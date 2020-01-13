#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#define BUFF_SIZE 512

static const char *const	errs[] = {
	"Unknown Error",
	"Invalid arguments",
	"Missing file"
};

void	error_exit(const int id) {
	if (id < 0 || id >= (int)(sizeof(errs)/sizeof(char*)))
		exit(2);
	write(STDERR_FILENO, errs[id], strlen(errs[id]));
	exit(1);
}

void	perror_exit(const char *msg) {
	perror(msg);
	exit(1);
}

int main(int ac, char *av[]) {
	int		fd_src, fd_dst;
	char	buffer[BUFF_SIZE];
	ssize_t	rmemsz;

	if (ac != 3)
		error_exit(1);
	if ((fd_src = open(av[1], O_RDONLY)) < 0)
		perror_exit("Source file open");
	if ((fd_dst = open(av[2], O_WRONLY)) < 0)
		perror_exit("Destination file open");
	for (;;) {
		rmemsz = read(fd_src, buffer, BUFF_SIZE);
		if (rmemsz == 0)
			break;
		if (rmemsz < 0)
			perror_exit("Read file");
		rmemsz = write(fd_dst, buffer, rmemsz);
		if (rmemsz < 0)
			perror_exit("Write file");
	}
	close(fd_src);
	close(fd_dst);
	return (0);
}