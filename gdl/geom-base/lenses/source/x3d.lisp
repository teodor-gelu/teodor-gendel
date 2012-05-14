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

(in-package :geom-base)

(define-format x3d (vrml))

(define-lens (x3d base-drawing)()
  :output-functions
  ((cad-output
    ()
    (let (
          ;;(req (when (find-package :gwl) (symbol-value (read-from-string "gwl:*req*"))))
          )
      (let (;;(keep-alive? (and req (slot-value req (read-from-string "net.aserve::request-header-connection"))))
            ;;(protocol (and req (slot-value req (read-from-string "net.aserve::protocol"))))
            )
          
        ;;(when *debug?* (describe req) (print-variables self keep-alive? protocol))
          
        (write-the header)
        
        ;;
        ;; FLAG -- each view should really be in a separate X3D area or scene, but using references if possible. 
        ;;
        (cl-who:with-html-output (*stream* nil)
	   (mapc #'(lambda(key viewpoint)
		     (let ((position (getf viewpoint :point))
                          
			   (orientation (matrix-to-rotation (getf viewpoint :orientation)))
                          
			   (field-of-view (degree (getf viewpoint :field-of-view))))
                      
		       (cl-who:htm 
			((:|Viewpoint| 
			   :position (format nil "~a ~a ~a" (get-x position) (get-y position) (get-z position))
			   :orientation (format nil "~a ~a ~a ~a"
						(get-x orientation)
						(get-y orientation)
						(get-z orientation)
						(get-w orientation))
			   :|fieldOfView| field-of-view
			   :description (string-capitalize key)))

			((:|navigationinfo| :type "Examine"
			   :headlight "TRUE"
			   :speed (format nil "~a" (getf viewpoint :speed)))))))
		 (list (first (the viewpoints)))
		 (list (second  (the viewpoints))))
	   
	   (let ((background (lookup-color (the background-color))))
	     (cl-who:htm (:|Background| :|skyColor| (format nil "~a ~a ~a" 
							    (to-double-float (get-x background))
							    (to-double-float (get-y background))
							    (to-double-float (get-z background))))))
						     
        
	   (mapc #'(lambda(view)
		     (let ((object-roots (ensure-list (the-object view object-roots)))
			   (objects (ensure-list (the-object view  objects))))
                      
		       (when *debug?* (print-variables object-roots objects))
                    
		       (mapc #'(lambda(root) (write-the-object root (cad-output-tree :header? nil))) object-roots)
                    
		       (mapc #'(lambda(leaf) (write-the-object leaf (cad-output :header? nil))) objects)))

		 (the views))
	  )

        )))))

(define-lens (x3d base-object)()
  :output-functions
  (
   (header
    ()
    
    #+nil
    (format *stream* "~a~%~a~%"
            "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
            "<!DOCTYPE X3D PUBLIC \"ISO//Web3D//DTD X3D 3.1//EN\" \"http://www.web3d.org/specifications/x3d-3.1.dtd\">"))
   
   (rgb-color
    (color)
    (when color
      (let ((fcolor (coerce (lookup-color color) 'list)))
        (format nil "~,3f ~,3f ~,3f" (nth 0 fcolor) (nth 1 fcolor) (nth 2 fcolor)))))
   
   (pixel-texture
    ()
    (cl-who:with-html-output (*stream* nil :indent nil)
      (:|PixelTexture| :image (getf (the display-controls) :pixel-texture))))
   
   (line-properties
    ()
    (cl-who:with-html-output (*stream* nil :indent nil)
      (:|LineProperties| :linetype (getf (the display-controls) :linetype))))
   
   (material-properties
    ()
    (cl-who:with-html-output (*stream* nil :indent nil)
      (:|Material| :|diffuseColor| (write-the (rgb-color (if (getf (the display-controls) :color)
                                                         (getf (the display-controls) :color)
                                                       :black)))
                 :|ambientIntensity| (getf (the display-controls) :ambient-intensity)
                 :|emissiveColor| (write-the (rgb-color (getf (the display-controls) :emissive-color)))
                 :|shininess| (getf (the display-controls) :shininess)
                 :|specularColor| (write-the (rgb-color (getf (the display-controls) :specular-color)))
                 :|transparency| (getf (the display-controls) :transparency)
                 )))
   
   (appearance
    ()
    (cl-who:with-html-output (*stream* nil :indent nil)
      (write-the pixel-texture)
      (write-the material-properties)))
   
   (transform
    ()
    (let* (;;(rotation (quaternion-to-rotation (matrix-to-quaternion (the orientation))))
           (rotation (matrix-to-rotation (the orientation)))
           (x (get-x (the center))) 
           (y (get-y (the center))) 
           (z (get-z (the center))))
      
      (cl-who:with-html-output (*stream* nil :indent nil)
        (:|Transform| :translation (when (not (every #'zerop (list x y z)))
                                   (format nil "~3,7f ~3,7f ~3,7f" x y z))
                    :rotation (when rotation
                                (format nil "~3,7f ~3,7f ~3,7f ~3,7f" (get-x rotation) (get-y rotation) (get-z rotation) (get-w rotation)))
                    (:|Group| (write-the shape))))))
   
   (scene 
    ()
    (cl-who:with-html-output (*stream* nil :indent nil)
      (:|X3D| :profile "Immersive"
            :version "3.1" 
            :xmlns\:xsd "http://www.w3.org/2001/XMLSchema-instance"
            :xsd\:noNamespaceSchemaLocation "http://www.web3d.org/specifications/x3d-3.1.xsd"
            (:|Scene| (:|Transform| (:|MetadataString| :name "fieldID" 
                                                 ;;:value (the x3d-node-id)
                                                 :value (the root-path-string)
                                                 :containerField "metadata")
                                (:|Group| (write-the cad-output-tree)))))))


   (cad-output
    (&key (header? t))
    
    (when header? (write-the header))
    
    (let ((orientation (the orientation)))
      
      (let (;;(rotation (quaternion-to-rotation (matrix-to-quaternion orientation)))
            (rotation (matrix-to-rotation orientation))
            (x (get-x (the center)))
            (y (get-y (the center))) 
            (z (get-z (the center)))
            )
        
        (cl-who:with-html-output (*stream* nil :indent nil)
	  ((:|Transform| :|translation| (unless (every #'zerop (list x y z))
				       (format nil "~3,7f ~3,7f ~3,7f" x y z)))
	   ((:|Transform| :|rotation| (when rotation
				   (format nil "~3,7f ~3,7f ~3,7f ~3,7f" 
					   (get-x rotation) (get-y rotation) (get-z rotation) (get-w rotation))))
	    (if (and (find-package :gwl) (symbol-value (read-safe-string "gwl::*onclick-function*")))
		(cl-who:htm 
		 ((:|Anchor| :url (format nil "javascript:event=null;~a"
					  (funcall (symbol-value (read-safe-string "gwl::*onclick-function*")) self)))
                   
		  (write-the shape)))
		(write-the shape)))
	   (when (and (typep self 'outline-specialization-mixin)
		      (not (ignore-errors (typep self (read-from-string "surf:surface")))))
	     (let* ((center (reverse-vector (the center)))
		    (x (get-x center)) (y (get-y center)) (z (get-z center))
		    (inverse (when (the orientation)
			       (matrix-to-rotation (matrix:transpose-matrix 
						    (the orientation)))
			       #+nil
			       (quaternion-to-rotation (matrix-to-quaternion (matrix:transpose-matrix 
									      (the orientation)))))))
	       (cl-who:htm
		((:|Transform| :|translation| (when (not (every #'zerop (list x y z)))
					    (format nil "~3,7f, ~3,7f, ~3,7f" x y z)))
		 ((:|Transform| :|rotation| (when inverse
					  (format nil "~3,7f ~3,7f ~3,7f ~3,7f" 
						  (get-x inverse) (get-y inverse) (get-z inverse) (get-w inverse))))
		  (mapc #'(lambda(outline-object)
			    (write-the-object outline-object (cad-output :header? nil)))
			(the outline-leaves))))))))))))

   
   (cad-output-tree
    (&key (header? t) (from-root? t))
    
    (when header? (write-the header))
    
    (let ((center (if from-root? (the center) (the local-center)))
	  (orientation (if from-root? (the orientation) (the local-orientation))))
      (let (;;(rotation (quaternion-to-rotation (matrix-to-quaternion orientation)))
            (rotation (matrix-to-rotation orientation))
            (x (get-x center)) (y (get-y center)) (z (get-z center)))
        
         
        (cl-who:with-html-output (*stream* nil :indent nil)
          ((:|Transform| :|translation| (unless (every #'zerop (list x y z))
				      (format nil "~3,7f ~3,7f ~3,7f" x y z)))
	   ((:|Transform| :|rotation| (when rotation
				    (format nil "~3,7f ~3,7f ~3,7f ~3,7f" 
					    (get-x rotation) (get-y rotation) (get-z rotation) (get-w rotation))))
           
	    (if (null (the children))
		(if (and (find-package :gwl) (symbol-value (read-safe-string "gwl::*onclick-function*")))
		    (cl-who:htm 
		     ((:|Anchor| :url (format nil "javascript:event=null;~a"
					      (funcall (symbol-value (read-safe-string "gwl::*onclick-function*")) self)))
		      (write-the shape)))
		    (write-the shape))
		
		(mapc #'(lambda(child) 
			  (write-the-object child (cad-output-tree :header? nil :from-root? nil))) (the children)))
    
	    (when (and (typep self 'outline-specialization-mixin)
		       (not (ignore-errors (typep self (read-from-string "surf:surface")))))
      
	      (let* ((center (reverse-vector (the center)))
		     (x (get-x center)) (y (get-y center)) (z (get-z center))
		     (inverse (when (the orientation)
				#+nil
				(quaternion-to-rotation (matrix-to-quaternion (matrix:transpose-matrix (the orientation))))
				(matrix-to-rotation (matrix:transpose-matrix (the orientation))))))
		(cl-who:htm
		 ((:|Transform| :|translation| (when (not (every #'zerop (list x y z)))
					     (format nil "~3,7f, ~3,7f, ~3,7f" x y z)))
		  ((:|Transform| :|rotation| (when inverse
					   (format nil "~3,7f ~3,7f ~3,7f ~3,7f" 
						   (get-x inverse) (get-y inverse) (get-z inverse) (get-w inverse))))
		   (mapc #'(lambda(outline-object)
			     (write-the-object outline-object (cad-output :header? nil)))
			 (the outline-leaves)))))))))))))))


   



(define-lens (x3d line)()
  :output-functions
  ((shape
    ()
    
    (let* ((points (mapcar #'(lambda(point) (the (global-to-local point))) (list (the start) (the end))))
           (indices (list-of-numbers 0 (1- (length points)))))
      (cl-who:with-html-output (*stream* nil :indent nil)
        ((:|Shape| 
          (:|Appearance| (write-the material-properties)))
         ((:|IndexedLineSet| :coordIndex (format nil "~{~a ~}-1" indices))
          ((:|Coordinate| :point (format nil "~{~a~^ ~}" 
                                       (mapcar #'(lambda(point) (format nil "~a ~a ~a" 
                                                                        (get-x point) 
                                                                        (get-y point) 
                                                                        (get-z point))) points)))))))))))






(define-lens (x3d arc)()
  :output-functions
  ((shape
    ()
    (dolist (bezier (list-elements (the beziers)))
      (let* ((points (mapcar #'(lambda(point) (the (global-to-local point))) (the-object bezier (equi-spaced-points *curve-chords*))))
             (indices (list-of-numbers 0 (1- (length points)))))
	(cl-who:with-html-output (*stream* nil :indent nil)
	  ((:|Shape| 
	    (:|Appearance| (write-the material-properties)))
	   ((:|IndexedLineSet| :coordIndex (format nil "~{~a ~}-1" indices))
	    ((:|Coordinate| :point (format nil "~{~a~^ ~}" 
					 (mapcar #'(lambda(point) (format nil "~a ~a ~a" 
									  (get-x point) 
									  (get-y point) 
									  (get-z point))) points))))))))))))



;;
;; FLAG -- identical to curve
;;
(define-lens (x3d ellipse)()
  :output-functions
  ((shape
    ()
    (dolist (bezier (list-elements (the beziers)))
      (let* ((points (mapcar #'(lambda(point) (the (global-to-local point))) (the-object bezier (equi-spaced-points *curve-chords*))))
             (indices (list-of-numbers 0 (1- (length points)))))
	(cl-who:with-html-output (*stream* nil :indent nil)
	  ((:|Shape| 
	    (:|Appearance| (write-the material-properties)))
	   ((:|IndexedLineSet| :coordIndex (format nil "~{~a ~}-1" indices))
	    ((:|Coordinate| :point (format nil "~{~a~^ ~}" 
					 (mapcar #'(lambda(point) (format nil "~a ~a ~a" 
									  (get-x point) 
									  (get-y point) 
									  (get-z point))) points))))))))))))



(define-lens (x3d cone)()
  :output-functions
  (
   (shape
    ()
    (if (the simple?)
	(cl-who:with-html-output (*stream* nil :indent nil)
	  (:|Shape|
	   (:|Appearance| (write-the material-properties))
	   (:|Cone| :bottomRadius (the radius-1)
		  :topRadius (the radius-2)
		  :height (the length)
		  :bottom (when (the bottom-cap?) "TRUE"))))
	(call-next-method)))))
	


(define-lens (x3d sphere)()
  :output-functions
  (
   (shape
    ()
    (if (the simple?)
	(cl-who:with-html-output (*stream* nil :indent nil)
	  (:Shape
	   (:Appearance (if (getf (the display-controls) :pixel-texture)
			    (write-the pixel-texture)
			    (write-the material-properties)))
	   (:Sphere :radius (the radius))))
	(call-next-method)))))



(define-lens (x3d cylinder)()
  :output-functions
  (
   (shape
    ()
    (if (the simple?)
	(cl-who:with-html-output (*stream* nil :indent nil)
	  (:|Shape|
	   (:|Appearance| (write-the material-properties))
	   (:|Cylinder| :|radius| (the radius) 
		      :|height| (the length))))
	(call-next-method)))))


(define-lens (x3d box)()
  :output-functions
  ((shape
    ()
    (cl-who:with-html-output (*stream* nil :indent t)
      (:|Shape|
       (:|Appearance| (write-the material-properties))
       (:|Box| :|size| (format nil "~a ~a ~a" 
			       (to-double-float (the width))
			       (to-double-float (the length))
			       (to-double-float (the height)))))))))



(define-lens (x3d global-filleted-polyline)()
  :output-functions
  ((shape
    ()
    (let ((points (the interpolated-points)))
      (cl-who:with-html-output (*stream* nil :indent nil)
	(:|Shape|
	 (:|Appearance| (write-the material-properties))
	 (:|IndexedLineSet| 
	  :|coordIndex| (format nil "~{~a~^ ~}" (list-of-numbers 0 (1- (length points))))
	  (:|Coordinate|
	   :|point| (format nil "~{~a~^ ~}" 
			  (mapcar #'(lambda(point) 
				      (let ((point (the (global-to-local point))))
					(format nil "~a ~a ~a" (get-x point) (get-y point) (get-z point)))) points))))))))))


(define-lens (x3d global-polyline)()
  :output-functions
  (
   (shape
    ()
    (cl-who:with-html-output (*stream* nil :indent nil)
      (:|Shape|
       (:|Appearance| (progn (when (getf (the display-controls) :linetype)
                             (write-the line-properties))
                           (write-the material-properties)))
       (:|IndexedLineSet| :|coordIndex| (format nil "~{~a ~}-1" (list-of-numbers 0 (1- (length (the vertex-list)))))
                        (:|Coordinate| :|point| (format nil "~{~a~^, ~}" 
                                                    (let ((*read-default-float-format* 'single-float))
                                                      (mapcar #'(lambda(point) (format nil "~a ~a ~a"
                                                                                       (coerce (get-x point) 'single-float)
                                                                                       (coerce (get-y point) 'single-float) 
                                                                                       (coerce (get-z point) 'single-float)
                                                                                       ))
                                                              (the vertex-list)))))))))))


(define-lens (x3d ifs-output-mixin)()
  :output-functions
  ((shape
    ()
    (cl-who:with-html-output (*stream* nil :indent t)
      (:|Shape|
       (:|Appearance| (write-the material-properties))
       ((:|IndexedFaceSet| :|solid| "FALSE"
	  :|creaseAngle| "1.571"
	  :|coordIndex| (format nil "~{~{~a~^ ~}~^ -1 ~}" (the ifs-indices)))
        ((:|Coordinate| :|point| (format nil "~{~{~a~^ ~}~^ ~}"
                                     (map 'list #'(lambda(point) 
                                                    (let ((point (the (global-to-local point))))
                                                      (list (get-x point) (get-y point) (get-z point))) )
                                          (the ifs-array)))))))))))
