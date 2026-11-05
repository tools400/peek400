**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 2.2.0                               *
//  Programm : PEEK33                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 19.12.1997  Raddatz                               *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Aktualisierungen beim Versionswechsel                        *
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
/COPY QCOPYLE,H_SPEC
/COPY QCOPYLE,COPYRIGHT

/COPY QCOPYLE,D_VARDEF
/COPY QCOPYLE,D_COLORATR
/COPY QCOPYLE,SDS
/COPY QCOPYLE,CEECNDHDLR

/COPY QCOPYLE,SET0001                    // Benutzervoreinstellungen
/COPY QCOPYLE,SET0007                    // Versionsnummer
/COPY QCOPYLE,SET0012                    // Generieren Programme *CRTPGM
/COPY QCOPYLE,SET0016                    // SQL: Limit zum Anzeigen der Anzahl Datensät

/define internal_prototype
/COPY QCOPYLE,PPEEK33
/undefine internal_prototype

/COPY QCOPYLE,PPEEK53

dcl-ds set0007  likeds(set0007_t) inz;
dcl-ds set0012  likeds(set0012_t) inz;
dcl-ds set0016  likeds(set0016_t) inz;

//  Vor V3.0.0
dcl-ds set0012_alt qualified;
  //  Kleinbuchstaben erlaubt: 1=Ja; 0=Nein
  set_alwlc       char(10) inz('1');
  //  Standardmäßig Klienbuchstaben: 1=Ja; 0=Nein
  set_case        char(10) inz('0');
  //  Endemarkierung
  set_0012        char(1) inz(x'8B');
end-ds;

dcl-s x               like(int4_t) inz;

dcl-ds wrktabds qualified;
  remark          char(5) inz(*blanks);
  section         char(10) inz(*blanks);
  key             char(10) inz(*blanks);
  data            like(set0000_t) inz(*blanks);
end-ds;

dcl-ds set0001        likeds(set0001_t) inz;

dcl-s o_data          like(set0000_t) inz;

dcl-s wrktab          char(100) dim(100) inz(*blanks);
dcl-s wrkelem         like(int4_t) inz;

dcl-s tb010100        char(100) dim( 58) ctdata perrcd(1);
dcl-c elm010100 const(%elem(tb010100));

dcl-s tb010200        char(100) dim( 36) ctdata perrcd(1);
dcl-c elm010200 const(%elem(tb010200));

dcl-s tb010300        char(100) dim( 12) ctdata perrcd(1);
dcl-c elm010300 const(%elem(tb010300));

dcl-s tb010400        char(100) dim( 42) ctdata perrcd(1);
dcl-c elm010400 const(%elem(tb010400));

dcl-s tb010500        char(100) dim( 52) ctdata perrcd(1);
dcl-c elm010500 const(%elem(tb010500));

dcl-s tb020000        char(100) dim( 34) ctdata perrcd(1);
dcl-c elm020000 const(%elem(tb020000));

dcl-s tb020100        char(100) dim( 40) ctdata perrcd(1);
dcl-c elm020100 const(%elem(tb020100));

dcl-s tb020200        char(100) dim( 30) ctdata perrcd(1);
dcl-c elm020200 const(%elem(tb020200));

dcl-s tb030000        char(100) dim( 22) ctdata perrcd(1);
dcl-c elm030000 const(%elem(tb030000));

dcl-s tb030100        char(100) dim(  4) ctdata perrcd(1);
dcl-c elm030100 const(%elem(tb030100));

dcl-s tb030101        char(100) dim( 24) ctdata perrcd(1);
dcl-c elm030101 const(%elem(tb030101));

dcl-s tb030205        char(100) dim( 26) ctdata perrcd(1);
dcl-c elm030205 const(%elem(tb030205));

dcl-s tb030401        char(100) dim(  4) ctdata perrcd(1);
dcl-c elm030401 const(%elem(tb030401));

dcl-s tb030500        char(100) dim(  4) ctdata perrcd(1);
dcl-c elm030500 const(%elem(tb030500));

dcl-s tb040001        char(100) dim( 16) ctdata perrcd(1);
dcl-c elm040001 const(%elem(tb040001));

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************

dcl-pi peek33;
  i_version       const like(version_t);
  o_msgid               like(msgid_t);
  o_msgdta              like(msgdta_t);
end-pi;

//----------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

o_msgid = '';
o_msgdta = '';

//  Ermitteln der abgespeicherten Versions-Nr. ...
exsr getUsrSetg;

//  Vergleichen mit jetziger Versions-Nr. ...
if (set0007.set_vsn <> i_version);
  //  ... und bei Abweichungen den
  //      Aktualisierungsvorgang starten
  exsr vpos;
else;
endif;

*inlr = '1';

//============================================================*
//    VPos          Durchführen der Aktualisierungsarbeiten   *
//============================================================*

