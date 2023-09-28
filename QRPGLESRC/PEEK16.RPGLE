      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 2.2.0                               *
      *  Programm : PEEK16                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 14.10.97  Raddatz                                 *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Generieren RPG-LE Programm                                   *
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
     FQPEEKGEN  O    E             DISK    usropn
     F                                     rename(QPEEKGEN :FOUTPUT)
      *
     FQCOPYLE1  IF   E             DISK    usropn
     F                                     rename(QPEEKGEN :FCOPY1 )
      *
     FQCOPYLE2  IF   E             DISK    usropn
     F                                     rename(QPEEKGEN :FCOPY2 )
      *
     FQCOPYLE3  IF   E             DISK    usropn
     F                                     rename(QPEEKGEN :FCOPY3 )
      *
     FQCOPYLE4  IF   E             DISK    usropn
     F                                     rename(QPEEKGEN :FCOPY4 )
      *
     FQCOPYLE5  IF   E             DISK    usropn
     F                                     rename(QPEEKGEN :FCOPY5 )
      *
     FQCOPYLE6  IF   E             DISK    usropn
     F                                     rename(QPEEKGEN :FCOPY6 )
      *
     FPEEKSRC   IF   E             DISK    usropn
     F                                     rename(PEEKSRC:FINPUT)
      *
     FPEEKFLD   IF   E             DISK    usropn
      *
      *===============================================================*
      *  Datenstrukturen für die Codegenerierung
      *===============================================================*
      *
     D ds_page         DS           112
     D  $page_Spc              6      6    inz('C')
     D  $page_F2a             26     44    inz('When      scnNbr = ')
     D  $page_F2b             45     47S 0 inz
      *
     D ds_chkCh        DS           112
     D  $chkCh_Spc             6      6    inz('C')
     D  $chkCh_opC            26     31    inz('Exsr')
     D  $chkCh_F2a            36     42    inz('chkChar')
     D  $chkCh_F2b            43     45S 0 inz
      *
     D ds_exfmt        DS           112
     D  $exfmt_Spc             6      6    inz('C')
     D  $exfmt_neg             9      9    inz('N')
     D  $exfmt_ind            10     11    inz('71')
     D  $exfmt_opC            26     31    inz('Exfmt')
     D  $exfmt_ext            32     35    inz
     D  $exfmt_sc             36     37    inz('UC')
     D  $exfmt_scN            38     40S 0 inz
      *
     D ds_more         DS           112
     D  $more_scnN            46     48S 0 inz
      *
     D ds_fmtNme       DS           112
     D  $fmtNm_xNm            51     60    inz
      *
     D ds_rnmBuf       DS           112
     D  $rnmBf_Spc             6      6    inz('I')
     D  $rnmBf_xFd            21     30    inz
     D  $rnmBf_iFd            49     62    inz
      *
     D ds_rnmEx        DS           112
     D  $rnmEx_spc             6      6    inz('D')
     D  $rnmEx_ext            22     22    inz('E')
     D  $rnmEx_iFd             7     21    inz
     D  $rnmEx_xFd            44     80    inz
      *
     D ds_ovlEx        DS           112
     D  $ovlEx_spc             6      6    inz('D')
     D  $ovlEx_iFd             7     21    inz
     D  $ovlEx_typ            38     42    inz
     D  $ovlEx_xFd            44     80    inz
      *
     D ds_lcas         DS           112
     D  $lcas_inz             65     70    inz
      *
     D ds_rcdLock      DS           112
     D  $rcdLock_inz          65     70    inz
      *
     D ds_alwl         DS           112
     D  $alwl_inz             65     70    inz
      *
     D ds_keepCrs      DS           112
     D  $keepCrs_inz          44     47    inz
      *
     D ds_ucs2         DS           112
     D  $ucs2_value           46     59    inz
      *
     D ds_bufLen       DS           112
     D  $bufLn_ln             35     39S 0 inz
      *
     D ds_eval         DS           112
     D  $Eval_Spc              6      6    inz('C')
     D  $Eval_Code            26     31    inz('Eval')
     D  $Eval_Fct2            36     80    inz
      *
     D ds_for          DS           112
     D  $For_Spc               6      6    inz('C')
     D  $For_Code             26     31    inz('For')
     D  $For_Fct2             36     80    inz
      *
     D ds_endfor       DS           112
     D  $EndFor_Spc            6      6    inz('C')
     D  $EndFor_Oper          26     31    inz('Endfor')
      *
     D ds_select       DS           112
     D  $Select_Spc            6      6    inz('C')
     D  $Select_Code          26     31    inz('Select')
     D  $Select_Fct2          36     80    inz
      *
     D ds_when         DS           112
     D  $When_Spc              6      6    inz('C')
     D  $When_Code            26     31    inz('When')
     D  $When_Fct2            36     80    inz
      *
     D ds_endsl        DS           112
     D  $EndSl_Spc             6      6    inz('C')
     D  $EndSl_Oper           26     31    inz('Endsl')
      *
     D ds_if           DS           112
     D  $If_Spc                6      6    inz('C')
     D  $If_If                26     31    inz('If')
     D  $If_Fct2              36     80    inz
      *
     D ds_cont         DS           112
     D  $cont_Spc              6      6    inz('C')
     D  $cont_Fct2            36     80    inz
      *
     D ds_else         DS           112
     D  $Else_Spc              6      6    inz('C')
     D  $Else_Oper            26     31    inz('Else')
      *
     D ds_endif        DS           112
     D  $Endif_Spc             6      6    inz('C')
     D  $Endif_Oper           26     31    inz('Endif')
      *
     D ds_clear        DS           112
     D  $Clear_Spc             6      6    inz('C')
     D  $Clear_Oper           26     31    inz('Clear')
     D  $Clear_Field          50     63    inz
      *
     D ds_remark       DS           112
     D  $rem_atrB              1      1    inz(§White)
     D  $rem_rem               7      7    inz('*')
     D  $rem_txt              10    112    inz
      *
     D ds_begsr        DS           112
     D  $begsr_spc             6      6    inz('C')
     D  $begsr_f1             12     25    inz
     D  $begsr_opC            26     35    inz('Begsr')
      *
     D ds_endsr        DS           112
     D  $endsr_spc             6      6    inz('C')
     D  $endsr_opC            26     35    inz('Endsr')
      *
     D ds_exsr         DS           112
     D  $exsr_spc              6      6    inz('C')
     D  $exsr_opC             26     35    inz('Exsr')
     D  $exsr_fct2            36     49    inz
      *
     D #SRCSEQ         S                   like(SRCSEQ)
     D #Increment      C                   const(0,01)
      *
     D                 DS
     D FieldCount                     5S 0 inz(*ZEROS)
     D A#FdCount                      5A   overlay(FieldCount:1)
      *
     D cmd             S              4A   inz
     D scnNbr          S                   like(int4_t) inz
      *
     D §512            C                   const(': Unknown field type')
      *
     D pos             S             10I 0 inz
     D len             S             10I 0 inz
     D totLin          S             10I 0 inz
     D curLin          S              2S 0 inz
      *
     D totFields       S             10I 0 inz
     D curField        S              2S 0 inz
      *
     D nullDft         S              4A   inz
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      *----------------------------------------------------*
      *
      /define internal_prototype
      /COPY QCOPYLE,PPEEK16
      /undefine internal_prototype
      *
      *---Farbattribute------------------------------------*
      /COPY QCOPYLE,D_COLORATR
      *----------------------------------------------------*
      *
      *---API-Formate--------------------------------------*
     D FLDL0100        DS                  likeds(FLDL0100_t) inz
      /COPY QCOPYLE,FLDL0100
      *----------------------------------------------------*
      *
      *---Prototypen---------------------------------------*
     D p_wrtOut        PR
     D  i_srcDta                           const like(SRCDTA)
      *
     D f_readFld       PR                        like(bool_t)
      *
      *====================================================*
      *  Steuerleiste
      *====================================================*
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      /COPY QCOPYLE,F_PEEK61
      *
      /COPY QCOPYLE,CEECNDHDLR
      *
     D PEEK16          PI
     D  i_prodLib                          const like(lib_t)
     D  i_fileName                         const likeds(qObj_t)
     D  i_rcdFmt                           const like(rcdFmt_t)
     D  i_scnNbrs                     2P 0 const
     D  i_alwLC                            const like(bool_t)
     D  i_case                             const like(bool_t)
     D  i_rcdLock                          const like(bool_t)
     D  i_nullDft                          const like(bool_t)
     D  i_keepCrs                          const like(bool_t)
     D  io_stage                                 like(int4_t)
     D  i_numPasses                        const like(int4_t)
      *
      *  Register error handler
     C                   callp     CEEHDLR(%paddr('errorHandler')
     C                                     : *null: *omit)
     C                   Open      QPEEKGEN
     C                   Open      PEEKSRC
      *
     C                   Eval      #SRCSEQ = 0
      *
     C                   Do        *hival
     C                   Read      FINPUT                                 11
     C                   If        *in11 = bEOF
     C                   Leave
     C                   Endif
      *
     C                   Eval      cmd = %subst(SRCDTA: 1: 4)
      *
     C                   Select
      *
      *  File 1
     C                   When      cmd = 'FMT1'
     C                   Eval      ds_fmtNme = SRCDTA
     C                   Eval      $fmtNm_xNm = i_rcdFmt
     C                   Callp     p_wrtOut(ds_fmtNme)
      *
      *  Felddefinitionen
     C                   When      cmd = 'DEF1'
     C                   Callp     p_wrtOut(SRCDTA)
     C                   Exsr      SUB014
      *
      *  Umbenennen /copy Anweisungen
     C                   When      cmd = 'COPY'
     C                   Exsr      SUB025
     C                   Callp     p_wrtOut(SRCDTA)
      *
      *  Konstanten für "Feld zu lang"
     C                   When      cmd = 'DEF2'
     C                   Callp     p_wrtOut(SRCDTA)
     C                   Exsr      SUB016
      *
      *  Prüfen ...
     C                   When      cmd = 'CHKS'
     C                   Callp     p_wrtOut(SRCDTA)
     C                   Exsr      SUB015
      *
      *  Blättern ...
     C                   When      cmd = 'SCRN'
     C                   Callp     p_wrtOut(SRCDTA)
     C                   Exsr      SUB003
      *
      *  Letzte Seite ...
     C                   When      cmd = 'LSCN'
     C                   Exsr      SUB001
      *
      *  isLower ...
     C                   When      cmd = 'LCAS'
     C                   Exsr      SUB002
      *
      *  isRcdLock...
     C                   When      cmd = 'RLCK'
     C                   Exsr      SUB019
      *
      *  Übertragen Dateifelder in Bildschirmfelder
     C                   When      cmd = 'TSCN'
     C                   Callp     p_wrtOut(SRCDTA)
     C                   Exsr      SUB004
      *
      *  Übertragen Felder > 512 in Dateifelder
     C                   When      cmd = 'FSCN'
     C                   Callp     p_wrtOut(SRCDTA)
     C                   Exsr      SUB007
     C                   Exsr      SUB005
      *
      *  Prüfung ungültige Zeichen
     C                   When      cmd = 'CHKC'
     C                   Callp     p_wrtOut(SRCDTA)
     C                   Exsr      SUB006
      *
      *  Setzen NULL Indicator
     C                   When      cmd = 'NULL'
     C                   Callp     p_wrtOut(SRCDTA)
     C                   Exsr      SUB017
      *
      *  Hex-Editierung
     C                   When      cmd = 'HEX'
     C                   Callp     p_wrtOut(SRCDTA)
     C                   Exsr      SUB008
      *
      *  Text-Editierung
     C                   When      cmd = 'TXT'
     C                   Callp     p_wrtOut(SRCDTA)
     C                   Exsr      SUB018
      *
      *  Rename-Struktur
     C                   When      cmd = 'RNM2'
     C                   Callp     p_wrtOut(SRCDTA)
     C                   Exsr      SUB009
      *
      *  Rename-Struktur
     C                   When      cmd = 'RNM1'
     C                   Eval      ds_bufLen = SRCDTA
     C                   Eval      $bufLn_ln = RCD_BUFF_LEN
     C                   Callp     p_wrtOut(ds_bufLen)
     C                   Exsr      SUB010
      *
      *  initialisieren ISO-Felder
     C                   When      cmd = 'ISO '
     C                   Callp     p_wrtOut(SRCDTA)
     C                   Exsr      SUB011
      *
      *  isAlwLower ...
     C                   When      cmd = 'ALWL'
     C                   Exsr      SUB012
      *
      *  1. Seite ...
     C                   When      cmd = 'SCN1'
     C                   Exsr      SUB013
      *
      *  Übertragen Dateifelder in Bildschirmfelder
     C                   When      cmd = 'TOS'
     C                   Exsr      SUB020
      *
      *  Übertragen Bildschirmfelder in Dateifelder
     C                   When      cmd = 'TOF'
     C                   Exsr      SUB021
      *
      *  Löschen Felder im Datensatz
     C                   When      cmd = 'CLR'
     C                   Exsr      SUB022
      *
      *  Beibehalten Cursor Position
     C                   When      cmd = 'KEEP'
     C                   Exsr      SUB023
      *
      *  UCS-2 Feld für String/Hex Editor
     C                   When      cmd = 'UCS2'
      ***                Exsr      SUB024
      *
     C                   Other
      *  Nur kopieren ...
     C                   Callp     p_wrtOut(SRCDTA)
     C                   Endsl
      *
     C                   Enddo
      *
     C                   Close     QPEEKGEN
     C                   Close     PEEKSRC
      *
     C                   Eval      *inlr = *on
      *
      *============================================================*
      *    SUB001        Umschalten: Weitere ... / Ende            *
      *============================================================*
      *
     C     SUB001        Begsr
      *
     C                   Eval      ds_more    = SRCDTA
     C                   Eval      $more_scnN = i_scnNbrs
     C                   Callp     p_wrtOut(ds_more)
      *
     C                   Endsr
      *
      *============================================================*
      *    SUB002        isLower                                   *
      *============================================================*
      *
     C     SUB002        Begsr
      *
     C                   Eval      ds_lcas = SRCDTA
      *
     C                   If        i_case = bTrue
     C                   Eval      $lcas_inz = 'bTrue'
     C                   Else
     C                   Eval      $lcas_inz = 'bFalse'
     C                   Endif
      *
     C                   Callp     p_wrtOut(ds_lcas)
      *
     C                   Endsr
      *
      *============================================================*
      *    SUB003        Blättern                                  *
      *============================================================*
      *
     C     SUB003        Begsr
      *
     C     1             Do        i_scnNbrs     scnNbr
      *
      *  When      scnNbr = 001
     C                   Reset                   ds_page
     C                   Eval      $page_F2b = scnNbr
     C                   Callp     p_wrtOut(ds_page)
      *
      *  Exfmt     LC001
     C                   If        i_alwLC = bTrue
     C                   Reset                   ds_exfmt
     C                   Eval      $exfmt_neg = ' '
     C                   Eval      $exfmt_sc  = 'LC'
     C                   Eval      $exfmt_scN = scnNbr
     C                   Callp     p_wrtOut(ds_exfmt)
     C                   Endif
      *
      *  Exfmt     UC001
     C                   Reset                   ds_exfmt
     C                   Eval      $exfmt_neg = 'N'
     C                   Eval      $exfmt_sc  = 'UC'
     C                   Eval      $exfmt_scN = scnNbr
     C                   Callp     p_wrtOut(ds_exfmt)
      *
     C                   Enddo
      *
     C                   Endsr
      *
      *============================================================*
      *    SUB004        Dateifelder ==> Bildschirmfelder          *
      *============================================================*
      *
     C     SUB004        Begsr
      *
     C                   Open      PEEKFLD
      *
     C                   Eval      fieldCount = 0
      *
     C     1             Setll     FPEEKFLD
      *
     C                   Dow       f_readFld <> bEOF
      *
     C                   Eval      fieldCount = fieldCount + 1
      *
     C                   If        f_isNotAlw(FLDL0100) = bTrue
     C                   Reset                   ds_remark
     C                   Eval      $rem_txt = FLDL0100.F1VFLD + §512
     C                   Callp     p_wrtOut(ds_remark)
     C                   Iter
     C                   Endif
      *
     C                   If        (FLDL0100.F1DTYP = 'G')                      = Graphic
     C                   Eval      totLin = f_nbrDspRw(FLDL0100)
     C                   Else
     C                   Eval      totLin = 1
     C                   Endif
      *
     C                   Reset                   ds_exsr
     C                   Eval      $exsr_fct2 = 's_' + %trim(FLDL0100.F1VFLD)
     C                   Callp     p_wrtOut(ds_exsr)
      *
      *
     C                   Enddo
      *
     C                   Close     PEEKFLD
      *
     C                   Eval      io_stage = io_stage + 1
     C                   Callp     p_showProgressMeter(io_stage)
      *
     C                   Endsr
      *
      *============================================================*
      *    SUB005        Bildschirmfelder ==> Dateifelder          *
      *============================================================*
      *
     C     SUB005        Begsr
      *
     C                   Open      PEEKFLD
      *
     C                   Eval      fieldCount = 0
      *
     C     1             Setll     FPEEKFLD
      *
     C                   Dow       f_readFld <> bEOF
      *
      *  Feldzähler ...
     C                   Eval      fieldCount = fieldCount + 1
      *
      *  Keine Felder größer als 512-Zeichen oder
      *  nicht erlaubte Feldtypen ...
     C                   IF        (f_isNotAlw(FLDL0100) = bTrue)
      *
     C                   Reset                   ds_remark
     C                   Eval      $rem_txt = FLDL0100.F1VFLD + §512
     C                   Callp     p_wrtOut(ds_remark)
      *
     C                   Iter
     C                   Endif
      *
     C                   If        (FLDL0100.F1DTYP = 'G')                      = Graphic
     C                   Eval      totLin = f_nbrDspRw(FLDL0100)
     C                   Else
     C                   Eval      totLin = 1
     C                   Endif
      *
      *  If        (EDT00002 = '1') and
     C                   Reset                   ds_if
     C                   Eval      $If_Fct2='(EDT' + a#FdCount + ' = ''1'') and'
     C                   Callp     p_wrtOut(ds_if)
      *
      *            not (LNG0000001 = '1')
     C                   Reset                   ds_if
     C                   Eval      $If_If  = ' '
     C                   Eval      $If_Fct2='not (LNG' + a#FdCount + ' = ''1'')'
     C                   Callp     p_wrtOut(ds_if)
      *
      *  Übertragen BS-Feld in Dateifeld ...
     C                   If        (FLDL0100.F1NALW = '1')
     C                   Reset                   ds_if
     C                   Eval      $If_If   = ''
     C                   Eval      $If_Fct2 = 'and not %nullind(' +
     C                                           %trimR(FLDL0100.F1VFLD) + ')'
     C                   Callp     p_wrtOut(ds_if)
     C                   Endif
      *
     C                   Reset                   ds_exsr
     C                   Eval      $exsr_fct2 = 'f_' + %trim(FLDL0100.F1VFLD)
     C                   Callp     p_wrtOut(ds_exsr)
      *
      *  ENDIF
     C                   Reset                   ds_endif
     C                   Callp     p_wrtOut(ds_endif)
      *
     C                   Enddo
      *
     C                   Close     PEEKFLD
      *
     C                   Eval      io_stage = io_stage + 1
     C                   Callp     p_showProgressMeter(io_stage)
      *
     C                   Endsr
      *
      *============================================================*
      *    SUB006        Prüfung ungültige Zeichen kopieren        *
      *============================================================*
      *
     C     SUB006        Begsr
      *
     C                   Open      QCOPYLE1
      *
     C     1             Setll     FCOPY1
      *
     C                   Do        *HIVAL
     C                   Read      FCOPY1                                 11
     C                   If        *in11 = bEOF
     C                   Leave
     C                   Endif
      *
     C                   Callp     p_wrtOut(SRCDTA)
     C                   Enddo
      *
     C                   Close     QCOPYLE1
      *
     C                   Endsr
      *
      *============================================================*
      *    SUB007        Alle Felder prüfen                        *
      *============================================================*
      *
     C     SUB007        Begsr
      *
     C     1             Do        i_scnNbrs     scnNbr
      *
     C                   Reset                   ds_chkCh
     C                   Eval      $chkCh_F2b = scnNbr
     C                   Callp     p_wrtOut(ds_chkCh)
      *
     C                   Enddo
      *
      *   Remark einfügen ...
     C                   Reset                   ds_remark
     C                   Callp     p_wrtOut(ds_remark)
      *
     C                   Endsr
      *
      *============================================================*
      *    SUB008        Hex-Editierung                            *
      *============================================================*
      *
     C     SUB008        Begsr
      *
     C                   Open      QCOPYLE2
      *
     C     1             Setll     FCOPY2
      *
     C                   Do        *hival
     C                   Read      FCOPY2                                 11
     C                   If        *in11 = bEOF
     C                   Leave
     C                   Endif
      *
     C                   Callp     p_wrtOut(SRCDTA)
     C                   Enddo
      *
     C                   Close     QCOPYLE2
      *
     C                   Endsr
      *
      *============================================================*
      *    SUB009        Umbenennen Dateifelder                    *
      *============================================================*
      *
     C     SUB009        Begsr
      *
     C                   Open      PEEKFLD
      *
     C     1             Setll     FPEEKFLD
      *
     C                   Dow       f_readFld <> bEOF
      *
      *  Rename
     C                   Reset                   ds_rnmBuf
     C                   Eval      $rnmBf_xFd = FLDL0100.F1FNME
     C                   Eval      $rnmBf_iFd = FLDL0100.F1VFLD
     C                   Callp     p_wrtOut(ds_rnmBuf)
      *
     C                   Enddo
      *
     C                   Close     PEEKFLD
      *
     C                   Eval      io_stage = io_stage + 1
     C                   Callp     p_showProgressMeter(io_stage)
      *
     C                   Endsr
      *
      *============================================================*
      *    SUB010        Umbenennen Dateifelder (Input Buffer)     *
      *============================================================*
      *
     C     SUB010        Begsr
      *
     C                   Open      PEEKFLD
      *
     C     1             Setll     FPEEKFLD
      *
     C                   Dow       f_readFld <> bEOF
      *
      *  Rename
     C                   Reset                   ds_rnmEx
     C                   Eval      $rnmEx_xFd =
     C                               'extfld(' + %trim(FLDL0100.F1FNME) + ')'
     C                   Eval      $rnmEx_iFd = ' ' + FLDL0100.F1VFLD
     C                   Callp     p_wrtOut(ds_rnmEx)
      *
     C                   Enddo
      *
     C                   Eval      io_stage = io_stage + 1
     C                   Callp     p_showProgressMeter(io_stage)
      *
     C                   Close     PEEKFLD
      *
     C                   Eval      io_stage = io_stage + 1
     C                   Callp     p_showProgressMeter(io_stage)
      *
     C                   Endsr
      *
      *============================================================*
      *    SUB011        Initialisieren ISO-Felder                 *
      *============================================================*
      *
     C     SUB011        Begsr
      *
     C                   Open      PEEKFLD
      *
     C                   Eval      fieldCount = 0
      *
     C     1             Setll     FPEEKFLD
      *
     C                   Dow       f_readFld <> bEOF
      *
      *  Feldzähler ...
     C                   Eval      fieldCount = fieldCount + 1
      *
      *  Keine Felder größer als 512-Zeichen
     C                   IF        (f_isToLong(FLDL0100) = bTrue) or
     C                             (f_isNotAlw(FLDL0100) = bTrue)
     C                   Iter
     C                   Endif
      *
      *  Kein ISO Feld
     C                   If        (FLDL0100.F1DTYP <> 'T') and
     C                             (FLDL0100.F1DTYP <> 'L') and
     C                             (FLDL0100.F1DTYP <> 'Z')
     C                   Iter
     C                   Endif
      *
      *  If        FLD0000011= ' '
     C                   Reset                   ds_if
     C                   Eval      $If_Fct2 = 'FLD' + a#FdCount + '= '' '''
     C                   Callp     p_wrtOut(ds_if)
      *
      *  Eval      FLD0000011 = ISOT
     C                   Reset                   ds_eval
      *
     C                   Eval      $eval_fct2 = 'FLD' + a#FdCount
      *
      *  Initialisieren ...
     C                   Select
      *  ... Zeitfeld
     C                   When      (FLDL0100.F1DTYP = 'T')
     C                   Select
      *      ... *EUR
     C                   When      (FLDL0100.F1DTFM = '*EUR')
     C                   Eval      $eval_fct2  = %trimr($eval_fct2) + ' = EURT'
      *      ... *JIS
     C                   When      (FLDL0100.F1DTFM = '*JIS')
     C                   Eval      $eval_fct2  = %trimr($eval_fct2) + ' = JIST'
      *      ... *HMS
     C                   When      (FLDL0100.F1DTFM = '*HMS')
     C                   Eval      $eval_fct2  = %trimr($eval_fct2) + ' = HMST'
      *      ... *ISO
     C                   Other
     C                   Eval      $eval_fct2  = %trimr($eval_fct2) + ' = ISOT'
     C                   Endsl
      *  ... Datumsfeld
     C                   When      (FLDL0100.F1DTYP = 'L')
     C                   Select
      *      ... *EUR
     C                   When      (FLDL0100.F1DTFM = '*EUR')
     C                   Eval      $eval_fct2  = %trimr($eval_fct2) + ' = EURL'
      *      ... *JIS
     C                   When      (FLDL0100.F1DTFM = '*JIS')
     C                   Eval      $eval_fct2  = %trimr($eval_fct2) + ' = JISL'
      *      ... *ISO
     C                   Other
     C                   Eval      $eval_fct2  = %trimr($eval_fct2) + ' = ISOL'
     C                   Endsl
      *  ... Zeitstempelfeld
     C                   When      (FLDL0100.F1DTYP = 'Z')
     C                   Eval      $eval_fct2  = %trimr($eval_fct2) + ' = ISOZ'
     C                   Endsl
      *
     C                   Callp     p_wrtOut(ds_eval)
      *  Endif
     C                   Reset                   ds_endif
     C                   Callp     p_wrtOut(ds_endif)
      *  Remark
     C                   Reset                   ds_remark
     C                   Callp     p_wrtOut(ds_remark)
      *
     C                   Enddo
      *
     C                   Close     PEEKFLD
      *
     C                   Eval      io_stage = io_stage + 1
     C                   Callp     p_showProgressMeter(io_stage)
      *
     C                   Endsr
      *
      *============================================================*
      *    SUB012        isAlwLower                                *
      *============================================================*
      *
     C     SUB012        Begsr
      *
     C                   Eval      ds_alwl = SRCDTA
      *
     C                   If        i_alwLC = bTrue
     C                   Eval      $alwl_inz = 'bTrue'
     C                   Else
     C                   Eval      $alwl_inz = 'bFalse'
     C                   Endif
      *
     C                   Callp     p_wrtOut(ds_alwl)
      *
     C                   Endsr
      *
      *============================================================*
      *    SUB013        Seite 1                                   *
      *============================================================*
      *
     C     SUB013        Begsr
      *
     C                   If        i_alwLC = bTrue
     C                   Reset                   ds_exfmt
     C                   Eval      $exfmt_neg = ' '
     C                   Eval      $exfmt_sc  = 'LC'
     C                   Eval      $exfmt_scN = 1
     C                   Callp     p_wrtOut(ds_exfmt)
     C                   Endif
      *
     C                   Reset                   ds_exfmt
     C                   Eval      $exfmt_neg = 'N'
     C                   Eval      $exfmt_sc  = 'UC'
     C                   Eval      $exfmt_scN = 1
     C                   Callp     p_wrtOut(ds_exfmt)
      *
     C                   Endsr
      *
      *============================================================*
      *    SUB014        Felddefinitionen                          *
      *============================================================*
      *
     C     SUB014        Begsr
      *
     C                   Open      QCOPYLE3
      *
     C     1             Setll     FCOPY3
      *
     C                   Do        *hival
     C                   Read      FCOPY3                                 11
     C                   If        *in11 = bEOF
     C                   Leave
     C                   Endif
      *
     C                   Callp     p_wrtOut(SRCDTA)
     C                   Enddo
      *
     C                   Close     QCOPYLE3
      *
     C                   Endsr
      *
      *============================================================*
      *    SUB015        Prüfen Feldinhalte                        *
      *============================================================*
      *
     C     SUB015        Begsr
      *
     C     1             Do        i_scnNbrs     scnNbr
      *
      *  When      scnNbr = 001
     C                   Reset                   ds_page
     C                   Eval      $page_F2b = scnNbr
     C                   Callp     p_wrtOut(ds_page)
      *
      *  Exsr      chkChar001
     C                   Reset                   ds_chkCh
     C                   Eval      $chkCh_F2b = scnNbr
     C                   Callp     p_wrtOut(ds_chkCh)
      *
     C                   Enddo
      *
     C                   Endsr
      *
      *============================================================*
      *    SUB016        Felddefinitionen                          *
      *============================================================*
      *
     C     SUB016        Begsr
      *
     C                   Open      QCOPYLE4
      *
     C     1             Setll     FCOPY4
      *
     C                   Do        *hival
     C                   Read      FCOPY4                                 11
     C                   If        *in11 = bEOF
     C                   Leave
     C                   Endif
      *
     C                   Callp     p_wrtOut(SRCDTA)
     C                   Enddo
      *
     C                   Close     QCOPYLE4
      *
     C                   Endsr
      *
      *============================================================*
      *    SUB017        Umschalten NULL-Indicator                 *
      *============================================================*
      *
     C     SUB017        Begsr
      *
     C                   Open      QCOPYLE5
      *
     C     1             Setll     FCOPY5
      *
     C                   Do        *hival
     C                   Read      FCOPY5                                 11
     C                   If        *in11 = bEOF
     C                   Leave
     C                   Endif
      *
     C                   Callp     p_wrtOut(SRCDTA)
     C                   Enddo
      *
     C                   Close     QCOPYLE5
      *
     C                   Endsr
      *
      *============================================================*
      *    SUB018        Text-Editor                               *
      *============================================================*
      *
     C     SUB018        Begsr
      *
     C                   Open      QCOPYLE6
      *
     C     1             Setll     FCOPY6
      *
     C                   Do        *hival
     C                   Read      FCOPY6                                 11
     C                   If        *in11 = bEOF
     C                   Leave
     C                   Endif
      *
     C                   Callp     p_wrtOut(SRCDTA)
     C                   Enddo
      *
     C                   Close     QCOPYLE6
      *
     C                   Endsr
      *
      *============================================================*
      *    SUB019        isRcdLock                                 *
      *============================================================*
      *
     C     SUB019        Begsr
      *
     C                   Eval      ds_rcdLock = SRCDTA
      *
     C                   If        i_rcdLock = bTrue
     C                   Eval      $rcdLock_inz = 'bTrue'
     C                   Else
     C                   Eval      $rcdLock_inz = 'bFalse'
     C                   Endif
      *
     C                   Callp     p_wrtOut(ds_rcdLock)
      *
     C                   Endsr
      *
      *============================================================*
      *    SUB020        Übertragen Dateifelder in Bildschirmfelder*
      *============================================================*
      *
     C     SUB020        Begsr
      *
     C                   Open      PEEKFLD
      *
     C                   Eval      fieldCount = 0
      *
     C     1             Setll     FPEEKFLD
      *
     C                   Dow       f_readFld <> bEOF
      *
     C                   Eval      fieldCount = fieldCount + 1
      *
     C                   If        f_isNotAlw(FLDL0100) = bTrue
     C                   Iter
     C                   Endif
      *
     C                   If        (FLDL0100.F1DTYP = 'G')                      = Graphic
     C                   Eval      totFields = f_nbrDspRw(FLDL0100)
     C                   Else
     C                   Eval      totFields = 1
     C                   Endif
      *
     C                   Reset                   ds_remark
     C                   Eval      $rem_txt = FLDL0100.F1FNME
     C                   Callp     p_wrtOut(ds_remark)
      *
      *  Generieren BEGSR
     C                   Reset                   ds_begsr
     C                   Eval      $begsr_f1 = 's_' + %trim(FLDL0100.F1VFLD)
     C                   Callp     p_wrtOut(ds_begsr)
     C                   Reset                   ds_remark
     C                   Callp     p_wrtOut(ds_remark)
      *
     C                   Eval      pos = 1
      *
      *  Löschen Felder, wenn NULL-fähig oder VARLEN
     C                   If        FLDL0100.F1NALW = '1' or
     C                             f_isVarLen(FLDL0100) = bTrue
      *
     C                   For       curField = 1 to totFields
     C                   Reset                   ds_clear
     C                   If        totFields = 1
     C                   Eval      $Clear_Field = 'FLD' + a#FdCount
     C                   Else
     C                   Eval      $Clear_Field = 'FLD' + a#FdCount
     C                                                  + %editc(curField: 'X')
     C                   Endif
     C                   Callp     p_wrtOut(ds_clear)
     C                   Endfor
      *
     C                   Reset                   ds_remark
     C                   Callp     p_wrtOut(ds_remark)
      *
     C                   Endif
      *
      *  Generieren Abfrage auf NULL-Indicator
     C                   If        (FLDL0100.F1NALW = '1')
      *
     C                   Reset                   ds_if
     C                   Eval      $If_Fct2 = 'not %nullind(' +
     C                                           %trimR(FLDL0100.F1VFLD) + ')'
     C                   Callp     p_wrtOut(ds_if)
      *
     C                   Endif
      *
     C                   If        totFields > 1
      *
      *  Generieren:    offs = 0
     C                   Reset                   ds_remark
     C                   Callp     p_wrtOut(ds_remark)
      *
     C                   Reset                   ds_eval
     C                   Eval      $Eval_Fct2 = 'offs = 0'
     C                   Callp     p_wrtOut(ds_eval)
      *
     C                   Reset                   ds_remark
     C                   Callp     p_wrtOut(ds_remark)
      *
      *  Generieren:    For x = 1 to 8           (8 = totFields)
     C                   Reset                   ds_for
     C                   Eval      $For_Fct2 = 'x = 1 to ' + %char(totFields)
     C                   Callp     p_wrtOut(ds_for)
      *
      *  Generieren:    rem  = L_00000013
     C                   Reset                   ds_eval
     C                   Eval      $Eval_Fct2 =
     C                               'rem = %len(' + FLDL0100.F1VFLD +
     C                               ') - offs'
     C
     C                   Callp     p_wrtOut(ds_eval)
      *
      *  Generieren:    If (rem > 18)            (18 = f_cntFldLn(..))
     C                   Reset                   ds_if
     C                   Eval      $If_Fct2 = '(rem > ' +
     C                                         %char(f_cntFldLn(FLDL0100)) + ')'
     C                   Callp     p_wrtOut(ds_if)
      *
     C                   Reset                   ds_eval
     C                   Eval      $Eval_Fct2 = 'len = ' +
     C                                          %char(f_cntFldLn(FLDL0100))
     C                   Callp     p_wrtOut(ds_eval)
      *
     C                   Reset                   ds_else
     C                   Callp     p_wrtOut(ds_else)
      *
     C                   Reset                   ds_eval
     C                   Eval      $Eval_Fct2 = 'len = rem'
     C                   Callp     p_wrtOut(ds_eval)
      *
     C                   Reset                   ds_endif
     C                   Callp     p_wrtOut(ds_endif)
      *
      *  Generieren:    Select
     C                   Reset                   ds_select
     C                   Callp     p_wrtOut(ds_select)
      *
     C                   Endif
      *
      *  Übertragen Dateifeld --> Bildschirmfeld
     C                   For       curField = 1 to totFields
      *
      *  Generieren:    When (x = 1)
     C                   If        totFields > 1
     C                   Reset                   ds_when
     C                   Eval      $When_Fct2 = '(x = ' + %char(curField) +
     C                                          ' and len > 0)'
     C                   Callp     p_wrtOut(ds_when)
     C                   Endif
      *
     C                   If        totFields = 1
     C                   Reset                   ds_eval
     C                   Eval      $Eval_Fct2 = 'FLD' + a#FdCount +
     C                                          ' = ' + FLDL0100.F1VFLD
     C                   Callp     p_wrtOut(ds_eval)
     C                   Else
      *
      *    Generieren:    FLD0001301 = %subst(P_00000013: offs+1: len)
     C                   Reset                   ds_eval
     C                   Eval      $Eval_Fct2 =
     C                             'FLD' + a#FdCount + %editc(curField: 'X') +
     C                             ' = ' +
     C                             '%subst(' + %trimR(FLDL0100.F1VFLD) +
     C                             ': offs+1: len)'
     C                   Callp     p_wrtOut(ds_eval)
      *
     C                   Endif
      *
     C                   Endfor
      *
      *  Generieren:    Endsl
     C                   If        totFields > 1
     C                   Reset                   ds_endsl
     C                   Callp     p_wrtOut(ds_endsl)
      *
      *  Generieren:    offs = offs + len
     C                   Reset                   ds_eval
     C                   Eval      $Eval_Fct2 = 'offs = offs + len'
     C                   Callp     p_wrtOut(ds_eval)
      *
      *  ENDFOR von:  For-Schleife über Feldsegmente
     C                   Reset                   ds_endfor
     C                   Callp     p_wrtOut(ds_endfor)
     C                   Endif
      *
      *  ENDIF von:   Generieren Abfrage auf NULL-Indicator
     C                   If        (FLDL0100.F1NALW = '1')
      *
     C                   Reset                   ds_endif
     C                   Callp     p_wrtOut(ds_endif)
      *
     C                   Endif
      *
      *  Generieren ENDSR
     C                   Reset                   ds_remark
     C                   Callp     p_wrtOut(ds_remark)
      *
     C                   Reset                   ds_endsr
     C                   Callp     p_wrtOut(ds_endsr)
      *
     C                   Enddo
      *
     C                   Close     PEEKFLD
      *
     C                   Endsr
      *
      *============================================================*
      *    SUB021        Übertragen Bildschirmfelder in Dateifelder*
      *============================================================*
      *
     C     SUB021        Begsr
      *
     C                   Open      PEEKFLD
      *
     C                   Eval      fieldCount = 0
      *
     C     1             Setll     FPEEKFLD
      *
     C                   Dow       f_readFld <> bEOF
      *
     C                   Eval      fieldCount = fieldCount + 1
      *
     C                   If        f_isNotAlw(FLDL0100) = bTrue
     C                   Iter
     C                   Endif
      *
     C                   If        (FLDL0100.F1DTYP = 'G')                      = Graphic
     C                   Eval      totFields = f_nbrDspRw(FLDL0100)
     C                   Else
     C                   Eval      totFields = 1
     C                   Endif
      *
     C                   Reset                   ds_begsr
     C                   Eval      $begsr_f1 = 'f_' + %trim(FLDL0100.F1VFLD)
     C                   Callp     p_wrtOut(ds_begsr)
      *
     C                   If        f_isCharFld(FLDL0100) = bTrue
     C                   Reset                   ds_eval
     C                   Eval      $Eval_Fct2 =
     C                               %trim(FLDL0100.F1VFLD) + ' = %trimR('
     C                   Callp     p_wrtOut(ds_Eval)
     C                   Else
     C                   Reset                   ds_eval
     C                   Eval      $Eval_Fct2 = %trim(FLDL0100.F1VFLD) + ' ='
     C                   Callp     p_wrtOut(ds_Eval)
     C                   Endif
      *
     C                   For       curField = 1 to totFields
      *
     C                   Reset                   ds_eval
     C                   Clear                   $Eval_Code
     C                   Eval      $Eval_Fct2 = %trim('FLD' + A#FdCount)
     C                   If        totFields > 1
     C                   Eval      $Eval_Fct2 = %trimR($Eval_Fct2) +
     C                                          %editc(curField: 'X')
     C                   If        curField < totFields
     C                   Eval      $Eval_Fct2 = %trimR($Eval_Fct2) + ' +'
     C                   Endif
     C                   Endif
      *
     C                   Callp     p_wrtOut(ds_Eval)
     C                   Endfor
      *
     C                   If        f_isCharFld(FLDL0100) = bTrue
     C                   Reset                   ds_eval
     C                   Eval      $Eval_Code = ''
     C                   Eval      $Eval_Fct2 = ')'
     C                   Callp     p_wrtOut(ds_Eval)
     C                   Endif
      *
     C                   Reset                   ds_endsr
     C                   Callp     p_wrtOut(ds_endsr)
      *
     C                   Enddo
      *
     C                   Close     PEEKFLD
      *
     C                   Endsr
      *
      *============================================================*
      *    SUB022        Löschen Felder im Datensatz               *
      *============================================================*
      *
     C     SUB022        Begsr
      *
     C                   If        (i_nullDft = bFalse)
     C                   Eval      nullDft = '*ON'
     C                   Else
     C                   Eval      nullDft = '*OFF'
     C                   Endif
      *
     C                   Open      PEEKFLD
      *
     C                   Eval      fieldCount = 0
      *
     C     1             Setll     FPEEKFLD
      *
     C                   Dow       f_readFld <> bEOF
      *
     C                   Eval      fieldCount = fieldCount + 1
      *
     C                   If        f_isNotAlw(FLDL0100) = bTrue
     C                   Iter
     C                   Endif
      *
      *  Setzen NULL-Indicator
     C                   If        (FLDL0100.F1NALW = '1')
      *
     C                   Reset                   ds_eval
     C                   Eval      $Eval_Fct2 =
     C                               '%nullind(' +
     C                               %trimR(FLDL0100.F1VFLD) + ') = '
     C                   Eval      $Eval_Fct2 = %trimR($Eval_fct2) + nullDft
     C                   Callp     p_wrtOut(ds_Eval)
      *
     C                   Endif
      *
      *
     C                   Enddo
      *
     C                   Close     PEEKFLD
      *
     C                   Endsr
      *
      *============================================================*
      *    SUB023        Beibehalten Cursor Position               *
      *============================================================*
      *
     C     SUB023        Begsr
      *
     C                   Eval      ds_keepCrs = SRCDTA
      *
     C                   If        i_keepCrs = bTrue
     C                   Eval      $keepCrs_inz = '''1'''
     C                   Else
     C                   Eval      $keepCrs_inz = '''0'''
     C                   Endif
      *
     C                   Callp     p_wrtOut(ds_keepCrs)
      *
     C                   Endsr
      *
      *============================================================*
      *    SUB024        UCS2-Feld für String/Hex Editor           *
      *============================================================*
      *
     C     SUB024        Begsr
      *
     C                   Eval      ds_ucs2 = SRCDTA
      *
     C                   Eval      $ucs2_value = '(FLDL0100.F1UCS2 = ''1'')'
      *
     C                   Callp     p_wrtOut(ds_ucs2)
      *
     C                   Endsr
      *
      *============================================================*
      *    SUB025        Umbenennen /copy Anweisungen              *
      *============================================================*
      *
     C     SUB025        Begsr
      *
     C                   Eval      SRCDTA = %scanrpl('LIBRARY_NAME'
     C                                               : %trim(i_prodLib)
     C                                               :SRCDTA)
      *
     C                   Endsr
      *
      *============================================================*
      *    wrtOut        Ausgeben Quellenzeile                     *
      *============================================================*
     P p_wrtOut        B
     D                 PI
     D  i_srcDta                           const like(SRCDTA)
      *
     C                   Eval      #SRCSEQ = #SRCSEQ + #Increment
      *
     C                   Eval      SRCSEQ  = #SRCSEQ
     C                   Eval      SRCDTA  = i_srcDta
     C                   WRITE     FOUTPUT
      *
     C                   Return
      *
     P                 E
      *
      *============================================================*
      *    readFld       Lesen nächstes Feld aus PEEKFLD           *
      *============================================================*
     P f_readFld       B
     D                 PI                        like(bool_t)
      *------------------------------------------------------------
      *
     C                   DoU       *in20 = bEOF
      *
     C                   Read      FPEEKFLD                               20
      *
     C                   If        (*in20 <> bEOF)
     C                   Eval      FLDL0100 = FFD
     C                   Leave
     C                   Endif
      *
     C                   Enddo
      *
     C                   Return    *in20
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
