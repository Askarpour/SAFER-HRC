(defvar notcall 0)
(defvar exetime 1)
; things to export
(defvar Threshold 2)

(load "ORL-Module/L.lisp")
(load "ORL-Module/O.lisp")
(load "ORL-Module/R.lisp")

(load "Hazards.lisp")
(load "RRM.lisp")
(load "REs.lisp")
(load "REv.lisp")
; (load "TaskLib/fcm.lisp") ;<-************************



(defun mutually_exclusive (str1 str2 str3 str4 str5 str6 index Tname)
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
        ))))))))

(defun SeqAction (index Tname)
 (eval (list `alwf (append `(&&)
  (loop for i in index collect
   `(&&
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
    (<->
      (-P- ,(read-from-string (format nil "Action_State_ns_~A_~A" i Tname)))
      (&&
        (alwp (||(-P- ,(read-from-string (format nil "Action_State_ns_~A_~A" i Tname)))(-P- ,(read-from-string (format nil "Action_State_wt_~A_~A" i Tname)))))
        (!! (-P- ,(read-from-string (format nil "Action_Pre_~A_~A" i Tname))))))

    ;waiting
    (<->
      (-P- ,(read-from-string (format nil "Action_State_wt_~A_~A" i Tname)))
      (&& 
        (-P- ,(read-from-string (format nil "Action_Doer_op_~A_~A" i Tname))) 
        (-P- ,(read-from-string (format nil "Action_Pre_~A_~A" i Tname)))
        (!!(-P- ,(read-from-string (format nil "Op_starts_~A_~A" i Tname))))
        (alwp (||(-P- ,(read-from-string (format nil "Action_State_ns_~A_~A" i Tname)))(-P- ,(read-from-string (format nil "Action_State_wt_~A_~A" i Tname))))) 
        (next (|| 
          (-P- ,(read-from-string (format nil "Action_State_wt_~A_~A" i Tname)))
          (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" i Tname))) 
          (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" i Tname)))
        ))))

    ;exe
    (<->
      (-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" i Tname)))
      (&& 
        (!! (-P- ,(read-from-string (format nil "Action_Post_~A_~A" i Tname))))
        (-P- no_RRM)
        (!! (-P- hold))
        (alwp(&&
          (!! (-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" i Tname))))
          ))
        (alwF(&&
          (!! (-P- ,(read-from-string (format nil "Action_State_ns_~A_~A" i Tname))))
          (!! (-P- ,(read-from-string (format nil "Action_State_wt_~A_~A" i Tname))))
          ))
        (||
          (Yesterday (&& (-P- ,(read-from-string (format nil "Action_State_wt_~A_~A" i Tname))) (-P- ,(read-from-string (format nil "Action_Pre_~A_~A" i Tname)))))
          (Yesterday(-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" i Tname))))
          (Yesterday(-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" i Tname))))
          (&&(Yesterday(-P- ,(read-from-string (format nil "Action_State_ns_~A_~A" i Tname)))) (-P- ,(read-from-string (format nil "Action_Pre_~A_~A" i Tname))) (-P- ,(read-from-string (format nil "Action_Doer_ro_~A_~A" i Tname))) )
          (Yesterday(-P- ,(read-from-string (format nil "Action_State_hd_~A_~A" i Tname))))
        )
        ))

    ;exrm
    (<->
      (-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" i Tname)))
      (&& 
        (!! (-P- ,(read-from-string (format nil "Action_Post_~A_~A" i Tname))))
        (!! (-P- no_RRM)) 
        (!! (-P- hold))
        (alwp(&&
          (!! (-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" i Tname))))
          ))
        (alwF(&&
          (!! (-P- ,(read-from-string (format nil "Action_State_ns_~A_~A" i Tname))))
          (!! (-P- ,(read-from-string (format nil "Action_State_wt_~A_~A" i Tname))))
          ))
        (||
          (Yesterday (&& (-P- ,(read-from-string (format nil "Action_State_wt_~A_~A" i Tname))) (-P- ,(read-from-string (format nil "Action_Pre_~A_~A" i Tname)))))
          (Yesterday(-P- ,(read-from-string (format nil "Action_State_exe_~A_~A" i Tname))))
          (Yesterday(-P- ,(read-from-string (format nil "Action_State_exrm_~A_~A" i Tname))))
          (&&(Yesterday(-P- ,(read-from-string (format nil "Action_State_ns_~A_~A" i Tname)))) (-P- ,(read-from-string (format nil "Action_Pre_~A_~A" i Tname))) (-P- ,(read-from-string (format nil "Action_Doer_ro_~A_~A" i Tname))) )
          (Yesterday(-P- ,(read-from-string (format nil "Action_State_hd_~A_~A" i Tname))))
        )
      ))

    ;hold
    (<->
      (-P- ,(read-from-string (format nil "Action_State_hd_~A_~A" i Tname)))
      (&& 
        (alwF(&&
          (!! (-P- ,(read-from-string (format nil "Action_State_ns_~A_~A" i Tname))))
          (!! (-P- ,(read-from-string (format nil "Action_State_wt_~A_~A" i Tname))))
          ))
        (-P- hold) 
        (alwp(&&
          (!! (-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" i Tname))))
          ))
        (Yesterday (!! (|| (-P- ,(read-from-string (format nil "Action_State_ns_~A_~A" i Tname))) (-P- ,(read-from-string (format nil "Action_State_wt_~A_~A" i Tname))) (-P- ,(read-from-string (format nil "Action_State_dn_~A_~A" i Tname))))))
      )
    )

    ; done
    (<->
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

    (<->
      (-P- safety-property)
      (&& (Risk= Threshold) (Yesterday (Risk= Threshold))))

    ))))))

(defun reset_actions (index Tname)
 (eval (append `(&&)
   (loop for i in index collect `(&&
    (-P- ,(read-from-string (format nil "Action_State_ns_~A_~A" i Tname))))))))
   
