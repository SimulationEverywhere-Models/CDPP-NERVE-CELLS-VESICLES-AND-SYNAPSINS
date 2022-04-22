[top]
components : chemCell

[chemCell]
type : cell
dim : (26,22)
delay : transport
defaultDelayTime  : 100
border : wrapped 

neighbors :  chemCell(-1,-1) chemCell(-1,0) chemCell(-1,1) 
neighbors :  chemCell(0,-1)  chemCell(0,0)  chemCell(0,1) 
neighbors :  chemCell(1,-1)  chemCell(1,0)  chemCell(1,1)
 
 

initialvalue : 0
initialrowvalue : 0       0010201202201012020100 
initialrowvalue : 1       0001020120101020120100 
initialrowvalue : 2       0000000000000000000000
initialrowvalue : 3       0010112010120220220100 
initialrowvalue : 4       0002010001120220111200 
initialrowvalue : 5       0000000000000000000000 
initialrowvalue : 6       0012012020120201112000 
initialrowvalue : 7       0001202201012012012000 
initialrowvalue : 8       0010201202201101201200 
initialrowvalue : 9       0000000000000000000000 
initialrowvalue : 10      0001010101202012020100 
initialrowvalue : 11      0001202020111202201000 
initialrowvalue : 12      0010201201120201020100 
initialrowvalue : 13      0020102011020120120100 
initialrowvalue : 14      0000000000000000000000 
initialrowvalue : 15      0012022010101012020100 
initialrowvalue : 16      0012122020120102010100 
initialrowvalue : 17      0001010101202012020100
initialrowvalue : 18      0000000000000000000000
initialrowvalue : 19      0010201020101201201000
initialrowvalue : 20      0000000000000000000000
initialrowvalue : 21      0012022012020201010100
initialrowvalue : 22      0000000021000000020000
initialrowvalue : 23      0000000000000210000000 
initialrowvalue : 24      0010201202201101201200 
initialrowvalue : 25      0001202020111202201000
 
localtransition : chemCell-rule

[chemCell-rule]

rule : {round(uniform(11,14))} 100 { (0,0) = 1  }
rule : {round(uniform(21,24))} 100 { (0,0) = 2  }

rule : {round(uniform(31,34))} 100 {((0,0)=21 or (0,0)=22 or (0,0)=23 or (0,0)=24) and 
( ((-1,0)- 10 = 1 or (-1,0)- 10 = 2 or (-1,0)- 10 = 3 or (-1,0)- 10 =4 ) or
  ((1,0)- 10 = 1 or (1,0)- 10 = 2 or (1,0)- 10 = 3 or (1,0)- 10 = 4)     or
  ((0,-1)- 10 = 1 or (0,-1)- 10 = 2 or (0,-1)- 10 = 3 or (0,-1)- 10 = 4) or
  ((0,1)- 10 = 1 or (0,1)- 10 = 2 or (0,1)- 10 = 3 or (0,1)- 10 = 4 )    or
  ((-1,1)- 10 = 1 or (-1,1)- 10 = 2 or (-1,1)- 10 = 3 or (-1,1)- 10 = 4) or
  ((1,-1)- 10 = 1 or (1,-1)- 10 = 2 or (1,-1)- 10 = 3 or (1,-1)- 10 = 4) or
  ((1,1)- 10 = 1 or (1,1)- 10 = 2 or (1,1)- 10 = 3 or (1,1)- 10 = 4)     or
  ((-1,-1)- 10 = 1 or (-1,-1)- 10 = 2 or (-1,-1)- 10 = 3 or (-1,-1)- 10 = 4) )  and random > 0.10}

rule : {round(uniform(41,44))} 100 {((0,0)=11 or (0,0)=12 or (0,0)=13 or (0,0)=14) and 
( ((-1,0)- 30 = 1 or (-1,0)- 30 = 2 or (-1,0)- 30 = 3 or (-1,0)- 30 = 4) or 
((1,0)- 30 = 1 or (1,0)- 30 = 2 or (1,0)- 30 = 3 or (1,0)- 30 = 4) or 
((0,-1)- 30 = 1 or (0,-1)- 30 = 2 or (0,-1)- 30 = 3 or (0,-1)- 30 = 4)  or 
((0,1)- 30 = 1 or (0,1)- 30 = 2 or (0,1)- 30 = 3 or (0,1)- 30 = 4 ) or 
((-1,1)- 30 = 1 or (-1,1)- 30 = 2 or (-1,1)- 30 = 3 or (-1,1)- 30 = 4) or 
((1,-1)- 30 = 1 or (1,-1)- 30 = 2 or (1,-1)- 30 = 3 or (1,-1)- 30 = 4) or 
((1,1)- 30 = 1 or (1,1)- 30 = 2 or (1,1)- 30 = 3 or (1,1)- 30 = 4) or 
((-1,-1)- 30 = 1 or (-1,-1)- 30 = 2 or (-1,-1)- 30 = 3 or (-1,-1)- 30 = 4))  and random > 0.10}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%moving rules for S   --  


%moving up
rule : 91 100 {(0,0)=21 and (-1,0)=0 and t}
rule : {round(uniform(21,24))} 0 {(0,0)=0 and (1,0)=91 }
rule : 00 0 {(0,0)=91}

%moving right
rule : 92 100 {(0,0)=22 and (0,1)=00 and t}
rule : {round(uniform(21,24))} 0 {(0,0)=0 and (0,-1)=92}
rule : 00 0 {(0,0)=92}

%moving down
rule : 93 100 {(0,0)=23 and (1,0)=00 and t}
rule : {round(uniform(21,24))} 0 {(0,0)=0 and (-1,0)=93 }
rule : 00 0 {(0,0)=93}


%moving left
rule : 94 100 {(0,0)=24 and (0,-1)=00 and t}
rule : {round(uniform(21,24))} 0 {(0,0)=0 and (0,1)=94 }
rule : 00 0 {(0,0)=94}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%release 0.1 of the S (the offrate is 0.1)
rule : {round(uniform(21,24))} 100 {((0,0)=33 or (0,0)=32 or (0,0)=31 or (0,0)=34) and random < 0.10}



% any others
rule : { (0, 0) } 100 { t}



