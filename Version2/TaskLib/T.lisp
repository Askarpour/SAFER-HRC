
;;requirements
  (defvar jigs 1)
  (defvar notcall 0)
  (defvar jigs_indexes (loop for i from 0 to (- jigs 1) collect i))
  (defvar body_indexes (loop for i from 1 to 11 collect i))
  (defvar actions1-indexes (loop for i from 1 to (+ 8 (* 6 jigs)) collect i))
  (defvar T1 1)
  (defvar actions2-indexes (loop for i from 1 to 8 collect i))
  (defvar T2 2)
  (defvar actions3-indexes (loop for i from 1 to 2 collect i))
  (defvar T3 3)
  (defvar actions4-indexes (loop for i from 1 to 2 collect i))
  (defvar T4 4)
  (defvar err-phenotype-indexes (loop for i from 1 to 5 collect i))

  (load "ORL-Module/L.lisp")
  (load "ORL-Module/O.lisp")
  (load "ORL-Module/R.lisp")
  (load "Hazards.lisp")
  (load "RRM.lisp")
  (load "REs.lisp")
  (load "REv.lisp")

;; Task Parameters
  ; actions(i 1 l) -->status
  ; actions(i 2 l) -->exeTime
  ; actions(i 3 l) -->subject
  ; actions(i 4 l) -->erroneous/normative

  (define-tvar actions *int* *int* *int* *int*)
  (define-tvar Action_Pre *int* *int* *int*)
  (define-tvar Action_Pre_L *int* *int* *int*)
  (define-tvar Action_Post *int* *int* *int*)
  (define-tvar Action_Post_L *int* *int* *int*)
  (define-tvar safe_L *int* *int* *int*)

  ;********************************
  (define-tvar errorA *int* *int* *int* *int*)

  ;; errorA (i,T,k)
  ;; i is action index
  ;; T is task identifier
  ;; k is error phenotype

  (defvar repetition 1)
  (defvar Omission 2)
  (defvar Late 3)
  (defvar early 4)
  (defvar insertion 5)

  (define-tvar errorF *int* *int* *int*)

  (define-tvar errorL *int* *int* *int*)


  (define-tvar OpStarts *int* *int* *int*)
  (define-tvar OpStops *int* *int* *int*)

  ;erroneous state
  (defconstant normative 0)
  (defconstant erroneous 1)

  ;********************************


  ;;Statuses
  (defvar notstarted 0)
  (defvar waiting 1)
  (defvar executing 2)
  (defvar exrm 3)
  (defvar hold 4)
  (defvar done 5)
  (defvar exitt 6)
  (defvar inexitt 7)

  (defvar exetime 3)
  (defvar delta 3) ;;time for op to act

  ;performer identifier

  (defconstant operator 1)
  (defconstant robot 2)


  ; things to export
  (defvar Threshold 2)
  (define-tvar Risk *int*) ;;max risk in the system


