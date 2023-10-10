**free
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
// >>PRE-COMPILER<<                                              *
//   >>CRTCMD<< &LI/CRTPEEKOBJ SRCFILE(&SL/&SF) SRCMBR(&SM) +    *
//                           OBJLIB(&LI) DEVLIB(&LI) +           *
//                           SBMJOB(*NO) BNDDIR(PEEK) +          *
//                           INSTALL(*NO);                       *
//   >>EXECUTE<<                                                 *
// >>END-PRE-COMPILER<<                                          *
//===============================================================*
ctl-opt main(peek39);
/COPY QCOPYLE,H_SPEC
/COPY QCOPYLE,COPYRIGHT

/COPY QCOPYLE,D_VARDEF
/COPY QCOPYLE,DBRL0200
/COPY QCOPYLE,GENHEADER
/COPY QCOPYLE,FLDL0100
/COPY QCOPYLE,QDBLDBR
/COPY QCOPYLE,QUSCRTUS
/COPY QCOPYLE,QUSPTRUS

/define internal_prototype
/COPY QCOPYLE,PPEEK39
/undefine internal_prototype

/COPY QCOPYLE,PPEEK53
/COPY QCOPYLE,PPEEK58

dcl-s size_t          uns(10) template;

//  qsort -- Sort Array
dcl-pr qsort pointer extproc('qsort');
  memptr          pointer value;
  numelem         value  like(size_t);
  width           value  like(size_t);
  psortfunc       pointer(*proc) value;
end-pr;

//  Sort List Entries by Name                         *
dcl-pr sortbyname      int(10);
  i_pkey          pointer value;
  i_pelm          pointer value;
end-pr;

dcl-ds qusrspc likeds(qobj_t) inz;
dcl-s pspcptr         pointer;
dcl-ds errcode likeds(errcode_t) inz;

//  Organisation of generic header
dcl-ds genheader likeds(genheader_t) based(pspcptr);

//  List data
dcl-s currliste       like(int4_t);
dcl-s offsetliste     like(int4_t);
dcl-s pliste          pointer;
dcl-ds liste likeds(dbrl0200_t) based(pliste);

dcl-s msgid           like(msgid_t);
dcl-s msgdta          like(msgdta_t);

//*******************************************************************
//           Main  Control block                                    *
//*******************************************************************

dcl-proc peek39;
  dcl-pi *N;
    i_qfile         const like(qobj_t);
    i_mbr           const like(mbr_t);
    i_function      const like(function_t);
    o_nume          like(int4_t);
    o_dbrl0200      likeds(dbrl0200_t);
  end-pi;

  //---------------------------------------------------*

  qusrspc.lib = USRSPC_LIBRARY;
  qusrspc.name = USRSPC_NAME;

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
    o_nume = 0;
  endmon;

  //====================================================*
  //  Create --  create user space and get database rel.*
  //====================================================*

  begsr create;

    o_nume = *zeros;

    //  create user space
    if (not f_exist(
       qusrspc.name: qusrspc.lib: '*USRSPC'));
      quscrtus(qusrspc: 'TEMP': 32767: x'00'
              : '*ALL': 'Peek/400 - Work Area');
    endif;

    //  get user space pointer
    qusptrus(qusrspc: pspcptr);

    //  get database relations
    qdbldbr(qusrspc: 'DBRL0200'
           : i_qfile: i_mbr: '': errcode);

    if (errcode.bytavl > 0);
      o_nume = 0;
      currliste = -1;
    else;

      //  sort entries by name
      qsort(pspcptr + genheader.offsetlst
           : genheader.numlstent
           : genheader.entrysize
           : %paddr(sortbyname));

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

  endsr;

  //====================================================*
  //  Read   --  Read next entry                        *
  //====================================================*

  begsr read;

    clear o_dbrl0200;

    if (currliste < 0 or
       currliste >= genheader.numlstent);
      exsr seterror;
      leavesr;
    endif;

    currliste = currliste + 1;

    offsetliste =
     genheader.offsetlst +
     ((currliste - 1) * genheader.entrysize);

    pliste = pspcptr + offsetliste;

    o_dbrl0200 = liste;

    o_nume = genheader.numlstent - currliste;

  endsr;

  //====================================================*
  //  Set error condition                               *
  //====================================================*

  begsr seterror;

    o_nume = 0;

  endsr;

end-proc;

//====================================================*
//  Sort List Entries by Name                         *
//====================================================*
dcl-proc sortbyname;
  dcl-pi *N              int(10);
    i_pkey          pointer value;
    i_pelm          pointer value;
  end-pi;

  dcl-ds key qualified   based(i_pkey);
    depfile         char(10) pos(31);
    deplib          char(10);
    depmbr          char(10);
  end-ds;

  dcl-ds elm likeds(key) based(i_pelm);
  // - - - - - - - - - - - - - - - - - - - - - - - - - -

  select;
  when (key.deplib < elm.deplib);
    return -1;
  when (key.deplib > elm.deplib);
    return 1;
  other;
    select;
    when (key.depfile < elm.depfile);
      return -1;
    when (key.depfile > elm.depfile);
      return 1;
    other;
      return 0;
    endsl;
  endsl;

end-proc;

