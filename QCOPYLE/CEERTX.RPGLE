**free
/if not defined(CEERTX)
/define CEERTX

//  Register Call Stack Entry Termination User Exit Procedure (CEERTX)
dcl-pr ceertx extproc('CEERTX');
  i_procPtr  pointer(*proc) const;
  i_rtxToken pointer options(*omit) const;
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

/endif
