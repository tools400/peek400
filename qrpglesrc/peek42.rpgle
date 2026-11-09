**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - Aufbereiten Kurzauswahl                      *
      //%EMETADATA                                                     *
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
/copy 'qcopyle/h_spec.rpgleinc'
/copy 'qcopyle/copyright.rpgleinc'

// Aufbau des Satzformats
dcl-f peekFld keyed usropn prefix(f_);

dcl-ds io_buff;
  io_buffFld like(rcdBuf_t);
end-ds;

dcl-s io_nullMap like(nullMap_t) dim(NULL_MAP_SIZE);

/copy 'qcopyle/d_vardef.rpgleinc'
/copy 'qcopyle/fldl0100.rpgleinc'
/copy 'qcopyle/shortcmd_d.rpgleinc'
/copy 'qcopyle/d_clib.rpgleinc'
/copy 'qcopyle/sds.rpgleinc'
/copy 'qcopyle/ceecndhdlr.rpgleinc'

/define internal_prototype
/copy 'qcopyle/ppeek42.rpgleinc'
/undefine internal_prototype

/copy 'qcopyle/ppeek06.rpgleinc'
/copy 'qcopyle/ppeek66.rpgleinc'

/copy 'qcopyle/ppeek53.rpgleinc'
/copy 'qcopyle/ppeek58.rpgleinc'
/copy 'qcopyle/ppeek63.rpgleinc'

dcl-pr lf_rtvFldName varchar(10);
  i_buffer   like(r_shortCmd) const;
  i_startPos like(int4_t) const;
end-pr;

dcl-pr lf_rtvFldFormat like(bool_t);
  io_buffer  like(r_shortCmd);
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
dcl-s isRecord like(bool_t) inz(bFalse);

dcl-s r_file like(shortCmd_t.sc_file) inz;
dcl-s r_lib like(shortCmd_t.sc_lib) inz;
dcl-s r_mbr like(shortCmd_t.sc_mbr) inz;
dcl-s r_shortCmd like(o_execCmd) inz(*blanks);
dcl-s r_cmd1 varchar(32702) inz(*blanks);
dcl-s r_cmd2 varchar(32702) inz(*blanks);
dcl-c R_MaxLen 256;
dcl-s r_var varchar(10) inz(*blanks);
dcl-s r_value varchar(32766) inz('');
dcl-s s like(int4_t) inz;
dcl-s i like(int4_t) inz;
dcl-s fldName varchar(10) inz(*blanks);
dcl-s isOutFormat like(bool_t) inz(bFalse);
dcl-ds shortCmd likeds(shortCmd_t) inz;
dcl-ds fldl0100 likeds(fldl0100_t) inz;
dcl-ds fldl0100_out likeds(fldl0100_t) inz;

dcl-s peek06_name like(pgmCallN_t) inz;
dcl-s peek66_name like(pgmCallN_t) inz;

//  Parameterliste PEEK06
dcl-s yOutBuffer like(rcdBuf_t);
dcl-s yOutBuffLn like(int4_t) inz;
dcl-s yMsgID like(msgId_t) inz(*blanks);
dcl-s yMsgDta like(msgDta_t) inz(*blanks);

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
  i_shortCmd  like(shortCmd_t) const;
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

exsr first;

select;
// Initialisierung
when (shortCmd.sc_action = '*INIT');
  r_file = shortCmd.sc_file;
  r_lib = shortCmd.sc_lib;
  r_mbr = shortCmd.sc_mbr;
  isInit = bTrue;
// Befehl
when (shortCmd.sc_action = '*CMD');
  exsr buildCmd;
//  Unbekannte Aktion
other;
  p_kill('Unknown short command action: ' +
        shortCmd.sc_action);
endsl;

return;

//============================================================*
//    buildCmd      Aufbereiten des auszuführenden Befehls    *
//============================================================*

begsr buildCmd;

  r_shortCmd = shortCmd.sc_cmd;

  if (isInit = bFalse);
  //  keine Initialisierung
  else;
    exsr rpl_file;
    exsr rpl_lib;
    exsr rpl_mbr;
    exsr rpl_rrn;
    exsr rpl_fldName;
  endif;

  o_execCmd = r_shortCmd;

