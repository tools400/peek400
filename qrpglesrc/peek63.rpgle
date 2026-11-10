**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - Dateizugriffsroutinen            SrvPgm      *
      //%EMETADATA                                                     *
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 3.0.0                               *
//  Programm : PEEK63                                            *
//  Typ      : RPGLE                                             *
//                                                               *
//  erstellt : 25.01.07  Raddatz                                 *
//  geändert :                                                   *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Peek/400 - Dateizugriffsroutinen                             *
//                                                               *
//===============================================================*
ctl-opt nomain;
/copy 'qcopyle/h_spec.rpgleinc'
/copy 'qcopyle/copyright.rpgleinc'

/copy 'qcopyle/fldl0100.rpgleinc'
/copy 'qcopyle/d_clib.rpgleinc'
/copy 'qcopyle/d_clib2.rpgleinc'
/copy 'qcopyle/usr9994.rpgleinc'
/copy 'qcopyle/sds.rpgleinc'

/copy 'qcopyle/ppeek53.rpgleinc'
/copy 'qcopyle/ppeek58.rpgleinc'
/copy 'qcopyle/ppeek63.rpgleinc'

dcl-c OPER_OPEN '*OPEN';
dcl-c OPER_CHAIN_RRN '*CHAIN_RRN';

dcl-c OPER_CHAIN_KEY '*CHAIN_KEY';

dcl-c OPER_SETLL_RRN '*SETLL_RRN';

dcl-c OPER_SETLL_KEY '*SETLL_KEY';
dcl-c OPER_SETGT_RRN '*SETGT_RRN';
dcl-c OPER_SETGT_KEY '*SETGT_KEY';
dcl-c OPER_READ '*READ';
dcl-c OPER_READP '*READP';
dcl-c OPER_CLOSE '*CLOSE';
dcl-c OPER_DELETE '*DELETE';
dcl-c OPER_UNLOCK '*UNLOCK';

dcl-c ERROR_RRN 0;

dcl-pr clearErrorMsg;
  io_hFile likeds(hFile_t);
end-pr;

dcl-pr clearBufferAndNullMap;
  i_rfile      likeds(rfile_t) const;
  io_rcdBuffer like(rcdBuf_t);
  io_nullMap   like(nullMap_t) dim(NULL_MAP_SIZE);
end-pr;

dcl-pr copyInNullMap;
  i_rfile    likeds(rfile_t) const;
  io_nullMap like(nullMap_t) dim(NULL_MAP_SIZE);
end-pr;

//  Returns the value of the specified mode parameter.
dcl-pr getMode varchar(16);
  i_mode    varchar(512) value;
  i_parm    varchar(16) value;
  i_default varchar(16) value;
end-pr;

dcl-pr setEOF;
  io_hFile    likeds(hFile_t);
  i_operation char(10) value;
end-pr;

//===================================================================*
//  Opens a given file.                                   (Body)     *
//===================================================================*

dcl-proc CIO_open export;
  dcl-pi *n like(bool_t);
    o_hFile     likeds(hFile_t);
    i_file      like(file_t) const;
    i_lib       like(lib_t) const;
    i_mbr       like(mbr_t) const;
    i_rcdFormat like(rcdFmt_t) const;
    i_mode      pointer options(*string) const;
  end-pi;

  dcl-s fd pointer;

  dcl-ds rfile likeds(rfile_t) based(fd);
  dcl-ds riofb likeds(riofb_t) based(pRIOFB);
  // ----------------------------------------------------------------------

  p_clrErrno();

  clear o_hFile;

  monitor;
    fd = ropen(%trim(i_lib ) + '/' +
               %trim(i_file) + '(' +
               %trim(i_mbr) + ')'
               : i_mode);
    if (fd <> *null and i_rcdFormat <> '' and i_rcdFormat <> '*FIRST');
      rformat(fd: %trim(i_rcdFormat));
    endif;
  on-error;
    //  Do not leave the file open, if _Rformat() failed.
    if (fd <> *null);
      rclose(fd);
    endif;
    fd = *null;
  endmon;

  if (fd = *null);
    o_hFile.errno = f_errno();
    return bFalse;
  endif;

  o_hFile.fd        = fd;
  o_hFile.isOpen    = bTrue;
  o_hFile.name      = i_file;
  o_hFile.lib       = i_lib;
  o_hFile.mbr       = i_mbr;
  o_hFile.rcdFormat = i_rcdFormat;
  o_hFile.errno     = 0;
  o_hFile.lastOper  = OPER_OPEN;
  o_hFile.arrseq    = getMode(%str(i_mode): 'arrseq': 'N');
  o_hFile.msgID     = '';
  o_hFile.msgDta    = '';

  return bTrue;

