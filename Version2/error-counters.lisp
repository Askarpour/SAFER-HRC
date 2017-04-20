(defconstant error_count_0
	(Alwf
		(!!(-E- i actions1-indexes
		([=] (-V- actions i 4 1) erroneous)
	)))
)

(defconstant error_count_1

 	;;only one erroneous action at a time
 	;;once error detected, no error anymore
	(AlwF(&&
			(-A- i actions1-indexes
				(->
					([=] (-V- actions i 4 1) erroneous)
					(&&
						(Alwf(!!(-E- j actions1-indexes
							(&&
								(!! ([=] i j))
								([=] (-V- actions j 4 1) erroneous)
							)
						)))
	
						(->
							(SomF([=] (-V- actions i 4 1) normative))
							(AlwF([=] (-V- actions i 4 1) normative))
						)
					)
				)
			)
		))
)

(defconstant error_count_2
	(AlwF(&&
			(SomF (-E- i actions1-indexes ([=] (-V- actions i 4 1) erroneous)))
	
			(-A- i actions1-indexes
				(->
					([=] (-V- actions i 4 1) erroneous)
					(-E- k actions1-indexes
						(&&
							(!! ([=] k i))
							([=] (-V- actions k 4 1) erroneous)
							(Alwf
								(!!
									(-E- j actions1-indexes
										(&&
											(!! ([=] i j))
											(!! ([=] k j))
											([=] (-V- actions j 4 1) erroneous)
										)
									)
								)
							)
	
							(->
								(SomF([=] (-V- actions i 4 1) normative))
								(AlwF([=] (-V- actions i 4 1) normative))
							)
							(->
								(SomF([=] (-V- actions k 4 1) normative))
								(AlwF([=] (-V- actions k 4 1) normative))
							)
						)
					)
				)
			)
		))
)

(defconstant error_count_3

	(AlwF(&&
			(SomF (-E- i actions1-indexes ([=] (-V- actions i 4 1) erroneous)))
	
			(-A- i actions1-indexes
				(->
					([=] (-V- actions i 4 1) erroneous)
					(-E- l actions1-indexes
						(&&
							(!! ([=] l i))
							([=] (-V- actions l 4 1) erroneous)
							(-E- k actions1-indexes
								(&&
									(!! ([=] k i))
									(!! ([=] k l))
									([=] (-V- actions k 4 1) erroneous)
									(Alwf
										(!!
											(-E- j actions1-indexes
												(&&
													(!! ([=] i j))
													(!! ([=] k j))
													(!! ([=] l j))
													([=] (-V- actions j 4 1) erroneous)
												)
											)
										)
									)
	
									(->
										(SomF([=] (-V- actions i 4 1) normative))
										(AlwF([=] (-V- actions i 4 1) normative))
									)
									(->
										(SomF([=] (-V- actions k 4 1) normative))
										(AlwF([=] (-V- actions k 4 1) normative))
									)
									(->
										(SomF([=] (-V- actions l 4 1) normative))
										(AlwF([=] (-V- actions l 4 1) normative))
									)
								)
							)
						)
					)
				)
			)
		))
)


(defconstant error_count_4

	(Alwf(&&
			(SomF (-E- i actions1-indexes ([=] (-V- actions i 4 1) erroneous)))
	
			(-A- i actions1-indexes
				(->
					([=] (-V- actions i 4 1) erroneous)
					(-E- x actions1-indexes
						(&&
							(!! ([=] x i))
							([=] (-V- actions x 4 1) erroneous)
							(-E- l actions1-indexes
								(&&
									(!! ([=] l i))
									(!! ([=] l x))
									([=] (-V- actions l 4 1) erroneous)
									(-E- k actions1-indexes
										(&&
											(!! ([=] k i))
											(!! ([=] k l))
											(!! ([=] k x))
											([=] (-V- actions k 4 1) erroneous)
											(Alwf
												(!!
													(-E- j actions1-indexes
														(&&
															(!! ([=] j i))
															(!! ([=] j k))
															(!! ([=] j l))
															(!! ([=] j x))
															([=] (-V- actions j 4 1) erroneous)
														)
													)
												)
											)
	
											(->
												(SomF([=] (-V- actions i 4 1) normative))
												(AlwF([=] (-V- actions i 4 1) normative))
											)
											(->
												(SomF([=] (-V- actions k 4 1) normative))
												(AlwF([=] (-V- actions k 4 1) normative))
											)
											(->
												(SomF([=] (-V- actions l 4 1) normative))
												(AlwF([=] (-V- actions l 4 1) normative))
											)
											(->
												(SomF([=] (-V- actions x 4 1) normative))
												(AlwF([=] (-V- actions x 4 1) normative))
											)
										)
									)
								)
							)
						)
					)
				)
			)
		))
)

