
_init：     文件格式 elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	83 ec 10             	sub    $0x10,%esp
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   a:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  11:	00 
  12:	c7 04 24 5a 07 00 00 	movl   $0x75a,(%esp)
  19:	e8 f1 02 00 00       	call   30f <open>
  1e:	85 c0                	test   %eax,%eax
  20:	0f 88 a7 00 00 00    	js     cd <main+0xcd>
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  26:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  2d:	e8 15 03 00 00       	call   347 <dup>
  dup(0);  // stderr
  32:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  39:	e8 09 03 00 00       	call   347 <dup>
  3e:	66 90                	xchg   %ax,%ax

  for(;;){
    printf(1, "init: starting sh\n");
  40:	c7 44 24 04 62 07 00 	movl   $0x762,0x4(%esp)
  47:	00 
  48:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  4f:	e8 e4 03 00 00       	call   438 <printf>
    pid = fork();
  54:	e8 6e 02 00 00       	call   2c7 <fork>
  59:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
  5b:	83 f8 00             	cmp    $0x0,%eax
  5e:	7c 27                	jl     87 <main+0x87>
      printf(1, "init: fork failed\n");
      exit();
    }
    if(pid == 0){
  60:	74 3e                	je     a0 <main+0xa0>
  62:	66 90                	xchg   %ax,%ax
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  64:	e8 6e 02 00 00       	call   2d7 <wait>
  69:	85 c0                	test   %eax,%eax
  6b:	78 d3                	js     40 <main+0x40>
  6d:	39 d8                	cmp    %ebx,%eax
  6f:	74 cf                	je     40 <main+0x40>
      printf(1, "zombie!\n");
  71:	c7 44 24 04 a1 07 00 	movl   $0x7a1,0x4(%esp)
  78:	00 
  79:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  80:	e8 b3 03 00 00       	call   438 <printf>
  85:	eb dd                	jmp    64 <main+0x64>
      printf(1, "init: fork failed\n");
  87:	c7 44 24 04 75 07 00 	movl   $0x775,0x4(%esp)
  8e:	00 
  8f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  96:	e8 9d 03 00 00       	call   438 <printf>
      exit();
  9b:	e8 2f 02 00 00       	call   2cf <exit>
      exec("sh", argv);
  a0:	c7 44 24 04 44 0a 00 	movl   $0xa44,0x4(%esp)
  a7:	00 
  a8:	c7 04 24 88 07 00 00 	movl   $0x788,(%esp)
  af:	e8 53 02 00 00       	call   307 <exec>
      printf(1, "init: exec sh failed\n");
  b4:	c7 44 24 04 8b 07 00 	movl   $0x78b,0x4(%esp)
  bb:	00 
  bc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  c3:	e8 70 03 00 00       	call   438 <printf>
      exit();
  c8:	e8 02 02 00 00       	call   2cf <exit>
    mknod("console", 1, 1);
  cd:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  d4:	00 
  d5:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  dc:	00 
  dd:	c7 04 24 5a 07 00 00 	movl   $0x75a,(%esp)
  e4:	e8 2e 02 00 00       	call   317 <mknod>
    open("console", O_RDWR);
  e9:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  f0:	00 
  f1:	c7 04 24 5a 07 00 00 	movl   $0x75a,(%esp)
  f8:	e8 12 02 00 00       	call   30f <open>
  fd:	e9 24 ff ff ff       	jmp    26 <main+0x26>
 102:	66 90                	xchg   %ax,%ax

00000104 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 104:	55                   	push   %ebp
 105:	89 e5                	mov    %esp,%ebp
 107:	53                   	push   %ebx
 108:	8b 45 08             	mov    0x8(%ebp),%eax
 10b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 10e:	89 c2                	mov    %eax,%edx
 110:	8a 19                	mov    (%ecx),%bl
 112:	88 1a                	mov    %bl,(%edx)
 114:	42                   	inc    %edx
 115:	41                   	inc    %ecx
 116:	84 db                	test   %bl,%bl
 118:	75 f6                	jne    110 <strcpy+0xc>
    ;
  return os;
}
 11a:	5b                   	pop    %ebx
 11b:	5d                   	pop    %ebp
 11c:	c3                   	ret    
 11d:	8d 76 00             	lea    0x0(%esi),%esi

