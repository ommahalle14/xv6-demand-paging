#include "types.h"
#include "defs.h"
#include "swap.h"

struct swapentry swaptable[MAXSWAPPAGES];

void swapinit(void)
{
  int i;

  for(i = 0; i < MAXSWAPPAGES; i++){
    swaptable[i].valid = 0;
  }
}
