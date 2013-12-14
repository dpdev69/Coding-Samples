/*
  Name: Emmanuel Taylor
  UID: 111615834
  Directory ID: etaylor5

  CMSC216 Project 2: Hashtable I
  hashtester.c
*/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sysexits.h>
#include "hashtable.h"

#define MAX_SIZE 1024

int main(int argc, char *argv[]) {
  FILE *input;
  Table table;
  int index;
  char buffer[MAX_SIZE + 1];
  char command_line[MAX_SIZE + 1];
  char display[MAX_SIZE + 1];
  char key[MAX_SIZE + 1];
  char val[MAX_SIZE + 1];
  
  /* Initialize table. */
  init_table(&table);
 
  /* Uses stdin if the user does not use a file. */
  if (argc == 1) {
    input = stdin;
  }

  /* Opens the file that the user choose, throws errors if file is invalid. */
  else if (argc == 2) {
    if ((input = fopen(argv[1], "r")) == NULL) {
      fprintf(stderr, "Error: Could not open file.\n");
      exit(EX_OSERR);
    }
  }
  else {
    fprintf(stderr, "Error: Invalid file.\n");
    exit(EX_USAGE);
  }

  /* Reads the input from the file one line at a time. */
  while (fgets(buffer, MAX_SIZE, input) != NULL) {
    sscanf(buffer, "%s", command_line);
    
    /* Disregards comment lines that start with #. */
    if (command_line[0] == '#') {
      continue;
    }

    /* Algorithm that executes when the command is to insert something into the
       hash table. */
    if (strcmp(command_line, "insert") == 0) {
      if (sscanf(buffer, "%s %s %s", command_line, key, val) == 3) {
	if (insert(&table, key, val) == 0) {
	  printf("Insertion of %s => %s succeeded.\n", key, val);
	}
	else {
	  printf("Insertion of %s => %s failed.\n", key, val);
	}
      }
      
      /* Disregards blank lines, they will not cause an error. */
      else if (strcmp(buffer, "\n") == 0) {
	sscanf(buffer, "\n\n%s", command_line);
      }

      /* If the user enters an incomplete insert command, hashtester will exit
	 with an error. */
      else if (sscanf(buffer, "%s %s", command_line, key) != 3) {
	fprintf(stderr, "Error: Incomplete command.\n");
	exit(EX_DATAERR);
      }
    }

    /* Algorithm that executes when the command is to search something that is
       in the hash table. */
    else if (strcmp(command_line, "search") == 0) {
      if (sscanf(buffer, "%s %s", command_line, key) == 2) {
	if (search(&table, key, val) == 0) {
	  printf("Search for %s succeeded (%s).\n", key, val);
	}
	else {
	  printf("Search for %s failed.\n", key);
	}
      }

      /* Disregards blank lines, they will not cause an error. */
      else if (strcmp(buffer, "\n") == 0) {
	sscanf(buffer, "\n\n%s", command_line);
      }
      
      /* If the user enters an incomplete search command, hashtester will exit
	 with an error. */
      else if (sscanf(buffer, "%s %s", command_line, key) != 2) {
	fprintf(stderr, "Error: Impcomplete command.\n");
	exit(EX_DATAERR);
      }
    }

    /* Algorithm that executes when the command is to delete something that is
       in the hash table */
    else if (strcmp(command_line, "delete") == 0) {
      if (sscanf(buffer, "%s %s", command_line, key) == 2) {
	if (delete(&table, key) == 0) {
	  printf("Deletion of %s succeeded.\n", key);
	}
	else {
	  printf("Deletion of %s failed.\n", key);
	}
      }
  
      /* Disregards blank lines, they will not cause an error. */
      else if (strcmp(buffer, "\n") == 0) {
	sscanf(buffer, "\n\n%s", command_line);
      }

      /* If the user enters an incomplete delete command, the hashtester will
	 exit with an error. */
      else if (sscanf(buffer, "%s %s", command_line, key) != 2) {
	fprintf(stderr, "Error: Imcomplete command.\n");
	exit(EX_DATAERR);
      }
    }

    /* Algorithm that executes when the command is to reset the entire hash
       table. */
    else if (strcmp(command_line, "reset") == 0) {
      if (sscanf(buffer, "%s", command_line) == 1) {
	reset_table(&table);
	printf("Table reset.\n");
      }
    }

    /* Algorithm that executes when the command is to display an item that is
       in the hash table. */
    else if (strcmp(command_line, "display") == 0) {
      if (sscanf(buffer, "%s %s", command_line, display) == 2) {

	/* Shows the number of keys in the table. */
	if (strcmp(display, "key_count") == 0) {
	  printf("Key count: %d\n", key_count(&table));
	}
	
	/* Displays the table with bucket states. */
	if (strcmp(display, "table") == 0) {
	  for (index = 0; index < NUM_BUCKETS; index++) {
	    if (table.buckets[index].state == FULL) {
	      printf("Bucket %d: FULL (%s => %s)\n", index,
		     table.buckets[index].data.key, 
		     table.buckets[index].data.value);
	    }
	    else if (table.buckets[index].state == DELETED) {
	      printf("Bucket %d: DELETED\n", index);
	    }
	    else {
	      printf("Bucket %d: EMPTY\n", index);
	    }
	  }
	}
      }

      /* If the user enters an incomplete display command, hashtester will exit
	 with an error. */
      else {
	fprintf(stderr, "Error: Incomplete command.\n");
	exit(EX_DATAERR);
      }
    }

    /* Disregards blank lines, they will not cause an error. */
    else if (strcmp(buffer, "\n") == 0) {
      sscanf(buffer, "\n\n%s", command_line);
    }
  
    /* If the users enters a completely invalid command (e.g. "remove" instead
       of "delete" or anything not defined above, hashtester will exit with the
       error code EX_DATAERR. */
    else {
      fprintf(stderr, "Error: Invalid command.\n");
      exit(EX_DATAERR);
    }
  }

  fclose(input);
  return 0;
}
