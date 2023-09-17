?     *
?     *============================================================*
?     *      Modul: Peek051                                        *
?     *============================================================*
?     *                                                                                       RADDAT
     D SQL_prepareStatement...                                                                RADDAT
     D                 PR                         like(r§bool    )                            RADDAT
     D                                     extproc('SQL_prepareStatement')                    RADDAT
     D  i_check                            value  like(r§bool    )
     D  i_file                             value  like(r§file    )
     D  i_lib                              value  like(r§lib     )
     D  i_mbr                              value  like(r§mbr     )
     D  i_format                           value  like(r§rcdFmt  )                            RADDAT
     D  i_sqlSelect                 512A   value
     D  i_sqlOrder                  512A   value
     D  o_msgID                                   like(r§msgID   )
     D  o_msgDta                                  like(r§msgDta  )
?     *
?     *-------------------------------------------------------------------*
?     *
     D SQL_open...                                                                            RADDAT
     D                 PR                         like(r§bool    )                            RADDAT
     D                                     extproc('SQL_open')                                RADDAT
     D  o_hFile                                   likeds(r§hFile )                            RADDAT
     D  o_msgID                                   like(r§msgID   )                            RADDAT
     D  o_msgDta                                  like(r§msgDta  )                            RADDAT
?     *
?     *-------------------------------------------------------------------*
     D SQL_nextRow...                                                                         RADDAT
     D                 PR                         like(r§bool    )                            RADDAT
     D                                     extproc('SQL_nextRow')                             RADDAT
     D  o_buffer                                  like(r§rcdBuf  )                            RADDAT
     D  o_nullMap                                 like(r§nullMap )                            RADDAT
     D                                            dim(§nullMapSize)                           RADDAT
     D  o_hFile                                   likeds(r§hFile )                            RADDAT
     D  o_msgID                                   like(r§msgID   )                            RADDAT
     D  o_msgDta                                  like(r§msgDta  )                            RADDAT
?     *
?     *-------------------------------------------------------------------*
     D SQL_previousRow...                                                                     RADDAT
     D                 PR                         like(r§bool    )                            RADDAT
     D                                     extproc('SQL_previousRow')                         RADDAT
     D  o_buffer                                  like(r§rcdBuf  )                            RADDAT
     D  o_nullMap                                 like(r§nullMap )                            RADDAT
     D                                            dim(§nullMapSize)                           RADDAT
     D  o_hFile                                   likeds(r§hFile )                            RADDAT
     D  o_msgID                                   like(r§msgID   )                            RADDAT
     D  o_msgDta                                  like(r§msgDta  )                            RADDAT
?     *
?     *-------------------------------------------------------------------*
     D SQL_gotoTop...                                                                         RADDAT
     D                 PR                         like(r§bool   )                             RADDAT
     D                                     extproc('SQL_gotoTop')                             RADDAT
     D  o_msgID                                   like(r§msgID  )                             RADDAT
     D  o_msgDta                                  like(r§msgDta )                             RADDAT
?     *
?     *-------------------------------------------------------------------*
     D SQL_gotoBottom...                                                                      RADDAT
     D                 PR                         like(r§bool   )                             RADDAT
     D                                     extproc('SQL_gotoBottom')                          RADDAT
     D  o_msgID                                   like(r§msgID  )                             RADDAT
     D  o_msgDta                                  like(r§msgDta )                             RADDAT
?     *
?     *-------------------------------------------------------------------*
     D SQL_close...                                                                           RADDAT
     D                 PR                         like(r§bool    )                            RADDAT
     D                                     extproc('SQL_close')                               RADDAT
     D  o_hFile                                   likeds(r§hFile )                            RADDAT
     D  o_msgID                                   like(r§msgID   )                            RADDAT
     D  o_msgDta                                  like(r§msgDta  )                            RADDAT
?     *
?     *-------------------------------------------------------------------*
     D SQL_quote...                                                                           RADDAT
     D                 PR           512A                                                      RADDAT
     D                                     extproc('SQL_quote')                               RADDAT
     D  i_string                    512A   const
?     *                                                                                       RADDAT
?     *-------------------------------------------------------------------*                   RADDAT
     D SQL_count...                                                                           RADDAT
     D                 PR            10I 0                                                    RADDAT
     D                                     extproc('SQL_count')                               RADDAT
?     *-------------------------------------------------------------------*                   RADDAT
?     *
