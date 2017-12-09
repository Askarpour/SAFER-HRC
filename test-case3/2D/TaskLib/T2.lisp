(load "TaskLib/ActionList.lisp")

(defvar action_indexes (loop for i from 1 to 9 collect i))
(defvar T1 1)
(defvar T2 2)


;;List of actions
;; 
;; 1.robot base moves to bin 1
;; 2.robot arm is streching out
;; 3.robot picks a wp
;; 4.robot arm is rolled back in
;; 5.robot base moves to pallet 1
;; 6.robot ee hold wp
;; 7.robot arm is streching out
;; 8.robot inserts wp on pallet1
;; 9.op unscrews wp

(defconstant Config2
 (alwf(&&
       (SeqAction action_indexes 1)
       (mutually_exclusive2 action_indexes 1)
       (limiting_op_actions action_indexes 1)

       (relativeProperties 1 1)
       (Operator_Body 1)
       (Robot_Structure 1)

       (first_base_move 1 1 3 5)
       (move 2 1 5 6 1)
       (pick 3 1 6 1)
       (move 4 1 6 5 1)
       (base_move 5 1 5 3)
       (ee_hold 6 1 5)
       ;*
       (move 7 1 3 2 1)
       (insertp 8 1 1 1)
       (unscrew 9 1 1 1)

       (-> (basemoves (setq l '(1 5)) 1) (!! (-P- Base_1_Moving)))
)))

