#ifndef HTABLE_H
#define HTABLE_H

typedef struct bucket {
   char *key;
   void *value;
   struct bucket *next;
} Bucket;

typedef struct {
   int key_count;
   int table_size;
   void (*free_value)(void *);
   Bucket **buckets;
} Table;

int create_table(Table ** table, int table_size, void (*free_value)(void *));
int destroy_table(Table * table);
int put(Table * table, const char *key, void *value);
int get_value(const Table * table, const char *key, void **value);
int get_key_count(const Table * table);
int remove_entry(Table * table, const char *key);
int clear_table(Table * table);
int is_empty(const Table * table);
int get_table_size(const Table * table);

#define SUCC 1
#define FAIL -1

#endif
