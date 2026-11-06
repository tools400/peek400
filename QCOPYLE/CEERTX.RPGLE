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
  condition_id char(4) pos(1);
  msgSev       int(5) pos(1);
  msg_no       uns(5) pos(3);
  flags        char(1) pos(5);
  facility_id  char(3) pos(6);
  i_s_info     char(4) pos(9);
end-ds;

/endif
