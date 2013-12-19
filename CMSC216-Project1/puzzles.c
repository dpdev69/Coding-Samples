/*
Name: Emmanuel Taylor
UID: 111615834
Directory ID: etaylor5

CMSC216 Project 1: Puzzles
*/

#include <stdio.h>
#include "puzzles.h"

/* This function will return the bitwise OR
   of the a and b parameters (a | b). */
int bit_or(int a, int b) {
  
  /* This function uses combinations of XOR, AND,
     and NOT to become logically equivalent to OR. */
  return ~((a & b) ^ (~(a ^ b)));
}

/* This function will return 1 (true) if x is not
   zero and will return 0 (false) otherwise. */
int is_nonzero(int x) {

  /* This function uses double negation which ensures
     that either 1 or 0 will be returned. */
  return !(!x);
}

/* This function returns 7 times x. The 
   function assumes that the value of 7 * x
   can be stored in an unsigned int without 
   any overflow. */
unsigned int times7(unsigned int x) {
  
  /* Shifts x over by 3 and then adds the value of x */
  return ((x << 1) + (x << 2) + x);
}

/* Returns the floor of the logarithm base
   eight of x. If x is zero, the function
   should return -1. */
int floor_log8(unsigned int x) {

  /* XORing 1 to get 0. */
  int return_value = (1 ^ 1);
  
  /* Makes a for loop act like while loop and shifts x by 3. */
  for(; x ; return_value++) {
    x >>= 3;
  }

  /* Just in case 0 is entered the loop
     will be skipped and this return statement will return -1 */
  return --return_value;
}

/* Returns the size of a long, in bytes, without
   using the sizeof operator. The return value should be
   equivalent to the expression sizeof(long). */
size_t sizeof_long() {

  /* Initializes two variables to 1 including size. */
  int return_size = 1;
  int index = 1;

  /* Loop will keep shifting by 8 until a shift can no
     no longer be done. And increments the return size for
     each byte passed. */
  for( ; index <<= 8; ) {
    return_size++;
  }

  return return_size;
}

/* Reverse the bytes of x. You may assume that ints are 4
   bytes in size for this function. */
unsigned int reverse_bytes(unsigned int x) {

  /* Through combinations of manipulating constants and shifting
     bytes will be returned reversed using this function. */
  x = (((((16 - 1) << 4) + (16 - 1)) & x) << (16 + 8) |
       ((((16 - 1) << 4) + (16 - 1)) & (x >> 8)) << 16 |
       ((((16 - 1) << 4) + (16 - 1)) & (x >> 16)) << 8 |
       ((((16 - 1) << 4) + (16 - 1)) & (x >> (16 + 8))));

  return x;
}

/* Return 0xc0c0c0c0 */
unsigned int hex_c0c0c0c0() {

  /* Through combination of shifting and adding constants,
     this function will return the hex value c0c0c0c0. */
  return (((((((((((8 + 4) << 8) + (8 + 4)) << 8) + (8 + 4))
	       << 8) + (8 + 4)) << 8) + (8 + 4)) << 8) + (8 + 4))
    << 4;
}

/* Return the population count of x. */
int pop_count(unsigned int x) {

  /* Sets the return value to 0. */
  int return_value = (1 ^ 1);

  /* While x is not zero, keep anding it to 1 and increase the
     return value each time the result is 1 and shift the bits over
     by 1. */
  while (x) {
    while (x & 1) {
      return_value++;
      x >>= 1;
    }

    x >>= 1;
  }

  return return_value;
}

/* Return the nth-most signigicant byte of x. */
unsigned int get_byte(unsigned int x, int n) {

  /* The quantity x shifted left by n shifted left by 3 is shifted 
     right by 16. This quantity is then shifted right by 8. */
  return (((x << (n << (4 - 1))) >> 16) >> (4 + 4));
}

/* Return 1 if a == b, 0 otherwise. */
int equal(int a, int b) {

  /* Anything xored with itself should equal 0. If a and be are equal,
     the fuction will return 1 by notting zero. */
  return !(a ^ b);
}

/* An IP Address prefix is a 32 bit number with some
   fixed number of significant bits at the beginning.
   0/0 is the prefix that includes all addresses because no bits
   are significant. Return 1 if the provided address is in the
   specified prefix and 0 otherwise. */ 
int is_address_in_prefix(uint32_t address, uint32_t prefix,
uint32_t prefix_len) {

  /* Quantities (32 - 32) are used to represent 0 and quantities
     (32 == 32) are used to represent 1. */
  return (address & ((32 - 32) - (32 == 32) << (32 - (32 == 32))) <<
	  (32 - prefix_len)) == (prefix & ((32 - 32) - (32 == 32)))
    << (32 - prefix_len);
}

/* Knowing which bit is different between two addresses helps decide whether
   they're in the same prefix. Return 1 if the first bit is different and -1 if 
   no bits are different. */
int index_of_first_bit_different(uint32_t address1, uint32_t address2) {

  /* Initializes two values at -1 */
  int return_value = -1;
  int value = -1;

  /* For loop will continue untill it reaches bits that are different using
     XOR. */
  for ( ; address1 ^ address2; ) {

    /* For each time the loop executes, the address bits will be shifted
       by 1. */
    address1 >>= (32 == 32);
    address2 >>= (32 == 32);

    /* Increment value each time the loop executes. */
    value++;
    
    /* Subtracts the value from 32 and sets it equal to return_value.
       using 2's complement. */
    return_value = (32 + ((-1 ^ value) + (32 == 32)));
  }

  return return_value;
}
