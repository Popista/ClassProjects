
_test1：     文件格式 elf32-i386


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
	//fork();
	int a;
	//char *a = (char*)malloc(4096);
	char *b = (char*)malloc(50000);
   9:	c7 04 24 50 c3 00 00 	movl   $0xc350,(%esp)
  10:	e8 07 06 00 00       	call   61c <malloc>
	//a = "1231312";
	b = "222";
	printf(1,"%s \n",b);
  15:	c7 44 24 08 f2 06 00 	movl   $0x6f2,0x8(%esp)
  1c:	00 
  1d:	c7 44 24 04 f6 06 00 	movl   $0x6f6,0x4(%esp)
  24:	00 
  25:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  2c:	e8 9f 03 00 00       	call   3d0 <printf>
	a = getpid();
  31:	e8 b1 02 00 00       	call   2e7 <getpid>
	printf(1,"pid : %d \n",a);
  36:	89 44 24 08          	mov    %eax,0x8(%esp)
  3a:	c7 44 24 04 fb 06 00 	movl   $0x6fb,0x4(%esp)
  41:	00 
  42:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  49:	e8 82 03 00 00       	call   3d0 <printf>
    printf(1,"mempagenum: %d\n", mempagenum());
  4e:	e8 bc 02 00 00       	call   30f <mempagenum>
  53:	89 44 24 08          	mov    %eax,0x8(%esp)
  57:	c7 44 24 04 06 07 00 	movl   $0x706,0x4(%esp)
  5e:	00 
  5f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  66:	e8 65 03 00 00       	call   3d0 <printf>
    printf(1,"syscallnum: %d\n", syscallnum());
  6b:	e8 a7 02 00 00       	call   317 <syscallnum>
  70:	89 44 24 08          	mov    %eax,0x8(%esp)
  74:	c7 44 24 04 16 07 00 	movl   $0x716,0x4(%esp)
  7b:	00 
  7c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  83:	e8 48 03 00 00       	call   3d0 <printf>
    free(b);
  88:	c7 04 24 f2 06 00 00 	movl   $0x6f2,(%esp)
  8f:	e8 08 05 00 00       	call   59c <free>
    exit();
  94:	e8 ce 01 00 00       	call   267 <exit>
  99:	66 90                	xchg   %ax,%ax
  9b:	90                   	nop

0000009c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  9c:	55                   	push   %ebp
  9d:	89 e5                	mov    %esp,%ebp
  9f:	53                   	push   %ebx
  a0:	8b 45 08             	mov    0x8(%ebp),%eax
  a3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  a6:	89 c2                	mov    %eax,%edx
  a8:	8a 19                	mov    (%ecx),%bl
  aa:	88 1a                	mov    %bl,(%edx)
  ac:	42                   	inc    %edx
  ad:	41                   	inc    %ecx
  ae:	84 db                	test   %bl,%bl
  b0:	75 f6                	jne    a8 <strcpy+0xc>
    ;
  return os;
}
  b2:	5b                   	pop    %ebx
  b3:	5d                   	pop    %ebp
  b4:	c3                   	ret    
  b5:	8d 76 00             	lea    0x0(%esi),%esi

000000b8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b8:	55                   	push   %ebp
  b9:	89 e5                	mov    %esp,%ebp
  bb:	56                   	push   %esi
  bc:	53                   	push   %ebx
  bd:	8b 55 08             	mov    0x8(%ebp),%edx
  c0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  c3:	0f b6 02             	movzbl (%edx),%eax
  c6:	0f b6 19             	movzbl (%ecx),%ebx
  c9:	84 c0                	test   %al,%al
  cb:	75 14                	jne    e1 <strcmp+0x29>
  cd:	eb 1d                	jmp    ec <strcmp+0x34>
  cf:	90                   	nop
    p++, q++;
  d0:	42                   	inc    %edx
  d1:	8d 71 01             	lea    0x1(%ecx),%esi
  while(*p && *p == *q)
  d4:	0f b6 02             	movzbl (%edx),%eax
  d7:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  db:	84 c0                	test   %al,%al
  dd:	74 0d                	je     ec <strcmp+0x34>
    p++, q++;
  df:	89 f1                	mov    %esi,%ecx
  while(*p && *p == *q)
  e1:	38 d8                	cmp    %bl,%al
  e3:	74 eb                	je     d0 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
  e5:	29 d8                	sub    %ebx,%eax
}
  e7:	5b                   	pop    %ebx
  e8:	5e                   	pop    %esi
  e9:	5d                   	pop    %ebp
  ea:	c3                   	ret    
  eb:	90                   	nop
  while(*p && *p == *q)
  ec:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  ee:	29 d8                	sub    %ebx,%eax
}
  f0:	5b                   	pop    %ebx
  f1:	5e                   	pop    %esi
  f2:	5d                   	pop    %ebp
  f3:	c3                   	ret    

