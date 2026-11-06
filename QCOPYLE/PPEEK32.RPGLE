**free

/if defined(internal_prototype)
dcl-pr peek32 extpgm('PEEK32');
/else
dcl-pr peek32 extpgm(peek32_name);
/endif
  io_buffer likeds(rcdbuffer_t);
  i_bufflen like(int4_t) const;
  i_ccsid   like(int4_t) const;
  o_msgid   like(msgid_t);
  o_msgdta  like(msgdta_t);
end-pr;
