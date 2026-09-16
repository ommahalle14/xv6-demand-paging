#include "types.h"
#include "fcntl.h"
#include "stat.h"
#include "user.h"
#include "fs.h"

int
main(int argc, char *argv[])
{
  int fd, i, n;
  char buf[128];

  if(argc != 2){
    printf(2, "usage: trylseek filename\n");
    exit();
  }

  fd = open(argv[1], O_RDONLY);
  if(fd < 0){
    printf(2, "unable to open file\n");
    exit();
  }

  lseek(fd, 10, SEEK_SET);
  n = read(fd, buf, 5);
  for(i = 0; i < n; i++)
    printf(1, "%c", buf[i]);
  printf(1, "\n");

  lseek(fd, 10, SEEK_CUR);
  n = read(fd, buf, 5);
  for(i = 0; i < n; i++)
    printf(1, "%c", buf[i]);
  printf(1, "\n");

  lseek(fd, -5, SEEK_END);
  n = read(fd, buf, 5);
  for(i = 0; i < n; i++)
    printf(1, "%c", buf[i]);
  printf(1, "\n");

  lseek(fd, 5, SEEK_END);
  n = read(fd, buf, 5);
  for(i = 0; i < n; i++)
    printf(1, "%c", buf[i]);
  printf(1, "\n");

  close(fd);
  exit();
}