begsr vpos;

  //  Schleife solabge durchlaufen, bis das
  //  der jetzige Versionsstand erreicht worden ist.
  dow (set0007.set_vsn <= i_version);

    //  ... aktualiseren der früheren Versionsstände
    select;
    when (set0007.set_vsn < 'V01R01M00');
      exsr v01r01m00;
    when (set0007.set_vsn < 'V01R02M00');
      exsr v01r02m00;
    when (set0007.set_vsn < 'V01R03M00');
      exsr v01r03m00;
    when (set0007.set_vsn < 'V01R04M00');
      exsr v01r04m00;
    when (set0007.set_vsn < 'V01R05M00');
      exsr v01r05m00;
    when (set0007.set_vsn < 'V01R05M01');
      exsr v01r05m01;
    when (set0007.set_vsn < 'V02R00M00');
      exsr v02r00m00;
    when (set0007.set_vsn < 'V02R01M00');
      exsr v02r01m00;
    when (set0007.set_vsn < 'V02R01M01');
      exsr v02r01m01;
    when (set0007.set_vsn < 'V02R02M00');
      exsr v02r02m00;
    when (set0007.set_vsn < 'V02R02M01');
      exsr v02r02m01;
    when (set0007.set_vsn < 'V02R02M02');
      exsr v02r02m02;
    when (set0007.set_vsn < 'V02R03M00');
      exsr v02r03m00;
    when (set0007.set_vsn < 'V02R03M01');
      exsr v02r03m01;
    when (set0007.set_vsn < 'V02R03M02');
      exsr v02r03m02;
    when (set0007.set_vsn < 'V02R04M00');
      exsr v02r04m00;
    when (set0007.set_vsn < 'V02R04M01');
      exsr v02r04m01;
    when (set0007.set_vsn < 'V02R04M02');
      exsr v02r04m02;
    when (set0007.set_vsn < 'V03R00M00');
      exsr v03r00m00;
    when (set0007.set_vsn < 'V03R01M00');
      exsr v03r01m00;
    when (set0007.set_vsn < 'V03R01M01');
      exsr v03r01m01;
    when (set0007.set_vsn < 'V03R01M02');
      exsr v03r01m02;
    when (set0007.set_vsn < 'V03R01M03');
      exsr v03r01m03;
    when (set0007.set_vsn < 'V03R01M04');
      exsr v03r01m04;
    when (set0007.set_vsn < 'V03R01M05');
      exsr v03r01m05;
    when (set0007.set_vsn < 'V03R01M06');
      exsr v03r01m06;
    when (set0007.set_vsn < 'V03R02M00');
      exsr v03r02m00;
    when (set0007.set_vsn < 'V03R02M01');
      exsr v03r02m01;
    when (set0007.set_vsn < 'V03R02M02');
      exsr v03r02m02;
    when (set0007.set_vsn < 'V03R02M03');
      exsr v03r02m03;
    when (set0007.set_vsn < 'V03R02M04');
      exsr v03r02m04;
    when (set0007.set_vsn < 'V03R02M05');
      exsr v03r02m05;
    when (set0007.set_vsn < 'V03R02M06');
      exsr v03r02m06;
    when (set0007.set_vsn < 'V03R03M00');
      exsr v03r03m00;
    when (set0007.set_vsn < 'V03R03M01');
      exsr v03r03m01;
    when (set0007.set_vsn < 'V03R03M02');
      exsr v03r03m02;
    when (set0007.set_vsn < 'V03R03M03');
      exsr v03r03m03;
    when (set0007.set_vsn < 'V03R04M00');
      exsr v03r04m00;
    when (set0007.set_vsn < 'V03R04M01');
      exsr v03r04m01;
    when (set0007.set_vsn < 'V03R04M02');
      exsr v03r04m02;
    when (set0007.set_vsn < 'V03R04M03');
      exsr v03r04m03;
    when (set0007.set_vsn < 'V03R05M00');
      exsr v03r05m00;
    when (set0007.set_vsn < 'V03R05M01');
      exsr v03r05m01;
    when (set0007.set_vsn < 'V03R05M02');
      exsr v03r05m02;
    when (set0007.set_vsn < 'V03R05M03');
      exsr v03r05m03;
    when (set0007.set_vsn < 'V03R05M04');
      exsr v03r05m04;
    when (set0007.set_vsn < 'V03R05M05');
      exsr v03r05m05;
    when (set0007.set_vsn < 'V03R05M06');
      exsr v03r05m06;
    when (set0007.set_vsn < 'V03R05M07');
      exsr v03r05m07;
    when (set0007.set_vsn < 'V03R05M08');
      exsr v03r05m08;
    when (set0007.set_vsn < 'V04R00M01');
      exsr v04r00m01;
    when (set0007.set_vsn < 'V04R00M02');
      exsr v04r00m02;
    when (set0007.set_vsn < 'V04R00M03');
      exsr v04r00m03;
    when (set0007.set_vsn < 'V04R00M04');
      exsr v04r00m04;
    when (set0007.set_vsn < 'V04R00M05');
      exsr v04r00m05;
    when (set0007.set_vsn < 'V04R00M06');
      exsr v04r00m06;
    when (set0007.set_vsn < 'V04R00M07');
      exsr v04r00m07;
    when (set0007.set_vsn < 'V04R00M08');
      exsr v04r00m08;
    other;
      //  ... kein weiterer Schritt: aktuelle Versions-Nr. speichern
      set0007.set_vsn = i_version;
      exsr setUsrSetg;
      leave;
    endsl;

    //  ... Abspeichern der neuen Versions-Nr.
    exsr setUsrSetg;
  enddo;

endsr;

//============================================================*
//    V01R01M00     Aktualisierung auf Version 1.1.0          *
//============================================================*

begsr v01r01m00;

  wrktab = %subarr(tb010100: 1);
  wrkelem = elm010100;
  exsr updPeekUsr;

  set0007.set_vsn = 'V01R01M00';

endsr;

//============================================================*
//    V01R02M00     Aktualisierung auf Version 1.2.0          *
//============================================================*

begsr v01r02m00;

  wrktab = %subarr(tb010200: 1);
  wrkelem = elm010200;
  exsr updPeekUsr;

  set0007.set_vsn = 'V01R02M00';

endsr;

//============================================================*
//    V01R03M00     Aktualisierung auf Version 1.3.0          *
//============================================================*

begsr v01r03m00;

  wrktab = %subarr(tb010300: 1);
  wrkelem = elm010300;
  exsr updPeekUsr;

  set0007.set_vsn = 'V01R03M00';

endsr;

//============================================================*
//    V01R04M00     Aktualisierung auf Version 1.4.0          *
//============================================================*

begsr v01r04m00;

  wrktab = %subarr(tb010400: 1);
  wrkelem = elm010400;
  exsr updPeekUsr;

  set0007.set_vsn = 'V01R04M00';

