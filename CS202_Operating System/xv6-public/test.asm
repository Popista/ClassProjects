
_test：     文件格式 elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "stat.h"
#include "user.h"

int main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
    printf(1,"%d\n", getprocnum());
   9:	e8 89 02 00 00       	call   297 <getprocnum>
   e:	89 44 24 08          	mov    %eax,0x8(%esp)
  12:	c7 44 24 04 82 06 00 	movl   $0x682,0x4(%esp)
  19:	00 
  1a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  21:	e8 3a 03 00 00       	call   360 <printf>
    exit();
  26:	e8 cc 01 00 00       	call   1f7 <exit>
  2b:	90                   	nop

0000002c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  2c:	55                   	push   %ebp
  2d:	89 e5                	mov    %esp,%ebp
  2f:	53                   	push   %ebx
  30:	8b 45 08             	mov    0x8(%ebp),%eax
  33:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  36:	89 c2                	mov    %eax,%edx
  38:	8a 19                	mov    (%ecx),%bl
  3a:	88 1a                	mov    %bl,(%edx)
  3c:	42                   	inc    %edx
  3d:	41                   	inc    %ecx
  3e:	84 db                	test   %bl,%bl
  40:	75 f6                	jne    38 <strcpy+0xc>
    ;
  return os;
}
  42:	5b                   	pop    %ebx
  43:	5d                   	pop    %ebp
  44:	c3                   	ret    
  45:	8d 76 00             	lea    0x0(%esi),%esi

00000048 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  48:	55                   	push   %ebp
  49:	89 e5                	mov    %esp,%ebp
  4b:	56                   	push   %esi
  4c:	53                   	push   %ebx
  4d:	8b 55 08             	mov    0x8(%ebp),%edx
  50:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  53:	0f b6 02             	movzbl (%edx),%eax
  56:	0f b6 19             	movzbl (%ecx),%ebx
  59:	84 c0                	test   %al,%al
  5b:	75 14                	jne    71 <strcmp+0x29>
  5d:	eb 1d                	jmp    7c <strcmp+0x34>
  5f:	90                   	nop
    p++, q++;
  60:	42                   	inc    %edx
  61:	8d 71 01             	lea    0x1(%ecx),%esi
  while(*p && *p == *q)
  64:	0f b6 02             	movzbl (%edx),%eax
  67:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  6b:	84 c0                	test   %al,%al
  6d:	74 0d                	je     7c <strcmp+0x34>
    p++, q++;
  6f:	89 f1                	mov    %esi,%ecx
  while(*p && *p == *q)
  71:	38 d8                	cmp    %bl,%al
  73:	74 eb                	je     60 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
  75:	29 d8                	sub    %ebx,%eax
}
  77:	5b                   	pop    %ebx
  78:	5e                   	pop    %esi
  79:	5d                   	pop    %ebp
  7a:	c3                   	ret    
  7b:	90                   	nop
  while(*p && *p == *q)
  7c:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  7e:	29 d8                	sub    %ebx,%eax
}
  80:	5b                   	pop    %ebx
  81:	5e                   	pop    %esi
  82:	5d                   	pop    %ebp
  83:	c3                   	ret    

00000084 <strlen>:

uint
strlen(char *s)
{
  84:	55                   	push   %ebp
  85:	89 e5                	mov    %esp,%ebp
  87:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  8a:	80 39 00             	cmpb   $0x0,(%ecx)
  8d:	74 10                	je     9f <strlen+0x1b>
  8f:	31 d2                	xor    %edx,%edx
  91:	8d 76 00             	lea    0x0(%esi),%esi
  94:	42                   	inc    %edx
  95:	89 d0                	mov    %edx,%eax
  97:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  9b:	75 f7                	jne    94 <strlen+0x10>
    ;
  return n;
}
  9d:	5d                   	pop    %ebp
  9e:	c3                   	ret    
  for(n = 0; s[n]; n++)
  9f:	31 c0                	xor    %eax,%eax
}
  a1:	5d                   	pop    %ebp
  a2:	c3                   	ret    
  a3:	90                   	nop

000000a4 <memset>:

