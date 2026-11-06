**free
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
// >>PRE-COMPILER<<                                              *
//   >>CRTCMD<< &LI/CRTPEEKOBJ SRCFILE(&SL/&SF) SRCMBR(&SM) +    *
//                           OBJLIB(&LI) DEVLIB(&LI) +           *
//                           SBMJOB(*NO) BNDDIR(PEEK) +          *
//                           INSTALL(*NO);                       *
//   >>EXECUTE<<                                                 *
// >>END-PRE-COMPILER<<                                          *
//===============================================================*
ctl-opt nomain;
/copy QCOPYLE,H_SPEC
/copy QCOPYLE,COPYRIGHT

/copy QCOPYLE,FLDL0100
/copy QCOPYLE,D_CLib
/copy QCOPYLE,D_CLib2
/copy QCOPYLE,USR9994
/copy QCOPYLE,SDS

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58
/copy QCOPYLE,PPEEK63

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
  io_hfile likeds(hfile_t);
end-pr;

dcl-pr clearBufferAndNullMap;
  i_rfile      likeds(rfile_t) const;
  io_rcdbuffer like(rcdbuf_t);
  io_nullmap   like(nullmap_t) dim(NULL_MAP_SIZE);
end-pr;

dcl-pr copyInNullMap;
  i_rfile    likeds(rfile_t) const;
  io_nullmap like(nullmap_t) dim(NULL_MAP_SIZE);
end-pr;

//  Returns the value of the specified mode parameter.
dcl-pr getMode varchar(16);
  i_mode    varchar(512) value;
  i_parm    varchar(16) value;
  i_default varchar(16) value;
end-pr;

dcl-pr setEOF;
  io_hfile    likeds(hfile_t);
  i_operation char(10) value;
end-pr;

//===================================================================*
//  Opens a given file.                                   (Body)     *
//===================================================================*

dcl-proc CIO_open export;
  dcl-pi *n like(bool_t);
    o_hfile     likeds(hfile_t);
    i_file      like(file_t) const;
    i_lib       like(lib_t) const;
    i_mbr       like(mbr_t) const;
    i_rcdformat like(rcdFmt_t) const;
    i_mode      pointer options(*string) const;
  end-pi;

  dcl-s fd pointer;

  dcl-ds rfile likeds(rfile_t) based(fd);
  dcl-ds riofb likeds(riofb_t) based(priofb);
  // ----------------------------------------------------------------------

  p_clrerrno();

  clear o_hfile;

  monitor;
    fd = ropen(%trim(i_lib ) + '/' +
               %trim(i_file) + '(' +
               %trim(i_mbr) + ')'
               : i_mode);
    if (fd <> *null and i_rcdformat <> '' and i_rcdformat <> '*FIRST');
      rformat(fd: %trim(i_rcdformat));
    endif;
  on-error;
    //  Do not leave the file open, if _Rformat() failed.
    if (fd <> *null);
      rclose(fd);
    endif;
    fd = *null;
  endmon;

  if (fd = *null);
    o_hfile.errno = f_errno();
    return bFalse;
  endif;

  o_hfile.fd        = fd;
  o_hfile.isopen    = bTrue;
  o_hfile.name      = i_file;
  o_hfile.lib       = i_lib;
  o_hfile.mbr       = i_mbr;
  o_hfile.rcdformat = i_rcdformat;
  o_hfile.errno     = 0;
  o_hfile.lastoper  = OPER_OPEN;
  o_hfile.arrseq    = getMode(%str(i_mode): 'arrseq': 'N');
  o_hfile.msgid     = '';
  o_hfile.msgdta    = '';

  return bTrue;

end-proc;

//===================================================================*
//  Checks whether the file identified by i_hFile is open or not.
//===================================================================*

dcl-proc CIO_isOpen export;
  dcl-pi *n like(bool_t);
    i_hfile likeds(hfile_t) const;
  end-pi;
  // ------------------------------------------------------------------------

  if (i_hfile.fd = *null);
    return bFalse;
  endif;

  return i_hfile.isopen;

