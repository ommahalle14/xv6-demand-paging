#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main (int argc , char* argv[] ) {

	char buff[512];
	int n =0;
	int srcfd = 0;
	int desfd = 0;
	if(argc != 3){
	printf(2,"not enough arguments\n");
	exit();
	}
	
	srcfd = open(argv[1] , O_RDONLY);
	
	if(srcfd < 0){
	printf(2,"unable to open sourcefile\n");
	exit();
	}
	
	 desfd = open(argv[2], O_CREATE | O_WRONLY);
	 
	 if(desfd < 0){
	printf(2,"unable to open destinationfile\n");
	close(srcfd);
	exit();
	}
	
	while((n = read(srcfd,buff,sizeof(buff))) >0){
	if(write(desfd , buff , n ) != n){
            printf(2, "unable to write\n");
            close(srcfd);
            close(desfd);
            exit();
	}
	}
	if(n< 0){
	printf(2,"unable to read\n");
	}
	
	close(srcfd);
	close(desfd);
	exit();
}
