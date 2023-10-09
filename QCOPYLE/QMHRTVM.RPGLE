**FREE
/if not defined(QMHRTVM)
/define QMHRTVM
//
//  Retrieve Message (QMHRTVM) API
dcl-pr qmhrtvm
       extpgm('QMHRTVM');
  o_msginf        char(65535) options(*varsize);
  i_msginflen     int(10) const;
  i_format        char(8) const;
  i_msgid         char(7) const;
  i_qmsgf         char(20) const;
  i_rpldata       char(65535) const  options(*varsize );
  i_rpldatalen    int(10) const;
  i_rplvars       char(10) const;
  i_rtnctrlchrs   char(10) const;
  io_errcode      char(65535) options(*varsize );
  i_rtvopt        char(10) const  options(*nopass  );                    // | OptGrp 1
  i_toccsid       int(10) const  options(*nopass  );                     // |
  i_ccsidrpldta   int(10) const  options(*nopass  );                     // |
end-pr;
//
/endif
