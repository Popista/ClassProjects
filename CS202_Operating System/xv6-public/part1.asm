
_part1：     文件格式 elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char *argv[]) {
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
    sleep(5);
   9:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
  10:	e8 da 02 00 00       	call   2ef <sleep>
    if(*argv[1] == '1'){    //count of the processes in the system
  15:	8b 45 0c             	mov    0xc(%ebp),%eax
  18:	8b 40 04             	mov    0x4(%eax),%eax
  1b:	8a 00                	mov    (%eax),%al
  1d:	3c 31                	cmp    $0x31,%al
  1f:	74 2f                	je     50 <main+0x50>
        printf(1,"process num: %d\n", getprocnum());
        exit();
    }
    if(*argv[1] == '2'){    // the number of system calls this program has invoked
  21:	3c 32                	cmp    $0x32,%al
  23:	74 4d                	je     72 <main+0x72>
        //fork();
        //sleep(1);    //sleep(int) is a system call, call it to test if the syscallnum() is working.
        printf(1,"syscallnum: %d\n", syscallnum());
        exit();
    }
    if(*argv[1] == '3'){  // the number of memory pages the current process is using
  25:	3c 33                	cmp    $0x33,%al
  27:	74 05                	je     2e <main+0x2e>
        printf(1,"mempagenum: %d\n", mempagenum());
        //free(p);
        exit();
    }
    //printf(1,"%c\n",*argv[1]);
    exit();
  29:	e8 31 02 00 00       	call   25f <exit>
        printf(1,"mempagenum: %d\n", mempagenum());
  2e:	e8 d4 02 00 00       	call   307 <mempagenum>
  33:	89 44 24 08          	mov    %eax,0x8(%esp)
  37:	c7 44 24 04 0b 07 00 	movl   $0x70b,0x4(%esp)
  3e:	00 
  3f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  46:	e8 7d 03 00 00       	call   3c8 <printf>
        exit();
  4b:	e8 0f 02 00 00       	call   25f <exit>
        printf(1,"process num: %d\n", getprocnum());
  50:	e8 aa 02 00 00       	call   2ff <getprocnum>
  55:	89 44 24 08          	mov    %eax,0x8(%esp)
  59:	c7 44 24 04 ea 06 00 	movl   $0x6ea,0x4(%esp)
  60:	00 
  61:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  68:	e8 5b 03 00 00       	call   3c8 <printf>
        exit();
  6d:	e8 ed 01 00 00       	call   25f <exit>
        printf(1,"syscallnum: %d\n", syscallnum());
  72:	e8 98 02 00 00       	call   30f <syscallnum>
  77:	89 44 24 08          	mov    %eax,0x8(%esp)
  7b:	c7 44 24 04 fb 06 00 	movl   $0x6fb,0x4(%esp)
  82:	00 
  83:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  8a:	e8 39 03 00 00       	call   3c8 <printf>
        exit();
  8f:	e8 cb 01 00 00       	call   25f <exit>

00000094 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  94:	55                   	push   %ebp
  95:	89 e5                	mov    %esp,%ebp
  97:	53                   	push   %ebx
  98:	8b 45 08             	mov    0x8(%ebp),%eax
  9b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  9e:	89 c2                	mov    %eax,%edx
  a0:	8a 19                	mov    (%ecx),%bl
  a2:	88 1a                	mov    %bl,(%edx)
  a4:	42                   	inc    %edx
  a5:	41                   	inc    %ecx
  a6:	84 db                	test   %bl,%bl
  a8:	75 f6                	jne    a0 <strcpy+0xc>
    ;
  return os;
}
  aa:	5b                   	pop    %ebx
  ab:	5d                   	pop    %ebp
  ac:	c3                   	ret    
  ad:	8d 76 00             	lea    0x0(%esi),%esi

000000b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	56                   	push   %esi
  b4:	53                   	push   %ebx
  b5:	8b 55 08             	mov    0x8(%ebp),%edx
  b8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  bb:	0f b6 02             	movzbl (%edx),%eax
  be:	0f b6 19             	movzbl (%ecx),%ebx
  c1:	84 c0                	test   %al,%al
  c3:	75 14                	jne    d9 <strcmp+0x29>
  c5:	eb 1d                	jmp    e4 <strcmp+0x34>
  c7:	90                   	nop
    p++, q++;
  c8:	42                   	inc    %edx
  c9:	8d 71 01             	lea    0x1(%ecx),%esi
  while(*p && *p == *q)
  cc:	0f b6 02             	movzbl (%edx),%eax
  cf:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  d3:	84 c0                	test   %al,%al
  d5:	74 0d                	je     e4 <strcmp+0x34>
    p++, q++;
  d7:	89 f1                	mov    %esi,%ecx
  while(*p && *p == *q)
  d9:	38 d8                	cmp    %bl,%al
  db:	74 eb                	je     c8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
  dd:	29 d8                	sub    %ebx,%eax
}
  df:	5b                   	pop    %ebx
  e0:	5e                   	pop    %esi
  e1:	5d                   	pop    %ebp
  e2:	c3                   	ret    
  e3:	90                   	nop
  while(*p && *p == *q)
  e4:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  e6:	29 d8                	sub    %ebx,%eax
}
  e8:	5b                   	pop    %ebx
  e9:	5e                   	pop    %esi
  ea:	5d                   	pop    %ebp
  eb:	c3                   	ret    

