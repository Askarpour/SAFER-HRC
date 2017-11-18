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

(defun hazard_hit (bodypart robotpart hazard_id other_robotpart_1 other_robotpart_2)
 (eval`(&&
    (<->
        (-P- ,(read-from-string (format nil "Hazard_occured_~A" hazard_id))) 
        (&&
            ([=](-V- ,(with-input-from-string (in (format nil "Body_Part_pos ~a" bodypart)) (loop for x = (read in nil nil) while x collect x))) (first(-V- ,(with-input-from-string (in (format nil "~D_Position" robotpart)) (loop for x = (read in nil nil) while x collect x)))))
            (-P- ,(read-from-string (format nil "~D_Moving" robotpart))) 
            (!!
                (||
                    ; ([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos ~a" bodypart)) (loop for x = (read in nil nil) while x collect x))) L_1_2)
                    ; ([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos ~a" bodypart)) (loop for x = (read in nil nil) while x collect x))) L_1_3)
                    (-P- occluded)
                    ;;ocluded area 
                   
                    ([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos ~a" bodypart)) (loop for x = (read in nil nil) while x collect x))) (first(-V- ,(with-input-from-string (in (format nil "~D_Position" other_robotpart_1)) (loop for x = (read in nil nil) while x collect x)))) )
                    ([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos ~a" bodypart)) (loop for x = (read in nil nil) while x collect x))) (first(-V- ,(with-input-from-string (in (format nil "~D_Position" other_robotpart_2)) (loop for x = (read in nil nil) while x collect x)))))
                )
            )  
        )
    )
    ([=](first(-V- ,(with-input-from-string (in (format nil "Hazard_Reg_~A" hazard_id)) (loop for x = (read in nil nil) while x collect x)))) (first(-V- ,(with-input-from-string (in (format nil "~D_Position" robotpart)) (loop for x = (read in nil nil) while x collect x)))))
    )))

(defun hazard_entg (bodypart robotpart hazard_id other_robotpart_1 other_robotpart_2)
 (eval
   `(&&
    (<->
        (-P- ,(read-from-string (format nil "Hazard_occured_~A" hazard_id))) 
        (&& 
            ([=]
                (-V- ,(with-input-from-string (in (format nil "Body_Part_pos ~a" bodypart)) (loop for x = (read in nil nil) while x collect x)))
                (first(-V- ,(with-input-from-string (in (format nil "~D_Position" robotpart)) (loop for x = (read in nil nil) while x collect x))))
            )
            (||
                ; ([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos ~a" bodypart)) (loop for x = (read in nil nil) while x collect x))) L_1_2)
                ; ([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos ~a" bodypart)) (loop for x = (read in nil nil) while x collect x))) L_1_3)
                (-P- occluded)
                
                (&&
                    ([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos ~a" bodypart)) (loop for x = (read in nil nil) while x collect x))) (first(-V- ,(with-input-from-string (in (format nil "~D_Position" other_robotpart_1)) (loop for x = (read in nil nil) while x collect x))))) 
                    (-P- ,(read-from-string (format nil "~D_Moving" other_robotpart_1))) 
                )

                (&&
                    ([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos ~a" bodypart)) (loop for x = (read in nil nil) while x collect x))) (first(-V- ,(with-input-from-string (in (format nil "~D_Position" other_robotpart_2)) (loop for x = (read in nil nil) while x collect x)))) )
                    (-P- ,(read-from-string (format nil "~D_Moving" other_robotpart_2))) 
                )                        
            )
            (||
                (-P- ,(read-from-string (format nil "~D_Moving" robotpart))) 
                (!!([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos ~a" bodypart)) (loop for x = (read in nil nil) while x collect x))) (Yesterday (-V- ,(with-input-from-string (in (format nil "Body_Part_pos ~a" bodypart)) (loop for x = (read in nil nil) while x collect x))))))
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
    (hazard_hit Neck End_Eff_B 1 LINK1 LINK2)
    (hazard_hit Head End_Eff_B 1 LINK1 LINK2)
    (hazard_hit shoulders End_Eff_B 1 LINK1 LINK2)

    (hazard_hit Chest End_Eff_B 2 LINK1 LINK2)
    (hazard_hit Belly End_Eff_B 2 LINK1 LINK2)
    (hazard_hit Pelvis End_Eff_B 2 LINK1 LINK2)

    (hazard_hit Upper_Arm End_Eff_B 3 LINK1 LINK2)
    (hazard_hit Hand End_Eff_B 3 LINK1 LINK2)
    (hazard_hit Lower_Arm End_Eff_B 3 LINK1 LINK2)


    (hazard_hit Neck LINK1 4 LINK2 End_Eff_B)
    (hazard_hit Head LINK1 4 LINK2 End_Eff_B)
    (hazard_hit shoulders LINK1 4 LINK2 End_Eff_B)

    (hazard_hit Chest LINK1 5 LINK2 End_Eff_B)
    (hazard_hit Belly LINK1 5 LINK2 End_Eff_B)
    (hazard_hit Pelvis LINK1 5 LINK2 End_Eff_B)

    (hazard_hit Upper_Arm LINK1 6 LINK2 End_Eff_B)
    (hazard_hit Hand LINK1 6 LINK2 End_Eff_B)
    (hazard_hit Lower_Arm LINK1 6 LINK2 End_Eff_B)


    (hazard_hit Neck LINK2 7 LINK1 End_Eff_B)
    (hazard_hit Head LINK2 7 LINK1 End_Eff_B)
    (hazard_hit shoulders LINK2 7 LINK1 End_Eff_B)

    (hazard_hit Chest LINK2 8 LINK1 End_Eff_B)
    (hazard_hit Belly LINK2 8 LINK1 End_Eff_B)
    (hazard_hit Pelvis LINK2 8 LINK1 End_Eff_B)

    (hazard_hit Upper_Arm LINK2 9 LINK1 End_Eff_B)
    (hazard_hit Hand LINK2 9 LINK1 End_Eff_B)
    (hazard_hit Lower_Arm LINK2 9 LINK1 End_Eff_B)


    ;;*** entanglements
    (hazard_entg Neck End_Eff_B 10 LINK2 LINK1)
    (hazard_entg Head End_Eff_B 10 LINK2 LINK1)
    (hazard_entg shoulders End_Eff_B 10 LINK2 LINK1)

    (hazard_entg Chest End_Eff_B 11 LINK2 LINK1)
    (hazard_entg Belly End_Eff_B 11 LINK2 LINK1)
    (hazard_entg Pelvis End_Eff_B 11 LINK2 LINK1)

    (hazard_entg Upper_Arm End_Eff_B 12 LINK2 LINK1)
    (hazard_entg Hand End_Eff_B 12 LINK2 LINK1)
    (hazard_entg Lower_Arm End_Eff_B 12 LINK2 LINK1)


    (hazard_entg Neck LINK1 13 LINK2 End_Eff_B)
    (hazard_entg Head LINK1 13 LINK2 End_Eff_B)
    (hazard_entg shoulders LINK1 13 LINK2 End_Eff_B)

    (hazard_entg Chest LINK1 14 LINK2 End_Eff_B)
    (hazard_entg Belly LINK1 14 LINK2 End_Eff_B)
    (hazard_entg Pelvis LINK1 14 LINK2 End_Eff_B)

    (hazard_entg Upper_Arm LINK1 15 LINK2 End_Eff_B)
    (hazard_entg Hand LINK1 15 LINK2 End_Eff_B)
    (hazard_entg Lower_Arm LINK1 15 LINK2 End_Eff_B)


    (hazard_entg Neck LINK2 16 LINK1 End_Eff_B)
    (hazard_entg Head LINK2 16 LINK1 End_Eff_B)
    (hazard_entg shoulders LINK2 16 LINK1 End_Eff_B)

    (hazard_entg Chest LINK2 17 LINK1 End_Eff_B)
    (hazard_entg Belly LINK2 17 LINK1 End_Eff_B)
    (hazard_entg Pelvis LINK2 17 LINK1 End_Eff_B)

    (hazard_entg Upper_Arm LINK2 18 LINK1 End_Eff_B)
    (hazard_entg Hand LINK2 18 LINK1 End_Eff_B)
    (hazard_entg Lower_Arm LINK2 18 LINK1 End_Eff_B)
     )))
