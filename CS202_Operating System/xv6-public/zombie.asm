
_zombie：     文件格式 elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
  if(fork() > 0)
   9:	e8 d9 01 00 00       	call   1e7 <fork>
   e:	85 c0                	test   %eax,%eax
  10:	7e 0c                	jle    1e <main+0x1e>
    sleep(5);  // Let child exit before parent.
  12:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
  19:	e8 61 02 00 00       	call   27f <sleep>
  exit();
  1e:	e8 cc 01 00 00       	call   1ef <exit>
  23:	90                   	nop

00000024 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  24:	55                   	push   %ebp
  25:	89 e5                	mov    %esp,%ebp
  27:	53                   	push   %ebx
  28:	8b 45 08             	mov    0x8(%ebp),%eax
  2b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  2e:	89 c2                	mov    %eax,%edx
  30:	8a 19                	mov    (%ecx),%bl
  32:	88 1a                	mov    %bl,(%edx)
  34:	42                   	inc    %edx
  35:	41                   	inc    %ecx
  36:	84 db                	test   %bl,%bl
  38:	75 f6                	jne    30 <strcpy+0xc>
    ;
  return os;
}
  3a:	5b                   	pop    %ebx
  3b:	5d                   	pop    %ebp
  3c:	c3                   	ret    
  3d:	8d 76 00             	lea    0x0(%esi),%esi

00000040 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  40:	55                   	push   %ebp
  41:	89 e5                	mov    %esp,%ebp
  43:	56                   	push   %esi
  44:	53                   	push   %ebx
  45:	8b 55 08             	mov    0x8(%ebp),%edx
  48:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  4b:	0f b6 02             	movzbl (%edx),%eax
  4e:	0f b6 19             	movzbl (%ecx),%ebx
  51:	84 c0                	test   %al,%al
  53:	75 14                	jne    69 <strcmp+0x29>
  55:	eb 1d                	jmp    74 <strcmp+0x34>
  57:	90                   	nop
    p++, q++;
  58:	42                   	inc    %edx
  59:	8d 71 01             	lea    0x1(%ecx),%esi
  while(*p && *p == *q)
  5c:	0f b6 02             	movzbl (%edx),%eax
  5f:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  63:	84 c0                	test   %al,%al
  65:	74 0d                	je     74 <strcmp+0x34>
    p++, q++;
  67:	89 f1                	mov    %esi,%ecx
  while(*p && *p == *q)
  69:	38 d8                	cmp    %bl,%al
  6b:	74 eb                	je     58 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
  6d:	29 d8                	sub    %ebx,%eax
}
  6f:	5b                   	pop    %ebx
  70:	5e                   	pop    %esi
  71:	5d                   	pop    %ebp
  72:	c3                   	ret    
  73:	90                   	nop
  while(*p && *p == *q)
  74:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  76:	29 d8                	sub    %ebx,%eax
}
  78:	5b                   	pop    %ebx
  79:	5e                   	pop    %esi
  7a:	5d                   	pop    %ebp
  7b:	c3                   	ret    

0000007c <strlen>:

uint
strlen(char *s)
{
  7c:	55                   	push   %ebp
  7d:	89 e5                	mov    %esp,%ebp
  7f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  82:	80 39 00             	cmpb   $0x0,(%ecx)
  85:	74 10                	je     97 <strlen+0x1b>
  87:	31 d2                	xor    %edx,%edx
  89:	8d 76 00             	lea    0x0(%esi),%esi
  8c:	42                   	inc    %edx
  8d:	89 d0                	mov    %edx,%eax
  8f:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  93:	75 f7                	jne    8c <strlen+0x10>
    ;
  return n;
}
  95:	5d                   	pop    %ebp
  96:	c3                   	ret    
  for(n = 0; s[n]; n++)
  97:	31 c0                	xor    %eax,%eax
}
  99:	5d                   	pop    %ebp
  9a:	c3                   	ret    
  9b:	90                   	nop

0000009c <memset>:

void*
memset(void *dst, int c, uint n)
{
  9c:	55                   	push   %ebp
  9d:	89 e5                	mov    %esp,%ebp
  9f:	57                   	push   %edi
  a0:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  a3:	89 d7                	mov    %edx,%edi
  a5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  ab:	fc                   	cld    
  ac:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  ae:	89 d0                	mov    %edx,%eax
  b0:	5f                   	pop    %edi
  b1:	5d                   	pop    %ebp
  b2:	c3                   	ret    
  b3:	90                   	nop

000000b4 <strchr>:

char*
strchr(const char *s, char c)
{
  b4:	55                   	push   %ebp
  b5:	89 e5                	mov    %esp,%ebp
  b7:	8b 45 08             	mov    0x8(%ebp),%eax
  ba:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
  bd:	8a 10                	mov    (%eax),%dl
  bf:	84 d2                	test   %dl,%dl
  c1:	75 0c                	jne    cf <strchr+0x1b>
  c3:	eb 13                	jmp    d8 <strchr+0x24>
  c5:	8d 76 00             	lea    0x0(%esi),%esi
  c8:	40                   	inc    %eax
  c9:	8a 10                	mov    (%eax),%dl
  cb:	84 d2                	test   %dl,%dl
  cd:	74 09                	je     d8 <strchr+0x24>
    if(*s == c)
  cf:	38 ca                	cmp    %cl,%dl
  d1:	75 f5                	jne    c8 <strchr+0x14>
      return (char*)s;
  return 0;
}
  d3:	5d                   	pop    %ebp
  d4:	c3                   	ret    
  d5:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
  d8:	31 c0                	xor    %eax,%eax
}
  da:	5d                   	pop    %ebp
  db:	c3                   	ret    

000000dc <gets>:

char*
gets(char *buf, int max)
{
  dc:	55                   	push   %ebp
  dd:	89 e5                	mov    %esp,%ebp
  df:	57                   	push   %edi
  e0:	56                   	push   %esi
  e1:	53                   	push   %ebx
  e2:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
  e5:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
  e7:	8d 7d e7             	lea    -0x19(%ebp),%edi
  ea:	66 90                	xchg   %ax,%ax
  for(i=0; i+1 < max; ){
  ec:	8d 73 01             	lea    0x1(%ebx),%esi
  ef:	3b 75 0c             	cmp    0xc(%ebp),%esi
  f2:	7d 40                	jge    134 <gets+0x58>
    cc = read(0, &c, 1);
  f4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  fb:	00 
  fc:	89 7c 24 04          	mov    %edi,0x4(%esp)
 100:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 107:	e8 fb 00 00 00       	call   207 <read>
    if(cc < 1)
 10c:	85 c0                	test   %eax,%eax
 10e:	7e 24                	jle    134 <gets+0x58>
      break;
    buf[i++] = c;
 110:	8a 45 e7             	mov    -0x19(%ebp),%al
 113:	8b 55 08             	mov    0x8(%ebp),%edx
 116:	88 44 32 ff          	mov    %al,-0x1(%edx,%esi,1)
    if(c == '\n' || c == '\r')
 11a:	3c 0a                	cmp    $0xa,%al
 11c:	74 06                	je     124 <gets+0x48>
 11e:	89 f3                	mov    %esi,%ebx
 120:	3c 0d                	cmp    $0xd,%al
 122:	75 c8                	jne    ec <gets+0x10>
      break;
  }
  buf[i] = '\0';
 124:	8b 45 08             	mov    0x8(%ebp),%eax
 127:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 12b:	83 c4 2c             	add    $0x2c,%esp
 12e:	5b                   	pop    %ebx
 12f:	5e                   	pop    %esi
 130:	5f                   	pop    %edi
 131:	5d                   	pop    %ebp
 132:	c3                   	ret    
 133:	90                   	nop
    if(cc < 1)
 134:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 136:	8b 45 08             	mov    0x8(%ebp),%eax
 139:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 13d:	83 c4 2c             	add    $0x2c,%esp
 140:	5b                   	pop    %ebx
 141:	5e                   	pop    %esi
 142:	5f                   	pop    %edi
 143:	5d                   	pop    %ebp
 144:	c3                   	ret    
 145:	8d 76 00             	lea    0x0(%esi),%esi

00000148 <stat>:

int
stat(char *n, struct stat *st)
{
 148:	55                   	push   %ebp
 149:	89 e5                	mov    %esp,%ebp
 14b:	56                   	push   %esi
 14c:	53                   	push   %ebx
 14d:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 150:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 157:	00 
 158:	8b 45 08             	mov    0x8(%ebp),%eax
 15b:	89 04 24             	mov    %eax,(%esp)
 15e:	e8 cc 00 00 00       	call   22f <open>
 163:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 165:	85 c0                	test   %eax,%eax
 167:	78 23                	js     18c <stat+0x44>
    return -1;
  r = fstat(fd, st);
 169:	8b 45 0c             	mov    0xc(%ebp),%eax
 16c:	89 44 24 04          	mov    %eax,0x4(%esp)
 170:	89 1c 24             	mov    %ebx,(%esp)
 173:	e8 cf 00 00 00       	call   247 <fstat>
 178:	89 c6                	mov    %eax,%esi
  close(fd);
 17a:	89 1c 24             	mov    %ebx,(%esp)
 17d:	e8 95 00 00 00       	call   217 <close>
  return r;
}
 182:	89 f0                	mov    %esi,%eax
 184:	83 c4 10             	add    $0x10,%esp
 187:	5b                   	pop    %ebx
 188:	5e                   	pop    %esi
 189:	5d                   	pop    %ebp
 18a:	c3                   	ret    
 18b:	90                   	nop
    return -1;
 18c:	be ff ff ff ff       	mov    $0xffffffff,%esi
 191:	eb ef                	jmp    182 <stat+0x3a>
 193:	90                   	nop

00000194 <atoi>:

int
atoi(const char *s)
{
 194:	55                   	push   %ebp
 195:	89 e5                	mov    %esp,%ebp
 197:	53                   	push   %ebx
 198:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 19b:	0f be 11             	movsbl (%ecx),%edx
 19e:	8d 42 d0             	lea    -0x30(%edx),%eax
 1a1:	3c 09                	cmp    $0x9,%al
 1a3:	b8 00 00 00 00       	mov    $0x0,%eax
 1a8:	77 15                	ja     1bf <atoi+0x2b>
 1aa:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 1ac:	8d 04 80             	lea    (%eax,%eax,4),%eax
 1af:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
 1b3:	41                   	inc    %ecx
  while('0' <= *s && *s <= '9')
 1b4:	0f be 11             	movsbl (%ecx),%edx
 1b7:	8d 5a d0             	lea    -0x30(%edx),%ebx
 1ba:	80 fb 09             	cmp    $0x9,%bl
 1bd:	76 ed                	jbe    1ac <atoi+0x18>
  return n;
}
 1bf:	5b                   	pop    %ebx
 1c0:	5d                   	pop    %ebp
 1c1:	c3                   	ret    
 1c2:	66 90                	xchg   %ax,%ax

000001c4 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 1c4:	55                   	push   %ebp
 1c5:	89 e5                	mov    %esp,%ebp
 1c7:	56                   	push   %esi
 1c8:	53                   	push   %ebx
 1c9:	8b 45 08             	mov    0x8(%ebp),%eax
 1cc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1cf:	8b 75 10             	mov    0x10(%ebp),%esi
memmove(void *vdst, void *vsrc, int n)
 1d2:	31 d2                	xor    %edx,%edx
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1d4:	85 f6                	test   %esi,%esi
 1d6:	7e 0b                	jle    1e3 <memmove+0x1f>
    *dst++ = *src++;
 1d8:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 1db:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 1de:	42                   	inc    %edx
  while(n-- > 0)
 1df:	39 f2                	cmp    %esi,%edx
 1e1:	75 f5                	jne    1d8 <memmove+0x14>
  return vdst;
}
 1e3:	5b                   	pop    %ebx
 1e4:	5e                   	pop    %esi
 1e5:	5d                   	pop    %ebp
 1e6:	c3                   	ret    

