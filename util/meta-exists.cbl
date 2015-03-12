       >>source format is free
*>*********************************************************************

identification division.
program-id. cobmind-meta-exists.

*>*********************************************************************

data division.
working-storage section.

01 metafile  pic x(128) value spaces.

linkage section.

01 database   pic x(128) value spaces.
01 result     pic x.
   88 exists  value 'Y', false 'N'.

*>*********************************************************************

procedure division using database, result.
  string database '_meta'
    delimited by space
    into metafile

  call 'cobmind-file-exists' using
    by reference metafile
    by reference result.
exit program.
