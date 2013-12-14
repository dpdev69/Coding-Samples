/*
  Emmanuel Taylor
  UID: 111615834
  Directory ID: etaylor5

  CMSC 216 Project 3: Hashtable II
  studentTests.c
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "htable.h"
#include "my_memory_checker_216.h"

/*****************************************************/
/* In this file you will provide tests to your       */
/* hash table.  Each test should be named test1()    */
/* test2(), etc. Each test must have a description   */
/* of what it is testing (this description is really */
/* important.                                        */
/* main just calls all test1(), test2(), etc.        */
/*****************************************************/

extern unsigned int hash_code(const char *str);

/* Using prototypes from public01.c */
static void display_table(Table * table);
static void print_list(Bucket * bucket);

/* This test checks the functionality of create_table and destroy_table. */
static int test1() {
   int table_size = 2;
   Table *table_ptr;
   create_table(&table_ptr, table_size, free);
   destroy_table(table_ptr);
   return SUCC;
}

/* THE FOLLOWING 14 TESTS ARE TESTING FOR NULL. */

/* This test will check create_table when table is NULL. */
static int test2() {
  Table *table_ptr = NULL;
  int table_size = 2;
  
  if(create_table(NULL, table_size, free) == FAIL) {
    printf("Test2: create_table() passes check for table = NULL.\n");
    return SUCC;
  }
  else {
    destroy_table(table_ptr);
    printf("Test2: create_table() fails check for table =  NULL.\n");
    return FAIL;
  }
}

/* This test will check create_table when table_size = 0. */
static int test3() {
  Table *table_ptr;
  int table_size = 0;

  if(create_table(&table_ptr, table_size, free) == FAIL) {
    printf("Test3: create_table() passes check for table_size = 0.\n");
    return SUCC;
  }
  else {
    destroy_table(table_ptr);
    printf("Test3: create_table() fails check for table_size = 0.\n");
    return FAIL;
  }
}

/* This test will check destroy_table when table is NULL. */
static int test4() {
  Table *table_ptr = NULL;

  if(destroy_table(table_ptr) == FAIL) {
    printf("Test4: destroy_table() passes check for table = NULL.\n");
    return SUCC;
  }
  else {
    printf("Test4: destroy_table() fails check for table = NULL.\n");
    return FAIL;
  }
}

/* This test checks put when table is NULL. */
static int test5() {
  Table *table_ptr = NULL;
  int val = 2;

  if(put(table_ptr, "John", &val) == FAIL) {
    printf("Test5: put() passes check for table = NULL.\n");
    return SUCC;
  }
  else {
    printf("Test5: put() fails check for table = NULL.\n");
    return FAIL;
  }
}

/* This test checks put when key is NULL. */
static int test6() {
  Table *table_ptr;
  int val = 2, table_size = 2;
 
  create_table(&table_ptr, table_size, free);
  if(put(table_ptr, NULL, &val) == FAIL) {
    destroy_table(table_ptr);
    printf("Test6: put() passes check for key = NULL.\n");
    return SUCC;
  }
  else {
    destroy_table(table_ptr);
    printf("Test6: put() fails check for key = NULL.\n");
    return FAIL;
  }
}

/* This test checks get_value when table is NULL. */
static int test7() {
  Table *table_ptr = NULL;
  void *val;
  
  if(get_value(table_ptr, "John", &val) == FAIL) {
    printf("Test7: get_value() passes check for table = NULL.\n");
    return SUCC;
  }
  else {
    printf("Test5: get_value() fails check for table = NULL.\n");
    return FAIL;
  }
}

/* This test checks get_value when key is NULL. */
static int test8() {
  Table *table_ptr;
  int table_size = 2;
  void *val;

  create_table(&table_ptr, table_size, free);
  if(get_value(table_ptr, NULL, &val) == FAIL) {
    destroy_table(table_ptr);
    printf("Test8: get_value() passes check for key = NULL.\n");
    return SUCC;
  }
  else {
    destroy_table(table_ptr);
    printf("Test8: get_value() fails check for key = NULL.\n");
    return FAIL;
  }
}

/* This test checks get_key_count when table is NULL.  */
static int test9() {
  Table *table_ptr = NULL;

  if(get_key_count(table_ptr) == FAIL) {
    printf("Test10: get_key_count() passes check for table = NULL.\n");
    return SUCC;
  }
  else {
    printf("Test10: get_key_count() fails check for table = NULL.\n");
    return FAIL;
  }
}

/* This test checks remove_entry when table is NULL. */
static int test10() {
  Table *table_ptr = NULL;

  if(remove_entry(table_ptr, "John") == FAIL) {
    printf("Test11: remove_entry() passes check for table = NULL.\n");
    return SUCC;
  }
  else {
    printf("Test11: remove_entry() fails check for table = NULL.\n");
    return FAIL;
  }
}

/* This test checks remove_entry when key is NULL. */
static int test11() {
  Table *table_ptr;
  int table_size = 2;

  create_table(&table_ptr, table_size, free);
  if(remove_entry(table_ptr, NULL) == FAIL) {
    destroy_table(table_ptr);
    printf("Test12: remove_entry() passes check for key = NULL.\n");
    return SUCC;
  }
  else {
    destroy_table(table_ptr);
    printf("Test12: remove_entry() fails check for key = NULL.\n");
    return FAIL;
  }
}

/* This test checks clear_table when table is NULL. */
static int test12() {
  Table *table_ptr = NULL;

  if(clear_table(table_ptr) == FAIL) {
    printf("Test13: clear_table passes check for table = NULL.\n");
    return SUCC;
  }
  else {
    printf("Test13: clear_table fails check for table = NULL.\n");
    return FAIL;
  }
}

