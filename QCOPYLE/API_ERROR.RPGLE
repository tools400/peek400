?     *===============================================================*                       RADDAT
?     *    Error reporting for API-Call's                             *                       RADDAT
?     *===============================================================*                       RADDAT
?     *                                                                                       RADDAT
?     *  API error reporting                                                                  RADDAT
     D §ErrorCode      DS           256                                                       RADDAT
     D  §ErrProv               1      4I 0 INZ(256)                                           RADDAT
     D  §ErrAvail              5      8I 0 INZ(0)                                             RADDAT
     D  §ErrID                 9     15A   INZ(*BLANKS)                                       RADDAT
     D  §ErrRes01             16     16A   INZ(*BLANKS)                                       RADDAT
     D  §ErrDta               17    256A   INZ(*BLANKS)                                       RADDAT
?     *                                                                                       RADDAT
