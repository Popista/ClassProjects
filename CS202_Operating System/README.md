TO run：make qemu (need qemu virtual machine）
Project 1：
(1) Add system calls to xv6(2) Change the scheduler to use lottery and stride scheduling

Lottery scheduling test:
lotterytest&;lotterytest2&;lotterytest3


Stride scheduling test:
stride1&;stride2&;stride3


Project 2：
(1) Add a new system call clone to add kernel threads to xv6(2) Create some numbers of threads by thread_create and simulate a game of passing a Frisbee among threads by implementing Spin Lock, Array-based queue Lock, SeqLock

1 :SpinLock:
Input:frisbee thread# running#
example: frisbee 10 20

2: Array_based queue Lock
frisbee_array 10 20

3: Sequential Lock
frisbee_seq 10 20

Reference:

CS202 Advanced Operating System, University of California, Riverside
