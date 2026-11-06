**free
/if not defined(QMHSNDPM)
/define QMHSNDPM

//  Send Program Message (QMHSNDPM) API
dcl-pr qmhsndpm extpgm('QMHSNDPM');
  i_msgid      char(7) const;
  i_qmsgf      char(20) const;
  i_msgdata    char(32767) options(*varsize) const;
  i_length     int(10) const;
  i_msgtype    char(10) const;
  i_callstke   char(256) const;
  i_callstkc   int(10) const;
  o_msgkey     char(4);
  io_errcode   char(32767) options(*varsize);
  i_lenstke    int(10) options(*nopass) const; // | optGrp 1
  i_callstkeq  char(20) options(*nopass) const; // |
  i_wait       int(10) options(*nopass) const; // |
  i_callstkedt char(10) options(*nopass) const; // | optGrp 2
  i_ccsid      int(10) options(*nopass) const; // |
end-pr;

/endif
