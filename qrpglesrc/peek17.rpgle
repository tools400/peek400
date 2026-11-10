**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - Erfassen der Suchkriterien                   *
      //%EMETADATA                                                     *
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
/copy 'qcopyle/h_spec.rpgleinc'
/copy 'qcopyle/copyright.rpgleinc'

dcl-f peek17fm workstn(*ext) usage(*input: *output) usropn infds(workstn);

dcl-f peekFld keyed usropn infds(peek_01_ds) prefix(f_);

dcl-ds workstn likeds(workstn_t);

dcl-ds peek_01_ds likeds(infds_t);


/copy 'qcopyle/d_vardef.rpgleinc'
/copy 'qcopyle/d_workstn.rpgleinc'
/copy 'qcopyle/shortcmd_d.rpgleinc'
/copy 'qcopyle/sds.rpgleinc'
/copy 'qcopyle/fldl0100.rpgleinc'
/copy 'qcopyle/scrnfkeys.rpgleinc'
/copy 'qcopyle/d_infds.rpgleinc'

/define internal_prototype
/copy 'qcopyle/ppeek17.rpgleinc'
/undefine internal_prototype

/copy 'qcopyle/set0002.rpgleinc'
/copy 'qcopyle/set0003.rpgleinc'
/copy 'qcopyle/set0008.rpgleinc'

/copy 'qcopyle/usr8100.rpgleinc'
/copy 'qcopyle/usr8108.rpgleinc'
/copy 'qcopyle/usr8124.rpgleinc'
/copy 'qcopyle/usr8126.rpgleinc'
/copy 'qcopyle/usr8129.rpgleinc'
/copy 'qcopyle/usr8134.rpgleinc'
/copy 'qcopyle/usr8135.rpgleinc'
/copy 'qcopyle/usr8136.rpgleinc'
/copy 'qcopyle/usr8138.rpgleinc'
/copy 'qcopyle/usr8140.rpgleinc'
/copy 'qcopyle/usr8141.rpgleinc'
/copy 'qcopyle/usr8142.rpgleinc'
/copy 'qcopyle/usr8192.rpgleinc'

dcl-ds set0002 likeds(set0002_t) inz;
dcl-ds set0003 likeds(set0003_t) inz;
dcl-ds set0008 likeds(set0008_t) inz;

dcl-ds fldl0100 likeds(fldl0100_t) inz;

dcl-s yFKeys char(18) dim(32);
dcl-s yNbrOfKeys like(int4_t);
dcl-s yMsgID char(7);
dcl-s yMsgDta char(512);

dcl-s yPgmCmd char(10);
dcl-s yCmdDta like(pgmCmdDt_t);

dcl-s yField char(10);

dcl-s sfBot like(int4_t);
dcl-c NBR_F_KEYS 2;

dcl-s mustWait char(1) inz(bFalse);

dcl-s x like(int4_t) inz;

