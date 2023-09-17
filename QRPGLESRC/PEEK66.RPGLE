      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 3.1.0                               *
      *  Programm : PEEK65                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 31.07.2008  Raddatz                               *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Konvertieren Datenformat für Kurzbefehl                      *
      *                                                               *
      *===============================================================*
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_CLib
      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,FLDL0100
      /COPY QCOPYLE,D_MI
      *
     D numeric_t       S             31P10 based(pDummy)
     D cDATA_TYPE      C                   'P'
     D cDIGITS         C                   %len(numeric_t)
     D cDECPOS         C                   %decpos(numeric_t)
      *
     D cCHR_X          C                   'x'
     D cQUOTE          C                   ''''
      *----------------------------------------------------*
      *
      *---Nachrichten--------------------------------------*
      /COPY QCOPYLE,API_ERROR
      /COPY QCOPYLE,MSG_D_MAPI
      *----------------------------------------------------*
      *
      *---SDS-Datenstruktur--------------------------------*
      /COPY QCOPYLE,ERR_D_SDS
      *----------------------------------------------------*
      *
      *---API-Formate--------------------------------------*
      /COPY QCOPYLE,OBJD0400
      *----------------------------------------------------*
      *
      *----------------------------------------------------*
      *  Externe Prototypen                                *
      *----------------------------------------------------*
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      *
      *----------------------------------------------------*
      *  Interne Prototypen                                *
      *----------------------------------------------------*
     D main...
     D                 PR                  extproc('main')
     D  io_Buffer                                 like(XBuffer      )
     D  io_Length                                 like(XLength      )
     D  i_InFormat                         const  likeds(XInFormat  )
     D  i_OutFormat                        const  likeds(XOutFormat )
     D  o_MsgID                                   like(XMsgID       )
     D  o_MsgDta                                  like(XMsgDta      )
      *
      *  Convert from numeric value.
     D convertFromNumeric...
     D                 PR                  extproc('convertFromNumeric')
     D  io_Buffer                                 like(XBuffer      )
     D  io_Length                                 like(XLength      )
     D  i_OutFormat                        const  likeds(XOutFormat )
     D  o_MsgID                                   like(XMsgID       )
     D  o_MsgDta                                  like(XMsgDta      )
      *
      *  Convert from string value.
     D convertFromString...
     D                 PR                  extproc('convertFromString')
     D  io_Buffer                                 like(XBuffer      )
     D  io_Length                                 like(XLength      )
     D  i_OutFormat                        const  likeds(XOutFormat )
     D  o_MsgID                                   like(XMsgID       )
     D  o_MsgDta                                  like(XMsgDta      )
      *
      *  Convert to numeric value.
     D convertToNumeric...
     D                 PR                  extproc('convertToNumeric')
     D  io_Buffer                                 like(XBuffer      )
     D  io_Length                                 like(XLength      )
     D  i_OutFormat                        const  likeds(XOutFormat )
     D  o_MsgID                                   like(XMsgID       )
     D  o_MsgDta                                  like(XMsgDta      )
      *
      *  Convert to string value.
     D convertToString...
     D                 PR                  extproc('convertToString')
     D  io_Buffer                                 like(XBuffer      )
     D  io_Length                                 like(XLength      )
     D  i_OutFormat                        const  likeds(XOutFormat )
     D  o_MsgID                                   like(XMsgID       )
     D  o_MsgDta                                  like(XMsgDta      )
      *
      *----------------------------------------------------*
      *  F E L D - D E F I N I T I O N E N                 *
      *----------------------------------------------------*
      *
      *  *ENTRY Liste
     D XBuffer         S                   like(r§cmdBuffer )
     D XLength         S                   like(R§INT4      )
     D XInFormat       DS                  likeds(FLDL0100_t)
     D XOutFormat      DS                  likeds(FLDL0100_t)
     D XMsgID          S                   like(r§msgID     )
     D XMsgDta         S                   like(r§msgDta    )
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
      * ENTRY-LISTE
     C     *ENTRY        PLIST
     C                   PARM                    XBuffer
     C                   PARM                    XLength
     C                   PARM                    XInFormat
     C                   PARM                    XOutFormat
     C                   PARM                    XMsgID
     C                   PARM                    XMsgDta
      *
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         main(XBuffer
              : XLength
              : XInFormat
              : XOutFormat
              : XMsgID
              : XMsgDta);

         return;

         // -----------------------------------------------
         //    Global error handler
         // -----------------------------------------------
         begsr *PSSR;

            dump;

         endsr;

      /END-FREE
      *
      *========================================================================*
      *  Main - Prozedur
      *========================================================================*
     P main...
     P                 B
      *
     D main...
     D                 PI
     D  io_Buffer                                 like(XBuffer      )
     D  io_Length                                 like(XLength      )
     D  i_InFormat                         const  likeds(XInFormat  )
     D  i_OutFormat                        const  likeds(XOutFormat )
     D  o_MsgID                                   like(XMsgID       )
     D  o_MsgDta                                  like(XMsgDta      )
      *
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         clear o_MsgID;
         clear o_MsgDta;

         if (f_isNumFld(i_InFormat) = bTrue);
            convertFromNumeric(io_Buffer: io_Length: i_OutFormat
                               : o_MsgID: o_MsgDta);
         else;
            convertFromString(io_Buffer: io_Length: i_OutFormat
                               : o_MsgID: o_MsgDta);
         endif;

         return;

      /END-FREE
      *
     P main...
     P                 E
      *
      *========================================================================*
      *  Convert from numeric value.
      *========================================================================*
     P convertFromNumeric...
     P                 B
      *
     D convertFromNumeric...
     D                 PI
     D  io_Buffer                                 like(XBuffer      )
     D  io_Length                                 like(XLength      )
     D  i_OutFormat                        const  likeds(XOutFormat )
     D  o_MsgID                                   like(XMsgID       )
     D  o_MsgDta                                  like(XMsgDta      )
      *
      *  Arbeitsfelder
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         if (f_isNumFld(i_OutFormat) = bTrue);
            convertToNumeric(io_Buffer: io_Length: i_OutFormat
                             : o_MsgID: o_MsgDta);
         else;
            convertToString(io_Buffer: io_Length: i_OutFormat
                            : o_MsgID: o_MsgDta);
         endif;

         return;

      /END-FREE
      *
     P convertFromNumeric...
     P                 E
      *
      *========================================================================*
      *  Convert from string value.
      *========================================================================*
     P convertFromString...
     P                 B
      *
     D convertFromString...
     D                 PI
     D  io_Buffer                                 like(XBuffer      )
     D  io_Length                                 like(XLength      )
     D  i_OutFormat                        const  likeds(XOutFormat )
     D  o_MsgID                                   like(XMsgID       )
     D  o_MsgDta                                  like(XMsgDta      )
      *
      *  Arbeitsfelder
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         if (f_isNumFld(i_OutFormat) = bTrue);
            convertToNumeric(io_Buffer: io_Length: i_OutFormat
                             : o_MsgID: o_MsgDta);
         else;
            convertToString(io_Buffer: io_Length: i_OutFormat
                            : o_MsgID: o_MsgDta);
         endif;

         return;

      /END-FREE
      *
     P convertFromString...
     P                 E
      *
      *========================================================================*
      *  Convert to numeric value.
      *========================================================================*
     P convertToNumeric...
     P                 B
      *
     D convertToNumeric...
     D                 PI
     D  io_Buffer                                 like(XBuffer      )
     D  io_Length                                 like(XLength      )
     D  i_OutFormat                        const  likeds(XOutFormat )
     D  o_MsgID                                   like(XMsgID       )
     D  o_MsgDta                                  like(XMsgDta      )
      *
      *  Arbeitsfelder
     D isOneByteInt    S                   like(r§bool    )
     D oneByteIntAdjust...
     D                 S             10I 0
     D inNumeric       S                   like(numeric_t )
     D tmpBuffer       S                   like(io_Buffer )
     D digits          S             10I 0
      *
      *  Nachrichten
      /COPY QCOPYLE,USR8227
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         monitor;
            inNumeric = %dec(%subst(io_Buffer: 1: io_Length): cDIGITS: cDECPOS);
         on-error;
            clear USR8227;
            USR82271 = %subst(io_Buffer: 1: io_length);
            USR82272 = cDATA_TYPE;
            USR82273 = cDIGITS;
            USR82274 = cDECPOS;
            o_MsgID  = 'USR8227';
            o_MsgDta = USR8227;
            return;
         endmon;

         if ((i_OutFormat.F1DTYP = 'B' or
              i_OutFormat.F1DTYP = 'I' or
              i_OutFormat.F1DTYP = 'U')
            and f_rpgToIntLength(i_OutFormat.F1DIGT) = 1);
            isOneByteInt = bTrue;
            oneByteIntAdjust = 1;
         else;
            isOneByteInt = bFalse;
            oneByteIntAdjust = 0;
         endif;

         if (f_isFloatFld(i_outFormat) = bTrue);
            digits = i_OutFormat.F1FLEN;
         else;
            digits = i_OutFormat.F1DIGT;
         endif;

         clear io_Buffer;
         clear io_Length;

         cpynv(f_NUM_Descr2(i_OutFormat.F1DTYP
                            : digits + oneByteIntAdjust
                            : i_OutFormat.F1DECP)
               : %addr(io_Buffer)
               : f_NUM_Descr2(cDATA_TYPE
                              : %len(inNumeric)
                              : %decpos(inNumeric))
               : %addr(inNumeric));

         if (isOneByteInt = bTrue);
            %subst(io_Buffer: 1: 1) = %subst(io_Buffer: 2: 1);
            %subst(io_Buffer: 2: 1) = x'00';
         endif;

         select;
         when (i_OutFormat.F1DTYP = 'B' or
               i_OutFormat.F1DTYP = 'I' or
               i_OutFormat.F1DTYP = 'U');
            io_Length = f_rpgToIntLength(i_OutFormat.F1DIGT);
         when (i_OutFormat.F1DTYP = 'P');
            io_Length = %int(i_OutFormat.F1DIGT / 2) + 1;
         when (i_OutFormat.F1DTYP = 'S');
            io_Length = i_OutFormat.F1DIGT;
         when (i_OutFormat.F1DTYP = 'F');
            io_Length = i_OutFormat.F1FLEN;
         endsl;

         cvthc(%addr(tmpBuffer): %addr(io_Buffer): io_Length * 2);
         io_Length = io_Length * 2;
         io_Buffer = %subst(tmpBuffer: 1: io_Length);

         io_Buffer = cCHR_X + cQUOTE + %subst(io_Buffer: 1: io_Length) + cQUOTE;
         io_Length = io_Length + %len(cCHR_X) + %len(cQUOTE) * 2;

         return;

      /END-FREE
      *
     P convertToNumeric...
     P                 E
      *
      *========================================================================*
      *  Convert to string value.
      *========================================================================*
     P convertToString...
     P                 B
      *
     D convertToString...
     D                 PI
     D  io_Buffer                                 like(XBuffer      )
     D  io_Length                                 like(XLength      )
     D  i_OutFormat                        const  likeds(XOutFormat )
     D  o_MsgID                                   like(XMsgID       )
     D  o_MsgDta                                  like(XMsgDta      )
      *
      *  Arbeitsfelder
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         io_Buffer = %subst(io_Buffer: 1: i_OutFormat.F1FLEN);
         io_Length = i_OutFormat.F1FLEN;

         // io_Buffer = cQUOTE + %subst(io_Buffer: 1: io_Length) + cQUOTE;
         // io_Length = io_Length + %len(cQUOTE) * 2;

         return;

      /END-FREE
      *
     P convertToString...
     P                 E
      *
