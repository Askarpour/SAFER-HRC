(load "TaskLib/ActionList.lisp")

(defvar action_indexes (loop for i from 1 to 3 collect i))
(defvar T1 1)
(defvar T2 2)


;;List of actions
;; 
;; 1.robot base moves to bin 1
;; 2.robot arm is streching out
;; 3.robot picks a wp

(defconstant Config2
 (alwf(&&
       (SeqAction action_indexes 1)
       (Robot_Structure 1) 

       (first_base_move 1 1 3 5)
       (move 2 1 5 6 1)
       (pick 3 1 6 1)
)))

