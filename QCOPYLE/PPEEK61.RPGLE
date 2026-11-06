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
dcl-c cPrgMtr_jobType_all '*ALL';
dcl-c cPrgMtr_jobType_dlg '*DIALOG';
dcl-c cPrgMtr_jobType_batch '*BATCH';

//  Reverse image colours for solid progress bars.
//  Set i_marker to one of these for good effect.
dcl-c cPrgMtr_green x'21';
dcl-c cPrgMtr_white x'23';
dcl-c cPrgMtr_red x'29';
dcl-c cPrgMtr_turqoise x'31';
dcl-c cPrgMtr_yellow x'33';
dcl-c cPrgMtr_pink x'39';
dcl-c cPrgMtr_blue x'3B';

/endif
