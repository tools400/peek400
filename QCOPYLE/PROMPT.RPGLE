**free
// --------------------------------------------------------------------
// Stand Alone Fields - TOP
// --------------------------------------------------------------------
dcl-s ##Field char(10);
dcl-s ##Member char(10);
dcl-s r#field char(10);
dcl-s r#member char(10);
// --------------------------------------------------------------------
// Stand Alone Fields - BOTTOM
// --------------------------------------------------------------------

select;
when (ScnFld = '##FIELD');
  C                   movel(p)  ##Field       r#field
  C                   movel(p)  ##Field       YData
YDataTyp = *blanks;
  C                   z-add     10            YDataLen
when ScnFld = '##MEMBER';
  C                   movel(p)  ##Member      r#member
  C                   movel(p)  ##Member      YData
YDataTyp = *blanks;
  C                   z-add     10            YDataLen
other;
  YData = *blanks;
  YDataTyp = *blanks;
  YDataLen = *zeros;
endsl;

C                   movel(p)  ScnFld        YPromptFor
C                   call      peek38        P_Peek38               99
if *in99 = *on;
//  ... Fehler, also ungültige Rückgabedaten
else;

if (YMsgID <> *blanks);

  if (YMsgID = '*NONE');
    YMsgID = *blanks;
    YMsgDta = *blanks;
  endif;

  select;
  when (ScnFld = '##FIELD');
    C                   movel(p)  r#field       ##Field
     when ScnFld = '##MEMBER';
    C                   movel(p)  r#member      ##Member
     endsl;

  else;

    select;
    when (ScnFld = '##FIELD');
      ##Field = %subst(YRetData:1:YDataLen);
    when (ScnFld = '##MEMBER');
      ##Member = %subst(YRetData:1:YDataLen);
    endsl;

    endif;

    endif;

