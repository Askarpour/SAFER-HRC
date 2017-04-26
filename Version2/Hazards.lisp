;;Hazards

(define-tvar hazards *int* *int* *int*)
(defvar hazards-indexes (loop for i from 1 to 15 collect i))


;; Hazrads Parameters

    ; hazards(i 0) --> 0/1 origin exists or no. we assume that each hazard associates with a pair of (origin, consequence) in table A.1 of ISO10218
    ; hazrads(i 1) -->(Av+Fr+Pr)
    ; hazrads(i 2) --> Consequence: impact (1) / entanglement (2)
    ; hazrads(i 3) --> severity
    ; hazrads(i 4) --> risk
    ; hazrads(i 5) --> layout region where the hazard happens
    (defvar impact 1)
    (defvar entanglement 2)

(defconstant *HazardsInit*
 ;;initialization of existance and (Av+Fr+Pr)

    (-A- i hazards-indexes
            (alw
                    (&&

                            ([>=] (-V- hazards i 0) 0)
                            ([<=] (-V- hazards i 0) 1)

                            ([>=] (-V- hazards i 1) 1)
                            ([<=] (-V- hazards i 1) 16)

                            ;;temp
                            ([=] (-V- hazards i 1) 9)

                            (-> ([<=] i 9) ([=] (-V- hazards i 2) impact))
                            (-> ([>] i 9) ([=] (-V- hazards i 2) entanglement))

                            ([>=] (-V- hazards i 3) 1)
                            ([<=] (-V- hazards i 3) 4)

                            ([>=] (-V- hazards i 4) 0)
                            ([<=] (-V- hazards i 4) 2)

                            ([>=] (-V- hazards i 5) 0)
                            ([<=] (-V- hazards i 5) 11)

                    )
            )

    )
)


;;two types of hazards are considered : impact    entangled
;;The origin of each of these two can happen by a point of robot, except that end-eff cannot entangle anything, so in total we have 5 category of hazards.
;;then we consider 3 body-parts category: head and shoulders(1,2,10) waist-part(3,4,5) hands and arms(6,7,11)
;;and so we study 15 hazards in fact.

