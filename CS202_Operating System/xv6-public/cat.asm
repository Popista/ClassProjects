
_cat：     文件格式 elf32-i386


Disassembly of section .text:

00000000 <main>:
  }
}

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
   6:	83 e4 f0             	and    $0xfffffff0,%esp
   9:	83 ec 20             	sub    $0x20,%esp
   c:	8b 7d 08             	mov    0x8(%ebp),%edi
  int fd, i;

  if(argc <= 1){
   f:	83 ff 01             	cmp    $0x1,%edi
  12:	7e 66                	jle    7a <main+0x7a>
main(int argc, char *argv[])
  14:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  17:	83 c3 04             	add    $0x4,%ebx
  1a:	be 01 00 00 00       	mov    $0x1,%esi
  1f:	90                   	nop
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  20:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  27:	00 
  28:	8b 03                	mov    (%ebx),%eax
  2a:	89 04 24             	mov    %eax,(%esp)
  2d:	e8 ed 02 00 00       	call   31f <open>
  32:	85 c0                	test   %eax,%eax
  34:	78 25                	js     5b <main+0x5b>
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
  36:	89 04 24             	mov    %eax,(%esp)
  39:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  3d:	e8 4a 00 00 00       	call   8c <cat>
    close(fd);
  42:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  46:	89 04 24             	mov    %eax,(%esp)
  49:	e8 b9 02 00 00       	call   307 <close>
  for(i = 1; i < argc; i++){
  4e:	46                   	inc    %esi
  4f:	83 c3 04             	add    $0x4,%ebx
  52:	39 fe                	cmp    %edi,%esi
  54:	75 ca                	jne    20 <main+0x20>
  }
  exit();
  56:	e8 84 02 00 00       	call   2df <exit>
      printf(1, "cat: cannot open %s\n", argv[i]);
  5b:	8b 03                	mov    (%ebx),%eax
  5d:	89 44 24 08          	mov    %eax,0x8(%esp)
  61:	c7 44 24 04 8d 07 00 	movl   $0x78d,0x4(%esp)
  68:	00 
  69:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  70:	e8 d3 03 00 00       	call   448 <printf>
      exit();
  75:	e8 65 02 00 00       	call   2df <exit>
    cat(0);
  7a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  81:	e8 06 00 00 00       	call   8c <cat>
    exit();
  86:	e8 54 02 00 00       	call   2df <exit>
  8b:	90                   	nop

0000008c <cat>:
{
  8c:	55                   	push   %ebp
  8d:	89 e5                	mov    %esp,%ebp
  8f:	56                   	push   %esi
  90:	53                   	push   %ebx
  91:	83 ec 10             	sub    $0x10,%esp
  94:	8b 75 08             	mov    0x8(%ebp),%esi
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  97:	eb 1f                	jmp    b8 <cat+0x2c>
  99:	8d 76 00             	lea    0x0(%esi),%esi
    if (write(1, buf, n) != n) {
  9c:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  a0:	c7 44 24 04 a0 0a 00 	movl   $0xaa0,0x4(%esp)
  a7:	00 
  a8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  af:	e8 4b 02 00 00       	call   2ff <write>
  b4:	39 d8                	cmp    %ebx,%eax
  b6:	75 28                	jne    e0 <cat+0x54>
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  b8:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  bf:	00 
  c0:	c7 44 24 04 a0 0a 00 	movl   $0xaa0,0x4(%esp)
  c7:	00 
  c8:	89 34 24             	mov    %esi,(%esp)
  cb:	e8 27 02 00 00       	call   2f7 <read>
  d0:	89 c3                	mov    %eax,%ebx
  d2:	83 f8 00             	cmp    $0x0,%eax
  d5:	7f c5                	jg     9c <cat+0x10>
  if(n < 0){
  d7:	75 20                	jne    f9 <cat+0x6d>
}
  d9:	83 c4 10             	add    $0x10,%esp
  dc:	5b                   	pop    %ebx
  dd:	5e                   	pop    %esi
  de:	5d                   	pop    %ebp
  df:	c3                   	ret    
      printf(1, "cat: write error\n");
  e0:	c7 44 24 04 6a 07 00 	movl   $0x76a,0x4(%esp)
  e7:	00 
  e8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  ef:	e8 54 03 00 00       	call   448 <printf>
      exit();
  f4:	e8 e6 01 00 00       	call   2df <exit>
    printf(1, "cat: read error\n");
  f9:	c7 44 24 04 7c 07 00 	movl   $0x77c,0x4(%esp)
 100:	00 
 101:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 108:	e8 3b 03 00 00       	call   448 <printf>
    exit();
 10d:	e8 cd 01 00 00       	call   2df <exit>
 112:	66 90                	xchg   %ax,%ax

00000114 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 114:	55                   	push   %ebp
 115:	89 e5                	mov    %esp,%ebp
 117:	53                   	push   %ebx
 118:	8b 45 08             	mov    0x8(%ebp),%eax
 11b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 11e:	89 c2                	mov    %eax,%edx
 120:	8a 19                	mov    (%ecx),%bl
 122:	88 1a                	mov    %bl,(%edx)
 124:	42                   	inc    %edx
 125:	41                   	inc    %ecx
 126:	84 db                	test   %bl,%bl
 128:	75 f6                	jne    120 <strcpy+0xc>
    ;
  return os;
}
 12a:	5b                   	pop    %ebx
 12b:	5d                   	pop    %ebp
 12c:	c3                   	ret    
 12d:	8d 76 00             	lea    0x0(%esi),%esi

00000130 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	56                   	push   %esi
 134:	53                   	push   %ebx
 135:	8b 55 08             	mov    0x8(%ebp),%edx
 138:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 13b:	0f b6 02             	movzbl (%edx),%eax
 13e:	0f b6 19             	movzbl (%ecx),%ebx
 141:	84 c0                	test   %al,%al
 143:	75 14                	jne    159 <strcmp+0x29>
 145:	eb 1d                	jmp    164 <strcmp+0x34>
 147:	90                   	nop
    p++, q++;
 148:	42                   	inc    %edx
 149:	8d 71 01             	lea    0x1(%ecx),%esi
  while(*p && *p == *q)
 14c:	0f b6 02             	movzbl (%edx),%eax
 14f:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 153:	84 c0                	test   %al,%al
 155:	74 0d                	je     164 <strcmp+0x34>
    p++, q++;
 157:	89 f1                	mov    %esi,%ecx
  while(*p && *p == *q)
 159:	38 d8                	cmp    %bl,%al
 15b:	74 eb                	je     148 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 15d:	29 d8                	sub    %ebx,%eax
}
 15f:	5b                   	pop    %ebx
 160:	5e                   	pop    %esi
 161:	5d                   	pop    %ebp
 162:	c3                   	ret    
 163:	90                   	nop
  while(*p && *p == *q)
 164:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 166:	29 d8                	sub    %ebx,%eax
}
 168:	5b                   	pop    %ebx
 169:	5e                   	pop    %esi
 16a:	5d                   	pop    %ebp
 16b:	c3                   	ret    

