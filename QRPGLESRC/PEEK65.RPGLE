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

dcl-f peekfldl0 keyed usropn rename(fpeekfld: fpeekfldl0) infds(peek_00_ds) prefix(f_);

dcl-ds peek_00_ds likeds(infds_t);

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

dcl-ds objd0400 likeds(objd0400_t) inz;
dcl-ds fldl0100 likeds(fldl0100_t) inz;

dcl-ds io_buff;
  io_buffFld like(rcdBuf_t);
end-ds;

dcl-s io_nullMap like(nullMap_t) dim(NULL_MAP_SIZE);

dcl-s yString like(rcdBuf_t);
dcl-s yStrLen like(int4_t);
dcl-s yMsgID char(7);
dcl-s yMsgDta char(512);

dcl-ds yQFile likeds(qObj_t) inz;

//  Arbeitsfelder
dcl-s isRecord like(bool_t) inz(bFalse);
dcl-s isCvtChar like(bool_t) inz(bFalse);
dcl-s isPrinted like(bool_t) inz(bFalse);

dcl-s x like(int4_t);
dcl-s y like(int4_t);
dcl-s textLen like(int4_t);

dcl-s r$text like(fldl0100_t.f1FTxt);

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

dcl-ds f1Key_l0 likerec(fpeekfldl0: *key);
//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr first;

//  Drucken Datensatz
if (o_msgID = '');
  exsr pbInit;
  exsr pbSetLL;
  exsr pbReadUp;

  if (isCvtChar = bTrue);
    exsr pbSeite;
    write error;
  endif;

  if (isPrinted = bTrue);
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
if (cio_isOpen(hFile04) = bTrue);
  cio_close(hFile04);
endif;

return;

//============================================================*
//    pbInit        Initialisieren der Subfile zur Anzeige    *
//                  der nächsten Seite                        *
//============================================================*

begsr pbInit;

  //  Überlaufzeile
  *in60 = bTrue;

  //  Kopfinformationen
  $$file = i_file;
  $$lib  = i_library;
  $$rrn  = %editc(i_rcdNbr: 'X');
  $$desc = objd0400.o4Text;

  //  Konvertieren nicht darstellbarer Zeichen
  isCvtChar = bFalse;

endsr;

//============================================================*
//    pbSetLL       Setzen Dateizeiger                        *
//============================================================*

begsr pbSetLL;

  clear f1Key_l0;
  f1Key_l0.f_fldSeq = 0;
  setll %kds(f1Key_l0) fpeekfldl0;

endsr;

//============================================================*
//    pbReadUp      Drucken Datenzeilen                       *
//============================================================*

begsr pbReadUp;

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
    $$fNme = fldl0100.f1FNme;

    x = 1;
    y = 1;
    exsr pbFill;

    dow (x <= yStrLen or y <= textLen);

      exsr pbSeite;

      if (y <= %len(r$text));
        $$text = %subst(r$text : y: %len($$text));
      else;
        $$text = '';
      endif;

      if (x <= %len(yString));
        $$data = %subst(yString: x: %len($$data));
      else;
        $$data = '';
      endif;

      write item;
      x = x + %len($$data);
      y = y + %len($$text);
      $$fNme = '';
      $$text = '';

      isPrinted = bTrue;
    enddo;

  enddo;

endsr;

//============================================================*
//    pbFill        Füllen Datenzeile                         *
//============================================================*

begsr pbFill;

  //      ... Überschreiben EDTCDE
  if (f_edtCde <> '');
    fldl0100.f1EdtC = f_edtCde;
  else;
  //       Original EDITCODE verwenden
  endif;

  //      ... eintragen Feldbezeichnung
  if (fldl0100.f1FTxt = '');
    r$text = '-';
  else;
    r$text = fldl0100.f1FTxt;
  endif;

  textLen = %len(%trimr(r$text));

  //  ... NULL erlaubt?
  if (fldl0100.f1nalw = '1' and io_nullMap(fldl0100.f1seq) = 1);
    yString = f_msgText('TXT0127': '');
    yStrLen = %len(%trimr(yString));
  else;

    monitor;

      //  ... aufbereiten des Feldinhaltes
      peek06(fldl0100: 'FLDL0100': io_buff
            : bFalse: bTrue: yString: yStrLen
            : yMsgID: yMsgDta);

      //  ... Konvertieren nicht darstellbarer Zeichen
      peek32(yString: yStrLen: 0
            : yMsgID: yMsgDta);

      *in99 = bFalse;
    on-error;
      *in99 = bTrue;
    endmon;

    if (*in99 = *off);

      if (f_isCharFld(fldl0100) = bTrue and
          yStrLen < %len(yString) - 2);
        %subst(yString: yStrLen+1: 1) = cQUOTE;
        yStrLen = yStrLen + 1;
        %subst(yString: 2) = yString;
        %subst(yString: 1: 1) = cQUOTE;
        yStrLen = yStrLen + 1;
      endif;

      if (isCvtChar = bFalse);
        if (yMsgID <> *blanks);
          isCvtChar = bTrue;
          $$error = f_msgText(yMsgID: yMsgDta);
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
//    pbSeite       Prüfen auf Seitenwechsel                  *
//============================================================*

begsr pbSeite;

  if (*in60 = bTrue);
    write newpage;
    write head1;
    write head2;
    write head3;
    *in60 = bFalse;
  endif;

endsr;

//============================================================*
//    getObjText    Abrufrufen der Objektbezeichnung          *
//============================================================*

begsr getObjText;

  yQFile.name = i_file;
  yQFile.lib = i_library;
  monitor;
    peek09(yQFile: objd0400: yMsgID: yMsgDta);
    *in99 = bFalse;
  on-error;
    *in99 = bTrue;
  endmon;

  if (*in99 = '1' or yMsgID <> '');
    clear objd0400;
  endif;
  yMsgID = '';
  yMsgDta = '';

endsr;

//============================================================*
//    readRcd       Einlesen des anzuzeigenden Satzes         *
//============================================================*

begsr readRcd;

  if (cio_chainWithRRN(hFile04
                   : i_rcdNbr
                   : bFalse
                   : io_buff
                   : io_nullMap) = bFalse);
    isRecord = bFalse;
  else;
    isRecord = bTrue;
  endif;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  // - Programm initialisieren
  o_msgID = '';
  o_msgDta = '';
  isPrinted = bFalse;

  // - Öffnen der Datei und Einlesen des zu druckenden Satzes;
  //   die Druckdatei wird erst danach geöffnet, damit ohne
  //   Satz keine Liste entsteht
  if (cio_open(hFile04
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

  exsr readRcd;
  if (isRecord = bFalse);
    o_msgID  = 'USR8120';
    o_msgDta = '';
    leavesr;
  endif;

  // - Einlesen Objektbeschreibung
  exsr getObjText;

  // - Öffnen der Druckdatei und der Feldliste
  f_execute('OVRPRTF +
             FILE(PEEK65P) +
             TOFILE(' +
               %trimr(sds.pgmLib) + '/PEEK65P) +
             SPLFNAME(' +
               %trim(i_file) + ') +
             USRDTA(''' +
               %editc(i_rcdNbr: 'X') + ''') +
             OVRSCOPE(*CALLLVL)'
            : yMsgID: yMsgDta);
  yMsgID = '';
  yMsgDta = '';

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

