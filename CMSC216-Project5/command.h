/* This file and all derivatives (C) 2012 Neil Spring and the
 * University of Maryland.  Any use, copying, or distribution
 * without permission is prohibited.
 */

/* each command to execute is a leaf in this tree. */
/* commands are tied together in the tree, left side 
   executed first. */
struct tree {
  enum { NONE = 0, AND, OR, SEMI, PIPE } conjunction;
  struct tree *left, *right;
  char **argv;
  char *input;
  char *output;
};

/* array of strings to match the conjunction enum
   above.  print the element using conj[tree->conjunction] */
/* declared static (improperly) to avoid duplicate symbols;
   improper because it creates multiple copies of the strings
   in a binary.  Done here since we might change the operations. */
   
static const char *conj[] __attribute__((unused)) = { "err", "&&", "||", ";", "|" };  
