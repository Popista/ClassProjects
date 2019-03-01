
_kill：     文件格式 elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
   6:	83 e4 f0             	and    $0xfffffff0,%esp
   9:	83 ec 10             	sub    $0x10,%esp
   c:	8b 75 08             	mov    0x8(%ebp),%esi
   f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  if(argc < 2){
  12:	83 fe 01             	cmp    $0x1,%esi
  15:	7e 22                	jle    39 <main+0x39>
  17:	bb 01 00 00 00       	mov    $0x1,%ebx
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  1c:	8b 04 9f             	mov    (%edi,%ebx,4),%eax
  1f:	89 04 24             	mov    %eax,(%esp)
  22:	e8 9d 01 00 00       	call   1c4 <atoi>
  27:	89 04 24             	mov    %eax,(%esp)
  2a:	e8 20 02 00 00       	call   24f <kill>
  for(i=1; i<argc; i++)
  2f:	43                   	inc    %ebx
  30:	39 f3                	cmp    %esi,%ebx
  32:	75 e8                	jne    1c <main+0x1c>
  exit();
  34:	e8 e6 01 00 00       	call   21f <exit>
    printf(2, "usage: kill pid...\n");
  39:	c7 44 24 04 aa 06 00 	movl   $0x6aa,0x4(%esp)
  40:	00 
  41:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  48:	e8 3b 03 00 00       	call   388 <printf>
    exit();
  4d:	e8 cd 01 00 00       	call   21f <exit>
  52:	66 90                	xchg   %ax,%ax

00000054 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  54:	55                   	push   %ebp
  55:	89 e5                	mov    %esp,%ebp
  57:	53                   	push   %ebx
  58:	8b 45 08             	mov    0x8(%ebp),%eax
  5b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  5e:	89 c2                	mov    %eax,%edx
  60:	8a 19                	mov    (%ecx),%bl
  62:	88 1a                	mov    %bl,(%edx)
  64:	42                   	inc    %edx
  65:	41                   	inc    %ecx
  66:	84 db                	test   %bl,%bl
  68:	75 f6                	jne    60 <strcpy+0xc>
    ;
  return os;
}
  6a:	5b                   	pop    %ebx
  6b:	5d                   	pop    %ebp
  6c:	c3                   	ret    
  6d:	8d 76 00             	lea    0x0(%esi),%esi

00000070 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  70:	55                   	push   %ebp
  71:	89 e5                	mov    %esp,%ebp
  73:	56                   	push   %esi
  74:	53                   	push   %ebx
  75:	8b 55 08             	mov    0x8(%ebp),%edx
  78:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  7b:	0f b6 02             	movzbl (%edx),%eax
  7e:	0f b6 19             	movzbl (%ecx),%ebx
  81:	84 c0                	test   %al,%al
  83:	75 14                	jne    99 <strcmp+0x29>
  85:	eb 1d                	jmp    a4 <strcmp+0x34>
  87:	90                   	nop
    p++, q++;
  88:	42                   	inc    %edx
  89:	8d 71 01             	lea    0x1(%ecx),%esi
  while(*p && *p == *q)
  8c:	0f b6 02             	movzbl (%edx),%eax
  8f:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  93:	84 c0                	test   %al,%al
  95:	74 0d                	je     a4 <strcmp+0x34>
    p++, q++;
  97:	89 f1                	mov    %esi,%ecx
  while(*p && *p == *q)
  99:	38 d8                	cmp    %bl,%al
  9b:	74 eb                	je     88 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
  9d:	29 d8                	sub    %ebx,%eax
}
  9f:	5b                   	pop    %ebx
  a0:	5e                   	pop    %esi
  a1:	5d                   	pop    %ebp
  a2:	c3                   	ret    
  a3:	90                   	nop
  while(*p && *p == *q)
  a4:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  a6:	29 d8                	sub    %ebx,%eax
}
  a8:	5b                   	pop    %ebx
  a9:	5e                   	pop    %esi
  aa:	5d                   	pop    %ebp
  ab:	c3                   	ret    

000000ac <strlen>:

uint
strlen(char *s)
{
  ac:	55                   	push   %ebp
  ad:	89 e5                	mov    %esp,%ebp
  af:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  b2:	80 39 00             	cmpb   $0x0,(%ecx)
  b5:	74 10                	je     c7 <strlen+0x1b>
  b7:	31 d2                	xor    %edx,%edx
  b9:	8d 76 00             	lea    0x0(%esi),%esi
  bc:	42                   	inc    %edx
  bd:	89 d0                	mov    %edx,%eax
  bf:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  c3:	75 f7                	jne    bc <strlen+0x10>
    ;
  return n;
}
  c5:	5d                   	pop    %ebp
  c6:	c3                   	ret    
  for(n = 0; s[n]; n++)
  c7:	31 c0                	xor    %eax,%eax
}
  c9:	5d                   	pop    %ebp
  ca:	c3                   	ret    
  cb:	90                   	nop

