
_echo：     文件格式 elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
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

  for(i = 1; i < argc; i++)
  12:	83 fe 01             	cmp    $0x1,%esi
  15:	7e 5a                	jle    71 <main+0x71>
  17:	bb 01 00 00 00       	mov    $0x1,%ebx
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  1c:	43                   	inc    %ebx
  1d:	39 f3                	cmp    %esi,%ebx
  1f:	74 2c                	je     4d <main+0x4d>
  21:	8d 76 00             	lea    0x0(%esi),%esi
  24:	c7 44 24 0c ce 06 00 	movl   $0x6ce,0xc(%esp)
  2b:	00 
  2c:	8b 44 9f fc          	mov    -0x4(%edi,%ebx,4),%eax
  30:	89 44 24 08          	mov    %eax,0x8(%esp)
  34:	c7 44 24 04 d0 06 00 	movl   $0x6d0,0x4(%esp)
  3b:	00 
  3c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  43:	e8 64 03 00 00       	call   3ac <printf>
  48:	43                   	inc    %ebx
  49:	39 f3                	cmp    %esi,%ebx
  4b:	75 d7                	jne    24 <main+0x24>
  4d:	c7 44 24 0c d5 06 00 	movl   $0x6d5,0xc(%esp)
  54:	00 
  55:	8b 44 9f fc          	mov    -0x4(%edi,%ebx,4),%eax
  59:	89 44 24 08          	mov    %eax,0x8(%esp)
  5d:	c7 44 24 04 d0 06 00 	movl   $0x6d0,0x4(%esp)
  64:	00 
  65:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  6c:	e8 3b 03 00 00       	call   3ac <printf>
  exit();
  71:	e8 cd 01 00 00       	call   243 <exit>
  76:	66 90                	xchg   %ax,%ax

00000078 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  78:	55                   	push   %ebp
  79:	89 e5                	mov    %esp,%ebp
  7b:	53                   	push   %ebx
  7c:	8b 45 08             	mov    0x8(%ebp),%eax
  7f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  82:	89 c2                	mov    %eax,%edx
  84:	8a 19                	mov    (%ecx),%bl
  86:	88 1a                	mov    %bl,(%edx)
  88:	42                   	inc    %edx
  89:	41                   	inc    %ecx
  8a:	84 db                	test   %bl,%bl
  8c:	75 f6                	jne    84 <strcpy+0xc>
    ;
  return os;
}
  8e:	5b                   	pop    %ebx
  8f:	5d                   	pop    %ebp
  90:	c3                   	ret    
  91:	8d 76 00             	lea    0x0(%esi),%esi

00000094 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  94:	55                   	push   %ebp
  95:	89 e5                	mov    %esp,%ebp
  97:	56                   	push   %esi
  98:	53                   	push   %ebx
  99:	8b 55 08             	mov    0x8(%ebp),%edx
  9c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  9f:	0f b6 02             	movzbl (%edx),%eax
  a2:	0f b6 19             	movzbl (%ecx),%ebx
  a5:	84 c0                	test   %al,%al
  a7:	75 14                	jne    bd <strcmp+0x29>
  a9:	eb 1d                	jmp    c8 <strcmp+0x34>
  ab:	90                   	nop
    p++, q++;
  ac:	42                   	inc    %edx
  ad:	8d 71 01             	lea    0x1(%ecx),%esi
  while(*p && *p == *q)
  b0:	0f b6 02             	movzbl (%edx),%eax
  b3:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  b7:	84 c0                	test   %al,%al
  b9:	74 0d                	je     c8 <strcmp+0x34>
    p++, q++;
  bb:	89 f1                	mov    %esi,%ecx
  while(*p && *p == *q)
  bd:	38 d8                	cmp    %bl,%al
  bf:	74 eb                	je     ac <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
  c1:	29 d8                	sub    %ebx,%eax
}
  c3:	5b                   	pop    %ebx
  c4:	5e                   	pop    %esi
  c5:	5d                   	pop    %ebp
  c6:	c3                   	ret    
  c7:	90                   	nop
  while(*p && *p == *q)
  c8:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  ca:	29 d8                	sub    %ebx,%eax
}
  cc:	5b                   	pop    %ebx
  cd:	5e                   	pop    %esi
  ce:	5d                   	pop    %ebp
  cf:	c3                   	ret    

000000d0 <strlen>:

uint
strlen(char *s)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  d6:	80 39 00             	cmpb   $0x0,(%ecx)
  d9:	74 10                	je     eb <strlen+0x1b>
  db:	31 d2                	xor    %edx,%edx
  dd:	8d 76 00             	lea    0x0(%esi),%esi
  e0:	42                   	inc    %edx
  e1:	89 d0                	mov    %edx,%eax
  e3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  e7:	75 f7                	jne    e0 <strlen+0x10>
    ;
  return n;
}
  e9:	5d                   	pop    %ebp
  ea:	c3                   	ret    
  for(n = 0; s[n]; n++)
  eb:	31 c0                	xor    %eax,%eax
}
  ed:	5d                   	pop    %ebp
  ee:	c3                   	ret    
  ef:	90                   	nop

000000f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	57                   	push   %edi
  f4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  f7:	89 d7                	mov    %edx,%edi
  f9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  ff:	fc                   	cld    
 100:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 102:	89 d0                	mov    %edx,%eax
 104:	5f                   	pop    %edi
 105:	5d                   	pop    %ebp
 106:	c3                   	ret    
 107:	90                   	nop

00000108 <strchr>:

char*
strchr(const char *s, char c)
{
 108:	55                   	push   %ebp
 109:	89 e5                	mov    %esp,%ebp
 10b:	8b 45 08             	mov    0x8(%ebp),%eax
 10e:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
 111:	8a 10                	mov    (%eax),%dl
 113:	84 d2                	test   %dl,%dl
 115:	75 0c                	jne    123 <strchr+0x1b>
 117:	eb 13                	jmp    12c <strchr+0x24>
 119:	8d 76 00             	lea    0x0(%esi),%esi
 11c:	40                   	inc    %eax
 11d:	8a 10                	mov    (%eax),%dl
 11f:	84 d2                	test   %dl,%dl
 121:	74 09                	je     12c <strchr+0x24>
    if(*s == c)
 123:	38 ca                	cmp    %cl,%dl
 125:	75 f5                	jne    11c <strchr+0x14>
      return (char*)s;
  return 0;
}
 127:	5d                   	pop    %ebp
 128:	c3                   	ret    
 129:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
 12c:	31 c0                	xor    %eax,%eax
}
 12e:	5d                   	pop    %ebp
 12f:	c3                   	ret    

00000130 <gets>:

char*
gets(char *buf, int max)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	57                   	push   %edi
 134:	56                   	push   %esi
 135:	53                   	push   %ebx
 136:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 139:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
 13b:	8d 7d e7             	lea    -0x19(%ebp),%edi
 13e:	66 90                	xchg   %ax,%ax
  for(i=0; i+1 < max; ){
 140:	8d 73 01             	lea    0x1(%ebx),%esi
 143:	3b 75 0c             	cmp    0xc(%ebp),%esi
 146:	7d 40                	jge    188 <gets+0x58>
    cc = read(0, &c, 1);
 148:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 14f:	00 
 150:	89 7c 24 04          	mov    %edi,0x4(%esp)
 154:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 15b:	e8 fb 00 00 00       	call   25b <read>
    if(cc < 1)
 160:	85 c0                	test   %eax,%eax
 162:	7e 24                	jle    188 <gets+0x58>
      break;
    buf[i++] = c;
 164:	8a 45 e7             	mov    -0x19(%ebp),%al
 167:	8b 55 08             	mov    0x8(%ebp),%edx
 16a:	88 44 32 ff          	mov    %al,-0x1(%edx,%esi,1)
    if(c == '\n' || c == '\r')
 16e:	3c 0a                	cmp    $0xa,%al
 170:	74 06                	je     178 <gets+0x48>
 172:	89 f3                	mov    %esi,%ebx
 174:	3c 0d                	cmp    $0xd,%al
 176:	75 c8                	jne    140 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 178:	8b 45 08             	mov    0x8(%ebp),%eax
 17b:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 17f:	83 c4 2c             	add    $0x2c,%esp
 182:	5b                   	pop    %ebx
 183:	5e                   	pop    %esi
 184:	5f                   	pop    %edi
 185:	5d                   	pop    %ebp
 186:	c3                   	ret    
 187:	90                   	nop
    if(cc < 1)
 188:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 18a:	8b 45 08             	mov    0x8(%ebp),%eax
 18d:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 191:	83 c4 2c             	add    $0x2c,%esp
 194:	5b                   	pop    %ebx
 195:	5e                   	pop    %esi
 196:	5f                   	pop    %edi
 197:	5d                   	pop    %ebp
 198:	c3                   	ret    
 199:	8d 76 00             	lea    0x0(%esi),%esi

0000019c <stat>:

int
stat(char *n, struct stat *st)
{
 19c:	55                   	push   %ebp
 19d:	89 e5                	mov    %esp,%ebp
 19f:	56                   	push   %esi
 1a0:	53                   	push   %ebx
 1a1:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1a4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1ab:	00 
 1ac:	8b 45 08             	mov    0x8(%ebp),%eax
 1af:	89 04 24             	mov    %eax,(%esp)
 1b2:	e8 cc 00 00 00       	call   283 <open>
 1b7:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 1b9:	85 c0                	test   %eax,%eax
 1bb:	78 23                	js     1e0 <stat+0x44>
    return -1;
  r = fstat(fd, st);
 1bd:	8b 45 0c             	mov    0xc(%ebp),%eax
 1c0:	89 44 24 04          	mov    %eax,0x4(%esp)
 1c4:	89 1c 24             	mov    %ebx,(%esp)
 1c7:	e8 cf 00 00 00       	call   29b <fstat>
 1cc:	89 c6                	mov    %eax,%esi
  close(fd);
 1ce:	89 1c 24             	mov    %ebx,(%esp)
 1d1:	e8 95 00 00 00       	call   26b <close>
  return r;
}
 1d6:	89 f0                	mov    %esi,%eax
 1d8:	83 c4 10             	add    $0x10,%esp
 1db:	5b                   	pop    %ebx
 1dc:	5e                   	pop    %esi
 1dd:	5d                   	pop    %ebp
 1de:	c3                   	ret    
 1df:	90                   	nop
    return -1;
 1e0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1e5:	eb ef                	jmp    1d6 <stat+0x3a>
 1e7:	90                   	nop

000001e8 <atoi>:

int
atoi(const char *s)
{
 1e8:	55                   	push   %ebp
 1e9:	89 e5                	mov    %esp,%ebp
 1eb:	53                   	push   %ebx
 1ec:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1ef:	0f be 11             	movsbl (%ecx),%edx
 1f2:	8d 42 d0             	lea    -0x30(%edx),%eax
 1f5:	3c 09                	cmp    $0x9,%al
 1f7:	b8 00 00 00 00       	mov    $0x0,%eax
 1fc:	77 15                	ja     213 <atoi+0x2b>
 1fe:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 200:	8d 04 80             	lea    (%eax,%eax,4),%eax
 203:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
 207:	41                   	inc    %ecx
  while('0' <= *s && *s <= '9')
 208:	0f be 11             	movsbl (%ecx),%edx
 20b:	8d 5a d0             	lea    -0x30(%edx),%ebx
 20e:	80 fb 09             	cmp    $0x9,%bl
 211:	76 ed                	jbe    200 <atoi+0x18>
  return n;
}
 213:	5b                   	pop    %ebx
 214:	5d                   	pop    %ebp
 215:	c3                   	ret    
 216:	66 90                	xchg   %ax,%ax

00000218 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 218:	55                   	push   %ebp
 219:	89 e5                	mov    %esp,%ebp
 21b:	56                   	push   %esi
 21c:	53                   	push   %ebx
 21d:	8b 45 08             	mov    0x8(%ebp),%eax
 220:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 223:	8b 75 10             	mov    0x10(%ebp),%esi
memmove(void *vdst, void *vsrc, int n)
 226:	31 d2                	xor    %edx,%edx
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 228:	85 f6                	test   %esi,%esi
 22a:	7e 0b                	jle    237 <memmove+0x1f>
    *dst++ = *src++;
 22c:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 22f:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 232:	42                   	inc    %edx
  while(n-- > 0)
 233:	39 f2                	cmp    %esi,%edx
 235:	75 f5                	jne    22c <memmove+0x14>
  return vdst;
}
 237:	5b                   	pop    %ebx
 238:	5e                   	pop    %esi
 239:	5d                   	pop    %ebp
 23a:	c3                   	ret    

0000023b <fork>:
 23b:	b8 01 00 00 00       	mov    $0x1,%eax
 240:	cd 40                	int    $0x40
 242:	c3                   	ret    

00000243 <exit>:
 243:	b8 02 00 00 00       	mov    $0x2,%eax
 248:	cd 40                	int    $0x40
 24a:	c3                   	ret    

0000024b <wait>:
 24b:	b8 03 00 00 00       	mov    $0x3,%eax
 250:	cd 40                	int    $0x40
 252:	c3                   	ret    

