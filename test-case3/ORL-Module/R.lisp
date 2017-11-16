;;Robot

(define-tvar LINK1_Position *int*)
(define-tvar LINK2_Position *int*)
(define-tvar End_Eff_B_Position *int*) 
(define-tvar BASE_Position *int*)


(defconstant *Robot_Structure*
 (alwf(&&
 	;;positions
	; (|| (Adj (-V- LINK1_Position) L_last)([=] (-V- LINK1_Position) L_last))
	(|| (Adj (-V- LINK2_Position) (Yesterday (-V- LINK2_Position)))  ([=] (-V- LINK2_Position) (Yesterday (-V- LINK2_Position))))
	(|| (Adj (-V- End_Eff_B_Position) (Yesterday (-V- End_Eff_B_Position)))  ([=] (-V- End_Eff_B_Position) (Yesterday (-V- End_Eff_B_Position))))
	(|| (Adj (-V- LINK1_Position) (-V- LINK2_Position)) ([=] (-V- LINK1_Position) (-V- LINK2_Position)))
	(|| (Adj (-V- End_Eff_B_Position) (-V- LINK2_Position)) ([=] (-V- End_Eff_B_Position) (-V- LINK2_Position)))
	(|| (Adj (-V- LINK1_Position) (-V- BASE_Position)) ([=] (-V- LINK1_Position) (-V- BASE_Position)))
	(-> ([=] (-V- LINK1_Position) (-V- End_Eff_B_Position)) ([=] (-V- LINK2_Position) (-V- End_Eff_B_Position)) )
	;;moving regulations
	(-> (-P- End_Eff_Moving) (-P- LINK2_Moving))
	(<->(-P- LINK1_Moving)(!! ([=] (-V- LINK1_Position) (Yesterday (-V- LINK1_Position)))))
	(<->(-P- LINK2_Moving)(!! ([=] (-V- LINK2_Position) (Yesterday (-V- LINK2_Position)))))
	(<->(-P- LINK2_Moving)(!! ([=] (-V- LINK2_Position) (Yesterday (-V- LINK2_Position)))))
	(<->(-P- End_Eff_Moving)(!! ([=] (-V- End_Eff_B_Position) (Yesterday (-V- End_Eff_B_Position)))))
	(<->(-P- BASE_Moving)(!! ([=] (-V- BASE_Position) (Yesterday (-V- BASE_Position)))))
	(<->(-P- End_Eff_Moving) (-P- End_Eff_B_Moving)) 
	(-> (-P- BASE_Moving) (&& (-P- LINK1_Moving) (-P- LINK2_Moving) (-P- End_Eff_Moving)))
	(-> (-P- BASE_Moving) (&& ([=] (-V- LINK1_Position) (-V- BASE_Position))  ([=] (-V- LINK2_Position) (-V- BASE_Position)) ([=] (-V- BASE_Position) (-V- End_Eff_B_Position))))
	;;no move no activity
	(->(&& (|| (-P- LINK1_Moving) (-P- LINK2_Moving) (-P- End_Eff_Moving) (-P- BASE_Moving) ) (-P- no_RRM))(-P- relativeVelocity_critical))
	;;whe occluded
    (<->(-P- occluded)
    (|| (IsPallet (-V- LINK1_Position))(IsPallet (-V- LINK2_Position))(IsPallet (-V- End_Eff_B_Position))(IsPallet (-V- BASE_Position))))


)))



;use like (robotidle (setq l '(1 2 3)) Tname)
(defun robotidle (l Tname)
  (eval  (list `alwf `(<->
    (eval(append `(&&) (loop for i in l collect `(&&
      (|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" i ,(read-from-string (format nil "~A" Tname))))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" i ,(read-from-string (format nil "~A" Tname))))))))))(&& (!! (-P- LINK1_Moving)) (!! (-P- LINK2_Moving)) (!! (-P- End_Eff_Moving)))))))


