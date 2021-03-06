;;
;; Copyright 2012 Genworks International and the Delft University of
;; Technology
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




(define-object single-box (base-object)
  :computed-slots
  ((length 10)
   (width 16.18)
   (height 3.2))
  
  :objects
  ((box :type 'box
        :length (the length)
        :width (the width)
        :height (the height))))


(define-object single-box-trickle (base-object)
  :computed-slots
  ((length 10)
   (width 16.18)
   (height 3.2))
  
  :objects
  ((box :type 'box)))

(define-object five-boxes (base-object)
  
  :computed-slots
  ((length 9)
   (width 4)
   (height 1)
   (display-controls (list :line-thickness 2))
   (box-width 1)
   (box-length 1)
   (box-height 1))

  
  :objects
  ((middle :type 'box
           :length (the box-length)
           :width (the box-width)
           :height (the box-height))
   
   (right-rear  :type 'box
                :length (the box-length) 
                :width (the box-width)
                :height (the box-height)
                :display-controls (append (the display-controls)
                                          (list :color :green-forest))
                :center (translate (the center)
                                   :right (half (the width))
                                   :rear (half (the length))))
   (right-front :type 'box
                :length (the box-length) 
                :width (the box-width) 
                :height (the box-height)
                :display-controls (append (the display-controls)
                                          (list :color :green-lime))
                :center (translate (the center)
                                   :right (half (the width))
                                   :front (half (the length))))
   
   (left-rear  :type 'box
               :display-controls (append (the display-controls)
                                         (list :color :red-orange))
               :length (the box-length) 
               :width (the box-width) 
               :height (the box-height)
               :center (translate (the center)
                                  :left (half (the width))
                                  :rear (half (the length))))
   
   (left-front  :type 'box
                :display-controls (append (the display-controls)
                                          (list :color :scarlet))
                :length (the box-length) 
                :width (the box-width) 
                :height (the box-height)
                :center (translate (the center)
                                   :left (half (the width))
                                   :front (half (the length))))))


(define-object tilted-monolith (base-object)
  :input-slots
  ((length 9)
   (width 4)
   (height 1))
  
  :objects
  ((monolith :type 'box)
   
   (tilted :type 'box
           :display-controls (list :color :red :line-thickness 2)
           :orientation (alignment :top
                                   (rotate-vector-d 
                                    (the (face-normal-vector :top))
                                    45
                                    (the (face-normal-vector :rear)))
                                   :rear
                                   (the (face-normal-vector :rear))))))

    
(define-object cylinder-sample (cylinder)
   :computed-slots
   ((display-controls (list :line-thickness 2 :color :pink-spicy))
    (length 10)
    (radius 3)
    (number-of-sections 25)))


(define-object cone-sample (cone)
    :computed-slots
    ((display-controls (list :line-thickness 2
                             :color :blue-neon :transparency 0.5 
			     :shininess 0.8 :specular-color :white))
     (length 10)
     (radius-1 2)
     (inner-radius-1 1)
     (radius-2 5)
     (number-of-sections 5)
     (inner-radius-2 3)))

(define-object sphere-sample (sphere)
    :computed-slots
    ((radius 150)
     (number-of-vertical-sections 10)
     (number-of-horizontal-sections 10)
     (display-controls (list :line-thickness 2
                             :color :green-forest-medium))))


(define-object spherical-cap-sample (spherical-cap)
   :computed-slots
   ((base-radius 150)
    (cap-thickness 7)
    (axis-length (* (the base-radius) +phi+))
    (number-of-vertical-sections 10)
    (number-of-horizontal-sections 10)
    (display-controls (list :line-thickness 2
                            :color :orchid-medium :transparency 0.5))))

(define-object torus-sample (torus)
    :computed-slots
    ((major-radius 150)
     (minor-radius 42)
     (draw-centerline-arc? t)
     (number-of-longitudinal-sections 10)
     (number-of-transverse-sections 10)
     (display-controls (list :line-thickness 2
                             :color :green-forest-medium))))

(define-object global-filleted-polygon-projection-sample 
    (global-filleted-polygon-projection)
    :computed-slots
    ((display-controls (list :line-thickness 2
                             :color :blue-steel :transparency 0.3 
                             :shininess 0.7 :spectral-color :white))
     (default-radius 5)
     (projection-depth 5)
     (vertex-list (list (make-point 0 0 0)
                        (make-point 10 10 0)
                        (make-point 30 10 0)
                        (make-point 40 0 0)
                        (make-point 30 -10 0)
                        (make-point 10 -10 0)
                        (make-point 0 0 0)))))


(define-object simple-curve (base-object)
  :input-slots ((control-points (list (make-point -2 0 0)
                                      (make-point -1 1 0)
                                      (make-point 1 1 0)
                                      (make-point 2 0 0))))
  
  :objects ((curve :type 'b-spline-curve
                   :control-points (the control-points))
            
            (points :type 'points-display
                    :points (the control-points))))



(define-object simple-curve-set (base-object)
  :input-slots ((control-points (list (make-point -2 0 0)
                                      (make-point -1 1 0)
                                      (make-point 1 1 0)
                                      (make-point 2 0 0))))
  
  :objects ((curves :type 'b-spline-curve
                    :sequence (:size 6)
                    :degree (1+ (the-child index))
                    :control-points (the control-points))
            
            
            (points :type 'points-display
                    :points (the control-points))))


(define-object simple-surface (base-object)
  :input-slots ((control-points 
                 (list 
                  (list (make-point -2 0 -2)
                        (make-point -1 1 -2)
                        (make-point 1 1 -2)
                        (make-point 2 0 -2))
                  (list (make-point -2 0 -1)
                        (make-point -1 2 -1)
                        (make-point 1 2 -1)
                        (make-point 2 0 -1))
                  (list (make-point -2 0 1)
                        (make-point -1 2 1)
                        (make-point 1 2 1)
                        (make-point 2 0 1))
                  (list (make-point -2 0 2)
                        (make-point -1 1 2)
                        (make-point 1 1 2)
                        (make-point 2 0 2)))))
  
  :objects ((surface :type 'b-spline-surface
                     :display-controls (list :color :blue
                                             :line-thickness 2
                                             :bezier-points t)
                     :control-points (the control-points))))

(define-object simple-surface-set (base-object)
  :input-slots ((control-points 
                 (list 
                  (list (make-point -2 0 -2)
                        (make-point -1 1 -2)
                        (make-point 1 1 -2)
                        (make-point 2 0 -2))
                  (list (make-point -2 0 -1)
                        (make-point -1 2 -1)
                        (make-point 1 2 -1)
                        (make-point 2 0 -1))
                  (list (make-point -2 0 1)
                        (make-point -1 2 1)
                        (make-point 1 2 1)
                        (make-point 2 0 1))
                  (list (make-point -2 0 2)
                        (make-point -1 1 2)
                        (make-point 1 1 2)
                        (make-point 2 0 2)))))
  
  :objects ((surfaces :type 'b-spline-surface
                      :sequence (:size 6)
                      :u-degree (1+ (the-child index))
                      :display-controls (list :color :blue
                                              :line-thickness 2
                                              :bezier-points t)
                      :control-points (the control-points))))


(define-object boxed-curves-example (base-object)
  
  :objects
  ((wavy :type 'b-spline-curve
         :control-points (list (make-point -2 0 0)
                               (make-point -1 1 0)
                               (make-point 1 1 0)
                               (make-point 2 0 0)
                               (make-point 3 0 00)))
         
   
   (translated :type 'boxed-curve
               :display-controls (list :color :red :line-thickness 2)
               :curve-in (the wavy)
               :center (translate (the center) :right 5))
   
   (translated-rotated :type 'boxed-curve
                       :display-controls (list :color :green :line-thickness 2)
                       :curve-in (the translated)
                       :orientation (alignment :rear 
                                               (the (face-normal-vector :left))))
   
   (mirrored :type 'boxed-curve 
             :display-controls (list :color :blue :line-thickness 2)
             :curve-in (the wavy)
             :orientation (alignment :rear (the (face-normal-vector :front))
                                     :right (the (face-normal-vector :right))
                                     :top (the (face-normal-vector :top))))
   
   (mirrored-2 :type 'boxed-curve 
               :display-controls (list :color :orange :line-thickness 2)
               :curve-in (the translated)
               :orientation (alignment :rear (the (face-normal-vector :front))
                                       :right (the (face-normal-vector :right))
                                       :top (the (face-normal-vector :top))))
               
   (mirrored-3 :type 'boxed-curve 
               :display-controls (list :color :pink :line-thickness 2)
               :curve-in (the translated-rotated)
               :from-orientation (the orientation)
               :orientation (alignment :rear (the (face-normal-vector :rear))
                                       :right (the (face-normal-vector :left))
                                       :top (the (face-normal-vector :top))))))

(define-object box-cone-unite (base-object)
  :hidden-objects
  ((cone :type 'cone-solid
         :length 100
         :radius-1 5
         :radius-2 20)
   
   (box :type 'box-solid
        :length 50
        :width 50
        :height 50))
  
  :objects
  ((united :type 'united-solid
           :display-controls (list :line-thickness 2 :color :red)
           :brep (the box)
           :other-brep (the cone))))

(define-object box-cone-subtract (base-object)
  :hidden-objects
  ((cone :type 'cone-solid
         :length 100
         :radius-1 5
         :radius-2 20)
   
   (box :type 'box-solid
        :length 50
        :width 50
        :height 50))
  
  :objects
  ((subtracted :type 'subtracted-solid
               :display-controls (list :line-thickness 2 :color :green
                                       :transparency 0.3)
               :brep (the box)
               :other-brep (the cone))))

(define-object box-cone-intersect (base-object)
  :hidden-objects
  ((cone :type 'cone-solid
         :length 100
         :radius-1 5
         :radius-2 20)
   
   (box :type 'box-solid
        :length 50
        :width 50
        :height 50))
  
  :objects
  ((intersect :type 'intersected-solid
              :display-controls (list :line-thickness 2 :color :blue)
              :brep (the box)
              :other-brep (the cone))))



(define-object airfoil (base-object)
  
  :input-slots ((control-points
                 '(#(0.0 0.0 0.05) 
                   #(9.5 0.0 2.0) 
                   #(17.0 0.0 2.0) 
                   #(22.0 0.0 0.0) 
                   #(17.0 0.0 -2.0)
                   #(9.5 0.0 -2.0) 
                   #(0.0 0.0 -0.05)))
                (number-of-profiles 5)
                (span 108))
  
  :computed-slots ((profile-spacing (/ (the span)
                                       (1- (the number-of-profiles)))))
  
  :hidden-objects ((profile-curves :type 'boxed-curve
                                   :sequence (:size (the number-of-profiles))
                                   :curve-in (the profile)
                                   :center (translate (the center)
                                                      :rear
                                                      (* (the-child index)
                                                         (the profile-spacing))))
                   
                   (bspline :type 'b-spline-curve
                            :control-points (the control-points))
                   
                   (trailing-edge-line :type 'linear-curve
                                       :start (the bspline start)
                                       :end (the bspline end))
                   
                   (profile :type 'composed-curve
                            :curves (list (the bspline) (the trailing-edge-line))))
  
  :objects ((loft :type 'lofted-surface
                  :synchronized? t
                  :curves (list-elements (the profile-curves)))))


(define-object merged-airfoil (base-object)
  
  :input-slots ((span 108))
  
  :computed-slots
  ((chord (3d-distance (the airfoil (profile-curves 0) (point 0.5))
                       (the airfoil (profile-curves 0) start))))
  
  :hidden-objects
  ((airfoil :type 'airfoil
            :span (the span))

   (ends :type 'rectangular-surface
         :sequence (:size 2)
         :width (* (the chord) 2.5)
         :length (the-child width)
         :center (ecase (the-child index)
                   (0 (translate (the airfoil profile-curves first start)
                                 :rear
                                 (* (the airfoil span) 0.05)))
                   (1 (translate (the airfoil profile-curves last start)
                                 :front
                                 (* (the airfoil span) 0.05))))
         :orientation (alignment :top (the (face-normal-vector :rear))))
   
   (spar :type 'rectangular-surface
         :center (translate (midpoint (the airfoil (profile-curves 0) start)
                                      (the airfoil (profile-curves 0) (point 0.5)))
                            :rear (half (the airfoil span)))
         :orientation (alignment :top (the (face-normal-vector :right))
                                 :rear (the (face-normal-vector :top)))
         :length (* (the chord) 1.2)
         :width (* (the airfoil span) 1.2)))
  
  :objects
  ((merged :type 'merged-solid
           :brep (the airfoil loft)
	   :make-manifold? t
           :other-brep (cons (the spar)
                             (list-elements (the ends))))))

(define-object regioned-airfoil (base-object)

  :input-slots ((span 108))
  
  :hidden-objects
  ((merged :type 'merged-airfoil
           :span (the span)))

  
  :objects
  ((regioned :type 'regioned-solid
             :display-controls (list :line-thickness 2)
             :brep (the merged merged))))
                           



(in-package :gwl-user)


;;
;; This macro, with-htm, is being added to core GDL in the GWL package. 
;;
(eval-when (:compile-toplevel :load-toplevel :execute)
  (unless (fboundp 'with-htm)
    (defmacro with-htm (&body body)
      `(gwl:with-cl-who-string () ,@body))))

(define-object wing-surface-and-volume (base-ajax-sheet)

  :computed-slots
  ((main-sheet-body 
    (with-htm
      (when *developing?* (str (the development-links)))
      (:h2 "Wing Area and Tank Volume")
      ((:table :border 1)
       (:tr
        (:th "Area")
        (:td (fmt "~3,3f" (the regioned-airfoil regioned brep area)))
        (dolist (region (list-elements (the regioned-airfoil regioned breps)))
          (htm (:tr 
                (:th (fmt "Region ~a Volume" (the-object region index)))
                (:td (fmt "~3,3f" (the-object region volume)))))))))))
  
  :objects
  ((regioned-airfoil :type 'regioned-airfoil)))


(define-object wing-surface-and-volume-ajax (base-ajax-sheet)

  :input-slots ((span-default 108))
  
  :computed-slots
  ((main-sheet-body 
    (with-htm
      (when *developing?* (str (the development-links)))
      (:center (:h2 "Wing Area and Tank Volume"))
      (str (the input-section main-div))
      (str (the report-section main-div)))))
  
  :objects
  ((regioned-airfoil :type 'regioned-airfoil
                     :span (the span value))
   
   (span :type 'text-form-control
         :domain :number
         :default (the span-default)
         :prompt "Wing Span"
         :ajax-submit-on-change? t)
   
   (input-section :type 'sheet-section
                  :inner-html (with-htm
                               (:p (str (the span html-string)))))
   
   (report-section 
    :type 'sheet-section
    :inner-html (with-htm
                 ((:table :border 1)
                  (:tr
                   (:th "Area")
                   (:td (fmt "~3,3f" (the regioned-airfoil regioned brep area)))
                   (dolist (region (list-elements 
				    (the regioned-airfoil regioned breps)))
                     (htm (:tr 
                           (:th (fmt "Region ~a Volume" (the-object region index)))
                           (:td (fmt "~3,3f" (the-object region volume))))))))))))

(define-object wing-with-graphics 
    (wing-surface-and-volume-ajax)
  :computed-slots 
  ((use-raphael? t)
   
   (main-sheet-body 
    (with-htm
      (when *developing?* (str (the development-links)))
      (when (and (the parent)
                 (typep (the parent) 'several-wings))
        (htm ((:a :href (the parent url))
              "Back to Spans")))
      (:h2 "Wing Area and Tank Volume")
      (:table
       (:tr (:td (str (the input-section main-div)))
            (:td (str (the report-section main-div)))))
      
      (:table
       (:tr
        (:td (str (the merged-viewport main-div)))        
        (:td (str (the regioned-viewport main-div))))))))
  
  :objects
  ((merged-viewport :type 'base-ajax-graphics-sheet
                    :image-format-default :png
                    :view-direction-default :trimetric
                    :display-list-objects 
		    (list (the regioned-airfoil merged merged))
                    :length 300 :width 300)
   
   (regioned-viewport :type 'base-ajax-graphics-sheet
                      :view-direction-default :trimetric
                      :image-format-default :png
                      :display-list-objects 
		      (list-elements 
		       (the regioned-airfoil regioned breps))
                      :length 300 :width 300)))


(define-object several-wings (base-ajax-sheet)
  
  :input-slots
  ((span-defaults (list 98 108 118)))

  :computed-slots
  ((main-sheet-body 
    (with-htm
      (:h2 "Wing Areas and Tank Volumes for several Wings")
      (:ul
       (dolist (wing (list-elements (the wings)))
         (htm
          (:li
           ((:a :href (the-object wing url))
                (fmt "Wing with default span of ~a" 
		     (the-object wing span-default))))))))))
  
  :objects 
  ((wings :type 'wing-with-graphics
          :sequence (:size (length (the span-defaults)))
          :span-default (nth (the-child index) (the span-defaults)))))


(define-object wing-drawing (base-drawing)
  
  :input-slots ((page-length (getf (getf *paper-size-plist* :a4) :height))
                (page-width (getf (getf *paper-size-plist* :a4) :width)))

  :objects 
  ((regioned-airfoil :type 'regioned-airfoil))
  
  :hidden-objects
  ((merged-view :type 'base-view
                :border-box? t
                :width (half (the width))
                :length (half (the length))
                :center (translate (the (vertex :top :right :rear))
                                   :left (half (the-child width))
                                   :front (half (the-child length)))
                :projection-vector (getf *standard-views* :trimetric)
                :objects (list (the regioned-airfoil merged merged)))
   
   (top-view :type 'base-view
             :border-box? t
             :width (half (the width))
             :length (half (the length))
             :center
             (translate (the (vertex :top :left :front))
                        :right (half (the-child width))
                        :rear (half (the-child length)))
             :projection-vector (getf *standard-views* :top)
             :objects (list-elements (the regioned-airfoil regioned breps)))
  
   (tri-view :type 'base-view
             :border-box? t
             :width (half (the width))
             :length (half (the length))
             :center (translate (the (vertex :top :right :front))
                                :left (half (the-child width))
                                :rear (half (the-child length)))
             :projection-vector (getf *standard-views* :trimetric)
             :objects (list-elements (the regioned-airfoil regioned breps)))))


(define-object wing-drawing-with-dimension (wing-drawing)

  :objects
  ((span-dimension :type 'vertical-dimension 
                   :start-point (the regioned-airfoil regioned
                                     (breps 0)
                                     bounding-bbox (vertex :top :left :front))
                   :end-point (the regioned-airfoil regioned
                                   (breps 0)
                                   bounding-bbox (vertex :top :left :rear))
                   :flip-leaders? t
                   :character-size 1.5)

  
   (top-view :type 'base-view 
             :objects (cons (the span-dimension)
                            (list-elements 
			     (the regioned-airfoil regioned breps))))))


(define-object wing-drawing-with-typeset-block (wing-drawing-with-dimension)
  :objects
  ((text :type 'wing-drawing-typeset-block
         :regioned (the regioned-airfoil regioned))
   
   (text-view :type 'base-view
              :objects (list (the text))

              :length (half (the length))
              :width (half (the width))
              :center (translate (the (vertex :top :left :rear))
                                 :right (half (the-child width))
                                 :front (half (the-child length))))))


(define-object wing-drawing-typeset-block (typeset-block)
  :input-slots (regioned)
  
  :functions ((content 
               ()
               (typeset:compile-text 
                ()
                (typeset:vspace 5)
                (typeset:table 
                 (:col-widths (list 180 175) )
                 (typeset:row ()
                              (typeset:cell ()
                                            (typeset:paragraph 
                                             (:font "Courier" :font-size 25)
                                             (typeset:put-string "Area")))
                              (typeset:cell ()
                                            (typeset:paragraph 
                                             (:font "Courier" :font-size 25)
                                             (typeset:put-string 
                                              (format nil "~5,3f" 
                                                      (the regioned brep area))))))
                 (dolist (region (list-elements (the regioned breps)))
                   (typeset:row 
                    ()
                    (typeset:cell
                     ()
                     (typeset:paragraph
                      (:font "Courier" :font-size 25)
                      (typeset:put-string (format nil "Region ~a Volume"
                                                  (the-object region index)))))
                    (typeset:cell
                     ()
                     (typeset:paragraph
                      (:font "Courier" :font-size 25)
                      (typeset:put-string 
		       (format nil "~3,3f"
			       (the-object region volume))))))))))))


(define-object wing-drawing-with-output (wing-drawing-with-typeset-block)

  :functions
  ((pdf-out!
    ()
    (let ((output-path (merge-pathnames "wing.pdf" (user-homedir-pathname))))
      (with-format (pdf output-path 
                        :page-length (the page-length)
                        :page-width (the page-width))
        (write-the cad-output))
      output-path))
   
   (png-out!
    ()
    (let ((output-path (merge-pathnames "wing.png" (user-homedir-pathname))))
      (with-format (png output-path 
                        :page-length (the page-length)
                        :page-width (the page-width))
        (write-the cad-output))
      output-path))))



(define-object wing-with-restore (wing-with-graphics)

  :objects
  ((restore-button :type 'button-form-control
                   :label "Restore!"
                   :onclick (the (gdl-ajax-call :function-key :restore-defaults!
                                                :bashee (the span))))
   (input-section :type 'sheet-section
                  :inner-html (with-htm
                               (:p (str (the restore-button html-string)))
                               (:p (str (the span html-string)))))
   ))


(define-object wing-with-iges-download (wing-with-graphics)

  :computed-slots
  ((pdf-url (let ((url (glisp:replace-regexp
			(the url)  
			"index\\.html" "wing-drawing.pdf")))
              (publish :path url
                       :function 
		       #'(lambda(req ent)
			   (with-http-response (req ent)
			     (with-http-body (req ent)
			       (with-format (pdf (request-reply-stream req))
				 (write-the drawing cad-output))))))
              url))
   
   (iges-url (let ((url (glisp:replace-regexp 
			 (the url)  
			 "index\\.html" "wing-regions.iges")))
               (publish :path url
                        :function 
                        #'(lambda(req ent)
                            (with-http-response (req ent)
                              (with-http-body (req ent)
                                (with-format (iges (request-reply-stream req))
                                  (write-the regioned-airfoil cad-output-tree))))))
               url))
   
   (main-sheet-body 
    (with-htm
      (when *developing?* (str (the development-links)))
      (when (and (the parent)
                 (typep (the parent) 'several-wings))
        (htm ((:a :href (the parent url))
              "Back to Spans")))
      (:h2 "Wing Area and Tank Volume")
      (:table
       (:tr (:td (str (the input-section main-div)))
            (:td (str (the report-section main-div)))))
      
      (:p ((:a :href (the pdf-url)) "Download PDF File"))
      (:p ((:a :href (the iges-url)) "Download Iges File"))
      
      (:table
       (:tr
        (:td (str (the merged-viewport main-div)))        
        (:td (str (the regioned-viewport main-div))))))))
  
  :objects
  ((drawing :type 'wing-drawing-with-input-airfoil
            :regioned-airfoil (the regioned-airfoil))))


(define-object wing-drawing-with-input-airfoil (wing-drawing-with-typeset-block)
  :input-slots (regioned-airfoil))




(define-object wing-with-submit (wing-with-graphics)

  :objects
  ((span :type 'text-form-control
         :domain :number
         :default (the span-default)
         :prompt "Wing Span"
         :ajax-submit-on-change? nil)
   
   (restore-button :type 'button-form-control
                   :label "Restore!"
                   :onclick (the (gdl-ajax-call :function-key :restore-defaults!
                                                :bashee (the span))))

   (submit-button :type 'button-form-control
                  :label "Submit"
                  :onclick (the (gdl-ajax-call :form-controls (list (the span)))))
   
   (input-section :type 'sheet-section
                  :inner-html (with-htm
                               (:p (str (the span html-string)))
                               (:p (str (the submit-button html-string)))
                               (:p (str (the restore-button html-string)))))
   
   ))


(define-object wing-with-iges-and-step (base-object)
  
  :objects
  ((regioned-airfoil :type 'regioned-airfoil))
  
  :functions
  ((iges-out!
    ()
    (with-format (iges (merge-pathnames "wing-regions.iges" 
					(user-homedir-pathname)))
      (write-the regioned-airfoil regioned cad-output-tree)))
   
   (step-out!
    ()
    (with-format (step (merge-pathnames "wing-regions.step" 
					(user-homedir-pathname)))
      (dolist (brep (list-elements (the regioned-airfoil regioned breps)))
        (write-the-object brep cad-output))))
   
   (native-out!
    ()
    (with-format (native (merge-pathnames "wing-regions.iwp" 
					  (user-homedir-pathname)))
      (write-the regioned-airfoil regioned cad-output-tree)))))


(define-object wing-readers (base-object)
  :input-slots ((base-path (merge-pathnames "wing-regions" 
					    (user-homedir-pathname))))
  
  :objects
  ((iges-reader :type 'iges-reader 
                :file-name (make-pathname :type "iges"
                                          :defaults (the base-path)))
   
   (step-reader :type 'step-reader
                :file-name (make-pathname :type "step"
                                          :defaults (the base-path)))
   
   (native-reader :type 'native-reader
                  :file-name (make-pathname :type "iwp"
                                            :defaults (the base-path)))))



(define-object merged-3rds (base-object)
  
  :computed-slots
  ((chord (3d-distance (the airfoil (profile-curves 0) (point 0.5))
                       (the airfoil (profile-curves 0) start))))
  
  :hidden-objects
  ((airfoil :type 'airfoil)

   (ends :type 'rectangular-surface
         :sequence (:size 2)
         :width (* (the chord) 2.5)
         :length (the-child width)
         :center (ecase (the-child index)
                   (0 (translate (the airfoil profile-curves first start)
                                 :rear
                                 (* (the airfoil span) 0.05)))
                   (1 (translate (the airfoil profile-curves last start)
                                 :front
                                 (* (the airfoil span) 0.05))))
         :orientation (alignment :top (the (face-normal-vector :rear))))
   
   (spar :type 'rectangular-surface
         :sequence (:size 2)
         :center (translate (midpoint (the airfoil (profile-curves 0) start)
                                      (the airfoil (profile-curves 0) (point 0.5)))
                            :rear (half (the airfoil span))
                            :left (ecase (the-child index)
                                    (0  (* 1/6 (the chord)))
                                    (1  (- (* 1/6 (the chord))))))
         :orientation (alignment :top (the (face-normal-vector :right))
                                 :rear (the (face-normal-vector :top)))
         :length (* (the chord) 1.2)
         :width (* (the airfoil span) 1.2)))
  
  :objects
  ((merged :type 'merged-solid
           :brep (the airfoil loft)
           :other-brep (append (list-elements (the spar))
                               (list-elements (the ends))))))




(define-object regioned-3rds (base-object)
  
  :objects
  ((merged :type 'merged-3rds))
  
  :objects
  ((regioned :type 'regioned-solid
             :display-controls (list :line-thickness 2)
             :brep (the merged merged))))












