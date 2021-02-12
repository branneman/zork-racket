# TODO

## Large tasks

- Add state store
- Load world from file
- Save+Load state
- Add `Revision 88 / Serial number 840726` line, e.g.:
  ```sh
  echo Revision $(git rev-list --all --count) / Serial number $(git rev-parse --short HEAD)
  ```
- Full-screen rendering (top bar with location, score, moves)

## Medium tasks

- Store level data (graph) in a data file (as s-expressions)

## Small tasks

- Gather actual zork questions + replies, use those strings
- Capture Ctrl-C, no-op
