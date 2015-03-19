       >>source format is free
*>*********************************************************************

identification division.
program-id. mmdb2-close.

*>*********************************************************************

data division.
linkage section.

01 handle  pic x(4).

*>*********************************************************************

procedure division using handle.
  call 'CBL_CLOSE_FILE' using handle.

  if return-code <> 0
    display 'failed to open meta file (return code: ' return-code ')'
  end-if
  .