0000016c <strlen>:

uint
strlen(char *s)
{
 16c:	55                   	push   %ebp
 16d:	89 e5                	mov    %esp,%ebp
 16f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 172:	80 39 00             	cmpb   $0x0,(%ecx)
 175:	74 10                	je     187 <strlen+0x1b>
 177:	31 d2                	xor    %edx,%edx
 179:	8d 76 00             	lea    0x0(%esi),%esi
 17c:	42                   	inc    %edx
 17d:	89 d0                	mov    %edx,%eax
 17f:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 183:	75 f7                	jne    17c <strlen+0x10>
    ;
  return n;
}
 185:	5d                   	pop    %ebp
 186:	c3                   	ret    
  for(n = 0; s[n]; n++)
 187:	31 c0                	xor    %eax,%eax
}
 189:	5d                   	pop    %ebp
 18a:	c3                   	ret    
 18b:	90                   	nop

0000018c <memset>:

void*
memset(void *dst, int c, uint n)
{
 18c:	55                   	push   %ebp
 18d:	89 e5                	mov    %esp,%ebp
 18f:	57                   	push   %edi
 190:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 193:	89 d7                	mov    %edx,%edi
 195:	8b 4d 10             	mov    0x10(%ebp),%ecx
 198:	8b 45 0c             	mov    0xc(%ebp),%eax
 19b:	fc                   	cld    
 19c:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 19e:	89 d0                	mov    %edx,%eax
 1a0:	5f                   	pop    %edi
 1a1:	5d                   	pop    %ebp
 1a2:	c3                   	ret    
 1a3:	90                   	nop

000001a4 <strchr>:

char*
strchr(const char *s, char c)
{
 1a4:	55                   	push   %ebp
 1a5:	89 e5                	mov    %esp,%ebp
 1a7:	8b 45 08             	mov    0x8(%ebp),%eax
 1aa:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
 1ad:	8a 10                	mov    (%eax),%dl
 1af:	84 d2                	test   %dl,%dl
 1b1:	75 0c                	jne    1bf <strchr+0x1b>
 1b3:	eb 13                	jmp    1c8 <strchr+0x24>
 1b5:	8d 76 00             	lea    0x0(%esi),%esi
 1b8:	40                   	inc    %eax
 1b9:	8a 10                	mov    (%eax),%dl
 1bb:	84 d2                	test   %dl,%dl
 1bd:	74 09                	je     1c8 <strchr+0x24>
    if(*s == c)
 1bf:	38 ca                	cmp    %cl,%dl
 1c1:	75 f5                	jne    1b8 <strchr+0x14>
      return (char*)s;
  return 0;
}
 1c3:	5d                   	pop    %ebp
 1c4:	c3                   	ret    
 1c5:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
 1c8:	31 c0                	xor    %eax,%eax
}
 1ca:	5d                   	pop    %ebp
 1cb:	c3                   	ret    

000001cc <gets>:

