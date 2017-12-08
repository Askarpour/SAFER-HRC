(load "TaskLib/ActionList.lisp")

(defvar action_indexes (loop for i from 1 to 2 collect i))
(defvar T1 1)
(defvar T2 2)


;;List of actions
;; 
;; 1.robot base moves to pallet 3
;; 2.operator crosses 



(defconstant Config2
 (alwf(&&
       (SeqAction action_indexes 1)
       (mutually_exclusive2 action_indexes 1)
       (limiting_op_actions action_indexes 1)

       (relativeProperties 1 1)
       (Operator_Body 1)
       (Robot_Structure 1)

       (first_base_move 1 1 14 22)
       (op_moves 2 2 5 9 1)

       (In_same_L `Base_1 `EndEff_1)
       (In_same_L `Base_1 `Link1_1)
       (In_same_L `Base_1 `Link2_1)
       (-> (basemoves (setq l '(1)) 1) (!! (-P- Base_1_Moving)))
)))

