#include "types.h"
#include "stat.h"
#include "user.h"
int main(void)
{
  char x ;
 uint faultadress = (uint)&x - 4096;
 char *p = (char*)faultadress;
  printf(1, "About to cause page fault\n");
 printf(1, "x=%x, target= %x\n",&x,faultadress);
 *p = 10;
  printf(1, "This should not print\n");
  exit();
}
