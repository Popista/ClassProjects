
_threadtest：     文件格式 elf32-i386


Disassembly of section .text:

00000000 <main>:
    return 0;
}

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	83 ec 30             	sub    $0x30,%esp
    if(argc != 3)
   a:	83 7d 08 03          	cmpl   $0x3,0x8(%ebp)
   e:	74 19                	je     29 <main+0x29>
    {
        printf(1, "Usage: threadtest numberOfThreads loopCount");
  10:	c7 44 24 04 4c 08 00 	movl   $0x84c,0x4(%esp)
  17:	00 
  18:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1f:	e8 f0 04 00 00       	call   514 <printf>
        exit();
  24:	e8 7a 03 00 00       	call   3a3 <exit>
    }

    //int nThreads = atoi(argv[1]);
    int nLoops =  5;
  29:	c7 44 24 18 05 00 00 	movl   $0x5,0x18(%esp)
  30:	00 

    int count = 0;
  31:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
  38:	00 
    lk->locked = 0;
  39:	c7 44 24 20 00 00 00 	movl   $0x0,0x20(%esp)
  40:	00 
    struct lock_t lock;
    lock_init(&lock);

    counter_args args;
    args.nLoops = &nLoops;
  41:	8d 44 24 18          	lea    0x18(%esp),%eax
  45:	89 44 24 24          	mov    %eax,0x24(%esp)
    args.count = &count;
  49:	8d 44 24 1c          	lea    0x1c(%esp),%eax
  4d:	89 44 24 28          	mov    %eax,0x28(%esp)
    args.lock = &lock;
  51:	8d 44 24 20          	lea    0x20(%esp),%eax
  55:	89 44 24 2c          	mov    %eax,0x2c(%esp)
    void * a = (void*) &args;

    int i;
    for(i = 0; i < 2; i++)
    {
        printf(1,"333");
  59:	c7 44 24 04 38 08 00 	movl   $0x838,0x4(%esp)
  60:	00 
  61:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  68:	e8 a7 04 00 00       	call   514 <printf>
    void * a = (void*) &args;
  6d:	8d 5c 24 24          	lea    0x24(%esp),%ebx
  71:	89 5c 24 04          	mov    %ebx,0x4(%esp)
        thread_create(counter, a);
  75:	c7 04 24 d4 00 00 00 	movl   $0xd4,(%esp)
  7c:	e8 db 00 00 00       	call   15c <thread_create>
        printf(1,"333");
  81:	c7 44 24 04 38 08 00 	movl   $0x838,0x4(%esp)
  88:	00 
  89:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  90:	e8 7f 04 00 00       	call   514 <printf>
    void * a = (void*) &args;
  95:	89 5c 24 04          	mov    %ebx,0x4(%esp)
        thread_create(counter, a);
  99:	c7 04 24 d4 00 00 00 	movl   $0xd4,(%esp)
  a0:	e8 b7 00 00 00       	call   15c <thread_create>
    wait();
  a5:	e8 01 03 00 00       	call   3ab <wait>
  aa:	e8 fc 02 00 00       	call   3ab <wait>
    for(i = 0; i < 2; i++)
    {
        thread_join();
    }

    printf(1, "Result is: %d\n", *(args.count));
  af:	8b 44 24 28          	mov    0x28(%esp),%eax
  b3:	8b 00                	mov    (%eax),%eax
  b5:	89 44 24 08          	mov    %eax,0x8(%esp)
  b9:	c7 44 24 04 3c 08 00 	movl   $0x83c,0x4(%esp)
  c0:	00 
  c1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  c8:	e8 47 04 00 00       	call   514 <printf>
    exit();
  cd:	e8 d1 02 00 00       	call   3a3 <exit>
  d2:	66 90                	xchg   %ax,%ax

000000d4 <counter>:
{
  d4:	55                   	push   %ebp
  d5:	89 e5                	mov    %esp,%ebp
  d7:	57                   	push   %edi
  d8:	56                   	push   %esi
  d9:	53                   	push   %ebx
  da:	83 ec 2c             	sub    $0x2c,%esp
  dd:	8b 7d 08             	mov    0x8(%ebp),%edi
    printf(1,"%d\n",*args->nLoops);
  e0:	8b 07                	mov    (%edi),%eax
  e2:	8b 00                	mov    (%eax),%eax
  e4:	89 44 24 08          	mov    %eax,0x8(%esp)
  e8:	c7 44 24 04 47 08 00 	movl   $0x847,0x4(%esp)
  ef:	00 
  f0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  f7:	e8 18 04 00 00       	call   514 <printf>
    for(i = 0; i < *args->nLoops; i++)
  fc:	8b 07                	mov    (%edi),%eax
  fe:	31 c9                	xor    %ecx,%ecx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
 100:	be 01 00 00 00       	mov    $0x1,%esi
 105:	8b 00                	mov    (%eax),%eax
 107:	85 c0                	test   %eax,%eax
 109:	7e 47                	jle    152 <counter+0x7e>
 10b:	90                   	nop
        lock_acquire(args->lock);
 10c:	8b 57 08             	mov    0x8(%edi),%edx
 10f:	90                   	nop
 110:	89 f0                	mov    %esi,%eax
 112:	f0 87 02             	lock xchg %eax,(%edx)
 115:	89 c3                	mov    %eax,%ebx
    while(xchg(&lk->locked, 1) != 0)
 117:	85 c0                	test   %eax,%eax
 119:	75 f5                	jne    110 <counter+0x3c>
        printf(1,"%d\n", getpid());
 11b:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 11e:	e8 00 03 00 00       	call   423 <getpid>
 123:	89 44 24 08          	mov    %eax,0x8(%esp)
 127:	c7 44 24 04 47 08 00 	movl   $0x847,0x4(%esp)
 12e:	00 
 12f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 136:	e8 d9 03 00 00       	call   514 <printf>
        (*args->count)++;
 13b:	8b 47 04             	mov    0x4(%edi),%eax
 13e:	ff 00                	incl   (%eax)
    xchg(&lk->locked, 0);
 140:	8b 57 08             	mov    0x8(%edi),%edx
 143:	89 d8                	mov    %ebx,%eax
 145:	f0 87 02             	lock xchg %eax,(%edx)
    for(i = 0; i < *args->nLoops; i++)
 148:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
 14b:	41                   	inc    %ecx
 14c:	8b 07                	mov    (%edi),%eax
 14e:	39 08                	cmp    %ecx,(%eax)
 150:	7f ba                	jg     10c <counter+0x38>
}
 152:	31 c0                	xor    %eax,%eax
 154:	83 c4 2c             	add    $0x2c,%esp
 157:	5b                   	pop    %ebx
 158:	5e                   	pop    %esi
 159:	5f                   	pop    %edi
 15a:	5d                   	pop    %ebp
 15b:	c3                   	ret    

0000015c <thread_create>:
{
 15c:	55                   	push   %ebp
 15d:	89 e5                	mov    %esp,%ebp
 15f:	83 ec 18             	sub    $0x18,%esp
    void *nSp = malloc(4096);
 162:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 169:	e8 f2 05 00 00       	call   760 <malloc>
    rc = clone1(nSp, 4096);
 16e:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
 175:	00 
 176:	89 04 24             	mov    %eax,(%esp)
 179:	e8 0d 03 00 00       	call   48b <clone1>
    if(rc == 0)
 17e:	85 c0                	test   %eax,%eax
 180:	74 02                	je     184 <thread_create+0x28>
}
 182:	c9                   	leave  
 183:	c3                   	ret    
        (*start_routine)(arg);
 184:	8b 45 0c             	mov    0xc(%ebp),%eax
 187:	89 04 24             	mov    %eax,(%esp)
 18a:	ff 55 08             	call   *0x8(%ebp)
        exit();
 18d:	e8 11 02 00 00       	call   3a3 <exit>
 192:	66 90                	xchg   %ax,%ax

00000194 <thread_join>:
{
 194:	55                   	push   %ebp
 195:	89 e5                	mov    %esp,%ebp
}
 197:	5d                   	pop    %ebp
    wait();
 198:	e9 0e 02 00 00       	jmp    3ab <wait>
 19d:	8d 76 00             	lea    0x0(%esi),%esi

000001a0 <lock_init>:
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
    lk->locked = 0;
 1a3:	8b 45 08             	mov    0x8(%ebp),%eax
 1a6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
 1ac:	5d                   	pop    %ebp
 1ad:	c3                   	ret    
 1ae:	66 90                	xchg   %ax,%ax

000001b0 <lock_acquire>:
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	8b 55 08             	mov    0x8(%ebp),%edx
 1b6:	b9 01 00 00 00       	mov    $0x1,%ecx
 1bb:	90                   	nop
 1bc:	89 c8                	mov    %ecx,%eax
 1be:	f0 87 02             	lock xchg %eax,(%edx)
    while(xchg(&lk->locked, 1) != 0)
 1c1:	85 c0                	test   %eax,%eax
 1c3:	75 f7                	jne    1bc <lock_acquire+0xc>
}
 1c5:	5d                   	pop    %ebp
 1c6:	c3                   	ret    
 1c7:	90                   	nop