dcl-s r_sign like(##sign);
dcl-s r_arg30 like(##arg);
dcl-s r_qFile like(i_qFile);
dcl-s r_member like(i_member);
dcl-s r_vorK like(##arg);
dcl-s r_nachK like(##arg);
dcl-s r_a1 char(1);
dcl-s r_field like(##field);

dcl-s peek21_name like(pgmCallN_t) inz;
dcl-s peek23_name like(pgmCallN_t) inz;
dcl-s peek37_name like(pgmCallN_t) inz;

/copy 'qcopyle/ppeek21.rpgleinc'
/copy 'qcopyle/ppeek23.rpgleinc'
/copy 'qcopyle/ppeek37.rpgleinc'

/copy 'qcopyle/ppeek53.rpgleinc'
/copy 'qcopyle/ppeek58.rpgleinc'

/copy 'qcopyle/ceecndhdlr.rpgleinc'

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

exsr first;

dow ('1');

  //  Nachrichten anzeigen
  *in89 = '0';
  write msgCtl;

  //  Anzeigen der Befehlstasten
  select;
  when ((sfBot = 2) and
     (yNbrOfKeys > NBR_F_KEYS * (sfBot - 1)));
    write pbbot#2;
  when ((sfBot = 3) and
     (yNbrOfKeys > NBR_F_KEYS * (sfBot - 1)));
    write pbbot#3;
  when ((sfBot = 4) and
     (yNbrOfKeys > NBR_F_KEYS * (sfBot - 1)));
    write pbbot#4;
  when ((sfBot = 5) and
     (yNbrOfKeys > NBR_F_KEYS * (sfBot - 1)));
    write pbbot#5;
  when ((sfBot = 6) and
     (yNbrOfKeys > NBR_F_KEYS * (sfBot - 1)));
    write pbbot#6;
  other;
    write pbbot#1;
    sfBot = 1;
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
        : yPgmCmd: yCmdDta: yMsgID: yMsgDta);
  if (yMsgID <> *blanks);
    p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
    yMsgID = '';
    yMsgDta = '';
    iter;
  endif;

  //  Abfragen der Programmbefehle
  select;
  //  F3  - Ende
  when (yPgmCmd = '*EXIT');
    exsr c_endPgm;
    leave;

  //  F4  - Prompt
  when (yPgmCmd = '*PROMPT');
    exsr c_prompt;
    iter;

  //  F5  - Aktualisieren
  when (yPgmCmd = '*REFRESH');
    exsr c_refresh;
    iter;

  //  F12 - Ende
  when (yPgmCmd = '*CANCEL');
    exsr c_endPgm;
    leave;

  //  F24 - Weitere Tasten
  when (yPgmCmd = '*MOREKEYS');
    exsr c_moreKeys;

  //  Datenfreigabe
  when (yPgmCmd = '*ENTER');
    exsr c_enter;
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

close peekFld;
close peek17fm;

return;

//============================================================*
//    c_enter       "Datenfreigabetaste"                      *
//============================================================*

begsr c_enter;

  dou ('1');

    r_field = ##field;

    //  Prompt?
    //  ... ##field
    if (%trim(##field ) = set0008.set_prmt);
      exsr c_prompt;
      if (*in99 = bTrue);
        leave;
      else;
      //  ...?
      endif;
    endif;

    exsr prfB1;

    if (##field <> r_field);
      mustWait = bTrue;
    endif;

    if (mustWait = bTrue);
      *in99 = '1';
    else;
    //  Wert belassen ...
    endif;

  enddo;

  if (*in99 = *off);
    o_field = ##field;
    o_operation = ##op;
    o_argument = r_arg30;
    o_sign = ##sign;
    o_srchNbrs = ##nbrs;

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

begsr prfB1;

  mustWait = bFalse;

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

    if (##field = '*RECORD');
    //        suchen im ganzen Datensatz
    else;

      clear f_key;
      f_key.f_field = ##field;
      chain %kds(f_key) fpeekfld;
      if (not %found());
        //  Fehlermeldung ...
        *in99 = '1';
        clear usr8136;
        usr8136.var1 = ##field;
        p_sndPgmMg('USR8136': usr8136: sds.pgmName);
        leave;
      else;
        fldl0100 = f_ffd;
      endif;

      if (fldl0100.f1DTyp <> 'A' and    // alpha-num
          // FLDL0100.f1DTyp <> 'G' and // graphic
          fldl0100.f1DTyp <> 'S' and    // Zoned
          fldl0100.f1DTyp <> 'B' and    // Binary
          fldl0100.f1DTyp <> 'P' and    // Packed
          fldl0100.f1DTyp <> 'T' and    // Time
          fldl0100.f1DTyp <> 'L' and    // Date
          fldl0100.f1DTyp <> 'F');       // Float
        *in99 = '1';
        clear usr8129;
        usr8129.var1 = ##field;
        usr8129.var2 = fldl0100.f1DTyp;
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

    if (##field <> '*RECORD');
      if (##op = 'LIKE'
          or ##op = 'NLIKE');
        //*   f1DTyp        IFNE      'A'  // alpha-num
        //*   f1DTyp        ANDNE     'L'  // Date
        //*   f1DTyp        ANDNE     'T'  // Time
        if (fldl0100.f1DTyp <> 'A' and      // alpha-num
            fldl0100.f1DTyp <> 'L' and      // Date
            fldl0100.f1DTyp <> 'T');         // Time
          *in99 = '1';
          clear usr8135;
          usr8135.var1 = ##op;
          usr8135.var2 = fldl0100.f1DTyp;
          p_sndPgmMg('USR8135': usr8135: sds.pgmName);
          leave;
        endif;
      endif;
    endif;

    if (##field = '*RECORD'
        and ##op <> 'LIKE'
        and ##op <> 'NLIKE');
      *in99 = '1';
      clear usr8134;
      usr8134.var1 = ##op;    // Operation
      usr8134.var2 = ##field; // Feld
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

    r_sign = *blanks;
    ##sign = *blanks;

    if (##arg = *blanks);
      *in99 = '1';
      p_sndPgmMg('USR8140': usr8140: sds.pgmName);
      leave;
    endif;

    //  Umsetzen in internes Arbeitsfeld ...
    r_arg30 = %xlate(C_LOWER: C_UPPER: ##arg);

    select;
    //  Umsetzen des Sonderwertes "*BLANKS" ...
    when (r_arg30 = '*BLANKS'
       or r_arg30 = '*BLANK');
      r_arg30 = *blanks;

    //  Umsetzen des Sonderwertes "*ZEROS" ...
    when (r_arg30 = '*ZEROS'
       or r_arg30 = '*ZERO');
      r_arg30 = *zeros;
    other;
      //  ... aktuellen Wert belassen
      r_arg30 = ##arg;
    endsl;

    //  Verarbeiten numerischer Werte ...
    if (f_isNumFld(fldl0100) = bTrue);

      //  ... Vorzeichen, links
      exsr signLeft;
      //  ... Vorzeichen, rechts
      exsr signRight;

      //  ... umsetzen *BLANKS in '+' Zeichen
      if (##sign = *blanks);
        ##sign = set0003.set_signP;
      else;
      //      ... Vorzeichen stehen lassen
      endif;

      //  ... gültige Daten
      //      ... Komma extrahieren
      if (fldl0100.f1DTyp = 'F'); // Float
        if (f_vldFloat(r_arg30) = bFalse);
          *in99 = '1';
          clear usr8192.var1;
          usr8192.var1 = ##field;
          p_sndPgmMg('USR8192': usr8192: sds.pgmName);
        endif;
      else;
        exsr srchPoint;
        exsr expandNum;
        exsr chkNumData;
      endif;

      if (*in99 = *on);
        leave;
      endif;

      //  ... falsches Vorzeichen
      if (##sign <> set0003.set_signM and
          ##sign <> set0003.set_signP);
        *in99 = '1';
        clear usr8141;
        usr8141.var1 = set0003.set_signP;
        usr8141.var2 = set0003.set_signM;
        p_sndPgmMg('USR8141': usr8141: sds.pgmName);
        leave;
      else;
      //  ... richtiges Vorzeichen
      endif;

    else;
      //  Alpha-numerische Werte ...
      //  ... Vorzeichen
      ##sign = *blanks;
    endif;

  enddo;

  if (*in99 = *on);
    *in22 = '1';
    *in32 = '1';
  endif;

endsr;

//============================================================*
//    signLeft      Prüfen extrahieren Vorzeichen links       *
//============================================================*

begsr signLeft;

  //   Suchen erstes Zeichen <> *BLANKS ...
  x = %check(' ':r_arg30);
  if (x = *zeros);
  //   Wenn nicht gefunden, dann ist nichts zu tun ...
  else;
    //   ansonsten das Zeichen extrahieren.
    //*   1             SUBST (P) r_arg30:X     r_sign
    r_sign = %subst(r_arg30: x: 1);
    //   Wenn das extrahierte Zeichen dem '+' oder '-'
    //   Zeichen entspricht, dann die Umsetzung vornehmen ...
    if (r_sign = set0003.set_signM
        or r_sign = set0003.set_signP);
      ##sign = r_sign;
      x = x + 1;
      if (x <= 30);
        //*                 SUBST (P) r_arg30:X     r_arg30
        r_arg30 = %subst(r_arg30: x);
      else;
        r_arg30 = *blanks;
      endif;
    else;
    //   ... ansonsten ist nix zu tun.
    endif;
  endif;

endsr;

//============================================================*
//    signRight     Prüfen und umsetzen Vorzeichen rechts     *
//============================================================*

begsr signRight;

  //   Suchen letztes Zeichen <> *BLANKS ...
  //*   ' '           CHECKR    r_arg30       X
  x = %checkr(' ': r_arg30);
  if (x = *zeros);
  //   Wenn nicht gefunden, dann ist nichts zu tun ...
  else;
    //   ansonsten das Zeichen extrahieren.
    //*   1             SUBST (P) r_arg30:X     r_sign
    r_sign = %subst(r_arg30: x: 1);
    //   Wenn das extrahierte Zeichen dem '+' oder '-'
    //   Zeichen entspricht, dann die Umsetzung vornehmen ...
    if (r_sign = set0003.set_signM
        or r_sign = set0003.set_signP);
      ##sign = r_sign;
      x = x - 1;
      if (x > *zeros);
        //*   X             SUBST (P) r_arg30:1     r_arg30
        r_arg30 = %subst(r_arg30: 1: x);
      else;
        r_arg30 = *blanks;
      endif;
    else;
    //   ... ansonsten ist nix zu tun.
    endif;
  endif;

endsr;

//============================================================*
//    srchPoint     Prüfen und umsetzen Komma                 *
//============================================================*

begsr srchPoint;

  if (f_isNumFld(fldl0100) = bFalse);
  //    keine Aufbereitung für nicht-numerische Daten
  else;

    //  Suchen nach Komma ...
    x = %scan(set0003.set_point: r_arg30);
    if (x = *zeros);
      //   Wenn nicht gefunden, dann Länge +1 ...
      //*   ' '           CHECKR    r_arg30       X
      x = %checkr(' ': r_arg30);
      x = x + 1;
    endif;

    //   ansonsten Vorkommastellen ...
    x = x - 1;
    if (x > *zeros);
      //*   X             SUBST (P) r_arg30:1     r_vorK
      r_vorK = %subst(r_arg30: 1: x);
    else;
      r_vorK = *blanks;
    endif;
    //   ... und Nachkommastellen extrahieren
    x = x + 2;
    if (x <= 30);
      //*                 SUBST (P) r_arg30:X     r_nachK
      r_nachK = %subst(r_arg30: x);
    else;
      r_nachK = *blanks;
    endif;

    //   Anzahl der Nachkommastellen auffüllen ...
    if (fldl0100.f1DecP <= 0);
      //   ... keine vorhanden
      r_nachK = *blanks;
    else;
      //   ... auffüllen
      for do_x2 = 1 to %len(r_nachK);
        r_a1 = %subst(r_nachK: fldl0100.f1DecP: 1);

        if (r_a1 <> *blanks);
          r_nachK = %subst(r_nachK: 1: fldl0100.f1DecP);
          leave;
        endif;

        r_nachK = %trimr(r_nachK) + '0';
      endfor;
    endif;

    //   Ganzzahl zusammenbauen ...
    r_arg30 = %trimr(r_vorK) + r_nachK;
  endif;

endsr;

//============================================================*
//    PRF23         Prüfen:  Anzahl Datensätze                *
//============================================================*

begsr prf23;

  dou ('1');

    if (##nbrs = *zeros);
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
//    c_endPgm      F3/F12 - Programm beenden                 *
//============================================================*

begsr c_endPgm;

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
//    c_prompt      F4  - Prompt                              *
//============================================================*

begsr c_prompt;

  select;
  when (scnFld = '##FIELD'
     or ##field = set0008.set_prmt);
    exsr pmt_field;
  other;
    p_sndPgmMg('USR8179': '': sds.pgmName);
    *in99 = bTrue;
  endsl;

endsr;

//============================================================*
//    pmt_field     Prompt - Field                            *
//============================================================*

begsr pmt_field;

  peek37(i_dsp80: i_copyright: yField
        : yMsgID: yMsgDta);

  if (yMsgID = *blanks);
    ##field = yField;
  else;
    p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
    yMsgID = '';
    yMsgDta = '';
    *in99 = bTrue;
  endif;

endsr;

//============================================================*
//    c_refresh     F5  - Aktualisieren der Subfile           *
//============================================================*

begsr c_refresh;

  exsr fill##;

endsr;

//============================================================*
//    c_moreKeys    F24 - Weitere Tasten                      *
//============================================================*

begsr c_moreKeys;

  sfBot = sfBot + 1;

endsr;

//============================================================*
//    FILL##        Füllen Bildschirm                         *
//============================================================*

begsr fill##;

  //  Wenn die Datei oder das Member gewechselt hat,
  if (i_qFile <> r_qFile
      or i_member <> r_member);
    //  ... dann die Bildschirmfelder neu
    //      initialisieren.
    exsr initField;
    r_qFile = i_qFile;
    r_member = i_member;
  else;
  //  ... sonst die Bildschirmfelder belassen
  endif;

  clear f_key;
  f_key.f_field = ##field;
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
  when (##arg = *blanks);
    ##arg = '*BLANKS';
  when (##arg = *zeros);
    ##arg = '*ZEROS';
  other;
  // ... Umsetzung nicht erforderlich
  endsl;

  if (##nbrs = 0);
    ##nbrs = set0002.set_sNbrs;
  else;
  //  Wert stehenlassen ...
  endif;

endsr;

//============================================================*
//    initField     Initialisieren der Bildschirmfelder       *
//============================================================*

begsr initField;

  ##field = '';
  ##op = '';
  ##arg = '';
  ##sign = '';
  $$wldcd = set0002.set_wldCd;
  ##nbrs = 0;
  ##type = 'N';
  ##case = bFalse;

endsr;

//============================================================*
//    setScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr setScreen;

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
  if (set0008.set_dspPmt = bTrue);
    *in71 = '1';
  else;
    *in71 = '0';
  endif;

endsr;

//============================================================*
//    getUsrSetg    Ermitteln der Benutzervoreinstellungen    *
//============================================================*

begsr getUsrSetg;

  //  Attribute der Suchfunktion
  set0002 = f_getUsrSg('*SEARCH'   );

  //  Attribute der Schlüsselaufbeeitung
  set0003 = f_getUsrSg('*ACCESSKEY');

  //  *PROMPT
  set0008 = f_getUsrSg('*PROMPT'   );

endsr;

//============================================================*
//    trimNum       Nullenunterdrückung für numerische Daten  *
//============================================================*

begsr trimNum;

  if (f_isNumFld(fldl0100) = bFalse);
  //    keine Aufbereitung für nicht-numerische Daten
  else;

    x = %check('0':r_arg30);
    if (x > 0);
      r_arg30 = %subst(r_arg30: x);
    else;
      // Nur führende Nullen vorhanden
      r_arg30 = *blanks;
    endif;

    // Argument bestand nur aus führenden Nullen
    // oder nur aus *BLANKS ...
    if (r_arg30 = *blanks);
      r_arg30 = '0';
    else;
    // keine Korrektur der Aufbereitung
    // erforderlich
    endif;

  endif;

endsr;

//============================================================*
//    chkNumData    auf gültige numerische Daten prüfen       *
//============================================================*

begsr chkNumData;

  if (f_isNumFld(fldl0100) = bFalse);
  //    keine Prüfung für nicht-numerische Daten
  else;

    if (%check(NUMERIC_DIGITS: r_arg30) > 0);
      *in99 = bTrue;
      clear usr8138.var1;
      usr8138.var1 = ##field;
      p_sndPgmMg('USR8138': usr8138: sds.pgmName);
    endif;

  endif;

endsr;

//============================================================*
//    expandNum     numerische Daten rechtsbündig setzen      *
//============================================================*

begsr expandNum;

  if (f_isNumFld(fldl0100) = bFalse);
  //    keine Aufbereitung für nicht-numerische Daten
  else;

    x = %checkr(' ': r_arg30);
    x = 30 - x;
    if (x > 0);
      r_arg30 = f_space(x) +  r_arg30;
    else;
    // ... ist bereits rechtbündig
    endif;

    r_arg30 = %xlate(' ': '0': r_arg30);

  endif;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  // - Öffnen der Dateien
  open peekFld;
  open peek17fm;

  // - Benutzervoreinstellungen
  exsr getUsrSetg;

  // - Füllen der Bildschirmfelder
  exsr fill##;

  // - Programm initialisieren
  p_rmvPgmMg(sds.pgmName);

  o_sgID = *blanks;
  o_msgDta = *blanks;

  // - Darstellung der Befehlstasten
  sfBot = 1;

  // - Einstellen der Bildschirmauflösung 80/132-Zeichen
  exsr setScreen;

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

  pgmQ = '*';

  peek21_name = f_pgmCallN('PEEK21');
  peek23_name = f_pgmCallN('PEEK23');
  peek37_name = f_pgmCallN('PEEK37');

  peek23(sds.pgmName: '*ALL': 0
        : yFKeys: yNbrOfKeys);
  scrnFKeys = %subarr(yFKeys: 1);

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

