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

(in-package :www.genworks.com)

(define-object license-choice-explanation (sheet-section)

  :computed-slots
  ((inner-html (with-cl-who-string ()
		 ((:div :class "profile") 
		  ((:div :class :people)
		   (:h2 (str (locale-string :licensing-explained)))
		   (str (locale-string :genworks-gendl-is-so-called))
		   " "
		   ((:a :href "http://en.wikipedia.org/wiki/Multi-licensing") 
		    "\"" (str (locale-string :dual-licensed)) "\"")
		   " "
		   (str (locale-string :software-available-under-an-open-source-license))
		   " ("
		   ((:a :href "http://www.gnu.org/licenses/agpl-3.0.txt") "AGPL")
		   ") "
		   (str (locale-string :and-alternatively))))

		 ((:a :name "agpl-license"))
		 ((:a :href "#Top") (:h3 (str (locale-string :open-source))))
		 ((:div :class "profile")
		  ((:div :class "people")
		   (:p (str (locale-string :open-source-allows-freedom))
		       " " 
		       ((:a :href "http://www.gnu.org/licenses/agpl-3.0.txt") "AGPL")
		       " "
		       (str (locale-string :or-a-compatible-license)))

		   (:p (str (locale-string :no-restrictions)))

		   (:p (str (locale-string :code-must-remain-free)))

		   (:p (str (locale-string :opportunity-to-overcome-limitation))
		       (:ol
			(:li (str (locale-string :contribute-to-gendl))
			     ((:a :href "/newsite-static/documents/contributor.pdf") 
			      (str (locale-string :contributors-agreement)))
			     ", "
			     (str (locale-string :sharing)) ";")
			(:li (str (locale-string :purchase-appropriate-license)) ";")
			(:li (str (locale-string :freely-include)))))))

		 ((:a :name "trial-license"))
		 ((:a :href "#Top")(:h3 (str (locale-string :evaluation))))
		 ((:div :class "profile")
		  ((:div :class "people")
		   (str (locale-string :the)) " "
		   ((:a :href "/newsite-static/documents/eval.txt") 
		    (str (locale-string :evaluation-license)))
		   " "
		   (str (locale-string :provides-fully-functional))
		   " "
		   ((:a :href "http://www.gnu.org/licenses/agpl-3.0.txt") 
		    (str (locale-string :agpl-open-source-license)))
		   ", "
		   (str (locale-string :as-well-as-the-no-commercial-and-other))
		   " "
		   ((:a :href "/newsite-static/documents/eval.txt") 
		    (str (locale-string :evaluation-license)))
		   ". "
		   (str (locale-string :evaluation-may-be-renewed))))

		 ((:a :name "student-license"))
		 ((:a :href "#Top")(:h3 (str (locale-string :student))))
		 ((:div :class "profile")
		  ((:div :class "people")
		   (:str (locale-string :the))
		   " "
		   ((:a :href "/newsite-static/documents/student.txt") (str (locale-string :student-license)))
		   " "
		   (str (locale-string :is-valid-for-one-year))
		   ((:a :href "http://www.gnu.org/licenses/agpl-3.0.txt") 
		    (str (locale-string :agpl-open-source-license)))
		   ", "
		   (str (locale-string :as-well-as-the-no-commercial-and-other))
		   " "
		   ((:a :href "/newsite-static/documents/eval.txt") (str (locale-string :evaluation-license)))
		   ". "
		   (str (locale-string :student-license-also-qualifies-for-smlib))))
		 
		 ((:a :name "professional-license"))
		 ((:a :href "#Top")(:h3 (str (locale-string :professional))))
		 ((:div :class "profile")
		  ((:div :class "people")
		   (:p (str (locale-string :the))
		       " "
		       ((:a :href "/newsite-static/documents/gendl-development.pdf") 
			(str (locale-string :professional-license)))
		       " "
		       (str (locale-string :is-intended-for-use-in-the-early)))

		   (:p (str (locale-string :professional-is-perpetual)))))

		 ((:a :name "enterprise-license"))
		 ((:a :href "#Top") (:h3 (str (locale-string :enterprise))))
		 ((:div :class "profile")
		  ((:div :class "people")
		   (:p (str (locale-string :the))
		       " "
		       ((:a :href "/newsite-static/documents/gendl-development.pdf") 
			(str (locale-string :enterprise-license)))
		       " "
		       (str (locale-string :allows-all-uses-plus))

		       (:ol
			(:li (str (locale-string :noncommercial-testing)) ";")
			(:li (str (locale-string :academic-eg-university)))))

		   (:p (str (locale-string :for-commercial-deployments-gendl-runtime-are-available)))

		   (:p (str (locale-string :enterprise-is-perpetual)))))

		 
		 ((:a :name "academic-pricing"))
		 ((:a :href "#Top") (:h2 (str (locale-string :academic-pricing))))
		 
		 (:p (str (locale-string :as-our-investment-in-future)))
		 (:ol
		  (:li (str (locale-string :academic-institutions)) ";")
		  (:li (str (locale-string :government-research-labs)) ";")
		  (:li (str (locale-string :government-industry-consortia)) ";"))
		 
		 (:p (str (locale-string :furthermore-academic-runtimes-free)))))))





