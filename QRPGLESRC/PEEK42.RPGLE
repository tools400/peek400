      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 1.4.0                               *
      *  Programm : PEEK42                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 14.04.98  Raddatz                                 *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Verarbeiten einer Kurzauswahl                                *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Gültige Ersatzvariablen:                                     *
      *  ------------------------                                     *
      *     &L           - Bibliothek der geöffneten Datei            *
      *     &F           - Name der geöffneten Datei                  *
      *     &N           - Name der Teildatei                         *
      *     &R           - Relative Satznummer                        *
      *     % + Feldname - Wert des angegebenen Feldes                *
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
      * Aufbau des Satzformats
     FPEEKFLD   IF   E           K DISK    USROPN
     F                                     PREFIX(F_)
      *
     D IO_Buff         DS
     D  IO_BuffFld                         like(rcdBuf_t)
      *
     D IO_NullMap      S                   like(nullMap_t)
     D                                     dim(NULL_MAP_SIZE)
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      *----------------------------------------------------*
      *
      /define internal_prototype
      /COPY QCOPYLE,PPEEK42
      /undefine internal_prototype
      *
      *---ShortCmd-----------------------------------------*
      /COPY QCOPYLE,ShortCmd_d
      *----------------------------------------------------*
      *
      *---C-Library----------------------------------------*
      /COPY QCOPYLE,D_CLIB
      *----------------------------------------------------*
      *
      *---SDS-Datenstruktur--------------------------------*
      /COPY QCOPYLE,ERR_D_SDS
      *----------------------------------------------------*
      *
      *----------------------------------------------------*
      *  Externe Prototypen                                *
      *----------------------------------------------------*
      /COPY QCOPYLE,PPEEK06
      /COPY QCOPYLE,PPEEK66
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      /COPY QCOPYLE,F_PEEK63
      *
      *----------------------------------------------------*
      *  Interne Prototypen                                *
      *----------------------------------------------------*
     D lf_rtvFldName...
     D                 PR            10A   varying
     D  i_buffer                           const  like(R_ShortCmd  )
     D  i_startPos                         const  like(INT4_t)
      *
     D lf_rtvFldFormat...
     D                 PR                         like(bool_t)
     D  io_buffer                                 like(R_ShortCmd  )
     D  i_startPos                         const  like(INT4_t)
     D  o_FLDL0100                                likeds(FLDL0100_t)
     D  o_MsgID                                   like(msgID_t)
     D  o_msgDta                                  like(msgDta_t)
      *
     D lf_loadFldAtr...
     D                 PR             1A
     D  i_fldName                    10A   const
     D  o_fldl0100                         likeds(FLDL0100_t)
      *
      *----------------------------------------------------*
      *  F E L D - D E F I N I T I O N E N                 *
      *----------------------------------------------------*
      *
     D isInit          S                   like(bool_t) inz(bFalse)
     D isRecord        S                   like(bool_t) inz(bFalse)
      *
     D R_File          S                   LIKE(ShortCmd_t.SC_File) inz
     D R_Lib           S                   LIKE(ShortCmd_t.SC_Lib) inz
     D R_Mbr           S                   LIKE(ShortCmd_t.SC_Mbr) inz
     D R_ShortCmd      S                   LIKE(o_execCmd  ) INZ(*BLANKS)
     D R_Cmd1          S          32702A   varying          INZ(*BLANKS)
     D R_Cmd2          S          32702A   varying          INZ(*BLANKS)
     D R_MaxLen        C                   CONST(256)
     D R_Var           S             10A   varying          inz(*BLANKS)
     D R_Value         S          32766A   varying          inz('')
     D S               S                   like(int4_t) inz
     D I               S                   like(int4_t) inz
     D fldName         S             10A   varying          inz(*BLANKS)
     D isOutFormat     S                   like(bool_t) inz(bFalse)
     D ShortCmd        DS                  likeds(ShortCmd_t) inz
     D FLDL0100        DS                  likeds(FLDL0100_t) inz
     D FLDL0100_OUT    DS                  likeds(FLDL0100_t) inz
      /COPY QCOPYLE,FLDL0100
      *
     D PEEK06_NAME     S                   like(pgmCallN_t) inz
     D PEEK66_NAME     S                   like(pgmCallN_t) inz
      *
      *  Parameterliste PEEK06
     D yOutBuffer      S                   LIKE(RCDBUF_t)
     D YOutBuffLn      S                   like(INT4_t) INZ
     D YMsgID          S                   like(msgID_t) INZ(*BLANKS)
     D YMsgDta         S                   like(msgDta_t) INZ(*BLANKS)
      *
     D cNAME_PREFIX    C                   const('%')
     D cFORMAT_START   C                   const('(')
     D cFORMAT_END     C                   const(')')
     D cFORMAT_DELIMITER...
     D                 C                   const(',')
      *
      * Für Einzelsatzzugriff
     D hFile00         DS                   likeds(hFile_t)
      *
      /COPY QCOPYLE,CEECNDHDLR
      *
     D isInzSr         S                   like(bool_t) inz(bFalse)
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     D PEEK42          PI
     D  i_file                             const like(file_t)
     D  i_library                          const like(lib_t)
     D  i_member                           const like(mbr_t)
     D  i_rcdFormat                        const like(fmt_t)
     D  i_shortCmd                         const like(ShortCmd_t)
     D  i_rcdNbr                           const like(rcdNbr_t)
     D  o_execCmd                                like(cmdBuffer_t)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
      *---------------------------------------------------*
      *
      *  Register error handler
     C                   callp     CEEHDLR(%paddr('errorHandler')
     C                                     : *null: *omit)
      *
     C                   EXSR      InzSr
      *
     C                   EXSR      FIRST
      *
     C                   SELECT
      * Initialisierung
     C                   when      (ShortCmd.SC_Action = '*INIT')
     C                   EVAL      R_File = ShortCmd.SC_File
     C                   EVAL      R_Lib = ShortCmd.SC_Lib
     C                   EVAL      R_Mbr = ShortCmd.SC_Mbr
     C                   EVAL      IsInit = bTrue
      * Befehl
     C                   when      (ShortCmd.SC_Action = '*CMD')
     C                   EXSR      BuildCmd
      *  Unbekannte Aktion
     C                   OTHER
     C                   Callp     p_kill('Unknown short command action: ' +
     C                                    ShortCmd.SC_Action)
     C                   Endsl
      *
     C     ENDE          TAG
      *
     C                   RETURN
      *
      *============================================================*
      *    BuildCmd      Aufbereiten des auszuführenden Befehls    *
      *============================================================*
      *
     C     BuildCmd      BEGSR
      *
     C                   EVAL      R_ShortCmd = ShortCmd.SC_Cmd
      *
     C     IsInit        IFEQ      bFalse
      *  keine Initialisierung
     C                   ELSE
     C                   EXSR      Rpl_File
     C                   EXSR      Rpl_Lib
     C                   EXSR      Rpl_Mbr
     C                   EXSR      Rpl_Rrn
     C                   EXSR      Rpl_FldName
     C                   Endif
      *
     C                   EVAL      o_execCmd = R_ShortCmd
      *
     C                   ENDSR
      *
      *============================================================*
      *    Rpl_File      Ersetzen der Ersatzvariablen &F           *
      *============================================================*
      *
     C     Rpl_File      BEGSR
      *
     C                   EVAL      R_Var   = '&F'
     C                   EVAL      R_Value = %trimr(R_File)
     C                   EXSR      Rpl_Var
      *
     C                   ENDSR
      *
      *============================================================*
      *    Rpl_Lib       Ersetzen der Ersatzvariablen &L           *
      *============================================================*
      *
     C     Rpl_Lib       BEGSR
      *
     C                   EVAL      R_Var   = '&L'
     C                   EVAL      R_Value = %trimr(R_Lib)
     C                   EXSR      Rpl_Var
      *
     C                   ENDSR
      *
      *============================================================*
      *    Rpl_Mbr       Ersetzen der Ersatzvariablen &N           *
      *============================================================*
      *
     C     Rpl_Mbr       BEGSR
      *
     C                   EVAL      R_Var   = '&N'
     C                   EVAL      R_Value = %trimr(R_Mbr)
     C                   EXSR      Rpl_Var
      *
     C                   ENDSR
      *
      *============================================================*
      *    Rpl_Rrn       Ersetzen der Ersatzvariablen &R           *
      *============================================================*
      *
     C     Rpl_Rrn       BEGSR
      *
     C                   EVAL      R_Var   = '&R'
     C                   EVAL      R_Value = %trimr(%editc(i_rcdNbr: 'X'))
     C                   EXSR      Rpl_Var
      *
     C                   ENDSR
      *
      *============================================================*
      *    Rpl_FldName   Ersetzen der Ersatzvariablen %*           *
      *============================================================*
      *
     C     Rpl_FldName   BEGSR
      *
     C                   IF        CIO_open(hFile00
     C                                      : i_file
     C                                      : i_library
     C                                      : i_member
     C                                      : ''
     C                                      : 'rr, arrseq=Y, commit=N, +
     C                                         nullcap=Y, riofb=Y, +
     C                                         secure=Y') = bFalse
     C                   EVAL      isRecord = bFalse
     C                   GOTO      ERpl_FldName
     C                   ENDIF
      *
     C                   FOR       i = 1 to %len(R_ShortCmd)
      *
     C                   IF        %subst(R_ShortCmd: i: 1) = cNAME_PREFIX
      *
     C                   EXSR      ReadRcd
     C                   IF        isRecord = bFalse
     C                   LEAVE
     C                   ENDIF
      *
     C                   IF        not %open(PEEKFLD)
     C                   OPEN      PEEKFLD
     C                   ENDIF
      *
     C                   EVAL      fldName = lf_rtvFldName(R_ShortCmd: i)
     C                   IF        (fldName <> '') and
     C                             (lf_loadFldAtr(fldName: FLDL0100) = bTrue)
      *
     C                   monitor
     C                   CALLP     PEEK06(FLDL0100: 'FLDL0100': IO_Buff
     C                                    : bTrue: bTrue
     C                                    : yOutBuffer: YOutBuffLn
     C                                    : YMsgID: YMsgDta)
     C                   eval      *in99 = bFalse
     C                   on-error
     C                   eval      *in99 = bTrue
     C                   endmon
      *
     C                   EVAL      isOutFormat = lf_rtvFldFormat(
     C                                              R_ShortCmd
     C                                              : i+%len(%trimR(fldName))+1
     C                                              : FLDL0100_OUT
     C                                              : yMsgID
     C                                              : yMsgDta)
      *
     C                   IF        (YMsgID <> '')
     C                   EVAL      o_msgID  = YMsgID
     C                   EVAL      o_msgDta = YMsgDta
     C                   GOTO      ERpl_FldName
     C                   ENDIF
      *
     C                   EVAL      R_Var = cNAME_PREFIX + fldName
      *
     C                   IF        (isOutFormat = bFalse)
     C                   EVAL      R_Value = %trimR(%subst(yOutBuffer :
     C                                                     1          :
     C                                                     YOutBuffLn ))
     C                   ELSE
      *
     C                   monitor
     C                   callp     PEEK66(yOutBuffer: YOutBuffLn
     C                                    : FLDL0100: FLDL0100_OUT
     C                                    : YMsgID: YMsgDta)
     C                   eval      *in99 = bFalse
     C                   on-error
     C                   eval      *in99 = bTrue
     C                   endmon
      *
     C                   IF        (YMsgID <> '')
     C                   EVAL      o_msgID  = YMsgID
     C                   EVAL      o_msgDta = YMsgDta
     C                   GOTO      ERpl_FldName
     C                   ENDIF
      *
     C                   EVAL      R_Value = %subst(yOutBuffer :
     C                                              1          :
     C                                              YOutBuffLn )
     C                   ENDIF
      *
     C                   EVAL      R_ShortCmd = %replace(R_Value
     C                                                   : R_ShortCmd
     C                                                   : i
     C                                                   : %len(R_Var))
     C                   ENDIF
      *
     C                   ENDIF
      *
     C                   ENDFOR
      *
     C     ERpl_FldName  TAG
      *
     C                   IF        CIO_isOpen(hFile00) = bTrue
     C                   CALLP     CIO_close(hFile00)
     C                   ENDIF
      *
     C                   IF        %open(PEEKFLD)
     C                   CLOSE     PEEKFLD
     C                   ENDIF
      *
     C                   ENDSR
      *
      *============================================================*
      *    Rpl_Var       Ersetzen der Ersatzvariablen              *
      *============================================================*
      *
     C     Rpl_Var       BEGSR
      *
     C                   EVAL      S = 1
      *
     C                   DOU       S = 0
      *
     C                   EVAL      S = %scan(R_Var: R_ShortCmd: S)
     C     S             IFEQ      *ZEROS
      *  Nix gefunden ...
     C                   ELSE
      *  Variable ersetzen ...
      *  ... extrahieren 1. Teil
     C                   EVAL      S = S - 1
     C                   IF        (S <= 0)
     C                   EVAL      R_Cmd1 = ''
     C                   ELSE
     C                   EVAL      R_Cmd1 = %subst(R_ShortCmd: 1: S)
     C                   Endif
      *
      *  ... extrahieren 2. Teil
     C                   EVAL      S = S + 1 + %len(R_Var)
     C     S             IFGT      R_MaxLen
     C                   EVAL      R_Cmd2 = ''
     C                   ELSE
     C                   EVAL      R_Cmd2 = %trimr(%subst(R_ShortCmd: S))
     C                   Endif
      *
      *  ... zusammenführen Teil 1, Variable und Teil 2
     C                   EVAL      R_ShortCmd = R_Cmd1 + R_Value + R_Cmd2
      *
     C                   Endif
      *
     C                   Enddo
      *
     C                   ENDSR
      *
      *============================================================*
      *    ReadRcd       Einlesen des anzuzeigenden Satzes         *
      *============================================================*
      *
     C     ReadRcd       BEGSR
      *
     C                   IF        CIO_chainWithRRN(hFile00
     C                                              : i_rcdNbr
     C                                              : bFalse
     C                                              : IO_Buff
     C                                              : IO_NullMap) = bFalse
     C                   EVAL      isRecord = bFalse
     C                   ELSE
     C                   EVAL      isRecord = bTrue
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    First         Initialisierung                           *
      *============================================================*
      *
     C     First         BEGSR
      *
      * - Programm initialisieren
      ***                Callp     p_rmvPgmMg(§§pgmName)
      *
     C                   EVAL      o_msgID = *BLANKS
     C                   EVAL      o_msgDta = *BLANKS
      *
     C                   EVAL      ShortCmd = i_shortCmd
      *
     C                   ENDSR
      *
      *====================================================*
      *  InzSr --  Initialize program                      *
      *====================================================*
      *
     C     InzSr         Begsr
      *
     C                   If        (isInzSr = bTrue)
     C                   Leavesr
     C                   Endif
      *
     C                   Eval      isInzSr = bTrue
      *
     C                   EVAL      IsInit = bFalse
      *
     C                   Eval      PEEK06_NAME = f_pgmCallN('PEEK06')
     C                   Eval      PEEK66_NAME = f_pgmCallN('PEEK66')
      *
     C                   ENDSR
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
      *============================================================*
      *    Ermitteln Feldname aus Kurzbefehl                       *
      *============================================================*
     P lf_rtvFldName...
     P                 B
     D                 PI            10A   varying
     D  i_buffer                           const  like(R_ShortCmd  )
     D  i_startPos                         const  like(INT4_t)
      *
      *  Funktionswert
     D fldName         S             10A                inz
      *
      *  Arbeitsfelder
     D i               S                   like(INT4_t) inz
      *
      *  Gültige Zeichen für Feldnamen
     D cCHARS          C                   const('_$#§-
     D                                     ABCDEFGHIJKLMNOPQRSTUVWXYZ-
     D                                     1234567890')
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      *
     C                   eval      fldName = ''
      *
     C                   for       i = i_startPos + 1 to %len(i_buffer)
     C                   if        %scan(%subst(i_buffer: i: 1): cCHARS) = 0
     C                   leave
     C                   endif
      *
     C                   eval      fldName = %trimR(fldName) +
     C                                       %subst(i_buffer: i: 1)
     C                   endfor
      *
     C                   return    %trimr(fldName)
      *
     P                 E
      *
      *============================================================*
      *    Ermitteln Feldformat                                    *
      *============================================================*
     P lf_rtvFldFormat...
     P                 B
     D                 PI                         like(bool_t)
     D  io_buffer                                 like(R_ShortCmd  )
     D  i_startPos                         const  like(INT4_t)
     D  o_FLDL0100                                likeds(FLDL0100_t)
     D  o_MsgID                                   like(msgID_t)
     D  o_msgDta                                  like(msgDta_t)
      *
      *  Arbeitsfelder
     D s               S                   like(int4_t) inz
     D e               S                   like(int4_t) inz
     D l               S                   like(int4_t) inz
     D strFormat       S            256A   inz
     D data            DS                  qualified inz
     D  type                          1A
     D  length                       10I 0
     D  decPos                       10I 0
     D pToken          S               *   inz
     D FLDL0100_TMP    DS                  likeds(FLDL0100_t) inz
      *
      *  Nachrichten
      /COPY QCOPYLE,USR8228
      /COPY QCOPYLE,USR8229
      /COPY QCOPYLE,USR8230
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         clear o_FLDL0100;
         clear o_MsgID;
         clear o_msgDta;

         if (i_startPos > %len(io_buffer) or
             %subst(io_buffer: i_startPos: 1) <> cFORMAT_START);
            return bFalse;
         endif;

         // Find end of format definition
         s = i_startPos;
         e = s;
         l = 0;

         dow (e <= %len(io_buffer));
            if (%subst(io_buffer: e: 1) = cFORMAT_END);
               l = e - s + 1;
               leave;
            else;
               e = e + 1;
            endif;
         enddo;

         // Get format without leading and trailing parenthesis
         strFormat = %subst(io_buffer: s+1: l-2);

         if (strFormat = '');
            return bFalse;
         endif;

         // Remove format definition from buffer
         io_buffer = %replace('': io_buffer: s: l);

         // Splitt format into data type, length and decimal positions
         pToken = strtok(strFormat: cFORMAT_DELIMITER);
         if (pToken <> *NULL);            // data type
            data.type = %str(pToken);
            pToken = strtok(*NULL: cFORMAT_DELIMITER);
         endif;

         if (pToken <> *NULL);            // field length
            monitor;
               data.length = %dec(%str(pToken): 10: 0);
            on-error;
               clear USR8229;
               USR82291 = %str(pToken);
               o_MsgID  = 'USR8229';
               o_msgDta = USR8229;
               return bFalse;
            endmon;
            pToken = strtok(*NULL: cFORMAT_DELIMITER);
         endif;

         if (pToken <> *NULL);            // decimal positions
            monitor;
               data.decPos = %dec(%str(pToken): 10: 0);
            on-error;
               clear USR8230;
               USR82301 = %str(pToken);
               o_MsgID  = 'USR8230';
               o_msgDta = USR8230;
               return bFalse;
            endmon;
         endif;

         // Compose new field type
         if lf_loadFldAtr(fldName: FLDL0100_TMP) = bFalse;
            return bFalse;
         endif;

         FLDL0100_TMP.F1DTYP = %xlate(cLOWER: cUPPER: data.type);
         if (f_isNotAlw(FLDL0100_TMP) = bTrue);
            clear USR8228;
            USR82281 = data.type;
            o_MsgID  = 'USR8228';
            o_msgDta = USR8228;
            return bFalse;
         endif;

         // Check data type
         if (f_isNotAlw(FLDL0100_TMP) = bTrue);
            return bFalse;
         endif;

         // Replace length and decimal position
         if (f_isNumFld(FLDL0100) = bTrue);
            FLDL0100_TMP.F1DECP = data.decPos;
            select;
            when (FLDL0100_TMP.F1DTYP = 'S');
               FLDL0100_TMP.F1DIGT = data.length;
               FLDL0100_TMP.F1FLEN = data.length;
            when (FLDL0100_TMP.F1DTYP = 'P');
               FLDL0100_TMP.F1DIGT = data.length;
               FLDL0100_TMP.F1FLEN = %int(data.length / 2);
               if (%rem(data.length: 2) <> 0);
                  FLDL0100_TMP.F1FLEN = FLDL0100_TMP.F1FLEN + 1;
               endif;
            when (FLDL0100_TMP.F1DTYP = 'B' or FLDL0100_TMP.F1DTYP = 'I');
               select;
               when (data.length <= 3);
                  FLDL0100_TMP.F1DIGT = 3;
                  FLDL0100_TMP.F1FLEN = 1;
               when (data.length <= 5);
                  FLDL0100_TMP.F1DIGT = 5;
                  FLDL0100_TMP.F1FLEN = 2;
               when (data.length <= 10);
                  FLDL0100_TMP.F1DIGT = 10;
                  FLDL0100_TMP.F1FLEN = 4;
               when (data.length <= 20);
                  FLDL0100_TMP.F1DIGT = 20;
                  FLDL0100_TMP.F1FLEN = 8;
               endsl;
            when (FLDL0100_TMP.F1DTYP = 'F');
               if (data.decPos <> 0);
                  clear USR8230;
                  USR82301 = %char(data.decPos);
                  o_MsgID  = 'USR8230';
                  o_msgDta = USR8230;
                  return bFalse;
               endif;
               select;
               when (data.length = 4);
                  FLDL0100_TMP.F1DIGT = 8;
                  FLDL0100_TMP.F1FLEN = 4;
                  FLDL0100_TMP.F1DECP = 7;
               when (data.length = 8);
                  FLDL0100_TMP.F1DIGT = 16;
                  FLDL0100_TMP.F1FLEN = 8;
                  FLDL0100_TMP.F1DECP = 15;
               other;
                  clear USR8229;
                  USR82291 = %char(data.length);
                  o_MsgID  = 'USR8229';
                  o_msgDta = USR8229;
                  return bFalse;
               endsl;
            endsl;
         else;
            FLDL0100_TMP.F1FLEN = data.length;
         endif;

         // Replace start position
         FLDL0100_TMP.F1OBUF = 1;
         FLDL0100_TMP.F1IBUF = 1;

         o_FLDL0100 = FLDL0100_TMP;

         return bTrue;

      /END-FREE
      *
     P                 E
      *
      *============================================================*
      *    Laden Feldattribute                                     *
      *============================================================*
     P lf_loadFldAtr...
     P                 B
     D                 PI             1A
     D  i_fldName                    10A   const
     D  o_fldl0100                         likeds(FLDL0100_t)
      *
      *  Funktionswert
     D isLoaded        S              1A                inz(bFalse)
      *
      *  Arbeitsfelder
     D FLDL0100        DS                  likeds(FLDL0100_t) inz
      *
      *----------------------------------------------------*
      *  Schlüsselliste für PEEKFLD
     C     F_KEY         KLIST
     C                   KFLD                    F_FIELD
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      *
     C                   EVAL      F_FIELD = i_fldName
     C     F_KEY         CHAIN     FPEEKFLD                           11
     C     *IN11         IFEQ      '0'
     C                   EVAL      FLDL0100 = F_FFD
     C                   EVAL      isLoaded = bTrue
     C                   ELSE
     C                   CLEAR                   FLDL0100
     C                   EVAL      isLoaded = bFalse
     C                   ENDIF
      *
     C                   eval      o_fldl0100 = FLDL0100
      *
     C                   return                  isLoaded
      *
     P                 E
      *
