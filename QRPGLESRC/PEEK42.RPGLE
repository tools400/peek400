**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 1.4.0                               *
//  Programm : PEEK42                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 14.04.98  Raddatz                                 *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Verarbeiten einer Kurzauswahl                                *
//                                                               *
//===============================================================*
//                                                               *
//  Gültige Ersatzvariablen:                                     *
//  ------------------------                                     *
//     &L           - Bibliothek der geöffneten Datei            *
//     &F           - Name der geöffneten Datei                  *
//     &N           - Name der Teildatei                         *
//     &R           - Relative Satznummer                        *
//     % + Feldname - Wert des angegebenen Feldes                *
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

// Aufbau des Satzformats
dcl-f peekfld keyed usropn prefix(f_);

dcl-ds IO_Buff;
  IO_BuffFld like(rcdBuf_t);
end-ds;

dcl-s IO_NullMap like(nullMap_t) dim(NULL_MAP_SIZE);

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,ShortCmd_d
/copy QCOPYLE,D_CLIB
/copy QCOPYLE,SDS
/copy QCOPYLE,CEECNDHDLR

/define internal_prototype
/copy QCOPYLE,PPEEK42
/undefine internal_prototype

/copy QCOPYLE,PPEEK06
/copy QCOPYLE,PPEEK66

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58
/copy QCOPYLE,PPEEK63

dcl-pr lf_rtvFldName varchar(10);
  i_buffer   like(R_ShortCmd) const;
  i_startPos like(int4_t) const;
end-pr;

dcl-pr lf_rtvFldFormat like(bool_t);
  io_buffer  like(R_ShortCmd);
  i_startPos like(int4_t) const;
  o_fldl0100 likeds(fldl0100_t);
  o_msgID    like(msgId_t);
  o_msgDta   like(msgDta_t);
end-pr;

dcl-pr lf_loadFldAtr char(1);
  i_fldName  char(10) const;
  o_fldl0100 likeds(fldl0100_t);
end-pr;

dcl-s isInit like(bool_t) inz(bFalse);
dcl-s IsRecord like(bool_t) inz(bFalse);

dcl-s R_File like(ShortCmd_t.SC_File) inz;
dcl-s R_Lib like(ShortCmd_t.SC_Lib) inz;
dcl-s R_Mbr like(ShortCmd_t.SC_Mbr) inz;
dcl-s R_ShortCmd like(o_execCmd) inz(*blanks);
dcl-s R_Cmd1 varchar(32702) inz(*blanks);
dcl-s R_Cmd2 varchar(32702) inz(*blanks);
dcl-c R_MaxLen 256;
dcl-s R_Var varchar(10) inz(*blanks);
dcl-s R_Value varchar(32766) inz('');
dcl-s s like(int4_t) inz;
dcl-s i like(int4_t) inz;
dcl-s fldName varchar(10) inz(*blanks);
dcl-s isOutFormat like(bool_t) inz(bFalse);
dcl-ds ShortCmd likeds(ShortCmd_t) inz;
dcl-ds fldl0100 likeds(fldl0100_t) inz;
dcl-ds fldl0100_out likeds(fldl0100_t) inz;

dcl-s peek06_name like(pgmCallN_t) inz;
dcl-s peek66_name like(pgmCallN_t) inz;

//  Parameterliste PEEK06
dcl-s YOutBuffer like(rcdBuf_t);
dcl-s YOutBuffLn like(int4_t) inz;
dcl-s YMsgID like(msgId_t) inz(*blanks);
dcl-s YMsgDta like(msgDta_t) inz(*blanks);

dcl-c NAME_PREFIX '%';
dcl-c cFORMAT_START '(';
dcl-c cFORMAT_END ')';
dcl-c cFORMAT_DELIMITER ',';

// Für Einzelsatzzugriff
dcl-ds hFile00 likeds(hFile_t);

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek42;
  i_file      like(file_t) const;
  i_library   like(lib_t) const;
  i_member    like(mbr_t) const;
  i_rcdFormat like(fmt_t) const;
  i_shortCmd  like(ShortCmd_t) const;
  i_rcdNbr    like(rcdNbr_t) const;
  o_execCmd   like(cmdBuffer_t);
  o_msgID     like(msgId_t);
  o_msgDta    like(msgDta_t);
end-pi;

//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr First;

select;
// Initialisierung
when (ShortCmd.SC_Action = '*INIT');
  R_File = ShortCmd.SC_File;
  R_Lib = ShortCmd.SC_Lib;
  R_Mbr = ShortCmd.SC_Mbr;
  isInit = bTrue;
// Befehl
when (ShortCmd.SC_Action = '*CMD');
  exsr BuildCmd;
