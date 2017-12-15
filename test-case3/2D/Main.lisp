(asdf:operate 'asdf:load-op 'ae2sbvzot)
(use-package :trio-utils)
(defvar TSPACE 5)


(load "ORL-Module/L.lisp")
(load "ORL-Module/O.lisp")
(load "ORL-Module/R.lisp")

  (load "Hazards.lisp")
;   (load "RRM.lisp")
  (load "REs.lisp")
  ; (load "REv.lisp")

(defconstant Hazards
    (&&
        ;;Hazards 
        *Hazardslist*
        ;;risks
        (Risk_estimation )
        ; (RRMProperties 1 1)
        ))

(defconstant ExeT2
 (&&  
 Hazards
 (Robot_Structure 1)
 (Operator_Body 1)
 (relativeProperties 1 1)
  (AlwF (-P- BASE_1_MOVING))
  (SomF (&& (In_same_L `BASE_1 `operator_1_head_area)(-P- BASE_1_MOVING)))
  (AlwF (-> (In_same_L `BASE_1 `operator_1_head_area) (-P- RELATIVEVELOCITY_1_1_LOW)))
  ; (AlwF (!!(Risk= 2)))
))

(defconstant *sys*
 (yesterday(&&
  ; (Next ExeT1)
  (Next ExeT2)
  )))


(format t "~S" *sys*)
(ae2sbvzot:zot TSPACE
 (&&
   *sys*
   )
  )