end-proc;

//===================================================================*
//  Returns the name of the file identified by i_hFile.
//===================================================================*

dcl-proc CIO_getFile export;
  dcl-pi *n like(file_t);
    i_hfile likeds(hfile_t) const;
  end-pi;
  // ------------------------------------------------------------------------

  if (CIO_isOpen(i_hfile) = bFalse);
    return '';
  endif;

  return i_hfile.name;

end-proc;

//===================================================================*
//  Returns the name of the library that contains the file
//  identified by i_hFile.
//===================================================================*

dcl-proc CIO_getLibrary export;
  dcl-pi *n like(lib_t);
    i_hfile likeds(hfile_t) const;
  end-pi;
  // ------------------------------------------------------------------------

  if (CIO_isOpen(i_hfile) = bFalse);
    return '';
  endif;

  return i_hfile.lib;

end-proc;

//===================================================================*
//  Returns the name of the member of the file identified by i_hFile.
//===================================================================*

dcl-proc CIO_getMember export;
  dcl-pi *n like(lib_t);
    i_hfile likeds(hfile_t) const;
  end-pi;
  // ------------------------------------------------------------------------

  if (CIO_isOpen(i_hfile) = bFalse);
    return '';
  endif;

  return i_hfile.mbr;

end-proc;

//===================================================================*
//  Returns the name of the record format of the file identified
//  by i_hFile.
//===================================================================*

dcl-proc CIO_getRecordFormat export;
  dcl-pi *n char(10);
    i_hfile likeds(hfile_t) const;
  end-pi;
  // ------------------------------------------------------------------------

  if (CIO_isOpen(i_hfile) = bFalse);
    return '';
  endif;

  return i_hfile.rcdformat;

end-proc;

//===================================================================*
//  Returns the record length of the file identified by i_hFile.
//===================================================================*

dcl-proc CIO_getRecordLength export;
  dcl-pi *n int(10);
    i_hfile likeds(hfile_t) const;
  end-pi;

  dcl-ds rfile likeds(rfile_t) based(i_hfile.fd);
  // ----------------------------------------------------------------------

  if (CIO_isOpen(i_hfile) = bFalse);
    return ERROR_RRN;
  endif;

  return rfile.buflen;

end-proc;

//===================================================================*
//  Returns the record number of the current record of the file
//  identified by i_hFile.
//===================================================================*

dcl-proc CIO_getRrn export;
  dcl-pi *n like(rcdNbr_t);
    i_hfile likeds(hfile_t) const;
  end-pi;

  dcl-ds rfile likeds(rfile_t) based(i_hfile.fd);
  dcl-ds riofb likeds(riofb_t) based(priofb);
  // ----------------------------------------------------------------------

  if (CIO_isOpen(i_hfile) = bFalse);
    return ERROR_RRN;
  endif;

  priofb = %addr(rfile.riofb);

  return riofb.rrn;

end-proc;

//===================================================================*
//  Returns the record number of the current record of the file
//  identified by i_hFile.
//===================================================================*

dcl-proc CIO_getMbrNbr export;
  dcl-pi *n int(10);
    i_hfile likeds(hfile_t) const;
  end-pi;

  dcl-ds xxiofb likeds(xxiofb_t) based(pxxiofb);
  dcl-ds xxiofb_db likeds(xxiofb_db_t) based(pxxiofb_db);
  // ----------------------------------------------------------------------

  if (CIO_isOpen(i_hfile) = bFalse);
    return ERROR_RRN;
  endif;

  pxxiofb = riofbk(i_hfile.fd);
  pxxiofb_db = pxxiofb + %size(xxiofb);

  return xxiofb_db.data_mbr_num;

end-proc;

//===================================================================*
//  Returns the file information data structure of the file
//  identified by i_hFile.
//===================================================================*

