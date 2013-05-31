<!doctype style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN">
<!-- Copyright (C) 1999 Avi Kivity -->

<!--
   
This stylesheet provides procedures for handling sgml transformations
using OpenJade's sgml backend. All procedures assume that osnl refers
to a node of class element.

  (empty-element? osnl)
  Returns #f if the element has a declared content model of EMPTY.

  (element-attributes osnl)
  Returns a list of the non-implied attributes of osnl, in the same
  foramt accepted by the attributes: characteristic of the element
  flow object.
  
  (copy-element osnl)
  Returns a sosofo that is the identity transformation of osnl. Bug:
  Defaulted attributes are made explicit. Fix with prlgabs1?

-->


<style-specification id=transform>

(declare-flow-object-class element
    "UNREGISTERED::James Clark//Flow Object Class::element")
(declare-flow-object-class empty-element
    "UNREGISTERED::James Clark//Flow Object Class::empty-element")
(declare-flow-object-class document-type
    "UNREGISTERED::James Clark//Flow Object Class::document-type")
(declare-flow-object-class entity
    "UNREGISTERED::James Clark//Flow Object Class::entity")
(declare-flow-object-class entity-ref
    "UNREGISTERED::James Clark//Flow Object Class::entity-ref")
(declare-flow-object-class formatting-instruction
    "UNREGISTERED::James Clark//Flow Object Class::formatting-instruction")
(declare-characteristic preserve-sdata?
    "UNREGISTERED::James Clark//Characteristic::preserve-sdata?" #f)

(define (empty-element? #!optional (nd (current-node)))
    (node-property 'must-omit-end-tag? nd)
)

(define (element-attributes #!optional (nd (current-node)))
    (let loop ((atts (named-node-list-names (attributes nd))))
        (if (null? atts)
            '()
            (let*
                (
                    (name (car atts))
                    (value (attribute-string name nd))
                )
                (if value
                    (cons (list name value) (loop (cdr atts)))
                    (loop (cdr atts))
                )
            )
        )
    )
)

(define (copy-element #!optional (node (current-node)))
    (if (empty-element? node)
        (make empty-element  attributes: (element-attributes node))
        (make element        attributes: (element-attributes node))
    )
)

(mode identity-transform
    (default (copy-element))        
)