end-proc;

//===================================================================*
//  Checks whether the file identified by i_hFile is open or not.
//===================================================================*

dcl-proc CIO_isOpen export;
  dcl-pi *n like(bool_t);
    i_hFile likeds(hFile_t) const;
  end-pi;
  // ------------------------------------------------------------------------

  if (i_hFile.fd = *null);
    return bFalse;
  endif;

  return i_hFile.isOpen;

end-proc;

//===================================================================*
//  Returns the name of the file identified by i_hFile.
//===================================================================*

dcl-proc CIO_getFile export;
  dcl-pi *n like(file_t);
    i_hFile likeds(hFile_t) const;
  end-pi;
  // ------------------------------------------------------------------------

  if (CIO_isOpen(i_hFile) = bFalse);
    return '';
  endif;

  return i_hFile.name;

end-proc;

//===================================================================*
//  Returns the name of the library that contains the file
//  identified by i_hFile.
//===================================================================*

dcl-proc CIO_getLibrary export;
  dcl-pi *n like(lib_t);
    i_hFile likeds(hFile_t) const;
  end-pi;
  // ------------------------------------------------------------------------

  if (CIO_isOpen(i_hFile) = bFalse);
    return '';
  endif;

  return i_hFile.lib;

end-proc;

//===================================================================*
//  Returns the name of the member of the file identified by i_hFile.
//===================================================================*

dcl-proc CIO_getMember export;
  dcl-pi *n like(lib_t);
    i_hFile likeds(hFile_t) const;
  end-pi;
  // ------------------------------------------------------------------------

  if (CIO_isOpen(i_hFile) = bFalse);
    return '';
  endif;

  return i_hFile.mbr;

end-proc;

//===================================================================*
//  Returns the name of the record format of the file identified
//  by i_hFile.
//===================================================================*

dcl-proc CIO_getRecordFormat export;
  dcl-pi *n char(10);
    i_hFile likeds(hFile_t) const;
  end-pi;
  // ------------------------------------------------------------------------

  if (CIO_isOpen(i_hFile) = bFalse);
    return '';
  endif;

  return i_hFile.rcdFormat;

end-proc;

//===================================================================*
//  Returns the record length of the file identified by i_hFile.
//===================================================================*

dcl-proc CIO_getRecordLength export;
  dcl-pi *n int(10);
    i_hFile likeds(hFile_t) const;
  end-pi;

  dcl-ds rfile likeds(rfile_t) based(i_hFile.fd);
  // ----------------------------------------------------------------------

  if (CIO_isOpen(i_hFile) = bFalse);
    return ERROR_RRN;
  endif;

  return rfile.bufLen;

end-proc;

//===================================================================*
//  Returns the record number of the current record of the file
//  identified by i_hFile.
//===================================================================*

dcl-proc CIO_getRRN export;
  dcl-pi *n like(rcdNbr_t);
    i_hFile likeds(hFile_t) const;
  end-pi;

  dcl-ds rfile likeds(rfile_t) based(i_hFile.fd);
  dcl-ds riofb likeds(riofb_t) based(pRIOFB);
  // ----------------------------------------------------------------------

  if (CIO_isOpen(i_hFile) = bFalse);
    return ERROR_RRN;
  endif;

  pRIOFB = %addr(rfile.riofb);

  return riofb.rrn;

end-proc;

//===================================================================*
//  Returns the record number of the current record of the file
//  identified by i_hFile.
//===================================================================*

dcl-proc CIO_getMbrNbr export;
  dcl-pi *n int(10);
    i_hFile likeds(hFile_t) const;
  end-pi;

  dcl-ds xxiofb likeds(xxiofb_t) based(pXXIOFB);
  dcl-ds xxiofb_db likeds(xxiofb_db_t) based(pXXIOFB_db);
  // ----------------------------------------------------------------------

  if (CIO_isOpen(i_hFile) = bFalse);
    return ERROR_RRN;
  endif;

  pXXIOFB = riofbk(i_hFile.fd);
  pXXIOFB_db = pXXIOFB + %size(xxiofb);

  return xxiofb_db.data_mbr_num;

