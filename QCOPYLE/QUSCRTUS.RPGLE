      /if not defined(QUSCRTUS)
      /define QUSCRTUS
      *
      *  List Objects (QUSCRTUS) API
     d QUSCRTUS...
     d                 pr                         extpgm('QUSCRTUS')
     d  i_qUsrSpc                    20A   const
     d  i_extAttr                    10a   const
     d  i_initSize                   10i 0 const
     d  i_initValue                   1a   const
     d  i_pubAuth                    10a   const
     d  i_text                       50a   const
     d  i_replace                    10a   const  options(*nopass)              | optGrp 1
     d  io_errCode                65535a          options(*nopass: *varsize)    |
     d  i_domain                     10a   const  options(*nopass)              | optGrp 2
     d  i_transSizeReq...                                                       | optGrp 3
     d                               10a   const  options(*nopass)              |
     d  i_optSpaceAlign...                                                      |
     d                                1a   const  options(*nopass)              |
      *
      /endif
