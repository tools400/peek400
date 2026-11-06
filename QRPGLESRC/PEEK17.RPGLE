**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 2.2.0                               *
//  Programm : PEEK17                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 20.10.97  Raddatz                                 *
//  geändert : 27.04.99  für Version 2.1.0                       *
//  geändert : 29.07.99  für Version 2.2.0                       *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Erfassen der Suchkriterien                                   *
//                                                               *
// ============================================================= *
// >>PRE-COMPILER<<                                              *
//   >>CRTCMD<< &LI/CRTPEEKOBJ SRCFILE(&SL/&SF) SRCMBR(&SM) +    *
//                           OBJLIB(&LI) DEVLIB(&LI) +           *
//                           SBMJOB(*NO) BNDDIR(PEEK) +          *
//                           INSTALL(*NO);                       *
//   >>EXECUTE<<                                                 *
// >>END-PRE-COMPILER<<                                          *
//===============================================================*
/copy QCOPYLE,H_SPEC
/copy QCOPYLE,COPYRIGHT

dcl-f peek17fm workstn(*ext) usage(*input: *output) usropn infds(workstn);

dcl-f peekfld keyed usropn infds(Peek_01_DS) prefix(f_);

dcl-ds workstn likeds(workstn_t);

dcl-ds Peek_01_DS likeds(infds_t);


/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,D_WORKSTN
/copy QCOPYLE,ShortCmd_D
/copy QCOPYLE,SDS
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,SCRNFKEYS
/copy QCOPYLE,D_INFDS

/define internal_prototype
/copy QCOPYLE,PPEEK17
/undefine internal_prototype

/copy QCOPYLE,SET0002
/copy QCOPYLE,SET0003
/copy QCOPYLE,SET0008

/copy QCOPYLE,USR8100
/copy QCOPYLE,USR8108
/copy QCOPYLE,USR8124
/copy QCOPYLE,USR8126
/copy QCOPYLE,USR8129
/copy QCOPYLE,USR8134
/copy QCOPYLE,USR8135
/copy QCOPYLE,USR8136
/copy QCOPYLE,USR8138
/copy QCOPYLE,USR8140
/copy QCOPYLE,USR8141
/copy QCOPYLE,USR8142
/copy QCOPYLE,USR8192

dcl-ds set0002 likeds(SET0002_t) inz;
dcl-ds set0003 likeds(SET0003_t) inz;
dcl-ds set0008 likeds(set0008_t) inz;

dcl-ds fldl0100 likeds(fldl0100_t) inz;

dcl-s yFKeys char(18) dim(32);
dcl-s yNbrOfKeys like(int4_t);
dcl-s YMsgID char(7);
dcl-s YMsgDta char(512);

dcl-s YPgmCmd char(10);
dcl-s YCmdDta like(pgmCmdDt_t);

dcl-s YField char(10);

dcl-s sfbot like(int4_t);
dcl-c NBR_F_KEYS 2;

dcl-s MustWait char(1) inz(bFalse);

dcl-s x like(int4_t) inz;