end-proc;

//===================================================================*
//  Returns the file information data structure of the file
//  identified by i_hFile.
//===================================================================*

dcl-proc CIO_getInfDS export;
  dcl-pi *n likeds(infds_t);
    i_hFile likeds(hFile_t) const;
  end-pi;

  //  Funktionswert
  dcl-ds infds likeds(infds_t) inz;
  // ----------------------------------------------------------------------

  clear infds;
  infds.isOpen  = CIO_isOpen(i_hFile);
  infds.file    = CIO_getFile(i_hFile);
  infds.library = CIO_getLibrary(i_hFile);
  infds.rcdLen  = CIO_getRecordLength(i_hFile);
  infds.member  = CIO_getMember(i_hFile);
  infds.rcdFmt  = CIO_getRecordFormat(i_hFile);
  infds.mbrNbr  = CIO_getMbrNbr(i_hFile);
  infds.rcdNbr  = CIO_getRRN(i_hFile);

  return infds;

end-proc;

//===================================================================*
//  Returns TRUE if the file is in error.
//===================================================================*

dcl-proc CIO_isError export;
  dcl-pi *n like(bool_t);
    i_hFile likeds(hFile_t) const;
  end-pi;
  // ------------------------------------------------------------------------

  if (i_hFile.errno <> 0 or i_hFile.msgID <> '');
    return bTrue;
  else;
    return bFalse;
  endif;

end-proc;

//===================================================================*
//  Sets an error.
//===================================================================*

dcl-proc CIO_setErrorMsg export;
  dcl-pi *n;
    io_hFile likeds(hFile_t);
    i_msgID  like(msgId_t) const;
    i_msgDta like(msgDta_t) const;
  end-pi;
  // ------------------------------------------------------------------------

  io_hFile.errno  = ERROR_RRN;
  io_hFile.msgID  = i_msgID;
  io_hFile.msgDta = i_msgDta;

end-proc;

//===================================================================*
//  Gets the current error message.
//===================================================================*

dcl-proc CIO_getErrorMsg export;
  dcl-pi *n;
    i_hFile  likeds(hFile_t) const;
    o_msgID  like(msgId_t);
    o_msgDta like(msgDta_t);
  end-pi;

/copy 'qcopyle/usr0012.rpgleinc' // ?
  // ------------------------------------------------------------------------

  if (i_hFile.msgID <> '');
    o_msgID  = i_hFile.msgID;
    o_msgDta = i_hFile.msgDta;
  else;
    clear usr0012;
    usr0012.var1 = CIO_getErrorText(i_hFile);
    usr0012.var2 = CIO_getError(i_hFile);
    o_msgID  = 'USR0012';
    o_msgDta = usr0012;
  endif;

end-proc;

//===================================================================*
//  Returns the latest error number associated to file i_hFile.
//===================================================================*

dcl-proc CIO_getError export;
  dcl-pi *n int(10);
    i_hFile likeds(hFile_t) const;
  end-pi;
  // ------------------------------------------------------------------------

  return i_hFile.errno;

end-proc;

//===================================================================*
//  Returns the latest error text associated to file i_hFile.
//===================================================================*

dcl-proc CIO_getErrorText export;
  dcl-pi *n varchar(512);
    i_hFile likeds(hFile_t) const;
  end-pi;
  // ------------------------------------------------------------------------

  if (i_hFile.msgID <> '');
    return f_msgText(i_hFile.msgID: i_hFile.msgDta);
  else;
    return %trimr(f_strError(i_hFile.errno));
  endif;

end-proc;

//===================================================================*
//  Reads the record identified by i_rrn from a given file.
//===================================================================*

