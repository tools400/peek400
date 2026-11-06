**free

/if defined(internal_prototype)
dcl-pr peek42 extpgm('PEEK42');
/else
dcl-pr peek42 extpgm(peek42_name);
/endif
  i_file      like(file_t) const;
  i_library   like(lib_t) const;
  i_member    like(mbr_t) const;
  i_rcdformat like(fmt_t) const;
  i_shortcmd  like(shortcmd_t) const;
  i_rcdnbr    like(rcdnbr_t) const;
  o_execcmd   like(cmdbuffer_t);
  o_msgid     like(msgid_t);
  o_msgdta    like(msgdta_t);
end-pr;
