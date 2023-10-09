**FREE
//===============================================================*
//                                                               *
//  Additional information about SELL0100:                       *
//  SELECT/OMIT statements                                       *
//                                                               *
//===============================================================*
//
//  list API format SELL0100
//  (data structure can be used within the calling program
//  to splitt XData into its units.)
dcl-ds sell0100_t len(256) qualified template;
  sorcen          char(1);                                               // über API
  sordat          char(6);                                               // über API
  sortim          char(6);                                               // über API
  sofile          char(10);                                              // über API
  solib           char(10);                                              // über API
  softyp          char(1);
  sofila          char(4);                                               // über API
  somxd           char(3);
  sofatr          char(6);
  sosysn          char(8);
  soasp           packed(3);
  sores           char(4);
  //
  sonrul          packed(5);                                             // über API
  sorfmt          char(10);                                              // über API
  sofld           char(10);                                              // über API
  sorule          char(1);                                               // über API
  socomp          char(2);                                               // über API
  sonval          packed(3);                                             // über API
  sovall          packed(3);                                             // über API
  sovalu          char(32);                                              // über API
  sodyns          char(1);                                               // über API
  sofjvl          packed(3);
  sopjvl          packed(3);
end-ds;
//
