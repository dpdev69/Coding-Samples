/*
  Name: Emmanuel Taylor
  Directory ID: etaylor5
  UID: 111615834

  CMSC216 Project3: Hashtable II
  htable.c
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "htable.h"
#include "my_memory_checker_216.h"

/* Implementation of the hash_code function. */
extern unsigned int hash_code(const char *str) {
  unsigned int hash_code_value = 0;
  unsigned long index = 0;

  while(index < strlen(str)) {
    hash_code_value ^= ((hash_code_value << 3) | (hash_code_value >> 29)) +
      str[index++];
  }

  return hash_code_value;
}

/* This method will free an entire bucket that gets passed to it. */
static void free_entire_bucket(Bucket *curr_bucket, Table *table) {
  if (table -> free_value != NULL && curr_bucket -> value != NULL) {
    table -> free_value(curr_bucket -> value);
  }

  curr_bucket -> value = NULL;
  free(curr_bucket -> key);
  curr_bucket -> key = NULL;
  free(curr_bucket);
  curr_bucket = NULL;
  table -> key_count--;
}
  
/* This function will initialize a table with the parameters given. It will
   also set the key_count to zero. */
int create_table(Table ** table, int table_size, void (*free_value)(void *)) {
  int index = 0;

  /* If table or table_size are empty/zero, return FAIL. */
  if (table == NULL || table_size == 0) {
    return FAIL;
  }

  /* If table and table_size are not empty/zero, set key count to zero and
     initialize the tables parameters and each bucket to NULL. */
  if (table && table_size != 0) {
    *table = malloc(sizeof(Table));
    (*table) -> key_count = 0;
    (*table) -> table_size = table_size;
    (*table) -> free_value = free_value;
    (*table) -> buckets = calloc(table_size, sizeof(Bucket *));
    while (index < table_size) {
      (*table) -> buckets[index++] = NULL;
    }

    return SUCC;
  }

  return FAIL;
}

/* This function frees all memory associated with the given table, including all
   nodes of the hash chains. */
int destroy_table(Table * table) {

  /* If the table is NULL, return FAIL. */
  if (table == NULL) {
    return FAIL;
  }

  /* If the table isn't NULL, call clear_table and free the table, buckets, and
     set them to NULL. */
  else {
    clear_table(table);
    free(table -> buckets);
    free(table);
    return SUCC;
  }
}

/* This function will try to insert a key and a value paired with it into the
   hashtable assuming certain conditions are met which are in the comments 
   below. */
int put(Table * table, const char *key, void *value) {

  /* If the key or table is NULL, return FAIL. */
  if (key == NULL || table == NULL) {
    return FAIL;
  }

  /* If not the above statement do this. */
  else {
    unsigned int hash_value = hash_code(key);
    int index = hash_value % (table -> table_size);
    Bucket *curr_bucket = table -> buckets[index], *new;
   
    /* While curr_bucket, call free_value on curr_buckets value. */
    while (curr_bucket) {
      if (strcmp(curr_bucket -> key, key) == 0) {
	if (curr_bucket -> value != NULL && table -> free_value != NULL) {
	  table -> free_value(curr_bucket -> value);
	}

	/* Set curr_bucket value equal to the value. */
	curr_bucket -> value = value;
	return SUCC;
      }

      /* curr_bucket goes to the next bucket. */
      curr_bucket = curr_bucket -> next;
    }

    /* Moves to the top of the list. */
    new = malloc(sizeof(Bucket));
    if (new == NULL) {
      return FAIL;
    }

    new -> next = table -> buckets[index];
    new -> key = malloc(strlen(key) + 1);
    if (new -> key == NULL) {
      return FAIL;
    }

    strcpy(new -> key, key);
    new -> value = value;
    table -> buckets[index] = new;
    table -> key_count++;
    return SUCC;
  }

  return FAIL;
}

/* This function will copy the value into the parameter value if it is found
   in the table. */
int get_value(const Table * table, const char *key, void **value) {

  /* Returns fail of either table, key or value is NULL. */
  if (table == NULL || key == NULL) {
    return FAIL;
  }

  /* Checks to see if value exists and stores it into the value parameter. */
  else {
    int index = hash_code(key) % (table -> table_size);
    Bucket *curr_bucket = table -> buckets[index];
    while (curr_bucket) {
      if (strcmp (curr_bucket -> key, key) == 0) {
	*value = curr_bucket -> value;
	return SUCC;
      }

      curr_bucket = curr_bucket -> next;
    }

    *value = NULL;
    return FAIL;
  }

  return FAIL;
}

/* This function returns to number of keys in the table, and will return FAIL if
   the table is NULL. */
int get_key_count(const Table * table) {
  if (table == NULL) {
    return FAIL;
  } 
  else {
    return table -> key_count;
  }
}

/* This function will attempt to remove a key and a value paired with it if that
   key is found within the hashtable. */
int remove_entry(Table * table, const char *key) {

  /* If either table or key is NULL, return FAIL. */
  if (table == NULL || key == NULL) {
    return FAIL;
  }

  /* Checks to see if the key is in the table, if it is, we remove the bucket
     that matches that key. */
  else {
    int index = hash_code(key) % (table -> table_size);
    Bucket *search = table -> buckets[index];
    Bucket *prev_bucket = NULL;

    /* Searching for the bucket here. */
    while (search) {
      if (strcmp(key, search -> key) == 0) {
	if (prev_bucket == NULL) {
	  table -> buckets[index] = table -> buckets[index] -> next;
	  free_entire_bucket(search, table);
	  return SUCC;
	}

	prev_bucket -> next = search -> next;
	free_entire_bucket(search, table);
	return SUCC;
      }

      prev_bucket = search;
      search = search -> next;
    }

    return FAIL;
  }

  return FAIL;
}

/* This function will check through a table and free everything that is in the
   array. */
int clear_table(Table * table) {

  /* If table is null, return FAIL. */
  if (table == NULL) {
    return FAIL;
  }

  /* Checks through the hash table and free all of the buckets that are in the
     array. */
  else {
    int index;
    for (index = 0; index < table -> table_size; index++) {
      Bucket *curr_bucket = table -> buckets[index];
      Bucket *next = NULL;
      while (curr_bucket) {
	next = curr_bucket -> next;
	free_entire_bucket(curr_bucket, table);
	curr_bucket = next;
      }
      
      table -> buckets[index] = NULL;
    }
    
    return SUCC;
  }

  return FAIL;
}

/* This function checks to see if the table is empty. */
int is_empty(const Table * table) {
  if (table == NULL) {
    return SUCC;
  }
  else {
    int index = 0;
    for (index = 0; index < table -> table_size; index++) {
      if (table -> buckets[index] != NULL) {
	return 0;
      }
    }

    return SUCC;
  }
}

/* This function returns the table size. The function returns FAIL if the table
   is NULL. */
int get_table_size(const Table * table) {
  if (table == NULL) {
    return FAIL;
  }
  else {
    return table -> table_size;
  }
}
