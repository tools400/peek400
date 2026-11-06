**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 2.0.0                               *
//  Programm : PEEK03                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 23.10.97  Raddatz                                 *
//                                                               *
//===============================================================*
//                                                               *
//  Dokumentation:                                               *
//                                                               *
//  Aktualisieren der Feldliste mit Schlüsselinformationen       *
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

dcl-f peekFld usage(*update: *delete) keyed usropn prefix(f_);

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,KEYL0100
/copy QCOPYLE,SDS
/copy QCOPYLE,CEECNDHDLR

/copy QCOPYLE,USR0006

/define internal_prototype
/copy QCOPYLE,PPEEK03
/undefine internal_prototype

/copy QCOPYLE,PPEEK41
/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

dcl-s peek41_name like(pgmCallN_t) inz;

dcl-ds fldl0100 likeds(fldl0100_t) inz;

dcl-s rtnCode like(int4_t) inz;
dcl-s nbrOfKey like(int4_t) inz;

dcl-s x like(int4_t) inz;
dcl-s y like(int4_t) inz;
dcl-s z like(int4_t) inz;
dcl-s tempStr like(i_sqlOrder) inz;
dcl-ds keyl0100 likeds(keyl0100_t) based(pKEYL0100);
dcl-ds keyl0100_sql likeds(keyl0100_t) inz;
dcl-s data char(512) inz;
dcl-s numKeyFld like(int4_t);
dcl-s sqlName varchar(128) inz;

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek03;
  i_qFile    likeds(qObj_t) const;
  i_rcdFmt   like(fmt_t) const;
  i_access   like(accessMode_t) const;
  i_sqlOrder like(sqlOrder_t) const;
  o_msgID    like(msgId_t);
  o_msgDta   like(msgDta_t);
end-pi;

dcl-s do_x1 packed(7);

dcl-ds f_key likerec(fpeekfld: *key);

//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr first;

if (i_access = SQL_SEQ);
  exsr sqlSeq;
else;
  exsr otherSeq;
endif;

if (nbrOfKey <= *zeros);
  o_msgID = 'USR0006';
  USR0006.var1 = i_qFile.name;
  USR0006.var2 = i_qFile.lib;
  o_msgDta = usr0006;
else;
  o_msgID = '';
  o_msgDta = '';
endif;

*inlr = '1';

//====================================================*
//  sqlSeq     SQL-Auswahl                            *
//====================================================*

begsr sqlSeq;

  pKEYL0100 = %addr(keyl0100_sql);

  numKeyFld = 0;

  x = 1;
  exsr getNextFld;

  dow (y > 1);

    tempStr = %trim(%subst(i_sqlOrder: x: y-x));
    //  Ende des Feldes ...
    z = %scan('"': tempStr: 2);
    sqlName = %trim(%subst(tempStr: 2: z-2));
    exsr getSysName;

    //  Alles hinter dem Feld ...
    if (z+1 <= %len(tempStr));
      tempStr = %trim(%subst(tempStr: z+1));
    else;
      tempStr = '';
    endif;

    if (tempStr = 'DESC');
      keyl0100.apkseq  = 'D';
      numKeyFld = numKeyFld + 1;
      keyl0100.apkeyn = numKeyFld;
      exsr addKeyInf;
    else;
      keyl0100.apkseq  = 'A';
      numKeyFld = numKeyFld + 1;
      keyl0100.apkeyn = numKeyFld;
      exsr addKeyInf;
    endif;

    x = y + 1;
    exsr getNextFld;
  enddo;

  nbrOfKey = numKeyFld;

endsr;

//====================================================*
//  getSysName  Systemname des Feldes in sqlName      *
//====================================================*

begsr getSysName;

  //  In der SQL-Sortierung kann auch der lange SQL-Name einer Spalte
  //  stehen. PEEKFLD ist aber über den Systemnamen verschlüsselt.
  keyl0100.apkeyf = '';

  if (sqlName = '');
    leavesr;
  endif;

  if (%len(sqlName) <= %len(keyl0100.apkeyf));
    f_key.f_field = sqlName;
    chain(n) %kds(f_key) fpeekfld;
    if (%found());
      keyl0100.apkeyf = sqlName;
      leavesr;
    endif;
  endif;

  //  ... sonst nach dem alternativen Namen suchen
  setll *loval fpeekfld;
  read(n) fpeekfld;
  dow (not %eof());
    fldl0100 = f_ffd;
    if (fldl0100.f1afnm = sqlName);
      keyl0100.apkeyf = f_field;
      leavesr;
    endif;
    read(n) fpeekfld;
  enddo;

endsr;

//====================================================*
//  getNextFld  nächstes Feld im SQL-String           *
//====================================================*

begsr getNextFld;

  if (x > %len(i_sqlOrder));
    y = 0;
  else;

    y = %scan(',': i_sqlOrder: x);

    if ((y = 0) and
        (%subst(i_sqlOrder: x) <> ' '));
      y = %checkr(' ': i_sqlOrder);
      y = y + 1;
    endif;

  endif;

endsr;

//====================================================*
//  otherSeq   keine SQl-Auswahl                      *
//====================================================*

begsr otherSeq;

  pKEYL0100 = %addr(data);

  //  Abrufen der Dateiinformationen ...
  peek41(i_qFile: i_rcdFmt
        : '*CREATE': rtnCode: data);
  if (rtnCode <= 0);
  //  ... schade, Aufruf ist fehlgeschlagen
  else;
    //  Einlesen der Schlüsselinformationen ...
    peek41(i_qFile: i_rcdFmt
          : '*KEY': nbrOfKey: data);

    for do_x1 = 1 to nbrOfKey;
      peek41(i_qFile: i_rcdFmt
            : '*READKEY': rtnCode: data);
      exsr addKeyInf;
    endfor;

  endif;

endsr;

//====================================================*
//  addKeyInf  Hinzufügen Schlüsselinformationen      *
//====================================================*

begsr addKeyInf;

  clear f_key;
  f_key.f_field = keyl0100.apkeyf;
  chain %kds(f_key) fpeekfld;
  if (%found());
    f_desc = keyl0100.apkseq;
    f_kSeq = keyl0100.apkeyn;
    fldl0100 = f_ffd;
    fldl0100.f1KeyF = '1';
    f_ffd = fldl0100;
    update fpeekfld;
  endif;

endsr;

//====================================================*
//  First  --  Initialize program                     *
//====================================================*

begsr first;

  nbrOfKey = *zeros;

  // - Meldung
  p_sndStsMg('USR8137': i_qFile);

  // - Los gehts'
  o_msgID = *blanks;
  o_msgDta = *blanks;

endsr;

//====================================================*
//  InzSr --  Initialize program                      *
//====================================================*

begsr inzsr;

  if (isInzSr = bTrue);
    leavesr;
  endif;

  isInzSr = bTrue;

  peek41_name = f_pgmCallN('PEEK41');

  open peekFld;

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


