(load "TaskLib/ActionList.lisp")

(defvar action_indexes (loop for i from 1 to 10 collect i))
(defvar T1 1)
(defvar T2 2)


;;List of actions
;; 
;; 1.robot arm is streching out
;; 2.robot picks a wp
;; 3.robot arm is rolled back in
;; 4.robot base moves to pallet 1
;; 5.robot ee hold wp
;; 6.robot arm is streching out
;; 7.robot inserts wp on pallet1
;; 8.op unscrews wp
;; 9.robot removes wp from the pallet
;; 10.robot arm is rolled back in


(defconstant Config1
 (alwf(&&
       (SeqAction action_indexes 1)
       (mutually_exclusive2 action_indexes 1)
       (limiting_op_actions action_indexes 1)

       (relativeProperties 1 1)
       (Operator_Body 1)
       (Robot_Structure 1)
       
       (move 1 1 44 37 1)
       (pick 2 1 37 1)
       (move 3 1 37 44 1)
       (base_move 4 1 22 14)
       (ee_hold 5 1 4)
       ;*
       (move 6 1 36 39 1)
       (insertp 7 1 39 1)
       (unscrew 8 1 39 1)
       (removep 9 1 38)
       (move 10 1 38 36 1)
       ;*

       (-> (basemoves (setq l '(4)) 1) (!! (-P- Base_1_Moving)))
       (-> (basemoves (setq l '(1 2 3 6 7 8 9 10)) 1) (|| (above_same_L `Base_1 `EndEff_1) (!! (-P- EndEff_1_Moving))))
)))
