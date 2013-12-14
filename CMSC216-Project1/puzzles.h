#include <stdlib.h>  /* needed for definition of size_t */
#include <stdint.h>

int bit_or(int, int);
int is_nonzero(int);
unsigned int times7(unsigned int);
int floor_log8(unsigned int);
size_t sizeof_long();
unsigned int reverse_bytes(unsigned int);
unsigned int hex_c0c0c0c0();
int pop_count(unsigned int);
unsigned int get_byte(unsigned int, int);
int equal(int, int);
int is_address_in_prefix(uint32_t address, uint32_t prefix, uint32_t prefix_len);
int index_of_first_bit_different(uint32_t address1, uint32_t address2); 
