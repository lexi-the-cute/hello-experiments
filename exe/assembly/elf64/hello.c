// This program just prints `hello world\n`, then exits
//
// See syscall(2) and unistd.h(0P)

#include <unistd.h>
#include <stdlib.h>

#define msg "hello world\n"
#define msglen sizeof(msg)

void main() {
	write(STDOUT_FILENO, msg, msglen);
	exit(EXIT_SUCCESS);
}
