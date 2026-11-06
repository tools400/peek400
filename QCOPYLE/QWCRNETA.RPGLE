**free
/if not defined(QWCRNETA)
/define QWCRNETA

//  Retrieve Network Attributes (QWCRNETA) API
dcl-pr qwcrneta extpgm('QWCRNETA');
  o_rcvVar     char(32767) options(*varsize);
  i_lenRcv     int(10) const;
  i_numAttr    int(10) const;
  i_attrNames  char(10) dim(50) options(*varsize) const;
  io_errorCode char(32767) options(*varsize);
end-pr;

dcl-ds QWCRNETA_returned qualified template;
  numE     int(10);
  offsAttr int(10);
end-ds;
//  Network attribute information table   CHAR(*)

dcl-ds QWCRNETA_attr qualified template;
  name      char(10);
  type      char(1);
  status    char(1);
  length    int(10);
  data_char char(256);
  data_bin  int(10) overlay(data_char);
end-ds;

dcl-c qwcrneta_status_ok ' ';
dcl-c qwcrneta_status_locked 'L';

dcl-c qwcrneta_data_none ' ';
dcl-c qwcrneta_data_char 'C';
dcl-c qwcrneta_data_bin 'B';

/endif
