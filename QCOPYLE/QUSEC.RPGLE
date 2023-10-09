**FREE
//** START HEADER FILE SPECIFICATIONS ****************************
//
//Header File Name: H/QUSEC
//
//Descriptive Name: Error Code Parameter.
//
//5763-SS1  (C) Copyright IBM Corp. 1994,1994
//All rights reserved.
//US Government Users Restricted Rights -
//Use, duplication or disclosure restricted
//by GSA ADP Schedule Contract with IBM Corp.
//
//Licensed Materials-Property of IBM
//
//
//Description: Include header file for the error code parameter.
//
//Header Files Included: None.
//
//Macros List: None.
//
//Structure List: Qus_EC_t
//
//Function Prototype List: None.
//
//Change Activity:
//
//CFD List:
//
//FLAG REASON       LEVEL DATE   PGMR      CHANGE DESCRIPTION
//---- ------------ ----- ------ --------- ----------------------
//$A0= D2862000     3D10  931201 DPOHLSON: New Include
//
//End CFD List.
//
//Additional notes about the Change Activity
//End Change Activity.
//** END HEADER FILE SPECIFICATIONS ******************************
//****************************************************************
//Record structure for Error Code Parameter
//***                                                          ***
//NOTE: The following type definition only defines the fixed
//   portion of the format.  Verying length field Exception
//   Data will not be defined here.
//****************************************************************
dcl-ds qusec;
  //                                             Qus EC
  qusbprv         int(10) inz(256);
  //                                             Bytes Provided
  qusbavl         int(10);
  //                                             Bytes Available
  qusei           char(7);
  //                                             Exception Id
  quserved        char(1);
  //                                             Reserved
  qused01         char(240);
end-ds;
//
//                                      Varying length