void*
memset(void *dst, int c, uint n)
{
  a4:	55                   	push   %ebp
  a5:	89 e5                	mov    %esp,%ebp
  a7:	57                   	push   %edi
  a8:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  ab:	89 d7                	mov    %edx,%edi
  ad:	8b 4d 10             	mov    0x10(%ebp),%ecx
  b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  b3:	fc                   	cld    
  b4:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  b6:	89 d0                	mov    %edx,%eax
  b8:	5f                   	pop    %edi
  b9:	5d                   	pop    %ebp
  ba:	c3                   	ret    
  bb:	90                   	nop

000000bc <strchr>:

char*
strchr(const char *s, char c)
{
  bc:	55                   	push   %ebp
  bd:	89 e5                	mov    %esp,%ebp
  bf:	8b 45 08             	mov    0x8(%ebp),%eax
  c2:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
  c5:	8a 10                	mov    (%eax),%dl
  c7:	84 d2                	test   %dl,%dl
  c9:	75 0c                	jne    d7 <strchr+0x1b>
  cb:	eb 13                	jmp    e0 <strchr+0x24>
  cd:	8d 76 00             	lea    0x0(%esi),%esi
  d0:	40                   	inc    %eax
  d1:	8a 10                	mov    (%eax),%dl
  d3:	84 d2                	test   %dl,%dl
  d5:	74 09                	je     e0 <strchr+0x24>
    if(*s == c)
  d7:	38 ca                	cmp    %cl,%dl
  d9:	75 f5                	jne    d0 <strchr+0x14>
      return (char*)s;
  return 0;
}
  db:	5d                   	pop    %ebp
  dc:	c3                   	ret    
  dd:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
  e0:	31 c0                	xor    %eax,%eax
}
  e2:	5d                   	pop    %ebp
  e3:	c3                   	ret    

000000e4 <gets>:

char*
gets(char *buf, int max)
{
  e4:	55                   	push   %ebp
  e5:	89 e5                	mov    %esp,%ebp
  e7:	57                   	push   %edi
  e8:	56                   	push   %esi
  e9:	53                   	push   %ebx
  ea:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
  ed:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
  ef:	8d 7d e7             	lea    -0x19(%ebp),%edi
  f2:	66 90                	xchg   %ax,%ax
  for(i=0; i+1 < max; ){
  f4:	8d 73 01             	lea    0x1(%ebx),%esi
  f7:	3b 75 0c             	cmp    0xc(%ebp),%esi
  fa:	7d 40                	jge    13c <gets+0x58>
    cc = read(0, &c, 1);
  fc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 103:	00 
 104:	89 7c 24 04          	mov    %edi,0x4(%esp)
 108:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 10f:	e8 fb 00 00 00       	call   20f <read>
    if(cc < 1)
 114:	85 c0                	test   %eax,%eax
 116:	7e 24                	jle    13c <gets+0x58>
      break;
    buf[i++] = c;
 118:	8a 45 e7             	mov    -0x19(%ebp),%al
 11b:	8b 55 08             	mov    0x8(%ebp),%edx
 11e:	88 44 32 ff          	mov    %al,-0x1(%edx,%esi,1)
    if(c == '\n' || c == '\r')
 122:	3c 0a                	cmp    $0xa,%al
 124:	74 06                	je     12c <gets+0x48>
 126:	89 f3                	mov    %esi,%ebx
 128:	3c 0d                	cmp    $0xd,%al
 12a:	75 c8                	jne    f4 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 12c:	8b 45 08             	mov    0x8(%ebp),%eax
 12f:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 133:	83 c4 2c             	add    $0x2c,%esp
 136:	5b                   	pop    %ebx
 137:	5e                   	pop    %esi
 138:	5f                   	pop    %edi
 139:	5d                   	pop    %ebp
 13a:	c3                   	ret    
 13b:	90                   	nop
    if(cc < 1)
 13c:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 13e:	8b 45 08             	mov    0x8(%ebp),%eax
 141:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 145:	83 c4 2c             	add    $0x2c,%esp
 148:	5b                   	pop    %ebx
 149:	5e                   	pop    %esi
 14a:	5f                   	pop    %edi
 14b:	5d                   	pop    %ebp
 14c:	c3                   	ret    
 14d:	8d 76 00             	lea    0x0(%esi),%esi

00000150 <stat>:

int
stat(char *n, struct stat *st)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	56                   	push   %esi
 154:	53                   	push   %ebx
 155:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 158:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 15f:	00 
 160:	8b 45 08             	mov    0x8(%ebp),%eax
 163:	89 04 24             	mov    %eax,(%esp)
 166:	e8 cc 00 00 00       	call   237 <open>
 16b:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 16d:	85 c0                	test   %eax,%eax
 16f:	78 23                	js     194 <stat+0x44>
    return -1;
  r = fstat(fd, st);
 171:	8b 45 0c             	mov    0xc(%ebp),%eax
 174:	89 44 24 04          	mov    %eax,0x4(%esp)
 178:	89 1c 24             	mov    %ebx,(%esp)
 17b:	e8 cf 00 00 00       	call   24f <fstat>
 180:	89 c6                	mov    %eax,%esi
  close(fd);
 182:	89 1c 24             	mov    %ebx,(%esp)
 185:	e8 95 00 00 00       	call   21f <close>
  return r;
}
 18a:	89 f0                	mov    %esi,%eax
 18c:	83 c4 10             	add    $0x10,%esp
 18f:	5b                   	pop    %ebx
 190:	5e                   	pop    %esi
 191:	5d                   	pop    %ebp
 192:	c3                   	ret    
 193:	90                   	nop
    return -1;
 194:	be ff ff ff ff       	mov    $0xffffffff,%esi
 199:	eb ef                	jmp    18a <stat+0x3a>
 19b:	90                   	nop

0000019c <atoi>:

int
atoi(const char *s)
{
 19c:	55                   	push   %ebp
 19d:	89 e5                	mov    %esp,%ebp
 19f:	53                   	push   %ebx
 1a0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1a3:	0f be 11             	movsbl (%ecx),%edx
 1a6:	8d 42 d0             	lea    -0x30(%edx),%eax
 1a9:	3c 09                	cmp    $0x9,%al
 1ab:	b8 00 00 00 00       	mov    $0x0,%eax
 1b0:	77 15                	ja     1c7 <atoi+0x2b>
 1b2:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 1b4:	8d 04 80             	lea    (%eax,%eax,4),%eax
 1b7:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
 1bb:	41                   	inc    %ecx
  while('0' <= *s && *s <= '9')
 1bc:	0f be 11             	movsbl (%ecx),%edx
 1bf:	8d 5a d0             	lea    -0x30(%edx),%ebx
 1c2:	80 fb 09             	cmp    $0x9,%bl
 1c5:	76 ed                	jbe    1b4 <atoi+0x18>
  return n;
}
 1c7:	5b                   	pop    %ebx
 1c8:	5d                   	pop    %ebp
 1c9:	c3                   	ret    
 1ca:	66 90                	xchg   %ax,%ax

000001cc <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 1cc:	55                   	push   %ebp
 1cd:	89 e5                	mov    %esp,%ebp
 1cf:	56                   	push   %esi
 1d0:	53                   	push   %ebx
 1d1:	8b 45 08             	mov    0x8(%ebp),%eax
 1d4:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1d7:	8b 75 10             	mov    0x10(%ebp),%esi
memmove(void *vdst, void *vsrc, int n)
 1da:	31 d2                	xor    %edx,%edx
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1dc:	85 f6                	test   %esi,%esi
 1de:	7e 0b                	jle    1eb <memmove+0x1f>
    *dst++ = *src++;
 1e0:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 1e3:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 1e6:	42                   	inc    %edx
  while(n-- > 0)
 1e7:	39 f2                	cmp    %esi,%edx
 1e9:	75 f5                	jne    1e0 <memmove+0x14>
  return vdst;
}
 1eb:	5b                   	pop    %ebx
 1ec:	5e                   	pop    %esi
 1ed:	5d                   	pop    %ebp
 1ee:	c3                   	ret    

000001ef <fork>:
 1ef:	b8 01 00 00 00       	mov    $0x1,%eax
 1f4:	cd 40                	int    $0x40
 1f6:	c3                   	ret    

000001f7 <exit>:
 1f7:	b8 02 00 00 00       	mov    $0x2,%eax
 1fc:	cd 40                	int    $0x40
 1fe:	c3                   	ret    

000001ff <wait>:
 1ff:	b8 03 00 00 00       	mov    $0x3,%eax
 204:	cd 40                	int    $0x40
 206:	c3                   	ret    

00000207 <pipe>:
 207:	b8 04 00 00 00       	mov    $0x4,%eax
 20c:	cd 40                	int    $0x40
 20e:	c3                   	ret    

0000020f <read>:
 20f:	b8 05 00 00 00       	mov    $0x5,%eax
 214:	cd 40                	int    $0x40
 216:	c3                   	ret    

00000217 <write>:
 217:	b8 10 00 00 00       	mov    $0x10,%eax
 21c:	cd 40                	int    $0x40
 21e:	c3                   	ret    

0000021f <close>:
 21f:	b8 15 00 00 00       	mov    $0x15,%eax
 224:	cd 40                	int    $0x40
 226:	c3                   	ret    

