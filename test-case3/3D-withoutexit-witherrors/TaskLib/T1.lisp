(load "TaskLib/ActionList.lisp")
(load "TaskLib/fcm.lisp")

(defvar action_indexes (loop for i from 1 to 23 collect i))
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
;; 10.robot removes wp from the pallet
;; 11.robot arm is rolled back in
;; 12.robot base moves to pallet 2
;; 13.robot ee hold wp
;; 14.robot arm is streching out
;; 15.robot inserts wp on pallet2
;; 16.op unscrews wp
;; 17.robot removes wp from the pallet
;; 18.robot arm is rolled back in
;; 19.robot base moves to pallet 3
;; 20.robot ee hold wp
;; 21.robot arm is streching out
;; 22.robot inserts wp on pallet3
;; 23.operator inspects the wp

(defconstant Config1
 (alwf(&&
       (SeqAction action_indexes 1)
       (mutually_exclusive2 action_indexes 1)
       ; (limiting_op_actions action_indexes 1)

       (alwf(relativeProperties 1 1))
       (alwf(Operator_Body 1))
       (alwf(Robot_Structure 1))
       (Seq-errors action_indexes 1 2)

;       (first_base_move 1 1 22 9)
       (move 2 1 32 L_upperbin 1)
       (pick 3 1 L_upperbin 1)
       (move 4 1 L_upperbin 32 1)
       (base_move 5 1 9 22)
       (ee_hold 6 1 5)
       ;*
       (move 7 1 45 34 1)
       (insertp 8 1 34 1)
       (unscrew 9 1 34 1)
       (removep 10 1 34)
       (move 11 1 34 45 1)
       ;*
       (base_move 12 1 22 18)
       (ee_hold 13 1 12)
       (move 14 1 41 35 1)
       (insertp 15 1 35 1)
       (unscrew 16 1 35 1)
       (removep 17 1 35)
       (move 18 1 35 41 1)
      ; *
       (base_move 19 1 18 17)
       (ee_hold 20 1 19)
       (move 21 1 40 29 1)
       (insertp 22 1 29 1)
       (inspectp 23 1 29 1)

       ;if none of these is running then base shouldnt move
       (-> (basemoves (setq l '(1 5 12 19)) 1) (!! (-P- Base_1_Moving)))
       ;;if none of these is running then endeff shouldnt move from base
       (-> (basemoves (setq l '(2 3 4 8 10 11 14 15 17 18  21 23)) 1) (|| (above_same_L `Base_1 `EndEff_1) (!! (-P- EndEff_1_Moving))))
       )))
