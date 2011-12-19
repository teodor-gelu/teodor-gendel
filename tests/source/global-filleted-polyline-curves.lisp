;;
;; Copyright 2002, 2009 Genworks International and Genworks BV 
;;
;; This source file is part of the General-purpose Declarative
;; Language project (GDL).
;;
;; This source file contains free software: you can redistribute it
;; and/or modify it under the terms of the GNU Affero General Public
;; License as published by the Free Software Foundation, either
;; version 3 of the License, or (at your option) any later version.
;; 
;; This source file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; Affero General Public License for more details.
;; 
;; You should have received a copy of the GNU Affero General Public
;; License along with this source file.  If not, see
;; <http://www.gnu.org/licenses/>.
;; 


(in-package :gdl-lift-tests)

(define-object global-filleted-polyline-curves-test (global-filleted-polyline-curves)
		    
  :computed-slots
  ((default-radius 5)
   (vertex-list (list (make-point 0 0 0)
		      (make-point 10 10 0)
		      (make-point 30 10 0)
		      (make-point 40 0 0)
		      (make-point 30 -10 0)
		      (make-point 10 -10 0)
		      (make-point 0 0 0)))
   
   (regression-test-data (list (mapcar #'(lambda (curve)
					   (multiple-value-list (the-object curve b-spline-data)))
				       (the ordered-curves))))))


(register-test-definition 'global-filleted-polyline-curves-test)


(define-object global-filleted-polyline-curve-test (global-filleted-polyline-curve)
  :computed-slots
  ((default-radius 5)
   (vertex-list (list (make-point 0 0 0)
		      (make-point 10 10 0)
		      (make-point 30 10 0)
		      (make-point 40 0 0)
		      (make-point 30 -10 0)
		      (make-point 10 -10 0)
		      (make-point 0 0 0)))
   
   (regression-test-data (mapcar #'(lambda (curve)
				     (multiple-value-list (the-object curve b-spline-data)))
				 (the ordered-curves)))))

(register-test-definition 'global-filleted-polyline-curve-test)


(define-object global-filleted-polyline-curve-open-test (global-filleted-polyline-curve)

  :computed-slots
  ((default-radius 5)
   (vertex-list (list (make-point 0 0 0)
		      (make-point 10 10 0)
		      (make-point 30 10 0)
		      (make-point 40 0 0)
		      (make-point 60 0 0)
		      (make-point 70 10 0)
		      
		      ))
   
   (regression-test-data (multiple-value-list (the b-spline-data)))))

