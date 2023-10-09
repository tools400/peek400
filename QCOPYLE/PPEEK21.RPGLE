**FREE

/if defined(internal_prototype)
dcl-pr peek21 extpgm('PEEK21');
/else
dcl-pr peek21 extpgm(peek21_name);
/endif
  i_scnaid                           const like(scnaid_t);
  i_pgm                              const like(pgm_t);
  o_pgmcmd                                 like(pgmcmd_t);
  o_cmddta                                 like(pgmcmddt_t);
  o_msgid                                  like(msgid_t);
  o_msgdta                                 like(msgdta_t);
  i_exclkeys                         const like(pgmcmd_t) dim(25) options(*nopass);
end-pr;

