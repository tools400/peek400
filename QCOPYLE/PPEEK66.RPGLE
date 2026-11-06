**free

/if defined(internal_prototype)
dcl-pr peek66 extpgm('PEEK66');
/else
dcl-pr peek66 extpgm(peek66_name);
/endif
  io_buffer   like(cmdbuffer_t);
  io_length   like(int4_t);
  i_informat  likeds(fldl0100_t) const;
  i_outformat likeds(fldl0100_t) const;
  o_msgid     like(msgid_t);
  o_msgdta    like(msgdta_t);
end-pr;
