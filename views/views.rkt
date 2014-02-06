#lang racket
(provide define-view)
(define-syntax (define-view stx)
  (syntax-case stx ()
    [(_ view-name predicate values-returning-accessor)
     #'(define-match-expander view-name
         (syntax-rules ()
           [(_ field (... ...))
            (? (λ (y) (predicate y))
               (app (λ (x) (call-with-values (thunk (values-returning-accessor x)) list))
                    (list field (... ...))))]))]
    [(_ view-name predicate accessor ...)
     (with-syntax ([(x ...) (generate-temporaries #'(accessor ...))])
       #'(define-match-expander view-name
           (syntax-rules ()
             [(_ x ...)
              (? (λ (y) (predicate y))
                 (app (λ (y) (list (accessor y) ...)) (list x ...)))])))]))
