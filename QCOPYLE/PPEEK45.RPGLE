**FREE

/if defined(internal_prototype)
dcl-pr peek45 extpgm('PEEK45');
/else
dcl-pr peek45 extpgm(peek45_name);
/endif
  i_dsp80                            const like(dsp80_t);
  i_headtype                         const like(headtyp_t);
  i_copyright                        const like(copyrght_t);
  i_fldname                          const like(fieldnme_t);
  io_fldinhalt                             likeds(fldinhalt_t);
  io_length                                like(int4_t);
  i_protect                          const like(bool_t);
  i_isucs2                           const like(int4_t);
  o_msgid                                  like(msgid_t);
  o_msgdta                                 like(msgdta_t);
  //  bTrue: Der Wert steht schon in der Job-CCSID (Änderungsprogramm)
  i_isjobccsid                       const like(bool_t) options(*nopass);
end-pr;
