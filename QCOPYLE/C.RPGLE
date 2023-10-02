      *
      *============================================================*
      *      Modul: Peek063                                        *
      *============================================================*
      /INCLUDE QCOPYLE,D_VARDEF
      /INCLUDE QCOPYLE,D_INFDS
      *
     D hFile_t         DS                  qualified               based(pDummy)
     D  fd                             *
     D  isOpen                             like(bool_t)
     D  name                               like(file_t)
     D  lib                                like(lib_t)
     D  mbr                                like(mbr_t)
     D  rcdFormat                    10A
     D  errno                        10I 0
     D  lastOper                     10A
     D  rrn                          10I 0
     D  arrseq                        1A
     D  msgID                              like(msgID_t)
     D  msgDta                             like(msgDta_t)
      *
      *-------------------------------------------------------------------*
     D CIO_open...
     D                 PR                         like(bool_t)
     D                                            extproc('PEEK63+
     D                                            _CIO_open+
     D                                            ')
     D  o_hFile                                   likeds(hFile_t)
     D  i_file                             const  like(file_t)
     D  i_lib                              const  like(lib_t)
     D  i_mbr                              const  like(mbr_t)
     D  i_rcdFormat                  10A   const
     D  i_mode                         *   const  options(*string)
      *
      *-------------------------------------------------------------------*
     D CIO_isOpen...
     D                 PR                         like(bool_t)
     D                                            extproc('PEEK63+
     D                                            _CIO_isOpen+
     D                                            ')
     D  i_hFile                            const  likeds(hFile_t)
      *
      *-------------------------------------------------------------------*
     D CIO_getFile...
     D                 PR                         like(file_t)
     D                                            extproc('PEEK63+
     D                                            _CIO_getFile+
     D                                            ')
     D  i_hFile                            const  likeds(hFile_t)
      *
      *-------------------------------------------------------------------*
     D CIO_getLibrary...
     D                 PR                         like(lib_t)
     D                                            extproc('PEEK63+
     D                                            _CIO_getLibrary+
     D                                            ')
     D  i_hFile                            const  likeds(hFile_t)
      *
      *-------------------------------------------------------------------*
     D CIO_getMember...
     D                 PR                         like(mbr_t)
     D                                            extproc('PEEK63+
     D                                            _CIO_getMember+
     D                                            ')
     D  i_hFile                            const  likeds(hFile_t)
      *
      *-------------------------------------------------------------------*
     D CIO_getRecordFormat...
     D                 PR            10A
     D                                            extproc('PEEK63+
     D                                            _CIO_getRecordFormat+
     D                                            ')
     D  i_hFile                            const  likeds(hFile_t)
      *
      *-------------------------------------------------------------------*
     D CIO_getRecordLength...
     D                 PR            10I 0
     D                                            extproc('PEEK63+
     D                                            _CIO_getRecordLength+
     D                                            ')
     D  i_hFile                            const  likeds(hFile_t)
      *
      *-------------------------------------------------------------------*
     D CIO_getRRN...
     D                 PR            10I 0
     D                                            extproc('PEEK63+
     D                                            _CIO_getRRN+
     D                                            ')
     D  i_hFile                            const  likeds(hFile_t)
      *
      *-------------------------------------------------------------------*
     D CIO_getInfDS...
     D                 PR                         likeds(infds_t)
     D                                            extproc('PEEK63+
     D                                            _CIO_getInfDS+
     D                                            ')
     D  i_hFile                            const  likeds(hFile_t)
      *
      *-------------------------------------------------------------------*
     D CIO_isError...
     D                 PR                         like(bool_t)
     D                                            extproc('PEEK63+
     D                                            _CIO_isError+
     D                                            ')
     D  i_hFile                            const  likeds(hFile_t)
      *
      *-------------------------------------------------------------------*
     D CIO_setErrorMsg...
     D                 PR
     D                                            extproc('PEEK63+
     D                                            _CIO_setErrorMsg+
     D                                            ')
     D  io_hFile                                  likeds(hFile_t)
     D  i_msgID                            const  like(msgID_t)
     D  i_msgDta                           const  like(msgDta_t)
      *
      *-------------------------------------------------------------------*
     D CIO_getError...
     D                 PR            10I 0
     D                                            extproc('PEEK63+
     D                                            _CIO_getError+
     D                                            ')
     D  i_hFile                            const  likeds(hFile_t)
      *
      *-------------------------------------------------------------------*
     D CIO_getErrorText...
     D                 PR           512A          varying
     D                                            extproc('PEEK63+
     D                                            _CIO_getErrorText+
     D                                            ')
     D  i_hFile                            const  likeds(hFile_t)
      *
      *-------------------------------------------------------------------*
     D CIO_chainWithRRN...
     D                 PR                         like(bool_t)
     D                                            extproc('PEEK63+
     D                                            _CIO_chainWithRRN+
     D                                            ')
     D  io_hFile                                  likeds(hFile_t)
     D  i_rrn                              const  like(rcdNbr_t)
     D  i_doLock                           const  like(bool_t)
     D  io_rcdBuffer                              like(rcdBuf_t)
     D  io_nullMap                                like(nullMap_t)
     D                                            dim(NULL_MAP_SIZE)
      *
      *-------------------------------------------------------------------*
     D CIO_chainWithKey...
     D                 PR                         like(bool_t)
     D                                            extproc('PEEK63+
     D                                            _CIO_chainWithKey+
     D                                            ')
     D  io_hFile                                  likeds(hFile_t)
     D  i_key                              const  like(keyBuf_t)
     D  i_doLock                           const  like(bool_t)
     D  io_rcdBuffer                              like(rcdBuf_t)
     D  io_nullMap                                like(nullMap_t)
     D                                            dim(NULL_MAP_SIZE)
      *
      *-------------------------------------------------------------------*
     D CIO_setllWithRRN...
     D                 PR                         like(bool_t)
     D                                            extproc('PEEK63+
     D                                            _CIO_setllWithRRN+
     D                                            ')
     D  io_hFile                                  likeds(hFile_t)
     D  i_rrn                              const  like(rcdNbr_t)
      *
      *-------------------------------------------------------------------*
     D CIO_setllWithKey...
     D                 PR                         like(bool_t)
     D                                            extproc('PEEK63+
     D                                            _CIO_setllWithKey+
     D                                            ')
     D  io_hFile                                  likeds(hFile_t)
     D  i_key                              const  like(keyBuf_t)
      *
      *-------------------------------------------------------------------*
     D CIO_setgtWithRRN...
     D                 PR                         like(bool_t)
     D                                            extproc('PEEK63+
     D                                            _CIO_setgtWithRRN+
     D                                            ')
     D  io_hFile                                  likeds(hFile_t)
     D  i_rrn                              const  like(rcdNbr_t)
      *
      *-------------------------------------------------------------------*
     D CIO_setgtWithKey...
     D                 PR                         like(bool_t)
     D                                            extproc('PEEK63+
     D                                            _CIO_setgtWithKey+
     D                                            ')
     D  io_hFile                                  likeds(hFile_t)
     D  i_key                              const  like(keyBuf_t)
      *
      *-------------------------------------------------------------------*
     D CIO_read...
     D                 PR                         like(bool_t)
     D                                            extproc('PEEK63+
     D                                            _CIO_read+
     D                                            ')
     D  io_hFile                                  likeds(hFile_t)
     D  i_doLock                           const  like(bool_t)
     D  io_rcdBuffer                              like(rcdBuf_t)
     D  io_nullMap                                like(nullMap_t)
     D                                            dim(NULL_MAP_SIZE)
      *
      *-------------------------------------------------------------------*
     D CIO_readp...
     D                 PR                         like(bool_t)
     D                                            extproc('PEEK63+
     D                                            _CIO_readp+
     D                                            ')
     D  io_hFile                                  likeds(hFile_t)
     D  i_doLock                           const  like(bool_t)
     D  io_rcdBuffer                              like(rcdBuf_t)
     D  io_nullMap                                like(nullMap_t)
     D                                            dim(NULL_MAP_SIZE)
      *
      *-------------------------------------------------------------------*
     D CIO_delete...
     D                 PR                         like(bool_t)
     D                                            extproc('PEEK63+
     D                                            _CIO_delete+
     D                                            ')
     D  io_hFile                                  likeds(hFile_t)
      *
      *-------------------------------------------------------------------*
     D CIO_unlock...
     D                 PR                         like(bool_t)
     D                                            extproc('PEEK63+
     D                                            _CIO_unlock+
     D                                            ')
     D  io_hFile                                  likeds(hFile_t)
      *
      *-------------------------------------------------------------------*
     D CIO_close...
     D                 PR                         like(bool_t)
     D                                            extproc('PEEK63+
     D                                            _CIO_close+
     D                                            ')
     D  io_hFile                                  likeds(hFile_t)
      *
      *-------------------------------------------------------------------*
      *
