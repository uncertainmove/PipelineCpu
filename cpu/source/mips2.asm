 .text
sort_next:
 addi $s1, $s0, 10
 sw $s1, 0($s0)
 lw $s0, 0($s0)
 addi $v0, $0, 10
 syscall
