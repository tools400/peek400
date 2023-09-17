 DEF  /IF NOT DEFINED(F_PEEK61)                                                               RADDAT
 DEF  /DEFINE F_PEEK61                                                                        RADDAT
?     *                                                                                       RADDAT
?     *  Initialize Progress Meter                                                            RADDAT
     D p_inzProgressMeter...                                                                  RADDAT
     D                 PR                                                                     RADDAT
     D  i_text                       20A   const                                              RADDAT
     D  i_maxValue                   10I 0 const                                              RADDAT
     D  i_marker                      1A   const  options(*nopass)                            RADDAT
     D  i_waitSec                    10I 0 const  options(*nopass)                            RADDAT
     D  i_jobType                    10A   const  options(*nopass)                            RADDAT
     D  i_width                      10I 0 const  options(*nopass)                            RADDAT
?     *                                                                                       RADDAT
?     *  Show Progress Meter                                                                  RADDAT
     D p_showProgressMeter...                                                                 RADDAT
     D                 PR                                                                     RADDAT
     D  i_currValue                  10I 0 const                                              RADDAT
?     *                                                                                       RADDAT
?     *  Job Types                                                                            RADDAT
     D cPrgMtr_JobType_All...                                                                 RADDAT
     D                 C                   const('*ALL')                                      RADDAT
     D cPrgMtr_JobType_Dlg...                                                                 RADDAT
     D                 C                   const('*DIALOG')                                   RADDAT
     D cPrgMtr_JobType_Batch...                                                               RADDAT
     D                 C                   const('*BATCH')                                    RADDAT
?     *                                                                                       RADDAT
?     *  Reverse image colours for solid progress bars.                                       RADDAT
?     *  Set i_marker to one of these for good effect.                                        RADDAT
     D cPrgMtr_Green   C                   const(X'21')                                       RADDAT
     D cPrgMtr_White   C                   const(X'23')                                       RADDAT
     D cPrgMtr_Red     C                   const(X'29')                                       RADDAT
     D cPrgMtr_Turqoise...                                                                    RADDAT
     D                 C                   const(X'31')                                       RADDAT
     D cPrgMtr_Yellow  C                   const(X'33')                                       RADDAT
     D cPrgMtr_Pink    C                   const(X'39')                                       RADDAT
     D cPrgMtr_Blue    C                   const(X'3B')                                       RADDAT
?     *                                                                                       RADDAT
 DEF  /ENDIF                                                                    ?             RADDAT
