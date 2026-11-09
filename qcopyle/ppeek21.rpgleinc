**free

/if defined(internal_prototype)
dcl-pr peek21 extpgm('PEEK21');
/else
dcl-pr peek21 extpgm(peek21_name);
/endif
  i_scnAID   like(scnAID_t) const;
  i_pgm      like(pgm_t) const;
  o_pgmCmd   like(pgmCmd_t);
  o_cmdDta   like(pgmCmdDt_t);
  o_msgID    like(msgId_t);
  o_msgDta   like(msgDta_t);
  i_exclKeys like(pgmCmd_t) dim(25) options(*nopass) const;
end-pr;

