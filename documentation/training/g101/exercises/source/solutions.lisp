;;
;; Copyright 2002-2011, 2012 Genworks International
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

(in-package :gdl-user)

;;
;; Exercises from Slide 3.14
;;

(defun dots (number)
  "Write an iterative version of a function 
which takes a number and prints that many dots.

Example call:

  (dots 3) 

 --> ...

"
  (dotimes (n number) (princ ".")))


(defun dots-r (number)
  "Write a recursive version of a function 
which takes a number and prints that many dots.


Example call:

  (dots 3) 

 --> ...


"
  (when (plusp number)
    (princ ".")
    (dots-r (1- number))))


(defun nth-rest (n list)
  "Write a recursive function which returns the result of applying 
rest n times to list (equivalent to the Lisp function nthcdr).

Example call:

     (nth-rest 2 '(a b c d e f))
 --> (c d e f)

"
  (if (zerop n)
      list
    (nth-rest (1- n) (rest list))))


(defun our-nth (n list)
  "Write a recursive function which returns the nth element of 
a list (equivalent to the Lisp function nth).

Example call:

     (our-nth 2 '(a b c d e f))
 --> c

"
  (first (nth-rest n list)))


(defun our-getf (plist keyword)
  "Write a recursive function our-getf plist keyword, 
which behaves as getf

Example call:

     (our-getf '(:germany :berlin :england :london :finland :helsinki  
		 :norway :oslo :france :paris) :finland) 
 --> :helsinki

"
  (when plist
    (if (eql (first plist) keyword)
	(second plist)
      (our-getf (rest (rest plist)) keyword))))


;;
;; Bonus exercises from Slide 3.14
;;

(defun filter-in (function list)
  "Write a function which takes a function object and a list, 
and returns a new list containing all elements of the list for 
which the function returns non-nil (equivalent to the CL function 
remove-if-not).

Example call: 

     (filter-in #'listp '(hello (how are you) well (i am okay) but (a bit tired)) 
 --> ((how are you)(i am okay)(a bit tired))

"
  (let ((result nil))
    (dolist (element list (reverse result))
      (when (funcall function element)
	(push element result)))))


(defun position-filter (function list)
  "Write a function which takes a function and a list, 
and returns a new list containing all elements from list for which the 
function returns true when applied to that element's (zero-indexed) 
position in the list.

Example call:

     (position-filter #'oddp '(a b c d e f))
 --> (b d f)

"
  (let ((result nil) 
	(count 0))
    (dolist (element list (reverse result))
      (when (funcall function count)
	(push element result))
      (incf count))))


(defun set-difference-o (list1 list2)
  "Write a function which works just like set-difference, 
except it retains the ordering of elements in the first list.

Example call: 

     (set-difference-o '(a b c d e f) '(e d b))
 --> (a c f)

"
  (let ((result nil))
    (dolist (element list1 (reverse result))
      (unless (member element list2)
	(push element result)))))



(defun intersection-o (list1 list2)
  "Write a function which works just like intersection, 
except it retains the ordering of elements in the first list.

Example call: 

    (intersection-o '(a b c d e f) '(e d b))
--> (b d e)

"
  (let ((result nil))
    (dolist (element list1 (reverse result))
      (when (member element list2)
	(push element result)))))



(defparameter *test-cases*
    `((nth-rest (2 (a b c d e f)) (c d e f))
      (our-nth (2 (a b c d e f)) c)
      (our-getf ((:germany :berlin :england :london :finland :helsinki  
		  :norway :oslo :france :paris) :finland) :helsinki)
      (filter-in (,#'listp (hello (how are you) well (i am okay) but (a bit tired))) 
       ((how are you)(i am okay)(a bit tired)))
      (position-filter (,#'oddp (a b c d e f)) (b d f))
      (position-filter (,#'evenp (:germany :berlin :england :london :finland :helsinki
				 :norway :oslo :france :paris))
       (:germany :england :finland :norway :france))
      (set-difference-o ((a b c d e f) (e d b)) (a c f))
      (intersection-o ((a b c d e f) (e d b)) (b d e))))

(defun run-tests ()
  (dolist (test-case *test-cases*)
    (let ((result (apply (symbol-function (first test-case))
			 (second test-case))))
      (if (equalp result (third test-case))
	  (format t "~%Function `~s' passed on ~s~%" (first test-case) (second test-case))
	(format t "~%!!!Function `~s' failed on ~s~% -- returned ~s when ~s was expected.~%~%" 
		(first test-case) (second test-case) result (third test-case))))))
	
       
       
    
