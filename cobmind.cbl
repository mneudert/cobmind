       >>source format is free
*>*********************************************************************

identification division.
program-id. cobmind.

*>*********************************************************************

data division.
working-storage section.

01 argv        pic x(255) value spaces.
   88 argv-db  value "-d", "--database".
   88 argv-ip  value "-i", "--ip".

01 cmdstatus   pic x value spaces.
   88 lastcmd  value "l".

01 lookup-info.
   05 lookup-db  pic x(128) value spaces.
   05 lookup-ip  pic x(15) value spaces.

*>*********************************************************************

procedure division.
perform lookup.
stop run.

*>*********************************************************************

lookup.
  perform parse-arguments.
  perform maybe-lookup.

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

parse-arguments.
  perform until lastcmd
    move low-values	to argv
    accept argv from argument-value

    if argv > low-values
      perform process-arguments
    else
      move "l" to cmdstatus
    end-if
  end-perform.

process-arguments.
  evaluate true
    when argv-db
      accept lookup-db from argument-value

    when argv-ip
      accept lookup-ip from argument-value

    when other display "invalid switch: " argv
  end-evaluate.
