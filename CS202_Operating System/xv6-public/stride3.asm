
_stride3：     文件格式 elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"


int main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp


    setstride(250);
   9:	c7 04 24 fa 00 00 00 	movl   $0xfa,(%esp)
  10:	e8 c6 02 00 00       	call   2db <setstride>
    setpass(40);
  15:	c7 04 24 28 00 00 00 	movl   $0x28,(%esp)
  1c:	e8 c2 02 00 00       	call   2e3 <setpass>

    sleep(5);
  21:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
  28:	e8 76 02 00 00       	call   2a3 <sleep>
  2d:	ba f8 a7 00 00       	mov    $0xa7f8,%edx
  32:	66 90                	xchg   %ax,%ax
    int i,k;
    const int loop=43000;
    //int result;
    for(i=0;i<loop;i++)
    {
        asm("nop"); //in order to prevent the compiler from optimizing the for loop
  34:	90                   	nop
  35:	b8 f8 a7 00 00       	mov    $0xa7f8,%eax
  3a:	66 90                	xchg   %ax,%ax
        for(k=0;k<loop;k++)
        {
            asm("nop");
  3c:	90                   	nop
        for(k=0;k<loop;k++)
  3d:	48                   	dec    %eax
  3e:	75 fc                	jne    3c <main+0x3c>
    for(i=0;i<loop;i++)
  40:	4a                   	dec    %edx
  41:	75 f1                	jne    34 <main+0x34>
        }

    }
    //result = getsheltime();
    //printf(1,"Prog2: !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!%d\n",result);
    exit();
  43:	e8 cb 01 00 00       	call   213 <exit>

00000048 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  48:	55                   	push   %ebp
  49:	89 e5                	mov    %esp,%ebp
  4b:	53                   	push   %ebx
  4c:	8b 45 08             	mov    0x8(%ebp),%eax
  4f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  52:	89 c2                	mov    %eax,%edx
  54:	8a 19                	mov    (%ecx),%bl
  56:	88 1a                	mov    %bl,(%edx)
  58:	42                   	inc    %edx
  59:	41                   	inc    %ecx
  5a:	84 db                	test   %bl,%bl
  5c:	75 f6                	jne    54 <strcpy+0xc>
    ;
  return os;
}
  5e:	5b                   	pop    %ebx
  5f:	5d                   	pop    %ebp
  60:	c3                   	ret    
  61:	8d 76 00             	lea    0x0(%esi),%esi

00000064 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  64:	55                   	push   %ebp
  65:	89 e5                	mov    %esp,%ebp
  67:	56                   	push   %esi
  68:	53                   	push   %ebx
  69:	8b 55 08             	mov    0x8(%ebp),%edx
  6c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  6f:	0f b6 02             	movzbl (%edx),%eax
  72:	0f b6 19             	movzbl (%ecx),%ebx
  75:	84 c0                	test   %al,%al
  77:	75 14                	jne    8d <strcmp+0x29>
  79:	eb 1d                	jmp    98 <strcmp+0x34>
  7b:	90                   	nop
    p++, q++;
  7c:	42                   	inc    %edx
  7d:	8d 71 01             	lea    0x1(%ecx),%esi
  while(*p && *p == *q)
  80:	0f b6 02             	movzbl (%edx),%eax
  83:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  87:	84 c0                	test   %al,%al
  89:	74 0d                	je     98 <strcmp+0x34>
    p++, q++;
  8b:	89 f1                	mov    %esi,%ecx
  while(*p && *p == *q)
  8d:	38 d8                	cmp    %bl,%al
  8f:	74 eb                	je     7c <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
  91:	29 d8                	sub    %ebx,%eax
}
  93:	5b                   	pop    %ebx
  94:	5e                   	pop    %esi
  95:	5d                   	pop    %ebp
  96:	c3                   	ret    
  97:	90                   	nop
  while(*p && *p == *q)
  98:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  9a:	29 d8                	sub    %ebx,%eax
}
  9c:	5b                   	pop    %ebx
  9d:	5e                   	pop    %esi
  9e:	5d                   	pop    %ebp
  9f:	c3                   	ret    

000000a0 <strlen>:

uint
strlen(char *s)
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  a6:	80 39 00             	cmpb   $0x0,(%ecx)
  a9:	74 10                	je     bb <strlen+0x1b>
  ab:	31 d2                	xor    %edx,%edx
  ad:	8d 76 00             	lea    0x0(%esi),%esi
  b0:	42                   	inc    %edx
  b1:	89 d0                	mov    %edx,%eax
  b3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  b7:	75 f7                	jne    b0 <strlen+0x10>
    ;
  return n;
}
  b9:	5d                   	pop    %ebp
  ba:	c3                   	ret    
  for(n = 0; s[n]; n++)
  bb:	31 c0                	xor    %eax,%eax
}
  bd:	5d                   	pop    %ebp
  be:	c3                   	ret    
  bf:	90                   	nop

000000c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	57                   	push   %edi
  c4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  c7:	89 d7                	mov    %edx,%edi
  c9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  cf:	fc                   	cld    
  d0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  d2:	89 d0                	mov    %edx,%eax
  d4:	5f                   	pop    %edi
  d5:	5d                   	pop    %ebp
  d6:	c3                   	ret    
  d7:	90                   	nop

000000d8 <strchr>:

char*
strchr(const char *s, char c)
{
  d8:	55                   	push   %ebp
  d9:	89 e5                	mov    %esp,%ebp
  db:	8b 45 08             	mov    0x8(%ebp),%eax
  de:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
  e1:	8a 10                	mov    (%eax),%dl
  e3:	84 d2                	test   %dl,%dl
  e5:	75 0c                	jne    f3 <strchr+0x1b>
  e7:	eb 13                	jmp    fc <strchr+0x24>
  e9:	8d 76 00             	lea    0x0(%esi),%esi
  ec:	40                   	inc    %eax
  ed:	8a 10                	mov    (%eax),%dl
  ef:	84 d2                	test   %dl,%dl
  f1:	74 09                	je     fc <strchr+0x24>
    if(*s == c)
  f3:	38 ca                	cmp    %cl,%dl
  f5:	75 f5                	jne    ec <strchr+0x14>
      return (char*)s;
  return 0;
}
  f7:	5d                   	pop    %ebp
  f8:	c3                   	ret    
  f9:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
  fc:	31 c0                	xor    %eax,%eax
}
  fe:	5d                   	pop    %ebp
  ff:	c3                   	ret    

00000100 <gets>:

char*
gets(char *buf, int max)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	57                   	push   %edi
 104:	56                   	push   %esi
 105:	53                   	push   %ebx
 106:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 109:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
 10b:	8d 7d e7             	lea    -0x19(%ebp),%edi
 10e:	66 90                	xchg   %ax,%ax
  for(i=0; i+1 < max; ){
 110:	8d 73 01             	lea    0x1(%ebx),%esi
 113:	3b 75 0c             	cmp    0xc(%ebp),%esi
 116:	7d 40                	jge    158 <gets+0x58>
    cc = read(0, &c, 1);
 118:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 11f:	00 
 120:	89 7c 24 04          	mov    %edi,0x4(%esp)
 124:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 12b:	e8 fb 00 00 00       	call   22b <read>
    if(cc < 1)
 130:	85 c0                	test   %eax,%eax
 132:	7e 24                	jle    158 <gets+0x58>
      break;
    buf[i++] = c;
 134:	8a 45 e7             	mov    -0x19(%ebp),%al
 137:	8b 55 08             	mov    0x8(%ebp),%edx
 13a:	88 44 32 ff          	mov    %al,-0x1(%edx,%esi,1)
    if(c == '\n' || c == '\r')
 13e:	3c 0a                	cmp    $0xa,%al
 140:	74 06                	je     148 <gets+0x48>
 142:	89 f3                	mov    %esi,%ebx
 144:	3c 0d                	cmp    $0xd,%al
 146:	75 c8                	jne    110 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 148:	8b 45 08             	mov    0x8(%ebp),%eax
 14b:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 14f:	83 c4 2c             	add    $0x2c,%esp
 152:	5b                   	pop    %ebx
 153:	5e                   	pop    %esi
 154:	5f                   	pop    %edi
 155:	5d                   	pop    %ebp
 156:	c3                   	ret    
 157:	90                   	nop
    if(cc < 1)
 158:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 15a:	8b 45 08             	mov    0x8(%ebp),%eax
 15d:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 161:	83 c4 2c             	add    $0x2c,%esp
 164:	5b                   	pop    %ebx
 165:	5e                   	pop    %esi
 166:	5f                   	pop    %edi
 167:	5d                   	pop    %ebp
 168:	c3                   	ret    
 169:	8d 76 00             	lea    0x0(%esi),%esi

0000016c <stat>:

int
stat(char *n, struct stat *st)
{
 16c:	55                   	push   %ebp
 16d:	89 e5                	mov    %esp,%ebp
 16f:	56                   	push   %esi
 170:	53                   	push   %ebx
 171:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 174:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 17b:	00 
 17c:	8b 45 08             	mov    0x8(%ebp),%eax
 17f:	89 04 24             	mov    %eax,(%esp)
 182:	e8 cc 00 00 00       	call   253 <open>
 187:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 189:	85 c0                	test   %eax,%eax
 18b:	78 23                	js     1b0 <stat+0x44>
    return -1;
  r = fstat(fd, st);
 18d:	8b 45 0c             	mov    0xc(%ebp),%eax
 190:	89 44 24 04          	mov    %eax,0x4(%esp)
 194:	89 1c 24             	mov    %ebx,(%esp)
 197:	e8 cf 00 00 00       	call   26b <fstat>
 19c:	89 c6                	mov    %eax,%esi
  close(fd);
 19e:	89 1c 24             	mov    %ebx,(%esp)
 1a1:	e8 95 00 00 00       	call   23b <close>
  return r;
}
 1a6:	89 f0                	mov    %esi,%eax
 1a8:	83 c4 10             	add    $0x10,%esp
 1ab:	5b                   	pop    %ebx
 1ac:	5e                   	pop    %esi
 1ad:	5d                   	pop    %ebp
 1ae:	c3                   	ret    
 1af:	90                   	nop
    return -1;
 1b0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1b5:	eb ef                	jmp    1a6 <stat+0x3a>
 1b7:	90                   	nop

000001b8 <atoi>:

int
atoi(const char *s)
{
 1b8:	55                   	push   %ebp
 1b9:	89 e5                	mov    %esp,%ebp
 1bb:	53                   	push   %ebx
 1bc:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1bf:	0f be 11             	movsbl (%ecx),%edx
 1c2:	8d 42 d0             	lea    -0x30(%edx),%eax
 1c5:	3c 09                	cmp    $0x9,%al
 1c7:	b8 00 00 00 00       	mov    $0x0,%eax
 1cc:	77 15                	ja     1e3 <atoi+0x2b>
 1ce:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 1d0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 1d3:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
 1d7:	41                   	inc    %ecx
  while('0' <= *s && *s <= '9')
 1d8:	0f be 11             	movsbl (%ecx),%edx
 1db:	8d 5a d0             	lea    -0x30(%edx),%ebx
 1de:	80 fb 09             	cmp    $0x9,%bl
 1e1:	76 ed                	jbe    1d0 <atoi+0x18>
  return n;
}
 1e3:	5b                   	pop    %ebx
 1e4:	5d                   	pop    %ebp
 1e5:	c3                   	ret    
 1e6:	66 90                	xchg   %ax,%ax

000001e8 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 1e8:	55                   	push   %ebp
 1e9:	89 e5                	mov    %esp,%ebp
 1eb:	56                   	push   %esi
 1ec:	53                   	push   %ebx
 1ed:	8b 45 08             	mov    0x8(%ebp),%eax
 1f0:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1f3:	8b 75 10             	mov    0x10(%ebp),%esi
memmove(void *vdst, void *vsrc, int n)
 1f6:	31 d2                	xor    %edx,%edx
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1f8:	85 f6                	test   %esi,%esi
 1fa:	7e 0b                	jle    207 <memmove+0x1f>
    *dst++ = *src++;
 1fc:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 1ff:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 202:	42                   	inc    %edx
  while(n-- > 0)
 203:	39 f2                	cmp    %esi,%edx
 205:	75 f5                	jne    1fc <memmove+0x14>
  return vdst;
}
 207:	5b                   	pop    %ebx
 208:	5e                   	pop    %esi
 209:	5d                   	pop    %ebp
 20a:	c3                   	ret    

0000020b <fork>:
 20b:	b8 01 00 00 00       	mov    $0x1,%eax
 210:	cd 40                	int    $0x40
 212:	c3                   	ret    

00000213 <exit>:
 213:	b8 02 00 00 00       	mov    $0x2,%eax
 218:	cd 40                	int    $0x40
 21a:	c3                   	ret    

0000021b <wait>:
 21b:	b8 03 00 00 00       	mov    $0x3,%eax
 220:	cd 40                	int    $0x40
 222:	c3                   	ret    

00000223 <pipe>:
 223:	b8 04 00 00 00       	mov    $0x4,%eax
 228:	cd 40                	int    $0x40
 22a:	c3                   	ret    