//  Unbekannte Aktion
other;
  p_kill('Unknown short command action: ' +
        ShortCmd.SC_Action);
endsl;

return;

//============================================================*
//    BuildCmd      Aufbereiten des auszuführenden Befehls    *
//============================================================*

begsr BuildCmd;

  R_ShortCmd = ShortCmd.SC_Cmd;

  if (isInit = bFalse);
  //  keine Initialisierung
  else;
    exsr Rpl_File;
    exsr Rpl_Lib;
    exsr Rpl_Mbr;
    exsr Rpl_Rrn;
    exsr Rpl_FldName;
  endif;

  o_execCmd = R_ShortCmd;

endsr;

//============================================================*
//    Rpl_File      Ersetzen der Ersatzvariablen &F           *
//============================================================*

begsr Rpl_File;

  R_Var   = '&F';
  R_Value = %trimr(R_File);
  exsr Rpl_Var;

endsr;

//============================================================*
//    Rpl_Lib       Ersetzen der Ersatzvariablen &L           *
//============================================================*

begsr Rpl_Lib;

  R_Var   = '&L';
  R_Value = %trimr(R_Lib);
  exsr Rpl_Var;

endsr;

//============================================================*
//    Rpl_Mbr       Ersetzen der Ersatzvariablen &N           *
//============================================================*

begsr Rpl_Mbr;

  R_Var   = '&N';
  R_Value = %trimr(R_Mbr);
  exsr Rpl_Var;

endsr;

//============================================================*
//    Rpl_Rrn       Ersetzen der Ersatzvariablen &R           *
//============================================================*

begsr Rpl_Rrn;

  R_Var   = '&R';
  R_Value = %trimr(%editc(i_rcdNbr: 'X'));
  exsr Rpl_Var;

endsr;

//============================================================*
//    Rpl_FldName   Ersetzen der Ersatzvariablen %*           *
//============================================================*

