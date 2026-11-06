**free
/if not defined(CEECNDHDLR)
/define CEECNDHDLR

//  CEEHDLR-Register user-written condition handler
dcl-pr ceehdlr;
  i_pHdlProc pointer(*proc) const;
  i_pToken   pointer const;
  o_fc       likeds(cee_fc_t) options(*omit);
end-pr;

//  CEEHDLU-Unregister user-written condition handler
dcl-pr ceehdlu;
  i_pHdlProc pointer(*proc) const;
  o_fc       likeds(cee_fc_t) options(*omit);
end-pr;

//  Condition token, used as feedback code
dcl-ds cee_fc_t qualified template;
  Condition_ID char(4) pos(1);
  msgSev       int(5) pos(1);
  Msg_No       uns(5) pos(3);
  Flags        char(1) pos(5);
  Facility_ID  char(3) pos(6);
  I_S_Info     char(4) pos(9);
end-ds;

//  Prototype for the condition handler.
dcl-pr errorHandler extproc('errorHandler');
  i_condition    likeds(cee_fc_t) value;
  i_tokenIn      int(10) value;
  i_resultCode   int(10);
  o_newCondition likeds(cee_fc_t);
end-pr;

// Action codes are:
dcl-c cee_resume 10;
dcl-c cee_percolate 20;

/endif
