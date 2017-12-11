(asdf:operate 'asdf:load-op 'ae2sbvzot)
(use-package :trio-utils)
(defvar TSPACE 5)


(load "TaskLib/T.lisp")

(defconstant ExeT2
 (&&  
 (load "TaskLib/T2.lisp")
  Config2
  (reset_actions action_indexes  1)
  ; (SomF (-P- Action_State_dn_3_1))
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