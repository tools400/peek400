**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 1.4.0                               *
//  Programm : PEEK10                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 26.09.96  RADDATZ                                 *
//                                                               *
//===============================================================*
//                                                               *
//  Dokumentation:                                               *
//                                                               *
//  Abrufen der verfügbaren Satzformate über API's               *
//                                                               *
//===============================================================*
//                                                               *
//  INPUT-Parameter:                                             *
//  ================                                             *
//                                                               *
//  XQFile  - Qualified file name                                *
//             1 - 10:  file                                     *
//            11 - 20:  library                                  *
//                                                               *
//  XFUNK   - control of modul function                          *
//     *CREATE  - create list of database relations   CREATE     *
//     *READ    - get next entry                      READ       *
//     *DELETE  - delete list                         DELETE     *
//                                                               *
//  OUTPUT-Parameter:                                            *
//  =================                                            *
//                                                               *
//  XANZ    - number of entry (depedencies)                      *
//            parameter is supported using XFUNK=1   (create)    *
//                                                               *
//  XLIST   - entry                                              *
//            parameter is supported using XFUNK=5   (read)      *
//            (must be splitted using a data structure)          *
//                                                               *
//===============================================================*
//                                                               *
//  Typical call sequence:                                       *
//                                                               *
//      PEEK10 - Funktion (1)       create list                  *
//                                                               *
//  1   DO  XANZ                                                 *
//      PEEK10 - Funktion (5)       read next entry              *
//      ENDDO                                                    *
//                                                               *
//      PEEK10 - Funktion (4)       delete list (user space)     *
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
ctl-opt main(peek11);
/copy QCOPYLE,H_SPEC
/copy QCOPYLE,COPYRIGHT

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,RCDL0200
/copy QCOPYLE,GENHEADER
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,QUSLRCD
/copy QCOPYLE,QUSCRTUS
/copy QCOPYLE,QUSPTRUS

/define internal_prototype
/copy QCOPYLE,PPEEK11
/undefine internal_prototype

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

dcl-ds qUsrSpc likeds(qObj_t) inz;
dcl-s pSpcPtr pointer;
dcl-ds errCode likeds(errCode_t) inz;

//  Organisation of generic header
dcl-ds GenHeader likeds(genHeader_t) based(pSpcPtr);

//  List data
dcl-s currListE like(int4_t);
dcl-s offsetListE like(int4_t);
dcl-s pListE pointer;
dcl-ds listE likeds(RCDL0200_t) based(pListE);

dcl-s msgID like(msgId_t);
dcl-s msgDta like(msgDta_t);

//*******************************************************************
//           Main  Control block                                    *
//*******************************************************************

dcl-proc peek11;
  dcl-pi *n;
    i_qFile    likeds(qObj_t) const;
    i_function like(function_t) const;
    o_numE     like(int4_t);
    o_rcdl0200 likeds(RCDL0200_t);
  end-pi;

  //---------------------------------------------------*

  qUsrSpc.lib = USRSPC_LIBRARY;
  qUsrSpc.name = USRSPC_NAME;

  monitor;

    select;
    when (i_function = '*CREATE');
      exsr Create;
    when (i_function = '*DELETE');
      exsr delete;
    when (i_function = '*READ');
      exsr read;
    endsl;

  on-error;
    dump;
    o_numE = 0;
    currListE = -1;
  endmon;

  //====================================================*
  //  Create --  create user space and get database rel.*
  //====================================================*

  begsr Create;

    o_numE = *zeros;

    //  create user space
    if (not f_exist(
       qUsrSpc.name: qUsrSpc.lib: '*USRSPC'));
      quscrtus(qUsrSpc: 'TEMP': 32767: x'00'
              : '*ALL': 'Peek/400 - Work Area');
    endif;

    //  get user space pointer
    qusptrus(qUsrSpc: pSpcPtr);

    //  get file record formats
    //  (Fehler als Rückgabewert, nicht als Escape-Nachricht, z.B.
    //  CPF9812, wenn die Datei nicht existiert)
    clear errCode;
    errCode.bytPrv = %size(errCode);
    quslrcd(qUsrSpc: 'RCDL0200': i_qFile: '0': errCode);

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

  endsr;

  //====================================================*
  //  Read   --  Read next entry                        *
  //====================================================*

  begsr read;

    clear o_rcdl0200;

    if (currListE < 0 or
       currListE >= GenHeader.NumLstEnt);
      exsr setError;
      leavesr;
    endif;

    currListE = currListE + 1;

    offsetListE =
     GenHeader.OffsetLst +
     ((currListE - 1) * GenHeader.EntrySize);

    pListE = pSpcPtr + offsetListE;

    o_rcdl0200 = listE;

    o_numE = GenHeader.NumLstEnt - currListE;

  endsr;

  //====================================================*
  //  Set error condition                               *
  //====================================================*

  begsr setError;

    o_numE = 0;
    currListE = -1;

  endsr;

end-proc;

