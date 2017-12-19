(load "TaskLib/ActionList.lisp")

(defvar action_indexes (loop for i from 1 to 15 collect i))
(defvar T1 1)
(defvar T2 2)


;;List of actions
;; 
;; 1.op unscrews wp
;; 2.robot removes wp from the pallet
;; 3.robot arm is rolled back in
;; 4.robot base moves to pallet 2
;; 5.robot ee hold wp
;; 6.robot arm is streching out
;; 7.robot inserts wp on pallet2
;; 8.op unscrews wp
;; 9.robot removes wp from the pallet
;; 10.robot arm is rolled back in
;; 11.robot base moves to pallet 3
;; 12.robot ee hold wp
;; 13.robot arm is streching out
;; 14.robot inserts wp on pallet3
;; 15.operator inspects the wp


(defconstant Config1
 (alwf(&&
       (SeqAction action_indexes 1)
       (mutually_exclusive2 action_indexes 1)
       (limiting_op_actions action_indexes 1)

       (relativeProperties 1 1)
       (Operator_Body 1)
       (Robot_Structure 1)
       
       (unscrew 1 1 39 1)
       (removep 2 1 38)
       (move 3 1 38 36 1)
       ;*
       (base_move 4 1 14 12)
       (ee_hold 5 1 4)
       (move 6 1 34 41 1)
       (insertp 7 1 41 1)
       (unscrew 8 1 41 1)
       (removep 9 1 40)
       (move 10 1 40 34 1)
       ;*
       (base_move 11 1 12 5)
       (ee_hold 12 1 11)
       (move 13 1 27 43 1)
       (insertp 14 1 43 1)
       (inspectp 15 1 42 1)

       ;if none of these is running then base shouldnt move
       (-> (basemoves (setq l '(4 11)) 1) (!! (-P- Base_1_Moving)))
       ;;if none of these is running then endeff shouldnt move from base
       (-> (basemoves (setq l '(1 2 3 6 7 8 9 10 13 14 15)) 1) (|| (above_same_L `Base_1 `EndEff_1) (!! (-P- EndEff_1_Moving))))
)))
