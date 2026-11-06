**free

/if defined(internal_prototype)
dcl-pr peek49 extpgm('PEEK49');
/else
dcl-pr peek49 extpgm(peek49_name);
/endif
  i_dsp80     like(dsp80_t) const;
  i_copyright like(copyrght_t) const;
  i_release   like(release_t) const;
  i_version   like(version_t) const;
  o_msgid     like(msgid_t);
  o_msgdta    like(msgdta_t);
end-pr;

