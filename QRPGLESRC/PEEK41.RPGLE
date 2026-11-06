**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 1.4.0                               *
//  Programm : PEEK41                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 31.12.1997  Raddatz                               *
//                                                               *
//===============================================================*
//                                                               *
//  Dokumentation:                                               *
//                                                               *
//  Abrufen von Dateiinformationen einer Datei                   *
//                                                               *
//===============================================================*
//                                                               *
//  INPUT-Parameter:                                             *
//  ================                                             *
//                                                               *
//  XQFile      - Qualified file name                            *
//                  1 - 10:  file                                *
//                 11 - 20:  library                             *
//                                                               *
//  XRcdFormat  - Record format name                             *
//                                                               *
//  XFunction     - control of module function                   *
//     *CREATE    - retrieve file description         CREATE     *
//     *BASED-ON  - retrieve based on phys. file      BASED_ON   *
//     *KEY       - initiate key sequence to reutrn   KEY        *
//     *READKEY   - read next entry                   READKEY    *
//     *SELECT    - initiate s/o statement to return  SELECT     *
//     *READSEL   - read next entry                   READSELECT *
//     *READTEXT  - file description                  READTEXT   *
//                                                               *
//  OUTPUT-Parameter:                                            *
//  =================                                            *
//                                                               *
//  XNbrOfEnt   - number of entry (depedencies)                  *
//                *CREATE   - 1=OK                               *
//                            0=Fehler                           *
//                            o_data = FILD0100                  *
//                *BASED-ON - 1=OK                               *
//                            0=Fehler                           *
//                            o_data = BSPF0100                  *
//                *KEY      - x=Anzahl Schlüsselfelder           *
//                            o_data = ''                        *
//                *READKEY  - x=Nr. des Schlüsselfeldes          *
//                            o_data = KEYL0100                  *
//                *READTEXT - x=Länge der Textbescheibung        *
//                            o_data = description               *
//                *SELECT   - x=Anzahl SELECT Einträge           *
//                            o_data = ''                        *
//                *READSEL  - x=Anzahl SELECT Einträge           *
//                            o_data = SELL0100                  *
//                                                               *
//  XData       - entry                                          *
//                parameter is supported using XFunc=5  (read)   *
//                (must be splitted using a data structure)      *
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

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,QDBRTVFD
/copy QCOPYLE,KEYL0100
/copy QCOPYLE,FILD0100
/copy QCOPYLE,SELL0100
/copy QCOPYLE,BSPF0100
/copy QCOPYLE,CEECNDHDLR

/define internal_prototype
/copy QCOPYLE,PPEEK41
/undefine internal_prototype

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

//----------------------------------------------------*
//  API - DATENSTRUKTUREN                             *
//----------------------------------------------------*

//  declarations for QDBRTVFD
dcl-ds *n;
  rcvVarTab char(1) dim(32000);
  RcvVar    char(32000) pos(1) inz;
end-ds;

dcl-s rcvVarLn int(10) inz(32000);

dcl-ds retQfile likeds(qObj_t);

dcl-ds errCode likeds(errCode_t) inz;

//  declarations for File definition header  (Qdb_Qdbfh), 1.9.3.2
dcl-s pFiledefhd pointer;

dcl-ds fileDefHd likeds(Qdb_Qdbfh_t) based(pFiledefhd);
dcl-ds lglFileSpcAttr likeds(Qdb_Qdbflogl_t) based(pLglFileSpcAttr);

//  declarations for File Scope Array        (Qdb_Qdbfb), 1.9.3.20
dcl-s pFilescpay pointer;
dcl-ds fileScope likeds(Qdb_Qdbfb_t) based(pFilescpay);

//  declarations for Key Specification Array (Qdb_Qdbfk), 1.9.3.23
dcl-s pKeyspecay pointer;
dcl-ds keySpecAy likeds(Qdb_Qdbfk_t) based(pKeyspecay);

