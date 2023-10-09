**FREE
/if not defined(CEECNDHDLR)
/define CEECNDHDLR
//
//  CEEHDLR-Register user-written condition handler
dcl-pr ceehdlr;
  i_phdlproc      pointer(*proc) const;
  i_ptoken        pointer const;
  o_fc            likeds(cee_fc_t)
options(*omit);
end-pr;
//
//  CEEHDLU-Unregister user-written condition handler
dcl-pr ceehdlu;
  i_phdlproc      pointer(*proc) const;
  o_fc            likeds(cee_fc_t)
options(*omit);
end-pr;
//
//  Condition token, used as feedback code
dcl-ds cee_fc_t qualified template;
  condition_id
  char(4) pos(1);
  msgsev          int(5) pos(1);
  msg_no          uns(5) pos(3);
  flags           char(1) pos(5);
  facility_id
  char(3) pos(6);
  i_s_info        char(4) pos(9);
end-ds;
//
//  Prototype for the condition handler.
dcl-pr errorhandler extproc('errorHandler');
  i_condition     value likeds(cee_fc_t);
i_tokenin       int(10) value;
i_resultcode    int(10);
o_newcondition  likeds(cee_fc_t);
end-pr;
//
// Action codes are:
dcl-c cee_resume 10;
dcl-c cee_percolate 20;
//
/endif
