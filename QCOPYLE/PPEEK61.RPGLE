**free
/if not defined(PPEEK61)
/define PPEEK61

//  Initialize Progress Meter
dcl-pr p_inzprogressmeter;
  i_text     char(20) const;
  i_maxvalue int(10) const;
  i_marker   char(1) options(*nopass) const;
  i_waitsec  int(10) options(*nopass) const;
  i_jobtype  char(10) options(*nopass) const;
  i_width    int(10) options(*nopass) const;
end-pr;

//  Show Progress Meter
dcl-pr p_showprogressmeter;
  i_currvalue int(10) const;
end-pr;

//  Job Types
dcl-c cprgmtr_jobtype_all '*ALL';
dcl-c cprgmtr_jobtype_dlg '*DIALOG';
dcl-c cprgmtr_jobtype_batch '*BATCH';

//  Reverse image colours for solid progress bars.
//  Set i_marker to one of these for good effect.
dcl-c cprgmtr_green x'21';
dcl-c cprgmtr_white x'23';
dcl-c cprgmtr_red x'29';
dcl-c cprgmtr_turqoise x'31';
dcl-c cprgmtr_yellow x'33';
dcl-c cprgmtr_pink x'39';
dcl-c cprgmtr_blue x'3B';

/endif
