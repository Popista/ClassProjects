#include "types.h"
#include "stat.h"
#include "user.h"

int main(void)
{
	int a;
	a = fork();
	printf(1,"pid: %d\n", a);
    printf(1,"syscallnum: %d\n", syscallnum());
    exit();
}