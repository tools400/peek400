**free

/if defined(internal_prototype)
dcl-pr peek55 extpgm('PEEK55');
/else
dcl-pr peek55 extpgm(peek55_name);
/endif
  gi_file       like(file_t) const;
  gi_lib        like(lib_t) const;
  gi_mbr        like(mbr_t) const;
  gi_rcdFmt     like(fmt_t) const;
  gi_rcdFmtID   like(fmtId_t) const;
  gi_envFile    like(file_t) const;
  gi_envLib     like(lib_t) const;
  gi_envMbr     like(mbr_t) const;
  gi_option     like(option_t) const;
  go_pinTabR    like(pinTabR_t) dim(12);
  go_nbrPinR    like(int4_t);
  go_pinTabC    like(fieldNme_t) dim(12);
  go_nbrPinC    like(int4_t);
  go_File       like(file_t);
  go_Lib        like(lib_t);
  go_Mbr        like(mbr_t);
  go_rcdFmt     like(fmt_t);
  go_AccMode    like(accessMode_t);
  go_SqlSel     like(sqlWhere_t);
  go_SqlOrd     like(sqlOrder_t);
  go_isKeyLower like(bool_t);
  go_msgID      like(msgId_t);
  go_msgDta     like(msgDta_t);
end-pr;
