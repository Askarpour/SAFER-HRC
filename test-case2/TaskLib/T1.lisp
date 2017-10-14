(defvar actions-index (loop for i from 1 to 13 collect i))

;operator inserts the wp in bp1
(defun insertp1(actionid Traceid)
 (eval (list `alwf (append `(&&)
	(loop for i from actionid to actionid collect
   `(&&	
   		(-P- ,(read-from-string (format nil "Action_Doer_ro_~A_~A" actionid Traceid)))
   		
   		; (->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" actionid Traceid))) (&&(-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- actionid 1) Traceid)))([=](-V- End_Eff_B_Position) BP1)))

		   ; (->(-P- ,(read-from-string (format nil "Action_Pre_L_~A_~A" actionid Traceid)))([=](-V- End_Eff_B_Position) BP1))

		   ; (->(-P- ,(read-from-string (format nil "Action_Post_~A_~A" actionid Traceid))) ([=](-V- End_Eff_B_Position) BP1))

		   ; (->(-P- ,(read-from-string (format nil "Action_Post_L_~A_~A" actionid Traceid))) ([=](-V- End_Eff_B_Position) BP1))

       (->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" actionid Traceid))) (&&(-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- actionid 1) Traceid)))([=](-V- Body_Part_pos hand) BP1)))

       (->(-P- ,(read-from-string (format nil "Action_Pre_L_~A_~A" actionid Traceid)))([=](-V- Body_Part_pos hand) BP1))

       (->(-P- ,(read-from-string (format nil "Action_Post_~A_~A" actionid Traceid))) ([=](-V- Body_Part_pos hand) BP1))

       (->(-P- ,(read-from-string (format nil "Action_Post_L_~A_~A" actionid Traceid))) ([=](-V- Body_Part_pos hand) BP1))

 	 ))))))
;operator inserts the wp in bp2
(defun insertp2(actionid Traceid)
 (eval (list `alwf (append `(&&)
	(loop for i from actionid to actionid collect
   `(&&	
   		(-P- ,(read-from-string (format nil "Action_Doer_ro_~A_~A" actionid Traceid)))

   		(->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" actionid Traceid))) (&&(-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- actionid 1) Traceid)))([=](-V- End_Eff_B_Position) BP2)))

   		(->(-P- ,(read-from-string (format nil "Action_Pre_L_~A_~A" actionid Traceid)))([=](-V- End_Eff_B_Position) BP2))

   		(->(-P- ,(read-from-string (format nil "Action_Post_~A_~A" actionid Traceid)))([=](-V- End_Eff_B_Position) BP2))

   		(->(-P- ,(read-from-string (format nil "Action_Post_L_~A_~A" actionid Traceid)))([=](-V- End_Eff_B_Position) BP2))
 			
 	 ))))))

;operator inspects the execution
(defun inspectp(actionid traceid inspection-pos)
 (eval (list `alwf (append `(&&)
   (loop for i from actionid to actionid collect
   `(&&  
       (-P- ,(read-from-string (format nil "Action_Doer_op_~A_~A" actionid Traceid)))
       (->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" actionid Traceid))) (&&(-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- actionid 1) Traceid)))([=](-V- Body_Part_pos hand) ,(read-from-string (format nil "~A" inspection-pos))) ([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" inspection-pos))) (-P- Robot_Idle)))   

    (->(-P- ,(read-from-string (format nil "Action_Pre_L_~A_~A" actionid Traceid))) (&&([=](-V- Body_Part_pos hand) ,(read-from-string (format nil "~A" inspection-pos))) ([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" inspection-pos)))))

    (->(-P- ,(read-from-string (format nil "Action_Post_~A_~A" actionid Traceid))) (&& ([=](-V- Body_Part_pos hand) ,(read-from-string (format nil "~A" inspection-pos))) ([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" inspection-pos))) (-P- Robot_Idle))) 

    (->(-P- ,(read-from-string (format nil "Action_Post_L_~A_~A" actionid Traceid)))(&&([=](-V- Body_Part_pos hand) ,(read-from-string (format nil "~A" inspection-pos))) ([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" inspection-pos))))) 

    (->(|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" actionid Traceid))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" actionid Traceid)))) (&& ([=](-V- Body_Part_pos hand) ,(read-from-string (format nil "~A" inspection-pos)))(-P- Robot_Idle)))
    
))))))      

;robot is moving
(defun move(actionid Traceid source dest)
 (eval (list `alwf (append `(&&)
   (loop for i from actionid to actionid collect
   `(&&
         (-P- ,(read-from-string (format nil "Action_Doer_ro_~A_~A" actionid Traceid)))

         (->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" actionid Traceid))) (&&(-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- actionid 1) Traceid)))([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" source)))))   

         (->(-P- ,(read-from-string (format nil "Action_Pre_L_~A_~A" actionid Traceid))) ([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" source))))

         (->(-P- ,(read-from-string (format nil "Action_Safe_L_~A_~A" actionid Traceid))) (&& (!!( Adj (-V- Body_Part_pos hand) ,(read-from-string (format nil "~A" dest))))  (!!([=](-V- Body_Part_pos hand) ,(read-from-string (format nil "~A" dest))))))

         (->(-P- ,(read-from-string (format nil "Action_Post_~A_~A" actionid Traceid))) ([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" dest))))

         (->(-P- ,(read-from-string (format nil "Action_Post_L~A_~A" actionid Traceid))) ([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" dest)))) 
))))))

;robot is moving
(defun firstmove(actionid Traceid source dest)
 (eval (list `alwf (append `(&&)
   (loop for i from actionid to actionid collect
   `(&&
         (-P- ,(read-from-string (format nil "Action_Doer_ro_~A_~A" actionid Traceid)))

         (->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" actionid Traceid))) (&&([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" source)))))   

         (->(-P- ,(read-from-string (format nil "Action_Pre_L_~A_~A" actionid Traceid))) ([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" source))))

         (->(-P- ,(read-from-string (format nil "Action_Post_~A_~A" actionid Traceid))) ([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" dest))))

         (->(-P- ,(read-from-string (format nil "Action_Post_L~A_~A" actionid Traceid))) ([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" dest)))) 
))))))

; ro picks a wp
(defun pick(actionid Traceid dest)
 (eval (list `alwf (append `(&&)
   (loop for i from actionid to actionid collect
   `(&&
         (-P- ,(read-from-string (format nil "Action_Doer_ro_~A_~A" actionid Traceid)))

         (->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" actionid Traceid))) (-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- actionid 1) Traceid)))) 

         (->(-P- ,(read-from-string (format nil "Action_Post_~A_~A" actionid Traceid))) (&& ([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" dest))) (-P- PP_empty)))

         (->(-P- ,(read-from-string (format nil "Action_Post_L_~A_~A" actionid Traceid))) ([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" dest))))

         (->(-P- ,(read-from-string (format nil "Action_Safe_L_~A_~A" actionid Traceid))) (&& (!!( Adj (-V- Body_Part_pos hand) ,(read-from-string (format nil "~A" dest))))  (!!([=](-V- Body_Part_pos hand) ,(read-from-string (format nil "~A" dest))))))

         (->(|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" actionid Traceid))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" actionid Traceid)))) ([=](-V- End_Eff_B_Position) ,(read-from-string (format nil "~A" dest))))

))))))

;ro removes wp from p1
(defun removep1(actionid Traceid)
 (eval (list `alwf (append `(&&)
   (loop for i from actionid to actionid collect
   `(&& 
      (-P- ,(read-from-string (format nil "Action_Doer_ro_~A_~A" actionid Traceid)))

      (->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" actionid Traceid))) (-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- actionid 1) Traceid))))
      
      (->(-P- ,(read-from-string (format nil "Action_Post_~A_~A" actionid Traceid))) (&& ([=](-V- End_Eff_B_Position) BP1) (-P- BP1_empty)))

      (->(-P- ,(read-from-string (format nil "Action_Post_L_~A_~A" actionid Traceid))) ([=](-V- End_Eff_B_Position) BP1))

      (->(|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" actionid Traceid))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" actionid Traceid)))) (&& ([=](-V- End_Eff_B_Position) BP1) (-P- remove-going-on)))

))))))

;ro removes wp from p2
(defun removep2(actionid Traceid)
 (eval (list `alwf (append `(&&)
   (loop for i from actionid to actionid collect
   `(&& 
      (-P- ,(read-from-string (format nil "Action_Doer_ro_~A_~A" actionid Traceid)))

      (->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" actionid Traceid))) (-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- actionid 1) Traceid))))

      (->(-P- ,(read-from-string (format nil "Action_Post_~A_~A" actionid Traceid))) (&& ([=](-V- End_Eff_B_Position) BP2) (-P- BP2_empty)))

      (->(-P- ,(read-from-string (format nil "Action_Post_L_~A_~A" actionid Traceid))) ([=](-V- End_Eff_B_Position) BP2))

      (->(|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" actionid Traceid))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" actionid Traceid)))) (&& ([=](-V- End_Eff_B_Position) BP2) (-P- remove-going-on)))
))))))

;operator unscrews the part
(defun unscrew (actionid traceid piece-pos)
 (eval (list `alwf (append `(&&)
   (loop for i from actionid to actionid collect
   `(&&
      (-P- ,(read-from-string (format nil "Action_Doer_op_~A_~A" actionid Traceid)))

      (->(-P- ,(read-from-string (format nil "Action_Pre_~A_~A" actionid Traceid))) (&&(-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" (- actionid 1) Traceid)))([=](-V- Body_Part_pos hand) ,(read-from-string (format nil "~A" piece-pos)))))

      (->(-P- ,(read-from-string (format nil "Action_Pre_L_~A_~A" actionid Traceid))) ([=](-V- Body_Part_pos hand) ,(read-from-string (format nil "~A" piece-pos))))

      (->(-P- ,(read-from-string (format nil "Action_Post_~A_~A" actionid Traceid))) ([=](-V- Body_Part_pos hand) ,(read-from-string (format nil "~A" piece-pos))))

      (->(-P- ,(read-from-string (format nil "Action_Post_L_~A_~A" actionid Traceid))) ([=](-V- Body_Part_pos hand) ,(read-from-string (format nil "~A" piece-pos))))

      (->(|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" actionid Traceid))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" actionid Traceid)))) ([=](-V- Body_Part_pos hand) ,(read-from-string (format nil "~A" piece-pos))))
)))))) 

(defconstant mutually_exclusive2
  (&&
    (mutually_exclusive "Action_State_ns" "Action_State_wt" "Action_State_exe" "Action_State_dn" "Action_State_exrm" "Action_State_hd" "Action_State_ex"  actions-index 1)
    (mutually_exclusive "Action_State_wt" "Action_State_ns" "Action_State_exe" "Action_State_dn" "Action_State_exrm" "Action_State_hd" "Action_State_ex"  actions-index 1)
    (mutually_exclusive "Action_State_exe" "Action_State_ns" "Action_State_wt" "Action_State_dn" "Action_State_exrm" "Action_State_hd" "Action_State_ex"  actions-index 1)
    (mutually_exclusive "Action_State_dn" "Action_State_ns" "Action_State_wt" "Action_State_exe" "Action_State_exrm" "Action_State_hd" "Action_State_ex"  actions-index 1)
    (mutually_exclusive "Action_State_exrm" "Action_State_ns" "Action_State_wt" "Action_State_exe" "Action_State_dn" "Action_State_hd" "Action_State_ex"  actions-index 1)
    (mutually_exclusive "Action_State_hd" "Action_State_ns" "Action_State_wt" "Action_State_exe" "Action_State_dn" "Action_State_exrm" "Action_State_ex"  actions-index 1)
    (mutually_exclusive "Action_State_ex" "Action_State_ns" "Action_State_wt" "Action_State_exe" "Action_State_dn" "Action_State_exrm" "Action_State_hd"  actions-index 1)))

    
;;
;; robot moves from HP to P2
;; operator unscrews wp1 from P2
;; robot removes the wp1 from P2
;; robot takes wp1 to bin
;; robot moves back to HP
;; operator unscrews wp2 in P1
;; robot moves to P1
;; robot removes the wp2 from P1
;; robot moves from P1 to P2
;; operator inserts wp2 in P2
;; robot goes to bin
;; robot picks a new wp
;; robot moves to HP
;; robot inserts new wp in P1
