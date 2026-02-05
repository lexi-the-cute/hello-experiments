#!/bin/sh

#	-----------------------------------------------------------------------------
# See nasm(1) and ld(1)
#	-----------------------------------------------------------------------------
#		For those new to man, a manual page is often referenced by page(chapter).
#	Manual Pages (manpages) don't necessarily have chapter names as numbers
#	only. For example, the POSIX Programmer's Manual has exec(1P). To pull up a
#	manual page, type `man chapter page`. Info pages are different. They don't
#	have a standard format, but we've been debating on if we should either use
#	the same format as manpages, or use something else like page[subsection]
#	such as tar[Sparse Formats] or use page<subsection> which could be looked
#	up via `info page "subsection"`
#
#		The Netwide Assembler (or nasm(1)) doesn't use longform args for all the
#	args we use. While unfortunate, we can explain the args in the comments to
#	make up for the lack of self-descriptive args.
#
#		Also see gcc[x86 Options] and ld[Options]
#	-----------------------------------------------------------------------------

# Compiling Works, However, Execution Segfaults on 'syscall'
#	nasm --format elf32 --debug-format dwarf --output hello.o hello.asm
	nasm -f elf32 -F dwarf -o hello.o hello.asm

#	Linking Works
#	ld --emulate elf_i386 --architecture elf32 --output hello hello.o
	ld -m elf_i386 --architecture elf32 --output hello hello.o

#	Produces working 32-bit <s>ELF</s> executable. Note: Not Locked To ELF
#	gcc -m32 -gdwarf-2 -o hello-c hello.c
#	gcc -m32 -gdwarf-2 -o hello-c hello.c
