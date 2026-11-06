**free

/if defined(internal_prototype)
dcl-pr peek26 extpgm('PEEK26');
/else
dcl-pr peek26 extpgm(peek26_name);
/endif
  i_dsp80    like(dsp80_t) const;
  i_qsrcfile likeds(qobj_t) const;
  i_srcmbr   like(mbr_t) const;
  o_tofile   like(file_t);
  o_tolib    like(lib_t);
  o_tombr    like(mbr_t);
  o_mbropt   like(option_t);
  o_crtfile  like(option_t);
  o_msgid    like(msgid_t);
  o_msgdta   like(msgdta_t);
end-pr;