dcl-proc CIO_getInfDS export;
  dcl-pi *n likeds(infds_t);
    i_hfile likeds(hfile_t) const;
  end-pi;

  //  Funktionswert
  dcl-ds infds likeds(infds_t) inz;
  // ----------------------------------------------------------------------

  clear infds;
  infds.isOpen  = CIO_isOpen(i_hfile);
  infds.file    = CIO_getFile(i_hfile);
  infds.library = CIO_getLibrary(i_hfile);
  infds.rcdlen  = CIO_getRecordLength(i_hfile);
  infds.member  = CIO_getMember(i_hfile);
  infds.rcdfmt  = CIO_getRecordFormat(i_hfile);
  infds.mbrnbr  = CIO_getMbrNbr(i_hfile);
  infds.rcdnbr  = CIO_getRrn(i_hfile);

  return infds;

end-proc;

//===================================================================*
//  Returns TRUE if the file is in error.
//===================================================================*

dcl-proc CIO_isError export;
  dcl-pi *n like(bool_t);
    i_hfile likeds(hfile_t) const;
  end-pi;
  // ------------------------------------------------------------------------

  if (i_hfile.errno <> 0 or i_hfile.msgid <> '');
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
    io_hfile likeds(hfile_t);
    i_msgid  like(msgid_t) const;
    i_msgdta like(msgdta_t) const;
  end-pi;
  // ------------------------------------------------------------------------

  io_hfile.errno  = ERROR_RRN;
  io_hfile.msgid  = i_msgid;
  io_hfile.msgdta = i_msgdta;

end-proc;

//===================================================================*
//  Gets the current error message.
//===================================================================*

dcl-proc CIO_getErrorMsg export;
  dcl-pi *n;
    i_hfile  likeds(hfile_t) const;
    o_msgid  like(msgid_t);
    o_msgdta like(msgdta_t);
  end-pi;

/copy QCOPYLE,USR0012 // ?
  // ------------------------------------------------------------------------

  if (i_hfile.msgid <> '');
    o_msgid  = i_hfile.msgid;
    o_msgdta = i_hfile.msgdta;
  else;
    clear usr0012;
    usr0012.var1 = CIO_getErrorText(i_hfile);
    usr0012.var2 = CIO_getError(i_hfile);
    o_msgid  = 'USR0012';
    o_msgdta = usr0012;
  endif;

end-proc;

//===================================================================*
//  Returns the latest error number associated to file i_hFile.
//===================================================================*

dcl-proc CIO_getError export;
  dcl-pi *n int(10);
    i_hfile likeds(hfile_t) const;
  end-pi;
  // ------------------------------------------------------------------------

  return i_hfile.errno;

end-proc;

//===================================================================*
//  Returns the latest error text associated to file i_hFile.
//===================================================================*

dcl-proc CIO_getErrorText export;
  dcl-pi *n varchar(512);
    i_hfile likeds(hfile_t) const;
  end-pi;
  // ------------------------------------------------------------------------

  if (i_hfile.msgid <> '');
    return f_msgtext(i_hfile.msgid: i_hfile.msgdta);
  else;
    return %trimr(f_strerror(i_hfile.errno));
  endif;

end-proc;

//===================================================================*
//  Reads the record identified by i_rrn from a given file.
//===================================================================*

dcl-proc CIO_chainWithRrn export;
  dcl-pi *n like(bool_t);
    io_hfile     likeds(hfile_t);
    i_rrn        like(rcdNbr_t) const;
    i_dolock     like(bool_t) const;
    io_rcdbuffer like(rcdbuf_t);
    io_nullmap   like(nullmap_t) dim(NULL_MAP_SIZE);
  end-pi;

  dcl-s options int(10) inz(dft);

  dcl-ds rfile likeds(rfile_t) based(io_hfile.fd);
  dcl-ds riofb likeds(riofb_t) based(priofb);
  // ----------------------------------------------------------------------

  p_clrerrno();
  clearErrorMsg(io_hfile);

  clearBufferAndNullMap(rfile: io_rcdbuffer: io_nullmap);

  if (i_dolock = bTrue);
    options = dft;
  else;
    options = no_lock;
  endif;

  priofb = rreadd(io_hfile.fd
                  : %addr(io_rcdbuffer): %size(io_rcdbuffer)
                  : options: i_rrn);
  if (riofb.numbyt <> rfile.buflen);
    io_hfile.errno = f_errno();
    return bFalse;
  endif;

  copyInNullMap(rfile: io_nullmap);

  io_hfile.lastoper = OPER_CHAIN_RRN;
  io_hfile.errno = 0;

  return bTrue;

