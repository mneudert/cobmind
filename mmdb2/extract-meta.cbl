       >>source format is free
*>*********************************************************************

identification division.
program-id. mmdb2-extract-meta.

*>*********************************************************************

environment division.
input-output section.

file-control.
  select filehandle
    assign to filename
    organization is binary sequential.

*>*********************************************************************

data division.
file section.

fd filehandle.
01 databyte  pic x(1).

working-storage section.

01 filename  pic x(128) value spaces.

01 needle-rec.
   05 needle-char  pic 9(2) value 1.
   05 needle-len   pic 9(2) value 14.
   05 needle-pos   pic 9(9) value 0.
   05 needle-str   pic x(14).

01 search-pos      pic 9(9).
01 search-rec      pic x.
   88 search-done  value 'Y', false 'N'.

linkage section.

01 database  pic x(128) value spaces.

*>*********************************************************************

procedure division using database.
  move database to filename

  string X'ABCDEF' 'MaxMind.com'
    delimited by space
    into needle-str

  open input filehandle

  perform locate-meta
  display 'meta start position: ' with no advancing
  display needle-pos

  close filehandle.
exit program.

*>*********************************************************************

check-needle.
  add 1 to search-pos

  if databyte <> needle-str(needle-char:1)
    set needle-char to 1
  else
    add 1 to needle-char
  end-if

  if needle-char > needle-len
    move search-pos to needle-pos
    set search-done to true
  end-if.


locate-meta.
  perform until search-done
    read filehandle
      at end
        set search-done to true
      not at end
        perform check-needle
    end-read
  end-perform.
