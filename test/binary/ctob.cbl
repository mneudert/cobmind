       >>source format is free
*>*********************************************************************

identification division.
program-id. cobmind-test-binary.

*>*********************************************************************

data division.
working-storage section.

01 byte       pic x(1) value '%'.
01 bitstring  pic x(8).

01 expected  pic x(8) value '00100101'.

*>*********************************************************************

procedure division.
  call 'binary-ctob' using byte, bitstring

  if not bitstring = expected
    display 'Character to Bistring conversion failed!'

    display 'Expected: ' expected
    display 'Found:    ' bitstring

    move 1 to return-code
  end-if
stop run.