char*
gets(char *buf, int max)
{
 1cc:	55                   	push   %ebp
 1cd:	89 e5                	mov    %esp,%ebp
 1cf:	57                   	push   %edi
 1d0:	56                   	push   %esi
 1d1:	53                   	push   %ebx
 1d2:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1d5:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
 1d7:	8d 7d e7             	lea    -0x19(%ebp),%edi
 1da:	66 90                	xchg   %ax,%ax
  for(i=0; i+1 < max; ){
 1dc:	8d 73 01             	lea    0x1(%ebx),%esi
 1df:	3b 75 0c             	cmp    0xc(%ebp),%esi
 1e2:	7d 40                	jge    224 <gets+0x58>
    cc = read(0, &c, 1);
 1e4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 1eb:	00 
 1ec:	89 7c 24 04          	mov    %edi,0x4(%esp)
 1f0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1f7:	e8 fb 00 00 00       	call   2f7 <read>
    if(cc < 1)
 1fc:	85 c0                	test   %eax,%eax
 1fe:	7e 24                	jle    224 <gets+0x58>
      break;
    buf[i++] = c;
 200:	8a 45 e7             	mov    -0x19(%ebp),%al
 203:	8b 55 08             	mov    0x8(%ebp),%edx
 206:	88 44 32 ff          	mov    %al,-0x1(%edx,%esi,1)
    if(c == '\n' || c == '\r')
 20a:	3c 0a                	cmp    $0xa,%al
 20c:	74 06                	je     214 <gets+0x48>
 20e:	89 f3                	mov    %esi,%ebx
 210:	3c 0d                	cmp    $0xd,%al
 212:	75 c8                	jne    1dc <gets+0x10>
      break;
  }
  buf[i] = '\0';
 214:	8b 45 08             	mov    0x8(%ebp),%eax
 217:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 21b:	83 c4 2c             	add    $0x2c,%esp
 21e:	5b                   	pop    %ebx
 21f:	5e                   	pop    %esi
 220:	5f                   	pop    %edi
 221:	5d                   	pop    %ebp
 222:	c3                   	ret    
 223:	90                   	nop
    if(cc < 1)
 224:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 226:	8b 45 08             	mov    0x8(%ebp),%eax
 229:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 22d:	83 c4 2c             	add    $0x2c,%esp
 230:	5b                   	pop    %ebx
 231:	5e                   	pop    %esi
 232:	5f                   	pop    %edi
 233:	5d                   	pop    %ebp
 234:	c3                   	ret    
 235:	8d 76 00             	lea    0x0(%esi),%esi

00000238 <stat>:

int
stat(char *n, struct stat *st)
{
 238:	55                   	push   %ebp
 239:	89 e5                	mov    %esp,%ebp
 23b:	56                   	push   %esi
 23c:	53                   	push   %ebx
 23d:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 240:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 247:	00 
 248:	8b 45 08             	mov    0x8(%ebp),%eax
 24b:	89 04 24             	mov    %eax,(%esp)
 24e:	e8 cc 00 00 00       	call   31f <open>
 253:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 255:	85 c0                	test   %eax,%eax
 257:	78 23                	js     27c <stat+0x44>
    return -1;
  r = fstat(fd, st);
 259:	8b 45 0c             	mov    0xc(%ebp),%eax
 25c:	89 44 24 04          	mov    %eax,0x4(%esp)
 260:	89 1c 24             	mov    %ebx,(%esp)
 263:	e8 cf 00 00 00       	call   337 <fstat>
 268:	89 c6                	mov    %eax,%esi
  close(fd);
 26a:	89 1c 24             	mov    %ebx,(%esp)
 26d:	e8 95 00 00 00       	call   307 <close>
  return r;
}
 272:	89 f0                	mov    %esi,%eax
 274:	83 c4 10             	add    $0x10,%esp
 277:	5b                   	pop    %ebx
 278:	5e                   	pop    %esi
 279:	5d                   	pop    %ebp
 27a:	c3                   	ret    
 27b:	90                   	nop
    return -1;
 27c:	be ff ff ff ff       	mov    $0xffffffff,%esi
 281:	eb ef                	jmp    272 <stat+0x3a>
 283:	90                   	nop

00000284 <atoi>:

int
atoi(const char *s)
{
 284:	55                   	push   %ebp
 285:	89 e5                	mov    %esp,%ebp
 287:	53                   	push   %ebx
 288:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 28b:	0f be 11             	movsbl (%ecx),%edx
 28e:	8d 42 d0             	lea    -0x30(%edx),%eax
 291:	3c 09                	cmp    $0x9,%al
 293:	b8 00 00 00 00       	mov    $0x0,%eax
 298:	77 15                	ja     2af <atoi+0x2b>
 29a:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 29c:	8d 04 80             	lea    (%eax,%eax,4),%eax
 29f:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
 2a3:	41                   	inc    %ecx
  while('0' <= *s && *s <= '9')
 2a4:	0f be 11             	movsbl (%ecx),%edx
 2a7:	8d 5a d0             	lea    -0x30(%edx),%ebx
 2aa:	80 fb 09             	cmp    $0x9,%bl
 2ad:	76 ed                	jbe    29c <atoi+0x18>
  return n;
}
 2af:	5b                   	pop    %ebx
 2b0:	5d                   	pop    %ebp
 2b1:	c3                   	ret    
 2b2:	66 90                	xchg   %ax,%ax

000002b4 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2b4:	55                   	push   %ebp
 2b5:	89 e5                	mov    %esp,%ebp
 2b7:	56                   	push   %esi
 2b8:	53                   	push   %ebx
 2b9:	8b 45 08             	mov    0x8(%ebp),%eax
 2bc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 2bf:	8b 75 10             	mov    0x10(%ebp),%esi
memmove(void *vdst, void *vsrc, int n)
 2c2:	31 d2                	xor    %edx,%edx
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2c4:	85 f6                	test   %esi,%esi
 2c6:	7e 0b                	jle    2d3 <memmove+0x1f>
    *dst++ = *src++;
 2c8:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 2cb:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2ce:	42                   	inc    %edx
  while(n-- > 0)
 2cf:	39 f2                	cmp    %esi,%edx
 2d1:	75 f5                	jne    2c8 <memmove+0x14>
  return vdst;
}
 2d3:	5b                   	pop    %ebx
 2d4:	5e                   	pop    %esi
 2d5:	5d                   	pop    %ebp
 2d6:	c3                   	ret    

