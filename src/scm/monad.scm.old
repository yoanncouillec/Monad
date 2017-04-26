(module monad)

(print "Monad")

(define (getchar i)
   (list (read) (+ i 1)))

(define (getchar2 i)
   (let ((res1 (getchar i)))
      (let ((res2 (getchar (cadr res1))))
	 (list (list (car res1) (car res2)) (cadr res2)))))

(define (getchar4 i)
   (let ((res1 (getchar2 i)))
      (let ((res2 (getchar2 (cadr res1))))
	 (list (append (car res1) (car res2)) (cadr res2)))))