(defconstant error_count_5

	(AlwF(&&
			(SomF (-E- i actions1-indexes ([=] (-V- actions i 4 1) erroneous)))
	
			(-A- i actions1-indexes
				(->
					([=] (-V- actions i 4 1) erroneous)
					(-E- y actions1-indexes
						(&&
							(!! ([=] y i))
							([=] (-V- actions y 4 1) erroneous)
							(-E- x actions1-indexes
	
								(&&
									(!! ([=] x i))
									(!! ([=] x y))
									([=] (-V- actions x 4 1) erroneous)
									(-E- l actions1-indexes
										(&&
											(!! ([=] l i))
											(!! ([=] l x))
											([=] (-V- actions l 4 1) erroneous)
											(-E- k actions1-indexes
												(&&
													(!! ([=] k i))
													(!! ([=] k l))
													(!! ([=] k x))
													(!! ([=] k y))
													([=] (-V- actions k 4 1) erroneous)
													(Alwf
														(!!
															(-E- j actions1-indexes
																(&&
																	(!! ([=] j i))
																	(!! ([=] j k))
																	(!! ([=] j l))
																	(!! ([=] j x))
																	(!! ([=] j y))
																	([=] (-V- actions j 4 1) erroneous)
																)
															)
														)
													)
	
													(->
														(SomF([=] (-V- actions i 4 1) normative))
														(AlwF([=] (-V- actions i 4 1) normative))
													)
													(->
														(SomF([=] (-V- actions k 4 1) normative))
														(AlwF([=] (-V- actions k 4 1) normative))
													)
													(->
														(SomF([=] (-V- actions l 4 1) normative))
														(AlwF([=] (-V- actions l 4 1) normative))
													)
													(->
														(SomF([=] (-V- actions x 4 1) normative))
														(AlwF([=] (-V- actions x 4 1) normative))
													)
													(->
														(SomF([=] (-V- actions y 4 1) normative))
														(AlwF([=] (-V- actions y 4 1) normative))
													)
												)
											)
										)
									)
								)
							)
						)
					)
				)
			)
		))
)


; (loop for i from 1 to 15 collect
;   (progn
;     (eval `(defconstant ,(read-from-string (format nil "desiredProperty_~A_~A" i 0)) 
;       (&&
;         (SomF ([=] (-V- ,(with-input-from-string (in (format nil "hazards ~a ~a" i 0)) (loop for x = (read in nil nil) while x collect x))) 1))
;         (AlwF error_count_0)
;         )
; ))))
		
; (loop for i from 1 to 15 collect
;   (progn
;     (eval `(defconstant ,(read-from-string (format nil "desiredProperty_~A_~A" i 1)) 
;       (&&
;         (SomF ([=] (-V- ,(with-input-from-string (in (format nil "hazards ~a ~a" i 0)) (loop for x = (read in nil nil) while x collect x))) 1))
;         (AlwF error_count_1)
;         )
; ))))
		
; (loop for i from 1 to 15 collect
;   (progn
;     (eval `(defconstant ,(read-from-string (format nil "desiredProperty_~A_~A" i 2)) 
;       (&&
;         (SomF ([=] (-V- ,(with-input-from-string (in (format nil "hazards ~a ~a" i 0)) (loop for x = (read in nil nil) while x collect x))) 1))
;         (AlwF error_count_2)
;         )
; ))))

; (loop for i from 1 to 15 collect
;   (progn
;     (eval `(defconstant ,(read-from-string (format nil "desiredProperty_~A_~A" i 3)) 
;       (&&
;         (SomF ([=] (-V- ,(with-input-from-string (in (format nil "hazards ~a ~a" i 0)) (loop for x = (read in nil nil) while x collect x))) 1))
;         (AlwF error_count_3)
;         )
; ))))

