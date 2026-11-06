**free
/if NOT defined(QUSRJOBI)
/define QUSRJOBI

/if NOT defined(qJob_t)
/define qJob_t
//   Qualified job name
dcl-ds qjob_t qualified template;
  name char(10);
  user char(10);
  nbr  char(6);
end-ds;
/endif

//  Retrieve Job Information (QUSRJOBI) API
dcl-pr qusrjobi extpgm('QUSRJOBI');
  o_rcvvar     char(65535) options(*varsize);
  i_rcvvarlen  int(10) const;
  i_format     char(8) const;
  i_qjob       char(26) const;
  i_intjobid   char(16) const;
  io_errcode   char(65535) options(*nopass: *varsize); // OptGrp 1
  i_resprfstat char(1) options(*nopass) const; // OptGrp 2
end-pr;

//  This format returns basic performance information about a job.
dcl-ds jobi0100_t qualified template;
  bytret     int(10);
  bytavl     int(10);
  job        char(10);
  user       char(10);
  nbr        char(6);
  intjobid   char(16);
  status     char(10);
  type       char(1);
  subtype    char(1);
  reserved_1 char(2);
  runpty     int(10);
  timeslice  int(10);
  dftwait    int(10);
  purge      char(10);
end-ds;

//  This format returns information equivalent to that found on the
//  Work with Active Jobs (WRKACTJOB) command.
dcl-ds jobi0200_t qualified template;
  bytret          int(10);
  bytavl          int(10);
  job             char(10);
  user            char(10);
  nbr             char(6);
  intjobid        char(16);
  status          char(10);
  type            char(1);
  subtype         char(1);
  sbsdname        char(10);
  runpty          int(10);
  syspoolid       int(10);
  prctimeusd      int(10);
  numauxiorq      int(10);
  numinttact      int(10);
  rsptimetot      int(10);
  fnctype         char(1);
  fncname         char(10);
  actjobsts       char(4);
  numdblckw       int(10);
  numintlckw      int(10);
  numnondblckw    int(10);
  timedblckw      int(10);
  timeintlckw     int(10);
  timenondblckw   int(10);
  reserved_01     char(1);
  currsyspoolid   int(10);
  thrdcount       int(10);
  prcunttmusd     uns(20);
  numauxiorqlng   uns(20);
  prcunttmusddb   uns(20);
  pagefaults      uns(20);
  actjobstsjobend char(4);
  mempoolname     char(10);
  msgrply         char(1);
end-ds;

//  This format returns job queue and output queue information for a job, as
//  well as information about the submitter's job if the job is a submitted batch job.
dcl-ds jobi0300_t qualified template;
  bytret     int(10);
  bytavl     int(10);
  job        char(10);
  user       char(10);
  nbr        char(6);
  intjobid   char(16);
  status     char(10);
  type       char(1);
  subtype    char(1);
  jobq       char(10);
  jobqlib    char(10);
  jobqpty    char(2);
  outq       char(10);
  outqlib    char(10);
  outqpty    char(2);
  prtdev     char(10);
  sbmjob     char(10);
  sbmuser    char(10);
  sbmnbr     char(6);
  sbmmsgq    char(10);
  sbmmsgqlib char(10);
  stsonjobq  char(10);
  dattimsbm  char(8);
  jobdate    char(7);
end-ds;

//  This format primarily returns job attribute types of information.
dcl-ds jobi0400_t qualified template;
  bytret        int(10);
  bytavl        int(10);
  job           char(10);
  user          char(10);
  nbr           char(6);
  intjobid      char(16);
  status        char(10);
  type          char(1);
  subtype       char(1);
  datetimeent   char(13);
  datetimeact   char(13);
  jobacctcode   char(15);
  jobd          char(10);
  jobdlib       char(10);
  unitofworkid  char(24);
  mode          char(8);
  inqmsgrply    char(10);
  logclpgms     char(10);
  brkmsghdl     char(10);
  stsmsghdl     char(10);
  devrcvract    char(13);
  ddmcnvhdl     char(10);
  datesep       char(1);
  datefmt       char(4);
  prttext       char(30);
  sbmjob        char(10);
  sbmuser       char(10);
  sbmnbr        char(6);
  sbmmsgq       char(10);
  sbmmsgqlib    char(10);
  timesep       char(1);
  ccsid         int(10);
  datetimescd   char(8);
  prtkeyfmt     char(10);
  sortseq       char(10);
  sortseqlib    char(10);
  langid        char(3);
  countryid     char(2);
  complsts      char(1);
  signedonjob   char(1);
  jobsws        char(8);
  msgqfullact   char(10);
  reserved_01   char(1);
  msgqmaxsize   int(10);
  dftccsid      int(10);
  rtgdata       char(80);
  decfmt        char(1);
  chridctrl     char(10);
  servertype    char(30);
  alwmltthrds   char(1);
  joblogpnd     char(1);
  reserved_02   char(1);
  jobendrsn     int(10);
  jobtypeenhncd int(10);
  datetimeend   char(13);
  reserved_03   char(1);
  splfactn      char(10);
  ofsaspgrpinf  int(10);
  numeaspgrpinf int(10);
  lenaspgrpinfe int(10);
  timezonedscnm char(10);
  joblogoutput  char(10);
end-ds;

//  This format returns information about active jobs only.
//  It is intended to supplement the JOBI0400 format.
dcl-ds jobi0600_t qualified template;
  bytret      int(10);
  bytavl      int(10);
  job         char(10);
  user        char(10);
  nbr         char(6);
  intjobid    char(16);
  status      char(10);
  type        char(1);
  subtype     char(1);
  jobsws      char(8);
  endstatus   char(1);
  sbsd        char(10);
  sbsdlib     char(10);
  curuser     char(10);
  dbcs        char(1);
  exitkey     char(1);
  cancelkey   char(1);
  prdretcode  int(10);
  userretcode int(10);
  pgmretcode  int(10);
  spcenv      char(10);
  device      char(10);
  grpprf      char(10);
  grpprfary   char(10) dim(15);
  jobusrid    char(10);
  jobusridstg char(1);
end-ds;

//  This format returns library list information for an active job.
dcl-ds jobi0700_t qualified template;
  bytret     int(10);
  bytavl     int(10);
  job        char(10);
  user       char(10);
  nbr        char(6);
  intjobid   char(16);
  status     char(10);
  type       char(1);
  subtype    char(1);
  reserved_1 char(2);
  numsyslibe int(10);
  numprdlibe int(10);
  numcurlibe int(10);
  numusrlibe int(10);
end-ds;
//   System library list                   Array (*) of CHAR(11)
//   Product libraries                     Array (*) of CHAR(11)
//   Current library                       Array (*) of CHAR(11)
//   User library list                     Array (*) of CHAR(11)

/endif