endsr;

//============================================================*
//    V01R05M00     Aktualisierung auf Version 1.5.0          *
//============================================================*

begsr v01r05m00;

  wrktab = %subarr(tb010500: 1);
  wrkelem = elm010500;
  exsr updPeekUsr;

  set0007.set_vsn = 'V01R05M00';

endsr;

//============================================================*
//    V01R05M01     Aktualisierung auf Version 1.5.1          *
//============================================================*

begsr v01r05m01;

  set0007.set_vsn = 'V01R05M01';

endsr;

//============================================================*
//    V02R00M00     Aktualisierung auf Version 2.0.0          *
//============================================================*

begsr v02r00m00;

  wrktab = %subarr(tb020000: 1);
  wrkelem = elm020000;
  exsr updPeekUsr;

  set0007.set_vsn = 'V02R00M00';

endsr;

//============================================================*
//    V02R01M00     Aktualisierung auf Version 2.1.0          *
//============================================================*

begsr v02r01m00;

  wrktab = %subarr(tb020100: 1);
  wrkelem = elm020100;
  exsr updPeekUsr;

  set0007.set_vsn = 'V02R01M00';

endsr;

//============================================================*
//    V02R01M01     Aktualisierung auf V02R01M01              *
//============================================================*

begsr v02r01m01;

  set0007.set_vsn = 'V02R01M01';

endsr;

//============================================================*
//    V02R02M00     Aktualisierung auf Version 2.2.0          *
//============================================================*

begsr v02r02m00;

  wrktab = %subarr(tb020200: 1);
  wrkelem = elm020200;
  exsr updPeekUsr;

  set0007.set_vsn = 'V02R02M00';

endsr;

//============================================================*
//    V02R02M01     Aktualisierung auf Version 2.2.1          *
//============================================================*

begsr v02r02m01;

  set0007.set_vsn = 'V02R02M01';

endsr;

//============================================================*
//    V02R02M02     Aktualisierung auf Version 2.2.2          *
//============================================================*

begsr v02r02m02;

  set0007.set_vsn = 'V02R02M02';

endsr;

//============================================================*
//    V02R03M00     Aktualisierung auf Version 2.3.0          *
//============================================================*

begsr v02r03m00;

  set0007.set_vsn = 'V02R03M00';

endsr;

//============================================================*
//    V02R03M01     Aktualisierung auf Version 2.3.1          *
//============================================================*

begsr v02r03m01;

  set0007.set_vsn = 'V02R03M01';

endsr;

//============================================================*
//    V02R03M02     Aktualisierung auf Version 2.3.1          *
//============================================================*

begsr v02r03m02;

  set0007.set_vsn = 'V02R03M02';

endsr;

//============================================================*
//    V02R04M00     Aktualisierung auf Version 2.4.0          *
//============================================================*

begsr v02r04m00;

  set0007.set_vsn = 'V02R04M00';

endsr;

//============================================================*
//    V02R04M01     Aktualisierung auf Version 2.4.1          *
//============================================================*

begsr v02r04m01;

  set0007.set_vsn = 'V02R04M01';

endsr;

//============================================================*
//    V02R04M02     Aktualisierung auf Version 2.4.2          *
//============================================================*

begsr v02r04m02;

  set0007.set_vsn = 'V02R04M02';

endsr;

//============================================================*
//    V03R00M00     Aktualisierung auf Version 3.0.0          *
//============================================================*

begsr v03r00m00;

  wrktab = %subarr(tb030000: 1);
  wrkelem = elm030000;
  exsr updPeekUsr;

  set0007.set_vsn = 'V03R00M00';

  //  Umsetzen Datenstruktur "Generieren Programme" (*CRTPGM, SET0012)
  set0012_alt = f_getusrsg('*CRTPGM');

  if (set0012_alt.set_alwlc = '0' or
     set0012_alt.set_alwlc = '1'   ) and
     (set0012_alt.set_case  = '0' or
     set0012_alt.set_case  = '1'   ) and
     (set0012_alt.set_0012  = x'8B' );
    reset set0012;
    set0012.set_alwlc = set0012_alt.set_alwlc;
    set0012.set_case  = set0012_alt.set_case;
    set0012.set_0012  = set0012_alt.set_0012;
    p_updusrsg('*CRTPGM': set0012);
  endif;

endsr;

//============================================================*
//    V03R01M00     Aktualisierung auf Version 3.1.0          *
//============================================================*

begsr v03r01m00;

  wrktab = %subarr(tb030100: 1);
  wrkelem = elm030100;
  exsr updPeekUsr;

  set0007.set_vsn = 'V03R01M00';

endsr;

//============================================================*
//    V03R01M01     Aktualisierung auf Version 3.1.1          *
//============================================================*

begsr v03r01m01;

  wrktab = %subarr(tb030101: 1);
  wrkelem = elm030101;
  exsr updPeekUsr;

  set0007.set_vsn = 'V03R01M01';

endsr;

//============================================================*
//    V03R01M02     Aktualisierung auf Version 3.1.2          *
//============================================================*

begsr v03r01m02;

  set0007.set_vsn = 'V03R01M02';

endsr;

//============================================================*
//    V03R01M03     Aktualisierung auf Version 3.1.3          *
//============================================================*

begsr v03r01m03;

  set0007.set_vsn = 'V03R01M03';

endsr;

//============================================================*
//    V03R01M04     Aktualisierung auf Version 3.1.4          *
//============================================================*

begsr v03r01m04;

  set0007.set_vsn = 'V03R01M04';

endsr;

//============================================================*
//    V03R01M05     Aktualisierung auf Version 3.1.5          *
//============================================================*

begsr v03r01m05;

  set0007.set_vsn = 'V03R01M05';

endsr;

//============================================================*
//    V03R01M06     Aktualisierung auf Version 3.1.6          *
//============================================================*

