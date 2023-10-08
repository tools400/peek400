      /if not defined(QWCRNETA)
      /define QWCRNETA
      *
      *  Retrieve Network Attributes (QWCRNETA) API
     d QWCRNETA...
     d                 pr                  extpgm('QWCRNETA')
     d  o_rcvVar                  32767A          options(*varsize)
     d  i_lenRcv                     10i 0 const
     d  i_numAttr                    10i 0 const
     d  i_attrNames                  10a   const  dim(50) options(*varsize)
     d  io_errorCode              32767A          options(*varsize)
      *
     d QWCRNETA_returned...
     d                 ds                  qualified template
     d  numE                         10i 0
     d  offsAttr                     10i 0
      *  Network attribute information table   CHAR(*)
      *
     d QWCRNETA_attr...
     d                 ds                  qualified template
     d  name                         10a
     d  type                          1a
     d  status                        1a
     d  length                       10i 0
     d  data_char                   256a
     d  data_bin                     10i 0 overlay(data_char)
      *
     d QWCRNETA_STATUS_OK...
     d                 c                       ' '
     d QWCRNETA_STATUS_LOCKED...
     d                 c                       'L'
      *
     d QWCRNETA_DATA_NONE...
     d                 c                       ' '
     d QWCRNETA_DATA_CHAR...
     d                 c                       'C'
     d QWCRNETA_DATA_BIN...
     d                 c                       'B'
      *
      /endif