000000ec <strlen>:

uint
strlen(char *s)
{
  ec:	55                   	push   %ebp
  ed:	89 e5                	mov    %esp,%ebp
  ef:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  f2:	80 39 00             	cmpb   $0x0,(%ecx)
  f5:	74 10                	je     107 <strlen+0x1b>
  f7:	31 d2                	xor    %edx,%edx
  f9:	8d 76 00             	lea    0x0(%esi),%esi
  fc:	42                   	inc    %edx
  fd:	89 d0                	mov    %edx,%eax
  ff:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 103:	75 f7                	jne    fc <strlen+0x10>
    ;
  return n;
}
 105:	5d                   	pop    %ebp
 106:	c3                   	ret    
  for(n = 0; s[n]; n++)
 107:	31 c0                	xor    %eax,%eax
}
 109:	5d                   	pop    %ebp
 10a:	c3                   	ret    
 10b:	90                   	nop

0000010c <memset>:

void*
memset(void *dst, int c, uint n)
{
 10c:	55                   	push   %ebp
 10d:	89 e5                	mov    %esp,%ebp
 10f:	57                   	push   %edi
 110:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 113:	89 d7                	mov    %edx,%edi
 115:	8b 4d 10             	mov    0x10(%ebp),%ecx
 118:	8b 45 0c             	mov    0xc(%ebp),%eax
 11b:	fc                   	cld    
 11c:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 11e:	89 d0                	mov    %edx,%eax
 120:	5f                   	pop    %edi
 121:	5d                   	pop    %ebp
 122:	c3                   	ret    
 123:	90                   	nop

00000124 <strchr>:

char*
strchr(const char *s, char c)
{
 124:	55                   	push   %ebp
 125:	89 e5                	mov    %esp,%ebp
 127:	8b 45 08             	mov    0x8(%ebp),%eax
 12a:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
 12d:	8a 10                	mov    (%eax),%dl
 12f:	84 d2                	test   %dl,%dl
 131:	75 0c                	jne    13f <strchr+0x1b>
 133:	eb 13                	jmp    148 <strchr+0x24>
 135:	8d 76 00             	lea    0x0(%esi),%esi
 138:	40                   	inc    %eax
 139:	8a 10                	mov    (%eax),%dl
 13b:	84 d2                	test   %dl,%dl
 13d:	74 09                	je     148 <strchr+0x24>
    if(*s == c)
 13f:	38 ca                	cmp    %cl,%dl
 141:	75 f5                	jne    138 <strchr+0x14>
      return (char*)s;
  return 0;
}
 143:	5d                   	pop    %ebp
 144:	c3                   	ret    
 145:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
 148:	31 c0                	xor    %eax,%eax
}
 14a:	5d                   	pop    %ebp
 14b:	c3                   	ret    

0000014c <gets>:

char*
gets(char *buf, int max)
{
 14c:	55                   	push   %ebp
 14d:	89 e5                	mov    %esp,%ebp
 14f:	57                   	push   %edi
 150:	56                   	push   %esi
 151:	53                   	push   %ebx
 152:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 155:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
 157:	8d 7d e7             	lea    -0x19(%ebp),%edi
 15a:	66 90                	xchg   %ax,%ax
  for(i=0; i+1 < max; ){
 15c:	8d 73 01             	lea    0x1(%ebx),%esi
 15f:	3b 75 0c             	cmp    0xc(%ebp),%esi
 162:	7d 40                	jge    1a4 <gets+0x58>
    cc = read(0, &c, 1);
 164:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 16b:	00 
 16c:	89 7c 24 04          	mov    %edi,0x4(%esp)
 170:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 177:	e8 fb 00 00 00       	call   277 <read>
    if(cc < 1)
 17c:	85 c0                	test   %eax,%eax
 17e:	7e 24                	jle    1a4 <gets+0x58>
      break;
    buf[i++] = c;
 180:	8a 45 e7             	mov    -0x19(%ebp),%al
 183:	8b 55 08             	mov    0x8(%ebp),%edx
 186:	88 44 32 ff          	mov    %al,-0x1(%edx,%esi,1)
    if(c == '\n' || c == '\r')
 18a:	3c 0a                	cmp    $0xa,%al
 18c:	74 06                	je     194 <gets+0x48>
 18e:	89 f3                	mov    %esi,%ebx
 190:	3c 0d                	cmp    $0xd,%al
 192:	75 c8                	jne    15c <gets+0x10>
      break;
  }
  buf[i] = '\0';
 194:	8b 45 08             	mov    0x8(%ebp),%eax
 197:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 19b:	83 c4 2c             	add    $0x2c,%esp
 19e:	5b                   	pop    %ebx
 19f:	5e                   	pop    %esi
 1a0:	5f                   	pop    %edi
 1a1:	5d                   	pop    %ebp
 1a2:	c3                   	ret    
 1a3:	90                   	nop
    if(cc < 1)
 1a4:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 1a6:	8b 45 08             	mov    0x8(%ebp),%eax
 1a9:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 1ad:	83 c4 2c             	add    $0x2c,%esp
 1b0:	5b                   	pop    %ebx
 1b1:	5e                   	pop    %esi
 1b2:	5f                   	pop    %edi
 1b3:	5d                   	pop    %ebp
 1b4:	c3                   	ret    
 1b5:	8d 76 00             	lea    0x0(%esi),%esi

000001b8 <stat>:

int
stat(char *n, struct stat *st)
{
 1b8:	55                   	push   %ebp
 1b9:	89 e5                	mov    %esp,%ebp
 1bb:	56                   	push   %esi
 1bc:	53                   	push   %ebx
 1bd:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1c0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1c7:	00 
 1c8:	8b 45 08             	mov    0x8(%ebp),%eax
 1cb:	89 04 24             	mov    %eax,(%esp)
 1ce:	e8 cc 00 00 00       	call   29f <open>
 1d3:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 1d5:	85 c0                	test   %eax,%eax
 1d7:	78 23                	js     1fc <stat+0x44>
    return -1;
  r = fstat(fd, st);
 1d9:	8b 45 0c             	mov    0xc(%ebp),%eax
 1dc:	89 44 24 04          	mov    %eax,0x4(%esp)
 1e0:	89 1c 24             	mov    %ebx,(%esp)
 1e3:	e8 cf 00 00 00       	call   2b7 <fstat>
 1e8:	89 c6                	mov    %eax,%esi
  close(fd);
 1ea:	89 1c 24             	mov    %ebx,(%esp)
 1ed:	e8 95 00 00 00       	call   287 <close>
  return r;
}
 1f2:	89 f0                	mov    %esi,%eax
 1f4:	83 c4 10             	add    $0x10,%esp
 1f7:	5b                   	pop    %ebx
 1f8:	5e                   	pop    %esi
 1f9:	5d                   	pop    %ebp
 1fa:	c3                   	ret    
 1fb:	90                   	nop
    return -1;
 1fc:	be ff ff ff ff       	mov    $0xffffffff,%esi
 201:	eb ef                	jmp    1f2 <stat+0x3a>
 203:	90                   	nop

00000204 <atoi>:

int
atoi(const char *s)
{
 204:	55                   	push   %ebp
 205:	89 e5                	mov    %esp,%ebp
 207:	53                   	push   %ebx
 208:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 20b:	0f be 11             	movsbl (%ecx),%edx
 20e:	8d 42 d0             	lea    -0x30(%edx),%eax
 211:	3c 09                	cmp    $0x9,%al
 213:	b8 00 00 00 00       	mov    $0x0,%eax
 218:	77 15                	ja     22f <atoi+0x2b>
 21a:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 21c:	8d 04 80             	lea    (%eax,%eax,4),%eax
 21f:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
 223:	41                   	inc    %ecx
  while('0' <= *s && *s <= '9')
 224:	0f be 11             	movsbl (%ecx),%edx
 227:	8d 5a d0             	lea    -0x30(%edx),%ebx
 22a:	80 fb 09             	cmp    $0x9,%bl
 22d:	76 ed                	jbe    21c <atoi+0x18>
  return n;
}
 22f:	5b                   	pop    %ebx
 230:	5d                   	pop    %ebp
 231:	c3                   	ret    
 232:	66 90                	xchg   %ax,%ax

00000234 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 234:	55                   	push   %ebp
 235:	89 e5                	mov    %esp,%ebp
 237:	56                   	push   %esi
 238:	53                   	push   %ebx
 239:	8b 45 08             	mov    0x8(%ebp),%eax
 23c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 23f:	8b 75 10             	mov    0x10(%ebp),%esi
memmove(void *vdst, void *vsrc, int n)
 242:	31 d2                	xor    %edx,%edx
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 244:	85 f6                	test   %esi,%esi
 246:	7e 0b                	jle    253 <memmove+0x1f>
    *dst++ = *src++;
 248:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 24b:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 24e:	42                   	inc    %edx
  while(n-- > 0)
 24f:	39 f2                	cmp    %esi,%edx
 251:	75 f5                	jne    248 <memmove+0x14>
  return vdst;
}
 253:	5b                   	pop    %ebx
 254:	5e                   	pop    %esi
 255:	5d                   	pop    %ebp
 256:	c3                   	ret    

