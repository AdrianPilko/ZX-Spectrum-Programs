5 rem (c) Adrian Pilkington 2021, code to write ByteForever youtube channel logo V1
10 cls
15 let i=0
16 let p=3
30 for n=0 to 6 rem down 7
32 ink i
35 paper p
40 print at n,0;"8"
41 print at n,12;"8"
42 print at n,15;"8"
43 print at n+8,0;"8"
44 print at n+8,9;"8" rem  left vertical in first R of forever
45 print at n+8,14;"8" rem first E in forever
46 print at n+8,24;"8" rem second E in forever
47 print at n+8,4;"8" rem left vertical of o in forever
48 print at n+8,7;"8"rem right vertical of o in forever
49 print at n+8,29;"8" rem vertical second R in forever
50 print at n+8,19;"8" rem left vertical V
56 let p = p - 1:let i = i + 1
57 if i>=2 then let i=0
58 if p<=0 then let p=3
59 next n

60 for n=0 to 3 rem accross 4
61 ink i
62 paper p
65 print at 0,n+10;"8"
66 print at 0,n+15;"8"
68 print at 8,n;"8"
70 print at 8,n+14;"8" rem upper bar in first E of forever
71 print at 14,n+14;"8"
73 print at 8,n+24;"8"
74 print at 14,n+24;"8"
100 let p = p - 1:let i = i + 1
110 if i>=3 then let i=0
111 if p<=0 then let p=3
113 next n
120 print at 0,14;"8"
121 print at 8,30;"8"
122 print at 11,30;"8"

130 for n=0 to 2   rem accross 3
131 ink i
132 paper p
133 print at 0,n;"8"
134 print at 6,n;"8"
135 print at 3,n;"8"
136 print at 3,n+15;"8"
137 print at 11,n;"8"
138 print at 11,n+14;"8"
139 print at 11,n+24;"8" rem seconds E in forever
140 print at 8,n+9;"8" rem first R in forever
141 print at 8,n+5;"8"
142 print at 14,n+5;"8"
143 print at 11,n+9;"8" rem first R in forever lower bar
144 print at 6,n+16;"8"

150 let p = p - 1:let i = i + 1
151 if i>=2 then let i=0
152 if p<=0 then let p=3
153 next n


180 for n=0 to 1   rem down 2 
181 ink i
182 paper p
183 print at n+1,3;"8"
184 print at n+4,3;"8"
185 print at n+9,12;"8" rem right 2 in first R of forever
186 print at n+9,31;"8" rem right 2 in first R of forever
187 print at n+13,31;"8" rem right 2 in first R of forever
200 let p = p - 1:let i = i + 1
201 if i>=2 then let i=0
202 if p<=0 then let p=3
203 next n
204 print at 12,31;"8" rem right 2 in first R of forever

249 let n=0
250 for m=0 to 2   rem forward diagonal 3's
256 ink i
257 paper p
258 print at n,m+4;"8"   rem backward part of Y in byte
259 print at n+12,m+10;"8" rem bottom leg first R in forever

300 let p = p - 1:let i = i + 1
301 if i>=2 then let i=0
302 if p<=0 then let p=3
303 let n=n+1
304 next m

349 let m=2
350 let n=0 rem backward diagonals
351 for q=0 to 2
352 ink i
353 paper p
354 print at n,m+6;"8" 
355 print at n+12,m+19;"8" rem V in forever

400 let p = p - 1:let i = i + 1
401 if i>=4 then let i=0
402 if p<=0 then let p=3
403 let n=n+1
404 let m=m-1
405 next q


500 for n=0 to 3 rem down 4
501 ink i
502 paper p
503 print at n+3,6;"8" rem bottom of Y in byte
504 print at n,12;"8" 
505 print at n,15;"8"
507 print at n+8,22;"8" rem right of V
550 let p = p - 1:let i = i + 1
551 if i>=2 then let i=0
552 if p<=0 then let p=3
553 next n

700 goto 30