dcl-proc CIO_chainWithRRN export;
  dcl-pi *n like(bool_t);
    io_hFile     likeds(hFile_t);
    i_rrn        like(rcdNbr_t) const;
    i_doLock     like(bool_t) const;
    io_rcdBuffer like(rcdBuf_t);
    io_nullMap   like(nullMap_t) dim(NULL_MAP_SIZE);
  end-pi;

  dcl-s options int(10) inz(dft);

  dcl-ds rfile likeds(rfile_t) based(io_hFile.fd);
  dcl-ds riofb likeds(riofb_t) based(pRIOFB);
  // ----------------------------------------------------------------------

  p_clrErrno();
  clearErrorMsg(io_hFile);

  clearBufferAndNullMap(rfile: io_rcdBuffer: io_nullMap);

  if (i_doLock = bTrue);
    options = dft;
  else;
    options = no_lock;
  endif;

  pRIOFB = rreadd(io_hFile.fd
                  : %addr(io_rcdBuffer): %size(io_rcdBuffer)
                  : options: i_rrn);
  if (riofb.numByt <> rfile.bufLen);
    io_hFile.errno = f_errno();
    return bFalse;
  endif;

  copyInNullMap(rfile: io_nullMap);

  io_hFile.lastOper = OPER_CHAIN_RRN;
  io_hFile.errno = 0;

  return bTrue;

end-proc;

//===================================================================*
//  Reads the record identified by i_key from a given file.
//===================================================================*

dcl-proc CIO_chainWithKey export;
  dcl-pi *n like(bool_t);
    io_hFile     likeds(hFile_t);
    i_key        like(keyBuf_t) const;
    i_doLock     like(bool_t) const;
    io_rcdBuffer like(rcdBuf_t);
    io_nullMap   like(nullMap_t) dim(NULL_MAP_SIZE);
  end-pi;

  dcl-s options int(10) inz(dft);
  dcl-s key like(i_key) inz;
  dcl-s keyLen int(10) inz;

  dcl-ds rfile likeds(rfile_t) based(io_hFile.fd);
  dcl-ds riofb likeds(riofb_t) based(pRIOFB);
  // ----------------------------------------------------------------------

  p_clrErrno();
  clearErrorMsg(io_hFile);

  clearBufferAndNullMap(rfile: io_rcdBuffer: io_nullMap);

  if (i_doLock = bTrue);
    options = f_bitor(dft: key_eq);
  else;
    options = f_bitor(no_lock: key_eq);
  endif;

  key = i_key;
  keyLen = %len(key);

  pRIOFB = rreadk(io_hFile.fd
                  : %addr(io_rcdBuffer): %size(io_rcdBuffer)
                  : options: %addr(key): keyLen);
  if ((riofb.numByt <> rfile.bufLen) or (riofb.numByt = eof));
    io_hFile.errno = f_errno();
    return bFalse;
  endif;

  copyInNullMap(rfile: io_nullMap);

  io_hFile.lastOper = OPER_CHAIN_KEY;
  io_hFile.errno = 0;

  return bTrue;

end-proc;

//===================================================================*
//  Positions the file right before the record identifed by i_rrn.
//===================================================================*

dcl-proc CIO_setllWithRRN export;
  dcl-pi *n like(bool_t);
    io_hFile likeds(hFile_t);
    i_rrn    like(rcdNbr_t) const;
  end-pi;

  dcl-s errorNbr int(10) inz;
  dcl-s options uns(10) inz;

  dcl-ds rfile likeds(rfile_t) based(io_hFile.fd);
  dcl-ds riofb likeds(riofb_t) based(pRIOFB);
  // ----------------------------------------------------------------------

  clearErrorMsg(io_hFile);

  // Setzen Datenzeiger auf angegebene Satznummer
  // (auch auf gelöschte Datensatze)
  options = f_bitor(rrn_eq: no_lock);

  p_clrErrno();
  pRIOFB = rlocate(io_hFile.fd: *null: i_rrn: options);

  select;
  when (riofb.numByt = 0);   // Datensatz nicht vorhanden
    p_clrErrno();
    pRIOFB = rreadn(io_hFile.fd : *null: 0: no_lock);
    errorNbr = f_errno();
  when (riofb.numByt = 1);   // Datensatz vorhanden
    p_clrErrno();
    pRIOFB = rreads(io_hFile.fd : *null: 0: no_lock);
    errorNbr = f_errno();
    if (riofb.numByt = 0 and errorNbr = eiorecerr_c);   // wahrscheinlich ein
      // gelöschter Datensatz
      p_clrErrno();
      pRIOFB = rreadn(io_hFile.fd : *null: 0: no_lock);
    endif;
  endsl;

  // Datensatz nicht vorhanden, also ans Ende der Datei positionieren
  if (riofb.numByt = 0);
    options = f_bitor(end  : no_lock);
    p_clrErrno();
    pRIOFB = rlocate(io_hFile.fd: *null: i_rrn: options);
  endif;

  if (riofb.numByt = eof);
    io_hFile.errno = f_errno();   // "End of File" erreicht
    return bFalse;
  endif;

  if (riofb.numByt <> rfile.bufLen);
    io_hFile.errno = f_errno();
    return bFalse;
  endif;

  io_hFile.lastOper = OPER_SETLL_RRN;
  io_hFile.errno = 0;

  return bTrue;

