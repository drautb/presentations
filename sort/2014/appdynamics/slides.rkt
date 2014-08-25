#lang slideshow

;; SORT 2014 Colors
(define sort-blue (list 24 30 53))
(define sort-red (list 248 41 42))

;; width and height of slides
(define w (+ (* 2 margin) client-w))
(define h (+ (* 2 margin) client-h))

;; Slide Assemblers
;; - blue-slide-assembler is for the title and 
;;   closing slides.
;; - sort-slide-assembler is for each content slide,
;;   it puts the slide logo bar on the bottom.
(define default-slide-assembler (current-slide-assembler))

(define blue-slide-assembler 
  (lambda (s v-sep c)
    (let ([c (colorize c "white")])
      (lt-superimpose
       (inset (colorize (filled-rectangle w h) 
                        sort-blue) 
              (- margin)) 
       c))))

(define sort-slide-assembler
  (lambda (s v-sep c)
    (lb-superimpose
     (if s
         (vc-append v-sep (titlet s) c)
         c)
     sort-footer)))


;; Helper functions
(define white-bar (colorize (filled-rectangle w 4) "white"))

(define sort-arrows
  (let* ([top-pict (colorize (circle 5) sort-blue)]
        [bottom-pict (colorize (circle 5) sort-blue)]
        [combined (vc-append 30 top-pict bottom-pict)])
    (hc-append
     (pin-arrow-line 10
                     combined
                     bottom-pict lc-find
                     top-pict lc-find
                     #:start-angle (* 3 (/ pi 4))
                     #:start-pull 1/3
                     #:end-angle (/ pi 4)
                     #:end-pull 1/3
                     #:line-width 4
                     #:color sort-red)
     (pin-arrow-line 10
                     combined
                     top-pict rc-find
                     bottom-pict rc-find
                     #:start-angle (- (/ pi 4))
                     #:start-pull 1/3
                     #:end-angle (* 5 (/ pi 4))
                     #:end-pull 1/3
                     #:line-width 4
                     #:color sort-red))))

(define sort-logo
  (parameterize ([current-font-size 48])
    (hc-append 20
               (t "SORT")
               sort-arrows
               (t "2014"))))

(define sort-logo-bar
  (vc-append 10 white-bar sort-logo white-bar))

(define sort-footer-logo
  (scale 
   (colorize
    (hc-append (colorize (circle 20) sort-blue)
               (vc-append
                sort-logo
                (parameterize ([current-font-size 22])
                  (t "ACCELERATE INNOVATION"))))
               "white") 1/3))

(define sort-footer
  (inset
   (lc-superimpose
    (colorize
     (filled-rectangle w 40)
     sort-blue)
    sort-footer-logo)
   (- margin) 
   (- (* 3.5 margin))))


;; TITLE
(current-slide-assembler blue-slide-assembler)

(slide
 (inset sort-logo-bar (- margin))
 (blank)
 (t "AppDynamics"))

;; SLIDES
(current-slide-assembler sort-slide-assembler)

(slide
 #:title "What is AppDynamics?"
 (t "It's a nifty tool"))

;; END SLIDE
(current-slide-assembler blue-slide-assembler)

(slide
 (inset sort-logo-bar (- margin))
 (blank)
 (parameterize ([current-font-size 16])
   (t "© 2014 by Intellectual Reserve, Inc. All rights reserved")))