00000227 <kill>:
 227:	b8 06 00 00 00       	mov    $0x6,%eax
 22c:	cd 40                	int    $0x40
 22e:	c3                   	ret    

0000022f <exec>:
 22f:	b8 07 00 00 00       	mov    $0x7,%eax
 234:	cd 40                	int    $0x40
 236:	c3                   	ret    

00000237 <open>:
 237:	b8 0f 00 00 00       	mov    $0xf,%eax
 23c:	cd 40                	int    $0x40
 23e:	c3                   	ret    

0000023f <mknod>:
 23f:	b8 11 00 00 00       	mov    $0x11,%eax
 244:	cd 40                	int    $0x40
 246:	c3                   	ret    

00000247 <unlink>:
 247:	b8 12 00 00 00       	mov    $0x12,%eax
 24c:	cd 40                	int    $0x40
 24e:	c3                   	ret    

0000024f <fstat>:
 24f:	b8 08 00 00 00       	mov    $0x8,%eax
 254:	cd 40                	int    $0x40
 256:	c3                   	ret    

00000257 <link>:
 257:	b8 13 00 00 00       	mov    $0x13,%eax
 25c:	cd 40                	int    $0x40
 25e:	c3                   	ret    

0000025f <mkdir>:
 25f:	b8 14 00 00 00       	mov    $0x14,%eax
 264:	cd 40                	int    $0x40
 266:	c3                   	ret    

00000267 <chdir>:
 267:	b8 09 00 00 00       	mov    $0x9,%eax
 26c:	cd 40                	int    $0x40
 26e:	c3                   	ret    

0000026f <dup>:
 26f:	b8 0a 00 00 00       	mov    $0xa,%eax
 274:	cd 40                	int    $0x40
 276:	c3                   	ret    

00000277 <getpid>:
 277:	b8 0b 00 00 00       	mov    $0xb,%eax
 27c:	cd 40                	int    $0x40
 27e:	c3                   	ret    

0000027f <sbrk>:
 27f:	b8 0c 00 00 00       	mov    $0xc,%eax
 284:	cd 40                	int    $0x40
 286:	c3                   	ret    

00000287 <sleep>:
 287:	b8 0d 00 00 00       	mov    $0xd,%eax
 28c:	cd 40                	int    $0x40
 28e:	c3                   	ret    

0000028f <uptime>:
 28f:	b8 0e 00 00 00       	mov    $0xe,%eax
 294:	cd 40                	int    $0x40
 296:	c3                   	ret    

00000297 <getprocnum>:
 297:	b8 16 00 00 00       	mov    $0x16,%eax
 29c:	cd 40                	int    $0x40
 29e:	c3                   	ret    

0000029f <mempagenum>:
 29f:	b8 17 00 00 00       	mov    $0x17,%eax
 2a4:	cd 40                	int    $0x40
 2a6:	c3                   	ret    

000002a7 <syscallnum>:
 2a7:	b8 18 00 00 00       	mov    $0x18,%eax
 2ac:	cd 40                	int    $0x40
 2ae:	c3                   	ret    

000002af <settickets>:
 2af:	b8 19 00 00 00       	mov    $0x19,%eax
 2b4:	cd 40                	int    $0x40
 2b6:	c3                   	ret    

000002b7 <getsheltime>:
 2b7:	b8 1a 00 00 00       	mov    $0x1a,%eax
 2bc:	cd 40                	int    $0x40
 2be:	c3                   	ret    

000002bf <setstride>:
 2bf:	b8 1b 00 00 00       	mov    $0x1b,%eax
 2c4:	cd 40                	int    $0x40
 2c6:	c3                   	ret    

000002c7 <setpass>:
 2c7:	b8 1c 00 00 00       	mov    $0x1c,%eax
 2cc:	cd 40                	int    $0x40
 2ce:	c3                   	ret    

000002cf <join>:
 2cf:	b8 1d 00 00 00       	mov    $0x1d,%eax
 2d4:	cd 40                	int    $0x40
 2d6:	c3                   	ret    

000002d7 <clone1>:
 2d7:	b8 1e 00 00 00       	mov    $0x1e,%eax
 2dc:	cd 40                	int    $0x40
 2de:	c3                   	ret    
 2df:	90                   	nop

