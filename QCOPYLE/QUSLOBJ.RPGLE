      /if not defined(QUSLOBJ)
      /define QUSLOBJ
      *
      *  List Objects (QUSLOBJ) API
     d QUSLOBJ...
     d                 pr                         extpgm('QUSLOBJ')
     d  i_qUsrSpc                    20A   const
     d  i_format                      8a   const
     d  i_qObj                       20A   const
     d  i_objType                    10a   const
     d  io_errCode                65535a          options(*nopass: *varsize)    | optGrp 1
     d  i_authCtrl                65535a   const  options(*nopass: *varsize)    | optGrp 2
     d  i_slcCtrl                 65535a   const  options(*nopass: *varsize)    |
     d  i_auxStgPool              65535a   const  options(*nopass: *varsize)    | optGrp 3
      *
      *  Input Parameter Section
     d QUSLOBJ_inpParm_t...
     d                 ds                  qualified template
     d  qUsrSpc                      20a
     d  format                        8a
     d  objSlc                       10a
     d  libSlc                       10a
     d  objTypeSlc                   10a
     d  reserved_1                    2a
     d  errBytPrv                    10i 0
     d  lenAuthCtrl                  10i 0
     d  callLvl                      10i 0
     d  ofsObjAuth                   10i 0
     d  numObjAuth                   10i 0
     d  ofsLibAuth                   10i 0
     d  numLibAuth                   10i 0
     d  lenSlcCtrl                   10i 0
     d  slcOmtSts                    10i 0
     d  ofsSts                       10i 0
     d  numSts                       10i 0
     d  lenAuxStgPool                10i 0
     d  auxStgPoolName...
     d                               10a
     d  auxStgPoolType...
     d                               10a
      *  Object authorities   ARRAY(*) of CHAR(10)
      *  Library authorities  ARRAY(*) of CHAR(10)
      *  Statuses             ARRAY(*) of CHAR(1)
      *
      *  Authority Control Format
     d QUSLOBJ_authCtrl_t...
     d                 ds                  qualified template
     d  length                       10a
     d  callLvl                      10i 0
     d  ofsObjAuth                   10i 0
     d  numObjAuth                   10i 0
     d  ofsLibAuth                   10i 0
     d  numLibAuth                   10i 0
     d  reserved_1                   10i 0
      *  Object authorities   ARRAY(*) of CHAR(10)
      *  Library authorities  ARRAY(*) of CHAR(10)
      *
      *  Selection Control Format
     d QUSLOBJ_slcCtrl_t...
     d                 ds                  qualified template
     d  length                       10i 0
     d  slcOmtSts                    10i 0
     d  ofsSts                       10i 0
     d  numSts                       10i 0
     d  reserved_1                   10i 0
      *  Statuses             ARRAY(*) of CHAR(1)
      *
      /endif
