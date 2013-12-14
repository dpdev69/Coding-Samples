/**************************************/ 
/* Emmanuel Taylor                    */ 
/* CMSC216: Multithreaded Mergesort   */ 
/* UID: 111615834                     */ 
/* Directory ID: etaylor5             */ 
/*                                    */ 
/* mergesort.c                        */ 
/**************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sysexits.h>
#include <pthread.h>
#include <err.h>
#include "mergesort.h"

/* Declaration of the thread mutex, task queue, and compare function. */
static pthread_mutex_t thread_mutex = PTHREAD_MUTEX_INITIALIZER;
static Chunk *queue = NULL;
static Compare_fn global_cmp;

/* Function prototype declarations. */
static void merge_helper(void *, void *, size_t, Compare_fn, size_t);
static void create(Chunk *, Chunk *, Chunk *, size_t);
static void insert(void *, int, int, int);
static void remove_c(Chunk *);
static void insert_at_end(Chunk *, Chunk *);
static void *chunk_remove();

/* This function will recursively call itself on each half of the array until
   the size becomes 1. Next the merge_helper function is called to merge the
   pieces of the array back together. */
void mergesort(void *arr, size_t num_elem, size_t elem_size, Compare_fn cmp) {
  void *breakpoint = arr + elem_size * (num_elem / 2);

  /* If either cmp or arr is NULL, return the array without changing it. */
  if (cmp == NULL || arr == NULL){
    return;
  }

  /* Arrays of size 1 are automatically sorted. If this is reached, return. */
  if (num_elem <= 1){
    return;
  }

  /* Recursively call on each half of an array and then merge them back together
     after they have been sorted. */
  mergesort(arr, num_elem / 2, elem_size, cmp);
  mergesort(breakpoint, num_elem - num_elem / 2, elem_size, cmp);
  merge_helper(arr, breakpoint, num_elem, cmp, elem_size);
}

/* This is the merge helper function that is used in mergesort to merge 
   together arrays that have been sorted. */
void merge_helper(void *start, void *half, size_t num, Compare_fn cmp,
		  size_t size) {
  char *location = calloc(num, size);
  size_t mid = num / 2;
  size_t index = 0, index2 = 0;
  char *place = location;

  while (index < mid && index2 < num - mid){
    if (cmp(start + (index * size), half + (index2 * size)) <= 0){
      memcpy(place, start + (index * size), size);
      index++;
    }
    else {
      memcpy(place, half + (index2 * size), size);
      index2++;
    }

    place += size;
  }

  while (index < mid){
    memcpy(place, start + (index * size), size);
    place += size;
    index++;
  }

  while (index2 < (num - mid)){
    memcpy(place, half + (index2 * size), size);
    place += size;
    index2++;
  }

  memcpy(start, location, size * num);
  free(location);
}

/* This function breaks the array down into chunks, and creates threads to take
   chunks out of the task queue. The chunks will be sorted and placed back into
   the queue. */
void mt_mergesort(void *arr, size_t num_elem, int chunk_size, size_t elem_size,
		  Compare_fn cmp, int num_threads) {
  int num_of_chunks, index, first;
  void *temp;
  pthread_t *tid;

  /* If either cmp or arr is NULL, return the array without changing it. */
  if (cmp == NULL || arr == NULL) {
    return;
  }

  /* If these limits aren't met, return the array without changing it. */
  if (chunk_size < 1 || chunk_size > 1073741824) {
    return;
  }

  /* If these limits aren't met, return the array without changing it. */
  if (num_threads < 1 || num_threads > 1024) {
    return;
  }

  global_cmp = cmp;

  tid = malloc(sizeof(pthread_t) * num_threads);

  /* If tid is NULL, exit. */
  if (tid == NULL) {
    return;
  }

  num_of_chunks = num_elem / chunk_size;
  
  for (index = 0; index < num_of_chunks; index++) {
    first = index * chunk_size;
    temp = &((char *)arr)[first];
    insert(temp, first, chunk_size, 0);
  }

  for (index = 0; index < num_threads; index++) {
    if(pthread_create(&tid[index], NULL, chunk_remove, &elem_size)) {
      return;
    }

    if(pthread_join(tid[index], NULL)) {
      return;
    }
  }
}