//  declarations for select/omit Specification Array (Qdb_Qdbfk), 1.9.31
dcl-s pSelspecay pointer;
dcl-ds selSpecAy likeds(Qdb_Qdbfss_t) based(pSelspecay);
dcl-s pSelparmay pointer;

dcl-ds selParmAy likeds(Qdb_Qdbfsp_t) based(pSelparmay);

dcl-s Offset like(int4_t);
dcl-s Counter like(int4_t);
dcl-s mbrNbr like(int4_t);
dcl-s NbrOfKeyFd like(int4_t);
dcl-s PosOfKeyFd like(int4_t);
dcl-s LenOfSlOm like(int4_t);
dcl-s NbrOfSlOm like(int4_t);
dcl-s PosOfSlOm like(int4_t);
dcl-s XPos like(int4_t);
dcl-s r_valu like(SELL0100_t.sovalu);

dcl-ds keyl0100 likeds(KEYL0100_t);
dcl-ds fild0100 likeds(FILD0100_t);
dcl-ds sell0100 likeds(SELL0100_t);
dcl-ds bspf0100 likeds(BSPF0100_t);

//  Boolean variables & constants
dcl-s IsFound like(bool_t) inz(bFalse);
dcl-s isJoinFile like(bool_t) inz(bFalse);

dcl-ds now qualified;
  date  likeds(ts_date_t) pos(1);
  date6 char(6) pos(3);
  time  likeds(ts_time_t) pos(9);
  time6 char(6) pos(9);
end-ds;

dcl-ds ts_date_t qualified template;
  year    zoned(4);
  century zoned(2) overlay(year);
  month   zoned(2);
  day     zoned(2);
end-ds;

dcl-ds ts_time_t qualified template;
  hour   zoned(2);
  minute zoned(2);
  second zoned(2);
  mSecs  zoned(6);
end-ds;

//*******************************************************************
//           Main  Control block                                    *
//*******************************************************************
dcl-pi peek41;
  i_qFile    likeds(qObj_t) const;
  i_rcdFmt   like(fmt_t) const;
  i_function like(function_t) const;
  o_nbrOfEnt like(int4_t);
  o_data     char(512);
end-pi;
//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

select;
when (i_function = '*CREATE');
  exsr Create;
when (i_function = '*BASED-ON');
  exsr Based_On;
when (i_function = '*KEY');
  exsr key;
when (i_function = '*READKEY');
  exsr ReadKey;
when (i_function = '*READTEXT');
  exsr ReadText;
when (i_function = '*SELECT');
  exsr select;
when (i_function = '*READSEL');
  exsr ReadSelect;
endsl;

return;

//====================================================*
//  Create --  create user space and get database rel.*
//====================================================*

begsr Create;

  //  retrieve file description
  clear errCode;
  errCode.bytPrv = %size(errCode);

  qdbrtvfd(RcvVar: rcvVarLn: retQfile
          : 'FILD0100': i_qFile: ''
          : '0': '*LCL': '*EXT'
          : errCode);

  if (errCode.bytAvl > 0);
    o_nbrOfEnt = 0;
  else;
    o_nbrOfEnt = 1;
    pFiledefhd = %addr(rcvVarTab(1));
  endif;

  exsr API_Crt;

endsr;

//====================================================*
//  API_Crt    Fill API-structure for CREATE          *
//====================================================*

