**FREE

/if defined(internal_prototype)
dcl-pr peek12 extpgm('PEEK12');
/else
dcl-pr peek12 extpgm(peek12_name);
/endif
  i_dsp80                            const like(dsp80_t);
  i_copyright                        const like(copyrght_t);
  i_fmtname                          const like(fmt_t);
  i_fmtmode                          const like(mode_t);
  o_rcdl0200                               likeds(rcdl0200_t);
  o_fmtnbr                                 like(int2_t);
  o_msgid                                  like(msgid_t);
  o_msgdta                                 like(msgdta_t);
end-pr;
