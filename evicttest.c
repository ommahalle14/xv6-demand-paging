#include "types.h"
#include "stat.h"
#include "user.h"

#define PGSIZE 4096
#define PRESSURE (240 * 1024 * 1024)

int
main(void)
{

  char *p;
  char *q;
  char *r;
  int i;
  int fd[2];
  int pid;
  int childok;

  p = sbrk(PGSIZE);
  if(p == (char*)-1){
    printf(1, "evicttest: initial allocation failed\n");
    exit();
  }

  q = sbrk(PGSIZE);
  if(q == (char*)-1){
  printf(1, "evicttest: second allocation failed\n");
  exit();
}

  if(pipe(fd) < 0){
  printf(1, "evicttest: pipe failed\n");
  exit();
}

  for(i = 0; i < PGSIZE; i++){
  p[i] = (i * 17 + 23) & 0xff;
  q[i] = (i * 7 + 41) & 0xff;
}
  r = sbrk(PRESSURE);

  if(r != (char*)-1){
    printf(1, "evicttest: pressure allocation unexpectedly succeeded\n");
    exit();
  }

  for(i = 0; i < PGSIZE; i++){
  if((uchar)q[i] != ((i * 7 + 41) & 0xff)){
    printf(1, "evicttest: second page data mismatch at %d\n", i);
    exit();
  }
}

if((pid = fork()) < 0){
  printf(1, "evicttest: fork failed\n");
  close(fd[0]);
  close(fd[1]);
  exit();
}

if(pid == 0){
  close(fd[0]);
  childok = 1;

  for(i = 0; i < PGSIZE; i++){
    if((uchar)p[i] != ((i * 17 + 23) & 0xff)){
      childok = 0;
      break;
    }
  }

  p[0] = 0xaa;
  write(fd[1], &childok, sizeof(childok));
  close(fd[1]);
  exit();
}

close(fd[1]);
wait();

if(read(fd[0], &childok, sizeof(childok)) != sizeof(childok) ||
   childok != 1){
  printf(1, "evicttest: child swap-copy test failed\n");
  close(fd[0]);
  exit();
}

close(fd[0]);
printf(1, "evicttest: swapped-page fork test PASS\n");

  for(i = 0; i < PGSIZE; i++){
    if((uchar)p[i] != ((i * 17 + 23) & 0xff)){
      printf(1, "evicttest: data mismatch at %d\n", i);
      exit();
    }
  }

r = sbrk(PRESSURE);
if(r != (char*)-1){
  printf(1, "evicttest: second pressure unexpectedly succeeded\n");
  exit();
}
  printf(1, "evicttest: contents preserved across eviction\n");
  exit();
}
