       >>source format is free
*>*********************************************************************

identification division.
program-id. mmdb2-extract-meta.

*>*********************************************************************

data division.
working-storage section.

01 buffer       pic x(1).

01 file-handle  pic x(4).
01 file-offset  pic x(8) comp-x.

01 needle-rec.
   05 needle-char  pic x(1) comp-x.
   05 needle-len   pic x(1) comp-x.
   05 needle-str   pic x(14).

01 search-rec      pic x.
   88 search-done  value 'Y', false 'N'.

linkage section.

01 database  pic x(128) value spaces.

*>*********************************************************************

procedure division using database.
  move 1  to needle-char
  move 14 to needle-len

  string X'ABCDEF' 'MaxMind.com'
    delimited by space
    into needle-str

  perform open-meta
  perform locate-meta
  perform close-meta

  display 'meta start position: ' with no advancing
  display file-offset
exit program.

*>*********************************************************************

check-needle.
  call 'CBL_READ_FILE' using file-handle, file-offset, 1, 0, buffer

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

  add 1 to file-offset

  if needle-char > needle-len
    set search-done to true
  end-if
  .


close-meta.
  call 'CBL_CLOSE_FILE' using file-handle.

  if return-code <> 0
    display 'failed to open meta file (return code: ' return-code ')'
  end-if
  .


locate-meta.
  perform until search-done
    perform check-needle
  end-perform
  .


open-meta.
  call 'CBL_OPEN_FILE' using database, 1, 0, 0, file-handle

  if return-code <> 0
    display 'failed to open meta file (return code: ' return-code ')'
    goback
  end-if
  .
