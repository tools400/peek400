**free
/if NOT defined(CLIB2)
/define CLIB2

//  File open feedback data structure
dcl-ds rfile_t qualified template;
  res01   char(16);
  pInBuf  pointer;
  pOutBuf pointer;
  res02   char(48);
/if not defined(*V5R3M0)
  riofb   like(riofb_t);
/else
  riofb   likeds(riofb_t);
/endif
  res03   char(32);
  bufLen  uns(10);
  res04   char(28);
  pInNull pointer;
  pOutNul pointer;
  pKeyNul pointer;
  res05   char(48);
  minLen  int(10);
  nMapLen int(5);
  nKeyLen int(5);
  res06   char(8);
end-ds;

//  Record IO feedback data structure
dcl-ds riofb_t qualified align template;
  pKey   pointer;
  pSysP  pointer;
  rrn    uns(10);
  numByt int(10);
  blkCnt int(5);
  blkFld char(1);
  bitFld char(1);
  dupKy  char(1) overlay(bitFld: 1);
  icfLc  char(1) overlay(bitFld: 1);
  res01  char(1) overlay(bitFld: 1);
  res02  char(20);
end-ds;

//  Record IO feedback data structure
dcl-ds xxiofb_t qualified template;
  file_dep_fb_offset int(5);
  write_count        int(10);
  read_count         int(10);
  write_read_count   int(10);
  other_io_count     int(10);
  reserved1          char(1);
  cur_operation      char(1);
  rec_format         char(10);
  dev_class          char(2);
  dev_name           char(10);
  last_io_rec_len    int(10);
  reserved2          char(80);
  num_recs_retrieved int(5);
  last_io_rec_len2   int(5);
  reserved3          char(2);
  cur_blk_count      int(10);
  reserved4          char(8);
end-ds;

dcl-ds xxiofb_db_t qualified template;
  db_fdbk_size       int(10);
  join_default_flags char(4);
  reserved1          char(2);
  num_locked_recs    int(5);
  fields_in_fmt      int(5);
  reserved2          char(4);
  reserved3          char(1);
  flags              int(3);
  num_key_fields     int(5);
  reserved4          char(4);
  key_len            uns(5);
  data_mbr_num       int(5);
  data_mbr_rrn       uns(10);
  key_value          char(1) dim(max_key_size);
end-ds;

dcl-c max_key_size 32768;

//  Constants used by IO feedback procedures
dcl-c rrn_eq x'08000300';

dcl-c key_eq x'0B000100';
dcl-c key_gt x'0D000100';
dcl-c key_lt x'09000100';
dcl-c key_le x'0A000100';
dcl-c key_ge x'0C000100';
dcl-c key_nextunq x'05000100';
dcl-c key_prevunq x'06000100';
dcl-c key_nexteq x'0E000100';
dcl-c key_preveq x'0F000100';

dcl-c First x'01000300';
dcl-c last x'02000300';
dcl-c next x'03000300';
dcl-c previous x'04000300';

dcl-c start_frc x'03000004';
dcl-c start x'01000004';
dcl-c end_frc x'04000004';
dcl-c end x'02000004';

dcl-c no_lock x'00000001';
dcl-c dft x'0B000100';
dcl-c no_position x'00100000';
dcl-c prior x'00001000';
dcl-c data_only x'00000002';
dcl-c null_key_map x'00000008';

dcl-c eof -1;

//  _Ropen -- Open a Record File for I/O Operatins
//    #include <recio.h>
//    _RFILE *_Ropen(const char * filename, const char * mode, ...);
dcl-pr ropen pointer extproc('C_Ropen'); // _RFILE
  i_fileName pointer options(*string) value;
  i_mode     pointer options(*string) value;
end-pr;

//  _Rclose -- Close a File
//    #include <recio.h>
//    int _Rclose(_RFILE *fp);
dcl-pr rclose int(10) extproc('C_Rclose');
  i_fp pointer value;
