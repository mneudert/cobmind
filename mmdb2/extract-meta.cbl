       >>source format is free
*>*********************************************************************

identification division.
program-id. mmdb2-extract-meta.

*>*********************************************************************

data division.
working-storage section.

01 meta-offset  pic x(8) comp-x.

linkage section.

01 database  pic x(4).

*>*********************************************************************

procedure division using database.
  call 'mmdb2-locate-meta' using database, meta-offset

  display 'meta start position: ' meta-offset
exit program.
