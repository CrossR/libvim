#include "libvim.h"
#include "minunit.h"

static int updateCount = 0;
static int lastLnum = 0;
static int lastLnume = 0;
static long lastXtra = 0;
static long lastVersionAtUpdateTime = 0;

void onBufferUpdate(bufferUpdate_T update)
{
  lastLnum = update.lnum;
  lastLnume = update.lnume;
  lastXtra = update.xtra;
  lastVersionAtUpdateTime = vimBufferGetLastChangedTick(curbuf);

  updateCount++;
}

void test_setup(void)
{
  vimInput("<esc>");
  vimInput("<esc>");

  vimExecute("e!");

  vimInput("g");
  vimInput("g");

  updateCount = 0;
  lastLnum = 0;
  lastLnume = 0;
  lastXtra = 0;
}

void test_teardown(void) {}

MU_TEST(test_format_line)
{
  buf_T *buf = vimBufferOpen("collateral/indent_test.py", 1, 0);
  int startingLen = vimBufferGetLineCount(buf);

  // Setup some options.
  vimExecute("filetype plugin indent on");
  vimExecute("set autoindent");
  vimExecute("set expandtab");
  vimExecute("set softtabstop=4");

  // Format the full file.
  vimInput("V");
  vimInput("G");
  vimInput("=");
  vimInput("k");

  int finishingLen = vimBufferGetLineCount(buf);
  printf("Line len changed from %i to %i\n", startingLen, finishingLen);

  printf("Buffer is: \n");
  for (unsigned int i = 1; i <= finishingLen; ++i)
    printf("%s\n", vimBufferGetLine(buf, i));

  // There should have been 2 updates, but no deletions.
  mu_check(updateCount == 2);
  mu_check((lastLnume - lastLnum) == 0);
  mu_check(lastXtra == 0);
  mu_check(lastVersionAtUpdateTime == vimBufferGetLastChangedTick(curbuf));

  // Check each line is now valid.
  buf_T *buf2 = vimBufferOpen("collateral/indent_test_fixed.py", 1, 0);
  mu_check(vimBufferGetLineCount(buf) == vimBufferGetLineCount(buf2));

  for (unsigned int i = 1; i <= finishingLen; ++i) {
    char *formattedLine = vimBufferGetLine(buf, i);
    char *correctLine = vimBufferGetLine(buf2, i);
    mu_check(strcmp(formattedLine, correctLine) == 0);
  }
}

MU_TEST_SUITE(test_suite)
{
  MU_SUITE_CONFIGURE(&test_setup, &test_teardown);

  MU_RUN_TEST(test_format_line);
}

int main(int argc, char **argv)
{
  vimInit(argc, argv);

  vimSetBufferUpdateCallback(&onBufferUpdate);

  win_setwidth(5);
  win_setheight(100);

  vimBufferOpen("collateral/indent_test.py", 1, 0);

  MU_RUN_SUITE(test_suite);
  MU_REPORT();
  MU_RETURN();
}
