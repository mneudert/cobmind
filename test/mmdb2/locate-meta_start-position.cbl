       >>source format is free
*>*********************************************************************

identification division.
program-id. cobmind-test-mmdb2.

*>*********************************************************************

data division.
working-storage section.

01 database-handle  pic x(4).
01 database-path    pic x(128) value './test-data/CobMind.mmdb'.
01 meta-offset      pic x(8) comp-x.

01 expected  pic x(8) comp-x value 515.

*>*********************************************************************

procedure division.
  call 'mmdb2-open' using database-path, database-handle
  call 'mmdb2-locate-meta' using database-handle, meta-offset

  if not meta-offset = expected
    display 'Found Metadata at wrong position!'

    display 'Expected: ' expected
    display 'Found:    ' meta-offset

    move 1 to return-code
  end-if
stop run.
