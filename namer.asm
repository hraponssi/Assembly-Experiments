; namer.asm
;
; Author: Hraponssi
; Date: 18-Sep-2022

section .data				; Initialized variables
	motd: db "Welcome to Namer!", 0xA
	motd_length equ $-motd
	setname: db "Set a name: "
	setname_length equ $-setname
	newline: db 0xA
	nameis: db "Your name is: "
	nameis_length equ $-nameis
	
section .bss				; Variables not initialized
	uname: resb 32

global _start

section .text

exit:
	;Exit
	mov eax, 0x1			; Exit syscall
	mov ebx, 0				; Exit/return code/value
	int 0x80				; Invoke syscall

setnamef:
	;Print setname
	mov eax, 0x4			; Write syscall
	mov ebx, 1				; Stdout as the fd
	mov ecx, setname		; Message as the buffer
	mov edx, setname_length	; Give the length
	int 0x80				; Invoke syscall

	;Get input name
	mov eax, 0x3			; Read syscall
	mov ebx, 0				; Stdin as the fd
	mov ecx, uname			; Message as the buffer
	mov edx, 32				; Give the length
	int 0x80				; Invoke syscall

	;Print nameis
	mov eax, 0x4			; Write syscall
	mov ebx, 1				; Stdout as the fd
	mov ecx, nameis			; Message as the buffer
	mov edx, nameis_length	; Give the length
	int 0x80				; Invoke syscall

	;Print uname
	mov eax, 0x4			; Write syscall
	mov ebx, 1				; Stdout as the fd
	mov ecx, uname			; Message as the buffer
	mov edx, 32				; Give the length
	int 0x80				; Invoke syscall
	
	call exit

main:
	;Print motd
	mov eax, 0x4			; Write syscall
	mov ebx, 1				; Stdout as the fd
	mov ecx, motd			; Message as the buffer
	mov edx, motd_length	; Give the length
	int 0x80				; Invoke syscall
	
	call setnamef

_start:
	call main
