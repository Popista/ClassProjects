#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char *argv[]) {
    sleep(5);
    if(*argv[1] == '1'){    //count of the processes in the system
        printf(1,"process num: %d\n", getprocnum());
        exit();
    }
    if(*argv[1] == '2'){    // the number of system calls this program has invoked
        //fork();
        //sleep(1);    //sleep(int) is a system call, call it to test if the syscallnum() is working.
        printf(1,"syscallnum: %d\n", syscallnum());
        exit();
    }
    if(*argv[1] == '3'){  // the number of memory pages the current process is using
        //char *p = (char*)malloc(45056);
        //char *p = (char*)malloc(40960);    //allocate new space to see whether the mempagenum() is working
        printf(1,"mempagenum: %d\n", mempagenum());
        //free(p);
        exit();
    }
    //printf(1,"%c\n",*argv[1]);
    exit();
}

