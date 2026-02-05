; This program just prints `hello world\n`, then exits

global _start

section .text

_start:
  mov eax, 4        ; write(
  mov edi, 1        ;   STDOUT_FILENO,
  mov esi, msg      ;   "hello world!\n",
  mov edx, msglen   ;   sizeof("hello world\n")
  syscall           ; );

  mov eax, 60       ; exit(
  mov edi, 0        ;   EXIT_SUCCESS
  syscall           ; );

section .rodata
  msg: db "hello world", 0x0A
  msglen: equ $ - msg