begsr API_Crt;

  now = %char(%timestamp(): *iso0);

  clear fild0100;
  //  Jahrhundert
  if (now.date.century = 19);
    fild0100.atrcen = '0';
  else;
    fild0100.atrcen = '1';
  endif;

  //  Datum
  fild0100.atrdat = now.date6;

  //  Uhrzeit
  fild0100.atrtim = now.time6;

  if (o_nbrOfEnt <= *zeros);
    //  Fehler aufgetreten
    //  Datei/Bibliothek
    fild0100.atfile = '*ERROR';
    fild0100.atlib = '*ERROR';
  else;
    //  restliche Felder füllen
    //  Datei/Bibliothek
    fild0100.atfile = retQfile.name;
    fild0100.atlib = retQfile.lib;
    //  Bit 2   - Qdbfhfpl - Type of file
    //                  D=Einheit, P=PF, L=LF, R=DDM PF, S=DDM LF
    //*                 EVAL      *in98 = %bitand(QdbfhflgH: x'20') = x'20'
    //*                 EVAL      OneByte = QdbfhflgH                          Key statement
    //*                 BITOFF    '0134567'     OneByte
    //*                 TESTB     '2'           OneByte                  99
    //*   *IN99         IFEQ      '1'
    if (%bitand(fileDefHd.QdbfhflgH: x'20') = x'20');
      fild0100.atfila = '*LGL';                                       // logical
      fild0100.atftyp = 'L';
    else;
      fild0100.atfila = '*PHY';                                       // physical
      fild0100.atftyp = 'P';
    endif;

    //  Bit 4   - Qdbfhfsu - file type (FILETYPE)
    //*                 EVAL      *in98 = %bitand(QdbfhflgH: x'08') = x'08'
    //*                 EVAL      OneByte = QdbfhflgH                          Key statement
    //*                 BITOFF    '0123567'     OneByte
    //*                 TESTB     '4'           OneByte                  99
    //*   *IN99         IFEQ      '1'
    if (%bitand(fileDefHd.QdbfhflgH: x'08') = x'08');
    //                  EVAL      ATDTAT = '*SRC'
    else;
    //                  EVAL      ATDTAT = '*DTA'
    endif;

    //  Dateiwartezeit - Qdbfwtfi
    fild0100.atwait = fileDefHd.Qdbfwtfi;

    //  Satzwartezeit  - Qdbfbrwt
    fild0100.atwatr = fileDefHd.Qdbfbrwt;

    //  Bit 0   - Qdbfhflc - level check
    //*                 EVAL      *in98 = %bitand(QdbfhflgL: x'80') = x'80'
    //*                 EVAL      OneByte = QdbfhflgL                          Level Check
    //*                 BITOFF    '1234567'     OneByte
    //*                 TESTB     '0'           OneByte                  99
    //*   *IN99         IFEQ      '1'
    if (%bitand(fileDefHd.QdbfhflgL: x'80') = x'80');
      fild0100.atlvlc = 'Y';
    else;
      fild0100.atlvlc = 'N';
    endif;

    //  Textbeschreibung
    fild0100.attxt = fileDefHd.Qdbfhtxt;

    //  Extern/Intern beschriebene Datei
    //  Bit 7   - Qdbfpgmd - program described file indicator
    //*                 EVAL      *in98 = %bitand(Qaaf2: x'0100') = x'0100'
    //*                 EVAL      OneByte = Qaaf2                              Key statement
    //*                 BITOFF    '0123456'     OneByte
    //*                 TESTB     '7'           OneByte                  99
    //*   *IN99         IFEQ      '1'
    if (%bitand(fileDefHd.Qaaf2: x'0100') = x'0100');
      fild0100.atfls = 'Y';                                           // program
    else;
      fild0100.atfls = 'N';                                           // extern
    endif;

    //  Zugriffspfad
    select;
    when (fileDefHd.Qdbfpact = 'AR');
      fild0100.ataccp = 'A';
    when (fileDefHd.Qdbfpact = 'KC' or
       fileDefHd.Qdbfpact = 'KF' or
       fileDefHd.Qdbfpact = 'KL' or
       fileDefHd.Qdbfpact = 'KN' or
       fileDefHd.Qdbfpact = 'KU');
      fild0100.ataccp = 'K';
    other;
      fild0100.ataccp = '?';
    endsl;

    //  Select/Omit Angaben
    //  Bit 1   - Qdbfkfso - select/omit
    //*                 EVAL      *in98 = %bitand(QdbfhflgL: x'40') = x'40'
    //*                 EVAL      OneByte = QdbfhflgL                          Key statement
    //*                 BITOFF    '0234567'     OneByte
    //*                 TESTB     '1'           OneByte                  99
    //*   *IN99         IFEQ      '1'
    if (%bitand(fileDefHd.QdbfhflgL: x'40') = x'40');
      fild0100.atselo = 'Y';
    else;
      fild0100.atselo = 'N';
    endif;

    //  Logical File Attributes
    if (fileDefHd.Qdblfof > 0);
      pLglFileSpcAttr =
       pFiledefhd + fileDefHd.Qdblfof;
      isJoinFile =
       %bitand(lglFileSpcAttr.Qlfa: x'20') = x'20';
    else;
      isJoinFile = bFalse;
    endif;

    //  Join logical file
    if (isJoinFile = bTrue);
      fild0100.atjoin = 'Y';
    else;
      fild0100.atjoin = 'N';
    endif;

    //  Anzahl Satzformate
    if (fild0100.atjoin = 'Y');
      fild0100.atnofm = 1;
    else;
      fild0100.atnofm = fileDefHd.Qdbflbnum;
    endif;

    //  Anzahl Teildateien
    fild0100.atnomb = fileDefHd.Qdbfhmnum;

    //  Auxiliary storage pool ID
    fild0100.atasp = fileDefHd.Qdbfasp;

    //  nicht unterstützt:
    fild0100.atmxdd = '';
    fild0100.atmxdc = '';
    fild0100.atmxdb = '';
    fild0100.atfatr = '';
    fild0100.atsysn = '';
    fild0100.atshar = '';
    fild0100.atfccn = '';
    fild0100.atfcdt = '';
    fild0100.atfctm = '';
    fild0100.aticap = '';
    fild0100.ataqdv = '';
    fild0100.atmxdv = 0;
    fild0100.atspol = '';
    fild0100.atnodv = 0;
    fild0100.atubl  = 0;
    fild0100.atidta = '';
    fild0100.atcseq = '';

  endif;

  o_data = fild0100;

