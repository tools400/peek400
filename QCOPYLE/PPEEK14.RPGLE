**FREE

/if defined(internal_prototype)
dcl-pr peek14 extpgm('PEEK14');
/else
dcl-pr peek14 extpgm(peek14_name);
/endif
  i_dsp80                            const like(dsp80_t);
  io_headertype                            like(headertype_t);
  i_copyright                        const like(copyrght_t);
  i_rcdnbr                           const like(rcdnbr_t);
  i_file                             const like(file_t);
  i_lib                              const like(lib_t);
  i_mbr                              const like(mbr_t);
  i_rcdfmt                           const like(fmt_t);
  i_function                         const like(function_t);
  i_commitlvl                        const like(bool_t);
  io_screennbr                             like(int4_t);
  o_msgid                                  like(msgid_t);
  o_msgdta                                 like(msgdta_t);
end-pr;