000001e7 <fork>:
 1e7:	b8 01 00 00 00       	mov    $0x1,%eax
 1ec:	cd 40                	int    $0x40
 1ee:	c3                   	ret    

000001ef <exit>:
 1ef:	b8 02 00 00 00       	mov    $0x2,%eax
 1f4:	cd 40                	int    $0x40
 1f6:	c3                   	ret    

000001f7 <wait>:
 1f7:	b8 03 00 00 00       	mov    $0x3,%eax
 1fc:	cd 40                	int    $0x40
 1fe:	c3                   	ret    

000001ff <pipe>:
 1ff:	b8 04 00 00 00       	mov    $0x4,%eax
 204:	cd 40                	int    $0x40
 206:	c3                   	ret    

00000207 <read>:
 207:	b8 05 00 00 00       	mov    $0x5,%eax
 20c:	cd 40                	int    $0x40
 20e:	c3                   	ret    

0000020f <write>:
 20f:	b8 10 00 00 00       	mov    $0x10,%eax
 214:	cd 40                	int    $0x40
 216:	c3                   	ret    

00000217 <close>:
 217:	b8 15 00 00 00       	mov    $0x15,%eax
 21c:	cd 40                	int    $0x40
 21e:	c3                   	ret    

0000021f <kill>:
 21f:	b8 06 00 00 00       	mov    $0x6,%eax
 224:	cd 40                	int    $0x40
 226:	c3                   	ret    

