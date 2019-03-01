
_lotterytest：     文件格式 elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"
#include "lot.h"

int main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
    settickets(300);
   9:	c7 04 24 2c 01 00 00 	movl   $0x12c,(%esp)
  10:	e8 aa 02 00 00       	call   2bf <settickets>
    sleep(5);
  15:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
  1c:	e8 76 02 00 00       	call   297 <sleep>
  21:	ba f8 a7 00 00       	mov    $0xa7f8,%edx
  26:	66 90                	xchg   %ax,%ax
    int i,k;
    const int loop=43000;
    //int result;
    for(i=0;i<loop;i++)
    {
        asm("nop"); //in order to prevent the compiler from optimizing the for loop
  28:	90                   	nop
  29:	b8 f8 a7 00 00       	mov    $0xa7f8,%eax
  2e:	66 90                	xchg   %ax,%ax
        for(k=0;k<loop;k++)
        {
            asm("nop");
  30:	90                   	nop
        for(k=0;k<loop;k++)
  31:	48                   	dec    %eax
  32:	75 fc                	jne    30 <main+0x30>
    for(i=0;i<loop;i++)
  34:	4a                   	dec    %edx
  35:	75 f1                	jne    28 <main+0x28>
        }
    }
    //result = getsheltime();
    //printf(1,"Prog1: !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!%d\n",result);
    exit();
  37:	e8 cb 01 00 00       	call   207 <exit>

0000003c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  3c:	55                   	push   %ebp
  3d:	89 e5                	mov    %esp,%ebp
  3f:	53                   	push   %ebx
  40:	8b 45 08             	mov    0x8(%ebp),%eax
  43:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  46:	89 c2                	mov    %eax,%edx
  48:	8a 19                	mov    (%ecx),%bl
  4a:	88 1a                	mov    %bl,(%edx)
  4c:	42                   	inc    %edx
  4d:	41                   	inc    %ecx
  4e:	84 db                	test   %bl,%bl
  50:	75 f6                	jne    48 <strcpy+0xc>
    ;
  return os;
}
  52:	5b                   	pop    %ebx
  53:	5d                   	pop    %ebp
  54:	c3                   	ret    
  55:	8d 76 00             	lea    0x0(%esi),%esi

00000058 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  58:	55                   	push   %ebp
  59:	89 e5                	mov    %esp,%ebp
  5b:	56                   	push   %esi
  5c:	53                   	push   %ebx
  5d:	8b 55 08             	mov    0x8(%ebp),%edx
  60:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  63:	0f b6 02             	movzbl (%edx),%eax
  66:	0f b6 19             	movzbl (%ecx),%ebx
  69:	84 c0                	test   %al,%al
  6b:	75 14                	jne    81 <strcmp+0x29>
  6d:	eb 1d                	jmp    8c <strcmp+0x34>
  6f:	90                   	nop
    p++, q++;
  70:	42                   	inc    %edx
  71:	8d 71 01             	lea    0x1(%ecx),%esi
  while(*p && *p == *q)
  74:	0f b6 02             	movzbl (%edx),%eax
  77:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  7b:	84 c0                	test   %al,%al
  7d:	74 0d                	je     8c <strcmp+0x34>
    p++, q++;
  7f:	89 f1                	mov    %esi,%ecx
  while(*p && *p == *q)
  81:	38 d8                	cmp    %bl,%al
  83:	74 eb                	je     70 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
  85:	29 d8                	sub    %ebx,%eax
}
  87:	5b                   	pop    %ebx
  88:	5e                   	pop    %esi
  89:	5d                   	pop    %ebp
  8a:	c3                   	ret    
  8b:	90                   	nop
  while(*p && *p == *q)
  8c:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  8e:	29 d8                	sub    %ebx,%eax
}
  90:	5b                   	pop    %ebx
  91:	5e                   	pop    %esi
  92:	5d                   	pop    %ebp
  93:	c3                   	ret    

00000094 <strlen>:

uint
strlen(char *s)
{
  94:	55                   	push   %ebp
  95:	89 e5                	mov    %esp,%ebp
  97:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  9a:	80 39 00             	cmpb   $0x0,(%ecx)
  9d:	74 10                	je     af <strlen+0x1b>
  9f:	31 d2                	xor    %edx,%edx
  a1:	8d 76 00             	lea    0x0(%esi),%esi
  a4:	42                   	inc    %edx
  a5:	89 d0                	mov    %edx,%eax
  a7:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  ab:	75 f7                	jne    a4 <strlen+0x10>
    ;
  return n;
}
  ad:	5d                   	pop    %ebp
  ae:	c3                   	ret    
  for(n = 0; s[n]; n++)
  af:	31 c0                	xor    %eax,%eax
}
  b1:	5d                   	pop    %ebp
  b2:	c3                   	ret    
  b3:	90                   	nop

