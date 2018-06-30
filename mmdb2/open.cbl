       >>source format is free
*>*********************************************************************

identification division.
program-id. mmdb2-open.

*>*********************************************************************

data division.
linkage section.

01 database  pic x(4).
01 filename  pic x(128).

*>*********************************************************************

procedure division using filename, database.
  call 'CBL_OPEN_FILE' using filename, 1, 0, 0, database

  if return-code <> 0
    display 'failed to open file (return code: ' return-code ')'
  end-if
exit program.
