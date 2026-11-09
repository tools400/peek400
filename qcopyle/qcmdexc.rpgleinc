**free
      //%METADATA                                                      *
      // %TEXT Execute Command (QCMDEXC) API                           *
      //%EMETADATA                                                     *
/if not defined(QCMDEXC)
/define QCMDEXC

//  ... Execute Command (QCMDEXC) API
dcl-pr qcmdexc extpgm('QCMDEXC');
  i_cmd        char(32702) options(*varsize) const;
  i_length     packed(15: 5) const;
  i_igCprcCtrl char(3) options(*nopass) const;
end-pr;

dcl-c qcmdexc_igc 'IGC';

/endif