00000253 <pipe>:
 253:	b8 04 00 00 00       	mov    $0x4,%eax
 258:	cd 40                	int    $0x40
 25a:	c3                   	ret    

0000025b <read>:
 25b:	b8 05 00 00 00       	mov    $0x5,%eax
 260:	cd 40                	int    $0x40
 262:	c3                   	ret    

00000263 <write>:
 263:	b8 10 00 00 00       	mov    $0x10,%eax
 268:	cd 40                	int    $0x40
 26a:	c3                   	ret    

0000026b <close>:
 26b:	b8 15 00 00 00       	mov    $0x15,%eax
 270:	cd 40                	int    $0x40
 272:	c3                   	ret    

00000273 <kill>:
 273:	b8 06 00 00 00       	mov    $0x6,%eax
 278:	cd 40                	int    $0x40
 27a:	c3                   	ret    

0000027b <exec>:
 27b:	b8 07 00 00 00       	mov    $0x7,%eax
 280:	cd 40                	int    $0x40
 282:	c3                   	ret    

00000283 <open>:
 283:	b8 0f 00 00 00       	mov    $0xf,%eax
 288:	cd 40                	int    $0x40
 28a:	c3                   	ret    

0000028b <mknod>:
 28b:	b8 11 00 00 00       	mov    $0x11,%eax
 290:	cd 40                	int    $0x40
 292:	c3                   	ret    

00000293 <unlink>:
 293:	b8 12 00 00 00       	mov    $0x12,%eax
 298:	cd 40                	int    $0x40
 29a:	c3                   	ret    

0000029b <fstat>:
 29b:	b8 08 00 00 00       	mov    $0x8,%eax
 2a0:	cd 40                	int    $0x40
 2a2:	c3                   	ret    

000002a3 <link>:
 2a3:	b8 13 00 00 00       	mov    $0x13,%eax
 2a8:	cd 40                	int    $0x40
 2aa:	c3                   	ret    

000002ab <mkdir>:
 2ab:	b8 14 00 00 00       	mov    $0x14,%eax
 2b0:	cd 40                	int    $0x40
 2b2:	c3                   	ret    

000002b3 <chdir>:
 2b3:	b8 09 00 00 00       	mov    $0x9,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret    

000002bb <dup>:
 2bb:	b8 0a 00 00 00       	mov    $0xa,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret    

000002c3 <getpid>:
 2c3:	b8 0b 00 00 00       	mov    $0xb,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret    

000002cb <sbrk>:
 2cb:	b8 0c 00 00 00       	mov    $0xc,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret    

000002d3 <sleep>:
 2d3:	b8 0d 00 00 00       	mov    $0xd,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret    

000002db <uptime>:
 2db:	b8 0e 00 00 00       	mov    $0xe,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret    

000002e3 <getprocnum>:
 2e3:	b8 16 00 00 00       	mov    $0x16,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret    

000002eb <mempagenum>:
 2eb:	b8 17 00 00 00       	mov    $0x17,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret    

000002f3 <syscallnum>:
 2f3:	b8 18 00 00 00       	mov    $0x18,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret    

000002fb <settickets>:
 2fb:	b8 19 00 00 00       	mov    $0x19,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret    

00000303 <getsheltime>:
 303:	b8 1a 00 00 00       	mov    $0x1a,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret    

0000030b <setstride>:
 30b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret    

00000313 <setpass>:
 313:	b8 1c 00 00 00       	mov    $0x1c,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret    

0000031b <join>:
 31b:	b8 1d 00 00 00       	mov    $0x1d,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <clone1>:
 323:	b8 1e 00 00 00       	mov    $0x1e,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    
 32b:	90                   	nop

