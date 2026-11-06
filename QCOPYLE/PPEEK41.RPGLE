**free

/if defined(internal_prototype)
dcl-pr peek41 extpgm('PEEK41');
/else
dcl-pr peek41 extpgm(peek41_name);
/endif
  i_qfile    likeds(qobj_t) const;
  i_rcdfmt   like(fmt_t) const;
  i_function like(function_t) const;
  o_nbrofent like(int4_t);
  o_data     char(512);
end-pr;

