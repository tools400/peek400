**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - Ermitteln Datenbankrelationen                *
      //%EMETADATA                                                     *
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 1.4.0                               *
//  Programm : PEEK39                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 20.03.98  RADDATZ                                 *
//                                                               *
//===============================================================*
//                                                               *
//  Dokumentation:                                               *
//                                                               *
//  Peek/400 - Ermitteln Datenbankrelationen                     *
//                                                               *
//===============================================================*
//                                                               *
//  INPUT-Parameter:                                             *
//  ================                                             *
//                                                               *
//  XQFILE  - Qualified file name                                *
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
//      PEEK39 - Funktion (1)       create list                  *
//                                                               *
//  1   DO  XANZ                                                 *
//      PEEK39 - Funktion (5)       read next entry              *
//      ENDDO                                                    *
//                                                               *
//      PEEK39 - Funktion (4)       delete list (user space)     *
//                                                               *
// ============================================================= *
ctl-opt main(peek39);
/copy 'qcopyle/h_spec.rpgleinc'
/copy 'qcopyle/copyright.rpgleinc'

/copy 'qcopyle/d_vardef.rpgleinc'
/copy 'qcopyle/dbrl0200.rpgleinc'
/copy 'qcopyle/genheader.rpgleinc'
/copy 'qcopyle/fldl0100.rpgleinc'
/copy 'qcopyle/qdbldbr.rpgleinc'
/copy 'qcopyle/quscrtus.rpgleinc'
/copy 'qcopyle/qusptrus.rpgleinc'

/define internal_prototype
/copy 'qcopyle/ppeek39.rpgleinc'
/undefine internal_prototype

/copy 'qcopyle/ppeek53.rpgleinc'
/copy 'qcopyle/ppeek58.rpgleinc'

dcl-s size_t uns(10) template;

//  qsort -- Sort Array
dcl-pr qsort pointer extproc('qsort');
  memPtr    pointer value;
  numElem   like(size_t) value;
  width     like(size_t) value;
  pSortFunc pointer(*proc) value;
end-pr;

//  Sort List Entries by Name                         *
dcl-pr sortByName int(10);
  i_pKey pointer value;
  i_pElm pointer value;
end-pr;

dcl-ds qUsrSpc likeds(qObj_t) inz;
dcl-s pSpcPtr pointer;
dcl-ds errCode likeds(errCode_t) inz;

//  Organisation of generic header
dcl-ds genHeader likeds(genHeader_t) based(pSpcPtr);

//  List data
dcl-s currListE like(int4_t);
dcl-s offsetListE like(int4_t);
dcl-s pListE pointer;
dcl-ds listE likeds(dbrl0200_t) based(pListE);

dcl-s msgID like(msgId_t);
dcl-s msgDta like(msgDta_t);

//*******************************************************************
//           Main  Control block                                    *
//*******************************************************************

dcl-proc peek39;
  dcl-pi *n;
    i_qFile    like(qObj_t) const;
    i_mbr      like(mbr_t) const;
    i_function like(function_t) const;
    o_numE     like(int4_t);
    o_dbrl0200 likeds(dbrl0200_t);
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

    //  get database relations (Fehler über errcode statt Ausnahme)
    clear errCode;
    errCode.bytPrv = %size(errCode);
    qdbldbr(qUsrSpc: 'DBRL0200'
           : i_qFile: i_mbr: '': errCode);

    if (errCode.bytAvl > 0);
      o_numE = 0;
      currListE = -1;
    else;

      //  sort entries by name
      qsort(pSpcPtr + genHeader.offsetLst
           : genHeader.numLstEnt
           : genHeader.entrySize
           : %paddr(sortByName));

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

    clear o_dbrl0200;

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

    o_dbrl0200 = listE;

    o_numE = genHeader.numLstEnt - currListE;

  endsr;

  //====================================================*
  //  Set error condition                               *
  //====================================================*

  begsr setError;

    o_numE = 0;

  endsr;

end-proc;

//====================================================*
//  Sort List Entries by Name                         *
//====================================================*
dcl-proc sortByName;
  dcl-pi *n int(10);
    i_pKey pointer value;
    i_pElm pointer value;
  end-pi;

  dcl-ds key qualified based(i_pKey);
    depFile char(10) pos(31);
    depLib  char(10);
    depMbr  char(10);
  end-ds;

  dcl-ds elm likeds(key) based(i_pElm);
  // - - - - - - - - - - - - - - - - - - - - - - - - - -

  select;
  when (key.depLib < elm.depLib);
    return -1;
  when (key.depLib > elm.depLib);
    return 1;
  other;
    select;
    when (key.depFile < elm.depFile);
      return -1;
    when (key.depFile > elm.depFile);
      return 1;
    other;
      return 0;
    endsl;
  endsl;

end-proc;