000000b4 <memset>:

void*
memset(void *dst, int c, uint n)
{
  b4:	55                   	push   %ebp
  b5:	89 e5                	mov    %esp,%ebp
  b7:	57                   	push   %edi
  b8:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  bb:	89 d7                	mov    %edx,%edi
  bd:	8b 4d 10             	mov    0x10(%ebp),%ecx
  c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  c3:	fc                   	cld    
  c4:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  c6:	89 d0                	mov    %edx,%eax
  c8:	5f                   	pop    %edi
  c9:	5d                   	pop    %ebp
  ca:	c3                   	ret    
  cb:	90                   	nop

000000cc <strchr>:

char*
strchr(const char *s, char c)
{
  cc:	55                   	push   %ebp
  cd:	89 e5                	mov    %esp,%ebp
  cf:	8b 45 08             	mov    0x8(%ebp),%eax
  d2:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
  d5:	8a 10                	mov    (%eax),%dl
  d7:	84 d2                	test   %dl,%dl
  d9:	75 0c                	jne    e7 <strchr+0x1b>
  db:	eb 13                	jmp    f0 <strchr+0x24>
  dd:	8d 76 00             	lea    0x0(%esi),%esi
  e0:	40                   	inc    %eax
  e1:	8a 10                	mov    (%eax),%dl
  e3:	84 d2                	test   %dl,%dl
  e5:	74 09                	je     f0 <strchr+0x24>
    if(*s == c)
  e7:	38 ca                	cmp    %cl,%dl
  e9:	75 f5                	jne    e0 <strchr+0x14>
      return (char*)s;
  return 0;
}
  eb:	5d                   	pop    %ebp
  ec:	c3                   	ret    
  ed:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
  f0:	31 c0                	xor    %eax,%eax
}
  f2:	5d                   	pop    %ebp
  f3:	c3                   	ret    

000000f4 <gets>:

char*
gets(char *buf, int max)
{
  f4:	55                   	push   %ebp
  f5:	89 e5                	mov    %esp,%ebp
  f7:	57                   	push   %edi
  f8:	56                   	push   %esi
  f9:	53                   	push   %ebx
  fa:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
  fd:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
  ff:	8d 7d e7             	lea    -0x19(%ebp),%edi
 102:	66 90                	xchg   %ax,%ax
  for(i=0; i+1 < max; ){
 104:	8d 73 01             	lea    0x1(%ebx),%esi
 107:	3b 75 0c             	cmp    0xc(%ebp),%esi
 10a:	7d 40                	jge    14c <gets+0x58>
    cc = read(0, &c, 1);
 10c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 113:	00 
 114:	89 7c 24 04          	mov    %edi,0x4(%esp)
 118:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 11f:	e8 fb 00 00 00       	call   21f <read>
    if(cc < 1)
 124:	85 c0                	test   %eax,%eax
 126:	7e 24                	jle    14c <gets+0x58>
      break;
    buf[i++] = c;
 128:	8a 45 e7             	mov    -0x19(%ebp),%al
 12b:	8b 55 08             	mov    0x8(%ebp),%edx
 12e:	88 44 32 ff          	mov    %al,-0x1(%edx,%esi,1)
    if(c == '\n' || c == '\r')
 132:	3c 0a                	cmp    $0xa,%al
 134:	74 06                	je     13c <gets+0x48>
 136:	89 f3                	mov    %esi,%ebx
 138:	3c 0d                	cmp    $0xd,%al
 13a:	75 c8                	jne    104 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 13c:	8b 45 08             	mov    0x8(%ebp),%eax
 13f:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 143:	83 c4 2c             	add    $0x2c,%esp
 146:	5b                   	pop    %ebx
 147:	5e                   	pop    %esi
 148:	5f                   	pop    %edi
 149:	5d                   	pop    %ebp
 14a:	c3                   	ret    
 14b:	90                   	nop
    if(cc < 1)
 14c:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 14e:	8b 45 08             	mov    0x8(%ebp),%eax
 151:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 155:	83 c4 2c             	add    $0x2c,%esp
 158:	5b                   	pop    %ebx
 159:	5e                   	pop    %esi
 15a:	5f                   	pop    %edi
 15b:	5d                   	pop    %ebp
 15c:	c3                   	ret    
 15d:	8d 76 00             	lea    0x0(%esi),%esi

00000160 <stat>:

int
stat(char *n, struct stat *st)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	56                   	push   %esi
 164:	53                   	push   %ebx
 165:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 168:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 16f:	00 
 170:	8b 45 08             	mov    0x8(%ebp),%eax
 173:	89 04 24             	mov    %eax,(%esp)
 176:	e8 cc 00 00 00       	call   247 <open>
 17b:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 17d:	85 c0                	test   %eax,%eax
 17f:	78 23                	js     1a4 <stat+0x44>
    return -1;
  r = fstat(fd, st);
 181:	8b 45 0c             	mov    0xc(%ebp),%eax
 184:	89 44 24 04          	mov    %eax,0x4(%esp)
 188:	89 1c 24             	mov    %ebx,(%esp)
 18b:	e8 cf 00 00 00       	call   25f <fstat>
 190:	89 c6                	mov    %eax,%esi
  close(fd);
 192:	89 1c 24             	mov    %ebx,(%esp)
 195:	e8 95 00 00 00       	call   22f <close>
  return r;
}
 19a:	89 f0                	mov    %esi,%eax
 19c:	83 c4 10             	add    $0x10,%esp
 19f:	5b                   	pop    %ebx
 1a0:	5e                   	pop    %esi
 1a1:	5d                   	pop    %ebp
 1a2:	c3                   	ret    
 1a3:	90                   	nop
    return -1;
 1a4:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1a9:	eb ef                	jmp    19a <stat+0x3a>
 1ab:	90                   	nop

000001ac <atoi>:

int
atoi(const char *s)
{
 1ac:	55                   	push   %ebp
 1ad:	89 e5                	mov    %esp,%ebp
 1af:	53                   	push   %ebx
 1b0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1b3:	0f be 11             	movsbl (%ecx),%edx
 1b6:	8d 42 d0             	lea    -0x30(%edx),%eax
 1b9:	3c 09                	cmp    $0x9,%al
 1bb:	b8 00 00 00 00       	mov    $0x0,%eax
 1c0:	77 15                	ja     1d7 <atoi+0x2b>
 1c2:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 1c4:	8d 04 80             	lea    (%eax,%eax,4),%eax
 1c7:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
 1cb:	41                   	inc    %ecx
  while('0' <= *s && *s <= '9')
 1cc:	0f be 11             	movsbl (%ecx),%edx
 1cf:	8d 5a d0             	lea    -0x30(%edx),%ebx
 1d2:	80 fb 09             	cmp    $0x9,%bl
 1d5:	76 ed                	jbe    1c4 <atoi+0x18>
  return n;
}
 1d7:	5b                   	pop    %ebx
 1d8:	5d                   	pop    %ebp
 1d9:	c3                   	ret    
 1da:	66 90                	xchg   %ax,%ax

000001dc <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 1dc:	55                   	push   %ebp
 1dd:	89 e5                	mov    %esp,%ebp
 1df:	56                   	push   %esi
 1e0:	53                   	push   %ebx
 1e1:	8b 45 08             	mov    0x8(%ebp),%eax
 1e4:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1e7:	8b 75 10             	mov    0x10(%ebp),%esi
memmove(void *vdst, void *vsrc, int n)
 1ea:	31 d2                	xor    %edx,%edx
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1ec:	85 f6                	test   %esi,%esi
 1ee:	7e 0b                	jle    1fb <memmove+0x1f>
    *dst++ = *src++;
 1f0:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 1f3:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 1f6:	42                   	inc    %edx
  while(n-- > 0)
 1f7:	39 f2                	cmp    %esi,%edx
 1f9:	75 f5                	jne    1f0 <memmove+0x14>
  return vdst;
}
 1fb:	5b                   	pop    %ebx
 1fc:	5e                   	pop    %esi
 1fd:	5d                   	pop    %ebp
 1fe:	c3                   	ret    

000001ff <fork>:
 1ff:	b8 01 00 00 00       	mov    $0x1,%eax
 204:	cd 40                	int    $0x40
 206:	c3                   	ret    

00000207 <exit>:
 207:	b8 02 00 00 00       	mov    $0x2,%eax
 20c:	cd 40                	int    $0x40
 20e:	c3                   	ret    

0000020f <wait>:
 20f:	b8 03 00 00 00       	mov    $0x3,%eax
 214:	cd 40                	int    $0x40
 216:	c3                   	ret    

00000217 <pipe>:
 217:	b8 04 00 00 00       	mov    $0x4,%eax
 21c:	cd 40                	int    $0x40
 21e:	c3                   	ret    