end-proc;

//===================================================================*
//  Reads the record identified by i_key from a given file.
//===================================================================*

dcl-proc CIO_chainWithKey export;
  dcl-pi *n like(bool_t);
    io_hfile     likeds(hfile_t);
    i_key        like(keybuf_t) const;
    i_dolock     like(bool_t) const;
    io_rcdbuffer like(rcdbuf_t);
    io_nullmap   like(nullmap_t) dim(NULL_MAP_SIZE);
  end-pi;

  dcl-s options int(10) inz(dft);
  dcl-s key like(i_key) inz;
  dcl-s keylen int(10) inz;

  dcl-ds rfile likeds(rfile_t) based(io_hfile.fd);
  dcl-ds riofb likeds(riofb_t) based(priofb);
  // ----------------------------------------------------------------------

  p_clrerrno();
  clearErrorMsg(io_hfile);

  clearBufferAndNullMap(rfile: io_rcdbuffer: io_nullmap);

  if (i_dolock = bTrue);
    options = f_bitor(dft: key_eq);
  else;
    options = f_bitor(no_lock: key_eq);
  endif;

  key = i_key;
  keylen = %len(key);

  priofb = rreadk(io_hfile.fd
                  : %addr(io_rcdbuffer): %size(io_rcdbuffer)
                  : options: %addr(key): keylen);
  if ((riofb.numbyt <> rfile.buflen) or (riofb.numbyt = eof));
    io_hfile.errno = f_errno();
    return bFalse;
  endif;

  copyInNullMap(rfile: io_nullmap);

  io_hfile.lastoper = OPER_CHAIN_KEY;
  io_hfile.errno = 0;

  return bTrue;

end-proc;

//===================================================================*
//  Positions the file right before the record identifed by i_rrn.
//===================================================================*

dcl-proc CIO_setllWithRrn export;
  dcl-pi *n like(bool_t);
    io_hfile likeds(hfile_t);
    i_rrn    like(rcdNbr_t) const;
  end-pi;

  dcl-s errornbr int(10) inz;
  dcl-s options uns(10) inz;

  dcl-ds rfile likeds(rfile_t) based(io_hfile.fd);
  dcl-ds riofb likeds(riofb_t) based(priofb);
  // ----------------------------------------------------------------------

  clearErrorMsg(io_hfile);

  // Setzen Datenzeiger auf angegebene Satznummer
  // (auch auf gelöschte Datensatze)
  options = f_bitor(rrn_eq: no_lock);

  p_clrerrno();
  priofb = rlocate(io_hfile.fd: *null: i_rrn: options);

  select;
  when (riofb.numbyt = 0);   // Datensatz nicht vorhanden
    p_clrerrno();
    priofb = rreadn(io_hfile.fd : *null: 0: no_lock);
    errornbr = f_errno();
  when (riofb.numbyt = 1);   // Datensatz vorhanden
    p_clrerrno();
    priofb = rreads(io_hfile.fd : *null: 0: no_lock);
    errornbr = f_errno();
    if (riofb.numbyt = 0 and errornbr = eiorecerr_c);   // wahrscheinlich ein
      // gelöschter Datensatz
      p_clrerrno();
      priofb = rreadn(io_hfile.fd : *null: 0: no_lock);
    endif;
  endsl;

  // Datensatz nicht vorhanden, also ans Ende der Datei positionieren
  if (riofb.numbyt = 0);
    options = f_bitor(end  : no_lock);
    p_clrerrno();
    priofb = rlocate(io_hfile.fd: *null: i_rrn: options);
  endif;

  if (riofb.numbyt = eof);
    io_hfile.errno = f_errno();   // "End of File" erreicht
    return bFalse;
  endif;

  if (riofb.numbyt <> rfile.buflen);
    io_hfile.errno = f_errno();
    return bFalse;
  endif;

  io_hfile.lastoper = OPER_SETLL_RRN;
  io_hfile.errno = 0;

  return bTrue;