000002e0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	57                   	push   %edi
 2e4:	56                   	push   %esi
 2e5:	53                   	push   %ebx
 2e6:	83 ec 3c             	sub    $0x3c,%esp
 2e9:	89 c7                	mov    %eax,%edi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 2eb:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 2ed:	8b 5d 08             	mov    0x8(%ebp),%ebx
 2f0:	85 db                	test   %ebx,%ebx
 2f2:	74 04                	je     2f8 <printint+0x18>
 2f4:	85 d2                	test   %edx,%edx
 2f6:	78 5d                	js     355 <printint+0x75>
  neg = 0;
 2f8:	31 db                	xor    %ebx,%ebx
  } else {
    x = xx;
  }

  i = 0;
 2fa:	31 f6                	xor    %esi,%esi
 2fc:	eb 04                	jmp    302 <printint+0x22>
 2fe:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 300:	89 d6                	mov    %edx,%esi
 302:	31 d2                	xor    %edx,%edx
 304:	f7 f1                	div    %ecx
 306:	8a 92 8d 06 00 00    	mov    0x68d(%edx),%dl
 30c:	88 54 35 d8          	mov    %dl,-0x28(%ebp,%esi,1)
 310:	8d 56 01             	lea    0x1(%esi),%edx
  }while((x /= base) != 0);
 313:	85 c0                	test   %eax,%eax
 315:	75 e9                	jne    300 <printint+0x20>
  if(neg)
 317:	85 db                	test   %ebx,%ebx
 319:	74 08                	je     323 <printint+0x43>
    buf[i++] = '-';
 31b:	c6 44 15 d8 2d       	movb   $0x2d,-0x28(%ebp,%edx,1)
 320:	8d 56 02             	lea    0x2(%esi),%edx

  while(--i >= 0)
 323:	8d 5a ff             	lea    -0x1(%edx),%ebx
 326:	8d 75 d7             	lea    -0x29(%ebp),%esi
 329:	8d 76 00             	lea    0x0(%esi),%esi
 32c:	8a 44 1d d8          	mov    -0x28(%ebp,%ebx,1),%al
 330:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 333:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 33a:	00 
 33b:	89 74 24 04          	mov    %esi,0x4(%esp)
 33f:	89 3c 24             	mov    %edi,(%esp)
 342:	e8 d0 fe ff ff       	call   217 <write>
  while(--i >= 0)
 347:	4b                   	dec    %ebx
 348:	83 fb ff             	cmp    $0xffffffff,%ebx
 34b:	75 df                	jne    32c <printint+0x4c>
    putc(fd, buf[i]);
}
 34d:	83 c4 3c             	add    $0x3c,%esp
 350:	5b                   	pop    %ebx
 351:	5e                   	pop    %esi
 352:	5f                   	pop    %edi
 353:	5d                   	pop    %ebp
 354:	c3                   	ret    
    x = -xx;
 355:	f7 d8                	neg    %eax
    neg = 1;
 357:	bb 01 00 00 00       	mov    $0x1,%ebx
    x = -xx;
 35c:	eb 9c                	jmp    2fa <printint+0x1a>
 35e:	66 90                	xchg   %ax,%ax

00000360 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	57                   	push   %edi
 364:	56                   	push   %esi
 365:	53                   	push   %ebx
 366:	83 ec 3c             	sub    $0x3c,%esp
 369:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 36c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 36f:	8a 03                	mov    (%ebx),%al
 371:	84 c0                	test   %al,%al
 373:	0f 84 bb 00 00 00    	je     434 <printf+0xd4>