000000cc <memset>:

void*
memset(void *dst, int c, uint n)
{
  cc:	55                   	push   %ebp
  cd:	89 e5                	mov    %esp,%ebp
  cf:	57                   	push   %edi
  d0:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  d3:	89 d7                	mov    %edx,%edi
  d5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  db:	fc                   	cld    
  dc:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  de:	89 d0                	mov    %edx,%eax
  e0:	5f                   	pop    %edi
  e1:	5d                   	pop    %ebp
  e2:	c3                   	ret    
  e3:	90                   	nop

000000e4 <strchr>:

char*
strchr(const char *s, char c)
{
  e4:	55                   	push   %ebp
  e5:	89 e5                	mov    %esp,%ebp
  e7:	8b 45 08             	mov    0x8(%ebp),%eax
  ea:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
  ed:	8a 10                	mov    (%eax),%dl
  ef:	84 d2                	test   %dl,%dl
  f1:	75 0c                	jne    ff <strchr+0x1b>
  f3:	eb 13                	jmp    108 <strchr+0x24>
  f5:	8d 76 00             	lea    0x0(%esi),%esi
  f8:	40                   	inc    %eax
  f9:	8a 10                	mov    (%eax),%dl
  fb:	84 d2                	test   %dl,%dl
  fd:	74 09                	je     108 <strchr+0x24>
    if(*s == c)
  ff:	38 ca                	cmp    %cl,%dl
 101:	75 f5                	jne    f8 <strchr+0x14>
      return (char*)s;
  return 0;
}
 103:	5d                   	pop    %ebp
 104:	c3                   	ret    
 105:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
 108:	31 c0                	xor    %eax,%eax
}
 10a:	5d                   	pop    %ebp
 10b:	c3                   	ret    

0000010c <gets>:

char*
gets(char *buf, int max)
{
 10c:	55                   	push   %ebp
 10d:	89 e5                	mov    %esp,%ebp
 10f:	57                   	push   %edi
 110:	56                   	push   %esi
 111:	53                   	push   %ebx
 112:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 115:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
 117:	8d 7d e7             	lea    -0x19(%ebp),%edi
 11a:	66 90                	xchg   %ax,%ax
  for(i=0; i+1 < max; ){
 11c:	8d 73 01             	lea    0x1(%ebx),%esi
 11f:	3b 75 0c             	cmp    0xc(%ebp),%esi
 122:	7d 40                	jge    164 <gets+0x58>
    cc = read(0, &c, 1);
 124:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 12b:	00 
 12c:	89 7c 24 04          	mov    %edi,0x4(%esp)
 130:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 137:	e8 fb 00 00 00       	call   237 <read>
    if(cc < 1)
 13c:	85 c0                	test   %eax,%eax
 13e:	7e 24                	jle    164 <gets+0x58>
      break;
    buf[i++] = c;
 140:	8a 45 e7             	mov    -0x19(%ebp),%al
 143:	8b 55 08             	mov    0x8(%ebp),%edx
 146:	88 44 32 ff          	mov    %al,-0x1(%edx,%esi,1)
    if(c == '\n' || c == '\r')
 14a:	3c 0a                	cmp    $0xa,%al
 14c:	74 06                	je     154 <gets+0x48>
 14e:	89 f3                	mov    %esi,%ebx
 150:	3c 0d                	cmp    $0xd,%al
 152:	75 c8                	jne    11c <gets+0x10>
      break;
  }
  buf[i] = '\0';
 154:	8b 45 08             	mov    0x8(%ebp),%eax
 157:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 15b:	83 c4 2c             	add    $0x2c,%esp
 15e:	5b                   	pop    %ebx
 15f:	5e                   	pop    %esi
 160:	5f                   	pop    %edi
 161:	5d                   	pop    %ebp
 162:	c3                   	ret    
 163:	90                   	nop
    if(cc < 1)
 164:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 166:	8b 45 08             	mov    0x8(%ebp),%eax
 169:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 16d:	83 c4 2c             	add    $0x2c,%esp
 170:	5b                   	pop    %ebx
 171:	5e                   	pop    %esi
 172:	5f                   	pop    %edi
 173:	5d                   	pop    %ebp
 174:	c3                   	ret    
 175:	8d 76 00             	lea    0x0(%esi),%esi

00000178 <stat>:

int
stat(char *n, struct stat *st)
{
 178:	55                   	push   %ebp
 179:	89 e5                	mov    %esp,%ebp
 17b:	56                   	push   %esi
 17c:	53                   	push   %ebx
 17d:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 180:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 187:	00 
 188:	8b 45 08             	mov    0x8(%ebp),%eax
 18b:	89 04 24             	mov    %eax,(%esp)
 18e:	e8 cc 00 00 00       	call   25f <open>
 193:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 195:	85 c0                	test   %eax,%eax
 197:	78 23                	js     1bc <stat+0x44>
    return -1;
  r = fstat(fd, st);
 199:	8b 45 0c             	mov    0xc(%ebp),%eax
 19c:	89 44 24 04          	mov    %eax,0x4(%esp)
 1a0:	89 1c 24             	mov    %ebx,(%esp)
 1a3:	e8 cf 00 00 00       	call   277 <fstat>
 1a8:	89 c6                	mov    %eax,%esi
  close(fd);
 1aa:	89 1c 24             	mov    %ebx,(%esp)
 1ad:	e8 95 00 00 00       	call   247 <close>
  return r;
}
 1b2:	89 f0                	mov    %esi,%eax
 1b4:	83 c4 10             	add    $0x10,%esp
 1b7:	5b                   	pop    %ebx
 1b8:	5e                   	pop    %esi
 1b9:	5d                   	pop    %ebp
 1ba:	c3                   	ret    
 1bb:	90                   	nop
    return -1;
 1bc:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1c1:	eb ef                	jmp    1b2 <stat+0x3a>
 1c3:	90                   	nop

000001c4 <atoi>:

int
atoi(const char *s)
{
 1c4:	55                   	push   %ebp
 1c5:	89 e5                	mov    %esp,%ebp
 1c7:	53                   	push   %ebx
 1c8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1cb:	0f be 11             	movsbl (%ecx),%edx
 1ce:	8d 42 d0             	lea    -0x30(%edx),%eax
 1d1:	3c 09                	cmp    $0x9,%al
 1d3:	b8 00 00 00 00       	mov    $0x0,%eax
 1d8:	77 15                	ja     1ef <atoi+0x2b>
 1da:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 1dc:	8d 04 80             	lea    (%eax,%eax,4),%eax
 1df:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
 1e3:	41                   	inc    %ecx
  while('0' <= *s && *s <= '9')
 1e4:	0f be 11             	movsbl (%ecx),%edx
 1e7:	8d 5a d0             	lea    -0x30(%edx),%ebx
 1ea:	80 fb 09             	cmp    $0x9,%bl
 1ed:	76 ed                	jbe    1dc <atoi+0x18>
  return n;
}
 1ef:	5b                   	pop    %ebx
 1f0:	5d                   	pop    %ebp
 1f1:	c3                   	ret    
 1f2:	66 90                	xchg   %ax,%ax

000001f4 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 1f4:	55                   	push   %ebp
 1f5:	89 e5                	mov    %esp,%ebp
 1f7:	56                   	push   %esi
 1f8:	53                   	push   %ebx
 1f9:	8b 45 08             	mov    0x8(%ebp),%eax
 1fc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1ff:	8b 75 10             	mov    0x10(%ebp),%esi
memmove(void *vdst, void *vsrc, int n)
 202:	31 d2                	xor    %edx,%edx
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 204:	85 f6                	test   %esi,%esi
 206:	7e 0b                	jle    213 <memmove+0x1f>
    *dst++ = *src++;
 208:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 20b:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 20e:	42                   	inc    %edx
  while(n-- > 0)
 20f:	39 f2                	cmp    %esi,%edx
 211:	75 f5                	jne    208 <memmove+0x14>
  return vdst;
}
 213:	5b                   	pop    %ebx
 214:	5e                   	pop    %esi
 215:	5d                   	pop    %ebp
 216:	c3                   	ret    

00000217 <fork>:
 217:	b8 01 00 00 00       	mov    $0x1,%eax
 21c:	cd 40                	int    $0x40
 21e:	c3                   	ret    

0000021f <exit>:
 21f:	b8 02 00 00 00       	mov    $0x2,%eax
 224:	cd 40                	int    $0x40
 226:	c3                   	ret    

00000227 <wait>:
 227:	b8 03 00 00 00       	mov    $0x3,%eax
 22c:	cd 40                	int    $0x40
 22e:	c3                   	ret    

0000022f <pipe>:
 22f:	b8 04 00 00 00       	mov    $0x4,%eax
 234:	cd 40                	int    $0x40
 236:	c3                   	ret    

