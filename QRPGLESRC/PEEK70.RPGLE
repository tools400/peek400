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
/copy QCOPYLE,H_SPEC
/copy QCOPYLE,COPYRIGHT

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,OBJL0200
/copy QCOPYLE,GENHEADER
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,QUSLOBJ
/copy QCOPYLE,QUSCRTUS
/copy QCOPYLE,QUSPTRUS

/define internal_prototype
/copy QCOPYLE,PPEEK70
/undefine internal_prototype

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

//  Eigener Benutzerbereich: QTEMP/§PEEK§ benutzen und löschen auch
//  PEEK02, PEEK11, PEEK39 und PEEK46.
dcl-c USRSPC_PEEK70 'PEEK70SPC';

dcl-ds qUsrSpc likeds(qObj_t) inz;
dcl-s pSpcPtr pointer inz(*null);
dcl-ds errCode likeds(errCode_t) inz;

//  Organisation of generic header
dcl-ds GenHeader likeds(genHeader_t) based(pSpcPtr);

//  List data (-1: keine Liste erstellt)
dcl-s currListE like(int4_t) inz(-1);
dcl-s offsetListE like(int4_t);
dcl-s pListE pointer;
dcl-ds listE likeds(objl0200_t) based(pListE);

dcl-s msgID like(msgId_t);
dcl-s msgDta like(msgDta_t);

//*******************************************************************
//           Main  Control block                                    *
//*******************************************************************

dcl-proc peek70;
  dcl-pi *n;
    i_qFile    likeds(qObj_t) const;
    i_function like(function_t) const;
    o_numE     like(int4_t);
    o_objl0200 likeds(objl0200_t);
  end-pi;
  //---------------------------------------------------*

  qUsrSpc.lib = USRSPC_LIBRARY;
  qUsrSpc.name = USRSPC_PEEK70;

  monitor;

    select;
    when (i_function = '*CREATE');
      exsr Create;
    when (i_function = '*DELETE');
      exsr delete;
    when (i_function = '*READ');
      exsr read;
    other;
      //  Unbekannte Funktion
      exsr setError;
    endsl;

  on-error;
    dump;
    //  Nach einem Fehler gibt es keine gültige Liste mehr
    currListE = -1;
    exsr setError;
  endmon;

  //====================================================*
  //  Create --  create user space and get database rel.*
  //====================================================*

  begsr Create;

    o_numE = *zeros;
    currListE = -1;

    //  create user space
    if (not f_exist(
       qUsrSpc.name: qUsrSpc.lib: '*USRSPC'));
      quscrtus(qUsrSpc: 'TEMP': 32767: x'00'
              : '*ALL': 'Peek/400 - Work Area');
    endif;

    //  get user space pointer
    qusptrus(qUsrSpc: pSpcPtr);

    //  get list of files (errors are returned in errcode)
    clear errCode;
    errCode.bytPrv = %size(errCode);
    quslobj(qUsrSpc: 'OBJL0200'
           : i_qFile: '*FILE': errCode);

    if (errCode.bytAvl > 0);
      o_numE = 0;
      currListE = -1;
    else;
      o_numE = GenHeader.NumLstEnt;
      currListE = 0;
    endif;

  endsr;

  //====================================================*
  //  Delete --  Delete user space                      *
  //====================================================*

  begsr delete;

    if (f_exist(
       qUsrSpc.name: qUsrSpc.lib: '*USRSPC'));

      f_execute('DLTUSRSPC USRSPC(' +
                 %trim(qUsrSpc.lib) + '/' +
                 %trim(qUsrSpc.name) +
               ')': msgID: msgDta);
    endif;

    pSpcPtr = *null;
    currListE = -1;
    o_numE = 0;

  endsr;

  //====================================================*
  //  Read   --  Read next entry                        *
  //====================================================*

  begsr read;

    clear o_objl0200;

    //  Keine Liste erstellt (oder gelöscht) oder Listenende
    if (pSpcPtr = *null or currListE < 0);
      exsr setError;
      leavesr;
    endif;

    if (currListE >= GenHeader.NumLstEnt);
      exsr setError;
      leavesr;
    endif;

    currListE = currListE + 1;

    offsetListE =
     GenHeader.OffsetLst +
     ((currListE - 1) * GenHeader.EntrySize);

    pListE = pSpcPtr + offsetListE;

    o_objl0200 = listE;

    o_numE = GenHeader.NumLstEnt - currListE;

  endsr;

  //====================================================*
  //  Set error condition                               *
  //====================================================*

  begsr setError;

    o_numE = 0;
    clear o_objl0200;

  endsr;

end-proc;

