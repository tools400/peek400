**free

/if defined(internal_prototype)
dcl-pr peek36 extpgm('PEEK36');
/else
dcl-pr peek36 extpgm(peek36_name);
/endif
  i_buffer    like(smallBuffer_t) const;
  i_type      like(dataType_t) const;
  i_dattimfmt like(fldl0100_t.f1dtfm) const;
  i_separator like(fldl0100_t.f1dtsp) const;
  o_msgid     like(msgid_t);
  o_msgdta    like(msgdta_t);
end-pr;