end-proc;

//===================================================================*
//  Positions the file right before the record identifed by i_key.
//===================================================================*

dcl-proc CIO_setllWithKey export;
  dcl-pi *n like(bool_t);
    io_hFile likeds(hFile_t);
    i_key    like(keyBuf_t) const;
  end-pi;

  dcl-s options uns(10) inz;
  dcl-s key like(i_key) inz;
  dcl-s keyLen int(10) inz;

  dcl-ds rfile likeds(rfile_t) based(io_hFile.fd);
  dcl-ds riofb likeds(riofb_t) based(pRIOFB);
  // ----------------------------------------------------------------------

  p_clrErrno();
  clearErrorMsg(io_hFile);

  // Setzen Datenzeiger auf angegebenen Schlüssel
  key = i_key;
  keyLen = %len(key);

  options = f_bitor(key_ge: prior: data_only);

  pRIOFB = rlocate(io_hFile.fd: %addr(key): keyLen: options);
  if (riofb.numByt = 0 or riofb.numByt = eof);
    //  No key >= i_key: position to the end of the file like SETLL
    options = f_bitor(end: data_only);
    pRIOFB = rlocate(io_hFile.fd: %addr(key): keyLen: options);
  endif;

  if (riofb.numByt = 0); // or (RIOFB.numByt = EOF);
    io_hFile.errno = f_errno();   //Fehler bei _Rlocate() aufgetreten
    return bFalse;
  endif;

  io_hFile.lastOper = OPER_SETLL_KEY;
  io_hFile.errno = 0;

  return bTrue;

end-proc;

//===================================================================*
//  Positions the file right after the record identifed by i_rrn.
//===================================================================*

dcl-proc CIO_setgtWithRRN export;
  dcl-pi *n like(bool_t);
    io_hFile likeds(hFile_t);
    i_rrn    like(rcdNbr_t) const;
  end-pi;

  dcl-s options uns(10) inz;

  dcl-ds rfile likeds(rfile_t) based(io_hFile.fd);
  dcl-ds riofb likeds(riofb_t) based(pRIOFB);
  // ----------------------------------------------------------------------

  p_clrErrno();
  clearErrorMsg(io_hFile);

  // Setzen Datenzeiger auf angegebene Satznummer
  // (auch auf gelöschte Datensatze)
  options = f_bitor(rrn_eq: no_lock);

  pRIOFB = rlocate(io_hFile.fd: *null: i_rrn: options);
  if (riofb.numByt = 0);
    options = f_bitor(end: no_lock);
    pRIOFB = rlocate(io_hFile.fd: *null: i_rrn: options);
  endif;

  if (riofb.numByt = 0);
    io_hFile.errno = f_errno();   // Fehler bei _Rlocate() aufgetreten
    return bFalse;
  endif;

  if (riofb.numByt = eof);
    io_hFile.errno = f_errno();   // "End of File" erreicht
    return bFalse;
  endif;

  // Einlesen Datensatz
  pRIOFB = rreads(io_hFile.fd : *null: 0: no_lock);
  if (riofb.numByt = 0 and f_errno() = eiorecerr_c);   // wahrscheinlich ein
    // gelöschter Datensatz
    pRIOFB = rreadn(io_hFile.fd : *null: 0: no_lock);
  endif;

  if (riofb.numByt <> rfile.bufLen);
    io_hFile.errno = f_errno();
    return bFalse;
  endif;

  io_hFile.lastOper = OPER_SETGT_RRN;
  io_hFile.errno = 0;

  return bTrue;

end-proc;