0000022b <read>:
 22b:	b8 05 00 00 00       	mov    $0x5,%eax
 230:	cd 40                	int    $0x40
 232:	c3                   	ret    

00000233 <write>:
 233:	b8 10 00 00 00       	mov    $0x10,%eax
 238:	cd 40                	int    $0x40
 23a:	c3                   	ret    

0000023b <close>:
 23b:	b8 15 00 00 00       	mov    $0x15,%eax
 240:	cd 40                	int    $0x40
 242:	c3                   	ret    

00000243 <kill>:
 243:	b8 06 00 00 00       	mov    $0x6,%eax
 248:	cd 40                	int    $0x40
 24a:	c3                   	ret    

0000024b <exec>:
 24b:	b8 07 00 00 00       	mov    $0x7,%eax
 250:	cd 40                	int    $0x40
 252:	c3                   	ret    

00000253 <open>:
 253:	b8 0f 00 00 00       	mov    $0xf,%eax
 258:	cd 40                	int    $0x40
 25a:	c3                   	ret    

0000025b <mknod>:
 25b:	b8 11 00 00 00       	mov    $0x11,%eax
 260:	cd 40                	int    $0x40
 262:	c3                   	ret    

00000263 <unlink>:
 263:	b8 12 00 00 00       	mov    $0x12,%eax
 268:	cd 40                	int    $0x40
 26a:	c3                   	ret    

0000026b <fstat>:
 26b:	b8 08 00 00 00       	mov    $0x8,%eax
 270:	cd 40                	int    $0x40
 272:	c3                   	ret    

00000273 <link>:
 273:	b8 13 00 00 00       	mov    $0x13,%eax
 278:	cd 40                	int    $0x40
 27a:	c3                   	ret    

0000027b <mkdir>:
 27b:	b8 14 00 00 00       	mov    $0x14,%eax
 280:	cd 40                	int    $0x40
 282:	c3                   	ret    

00000283 <chdir>:
 283:	b8 09 00 00 00       	mov    $0x9,%eax
 288:	cd 40                	int    $0x40
 28a:	c3                   	ret    

0000028b <dup>:
 28b:	b8 0a 00 00 00       	mov    $0xa,%eax
 290:	cd 40                	int    $0x40
 292:	c3                   	ret    

00000293 <getpid>:
 293:	b8 0b 00 00 00       	mov    $0xb,%eax
 298:	cd 40                	int    $0x40
 29a:	c3                   	ret    

0000029b <sbrk>:
 29b:	b8 0c 00 00 00       	mov    $0xc,%eax
 2a0:	cd 40                	int    $0x40
 2a2:	c3                   	ret    

000002a3 <sleep>:
 2a3:	b8 0d 00 00 00       	mov    $0xd,%eax
 2a8:	cd 40                	int    $0x40
 2aa:	c3                   	ret    

000002ab <uptime>:
 2ab:	b8 0e 00 00 00       	mov    $0xe,%eax
 2b0:	cd 40                	int    $0x40
 2b2:	c3                   	ret    

000002b3 <getprocnum>:
 2b3:	b8 16 00 00 00       	mov    $0x16,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret    

000002bb <mempagenum>:
 2bb:	b8 17 00 00 00       	mov    $0x17,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret    

000002c3 <syscallnum>:
 2c3:	b8 18 00 00 00       	mov    $0x18,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret    

000002cb <settickets>:
 2cb:	b8 19 00 00 00       	mov    $0x19,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret    

000002d3 <getsheltime>:
 2d3:	b8 1a 00 00 00       	mov    $0x1a,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret    

000002db <setstride>:
 2db:	b8 1b 00 00 00       	mov    $0x1b,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret    

000002e3 <setpass>:
 2e3:	b8 1c 00 00 00       	mov    $0x1c,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret    

000002eb <join>:
 2eb:	b8 1d 00 00 00       	mov    $0x1d,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret    

000002f3 <clone1>:
 2f3:	b8 1e 00 00 00       	mov    $0x1e,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret    
 2fb:	90                   	nop