0000021f <read>:
 21f:	b8 05 00 00 00       	mov    $0x5,%eax
 224:	cd 40                	int    $0x40
 226:	c3                   	ret    

00000227 <write>:
 227:	b8 10 00 00 00       	mov    $0x10,%eax
 22c:	cd 40                	int    $0x40
 22e:	c3                   	ret    

0000022f <close>:
 22f:	b8 15 00 00 00       	mov    $0x15,%eax
 234:	cd 40                	int    $0x40
 236:	c3                   	ret    

00000237 <kill>:
 237:	b8 06 00 00 00       	mov    $0x6,%eax
 23c:	cd 40                	int    $0x40
 23e:	c3                   	ret    

0000023f <exec>:
 23f:	b8 07 00 00 00       	mov    $0x7,%eax
 244:	cd 40                	int    $0x40
 246:	c3                   	ret    

00000247 <open>:
 247:	b8 0f 00 00 00       	mov    $0xf,%eax
 24c:	cd 40                	int    $0x40
 24e:	c3                   	ret    

0000024f <mknod>:
 24f:	b8 11 00 00 00       	mov    $0x11,%eax
 254:	cd 40                	int    $0x40
 256:	c3                   	ret    

00000257 <unlink>:
 257:	b8 12 00 00 00       	mov    $0x12,%eax
 25c:	cd 40                	int    $0x40
 25e:	c3                   	ret    

0000025f <fstat>:
 25f:	b8 08 00 00 00       	mov    $0x8,%eax
 264:	cd 40                	int    $0x40
 266:	c3                   	ret    

00000267 <link>:
 267:	b8 13 00 00 00       	mov    $0x13,%eax
 26c:	cd 40                	int    $0x40
 26e:	c3                   	ret    

0000026f <mkdir>:
 26f:	b8 14 00 00 00       	mov    $0x14,%eax
 274:	cd 40                	int    $0x40
 276:	c3                   	ret    

00000277 <chdir>:
 277:	b8 09 00 00 00       	mov    $0x9,%eax
 27c:	cd 40                	int    $0x40
 27e:	c3                   	ret    

0000027f <dup>:
 27f:	b8 0a 00 00 00       	mov    $0xa,%eax
 284:	cd 40                	int    $0x40
 286:	c3                   	ret    

00000287 <getpid>:
 287:	b8 0b 00 00 00       	mov    $0xb,%eax
 28c:	cd 40                	int    $0x40
 28e:	c3                   	ret    

0000028f <sbrk>:
 28f:	b8 0c 00 00 00       	mov    $0xc,%eax
 294:	cd 40                	int    $0x40
 296:	c3                   	ret    

00000297 <sleep>:
 297:	b8 0d 00 00 00       	mov    $0xd,%eax
 29c:	cd 40                	int    $0x40
 29e:	c3                   	ret    

0000029f <uptime>:
 29f:	b8 0e 00 00 00       	mov    $0xe,%eax
 2a4:	cd 40                	int    $0x40
 2a6:	c3                   	ret    

000002a7 <getprocnum>:
 2a7:	b8 16 00 00 00       	mov    $0x16,%eax
 2ac:	cd 40                	int    $0x40
 2ae:	c3                   	ret    

000002af <mempagenum>:
 2af:	b8 17 00 00 00       	mov    $0x17,%eax
 2b4:	cd 40                	int    $0x40
 2b6:	c3                   	ret    

000002b7 <syscallnum>:
 2b7:	b8 18 00 00 00       	mov    $0x18,%eax
 2bc:	cd 40                	int    $0x40
 2be:	c3                   	ret    

000002bf <settickets>:
 2bf:	b8 19 00 00 00       	mov    $0x19,%eax
 2c4:	cd 40                	int    $0x40
 2c6:	c3                   	ret    

000002c7 <getsheltime>:
 2c7:	b8 1a 00 00 00       	mov    $0x1a,%eax
 2cc:	cd 40                	int    $0x40
 2ce:	c3                   	ret    

000002cf <setstride>:
 2cf:	b8 1b 00 00 00       	mov    $0x1b,%eax
 2d4:	cd 40                	int    $0x40
 2d6:	c3                   	ret    

000002d7 <setpass>:
 2d7:	b8 1c 00 00 00       	mov    $0x1c,%eax
 2dc:	cd 40                	int    $0x40
 2de:	c3                   	ret    

000002df <join>:
 2df:	b8 1d 00 00 00       	mov    $0x1d,%eax
 2e4:	cd 40                	int    $0x40
 2e6:	c3                   	ret    

000002e7 <clone1>:
 2e7:	b8 1e 00 00 00       	mov    $0x1e,%eax
 2ec:	cd 40                	int    $0x40
 2ee:	c3                   	ret    
 2ef:	90                   	nop

