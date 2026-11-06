**free
/if NOT defined(D_MI)
/define D_MI

dcl-s num_descr_t int(10) template;

//  Copy Numeric Value (CPYNV)
dcl-pr cpynv pointer extproc('cpynv');
  i_rcvdesc like(num_descr_t) value;
  i_prcvvar pointer value;
  i_srcdesc like(num_descr_t) value;
  i_psrcvar pointer value;
end-pr;

//  These values must be specified on the Scalar Type for CPYNV,
//  CVTEFN, and EDIT instructions.                              QSYSINC/MIH.MICPTCOM
dcl-c t_signed x'00';
dcl-c t_float x'01';
dcl-c t_zoned x'02';
dcl-c t_packed x'03';
dcl-c t_char x'04';
dcl-c t_onlyns x'06';
dcl-c t_onlyn x'07';
dcl-c t_either x'08';
dcl-c t_open x'09';
dcl-c t_unsigned x'0A';

/endif