000001c8 <lock_release>:
{
 1c8:	55                   	push   %ebp
 1c9:	89 e5                	mov    %esp,%ebp
 1cb:	8b 55 08             	mov    0x8(%ebp),%edx
 1ce:	31 c0                	xor    %eax,%eax
 1d0:	f0 87 02             	lock xchg %eax,(%edx)
}
 1d3:	5d                   	pop    %ebp
 1d4:	c3                   	ret    
 1d5:	66 90                	xchg   %ax,%ax
 1d7:	90                   	nop

000001d8 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 1d8:	55                   	push   %ebp
 1d9:	89 e5                	mov    %esp,%ebp
 1db:	53                   	push   %ebx
 1dc:	8b 45 08             	mov    0x8(%ebp),%eax
 1df:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1e2:	89 c2                	mov    %eax,%edx
 1e4:	8a 19                	mov    (%ecx),%bl
 1e6:	88 1a                	mov    %bl,(%edx)
 1e8:	42                   	inc    %edx
 1e9:	41                   	inc    %ecx
 1ea:	84 db                	test   %bl,%bl
 1ec:	75 f6                	jne    1e4 <strcpy+0xc>
    ;
  return os;
}
 1ee:	5b                   	pop    %ebx
 1ef:	5d                   	pop    %ebp
 1f0:	c3                   	ret    
 1f1:	8d 76 00             	lea    0x0(%esi),%esi

