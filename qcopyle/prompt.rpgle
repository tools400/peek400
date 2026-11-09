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
when (scnFld = '##FIELD');
  C                   movel(p)  ##field       r#field
  C                   movel(p)  ##field       yData
yDataTyp = *blanks;
  C                   z-add     10            yDataLen
when scnFld = '##MEMBER';
  C                   movel(p)  ##member      r#member
  C                   movel(p)  ##member      yData
yDataTyp = *blanks;
  C                   z-add     10            yDataLen
other;
  yData = *blanks;
  yDataTyp = *blanks;
  yDataLen = *zeros;
endsl;

C                   movel(p)  scnFld        yPromptFor
C                   call      peek38        p_peek38               99
if *in99 = *on;
//  ... Fehler, also ungültige Rückgabedaten
else;

if (yMsgID <> *blanks);

  if (yMsgID = '*NONE');
    yMsgID = *blanks;
    yMsgDta = *blanks;
  endif;

  select;
  when (scnFld = '##FIELD');
    C                   movel(p)  r#field       ##field
     when scnFld = '##MEMBER';
    C                   movel(p)  r#member      ##member
     endsl;

  else;

    select;
    when (scnFld = '##FIELD');
      ##field = %subst(yRetData:1:yDataLen);
    when (scnFld = '##MEMBER');
      ##member = %subst(yRetData:1:yDataLen);
    endsl;

    endif;

    endif;