endsr;

//============================================================*
//    rpl_file      Ersetzen der Ersatzvariablen &F           *
//============================================================*

begsr rpl_file;

  r_var   = '&F';
  r_value = %trimr(r_file);
  exsr rpl_var;

endsr;

//============================================================*
//    rpl_lib       Ersetzen der Ersatzvariablen &L           *
//============================================================*

begsr rpl_lib;

  r_var   = '&L';
  r_value = %trimr(r_lib);
  exsr rpl_var;

endsr;

//============================================================*
//    rpl_mbr       Ersetzen der Ersatzvariablen &N           *
//============================================================*

begsr rpl_mbr;

  r_var   = '&N';
  r_value = %trimr(r_mbr);
  exsr rpl_var;

endsr;

//============================================================*
//    rpl_rrn       Ersetzen der Ersatzvariablen &R           *
//============================================================*

begsr rpl_rrn;

  r_var   = '&R';
  r_value = %trimr(%editc(i_rcdNbr: 'X'));
  exsr rpl_var;

endsr;

//============================================================*
//    rpl_fldName   Ersetzen der Ersatzvariablen %*           *
//============================================================*

begsr rpl_fldName;

  dou ('1');

    if CIO_open(hFile00
             : i_file
             : i_library
             : i_member
             : ''
             : 'rr, arrseq=Y, commit=N, +
                nullcap=Y, riofb=Y, +
                secure=Y') = bFalse;
      isRecord = bFalse;
      leave;
    endif;

    for i = 1 to %len(r_shortCmd);

      if (%subst(r_shortCmd: i: 1) = NAME_PREFIX);

        exsr readRcd;
        if (isRecord = bFalse);
          leave;
        endif;

        if (not %open(peekFld));
          open peekFld;
        endif;

        fldName = lf_rtvFldName(r_shortCmd: i);
        if ((fldName <> '') and
            (lf_loadFldAtr(fldName: fldl0100) = bTrue));

          monitor;
            peek06(fldl0100: 'FLDL0100': io_buff
                  : bTrue: bTrue
                  : yOutBuffer: yOutBuffLn
                  : yMsgID: yMsgDta);
            *in99 = bFalse;
          on-error;
            *in99 = bTrue;
          endmon;

          isOutFormat = lf_rtvFldFormat(
                          r_shortCmd
                          : i+%len(%trimr(fldName))+1
                          : fldl0100_out
                          : yMsgID
                          : yMsgDta);

          if (yMsgID <> '');
            o_msgID  = yMsgID;
            o_msgDta = yMsgDta;
            leave;
          endif;

          r_var = NAME_PREFIX + fldName;

          if (isOutFormat = bFalse);
            r_value = %trimr(%subst(yOutBuffer :
                                   1          :
                                   yOutBuffLn ));
          else;
            monitor;
              peek66(yOutBuffer: yOutBuffLn
                    : fldl0100: fldl0100_out
                    : yMsgID: yMsgDta);
              *in99 = bFalse;
            on-error;
              *in99 = bTrue;
            endmon;

            if (yMsgID <> '');
              o_msgID  = yMsgID;
              o_msgDta = yMsgDta;
              leave;
            endif;

            r_value = %subst(yOutBuffer: 1: yOutBuffLn);
          endif;

          r_shortCmd =
            %replace(r_value: r_shortCmd: i: %len(r_var));
        endif;

      endif;

    endfor;

  enddo;

  if (CIO_isOpen(hFile00) = bTrue);
    CIO_close(hFile00);
  endif;

  if (%open(peekFld));
    close peekFld;
  endif;

endsr;

//============================================================*
//    rpl_var       Ersetzen der Ersatzvariablen              *
//============================================================*

begsr rpl_var;

  s = 1;

  dou (s = 0);

    s = %scan(r_var: r_shortCmd: s);
    if (s = *zeros);
    //  Nix gefunden ...
    else;
      //  Variable ersetzen ...
      //  ... extrahieren 1. Teil
      s = s - 1;
      if (s <= 0);
        r_cmd1 = '';
      else;
        r_cmd1 = %subst(r_shortCmd: 1: s);
      endif;

      //  ... extrahieren 2. Teil
      s = s + 1 + %len(r_var);
      if (s > R_MaxLen);
        r_cmd2 = '';
      else;
        r_cmd2 = %trimr(%subst(r_shortCmd: s));
      endif;

      //  ... zusammenführen Teil 1, Variable und Teil 2
      r_shortCmd = r_cmd1 + r_value + r_cmd2;

    endif;

  enddo;

endsr;

//============================================================*
//    readRcd       Einlesen des anzuzeigenden Satzes         *
//============================================================*

begsr readRcd;

  if (CIO_chainWithRRN(hFile00
                    : i_rcdNbr
                    : bFalse
                    : io_buff
                    : io_nullMap) = bFalse);
    isRecord = bFalse;
  else;
    isRecord = bTrue;
  endif;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  // - Programm initialisieren
  //**                Callp     p_rmvPgmMg(sds.pgmName)

  o_msgID = *blanks;
  o_msgDta = *blanks;

  shortCmd = i_shortCmd;

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
    i_buffer   like(r_shortCmd) const;
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
    io_buffer  like(r_shortCmd);
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
/copy 'qcopyle/usr8228.rpgleinc'
/copy 'qcopyle/usr8229.rpgleinc'
/copy 'qcopyle/usr8230.rpgleinc'
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

  fldl0100_tmp.f1DTyp = %xlate(C_LOWER: C_UPPER: data.type);
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
    fldl0100_tmp.f1DecP = data.decpos;
    select;
    when (fldl0100_tmp.f1DTyp = 'S');
      fldl0100_tmp.f1Digt = data.length;
      fldl0100_tmp.f1FLen = data.length;
    when (fldl0100_tmp.f1DTyp = 'P');
      fldl0100_tmp.f1Digt = data.length;
      fldl0100_tmp.f1FLen = %int(data.length / 2);
      if (%rem(data.length: 2) <> 0);
        fldl0100_tmp.f1FLen = fldl0100_tmp.f1FLen + 1;
      endif;
    when (fldl0100_tmp.f1DTyp = 'B' or fldl0100_tmp.f1DTyp = 'I');
      select;
      when (data.length <= 3);
        fldl0100_tmp.f1Digt = 3;
        fldl0100_tmp.f1FLen = 1;
      when (data.length <= 5);
        fldl0100_tmp.f1Digt = 5;
        fldl0100_tmp.f1FLen = 2;
      when (data.length <= 10);
        fldl0100_tmp.f1Digt = 10;
        fldl0100_tmp.f1FLen = 4;
      when (data.length <= 20);
        fldl0100_tmp.f1Digt = 20;
        fldl0100_tmp.f1FLen = 8;
      endsl;
    when (fldl0100_tmp.f1DTyp = 'F');
      if (data.decpos <> 0);
        clear usr8230;
        usr8230.var1 = %char(data.decpos);
        o_msgID  = 'USR8230';
        o_msgDta = usr8230;
        return bFalse;
      endif;
      select;
      when (data.length = 4);
        fldl0100_tmp.f1Digt = 8;
        fldl0100_tmp.f1FLen = 4;
        fldl0100_tmp.f1DecP = 7;
      when (data.length = 8);
        fldl0100_tmp.f1Digt = 16;
        fldl0100_tmp.f1FLen = 8;
        fldl0100_tmp.f1DecP = 15;
      other;
        clear usr8229;
        usr8229.var1 = %char(data.length);
        o_msgID  = 'USR8229';
        o_msgDta = usr8229;
        return bFalse;
      endsl;
    endsl;
  else;
    fldl0100_tmp.f1FLen = data.length;
  endif;

  // Replace start position
  fldl0100_tmp.f1obuf = 1;
  fldl0100_tmp.f1IBuf = 1;

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
  f_key.f_field = i_fldName;
  chain %kds(f_key) fpeekfld;
  if (%found(peekFld));
    fldl0100 = f_ffd;
    isLoaded = bTrue;
  else;
    clear fldl0100;
    isLoaded = bFalse;
  endif;

  o_fldl0100 = fldl0100;

  return isLoaded;

end-proc;

