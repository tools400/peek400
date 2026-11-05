**FREE

/if defined(internal_prototype)
dcl-pr peek27 extpgm('PEEK27');
/else
dcl-pr peek27 extpgm(peek27_name);
/endif
  i_pgm                              const like(pgm_t);
  o_choices                                like(choice_t) dim(32);
  o_numchoices                             like(int4_t);
  i_exclkeys                         const like(pgmcmd_t) dim(25)
                                     options(*nopass: *omit);
  i_width                            const like(int4_t) options(*nopass);
end-pr;
