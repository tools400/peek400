**free
/if NOT defined(PPEEK71)
/define PPEEK71

//  Transcoder handle.
dcl-s hTranscoder_t pointer template;

//  Returns a Transcoder to convert from a
//  given CCSID to the job CCSID.
dcl-pr Transcoder_toJobCcsid like(hTranscoder_t) extproc('PEEK71_Transcoder_toJobCcsid');
  i_fromCcsid uns(10) const;
end-pr;

//  Returns a Transcoder to convert from a
//  given CCSID to the CCSID of the file field.
dcl-pr Transcoder_toFieldCcsid like(hTranscoder_t) extproc('PEEK71_Transcoder_toFieldCcsid');
  i_toCcsid uns(10) const;
end-pr;

//  Initializes character translation.
dcl-pr Transcoder_new like(hTranscoder_t) extproc('PEEK71_Transcoder_new');
  i_toCcsid   uns(10) const;
  i_fromCcsid uns(10) const;
end-pr;

//  Translate a given buffer using dynamic memory allocation.
dcl-pr Transcoder_xlateRaw int(10) opdesc extproc('PEEK71_Transcoder_xlateRaw');
  i_hTranscoder like(hTranscoder_t) const;
  i_pInBuf      pointer value;
  i_size        int(10) const;
  o_pOutBuf     pointer;
end-pr;

//  Translate a given buffer.
dcl-pr Transcoder_xlateBuffer int(10) opdesc extproc('PEEK71_Transcoder_xlateBuffer');
  i_hTranscoder like(hTranscoder_t) const;
  i_pInBuf      pointer value;
  i_size        int(10) const;
  i_maxSize     int(10) options(*nopass: *omit) const;
end-pr;

//  Translate a given varying string.
dcl-pr Transcoder_xlateString varchar(32767) opdesc extproc('PEEK71_Transcoder_xlateString');
  i_hTranscoder like(hTranscoder_t) const;
  i_string      varchar(32767) options(*varsize) const;
end-pr;

//  Returns the "from CCSID".
dcl-pr Transcoder_getFromCcsid int(10) extproc('PEEK71_Transcoder_getFromCcsid');
  i_hTranscoder like(hTranscoder_t) const;
end-pr;

//  Returns the "to CCSID".
dcl-pr Transcoder_getToCcsid int(10) extproc('PEEK71_Transcoder_getToCcsid');
  i_hTranscoder like(hTranscoder_t) const;
end-pr;

//  Terminates character translation.
dcl-pr Transcoder_delete extproc('PEEK71_Transcoder_delete');
  io_hTranscoder like(hTranscoder_t);
end-pr;

//  Returns a Transcoder NULL-handle.
dcl-pr Transcoder_null like(hTranscoder_t) extproc('PEEK71_Transcoder_null');
end-pr;

//  Returns cTrue if a given Transcoder handle is NULL.
dcl-pr Transcoder_isNull ind extproc('PEEK71_Transcoder_isNull');
  i_hTranscoder like(hTranscoder_t) const;
end-pr;

//  Deletes the transcoders created by Transcoder_toJobCcsid() and
//  Transcoder_toFieldCcsid() and forgets the job CCSID.
dcl-pr Transcoder_reset extproc('PEEK71_Transcoder_reset');
end-pr;

/endif
