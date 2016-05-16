       >>source format is free
*>*********************************************************************

identification division.
program-id. binary-ctob.

*>*********************************************************************

data division.
working-storage section.

01 buffer  pic 999.

linkage section.

01 byte       pic x(1).
01 bitstring  pic x(8).

*>*********************************************************************

procedure division using byte, bitstring.
  compute buffer = function ord(byte) - 1
  move '00000000' to bitstring

  if buffer >= 128
    move '1' to bitstring(1:1)
    subtract 128 from buffer
  end-if

  if buffer >= 64
    move '1' to bitstring(2:1)
    subtract 64 from buffer
  end-if

  if buffer >= 32
    move '1' to bitstring(3:1)
    subtract 32 from buffer
  end-if

  if buffer >= 16
    move '1' to bitstring(4:1)
    subtract 16 from buffer
  end-if

  if buffer >= 8
    move '1' to bitstring(5:1)
    subtract 8 from buffer
  end-if

  if buffer >= 4
    move '1' to bitstring(6:1)
    subtract 4 from buffer
  end-if

  if buffer >= 2
    move '1' to bitstring(7:1)
    subtract 2 from buffer
  end-if

  if buffer >= 1
    move '1' to bitstring(8:1)
    subtract 1 from buffer
  end-if
exit program.