//===================================================================*
//  Positions the file right after the record identifed by i_key.
//===================================================================*

dcl-proc CIO_setgtWithKey export;
  dcl-pi *n like(bool_t);
    io_hFile likeds(hFile_t);
    i_key    like(keyBuf_t) const;
  end-pi;

  dcl-s options uns(10) inz;
  dcl-s key like(i_key) inz;
  dcl-s keyLen int(10) inz;

  dcl-ds rfile likeds(rfile_t) based(io_hFile.fd);
  dcl-ds riofb likeds(riofb_t) based(pRIOFB);
  // ----------------------------------------------------------------------

  p_clrErrno();
  clearErrorMsg(io_hFile);

  // Setzen Datenzeiger auf angegebenen Schlüssel
  key = i_key;
  keyLen = %len(key);

  options = f_bitor(key_gt: prior: data_only);

  pRIOFB = rlocate(io_hFile.fd: %addr(key): keyLen: options);
  if ((riofb.numByt = 0) or (riofb.numByt = eof));
    options = f_bitor(end: data_only);
    pRIOFB = rlocate(io_hFile.fd: %addr(key): keyLen: options);
  endif;

  if (riofb.numByt = 0); // or (RIOFB.numByt = EOF);
    io_hFile.errno = f_errno();   // Fehler bei _Rlocate() aufgetreten
    return bFalse;
  endif;

  io_hFile.lastOper = OPER_SETGT_KEY;
  io_hFile.errno = 0;

  return bTrue;

end-proc;

//===================================================================*
//  Returns the next record from the file.
//===================================================================*

dcl-proc CIO_read export;
  dcl-pi *n like(bool_t);
    io_hFile     likeds(hFile_t);
    i_doLock     like(bool_t) const;
    io_rcdBuffer like(rcdBuf_t);
    io_nullMap   like(nullMap_t) dim(NULL_MAP_SIZE);
  end-pi;

  dcl-s options int(10) inz(dft);
  dcl-s function varchar(32) inz;
  dcl-s msgID like(msgId_t) inz;
  dcl-s msgDta like(msgDta_t) inz;

  dcl-ds rfile likeds(rfile_t) based(io_hFile.fd);
  dcl-ds riofb likeds(riofb_t) based(pRIOFB);
  // ----------------------------------------------------------------------

  p_clrErrno();
  clearErrorMsg(io_hFile);

  clearBufferAndNullMap(rfile: io_rcdBuffer: io_nullMap);

  if (i_doLock = bTrue);
    options = dft;
  else;
    options = no_lock;
  endif;

  if ((io_hFile.lastOper = OPER_SETLL_RRN) or
      (io_hFile.lastOper = OPER_SETGT_RRN));
    //?(io_hFile.lastOper = cOPER_SETLL_KEY) or
    //?(io_hFile.lastOper = cOPER_SETGT_KEY);
    function = '_Rreads';
    pRIOFB = rreads(io_hFile.fd
                    : %addr(io_rcdBuffer): %size(io_rcdBuffer)
                    : options);
  else;
    function = '_Rreadn';
    pRIOFB = rreadn(io_hFile.fd
                    : %addr(io_rcdBuffer): %size(io_rcdBuffer)
                    : options);
  endif;

  io_hFile.errno = f_errno();

  if (io_hFile.errno <> 0);
    clear usr9994;
    usr9994.var1 = f_errno();
    usr9994.var2 = function;
    usr9994.var3 = f_strError(f_errno());
    msgID  = 'USR9994';
    msgDta = usr9994;
    p_sndPgmMg(msgID: msgDta: '*': MSG_T_DIAG);
    return bTrue;   // Return "EOF" to caller
  endif;

  select;
  when (riofb.numByt = eof);
    io_hFile.lastOper = OPER_READ;
    io_hFile.errno = 0;
    return bTrue;   // Return "EOF" to caller
  endsl;

  copyInNullMap(rfile: io_nullMap);
  io_hFile.lastOper = OPER_READ;
  io_hFile.errno = 0;

  return bFalse;  // Return "found" to caller

end-proc;

//===================================================================*
//  Returns the previous record from the file.
//===================================================================*

