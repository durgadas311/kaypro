#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <stdlib.h>

int main(int argc, char **argv) {
	int x;
	int fd = -1;
	int or = 0;
	int and = 0;
	int d_or = 0;
	int d_and = 0;
	int adr;
	unsigned char dat;
	struct stat stb;
	unsigned char *buf;

	extern int optind;
	extern char *optarg;

	while ((x = getopt(argc, argv, "a:A:o:O:")) != EOF) {
		switch (x) {
		case 'a':
			and = strtoul(optarg, NULL, 0);
			break;
		case 'A':
			d_and = strtoul(optarg, NULL, 0);
			break;
		case 'o':
			or = strtoul(optarg, NULL, 0);
			break;
		case 'O':
			d_or = strtoul(optarg, NULL, 0);
			break;
		}
	}
	x = optind;
	if (x >= argc) {
		fprintf(stderr, "Usage: %s [-a <mask>][-o <mask>] file\n", argv[0]);
		exit(1);
	}
	fd = open(argv[x], O_RDONLY);
	if (fd < 0) {
		perror(argv[x]);
		exit(1);
	}
	fstat(fd, &stb);
	buf = malloc(stb.st_size);
	if (!buf) {
		perror(argv[x]);
		exit(1);
	}
	read(fd, buf, stb.st_size);
	close(fd);

	for (x = 0; x < stb.st_size; ++x) {
		adr = (x & ~and) | or;
		adr &= stb.st_size - 1;
		dat = (buf[adr] & ~ d_and) | d_or;
		write(1, &dat, 1);
	}
	free(buf);
	return 0;
}
