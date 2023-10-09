**FREE
/if not defined(QUSPTRUS)
/define QUSPTRUS
//
//  List Objects (QUSPTRUS) API
dcl-pr qusptrus
       extpgm('QUSPTRUS');
  i_qusrspc       char(20) const;
  o_pusrspc       pointer;
  io_errcode      char(65535) options(*nopass: *varsize);                // |
end-pr;
//
/endif
