#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "fs.h"
#include "buf.h"

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return myproc()->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}


int
sys_diskio(void)
{
  char *p;
  int blockno;
  int write;
  struct buf *b;

  if(argptr(0, &p, BSIZE) < 0)
    return -1;
  if(argint(1, &blockno) < 0)
    return -1;
  if(argint(2, &write) < 0)
    return -1;

  if(blockno < 0 || blockno >= THIRDDISKSIZE)
    return -1;

  cprintf("diskio: block=%d write=%d user[0]=%x\n",
          blockno, write, p[0] & 0xff);

  b = bread(2, blockno);

  cprintf("diskio: after bread data[0]=%x\n",
          b->data[0] & 0xff);

  if(write){
    memmove(b->data, p, BSIZE);

    cprintf("diskio: after copy data[0]=%x\n",
            b->data[0] & 0xff);

    bwrite(b);

    cprintf("diskio: after bwrite data[0]=%x\n",
            b->data[0] & 0xff);
  } else {
    cprintf("diskio: read data[0]=%x\n",
            b->data[0] & 0xff);

    memmove(p, b->data, BSIZE);

    cprintf("diskio: user after copy[0]=%x\n",
            p[0] & 0xff);
  }

  brelse(b);
  return 0;
}
