**FREE
/if not defined(QWCRNETA)
/define QWCRNETA
//
//  Retrieve Network Attributes (QWCRNETA) API
dcl-pr qwcrneta
       extpgm('QWCRNETA');
  o_rcvvar        char(32767) options(*varsize);
  i_lenrcv        int(10) const;
  i_numattr       int(10) const;
  i_attrnames     char(10) const  dim(50) options(*varsize);
  io_errorcode    char(32767) options(*varsize);
end-pr;
//
dcl-ds qwcrneta_returned
       qualified template;
  nume            int(10);
  offsattr        int(10);
end-ds;
//  Network attribute information table   CHAR(*)
//
dcl-ds qwcrneta_attr
       qualified template;
  name            char(10);
  type            char(1);
  status          char(1);
  length          int(10);
  data_char       char(256);
  data_bin        int(10) overlay(data_char);
end-ds;
//
dcl-c qwcrneta_status_ok
      ' ';
dcl-c qwcrneta_status_locked
      'L';
//
dcl-c qwcrneta_data_none
      ' ';
dcl-c qwcrneta_data_char
      'C';
dcl-c qwcrneta_data_bin
      'B';
//
/endif
