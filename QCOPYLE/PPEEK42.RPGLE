**free

/if defined(internal_prototype)
dcl-pr peek42 extpgm('PEEK42');
/else
dcl-pr peek42 extpgm(peek42_name);
/endif
  i_file      like(file_t) const;
  i_library   like(lib_t) const;
  i_member    like(mbr_t) const;
  i_rcdFormat like(fmt_t) const;
  i_shortCmd  like(shortCmd_t) const;
  i_rcdNbr    like(rcdNbr_t) const;
  o_execCmd   like(cmdBuffer_t);
  o_msgID     like(msgId_t);
  o_msgDta    like(msgDta_t);
end-pr;
