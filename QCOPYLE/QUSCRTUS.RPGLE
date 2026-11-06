**free
/if not defined(QUSCRTUS)
/define QUSCRTUS

//  List Objects (QUSCRTUS) API
dcl-pr quscrtus extpgm('QUSCRTUS');
  i_qusrspc       char(20) const;
  i_extattr       char(10) const;
  i_initsize      int(10) const;
  i_initvalue     char(1) const;
  i_pubauth       char(10) const;
  i_text          char(50) const;
  i_replace       char(10) options(*nopass) const; // | optGrp 1
  io_errcode      char(65535) options(*nopass: *varsize); // |
  i_domain        char(10) options(*nopass) const; // | optGrp 2
  // | optGrp 3
  i_transsizereq  char(10) options(*nopass) const; // |
  // |
  i_optspacealign char(1) options(*nopass) const; // |
end-pr;

/endif
