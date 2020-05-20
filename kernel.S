.global lab3
.syntax unified

.global vtable_kernel
.global __kernel_reset__

.type vtable_kernel, %object
.type __kernel_reset__, %function

.section .interrupt_vector
vtable_kernel:
	.word __stack_start
	.word __kernel_reset__+1
	.size vtable_kernel, .-vtable_kernel

.section .rodata
	data: .asciz "kernel started\n"
	result: .asciz "Value in R3: "

__kernel_reset__:
    ldr r0, =data
    bl dbgput_line

    mov R3, #4 //A
    mov R4, #2 //B
    mov R5, #2 //C
    mov R6, #4 //A
    bl test_var

    stat1:
	add R3, R3, R4
	sdiv R3, R3, R5
	b finish

    stat2:
	sub R3, R3, R4
	sdiv R3, R3, R5
	b finish

    test_var:
	sub R6, R6, R4
	cmp R6, 0
	bge stat1
	blt stat2

    finish:
	ldr r0, =result
	bl dbgput
	mov r0, r3
	bl dbgput_num

task_end:
        b task_end