000002fc <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 2fc:	55                   	push   %ebp
 2fd:	89 e5                	mov    %esp,%ebp
 2ff:	57                   	push   %edi
 300:	56                   	push   %esi
 301:	53                   	push   %ebx
 302:	83 ec 3c             	sub    $0x3c,%esp
 305:	89 c7                	mov    %eax,%edi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 307:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 309:	8b 5d 08             	mov    0x8(%ebp),%ebx
 30c:	85 db                	test   %ebx,%ebx
 30e:	74 04                	je     314 <printint+0x18>
 310:	85 d2                	test   %edx,%edx
 312:	78 5d                	js     371 <printint+0x75>
  neg = 0;
 314:	31 db                	xor    %ebx,%ebx
  } else {
    x = xx;
  }

  i = 0;
 316:	31 f6                	xor    %esi,%esi
 318:	eb 04                	jmp    31e <printint+0x22>
 31a:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 31c:	89 d6                	mov    %edx,%esi
 31e:	31 d2                	xor    %edx,%edx
 320:	f7 f1                	div    %ecx
 322:	8a 92 a5 06 00 00    	mov    0x6a5(%edx),%dl
 328:	88 54 35 d8          	mov    %dl,-0x28(%ebp,%esi,1)
 32c:	8d 56 01             	lea    0x1(%esi),%edx
  }while((x /= base) != 0);
 32f:	85 c0                	test   %eax,%eax
 331:	75 e9                	jne    31c <printint+0x20>
  if(neg)
 333:	85 db                	test   %ebx,%ebx
 335:	74 08                	je     33f <printint+0x43>
    buf[i++] = '-';
 337:	c6 44 15 d8 2d       	movb   $0x2d,-0x28(%ebp,%edx,1)
 33c:	8d 56 02             	lea    0x2(%esi),%edx

  while(--i >= 0)
 33f:	8d 5a ff             	lea    -0x1(%edx),%ebx
 342:	8d 75 d7             	lea    -0x29(%ebp),%esi
 345:	8d 76 00             	lea    0x0(%esi),%esi
 348:	8a 44 1d d8          	mov    -0x28(%ebp,%ebx,1),%al
 34c:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 34f:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 356:	00 
 357:	89 74 24 04          	mov    %esi,0x4(%esp)
 35b:	89 3c 24             	mov    %edi,(%esp)
 35e:	e8 d0 fe ff ff       	call   233 <write>
  while(--i >= 0)
 363:	4b                   	dec    %ebx
 364:	83 fb ff             	cmp    $0xffffffff,%ebx
 367:	75 df                	jne    348 <printint+0x4c>
    putc(fd, buf[i]);
}
 369:	83 c4 3c             	add    $0x3c,%esp
 36c:	5b                   	pop    %ebx
 36d:	5e                   	pop    %esi
 36e:	5f                   	pop    %edi
 36f:	5d                   	pop    %ebp
 370:	c3                   	ret    
    x = -xx;
 371:	f7 d8                	neg    %eax
    neg = 1;
 373:	bb 01 00 00 00       	mov    $0x1,%ebx
    x = -xx;
 378:	eb 9c                	jmp    316 <printint+0x1a>
 37a:	66 90                	xchg   %ax,%ax

0000037c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 37c:	55                   	push   %ebp
 37d:	89 e5                	mov    %esp,%ebp
 37f:	57                   	push   %edi
 380:	56                   	push   %esi
 381:	53                   	push   %ebx
 382:	83 ec 3c             	sub    $0x3c,%esp
 385:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 388:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 38b:	8a 03                	mov    (%ebx),%al
 38d:	84 c0                	test   %al,%al
 38f:	0f 84 bb 00 00 00    	je     450 <printf+0xd4>