00000237 <read>:
 237:	b8 05 00 00 00       	mov    $0x5,%eax
 23c:	cd 40                	int    $0x40
 23e:	c3                   	ret    

0000023f <write>:
 23f:	b8 10 00 00 00       	mov    $0x10,%eax
 244:	cd 40                	int    $0x40
 246:	c3                   	ret    

00000247 <close>:
 247:	b8 15 00 00 00       	mov    $0x15,%eax
 24c:	cd 40                	int    $0x40
 24e:	c3                   	ret    

0000024f <kill>:
 24f:	b8 06 00 00 00       	mov    $0x6,%eax
 254:	cd 40                	int    $0x40
 256:	c3                   	ret    

00000257 <exec>:
 257:	b8 07 00 00 00       	mov    $0x7,%eax
 25c:	cd 40                	int    $0x40
 25e:	c3                   	ret    

0000025f <open>:
 25f:	b8 0f 00 00 00       	mov    $0xf,%eax
 264:	cd 40                	int    $0x40
 266:	c3                   	ret    

00000267 <mknod>:
 267:	b8 11 00 00 00       	mov    $0x11,%eax
 26c:	cd 40                	int    $0x40
 26e:	c3                   	ret    

0000026f <unlink>:
 26f:	b8 12 00 00 00       	mov    $0x12,%eax
 274:	cd 40                	int    $0x40
 276:	c3                   	ret    

00000277 <fstat>:
 277:	b8 08 00 00 00       	mov    $0x8,%eax
 27c:	cd 40                	int    $0x40
 27e:	c3                   	ret    

0000027f <link>:
 27f:	b8 13 00 00 00       	mov    $0x13,%eax
 284:	cd 40                	int    $0x40
 286:	c3                   	ret    

00000287 <mkdir>:
 287:	b8 14 00 00 00       	mov    $0x14,%eax
 28c:	cd 40                	int    $0x40
 28e:	c3                   	ret    

0000028f <chdir>:
 28f:	b8 09 00 00 00       	mov    $0x9,%eax
 294:	cd 40                	int    $0x40
 296:	c3                   	ret    

00000297 <dup>:
 297:	b8 0a 00 00 00       	mov    $0xa,%eax
 29c:	cd 40                	int    $0x40
 29e:	c3                   	ret    

0000029f <getpid>:
 29f:	b8 0b 00 00 00       	mov    $0xb,%eax
 2a4:	cd 40                	int    $0x40
 2a6:	c3                   	ret    

000002a7 <sbrk>:
 2a7:	b8 0c 00 00 00       	mov    $0xc,%eax
 2ac:	cd 40                	int    $0x40
 2ae:	c3                   	ret    

000002af <sleep>:
 2af:	b8 0d 00 00 00       	mov    $0xd,%eax
 2b4:	cd 40                	int    $0x40
 2b6:	c3                   	ret    

000002b7 <uptime>:
 2b7:	b8 0e 00 00 00       	mov    $0xe,%eax
 2bc:	cd 40                	int    $0x40
 2be:	c3                   	ret    

000002bf <getprocnum>:
 2bf:	b8 16 00 00 00       	mov    $0x16,%eax
 2c4:	cd 40                	int    $0x40
 2c6:	c3                   	ret    

000002c7 <mempagenum>:
 2c7:	b8 17 00 00 00       	mov    $0x17,%eax
 2cc:	cd 40                	int    $0x40
 2ce:	c3                   	ret    

000002cf <syscallnum>:
 2cf:	b8 18 00 00 00       	mov    $0x18,%eax
 2d4:	cd 40                	int    $0x40
 2d6:	c3                   	ret    

000002d7 <settickets>:
 2d7:	b8 19 00 00 00       	mov    $0x19,%eax
 2dc:	cd 40                	int    $0x40
 2de:	c3                   	ret    

000002df <getsheltime>:
 2df:	b8 1a 00 00 00       	mov    $0x1a,%eax
 2e4:	cd 40                	int    $0x40
 2e6:	c3                   	ret    

000002e7 <setstride>:
 2e7:	b8 1b 00 00 00       	mov    $0x1b,%eax
 2ec:	cd 40                	int    $0x40
 2ee:	c3                   	ret    

000002ef <setpass>:
 2ef:	b8 1c 00 00 00       	mov    $0x1c,%eax
 2f4:	cd 40                	int    $0x40
 2f6:	c3                   	ret    

000002f7 <join>:
 2f7:	b8 1d 00 00 00       	mov    $0x1d,%eax
 2fc:	cd 40                	int    $0x40
 2fe:	c3                   	ret    

000002ff <clone1>:
 2ff:	b8 1e 00 00 00       	mov    $0x1e,%eax
 304:	cd 40                	int    $0x40
 306:	c3                   	ret    
 307:	90                   	nop

