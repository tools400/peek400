**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 3.1.0                               *
//  Programm : PEEK65                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 29.06.2008  Raddatz                               *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Drucken Datensatz                                            *
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

dcl-f peek65p printer(*ext) usage(*output) usropn oflind(*in60);

dcl-f peekfldl0 keyed usropn rename(fpeekfld: fpeekfldl0) infds(Peek_00_DS) prefix(f_);

dcl-ds Peek_00_DS likeds(infds_t);

dcl-ds hFile04 likeds(hFile_t);

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,D_INFDS
/copy QCOPYLE,SDS
/copy QCOPYLE,OBJD0400
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,SCRNFKEYS
/copy QCOPYLE,CEECNDHDLR
/copy QCOPYLE,USR0005

/define internal_prototype
/copy QCOPYLE,PPEEK65
/undefine internal_prototype

/copy QCOPYLE,PPEEK06
/copy QCOPYLE,PPEEK09
/copy QCOPYLE,PPEEK32

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58
/copy QCOPYLE,PPEEK63

dcl-ds objd0400 likeds(OBJD0400_t) inz;
dcl-ds fldl0100 likeds(fldl0100_t) inz;

dcl-ds IO_Buff;
  IO_BuffFld like(rcdBuf_t);
end-ds;

dcl-s IO_NullMap like(nullMap_t) dim(NULL_MAP_SIZE);

dcl-s YString like(rcdBuf_t);
dcl-s YStrLen like(int4_t);
dcl-s YMsgID char(7);
dcl-s YMsgDta char(512);

dcl-ds YQFile likeds(qObj_t) inz;

//  Arbeitsfelder
dcl-s IsRecord like(bool_t) inz(bFalse);
dcl-s IsCvtChar like(bool_t) inz(bFalse);
dcl-s IsPrinted like(bool_t) inz(bFalse);

dcl-s x like(int4_t);
dcl-s y like(int4_t);
dcl-s textLen like(int4_t);

dcl-s r$text like(fldl0100_t.f1ftxt);

//  Qualifizierte Programmnamen
dcl-s peek06_name like(pgmCallN_t);
dcl-s peek09_name like(pgmCallN_t);
dcl-s peek32_name like(pgmCallN_t);