printf(int fd, char *fmt, ...)
 379:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
 37a:	8d 55 10             	lea    0x10(%ebp),%edx
 37d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  state = 0;
 380:	31 ff                	xor    %edi,%edi
 382:	eb 2f                	jmp    3b3 <printf+0x53>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 384:	83 f9 25             	cmp    $0x25,%ecx
 387:	0f 84 af 00 00 00    	je     43c <printf+0xdc>
        state = '%';
      } else {
        putc(fd, c);
 38d:	88 4d e2             	mov    %cl,-0x1e(%ebp)
  write(fd, &c, 1);
 390:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 397:	00 
 398:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 39b:	89 44 24 04          	mov    %eax,0x4(%esp)
 39f:	89 34 24             	mov    %esi,(%esp)
 3a2:	e8 70 fe ff ff       	call   217 <write>
 3a7:	43                   	inc    %ebx
  for(i = 0; fmt[i]; i++){
 3a8:	8a 43 ff             	mov    -0x1(%ebx),%al
 3ab:	84 c0                	test   %al,%al
 3ad:	0f 84 81 00 00 00    	je     434 <printf+0xd4>
    c = fmt[i] & 0xff;
 3b3:	0f b6 c8             	movzbl %al,%ecx
    if(state == 0){
 3b6:	85 ff                	test   %edi,%edi
 3b8:	74 ca                	je     384 <printf+0x24>
      }
    } else if(state == '%'){
 3ba:	83 ff 25             	cmp    $0x25,%edi
 3bd:	75 e8                	jne    3a7 <printf+0x47>
      if(c == 'd'){
 3bf:	83 f9 64             	cmp    $0x64,%ecx
 3c2:	0f 84 14 01 00 00    	je     4dc <printf+0x17c>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 3c8:	83 f9 78             	cmp    $0x78,%ecx
 3cb:	74 7b                	je     448 <printf+0xe8>
 3cd:	83 f9 70             	cmp    $0x70,%ecx
 3d0:	74 76                	je     448 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 3d2:	83 f9 73             	cmp    $0x73,%ecx
 3d5:	0f 84 91 00 00 00    	je     46c <printf+0x10c>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 3db:	83 f9 63             	cmp    $0x63,%ecx
 3de:	0f 84 cc 00 00 00    	je     4b0 <printf+0x150>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 3e4:	83 f9 25             	cmp    $0x25,%ecx
 3e7:	0f 84 13 01 00 00    	je     500 <printf+0x1a0>
 3ed:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
  write(fd, &c, 1);
 3f1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3f8:	00 
 3f9:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 3fc:	89 44 24 04          	mov    %eax,0x4(%esp)
 400:	89 34 24             	mov    %esi,(%esp)
 403:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 406:	e8 0c fe ff ff       	call   217 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 40b:	8b 4d d0             	mov    -0x30(%ebp),%ecx
 40e:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
 411:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 418:	00 
 419:	8d 55 e7             	lea    -0x19(%ebp),%edx
 41c:	89 54 24 04          	mov    %edx,0x4(%esp)
 420:	89 34 24             	mov    %esi,(%esp)
 423:	e8 ef fd ff ff       	call   217 <write>
      }
      state = 0;
 428:	31 ff                	xor    %edi,%edi
 42a:	43                   	inc    %ebx
  for(i = 0; fmt[i]; i++){
 42b:	8a 43 ff             	mov    -0x1(%ebx),%al
 42e:	84 c0                	test   %al,%al
 430:	75 81                	jne    3b3 <printf+0x53>
 432:	66 90                	xchg   %ax,%ax
    }
  }
}
 434:	83 c4 3c             	add    $0x3c,%esp
 437:	5b                   	pop    %ebx
 438:	5e                   	pop    %esi
 439:	5f                   	pop    %edi
 43a:	5d                   	pop    %ebp
 43b:	c3                   	ret    
        state = '%';
 43c:	bf 25 00 00 00       	mov    $0x25,%edi
 441:	e9 61 ff ff ff       	jmp    3a7 <printf+0x47>
 446:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 448:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 44f:	b9 10 00 00 00       	mov    $0x10,%ecx
 454:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 457:	8b 10                	mov    (%eax),%edx
 459:	89 f0                	mov    %esi,%eax
 45b:	e8 80 fe ff ff       	call   2e0 <printint>
        ap++;
 460:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 464:	31 ff                	xor    %edi,%edi
        ap++;
 466:	e9 3c ff ff ff       	jmp    3a7 <printf+0x47>
 46b:	90                   	nop
        s = (char*)*ap;
 46c:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 46f:	8b 3a                	mov    (%edx),%edi
        ap++;
 471:	83 c2 04             	add    $0x4,%edx
 474:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
 477:	85 ff                	test   %edi,%edi
 479:	0f 84 a3 00 00 00    	je     522 <printf+0x1c2>
        while(*s != 0){
 47f:	8a 07                	mov    (%edi),%al
 481:	84 c0                	test   %al,%al
 483:	74 24                	je     4a9 <printf+0x149>
 485:	8d 76 00             	lea    0x0(%esi),%esi
 488:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 48b:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 492:	00 
 493:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 496:	89 44 24 04          	mov    %eax,0x4(%esp)
 49a:	89 34 24             	mov    %esi,(%esp)
 49d:	e8 75 fd ff ff       	call   217 <write>
          s++;
 4a2:	47                   	inc    %edi
        while(*s != 0){
 4a3:	8a 07                	mov    (%edi),%al
 4a5:	84 c0                	test   %al,%al
 4a7:	75 df                	jne    488 <printf+0x128>
      state = 0;
 4a9:	31 ff                	xor    %edi,%edi
 4ab:	e9 f7 fe ff ff       	jmp    3a7 <printf+0x47>
        putc(fd, *ap);
 4b0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 4b3:	8b 02                	mov    (%edx),%eax
 4b5:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 4b8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4bf:	00 
 4c0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 4c3:	89 44 24 04          	mov    %eax,0x4(%esp)
 4c7:	89 34 24             	mov    %esi,(%esp)
 4ca:	e8 48 fd ff ff       	call   217 <write>
        ap++;
 4cf:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 4d3:	31 ff                	xor    %edi,%edi
 4d5:	e9 cd fe ff ff       	jmp    3a7 <printf+0x47>
 4da:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 4dc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 4e3:	b1 0a                	mov    $0xa,%cl
 4e5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 4e8:	8b 10                	mov    (%eax),%edx
 4ea:	89 f0                	mov    %esi,%eax
 4ec:	e8 ef fd ff ff       	call   2e0 <printint>
        ap++;
 4f1:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 4f5:	66 31 ff             	xor    %di,%di
 4f8:	e9 aa fe ff ff       	jmp    3a7 <printf+0x47>
 4fd:	8d 76 00             	lea    0x0(%esi),%esi
 500:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
  write(fd, &c, 1);
 504:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 50b:	00 
 50c:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 50f:	89 44 24 04          	mov    %eax,0x4(%esp)
 513:	89 34 24             	mov    %esi,(%esp)
 516:	e8 fc fc ff ff       	call   217 <write>
      state = 0;
 51b:	31 ff                	xor    %edi,%edi
 51d:	e9 85 fe ff ff       	jmp    3a7 <printf+0x47>
          s = "(null)";
 522:	bf 86 06 00 00       	mov    $0x686,%edi
 527:	e9 53 ff ff ff       	jmp    47f <printf+0x11f>

0000052c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 52c:	55                   	push   %ebp
 52d:	89 e5                	mov    %esp,%ebp
 52f:	57                   	push   %edi
 530:	56                   	push   %esi
 531:	53                   	push   %ebx
 532:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 535:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 538:	a1 20 09 00 00       	mov    0x920,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 53d:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 53f:	39 d0                	cmp    %edx,%eax
 541:	72 11                	jb     554 <free+0x28>
 543:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 544:	39 c8                	cmp    %ecx,%eax
 546:	72 04                	jb     54c <free+0x20>
 548:	39 ca                	cmp    %ecx,%edx
 54a:	72 10                	jb     55c <free+0x30>
 54c:	89 c8                	mov    %ecx,%eax
 54e:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 550:	39 d0                	cmp    %edx,%eax
 552:	73 f0                	jae    544 <free+0x18>
 554:	39 ca                	cmp    %ecx,%edx
 556:	72 04                	jb     55c <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 558:	39 c8                	cmp    %ecx,%eax
 55a:	72 f0                	jb     54c <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 55c:	8b 73 fc             	mov    -0x4(%ebx),%esi
 55f:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 562:	39 cf                	cmp    %ecx,%edi
 564:	74 1a                	je     580 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 566:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 569:	8b 48 04             	mov    0x4(%eax),%ecx
 56c:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 56f:	39 f2                	cmp    %esi,%edx
 571:	74 24                	je     597 <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 573:	89 10                	mov    %edx,(%eax)
  freep = p;
 575:	a3 20 09 00 00       	mov    %eax,0x920
}
 57a:	5b                   	pop    %ebx
 57b:	5e                   	pop    %esi
 57c:	5f                   	pop    %edi
 57d:	5d                   	pop    %ebp
 57e:	c3                   	ret    
 57f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 580:	03 71 04             	add    0x4(%ecx),%esi
 583:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 586:	8b 08                	mov    (%eax),%ecx
 588:	8b 09                	mov    (%ecx),%ecx
 58a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 58d:	8b 48 04             	mov    0x4(%eax),%ecx
 590:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 593:	39 f2                	cmp    %esi,%edx
 595:	75 dc                	jne    573 <free+0x47>
    p->s.size += bp->s.size;
 597:	03 4b fc             	add    -0x4(%ebx),%ecx
 59a:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 59d:	8b 53 f8             	mov    -0x8(%ebx),%edx
 5a0:	89 10                	mov    %edx,(%eax)
  freep = p;
 5a2:	a3 20 09 00 00       	mov    %eax,0x920
}
 5a7:	5b                   	pop    %ebx
 5a8:	5e                   	pop    %esi
 5a9:	5f                   	pop    %edi
 5aa:	5d                   	pop    %ebp
 5ab:	c3                   	ret    