0000032c <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 32c:	55                   	push   %ebp
 32d:	89 e5                	mov    %esp,%ebp
 32f:	57                   	push   %edi
 330:	56                   	push   %esi
 331:	53                   	push   %ebx
 332:	83 ec 3c             	sub    $0x3c,%esp
 335:	89 c7                	mov    %eax,%edi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 337:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 339:	8b 5d 08             	mov    0x8(%ebp),%ebx
 33c:	85 db                	test   %ebx,%ebx
 33e:	74 04                	je     344 <printint+0x18>
 340:	85 d2                	test   %edx,%edx
 342:	78 5d                	js     3a1 <printint+0x75>
  neg = 0;
 344:	31 db                	xor    %ebx,%ebx
  } else {
    x = xx;
  }

  i = 0;
 346:	31 f6                	xor    %esi,%esi
 348:	eb 04                	jmp    34e <printint+0x22>
 34a:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 34c:	89 d6                	mov    %edx,%esi
 34e:	31 d2                	xor    %edx,%edx
 350:	f7 f1                	div    %ecx
 352:	8a 92 de 06 00 00    	mov    0x6de(%edx),%dl
 358:	88 54 35 d8          	mov    %dl,-0x28(%ebp,%esi,1)
 35c:	8d 56 01             	lea    0x1(%esi),%edx
  }while((x /= base) != 0);
 35f:	85 c0                	test   %eax,%eax
 361:	75 e9                	jne    34c <printint+0x20>
  if(neg)
 363:	85 db                	test   %ebx,%ebx
 365:	74 08                	je     36f <printint+0x43>
    buf[i++] = '-';
 367:	c6 44 15 d8 2d       	movb   $0x2d,-0x28(%ebp,%edx,1)
 36c:	8d 56 02             	lea    0x2(%esi),%edx

  while(--i >= 0)
 36f:	8d 5a ff             	lea    -0x1(%edx),%ebx
 372:	8d 75 d7             	lea    -0x29(%ebp),%esi
 375:	8d 76 00             	lea    0x0(%esi),%esi
 378:	8a 44 1d d8          	mov    -0x28(%ebp,%ebx,1),%al
 37c:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 37f:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 386:	00 
 387:	89 74 24 04          	mov    %esi,0x4(%esp)
 38b:	89 3c 24             	mov    %edi,(%esp)
 38e:	e8 d0 fe ff ff       	call   263 <write>
  while(--i >= 0)
 393:	4b                   	dec    %ebx
 394:	83 fb ff             	cmp    $0xffffffff,%ebx
 397:	75 df                	jne    378 <printint+0x4c>
    putc(fd, buf[i]);
}
 399:	83 c4 3c             	add    $0x3c,%esp
 39c:	5b                   	pop    %ebx
 39d:	5e                   	pop    %esi
 39e:	5f                   	pop    %edi
 39f:	5d                   	pop    %ebp
 3a0:	c3                   	ret    
    x = -xx;
 3a1:	f7 d8                	neg    %eax
    neg = 1;
 3a3:	bb 01 00 00 00       	mov    $0x1,%ebx
    x = -xx;
 3a8:	eb 9c                	jmp    346 <printint+0x1a>
 3aa:	66 90                	xchg   %ax,%ax

000003ac <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3ac:	55                   	push   %ebp
 3ad:	89 e5                	mov    %esp,%ebp
 3af:	57                   	push   %edi
 3b0:	56                   	push   %esi
 3b1:	53                   	push   %ebx
 3b2:	83 ec 3c             	sub    $0x3c,%esp
 3b5:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3b8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 3bb:	8a 03                	mov    (%ebx),%al
 3bd:	84 c0                	test   %al,%al
 3bf:	0f 84 bb 00 00 00    	je     480 <printf+0xd4>
