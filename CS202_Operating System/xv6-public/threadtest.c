#include "types.h"
#include "stat.h"
#include "fcntl.h"
#include "user.h"
#include "x86.h"
#include "threadlib.h"

struct lock_t lock;

void thread_create(void *(*start_routine)(void*), void *arg)
{
    void *nSp = malloc(4096);
    int rc;
    rc = clone1(nSp, 4096);

    if(rc == 0)
    {
        (*start_routine)(arg);
        exit();
    }
}

void thread_join()
{
    wait();
}

void lock_init(struct lock_t *lk)
{
    lk->locked = 0;
}

void lock_acquire(struct lock_t *lk)
{
    while(xchg(&lk->locked, 1) != 0)
        ;
}

void lock_release(struct lock_t *lk)
{
    xchg(&lk->locked, 0);
}



typedef struct __counter_args {
    int *nLoops;
    int *count;
    struct lock_t *lock;
} counter_args;


void *counter(void *arg)
{
    counter_args *args= (counter_args*)arg;

    int i;

    printf(1,"%d\n",*args->nLoops);
    for(i = 0; i < *args->nLoops; i++)
    {
        lock_acquire(args->lock);
        printf(1,"%d\n", getpid());
        (*args->count)++;
        lock_release(args->lock);
    }

    return 0;
}

int
main(int argc, char *argv[])
{
    if(argc != 3)
    {
        printf(1, "Usage: threadtest numberOfThreads loopCount");
        exit();
    }

    //int nThreads = atoi(argv[1]);
    int nLoops =  5;

    int count = 0;
    struct lock_t lock;
    lock_init(&lock);

    counter_args args;
    args.nLoops = &nLoops;
    args.count = &count;
    args.lock = &lock;

    void * a = (void*) &args;

    int i;
    for(i = 0; i < 2; i++)
    {
        printf(1,"333");
        thread_create(counter, a);
    }

    for(i = 0; i < 2; i++)
    {
        thread_join();
    }

    printf(1, "Result is: %d\n", *(args.count));
    exit();
}