**free
/if defined(internal_prototype)
dcl-pr exit01 extpgm('EXIT01');
/else
dcl-pr exit01 extpgm(exit01_name);
/endif
  gi_qfile    likeds(qobj_t) const;
  gi_mbr      like(mbr_t) const;
  gi_access   like(accmode_t) const;
  gio_chgl    like(bool_t);
  gio_chgf    like(bool_t);
  gio_chgm    like(bool_t);
  gio_updmd   like(bool_t);
  gio_updky   like(bool_t);
  gio_chgsqlw like(bool_t);
  gio_chgsqlo like(bool_t);
  gio_accat   like(bool_t);
  go_msgid    like(msgid_t);
  go_msgdta   like(msgdta_t);
end-pr;

