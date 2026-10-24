#define SWAPDEV 2
#define SWAPSTART 16
#define BLOCKSPERPAGE 8
#define MAXSWAPPAGES 510

struct swapentry {
int pid;
uint va;
int block;
int flags;
int valid;
};

int swapalloc(int, uint, int);
int swapgetflags(int, uint);
int swapwrite(int, char *);
int swapread(int, char *);
int swapcopy(int, int);
int swaplookup(int, uint);
int swapfree(int, uint);
int swapout(pde_t *, uint, int);
int swapin(pde_t *, uint, int);
void swapfreepid(int);
