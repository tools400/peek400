**free
/if not defined(QTNRCMTI)
/define QTNRCMTI

//  ... Retrieve Commitment Information (QTNRCMTI) API
dcl-pr qtnrcmti extpgm('QTNRCMTI');
  o_rcvVar    char(65535) options(*varsize);
  i_rcvVarLen int(10) const;
  i_format    char(8) const;
  io_ErrCode  char(65535) options(*varsize);
end-pr;

//  This format returns commitment information.
dcl-ds cmti0100_t qualified template;
  bytRet             int(10);
  bytAvl             int(10);
  status             char(1);
  lockLevel          char(10);
  scope              char(1);
  statusActGrp       char(1);
  waitOutcome        char(1);
  problemAction      char(1);
  voteReadOnly       char(1);
  actionEndJob       char(1);
  dftJrnName         char(10);
  dftJrnLib          char(10);
  LUOW_id            char(39);
  lastAgentPermitted char(1);
  okToLeaveOut       char(1);
  acceptVoteReliable char(1);
end-ds;

/endif
