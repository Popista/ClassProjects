TO run：make qemu (need qemu virtual machine）
Project 1：
(1) Add system calls to xv6

Lottery scheduling test:
lotterytest&;lotterytest2&;lotterytest3


Stride scheduling test:
stride1&;stride2&;stride3


Project 2：
(1) Add a new system call clone to add kernel threads to xv6

1 :SpinLock:
Input:frisbee thread# running#
example: frisbee 10 20

2: Array_based queue Lock
frisbee_array 10 20

3: Sequential Lock
frisbee_seq 10 20

Reference:

CS202 Advanced Operating System, University of California, Riverside