000002d7 <fork>:
 2d7:	b8 01 00 00 00       	mov    $0x1,%eax
 2dc:	cd 40                	int    $0x40
 2de:	c3                   	ret    

000002df <exit>:
 2df:	b8 02 00 00 00       	mov    $0x2,%eax
 2e4:	cd 40                	int    $0x40
 2e6:	c3                   	ret    

000002e7 <wait>:
 2e7:	b8 03 00 00 00       	mov    $0x3,%eax
 2ec:	cd 40                	int    $0x40
 2ee:	c3                   	ret    

000002ef <pipe>:
 2ef:	b8 04 00 00 00       	mov    $0x4,%eax
 2f4:	cd 40                	int    $0x40
 2f6:	c3                   	ret    

000002f7 <read>:
 2f7:	b8 05 00 00 00       	mov    $0x5,%eax
 2fc:	cd 40                	int    $0x40
 2fe:	c3                   	ret    

000002ff <write>:
 2ff:	b8 10 00 00 00       	mov    $0x10,%eax
 304:	cd 40                	int    $0x40
 306:	c3                   	ret    

00000307 <close>:
 307:	b8 15 00 00 00       	mov    $0x15,%eax
 30c:	cd 40                	int    $0x40
 30e:	c3                   	ret    

0000030f <kill>:
 30f:	b8 06 00 00 00       	mov    $0x6,%eax
 314:	cd 40                	int    $0x40
 316:	c3                   	ret    

00000317 <exec>:
 317:	b8 07 00 00 00       	mov    $0x7,%eax
 31c:	cd 40                	int    $0x40
 31e:	c3                   	ret    

0000031f <open>:
 31f:	b8 0f 00 00 00       	mov    $0xf,%eax
 324:	cd 40                	int    $0x40
 326:	c3                   	ret    

00000327 <mknod>:
 327:	b8 11 00 00 00       	mov    $0x11,%eax
 32c:	cd 40                	int    $0x40
 32e:	c3                   	ret    

0000032f <unlink>:
 32f:	b8 12 00 00 00       	mov    $0x12,%eax
 334:	cd 40                	int    $0x40
 336:	c3                   	ret    

00000337 <fstat>:
 337:	b8 08 00 00 00       	mov    $0x8,%eax
 33c:	cd 40                	int    $0x40
 33e:	c3                   	ret    

0000033f <link>:
 33f:	b8 13 00 00 00       	mov    $0x13,%eax
 344:	cd 40                	int    $0x40
 346:	c3                   	ret    

00000347 <mkdir>:
 347:	b8 14 00 00 00       	mov    $0x14,%eax
 34c:	cd 40                	int    $0x40
 34e:	c3                   	ret    

0000034f <chdir>:
 34f:	b8 09 00 00 00       	mov    $0x9,%eax
 354:	cd 40                	int    $0x40
 356:	c3                   	ret    

00000357 <dup>:
 357:	b8 0a 00 00 00       	mov    $0xa,%eax
 35c:	cd 40                	int    $0x40
 35e:	c3                   	ret    

0000035f <getpid>:
 35f:	b8 0b 00 00 00       	mov    $0xb,%eax
 364:	cd 40                	int    $0x40
 366:	c3                   	ret    

00000367 <sbrk>:
 367:	b8 0c 00 00 00       	mov    $0xc,%eax
 36c:	cd 40                	int    $0x40
 36e:	c3                   	ret    

0000036f <sleep>:
 36f:	b8 0d 00 00 00       	mov    $0xd,%eax
 374:	cd 40                	int    $0x40
 376:	c3                   	ret    

00000377 <uptime>:
 377:	b8 0e 00 00 00       	mov    $0xe,%eax
 37c:	cd 40                	int    $0x40
 37e:	c3                   	ret    

