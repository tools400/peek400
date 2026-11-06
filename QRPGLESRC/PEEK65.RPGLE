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

dcl-ds hfile04 likeds(hfile_t);

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
  io_bufffld like(rcdbuf_t);
end-ds;

dcl-s io_nullmap like(nullmap_t) dim(NULL_MAP_SIZE);

dcl-s ystring like(rcdbuf_t);
dcl-s ystrlen like(int4_t);
dcl-s ymsgid char(7);
dcl-s ymsgdta char(512);

dcl-ds yqfile likeds(qobj_t) inz;

//  Arbeitsfelder
dcl-s isrecord like(bool_t) inz(bFalse);
dcl-s iscvtchar like(bool_t) inz(bFalse);
dcl-s isprinted like(bool_t) inz(bFalse);

dcl-s x like(int4_t);
dcl-s y like(int4_t);
dcl-s textlen like(int4_t);

dcl-s r$text like(fldl0100_t.f1ftxt);

//  Qualifizierte Programmnamen
dcl-s peek06_name like(pgmcalln_t);
dcl-s peek09_name like(pgmcalln_t);
dcl-s peek32_name like(pgmcalln_t);

//  Konstanten
dcl-c cquote '''';

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek65;
  i_rcdNbr    like(rcdNbr_t) const;
  i_file      like(file_t) const;
  i_library   like(lib_t) const;
  i_member    like(mbr_t) const;
  i_rcdformat like(rcdfmt_t) const;
  o_msgid     like(msgid_t);
  o_msgdta    like(msgdta_t);
end-pi;

dcl-ds f1key_l0 likerec(fpeekfldl0: *key);
//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr first;

//  Drucken Datensatz
if (o_msgid = '');
  exsr pbinit;
  exsr pbsetll;
  exsr pbreadup;

  if (iscvtchar = bTrue);
    exsr pbseite;
    write error;
  endif;

  if (isprinted = bTrue);
    o_msgid  = 'USR8226';
    o_msgdta = '';
  endif;
endif;

if (%open(peek65p));
  close peek65p;
endif;
if (%open(peekfldl0));
  close peekfldl0;
endif;
if (cio_isopen(hfile04) = bTrue);
  cio_close(hfile04);
endif;

return;

//============================================================*
//    PBInit        Initialisieren der Subfile zur Anzeige    *
//                  der nächsten Seite                        *
//============================================================*

begsr pbinit;

  //  Überlaufzeile
  *in60 = bTrue;

  //  Kopfinformationen
  $$file = i_file;
  $$lib  = i_library;
  $$rrn  = %editc(i_rcdNbr: 'X');
  $$desc = objd0400.o4text;

  //  Konvertieren nicht darstellbarer Zeichen
  iscvtchar = bFalse;

endsr;

//============================================================*
//    PBSetLL       Setzen Dateizeiger                        *
//============================================================*

begsr pbsetll;

  clear f1key_l0;
  f1key_l0.f_fldseq = 0;
  setll %kds(f1key_l0) fpeekfldl0;

endsr;

//============================================================*
//    PBReadUP      Drucken Datenzeilen                       *
//============================================================*

begsr pbreadup;

  dow ('1');
    read fpeekfldl0;
    if (%eof());
      leave;
    endif;

    //  Feldattribute
    fldl0100 = f_ffd;

    //  nicht erlaubte Feldtypen
    if (f_isnotalw(fldl0100) = bTrue);
      iter;
    endif;

    //  Ausgeben Feld
    clear item;
    $$fnme = fldl0100.f1fnme;

    x = 1;
    y = 1;
    exsr pbfill;

    dow (x <= ystrlen or y <= textlen);

      exsr pbseite;

      if (y <= %len(r$text));
        $$text = %subst(r$text : y: %len($$text));
      else;
        $$text = '';
      endif;

      if (x <= %len(ystring));
        $$data = %subst(ystring: x: %len($$data));
      else;
        $$data = '';
      endif;

      write item;
      x = x + %len($$data);
      y = y + %len($$text);
      $$fnme = '';
      $$text = '';

      isprinted = bTrue;
    enddo;

  enddo;

endsr;

//============================================================*
//    PBFill        Füllen Datenzeile                         *
//============================================================*

begsr pbfill;

  //      ... Überschreiben EDTCDE
  if (f_edtcde <> '');
    fldl0100.f1edtc = f_edtcde;
  else;
  //       Original EDITCODE verwenden
  endif;

  //      ... eintragen Feldbezeichnung
  if (fldl0100.f1ftxt = '');
    r$text = '-';
  else;
    r$text = fldl0100.f1ftxt;
  endif;

  textlen = %len(%trimr(r$text));

  //  ... NULL erlaubt?
  if (fldl0100.f1nalw = '1' and io_nullmap(fldl0100.f1seq) = 1);
    ystring = f_msgtext('TXT0127': '');
    ystrlen = %len(%trimr(ystring));
  else;

    monitor;

      //  ... aufbereiten des Feldinhaltes
      peek06(fldl0100: 'FLDL0100': io_buff
            : bFalse: bTrue: ystring: ystrlen
            : ymsgid: ymsgdta);

      //  ... Konvertieren nicht darstellbarer Zeichen
      peek32(ystring: ystrlen: 0
            : ymsgid: ymsgdta);

      *in99 = bFalse;
    on-error;
      *in99 = bTrue;
    endmon;

    if (*in99 = *off);

      if (f_ischarfld(fldl0100) = bTrue and
          ystrlen < %len(ystring) - 2);
        %subst(ystring: ystrlen+1: 1) = cquote;
        ystrlen = ystrlen + 1;
        %subst(ystring: 2) = ystring;
        %subst(ystring: 1: 1) = cquote;
        ystrlen = ystrlen + 1;
      endif;

      if (iscvtchar = bFalse);
        if (ymsgid <> *blanks);
          iscvtchar = bTrue;
          $$error = f_msgtext(ymsgid: ymsgdta);
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

begsr pbseite;

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

begsr getobjtext;

  yqfile.name = i_file;
  yqfile.lib = i_library;
  monitor;
    peek09(yqfile: objd0400: ymsgid: ymsgdta);
    *in99 = bFalse;
  on-error;
    *in99 = bTrue;
  endmon;

  if (*in99 = '1' or ymsgid <> '');
    clear objd0400;
  endif;
  ymsgid = '';
  ymsgdta = '';

endsr;

//============================================================*
//    ReadRcd       Einlesen des anzuzeigenden Satzes         *
//============================================================*

begsr readrcd;

  if (cio_chainwithrrn(hfile04
                   : i_rcdNbr
                   : bFalse
                   : io_buff
                   : io_nullmap) = bFalse);
    isrecord = bFalse;
  else;
    isrecord = bTrue;
  endif;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  // - Programm initialisieren
  o_msgid = '';
  o_msgdta = '';
  isprinted = bFalse;

  // - Öffnen der Datei und Einlesen des zu druckenden Satzes;
  //   die Druckdatei wird erst danach geöffnet, damit ohne
  //   Satz keine Liste entsteht
  if (cio_open(hfile04
              : i_file
              : i_library
              : i_member
              : i_rcdformat
              : 'rr,arrseq=Y,nullcap=Y,riofb=Y') = bFalse);
    clear usr0005;
    usr0005.var1 = i_file;
    o_msgid  = 'USR0005';
    o_msgdta = usr0005;
    leavesr;
  endif;

  exsr readrcd;
  if (isrecord = bFalse);
    o_msgid  = 'USR8120';
    o_msgdta = '';
    leavesr;
  endif;

  // - Einlesen Objektbeschreibung
  exsr getobjtext;

  // - Öffnen der Druckdatei und der Feldliste
  f_execute('OVRPRTF +
             FILE(PEEK65P) +
             TOFILE(' +
               %trimr(sds.pgmlib) + '/PEEK65P) +
             SPLFNAME(' +
               %trim(i_file) + ') +
             USRDTA(''' +
               %editc(i_rcdNbr: 'X') + ''') +
             OVRSCOPE(*CALLLVL)'
            : ymsgid: ymsgdta);
  ymsgid = '';
  ymsgdta = '';

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

  peek06_name = f_pgmcalln('PEEK06');
  peek09_name = f_pgmcalln('PEEK09');
  peek32_name = f_pgmcalln('PEEK32');

  txt0132 = f_msgtext('TXT0132': ''); // Datei:
  txt0133 = f_msgtext('TXT0133': ''); // Bibliothek:
  txt0134 = f_msgtext('TXT0134': ''); // RRN:
  txt0135 = f_msgtext('TXT0135': ''); // Seite:
  txt0136 = f_msgtext('TXT0136': ''); // Feldname
  txt0137 = f_msgtext('TXT0137': ''); // Feldbeschr.
  txt0138 = f_msgtext('TXT0138': ''); // Feldinhalt
  txt0139 = f_msgtext('TXT0139': ''); // Text:

endsr;

//============================================================*
//  Program error handler                                     *
//============================================================*

dcl-proc errorhandler;
  dcl-pi *n;
    i_condtoken    likeds(cee_fc_t) value;
    i_pcommarea    int(10) value;
    o_action       int(10);
    o_newcondtoken likeds(cee_fc_t);
  end-pi;

  dump;
  o_action = cee_percolate;

end-proc;