begsr v03r01m06;

  set0007.set_vsn = 'V03R01M06';

endsr;

//============================================================*
//    V03R02M00     Aktualisierung auf Version 3.2.0          *
//============================================================*

begsr v03r02m00;

  set0007.set_vsn = 'V03R02M00';

endsr;

//============================================================*
//    V03R02M01     Aktualisierung auf Version 3.2.1          *
//============================================================*

begsr v03r02m01;

  set0007.set_vsn = 'V03R02M01';

  //  Eintragen Art und Weise der Umsetzung von Edit Codes in der Subfile:
  set0001 = f_getusrsg('*DSPATTR');

  if (set0001.set_dspsgn <> '2');
    set0001.set_dspsgn   = '2';
    p_updusrsg('*DSPATTR': set0001);
  endif;

endsr;

//============================================================*
//    V03R02M02     Aktualisierung auf Version 3.2.2          *
//============================================================*

begsr v03r02m02;

  set0007.set_vsn = 'V03R02M02';

  //  Ändern Default Edit Code von 'J' auf 'L'
  set0001 = f_getusrsg('*DSPATTR');

  if (set0001.set_editcode = 'J');
    set0001.set_editcode = 'L';
    set0001.set_dspsgn   = '2';
    p_updusrsg('*DSPATTR': set0001);
  endif;

endsr;

//============================================================*
//    V03R02M03     Aktualisierung auf Version 3.2.3          *
//============================================================*

begsr v03r02m03;

  set0007.set_vsn = 'V03R02M03';

endsr;

//============================================================*
//    V03R02M04     Aktualisierung auf Version 3.2.4          *
//============================================================*

begsr v03r02m04;

  set0007.set_vsn = 'V03R02M04';

endsr;

//============================================================*
//    V03R02M05     Aktualisierung auf Version 3.2.5          *
//============================================================*

begsr v03r02m05;

  wrktab = %subarr(tb030205: 1);
  wrkelem = elm030205;
  exsr updPeekUsr;

  set0007.set_vsn = 'V03R02M05';

endsr;

//============================================================*
//    V03R02M06     Aktualisierung auf Version 3.2.6          *
//============================================================*

begsr v03r02m06;

  set0007.set_vsn = 'V03R02M06';

endsr;

//============================================================*
//    V03R03M00     Aktualisierung auf Version 3.3.0          *
//============================================================*

begsr v03r03m00;

  set0007.set_vsn = 'V03R03M00';

endsr;

//============================================================*
//    V03R03M01     Aktualisierung auf Version 3.3.1          *
//============================================================*

begsr v03r03m01;

  set0007.set_vsn = 'V03R03M01';

endsr;

//============================================================*
//    V03R03M02     Aktualisierung auf Version 3.3.2          *
//============================================================*

begsr v03r03m02;

  set0007.set_vsn = 'V03R03M02';

endsr;

//============================================================*
//    V03R03M03     Aktualisierung auf Version 3.3.3          *
//============================================================*

begsr v03r03m03;

  set0007.set_vsn = 'V03R03M03';

endsr;

//============================================================*
//    V03R04M00     Aktualisierung auf Version 3.4.0          *
//============================================================*

begsr v03r04m00;

  set0007.set_vsn = 'V03R04M00';

endsr;

//============================================================*
//    V03R04M01     Aktualisierung auf Version 3.4.1          *
//============================================================*

begsr v03r04m01;

  wrktab = %subarr(tb030401: 1);
  wrkelem = elm030401;
  exsr updPeekUsr;

  set0007.set_vsn = 'V03R04M01';

endsr;

//============================================================*
//    V03R04M02     Aktualisierung auf Version 3.4.2          *
//============================================================*

begsr v03r04m02;

  set0007.set_vsn = 'V03R04M02';

endsr;

//============================================================*
//    V03R04M03     Aktualisierung auf Version 3.4.3          *
//============================================================*

begsr v03r04m03;

  set0007.set_vsn = 'V03R04M03';

endsr;

//============================================================*
//    V03R05M00     Aktualisierung auf Version 3.5.0          *
//============================================================*

begsr v03r05m00;

  wrktab = %subarr(tb030500: 1);
  wrkelem = elm030500;
  exsr updPeekUsr;

  set0007.set_vsn = 'V03R05M00';

  //  Anlegen Einstellung für max. Anzahl Sätze für SQL-COUNT()
  set0016 = f_getusrsg('*SQLLMTCNT');

endsr;

//============================================================*
//    V03R05M01     Aktualisierung auf Version 3.5.1          *
//============================================================*

begsr v03r05m01;

  set0007.set_vsn = 'V03R05M01';

endsr;

//============================================================*
//    V03R05M02     Aktualisierung auf Version 3.5.2          *
//============================================================*

begsr v03r05m02;

  set0007.set_vsn = 'V03R05M02';

endsr;

//============================================================*
//    V03R05M03     Aktualisierung auf Version 3.5.3          *
//============================================================*

begsr v03r05m03;

  set0007.set_vsn = 'V03R05M03';

endsr;

//============================================================*
//    V03R05M04     Aktualisierung auf Version 3.5.4          *
//============================================================*

begsr v03r05m04;

  set0007.set_vsn = 'V03R05M04';

endsr;

//============================================================*
//    V03R05M05     Aktualisierung auf Version 3.5.5          *
//============================================================*

begsr v03r05m05;

  set0007.set_vsn = 'V03R05M05';

endsr;

//============================================================*
//    V03R05M06     Aktualisierung auf Version 3.5.6          *
//============================================================*

begsr v03r05m06;

  set0007.set_vsn = 'V03R05M06';

endsr;

//============================================================*
//    V03R05M07     Aktualisierung auf Version 3.5.7          *
//============================================================*

begsr v03r05m07;

  set0007.set_vsn = 'V03R05M07';

