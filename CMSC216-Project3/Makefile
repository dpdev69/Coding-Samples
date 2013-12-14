CC = gcc
CFLAGS = -ansi -Wall -g -O0 -Wwrite-strings -Wshadow -pedantic-errors \
	 -fstack-protector-all
PROGS = public01 public02 studentTests

.PHONY: all clean

all: $(PROGS)

clean:
	rm -f *.o $(PROGS)

public01: public01.o htable.o my_memory_checker_216.o
	$(CC) -o public01 public01.o htable.o my_memory_checker_216.o

public02: public02.o htable.o
	$(CC) -o public02 public02.o htable.o

studentTests: studentTests.o htable.o my_memory_checker_216.o
	$(CC) -o studentTests studentTests.o htable.o my_memory_checker_216.o

public01.o: public01.c htable.h my_memory_checker_216.h
	$(CC) $(CFLAGS) -c public01.c

public02.o: public02.c htable.h
	$(CC) $(CFLAGS) -c public02.c

studentTests.o: studentTests.c htable.h my_memory_checker_216.h
	$(CC) $(CFLAGS) -c studentTests.c

htable.o: htable.c htable.h
	$(CC) $(CFLAGS) -c htable.c

my_memory_checker_216.o: my_memory_checker_216.c my_memory_checker_216.h
	$(CC) $(CFLAGS) -c my_memory_checker_216.c