dcl-s R_Sign like(##Sign);
dcl-s R_Arg30 like(##Arg);
dcl-s R_QFile like(i_qFile);
dcl-s R_Member like(i_member);
dcl-s R_VorK like(##Arg);
dcl-s R_NachK like(##Arg);
dcl-s r_a1 char(1);
dcl-s R_Field like(##Field);

dcl-s peek21_name like(pgmCallN_t) inz;
dcl-s peek23_name like(pgmCallN_t) inz;
dcl-s peek37_name like(pgmCallN_t) inz;

/copy QCOPYLE,PPEEK21
/copy QCOPYLE,PPEEK23
/copy QCOPYLE,PPEEK37

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

/copy QCOPYLE,CEECNDHDLR

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek17;
  i_dsp80     like(bool_t) const;
  i_copyright like(copyright_t) const;
  i_qFile     like(qObj_t) const;
  i_member    like(mbr_t) const;
  o_field     like(fieldNme_t);
  o_operation like(operation_t);
  o_argument  like(argument_t);
  o_sign      like(sign_t);
  o_srchNbrs  like(srchNbrs_t);
  o_srchType  like(type_t);
  o_srchCase  like(bool_t);
  o_sgID      like(msgId_t);
  o_msgDta    like(msgDta_t);
end-pi;

dcl-s do_x2 packed(7);

dcl-ds f_key likerec(fpeekfld: *key);

//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr First;

dow ('1');

  //  Nachrichten anzeigen
  *in89 = '0';
  write msgctl;

  //  Anzeigen der Befehlstasten
  select;
  when ((sfbot = 2) and
     (yNbrOfKeys > NBR_F_KEYS * (sfbot - 1)));
    write pbbot#2;
  when ((sfbot = 3) and
     (yNbrOfKeys > NBR_F_KEYS * (sfbot - 1)));
    write pbbot#3;
  when ((sfbot = 4) and
     (yNbrOfKeys > NBR_F_KEYS * (sfbot - 1)));
    write pbbot#4;
  when ((sfbot = 5) and
     (yNbrOfKeys > NBR_F_KEYS * (sfbot - 1)));
    write pbbot#5;
  when ((sfbot = 6) and
     (yNbrOfKeys > NBR_F_KEYS * (sfbot - 1)));
    write pbbot#6;
  other;
    write pbbot#1;
    sfbot = 1;
  endsl;

  //  Anzeigen Bildschirm
  exfmt bild01;

  //  Nachrichten löschen
  p_rmvPgmMg(sds.pgmName);

  //  Bezugszahlen löschen
  exsr bzoff1;

  //  Mappen der gedrückten Taste
  //  in Programmbefehl
  peek21(workstn.aid: sds.pgmName
        : YPgmCmd: YCmdDta: YMsgID: YMsgDta);
  if (YMsgID <> *blanks);
    p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
    YMsgID = '';
    YMsgDta = '';
    iter;
  endif;

  //  Abfragen der Programmbefehle
  select;
  //  F3  - Ende
  when (YPgmCmd = '*EXIT');
    exsr C_EndPgm;
    leave;

  //  F4  - Prompt
  when (YPgmCmd = '*PROMPT');
    exsr C_Prompt;
    iter;

  //  F5  - Aktualisieren
  when (YPgmCmd = '*REFRESH');
    exsr C_Refresh;
    iter;

  //  F12 - Ende
  when (YPgmCmd = '*CANCEL');
    exsr C_EndPgm;
    leave;

  //  F24 - Weitere Tasten
  when (YPgmCmd = '*MOREKEYS');
    exsr C_MoreKeys;

  //  Datenfreigabe
  when (YPgmCmd = '*ENTER');
    exsr C_Enter;
    if (*in99 = *off);
      o_sgID = 'USR8112';
      o_msgDta = *blanks;
      leave;
    endif;

  other;
    //  Falsche Taste gedrückt
    p_wrongKey(workstn.aid: sds.pgmName);
    iter;
  endsl;

enddo;

close peekfld;
close peek17fm;

return;

//============================================================*
//    C_Enter       "Datenfreigabetaste"                      *
//============================================================*

begsr C_Enter;

  dou ('1');

    R_Field = ##Field;

    //  Prompt?
    //  ... ##Field
    if (%trim(##Field ) = set0008.set_prmt);
      exsr C_Prompt;
      if (*in99 = bTrue);
        leave;
      else;
      //  ...?
      endif;
    endif;

    exsr prfb1;

    if (##Field <> R_Field);
      MustWait = bTrue;
    endif;

    if (MustWait = bTrue);
      *in99 = '1';
    else;
    //  Wert belassen ...
    endif;

  enddo;

  if (*in99 = *off);
    o_field = ##Field;
    o_operation = ##op;
    o_argument = R_Arg30;
    o_sign = ##Sign;
    o_srchNbrs = ##Nbrs;

    select;
    when (##type = 'U');
      o_srchType = '*UNDERLINE';
    when (##type = 'R');
      o_srchType = '*REVERSE';
    when (##type = 'P');
      o_srchType = '*PINROW';
    other;
      o_srchType = '*NORMAL';
    endsl;

    o_srchCase = ##case;

    o_sgID = 'USR8112';
    o_msgDta = *blanks;
  endif;

endsr;

//============================================================*
//    BZOFF1        Ausschalten aller Fehlerbezugszahlen      *
//============================================================*

begsr bzoff1;

  //  DSPATR(PC)
  *in20 = '0'; // ##FIELD
  *in21 = '0'; // ##OP
  *in22 = '0'; // ##ARG
  *in23 = '0'; // ##NBRS
  *in24 = '0'; // ##TYPE
  *in25 = '0'; // ##CASE

  //  DSPATR(RI)
  *in30 = '0'; // ##FIELD
  *in31 = '0'; // ##OP
  *in32 = '0'; // ##ARG
  *in33 = '0'; // ##NBRS
  *in34 = '0'; // ##TYPE
  *in35 = '0'; // ##CASE

  //  Fehler
  *in99 = '0';

endsr;

//============================================================*
//    PRFB1         Prüfen der Eingaben                       *
//============================================================*

begsr prfb1;

  MustWait = bFalse;

  exsr prf20; // Field
  if (*in99 = bTrue);
    leavesr;
  endif;

  exsr prf21; // Operation
  if (*in99 = bTrue);
    leavesr;
  endif;

  exsr prf22; // Argument
  if (*in99 = bTrue);
    leavesr;
  endif;

  exsr prf23; // Search Nbrs
  if (*in99 = bTrue);
    leavesr;
  endif;

  exsr prf24; // Search Type
  if (*in99 = bTrue);
    leavesr;
  endif;

  exsr prf25; // Case-Sens.
  if (*in99 = bTrue);
    leavesr;
  endif;

endsr;

//============================================================*
//    PRF20         Prüfen:  Feldname                         *
//============================================================*

begsr prf20;

  dou ('1');

    if (##Field = '*RECORD');
    //        suchen im ganzen Datensatz
    else;

      clear f_key;
      f_key.F_Field = ##Field;
      chain %kds(f_key) fpeekfld;
      if (not %found());
        //  Fehlermeldung ...
        *in99 = '1';
        clear usr8136;
        usr8136.var1 = ##Field;
        p_sndPgmMg('USR8136': usr8136: sds.pgmName);
        leave;
      else;
        fldl0100 = f_ffd;
      endif;

      if (fldl0100.F1DTyp <> 'A' and    // alpha-num
          // FLDL0100.F1DTyp <> 'G' and // graphic
          fldl0100.F1DTyp <> 'S' and    // Zoned
          fldl0100.F1DTyp <> 'B' and    // Binary
          fldl0100.F1DTyp <> 'P' and    // Packed
          fldl0100.F1DTyp <> 'T' and    // Time
          fldl0100.F1DTyp <> 'L' and    // Date
          fldl0100.F1DTyp <> 'F');       // Float
        *in99 = '1';
        clear usr8129;
        usr8129.var1 = ##Field;
        usr8129.var2 = fldl0100.F1DTyp;
        p_sndPgmMg('USR8129': usr8129: sds.pgmName);
        leave;
      endif;

    endif;

  enddo;

  if (*in99 = *on);
    *in20 = '1';
    *in30 = '1';
  endif;

endsr;

//============================================================*
//    PRF21         Prüfen:  Operation                        *
//============================================================*

begsr prf21;

  dou ('1');

    if (##op <> 'EQ'
        and ##op <> 'NE'
        and ##op <> 'LT'
        and ##op <> 'GT'
        and ##op <> 'LE'
        and ##op <> 'GE'
        and ##op <> 'LIKE'
        and ##op <> 'NLIKE');
      *in99 = '1';
      clear usr8124;
      usr8124.var1 = ##op;
      p_sndPgmMg('USR8124': usr8124: sds.pgmName);
      leave;
    endif;

    if (##Field <> '*RECORD');
      if (##op = 'LIKE'
          or ##op = 'NLIKE');
        //*   F1DTyp        IFNE      'A'  // alpha-num
        //*   F1DTyp        ANDNE     'L'  // Date
        //*   F1DTyp        ANDNE     'T'  // Time
        if (fldl0100.F1DTyp <> 'A' and      // alpha-num
            fldl0100.F1DTyp <> 'L' and      // Date
            fldl0100.F1DTyp <> 'T');         // Time
          *in99 = '1';
          clear usr8135;
          usr8135.var1 = ##op;
          usr8135.var2 = fldl0100.F1DTyp;
          p_sndPgmMg('USR8135': usr8135: sds.pgmName);
          leave;
        endif;
      endif;
    endif;

    if (##Field = '*RECORD'
        and ##op <> 'LIKE'
        and ##op <> 'NLIKE');
      *in99 = '1';
      clear usr8134;
      usr8134.var1 = ##op;    // Operation
      usr8134.var2 = ##Field; // Feld
      p_sndPgmMg('USR8134': usr8134: sds.pgmName);
      leave;
    endif;

  enddo;

  if (*in99 = *on);
    *in21 = '1';
    *in31 = '1';
  endif;

endsr;

//============================================================*
//    PRF22         Prüfen:  Argument                         *
//============================================================*

begsr prf22;

  dou ('1');

    R_Sign = *blanks;
    ##Sign = *blanks;

    if (##Arg = *blanks);
      *in99 = '1';
      p_sndPgmMg('USR8140': usr8140: sds.pgmName);
      leave;
    endif;

    //  Umsetzen in internes Arbeitsfeld ...
    R_Arg30 = %xlate(C_LOWER: C_UPPER: ##Arg);

    select;
    //  Umsetzen des Sonderwertes "*BLANKS" ...
    when (R_Arg30 = '*BLANKS'
       or R_Arg30 = '*BLANK');
      R_Arg30 = *blanks;

    //  Umsetzen des Sonderwertes "*ZEROS" ...
    when (R_Arg30 = '*ZEROS'
       or R_Arg30 = '*ZERO');
      R_Arg30 = *zeros;
    other;
      //  ... aktuellen Wert belassen
      R_Arg30 = ##Arg;
    endsl;

    //  Verarbeiten numerischer Werte ...
    if (f_isNumFld(fldl0100) = bTrue);

      //  ... Vorzeichen, links
      exsr SignLeft;
      //  ... Vorzeichen, rechts
      exsr SignRight;

      //  ... umsetzen *BLANKS in '+' Zeichen
      if (##Sign = *blanks);
        ##Sign = set0003.SET_SignP;
      else;
      //      ... Vorzeichen stehen lassen
      endif;

      //  ... gültige Daten
      //      ... Komma extrahieren
      if (fldl0100.F1DTyp = 'F'); // Float
        if (f_vldFloat(R_Arg30) = bFalse);
          *in99 = '1';
          clear usr8192.var1;
          usr8192.var1 = ##Field;
          p_sndPgmMg('USR8192': usr8192: sds.pgmName);
        endif;
      else;
        exsr SrchPoint;
        exsr ExpandNum;
        exsr ChkNumData;
      endif;

      if (*in99 = *on);
        leave;
      endif;

      //  ... falsches Vorzeichen
      if (##Sign <> set0003.SET_SignM and
          ##Sign <> set0003.SET_SignP);
        *in99 = '1';
        clear usr8141;
        usr8141.var1 = set0003.SET_SignP;
        usr8141.var2 = set0003.SET_SignM;
        p_sndPgmMg('USR8141': usr8141: sds.pgmName);
        leave;
      else;
      //  ... richtiges Vorzeichen
      endif;

    else;
      //  Alpha-numerische Werte ...
      //  ... Vorzeichen
      ##Sign = *blanks;
    endif;

  enddo;

  if (*in99 = *on);
    *in22 = '1';
    *in32 = '1';
  endif;

endsr;

//============================================================*
//    SignLeft      Prüfen extrahieren Vorzeichen links       *
//============================================================*

begsr SignLeft;

  //   Suchen erstes Zeichen <> *BLANKS ...
  x = %check(' ':R_Arg30);
  if (x = *zeros);
  //   Wenn nicht gefunden, dann ist nichts zu tun ...
  else;
    //   ansonsten das Zeichen extrahieren.
    //*   1             SUBST (P) R_Arg30:X     R_Sign
    R_Sign = %subst(R_Arg30: x: 1);
    //   Wenn das extrahierte Zeichen dem '+' oder '-'
    //   Zeichen entspricht, dann die Umsetzung vornehmen ...
    if (R_Sign = set0003.SET_SignM
        or R_Sign = set0003.SET_SignP);
      ##Sign = R_Sign;
      x = x + 1;
      if (x <= 30);
        //*                 SUBST (P) R_Arg30:X     R_Arg30
        R_Arg30 = %subst(R_Arg30: x);
      else;
        R_Arg30 = *blanks;
      endif;
    else;
    //   ... ansonsten ist nix zu tun.
    endif;
  endif;

endsr;

//============================================================*
//    SignRight     Prüfen und umsetzen Vorzeichen rechts     *
//============================================================*

begsr SignRight;

  //   Suchen letztes Zeichen <> *BLANKS ...
  //*   ' '           CHECKR    R_Arg30       X
  x = %checkr(' ': R_Arg30);
  if (x = *zeros);
  //   Wenn nicht gefunden, dann ist nichts zu tun ...
  else;
    //   ansonsten das Zeichen extrahieren.
    //*   1             SUBST (P) R_Arg30:X     R_Sign
    R_Sign = %subst(R_Arg30: x: 1);
    //   Wenn das extrahierte Zeichen dem '+' oder '-'
    //   Zeichen entspricht, dann die Umsetzung vornehmen ...
    if (R_Sign = set0003.SET_SignM
        or R_Sign = set0003.SET_SignP);
      ##Sign = R_Sign;
      x = x - 1;
      if (x > *zeros);
        //*   X             SUBST (P) R_Arg30:1     R_Arg30
        R_Arg30 = %subst(R_Arg30: 1: x);
      else;
        R_Arg30 = *blanks;
      endif;
    else;
    //   ... ansonsten ist nix zu tun.
    endif;
  endif;

endsr;

//============================================================*
//    SrchPoint     Prüfen und umsetzen Komma                 *
//============================================================*

begsr SrchPoint;

  if (f_isNumFld(fldl0100) = bFalse);
  //    keine Aufbereitung für nicht-numerische Daten
  else;

    //  Suchen nach Komma ...
    x = %scan(set0003.SET_Point: R_Arg30);
    if (x = *zeros);
      //   Wenn nicht gefunden, dann Länge +1 ...
      //*   ' '           CHECKR    R_Arg30       X
      x = %checkr(' ': R_Arg30);
      x = x + 1;
    endif;

    //   ansonsten Vorkommastellen ...
    x = x - 1;
    if (x > *zeros);
      //*   X             SUBST (P) R_Arg30:1     R_VorK
      R_VorK = %subst(R_Arg30: 1: x);
    else;
      R_VorK = *blanks;
    endif;
    //   ... und Nachkommastellen extrahieren
    x = x + 2;
    if (x <= 30);
      //*                 SUBST (P) R_Arg30:X     R_NachK
      R_NachK = %subst(R_Arg30: x);
    else;
      R_NachK = *blanks;
    endif;

    //   Anzahl der Nachkommastellen auffüllen ...
    if (fldl0100.f1decp <= 0);
      //   ... keine vorhanden
      R_NachK = *blanks;
    else;
      //   ... auffüllen
      for do_x2 = 1 to %len(R_NachK);
        r_a1 = %subst(R_NachK: fldl0100.f1decp: 1);

        if (r_a1 <> *blanks);
          R_NachK = %subst(R_NachK: 1: fldl0100.f1decp);
          leave;
        endif;

        R_NachK = %trimr(R_NachK) + '0';
      endfor;
    endif;

    //   Ganzzahl zusammenbauen ...
    R_Arg30 = %trimr(R_VorK) + R_NachK;
  endif;

endsr;

//============================================================*
//    PRF23         Prüfen:  Anzahl Datensätze                *
//============================================================*

begsr prf23;

  dou ('1');

    if (##Nbrs = *zeros);
      *in99 = '1';
      p_sndPgmMg('USR8125': '': sds.pgmName);
      leave;
    endif;

  enddo;

  if (*in99 = *on);
    *in23 = '1';
    *in33 = '1';
  endif;

endsr;

//============================================================*
//    PRF24         Prüfen:  Suchtyp                          *
//============================================================*

begsr prf24;

  dou ('1');

    if (##type <> 'N'
        and ##type <> 'R'
        and ##type <> 'U'
        and ##type <> 'P');
      *in99 = '1';
      clear usr8126;
      usr8126.var1 = ##type;
      p_sndPgmMg('USR8126': usr8126: sds.pgmName);
      leave;
    endif;

  enddo;

  if (*in99 = *on);
    *in24 = '1';
    *in34 = '1';
  endif;

endsr;

//============================================================*
//    PRF25         Prüfen:  case-sensitive                   *
//============================================================*

begsr prf25;

  dou ('1');

    if (##case <> bTrue
        and ##case <> bFalse);
      *in99 = '1';
      p_sndPgmMg('USR8133': '': sds.pgmName);
      leave;
    endif;

  enddo;

  if (*in99 = *on);
    *in25 = '1';
    *in35 = '1';
  endif;

endsr;

//============================================================*
//    C_EndPgm      F3/F12 - Programm beenden                 *
//============================================================*

begsr C_EndPgm;

  p_rmvPgmMg(sds.pgmName);

  o_sgID = 'USR8100';

  select;
  when (workstn.aid = k_f3);
    usr8100.var1 = 'F3';
  when (workstn.aid = k_f12);
    usr8100.var1 = 'F12';
  other;
    usr8100.var1 = 'Fxx';
  endsl;

  o_msgDta = usr8100;

endsr;

//============================================================*
//    C_Prompt      F4  - Prompt                              *
//============================================================*

begsr C_Prompt;

  select;
  when (ScnFld = '##FIELD'
     or ##Field = set0008.set_prmt);
    exsr Pmt_Field;
  other;
    p_sndPgmMg('USR8179': '': sds.pgmName);
    *in99 = bTrue;
  endsl;

endsr;

//============================================================*
//    Pmt_Field     Prompt - Field                            *
//============================================================*

begsr Pmt_Field;

  peek37(i_dsp80: i_copyright: YField
        : YMsgID: YMsgDta);

  if (YMsgID = *blanks);
    ##Field = YField;
  else;
    p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
    YMsgID = '';
    YMsgDta = '';
    *in99 = bTrue;
  endif;

endsr;

//============================================================*
//    C_Refresh     F5  - Aktualisieren der Subfile           *
//============================================================*

begsr C_Refresh;

  exsr fill##;

endsr;

//============================================================*
//    C_MoreKeys    F24 - Weitere Tasten                      *
//============================================================*

begsr C_MoreKeys;

  sfbot = sfbot + 1;

endsr;

//============================================================*
//    FILL##        Füllen Bildschirm                         *
//============================================================*

begsr fill##;

  //  Wenn die Datei oder das Member gewechselt hat,
  if (i_qFile <> R_QFile
      or i_member <> R_Member);
    //  ... dann die Bildschirmfelder neu
    //      initialisieren.
    exsr InitField;
    R_QFile = i_qFile;
    R_Member = i_member;
  else;
  //  ... sonst die Bildschirmfelder belassen
  endif;

  clear f_key;
  f_key.F_Field = ##Field;
  chain %kds(f_key) fpeekfld;
  if (not %found());
    clear fldl0100;
  else;
    fldl0100 = f_ffd;
  endif;

  //  Defaultoperationscode einsetzen ...
  if (##op = *blanks);
    ##op = 'EQ';
  else;
  //  Operationscode stehenlasen
  endif;

  //  Sonderwerte einsetzen ...
  select;
  when (##Arg = *blanks);
    ##Arg = '*BLANKS';
  when (##Arg = *zeros);
    ##Arg = '*ZEROS';
  other;
  // ... Umsetzung nicht erforderlich
  endsl;

  if (##Nbrs = 0);
    ##Nbrs = set0002.SET_SNbrs;
  else;
  //  Wert stehenlassen ...
  endif;

endsr;

//============================================================*
//    InitField     Initialisieren der Bildschirmfelder       *
//============================================================*

begsr InitField;

  ##Field = '';
  ##op = '';
  ##Arg = '';
  ##Sign = '';
  $$wldcd = set0002.set_wldcd;
  ##Nbrs = 0;
  ##type = 'N';
  ##case = bFalse;

endsr;

//============================================================*
//    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr SetScreen;

  if (i_dsp80 = '0');
    //   132-Zeichen Anzeige
    *in88 = '0';
    zei = 6;
    zei = zei + 1;
    pos = 26;
  else;
    //    80-Zeichen Anzeige
    *in88 = '1';
    zei = 4;
    zei = zei + 3;
    pos = 7;
  endif;

  //  Prompt-Felder anzeigen ...
  if (set0008.SET_DspPmt = bTrue);
    *in71 = '1';
  else;
    *in71 = '0';
  endif;

endsr;

//============================================================*
//    GetUsrSetg    Ermitteln der Benutzervoreinstellungen    *
//============================================================*

begsr GetUsrSetg;

  //  Attribute der Suchfunktion
  set0002 = f_getUsrSg('*SEARCH'   );

  //  Attribute der Schlüsselaufbeeitung
  set0003 = f_getUsrSg('*ACCESSKEY');

  //  *PROMPT
  set0008 = f_getUsrSg('*PROMPT'   );

endsr;

//============================================================*
//    TrimNum       Nullenunterdrückung für numerische Daten  *
//============================================================*

begsr TrimNum;

  if (f_isNumFld(fldl0100) = bFalse);
  //    keine Aufbereitung für nicht-numerische Daten
  else;

    x = %check('0':R_Arg30);
    if (x > 0);
      R_Arg30 = %subst(R_Arg30: x);
    else;
      // Nur führende Nullen vorhanden
      R_Arg30 = *blanks;
    endif;

    // Argument bestand nur aus führenden Nullen
    // oder nur aus *BLANKS ...
    if (R_Arg30 = *blanks);
      R_Arg30 = '0';
    else;
    // keine Korrektur der Aufbereitung
    // erforderlich
    endif;

  endif;

endsr;

//============================================================*
//    ChkNumData    auf gültige numerische Daten prüfen       *
//============================================================*

begsr ChkNumData;

  if (f_isNumFld(fldl0100) = bFalse);
  //    keine Prüfung für nicht-numerische Daten
  else;

    if (%check(NUMERIC_DIGITS: R_Arg30) > 0);
      *in99 = bTrue;
      clear usr8138.var1;
      usr8138.var1 = ##Field;
      p_sndPgmMg('USR8138': usr8138: sds.pgmName);
    endif;

  endif;

endsr;

//============================================================*
//    ExpandNum     numerische Daten rechtsbündig setzen      *
//============================================================*

begsr ExpandNum;

  if (f_isNumFld(fldl0100) = bFalse);
  //    keine Aufbereitung für nicht-numerische Daten
  else;

    x = %checkr(' ': R_Arg30);
    x = 30 - x;
    if (x > 0);
      R_Arg30 = f_space(x) +  R_Arg30;
    else;
    // ... ist bereits rechtbündig
    endif;

    R_Arg30 = %xlate(' ': '0': R_Arg30);

  endif;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr First;

  // - Öffnen der Dateien
  open peekfld;
  open peek17fm;

  // - Benutzervoreinstellungen
  exsr GetUsrSetg;

  // - Füllen der Bildschirmfelder
  exsr fill##;

  // - Programm initialisieren
  p_rmvPgmMg(sds.pgmName);

  o_sgID = *blanks;
  o_msgDta = *blanks;

  // - Darstellung der Befehlstasten
  sfbot = 1;

  // - Einstellen der Bildschirmauflösung 80/132-Zeichen
  exsr SetScreen;

  // - Copyright
  p_sndPgmMg('USR9999': i_copyright: sds.pgmName);

endsr;

//====================================================*
//  InzSr --  Initialize program                      *
//====================================================*

begsr inzsr;

  if (isInzSr = bTrue);
    leavesr;
  endif;

  isInzSr = bTrue;

  PGMQ = '*';

  peek21_name = f_pgmCallN('PEEK21');
  peek23_name = f_pgmCallN('PEEK23');
  peek37_name = f_pgmCallN('PEEK37');

  peek23(sds.pgmName: '*ALL': 0
        : yFKeys: yNbrOfKeys);
  ScrnFKeys = %subarr(yFKeys: 1);

endsr;

//============================================================*
//  Program error handler                                     *
//============================================================*

dcl-proc errorHandler;
  dcl-pi *n;
    i_condToken    likeds(cee_fc_t) value;
    i_pCommArea    int(10) value;
    o_action       int(10);
    o_newCondToken likeds(cee_fc_t);
  end-pi;

  dump;
  o_action = cee_percolate;

end-proc;