endsr;

//============================================================*
//    V03R05M08     Aktualisierung auf Version 3.5.8          *
//============================================================*

begsr v03r05m08;

  set0007.set_vsn = 'V03R05M08';

endsr;

//============================================================*
//    V04R00M01     Aktualisierung auf Version 4.0.1          *
//============================================================*

begsr v04r00m01;

  wrktab = %subarr(tb040001: 1);
  wrkelem = elm040001;
  exsr updPeekUsr;

  set0007.set_vsn = 'V04R00M01';

endsr;

//============================================================*
//    V04R00M02     Aktualisierung auf Version 4.0.2          *
//============================================================*

begsr v04r00m02;

  set0007.set_vsn = 'V04R00M02';

endsr;

//============================================================*
//    V04R00M03     Aktualisierung auf Version 4.0.3          *
//============================================================*

begsr v04r00m03;

  set0007.set_vsn = 'V04R00M03';

endsr;

//============================================================*
//    V04R00M04     Aktualisierung auf Version 4.0.4          *
//============================================================*

begsr v04r00m04;

  set0007.set_vsn = 'V04R00M04';

endsr;

//============================================================*
//    V04R00M05     Aktualisierung auf Version 4.0.5          *
//============================================================*

begsr v04r00m05;

  set0007.set_vsn = 'V04R00M05';

endsr;

//============================================================*
//    V04R00M06     Aktualisierung auf Version 4.0.6          *
//============================================================*

begsr v04r00m06;

  set0007.set_vsn = 'V04R00M06';

endsr;

//============================================================*
//    V04R00M07     Aktualisierung auf Version 4.0.7          *
//============================================================*

begsr v04r00m07;

  set0007.set_vsn = 'V04R00M07';

endsr;

//============================================================*
//    V04R00M08     Aktualisierung auf Version 4.0.8          *
//============================================================*

begsr v04r00m08;

  set0007.set_vsn = 'V04R00M08';

endsr;

//============================================================*
//    UpdPeekUsr    Aktualisieren der PEEKUSR-Datei           *
//============================================================*

begsr updPeekUsr;

  for x = 1 to wrkelem;

    wrktabds = wrktab(x);

    *in11 = f_chainusr(wrktabds.section
                      : wrktabds.key: o_data);

    x = x + 1;

    //  Wenn der Datenbereich anders als erwartet
    //  belegt ist, ...
    if (o_data <> wrktabds.data);
      //  ... dann keine Änderung durchführen
      iter;
    else;
      //  ... ansonsten die Änderung vollziehen
      wrktabds = wrktab(x);
      if (*in11 = '1');
        f_writeusr(wrktabds.section
                  : wrktabds.key: wrktabds.data);
      else;
        f_updatusr(wrktabds.section
                  : wrktabds.key: wrktabds.data);
      endif;
    endif;

  endfor;

endsr;

//============================================================*
//    GetUsrSetg    Ermitteln der Versions-Nr.                *
//============================================================*

begsr getUsrSetg;

  //  *VERSION
  set0007 = f_getusrsg('*VERSION'  );

endsr;

//============================================================*
//    SetUsrSetg    Speichern der Versions-Nr.                *
//============================================================*

begsr setUsrSetg;

  //  *DSPATR
  p_updusrsg('*VERSION': set0007);

endsr;

//============================================================*
//  Program error handler                                     *
//============================================================*

dcl-proc errorhandler;
  dcl-pi *N;
    i_condtoken     value likeds(cee_fc_t);
    i_pcommarea     int(10) value;
    o_action        int(10);
    o_newcondtoken  likeds(cee_fc_t);
  end-pi;

  dump;
  o_action = cee_percolate;

end-proc;