endsr;

//====================================================*
//  Based_On-  set pointer to matching                *
//             file scope entry of based-on           *
//====================================================*

begsr Based_On;

  if (%check('0123456789': %trim(i_rcdFmt)) = 0);
    //**                Eval      mbrNbr = %dec(%trim(XRcdFormat): 10: 0)
    //**                EXSR      FindMbr
    p_kill('Incorrect record format name: ' +
          i_rcdFmt);
  else;
    exsr FindRcdFmt;
  endif;

  if (IsFound = bTrue);
    //  store number of key fields ...
    clear bspf0100;
    bspf0100.bffile = fileScope.Qdbfbf;
    bspf0100.bflib = fileScope.Qdbfbfl;
    bspf0100.bfrcdfmt = fileScope.Qdbft;
    o_nbrOfEnt = 1;
    o_data = bspf0100;
  else;
    //  no key fields found ...
    o_nbrOfEnt = 0;
    o_data = '';
  endif;

endsr;

//====================================================*
//  Key    --  set pointer to matching                *
//             file scope entry of key fields         *
//====================================================*

begsr key;

  exsr FindRcdFmt;
  if (IsFound = bTrue);
    //  store number of key fields ...
    NbrOfKeyFd = fileScope.Qdbfbgky;
    PosOfKeyFd = *zeros;
  else;
    //  no key fields found ...
    NbrOfKeyFd = *zeros;
    PosOfKeyFd = *hival;
  endif;

  o_nbrOfEnt = NbrOfKeyFd;

endsr;

//====================================================*
//  ReadKey --  read key entry one by one             *
//====================================================*

