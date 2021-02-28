#lang racket

(provide strings get-string)

(define strings (make-hash))
(define (get-string s) (hash-ref strings s))

(hash-set! strings 'intro
           "ZORK-RACKET I\nUnlicense\nZORK is a registered trademark of Infocom, Inc.\n\n")

(hash-set! strings 'score
           "Your score is $1 (total of $2 points), in $3 moves.")
(hash-set! strings 'rank
           "This gives you the rank of $1")

(hash-set! strings 'input-empty
           "I beg your pardon?")
(hash-set! strings 'input-unknown-word
           "I don't know the word \"$1\".")
(hash-set! strings 'input-unknown-sentence
           "That sentence isn't one I recognize.")
(hash-set! strings 'input-direction-wrong
           "You can't go that way.")