**   Section---Schlüssel-Datenbereich-------------------------- Version 1.1.0 -----------
alt: *PEEK05   *F11
neu: *PEEK05   *F11      *LAYOUT
alt: *PEEK05   *F13      *USERSETG
neu: *PEEK05   *F13      *REPEAT
alt: *PEEK05   *F15
neu: *PEEK05   *F15      *USERSETG
alt: *PEEK05   *F19      *LEFT
neu: *PEEK05   *F19      *PAGELEFT
alt: *PEEK05   *F20      *RIGHT
neu: *PEEK05   *F20      *PAGERIGHT
alt: *PEEK05   X
neu: *PEEK05   X         *NEXTMARK
alt: *PEEK05   Y
neu: *PEEK05   Y         *PREVMARK
alt: *PEEK05   L
neu: *PEEK05   L         *LEFT
alt: *PEEK05   R
neu: *PEEK05   R         *RIGHT
alt: *PEEK05   RB
neu: *PEEK05   RB        *REBUILD
alt: *PEEK05   UR
neu: *PEEK05   UR        *CLRPINROW
alt: *PEEK05   UC
neu: *PEEK05   UC        *CLRPINCOL
alt: *PEEK34
neu: *PEEK34             *NONE
alt: *PEEK34   *F03
neu: *PEEK34   *F03      *SAVE_EXIT
alt: *PEEK34   *F05
neu: *PEEK34   *F05      *REFRESH
alt: *PEEK34   *F11
neu: *PEEK34   *F11      *FLOATKEYS
alt: *PEEK34   *F12
neu: *PEEK34   *F12      *CANCEL
alt: *PEEK34   *F24
neu: *PEEK34   *F24      *MOREKEYS
alt: *PEEK34   *ENTER
neu: *PEEK34   *ENTER    *ENTER
alt: *PEEK34   *PAGEUP
neu: *PEEK34   *PAGEUP   *PAGEUP
alt: *PEEK34   *PAGEDOWN
neu: *PEEK34   *PAGEDOWN *PAGEDOWN
alt: *PEEK37   *ENTER
neu: *PEEK37   *ENTER    *ENTER
alt: *PEEK37   *F03
neu: *PEEK37   *F03      *EXIT
alt: *PEEK37   *F05
neu: *PEEK37   *F05      *REFRESH
alt: *PEEK37   *F12
neu: *PEEK37   *F12      *CANCEL
alt: *PEEK37   *F24
neu: *PEEK37   *F24      *MOREKEYS
alt: *PEEK37   *PAGEUP
neu: *PEEK37   *PAGEUP   *PAGEUP
alt: *PEEK37   *PAGEDOWN
neu: *PEEK37   *PAGEDOWN *PAGEDOWN
alt: *PEEK37   1
neu: *PEEK37   1         *SELECT
**   Section---Schlüssel-Datenbereich-------------------------- Version 1.2.0 -----------
alt: *CMD      DM
neu: *CMD      DM        DSPMSG
alt: *CMD      EA
neu: *CMD      EA        EDTOBJAUT OBJ(&L/&F) OBJTYPE(*FILE)
alt: *CMD      FD
neu: *CMD      FD        DSPFD FILE(&L/&F)
alt: *CMD      JL
neu: *CMD      JL        DSPJOBLOG
alt: *CMD      SP
neu: *CMD      SP        WRKSPLF
alt: *CMD      WS
neu: *CMD      WS        WRKSBMJOB
alt: *PEEK05   *F09      *MOVETOP
neu: *PEEK05   *F09      *DSPDBR
alt: *PEEK05   S
neu: *PEEK05   S         *TGLACCESS
alt: *PEEK40   *ENTER
neu: *PEEK40   *ENTER    *ENTER
alt: *PEEK40   *F03
neu: *PEEK40   *F03      *EXIT
alt: *PEEK40   *F05
neu: *PEEK40   *F05      *REFRESH
alt: *PEEK40   *F12
neu: *PEEK40   *F12      *CANCEL
alt: *PEEK40   *F24
neu: *PEEK40   *F24      *MOREKEYS
alt: *PEEK40   *PAGEUP
neu: *PEEK40   *PAGEUP   *PAGEUP
alt: *PEEK40   *PAGEDOWN
neu: *PEEK40   *PAGEDOWN *PAGEDOWN
alt: *PEEK40   1
neu: *PEEK40   1         *SELECT
alt: *PXXXXXXXX*F17
neu: *PXXXXXXXX*F17      *TOP
alt: *PXXXXXXXX*F18
neu: *PXXXXXXXX*F18      *BOT
**   Section---Schlüssel-Datenbereich-------------------------- Version 1.3.0 -----------
alt: *PXXXXXXXX*F09
neu: *PXXXXXXXX*F09      *HEXEDIT
alt: *PEEK45   *F03
neu: *PEEK45   *F03      *EXIT
alt: *PEEK45   *F05
neu: *PEEK45   *F05      *REFRESH
alt: *PEEK45   *F12
neu: *PEEK45   *F12      *CANCEL
alt: *PEEK45   *F24
neu: *PEEK45   *F24      *MOREKEYS
alt: *PEEK45   *ENTER
neu: *PEEK45   *ENTER    *ENTER
**   Section---Schlüssel-Datenbereich-------------------------- Version 1.4.0 -----------
alt: *PEEK47   *ENTER
neu: *PEEK47   *ENTER    *ENTER
alt: *PEEK47   *F03
neu: *PEEK47   *F03      *EXIT
alt: *PEEK47   *F05
neu: *PEEK47   *F05      *REFRESH
alt: *PEEK47   *F12
neu: *PEEK47   *F12      *CANCEL
alt: *PEEK47   *F23
neu: *PEEK47   *F23      *MOREOPT
alt: *PEEK47   *F24
neu: *PEEK47   *F24      *MOREKEYS
alt: *PEEK47   *PAGEUP
neu: *PEEK47   *PAGEUP   *PAGEUP
alt: *PEEK47   *PAGEDOWN
neu: *PEEK47   *PAGEDOWN *PAGEDOWN
alt: *PEEK47   1
neu: *PEEK47   1         *SELECT
neu: *PEEK47
neu: *PEEK47             *NONE
alt: *PEEK05   *F04
neu: *PEEK05   *F04      *PROMPT
alt: *PEEK17   *F04
neu: *PEEK17   *F04      *PROMPT
neu: *PEEK37
neu: *PEEK37             *NONE
alt: *PEEK37   *F23
neu: *PEEK37   *F23      *MOREOPT
alt: *PEEK14   *F09
neu: *PEEK14   *F09      *HEXEDIT
alt: *PEEK49   *ENTER
neu: *PEEK49   *ENTER    *ENTER
alt: *PEEK49   *F03
neu: *PEEK49   *F03      *EXIT
alt: *PEEK49   *F05
neu: *PEEK49   *F05      *REFRESH
alt: *PEEK49   *F12
neu: *PEEK49   *F12      *CANCEL
alt: *PEEK49   *F24
neu: *PEEK49   *F24      *MOREKEYS
alt: *PEEK05   A
neu: *PEEK05   A         *ABOUT
**   Section---Schlüssel-Datenbereich-------------------------- Version 1.5.0 -----------
alt: *PEEK50
neu: *PEEK50             *NONE
alt: *PEEK50   *F03
neu: *PEEK50   *F03      *SAVE_EXIT
alt: *PEEK50   *F05
neu: *PEEK50   *F05      *REFRESH
alt: *PEEK50   *F12
neu: *PEEK50   *F12      *CANCEL
alt: *PEEK50   *F16
neu: *PEEK50   *F16      *SEARCH
alt: *PEEK50   *F17
neu: *PEEK50   *F17      *TOP
alt: *PEEK50   *F18
neu: *PEEK50   *F18      *BOT
alt: *PEEK50   *F22
neu: *PEEK50   *F22      *CLRALL
alt: *PEEK50   *F24
neu: *PEEK50   *F24      *MOREKEYS
alt: *PEEK50   *ENTER
neu: *PEEK50   *ENTER    *ENTER
alt: *PEEK50   *PAGEUP
neu: *PEEK50   *PAGEUP   *PAGEUP
alt: *PEEK50   *PAGEDOWN
neu: *PEEK50   *PAGEDOWN *PAGEDOWN
alt: *PEEK05   *F15      *USERSETG
neu: *PEEK05   *F15      *PINCOLDLG
alt: *PEEK05   ST
neu: *PEEK05   ST        *USERSETG
alt: *PEEK14   *F17
neu: *PEEK14   *F17      *TOP
alt: *PEEK14   *F18
neu: *PEEK14   *F18      *BOT
alt: *PEEK37   *F16
neu: *PEEK37   *F16      *SEARCH
alt: *PEEK37   *F17
neu: *PEEK37   *F17      *TOP
alt: *PEEK37   *F18
neu: *PEEK37   *F18      *BOT
alt: *PEEK34   *F16
neu: *PEEK34   *F16      *SEARCH
alt: *PEEK34   *F17
neu: *PEEK34   *F17      *TOP
alt: *PEEK34   *F18
neu: *PEEK34   *F18      *BOT
alt: *PEEK05   H
neu: *PEEK05   H         *TGLDSP
alt: *PEEK47   *F16
neu: *PEEK47   *F16      *SEARCH
alt: *PEEK47   *F17
neu: *PEEK47   *F17      *TOP
alt: *PEEK47   *F18
neu: *PEEK47   *F18      *BOT
**   Section---Schlüssel-Datenbereich-------------------------- Version 2.0.0 -----------
alt: *PEEK48   *ENTER
neu: *PEEK48   *ENTER    *ENTER
alt: *PEEK48   *F03
neu: *PEEK48   *F03      *EXIT
alt: *PEEK48   *F04
neu: *PEEK48   *F04      *PROMPT
alt: *PEEK48   *F05
neu: *PEEK48   *F05      *REFRESH
alt: *PEEK48   *F09
neu: *PEEK48   *F09      *DSPDBR
alt: *PEEK48   *F11
neu: *PEEK48   *F11      *INSKEYFLD
alt: *PEEK48   *F12
neu: *PEEK48   *F12      *CANCEL
alt: *PEEK48   *F24
neu: *PEEK48   *F24      *MOREKEYS
alt: *PEEK05   *HELP
neu: *PEEK05   *HELP     *SQL
alt: *PEEK52   *ENTER
neu: *PEEK52   *ENTER    *ENTER
alt: *PEEK52   *F03
neu: *PEEK52   *F03      *EXIT
alt: *PEEK52   *F05
neu: *PEEK52   *F05      *REFRESH
alt: *PEEK52   *F12
neu: *PEEK52   *F12      *CANCEL
alt: *PEEK52   *F24
neu: *PEEK52   *F24      *MOREKEYS
alt: *PEEK40   *F16
neu: *PEEK40   *F16      *SEARCH
alt: *PEEK40   *F17
neu: *PEEK40   *F17      *TOP
alt: *PEEK40   *F18
neu: *PEEK40   *F18      *BOT
**   Section---Schlüssel-Datenbereich-------------------------- Version 2.1.0 -----------
alt: *PEEK56   *ENTER
neu: *PEEK56   *ENTER    *ENTER
alt: *PEEK56   *F03
neu: *PEEK56   *F03      *EXIT
alt: *PEEK56   *F05
neu: *PEEK56   *F05      *REFRESH
alt: *PEEK56   *F12
neu: *PEEK56   *F12      *CANCEL
alt: *PEEK56   *F16
neu: *PEEK56   *F16      *SEARCH
alt: *PEEK56   *F17
neu: *PEEK56   *F17      *TOP
alt: *PEEK56   *F18
neu: *PEEK56   *F18      *BOT
alt: *PEEK56   *F23
neu: *PEEK56   *F23      *MOREOPT
alt: *PEEK56   *F24
neu: *PEEK56   *F24      *MOREKEYS
alt: *PEEK56   *PAGEUP
neu: *PEEK56   *PAGEUP   *PAGEUP
alt: *PEEK56   *PAGEDOWN
neu: *PEEK56   *PAGEDOWN *PAGEDOWN
alt: *PEEK56   1
neu: *PEEK56   1         *SELECT
neu: *PEEK56
neu: *PEEK56             *NONE
alt: *PEEK05   SE
neu: *PEEK05   SE        *SAVEENV
alt: *PEEK05   LE
neu: *PEEK05   LE        *LOADENV
alt: *PEEK05   DE
neu: *PEEK05   DE        *DELETEENV
alt: *PEEK57   *F03
neu: *PEEK57   *F03      *EXIT
alt: *PEEK57   *F09
neu: *PEEK57   *F09      *DELETEENV
alt: *PEEK57   *F12
neu: *PEEK57   *F12      *CANCEL
alt: *PEEK57   *F24
neu: *PEEK57   *F24      *MOREKEYS
**   Section---Schlüssel-Datenbereich-------------------------- Version 2.2.0 -----------
alt: *PEEK45   *F19
neu: *PEEK45   *F19      *LEFT
alt: *PEEK45   *F20
neu: *PEEK45   *F20      *RIGHT
alt: *PEEK45   *F17
neu: *PEEK45   *F17      *FIRSTPOS
alt: *PEEK45   *F18
neu: *PEEK45   *F18      *LASTPOS
alt: *PEEK59   *ENTER
neu: *PEEK59   *ENTER    *OK
alt: *PEEK59   *F03
neu: *PEEK59   *F03      *NO
alt: *PEEK59   *F09
neu: *PEEK59   *F09      *YES
alt: *PEEK59   *F12
neu: *PEEK59   *F12      *CANCEL
alt: *PEEK12   *ENTER
neu: *PEEK12   *ENTER    *ENTER
alt: *PEEK12   *F03
neu: *PEEK12   *F03      *EXIT
alt: *PEEK12   *F05
neu: *PEEK12   *F05      *REFRESH
alt: *PEEK12   *F12
neu: *PEEK12   *F12      *CANCEL
alt: *PEEK12   *F24
neu: *PEEK12   *F24      *MOREKEYS
alt: *PEEK56   1         *SELECT
neu: *PEEK56   1         *SLCENV
alt: *PEEK56   2
neu: *PEEK56   2         *SLCLAYOUT
**   Section---Schlüssel-Datenbereich-------------------------- Version 3.0.0 -----------
alt: *PXXXXXXXX*F08
neu: *PXXXXXXXX*F08      *TGLNULL
alt: *PXXXXXXXX*F10
neu: *PXXXXXXXX*F10      *STREDIT
alt: *PXXXXXXXX*F13
neu: *PXXXXXXXX*F13      *TGLRCDLCK
alt: *PEEK14   *F10
neu: *PEEK14   *F10      *STREDIT
alt: *PEEK45   *F07
neu: *PEEK45   *F07      *TGLINPUT
alt: *PEEK64   *ENTER
neu: *PEEK64   *ENTER    *ENTER
alt: *PEEK64   *F03
neu: *PEEK64   *F03      *EXIT
alt: *PEEK64   *F05
neu: *PEEK64   *F05      *REFRESH
alt: *PEEK64   *F12
neu: *PEEK64   *F12      *CANCEL
alt: *PEEK64   *F24
neu: *PEEK64   *F24      *MOREKEYS
alt: *PEEK05   K
neu: *PEEK05   K         *TGLKEYLUC
**   Section---Schlüssel-Datenbereich-------------------------- Version 3.1.0 -----------
alt: *PEEK05   6
neu: *PEEK05   6         *PRINT
alt: *PEEK14   *F21
neu: *PEEK14   *F21      *PRINT
**   Section---Schlüssel-Datenbereich-------------------------- Version 3.1.1 -----------
neu: *PEEK68
neu: *PEEK68             *NONE
alt: *PEEK68   *ENTER
neu: *PEEK68   *ENTER    *ENTER
alt: *PEEK68   *F03
neu: *PEEK68   *F03      *EXIT
alt: *PEEK68   *F05
neu: *PEEK68   *F05      *REFRESH
alt: *PEEK68   *F12
neu: *PEEK68   *F12      *CANCEL
alt: *PEEK68   *F17
neu: *PEEK68   *F17      *TOP
alt: *PEEK68   *F18
neu: *PEEK68   *F18      *BOT
alt: *PEEK68   *F22
neu: *PEEK68   *F22      *MOREOPT
alt: *PEEK68   *F24
neu: *PEEK68   *F24      *MOREKEYS
alt: *PEEK68   *PAGEUP
neu: *PEEK68   *PAGEUP   *PAGEUP
alt: *PEEK68   *PAGEDOWN
neu: *PEEK68   *PAGEDOWN *PAGEDOWN
alt: *PEEK68   1
neu: *PEEK68   1         *SELECT
**   Section---Schlüssel-Datenbereich-------------------------- Version 3.2.5 -----------
neu: *PEEK69
neu: *PEEK69             *NONE
alt: *PEEK69   *ENTER
neu: *PEEK69   *ENTER    *ENTER
alt: *PEEK69   *F03
neu: *PEEK69   *F03      *EXIT
alt: *PEEK69   *F05
neu: *PEEK69   *F05      *REFRESH
alt: *PEEK69   *F12
neu: *PEEK69   *F12      *CANCEL
alt: *PEEK69   *F16
neu: *PEEK69   *F16      *SEARCH
alt: *PEEK69   *F17
neu: *PEEK69   *F17      *TOP
alt: *PEEK69   *F18
neu: *PEEK69   *F18      *BOT
alt: *PEEK69   *F23
neu: *PEEK69   *F23      *MOREOPT
alt: *PEEK69   *F24
neu: *PEEK69   *F24      *MOREKEYS
alt: *PEEK69   *PAGEDOWN
neu: *PEEK69   *PAGEDOWN *PAGEDOWN
alt: *PEEK69   *PAGEUP
neu: *PEEK69   *PAGEUP   *PAGEUP
alt: *PEEK69   1
neu: *PEEK69   1         *SELECT
**   Section---Schlüssel-Datenbereich-------------------------- Version 3.4.1 -----------
alt: *PEEK45   *PAGEUP
neu: *PEEK45   *PAGEUP   *PAGEUP
alt: *PEEK45   *PAGEDOWN
neu: *PEEK45   *PAGEDOWN *PAGEDOWN
**   Section---Schlüssel-Datenbereich-------------------------- Version 3.5.0 -----------
alt: *PEEK64   *ENTER    *OK
neu: *PEEK64   *ENTER    *ENTER
alt: *PEEK64   *F3       *NO
neu: *PEEK64   *F3       *EXIT
**   Section---Schlüssel-Datenbereich-------------------------- Version 4.0.1 -----------
alt: *PEEK64   *F07
neu: *PEEK64   *F07      *INSERT
alt: *PEEK64   *F08
neu: *PEEK64   *F08      *DELETE
alt: *PEEK64   *F19
neu: *PEEK64   *F19      *LEFT
alt: *PEEK64   *F20
neu: *PEEK64   *F20      *RIGHT
alt: *PEEK46   *F17
neu: *PEEK64   *F17      *FIRSTPOS
alt: *PEEK64   *F18
neu: *PEEK64   *F18      *LASTPOS
alt: *PEEK64   *PAGEUP
neu: *PEEK64   *PAGEUP   *PAGEUP
alt: *PEEK64   *PAGEDOWN
neu: *PEEK64   *PAGEDOWN *PAGEDOWN
