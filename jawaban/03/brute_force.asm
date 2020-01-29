.data
output:		.space	61	# 61 chars of happy null byte
message:	.asciiz	"lwcjba uig vwb jm xtmiaivb, jcb kmzbiqvbg qa ijaczl"
linefeed:	.asciiz	"\n"
template:	.asciiz	"key #XX: "
# LETTERS is ascii from 97 to 122

.text
main:
	la	$t7, output
	la	$t1, template
	li	$t8, 0
	
	copy_template:
		lb	$t2, ($t1)
		sb	$t2, ($t7)
		addi	$t1, $t1, 1
		addi	$t7, $t7, 1
		addi	$t8, $t8, 1
		blt	$t8, 9, copy_template	
		
	li	$t9, 0		# set counter9 to 0, also known as key
		
main_loop:		
	
	# get the output pointer ready
	la	$t7, output		# t1 now point to translated				
	addi	$t7, $t7, 5		# offset by 5
	
	## this will be the key
	li	$t2, 10
	div	$t9, $t2
	mflo	$t2
	addi	$t2, $t2, 48
	sb	$t2, ($t7)
	mfhi	$t2
	addi	$t2, $t2, 48
	sb	$t2, 1($t7)
	
	addi	$t7, $t7, 3
	
	li	$t8, 0		# set counter8 to 0
	
	symbol_loop:			
		la	$t1, message		# t1 point to message
		add	$t1, $t1, $t8		# increment pointer t1 with t9
		lb	$t2, ($t1)		# read into t2, A.K.A symbol		
		
		sub 	$t0, $t2, 97		# num = LETTERS.find(symbol)		
		
		addi	$t7, $t7, 1		# increment pointer t7
		
		blt	$t0, 0, trans_plus_sym
		bge	$t0, 26, trans_plus_sym
		
		# if t0 >= 0 && t0 < 26 :
			sub	$t0, $t0, $t9		# num = num - key		
			
			bge	$t0, 0, trans_plus_lett
			# if num < 0
				addi	$t0, $t0, 26		# num = num + len(LETTERS)
			trans_plus_lett:
				add	$t2, $t0, 97		# LETTERS[num]												
				sb	$t2, ($t7)		# write t2 to output						
				
			j	end_if
			
		trans_plus_sym:			
			sb	$t2, ($t7)		# write t2 to output
		
		end_if:		
		addi	$t8, $t8, 1		# increment counter8
		blt	$t8, 51, symbol_loop	# loop till all character is readed
	
	#add null terminating character
	addi	$t7, $t7, 1
	li	$t0, 0
	sb	$t0, ($t7)
	
	# print(output)
	li	$v0, 4
	la	$a0, output
	syscall
	
	# println()	
	la	$a0, linefeed
	syscall
	
	addi	$t9, $t9, 1
	blt	$t9, 26, main_loop	# loop till 26 times