00000257 <fork>:
 257:	b8 01 00 00 00       	mov    $0x1,%eax
 25c:	cd 40                	int    $0x40
 25e:	c3                   	ret    

0000025f <exit>:
 25f:	b8 02 00 00 00       	mov    $0x2,%eax
 264:	cd 40                	int    $0x40
 266:	c3                   	ret    

00000267 <wait>:
 267:	b8 03 00 00 00       	mov    $0x3,%eax
 26c:	cd 40                	int    $0x40
 26e:	c3                   	ret    

0000026f <pipe>:
 26f:	b8 04 00 00 00       	mov    $0x4,%eax
 274:	cd 40                	int    $0x40
 276:	c3                   	ret    

00000277 <read>:
 277:	b8 05 00 00 00       	mov    $0x5,%eax
 27c:	cd 40                	int    $0x40
 27e:	c3                   	ret    

0000027f <write>:
 27f:	b8 10 00 00 00       	mov    $0x10,%eax
 284:	cd 40                	int    $0x40
 286:	c3                   	ret    

00000287 <close>:
 287:	b8 15 00 00 00       	mov    $0x15,%eax
 28c:	cd 40                	int    $0x40
 28e:	c3                   	ret    

0000028f <kill>:
 28f:	b8 06 00 00 00       	mov    $0x6,%eax
 294:	cd 40                	int    $0x40
 296:	c3                   	ret    

00000297 <exec>:
 297:	b8 07 00 00 00       	mov    $0x7,%eax
 29c:	cd 40                	int    $0x40
 29e:	c3                   	ret    

0000029f <open>:
 29f:	b8 0f 00 00 00       	mov    $0xf,%eax
 2a4:	cd 40                	int    $0x40
 2a6:	c3                   	ret    

000002a7 <mknod>:
 2a7:	b8 11 00 00 00       	mov    $0x11,%eax
 2ac:	cd 40                	int    $0x40
 2ae:	c3                   	ret    

000002af <unlink>:
 2af:	b8 12 00 00 00       	mov    $0x12,%eax
 2b4:	cd 40                	int    $0x40
 2b6:	c3                   	ret    

000002b7 <fstat>:
 2b7:	b8 08 00 00 00       	mov    $0x8,%eax
 2bc:	cd 40                	int    $0x40
 2be:	c3                   	ret    

000002bf <link>:
 2bf:	b8 13 00 00 00       	mov    $0x13,%eax
 2c4:	cd 40                	int    $0x40
 2c6:	c3                   	ret    

000002c7 <mkdir>:
 2c7:	b8 14 00 00 00       	mov    $0x14,%eax
 2cc:	cd 40                	int    $0x40
 2ce:	c3                   	ret    

000002cf <chdir>:
 2cf:	b8 09 00 00 00       	mov    $0x9,%eax
 2d4:	cd 40                	int    $0x40
 2d6:	c3                   	ret    

000002d7 <dup>:
 2d7:	b8 0a 00 00 00       	mov    $0xa,%eax
 2dc:	cd 40                	int    $0x40
 2de:	c3                   	ret    

000002df <getpid>:
 2df:	b8 0b 00 00 00       	mov    $0xb,%eax
 2e4:	cd 40                	int    $0x40
 2e6:	c3                   	ret    

000002e7 <sbrk>:
 2e7:	b8 0c 00 00 00       	mov    $0xc,%eax
 2ec:	cd 40                	int    $0x40
 2ee:	c3                   	ret    

000002ef <sleep>:
 2ef:	b8 0d 00 00 00       	mov    $0xd,%eax
 2f4:	cd 40                	int    $0x40
 2f6:	c3                   	ret    

000002f7 <uptime>:
 2f7:	b8 0e 00 00 00       	mov    $0xe,%eax
 2fc:	cd 40                	int    $0x40
 2fe:	c3                   	ret    

000002ff <getprocnum>:
 2ff:	b8 16 00 00 00       	mov    $0x16,%eax
 304:	cd 40                	int    $0x40
 306:	c3                   	ret    

00000307 <mempagenum>:
 307:	b8 17 00 00 00       	mov    $0x17,%eax
 30c:	cd 40                	int    $0x40
 30e:	c3                   	ret    

0000030f <syscallnum>:
 30f:	b8 18 00 00 00       	mov    $0x18,%eax
 314:	cd 40                	int    $0x40
 316:	c3                   	ret    

00000317 <settickets>:
 317:	b8 19 00 00 00       	mov    $0x19,%eax
 31c:	cd 40                	int    $0x40
 31e:	c3                   	ret    

0000031f <getsheltime>:
 31f:	b8 1a 00 00 00       	mov    $0x1a,%eax
 324:	cd 40                	int    $0x40
 326:	c3                   	ret    

