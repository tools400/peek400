**free

/if defined(internal_prototype)
dcl-pr peek54 extpgm('PEEK54');
/else
dcl-pr peek54 extpgm(peek54_name);
/endif
  gi_file       like(file_t) const;
  gi_lib        like(lib_t) const;
  gi_mbr        like(mbr_t) const;
  gi_rcdfmt     like(fmt_t) const;
  gi_rcdfmtid   like(fmtid_t) const;
  gi_envfile    like(file_t) const;
  gi_envlib     like(lib_t) const;
  gi_envmbr     like(mbr_t) const;
  gi_isautosave like(bool_t) const;
  gi_pintabr    like(pintabr_t) dim(12) const;
  gi_nbrpinr    like(int4_t) const;
  gi_pintabc    like(fieldnme_t) dim(12) const;
  gi_nbrpinc    like(int4_t) const;
  gi_accmode    like(accessmode_t) const;
  gi_sqlsel     like(sqlwhere_t) const;
  gi_sqlord     like(sqlorder_t) const;
  gi_iskeylower like(bool_t) const;
  go_msgid      like(msgid_t);
  go_msgdta     like(msgdta_t);
end-pr;
