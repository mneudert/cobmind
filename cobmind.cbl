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

01 database-exists-rec  pic x.
   88 database-exists   value 'Y', false 'N'.

*>*********************************************************************

procedure division.
  perform parse-argv.
  perform validate-argv.
  perform maybe-lookup.
stop run.

*>*********************************************************************

maybe-lookup.
  if database-exists
  and (lookup-ip not = spaces and low-value)
    display 'database: ' lookup-db
    display 'ip:       ' lookup-ip
  end-if.


parse-argv.
  call 'cobmind-cli' using
    by reference lookup-db
    by reference lookup-ip

  if lookup-db = spaces or low-value
    display 'missing database path! ("-d" or "--database")'
  end-if

  if lookup-ip = spaces or low-value
    display 'missing ip address! ("-i" or "--ip")'
  end-if.


validate-argv.
  if lookup-db not = spaces
    call 'cobmind-file-exists' using
      by reference lookup-db
      by reference database-exists-rec

    if (not database-exists)
      display 'failed to locate or open database: ' lookup-db
    end-if
  end-if.
