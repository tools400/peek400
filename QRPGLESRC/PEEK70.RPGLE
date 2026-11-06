**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 3.2.4                               *
//  Programm : PEEK70                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 05.11.2010  Thomas Raddatz                        *
//                                                               *
//===============================================================*
//                                                               *
//  Dokumentation:                                               *
//                                                               *
//  Peek/400 - Ermitteln Dateiliste                              *
//                                                               *
//  Listet die Objekte vom Typ *FILE (QUSLOBJ, Format OBJL0200)  *
//  im eigenen Benutzerbereich QTEMP/PEEK70SPC.                  *
//                                                               *
//===============================================================*
//                                                               *
//  Parameter:                                                   *
//  ==========                                                   *
//                                                               *
//  i_qFile     - Datei (auch generisch, *ALL) und Bibliothek    *
//                (auch *LIBL, *CURLIB, ...)                     *
//                                                               *
//  i_function  - Funktion                                       *
//     *CREATE  - Liste erstellen                                *
//     *READ    - nächsten Eintrag lesen                         *
//     *DELETE  - Liste (Benutzerbereich) löschen                *
//                                                               *
//  o_nume      - *CREATE: Anzahl Einträge                       *
//                *READ:   Anzahl noch folgender Einträge        *
//                0, wenn die Liste nicht erstellt werden konnte *
//                oder kein Eintrag mehr da ist                  *
//                                                               *
//  o_objl0200  - *READ: gelesener Eintrag                       *
//                                                               *
//===============================================================*
//                                                               *
//  Aufruffolge:                                                 *
//                                                               *
//      PEEK70 *CREATE  - Liste erstellen (o_nume Einträge)      *
//      solange o_nume > 0:                                      *
//         PEEK70 *READ - Eintrag lesen                          *
//      PEEK70 *DELETE  - Benutzerbereich löschen (optional)     *
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
ctl-opt main(peek70);
/COPY QCOPYLE,H_SPEC
/COPY QCOPYLE,COPYRIGHT

/COPY QCOPYLE,D_VARDEF
/COPY QCOPYLE,OBJL0200
/COPY QCOPYLE,GENHEADER
/COPY QCOPYLE,FLDL0100
/COPY QCOPYLE,QUSLOBJ
/COPY QCOPYLE,QUSCRTUS
/COPY QCOPYLE,QUSPTRUS

/define internal_prototype
/COPY QCOPYLE,PPEEK70
/undefine internal_prototype

/COPY QCOPYLE,PPEEK53
/COPY QCOPYLE,PPEEK58

//  Eigener Benutzerbereich: QTEMP/§PEEK§ benutzen und löschen auch
//  PEEK02, PEEK11, PEEK39 und PEEK46.
dcl-c USRSPC_PEEK70   'PEEK70SPC';

dcl-ds qusrspc likeds(qobj_t) inz;
dcl-s pspcptr         pointer inz(*null);
dcl-ds errcode likeds(errcode_t) inz;

//  Organisation of generic header
dcl-ds genheader likeds(genheader_t) based(pspcptr);

//  List data (-1: keine Liste erstellt)
dcl-s currliste       like(int4_t) inz(-1);
dcl-s offsetliste     like(int4_t);
dcl-s pliste          pointer;
dcl-ds liste likeds(objl0200_t) based(pliste);

dcl-s msgid           like(msgid_t);
dcl-s msgdta          like(msgdta_t);

//*******************************************************************
//           Main  Control block                                    *
//*******************************************************************

dcl-proc peek70;
  dcl-pi *N;
    i_qfile         const likeds(qobj_t);
    i_function      const like(function_t);
    o_nume          like(int4_t);
    o_objl0200      likeds(objl0200_t);
  end-pi;
  //---------------------------------------------------*

  qusrspc.lib = USRSPC_LIBRARY;
  qusrspc.name = USRSPC_PEEK70;

  monitor;

    select;
    when (i_function = '*CREATE');
      exsr create;
    when (i_function = '*DELETE');
      exsr delete;
    when (i_function = '*READ');
      exsr read;
    other;
      //  Unbekannte Funktion
      exsr seterror;
    endsl;

  on-error;
    dump;
    //  Nach einem Fehler gibt es keine gültige Liste mehr
    currliste = -1;
    exsr seterror;
  endmon;

  //====================================================*
  //  Create --  create user space and get database rel.*
  //====================================================*

  begsr create;

    o_nume = *zeros;
    currliste = -1;

    //  create user space
    if (not f_exist(
       qusrspc.name: qusrspc.lib: '*USRSPC'));
      quscrtus(qusrspc: 'TEMP': 32767: x'00'
              : '*ALL': 'Peek/400 - Work Area');
    endif;

    //  get user space pointer
    qusptrus(qusrspc: pspcptr);

    //  get list of files (errors are returned in errcode)
    clear errcode;
    errcode.bytprv = %size(errcode);
    quslobj(qusrspc: 'OBJL0200'
           : i_qfile: '*FILE': errcode);

    if (errcode.bytavl > 0);
      o_nume = 0;
      currliste = -1;
    else;
      o_nume = genheader.numlstent;
      currliste = 0;
    endif;

  endsr;

  //====================================================*
  //  Delete --  Delete user space                      *
  //====================================================*

  begsr delete;

    if (f_exist(
       qusrspc.name: qusrspc.lib: '*USRSPC'));

      f_execute('DLTUSRSPC USRSPC(' +
                 %trim(qusrspc.lib) + '/' +
                 %trim(qusrspc.name) +
               ')': msgid: msgdta);
    endif;

    pspcptr = *null;
    currliste = -1;
    o_nume = 0;

  endsr;

  //====================================================*
  //  Read   --  Read next entry                        *
  //====================================================*

  begsr read;

    clear o_objl0200;

    //  Keine Liste erstellt (oder gelöscht) oder Listenende
    if (pspcptr = *null or currliste < 0);
      exsr seterror;
      leavesr;
    endif;

    if (currliste >= genheader.numlstent);
      exsr seterror;
      leavesr;
    endif;

    currliste = currliste + 1;

    offsetliste =
     genheader.offsetlst +
     ((currliste - 1) * genheader.entrysize);

    pliste = pspcptr + offsetliste;

    o_objl0200 = liste;

    o_nume = genheader.numlstent - currliste;

  endsr;

  //====================================================*
  //  Set error condition                               *
  //====================================================*

  begsr seterror;

    o_nume = 0;
    clear o_objl0200;

  endsr;

end-proc;

