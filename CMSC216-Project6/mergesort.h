#ifndef MERGESORT_H
#define MERGESORT_H

typedef int (*Compare_fn)(const void *, const void *);

typedef struct Chunk {
    struct Chunk	*next;
    void		*arr;		/* address of first */
    int			first;
    int			size;
    int			done;
} Chunk;


void mergesort(void *arr, size_t num_elem, size_t elem_size, Compare_fn cmp);
void mt_mergesort(void *arr, size_t num_elem, int chunk_size, size_t elem_size, Compare_fn cmp,
                  int num_threads);

#endif