printf(int fd, char *fmt, ...)
 395:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
 396:	8d 55 10             	lea    0x10(%ebp),%edx
 399:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  state = 0;
 39c:	31 ff                	xor    %edi,%edi
 39e:	eb 2f                	jmp    3cf <printf+0x53>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 3a0:	83 f9 25             	cmp    $0x25,%ecx
 3a3:	0f 84 af 00 00 00    	je     458 <printf+0xdc>
        state = '%';
      } else {
        putc(fd, c);
 3a9:	88 4d e2             	mov    %cl,-0x1e(%ebp)
  write(fd, &c, 1);
 3ac:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3b3:	00 
 3b4:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 3b7:	89 44 24 04          	mov    %eax,0x4(%esp)
 3bb:	89 34 24             	mov    %esi,(%esp)
 3be:	e8 70 fe ff ff       	call   233 <write>
 3c3:	43                   	inc    %ebx
  for(i = 0; fmt[i]; i++){
 3c4:	8a 43 ff             	mov    -0x1(%ebx),%al
 3c7:	84 c0                	test   %al,%al
 3c9:	0f 84 81 00 00 00    	je     450 <printf+0xd4>
    c = fmt[i] & 0xff;
 3cf:	0f b6 c8             	movzbl %al,%ecx
    if(state == 0){
 3d2:	85 ff                	test   %edi,%edi
 3d4:	74 ca                	je     3a0 <printf+0x24>
      }
    } else if(state == '%'){
 3d6:	83 ff 25             	cmp    $0x25,%edi
 3d9:	75 e8                	jne    3c3 <printf+0x47>
      if(c == 'd'){
 3db:	83 f9 64             	cmp    $0x64,%ecx
 3de:	0f 84 14 01 00 00    	je     4f8 <printf+0x17c>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 3e4:	83 f9 78             	cmp    $0x78,%ecx
 3e7:	74 7b                	je     464 <printf+0xe8>
 3e9:	83 f9 70             	cmp    $0x70,%ecx
 3ec:	74 76                	je     464 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 3ee:	83 f9 73             	cmp    $0x73,%ecx
 3f1:	0f 84 91 00 00 00    	je     488 <printf+0x10c>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 3f7:	83 f9 63             	cmp    $0x63,%ecx
 3fa:	0f 84 cc 00 00 00    	je     4cc <printf+0x150>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 400:	83 f9 25             	cmp    $0x25,%ecx
 403:	0f 84 13 01 00 00    	je     51c <printf+0x1a0>
 409:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
  write(fd, &c, 1);
 40d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 414:	00 
 415:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 418:	89 44 24 04          	mov    %eax,0x4(%esp)
 41c:	89 34 24             	mov    %esi,(%esp)
 41f:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 422:	e8 0c fe ff ff       	call   233 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 427:	8b 4d d0             	mov    -0x30(%ebp),%ecx
 42a:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
 42d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 434:	00 
 435:	8d 55 e7             	lea    -0x19(%ebp),%edx
 438:	89 54 24 04          	mov    %edx,0x4(%esp)
 43c:	89 34 24             	mov    %esi,(%esp)
 43f:	e8 ef fd ff ff       	call   233 <write>
      }
      state = 0;
 444:	31 ff                	xor    %edi,%edi
 446:	43                   	inc    %ebx
  for(i = 0; fmt[i]; i++){
 447:	8a 43 ff             	mov    -0x1(%ebx),%al
 44a:	84 c0                	test   %al,%al
 44c:	75 81                	jne    3cf <printf+0x53>
 44e:	66 90                	xchg   %ax,%ax
    }
  }
}
 450:	83 c4 3c             	add    $0x3c,%esp
 453:	5b                   	pop    %ebx
 454:	5e                   	pop    %esi
 455:	5f                   	pop    %edi
 456:	5d                   	pop    %ebp
 457:	c3                   	ret    
        state = '%';
 458:	bf 25 00 00 00       	mov    $0x25,%edi
 45d:	e9 61 ff ff ff       	jmp    3c3 <printf+0x47>
 462:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 464:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 46b:	b9 10 00 00 00       	mov    $0x10,%ecx
 470:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 473:	8b 10                	mov    (%eax),%edx
 475:	89 f0                	mov    %esi,%eax
 477:	e8 80 fe ff ff       	call   2fc <printint>
        ap++;
 47c:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 480:	31 ff                	xor    %edi,%edi
        ap++;
 482:	e9 3c ff ff ff       	jmp    3c3 <printf+0x47>
 487:	90                   	nop
        s = (char*)*ap;
 488:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 48b:	8b 3a                	mov    (%edx),%edi
        ap++;
 48d:	83 c2 04             	add    $0x4,%edx
 490:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
 493:	85 ff                	test   %edi,%edi
 495:	0f 84 a3 00 00 00    	je     53e <printf+0x1c2>
        while(*s != 0){
 49b:	8a 07                	mov    (%edi),%al
 49d:	84 c0                	test   %al,%al
 49f:	74 24                	je     4c5 <printf+0x149>
 4a1:	8d 76 00             	lea    0x0(%esi),%esi
 4a4:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 4a7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4ae:	00 
 4af:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 4b2:	89 44 24 04          	mov    %eax,0x4(%esp)
 4b6:	89 34 24             	mov    %esi,(%esp)
 4b9:	e8 75 fd ff ff       	call   233 <write>
          s++;
 4be:	47                   	inc    %edi
        while(*s != 0){
 4bf:	8a 07                	mov    (%edi),%al
 4c1:	84 c0                	test   %al,%al
 4c3:	75 df                	jne    4a4 <printf+0x128>
      state = 0;
 4c5:	31 ff                	xor    %edi,%edi
 4c7:	e9 f7 fe ff ff       	jmp    3c3 <printf+0x47>
        putc(fd, *ap);
 4cc:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 4cf:	8b 02                	mov    (%edx),%eax
 4d1:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 4d4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4db:	00 
 4dc:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 4df:	89 44 24 04          	mov    %eax,0x4(%esp)
 4e3:	89 34 24             	mov    %esi,(%esp)
 4e6:	e8 48 fd ff ff       	call   233 <write>
        ap++;
 4eb:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 4ef:	31 ff                	xor    %edi,%edi
 4f1:	e9 cd fe ff ff       	jmp    3c3 <printf+0x47>
 4f6:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 4f8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 4ff:	b1 0a                	mov    $0xa,%cl
 501:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 504:	8b 10                	mov    (%eax),%edx
 506:	89 f0                	mov    %esi,%eax
 508:	e8 ef fd ff ff       	call   2fc <printint>
        ap++;
 50d:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 511:	66 31 ff             	xor    %di,%di
 514:	e9 aa fe ff ff       	jmp    3c3 <printf+0x47>
 519:	8d 76 00             	lea    0x0(%esi),%esi
 51c:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
  write(fd, &c, 1);
 520:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 527:	00 
 528:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 52b:	89 44 24 04          	mov    %eax,0x4(%esp)
 52f:	89 34 24             	mov    %esi,(%esp)
 532:	e8 fc fc ff ff       	call   233 <write>
      state = 0;
 537:	31 ff                	xor    %edi,%edi
 539:	e9 85 fe ff ff       	jmp    3c3 <printf+0x47>
          s = "(null)";
 53e:	bf 9e 06 00 00       	mov    $0x69e,%edi
 543:	e9 53 ff ff ff       	jmp    49b <printf+0x11f>

00000548 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 548:	55                   	push   %ebp
 549:	89 e5                	mov    %esp,%ebp
 54b:	57                   	push   %edi
 54c:	56                   	push   %esi
 54d:	53                   	push   %ebx
 54e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 551:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 554:	a1 38 09 00 00       	mov    0x938,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 559:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 55b:	39 d0                	cmp    %edx,%eax
 55d:	72 11                	jb     570 <free+0x28>
 55f:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 560:	39 c8                	cmp    %ecx,%eax
 562:	72 04                	jb     568 <free+0x20>
 564:	39 ca                	cmp    %ecx,%edx
 566:	72 10                	jb     578 <free+0x30>
 568:	89 c8                	mov    %ecx,%eax
 56a:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 56c:	39 d0                	cmp    %edx,%eax
 56e:	73 f0                	jae    560 <free+0x18>
 570:	39 ca                	cmp    %ecx,%edx
 572:	72 04                	jb     578 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 574:	39 c8                	cmp    %ecx,%eax
 576:	72 f0                	jb     568 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 578:	8b 73 fc             	mov    -0x4(%ebx),%esi
 57b:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 57e:	39 cf                	cmp    %ecx,%edi
 580:	74 1a                	je     59c <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 582:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 585:	8b 48 04             	mov    0x4(%eax),%ecx
 588:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 58b:	39 f2                	cmp    %esi,%edx
 58d:	74 24                	je     5b3 <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 58f:	89 10                	mov    %edx,(%eax)
  freep = p;
 591:	a3 38 09 00 00       	mov    %eax,0x938
}
 596:	5b                   	pop    %ebx
 597:	5e                   	pop    %esi
 598:	5f                   	pop    %edi
 599:	5d                   	pop    %ebp
 59a:	c3                   	ret    
 59b:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 59c:	03 71 04             	add    0x4(%ecx),%esi
 59f:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5a2:	8b 08                	mov    (%eax),%ecx
 5a4:	8b 09                	mov    (%ecx),%ecx
 5a6:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5a9:	8b 48 04             	mov    0x4(%eax),%ecx
 5ac:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 5af:	39 f2                	cmp    %esi,%edx
 5b1:	75 dc                	jne    58f <free+0x47>
    p->s.size += bp->s.size;
 5b3:	03 4b fc             	add    -0x4(%ebx),%ecx
 5b6:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 5b9:	8b 53 f8             	mov    -0x8(%ebx),%edx
 5bc:	89 10                	mov    %edx,(%eax)
  freep = p;
 5be:	a3 38 09 00 00       	mov    %eax,0x938
}
 5c3:	5b                   	pop    %ebx
 5c4:	5e                   	pop    %esi
 5c5:	5f                   	pop    %edi
 5c6:	5d                   	pop    %ebp
 5c7:	c3                   	ret    