000001f4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1f4:	55                   	push   %ebp
 1f5:	89 e5                	mov    %esp,%ebp
 1f7:	56                   	push   %esi
 1f8:	53                   	push   %ebx
 1f9:	8b 55 08             	mov    0x8(%ebp),%edx
 1fc:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 1ff:	0f b6 02             	movzbl (%edx),%eax
 202:	0f b6 19             	movzbl (%ecx),%ebx
 205:	84 c0                	test   %al,%al
 207:	75 14                	jne    21d <strcmp+0x29>
 209:	eb 1d                	jmp    228 <strcmp+0x34>
 20b:	90                   	nop
    p++, q++;
 20c:	42                   	inc    %edx
 20d:	8d 71 01             	lea    0x1(%ecx),%esi
  while(*p && *p == *q)
 210:	0f b6 02             	movzbl (%edx),%eax
 213:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 217:	84 c0                	test   %al,%al
 219:	74 0d                	je     228 <strcmp+0x34>
    p++, q++;
 21b:	89 f1                	mov    %esi,%ecx
  while(*p && *p == *q)
 21d:	38 d8                	cmp    %bl,%al
 21f:	74 eb                	je     20c <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 221:	29 d8                	sub    %ebx,%eax
}
 223:	5b                   	pop    %ebx
 224:	5e                   	pop    %esi
 225:	5d                   	pop    %ebp
 226:	c3                   	ret    
 227:	90                   	nop
  while(*p && *p == *q)
 228:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 22a:	29 d8                	sub    %ebx,%eax
}
 22c:	5b                   	pop    %ebx
 22d:	5e                   	pop    %esi
 22e:	5d                   	pop    %ebp
 22f:	c3                   	ret    

00000230 <strlen>:

uint
strlen(char *s)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 236:	80 39 00             	cmpb   $0x0,(%ecx)
 239:	74 10                	je     24b <strlen+0x1b>
 23b:	31 d2                	xor    %edx,%edx
 23d:	8d 76 00             	lea    0x0(%esi),%esi
 240:	42                   	inc    %edx
 241:	89 d0                	mov    %edx,%eax
 243:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 247:	75 f7                	jne    240 <strlen+0x10>
    ;
  return n;
}
 249:	5d                   	pop    %ebp
 24a:	c3                   	ret    
  for(n = 0; s[n]; n++)
 24b:	31 c0                	xor    %eax,%eax
}
 24d:	5d                   	pop    %ebp
 24e:	c3                   	ret    
 24f:	90                   	nop

00000250 <memset>:

void*
memset(void *dst, int c, uint n)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	57                   	push   %edi
 254:	8b 55 08             	mov    0x8(%ebp),%edx
  asm volatile("cld; rep stosb" :
 257:	89 d7                	mov    %edx,%edi
 259:	8b 4d 10             	mov    0x10(%ebp),%ecx
 25c:	8b 45 0c             	mov    0xc(%ebp),%eax
 25f:	fc                   	cld    
 260:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 262:	89 d0                	mov    %edx,%eax
 264:	5f                   	pop    %edi
 265:	5d                   	pop    %ebp
 266:	c3                   	ret    
 267:	90                   	nop

00000268 <strchr>:

char*
strchr(const char *s, char c)
{
 268:	55                   	push   %ebp
 269:	89 e5                	mov    %esp,%ebp
 26b:	8b 45 08             	mov    0x8(%ebp),%eax
 26e:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
 271:	8a 10                	mov    (%eax),%dl
 273:	84 d2                	test   %dl,%dl
 275:	75 0c                	jne    283 <strchr+0x1b>
 277:	eb 13                	jmp    28c <strchr+0x24>
 279:	8d 76 00             	lea    0x0(%esi),%esi
 27c:	40                   	inc    %eax
 27d:	8a 10                	mov    (%eax),%dl
 27f:	84 d2                	test   %dl,%dl
 281:	74 09                	je     28c <strchr+0x24>
    if(*s == c)
 283:	38 ca                	cmp    %cl,%dl
 285:	75 f5                	jne    27c <strchr+0x14>
      return (char*)s;
  return 0;
}
 287:	5d                   	pop    %ebp
 288:	c3                   	ret    
 289:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
 28c:	31 c0                	xor    %eax,%eax
}
 28e:	5d                   	pop    %ebp
 28f:	c3                   	ret    

00000290 <gets>:

char*
gets(char *buf, int max)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	57                   	push   %edi
 294:	56                   	push   %esi
 295:	53                   	push   %ebx
 296:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 299:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
 29b:	8d 7d e7             	lea    -0x19(%ebp),%edi
 29e:	66 90                	xchg   %ax,%ax
  for(i=0; i+1 < max; ){
 2a0:	8d 73 01             	lea    0x1(%ebx),%esi
 2a3:	3b 75 0c             	cmp    0xc(%ebp),%esi
 2a6:	7d 40                	jge    2e8 <gets+0x58>
    cc = read(0, &c, 1);
 2a8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 2af:	00 
 2b0:	89 7c 24 04          	mov    %edi,0x4(%esp)
 2b4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2bb:	e8 fb 00 00 00       	call   3bb <read>
    if(cc < 1)
 2c0:	85 c0                	test   %eax,%eax
 2c2:	7e 24                	jle    2e8 <gets+0x58>
      break;
    buf[i++] = c;
 2c4:	8a 45 e7             	mov    -0x19(%ebp),%al
 2c7:	8b 55 08             	mov    0x8(%ebp),%edx
 2ca:	88 44 32 ff          	mov    %al,-0x1(%edx,%esi,1)
    if(c == '\n' || c == '\r')
 2ce:	3c 0a                	cmp    $0xa,%al
 2d0:	74 06                	je     2d8 <gets+0x48>
 2d2:	89 f3                	mov    %esi,%ebx
 2d4:	3c 0d                	cmp    $0xd,%al
 2d6:	75 c8                	jne    2a0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 2d8:	8b 45 08             	mov    0x8(%ebp),%eax
 2db:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 2df:	83 c4 2c             	add    $0x2c,%esp
 2e2:	5b                   	pop    %ebx
 2e3:	5e                   	pop    %esi
 2e4:	5f                   	pop    %edi
 2e5:	5d                   	pop    %ebp
 2e6:	c3                   	ret    
 2e7:	90                   	nop
    if(cc < 1)
 2e8:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 2ea:	8b 45 08             	mov    0x8(%ebp),%eax
 2ed:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 2f1:	83 c4 2c             	add    $0x2c,%esp
 2f4:	5b                   	pop    %ebx
 2f5:	5e                   	pop    %esi
 2f6:	5f                   	pop    %edi
 2f7:	5d                   	pop    %ebp
 2f8:	c3                   	ret    
 2f9:	8d 76 00             	lea    0x0(%esi),%esi

000002fc <stat>:

int
stat(char *n, struct stat *st)
{
 2fc:	55                   	push   %ebp
 2fd:	89 e5                	mov    %esp,%ebp
 2ff:	56                   	push   %esi
 300:	53                   	push   %ebx
 301:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 304:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 30b:	00 
 30c:	8b 45 08             	mov    0x8(%ebp),%eax
 30f:	89 04 24             	mov    %eax,(%esp)
 312:	e8 cc 00 00 00       	call   3e3 <open>
 317:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 319:	85 c0                	test   %eax,%eax
 31b:	78 23                	js     340 <stat+0x44>
    return -1;
  r = fstat(fd, st);
 31d:	8b 45 0c             	mov    0xc(%ebp),%eax
 320:	89 44 24 04          	mov    %eax,0x4(%esp)
 324:	89 1c 24             	mov    %ebx,(%esp)
 327:	e8 cf 00 00 00       	call   3fb <fstat>
 32c:	89 c6                	mov    %eax,%esi
  close(fd);
 32e:	89 1c 24             	mov    %ebx,(%esp)
 331:	e8 95 00 00 00       	call   3cb <close>
  return r;
}
 336:	89 f0                	mov    %esi,%eax
 338:	83 c4 10             	add    $0x10,%esp
 33b:	5b                   	pop    %ebx
 33c:	5e                   	pop    %esi
 33d:	5d                   	pop    %ebp
 33e:	c3                   	ret    
 33f:	90                   	nop
    return -1;
 340:	be ff ff ff ff       	mov    $0xffffffff,%esi
 345:	eb ef                	jmp    336 <stat+0x3a>
 347:	90                   	nop

00000348 <atoi>:

int
atoi(const char *s)
{
 348:	55                   	push   %ebp
 349:	89 e5                	mov    %esp,%ebp
 34b:	53                   	push   %ebx
 34c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 34f:	0f be 11             	movsbl (%ecx),%edx
 352:	8d 42 d0             	lea    -0x30(%edx),%eax
 355:	3c 09                	cmp    $0x9,%al
 357:	b8 00 00 00 00       	mov    $0x0,%eax
 35c:	77 15                	ja     373 <atoi+0x2b>
 35e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 360:	8d 04 80             	lea    (%eax,%eax,4),%eax
 363:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
 367:	41                   	inc    %ecx
  while('0' <= *s && *s <= '9')
 368:	0f be 11             	movsbl (%ecx),%edx
 36b:	8d 5a d0             	lea    -0x30(%edx),%ebx
 36e:	80 fb 09             	cmp    $0x9,%bl
 371:	76 ed                	jbe    360 <atoi+0x18>
  return n;
}
 373:	5b                   	pop    %ebx
 374:	5d                   	pop    %ebp
 375:	c3                   	ret    
 376:	66 90                	xchg   %ax,%ax

00000378 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 378:	55                   	push   %ebp
 379:	89 e5                	mov    %esp,%ebp
 37b:	56                   	push   %esi
 37c:	53                   	push   %ebx
 37d:	8b 45 08             	mov    0x8(%ebp),%eax
 380:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 383:	8b 75 10             	mov    0x10(%ebp),%esi
memmove(void *vdst, void *vsrc, int n)
 386:	31 d2                	xor    %edx,%edx
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 388:	85 f6                	test   %esi,%esi
 38a:	7e 0b                	jle    397 <memmove+0x1f>
    *dst++ = *src++;
 38c:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 38f:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 392:	42                   	inc    %edx
  while(n-- > 0)
 393:	39 f2                	cmp    %esi,%edx
 395:	75 f5                	jne    38c <memmove+0x14>
  return vdst;
}
 397:	5b                   	pop    %ebx
 398:	5e                   	pop    %esi
 399:	5d                   	pop    %ebp
 39a:	c3                   	ret    

0000039b <fork>:
 39b:	b8 01 00 00 00       	mov    $0x1,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret    