00000120 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	56                   	push   %esi
 124:	53                   	push   %ebx
 125:	8b 55 08             	mov    0x8(%ebp),%edx
 128:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 12b:	0f b6 02             	movzbl (%edx),%eax
 12e:	0f b6 19             	movzbl (%ecx),%ebx
 131:	84 c0                	test   %al,%al
 133:	75 14                	jne    149 <strcmp+0x29>
 135:	eb 1d                	jmp    154 <strcmp+0x34>
 137:	90                   	nop
    p++, q++;
 138:	42                   	inc    %edx
 139:	8d 71 01             	lea    0x1(%ecx),%esi
  while(*p && *p == *q)
 13c:	0f b6 02             	movzbl (%edx),%eax
 13f:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 143:	84 c0                	test   %al,%al
 145:	74 0d                	je     154 <strcmp+0x34>
    p++, q++;
 147:	89 f1                	mov    %esi,%ecx
  while(*p && *p == *q)
 149:	38 d8                	cmp    %bl,%al
 14b:	74 eb                	je     138 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 14d:	29 d8                	sub    %ebx,%eax
}
 14f:	5b                   	pop    %ebx
 150:	5e                   	pop    %esi
 151:	5d                   	pop    %ebp
 152:	c3                   	ret    
 153:	90                   	nop
  while(*p && *p == *q)
 154:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 156:	29 d8                	sub    %ebx,%eax
}
 158:	5b                   	pop    %ebx
 159:	5e                   	pop    %esi
 15a:	5d                   	pop    %ebp
 15b:	c3                   	ret    

0000015c <strlen>:

uint
strlen(char *s)
{
 15c:	55                   	push   %ebp
 15d:	89 e5                	mov    %esp,%ebp
 15f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 162:	80 39 00             	cmpb   $0x0,(%ecx)
 165:	74 10                	je     177 <strlen+0x1b>
 167:	31 d2                	xor    %edx,%edx
 169:	8d 76 00             	lea    0x0(%esi),%esi
 16c:	42                   	inc    %edx
 16d:	89 d0                	mov    %edx,%eax
 16f:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 173:	75 f7                	jne    16c <strlen+0x10>
    ;
  return n;
}
 175:	5d                   	pop    %ebp
 176:	c3                   	ret    
  for(n = 0; s[n]; n++)
 177:	31 c0                	xor    %eax,%eax
}
 179:	5d                   	pop    %ebp
 17a:	c3                   	ret    
 17b:	90                   	nop

0000017c <memset>:

void*
memset(void *dst, int c, uint n)
{
 17c:	55                   	push   %ebp
 17d:	89 e5                	mov    %esp,%ebp
 17f:	57                   	push   %edi
 180:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 183:	89 d7                	mov    %edx,%edi
 185:	8b 4d 10             	mov    0x10(%ebp),%ecx
 188:	8b 45 0c             	mov    0xc(%ebp),%eax
 18b:	fc                   	cld    
 18c:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 18e:	89 d0                	mov    %edx,%eax
 190:	5f                   	pop    %edi
 191:	5d                   	pop    %ebp
 192:	c3                   	ret    
 193:	90                   	nop

00000194 <strchr>:

char*
strchr(const char *s, char c)
{
 194:	55                   	push   %ebp
 195:	89 e5                	mov    %esp,%ebp
 197:	8b 45 08             	mov    0x8(%ebp),%eax
 19a:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
 19d:	8a 10                	mov    (%eax),%dl
 19f:	84 d2                	test   %dl,%dl
 1a1:	75 0c                	jne    1af <strchr+0x1b>
 1a3:	eb 13                	jmp    1b8 <strchr+0x24>
 1a5:	8d 76 00             	lea    0x0(%esi),%esi
 1a8:	40                   	inc    %eax
 1a9:	8a 10                	mov    (%eax),%dl
 1ab:	84 d2                	test   %dl,%dl
 1ad:	74 09                	je     1b8 <strchr+0x24>
    if(*s == c)
 1af:	38 ca                	cmp    %cl,%dl
 1b1:	75 f5                	jne    1a8 <strchr+0x14>
      return (char*)s;
  return 0;
}
 1b3:	5d                   	pop    %ebp
 1b4:	c3                   	ret    
 1b5:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
 1b8:	31 c0                	xor    %eax,%eax
}
 1ba:	5d                   	pop    %ebp
 1bb:	c3                   	ret    

000001bc <gets>:

char*
gets(char *buf, int max)
{
 1bc:	55                   	push   %ebp
 1bd:	89 e5                	mov    %esp,%ebp
 1bf:	57                   	push   %edi
 1c0:	56                   	push   %esi
 1c1:	53                   	push   %ebx
 1c2:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1c5:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
 1c7:	8d 7d e7             	lea    -0x19(%ebp),%edi
 1ca:	66 90                	xchg   %ax,%ax
  for(i=0; i+1 < max; ){
 1cc:	8d 73 01             	lea    0x1(%ebx),%esi
 1cf:	3b 75 0c             	cmp    0xc(%ebp),%esi
 1d2:	7d 40                	jge    214 <gets+0x58>
    cc = read(0, &c, 1);
 1d4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 1db:	00 
 1dc:	89 7c 24 04          	mov    %edi,0x4(%esp)
 1e0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1e7:	e8 fb 00 00 00       	call   2e7 <read>
    if(cc < 1)
 1ec:	85 c0                	test   %eax,%eax
 1ee:	7e 24                	jle    214 <gets+0x58>
      break;
    buf[i++] = c;
 1f0:	8a 45 e7             	mov    -0x19(%ebp),%al
 1f3:	8b 55 08             	mov    0x8(%ebp),%edx
 1f6:	88 44 32 ff          	mov    %al,-0x1(%edx,%esi,1)
    if(c == '\n' || c == '\r')
 1fa:	3c 0a                	cmp    $0xa,%al
 1fc:	74 06                	je     204 <gets+0x48>
 1fe:	89 f3                	mov    %esi,%ebx
 200:	3c 0d                	cmp    $0xd,%al
 202:	75 c8                	jne    1cc <gets+0x10>
      break;
  }
  buf[i] = '\0';
 204:	8b 45 08             	mov    0x8(%ebp),%eax
 207:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 20b:	83 c4 2c             	add    $0x2c,%esp
 20e:	5b                   	pop    %ebx
 20f:	5e                   	pop    %esi
 210:	5f                   	pop    %edi
 211:	5d                   	pop    %ebp
 212:	c3                   	ret    
 213:	90                   	nop
    if(cc < 1)
 214:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 216:	8b 45 08             	mov    0x8(%ebp),%eax
 219:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 21d:	83 c4 2c             	add    $0x2c,%esp
 220:	5b                   	pop    %ebx
 221:	5e                   	pop    %esi
 222:	5f                   	pop    %edi
 223:	5d                   	pop    %ebp
 224:	c3                   	ret    
 225:	8d 76 00             	lea    0x0(%esi),%esi

00000228 <stat>:

int
stat(char *n, struct stat *st)
{
 228:	55                   	push   %ebp
 229:	89 e5                	mov    %esp,%ebp
 22b:	56                   	push   %esi
 22c:	53                   	push   %ebx
 22d:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 230:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 237:	00 
 238:	8b 45 08             	mov    0x8(%ebp),%eax
 23b:	89 04 24             	mov    %eax,(%esp)
 23e:	e8 cc 00 00 00       	call   30f <open>
 243:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 245:	85 c0                	test   %eax,%eax
 247:	78 23                	js     26c <stat+0x44>
    return -1;
  r = fstat(fd, st);
 249:	8b 45 0c             	mov    0xc(%ebp),%eax
 24c:	89 44 24 04          	mov    %eax,0x4(%esp)
 250:	89 1c 24             	mov    %ebx,(%esp)
 253:	e8 cf 00 00 00       	call   327 <fstat>
 258:	89 c6                	mov    %eax,%esi
  close(fd);
 25a:	89 1c 24             	mov    %ebx,(%esp)
 25d:	e8 95 00 00 00       	call   2f7 <close>
  return r;
}
 262:	89 f0                	mov    %esi,%eax
 264:	83 c4 10             	add    $0x10,%esp
 267:	5b                   	pop    %ebx
 268:	5e                   	pop    %esi
 269:	5d                   	pop    %ebp
 26a:	c3                   	ret    
 26b:	90                   	nop
    return -1;
 26c:	be ff ff ff ff       	mov    $0xffffffff,%esi
 271:	eb ef                	jmp    262 <stat+0x3a>
 273:	90                   	nop

00000274 <atoi>:

int
atoi(const char *s)
{
 274:	55                   	push   %ebp
 275:	89 e5                	mov    %esp,%ebp
 277:	53                   	push   %ebx
 278:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 27b:	0f be 11             	movsbl (%ecx),%edx
 27e:	8d 42 d0             	lea    -0x30(%edx),%eax
 281:	3c 09                	cmp    $0x9,%al
 283:	b8 00 00 00 00       	mov    $0x0,%eax
 288:	77 15                	ja     29f <atoi+0x2b>
 28a:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 28c:	8d 04 80             	lea    (%eax,%eax,4),%eax
 28f:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
 293:	41                   	inc    %ecx
  while('0' <= *s && *s <= '9')
 294:	0f be 11             	movsbl (%ecx),%edx
 297:	8d 5a d0             	lea    -0x30(%edx),%ebx
 29a:	80 fb 09             	cmp    $0x9,%bl
 29d:	76 ed                	jbe    28c <atoi+0x18>
  return n;
}
 29f:	5b                   	pop    %ebx
 2a0:	5d                   	pop    %ebp
 2a1:	c3                   	ret    
 2a2:	66 90                	xchg   %ax,%ax

000002a4 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2a4:	55                   	push   %ebp
 2a5:	89 e5                	mov    %esp,%ebp
 2a7:	56                   	push   %esi
 2a8:	53                   	push   %ebx
 2a9:	8b 45 08             	mov    0x8(%ebp),%eax
 2ac:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 2af:	8b 75 10             	mov    0x10(%ebp),%esi
memmove(void *vdst, void *vsrc, int n)
 2b2:	31 d2                	xor    %edx,%edx
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2b4:	85 f6                	test   %esi,%esi
 2b6:	7e 0b                	jle    2c3 <memmove+0x1f>
    *dst++ = *src++;
 2b8:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 2bb:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2be:	42                   	inc    %edx
  while(n-- > 0)
 2bf:	39 f2                	cmp    %esi,%edx
 2c1:	75 f5                	jne    2b8 <memmove+0x14>
  return vdst;
}
 2c3:	5b                   	pop    %ebx
 2c4:	5e                   	pop    %esi
 2c5:	5d                   	pop    %ebp
 2c6:	c3                   	ret    

