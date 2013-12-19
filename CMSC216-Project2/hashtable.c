/*
  Name: Emmanuel Taylor
  UID: 111615834
  Directory ID: etaylor5
  CMSC216 Project 2: Hashtable I
  hashtable.c
*/

#include <stdio.h>
#include <string.h>
#include "hashtable.h"

/* Initialize table to be empty. You can assume that the table has capacity
   NUM_BUCKETS, as defined in hashtable.h. Do nothing if t is NULL. */
void init_table(Table *t) {
  int index;

  /* Do nothing if t is NULL. */
  if (t == NULL) {
    return ;
  }

  /* Iterates through the table changing all FULL and DELETED buckets to the
     EMPTY state. Sets key count to 0. */
  for (index = 0; index < NUM_BUCKETS; index++) {
    t -> buckets[index].state = EMPTY;
    t -> key_ct = 0;
  }
}

/* Reset the able to an empty state, meaning that all buckets are in the empty
   state. Do nothing if t is NULL. */
void reset_table(Table *t) {

  /* Calls init_table(Table *t) since both functions have the exact same 
     functionality */
  init_table(t);
}

/* Insert a key/value pair into the table. Insertion fails if either key or val
   is NULL, either key or value string is longer than MAX_STR_SIZE defined in
   hashtable.h, t is NULL, or table is full. If key exists in the table, update
   the value. Return 0 for success, -1 otherwise. */
int insert(Table *t, const char *key, const char *val) {
  int index = 0;

  /* Insertion will fail if key, val, or t is NULL. */
  if (key == NULL || val == NULL || t == NULL) {
    return -1;
  }

  /* Insertion will fail of the length of key and val is longer than 
     MAX_STR_SIZE. */
  if (strlen(key) > MAX_STR_SIZE || strlen(val) > MAX_STR_SIZE) {
    return -1;
  } 

  /* Hashes key to a location, if the bucket is not full, do the insertion. */
  for (index = (hash_code(key) % NUM_BUCKETS); (index % NUM_BUCKETS)
	 < NUM_BUCKETS; index++) {
    if (t -> buckets[index].state != FULL) {
      t -> buckets[index].state = FULL;
      t -> key_ct++;
      strcpy(t -> buckets[index].data.key, key);
      strcpy(t -> buckets[index].data.value, val);

      return 0;
    }

    /* If the bucket is full, and the keys are the same, update the value. */
    if ((t -> buckets[index].state == FULL) &&
	strcmp(t -> buckets[index].data.key, key) == 0) {
      strcpy(t -> buckets[index].data.value, val);

      return 0;
    }

    /* If there are keys in each bucket, and the search cannot find the key,
       insertion fails. */
    if (t -> key_ct == NUM_BUCKETS && !(search(t, key, NULL))) {
      return -1;
    }
  }

  return -1;
}
 
/* Search for a key in the table. If they key is present and val is not NULL, 
   the value that is paired with key in the table should be copied into the 
   buffer val points to. If either t or key is NULL, the search fails. If the 
   key is present and the parameter val is NULL, the function will not copy the 
   string and return 0. */
int search(Table *t, const char *key, char *val) {
  int index = (hash_code(key) % NUM_BUCKETS);
  int start_point = (hash_code(key) % NUM_BUCKETS);

  /* Search fails if t or key is NULL. */
  if (t == NULL || key == NULL) {
    return -1;
  }

  /* Hashes key to a location, if neither key or val is NULL and the bucket is
     FULL, copy the paired value to the buffer val points to. */
  for (; (index % NUM_BUCKETS) < NUM_BUCKETS; index++) {
    if (key != NULL && val != NULL && t -> buckets[index].state == FULL) {
      strcpy(val, t -> buckets[index].data.value);
      return 0;
    }

    /* If val is null with the same conditions above, val is not copied. */
    else if (key != NULL && val == NULL && t -> buckets[index].state == FULL) {
      return 0;
    }

    /* Search fails if the bucket is EMPTY. */
    if (t -> buckets[index].state == EMPTY) {
      return -1;
    }

    /* If search goes through the table and returns to the start position,
       search fails. */
    if (index == start_point) {
      return -1;
    }
  }

  return -1;
}

/* Attempt to remove the key from the table. If either t or key is NULL, or if
   the key does not exist in the table, the attempt fails. */
int delete(Table *t, const char *key) {
  int index = (hash_code(key) % NUM_BUCKETS);

  /* Deletion attempt fails of t or key is NULL. */
  if (t == NULL || key == NULL) {
    return -1;
  }

  /* Hashes key to a location, keep looking until you find the key and do the
     deletion attempt. */
  for (; (index % NUM_BUCKETS) < NUM_BUCKETS; index++) {
    if (strcmp(t -> buckets[index].data.key, key) == 0 && t -> 
	buckets[index].state == FULL) {
      t -> buckets[index].state = DELETED;
      t -> key_ct--;
      strcpy(t -> buckets[index].data.value, "");
      strcpy(t -> buckets[index].data.key, "");

      return 0;
    }

    /* If the bucket is EMPTY, deletion attempt fails. */
    if (t -> buckets[index].state == EMPTY) {
      return -1;
    }

    /* If key isn't found before we return to the start position, deletion will
       fails. */
    if (index == (hash_code(key) % NUM_BUCKETS)) {
      return -1;
    }
  }
      
  return -1;
}

/* Return the number of keys present in the table, or -1 if t is NULL. */
int key_count(Table *t) {
  if (t == NULL) {
    return -1;
  }
  else {
    return t -> key_ct;
  }
}

/* Return the number of buckets the table has; return -1 if t is NULL. */
int bucket_count(Table *t) {
  if (t == NULL) {
    return -1;
  }
  else {
    return NUM_BUCKETS;
  }
}

/* Return the hash code of the string, as defined by the algorithm in Section
   2.2.2. If str is NULL, return 0. */
unsigned long hash_code(const char *str) {
  int index;
  unsigned long hash_code_value = 0;

  if (str == NULL) {
    return 0;
  }
  else {
    for (index = 0; index < strlen(str); index++) {
      hash_code_value = hash_code_value * 65599;
      hash_code_value = hash_code_value + str[index];
    }
  }

  return hash_code_value;
}