00000327 <setstride>:
 327:	b8 1b 00 00 00       	mov    $0x1b,%eax
 32c:	cd 40                	int    $0x40
 32e:	c3                   	ret    

0000032f <setpass>:
 32f:	b8 1c 00 00 00       	mov    $0x1c,%eax
 334:	cd 40                	int    $0x40
 336:	c3                   	ret    

00000337 <join>:
 337:	b8 1d 00 00 00       	mov    $0x1d,%eax
 33c:	cd 40                	int    $0x40
 33e:	c3                   	ret    

0000033f <clone1>:
 33f:	b8 1e 00 00 00       	mov    $0x1e,%eax
 344:	cd 40                	int    $0x40
 346:	c3                   	ret    
 347:	90                   	nop

00000348 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 348:	55                   	push   %ebp
 349:	89 e5                	mov    %esp,%ebp
 34b:	57                   	push   %edi
 34c:	56                   	push   %esi
 34d:	53                   	push   %ebx
 34e:	83 ec 3c             	sub    $0x3c,%esp
 351:	89 c7                	mov    %eax,%edi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 353:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 355:	8b 5d 08             	mov    0x8(%ebp),%ebx
 358:	85 db                	test   %ebx,%ebx
 35a:	74 04                	je     360 <printint+0x18>
 35c:	85 d2                	test   %edx,%edx
 35e:	78 5d                	js     3bd <printint+0x75>
  neg = 0;
 360:	31 db                	xor    %ebx,%ebx
  } else {
    x = xx;
  }

  i = 0;
 362:	31 f6                	xor    %esi,%esi
 364:	eb 04                	jmp    36a <printint+0x22>
 366:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 368:	89 d6                	mov    %edx,%esi
 36a:	31 d2                	xor    %edx,%edx
 36c:	f7 f1                	div    %ecx
 36e:	8a 92 22 07 00 00    	mov    0x722(%edx),%dl
 374:	88 54 35 d8          	mov    %dl,-0x28(%ebp,%esi,1)
 378:	8d 56 01             	lea    0x1(%esi),%edx
  }while((x /= base) != 0);
 37b:	85 c0                	test   %eax,%eax
 37d:	75 e9                	jne    368 <printint+0x20>
  if(neg)
 37f:	85 db                	test   %ebx,%ebx
 381:	74 08                	je     38b <printint+0x43>
    buf[i++] = '-';
 383:	c6 44 15 d8 2d       	movb   $0x2d,-0x28(%ebp,%edx,1)
 388:	8d 56 02             	lea    0x2(%esi),%edx

  while(--i >= 0)
 38b:	8d 5a ff             	lea    -0x1(%edx),%ebx
 38e:	8d 75 d7             	lea    -0x29(%ebp),%esi
 391:	8d 76 00             	lea    0x0(%esi),%esi
 394:	8a 44 1d d8          	mov    -0x28(%ebp,%ebx,1),%al
 398:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 39b:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3a2:	00 
 3a3:	89 74 24 04          	mov    %esi,0x4(%esp)
 3a7:	89 3c 24             	mov    %edi,(%esp)
 3aa:	e8 d0 fe ff ff       	call   27f <write>
  while(--i >= 0)
 3af:	4b                   	dec    %ebx
 3b0:	83 fb ff             	cmp    $0xffffffff,%ebx
 3b3:	75 df                	jne    394 <printint+0x4c>
    putc(fd, buf[i]);
}
 3b5:	83 c4 3c             	add    $0x3c,%esp
 3b8:	5b                   	pop    %ebx
 3b9:	5e                   	pop    %esi
 3ba:	5f                   	pop    %edi
 3bb:	5d                   	pop    %ebp
 3bc:	c3                   	ret    
    x = -xx;
 3bd:	f7 d8                	neg    %eax
    neg = 1;
 3bf:	bb 01 00 00 00       	mov    $0x1,%ebx
    x = -xx;
 3c4:	eb 9c                	jmp    362 <printint+0x1a>
 3c6:	66 90                	xchg   %ax,%ax

000003c8 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3c8:	55                   	push   %ebp
 3c9:	89 e5                	mov    %esp,%ebp
 3cb:	57                   	push   %edi
 3cc:	56                   	push   %esi
 3cd:	53                   	push   %ebx
 3ce:	83 ec 3c             	sub    $0x3c,%esp
 3d1:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3d4:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 3d7:	8a 03                	mov    (%ebx),%al
 3d9:	84 c0                	test   %al,%al
 3db:	0f 84 bb 00 00 00    	je     49c <printf+0xd4>
