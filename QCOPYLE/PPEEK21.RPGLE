**free

/if defined(internal_prototype)
dcl-pr peek21 extpgm('PEEK21');
/else
dcl-pr peek21 extpgm(peek21_name);
/endif
  i_scnaid   like(scnaid_t) const;
  i_pgm      like(pgm_t) const;
  o_pgmcmd   like(pgmcmd_t);
  o_cmddta   like(pgmcmddt_t);
  o_msgid    like(msgid_t);
  o_msgdta   like(msgdta_t);
  i_exclkeys like(pgmcmd_t) dim(25) options(*nopass) const;
end-pr;

