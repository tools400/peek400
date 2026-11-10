**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - Ermitteln Satzaufbau                         *
      //%EMETADATA                                                     *
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 1.4.0                               *
//  Programm : PEEK02                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 26.09.96  RADDATZ                                 *
//                                                               *
//===============================================================*
//                                                               *
//  Dokumentation:                                               *
//                                                               *
//  Abrufen einer Satzformatbeschreibung über API's              *
//                                                               *
//===============================================================*
//                                                               *
//  INPUT-Parameter:                                             *
//  ================                                             *
//                                                               *
//  xQFile  - Qualified file name                                *
//             1 - 10:  file                                     *
//            11 - 20:  library                                  *
//                                                               *
//  xRFmt   - Record format name                                 *
//                                                               *
//  xOption - control of modul function                          *
//     *CREATE  - create list of database relations   CREATE     *
//     *READ    - get next entry                      READ       *
//     *DELETE  - delete list                         DELETE     *
//                                                               *
//  OUTPUT-Parameter:                                            *
//  =================                                            *
//                                                               *
//  xAnz    - number of entry (depedencies)                      *
//            parameter is supported using xOption=1 (create)    *
//                                                               *
//  xRcdFmtID - record format id                                 *
//            parameter is supported using xOption=1 (create)    *
//                                                               *
//  xListE  - list entry                                         *
//            parameter is supported using xOption=5 (read)      *
//            (must be splitted using a data structure)          *
//                                                               *
//===============================================================*
//                                                               *
//  Typical call sequence:                                       *
//                                                               *
//      PEEK02 - Funktion (1)       create list                  *
//                                                               *
//  1   DO  xAnz                                                 *
//      PEEK02 - Funktion (5)       read next entry              *
//      ENDDO                                                    *
//                                                               *
//      PEEK02 - Funktion (4)       delete list (user space)     *
//                                                               *
// ============================================================= *
ctl-opt main(peek02);
/copy 'qcopyle/h_spec.rpgleinc'
/copy 'qcopyle/copyright.rpgleinc'

/copy 'qcopyle/d_vardef.rpgleinc'
/copy 'qcopyle/fldl0100.rpgleinc'
/copy 'qcopyle/genheader.rpgleinc'
/copy 'qcopyle/quscrtus.rpgleinc'
/copy 'qcopyle/qusptrus.rpgleinc'
/copy 'qcopyle/quslfld.rpgleinc'

/define internal_prototype
/copy 'qcopyle/ppeek02.rpgleinc'
/undefine internal_prototype

/copy 'qcopyle/ppeek53.rpgleinc'
/copy 'qcopyle/ppeek58.rpgleinc'

dcl-ds qUsrSpc likeds(qObj_t) inz;
dcl-s pSpcPtr pointer;
dcl-ds errCode likeds(errCode_t) inz;

dcl-ds genHeader likeds(genHeader_t) based(pSpcPtr);
dcl-ds listHeader likeds(QUSLFLD_header_t) based(pListHeader);

dcl-s currListE like(int4_t);
dcl-s offsetListE like(int4_t);
dcl-s pListE pointer;
dcl-ds listE likeds(fldl0100_t) based(pListE);

dcl-s msgID like(msgId_t);
dcl-s msgDta like(msgDta_t);

//*******************************************************************
//           Main  Control block                                    *
//*******************************************************************

dcl-proc peek02;
  dcl-pi *n;
    i_qFile    likeds(qObj_t) const;
    i_rcdFmt   like(fmt_t) const;
    i_function like(function_t) const;
    o_numE     like(int4_t);
    o_fldl0100 likeds(fldl0100_t);
    o_rcdFmtID like(fmtId_t);
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

    //  get file fields
    //  (Fehler als Rückgabewert, nicht als Escape-Nachricht, z.B.
    //  CPF3C28, wenn das Satzformat nicht existiert)
    clear errCode;
    errCode.bytPrv = %size(errCode);
    quslfld(qUsrSpc: 'FLDL0100': i_qFile
           : i_rcdFmt: '0': errCode);

    if (errCode.bytAvl > 0);
      pListHeader = *null;
      o_numE = 0;
      currListE = -1;
    else;
      pListHeader = pSpcPtr + genHeader.offsetHdr;
      o_numE = genHeader.numLstEnt;
      o_rcdFmtID = listHeader.rcdFmtID;
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

    clear o_fldl0100;

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

    o_fldl0100 = listE;

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

