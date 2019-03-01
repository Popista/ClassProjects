#include "types.h"
#include "stat.h"
#include "user.h"
#include "x86.h"
#define PGSIZE 4096



typedef struct  {
    int pid;
    int lock;  //the location of a thread in the queue
    int hasFrisbee;
} frisbee;

int flag[30];
int test[30];
int countflag = 0;
int round = 0;
int t = 0;
int x = 0;
frisbee fr[30];
int number = 0;
int itt = 0;

void lock_init()
{
    int i;
    for(i=0;i<t;i++){
        flag[i] = 0;
        fr[i].lock = 0;
    }
    countflag = t - 1;
    fr[0].lock = 1;
}

void lock_acquire()
{
    int pid, i;
    pid = getpid();
    for(i=0;i<t;i++){
        if(fr[i].pid == pid){
            //printf(1,"pidd\n");
            while(!(fr[i].lock)){
                //j = j + 1;
                sleep(5);
                //printf(1,"%d\n",fr[i].pid);
            }
            //printf(1,"%d\n",fr[i].pid);
            //printf(2,"iit : %d\n",itt);
            break;
        }
    }
}

void lock_release()
{
    int pid, i, j;
    pid = getpid();
    for(i=0;i<t;i++){
        if(fr[i].pid == pid){
            fr[i].lock = 0;
            j = (i+1)%t;
            fr[j].lock = 1;
            break;
        }
    }
    sleep(100);
}



void
thread_create(void (*start_routine)(void*), void *arg){
    void *stack = malloc(PGSIZE);
    int rc;

    int i = 0;
    for(i = 0;i<t;i++){
        fr[i].hasFrisbee = 0;
        fr[i].pid = 0;
    }
    i = 0;
    fr[0].hasFrisbee = 1;
    rc = clone1(stack, PGSIZE);

    //printf(1,"%d\n", rc);
    if(rc == 0)
    {
        //sleep(20);
        fr[itt].pid = getpid();
        itt++;
        start_routine(arg);
        exit();
    }
}

void
pass(void *arg){
    //printf(1,"%d\n", round);
    /*for(;;){
        lock_acquire(lk);
        //printf(1, "%d\n", x);
        if(x == round){
            break;
        }

        printf(1, "%d\n", getpid());
        x++;
        lock_release(lk);
        //printf(1, "%d\n", i);

    }
    lock_release(lk);*/
    int i;
    int j = 0;
    int id;
    sleep(100);
    for(; x < round; )
    {


        lock_acquire();
        id = getpid();
        //printf(1,"%d\n",id);
        //printf(1,"there %d\n",id);
        if(x==round){
            break;
        }
        for(i = 0;i<t;i++){
            if(fr[i].pid == id){
                if(x==round){
                    break;
                }
                if(fr[i].hasFrisbee == 0){
                    //printf(1,"%d\n",i);
                    //printf(1," = 0\n");
                    break;
                }

                else{
                    //printf(1,"here\n");
                    j = (i + 1) % t;
                    fr[j].hasFrisbee = 1;
                    fr[i].hasFrisbee = 0;
                    printf(1, "Pass number no: %d, Thread %d is passing the token to thread %d\n", number++,i,j);
                    x++;
                    break;
                }
            }
        }
        //printf(1,"jrere\n");
        lock_release();
    }

}

int main(int argc, char *argv[])
{
    int i,j, temp = 0;
    int arg = 1;

    //Get the parameters from the terminal

    for(i=0;i<strlen(argv[1]);i++){
        temp = *(argv[1] + i) - '0';
        //printf(1,"%d\n",temp);
        for(j=i;j<strlen(argv[1]) - 1;j++){
            temp = temp * 10;
        }
        t = t + temp;
    }
    for(i=0;i<strlen(argv[2]);i++){
        temp = *(argv[2] + i) - '0';
        //printf(1,"%d\n",temp);
        for(j=i;j<strlen(argv[2]) - 1;j++){
            temp = temp * 10;
        }
        round = round + temp;
    }
    //printf(1,"%d\n", t);
    //printf(1,"%d\n", round);
    //arg = round;


    lock_init();
    for(i=0;i<t;i++){

        arg = i+1;
        thread_create(&pass, &arg);
        //printf(1, "%d\n", result);
    }
    void **join_stack = (void**) ((uint)sbrk(0) - 4);
    for(i=0;i<t;i++){
        join(join_stack);
    }




    exit();
}



