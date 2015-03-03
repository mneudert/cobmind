       >>source format is free
*>*********************************************************************

identification division.
program-id. cobmind.

*>*********************************************************************

data division.
working-storage section.

01 lookup-info.
   05 lookup-db  pic x(128) value spaces.
   05 lookup-ip  pic x(15) value spaces.

*>*********************************************************************

procedure division.
  call 'cobmind-cli' using
    by reference lookup-db
    by reference lookup-ip

  perform maybe-lookup.
stop run.

*>*********************************************************************

maybe-lookup.
  if lookup-db = spaces or low-value
    display 'missing database path! ("-d" or "--database")'
  end-if

  if lookup-ip = spaces or low-value
    display 'missing ip address! ("-i" or "--ip")'
  end-if

  if (lookup-db not = spaces and low-value)
  and (lookup-ip not = spaces and low-value)
    display "database: " lookup-db
    display "ip:       " lookup-ip
  end-if.
