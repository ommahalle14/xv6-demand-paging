#include "types.h"
#include "stat.h"
#include "user.h"

#define PGSIZE 4096
#define PRESSURE (240 * 1024 * 1024)

int
main(void)
{
  char *p;
  char *r;
  int i;

  p = sbrk(PGSIZE);
  if(p == (char*)-1){
    printf(1, "evicttest: initial allocation failed\n");
    exit();
  }

  for(i = 0; i < PGSIZE; i++)
    p[i] = (i * 17 + 23) & 0xff;

   printf(1, "evicttest: pattern page at %x\n", (uint)p);
  printf(1, "evicttest: checking memory pressure\n");
  r = sbrk(PRESSURE);

  if(r != (char*)-1){
    printf(1, "evicttest: pressure allocation unexpectedly succeeded\n");
    exit();
  }

  for(i = 0; i < PGSIZE; i++){
    if((uchar)p[i] != ((i * 17 + 23) & 0xff)){
      printf(1, "evicttest: data mismatch at %d\n", i);
      exit();
    }
  }

  printf(1, "evicttest: contents preserved across eviction\n");
  exit();
}
