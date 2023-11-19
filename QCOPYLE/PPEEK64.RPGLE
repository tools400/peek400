**FREE

/if defined(internal_prototype)
dcl-pr peek64 extpgm('PEEK64');
/else
dcl-pr peek64 extpgm(peek64_name);
/endif
  i_dsp80                            const like(dsp80_t);
  i_headType                         const like(headtyp_t);
  i_copyright                        const like(copyrght_t);
  i_fldName                          const like(fieldnme_t);
  io_fldInhalt                             likeds(fldinhalt_t);
  io_length                                like(int4_t);
  i_protect                          const like(bool_t);
  i_isUcs2                           const like(int4_t);
  o_msgId                                  like(msgid_t);
  o_msgDta                                 like(msgdta_t);
end-pr;