000000f4 <strlen>:

uint
strlen(char *s)
{
  f4:	55                   	push   %ebp
  f5:	89 e5                	mov    %esp,%ebp
  f7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  fa:	80 39 00             	cmpb   $0x0,(%ecx)
  fd:	74 10                	je     10f <strlen+0x1b>
  ff:	31 d2                	xor    %edx,%edx
 101:	8d 76 00             	lea    0x0(%esi),%esi
 104:	42                   	inc    %edx
 105:	89 d0                	mov    %edx,%eax
 107:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 10b:	75 f7                	jne    104 <strlen+0x10>
    ;
  return n;
}
 10d:	5d                   	pop    %ebp
 10e:	c3                   	ret    
  for(n = 0; s[n]; n++)
 10f:	31 c0                	xor    %eax,%eax
}
 111:	5d                   	pop    %ebp
 112:	c3                   	ret    
 113:	90                   	nop

00000114 <memset>:

void*
memset(void *dst, int c, uint n)
{
 114:	55                   	push   %ebp
 115:	89 e5                	mov    %esp,%ebp
 117:	57                   	push   %edi
 118:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 11b:	89 d7                	mov    %edx,%edi
 11d:	8b 4d 10             	mov    0x10(%ebp),%ecx
 120:	8b 45 0c             	mov    0xc(%ebp),%eax
 123:	fc                   	cld    
 124:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 126:	89 d0                	mov    %edx,%eax
 128:	5f                   	pop    %edi
 129:	5d                   	pop    %ebp
 12a:	c3                   	ret    
 12b:	90                   	nop

0000012c <strchr>:

char*
strchr(const char *s, char c)
{
 12c:	55                   	push   %ebp
 12d:	89 e5                	mov    %esp,%ebp
 12f:	8b 45 08             	mov    0x8(%ebp),%eax
 132:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
 135:	8a 10                	mov    (%eax),%dl
 137:	84 d2                	test   %dl,%dl
 139:	75 0c                	jne    147 <strchr+0x1b>
 13b:	eb 13                	jmp    150 <strchr+0x24>
 13d:	8d 76 00             	lea    0x0(%esi),%esi
 140:	40                   	inc    %eax
 141:	8a 10                	mov    (%eax),%dl
 143:	84 d2                	test   %dl,%dl
 145:	74 09                	je     150 <strchr+0x24>
    if(*s == c)
 147:	38 ca                	cmp    %cl,%dl
 149:	75 f5                	jne    140 <strchr+0x14>
      return (char*)s;
  return 0;
}
 14b:	5d                   	pop    %ebp
 14c:	c3                   	ret    
 14d:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
 150:	31 c0                	xor    %eax,%eax
}
 152:	5d                   	pop    %ebp
 153:	c3                   	ret    

00000154 <gets>:

char*
gets(char *buf, int max)
{
 154:	55                   	push   %ebp
 155:	89 e5                	mov    %esp,%ebp
 157:	57                   	push   %edi
 158:	56                   	push   %esi
 159:	53                   	push   %ebx
 15a:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 15d:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
 15f:	8d 7d e7             	lea    -0x19(%ebp),%edi
 162:	66 90                	xchg   %ax,%ax
  for(i=0; i+1 < max; ){
 164:	8d 73 01             	lea    0x1(%ebx),%esi
 167:	3b 75 0c             	cmp    0xc(%ebp),%esi
 16a:	7d 40                	jge    1ac <gets+0x58>
    cc = read(0, &c, 1);
 16c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 173:	00 
 174:	89 7c 24 04          	mov    %edi,0x4(%esp)
 178:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 17f:	e8 fb 00 00 00       	call   27f <read>
    if(cc < 1)
 184:	85 c0                	test   %eax,%eax
 186:	7e 24                	jle    1ac <gets+0x58>
      break;
    buf[i++] = c;
 188:	8a 45 e7             	mov    -0x19(%ebp),%al
 18b:	8b 55 08             	mov    0x8(%ebp),%edx
 18e:	88 44 32 ff          	mov    %al,-0x1(%edx,%esi,1)
    if(c == '\n' || c == '\r')
 192:	3c 0a                	cmp    $0xa,%al
 194:	74 06                	je     19c <gets+0x48>
 196:	89 f3                	mov    %esi,%ebx
 198:	3c 0d                	cmp    $0xd,%al
 19a:	75 c8                	jne    164 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 19c:	8b 45 08             	mov    0x8(%ebp),%eax
 19f:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 1a3:	83 c4 2c             	add    $0x2c,%esp
 1a6:	5b                   	pop    %ebx
 1a7:	5e                   	pop    %esi
 1a8:	5f                   	pop    %edi
 1a9:	5d                   	pop    %ebp
 1aa:	c3                   	ret    
 1ab:	90                   	nop
    if(cc < 1)
 1ac:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 1ae:	8b 45 08             	mov    0x8(%ebp),%eax
 1b1:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 1b5:	83 c4 2c             	add    $0x2c,%esp
 1b8:	5b                   	pop    %ebx
 1b9:	5e                   	pop    %esi
 1ba:	5f                   	pop    %edi
 1bb:	5d                   	pop    %ebp
 1bc:	c3                   	ret    
 1bd:	8d 76 00             	lea    0x0(%esi),%esi

000001c0 <stat>:

int
stat(char *n, struct stat *st)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	56                   	push   %esi
 1c4:	53                   	push   %ebx
 1c5:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1c8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1cf:	00 
 1d0:	8b 45 08             	mov    0x8(%ebp),%eax
 1d3:	89 04 24             	mov    %eax,(%esp)
 1d6:	e8 cc 00 00 00       	call   2a7 <open>
 1db:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 1dd:	85 c0                	test   %eax,%eax
 1df:	78 23                	js     204 <stat+0x44>
    return -1;
  r = fstat(fd, st);
 1e1:	8b 45 0c             	mov    0xc(%ebp),%eax
 1e4:	89 44 24 04          	mov    %eax,0x4(%esp)
 1e8:	89 1c 24             	mov    %ebx,(%esp)
 1eb:	e8 cf 00 00 00       	call   2bf <fstat>
 1f0:	89 c6                	mov    %eax,%esi
  close(fd);
 1f2:	89 1c 24             	mov    %ebx,(%esp)
 1f5:	e8 95 00 00 00       	call   28f <close>
  return r;
}
 1fa:	89 f0                	mov    %esi,%eax
 1fc:	83 c4 10             	add    $0x10,%esp
 1ff:	5b                   	pop    %ebx
 200:	5e                   	pop    %esi
 201:	5d                   	pop    %ebp
 202:	c3                   	ret    
 203:	90                   	nop
    return -1;
 204:	be ff ff ff ff       	mov    $0xffffffff,%esi
 209:	eb ef                	jmp    1fa <stat+0x3a>
 20b:	90                   	nop

0000020c <atoi>:

int
atoi(const char *s)
{
 20c:	55                   	push   %ebp
 20d:	89 e5                	mov    %esp,%ebp
 20f:	53                   	push   %ebx
 210:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 213:	0f be 11             	movsbl (%ecx),%edx
 216:	8d 42 d0             	lea    -0x30(%edx),%eax
 219:	3c 09                	cmp    $0x9,%al
 21b:	b8 00 00 00 00       	mov    $0x0,%eax
 220:	77 15                	ja     237 <atoi+0x2b>
 222:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 224:	8d 04 80             	lea    (%eax,%eax,4),%eax
 227:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
 22b:	41                   	inc    %ecx
  while('0' <= *s && *s <= '9')
 22c:	0f be 11             	movsbl (%ecx),%edx
 22f:	8d 5a d0             	lea    -0x30(%edx),%ebx
 232:	80 fb 09             	cmp    $0x9,%bl
 235:	76 ed                	jbe    224 <atoi+0x18>
  return n;
}
 237:	5b                   	pop    %ebx
 238:	5d                   	pop    %ebp
 239:	c3                   	ret    
 23a:	66 90                	xchg   %ax,%ax

0000023c <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 23c:	55                   	push   %ebp
 23d:	89 e5                	mov    %esp,%ebp
 23f:	56                   	push   %esi
 240:	53                   	push   %ebx
 241:	8b 45 08             	mov    0x8(%ebp),%eax
 244:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 247:	8b 75 10             	mov    0x10(%ebp),%esi
memmove(void *vdst, void *vsrc, int n)
 24a:	31 d2                	xor    %edx,%edx
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 24c:	85 f6                	test   %esi,%esi
 24e:	7e 0b                	jle    25b <memmove+0x1f>
    *dst++ = *src++;
 250:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 253:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 256:	42                   	inc    %edx
  while(n-- > 0)
 257:	39 f2                	cmp    %esi,%edx
 259:	75 f5                	jne    250 <memmove+0x14>
  return vdst;
}
 25b:	5b                   	pop    %ebx
 25c:	5e                   	pop    %esi
 25d:	5d                   	pop    %ebp
 25e:	c3                   	ret    

0000025f <fork>:
 25f:	b8 01 00 00 00       	mov    $0x1,%eax
 264:	cd 40                	int    $0x40
 266:	c3                   	ret    

