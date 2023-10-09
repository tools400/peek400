**FREE
/if not defined(QWCRSVAL)
/define QWCRSVAL
//
//  Retrieve System Values (QWCRSVAL) API
dcl-pr qwcrsval
       extpgm('QWCRSVAL');
  o_rcvvar        char(65535) options(*varsize);
  i_lenrcvvar     int(10) const;
  i_numsysval     int(10) const;
  i_arysysval     char(10) const  options(*varsize) dim(128);
  io_errcode      char(65535) options(*varsize);
end-pr;
//
//  Return value
dcl-ds qwcrsval_rtnvalue_t
       len(4096) qualified template;
  numsysvalrtn    int(10);
  ofssysvaltbl    int(10) dim(128);
end-ds;
//
dcl-ds qwcrsval_sysvalinftbl_t
       qualified based(psysvaltbl);
  sysval          char(10);
  type            char(1);
  infstatus       char(1);
  length          int(10);
  data            char(4096);
end-ds;
//
// --------------------------------------------------
//  Pre-defined structures for complex system values
// --------------------------------------------------
//
//  QACGLVL:         Accounting level
dcl-ds qwcrsval_acglvl_t
       qualified;
  option          char(10) dim(8);
end-ds;
//
//  QALWOBJRST:      Allow object restore options
dcl-ds qwcrsval_alwobjrst_t
       qualified;
  option          char(10) dim(15);
end-ds;
//
//  QALWUSRDMN:      Allow user domain
dcl-ds qwcrsval_alwusrdmn_t
       qualified;
  lib             char(10) dim(50);
end-ds;
//
//  QATNPGM:        Attention program
dcl-ds qwcrsval_atnpgm_t
       qualified;
  name            char(10);
  lib             char(10);
end-ds;
//
//  QAUDCTL:         Auditing control
dcl-ds qwcrsval_audctl_t
       qualified;
  option          char(10) dim(5);
end-ds;
//
//  QAUDLVL:         Auditing level
dcl-ds qwcrsval_audlvl_t
       qualified;
  option          char(10) dim(16);
end-ds;
//
//  QAUDLVL2:        Auditing level extension
dcl-ds qwcrsval_audlvl2_t
       qualified;
  option          char(10) dim(99);
end-ds;
//
//  QBOOKPATH:      Book and bookshelf search path
dcl-ds qwcrsval_bookpath_t
       qualified;
  path            char(63) dim(5);
end-ds;
//
//  QCFGMSGQ:       Configuration message queue
dcl-ds qwcrsval_cfgmsgq_t
       qualified;
  name            char(10);
  lib             char(10);
end-ds;
//
//  QCHRID:         Character set and code page
dcl-ds qwcrsval_chrid_t
       qualified;
  ccsid           char(10);
  codepage        char(10);
end-ds;
//
//  QCMNRCYLMT:     Communications recovery limit
dcl-ds qwcrsval_cmnrcylmt_t
       qualified;
  count           char(10);
  interval        char(10);
end-ds;
//
//  QCTLSBSD:       Controlling subsystem
dcl-ds qwcrsval_ctlsbsd_t
       qualified;
  name            char(10);
  lib             char(10);
end-ds;
//
//  QDATETIME:      System date and time       (YYYYMMDDHHNNSSXXXXXX)
dcl-ds qwcrsval_datetime_t
       qualified;
  date            char(8);
  time            char(6);
  msecs           char(6);
end-ds;
//
//  QIGCCDEFNT:     Double-byte coded font name
dcl-ds qwcrsval_igccdefnt_t
       qualified;
  name            char(10);
  lib             char(10);
end-ds;
//
//  QINACTMSGQ:   Inactive message queue
dcl-ds qwcrsval_inactmsgq_t
       qualified;
  name            char(10);
  lib             char(10);
end-ds;
//
//  QIPLDATTIM:   Automatic IPL date and time  (value = CYYMMDDHHMMSS)
dcl-ds qwcrsval_ipldattim_t
       qualified;
  value           char(13);
  spcval          char(10) overlay(value);
end-ds;
//
//  QPRBFTR:      Problem filter
dcl-ds qwcrsval_prbftr_t
       qualified;
  name            char(10);
  lib             char(10);
end-ds;
//
//  QPWDVLDPGM:   Password validation program
dcl-ds qwcrsval_pwdvldpgm_t
       qualified;
  name            char(10);
  lib             char(10);
end-ds;
//
//  QRMTSIGN:     Remote sign-on
dcl-ds qwcrsval_rmtsign_t
       qualified;
  spcval          char(10);
  pgm             char(10) overlay(spcval);
  lib             char(10);
end-ds;
//
//  QSCANFS:      Scan file systems
dcl-ds qwcrsval_scanfs_t
       qualified;
  option          char(10) dim(20);
end-ds;
//
//  QSCANFSCTL:   Scan file systems control
dcl-ds qwcrsval_scanfsctl_t
       qualified;
  option          char(10) dim(20);
end-ds;
//
//  QSETJOBATR:   Set job attributes from locale
dcl-ds qwcrsval_setjobatr_t
       qualified;
  attr            char(10) dim(16);
end-ds;
//
//  QSRTSEQ:      Sort sequence table
dcl-ds qwcrsval_srtseq_t
       qualified;
  name            char(10);
  lib             char(10);
end-ds;
//
//  QSTRUPPGM:    Startup program name
dcl-ds qwcrsval_struppgm_t
       qualified;
  name            char(10);
  lib             char(10);
end-ds;
//
//  QSYSLIBL:     System library list
dcl-ds qwcrsval_syslibl_t
       qualified;
  lib             char(10) dim(15);
end-ds;
//
//  QUSRLIBL:     User library list
dcl-ds qwcrsval_usrlibl_t
       qualified;
  lib             char(10) dim(25);
end-ds;
//
//  QUTCOFFSET:   Coordinated universal time offset
dcl-ds qwcrsval_utcoffset_t
       qualified;
  timezoneid      char(1);
  hours           char(2);
  minutes         char(2);
end-ds;
//
/endif