000002c7 <fork>:
 2c7:	b8 01 00 00 00       	mov    $0x1,%eax
 2cc:	cd 40                	int    $0x40
 2ce:	c3                   	ret    

000002cf <exit>:
 2cf:	b8 02 00 00 00       	mov    $0x2,%eax
 2d4:	cd 40                	int    $0x40
 2d6:	c3                   	ret    

000002d7 <wait>:
 2d7:	b8 03 00 00 00       	mov    $0x3,%eax
 2dc:	cd 40                	int    $0x40
 2de:	c3                   	ret    

000002df <pipe>:
 2df:	b8 04 00 00 00       	mov    $0x4,%eax
 2e4:	cd 40                	int    $0x40
 2e6:	c3                   	ret    

000002e7 <read>:
 2e7:	b8 05 00 00 00       	mov    $0x5,%eax
 2ec:	cd 40                	int    $0x40
 2ee:	c3                   	ret    

000002ef <write>:
 2ef:	b8 10 00 00 00       	mov    $0x10,%eax
 2f4:	cd 40                	int    $0x40
 2f6:	c3                   	ret    

000002f7 <close>:
 2f7:	b8 15 00 00 00       	mov    $0x15,%eax
 2fc:	cd 40                	int    $0x40
 2fe:	c3                   	ret    

000002ff <kill>:
 2ff:	b8 06 00 00 00       	mov    $0x6,%eax
 304:	cd 40                	int    $0x40
 306:	c3                   	ret    

00000307 <exec>:
 307:	b8 07 00 00 00       	mov    $0x7,%eax
 30c:	cd 40                	int    $0x40
 30e:	c3                   	ret    

0000030f <open>:
 30f:	b8 0f 00 00 00       	mov    $0xf,%eax
 314:	cd 40                	int    $0x40
 316:	c3                   	ret    

00000317 <mknod>:
 317:	b8 11 00 00 00       	mov    $0x11,%eax
 31c:	cd 40                	int    $0x40
 31e:	c3                   	ret    

0000031f <unlink>:
 31f:	b8 12 00 00 00       	mov    $0x12,%eax
 324:	cd 40                	int    $0x40
 326:	c3                   	ret    

00000327 <fstat>:
 327:	b8 08 00 00 00       	mov    $0x8,%eax
 32c:	cd 40                	int    $0x40
 32e:	c3                   	ret    

0000032f <link>:
 32f:	b8 13 00 00 00       	mov    $0x13,%eax
 334:	cd 40                	int    $0x40
 336:	c3                   	ret    

00000337 <mkdir>:
 337:	b8 14 00 00 00       	mov    $0x14,%eax
 33c:	cd 40                	int    $0x40
 33e:	c3                   	ret    

0000033f <chdir>:
 33f:	b8 09 00 00 00       	mov    $0x9,%eax
 344:	cd 40                	int    $0x40
 346:	c3                   	ret    

00000347 <dup>:
 347:	b8 0a 00 00 00       	mov    $0xa,%eax
 34c:	cd 40                	int    $0x40
 34e:	c3                   	ret    

0000034f <getpid>:
 34f:	b8 0b 00 00 00       	mov    $0xb,%eax
 354:	cd 40                	int    $0x40
 356:	c3                   	ret    

00000357 <sbrk>:
 357:	b8 0c 00 00 00       	mov    $0xc,%eax
 35c:	cd 40                	int    $0x40
 35e:	c3                   	ret    

0000035f <sleep>:
 35f:	b8 0d 00 00 00       	mov    $0xd,%eax
 364:	cd 40                	int    $0x40
 366:	c3                   	ret    

00000367 <uptime>:
 367:	b8 0e 00 00 00       	mov    $0xe,%eax
 36c:	cd 40                	int    $0x40
 36e:	c3                   	ret    

0000036f <getprocnum>:
 36f:	b8 16 00 00 00       	mov    $0x16,%eax
 374:	cd 40                	int    $0x40
 376:	c3                   	ret    

00000377 <mempagenum>:
 377:	b8 17 00 00 00       	mov    $0x17,%eax
 37c:	cd 40                	int    $0x40
 37e:	c3                   	ret    

0000037f <syscallnum>:
 37f:	b8 18 00 00 00       	mov    $0x18,%eax
 384:	cd 40                	int    $0x40
 386:	c3                   	ret    

