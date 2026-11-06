**free
//===============================================================*
//                                                               *
//  Additional information about FILD0100:                       *
//  My private API using DSPFD                                   *
//                                                               *
//===============================================================*

//  API format FILD0100
dcl-ds fild0100_t len(256) qualified template;
  atrcen char(1);
  atrdat char(6);
  atrtim char(6);
  atfile char(10);
  atlib  char(10);
  atftyp char(1);
  atfila char(4);
  atmxdd char(1); // nicht unterst.
  atmxdc char(1); // nicht unterst.
  atmxdb char(1); // nicht unterst.
  atfatr char(6);
  atsysn char(8);
  atasp  packed(3);
  atres  char(4);
  atdtat char(1);
  atwait packed(5);
  atwatr packed(5);
  atshar char(1);
  atlvlc char(1);
  attxt  char(50);
  atnofm packed(5);
  atfccn char(1);
  atfcdt char(6);
  atfctm char(6);
  atfls  char(1);
  aticap char(1);
  atres2 char(9);
  ataqdv char(10);
  atmxdv packed(3); // nicht unterst.
  atspol char(1);
  atnodv packed(3);
  atubl  packed(5);
  atidta char(1);
  atres3 char(9);
  ataccp char(1);
  atselo char(1);
  atcseq char(1);
  atnomb packed(5);
  atjoin char(1);
  atsqlt char(1);
  atres4 char(8);
end-ds;

