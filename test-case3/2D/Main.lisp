(asdf:operate 'asdf:load-op 'ae2sbvzot)
(use-package :trio-utils)
(defvar TSPACE 5)


(load "ORL-Module/L.lisp")
(load "ORL-Module/O.lisp")
(load "ORL-Module/R.lisp")

  (load "Hazards.lisp")
  (load "REs.lisp")

(defconstant Hazards
    (&&
        *Hazardslist*
        (Risk_estimation )
        ))

(defconstant ExeT2
 (&&  
  ;;definitions
  Hazards
 (Robot_Structure 1)
 (Operator_Body 1)
 (relativeProperties 1 1)

 ;risk reduction measure
 (AlwF (-> (In_same_L `BASE_1 `operator_1_head_area) (&& (-P- RELATIVEFORCE_1_1_LOW)(-P- RELATIVEVELOCITY_1_1_LOW))))

 ;property
 (!!(AlwF (!! (|| (HAZARD_Risk_1= 2) (HAZARD_Risk_2= 2)))))
))

(defconstant *sys*
 (&&
  ExeT2
  ))


(format t "~S" *sys*)
(ae2sbvzot:zot TSPACE
 (&&
   *sys*
   )
  )