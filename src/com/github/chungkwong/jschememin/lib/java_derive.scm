(import (scheme base))
(define (scheme->java x)
        (cond ((boolean? x) (boolean->Boolean x))
              ((string? x) (string->String x))
              ((symbol? x) (symbol->String x))
              ((bytevector? x) (bytevector->ByteArray x))
              ((integer? x) (integer->Integer x))
              ((real? x) (real->Double x))
              (else x)))
(define (java->scheme x)
        (cond ((instanceof x 'java.lang.Boolean) (Boolean->boolean x))
              ((instanceof x 'java.lang.String) (String->string x))
              ((instanceof x 'java.lang.Double) (Double->real x))
              ((instanceof x 'java.lang.Integer) (Integer->integer x))
              (else x)))