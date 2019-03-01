
_frisbee_seq：     文件格式 elf32-i386


Disassembly of section .text:

00000000 <main>:
    }

}

int main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
   6:	83 e4 f0             	and    $0xfffffff0,%esp
   9:	83 ec 30             	sub    $0x30,%esp
   c:	8b 75 0c             	mov    0xc(%ebp),%esi
    int i,j, temp = 0;
    int arg = 1;
   f:	c7 44 24 2c 01 00 00 	movl   $0x1,0x2c(%esp)
  16:	00 

    //Get the parameters from the terminal

    for(i=0;i<strlen(argv[1]);i++){
  17:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
  1e:	00 
  1f:	90                   	nop
  20:	8b 46 04             	mov    0x4(%esi),%eax
  23:	89 04 24             	mov    %eax,(%esp)
  26:	e8 95 03 00 00       	call   3c0 <strlen>
  2b:	39 44 24 1c          	cmp    %eax,0x1c(%esp)
  2f:	73 36                	jae    67 <main+0x67>
        temp = *(argv[1] + i) - '0';
  31:	8b 46 04             	mov    0x4(%esi),%eax
  34:	8b 4c 24 1c          	mov    0x1c(%esp),%ecx
  38:	0f be 14 08          	movsbl (%eax,%ecx,1),%edx
  3c:	8d 7a d0             	lea    -0x30(%edx),%edi
        //printf(1,"%d\n",temp);
        for(j=i;j<strlen(argv[1]) - 1;j++){
  3f:	89 cb                	mov    %ecx,%ebx
  41:	eb 0b                	jmp    4e <main+0x4e>
  43:	90                   	nop
            temp = temp * 10;
  44:	8d 14 bf             	lea    (%edi,%edi,4),%edx
  47:	8d 3c 12             	lea    (%edx,%edx,1),%edi
        for(j=i;j<strlen(argv[1]) - 1;j++){
  4a:	43                   	inc    %ebx
  4b:	8b 46 04             	mov    0x4(%esi),%eax
  4e:	89 04 24             	mov    %eax,(%esp)
  51:	e8 6a 03 00 00       	call   3c0 <strlen>
  56:	48                   	dec    %eax
  57:	39 c3                	cmp    %eax,%ebx
  59:	72 e9                	jb     44 <main+0x44>
        }
        t = t + temp;
  5b:	01 3d b0 0d 00 00    	add    %edi,0xdb0
    for(i=0;i<strlen(argv[1]);i++){
  61:	ff 44 24 1c          	incl   0x1c(%esp)
  65:	eb b9                	jmp    20 <main+0x20>
  67:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
  6e:	00 
  6f:	90                   	nop
    }
    for(i=0;i<strlen(argv[2]);i++){
  70:	8b 46 08             	mov    0x8(%esi),%eax
  73:	89 04 24             	mov    %eax,(%esp)
  76:	e8 45 03 00 00       	call   3c0 <strlen>
  7b:	39 44 24 1c          	cmp    %eax,0x1c(%esp)
  7f:	73 36                	jae    b7 <main+0xb7>
        temp = *(argv[2] + i) - '0';
  81:	8b 46 08             	mov    0x8(%esi),%eax
  84:	8b 4c 24 1c          	mov    0x1c(%esp),%ecx
  88:	0f be 14 08          	movsbl (%eax,%ecx,1),%edx
  8c:	8d 7a d0             	lea    -0x30(%edx),%edi
        //printf(1,"%d\n",temp);
        for(j=i;j<strlen(argv[2]) - 1;j++){
  8f:	89 cb                	mov    %ecx,%ebx
  91:	eb 0b                	jmp    9e <main+0x9e>
  93:	90                   	nop
            temp = temp * 10;
  94:	8d 14 bf             	lea    (%edi,%edi,4),%edx
  97:	8d 3c 12             	lea    (%edx,%edx,1),%edi
        for(j=i;j<strlen(argv[2]) - 1;j++){
  9a:	43                   	inc    %ebx
  9b:	8b 46 08             	mov    0x8(%esi),%eax
  9e:	89 04 24             	mov    %eax,(%esp)
  a1:	e8 1a 03 00 00       	call   3c0 <strlen>
  a6:	48                   	dec    %eax
  a7:	39 c3                	cmp    %eax,%ebx
  a9:	72 e9                	jb     94 <main+0x94>
        }
        round = round + temp;
  ab:	01 3d b4 0d 00 00    	add    %edi,0xdb4
    for(i=0;i<strlen(argv[2]);i++){
  b1:	ff 44 24 1c          	incl   0x1c(%esp)
  b5:	eb b9                	jmp    70 <main+0x70>
    //printf(1,"%d\n", t);
    //printf(1,"%d\n", round);
    //arg = round;


    lock_init(lock);
  b7:	a1 e0 0d 00 00       	mov    0xde0,%eax
    lk->locked = 0;
  bc:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    for(i=0;i<t;i++){
  c2:	8b 15 b0 0d 00 00    	mov    0xdb0,%edx
  c8:	85 d2                	test   %edx,%edx
  ca:	7e 25                	jle    f1 <main+0xf1>
  cc:	31 db                	xor    %ebx,%ebx
  ce:	8d 74 24 2c          	lea    0x2c(%esp),%esi
  d2:	66 90                	xchg   %ax,%ax

        arg = i+1;
  d4:	43                   	inc    %ebx
  d5:	89 5c 24 2c          	mov    %ebx,0x2c(%esp)
        thread_create(&pass, &arg);
  d9:	89 74 24 04          	mov    %esi,0x4(%esp)
  dd:	c7 04 24 60 02 00 00 	movl   $0x260,(%esp)
  e4:	e8 f7 01 00 00       	call   2e0 <thread_create>
    for(i=0;i<t;i++){
  e9:	39 1d b0 0d 00 00    	cmp    %ebx,0xdb0
  ef:	7f e3                	jg     d4 <main+0xd4>
        //printf(1, "%d\n", result);
    }
    void **join_stack = (void**) ((uint)sbrk(0) - 4);
  f1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  f8:	e8 be 04 00 00       	call   5bb <sbrk>
  fd:	8d 70 fc             	lea    -0x4(%eax),%esi
    for(i=0;i<t;i++){
 100:	31 db                	xor    %ebx,%ebx
 102:	a1 b0 0d 00 00       	mov    0xdb0,%eax
 107:	85 c0                	test   %eax,%eax
 109:	7e 12                	jle    11d <main+0x11d>
 10b:	90                   	nop
        join(join_stack);
 10c:	89 34 24             	mov    %esi,(%esp)
 10f:	e8 f7 04 00 00       	call   60b <join>
    for(i=0;i<t;i++){
 114:	43                   	inc    %ebx
 115:	39 1d b0 0d 00 00    	cmp    %ebx,0xdb0
 11b:	7f ef                	jg     10c <main+0x10c>
    }




    exit();
 11d:	e8 11 04 00 00       	call   533 <exit>
 122:	66 90                	xchg   %ax,%ax

00000124 <lock_init>:
{
 124:	55                   	push   %ebp
 125:	89 e5                	mov    %esp,%ebp
    lk->locked = 0;
 127:	8b 45 08             	mov    0x8(%ebp),%eax
 12a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
 130:	5d                   	pop    %ebp
 131:	c3                   	ret    
 132:	66 90                	xchg   %ax,%ax

00000134 <lock_acquire>:
{
 134:	55                   	push   %ebp
 135:	89 e5                	mov    %esp,%ebp
 137:	8b 55 08             	mov    0x8(%ebp),%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
 13a:	b9 01 00 00 00       	mov    $0x1,%ecx
 13f:	90                   	nop
 140:	89 c8                	mov    %ecx,%eax
 142:	f0 87 02             	lock xchg %eax,(%edx)
    while(xchg(&lk->locked, 1) != 0){
 145:	85 c0                	test   %eax,%eax
 147:	75 f7                	jne    140 <lock_acquire+0xc>
}
 149:	5d                   	pop    %ebp
 14a:	c3                   	ret    
 14b:	90                   	nop

0000014c <lock_release>:
{
 14c:	55                   	push   %ebp
 14d:	89 e5                	mov    %esp,%ebp
 14f:	8b 55 08             	mov    0x8(%ebp),%edx
 152:	31 c0                	xor    %eax,%eax
 154:	f0 87 02             	lock xchg %eax,(%edx)
}
 157:	5d                   	pop    %ebp
 158:	c3                   	ret    
 159:	8d 76 00             	lea    0x0(%esi),%esi

0000015c <reader>:
{
 15c:	55                   	push   %ebp
 15d:	89 e5                	mov    %esp,%ebp
 15f:	57                   	push   %edi
 160:	56                   	push   %esi
 161:	53                   	push   %ebx
 162:	83 ec 1c             	sub    $0x1c,%esp
        if(counter % 2 == 0){
 165:	f6 05 b8 0d 00 00 01 	testb  $0x1,0xdb8
 16c:	74 17                	je     185 <reader+0x29>
 16e:	66 90                	xchg   %ax,%ax
        sleep(3);
 170:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
 177:	e8 47 04 00 00       	call   5c3 <sleep>
        if(counter % 2 == 0){
 17c:	f6 05 b8 0d 00 00 01 	testb  $0x1,0xdb8
 183:	75 eb                	jne    170 <reader+0x14>
    int pid = getpid();
 185:	e8 29 04 00 00       	call   5b3 <getpid>
    for(i=0;i<t;i++){
 18a:	8b 15 b0 0d 00 00    	mov    0xdb0,%edx
 190:	31 f6                	xor    %esi,%esi
 192:	85 d2                	test   %edx,%edx
 194:	7e 18                	jle    1ae <reader+0x52>
        if(fr[i].pid == pid){
 196:	39 05 00 0e 00 00    	cmp    %eax,0xe00
 19c:	75 0b                	jne    1a9 <reader+0x4d>
 19e:	eb 0e                	jmp    1ae <reader+0x52>
 1a0:	39 04 f5 00 0e 00 00 	cmp    %eax,0xe00(,%esi,8)
 1a7:	74 05                	je     1ae <reader+0x52>
    for(i=0;i<t;i++){
 1a9:	46                   	inc    %esi
 1aa:	39 d6                	cmp    %edx,%esi
 1ac:	75 f2                	jne    1a0 <reader+0x44>
    num = counter;
 1ae:	a1 b8 0d 00 00       	mov    0xdb8,%eax
 1b3:	89 c3                	mov    %eax,%ebx
    int mark = 0;
 1b5:	31 ff                	xor    %edi,%edi
    int num,num2 = 100;
 1b7:	ba 64 00 00 00       	mov    $0x64,%edx
    while(num != num2 || num2 % 2 != 0) {
 1bc:	eb 24                	jmp    1e2 <reader+0x86>
 1be:	66 90                	xchg   %ax,%ax
        num = counter;
 1c0:	89 c3                	mov    %eax,%ebx
        mark = 0;
 1c2:	31 c0                	xor    %eax,%eax
 1c4:	39 35 a0 0d 00 00    	cmp    %esi,0xda0
 1ca:	0f 94 c0             	sete   %al
 1cd:	89 c7                	mov    %eax,%edi
        sleep(3);
 1cf:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
 1d6:	e8 e8 03 00 00       	call   5c3 <sleep>
        num2 = counter;
 1db:	a1 b8 0d 00 00       	mov    0xdb8,%eax
 1e0:	89 c2                	mov    %eax,%edx
    while(num != num2 || num2 % 2 != 0) {
 1e2:	39 d3                	cmp    %edx,%ebx
 1e4:	75 da                	jne    1c0 <reader+0x64>
 1e6:	83 e3 01             	and    $0x1,%ebx
 1e9:	75 d5                	jne    1c0 <reader+0x64>
    if(mark == 1){
 1eb:	4f                   	dec    %edi
 1ec:	75 0a                	jne    1f8 <reader+0x9c>
}
 1ee:	89 f0                	mov    %esi,%eax
 1f0:	83 c4 1c             	add    $0x1c,%esp
 1f3:	5b                   	pop    %ebx
 1f4:	5e                   	pop    %esi
 1f5:	5f                   	pop    %edi
 1f6:	5d                   	pop    %ebp
 1f7:	c3                   	ret    
        return -1;
 1f8:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1fd:	eb ef                	jmp    1ee <reader+0x92>
 1ff:	90                   	nop

00000200 <writer>:
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	53                   	push   %ebx
 204:	83 ec 24             	sub    $0x24,%esp
 207:	8b 4d 08             	mov    0x8(%ebp),%ecx
    counter++;
 20a:	ff 05 b8 0d 00 00    	incl   0xdb8
    frisbe = (p+1) % t;
 210:	8d 41 01             	lea    0x1(%ecx),%eax
 213:	99                   	cltd   
 214:	f7 3d b0 0d 00 00    	idivl  0xdb0
 21a:	89 15 a0 0d 00 00    	mov    %edx,0xda0
    printf(1, "Pass number no: %d, Thread %d is passing the token to thread %d\n", number++,p,frisbe);
 220:	a1 a8 0d 00 00       	mov    0xda8,%eax
 225:	8d 58 01             	lea    0x1(%eax),%ebx
 228:	89 1d a8 0d 00 00    	mov    %ebx,0xda8
 22e:	89 54 24 10          	mov    %edx,0x10(%esp)
 232:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
 236:	89 44 24 08          	mov    %eax,0x8(%esp)
 23a:	c7 44 24 04 c0 09 00 	movl   $0x9c0,0x4(%esp)
 241:	00 
 242:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 249:	e8 4e 04 00 00       	call   69c <printf>
    x++;
 24e:	ff 05 ac 0d 00 00    	incl   0xdac
    counter++;
 254:	ff 05 b8 0d 00 00    	incl   0xdb8
}
 25a:	83 c4 24             	add    $0x24,%esp
 25d:	5b                   	pop    %ebx
 25e:	5d                   	pop    %ebp
 25f:	c3                   	ret    

00000260 <pass>:
pass(void *arg){
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	53                   	push   %ebx
 264:	83 ec 24             	sub    $0x24,%esp
    sleep(100);
 267:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
 26e:	e8 50 03 00 00       	call   5c3 <sleep>
 273:	bb 01 00 00 00       	mov    $0x1,%ebx
 278:	a1 ac 0d 00 00       	mov    0xdac,%eax
 27d:	8b 15 b4 0d 00 00    	mov    0xdb4,%edx
    for(; x < round; )
 283:	39 d0                	cmp    %edx,%eax
 285:	7d 51                	jge    2d8 <pass+0x78>
        pro = reader();
 287:	e8 d0 fe ff ff       	call   15c <reader>
 28c:	89 c1                	mov    %eax,%ecx
        if(x==round){
 28e:	a1 ac 0d 00 00       	mov    0xdac,%eax
 293:	8b 15 b4 0d 00 00    	mov    0xdb4,%edx
 299:	39 d0                	cmp    %edx,%eax
 29b:	74 3b                	je     2d8 <pass+0x78>
        if(pro != -1){
 29d:	83 f9 ff             	cmp    $0xffffffff,%ecx
 2a0:	74 e1                	je     283 <pass+0x23>
            lock_acquire(lock);
 2a2:	8b 15 e0 0d 00 00    	mov    0xde0,%edx
 2a8:	89 d8                	mov    %ebx,%eax
 2aa:	f0 87 02             	lock xchg %eax,(%edx)
    while(xchg(&lk->locked, 1) != 0){
 2ad:	85 c0                	test   %eax,%eax
 2af:	75 f7                	jne    2a8 <pass+0x48>
            writer(pro);
 2b1:	89 0c 24             	mov    %ecx,(%esp)
 2b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
 2b7:	e8 44 ff ff ff       	call   200 <writer>
    xchg(&lk->locked, 0);
 2bc:	8b 15 e0 0d 00 00    	mov    0xde0,%edx
 2c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2c5:	f0 87 02             	lock xchg %eax,(%edx)
            sleep(5);
 2c8:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 2cf:	e8 ef 02 00 00       	call   5c3 <sleep>
 2d4:	eb a2                	jmp    278 <pass+0x18>
 2d6:	66 90                	xchg   %ax,%ax
}
 2d8:	83 c4 24             	add    $0x24,%esp
 2db:	5b                   	pop    %ebx
 2dc:	5d                   	pop    %ebp
 2dd:	c3                   	ret    
 2de:	66 90                	xchg   %ax,%ax

000002e0 <thread_create>:
thread_create(void (*start_routine)(void*), void *arg){
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	53                   	push   %ebx
 2e4:	83 ec 14             	sub    $0x14,%esp
    void *stack = malloc(PGSIZE);
 2e7:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 2ee:	e8 f5 05 00 00       	call   8e8 <malloc>
    for(i = 0;i<t;i++){
 2f3:	8b 0d b0 0d 00 00    	mov    0xdb0,%ecx
 2f9:	31 d2                	xor    %edx,%edx
 2fb:	85 c9                	test   %ecx,%ecx
 2fd:	7e 1c                	jle    31b <thread_create+0x3b>
 2ff:	90                   	nop
        fr[i].hasFrisbee = 0;
 300:	c7 04 d5 04 0e 00 00 	movl   $0x0,0xe04(,%edx,8)
 307:	00 00 00 00 
        fr[i].pid = 0;
 30b:	c7 04 d5 00 0e 00 00 	movl   $0x0,0xe00(,%edx,8)
 312:	00 00 00 00 
    for(i = 0;i<t;i++){
 316:	42                   	inc    %edx
 317:	39 ca                	cmp    %ecx,%edx
 319:	75 e5                	jne    300 <thread_create+0x20>
    fr[0].hasFrisbee = 1;
 31b:	c7 05 04 0e 00 00 01 	movl   $0x1,0xe04
 322:	00 00 00 
    rc = clone1(stack, PGSIZE);
 325:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
 32c:	00 
 32d:	89 04 24             	mov    %eax,(%esp)
 330:	e8 de 02 00 00       	call   613 <clone1>
    if(rc == 0)
 335:	85 c0                	test   %eax,%eax
 337:	74 06                	je     33f <thread_create+0x5f>
}
 339:	83 c4 14             	add    $0x14,%esp
 33c:	5b                   	pop    %ebx
 33d:	5d                   	pop    %ebp
 33e:	c3                   	ret    
        fr[itt].pid = getpid();
 33f:	8b 1d a4 0d 00 00    	mov    0xda4,%ebx
 345:	e8 69 02 00 00       	call   5b3 <getpid>
 34a:	89 04 dd 00 0e 00 00 	mov    %eax,0xe00(,%ebx,8)
        itt++;
 351:	ff 05 a4 0d 00 00    	incl   0xda4
        start_routine(arg);
 357:	8b 45 0c             	mov    0xc(%ebp),%eax
 35a:	89 04 24             	mov    %eax,(%esp)
 35d:	ff 55 08             	call   *0x8(%ebp)
        exit();
 360:	e8 ce 01 00 00       	call   533 <exit>
 365:	66 90                	xchg   %ax,%ax
 367:	90                   	nop

00000368 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 368:	55                   	push   %ebp
 369:	89 e5                	mov    %esp,%ebp
 36b:	53                   	push   %ebx
 36c:	8b 45 08             	mov    0x8(%ebp),%eax
 36f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 372:	89 c2                	mov    %eax,%edx
 374:	8a 19                	mov    (%ecx),%bl
 376:	88 1a                	mov    %bl,(%edx)
 378:	42                   	inc    %edx
 379:	41                   	inc    %ecx
 37a:	84 db                	test   %bl,%bl
 37c:	75 f6                	jne    374 <strcpy+0xc>
    ;
  return os;
}
 37e:	5b                   	pop    %ebx
 37f:	5d                   	pop    %ebp
 380:	c3                   	ret    
 381:	8d 76 00             	lea    0x0(%esi),%esi

00000384 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 384:	55                   	push   %ebp
 385:	89 e5                	mov    %esp,%ebp
 387:	56                   	push   %esi
 388:	53                   	push   %ebx
 389:	8b 55 08             	mov    0x8(%ebp),%edx
 38c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 38f:	0f b6 02             	movzbl (%edx),%eax
 392:	0f b6 19             	movzbl (%ecx),%ebx
 395:	84 c0                	test   %al,%al
 397:	75 14                	jne    3ad <strcmp+0x29>
 399:	eb 1d                	jmp    3b8 <strcmp+0x34>
 39b:	90                   	nop
    p++, q++;
 39c:	42                   	inc    %edx
 39d:	8d 71 01             	lea    0x1(%ecx),%esi
  while(*p && *p == *q)
 3a0:	0f b6 02             	movzbl (%edx),%eax
 3a3:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 3a7:	84 c0                	test   %al,%al
 3a9:	74 0d                	je     3b8 <strcmp+0x34>
    p++, q++;
 3ab:	89 f1                	mov    %esi,%ecx
  while(*p && *p == *q)
 3ad:	38 d8                	cmp    %bl,%al
 3af:	74 eb                	je     39c <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 3b1:	29 d8                	sub    %ebx,%eax
}
 3b3:	5b                   	pop    %ebx
 3b4:	5e                   	pop    %esi
 3b5:	5d                   	pop    %ebp
 3b6:	c3                   	ret    
 3b7:	90                   	nop
  while(*p && *p == *q)
 3b8:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 3ba:	29 d8                	sub    %ebx,%eax
}
 3bc:	5b                   	pop    %ebx
 3bd:	5e                   	pop    %esi
 3be:	5d                   	pop    %ebp
 3bf:	c3                   	ret    

000003c0 <strlen>:

uint
strlen(char *s)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 3c6:	80 39 00             	cmpb   $0x0,(%ecx)
 3c9:	74 10                	je     3db <strlen+0x1b>
 3cb:	31 d2                	xor    %edx,%edx
 3cd:	8d 76 00             	lea    0x0(%esi),%esi
 3d0:	42                   	inc    %edx
 3d1:	89 d0                	mov    %edx,%eax
 3d3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 3d7:	75 f7                	jne    3d0 <strlen+0x10>
    ;
  return n;
}
 3d9:	5d                   	pop    %ebp
 3da:	c3                   	ret    
  for(n = 0; s[n]; n++)
 3db:	31 c0                	xor    %eax,%eax
}
 3dd:	5d                   	pop    %ebp
 3de:	c3                   	ret    
 3df:	90                   	nop

000003e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	57                   	push   %edi
 3e4:	8b 55 08             	mov    0x8(%ebp),%edx
  asm volatile("cld; rep stosb" :
 3e7:	89 d7                	mov    %edx,%edi
 3e9:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3ec:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ef:	fc                   	cld    
 3f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 3f2:	89 d0                	mov    %edx,%eax
 3f4:	5f                   	pop    %edi
 3f5:	5d                   	pop    %ebp
 3f6:	c3                   	ret    
 3f7:	90                   	nop

000003f8 <strchr>:

char*
strchr(const char *s, char c)
{
 3f8:	55                   	push   %ebp
 3f9:	89 e5                	mov    %esp,%ebp
 3fb:	8b 45 08             	mov    0x8(%ebp),%eax
 3fe:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
 401:	8a 10                	mov    (%eax),%dl
 403:	84 d2                	test   %dl,%dl
 405:	75 0c                	jne    413 <strchr+0x1b>
 407:	eb 13                	jmp    41c <strchr+0x24>
 409:	8d 76 00             	lea    0x0(%esi),%esi
 40c:	40                   	inc    %eax
 40d:	8a 10                	mov    (%eax),%dl
 40f:	84 d2                	test   %dl,%dl
 411:	74 09                	je     41c <strchr+0x24>
    if(*s == c)
 413:	38 ca                	cmp    %cl,%dl
 415:	75 f5                	jne    40c <strchr+0x14>
      return (char*)s;
  return 0;
}
 417:	5d                   	pop    %ebp
 418:	c3                   	ret    
 419:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
 41c:	31 c0                	xor    %eax,%eax
}
 41e:	5d                   	pop    %ebp
 41f:	c3                   	ret    

00000420 <gets>:

char*
gets(char *buf, int max)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	57                   	push   %edi
 424:	56                   	push   %esi
 425:	53                   	push   %ebx
 426:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 429:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
 42b:	8d 7d e7             	lea    -0x19(%ebp),%edi
 42e:	66 90                	xchg   %ax,%ax
  for(i=0; i+1 < max; ){
 430:	8d 73 01             	lea    0x1(%ebx),%esi
 433:	3b 75 0c             	cmp    0xc(%ebp),%esi
 436:	7d 40                	jge    478 <gets+0x58>
    cc = read(0, &c, 1);
 438:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 43f:	00 
 440:	89 7c 24 04          	mov    %edi,0x4(%esp)
 444:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 44b:	e8 fb 00 00 00       	call   54b <read>
    if(cc < 1)
 450:	85 c0                	test   %eax,%eax
 452:	7e 24                	jle    478 <gets+0x58>
      break;
    buf[i++] = c;
 454:	8a 45 e7             	mov    -0x19(%ebp),%al
 457:	8b 55 08             	mov    0x8(%ebp),%edx
 45a:	88 44 32 ff          	mov    %al,-0x1(%edx,%esi,1)
    if(c == '\n' || c == '\r')
 45e:	3c 0a                	cmp    $0xa,%al
 460:	74 06                	je     468 <gets+0x48>
 462:	89 f3                	mov    %esi,%ebx
 464:	3c 0d                	cmp    $0xd,%al
 466:	75 c8                	jne    430 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 468:	8b 45 08             	mov    0x8(%ebp),%eax
 46b:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 46f:	83 c4 2c             	add    $0x2c,%esp
 472:	5b                   	pop    %ebx
 473:	5e                   	pop    %esi
 474:	5f                   	pop    %edi
 475:	5d                   	pop    %ebp
 476:	c3                   	ret    
 477:	90                   	nop
    if(cc < 1)
 478:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 47a:	8b 45 08             	mov    0x8(%ebp),%eax
 47d:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 481:	83 c4 2c             	add    $0x2c,%esp
 484:	5b                   	pop    %ebx
 485:	5e                   	pop    %esi
 486:	5f                   	pop    %edi
 487:	5d                   	pop    %ebp
 488:	c3                   	ret    
 489:	8d 76 00             	lea    0x0(%esi),%esi

0000048c <stat>:

int
stat(char *n, struct stat *st)
{
 48c:	55                   	push   %ebp
 48d:	89 e5                	mov    %esp,%ebp
 48f:	56                   	push   %esi
 490:	53                   	push   %ebx
 491:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 494:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 49b:	00 
 49c:	8b 45 08             	mov    0x8(%ebp),%eax
 49f:	89 04 24             	mov    %eax,(%esp)
 4a2:	e8 cc 00 00 00       	call   573 <open>
 4a7:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 4a9:	85 c0                	test   %eax,%eax
 4ab:	78 23                	js     4d0 <stat+0x44>
    return -1;
  r = fstat(fd, st);
 4ad:	8b 45 0c             	mov    0xc(%ebp),%eax
 4b0:	89 44 24 04          	mov    %eax,0x4(%esp)
 4b4:	89 1c 24             	mov    %ebx,(%esp)
 4b7:	e8 cf 00 00 00       	call   58b <fstat>
 4bc:	89 c6                	mov    %eax,%esi
  close(fd);
 4be:	89 1c 24             	mov    %ebx,(%esp)
 4c1:	e8 95 00 00 00       	call   55b <close>
  return r;
}
 4c6:	89 f0                	mov    %esi,%eax
 4c8:	83 c4 10             	add    $0x10,%esp
 4cb:	5b                   	pop    %ebx
 4cc:	5e                   	pop    %esi
 4cd:	5d                   	pop    %ebp
 4ce:	c3                   	ret    
 4cf:	90                   	nop
    return -1;
 4d0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 4d5:	eb ef                	jmp    4c6 <stat+0x3a>
 4d7:	90                   	nop

000004d8 <atoi>:

int
atoi(const char *s)
{
 4d8:	55                   	push   %ebp
 4d9:	89 e5                	mov    %esp,%ebp
 4db:	53                   	push   %ebx
 4dc:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4df:	0f be 11             	movsbl (%ecx),%edx
 4e2:	8d 42 d0             	lea    -0x30(%edx),%eax
 4e5:	3c 09                	cmp    $0x9,%al
 4e7:	b8 00 00 00 00       	mov    $0x0,%eax
 4ec:	77 15                	ja     503 <atoi+0x2b>
 4ee:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 4f0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 4f3:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
 4f7:	41                   	inc    %ecx
  while('0' <= *s && *s <= '9')
 4f8:	0f be 11             	movsbl (%ecx),%edx
 4fb:	8d 5a d0             	lea    -0x30(%edx),%ebx
 4fe:	80 fb 09             	cmp    $0x9,%bl
 501:	76 ed                	jbe    4f0 <atoi+0x18>
  return n;
}
 503:	5b                   	pop    %ebx
 504:	5d                   	pop    %ebp
 505:	c3                   	ret    
 506:	66 90                	xchg   %ax,%ax

00000508 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 508:	55                   	push   %ebp
 509:	89 e5                	mov    %esp,%ebp
 50b:	56                   	push   %esi
 50c:	53                   	push   %ebx
 50d:	8b 45 08             	mov    0x8(%ebp),%eax
 510:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 513:	8b 75 10             	mov    0x10(%ebp),%esi
memmove(void *vdst, void *vsrc, int n)
 516:	31 d2                	xor    %edx,%edx
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 518:	85 f6                	test   %esi,%esi
 51a:	7e 0b                	jle    527 <memmove+0x1f>
    *dst++ = *src++;
 51c:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 51f:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 522:	42                   	inc    %edx
  while(n-- > 0)
 523:	39 f2                	cmp    %esi,%edx
 525:	75 f5                	jne    51c <memmove+0x14>
  return vdst;
}
 527:	5b                   	pop    %ebx
 528:	5e                   	pop    %esi
 529:	5d                   	pop    %ebp
 52a:	c3                   	ret    

0000052b <fork>:
 52b:	b8 01 00 00 00       	mov    $0x1,%eax
 530:	cd 40                	int    $0x40
 532:	c3                   	ret    

00000533 <exit>:
 533:	b8 02 00 00 00       	mov    $0x2,%eax
 538:	cd 40                	int    $0x40
 53a:	c3                   	ret    

0000053b <wait>:
 53b:	b8 03 00 00 00       	mov    $0x3,%eax
 540:	cd 40                	int    $0x40
 542:	c3                   	ret    

00000543 <pipe>:
 543:	b8 04 00 00 00       	mov    $0x4,%eax
 548:	cd 40                	int    $0x40
 54a:	c3                   	ret    

0000054b <read>:
 54b:	b8 05 00 00 00       	mov    $0x5,%eax
 550:	cd 40                	int    $0x40
 552:	c3                   	ret    

00000553 <write>:
 553:	b8 10 00 00 00       	mov    $0x10,%eax
 558:	cd 40                	int    $0x40
 55a:	c3                   	ret    

0000055b <close>:
 55b:	b8 15 00 00 00       	mov    $0x15,%eax
 560:	cd 40                	int    $0x40
 562:	c3                   	ret    

00000563 <kill>:
 563:	b8 06 00 00 00       	mov    $0x6,%eax
 568:	cd 40                	int    $0x40
 56a:	c3                   	ret    

0000056b <exec>:
 56b:	b8 07 00 00 00       	mov    $0x7,%eax
 570:	cd 40                	int    $0x40
 572:	c3                   	ret    

00000573 <open>:
 573:	b8 0f 00 00 00       	mov    $0xf,%eax
 578:	cd 40                	int    $0x40
 57a:	c3                   	ret    

0000057b <mknod>:
 57b:	b8 11 00 00 00       	mov    $0x11,%eax
 580:	cd 40                	int    $0x40
 582:	c3                   	ret    

00000583 <unlink>:
 583:	b8 12 00 00 00       	mov    $0x12,%eax
 588:	cd 40                	int    $0x40
 58a:	c3                   	ret    

0000058b <fstat>:
 58b:	b8 08 00 00 00       	mov    $0x8,%eax
 590:	cd 40                	int    $0x40
 592:	c3                   	ret    

00000593 <link>:
 593:	b8 13 00 00 00       	mov    $0x13,%eax
 598:	cd 40                	int    $0x40
 59a:	c3                   	ret    

0000059b <mkdir>:
 59b:	b8 14 00 00 00       	mov    $0x14,%eax
 5a0:	cd 40                	int    $0x40
 5a2:	c3                   	ret    

000005a3 <chdir>:
 5a3:	b8 09 00 00 00       	mov    $0x9,%eax
 5a8:	cd 40                	int    $0x40
 5aa:	c3                   	ret    

000005ab <dup>:
 5ab:	b8 0a 00 00 00       	mov    $0xa,%eax
 5b0:	cd 40                	int    $0x40
 5b2:	c3                   	ret    

000005b3 <getpid>:
 5b3:	b8 0b 00 00 00       	mov    $0xb,%eax
 5b8:	cd 40                	int    $0x40
 5ba:	c3                   	ret    

000005bb <sbrk>:
 5bb:	b8 0c 00 00 00       	mov    $0xc,%eax
 5c0:	cd 40                	int    $0x40
 5c2:	c3                   	ret    

000005c3 <sleep>:
 5c3:	b8 0d 00 00 00       	mov    $0xd,%eax
 5c8:	cd 40                	int    $0x40
 5ca:	c3                   	ret    

000005cb <uptime>:
 5cb:	b8 0e 00 00 00       	mov    $0xe,%eax
 5d0:	cd 40                	int    $0x40
 5d2:	c3                   	ret    

000005d3 <getprocnum>:
 5d3:	b8 16 00 00 00       	mov    $0x16,%eax
 5d8:	cd 40                	int    $0x40
 5da:	c3                   	ret    

000005db <mempagenum>:
 5db:	b8 17 00 00 00       	mov    $0x17,%eax
 5e0:	cd 40                	int    $0x40
 5e2:	c3                   	ret    

000005e3 <syscallnum>:
 5e3:	b8 18 00 00 00       	mov    $0x18,%eax
 5e8:	cd 40                	int    $0x40
 5ea:	c3                   	ret    

000005eb <settickets>:
 5eb:	b8 19 00 00 00       	mov    $0x19,%eax
 5f0:	cd 40                	int    $0x40
 5f2:	c3                   	ret    

000005f3 <getsheltime>:
 5f3:	b8 1a 00 00 00       	mov    $0x1a,%eax
 5f8:	cd 40                	int    $0x40
 5fa:	c3                   	ret    

000005fb <setstride>:
 5fb:	b8 1b 00 00 00       	mov    $0x1b,%eax
 600:	cd 40                	int    $0x40
 602:	c3                   	ret    

00000603 <setpass>:
 603:	b8 1c 00 00 00       	mov    $0x1c,%eax
 608:	cd 40                	int    $0x40
 60a:	c3                   	ret    

0000060b <join>:
 60b:	b8 1d 00 00 00       	mov    $0x1d,%eax
 610:	cd 40                	int    $0x40
 612:	c3                   	ret    

00000613 <clone1>:
 613:	b8 1e 00 00 00       	mov    $0x1e,%eax
 618:	cd 40                	int    $0x40
 61a:	c3                   	ret    
 61b:	90                   	nop

0000061c <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 61c:	55                   	push   %ebp
 61d:	89 e5                	mov    %esp,%ebp
 61f:	57                   	push   %edi
 620:	56                   	push   %esi
 621:	53                   	push   %ebx
 622:	83 ec 3c             	sub    $0x3c,%esp
 625:	89 c7                	mov    %eax,%edi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 627:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 629:	8b 5d 08             	mov    0x8(%ebp),%ebx
 62c:	85 db                	test   %ebx,%ebx
 62e:	74 04                	je     634 <printint+0x18>
 630:	85 d2                	test   %edx,%edx
 632:	78 5d                	js     691 <printint+0x75>
  neg = 0;
 634:	31 db                	xor    %ebx,%ebx
  } else {
    x = xx;
  }

  i = 0;
 636:	31 f6                	xor    %esi,%esi
 638:	eb 04                	jmp    63e <printint+0x22>
 63a:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 63c:	89 d6                	mov    %edx,%esi
 63e:	31 d2                	xor    %edx,%edx
 640:	f7 f1                	div    %ecx
 642:	8a 92 0b 0a 00 00    	mov    0xa0b(%edx),%dl
 648:	88 54 35 d8          	mov    %dl,-0x28(%ebp,%esi,1)
 64c:	8d 56 01             	lea    0x1(%esi),%edx
  }while((x /= base) != 0);
 64f:	85 c0                	test   %eax,%eax
 651:	75 e9                	jne    63c <printint+0x20>
  if(neg)
 653:	85 db                	test   %ebx,%ebx
 655:	74 08                	je     65f <printint+0x43>
    buf[i++] = '-';
 657:	c6 44 15 d8 2d       	movb   $0x2d,-0x28(%ebp,%edx,1)
 65c:	8d 56 02             	lea    0x2(%esi),%edx

  while(--i >= 0)
 65f:	8d 5a ff             	lea    -0x1(%edx),%ebx
 662:	8d 75 d7             	lea    -0x29(%ebp),%esi
 665:	8d 76 00             	lea    0x0(%esi),%esi
 668:	8a 44 1d d8          	mov    -0x28(%ebp,%ebx,1),%al
 66c:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 66f:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 676:	00 
 677:	89 74 24 04          	mov    %esi,0x4(%esp)
 67b:	89 3c 24             	mov    %edi,(%esp)
 67e:	e8 d0 fe ff ff       	call   553 <write>
  while(--i >= 0)
 683:	4b                   	dec    %ebx
 684:	83 fb ff             	cmp    $0xffffffff,%ebx
 687:	75 df                	jne    668 <printint+0x4c>
    putc(fd, buf[i]);
}
 689:	83 c4 3c             	add    $0x3c,%esp
 68c:	5b                   	pop    %ebx
 68d:	5e                   	pop    %esi
 68e:	5f                   	pop    %edi
 68f:	5d                   	pop    %ebp
 690:	c3                   	ret    
    x = -xx;
 691:	f7 d8                	neg    %eax
    neg = 1;
 693:	bb 01 00 00 00       	mov    $0x1,%ebx
    x = -xx;
 698:	eb 9c                	jmp    636 <printint+0x1a>
 69a:	66 90                	xchg   %ax,%ax

0000069c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 69c:	55                   	push   %ebp
 69d:	89 e5                	mov    %esp,%ebp
 69f:	57                   	push   %edi
 6a0:	56                   	push   %esi
 6a1:	53                   	push   %ebx
 6a2:	83 ec 3c             	sub    $0x3c,%esp
 6a5:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6a8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 6ab:	8a 03                	mov    (%ebx),%al
 6ad:	84 c0                	test   %al,%al
 6af:	0f 84 bb 00 00 00    	je     770 <printf+0xd4>
printf(int fd, char *fmt, ...)
 6b5:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
 6b6:	8d 55 10             	lea    0x10(%ebp),%edx
 6b9:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  state = 0;
 6bc:	31 ff                	xor    %edi,%edi
 6be:	eb 2f                	jmp    6ef <printf+0x53>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 6c0:	83 f9 25             	cmp    $0x25,%ecx
 6c3:	0f 84 af 00 00 00    	je     778 <printf+0xdc>
        state = '%';
      } else {
        putc(fd, c);
 6c9:	88 4d e2             	mov    %cl,-0x1e(%ebp)
  write(fd, &c, 1);
 6cc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6d3:	00 
 6d4:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 6d7:	89 44 24 04          	mov    %eax,0x4(%esp)
 6db:	89 34 24             	mov    %esi,(%esp)
 6de:	e8 70 fe ff ff       	call   553 <write>
 6e3:	43                   	inc    %ebx
  for(i = 0; fmt[i]; i++){
 6e4:	8a 43 ff             	mov    -0x1(%ebx),%al
 6e7:	84 c0                	test   %al,%al
 6e9:	0f 84 81 00 00 00    	je     770 <printf+0xd4>
    c = fmt[i] & 0xff;
 6ef:	0f b6 c8             	movzbl %al,%ecx
    if(state == 0){
 6f2:	85 ff                	test   %edi,%edi
 6f4:	74 ca                	je     6c0 <printf+0x24>
      }
    } else if(state == '%'){
 6f6:	83 ff 25             	cmp    $0x25,%edi
 6f9:	75 e8                	jne    6e3 <printf+0x47>
      if(c == 'd'){
 6fb:	83 f9 64             	cmp    $0x64,%ecx
 6fe:	0f 84 14 01 00 00    	je     818 <printf+0x17c>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 704:	83 f9 78             	cmp    $0x78,%ecx
 707:	74 7b                	je     784 <printf+0xe8>
 709:	83 f9 70             	cmp    $0x70,%ecx
 70c:	74 76                	je     784 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 70e:	83 f9 73             	cmp    $0x73,%ecx
 711:	0f 84 91 00 00 00    	je     7a8 <printf+0x10c>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 717:	83 f9 63             	cmp    $0x63,%ecx
 71a:	0f 84 cc 00 00 00    	je     7ec <printf+0x150>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 720:	83 f9 25             	cmp    $0x25,%ecx
 723:	0f 84 13 01 00 00    	je     83c <printf+0x1a0>
 729:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
  write(fd, &c, 1);
 72d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 734:	00 
 735:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 738:	89 44 24 04          	mov    %eax,0x4(%esp)
 73c:	89 34 24             	mov    %esi,(%esp)
 73f:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 742:	e8 0c fe ff ff       	call   553 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 747:	8b 4d d0             	mov    -0x30(%ebp),%ecx
 74a:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
 74d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 754:	00 
 755:	8d 55 e7             	lea    -0x19(%ebp),%edx
 758:	89 54 24 04          	mov    %edx,0x4(%esp)
 75c:	89 34 24             	mov    %esi,(%esp)
 75f:	e8 ef fd ff ff       	call   553 <write>
      }
      state = 0;
 764:	31 ff                	xor    %edi,%edi
 766:	43                   	inc    %ebx
  for(i = 0; fmt[i]; i++){
 767:	8a 43 ff             	mov    -0x1(%ebx),%al
 76a:	84 c0                	test   %al,%al
 76c:	75 81                	jne    6ef <printf+0x53>
 76e:	66 90                	xchg   %ax,%ax
    }
  }
}
 770:	83 c4 3c             	add    $0x3c,%esp
 773:	5b                   	pop    %ebx
 774:	5e                   	pop    %esi
 775:	5f                   	pop    %edi
 776:	5d                   	pop    %ebp
 777:	c3                   	ret    
        state = '%';
 778:	bf 25 00 00 00       	mov    $0x25,%edi
 77d:	e9 61 ff ff ff       	jmp    6e3 <printf+0x47>
 782:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 784:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 78b:	b9 10 00 00 00       	mov    $0x10,%ecx
 790:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 793:	8b 10                	mov    (%eax),%edx
 795:	89 f0                	mov    %esi,%eax
 797:	e8 80 fe ff ff       	call   61c <printint>
        ap++;
 79c:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 7a0:	31 ff                	xor    %edi,%edi
        ap++;
 7a2:	e9 3c ff ff ff       	jmp    6e3 <printf+0x47>
 7a7:	90                   	nop
        s = (char*)*ap;
 7a8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 7ab:	8b 3a                	mov    (%edx),%edi
        ap++;
 7ad:	83 c2 04             	add    $0x4,%edx
 7b0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
 7b3:	85 ff                	test   %edi,%edi
 7b5:	0f 84 a3 00 00 00    	je     85e <printf+0x1c2>
        while(*s != 0){
 7bb:	8a 07                	mov    (%edi),%al
 7bd:	84 c0                	test   %al,%al
 7bf:	74 24                	je     7e5 <printf+0x149>
 7c1:	8d 76 00             	lea    0x0(%esi),%esi
 7c4:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 7c7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 7ce:	00 
 7cf:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 7d2:	89 44 24 04          	mov    %eax,0x4(%esp)
 7d6:	89 34 24             	mov    %esi,(%esp)
 7d9:	e8 75 fd ff ff       	call   553 <write>
          s++;
 7de:	47                   	inc    %edi
        while(*s != 0){
 7df:	8a 07                	mov    (%edi),%al
 7e1:	84 c0                	test   %al,%al
 7e3:	75 df                	jne    7c4 <printf+0x128>
      state = 0;
 7e5:	31 ff                	xor    %edi,%edi
 7e7:	e9 f7 fe ff ff       	jmp    6e3 <printf+0x47>
        putc(fd, *ap);
 7ec:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 7ef:	8b 02                	mov    (%edx),%eax
 7f1:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 7f4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 7fb:	00 
 7fc:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 7ff:	89 44 24 04          	mov    %eax,0x4(%esp)
 803:	89 34 24             	mov    %esi,(%esp)
 806:	e8 48 fd ff ff       	call   553 <write>
        ap++;
 80b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 80f:	31 ff                	xor    %edi,%edi
 811:	e9 cd fe ff ff       	jmp    6e3 <printf+0x47>
 816:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 818:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 81f:	b1 0a                	mov    $0xa,%cl
 821:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 824:	8b 10                	mov    (%eax),%edx
 826:	89 f0                	mov    %esi,%eax
 828:	e8 ef fd ff ff       	call   61c <printint>
        ap++;
 82d:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 831:	66 31 ff             	xor    %di,%di
 834:	e9 aa fe ff ff       	jmp    6e3 <printf+0x47>
 839:	8d 76 00             	lea    0x0(%esi),%esi
 83c:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
  write(fd, &c, 1);
 840:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 847:	00 
 848:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 84b:	89 44 24 04          	mov    %eax,0x4(%esp)
 84f:	89 34 24             	mov    %esi,(%esp)
 852:	e8 fc fc ff ff       	call   553 <write>
      state = 0;
 857:	31 ff                	xor    %edi,%edi
 859:	e9 85 fe ff ff       	jmp    6e3 <printf+0x47>
          s = "(null)";
 85e:	bf 04 0a 00 00       	mov    $0xa04,%edi
 863:	e9 53 ff ff ff       	jmp    7bb <printf+0x11f>

00000868 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 868:	55                   	push   %ebp
 869:	89 e5                	mov    %esp,%ebp
 86b:	57                   	push   %edi
 86c:	56                   	push   %esi
 86d:	53                   	push   %ebx
 86e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 871:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 874:	a1 bc 0d 00 00       	mov    0xdbc,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 879:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 87b:	39 d0                	cmp    %edx,%eax
 87d:	72 11                	jb     890 <free+0x28>
 87f:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 880:	39 c8                	cmp    %ecx,%eax
 882:	72 04                	jb     888 <free+0x20>
 884:	39 ca                	cmp    %ecx,%edx
 886:	72 10                	jb     898 <free+0x30>
 888:	89 c8                	mov    %ecx,%eax
 88a:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 88c:	39 d0                	cmp    %edx,%eax
 88e:	73 f0                	jae    880 <free+0x18>
 890:	39 ca                	cmp    %ecx,%edx
 892:	72 04                	jb     898 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 894:	39 c8                	cmp    %ecx,%eax
 896:	72 f0                	jb     888 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 898:	8b 73 fc             	mov    -0x4(%ebx),%esi
 89b:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 89e:	39 cf                	cmp    %ecx,%edi
 8a0:	74 1a                	je     8bc <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 8a2:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 8a5:	8b 48 04             	mov    0x4(%eax),%ecx
 8a8:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 8ab:	39 f2                	cmp    %esi,%edx
 8ad:	74 24                	je     8d3 <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 8af:	89 10                	mov    %edx,(%eax)
  freep = p;
 8b1:	a3 bc 0d 00 00       	mov    %eax,0xdbc
}
 8b6:	5b                   	pop    %ebx
 8b7:	5e                   	pop    %esi
 8b8:	5f                   	pop    %edi
 8b9:	5d                   	pop    %ebp
 8ba:	c3                   	ret    
 8bb:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 8bc:	03 71 04             	add    0x4(%ecx),%esi
 8bf:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 8c2:	8b 08                	mov    (%eax),%ecx
 8c4:	8b 09                	mov    (%ecx),%ecx
 8c6:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 8c9:	8b 48 04             	mov    0x4(%eax),%ecx
 8cc:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 8cf:	39 f2                	cmp    %esi,%edx
 8d1:	75 dc                	jne    8af <free+0x47>
    p->s.size += bp->s.size;
 8d3:	03 4b fc             	add    -0x4(%ebx),%ecx
 8d6:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 8d9:	8b 53 f8             	mov    -0x8(%ebx),%edx
 8dc:	89 10                	mov    %edx,(%eax)
  freep = p;
 8de:	a3 bc 0d 00 00       	mov    %eax,0xdbc
}
 8e3:	5b                   	pop    %ebx
 8e4:	5e                   	pop    %esi
 8e5:	5f                   	pop    %edi
 8e6:	5d                   	pop    %ebp
 8e7:	c3                   	ret    

000008e8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8e8:	55                   	push   %ebp
 8e9:	89 e5                	mov    %esp,%ebp
 8eb:	57                   	push   %edi
 8ec:	56                   	push   %esi
 8ed:	53                   	push   %ebx
 8ee:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8f1:	8b 75 08             	mov    0x8(%ebp),%esi
 8f4:	83 c6 07             	add    $0x7,%esi
 8f7:	c1 ee 03             	shr    $0x3,%esi
 8fa:	46                   	inc    %esi
  if((prevp = freep) == 0){
 8fb:	8b 15 bc 0d 00 00    	mov    0xdbc,%edx
 901:	85 d2                	test   %edx,%edx
 903:	0f 84 8d 00 00 00    	je     996 <malloc+0xae>
 909:	8b 02                	mov    (%edx),%eax
 90b:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 90e:	39 ce                	cmp    %ecx,%esi
 910:	76 52                	jbe    964 <malloc+0x7c>
 912:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 919:	eb 0a                	jmp    925 <malloc+0x3d>
 91b:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 91c:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 91e:	8b 48 04             	mov    0x4(%eax),%ecx
 921:	39 ce                	cmp    %ecx,%esi
 923:	76 3f                	jbe    964 <malloc+0x7c>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 925:	89 c2                	mov    %eax,%edx
 927:	3b 05 bc 0d 00 00    	cmp    0xdbc,%eax
 92d:	75 ed                	jne    91c <malloc+0x34>
  if(nu < 4096)
 92f:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 935:	76 4d                	jbe    984 <malloc+0x9c>
 937:	89 d8                	mov    %ebx,%eax
 939:	89 f7                	mov    %esi,%edi
  p = sbrk(nu * sizeof(Header));
 93b:	89 04 24             	mov    %eax,(%esp)
 93e:	e8 78 fc ff ff       	call   5bb <sbrk>
  if(p == (char*)-1)
 943:	83 f8 ff             	cmp    $0xffffffff,%eax
 946:	74 18                	je     960 <malloc+0x78>
  hp->s.size = nu;
 948:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 94b:	83 c0 08             	add    $0x8,%eax
 94e:	89 04 24             	mov    %eax,(%esp)
 951:	e8 12 ff ff ff       	call   868 <free>
  return freep;
 956:	8b 15 bc 0d 00 00    	mov    0xdbc,%edx
      if((p = morecore(nunits)) == 0)
 95c:	85 d2                	test   %edx,%edx
 95e:	75 bc                	jne    91c <malloc+0x34>
        return 0;
 960:	31 c0                	xor    %eax,%eax
 962:	eb 18                	jmp    97c <malloc+0x94>
      if(p->s.size == nunits)
 964:	39 ce                	cmp    %ecx,%esi
 966:	74 28                	je     990 <malloc+0xa8>
        p->s.size -= nunits;
 968:	29 f1                	sub    %esi,%ecx
 96a:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 96d:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 970:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 973:	89 15 bc 0d 00 00    	mov    %edx,0xdbc
      return (void*)(p + 1);
 979:	83 c0 08             	add    $0x8,%eax
  }
}
 97c:	83 c4 1c             	add    $0x1c,%esp
 97f:	5b                   	pop    %ebx
 980:	5e                   	pop    %esi
 981:	5f                   	pop    %edi
 982:	5d                   	pop    %ebp
 983:	c3                   	ret    
  if(nu < 4096)
 984:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 989:	bf 00 10 00 00       	mov    $0x1000,%edi
 98e:	eb ab                	jmp    93b <malloc+0x53>
        prevp->s.ptr = p->s.ptr;
 990:	8b 08                	mov    (%eax),%ecx
 992:	89 0a                	mov    %ecx,(%edx)
 994:	eb dd                	jmp    973 <malloc+0x8b>
    base.s.ptr = freep = prevp = &base;
 996:	c7 05 bc 0d 00 00 c0 	movl   $0xdc0,0xdbc
 99d:	0d 00 00 
 9a0:	c7 05 c0 0d 00 00 c0 	movl   $0xdc0,0xdc0
 9a7:	0d 00 00 
    base.s.size = 0;
 9aa:	c7 05 c4 0d 00 00 00 	movl   $0x0,0xdc4
 9b1:	00 00 00 
 9b4:	b8 c0 0d 00 00       	mov    $0xdc0,%eax
 9b9:	e9 54 ff ff ff       	jmp    912 <malloc+0x2a>
