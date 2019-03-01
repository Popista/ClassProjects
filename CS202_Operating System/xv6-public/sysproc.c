#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"


//int numsyscall = -1;

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return myproc()->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

int
sys_settickets(void)   //system call to initiate tickets
{
  int t;

  if(argint(0, &t) < 0)  //get the function parameter(tickets) like settickets(30) 30 is the parameter
    return -1;
  return settickets(t);
}

int sys_setstride(void)  //system call to initiate stride
{
    int t;

    if(argint(0, &t) < 0)  //get the function parameter(strides)
        return -1;
    return setstride(t);
}

int sys_setpass(void)  //system call to initiate pass
{
    int t;

    if(argint(0, &t) < 0)  //get the function parameter(passes)
        return -1;
    return setpass(t);
}


int
sys_join(void){
    void **stack;
    if(argptr(0, (void*)&stack, sizeof(void**)) < 0)
        return -1;
    return join(stack);
}



int
sys_clone1(void) {
    int size;
    void *stack;
    if (argptr(0, (void *) &stack, sizeof(stack)) < 0)  //get the function parameter(passes)
        return -1;
    if (argptr(1, (void *) &size, sizeof(int)) < 0)  //get the function parameter(passes)
        return -1;
    return clone1(stack, size);
}