printf(int fd, char *fmt, ...)
 3c5:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
 3c6:	8d 55 10             	lea    0x10(%ebp),%edx
 3c9:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  state = 0;
 3cc:	31 ff                	xor    %edi,%edi
 3ce:	eb 2f                	jmp    3ff <printf+0x53>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 3d0:	83 f9 25             	cmp    $0x25,%ecx
 3d3:	0f 84 af 00 00 00    	je     488 <printf+0xdc>
        state = '%';
      } else {
        putc(fd, c);
 3d9:	88 4d e2             	mov    %cl,-0x1e(%ebp)
  write(fd, &c, 1);
 3dc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3e3:	00 
 3e4:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 3e7:	89 44 24 04          	mov    %eax,0x4(%esp)
 3eb:	89 34 24             	mov    %esi,(%esp)
 3ee:	e8 70 fe ff ff       	call   263 <write>
 3f3:	43                   	inc    %ebx
  for(i = 0; fmt[i]; i++){
 3f4:	8a 43 ff             	mov    -0x1(%ebx),%al
 3f7:	84 c0                	test   %al,%al
 3f9:	0f 84 81 00 00 00    	je     480 <printf+0xd4>
    c = fmt[i] & 0xff;
 3ff:	0f b6 c8             	movzbl %al,%ecx
    if(state == 0){
 402:	85 ff                	test   %edi,%edi
 404:	74 ca                	je     3d0 <printf+0x24>
      }
    } else if(state == '%'){
 406:	83 ff 25             	cmp    $0x25,%edi
 409:	75 e8                	jne    3f3 <printf+0x47>
      if(c == 'd'){
 40b:	83 f9 64             	cmp    $0x64,%ecx
 40e:	0f 84 14 01 00 00    	je     528 <printf+0x17c>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 414:	83 f9 78             	cmp    $0x78,%ecx
 417:	74 7b                	je     494 <printf+0xe8>
 419:	83 f9 70             	cmp    $0x70,%ecx
 41c:	74 76                	je     494 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 41e:	83 f9 73             	cmp    $0x73,%ecx
 421:	0f 84 91 00 00 00    	je     4b8 <printf+0x10c>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 427:	83 f9 63             	cmp    $0x63,%ecx
 42a:	0f 84 cc 00 00 00    	je     4fc <printf+0x150>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 430:	83 f9 25             	cmp    $0x25,%ecx
 433:	0f 84 13 01 00 00    	je     54c <printf+0x1a0>
 439:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
  write(fd, &c, 1);
 43d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 444:	00 
 445:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 448:	89 44 24 04          	mov    %eax,0x4(%esp)
 44c:	89 34 24             	mov    %esi,(%esp)
 44f:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 452:	e8 0c fe ff ff       	call   263 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 457:	8b 4d d0             	mov    -0x30(%ebp),%ecx
 45a:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
 45d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 464:	00 
 465:	8d 55 e7             	lea    -0x19(%ebp),%edx
 468:	89 54 24 04          	mov    %edx,0x4(%esp)
 46c:	89 34 24             	mov    %esi,(%esp)
 46f:	e8 ef fd ff ff       	call   263 <write>
      }
      state = 0;
 474:	31 ff                	xor    %edi,%edi
 476:	43                   	inc    %ebx
  for(i = 0; fmt[i]; i++){
 477:	8a 43 ff             	mov    -0x1(%ebx),%al
 47a:	84 c0                	test   %al,%al
 47c:	75 81                	jne    3ff <printf+0x53>
 47e:	66 90                	xchg   %ax,%ax
    }
  }
}
 480:	83 c4 3c             	add    $0x3c,%esp
 483:	5b                   	pop    %ebx
 484:	5e                   	pop    %esi
 485:	5f                   	pop    %edi
 486:	5d                   	pop    %ebp
 487:	c3                   	ret    
        state = '%';
 488:	bf 25 00 00 00       	mov    $0x25,%edi
 48d:	e9 61 ff ff ff       	jmp    3f3 <printf+0x47>
 492:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 494:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 49b:	b9 10 00 00 00       	mov    $0x10,%ecx
 4a0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 4a3:	8b 10                	mov    (%eax),%edx
 4a5:	89 f0                	mov    %esi,%eax
 4a7:	e8 80 fe ff ff       	call   32c <printint>
        ap++;
 4ac:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 4b0:	31 ff                	xor    %edi,%edi
        ap++;
 4b2:	e9 3c ff ff ff       	jmp    3f3 <printf+0x47>
 4b7:	90                   	nop
        s = (char*)*ap;
 4b8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 4bb:	8b 3a                	mov    (%edx),%edi
        ap++;
 4bd:	83 c2 04             	add    $0x4,%edx
 4c0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
 4c3:	85 ff                	test   %edi,%edi
 4c5:	0f 84 a3 00 00 00    	je     56e <printf+0x1c2>
        while(*s != 0){
 4cb:	8a 07                	mov    (%edi),%al
 4cd:	84 c0                	test   %al,%al
 4cf:	74 24                	je     4f5 <printf+0x149>
 4d1:	8d 76 00             	lea    0x0(%esi),%esi
 4d4:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 4d7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4de:	00 
 4df:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 4e2:	89 44 24 04          	mov    %eax,0x4(%esp)
 4e6:	89 34 24             	mov    %esi,(%esp)
 4e9:	e8 75 fd ff ff       	call   263 <write>
          s++;
 4ee:	47                   	inc    %edi
        while(*s != 0){
 4ef:	8a 07                	mov    (%edi),%al
 4f1:	84 c0                	test   %al,%al
 4f3:	75 df                	jne    4d4 <printf+0x128>
      state = 0;
 4f5:	31 ff                	xor    %edi,%edi
 4f7:	e9 f7 fe ff ff       	jmp    3f3 <printf+0x47>
        putc(fd, *ap);
 4fc:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 4ff:	8b 02                	mov    (%edx),%eax
 501:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 504:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 50b:	00 
 50c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 50f:	89 44 24 04          	mov    %eax,0x4(%esp)
 513:	89 34 24             	mov    %esi,(%esp)
 516:	e8 48 fd ff ff       	call   263 <write>
        ap++;
 51b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 51f:	31 ff                	xor    %edi,%edi
 521:	e9 cd fe ff ff       	jmp    3f3 <printf+0x47>
 526:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 528:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 52f:	b1 0a                	mov    $0xa,%cl
 531:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 534:	8b 10                	mov    (%eax),%edx
 536:	89 f0                	mov    %esi,%eax
 538:	e8 ef fd ff ff       	call   32c <printint>
        ap++;
 53d:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 541:	66 31 ff             	xor    %di,%di
 544:	e9 aa fe ff ff       	jmp    3f3 <printf+0x47>
 549:	8d 76 00             	lea    0x0(%esi),%esi
 54c:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
  write(fd, &c, 1);
 550:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 557:	00 
 558:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 55b:	89 44 24 04          	mov    %eax,0x4(%esp)
 55f:	89 34 24             	mov    %esi,(%esp)
 562:	e8 fc fc ff ff       	call   263 <write>
      state = 0;
 567:	31 ff                	xor    %edi,%edi
 569:	e9 85 fe ff ff       	jmp    3f3 <printf+0x47>
          s = "(null)";
 56e:	bf d7 06 00 00       	mov    $0x6d7,%edi
 573:	e9 53 ff ff ff       	jmp    4cb <printf+0x11f>

00000578 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 578:	55                   	push   %ebp
 579:	89 e5                	mov    %esp,%ebp
 57b:	57                   	push   %edi
 57c:	56                   	push   %esi
 57d:	53                   	push   %ebx
 57e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 581:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 584:	a1 74 09 00 00       	mov    0x974,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 589:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 58b:	39 d0                	cmp    %edx,%eax
 58d:	72 11                	jb     5a0 <free+0x28>
 58f:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 590:	39 c8                	cmp    %ecx,%eax
 592:	72 04                	jb     598 <free+0x20>
 594:	39 ca                	cmp    %ecx,%edx
 596:	72 10                	jb     5a8 <free+0x30>
 598:	89 c8                	mov    %ecx,%eax
 59a:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 59c:	39 d0                	cmp    %edx,%eax
 59e:	73 f0                	jae    590 <free+0x18>
 5a0:	39 ca                	cmp    %ecx,%edx
 5a2:	72 04                	jb     5a8 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5a4:	39 c8                	cmp    %ecx,%eax
 5a6:	72 f0                	jb     598 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 5a8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5ab:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 5ae:	39 cf                	cmp    %ecx,%edi
 5b0:	74 1a                	je     5cc <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 5b2:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5b5:	8b 48 04             	mov    0x4(%eax),%ecx
 5b8:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 5bb:	39 f2                	cmp    %esi,%edx
 5bd:	74 24                	je     5e3 <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 5bf:	89 10                	mov    %edx,(%eax)
  freep = p;
 5c1:	a3 74 09 00 00       	mov    %eax,0x974
}
 5c6:	5b                   	pop    %ebx
 5c7:	5e                   	pop    %esi
 5c8:	5f                   	pop    %edi
 5c9:	5d                   	pop    %ebp
 5ca:	c3                   	ret    
 5cb:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 5cc:	03 71 04             	add    0x4(%ecx),%esi
 5cf:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5d2:	8b 08                	mov    (%eax),%ecx
 5d4:	8b 09                	mov    (%ecx),%ecx
 5d6:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5d9:	8b 48 04             	mov    0x4(%eax),%ecx
 5dc:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 5df:	39 f2                	cmp    %esi,%edx
 5e1:	75 dc                	jne    5bf <free+0x47>
    p->s.size += bp->s.size;
 5e3:	03 4b fc             	add    -0x4(%ebx),%ecx
 5e6:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 5e9:	8b 53 f8             	mov    -0x8(%ebx),%edx
 5ec:	89 10                	mov    %edx,(%eax)
  freep = p;
 5ee:	a3 74 09 00 00       	mov    %eax,0x974
}
 5f3:	5b                   	pop    %ebx
 5f4:	5e                   	pop    %esi
 5f5:	5f                   	pop    %edi
 5f6:	5d                   	pop    %ebp
 5f7:	c3                   	ret    