00000227 <exec>:
 227:	b8 07 00 00 00       	mov    $0x7,%eax
 22c:	cd 40                	int    $0x40
 22e:	c3                   	ret    

0000022f <open>:
 22f:	b8 0f 00 00 00       	mov    $0xf,%eax
 234:	cd 40                	int    $0x40
 236:	c3                   	ret    

00000237 <mknod>:
 237:	b8 11 00 00 00       	mov    $0x11,%eax
 23c:	cd 40                	int    $0x40
 23e:	c3                   	ret    

0000023f <unlink>:
 23f:	b8 12 00 00 00       	mov    $0x12,%eax
 244:	cd 40                	int    $0x40
 246:	c3                   	ret    

00000247 <fstat>:
 247:	b8 08 00 00 00       	mov    $0x8,%eax
 24c:	cd 40                	int    $0x40
 24e:	c3                   	ret    

0000024f <link>:
 24f:	b8 13 00 00 00       	mov    $0x13,%eax
 254:	cd 40                	int    $0x40
 256:	c3                   	ret    

00000257 <mkdir>:
 257:	b8 14 00 00 00       	mov    $0x14,%eax
 25c:	cd 40                	int    $0x40
 25e:	c3                   	ret    

0000025f <chdir>:
 25f:	b8 09 00 00 00       	mov    $0x9,%eax
 264:	cd 40                	int    $0x40
 266:	c3                   	ret    

00000267 <dup>:
 267:	b8 0a 00 00 00       	mov    $0xa,%eax
 26c:	cd 40                	int    $0x40
 26e:	c3                   	ret    

0000026f <getpid>:
 26f:	b8 0b 00 00 00       	mov    $0xb,%eax
 274:	cd 40                	int    $0x40
 276:	c3                   	ret    

00000277 <sbrk>:
 277:	b8 0c 00 00 00       	mov    $0xc,%eax
 27c:	cd 40                	int    $0x40
 27e:	c3                   	ret    

0000027f <sleep>:
 27f:	b8 0d 00 00 00       	mov    $0xd,%eax
 284:	cd 40                	int    $0x40
 286:	c3                   	ret    

00000287 <uptime>:
 287:	b8 0e 00 00 00       	mov    $0xe,%eax
 28c:	cd 40                	int    $0x40
 28e:	c3                   	ret    

0000028f <getprocnum>:
 28f:	b8 16 00 00 00       	mov    $0x16,%eax
 294:	cd 40                	int    $0x40
 296:	c3                   	ret    

00000297 <mempagenum>:
 297:	b8 17 00 00 00       	mov    $0x17,%eax
 29c:	cd 40                	int    $0x40
 29e:	c3                   	ret    

0000029f <syscallnum>:
 29f:	b8 18 00 00 00       	mov    $0x18,%eax
 2a4:	cd 40                	int    $0x40
 2a6:	c3                   	ret    

000002a7 <settickets>:
 2a7:	b8 19 00 00 00       	mov    $0x19,%eax
 2ac:	cd 40                	int    $0x40
 2ae:	c3                   	ret    

000002af <getsheltime>:
 2af:	b8 1a 00 00 00       	mov    $0x1a,%eax
 2b4:	cd 40                	int    $0x40
 2b6:	c3                   	ret    

000002b7 <setstride>:
 2b7:	b8 1b 00 00 00       	mov    $0x1b,%eax
 2bc:	cd 40                	int    $0x40
 2be:	c3                   	ret    

000002bf <setpass>:
 2bf:	b8 1c 00 00 00       	mov    $0x1c,%eax
 2c4:	cd 40                	int    $0x40
 2c6:	c3                   	ret    

000002c7 <join>:
 2c7:	b8 1d 00 00 00       	mov    $0x1d,%eax
 2cc:	cd 40                	int    $0x40
 2ce:	c3                   	ret    

000002cf <clone1>:
 2cf:	b8 1e 00 00 00       	mov    $0x1e,%eax
 2d4:	cd 40                	int    $0x40
 2d6:	c3                   	ret    
 2d7:	90                   	nop

