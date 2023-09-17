 DEF  /IF NOT DEFINED(CLIB2)
 DEF  /DEFINE CLIB2
      *
      *  File open feedback data structure
     D RFILE_t         DS                  based(pDummy)         qualified
     D  res01                        16A
     D  pInBuf                         *
     D  pOutBuf                        *
     D  res02                        48A
      /if not defined(*V5R3M0)
     D  riofb                              like(RIOFB_t)
      /else
     D  riofb                              likeds(RIOFB_t)
      /endif
     D  res03                        32A
     D  bufLen                       10U 0
     D  res04                        28A
     D  pInNull                        *
     D  pOutNul                        *
     D  pKeyNul                        *
     D  res05                        48A
     D  minLen                       10I 0
     D  nMapLen                       5I 0
     D  nKeyLen                       5I 0
     D  res06                         8A
      *
      *  Record IO feedback data structure
     D RIOFB_t         DS                  based(pDummy)  align  qualified
     D  pKey                           *
     D  pSysP                          *
     D  rrn                          10U 0
     D  numByt                       10I 0
     D  blkCnt                        5I 0
     D  blkFld                        1A
     D  bitfld                        1A
     D   dupKy                        1A   overlay(bitfld: 1)
     D   icfLc                        1A   overlay(bitfld: 1)
     D   res01                        1A   overlay(bitfld: 1)
     D  res02                        20A
      *
      *  Record IO feedback data structure
     D XXIOFB_t        DS                  based(pDummy)  qualified
     D  file_dep_fb_offset...
     D                                5I 0
     D  write_count                  10I 0
     D  read_count                   10I 0
     D  write_read_count...
     D                               10I 0
     D  other_io_count...
     D                               10I 0
     D  reserved1                     1A
     D  cur_operation                 1A
     D  rec_format                   10A
     D  dev_class                     2A
     D  dev_name                     10A
     D  last_io_rec_len...
     D                               10I 0
     D  reserved2                    80A
     D  num_recs_retrieved...
     D                                5I 0
     D  last_io_rec_len2...
     D                                5I 0
     D  reserved3                     2A
     D  cur_blk_count                10I 0
     D  reserved4                     8A
      *
     D XXIOFB_DB_T     DS                  based(pDummy)  qualified
     D  db_fdbk_size                 10I 0
     D  join_default_flags...
     D                                4A
     D  reserved1                     2A
     D  num_locked_recs...
     D                                5I 0
     D  fields_in_fmt                 5I 0
     D  reserved2                     4A
     D  reserved3                     1A
     D  flags                         3I 0
     D  num_key_fields...
     D                                5I 0
     D  reserved4                     4A
     D  key_len                       5U 0
     D  data_mbr_num                  5I 0
     D  data_mbr_RRN                 10U 0
     D  key_value                     1A   dim(MAX_KEY_SIZE)
      *
     D MAX_KEY_SIZE    C                   32768
      *
      *  Constants used by IO feedback procedures
     D RRN_EQ          C                   const(x'08000300')
      *
     D KEY_EQ          C                   const(x'0B000100')
     D KEY_GT          C                   const(x'0D000100')
     D KEY_LT          C                   const(x'09000100')
     D KEY_LE          C                   const(x'0A000100')
     D KEY_GE          C                   const(x'0C000100')
     D KEY_NEXTUNQ     C                   const(x'05000100')
     D KEY_PREVUNQ     C                   const(x'06000100')
     D KEY_NEXTEQ      C                   const(x'0E000100')
     D KEY_PREVEQ      C                   const(x'0F000100')
      *
     D FIRST           C                   const(x'01000300')
     D LAST            C                   const(x'02000300')
     D NEXT            C                   const(x'03000300')
     D PREVIOUS        C                   const(x'04000300')
      *
     D START_FRC       C                   const(x'03000004')
     D START           C                   const(x'01000004')
     D END_FRC         C                   const(x'04000004')
     D END             C                   const(x'02000004')
      *
     D NO_LOCK         C                   const(x'00000001')
     D DFT             C                   const(x'0B000100')
     D NO_POSITION     C                   const(x'00100000')
     D PRIOR           C                   const(x'00001000')
     D DATA_ONLY       C                   const(x'00000002')
     D NULL_KEY_MAP    C                   const(x'00000008')
      *
     D EOF             C                   const(-1)
      *
      *  _Ropen -- Open a Record File for I/O Operatins                                      R
      *    #include <recio.h>
      *    _RFILE *_Ropen(const char * filename, const char * mode, ...);
     D Ropen           PR              *          extproc('C_Ropen')            _RFILE
     D  i_fileName                     *   value  options(*string)
     D  i_mode                         *   value  options(*string)
      *
      *  _Rclose -- Close a File
      *    #include <recio.h>
      *    int _Rclose(_RFILE *fp);
     D Rclose          PR            10I 0        extproc('C_Rclose')
     D  i_fp                           *   value
      *
      *  _Riofbk()  Obtain I/O Feedback Information
      *    #include <recio.h>
      *    #include <xxfdbk.h>
      *    _XXIOFB_T *_Riofbk(_RFILE *fp);
     D Riofbk          PR              *          extproc('C_Riofbk')           _XXIOFB_T
     D  i_fp                           *   value
      *
      *  _Rlocate -- Position to a Record
      *    #include <recio.h>
      *    _RIOFB_T *_Rlocate(_RFILE *fp, void *key, int klen_rrn, int opts);
     D Rlocate         PR              *          extproc('C_Rlocate')          _RIOFB_T
     D  i_fp                           *   value
     D  i_key                          *   value
     D  i_klen_rrn                   10I 0 value
     D  i_opts                       10I 0 value
      *
      *  _Rreadd -- Read a Record by Relative Record Number
      *    #include <recio.h>
      *    _RIOFB_T *_Rreadd (_RFILE *fp, void *buf, size_t size,
      *                                int opts, long rrn);
     D Rreadd          PR              *          extproc('C_Rreadd')           _RIOFB_T
     D  i_fp                           *   value
     D  i_pBuffer                      *   value
     D  i_size                       10U 0 value
     D  i_opts                       10I 0 value
     D  i_rrn                        10I 0 value
      *
      *  _Rdelete -- Delete a Record
      *    #include <recio.h>
      *    _RIOFB_T *_Rdelete(_RFILE *fp);
     D Rdelete         PR              *          extproc('C_Rdelete')          _RIOFB_T
     D  i_fp                           *   value
      *
      *  _Rreadn -- Read the next Record
      *    #include <recio.h>
      *    _RIOFB_T *_Rreadn (_RFILE *fp, void *buf, size_t size, int opts);
     D Rreadn          PR              *          extproc('C_Rreadn')           _RIOFB_T
     D  i_fp                           *   value
     D  i_pBuffer                      *   value
     D  i_size                       10U 0 value
     D  i_opts                       10I 0 value
      *
      *  _Rreadp -- Read the Previous Record
      *    #include <recio.h>
      *    _RIOFB_T *_Rreadp (_RFILE *fp, void *buf, size_t size, int opts);
     D Rreadp          PR              *          extproc('C_Rreadp')           _RIOFB_T
     D  i_fp                           *   value
     D  i_pBuffer                      *   value
     D  i_size                       10U 0 value
     D  i_opts                       10I 0 value
      *
      *  _Rreadk -- Read a Record by Key
      *    #include <recio.h>
      *    _RIOFB_T *_Rreadk(_RFILE *fp, void *buf, size_t size,
      *                       int opts, void *key, unsigned int keylen);
     D Rreadk          PR              *          extproc('C_Rreadk')           _RIOFB_T
     D  i_fp                           *   value
     D  i_pBuffer                      *   value
     D  i_size                       10U 0 value
     D  i_opts                       10I 0 value
     D  i_key                          *   value
     D  i_klen                       10I 0 value
      *
      *  _Rreads -- Read the Same Record
      *    #include <recio.h>
      *    _RIOFB_T *_Rreads(_RFILE *fp, void *buf, size_t size, int opts);
     D Rreads          PR              *          extproc('C_Rreads')           _RIOFB_T
     D  i_fp                           *   value
     D  i_pBuffer                      *   value
     D  i_size                       10U 0 value
     D  i_opts                       10I 0 value
      *
      *  _Rrlslck -- Release a Record Lock
      *    #include <recio.h>
      *    int _Rrlslck(_RFILE *fp);
     D RrlsLck         PR            10I 0        extproc('C_Rrlslck')          int 1=success
     D  i_fp                           *   value                                    0=error
      *
      *  _Rupdate -- Update a Record
      *    #include <recio.h>
      *    _RIOFB_T *_Rupdate(_RFILE *fp, void *buf, size_t size);
     D Rupdate         PR              *          extproc('C_Rupdate')          _RIOFB_T
     D  i_fp                           *   value
      /if defined(RUPDATE_OPTIONS_STRING)
     D  i_pBuffer                      *   value  options(*string)
      /else
     D  i_pBuffer                      *   value
      /endif
     D  i_size                       10U 0 value
      *
      *
      *  _Rwrite -- Write the next record
      *    #include <recio.h>
      *    _RIOFB_T * _Rwrite(_RFILE *fp, void *buf, size_t size);
     D Rwrite          PR              *          extproc('C_Rwrite')           _RIOFB_T
     D  i_fp                           *   value
      /if defined(RWRITE_OPTIONS_STRING)
     D  i_pBuffer                      *   value  options(*string)
      /else
     D  i_pBuffer                      *   value
      /endif
     D  i_size                       10U 0 value
      *
      *  _Rwrited -- Write a Record Directly
      *    #include <recio.h>
      *    _RIOFB_T *_Rwrited(_RFILE *fp, void *buf, size_t size, unsigned long rrn);
     D Rwrited         PR              *          extproc('C_Rwrited')          _RIOFB_T
     D  i_fp                           *   value
      /if defined(RWRITE_OPTIONS_STRING)
     D  i_pBuffer                      *   value  options(*string)
      /else
     D  i_pBuffer                      *   value
      /endif
     D  i_size                       10U 0 value
     D  i_rrn                        10U 0 value
      *
      *  _Rformat -- Set the Record Format Name
      *    #include <recio.h>
      *    void  _Rformat(_RFILE *fp, char *fmt);
     D Rformat         PR                         extproc('C_Rformat')          void
     D  i_handle                       *   value
     D  i_format                       *   value  options(*string)
      *
 DEF  /ENDIF
