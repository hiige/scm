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
      (if (null? cmd) (repl)
        (apply exec cmd)))))
