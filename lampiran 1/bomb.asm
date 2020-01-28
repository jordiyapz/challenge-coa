#NOTES: syscall numbered 30 and higher are not provided by SPIM. It is only provided by MARS

.text

#so it begin...
main:

li 	$v0,55			
la 	$a0,intro
li 	$a1,1
syscall


li	$v0, 51			
la	$a0, var1		
syscall

move	$t0,$a0

la	$a0,var2
lb	$t1,var2
bne	$t0,$t1,boom

li 	$v0,55			
la 	$a0,phase1
li 	$a1,1
syscall
		
#
li	$v0, 51			
la	$a0, var1		
syscall				

move	$t0,$a0			

ori	$t1,$0,0x600D
ori	$t2,$0,0xF00D

and 	$t3,$0,$t1
or	$t4,$0,$t2

addu	$t5,$t0,$t3
subu	$t6,$t0,$t4

mul	$t7,$t5,$t6
beqz 	$t0,boom
bne	$t7,$t0,boom

li 	$v0,55			
la 	$a0,phase2
li 	$a1,1
syscall

#
li	$v0, 54
la	$a0, phase3		
la	$a1, var3
li	$a2, 20
syscall		

			
la	$t1,array1
la	$t2,array2


lb	$t3,($t1)
sb	$t3,($t2)

lb	$t3,2($t1)
sb	$t3,1($t2)

lb	$t3,8($t1)
sb	$t3,2($t2)


lb	$t3,($t1)
sb	$t3,3($t2)

lb	$t3,5($t1)
sb	$t3,4($t2)

lb	$t3,4($t1)
sb	$t3,5($t2)


lb	$t3,1($t1)
sb	$t3,6($t2)

lb	$t3,9($t1)
sb	$t3,7($t2)

lb	$t3,9($t1)
sb	$t3,8($t2)


lb	$t3,3($t1)
sb	$t3,9($t2)

lb	$t3,6($t1)
sb	$t3,10($t2)

lb	$t3,5($t1)
sb	$t3,11($t2)


lb	$t3,3($t1)
sb	$t3,12($t2)

lb	$t3,7($t1)
sb	$t3,13($t2)

lb	$t3,2($t1)
sb	$t3,14($t2)

la	$t0,var3
la	$t4,array2
ori	$t5,$0,1	#counter

loop:
lb	$t6,($t0)
lb	$t7,($t4)

bne	$t6,$t7,boom
sll     $0,$0,1        # branch delay

addiu	$t0,$t0,1
addiu	$t4,$t4,1

beq	$t5,15,congrat
sll     $0,$0,0        # branch delay

addiu	$t5,$t5,1

j	loop
sll     $0,$0,0        # branch delay

congrat:
li 	$v0,55			
la 	$a0,msg
li 	$a1,1
syscall
j	exit

boom:
li 	$v0,55			
la 	$a0,fail
li 	$a1,0
syscall
j	exit

exit:
li 	$v0,10
syscall


.data
var1:	.space 	15
var2: 	.byte	370

intro:	.asciiz "Welcome to my litte bomb. You have 3 phases with which to blow yourself up. Have a nice day!\n -clapper"
phase1:	.asciiz "Phase 1 Complete. Cable 1 is defused!\n I think you are just lucky ..."
phase2:	.asciiz "Phase 2 Complete. Cable 2 is defused!\n So you can do some algebra heh..."
phase3:	.asciiz "This is last stage. Good luck, you really need it he he..."
fail:	.asciiz "BOOOM!! BOOOM! Ha ha ha You fail"
msg:	.asciiz "Congratulation! You save the world!"
var3:	.asciiz "ABCDEFGHIJKLMNOP"
array1:	.asciiz "ACDEGJMNRW1234567890"
array2:	.asciiz "ABCDEFGHIJKLMNOP"