dcl-proc CIO_readp export;
  dcl-pi *n like(bool_t);
    io_hFile     likeds(hFile_t);
    i_doLock     like(bool_t) const;
    io_rcdBuffer like(rcdBuf_t);
    io_nullMap   like(nullMap_t) dim(NULL_MAP_SIZE);
  end-pi;

  dcl-s options int(10) inz(dft);
  dcl-s function varchar(32) inz;
  dcl-s msgID like(msgId_t) inz;
  dcl-s msgDta like(msgDta_t) inz;

  dcl-ds rfile likeds(rfile_t) based(io_hFile.fd);
  dcl-ds riofb likeds(riofb_t) based(pRIOFB);
  // ----------------------------------------------------------------------

  p_clrErrno();
  clearErrorMsg(io_hFile);

  clearBufferAndNullMap(rfile: io_rcdBuffer: io_nullMap);

  if (i_doLock = bTrue);
    options = dft;
  else;
    options = no_lock;
  endif;

  if ((io_hFile.lastOper = OPER_SETLL_RRN) or
      (io_hFile.lastOper = OPER_SETGT_RRN));
    //?(io_hFile.lastOper = cOPER_SETLL_KEY) or
    //?(io_hFile.lastOper = cOPER_SETGT_KEY);
    function = '_Rreads';
    pRIOFB = rreads(io_hFile.fd
                    : %addr(io_rcdBuffer): %size(io_rcdBuffer)
                    : options);
  else;
    function = '_Rreadp';
    pRIOFB = rreadp(io_hFile.fd
                    : %addr(io_rcdBuffer): %size(io_rcdBuffer)
                    : options);
  endif;

  io_hFile.errno = f_errno();

  if (io_hFile.errno <> 0);
    clear usr9994;
    usr9994.var1 = f_errno();
    usr9994.var2 = function;
    usr9994.var3 = f_strError(f_errno());
    msgID  = 'USR9994';
    msgDta = usr9994;
    p_sndPgmMg(msgID: msgDta: '*': MSG_T_DIAG);
    return bTrue;   // Return "EOF" to caller
  endif;


  select;
  when (riofb.numByt = eof);
    io_hFile.lastOper = OPER_READP;
    io_hFile.errno = 0;
    return bTrue;   // Return "EOF" to caller
  endsl;

  copyInNullMap(rfile: io_nullMap);
  io_hFile.lastOper = OPER_READP;
  io_hFile.errno = 0;

  return bFalse;  // Return "found" to caller

end-proc;

//===================================================================*
//  Deletes the record that is currently locked for update.
//===================================================================*

dcl-proc CIO_delete export;
  dcl-pi *n like(bool_t);
    io_hFile likeds(hFile_t);
  end-pi;

  dcl-ds rfile likeds(rfile_t) based(io_hFile.fd);
  dcl-ds riofb likeds(riofb_t) based(pRIOFB);
  // ----------------------------------------------------------------------

  p_clrErrno();
  clearErrorMsg(io_hFile);

  pRIOFB = rdelete(io_hFile.fd);
  if (riofb.numByt = 0);
    io_hFile.errno = f_errno();
    return bFalse;
  endif;

  io_hFile.lastOper = OPER_DELETE;
  io_hFile.errno = 0;

  return bTrue;

end-proc;

//===================================================================*
//  Releases the lock on the currently locked record.
//===================================================================*

dcl-proc CIO_unlock export;
  dcl-pi *n like(bool_t);
    io_hFile likeds(hFile_t);
  end-pi;

  dcl-s rc int(10);

  dcl-ds rfile likeds(rfile_t) based(io_hFile.fd);
  // ------------------------------------------------------------------------

  p_clrErrno();
  clearErrorMsg(io_hFile);

  rc = rrlsLck(io_hFile.fd);
  if (rc = 0);
    io_hFile.errno = f_errno();
    return bFalse;
  endif;

  io_hFile.lastOper = OPER_UNLOCK;
  io_hFile.errno = 0;

  return bTrue;

end-proc;

//===================================================================*
//  Closes the file identifed by io_hFile.
//===================================================================*

dcl-proc CIO_close export;
  dcl-pi *n like(bool_t);
    io_hFile likeds(hFile_t);
  end-pi;
  // ------------------------------------------------------------------------

  p_clrErrno();
  clearErrorMsg(io_hFile);

  if (rclose(io_hFile.fd) <> 0);
    io_hFile.errno = f_errno();
    return bFalse;
  endif;

  clear io_hFile;
  io_hFile.isOpen = bFalse;
  io_hFile.lastOper = OPER_CLOSE;
  io_hFile.errno = 0;

  return bTrue;

