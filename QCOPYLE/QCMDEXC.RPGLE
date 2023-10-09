**FREE
/if not defined(QCMDEXC)
/define QCMDEXC
//
//  ... Execute Command (QCMDEXC) API
dcl-pr qcmdexc
       extpgm('QCMDEXC');
  i_cmd           char(32702) const  options(*varsize);
  i_length        packed(15:5) const;
  i_igcprcctrl    char(3) const  options(*nopass);
end-pr;
//
dcl-c qcmdexc_igc 'IGC';
//
/endif
