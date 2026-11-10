**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - Ermitteln Satzformate                        *
      //%EMETADATA                                                     *
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
ctl-opt main(peek11);
/copy 'qcopyle/h_spec.rpgleinc'
/copy 'qcopyle/copyright.rpgleinc'

/copy 'qcopyle/d_vardef.rpgleinc'
/copy 'qcopyle/rcdl0200.rpgleinc'
/copy 'qcopyle/genheader.rpgleinc'
/copy 'qcopyle/fldl0100.rpgleinc'
/copy 'qcopyle/quslrcd.rpgleinc'
/copy 'qcopyle/quscrtus.rpgleinc'
/copy 'qcopyle/qusptrus.rpgleinc'

/define internal_prototype
/copy 'qcopyle/ppeek11.rpgleinc'
/undefine internal_prototype

/copy 'qcopyle/ppeek53.rpgleinc'
/copy 'qcopyle/ppeek58.rpgleinc'

dcl-ds qUsrSpc likeds(qObj_t) inz;
dcl-s pSpcPtr pointer;
dcl-ds errCode likeds(errCode_t) inz;

//  Organisation of generic header
dcl-ds genHeader likeds(genHeader_t) based(pSpcPtr);

//  List data
dcl-s currListE like(int4_t);
dcl-s offsetListE like(int4_t);
dcl-s pListE pointer;
dcl-ds listE likeds(rcdl0200_t) based(pListE);

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
    o_rcdl0200 likeds(rcdl0200_t);
  end-pi;

  //---------------------------------------------------*

  qUsrSpc.lib = USRSPC_LIBRARY;
  qUsrSpc.name = USRSPC_NAME;

  monitor;

    select;
    when (i_function = '*CREATE');
      exsr create;
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

  begsr create;

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
      o_numE = genHeader.numLstEnt;
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
       currListE >= genHeader.numLstEnt);
      exsr setError;
      leavesr;
    endif;

    currListE = currListE + 1;

    offsetListE =
     genHeader.offsetLst +
     ((currListE - 1) * genHeader.entrySize);

    pListE = pSpcPtr + offsetListE;

    o_rcdl0200 = listE;

    o_numE = genHeader.numLstEnt - currListE;

  endsr;

  //====================================================*
  //  Set error condition                               *
  //====================================================*

  begsr setError;

    o_numE = 0;
    currListE = -1;

  endsr;

end-proc;

