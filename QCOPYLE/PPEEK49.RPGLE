**FREE

/if defined(internal_prototype)
dcl-pr peek49 extpgm('PEEK49');
/else
dcl-pr peek49 extpgm(peek49_name);
/endif
  i_dsp80                            const like(dsp80_t);
  i_copyright                        const like(copyrght_t);
  i_release                          const like(release_t);
  i_version                          const like(version_t);
  o_msgid                                  like(msgid_t);
  o_msgdta                                 like(msgdta_t);
end-pr;