0000037f <getprocnum>:
 37f:	b8 16 00 00 00       	mov    $0x16,%eax
 384:	cd 40                	int    $0x40
 386:	c3                   	ret    

00000387 <mempagenum>:
 387:	b8 17 00 00 00       	mov    $0x17,%eax
 38c:	cd 40                	int    $0x40
 38e:	c3                   	ret    

0000038f <syscallnum>:
 38f:	b8 18 00 00 00       	mov    $0x18,%eax
 394:	cd 40                	int    $0x40
 396:	c3                   	ret    

00000397 <settickets>:
 397:	b8 19 00 00 00       	mov    $0x19,%eax
 39c:	cd 40                	int    $0x40
 39e:	c3                   	ret    

0000039f <getsheltime>:
 39f:	b8 1a 00 00 00       	mov    $0x1a,%eax
 3a4:	cd 40                	int    $0x40
 3a6:	c3                   	ret    

000003a7 <setstride>:
 3a7:	b8 1b 00 00 00       	mov    $0x1b,%eax
 3ac:	cd 40                	int    $0x40
 3ae:	c3                   	ret    

000003af <setpass>:
 3af:	b8 1c 00 00 00       	mov    $0x1c,%eax
 3b4:	cd 40                	int    $0x40
 3b6:	c3                   	ret    

000003b7 <join>:
 3b7:	b8 1d 00 00 00       	mov    $0x1d,%eax
 3bc:	cd 40                	int    $0x40
 3be:	c3                   	ret    

000003bf <clone1>:
 3bf:	b8 1e 00 00 00       	mov    $0x1e,%eax
 3c4:	cd 40                	int    $0x40
 3c6:	c3                   	ret    
 3c7:	90                   	nop

000003c8 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3c8:	55                   	push   %ebp
 3c9:	89 e5                	mov    %esp,%ebp
 3cb:	57                   	push   %edi
 3cc:	56                   	push   %esi
 3cd:	53                   	push   %ebx
 3ce:	83 ec 3c             	sub    $0x3c,%esp
 3d1:	89 c7                	mov    %eax,%edi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3d3:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 3d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
 3d8:	85 db                	test   %ebx,%ebx
 3da:	74 04                	je     3e0 <printint+0x18>
 3dc:	85 d2                	test   %edx,%edx
 3de:	78 5d                	js     43d <printint+0x75>
  neg = 0;
 3e0:	31 db                	xor    %ebx,%ebx
  } else {
    x = xx;
  }

  i = 0;
 3e2:	31 f6                	xor    %esi,%esi
 3e4:	eb 04                	jmp    3ea <printint+0x22>
 3e6:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 3e8:	89 d6                	mov    %edx,%esi
 3ea:	31 d2                	xor    %edx,%edx
 3ec:	f7 f1                	div    %ecx
 3ee:	8a 92 a9 07 00 00    	mov    0x7a9(%edx),%dl
 3f4:	88 54 35 d8          	mov    %dl,-0x28(%ebp,%esi,1)
 3f8:	8d 56 01             	lea    0x1(%esi),%edx
  }while((x /= base) != 0);
 3fb:	85 c0                	test   %eax,%eax
 3fd:	75 e9                	jne    3e8 <printint+0x20>
  if(neg)
 3ff:	85 db                	test   %ebx,%ebx
 401:	74 08                	je     40b <printint+0x43>
    buf[i++] = '-';
 403:	c6 44 15 d8 2d       	movb   $0x2d,-0x28(%ebp,%edx,1)
 408:	8d 56 02             	lea    0x2(%esi),%edx

  while(--i >= 0)
 40b:	8d 5a ff             	lea    -0x1(%edx),%ebx
 40e:	8d 75 d7             	lea    -0x29(%ebp),%esi
 411:	8d 76 00             	lea    0x0(%esi),%esi
 414:	8a 44 1d d8          	mov    -0x28(%ebp,%ebx,1),%al
 418:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 41b:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 422:	00 
 423:	89 74 24 04          	mov    %esi,0x4(%esp)
 427:	89 3c 24             	mov    %edi,(%esp)
 42a:	e8 d0 fe ff ff       	call   2ff <write>
  while(--i >= 0)
 42f:	4b                   	dec    %ebx
 430:	83 fb ff             	cmp    $0xffffffff,%ebx
 433:	75 df                	jne    414 <printint+0x4c>
    putc(fd, buf[i]);
}
 435:	83 c4 3c             	add    $0x3c,%esp
 438:	5b                   	pop    %ebx
 439:	5e                   	pop    %esi
 43a:	5f                   	pop    %edi
 43b:	5d                   	pop    %ebp
 43c:	c3                   	ret    
    x = -xx;
 43d:	f7 d8                	neg    %eax
    neg = 1;
 43f:	bb 01 00 00 00       	mov    $0x1,%ebx
    x = -xx;
 444:	eb 9c                	jmp    3e2 <printint+0x1a>
 446:	66 90                	xchg   %ax,%ax

