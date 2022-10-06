#lang slideshow

(require racket/draw)

;; SORT 2014 Colors
(define sort-blue (list 24 30 53))
(define sort-red (list 248 41 42))

;; width and height of slides
(define w (+ (* 2 margin) client-w))
(define h (+ (* 2 margin) client-h))

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
   (- margin)))

(define (repeat subject n)
  (cond [(= n 0) subject]
        [else (values subject (repeat subject (- n 1)))]))

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
    (let ([c (lb-superimpose c sort-footer)])
      (if s
          (vc-append 48 (titlet s) c)
          c))))

;; Setup
(current-page-number-color 
 (make-color 255 255 255))

;; TITLE
(current-slide-assembler blue-slide-assembler)

(slide
 (inset sort-logo-bar (- margin))
 (blank)
 (t "Application Performance Monitoring with AppDynamics")
 (comment "My name is Ben Draut. I'm a member of the platform team at FamilySearch where we've been working on building a PaaS on AWS.\n"
          "We use AppDynamics to monitor our Java applications. My goal today is to show where the value-add is for us in using AppD.\n"
          "If you're already using it at FamilySearch, hopefully you'll gain a better understanding today of the kinds of things you can do.\n"
          "If you're not already using it, hopefully this will help you make a decision, or at least satiate your curiosity. :)\n"))

;; SLIDES
(current-slide-assembler sort-slide-assembler)

(slide
 #:title "What is AppDynamics?"
 (item "From their website:")
 (para #:align 'center
       (it "\"Monitor, automate, and analyze every business transaction")
       (it "with the AppDynamics Application Intelligence Platform\""))
 (blank)
 'next
 (item "A performance managment tool.")
 (item "Gives high visibility into application.")
 (item "Learns (or can be taught) to recognize and respond to abnormalaties."))

(slide
 #:title "Some Examples"
 'next
 (item "Autoscaling")
 'next
 (item "Runbook Automation")
 'next
 (item "Custom Dashboards/Reports")
 'next
 (item "Something you wouldn't expect, something cool about AppD.")) 

(let* ([app-node (parameterize ([current-font-size 16])
                   (cc-superimpose (colorize (rounded-rectangle 100 60 10) "blue") (t "App Server")))]
       [app-layer (hc-append 20 app-node app-node app-node)]
       [tier (cc-superimpose app-layer (parameterize ([current-font-size 20])
               (ct-superimpose (colorize (rounded-rectangle 400 300 10) "green") (t "App Tier"))))])
  (slide
   #:title "How AppDynamics Sees the World"
   app-layer
   'next
   tier))


(slide
 (t "Questions"))

;; END SLIDE
(current-slide-assembler blue-slide-assembler)

(slide
 (inset sort-logo-bar (- margin))
 (blank)
 (parameterize ([current-font-size 16])
   (t "© 2014 by Intellectual Reserve, Inc. All rights reserved")))
