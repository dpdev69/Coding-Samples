#include <stdio.h>
#include "puzzles.h"

/* 
  project 1, public test 05
  testing is_address_in_prefix()
*/

static void test_case(uint32_t addr, uint32_t prefix, uint32_t prefix_len);

int main() {
  test_case(0x80088008, 0x80080000, 16);
  test_case(0x80088008, 0x80080000, 32);

  return 0;
}

static void test_case(uint32_t addr, uint32_t prefix, uint32_t prefix_len) {
  int answer = is_address_in_prefix(addr, prefix, prefix_len);
  printf("is_address_in_prefix for addr(0x%08x), prefix(0x%08x), prefix length(%u) is %d\n", 
          addr, prefix, prefix_len, answer);
}
