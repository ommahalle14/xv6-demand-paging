#define SWAPDEV 2
#define SWAPSTART 16
#define BLOCKSPERPAGE 8
#define MAXSWAPPAGES 510

struct swapentry {
int pid;
uint va;
int block;
int valid;
};
