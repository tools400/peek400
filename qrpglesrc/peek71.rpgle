**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - Character Translation Services   SrvPgm      *
      //%EMETADATA                                                     *
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 3.3.0                               *
//  Programm : PEEK071                                           *
//  Typ      : RPGLE                                             *
//                                                               *
//  erstellt : 27.03.2012   Thomas Raddatz                       *
//  geändert :                                                   *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Peek/400 - Character Translation Services                    *
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
/copy 'qcopyle/h_spec.rpgleinc'
/copy 'qcopyle/copyright.rpgleinc'

// ------------------------------------
//  Constants
// ------------------------------------

//  Transcoder handle identifier
dcl-c class_transcoder '*CLASS:ccsid.TRANSCODER';

// ------------------------------------
//  Type Definitions
// ------------------------------------
/copy 'qcopyle/d_vardef.rpgleinc'
/copy 'qcopyle/fldl0100.rpgleinc'

//  Transcoder handle
dcl-ds transcoder_t qualified template;
  class     likeds(class_t);
  fromCcsid uns(10);
  toCcsid   uns(10);
  hIconv    likeds(iconv_t);
end-ds;

dcl-ds class_t qualified template;
  name     like(className_t);
  size     int(10);
  reserved char(12);
end-ds;

dcl-s className_t varchar(62) template;

/copy 'qcopyle/ppeek71.rpgleinc'

/copy 'qcopyle/d_clib.rpgleinc' // C-Runtime Library
/copy 'qcopyle/ppeek53.rpgleinc' // Zugriff auf Benutzerdaten
/copy 'qcopyle/ppeek58.rpgleinc' // Allgemeine Routinen
/copy 'qcopyle/qusrjobi.rpgleinc' // Retrieve Job Information (QUSRJOBI) API
/copy 'qcopyle/qmhsndpm.rpgleinc' // Send Program Message (QMHSNDPM) API

// ------------------------------------
//  Internal prototypes
// ------------------------------------

//  Performs charcater translation.
dcl-pr performTranslation uns(10) extproc('performTranslation');
  i_hTranscoder like(hTranscoder_t) const;
  i_pInBuf      pointer value;
  i_length      int(10) const;
  o_pTo         pointer;
  i_maxSize     int(10) const;
end-pr;

//  Returns a transcoder that matches the specified "from CCSID"
//  from the list of created transcoders.
dcl-pr findTranscoder like(hTranscoder_t) extproc('findTranscoder');
  i_toCcsid   uns(10) const;
  i_fromCcsid uns(10) const;
end-pr;

//  Produces a transcoder to transcode character data from
//  and to given CCSIDs.
dcl-pr createTranscoder like(hTranscoder_t) extproc('createTranscoder');
  i_toCcsid   uns(10) const;
  i_fromCcsid uns(10) const;
end-pr;

//  Kills utility with an ESCAPE message.
dcl-pr kill extproc('kill');
  i_text  varchar(128) const;
  i_errno int(10) options(*nopass) const;
end-pr;

//  Returns the CCSID of the current job.
dcl-pr getJobCcsid int(10) extproc('getJobCcsid');
end-pr;

//  Kills utility, if a given handle is not a transcoder.
dcl-pr checkHandle extproc('checkHandle');
  i_hTranscoder like(hTranscoder_t) const;
end-pr;

// ------------------------------------
//  Global fields & constants
// ------------------------------------
dcl-s g_jobCcsid uns(10) inz(0);

dcl-ds g_transcoders qualified;
  numE int(10) inz;
  item likeds(transcoderE_t) dim(64) inz;
end-ds;

dcl-ds transcoderE_t qualified;
  hTranscoder like(hTranscoder_t);
  toCcsid     int(10);
  fromCcsid   int(10);
end-ds;

//=====================================================================*
//  Returns a Transcoder to convert from a
//  given CCSID to the job CCSID.
//=====================================================================*
dcl-proc Transcoder_toJobCcsid export;
  dcl-pi *n like(hTranscoder_t);
    i_fromCcsid uns(10) const;
  end-pi;

  //  Return value
  dcl-s hTranscoder like(hTranscoder_t) inz;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  hTranscoder = findTranscoder(getJobCcsid(): i_fromCcsid);
  if (Transcoder_isNull(hTranscoder));
    hTranscoder = createTranscoder(getJobCcsid(): i_fromCcsid);
  endif;

  return hTranscoder;

end-proc;

