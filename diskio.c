#include "types.h"
#include "stat.h"
#include "user.h"

int
main(void)
{
  char buf[512];
  int i;

  for(i = 0; i < 512; i++)
    buf[i] = 0x5A;

  if(diskio(buf, 100, 1) < 0){
    printf(1, "disk write failed\n");
    exit();
  }

  printf(1, "disk write successful\n");

  for(i = 0; i < 512; i++)
    buf[i] = 0;

  if(diskio(buf, 100, 0) < 0){
    printf(1, "disk read failed\n");
    exit();
  }

  for(i = 0; i < 512; i++){
    if((buf[i] & 0xff) != 0x5A){
      printf(1, "FAILED at byte %d: got %x\n",
             i, buf[i] & 0xff);
      exit();
    }
  }

  printf(1, "disk read verification PASS\n");
  exit();
}
