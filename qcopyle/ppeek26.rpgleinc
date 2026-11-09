**free

/if defined(internal_prototype)
dcl-pr peek26 extpgm('PEEK26');
/else
dcl-pr peek26 extpgm(peek26_name);
/endif
  i_dsp80    like(dsp80_t) const;
  i_qSrcFile likeds(qObj_t) const;
  i_srcMbr   like(mbr_t) const;
  o_toFile   like(file_t);
  o_toLib    like(lib_t);
  o_toMbr    like(mbr_t);
  o_mbrOpt   like(option_t);
  o_crtFile  like(option_t);
  o_msgID    like(msgId_t);
  o_msgDta   like(msgDta_t);
end-pr;
