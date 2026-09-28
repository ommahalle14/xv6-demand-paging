#include "types.h"
#include "stat.h"
#include "user.h"
int main(void)
{
  int *p = (int*)0x40000000;
  printf(1, "About to cause page fault\n");
  *p = 10;
  
  
  printf(1, "This should not print\n");
  exit();
}
