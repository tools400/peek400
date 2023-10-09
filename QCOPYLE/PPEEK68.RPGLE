**FREE

/if defined(internal_prototype)
dcl-pr peek68 extpgm('PEEK68');
/else
dcl-pr peek68 extpgm(peek68_name);
/endif
  i_dsp80                            const like(dsp80_t);
  i_pgm                              const like(pgm_t);
  i_copyright                        const like(copyrght_t);
  o_sflopt                                 like(sfpau_t);
  o_msgid                                  like(msgid_t);
  o_msgdta                                 like(msgdta_t);
end-pr;