000002f0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	57                   	push   %edi
 2f4:	56                   	push   %esi
 2f5:	53                   	push   %ebx
 2f6:	83 ec 3c             	sub    $0x3c,%esp
 2f9:	89 c7                	mov    %eax,%edi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 2fb:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 2fd:	8b 5d 08             	mov    0x8(%ebp),%ebx
 300:	85 db                	test   %ebx,%ebx
 302:	74 04                	je     308 <printint+0x18>
 304:	85 d2                	test   %edx,%edx
 306:	78 5d                	js     365 <printint+0x75>
  neg = 0;
 308:	31 db                	xor    %ebx,%ebx
  } else {
    x = xx;
  }

  i = 0;
 30a:	31 f6                	xor    %esi,%esi
 30c:	eb 04                	jmp    312 <printint+0x22>
 30e:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 310:	89 d6                	mov    %edx,%esi
 312:	31 d2                	xor    %edx,%edx
 314:	f7 f1                	div    %ecx
 316:	8a 92 99 06 00 00    	mov    0x699(%edx),%dl
 31c:	88 54 35 d8          	mov    %dl,-0x28(%ebp,%esi,1)
 320:	8d 56 01             	lea    0x1(%esi),%edx
  }while((x /= base) != 0);
 323:	85 c0                	test   %eax,%eax
 325:	75 e9                	jne    310 <printint+0x20>
  if(neg)
 327:	85 db                	test   %ebx,%ebx
 329:	74 08                	je     333 <printint+0x43>
    buf[i++] = '-';
 32b:	c6 44 15 d8 2d       	movb   $0x2d,-0x28(%ebp,%edx,1)
 330:	8d 56 02             	lea    0x2(%esi),%edx

  while(--i >= 0)
 333:	8d 5a ff             	lea    -0x1(%edx),%ebx
 336:	8d 75 d7             	lea    -0x29(%ebp),%esi
 339:	8d 76 00             	lea    0x0(%esi),%esi
 33c:	8a 44 1d d8          	mov    -0x28(%ebp,%ebx,1),%al
 340:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 343:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 34a:	00 
 34b:	89 74 24 04          	mov    %esi,0x4(%esp)
 34f:	89 3c 24             	mov    %edi,(%esp)
 352:	e8 d0 fe ff ff       	call   227 <write>
  while(--i >= 0)
 357:	4b                   	dec    %ebx
 358:	83 fb ff             	cmp    $0xffffffff,%ebx
 35b:	75 df                	jne    33c <printint+0x4c>
    putc(fd, buf[i]);
}
 35d:	83 c4 3c             	add    $0x3c,%esp
 360:	5b                   	pop    %ebx
 361:	5e                   	pop    %esi
 362:	5f                   	pop    %edi
 363:	5d                   	pop    %ebp
 364:	c3                   	ret    
    x = -xx;
 365:	f7 d8                	neg    %eax
    neg = 1;
 367:	bb 01 00 00 00       	mov    $0x1,%ebx
    x = -xx;
 36c:	eb 9c                	jmp    30a <printint+0x1a>
 36e:	66 90                	xchg   %ax,%ax

00000370 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	57                   	push   %edi
 374:	56                   	push   %esi
 375:	53                   	push   %ebx
 376:	83 ec 3c             	sub    $0x3c,%esp
 379:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 37c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 37f:	8a 03                	mov    (%ebx),%al
 381:	84 c0                	test   %al,%al
 383:	0f 84 bb 00 00 00    	je     444 <printf+0xd4>
