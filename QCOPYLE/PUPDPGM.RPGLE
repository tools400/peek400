**FREE

/if defined(internal_prototype)
dcl-pr updpgm extpgm('UPDPGM');
/else
dcl-pr updpgm extpgm(updpgm_name);
/endif
  i_dsp80                            const like(dsp80_t);
  io_headertype                            like(headertype_t);
  i_copyright                        const like(copyrght_t);
  i_rcdnbr                           const like(rcdnbr_t);
  i_file                             const like(file_t);
  i_library                          const like(lib_t);
  i_member                           const like(mbr_t);
  i_function                         const like(function_t);
  i_commitlvl                        const like(commitlvl_t);
  i_isupdkey                         const like(bool_t);
  io_screennbr                             like(int4_t);
  io_islower                               like(bool_t);
  io_csrrow                                like(int4_t);
  io_csrcol                                like(int4_t);
  o_msgid                                  like(msgid_t);
  o_msgdta                                 like(msgdta_t);
end-pr;

