
_frisbee：     文件格式 elf32-i386


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
  26:	e8 79 03 00 00       	call   3a4 <strlen>
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
  51:	e8 4e 03 00 00       	call   3a4 <strlen>
  56:	48                   	dec    %eax
  57:	39 c3                	cmp    %eax,%ebx
  59:	72 e9                	jb     44 <main+0x44>
        }
        t = t + temp;
  5b:	01 3d ac 0d 00 00    	add    %edi,0xdac
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
  76:	e8 29 03 00 00       	call   3a4 <strlen>
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
  a1:	e8 fe 02 00 00       	call   3a4 <strlen>
  a6:	48                   	dec    %eax
  a7:	39 c3                	cmp    %eax,%ebx
  a9:	72 e9                	jb     94 <main+0x94>
        }
        round = round + temp;
  ab:	01 3d b0 0d 00 00    	add    %edi,0xdb0
    for(i=0;i<strlen(argv[2]);i++){
  b1:	ff 44 24 1c          	incl   0x1c(%esp)
  b5:	eb b9                	jmp    70 <main+0x70>
    lk->locked = 0;
  b7:	c7 05 c0 0d 00 00 00 	movl   $0x0,0xdc0
  be:	00 00 00 
    //printf(1,"%d\n", round);
    //arg = round;


    lock_init(&lock);
    for(i=0;i<t;i++){
  c1:	8b 0d ac 0d 00 00    	mov    0xdac,%ecx
  c7:	85 c9                	test   %ecx,%ecx
  c9:	7e 26                	jle    f1 <main+0xf1>
  cb:	31 db                	xor    %ebx,%ebx
  cd:	8d 74 24 2c          	lea    0x2c(%esp),%esi
  d1:	8d 76 00             	lea    0x0(%esi),%esi

        arg = i+1;
  d4:	43                   	inc    %ebx
  d5:	89 5c 24 2c          	mov    %ebx,0x2c(%esp)
        thread_create(&pass, &arg);
  d9:	89 74 24 04          	mov    %esi,0x4(%esp)
  dd:	c7 04 24 d4 01 00 00 	movl   $0x1d4,(%esp)
  e4:	e8 d3 01 00 00       	call   2bc <thread_create>
    for(i=0;i<t;i++){
  e9:	39 1d ac 0d 00 00    	cmp    %ebx,0xdac
  ef:	7f e3                	jg     d4 <main+0xd4>
        //printf(1, "%d\n", result);
    }
    void **join_stack = (void**) ((uint)sbrk(0) - 4);
  f1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  f8:	e8 a2 04 00 00       	call   59f <sbrk>
  fd:	8d 70 fc             	lea    -0x4(%eax),%esi
    for(i=0;i<t;i++){
 100:	31 db                	xor    %ebx,%ebx
 102:	8b 15 ac 0d 00 00    	mov    0xdac,%edx
 108:	85 d2                	test   %edx,%edx
 10a:	7e 11                	jle    11d <main+0x11d>
        join(join_stack);
 10c:	89 34 24             	mov    %esi,(%esp)
 10f:	e8 db 04 00 00       	call   5ef <join>
    for(i=0;i<t;i++){
 114:	43                   	inc    %ebx
 115:	39 1d ac 0d 00 00    	cmp    %ebx,0xdac
 11b:	7f ef                	jg     10c <main+0x10c>
    }




    exit();
 11d:	e8 f5 03 00 00       	call   517 <exit>
 122:	66 90                	xchg   %ax,%ax

00000124 <test_and_set>:
int test_and_set(struct lock_t *lk, int tn){
 124:	55                   	push   %ebp
 125:	89 e5                	mov    %esp,%ebp
 127:	8b 45 08             	mov    0x8(%ebp),%eax
    if(tn == 1){
 12a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
 12e:	74 0c                	je     13c <test_and_set+0x18>
        lk->locked = 0;
 130:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
        return 0;
 136:	31 c0                	xor    %eax,%eax
}
 138:	5d                   	pop    %ebp
 139:	c3                   	ret    
 13a:	66 90                	xchg   %ax,%ax
        if(lk->locked == 0){
 13c:	8b 10                	mov    (%eax),%edx
 13e:	85 d2                	test   %edx,%edx
 140:	74 0a                	je     14c <test_and_set+0x28>
            return 0;
 142:	31 c0                	xor    %eax,%eax
 144:	4a                   	dec    %edx
 145:	0f 94 c0             	sete   %al
}
 148:	5d                   	pop    %ebp
 149:	c3                   	ret    
 14a:	66 90                	xchg   %ax,%ax
            lk->locked = 1;
 14c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
            return 0;
 152:	31 c0                	xor    %eax,%eax
}
 154:	5d                   	pop    %ebp
 155:	c3                   	ret    
 156:	66 90                	xchg   %ax,%ax

00000158 <lock_init>:
{
 158:	55                   	push   %ebp
 159:	89 e5                	mov    %esp,%ebp
    lk->locked = 0;
 15b:	8b 45 08             	mov    0x8(%ebp),%eax
 15e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
 164:	5d                   	pop    %ebp
 165:	c3                   	ret    
 166:	66 90                	xchg   %ax,%ax

00000168 <lock_acquire>:
{
 168:	55                   	push   %ebp
 169:	89 e5                	mov    %esp,%ebp
 16b:	56                   	push   %esi
 16c:	53                   	push   %ebx
 16d:	83 ec 10             	sub    $0x10,%esp
 170:	8b 5d 08             	mov    0x8(%ebp),%ebx
        if(lk->locked == 0){
 173:	8b 03                	mov    (%ebx),%eax
 175:	85 c0                	test   %eax,%eax
 177:	74 0b                	je     184 <lock_acquire+0x1c>
        if(lk->locked == 1){
 179:	48                   	dec    %eax
 17a:	74 18                	je     194 <lock_acquire+0x2c>
}
 17c:	83 c4 10             	add    $0x10,%esp
 17f:	5b                   	pop    %ebx
 180:	5e                   	pop    %esi
 181:	5d                   	pop    %ebp
 182:	c3                   	ret    
 183:	90                   	nop
            lk->locked = 1;
 184:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
}
 18a:	83 c4 10             	add    $0x10,%esp
 18d:	5b                   	pop    %ebx
 18e:	5e                   	pop    %esi
 18f:	5d                   	pop    %ebp
 190:	c3                   	ret    
 191:	8d 76 00             	lea    0x0(%esi),%esi
        if(lk->locked == 1){
 194:	be 01 00 00 00       	mov    $0x1,%esi
 199:	8d 76 00             	lea    0x0(%esi),%esi
        sleep(a);
 19c:	89 34 24             	mov    %esi,(%esp)
 19f:	e8 03 04 00 00       	call   5a7 <sleep>
        a = a + 2;
 1a4:	83 c6 02             	add    $0x2,%esi
        if(lk->locked == 0){
 1a7:	8b 03                	mov    (%ebx),%eax
 1a9:	85 c0                	test   %eax,%eax
 1ab:	74 d7                	je     184 <lock_acquire+0x1c>
        if(lk->locked == 1){
 1ad:	48                   	dec    %eax
 1ae:	74 ec                	je     19c <lock_acquire+0x34>
}
 1b0:	83 c4 10             	add    $0x10,%esp
 1b3:	5b                   	pop    %ebx
 1b4:	5e                   	pop    %esi
 1b5:	5d                   	pop    %ebp
 1b6:	c3                   	ret    
 1b7:	90                   	nop

000001b8 <lock_release>:
{
 1b8:	55                   	push   %ebp
 1b9:	89 e5                	mov    %esp,%ebp
        lk->locked = 0;
 1bb:	8b 45 08             	mov    0x8(%ebp),%eax
 1be:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    sleep(100);
 1c4:	c7 45 08 64 00 00 00 	movl   $0x64,0x8(%ebp)
}
 1cb:	5d                   	pop    %ebp
    sleep(100);
 1cc:	e9 d6 03 00 00       	jmp    5a7 <sleep>
 1d1:	8d 76 00             	lea    0x0(%esi),%esi

000001d4 <pass>:
pass(void *arg){
 1d4:	55                   	push   %ebp
 1d5:	89 e5                	mov    %esp,%ebp
 1d7:	53                   	push   %ebx
 1d8:	83 ec 24             	sub    $0x24,%esp
    sleep(100);
 1db:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
 1e2:	e8 c0 03 00 00       	call   5a7 <sleep>
    for(; x < round; )
 1e7:	a1 b0 0d 00 00       	mov    0xdb0,%eax
 1ec:	39 05 a8 0d 00 00    	cmp    %eax,0xda8
 1f2:	7d 5f                	jge    253 <pass+0x7f>
        lock_acquire(lk);
 1f4:	c7 04 24 c0 0d 00 00 	movl   $0xdc0,(%esp)
 1fb:	e8 68 ff ff ff       	call   168 <lock_acquire>
        id = getpid();
 200:	e8 92 03 00 00       	call   597 <getpid>
        for(i = 0;i<t;i++){
 205:	8b 1d ac 0d 00 00    	mov    0xdac,%ebx
 20b:	85 db                	test   %ebx,%ebx
 20d:	7e 2b                	jle    23a <pass+0x66>
            if(x==round){
 20f:	8b 15 b0 0d 00 00    	mov    0xdb0,%edx
 215:	39 15 a8 0d 00 00    	cmp    %edx,0xda8
 21b:	74 1d                	je     23a <pass+0x66>
        for(i = 0;i<t;i++){
 21d:	31 c9                	xor    %ecx,%ecx
            if(fr[i].pid == id){
 21f:	39 05 e0 0d 00 00    	cmp    %eax,0xde0
 225:	75 0e                	jne    235 <pass+0x61>
 227:	eb 33                	jmp    25c <pass+0x88>
 229:	8d 76 00             	lea    0x0(%esi),%esi
 22c:	39 04 cd e0 0d 00 00 	cmp    %eax,0xde0(,%ecx,8)
 233:	74 27                	je     25c <pass+0x88>
        for(i = 0;i<t;i++){
 235:	41                   	inc    %ecx
 236:	39 d9                	cmp    %ebx,%ecx
 238:	75 f2                	jne    22c <pass+0x58>
        lock_release(lk);
 23a:	c7 04 24 c0 0d 00 00 	movl   $0xdc0,(%esp)
 241:	e8 72 ff ff ff       	call   1b8 <lock_release>
    for(; x < round; )
 246:	a1 b0 0d 00 00       	mov    0xdb0,%eax
 24b:	39 05 a8 0d 00 00    	cmp    %eax,0xda8
 251:	7c a1                	jl     1f4 <pass+0x20>
}
 253:	83 c4 24             	add    $0x24,%esp
 256:	5b                   	pop    %ebx
 257:	5d                   	pop    %ebp
 258:	c3                   	ret    
 259:	8d 76 00             	lea    0x0(%esi),%esi
                if(fr[i].hasFrisbee == 0){
 25c:	8b 04 cd e4 0d 00 00 	mov    0xde4(,%ecx,8),%eax
 263:	85 c0                	test   %eax,%eax
 265:	74 d3                	je     23a <pass+0x66>
                    j = (i + 1) % t;
 267:	8d 41 01             	lea    0x1(%ecx),%eax
 26a:	99                   	cltd   
 26b:	f7 fb                	idiv   %ebx
                    fr[j].hasFrisbee = 1;
 26d:	c7 04 d5 e4 0d 00 00 	movl   $0x1,0xde4(,%edx,8)
 274:	01 00 00 00 
                    fr[i].hasFrisbee = 0;
 278:	c7 04 cd e4 0d 00 00 	movl   $0x0,0xde4(,%ecx,8)
 27f:	00 00 00 00 
                    printf(1, "Pass number no: %d, Thread %d is passing the token to thread %d\n", number++,i,j);
 283:	a1 a4 0d 00 00       	mov    0xda4,%eax
 288:	8d 58 01             	lea    0x1(%eax),%ebx
 28b:	89 1d a4 0d 00 00    	mov    %ebx,0xda4
 291:	89 54 24 10          	mov    %edx,0x10(%esp)
 295:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
 299:	89 44 24 08          	mov    %eax,0x8(%esp)
 29d:	c7 44 24 04 a4 09 00 	movl   $0x9a4,0x4(%esp)
 2a4:	00 
 2a5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2ac:	e8 cf 03 00 00       	call   680 <printf>
                    x++;
 2b1:	ff 05 a8 0d 00 00    	incl   0xda8
                    break;
 2b7:	eb 81                	jmp    23a <pass+0x66>
 2b9:	8d 76 00             	lea    0x0(%esi),%esi

000002bc <thread_create>:
thread_create(void (*start_routine)(void*), void *arg){
 2bc:	55                   	push   %ebp
 2bd:	89 e5                	mov    %esp,%ebp
 2bf:	53                   	push   %ebx
 2c0:	83 ec 14             	sub    $0x14,%esp
    void *stack = malloc(PGSIZE);
 2c3:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 2ca:	e8 fd 05 00 00       	call   8cc <malloc>
    for(i = 0;i<t;i++){
 2cf:	8b 0d ac 0d 00 00    	mov    0xdac,%ecx
 2d5:	85 c9                	test   %ecx,%ecx
 2d7:	7e 1e                	jle    2f7 <thread_create+0x3b>
 2d9:	31 d2                	xor    %edx,%edx
 2db:	90                   	nop
        fr[i].hasFrisbee = 0;
 2dc:	c7 04 d5 e4 0d 00 00 	movl   $0x0,0xde4(,%edx,8)
 2e3:	00 00 00 00 
        fr[i].pid = 0;
 2e7:	c7 04 d5 e0 0d 00 00 	movl   $0x0,0xde0(,%edx,8)
 2ee:	00 00 00 00 
    for(i = 0;i<t;i++){
 2f2:	42                   	inc    %edx
 2f3:	39 ca                	cmp    %ecx,%edx
 2f5:	75 e5                	jne    2dc <thread_create+0x20>
    fr[t/2].hasFrisbee = 1;
 2f7:	89 ca                	mov    %ecx,%edx
 2f9:	c1 ea 1f             	shr    $0x1f,%edx
 2fc:	01 d1                	add    %edx,%ecx
 2fe:	d1 f9                	sar    %ecx
 300:	c7 04 cd e4 0d 00 00 	movl   $0x1,0xde4(,%ecx,8)
 307:	01 00 00 00 
    rc = clone1(stack, PGSIZE);
 30b:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
 312:	00 
 313:	89 04 24             	mov    %eax,(%esp)
 316:	e8 dc 02 00 00       	call   5f7 <clone1>
    if(rc == 0)
 31b:	85 c0                	test   %eax,%eax
 31d:	74 06                	je     325 <thread_create+0x69>
}
 31f:	83 c4 14             	add    $0x14,%esp
 322:	5b                   	pop    %ebx
 323:	5d                   	pop    %ebp
 324:	c3                   	ret    
        fr[itt].pid = getpid();
 325:	8b 1d a0 0d 00 00    	mov    0xda0,%ebx
 32b:	e8 67 02 00 00       	call   597 <getpid>
 330:	89 04 dd e0 0d 00 00 	mov    %eax,0xde0(,%ebx,8)
        itt++;
 337:	ff 05 a0 0d 00 00    	incl   0xda0
        start_routine(arg);
 33d:	8b 45 0c             	mov    0xc(%ebp),%eax
 340:	89 04 24             	mov    %eax,(%esp)
 343:	ff 55 08             	call   *0x8(%ebp)
        exit();
 346:	e8 cc 01 00 00       	call   517 <exit>
 34b:	90                   	nop

0000034c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 34c:	55                   	push   %ebp
 34d:	89 e5                	mov    %esp,%ebp
 34f:	53                   	push   %ebx
 350:	8b 45 08             	mov    0x8(%ebp),%eax
 353:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 356:	89 c2                	mov    %eax,%edx
 358:	8a 19                	mov    (%ecx),%bl
 35a:	88 1a                	mov    %bl,(%edx)
 35c:	42                   	inc    %edx
 35d:	41                   	inc    %ecx
 35e:	84 db                	test   %bl,%bl
 360:	75 f6                	jne    358 <strcpy+0xc>
    ;
  return os;
}
 362:	5b                   	pop    %ebx
 363:	5d                   	pop    %ebp
 364:	c3                   	ret    
 365:	8d 76 00             	lea    0x0(%esi),%esi

00000368 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 368:	55                   	push   %ebp
 369:	89 e5                	mov    %esp,%ebp
 36b:	56                   	push   %esi
 36c:	53                   	push   %ebx
 36d:	8b 55 08             	mov    0x8(%ebp),%edx
 370:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 373:	0f b6 02             	movzbl (%edx),%eax
 376:	0f b6 19             	movzbl (%ecx),%ebx
 379:	84 c0                	test   %al,%al
 37b:	75 14                	jne    391 <strcmp+0x29>
 37d:	eb 1d                	jmp    39c <strcmp+0x34>
 37f:	90                   	nop
    p++, q++;
 380:	42                   	inc    %edx
 381:	8d 71 01             	lea    0x1(%ecx),%esi
  while(*p && *p == *q)
 384:	0f b6 02             	movzbl (%edx),%eax
 387:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 38b:	84 c0                	test   %al,%al
 38d:	74 0d                	je     39c <strcmp+0x34>
    p++, q++;
 38f:	89 f1                	mov    %esi,%ecx
  while(*p && *p == *q)
 391:	38 d8                	cmp    %bl,%al
 393:	74 eb                	je     380 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 395:	29 d8                	sub    %ebx,%eax
}
 397:	5b                   	pop    %ebx
 398:	5e                   	pop    %esi
 399:	5d                   	pop    %ebp
 39a:	c3                   	ret    
 39b:	90                   	nop
  while(*p && *p == *q)
 39c:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 39e:	29 d8                	sub    %ebx,%eax
}
 3a0:	5b                   	pop    %ebx
 3a1:	5e                   	pop    %esi
 3a2:	5d                   	pop    %ebp
 3a3:	c3                   	ret    

000003a4 <strlen>:

uint
strlen(char *s)
{
 3a4:	55                   	push   %ebp
 3a5:	89 e5                	mov    %esp,%ebp
 3a7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 3aa:	80 39 00             	cmpb   $0x0,(%ecx)
 3ad:	74 10                	je     3bf <strlen+0x1b>
 3af:	31 d2                	xor    %edx,%edx
 3b1:	8d 76 00             	lea    0x0(%esi),%esi
 3b4:	42                   	inc    %edx
 3b5:	89 d0                	mov    %edx,%eax
 3b7:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 3bb:	75 f7                	jne    3b4 <strlen+0x10>
    ;
  return n;
}
 3bd:	5d                   	pop    %ebp
 3be:	c3                   	ret    
  for(n = 0; s[n]; n++)
 3bf:	31 c0                	xor    %eax,%eax
}
 3c1:	5d                   	pop    %ebp
 3c2:	c3                   	ret    
 3c3:	90                   	nop

000003c4 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3c4:	55                   	push   %ebp
 3c5:	89 e5                	mov    %esp,%ebp
 3c7:	57                   	push   %edi
 3c8:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 3cb:	89 d7                	mov    %edx,%edi
 3cd:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3d0:	8b 45 0c             	mov    0xc(%ebp),%eax
 3d3:	fc                   	cld    
 3d4:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 3d6:	89 d0                	mov    %edx,%eax
 3d8:	5f                   	pop    %edi
 3d9:	5d                   	pop    %ebp
 3da:	c3                   	ret    
 3db:	90                   	nop

000003dc <strchr>:

char*
strchr(const char *s, char c)
{
 3dc:	55                   	push   %ebp
 3dd:	89 e5                	mov    %esp,%ebp
 3df:	8b 45 08             	mov    0x8(%ebp),%eax
 3e2:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
 3e5:	8a 10                	mov    (%eax),%dl
 3e7:	84 d2                	test   %dl,%dl
 3e9:	75 0c                	jne    3f7 <strchr+0x1b>
 3eb:	eb 13                	jmp    400 <strchr+0x24>
 3ed:	8d 76 00             	lea    0x0(%esi),%esi
 3f0:	40                   	inc    %eax
 3f1:	8a 10                	mov    (%eax),%dl
 3f3:	84 d2                	test   %dl,%dl
 3f5:	74 09                	je     400 <strchr+0x24>
    if(*s == c)
 3f7:	38 ca                	cmp    %cl,%dl
 3f9:	75 f5                	jne    3f0 <strchr+0x14>
      return (char*)s;
  return 0;
}
 3fb:	5d                   	pop    %ebp
 3fc:	c3                   	ret    
 3fd:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
 400:	31 c0                	xor    %eax,%eax
}
 402:	5d                   	pop    %ebp
 403:	c3                   	ret    

00000404 <gets>:

char*
gets(char *buf, int max)
{
 404:	55                   	push   %ebp
 405:	89 e5                	mov    %esp,%ebp
 407:	57                   	push   %edi
 408:	56                   	push   %esi
 409:	53                   	push   %ebx
 40a:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 40d:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
 40f:	8d 7d e7             	lea    -0x19(%ebp),%edi
 412:	66 90                	xchg   %ax,%ax
  for(i=0; i+1 < max; ){
 414:	8d 73 01             	lea    0x1(%ebx),%esi
 417:	3b 75 0c             	cmp    0xc(%ebp),%esi
 41a:	7d 40                	jge    45c <gets+0x58>
    cc = read(0, &c, 1);
 41c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 423:	00 
 424:	89 7c 24 04          	mov    %edi,0x4(%esp)
 428:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 42f:	e8 fb 00 00 00       	call   52f <read>
    if(cc < 1)
 434:	85 c0                	test   %eax,%eax
 436:	7e 24                	jle    45c <gets+0x58>
      break;
    buf[i++] = c;
 438:	8a 45 e7             	mov    -0x19(%ebp),%al
 43b:	8b 55 08             	mov    0x8(%ebp),%edx
 43e:	88 44 32 ff          	mov    %al,-0x1(%edx,%esi,1)
    if(c == '\n' || c == '\r')
 442:	3c 0a                	cmp    $0xa,%al
 444:	74 06                	je     44c <gets+0x48>
 446:	89 f3                	mov    %esi,%ebx
 448:	3c 0d                	cmp    $0xd,%al
 44a:	75 c8                	jne    414 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 44c:	8b 45 08             	mov    0x8(%ebp),%eax
 44f:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 453:	83 c4 2c             	add    $0x2c,%esp
 456:	5b                   	pop    %ebx
 457:	5e                   	pop    %esi
 458:	5f                   	pop    %edi
 459:	5d                   	pop    %ebp
 45a:	c3                   	ret    
 45b:	90                   	nop
    if(cc < 1)
 45c:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 45e:	8b 45 08             	mov    0x8(%ebp),%eax
 461:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 465:	83 c4 2c             	add    $0x2c,%esp
 468:	5b                   	pop    %ebx
 469:	5e                   	pop    %esi
 46a:	5f                   	pop    %edi
 46b:	5d                   	pop    %ebp
 46c:	c3                   	ret    
 46d:	8d 76 00             	lea    0x0(%esi),%esi

00000470 <stat>:

int
stat(char *n, struct stat *st)
{
 470:	55                   	push   %ebp
 471:	89 e5                	mov    %esp,%ebp
 473:	56                   	push   %esi
 474:	53                   	push   %ebx
 475:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 478:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 47f:	00 
 480:	8b 45 08             	mov    0x8(%ebp),%eax
 483:	89 04 24             	mov    %eax,(%esp)
 486:	e8 cc 00 00 00       	call   557 <open>
 48b:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 48d:	85 c0                	test   %eax,%eax
 48f:	78 23                	js     4b4 <stat+0x44>
    return -1;
  r = fstat(fd, st);
 491:	8b 45 0c             	mov    0xc(%ebp),%eax
 494:	89 44 24 04          	mov    %eax,0x4(%esp)
 498:	89 1c 24             	mov    %ebx,(%esp)
 49b:	e8 cf 00 00 00       	call   56f <fstat>
 4a0:	89 c6                	mov    %eax,%esi
  close(fd);
 4a2:	89 1c 24             	mov    %ebx,(%esp)
 4a5:	e8 95 00 00 00       	call   53f <close>
  return r;
}
 4aa:	89 f0                	mov    %esi,%eax
 4ac:	83 c4 10             	add    $0x10,%esp
 4af:	5b                   	pop    %ebx
 4b0:	5e                   	pop    %esi
 4b1:	5d                   	pop    %ebp
 4b2:	c3                   	ret    
 4b3:	90                   	nop
    return -1;
 4b4:	be ff ff ff ff       	mov    $0xffffffff,%esi
 4b9:	eb ef                	jmp    4aa <stat+0x3a>
 4bb:	90                   	nop

000004bc <atoi>:

int
atoi(const char *s)
{
 4bc:	55                   	push   %ebp
 4bd:	89 e5                	mov    %esp,%ebp
 4bf:	53                   	push   %ebx
 4c0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4c3:	0f be 11             	movsbl (%ecx),%edx
 4c6:	8d 42 d0             	lea    -0x30(%edx),%eax
 4c9:	3c 09                	cmp    $0x9,%al
 4cb:	b8 00 00 00 00       	mov    $0x0,%eax
 4d0:	77 15                	ja     4e7 <atoi+0x2b>
 4d2:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 4d4:	8d 04 80             	lea    (%eax,%eax,4),%eax
 4d7:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
 4db:	41                   	inc    %ecx
  while('0' <= *s && *s <= '9')
 4dc:	0f be 11             	movsbl (%ecx),%edx
 4df:	8d 5a d0             	lea    -0x30(%edx),%ebx
 4e2:	80 fb 09             	cmp    $0x9,%bl
 4e5:	76 ed                	jbe    4d4 <atoi+0x18>
  return n;
}
 4e7:	5b                   	pop    %ebx
 4e8:	5d                   	pop    %ebp
 4e9:	c3                   	ret    
 4ea:	66 90                	xchg   %ax,%ax

000004ec <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 4ec:	55                   	push   %ebp
 4ed:	89 e5                	mov    %esp,%ebp
 4ef:	56                   	push   %esi
 4f0:	53                   	push   %ebx
 4f1:	8b 45 08             	mov    0x8(%ebp),%eax
 4f4:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 4f7:	8b 75 10             	mov    0x10(%ebp),%esi
memmove(void *vdst, void *vsrc, int n)
 4fa:	31 d2                	xor    %edx,%edx
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4fc:	85 f6                	test   %esi,%esi
 4fe:	7e 0b                	jle    50b <memmove+0x1f>
    *dst++ = *src++;
 500:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 503:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 506:	42                   	inc    %edx
  while(n-- > 0)
 507:	39 f2                	cmp    %esi,%edx
 509:	75 f5                	jne    500 <memmove+0x14>
  return vdst;
}
 50b:	5b                   	pop    %ebx
 50c:	5e                   	pop    %esi
 50d:	5d                   	pop    %ebp
 50e:	c3                   	ret    

0000050f <fork>:
 50f:	b8 01 00 00 00       	mov    $0x1,%eax
 514:	cd 40                	int    $0x40
 516:	c3                   	ret    

00000517 <exit>:
 517:	b8 02 00 00 00       	mov    $0x2,%eax
 51c:	cd 40                	int    $0x40
 51e:	c3                   	ret    

0000051f <wait>:
 51f:	b8 03 00 00 00       	mov    $0x3,%eax
 524:	cd 40                	int    $0x40
 526:	c3                   	ret    

00000527 <pipe>:
 527:	b8 04 00 00 00       	mov    $0x4,%eax
 52c:	cd 40                	int    $0x40
 52e:	c3                   	ret    

0000052f <read>:
 52f:	b8 05 00 00 00       	mov    $0x5,%eax
 534:	cd 40                	int    $0x40
 536:	c3                   	ret    

00000537 <write>:
 537:	b8 10 00 00 00       	mov    $0x10,%eax
 53c:	cd 40                	int    $0x40
 53e:	c3                   	ret    

0000053f <close>:
 53f:	b8 15 00 00 00       	mov    $0x15,%eax
 544:	cd 40                	int    $0x40
 546:	c3                   	ret    

00000547 <kill>:
 547:	b8 06 00 00 00       	mov    $0x6,%eax
 54c:	cd 40                	int    $0x40
 54e:	c3                   	ret    

0000054f <exec>:
 54f:	b8 07 00 00 00       	mov    $0x7,%eax
 554:	cd 40                	int    $0x40
 556:	c3                   	ret    

00000557 <open>:
 557:	b8 0f 00 00 00       	mov    $0xf,%eax
 55c:	cd 40                	int    $0x40
 55e:	c3                   	ret    

0000055f <mknod>:
 55f:	b8 11 00 00 00       	mov    $0x11,%eax
 564:	cd 40                	int    $0x40
 566:	c3                   	ret    

00000567 <unlink>:
 567:	b8 12 00 00 00       	mov    $0x12,%eax
 56c:	cd 40                	int    $0x40
 56e:	c3                   	ret    

0000056f <fstat>:
 56f:	b8 08 00 00 00       	mov    $0x8,%eax
 574:	cd 40                	int    $0x40
 576:	c3                   	ret    

00000577 <link>:
 577:	b8 13 00 00 00       	mov    $0x13,%eax
 57c:	cd 40                	int    $0x40
 57e:	c3                   	ret    

0000057f <mkdir>:
 57f:	b8 14 00 00 00       	mov    $0x14,%eax
 584:	cd 40                	int    $0x40
 586:	c3                   	ret    

00000587 <chdir>:
 587:	b8 09 00 00 00       	mov    $0x9,%eax
 58c:	cd 40                	int    $0x40
 58e:	c3                   	ret    

0000058f <dup>:
 58f:	b8 0a 00 00 00       	mov    $0xa,%eax
 594:	cd 40                	int    $0x40
 596:	c3                   	ret    

00000597 <getpid>:
 597:	b8 0b 00 00 00       	mov    $0xb,%eax
 59c:	cd 40                	int    $0x40
 59e:	c3                   	ret    

0000059f <sbrk>:
 59f:	b8 0c 00 00 00       	mov    $0xc,%eax
 5a4:	cd 40                	int    $0x40
 5a6:	c3                   	ret    

000005a7 <sleep>:
 5a7:	b8 0d 00 00 00       	mov    $0xd,%eax
 5ac:	cd 40                	int    $0x40
 5ae:	c3                   	ret    

000005af <uptime>:
 5af:	b8 0e 00 00 00       	mov    $0xe,%eax
 5b4:	cd 40                	int    $0x40
 5b6:	c3                   	ret    

000005b7 <getprocnum>:
 5b7:	b8 16 00 00 00       	mov    $0x16,%eax
 5bc:	cd 40                	int    $0x40
 5be:	c3                   	ret    

000005bf <mempagenum>:
 5bf:	b8 17 00 00 00       	mov    $0x17,%eax
 5c4:	cd 40                	int    $0x40
 5c6:	c3                   	ret    

000005c7 <syscallnum>:
 5c7:	b8 18 00 00 00       	mov    $0x18,%eax
 5cc:	cd 40                	int    $0x40
 5ce:	c3                   	ret    

000005cf <settickets>:
 5cf:	b8 19 00 00 00       	mov    $0x19,%eax
 5d4:	cd 40                	int    $0x40
 5d6:	c3                   	ret    

000005d7 <getsheltime>:
 5d7:	b8 1a 00 00 00       	mov    $0x1a,%eax
 5dc:	cd 40                	int    $0x40
 5de:	c3                   	ret    

000005df <setstride>:
 5df:	b8 1b 00 00 00       	mov    $0x1b,%eax
 5e4:	cd 40                	int    $0x40
 5e6:	c3                   	ret    

000005e7 <setpass>:
 5e7:	b8 1c 00 00 00       	mov    $0x1c,%eax
 5ec:	cd 40                	int    $0x40
 5ee:	c3                   	ret    

000005ef <join>:
 5ef:	b8 1d 00 00 00       	mov    $0x1d,%eax
 5f4:	cd 40                	int    $0x40
 5f6:	c3                   	ret    

000005f7 <clone1>:
 5f7:	b8 1e 00 00 00       	mov    $0x1e,%eax
 5fc:	cd 40                	int    $0x40
 5fe:	c3                   	ret    
 5ff:	90                   	nop

00000600 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 600:	55                   	push   %ebp
 601:	89 e5                	mov    %esp,%ebp
 603:	57                   	push   %edi
 604:	56                   	push   %esi
 605:	53                   	push   %ebx
 606:	83 ec 3c             	sub    $0x3c,%esp
 609:	89 c7                	mov    %eax,%edi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 60b:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 60d:	8b 5d 08             	mov    0x8(%ebp),%ebx
 610:	85 db                	test   %ebx,%ebx
 612:	74 04                	je     618 <printint+0x18>
 614:	85 d2                	test   %edx,%edx
 616:	78 5d                	js     675 <printint+0x75>
  neg = 0;
 618:	31 db                	xor    %ebx,%ebx
  } else {
    x = xx;
  }

  i = 0;
 61a:	31 f6                	xor    %esi,%esi
 61c:	eb 04                	jmp    622 <printint+0x22>
 61e:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 620:	89 d6                	mov    %edx,%esi
 622:	31 d2                	xor    %edx,%edx
 624:	f7 f1                	div    %ecx
 626:	8a 92 ef 09 00 00    	mov    0x9ef(%edx),%dl
 62c:	88 54 35 d8          	mov    %dl,-0x28(%ebp,%esi,1)
 630:	8d 56 01             	lea    0x1(%esi),%edx
  }while((x /= base) != 0);
 633:	85 c0                	test   %eax,%eax
 635:	75 e9                	jne    620 <printint+0x20>
  if(neg)
 637:	85 db                	test   %ebx,%ebx
 639:	74 08                	je     643 <printint+0x43>
    buf[i++] = '-';
 63b:	c6 44 15 d8 2d       	movb   $0x2d,-0x28(%ebp,%edx,1)
 640:	8d 56 02             	lea    0x2(%esi),%edx

  while(--i >= 0)
 643:	8d 5a ff             	lea    -0x1(%edx),%ebx
 646:	8d 75 d7             	lea    -0x29(%ebp),%esi
 649:	8d 76 00             	lea    0x0(%esi),%esi
 64c:	8a 44 1d d8          	mov    -0x28(%ebp,%ebx,1),%al
 650:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 653:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 65a:	00 
 65b:	89 74 24 04          	mov    %esi,0x4(%esp)
 65f:	89 3c 24             	mov    %edi,(%esp)
 662:	e8 d0 fe ff ff       	call   537 <write>
  while(--i >= 0)
 667:	4b                   	dec    %ebx
 668:	83 fb ff             	cmp    $0xffffffff,%ebx
 66b:	75 df                	jne    64c <printint+0x4c>
    putc(fd, buf[i]);
}
 66d:	83 c4 3c             	add    $0x3c,%esp
 670:	5b                   	pop    %ebx
 671:	5e                   	pop    %esi
 672:	5f                   	pop    %edi
 673:	5d                   	pop    %ebp
 674:	c3                   	ret    
    x = -xx;
 675:	f7 d8                	neg    %eax
    neg = 1;
 677:	bb 01 00 00 00       	mov    $0x1,%ebx
    x = -xx;
 67c:	eb 9c                	jmp    61a <printint+0x1a>
 67e:	66 90                	xchg   %ax,%ax

00000680 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 680:	55                   	push   %ebp
 681:	89 e5                	mov    %esp,%ebp
 683:	57                   	push   %edi
 684:	56                   	push   %esi
 685:	53                   	push   %ebx
 686:	83 ec 3c             	sub    $0x3c,%esp
 689:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 68c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 68f:	8a 03                	mov    (%ebx),%al
 691:	84 c0                	test   %al,%al
 693:	0f 84 bb 00 00 00    	je     754 <printf+0xd4>
printf(int fd, char *fmt, ...)
 699:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
 69a:	8d 55 10             	lea    0x10(%ebp),%edx
 69d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  state = 0;
 6a0:	31 ff                	xor    %edi,%edi
 6a2:	eb 2f                	jmp    6d3 <printf+0x53>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 6a4:	83 f9 25             	cmp    $0x25,%ecx
 6a7:	0f 84 af 00 00 00    	je     75c <printf+0xdc>
        state = '%';
      } else {
        putc(fd, c);
 6ad:	88 4d e2             	mov    %cl,-0x1e(%ebp)
  write(fd, &c, 1);
 6b0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6b7:	00 
 6b8:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 6bb:	89 44 24 04          	mov    %eax,0x4(%esp)
 6bf:	89 34 24             	mov    %esi,(%esp)
 6c2:	e8 70 fe ff ff       	call   537 <write>
 6c7:	43                   	inc    %ebx
  for(i = 0; fmt[i]; i++){
 6c8:	8a 43 ff             	mov    -0x1(%ebx),%al
 6cb:	84 c0                	test   %al,%al
 6cd:	0f 84 81 00 00 00    	je     754 <printf+0xd4>
    c = fmt[i] & 0xff;
 6d3:	0f b6 c8             	movzbl %al,%ecx
    if(state == 0){
 6d6:	85 ff                	test   %edi,%edi
 6d8:	74 ca                	je     6a4 <printf+0x24>
      }
    } else if(state == '%'){
 6da:	83 ff 25             	cmp    $0x25,%edi
 6dd:	75 e8                	jne    6c7 <printf+0x47>
      if(c == 'd'){
 6df:	83 f9 64             	cmp    $0x64,%ecx
 6e2:	0f 84 14 01 00 00    	je     7fc <printf+0x17c>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 6e8:	83 f9 78             	cmp    $0x78,%ecx
 6eb:	74 7b                	je     768 <printf+0xe8>
 6ed:	83 f9 70             	cmp    $0x70,%ecx
 6f0:	74 76                	je     768 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 6f2:	83 f9 73             	cmp    $0x73,%ecx
 6f5:	0f 84 91 00 00 00    	je     78c <printf+0x10c>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6fb:	83 f9 63             	cmp    $0x63,%ecx
 6fe:	0f 84 cc 00 00 00    	je     7d0 <printf+0x150>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 704:	83 f9 25             	cmp    $0x25,%ecx
 707:	0f 84 13 01 00 00    	je     820 <printf+0x1a0>
 70d:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
  write(fd, &c, 1);
 711:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 718:	00 
 719:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 71c:	89 44 24 04          	mov    %eax,0x4(%esp)
 720:	89 34 24             	mov    %esi,(%esp)
 723:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 726:	e8 0c fe ff ff       	call   537 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 72b:	8b 4d d0             	mov    -0x30(%ebp),%ecx
 72e:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
 731:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 738:	00 
 739:	8d 55 e7             	lea    -0x19(%ebp),%edx
 73c:	89 54 24 04          	mov    %edx,0x4(%esp)
 740:	89 34 24             	mov    %esi,(%esp)
 743:	e8 ef fd ff ff       	call   537 <write>
      }
      state = 0;
 748:	31 ff                	xor    %edi,%edi
 74a:	43                   	inc    %ebx
  for(i = 0; fmt[i]; i++){
 74b:	8a 43 ff             	mov    -0x1(%ebx),%al
 74e:	84 c0                	test   %al,%al
 750:	75 81                	jne    6d3 <printf+0x53>
 752:	66 90                	xchg   %ax,%ax
    }
  }
}
 754:	83 c4 3c             	add    $0x3c,%esp
 757:	5b                   	pop    %ebx
 758:	5e                   	pop    %esi
 759:	5f                   	pop    %edi
 75a:	5d                   	pop    %ebp
 75b:	c3                   	ret    
        state = '%';
 75c:	bf 25 00 00 00       	mov    $0x25,%edi
 761:	e9 61 ff ff ff       	jmp    6c7 <printf+0x47>
 766:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 768:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 76f:	b9 10 00 00 00       	mov    $0x10,%ecx
 774:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 777:	8b 10                	mov    (%eax),%edx
 779:	89 f0                	mov    %esi,%eax
 77b:	e8 80 fe ff ff       	call   600 <printint>
        ap++;
 780:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 784:	31 ff                	xor    %edi,%edi
        ap++;
 786:	e9 3c ff ff ff       	jmp    6c7 <printf+0x47>
 78b:	90                   	nop
        s = (char*)*ap;
 78c:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 78f:	8b 3a                	mov    (%edx),%edi
        ap++;
 791:	83 c2 04             	add    $0x4,%edx
 794:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
 797:	85 ff                	test   %edi,%edi
 799:	0f 84 a3 00 00 00    	je     842 <printf+0x1c2>
        while(*s != 0){
 79f:	8a 07                	mov    (%edi),%al
 7a1:	84 c0                	test   %al,%al
 7a3:	74 24                	je     7c9 <printf+0x149>
 7a5:	8d 76 00             	lea    0x0(%esi),%esi
 7a8:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 7ab:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 7b2:	00 
 7b3:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 7b6:	89 44 24 04          	mov    %eax,0x4(%esp)
 7ba:	89 34 24             	mov    %esi,(%esp)
 7bd:	e8 75 fd ff ff       	call   537 <write>
          s++;
 7c2:	47                   	inc    %edi
        while(*s != 0){
 7c3:	8a 07                	mov    (%edi),%al
 7c5:	84 c0                	test   %al,%al
 7c7:	75 df                	jne    7a8 <printf+0x128>
      state = 0;
 7c9:	31 ff                	xor    %edi,%edi
 7cb:	e9 f7 fe ff ff       	jmp    6c7 <printf+0x47>
        putc(fd, *ap);
 7d0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 7d3:	8b 02                	mov    (%edx),%eax
 7d5:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 7d8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 7df:	00 
 7e0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 7e3:	89 44 24 04          	mov    %eax,0x4(%esp)
 7e7:	89 34 24             	mov    %esi,(%esp)
 7ea:	e8 48 fd ff ff       	call   537 <write>
        ap++;
 7ef:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 7f3:	31 ff                	xor    %edi,%edi
 7f5:	e9 cd fe ff ff       	jmp    6c7 <printf+0x47>
 7fa:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 7fc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 803:	b1 0a                	mov    $0xa,%cl
 805:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 808:	8b 10                	mov    (%eax),%edx
 80a:	89 f0                	mov    %esi,%eax
 80c:	e8 ef fd ff ff       	call   600 <printint>
        ap++;
 811:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 815:	66 31 ff             	xor    %di,%di
 818:	e9 aa fe ff ff       	jmp    6c7 <printf+0x47>
 81d:	8d 76 00             	lea    0x0(%esi),%esi
 820:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
  write(fd, &c, 1);
 824:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 82b:	00 
 82c:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 82f:	89 44 24 04          	mov    %eax,0x4(%esp)
 833:	89 34 24             	mov    %esi,(%esp)
 836:	e8 fc fc ff ff       	call   537 <write>
      state = 0;
 83b:	31 ff                	xor    %edi,%edi
 83d:	e9 85 fe ff ff       	jmp    6c7 <printf+0x47>
          s = "(null)";
 842:	bf e8 09 00 00       	mov    $0x9e8,%edi
 847:	e9 53 ff ff ff       	jmp    79f <printf+0x11f>

0000084c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 84c:	55                   	push   %ebp
 84d:	89 e5                	mov    %esp,%ebp
 84f:	57                   	push   %edi
 850:	56                   	push   %esi
 851:	53                   	push   %ebx
 852:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 855:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 858:	a1 b4 0d 00 00       	mov    0xdb4,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 85d:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 85f:	39 d0                	cmp    %edx,%eax
 861:	72 11                	jb     874 <free+0x28>
 863:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 864:	39 c8                	cmp    %ecx,%eax
 866:	72 04                	jb     86c <free+0x20>
 868:	39 ca                	cmp    %ecx,%edx
 86a:	72 10                	jb     87c <free+0x30>
 86c:	89 c8                	mov    %ecx,%eax
 86e:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 870:	39 d0                	cmp    %edx,%eax
 872:	73 f0                	jae    864 <free+0x18>
 874:	39 ca                	cmp    %ecx,%edx
 876:	72 04                	jb     87c <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 878:	39 c8                	cmp    %ecx,%eax
 87a:	72 f0                	jb     86c <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 87c:	8b 73 fc             	mov    -0x4(%ebx),%esi
 87f:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 882:	39 cf                	cmp    %ecx,%edi
 884:	74 1a                	je     8a0 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 886:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 889:	8b 48 04             	mov    0x4(%eax),%ecx
 88c:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 88f:	39 f2                	cmp    %esi,%edx
 891:	74 24                	je     8b7 <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 893:	89 10                	mov    %edx,(%eax)
  freep = p;
 895:	a3 b4 0d 00 00       	mov    %eax,0xdb4
}
 89a:	5b                   	pop    %ebx
 89b:	5e                   	pop    %esi
 89c:	5f                   	pop    %edi
 89d:	5d                   	pop    %ebp
 89e:	c3                   	ret    
 89f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 8a0:	03 71 04             	add    0x4(%ecx),%esi
 8a3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 8a6:	8b 08                	mov    (%eax),%ecx
 8a8:	8b 09                	mov    (%ecx),%ecx
 8aa:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 8ad:	8b 48 04             	mov    0x4(%eax),%ecx
 8b0:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 8b3:	39 f2                	cmp    %esi,%edx
 8b5:	75 dc                	jne    893 <free+0x47>
    p->s.size += bp->s.size;
 8b7:	03 4b fc             	add    -0x4(%ebx),%ecx
 8ba:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 8bd:	8b 53 f8             	mov    -0x8(%ebx),%edx
 8c0:	89 10                	mov    %edx,(%eax)
  freep = p;
 8c2:	a3 b4 0d 00 00       	mov    %eax,0xdb4
}
 8c7:	5b                   	pop    %ebx
 8c8:	5e                   	pop    %esi
 8c9:	5f                   	pop    %edi
 8ca:	5d                   	pop    %ebp
 8cb:	c3                   	ret    

000008cc <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8cc:	55                   	push   %ebp
 8cd:	89 e5                	mov    %esp,%ebp
 8cf:	57                   	push   %edi
 8d0:	56                   	push   %esi
 8d1:	53                   	push   %ebx
 8d2:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8d5:	8b 75 08             	mov    0x8(%ebp),%esi
 8d8:	83 c6 07             	add    $0x7,%esi
 8db:	c1 ee 03             	shr    $0x3,%esi
 8de:	46                   	inc    %esi
  if((prevp = freep) == 0){
 8df:	8b 15 b4 0d 00 00    	mov    0xdb4,%edx
 8e5:	85 d2                	test   %edx,%edx
 8e7:	0f 84 8d 00 00 00    	je     97a <malloc+0xae>
 8ed:	8b 02                	mov    (%edx),%eax
 8ef:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 8f2:	39 ce                	cmp    %ecx,%esi
 8f4:	76 52                	jbe    948 <malloc+0x7c>
 8f6:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 8fd:	eb 0a                	jmp    909 <malloc+0x3d>
 8ff:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 900:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 902:	8b 48 04             	mov    0x4(%eax),%ecx
 905:	39 ce                	cmp    %ecx,%esi
 907:	76 3f                	jbe    948 <malloc+0x7c>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 909:	89 c2                	mov    %eax,%edx
 90b:	3b 05 b4 0d 00 00    	cmp    0xdb4,%eax
 911:	75 ed                	jne    900 <malloc+0x34>
  if(nu < 4096)
 913:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 919:	76 4d                	jbe    968 <malloc+0x9c>
 91b:	89 d8                	mov    %ebx,%eax
 91d:	89 f7                	mov    %esi,%edi
  p = sbrk(nu * sizeof(Header));
 91f:	89 04 24             	mov    %eax,(%esp)
 922:	e8 78 fc ff ff       	call   59f <sbrk>
  if(p == (char*)-1)
 927:	83 f8 ff             	cmp    $0xffffffff,%eax
 92a:	74 18                	je     944 <malloc+0x78>
  hp->s.size = nu;
 92c:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 92f:	83 c0 08             	add    $0x8,%eax
 932:	89 04 24             	mov    %eax,(%esp)
 935:	e8 12 ff ff ff       	call   84c <free>
  return freep;
 93a:	8b 15 b4 0d 00 00    	mov    0xdb4,%edx
      if((p = morecore(nunits)) == 0)
 940:	85 d2                	test   %edx,%edx
 942:	75 bc                	jne    900 <malloc+0x34>
        return 0;
 944:	31 c0                	xor    %eax,%eax
 946:	eb 18                	jmp    960 <malloc+0x94>
      if(p->s.size == nunits)
 948:	39 ce                	cmp    %ecx,%esi
 94a:	74 28                	je     974 <malloc+0xa8>
        p->s.size -= nunits;
 94c:	29 f1                	sub    %esi,%ecx
 94e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 951:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 954:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 957:	89 15 b4 0d 00 00    	mov    %edx,0xdb4
      return (void*)(p + 1);
 95d:	83 c0 08             	add    $0x8,%eax
  }
}
 960:	83 c4 1c             	add    $0x1c,%esp
 963:	5b                   	pop    %ebx
 964:	5e                   	pop    %esi
 965:	5f                   	pop    %edi
 966:	5d                   	pop    %ebp
 967:	c3                   	ret    
  if(nu < 4096)
 968:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 96d:	bf 00 10 00 00       	mov    $0x1000,%edi
 972:	eb ab                	jmp    91f <malloc+0x53>
        prevp->s.ptr = p->s.ptr;
 974:	8b 08                	mov    (%eax),%ecx
 976:	89 0a                	mov    %ecx,(%edx)
 978:	eb dd                	jmp    957 <malloc+0x8b>
    base.s.ptr = freep = prevp = &base;
 97a:	c7 05 b4 0d 00 00 b8 	movl   $0xdb8,0xdb4
 981:	0d 00 00 
 984:	c7 05 b8 0d 00 00 b8 	movl   $0xdb8,0xdb8
 98b:	0d 00 00 
    base.s.size = 0;
 98e:	c7 05 bc 0d 00 00 00 	movl   $0x0,0xdbc
 995:	00 00 00 
 998:	b8 b8 0d 00 00       	mov    $0xdb8,%eax
 99d:	e9 54 ff ff ff       	jmp    8f6 <malloc+0x2a>
