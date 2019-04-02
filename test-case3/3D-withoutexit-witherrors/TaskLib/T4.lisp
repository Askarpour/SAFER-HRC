(load "TaskLib/ActionList.lisp")

(defvar action_indexes (loop for i from 1 to 5 collect i))
(defvar T1 1)
(defvar T2 2)


;;List of actions
;; 
;; 1. operator moves to pallet 3
;; 2. operator inspects the shape of wp on pallet 3
;; 3. operator sends move signals to ro
;; 4. robot moves to pallet 3
;; 5. robot removes a wp from the pallet
;; 6. robot places the wp on the conveyor belt

(defconstant Config1
 (alwf(&&
       (SeqAction action_indexes 1)
       (mutually_exclusive2 action_indexes 1)
       ; (limiting_op_actions action_indexes 1)

       (relativeProperties 1 1)
       (Operator_Body 1)
       (Robot_Structure 1)
       
       ; (inspectp 2 1 29 1)
       ; (send_move_signal 3 1)
       ; (removep 4 1 29)
       ; (insertp 5 1 30 1)

       (!! (-P-  OPERATOR_1_HEAD_AREA_IN_L_5))
       (!! (-P-  OPERATOR_1_HEAD_AREA_IN_L_3))
       (!!(-P- BASE_1_IN_L_5))

       ; (!! (-P- Base_1_Moving))

       ;;if none of these is running then endeff shouldnt move from base
       ; (-> (basemoves (setq l '(5 4)) 1) (|| (above_same_L `Base_1 `EndEff_1) (!! (-P- EndEff_1_Moving))))
)))