00000308 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 308:	55                   	push   %ebp
 309:	89 e5                	mov    %esp,%ebp
 30b:	57                   	push   %edi
 30c:	56                   	push   %esi
 30d:	53                   	push   %ebx
 30e:	83 ec 3c             	sub    $0x3c,%esp
 311:	89 c7                	mov    %eax,%edi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 313:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 315:	8b 5d 08             	mov    0x8(%ebp),%ebx
 318:	85 db                	test   %ebx,%ebx
 31a:	74 04                	je     320 <printint+0x18>
 31c:	85 d2                	test   %edx,%edx
 31e:	78 5d                	js     37d <printint+0x75>
  neg = 0;
 320:	31 db                	xor    %ebx,%ebx
  } else {
    x = xx;
  }

  i = 0;
 322:	31 f6                	xor    %esi,%esi
 324:	eb 04                	jmp    32a <printint+0x22>
 326:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 328:	89 d6                	mov    %edx,%esi
 32a:	31 d2                	xor    %edx,%edx
 32c:	f7 f1                	div    %ecx
 32e:	8a 92 c5 06 00 00    	mov    0x6c5(%edx),%dl
 334:	88 54 35 d8          	mov    %dl,-0x28(%ebp,%esi,1)
 338:	8d 56 01             	lea    0x1(%esi),%edx
  }while((x /= base) != 0);
 33b:	85 c0                	test   %eax,%eax
 33d:	75 e9                	jne    328 <printint+0x20>
  if(neg)
 33f:	85 db                	test   %ebx,%ebx
 341:	74 08                	je     34b <printint+0x43>
    buf[i++] = '-';
 343:	c6 44 15 d8 2d       	movb   $0x2d,-0x28(%ebp,%edx,1)
 348:	8d 56 02             	lea    0x2(%esi),%edx

  while(--i >= 0)
 34b:	8d 5a ff             	lea    -0x1(%edx),%ebx
 34e:	8d 75 d7             	lea    -0x29(%ebp),%esi
 351:	8d 76 00             	lea    0x0(%esi),%esi
 354:	8a 44 1d d8          	mov    -0x28(%ebp,%ebx,1),%al
 358:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 35b:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 362:	00 
 363:	89 74 24 04          	mov    %esi,0x4(%esp)
 367:	89 3c 24             	mov    %edi,(%esp)
 36a:	e8 d0 fe ff ff       	call   23f <write>
  while(--i >= 0)
 36f:	4b                   	dec    %ebx
 370:	83 fb ff             	cmp    $0xffffffff,%ebx
 373:	75 df                	jne    354 <printint+0x4c>
    putc(fd, buf[i]);
}
 375:	83 c4 3c             	add    $0x3c,%esp
 378:	5b                   	pop    %ebx
 379:	5e                   	pop    %esi
 37a:	5f                   	pop    %edi
 37b:	5d                   	pop    %ebp
 37c:	c3                   	ret    
    x = -xx;
 37d:	f7 d8                	neg    %eax
    neg = 1;
 37f:	bb 01 00 00 00       	mov    $0x1,%ebx
    x = -xx;
 384:	eb 9c                	jmp    322 <printint+0x1a>
 386:	66 90                	xchg   %ax,%ax

00000388 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 388:	55                   	push   %ebp
 389:	89 e5                	mov    %esp,%ebp
 38b:	57                   	push   %edi
 38c:	56                   	push   %esi
 38d:	53                   	push   %ebx
 38e:	83 ec 3c             	sub    $0x3c,%esp
 391:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 394:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 397:	8a 03                	mov    (%ebx),%al
 399:	84 c0                	test   %al,%al
 39b:	0f 84 bb 00 00 00    	je     45c <printf+0xd4>