(define-object cl-engine-explanation (sheet-section)

  :computed-slots
  ((inner-html (with-cl-who-string ()
		 (:h2 "CL Engines Explained")
		 
		 ((:div :class "profile")
		  ((:div :class "people")
		   (:p ((:a :href "http://en.wikipedia.com/Common_Lisp"r)
			"Common Lisp")
		       " (CL) is an industry-standard programming
                  language, available today in several commercial as
                  well as community-supported Open Source
                  implementations. It is a goal of the GenDL project
                  to run on all major CL implementations, and as of
                  today, GenDL builds are available for three: "

		       ((:a :href "http://www.franz.com/products/allegro-common-lisp/") 
			"Allegro CL")

		       " from "

		       ((:a :href "http://www.franz.com") "Franz Inc")
		  
		       ", "

		       ((:a :href "http://www.lispworks.com/products/index.html") 
			"LispWorks")

		       " from "

		       ((:a :href "http://www.lispworks.com") "LispWorks Ltd") 

		       ", and "

		       ((:a :href "http://www.sbcl.org") "SBCL")

		       ", an Open Source implementation supported
                  by the community and by several third-party firms.")

		   (:p "It is possible to obtain GenDL seats bundled
		 with one of the commercial CL engines, with one of
		 our supported Open Source CL engines, or with no CL
		 engine at all. The selection of a commercial CL
		 engine includes technical support from that vendor,
		 provided to you via Genworks. The selection of an
		 Free/Open Source CL engine will result in increased
		 prices for Genworks support, because these CL engines
		 are typically available free of charge, and as such
		 do not include commercial CL support on their own.
		 The selection of no CL engine at all results in no
		 availability of Technical Support from
		 Genworks (third-party technical support may be a
		 possibility in this case)")))

		 ((:a :name "cl-none"))
		 ((:a :href "#Top") (:h3 "No CL Engine"))
		 ((:div :class "profile")
		  ((:div :class "people")
		   (:p "With this option, you will have to provide for
                   your own CL infrastructure as well as your own
                   Technical Support. This option may be appropriate
                   if you already have an existing CL infrastructure
                   in place, and you are equipped to handle your own
                   GenDL technical support.")))


		 ((:a :name "cl-sbcl"))
		 ((:a :href "#Top") (:h3 "Steel Bank Common Lisp"))
		 ((:div :class "profile")
		  ((:div :class "people")
		   (:p "By choosing this option explicitly, you enable
                   Genworks to offer Technical Support, because we do
                   have experience running GenDL with SBCL
                   ourselves. The Technical Support prices are higher
                   than with a commercial CL engine, because the SBCL
                   price (zero) includes no support. In order to
                   support GenDL on SBCL, Genworks will from time to
                   time have to become more familiar with SBCL
                   internals, or contract with a third-party such as "
		       ((:a :href "http://sb-studio.net") "Steel Bank
		       Studio")
		       ".")))


		 ((:a :name "cl-acl-32"))
		 ((:a :href "#Top") 
		  (:h3 "Allegro CL 32-bit"))
		 ((:div :class "profile")
		  ((:div :class "people")
		   (:p 
		    ((:a :href "http://www.franz.com/products/allegro-common-lisp/") 
		     "Allegro CL")
		    " 32-bit has been the primary deployment platform
                    for GenDL for over 10 years and remains a trusty
                    workhorse for small to medium sized applications
                    and models. Allegro CL also ships with a wide
                    array of supported add-on products, some of which
                    are available with standard Allegro CL GenDL at no
                    extra charge. The Professional and Enterprise
                    editions of GenDL correspond to the Professional
                    and Enterprise editions of Allegro CL.")
		   (:p "Allegro CL is supported on Windows, Linux,
                    FreeBSD, MacOS, and several commercial Unix
                    systems.")
		   (:p "The pricing model for Allegro CL is inclusive
                   of technical support, so selecting Allegro CL will
                   result in a reduction of Genworks' listed support
                   prices relative to the other CL choices
                   available. As with GenDL, Allegro CL's pricing
                   model carries license/support fees or royalties for
                   delivery of runtime applications. These fees are
                   included in the quoted runtime license/royalty fees
                   for a GenDL package configured with Allegro as the
                   CL Engine.")))

		 ((:a :name "cl-acl-64"))
		 ((:a :href "#Top") 
		  (:h3 "Allegro CL 64-bit"))
		 ((:div :class "profile")
		  ((:div :class "people")
		   (:p 
		    ((:a :href "http://www.franz.com/products/allegro-common-lisp/") 
		     "Allegro CL 64-bit")
		    " brings the stability and depth of Allegro CL to
                     a 64-bit address space, enabling models and
                     object trees to utilize up to the physical memory
                     limits of the host machine. This results in the
                     ability to retain computed object trees with vast
                     amounts of detailed information during a running
                     GenDL session. All attributes of Allegro CL
                     32-bit described above also apply to 64-bit.")))


		 ((:a :name "lw-32-pro"))
		 ((:a :href "#Top") (:h3 "LispWorks 32-bit Professional"))
		 ((:div :class "profile")
		  ((:div :class "people")
		   (:p "Common Lisp has long been the standard for
		   complex application development. "
		       ((:a :href "http://www.lispworks.com") "LispWorks")
		       " builds on this tradition with modern Lisp
		   development tools, based on advanced technologies
		   which make them the best development platform for a
		   variety of uses.")

		   (:p "The pricing model for LispWorks is exclusive
                   of technical support, so selecting LispWorks will
                   result in an increase of Genworks' listed support
                   prices (relative to Allegro CL).  Unlike GenDL,
                   LispWorks' pricing model for most platforms carries
                   no license/support fees or royalties for
                   delivery. This results in a reduction in the quoted
                   runtime license/royalty fees for a GenDL package
                   configured with LispWorks as the CL Engine.")
		   
		   (:p "What we refer to as \"LispWorks 32-bit Professional\"
		   corresponds to "
		       ((:a :href "http://www.lispworks.com/products/lispworks.html")
		       "LispWorks Professional")
		       " Edition. Unlike the Allegro CL Professional
		   Edition, LispWorks Professional Edition is capable
		   of generating runtime applications. Therefore it is
		   possible to configure an Enterprise GenDL seat with
		   this edition of LispWorks, but not with the
		   Professional Edition of Allegro CL. The LispWorks
		   Professional Edition is a complete Common Lisp
		   development environment, but lacks certain add-on
		   features which are available in the LispWorks
		   Enterprise Edition.")))


		 ((:a :name "lw-32-exp"))
		 ((:a :href "#Top") (:h3 "LispWorks 32-bit Enterprise"))
		 ((:div :class "profile")
		  ((:div :class "people")
		   (:p "What we refer to as \"LispWorks 32-bit
                   Enterprise\" corresponds to "
		       ((:a :href "http://www.lispworks.com/products/lispworks.html")
			"LispWorks 32-bit")
		       " Enterprise Edition. The Lispworks Enterprise
                   Edition includes all the "
		       ((:a :href "http://www.lispworks.com/products/features.html") 
			"features")
		       " of Professional, with the
                   addition of several "
		       ((:a :href "http://www.lispworks.com/products/LW60.pdf") 
			"add-on modules")
		       " including SQL Database
                   connectivity tools, traditional Expert System
                   framework with embedded Prolog compiler, and CORBA
                   ORB support.")))


		 ((:a :name "lw-64-exp"))
		 ((:a :href "#Top") (:h3 "LispWorks 64-bit Enterprise"))
		 ((:div :class "profile")
		  ((:div :class "people")
		   (:p "What we refer to as \"LispWorks 64-bit
                   Enterprise\" corresponds to LispWorks 64-bit
                   Enterprise Edition. The Lispworks 64-bit Enterprise
                   Edition includes all the features of 32-bit
                   Enterprise, with the addition of 64-bit support,
                   enabling increased computing performance enabling
                   models and object trees to utilize up to the
                   physical memory limits of the host machine. This
                   results in the ability to retain computed object
                   trees with vast amounts of detailed information
                   during a running GenDL session.")))))))




(define-object tech-support-level-explanation (sheet-section)

  :computed-slots
  ((inner-html (with-cl-who-string ()
		 (:h2 "Technical Support Levels Explained")
		 
		 ((:div :class "profile")
		  ((:div :class "people")
		   (:p " While the main goal  of Gendl is ease of use, because of the broad and powerful nature
of the system, some level of professional technical support can provide a valuable boost to your project."

		 ((:a :name "tech-support-none"))
		 ((:a :href "#Top") (:h3 "None (i.e. self-provided or third-party)"))
		 ((:div :class "profile")
		  ((:div :class "people")
		   (:p "With this option, you will have to provide for
                   your own CL and Gendl support. This option may be
                   appropriate if you already have an existing CL
                   infrastructure in place, and you are equipped to
                   handle your own GenDL technical support.")))


		 ((:a :name "tech-support-install"))
		 ((:a :href "#Top") (:h3 "Installation and Configuration"))
		 ((:div :class "profile")
		  ((:div :class "people")
		   (:p "We will support your initial installation...")))


		 ((:a :name "tech-support-how-to"))
		 ((:a :href "#Top") 
		  (:h3 "Technical how-to Questions and Answers"))
		 ((:div :class "profile")
		  ((:div :class "people")
		   (:p 
		    " With this option, you can call or write to Genworks with customized inquiries 
and receive custom support answers, typically within 24 hours. If you send working self-contained
example applications, we can also attempt to replicate and debug any problems you are having with 
your application. At this support level we cannot support Nondisclosure Agreements (NDA) on sample 
code sent.")))

		 ((:a :name "tech-support-nda"))
		 ((:a :href "#Top") 
		  (:h3 "Application Code Nondisclosure"))
		 ((:div :class "profile")
		  ((:div :class "people")
		   (:p 
		    "At this support level, you may send us your self-contained application code for debugging, and
we will take measures to keep this code under strict Confidentiality and Nondisclosure.")))


		 ((:a :name "tech-support-mission-critical"))
		 ((:a :href "#Top") (:h3 "Mission-critical Production Environment"))
		 ((:div :class "profile")
		  ((:div :class "people")
		   (:p "This is the ultimate support level, which
provides you with custom Application Support, default Nondisclosure on
all submitted materials, and real-time telepone and chat support for
mission-critical applications (e.g. high-traffic websites or
manufacturing facilities running on Gendl technology)."))))))))))