#include <stdio.h>
#include <stdlib.h>
#include "htable.h"
#include "my_memory_checker_216.h"

static void display_table(Table * table);
static void print_list(Bucket * bucket);

int main() {
   Table *table_ptr;
   int x, y, table_size = 5;
   void *value;

   /***** Starting memory checking *****/
   start_memory_check();
   /***** Starting memory checking *****/

   create_table(&table_ptr, table_size, NULL);
   x = 2;
   put(table_ptr, "Peggy", &x);
   y = 1;
   put(table_ptr, "John", &y);

   printf("Table size: %d\n", get_table_size(table_ptr));
   if (is_empty(table_ptr)) {
      printf("Empty table\n");
   } else {
      printf("Not empty\n");
   }
   get_value(table_ptr, "John", &value);
   printf("Value for John %d\n", *(int *) value);

   printf("Removing Peggy: %d\n", remove_entry(table_ptr, "Peggy"));
   printf("Displaying Table\n");
   display_table(table_ptr);

   clear_table(table_ptr);
   printf("After clearing\n");
   if (is_empty(table_ptr)) {
      printf("Empty table\n");
   } else {
      printf("Not empty\n");
   }
   printf("Displaying Table\n");
   display_table(table_ptr);

   destroy_table(table_ptr);

   /****** Gathering memory checking info *****/
   stop_memory_check();
   /****** Gathering memory checking info *****/

   return 0;
}

static void display_table(Table * table) {
   int i;

   printf("Key_count: %d\n", table->key_count);
   printf("Table_size: %d\n", table->table_size);
   if (table->key_count == 0) {
      printf("Empty table\n");
   } else {
      for (i = 0; i < table->table_size; i++) {
         print_list(table->buckets[i]);
      }
   }
}

static void print_list(Bucket * bucket) {
   if (bucket != NULL) {
      printf("Key: %s, value: %d\n", bucket->key, *((int *) bucket->value));

      print_list(bucket->next);
   }
}