begsr ReadKey;

  if (PosOfKeyFd < NbrOfKeyFd);

    Offset = PosOfKeyFd * %size(keySpecAy);
    Offset = Offset + fileScope.Qdbfksof;

    pKeyspecay = %addr(rcvVarTab(Offset + 1));

    clear keyl0100;
    //  Jahrhundert
    keyl0100.aprcen = fild0100.atrcen;
    //  Datum
    keyl0100.aprdat = fild0100.atrdat;
    //  Uhrzeit
    keyl0100.aprtim = fild0100.atrtim;
    //  Datei
    keyl0100.apfile = fild0100.atfile;
    //  Bibliothek
    keyl0100.aplib = fild0100.atlib;
    //  Anzahl Schlüsselfelder
    keyl0100.apnkyf = NbrOfKeyFd;
    //  Feldname
    keyl0100.apkeyf = keySpecAy.Qdbfkfld;                              // Feldname
    //  Schlüsselfeldnummer
    keyl0100.apkeyn = PosOfKeyFd + 1;
    //  Dateiart
    keyl0100.apftyp = fild0100.atftyp;                                 // file type
    //------------------------------------------*
    //  Dateiattribute:                         *
    //------------------------------------------*
    //  Zugriffspfadwartung
    keyl0100.apmant = fileDefHd.Qdbfkfdm;
    //  Bit 0/1 - Reserved_1
    //  Bit 2   - Qdbfhfpl - Type of file
    keyl0100.apfila = fild0100.atfila;                                 // physical
    //  Bit 3   - Reserved_2
    //  Bit 5   - Reserved_3
    //  Bit 6   - Qdbfhfky - Access path
    //*                 EVAL      *in98 = %bitand(QdbfhflgH: x'02') = x'02'
    //*                 EVAL      OneByte = QdbfhflgH                          Key statement
    //*                 BITOFF    '0123457'     OneByte
    //*                 TESTB     '6'           OneByte                  99
    //*   *IN99         IFEQ      '1'
    if (%bitand(fileDefHd.QdbfhflgH: x'02') = x'02');
      //  ... keyed
      select;
      //      ... arrival sequence
      when (fileDefHd.Qdbfpact = 'AR');
        keyl0100.apuniq = '*BLANKS';                                 // no unique key
        keyl0100.apkeyo = '*BLANKS';                                 // no order
      //      ... keyed, no unique, FCFO order
      when (fileDefHd.Qdbfpact = 'KC');
        keyl0100.apuniq = 'N';                                       // no unique key
        keyl0100.apkeyo = 'C';                                       // FCFO oder
      //      ... keyed, no unique, FIFO order
      when (fileDefHd.Qdbfpact = 'KF');
        keyl0100.apuniq = 'N';                                       // no unique key
        keyl0100.apkeyo = 'F';                                       // FIFO order
      //      ... keyed, no unique, LIFO order
      when (fileDefHd.Qdbfpact = 'KL');
        keyl0100.apuniq = 'N';                                       // no unique key
        keyl0100.apkeyo = 'L';                                       // LIFO order
      //      ... keyed, no unique, no order
      when (fileDefHd.Qdbfpact = 'KN');
        keyl0100.apuniq = 'N';                                       // no unique key
        keyl0100.apkeyo = 'N';                                       // no order
      //      ... keyed, unique, FIFO order - see DSPFD
      when (fileDefHd.Qdbfpact = 'KU');
        keyl0100.apuniq = 'Y';                                       // no unique key
        keyl0100.apkeyo = 'N';                                       // FIFO order

      other;
      endsl;
    else;
      //  ... arrival sequence
      keyl0100.apuniq = '*BLANKS';                                    // no unique key
      keyl0100.apkeyo = '*BLANKS';                                    // no access path
    endif;
    //  Bit 7   - Reserved_4

    //------------------------------------------*
    //  Additional attribute flags              *
    //------------------------------------------*
    //  Bit 7   - Qdbfpkey - primary key
    //*                 EVAL      *in98 = %bitand(Qaaf2H: x'01') = x'01'
    //*                 EVAL      OneByte = Qaaf2H                             Key statement
    //*                 BITOFF    '0123456'     OneByte
    //*                 TESTB     '7'           OneByte                  99
    //*   *IN99         IFEQ      '1'
    if (%bitand(fileDefHd.Qaaf2H: x'01') = x'01');
      keyl0100.apriky = 'P';                                          // primary key
    else;
      //  Bit 0   - Qdbfpkey - primary key
      //*                 EVAL      *in98 = %bitand(Qaaf2L: x'80') = x'80'
      //*                 EVAL      OneByte = Qaaf2L                             Key statement
      //*                 BITOFF    '1234567'     OneByte
      //*                 TESTB     '0'           OneByte                  99
      //*   *IN99         IFEQ      '1'
      if (%bitand(fileDefHd.Qaaf2L: x'80') = x'80');
        keyl0100.apriky = 'U';                                       // unique constr
      else;
        keyl0100.apriky = 'N';                                       // keine
      endif;
    endif;

    //------------------------------------------*
    //  Schlüsselfeldattribute:                 *
    //------------------------------------------*
    //  Bit 0   - Qdbfksad - Ascending/Descending indicator
    //*                 EVAL      *in98 = %bitand(Qdbfksq: x'80') = x'80'
    //*                 EVAL      OneByte = Qdbfksq                            Key statement
    //*                 BITOFF    '1234567'     OneByte
    //*                 TESTB     '0'           OneByte                  99
    //*   *IN99         IFEQ      '1'
    if (%bitand(keySpecAy.Qdbfksq: x'80') = x'80');
      keyl0100.apkseq = 'D';                                          // Descending
    else;
      keyl0100.apkseq = 'A';                                          // Ascending
    endif;
    //  Bit 1/2 - Qdbfksn  - Numeric key field seq. indicator
    //*                 EVAL      OneByte = Qdbfksq                            Key statement
    //*                 BITOFF    '034567'      OneByte

    select;
    //*   OneByte       WHENEQ    x'00'
    when (keySpecAy.Qdbfksq = x'00');
      keyl0100.apksin = 'N';                                          // Unsigned
    //*   OneByte       WHENEQ    x'20'
    when (keySpecAy.Qdbfksq = x'20');
      keyl0100.apksin = 'A';                                          // AbsVal
    //*   OneByte       WHENEQ    x'40'
    when (keySpecAy.Qdbfksq = x'40');
      keyl0100.apksin = 'S';                                          // Signed
    other;
      keyl0100.apksin = '?';                                          // unknown
    endsl;
    //  Bit 3   - Reserved_60
    //  Bit 4   - Qdbfksac - Alternate collating seq. indicator
    //*                 EVAL      *in98 = %bitand(Qdbfksq: x'08') = x'08'
    //*                 EVAL      OneByte = Qdbfksq                            Key statement
    //*                 BITOFF    '0123567'     OneByte
    //*                 TESTB     '4'           OneByte                  99
    //*   *IN99         IFEQ      '1'
    if (%bitand(keySpecAy.Qdbfksq: x'08') = x'08');
      keyl0100.apkasq = 'Y';                                          // altern. seq.
    else;
      keyl0100.apkasq = 'N';                                          // no alt. seq.
    endif;
    //  Bit 5   - Qdbfkszf - Force zone  seq. indicator
    //*                 EVAL      *in98 = %bitand(Qdbfksq: x'04') = x'04'
    //*                 EVAL      OneByte = Qdbfksq                            Key statement
    //*                 BITOFF    '0123467'     OneByte
    //*                 TESTB     '5'           OneByte                  99
    //*   *IN99         IFEQ      '1'
    if (%bitand(keySpecAy.Qdbfksq: x'04') = x'04');
      keyl0100.apkzd = 'Z';                                           // Zone
    else;
      //  Bit 6   - Qdbfksdf - Force digit seq. indicator
      //*                 EVAL      *in98 = %bitand(Qdbfksq: x'02') = x'02'
      //*                 EVAL      OneByte = Qdbfksq                            Key statement
      //*                 BITOFF    '0123457'     OneByte
      //*                 TESTB     '6'           OneByte                  99
      //*   *IN99         IFEQ      '1'
      if (%bitand(keySpecAy.Qdbfksq: x'02') = x'02');
        keyl0100.apkzd = 'D';                                        // Digit
      else;
        keyl0100.apkzd = 'N';                                        // None
      endif;
    endif;
    //  Bit 7   - Qdbfkft  - external / internal name indicator
    //*                 EVAL      *in98 = %bitand(Qdbfksq: x'01') = x'01'
    //*                 EVAL      OneByte = Qdbfksq                            Key statement
    //*                 BITOFF    '0123456'     OneByte
    //*                 TESTB     '7'           OneByte                  99
    //*   *IN99         IFEQ      '1'
    if (%bitand(keySpecAy.Qdbfksq: x'01') = x'01');
    //**                EVAL      'E'     z.Z. kein Feld vorhanden             external
    else;
    //**                EVAL      'I'     z.Z. kein Feld vorhanden             internal
    endif;

    o_data = keyl0100;
    o_nbrOfEnt = PosOfKeyFd + 1;
    //  pointer to next field
    PosOfKeyFd = PosOfKeyFd + 1;
  else;
    o_nbrOfEnt = *zeros;
    o_data = *blanks;
  endif;

