**FREE
/if not defined(PPEEK61)
/define PPEEK61

//  Initialize Progress Meter
dcl-pr p_inzprogressmeter;
  i_text          char(20) const;
  i_maxvalue      int(10)  const;
  i_marker        char(1)  const  options(*nopass);
  i_waitsec       int(10)  const  options(*nopass);
  i_jobtype       char(10) const  options(*nopass);
  i_width         int(10)  const  options(*nopass);
end-pr;

//  Show Progress Meter
dcl-pr p_showprogressmeter;
  i_currvalue     int(10) const;
end-pr;

//  Job Types
dcl-c cprgmtr_jobtype_all    const('*ALL');
dcl-c cprgmtr_jobtype_dlg    const('*DIALOG');
dcl-c cprgmtr_jobtype_batch  const('*BATCH');

//  Reverse image colours for solid progress bars.
//  Set i_marker to one of these for good effect.
dcl-c cprgmtr_green    const(x'21');
dcl-c cprgmtr_white    const(x'23');
dcl-c cprgmtr_red      const(x'29');
dcl-c cprgmtr_turqoise const(x'31');
dcl-c cprgmtr_yellow   const(x'33');
dcl-c cprgmtr_pink     const(x'39');
dcl-c cprgmtr_blue     const(x'3B');

/endif
