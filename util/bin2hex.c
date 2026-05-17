#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>
#include <stdlib.h>

#define RECLEN	16

static int cs;

void phexb(int b) {
	b &= 0xff;
	printf("%02X", b);
	cs += b;
}

void phexw(int w) {
	phexb(w >> 8);
	phexb(w);
}

int main(int argc, char **argv) {
	int x, y;
	struct stat stb;
	int fd;
	int org = 0x100;
	unsigned char *buf;
	extern char *optarg;
	extern int optind;

	while ((x = getopt(argc, argv, "o:")) != EOF) {
		switch (x) {
		case 'o':
			org = strtoul(optarg, NULL, 0);
			break;
		}
	}
	if (optind >= argc) {
		fprintf(stderr, "Usage: %s [-o org] file\n", argv[0]);
		exit(1);
	}
	fd = open(argv[optind], O_RDONLY);
	if (fd < 0) {
		perror(argv[optind]);
		exit(1);
	}
	fstat(fd, &stb);
	buf = malloc(stb.st_size);
	if (buf == NULL) {
		perror("malloc");
		exit(1);
	}
	x = read(fd, buf, stb.st_size);
	if (x < 0) {
		perror(argv[optind]);
		exit(1);
	}
	close(fd);
	if (x != stb.st_size) {
		fprintf(stderr, "%s: wrong size\n", argv[optind]);
		exit(1);
	}
	cs = 0;
	while (x > 0) {
		if (x > 16) y = 16;
		else y = x;

		putchar(':');
		phexb(y);
		phexw(org);
		phexb(0);
		while (y > 0) {
			phexb(*buf++);
			++org;
			--x;
			--y;
		}
		phexb(-cs);
		putchar('\n');
	}
	printf(":0000000000\n");
	return 0;
}
