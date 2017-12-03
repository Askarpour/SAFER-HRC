
  (defvar notcall 0)
  (defvar exetime 1)
  ; things to export
  (defvar Threshold 2)
  (define-tvar Risk *int*) ;;max risk in the system  

  
  

(load "ORL-Module/L.lisp")
(load "ORL-Module/O.lisp")
(load "ORL-Module/R.lisp")

  (load "Hazards.lisp")
  (load "RRM.lisp")
  (load "REs.lisp")
  (load "REv.lisp")
  ; (load "TaskLib/fcm.lisp") ;<-************************



(defun mutually_exclusive (str1 str2 str3 str4 str5 str6 str7 index Tname)
  (eval (list `alwf (append `(&&)
   (loop for i in index collect
   `(&&
    (<->
      (-P- ,(read-from-string (format nil "~A_~A_~A" str1 i Tname))) 
      (&&
        (!! (-P- ,(read-from-string (format nil "~A_~A_~A" str2 i Tname))))
        (!! (-P- ,(read-from-string (format nil "~A_~A_~A" str3 i Tname))))
        (!! (-P- ,(read-from-string (format nil "~A_~A_~A" str4 i Tname))))
        (!! (-P- ,(read-from-string (format nil "~A_~A_~A" str5 i Tname))))
        (!! (-P- ,(read-from-string (format nil "~A_~A_~A" str6 i Tname))))
        (!! (-P- ,(read-from-string (format nil "~A_~A_~A" str7 i Tname))))))))))))

(defun SeqAction (index Tname)
 (eval (list `alwf (append `(&&)
  (loop for i in index collect
   `(&&
    ; ([=](-V- ,(read-from-string (format nil "Action_Time_~A_~A" i Tname))) 1)
     ;each action is done either by op or ro
    (<->(-P- ,(read-from-string (format nil "Action_Doer_ro_~A_~A" i Tname))) (!!(-P- ,(read-from-string (format nil "Action_Doer_op_~A_~A" i Tname)))))

     ;op either starts or stops
    (!! (&& (-P- ,(read-from-string (format nil "Op_starts_~A_~A" i Tname))) (-P- ,(read-from-string (format nil "Op_stops_~A_~A" i Tname)))))

    ; op can start or stop only when in position
    (-> (-P- ,(read-from-string (format nil "Op_starts_~A_~A" i Tname))) (-P- ,(read-from-string (format nil "Action_Pre_L_~A_~A" i Tname))))
    (->  (-P- ,(read-from-string (format nil "Op_stops_~A_~A" i Tname))) (-P- ,(read-from-string (format nil "Action_Post_L_~A_~A" i Tname))))

    ;op can stop only if he started within past exetime units
    (->  (-P- ,(read-from-string (format nil "Op_stops_~A_~A" i Tname))) (withinP (-P- ,(read-from-string (format nil "Op_starts_~A_~A" i Tname))) exetime))
    
     ;robot actions do not have waiting state
    (->(-P- ,(read-from-string (format nil "Action_Doer_ro_~A_~A" i Tname)))(Alwf(!! (-P- ,(read-from-string (format nil "Action_State_wt_~A_~A" i Tname)))) ))
     
     ;ns
    (->
      (-P- ,(read-from-string (format nil "Action_State_ns_~A_~A" i Tname)))
      (&&
        (alwp (||(-P- ,(read-from-string (format nil "Action_State_ns_~A_~A" i Tname)))(-P- ,(read-from-string (format nil "Action_State_wt_~A_~A" i Tname)))))
        (!! (-P- ,(read-from-string (format nil "Action_Pre_~A_~A" i Tname))))))

    ;waiting
    (->
      (-P- ,(read-from-string (format nil "Action_State_wt_~A_~A" i Tname)))
      (&& 
        (-P- ,(read-from-string (format nil "Action_Doer_op_~A_~A" i Tname))) 
        (-P- ,(read-from-string (format nil "Action_Pre_~A_~A" i Tname)))
        (!!(-P- ,(read-from-string (format nil "Op_starts_~A_~A" i Tname))))
        (alwp (||(-P- ,(read-from-string (format nil "Action_State_ns_~A_~A" i Tname)))(-P- ,(read-from-string (format nil "Action_State_wt_~A_~A" i Tname))))) 
        (next (|| 
          (-P- ,(read-from-string (format nil "Action_State_ns_~A_~A" i Tname)))
          (-P- ,(read-from-string (format nil "Action_State_wt_~A_~A" i Tname)))
          (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" i Tname))) 
          (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" i Tname)))
        ))))

    ;exe
    (->
      (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" i Tname)))
      (&& 
        (!! (-P- ,(read-from-string (format nil "Action_Post_~A_~A" i Tname))))
        ; (-P- no_RRM)
        (!! (-P- hold))
        ([<] (-V- Risk) Threshold)
        (alwp(&&
          (!! (-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" i Tname))))
          (!! (-P- ,(read-from-string (format nil "Action_State_ex_~A_~A" i Tname))))
          ))
        (alwF(&&
          (!! (-P- ,(read-from-string (format nil "Action_State_ns_~A_~A" i Tname))))
          (!! (-P- ,(read-from-string (format nil "Action_State_wt_~A_~A" i Tname))))
          ))
        (||
          (&&( Yesterday(-P- ,(read-from-string (format nil "Action_State_wt_~A_~A" i Tname)))) (-P- ,(read-from-string (format nil "Action_Pre_~A_~A" i Tname))) (-P- ,(read-from-string (format nil "Op_starts_~A_~A" i Tname))))
          (&& (Yesterday(-P- ,(read-from-string (format nil "Action_State_ns_~A_~A" i Tname))) ) (-P- ,(read-from-string (format nil "Action_Pre_~A_~A" i Tname))) (-P- ,(read-from-string (format nil "Action_Doer_op_~A_~A" i Tname)))  (-P- ,(read-from-string (format nil "Op_starts_~A_~A" i Tname))))
          (Yesterday(-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" i Tname))))
          (Yesterday(-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" i Tname))))
          (&&(Yesterday(-P- ,(read-from-string (format nil "Action_State_ns_~A_~A" i Tname)))) (-P- ,(read-from-string (format nil "Action_Pre_~A_~A" i Tname))) (-P- ,(read-from-string (format nil "Action_Doer_ro_~A_~A" i Tname))) )
          (Yesterday(-P- ,(read-from-string (format nil "Action_State_hd_~A_~A" i Tname))))
        )))

    ;exrm
    (->
      (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" i Tname)))
      (&& 
        (!! (-P- ,(read-from-string (format nil "Action_Post_~A_~A" i Tname))))
        ; (!! (-P- no_RRM)) 
        (!! (-P- hold))
        ([=] (-V- Risk) Threshold)
        (alwp(&&
          (!! (-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" i Tname))))
          (!! (-P- ,(read-from-string (format nil "Action_State_ex_~A_~A" i Tname))))
          ))
        (alwF(&&
          (!! (-P- ,(read-from-string (format nil "Action_State_ns_~A_~A" i Tname))))
          (!! (-P- ,(read-from-string (format nil "Action_State_wt_~A_~A" i Tname))))
          ))
        (||
          (&&( Yesterday(-P- ,(read-from-string (format nil "Action_State_wt_~A_~A" i Tname)))) (-P- ,(read-from-string (format nil "Action_Pre_~A_~A" i Tname))) (-P- ,(read-from-string (format nil "Op_starts_~A_~A" i Tname))))
          (&& (Yesterday(-P- ,(read-from-string (format nil "Action_State_ns_~A_~A" i Tname))) ) (-P- ,(read-from-string (format nil "Action_Pre_~A_~A" i Tname))) (-P- ,(read-from-string (format nil "Action_Doer_op_~A_~A" i Tname)))  (-P- ,(read-from-string (format nil "Op_starts_~A_~A" i Tname))))
          (Yesterday(-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" i Tname))))
          (Yesterday(-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" i Tname))))
          (&&(Yesterday(-P- ,(read-from-string (format nil "Action_State_ns_~A_~A" i Tname)))) (-P- ,(read-from-string (format nil "Action_Pre_~A_~A" i Tname))) (-P- ,(read-from-string (format nil "Action_Doer_ro_~A_~A" i Tname))) )
          (Yesterday(-P- ,(read-from-string (format nil "Action_State_hd_~A_~A" i Tname))))
        )))

    ;hold
    (->
      (-P- ,(read-from-string (format nil "Action_State_hd_~A_~A" i Tname)))
      (&& 
        (alwF(&&
          (!! (-P- ,(read-from-string (format nil "Action_State_ns_~A_~A" i Tname))))
          (!! (-P- ,(read-from-string (format nil "Action_State_wt_~A_~A" i Tname))))
          ))
        (-P- hold) 
        (alwp(&&
          (!! (-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" i Tname))))
          (!! (-P- ,(read-from-string (format nil "Action_State_ex_~A_~A" i Tname))))
          ))
        (Yesterday (!! (|| (-P- ,(read-from-string (format nil "Action_State_ns_~A_~A" i Tname))) (-P- ,(read-from-string (format nil "Action_State_wt_~A_~A" i Tname))) (-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" i Tname))))))
        ; ([<] (-V- Risk) 2)
      )
    )

    ; done
    (->
      (-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" i Tname))) 
      (&& 
        (alwf (-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" i Tname))))
        (SomP ( || (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" i Tname))) (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" i Tname)))))
       (|| 
        (Yesterday(-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" i Tname)))) 
        (&& (Yesterday(-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" i Tname)))) (-P- ,(read-from-string (format nil "Action_Post_~A_~A" i Tname))))
        (&& (Yesterday(-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" i Tname)))) (-P- ,(read-from-string (format nil "Action_Post_~A_~A" i Tname))))
        )
       (SomP 
       (lasted (|| (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" i Tname))) (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" i Tname)))) exetime)
       )
      )
    )

    ;exit
    (->
      (-P- ,(read-from-string (format nil "Action_State_ex_~A_~A" i Tname)))
      (&& 
        (alwf (-P- ,(read-from-string (format nil "Action_State_ex_~A_~A" i Tname)))) 
        (|| 
          (Yesterday(-P- ,(read-from-string (format nil "Action_State_ex_~A_~A" i Tname))) )
          (-P- safety-property)
          )))

    (<->
      (-P- safety-property)
      (&& ([=] (-V- Risk) Threshold) (Yesterday ([<] (-V- Risk) Threshold))))

    ))))))

(defun op_limit_helper (action_id1 action_id2 index Tname)
  (eval (list `alwf (append `(&&)
    (loop for i in index collect
      `(->
          (&&
             (|| (-P- ,(read-from-string (format nil "Op_starts_~A_~A" action_id1 Tname))) (-P- ,(read-from-string (format nil "Op_stops_~A_~A" action_id1 Tname))))
             (|| (-P- ,(read-from-string (format nil "Op_starts_~A_~A" action_id2 Tname))) (-P- ,(read-from-string (format nil "Op_stops_~A_~A" action_id2 Tname))))
             ; (-P- ,(read-from-string (format nil "Op_starts_~A_~A" action_id1 Tname)))
             ; (-P- ,(read-from-string (format nil "Op_starts_~A_~A" action_id2 Tname)))
             (!! ([=] ,(read-from-string (format nil "~A" action_id1)) ,(read-from-string (format nil "~A" action_id2)))))
          (||
             ([=] ,(read-from-string (format nil "~A" i)) ,(read-from-string (format nil "~A" action_id1)))
             ([=] ,(read-from-string (format nil "~A" i)) ,(read-from-string (format nil "~A" action_id2)))
             (!! (-P- ,(read-from-string (format nil "Action_Doer_op_~A_~A" i Tname))))
             (!!(|| (-P- ,(read-from-string (format nil "Op_starts_~A_~A" action_id1 Tname))) (-P- ,(read-from-string (format nil "Op_stops_~A_~A" action_id1 Tname))))))
  ))))))

(defun op_limit_helper2 (action_id1 index  Tname)
 (eval (list `alwf (append `(&&)
    (loop for i in index collect
      `(&&
        (op_limit_helper ,(read-from-string (format nil "~A" action_id1)) ,(read-from-string (format nil "~A" i)) ,(read-from-string (format nil "'~A" index)) ,(read-from-string (format nil "~A" Tname)))))))))

(defun limiting_op_actions (index  Tname)
 ;only two operator actions concurrently execute
 (eval (list `alwf (append `(&&)
    (loop for i in index collect
        `(op_limit_helper2 ,(read-from-string (format nil "~A" i)) ,(read-from-string (format nil "'~A" index)) ,(read-from-string (format nil "~A" Tname))))))))

(defun ro_limit_helper (action_id1 index Tname)
  (eval (append `(&&)
    (loop for i in index collect
      `(->
         (&& (-P- ,(read-from-string (format nil "Action_Doer_ro_~A_~A" action_id1 Tname))) (|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" action_id1 Tname))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" action_id1 Tname)))))
         (|| (!! (|| (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" i Tname))) (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" i Tname))))) 
          ([=] ,(read-from-string (format nil "~A" i)) ,(read-from-string (format nil "~A" action_id1))))
         ; (|| ([=] ,(read-from-string (format nil "~A" i)) ,(read-from-string (format nil "~A" action_id1))) 
         ;  (!! (|| (-P- ,(read-from-string (format nil "Op_starts_~A_~A" action_id1 Tname))) (-P- ,(read-from-string (format nil "Op_stops_~A_~A" action_id1 Tname))))) )
  )))))

(defun limiting_ro_actions (index Tname)
  ;;only one ro action at a time
  (eval (list `alwf (append `(&&)
    (loop for i in index collect
         `(ro_limit_helper ,(read-from-string (format nil "~A" i)) ,(read-from-string (format nil "'~A" index)) ,(read-from-string (format nil "~A" Tname))))))))

(defun reset_actions (index Tname)
 (eval (append `(&&)
   (loop for i in index collect `(&&
    (-P- ,(read-from-string (format nil "Action_State_ns_~A_~A" i Tname))))))))
   
(defun op_idle (index Tname)
  (eval (append `(&&)
   (loop for i in index collect `(&&
    (!! (-P- ,(read-from-string (format nil "Op_starts_~A_~A" i Tname))))
    (!! (-P- ,(read-from-string (format nil "Op_stops_~A_~A" i Tname))))
    )))))