000002d8 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 2d8:	55                   	push   %ebp
 2d9:	89 e5                	mov    %esp,%ebp
 2db:	57                   	push   %edi
 2dc:	56                   	push   %esi
 2dd:	53                   	push   %ebx
 2de:	83 ec 3c             	sub    $0x3c,%esp
 2e1:	89 c7                	mov    %eax,%edi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 2e3:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 2e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
 2e8:	85 db                	test   %ebx,%ebx
 2ea:	74 04                	je     2f0 <printint+0x18>
 2ec:	85 d2                	test   %edx,%edx
 2ee:	78 5d                	js     34d <printint+0x75>
  neg = 0;
 2f0:	31 db                	xor    %ebx,%ebx
  } else {
    x = xx;
  }

  i = 0;
 2f2:	31 f6                	xor    %esi,%esi
 2f4:	eb 04                	jmp    2fa <printint+0x22>
 2f6:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 2f8:	89 d6                	mov    %edx,%esi
 2fa:	31 d2                	xor    %edx,%edx
 2fc:	f7 f1                	div    %ecx
 2fe:	8a 92 81 06 00 00    	mov    0x681(%edx),%dl
 304:	88 54 35 d8          	mov    %dl,-0x28(%ebp,%esi,1)
 308:	8d 56 01             	lea    0x1(%esi),%edx
  }while((x /= base) != 0);
 30b:	85 c0                	test   %eax,%eax
 30d:	75 e9                	jne    2f8 <printint+0x20>
  if(neg)
 30f:	85 db                	test   %ebx,%ebx
 311:	74 08                	je     31b <printint+0x43>
    buf[i++] = '-';
 313:	c6 44 15 d8 2d       	movb   $0x2d,-0x28(%ebp,%edx,1)
 318:	8d 56 02             	lea    0x2(%esi),%edx

  while(--i >= 0)
 31b:	8d 5a ff             	lea    -0x1(%edx),%ebx
 31e:	8d 75 d7             	lea    -0x29(%ebp),%esi
 321:	8d 76 00             	lea    0x0(%esi),%esi
 324:	8a 44 1d d8          	mov    -0x28(%ebp,%ebx,1),%al
 328:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 32b:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 332:	00 
 333:	89 74 24 04          	mov    %esi,0x4(%esp)
 337:	89 3c 24             	mov    %edi,(%esp)
 33a:	e8 d0 fe ff ff       	call   20f <write>
  while(--i >= 0)
 33f:	4b                   	dec    %ebx
 340:	83 fb ff             	cmp    $0xffffffff,%ebx
 343:	75 df                	jne    324 <printint+0x4c>
    putc(fd, buf[i]);
}
 345:	83 c4 3c             	add    $0x3c,%esp
 348:	5b                   	pop    %ebx
 349:	5e                   	pop    %esi
 34a:	5f                   	pop    %edi
 34b:	5d                   	pop    %ebp
 34c:	c3                   	ret    
    x = -xx;
 34d:	f7 d8                	neg    %eax
    neg = 1;
 34f:	bb 01 00 00 00       	mov    $0x1,%ebx
    x = -xx;
 354:	eb 9c                	jmp    2f2 <printint+0x1a>
 356:	66 90                	xchg   %ax,%ax

00000358 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 358:	55                   	push   %ebp
 359:	89 e5                	mov    %esp,%ebp
 35b:	57                   	push   %edi
 35c:	56                   	push   %esi
 35d:	53                   	push   %ebx
 35e:	83 ec 3c             	sub    $0x3c,%esp
 361:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 364:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 367:	8a 03                	mov    (%ebx),%al
 369:	84 c0                	test   %al,%al
 36b:	0f 84 bb 00 00 00    	je     42c <printf+0xd4>