/* This test checks is_empty when table is NULL. */
static int test13() {
  Table *table_ptr = NULL;

  if(is_empty(table_ptr) == SUCC) {
    printf("Test14: is_empty passes check for table = NULL.\n");
    return SUCC;
  }
  else {
    printf("Test14: is_empty fails check for table = NULL.\n");
    return FAIL;
  }
}

/* This test checks get_table_size when table is NULL. */
static int test14() {
  Table *table_ptr = NULL;

  if(get_table_size(table_ptr) == FAIL) {
    printf("Test15: get_table_size passes check for table = NULL.\n");
    return SUCC;
  }
  else {
    printf("Test15: get_table_size fails check for table = NULL.\n");
    return FAIL;
  }
}

/* END OF NULL TESTS. */


/* THE FOLLOWING 3 TESTS CHECK EXTRA FUNCTIONALITY OF EACH FUNCTION. */

/* This test checks if put actually puts something into the table. */
static int test15() {
  Table *table_ptr;
  int table_size = 5;
  int value1 = 3;
  int value2 = 4;

  create_table(&table_ptr, table_size, NULL);
  clear_table(table_ptr);
  put(table_ptr, "Benson", &value1);
  put(table_ptr, "Rigby", &value2);
  put(table_ptr, "Mordecai", &value2);
  put(table_ptr, "Mordecai", &value1);

  if(is_empty(table_ptr) == SUCC) {
    display_table(table_ptr);
    destroy_table(table_ptr);
    printf("Nothing was ever put in the table.\n");
    return FAIL;
  }
  else {
    display_table(table_ptr);
    printf("Successfully entered into the table.\n");
    destroy_table(table_ptr);
    return SUCC;
  }
}

/* This test checks to see if the get_value functions returns correct value. */
static int test16() {
  Table *table_ptr;
  int table_size = 5, value = 3;
  void *return_value;

  create_table(&table_ptr, table_size, NULL);
  clear_table(table_ptr);
  put(table_ptr, "Dexter", &value);
  get_value(table_ptr, "Dexter", &return_value);
  printf("Value for Dexter: %d\n", *(int *)return_value);
  if (*(int *) return_value == 3) {
    display_table(table_ptr);
    destroy_table(table_ptr);
    printf("Returned correct value.\n");
    return SUCC;
  }
  else {
    display_table(table_ptr);
    destroy_table(table_ptr);
    printf("Returned incorrect value.\n");
    return FAIL;
  }
}

/* This test checks the functionality of remove_entry. */
static int test17() {
  Table *table_ptr;
  int table_size = 5, value = 3;
  
  create_table(&table_ptr, table_size, NULL);
  clear_table(table_ptr);
  put(table_ptr, "Anthony", &value);
  printf("After insertion.\n");
  display_table(table_ptr);
  remove_entry(table_ptr, "Anthony");
  printf("After deletion.\n");
  display_table(table_ptr);
  if (is_empty(table_ptr) == SUCC) {
    destroy_table(table_ptr);
    printf("Successfully removed entry.\n");
    return SUCC;
  }
  else {
    destroy_table(table_ptr);
    printf("Unsuccessful remove.\n");
    return FAIL;
  }
}

/* Tests multiple keys in one bucket. */
static int test18() {
  Table *table_ptr;
  int table_size = 1, value1 = 2, value2 = 3;

  create_table(&table_ptr, table_size, NULL);
  clear_table(table_ptr);
  put(table_ptr, "Anthony", &value1);
  printf("After first insertion.\n");
  display_table(table_ptr);
  put(table_ptr, "Anhtony", &value2);
  printf("After second insertion.\n");
  display_table(table_ptr);
  destroy_table(table_ptr);
  return SUCC;
}

/* END OF FUNCTIONALITY TESTS. */

int main() {
   int r = SUCC;

   /***** Starting memory checking *****/
   start_memory_check();
   /***** Starting memory checking *****/

   /* NULL TESTS. */
   if(test1() == FAIL) r = FAIL;
   if(test2() == FAIL) r = FAIL;
   if(test3() == FAIL) r = FAIL;
   if(test4() == FAIL) r = FAIL;
   if(test5() == FAIL) r = FAIL;
   if(test6() == FAIL) r = FAIL;
   if(test7() == FAIL) r = FAIL;
   if(test8() == FAIL) r = FAIL;
   if(test9() == FAIL) r = FAIL;
   if(test10() == FAIL) r = FAIL;
   if(test11() == FAIL) r = FAIL;
   if(test12() == FAIL) r = FAIL;
   if(test13() == FAIL) r = FAIL;
   if(test14() == FAIL) r = FAIL;
   
   printf("\n");

   /* FUNCTIONALITY TESTS. */
   if(test15() == FAIL) r = FAIL;
   printf("\n");
   if(test16() == FAIL) r = FAIL;
   printf("\n");
   if(test17() == FAIL) r = FAIL;
   printf("\n");
   if(test18() == FAIL) r = FAIL;

   /****** Gathering memory checking info *****/
   stop_memory_check();
   /****** Gathering memory checking info *****/
   
   if(r==FAIL) {
     exit(EXIT_FAILURE);
   }

   return 0;
}

static void display_table(Table * table) {
  int i;

  printf("Key_count: %d\n", table -> key_count);
  printf("Table_size: %d\n", table -> table_size);
  if (table -> key_count == 0) {
    printf("Empty table.\n");
  }
  else {
    for (i = 0; i < table -> table_size; i++) {
      print_list(table -> buckets[i]);
    }
  }
}

static void print_list(Bucket * bucket) {
  if (bucket != NULL) {
    printf("Key: %s, Value: %d\n", bucket -> key, *((int *) bucket -> value));

    print_list(bucket -> next);
  }
}
