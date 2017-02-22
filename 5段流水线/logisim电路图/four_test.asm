.text
 addi $s0, $zero, 1
 addi $s3, $zero, 0xffe
 addi $s1, $zero, 0
xor_sltiu_test:
 addi $s1, $s1, 1
 xor $s3, $s1, $s3
 addi $a0, $s3, 0
 addi $v0, $zero, 34
 syscall
 sltiu $s2, $s1, 8
 beq $s2, $s0, xor_sltiu_test
 addi $s0, $zero, -40
 addi $s3, $zero, 0x1100
lbu_bltz_test:
 addi $s3, $s3, 1
 sw $s3, 40($s0)
 lbu $a0, 40($s0)
 addi $s0, $s0, 4
 addi $v0, $zero, 34
 syscall
 bltz $s0, lbu_bltz_test
 
 addi $v0, $zero, 10
 syscall

