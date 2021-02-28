#lang racket

(require "level.rkt")

(provide leveldata
         leveldata-label
         leveldata-label-set!
         leveldata-description
         leveldata-edge-direction
         leveldata-edge-direction-set!
         level/get-edges)

(graph-part 'west-of-house "West of House"
            "You are standing in an open field west of a white house, with a boarded front door."
            '((N north-of-house)
              (S south-of-house)
              ;(SW stone-barrow)
              (W forest-1)))

(graph-part 'north-of-house "North of House"
            "You are facing the north side of a white house. There is no door here, and all the windows are boarded up. To the north a narrow path winds through the trees."
            '((W west-of-house)
              (N forest-path)
              (E behind-house)))

(graph-part 'behind-house "Behind House"
            ; "slightly ajar" vs "open"
            "You are behind the white house. A path leads into the forest to the east. In one corner of the house there is a small window which is slightly ajar."
            '((N north-of-house)
              ;(E clearing-2)
              (S south-of-house)))

(graph-part 'south-of-house "South of House"
            "You are facing the south side of a white house. There is no door here, and all the windows are boarded."
            '((W west-of-house)
              (E behind-house)
              (S forest-3)))

(graph-part 'forest-path "Forest Path"
            "This is a path winding through a dimly lit forest. The path heads north-south here. One particularly large tree with some low branches stands at the edge of the path."
            '((S north-of-house)
              (W forest-1)))

(graph-part 'forest-1 "Forest"
            "This is a dimly lit forest, with large trees all around." ; + random forest sentence
            '((S forest-3)
              ;(N clearing-1)
              (E forest-path)))

(graph-part 'forest-3 "Forest"
            "This is a dimly lit forest, with large trees all around." ; + random forest sentence
            '((NW south-of-house)
              ;(N clearing-2)
              (W forest-1)))
