**free

/if defined(internal_prototype)
dcl-pr peek55 extpgm('PEEK55');
/else
dcl-pr peek55 extpgm(peek55_name);
/endif
  gi_file       like(file_t) const;
  gi_lib        like(lib_t) const;
  gi_mbr        like(mbr_t) const;
  gi_rcdfmt     like(fmt_t) const;
  gi_rcdfmtid   like(fmtid_t) const;
  gi_envfile    like(file_t) const;
  gi_envlib     like(lib_t) const;
  gi_envmbr     like(mbr_t) const;
  gi_option     like(option_t) const;
  go_pintabr    like(pintabr_t) dim(12);
  go_nbrpinr    like(int4_t);
  go_pintabc    like(fieldnme_t) dim(12);
  go_nbrpinc    like(int4_t);
  go_file       like(file_t);
  go_lib        like(lib_t);
  go_mbr        like(mbr_t);
  go_rcdfmt     like(fmt_t);
  go_accmode    like(accessmode_t);
  go_sqlsel     like(sqlwhere_t);
  go_sqlord     like(sqlorder_t);
  go_iskeylower like(bool_t);
  go_msgid      like(msgid_t);
  go_msgdta     like(msgdta_t);
end-pr;
