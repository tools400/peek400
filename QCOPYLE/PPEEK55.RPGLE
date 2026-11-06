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
  go_file       like(file_t);
  go_lib        like(lib_t);
  go_mbr        like(mbr_t);
  go_rcdFmt     like(fmt_t);
  go_accMode    like(accessMode_t);
  go_sqlSel     like(sqlWhere_t);
  go_sqlOrd     like(sqlOrder_t);
  go_isKeyLower like(bool_t);
  go_msgID      like(msgId_t);
  go_msgDta     like(msgDta_t);
end-pr;