endsr;

//====================================================*
//  SELECT --  set pointer to matching                *
//             file scope entry of select & omit      *
//====================================================*

begsr select;

  exsr FindRcdFmt;
  if (IsFound = bTrue);
    //  store number of select/omit statements ...
    NbrOfSlOm = fileScope.Qdbfsoon;
    PosOfSlOm = *zeros;
  else;
    //  no select/omit statements found ...
    NbrOfSlOm = *zeros;
    PosOfSlOm = *hival;
  endif;

  o_nbrOfEnt = NbrOfSlOm;

endsr;

//====================================================*
//  ReadSelect  read select/omit one by one           *
//====================================================*

begsr ReadSelect;

  if (PosOfSlOm < NbrOfSlOm);

    //  Set pointer to select/omit specification entry
    Offset = PosOfSlOm * %size(selSpecAy);
    Offset = Offset + fileScope.Qdbfsoof;

    pSelspecay = %addr(rcvVarTab(Offset + 1));

    clear sell0100;

    sell0100.sorcen = fild0100.atrcen;    //  Jahrhundert
    sell0100.sordat = fild0100.atrdat;    //  Datum
    sell0100.sortim = fild0100.atrtim;    //  Uhrzeit
    sell0100.sofile = fild0100.atfile;    //  Datei
    sell0100.solib = fild0100.atlib;      //  Bibliothek
    sell0100.softyp = fild0100.atftyp;    //  Dateiart
    sell0100.sofila = fild0100.atfila;    //  Dateiattribut
    sell0100.somxd = '';                  //  Reserviert
    sell0100.sofatr = fild0100.atfatr;    //  Dateiattribut
    sell0100.sosysn = fild0100.atsysn;    //  Systemname
    sell0100.soasp = fild0100.atasp;      //  ASP Zusatzspeicher
    sell0100.sores = '';                  //  Reserviert
    sell0100.sonrul = NbrOfSlOm;          //  Anzahl SELECT/OMIT Regeln
    sell0100.sorfmt = fileScope.Qdbft;    //  Satzformat
    sell0100.sorule = selSpecAy.Qdbfssso; //  SELECT/OMIT Regel
    sell0100.socomp = selSpecAy.Qdbfssop; //  Vergleichoperator, z.B.:  EQ,NE,AL

    //  Wenn SELECT/OMIT-Parameter vorhanden sind, ...
    if (selSpecAy.Qdbfsoso <= 0);
    // ... es sind aber keine vorhanden
    else;
      // ... dann diese ermitteln und zurückliefern

      // ... Feldname
      sell0100.sofld = selSpecAy.Qdbfssfn;
      //      ... SELECT/OMIT Anzahl Vergleichswerte
      sell0100.sonval = selSpecAy.Qdbfsspnum;

      // ... Zeiger auf den ersten Wert setzen ...
      Offset = selSpecAy.Qdbfsoso;
      pSelparmay = %addr(rcvVarTab(Offset + 1));

      // ...  ermitteln SELECT/OMIT Wert und Wertlänge
      dow ('1');

        LenOfSlOm = selParmAy.Qdbfspln - 20;

        if (LenOfSlOm >= 1
            and LenOfSlOm <= 32);
          r_valu =
           %subst(selParmAy.Qdbfspvl: 1: LenOfSlOm);
        else;
          r_valu = '';
        endif;

        // ... SELECT/OMIT Wert
        if (sell0100.sovalu = '');
          sell0100.sovalu = r_valu;
        else;
          sell0100.sovalu =
           %trimr(sell0100.sovalu) + ' ' + r_valu;
        endif;
        // ... SELECT/OMIT Wertlänge
        sell0100.sovall = LenOfSlOm;

        // ... wenn weitere Werte vorhanden sind, ...
        if (selParmAy.Qdbfspno <> 0);
          //          ... dann den Zeiger auf den nächsten Wert ausrichten
          Offset = selParmAy.Qdbfspno;
          pSelparmay = %addr(rcvVarTab(Offset + 1));
        else;
          // ... ansonsten die Verarbeitung beenden
          leave;
        endif;

      enddo;

      //  DYNSLT
      sell0100.sodyns = *blanks;
      //  JREF Field
      sell0100.sofjvl = selSpecAy.Qdbfssfj;
      //  JREF Parameter
      sell0100.sopjvl = *zeros;
    endif;

    o_data = sell0100;

    o_nbrOfEnt = PosOfSlOm + 1;
    //  pointer to next field
    PosOfSlOm = PosOfSlOm + 1;
  else;
    o_nbrOfEnt = *zeros;
    o_data = *blanks;
  endif;

