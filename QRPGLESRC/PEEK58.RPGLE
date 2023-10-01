      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 2.2.0                               *
      *  Programm : PEEK058                                           *
      *  Typ      : RPGLE                                             *
      *                                                               *
      *  erstellt : 21.07.99  Raddatz                                 *
      *  geändert :                                                   *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Peek/400 - Allgemeine Routinen                               *
      *                                                               *
      *===============================================================*
      * >>PRE-COMPILER<<                                              *
      *   >>CRTCMD<< &LI/CRTPEEKOBJ SRCFILE(&SL/&SF) SRCMBR(&SM) +    *
      *                           OBJLIB(&LI) DEVLIB(&LI) +           *
      *                           SBMJOB(*NO) BNDDIR(PEEK) +          *
      *                           INSTALL(*NO);                       *
      *   >>EXECUTE<<                                                 *
      * >>END-PRE-COMPILER<<                                          *
      *===============================================================*
     H NOMAIN
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,FILD0100
      /COPY QCOPYLE,FLDL0100
      /COPY QCOPYLE,MBRD0100
      /COPY QCOPYLE,BSPF0100
      /COPY QCOPYLE,OBJD0100
      /COPY QCOPYLE,D_CLib
      /COPY QCOPYLE,F_PEEK53
      *----------------------------------------------------*

      *---INFOSTRUKTUR FÜR AID-BYTE -----------------------*
      /COPY QCOPYLE,DS_WORKSTN
      *----------------------------------------------------*
      *
      *---Eigener Prototyp---------------------------------*
      /COPY QCOPYLE,F_PEEK58
      *----------------------------------------------------*
      *
      *---Externe Prototypen-------------------------------*
      /COPY QCOPYLE,D_MI
      *
      /COPY QCOPYLE,QDBRTVFD
      /COPY QCOPYLE,QUSRJOBI
      *----------------------------------------------------*
      *
      /COPY QCOPYLE,PPEEK41
      *
     D PEEK41_NAME     S                   like(pgmCallN_t)
      *
      *  Performs word wrapping on a given string without respect to
      *  end-of-paragraph markers.
     D lf_wordWrap...
     D                 PR          4096A          varying
     D  i_string                   4096A   const  varying
     D  i_width                      10U 0 const
     D  io_startPos                  10U 0
      *
      *  Tests for one or more bits.
     D f_isBitOn...
     D                 PR              N
     D  i_testBit                    10U 0 value
     D  i_value                      10U 0 value
      *
      *---SDS-Datenstruktur--------------------------------*
      /COPY QCOPYLE,ERR_D_SDS
      *----------------------------------------------------*
      *
     D g_prdLib        S                   like(lib_t)
     D                                     inz
      *
     D g_jobCcsid      S             10U 0 inz(0)
      *
      *===================================================================*
      *  Funktion:  f_dsplyLn                                  (Body)     *
      *===================================================================*
      *
     P f_dsplyLn       B                   Export
     D                 PI                         like(int4_t)
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      *
      *  Funktionswert
     D fldLen          S                   like(int4_t)
      * ------------------------------------------------------------------------
      *
     C                   If        (i_FLDL0100.F1DTYP = 'G' and
     C                              i_FLDL0100.F1NDBC > 0)
     C                   Return    i_FLDL0100.F1NDBC
     C                   Endif
      *
     C                   Eval      fldLen = i_FLDL0100.F1FLEN
      *
     C                   If        i_FLDL0100.F1VFMI = '1'
      *  Variable Feldlänge ...
     C                   Eval      fldLen = fldLen - 2
     C                   Endif
      *
     C                   Return    fldLen
      *
     P                 E
      *
      *===================================================================*
      *  Funktion:  f_buffLn                                   (Body)     *
      *===================================================================*
      *
     P f_buffLn        B                   Export
     D                 PI                         like(int4_t)
     D  i_FLDL0100                         const  likeds(fldl0100_t)
     D  i_withLen                          const  like(bool_t)
     D                                            options(*nopass)
      *
      *  Parameterpositionen optionaler Parameter
     D p_withLen       C                   const(2)
      *
      *  Funktionswert
     D fldLen          S                   like(int4_t)
     D                                     inz
      *
      *  Arbeitsfelder
     D withLen         S                   like(i_withLen)
     D                                     inz
      * ------------------------------------------------------------------------
      *
     C                   If        %parms >= p_withLen
     C                   Eval      withLen  = i_withLen
     C                   Else
     C                   Eval      withLen  = bFalse
     C                   Endif
      *
     C                   If        i_FLDL0100.F1VFMI = '1'
      *  Variable Feldlänge ...
     C                   If        withLen = bTrue
      *  ... incl. Längenbyte
     C                   Eval      fldLen = i_FLDL0100.F1FLEN
     C                   Else
      *  ... ohne Längenbyte
     C                   Eval      fldLen = i_FLDL0100.F1FLEN - 2
     C                   Endif
     C                   Else
      *  Felder fester Länge
     C                   Eval      fldLen = i_FLDL0100.F1FLEN
     C                   Endif
      *
     C                   Return    fldLen
      *
     P                 E
      *
      *===================================================================*
      *  Funktion:  f_curFldLn                                 (Body)     *
      *===================================================================*
      *
     P f_curFldLn      B                   Export
     D                 PI                         like(int4_t)
     D  i_buffer                           const  like(rcdbuf_t)
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      *
      *  Funktionswert
     D curFldLn        S                   like(int4_t)
     D                                     inz
      * ------------------------------------------------------------------------
      *
     C                   If        i_FLDL0100.F1VFMI = '1'
     C                   Eval      curFldLn = f_binToDec(i_buffer
     C                                                   : i_FLDL0100.F1IBUF
     C                                                   : 2)
     C                   Else
     C                   if        (i_FLDL0100.F1NDBC > 0)
     C                   eval      curFldLn = i_FLDL0100.F1NDBC
     C                   else
     C                   Eval      curFldLn = i_FLDL0100.F1FLEN
     C                   endif
     C                   Endif
      *
     C                   Return    curFldLn
      *
     P                 E
      *
      *===================================================================*
      *  Funktion:  f_rtvFld                                   (Body)     *
      *===================================================================*
      *
     P f_rtvFld        B                   Export
     D                 PI                  opdesc like(int4_t)
     D  o_buffer                                  like(rcdbuf_t)
     D                                            options(*varsize)
     D  i_buffer                           const  like(rcdbuf_t)
     D  i_FLDL0100                         const  likeds(fldl0100_t)
     D  i_withLen                          const  like(bool_t)
     D                                            options(*nopass)
      *
      *  Parameterpositionen optionaler Parameter
     D p_withLen       C                   const(4)
      *
      *  Funktionswert
     D rtnLen          S                   like(int4_t)
     D                                     inz
      *
      * Parameters passed to CEEDOD
     D DescType        S             10I 0
     D DataType        S             10I 0
     D DescInfo1       S             10I 0
     D DescInfo2       S             10I 0
     D parmLen         S             10I 0
      *
      *  Arbeitsfelder
     D withLen         S                   like(i_withLen)
     D                                     inz
      * ------------------------------------------------------------------------
      *
     C                   CALLP     CEEDOD(1         : DescType : DataType :
     C                                    DescInfo1 : DescInfo2: parmLen  :
     C                                    *OMIT)
      *
     C                   If        %parms >= p_withLen
     C                   Eval      withLen  = i_withLen
     C                   Else
     C                   Eval      withLen  = bFalse
     C                   Endif
      *
     C                   Eval      rtnLen = f_buffLn(i_FLDL0100: withLen)
     C                   If        rtnLen > parmLen
     C                   Eval      rtnLen = parmLen
     C                   Endif
      *
     C                   If        i_FLDL0100.F1VFMI = '1'
     C                   If        withLen = bFalse
     C                   Eval      %subst(o_buffer: 1: parmLen) =
     C                             %subst(i_buffer: i_FLDL0100.F1IBUF+2: rtnLen)
     C                   Else
     C                   Eval      %subst(o_buffer: 1: parmLen) =
     C                             %subst(i_buffer: i_FLDL0100.F1IBUF  : rtnLen)
     C                   Endif
     C                   Else
     C                   Eval      %subst(o_buffer: 1: parmLen) =
     C                             %subst(i_buffer: i_FLDL0100.F1IBUF  : rtnLen)
     C                   Endif
      *
     C                   Return    rtnLen
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_fldToBuf                                 (Body)     *
      *===================================================================*
      *
     P p_fldToBuf      B                   Export
     D                 PI
     D  io_buffer                                 like(rcdbuf_t)
     D  i_fieldDta                                like(rcdbuf_t)
     D  i_FLDL0100                         const  likeds(fldl0100_t)
     D  i_withLen                          const  like(bool_t)
     D                                            options(*nopass)
      *
      *  Parameterpositionen optionaler Parameter
     D p_withLen       C                   const(4)
      *
      *  Arbeitsfelder
     D  withLen        S                   like(i_withLen)
     D                                     inz
      *
     D fieldDta        S                   like(rcdBuf_t)
     D                                     based(pFieldDta)
     D fieldDtaUcs2    S                   like(rcdBufUcs2_t)
     D                                     based(pFieldDta)
      *
     D                 DS
     D  buffLn                             like(int2_t)
     D  buffLnA                       2A   overlay(buffLn:  1)
      * ------------------------------------------------------------------------
     C                   Eval      pFieldDta = %addr(i_fieldDta)
      *
     C                   If        %parms >= p_withLen
     C                   Eval      withLen = i_withLen
     C                   Else
     C                   Eval      withLen = bFalse
     C                   Endif
      *
     C                   If        i_FLDL0100.F1VFMI = '1'
      *  Felder variabler Länge ...
     C                   If        withLen = bFalse
      *  ... ohne Längenangabe
      *      (einfügen Längenangabe)
     C
     C                   If        (i_FLDL0100.F1DTYP = 'G')
     C                   Eval      buffLn = %len(%trimr(
     C                                           %subst(fieldDtaUcs2
     C                                                  : 1
     C                                                  : f_dsplyLn(i_FLDL0100))
     C                                                  )) * 2
     C                   Else
     C                   Eval      buffLn = %len(%trimr(
     C                                           fieldDta))
     C                   Endif
      *
     C                   Eval      %subst(io_buffer  :
     C                                    i_FLDL0100.F1IBuf+2 :
     C                                    f_buffLn(i_FLDL0100: withLen))
     C                                       = i_fieldDta
      *
     C                   If        (i_FLDL0100.F1DTYP = 'G' and
     C                              i_FLDL0100.F1NDBC > 0)
     C                   Eval      buffLn = buffLn / 2
     C                   Endif
      *
     C                   Eval      %subst(io_buffer  :
     C                                    i_FLDL0100.F1IBuf   :
     C                                    2          )
     C                                       = buffLnA
     C                   Else
      *  ... incl. Längenangabe
     C                   Eval      %subst(io_buffer  :
     C                                    i_FLDL0100.F1IBuf   :
     C                                    f_buffLn(i_FLDL0100: withLen))
     C                                       = i_fieldDta
     C                   Endif
     C                   Else
      *  Felder fester Länge ...
     C                   Eval      %subst(io_buffer  :
     C                                    i_FLDL0100.F1IBuf   :
     C                                    f_buffLn(i_FLDL0100))
     C                                       = i_fieldDta
     C                   Endif
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Funktion:  f_isVarLen                                 (Body)     *
      *===================================================================*
      *
     P f_isVarLen      B                   Export
     D                 PI                         like(bool_t)
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      * ------------------------------------------------------------------------
      *
     C                   If        i_FLDL0100.F1VFMI = '1'
     C                   Return    bTrue
     C                   Else
     C                   Return    bFalse
     C                   Endif
      *
     P                 E
      *
      *===================================================================*
      *  Funktion:  f_binToDec                                 (Body)     *
      *===================================================================*
      *
     P f_binToDec      B                   Export
     D                 PI                  opdesc like(int4_t)
     D  i_string                  32767A   const options(*varsize)
     D  i_startPos                         const  like(int4_t)
     D  i_length                           const  like(int4_t)
      *
      * Funktionswert
     D                 DS
     D intValue                            like(int4_t) inz
     D alpha2                         2A   overlay(intValue: 3)
     D alpha4                         2A   overlay(intValue: 1)
      *
      * Parameters passed to CEEDOD
     D DescType        S             10I 0
     D DataType        S             10I 0
     D DescInfo1       S             10I 0
     D DescInfo2       S             10I 0
     D parmLen         S             10I 0
      * ------------------------------------------------------------------------
      *
     C                   CALLP     CEEDOD(1         : DescType : DataType :
     C                                    DescInfo1 : DescInfo2: parmLen  :
     C                                    *OMIT)
      *
     C                   If        (i_startpos + i_length - 1) > parmLen
     C                   Callp     p_kill('Start position and length outside +
     C                                    range.')
     C                   Else
     C                   Select
     C                   When      i_length = 2
     C                   Eval      alpha2 = %subst(i_string   :
     C                                             i_startPos :
     C                                             i_length   )
     C                   When      i_length = 4
     C                   Eval      alpha4 = %subst(i_string   :
     C                                             i_startPos :
     C                                             i_length   )
     C                   Other
     C                   Callp     p_kill('Incorrect length: ' +
     C                                    %char(i_length))
     C                   Endsl
     C                   Endif
      *
     C                   Return    intValue
      *
     P                 E
      *
      *===================================================================*
      *  Funktion:  f_len                                      (Body)     *
      *===================================================================*
      *
     P f_len           B                   Export
     D                 PI                  opdesc like(int4_t)
     D  i_string                  32767A   const options(*varsize)
      *
      * Parameters passed to CEEDOD
     D DescType        S             10I 0
     D DataType        S             10I 0
     D DescInfo1       S             10I 0
     D DescInfo2       S             10I 0
     D parmLen         S             10I 0
      * ------------------------------------------------------------------------
      *
     C                   CALLP     CEEDOD(1         : DescType : DataType :
     C                                    DescInfo1 : DescInfo2: parmLen  :
     C                                    *OMIT)
      *
     C                   Return    parmLen
      *
     P                 E
      *
      *===================================================================*
      *  Funktion:  f_scan                                     (Body)     *
      *===================================================================*
      *
     P f_scan          B                   Export
     D                 PI                  opdesc like(int4_t)
     D  SrchArg                     100A   CONST  OPTIONS(*VARSIZE)
     D  String                      100A   CONST
      *
     D LenArg          S                   like(int4_t) inz
     D PosFound        S                   like(int4_t) inz
      *
      * Parameters passed to CEEDOD
     D DescType        S                   like(int4_t) inz
     D DataType        S                   like(int4_t) inz
     D DescInfo1       S                   like(int4_t) inz
     D DescInfo2       S                   like(int4_t) inz
     D pLen            S                   like(int4_t) inz
      *------------------------------------------------------------*
      *
     C                   CALLP     CEEDOD(1         : DescType : DataType :
     C                                    DescInfo1 : DescInfo2: pLen     :
     C                                    *OMIT)
      *
     C     SrchArg:pLen  Scan      String:1      PosFound
      *
     C                   Return    PosFound
      *
     P                 E
      *
      *===================================================================*
      *  Funktion:  f_vldNme                                   (Body)     *
      *===================================================================*
      *
     P f_vldName       B                   Export
     D                 PI                         like(bool_t)
     D  i_name                       10A   const
     D  o_msgID                                   like(msgID_t)
     D  o_msgDta                                  like(msgDta_t)
      *
      *  Funktionswert
     D isValid         S                   like(bool_t)
     D                                     inz(bFalse)
      *
      *  Arbeitsfelder
     D idx             S                   like(int4_t)
     D                                     inz
     D chr             S              1A
     D                                     inz
     D strString       S                   like(bool_t)
     D                                     inz(bFalse)
     D endString       S                   like(bool_t)
     D                                     inz(bFalse)
      *
     D vld1Chr         C                   const('§$#-
     D                                     ABCDEFGHIJKLMNOPQRSTUVWXYZ')
     D vldChr          C                   const('§$#-
     D                                     ABCDEFGHIJKLMNOPQRSTUVWXYZ-
     D                                     _.1234567890')
      *
      /COPY QCOPYLE,USR8182
      *-------------------------------------------------------------------*
      *
     C                   Eval      isValid   = bTrue
     C                   Eval      strString = bFalse
     C                   Eval      endString = bFalse
      *
     C     1             Do        10            idx
      *
     C                   Eval      chr = %subst(i_name: idx: 1)
      *
      *  Prüfen Start des Strings und 1. Zeichen ...
     C                   If        (strString =  bFalse)  and
     C                             (endString =  bFalse)  and
     C                             (chr       <> ' '   )
     C                   Eval      strString = bTrue
     C     vld1Chr       Check     chr                                    01
     C                   If        *IN01 = *ON
     C                   Clear                   USR8182
     C                   Eval      USR81821 = chr
     C                   Eval      o_msgID  = 'USR8182'
     C                   Eval      o_msgDta = USR8182
     C                   Eval      isValid  = bFalse
     C                   Leave
     C                   Endif
     C                   Iter
     C                   Endif
      *
      *  Prüfen Ende des Strings ...
     C                   If        (strString =  bTrue )  and
     C                             (endString =  bFalse)  and
     C                             (chr       =  ' '   )
     C                   Eval      endString = bTrue
     C                   Iter
     C                   Endif
      *
      *  Prüfen Zeichen des Strings ...
     C                   If        (strString =  bTrue )  and
     C                             (endString =  bFalse)
     C     vldChr        Check     chr                                    01
     C                   If        *IN01 = *ON
     C                   Clear                   USR8182
     C                   Eval      USR81821 = chr
     C                   Eval      o_msgID  = 'USR8182'
     C                   Eval      o_msgDta = USR8182
     C                   Eval      isValid  = bFalse
     C                   Leave
     C                   Endif
     C                   Endif
      *
      *  Prüfen Zeichen hinter dem Ende des Strings ...
     C                   If        (strString =  bTrue )  and
     C                             (endString =  bTrue )
     C                   If        chr <> ' '
     C                   Clear                   USR8182
     C                   Eval      USR81821 = chr
     C                   Eval      o_msgID  = 'USR8182'
     C                   Eval      o_msgDta = USR8182
     C                   Eval      isValid  = bFalse
     C                   Leave
     C                   Endif
     C                   Endif
      *
     C                   Enddo
      *
     C                   If        (strString =  bFalse)
     C                   Clear                   USR8182
     C                   Eval      USR81821 = chr
     C                   Eval      o_msgID  = 'USR8182'
     C                   Eval      o_msgDta = USR8182
     C                   Eval      isValid  = bFalse
     C                   Endif
      *
     C                   Return    isValid
      *
     P                 E
      *
      *===================================================================*
      *  Funktion:  f_vldFloat                                 (Body)     *
      *===================================================================*
      *
     P f_vldFloat      B                   Export
     D                 PI                         like(bool_t)
     D  i_buffer                     64A   const  varying
      *
      *  Arbeitsfelder
     D i               S             10I 0 inz
     D c               S              1A   inz
     D dummy           S              8F   inz
     D hasExponent     S                   like(bool_t) inz(bFalse)
     D cDIGITS         C                   '0123456789'
      *-------------------------------------------------------------------*
      /FREE

       monitor;

         if (%len(i_buffer) = 0);
           return bFalse;
         endif;

         i = %check(' ': i_buffer);

         // Prüfen auf führendes Vorzeichen
         c = %subst(i_buffer: i: 1);
         if (c = '+' or c = '-');   // Überspringen Vorzeichen
           i = i + 1;
         endif;

         // Prüfen auf nummerische Ziffern vor dem Komma
         dow (i <= %len(i_buffer));
           c = %subst(i_buffer: i: 1);
           if (c <> ' ');
             if (c = ',' or c = '.');
               i = i + 1;   // Überspringen Komma
               leave;
             endif;
             if (%check(cDIGITS: c) <> 0);
               return bFalse;
             endif;
           endif;
           i = i + 1;
         enddo;

         // Prüfen auf nummerische Ziffern hinter dem Komma
         dow (i <= %len(i_buffer));
           c = %subst(i_buffer: i: 1);
           if (c <> ' ');
             if (c = 'e' or c = 'E');
               leave;
             endif;
             if (%check(cDIGITS: c) <> 0);
               return bFalse;
             endif;
           endif;
           i = i + 1;
         enddo;

         if (c = 'e' or c = 'E');
           // Prüfen auf Vorzeichen des Exponenten
           i = i + 1;
           if (i > %len(i_buffer));
             return bFalse;
           endif;
           c = %subst(i_buffer: i: 1);
           if (c <> '+' and c <> '-' and c <> ' ');
             return bFalse;
           endif;

           i = i + 1;
           hasExponent = bFalse;

           // Prüfen auf nummerische Ziffern des Exponenten
           dow (i <= %len(i_buffer));
             c = %subst(i_buffer: i: 1);
             if (c <> ' ');
               if (%check(cDIGITS: c) <> 0);
                 return bFalse;
               endif;
               hasExponent = bTrue;
             endif;
             i = i + 1;
           enddo;

           if (hasExponent <> bTrue);
             return bFalse;
           endif;
         endif;

         dummy = %float(i_buffer);

         return bTrue;
       on-error;
         p_rmvPgmMg('*');
         return bFalse;
       endmon;

      /END-FREE
      *
     P                 E
      *
      *===================================================================*
      *  Funktion:  f_execute                                  (Body)     *
      *===================================================================*
      *
     P f_execute       B                   Export
     D                 PI                  opdesc like(bool_t)
     D  i_cmd                     32702A   const
     D                                     options(*VARSIZE)
     D  o_msgID                                   like(msgID_t)
     D  o_msgDta                                  like(msgDta_t)
      *
      *  Definieren Funktionswert
     D isOK            S                          like(bool_t)
     D                                            inz(bFalse)
      *
      *  Definieren Parameter für p_getOpDesc
     D posNr           S             10I 0 INZ
     D descType        S             10I 0 INZ
     D datatype        S             10I 0 INZ
     D descInf1        S             10I 0 INZ
     D descInf2        S             10I 0 INZ
     D dataLen         S             10I 0 INZ
     D feedBack        S             12A   INZ
      *
      *  Definitionen für QCAPCMD
     D cmdLen          S             10I 0 INZ
     D optCtrl         DS
     D  typ_CmdPrc             1      4I 0 INZ(0)                               like QCMDEXC
     D  DBCS_Data              5      5A   INZ('0')                             ignore DBCS
     D  prmt_Act               6      6A   INZ('0')                             never prompt
     D  cmdStrSntx             7      7A   INZ('0')                             AS/400 Syntax
     D  msgRtvKey              8     11A   INZ(*BLANKS)                         no retrieve ke
     D  res_01                12     20A   INZ(*ALLx'00')
     D optCtrlLen      S             10I 0 INZ
     D optCtrlFmt      S              8A   INZ('CPOP0100')
     D cmd             S                   LIKE(i_cmd)
     D                                     INZ
     D lenAvl          S             10I 0 INZ
     D lenAvlRtn       S             10I 0 INZ
     D errCode         DS                  LIKEDS(errCode_t ) inz
      *-------------------------------------------------------------------
      *
     C                   Reset                   errCode
     C                   Eval      errCode.bytPrv = %size(errCode)
      *
     C                   Callp     CEEDOD(1: descType: dataType:
     C                                       descInf1: descInf2:
     C                                       dataLen:  feedBack)
      *
     C                   Eval      cmd        = %subst(i_cmd: 1: dataLen)
     C                   Eval      cmdLen     = %len(cmd)
     C                   Eval      lenAvl     = %len(cmd)
      *
     C                   Eval      optCtrlLen = %len(OptCtrl)
     C                   Reset                   errCode
     C                   Eval      errCode.bytPrv = %size(errCode)
      *
     C                   CALL      'QCAPCMD'
     C                   PARM                    cmd
     C                   PARM                    cmdLen
     C                   PARM                    optCtrl
     C                   PARM                    optCtrlLen
     C                   PARM                    optCtrlFmt
     C                   PARM                    cmd
     C                   PARM                    lenAvl
     C                   PARM                    lenAvlRtn
     C                   PARM                    errCode
      *
     C                   If        errCode.bytAvl <> 0
     C                   Eval      o_msgID  = errCode.excID
     C                   Eval      o_msgDta = errCode.excDta
     C                   Eval      isOK     = bFalse
     C                   Else
     C                   Eval      o_msgID  = ' '
     C                   Eval      o_msgDta = ' '
     C                   Eval      isOK     = bTrue
     C                   Endif
      *
     C                   Return    isOK
      *
     P                 E
      *
      *===================================================================*
      *  Funktion:  f_basedPF                                  (Body)     *
      *===================================================================*
      *
     P f_basedPF       B                   Export
     D                 PI                         like(bool_t)
     D  i_file                             value  like(file_t)
     D  i_lib                              value  like(lib_t)
     D  i_mbr                              value  like(mbr_t)
     D  i_rcdFmt                           value  like(rcdFmt_t)
     D  i_rcdMbrNbr                        value  like(mbrNbr_t)
     D  o_pFile                                   like(file_t)
     D  o_pLib                                    like(lib_t)
     D  o_pMbr                                    like(mbr_t)
     D  o_pRcdFmt                                 like(rcdFmt_t)
      *
      *  Definieren Funktionswert ...
     D isBasedOnPF     S                   like(bool_t) inz(bFalse)
      *
     D tFile           S                   like(i_file)
     D tLib            S                   like(i_lib)
     D tMbr            S                   like(i_mbr)
     D tRcdFmt         S                   like(i_rcdFmt)
     D FILD0100        DS                  likeds(FILD0100_t) inz
      *
     D yQFile          DS                  likeds(qObj_t) inz
     D yNbrOfEnt       s                   like(int4_t)
     D yData           s            512A
      *------------------------------------------------------------*
      *
     C                   Eval      PEEK41_NAME = f_pgmCallN('PEEK41')
      *
     C                   Eval      o_pFile  = '*ERROR'
     C                   Eval      o_pLib   = '*ERROR'
     C                   Eval      o_pMbr   = '*ERROR'
     C                   Eval      o_pRcdFmt = '*ERROR'
      *
      *  Einlesen der Dateiinformationen ...
     C                   Eval      yQFile.name = i_file
     C                   Eval      yQFile.lib = i_lib
     C                   Callp     PEEK41(yQFile: i_rcdFmt
     C                                    : '*CREATE': yNbrOfEnt: YData)
      *
     C                   If        yNbrOfEnt = 0
     C                   Return    bFalse
     C                   Endif
      *
      *      prüfen auf logische Datei
     C                   Eval      FILD0100 = yData
      *
     C                   If        FILD0100.ATFILA = '*LGL'
      *      ... logical file
     C                   Select
     C                   When      FILD0100.ATNOMB > 1
      *          ... multi-based-member logical file
     C                   If        f_basedMbr(i_file: i_lib: i_mbr
     C                                        : i_rcdMbrNbr: i_rcdFmt
     C                                        : tFile: tLib: tMbr: tRcdFmt
     C                                        ) = bFalse
     C                   Return    bFalse
     C                   Endif
      *
     C                   When      FILD0100.ATNOFM > 1
      *          ... multi-format logical file
     C                   If        f_basedMbr(i_file: i_lib: i_mbr
     C                                        : i_rcdMbrNbr: i_rcdFmt
     C                                        : tFile: tLib: tMbr: tRcdFmt
     C                                        ) = bFalse
     C                   Return    bFalse
     C                   Endif
      *
     C                   Other
      *          ... single-format logical file
     C                   If        f_basedMbr(i_file: i_lib: i_mbr
     C                                        : i_rcdMbrNbr: i_rcdFmt
     C                                        : tFile: tLib: tMbr: tRcdFmt
     C                                        ) = bFalse
     C                   Return    bFalse
     C                   Endif
     C                   Endsl
      *
      *
     C                   Eval      isBasedOnPF = bTrue
     C                   Eval      o_pFile   = tFile
     C                   Eval      o_pLib    = tLib
     C                   Eval      o_pMbr    = tMbr
     C                   Eval      o_pRcdFmt = tRcdFmt
      *
     C                   Else
      *      ... physical file
     C                   If        f_basedMbr(i_file: i_lib: i_mbr
     C                                        : i_rcdMbrNbr: i_rcdFmt
     C                                        : tFile: tLib: tMbr: tRcdFmt
     C                                        ) = bFalse
     C                   Return    bFalse
     C                   Endif
      *
     C                   Eval      isBasedOnPF = bFalse
     C                   Eval      o_pFile   = tFile
     C                   Eval      o_pLib    = tLib
     C                   Eval      o_pMbr    = tMbr
     C                   Eval      o_pRcdFmt = tRcdFmt
     C                   Endif
      *
     C                   Return    isBasedOnPF
      *
     P                 E
      *
      *===================================================================*
      *  Funktion:  f_basedMbr                                 (Body)     *
      *===================================================================*
      *
     P f_basedMbr      B                   Export
     D                 PI                         like(bool_t)
     D  i_file                             value  like(file_t)
     D  i_lib                              value  like(lib_t)
     D  i_mbr                              value  like(mbr_t)
     D  i_mbrNbr                           value  like(int4_t)
     D  i_rcdFmt                           value  like(rcdFmt_t)
     D  o_pFile                                   like(file_t)
     D  o_pLib                                    like(lib_t)
     D  o_pMbr                                    like(mbr_t)
     D  o_rcdFmt                                  like(rcdFmt_t)
      *
      *  Definieren Funktionswert ...
     D isMbrFound      S                   like(bool_t) inz(bFalse)
      *
      *  Retrieve Member Description (QUSRMBRD) API
     D QUSRMBRD        PR                         extpgm('QUSRMBRD')
     D  rcvVar                    32767A          options(*varsize)
     D  lenRcvVar                    10I 0 const
     D  formatName                    8A   const
     D  qFileName                    20A   const
     D  mbr                          10A   const
     D  ovrPrc                        1A   const
     D  errCode                   32767A          options(*varsize: *nopass)
     D  fndMbrPrc                     1A   const  options(          *nopass)
      *
     D mbrNbr          S                   like(i_mbrNbr)
      *
     D alloc           PR              *          extproc('malloc')
     D  memSize                      10U 0 value
      *
     D realloc         PR              *          extproc('realloc')
     D  memPtr                         *   value
     D  memSize                      10U 0 value
      *
     D dealloc         PR              *          extproc('free')
     D  memPtr                         *   value
      *
      *  Arbeitsfelder
     D errCode         DS                  likeds(errCode_t) inz
      *
     D BSPF0100        DS                  likeds(BSPF0100_t) inz
      *
     D pMBRD0300       S               *   inz static
     D MBRD0300        DS                  based(pMBRD0300)
     D  m3bytPrv               1      4I 0
     D  m3bytAvl               5      8I 0
     D  m3FileName             9     18A
     D  m3LibName             19     28A
     D  m3MbrName             29     38A
     D  m3FileAttr            39     48A
     D  m3NbrMbr             157    160I 0
     D  m3joinMbr            267    267A
     D  m3AccPathMaint...
     D                       268    268A
     D  m3SQLFileType        269    278A
     D  m3NumCstIdx          333    334I 0
     D  m3OffsCstIdx         335    338I 0
     D  reserved_3           339    384A
      *
     D basedOnE        DS           112    based(pBasedOnE)
     D  bsdOnFile              1     10A
     D  bsdOnLib              11     20A
     D  bsdOnMbr              21     30A
     D  fmtName               31     40A
     D  LFRcdFmtNbr           41     44I 0
     D  NbrRcds               45     48I 0
     D  NbrDltRcds            49     52I 0
     D  AccPathSize           53     56I 0
     D  AccPathSizeM          57     60I 0
     D  AccPathShared         61     61A
     D  AccPathValid          62     62A
     D  AccPathHeld           63     63A
     D  AccPathOwnrFile...
     D                        64     73A
     D  AccPathOwnrLib...
     D                        74     83A
     D  AccPathOwnrMbr...
     D                        84     93A
     D  AccPathJrn            94     94A
     D  Reserved_1            95     96A
     D  NbrRcdsU              97    100I 0
     D  NbrDltRcdsU          101    104I 0
     D  Reserved_2           105    112A
      *
     D offset          S             10I 0 inz
     D fild0100        ds                  likeds(fild0100_t) inz
      *
     D qFile           DS                  likeds(qObj_t) inz
     D yNbrOfEnt       s                   like(int4_t)
     D yData           s            512A
      *------------------------------------------------------------*
      *
     C                   Eval      PEEK41_NAME = f_pgmCallN('PEEK41')
      *
     C                   Eval      o_pFile = ' '
     C                   Eval      o_pLib  = ' '
     C                   Eval      o_pMbr  = ' '
      *
      *  Ermitteln Speicherbedarf
     C                   Reset                   errCode
     C                   Eval      errCode.bytPrv = %size(errCode)
      *
     C                   Eval      pMBRD0300 = alloc(%size(MBRD0300))
     C                   Callp     QUSRMBRD(MBRD0300       :
     C                                      %size(MBRD0300):
     C                                      'MBRD0300'     :
     C                                      i_file + i_lib :
     C                                      i_mbr          :
     C                                      '0'            :
     C                                      errCode        )
     C                   If        errCode.bytAvl <> 0
     C                   Eval      isMbrFound = bFalse
     C                   Return    isMbrFound
     C                   Endif
      *
      *  Zuordnen Speicher
     C                   Eval      pMBRD0300 = realloc(pMBRD0300: m3BytAvl)
      *
      *  Abrufen Beschreibung der Teildatei
     C                   Callp     QUSRMBRD(MBRD0300       :
     C                                      m3BytAvl       :
     C                                      'MBRD0300'     :
     C                                      i_file + i_lib :
     C                                      i_mbr          :
     C                                      '0'            :
     C                                      errCode        )
     C                   If        errCode.bytAvl <> 0
     C                   Eval      isMbrFound = bFalse
     C                   Return    isMbrFound
     C                   Endif
      *
     C                   Select
      *  Wenn es sich um eine Join Datei oder SQL VIEW handelt, ...
     C                   When      m3JoinMbr = '1' or
     C                             m3SQLFileType = 'VIEW'
      *  ... dann
      *      zurückgeben der Eingangsmemberdaten, wegen Join Datei
     C                   Eval      o_pFile   = i_file
     C                   Eval      o_pLib    = i_lib
     C                   Eval      o_pMbr    = i_mbr
     C                   Eval      o_rcdFmt  = i_rcdFmt
     C                   Eval      isMbrFound = bTrue
      *
      *  Wenn es keine basierenden physischen Member gibt, ...
     C                   When      m3NbrMbr = 0
      *  ... dann
      *      zurückgeben der Eingangsmemberdaten
     C                   Eval      o_pFile   = i_file
     C                   Eval      o_pLib    = i_lib
     C                   Eval      o_pMbr    = i_mbr
     C                   Eval      o_rcdFmt  = i_rcdFmt
     C                   Eval      isMbrFound = bTrue
     C                   Other
      *  ... sonst
      *      zurückgeben des basierenden physischen Members
     C                   If        (i_mbrNbr > 0)
     C                   Eval      mbrNbr = i_mbrNbr
     C                   Else
     C                   If        (m3NbrMbr = 1)
     C                   Eval      mbrNbr = 1
     C                   Else
     C                   Eval      mbrNbr = -1
     C                   Endif
     C                   Endif
      *
     C                   If        (mbrNbr > 0)
     C                   Eval      offset = %size(MBRD0300) +
     C                               (mbrNbr - 1) * %size(basedOnE)
     C                   Eval      pBasedOnE  = f_addPtr(pMBRD0300: offset)
     C                   Eval      o_pFile    = bsdOnFile
     C                   Eval      o_pLib     = bsdOnLib
     C                   Eval      o_pMbr     = bsdOnMbr
     C                   Eval      o_rcdFmt   = '*FIRST'
     C                   Eval      isMbrFound = bTrue
     C                   Else
     C                   Eval      o_pFile    = '*ERROR'
     C                   Eval      o_pLib     = '*ERROR'
     C                   Eval      o_pMbr     = '*ERROR'
     C                   Eval      o_rcdFmt   = '*ERROR'
     C                   Eval      isMbrFound = bFalse
     C                   Endif
     C                   Endsl
      *
      *  Freigeben Speicher ...
     C                   Callp     dealloc(pMBRD0300)
      *
     C                   If        (o_rcdFmt = '*FIRST')
      *
      *  Einlesen der Dateiinformationen ...
     C                   Eval      qFile.name = o_pFile
     C                   Eval      qFile.lib = o_pLib
     C                   Callp     PEEK41(qFile: o_rcdFmt
     C                                    : '*CREATE': yNbrOfEnt: YData)
     C                   Eval      FILD0100 = yData
      *
     C                   Callp     PEEK41(qFile: o_rcdFmt
     C                                    : '*BASED-ON': yNbrOfEnt: YData)
     C                   Eval      BSPF0100 = YData
      *
     C                   If        (YNbrOfEnt = 1)
     C                   Eval      o_rcdFmt = BSPF0100.BFRCDFMT
     C                   Endif
      *
     C                   Endif
      *
     C                   Return    isMbrFound
      *
     P                 E
      *
      *===================================================================*
      *  Funktion:  f_numBased                                 (Body)     *
      *===================================================================*
      *
     P f_numBased      B                   Export
     D                 PI                         like(int4_t)
     D  i_file                             const  like(file_t)
     D  i_lib                              const  like(lib_t)
     D  i_mbr                              const  like(mbr_t)
      *
      *  Definieren Funktionswert ...
     D f_numBased      S                   like(int4_t)
     D                                     inz
      *
      *  Prototypen
     D QUSRMBRD        PR                         extpgm('QUSRMBRD')
     D  rcvVar                    32767A          options(*varsize)
     D  lenRcvVar                    10I 0 const
     D  formatName                    8A   const
     D  qFileName                    20A   const
     D  mbr                          10A   const
     D  ovrPrc                        1A   const
     D  errCode                   32767A          options(*varsize: *nopass)
     D  fndMbrPrc                     1A   const  options(          *nopass)
      *
      *  Arbeitsfelder
     D errCode         DS                  likeds(errCode_t ) inz
      *
     D MBRD0300        DS                  inz
     D  m3bytPrv               1      4I 0
     D  m3bytAvl               5      8I 0
     D  m3FileAttr            39     48A
     D  m3NbrMbr             157    160I 0
      *------------------------------------------------------------*
      *
      *  Ermitteln Anzahl basierender Teildateien
     C                   Reset                   errCode
     C                   Eval      errCode.bytPrv = %size(errCode)
      *
     C                   Callp     QUSRMBRD(MBRD0300       :
     C                                      %size(MBRD0300):
     C                                      'MBRD0300'     :
     C                                      i_file + i_lib :
     C                                      i_mbr          :
     C                                      '0'            :
     C                                      errCode        )
     C                   If        errCode.bytAvl <> 0
     C                   Eval      f_numBased = -1
     C                   Else
     C                   If        m3FileAttr = 'PF'
     C                   Eval      f_numBased = 1
     C                   Else
     C                   Eval      f_numBased = m3NbrMbr
     C                   Endif
     C                   Endif
      *
     C                   Return    f_numBased
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_setPrdLb                                 (Body)     *
      *===================================================================*
      *
     P p_setPrdLb      B                   Export
     D                 PI
     D  i_lib                              const  like(lib_t)
      *------------------------------------------------------------*
      *
     C                   Eval      g_prdLib = i_lib
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Funktion:  f_getPrdLb                                 (Body)     *
      *===================================================================*
      *
     P f_getPrdLb      B                   Export
     D                 PI                         like(lib_t)
      *------------------------------------------------------------*
      *
     C                   Return    g_prdLib
      *
     P                 E
      *
      *===================================================================*
      *  Funktion:  f_cmdLine                                  (Body)     *
      *===================================================================*
      *
     P f_cmdLine       B                   Export
     D                 PI                         like(bool_t)
      *------------------------------------------------------------*
      *
      *  Definieren Funktionswert ...
     D  f_cmdLine      S                   like(bool_t)
     D                                     inz
      *
     D rcvVarLen       S                   like(INT4_t)
     D format          S              8A
     D usrPrf          S             10A
     D errCode         DS                  likeds(errCode_t ) inz
      *
      /COPY QCOPYLE,USRI0200
      *------------------------------------------------------------*
      *
     C                   Eval      rcvVarLen = §usri200
     C                   Eval      format    = 'USRI0200'
     C                   Eval      usrPrf    = §§user
     C                   Clear                   usri0200
      *
     C                   Reset                   errCode
     C                   Eval      errCode.bytPrv = %size(errCode)
      *
     C                   Call      'QSYRUSRI'
     C                   Parm                    usri0200
     C                   Parm                    rcvVarLen
     C                   Parm                    format
     C                   Parm                    usrPrf
     C                   Parm                    errCode
      *
     C                   If        (errCode.bytAvl <> 0)  or
     C                             (u2lmtCap  =  '*YES')
     C                   Eval      f_cmdLine = bFalse
     C                   Else
     C                   Eval      f_cmdLine = bTrue
     C                   Endif
      *
     C                   Return    f_cmdLine
      *
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_expStr                                   (Body)     *
      *===================================================================*
      *
     P p_expStr        B                   Export
     D                 PI                  opdesc
     D  o_string                  32767A          options(*varsize)
     D  i_string                  32767A   const  options(*varsize)
     D  i_stepVal                    10I 0 const  options(*nopass)
      *
      *  Parameterpositionen optionaler Parameter
     D p_stepVal       C                   const(3)
      *
      * Parameters passed to CEEDOD
     D DescType        S             10I 0
     D DataType        S             10I 0
     D DescInfo1       S             10I 0
     D DescInfo2       S             10I 0
     D oStrLen         S             10I 0
     D iStrLen         S             10I 0
      *
      *  Arbeitsfelder
     D stepVal         S             10I 0 inz
     D iIdx            S             10I 0 inz
     D oIdx            S             10I 0 inz
      * ------------------------------------------------------------------------
      *
     C                   CALLP     CEEDOD(1         : DescType : DataType :
     C                                    DescInfo1 : DescInfo2: oStrLen  :
     C                                    *OMIT)
      *
     C                   CALLP     CEEDOD(2         : DescType : DataType :
     C                                    DescInfo1 : DescInfo2: iStrLen  :
     C                                    *OMIT)
      *
     C                   If        %parms >= p_stepVal
     C                   Eval      stepVal = i_stepVal
     C                   Else
     C                   Eval      stepVal = 1
     C                   Endif
      *
     C                   Eval      iIdx = 1
     C                   Eval      oIdx = 1
      *
     C                   Dow       (iIdx <= iStrLen) and
     C                             (oIdx <= oStrLen)
      *
     C                   Eval      %subst(o_string: oIdx: 1) =
     C                                %subst(i_string: iIdx: 1)
      *
     C                   Eval      iIdx = iIdx + 1
     C                   Eval      oIdx = oIdx + 1
      *
     C     1             Do        stepVal
     C                   Eval      %subst(o_string: oIdx: 1) = ' '
     C                   Eval      oIdx = oIdx + 1
     C                   Enddo
     C                   Enddo
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Funktion:  f_headline                                 (Body)     *
      *===================================================================*
      *
     P f_headline      B                   Export
     D                 PI                  like(colHeading_t)
     D  i_headTyp                          const  like(type_t)
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      *
      *  Funktionswert
     D heading         S                   like(colHeading_t)
      * ------------------------------------------------------------------------
      *
      *  Überschrift ...
     C                   Select
      *  ... Feldtext
     C                   When      i_headTyp = '*FIELDTEXT'
     C                   If        i_FLDL0100.F1FTXT = ' '
     C                   Eval      heading = '?' + i_FLDL0100.F1FNME
     C                   Else
     C                   Eval      heading = i_FLDL0100.F1FTXT
     C                   Endif
      *  ... Feldtyp
     C                   When      i_headTyp = '*FIELDTYPE'
     C                   Eval      heading = f_fieldTypeAsString(i_FLDL0100)
      *  ... Feldname
     C                   Other
     C                   Eval      heading = i_FLDL0100.F1FNME
     C                   Endsl
      *
     C                   Return    heading
      *
     P                 E
      *
      *===================================================================*
      *  Funktion:  f_isNumFld                                 (Body)     *
      *===================================================================*
      *
     P f_isNumFld      B                   Export
     D                 PI                         like(bool_t)
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      *
      *  Funktionswert
     D isNumFld        S                   like(bool_t)
     D                                     inz
      * ------------------------------------------------------------------------
      *
     C                   If        (i_FLDL0100.F1DTYP = 'S') or                 Zoned
     C                             (i_FLDL0100.F1DTYP = 'B') or                 Binary
     C                             (i_FLDL0100.F1DTYP = 'P') or                 Packed
     C                             (i_FLDL0100.F1DTYP = 'F')                    Float
     C                   Eval      isNumFld = bTrue
     C                   Else
     C                   Eval      isNumFld = bFalse
     C                   Endif
      *
     C                   Return    isNumFld
      *
     P                 E
      *
      *===================================================================*
      *  Funktion:  f_isFloatFld                               (Body)     *
      *===================================================================*
      *
     P f_isFloatFld    B                   Export
     D                 PI                         like(bool_t)
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      *
      *  Funktionswert
     D isFloat         S                   like(bool_t)
     D                                     inz
      * ------------------------------------------------------------------------
      *
     C                   If        (i_FLDL0100.F1DTYP = 'F')                    Float
     C                   Eval      isFloat = bTrue
     C                   Else
     C                   Eval      isFloat = bFalse
     C                   Endif
      *
     C                   Return    isFloat
      *
     P                 E
      *
      *===================================================================*
      *  Funktion:  f_isCharFld                                (Body)     *
      *===================================================================*
      *
     P f_isCharFld     B                   Export
     D                 PI                         like(bool_t)
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      *
      *  Funktionswert
     D isCharFld       S                   like(bool_t)
     D                                     inz
      * ------------------------------------------------------------------------
      *
     C                   If        (i_FLDL0100.F1DTYP = 'A' or                  Alpha
     C                              i_FLDL0100.F1DTYP = 'G')                    Graphic
     C                   Eval      isCharFld = bTrue
     C                   Else
     C                   Eval      isCharFld = bFalse
     C                   Endif
      *
     C                   Return    isCharFld
      *
     P                 E
      *
      *===================================================================*
      *  Funktion:  f_hasCcsid                                 (Body)     *
      *===================================================================*
      *
     P f_hasCcsid      B                   Export
     D                 PI                         like(bool_t)
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      *
      *  Funktionswert
     D hasCcsid        S                   like(bool_t)
     D                                     inz
      * ------------------------------------------------------------------------
      *
     C                   If        (i_FLDL0100.F1FDCC > 0 and
     C                              i_FLDL0100.F1FDCC <> 65535)
     C                   Eval      hasCcsid = bTrue
     C                   Else
     C                   Eval      hasCcsid = bFalse
     C                   Endif
      *
     C                   Return    hasCcsid
      *
     P                 E
      *
      *===================================================================*
      *  Funktion:  f_appMsgF                                  (Body)     *
      *===================================================================*
      *
     P f_appMsgF       B                   Export
     D                 PI                         like(file_t)
      *------------------------------------------------------------*
      *
     C                   Return    'PEEKGER'
      *
     P                 E
      *
      *===================================================================*
      *  Funktion:  f_appMsgFL                                 (Body)     *
      *===================================================================*
      *
     P f_appMsgFL      B                   Export
     D                 PI                         like(lib_t)
      *------------------------------------------------------------*
      *
     C                   Return    '*LIBL'
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_rmvPgmMg                                 (Body)     *
      *===================================================================*
      *
     P p_rmvPgmMg      B                   Export
     D                 PI
     D  i_pgmNme                           const  like(pgm_t)
      *
      *  Parameter für QMHRMVPM API
     D yStkE           S                   like(proc_t)
     D                                     inz
     D yStkCnt         S                   like(int4_t)
     D                                     inz
     D yMsgKey         S              4A   inz
     D yMsgToRmv       S             10A   inz
     D yErrCode        DS                  likeds(errCode_t ) inz
     D yStkELen        S             10I 0 inz
     D yQStkE          DS
     D  yStkEMod                           like(mod_t)  inz
     D  yStkEPgm                           like(pgm_t)  inz
     D yRmvExcpt       S             10A   inz
      *------------------------------------------------------------*
      *
     C                   IF        i_pgmNme = '*'
     C                   EVAL      yStkE      = i_pgmNme
     C                   EVAL      yStkCnt    = 1
     C                   Eval      yStkEMod   = '*NONE'
     C                   Eval      yStkEPgm   = '*NONE'
     C                   ELSE
     C                   EVAL      yStkE      = i_pgmNme
     C                   EVAL      yStkCnt    = 0
     C                   Eval      yStkEMod   = i_pgmNme
     C                   Eval      yStkEPgm   = i_pgmNme
     C                   ENDIF
      *
     C                   EVAL      yMsgKey      = ' '
     C                   EVAL      yMsgToRmv    = '*ALL'
     C                   Reset                   yErrCode
     C                   Eval      yErrCode.bytPrv = %size(yErrCode)
     C                   EVAL      yStkELen     = %size(yStkE)
     C                   EVAL      yRmvExcpt    = '*NO'
      *
     C                   Call      'QMHRMVPM'
     C                   Parm                    yStkE
     C                   Parm                    yStkCnt
     C                   Parm                    yMsgKey
     C                   Parm                    yMsgToRmv
     C                   Parm                    yErrCode
     C                   Parm                    yStkELen
     C                   Parm                    yQStkE
     C                   Parm                    yRmvExcpt
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_sndPgmMg                                 (Body)     *
      *===================================================================*
      *
     P p_sndPgmMg      B                   Export
     D                 PI
     D  i_msgID                            const  like(msgID_t)
     D  i_msgDta                           const  like(msgDta_t)
     D  i_pgmNme                           const  like(pgm_t)
     D  i_msgType                          const  like(msgType_t)
     D                                            options(*nopass)
      *
      *  Parameterpositionen optionaler Parameter
     D p_msgType       C                   const(4)
      *
      *  Parameter für QMHSNDPM API
     D yMsgID          S                   like(msgID_t)
     D                                     inz
     D yQMsgF          DS
     D  yMsgF                              like(file_t)  inz
     D  yMsgFL                             like(lib_t)  inz
     D yMsgDta         S                   like(msgDta_t)
     D                                     inz
     D yMsgDtaLen      S                   like(int4_t)
     D                                     inz
     D yMsgType        S             10A
     D                                     inz
     D yStkE           S                   like(proc_t)
     D                                     inz
     D yStkCnt         S                   like(int4_t)
     D                                     inz
     D yMsgKey         S              4A   inz
     D yErrCode        DS                  likeds(errCode_t ) inz
     D yStkELen        S             10I 0 inz
     D yQStkE          DS
     D  yStkEMod                           like(mod_t)  inz
     D  yStkEPgm                           like(pgm_t)  inz
     D yRmvExcpt       S             10A   inz
     D yMsgWait        S                   like(int4_t)
     D                                     inz
      *------------------------------------------------------------*
      *
     C                   If        i_msgID <> ' '
      *
     C                   EVAL      yMsgID       = i_msgID
     C                   If        (%subst(i_msgID: 1: 3) = 'AID') or
     C                             (%subst(i_msgID: 1: 3) = 'KEY') or
     C                             (%subst(i_msgID: 1: 3) = 'MBX') or
     C                             (%subst(i_msgID: 1: 3) = 'TXT') or
     C                             (%subst(i_msgID: 1: 3) = 'USR')
     C                   EVAL      yMsgF        = f_appMsgF
     C                   EVAL      yMsgFL       = f_appMsgFL
     C                   Else
     C                   EVAL      yMsgF        = 'QCPFMSG'
     C                   EVAL      yMsgFL       = '*LIBL'
     C                   Endif
     C                   EVAL      yMsgDta      = i_msgDta
     C                   EVAL      yMsgDtaLen   = %size(yMsgDta)
      *
     C                   If        %parms >= p_msgType
     C                   EVAL      yMsgType     = i_msgType
     C                   Else
     C                   EVAL      yMsgType     = '*INFO'
     C                   Endif
      *
     C                   Select
     C                   When      i_pgmNme = '*'
     C                   Eval      yStkE        = i_pgmNme
     C                   Eval      yStkCnt      = 1
     C                   Other
     C                   Eval      yStkE        = i_pgmNme
     C                   Eval      yStkCnt      = 0
     C                   Endsl
      *
     C                   EVAL      yMsgKey      = ' '
     C                   Reset                   yErrCode
     C                   Eval      yErrCode.bytPrv = %size(yErrCode)
     C                   EVAL      yStkELen     = %size(yStkE)
     C                   Eval      yStkEPgm   = i_pgmNme
     C                   Eval      yStkEMod   = i_pgmNme
     C                   EVAL      yMsgWait     = -1
      *
     C                   Call      'QMHSNDPM'
     C                   Parm                    yMsgID
     C                   Parm                    yQMsgF
     C                   Parm                    yMsgDta
     C                   Parm                    yMsgDtaLen
     C                   Parm                    yMsgType
     C                   Parm                    yStkE
     C                   Parm                    yStkCnt
     C                   Parm                    yMsgKey
     C                   Parm                    yErrCode
     C                   Parm                    yStkELen
     C                   Parm                    yQStkE
     C                   Parm                    yMsgWait
      *
     C                   Endif
      *
     C**                 Eval      i_msgID  = ' '
     C**                 Eval      i_msgDta = ' '
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Funktion:  f_canUseRefFld                             (Body)     *
      *===================================================================*
      *
     P f_canUseRefFld  B                   Export
     D                 PI                         like(bool_t)
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      *
      *  Funktionswert
     D canUseRefFld    S                   like(bool_t)
     D                                     inz
      * ------------------------------------------------------------------------
      *
     C                   If        (i_FLDL0100.F1DTYP = 'G' or
     C                              (i_FLDL0100.F1DTYP = 'A' and
     C                               (i_FLDL0100.F1FDCC = 1200 or
     C                                i_FLDL0100.F1FDCC = 1208)))
     C                   Eval      canUseRefFld = bFalse
     C                   Else
     C                   Eval      canUseRefFld = bTrue
     C                   Endif
      *
     C                   Return    canUseRefFld
      *
     P                 E
      *
      *===================================================================*
      *  Funktion:  f_canUseCntFld                             (Body)     *
      *===================================================================*
      *
     P f_canUseCntFld  B                   Export
     D                 PI                         like(bool_t)
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      *
      *  Funktionswert
     D canUseCntFld    S                   like(bool_t)
     D                                     inz
      * ------------------------------------------------------------------------
      *
     C                   If        (i_FLDL0100.F1DTYP = 'G' or
     C                              (i_FLDL0100.F1DTYP = 'A' and
     C                               (i_FLDL0100.F1FDCC = 1200 or
     C                                i_FLDL0100.F1FDCC = 1208)))
     C                   Eval      canUseCntFld = bFalse
     C                   Else
     C                   Eval      canUseCntFld = bTrue
     C                   Endif
      *
     C                   Return    canUseCntFld
      *
     P                 E
      *
      *===================================================================*
      *  Funktion:  f_mustCvtCcsid                             (Body)     *
      *===================================================================*
      *
     P f_mustCvtCcsid  B                   Export
     D                 PI                         like(bool_t)
      *
     D jobi0400        DS                  likeds(jobi0400_t)
      * ------------------------------------------------------------------------
      /free

       if (g_jobCcsid = 0);
         QUSRJOBI(jobi0400: %size(jobi0400): 'JOBI0400': '*': '');
         g_jobCcsid = jobi0400.ccsid;
       endif;

       if (g_jobCcsid = 65535); // Job CCSID = *HEX
         return bTrue;
       endif;

       return bFalse;

      /end-free
     P                 E
      *
      *===================================================================*
      *  Funktion:  f_isToLong                                 (Body)     *
      *===================================================================*
      *
     P f_isToLong      B                   Export
     D                 PI                         like(bool_t)
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      *
      *  Funktionswert
     D toLong          S                   like(bool_t)
     D                                     inz
      * ------------------------------------------------------------------------
      *
     C                   If        f_dsplyLn(i_FLDL0100)>f_maxDspLn(i_FLDL0100)
     C                   Eval      toLong = bTrue
     C                   Else
     C                   Eval      toLong = bFalse
     C                   Endif
      *
     C                   Return    toLong
      *
     P                 E
      *
      *===================================================================*
      *  Funktion:  f_isToLongMax                              (Body)     *
      *===================================================================*
      *
     P f_isToLongMax   B                   Export
     D                 PI                         like(bool_t)
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      *
      *  Funktionswert
     D toLong          S                   like(bool_t)
     D                                     inz
      * ------------------------------------------------------------------------
      *
     C                   If        f_buffLn(i_FLDL0100) > 1024
     C                   Eval      toLong = bTrue
     C                   Else
     C                   Eval      toLong = bFalse
     C                   Endif
      *
     C                   Return    toLong
      *
     P                 E
      *
      *===================================================================*
      *  Funktion:  f_maxDspLn                                 (Body)     *
      *===================================================================*
      *
     P f_maxDspLn      B                   Export
     D                 PI                         like(int4_t)
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      *
     D maxLen          S             10I 0 inz
      *------------------------------------------------------------*
      *
     C                   Eval      maxLen =  %int(f_cntFldLn(i_FLDL0100) * 15)
     C                   If        maxLen > 512
     C                   Eval      maxLen = 512
     C                   Endif
      *
     C                   Return    maxLen
      *
     P                 E
      *
      *===================================================================*
      *  Funktion:  f_cntFldLn                                 (Body)     *
      *===================================================================*
      *
     P f_cntFldLn      B                   Export
     D                 PI                         like(int4_t)
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      *------------------------------------------------------------*
      *
     C                   If        (i_FLDL0100.F1DTYP = 'G')
     C                   Return    34                                           TODO:18
     C                   Else
     C                   Return    35
     C                   Endif
      *
     P                 E
      *
      *===================================================================*
      *  Funktion:  f_nbrDspRw                                 (Body)     *
      *===================================================================*
      *
     P f_nbrDspRw      B                   Export
     D                 PI                         like(int4_t)
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      *
      * Funktionswert
     D nbrDspRow       S                   like(int4_t)
     D                                     inz
      *
      * Arbeitsfelder
     D dsplyLen        S                   like(int4_t)
      *------------------------------------------------------------*
      *
     C                   If        f_isToLong(i_FLDL0100) = bTrue
     C                   Eval      dsplyLen = f_maxDspLn(i_FLDL0100)
     C                   Else
     C                   Eval      dsplyLen = f_dsplyLn(i_FLDL0100)
     C                   Endif
      *
     C                   Eval      nbrDspRow = dsplyLen / f_cntFldLn(i_FLDL0100)
      *
     C                   If        dsplyLen <>
     C                                (nbrDspRow * f_cntFldLn(i_FLDL0100))
     C                   Eval      nbrDspRow = nbrDspRow + 1
     C                   Endif
      *
     C                   Return    nbrDspRow
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_decToBin                                 (Body)     *
      *===================================================================*
      *
     P p_decToBin      B                   Export
     D                 PI                  opdesc
     D  io_string                 32767A          options(*varsize)
     D  i_startPos                         const  like(int4_t)
     D  i_length                           const  like(int4_t)
     D  i_value                            const  like(int4_t)
      *
      * Parameters passed to CEEDOD
     D DescType        S             10I 0
     D DataType        S             10I 0
     D DescInfo1       S             10I 0
     D DescInfo2       S             10I 0
     D parmLen         S             10I 0
      *
      * Arbeitsfelder
     D                 DS
     D intValue                            like(int4_t) inz
     D alpha2                         2A   overlay(intValue: 3)
     D alpha4                         2A   overlay(intValue: 1)
      * ------------------------------------------------------------------------
      *
     C                   CALLP     CEEDOD(1         : DescType : DataType :
     C                                    DescInfo1 : DescInfo2: parmLen  :
     C                                    *OMIT)
      *
     C                   If        (i_startpos + i_length - 1) > parmLen
     C                   Callp     p_kill('Start position and length outside +
     C                                    range.')
     C                   Else
     C                   Eval      intValue = i_value
     C                   Select
     C                   When      i_length = 2
     C                   Eval      %subst(io_string  :
     C                                    i_startPos :
     C                                    i_length   ) = alpha2
     C                   When      i_length = 4
     C                   Eval      %subst(io_string  :
     C                                    i_startPos :
     C                                    i_length   ) = alpha4
     C                   Other
     C                   Callp     p_kill('Incorrect length: ' +
     C                                    %char(i_length))
     C                   Endsl
     C                   Endif
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Funktion:  f_isNotAlw                                 (Body)     *
      *===================================================================*
      *
     P f_isNotAlw      B                   Export
     D                 PI                         like(bool_t)
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      *
      * Funktionswert
     D notAllowed      S                   like(bool_t) inz(bTrue)
      * ------------------------------------------------------------------------
      *
      *  Wenn es sich um einen der folgenden Feldtypen handelt, ...
     C                   If        (i_FLDL0100.F1DTyp = 'A') or                 = Alpha
     C                             (i_FLDL0100.F1DTyp = 'B') or                 = Binary
     C                             (i_FLDL0100.F1DTyp = 'P') or                 = Packed
     C                             (i_FLDL0100.F1DTyp = 'S') or                 = Zoned
     C                             (i_FLDL0100.F1DTyp = 'L') or                 = Date
     C                             (i_FLDL0100.F1DTyp = 'T') or                 = Time
     C                             (i_FLDL0100.F1DTyp = 'Z') or                 = Timestamp
    -C                             (i_FLDL0100.F1DTyp = 'J') or                 = DBCS-Only
    -C                             (i_FLDL0100.F1DTyp = 'O') or                 = DBCS-Open
    -C                             (i_FLDL0100.F1DTyp = 'E') or                 = DBCS-Either
    -C                             (i_FLDL0100.F1DTyp = 'F') or                 = Float
    -C                             (i_FLDL0100.F1DTyp = 'G')                    = Graphic
      *  ... dann
      *      prüfen, ob es sich um ein GRAPHIC Feld ohne CCSID handelt
    -C                   If        (i_FLDL0100.F1DTyp = 'G' and
     C                              f_hasCcsid(i_FLDL0100) = bFalse)
     C                   Eval      notAllowed = bTrue
     C                   Return    notAllowed
     C                   Endif
      *
      *      prüfen, ob es sich um ein Packed oder Zoned Feld mit mehr als
      *      30 Stellen handelt.
     C                   If        (i_FLDL0100.F1DTyp = 'P' or
     C                              i_FLDL0100.F1DTyp = 'S')
     C                   If        (i_FLDL0100.F1DIGT > 30)
     C                   Eval      notAllowed = bTrue
     C                   Return    notAllowed
     C                   Endif
     C                   Endif
      *
      *      prüfen, ob es sich um ein Feld variabler Länge handelt.
      *
      *      Wenn es sich um ein Feld variabler Länge handelt, ...
     C                   If        f_isVarLen(i_FLDL0100) = bTrue
      *      ... dann
      *          prüfen, ob es sich um alpha-numerisches Feld handelt.
     C                   If        i_FLDL0100.F1DTyp = 'A' or                   = Alpha
     C                             i_FLDL0100.F1DTyp = 'G'                      = Graphic
     C                   Eval      notAllowed = bFalse
     C                   Else
     C                   Eval      notAllowed = bTrue
     C                   Endif
     C                   Else
      *      ... sonst
      *          ist alles klar.
     C                   Eval      notAllowed = bFalse
     C                   Endif
     C                   Else
      *  ... sonst
      *      setzen Markierung für unbekannten Feldtyp
     C                   Eval      notAllowed = bTrue
     C                   Endif
      *
     C                   Return    notAllowed
      *
     P                 E
      *
      *===================================================================*
      *  Funktion:  f_isKeyFld                                 (Body)     *
      *===================================================================*
      *
     P f_isKeyFld      B                   Export
     D                 PI                         like(bool_t)
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      *
      * Funktionswert
     D isKeyFld        S                   like(bool_t) inz(bFalse)
      * ------------------------------------------------------------------------
      *
      *  Wenn es sich um ein Schlüsselfeld handelt, ...
     C                   If        (i_FLDL0100.F1KeyF = '1')
      *  ... dann
     C                   Eval      isKeyFld = bTrue
     C                   Else
      *  ... sonst
     C                   Eval      isKeyFld = bFalse
     C                   Endif
      *
     C                   Return    isKeyFld
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  f_pgmCallN                                 (Body)     *
      *===================================================================*
      *
     P f_pgmCallN      B                   Export
     D                 PI                         like(pgmCallN_t)
     D  i_pgmNme                           const  like(pgm_t)
      *------------------------------------------------------------*
      *
     C                   Return    %trimr(f_getPrdLb) + '/' + i_pgmNme
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_sndStsMg                                 (Body)     *
      *===================================================================*
      *
     P p_sndStsMg      B                   Export
     D                 PI
     D  i_msgID                            const like(msgID_t)
     D  i_msgDta                           const like(msgDta_t)
      *
      *  Parameter für QMHSNDPM API
     D yMsgID          S                   like(msgID_t)
     D                                     inz
     D yQMsgF          DS
     D  yMsgF                              like(file_t)  inz
     D  yMsgFL                             like(lib_t)  inz
     D yMsgDta         S                   like(msgDta_t)
     D                                     inz
     D yMsgDtaLen      S                   like(int4_t)
     D                                     inz
     D yMsgType        S             10A
     D                                     inz
     D yStkE           S                   like(proc_t)
     D                                     inz
     D yStkCnt         S                   like(int4_t)
     D                                     inz
     D yMsgKey         S              4A   inz
     D yErrCode        DS                  likeds(errCode_t ) inz
      *------------------------------------------------------------*
      *
     C                   If        i_msgID <> ' '
      *
     C                   EVAL      yMsgID       = i_msgID
     C                   EVAL      yMsgF        = f_appMsgF
     C                   EVAL      yMsgFL       = f_appMsgFL
     C                   EVAL      yMsgDta      = i_msgDta
     C                   EVAL      yMsgDtaLen   = %size(yMsgDta)
     C                   EVAL      yMsgType     = '*STATUS'
     C                   EVAL      yStkE        = '*EXT'
     C                   EVAL      yStkCnt      = 0
     C                   EVAL      yMsgKey      = ' '
     C                   Reset                   yErrCode
     C                   Eval      yErrCode.bytPrv = %size(yErrCode)
      *
     C                   Call      'QMHSNDPM'
     C                   Parm                    yMsgID
     C                   Parm                    yQMsgF
     C                   Parm                    yMsgDta
     C                   Parm                    yMsgDtaLen
     C                   Parm                    yMsgType
     C                   Parm                    yStkE
     C                   Parm                    yStkCnt
     C                   Parm                    yMsgKey
     C                   Parm                    yErrCode
      *
     C                   Endif
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  f_rtvMsgD                                  (Body)     *
      *===================================================================*
      *
     P f_rtvMsgD       B                   Export
     D                 PI          2048A
     D  i_msgID                            value  like(msgID_t)
     D  i_msgDta                           value  like(msgDta_t)
     D  i_rplcSubV                         const  like(bool_t)
     D                                            options(*nopass)
     D  i_rtnFmtCC                         const  like(bool_t)
     D                                            options(*nopass)
     D  i_msgF                             value  like(file_t)
     D                                            options(*nopass)
     D  i_msgFL                            value  like(lib_t)
     D                                            options(*nopass)
      *
      *  Parameterpositionen optionaler Parameter
     D p_rplcSubV      C                   const(3)
     D p_rtnFmtCC      C                   const(4)
     D p_msgF          C                   const(5)
     D p_msgFL         C                   const(6)
      *
      *  Funktionswert
      /COPY QCOPYLE,RTVM0100
      *
      *  Parameter für QMHSNDPM
     D msgDLen         S             10I 0 inz
     D format          S              8A   inz
     D qMsgF           DS
     D  msgF                               like(file_t)  inz
     D  msgFL                              like(lib_t)  inz
     D msgDtaLn        S             10I 0 inz
     D rplcSubV        S             10A   inz
     D rtnFmtCC        S             10A   inz
     D errCode         DS                  likeds(errCode_t ) inz
      *
      *------------------------------------------------------------*
      *
     C                   Clear                   RTVM0100
     C                   Eval      msgDLen  = %len(RTVM0100)
     C                   Eval      format   = 'RTVM0100'
      *
     C                   If        %parms >= p_msgF
     C                   Eval      msgF  = i_msgF
     C                   Else
     C                   Eval      msgF  = f_appMsgF
     C                   Endif
      *
     C                   If        %parms >= p_msgFL
     C                   Eval      msgFL = i_msgFL
     C                   Else
     C                   Eval      msgFL = f_appMsgFL
     C                   Endif
      *
     C                   Eval      msgDtaLn = %len(i_msgDta)
      *
      *  Replace substitution variables
     C                   If        %parms >= p_rplcSubV
     C                   If        i_rplcSubV = bTrue
     C                   Eval      rplcSubV = '*YES'
     C                   Else
     C                   Eval      rplcSubV = '*NO'
     C                   Endif
     C                   Else
     C                   Eval      rplcSubV = '*NO'
     C                   Endif
      *
      *  Return format control characters
     C                   If        %parms >= p_rtnFmtCC
     C                   If        i_rtnFmtCC = bTrue
     C                   Eval      rtnFmtCC = '*YES'
     C                   Else
     C                   Eval      rtnFmtCC = '*NO'
     C                   Endif
     C                   Else
     C                   Eval      rtnFmtCC = '*NO'
     C                   Endif
      *
     C                   Reset                   errCode
     C                   Eval      errCode.bytPrv = %size(errCode)
      *
     C                   Call      'QMHRTVM'
     C                   Parm                    RTVM0100
     C                   Parm                    msgDLen
     C                   Parm                    format
     C                   Parm                    i_msgID                        Msg ID
     C                   Parm                    qMsgF                          Msg File
     C                   Parm                    i_msgDta                       Msg Dta
     C                   Parm                    msgDtaLn                       Msg Dta Len
     C                   Parm                    rplcSubV                       Msg Repl Sub
     C                   Parm                    rtnFmtCC                       Ret Form Cha
     C                   Parm                    errCode
      *
     C                   Return    RTVM0100
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  f_msgText                                  (Body)     *
      *===================================================================*
      *
     P f_msgText       B                   Export
     D                 PI           512A
     D  i_msgID                            value  like(msgID_t)
     D  i_msgDta                           value  like(msgDta_t)
     D  i_msgF                             value  like(file_t)
     D                                            options(*nopass)
     D  i_msgFL                            value  like(lib_t)
     D                                            options(*nopass)
      *
      *  Parameterpositionen optionaler Parameter
     D p_msgF          C                   const(3)
     D p_msgFL         C                   const(4)
      *
      *  Funktionswert
     D msgText         S            512A   inz
      *
      /COPY QCOPYLE,RTVM0100
      *------------------------------------------------------------*
      *
     C                   Select
     C                   When      %parms =  p_msgF
     C                   Eval      RTVM0100 = f_rtvMsgD(i_msgID :i_msgDta:
     C                                                  bTrue   :bFalse  :
     C                                                  i_msgF           )
     C                   When      %parms =  p_msgFL
     C                   Eval      RTVM0100 = f_rtvMsgD(i_msgID :i_msgDta:
     C                                                  bTrue   :bFalse  :
     C                                                  i_msgF  :i_msgFL )
     C                   Other
     C                   Eval      RTVM0100 = f_rtvMsgD(i_msgID :i_msgDta:
     C                                                  bTrue   :bFalse  )
     C                   Endsl
      *
     C                   If        RT1_LnMgRt > 0
     C                   Eval      msgText = %subst(RT1_Data: 1: RT1_LnMgRt)
     C                   Else
     C                   Eval      msgText = ' '
     C                   Endif
      *
     C                   Return    msgText
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_movPgmMg                                 (Body)     *
      *===================================================================*
      *
     P p_movPgmMg      B                   Export
     D                 PI
     D  i_pgmNme                           const  like(pgm_t)
      *
      *  Parameter für QMHMOVPM
     D msgKey          S              4A   inz
     D typToMove       DS
     D  toMove_1                     10A   inz('*COMP')
     D  toMove_2                     10A   inz('*DIAG')
     D  toMove_3                     10A   inz('*INFO')
     D  toMove_4                     10A   inz('*ESCAPE')
     D nbrToMove       S                   like(int4_t) inz(4)
     D toStkE          S                   like(proc_t) inz
     D toStkCnt        S                   like(int4_t) inz(2)
     D errCode         DS                  likeds(errCode_t ) inz
     D toStkELn        S                   like(int4_t) inz
     D toQStkE         DS
     D  toStkEMod                          like(mod_t) inz
     D  toStkEPgm                          like(pgm_t) inz
     D toStkEDT        S             10A   inz('*CHAR')
     D frmStkE         S               *   inz(*null)
     D frmStkECnt      S                   like(int4_t) inz(1)
      *------------------------------------------------------------*
      *
     C                   Eval      toStkE    = i_pgmNme
     C                   Eval      toStkELn  = %len(toStkE)
     C                   Eval      toStkEMod = i_pgmNme
     C                   Eval      toStkEPgm = i_pgmNme
      *
     C                   Call      'QMHMOVPM'
     C                   Parm                    msgKey
     C                   Parm                    typToMove
     C                   Parm                    nbrToMove
     C                   Parm                    toStkE
     C                   Parm                    toStkCnt
     C                   Parm                    errCode
     C                   Parm                    toStkELn                       ! optional 1
     C                   Parm                    toQStkE                        !
     C                   Parm                    toStkEDT                       ! optional 2
     C                   Parm                    frmStkE                        !
     C                   Parm                    frmStkECnt                     !
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_wrongKey                                 (Body)     *
      *===================================================================*
      *
     P p_wrongKey      B                   Export
     D                 PI
     D  i_scnAID                           const  like(scnAID_t)
     D  i_pgmNme                           const  like(pgm_t)
      *
      *  Arbeitsfelder
     D                 DS
     D msgID                               like(msgID_t) inz('AID')
     D msgNbr                         4A   overlay(msgID: 4)
     D msgDta          S                   like(msgDta_t) inz
      *------------------------------------------------------------*
      *
     C                   Callp     p_keyToMsg(i_scnAID: msgID: msgDta)
     C                   Callp     p_sndPgmMg(msgID: msgDta: i_pgmNme)
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_keyToMsg                                 (Body)     *
      *===================================================================*
      *
     P p_keyToMsg      B                   Export
     D                 PI
     D  i_scnAID                           const  like(scnAID_t)
     D  o_msgID                                   like(msgID_t)
     D  o_msgDta                                  like(msgDta_t)
      *
      *  Arbeitsfelder
     D                 DS
     D msgID                               like(msgID_t) inz
     D msgNbr                         4A   overlay(msgID: 4)
     D msgDta          S                   like(msgDta_t) inz
      *------------------------------------------------------------*
      *
     C                   Eval      msgID  = 'AID'
     C                   Eval      msgDta = ' '
      *
     C                   Select
     C                   When      i_scnAID = K_F1
     C                   Eval      msgNbr   = '0031'
     C                   When      i_scnAID = K_F2
     C                   Eval      msgNbr   = '0032'
     C                   When      i_scnAID = K_F3
     C                   Eval      msgNbr   = '0033'
     C                   When      i_scnAID = K_F4
     C                   Eval      msgNbr   = '0034'
     C                   When      i_scnAID = K_F5
     C                   Eval      msgNbr   = '0035'
     C                   When      i_scnAID = K_F6
     C                   Eval      msgNbr   = '0036'
     C                   When      i_scnAID = K_F7
     C                   Eval      msgNbr   = '0037'
     C                   When      i_scnAID = K_F8
     C                   Eval      msgNbr   = '0038'
     C                   When      i_scnAID = K_F9
     C                   Eval      msgNbr   = '0039'
     C                   When      i_scnAID = K_F10
     C                   Eval      msgNbr   = '003A'
     C                   When      i_scnAID = K_F11
     C                   Eval      msgNbr   = '003B'
     C                   When      i_scnAID = K_F12
     C                   Eval      msgNbr   = '003C'
     C                   When      i_scnAID = K_F13
     C                   Eval      msgNbr   = '00B1'
     C                   When      i_scnAID = K_F14
     C                   Eval      msgNbr   = '00B2'
     C                   When      i_scnAID = K_F15
     C                   Eval      msgNbr   = '00B3'
     C                   When      i_scnAID = K_F16
     C                   Eval      msgNbr   = '00B4'
     C                   When      i_scnAID = K_F17
     C                   Eval      msgNbr   = '00B5'
     C                   When      i_scnAID = K_F18
     C                   Eval      msgNbr   = '00B6'
     C                   When      i_scnAID = K_F19
     C                   Eval      msgNbr   = '00B7'
     C                   When      i_scnAID = K_F20
     C                   Eval      msgNbr   = '00B8'
     C                   When      i_scnAID = K_F21
     C                   Eval      msgNbr   = '00B9'
     C                   When      i_scnAID = K_F22
     C                   Eval      msgNbr   = '00BA'
     C                   When      i_scnAID = K_F23
     C                   Eval      msgNbr   = '00BB'
     C                   When      i_scnAID = K_F24
     C                   Eval      msgNbr   = '00BC'
     C                   When      i_scnAID = K_DELETE
     C                   Eval      msgNbr   = '00BD'
     C                   When      i_scnAID = K_ENTER
     C                   Eval      msgNbr   = '00F1'
     C                   When      i_scnAID = K_HELP
     C                   Eval      msgNbr   = '00F3'
     C                   When      i_scnAID = K_PAGE_DOWN
     C                   Eval      msgNbr   = '00F4'
     C                   When      i_scnAID = K_PAGE_UP
     C                   Eval      msgNbr   = '00F5'
     C                   When      i_scnAID = K_PRINT_SCREEN
     C                   Eval      msgNbr   = '00F6'
     C                   When      i_scnAID = K_RESET
     C                   Eval      msgNbr   = '00F8'
     C                   When      i_scnAID = K_LIGHT_PEN
     C                   Eval      msgNbr   = '003F'
     C                   Other
     C                   Eval      msgNbr   = '0100'
     C                   Endsl
      *
     C                   Eval      o_msgID  = msgID
     C                   Eval      o_msgDta = msgDta
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  f_spltTxt                                  (Body)     *
      *===================================================================*
      *
     P f_spltTxt       B                   Export
     D                 PI                  opdesc like(int4_t)
     D  i_text                    32767A   const  options(*varsize)
     D  i_strPos                           const  like(int4_t)
     D  i_len                              const  like(int4_t)
     D  o_text                    32767A          options(*varsize)
      *
      *  Funktionswert
     D rtnLen          S                   like(int4_t) inz
      *
      *  Arbeitsfelder
     D pNewLine        S                   like(int4_t) inz
     D iTxtLen         S                   like(int4_t) inz
     D oTxtLen         S                   like(int4_t) inz
     D nextChar        S              1A   inz
     D trimLen         S                   like(int4_t) inz
      *
      * Parameters passed to CEEDOD
     D DescType        S             10I 0
     D DataType        S             10I 0
     D DescInfo1       S             10I 0
     D DescInfo2       S             10I 0
     D parmLen         S             10I 0
      *------------------------------------------------------------*
      *
     C                   Callp     CEEDOD(1         : DescType : DataType :
     C                                    DescInfo1 : DescInfo2: iTxtLen  :
     C                                    *OMIT)
      *
     C                   Callp     CEEDOD(4         : DescType : DataType :
     C                                    DescInfo1 : DescInfo2: oTxtLen  :
     C                                    *OMIT)
      *
      *  Wenn die Startposition außerhalb des gültigen
      *  Bereichs liegt, ...
     C                   If        i_strPos > iTxtLen
      *  ... dann
      *      einen Leerstring zurück geben
     C                   Eval      %subst(o_Text: 1: otxtLen) = ' '
     C                   Eval      rtnLen = 0
     C                   Else
      *  ... sonst
      *      prüfen zu entnehmende Länge
     C                   If        (i_strPos + i_len - 1) <= iTxtLen
     C                   Eval      rtnLen = i_len
     C                   Else
     C                   Eval      rtnLen = iTxtLen - i_strPos + 1
     C                   Endif
      *
     C                   If        rtnLen > oTxtLen
     C                   Eval      rtnLen = oTxtLen
     C                   Endif
      *
      *      Zeichenkette entnehmen
     C                   Eval      %subst(o_Text: 1: otxtLen) =
     C                                %subst(i_Text: i_strPos: rtnLen)
      *
      *      Auf Zeilenwechsel prüfen
     C                   Eval      pNewLine =
     C                                %scan('°': %subst(o_Text: 1: otxtLen))
     C                   If        pNewLine > 0
     C                   Eval      rtnLen = pNewLine
     C                   Eval      %subst(o_Text
     C                                    : rtnLen
     C                                    : otxtLen - rtnLen + 1) = ''
     C                   Endif
      *
      *      Bestimmen Länge ohne nachgestellte Leezeichen
     C                   Eval      trimLen =
     C                                %len(%trimr(%subst(o_Text: 1: rtnLen)))
      *
      *      Wenn keine nachgestellten Leezeichen
      *      vorhanden sind, ...
     C                   If        rtnLen = trimLen
      *      ... dann
      *          Folgezeichen im Eingabestring prüfen
     C                   If        itxtLen > rtnLen
     C                   Eval      nextChar = %subst(i_text: rtnLen + 1: 1)
      *
      *          Wenn das Folgezeichen <> ' ' ist, d.h.
      *          wir befinden uns mitten in der Zeichenkette, ...
     C                   If        (nextChar <> ' ') and (nextChar <> '°')
      *          ... dann
      *              rückwärts nach einer Lücke für
      *              den Zeilenumbruch suchen
     C                   Dow       trimLen > 0
     C                   If        %subst(o_text: trimLen: 1) = ' '
     C                   Eval      rtnLen = trimLen
     C                   Eval      %subst(o_Text: 1: otxtLen) =
     C                                %subst(o_Text: 1: rtnLen)
     C                   Leave
     C                   Endif
     C                   Eval      trimLen = trimLen - 1
     C                   Enddo
      *
     C                   Endif
     C                   Endif
     C                   Endif
     C                   Endif
      *
     C                   Return    rtnLen
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_center                                   (Body)     *
      *===================================================================*
      *
     P p_center        B                   Export
     D                 PI                  opdesc
     D  io_text                   32767A          options(*varsize)
      *
      *  Arbeitsfelder
     D textLen         S                   like(int4_t) inz
     D iPreSpc         S                   like(int4_t) inz
     D iPostSpc        S                   like(int4_t) inz
     D trimLen         S                   like(int4_t) inz
     D oPreSpc         S                   like(int4_t) inz
     D oPostSpc        S                   like(int4_t) inz
      *
      * Parameters passed to CEEDOD
     D DescType        S             10I 0
     D DataType        S             10I 0
     D DescInfo1       S             10I 0
     D DescInfo2       S             10I 0
     D parmLen         S             10I 0
      *------------------------------------------------------------*
      *
      *  Ermitteln Länge der Zeichenfolge
     C                   Callp     CEEDOD(1         : DescType : DataType :
     C                                    DescInfo1 : DescInfo2: textLen  :
     C                                    *OMIT)
      *
      *  Ermitteln Anzahl führender und nachgestellter Leerzeichen
      *  für Eingangszeichenfolge
     C                   Eval      iPreSpc  = textLen -
     C                                %len(%triml(%subst(io_text: 1: textLen)))
      *
     C                   Eval      iPostSpc = textLen -
     C                                %len(%trimr(%subst(io_text: 1: textLen)))
      *
      *  Ermitteln Länge der Zeichenfolge ohne Leerzeichen
     C                   Eval      trimLen  = textLen - iPreSpc - iPostSpc
      *
      *  Ermitteln Anzahl führender und nachgestellter Leerzeichen
      *  für zentrierte Zeichenfolge
     C                   Eval      oPreSpc  = textLen - trimLen
     C                   Div       2             oPreSpc
     C                   Eval      oPostSpc = textLen - trimLen - oPreSpc
      *
      *  Wenn Leerzeichen vorangestellt werden müssen, ...
     C                   If        (oPreSpc >  0      )  and
     C                             (oPreSpc <> iPreSpc)
      *  ... dann
      *      Zeichenkette verschieben
     C                   Eval      %subst(io_text: oPreSpc + 1: trimLen) =
     C                                %subst(io_text: iPreSpc + 1: trimLen)
      *      Führende Leerzeichen löschen
     C                   Eval      %subst(io_text: 1: oPreSpc) = ' '
      *      Nachgestellte Leerzeichen löschen
     C                   If        oPostSpc > 0
     C                   Eval      %subst(io_text               :
     C                                    textLen - oPostSpc + 1:
     C                                    oPostSpc              ) = ' '
     C                   Endif
     C                   Endif
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  f_addPtr                                   (Body)     *
      *===================================================================*
      *
     P f_addPtr        B                   Export
     D                 PI              *
     D  i_pointer                      *   value
     D  i_offset                      5I 0 value
      *
      *  Arbeitsfelder
     D ofsAry          S              1A   dim(32767) based(pOfsAry)
      *------------------------------------------------------------*
      *
     C                   Dow       i_offset > 0
      *
     C                   Eval      pOfsAry = i_pointer
      *
     C                   If        i_offset <= %elem(ofsAry) - 1
     C                   Eval      i_pointer = %addr(ofsAry(i_offset + 1))
     C                   Eval      i_offset = 0
     C                   Else
     C                   Eval      i_pointer = %addr(ofsAry(%elem(ofsAry)))
     C                   Eval      i_offset = i_offset - %elem(ofsAry) + 1
     C                   Endif
      *
     C                   Enddo
      *
     C                   Return    i_pointer
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  f_isKeyExc                                 (Body)     *
      *===================================================================*
      *
     P f_isKeyExc      B                   Export
     D                 PI                        like(bool_t)
     D  i_data                             value like(SET0000_t)
     D  i_exclKeys                         value like(pgmCmd_t) DIM(25)
      *
      *  Funktionswert
     D isExcluded      S                   like(bool_t) inz
      *
      *  Arbeitsfelder
     D pgmCmd          S                   like(pgmCmd_t) inz
     D in01            S                   like(*in01     ) inz
      *------------------------------------------------------------*
      *
     C                   Eval      in01 = *in01
      *
     C                   Eval      pgmCmd = i_data
     C     pgmCmd        Lookup    i_exclKeys                             01
     C                   If        *in01 = '1'
     C                   Eval      isExcluded = bTrue
     C                   Else
     C                   Eval      isExcluded = bFalse
     C                   Endif
      *
     C                   Eval      *in01 = in01
      *
     C                   Return    isExcluded
      *
     P                 E
      *
      *===============================================================*
      *  Prepare NUM_Descr - RPG-IV implementation of NUM_DESCR macro
      *  V4R4 and above                Refer to: QSYSINC/MIH.MICPTCOM
      *===============================================================*
      * The following macro is used to prepare the numeric descriptor
      * (_NUM_Descr_T), used in the cpynv and edit functions. Can also
      * be used to set the type and length fields of _DPA_Template_T.
      * The valid values for the parameters are:
      *    type         length             fractional
      *    -----------  -----------------  -------------------------
      *    _T_Signed    2 or 4             0
      *    _T_Float     4 or 8             0
      *    _T_Zoned     1 <= length <= 31  0 <= fractional <= length
      *    _T_Packed    1 <= length <= 31  0 <= fractional <= length
      *    _T_Unsigned  2 or 4             0
      *
      *===============================================================*
      *
     P f_NUM_Descr...
     P                 B                   export
     D                 PI            10I 0
     D  i_type                        3I 0 value
     D  i_length                      3I 0 value
     D  i_fraction                    3I 0 value
      *
     D                 DS
     D NUM_Descr                     10I 0 inz
     D  NUM_Descr_type...
     D                                3I 0 overlay(NUM_Descr: 1)
     D  NUM_Descr_fraction...
     D                                3I 0 overlay(NUM_Descr: 2)
     D  NUM_Descr_length...
     D                                3I 0 overlay(NUM_Descr: 3)
      *
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      *
     C                   Eval      NUM_Descr_type     = i_type
     C                   Eval      NUM_Descr_fraction = i_fraction
     C                   Eval      NUM_Descr_length   = i_length
      *
     C                   Return    NUM_Descr
      *
     P                 E
      *
      *========================================================================*
      *  f_NUM_Descr2
      *========================================================================*
     P f_NUM_Descr2...
     P                 B                          export
     D                 PI            10I 0
     D  i_type                        1A   value
     D  i_length                      3I 0 value
     D  i_fractional                  3I 0 value
      *
      *  Parameter positions
      *
      *  Return value
     D                 DS
     D NUM_Descr                     10I 0 inz
     D  NUM_Descr_24                  3I 0 overlay(NUM_Descr: 1)
     D  NUM_Descr_16                  3I 0 overlay(NUM_Descr: *NEXT)
     D  NUM_Descr_8                   3I 0 overlay(NUM_Descr: *NEXT)
     D  NUM_Descr_0                   3I 0 overlay(NUM_Descr: *NEXT)
      *
      *  Arbeitsfelder
     D type            S              3I 0 inz
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

       // Convert RPG type ...
       select;
       // ... zoned
       when (i_type = 'S');
         type = T_ZONED;
       // ... packed
       when (i_type = 'P');
         type = T_PACKED;
       // ... binary
       when (i_type = 'B');
         type = T_SIGNED;
         i_length = f_rpgToIntLength(i_length);
       // ... integer
       when (i_type = 'I');
         type = T_SIGNED;
         i_length = f_rpgToIntLength(i_length);
       // ... unsigned integer
       when (i_type = 'U');
         type = T_SIGNED;
         i_length = f_rpgToIntLength(i_length);
       // ... float
       when (i_type = 'F');
         type = T_FLOAT;
       endsl;

       NUM_Descr = f_NUM_Descr(type: i_length: i_fractional);

       return NUM_Descr;

      /END-FREE
      *
     P                 E
      *
      *========================================================================*
      *  Converts a given RPG numeric field length to an integer length.
      *========================================================================*
     P f_rpgToIntLength...
     P                 B                          export
     D                 PI            10I 0
     D  i_length                     10I 0 value
      *
      *  Return value
     D intLength       S             10I 0 inz
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

       select;
       when (i_length <= 3);
         intLength = 1;
       when (i_length <= 5);
         intLength = 2;
       when (i_length <= 10);
         intLength = 4;
       when (i_length <= 20);
         intLength = 8;
       other;
         intLength = -1;
       endsl;

       return intLength;

      /END-FREE
      *
     P                 E
      *
      *===============================================================*
      *  Clears C error code.
      *===============================================================*
      *
     P p_clrErrno...
     P                 B                   export
     D                 PI
      *
     D runTimeError    S             10I 0 based(pRunTimeError)
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

       pRunTimeError = errno();
       runTimeError = 0;

       return;

      /END-FREE
     P                 E
      *
      *===============================================================*
      *  Returns C runtime error code.
      *===============================================================*
      *
     P f_errno...
     P                 B                   export
     D                 PI            10I 0
      *
     D runTimeError    S             10I 0 based(pRunTimeError)
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

       pRunTimeError = errno();

       return runTimeError;

      /END-FREE
     P                 E
      *
      *===============================================================*
      *  Returns the description of a given C runtime error code.
      *===============================================================*
      *
     P f_strerror...
     P                 B                   export
     D                 PI                         like(msgDta_t)
     D  i_errno                      10I 0 const
      *
      *  Funktionswert
     D errText         S                   like(msgDta_t) inz
      *
     D pErrText        S               *   inz
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

       pErrText = strerror(i_errno);
       if   pErrText = *NULL;
         errText = '';
       else;
         errText = %str(pErrText);
       endif;

       return errText;

      /END-FREE
     P                 E
      *
      *===============================================================*
      *  Returns the bit-wise ORing of the bits of all the arguments.
      *===============================================================*
      *
     P f_bitor...
     P                 B                   export
     D                 PI            10U 0
     D  i_arg1                       10U 0 value
     D  i_arg2                       10U 0 value
     D  i_arg3                       10U 0 value  options(*nopass)
     D  i_arg4                       10U 0 value  options(*nopass)
     D  i_arg5                       10U 0 value  options(*nopass)
      *
      *  Parameterpositionen optionaler Parameter
     D p_arg3          C                   const(3)
     D p_arg4          C                   const(4)
     D p_arg5          C                   const(5)
      *
      *  Funktionswert
     D result          S             10U 0 inz
      *
      *  OR String (ORSTR)
     D ORSTR...
     D                 PR                  extproc('_ORSTR')
     D  i_pReceiver                    *   value
     D  i_pFirstSrc                    *   value  options(*string)
     D  i_pSecondSrc                   *   value  options(*string)
     D  i_length                     10U 0 value
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

       ORSTR(%addr(result): %addr(i_arg1): %addr(i_arg2): %size(result));

       return result;

      /END-FREE
     P                 E
      *
      *=========================================================================
      *  Checks object existance.
      *=========================================================================
      *  Parameters:
      *   i_obj         - The object to check for existance.
      *   i_lib         - The library that contains the object.
      *                   Default:        *LIBL
      *   i_type        - The type of the object.
      *   i_mbr         - The member that is checked in case of that
      *                   the object is a file.
      *                   Default:        *NONE
      *
      *  Returns:
      *   doesExists    - Returns bTrue when the object exists.
      *=========================================================================
     P f_exist...
     P                 B                   export
     D                 PI              N
     D  i_obj                        10A   const
     D  i_lib                        10A   const  options(*omit)
     D  i_type                       10A   const
     D  i_mbr                        10A   const  options(*nopass)
      *
      *  Return value
     D doesExist       S               N   inz(bFalse)
      *
      *  Parameter positions
     D p_lib           C                   const(2)
     D p_mbr           C                   const(4)
      *
      *  Optional parameter fields
     D lib             S                   like(i_lib       ) inz
     D mbr             S                   like(i_mbr       ) inz
      *
      *  Local fields
     D objd0100        DS                  likeds(objd0100_t) inz
     D mbrd0100        DS                  likeds(MBRD0100_t) inz
     D qObj            DS                  likeds(qObj_t) inz
     D errCode         DS                  likeds(errCode_t ) inz
      *
      *  Prototypen
     D QUSRMBRD        PR                         extpgm('QUSRMBRD')
     D  i_rcvVar                  32767A          options(*varsize)
     D  i_length                     10I 0 const
     D  i_format                      8A   const
     D  i_qFile                      20A   const
     D  i_mbr                        10A   const
     D  i_prcOverride                 1A   const
     D  io_ErrCode                32767A          options(*nopass: *varsize)    | optGrp 1
      *
      *  Prototypen
     D QUSROBJD        PR                         extpgm('QUSROBJD')
     D  i_rcvVar                  32767A          options(*varsize)
     D  i_length                     10I 0 const
     D  i_format                      8A   const
     D  i_qObj                       20A   const
     D  i_objType                    10A   const
     D  io_ErrCode                32767A          options(*nopass: *varsize)    | optGrp
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

       // Process optional parameter values ...
       // ... i_lib
       if (%parms() >= p_lib and %addr(i_lib) <> *NULL);
         lib = i_lib;
       else;
         lib = '*LIBL';
       endif;

       // ... i_mbr
       if (%parms() >= p_mbr);
         mbr = i_mbr;
       else;
         mbr = '*NONE';
       endif;

       // Retrieve the object description
       qObj.name = i_obj;
       qObj.lib  = lib;
       reset errCode;
       errCode.bytPrv = %size(errCode);
       QUSROBJD(objd0100: %size(objd0100): 'OBJD0100'
       : qObj: i_type: errCode);

       // Retrieve member description if object is a file
       // and a member name was given
       if (errCode.bytAvl = 0) and (mbr <> '*NONE');
         reset errCode;
         errCode.bytPrv = %size(errCode);
         QUSRMBRD(mbrd0100: %size(mbrd0100): 'MBRD0100'
         : qObj: mbr: '0': errCode);
       endif;

       // Set return value
       if (errCode.bytAvl = 0);
         doesExist = bTrue;
       else;
         doesExist = bFalse;
       endif;

       return doesExist;

      /END-FREE
     P                 E
      *
      *=========================================================================
      *  Performs word wrapping on a given string.
      *  Returns the next line of i_string with each call to f_wordWrap().
      *=========================================================================
      *  Parameters:
      *   i_string      - The string to be word wrapped.
      *   i_width       - Line length.
      *   io_startPos   - The position to start from.
      *                   (Should not be changed between calls.)
      *   i_option      - Options to set.
      *                   Default:        cWORDWRAP_PARAGRAPH_NONE +
      *                                   cWORDWRAP_PARAGRAPH_TRIMR
      *                   cWORDWRAP_PARAGRAPH_NONE   Do not respect
      *                                              end-of-paragraph markers.
      *                   cWORDWRAP_PARAGRAPH_MSGD   Respect end-of-paragraph
      *                                              markers of message descriptions:
      *                                              &N, &B and &P.
      *                   cWORDWRAP_PARAGRAPH_TEXT   Respect standard text
      *                                              end-of-paragraph markers: \n
      *                   cWORDWRAP_PARAGRAPH_TRIMR  Remove trailing blanks from
      *                                              result string.
      *
      *  Returns:
      *   text          - The next line of i_string.
      *=========================================================================
      *
     P f_wordWrap...
     P                 B                   export
     D                 PI          4096A          varying
     D  i_string                   4096A   const  varying
     D  i_width                      10U 0 const
     D  io_startPos                  10U 0
     D  i_options                    10U 0 const  options(*nopass)
      *
      *  Return value
     D text            S           4096A   inz    varying
      *
      *  Parameter positions
     D p_options       C                   const(4)
      *
      *  Optional parameter fields
     D options         S                   like(i_options) inz
      *
      *  Local fields
     D theEOP          DS                  qualified
     D  isFound                        N   inz(bFalse)
     D  position                     10I 0
     D  string                        2A   varying
     D x               S             10I 0                     inz
     D tmpEOP          S              2A   varying             inz
     D numEOP          S             10I 0                     inz
     D EOP             S                   like(tmpEOP) dim(3) inz
     D ESC             S              1A
     D startPos        S                   like(io_startPos  ) inz
     D string          S                   like(i_string     ) inz
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

       // Process optional parameter values ...
       // ... options
       if %parms >= p_options;
         options = i_options;
       else;
         options = cWORDWRAP_PARAGRAPH_NONE +
         cWORDWRAP_PARAGRAPH_TRIMR;
       endif;

       // TRIM trailing blanks
       string = %trimR(i_string);

       // Determine how to treat end-of-paragraph markers:
       select;
       // ... do not respect end-of-paragraph marker
       when f_isBitOn(cWORDWRAP_PARAGRAPH_NONE: options);
         clear EOP;
         clear ESC;
         numEOP = 0;
       // ... respect end-of-paragraph marker of message descriptions: &N, &P, &B
       when f_isBitOn(cWORDWRAP_PARAGRAPH_MSGD: options);
         clear EOP;
         EOP(1) = '&N';
         EOP(2) = '&P';
         EOP(3) = '&B';
         ESC    = '&';
         numEOP = 3;
       // ... respect end-of-paragraph marker of text: \n
       when f_isBitOn(cWORDWRAP_PARAGRAPH_TEXT: options);
         clear EOP;
         EOP(1) = '\N';
         ESC    = '\';
         numEOP = 1;
       endsl;

       // ---------------------------------------------------
       //  Perform word-wrap with no respect to
       //  end-of-paragraph markers.
       // ---------------------------------------------------
       if numEOP = 0;
         text = lf_wordWrap(string: i_width: io_startPos);
       else;
         // ---------------------------------------------------
         //  Perform word-wrap with respect to
         //  end-of-paragraph markers.
         // ---------------------------------------------------

         // Find next end-of-paragraph marker
         reset theEOP;
         theEOP.isFound = bFalse;
         theEOP.position = %scan(ESC: string: io_startPos);
         dow not theEOP.isFound and theEOP.position > 0;
           // If there is an escape character, ...
           if %subst(string: theEOP.position: 1) = ESC;
             // ... then check it against the list of EOP marker
             for x = 1 to numEOP;
               // If there is enough space for a EOP after the escape character
               // and if it is a known EOP, ...
               if theEOP.position <= %len(string) - %len(EOP(x)) + 1;
                 tmpEOP = %subst(string: theEOP.position: %len(EOP(x)));
                 if f_ucase(tmpEOP) = f_ucase(EOP(x));
                   // ... then set flag "EOP found"
                   theEOP.string  = EOP(x);
                   theEOP.isFound = bTrue;
                   leave;
                 endif;
               endif;
             endfor;
           endif;

           if (not theEOP.isFound);
             if (theEOP.position < %len(string));
               theEOP.position = %scan(ESC: string: theEOP.position + 1);
             else;
               theEOP.position = 0;
             endif;
           endif;
         enddo;

         // If no end-of-paragraph marker is found, ...
         if not theEOP.isFound;
           // ... then perform standard word wrap with no respect to EOP
           text = lf_wordWrap(string: i_width: io_startPos);
         else;
           // ... else perform word wrap for text portion
           //     before end-of-paragraph marker
           if (theEOP.position - io_startPos) > 0;
             string   = %subst(string: io_startPos:
               theEOP.position - io_startPos);
             startPos = 1;
             text = lf_wordWrap(string: i_width: startPos);
           else;
             text = '';
           endif;

           // If all we got is a EOP, ...
           if (%len(text)    = %len(theEOP.string)   ) and
           (f_ucase(text) = f_ucase(theEOP.string));
             // ... then delete it
             text = '';
           endif;
           // Set new start position. Skip EOP if EOP
           // caused new line.
           io_startPos = io_startPos + %len(text);
           if theEOP.position = io_startPos;
             io_startPos = io_startPos + %len(theEOP.string);
           endif;
           // Set start position to 0 if new start position
           // exceeds maximum length of text.
           if io_startPos > %len(i_string);
             io_startPos = 0;
           endif;
         endif;

       endif;

       // If the user requested to remove BLANKS, ...
       if f_isBitOn(cWORDWRAP_PARAGRAPH_TRIMR: options);
         // ... then remove BLANKS.
         text = %trimR(text);
       endif;

       return   text;

      /END-FREE
     P                 E
      *
      *=========================================================================
      *  Performs word wrapping on a given string without respect to
      *  end-of-paragraph markers.
      *=========================================================================
      *
     P lf_wordWrap...
     P                 B
     D                 PI          4096A          varying
     D  i_string                   4096A   const  varying
     D  i_width                      10U 0 const
     D  io_startPos                  10U 0
      *
      *  Return value
     D text            S           4096A   inz    varying
      *
      *  Local fields
     D sPos            S             10I 0 inz
     D ePos            S             10I 0 inz
     D ePosConst       S             10I 0 inz
     D length          S             10I 0 inz
     D char            S              1A   inz
     D x               S             10I 0 inz
      *
      *  Valid separater characters
     D cDELIMITER      C                   const(' -/\.:')
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

       // Initialise helper fields
       text   = '';
       sPos   = io_startPos;
       ePos   = 0;
       length = 0;

       // Set range
       ePos      = sPos + i_width;
       ePosConst = ePos;

       // If the end position is out of range ...
       if   ePos > %len(i_string);
         // ... then
         //     assume the last character to be the delimiter
         ePos = %len(i_string);
       else;
         // ... else
         //     look backwards for a deliniter.
         dow   ePos >= sPos;
           char = %subst(i_string: ePos: 1);
           // At position width + 1 ...
           if   ePos = ePosConst;
             // ... only BLANKS are allowed
             x = %check(' ': char);
           else;
             // ... else every delimiter is allowed
             x = %check(cDELIMITER: char);
           endif;
           // If there is a delimiter, ...
           if (x = 0 or char < x'40');
             // ... then stop searching
             x = 0;
             leave;
           endif;

           ePos = ePos - 1;
         enddo;
       endif;

       // If there is no delimiter, ...
       if   ePos < sPos;
         // ... then assume the last character to be the delimiter.
         ePos = sPos + i_width - 1;
       endif;

       // Retrieve text (incl. delimiter) ...
       length = ePos - sPos + 1;
       text = %subst(i_string: sPos: length);

       // ... and set new start position.
       sPos = sPos + length;
       if sPos <= %len(i_string);
         io_startPos = %check(' ': i_string: sPos);
       else;
         io_startPos = 0;
       endif;

       return   text;

      /END-FREE
     P                 E
      *
      *=========================================================================
      *  Tests for one or more bits.
      *=========================================================================
      *  Parameters:
      *   i_testBit     - The bits that are tested.
      *   i_value       - The numeric value that is tested for the bits.
      *
      *  Returns:
      *   isOn          - Returns bTrue when the bits specified at i_testBit
      *                   are set.
      *=========================================================================
      *
     P f_isBitOn...
     P                 B                   export
     D                 PI              N
     D  i_testBit                    10U 0 value
     D  i_value                      10U 0 value
      *
      *  Return value
     D isOn            S               N   inz(bTrue)
      *
      *  Helper fields
     D x               S              3I 0 inz
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

       isOn = bTrue;

       for   x = (%size(i_value) * 8) - 1 downTo 0 ;
         if   tstbts(%addr(i_testBit): x) <> 0;
           if   tstbts(%addr(i_value): x) = 0;
             isOn = bFalse;
             leave;
           endif;
         endif;
       endfor;

       return   isOn;

      /END-FREE
     P                 E
      *
      *=========================================================================
      *  Converts a given string to upper case.
      *=========================================================================
      *  Parameters:
      *   i_string      - The string to convert to upper case.
      *
      *  Returns:
      *   string        - The string converted to upper case.
      *=========================================================================
      *
     P f_ucase...
     P                 B                   export
     D                 PI          4096A           varying
     D  i_string                   4096A   const   varying
      *
      *  Return value
     D string          S           4096A   varying   inz
      *
      *  Fields for QlgConvertCase API
     D stringBuf       S           4096A             inz
     D errCode         DS                  likeds(errCode_t ) inz
      *
     D reqCtrlBlk      DS                  qualified
     D  type                         10I 0
     D  CCSID                        10I 0
     D  case                         10I 0
     D  reserved                     10A
      *
      *  Convert Case (QLGCNVCS, QlgConvertCase) API
     D QlgConvertCase  PR                         extproc('QlgConvertCase')
     D  i_reqCtrlBlk              32767A   const  options(*varsize)
     D  i_inData                  32767A   const  options(*varsize)
     D  o_outData                 32767A          options(*varsize)
     D  i_length                     10I 0 const
     D  io_ErrCode                32767A          options(*nopass: *varsize)
      *
      *
     D cCVTCASE_TYPE_ccsid...
     D                 C                   const(1)
     D cCVTCASE_TYPE_table...
     D                 C                   const(2)
     D cCVTCASE_TYPE_userDef...
     D                 C                   const(3)
     D cCVTCASE_toUpper...
     D                 C                   const(0)
     D cCVTCASE_toLower...
     D                 C                   const(1)
     D cCVTCASE_CCSID_Job...
     D                 C                   const(0)
      *
     D reqCtrlBlk_t    DS                  qualified           based(pDummy)
     D  type                         10I 0
     D  CCSID                        10I 0
     D  case                         10I 0
     D  reserved                     10A
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE


       if   i_string <> '';
         reqCtrlBlk.type     = cCVTCASE_TYPE_ccsid;
         reqCtrlBlk.CCSID    = cCVTCASE_CCSID_Job;
         reqCtrlBlk.case     = cCVTCASE_toUpper;
         reqCtrlBlk.reserved = *ALLx'00';
         reset errCode;
         QlgConvertCase(reqCtrlBlk:
         i_string: stringBuf: %len(i_string): errCode);
         string = %subst(stringBuf: 1: %len(i_string));
       else;
         string = i_string;
       endif;

       return   string;

      /END-FREE
     P                 E
      *
      *=========================================================================
      *  Tests if the specified string ends with the specified suffix.
      *=========================================================================
      *  Parameters:
      *   i_suffix      - The suffix.
      *   i_string      - The string that is tested.
      *
      *  Returns:
      *   endsWith      - Returns TRUE if the string ends with the suffix,
      *                   else FALSE.
      *=========================================================================
      *
     P f_endsWith...
     P                 B                   export
     D                 PI              N
     D  i_suffix                   4096A   const   varying
     D  i_string                   4096A   const   varying
      *
      *  Return value
     D endsWith        S               N   inz(bFalse)
      *
      *  Local fields
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

       if %len(i_string) = 0  or
       %len(i_suffix) = 0  or
       %len(i_string) < %len(i_suffix);
         return endsWith;
       endif;

       if %subst(i_string
       : %len(i_string) - %len(i_suffix) + 1) = i_suffix;
         endsWith = bTrue;
       endif;

       return   endsWith;

      /END-FREE
      *
     P                 E
      *
      *=========================================================================
      *  Sends a message to the command line.
      *=========================================================================
      *  Parameters:
      *   i_msg         - The message.
      *
      *  Returns:
      *   void
      *=========================================================================
     P f_sndMsgToCmdLine...
     P                 B                   export
     D                 PI
     D  i_msgID                       7A   const
     D  i_msgDta                    512A   const
      *
      *  Local fields
     D msgKey          S              4A                        inz
      *
     D qMsgF           DS                  qualified            inz
     D  name                         10A
     D  lib                          10A
      *
     D errCode         DS                  qualified            inz
     D  bytPrv                       10I 0
     D  bytAvl                       10I 0
     D  excID                         7A
     D  reserved                      1A
     D  excDta                      256A
      *
      *  Send Program Message (QMHSNDPM) API
     D QMHSNDPM        PR                         extpgm('QMHSNDPM')
     D   i_msgID                      7A   const
     D   i_qMsgF                     20A   const
     D   i_msgData                32767A   const  options(*varsize )
     D   i_length                    10I 0 const
     D   i_msgType                   10A   const
     D   i_callStkE               32767A   const  options(*varsize )
     D   i_callStkC                  10I 0 const
     D   o_msgKey                     4A
     D   io_ErrCode               32767A          options(*varsize )
     D   i_lenStkE                   10I 0 const  options(*nopass  )
     D   i_callStkEQ                 20A   const  options(*nopass  )
     D   i_wait                      10I 0 const  options(*nopass  )
     D   i_callStkEDT                10A   const  options(*nopass  )
     D   i_ccsid                     10I 0 const  options(*nopass  )
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

       clear qMsgF;
       qMsgF.name = f_appMsgF;
       qMsgF.lib  = f_appMsgFL;

       clear errCode;
       errCode.bytPrv = %size(errCode);

       QMHSNDPM(i_msgID: qMsgF: i_msgDta: %size(i_msgDta): '*DIAG'
       : 'PEEK': 2: msgKey: errCode);

       return;

      /END-FREE
      *
     P                 E
      *
      *===================================================================*
      *  Funktion:  f_fieldTypeAsString                        (Body)     *
      *===================================================================*
      *
     P f_fieldTypeAsString...
     P                 B                   Export
     D                 PI           128A          varying
     D  i_FLDL0100                         const  likeds(fldl0100_t)
      *
      *  Funktionswert
     D type            S            128A   varying inz
      *
      *  Arbeitsfelder
     D length          S              5S 0 inz
     D decPos          S              2S 0 inz
     D lengthA         S             16A   varying inz
     D decPosA         S             16A   varying inz
      * ------------------------------------------------------------------------
      /FREE

       if (f_isNumFld(i_FLDL0100) = bTrue);
         length = i_FLDL0100.F1DIGT;
         decPos = i_FLDL0100.F1DECP;
         lengthA = %editc(length: '3');
         decPosA = %editc(decPos: '3');
       else;
         length = i_FLDL0100.F1FLEN;
         decPos = -1;
         lengthA = %editc(length: '3');
         decPosA = '  ';
       endif;

       type = i_FLDL0100.F1FNME +
       '  ' + x'41'      +
       lengthA           +
       i_FLDL0100.F1DTYP +
       ' '               +
       decPosA           +
       x'41';

       return type;

      /END-FREE
      *
     P                 E
      *
      *===================================================================*
      *  Funktion:  f_nextHeaderType                           (Body)     *
      *===================================================================*
      *
     P f_nextHeaderType...
     P                 B                   Export
     D                 PI            10A
     D  i_headerType                 10A   value
      *
      *  Funktionswert
     D type            S             10A   inz
      * ------------------------------------------------------------------------
      /FREE

       Select;
       When (i_headerType = '*FIELDNAME');
         type = '*FIELDTEXT';
       When (i_headerType = '*FIELDTEXT');
         type = '*FIELDTYPE';
       Other;
         type = '*FIELDNAME';
       Endsl;

       return type;

      /END-FREE
      *
     P                 E
      *
      *===================================================================*
      *  Funktion:  f_getRecordFormatID                        (Body)     *
      *===================================================================*
      *
     P f_getRecordFormatInf...
     P                 B                   Export
     D                 PI                  likeds(rcdFmtInf_t)
     D  i_file                             value  like(file_t)
     D  i_lib                              value  like(lib_t)
     D  i_rcdFmt                           value  like(fmtID_t)
      *
      *  Funktionswert
     D rcdFmtInf       DS                  likeds(rcdFmtInf_t)
      *
     D qFile           DS                  likeds(qObj_t)
     D qFileRtn        DS                  likeds(qFile)
     D Qdb_Qddfmt      DS                  likeds(Qdb_Qddfmt_t)
     D                                     based(pQdb_Qddfmt)
     D size            S             10I 0
     D errCode         DS                  likeds(errCode_t) inz
      * ------------------------------------------------------------------------
      /FREE

       clear rcdFmtInf;

       qFile.name = i_file;
       qFile.lib = i_lib;

       size = (8);
       pQdb_Qddfmt = %alloc(size);

       monitor;
         QDBRTVFD(Qdb_Qddfmt: size: qFileRtn: 'FILD0200': qFile
         :'*FIRST' :'0' :'*LCL' :'*EXT' : errCode);

         size = (Qdb_Qddfmt.bytAvl);
         pQdb_Qddfmt = %realloc(pQdb_Qddfmt: size);
         QDBRTVFD(Qdb_Qddfmt: size: qFileRtn: 'FILD0200': qFile
         :'*FIRST' :'0' :'*LCL' :'*EXT' : errCode);

         rcdFmtInf.name = Qdb_Qddfmt.Qddfname;
         rcdFmtInf.ID = Qdb_Qddfmt.Qddfseq;
       on-error;
       endmon;

       dealloc(n) pQdb_Qddfmt;

       return rcdFmtInf;

      /END-FREE
     P                 E
      *
      *===================================================================*
      *  Funktion:  f_space                                    (Body)     *
      *===================================================================*
      *
     P f_space...
     P                 B                   Export
     D                 PI          4096A   varying
     D  i_length                     10I 0 value
      *
      *  Funktionswert
     D spaces          S           4096A   varying
      *
     D x               S             10I 0
      * ------------------------------------------------------------------------
      /FREE

       x = i_length;
       dow x > 0;
         spaces = spaces + ' ';
         x = x - 1;
       enddo;

       return spaces;

      /END-FREE
     P                 E
      *
      *===================================================================*
      *  Funktion:  Kills the program, sending an *ESCAPE message.        *
      *===================================================================*
     P p_kill...
     P                 B                   export
     D                 PI
     D  i_text                      128A   value  varying
      *
      *  Local fields
     D msgKey          S              4A   inz
      *
      *  Qualified message file name
     D qMsgF           DS                  qualified inz
     D  name                         10A
     D  lib                          10A
      *
      *  API error code
     D errCode         DS                  qualified inz
     D  bytPrv                       10I 0
     D  bytAvl                       10I 0
     D  excID                         7A
     D  reserved                      1A
     D  excDta                      256A
      *
      *  Send Program Message (QMHSNDPM) API
     D QMHSNDPM        PR                         extpgm('QMHSNDPM')
     D   i_msgID                      7A   const
     D   i_qMsgF                     20A   const
     D   i_msgData                32767A   const  options(*varsize )
     D   i_length                    10I 0 const
     D   i_msgType                   10A   const
     D   i_callStkE               32767A   const  options(*varsize )
     D   i_callStkC                  10I 0 const
     D   o_msgKey                     4A
     D   io_ErrCode               32767A          options(*varsize )
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /free
         clear qMsgF;
         qMsgF.name = 'QCPFMSG';
         qMsgF.lib  = '*LIBL';
         clear errCode;
         errCode.bytPrv = %size(errCode);
         QMHSNDPM('CPF9897': qMsgF: i_text: %len(i_text): '*ESCAPE'
                  : '*PGMBDY': 1: msgKey: errCode);
         return;
      /end-free
      *
     P                 E
      *
