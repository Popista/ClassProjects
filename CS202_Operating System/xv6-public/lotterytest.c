#include "types.h"
#include "stat.h"
#include "user.h"
#include "lot.h"

int main(int argc, char *argv[])
{
    settickets(300);
    sleep(5);
    // write your own function here
    int i,k;
    const int loop=43000;
    //int result;
    for(i=0;i<loop;i++)
    {
        asm("nop"); //in order to prevent the compiler from optimizing the for loop
        for(k=0;k<loop;k++)
        {
            asm("nop");
        }
    }
    //result = getsheltime();
    //printf(1,"Prog1: !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!%d\n",result);
    exit();
}