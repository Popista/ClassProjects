#include "types.h"
#include "stat.h"
#include "user.h"
#include "x86.h"
#define PGSIZE 4096

struct lock_t {
    uint locked;       // Is the lock held?
};



void lock_init(struct lock_t *lk)
{
    lk->locked = 0;
}

void lock_acquire(struct lock_t *lk)
{
    //int a = 1;
    while(xchg(&lk->locked, 1) != 0){
        //sleep(a);
        //a = a + 2;
        ;
    }
}

void lock_release(struct lock_t *lk)
{
    xchg(&lk->locked, 0);
}

typedef struct  {
    int pid;
    int hasFrisbee;
} frisbee;

int counter = 0;
int round = 0;
int t = 0;
int x = 0;
frisbee fr[30];
int number = 0;
int itt = 0;
int frisbe = 0;
struct lock_t *lock;

int reader()
{
    int num,num2 = 100;
    int mark = 0;
    for(;;){
        if(counter % 2 == 0){
            break;
        }
        sleep(3);
    }
    int i;
    int pid = getpid();
    for(i=0;i<t;i++){
        if(fr[i].pid == pid){
            break;
        }
    }
    num = counter;
    while(num != num2 || num2 % 2 != 0) {
        num = counter;
        mark = 0;
        if (frisbe == i) {
            mark = 1;
        }
        sleep(3);
        num2 = counter;

    }
    if(mark == 1){

        return i;
    }
    else
        return -1;

}

void writer(int p)
{


    //printf(1,"gam:%d\n",getpid());
    counter++;
    frisbe = (p+1) % t;
    printf(1, "Pass number no: %d, Thread %d is passing the token to thread %d\n", number++,p,frisbe);
    x++;
    counter++;

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
    int pro;
    sleep(100);
    int delay = 0;
    for(; x < round; )
    {
        //printf(1,"%d\n",x);
        pro = reader();
        //printf(1,"%d\n",pro);
        if(x==round){
            break;
        }
        if(pro != -1){
            if(x==round){
                break;
            }

            lock_acquire(lock);
            writer(pro);

            lock_release(lock);
            sleep(5);
        }
        delay = delay + 10;

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


    lock_init(lock);
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




