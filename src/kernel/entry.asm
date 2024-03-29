BITS 32
CPU 386

EXTERN main
EXTERN printString
EXTERN printHex

cli

; Set up the PIC to send IRQs to the right offset
mov al, 0x11
out 0x20, al
out 0xA0, al

mov al, 0x70 ; IRQ 0-7 goes on this offset
out 0x21, al
mov al, 0x78 ; and IRQ 8-15 goes here
out 0xA1, al

mov al, 0x04
out 0x21, al
mov al, 0x02
out 0xA1, al

mov al, 0x01
out 0x21, al
out 0xA1, al

; Load interrupt table!
lidt [idt]
sti

call main

push STR_GOODBYE
call printString

jmp $

handle_keyboard:
	pushad
	mov ebp, esp

	push STR_KEYBOARD
	call printString
	pop eax

	xor eax,eax
	in al, 60h
	push eax
	call printHex
	pop eax

	mov al, 20h
	out 20h, al

	popad
	iret

exception0:
	pushad
	mov ebp, esp
	sub esp, 8
	push 0x0
	jmp exception_common
exception1:
	pushad
	mov ebp, esp
	sub esp, 8
	push 0x1
	jmp exception_common
exception2:
	pushad
	mov ebp, esp
	sub esp, 8
	push 0x2
	jmp exception_common
exception3:
	pushad
	mov ebp, esp
	sub esp, 8
	push 0x3
	jmp exception_common
exception4:
	pushad
	mov ebp, esp
	sub esp, 8
	push 0x4
	jmp exception_common
exception5:
	pushad
	mov ebp, esp
	sub esp, 8
	push 0x5
	jmp exception_common
exception6:
	pushad
	mov ebp, esp
	sub esp, 8
	push 0x6
	jmp exception_common
exception7:
	pushad
	mov ebp, esp
	sub esp, 8
	push 0x7
	jmp exception_common
int_doublefault:
	pushad
	mov ebp,esp
	sub esp, 8
	push STR_DOUBLEFAULT
	call printString
	mov esp,ebp
	mov al, 20h
	out 20h, al
	popad
	iret
exception9:
	pushad
	mov ebp, esp
	sub esp, 8
	push 0x9
	jmp exception_common
exceptionA:
	pushad
	mov ebp, esp
	sub esp, 8
	push 0xA
	jmp exception_common
exceptionB:
	pushad
	mov ebp, esp
	sub esp, 8
	push 0xB
	jmp exception_common
exceptionC:
	pushad
	mov ebp, esp
	sub esp, 8
	push 0xC
	jmp exception_common
exceptionD:
	pushad
	mov ebp, esp
	sub esp, 8
	push 0xD
	jmp exception_common
exceptionE:
	pushad
	mov ebp, esp
	sub esp, 8
	push 0xE
	jmp exception_common
exceptionF:
	pushad
	mov ebp, esp
	sub esp, 8
	push 0xF
	jmp exception_common
exception10:
	pushad
	mov ebp, esp
	sub esp, 8
	push 0x10
	jmp exception_common
exception11:
	pushad
	mov ebp, esp
	sub esp, 8
	push 0x11
	jmp exception_common
exception12:
	pushad
	mov ebp, esp
	sub esp, 8
	push 0x12
	jmp exception_common
exception13:
	pushad
	mov ebp, esp
	sub esp, 8
	push 0x13
	jmp exception_common
exception_common:
	call printHex
	push STR_EXCEPTION
	call printString
	mov esp, ebp
	mov al, 20h
	out 20h, al
	popad
	iret

irq0:
	pushad
	mov al, 20h
	out 20h, al
	popad
	iret
irq1:
	pushad
	mov ebp, esp
	sub esp, 8
	push 1
	jmp irq_common
irq2:
	pushad
	mov ebp, esp
	sub esp, 8
	push 2
	jmp irq_common
irq3:
	pushad
	mov ebp, esp
	sub esp, 8
	push 3
	jmp irq_common
irq4:
	pushad
	mov ebp, esp
	sub esp, 8
	push 4
	jmp irq_common
irq5:
	pushad
	mov ebp, esp
	sub esp, 8
	push 5
	jmp irq_common
irq6:
	pushad
	mov ebp, esp
	sub esp, 8
	push 6
	jmp irq_common
irq7:
	pushad
	mov ebp, esp
	sub esp, 8
	push 7
	jmp irq_common
irq8:
	pushad
	mov ebp, esp
	sub esp, 8
	push 8
	jmp irq_common
irq9:
	pushad
	mov ebp, esp
	sub esp, 8
	push 9
	jmp irq_common
