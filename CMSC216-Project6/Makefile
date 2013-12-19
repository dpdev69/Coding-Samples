CC = gcc
CFLAGS = -ansi -Wall -g -O0 -Wwrite-strings -Wshadow -fstack-protector-all
TFLAGS = -lpthread
PROGS = mergetest public00 public01 public02 public03 public04 public05

.PHONY: all clean

all: $(PROGS)

clean:
	rm -f *.o *~ $(PROGS)
	
mergetest: mergesort.o mergetest.o
	$(CC) $(TFLAGS) -o mergetest mergetest.o mergesort.o
	
public00: public00.o mergesort.o
	$(CC) $(TFLAGS) -o public00 public00.o mergesort.o
	
public01: public01.o mergesort.o
	$(CC) $(TFLAGS) -o public01 public01.o mergesort.o
	
public02: public02.o mergesort.o
	$(CC) $(TFLAGS) -o public02 public02.o mergesort.o
	
public03: public03.o mergesort.o
	$(CC) $(TFLAGS) -o public03 public03.o mergesort.o
	
public04: public04.o mergesort.o
	$(CC) $(TFLAGS) -o public04 public04.o mergesort.o
	
public05: public05.o mergesort.o
	$(CC) $(TFLAGS) -o public05 public05.o mergesort.o
	
mergetest.o: mergesort.h mergetest.c
	$(CC) $(TFLAGS) $(CFLAGS) -c mergetest.c
	
mergesort.o: mergesort.h mergesort.c
	$(CC) $(TFLAGS) $(CFLAGS) -c mergesort.c
	
public00.o: mergesort.h public00.c
	$(CC) $(TFLAGS) $(CFLAGS) -c public00.c
	
public01.o: mergesort.h public01.c
	$(CC) $(TFLAGS) $(CFLAGS) -c public01.c
	
public02.o: mergesort.h public02.c
	$(CC) $(TFLAGS) $(CFLAGS) -c public02.c
	
public03.o: mergesort.h public03.c
	$(CC) $(TFLAGS) $(CFLAGS) -c public03.c
	
public04.o: mergesort.h public04.c
	$(CC) $(TFLAGS) $(CFLAGS) -c public04.c
	
public05.o: mergesort.h public05.c
	$(CC) $(TFLAGS) $(CFLAGS) -c public05.c
	
