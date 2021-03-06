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

01 metafile-exists-rec  pic x.
   88 metafile-exists   value 'Y', false 'N'.

01 database-handle pic x(4).

*>*********************************************************************

procedure division.
  perform parse-argv.
  perform validate-argv.
  perform maybe-lookup.
stop run.

*>*********************************************************************

maybe-extract-meta.
  call 'cobmind-meta-exists' using lookup-db, metafile-exists-rec

  if (not metafile-exists)
    display 'extracting meta data...'
    call 'mmdb2-extract-meta' using database-handle
  end-if
  .


maybe-lookup.
  if database-exists
  and (lookup-ip not = spaces and low-value)
    display 'database: ' lookup-db
    display 'ip:       ' lookup-ip

    call 'mmdb2-open' using lookup-db, database-handle

    if return-code = 0
      perform maybe-extract-meta
    end-if

    if return-code = 0
      call 'mmdb2-close' using database-handle
    end-if
  end-if
  .


parse-argv.
  call 'cobmind-cli' using lookup-db, lookup-ip

  if lookup-db = spaces or low-value
    display 'missing database path! ("-d" or "--database")'
  end-if

  if lookup-ip = spaces or low-value
    display 'missing ip address! ("-i" or "--ip")'
  end-if
  .


validate-argv.
  if lookup-db not = spaces
    call 'cobmind-file-exists' using lookup-db, database-exists-rec

    if (not database-exists)
      display 'failed to locate or open database: ' lookup-db
    end-if
  end-if
  .