printf(int fd, char *fmt, ...)
 371:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
 372:	8d 55 10             	lea    0x10(%ebp),%edx
 375:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  state = 0;
 378:	31 ff                	xor    %edi,%edi
 37a:	eb 2f                	jmp    3ab <printf+0x53>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 37c:	83 f9 25             	cmp    $0x25,%ecx
 37f:	0f 84 af 00 00 00    	je     434 <printf+0xdc>
        state = '%';
      } else {
        putc(fd, c);
 385:	88 4d e2             	mov    %cl,-0x1e(%ebp)
  write(fd, &c, 1);
 388:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 38f:	00 
 390:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 393:	89 44 24 04          	mov    %eax,0x4(%esp)
 397:	89 34 24             	mov    %esi,(%esp)
 39a:	e8 70 fe ff ff       	call   20f <write>
 39f:	43                   	inc    %ebx
  for(i = 0; fmt[i]; i++){
 3a0:	8a 43 ff             	mov    -0x1(%ebx),%al
 3a3:	84 c0                	test   %al,%al
 3a5:	0f 84 81 00 00 00    	je     42c <printf+0xd4>
    c = fmt[i] & 0xff;
 3ab:	0f b6 c8             	movzbl %al,%ecx
    if(state == 0){
 3ae:	85 ff                	test   %edi,%edi
 3b0:	74 ca                	je     37c <printf+0x24>
      }
    } else if(state == '%'){
 3b2:	83 ff 25             	cmp    $0x25,%edi
 3b5:	75 e8                	jne    39f <printf+0x47>
      if(c == 'd'){
 3b7:	83 f9 64             	cmp    $0x64,%ecx
 3ba:	0f 84 14 01 00 00    	je     4d4 <printf+0x17c>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 3c0:	83 f9 78             	cmp    $0x78,%ecx
 3c3:	74 7b                	je     440 <printf+0xe8>
 3c5:	83 f9 70             	cmp    $0x70,%ecx
 3c8:	74 76                	je     440 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 3ca:	83 f9 73             	cmp    $0x73,%ecx
 3cd:	0f 84 91 00 00 00    	je     464 <printf+0x10c>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 3d3:	83 f9 63             	cmp    $0x63,%ecx
 3d6:	0f 84 cc 00 00 00    	je     4a8 <printf+0x150>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 3dc:	83 f9 25             	cmp    $0x25,%ecx
 3df:	0f 84 13 01 00 00    	je     4f8 <printf+0x1a0>
 3e5:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
  write(fd, &c, 1);
 3e9:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3f0:	00 
 3f1:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 3f4:	89 44 24 04          	mov    %eax,0x4(%esp)
 3f8:	89 34 24             	mov    %esi,(%esp)
 3fb:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 3fe:	e8 0c fe ff ff       	call   20f <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 403:	8b 4d d0             	mov    -0x30(%ebp),%ecx
 406:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
 409:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 410:	00 
 411:	8d 55 e7             	lea    -0x19(%ebp),%edx
 414:	89 54 24 04          	mov    %edx,0x4(%esp)
 418:	89 34 24             	mov    %esi,(%esp)
 41b:	e8 ef fd ff ff       	call   20f <write>
      }
      state = 0;
 420:	31 ff                	xor    %edi,%edi
 422:	43                   	inc    %ebx
  for(i = 0; fmt[i]; i++){
 423:	8a 43 ff             	mov    -0x1(%ebx),%al
 426:	84 c0                	test   %al,%al
 428:	75 81                	jne    3ab <printf+0x53>
 42a:	66 90                	xchg   %ax,%ax
    }
  }
}
 42c:	83 c4 3c             	add    $0x3c,%esp
 42f:	5b                   	pop    %ebx
 430:	5e                   	pop    %esi
 431:	5f                   	pop    %edi
 432:	5d                   	pop    %ebp
 433:	c3                   	ret    
        state = '%';
 434:	bf 25 00 00 00       	mov    $0x25,%edi
 439:	e9 61 ff ff ff       	jmp    39f <printf+0x47>
 43e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 440:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 447:	b9 10 00 00 00       	mov    $0x10,%ecx
 44c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 44f:	8b 10                	mov    (%eax),%edx
 451:	89 f0                	mov    %esi,%eax
 453:	e8 80 fe ff ff       	call   2d8 <printint>
        ap++;
 458:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 45c:	31 ff                	xor    %edi,%edi
        ap++;
 45e:	e9 3c ff ff ff       	jmp    39f <printf+0x47>
 463:	90                   	nop
        s = (char*)*ap;
 464:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 467:	8b 3a                	mov    (%edx),%edi
        ap++;
 469:	83 c2 04             	add    $0x4,%edx
 46c:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
 46f:	85 ff                	test   %edi,%edi
 471:	0f 84 a3 00 00 00    	je     51a <printf+0x1c2>
        while(*s != 0){
 477:	8a 07                	mov    (%edi),%al
 479:	84 c0                	test   %al,%al
 47b:	74 24                	je     4a1 <printf+0x149>
 47d:	8d 76 00             	lea    0x0(%esi),%esi
 480:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 483:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 48a:	00 
 48b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 48e:	89 44 24 04          	mov    %eax,0x4(%esp)
 492:	89 34 24             	mov    %esi,(%esp)
 495:	e8 75 fd ff ff       	call   20f <write>
          s++;
 49a:	47                   	inc    %edi
        while(*s != 0){
 49b:	8a 07                	mov    (%edi),%al
 49d:	84 c0                	test   %al,%al
 49f:	75 df                	jne    480 <printf+0x128>
      state = 0;
 4a1:	31 ff                	xor    %edi,%edi
 4a3:	e9 f7 fe ff ff       	jmp    39f <printf+0x47>
        putc(fd, *ap);
 4a8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 4ab:	8b 02                	mov    (%edx),%eax
 4ad:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 4b0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4b7:	00 
 4b8:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 4bb:	89 44 24 04          	mov    %eax,0x4(%esp)
 4bf:	89 34 24             	mov    %esi,(%esp)
 4c2:	e8 48 fd ff ff       	call   20f <write>
        ap++;
 4c7:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 4cb:	31 ff                	xor    %edi,%edi
 4cd:	e9 cd fe ff ff       	jmp    39f <printf+0x47>
 4d2:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 4d4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 4db:	b1 0a                	mov    $0xa,%cl
 4dd:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 4e0:	8b 10                	mov    (%eax),%edx
 4e2:	89 f0                	mov    %esi,%eax
 4e4:	e8 ef fd ff ff       	call   2d8 <printint>
        ap++;
 4e9:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 4ed:	66 31 ff             	xor    %di,%di
 4f0:	e9 aa fe ff ff       	jmp    39f <printf+0x47>
 4f5:	8d 76 00             	lea    0x0(%esi),%esi
 4f8:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
  write(fd, &c, 1);
 4fc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 503:	00 
 504:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 507:	89 44 24 04          	mov    %eax,0x4(%esp)
 50b:	89 34 24             	mov    %esi,(%esp)
 50e:	e8 fc fc ff ff       	call   20f <write>
      state = 0;
 513:	31 ff                	xor    %edi,%edi
 515:	e9 85 fe ff ff       	jmp    39f <printf+0x47>
          s = "(null)";
 51a:	bf 7a 06 00 00       	mov    $0x67a,%edi
 51f:	e9 53 ff ff ff       	jmp    477 <printf+0x11f>

00000524 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 524:	55                   	push   %ebp
 525:	89 e5                	mov    %esp,%ebp
 527:	57                   	push   %edi
 528:	56                   	push   %esi
 529:	53                   	push   %ebx
 52a:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 52d:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 530:	a1 14 09 00 00       	mov    0x914,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 535:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 537:	39 d0                	cmp    %edx,%eax
 539:	72 11                	jb     54c <free+0x28>
 53b:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 53c:	39 c8                	cmp    %ecx,%eax
 53e:	72 04                	jb     544 <free+0x20>
 540:	39 ca                	cmp    %ecx,%edx
 542:	72 10                	jb     554 <free+0x30>
 544:	89 c8                	mov    %ecx,%eax
 546:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 548:	39 d0                	cmp    %edx,%eax
 54a:	73 f0                	jae    53c <free+0x18>
 54c:	39 ca                	cmp    %ecx,%edx
 54e:	72 04                	jb     554 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 550:	39 c8                	cmp    %ecx,%eax
 552:	72 f0                	jb     544 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 554:	8b 73 fc             	mov    -0x4(%ebx),%esi
 557:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 55a:	39 cf                	cmp    %ecx,%edi
 55c:	74 1a                	je     578 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 55e:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 561:	8b 48 04             	mov    0x4(%eax),%ecx
 564:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 567:	39 f2                	cmp    %esi,%edx
 569:	74 24                	je     58f <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 56b:	89 10                	mov    %edx,(%eax)
  freep = p;
 56d:	a3 14 09 00 00       	mov    %eax,0x914
}
 572:	5b                   	pop    %ebx
 573:	5e                   	pop    %esi
 574:	5f                   	pop    %edi
 575:	5d                   	pop    %ebp
 576:	c3                   	ret    
 577:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 578:	03 71 04             	add    0x4(%ecx),%esi
 57b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 57e:	8b 08                	mov    (%eax),%ecx
 580:	8b 09                	mov    (%ecx),%ecx
 582:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 585:	8b 48 04             	mov    0x4(%eax),%ecx
 588:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 58b:	39 f2                	cmp    %esi,%edx
 58d:	75 dc                	jne    56b <free+0x47>
    p->s.size += bp->s.size;
 58f:	03 4b fc             	add    -0x4(%ebx),%ecx
 592:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 595:	8b 53 f8             	mov    -0x8(%ebx),%edx
 598:	89 10                	mov    %edx,(%eax)
  freep = p;
 59a:	a3 14 09 00 00       	mov    %eax,0x914
}
 59f:	5b                   	pop    %ebx
 5a0:	5e                   	pop    %esi
 5a1:	5f                   	pop    %edi
 5a2:	5d                   	pop    %ebp
 5a3:	c3                   	ret    

