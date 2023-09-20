      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 1.4.0                               *
      *  Programm : PEEK07                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 01.10.96  RADDATZ                                 *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Dokumentation:                                               *
      *                                                               *
      *  Ermitteln der Netzwerkattribute                              *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  INPUT-Parameter:                                             *
      *  ================                                             *
      *                                                               *
      *  XAttr   - Attributname                                       *
      *          ALRBCKFP   (CHAR    16) Alert backup focal oint      *
      *          ALRCTLD    (CHAR    10) Alert controller             *
      *          ALRDFTFP   (CHAR    10) Alert focal point            *
      *          ALRFTR     (CHAR    20) Alert filter                 *
      *          ALRHLDCNT  (BINARY   4) Alert hold count             *
      *          ALRLOGSTS  (CHAR     7) Alert logging status         *
      *          ALRPRIFP   (CHAR    10) Alert primary focal point    *
      *          ALRRQSFP   (CHAR    18) Alert focal point to request *
      *          ALRSTS     (CHAR    10) Alert status                 *
      *                                                               *
      *          DDMACC     (CHAR    20) DDM request access           *
      *          DFTCNNLST  (CHAR    10) PC default ISDN              *
      *                                  connection list              *
      *          DFTMODE    (CHAR     8) Default mode                 *
      *          DFTNETTYPE (CHAR    10) ISDN network type            *
      *          DTACPR     (BINARY   4) Data compression             *
      *          DTACPRINM  (BINARY   4) Intermediate data            *
      *                                  compression                  *
      *          JOBACN     (CHAR    10) Job action                   *
      *          LCLCPNAME  (CHAR     8) Local control point          *
      *          LCLLOCNAME (CHAR     8) Local location name          *
      *          LCLNETID   (CHAR     8) Local network ID             *
      *          MAXINTSSN  (BINARY   4) Maximum sessions             *
      *          MAXHOP     (BINARY   4) Maximum hop count            *
      *          MSGQ       (CHAR    20) Message queue                *
      *          NETSERVER  (CHAR    85) Server network ID            *
      *          NODETYPE   (CHAR     8) APPN node type               *
      *          OUTQ       (CHAR    20) Output queue                 *
      *          PNDSYSNAME (CHAR     8) Pending system name          *
      *          PCSACC     (CHAR    20) PC Support access            *
      *          RAR        (BINARY   4) Addition resistance          *
      *          SYSNAME    (CHAR     8) Current system name          *
      *                                                               *
      *  OUTPUT-Parameter:                                            *
      *  =================                                            *
      *                                                               *
      *  XAttrLen- Länge des Wertes                                   *
      *  XAttrTyp- Typ des Wertes                                     *
      *  XValue  - Attributwert                                       *
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
      *----------------------------------------------------*
      *  API - DATENSTRUKTUREN                             *
      *----------------------------------------------------*
      *
      *  declarations for QUSRTVUS
     D RcvVar          DS
     D   NbrRetAttr            1      4I 0 INZ
     D   OffsToTble            5      8I 0 INZ
     D   RcvVarDta             9    264A   INZ
      *
     D NetAttr         DS                  QUALIFIED
     D   Nme                   1     10A   INZ
     D   DtaType              11     11A   INZ
     D   InfStat              12     12A   INZ
     D   DtaLen               13     16I 0 INZ
     D   Dta                  17    272A   INZ
      *
     D RcvVarLen       S                   INZ(264) LIKE(R§INT4)
     D NbrOfAttr       S                   INZ(1)   LIKE(R§INT4)
     D AttrName        S             10A   INZ
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,FLDL0100
      *----------------------------------------------------*
      *
      *---Versenden von Nachrichten------------------------*
      /COPY QCOPYLE,API_ERROR
      *----------------------------------------------------*
      *
     D XAttr           S             10A
     D XNoMsg          S                   like(r§bool    )
     D XAttrLen        S                   like(r§int4    )
     D XAttrTyp        S              1A
     D XValue          S            512A
      *
     D X               S                   like(r§int4    ) inz
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      *
      ********************************************************************
      *           Main  Control block                                    *
      ********************************************************************
      *
     C     *ENTRY        PLIST
      *  Input
     C                   PARM                    XAttr
     C                   PARM                    XNoMsg
      *  Output
     C                   PARM                    XAttrLen
     C                   PARM                    XAttrTyp
     C                   PARM                    XValue
      *
      *---------------------------------------------------*
      *
      * - Meldung
     C                   IF        (XNoMsg = bTrue)
     C                   Callp     p_sndStsMg('USR8106': ' ')
     C                   ELSE
      *        keine Statusmeldung ausgeben
     C                   Endif
      *
     C                   EVAL      AttrName = XAttr
      *
     C                   CALL      'QWCRNETA'
     C                   PARM                    RcvVar
     C                   PARM                    RcvVarLen
     C                   PARM                    NbrOfAttr
     C                   PARM                    AttrName
     C                   PARM                    §ErrorCode
      *
     C                   IF        (§ErrAvail = 0)
     C                   EXSR      GetAttr
     C                   ELSE
     C                   EVAL      XAttrLen = 0
     C                   EVAL      XAttrTyp = ''
     C                   EVAL      XValue = ''
     C                   Endif
      *
      *---------------------------------------------------*
      *  Ende Programm
      *
     C     ENDE          TAG
      *
     C                   RETURN
      *
      *====================================================*
      *  GetAttr -  Abrufen der Attributwertes             *
      *====================================================*
      *
     C     GetAttr       BEGSR
      *
     C                   EVAL      x = OffsToTble + 1
      *
     C                   IF        (X >= 1 and x <= 256)
     C                   EVAL      NetAttr = %subst(RcvVar: x)
     C                   EVAL      XValue = NetAttr.Dta
     C                   EVAL      XAttrLen = NetAttr.DtaLen
     C                   EVAL      XAttrTyp = NetAttr.DtaType
     C                   ELSE
     C                   EVAL      XAttrLen = 0
     C                   EVAL      XAttrTyp = ''
     C                   EVAL      XValue = ''
     C                   Endif
      *
     C                   ENDSR
      *
      *====================================================*
      *  *PSSR  --  Program error handler                  *
      *====================================================*
      *
     C     *PSSR         BEGSR
      *
     C                   DUMP
      *
     C                   GOTO      ENDE
      *
     C                   ENDSR     '*CANCL'
      *