endsr;

//====================================================*
//  ReadText--  read description of file              *
//====================================================*

begsr ReadText;

  //  Textbeschreibung
  o_data = fild0100.attxt;
  //*   ' '           CHECKR    XData         XPos
  XPos = %checkr(' ': o_data);
  o_nbrOfEnt = XPos;

endsr;

//====================================================*
//  FindRcdFmt  find matching record format           *
//====================================================*

begsr FindRcdFmt;

  IsFound = bFalse;
  Offset = fileDefHd.Qdbfos;
  Counter = fileDefHd.Qdbflbnum;

  dow (Counter > 0);
    pFilescpay = %addr(rcvVarTab(Offset + 1));

    if (fileScope.Qdbft = i_rcdFmt or
        i_rcdFmt = '*FIRST');
      //  Record format generic key field count ...
      IsFound = bTrue;
      leave;
    else;
      //  No matching record format found ...
      Offset = Offset + %size(fileScope);
      IsFound = bFalse;
    endif;
    Counter = Counter - 1;
  enddo;

endsr;

//====================================================*
//  FindMbr     find member by number                 *
//====================================================*

begsr FindMbr;

  if (mbrNbr < 1 or mbrNbr > fileDefHd.Qdbflbnum);
    IsFound = bFalse;
  else;
    Offset = fileDefHd.Qdbfos + ((mbrNbr -1) * %size(fileScope));
    pFilescpay = %addr(rcvVarTab(Offset + 1));
    IsFound = bTrue;
  endif;

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

