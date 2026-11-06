**free
/if NOT defined(PPEEK71)
/define PPEEK71

//  Transcoder handle.
dcl-s htranscoder_t pointer template;

//  Returns a Transcoder to convert from a
//  given CCSID to the job CCSID.
dcl-pr transcoder_tojobccsid like(htranscoder_t) extproc('PEEK71_Transcoder_toJobCcsid');
  i_fromccsid uns(10) const;
end-pr;

//  Returns a Transcoder to convert from a
//  given CCSID to the CCSID of the file field.
dcl-pr transcoder_tofieldccsid like(htranscoder_t) extproc('PEEK71_Transcoder_toFieldCcsid');
  i_toccsid uns(10) const;
end-pr;

//  Initializes character translation.
dcl-pr transcoder_new like(htranscoder_t) extproc('PEEK71_Transcoder_new');
  i_toccsid   uns(10) const;
  i_fromccsid uns(10) const;
end-pr;

//  Translate a given buffer using dynamic memory allocation.
dcl-pr transcoder_xlateraw int(10) opdesc extproc('PEEK71_Transcoder_xlateRaw');
  i_htranscoder like(htranscoder_t) const;
  i_pinbuf      pointer value;
  i_size        int(10) const;
  o_poutbuf     pointer;
end-pr;

//  Translate a given buffer.
dcl-pr transcoder_xlatebuffer int(10) opdesc extproc('PEEK71_Transcoder_xlateBuffer');
  i_htranscoder like(htranscoder_t) const;
  i_pinbuf      pointer value;
  i_size        int(10) const;
  i_maxsize     int(10) options(*nopass: *omit) const;
end-pr;

//  Translate a given varying string.
dcl-pr transcoder_xlatestring varchar(32767) opdesc extproc('PEEK71_Transcoder_xlateString');
  i_htranscoder like(htranscoder_t) const;
  i_string      varchar(32767) options(*varsize) const;
end-pr;

//  Returns the "from CCSID".
dcl-pr transcoder_getfromccsid int(10) extproc('PEEK71_Transcoder_getFromCcsid');
  i_htranscoder like(htranscoder_t) const;
end-pr;

//  Returns the "to CCSID".
dcl-pr transcoder_gettoccsid int(10) extproc('PEEK71_Transcoder_getToCcsid');
  i_htranscoder like(htranscoder_t) const;
end-pr;

//  Terminates character translation.
dcl-pr transcoder_delete extproc('PEEK71_Transcoder_delete');
  io_htranscoder like(htranscoder_t);
end-pr;

//  Returns a Transcoder NULL-handle.
dcl-pr transcoder_null like(htranscoder_t) extproc('PEEK71_Transcoder_null');
end-pr;

//  Returns cTrue if a given Transcoder handle is NULL.
dcl-pr transcoder_isnull ind extproc('PEEK71_Transcoder_isNull');
  i_htranscoder like(htranscoder_t) const;
end-pr;

//  Deletes the transcoders created by transcoder_toJobCcsid() and
//  transcoder_toFieldCcsid() and forgets the job CCSID.
dcl-pr transcoder_reset extproc('PEEK71_Transcoder_reset');
end-pr;

/endif
