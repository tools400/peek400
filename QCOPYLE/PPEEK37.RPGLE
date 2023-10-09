**FREE

/if defined(internal_prototype)
dcl-pr peek37 extpgm('PEEK37');
/else
dcl-pr peek37 extpgm(peek37_name);
/endif
  i_dsp80                            const like(dsp80_t);
  i_copyright                        const like(copyrght_t);
  o_feld                                   like(fieldnme_t);
  o_msgid                                  like(msgid_t);
  o_msgdta                                 like(msgdta_t);
end-pr;