//=====================================================================*
//  Returns a Transcoder to convert from a
//  given CCSID to the file field CCSID.
//=====================================================================*
dcl-proc Transcoder_toFieldCcsid export;
  dcl-pi *n like(hTranscoder_t);
    i_toCcsid uns(10) const;
  end-pi;

  //  Return value
  dcl-s hTranscoder like(hTranscoder_t) inz;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  hTranscoder = findTranscoder(i_toCcsid: getJobCcsid());
  if (Transcoder_isNull(hTranscoder));
    hTranscoder = createTranscoder(i_toCcsid: getJobCcsid());
  endif;

  return hTranscoder;

end-proc;

//=====================================================================*
//  Initializes character translation.
//=====================================================================*
dcl-proc Transcoder_new export;
  dcl-pi *n like(hTranscoder_t);
    i_toCcsid   uns(10) const;
    i_fromCcsid uns(10) const;
  end-pi;

  //  Return value
  dcl-s hTranscoder like(hTranscoder_t) inz;

  //  Helper fields
  dcl-ds toCode likeds(QtqCode_t) inz;
  dcl-ds fromCode likeds(QtqCode_t) inz;
  dcl-ds hIconv likeds(iconv_t) inz;

  //  Transcoder handle
  dcl-ds transcoder likeds(transcoder_t) based(pTranscoder);
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  clear fromCode;
  fromCode.ccsid         = i_fromCcsid;
  fromCode.conversionA   = 0;
  fromCode.substitutionA = 0;
  fromCode.shiftStateA   = 0;
  fromCode.inpLenOpt     = 0;
  fromCode.errOptMxdDta  = 1;
  fromCode.reserved      = *allx'00';

  clear toCode;
  toCode.ccsid         = i_toCcsid;
  toCode.conversionA   = 0;
  toCode.substitutionA = 0;
  toCode.shiftStateA   = 0;
  toCode.inpLenOpt     = 0;
  toCode.errOptMxdDta  = 0;
  toCode.reserved      =   *allx'00';

  hIconv = QtqIconv_open(toCode: fromCode);
  if (hIconv.return_value = -1);
    kill('Failed to initialize character conversion': f_errno());
  endif;

  pTranscoder = %alloc(%size(transcoder));

  clear transcoder;
  transcoder.class.name = class_transcoder;
  transcoder.class.size = %size(transcoder);

  transcoder.fromCcsid = i_fromCcsid;
  transcoder.toCcsid   = i_toCcsid;
  transcoder.hIconv    = hIconv;

  hTranscoder = pTranscoder;

  return hTranscoder;

end-proc;

//=====================================================================*
//  Translate a given buffer using dynamic memory allocation.
//=========================================================================
//  Parameters:
//   i_hTranscoder - Handle of the character transcoder.
//   i_pInBuf      - Pointer to the input buffer.
//   i_size        - Current size of the input buffer.
//   o_pOutBuf     - Pointer to the translated output data.
//   o_msg         - Optional. Error message.

//  Returns:
//   rc            - Returns the new length of the buffer.
//                   Sends escape message CPF9897 on error.
//=====================================================================*
dcl-proc Transcoder_xlateRaw export;
  dcl-pi *n int(10) opdesc;
    i_hTranscoder like(hTranscoder_t) const;
    i_pInBuf      pointer value;
    i_size        int(10) const;
    o_pOutBuf     pointer;
  end-pi;

  //  Return value
  dcl-s rc int(10) inz(0);

  //  Helper fields
  dcl-s pOutBuf pointer;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  checkHandle(i_hTranscoder);

  o_pOutBuf = *null;
  pOutBuf   = *null;

  //  performTranslation() sends CPF9897 on error. For an empty
  //  input buffer it returns 0 and o_pOutBuf stays *null.
  rc = performTranslation(i_hTranscoder
                          : i_pInBuf
                          : i_size
                          : pOutBuf
                          : -1);

  o_pOutBuf = pOutBuf;

  return rc;

end-proc;

//=====================================================================*
//  Translates a given buffer.
//=========================================================================
//  Parameters:
//   i_hTranscoder - Handle of the character transcoder.
//   i_pInBuf      - Pointer to the input buffer.
//   i_size        - Current size of the input buffer.
//   i_maxSize     - Optional. Maximum size of the input buffer.
//   o_msg         - Optional. Error message.

