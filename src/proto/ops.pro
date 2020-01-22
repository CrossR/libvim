/* ops.c */
void *state_change_initialize(oparg_T *oap);
executionStatus_T state_change_execute(void *ctx, int c);
void state_change_cleanup(void *ctx);

int get_op_type(int char1, int char2);
int op_on_lines(int op);
int op_is_change(int op);
int get_op_char(int optype);
int get_extra_op_char(int optype);
void op_shift(oparg_T *oap, int curs_top, int amount);
void shift_line(int left, int round, int amount, int call_changed_bytes);
void op_reindent(oparg_T *oap, int (*how)(void));
int get_expr_register(void);
void set_expr_line(char_u *new_line);
char_u *get_expr_line(void);
char_u *get_expr_line_src(void);
int valid_yank_reg(int regname, int writing);
void get_yank_register_value(int regname, int *num_lines, char_u ***lines);
int get_yank_register(int regname, int writing);
int may_get_selection(int regname);
void *get_register(int name, int copy);
void put_register(int name, void *reg);
void free_register(void *reg);
int yank_register_mline(int regname);
int do_record(int c);
int do_execreg(int regname, int colon, int addcr, int silent);
int insert_reg(int regname, int literally_arg);
int get_spec_reg(int regname, char_u **argp, int *allocated, int errmsg);
int cmdline_paste_reg(int regname, int literally_arg, int remcr);
void adjust_clip_reg(int *rp);
void shift_delete_registers(void);
int op_delete(oparg_T *oap);
int op_replace(oparg_T *oap, int c);
void op_tilde(oparg_T *oap);
int swapchar(int op_type, pos_T *pos);
void op_insert(oparg_T *oap, long count1);
void init_yank(void);
void clear_registers(void);
int op_yank(oparg_T *oap, int deleting, int mess);
void do_put(int regname, int dir, long count, int flags);
void adjust_cursor_eol(void);
int preprocs_left(void);
int get_register_name(int num);
void ex_display(exarg_T *eap);
char_u *skip_comment(char_u *line, int process, int include_space,
                     int *is_comment);
int do_join(long count, int insert_space, int save_undo, int use_formatoptions,
            int setmark);
void op_format(oparg_T *oap, int keep_cursor);
void op_formatexpr(oparg_T *oap);
int fex_format(linenr_T lnum, long count, int c);
void format_lines(linenr_T line_count, int avoid_fex);
int paragraph_start(linenr_T lnum);
void op_addsub(oparg_T *oap, linenr_T Prenum1, int g_cmd);
void prepare_viminfo_registers(void);
void finish_viminfo_registers(void);
int read_viminfo_register(vir_T *virp, int force);
void handle_viminfo_register(garray_T *values, int force);
void write_viminfo_registers(FILE *fp);
void x11_export_final_selection(void);
void clip_free_selection(VimClipboard *cbd);
void clip_get_selection(VimClipboard *cbd);
void clip_yank_selection(int type, char_u *str, long len, VimClipboard *cbd);
int clip_convert_selection(char_u **str, long_u *len, VimClipboard *cbd);
void dnd_yank_drag_data(char_u *str, long len);
char_u get_reg_type(int regname, long *reglen);
char_u *get_reg_contents(int regname, int flags);
void write_reg_contents(int name, char_u *str, int maxlen, int must_append);
void write_reg_contents_lst(int name, char_u **strings, int maxlen,
                            int must_append, int yank_type, long block_len);
void write_reg_contents_ex(int name, char_u *str, int maxlen, int must_append,
                           int yank_type, long block_len);
void clear_oparg(oparg_T *oap);
void cursor_pos_info(dict_T *dict);
/* vim: set ft=c : */
