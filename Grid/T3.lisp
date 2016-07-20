;;Operator changes the tool
(defvar actions-indexes (loop for i from 1 to 2 collect i))
(defvar T3 3)
(defun T3(tool)
	*ActionInitT3*
)	

(defconstant *ActionInitT3*
	(alwf 

 		(&&
		  (-A- i actions-indexes
	 	   ([=] (-V- actions i 2 T3) 3))
			 ; Initialization of subject
 	 		 ([=] (-V- actions 1 3 T3) operator)
 	 		 ([=] (-V- actions 1 3 T3) operator)

	 	 )
	)

)
;;operator goes to L_6
(defconstant *Action1T3* )

;;operator changes the tool(tool)
(defconstant *Action2T3* )
