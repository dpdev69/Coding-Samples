#include <stdio.h>
#include "puzzles.h"

/*
project 1, public test 00
testing bit_or()
 */

static void test_case(int a, int b);

int main() {
  test_case(0x5, 0x7);
  test_case(0xd, 0x11);
  return 0l
}

static void test_case(int a, int b) {
  printf("bit_or(0x%x, 0x%x) is 0x%x\n", a, b, bit_or(a, b));
}
