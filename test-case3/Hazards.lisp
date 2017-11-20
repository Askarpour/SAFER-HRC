;;Hazards

(defvar hazards-indexes (loop for i from 1 to 18 collect i))

(loop for i in hazards-indexes collect
  (progn 
        (eval `(define-tvar ,(read-from-string (format nil "Hazard_CI_~A" i)) *int*))
        (eval `(define-tvar ,(read-from-string (format nil "Hazard_Se_~A" i)) *int*))
        (eval `(define-tvar ,(read-from-string (format nil "Hazard_Risk_~A" i)) *int*))
        (eval `(define-tvar ,(read-from-string (format nil "Hazard_Reg_~A" i)) *int*))))

(defun HazardsInit ()
 (eval (list `alwf (append `(&&) (loop for i in hazards-indexes collect `(&&
    ;;
    ([<=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_CI_~A" i))(loop for x = (read in nil nil) while x collect x)))) 16)
    ([>=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_CI_~A" i))(loop for x = (read in nil nil) while x collect x)))) 1)
    ([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_CI_~A" i))(loop for x = (read in nil nil) while x collect x)))) 9) ;temp
    ;;
    ([<=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Se_~A" i))(loop for x = (read in nil nil) while x collect x)))) 4)
    ([>=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Se_~A" i))(loop for x = (read in nil nil) while x collect x)))) 1)
    ;;
    ([<=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Risk_~A" i))(loop for x = (read in nil nil) while x collect x)))) 2)
    ([>=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Risk_~A" i))(loop for x = (read in nil nil) while x collect x)))) 0)
    ;;
    ([<=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Reg_~A" i))(loop for x = (read in nil nil) while x collect x)))) L_last)
    ([>=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Reg_~A" i))(loop for x = (read in nil nil) while x collect x)))) L_first)))))))

(defun hazard_reg_reset ()
 (eval (append `(&&)(loop for i in hazards-indexes collect
    `([=] (first(-V- ,(with-input-from-string (in (format nil "Hazard_Reg_~A" i)) (loop for x = (read in nil nil) while x collect x)))) L_first)))))

(defun hazard_hit (opID bodypart robotpart hazard_id other_robotpart_1 other_robotpart_2)
 (eval`(&&
    (<->
        (-P- ,(read-from-string (format nil "Hazard_occured_~A" hazard_id))) 
        (&&
            ([=](-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~a ~a" opId bodypart)) (loop for x = (read in nil nil) while x collect x))) (first(-V- ,(with-input-from-string (in (format nil "~D_Position" robotpart)) (loop for x = (read in nil nil) while x collect x)))))
            (-P- ,(read-from-string (format nil "~D_Moving" robotpart))) 
            (!!
                (||
                    ; ([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos ~a" bodypart)) (loop for x = (read in nil nil) while x collect x))) L_1_2)
                    ; ([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos ~a" bodypart)) (loop for x = (read in nil nil) while x collect x))) L_1_3)
                    (-P- occluded)
                    ;;ocluded area 
                   
                    ([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~a ~a" opId bodypart)) (loop for x = (read in nil nil) while x collect x))) (first(-V- ,(with-input-from-string (in (format nil "~D_Position" other_robotpart_1)) (loop for x = (read in nil nil) while x collect x)))) )
                    ([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~a ~a" opId bodypart)) (loop for x = (read in nil nil) while x collect x))) (first(-V- ,(with-input-from-string (in (format nil "~D_Position" other_robotpart_2)) (loop for x = (read in nil nil) while x collect x)))))
                )
            )  
        )
    )
    ([=](first(-V- ,(with-input-from-string (in (format nil "Hazard_Reg_~A" hazard_id)) (loop for x = (read in nil nil) while x collect x)))) (first(-V- ,(with-input-from-string (in (format nil "~D_Position" robotpart)) (loop for x = (read in nil nil) while x collect x)))))
    )))

(defun hazard_entg (opId bodypart robotpart hazard_id other_robotpart_1 other_robotpart_2)
 (eval
   `(&&
    (<->
        (-P- ,(read-from-string (format nil "Hazard_occured_~A" hazard_id))) 
        (&& 
            ([=]
                (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~a ~a" opId bodypart)) (loop for x = (read in nil nil) while x collect x)))
                (first(-V- ,(with-input-from-string (in (format nil "~D_Position" robotpart)) (loop for x = (read in nil nil) while x collect x))))
            )
            (||
                ; ([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos ~a" bodypart)) (loop for x = (read in nil nil) while x collect x))) L_1_2)
                ; ([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos ~a" bodypart)) (loop for x = (read in nil nil) while x collect x))) L_1_3)
                (-P- occluded)
                
                (&&
                    ([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~a ~a" opId bodypart)) (loop for x = (read in nil nil) while x collect x))) (first(-V- ,(with-input-from-string (in (format nil "~D_Position" other_robotpart_1)) (loop for x = (read in nil nil) while x collect x))))) 
                    (-P- ,(read-from-string (format nil "~D_Moving" other_robotpart_1))) 
                )

                (&&
                    ([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~a ~a" opId bodypart)) (loop for x = (read in nil nil) while x collect x))) (first(-V- ,(with-input-from-string (in (format nil "~D_Position" other_robotpart_2)) (loop for x = (read in nil nil) while x collect x)))) )
                    (-P- ,(read-from-string (format nil "~D_Moving" other_robotpart_2))) 
                )                        
            )
            (||
                (-P- ,(read-from-string (format nil "~D_Moving" robotpart))) 
                (!!([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~a ~a" opId bodypart)) (loop for x = (read in nil nil) while x collect x))) (Yesterday (-V- ,(with-input-from-string (in (format nil "Body_Part_pos_~a ~a" opId bodypart)) (loop for x = (read in nil nil) while x collect x))))))
            )
        )
    )
    ([=](first(-V- ,(with-input-from-string (in (format nil "Hazard_Reg_~A" hazard_id)) (loop for x = (read in nil nil) while x collect x)))) (first(-V- ,(with-input-from-string (in (format nil "~D_Position" robotpart)) (loop for x = (read in nil nil) while x collect x)))))
    ))) 

(defvar End_Eff_B "End_Eff_B")
(defvar LINK1 "LINK1")
(defvar LINK2 "LINK2")

(defconstant *Hazards*
 (alwf(&&
    ;;*** hits
    (hazard_hit 1 Neck End_Eff_B 1 LINK1 LINK2)
    (hazard_hit 1 Head End_Eff_B 1 LINK1 LINK2)
    (hazard_hit 1 shoulders End_Eff_B 1 LINK1 LINK2)

    (hazard_hit 1 Chest End_Eff_B 2 LINK1 LINK2)
    (hazard_hit 1 Belly End_Eff_B 2 LINK1 LINK2)
    (hazard_hit 1 Pelvis End_Eff_B 2 LINK1 LINK2)

    (hazard_hit 1 Upper_Arm End_Eff_B 3 LINK1 LINK2)
    (hazard_hit 1 Hand End_Eff_B 3 LINK1 LINK2)
    (hazard_hit 1 Lower_Arm End_Eff_B 3 LINK1 LINK2)


    (hazard_hit 1 Neck LINK1 4 LINK2 End_Eff_B)
    (hazard_hit 1 Head LINK1 4 LINK2 End_Eff_B)
    (hazard_hit 1 shoulders LINK1 4 LINK2 End_Eff_B)

    (hazard_hit 1 Chest LINK1 5 LINK2 End_Eff_B)
    (hazard_hit 1 Belly LINK1 5 LINK2 End_Eff_B)
    (hazard_hit 1 Pelvis LINK1 5 LINK2 End_Eff_B)

    (hazard_hit 1 Upper_Arm LINK1 6 LINK2 End_Eff_B)
    (hazard_hit 1 Hand LINK1 6 LINK2 End_Eff_B)
    (hazard_hit 1 Lower_Arm LINK1 6 LINK2 End_Eff_B)


    (hazard_hit 1 Neck LINK2 7 LINK1 End_Eff_B)
    (hazard_hit 1 Head LINK2 7 LINK1 End_Eff_B)
    (hazard_hit 1 shoulders LINK2 7 LINK1 End_Eff_B)

    (hazard_hit 1 Chest LINK2 8 LINK1 End_Eff_B)
    (hazard_hit 1 Belly LINK2 8 LINK1 End_Eff_B)
    (hazard_hit 1 Pelvis LINK2 8 LINK1 End_Eff_B)

    (hazard_hit 1 Upper_Arm LINK2 9 LINK1 End_Eff_B)
    (hazard_hit 1 Hand LINK2 9 LINK1 End_Eff_B)
    (hazard_hit 1 Lower_Arm LINK2 9 LINK1 End_Eff_B)


    ;;*** entanglements
    (hazard_entg 1 Neck End_Eff_B 10 LINK2 LINK1)
    (hazard_entg 1 Head End_Eff_B 10 LINK2 LINK1)
    (hazard_entg 1 shoulders End_Eff_B 10 LINK2 LINK1)

    (hazard_entg 1 Chest End_Eff_B 11 LINK2 LINK1)
    (hazard_entg 1 Belly End_Eff_B 11 LINK2 LINK1)
    (hazard_entg 1 Pelvis End_Eff_B 11 LINK2 LINK1)

    (hazard_entg 1 Upper_Arm End_Eff_B 12 LINK2 LINK1)
    (hazard_entg 1 Hand End_Eff_B 12 LINK2 LINK1)
    (hazard_entg 1 Lower_Arm End_Eff_B 12 LINK2 LINK1)


    (hazard_entg 1 Neck LINK1 13 LINK2 End_Eff_B)
    (hazard_entg 1 Head LINK1 13 LINK2 End_Eff_B)
    (hazard_entg 1 shoulders LINK1 13 LINK2 End_Eff_B)

    (hazard_entg 1 Chest LINK1 14 LINK2 End_Eff_B)
    (hazard_entg 1 Belly LINK1 14 LINK2 End_Eff_B)
    (hazard_entg 1 Pelvis LINK1 14 LINK2 End_Eff_B)

    (hazard_entg 1 Upper_Arm LINK1 15 LINK2 End_Eff_B)
    (hazard_entg 1 Hand LINK1 15 LINK2 End_Eff_B)
    (hazard_entg 1 Lower_Arm LINK1 15 LINK2 End_Eff_B)


    (hazard_entg 1 Neck LINK2 16 LINK1 End_Eff_B)
    (hazard_entg 1 Head LINK2 16 LINK1 End_Eff_B)
    (hazard_entg 1 shoulders LINK2 16 LINK1 End_Eff_B)

    (hazard_entg 1 Chest LINK2 17 LINK1 End_Eff_B)
    (hazard_entg 1 Belly LINK2 17 LINK1 End_Eff_B)
    (hazard_entg 1 Pelvis LINK2 17 LINK1 End_Eff_B)

    (hazard_entg 1 Upper_Arm LINK2 18 LINK1 End_Eff_B)
    (hazard_entg 1 Hand LINK2 18 LINK1 End_Eff_B)
    (hazard_entg 1 Lower_Arm LINK2 18 LINK1 End_Eff_B)
     )))
