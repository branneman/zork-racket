Sources:
[Infocom-type parser](http://www.ifwiki.org/index.php/Infocom-type_parser),
[Zork I – Guide and Walkthrough](https://gamefaqs.gamespot.com/pc/564446-zork-i/faqs/65211),
Zork 1 maps
  ([1](https://gue.cgwmuseum.org/galleries/others/zork1_zug_map_1.jpg),
  [2](https://gue.cgwmuseum.org/galleries/others/zork1_zug_map_2.jpg),
  [3](https://gue.cgwmuseum.org/galleries/others/zork1_zug_map_3.jpg),
  [4](https://gue.cgwmuseum.org/galleries/others/zork1_zug_map_4.jpg))

## Large tasks

- Finish graph: vertexes, edges, directions, strings
- Save+Load state
- Full-screen rendering (top bar with location, score, moves)
- Arrow keys behave like prompt

## Medium tasks

- Forest vertex gives random forest sentence.
- `enter` and `exit` commands are for entering and leaving buildings/rooms/etc.
- Inventory (`inventory`, `take bottle`, `take all`, `pick/take/grab`):
   ```
   You are empty-handed.
   ```

   ```
   You are carrying:
     A glass bottle
     The glass bottle contains:
       A quantity of water
     A brown sack
   ```
- Add `Revision 88 / Serial number 840726` line, e.g.:
  ```sh
  echo Revision $(git rev-list --all --count) / Serial number $(git rev-parse --short HEAD)
  ```

## Small tasks

- `restart` command
- 'number of moves' starts at 1 instead of 0 (because of `zork.rkt`'s `repl/handler` call)
- Capture Ctrl-C, Ctrl+D: quit
- Healing (`wait`, 3 moves): `Time passes...`
- Verbosity:
  ```
  verbose:    Maximum verbosity.
  brief:      Brief descriptions.
  superbrief: Super-brief descriptions.
  ```
- Randomness:
  ```
  jump, hop, leap:  Very good. Now you can go to the second grade.
                    Are you enjoying yourself?
                    Do you expect me to applaud?
                    Wheeeeeeeeee!!!!!
  scream, shout:    "Aaaarrrrgggghhhh!"
  rape x:           "What an (ahem!) strange idea."
  zork:             "At your service."
  eat self:         "Auto-cannibalism is not the answer."
  ```
