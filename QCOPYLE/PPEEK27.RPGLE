000100231110**FREE
000200231110
000300231110/if defined(internal_prototype)
000400231110dcl-pr peek27 extpgm('PEEK27');
000500231110/else
000600231110dcl-pr peek27 extpgm(peek27_name);
000700231110/endif
000800231110  i_pgm                              const like(pgm_t);
000900231110  o_choices                                like(choice_t) dim(32);
001000231110  o_numchoices                             like(int4_t);
001100231112  i_exclkeys                         const like(pgmcmd_t) dim(25) options(*nopass);
001200231110end-pr;