(defun SeqAction (index Tname)
  (-A- i index
       ; ([=] (-V- actions i 5 Tname) 0)
       (alw(&&
            ([>=] (-V- actions i 1 Tname) 0)
            ([<=] (-V- actions i 1 Tname) 7)

            ([>=] (-V- Action_Pre i Tname) 0)
            ([<=] (-V- Action_Pre i Tname) 1)

            ([>=] (-V- Action_Pre_L i Tname) 0)
            ([<=] (-V- Action_Pre_L i Tname) 1)

            ([>=] (-V- Action_Post i Tname) 0)
            ([<=] (-V- Action_Post i Tname) 1)

            ([>=] (-V- Action_Post_L i Tname) 0)
            ([<=] (-V- Action_Post_L i Tname) 1)

            ([>=] (-V- safe_L i Tname) 0)
            ([<=] (-V- safe_L i Tname) 1)
         ;;**************************

            ([>=] (-V- OpStarts i Tname) 0)
            ([<=] (-V- OpStarts i Tname) 1)
            (-> ([=](-V- OpStarts i Tname) 1)  ([=] (-V- Action_Pre_L i Tname) 1))

            ([>=] (-V- OpStops i Tname) 0)
            ([<=] (-V- OpStops i Tname) 1)

            ([>=] (-V- actions i 4 Tname) normative)
            ([<=] (-V- actions i 4 Tname) erroneous)

            (-A- x err-phenotype-indexes
              (&&
                ([>=] (-V- errorA i Tname x) 0) ;no error
                ([<=] (-V- errorA i Tname x) 1)))



            ([>=] (-V- errorF i Tname) 0)
            ([>=] (-V- errorL i Tname) 0)


            ([<=] (-V- errorF i Tname) 1)
            ([<=] (-V- errorL i Tname) 1)

         ;;error
            (<->
              ([=] (-V- actions i 4 Tname) erroneous)
              (||
                (-E- x err-phenotype-indexes
                  ([=] (-V- errorA i Tname x) 1))

                ([=] (-V- errorF i Tname) 1)
                ([=] (-V- errorL i Tname) 1)))



    ;;norm
            (<->
              ([=] (-V- actions i 4 Tname) normative)
              (&&
                (-A- x err-phenotype-indexes
                      ([=] (-V- errorA i Tname x) 0))

               ([=] (-V- errorF i Tname) 0)
               ([=] (-V- errorL i Tname) 0)))



            (<->
              ([=] (-V- errorA i Tname repetition) 1)
              (&&
                ([=] (-V- actions i 3 Tname) operator)
                ([=] (-V- actions i 1 Tname) done)
                (||
                  ([=](-V- OpStarts i Tname) 1)
                  (Yesterday
                    (&&
                      ([=](-V- OpStops i Tname) 0)
                      (!! ([=] (-V- actions i 1 Tname) done)))))))






            (<->
              ([=] (-V- errorA i Tname Omission) 1)
              (&&
                ([=] (-V- actions i 3 Tname) operator)
                (AlwF (|| ([=] (-V- actions i 1 Tname) notstarted) ([=] (-V- actions i 1 Tname) waiting)))
                (AlwF ([=](-V- OpStarts i Tname) 0))
                (SomP (Lasted ([=] (-V- actions i 1 Tname) waiting) delta))
                (AlwF ([=] (-V- errorA i Tname Omission) 1))))




            (<->
              ([=] (-V- errorA i Tname Late) 1)
              (&&
                ([=] (-V- actions i 3 Tname) operator)
                (SomP
                  (Lasted
                    (&&
                      ([=] (-V- actions i 1 Tname) waiting)
                      ([=](-V- OpStarts i Tname) 0))

                   delta))

                ([=](-V- OpStarts i Tname) 1)))



            (<->
              ([=] (-V- errorA i Tname early) 1)
              (&&
                ([=] (-V- actions i 3 Tname) operator)
         ; (Next
                ([=] (-V- actions i 1 Tname) notstarted)
           ; )
                ([=](-V- OpStarts i Tname) 1)))



    ;;temp
            (Alwf ([=] (-V- errorA i Tname insertion) 0))

    ; (<->
    ; 	([=] (-V- errorA i Tname insertion) 1)
    ; 	(&&
    ; 		([=] (-V- actions i 3 Tname) operator)
    ; 		([=] (-V- actions i 1 Tname) waiting)
    ; 		(->
    ; 			([=] Tname T1)
    ; 			(||
    ; 				(-E- j actions2-indexes
    ; 					(Yesterday ([=](-V- OpStarts i T2) 1))
    ; 				)

    ; 				(-E- j actions3-indexes
    ; 					(Yesterday ([=](-V- OpStarts i T3) 1))
    ; 				)

    ; 				(-E- j actions4-indexes
    ; 					(Yesterday ([=](-V- OpStarts i T4) 1))
    ; 				)
    ; 			)
    ; 		)
    ; 		(->
    ; 			([=] Tname T2)
    ; 			(||
    ; 				(-E- j actions1-indexes
    ; 					(Yesterday ([=](-V- OpStarts i T1) 1))
    ; 				)

    ; 				(-E- j actions3-indexes
    ; 					(Yesterday ([=](-V- OpStarts i T3) 1))
    ; 				)

    ; 				(-E- j actions4-indexes
    ; 					(Yesterday ([=](-V- OpStarts i T4) 1))
    ; 				)
    ; 			)
    ; 		)
    ; 		(->
    ; 			([=] Tname T3)
    ; 			(||
    ; 				(-E- j actions2-indexes
    ; 					(Yesterday ([=](-V- OpStarts i T2) 1))
    ; 				)

    ; 				(-E- j actions1-indexes
    ; 					(Yesterday ([=](-V- OpStarts i T1) 1))
    ; 				)

    ; 				(-E- j actions4-indexes
    ; 					(Yesterday ([=](-V- OpStarts i T4) 1))
    ; 				)
    ; 			)
    ; 		)
    ; 		(->
    ; 			([=] Tname T4)
    ; 			(||
    ; 				(-E- j actions2-indexes
    ; 					(Yesterday ([=](-V- OpStarts i T2) 1))
    ; 				)

    ; 				(-E- j actions3-indexes
    ; 					(Yesterday ([=](-V- OpStarts i T3) 1))
    ; 				)

    ; 				(-E- j actions1-indexes
    ; 					(Yesterday ([=](-V- OpStarts i T1) 1))
    ; 				)
    ; 			)
    ; 		)
    ; 	)
    ; )

            (->
              ([=] (-V- errorF i Tname) 1)
              (&&
                ([=] (-V- actions i 3 Tname) operator)
                (||
                  ([=] (-V- actions i 1 Tname) executing)
                  ([=] (-V- actions i 1 Tname) exrm))))




            (<->
              ([=] (-V- errorL i Tname) 1)
              (||
                (&&
                  ([=] (-V- safe_L i Tname) 0)
                  ([=] (-V- actions i 3 Tname) operator)
                  (|| ([=] (-V- actions i 1 Tname) exrm) ([=] (-V- actions i 1 Tname) executing)))

             ;;ok
                (&& ([=] (-V- actions i 1 Tname) hold) (Yesterday (&& ([=](-V- OpStops i Tname) 0) (!!([=] (-V- actions i 1 Tname) hold)))))))



    ;;**************************

      ;robot actions do not have waiting state
            (->
              ([=] (-V- actions i 3 Tname) robot)
              (!! ([=] (-V- actions i 1 Tname) 1)))

  ;  		(->
  ;  			(&& ([=] (-V- actions i 3 Tname) robot) (||([=] (-V- actions i 1 Tname) executing) ([=] (-V- actions i 1 Tname) exrm)))
  ;  			(!!(-P- Robot_Idle))
    ; )


      ;;ns
            (<->
                 ([=] (-V- actions i 1 Tname) notstarted)
                 (&&
                  (alwp
                    (||
                     ([=] (-V- actions i 1 Tname) notstarted)
                     ([=] (-V- actions i 1 Tname) waiting)))


                  ([=] (-V- Action_Pre i Tname) 0)
                  (next (|| ([=] (-V- actions i 1 Tname) notstarted) ([=] (-V- actions i 1 Tname) waiting) ([=] (-V- actions i 1 Tname) executing)))))



          ;;ns to exe
            (->
                (&& ([=] (-V- actions i 1 Tname) executing) (Yesterday ([=] (-V- actions i 1 Tname) notstarted)))
                ([=] (-V- Action_Pre i Tname) 1))



            (->
                (&& ([=] (-V- actions i 1 Tname) notstarted) ([=] (-V- actions i 3 Tname) robot) (next ([=] (-V- Action_Pre i Tname) 1)))
                (next ([=] (-V- actions i 1 Tname) executing)))


      ;;waiting
            (->
              ([=] (-V- actions i 1 Tname) waiting)
              (&&
                ([=] (-V- actions i 3 Tname) operator)
          ; (!! (-P- OpActs))
          ; ([=](-V- OpStarts i Tname) 0)
                ([=] (-V- Action_Pre i Tname) 1)
                (alwp (||([=] (-V- actions i 1 Tname) notstarted) ([=] (-V- actions i 1 Tname) waiting)))))



            ;;waiting to ns
            (->
              (&& (Yesterday ([=] (-V- actions i 1 Tname) waiting)) ([=] (-V- actions i 1 Tname) notstarted))
              ([=] (-V- Action_Pre i Tname) 0))



    ;; 		;;waiting to ns
    ;; 		(->
    ;; 			(&& (Yesterday ([=] (-V- actions i 1 Tname) waiting)) ([=] (-V- actions i 1 Tname) notstarted))
    ;; 			(|| ([=] (-V- Action_Pre i Tname) 0) (withinp_ie (!! (-P- OpActs)) delta))

    ;; 		)

    ;; 		(->
    ;; 			(&& ([=] (-V- actions i 1 Tname) waiting) (withinp_ei (!! (-P- OpActs)) delta))
    ;; 			(next ([=] (-V- actions i 1 Tname) notstarted))

    ;; 		)

        ;;ns to waiting
            (->
              (&& (Yesterday([=] (-V- actions i 1 Tname) notstarted)) ([=] (-V- actions i 1 Tname) waiting))
              ([=] (-V- Action_Pre i Tname) 1))



            (->
              (&& (Yesterday ([=] (-V- actions i 1 Tname) notstarted)) ([=] (-V- actions i 3 Tname) operator) ([=] (-V- Action_Pre i Tname) 1))
              ([=] (-V- actions i 1 Tname) waiting))


            (->
              (&& (Yesterday([=] (-V- actions i 1 Tname) notstarted)) ([=] (-V- actions i 3 Tname) robot) ([=] (-V- Action_Pre i Tname) 1))
              ([=] (-V- actions i 1 Tname) executing))


        ;;waiting to exe
            (->
              (&& (Yesterday([=] (-V- actions i 1 Tname) waiting)) ([=] (-V- actions i 1 Tname) executing))
              (&&
                ([=] (-V- Action_Pre i Tname) 1)
            ; (-P- OpActs)
                ([=](-V- OpStarts i Tname) 1)))



            (->
              (&& (Yesterday([=] (-V- actions i 1 Tname) waiting)) ([=] (-V- Action_Pre i Tname) 1)
            ; (-P- OpActs)
                ([=](-V- OpStarts i Tname) 1))

              ([=] (-V- actions i 1 Tname) executing))


      ;;exe
            (->

              ([=] (-V- actions i 1 Tname) executing)
              (&&
                    ([=] (-V- Action_Post i Tname) 0)
                    (!! (-E- k RRM-indexes
                         ([=](-V- RRM k) on)))



                    (next (!!(|| ([=] (-V- actions i 1 Tname) notstarted) ([=] (-V- actions i 1 Tname) waiting))))))


        ;;exe to done
            (->
              (&& (Yesterday ([=] (-V- actions i 1 Tname) executing)) ([=] (-V- actions i 1 Tname) done))
              (&& ([=] (-V- Action_Post i Tname) 1)))
           ; (!! (-E- k RRM-indexes  ([=](-V- RRM k) on)))



            (->
              (&&
               ([=] (-V- actions i 1 Tname) executing) (next (&& ([=] (-V- Action_Post i Tname) 1) (!! (-E- k RRM-indexes  ([=](-V- RRM k) on))))))
              (next ([=] (-V- actions i 1 Tname) done)))


        ;;exe to hold
            (->
              (&&
               ([=] (-V- actions i 1 Tname) executing) ([=] (-V- actions i 3 Tname) robot) (next(-P- hold)))
              (next([=] (-V- actions i 1 Tname) hold)))


        ;;exe to exrm
            (->
              (&& ([=] (-V- actions i 1 Tname) exrm) (Yesterday ([=] (-V- actions i 1 Tname) executing)))
              (&&
                (-E- k RRM-indexes  ([=](-V- RRM k) on))
                (!!(-P- hold))
                ([=] (-V- Action_Post i Tname) 0)))


      ;;exrm

            (->

              ([=] (-V- actions i 1 Tname) exrm)
              (&&
                    ([=] (-V- Action_Post i Tname) 0)
                    (!! (-P- hold))
                    (-E- k RRM-indexes
                        ([=](-V- RRM k) on))

                (next (!!(|| ([=] (-V- actions i 1 Tname) notstarted) ([=] (-V- actions i 1 Tname) waiting))))))



         ;;exrm to exe
            (->
              (&& ([=] (-V- actions i 1 Tname) executing) (Yesterday ([=] (-V- actions i 1 Tname) exrm)))
              (&&
                 ([=] (-V- Action_Post i Tname) 0)
                 (!!
                   (-E- k RRM-indexes
                     ([=](-V- RRM k) on)))))





            (->
              (&& (Yesterday ([=] (-V- actions i 1 Tname) exrm)) ([=] (-V- Action_Post i Tname) 0) (!! (-E- k RRM-indexes ([=](-V- RRM k) on))))
              ([=] (-V- actions i 1 Tname) executing))


        ;;exrm to done
            (->
              (&& ([=] (-V- actions i 1 Tname) done) (Yesterday ([=] (-V- actions i 1 Tname) exrm)))

              (&&  ([=] (-V- Action_Post i Tname) 1) (!!(-E- k RRM-indexes ([=](-V- RRM k) on)))))

        ;;exrm to hold
            (->

              (&&  ([=] (-V- actions i 1 Tname) hold) ([=] (-V- actions i 3 Tname) robot) (Yesterday ([=] (-V- actions i 1 Tname) exrm)))
              (&& (-P- hold) ([=] (-V- Action_Post i Tname) 0)))


      ;;hold

            (->

              ([=] (-V- actions i 1 Tname) hold)
              (&&
                    (-P- hold)
      ;     		(!!(-E- k RRM-indexes
      ;     				(&&([=](-V- RRM k) on) (!! ([=] k 7)))
          ; ))
                (Yesterday (|| ([=] (-V- actions i 1 Tname) executing) ([=] (-V- actions i 1 Tname) hold)))
                (next (!!(|| ([=] (-V- actions i 1 Tname) notstarted) ([=] (-V- actions i 1 Tname) waiting) ([=] (-V- actions i 1 Tname) done))))))


        ;;hold to exe
            (->
              (&& (Yesterday ([=] (-V- actions i 1 Tname) hold)) ([=] (-V- actions i 1 Tname) executing))
              (&& (!!(-P- hold))
                (!!(-E- k RRM-indexes
                          ([=](-V- RRM k) on)))))




        ;;hold to exrm
            (->
              (&&([=] (-V- actions i 1 Tname) exrm) (Yesterday ([=] (-V- actions i 1 Tname) hold)))
              (&&
                (!!(-P- hold))
                (-E- k RRM-indexes
                      ([=](-V- RRM k) on))))





      ;;done
            (->
              ([=] (-V- actions i 1 Tname) done)
              (&&
                (alwf ([=] (-V- actions i 1 Tname) done))
                (Yesterday (|| ([=] (-V- actions i 1 Tname) done) ([=] (-V- actions i 1 Tname) executing) ([=] (-V- actions i 1 Tname) exrm)))
                (withinp_ie (!! ([=] (-V- actions i 1 Tname) hold)) exetime)))



      ;;exit
            (->
              ([=] (-V- actions i 1 Tname) exitt)
              (&&
                (alwf ([=] (-V- actions i 1 Tname) exitt))
                (Yesterday (|| ([=] (-V- actions i 1 Tname) exitt) ([=] (-V- actions i 1 Tname) inexitt)))))



      ;;intermediate exit
            (->
              ([=] (-V- actions i 1 Tname) inexitt)
              (&&
                ([>] (-V- Risk) Threshold)
                (Yesterday (!! ([>] (-V- Risk) Threshold)))
                (next (!! ([=] (-V- actions i 1 Tname) inexitt)))))


      ;;inexit to exit
            (->
        ; (&& (Yesterday (!!([=] (-V- actions i 1 Tname) exitt))) ([=] (-V- actions i 1 Tname) exitt))
             (&& ([>] (-V- Risk) Threshold) (Yesterday ([=] (-V- actions i 1 Tname) inexitt)))
             ([=] (-V- actions i 1 Tname) exitt))

    ;;anything to inexit
            (->
              (&& (Yesterday (!!([=] (-V- actions i 1 Tname) inexitt))) ([=] (-V- actions i 1 Tname) inexitt))
             (&& ([>] (-V- Risk) Threshold) (Yesterday (!!([>] (-V- Risk) Threshold)))))


            (-> ;;inexit to anything
                (&& (Yesterday ([=] (-V- actions i 1 Tname) inexitt)) (!!([>] (-V- Risk) Threshold)))
             (&& (!!([=] (-V- actions i 1 Tname) inexitt)) (!!([=] (-V- actions i 1 Tname) exitt))))))))

    ;;*********************************
  ; 	;only two operator actions concurrently execute
  ;   	(-A- j index
  ;   		(-A- k index
  ;   			(->
    ;     		(&&
    ;     			(||([=] (-V- actions j 1 Tname) executing) ([=] (-V- actions j 1 Tname) exrm))
    ;     			([=] (-V- actions j 3 Tname) operator)
    ; 				(&& (||([=] (-V- actions k 1 Tname) executing) ([=] (-V- actions k 1 Tname) exrm)) ([=] (-V- actions k 3 Tname) operator) (!! ([=] j k)))
    ; 			)
    ; 			(!!
    ; 				(-E- x index
    ; 					(&&
    ; 						(!! ([=] x k))
    ; 						(!! ([=] x j))
    ; 						([=](-V- OpStarts x Tname) 1)
    ; 					)
    ; 				)
    ; 			)
    ; 		)
    ; 	)
    ; )
  ; ;;only three erroneous actions at the same time
  ; 	(-A- j index
  ; 	   (-A- k index
  ; 		(->
  ;     		(&&
  ;     			([=] (-V- actions j 4 Tname) erroneous)
  ;     			([=] (-V- actions k 4 Tname) erroneous)
  ;     			(!! ([=] k j))
  ; 			)
  ; 			(!!
  ; 				(-E- x index
  ; 					(&&
  ; 						(!! ([=] x k))
  ; 						(!! ([=] x j))
  ; 						([=] (-V- actions x 4 Tname) erroneous)))))))




(defconstant *initConfig*
  (&&

    (!! (-P- partFixed))
    (!! (-P- partTaken))

    ; (somf (-P- partTaken))
    ; (-P- Robot_Homing)
    ; (somf (-P- partFixed))

    ; ;temporary condition for test
    ; (Alwf (!! (-P- hold)))
    ; (Alwf (-P- OpActs))

    ; (-A- i body_indexes
    ; 	([=](-V- Body_Part_pos hand) L_3_2))

     ;;Layout
    *relativeProperties*

     ;;Operator
     *Operator_Body*

     ;Robot
     *Robot_Structure*
     (robotidle actions1-indexes T1)
     ; (robotidle actions2-indexes T2)
     ; (robotidle actions3-indexes T3)
     ; (robotidle actions4-indexes T4)


     ;;Hazards
    (alwf *HazardsInit*)
    (alwf *Hazards*)

    ;;risks
    (alwf *REs*)
    *RRMProperties*
    *RRMcall*
    (Alwf
      (->
        (&& (|| (-P- LINK1_Moving) (-P- LINK2_Moving) (-P- End_Eff_Moving)) (-A- k RRM-indexes ([<=](-V- RRM k) off)))
        ([=] (-V- relativeVelocity) 3))
    )
  )
)