printf(int fd, char *fmt, ...)
 3e1:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
 3e2:	8d 55 10             	lea    0x10(%ebp),%edx
 3e5:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  state = 0;
 3e8:	31 ff                	xor    %edi,%edi
 3ea:	eb 2f                	jmp    41b <printf+0x53>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 3ec:	83 f9 25             	cmp    $0x25,%ecx
 3ef:	0f 84 af 00 00 00    	je     4a4 <printf+0xdc>
        state = '%';
      } else {
        putc(fd, c);
 3f5:	88 4d e2             	mov    %cl,-0x1e(%ebp)
  write(fd, &c, 1);
 3f8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3ff:	00 
 400:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 403:	89 44 24 04          	mov    %eax,0x4(%esp)
 407:	89 34 24             	mov    %esi,(%esp)
 40a:	e8 70 fe ff ff       	call   27f <write>
 40f:	43                   	inc    %ebx
  for(i = 0; fmt[i]; i++){
 410:	8a 43 ff             	mov    -0x1(%ebx),%al
 413:	84 c0                	test   %al,%al
 415:	0f 84 81 00 00 00    	je     49c <printf+0xd4>
    c = fmt[i] & 0xff;
 41b:	0f b6 c8             	movzbl %al,%ecx
    if(state == 0){
 41e:	85 ff                	test   %edi,%edi
 420:	74 ca                	je     3ec <printf+0x24>
      }
    } else if(state == '%'){
 422:	83 ff 25             	cmp    $0x25,%edi
 425:	75 e8                	jne    40f <printf+0x47>
      if(c == 'd'){
 427:	83 f9 64             	cmp    $0x64,%ecx
 42a:	0f 84 14 01 00 00    	je     544 <printf+0x17c>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 430:	83 f9 78             	cmp    $0x78,%ecx
 433:	74 7b                	je     4b0 <printf+0xe8>
 435:	83 f9 70             	cmp    $0x70,%ecx
 438:	74 76                	je     4b0 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 43a:	83 f9 73             	cmp    $0x73,%ecx
 43d:	0f 84 91 00 00 00    	je     4d4 <printf+0x10c>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 443:	83 f9 63             	cmp    $0x63,%ecx
 446:	0f 84 cc 00 00 00    	je     518 <printf+0x150>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 44c:	83 f9 25             	cmp    $0x25,%ecx
 44f:	0f 84 13 01 00 00    	je     568 <printf+0x1a0>
 455:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
  write(fd, &c, 1);
 459:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 460:	00 
 461:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 464:	89 44 24 04          	mov    %eax,0x4(%esp)
 468:	89 34 24             	mov    %esi,(%esp)
 46b:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 46e:	e8 0c fe ff ff       	call   27f <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 473:	8b 4d d0             	mov    -0x30(%ebp),%ecx
 476:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
 479:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 480:	00 
 481:	8d 55 e7             	lea    -0x19(%ebp),%edx
 484:	89 54 24 04          	mov    %edx,0x4(%esp)
 488:	89 34 24             	mov    %esi,(%esp)
 48b:	e8 ef fd ff ff       	call   27f <write>
      }
      state = 0;
 490:	31 ff                	xor    %edi,%edi
 492:	43                   	inc    %ebx
  for(i = 0; fmt[i]; i++){
 493:	8a 43 ff             	mov    -0x1(%ebx),%al
 496:	84 c0                	test   %al,%al
 498:	75 81                	jne    41b <printf+0x53>
 49a:	66 90                	xchg   %ax,%ax
    }
  }
}
 49c:	83 c4 3c             	add    $0x3c,%esp
 49f:	5b                   	pop    %ebx
 4a0:	5e                   	pop    %esi
 4a1:	5f                   	pop    %edi
 4a2:	5d                   	pop    %ebp
 4a3:	c3                   	ret    
        state = '%';
 4a4:	bf 25 00 00 00       	mov    $0x25,%edi
 4a9:	e9 61 ff ff ff       	jmp    40f <printf+0x47>
 4ae:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 4b0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4b7:	b9 10 00 00 00       	mov    $0x10,%ecx
 4bc:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 4bf:	8b 10                	mov    (%eax),%edx
 4c1:	89 f0                	mov    %esi,%eax
 4c3:	e8 80 fe ff ff       	call   348 <printint>
        ap++;
 4c8:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 4cc:	31 ff                	xor    %edi,%edi
        ap++;
 4ce:	e9 3c ff ff ff       	jmp    40f <printf+0x47>
 4d3:	90                   	nop
        s = (char*)*ap;
 4d4:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 4d7:	8b 3a                	mov    (%edx),%edi
        ap++;
 4d9:	83 c2 04             	add    $0x4,%edx
 4dc:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
 4df:	85 ff                	test   %edi,%edi
 4e1:	0f 84 a3 00 00 00    	je     58a <printf+0x1c2>
        while(*s != 0){
 4e7:	8a 07                	mov    (%edi),%al
 4e9:	84 c0                	test   %al,%al
 4eb:	74 24                	je     511 <printf+0x149>
 4ed:	8d 76 00             	lea    0x0(%esi),%esi
 4f0:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 4f3:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4fa:	00 
 4fb:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 4fe:	89 44 24 04          	mov    %eax,0x4(%esp)
 502:	89 34 24             	mov    %esi,(%esp)
 505:	e8 75 fd ff ff       	call   27f <write>
          s++;
 50a:	47                   	inc    %edi
        while(*s != 0){
 50b:	8a 07                	mov    (%edi),%al
 50d:	84 c0                	test   %al,%al
 50f:	75 df                	jne    4f0 <printf+0x128>
      state = 0;
 511:	31 ff                	xor    %edi,%edi
 513:	e9 f7 fe ff ff       	jmp    40f <printf+0x47>
        putc(fd, *ap);
 518:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 51b:	8b 02                	mov    (%edx),%eax
 51d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 520:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 527:	00 
 528:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 52b:	89 44 24 04          	mov    %eax,0x4(%esp)
 52f:	89 34 24             	mov    %esi,(%esp)
 532:	e8 48 fd ff ff       	call   27f <write>
        ap++;
 537:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 53b:	31 ff                	xor    %edi,%edi
 53d:	e9 cd fe ff ff       	jmp    40f <printf+0x47>
 542:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 544:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 54b:	b1 0a                	mov    $0xa,%cl
 54d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 550:	8b 10                	mov    (%eax),%edx
 552:	89 f0                	mov    %esi,%eax
 554:	e8 ef fd ff ff       	call   348 <printint>
        ap++;
 559:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 55d:	66 31 ff             	xor    %di,%di
 560:	e9 aa fe ff ff       	jmp    40f <printf+0x47>
 565:	8d 76 00             	lea    0x0(%esi),%esi
 568:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
  write(fd, &c, 1);
 56c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 573:	00 
 574:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 577:	89 44 24 04          	mov    %eax,0x4(%esp)
 57b:	89 34 24             	mov    %esi,(%esp)
 57e:	e8 fc fc ff ff       	call   27f <write>
      state = 0;
 583:	31 ff                	xor    %edi,%edi
 585:	e9 85 fe ff ff       	jmp    40f <printf+0x47>
          s = "(null)";
 58a:	bf 1b 07 00 00       	mov    $0x71b,%edi
 58f:	e9 53 ff ff ff       	jmp    4e7 <printf+0x11f>

00000594 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 594:	55                   	push   %ebp
 595:	89 e5                	mov    %esp,%ebp
 597:	57                   	push   %edi
 598:	56                   	push   %esi
 599:	53                   	push   %ebx
 59a:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 59d:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5a0:	a1 b4 09 00 00       	mov    0x9b4,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5a5:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5a7:	39 d0                	cmp    %edx,%eax
 5a9:	72 11                	jb     5bc <free+0x28>
 5ab:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5ac:	39 c8                	cmp    %ecx,%eax
 5ae:	72 04                	jb     5b4 <free+0x20>
 5b0:	39 ca                	cmp    %ecx,%edx
 5b2:	72 10                	jb     5c4 <free+0x30>
 5b4:	89 c8                	mov    %ecx,%eax
 5b6:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5b8:	39 d0                	cmp    %edx,%eax
 5ba:	73 f0                	jae    5ac <free+0x18>
 5bc:	39 ca                	cmp    %ecx,%edx
 5be:	72 04                	jb     5c4 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5c0:	39 c8                	cmp    %ecx,%eax
 5c2:	72 f0                	jb     5b4 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 5c4:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5c7:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 5ca:	39 cf                	cmp    %ecx,%edi
 5cc:	74 1a                	je     5e8 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 5ce:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5d1:	8b 48 04             	mov    0x4(%eax),%ecx
 5d4:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 5d7:	39 f2                	cmp    %esi,%edx
 5d9:	74 24                	je     5ff <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 5db:	89 10                	mov    %edx,(%eax)
  freep = p;
 5dd:	a3 b4 09 00 00       	mov    %eax,0x9b4
}
 5e2:	5b                   	pop    %ebx
 5e3:	5e                   	pop    %esi
 5e4:	5f                   	pop    %edi
 5e5:	5d                   	pop    %ebp
 5e6:	c3                   	ret    
 5e7:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 5e8:	03 71 04             	add    0x4(%ecx),%esi
 5eb:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5ee:	8b 08                	mov    (%eax),%ecx
 5f0:	8b 09                	mov    (%ecx),%ecx
 5f2:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5f5:	8b 48 04             	mov    0x4(%eax),%ecx
 5f8:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 5fb:	39 f2                	cmp    %esi,%edx
 5fd:	75 dc                	jne    5db <free+0x47>
    p->s.size += bp->s.size;
 5ff:	03 4b fc             	add    -0x4(%ebx),%ecx
 602:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 605:	8b 53 f8             	mov    -0x8(%ebx),%edx
 608:	89 10                	mov    %edx,(%eax)
  freep = p;
 60a:	a3 b4 09 00 00       	mov    %eax,0x9b4
}
 60f:	5b                   	pop    %ebx
 610:	5e                   	pop    %esi
 611:	5f                   	pop    %edi
 612:	5d                   	pop    %ebp
 613:	c3                   	ret    

