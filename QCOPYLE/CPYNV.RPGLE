**FREE
//
//  Templates  (micptcom.h)
dcl-s num_descr_t     int(10) template;
//
//  Constants  (micptcom.h)
dcl-c t_signed const(x'00');
dcl-c t_float const(x'01');
dcl-c t_zoned const(x'02');
dcl-c t_packed const(x'03');
dcl-c t_char const(x'04');
dcl-c t_onlyns const(x'06');
dcl-c t_onlyn const(x'07');
dcl-c t_either const(x'08');
dcl-c t_open const(x'09');
dcl-c t_unsigned const(x'0A');
//
//  Copy Numeric Value
dcl-pr cpynv
       pointer extproc('cpynv');
  o_rcvr_descr    value  like(num_descr_t);
  o_receiver      pointer value;
  i_src_descr     value  like(num_descr_t);
  i_source        pointer value;
end-pr;
//