end-pr;

//  _Riofbk() -- Obtain I/O Feedback Information
//    #include <recio.h>
//    #include <xxfdbk.h>
//    _XXIOFB_T *_Riofbk(_RFILE *fp);
dcl-pr riofbk pointer extproc('C_Riofbk'); // _XXIOFB_T
  i_fp pointer value;
end-pr;

//  _Rlocate -- Position to a Record
//    #include <recio.h>
//    _RIOFB_T *_Rlocate(_RFILE *fp, void *key, int klen_rrn, int opts);
dcl-pr rlocate pointer extproc('C_Rlocate'); // _RIOFB_T
  i_fp       pointer value;
  i_key      pointer value;
  i_klen_rrn int(10) value;
  i_opts     int(10) value;
end-pr;

//  _Rreadd -- Read a Record by Relative Record Number
//    #include <recio.h>
//    _RIOFB_T *_Rreadd (_RFILE *fp, void *buf, size_t size,
//                                int opts, long rrn);
dcl-pr rreadd pointer extproc('C_Rreadd'); // _RIOFB_T
  i_fp      pointer value;
  i_pBuffer pointer value;
  i_size    uns(10) value;
  i_opts    int(10) value;
  i_rrn     int(10) value;
end-pr;

//  _Rdelete -- Delete a Record
//    #include <recio.h>
//    _RIOFB_T *_Rdelete(_RFILE *fp);
dcl-pr rdelete pointer extproc('C_Rdelete'); // _RIOFB_T
  i_fp pointer value;
end-pr;

//  _Rreadn -- Read the next Record
//    #include <recio.h>
//    _RIOFB_T *_Rreadn (_RFILE *fp, void *buf, size_t size, int opts);
dcl-pr rreadn pointer extproc('C_Rreadn'); // _RIOFB_T
  i_fp      pointer value;
  i_pBuffer pointer value;
  i_size    uns(10) value;
  i_opts    int(10) value;
end-pr;

//  _Rreadp -- Read the Previous Record
//    #include <recio.h>
//    _RIOFB_T *_Rreadp (_RFILE *fp, void *buf, size_t size, int opts);
dcl-pr rreadp pointer extproc('C_Rreadp'); // _RIOFB_T
  i_fp      pointer value;
  i_pBuffer pointer value;
  i_size    uns(10) value;
  i_opts    int(10) value;
end-pr;

//  _Rreadk -- Read a Record by Key
//    #include <recio.h>
//    _RIOFB_T *_Rreadk(_RFILE *fp, void *buf, size_t size,
//                       int opts, void *key, unsigned int keylen);
dcl-pr rreadk pointer extproc('C_Rreadk'); // _RIOFB_T
  i_fp      pointer value;
  i_pBuffer pointer value;
  i_size    uns(10) value;
  i_opts    int(10) value;
  i_key     pointer value;
  i_klen    int(10) value;
end-pr;

//  _Rreads -- Read the Same Record
//    #include <recio.h>
//    _RIOFB_T *_Rreads(_RFILE *fp, void *buf, size_t size, int opts);
dcl-pr rreads pointer extproc('C_Rreads'); // _RIOFB_T
  i_fp      pointer value;
  i_pBuffer pointer value;
  i_size    uns(10) value;
  i_opts    int(10) value;
end-pr;

//  _Rrlslck -- Release a Record Lock
//    #include <recio.h>
//    int _Rrlslck(_RFILE *fp);
dcl-pr rrlsLck int(10) extproc('C_Rrlslck'); // int 1=success
  i_fp pointer value; //     0=error
end-pr;

//  _Rformat -- Set the Record Format Name
//    #include <recio.h>
//    void  _Rformat(_RFILE *fp, char *fmt);
dcl-pr rformat extproc('C_Rformat');
  i_handle pointer value;
  i_format pointer options(*string) value;
end-pr;

/endif
