**FREE
//===============================================================*
//                                                               *
//  Additional information about KEYL0100:                       *
//  My private API using DSPFD                                   *
//                                                               *
//===============================================================*
//
//  list API format KEYL0100
//  (data structure can be used within the calling program
//  to splitt XLIST into its units. See GETDBR_DMO)
dcl-ds keyl0100_t len(256) qualified;
  aprcen          char(1);
  aprdat          char(6);
  aprtim          char(6);
  apfile          char(10);
  aplib           char(10);
  apftyp          char(1);
  apfila          char(4);
  apmxd           char(3);
  apfatr          char(6);
  apsysn          char(8);
  apasp           packed(3);
  apres           char(4);
  apmant          char(1);
  apuniq          char(1);
  apkeyo          char(1);
  apselo          char(1);
  apaccp          char(1);
  apnsco          packed(3);
  apbof           char(10);
  apbol           char(10);
  apbolf          char(10);
  apnkyf          packed(3);
  apkeyf          char(10);
  apkseq          char(1);
  apksin          char(1);
  apkzd           char(1);
  apkasq          char(1);
  apkeyn          packed(3);
  apjoin          char(1);
  apacpj          char(1);
  apriky          char(1);
end-ds;
//
