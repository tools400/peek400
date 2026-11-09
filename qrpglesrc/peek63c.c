      /*%METADATA                                                     */
      /* %TEXT Peek/400 - Dateizugriffsroutinen  C-Helper  SrvPgm     */
      /*%EMETADATA                                                    */
     /*===============================================================*/
     /*                                                               */
     /*  (c) Thomas Raddatz                                           */
     /*                                                               */
     /*  Bereich  : PEEK, Version 3.0.0                               */
     /*  Programm : PEEK63C                                           */
     /*  Typ      : CLE                                               */
     /*                                                               */
     /*  erstellt : 30.03.2007  Raddatz                               */
     /*                                                               */
     /*===============================================================*/
     /*                                                               */
     /*  Kurzdokumentation :                                          */
     /*                                                               */
     /*  Peek/400 - Dateizugriffsroutinen  C-Helper                   */
     /*                                                               */
     /* ============================================================= */
#include <recio.h>
#include <xxfdbk.h>

// -------------------------------------------------------
//  Open a Record File for I/O Operations
// -------------------------------------------------------
_RFILE * C_Ropen(const char * filename, const char * mode)
{
   _RFILE *fp;

   fp = _Ropen( filename, mode);

   return fp;

}

// -------------------------------------------------------
//  Get latest IO feedback
// -------------------------------------------------------
_XXIOFB_T * C_Riofbk(_RFILE *fp)
{
   _XXIOFB_T *fb;
   _XXIOFB_DB_T *iofb;

   fb = _Riofbk(fp);
   iofb = (void*)(fb + 1);

   return fb;

}

// -------------------------------------------------------
//  Position to a Record
// -------------------------------------------------------
_RIOFB_T * C_Rlocate(_RFILE *fp, void *key, int klen_rrn, int opts)
{
   _RIOFB_T *fb;

   fb = _Rlocate(fp, key, klen_rrn, opts);

   return fb;

}

// -------------------------------------------------------
//  Read the Same Record
// -------------------------------------------------------
_RIOFB_T * C_Rreads(_RFILE *fp, void *buf, size_t size, int opts)
{
   _RIOFB_T *fb;

   fb = _Rreads(fp, buf, size, opts);

   return fb;

}

// -------------------------------------------------------
//  Read the next Record
// -------------------------------------------------------
_RIOFB_T * C_Rreadn(_RFILE *fp, void *buf, size_t size, int opts)
{
   _RIOFB_T *fb;

   fb = _Rreadn(fp, buf, size, opts);

   return fb;

}

// -------------------------------------------------------
//  Read a Record by Key
// -------------------------------------------------------
_RIOFB_T * C_Rreadk(_RFILE *fp, void *buf, size_t size, int opts, void *key, unsigned int keylen)
{
   _RIOFB_T *fb;

   fb = _Rreadk(fp, buf, size, opts, key, keylen);

   return fb;

}

// -------------------------------------------------------
//  Read the Previous Record
// -------------------------------------------------------
_RIOFB_T * C_Rreadp(_RFILE *fp, void *buf, size_t size, int opts)
{
   _RIOFB_T *fb;

   fb = _Rreadp(fp, buf, size, opts);

   return fb;

}

// -------------------------------------------------------
//  Read a Record by Relative Record Number
// -------------------------------------------------------
_RIOFB_T * C_Rreadd (_RFILE *fp, void *buf, size_t size, int opts, long rrn)
{
   _RIOFB_T *fb;

   fb = _Rreadd(fp, buf, size, opts, rrn);

   return fb;

}

// -------------------------------------------------------
//  Delete a Record
// -------------------------------------------------------
_RIOFB_T * C_Rdelete(_RFILE *fp)
{
   _RIOFB_T *fb;

   fb = _Rdelete(fp);

   return fb;

}

// -------------------------------------------------------
//  Release a Record Lock
// -------------------------------------------------------
int C_Rrlslck(_RFILE *fp)
{
   int rc;

   rc = _Rrlslck(fp);

   return rc;

}

// -------------------------------------------------------
//  Close a File
// -------------------------------------------------------
int C_Rclose(_RFILE *fp)
{
   int rc;

   rc = _Rclose(fp);

   return rc;

}

// -------------------------------------------------------
//  Set the Record Format Name
// -------------------------------------------------------
void C_Rformat(_RFILE *fp, char *fmt)
{

   _Rformat(fp, fmt);

   return;

}

