**free
/if not defined(QTNRCMTI)
/define QTNRCMTI

//  ... Retrieve Commitment Information (QTNRCMTI) API
dcl-pr qtnrcmti extpgm('QTNRCMTI');
  o_rcvvar    char(65535) options(*varsize);
  i_rcvvarlen int(10) const;
  i_format    char(8) const;
  io_errcode  char(65535) options(*varsize);
end-pr;

//  This format returns commitment information.
dcl-ds cmti0100_t qualified template;
  bytret             int(10);
  bytavl             int(10);
  status             char(1);
  locklevel          char(10);
  scope              char(1);
  statusactgrp       char(1);
  waitoutcome        char(1);
  problemaction      char(1);
  votereadonly       char(1);
  actionendjob       char(1);
  dftjrnname         char(10);
  dftjrnlib          char(10);
  luow_id            char(39);
  lastagentpermitted char(1);
  oktoleaveout       char(1);
  acceptvotereliable char(1);
end-ds;

/endif
