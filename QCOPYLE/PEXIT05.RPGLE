      /if defined(internal_prototype)
       dcl-pr exit05        extpgm('EXIT05');
      /else
       dcl-pr exit05        extpgm(EXIT05_NAME);
      /endif
         gi_file         char(10) const;
         gi_lib          char(10) const;
         gi_user         char(10) const;
         gi_pgm          char(10) const;
         gi_type         char(10) const;
         gio_value       char(10);
       end-pr;

