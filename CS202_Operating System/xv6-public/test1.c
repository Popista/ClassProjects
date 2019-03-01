#include "types.h"
#include "stat.h"
#include "user.h"

int main(void)
{
	//fork();
	int a;
	//char *a = (char*)malloc(4096);
	char *b = (char*)malloc(50000);
	//a = "1231312";
	b = "222";
	printf(1,"%s \n",b);
	a = getpid();
	printf(1,"pid : %d \n",a);
    printf(1,"mempagenum: %d\n", mempagenum());
    printf(1,"syscallnum: %d\n", syscallnum());
    free(b);
    exit();
}
