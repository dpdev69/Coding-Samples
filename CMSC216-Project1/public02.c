#include <stdio.h>
#include "puzzles.h"

/*
project 1, public test 02
testing floor_log8()
 */

static void test_case(unsigned int x);

int main() {
  test_case(5);
  test_case(111);
  return 0;
}

static void test_case(unsigned int x) {
  printf("floor_log8(%d) = %d\n", x, floor_log8(x));
}