end-proc;

//===================================================================*
//  Positions the file right before the record identifed by i_key.
//===================================================================*

dcl-proc CIO_setllWithKey export;
  dcl-pi *n like(bool_t);
    io_hfile likeds(hfile_t);
    i_key    like(keybuf_t) const;
  end-pi;

  dcl-s options uns(10) inz;
  dcl-s key like(i_key) inz;
  dcl-s keylen int(10) inz;

  dcl-ds rfile likeds(rfile_t) based(io_hfile.fd);
  dcl-ds riofb likeds(riofb_t) based(priofb);
  // ----------------------------------------------------------------------

  p_clrerrno();
  clearErrorMsg(io_hfile);

  // Setzen Datenzeiger auf angegebenen Schlüssel
  key = i_key;
  keylen = %len(key);

  options = f_bitor(key_ge: prior: data_only);

  priofb = rlocate(io_hfile.fd: %addr(key): keylen: options);
  if (riofb.numbyt = 0 or riofb.numbyt = eof);
    //  No key >= i_key: position to the end of the file like SETLL
    options = f_bitor(end: data_only);
    priofb = rlocate(io_hfile.fd: %addr(key): keylen: options);
  endif;

  if (riofb.numbyt = 0); // or (RIOFB.numByt = EOF);
    io_hfile.errno = f_errno();   //Fehler bei _Rlocate() aufgetreten
    return bFalse;
  endif;

  io_hfile.lastoper = OPER_SETLL_KEY;
  io_hfile.errno = 0;

  return bTrue;

end-proc;

//===================================================================*
//  Positions the file right after the record identifed by i_rrn.
//===================================================================*

dcl-proc CIO_setgtWithRrn export;
  dcl-pi *n like(bool_t);
    io_hfile likeds(hfile_t);
    i_rrn    like(rcdNbr_t) const;
  end-pi;

  dcl-s options uns(10) inz;

  dcl-ds rfile likeds(rfile_t) based(io_hfile.fd);
  dcl-ds riofb likeds(riofb_t) based(priofb);
  // ----------------------------------------------------------------------

  p_clrerrno();
  clearErrorMsg(io_hfile);

  // Setzen Datenzeiger auf angegebene Satznummer
  // (auch auf gelöschte Datensatze)
  options = f_bitor(rrn_eq: no_lock);

  priofb = rlocate(io_hfile.fd: *null: i_rrn: options);
  if (riofb.numbyt = 0);
    options = f_bitor(end: no_lock);
    priofb = rlocate(io_hfile.fd: *null: i_rrn: options);
  endif;

  if (riofb.numbyt = 0);
    io_hfile.errno = f_errno();   // Fehler bei _Rlocate() aufgetreten
    return bFalse;
  endif;

  if (riofb.numbyt = eof);
    io_hfile.errno = f_errno();   // "End of File" erreicht
    return bFalse;
  endif;

  // Einlesen Datensatz
  priofb = rreads(io_hfile.fd : *null: 0: no_lock);
  if (riofb.numbyt = 0 and f_errno() = eiorecerr_c);   // wahrscheinlich ein
    // gelöschter Datensatz
    priofb = rreadn(io_hfile.fd : *null: 0: no_lock);
  endif;

  if (riofb.numbyt <> rfile.buflen);
    io_hfile.errno = f_errno();
    return bFalse;
  endif;

  io_hfile.lastoper = OPER_SETGT_RRN;
  io_hfile.errno = 0;

  return bTrue;

