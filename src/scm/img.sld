(define-library (scm img)
  (export start load-if-exists)
  (import
   (chibi) (chibi repl)
   (chibi filesystem) (chibi assert))
  (include "img.scm"))
