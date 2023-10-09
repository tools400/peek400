**FREE

/if defined(internal_prototype)
dcl-pr peek17 extpgm('PEEK17');
/else
dcl-pr peek17 extpgm(peek17_name);
/endif
  i_dsp80                            const like(bool_t);
  i_copyright                        const like(copyrght_t);
  i_qfile                            const like(qobj_t);
  i_member                           const like(mbr_t);
  o_field                                  like(fieldNme_t);
  o_operation                              like(operation_t);
  o_argument                               like(argument_t);
  o_sign                                   like(sign_t);
  o_srchnbrs                               like(srchNbrs_t);
  o_srchtype                               like(type_t);
  o_srchcase                               like(bool_t);
  o_msgid                                  like(msgid_t);
  o_msgdta                                 like(msgdta_t);
end-pr;