(defun hazard_hit (bodypart robotpart hazard_id other_robotpart_1 other_robotpart_2)
 (eval
   `(<->
        ([=] (-V- ,(with-input-from-string (in (format nil "hazards ~a ~a" hazard_id 0)) (loop for x = (read in nil nil) while x collect x))) 1)
        (&& 
            ([=]
                (-V- ,(with-input-from-string (in (format nil "Body_Part_pos ~a" bodypart)) (loop for x = (read in nil nil) while x collect x)))
                (-V- ,(with-input-from-string (in (format nil "~D_Position" robotpart)) (loop for x = (read in nil nil) while x collect x)))
            )
            
            (|| 
                (-P- ,(read-from-string (format nil "~D_Moving" robotpart))) 
                ([=]
                    (-V- ,(with-input-from-string (in (format nil "Body_Part_pos ~a" bodypart)) (loop for x = (read in nil nil) while x collect x)))
                    (Yesterday (-V- ,(with-input-from-string (in (format nil "Body_Part_pos ~a" bodypart)) (loop for x = (read in nil nil) while x collect x))))
                )
            )
            (!!
                (||
                    ([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos ~a" bodypart)) (loop for x = (read in nil nil) while x collect x))) L_1_2)
                    ([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos ~a" bodypart)) (loop for x = (read in nil nil) while x collect x))) L_1_3)
                    ;;ocluded area 
                   
                    ([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos ~a" bodypart)) (loop for x = (read in nil nil) while x collect x))) (-V- ,(with-input-from-string (in (format nil "~D_Position" other_robotpart_1)) (loop for x = (read in nil nil) while x collect x)))) 
                    ([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos ~a" bodypart)) (loop for x = (read in nil nil) while x collect x))) (-V- ,(with-input-from-string (in (format nil "~D_Position" other_robotpart_2)) (loop for x = (read in nil nil) while x collect x))))
                )
            )  
        )
    )
  )
)


(defun hazard_entg (bodypart robotpart hazard_id other_robotpart_1 other_robotpart_2)
 (eval
   `(<->
        ([=] (-V- ,(with-input-from-string (in (format nil "hazards ~a ~a" hazard_id 0)) (loop for x = (read in nil nil) while x collect x))) 1)
        (&& 
            ([=]
                (-V- ,(with-input-from-string (in (format nil "Body_Part_pos ~a" bodypart)) (loop for x = (read in nil nil) while x collect x)))
                (-V- ,(with-input-from-string (in (format nil "~D_Position" robotpart)) (loop for x = (read in nil nil) while x collect x)))
            )
            (||
                ([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos ~a" bodypart)) (loop for x = (read in nil nil) while x collect x))) L_1_2)
                ([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos ~a" bodypart)) (loop for x = (read in nil nil) while x collect x))) L_1_3)
                
                (&&
                    ([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos ~a" bodypart)) (loop for x = (read in nil nil) while x collect x))) (-V- ,(with-input-from-string (in (format nil "~D_Position" other_robotpart_1)) (loop for x = (read in nil nil) while x collect x)))) 
                    (-P- ,(read-from-string (format nil "~D_Moving" other_robotpart_1))) 
                )

                (&&
                    ([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos ~a" bodypart)) (loop for x = (read in nil nil) while x collect x))) (-V- ,(with-input-from-string (in (format nil "~D_Position" other_robotpart_2)) (loop for x = (read in nil nil) while x collect x)))) 
                    (-P- ,(read-from-string (format nil "~D_Moving" other_robotpart_2))) 
                )                        
            )
            (||
                (-P- ,(read-from-string (format nil "~D_Moving" robotpart))) 
                (!!([=] (-V- ,(with-input-from-string (in (format nil "Body_Part_pos ~a" bodypart)) (loop for x = (read in nil nil) while x collect x))) (Yesterday (-V- ,(with-input-from-string (in (format nil "Body_Part_pos ~a" bodypart)) (loop for x = (read in nil nil) while x collect x))))))
            )
        )
    )
  )
)  

(defconstant *Hazards*
 (&&
        ;;*** hits
    (hazard_hit Neck End_Eff_F 1 LINK1 LINK2)
    (hazard_hit Head End_Eff_F 1 LINK1 LINK2)
    (hazard_hit shoulders End_Eff_F 1 LINK1 LINK2)

    (hazard_hit Chest End_Eff_F 2 LINK1 LINK2)
    (hazard_hit Belly End_Eff_F 2 LINK1 LINK2)
    (hazard_hit Pelvis End_Eff_F 2 LINK1 LINK2)

    (hazard_hit Upper_Arm End_Eff_F 3 LINK1 LINK2)
    (hazard_hit Hand End_Eff_F 3 LINK1 LINK2)
    (hazard_hit Lower_Arm End_Eff_F 3 LINK1 LINK2)


    (hazard_hit Neck LINK1 4 LINK2 End_Eff_F)
    (hazard_hit Head LINK1 4 LINK2 End_Eff_F)
    (hazard_hit shoulders LINK1 4 LINK2 End_Eff_F)

    (hazard_hit Chest LINK1 5 LINK2 End_Eff_F)
    (hazard_hit Belly LINK1 5 LINK2 End_Eff_F)
    (hazard_hit Pelvis LINK1 5 LINK2 End_Eff_F)

    (hazard_hit Upper_Arm LINK1 6 LINK2 End_Eff_F)
    (hazard_hit Hand LINK1 6 LINK2 End_Eff_F)
    (hazard_hit Lower_Arm LINK1 6 LINK2 End_Eff_F)


    (hazard_hit Neck LINK2 7 LINK1 End_Eff_F)
    (hazard_hit Head LINK2 7 LINK1 End_Eff_F)
    (hazard_hit shoulders LINK2 7 LINK1 End_Eff_F)

    (hazard_hit Chest LINK2 8 LINK1 End_Eff_F)
    (hazard_hit Belly LINK2 8 LINK1 End_Eff_F)
    (hazard_hit Pelvis LINK2 8 LINK1 End_Eff_F)

    (hazard_hit Upper_Arm LINK2 9 LINK1 End_Eff_F)
    (hazard_hit Hand LINK2 9 LINK1 End_Eff_F)
    (hazard_hit Lower_Arm LINK2 9 LINK1 End_Eff_F)


    ;;*** entanglements
    (hazard_entg Neck LINK1 10 LINK2 End_Eff_F)
    (hazard_entg Head LINK1 10 LINK2 End_Eff_F)
    (hazard_entg shoulders LINK1 10 LINK2 End_Eff_F)

    (hazard_entg Chest LINK1 11 LINK2 End_Eff_F)
    (hazard_entg Belly LINK1 11 LINK2 End_Eff_F)
    (hazard_entg Pelvis LINK1 11 LINK2 End_Eff_F)

    (hazard_entg Upper_Arm LINK1 12 LINK2 End_Eff_F)
    (hazard_entg Hand LINK1 12 LINK2 End_Eff_F)
    (hazard_entg Lower_Arm LINK1 12 LINK2 End_Eff_F)


    (hazard_entg Neck LINK2 13 LINK1 End_Eff_F)
    (hazard_entg Head LINK2 13 LINK1 End_Eff_F)
    (hazard_entg shoulders LINK2 13 LINK1 End_Eff_F)

    (hazard_entg Chest LINK2 14 LINK1 End_Eff_F)
    (hazard_entg Belly LINK2 14 LINK1 End_Eff_F)
    (hazard_entg Pelvis LINK2 14 LINK1 End_Eff_F)

    (hazard_entg Upper_Arm LINK2 15 LINK1 End_Eff_F)
    (hazard_entg Hand LINK2 15 LINK1 End_Eff_F)
    (hazard_entg Lower_Arm LINK2 15 LINK1 End_Eff_F)


    (-A- i hazards-indexes

        (->
            ([=] (-V- hazards i 0) 1)
            (&&
                (->
                        (&& ([>=] i 13) ([<] i 15))
                        ([=] (-V- hazards i 5) (-V- LINK2_Position))
                )

                (->
                        (&& ([>=] i 10) ([<=] i 12))
                        ([=] (-V- hazards i 5) (-V- LINK1_Position))
                )

                (->
                        (&&([>=] i 7) ([<=] i 9))
                        ([=] (-V- hazards i 5) (-V- LINK2_Position))
                )

                (->
                        (&& ([>=] i 4) ([<=] i 6))
                        ([=] (-V- hazards i 5) (-V- LINK1_Position))
                )

                (->
                        (&& ([>=] i 1) ([<=] i 3))
                        ([=] (-V- hazards i 5) (-V- End_Eff_F_Position))
                )
            )
        )
    )

    )
)