end-proc;

//===================================================================*
//  Positions the file right after the record identifed by i_key.
//===================================================================*

dcl-proc CIO_setgtWithKey export;
  dcl-pi *n like(bool_t);
    io_hfile likeds(hfile_t);
    i_key    like(keybuf_t) const;
  end-pi;

  dcl-s options uns(10) inz;
  dcl-s key like(i_key) inz;
  dcl-s keylen int(10) inz;

  dcl-ds rfile likeds(rfile_t) based(io_hfile.fd);
  dcl-ds riofb likeds(riofb_t) based(priofb);
  // ----------------------------------------------------------------------

  p_clrerrno();
  clearErrorMsg(io_hfile);

  // Setzen Datenzeiger auf angegebenen Schlüssel
  key = i_key;
  keylen = %len(key);

  options = f_bitor(key_gt: prior: data_only);

  priofb = rlocate(io_hfile.fd: %addr(key): keylen: options);
  if ((riofb.numbyt = 0) or (riofb.numbyt = eof));
    options = f_bitor(end: data_only);
    priofb = rlocate(io_hfile.fd: %addr(key): keylen: options);
  endif;

  if (riofb.numbyt = 0); // or (RIOFB.numByt = EOF);
    io_hfile.errno = f_errno();   // Fehler bei _Rlocate() aufgetreten
    return bFalse;
  endif;

  io_hfile.lastoper = OPER_SETGT_KEY;
  io_hfile.errno = 0;

  return bTrue;

end-proc;

//===================================================================*
//  Returns the next record from the file.
//===================================================================*

dcl-proc CIO_read export;
  dcl-pi *n like(bool_t);
    io_hfile     likeds(hfile_t);
    i_dolock     like(bool_t) const;
    io_rcdbuffer like(rcdbuf_t);
    io_nullmap   like(nullmap_t) dim(NULL_MAP_SIZE);
  end-pi;

  dcl-s options int(10) inz(dft);
  dcl-s function varchar(32) inz;
  dcl-s msgid like(msgid_t) inz;
  dcl-s msgdta like(msgdta_t) inz;

  dcl-ds rfile likeds(rfile_t) based(io_hfile.fd);
  dcl-ds riofb likeds(riofb_t) based(priofb);
  // ----------------------------------------------------------------------

  p_clrerrno();
  clearErrorMsg(io_hfile);

  clearBufferAndNullMap(rfile: io_rcdbuffer: io_nullmap);

  if (i_dolock = bTrue);
    options = dft;
  else;
    options = no_lock;
  endif;

  if ((io_hfile.lastoper = OPER_SETLL_RRN) or
      (io_hfile.lastoper = OPER_SETGT_RRN));
    //?(io_hFile.lastOper = cOPER_SETLL_KEY) or
    //?(io_hFile.lastOper = cOPER_SETGT_KEY);
    function = '_Rreads';
    priofb = rreads(io_hfile.fd
                    : %addr(io_rcdbuffer): %size(io_rcdbuffer)
                    : options);
  else;
    function = '_Rreadn';
    priofb = rreadn(io_hfile.fd
                    : %addr(io_rcdbuffer): %size(io_rcdbuffer)
                    : options);
  endif;

  io_hfile.errno = f_errno();

  if (io_hfile.errno <> 0);
    clear usr9994;
    usr9994.var1 = f_errno();
    usr9994.var2 = function;
    usr9994.var3 = f_strerror(f_errno());
    msgid  = 'USR9994';
    msgdta = usr9994;
    p_sndpgmmg(msgid: msgdta: '*': MSG_T_DIAG);
    return bTrue;   // Return "EOF" to caller
  endif;

  select;
  when (riofb.numbyt = eof);
    io_hfile.lastoper = OPER_READ;
    io_hfile.errno = 0;
    return bTrue;   // Return "EOF" to caller
  endsl;

  copyInNullMap(rfile: io_nullmap);
  io_hfile.lastoper = OPER_READ;
  io_hfile.errno = 0;

  return bFalse;  // Return "found" to caller

