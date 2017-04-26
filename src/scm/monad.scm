(module monad)

(define (>> action1 action2 world)
   (let ((res1 (action1 world)))
      (action2 (cadr res1))))

(define (>>= action1 action2 world)
   (let ((res1 (action1 world)))
      (action2 (car res1) (cadr res1))))

(define (return a world)
   (list a world))

;;; EXAMPLE ;;;

(define (getchar world)
   (list (read) (+ world 1)))

(define (print-world input world)
   (print input)
   (list input (+ world 1)))

;;; MAIN ;;;

(define (main0 world)
  (>>=
   (lambda (world) (list "a" world))
   (lambda (a world) (print-world a world))
   world))

(define (main1 world)
   (>>=
      (lambda (world)
	 (>>
	    (lambda (world) (print-world "What is your name?" world))
	    getchar
	    world))
      (lambda (a world)
	 (>>=
	    (lambda (world)
	       (>>
		  (lambda (world) (print-world "How old are you?" world))
		  getchar
		  world))
	    (lambda (b world) (print-world (string-append 
					    "Hey "
					    (symbol->string a)
					    "! You still rock at "
					    (number->string b) "!") 
					   world))
	    world))
      world))

(define (main4 world)
   (>>=
      getchar ; (lambda (world) (getchar world))
      (lambda (a world) (return (* a 2) world))
      world))

;;; EXECUTE ;;;

(main1 0)
