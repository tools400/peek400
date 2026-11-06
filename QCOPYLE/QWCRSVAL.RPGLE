**free
/if not defined(QWCRSVAL)
/define QWCRSVAL

//  Retrieve System Values (QWCRSVAL) API
dcl-pr qwcrsval extpgm('QWCRSVAL');
  o_rcvVar    char(65535) options(*varsize);
  i_lenRcvVar int(10) const;
  i_numSysVal int(10) const;
  i_arySysVal char(10) options(*varsize) dim(128) const;
  io_errCode  char(65535) options(*varsize);
end-pr;

//  Return value
dcl-ds QWCRSVAL_rtnValue_t len(4096) qualified template;
  numSysValRtn int(10);
  ofsSysValTbl int(10) dim(128);
end-ds;

dcl-ds QWCRSVAL_sysValInfTbl_t qualified based(pSysValTbl);
  sysVal    char(10);
  type      char(1);
  infStatus char(1);
  length    int(10);
  data      char(4096);
end-ds;

// --------------------------------------------------
//  Pre-defined structures for complex system values
// --------------------------------------------------

//  QACGLVL:         Accounting level
dcl-ds QWCRSVAL_acgLvl_t qualified;
  option char(10) dim(8);
end-ds;

//  QALWOBJRST:      Allow object restore options
dcl-ds QWCRSVAL_alwObjRst_t qualified;
  option char(10) dim(15);
end-ds;

//  QALWUSRDMN:      Allow user domain
dcl-ds QWCRSVAL_alwUsrDmn_t qualified;
  lib char(10) dim(50);
end-ds;

//  QATNPGM:        Attention program
dcl-ds QWCRSVAL_atnPgm_t qualified;
  name char(10);
  lib  char(10);
end-ds;

//  QAUDCTL:         Auditing control
dcl-ds QWCRSVAL_audCtl_t qualified;
  option char(10) dim(5);
end-ds;

//  QAUDLVL:         Auditing level
dcl-ds QWCRSVAL_audLvl_t qualified;
  option char(10) dim(16);
end-ds;

//  QAUDLVL2:        Auditing level extension
dcl-ds QWCRSVAL_audLvl2_t qualified;
  option char(10) dim(99);
end-ds;

//  QBOOKPATH:      Book and bookshelf search path
dcl-ds QWCRSVAL_bookPath_t qualified;
  path char(63) dim(5);
end-ds;

//  QCFGMSGQ:       Configuration message queue
dcl-ds QWCRSVAL_cfgMsgQ_t qualified;
  name char(10);
  lib  char(10);
end-ds;

//  QCHRID:         Character set and code page
dcl-ds QWCRSVAL_chrID_t qualified;
  ccsid    char(10);
  codePage char(10);
end-ds;

//  QCMNRCYLMT:     Communications recovery limit
dcl-ds QWCRSVAL_cmnRcyLmt_t qualified;
  count    char(10);
  interval char(10);
end-ds;

//  QCTLSBSD:       Controlling subsystem
dcl-ds QWCRSVAL_ctlSbsD_t qualified;
  name char(10);
  lib  char(10);
end-ds;

//  QDATETIME:      System date and time       (YYYYMMDDHHNNSSXXXXXX)
dcl-ds QWCRSVAL_dateTime_t qualified;
  date  char(8);
  time  char(6);
  mSecs char(6);
end-ds;

//  QIGCCDEFNT:     Double-byte coded font name
dcl-ds QWCRSVAL_igcCdeFnt_t qualified;
  name char(10);
  lib  char(10);
end-ds;

//  QINACTMSGQ:   Inactive message queue
dcl-ds QWCRSVAL_inActMsgQ_t qualified;
  name char(10);
  lib  char(10);
end-ds;

//  QIPLDATTIM:   Automatic IPL date and time  (value = CYYMMDDHHMMSS)
dcl-ds QWCRSVAL_iplDatTim_t qualified;
  value  char(13);
  spcVal char(10) overlay(value);
end-ds;

//  QPRBFTR:      Problem filter
dcl-ds QWCRSVAL_prbFtr_t qualified;
  name char(10);
  lib  char(10);
end-ds;

//  QPWDVLDPGM:   Password validation program
dcl-ds QWCRSVAL_pwdVldPgm_t qualified;
  name char(10);
  lib  char(10);
end-ds;

//  QRMTSIGN:     Remote sign-on
dcl-ds QWCRSVAL_rmtSign_t qualified;
  spcVal char(10);
  pgm    char(10) overlay(spcVal);
  lib    char(10);
end-ds;

//  QSCANFS:      Scan file systems
dcl-ds QWCRSVAL_scanFS_t qualified;
  option char(10) dim(20);
end-ds;

//  QSCANFSCTL:   Scan file systems control
dcl-ds QWCRSVAL_scanFSCtl_t qualified;
  option char(10) dim(20);
end-ds;

//  QSETJOBATR:   Set job attributes from locale
dcl-ds QWCRSVAL_setJobAtr_t qualified;
  attr char(10) dim(16);
end-ds;

//  QSRTSEQ:      Sort sequence table
dcl-ds QWCRSVAL_srtSeq_t qualified;
  name char(10);
  lib  char(10);
end-ds;

//  QSTRUPPGM:    Startup program name
dcl-ds QWCRSVAL_strUpPgm_t qualified;
  name char(10);
  lib  char(10);
end-ds;

//  QSYSLIBL:     System library list
dcl-ds QWCRSVAL_sysLibl_t qualified;
  lib char(10) dim(15);
end-ds;

//  QUSRLIBL:     User library list
dcl-ds QWCRSVAL_usrLibl_t qualified;
  lib char(10) dim(25);
end-ds;

//  QUTCOFFSET:   Coordinated universal time offset
dcl-ds QWCRSVAL_utcOffset_t qualified;
  timeZoneID char(1);
  hours      char(2);
  minutes    char(2);
end-ds;

/endif