00000267 <exit>:
 267:	b8 02 00 00 00       	mov    $0x2,%eax
 26c:	cd 40                	int    $0x40
 26e:	c3                   	ret    

0000026f <wait>:
 26f:	b8 03 00 00 00       	mov    $0x3,%eax
 274:	cd 40                	int    $0x40
 276:	c3                   	ret    

00000277 <pipe>:
 277:	b8 04 00 00 00       	mov    $0x4,%eax
 27c:	cd 40                	int    $0x40
 27e:	c3                   	ret    

0000027f <read>:
 27f:	b8 05 00 00 00       	mov    $0x5,%eax
 284:	cd 40                	int    $0x40
 286:	c3                   	ret    

00000287 <write>:
 287:	b8 10 00 00 00       	mov    $0x10,%eax
 28c:	cd 40                	int    $0x40
 28e:	c3                   	ret    

0000028f <close>:
 28f:	b8 15 00 00 00       	mov    $0x15,%eax
 294:	cd 40                	int    $0x40
 296:	c3                   	ret    

00000297 <kill>:
 297:	b8 06 00 00 00       	mov    $0x6,%eax
 29c:	cd 40                	int    $0x40
 29e:	c3                   	ret    

0000029f <exec>:
 29f:	b8 07 00 00 00       	mov    $0x7,%eax
 2a4:	cd 40                	int    $0x40
 2a6:	c3                   	ret    

000002a7 <open>:
 2a7:	b8 0f 00 00 00       	mov    $0xf,%eax
 2ac:	cd 40                	int    $0x40
 2ae:	c3                   	ret    

000002af <mknod>:
 2af:	b8 11 00 00 00       	mov    $0x11,%eax
 2b4:	cd 40                	int    $0x40
 2b6:	c3                   	ret    

000002b7 <unlink>:
 2b7:	b8 12 00 00 00       	mov    $0x12,%eax
 2bc:	cd 40                	int    $0x40
 2be:	c3                   	ret    

000002bf <fstat>:
 2bf:	b8 08 00 00 00       	mov    $0x8,%eax
 2c4:	cd 40                	int    $0x40
 2c6:	c3                   	ret    

000002c7 <link>:
 2c7:	b8 13 00 00 00       	mov    $0x13,%eax
 2cc:	cd 40                	int    $0x40
 2ce:	c3                   	ret    

000002cf <mkdir>:
 2cf:	b8 14 00 00 00       	mov    $0x14,%eax
 2d4:	cd 40                	int    $0x40
 2d6:	c3                   	ret    

000002d7 <chdir>:
 2d7:	b8 09 00 00 00       	mov    $0x9,%eax
 2dc:	cd 40                	int    $0x40
 2de:	c3                   	ret    

000002df <dup>:
 2df:	b8 0a 00 00 00       	mov    $0xa,%eax
 2e4:	cd 40                	int    $0x40
 2e6:	c3                   	ret    

000002e7 <getpid>:
 2e7:	b8 0b 00 00 00       	mov    $0xb,%eax
 2ec:	cd 40                	int    $0x40
 2ee:	c3                   	ret    

000002ef <sbrk>:
 2ef:	b8 0c 00 00 00       	mov    $0xc,%eax
 2f4:	cd 40                	int    $0x40
 2f6:	c3                   	ret    

000002f7 <sleep>:
 2f7:	b8 0d 00 00 00       	mov    $0xd,%eax
 2fc:	cd 40                	int    $0x40
 2fe:	c3                   	ret    

000002ff <uptime>:
 2ff:	b8 0e 00 00 00       	mov    $0xe,%eax
 304:	cd 40                	int    $0x40
 306:	c3                   	ret    

00000307 <getprocnum>:
 307:	b8 16 00 00 00       	mov    $0x16,%eax
 30c:	cd 40                	int    $0x40
 30e:	c3                   	ret    

0000030f <mempagenum>:
 30f:	b8 17 00 00 00       	mov    $0x17,%eax
 314:	cd 40                	int    $0x40
 316:	c3                   	ret    

00000317 <syscallnum>:
 317:	b8 18 00 00 00       	mov    $0x18,%eax
 31c:	cd 40                	int    $0x40
 31e:	c3                   	ret    

0000031f <settickets>:
 31f:	b8 19 00 00 00       	mov    $0x19,%eax
 324:	cd 40                	int    $0x40
 326:	c3                   	ret    

00000327 <getsheltime>:
 327:	b8 1a 00 00 00       	mov    $0x1a,%eax
 32c:	cd 40                	int    $0x40
 32e:	c3                   	ret    

0000032f <setstride>:
 32f:	b8 1b 00 00 00       	mov    $0x1b,%eax
 334:	cd 40                	int    $0x40
 336:	c3                   	ret    

