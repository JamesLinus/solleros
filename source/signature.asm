sigjump:
	jmp signatureend
signature:
db "SollerOS" ;Operating system name
db " Alpha Build ",0	;Soller OS development level
dd 253	;version number
signatureend: