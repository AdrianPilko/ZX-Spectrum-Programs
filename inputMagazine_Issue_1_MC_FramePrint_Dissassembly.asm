; FramePrint LISTING FOR INPUT MAGAZINE "SPEEDING UP YOUR GAMES ROUTINES" using machine code
10 IF PEEK 23733=127 THEN CLEAR 32399:
LET B=32400: LET Z=0
20 IF PEEK 23733=255 THEN CLEAR 65199:
LET B=65200: LET Z=1
30 LET T = 0:FOR N=B TO B +129:READ
A:LET T= T + A:POKE N,A:NEXT N:READ
A:IF A< >T THEN PRINT "DATA
ERROR":STOP
40 IF Z=1 THEN POKE 65258,178: POKE
65259,254: POKE 65277,179: POKE
65278,254
50 SAVE "FramePrint" CODE B,130
60 STOP
100 DATA 24,55,1,22,0,0,32,32,32,22,0,0,
32,32,32,22,0,0,32,32
110 DATA 32,22,0,0,144,145,146,22,0,0,147,
148,149,22,0,0,150,151,152,22
120 DATA 0,0,153,154,155,22,0,0,156,157,
158,22,0,0,159,160,161,58,146,126
130 DATA 254,1,1,18,0,40,8,56,4,203,33,
24,2,14,0,221,33,147,126,221
140 DATA 9,58,137,92,71,62,24,144,221,
119,1,60,221,119,7,60,221,119,13,58
150 DATA 136,92,71,62,33,144,221,119,2,
221, 119,8,221,119,14,221,229,62,2,205
160 DATA 1,22,209,1,18,0,205,60,32,201,9913

;; making use of https://clrhome.org/table/ to manually disassemble
;; also reference to http://www.primrosebank.net/computers/zxspectrum/docs/CompleteSpectrumROMDisassemblyThe.pdf

;; This is my best guess at disassembly and is not clear if correct or not
;; (as per convention prefix $ means number is hex, otherwise is decimal)

;address 32400
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

    ;; It's important where this code is in memory, and that's setup by the BASIC routine that
	;; loads the DATA statements - the Machine code is placed at 32400 if the PEEK 23733 returns 127 
	;; and it sets BASIC variable Z to 0. This is critical because if you read the rest of the text and
	;; the BASIC code it's clear that thie default routine below is written to run on a 16K ZX Spectrum
	;; the BASIC code has some more POKE's which change the machine code after it's been read from
	;; the data statements and this converts it to 48K ZX Spectrum compatible. This happens when
	;; Z=1 as a result of PEEK 23733 returning 255, in that case B (the BASIC variable) is set to
	;; 65200 and that is where the machine code gets read into from the DATA if you have a 48K machine
	;; (very sneaky indeed but cleverly allows compatibility with both versions of ZX Spectrum)

	;;; 159,169,161 is the last of the repeating pattern, and aligns with jump relative 55
	ld a, ($7e92)    ;58,146,126   ;; 58 dec = 3A hex =  ld a,(nn), byte order reverse to 126 146 = 7e92 = 32402
	cp 1             ;254,1        ;; 254 dec = FE hex= cp n 
	ld bc, $0012     ;1,18,0,      ;; 1 = ld bc, nn, reverse byte order 00 18 decimal = 0012 hex
	jr z, 8          ;40,8         ;; 40 decimal = 28 hex = jr z, d  (d is signed integer in this case 8)
	jr c, 4          ;56,4         ;; 56decimal = 38hex = jr c, d (d is signed integer in this case 4)

	                               ;; now we get to 203 decimal which is CB hex, and is a 2 byte opcode
	sla c            ;203,33,      ;; 203 decimal = cb, 33 decimal = 21 hex --->>> sla c (shift register c left 1 ) 
	jr 2             ;24,2         ;; 24decimal = 18 hex = jr d, where d is integer in next byte = 2       
	ld c, 0          ;14,0         ;; 14decimal = e hex = ld c, n
    ld ix, $7e93     ;221,33,147,126  ;; 221 = dd = 2byte opcode, ld ix, nn  --> reverse byte order so 147,126 = 126,147 = $7e,$93 
	 								;; $7e93 hex = 32403
	add ix, bc       ;221,9         ;; again 221=dd, from that table 9 is add ix, bc
					 
	ld a, ($5c89)    ;58,137,92    ;; as before 2 byte operand load a with value at $5c89 (reverse byte order) 
	
	ld b,a           ;71
	ld a, 24         ;62,24
	sub b            ;144
	ld (ix+1),a      ;221,119, 1    221 = dd -> lookup from dd table 119decimal -> 77hex 
	inc a            ;60.         (NOTE- these ix instructions are used to index a table plus offset)
	ld (ix+7),a      ;221,119,7
	inc a            ;60
    ld (ix+13),a     ;221,119,13
	ld a,($5c88)     ;58, 136,92,  reverse byte order 92,136 becomes $5c88. ->  23688 in decimal
	ld b,a           ;71
	ld a, 33         ;62,33.     I'm assuming 33 is the offset to the next screen line 32 wide??
	sub b            ;144 
	ld (ix+2),a      ;221,119,2,
    ld (ix+8),a      ;221,119,8
	ld (ix+14),a     ;221,119,14

	push ix          ;221,229
	ld a, 2          ;62,2
	call $1601       ;205,1,22    -> call nn,  ,1,22  becomes 22,1 -> $1601 this is ROM code 'CHAN-OPEN' SUBROUTINE
					 ; where the value of register a is the stream number - as far as I can tell this is the screen
	pop de           ;209. clearly setting de register with the previously pushed ix register
	ld bc, $0012     ;1,18,0 -> ld bc, nn 18,0 reversed and in hex is 0012
	call $203c       ;205,  60,32 -> 32,60 -> $203c  ROM subroutine to print to the screen
	ret              ;201, as per any machine code subroutine call ret to return to BASIC
