**free

/if defined(internal_prototype)
dcl-pr peek32 extpgm('PEEK32');
/else
dcl-pr peek32 extpgm(peek32_name);
/endif
  io_buffer likeds(rcdBuffer_t);
  i_buffLen like(int4_t) const;
  i_ccsid   like(int4_t) const;
  o_msgID   like(msgId_t);
  o_msgDta  like(msgDta_t);
end-pr;