end-proc;

//===================================================================*
//  Returns the previous record from the file.
//===================================================================*

dcl-proc CIO_readp export;
  dcl-pi *n like(bool_t);
    io_hfile     likeds(hfile_t);
    i_dolock     like(bool_t) const;
    io_rcdbuffer like(rcdbuf_t);
    io_nullmap   like(nullmap_t) dim(NULL_MAP_SIZE);
  end-pi;

  dcl-s options int(10) inz(dft);
  dcl-s function varchar(32) inz;
  dcl-s msgid like(msgid_t) inz;
  dcl-s msgdta like(msgdta_t) inz;

  dcl-ds rfile likeds(rfile_t) based(io_hfile.fd);
  dcl-ds riofb likeds(riofb_t) based(priofb);
  // ----------------------------------------------------------------------

  p_clrerrno();
  clearErrorMsg(io_hfile);

  clearBufferAndNullMap(rfile: io_rcdbuffer: io_nullmap);

  if (i_dolock = bTrue);
    options = dft;
  else;
    options = no_lock;
  endif;

  if ((io_hfile.lastoper = OPER_SETLL_RRN) or
      (io_hfile.lastoper = OPER_SETGT_RRN));
    //?(io_hFile.lastOper = cOPER_SETLL_KEY) or
    //?(io_hFile.lastOper = cOPER_SETGT_KEY);
    function = '_Rreads';
    priofb = rreads(io_hfile.fd
                    : %addr(io_rcdbuffer): %size(io_rcdbuffer)
                    : options);
  else;
    function = '_Rreadp';
    priofb = rreadp(io_hfile.fd
                    : %addr(io_rcdbuffer): %size(io_rcdbuffer)
                    : options);
  endif;

  io_hfile.errno = f_errno();

  if (io_hfile.errno <> 0);
    clear usr9994;
    usr9994.var1 = f_errno();
    usr9994.var2 = function;
    usr9994.var3 = f_strerror(f_errno());
    msgid  = 'USR9994';
    msgdta = usr9994;
    p_sndpgmmg(msgid: msgdta: '*': MSG_T_DIAG);
    return bTrue;   // Return "EOF" to caller
  endif;


  select;
  when (riofb.numbyt = eof);
    io_hfile.lastoper = OPER_READP;
    io_hfile.errno = 0;
    return bTrue;   // Return "EOF" to caller
  endsl;

  copyInNullMap(rfile: io_nullmap);
  io_hfile.lastoper = OPER_READP;
  io_hfile.errno = 0;

  return bFalse;  // Return "found" to caller

end-proc;

//===================================================================*
//  Deletes the record that is currently locked for update.
//===================================================================*

dcl-proc CIO_delete export;
  dcl-pi *n like(bool_t);
    io_hfile likeds(hfile_t);
  end-pi;

  dcl-ds rfile likeds(rfile_t) based(io_hfile.fd);
  dcl-ds riofb likeds(riofb_t) based(priofb);
  // ----------------------------------------------------------------------

  p_clrerrno();
  clearErrorMsg(io_hfile);

  priofb = rdelete(io_hfile.fd);
  if (riofb.numbyt = 0);
    io_hfile.errno = f_errno();
    return bFalse;
  endif;

  io_hfile.lastoper = OPER_DELETE;
  io_hfile.errno = 0;

  return bTrue;

end-proc;

//===================================================================*
//  Releases the lock on the currently locked record.
//===================================================================*

dcl-proc CIO_unlock export;
  dcl-pi *n like(bool_t);
    io_hfile likeds(hfile_t);
  end-pi;

  dcl-s rc int(10);

  dcl-ds rfile likeds(rfile_t) based(io_hfile.fd);
  // ------------------------------------------------------------------------

  p_clrerrno();
  clearErrorMsg(io_hfile);

  rc = rrlslck(io_hfile.fd);
  if (rc = 0);
    io_hfile.errno = f_errno();
    return bFalse;
  endif;

  io_hfile.lastoper = OPER_UNLOCK;
  io_hfile.errno = 0;

  return bTrue;