00000448 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 448:	55                   	push   %ebp
 449:	89 e5                	mov    %esp,%ebp
 44b:	57                   	push   %edi
 44c:	56                   	push   %esi
 44d:	53                   	push   %ebx
 44e:	83 ec 3c             	sub    $0x3c,%esp
 451:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 454:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 457:	8a 03                	mov    (%ebx),%al
 459:	84 c0                	test   %al,%al
 45b:	0f 84 bb 00 00 00    	je     51c <printf+0xd4>
printf(int fd, char *fmt, ...)
 461:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
 462:	8d 55 10             	lea    0x10(%ebp),%edx
 465:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  state = 0;
 468:	31 ff                	xor    %edi,%edi
 46a:	eb 2f                	jmp    49b <printf+0x53>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 46c:	83 f9 25             	cmp    $0x25,%ecx
 46f:	0f 84 af 00 00 00    	je     524 <printf+0xdc>
        state = '%';
      } else {
        putc(fd, c);
 475:	88 4d e2             	mov    %cl,-0x1e(%ebp)
  write(fd, &c, 1);
 478:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 47f:	00 
 480:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 483:	89 44 24 04          	mov    %eax,0x4(%esp)
 487:	89 34 24             	mov    %esi,(%esp)
 48a:	e8 70 fe ff ff       	call   2ff <write>
 48f:	43                   	inc    %ebx
  for(i = 0; fmt[i]; i++){
 490:	8a 43 ff             	mov    -0x1(%ebx),%al
 493:	84 c0                	test   %al,%al
 495:	0f 84 81 00 00 00    	je     51c <printf+0xd4>
    c = fmt[i] & 0xff;
 49b:	0f b6 c8             	movzbl %al,%ecx
    if(state == 0){
 49e:	85 ff                	test   %edi,%edi
 4a0:	74 ca                	je     46c <printf+0x24>
      }
    } else if(state == '%'){
 4a2:	83 ff 25             	cmp    $0x25,%edi
 4a5:	75 e8                	jne    48f <printf+0x47>
      if(c == 'd'){
 4a7:	83 f9 64             	cmp    $0x64,%ecx
 4aa:	0f 84 14 01 00 00    	je     5c4 <printf+0x17c>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 4b0:	83 f9 78             	cmp    $0x78,%ecx
 4b3:	74 7b                	je     530 <printf+0xe8>
 4b5:	83 f9 70             	cmp    $0x70,%ecx
 4b8:	74 76                	je     530 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4ba:	83 f9 73             	cmp    $0x73,%ecx
 4bd:	0f 84 91 00 00 00    	je     554 <printf+0x10c>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4c3:	83 f9 63             	cmp    $0x63,%ecx
 4c6:	0f 84 cc 00 00 00    	je     598 <printf+0x150>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4cc:	83 f9 25             	cmp    $0x25,%ecx
 4cf:	0f 84 13 01 00 00    	je     5e8 <printf+0x1a0>
 4d5:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
  write(fd, &c, 1);
 4d9:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4e0:	00 
 4e1:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4e4:	89 44 24 04          	mov    %eax,0x4(%esp)
 4e8:	89 34 24             	mov    %esi,(%esp)
 4eb:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 4ee:	e8 0c fe ff ff       	call   2ff <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 4f3:	8b 4d d0             	mov    -0x30(%ebp),%ecx
 4f6:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
 4f9:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 500:	00 
 501:	8d 55 e7             	lea    -0x19(%ebp),%edx
 504:	89 54 24 04          	mov    %edx,0x4(%esp)
 508:	89 34 24             	mov    %esi,(%esp)
 50b:	e8 ef fd ff ff       	call   2ff <write>
      }
      state = 0;
 510:	31 ff                	xor    %edi,%edi
 512:	43                   	inc    %ebx
  for(i = 0; fmt[i]; i++){
 513:	8a 43 ff             	mov    -0x1(%ebx),%al
 516:	84 c0                	test   %al,%al
 518:	75 81                	jne    49b <printf+0x53>
 51a:	66 90                	xchg   %ax,%ax
    }
  }
}
 51c:	83 c4 3c             	add    $0x3c,%esp
 51f:	5b                   	pop    %ebx
 520:	5e                   	pop    %esi
 521:	5f                   	pop    %edi
 522:	5d                   	pop    %ebp
 523:	c3                   	ret    
        state = '%';
 524:	bf 25 00 00 00       	mov    $0x25,%edi
 529:	e9 61 ff ff ff       	jmp    48f <printf+0x47>
 52e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 530:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 537:	b9 10 00 00 00       	mov    $0x10,%ecx
 53c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 53f:	8b 10                	mov    (%eax),%edx
 541:	89 f0                	mov    %esi,%eax
 543:	e8 80 fe ff ff       	call   3c8 <printint>
        ap++;
 548:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 54c:	31 ff                	xor    %edi,%edi
        ap++;
 54e:	e9 3c ff ff ff       	jmp    48f <printf+0x47>
 553:	90                   	nop
        s = (char*)*ap;
 554:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 557:	8b 3a                	mov    (%edx),%edi
        ap++;
 559:	83 c2 04             	add    $0x4,%edx
 55c:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
 55f:	85 ff                	test   %edi,%edi
 561:	0f 84 a3 00 00 00    	je     60a <printf+0x1c2>
        while(*s != 0){
 567:	8a 07                	mov    (%edi),%al
 569:	84 c0                	test   %al,%al
 56b:	74 24                	je     591 <printf+0x149>
 56d:	8d 76 00             	lea    0x0(%esi),%esi
 570:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 573:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 57a:	00 
 57b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 57e:	89 44 24 04          	mov    %eax,0x4(%esp)
 582:	89 34 24             	mov    %esi,(%esp)
 585:	e8 75 fd ff ff       	call   2ff <write>
          s++;
 58a:	47                   	inc    %edi
        while(*s != 0){
 58b:	8a 07                	mov    (%edi),%al
 58d:	84 c0                	test   %al,%al
 58f:	75 df                	jne    570 <printf+0x128>
      state = 0;
 591:	31 ff                	xor    %edi,%edi
 593:	e9 f7 fe ff ff       	jmp    48f <printf+0x47>
        putc(fd, *ap);
 598:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 59b:	8b 02                	mov    (%edx),%eax
 59d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 5a0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5a7:	00 
 5a8:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 5ab:	89 44 24 04          	mov    %eax,0x4(%esp)
 5af:	89 34 24             	mov    %esi,(%esp)
 5b2:	e8 48 fd ff ff       	call   2ff <write>
        ap++;
 5b7:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 5bb:	31 ff                	xor    %edi,%edi
 5bd:	e9 cd fe ff ff       	jmp    48f <printf+0x47>
 5c2:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 5c4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 5cb:	b1 0a                	mov    $0xa,%cl
 5cd:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 5d0:	8b 10                	mov    (%eax),%edx
 5d2:	89 f0                	mov    %esi,%eax
 5d4:	e8 ef fd ff ff       	call   3c8 <printint>
        ap++;
 5d9:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 5dd:	66 31 ff             	xor    %di,%di
 5e0:	e9 aa fe ff ff       	jmp    48f <printf+0x47>
 5e5:	8d 76 00             	lea    0x0(%esi),%esi
 5e8:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
  write(fd, &c, 1);
 5ec:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5f3:	00 
 5f4:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 5f7:	89 44 24 04          	mov    %eax,0x4(%esp)
 5fb:	89 34 24             	mov    %esi,(%esp)
 5fe:	e8 fc fc ff ff       	call   2ff <write>
      state = 0;
 603:	31 ff                	xor    %edi,%edi
 605:	e9 85 fe ff ff       	jmp    48f <printf+0x47>
          s = "(null)";
 60a:	bf a2 07 00 00       	mov    $0x7a2,%edi
 60f:	e9 53 ff ff ff       	jmp    567 <printf+0x11f>

00000614 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 614:	55                   	push   %ebp
 615:	89 e5                	mov    %esp,%ebp
 617:	57                   	push   %edi
 618:	56                   	push   %esi
 619:	53                   	push   %ebx
 61a:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 61d:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 620:	a1 80 0a 00 00       	mov    0xa80,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 625:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 627:	39 d0                	cmp    %edx,%eax
 629:	72 11                	jb     63c <free+0x28>
 62b:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 62c:	39 c8                	cmp    %ecx,%eax
 62e:	72 04                	jb     634 <free+0x20>
 630:	39 ca                	cmp    %ecx,%edx
 632:	72 10                	jb     644 <free+0x30>
 634:	89 c8                	mov    %ecx,%eax
 636:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 638:	39 d0                	cmp    %edx,%eax
 63a:	73 f0                	jae    62c <free+0x18>
 63c:	39 ca                	cmp    %ecx,%edx
 63e:	72 04                	jb     644 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 640:	39 c8                	cmp    %ecx,%eax
 642:	72 f0                	jb     634 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 644:	8b 73 fc             	mov    -0x4(%ebx),%esi
 647:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 64a:	39 cf                	cmp    %ecx,%edi
 64c:	74 1a                	je     668 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 64e:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 651:	8b 48 04             	mov    0x4(%eax),%ecx
 654:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 657:	39 f2                	cmp    %esi,%edx
 659:	74 24                	je     67f <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 65b:	89 10                	mov    %edx,(%eax)
  freep = p;
 65d:	a3 80 0a 00 00       	mov    %eax,0xa80
}
 662:	5b                   	pop    %ebx
 663:	5e                   	pop    %esi
 664:	5f                   	pop    %edi
 665:	5d                   	pop    %ebp
 666:	c3                   	ret    
 667:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 668:	03 71 04             	add    0x4(%ecx),%esi
 66b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 66e:	8b 08                	mov    (%eax),%ecx
 670:	8b 09                	mov    (%ecx),%ecx
 672:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 675:	8b 48 04             	mov    0x4(%eax),%ecx
 678:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 67b:	39 f2                	cmp    %esi,%edx
 67d:	75 dc                	jne    65b <free+0x47>
    p->s.size += bp->s.size;
 67f:	03 4b fc             	add    -0x4(%ebx),%ecx
 682:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 685:	8b 53 f8             	mov    -0x8(%ebx),%edx
 688:	89 10                	mov    %edx,(%eax)
  freep = p;
 68a:	a3 80 0a 00 00       	mov    %eax,0xa80
}
 68f:	5b                   	pop    %ebx
 690:	5e                   	pop    %esi
 691:	5f                   	pop    %edi
 692:	5d                   	pop    %ebp
 693:	c3                   	ret    

