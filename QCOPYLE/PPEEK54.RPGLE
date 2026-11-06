**free

/if defined(internal_prototype)
dcl-pr peek54 extpgm('PEEK54');
/else
dcl-pr peek54 extpgm(peek54_name);
/endif
  gi_file       like(file_t) const;
  gi_lib        like(lib_t) const;
  gi_mbr        like(mbr_t) const;
  gi_rcdFmt     like(fmt_t) const;
  gi_rcdFmtID   like(fmtId_t) const;
  gi_envFile    like(file_t) const;
  gi_envLib     like(lib_t) const;
  gi_envMbr     like(mbr_t) const;
  gi_isAutoSave like(bool_t) const;
  gi_pinTabR    like(pinTabR_t) dim(12) const;
  gi_nbrPinR    like(int4_t) const;
  gi_pinTabC    like(fieldNme_t) dim(12) const;
  gi_nbrPinC    like(int4_t) const;
  gi_AccMode    like(accessMode_t) const;
  gi_SqlSel     like(sqlWhere_t) const;
  gi_SqlOrd     like(sqlOrder_t) const;
  gi_isKeyLower like(bool_t) const;
  go_msgID      like(msgId_t);
  go_msgDta     like(msgDta_t);
end-pr;
