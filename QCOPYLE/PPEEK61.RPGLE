      /IF NOT DEFINED(PPEEK61)
      /DEFINE PPEEK61
      *
      *  Initialize Progress Meter
     D p_inzProgressMeter...
     D                 PR
     D  i_text                       20A   const
     D  i_maxValue                   10I 0 const
     D  i_marker                      1A   const  options(*nopass)
     D  i_waitSec                    10I 0 const  options(*nopass)
     D  i_jobType                    10A   const  options(*nopass)
     D  i_width                      10I 0 const  options(*nopass)
      *
      *  Show Progress Meter
     D p_showProgressMeter...
     D                 PR
     D  i_currValue                  10I 0 const
      *
      *  Job Types
     D cPrgMtr_JobType_All...
     D                 C                   const('*ALL')
     D cPrgMtr_JobType_Dlg...
     D                 C                   const('*DIALOG')
     D cPrgMtr_JobType_Batch...
     D                 C                   const('*BATCH')
      *
      *  Reverse image colours for solid progress bars.
      *  Set i_marker to one of these for good effect.
     D cPrgMtr_Green   C                   const(X'21')
     D cPrgMtr_White   C                   const(X'23')
     D cPrgMtr_Red     C                   const(X'29')
     D cPrgMtr_Turqoise...
     D                 C                   const(X'31')
     D cPrgMtr_Yellow  C                   const(X'33')
     D cPrgMtr_Pink    C                   const(X'39')
     D cPrgMtr_Blue    C                   const(X'3B')
      *
      /ENDIF
