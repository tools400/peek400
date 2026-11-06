**free
/if not defined(PPEEK61)
/define PPEEK61

//  Initialize Progress Meter
dcl-pr p_inzProgressMeter;
  i_text     char(20) const;
  i_maxValue int(10) const;
  i_marker   char(1) options(*nopass) const;
  i_waitSec  int(10) options(*nopass) const;
  i_jobType  char(10) options(*nopass) const;
  i_width    int(10) options(*nopass) const;
end-pr;

//  Show Progress Meter
dcl-pr p_showProgressMeter;
  i_currValue int(10) const;
end-pr;

//  Job Types
dcl-c cPrgMtr_JobType_All '*ALL';
dcl-c cPrgMtr_JobType_Dlg '*DIALOG';
dcl-c cPrgMtr_JobType_Batch '*BATCH';

//  Reverse image colours for solid progress bars.
//  Set i_marker to one of these for good effect.
dcl-c cPrgMtr_Green x'21';
dcl-c cPrgMtr_White x'23';
dcl-c cPrgMtr_Red x'29';
dcl-c cPrgMtr_Turqoise x'31';
dcl-c cPrgMtr_Yellow x'33';
dcl-c cPrgMtr_Pink x'39';
dcl-c cPrgMtr_Blue x'3B';

/endif
