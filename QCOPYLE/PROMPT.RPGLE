**free
// --------------------------------------------------------------------
// Stand Alone Fields - TOP
// --------------------------------------------------------------------
dcl-s ##field char(10);
dcl-s ##member char(10);
dcl-s r#field char(10);
dcl-s r#member char(10);
// --------------------------------------------------------------------
// Stand Alone Fields - BOTTOM
// --------------------------------------------------------------------

select;
when (scnfld = '##FIELD');
  C                   movel(p)  ##field       r#field
  C                   movel(p)  ##field       ydata
ydatatyp = *blanks;
  C                   z-add     10            ydatalen
when scnfld = '##MEMBER';
  C                   movel(p)  ##member      r#member
  C                   movel(p)  ##member      ydata
ydatatyp = *blanks;
  C                   z-add     10            ydatalen
other;
  ydata = *blanks;
  ydatatyp = *blanks;
  ydatalen = *zeros;
endsl;

C                   movel(p)  scnfld        ypromptfor
C                   call      peek38        p_peek38               99
if *in99 = *on;
//  ... Fehler, also ungültige Rückgabedaten
else;

if (ymsgid <> *blanks);

  if (ymsgid = '*NONE');
    ymsgid = *blanks;
    ymsgdta = *blanks;
  endif;

  select;
  when (scnfld = '##FIELD');
    C                   movel(p)  r#field       ##field
     when scnfld = '##MEMBER';
    C                   movel(p)  r#member      ##member
     endsl;

  else;

    select;
    when (scnfld = '##FIELD');
      ##field = %subst(yretdata:1:ydatalen);
    when (scnfld = '##MEMBER');
      ##member = %subst(yretdata:1:ydatalen);
    endsl;

    endif;

    endif;

