
		assertExpressionValue("(let ((p (lambda (x) x)))");
		assertExpressionValue("  (eqv? p p))","#t");
		assertExpressionValue("(eqv? \#f 'nil)","#f%");
		assertExpressionValue("(define gen-counter");
		assertExpressionValue("  (lambda ()");
		assertExpressionValue("    (let ((n 0))");
		assertExpressionValue("      (lambda () (set! n (+ n 1)) n))))");
		assertExpressionValue("(let ((g (gen-counter)))");
		assertExpressionValue("  (eqv? g g))","#t");
		assertExpressionValue("(eqv? (gen-counter) (gen-counter))","#f");
		assertExpressionValue("(define gen-loser");
		assertExpressionValue("  (lambda ()");
		assertExpressionValue("    (let ((n 0))");
		assertExpressionValue("      (lambda () (set! n (+ n 1)) 27))))");
		assertExpressionValue("(let ((g (gen-loser)))");
		assertExpressionValue("  (eqv? g g))","#t");
		assertExpressionValue("(eqv? (gen-loser) (gen-loser))","\unspecified");
		assertExpressionValue("");
		assertExpressionValue("(letrec ((f (lambda () (if (eqv? f g) 'both 'f)))");
		assertExpressionValue("         (g (lambda () (if (eqv? f g) 'both 'g))))");
		assertExpressionValue("  (eqv? f g))","\unspecified");
		assertExpressionValue("");
		assertExpressionValue("(letrec ((f (lambda () (if (eqv? f g) 'f 'both)))");
		assertExpressionValue("         (g (lambda () (if (eqv? f g) 'g 'both))))");
		assertExpressionValue("  (eqv? f g))","#f%");
		assertExpressionValue("(let ((x '(a)))");
		assertExpressionValue("  (eqv? x x))","#t%");
		assertExpressionValue("(let ((n (+ 2 3)))");
		assertExpressionValue("  (eq? n n))","\unspecified");
		assertExpressionValue("(let ((x '(a)))");
		assertExpressionValue("  (eq? x x))","#t");
		assertExpressionValue("(let ((x '\#()))");
		assertExpressionValue("  (eq? x x))","#t");
		assertExpressionValue("(let ((p (lambda (x) x)))");
		assertExpressionValue("  (eq? p p))","#t%");
		assertExpressionValue("");

		assertExpressionValue("(define x (list 'a 'b 'c))");
		assertExpressionValue("(define y x)");
		assertExpressionValue("y","(a b c)");
		assertExpressionValue("(list? y)","#t");
		assertExpressionValue("(set-cdr! x 4)","\unspecified");
		assertExpressionValue("x","(a . 4)");
		assertExpressionValue("(eqv? x y)","#t");
		assertExpressionValue("y","(a . 4)");
		assertExpressionValue("(list? y)","#f");
		assertExpressionValue("(set-cdr! x x)","\unspecified");
		assertExpressionValue("(list? x)","#f%");

		assertExpressionValue("(define (f) (list 'not-a-constant-list))");
		assertExpressionValue("(define (g) '(constant-list))");
		assertExpressionValue("(set-car! (f) 3)","\unspecified");
		assertExpressionValue("(set-car! (g) 3)","\scherror%");
		assertExpressionValue("        (list? '(a b c))","#t");
		assertExpressionValue("        (list? '())","#t");
		assertExpressionValue("        (list? '(a . b))","#f");
		assertExpressionValue("        (let ((x (list 'a)))");
		assertExpressionValue("          (set-cdr! x x)");
		assertExpressionValue("          (list? x))","#f%");
		assertExpressionValue("(let ((ls (list 'one 'two 'five!)))");
		assertExpressionValue("  (list-set! ls 2 'three)");
		assertExpressionValue("  ls)      \lev  (one two three)");
		assertExpressionValue("");
		assertExpressionValue("(list-set! '(0 1 2) 1 "oops")  \lev  \scherror  ; constant list%");
		assertExpressionValue("(memq 'a '(a b c))","(a b c)");
		assertExpressionValue("(memq 'b '(a b c))","(b c)");
		assertExpressionValue("(memq 'a '(b c d))","#f");
		assertExpressionValue("(memq (list 'a) '(b (a) c))","#f");
		assertExpressionValue("(member (list 'a)");
		assertExpressionValue("        '(b (a) c))","((a) c)");
		assertExpressionValue("(member "B"");
		assertExpressionValue("        '("a" "b" "c")");
		assertExpressionValue("        string-ci=?)","("b" "c")");
		assertExpressionValue("(memq 101 '(100 101 102))","\unspecified");
		assertExpressionValue("(memv 101 '(100 101 102))","(101 102)%");
		assertExpressionValue("(define e '((a 1) (b 2) (c 3)))");
		assertExpressionValue("(assq 'a e)","(a 1)");
		assertExpressionValue("(assq 'b e)","(b 2)");
		assertExpressionValue("(assq 'd e)","#f");
		assertExpressionValue("(assq (list 'a) '(((a)) ((b)) ((c))))","#f");
		assertExpressionValue("(assoc (list 'a) '(((a)) ((b)) ((c))))","((a))");
		assertExpressionValue("(assoc 2.0 '((1 1) (2 4) (3 9)) =)","(2 4)");
		assertExpressionValue("(assq 5 '((2 3) (5 7) (11 13)))","\unspecified");
		assertExpressionValue("(assv 5 '((2 3) (5 7) (11 13)))","(5 7)%");
		assertExpressionValue("(define a '(1 8 2 8)) ; a may be immutable");
		assertExpressionValue("(define b (list-copy a))");
		assertExpressionValue("(set-car! b 3)        ; b is mutable");
		assertExpressionValue("b","(3 8 2 8)");
		assertExpressionValue("a","(1 8 2 8)%");



		assertExpressionValue("(define (f) (make-string 3 \sharpsign\backwhack{}*))");
		assertExpressionValue("(define (g) "***")");
		assertExpressionValue("(string-set! (f) 0 \sharpsign\backwhack{}?)","\unspecified");
		assertExpressionValue("(string-set! (g) 0 \sharpsign\backwhack{}?)","\scherror");
		assertExpressionValue("(string-set! (symbol->string 'immutable)");
		assertExpressionValue("             0");
		assertExpressionValue("             \sharpsign\backwhack{}?)","\scherror%");
		assertExpressionValue("(define a "12345")");
		assertExpressionValue("(define b (string-copy "abcde"))");
		assertExpressionValue("(string-copy! b 1 a 0 2)");
		assertExpressionValue("b",""a12de"%");
		assertExpressionValue("(vector 'a 'b 'c)","\#(a b c)%");
		assertExpressionValue("(vector-ref '\#(1 1 2 3 5 8 13 21)");
		assertExpressionValue("            5)  \lev  8");
		assertExpressionValue("(vector-ref '\#(1 1 2 3 5 8 13 21)");
		assertExpressionValue("            (exact");
		assertExpressionValue("             (round (* 2 (acos -1))))) \lev 13%");
		assertExpressionValue("(let ((vec (vector 0 '(2 2 2 2) "Anna")))");
		assertExpressionValue("  (vector-set! vec 1 '("Sue" "Sue"))");
		assertExpressionValue("  vec)      \lev  \#(0 ("Sue" "Sue") "Anna")");
		assertExpressionValue("");
		assertExpressionValue("(vector-set! '\#(0 1 2) 1 "doe")  \lev  \scherror  ; constant vector%");
		assertExpressionValue("(vector->list '\#(dah dah didah))  \lev  (dah dah didah)");
		assertExpressionValue("(vector->list '\#(dah dah didah) 1 2) \lev (dah)");
		assertExpressionValue("(list->vector '(dididit dah))   \lev  \#(dididit dah)%");
		assertExpressionValue("(string->vector "ABC")","\#(\#\backwhack{}A \#\backwhack{}B \#\backwhack{}C)");
		assertExpressionValue("(vector->string");
		assertExpressionValue("  \#(\#\backwhack{}1 \#\backwhack{}2 \#\backwhack{}3)",""123"");
		assertExpressionValue("(define a \#(1 8 2 8)) ; a may be immutable");
		assertExpressionValue("(define b (vector-copy a))");
		assertExpressionValue("(vector-set! b 0 3)   ; b is mutable");
		assertExpressionValue("b","\#(3 8 2 8)");
		assertExpressionValue("(define c (vector-copy b 1 3))");
		assertExpressionValue("c","\#(8 2)%");
		assertExpressionValue("(define a (vector 1 2 3 4 5))");
		assertExpressionValue("(define b (vector 10 20 30 40 50))");
		assertExpressionValue("(vector-copy! b 1 a 0 2)");
		assertExpressionValue("b","\#(10 1 2 40 50)%");
		assertExpressionValue("(vector-append \#(a b c) \#(d e f)) \lev \#(a b c d e f)%");
		assertExpressionValue("(define a (vector 1 2 3 4 5))");
		assertExpressionValue("(vector-fill! a 'smash 2 4)");
		assertExpressionValue("a \lev \#(1 2 smash smash 5)%");
		assertExpressionValue("\#u8(0 10 5)%");

		assertExpressionValue("(procedure? car)","#t");
		assertExpressionValue("(procedure? 'car)","#f");
		assertExpressionValue("(procedure? (lambda (x) (* x x)))","#t");
		assertExpressionValue("(procedure? '(lambda (x) (* x x)))","#f");
		assertExpressionValue("(call-with-current-continuation procedure?)","#t%");
		assertExpressionValue("(apply + (list 3 4))","7");
		assertExpressionValue("");
		assertExpressionValue("(define compose");
		assertExpressionValue("  (lambda (f g)");
		assertExpressionValue("    (lambda args");
		assertExpressionValue("      (f (apply g args)))))");
		assertExpressionValue("");
		assertExpressionValue("((compose sqrt *) 12 75)","30%");
		assertExpressionValue("(map cadr '((a b) (d e) (g h)))   \lev  (b e h)");
		assertExpressionValue("");
		assertExpressionValue("(map (lambda (n) (expt n n))");
		assertExpressionValue("     '(1 2 3 4 5))                \lev  (1 4 27 256 3125)");
		assertExpressionValue("");
		assertExpressionValue("(map + '(1 2 3) '(4 5 6 7))","(5 7 9)");
		assertExpressionValue("");
		assertExpressionValue("(let ((count 0))");
		assertExpressionValue("  (map (lambda (ignored)");
		assertExpressionValue("         (set! count (+ count 1))");
		assertExpressionValue("         count)");
		assertExpressionValue("       '(a b)))","(1 2) \var{or} (2 1)%");
		assertExpressionValue("(string-map char-foldcase "AbdEgH") \lev  "abdegh"");
		assertExpressionValue("");
		assertExpressionValue("(string-map");
		assertExpressionValue(" (lambda (c)");
		assertExpressionValue("   (integer->char (+ 1 (char->integer c))))");
		assertExpressionValue(" "HAL")                \lev  "IBM"");
		assertExpressionValue("");
		assertExpressionValue("(string-map");
		assertExpressionValue(" (lambda (c k)");
		assertExpressionValue("   ((if (eqv? k \sharpsign\backwhack{}u) char-upcase char-downcase)");
		assertExpressionValue("    c))");
		assertExpressionValue(" "studlycaps xxx"");
		assertExpressionValue(" "ululululul")   \lev   "StUdLyCaPs"%");
		assertExpressionValue("(vector-map cadr '\#((a b) (d e) (g h)))   \lev  \#(b e h)");
		assertExpressionValue("");
		assertExpressionValue("(vector-map (lambda (n) (expt n n))");
		assertExpressionValue("            '\#(1 2 3 4 5))                \lev  \#(1 4 27 256 3125)");
		assertExpressionValue("");
		assertExpressionValue("(vector-map + '\#(1 2 3) '\#(4 5 6 7))       \lev  \#(5 7 9)");
		assertExpressionValue("");
		assertExpressionValue("(let ((count 0))");
		assertExpressionValue("  (vector-map");
		assertExpressionValue("   (lambda (ignored)");
		assertExpressionValue("     (set! count (+ count 1))");
		assertExpressionValue("     count)");
		assertExpressionValue("   '\#(a b)))","\#(1 2) \var{or} \#(2 1)%");
		assertExpressionValue("(let ((v (make-vector 5)))");
		assertExpressionValue("  (for-each (lambda (i)");
		assertExpressionValue("              (vector-set! v i (* i i)))");
		assertExpressionValue("            '(0 1 2 3 4))");
		assertExpressionValue("  v)","\#(0 1 4 9 16)%");
		assertExpressionValue("(let ((v '()))");
		assertExpressionValue("  (string-for-each");
		assertExpressionValue("   (lambda (c) (set! v (cons (char->integer c) v)))");
		assertExpressionValue("   "abcde")");
		assertExpressionValue("  v)","(101 100 99 98 97)%");
		assertExpressionValue("(let ((v (make-list 5)))");
		assertExpressionValue("  (vector-for-each");
		assertExpressionValue("   (lambda (i) (list-set! v i (* i i)))");
		assertExpressionValue("   '\#(0 1 2 3 4))");
		assertExpressionValue("  v)","(0 1 4 9 16)%");
		assertExpressionValue("(call-with-current-continuation");
		assertExpressionValue("  (lambda (exit)");
		assertExpressionValue("    (for-each (lambda (x)");
		assertExpressionValue("                (if (negative? x)");
		assertExpressionValue("                    (exit x)))");
		assertExpressionValue("              '(54 0 37 -3 245 19))");
		assertExpressionValue("    #t))","-3");
		assertExpressionValue("");
		assertExpressionValue("(define list-length");
		assertExpressionValue("  (lambda (obj)");
		assertExpressionValue("    (call-with-current-continuation");
		assertExpressionValue("      (lambda (return)");
		assertExpressionValue("        (letrec ((r");
		assertExpressionValue("                  (lambda (obj)");
		assertExpressionValue("                    (cond ((null? obj) 0)");
		assertExpressionValue("                          ((pair? obj)");
		assertExpressionValue("                           (+ (r (cdr obj)) 1))");
		assertExpressionValue("                          (else (return #f))))))");
		assertExpressionValue("          (r obj))))))");
		assertExpressionValue("");
		assertExpressionValue("(list-length '(1 2 3 4))","4");
		assertExpressionValue("");
		assertExpressionValue("(list-length '(a b . c))","#f%");
		assertExpressionValue("(call-with-values (lambda () (values 4 5))");
		assertExpressionValue("                  (lambda (a b) b))","5");
		assertExpressionValue("");
		assertExpressionValue("(call-with-values * -)","-1%");
		assertExpressionValue("(let ((path '())");
		assertExpressionValue("      (c \#f))");
		assertExpressionValue("  (let ((add (lambda (s)");
		assertExpressionValue("               (set! path (cons s path)))))");
		assertExpressionValue("    (dynamic-wind");
		assertExpressionValue("      (lambda () (add 'connect))");
		assertExpressionValue("      (lambda ()");
		assertExpressionValue("        (add (call-with-current-continuation");
		assertExpressionValue("               (lambda (c0)");
		assertExpressionValue("                 (set! c c0)");
		assertExpressionValue("                 'talk1))))");
		assertExpressionValue("      (lambda () (add 'disconnect)))");
		assertExpressionValue("    (if (< (length path) 4)");
		assertExpressionValue("        (c 'talk2)");
		assertExpressionValue("        (reverse path))))");
		assertExpressionValue("    \lev (connect talk1 disconnect");
		assertExpressionValue("               connect talk2 disconnect)%");
		assertExpressionValue("(call-with-current-continuation");
		assertExpressionValue(" (lambda (k)");
		assertExpressionValue("  (with-exception-handler");
		assertExpressionValue("   (lambda (x)");
		assertExpressionValue("    (display "condition: ")");
		assertExpressionValue("    (write x)");
		assertExpressionValue("    (newline)");
		assertExpressionValue("    (k 'exception))");
		assertExpressionValue("   (lambda ()");
		assertExpressionValue("    (+ 1 (raise 'an-error))))))","exception");
		assertExpressionValue(" \>{\em and prints}  condition: an-error");
		assertExpressionValue("");
		assertExpressionValue("(with-exception-handler");
		assertExpressionValue(" (lambda (x)");
		assertExpressionValue("  (display "something went wrong\backwhack{}n"))");
		assertExpressionValue(" (lambda ()");
		assertExpressionValue("  (+ 1 (raise 'an-error))))");
		assertExpressionValue(" \>{\em prints}  something went wrong%");
		assertExpressionValue("(with-exception-handler");
		assertExpressionValue("  (lambda (con)");
		assertExpressionValue("    (cond");
		assertExpressionValue("      ((string? con)");
		assertExpressionValue("       (display con))");
		assertExpressionValue("      (else");
		assertExpressionValue("       (display "a warning has been issued")))");
		assertExpressionValue("    42)");
		assertExpressionValue("  (lambda ()");
		assertExpressionValue("    (+ (raise-continuable "should be a number")");
		assertExpressionValue("       23)))");
		assertExpressionValue("   {\it prints:} should be a number","65%");
		assertExpressionValue("(define (null-list? l)");
		assertExpressionValue("  (cond ((pair? l) \#f)");
		assertExpressionValue("        ((null? l) \#t)");
		assertExpressionValue("        (else");
		assertExpressionValue("          (error");
		assertExpressionValue("            "null-list?: argument out of domain"");
		assertExpressionValue("            l))))%");
		assertExpressionValue("(eval '(* 7 3) (environment '(scheme base)))","21");
		assertExpressionValue("");
		assertExpressionValue("(let ((f (eval '(lambda (f x) (f x x))");
		assertExpressionValue("               (null-environment 5))))");
		assertExpressionValue("  (f + 10))","20");
		assertExpressionValue("(eval '(define foo 32)");
		assertExpressionValue("      (environment '(scheme base)))","{\it{} error is signaled}%");
		assertExpressionValue("(parameterize");
		assertExpressionValue("    ((current-output-port");
		assertExpressionValue("      (open-output-string)))");
		assertExpressionValue("    (display "piece")");
		assertExpressionValue("    (display " by piece ")");
		assertExpressionValue("    (display "by piece.")");
		assertExpressionValue("    (newline)");
		assertExpressionValue("    (get-output-string (current-output-port)))");
		assertExpressionValue("\lev "piece by piece by piece.\backwhack{}n"%");
		assertExpressionValue("(get-environment-variable "PATH") \lev "/usr/local/bin:/usr/bin:/bin"%");
		assertExpressionValue("(get-environment-variables) \lev (("USER" . "root") ("HOME" . "/"))%");
		assertExpressionValue("");
		assertExpressionValue("(features)","(r7rs ratios exact-complex full-unicode");
		assertExpressionValue("   gnu-linux little-endian ");
		assertExpressionValue("   fantastic-scheme");
		assertExpressionValue("   fantastic-scheme-1.0");
		assertExpressionValue("   space-ship-control-system)"%);