//  Returns:
//   rc            - Returns the new length of the buffer.
//                   Sends escape message CPF9897 on error.
//=====================================================================*
dcl-proc Transcoder_xlateBuffer export;
  dcl-pi *n int(10) opdesc;
    i_hTranscoder like(hTranscoder_t) const;
    i_pInBuf      pointer value;
    i_size        int(10) const;
    i_maxSize     int(10) options(*nopass: *omit) const;
  end-pi;

  //  Return value
  dcl-s rc int(10) inz(0);

  //  Fields for optional parameters
  dcl-s maxSize like(i_maxSize);

  //  Helper fields
  dcl-s pOutBuf pointer;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  checkHandle(i_hTranscoder);

  if (%parms() >= %parmnum(i_maxSize) and %addr(i_maxSize) <> *null);
    maxSize = i_maxSize;
  else;
    maxSize = i_size;
  endif;

  pOutBuf = *null;

  //  performTranslation() sends CPF9897 on error.
  rc = performTranslation(i_hTranscoder
                          : i_pInBuf
                          : i_size
                          : pOutBuf
                          : maxSize);

  if (rc > 0);
    memcpy(i_pInBuf: pOutBuf: rc);
  endif;

  if (pOutBuf <> *null);
    dealloc(n) pOutBuf;
  endif;

  return rc;

end-proc;

//=====================================================================*
//  Translates a given varying string.
//=========================================================================
//  Parameters:
//   i_hTranscoder - Handle of the character transcoder.
//   i_string      - Varying field containing the input data.
//   o_msg         - Optional. Error message.

//  Returns:
//   string        - Varying field containing the translated data.
//                   Sends escape message CPF9897 on error.
//=====================================================================*
dcl-proc Transcoder_xlateString export;
  dcl-pi *n varchar(32767) opdesc;
    i_hTranscoder like(hTranscoder_t) const;
    i_string      varchar(32767) options(*varsize) const;
  end-pi;

  //  Return value (data covers all 32767 bytes of the string)
  dcl-ds rtn qualified;
    string varchar(32767);
    len    int(5) pos(1);
    data   char(32767) pos(3);
  end-ds;

  //  Helper fields
  dcl-s pInBuf pointer;
  dcl-s pOutBuf pointer;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  checkHandle(i_hTranscoder);

  rtn.string = i_string;

  pInBuf  = %addr(rtn.data);
  pOutBuf = *null;

  //  performTranslation() sends CPF9897 on error.
  rtn.len = performTranslation(i_hTranscoder
                               : pInBuf
                               : %len(i_string)
                               : pOutBuf
                               : %size(rtn.data));

  if (rtn.len > 0);
    memcpy(%addr(rtn.data): pOutBuf: rtn.len);
  endif;

  if (pOutBuf <> *null);
    dealloc(n) pOutBuf;
  endif;

  return rtn.string;

end-proc;

//=====================================================================*
//  Returns the "from CCSID".
//=========================================================================
//  Parameters:
//   i_hTranscoder - Handle of the character transcoder.

//  Returns:
//   ccsid         - CCSID, a given buffer or string is translated from.
//=====================================================================*
dcl-proc Transcoder_getFromCcsid export;
  dcl-pi *n int(10);
    i_hTranscoder like(hTranscoder_t) const;
  end-pi;

  //  Transcoder handle
  dcl-ds transcoder likeds(transcoder_t) based(i_hTranscoder);
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  checkHandle(i_hTranscoder);

  return transcoder.fromCcsid;

end-proc;

//=====================================================================*
//  Returns the "to CCSID".
//=========================================================================
//  Parameters:
//   i_hTranscoder - Handle of the character transcoder.

//  Returns:
//   ccsid         - CCSID, a given buffer or string is translated to.
//=====================================================================*
dcl-proc Transcoder_getToCcsid export;
  dcl-pi *n int(10);
    i_hTranscoder like(hTranscoder_t) const;
  end-pi;

  //  Transcoder handle
  dcl-ds transcoder likeds(transcoder_t) based(i_hTranscoder);
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  checkHandle(i_hTranscoder);

  return transcoder.toCcsid;

end-proc;

//=====================================================================*
//  Terminates character translation.
//=====================================================================*
dcl-proc Transcoder_delete export;
  dcl-pi *n;
    io_hTranscoder like(hTranscoder_t);
  end-pi;

  //  Helper fields
  dcl-s x int(10);
  dcl-s y int(10);

  //  Transcoder handle
  dcl-ds transcoder likeds(transcoder_t) based(io_hTranscoder);
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  checkHandle(io_hTranscoder);

  //  Remove the transcoder from the list of created transcoders,
  //  otherwise Transcoder_toJobCcsid() would return the deleted
  //  handle.
  for x = 1 to g_transcoders.numE;
    if (g_transcoders.item(x).hTranscoder = io_hTranscoder);
      for y = x to g_transcoders.numE - 1;
        g_transcoders.item(y) = g_transcoders.item(y + 1);
      endfor;
      clear g_transcoders.item(g_transcoders.numE);
      g_transcoders.numE = g_transcoders.numE - 1;
      leave;
    endif;
  endfor;

  iconv_close(transcoder.hIconv);
  clear transcoder;

  dealloc(n) io_hTranscoder;

  return;

