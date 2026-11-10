**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - Konvertieren Datenformat für Kurzbefehl      *
      //%EMETADATA                                                     *
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 3.1.0                               *
//  Programm : PEEK65                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 31.07.2008  Raddatz                               *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Konvertieren Datenformat für Kurzbefehl                      *
//                                                               *
// ============================================================= *
/copy 'qcopyle/h_spec.rpgleinc'
/copy 'qcopyle/copyright.rpgleinc'

/copy 'qcopyle/d_clib.rpgleinc'
/copy 'qcopyle/d_vardef.rpgleinc'
/copy 'qcopyle/fldl0100.rpgleinc'
/copy 'qcopyle/d_mi.rpgleinc'
/copy 'qcopyle/sds.rpgleinc'
/copy 'qcopyle/ceecndhdlr.rpgleinc'

/define internal_prototype
/copy 'qcopyle/ppeek66.rpgleinc'
/undefine internal_prototype

/copy 'qcopyle/ppeek53.rpgleinc'
/copy 'qcopyle/ppeek58.rpgleinc'

dcl-s numeric_t packed(31: 10) template;
dcl-c cDATA_TYPE 'P';
dcl-c cDIGITS %len(numeric_t);
dcl-c cDECPOS %decpos(numeric_t);

dcl-c cCHR_X 'x';
dcl-c cQUOTE '''';

dcl-pr main extproc('main');
  io_buffer   like(gio_buffer);
  io_length   like(gio_length);
  i_inFormat  likeds(gi_inFormat) const;
  i_outFormat likeds(gi_outFormat) const;
  o_msgID     like(go_msgID);
  o_msgDta    like(go_msgDta);
end-pr;

//  Convert from numeric value.
dcl-pr convertFromNumeric extproc('convertFromNumeric');
  io_buffer   like(gio_buffer);
  io_length   like(gio_length);
  i_outFormat likeds(gi_outFormat) const;
  o_msgID     like(go_msgID);
  o_msgDta    like(go_msgDta);
end-pr;

//  Convert from string value.
dcl-pr convertFromString extproc('convertFromString');
  io_buffer   like(gio_buffer);
  io_length   like(gio_length);
  i_outFormat likeds(gi_outFormat) const;
  o_msgID     like(go_msgID);
  o_msgDta    like(go_msgDta);
end-pr;

//  Convert to numeric value.
dcl-pr convertToNumeric extproc('convertToNumeric');
  io_buffer   like(gio_buffer);
  io_length   like(gio_length);
  i_outFormat likeds(gi_outFormat) const;
  o_msgID     like(go_msgID);
  o_msgDta    like(go_msgDta);
end-pr;

//  Convert to string value.
dcl-pr convertToString extproc('convertToString');
  io_buffer   like(gio_buffer);
  io_length   like(gio_length);
  i_outFormat likeds(gi_outFormat) const;
  o_msgID     like(go_msgID);
  o_msgDta    like(go_msgDta);
end-pr;

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************

// ENTRY-LISTE
dcl-pi peek66;
  gio_buffer   like(cmdBuffer_t);
  gio_length   like(int4_t);
  gi_inFormat  likeds(fldl0100_t) const;
  gi_outFormat likeds(fldl0100_t) const;
  go_msgID     like(msgId_t);
  go_msgDta    like(msgDta_t);
end-pi;
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

//  Register error handler
ceehdlr(%paddr('errorHandler'): *null: *omit);

main(gio_buffer
     : gio_length
     : gi_inFormat
     : gi_outFormat
     : go_msgID
     : go_msgDta);

return;


//========================================================================*
//  Main - Prozedur
//========================================================================*
dcl-proc main;
  dcl-pi *n;
    io_buffer   like(gio_buffer);
    io_length   like(gio_length);
    i_inFormat  likeds(gi_inFormat) const;
    i_outFormat likeds(gi_outFormat) const;
    o_msgID     like(go_msgID);
    o_msgDta    like(go_msgDta);
  end-pi;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  clear o_msgID;
  clear o_msgDta;

  if (f_isNumFld(i_inFormat) = bTrue);
    convertFromNumeric(io_buffer: io_length: i_outFormat
                       : o_msgID: o_msgDta);
  else;
    convertFromString(io_buffer: io_length: i_outFormat
                       : o_msgID: o_msgDta);
  endif;

end-proc;

//========================================================================*
//  Convert from numeric value.
//========================================================================*
dcl-proc convertFromNumeric;
  dcl-pi *n;
    io_buffer   like(gio_buffer);
    io_length   like(gio_length);
    i_outFormat likeds(gi_outFormat) const;
    o_msgID     like(go_msgID);
    o_msgDta    like(go_msgDta);
  end-pi;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  if (f_isNumFld(i_outFormat) = bTrue);
    convertToNumeric(io_buffer: io_length: i_outFormat
                     : o_msgID: o_msgDta);
  else;
    convertToString(io_buffer: io_length: i_outFormat
                    : o_msgID: o_msgDta);
  endif;

end-proc;

//========================================================================*
//  Convert from string value.
//========================================================================*
dcl-proc convertFromString;
  dcl-pi *n;
    io_buffer   like(gio_buffer);
    io_length   like(gio_length);
    i_outFormat likeds(gi_outFormat) const;
    o_msgID     like(go_msgID);
    o_msgDta    like(go_msgDta);
  end-pi;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  if (f_isNumFld(i_outFormat) = bTrue);
    convertToNumeric(io_buffer: io_length: i_outFormat
                     : o_msgID: o_msgDta);
  else;
    convertToString(io_buffer: io_length: i_outFormat
                    : o_msgID: o_msgDta);
  endif;

end-proc;

//========================================================================*
//  Convert to numeric value.
//========================================================================*
dcl-proc convertToNumeric;
  dcl-pi *n;
    io_buffer   like(gio_buffer);
    io_length   like(gio_length);
    i_outFormat likeds(gi_outFormat) const;
    o_msgID     like(go_msgID);
    o_msgDta    like(go_msgDta);
  end-pi;

  //  Arbeitsfelder
  dcl-s isOneByteInt like(bool_t);
  dcl-s oneByteIntAdjust int(10);
  dcl-s inNumeric like(numeric_t);
  dcl-s tmpBuffer like(io_buffer);
  dcl-s digits int(10);
  dcl-s inBuffer like(io_buffer);
  dcl-s inLength like(io_length);

/copy 'qcopyle/usr8227.rpgleinc'
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  monitor;
    inNumeric = %dec(%subst(io_buffer: 1: io_length): cDIGITS: cDECPOS);
  on-error;
    clear usr8227;
    usr8227.var1 = %subst(io_buffer: 1: io_length);
    usr8227.var2 = cDATA_TYPE;
    usr8227.var3 = cDIGITS;
    usr8227.var4 = cDECPOS;
    o_msgID  = 'USR8227';
    o_msgDta = usr8227;
    return;
  endmon;

  if ((i_outFormat.f1DTyp = 'B' or
       i_outFormat.f1DTyp = 'I' or
       i_outFormat.f1DTyp = 'U')
     and f_rpgToIntLength(i_outFormat.f1Digt) = 1);
    isOneByteInt = bTrue;
    oneByteIntAdjust = 1;
  else;
    isOneByteInt = bFalse;
    oneByteIntAdjust = 0;
  endif;

  if (f_isFloatFld(i_outFormat) = bTrue);
    digits = i_outFormat.f1FLen;
  else;
    digits = i_outFormat.f1Digt;
  endif;

  inBuffer = io_buffer;
  inLength = io_length;

  clear io_buffer;
  clear io_length;

  //  Passt der Wert nicht in das Ausgabeformat, meldet CPYNV
  //  MCH1210 (Empfänger zu klein).
  monitor;
    cpynv(f_num_descr2(i_outFormat.f1DTyp
                       : digits + oneByteIntAdjust
                       : i_outFormat.f1DecP)
          : %addr(io_buffer)
          : f_num_descr2(cDATA_TYPE
                         : %len(inNumeric)
                         : %decpos(inNumeric))
          : %addr(inNumeric));
  on-error;
    io_buffer = inBuffer;
    io_length = inLength;
    clear usr8227;
    usr8227.var1 = %subst(io_buffer: 1: io_length);
    usr8227.var2 = i_outFormat.f1DTyp;
    usr8227.var3 = digits;
    usr8227.var4 = i_outFormat.f1DecP;
    o_msgID  = 'USR8227';
    o_msgDta = usr8227;
    return;
  endmon;

  if (isOneByteInt = bTrue);
    %subst(io_buffer: 1: 1) = %subst(io_buffer: 2: 1);
    %subst(io_buffer: 2: 1) = x'00';
  endif;

  select;
  when (i_outFormat.f1DTyp = 'B' or
        i_outFormat.f1DTyp = 'I' or
        i_outFormat.f1DTyp = 'U');
    io_length = f_rpgToIntLength(i_outFormat.f1Digt);
  when (i_outFormat.f1DTyp = 'P');
    io_length = %int(i_outFormat.f1Digt / 2) + 1;
  when (i_outFormat.f1DTyp = 'S');
    io_length = i_outFormat.f1Digt;
  when (i_outFormat.f1DTyp = 'F');
    io_length = i_outFormat.f1FLen;
  endsl;

  cvthc(%addr(tmpBuffer): %addr(io_buffer): io_length * 2);
  io_length = io_length * 2;
  io_buffer = %subst(tmpBuffer: 1: io_length);

  io_buffer = cCHR_X + cQUOTE + %subst(io_buffer: 1: io_length) + cQUOTE;
  io_length = io_length + %len(cCHR_X) + %len(cQUOTE) * 2;

end-proc;

//========================================================================*
//  Convert to string value.
//========================================================================*
dcl-proc convertToString;
  dcl-pi *n;
    io_buffer   like(gio_buffer);
    io_length   like(gio_length);
    i_outFormat likeds(gi_outFormat) const;
    o_msgID     like(go_msgID);
    o_msgDta    like(go_msgDta);
  end-pi;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  io_buffer = %subst(io_buffer: 1: i_outFormat.f1FLen);
  io_length = i_outFormat.f1FLen;

end-proc;

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

