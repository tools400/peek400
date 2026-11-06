**free

/if defined(internal_prototype)
dcl-pr peek66 extpgm('PEEK66');
/else
dcl-pr peek66 extpgm(peek66_name);
/endif
  io_buffer   like(cmdBuffer_t);
  io_Length   like(int4_t);
  i_InFormat  likeds(fldl0100_t) const;
  i_OutFormat likeds(fldl0100_t) const;
  o_msgID     like(msgId_t);
  o_msgDta    like(msgDta_t);
end-pr;
