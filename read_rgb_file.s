.data
	name: .asciiz "lena.rgb"
	request_file: .asciiz "Por favor insira o nome de um ficheiro RGB: \n"
	file_name: .space 128 #espaço para o user_input
	invalid_input: .asciiz "Erro ao abrir ficheiro, verifique se o nome que introduziu e valido! \n"
	file_content: .space 48  #conteudo do ficheiro  (48 bytes, 4x4 px)
.text

main:
	#request file name
	la $a0,request_file
	li $v0,4
	syscall
	
	#insert file name
	la $a0,file_name
	li $a1,128
	li $v0,8
	syscall
	
	
	la $a0,file_name
	jal read_rgb_file
	nop
	bltz $v0,erro
	nop
	j fim
	nop
fim:	
	li $v0,10
	syscall
erro:
	#error message
	la $a0,invalid_input
	li $v0,4
	syscall
	j main 
	nop
	
read_rgb_file:	
	addi $sp,$sp,-8
	sw $ra,0($sp) 
	sw $s0,4($sp)

	move $s0,$a0
	
	#open file
	la $a0,name
	li $a1,0
	li $a2,0
	li $v0,13
	syscall
	move $t0,$v0 #save file descriptor
	
	#read file
	move $a0,$t0
        la $a1,file_content
        li $a2,48
        li $v0, 14          
        syscall

	lw $ra,0($sp)
	lw $s0,4($sp)
	addi $sp,$sp,8
	
	jr $ra
	nop

		