000003a3 <exit>:
 3a3:	b8 02 00 00 00       	mov    $0x2,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret    

000003ab <wait>:
 3ab:	b8 03 00 00 00       	mov    $0x3,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <pipe>:
 3b3:	b8 04 00 00 00       	mov    $0x4,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <read>:
 3bb:	b8 05 00 00 00       	mov    $0x5,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <write>:
 3c3:	b8 10 00 00 00       	mov    $0x10,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    

000003cb <close>:
 3cb:	b8 15 00 00 00       	mov    $0x15,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <kill>:
 3d3:	b8 06 00 00 00       	mov    $0x6,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <exec>:
 3db:	b8 07 00 00 00       	mov    $0x7,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <open>:
 3e3:	b8 0f 00 00 00       	mov    $0xf,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <mknod>:
 3eb:	b8 11 00 00 00       	mov    $0x11,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <unlink>:
 3f3:	b8 12 00 00 00       	mov    $0x12,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <fstat>:
 3fb:	b8 08 00 00 00       	mov    $0x8,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <link>:
 403:	b8 13 00 00 00       	mov    $0x13,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    

0000040b <mkdir>:
 40b:	b8 14 00 00 00       	mov    $0x14,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret    

00000413 <chdir>:
 413:	b8 09 00 00 00       	mov    $0x9,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    

0000041b <dup>:
 41b:	b8 0a 00 00 00       	mov    $0xa,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret    

00000423 <getpid>:
 423:	b8 0b 00 00 00       	mov    $0xb,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret    

0000042b <sbrk>:
 42b:	b8 0c 00 00 00       	mov    $0xc,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <sleep>:
 433:	b8 0d 00 00 00       	mov    $0xd,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret    

0000043b <uptime>:
 43b:	b8 0e 00 00 00       	mov    $0xe,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret    

00000443 <getprocnum>:
 443:	b8 16 00 00 00       	mov    $0x16,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret    

0000044b <mempagenum>:
 44b:	b8 17 00 00 00       	mov    $0x17,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret    

00000453 <syscallnum>:
 453:	b8 18 00 00 00       	mov    $0x18,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret    

0000045b <settickets>:
 45b:	b8 19 00 00 00       	mov    $0x19,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret    

00000463 <getsheltime>:
 463:	b8 1a 00 00 00       	mov    $0x1a,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret    

0000046b <setstride>:
 46b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret    

00000473 <setpass>:
 473:	b8 1c 00 00 00       	mov    $0x1c,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret    

0000047b <join>:
 47b:	b8 1d 00 00 00       	mov    $0x1d,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret    

00000483 <clone>:
 483:	b8 1e 00 00 00       	mov    $0x1e,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret    

0000048b <clone1>:
 48b:	b8 1f 00 00 00       	mov    $0x1f,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret    
 493:	90                   	nop

00000494 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 494:	55                   	push   %ebp
 495:	89 e5                	mov    %esp,%ebp
 497:	57                   	push   %edi
 498:	56                   	push   %esi
 499:	53                   	push   %ebx
 49a:	83 ec 3c             	sub    $0x3c,%esp
 49d:	89 c7                	mov    %eax,%edi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 49f:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 4a1:	8b 5d 08             	mov    0x8(%ebp),%ebx
 4a4:	85 db                	test   %ebx,%ebx
 4a6:	74 04                	je     4ac <printint+0x18>
 4a8:	85 d2                	test   %edx,%edx
 4aa:	78 5d                	js     509 <printint+0x75>
  neg = 0;
 4ac:	31 db                	xor    %ebx,%ebx
  } else {
    x = xx;
  }

  i = 0;
 4ae:	31 f6                	xor    %esi,%esi
 4b0:	eb 04                	jmp    4b6 <printint+0x22>
 4b2:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 4b4:	89 d6                	mov    %edx,%esi
 4b6:	31 d2                	xor    %edx,%edx
 4b8:	f7 f1                	div    %ecx
 4ba:	8a 92 7f 08 00 00    	mov    0x87f(%edx),%dl
 4c0:	88 54 35 d8          	mov    %dl,-0x28(%ebp,%esi,1)
 4c4:	8d 56 01             	lea    0x1(%esi),%edx
  }while((x /= base) != 0);
 4c7:	85 c0                	test   %eax,%eax
 4c9:	75 e9                	jne    4b4 <printint+0x20>
  if(neg)
 4cb:	85 db                	test   %ebx,%ebx
 4cd:	74 08                	je     4d7 <printint+0x43>
    buf[i++] = '-';
 4cf:	c6 44 15 d8 2d       	movb   $0x2d,-0x28(%ebp,%edx,1)
 4d4:	8d 56 02             	lea    0x2(%esi),%edx

  while(--i >= 0)
 4d7:	8d 5a ff             	lea    -0x1(%edx),%ebx
 4da:	8d 75 d7             	lea    -0x29(%ebp),%esi
 4dd:	8d 76 00             	lea    0x0(%esi),%esi
 4e0:	8a 44 1d d8          	mov    -0x28(%ebp,%ebx,1),%al
 4e4:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 4e7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4ee:	00 
 4ef:	89 74 24 04          	mov    %esi,0x4(%esp)
 4f3:	89 3c 24             	mov    %edi,(%esp)
 4f6:	e8 c8 fe ff ff       	call   3c3 <write>
  while(--i >= 0)
 4fb:	4b                   	dec    %ebx
 4fc:	83 fb ff             	cmp    $0xffffffff,%ebx
 4ff:	75 df                	jne    4e0 <printint+0x4c>
    putc(fd, buf[i]);
}
 501:	83 c4 3c             	add    $0x3c,%esp
 504:	5b                   	pop    %ebx
 505:	5e                   	pop    %esi
 506:	5f                   	pop    %edi
 507:	5d                   	pop    %ebp
 508:	c3                   	ret    
    x = -xx;
 509:	f7 d8                	neg    %eax
    neg = 1;
 50b:	bb 01 00 00 00       	mov    $0x1,%ebx
    x = -xx;
 510:	eb 9c                	jmp    4ae <printint+0x1a>
 512:	66 90                	xchg   %ax,%ax

