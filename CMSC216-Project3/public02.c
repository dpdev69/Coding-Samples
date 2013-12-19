#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "htable.h"

extern unsigned int hash_code(const char *string);

int main() {
  assert(hash_code("gimme") == 477003);
  assert(hash_code("shelter") == 41540041);
  printf("hash_code() passes minimal testing.\n");
  printf("%lu\n", sizeof(unsigned long));
  exit(EXIT_SUCCESS);
}