/* This function merges chunks together. */
void create(Chunk *new, Chunk *chunk, Chunk *chunk2, size_t elem_size) {
  new -> done = 0;
  new -> next = NULL;

  if (chunk -> first < chunk2 -> first) {
    new -> first = chunk -> first;
    new -> arr = chunk -> arr;
  } 
  else {
    new -> first = chunk2 -> first;
    new -> arr = chunk2 -> arr;
  }

  new -> size = chunk -> size + chunk2 -> size;
}
 
/* This function adds each individual chunk together forming the initial task
   queue that is used. */
void insert(void *arr, int first, int size, int done) {
  Chunk *chunk;
  chunk = malloc(sizeof(struct Chunk));

  if (chunk == NULL) {
    return;
  }

  chunk -> first = first;
  chunk -> arr = arr;
  chunk -> size = size;
  chunk -> done = done;
  chunk -> next = queue;
  queue = chunk;
}

/* This function removes chunks from the task queue. */
void remove_c(Chunk *to_remove) {
  Chunk *temp = queue;
  
  if (temp == NULL) {
    return;
  }

  if (temp == to_remove) {
    queue = queue -> next;
    free(to_remove);
  }

  temp = queue;

  while (temp -> next != NULL) {

    if (temp -> next == to_remove) {
      temp -> next = temp -> next -> next;
      free(to_remove);
    }

    temp = temp -> next;
  }
}

/* This function inserts chunks at the end of the task queue. */
void insert_at_end(Chunk *temp, Chunk *to_insert) {
  temp = queue;

  while (temp -> next) {
    temp = temp -> next;
  }

  temp -> next = to_insert;
  temp -> next -> next = NULL;
}

/* Threads call this function to implement mergesorting for chunks. */
void *chunk_remove(void *arg) {
  Chunk *chunk, *new, *temp, *first = NULL, *second = NULL;
  int chunk_first, chunk_flag = 1;
 
  pthread_mutex_lock(&thread_mutex);
  
  while(chunk_flag) {
    chunk_flag = 0;
    chunk = queue;
    chunk_first = chunk -> first;
    
    if (queue -> done == 0) {
      if(chunk -> next != NULL) {
        queue = queue -> next;
      }

      mergesort(chunk -> arr, chunk -> size, * ((size_t *) arg), global_cmp);
      chunk -> done = 1;

      /* Place the chunk back into the queue. */
      if (chunk -> next != NULL) {
        insert_at_end(temp, chunk);
      }
    }

    temp = queue;

    /* Checking for chunks that are done. */
    while (temp) {
      if (temp -> first == chunk_first) {
        if (temp -> done) {
          if (first != NULL && first == temp) {
            temp = temp -> next;
          }

          if (first != NULL && temp != first && temp -> size == first -> size) {
            second = temp;
            new = malloc(sizeof(struct Chunk));

            if (new == NULL) {
              return;
	    }

            create(new, first, second, *((size_t *)arg));
            insert_at_end(temp, new);  
            remove_c(second);
            remove_c(first);
            first = NULL;
            second = NULL;
            temp = queue;
          } 
	  else {
            first = temp;
          }
        }
      }

      temp = temp -> next;
    }

    temp = queue;

    if (temp -> next == NULL) {
      mergesort(temp -> arr, temp -> size, *((size_t *)arg), global_cmp);
      temp -> done = 1;
    }

    while (temp) {
      if (temp -> done == 0 && queue -> next != NULL) {
        chunk_flag = 1;
      }

      temp = temp -> next;
    }
  }

  pthread_mutex_unlock(&thread_mutex);
  pthread_exit(NULL);
}