irq10:
	pushad
	mov ebp, esp
	sub esp, 8
	push 10
	jmp irq_common
irq11:
	pushad
	mov ebp, esp
	sub esp, 8
	push 11
	jmp irq_common
irq12:
	pushad
	mov ebp, esp
	sub esp, 8
	push 12
	jmp irq_common
irq13:
	pushad
	mov ebp, esp
	sub esp, 8
	push 13
	jmp irq_common
irq14:
	pushad
	mov ebp, esp
	sub esp, 8
	push 14
	jmp irq_common
irq15:
	pushad
	mov ebp, esp
	sub esp, 8
	push 15
	jmp irq_common
irq_common:
	call printHex
	push STR_IRQ
	call printString
	mov esp, ebp
	mov al, 20h
	out 20h, al
	popad
	iret

; Interrupt Descriptor Table
idt_start:
	dw exception0
	dw 0x8
	db 0
	db 10001110b
	dw 0

	dw exception1
	dw 0x8
	db 0
	db 10001110b
	dw 0

	dw exception2
	dw 0x8
	db 0
	db 10001110b
	dw 0

	dw exception3
	dw 0x8
	db 0
	db 10001110b
	dw 0

	dw exception4
	dw 0x8
	db 0
	db 10001110b
	dw 0

	dw exception5
	dw 0x8
	db 0
	db 10001110b
	dw 0

	dw exception6
	dw 0x8
	db 0
	db 10001110b
	dw 0

	dw exception7
	dw 0x8
	db 0
	db 10001110b
	dw 0

	dw int_doublefault
	dw 0x8
	db 0
	db 10001110b
	dw 0

	dw exception9
	dw 0x8
	db 0
	db 10001110b
	dw 0

	dw exceptionA
	dw 0x8
	db 0
	db 10001110b
	dw 0

	dw exceptionB
	dw 0x8
	db 0
	db 10001110b
	dw 0

	dw exceptionC
	dw 0x8
	db 0
	db 10001110b
	dw 0

	dw exceptionD
	dw 0x8
	db 0
	db 10001110b
	dw 0

	dw exceptionE
	dw 0x8
	db 0
	db 10001110b
	dw 0

	dw exceptionF
	dw 0x8
	db 0
	db 10001110b
	dw 0

	dw exception10
	dw 0x8
	db 0
	db 10001110b
	dw 0

	dw exception11
	dw 0x8
	db 0
	db 10001110b
	dw 0

	dw exception12
	dw 0x8
	db 0
	db 10001110b
	dw 0

	dw exception13
	dw 0x8
	db 0
	db 10001110b
	dw 0

	; Skip interrupts we don't care about for now
	times 8*(6Fh-13h) db 0x00

	dw irq0
	dw 0x8
	db 0
	db 10001110b
	dw 0

	; 71h = IRQ1 = keyboard
	dw handle_keyboard
	dw 0x8
	db 0
	db 10001110b
	dw 0

	dw irq2
	dw 0x8
	db 0
	db 10001110b
	dw 0

	dw irq3
	dw 0x8
	db 0
	db 10001110b
	dw 0

	dw irq4
	dw 0x8
	db 0
	db 10001110b
	dw 0

	dw irq5
	dw 0x8
	db 0
	db 10001110b
	dw 0

	dw irq6
	dw 0x8
	db 0
	db 10001110b
	dw 0

	dw irq7
	dw 0x8
	db 0
	db 10001110b
	dw 0

	dw irq8
	dw 0x8
	db 0
	db 10001110b
	dw 0

	dw irq9
	dw 0x8
	db 0
	db 10001110b
	dw 0

	dw irq10
	dw 0x8
	db 0
	db 10001110b
	dw 0

	dw irq11
	dw 0x8
	db 0
	db 10001110b
	dw 0

	dw irq12
	dw 0x8
	db 0
	db 10001110b
	dw 0

	dw irq13
	dw 0x8
	db 0
	db 10001110b
	dw 0

	dw irq14
	dw 0x8
	db 0
	db 10001110b
	dw 0

	dw irq15
	dw 0x8
	db 0
	db 10001110b
	dw 0

idt_end:
idt:
	dw idt_end - idt_start
	dd idt_start

STR_GOODBYE: db "Goodbye, shutting down!", 0
STR_KEYBOARD: db "KEYBOARD!!!", 0
STR_DOUBLEFAULT: db "DOUBLE FAULT!!!", 0
STR_EXCEPTION: db "EXCEPTION", 0
STR_IRQ: db "IRQ", 0