00000337 <setpass>:
 337:	b8 1c 00 00 00       	mov    $0x1c,%eax
 33c:	cd 40                	int    $0x40
 33e:	c3                   	ret    

0000033f <join>:
 33f:	b8 1d 00 00 00       	mov    $0x1d,%eax
 344:	cd 40                	int    $0x40
 346:	c3                   	ret    

00000347 <clone1>:
 347:	b8 1e 00 00 00       	mov    $0x1e,%eax
 34c:	cd 40                	int    $0x40
 34e:	c3                   	ret    
 34f:	90                   	nop

00000350 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	57                   	push   %edi
 354:	56                   	push   %esi
 355:	53                   	push   %ebx
 356:	83 ec 3c             	sub    $0x3c,%esp
 359:	89 c7                	mov    %eax,%edi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 35b:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 35d:	8b 5d 08             	mov    0x8(%ebp),%ebx
 360:	85 db                	test   %ebx,%ebx
 362:	74 04                	je     368 <printint+0x18>
 364:	85 d2                	test   %edx,%edx
 366:	78 5d                	js     3c5 <printint+0x75>
  neg = 0;
 368:	31 db                	xor    %ebx,%ebx
  } else {
    x = xx;
  }

  i = 0;
 36a:	31 f6                	xor    %esi,%esi
 36c:	eb 04                	jmp    372 <printint+0x22>
 36e:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 370:	89 d6                	mov    %edx,%esi
 372:	31 d2                	xor    %edx,%edx
 374:	f7 f1                	div    %ecx
 376:	8a 92 2d 07 00 00    	mov    0x72d(%edx),%dl
 37c:	88 54 35 d8          	mov    %dl,-0x28(%ebp,%esi,1)
 380:	8d 56 01             	lea    0x1(%esi),%edx
  }while((x /= base) != 0);
 383:	85 c0                	test   %eax,%eax
 385:	75 e9                	jne    370 <printint+0x20>
  if(neg)
 387:	85 db                	test   %ebx,%ebx
 389:	74 08                	je     393 <printint+0x43>
    buf[i++] = '-';
 38b:	c6 44 15 d8 2d       	movb   $0x2d,-0x28(%ebp,%edx,1)
 390:	8d 56 02             	lea    0x2(%esi),%edx

  while(--i >= 0)
 393:	8d 5a ff             	lea    -0x1(%edx),%ebx
 396:	8d 75 d7             	lea    -0x29(%ebp),%esi
 399:	8d 76 00             	lea    0x0(%esi),%esi
 39c:	8a 44 1d d8          	mov    -0x28(%ebp,%ebx,1),%al
 3a0:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 3a3:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3aa:	00 
 3ab:	89 74 24 04          	mov    %esi,0x4(%esp)
 3af:	89 3c 24             	mov    %edi,(%esp)
 3b2:	e8 d0 fe ff ff       	call   287 <write>
  while(--i >= 0)
 3b7:	4b                   	dec    %ebx
 3b8:	83 fb ff             	cmp    $0xffffffff,%ebx
 3bb:	75 df                	jne    39c <printint+0x4c>
    putc(fd, buf[i]);
}
 3bd:	83 c4 3c             	add    $0x3c,%esp
 3c0:	5b                   	pop    %ebx
 3c1:	5e                   	pop    %esi
 3c2:	5f                   	pop    %edi
 3c3:	5d                   	pop    %ebp
 3c4:	c3                   	ret    
    x = -xx;
 3c5:	f7 d8                	neg    %eax
    neg = 1;
 3c7:	bb 01 00 00 00       	mov    $0x1,%ebx
    x = -xx;
 3cc:	eb 9c                	jmp    36a <printint+0x1a>
 3ce:	66 90                	xchg   %ax,%ax

000003d0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	57                   	push   %edi
 3d4:	56                   	push   %esi
 3d5:	53                   	push   %ebx
 3d6:	83 ec 3c             	sub    $0x3c,%esp
 3d9:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3dc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 3df:	8a 03                	mov    (%ebx),%al
 3e1:	84 c0                	test   %al,%al
 3e3:	0f 84 bb 00 00 00    	je     4a4 <printf+0xd4>
