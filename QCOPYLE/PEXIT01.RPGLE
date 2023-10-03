      /if defined(internal_prototype)
       dcl-pr exit01        extpgm('EXIT01');
      /else
       dcl-pr exit01        extpgm(EXIT01_NAME);
      /endif
         gi_qFile        const likeds(qObj_t);
         gi_mbr          const like(mbr_t);
         gi_access       const like(accmode_t);
         gio_chgl              like(bool_t);
         gio_chgf              like(bool_t);
         gio_chgm              like(bool_t);
         gio_updmd             like(bool_t);
         gio_updky             like(bool_t);
         gio_chgsqlw           like(bool_t);
         gio_chgsqlo           like(bool_t);
         gio_accat             like(bool_t);
         go_msgid              like(msgid_t);
         go_msgdta             like(msgdta_t);
       end-pr;