000005ac <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 5ac:	55                   	push   %ebp
 5ad:	89 e5                	mov    %esp,%ebp
 5af:	57                   	push   %edi
 5b0:	56                   	push   %esi
 5b1:	53                   	push   %ebx
 5b2:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5b5:	8b 75 08             	mov    0x8(%ebp),%esi
 5b8:	83 c6 07             	add    $0x7,%esi
 5bb:	c1 ee 03             	shr    $0x3,%esi
 5be:	46                   	inc    %esi
  if((prevp = freep) == 0){
 5bf:	8b 15 20 09 00 00    	mov    0x920,%edx
 5c5:	85 d2                	test   %edx,%edx
 5c7:	0f 84 8d 00 00 00    	je     65a <malloc+0xae>
 5cd:	8b 02                	mov    (%edx),%eax
 5cf:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 5d2:	39 ce                	cmp    %ecx,%esi
 5d4:	76 52                	jbe    628 <malloc+0x7c>
 5d6:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 5dd:	eb 0a                	jmp    5e9 <malloc+0x3d>
 5df:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5e0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 5e2:	8b 48 04             	mov    0x4(%eax),%ecx
 5e5:	39 ce                	cmp    %ecx,%esi
 5e7:	76 3f                	jbe    628 <malloc+0x7c>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 5e9:	89 c2                	mov    %eax,%edx
 5eb:	3b 05 20 09 00 00    	cmp    0x920,%eax
 5f1:	75 ed                	jne    5e0 <malloc+0x34>
  if(nu < 4096)
 5f3:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 5f9:	76 4d                	jbe    648 <malloc+0x9c>
 5fb:	89 d8                	mov    %ebx,%eax
 5fd:	89 f7                	mov    %esi,%edi
  p = sbrk(nu * sizeof(Header));
 5ff:	89 04 24             	mov    %eax,(%esp)
 602:	e8 78 fc ff ff       	call   27f <sbrk>
  if(p == (char*)-1)
 607:	83 f8 ff             	cmp    $0xffffffff,%eax
 60a:	74 18                	je     624 <malloc+0x78>
  hp->s.size = nu;
 60c:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 60f:	83 c0 08             	add    $0x8,%eax
 612:	89 04 24             	mov    %eax,(%esp)
 615:	e8 12 ff ff ff       	call   52c <free>
  return freep;
 61a:	8b 15 20 09 00 00    	mov    0x920,%edx
      if((p = morecore(nunits)) == 0)
 620:	85 d2                	test   %edx,%edx
 622:	75 bc                	jne    5e0 <malloc+0x34>
        return 0;
 624:	31 c0                	xor    %eax,%eax
 626:	eb 18                	jmp    640 <malloc+0x94>
      if(p->s.size == nunits)
 628:	39 ce                	cmp    %ecx,%esi
 62a:	74 28                	je     654 <malloc+0xa8>
        p->s.size -= nunits;
 62c:	29 f1                	sub    %esi,%ecx
 62e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 631:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 634:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 637:	89 15 20 09 00 00    	mov    %edx,0x920
      return (void*)(p + 1);
 63d:	83 c0 08             	add    $0x8,%eax
  }
}
 640:	83 c4 1c             	add    $0x1c,%esp
 643:	5b                   	pop    %ebx
 644:	5e                   	pop    %esi
 645:	5f                   	pop    %edi
 646:	5d                   	pop    %ebp
 647:	c3                   	ret    
  if(nu < 4096)
 648:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 64d:	bf 00 10 00 00       	mov    $0x1000,%edi
 652:	eb ab                	jmp    5ff <malloc+0x53>
        prevp->s.ptr = p->s.ptr;
 654:	8b 08                	mov    (%eax),%ecx
 656:	89 0a                	mov    %ecx,(%edx)
 658:	eb dd                	jmp    637 <malloc+0x8b>
    base.s.ptr = freep = prevp = &base;
 65a:	c7 05 20 09 00 00 24 	movl   $0x924,0x920
 661:	09 00 00 
 664:	c7 05 24 09 00 00 24 	movl   $0x924,0x924
 66b:	09 00 00 
    base.s.size = 0;
 66e:	c7 05 28 09 00 00 00 	movl   $0x0,0x928
 675:	00 00 00 
 678:	b8 24 09 00 00       	mov    $0x924,%eax
 67d:	e9 54 ff ff ff       	jmp    5d6 <malloc+0x2a>