000005c8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 5c8:	55                   	push   %ebp
 5c9:	89 e5                	mov    %esp,%ebp
 5cb:	57                   	push   %edi
 5cc:	56                   	push   %esi
 5cd:	53                   	push   %ebx
 5ce:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5d1:	8b 75 08             	mov    0x8(%ebp),%esi
 5d4:	83 c6 07             	add    $0x7,%esi
 5d7:	c1 ee 03             	shr    $0x3,%esi
 5da:	46                   	inc    %esi
  if((prevp = freep) == 0){
 5db:	8b 15 38 09 00 00    	mov    0x938,%edx
 5e1:	85 d2                	test   %edx,%edx
 5e3:	0f 84 8d 00 00 00    	je     676 <malloc+0xae>
 5e9:	8b 02                	mov    (%edx),%eax
 5eb:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 5ee:	39 ce                	cmp    %ecx,%esi
 5f0:	76 52                	jbe    644 <malloc+0x7c>
 5f2:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 5f9:	eb 0a                	jmp    605 <malloc+0x3d>
 5fb:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5fc:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 5fe:	8b 48 04             	mov    0x4(%eax),%ecx
 601:	39 ce                	cmp    %ecx,%esi
 603:	76 3f                	jbe    644 <malloc+0x7c>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 605:	89 c2                	mov    %eax,%edx
 607:	3b 05 38 09 00 00    	cmp    0x938,%eax
 60d:	75 ed                	jne    5fc <malloc+0x34>
  if(nu < 4096)
 60f:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 615:	76 4d                	jbe    664 <malloc+0x9c>
 617:	89 d8                	mov    %ebx,%eax
 619:	89 f7                	mov    %esi,%edi
  p = sbrk(nu * sizeof(Header));
 61b:	89 04 24             	mov    %eax,(%esp)
 61e:	e8 78 fc ff ff       	call   29b <sbrk>
  if(p == (char*)-1)
 623:	83 f8 ff             	cmp    $0xffffffff,%eax
 626:	74 18                	je     640 <malloc+0x78>
  hp->s.size = nu;
 628:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 62b:	83 c0 08             	add    $0x8,%eax
 62e:	89 04 24             	mov    %eax,(%esp)
 631:	e8 12 ff ff ff       	call   548 <free>
  return freep;
 636:	8b 15 38 09 00 00    	mov    0x938,%edx
      if((p = morecore(nunits)) == 0)
 63c:	85 d2                	test   %edx,%edx
 63e:	75 bc                	jne    5fc <malloc+0x34>
        return 0;
 640:	31 c0                	xor    %eax,%eax
 642:	eb 18                	jmp    65c <malloc+0x94>
      if(p->s.size == nunits)
 644:	39 ce                	cmp    %ecx,%esi
 646:	74 28                	je     670 <malloc+0xa8>
        p->s.size -= nunits;
 648:	29 f1                	sub    %esi,%ecx
 64a:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 64d:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 650:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 653:	89 15 38 09 00 00    	mov    %edx,0x938
      return (void*)(p + 1);
 659:	83 c0 08             	add    $0x8,%eax
  }
}
 65c:	83 c4 1c             	add    $0x1c,%esp
 65f:	5b                   	pop    %ebx
 660:	5e                   	pop    %esi
 661:	5f                   	pop    %edi
 662:	5d                   	pop    %ebp
 663:	c3                   	ret    
  if(nu < 4096)
 664:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 669:	bf 00 10 00 00       	mov    $0x1000,%edi
 66e:	eb ab                	jmp    61b <malloc+0x53>
        prevp->s.ptr = p->s.ptr;
 670:	8b 08                	mov    (%eax),%ecx
 672:	89 0a                	mov    %ecx,(%edx)
 674:	eb dd                	jmp    653 <malloc+0x8b>
    base.s.ptr = freep = prevp = &base;
 676:	c7 05 38 09 00 00 3c 	movl   $0x93c,0x938
 67d:	09 00 00 
 680:	c7 05 3c 09 00 00 3c 	movl   $0x93c,0x93c
 687:	09 00 00 
    base.s.size = 0;
 68a:	c7 05 40 09 00 00 00 	movl   $0x0,0x940
 691:	00 00 00 
 694:	b8 3c 09 00 00       	mov    $0x93c,%eax
 699:	e9 54 ff ff ff       	jmp    5f2 <malloc+0x2a>
