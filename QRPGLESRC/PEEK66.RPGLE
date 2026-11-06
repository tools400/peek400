**free
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

/copy QCOPYLE,D_CLib
/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,D_MI
/copy QCOPYLE,SDS
/copy QCOPYLE,CEECNDHDLR

/define internal_prototype
/copy QCOPYLE,PPEEK66
/undefine internal_prototype

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

dcl-s numeric_t packed(31: 10) template;
dcl-c cDATA_TYPE 'P';
dcl-c cDIGITS %len(numeric_t);
dcl-c cDECPOS %decpos(numeric_t);

dcl-c cCHR_X 'x';
dcl-c cQUOTE '''';

dcl-pr main extproc('main');
  io_buffer   like(gio_buffer);
  io_Length   like(gio_length);
  i_InFormat  likeds(gi_inFormat) const;
  i_OutFormat likeds(gi_outFormat) const;
  o_msgID     like(go_msgID);
  o_msgDta    like(go_msgDta);
end-pr;

//  Convert from numeric value.
dcl-pr convertFromNumeric extproc('convertFromNumeric');
  io_buffer   like(gio_buffer);
  io_Length   like(gio_length);
  i_OutFormat likeds(gi_outFormat) const;
  o_msgID     like(go_msgID);
  o_msgDta    like(go_msgDta);
end-pr;

//  Convert from string value.
dcl-pr convertFromString extproc('convertFromString');
  io_buffer   like(gio_buffer);
  io_Length   like(gio_length);
  i_OutFormat likeds(gi_outFormat) const;
  o_msgID     like(go_msgID);
  o_msgDta    like(go_msgDta);
end-pr;

//  Convert to numeric value.
dcl-pr convertToNumeric extproc('convertToNumeric');
  io_buffer   like(gio_buffer);
  io_Length   like(gio_length);
  i_OutFormat likeds(gi_outFormat) const;
  o_msgID     like(go_msgID);
  o_msgDta    like(go_msgDta);
end-pr;

//  Convert to string value.
dcl-pr convertToString extproc('convertToString');
  io_buffer   like(gio_buffer);
  io_Length   like(gio_length);
  i_OutFormat likeds(gi_outFormat) const;
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
    io_Length   like(gio_length);
    i_InFormat  likeds(gi_inFormat) const;
    i_OutFormat likeds(gi_outFormat) const;
    o_msgID     like(go_msgID);
    o_msgDta    like(go_msgDta);
  end-pi;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  clear o_msgID;
  clear o_msgDta;

  if (f_isNumFld(i_InFormat) = bTrue);
    convertFromNumeric(io_buffer: io_Length: i_OutFormat
                       : o_msgID: o_msgDta);
  else;
    convertFromString(io_buffer: io_Length: i_OutFormat
                       : o_msgID: o_msgDta);
  endif;

end-proc;

//========================================================================*
//  Convert from numeric value.
//========================================================================*
dcl-proc convertFromNumeric;
  dcl-pi *n;
    io_buffer   like(gio_buffer);
    io_Length   like(gio_length);
    i_OutFormat likeds(gi_outFormat) const;
    o_msgID     like(go_msgID);
    o_msgDta    like(go_msgDta);
  end-pi;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  if (f_isNumFld(i_OutFormat) = bTrue);
    convertToNumeric(io_buffer: io_Length: i_OutFormat
                     : o_msgID: o_msgDta);
  else;
    convertToString(io_buffer: io_Length: i_OutFormat
                    : o_msgID: o_msgDta);
  endif;

end-proc;

//========================================================================*
//  Convert from string value.
//========================================================================*
dcl-proc convertFromString;
  dcl-pi *n;
    io_buffer   like(gio_buffer);
    io_Length   like(gio_length);
    i_OutFormat likeds(gi_outFormat) const;
    o_msgID     like(go_msgID);
    o_msgDta    like(go_msgDta);
  end-pi;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  if (f_isNumFld(i_OutFormat) = bTrue);
    convertToNumeric(io_buffer: io_Length: i_OutFormat
                     : o_msgID: o_msgDta);
  else;
    convertToString(io_buffer: io_Length: i_OutFormat
                    : o_msgID: o_msgDta);
  endif;

end-proc;

//========================================================================*
//  Convert to numeric value.
//========================================================================*
dcl-proc convertToNumeric;
  dcl-pi *n;
    io_buffer   like(gio_buffer);
    io_Length   like(gio_length);
    i_OutFormat likeds(gi_outFormat) const;
    o_msgID     like(go_msgID);
    o_msgDta    like(go_msgDta);
  end-pi;

  //  Arbeitsfelder
  dcl-s isOneByteInt like(bool_t);
  dcl-s oneByteIntAdjust int(10);
  dcl-s inNumeric like(numeric_t);
  dcl-s tmpBuffer like(io_buffer);
  dcl-s digits int(10);
  dcl-s inbuffer like(io_buffer);
  dcl-s inlength like(io_Length);

/copy QCOPYLE,USR8227
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  monitor;
    inNumeric = %dec(%subst(io_buffer: 1: io_Length): cDIGITS: cDECPOS);
  on-error;
    clear usr8227;
    usr8227.var1 = %subst(io_buffer: 1: io_Length);
    usr8227.var2 = cDATA_TYPE;
    usr8227.var3 = cDIGITS;
    usr8227.var4 = cDECPOS;
    o_msgID  = 'USR8227';
    o_msgDta = usr8227;
    return;
  endmon;

  if ((i_OutFormat.F1DTyp = 'B' or
       i_OutFormat.F1DTyp = 'I' or
       i_OutFormat.F1DTyp = 'U')
     and f_rpgToIntLength(i_OutFormat.f1digt) = 1);
    isOneByteInt = bTrue;
    oneByteIntAdjust = 1;
  else;
    isOneByteInt = bFalse;
    oneByteIntAdjust = 0;
  endif;

  if (f_isFloatFld(i_OutFormat) = bTrue);
    digits = i_OutFormat.f1flen;
  else;
    digits = i_OutFormat.f1digt;
  endif;

  inbuffer = io_buffer;
  inlength = io_Length;

  clear io_buffer;
  clear io_Length;

  //  Passt der Wert nicht in das Ausgabeformat, meldet CPYNV
  //  MCH1210 (Empfänger zu klein).
  monitor;
    cpynv(f_NUM_Descr2(i_OutFormat.F1DTyp
                       : digits + oneByteIntAdjust
                       : i_OutFormat.f1decp)
          : %addr(io_buffer)
          : f_NUM_Descr2(cDATA_TYPE
                         : %len(inNumeric)
                         : %decpos(inNumeric))
          : %addr(inNumeric));
  on-error;
    io_buffer = inbuffer;
    io_Length = inlength;
    clear usr8227;
    usr8227.var1 = %subst(io_buffer: 1: io_Length);
    usr8227.var2 = i_OutFormat.F1DTyp;
    usr8227.var3 = digits;
    usr8227.var4 = i_OutFormat.f1decp;
    o_msgID  = 'USR8227';
    o_msgDta = usr8227;
    return;
  endmon;

  if (isOneByteInt = bTrue);
    %subst(io_buffer: 1: 1) = %subst(io_buffer: 2: 1);
    %subst(io_buffer: 2: 1) = x'00';
  endif;

  select;
  when (i_OutFormat.F1DTyp = 'B' or
        i_OutFormat.F1DTyp = 'I' or
        i_OutFormat.F1DTyp = 'U');
    io_Length = f_rpgToIntLength(i_OutFormat.f1digt);
  when (i_OutFormat.F1DTyp = 'P');
    io_Length = %int(i_OutFormat.f1digt / 2) + 1;
  when (i_OutFormat.F1DTyp = 'S');
    io_Length = i_OutFormat.f1digt;
  when (i_OutFormat.F1DTyp = 'F');
    io_Length = i_OutFormat.f1flen;
  endsl;

  cvthc(%addr(tmpBuffer): %addr(io_buffer): io_Length * 2);
  io_Length = io_Length * 2;
  io_buffer = %subst(tmpBuffer: 1: io_Length);

  io_buffer = cCHR_X + cQUOTE + %subst(io_buffer: 1: io_Length) + cQUOTE;
  io_Length = io_Length + %len(cCHR_X) + %len(cQUOTE) * 2;

end-proc;

//========================================================================*
//  Convert to string value.
//========================================================================*
dcl-proc convertToString;
  dcl-pi *n;
    io_buffer   like(gio_buffer);
    io_Length   like(gio_length);
    i_OutFormat likeds(gi_outFormat) const;
    o_msgID     like(go_msgID);
    o_msgDta    like(go_msgDta);
  end-pi;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  io_buffer = %subst(io_buffer: 1: i_OutFormat.f1flen);
  io_Length = i_OutFormat.f1flen;

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

