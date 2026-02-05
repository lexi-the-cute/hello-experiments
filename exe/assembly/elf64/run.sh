#!/bin/sh

#	-----------------------------------------------------------------------------
#		For those new to man, a manual page is often referenced by page(chapter).
#	Manual Pages (manpages) don't necessarily have chapter names as numbers
#	only. For example, the POSIX Programmer's Manual has exec(1P). To pull up a
#	manual page, type `man chapter page`. Info pages are different. They don't
#	have a standard format, but we've been debating on if we should either use
#	the same format as manpages, or use something else like page[subsection]
#	such as tar[Sparse Formats] or use page<subsection> which could be looked
#	up via `info page "subsection"`
#	-----------------------------------------------------------------------------

./hello