end-proc;

//=====================================================================*
//  Deletes all transcoders created by Transcoder_toJobCcsid() and
//  Transcoder_toFieldCcsid() and forgets the job CCSID. Called at
//  the start of Peek, so that a changed job CCSID (CHGJOB) is used.
//=====================================================================*
dcl-proc Transcoder_reset export;
  dcl-pi *n;
  end-pi;

  dcl-s hTranscoder like(hTranscoder_t);
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  dow (g_transcoders.numE > 0);
    hTranscoder = g_transcoders.item(g_transcoders.numE).hTranscoder;
    Transcoder_delete(hTranscoder);
  enddo;

  g_jobCcsid = 0;

  return;

end-proc;

//=====================================================================*
//  Returns bTrue if a given Transcoder handle is NULL.
//=====================================================================*
dcl-proc Transcoder_isNull export;
  dcl-pi *n ind;
    i_hTranscoder like(hTranscoder_t) const;
  end-pi;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  if (i_hTranscoder = Transcoder_null());
    return bTrue;
  else;
    return bFalse;
  endif;

end-proc;

//=====================================================================*
//  Returns a Transcoder NULL-handle.
//=====================================================================*
dcl-proc Transcoder_null export;
  dcl-pi *n like(hTranscoder_t);
  end-pi;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  return *null;

end-proc;

//=====================================================================*
//  *** private ***
//  Performs charcater translation. Returns the length of the
//  transcoded buffer.
//=====================================================================*
dcl-proc performTranslation;
  dcl-pi *n uns(10);
    i_hTranscoder like(hTranscoder_t) const;
    i_pInBuf      pointer value;
    i_length      int(10) const;
    o_pOutBuf     pointer;
    i_maxSize     int(10) const;
  end-pi;

  //  Return value
  dcl-s length uns(10) inz;

  //  Helper fields
  dcl-s rc uns(10) inz;
  dcl-s bytPrv uns(10) inz;
  dcl-s bytLeft uns(10) inz;
  dcl-s bufSize int(10) inz;
  dcl-s pInBuf pointer inz;
  dcl-s pOutBuf pointer inz;
  dcl-s extendSize int(10) inz;
  dcl-s isMaxSize ind inz(bFalse);
  dcl-s errNbr int(10) inz;

  //  Transcoder handle
  dcl-ds transcoder likeds(transcoder_t) based(i_hTranscoder);
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  //  Nothing to translate: %alloc(0) is not allowed (RNX0425).
  if (i_length <= 0);
    return 0;
  endif;

  bytPrv    = i_length;
  bytLeft   = i_length;
  bufSize   = i_length;
  pInBuf    = i_pInBuf;
  length    = 0;

  if (o_pOutBuf = *null);
    o_pOutBuf = %alloc(bufSize);
  endif;

  if (i_maxSize = -1);
    isMaxSize = bFalse;
  else;
    isMaxSize = bTrue;
  endif;

  p_clrErrno();
  dou ((rc <> cICONV_ERROR) or (f_errno() <> e2big_c or
        (isMaxSize and bufSize >= i_maxSize)));

    if (f_errno() = e2big_c);
      if (isMaxSize and bufSize >= i_maxSize);
        leave;
      endif;
      extendSize = bytPrv * 2;
      if (isMaxSize and (bufSize + extendSize) > i_maxSize);
        extendSize = i_maxSize - bufSize;
      endif;
      bufSize   = bufSize + extendSize;
      bytLeft   = bytLeft + extendSize;
      o_pOutBuf = %realloc(o_pOutBuf: bufSize);
    endif;

    pOutBuf = o_pOutBuf + length;
    rc = iconv(transcoder.hIconv: pInBuf: bytPrv: pOutBuf: bytLeft);
    length = pOutBuf - o_pOutBuf;

  enddo;

  if (rc = cICONV_ERROR);
    errNbr = f_errno();
    //  Release the output buffer, because the escape message
    //  skips the clean-up of the caller.
    dealloc(n) o_pOutBuf;
    if (errNbr = e2big_c);
      kill('Target buffer too small to hold result': errNbr);
    else;
      kill('Failed to transcode characters': errNbr);
    endif;
  endif;

  return length;