printf(int fd, char *fmt, ...)
 3e9:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
 3ea:	8d 55 10             	lea    0x10(%ebp),%edx
 3ed:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  state = 0;
 3f0:	31 ff                	xor    %edi,%edi
 3f2:	eb 2f                	jmp    423 <printf+0x53>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 3f4:	83 f9 25             	cmp    $0x25,%ecx
 3f7:	0f 84 af 00 00 00    	je     4ac <printf+0xdc>
        state = '%';
      } else {
        putc(fd, c);
 3fd:	88 4d e2             	mov    %cl,-0x1e(%ebp)
  write(fd, &c, 1);
 400:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 407:	00 
 408:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 40b:	89 44 24 04          	mov    %eax,0x4(%esp)
 40f:	89 34 24             	mov    %esi,(%esp)
 412:	e8 70 fe ff ff       	call   287 <write>
 417:	43                   	inc    %ebx
  for(i = 0; fmt[i]; i++){
 418:	8a 43 ff             	mov    -0x1(%ebx),%al
 41b:	84 c0                	test   %al,%al
 41d:	0f 84 81 00 00 00    	je     4a4 <printf+0xd4>
    c = fmt[i] & 0xff;
 423:	0f b6 c8             	movzbl %al,%ecx
    if(state == 0){
 426:	85 ff                	test   %edi,%edi
 428:	74 ca                	je     3f4 <printf+0x24>
      }
    } else if(state == '%'){
 42a:	83 ff 25             	cmp    $0x25,%edi
 42d:	75 e8                	jne    417 <printf+0x47>
      if(c == 'd'){
 42f:	83 f9 64             	cmp    $0x64,%ecx
 432:	0f 84 14 01 00 00    	je     54c <printf+0x17c>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 438:	83 f9 78             	cmp    $0x78,%ecx
 43b:	74 7b                	je     4b8 <printf+0xe8>
 43d:	83 f9 70             	cmp    $0x70,%ecx
 440:	74 76                	je     4b8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 442:	83 f9 73             	cmp    $0x73,%ecx
 445:	0f 84 91 00 00 00    	je     4dc <printf+0x10c>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 44b:	83 f9 63             	cmp    $0x63,%ecx
 44e:	0f 84 cc 00 00 00    	je     520 <printf+0x150>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 454:	83 f9 25             	cmp    $0x25,%ecx
 457:	0f 84 13 01 00 00    	je     570 <printf+0x1a0>
 45d:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
  write(fd, &c, 1);
 461:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 468:	00 
 469:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 46c:	89 44 24 04          	mov    %eax,0x4(%esp)
 470:	89 34 24             	mov    %esi,(%esp)
 473:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 476:	e8 0c fe ff ff       	call   287 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 47b:	8b 4d d0             	mov    -0x30(%ebp),%ecx
 47e:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
 481:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 488:	00 
 489:	8d 55 e7             	lea    -0x19(%ebp),%edx
 48c:	89 54 24 04          	mov    %edx,0x4(%esp)
 490:	89 34 24             	mov    %esi,(%esp)
 493:	e8 ef fd ff ff       	call   287 <write>
      }
      state = 0;
 498:	31 ff                	xor    %edi,%edi
 49a:	43                   	inc    %ebx
  for(i = 0; fmt[i]; i++){
 49b:	8a 43 ff             	mov    -0x1(%ebx),%al
 49e:	84 c0                	test   %al,%al
 4a0:	75 81                	jne    423 <printf+0x53>
 4a2:	66 90                	xchg   %ax,%ax
    }
  }
}
 4a4:	83 c4 3c             	add    $0x3c,%esp
 4a7:	5b                   	pop    %ebx
 4a8:	5e                   	pop    %esi
 4a9:	5f                   	pop    %edi
 4aa:	5d                   	pop    %ebp
 4ab:	c3                   	ret    
        state = '%';
 4ac:	bf 25 00 00 00       	mov    $0x25,%edi
 4b1:	e9 61 ff ff ff       	jmp    417 <printf+0x47>
 4b6:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 4b8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4bf:	b9 10 00 00 00       	mov    $0x10,%ecx
 4c4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 4c7:	8b 10                	mov    (%eax),%edx
 4c9:	89 f0                	mov    %esi,%eax
 4cb:	e8 80 fe ff ff       	call   350 <printint>
        ap++;
 4d0:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 4d4:	31 ff                	xor    %edi,%edi
        ap++;
 4d6:	e9 3c ff ff ff       	jmp    417 <printf+0x47>
 4db:	90                   	nop
        s = (char*)*ap;
 4dc:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 4df:	8b 3a                	mov    (%edx),%edi
        ap++;
 4e1:	83 c2 04             	add    $0x4,%edx
 4e4:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
 4e7:	85 ff                	test   %edi,%edi
 4e9:	0f 84 a3 00 00 00    	je     592 <printf+0x1c2>
        while(*s != 0){
 4ef:	8a 07                	mov    (%edi),%al
 4f1:	84 c0                	test   %al,%al
 4f3:	74 24                	je     519 <printf+0x149>
 4f5:	8d 76 00             	lea    0x0(%esi),%esi
 4f8:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 4fb:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 502:	00 
 503:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 506:	89 44 24 04          	mov    %eax,0x4(%esp)
 50a:	89 34 24             	mov    %esi,(%esp)
 50d:	e8 75 fd ff ff       	call   287 <write>
          s++;
 512:	47                   	inc    %edi
        while(*s != 0){
 513:	8a 07                	mov    (%edi),%al
 515:	84 c0                	test   %al,%al
 517:	75 df                	jne    4f8 <printf+0x128>
      state = 0;
 519:	31 ff                	xor    %edi,%edi
 51b:	e9 f7 fe ff ff       	jmp    417 <printf+0x47>
        putc(fd, *ap);
 520:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 523:	8b 02                	mov    (%edx),%eax
 525:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 528:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 52f:	00 
 530:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 533:	89 44 24 04          	mov    %eax,0x4(%esp)
 537:	89 34 24             	mov    %esi,(%esp)
 53a:	e8 48 fd ff ff       	call   287 <write>
        ap++;
 53f:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 543:	31 ff                	xor    %edi,%edi
 545:	e9 cd fe ff ff       	jmp    417 <printf+0x47>
 54a:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 54c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 553:	b1 0a                	mov    $0xa,%cl
 555:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 558:	8b 10                	mov    (%eax),%edx
 55a:	89 f0                	mov    %esi,%eax
 55c:	e8 ef fd ff ff       	call   350 <printint>
        ap++;
 561:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 565:	66 31 ff             	xor    %di,%di
 568:	e9 aa fe ff ff       	jmp    417 <printf+0x47>
 56d:	8d 76 00             	lea    0x0(%esi),%esi
 570:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
  write(fd, &c, 1);
 574:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 57b:	00 
 57c:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 57f:	89 44 24 04          	mov    %eax,0x4(%esp)
 583:	89 34 24             	mov    %esi,(%esp)
 586:	e8 fc fc ff ff       	call   287 <write>
      state = 0;
 58b:	31 ff                	xor    %edi,%edi
 58d:	e9 85 fe ff ff       	jmp    417 <printf+0x47>
          s = "(null)";
 592:	bf 26 07 00 00       	mov    $0x726,%edi
 597:	e9 53 ff ff ff       	jmp    4ef <printf+0x11f>

0000059c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 59c:	55                   	push   %ebp
 59d:	89 e5                	mov    %esp,%ebp
 59f:	57                   	push   %edi
 5a0:	56                   	push   %esi
 5a1:	53                   	push   %ebx
 5a2:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5a5:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5a8:	a1 c0 09 00 00       	mov    0x9c0,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5ad:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5af:	39 d0                	cmp    %edx,%eax
 5b1:	72 11                	jb     5c4 <free+0x28>
 5b3:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5b4:	39 c8                	cmp    %ecx,%eax
 5b6:	72 04                	jb     5bc <free+0x20>
 5b8:	39 ca                	cmp    %ecx,%edx
 5ba:	72 10                	jb     5cc <free+0x30>
 5bc:	89 c8                	mov    %ecx,%eax
 5be:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5c0:	39 d0                	cmp    %edx,%eax
 5c2:	73 f0                	jae    5b4 <free+0x18>
 5c4:	39 ca                	cmp    %ecx,%edx
 5c6:	72 04                	jb     5cc <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5c8:	39 c8                	cmp    %ecx,%eax
 5ca:	72 f0                	jb     5bc <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 5cc:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5cf:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 5d2:	39 cf                	cmp    %ecx,%edi
 5d4:	74 1a                	je     5f0 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 5d6:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5d9:	8b 48 04             	mov    0x4(%eax),%ecx
 5dc:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 5df:	39 f2                	cmp    %esi,%edx
 5e1:	74 24                	je     607 <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 5e3:	89 10                	mov    %edx,(%eax)
  freep = p;
 5e5:	a3 c0 09 00 00       	mov    %eax,0x9c0
}
 5ea:	5b                   	pop    %ebx
 5eb:	5e                   	pop    %esi
 5ec:	5f                   	pop    %edi
 5ed:	5d                   	pop    %ebp
 5ee:	c3                   	ret    
 5ef:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 5f0:	03 71 04             	add    0x4(%ecx),%esi
 5f3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5f6:	8b 08                	mov    (%eax),%ecx
 5f8:	8b 09                	mov    (%ecx),%ecx
 5fa:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5fd:	8b 48 04             	mov    0x4(%eax),%ecx
 600:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 603:	39 f2                	cmp    %esi,%edx
 605:	75 dc                	jne    5e3 <free+0x47>
    p->s.size += bp->s.size;
 607:	03 4b fc             	add    -0x4(%ebx),%ecx
 60a:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 60d:	8b 53 f8             	mov    -0x8(%ebx),%edx
 610:	89 10                	mov    %edx,(%eax)
  freep = p;
 612:	a3 c0 09 00 00       	mov    %eax,0x9c0
}
 617:	5b                   	pop    %ebx
 618:	5e                   	pop    %esi
 619:	5f                   	pop    %edi
 61a:	5d                   	pop    %ebp
 61b:	c3                   	ret    

