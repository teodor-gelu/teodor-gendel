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

(in-package :genworks.demos.bus)

(define-view (html-format assembly) ()
  
  :output-functions
  ((model-inputs
    nil
    (html 
     (:p
      (:table
       (:tr ((:td :bgcolor :yellow) "Wheelbase")
	    (:td
	     ((:input :type :text :size 5 :name :wheelbase :value
		      (the :wheelbase)))))
       (:tr ((:td :bgcolor :yellow) "Track")
	    (:td ((:input :type :text :size 5 
			  :name :track :value (the :track)))))
       (:tr ((:td :bgcolor :yellow) "Height")
	    (:td
	     ((:input :type :text :size 5 
		      :name :height :value (the :height)))))))
     (:p ((:input :type :submit :name :ok :value " OK ")))))))