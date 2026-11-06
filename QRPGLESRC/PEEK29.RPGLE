**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 1.4.0                               *
//  Programm : PEEK29                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 03.11.97  Raddatz                                 *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Berechnen der Lizenznummer                                   *
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
/copy QCOPYLE,SDS
/copy QCOPYLE,CEECNDHDLR

/define internal_prototype
/copy QCOPYLE,PPEEK29
/undefine internal_prototype

dcl-s value char(1) dim(256);
dcl-s hex char(1) dim(16);

dcl-ds SysInpNbr qualified;
  SysName   char(8) inz;
  SysVers   char(6) inz;
  SysSrlNbr char(8) inz;
  SysEON    char(1) inz(x'00');
end-ds;

dcl-s x like(int4_t);
dcl-s y like(int4_t);
dcl-s a1 char(1);
dcl-s Summe packed(30);
dcl-s Rest packed(30);
dcl-s zw1 packed(30);
dcl-s zw2 packed(30);

//  Konvertierung HEX ==> DEC
dcl-s R_Dec packed(30);
dcl-s R_Hex char(20);

dcl-s IntSrlNbr char(20);

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek29;
  i_sysName    char(8) const;
  i_sysVersion char(6) const;
  i_sysSrlNbr  char(8) const;
  i_sysDate    int(10) const;
  o_serialNbr  char(20);
end-pi;

//----------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

// -  Systemname des AS/400 Systems
SysInpNbr.SysName = i_sysName;

// -  PEEK-Versionsnummer
SysInpNbr.SysVers = i_sysVersion;

// -  Seriennummer des AS/400 Systems
SysInpNbr.SysSrlNbr = i_sysSrlNbr;

//  - Berechnung der Prüfsumme
Summe = *zeros;

for x = 1 to 50;
  //*   1             SUBST     SysInpNbr:X   A1
  a1 = %subst(SysInpNbr: x: 1);
  if (a1 = x'00');
    leave;
  endif;

  y = 1;
  y = %lookup(a1: value);
  if (y > 0);
    //    ... gefunden
    Summe = Summe + y;
  else;
  //    ... nicht gefunden
  //        (kann eigentlich nicht sein)
  endif;

  Summe = Summe + (x * 256);
endfor;

//  - Datum als Komplement
Summe = Summe - i_sysDate;
Summe = Summe + 99999999;

//  - Prüfsumme in HEX-Wert umsetzen
R_Dec = Summe;
exsr DecToHex;
IntSrlNbr = R_Hex;

IntSrlNbr = %trimr(IntSrlNbr) + '-';

//  - Originaldatum anfügen, als Komplement gespeichert!
R_Dec = 0 - i_sysDate;
R_Dec = R_Dec + 99999999;
exsr DecToHex;
IntSrlNbr = %trimr(IntSrlNbr) + R_Hex;

o_serialNbr = IntSrlNbr;

return;

//============================================================*
//    DecToHex      Konvertieren Decimal ==> Hex              *
//============================================================*

begsr DecToHex;

  R_Hex = *blanks;
  Rest = R_Dec;

  dou (R_Dec = 0);
    zw1 = R_Dec / 16;
    zw2 = zw1 * 16;
    Rest = R_Dec - zw2;

    Rest = Rest + 1;
    R_Hex = %trimr(hex(Rest)) + R_Hex;

    R_Dec = zw1;
  enddo;

endsr;

//====================================================*
//  InzSr --  Initialize program                      *
//====================================================*

begsr inzsr;

  if (isInzSr = bTrue);
    leavesr;
  endif;

  isInzSr = bTrue;

  value(193) = 'A';
  value(194) = 'B';
  value(195) = 'C';
  value(196) = 'D';
  value(197) = 'E';
  value(198) = 'F';
  value(199) = 'G';
  value(200) = 'H';
  value(201) = 'I';

  value(209) = 'J';
  value(210) = 'K';
  value(211) = 'L';
  value(212) = 'M';
  value(213) = 'N';
  value(214) = 'O';
  value(215) = 'P';
  value(216) = 'Q';
  value(217) = 'R';

  value(226) = 'S';
  value(227) = 'T';
  value(228) = 'U';
  value(229) = 'V';
  value(230) = 'W';
  value(231) = 'X';
  value(232) = 'Y';
  value(233) = 'Z';

  value(240) = '0';
  value(241) = '1';
  value(242) = '2';
  value(243) = '3';
  value(244) = '4';
  value(245) = '5';
  value(246) = '6';
  value(247) = '7';
  value(248) = '8';
  value(249) = '9';

  hex(1) = '0';
  hex(2) = '1';
  hex(3) = '2';
  hex(4) = '3';
  hex(5) = '4';
  hex(6) = '5';
  hex(7) = '6';
  hex(8) = '7';
  hex(9) = '8';
  hex(10) = '9';
  hex(11) = 'A';
  hex(12) = 'B';
  hex(13) = 'C';
  hex(14) = 'D';
  hex(15) = 'E';
  hex(16) = 'F';

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

