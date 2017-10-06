       >>source format is free
*>*********************************************************************

identification division.
program-id. mmdb2-close.

*>*********************************************************************

data division.
linkage section.

01 database  pic x(4).

*>*********************************************************************

procedure division using database.
  call 'CBL_CLOSE_FILE' using database.

  if return-code <> 0
    display 'failed to open file (return code: ' return-code ')'
  end-if
  .
