#lang racket

(provide strings get-string)

(define strings (make-hash))
(define (get-string s) (hash-ref strings s))

(hash-set! strings 'intro
           "ZORK-RACKET I\nUnlicense\nZORK is a registered trademark of Infocom, Inc.\n\n")

(hash-set! strings 'health-5
           "You are in perfect health. You are strong enough to take several wounds.")
(hash-set! strings 'health-4
           "You have a light wound, which will be cured in $1 $2.\nYou can survive one serious wound.")
(hash-set! strings 'health-3
           "You have a serious wound, which will be cured in $1 $2. You can be killed by a serious wound.")
(hash-set! strings 'health-2
           "You have a several wounds, which will be cured in $1 $2. You can be killed by one more light wound.")
(hash-set! strings 'health-1
           "You have a serious wounds, which will be cured in $1 $2. You are at death's door.")
(hash-set! strings 'health-0
           "You are dead as a doornail.")

(hash-set! strings 'shout
           "Aaaarrrrgggghhhh!")

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