00000387 <settickets>:
 387:	b8 19 00 00 00       	mov    $0x19,%eax
 38c:	cd 40                	int    $0x40
 38e:	c3                   	ret    

0000038f <getsheltime>:
 38f:	b8 1a 00 00 00       	mov    $0x1a,%eax
 394:	cd 40                	int    $0x40
 396:	c3                   	ret    

00000397 <setstride>:
 397:	b8 1b 00 00 00       	mov    $0x1b,%eax
 39c:	cd 40                	int    $0x40
 39e:	c3                   	ret    

0000039f <setpass>:
 39f:	b8 1c 00 00 00       	mov    $0x1c,%eax
 3a4:	cd 40                	int    $0x40
 3a6:	c3                   	ret    

000003a7 <join>:
 3a7:	b8 1d 00 00 00       	mov    $0x1d,%eax
 3ac:	cd 40                	int    $0x40
 3ae:	c3                   	ret    

000003af <clone1>:
 3af:	b8 1e 00 00 00       	mov    $0x1e,%eax
 3b4:	cd 40                	int    $0x40
 3b6:	c3                   	ret    
 3b7:	90                   	nop

000003b8 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3b8:	55                   	push   %ebp
 3b9:	89 e5                	mov    %esp,%ebp
 3bb:	57                   	push   %edi
 3bc:	56                   	push   %esi
 3bd:	53                   	push   %ebx
 3be:	83 ec 3c             	sub    $0x3c,%esp
 3c1:	89 c7                	mov    %eax,%edi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3c3:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 3c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
 3c8:	85 db                	test   %ebx,%ebx
 3ca:	74 04                	je     3d0 <printint+0x18>
 3cc:	85 d2                	test   %edx,%edx
 3ce:	78 5d                	js     42d <printint+0x75>
  neg = 0;
 3d0:	31 db                	xor    %ebx,%ebx
  } else {
    x = xx;
  }

  i = 0;
 3d2:	31 f6                	xor    %esi,%esi
 3d4:	eb 04                	jmp    3da <printint+0x22>
 3d6:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 3d8:	89 d6                	mov    %edx,%esi
 3da:	31 d2                	xor    %edx,%edx
 3dc:	f7 f1                	div    %ecx
 3de:	8a 92 b1 07 00 00    	mov    0x7b1(%edx),%dl
 3e4:	88 54 35 d8          	mov    %dl,-0x28(%ebp,%esi,1)
 3e8:	8d 56 01             	lea    0x1(%esi),%edx
  }while((x /= base) != 0);
 3eb:	85 c0                	test   %eax,%eax
 3ed:	75 e9                	jne    3d8 <printint+0x20>
  if(neg)
 3ef:	85 db                	test   %ebx,%ebx
 3f1:	74 08                	je     3fb <printint+0x43>
    buf[i++] = '-';
 3f3:	c6 44 15 d8 2d       	movb   $0x2d,-0x28(%ebp,%edx,1)
 3f8:	8d 56 02             	lea    0x2(%esi),%edx

  while(--i >= 0)
 3fb:	8d 5a ff             	lea    -0x1(%edx),%ebx
 3fe:	8d 75 d7             	lea    -0x29(%ebp),%esi
 401:	8d 76 00             	lea    0x0(%esi),%esi
 404:	8a 44 1d d8          	mov    -0x28(%ebp,%ebx,1),%al
 408:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 40b:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 412:	00 
 413:	89 74 24 04          	mov    %esi,0x4(%esp)
 417:	89 3c 24             	mov    %edi,(%esp)
 41a:	e8 d0 fe ff ff       	call   2ef <write>
  while(--i >= 0)
 41f:	4b                   	dec    %ebx
 420:	83 fb ff             	cmp    $0xffffffff,%ebx
 423:	75 df                	jne    404 <printint+0x4c>
    putc(fd, buf[i]);
}
 425:	83 c4 3c             	add    $0x3c,%esp
 428:	5b                   	pop    %ebx
 429:	5e                   	pop    %esi
 42a:	5f                   	pop    %edi
 42b:	5d                   	pop    %ebp
 42c:	c3                   	ret    
    x = -xx;
 42d:	f7 d8                	neg    %eax
    neg = 1;
 42f:	bb 01 00 00 00       	mov    $0x1,%ebx
    x = -xx;
 434:	eb 9c                	jmp    3d2 <printint+0x1a>
 436:	66 90                	xchg   %ax,%ax

00000438 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 438:	55                   	push   %ebp
 439:	89 e5                	mov    %esp,%ebp
 43b:	57                   	push   %edi
 43c:	56                   	push   %esi
 43d:	53                   	push   %ebx
 43e:	83 ec 3c             	sub    $0x3c,%esp
 441:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 444:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 447:	8a 03                	mov    (%ebx),%al
 449:	84 c0                	test   %al,%al
 44b:	0f 84 bb 00 00 00    	je     50c <printf+0xd4>