end-proc;

//===================================================================*
//  Closes the file identifed by io_hFile.
//===================================================================*

dcl-proc CIO_close export;
  dcl-pi *n like(bool_t);
    io_hfile likeds(hfile_t);
  end-pi;
  // ------------------------------------------------------------------------

  p_clrerrno();
  clearErrorMsg(io_hfile);

  if (rclose(io_hfile.fd) <> 0);
    io_hfile.errno = f_errno();
    return bFalse;
  endif;

  clear io_hfile;
  io_hfile.isopen = bFalse;
  io_hfile.lastoper = OPER_CLOSE;
  io_hfile.errno = 0;

  return bTrue;

end-proc;

//===================================================================*
//  Sets the EOF indicator for a READ operation.
//  === Used by SQL_nextRow() ===
//===================================================================*

dcl-proc CIO_setEOF_read export;
  dcl-pi *n;
    io_hfile likeds(hfile_t);
  end-pi;
  // ------------------------------------------------------------------------

  setEOF(io_hfile: OPER_READ);

end-proc;

//===================================================================*
//  Sets the EOF indicator for a READP operation.
//  === Used by SQL_previousRow() ===
//===================================================================*

dcl-proc CIO_setEOF_readp export;
  dcl-pi *n;
    io_hfile likeds(hfile_t);
  end-pi;
  // ------------------------------------------------------------------------

  setEOF(io_hfile: OPER_READP);

end-proc;

//===================================================================*
//  *** private ***
//  Sets the EOF indicator for a READ or READP operation.
//===================================================================*

dcl-proc setEOF;
  dcl-pi *n;
    io_hfile    likeds(hfile_t);
    i_operation char(10) value;
  end-pi;

  dcl-ds rfile likeds(rfile_t) based(io_hfile.fd);
  dcl-ds riofb likeds(riofb_t) based(priofb);
  // ----------------------------------------------------------------------

  priofb = %addr(rfile.riofb);

  io_hfile.lastoper = i_operation;
  io_hfile.errno = 0;

  riofb.rrn    = 0;
  riofb.numbyt = eof;

end-proc;

//===================================================================*
//  *** private ***
//  Clears the error information.
//===================================================================*

dcl-proc clearErrorMsg;
  dcl-pi *n;
    io_hfile likeds(hfile_t);
  end-pi;
  // ------------------------------------------------------------------------

  io_hfile.errno  = 0;
  io_hfile.msgid  = '';
  io_hfile.msgdta = '';

end-proc;

//===================================================================*
//  *** private ***
//  Clears the file IO-buffer and NULL-map.
//===================================================================*

dcl-proc clearBufferAndNullMap;
  dcl-pi *n;
    i_rfile      likeds(rfile_t) const;
    io_rcdbuffer like(rcdbuf_t);
    io_nullmap   like(nullmap_t) dim(NULL_MAP_SIZE);
  end-pi;

  dcl-s x int(10);
  // ------------------------------------------------------------------------

  %subst(io_rcdbuffer: 1: i_rfile.buflen) = '';

  for x = 1 to i_rfile.nmaplen;
    io_nullmap(x) = 0;   // setzen auf "nicht NULL"
  endfor;

end-proc;

//===================================================================*
//  *** private ***
//  Copies the file IN-NULL-map.
//===================================================================*

dcl-proc copyInNullMap;
  dcl-pi *n;
    i_rfile    likeds(rfile_t) const;
    io_nullmap like(nullmap_t) dim(NULL_MAP_SIZE);
  end-pi;

  dcl-s x int(10);
  dcl-s innullmap zoned(1) dim(NULL_MAP_SIZE) based(i_rfile.pinnull);
  // ------------------------------------------------------------------------

  for x = 1 to i_rfile.nmaplen;
    io_nullmap(x) = innullmap(x);
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