00000614 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 614:	55                   	push   %ebp
 615:	89 e5                	mov    %esp,%ebp
 617:	57                   	push   %edi
 618:	56                   	push   %esi
 619:	53                   	push   %ebx
 61a:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 61d:	8b 75 08             	mov    0x8(%ebp),%esi
 620:	83 c6 07             	add    $0x7,%esi
 623:	c1 ee 03             	shr    $0x3,%esi
 626:	46                   	inc    %esi
  if((prevp = freep) == 0){
 627:	8b 15 b4 09 00 00    	mov    0x9b4,%edx
 62d:	85 d2                	test   %edx,%edx
 62f:	0f 84 8d 00 00 00    	je     6c2 <malloc+0xae>
 635:	8b 02                	mov    (%edx),%eax
 637:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 63a:	39 ce                	cmp    %ecx,%esi
 63c:	76 52                	jbe    690 <malloc+0x7c>
 63e:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 645:	eb 0a                	jmp    651 <malloc+0x3d>
 647:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 648:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 64a:	8b 48 04             	mov    0x4(%eax),%ecx
 64d:	39 ce                	cmp    %ecx,%esi
 64f:	76 3f                	jbe    690 <malloc+0x7c>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 651:	89 c2                	mov    %eax,%edx
 653:	3b 05 b4 09 00 00    	cmp    0x9b4,%eax
 659:	75 ed                	jne    648 <malloc+0x34>
  if(nu < 4096)
 65b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 661:	76 4d                	jbe    6b0 <malloc+0x9c>
 663:	89 d8                	mov    %ebx,%eax
 665:	89 f7                	mov    %esi,%edi
  p = sbrk(nu * sizeof(Header));
 667:	89 04 24             	mov    %eax,(%esp)
 66a:	e8 78 fc ff ff       	call   2e7 <sbrk>
  if(p == (char*)-1)
 66f:	83 f8 ff             	cmp    $0xffffffff,%eax
 672:	74 18                	je     68c <malloc+0x78>
  hp->s.size = nu;
 674:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 677:	83 c0 08             	add    $0x8,%eax
 67a:	89 04 24             	mov    %eax,(%esp)
 67d:	e8 12 ff ff ff       	call   594 <free>
  return freep;
 682:	8b 15 b4 09 00 00    	mov    0x9b4,%edx
      if((p = morecore(nunits)) == 0)
 688:	85 d2                	test   %edx,%edx
 68a:	75 bc                	jne    648 <malloc+0x34>
        return 0;
 68c:	31 c0                	xor    %eax,%eax
 68e:	eb 18                	jmp    6a8 <malloc+0x94>
      if(p->s.size == nunits)
 690:	39 ce                	cmp    %ecx,%esi
 692:	74 28                	je     6bc <malloc+0xa8>
        p->s.size -= nunits;
 694:	29 f1                	sub    %esi,%ecx
 696:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 699:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 69c:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 69f:	89 15 b4 09 00 00    	mov    %edx,0x9b4
      return (void*)(p + 1);
 6a5:	83 c0 08             	add    $0x8,%eax
  }
}
 6a8:	83 c4 1c             	add    $0x1c,%esp
 6ab:	5b                   	pop    %ebx
 6ac:	5e                   	pop    %esi
 6ad:	5f                   	pop    %edi
 6ae:	5d                   	pop    %ebp
 6af:	c3                   	ret    
  if(nu < 4096)
 6b0:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 6b5:	bf 00 10 00 00       	mov    $0x1000,%edi
 6ba:	eb ab                	jmp    667 <malloc+0x53>
        prevp->s.ptr = p->s.ptr;
 6bc:	8b 08                	mov    (%eax),%ecx
 6be:	89 0a                	mov    %ecx,(%edx)
 6c0:	eb dd                	jmp    69f <malloc+0x8b>
    base.s.ptr = freep = prevp = &base;
 6c2:	c7 05 b4 09 00 00 b8 	movl   $0x9b8,0x9b4
 6c9:	09 00 00 
 6cc:	c7 05 b8 09 00 00 b8 	movl   $0x9b8,0x9b8
 6d3:	09 00 00 
    base.s.size = 0;
 6d6:	c7 05 bc 09 00 00 00 	movl   $0x0,0x9bc
 6dd:	00 00 00 
 6e0:	b8 b8 09 00 00       	mov    $0x9b8,%eax
 6e5:	e9 54 ff ff ff       	jmp    63e <malloc+0x2a>
