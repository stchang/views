#lang racket
(require "../views.rkt")
(require rackunit)

(define-view A pair? car cdr)
(check-equal? 30 (match (cons 10 20) [(A x y) (+ 10 20)]))

(define-view B pair? car)
(check-equal? 10 (match (cons 10 20) [(B x) x]))
(check-exn exn:misc:match? (thunk (match (cons 10 20) [(B x y) x])))
(check-exn exn:misc:match? (thunk (match (vector 10 20) [(B x y) x])))

(define (car-car-cdr x) (values (car x) (car x) (cdr x)))
(define-view C pair? car-car-cdr)
(check-equal? 40 (match (cons 10 20) [(C x y z) (+ x y z)]))
(check-exn exn:misc:match? (thunk (match (cons 10 20) [(C x y) x])))
(check-exn exn:misc:match? (thunk (match (cons 10 20) [(C w x y z) x])))
(check-exn exn:misc:match? (thunk (match (vector 10 20) [(C w x y z) x])))

(define-view D pair? (λ (x) (car x)))
(check-equal? 10 (match (cons 10 20) [(D x) x]))
