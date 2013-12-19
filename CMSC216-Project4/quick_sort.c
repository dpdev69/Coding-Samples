#include <stdio.h>

#define MAX_ARRAY_SIZE 500

int array[MAX_ARRAY_SIZE];

void read_data(int number_of_elements);
void print_array(int a[], int array_size);
void quick_sort(int a[], int x, int y);

static int partition_list(int a[], int first, int last);
static void swap(int a[], int x, int y);

int main() {
  int number_of_elements
  
  scanf("%d", &number_of_elements);
  if (number_of_elements <= MAX_ARRAY_SIZE) {
    read_data(number_of_elements);
    quick_sort(array, 0, number_of_elements - 1);
    print_array(array, number_of_elements);
  }
  
  return 0;
}

void read_data(int number_of_elements) {
  int i;
  
  for (i = 0; i < number_of_elements; i++) {
    scanf("%d", &array[i]);
  }
}

void print_array(int a[], int array_size) {
  int i;
  
  for (i = 0; i < array_size; i++) {
    printf("%d", a[i]);
  }
  printf("\n");
}

void quick_sort(int a[], int x, int y) {
  int pivot_index;
  if ((y - x) > 0) {
    pivot_index = partition_list(a, x, y);
    quick_sort(a, x, pivot_index - 1);
    quick_sort(a, pivot_index + 1, y);
  }
}

static int partition_list(int a[], int first, int last) {
  int i, pivot = a[first], border = first;
  
  for (i = first + 1; i <= last; i++) {
    if (a[i] <= pivot) {
      border++
      swap(a, border, i);
    }
  }
  swap(a, first, border);
  return border;
}

static void swap(int a[], int x, int y) {
  int temp = a[x];
  a[x] = a[y];
  a[y] = temp;
}
