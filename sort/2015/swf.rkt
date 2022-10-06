#lang slideshow

(require racket/draw
         pict/face
         pict/flash
         pict/code)

;; SORT 2015 Colors
(define SORT-BLUE (list 24 29 52))
(define SORT-RED (list 233 48 48))

(define TITLE "AWS  Simple  Workflow  Service")
(define SUBTITLE "SWF")

(define PRESENTED-BY "Presented by FamilySearch")
(define COPYRIGHT "© 2015 by Intellectual Reserve, Inc.  All rights reserved")

(define CRS-WORKFLOW
  (parameterize ([current-font-size 12])
    (let* ([h-arrow (arrow 30 0)]
           [happy-face (scale (face 'happier) 1/5)]
           [mean-face (scale (face 'mean) 1/5)]
           [crs (cc-superimpose (file-icon 80 95 "honeydew")
                                (vc-append (t "CRS-1337")
                                           (t "RED FISH")))]
           [split-arrows (vc-append 40 (arrow 30 (/ pi 4))
                                    (arrow 30 (- (/ pi 4))))]
           [computer (cc-superimpose (desktop-machine (/ 3 4))
                                     (t "RED FISH"))]
           [poof (cc-superimpose (colorize (filled-flash 80 80) "yellow")
                                 (cc-superimpose (colorize (filled-flash 60 60) "orange")
                                                 (colorize (filled-flash 40 40) "red")))]
           [outcomes (vc-append 30 computer poof)])
      (hc-append 10 happy-face h-arrow crs h-arrow mean-face split-arrows outcomes))))

(define DOT (circle 2))
(define ELLIPSIS (hc-append 3 DOT DOT DOT))

(define (vertical-queue)
  (define q-arrow (arrow 10 (- (/ pi 2))))
  (define q-item (filled-rectangle 8 8))
  (vc-append 3
             q-arrow
             q-item
             q-item
             q-item
             q-arrow))

(define (server)
  (let* ([light (inset (colorize (disk 5) "green") 5)]
         [line (hline 30 6)]
         [lines (inset (vc-append line line line line) 5)]
         [features (vr-append 5 light lines)])
    (rb-superimpose (frame (colorize (filled-rectangle 40 60) "gray"))
                    features)))

(define (cluster)
  (rt-superimpose (rt-superimpose (server) (inset (server) 0 10 10 0))
                  (inset (server) 0 20 20 0)))

(define (labeled-cluster label)
  (vc-append 3 (cluster) (text label (current-main-font) 12)))

;; width and height of slides
(define w (+ (* 2 margin) client-w))
(define h (+ (* 2 margin) client-h))

;; Helper functions
(define sort-arrows
  (let* ([top-pict (colorize (circle 5) SORT-BLUE)]
         [bottom-pict (colorize (circle 5) SORT-BLUE)]
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
                      #:color SORT-RED)
      (pin-arrow-line 10
                      combined
                      top-pict rc-find
                      bottom-pict rc-find
                      #:start-angle (- (/ pi 4))
                      #:start-pull 1/3
                      #:end-angle (* 5 (/ pi 4))
                      #:end-pull 1/3
                      #:line-width 4
                      #:color SORT-RED))))

(define sort-logo-main
  (parameterize ([current-main-font "Helvetica Neue"]
                 [current-font-size 60])
    (colorize
      (hc-append 25
                 sort-arrows
                 (hc-append 5
                            (bt "SORT")
                            (t "2015")))
      SORT-RED)))

(define sort-logo
  (hc-append 20
             sort-logo-main
             (filled-rectangle 5 45)
             (parameterize ([current-font-size 26])
               (vl-append (t "POWERING EXPERTISE,")
                          (t "COLLABORATION & SUCCESS")))))

(define sort-footer-logo
  (hc-append (/ w 1.8) (inset (scale (colorize sort-logo "white") 1/3) 20 0)
             (colorize (text PRESENTED-BY "Helvetica Neue" 12) "white")))

(define sort-footer
  (inset
    (lc-superimpose
      (colorize
        (filled-rectangle w 40)
        SORT-BLUE)
      sort-footer-logo)
    (- margin)))

(define church-logo
  (parameterize ([current-main-font "Palatino"])
    (vc-append 3
               (parameterize ([current-font-size 10]) (t "THE CHURCH OF"))
               (parameterize ([current-font-size 24]) (t "JESUS CHRIST"))
               (parameterize ([current-font-size 10]) (t "OF LATTER-DAY SAINTS")))))

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
                         SORT-BLUE)
               (- margin))
        c))))

(define sort-slide-assembler
  (lambda (s v-sep c)
    (let ([c (lb-superimpose c sort-footer)])
      (if s
          (vc-append 48 (titlet s) c)
          c))))

;; Setup
(set-page-numbers-visible! #f)
(current-page-number-color
  (make-color 255 255 255))

;; TITLE
(current-slide-assembler blue-slide-assembler)

(slide
  (blank 0 (/ client-h 4))
  (vl-append (parameterize ([current-font-size 55])
               (t TITLE))
             (parameterize ([current-font-size 30])
               (colorize (t SUBTITLE) SORT-RED)))
  (blank 0 (/ client-h 3))
  sort-logo
  (t PRESENTED-BY))

;; SLIDES
(current-slide-assembler sort-slide-assembler)

(slide
  #:title "What is SWF?"
  'next
  (item "A workflow engine!")
  'next
  (item "A framework for orchestrating a set of related tasks.")
  'next
  (standard-fish 60 30 #:direction 'right)
  'next
  (blank)
  CRS-WORKFLOW
  'next
  (blank)
  (standard-fish 60 30 #:direction 'right #:color "red")
  'next
  (t "How could you build a distributed system to automate this?"))

(parameterize ([current-font-size 22])
  (slide
    #:title "SWF Vocabulary - I"
    'next
    (item "Domain")
    (subitem "Namespace for SWF components.")
    'next
    (item "Decider")
    (subitem "Stateless.")
    (subitem "'Decides' what to do next.")
    (subitem "Must be deterministic.")
    (subitem (it "Decider Worker") "or" (it "Workflow Worker"))
    'next
    (item "Workflow Execution")
    (subitem "An instance of a workflow.")))

(parameterize ([current-font-size 22])
  (slide
    #:title "SWF Vocabulary - II"
    'next
    (item "Activity")
    (subitem "A task that progresses the workflow.")
    (subitem (it "Activity Worker"))
    'next
    (item "Tasklist")
    (subitem "A queue for tasks awaiting execution.")))

(slide
  #:title "Outline"
  (item "What are the tasks?")
  'next
  (subitem "Obtain approval for request.")
  (subitem "Apply change. (If approved)"))

(slide
  #:title "SWF Model"
  'alts
  (let* ([user (vc-append (desktop-machine 1/2)
                          (text "You" (current-main-font) 10))]
         [decision-queue (vertical-queue)]
         [activity-queue (vertical-queue)]
         [queues
          (vc-append (text "Tasklists" (current-main-font) 12)
                     (inset (hc-append 10
                                       decision-queue
                                       activity-queue
                                       ELLIPSIS)
                            30 5 5 5))]
         [swf-cloud (cc-superimpose (cloud 100 80 "orange")
                                    (t "SWF"))]
         [swf (cc-superimpose
                (inset queues 150 0 0 50)
                swf-cloud)]
         [decider-workers (labeled-cluster "Decider Workers")]
         [activity-workers (labeled-cluster "Activity Workers")]
         [scene (hc-append 150
                           user
                           (vc-append 30
                                      swf
                                      (hc-append 30 decider-workers activity-workers)))]
         [model (cc-superimpose scene
                                (pin-arrow-line 5 (ghost scene) decider-workers ct-find swf-cloud cb-find
                                                #:start-angle (/ pi 2)
                                                #:end-angle (/ pi 2))
                                (pin-arrow-line 5 (ghost scene) activity-workers ct-find swf-cloud cb-find
                                                #:start-angle (/ pi 2)
                                                #:end-angle (/ pi 2)))]
         [schedule-decision-task
          (list (para "SWF schedules a decision task.")
                (cc-superimpose model
                                (pin-arrow-line 5 (ghost model) swf-cloud ct-find decision-queue ct-find
                                                #:start-angle (/ pi 2)
                                                #:end-angle (- (/ pi 2)))))]
         [schedule-activity-task
          (list (para "SWF schedules an activity task.")
                (cc-superimpose model
                                (pin-arrow-line 5 (ghost model) swf-cloud ct-find activity-queue ct-find
                                                #:start-angle (/ pi 2)
                                                #:end-angle (- (/ pi 2)))))]
         [decider-executes
          (list (para "A decider worker executes the task.")
                (cc-superimpose model
                                (pin-arrow-line 5 (ghost model) decision-queue cb-find decider-workers rtl-find
                                                #:start-angle (- (/ pi 2))
                                                #:end-angle pi)))]
         [activity-executes
          (list (para "An activity worker executes the task.")
                (cc-superimpose model
                                (pin-arrow-line 5 (ghost model) activity-queue cb-find activity-workers rtl-find
                                                #:start-angle (- (/ pi 2))
                                                #:end-angle pi)))])
    (list
      (list
        (para "Example model.")
        model)
      (list
        (para "You initiate a workflow by requesting a color change.")
        (cc-superimpose model
                        (pin-arrow-line 5 model user rc-find swf-cloud lc-find #:end-angle (* 2 pi))))
      schedule-decision-task
      decider-executes
      schedule-activity-task
      activity-executes
      schedule-decision-task
      decider-executes
      schedule-activity-task
      activity-executes
      schedule-decision-task
      (list
        (para "There are no more outstanding tasks, so the execution is complete.")
        model))))

(slide #:title "Demo"
       (vc-append (scale-to-fit (bitmap "code.png") 640 480)
                  (text "https://mediafinder.ldschurch.org/entry/aa09499a6f7d4d76af7f2d1addc9115f"
                        (current-main-font) 18)))

(slide
  #:title "Additional Resources"
  (item "AWS Documentation")
  (item "GitHub: pedropaulovc/aws-flow-maven-eclipse-samples"))

(slide #:title "Questions?"
       (scale-to-fit (vc-append (bitmap "questions.png")
                                (text "https://mediafinder.ldschurch.org/entry/4e02854d34404422bb194c0e11ef0119"
                                      (current-main-font) 38)) 640 480))


;; END SLIDE
(current-slide-assembler blue-slide-assembler)

(slide
  (blank 0 (/ client-h 4))
  sort-logo
  (blank)
  (t PRESENTED-BY)
  (blank 0 (/ client-h 4))
  church-logo
  (parameterize ([current-font-size 18])
    (t COPYRIGHT)))
