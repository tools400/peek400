?     *
?     *============================================================*
?     *      Modul: Peek051                                        *
?     *============================================================*
?     *                                                                                       RADDAT
     D SQL_prepareStatement...                                                                RADDAT
     D                 PR                         like(bool_t)                            RADDAT
     D                                     extproc('SQL_prepareStatement')                    RADDAT
     D  i_check                            value  like(bool_t)
     D  i_file                             value  like(file_t)
     D  i_lib                              value  like(lib_t)
     D  i_mbr                              value  like(mbr_t)
     D  i_format                           value  like(rcdFmt_t)                            RADDAT
     D  i_sqlSelect                 512A   value
     D  i_sqlOrder                  512A   value
     D  o_msgID                                   like(msgID_t)
     D  o_msgDta                                  like(msgDta_t)
?     *
?     *-------------------------------------------------------------------*
?     *
     D SQL_open...                                                                            RADDAT
     D                 PR                         like(bool_t)                            RADDAT
     D                                     extproc('SQL_open')                                RADDAT
     D  o_hFile                                   likeds(hFile_t)                            RADDAT
     D  o_msgID                                   like(msgID_t)                            RADDAT
     D  o_msgDta                                  like(msgDta_t)                            RADDAT
?     *
?     *-------------------------------------------------------------------*
     D SQL_nextRow...                                                                         RADDAT
     D                 PR                         like(bool_t)                            RADDAT
     D                                     extproc('SQL_nextRow')                             RADDAT
     D  o_buffer                                  like(rcdBuf_t)                            RADDAT
     D  o_nullMap                                 like(nullMap_t)                            RADDAT
     D                                            dim(NULL_MAP_SIZE)                           RADDAT
     D  o_hFile                                   likeds(hFile_t)                            RADDAT
     D  o_msgID                                   like(msgID_t)                            RADDAT
     D  o_msgDta                                  like(msgDta_t)                            RADDAT
?     *
?     *-------------------------------------------------------------------*
     D SQL_previousRow...                                                                     RADDAT
     D                 PR                         like(bool_t)                            RADDAT
     D                                     extproc('SQL_previousRow')                         RADDAT
     D  o_buffer                                  like(rcdBuf_t)                            RADDAT
     D  o_nullMap                                 like(nullMap_t)                            RADDAT
     D                                            dim(NULL_MAP_SIZE)                           RADDAT
     D  o_hFile                                   likeds(hFile_t)                            RADDAT
     D  o_msgID                                   like(msgID_t)                            RADDAT
     D  o_msgDta                                  like(msgDta_t)                            RADDAT
?     *
?     *-------------------------------------------------------------------*
     D SQL_gotoTop...                                                                         RADDAT
     D                 PR                         like(bool_t)                             RADDAT
     D                                     extproc('SQL_gotoTop')                             RADDAT
     D  o_msgID                                   like(msgID_t)                             RADDAT
     D  o_msgDta                                  like(msgDta_t)                             RADDAT
?     *
?     *-------------------------------------------------------------------*
     D SQL_gotoBottom...                                                                      RADDAT
     D                 PR                         like(bool_t)                             RADDAT
     D                                     extproc('SQL_gotoBottom')                          RADDAT
     D  o_msgID                                   like(msgID_t)                             RADDAT
     D  o_msgDta                                  like(msgDta_t)                             RADDAT
?     *
?     *-------------------------------------------------------------------*
     D SQL_close...                                                                           RADDAT
     D                 PR                         like(bool_t)                            RADDAT
     D                                     extproc('SQL_close')                               RADDAT
     D  o_hFile                                   likeds(hFile_t)                            RADDAT
     D  o_msgID                                   like(msgID_t)                            RADDAT
     D  o_msgDta                                  like(msgDta_t)                            RADDAT
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
