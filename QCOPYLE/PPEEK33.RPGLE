**FREE

/if defined(internal_prototype)
dcl-pr peek33 extpgm('PEEK33');
/else
dcl-pr peek33 extpgm(peek33_name);
/endif
  i_version                          const like(version_t);
  o_msgid                                  like(msgid_t);
  o_msgdta                                 like(msgdta_t);
end-pr;
