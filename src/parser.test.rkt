(module parser racket
  (require rackunit
           "parser.rkt"
           "state.rkt")

  (module+ test
    ; parser/clean-input
    (test-case "accepts empty input"
      (check-equal?
       (parser/clean-input "")
       ""))
    (test-case "leaves correct input alone"
      (check-equal?
       (parser/clean-input "abc")
       "abc")
      (check-equal?
       (parser/clean-input "abc def")
       "abc def"))
    (test-case "trims leading whitespace"
      (check-equal?
       (parser/clean-input "   abc")
       "abc"))
    (test-case "trims trailing whitespace"
      (check-equal?
       (parser/clean-input "abc \n")
       "abc"))
    (test-case "reduces multiple whitespace characters into one"
      (check-equal?
       (parser/clean-input "abc \t\n  def  ghi jkl")
       "abc def ghi jkl"))
    (test-case "lowercases a-z"
      (check-equal?
       (parser/clean-input "abc DEF ghi")
       "abc def ghi"))
    (test-case "replaces non-A-Z characters"
      (check-equal?
       (parser/clean-input "abc 123 ghi !@# mno")
       "abc ghi mno"))

    ; parser/replace-aliases
    (test-case "replaces go/walk with move"
      (check-equal? (parser/replace-aliases '("go"))   '("move"))
      (check-equal? (parser/replace-aliases '("walk")) '("move")))
    (test-case "replaces directions"
      (check-equal? (parser/replace-aliases '("u"))       '("up"))
      (check-equal? (parser/replace-aliases '("d"))       '("down"))
      (check-equal? (parser/replace-aliases '("n"))       '("north"))
      (check-equal? (parser/replace-aliases '("ne"))      '("northeast"))
      (check-equal? (parser/replace-aliases '("e"))       '("east"))
      (check-equal? (parser/replace-aliases '("se"))      '("southeast"))
      (check-equal? (parser/replace-aliases '("s"))       '("south"))
      (check-equal? (parser/replace-aliases '("sw"))      '("southwest"))
      (check-equal? (parser/replace-aliases '("w"))       '("west"))
      (check-equal? (parser/replace-aliases '("nw"))      '("northwest"))
      (check-equal? (parser/replace-aliases '("go" "u"))  '("move" "up"))
      (check-equal? (parser/replace-aliases '("go" "d"))  '("move" "down"))
      (check-equal? (parser/replace-aliases '("go" "n"))  '("move" "north"))
      (check-equal? (parser/replace-aliases '("go" "ne")) '("move" "northeast"))
      (check-equal? (parser/replace-aliases '("go" "e"))  '("move" "east"))
      (check-equal? (parser/replace-aliases '("go" "se")) '("move" "southeast"))
      (check-equal? (parser/replace-aliases '("go" "s"))  '("move" "south"))
      (check-equal? (parser/replace-aliases '("go" "sw")) '("move" "southwest"))
      (check-equal? (parser/replace-aliases '("go" "w"))  '("move" "west"))
      (check-equal? (parser/replace-aliases '("go" "nw")) '("move" "northwest")))
    (test-case "replaces l with look"
      (check-equal? (parser/replace-aliases '("l")) '("look")))
    (test-case "replaces scream with shout"
      (check-equal? (parser/replace-aliases '("scream")) '("shout")))
    (test-case "replaces diagnostic with diagnose"
      (check-equal? (parser/replace-aliases '("diagnostic")) '("diagnose")))

    ; parser/words->command
    (test-case "accepts empty input"
      (check-equal?
       (parser/words->command '())
       (command 'error '(input-empty))))
    (test-case "recognises 'move x' (direction) command"
      (check-equal?
       (parser/words->command '("move" "up"))
       (command 'move '(up)))
      (check-equal?
       (parser/words->command '("move" "down"))
       (command 'move '(down)))
      (check-equal?
       (parser/words->command '("move" "north"))
       (command 'move '(N)))
      (check-equal?
       (parser/words->command '("move" "northeast"))
       (command 'move '(NE)))
      (check-equal?
       (parser/words->command '("move" "east"))
       (command 'move '(E)))
      (check-equal?
       (parser/words->command '("move" "southeast"))
       (command 'move '(SE)))
      (check-equal?
       (parser/words->command '("move" "south"))
       (command 'move '(S)))
      (check-equal?
       (parser/words->command '("move" "southwest"))
       (command 'move '(SW)))
      (check-equal?
       (parser/words->command '("move" "west"))
       (command 'move '(W)))
      (check-equal?
       (parser/words->command '("move" "northwest"))
       (command 'move '(NW))))
    (test-case "recognises 'go x' (direction) command"
      (check-equal?
       (parser/words->command '("move" "north"))
       (command 'move '(N)))
      (check-equal?
       (parser/words->command '("move" "northeast"))
       (command 'move '(NE))))
    (test-case "recognises `quit` command when given 'quit'"
      (check-equal?
       (parser/words->command '("quit"))
       (command 'quit '())))))
