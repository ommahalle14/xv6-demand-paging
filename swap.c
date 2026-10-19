#include "types.h"
#include "defs.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "fs.h"
#include "buf.h"
#include "swap.h"

struct swapentry swaptable[MAXSWAPPAGES];

void swapinit(void)
{
  int i;

  for(i = 0; i < MAXSWAPPAGES; i++){
    swaptable[i].valid = 0;
  }
}

int
swapalloc(int pid, uint va)
{
  int i;

  for(i = 0; i < MAXSWAPPAGES; i++){
    if(swaptable[i].valid == 0){
      swaptable[i].pid = pid;
      swaptable[i].va = va;
      swaptable[i].block = SWAPSTART + i * BLOCKSPERPAGE;
      swaptable[i].valid = 1;
      return swaptable[i].block;
    }
  }

  return -1;
}



int swapwrite(int block, char *page)
{
  int i;
  struct buf *b;

  if(block < SWAPSTART ||
   block + BLOCKSPERPAGE > SWAPSTART + MAXSWAPPAGES * BLOCKSPERPAGE ||
   (block - SWAPSTART) % BLOCKSPERPAGE != 0)
  return -1;

  for(i = 0; i < BLOCKSPERPAGE; i++){
    b = bread(SWAPDEV, block + i);
    memmove(b->data, page + i * BSIZE, BSIZE);
    bwrite(b);
    brelse(b);
  }

  return 0;
}

int swapread(int block, char *page)
{
  int i;
  struct buf *b;

 if(block < SWAPSTART ||
   block + BLOCKSPERPAGE > SWAPSTART + MAXSWAPPAGES * BLOCKSPERPAGE ||
   (block - SWAPSTART) % BLOCKSPERPAGE != 0)
  return -1;

  for(i = 0; i < BLOCKSPERPAGE; i++){
    b = bread(SWAPDEV, block + i);
    memmove(page + i * BSIZE, b->data, BSIZE);
    brelse(b);
  }

  return 0;
}
