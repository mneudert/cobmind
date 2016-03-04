       >>source format is free
*>*********************************************************************

identification division.
program-id. mmdb2-locate-meta.

*>*********************************************************************

data division.
working-storage section.

01 buffer  pic x(1).

01 needle-rec.
   05 needle-char  pic x(1) comp-x.
   05 needle-len   pic x(1) comp-x.
   05 needle-str   pic x(14).

01 search-rec      pic x.
   88 search-done  value 'Y', false 'N'.

linkage section.

01 database  pic x(4).
01 offset    pic x(8) comp-x.

*>*********************************************************************

procedure division using database, offset.
  move 1  to needle-char
  move 14 to needle-len

  string X'ABCDEF' 'MaxMind.com'
    delimited by space
    into needle-str

  perform locate-meta
exit program.

*>*********************************************************************

check-needle.
  call 'CBL_READ_FILE' using database, offset, 1, 0, buffer

  if return-code <> 0
    display 'failed to read file (return code: ' return-code ')'

    set search-done to true
    goback
  end-if

  if buffer = needle-str(needle-char:1)
    add 1 to needle-char
  else
    move 1 to needle-char
  end-if

  add 1 to offset

  if needle-char > needle-len
    set search-done to true
  end-if
  .


locate-meta.
  perform until search-done
    perform check-needle
  end-perform
  .
