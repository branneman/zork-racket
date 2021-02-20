#lang racket

(provide parser/parse
         parser/clean-input
         parser/words->command
         command
         command-id
         command-variables)

; parser/parse :: string -> command<id,variables>
(define (parser/parse input)
  (let* ([cleaned (parser/clean-input input)]
         [words (string-split cleaned " ")])
    (parser/words->command words)))

; parser/clean-input :: string -> string
(define parser/clean-input
  (compose1 string-downcase
            string-trim
            (λ (s) (string-replace s #px"\\s+" " "))
            (λ (s) (string-replace s #px"[^a-zA-Z\\s]" ""))))

(struct command (id variables) #:transparent)

; parser/words->command :: (string ...) -> command<id,variables>
(define (parser/words->command words)
  (define sentence-length (length words))
  (define unknown-sentence (command 'error '(input-unknown-sentence)))
  (cond
    [(> sentence-length 1)
      unknown-sentence]
    [(= sentence-length 1)
      (cond
        [(or (equal? (first words) "quit")
             (equal? (first words) "exit"))
          (command 'quit '())]
        [else unknown-sentence])]
    [(= sentence-length 0)
      (command 'error '(input-empty))]
    [else
      unknown-sentence]))