printf(int fd, char *fmt, ...)
 451:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
 452:	8d 55 10             	lea    0x10(%ebp),%edx
 455:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  state = 0;
 458:	31 ff                	xor    %edi,%edi
 45a:	eb 2f                	jmp    48b <printf+0x53>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 45c:	83 f9 25             	cmp    $0x25,%ecx
 45f:	0f 84 af 00 00 00    	je     514 <printf+0xdc>
        state = '%';
      } else {
        putc(fd, c);
 465:	88 4d e2             	mov    %cl,-0x1e(%ebp)
  write(fd, &c, 1);
 468:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 46f:	00 
 470:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 473:	89 44 24 04          	mov    %eax,0x4(%esp)
 477:	89 34 24             	mov    %esi,(%esp)
 47a:	e8 70 fe ff ff       	call   2ef <write>
 47f:	43                   	inc    %ebx
  for(i = 0; fmt[i]; i++){
 480:	8a 43 ff             	mov    -0x1(%ebx),%al
 483:	84 c0                	test   %al,%al
 485:	0f 84 81 00 00 00    	je     50c <printf+0xd4>
    c = fmt[i] & 0xff;
 48b:	0f b6 c8             	movzbl %al,%ecx
    if(state == 0){
 48e:	85 ff                	test   %edi,%edi
 490:	74 ca                	je     45c <printf+0x24>
      }
    } else if(state == '%'){
 492:	83 ff 25             	cmp    $0x25,%edi
 495:	75 e8                	jne    47f <printf+0x47>
      if(c == 'd'){
 497:	83 f9 64             	cmp    $0x64,%ecx
 49a:	0f 84 14 01 00 00    	je     5b4 <printf+0x17c>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 4a0:	83 f9 78             	cmp    $0x78,%ecx
 4a3:	74 7b                	je     520 <printf+0xe8>
 4a5:	83 f9 70             	cmp    $0x70,%ecx
 4a8:	74 76                	je     520 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4aa:	83 f9 73             	cmp    $0x73,%ecx
 4ad:	0f 84 91 00 00 00    	je     544 <printf+0x10c>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4b3:	83 f9 63             	cmp    $0x63,%ecx
 4b6:	0f 84 cc 00 00 00    	je     588 <printf+0x150>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4bc:	83 f9 25             	cmp    $0x25,%ecx
 4bf:	0f 84 13 01 00 00    	je     5d8 <printf+0x1a0>
 4c5:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
  write(fd, &c, 1);
 4c9:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4d0:	00 
 4d1:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4d4:	89 44 24 04          	mov    %eax,0x4(%esp)
 4d8:	89 34 24             	mov    %esi,(%esp)
 4db:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 4de:	e8 0c fe ff ff       	call   2ef <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 4e3:	8b 4d d0             	mov    -0x30(%ebp),%ecx
 4e6:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
 4e9:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4f0:	00 
 4f1:	8d 55 e7             	lea    -0x19(%ebp),%edx
 4f4:	89 54 24 04          	mov    %edx,0x4(%esp)
 4f8:	89 34 24             	mov    %esi,(%esp)
 4fb:	e8 ef fd ff ff       	call   2ef <write>
      }
      state = 0;
 500:	31 ff                	xor    %edi,%edi
 502:	43                   	inc    %ebx
  for(i = 0; fmt[i]; i++){
 503:	8a 43 ff             	mov    -0x1(%ebx),%al
 506:	84 c0                	test   %al,%al
 508:	75 81                	jne    48b <printf+0x53>
 50a:	66 90                	xchg   %ax,%ax
    }
  }
}
 50c:	83 c4 3c             	add    $0x3c,%esp
 50f:	5b                   	pop    %ebx
 510:	5e                   	pop    %esi
 511:	5f                   	pop    %edi
 512:	5d                   	pop    %ebp
 513:	c3                   	ret    
        state = '%';
 514:	bf 25 00 00 00       	mov    $0x25,%edi
 519:	e9 61 ff ff ff       	jmp    47f <printf+0x47>
 51e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 520:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 527:	b9 10 00 00 00       	mov    $0x10,%ecx
 52c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 52f:	8b 10                	mov    (%eax),%edx
 531:	89 f0                	mov    %esi,%eax
 533:	e8 80 fe ff ff       	call   3b8 <printint>
        ap++;
 538:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 53c:	31 ff                	xor    %edi,%edi
        ap++;
 53e:	e9 3c ff ff ff       	jmp    47f <printf+0x47>
 543:	90                   	nop
        s = (char*)*ap;
 544:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 547:	8b 3a                	mov    (%edx),%edi
        ap++;
 549:	83 c2 04             	add    $0x4,%edx
 54c:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
 54f:	85 ff                	test   %edi,%edi
 551:	0f 84 a3 00 00 00    	je     5fa <printf+0x1c2>
        while(*s != 0){
 557:	8a 07                	mov    (%edi),%al
 559:	84 c0                	test   %al,%al
 55b:	74 24                	je     581 <printf+0x149>
 55d:	8d 76 00             	lea    0x0(%esi),%esi
 560:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 563:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 56a:	00 
 56b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 56e:	89 44 24 04          	mov    %eax,0x4(%esp)
 572:	89 34 24             	mov    %esi,(%esp)
 575:	e8 75 fd ff ff       	call   2ef <write>
          s++;
 57a:	47                   	inc    %edi
        while(*s != 0){
 57b:	8a 07                	mov    (%edi),%al
 57d:	84 c0                	test   %al,%al
 57f:	75 df                	jne    560 <printf+0x128>
      state = 0;
 581:	31 ff                	xor    %edi,%edi
 583:	e9 f7 fe ff ff       	jmp    47f <printf+0x47>
        putc(fd, *ap);
 588:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 58b:	8b 02                	mov    (%edx),%eax
 58d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 590:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 597:	00 
 598:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 59b:	89 44 24 04          	mov    %eax,0x4(%esp)
 59f:	89 34 24             	mov    %esi,(%esp)
 5a2:	e8 48 fd ff ff       	call   2ef <write>
        ap++;
 5a7:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 5ab:	31 ff                	xor    %edi,%edi
 5ad:	e9 cd fe ff ff       	jmp    47f <printf+0x47>
 5b2:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 5b4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 5bb:	b1 0a                	mov    $0xa,%cl
 5bd:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 5c0:	8b 10                	mov    (%eax),%edx
 5c2:	89 f0                	mov    %esi,%eax
 5c4:	e8 ef fd ff ff       	call   3b8 <printint>
        ap++;
 5c9:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 5cd:	66 31 ff             	xor    %di,%di
 5d0:	e9 aa fe ff ff       	jmp    47f <printf+0x47>
 5d5:	8d 76 00             	lea    0x0(%esi),%esi
 5d8:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
  write(fd, &c, 1);
 5dc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5e3:	00 
 5e4:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 5e7:	89 44 24 04          	mov    %eax,0x4(%esp)
 5eb:	89 34 24             	mov    %esi,(%esp)
 5ee:	e8 fc fc ff ff       	call   2ef <write>
      state = 0;
 5f3:	31 ff                	xor    %edi,%edi
 5f5:	e9 85 fe ff ff       	jmp    47f <printf+0x47>
          s = "(null)";
 5fa:	bf aa 07 00 00       	mov    $0x7aa,%edi
 5ff:	e9 53 ff ff ff       	jmp    557 <printf+0x11f>

00000604 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 604:	55                   	push   %ebp
 605:	89 e5                	mov    %esp,%ebp
 607:	57                   	push   %edi
 608:	56                   	push   %esi
 609:	53                   	push   %ebx
 60a:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 60d:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 610:	a1 4c 0a 00 00       	mov    0xa4c,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 615:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 617:	39 d0                	cmp    %edx,%eax
 619:	72 11                	jb     62c <free+0x28>
 61b:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 61c:	39 c8                	cmp    %ecx,%eax
 61e:	72 04                	jb     624 <free+0x20>
 620:	39 ca                	cmp    %ecx,%edx
 622:	72 10                	jb     634 <free+0x30>
 624:	89 c8                	mov    %ecx,%eax
 626:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 628:	39 d0                	cmp    %edx,%eax
 62a:	73 f0                	jae    61c <free+0x18>
 62c:	39 ca                	cmp    %ecx,%edx
 62e:	72 04                	jb     634 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 630:	39 c8                	cmp    %ecx,%eax
 632:	72 f0                	jb     624 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 634:	8b 73 fc             	mov    -0x4(%ebx),%esi
 637:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 63a:	39 cf                	cmp    %ecx,%edi
 63c:	74 1a                	je     658 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 63e:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 641:	8b 48 04             	mov    0x4(%eax),%ecx
 644:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 647:	39 f2                	cmp    %esi,%edx
 649:	74 24                	je     66f <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 64b:	89 10                	mov    %edx,(%eax)
  freep = p;
 64d:	a3 4c 0a 00 00       	mov    %eax,0xa4c
}
 652:	5b                   	pop    %ebx
 653:	5e                   	pop    %esi
 654:	5f                   	pop    %edi
 655:	5d                   	pop    %ebp
 656:	c3                   	ret    
 657:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 658:	03 71 04             	add    0x4(%ecx),%esi
 65b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 65e:	8b 08                	mov    (%eax),%ecx
 660:	8b 09                	mov    (%ecx),%ecx
 662:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 665:	8b 48 04             	mov    0x4(%eax),%ecx
 668:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 66b:	39 f2                	cmp    %esi,%edx
 66d:	75 dc                	jne    64b <free+0x47>
    p->s.size += bp->s.size;
 66f:	03 4b fc             	add    -0x4(%ebx),%ecx
 672:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 675:	8b 53 f8             	mov    -0x8(%ebx),%edx
 678:	89 10                	mov    %edx,(%eax)
  freep = p;
 67a:	a3 4c 0a 00 00       	mov    %eax,0xa4c
}
 67f:	5b                   	pop    %ebx
 680:	5e                   	pop    %esi
 681:	5f                   	pop    %edi
 682:	5d                   	pop    %ebp
 683:	c3                   	ret    