printf(int fd, char *fmt, ...)
 389:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
 38a:	8d 55 10             	lea    0x10(%ebp),%edx
 38d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  state = 0;
 390:	31 ff                	xor    %edi,%edi
 392:	eb 2f                	jmp    3c3 <printf+0x53>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 394:	83 f9 25             	cmp    $0x25,%ecx
 397:	0f 84 af 00 00 00    	je     44c <printf+0xdc>
        state = '%';
      } else {
        putc(fd, c);
 39d:	88 4d e2             	mov    %cl,-0x1e(%ebp)
  write(fd, &c, 1);
 3a0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3a7:	00 
 3a8:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 3ab:	89 44 24 04          	mov    %eax,0x4(%esp)
 3af:	89 34 24             	mov    %esi,(%esp)
 3b2:	e8 70 fe ff ff       	call   227 <write>
 3b7:	43                   	inc    %ebx
  for(i = 0; fmt[i]; i++){
 3b8:	8a 43 ff             	mov    -0x1(%ebx),%al
 3bb:	84 c0                	test   %al,%al
 3bd:	0f 84 81 00 00 00    	je     444 <printf+0xd4>
    c = fmt[i] & 0xff;
 3c3:	0f b6 c8             	movzbl %al,%ecx
    if(state == 0){
 3c6:	85 ff                	test   %edi,%edi
 3c8:	74 ca                	je     394 <printf+0x24>
      }
    } else if(state == '%'){
 3ca:	83 ff 25             	cmp    $0x25,%edi
 3cd:	75 e8                	jne    3b7 <printf+0x47>
      if(c == 'd'){
 3cf:	83 f9 64             	cmp    $0x64,%ecx
 3d2:	0f 84 14 01 00 00    	je     4ec <printf+0x17c>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 3d8:	83 f9 78             	cmp    $0x78,%ecx
 3db:	74 7b                	je     458 <printf+0xe8>
 3dd:	83 f9 70             	cmp    $0x70,%ecx
 3e0:	74 76                	je     458 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 3e2:	83 f9 73             	cmp    $0x73,%ecx
 3e5:	0f 84 91 00 00 00    	je     47c <printf+0x10c>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 3eb:	83 f9 63             	cmp    $0x63,%ecx
 3ee:	0f 84 cc 00 00 00    	je     4c0 <printf+0x150>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 3f4:	83 f9 25             	cmp    $0x25,%ecx
 3f7:	0f 84 13 01 00 00    	je     510 <printf+0x1a0>
 3fd:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
  write(fd, &c, 1);
 401:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 408:	00 
 409:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 40c:	89 44 24 04          	mov    %eax,0x4(%esp)
 410:	89 34 24             	mov    %esi,(%esp)
 413:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 416:	e8 0c fe ff ff       	call   227 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 41b:	8b 4d d0             	mov    -0x30(%ebp),%ecx
 41e:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
 421:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 428:	00 
 429:	8d 55 e7             	lea    -0x19(%ebp),%edx
 42c:	89 54 24 04          	mov    %edx,0x4(%esp)
 430:	89 34 24             	mov    %esi,(%esp)
 433:	e8 ef fd ff ff       	call   227 <write>
      }
      state = 0;
 438:	31 ff                	xor    %edi,%edi
 43a:	43                   	inc    %ebx
  for(i = 0; fmt[i]; i++){
 43b:	8a 43 ff             	mov    -0x1(%ebx),%al
 43e:	84 c0                	test   %al,%al
 440:	75 81                	jne    3c3 <printf+0x53>
 442:	66 90                	xchg   %ax,%ax
    }
  }
}
 444:	83 c4 3c             	add    $0x3c,%esp
 447:	5b                   	pop    %ebx
 448:	5e                   	pop    %esi
 449:	5f                   	pop    %edi
 44a:	5d                   	pop    %ebp
 44b:	c3                   	ret    
        state = '%';
 44c:	bf 25 00 00 00       	mov    $0x25,%edi
 451:	e9 61 ff ff ff       	jmp    3b7 <printf+0x47>
 456:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 458:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 45f:	b9 10 00 00 00       	mov    $0x10,%ecx
 464:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 467:	8b 10                	mov    (%eax),%edx
 469:	89 f0                	mov    %esi,%eax
 46b:	e8 80 fe ff ff       	call   2f0 <printint>
        ap++;
 470:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 474:	31 ff                	xor    %edi,%edi
        ap++;
 476:	e9 3c ff ff ff       	jmp    3b7 <printf+0x47>
 47b:	90                   	nop
        s = (char*)*ap;
 47c:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 47f:	8b 3a                	mov    (%edx),%edi
        ap++;
 481:	83 c2 04             	add    $0x4,%edx
 484:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
 487:	85 ff                	test   %edi,%edi
 489:	0f 84 a3 00 00 00    	je     532 <printf+0x1c2>
        while(*s != 0){
 48f:	8a 07                	mov    (%edi),%al
 491:	84 c0                	test   %al,%al
 493:	74 24                	je     4b9 <printf+0x149>
 495:	8d 76 00             	lea    0x0(%esi),%esi
 498:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 49b:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4a2:	00 
 4a3:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 4a6:	89 44 24 04          	mov    %eax,0x4(%esp)
 4aa:	89 34 24             	mov    %esi,(%esp)
 4ad:	e8 75 fd ff ff       	call   227 <write>
          s++;
 4b2:	47                   	inc    %edi
        while(*s != 0){
 4b3:	8a 07                	mov    (%edi),%al
 4b5:	84 c0                	test   %al,%al
 4b7:	75 df                	jne    498 <printf+0x128>
      state = 0;
 4b9:	31 ff                	xor    %edi,%edi
 4bb:	e9 f7 fe ff ff       	jmp    3b7 <printf+0x47>
        putc(fd, *ap);
 4c0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 4c3:	8b 02                	mov    (%edx),%eax
 4c5:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 4c8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4cf:	00 
 4d0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 4d3:	89 44 24 04          	mov    %eax,0x4(%esp)
 4d7:	89 34 24             	mov    %esi,(%esp)
 4da:	e8 48 fd ff ff       	call   227 <write>
        ap++;
 4df:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 4e3:	31 ff                	xor    %edi,%edi
 4e5:	e9 cd fe ff ff       	jmp    3b7 <printf+0x47>
 4ea:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 4ec:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 4f3:	b1 0a                	mov    $0xa,%cl
 4f5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 4f8:	8b 10                	mov    (%eax),%edx
 4fa:	89 f0                	mov    %esi,%eax
 4fc:	e8 ef fd ff ff       	call   2f0 <printint>
        ap++;
 501:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 505:	66 31 ff             	xor    %di,%di
 508:	e9 aa fe ff ff       	jmp    3b7 <printf+0x47>
 50d:	8d 76 00             	lea    0x0(%esi),%esi
 510:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
  write(fd, &c, 1);
 514:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 51b:	00 
 51c:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 51f:	89 44 24 04          	mov    %eax,0x4(%esp)
 523:	89 34 24             	mov    %esi,(%esp)
 526:	e8 fc fc ff ff       	call   227 <write>
      state = 0;
 52b:	31 ff                	xor    %edi,%edi
 52d:	e9 85 fe ff ff       	jmp    3b7 <printf+0x47>
          s = "(null)";
 532:	bf 92 06 00 00       	mov    $0x692,%edi
 537:	e9 53 ff ff ff       	jmp    48f <printf+0x11f>

0000053c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 53c:	55                   	push   %ebp
 53d:	89 e5                	mov    %esp,%ebp
 53f:	57                   	push   %edi
 540:	56                   	push   %esi
 541:	53                   	push   %ebx
 542:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 545:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 548:	a1 2c 09 00 00       	mov    0x92c,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 54d:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 54f:	39 d0                	cmp    %edx,%eax
 551:	72 11                	jb     564 <free+0x28>
 553:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 554:	39 c8                	cmp    %ecx,%eax
 556:	72 04                	jb     55c <free+0x20>
 558:	39 ca                	cmp    %ecx,%edx
 55a:	72 10                	jb     56c <free+0x30>
 55c:	89 c8                	mov    %ecx,%eax
 55e:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 560:	39 d0                	cmp    %edx,%eax
 562:	73 f0                	jae    554 <free+0x18>
 564:	39 ca                	cmp    %ecx,%edx
 566:	72 04                	jb     56c <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 568:	39 c8                	cmp    %ecx,%eax
 56a:	72 f0                	jb     55c <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 56c:	8b 73 fc             	mov    -0x4(%ebx),%esi
 56f:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 572:	39 cf                	cmp    %ecx,%edi
 574:	74 1a                	je     590 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 576:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 579:	8b 48 04             	mov    0x4(%eax),%ecx
 57c:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 57f:	39 f2                	cmp    %esi,%edx
 581:	74 24                	je     5a7 <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 583:	89 10                	mov    %edx,(%eax)
  freep = p;
 585:	a3 2c 09 00 00       	mov    %eax,0x92c
}
 58a:	5b                   	pop    %ebx
 58b:	5e                   	pop    %esi
 58c:	5f                   	pop    %edi
 58d:	5d                   	pop    %ebp
 58e:	c3                   	ret    
 58f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 590:	03 71 04             	add    0x4(%ecx),%esi
 593:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 596:	8b 08                	mov    (%eax),%ecx
 598:	8b 09                	mov    (%ecx),%ecx
 59a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 59d:	8b 48 04             	mov    0x4(%eax),%ecx
 5a0:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 5a3:	39 f2                	cmp    %esi,%edx
 5a5:	75 dc                	jne    583 <free+0x47>
    p->s.size += bp->s.size;
 5a7:	03 4b fc             	add    -0x4(%ebx),%ecx
 5aa:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 5ad:	8b 53 f8             	mov    -0x8(%ebx),%edx
 5b0:	89 10                	mov    %edx,(%eax)
  freep = p;
 5b2:	a3 2c 09 00 00       	mov    %eax,0x92c
}
 5b7:	5b                   	pop    %ebx
 5b8:	5e                   	pop    %esi
 5b9:	5f                   	pop    %edi
 5ba:	5d                   	pop    %ebp
 5bb:	c3                   	ret    

