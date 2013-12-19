#include <stdio.h>
#include "puzzles.h"

/* 
  project 1, public test 06
  testing index_of_first_bit_different()
*/


static void test_case(uint32_t addr1, uint32_t addr2);

int main() {
   test_case(0x80088008, 0x0);
   test_case(0x40088008, 0x0);
   test_case(0x40088008, 0x40088008);

   return 0;
}

static void test_case(uint32_t addr1, uint32_t addr2) {
  int answer = index_of_first_bit_different(addr1, addr2);
  printf("index_of_first_bit_different for addr1(0x%08x), and addr2(0x%08x) is %d\n", 
          addr1, addr2, answer);
}