00000684 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 684:	55                   	push   %ebp
 685:	89 e5                	mov    %esp,%ebp
 687:	57                   	push   %edi
 688:	56                   	push   %esi
 689:	53                   	push   %ebx
 68a:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 68d:	8b 75 08             	mov    0x8(%ebp),%esi
 690:	83 c6 07             	add    $0x7,%esi
 693:	c1 ee 03             	shr    $0x3,%esi
 696:	46                   	inc    %esi
  if((prevp = freep) == 0){
 697:	8b 15 4c 0a 00 00    	mov    0xa4c,%edx
 69d:	85 d2                	test   %edx,%edx
 69f:	0f 84 8d 00 00 00    	je     732 <malloc+0xae>
 6a5:	8b 02                	mov    (%edx),%eax
 6a7:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6aa:	39 ce                	cmp    %ecx,%esi
 6ac:	76 52                	jbe    700 <malloc+0x7c>
 6ae:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 6b5:	eb 0a                	jmp    6c1 <malloc+0x3d>
 6b7:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6b8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6ba:	8b 48 04             	mov    0x4(%eax),%ecx
 6bd:	39 ce                	cmp    %ecx,%esi
 6bf:	76 3f                	jbe    700 <malloc+0x7c>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6c1:	89 c2                	mov    %eax,%edx
 6c3:	3b 05 4c 0a 00 00    	cmp    0xa4c,%eax
 6c9:	75 ed                	jne    6b8 <malloc+0x34>
  if(nu < 4096)
 6cb:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 6d1:	76 4d                	jbe    720 <malloc+0x9c>
 6d3:	89 d8                	mov    %ebx,%eax
 6d5:	89 f7                	mov    %esi,%edi
  p = sbrk(nu * sizeof(Header));
 6d7:	89 04 24             	mov    %eax,(%esp)
 6da:	e8 78 fc ff ff       	call   357 <sbrk>
  if(p == (char*)-1)
 6df:	83 f8 ff             	cmp    $0xffffffff,%eax
 6e2:	74 18                	je     6fc <malloc+0x78>
  hp->s.size = nu;
 6e4:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 6e7:	83 c0 08             	add    $0x8,%eax
 6ea:	89 04 24             	mov    %eax,(%esp)
 6ed:	e8 12 ff ff ff       	call   604 <free>
  return freep;
 6f2:	8b 15 4c 0a 00 00    	mov    0xa4c,%edx
      if((p = morecore(nunits)) == 0)
 6f8:	85 d2                	test   %edx,%edx
 6fa:	75 bc                	jne    6b8 <malloc+0x34>
        return 0;
 6fc:	31 c0                	xor    %eax,%eax
 6fe:	eb 18                	jmp    718 <malloc+0x94>
      if(p->s.size == nunits)
 700:	39 ce                	cmp    %ecx,%esi
 702:	74 28                	je     72c <malloc+0xa8>
        p->s.size -= nunits;
 704:	29 f1                	sub    %esi,%ecx
 706:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 709:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 70c:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 70f:	89 15 4c 0a 00 00    	mov    %edx,0xa4c
      return (void*)(p + 1);
 715:	83 c0 08             	add    $0x8,%eax
  }
}
 718:	83 c4 1c             	add    $0x1c,%esp
 71b:	5b                   	pop    %ebx
 71c:	5e                   	pop    %esi
 71d:	5f                   	pop    %edi
 71e:	5d                   	pop    %ebp
 71f:	c3                   	ret    
  if(nu < 4096)
 720:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 725:	bf 00 10 00 00       	mov    $0x1000,%edi
 72a:	eb ab                	jmp    6d7 <malloc+0x53>
        prevp->s.ptr = p->s.ptr;
 72c:	8b 08                	mov    (%eax),%ecx
 72e:	89 0a                	mov    %ecx,(%edx)
 730:	eb dd                	jmp    70f <malloc+0x8b>
    base.s.ptr = freep = prevp = &base;
 732:	c7 05 4c 0a 00 00 50 	movl   $0xa50,0xa4c
 739:	0a 00 00 
 73c:	c7 05 50 0a 00 00 50 	movl   $0xa50,0xa50
 743:	0a 00 00 
    base.s.size = 0;
 746:	c7 05 54 0a 00 00 00 	movl   $0x0,0xa54
 74d:	00 00 00 
 750:	b8 50 0a 00 00       	mov    $0xa50,%eax
 755:	e9 54 ff ff ff       	jmp    6ae <malloc+0x2a>