00000694 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 694:	55                   	push   %ebp
 695:	89 e5                	mov    %esp,%ebp
 697:	57                   	push   %edi
 698:	56                   	push   %esi
 699:	53                   	push   %ebx
 69a:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 69d:	8b 75 08             	mov    0x8(%ebp),%esi
 6a0:	83 c6 07             	add    $0x7,%esi
 6a3:	c1 ee 03             	shr    $0x3,%esi
 6a6:	46                   	inc    %esi
  if((prevp = freep) == 0){
 6a7:	8b 15 80 0a 00 00    	mov    0xa80,%edx
 6ad:	85 d2                	test   %edx,%edx
 6af:	0f 84 8d 00 00 00    	je     742 <malloc+0xae>
 6b5:	8b 02                	mov    (%edx),%eax
 6b7:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6ba:	39 ce                	cmp    %ecx,%esi
 6bc:	76 52                	jbe    710 <malloc+0x7c>
 6be:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 6c5:	eb 0a                	jmp    6d1 <malloc+0x3d>
 6c7:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6c8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6ca:	8b 48 04             	mov    0x4(%eax),%ecx
 6cd:	39 ce                	cmp    %ecx,%esi
 6cf:	76 3f                	jbe    710 <malloc+0x7c>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6d1:	89 c2                	mov    %eax,%edx
 6d3:	3b 05 80 0a 00 00    	cmp    0xa80,%eax
 6d9:	75 ed                	jne    6c8 <malloc+0x34>
  if(nu < 4096)
 6db:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 6e1:	76 4d                	jbe    730 <malloc+0x9c>
 6e3:	89 d8                	mov    %ebx,%eax
 6e5:	89 f7                	mov    %esi,%edi
  p = sbrk(nu * sizeof(Header));
 6e7:	89 04 24             	mov    %eax,(%esp)
 6ea:	e8 78 fc ff ff       	call   367 <sbrk>
  if(p == (char*)-1)
 6ef:	83 f8 ff             	cmp    $0xffffffff,%eax
 6f2:	74 18                	je     70c <malloc+0x78>
  hp->s.size = nu;
 6f4:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 6f7:	83 c0 08             	add    $0x8,%eax
 6fa:	89 04 24             	mov    %eax,(%esp)
 6fd:	e8 12 ff ff ff       	call   614 <free>
  return freep;
 702:	8b 15 80 0a 00 00    	mov    0xa80,%edx
      if((p = morecore(nunits)) == 0)
 708:	85 d2                	test   %edx,%edx
 70a:	75 bc                	jne    6c8 <malloc+0x34>
        return 0;
 70c:	31 c0                	xor    %eax,%eax
 70e:	eb 18                	jmp    728 <malloc+0x94>
      if(p->s.size == nunits)
 710:	39 ce                	cmp    %ecx,%esi
 712:	74 28                	je     73c <malloc+0xa8>
        p->s.size -= nunits;
 714:	29 f1                	sub    %esi,%ecx
 716:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 719:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 71c:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 71f:	89 15 80 0a 00 00    	mov    %edx,0xa80
      return (void*)(p + 1);
 725:	83 c0 08             	add    $0x8,%eax
  }
}
 728:	83 c4 1c             	add    $0x1c,%esp
 72b:	5b                   	pop    %ebx
 72c:	5e                   	pop    %esi
 72d:	5f                   	pop    %edi
 72e:	5d                   	pop    %ebp
 72f:	c3                   	ret    
  if(nu < 4096)
 730:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 735:	bf 00 10 00 00       	mov    $0x1000,%edi
 73a:	eb ab                	jmp    6e7 <malloc+0x53>
        prevp->s.ptr = p->s.ptr;
 73c:	8b 08                	mov    (%eax),%ecx
 73e:	89 0a                	mov    %ecx,(%edx)
 740:	eb dd                	jmp    71f <malloc+0x8b>
    base.s.ptr = freep = prevp = &base;
 742:	c7 05 80 0a 00 00 84 	movl   $0xa84,0xa80
 749:	0a 00 00 
 74c:	c7 05 84 0a 00 00 84 	movl   $0xa84,0xa84
 753:	0a 00 00 
    base.s.size = 0;
 756:	c7 05 88 0a 00 00 00 	movl   $0x0,0xa88
 75d:	00 00 00 
 760:	b8 84 0a 00 00       	mov    $0xa84,%eax
 765:	e9 54 ff ff ff       	jmp    6be <malloc+0x2a>
