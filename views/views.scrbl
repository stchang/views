#lang scribble/manual
@(require scribble/eval
          (for-label "views.rkt" racket/base))

@title{Views for Racket}

@(define the-eval (make-base-eval))
@(the-eval '(require "views.rkt"))

@defmodule[views]

@author[@author+email["Stephen Chang" "stchang@racket-lang.org"]]

Implements @deftech{view}s for Racket.

@defform*[((define-view view-name values-returning-accessor)
           (define-view view-name accessor ...))]{
  Defines a @tech{match expander} with the given @racket[view-name]. If multiple accessors are provided, then the @tech{view} will match exactly that many identifiers. If only one accessor is given, then it's assumed that it may return multiple values and will bind as many identifiers as values returned by the accessor. This enables a view to use a more efficient accessor that may extract multiple values at once.
}

@(bibliography
  (bib-entry #:key "wadler"
             #:author "Philip Wadler"
             #:title "Views: A way for pattern matching to cohabit with data abstraction"
             #:location "14th POPL"
             #:date "1987") 
  (bib-entry #:key "okasaki"
             #:author "Chris Okasaki"
             #:title "Views for Standard ML"
             #:location "ML Workshop"
             #:date "1998"))