00000514 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 514:	55                   	push   %ebp
 515:	89 e5                	mov    %esp,%ebp
 517:	57                   	push   %edi
 518:	56                   	push   %esi
 519:	53                   	push   %ebx
 51a:	83 ec 3c             	sub    $0x3c,%esp
 51d:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 520:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 523:	8a 03                	mov    (%ebx),%al
 525:	84 c0                	test   %al,%al
 527:	0f 84 bb 00 00 00    	je     5e8 <printf+0xd4>
printf(int fd, char *fmt, ...)
 52d:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
 52e:	8d 55 10             	lea    0x10(%ebp),%edx
 531:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  state = 0;
 534:	31 ff                	xor    %edi,%edi
 536:	eb 2f                	jmp    567 <printf+0x53>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 538:	83 f9 25             	cmp    $0x25,%ecx
 53b:	0f 84 af 00 00 00    	je     5f0 <printf+0xdc>
        state = '%';
      } else {
        putc(fd, c);
 541:	88 4d e2             	mov    %cl,-0x1e(%ebp)
  write(fd, &c, 1);
 544:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 54b:	00 
 54c:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 54f:	89 44 24 04          	mov    %eax,0x4(%esp)
 553:	89 34 24             	mov    %esi,(%esp)
 556:	e8 68 fe ff ff       	call   3c3 <write>
 55b:	43                   	inc    %ebx
  for(i = 0; fmt[i]; i++){
 55c:	8a 43 ff             	mov    -0x1(%ebx),%al
 55f:	84 c0                	test   %al,%al
 561:	0f 84 81 00 00 00    	je     5e8 <printf+0xd4>
    c = fmt[i] & 0xff;
 567:	0f b6 c8             	movzbl %al,%ecx
    if(state == 0){
 56a:	85 ff                	test   %edi,%edi
 56c:	74 ca                	je     538 <printf+0x24>
      }
    } else if(state == '%'){
 56e:	83 ff 25             	cmp    $0x25,%edi
 571:	75 e8                	jne    55b <printf+0x47>
      if(c == 'd'){
 573:	83 f9 64             	cmp    $0x64,%ecx
 576:	0f 84 14 01 00 00    	je     690 <printf+0x17c>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 57c:	83 f9 78             	cmp    $0x78,%ecx
 57f:	74 7b                	je     5fc <printf+0xe8>
 581:	83 f9 70             	cmp    $0x70,%ecx
 584:	74 76                	je     5fc <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 586:	83 f9 73             	cmp    $0x73,%ecx
 589:	0f 84 91 00 00 00    	je     620 <printf+0x10c>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 58f:	83 f9 63             	cmp    $0x63,%ecx
 592:	0f 84 cc 00 00 00    	je     664 <printf+0x150>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 598:	83 f9 25             	cmp    $0x25,%ecx
 59b:	0f 84 13 01 00 00    	je     6b4 <printf+0x1a0>
 5a1:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
  write(fd, &c, 1);
 5a5:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5ac:	00 
 5ad:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 5b0:	89 44 24 04          	mov    %eax,0x4(%esp)
 5b4:	89 34 24             	mov    %esi,(%esp)
 5b7:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 5ba:	e8 04 fe ff ff       	call   3c3 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 5bf:	8b 4d d0             	mov    -0x30(%ebp),%ecx
 5c2:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
 5c5:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5cc:	00 
 5cd:	8d 55 e7             	lea    -0x19(%ebp),%edx
 5d0:	89 54 24 04          	mov    %edx,0x4(%esp)
 5d4:	89 34 24             	mov    %esi,(%esp)
 5d7:	e8 e7 fd ff ff       	call   3c3 <write>
      }
      state = 0;
 5dc:	31 ff                	xor    %edi,%edi
 5de:	43                   	inc    %ebx
  for(i = 0; fmt[i]; i++){
 5df:	8a 43 ff             	mov    -0x1(%ebx),%al
 5e2:	84 c0                	test   %al,%al
 5e4:	75 81                	jne    567 <printf+0x53>
 5e6:	66 90                	xchg   %ax,%ax
    }
  }
}
 5e8:	83 c4 3c             	add    $0x3c,%esp
 5eb:	5b                   	pop    %ebx
 5ec:	5e                   	pop    %esi
 5ed:	5f                   	pop    %edi
 5ee:	5d                   	pop    %ebp
 5ef:	c3                   	ret    
        state = '%';
 5f0:	bf 25 00 00 00       	mov    $0x25,%edi
 5f5:	e9 61 ff ff ff       	jmp    55b <printf+0x47>
 5fa:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 5fc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 603:	b9 10 00 00 00       	mov    $0x10,%ecx
 608:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 60b:	8b 10                	mov    (%eax),%edx
 60d:	89 f0                	mov    %esi,%eax
 60f:	e8 80 fe ff ff       	call   494 <printint>
        ap++;
 614:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 618:	31 ff                	xor    %edi,%edi
        ap++;
 61a:	e9 3c ff ff ff       	jmp    55b <printf+0x47>
 61f:	90                   	nop
        s = (char*)*ap;
 620:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 623:	8b 3a                	mov    (%edx),%edi
        ap++;
 625:	83 c2 04             	add    $0x4,%edx
 628:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
 62b:	85 ff                	test   %edi,%edi
 62d:	0f 84 a3 00 00 00    	je     6d6 <printf+0x1c2>
        while(*s != 0){
 633:	8a 07                	mov    (%edi),%al
 635:	84 c0                	test   %al,%al
 637:	74 24                	je     65d <printf+0x149>
 639:	8d 76 00             	lea    0x0(%esi),%esi
 63c:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 63f:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 646:	00 
 647:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 64a:	89 44 24 04          	mov    %eax,0x4(%esp)
 64e:	89 34 24             	mov    %esi,(%esp)
 651:	e8 6d fd ff ff       	call   3c3 <write>
          s++;
 656:	47                   	inc    %edi
        while(*s != 0){
 657:	8a 07                	mov    (%edi),%al
 659:	84 c0                	test   %al,%al
 65b:	75 df                	jne    63c <printf+0x128>
      state = 0;
 65d:	31 ff                	xor    %edi,%edi
 65f:	e9 f7 fe ff ff       	jmp    55b <printf+0x47>
        putc(fd, *ap);
 664:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 667:	8b 02                	mov    (%edx),%eax
 669:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 66c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 673:	00 
 674:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 677:	89 44 24 04          	mov    %eax,0x4(%esp)
 67b:	89 34 24             	mov    %esi,(%esp)
 67e:	e8 40 fd ff ff       	call   3c3 <write>
        ap++;
 683:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 687:	31 ff                	xor    %edi,%edi
 689:	e9 cd fe ff ff       	jmp    55b <printf+0x47>
 68e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 690:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 697:	b1 0a                	mov    $0xa,%cl
 699:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 69c:	8b 10                	mov    (%eax),%edx
 69e:	89 f0                	mov    %esi,%eax
 6a0:	e8 ef fd ff ff       	call   494 <printint>
        ap++;
 6a5:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 6a9:	66 31 ff             	xor    %di,%di
 6ac:	e9 aa fe ff ff       	jmp    55b <printf+0x47>
 6b1:	8d 76 00             	lea    0x0(%esi),%esi
 6b4:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
  write(fd, &c, 1);
 6b8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6bf:	00 
 6c0:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 6c3:	89 44 24 04          	mov    %eax,0x4(%esp)
 6c7:	89 34 24             	mov    %esi,(%esp)
 6ca:	e8 f4 fc ff ff       	call   3c3 <write>
      state = 0;
 6cf:	31 ff                	xor    %edi,%edi
 6d1:	e9 85 fe ff ff       	jmp    55b <printf+0x47>
          s = "(null)";
 6d6:	bf 78 08 00 00       	mov    $0x878,%edi
 6db:	e9 53 ff ff ff       	jmp    633 <printf+0x11f>

000006e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	57                   	push   %edi
 6e4:	56                   	push   %esi
 6e5:	53                   	push   %ebx
 6e6:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6e9:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6ec:	a1 e0 0b 00 00       	mov    0xbe0,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6f1:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f3:	39 d0                	cmp    %edx,%eax
 6f5:	72 11                	jb     708 <free+0x28>
 6f7:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6f8:	39 c8                	cmp    %ecx,%eax
 6fa:	72 04                	jb     700 <free+0x20>
 6fc:	39 ca                	cmp    %ecx,%edx
 6fe:	72 10                	jb     710 <free+0x30>
 700:	89 c8                	mov    %ecx,%eax
 702:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 704:	39 d0                	cmp    %edx,%eax
 706:	73 f0                	jae    6f8 <free+0x18>
 708:	39 ca                	cmp    %ecx,%edx
 70a:	72 04                	jb     710 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 70c:	39 c8                	cmp    %ecx,%eax
 70e:	72 f0                	jb     700 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 710:	8b 73 fc             	mov    -0x4(%ebx),%esi
 713:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 716:	39 cf                	cmp    %ecx,%edi
 718:	74 1a                	je     734 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 71a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 71d:	8b 48 04             	mov    0x4(%eax),%ecx
 720:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 723:	39 f2                	cmp    %esi,%edx
 725:	74 24                	je     74b <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 727:	89 10                	mov    %edx,(%eax)
  freep = p;
 729:	a3 e0 0b 00 00       	mov    %eax,0xbe0
}
 72e:	5b                   	pop    %ebx
 72f:	5e                   	pop    %esi
 730:	5f                   	pop    %edi
 731:	5d                   	pop    %ebp
 732:	c3                   	ret    
 733:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 734:	03 71 04             	add    0x4(%ecx),%esi
 737:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 73a:	8b 08                	mov    (%eax),%ecx
 73c:	8b 09                	mov    (%ecx),%ecx
 73e:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 741:	8b 48 04             	mov    0x4(%eax),%ecx
 744:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 747:	39 f2                	cmp    %esi,%edx
 749:	75 dc                	jne    727 <free+0x47>
    p->s.size += bp->s.size;
 74b:	03 4b fc             	add    -0x4(%ebx),%ecx
 74e:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 751:	8b 53 f8             	mov    -0x8(%ebx),%edx
 754:	89 10                	mov    %edx,(%eax)
  freep = p;
 756:	a3 e0 0b 00 00       	mov    %eax,0xbe0
}
 75b:	5b                   	pop    %ebx
 75c:	5e                   	pop    %esi
 75d:	5f                   	pop    %edi
 75e:	5d                   	pop    %ebp
 75f:	c3                   	ret    

