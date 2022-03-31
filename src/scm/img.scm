(define (libdir s)
  (add-module-directory s #t))
(define exec 
  (lambda argv
    (begin
     (define (command-line) argv)
     (load (car argv)))))

(define load-if-exists
  (lambda files
    (cond
      ((null? files) (if #f '()))
      ((file-exists? (car files))
       (begin
        (load (car files))
        (apply load-if-exists (cdr files))))
      (else
        (apply load-if-exists (cdr files))))))

(define start
  (lambda ()
    (let ((cmd (cdr (command-line))))
      (cond
        ((null? cmd) (repl))
        ((equal? "-" (car cmd))
         (apply exec
          (cons "/dev/stdin"
           (cdr cmd))))
        (else
          (apply exec cmd))))))
