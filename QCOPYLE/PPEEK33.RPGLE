**free

/if defined(internal_prototype)
dcl-pr peek33 extpgm('PEEK33');
/else
dcl-pr peek33 extpgm(peek33_name);
/endif
  i_version like(version_t) const;
  o_msgid   like(msgid_t);
  o_msgdta  like(msgdta_t);
end-pr;