0000061c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 61c:	55                   	push   %ebp
 61d:	89 e5                	mov    %esp,%ebp
 61f:	57                   	push   %edi
 620:	56                   	push   %esi
 621:	53                   	push   %ebx
 622:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 625:	8b 75 08             	mov    0x8(%ebp),%esi
 628:	83 c6 07             	add    $0x7,%esi
 62b:	c1 ee 03             	shr    $0x3,%esi
 62e:	46                   	inc    %esi
  if((prevp = freep) == 0){
 62f:	8b 15 c0 09 00 00    	mov    0x9c0,%edx
 635:	85 d2                	test   %edx,%edx
 637:	0f 84 8d 00 00 00    	je     6ca <malloc+0xae>
 63d:	8b 02                	mov    (%edx),%eax
 63f:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 642:	39 ce                	cmp    %ecx,%esi
 644:	76 52                	jbe    698 <malloc+0x7c>
 646:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 64d:	eb 0a                	jmp    659 <malloc+0x3d>
 64f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 650:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 652:	8b 48 04             	mov    0x4(%eax),%ecx
 655:	39 ce                	cmp    %ecx,%esi
 657:	76 3f                	jbe    698 <malloc+0x7c>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 659:	89 c2                	mov    %eax,%edx
 65b:	3b 05 c0 09 00 00    	cmp    0x9c0,%eax
 661:	75 ed                	jne    650 <malloc+0x34>
  if(nu < 4096)
 663:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 669:	76 4d                	jbe    6b8 <malloc+0x9c>
 66b:	89 d8                	mov    %ebx,%eax
 66d:	89 f7                	mov    %esi,%edi
  p = sbrk(nu * sizeof(Header));
 66f:	89 04 24             	mov    %eax,(%esp)
 672:	e8 78 fc ff ff       	call   2ef <sbrk>
  if(p == (char*)-1)
 677:	83 f8 ff             	cmp    $0xffffffff,%eax
 67a:	74 18                	je     694 <malloc+0x78>
  hp->s.size = nu;
 67c:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 67f:	83 c0 08             	add    $0x8,%eax
 682:	89 04 24             	mov    %eax,(%esp)
 685:	e8 12 ff ff ff       	call   59c <free>
  return freep;
 68a:	8b 15 c0 09 00 00    	mov    0x9c0,%edx
      if((p = morecore(nunits)) == 0)
 690:	85 d2                	test   %edx,%edx
 692:	75 bc                	jne    650 <malloc+0x34>
        return 0;
 694:	31 c0                	xor    %eax,%eax
 696:	eb 18                	jmp    6b0 <malloc+0x94>
      if(p->s.size == nunits)
 698:	39 ce                	cmp    %ecx,%esi
 69a:	74 28                	je     6c4 <malloc+0xa8>
        p->s.size -= nunits;
 69c:	29 f1                	sub    %esi,%ecx
 69e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 6a1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 6a4:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 6a7:	89 15 c0 09 00 00    	mov    %edx,0x9c0
      return (void*)(p + 1);
 6ad:	83 c0 08             	add    $0x8,%eax
  }
}
 6b0:	83 c4 1c             	add    $0x1c,%esp
 6b3:	5b                   	pop    %ebx
 6b4:	5e                   	pop    %esi
 6b5:	5f                   	pop    %edi
 6b6:	5d                   	pop    %ebp
 6b7:	c3                   	ret    
  if(nu < 4096)
 6b8:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 6bd:	bf 00 10 00 00       	mov    $0x1000,%edi
 6c2:	eb ab                	jmp    66f <malloc+0x53>
        prevp->s.ptr = p->s.ptr;
 6c4:	8b 08                	mov    (%eax),%ecx
 6c6:	89 0a                	mov    %ecx,(%edx)
 6c8:	eb dd                	jmp    6a7 <malloc+0x8b>
    base.s.ptr = freep = prevp = &base;
 6ca:	c7 05 c0 09 00 00 c4 	movl   $0x9c4,0x9c0
 6d1:	09 00 00 
 6d4:	c7 05 c4 09 00 00 c4 	movl   $0x9c4,0x9c4
 6db:	09 00 00 
    base.s.size = 0;
 6de:	c7 05 c8 09 00 00 00 	movl   $0x0,0x9c8
 6e5:	00 00 00 
 6e8:	b8 c4 09 00 00       	mov    $0x9c4,%eax
 6ed:	e9 54 ff ff ff       	jmp    646 <malloc+0x2a>
