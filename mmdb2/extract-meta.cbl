       >>source format is free
*>*********************************************************************

identification division.
program-id. mmdb2-extract-meta.

*>*********************************************************************

data division.
working-storage section.

01 buffer-rec.
   05 buffer-byte       pic x(1).
   05 buffer-bitstring  pic x(8).

01 meta-offset  pic x(8) comp-x.

linkage section.

01 database  pic x(4).

*>*********************************************************************

procedure division using database.
  call 'mmdb2-locate-meta' using database, meta-offset

  perform read-buffer-byte

  call 'binary-ctob' using buffer-byte, buffer-bitstring

  display 'meta start:     ' meta-offset
  display 'first bistring: ' buffer-bitstring
exit program.

read-buffer-byte.
  call 'CBL_READ_FILE' using database, meta-offset, 1, 0, buffer-byte
  .
