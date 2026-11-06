**free
/if defined(internal_prototype)
dcl-pr exit01 extpgm('EXIT01');
/else
dcl-pr exit01 extpgm(exit01_name);
/endif
  gi_qFile    likeds(qObj_t) const;
  gi_mbr      like(mbr_t) const;
  gi_access   like(accMode_t) const;
  gio_chgL    like(bool_t);
  gio_chgF    like(bool_t);
  gio_chgM    like(bool_t);
  gio_updMd   like(bool_t);
  gio_updKy   like(bool_t);
  gio_chgSqlW like(bool_t);
  gio_chgSqlO like(bool_t);
  gio_accAt   like(bool_t);
  go_msgID    like(msgId_t);
  go_msgDta   like(msgDta_t);
end-pr;