000005f8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 5f8:	55                   	push   %ebp
 5f9:	89 e5                	mov    %esp,%ebp
 5fb:	57                   	push   %edi
 5fc:	56                   	push   %esi
 5fd:	53                   	push   %ebx
 5fe:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 601:	8b 75 08             	mov    0x8(%ebp),%esi
 604:	83 c6 07             	add    $0x7,%esi
 607:	c1 ee 03             	shr    $0x3,%esi
 60a:	46                   	inc    %esi
  if((prevp = freep) == 0){
 60b:	8b 15 74 09 00 00    	mov    0x974,%edx
 611:	85 d2                	test   %edx,%edx
 613:	0f 84 8d 00 00 00    	je     6a6 <malloc+0xae>
 619:	8b 02                	mov    (%edx),%eax
 61b:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 61e:	39 ce                	cmp    %ecx,%esi
 620:	76 52                	jbe    674 <malloc+0x7c>
 622:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 629:	eb 0a                	jmp    635 <malloc+0x3d>
 62b:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 62c:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 62e:	8b 48 04             	mov    0x4(%eax),%ecx
 631:	39 ce                	cmp    %ecx,%esi
 633:	76 3f                	jbe    674 <malloc+0x7c>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 635:	89 c2                	mov    %eax,%edx
 637:	3b 05 74 09 00 00    	cmp    0x974,%eax
 63d:	75 ed                	jne    62c <malloc+0x34>
  if(nu < 4096)
 63f:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 645:	76 4d                	jbe    694 <malloc+0x9c>
 647:	89 d8                	mov    %ebx,%eax
 649:	89 f7                	mov    %esi,%edi
  p = sbrk(nu * sizeof(Header));
 64b:	89 04 24             	mov    %eax,(%esp)
 64e:	e8 78 fc ff ff       	call   2cb <sbrk>
  if(p == (char*)-1)
 653:	83 f8 ff             	cmp    $0xffffffff,%eax
 656:	74 18                	je     670 <malloc+0x78>
  hp->s.size = nu;
 658:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 65b:	83 c0 08             	add    $0x8,%eax
 65e:	89 04 24             	mov    %eax,(%esp)
 661:	e8 12 ff ff ff       	call   578 <free>
  return freep;
 666:	8b 15 74 09 00 00    	mov    0x974,%edx
      if((p = morecore(nunits)) == 0)
 66c:	85 d2                	test   %edx,%edx
 66e:	75 bc                	jne    62c <malloc+0x34>
        return 0;
 670:	31 c0                	xor    %eax,%eax
 672:	eb 18                	jmp    68c <malloc+0x94>
      if(p->s.size == nunits)
 674:	39 ce                	cmp    %ecx,%esi
 676:	74 28                	je     6a0 <malloc+0xa8>
        p->s.size -= nunits;
 678:	29 f1                	sub    %esi,%ecx
 67a:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 67d:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 680:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 683:	89 15 74 09 00 00    	mov    %edx,0x974
      return (void*)(p + 1);
 689:	83 c0 08             	add    $0x8,%eax
  }
}
 68c:	83 c4 1c             	add    $0x1c,%esp
 68f:	5b                   	pop    %ebx
 690:	5e                   	pop    %esi
 691:	5f                   	pop    %edi
 692:	5d                   	pop    %ebp
 693:	c3                   	ret    
  if(nu < 4096)
 694:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 699:	bf 00 10 00 00       	mov    $0x1000,%edi
 69e:	eb ab                	jmp    64b <malloc+0x53>
        prevp->s.ptr = p->s.ptr;
 6a0:	8b 08                	mov    (%eax),%ecx
 6a2:	89 0a                	mov    %ecx,(%edx)
 6a4:	eb dd                	jmp    683 <malloc+0x8b>
    base.s.ptr = freep = prevp = &base;
 6a6:	c7 05 74 09 00 00 78 	movl   $0x978,0x974
 6ad:	09 00 00 
 6b0:	c7 05 78 09 00 00 78 	movl   $0x978,0x978
 6b7:	09 00 00 
    base.s.size = 0;
 6ba:	c7 05 7c 09 00 00 00 	movl   $0x0,0x97c
 6c1:	00 00 00 
 6c4:	b8 78 09 00 00       	mov    $0x978,%eax
 6c9:	e9 54 ff ff ff       	jmp    622 <malloc+0x2a>
