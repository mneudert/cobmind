       >>source format is free
*>*********************************************************************

identification division.
program-id. cobmind-file-exists.

*>*********************************************************************

environment division.
input-output section.

file-control.
  select filehandle
    assign to filename
    file status is filestatus.

*>*********************************************************************

data division.
file section.

fd filehandle.
01 filehandle-rec  pic x(128).

working-storage section.

01 filename    pic x(128) value spaces.
01 filestatus  pic xx value '00'.

linkage section.

01 name       pic x(128) value spaces.
01 result     pic x.
   88 exists  value 'Y', false 'N'.

*>*********************************************************************

procedure division using name, result.
  move name to filename

  perform check.
exit program.

*>*********************************************************************

check.
  open input filehandle

  if '00' = filestatus
    set exists to true
  else
    set exists to false
  end-if

  close filehandle.
