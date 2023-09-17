      *
      *============================================================*
      *      Modul: Peek058                                        *
      *============================================================*
      *                                                                                       RADDAT
      *  Konstants: f_wordWrap()                                                              RADDAT
     D cWORDWRAP_PARAGRAPH_NONE...                                                            RADDAT
     D                 C                   const(1)                                           RADDAT
     D cWORDWRAP_PARAGRAPH_MSGD...                                                            RADDAT
     D                 C                   const(2)                                           RADDAT
     D cWORDWRAP_PARAGRAPH_TEXT...                                                            RADDAT
     D                 C                   const(4)                                           RADDAT
     D cWORDWRAP_PARAGRAPH_TRIMR...                                                           RADDAT
     D                 C                   const(8)                                           RADDAT
      *                                                                                       RADDAT
      *-------------------------------------------------------------------*                   RADDAT
     D f_dsplyLn       PR                         like(r§int4      )                          RADDAT
     D  i_FLDL0100                         const  likeds(fldl0100_t)                          RADDAT
      *
      *-------------------------------------------------------------------*
     D f_buffLn        PR                         like(r§int4      )                          RADDAT
     D  i_FLDL0100                         const  likeds(fldl0100_t)                          RADDAT
     D  i_withLen                          const  like(r§bool      )                          RADDAT
     D                                            options(*nopass)
      *
      *
      *-------------------------------------------------------------------*
     D f_curFldLn      PR                         like(r§int4      )                          RADDAT
     D  i_buffer                           const  like(r§rcdBuf    )                          RADDAT
     D  i_FLDL0100                         const  likeds(fldl0100_t)                          RADDAT
      *
      *
      *-------------------------------------------------------------------*
     D f_rtvFld        PR                         opdesc like(r§int4    )
     D  o_buffer                                  like(r§rcdBuf    )                          RADDAT
     D                                            options(*varsize)
     D  i_buffer                           const  like(r§rcdBuf    )                          RADDAT
     D  i_FLDL0100                         const  likeds(fldl0100_t)                          RADDAT
     D  i_withLenByte                      const  like(r§bool      )                          RADDAT
     D                                            options(*nopass)                            RADDAT
      *
      *-------------------------------------------------------------------*
     D p_fldToBuf      PR
     D  io_buffer                                 like(r§rcdbuf    )                          RADDAT
     D  i_fieldData                               like(r§rcdbuf    )                          RADDAT
     D  i_FLDL0100                         const  likeds(fldl0100_t)                          RADDAT
     D  i_withLenByte                      const  like(r§bool      )                          RADDAT
     D                                            options(*nopass)
      *
      *-------------------------------------------------------------------*
     D f_isVarLen      PR                         like(r§bool      )                          RADDAT
     D  i_FLDL0100                         const  likeds(fldl0100_t)                          RADDAT
      *
      *-------------------------------------------------------------------*
     D f_binToDec      PR                  opdesc like(r§int4    )
     D  i_string                  32767A   const options(*varsize)
     D  i_startPos                         const  like(r§int4    )
     D  i_length                           const  like(r§int4    )
      *
      *-------------------------------------------------------------------*
     D f_len           PR                  opdesc like(r§int4    )
     D  i_string                  32767A   const options(*varsize)
      *
      *-------------------------------------------------------------------*
      *
     D f_scan          PR                  opdesc like(r§int4    )
     D  SrchArg                     100A   CONST  OPTIONS(*VARSIZE)                           RADDAT
     D  String                      100A   CONST
      *
      *-------------------------------------------------------------------*
     D f_vldName       PR                         like(r§bool    )
     D  i_name                       10A   const
     D  o_msgID                                   like(r§msgID   )
     D  o_msgDta                                  like(r§msgDta  )
      *                                                                                       RADDAT
      *-------------------------------------------------------------------*                   RADDAT
     D f_vldFloat      PR                         like(r§bool    )                            RADDAT
     D  i_buffer                     64A   const  varying                                     RADDAT
      *
      *-------------------------------------------------------------------*
     D f_execute       PR                  opdesc like(r§bool    )
     D  i_cmd                     32702A   const                                              RADDAT
     D                                     options(*VARSIZE)
     D  o_msgID                                   like(r§msgID   )
     D  o_msgDta                                  like(r§msgDta  )
      *
      *-------------------------------------------------------------------*
     D f_basedPF       PR                         like(r§bool   )
     D  i_file                             value  like(r§file   )                             RADDAT
     D  i_lib                              value  like(r§lib    )                             RADDAT
     D  i_mbr                              value  like(r§mbr    )                             RADDAT
     D  i_rcdFmt                           value  like(r§rcdFmt )
     D  i_rcdMbrNbr                        value  like(r§mbrNbr )
     D  o_pFile                                   like(r§file   )
     D  o_pLib                                    like(r§lib    )
     D  o_pMbr                                    like(r§mbr    )
     D  o_pRcdFmt                                 like(r§rcdFmt )
      *                                                                                       RADDAT
     D f_basedMbr      PR                         like(r§bool    )                            RADDAT
     D  i_file                             value  like(r§file    )                            RADDAT
     D  i_lib                              value  like(r§lib     )                            RADDAT
     D  i_mbr                              value  like(r§mbr     )                            RADDAT
     D  i_mbrNbr                           value  like(r§int4    )
     D  i_rcdFmt                           value  like(r§rcdFmt  )
     D  o_pFile                                   like(r§file    )                            RADDAT
     D  o_pLib                                    like(r§lib     )                            RADDAT
     D  o_pMbr                                    like(r§mbr     )                            RADDAT
     D  o_rcdFmt                                  like(r§rcdFmt  )
      *                                                                                       RADDAT
     D f_numBased      PR                         like(r§int4    )                            RADDAT
     D  i_file                             const  like(r§file    )                            RADDAT
     D  i_lib                              const  like(r§lib     )                            RADDAT
     D  i_mbr                              const  like(r§mbr     )                            RADDAT
      *
      *-------------------------------------------------------------------*
     D p_setPrdLb      PR
     D  i_lib                              const  like(r§lib     )
      *
      *-------------------------------------------------------------------*
     D f_getPrdLb      PR                         like(r§lib     )
      *
      *-------------------------------------------------------------------*
     D f_cmdLine       PR                         like(r§bool    )
      *
      *
      *-------------------------------------------------------------------*
     D p_expStr        PR                  opdesc
     D  o_string                  32767A          options(*varsize)
     D  i_string                  32767A   const  options(*varsize)
     D  i_stepVal                    10I 0 const  options(*nopass)
      *
      *-------------------------------------------------------------------*
     D f_headline      PR            50A                                                      RADDAT
     D  i_headTyp                    10A   const
     D  i_FLDL0100                         const  likeds(fldl0100_t)                          RADDAT
      *
      *-------------------------------------------------------------------*
     D f_isNumFld      PR                         like(r§bool      )                          RADDAT
     D  i_FLDL0100                         const  likeds(fldl0100_t)                          RADDAT
      *                                                                                       RADDAT
      *-------------------------------------------------------------------*                   RADDAT
     D f_isFloatFld    PR                         like(r§bool      )                          RADDAT
     D  i_FLDL0100                         const  likeds(fldl0100_t)                          RADDAT
      *                                                                                       RADDAT
      *-------------------------------------------------------------------*                   RADDAT
     D f_isCharFld     PR                         like(r§bool      )                          RADDAT
     D  i_FLDL0100                         const  likeds(fldl0100_t)                          RADDAT
      *                                                                                       RADDAT
      *-------------------------------------------------------------------*                   RADDAT
     D f_hasCcsid      PR                         like(r§bool      )                          RADDAT
     D  i_FLDL0100                         const  likeds(fldl0100_t)                          RADDAT
      *
      *-------------------------------------------------------------------*
     D f_appMsgF       PR                         like(r§file    )
      *
      *-------------------------------------------------------------------*
     D f_appMsgFL      PR                         like(r§lib     )
      *
      *-------------------------------------------------------------------*
     D p_rmvPgmMg      PR
     D  i_pgmNme                           const  like(r§pgm     )
      *
      *-------------------------------------------------------------------*
     D p_sndPgmMg      PR
     D  i_msgID                                   like(r§msgID   )
     D  i_msgDta                                  like(r§msgDta  )
     D  i_pgmNme                           const  like(r§pgm     )
     D  i_msgType                          const  like(r§msgType )
     D                                            options(*nopass)
      *
      *-------------------------------------------------------------------*
     D f_canUseRefFld  PR                         like(r§bool      )
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      *
      *-------------------------------------------------------------------*
     D f_canUseCntFld  PR                         like(r§bool      )
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      *
      *-------------------------------------------------------------------*
     D f_mustCvtCcsid  PR                         like(r§bool      )
      *
      *-------------------------------------------------------------------*
     D f_isToLong      PR                         like(r§bool      )                          RADDAT
     D  i_FLDL0100                         const  likeds(fldl0100_t)                          RADDAT
      *                                                                                       RADDAT
      *-------------------------------------------------------------------*                   RADDAT
     D f_isToLongMax   PR                         like(r§bool      )                          RADDAT
     D  i_FLDL0100                         const  likeds(fldl0100_t)                          RADDAT
      *
      *-------------------------------------------------------------------*
     D f_maxDspLn      PR                         like(r§int4    )                            RADDAT
     D  i_FLDL0100                         const  likeds(fldl0100_t)                          RADDAT
      *                                                                                       RADDAT
      *-------------------------------------------------------------------*                   RADDAT
     D f_cntFldLn      PR                         like(r§int4    )                            RADDAT
     D  i_FLDL0100                         const  likeds(fldl0100_t)                          RADDAT
      *
      *-------------------------------------------------------------------*
     D f_nbrDspRw      PR                         like(r§int4      )                          RADDAT
     D  i_FLDL0100                         const  likeds(fldl0100_t)                          RADDAT
      *
      *-------------------------------------------------------------------*
     D p_decToBin      PR                  opdesc
     D  io_string                 32767A          options(*varsize)
     D  i_startPos                         const  like(r§int4    )
     D  i_length                           const  like(r§int4    )
     D  i_value                            const  like(r§int4    )
      *
      *-------------------------------------------------------------------*
     D f_isNotAlw      PR                         like(r§bool      )                          RADDAT
     D  i_FLDL0100                         const  likeds(fldl0100_t)                          RADDAT
      *                                                                                       RADDAT
      *-------------------------------------------------------------------*                   RADDAT
     D f_isKeyFld      PR                         like(r§bool      )                          RADDAT
     D  i_FLDL0100                         const  likeds(fldl0100_t)                          RADDAT
      *
      *-------------------------------------------------------------------*
     D p_sndStsMg      PR
     D  i_msgID                            const  like(r§msgID   )
     D  i_msgDta                           const  like(r§msgDta  )
      *
      *-------------------------------------------------------------------*
     D f_pgmCallN      PR                         like(r§pgmCallN)
     D  i_pgmNme                           const  like(r§pgm     )
      *
      *-------------------------------------------------------------------*
     D f_rtvMsgD       PR          2048A
     D  i_msgID                            value  like(r§msgID   )
     D  i_msgDta                           value  like(r§msgDta  )
     D  i_rplcSubV                         const  like(r§bool    )
     D                                            options(*nopass)
     D  i_rtnFmtCC                         const  like(r§bool    )
     D                                            options(*nopass)
     D  i_msgF                             value  like(r§file    )
     D                                            options(*nopass)
     D  i_msgFL                            value  like(r§lib     )
     D                                            options(*nopass)
      *
      *-------------------------------------------------------------------*
     D f_msgText       PR           512A
     D  i_msgID                            value  like(r§msgID   )
     D  i_msgDta                           value  like(r§msgDta  )
     D  i_msgF                             value  like(r§file    )
     D                                            options(*nopass)
     D  i_msgFL                            value  like(r§lib     )
     D                                            options(*nopass)
      *
      *-------------------------------------------------------------------*
     D p_movPgmMg      PR
     D  i_pgmNme                           const  like(r§pgm     )
      *
      *-------------------------------------------------------------------*
     D p_wrongKey      PR
     D  i_scnAID                           const  like(r§scnAID  )
     D  i_pgmNme                           const  like(r§pgm     )
      *
      *-------------------------------------------------------------------*
     D p_keyToMsg      PR
     D  i_scnAID                           const  like(r§scnAID  )
     D  o_msgID                                   like(r§msgID   )
     D  o_msgDta                                  like(r§msgDta  )
      *
      *-------------------------------------------------------------------*
     D f_spltTxt       PR                  opdesc like(r§int4    )
     D  i_text                    32767A   const  options(*varsize)
     D  i_strPos                           const  like(r§int4    )
     D  i_len                              const  like(r§int4    )
     D  o_text                    32767A          options(*varsize)
      *
      *-------------------------------------------------------------------*
     D p_center        PR                  opdesc
     D  i_text                    32767A          options(*varsize)
      *
      *===================================================================*
     D  p_hexToChr     PR                  extproc('cvthc')
     D   Char                     32767A   options(*varsize)
     D   Hex                      32767A   options(*varsize)
     D   lenHex                      10I 0 value
      *
      *-------------------------------------------------------------------*
     D  p_chrToHex     PR                  extproc('cvtch')
     D   Hex                      32767A   options(*varsize)
     D   Char                     32767A   options(*varsize)
     D   lenChar                     10I 0 value
      *
      *-------------------------------------------------------------------*                   RADDAT
     D f_addPtr        PR              *                                                      RADDAT
     D  i_pointer                      *   value                                              RADDAT
     D  i_offset                      5I 0 value                                              RADDAT
      *                                                                                       RADDAT
      *-------------------------------------------------------------------*                   RADDAT
     D f_isKeyExc      PR                        like(r§bool    )                             RADDAT
     D  i_data                             value like(R§SET0000 )                             RADDAT
     D  i_exclKeys                         value like(r§pgmCmd  ) DIM(25)                     RADDAT
      *                                                                                       RADDAT
      *-------------------------------------------------------------------*
     D f_NUM_Descr...                                                                         RADDAT
     D                 PR            10I 0                                                    RADDAT
     D  i_type                        3I 0 value                                              RADDAT
     D  i_length                      3I 0 value                                              RADDAT
     D  i_fraction                    3I 0 value                                              RADDAT
      *                                                                                       RADDAT
      *-------------------------------------------------------------------*                   RADDAT
     D f_NUM_Descr2...                                                                        RADDAT
     D                 PR            10I 0                                                    RADDAT
     D  i_type                        1A   value                                              RADDAT
     D  i_length                      3I 0 value                                              RADDAT
     D  i_fraction                    3I 0 value                                              RADDAT
      *                                                                                       RADDAT
      *-------------------------------------------------------------------*                   RADDAT
     D p_clrErrno...                                                                          RADDAT
     D                 PR                                                                     RADDAT
      *                                                                                       RADDAT
      *-------------------------------------------------------------------*                   RADDAT
     D f_errno...                                                                             RADDAT
     D                 PR            10I 0                                                    RADDAT
      *                                                                                       RADDAT
      *-------------------------------------------------------------------*                   RADDAT
     D f_strerror...                                                                          RADDAT
     D                 PR                         like(r§msgDta )                             RADDAT
     D  i_errno                      10I 0 const                                              RADDAT
      *                                                                                       RADDAT
      *-------------------------------------------------------------------*                   RADDAT
     D f_bitor...                                                                             RADDAT
     D                 PR            10U 0                                                    RADDAT
     D  i_arg1                       10U 0 value                                              RADDAT
     D  i_arg2                       10U 0 value                                              RADDAT
     D  i_arg3                       10U 0 value  options(*nopass)                            RADDAT
     D  i_arg4                       10U 0 value  options(*nopass)                            RADDAT
     D  i_arg5                       10U 0 value  options(*nopass)                            RADDAT
      *                                                                                       RADDAT
      *-------------------------------------------------------------------*                   RADDAT
     D f_rpgToIntLength...                                                                    RADDAT
     D                 PR            10I 0                                                    RADDAT
     D  i_length                     10I 0 value                                              RADDAT
      *                                                                                       RADDAT
      *-------------------------------------------------------------------*                   RADDAT
     D f_exist...                                                                             RADDAT
     D                 PR              N                                                      RADDAT
     D  i_obj                        10A   const                                              RADDAT
     D  i_lib                        10A   const  options(*omit)                              RADDAT
     D  i_type                       10A   const                                              RADDAT
     D  i_mbr                        10A   const  options(*nopass)                            RADDAT
      *                                                                                       RADDAT
      *-------------------------------------------------------------------*                   RADDAT
     D f_wordWrap...                                                                          RADDAT
     D                 PR          4096A          varying                                     RADDAT
     D  i_string                   4096A   const  varying                                     RADDAT
     D  i_width                      10U 0 const                                              RADDAT
     D  io_startPos                  10U 0                                                    RADDAT
     D  i_options                    10U 0 const  options(*nopass)                            RADDAT
      *                                                                                       RADDAT
      *-------------------------------------------------------------------*                   RADDAT
     D f_endsWith...                                                                          RADDAT
     D                 PR              N                                                      RADDAT
     D  i_suffix                   4096A   const   varying                                    RADDAT
     D  i_string                   4096A   const   varying                                    RADDAT
      *                                                                                       RADDAT
      *-------------------------------------------------------------------*                   RADDAT
      *  Converts a given string to upper case.                                               RADDAT
     D f_ucase...                                                                             RADDAT
     D                 PR          4096A           varying                                    RADDAT
     D  i_string                   4096A   const   varying                                    RADDAT
      *                                                                                       RADDAT
      *-------------------------------------------------------------------*                   RADDAT
      *  Sends a message to the command line.                                                 RADDAT
     D f_sndMsgToCmdLine...                                                                   RADDAT
     D                 PR                                                                     RADDAT
     D  i_msgID                       7A   const                                              RADDAT
     D  i_msgDta                    512A   const                                              RADDAT
      *                                                                                       RADDAT
      *-------------------------------------------------------------------*                   RADDAT
      *  Returns the field type as a string.                                                  RADDAT
     D f_fieldTypeAsString...                                                                 RADDAT
     D                 PR           128A          varying                                     RADDAT
     D  i_FLDL0100                         const  likeds(fldl0100_t)                          RADDAT
      *                                                                                       RADDAT
      *-------------------------------------------------------------------*                   RADDAT
      *  Returns the next headline.                                                           RADDAT
     D f_nextHeaderType...                                                                    RADDAT
     D                 PR            10A                                                      RADDAT
     D  i_headerType                 10A   value                                              RADDAT
      *
      *-------------------------------------------------------------------*                   RADDAT
      *  Returns the record format ID of a given file.
     D f_getRecordFormatInf...
     D                 PR                  likeds(r§rcdFmtInf)
     D  i_file                             value  like(r§file)
     D  i_library                          value  like(r§lib)
     D  i_rcdFmt                           value  like(r§fmtID)
      *
      *-------------------------------------------------------------------*
      *  Returns an empty string with a given length.
     D f_space...
     D                 PR          4096A   varying
     D  i_length                     10I 0 value
      *
      *-----------------------------------------------------------------*
      * Prototype for CEEDOD (Retrieve operational descriptor)
      *-----------------------------------------------------------------*
     D CEEDOD          PR
     D  ParmNum                      10I 0 CONST
     D  DescType                     10I 0
     D  DataType                     10I 0
     D  DescInfo1                    10I 0
     D  DescInfo2                    10I 0
     D  InLen                        10I 0
     D  fc                           12A   OPTIONS(*OMIT)
      *-------------------------------------------------------------------*