//  Konstanten
dcl-c cQUOTE '''';

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek65;
  i_rcdNbr    like(rcdNbr_t) const;
  i_file      like(file_t) const;
  i_library   like(lib_t) const;
  i_member    like(mbr_t) const;
  i_rcdFormat like(rcdFmt_t) const;
  o_msgID     like(msgId_t);
  o_msgDta    like(msgDta_t);
end-pi;

dcl-ds f1key_l0 likerec(fpeekfldl0: *key);
//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr First;

//  Drucken Datensatz
if (o_msgID = '');
  exsr PBInit;
  exsr PBSetLL;
  exsr PBReadUp;

  if (IsCvtChar = bTrue);
    exsr PBSeite;
    write error;
  endif;

  if (IsPrinted = bTrue);
    o_msgID  = 'USR8226';
    o_msgDta = '';
  endif;
endif;

if (%open(peek65p));
  close peek65p;
endif;
if (%open(peekfldl0));
  close peekfldl0;
endif;
if (CIO_isOpen(hFile04) = bTrue);
  CIO_close(hFile04);
endif;

return;

//============================================================*
//    PBInit        Initialisieren der Subfile zur Anzeige    *
//                  der nächsten Seite                        *
//============================================================*

begsr PBInit;

  //  Überlaufzeile
  *in60 = bTrue;

  //  Kopfinformationen
  $$File = i_file;
  $$Lib  = i_library;
  $$rrn  = %editc(i_rcdNbr: 'X');
  $$desc = objd0400.O4Text;

  //  Konvertieren nicht darstellbarer Zeichen
  IsCvtChar = bFalse;

endsr;

//============================================================*
//    PBSetLL       Setzen Dateizeiger                        *
//============================================================*

begsr PBSetLL;

  clear f1key_l0;
  f1key_l0.f_fldseq = 0;
  setll %kds(f1key_l0) fpeekfldl0;

endsr;

//============================================================*
//    PBReadUP      Drucken Datenzeilen                       *
//============================================================*

begsr PBReadUp;

  dow ('1');
    read fpeekfldl0;
    if (%eof());
      leave;
    endif;

    //  Feldattribute
    fldl0100 = f_ffd;

    //  nicht erlaubte Feldtypen
    if (f_isNotAlw(fldl0100) = bTrue);
      iter;
    endif;

    //  Ausgeben Feld
    clear item;
    $$fnme = fldl0100.f1fnme;

    x = 1;
    y = 1;
    exsr PBFill;

    dow (x <= YStrLen or y <= textLen);

      exsr PBSeite;

      if (y <= %len(r$text));
        $$text = %subst(r$text : y: %len($$text));
      else;
        $$text = '';
      endif;

      if (x <= %len(YString));
        $$data = %subst(YString: x: %len($$data));
      else;
        $$data = '';
      endif;

      write item;
      x = x + %len($$data);
      y = y + %len($$text);
      $$fnme = '';
      $$text = '';

      IsPrinted = bTrue;
    enddo;

  enddo;

endsr;

//============================================================*
//    PBFill        Füllen Datenzeile                         *
//============================================================*

begsr PBFill;

  //      ... Überschreiben EDTCDE
  if (F_EdtCde <> '');
    fldl0100.f1edtc = F_EdtCde;
  else;
  //       Original EDITCODE verwenden
  endif;

  //      ... eintragen Feldbezeichnung
  if (fldl0100.f1ftxt = '');
    r$text = '-';
  else;
    r$text = fldl0100.f1ftxt;
  endif;

  textLen = %len(%trimr(r$text));

  //  ... NULL erlaubt?
  if (fldl0100.f1nalw = '1' and IO_NullMap(fldl0100.f1seq) = 1);
    YString = f_msgText('TXT0127': '');
    YStrLen = %len(%trimr(YString));
  else;

    monitor;

      //  ... aufbereiten des Feldinhaltes
      peek06(fldl0100: 'FLDL0100': IO_Buff
            : bFalse: bTrue: YString: YStrLen
            : YMsgID: YMsgDta);

      //  ... Konvertieren nicht darstellbarer Zeichen
      peek32(YString: YStrLen: 0
            : YMsgID: YMsgDta);

      *in99 = bFalse;
    on-error;
      *in99 = bTrue;
    endmon;

    if (*in99 = *off);

      if (f_isCharFld(fldl0100) = bTrue and
          YStrLen < %len(YString) - 2);
        %subst(YString: YStrLen+1: 1) = cQUOTE;
        YStrLen = YStrLen + 1;
        %subst(YString: 2) = YString;
        %subst(YString: 1: 1) = cQUOTE;
        YStrLen = YStrLen + 1;
      endif;

      if (IsCvtChar = bFalse);
        if (YMsgID <> *blanks);
          IsCvtChar = bTrue;
          $$error = f_msgText(YMsgID: YMsgDta);
        else;
        // keine Nachricht anstehend
        endif;
      else;
      // Nachricht bereits gesendet
      endif;
    else;
    // Fehler bei Programmaufruf
    endif;

  // Ende: FLDL0100.F1NALW
  endif;

endsr;

//============================================================*
//    PBSeite       Prüfen auf Seitenwechsel                  *
//============================================================*

begsr PBSeite;

  if (*in60 = bTrue);
    write newpage;
    write head1;
    write head2;
    write head3;
    *in60 = bFalse;
  endif;

endsr;

//============================================================*
//    GetObjText    Abrufrufen der Objektbezeichnung          *
//============================================================*

begsr GetObjText;

  YQFile.name = i_file;
  YQFile.lib = i_library;
  monitor;
    peek09(YQFile: objd0400: YMsgID: YMsgDta);
    *in99 = bFalse;
  on-error;
    *in99 = bTrue;
  endmon;

  if (*in99 = '1' or YMsgID <> '');
    clear objd0400;
  endif;
  YMsgID = '';
  YMsgDta = '';

endsr;

//============================================================*
//    ReadRcd       Einlesen des anzuzeigenden Satzes         *
//============================================================*

begsr ReadRcd;

  if (CIO_chainWithRRN(hFile04
                   : i_rcdNbr
                   : bFalse
                   : IO_Buff
                   : IO_NullMap) = bFalse);
    IsRecord = bFalse;
  else;
    IsRecord = bTrue;
  endif;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr First;

  // - Programm initialisieren
  o_msgID = '';
  o_msgDta = '';
  IsPrinted = bFalse;

  // - Öffnen der Datei und Einlesen des zu druckenden Satzes;
  //   die Druckdatei wird erst danach geöffnet, damit ohne
  //   Satz keine Liste entsteht
  if (CIO_open(hFile04
              : i_file
              : i_library
              : i_member
              : i_rcdFormat
              : 'rr,arrseq=Y,nullcap=Y,riofb=Y') = bFalse);
    clear usr0005;
    usr0005.var1 = i_file;
    o_msgID  = 'USR0005';
    o_msgDta = usr0005;
    leavesr;
  endif;

  exsr ReadRcd;
  if (IsRecord = bFalse);
    o_msgID  = 'USR8120';
    o_msgDta = '';
    leavesr;
  endif;

  // - Einlesen Objektbeschreibung
  exsr GetObjText;

  // - Öffnen der Druckdatei und der Feldliste
  f_execute('OVRPRTF +
             FILE(PEEK65P) +
             TOFILE(' +
               %trimr(sds.PgmLib) + '/PEEK65P) +
             SPLFNAME(' +
               %trim(i_file) + ') +
             USRDTA(''' +
               %editc(i_rcdNbr: 'X') + ''') +
             OVRSCOPE(*CALLLVL)'
            : YMsgID: YMsgDta);
  YMsgID = '';
  YMsgDta = '';

  open peek65p;
  open peekfldl0;

endsr;

//====================================================*
//  InzSr --  Initialize program                      *
//====================================================*

begsr inzsr;

  if (isInzSr = bTrue);
    leavesr;
  endif;

  isInzSr = bTrue;

  peek06_name = f_pgmCallN('PEEK06');
  peek09_name = f_pgmCallN('PEEK09');
  peek32_name = f_pgmCallN('PEEK32');

  txt0132 = f_msgText('TXT0132': ''); // Datei:
  txt0133 = f_msgText('TXT0133': ''); // Bibliothek:
  txt0134 = f_msgText('TXT0134': ''); // RRN:
  txt0135 = f_msgText('TXT0135': ''); // Seite:
  txt0136 = f_msgText('TXT0136': ''); // Feldname
  txt0137 = f_msgText('TXT0137': ''); // Feldbeschr.
  txt0138 = f_msgText('TXT0138': ''); // Feldinhalt
  txt0139 = f_msgText('TXT0139': ''); // Text:

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

