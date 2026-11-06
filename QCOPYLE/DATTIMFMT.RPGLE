**free
//==================================================================*
//  Datums- und Zeitwerte im externen Format eines Feldes

//  f_extDate() und f_extTime() geben einen Wert so aus, wie er im
//  Satzpuffer eines Feldes steht: im Format DATFMT/TIMFMT des Feldes
//  und mit seinem Trennzeichen (FLDL0100.F1DTFM, FLDL0100.F1DTSP).

//  Der Member enthält Prozeduren, nicht nur Prototypen. Er wird am
//  Ende des Quellcodes nach /COPY QCOPYLE,FLDL0100 eingebunden.
//==================================================================*

//------------------------------------------------------------------*
//  Datum im Format des Feldes. Formate mit 2-stelligem Jahr (*MDY,
//  *DMY, *YMD, *JUL) umfassen nur 1940 bis 2039, kleinere und
//  größere Werte werden auf diesen Bereich begrenzt (*LOVAL, *HIVAL).
//------------------------------------------------------------------*
dcl-proc f_extDate;
  dcl-pi *n varchar(10);
    i_FLDL0100 likeds(fldl0100_t) const;
    i_date     date(*iso) value;
  end-pi;

  dcl-s text varchar(10);
  dcl-s dftsep char(1);

  if (i_FLDL0100.f1dtfm = '*MDY' or i_FLDL0100.f1dtfm = '*DMY' or
      i_FLDL0100.f1dtfm = '*YMD' or i_FLDL0100.f1dtfm = '*JUL');
    if (i_date < D'1940-01-01');
      i_date = D'1940-01-01';
    elseif (i_date > D'2039-12-31');
      i_date = D'2039-12-31';
    endif;
  endif;

  select;
  when (i_FLDL0100.f1dtfm = '*EUR');
    text = %char(i_date: *eur);
    dftsep = '.';
  when (i_FLDL0100.f1dtfm = '*USA');
    text = %char(i_date: *usa);
    dftsep = '/';
  when (i_FLDL0100.f1dtfm = '*JIS');
    text = %char(i_date: *jis);
    dftsep = '-';
  when (i_FLDL0100.f1dtfm = '*MDY');
    text = %char(i_date: *mdy);
    dftsep = '/';
  when (i_FLDL0100.f1dtfm = '*DMY');
    text = %char(i_date: *dmy);
    dftsep = '/';
  when (i_FLDL0100.f1dtfm = '*YMD');
    text = %char(i_date: *ymd);
    dftsep = '/';
  when (i_FLDL0100.f1dtfm = '*JUL');
    text = %char(i_date: *jul);
    dftsep = '/';
  other;
    text = %char(i_date: *iso);
    dftsep = '-';
  endsl;

  if (i_FLDL0100.f1dtsp <> ' ' and i_FLDL0100.f1dtsp <> dftsep);
    text = %xlate(dftsep: i_FLDL0100.f1dtsp: text);
  endif;

  return text;

end-proc;

//------------------------------------------------------------------*
//  Zeit im Format des Feldes.
//------------------------------------------------------------------*
dcl-proc f_extTime;
  dcl-pi *n varchar(8);
    i_FLDL0100 likeds(fldl0100_t) const;
    i_time     time(*iso) value;
  end-pi;

  dcl-s text varchar(8);
  dcl-s dftsep char(1);

  //  *HIVAL ist 24.00.00. Im Format *USA wäre das '12:00 AM' und damit
  //  wieder Mitternacht am Tagesanfang; größter *USA-Wert ist 11:59 PM.
  if (i_FLDL0100.f1dtfm = '*USA' and i_time > T'23.59.59');
    i_time = T'23.59.59';
  endif;

  select;
  when (i_FLDL0100.f1dtfm = '*HMS');
    text = %char(i_time: *hms);
    dftsep = ':';
  when (i_FLDL0100.f1dtfm = '*EUR');
    text = %char(i_time: *eur);
    dftsep = '.';
  when (i_FLDL0100.f1dtfm = '*USA');
    text = %char(i_time: *usa);
    dftsep = ':';
  when (i_FLDL0100.f1dtfm = '*JIS');
    text = %char(i_time: *jis);
    dftsep = ':';
  other;
    text = %char(i_time: *iso);
    dftsep = '.';
  endsl;

  if (i_FLDL0100.f1dtsp <> ' ' and i_FLDL0100.f1dtsp <> dftsep);
    text = %xlate(dftsep: i_FLDL0100.f1dtsp: text);
  endif;

  return text;

end-proc;