000005a4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 5a4:	55                   	push   %ebp
 5a5:	89 e5                	mov    %esp,%ebp
 5a7:	57                   	push   %edi
 5a8:	56                   	push   %esi
 5a9:	53                   	push   %ebx
 5aa:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5ad:	8b 75 08             	mov    0x8(%ebp),%esi
 5b0:	83 c6 07             	add    $0x7,%esi
 5b3:	c1 ee 03             	shr    $0x3,%esi
 5b6:	46                   	inc    %esi
  if((prevp = freep) == 0){
 5b7:	8b 15 14 09 00 00    	mov    0x914,%edx
 5bd:	85 d2                	test   %edx,%edx
 5bf:	0f 84 8d 00 00 00    	je     652 <malloc+0xae>
 5c5:	8b 02                	mov    (%edx),%eax
 5c7:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 5ca:	39 ce                	cmp    %ecx,%esi
 5cc:	76 52                	jbe    620 <malloc+0x7c>
 5ce:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 5d5:	eb 0a                	jmp    5e1 <malloc+0x3d>
 5d7:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5d8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 5da:	8b 48 04             	mov    0x4(%eax),%ecx
 5dd:	39 ce                	cmp    %ecx,%esi
 5df:	76 3f                	jbe    620 <malloc+0x7c>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 5e1:	89 c2                	mov    %eax,%edx
 5e3:	3b 05 14 09 00 00    	cmp    0x914,%eax
 5e9:	75 ed                	jne    5d8 <malloc+0x34>
  if(nu < 4096)
 5eb:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 5f1:	76 4d                	jbe    640 <malloc+0x9c>
 5f3:	89 d8                	mov    %ebx,%eax
 5f5:	89 f7                	mov    %esi,%edi
  p = sbrk(nu * sizeof(Header));
 5f7:	89 04 24             	mov    %eax,(%esp)
 5fa:	e8 78 fc ff ff       	call   277 <sbrk>
  if(p == (char*)-1)
 5ff:	83 f8 ff             	cmp    $0xffffffff,%eax
 602:	74 18                	je     61c <malloc+0x78>
  hp->s.size = nu;
 604:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 607:	83 c0 08             	add    $0x8,%eax
 60a:	89 04 24             	mov    %eax,(%esp)
 60d:	e8 12 ff ff ff       	call   524 <free>
  return freep;
 612:	8b 15 14 09 00 00    	mov    0x914,%edx
      if((p = morecore(nunits)) == 0)
 618:	85 d2                	test   %edx,%edx
 61a:	75 bc                	jne    5d8 <malloc+0x34>
        return 0;
 61c:	31 c0                	xor    %eax,%eax
 61e:	eb 18                	jmp    638 <malloc+0x94>
      if(p->s.size == nunits)
 620:	39 ce                	cmp    %ecx,%esi
 622:	74 28                	je     64c <malloc+0xa8>
        p->s.size -= nunits;
 624:	29 f1                	sub    %esi,%ecx
 626:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 629:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 62c:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 62f:	89 15 14 09 00 00    	mov    %edx,0x914
      return (void*)(p + 1);
 635:	83 c0 08             	add    $0x8,%eax
  }
}
 638:	83 c4 1c             	add    $0x1c,%esp
 63b:	5b                   	pop    %ebx
 63c:	5e                   	pop    %esi
 63d:	5f                   	pop    %edi
 63e:	5d                   	pop    %ebp
 63f:	c3                   	ret    
  if(nu < 4096)
 640:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 645:	bf 00 10 00 00       	mov    $0x1000,%edi
 64a:	eb ab                	jmp    5f7 <malloc+0x53>
        prevp->s.ptr = p->s.ptr;
 64c:	8b 08                	mov    (%eax),%ecx
 64e:	89 0a                	mov    %ecx,(%edx)
 650:	eb dd                	jmp    62f <malloc+0x8b>
    base.s.ptr = freep = prevp = &base;
 652:	c7 05 14 09 00 00 18 	movl   $0x918,0x914
 659:	09 00 00 
 65c:	c7 05 18 09 00 00 18 	movl   $0x918,0x918
 663:	09 00 00 
    base.s.size = 0;
 666:	c7 05 1c 09 00 00 00 	movl   $0x0,0x91c
 66d:	00 00 00 
 670:	b8 18 09 00 00       	mov    $0x918,%eax
 675:	e9 54 ff ff ff       	jmp    5ce <malloc+0x2a>