00000760 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 760:	55                   	push   %ebp
 761:	89 e5                	mov    %esp,%ebp
 763:	57                   	push   %edi
 764:	56                   	push   %esi
 765:	53                   	push   %ebx
 766:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 769:	8b 75 08             	mov    0x8(%ebp),%esi
 76c:	83 c6 07             	add    $0x7,%esi
 76f:	c1 ee 03             	shr    $0x3,%esi
 772:	46                   	inc    %esi
  if((prevp = freep) == 0){
 773:	8b 15 e0 0b 00 00    	mov    0xbe0,%edx
 779:	85 d2                	test   %edx,%edx
 77b:	0f 84 8d 00 00 00    	je     80e <malloc+0xae>
 781:	8b 02                	mov    (%edx),%eax
 783:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 786:	39 ce                	cmp    %ecx,%esi
 788:	76 52                	jbe    7dc <malloc+0x7c>
 78a:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 791:	eb 0a                	jmp    79d <malloc+0x3d>
 793:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 794:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 796:	8b 48 04             	mov    0x4(%eax),%ecx
 799:	39 ce                	cmp    %ecx,%esi
 79b:	76 3f                	jbe    7dc <malloc+0x7c>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 79d:	89 c2                	mov    %eax,%edx
 79f:	3b 05 e0 0b 00 00    	cmp    0xbe0,%eax
 7a5:	75 ed                	jne    794 <malloc+0x34>
  if(nu < 4096)
 7a7:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 7ad:	76 4d                	jbe    7fc <malloc+0x9c>
 7af:	89 d8                	mov    %ebx,%eax
 7b1:	89 f7                	mov    %esi,%edi
  p = sbrk(nu * sizeof(Header));
 7b3:	89 04 24             	mov    %eax,(%esp)
 7b6:	e8 70 fc ff ff       	call   42b <sbrk>
  if(p == (char*)-1)
 7bb:	83 f8 ff             	cmp    $0xffffffff,%eax
 7be:	74 18                	je     7d8 <malloc+0x78>
  hp->s.size = nu;
 7c0:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 7c3:	83 c0 08             	add    $0x8,%eax
 7c6:	89 04 24             	mov    %eax,(%esp)
 7c9:	e8 12 ff ff ff       	call   6e0 <free>
  return freep;
 7ce:	8b 15 e0 0b 00 00    	mov    0xbe0,%edx
      if((p = morecore(nunits)) == 0)
 7d4:	85 d2                	test   %edx,%edx
 7d6:	75 bc                	jne    794 <malloc+0x34>
        return 0;
 7d8:	31 c0                	xor    %eax,%eax
 7da:	eb 18                	jmp    7f4 <malloc+0x94>
      if(p->s.size == nunits)
 7dc:	39 ce                	cmp    %ecx,%esi
 7de:	74 28                	je     808 <malloc+0xa8>
        p->s.size -= nunits;
 7e0:	29 f1                	sub    %esi,%ecx
 7e2:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7e5:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7e8:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 7eb:	89 15 e0 0b 00 00    	mov    %edx,0xbe0
      return (void*)(p + 1);
 7f1:	83 c0 08             	add    $0x8,%eax
  }
}
 7f4:	83 c4 1c             	add    $0x1c,%esp
 7f7:	5b                   	pop    %ebx
 7f8:	5e                   	pop    %esi
 7f9:	5f                   	pop    %edi
 7fa:	5d                   	pop    %ebp
 7fb:	c3                   	ret    
  if(nu < 4096)
 7fc:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 801:	bf 00 10 00 00       	mov    $0x1000,%edi
 806:	eb ab                	jmp    7b3 <malloc+0x53>
        prevp->s.ptr = p->s.ptr;
 808:	8b 08                	mov    (%eax),%ecx
 80a:	89 0a                	mov    %ecx,(%edx)
 80c:	eb dd                	jmp    7eb <malloc+0x8b>
    base.s.ptr = freep = prevp = &base;
 80e:	c7 05 e0 0b 00 00 e4 	movl   $0xbe4,0xbe0
 815:	0b 00 00 
 818:	c7 05 e4 0b 00 00 e4 	movl   $0xbe4,0xbe4
 81f:	0b 00 00 
    base.s.size = 0;
 822:	c7 05 e8 0b 00 00 00 	movl   $0x0,0xbe8
 829:	00 00 00 
 82c:	b8 e4 0b 00 00       	mov    $0xbe4,%eax
 831:	e9 54 ff ff ff       	jmp    78a <malloc+0x2a>