printf(int fd, char *fmt, ...)
 3a1:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
 3a2:	8d 55 10             	lea    0x10(%ebp),%edx
 3a5:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  state = 0;
 3a8:	31 ff                	xor    %edi,%edi
 3aa:	eb 2f                	jmp    3db <printf+0x53>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 3ac:	83 f9 25             	cmp    $0x25,%ecx
 3af:	0f 84 af 00 00 00    	je     464 <printf+0xdc>
        state = '%';
      } else {
        putc(fd, c);
 3b5:	88 4d e2             	mov    %cl,-0x1e(%ebp)
  write(fd, &c, 1);
 3b8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3bf:	00 
 3c0:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 3c3:	89 44 24 04          	mov    %eax,0x4(%esp)
 3c7:	89 34 24             	mov    %esi,(%esp)
 3ca:	e8 70 fe ff ff       	call   23f <write>
 3cf:	43                   	inc    %ebx
  for(i = 0; fmt[i]; i++){
 3d0:	8a 43 ff             	mov    -0x1(%ebx),%al
 3d3:	84 c0                	test   %al,%al
 3d5:	0f 84 81 00 00 00    	je     45c <printf+0xd4>
    c = fmt[i] & 0xff;
 3db:	0f b6 c8             	movzbl %al,%ecx
    if(state == 0){
 3de:	85 ff                	test   %edi,%edi
 3e0:	74 ca                	je     3ac <printf+0x24>
      }
    } else if(state == '%'){
 3e2:	83 ff 25             	cmp    $0x25,%edi
 3e5:	75 e8                	jne    3cf <printf+0x47>
      if(c == 'd'){
 3e7:	83 f9 64             	cmp    $0x64,%ecx
 3ea:	0f 84 14 01 00 00    	je     504 <printf+0x17c>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 3f0:	83 f9 78             	cmp    $0x78,%ecx
 3f3:	74 7b                	je     470 <printf+0xe8>
 3f5:	83 f9 70             	cmp    $0x70,%ecx
 3f8:	74 76                	je     470 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 3fa:	83 f9 73             	cmp    $0x73,%ecx
 3fd:	0f 84 91 00 00 00    	je     494 <printf+0x10c>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 403:	83 f9 63             	cmp    $0x63,%ecx
 406:	0f 84 cc 00 00 00    	je     4d8 <printf+0x150>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 40c:	83 f9 25             	cmp    $0x25,%ecx
 40f:	0f 84 13 01 00 00    	je     528 <printf+0x1a0>
 415:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
  write(fd, &c, 1);
 419:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 420:	00 
 421:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 424:	89 44 24 04          	mov    %eax,0x4(%esp)
 428:	89 34 24             	mov    %esi,(%esp)
 42b:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 42e:	e8 0c fe ff ff       	call   23f <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 433:	8b 4d d0             	mov    -0x30(%ebp),%ecx
 436:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
 439:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 440:	00 
 441:	8d 55 e7             	lea    -0x19(%ebp),%edx
 444:	89 54 24 04          	mov    %edx,0x4(%esp)
 448:	89 34 24             	mov    %esi,(%esp)
 44b:	e8 ef fd ff ff       	call   23f <write>
      }
      state = 0;
 450:	31 ff                	xor    %edi,%edi
 452:	43                   	inc    %ebx
  for(i = 0; fmt[i]; i++){
 453:	8a 43 ff             	mov    -0x1(%ebx),%al
 456:	84 c0                	test   %al,%al
 458:	75 81                	jne    3db <printf+0x53>
 45a:	66 90                	xchg   %ax,%ax
    }
  }
}
 45c:	83 c4 3c             	add    $0x3c,%esp
 45f:	5b                   	pop    %ebx
 460:	5e                   	pop    %esi
 461:	5f                   	pop    %edi
 462:	5d                   	pop    %ebp
 463:	c3                   	ret    
        state = '%';
 464:	bf 25 00 00 00       	mov    $0x25,%edi
 469:	e9 61 ff ff ff       	jmp    3cf <printf+0x47>
 46e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 470:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 477:	b9 10 00 00 00       	mov    $0x10,%ecx
 47c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 47f:	8b 10                	mov    (%eax),%edx
 481:	89 f0                	mov    %esi,%eax
 483:	e8 80 fe ff ff       	call   308 <printint>
        ap++;
 488:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 48c:	31 ff                	xor    %edi,%edi
        ap++;
 48e:	e9 3c ff ff ff       	jmp    3cf <printf+0x47>
 493:	90                   	nop
        s = (char*)*ap;
 494:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 497:	8b 3a                	mov    (%edx),%edi
        ap++;
 499:	83 c2 04             	add    $0x4,%edx
 49c:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
 49f:	85 ff                	test   %edi,%edi
 4a1:	0f 84 a3 00 00 00    	je     54a <printf+0x1c2>
        while(*s != 0){
 4a7:	8a 07                	mov    (%edi),%al
 4a9:	84 c0                	test   %al,%al
 4ab:	74 24                	je     4d1 <printf+0x149>
 4ad:	8d 76 00             	lea    0x0(%esi),%esi
 4b0:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 4b3:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4ba:	00 
 4bb:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 4be:	89 44 24 04          	mov    %eax,0x4(%esp)
 4c2:	89 34 24             	mov    %esi,(%esp)
 4c5:	e8 75 fd ff ff       	call   23f <write>
          s++;
 4ca:	47                   	inc    %edi
        while(*s != 0){
 4cb:	8a 07                	mov    (%edi),%al
 4cd:	84 c0                	test   %al,%al
 4cf:	75 df                	jne    4b0 <printf+0x128>
      state = 0;
 4d1:	31 ff                	xor    %edi,%edi
 4d3:	e9 f7 fe ff ff       	jmp    3cf <printf+0x47>
        putc(fd, *ap);
 4d8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 4db:	8b 02                	mov    (%edx),%eax
 4dd:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 4e0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4e7:	00 
 4e8:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 4eb:	89 44 24 04          	mov    %eax,0x4(%esp)
 4ef:	89 34 24             	mov    %esi,(%esp)
 4f2:	e8 48 fd ff ff       	call   23f <write>
        ap++;
 4f7:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 4fb:	31 ff                	xor    %edi,%edi
 4fd:	e9 cd fe ff ff       	jmp    3cf <printf+0x47>
 502:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 504:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 50b:	b1 0a                	mov    $0xa,%cl
 50d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 510:	8b 10                	mov    (%eax),%edx
 512:	89 f0                	mov    %esi,%eax
 514:	e8 ef fd ff ff       	call   308 <printint>
        ap++;
 519:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 51d:	66 31 ff             	xor    %di,%di
 520:	e9 aa fe ff ff       	jmp    3cf <printf+0x47>
 525:	8d 76 00             	lea    0x0(%esi),%esi
 528:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
  write(fd, &c, 1);
 52c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 533:	00 
 534:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 537:	89 44 24 04          	mov    %eax,0x4(%esp)
 53b:	89 34 24             	mov    %esi,(%esp)
 53e:	e8 fc fc ff ff       	call   23f <write>
      state = 0;
 543:	31 ff                	xor    %edi,%edi
 545:	e9 85 fe ff ff       	jmp    3cf <printf+0x47>
          s = "(null)";
 54a:	bf be 06 00 00       	mov    $0x6be,%edi
 54f:	e9 53 ff ff ff       	jmp    4a7 <printf+0x11f>

00000554 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 554:	55                   	push   %ebp
 555:	89 e5                	mov    %esp,%ebp
 557:	57                   	push   %edi
 558:	56                   	push   %esi
 559:	53                   	push   %ebx
 55a:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 55d:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 560:	a1 5c 09 00 00       	mov    0x95c,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 565:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 567:	39 d0                	cmp    %edx,%eax
 569:	72 11                	jb     57c <free+0x28>
 56b:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 56c:	39 c8                	cmp    %ecx,%eax
 56e:	72 04                	jb     574 <free+0x20>
 570:	39 ca                	cmp    %ecx,%edx
 572:	72 10                	jb     584 <free+0x30>
 574:	89 c8                	mov    %ecx,%eax
 576:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 578:	39 d0                	cmp    %edx,%eax
 57a:	73 f0                	jae    56c <free+0x18>
 57c:	39 ca                	cmp    %ecx,%edx
 57e:	72 04                	jb     584 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 580:	39 c8                	cmp    %ecx,%eax
 582:	72 f0                	jb     574 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 584:	8b 73 fc             	mov    -0x4(%ebx),%esi
 587:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 58a:	39 cf                	cmp    %ecx,%edi
 58c:	74 1a                	je     5a8 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 58e:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 591:	8b 48 04             	mov    0x4(%eax),%ecx
 594:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 597:	39 f2                	cmp    %esi,%edx
 599:	74 24                	je     5bf <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 59b:	89 10                	mov    %edx,(%eax)
  freep = p;
 59d:	a3 5c 09 00 00       	mov    %eax,0x95c
}
 5a2:	5b                   	pop    %ebx
 5a3:	5e                   	pop    %esi
 5a4:	5f                   	pop    %edi
 5a5:	5d                   	pop    %ebp
 5a6:	c3                   	ret    
 5a7:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 5a8:	03 71 04             	add    0x4(%ecx),%esi
 5ab:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5ae:	8b 08                	mov    (%eax),%ecx
 5b0:	8b 09                	mov    (%ecx),%ecx
 5b2:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5b5:	8b 48 04             	mov    0x4(%eax),%ecx
 5b8:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 5bb:	39 f2                	cmp    %esi,%edx
 5bd:	75 dc                	jne    59b <free+0x47>
    p->s.size += bp->s.size;
 5bf:	03 4b fc             	add    -0x4(%ebx),%ecx
 5c2:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 5c5:	8b 53 f8             	mov    -0x8(%ebx),%edx
 5c8:	89 10                	mov    %edx,(%eax)
  freep = p;
 5ca:	a3 5c 09 00 00       	mov    %eax,0x95c
}
 5cf:	5b                   	pop    %ebx
 5d0:	5e                   	pop    %esi
 5d1:	5f                   	pop    %edi
 5d2:	5d                   	pop    %ebp
 5d3:	c3                   	ret    