end-proc;

//=====================================================================*
//  *** private ***
//  Returns a transcoder that matches the specified "from CCSID"
//  from the list of created transcoders.
//=====================================================================*
dcl-proc findTranscoder;
  dcl-pi *n like(hTranscoder_t);
    i_toCcsid   uns(10) const;
    i_fromCcsid uns(10) const;
  end-pi;

  dcl-s x int(10);
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  for x = 1 to g_transcoders.numE;
    if (i_toCcsid = g_transcoders.item(x).toCcsid and
        i_fromCcsid = g_transcoders.item(x).fromCcsid);
      return g_transcoders.item(x).hTranscoder;
    endif;
  endfor;

  return Transcoder_null();

end-proc;

//=====================================================================*
//  *** private ***
//  Produces a transcoder to transcode character data from
//  and to given CCSIDs.
//=====================================================================*
dcl-proc createTranscoder;
  dcl-pi *n like(hTranscoder_t);
    i_toCcsid   uns(10) const;
    i_fromCcsid uns(10) const;
  end-pi;

  dcl-s hTranscoder like(hTranscoder_t) inz;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  if (g_transcoders.numE = %elem(g_transcoders.item));
    kill('Maximum number of transcoders reached.');
    return Transcoder_null();
  endif;

  //  Count the new transcoder only after Transcoder_new() succeeded.
  //  Transcoder_new() sends an escape message on error, which
  //  would otherwise leave an empty entry in the list.
  hTranscoder = Transcoder_new(i_toCcsid: i_fromCcsid);

  g_transcoders.numE = g_transcoders.numE + 1;

  g_transcoders.item(g_transcoders.numE).hTranscoder = hTranscoder;
  g_transcoders.item(g_transcoders.numE).toCcsid = i_toCcsid;
  g_transcoders.item(g_transcoders.numE).fromCcsid = i_fromCcsid;

  return g_transcoders.item(g_transcoders.numE).hTranscoder;

end-proc;

//=====================================================================*
//  *** private ***
//  Returns the CCSID of the current job.
//=====================================================================*
dcl-proc getJobCcsid;
  dcl-pi *n int(10);
  end-pi;

  dcl-ds jobi0400 likeds(jobi0400_t) inz;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  if (g_jobCcsid > 0);
    return g_jobCcsid;
  endif;

  qusrjobi(jobi0400: %size(jobi0400): 'JOBI0400': '*': '');
  if (jobi0400.ccsid = 65535);
    g_jobCcsid = jobi0400.dftCcsid;
  else;
    g_jobCcsid = jobi0400.ccsid;
  endif;

  return g_jobCcsid;

end-proc;

//=====================================================================*
//  *** private ***
//  Kills utility with an ESCAPE message, if a given handle is not
//  a transcoder (*null, deleted or a foreign pointer).
//=====================================================================*
dcl-proc checkHandle;
  dcl-pi *n;
    i_hTranscoder like(hTranscoder_t) const;
  end-pi;

  //  Transcoder handle
  dcl-ds transcoder likeds(transcoder_t) based(i_hTranscoder);
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  if (i_hTranscoder = *null);
    kill('Invalid transcoder handle: *NULL');
  endif;

  if (transcoder.class.name <> class_transcoder);
    kill('Invalid transcoder handle');
  endif;

end-proc;

//=====================================================================*
//  *** private ***
//  Kills utility with an ESCAPE message.
//  i_errno is optional. If passed, the message contains the
//  error number and its text, e.g.:
//    Failed to transcode characters (errno 3491): <text>
//=====================================================================*
dcl-proc kill;
  dcl-pi *n;
    i_text  varchar(128) const;
    i_errno int(10) options(*nopass) const;
  end-pi;

  dcl-s text varchar(512) inz;
  dcl-s msgKey char(4) inz;
  dcl-ds qMsgF likeds(qObj_t) inz;
  dcl-ds errCode likeds(errCode_t) inz;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  if (%parms() >= %parmnum(i_errno));
    text = i_text + ' (errno ' + %char(i_errno) + '): '
           + %trimr(f_strError(i_errno));
  else;
    text = i_text;
  endif;

  qMsgF.name = 'QCPFMSG';
  qMsgF.lib  = '*LIBL';

  clear errCode;
  errCode.bytPrv = %size(errCode);

  //  Send the escape message to the caller of this service
  //  program, so that it does not pass the control boundary.
  qmhsndpm('CPF9897': qMsgF: text: %len(text): '*ESCAPE'
           : '*PGMBDY': 1: msgKey: errCode);

end-proc;