begsr Rpl_FldName;

  dou ('1');

    if CIO_open(hFile00
             : i_file
             : i_library
             : i_member
             : ''
             : 'rr, arrseq=Y, commit=N, +
                nullcap=Y, riofb=Y, +
                secure=Y') = bFalse;
      IsRecord = bFalse;
      leave;
    endif;

    for i = 1 to %len(R_ShortCmd);

      if (%subst(R_ShortCmd: i: 1) = NAME_PREFIX);

        exsr ReadRcd;
        if (IsRecord = bFalse);
          leave;
        endif;

        if (not %open(peekfld));
          open peekfld;
        endif;

        fldName = lf_rtvFldName(R_ShortCmd: i);
        if ((fldName <> '') and
            (lf_loadFldAtr(fldName: fldl0100) = bTrue));

          monitor;
            peek06(fldl0100: 'FLDL0100': IO_Buff
                  : bTrue: bTrue
                  : YOutBuffer: YOutBuffLn
                  : YMsgID: YMsgDta);
            *in99 = bFalse;
          on-error;
            *in99 = bTrue;
          endmon;

          isOutFormat = lf_rtvFldFormat(
                          R_ShortCmd
                          : i+%len(%trimr(fldName))+1
                          : fldl0100_out
                          : YMsgID
                          : YMsgDta);

          if (YMsgID <> '');
            o_msgID  = YMsgID;
            o_msgDta = YMsgDta;
            leave;
          endif;

          R_Var = NAME_PREFIX + fldName;

          if (isOutFormat = bFalse);
            R_Value = %trimr(%subst(YOutBuffer :
                                   1          :
                                   YOutBuffLn ));
          else;
            monitor;
              peek66(YOutBuffer: YOutBuffLn
                    : fldl0100: fldl0100_out
                    : YMsgID: YMsgDta);
              *in99 = bFalse;
            on-error;
              *in99 = bTrue;
            endmon;

            if (YMsgID <> '');
              o_msgID  = YMsgID;
              o_msgDta = YMsgDta;
              leave;
            endif;

            R_Value = %subst(YOutBuffer: 1: YOutBuffLn);
          endif;

          R_ShortCmd =
            %replace(R_Value: R_ShortCmd: i: %len(R_Var));
        endif;

      endif;

    endfor;

  enddo;

  if (CIO_isOpen(hFile00) = bTrue);
    CIO_close(hFile00);
  endif;

  if (%open(peekfld));
    close peekfld;
  endif;

endsr;

//============================================================*
//    Rpl_Var       Ersetzen der Ersatzvariablen              *
//============================================================*

begsr Rpl_Var;

  s = 1;

  dou (s = 0);

    s = %scan(R_Var: R_ShortCmd: s);
    if (s = *zeros);
    //  Nix gefunden ...
    else;
      //  Variable ersetzen ...
      //  ... extrahieren 1. Teil
      s = s - 1;
      if (s <= 0);
        R_Cmd1 = '';
      else;
        R_Cmd1 = %subst(R_ShortCmd: 1: s);
      endif;

      //  ... extrahieren 2. Teil
      s = s + 1 + %len(R_Var);
      if (s > R_MaxLen);
        R_Cmd2 = '';
      else;
        R_Cmd2 = %trimr(%subst(R_ShortCmd: s));
      endif;

      //  ... zusammenführen Teil 1, Variable und Teil 2
      R_ShortCmd = R_Cmd1 + R_Value + R_Cmd2;

    endif;

  enddo;

endsr;

//============================================================*
//    ReadRcd       Einlesen des anzuzeigenden Satzes         *
//============================================================*

begsr ReadRcd;

  if (CIO_chainWithRRN(hFile00
                    : i_rcdNbr
                    : bFalse
                    : IO_Buff
                    : IO_NullMap) = bFalse);
    IsRecord = bFalse;
  else;
    IsRecord = bTrue;
  endif;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr First;

  // - Programm initialisieren
  //**                Callp     p_rmvPgmMg(sds.pgmName)

  o_msgID = *blanks;
  o_msgDta = *blanks;

  ShortCmd = i_shortCmd;

endsr;

//====================================================*
//  InzSr --  Initialize program                      *
//====================================================*

begsr inzsr;

  if (isInzSr = bTrue);
    leavesr;
  endif;

  isInzSr = bTrue;

  isInit = bFalse;

  peek06_name = f_pgmCallN('PEEK06');
  peek66_name = f_pgmCallN('PEEK66');

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

//============================================================*
//    Ermitteln Feldname aus Kurzbefehl                       *
//============================================================*
dcl-proc lf_rtvFldName;
  dcl-pi *n varchar(10);
    i_buffer   like(R_ShortCmd) const;
    i_startPos like(int4_t) const;
  end-pi;

  //  Funktionswert
  dcl-s fldName char(10) inz;

  //  Arbeitsfelder
  dcl-s i like(int4_t) inz;

  //  Gültige Zeichen für Feldnamen
  dcl-c VALID_CHARS '_$#§ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  fldName = '';

  for i = i_startPos + 1 to %len(i_buffer);
    if (%scan(%subst(i_buffer: i: 1): VALID_CHARS) = 0);
      leave;
    endif;

    fldName = %trimr(fldName) +
             %subst(i_buffer: i: 1);
  endfor;

  return %trimr(fldName);

end-proc;

//============================================================*
//    Ermitteln Feldformat                                    *
//============================================================*
dcl-proc lf_rtvFldFormat;
  dcl-pi *n like(bool_t);
    io_buffer  like(R_ShortCmd);
    i_startPos like(int4_t) const;
    o_fldl0100 likeds(fldl0100_t);
    o_msgID    like(msgId_t);
    o_msgDta   like(msgDta_t);
  end-pi;

  //  Arbeitsfelder
  dcl-s s like(int4_t) inz;
  dcl-s e like(int4_t) inz;
  dcl-s l like(int4_t) inz;
  dcl-s strFormat char(256) inz;
  dcl-ds data qualified inz;
    type   char(1);
    length int(10);
    decpos int(10);
  end-ds;
  dcl-s pToken pointer inz;
  dcl-ds fldl0100_tmp likeds(fldl0100_t) inz;

  //  Nachrichten
/copy QCOPYLE,USR8228
/copy QCOPYLE,USR8229
/copy QCOPYLE,USR8230
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  clear o_fldl0100;
  clear o_msgID;
  clear o_msgDta;

  if (i_startPos > %len(io_buffer) or
      %subst(io_buffer: i_startPos: 1) <> cFORMAT_START);
    return bFalse;
  endif;

  // Find end of format definition
  s = i_startPos;
  e = s;
  l = 0;

  dow (e <= %len(io_buffer));
    if (%subst(io_buffer: e: 1) = cFORMAT_END);
      l = e - s + 1;
      leave;
    else;
      e = e + 1;
    endif;
  enddo;

  // Get format without leading and trailing parenthesis
  strFormat = %subst(io_buffer: s+1: l-2);

  if (strFormat = '');
    return bFalse;
  endif;

  // Remove format definition from buffer
  io_buffer = %replace('': io_buffer: s: l);

  // Splitt format into data type, length and decimal positions
  pToken = strtok(strFormat: cFORMAT_DELIMITER);
  if (pToken <> *null);            // data type
    data.type = %str(pToken);
    pToken = strtok(*null: cFORMAT_DELIMITER);
  endif;

  if (pToken <> *null);            // field length
    monitor;
      data.length = %dec(%str(pToken): 10: 0);
    on-error;
      clear usr8229;
      usr8229.var1 = %str(pToken);
      o_msgID  = 'USR8229';
      o_msgDta = usr8229;
      return bFalse;
    endmon;
    pToken = strtok(*null: cFORMAT_DELIMITER);
  endif;

  if (pToken <> *null);            // decimal positions
    monitor;
      data.decpos = %dec(%str(pToken): 10: 0);
    on-error;
      clear usr8230;
      usr8230.var1 = %str(pToken);
      o_msgID  = 'USR8230';
      o_msgDta = usr8230;
      return bFalse;
    endmon;
  endif;

  // Compose new field type
  if (lf_loadFldAtr(fldName: fldl0100_tmp) = bFalse);
    return bFalse;
  endif;

  fldl0100_tmp.F1DTyp = %xlate(C_LOWER: C_UPPER: data.type);
  if (f_isNotAlw(fldl0100_tmp) = bTrue);
    clear usr8228;
    usr8228.var1 = data.type;
    o_msgID  = 'USR8228';
    o_msgDta = usr8228;
    return bFalse;
  endif;

  // Check data type
  if (f_isNotAlw(fldl0100_tmp) = bTrue);
    return bFalse;
  endif;

  // Replace length and decimal position
  if (f_isNumFld(fldl0100) = bTrue);
    fldl0100_tmp.f1decp = data.decpos;
    select;
    when (fldl0100_tmp.F1DTyp = 'S');
      fldl0100_tmp.f1digt = data.length;
      fldl0100_tmp.f1flen = data.length;
    when (fldl0100_tmp.F1DTyp = 'P');
      fldl0100_tmp.f1digt = data.length;
      fldl0100_tmp.f1flen = %int(data.length / 2);
      if (%rem(data.length: 2) <> 0);
        fldl0100_tmp.f1flen = fldl0100_tmp.f1flen + 1;
      endif;
    when (fldl0100_tmp.F1DTyp = 'B' or fldl0100_tmp.F1DTyp = 'I');
      select;
      when (data.length <= 3);
        fldl0100_tmp.f1digt = 3;
        fldl0100_tmp.f1flen = 1;
      when (data.length <= 5);
        fldl0100_tmp.f1digt = 5;
        fldl0100_tmp.f1flen = 2;
      when (data.length <= 10);
        fldl0100_tmp.f1digt = 10;
        fldl0100_tmp.f1flen = 4;
      when (data.length <= 20);
        fldl0100_tmp.f1digt = 20;
        fldl0100_tmp.f1flen = 8;
      endsl;
    when (fldl0100_tmp.F1DTyp = 'F');
      if (data.decpos <> 0);
        clear usr8230;
        usr8230.var1 = %char(data.decpos);
        o_msgID  = 'USR8230';
        o_msgDta = usr8230;
        return bFalse;
      endif;
      select;
      when (data.length = 4);
        fldl0100_tmp.f1digt = 8;
        fldl0100_tmp.f1flen = 4;
        fldl0100_tmp.f1decp = 7;
      when (data.length = 8);
        fldl0100_tmp.f1digt = 16;
        fldl0100_tmp.f1flen = 8;
        fldl0100_tmp.f1decp = 15;
      other;
        clear usr8229;
        usr8229.var1 = %char(data.length);
        o_msgID  = 'USR8229';
        o_msgDta = usr8229;
        return bFalse;
      endsl;
    endsl;
  else;
    fldl0100_tmp.f1flen = data.length;
  endif;

  // Replace start position
  fldl0100_tmp.f1obuf = 1;
  fldl0100_tmp.F1IBuf = 1;

  o_fldl0100 = fldl0100_tmp;

  return bTrue;


end-proc;

//============================================================*
//    Laden Feldattribute                                     *
//============================================================*
dcl-proc lf_loadFldAtr;
  dcl-pi *n char(1);
    i_fldName  char(10) const;
    o_fldl0100 likeds(fldl0100_t);
  end-pi;

  //  Funktionswert
  dcl-s isLoaded char(1) inz(bFalse);

  //  Arbeitsfelder
  dcl-ds fldl0100 likeds(fldl0100_t) inz;

  dcl-ds f_key likerec(fpeekfld: *key);
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  clear f_key;
  f_key.F_Field = i_fldName;
  chain %kds(f_key) fpeekfld;
  if (%found(peekfld));
    fldl0100 = f_ffd;
    isLoaded = bTrue;
  else;
    clear fldl0100;
    isLoaded = bFalse;
  endif;

  o_fldl0100 = fldl0100;

  return isLoaded;

end-proc;

