**FREE
/IF NOT DEFINED(PPEEK71)
/DEFINE PPEEK71

//  Transcoder handle.
dcl-s htranscoder_t   pointer template;

//  Returns a Transcoder to convert from a
//  given CCSID to the job CCSID.
dcl-pr transcoder_tojobccsid
       like(htranscoder_t )
       extproc('PEEK71_+
       Transcoder_toJobCcsid+
       ');
  i_fromccsid     uns(10) const;
end-pr;

//  Returns a Transcoder to convert from a
//  given CCSID to the CCSID of the file field.
dcl-pr transcoder_tofieldccsid
       like(htranscoder_t )
       extproc('PEEK71_+
       Transcoder_toFieldCcsid+
       ');
  i_toccsid       uns(10) const;
end-pr;

//  Initializes character translation.
dcl-pr transcoder_new
       like(htranscoder_t )
       extproc('PEEK71_+
       Transcoder_new+
       ');
  i_toccsid       uns(10) const;
  i_fromccsid     uns(10) const;
end-pr;

//  Translate a given buffer using dynamic memory allocation.
dcl-pr transcoder_xlateraw
       int(10) opdesc
       extproc('PEEK71_+
       Transcoder_xlateRaw+
       ');
  i_htranscoder   const  like(htranscoder_t );
  i_pinbuf        pointer value;
  i_size          int(10) const;
  o_poutbuf       pointer;
end-pr;

//  Translate a given buffer.
dcl-pr transcoder_xlatebuffer
       int(10) opdesc
       extproc('PEEK71_+
       Transcoder_xlateBuffer+
       ');
  i_htranscoder   const  like(htranscoder_t );
  i_pinbuf        pointer value;
  i_size          int(10) const;
  i_maxsize       int(10) const  options(*nopass: *omit);
end-pr;

//  Translate a given varying string.
dcl-pr transcoder_xlatestring
       varchar(32767) opdesc
       extproc('PEEK71_+
       Transcoder_xlateString+
       ');
  i_htranscoder   const  like(htranscoder_t );
  i_string        varchar(32767) const   options(*varsize);
end-pr;

//  Returns the "from CCSID".
dcl-pr transcoder_getfromccsid
       int(10)
       extproc('PEEK71_+
       Transcoder_getFromCcsid+
       ');
  i_htranscoder   const  like(htranscoder_t );
end-pr;

//  Returns the "to CCSID".
dcl-pr transcoder_gettoccsid
       int(10)
       extproc('PEEK71_+
       Transcoder_getToCcsid+
       ');
  i_htranscoder   const  like(htranscoder_t );
end-pr;

//  Terminates character translation.
dcl-pr transcoder_delete
       extproc('PEEK71_+
       Transcoder_delete+
       ');
  io_htranscoder
       like(htranscoder_t );
end-pr;

//  Returns a Transcoder NULL-handle.
dcl-pr transcoder_null
       like(htranscoder_t )
       extproc('PEEK71_+
       Transcoder_null+
       ');
end-pr;

//  Returns cTrue if a given Transcoder handle is NULL.
dcl-pr transcoder_isnull
       ind
       extproc('PEEK71_+
       Transcoder_isNull+
       ');
  i_htranscoder   const  like(htranscoder_t );
end-pr;

//  Deletes the transcoders created by transcoder_toJobCcsid() and
//  transcoder_toFieldCcsid() and forgets the job CCSID.
dcl-pr transcoder_reset
       extproc('PEEK71_+
       Transcoder_reset+
       ');
end-pr;

/ENDIF