; (loop for i from 1 to 15 collect
;   (progn
;     (eval `(defconstant ,(read-from-string (format nil "desiredProperty_~A_~A" i 4)) 
;       (&&
;         (SomF ([=] (-V- ,(with-input-from-string (in (format nil "hazards ~a ~a" i 0)) (loop for x = (read in nil nil) while x collect x))) 1))
;         (AlwF error_count_4)
;         )
; ))))


; (loop for i from 1 to 15 collect
;   (progn
;     (eval `(defconstant ,(read-from-string (format nil "desiredProperty_~A_~A" i 5)) 
;       (&&
;         (SomF ([=] (-V- ,(with-input-from-string (in (format nil "hazards ~a ~a" i 0)) (loop for x = (read in nil nil) while x collect x))) 1))
;         (AlwF error_count_5)
;         )
; ))))


(loop for i from 1 to 15 collect
  (progn
    (eval `(defconstant ,(read-from-string (format nil "desiredProperty_~A_~A" i 0)) 
      (&&
        (SomF 
        	; (&&
        	([=] (-V- ,(with-input-from-string (in (format nil "hazards ~a ~a" i 0)) (loop for x = (read in nil nil) while x collect x))) 1)
        	; (|| (SomP (-E- x actions1-indexes ([=] (-V- actions x 4 1) erroneous))) (-E- x actions1-indexes ([=] (-V- actions x 4 1) erroneous)))
    		; )
    	)
        (AlwF error_count_0)
        )
))))
		
(loop for i from 1 to 15 collect
  (progn
    (eval `(defconstant ,(read-from-string (format nil "desiredProperty_~A_~A" i 1)) 
      (&&
        (SomF 
        	(&&
	        	([=] (-V- ,(with-input-from-string (in (format nil "hazards ~a ~a" i 0)) (loop for x = (read in nil nil) while x collect x))) 1)
	        	(|| (SomP (-E- x actions1-indexes ([=] (-V- actions x 4 1) erroneous))) (-E- x actions1-indexes ([=] (-V- actions x 4 1) erroneous)))
    		)
    	)
        (AlwF error_count_1)
        )
))))
		
(loop for i from 1 to 15 collect
  (progn
    (eval `(defconstant ,(read-from-string (format nil "desiredProperty_~A_~A" i 2)) 
      (&&
        (&&
        	([=] (-V- ,(with-input-from-string (in (format nil "hazards ~a ~a" i 0)) (loop for x = (read in nil nil) while x collect x))) 1)
        	(|| (SomP (-E- x actions1-indexes ([=] (-V- actions x 4 1) erroneous))) (-E- x actions1-indexes ([=] (-V- actions x 4 1) erroneous)))
		)
        (AlwF error_count_2)
        )
))))

(loop for i from 1 to 15 collect
  (progn
    (eval `(defconstant ,(read-from-string (format nil "desiredProperty_~A_~A" i 3)) 
      (&&
        (&&
        	([=] (-V- ,(with-input-from-string (in (format nil "hazards ~a ~a" i 0)) (loop for x = (read in nil nil) while x collect x))) 1)
        	(|| (SomP (-E- x actions1-indexes ([=] (-V- actions x 4 1) erroneous))) (-E- x actions1-indexes ([=] (-V- actions x 4 1) erroneous)))
		)
        (AlwF error_count_3)
        )
))))

(loop for i from 1 to 15 collect
  (progn
    (eval `(defconstant ,(read-from-string (format nil "desiredProperty_~A_~A" i 4)) 
      (&&
        (&&
        	([=] (-V- ,(with-input-from-string (in (format nil "hazards ~a ~a" i 0)) (loop for x = (read in nil nil) while x collect x))) 1)
        	(|| (SomP (-E- x actions1-indexes ([=] (-V- actions x 4 1) erroneous))) (-E- x actions1-indexes ([=] (-V- actions x 4 1) erroneous)))
		)
        (AlwF error_count_4)
        )
))))


(loop for i from 1 to 15 collect
  (progn
    (eval `(defconstant ,(read-from-string (format nil "desiredProperty_~A_~A" i 5)) 
      (&&
        (&&
        	([=] (-V- ,(with-input-from-string (in (format nil "hazards ~a ~a" i 0)) (loop for x = (read in nil nil) while x collect x))) 1)
        	(|| (SomP (-E- x actions1-indexes ([=] (-V- actions x 4 1) erroneous))) (-E- x actions1-indexes ([=] (-V- actions x 4 1) erroneous)))
		)
        (AlwF error_count_5)
        )
))))

