/**************************************/
/* Emmanuel Taylor                    */
/* CMSC216: Multithreaded Mergesort   */
/* UID: 111615834                     */
/* Directory ID: etaylor5             */
/*                                    */
/* mergetest.c                        */
/**************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sysexits.h>
#include <sys/time.h>
#include <sys/resource.h>
#include <time.h>
#include <err.h>
#include <pthread.h>
#include "mergesort.h"

#define NUM_THREADS 8

/* Comparison function that is passed to mergesort and mt_mergesort in the 
   mergesort.c file. */
static int compare(const void * a, const void * b) {
  int *x = (int *) a;
  int *y = (int *) b;

  if (*x > *y) {
    return 1;
  }

  if (*x == *y) {
    return 0;
  }

  return -1;
}

/* In this main function, mt_mergesort and mergesort are tested. This function
   will display the measured time taken to run each function with an array that
   is populated with randomly generated numbers. */
int main(int argc, char *argv[]) {
  int num_ints, seed, upper_bound, elements, index, index2, *arr, *temp;
  struct rusage start_rusage, end_rusage;
  struct timeval start_wall, end_wall;
  
  /* Handles if the user has the incorrect usage of mergetest. */
  if (argc < 5) {
    printf("Usage: mergetest <num ints> <elements> <seed> <upper bound>.\n");
    return 1;
  }

  /* Stores the numeric values of each argument inside of an int. */
  num_ints = atoi(argv[1]);
  elements = atoi(argv[2]);
  seed = atoi(argv[3]);
  upper_bound = atoi(argv[4]);

  /* Allocating space for the array. */
  arr = malloc(sizeof(int) * num_ints);

  /* If arr is NULL, the malloc failed. */
  if (arr == NULL) {
    printf("Error: Failed to do malloc() for arr.\n");
    return -1;
  }

  /* Allocating space for the temporary array. */
  temp = malloc(sizeof(int) * num_ints);
  
  /* If temp is NULL, the malloc failed. */
  if (temp == NULL) {
    printf("Error: Failed to do malloc() for temp.\n");
    return -1;
  }

  srand(seed);

  /* The array is filled with random integers. */
  for (index = 0; index < num_ints; index++) {
    arr[index] = rand() % upper_bound;
  }

  for (index = 0; index <= NUM_THREADS; index++) {
    for (index2 = 0; index2 < num_ints; index2++) {
      temp[index2] = arr[index2];
    }

    /* Starting wall timed measurements. */
    gettimeofday(&start_wall, NULL);
    getrusage(RUSAGE_SELF, &start_rusage);
    
    if (!index) {
      mergesort(temp, num_ints, sizeof(int), compare);
    }
    else {
      mt_mergesort(temp, num_ints, elements, sizeof(int), compare, index);
    }
    
    /* Ending wall timed measurements. */
    gettimeofday(&end_wall, NULL);
    getrusage(RUSAGE_SELF, &end_rusage);
    end_wall.tv_sec -= start_wall.tv_sec;

    if ((end_wall.tv_usec -= start_wall.tv_usec) < 0) {
      end_wall.tv_usec += 1000000;
      end_wall.tv_sec--;
    }

    /* Getting the user time. */
    end_rusage.ru_utime.tv_sec -= start_rusage.ru_utime.tv_sec;

    if ((end_rusage.ru_utime.tv_usec -= start_rusage.ru_utime.tv_usec) < 0) {
      end_rusage.ru_utime.tv_usec += 1000000;
      end_rusage.ru_utime.tv_sec--;
    }

    /* Getting the system time. */
    end_rusage.ru_stime.tv_sec -= start_rusage.ru_stime.tv_sec;

    if ((end_rusage.ru_stime.tv_usec -= start_rusage.ru_stime.tv_usec) < 0) {
      end_rusage.ru_stime.tv_usec += 1000000;
      end_rusage.ru_stime.tv_sec--;
    }

    /* Displaying timed values. */
    printf("%d threads: ", index);
    printf("%ld.%06ld wall; %ld.%06ld user; %ld.%06ld sys\n",
	   end_wall.tv_sec, end_wall.tv_usec,
	   end_rusage.ru_utime.tv_sec, end_rusage.ru_utime.tv_usec,
	   end_rusage.ru_stime.tv_sec, end_rusage.ru_stime.tv_usec);
  }

  /* Freeing the allocated space for arr and temp. */
  free(arr);
  free(temp);
  return 0;
}
