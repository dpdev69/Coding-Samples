#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include "executor.h"
#include "lexer.h"

#define MAX_LINE 1024
int main() {
  for(;;) {
    char buffer[MAX_LINE];
    /* wanted to add cwd to the prompt, but doing so will
       bork expectations for test output. for next time:
       maybe ansi brightness. */
    printf("d8sh%% ");
    fflush(stdout);

    if (fgets(buffer, MAX_LINE, stdin) == NULL) { break; } /* exit on eof */

    yy_scan_string(buffer); /* set up bison to read from memory */
    if (yyparse() != 0) { continue; } /* try again if parse error */

    /* yyparse will invoke execute() on the parsed tree. */
    /* execute should block until we're ready for the next prompt */
  }
  return(0);
}

/* required by bison */
void yyerror (const char *s) {
  fprintf (stderr, "Parse error: %s\n", s);
}
