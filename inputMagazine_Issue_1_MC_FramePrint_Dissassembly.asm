;100 DATA 24,55,1,22,0,0,32,32,32,22,0,0,
;32,32,32,22,0,0,32,32
;110 DATA 32,22,0,0,144,145,146,22,0,0,147,
;148,149,22,0,0,150,151,152,22
;120 DATA 0,0,153,154,155,22,0,0,156,157,
;158,22,0,0,159,160,161,58,146,126
;130 DATA 254,1,1,18,0,40,8,56,4,203,33,
;24,2,14,0,221,33,147,126,221
;140 DATA 9,58,137,92,71,62,24,144,221,
;119,1,60,221,119,7,60,221,119,13,58
;150 DATA 136,92,71,62,33,144,221,119,2,
;221, 119,8,221,119,14,221,229,62,2,205
;160 DATA 1,22,209,1,18,0,205,60,32,201,9913

;; making use of https://clrhome.org/table/ to manually disassemble

;; This is my best guess at disassembly and is not clear if correct or not

	jr 55             ; 24, 55   ;; this is a good inidication the next 55 bytes are data
	1,                           ;; there's a pattern of 22, 0, 0 followed by 3 numbers repeating
	22,0,0,         ; 
	32,32,32,
	22,0,0,
	32,32,32,
	22,0,0,
	32,32,32,
	22,0,0,
	144,145,146,
	22,0,0,
	147,148,149,
	22,0,0,
	150,151,152,
	22,0,0,
	153,154,155,
	22,0,0,
	156,157,158,
	22,0,0,
	159,160,161,
	;;; 159,169,161 is the last of the repeating pattern, and aligns with jump relative 55
	ld a, ($7e92)    ;58,146,126   ;; 58 dec = 3A hex =  ld a,(nn), byte order reverse to 126 146 = 7e92 = 32402
	cp 1             ;254,1        ;; 254 dec = FE hex= cp n 
	ld bc, $0012     ;1,18,0,      ;; 1 = ld bc, nn, reverse byte order 00 18 decimal = 0012 hex
	jr z, 8,         ;40,8         ;; 40 decimal = 28 hex = jr z, d  (d is signed integer in this case 8)
	jr c, 4          ;56,4         ;; 56decimal = 38hex = jr c, d (d is signed integer in this case 4)

	                               ;; now we get to 203 decimal which is CB hex, and is a 2 byte opcode
	sla c            ;203,33,      ;; 203 decimal = cb, 33 decimal = 21 hex --->>> sla c (shift register c left 1 ) 
	jr 2             ;24,2         ;; 24decimal = 18 hex = jr d, where d is integer in next byte = 2       
	ld c, 0          ;14,0         ;; 14decimal = e hex = ld c, n
    ld ix, $7e93     ;221,33,147,126  ;; 221 = dd = 2byte opcode, ld ix, nn  --> reverse byte order so 147,126 = 126,147 = $7e,$93 
	 								;; $7e93 hex = 32403
	add ix, bc       ;221,9         ;; again 221=dd, from that table 9 is add ix, bc
					 
					 ;58,137,92,71,62,24,144,221,
;119,1,60,221,119,7,60,221,119,13,58
;150 DATA 136,92,71,62,33,144,221,119,2,
;221, 119,8,221,119,14,221,229,62,2,205
;160 DATA 1,22,209,1,18,0,205,60,32,201,