000005d4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 5d4:	55                   	push   %ebp
 5d5:	89 e5                	mov    %esp,%ebp
 5d7:	57                   	push   %edi
 5d8:	56                   	push   %esi
 5d9:	53                   	push   %ebx
 5da:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5dd:	8b 75 08             	mov    0x8(%ebp),%esi
 5e0:	83 c6 07             	add    $0x7,%esi
 5e3:	c1 ee 03             	shr    $0x3,%esi
 5e6:	46                   	inc    %esi
  if((prevp = freep) == 0){
 5e7:	8b 15 5c 09 00 00    	mov    0x95c,%edx
 5ed:	85 d2                	test   %edx,%edx
 5ef:	0f 84 8d 00 00 00    	je     682 <malloc+0xae>
 5f5:	8b 02                	mov    (%edx),%eax
 5f7:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 5fa:	39 ce                	cmp    %ecx,%esi
 5fc:	76 52                	jbe    650 <malloc+0x7c>
 5fe:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 605:	eb 0a                	jmp    611 <malloc+0x3d>
 607:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 608:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 60a:	8b 48 04             	mov    0x4(%eax),%ecx
 60d:	39 ce                	cmp    %ecx,%esi
 60f:	76 3f                	jbe    650 <malloc+0x7c>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 611:	89 c2                	mov    %eax,%edx
 613:	3b 05 5c 09 00 00    	cmp    0x95c,%eax
 619:	75 ed                	jne    608 <malloc+0x34>
  if(nu < 4096)
 61b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 621:	76 4d                	jbe    670 <malloc+0x9c>
 623:	89 d8                	mov    %ebx,%eax
 625:	89 f7                	mov    %esi,%edi
  p = sbrk(nu * sizeof(Header));
 627:	89 04 24             	mov    %eax,(%esp)
 62a:	e8 78 fc ff ff       	call   2a7 <sbrk>
  if(p == (char*)-1)
 62f:	83 f8 ff             	cmp    $0xffffffff,%eax
 632:	74 18                	je     64c <malloc+0x78>
  hp->s.size = nu;
 634:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 637:	83 c0 08             	add    $0x8,%eax
 63a:	89 04 24             	mov    %eax,(%esp)
 63d:	e8 12 ff ff ff       	call   554 <free>
  return freep;
 642:	8b 15 5c 09 00 00    	mov    0x95c,%edx
      if((p = morecore(nunits)) == 0)
 648:	85 d2                	test   %edx,%edx
 64a:	75 bc                	jne    608 <malloc+0x34>
        return 0;
 64c:	31 c0                	xor    %eax,%eax
 64e:	eb 18                	jmp    668 <malloc+0x94>
      if(p->s.size == nunits)
 650:	39 ce                	cmp    %ecx,%esi
 652:	74 28                	je     67c <malloc+0xa8>
        p->s.size -= nunits;
 654:	29 f1                	sub    %esi,%ecx
 656:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 659:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 65c:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 65f:	89 15 5c 09 00 00    	mov    %edx,0x95c
      return (void*)(p + 1);
 665:	83 c0 08             	add    $0x8,%eax
  }
}
 668:	83 c4 1c             	add    $0x1c,%esp
 66b:	5b                   	pop    %ebx
 66c:	5e                   	pop    %esi
 66d:	5f                   	pop    %edi
 66e:	5d                   	pop    %ebp
 66f:	c3                   	ret    
  if(nu < 4096)
 670:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 675:	bf 00 10 00 00       	mov    $0x1000,%edi
 67a:	eb ab                	jmp    627 <malloc+0x53>
        prevp->s.ptr = p->s.ptr;
 67c:	8b 08                	mov    (%eax),%ecx
 67e:	89 0a                	mov    %ecx,(%edx)
 680:	eb dd                	jmp    65f <malloc+0x8b>
    base.s.ptr = freep = prevp = &base;
 682:	c7 05 5c 09 00 00 60 	movl   $0x960,0x95c
 689:	09 00 00 
 68c:	c7 05 60 09 00 00 60 	movl   $0x960,0x960
 693:	09 00 00 
    base.s.size = 0;
 696:	c7 05 64 09 00 00 00 	movl   $0x0,0x964
 69d:	00 00 00 
 6a0:	b8 60 09 00 00       	mov    $0x960,%eax
 6a5:	e9 54 ff ff ff       	jmp    5fe <malloc+0x2a>
