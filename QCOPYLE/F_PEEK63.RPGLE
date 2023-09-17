?     *
?     *============================================================*
?     *      Modul: Peek063                                        *                          RADDAT
?     *============================================================*
CPY  /INCLUDE QCOPYLE,D_VARDEF                  ?                                            RADDAT
CPY  /INCLUDE QCOPYLE,D_INFDS                   ?                                            RADDAT
?     *                                                                                       RADDAT
     D r§hFile         DS                  qualified               based(pDummy)              RADDAT
     D  fd                             *                                                      RADDAT
     D  isOpen                             like(r§bool   )                                    RADDAT
     D  name                               like(r§file   )                                    RADDAT
     D  lib                                like(r§lib    )                                    RADDAT
     D  mbr                                like(r§mbr    )                                    RADDAT
     D  rcdFormat                    10A                                                      RADDAT
     D  errno                        10I 0                                                    RADDAT
     D  lastOper                     10A                                                      RADDAT
     D  arrseq                        1A                                                      RADDAT
     D  msgID                              like(r§msgID  )                                    RADDAT
     D  msgDta                             like(r§msgDta )                                    RADDAT
?     *
?     *-------------------------------------------------------------------*
     D CIO_open...                                                                            RADDAT
     D                 PR                         like(r§bool    )                            RADDAT
     D                                            extproc('PEEK63+                            RADDAT
     D                                            _CIO_open+                                  RADDAT
     D                                            ')                                          RADDAT
     D  o_hFile                                   likeds(r§hFile )                            RADDAT
     D  i_file                             const  like(r§file    )                            RADDAT
     D  i_lib                              const  like(r§lib     )                            RADDAT
     D  i_mbr                              const  like(r§mbr     )                            RADDAT
     D  i_rcdFormat                  10A   const                                              RADDAT
     D  i_mode                         *   const  options(*string)                            RADDAT
?     *                                                                                       RADDAT
?     *-------------------------------------------------------------------*                   RADDAT
     D CIO_isOpen...                                                                          RADDAT
     D                 PR                         like(r§bool    )                            RADDAT
     D                                            extproc('PEEK63+                            RADDAT
     D                                            _CIO_isOpen+                                RADDAT
     D                                            ')                                          RADDAT
     D  i_hFile                            const  likeds(r§hFile )                            RADDAT
?     *                                                                                       RADDAT
?     *-------------------------------------------------------------------*                   RADDAT
     D CIO_getFile...                                                                         RADDAT
     D                 PR                         like(r§file    )                            RADDAT
     D                                            extproc('PEEK63+                            RADDAT
     D                                            _CIO_getFile+                               RADDAT
     D                                            ')                                          RADDAT
     D  i_hFile                            const  likeds(r§hFile )                            RADDAT
?     *                                                                                       RADDAT
?     *-------------------------------------------------------------------*                   RADDAT
     D CIO_getLibrary...                                                                      RADDAT
     D                 PR                         like(r§lib     )                            RADDAT
     D                                            extproc('PEEK63+                            RADDAT
     D                                            _CIO_getLibrary+                            RADDAT
     D                                            ')                                          RADDAT
     D  i_hFile                            const  likeds(r§hFile )                            RADDAT
?     *                                                                                       RADDAT
?     *-------------------------------------------------------------------*                   RADDAT
     D CIO_getMember...                                                                       RADDAT
     D                 PR                         like(r§mbr     )                            RADDAT
     D                                            extproc('PEEK63+                            RADDAT
     D                                            _CIO_getMember+                             RADDAT
     D                                            ')                                          RADDAT
     D  i_hFile                            const  likeds(r§hFile )                            RADDAT
?     *                                                                                       RADDAT
?     *-------------------------------------------------------------------*                   RADDAT
     D CIO_getRecordFormat...                                                                 RADDAT
     D                 PR            10A                                                      RADDAT
     D                                            extproc('PEEK63+                            RADDAT
     D                                            _CIO_getRecordFormat+                       RADDAT
     D                                            ')                                          RADDAT
     D  i_hFile                            const  likeds(r§hFile )                            RADDAT
?     *                                                                                       RADDAT
?     *-------------------------------------------------------------------*                   RADDAT
     D CIO_getRecordLength...                                                                 RADDAT
     D                 PR            10I 0                                                    RADDAT
     D                                            extproc('PEEK63+                            RADDAT
     D                                            _CIO_getRecordLength+                       RADDAT
     D                                            ')                                          RADDAT
     D  i_hFile                            const  likeds(r§hFile )                            RADDAT
?     *                                                                                       RADDAT
?     *-------------------------------------------------------------------*                   RADDAT
     D CIO_getRRN...                                                                          RADDAT
     D                 PR            10I 0                                                    RADDAT
     D                                            extproc('PEEK63+                            RADDAT
     D                                            _CIO_getRRN+                                RADDAT
     D                                            ')                                          RADDAT
     D  i_hFile                            const  likeds(r§hFile )                            RADDAT
      *
      *-------------------------------------------------------------------*
     D CIO_getMbrNbr...
     D                 PR            10I 0
     D                                            extproc('PEEK63+
     D                                            _CIO_getMbrNbr+
     D                                            ')
     D  i_hFile                            const  likeds(r§hFile )
?     *                                                                                       RADDAT
?     *-------------------------------------------------------------------*                   RADDAT
     D CIO_getInfDS...                                                                        RADDAT
     D                 PR                         likeds(r§infds)                             RADDAT
     D                                            extproc('PEEK63+                            RADDAT
     D                                            _CIO_getInfDS+                              RADDAT
     D                                            ')                                          RADDAT
     D  i_hFile                            const  likeds(r§hFile )                            RADDAT
?     *                                                                                       RADDAT
?     *-------------------------------------------------------------------*                   RADDAT
     D CIO_isError...                                                                         RADDAT
     D                 PR                         like(r§bool    )                            RADDAT
     D                                            extproc('PEEK63+                            RADDAT
     D                                            _CIO_isError+                               RADDAT
     D                                            ')                                          RADDAT
     D  i_hFile                            const  likeds(r§hFile )                            RADDAT
?     *                                                                                       RADDAT
?     *-------------------------------------------------------------------*                   RADDAT
     D CIO_setErrorMsg...                                                                     RADDAT
     D                 PR                                                                     RADDAT
     D                                            extproc('PEEK63+                            RADDAT
     D                                            _CIO_setErrorMsg+                           RADDAT
     D                                            ')                                          RADDAT
     D  io_hFile                                  likeds(r§hFile )                            RADDAT
     D  i_msgID                            const  like(r§msgID   )                            RADDAT
     D  i_msgDta                           const  like(r§msgDta  )                            RADDAT
?     *                                                                                       RADDAT
?     *-------------------------------------------------------------------*                   RADDAT
     D CIO_getErrorMsg...                                                                     RADDAT
     D                 PR                                                                     RADDAT
     D                                            extproc('PEEK63+                            RADDAT
     D                                            _CIO_getErrorMsg+                           RADDAT
     D                                            ')                                          RADDAT
     D  i_hFile                            const  likeds(r§hFile )                            RADDAT
     D  o_msgID                                   like(r§msgID   )                            RADDAT
     D  o_msgDta                                  like(r§msgDta  )                            RADDAT
?     *                                                                                       RADDAT
?     *-------------------------------------------------------------------*                   RADDAT
     D CIO_getError...                                                                        RADDAT
     D                 PR            10I 0                                                    RADDAT
     D                                            extproc('PEEK63+                            RADDAT
     D                                            _CIO_getError+                              RADDAT
     D                                            ')                                          RADDAT
     D  i_hFile                            const  likeds(r§hFile )                            RADDAT
?     *                                                                                       RADDAT
?     *-------------------------------------------------------------------*                   RADDAT
     D CIO_getErrorText...                                                                    RADDAT
     D                 PR           512A          varying                                     RADDAT
     D                                            extproc('PEEK63+                            RADDAT
     D                                            _CIO_getErrorText+                          RADDAT
     D                                            ')                                          RADDAT
     D  i_hFile                            const  likeds(r§hFile )                            RADDAT
?     *                                                                                       RADDAT
?     *-------------------------------------------------------------------*                   RADDAT
     D CIO_chainWithRRN...                                                                    RADDAT
     D                 PR                         like(r§bool     )                           RADDAT
     D                                            extproc('PEEK63+                            RADDAT
     D                                            _CIO_chainWithRRN+                          RADDAT
     D                                            ')                                          RADDAT
     D  io_hFile                                  likeds(r§hFile  )                           RADDAT
     D  i_rrn                              const  like(r§rcdNbr   )                           RADDAT
     D  i_doLock                           const  like(r§bool     )                           RADDAT
     D  io_rcdBuffer                              like(r§rcdBuf   )                           RADDAT
     D  io_nullMap                                like(r§nullMap  )                           RADDAT
     D                                            dim(§nullMapSize)                           RADDAT
?     *                                                                                       RADDAT
?     *-------------------------------------------------------------------*                   RADDAT
     D CIO_chainWithKey...                                                                    RADDAT
     D                 PR                         like(r§bool     )                           RADDAT
     D                                            extproc('PEEK63+                            RADDAT
     D                                            _CIO_chainWithKey+                          RADDAT
     D                                            ')                                          RADDAT
     D  io_hFile                                  likeds(r§hFile  )                           RADDAT
     D  i_key                              const  like(r§keyBuf   )                           RADDAT
     D  i_doLock                           const  like(r§bool     )                           RADDAT
     D  io_rcdBuffer                              like(r§rcdBuf   )                           RADDAT
     D  io_nullMap                                like(r§nullMap  )                           RADDAT
     D                                            dim(§nullMapSize)                           RADDAT
?     *                                                                                       RADDAT
?     *-------------------------------------------------------------------*                   RADDAT
     D CIO_setllWithRRN...                                                                    RADDAT
     D                 PR                         like(r§bool     )                           RADDAT
     D                                            extproc('PEEK63+                            RADDAT
     D                                            _CIO_setllWithRRN+                          RADDAT
     D                                            ')                                          RADDAT
     D  io_hFile                                  likeds(r§hFile  )                           RADDAT
     D  i_rrn                              const  like(r§rcdNbr   )                           RADDAT
?     *                                                                                       RADDAT
?     *-------------------------------------------------------------------*                   RADDAT
     D CIO_setllWithKey...                                                                    RADDAT
     D                 PR                         like(r§bool     )                           RADDAT
     D                                            extproc('PEEK63+                            RADDAT
     D                                            _CIO_setllWithKey+                          RADDAT
     D                                            ')                                          RADDAT
     D  io_hFile                                  likeds(r§hFile  )                           RADDAT
     D  i_key                              const  like(r§keyBuf   )                           RADDAT
?     *                                                                                       RADDAT
?     *-------------------------------------------------------------------*                   RADDAT
     D CIO_setgtWithRRN...                                                                    RADDAT
     D                 PR                         like(r§bool     )                           RADDAT
     D                                            extproc('PEEK63+                            RADDAT
     D                                            _CIO_setgtWithRRN+                          RADDAT
     D                                            ')                                          RADDAT
     D  io_hFile                                  likeds(r§hFile  )                           RADDAT
     D  i_rrn                              const  like(r§rcdNbr   )                           RADDAT
?     *                                                                                       RADDAT
?     *-------------------------------------------------------------------*                   RADDAT
     D CIO_setgtWithKey...                                                                    RADDAT
     D                 PR                         like(r§bool     )                           RADDAT
     D                                            extproc('PEEK63+                            RADDAT
     D                                            _CIO_setgtWithKey+                          RADDAT
     D                                            ')                                          RADDAT
     D  io_hFile                                  likeds(r§hFile  )                           RADDAT
     D  i_key                              const  like(r§keyBuf   )                           RADDAT
?     *                                                                                       RADDAT
?     *-------------------------------------------------------------------*                   RADDAT
     D CIO_read...                                                                            RADDAT
     D                 PR                         like(r§bool     )                           RADDAT
     D                                            extproc('PEEK63+                            RADDAT
     D                                            _CIO_read+                                  RADDAT
     D                                            ')                                          RADDAT
     D  io_hFile                                  likeds(r§hFile  )                           RADDAT
     D  i_doLock                           const  like(r§bool     )                           RADDAT
     D  io_rcdBuffer                              like(r§rcdBuf   )                           RADDAT
     D  io_nullMap                                like(r§nullMap  )                           RADDAT
     D                                            dim(§nullMapSize)                           RADDAT
?     *                                                                                       RADDAT
?     *-------------------------------------------------------------------*                   RADDAT
     D CIO_readp...                                                                           RADDAT
     D                 PR                         like(r§bool     )                           RADDAT
     D                                            extproc('PEEK63+                            RADDAT
     D                                            _CIO_readp+                                 RADDAT
     D                                            ')                                          RADDAT
     D  io_hFile                                  likeds(r§hFile  )                           RADDAT
     D  i_doLock                           const  like(r§bool     )                           RADDAT
     D  io_rcdBuffer                              like(r§rcdBuf   )                           RADDAT
     D  io_nullMap                                like(r§nullMap  )                           RADDAT
     D                                            dim(§nullMapSize)                           RADDAT
?     *                                                                                       RADDAT
?     *-------------------------------------------------------------------*                   RADDAT
     D CIO_delete...                                                                          RADDAT
     D                 PR                         like(r§bool     )                           RADDAT
     D                                            extproc('PEEK63+                            RADDAT
     D                                            _CIO_delete+                                RADDAT
     D                                            ')                                          RADDAT
     D  io_hFile                                  likeds(r§hFile  )                           RADDAT
?     *                                                                                       RADDAT
?     *-------------------------------------------------------------------*                   RADDAT
     D CIO_unlock...                                                                          RADDAT
     D                 PR                         like(r§bool     )                           RADDAT
     D                                            extproc('PEEK63+                            RADDAT
     D                                            _CIO_unlock+                                RADDAT
     D                                            ')                                          RADDAT
     D  io_hFile                                  likeds(r§hFile  )                           RADDAT
?     *                                                                                       RADDAT
?     *-------------------------------------------------------------------*                   RADDAT
     D CIO_close...                                                                           RADDAT
     D                 PR                         like(r§bool    )                            RADDAT
     D                                            extproc('PEEK63+                            RADDAT
     D                                            _CIO_close+                                 RADDAT
     D                                            ')                                          RADDAT
     D  io_hFile                                  likeds(r§hFile )                            RADDAT
?     *                                                                                       RADDAT
?     *-------------------------------------------------------------------*                   RADDAT
     D CIO_setEOF_read...                                                                     RADDAT
     D                 PR                                                                     RADDAT
     D                                            extproc('PEEK63+                            RADDAT
     D                                            _CIO_setEOF_read+                           RADDAT
     D                                            ')                                          RADDAT
     D  io_hFile                                  likeds(r§hFile )                            RADDAT
?     *                                                                                       RADDAT
?     *-------------------------------------------------------------------*                   RADDAT
     D CIO_setEOF_readp...                                                                    RADDAT
     D                 PR                                                                     RADDAT
     D                                            extproc('PEEK63+                            RADDAT
     D                                            _CIO_setEOF_readp+                          RADDAT
     D                                            ')                                          RADDAT
     D  io_hFile                                  likeds(r§hFile )                            RADDAT
?     *                                                                                       RADDAT
?     *-------------------------------------------------------------------*                   RADDAT
?     *                                                                                       RADDAT