end-proc;

//===================================================================*
//  Sets the EOF indicator for a READ operation.
//  === Used by SQL_nextRow() ===
//===================================================================*

dcl-proc CIO_setEOF_read export;
  dcl-pi *n;
    io_hFile likeds(hFile_t);
  end-pi;
  // ------------------------------------------------------------------------

  setEOF(io_hFile: OPER_READ);

end-proc;

//===================================================================*
//  Sets the EOF indicator for a READP operation.
//  === Used by SQL_previousRow() ===
//===================================================================*

dcl-proc CIO_setEOF_readp export;
  dcl-pi *n;
    io_hFile likeds(hFile_t);
  end-pi;
  // ------------------------------------------------------------------------

  setEOF(io_hFile: OPER_READP);

end-proc;

//===================================================================*
//  *** private ***
//  Sets the EOF indicator for a READ or READP operation.
//===================================================================*

dcl-proc setEOF;
  dcl-pi *n;
    io_hFile    likeds(hFile_t);
    i_operation char(10) value;
  end-pi;

  dcl-ds rfile likeds(rfile_t) based(io_hFile.fd);
  dcl-ds riofb likeds(riofb_t) based(pRIOFB);
  // ----------------------------------------------------------------------

  pRIOFB = %addr(rfile.riofb);

  io_hFile.lastOper = i_operation;
  io_hFile.errno = 0;

  riofb.rrn    = 0;
  riofb.numByt = eof;

end-proc;

//===================================================================*
//  *** private ***
//  Clears the error information.
//===================================================================*

dcl-proc clearErrorMsg;
  dcl-pi *n;
    io_hFile likeds(hFile_t);
  end-pi;
  // ------------------------------------------------------------------------

  io_hFile.errno  = 0;
  io_hFile.msgID  = '';
  io_hFile.msgDta = '';

end-proc;

//===================================================================*
//  *** private ***
//  Clears the file IO-buffer and NULL-map.
//===================================================================*

dcl-proc clearBufferAndNullMap;
  dcl-pi *n;
    i_rfile      likeds(rfile_t) const;
    io_rcdBuffer like(rcdBuf_t);
    io_nullMap   like(nullMap_t) dim(NULL_MAP_SIZE);
  end-pi;

  dcl-s x int(10);
  // ------------------------------------------------------------------------

  %subst(io_rcdBuffer: 1: i_rfile.bufLen) = '';

  for x = 1 to i_rfile.nMapLen;
    io_nullMap(x) = 0;   // setzen auf "nicht NULL"
  endfor;

end-proc;

//===================================================================*
//  *** private ***
//  Copies the file IN-NULL-map.
//===================================================================*

dcl-proc copyInNullMap;
  dcl-pi *n;
    i_rfile    likeds(rfile_t) const;
    io_nullMap like(nullMap_t) dim(NULL_MAP_SIZE);
  end-pi;

  dcl-s x int(10);
  dcl-s inNullMap zoned(1) dim(NULL_MAP_SIZE) based(i_rfile.pInNull);
  // ------------------------------------------------------------------------

  for x = 1 to i_rfile.nMapLen;
    io_nullMap(x) = inNullMap(x);
  endfor;

end-proc;

//===================================================================*
//  *** private ***
//  Returns the value of the specified mode parameter.
//===================================================================*

dcl-proc getMode;
  dcl-pi *n varchar(16);
    i_mode    varchar(512) value;
    i_parm    varchar(16) value;
    i_default varchar(16) value;
  end-pi;

  //  Local fields
  dcl-s x int(10);
  dcl-s y int(10);
  // ------------------------------------------------------------------------

  i_mode    = %trim(i_mode);
  i_parm    = %trim(i_parm);
  i_default = %trim(i_default);

  x = %scan(i_parm + '=': i_mode);
  if (x = 0);
    return i_default;
  endif;

  x = x + %len(i_parm) + 1;

  y = %scan(' ': i_mode: x);
  if (y = 0);
    return %subst(i_mode: x);
  endif;

  return %subst(i_mode: x: y-1-x);

end-proc;

