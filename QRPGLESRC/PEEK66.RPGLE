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
      * ============================================================= *
      * >>PRE-COMPILER<<                                              *
      *   >>CRTCMD<< &LI/CRTPEEKOBJ SRCFILE(&SL/&SF) SRCMBR(&SM) +    *
      *                           OBJLIB(&LI) DEVLIB(&LI) +           *
      *                           SBMJOB(*NO) BNDDIR(PEEK) +          *
      *                           INSTALL(*NO);                       *
      *   >>EXECUTE<<                                                 *
      * >>END-PRE-COMPILER<<                                          *
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
      /define internal_prototype
      /COPY QCOPYLE,PPEEK66
      /undefine internal_prototype
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
     D  io_Buffer                                 like(gio_buffer)
     D  io_Length                                 like(gio_length)
     D  i_InFormat                         const  likeds(gi_inFormat)
     D  i_OutFormat                        const  likeds(gi_outFormat)
     D  o_MsgID                                   like(go_msgID)
     D  o_MsgDta                                  like(go_msgDta)
      *
      *  Convert from numeric value.
     D convertFromNumeric...
     D                 PR                  extproc('convertFromNumeric')
     D  io_Buffer                                 like(gio_buffer)
     D  io_Length                                 like(gio_length)
     D  i_OutFormat                        const  likeds(gi_outFormat)
     D  o_MsgID                                   like(go_msgID)
     D  o_MsgDta                                  like(go_msgDta)
      *
      *  Convert from string value.
     D convertFromString...
     D                 PR                  extproc('convertFromString')
     D  io_Buffer                                 like(gio_buffer)
     D  io_Length                                 like(gio_length)
     D  i_OutFormat                        const  likeds(gi_outFormat )
     D  o_MsgID                                   like(go_msgID)
     D  o_MsgDta                                  like(go_msgDta)
      *
      *  Convert to numeric value.
     D convertToNumeric...
     D                 PR                  extproc('convertToNumeric')
     D  io_Buffer                                 like(gio_buffer)
     D  io_Length                                 like(gio_length)
     D  i_OutFormat                        const  likeds(gi_outFormat )
     D  o_MsgID                                   like(go_msgID)
     D  o_MsgDta                                  like(go_msgDta)
      *
      *  Convert to string value.
     D convertToString...
     D                 PR                  extproc('convertToString')
     D  io_Buffer                                 like(gio_buffer)
     D  io_Length                                 like(gio_length)
     D  i_OutFormat                        const  likeds(gi_outFormat)
     D  o_MsgID                                   like(go_msgID)
     D  o_MsgDta                                  like(go_msgDta)
      *
      /COPY QCOPYLE,CEECNDHDLR
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
      * ENTRY-LISTE
     D PEEK66          PI
     D  gio_buffer                               like(cmdBuffer_t)
     D  gio_length                               like(int4_t)
     D  gi_inFormat                        const likeds(FLDL0100_t)
     D  gi_outFormat                       const likeds(FLDL0100_t)
     D  go_msgID                                 like(msgID_t)
     D  go_msgDta                                like(msgDta_t)
      *
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         //  Register error handler
         CEEHDLR(%paddr('errorHandler'): *null: *omit);

         main(gio_buffer
              : gio_length
              : gi_inFormat
              : gi_outFormat
              : go_msgID
              : go_msgDta);

         return;

      /END-FREE
      *
      *========================================================================*
      *  Main - Prozedur
      *========================================================================*
     P main...
     P                 B
     D                 PI
     D  io_Buffer                                 like(gio_buffer)
     D  io_Length                                 like(gio_length)
     D  i_InFormat                         const  likeds(gi_inFormat)
     D  i_OutFormat                        const  likeds(gi_outFormat)
     D  o_MsgID                                   like(go_msgID)
     D  o_MsgDta                                  like(go_msgDta)
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
     P                 E
      *
      *========================================================================*
      *  Convert from numeric value.
      *========================================================================*
     P convertFromNumeric...
     P                 B
     D                 PI
     D  io_Buffer                                 like(gio_buffer)
     D  io_Length                                 like(gio_length)
     D  i_OutFormat                        const  likeds(gi_outFormat)
     D  o_MsgID                                   like(go_msgID)
     D  o_MsgDta                                  like(go_msgDta)
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
     P                 E
      *
      *========================================================================*
      *  Convert from string value.
      *========================================================================*
     P convertFromString...
     P                 B
     D                 PI
     D  io_Buffer                                 like(gio_buffer)
     D  io_Length                                 like(gio_length)
     D  i_OutFormat                        const  likeds(gi_outFormat)
     D  o_MsgID                                   like(go_msgID)
     D  o_MsgDta                                  like(go_msgDta)
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
     P                 E
      *
      *========================================================================*
      *  Convert to numeric value.
      *========================================================================*
     P convertToNumeric...
     P                 B
     D                 PI
     D  io_Buffer                                 like(gio_buffer)
     D  io_Length                                 like(gio_length)
     D  i_OutFormat                        const  likeds(gi_outFormat)
     D  o_MsgID                                   like(go_msgID)
     D  o_MsgDta                                  like(go_msgDta)
      *
      *  Arbeitsfelder
     D isOneByteInt    S                   like(bool_t)
     D oneByteIntAdjust...
     D                 S             10I 0
     D inNumeric       S                   like(numeric_t)
     D tmpBuffer       S                   like(io_Buffer)
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
     P                 E
      *
      *========================================================================*
      *  Convert to string value.
      *========================================================================*
     P convertToString...
     P                 B
     D                 PI
     D  io_Buffer                                 like(gio_buffer)
     D  io_Length                                 like(gio_length)
     D  i_OutFormat                        const  likeds(gi_outFormat)
     D  o_MsgID                                   like(go_msgID)
     D  o_MsgDta                                  like(go_msgDta)
      *
      *  Arbeitsfelder
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         io_Buffer = %subst(io_Buffer: 1: i_OutFormat.F1FLEN);
         io_Length = i_OutFormat.F1FLEN;

         return;

      /END-FREE
      *
     P                 E
      *
      *============================================================*
      *  Program error handler                                     *
      *============================================================*
      *
     P errorHandler    b
     D                 pi
     D i_condToken                         value likeds(cee_fc_t)
     D i_pCommArea                   10i 0 value
     D o_action                      10i 0
     D o_newCondToken                            likeds(cee_fc_t)
      /free

         dump;
         o_action = CEE_PERCOLATE;

      /end-free
     P                 e
      *
