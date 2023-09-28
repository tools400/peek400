      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 2.2.0                               *
      *  Programm : PEEK15                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 14.10.97  Raddatz                                 *
      *  geändert : 21.07.99  Raddatz für Version 2.2                 *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Generieren RPG-LE Displayfile                                *
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
     FQCOPYLE1  O    E             DISK    usropn
     F                                     rename(QPEEKGEN :FCOPY1 )
      *
     FQCOPYLE2  O    E             DISK    usropn
     F                                     rename(QPEEKGEN :FCOPY2 )
      *
     FQCOPYLE3  O    E             DISK    usropn
     F                                     rename(QPEEKGEN :FCOPY3 )
      *
     FQCOPYLE4  O    E             DISK    usropn
     F                                     rename(QPEEKGEN :FCOPY4 )
      *
     FQCOPYLE5  O    E             DISK    usropn
     F                                     rename(QPEEKGEN :FCOPY5 )
      *
     FQCOPYLE6  O    E             DISK    usropn
     F                                     rename(QPEEKGEN :FCOPY6 )
      *
     FPEEKSRC   IF   E             DISK    usropn
     F                                     rename(PEEKSRC:FINPUT)
     FPEEKFLD   IF   E             DISK    usropn
      *
      *===============================================================*
     D p_wrtDspF       PR
     D  i_srcDta                           const like(SRCDTA)
      *
     D p_wrtCopy1      PR
     D  i_srcDta                           const like(SRCDTA)
      *
     D p_wrtCopy2      PR
     D  i_srcDta                           const like(SRCDTA)
      *
     D p_wrtCopy3      PR
     D  i_srcDta                           const like(SRCDTA)
      *
     D p_wrtCopy4      PR
     D  i_srcDta                           const like(SRCDTA)
      *
     D p_wrtCopy5      PR
     D  i_srcDta                           const like(SRCDTA)
      *
     D p_wrtCopy6      PR
     D  i_srcDta                           const like(SRCDTA)
      *
     D f_readFld       PR                        like(r§bool    )
      *
      *===============================================================*
      *
     D ds_rcdFmt       DS           112
     D  $rcdFm_spc             6      6    inz('A')
     D  $rcdFm_typ            17     17    inz('R')
     D  $rcdFm_nme            19     23    inz
      *
     D ds_overlay      DS           112
     D  $ovl_spc               6      6    inz('A')
     D  $ovl_kWrd             45     80    inz('OVERLAY   ')
      *
     D ds_window       DS           112
     D  $wdw_spc               6      6    inz('A')
     D  $wdw_mode              9     12    inz
     D  $wdw_kWrd             45     80    inz('WINDOW(MSGCTL) ')
      *
     D ds_dspMode      DS           112
     D  $dspM_spc              6      6    inz('A')
     D  $dspM_neg              8      8    inz('N')
     D  $dspM_ind              9     10    inz('88')
     D  $dspM_kWrd            45     80    inz('DSPMOD(*DS4)   ')
      *
     D ds_csrLoc       DS           112
     D  $csrL_spc              6      6    inz('A')
     D  $csrL_kWrd            45     80    inz('CSRLOC(CSRROW     CSRCOL)')
      *
     D ds_fldDef       DS           112
     D  $fldD_spc              6      6    inz('A')
     D  $fldD_neg              8      8    inz
     D  $fldD_ind40            9     10    inz
     D  $fldD_ind50           12     13    inz
     D  $fldD_fldN            19     28    inz
     D  $fldD_ref             29     29    inz
     D  $fldD_len             30     34    inz
     D  $fldD_dTyp            35     35    inz
     D  $fldD_decP            36     37    inz
     D  $fldD_IO              38     38    inz
     D  $fldD_row             40     41S 0
     D   $fldD_row$                   2A   inz overlay($fldD_row: 1)
     D  $fldD_col             43     44S 0
     D   $fldD_col$                   2A   inz overlay($fldD_col: 1)
     D  $fldD_kWrd            45     80    inz
      *
     D ds_alias        DS           112
     D  $alias_spc             6      6    inz('A')
     D  $alias_kWrd           45     80    inz
      *
     D ds_fldCnt       DS           112
     D  $fldC_spc              6      6    inz('A')
     D  $fldC_kWrd            45     80    inz
      *
     D ds_literal      DS           112
     D  $lit_spc               6      6    inz('A')
     D  $lit_neg_1             8      8    inz
     D  $lit_ind_1             9     10    inz
     D  $lit_neg_2            11     11    inz
     D  $lit_ind_2            12     13    inz
     D  $lit_row              40     41S 0 inz
     D  $lit_col              44     44S 0 inz
     D  $lit_kWrd             45     80    inz
      *
     D ds_dspAtr       DS           112
     D  $dspA_spc              6      6    inz('A')
     D  $dspA_neg              8      8    inz
     D  $dspA_ind              9     10    inz
     D  $dspA_atr             45     80    inz
      *
      *  Message: Invalid Charcaters
     D ds_msgChar      DS           112
     D  $msgC_spc              6      6A   inz('A')
     D  $msgC_op               7      7A   inz
     D  $msgC_neg              8      8A   inz('N')
     D  $msgC_ind              9     10A   inz
     D  $msgC_fldN            19     28A   inz
     D  $msgC_len             33     34A   inz('30')
     D  $msgC_dTyp            35     35A   inz('A')
     D  $msgC_IO              38     38A   inz('O')
     D  $msgC_row             40     41S 0
     D   $msgC_row$                   2A   inz overlay($msgC_row: 1)
     D  $msgC_col             43     44S 0
     D   $msgC_col$                   2A   inz overlay($msgC_col: 1)
     D  $msgC_kWrd            45     80A   inz('MSGID(TXT &MSG        PEEKGER)')
     D  $msgC_fldNum          59     65A   inz
      *
      *  Message: Hidden field
     D ds_msgHidden    DS           112
     D  $msgH_spc              6      6A   inz('A')
     D  $msgH_fldN            19     28A   inz
     D  $msgH_len             34     34A   inz('4')
     D  $msgH_dTyp            35     35A   inz('A')
     D  $msgH_IO              38     38A   inz('H')
      *
      *---------------------------------------------------------------*
      *
     D ds_eval         DS           112
     D  $eval_spc              6      6    inz('C')
     D  $eval_opC             26     31    inz('Eval')
     D  $eval_fct2            36     80    inz
      *
     D ds_callp        DS           112
     D  $callp_spc             6      6    inz('C')
     D  $callp_opC            26     31    inz('Callp')
     D  $callp_fct2           36     80    inz
      *
     D ds_begsr        DS           112
     D  $begsr_spc             6      6    inz('C')
     D  $begsr_f1             12     25    inz
     D  $begsr_opC            26     35    inz('Begsr')
      *
     D ds_exsr         DS           112
     D  $exsr_spc              6      6    inz('C')
     D  $exsr_opC             26     35    inz('Exsr')
     D  $exsr_fct2            36     49    inz
      *
     D ds_if           DS           112
     D  $if_spc                6      6    inz('C')
     D  $if_opC               26     35    inz('If')
     D  $if_fct2              36     80    inz
      *
     D ds_endif        DS           112
     D  $endif_spc             6      6    inz('C')
     D  $endif_opC            26     35    inz('Endif')
      *
     D ds_endsr        DS           112
     D  $endsr_spc             6      6    inz('C')
     D  $endsr_opC            26     35    inz('Endsr')
      *
     D ds_leavesr      DS           112
     D  $leavesr_spc           6      6    inz('C')
     D  $leavesr_opC          26     35    inz('Leavesr')
      *
     D ds_else         DS           112
     D  $else_spc              6      6    inz('C')
     D  $else_opC             26     35    inz('Else')
      *
     D ds_when         DS           112
     D  $when_spc              6      6    inz('C')
     D  $when_opC             26     35    inz('When')
     D  $when_fct2            36     80    inz
      *
     D ds_cont         DS           112
     D  $cont_spc              6      6    inz('C')
     D  $cont_fct2            36     80    inz
      *
     D ds_selec        DS           112
     D  $selec_spc             6      6    inz('C')
     D  $selec_opC            26     35    inz('Select')
      *
     D ds_endsl        DS           112
     D  $endsl_spc             6      6    inz('C')
     D  $endsl_opC            26     35    inz('Endsl')
      *
     D ds_remark       DS           112
     D  $rem_atrB              1      1    inz(§White)
     D  $rem_rem               7      7    inz('*')
     D  $rem_txt               8    112    inz
     D  $rem_info             10    112    inz
      *
     D ds_defn         DS           112
     D  $defn_spc              6      6    inz('D')
     D  $defn_fldN             7     21    inz
     D  $defn_type            24     25    inz
     D  $defn_len             33     39    inz
     D  $defn_DTyp            40     40    inz
     D  $defn_decP            41     42    inz
     D  $defn_keyW            44     80    inz
      *
     D ds_movel        DS           112
     D  $movel_spc             6      6    inz('C')
     D  $movel_opC            26     31    inz('Movel')
     D  $movel_ext            32     35    inz('(P)')
     D  $movel_f2             36     49    inz
     D  $movel_r              50     63    inz
      *
     D isExit03        S               N   inz(bFalse)
     D EXIT03          S                   like(r§pgmCallN) inz
     D qPgm            DS                  qualified
     D  name                         10A
     D  lib                          10A
      *
     D CvtEditCode     PR                         extpgm(EXIT03)
     D  gi_file                      10A   const
     D  gi_lib                       10A   const
     D  gi_user                      10A   const
     D  gi_field                     10A   const
     D  gio_edtCde                    1A
      *
      /COPY QCOPYLE,ERR_D_SDS
      *
     D DotLine         S             40A   inz(*ALL'.')
      *
     D #SRCSEQ         S                   like(SRCSEQ) inz
     D #Increment      C                   const(0,01)
      *
     D MAX_ROWS        C                   18
      *
     D §remLine        C                   const('==========================+
     D                                            ==========================*')
      *
     D totLin          S                   like(r§int4    ) inz
     D curLin          S              2S 0 inz
     D dspLen          S             10I 0 inz
      *
     D totFields       S                   like(r§int4    ) inz
     D curField        S              2S 0 inz
      *
     D                 DS
     D newLen#                        5S 0 inz
     D NewLen#A                       5A   overlay(newLen#: 1)
      *
      *  Satzformatzähler
     D                 DS
     D scn#                           3S 0 inz
     D scn#a                          3A   overlay(scn#: 1)
      *  Feldzähler pro Satzformat
     D                 DS
     D FieldCount                     5S 0 inz(*ZEROS)
     D A#FdCount                      5A   overlay(FieldCount:1)
      *  Bezugszahlenzähler pro Satzformat für Felder mit unzulässigen Zeichen
     D                 DS
     D ind40#                         2S 0 inz
     D ind40#a                        2A   overlay(ind40#: 1)
      *  Bezugszahlenzähler pro Satzformat für Felder mit NULL Werten
     D                 DS
     D ind50#                         2S 0 inz
     D ind50#a                        2A   overlay(ind50#: 1)
      *  Zeilenzähler im Satzformat
     D                 DS
     D row#                           2S 0 inz
     D row#a                          2A   overlay(row#: 1)
      *  Umsetzung numerisch/alphanumerisch
     D                 DS
     D num#                           2S 0 inz
     D num#a                          2A   overlay(num#: 1)
      *
      *  Arbeitsfelder
     D hasRefFld       S                   like(r§bool    ) inz(bFalse)
     D newScn          S                   like(r§bool    ) inz(bTrue)
     D x               S                   like(r§int4    ) inz
     D y               S                   like(r§int4    ) inz
     D z               S                   like(r§int4    ) inz
     D p               S                   like(r§int4    ) inz
     D numQuote        S                   like(r§int4    ) inz
     D baseFldName     S                   like(r§fieldNme) inz
     D fieldName       S                   like(r§fieldNme) inz
     D r$ftxt          S                   like(FLDL0100_t.F1FTXT) inz
     D refFile         S                   like(r§file    ) inz
     D refLib          S                   like(r§lib     ) inz
     D fldToLong       S                   like(r§bool    ) inz
     D fldToLongMax    S                   like(r§bool    ) inz
     D closeChar1      S              1A   varying inz
     D closeChar2      S              1A   varying inz
     D headerType      S             20A   varying inz
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      *----------------------------------------------------*
      *
      /define internal_prototype
      /COPY QCOPYLE,PPEEK15
      /undefine internal_prototype
      *
      *---Farbattribute------------------------------------*
      /COPY QCOPYLE,D_COLORATR
      *----------------------------------------------------*
      *
      *---Nachrichtendefinitionen--------------------------*
      /COPY QCOPYLE,USR8188
      *----------------------------------------------------*
      *
      *---API-Formate--------------------------------------*
     D FLDL0100        DS                  likeds(FLDL0100_t) inz
      /COPY QCOPYLE,FLDL0100
      *----------------------------------------------------*
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      /COPY QCOPYLE,F_PEEK61
      *
      /COPY QCOPYLE,CEECNDHDLR
      *
     D isInzSr         S                   like(r§bool) inz(bFalse)
      *
      *====================================================*
      *  Steuerleiste
      *====================================================*
      *
     D PEEK15          PI
     D  i_qFile                            const likeds(r§qObj)
     D  io_scnNbrs                    2P 0
     D  i_alwLC                            const like(r§bool)
     D  io_stage                                 like(r§int4)
     D  i_numPasses                        const like(r§int4)
      *
      *----------------------------------------------------*

      *  Register error handler
     C                   callp     CEEHDLR(%paddr('errorHandler')
     C                                     : *null: *omit)
      *
     C                   Exsr      InzSr
      *
     C                   Open      QCOPYLE1
     C                   Open      QCOPYLE2
     C                   Open      QCOPYLE3
     C                   Open      QCOPYLE4
     C                   Open      QCOPYLE5
     C                   Open      QCOPYLE6
     C                   Open      QPEEKGEN
     C                   Open      PEEKFLD
      *
     C                   Eval      p = %scan('/': EXIT03)
     C                   If        p > 1
     C                   Eval      qPgm.lib = %subst(EXIT03: 1: p-1)
     C                   If        p < %len(EXIT03)
     C                   Eval      qPgm.name = %subst(EXIT03: p+1)
     C                   Eval      isExit03  = f_exist(qPgm.name
     C                                                 : qPgm.lib
     C                                                 : '*PGM')
     C                   Endif
     C                   Endif
      *
     C                   Eval      scn#    = 0
     C                   Eval      #SRCSEQ = 0
     C                   Eval      newScn  = bTrue
      *
     C                   If        i_alwLC = bFalse
      *  "Vorspann" nur kopieren, bei XAlwLC = FALSE
     C                   Exsr      copyHead
     C                   Else
      *  "Vorspann" nicht kopieren, da schon kopiert
     C                   Endif
      *
     C                   Eval      refFile = %subst(i_qFile:  1: 10)
     C                   Eval      refLib  = %subst(i_qFile: 11: 10)
      *
     C                   Eval      fieldCount = 0
      *
      *  Abarbeiten der Feldliste ...
     C     1             Setll     PEEKFLD
      *
     C                   Dow       f_readFld <> bEOF
      *
      ***                Clear                   USR8188
      ***                Eval      USR81881 = xStage
      ***                Eval      USR81882 = FLDL0100.F1FNME
      ***                Callp     p_sndStsMg('USR8188': USR8188)
      *
      *  ... erhöhen lfd. Feldnummer
     C                   Eval      fieldCount = fieldCount + 1
      *
      *  ... prüfen, ob das Feld erlaubt ist
     C                   If        f_isNotAlw(FLDL0100) = bTrue
     C                   Iter
     C                   Endif
      *
      *  ... ausgeben Feld
     C                   Exsr      WrtField
     C                   Enddo
      *
     C                   Eval      io_stage = io_stage + 1
     C                   Callp     p_showProgressMeter(io_stage)
      *
      *-------------------------------------------*
      *  Abschließen Copy-Book 1:                 *
      *  Inhalt:   chkCharXXX                     *
      *-------------------------------------------*
      *
      *  Endsr
     C                   Reset                   ds_endsr
     C                   Callp     p_wrtCopy1(ds_endsr)
      *  Remark
     C                   Reset                   ds_remark
     C                   Callp     p_wrtCopy1(ds_remark)
      *
      *-------------------------------------------*
      *  Abschließen Copy-Book 2:                 *
      *  Inhalt:   c_fldHexEd                     *
      *-------------------------------------------*
      *
      *  Endsl
     C                   Reset                   ds_endsl
     C                   Callp     p_wrtCopy2(ds_endsl)
      *  Remark
     C                   Reset                   ds_remark
     C                   Callp     p_wrtCopy2(ds_remark)
      *  Endsr
     C                   Reset                   ds_endsr
     C                   Callp     p_wrtCopy2(ds_endsr)
      *  Remark
     C                   Reset                   ds_remark
     C                   Callp     p_wrtCopy2(ds_remark)
      *
      *-------------------------------------------*
      *  Abschließen Copy-Book 6:                 *
      *  Inhalt:   c_fldStrEd                     *
      *-------------------------------------------*
      *
      *  Endsl
     C                   Reset                   ds_endsl
     C                   Callp     p_wrtCopy6(ds_endsl)
      *  Remark
     C                   Reset                   ds_remark
     C                   Callp     p_wrtCopy6(ds_remark)
      *  Endsr
     C                   Reset                   ds_endsr
     C                   Callp     p_wrtCopy6(ds_endsr)
      *  Remark
     C                   Reset                   ds_remark
     C                   Callp     p_wrtCopy6(ds_remark)
      *
      *-------------------------------------------*
      *  Zufügen Copy-Book 1:                     *
      *  Inhalt:   EnableEdit                     *
      *-------------------------------------------*
      *
      *  Ausgeben COPY-Strecke: EnableEdit
      *
      *  Remark
     C                   Reset                   ds_remark
     C                   Eval      $rem_txt  = §remLine
     C                   Callp     p_wrtCopy1(ds_remark)
      *
      *  Remark
     C                   Reset                   ds_remark
     C                   Eval      $rem_info = 'Alle Felder freischalten'
     C                   Callp     p_wrtCopy1(ds_remark)
      *
      *  Remark
     C                   Reset                   ds_remark
     C                   Eval      $rem_txt  = §remLine
     C                   Callp     p_wrtCopy1(ds_remark)
      *
      *  Remark
     C                   Reset                   ds_remark
     C                   Callp     p_wrtCopy1(ds_remark)
      *
      *  Begsr
     C                   Reset                   ds_begsr
     C                   Eval      $begsr_f1 = 'EnableEdit'
     C                   Callp     p_wrtCopy1(ds_begsr)
      *  Remark
     C                   Reset                   ds_remark
     C                   Callp     p_wrtCopy1(ds_remark)
      *
     C                   Eval      fieldCount = 0
      *
      *  Abarbeiten der Feldliste ...
     C     1             Setll     PEEKFLD
      *
     C                   Dow       f_readFld <> bEOF
      *
      ***                Clear                   USR8188
      ***                Eval      USR81881 = xStage
      ***                Eval      USR81882 = FLDL0100.F1FNME
      ***                Callp     p_sndStsMg('USR8188': USR8188)
      *
      *  ... erhöhen lfd. Feldnummer
     C                   Eval      fieldCount = fieldCount + 1
      *
      *  ... prüfen, ob das Feld erlaubt ist
     C                   If        f_isNotAlw(FLDL0100) = bTrue
     C                   Iter
     C                   Endif
      *
      *  ... ausgeben Initialisierung des log. Merkers
      *
      *  Eval      EDT0000001 = '1'
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 = 'EDT' + a#FdCount + ' = ''1'''
     C                   Callp     p_wrtCopy1(ds_eval)
     C                   Enddo
      *
     C                   Eval      io_stage = io_stage + 1
     C                   Callp     p_showProgressMeter(io_stage)
      *
      *  Remark
     C                   Reset                   ds_remark
     C                   Callp     p_wrtCopy1(ds_remark)
      *  Endsr
     C                   Reset                   ds_endsr
     C                   Callp     p_wrtCopy1(ds_endsr)
      *  Remark
     C                   Reset                   ds_remark
     C                   Callp     p_wrtCopy1(ds_remark)
      *
     C                   Close     QCOPYLE1
     C                   Close     QCOPYLE2
     C                   Close     QCOPYLE3
     C                   Close     QCOPYLE4
     C                   Close     QCOPYLE5
     C                   Close     QCOPYLE6
     C                   Close     QPEEKGEN
     C                   Close     PEEKFLD
      *
     C                   Eval      io_scnNbrs = scn#
      *
     C                   Eval      *inlr = *on
      *
      *============================================================*
      *    copyHead      Kopieren Vorspann                         *
      *============================================================*
      *
     C     copyHead      Begsr
      *
     C                   Open      PEEKSRC
      *
     C                   Do        *hival
     C                   Read      FINPUT                                 11
     C                   If        *in11 = bEOF
     C                   Leave
     C                   Endif
      *
      *  Nur kopieren ...
     C                   Callp     p_wrtDspF(SRCDTA)
     C                   Enddo
      *
     C                   Close     PEEKSRC
      *
      *-------------------------------------------*
      *  Initialisieren Copy-Book 2:              *
      *  Inhalt:   c_fldHexEd                     *
      *-------------------------------------------*
      *
      *  Begsr
     C                   Reset                   ds_begsr
     C                   Eval      $begsr_f1 = 'c_fldHexEd'
     C                   Callp     p_wrtCopy2(ds_begsr)
      *
      *  Remark
     C                   Reset                   ds_remark
     C                   Callp     p_wrtCopy2(ds_remark)
      *
      *  füllen Parameter für PEEK45
      *  Eval      yDsp80     = xDsp80
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 = 'yDsp80     = xDsp80'
     C                   Callp     p_wrtCopy2(ds_eval)
      *
      *  Eval      yHeaderTyp = xHeaderTyp
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 = 'yHeaderTyp = xHeaderTyp'
     C                   Callp     p_wrtCopy2(ds_eval)
      *
      *  Eval      yCopyRight = xCopyRight
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 = 'yCopyRight = xCopyRight'
     C                   Callp     p_wrtCopy2(ds_eval)
      *
      *  Eval      yProtect   = '0'
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 = 'yProtect   = ''0'''
     C                   Callp     p_wrtCopy2(ds_eval)
      *
      *  Eval      yMsgID     = ' '
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 = 'yMsgID     = '' '''
     C                   Callp     p_wrtCopy2(ds_eval)
      *
      *  Eval      yMsgDta    = ' '
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 = 'yMsgDta    = '' '''
     C                   Callp     p_wrtCopy2(ds_eval)
      *
      *  Remark
     C                   Reset                   ds_remark
     C                   Callp     p_wrtCopy2(ds_remark)
      *
      *  Eval      xScnCsrRow = wScnCsrRow - WndTopRow
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 =
     C                                'xScnCsrRow = wScnCsrRow - WndTopRow'
     C                   Callp     p_wrtCopy2(ds_eval)
      *
      *  Remark
     C                   Reset                   ds_remark
     C                   Callp     p_wrtCopy2(ds_remark)
      *
      *  Select
     C                   Reset                   ds_selec
     C                   Callp     p_wrtCopy2(ds_selec)
      *
      *-------------------------------------------*
      *  Initialisieren Copy-Book 6:              *
      *  Inhalt:   c_fldStrEd                     *
      *-------------------------------------------*
      *
      *  Begsr
     C                   Reset                   ds_begsr
     C                   Eval      $begsr_f1 = 'c_fldStrEd'
     C                   Callp     p_wrtCopy6(ds_begsr)
      *
      *  Remark
     C                   Reset                   ds_remark
     C                   Callp     p_wrtCopy6(ds_remark)
      *
      *  füllen Parameter für PEEK45
      *  Eval      yDsp80     = xDsp80
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 = 'yDsp80     = xDsp80'
     C                   Callp     p_wrtCopy6(ds_eval)
      *
      *  Eval      yHeaderTyp = xHeaderTyp
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 = 'yHeaderTyp = xHeaderTyp'
     C                   Callp     p_wrtCopy6(ds_eval)
      *
      *  Eval      yCopyRight = xCopyRight
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 = 'yCopyRight = xCopyRight'
     C                   Callp     p_wrtCopy6(ds_eval)
      *
      *  Eval      yProtect   = '0'
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 = 'yProtect   = ''0'''
     C                   Callp     p_wrtCopy6(ds_eval)
      *
      *  Eval      yMsgID     = ' '
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 = 'yMsgID     = '' '''
     C                   Callp     p_wrtCopy6(ds_eval)
      *
      *  Eval      yMsgDta    = ' '
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 = 'yMsgDta    = '' '''
     C                   Callp     p_wrtCopy6(ds_eval)
      *
      *  Remark
     C                   Reset                   ds_remark
     C                   Callp     p_wrtCopy6(ds_remark)
      *
      *  Eval      xScnCsrRow = wScnCsrRow - WndTopRow
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 =
     C                                'xScnCsrRow = wScnCsrRow - WndTopRow'
     C                   Callp     p_wrtCopy6(ds_eval)
      *
      *  Remark
     C                   Reset                   ds_remark
     C                   Callp     p_wrtCopy6(ds_remark)
      *
      *  Select
     C                   Reset                   ds_selec
     C                   Callp     p_wrtCopy6(ds_selec)
      *
     C                   Endsr
      *
      *============================================================*
      *
      *============================================================*
      *
     C     WrtField      Begsr
      *
      *   Berechnen Anzahl benötigter Zeilen ...
     C                   Eval      totLin = f_nbrDspRw(FLDL0100)
     C                   Eval      curLin = 1
     C                   Eval      dspLen = 0
      *
      * ---------------------------*
      *   Ausgeben Kopfsatz
      * ---------------------------*
     C                   If        (row# + totLin - 1) > MAX_ROWS
     C                   Eval      newScn = bTrue
     C                   Endif
      *
     C                   If        newScn = bTrue
     C                   Exsr      inzScreen
     C                   Endif
      *
      * ---------------------------*
      *   Ausgeben Felddefinition
      * ---------------------------*
     C                   If        fieldCount < 99999
     C                   Eval      baseFldName = 'FLD' + a#FdCount
     C                   Else
     C                   Eval      baseFldName = '*CNT_ERROR'
     C                   Endif
      *
     C                   Dou       curLin > totLin
    R *
    R *  Generieren ALPHA Felder als GRAPHIC für CCSIDs 1200 und 1208.
 B02R ***                If         FLDL0100.F1DTYP = 'A' and
    R ***                           (FLDL0100.F1FDCC = 1200 or FLDL0100.F1FDCC = 1208)
    R ***                Eval       FLDL0100.F1DTYP = 'G'
 E02R ***                Endif
      *
      *  Generieren Felder für mehrzeilige GRAPHIC Felder, weil das
      *  Schlüsselwort 'CNTFLD()' für GRAPHIC Felder nicht zulässig ist.
     C                   If        (baseFldName <> '*CNT_ERROR' and
     C                              FLDL0100.F1DTYP = 'G' and totLin > 1)
     C                   Eval      fieldName = %trimR(baseFldName) +
     C                                         %editc(curLin: 'X')
     C                   Else
     C                   Eval      fieldName = baseFldName
     C                   Endif
      *
      *  ... ausgeben Text
     C                   If        curLin = 1
      *      ... Feldname
     C                   Eval      headerType = '*FIELDNAME'
     C                   Reset                   ds_literal
     C                   Eval      $lit_neg_1 = 'N'
     C                   Eval      $lit_ind_1 = '70'
     C                   Eval      $lit_neg_2 = 'N'
     C                   Eval      $lit_ind_2 = '75'
     C                   Exsr      #TEXT
      *
      *      ... Feldtext
     C                   Eval      headerType = '*FIELDTEXT'
     C                   Reset                   ds_literal
     C                   Eval      $lit_neg_1 = ' '
     C                   Eval      $lit_ind_1 = '70'
     C                   Eval      $lit_neg_2 = 'N'
     C                   Eval      $lit_ind_2 = '75'
     C                   Exsr      #TEXT
      *
      *      ... Feldtyp
     C                   Eval      headerType = '*FIELDTYPE'
     C                   Reset                   ds_literal
     C                   Eval      $lit_neg_1 = 'N'
     C                   Eval      $lit_ind_1 = '70'
     C                   Eval      $lit_neg_2 = ' '
     C                   Eval      $lit_ind_2 = '75'
     C                   Exsr      #TEXT
     C                   Endif
      *
      *  ... ausgeben Feld für Schlüsselanzeiger
     C                   If        curLin = 1
     C                   Reset                   ds_fldDef
     C                   Eval      $fldD_fldN = 'KEY' + a#FdCount
     C                   Eval      $fldD_len  = '    1'
     C                   Eval      $fldD_dTyp = 'A'
     C                   Eval      $fldD_decP = '  '
     C                   Eval      $fldD_IO   = 'O'
     C                   Eval      $fldD_row  = row#
     C                   Eval      $fldD_Col  = 26
     C                   Callp     p_wrtDspF(ds_fldDef)
     C                   Endif
      *
      *  ... ausgeben "hidden field" für Nachrichtennummer TXT...
     C                   If        curLin = 1
     C                   Reset                   ds_msgHidden
     C                   Eval      $msgH_fldN = 'MSG' + a#FdCount
     C                   Callp     p_wrtDspF(ds_msgHidden)
     C                   Endif
      *
      *  ... ausgeben Hinweis "Unzulässige Zeichen"
     C                   If        curLin = 1
     C                   Reset                   ds_msgChar
     C                   Eval      $msgC_ind  = ind40#a
     C                   Eval      $msgC_len  = ''
     C                   Eval      $msgC_dTyp = ''
     C                   Eval      $msgC_IO   = ''
     C                   Eval      $msgC_row$ = ''
     C                   Eval      $msgC_col$ = ''
     C                   Eval      $msgC_kWrd = ''
     C                   Callp     p_wrtDspF(ds_msgChar)
      *
     C                   Reset                   ds_msgChar
     C                   Eval      $msgC_op     = 'O'
     C                   Eval      $msgC_ind    = ind50#a
     C                   Eval      $msgC_fldN = 'TXT' + a#FdCount
     C                   Eval      $msgC_fldNum = a#FdCount
     C                   Eval      $msgC_row    = row#
     C                   Eval      $msgC_col    = 29
     C                   Callp     p_wrtDspF(ds_msgChar)
     C                   Endif
      *
      *  ... Farbe: weiß
     C                   If        curLin = 1
     C                   Reset                   ds_dspAtr
     C                   Eval      $dspA_atr = 'COLOR(WHT)'
     C                   Callp     p_wrtDspF(ds_dspAtr)
     C                   Endif
      *
      *  ... ausgeben Felddefinition
     C                   Reset                   ds_fldDef
     C                   Eval      $fldD_fldN = fieldName
      *
      *      ... Referenzierung - Zeile 1
     C                   Eval      $fldD_row  = row# + (curLin - 1)
     C                   Eval      $fldD_col  = 29
      *
      *          ... Referenzfeld
     C                   If        (FLDL0100.F1DTYP <> 'G')                     = Graphic
     C                   Eval      $fldD_ref  = 'R'
     C                   Eval      $fldD_kWrd = 'REFFLD(' +
     C                                          %trimr(FLDL0100.F1FNME) + ' -'
     C                   Eval      hasRefFld = bTrue
     C                   Else
     C                   Eval      hasRefFld = bFalse
     C                   Endif
      *
      *          ... Datentyp
     C                   select
     C                   When      (FLDL0100.F1DTYP = 'L') or                   = Date
     C                             (FLDL0100.F1DTYP = 'T') or                   = Time
     C                             (FLDL0100.F1DTYP = 'Z')                      = Timestamp
     C                   Eval      $fldD_dTyp = 'A'
     C                   When      (FLDL0100.F1DTYP = 'G')                      = Graphic
     C                   Eval      $fldD_dTyp = 'G'
     C                   Other
     C                   Eval      $fldD_dTyp = ' '
     C                   Endsl
      *
      *          ... Feldlänge
     C                   If        (f_isToLong(FLDL0100) = bTrue) or
     C                             (FLDL0100.F1DTYP = 'G' and totLin > 1)
     C                   If        (FLDL0100.F1DTYP = 'G')                      = Graphic
     C                   If        curLin < totLin
     C                   Eval      newLen# = f_cntFldLn(FLDL0100)
     C                   Else
     C                   Eval      newLen# = f_dsplyLn(FLDL0100) - dspLen
     C                   If        newLen# > f_cntFldLn(FLDL0100)
     C                   Eval      newLen# = f_cntFldLn(FLDL0100)
     C                   Endif
     C                   Endif
     C                   Eval      dspLen = dspLen + newLen#
     C                   Else
     C                   Eval      newLen# = f_maxDspLn(FLDL0100)
     C                   Endif
     C                   Else
     C                   Eval      newLen# = f_dsplyLn(FLDL0100)
     C                   Endif
      *
     C                   If        (FLDL0100.F1DTYP = 'G' or                    = Graphic
     C                              f_isToLong(FLDL0100) = bTrue)
     C                   Eval      $fldD_len  = newLen#a
     C                   Else
     C                   Eval      $fldD_len  = ''
     C                   Endif
      *
      *          ... Bezugszahl
     C                   Eval      $fldD_neg  = '  '
     C                   Eval      $fldD_ind40= ind40#a
     C                   Eval      $fldD_ind50= ind50#a
      *          ... Input Feld
     C                   If        FLDL0100.F1USE = 'I'
     C                   Eval      $fldD_IO   = 'O'
     C                   Else
     C                   Eval      $fldD_IO   = 'B'
     C                   Endif
      *
     C                   Eval      $fldD_decP = '  '
     C                   Callp     p_wrtDspF(ds_fldDef)
      *
      *      ... Referenzierung - Zeile 2
     C                   If        (FLDL0100.F1DTYP <> 'G')                     = Graphic
     C                   Reset                   ds_fldCnt
     C                   Eval      $fldC_kWrd =
     C                              %trimr(refLib) + '/' + %trimr(refFile) + ')'
     C                   Callp     p_wrtDspF(ds_fldCnt)
     C                   Endif
      *
      *  ... Feld über mehrere Zeilen verteilen
     C                   If        (FLDL0100.F1DTYP <> 'G')                     = Graphic
     C                   If        totLin > 1
     C                   Reset                   ds_dspAtr
     C                   Eval      $dspA_atr = 'CNTFLD(35)'
     C                   Callp     p_wrtDspF(ds_dspAtr)
     C                   Endif
     C                   Else
      *       // TODO: Feld über mehrere Zeilen splitten
     C                   Endif
      *
      *  ... CCSID und Feldlänge für GRAPHIC Felder
     C                   If        (FLDL0100.F1DTYP = 'G')                      = Graphic
     C                   Reset                   ds_dspAtr
     C                   Eval      $dspA_atr = 'CCSID(13488 ' +
     C                                          %char(%int((newLen# / 2) + .5))
     C                                          + ')'
     C                   Callp     p_wrtDspF(ds_dspAtr)
     C                   Endif
      *
      *  ... CCSID CHARACTER Felder mit CCSID 1208 oder 1200
     C                   If        (FLDL0100.F1DTYP = 'A' and                   = Graphic
     C                              (FLDL0100.F1FDCC = 1200 or
     C                               FLDL0100.F1FDCC = 1208))
     C                   Reset                   ds_dspAtr
     C                   Eval      $dspA_atr = 'CCSID(13488 ' +
     C                                          %char(newLen#)
     C                                          + ')'
     C                   Callp     p_wrtDspF(ds_dspAtr)
     C                   Endif
      *
      *  Alias Feldname überschreiben, weil:
      *   - Aliasnamen in Groß-/Kleinbuchstaben sind nicht zulässig.
      *   - Einige Sonderzeichen wie zum Beispiel '#' oder '.' sind
      *     in einer Display File nicht zulässig.
      *  Der tatsächliche Alias Name spielt keine Rolle und wird daher
      *  auf den generierten Namen 'ALSnnnnn' gesetzt. Es könnte auch
      *  jeder andere eindeutige Name sein.
     C                   If        FLDL0100.F1AFNL > 0 and hasRefFld = bTrue
     C                   Reset                   ds_alias
     C                   Eval      $alias_kWrd = 'ALIAS(' +
     C                                           'ALS' + a#FdCount
     C                                           + ')'
     C                   Callp     p_wrtDspF(ds_alias)
     C                   ENDIF
      *
      *  Auf INPUT-Only-Felder prüfen ...
     C                   If        FLDL0100.F1USE <> 'I'
      *  .. Farbe = weiß
     C                   Reset                   ds_dspAtr
     C                   Eval      $dspA_atr = 'COLOR(WHT)'
     C                   Callp     p_wrtDspF(ds_dspAtr)
     C                   Else
      *  .. Farbe = grün
     C                   Reset                   ds_dspAtr
     C                   Eval      $dspA_atr = 'COLOR(GRN)'
     C                   Callp     p_wrtDspF(ds_dspAtr)
     C                   Endif
      *
      *  Feld schützen, wenn größer als 512-Zeichen ...
     C                   If        (f_isToLongMax(FLDL0100) = bTrue)
     C                   Eval      fldToLongMax = '1'
     C                   Else
     C                   Eval      fldToLongMax = '0'
     C                   Endif
      *
      *  Feld schützen, wenn größer als 512-Zeichen ...
     C                   If        (f_isToLong(FLDL0100) = bTrue) or
     C                             (f_isNotAlw(FLDL0100) = bTrue)
     C                   If        FLDL0100.F1USE <> 'I'
     C                   Reset                   ds_dspAtr
     C                   Eval      $dspA_atr = 'DSPATR(PR)'
     C                   Callp     p_wrtDspF(ds_dspAtr)
      *
     C                   Reset                   ds_dspAtr
     C                   Eval      $dspA_ind = '72'
     C                   Eval      $dspA_atr = 'DSPATR(UL)'
     C                   Callp     p_wrtDspF(ds_dspAtr)
     C                   Endif
     C                   Eval      fldToLong = '1'
     C                   Else
      *  Schlüsselfelder schützen/freigeben ...
     C                   If        (f_isKeyFld(FLDL0100) = bTrue)
     C                   If        FLDL0100.F1USE <> 'I'
     C                   Reset                   ds_dspAtr
     C                   Eval      $dspA_neg = 'N'
     C                   Eval      $dspA_ind = '73'
     C                   Eval      $dspA_atr = 'DSPATR(PR)'
     C                   Callp     p_wrtDspF(ds_dspAtr)
      *
     C                   Reset                   ds_dspAtr
     C                   Eval      $dspA_ind = '73'
     C                   Eval      $dspA_atr = 'DSPATR(UL)'
     C                   Callp     p_wrtDspF(ds_dspAtr)
     C                   Endif
     C                   Endif
     C                   Eval      fldToLong = '0'
     C                   Endif
      *
     C                   If        isExit03
     C                   Callp(E)  CvtEditCode(
     C                               refFile: refLib
     C                               : §§User: FLDL0100.F1FNME: FLDL0100.F1EDTC)
     C                   If        (%error())
     C                   Eval      isExit03 = bFalse
     C                   Endif
     C                   Endif
      *
     C                   If        (not isExit03)
      *  EDTWRD/EDTCDE ausgeben ...
     C                   Select
      *  EDTWRD prüfen ...
     C                   When      FLDL0100.F1EDWD <> ' '                       Edit word
     C                   Reset                   ds_dspAtr
     C                   Eval      $dspA_atr = 'EDTWRD(''' + FLDL0100.F1EDWD
     C                   Eval      %subst($dspA_atr
     C                                    : FLDL0100.F1EDWL + 9: 2) = ''')'
     C                   Callp     p_wrtDspF(ds_dspAtr)
      *
      *  Abfragen Feld-EDTCDE aus PEEKFLD ...
     C                   When      EDTCDE <> ' '                                Edit code
     C                             and f_isFloatFld(FLDL0100) = bFalse
     C                   Reset                   ds_dspAtr
     C                   Eval      $dspA_atr = 'EDTCDE(' + EDTCDE + ')'
     C                   Callp     p_wrtDspF(ds_dspAtr)
      *
     C                   Other
      *  Kein EDTWRD / kein EDTCDE
     C                   IF        (f_isNumFld(FLDL0100)   = bTrue ) and
     C                             (f_isFloatFld(FLDL0100) = bFalse) and
     C                             (FLDL0100.F1DECP > 0            )
     C                   Reset                   ds_dspAtr
     C                   Eval      $dspA_atr = 'EDTCDE(' + 'P' + ')'
     C                   Callp     p_wrtDspF(ds_dspAtr)
     C                   ENDIF
     C                   Endsl
      *
     C                   Endif
      *
      *  Lower case Attribut
      *  bei Alpha-Feldern ...
     C                   If        (FLDL0100.F1DTYP = 'A' or
     C                              FLDL0100.F1DTYP = 'G') and
     C                             (i_alwLC =  bTrue) and
     C                             (FLDL0100.F1USE <> 'I')
     C                   Reset                   ds_dspAtr
     C                   Eval      $dspA_atr = 'CHECK(LC) '
     C                   Callp     p_wrtDspF(ds_dspAtr)
     C                   Endif
      *
     C                   If        (FLDL0100.F1DTYP = 'G')
     C                   Eval      curLin = curLin + 1
     C                   Else
     C                   Eval      curLin = curLin + totLin
     C                   Endif
      *
     C                   Enddo
      *
      * ---------------------------*
      *  Copy-Strecken ausgeben
      * ---------------------------*
     C                   Exsr      wrtCopy1
     C                   Exsr      wrtCopy2
     C                   Exsr      wrtCopy3
     C                   Exsr      wrtCopy4
     C                   Exsr      wrtCopy5
     C                   Exsr      wrtCopy6
      *
      * ---------------------------*
      *  erhöhen Zeilenzähler
      * ---------------------------*
     C                   Eval      row# = row# + totLin
      *
      * ---------------------------*
      *  erhöhen Bezugszahlenzähler
      * ---------------------------*
     C                   Eval      ind40# = ind40# + 1
     C                   Eval      ind50# = ind50# + 1
      *
     C                   Endsr
      *
      *============================================================*
      *    inzScreen     Initialisieren neuen Bildschirm           *
      *============================================================*
      *
     C     inzScreen     Begsr
      *
      *  Wenn die laufende Bildschirm-Nr. = 0 ist,
      *  dann ...
     C                   If        scn# = 0
      *    ... ist keine abzuschließende
      *        Subroutine vorhanden
     C                   Else
      *    ... ansonsten Subroutine abschließen  (Copy-Book 1)
      *           Endsr
     C                   Reset                   ds_endsr
     C                   Callp     p_wrtCopy1(ds_endsr)
      *           Remark
     C                   Reset                   ds_remark
     C                   Callp     p_wrtCopy1(ds_remark)
     C                   Endif
      *
      *  Eine neue Subroutine beginnen (Copy-Book 1) ...
     C                   Eval      ind40# = 30
     C                   Eval      ind50# = 50
     C                   Eval      scn# = scn# + 1
      *
      *           Remark
     C                   Reset                   ds_remark
     C                   Eval      $rem_txt  = §remLine
     C                   Callp     p_wrtCopy1(ds_remark)
      *
      *           Remark
     C                   Reset                   ds_remark
     C                   Eval      $rem_info = 'Prüfung auf ungültige +
     C                                          Feldinhalte, Seite ' + scn#a
     C                   Callp     p_wrtCopy1(ds_remark)
      *
      *           Remark
     C                   Reset                   ds_remark
     C                   Eval      $rem_txt  = §remLine
     C                   Callp     p_wrtCopy1(ds_remark)
      *
      *           Remark
     C                   Reset                   ds_remark
     C                   Callp     p_wrtCopy1(ds_remark)
      *
      *           Begsr
     C                   Reset                   ds_begsr
     C                   Eval      $begsr_f1  = 'chkChar' + scn#a
     C                   Callp     p_wrtCopy1(ds_begsr)
      *
      *           Remark
     C                   Reset                   ds_remark
     C                   Callp     p_wrtCopy1(ds_remark)
      *
      *  Einen neuen Record im DspF anfangen ...
     C                   Reset                   ds_rcdFmt
      *
     C                   If        (i_alwLC = bFalse)
     C                   Eval      $rcdFm_nme = 'UC' + scn#a
     C                   Else
     C                   Eval      $rcdFm_nme = 'LC' + scn#a
     C                   Endif
      *
     C                   Callp     p_wrtDspF(ds_rcdFmt)
      *
      *  OVERLAY
     C                   Reset                   ds_overlay
     C                   Callp     p_wrtDspF(ds_overlay)
      *  WINDOW-Definition für *DS3
     C                   Reset                   ds_window
     C                   Eval      $wdw_mode = '*DS3'
     C                   Callp     p_wrtDspF(ds_window)
      *  WINDOW-Definition für *DS4
     C                   Reset                   ds_window
     C                   Eval      $wdw_mode = '*DS4'
     C                   Callp     p_wrtDspF(ds_window)
      *  Anzeigemodus
     C                   Reset                   ds_dspMode
     C                   Callp     p_wrtDspF(ds_dspMode)
      *  Cursor Position
     C                   Reset                   ds_csrLoc
     C                   Callp     p_wrtDspF(ds_csrLoc)
      *  Cursor Position, Variable CSRROW
     C                   Reset                   ds_fldDef
     C                   Eval      $fldD_fldN = 'CSRROW'
     C                   Eval      $fldD_len  = '    3'
     C                   Eval      $fldD_dTyp = 'S'
     C                   Eval      $fldD_decP = ' 0'
     C                   Eval      $fldD_IO   = 'H'
     C                   Eval      $fldD_row$ = ' '
     C                   Eval      $fldD_col$ = ' '
     C                   Callp     p_wrtDspF(ds_fldDef)
      *  Cursor Position, Variable CSRCOL
     C                   Reset                   ds_fldDef
     C                   Eval      $fldD_fldN = 'CSRCOL'
     C                   Eval      $fldD_len  = '    3'
     C                   Eval      $fldD_dTyp = 'S'
     C                   Eval      $fldD_decP = ' 0'
     C                   Eval      $fldD_IO   = 'H'
     C                   Eval      $fldD_row$ = ' '
     C                   Eval      $fldD_col$ = ' '
     C                   Callp     p_wrtDspF(ds_fldDef)
      *
      *  Initialisierung Feldausgabe
     C                   Eval      row#   = 4
      *
     C                   Eval      newScn = bFalse
      *
     C                   Endsr
      *
      *============================================================*
      *    wrtCopy1      Ausgeben Copy-Book 1 pro Feld             *
      *                  Prüfung auf nicht darstellbare Zeichen    *
      *============================================================*
      *
     C     wrtCopy1      Begsr
      *
      *  Remark
     C                   Reset                   ds_remark
     C                   Eval      $rem_info = 'Feld: ' + FLDL0100.F1FNME
     C                   Callp     p_wrtCopy1(ds_remark)
      *
      *  If        EDT0000001 = '1'
     C                   Reset                   ds_if
     C                   Eval      $if_fct2 = 'EDT' + a#FdCount + ' = ''1'''
     C                   Callp     p_wrtCopy1(ds_if)
      *
      *  Eval      F_FIELD = 'TEST#'
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 =
     C                               'F_FIELD = ' +
     C                               '''' + %trimr(FLDL0100.F1FNME) + ''''
     C                   Callp     p_wrtCopy1(ds_eval)
      *
     C                   Eval      closeChar1 = ''
      *
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 = 'yOutBuffer ='
      *
     C                   If        (f_isCharFld(FLDL0100) = bTrue and
     C                              f_isVarLen(FLDL0100) = bTrue)
     C                   Eval      $eval_fct2 = %triMR($eval_fct2) +
     C                                          '%trimR('
     C                   Eval      closeChar1 = ')'
     C                   Endif
      *
     C                   Callp     p_wrtCopy1(ds_eval)
      *
     C                   If        (FLDL0100.F1DTYP =  'G')
     C                   Eval      totFields = f_nbrDspRw(FLDL0100)
     C                   Else
     C                   Eval      totFields = 1
     C                   Endif
      *
     C                   For       curField = 1 to totFields
      *
     C                   Eval      closeChar2 = ''
      *
     C                   Reset                   ds_eval
     C                   Clear                   $eval_opC
      *
     C                   If        f_isNumFld(FLDL0100) = bTrue
     C                   If        (FLDL0100.F1DTYP = 'F')
     C                   Eval      $eval_fct2 = '%editflt(FLD' + a#FdCount
     C                   Eval      closeChar2 = ')'
     C                   Else
     C                   Eval      $eval_fct2 = '%char(FLD' + a#FdCount
     C                   Eval      closeChar2 = ')'
     C                   Endif
     C                   Else
     C                   Eval      $eval_fct2 = 'FLD' + a#FdCount
     C                   Endif
      *
     C                   If        totFields > 1
     C                   Eval      $eval_fct2 = %trimR($eval_fct2) +
     C                                          %editc(curField: 'X')
     C                   Endif
      *
     C                   Eval      $eval_fct2 = %trimR($eval_fct2) + closeChar2
      *
     C                   If        curField < totFields
     C                   Eval      $eval_fct2 = %trimR($eval_fct2) + ' +'
     C                   Endif
      *
     C                   Callp     p_wrtCopy1(ds_eval)
      *
     C                   Endfor
      *
     C                   If        (closeChar1 <> '')
     C                   Reset                   ds_eval
     C                   Clear                   $eval_opC
     C                   Eval      $eval_fct2 = closeChar1
     C                   Callp     p_wrtCopy1(ds_eval)
     C                   Endif
      *
      *  Eval      yOutBuffLn = ??
      *
     C                   If        (f_isCharFld(FLDL0100) = bFalse)
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 = 'yOutBuffLn = 0'
     C                   Callp     p_wrtCopy1(ds_eval)
     C                   Else
      *
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 = 'yOutBuffLn = %len('
     C                   If        (f_isVarLen(FLDL0100) = bTrue)
     C                   Eval      $eval_fct2 = %trimR($eval_fct2) + '%trimR('
     C                   Endif
     C                   Callp     p_wrtCopy1(ds_eval)
      *
     C                   For       curField = 1 to totFields
      *
     C                   Reset                   ds_eval
     C                   Clear                   $eval_opC
      *
     C                   Eval      $eval_fct2 = %trimR($eval_fct2) +
     C                                          'FLD' + a#FdCount
     C                   If        totFields > 1
     C                   Eval      $eval_fct2 = %trimR($eval_fct2) +
     C                                          %editc(curField: 'X')
     C                   Endif
      *
     C                   If        curField < totFields
     C                   Eval      $eval_fct2 = %trimR($eval_fct2) + ' +'
     C                   Endif
      *
     C                   Callp     p_wrtCopy1(ds_eval)
     C                   Endfor
      *
     C                   Reset                   ds_eval
     C                   Clear                   $eval_opC
     C                   Eval      $eval_fct2 = ')'
     C                   If        (f_isVarLen(FLDL0100) = bTrue)
     C                   Eval      $eval_fct2 = %trimR($eval_fct2) + ')'
     C                   Endif
     C                   Callp     p_wrtCopy1(ds_eval)
      *
     C                   Endif
      *
      *  Exsr      chkChar
     C                   Reset                   ds_exsr
     C                   Eval      $exsr_fct2 = 'chkChar'
     C                   Callp     p_wrtCopy1(ds_exsr)
      *
      *  Eval      *IN40 = isVisible
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 = '*IN' + ind40#a + ' = isVisible'
     C                   Callp     p_wrtCopy1(ds_eval)
      *
      *  Eval      EDT0000001 = *IN40
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 =  'EDT' + a#FdCount +
     C                                           ' = *IN' + ind40#a
     C                   Callp     p_wrtCopy1(ds_eval)
      *
      *  Eval      KEY0000001 = keyChar
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 = 'KEY' + a#FdCount + ' = keyChar'
     C                   Callp     p_wrtCopy1(ds_eval)
      *
      *  If        (isVisible = bFalse)
     C                   Reset                   ds_if
     C                   Eval      $if_fct2 = '(isVisible = bFalse)'
     C                   Callp     p_wrtCopy1(ds_if)
      *
      *  Eval      MSG00001 = '0076'
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 = 'MSG' + a#FdCount
     C                                                + ' = ''0076'''
     C                   Callp     p_wrtCopy1(ds_eval)
      *
      *  Endif
     C                   Reset                   ds_endif
     C                   Callp     p_wrtCopy1(ds_endif)
      *
      *  Else
     C                   Reset                   ds_else
     C                   Callp     p_wrtCopy1(ds_else)
      *
      *  Eval      isCvtChar = bTrue
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 = 'isCvtChar = bTrue'
     C                   Callp     p_wrtCopy1(ds_eval)
      *
      *  Eval      *IN40 = EDT0000001
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 = '*IN' + ind40#a +
     C                                          ' = EDT' + a#FdCount
     C                   Callp     p_wrtCopy1(ds_eval)
      *
      *  Endif
     C                   Reset                   ds_endif
     C                   Callp     p_wrtCopy1(ds_endif)
      *
      *  Remark
     C                   Reset                   ds_remark
     C                   Callp     p_wrtCopy1(ds_remark)
      *
     C                   If        FLDL0100.F1NALW = '1'
      *  If        %nullind(P_0000001)
     C                   Reset                   ds_if
     C                   Eval      $if_fct2 =
     C                               '%nullind(' + %trimR(FLDL0100.F1VFLD) + ')'
     C                   Callp     p_wrtCopy1(ds_if)
      *  Eval      *IN50 = '0'
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 = '*IN' + ind50#a + ' = ''0'''
     C                   Callp     p_wrtCopy1(ds_eval)
      *  Eval      &MSG0000001 = 'TXT0127'
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 = 'MSG' + a#FdCount
     C                                                + ' = ''0127'''
     C                   Callp     p_wrtCopy1(ds_eval)
      *  Else
     C                   Reset                   ds_else
     C                   Callp     p_wrtCopy1(ds_else)
      *  Eval      *IN50 = '1'
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 = '*IN' + ind50#a + ' = ''1'''
     C                   Callp     p_wrtCopy1(ds_eval)
      *  Endif
     C                   Reset                   ds_endif
     C                   Callp     p_wrtCopy1(ds_endif)
      *
     C                   Else
      *
      *  Eval      *IN50 = '1'
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 = '*IN' + ind50#a + ' = ''1'''
     C                   Callp     p_wrtCopy1(ds_eval)
      *
     C                   Endif
      *
      *  Remark
     C                   Reset                   ds_remark
     C                   Callp     p_wrtCopy1(ds_remark)
      *
     C                   Endsr
      *
      *============================================================*
      *    wrtCopy2      Ausgeben Copy-Book 2 pro Feld             *
      *                  Aufrufen Hex-Editor                       *
      *============================================================*
      *
     C     wrtCopy2      Begsr
      *
      *  Remark
     C                   Reset                   ds_remark
     C                   Eval      $rem_info = 'Feld: ' + FLDL0100.F1FNME
     C                   Callp     p_wrtCopy2(ds_remark)
      *
      *  When      (xScnCsrRow >= 04) and
     C                   Reset                   ds_when
     C                   Eval      $when_fct2 =
     C                                       '(xScnCsrRow >= ' + row#a + ') and'
     C                   Callp     p_wrtCopy2(ds_when)
      *
      *            (xScnCsrRow <= 04) and
     C                   Reset                   ds_cont
     C                   Eval      num# = row# + totLin - 1
     C                   Eval      $cont_fct2 =
     C                                       '(xScnCsrRow <= ' + num#a + ') and'
     C                   Callp     p_wrtCopy2(ds_cont)
      *
      *            (scnNbr      = 001)
     C                   Reset                   ds_cont
     C                   Eval      $cont_fct2 =
     C                                       '(scnNbr      = ' + scn#a + ')'
     C                   Callp     p_wrtCopy2(ds_cont)
      *
      *  Input-Only Feld?
     C                   If        (FLDL0100.F1USE = 'I')
      *  ... JA
     C                   Reset                   ds_exsr
     C                   Eval      $exsr_fct2 = 'MSG8208'
     C                   Callp     p_wrtCopy2(ds_exsr)
     C                   Else
      *  ... NEIN
      *      If        (EDT0000001 = '1') and
     C                   Reset                   ds_if
     C                   Eval      $if_fct2='(EDT' + a#FdCount + ' = ''1'') and'
     C                   Callp     p_wrtCopy2(ds_if)
      *
      *                not (LNG0000001 = '1')
     C                   Reset                   ds_if
     C                   Eval      $if_opC  = ' '
     C                   Eval      $if_fct2='not (LNG' + a#FdCount + ' = ''1'')'
     C                   Callp     p_wrtCopy2(ds_if)
      *
      *      Eval      P_00000001 = FLD0000001
     C                   Reset                   ds_exsr
     C                   Eval      $exsr_fct2 = 'f_' + %trim(FLDL0100.F1VFLD)
     C                   Callp     p_wrtCopy2(ds_exsr)
      *
      *  Endif
     C                   Reset                   ds_endif
     C                   Callp     p_wrtCopy2(ds_endif)
      *
      *  Eval      yFldName = 'TEST#V    '
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 = 'yFldName = ' +
     C                                          '''' + FLDL0100.F1FNME + ''''
     C                   Callp     p_wrtCopy2(ds_eval)
      *
      *  Eval      Editor = cEDITOR_HEX
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 = 'Editor = cEDITOR_HEX'
     C                   Callp     p_wrtCopy2(ds_eval)
      *
     C**                 If        f_isCharFld(FLDL0100) = bTrue
     C**                 Reset                   ds_eval
     C**                 Eval      $eval_fct2 = 'trimLen = %len(' + FLDL0100.F1VFLD + ')'
     C**                 Callp     p_wrtCopy2(ds_eval)
     C**                 Reset                   ds_eval
     C**                 Eval      $eval_fct2 = 'isCharFld = bTrue'
     C**                 Callp     p_wrtCopy2(ds_eval)
     C**                 Else
     C**                 Reset                   ds_eval
     C**                 Eval      $eval_fct2 = 'trimLen = -1'
     C**                 Callp     p_wrtCopy2(ds_eval)
     C**                 Reset                   ds_eval
     C**                 Eval      $eval_fct2 = 'isCharFld = bFalse'
     C**                 Callp     p_wrtCopy2(ds_eval)
     C**                 Endif
      *
      *  Exsr      fromBuffer
     C                   Reset                   ds_exsr
     C                   Eval      $exsr_fct2 = 'fromBuffer'
     C                   Callp     p_wrtCopy2(ds_exsr)
      *
      *  If        yMsgID = 'USR8112'
     C                   Reset                   ds_if
     C                   Eval      $if_fct2 = 'yMsgID = ''USR8112'''
     C                   Callp     p_wrtCopy2(ds_if)
      *
     C                   Reset                   ds_exsr
     C                   Eval      $exsr_fct2 = 's_' + %trim(FLDL0100.F1VFLD)
     C                   Callp     p_wrtCopy2(ds_exsr)
      *
      *  Eval      EDT0000006 = '1'
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 = 'EDT' + a#FdCount + ' = ''1'''
     C                   Callp     p_wrtCopy2(ds_eval)
      *
      *  Eval      %NULLIND() = *OFF
     C                   If        (FLDL0100.F1NALW = '1')
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 =
     C                               '%nullind(' +
     C                               %trimR(FLDL0100.F1VFLD) + ') = *OFF'
     C                   Callp     p_wrtCopy2(ds_eval)
     C                   Endif
      *
      *  Endif
     C                   Reset                   ds_endif
     C                   Callp     p_wrtCopy2(ds_endif)
      *
      *  Remark
     C                   Reset                   ds_remark
     C                   Callp     p_wrtCopy2(ds_remark)
      *
     C                   Endif
      *
     C                   Endsr
      *
      *============================================================*
      *    wrtCopy3      Ausgeben Copy-Book 3 pro Feld             *
      *                  Felder für Feldsperre                     *
      *============================================================*
      *
     C     wrtCopy3      Begsr
      *
      *  EDT0000001      S              1A   inz
     C                   Reset                   ds_defn
     C                   Eval      $defn_fldN = ' EDT' + a#FdCount
     C                   Eval      $defn_type = 'S'
     C                   Eval      $defn_len  = '      1'
     C                   Eval      $defn_dTyp = 'A'
     C                   Eval      $defn_decP = ' '
     C                   Eval      $defn_keyW = 'inz'
     C                   Callp     p_wrtCopy3(ds_defn)
      *
     C                   Endsr
      *
      *============================================================*
      *    wrtCopy4      Ausgeben Copy-Book 4 pro Feld             *
      *                  Konstanten für "Feld zu lang"             *
      *============================================================*
      *
     C     wrtCopy4      Begsr
      *
      *  LNG0000001      C                   const('0') / const('1')
     C                   Reset                   ds_defn
     C                   Eval      $defn_fldN = ' LNG' + a#FdCount
     C                   Eval      $defn_type = 'C'
     C                   Eval      $defn_len  = ' '
     C                   Eval      $defn_dTyp = ' '
     C                   Eval      $defn_decP = ' '
     C                   Eval      $defn_keyW = 'const(''' + fldToLong + ''')'
     C                   Callp     p_wrtCopy4(ds_defn)
      *
      *  MAX0000001      C                   const('0') / const('1')
     C                   Reset                   ds_defn
     C                   Eval      $defn_fldN = ' MAX' + a#FdCount
     C                   Eval      $defn_type = 'C'
     C                   Eval      $defn_len  = ' '
     C                   Eval      $defn_dTyp = ' '
     C                   Eval      $defn_decP = ' '
     C                   Eval      $defn_keyW = 'const(''' + fldToLongMax +''')'
     C                   Callp     p_wrtCopy4(ds_defn)
      *
     C                   Endsr
      *
      *============================================================*
      *    wrtCopy5      Ausgeben Copy-Book 5 pro Feld             *
      *                  Setzen NULL Indicator                     *
      *============================================================*
      *
     C     wrtCopy5      Begsr
      *
      *  Remark
     C                   Reset                   ds_remark
     C                   Eval      $rem_info = 'Feld: ' + FLDL0100.F1FNME
     C                   Callp     p_wrtCopy5(ds_remark)
      *
      *  When      (xScnCsrRow >= 04) and
     C                   Reset                   ds_when
     C                   Eval      $when_fct2 =
     C                                       '(xScnCsrRow >= ' + row#a + ') and'
     C                   Callp     p_wrtCopy5(ds_when)
      *
      *            (xScnCsrRow <= 04) and
     C                   Reset                   ds_cont
     C                   Eval      num# = row# + totLin - 1
     C                   Eval      $cont_fct2 =
     C                                       '(xScnCsrRow <= ' + num#a + ') and'
     C                   Callp     p_wrtCopy5(ds_cont)
      *
      *            (scnNbr      = 001)
     C                   Reset                   ds_cont
     C                   Eval      $cont_fct2 =
     C                                       '(scnNbr      = ' + scn#a + ')'
     C                   Callp     p_wrtCopy5(ds_cont)
      *
      * Eval      %nullind(P_00000001) =
      *              not %nullind(P_00000001)
     C                   If        (FLDL0100.F1NALW = '1')
      *
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 =
     C                               '%nullind(' +
     C                               %trimR(FLDL0100.F1VFLD) + ') = '
     C                   Callp     p_wrtCopy5(ds_eval)
     C                   Reset                   ds_eval
     C                   Clear                   $eval_opC
     C                   Eval      $eval_fct2 = 'not %nullind(' +
     C                                          %trimR(FLDL0100.F1VFLD) + ')'
     C                   Callp     p_wrtCopy5(ds_eval)
      *
     C                   Else
      *
      *  Setzen Fehlerflag: Feld ist nicht NULL-fähig
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 = 'pgmMsgID = ''USR8191'''
     C
     C                   Callp     p_wrtCopy5(ds_eval)
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 = 'pgmMsgDta = FLDL0100.F1FNME'
     C                   Callp     p_wrtCopy5(ds_eval)
     C                   Reset                   ds_callp
     C                   Eval      $callp_fct2 = 'p_sndPgmMg(pgmMsgID: +
     C                                                       pgmMsgDta: +
     C                                                       psPgmName)'
     C                   Callp     p_wrtCopy5(ds_callp)
      *
     C                   Endif
      *
      *  Remark
     C                   Reset                   ds_remark
     C                   Callp     p_wrtCopy5(ds_remark)
      *
     C                   Endsr
      *
      *============================================================*
      *    wrtCopy6      Ausgeben Copy-Book 6 pro Feld             *
      *                  Aufrufen String-Editor  (c_fldStrEd)      *
      *============================================================*
      *
     C     wrtCopy6      Begsr
      *
      *  Remark
     C                   Reset                   ds_remark
     C                   Eval      $rem_info = 'Feld: ' + FLDL0100.F1FNME
     C                   Callp     p_wrtCopy6(ds_remark)
      *
      *  When      (xScnCsrRow >= 04) and
     C                   Reset                   ds_when
     C                   Eval      $when_fct2 =
     C                                       '(xScnCsrRow >= ' + row#a + ') and'
     C                   Callp     p_wrtCopy6(ds_when)
      *
      *            (xScnCsrRow <= 04) and
     C                   Reset                   ds_cont
     C                   Eval      num# = row# + totLin - 1
     C                   Eval      $cont_fct2 =
     C                                       '(xScnCsrRow <= ' + num#a + ') and'
     C                   Callp     p_wrtCopy6(ds_cont)
      *
      *            (scnNbr      = 001)
     C                   Reset                   ds_cont
     C                   Eval      $cont_fct2 =
     C                                       '(scnNbr      = ' + scn#a + ')'
     C                   Callp     p_wrtCopy6(ds_cont)
      *
      *  Eval      yFldName = 'TEST#V    '
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 = 'yFldName = ' +
     C                                          '''' + FLDL0100.F1FNME + ''''
     C                   Callp     p_wrtCopy6(ds_eval)
      *
      *  Input-Only Feld?
     C                   If        (FLDL0100.F1USE = 'I')
     C                   Reset                   ds_exsr
     C                   Eval      $exsr_fct2 = 'MSG8208'
     C                   Callp     p_wrtCopy6(ds_exsr)
     C                   Leavesr
     C                   Endif
      *
      *  Not a character Feld? => Error message
     C                   If        f_isCharFld(FLDL0100) <> bTrue
     C                   Reset                   ds_exsr
     C                   Eval      $exsr_fct2 = 'MSG8221'
     C                   Callp     p_wrtCopy6(ds_exsr)
     C                   Leavesr
     C                   Endif
      *
      *      If        (EDT0000001 <> '1') or
     C                   Reset                   ds_if
     C                   Eval      $if_fct2='(EDT' + a#FdCount + ' <> ''1'')'
     C                   Callp     p_wrtCopy6(ds_if)
      *
      *      Exsr USR8193
     C                   Reset                   ds_exsr
     C                   Eval      $exsr_fct2 = 'USR8193'
     C                   Callp     p_wrtCopy6(ds_exsr)
      *
      *      Leavesr
     C                   Reset                   ds_leavesr
     C                   Callp     p_wrtCopy6(ds_leavesr)
      *
      *      Endif
     C                   Reset                   ds_endif
     C                   Callp     p_wrtCopy6(ds_endif)
      *
      *      If        (LNG0000001 = '1')
     C                   Reset                   ds_if
     C                   Eval      $if_fct2='not (LNG' + a#FdCount + ' = ''1'')'
     C                   Callp     p_wrtCopy6(ds_if)
      *
      *      Eval      P_00000001 = FLD0000001
     C                   Reset                   ds_exsr
     C                   Eval      $exsr_fct2 = 'f_' + %trim(FLDL0100.F1VFLD)
     C                   Callp     p_wrtCopy6(ds_exsr)
      *
      *  Endif
     C                   Reset                   ds_endif
     C                   Callp     p_wrtCopy6(ds_endif)
      *
      *  Eval      Editor = cEDITOR_STRING
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 = 'Editor = cEDITOR_STRING'
     C                   Callp     p_wrtCopy6(ds_eval)
      *
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 =
     C                               'yLength = %len(' + FLDL0100.F1VFLD + ')'
     C                   Callp     p_wrtCopy6(ds_eval)
      *
      *  Exsr      fromBuffer
     C                   Reset                   ds_exsr
     C                   Eval      $exsr_fct2 = 'fromBuffer'
     C                   Callp     p_wrtCopy6(ds_exsr)
      *
      *  If        yMsgID = 'USR8112'
     C                   Reset                   ds_if
     C                   Eval      $if_fct2 = 'yMsgID = ''USR8112'''
     C                   Callp     p_wrtCopy6(ds_if)
      *
      *  Eval      FLD0000006 = P_00000006
     C                   Reset                   ds_exsr
     C                   Eval      $exsr_fct2 = 's_' + %trim(FLDL0100.F1VFLD)
     C                   Callp     p_wrtCopy6(ds_exsr)
      *
      *  Eval      EDT0000006 = '1'
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 = 'EDT' + a#FdCount + ' = ''1'''
     C                   Callp     p_wrtCopy6(ds_eval)
      *
      *  Eval      %NULLIND() = *OFF
     C                   If        (FLDL0100.F1NALW = '1')
     C                   Reset                   ds_eval
     C                   Eval      $eval_fct2 =
     C                               '%nullind(' +
     C                               %trimR(FLDL0100.F1VFLD) + ') = *OFF'
     C                   Callp     p_wrtCopy6(ds_eval)
     C                   Endif
      *
      *  Endif
     C                   Reset                   ds_endif
     C                   Callp     p_wrtCopy6(ds_endif)
      *
      *  Remark
     C                   Reset                   ds_remark
     C                   Callp     p_wrtCopy6(ds_remark)
      *
     C                   Endsr
      *
      *============================================================*
      *    #TEXT         Aufbereiten Feldbezeichner                *
      *============================================================*
      *
     C     #TEXT         Begsr
      *
     C                   Eval      $lit_kWrd = ''''
      *
      * Feldtyp
      * Feldname
     C                   Select
     C                   When      headerType = '*FIELDNAME'
     C                   Eval      $lit_kWrd =
     C                               %trimr($lit_kWrd) + FLDL0100.F1FNME
     C                   Eval      x = %len(%trimR($lit_kWrd))
     C                   Eval      y = x
      * Feldtyp
     C                   When      headerType = '*FIELDTYPE'
     C                   Eval      $lit_kWrd = %trimr($lit_kWrd) +
     C                                         f_headline(headerType: FLDL0100)
     C                   Eval      x = %len(%trimR($lit_kWrd))
     C                   Eval      y = x
      * Feldtext
     C                   Other
     C                   If        (FLDL0100.F1FTXT = ' ')
     C                   Eval      $lit_kWrd =
     C                               %trimr($lit_kWrd) + '?' + FLDL0100.F1FNME
     C                   Eval      x = %len(%trimR($lit_kWrd))
     C                   Eval      y = x
     C                   Else
      *  Textbezeichnung auf ' prüfen ...
     C                   Eval      r$ftxt = ''
     C                   Eval      x = 1
     C                   Eval      y = 1
     C                   Dow       (x <= %len(%trimR(FLDL0100.F1FTXT))) and
     C                             (y <= %len(r$ftxt))
     C                   Eval      %subst(r$ftxt: y: 1) =
     C                               %subst(FLDL0100.F1FTXT: x: 1)
      *
     C                   If        (%subst(FLDL0100.F1FTXT: x: 1) = '''') and
     C                             (y < %len(r$ftxt))
     C                   Eval      y = y + 1
     C                   Eval      %subst(r$ftxt: y: 1) = ''''
     C                   Endif
      *
     C                   Eval      x = x + 1
     C                   Eval      y = y + 1
     C                   Enddo
      *
     C                   Eval      $lit_kWrd = %trimr($lit_kWrd) + r$ftxt
     C                   Endif
     C                   Endsl
      *
      *  Hinzufügen '........'
     C                   Eval      $lit_kWrd = %trimr($lit_kWrd) + dotLine
      *
      *  Begrenzen Textlänge auf max. mögliche Anzahl Zeichen
     C                   If        (26 + y - x <= %len($lit_kWrd))
     C                   Eval      %subst($lit_kWrd: 25 + y - x: 1) = ''''
     C                   Eval      %subst($lit_kWrd: 26 + y - x   ) = ' '
     C                   Endif
      *
      *  Prüfen auf ungerade Anzahl ' (Hochkommata)
     C                   Eval      numQuote = 0
      *
     C                   Eval      z = 0
     C                   Dow       z < %len(%trimR($lit_kWrd))
     C                   Eval      z = z + 1
     C                   If        %subst($lit_kWrd: z: 1) = ''''
     C                   Eval      numQuote = numQuote + 1
     C                   Endif
     C                   Enddo
      *
      *  Bei einer ungeraden Anzahl von Hochkommata ...
     C                   If        %rem(numQuote : 2) <> 0
      *  ... suchen letztes Hochkomma
     C                   Dow       %subst($lit_kWrd: z: 1) <> ''''
     C                   Eval      z = z - 1
     C                   Enddo
      *  ... ersetzen letztes Hochkomma durch Leerzeichen
     C                   If        (z < %len($lit_kWrd))
     C                   Eval      %subst($lit_kWrd: %len($lit_kWrd): 1) = ''''
     C                   Else
     C                   Eval      %subst($lit_kWrd: z: 1) = ' '
      *  ... suchen letztes Hochkomma
     C                   Dow       %subst($lit_kWrd: z: 1) <> ''''
     C                   Eval      z = z - 1
     C                   Enddo
      *      und löschen ales hinter dem letzten Hochkomma
     C                   Eval      %subst($lit_kWrd: z + 1) = ''
     C                   Endif
     C                   Endif
      *
      *  Ausgeben Textfeld
     C                   Eval      $lit_row = row#
     C                   Eval      $lit_col = 2
     C                   Callp     p_wrtDspF(ds_literal)
      *
     C                   Endsr
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
     C                   Eval      EXIT03 = f_pgmCallN('EXIT03')
      *
     C                   Endsr
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
      *    wrtDspF       Ausgeben Copy-Book 1    'Cxxxxxxxxx'      *
      *============================================================*
     P p_wrtDspF       B
     D                 PI
     D  i_srcDta                           const like(SRCDTA)
      *
     C                   Eval      #SRCSEQ = #SRCSEQ + #Increment
      *
     C                   Eval      SRCSEQ  = #SRCSEQ
     C                   Eval      SRCDAT = 0
     C                   Eval      SRCDTA  = i_srcDta
     C                   Write     FOUTPUT
      *
     C                   Return
      *
     P                 E
      *
      *============================================================*
      *    wrtCopy1      Ausgeben Copy-Book 1    'Axxxxxxxxx'      *
      *============================================================*
     P p_wrtCopy1      B
     D                 PI
     D  i_srcDta                           const like(SRCDTA)
      *
     C                   If        i_alwLC = bFalse
      *  Nur einmal ausgeben, bei XAlwLC = FALSE
     C                   Eval      SRCSEQ = 0
     C                   Eval      SRCDAT = 0
     C                   Eval      SRCDTA  = i_srcDta
     C                   Write     FCOPY1
     C                   Else
      *  kein zweites Mal ausgeben
     C                   Endif
      *
     C                   Return
      *
     P                 E
      *
      *============================================================*
      *    wrtCopy2      Ausgeben Copy-Book 2    'Bxxxxxxxxx'      *
      *============================================================*
     P p_wrtCopy2      B
     D                 PI
     D  i_srcDta                           const like(SRCDTA)
      *
     C                   If        i_alwLC = bFalse
      *  Nur einmal ausgeben, bei XAlwLC = FALSE
     C                   Eval      SRCSEQ = 0
     C                   Eval      SRCDAT = 0
     C                   Eval      SRCDTA  = i_srcDta
     C                   Write     FCOPY2
     C                   Else
      *  kein zweites Mal ausgeben
     C                   Endif
      *
     C                   Return
      *
     P                 E
      *
      *============================================================*
      *    wrtCopy3      Ausgeben Copy-Book 3    'Cxxxxxxxxx'      *
      *                  Felddefinitionen                          *
      *============================================================*
     P p_wrtCopy3      B
     D                 PI
     D  i_srcDta                           const like(SRCDTA)
      *
     C                   If        i_alwLC = bFalse
      *  Nur einmal ausgeben, bei XAlwLC = FALSE
     C                   Eval      SRCSEQ = 0
     C                   Eval      SRCDAT = 0
     C                   Eval      SRCDTA  = i_srcDta
     C                   Write     FCOPY3
     C                   Else
      *  kein zweites Mal ausgeben
     C                   Endif
      *
     C                   Return
      *
     P                 E
      *
      *============================================================*
      *    wrtCopy4      Ausgeben Copy-Book 4    'Dxxxxxxxxx'      *
      *                  Konstanten für "Feld zu lang"             *
      *============================================================*
     P p_wrtCopy4      B
     D                 PI
     D  i_srcDta                           const like(SRCDTA)
      *
     C                   If        i_alwLC = bFalse
      *  Nur einmal ausgeben, bei XAlwLC = FALSE
     C                   Eval      SRCSEQ = 0
     C                   Eval      SRCDAT = 0
     C                   Eval      SRCDTA  = i_srcDta
     C                   Write     FCOPY4
     C                   Else
      *  kein zweites Mal ausgeben
     C                   Endif
      *
     C                   Return
      *
     P                 E
      *
      *============================================================*
      *    wrtCopy5      Ausgeben Copy-Book 5    'Exxxxxxxxx'      *
      *                  Umsetzen NULL-Indicator                   *
      *============================================================*
     P p_wrtCopy5      B
     D                 PI
     D  i_srcDta                           const like(SRCDTA)
      *
     C                   If        i_alwLC = bFalse
      *  Nur einmal ausgeben, bei XAlwLC = FALSE
     C                   Eval      SRCSEQ = 0
     C                   Eval      SRCDAT = 0
     C                   Eval      SRCDTA  = i_srcDta
     C                   Write     FCOPY5
     C                   Else
      *  kein zweites Mal ausgeben
     C                   Endif
      *
     C                   Return
      *
     P                 E
      *
      *============================================================*
      *    wrtCopy6      Ausgeben Copy-Book 6    'Gxxxxxxxxx'      *
      *                  Aufrufen Text-Editor                      *
      *============================================================*
     P p_wrtCopy6      B
     D                 PI
     D  i_srcDta                           const like(SRCDTA)
      *
     C                   If        i_alwLC = bFalse
      *  Nur einmal ausgeben, bei XAlwLC = FALSE
     C                   Eval      SRCSEQ = 0
     C                   Eval      SRCDAT = 0
     C                   Eval      SRCDTA  = i_srcDta
     C                   Write     FCOPY6
     C                   Else
      *  kein zweites Mal ausgeben
     C                   Endif
      *
     C                   Return
      *
     P                 E
      *
      *============================================================*
      *    readFld       Lesen nächstes Feld aus PEEKFLD           *
      *============================================================*
     P f_readFld       B
     D                 PI                        like(r§bool    )
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
