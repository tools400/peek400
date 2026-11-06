**free

/if defined(internal_prototype)
dcl-pr peek45 extpgm('PEEK45');
/else
dcl-pr peek45 extpgm(peek45_name);
/endif
  i_dsp80      like(dsp80_t) const;
  i_headtype   like(headtyp_t) const;
  i_copyright  like(copyrght_t) const;
  i_fldname    like(fieldnme_t) const;
  io_fldinhalt likeds(fldinhalt_t);
  io_length    like(int4_t);
  i_protect    like(bool_t) const;
  i_isucs2     like(int4_t) const;
  o_msgid      like(msgid_t);
  o_msgdta     like(msgdta_t);
  //  bTrue: Der Wert steht schon in der Job-CCSID (Änderungsprogramm)
  i_isjobccsid like(bool_t) options(*nopass) const;
end-pr;
