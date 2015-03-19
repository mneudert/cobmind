       >>source format is free
*>*********************************************************************

identification division.
program-id. cobmind-cli.

*>*********************************************************************

data division.
working-storage section.

01 argv        pic x(255) value spaces.
   88 argv-db  value "-d", "--database".
   88 argv-ip  value "-i", "--ip".

01 cmdstatus   pic x value spaces.
   88 lastcmd  value "l".

linkage section.

01 lookup-db  pic x(128) value spaces.
01 lookup-ip  pic x(15) value spaces.

*>*********************************************************************

procedure division using lookup-db, lookup-ip.
  perform parse-arguments.
exit program.

*>*********************************************************************

parse-arguments.
  perform until lastcmd
    move low-values	to argv
    accept argv from argument-value

    if argv > low-values
      perform process-arguments
    else
      move "l" to cmdstatus
    end-if
  end-perform
  .

process-arguments.
  evaluate true
    when argv-db
      accept lookup-db from argument-value

    when argv-ip
      accept lookup-ip from argument-value

    when other display "invalid switch: " argv
  end-evaluate
  .
