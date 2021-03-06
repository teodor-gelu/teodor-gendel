(in-package :aserve-log)

(define-object assembly (base-html-sheet)
  
  :input-slots
  ((relevant-headings (list :domain :iso-time :uri-path :user-agent :referrer))
   (relevant-hosts (list "www.genworks.com" "www.squeakymail.com")))

  
  :functions 
  ((write-html-sheet 
    ()
    (html
     (:html
      (:head (:title "Log Report"))
      (:body (:center (:h2 "Log Report"))
	     (:p (the (:write-log-table)))))))
   
   (:pass-filter?
    (log &key relevant-hosts)
    (declare (ignore log relevant-hosts))
    t
    ;;
    ;; FLAG -- make more general and configurable.
    ;;
    #+nil
    (let ((domain (getf log :domain))
	  (uri-path (getf log :uri-path))
	  (user-agent (getf log :user-agent)))
      (and (or (null relevant-hosts)
	       (member (getf log :uri-host) relevant-hosts :test #'string-equal))
	   (or (null user-agent)
	       (not (or (search "usabestnet" domain)
			(search "c-68-40-98-13.hsd1.mi.comcast.net" domain)
			(search "msnbot.msn.com" domain)
			(search "netsonic.fi" domain)
			(search "amiedu.fi" domain)
			(search "looksmart" domain)
			(search "buildrack" domain)
			(search "wwnet.net" domain)
			(search "internetseer.net" domain)
			(search "googlebot.com" domain)
			(search "inktomi" domain)
			(search "echo.com" domain)
			(search "netcraft.com" domain)
			(search "spider" domain)
	       
			(string-equal uri-path "/robots.txt")
			(string-equal uri-path "/server-log")
			(search ".gif" uri-path)
			(search ".jpg" uri-path)
			(search "formmail" uri-path)
		    
			(string-equal user-agent "ia_archiver")
			(search "Gozilla" user-agent)
			(search "raw.no-ip.com/monitor" user-agent)
			(search "grub" user-agent)
			(search "Sleuth" user-agent)
			(search "Ask Jeeves" user-agent)
			(search "crawler" (string-downcase user-agent))
			(search "robot" (string-downcase user-agent))
			(search "LinkScan" user-agent)
			(search "sitecheck.internetseer.com" user-agent)
			(search "Googlebot" user-agent)))))))
   
   ;;
   ;; FLAG -- if memory becomes an issue, read & emit these one at a time from the file.
   ;;
   (:write-log-table
    ()
    (let* ((log-entries (gwl::read-log-entries))
	   (latest-time (getf (first log-entries) :start-time))
	   (cut-off-time (- latest-time (* 5 24 60 60)))
	   (relevant-hosts (the :relevant-hosts))
	   (entry-hash (make-hash-table :size (length (the :relevant-headings)))))
    (html
     ((:table :bgcolor :black :cellspacing 1 :cellpadding 2)
      ((:tr :bgcolor :yellow) 
       (dolist (heading (the :relevant-headings))
	 (html (:td (:princ (replace-substring (string-capitalize heading) "-" " "))))))
      (dolist (log log-entries)
	(when (and (> (getf log :start-time) cut-off-time)
		   (the (:pass-filter? log :relevant-hosts relevant-hosts)))
	  (html ((:tr :bgcolor (gethash :quartz *color-table*))
		 (dolist (heading (the :relevant-headings))
		   (let* ((value (getf log heading))
			  (hashed-value (gethash heading entry-hash)))
		     (if (not (equalp value hashed-value))
			 (progn (setf (gethash heading entry-hash) value)
				(case heading
				  (:uri-path (html (:td ((:a :href (format nil "~(~a~)://~a~a" 
									   (getf log :uri-scheme) (getf log :uri-host) value))
							 (:princ value)))))
				  (otherwise (html (:td (:princ value))))))
		       (html ((:td :bgcolor (gethash :aquamarine *color-table*)) :br)))))))))))))))


