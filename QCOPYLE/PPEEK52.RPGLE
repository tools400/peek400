**FREE

/if defined(internal_prototype)
dcl-pr peek52 extpgm('PEEK52');
/else
dcl-pr peek52 extpgm(peek52_name);
/endif
  i_dsp80                            const like(dsp80_t);
  i_copyright                        const like(copyrght_t);
  o_alwlc                                  like(bool_t);
  o_case                                   like(bool_t);
  o_cdlock                                 like(bool_t);
  o_nulldft                                like(bool_t);
  o_keepcrs                                like(bool_t);
  o_msgid                                  like(msgid_t);
  o_msgdta                                 like(msgdta_t);
  i_isunload                         const like(msgid_t);
end-pr;
