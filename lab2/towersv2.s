	.arch armv6
	.fpu vfp
	.text

@ print function is complete, no modifications needed
    .global	print
print:
	stmfd	sp!, {r3, lr}
	mov	r3, r0
	mov	r2, r1
	ldr	r0, startstring
	mov	r1, r3
	bl	printf
	ldmfd	sp!, {r3, pc}

myprint:
   stmfd sp!, {r0-r6, lr}
   mov   r6, r0
   ldr   r0, mystring
   bl printf
   ldmfd sp!, {r0-r6, pc}

mystring:
   .word mystring0

startstring:
	.word	string0

    .global	towers
towers:

	sub sp, sp, #4 /*save return address*/
	str lr, [sp, #0]

   /* Save calllee-saved registers to stack */
   @assume r4 = steps, r5 = peg
   sub sp, sp, #4 /*making space on the stack for int steps var*/
   sub sp, sp, #4 /*making space on the stack for int peg var*/
   str r4, [sp, #4] /*save r4 to the stack for steps var*/
   str r5, [sp, #8] /*save r5 to the stack for pegs var*/

   /* Save a copy of all 3 incoming parameters */
   sub sp, sp, #4 /*making space on the stack for int numDisks*/
   sub sp, sp, #4 /*making space on the stack for int start*/
   sub sp, sp, #4 /*making space on the stack for int goal*/
   @ assume r0 = numDisks, r1 = start, r2 = goal
   str r0, [sp, #12] /*save r0 to the stack for numDisks var*/
   str r1, [sp, #16] /*save r1 to the stack for start var*/
   str r2, [sp, #20] /*save r2 to the stack for goal var*/
   
   bl myprint

if:
   /* Compare numDisks with 2 or (numDisks - 2)*/
   cmp r0, #2 /*??????????????*/
   /* Check if less than, else branch to else */
   bge else
   /* set print function's start to incoming start */
   mov r0, r1 /*???????*/
   /* set print function's end to goal */
   mov r1, r2 /*???????*/
   /* call print function */
   bl print
   /* Set return register to 1 */
   mov r0, #1
   /* branch to endif */
   b endif

else:
   /* Use a callee-saved varable for temp and set it to 6 */
   mov r5, #6
   /* Subract start from temp and store to itself */
   sub r5, r5, r1
   /* Subtract goal from temp and store to itself (temp = 6 - start - goal)*/
   sub r5, r5, r2
   /* subtract 1 from original numDisks and store it to numDisks parameter */
   sub r0, r0, #1

   /* Set end parameter as temp */
   mov r2, r5 /*?????????????*/
   /* Call towers function */
   bl towers

   /* Save result to callee-saved register for total steps */
   mov r4, r0
   /* Set numDiscs parameter to 1 */
   ldr r0, [sp, #8] /*???????????????*/
   mov r0, #1
   /* Set start parameter to original start */
   ldr r1, [sp, #4] /*???????????*/
   /* Set goal parameter to original goal */
   ldr r2, [sp, #0] /*???????????*/
   /* Call towers function */
   bl towers

   /* Add result to total steps so far */
   add r4, r4, r0
   /* Set numDisks parameter to original numDisks - 1 */
   ldr r0, [sp, #8] /*???????????*/
   sub r0, r0, #1 
   /* set start parameter to temp */
   mov r1, r5
   /* set goal parameter to original goal */
   ldr r2, [sp, #0] /*???????????*/
   /* Call towers function */
   bl towers
   /* Add result to total steps so far and save it to return register */
   add r4, r4, r0
   mov r0, r4

endif:
   /* Restore Registers */
   ldr r2, [sp, #0]
   ldr r1, [sp, #4]
   ldr r0, [sp, #8]
   ldr r5, [sp, #12]
   ldr r4, [sp, #16]
   ldr lr, [sp, #0]
   add sp, sp, #24

   mov pc, lr

@ Function main is complete, no modifications needed
    .global	main
main:
	str	lr, [sp, #-4]!
	sub	sp, sp, #20
	ldr	r0, printdata
	bl	printf
	ldr	r0, printdata+4
	add	r1, sp, #12
	bl	scanf
	ldr	r0, [sp, #12]
	mov	r1, #1
	mov	r2, #3
	bl	towers
	str	r0, [sp]
	ldr	r0, printdata+8
	ldr	r1, [sp, #12]
	mov	r2, #1
	mov	r3, #3
	bl	printf
	mov	r0, #0
	add	sp, sp, #20
	ldr	pc, [sp], #4
end:

printdata:
	.word	string1
	.word	string2
	.word	string3

string0:
	.asciz	"Move from peg %d to peg %d\n"
string1:
	.asciz	"Enter number of discs to be moved: "
string2:
	.asciz	"%d"
	.space	1
string3:
	.ascii	"\n%d discs moved from peg %d to peg %d in %d steps."
	.ascii	"\012\000"

mystring0:
   .ascii   "r0: %d, r1: %d, r2: %d, r3: %d, r4: %d, r5: %d\n"

