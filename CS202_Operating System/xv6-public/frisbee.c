#include "types.h"
#include "stat.h"
#include "user.h"
#include "x86.h"
#define PGSIZE 4096

struct lock_t {
    uint locked;       // Is the lock held?
};

int test_and_set(struct lock_t *lk, int tn){
    if(tn == 1){
        if(lk->locked == 0){
            lk->locked = 1;
            return 0;
        }
        if(lk->locked == 1){
            return 1;
        }
    }
    else{
        lk->locked = 0;
        return 0;
    }
    return 0;
}

typedef struct  {
    int pid;
    int hasFrisbee;
} frisbee;

int round = 0;
int t = 0;
int x = 0;

void lock_init(struct lock_t *lk)
{
    lk->locked = 0;
}

void lock_acquire(struct lock_t *lk)
{
    int a = 1;
    while(test_and_set(lk, 1) != 0){
        sleep(a);
        a = a + 2;
    }
}

void lock_release(struct lock_t *lk)
{
    test_and_set(lk, 0);
    sleep(100);
}

struct lock_t lock;
frisbee fr[30];
int number = 0;
int itt = 0;

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
    fr[t/2].hasFrisbee = 1;
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
    struct lock_t *lk;
    lk = &lock;
    int i;
    int j = 0;
    int id;
    sleep(100);
    for(; x < round; )
    {
        if(x==round){
            break;
        }
        lock_acquire(lk);
        id = getpid();
        //printf(1,"%d\n",id);
        //printf(1,"there %d\n",id);
        for(i = 0;i<t;i++){
            if(x==round){
                break;
            }
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
                    j = (i + 1) % t;
                    fr[j].hasFrisbee = 1;
                    fr[i].hasFrisbee = 0;
                    printf(1, "Pass number no: %d, Thread %d is passing the token to thread %d\n", number++,i,j);
                    x++;
                    break;
                }
            }
        }
        lock_release(lk);
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


    lock_init(&lock);
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