000005bc <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 5bc:	55                   	push   %ebp
 5bd:	89 e5                	mov    %esp,%ebp
 5bf:	57                   	push   %edi
 5c0:	56                   	push   %esi
 5c1:	53                   	push   %ebx
 5c2:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5c5:	8b 75 08             	mov    0x8(%ebp),%esi
 5c8:	83 c6 07             	add    $0x7,%esi
 5cb:	c1 ee 03             	shr    $0x3,%esi
 5ce:	46                   	inc    %esi
  if((prevp = freep) == 0){
 5cf:	8b 15 2c 09 00 00    	mov    0x92c,%edx
 5d5:	85 d2                	test   %edx,%edx
 5d7:	0f 84 8d 00 00 00    	je     66a <malloc+0xae>
 5dd:	8b 02                	mov    (%edx),%eax
 5df:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 5e2:	39 ce                	cmp    %ecx,%esi
 5e4:	76 52                	jbe    638 <malloc+0x7c>
 5e6:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 5ed:	eb 0a                	jmp    5f9 <malloc+0x3d>
 5ef:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5f0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 5f2:	8b 48 04             	mov    0x4(%eax),%ecx
 5f5:	39 ce                	cmp    %ecx,%esi
 5f7:	76 3f                	jbe    638 <malloc+0x7c>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 5f9:	89 c2                	mov    %eax,%edx
 5fb:	3b 05 2c 09 00 00    	cmp    0x92c,%eax
 601:	75 ed                	jne    5f0 <malloc+0x34>
  if(nu < 4096)
 603:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 609:	76 4d                	jbe    658 <malloc+0x9c>
 60b:	89 d8                	mov    %ebx,%eax
 60d:	89 f7                	mov    %esi,%edi
  p = sbrk(nu * sizeof(Header));
 60f:	89 04 24             	mov    %eax,(%esp)
 612:	e8 78 fc ff ff       	call   28f <sbrk>
  if(p == (char*)-1)
 617:	83 f8 ff             	cmp    $0xffffffff,%eax
 61a:	74 18                	je     634 <malloc+0x78>
  hp->s.size = nu;
 61c:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 61f:	83 c0 08             	add    $0x8,%eax
 622:	89 04 24             	mov    %eax,(%esp)
 625:	e8 12 ff ff ff       	call   53c <free>
  return freep;
 62a:	8b 15 2c 09 00 00    	mov    0x92c,%edx
      if((p = morecore(nunits)) == 0)
 630:	85 d2                	test   %edx,%edx
 632:	75 bc                	jne    5f0 <malloc+0x34>
        return 0;
 634:	31 c0                	xor    %eax,%eax
 636:	eb 18                	jmp    650 <malloc+0x94>
      if(p->s.size == nunits)
 638:	39 ce                	cmp    %ecx,%esi
 63a:	74 28                	je     664 <malloc+0xa8>
        p->s.size -= nunits;
 63c:	29 f1                	sub    %esi,%ecx
 63e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 641:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 644:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 647:	89 15 2c 09 00 00    	mov    %edx,0x92c
      return (void*)(p + 1);
 64d:	83 c0 08             	add    $0x8,%eax
  }
}
 650:	83 c4 1c             	add    $0x1c,%esp
 653:	5b                   	pop    %ebx
 654:	5e                   	pop    %esi
 655:	5f                   	pop    %edi
 656:	5d                   	pop    %ebp
 657:	c3                   	ret    
  if(nu < 4096)
 658:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 65d:	bf 00 10 00 00       	mov    $0x1000,%edi
 662:	eb ab                	jmp    60f <malloc+0x53>
        prevp->s.ptr = p->s.ptr;
 664:	8b 08                	mov    (%eax),%ecx
 666:	89 0a                	mov    %ecx,(%edx)
 668:	eb dd                	jmp    647 <malloc+0x8b>
    base.s.ptr = freep = prevp = &base;
 66a:	c7 05 2c 09 00 00 30 	movl   $0x930,0x92c
 671:	09 00 00 
 674:	c7 05 30 09 00 00 30 	movl   $0x930,0x930
 67b:	09 00 00 
    base.s.size = 0;
 67e:	c7 05 34 09 00 00 00 	movl   $0x0,0x934
 685:	00 00 00 
 688:	b8 30 09 00 00       	mov    $0x930,%eax
 68d:	e9 54 ff ff ff       	jmp    5e6 <malloc+0x2a>
