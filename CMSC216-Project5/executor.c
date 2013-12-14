/***************************************/
/* Name: Emmanuel Taylor               */
/* UID: 111615834                      */
/* Directory ID: etaylor5              */
/*                                     */
/* CMSC216 Project 5: Simple Shell     */
/*                                     */
/* executor.c                          */
/***************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sysexits.h>
#include <err.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <fcntl.h>
#include "executor.h"
#include "command.h"

int execute(struct tree *t) {
  
  /* Checking if the tree is NULL. */
  if (t == NULL) {
    return 0;
  }

  /* The case that the conjunction isn't AND or PIPE. */
  if (t -> conjunction == NONE) {
    
    /* If the command is to exit, exit(0). */
    if (strcmp(t -> argv[0], "exit") == 0) {
      exit(0);
    }

    /* If the command is cd, then use chdir. If there is no second argument,
       the directory will be changed to Home, otherwise, we change to the
       second argument if one is provided. */
    else if (strcmp(t -> argv[0], "cd") == 0) {
      if (t -> argv[1] == NULL) {
	chdir(getenv("HOME"));
	return 0;
      }
      else {
	chdir(t -> argv[1]);
	return 0;
      }
    }

    else {
      pid_t child_pid;
      int in, out;

      child_pid = fork();

      /* Checking for a fork error. */
      if (child_pid < 0) {
	err(EX_OSERR, "Error: Fork Error.");
      }

      /* **** This is the child portion of the code. ***** */
      if (child_pid == 0) {

	/* Input redirection. */
	if (t -> input != NULL) {
	  in = open(t -> input, O_RDONLY);
	  if(in < 0) {
	    err(EX_OSERR, "Error: Error Opening File.");
	  }

	  if (dup2(in, STDIN_FILENO) < 0) {
	    err(EX_OSERR, "Error: dup2 Error.");
	  }

	  if (close(in) < 0) {
	    err(EX_OSERR, "Error: Error Closing File.");
	  }
	}

	/* Output redirection. */
	else if (t -> output != NULL) {
	  out = open(t -> output, O_RDWR | O_CREAT | O_TRUNC, 0664);
	  if (out < 0) {
	    err(EX_OSERR, "Error: Error Opening File.");
	  }

	  if (dup2(out, STDOUT_FILENO) < 0) {
	    err(EX_OSERR, "Error: dup 2 Error.");
	  }

	  if (close(out) < 0) {
	    err(EX_OSERR, "Error: Error Closing File.");
	  }
	}

	execvp(t -> argv[0], t -> argv);
	printf("Failed to execute %s\n", t -> argv[0]);
	exit(1);
      }

      /* ***** This is the parent portion of the code. ***** */
      else {
	int status;

	wait(&status);
	return status;
      }
    }
  }

  /* The case that the conjunction isn't NONE or PIPE. */
  else if (t -> conjunction == AND) {
    if (t -> input == NULL && t -> output == NULL) {
      pid_t child_pid;

      child_pid = fork();

      /* Checking for fork errors. */
      if (child_pid < 0) {
	err(EX_OSERR, "Error: Fork Error.");
      }

      /* ***** This is the child code. ***** */
      if (child_pid == 0) {
	if (execute(t -> left) == 0) {
	  if (execute(t -> right) == 0) {
	    exit(0);
	  }
	  else {
	    exit(-1);
	  }
	}
	else {
	  exit(-1);
	}
      }
      
      /* ***** This is the parent code. ***** */
      else {
	int status;

	wait(&status);
	return status;
      }
    }

    /* Input redirection. */
    if (t -> input != NULL) {
      pid_t child_pid;

      child_pid = fork();

      /* Checking for fork errors. */
      if (child_pid < 0) {
	err(EX_OSERR, "Error: Fork Error");
      }

      /* ***** This is the child code. ***** */
      if (child_pid == 0) {
	int in;

	in = open(t -> input, O_RDONLY);

	if (in < 0) {
	  err(EX_OSERR, "Error: Error Opening File.");
	}

	if (dup2(in, STDIN_FILENO) < 0) {
	  err(EX_OSERR, "Error: dup2 Error.");
	}

	if (close(in) < 0) {
	  err(EX_OSERR, "Error: Error Closing File.");
	}

	if (execute (t -> left) == 0) {
	  if (execute(t -> right) == 0) {
	    exit(0);
	  }
	  else {
	    exit(-1);
	  }
	}
	else {
	  exit(-1);
	}
      }

      /* ***** This is the parent code. ***** */
      else {
	int status;

	wait(&status);
	return status;
      }
    }

    /* Output redirection. */
    else if(t -> output != NULL) {
      int out;

      out = open(t -> output, O_RDWR | O_CREAT | O_TRUNC, 0664);

      if (out < 0) {
	err(EX_OSERR, "Error: Error Opening File.");
      }

      if (dup2(out, STDOUT_FILENO) < 0) {
	err(EX_OSERR, "Error: dup2 Error.");
      }

      if (close(out) < 0) {
	err(EX_OSERR, "Error: Error Closing File.");
      }

      pid_t child_pid;

      child_pid = fork();

      /*Checking for fork errors. */
      if (child_pid < 0) {
	err(EX_OSERR, "fork error");
      }

      /* ***** This is the child code. ***** */
      if (child_pid == 0) {
	if (execute(t -> left) == 0) {
	  if (execute(t -> right) == 0) {
	    exit(0);
	  }
	  else {
	    exit(-1);
	  }
	}
	else {
	  exit(-1);
	}
      }

      /* ***** This is the parent code. ***** */
      else {
	int status;

	wait(&status);
	return status;
      }
    }
    return 0;
  }

  /* The case that the conjunction isn't NONE or AND. */
  else if (t -> conjunction == PIPE) {
    int pipe_fd[2];
    pid_t child_pid;

    /* Checking for fork errors. */
    child_pid = fork();

    /* ***** This is the child code. ***** */
    if (child_pid == 0) {
      pid_t child_pipe;

      /* Checking for pipe errors. */
      if(pipe(pipe_fd) < 0) {
	err(EX_OSERR, "Error: Pipe Error.");
      }

      child_pipe = fork();

      /* Checking for fork errors. */
      if (child_pipe < 0) {
	err(EX_OSERR, "Error: Fork Error.");
      }

      if (child_pipe == 0) {
	
	/* Closing the pipe's read end. Not needed. */
	close(pipe_fd[0]);

	if (dup2(pipe_fd[1], STDOUT_FILENO) < 0) {
	  err(EX_OSERR, "Error: dup2 Error.");
	}

	if (execute(t -> left) == 0) {
	  exit(0);
	}
	else {
	  exit(-1);
	}
      }

      /* ***** This is the parent code. ***** */
      else {
	int status;

	wait(&status);

	if(status != 0) {
	  exit(EXIT_FAILURE);
	}

	/* Closing the pipe's write end. Not needed. */
	close(pipe_fd[1]);

	if (dup2(pipe_fd[0], STDIN_FILENO) < 0) {
	  err(EX_OSERR, "Error: dup2 Error.");
	}

	if(execute(t -> right) == 0) {
	  exit(0);
	}
	else {
	  exit(-1);
	}
      }
    }

    /* ***** This is the second  parent code. ***** */
    else {
      int second_status;

      wait(&second_status);
      return second_status;
    }
  }

  return 0;
}
