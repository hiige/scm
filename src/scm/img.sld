(define-library (scm img)
  (export start load-if-exists libdir)
  (import
   (chibi) (chibi repl)
   (chibi filesystem) (chibi assert))
  (include "img.scm"))
