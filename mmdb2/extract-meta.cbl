       >>source format is free
*>*********************************************************************

identification division.
program-id. mmdb2-extract-meta.

*>*********************************************************************

data division.
working-storage section.

01 meta-offset  pic x(8) comp-x.

01 needle-rec.
   05 needle-char  pic x(1) comp-x.
   05 needle-len   pic x(1) comp-x.
   05 needle-str   pic x(14).

01 search-rec      pic x.
   88 search-done  value 'Y', false 'N'.

linkage section.

01 database  pic x(4).

*>*********************************************************************

procedure division using database.
  call 'mmdb2-locate-meta' using database, meta-offset

  display 'meta start position: ' with no advancing
  display meta-offset
exit program.
