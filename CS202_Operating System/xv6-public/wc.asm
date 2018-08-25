
_wc：     文件格式 elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "%d %d %d %s\n", l, w, c, name);
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
  12:	7e 6c                	jle    80 <main+0x80>
main(int argc, char *argv[])
  14:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  17:	83 c3 04             	add    $0x4,%ebx
  1a:	be 01 00 00 00       	mov    $0x1,%esi
  1f:	90                   	nop
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  20:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  27:	00 
  28:	8b 03                	mov    (%ebx),%eax
  2a:	89 04 24             	mov    %eax,(%esp)
  2d:	e8 5d 03 00 00       	call   38f <open>
  32:	85 c0                	test   %eax,%eax
  34:	78 2b                	js     61 <main+0x61>
      printf(1, "wc: cannot open %s\n", argv[i]);
      exit();
    }
    wc(fd, argv[i]);
  36:	8b 13                	mov    (%ebx),%edx
  38:	89 54 24 04          	mov    %edx,0x4(%esp)
  3c:	89 04 24             	mov    %eax,(%esp)
  3f:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  43:	e8 54 00 00 00       	call   9c <wc>
    close(fd);
  48:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  4c:	89 04 24             	mov    %eax,(%esp)
  4f:	e8 23 03 00 00       	call   377 <close>
  for(i = 1; i < argc; i++){
  54:	46                   	inc    %esi
  55:	83 c3 04             	add    $0x4,%ebx
  58:	39 fe                	cmp    %edi,%esi
  5a:	75 c4                	jne    20 <main+0x20>
  }
  exit();
  5c:	e8 ee 02 00 00       	call   34f <exit>
      printf(1, "wc: cannot open %s\n", argv[i]);
  61:	8b 03                	mov    (%ebx),%eax
  63:	89 44 24 08          	mov    %eax,0x8(%esp)
  67:	c7 44 24 04 fd 07 00 	movl   $0x7fd,0x4(%esp)
  6e:	00 
  6f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  76:	e8 3d 04 00 00       	call   4b8 <printf>
      exit();
  7b:	e8 cf 02 00 00       	call   34f <exit>
    wc(0, "");
  80:	c7 44 24 04 ef 07 00 	movl   $0x7ef,0x4(%esp)
  87:	00 
  88:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  8f:	e8 08 00 00 00       	call   9c <wc>
    exit();
  94:	e8 b6 02 00 00       	call   34f <exit>
  99:	66 90                	xchg   %ax,%ax
  9b:	90                   	nop

0000009c <wc>:
{
  9c:	55                   	push   %ebp
  9d:	89 e5                	mov    %esp,%ebp
  9f:	57                   	push   %edi
  a0:	56                   	push   %esi
  a1:	53                   	push   %ebx
  a2:	83 ec 3c             	sub    $0x3c,%esp
  inword = 0;
  a5:	31 db                	xor    %ebx,%ebx
  l = w = c = 0;
  a7:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  ae:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  b5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
  bc:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  c3:	00 
  c4:	c7 44 24 04 00 0b 00 	movl   $0xb00,0x4(%esp)
  cb:	00 
  cc:	8b 45 08             	mov    0x8(%ebp),%eax
  cf:	89 04 24             	mov    %eax,(%esp)
  d2:	e8 90 02 00 00       	call   367 <read>
  d7:	89 c6                	mov    %eax,%esi
  d9:	83 f8 00             	cmp    $0x0,%eax
  dc:	7e 51                	jle    12f <wc+0x93>
  de:	31 ff                	xor    %edi,%edi
  e0:	eb 1d                	jmp    ff <wc+0x63>
  e2:	66 90                	xchg   %ax,%ax
      if(strchr(" \r\t\n\v", buf[i]))
  e4:	89 44 24 04          	mov    %eax,0x4(%esp)
  e8:	c7 04 24 da 07 00 00 	movl   $0x7da,(%esp)
  ef:	e8 20 01 00 00       	call   214 <strchr>
  f4:	85 c0                	test   %eax,%eax
  f6:	74 18                	je     110 <wc+0x74>
        inword = 0;
  f8:	31 db                	xor    %ebx,%ebx
    for(i=0; i<n; i++){
  fa:	47                   	inc    %edi
  fb:	39 f7                	cmp    %esi,%edi
  fd:	74 1f                	je     11e <wc+0x82>
      if(buf[i] == '\n')
  ff:	0f be 87 00 0b 00 00 	movsbl 0xb00(%edi),%eax
 106:	3c 0a                	cmp    $0xa,%al
 108:	75 da                	jne    e4 <wc+0x48>
        l++;
 10a:	ff 45 e4             	incl   -0x1c(%ebp)
 10d:	eb d5                	jmp    e4 <wc+0x48>
 10f:	90                   	nop
      else if(!inword){
 110:	85 db                	test   %ebx,%ebx
 112:	75 14                	jne    128 <wc+0x8c>
        w++;
 114:	ff 45 e0             	incl   -0x20(%ebp)
        inword = 1;
 117:	b3 01                	mov    $0x1,%bl
    for(i=0; i<n; i++){
 119:	47                   	inc    %edi
 11a:	39 f7                	cmp    %esi,%edi
 11c:	75 e1                	jne    ff <wc+0x63>
 11e:	8b 45 dc             	mov    -0x24(%ebp),%eax
 121:	01 f8                	add    %edi,%eax
 123:	89 45 dc             	mov    %eax,-0x24(%ebp)
 126:	eb 94                	jmp    bc <wc+0x20>
      else if(!inword){
 128:	bb 01 00 00 00       	mov    $0x1,%ebx
 12d:	eb cb                	jmp    fa <wc+0x5e>
  if(n < 0){
 12f:	75 38                	jne    169 <wc+0xcd>
  printf(1, "%d %d %d %s\n", l, w, c, name);
 131:	8b 45 0c             	mov    0xc(%ebp),%eax
 134:	89 44 24 14          	mov    %eax,0x14(%esp)
 138:	8b 45 dc             	mov    -0x24(%ebp),%eax
 13b:	89 44 24 10          	mov    %eax,0x10(%esp)
 13f:	8b 45 e0             	mov    -0x20(%ebp),%eax
 142:	89 44 24 0c          	mov    %eax,0xc(%esp)
 146:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 149:	89 44 24 08          	mov    %eax,0x8(%esp)
 14d:	c7 44 24 04 f0 07 00 	movl   $0x7f0,0x4(%esp)
 154:	00 
 155:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 15c:	e8 57 03 00 00       	call   4b8 <printf>
}
 161:	83 c4 3c             	add    $0x3c,%esp
 164:	5b                   	pop    %ebx
 165:	5e                   	pop    %esi
 166:	5f                   	pop    %edi
 167:	5d                   	pop    %ebp
 168:	c3                   	ret    
    printf(1, "wc: read error\n");
 169:	c7 44 24 04 e0 07 00 	movl   $0x7e0,0x4(%esp)
 170:	00 
 171:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 178:	e8 3b 03 00 00       	call   4b8 <printf>
    exit();
 17d:	e8 cd 01 00 00       	call   34f <exit>
 182:	66 90                	xchg   %ax,%ax

00000184 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 184:	55                   	push   %ebp
 185:	89 e5                	mov    %esp,%ebp
 187:	53                   	push   %ebx
 188:	8b 45 08             	mov    0x8(%ebp),%eax
 18b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 18e:	89 c2                	mov    %eax,%edx
 190:	8a 19                	mov    (%ecx),%bl
 192:	88 1a                	mov    %bl,(%edx)
 194:	42                   	inc    %edx
 195:	41                   	inc    %ecx
 196:	84 db                	test   %bl,%bl
 198:	75 f6                	jne    190 <strcpy+0xc>
    ;
  return os;
}
 19a:	5b                   	pop    %ebx
 19b:	5d                   	pop    %ebp
 19c:	c3                   	ret    
 19d:	8d 76 00             	lea    0x0(%esi),%esi

000001a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	56                   	push   %esi
 1a4:	53                   	push   %ebx
 1a5:	8b 55 08             	mov    0x8(%ebp),%edx
 1a8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 1ab:	0f b6 02             	movzbl (%edx),%eax
 1ae:	0f b6 19             	movzbl (%ecx),%ebx
 1b1:	84 c0                	test   %al,%al
 1b3:	75 14                	jne    1c9 <strcmp+0x29>
 1b5:	eb 1d                	jmp    1d4 <strcmp+0x34>
 1b7:	90                   	nop
    p++, q++;
 1b8:	42                   	inc    %edx
 1b9:	8d 71 01             	lea    0x1(%ecx),%esi
  while(*p && *p == *q)
 1bc:	0f b6 02             	movzbl (%edx),%eax
 1bf:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 1c3:	84 c0                	test   %al,%al
 1c5:	74 0d                	je     1d4 <strcmp+0x34>
    p++, q++;
 1c7:	89 f1                	mov    %esi,%ecx
  while(*p && *p == *q)
 1c9:	38 d8                	cmp    %bl,%al
 1cb:	74 eb                	je     1b8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 1cd:	29 d8                	sub    %ebx,%eax
}
 1cf:	5b                   	pop    %ebx
 1d0:	5e                   	pop    %esi
 1d1:	5d                   	pop    %ebp
 1d2:	c3                   	ret    
 1d3:	90                   	nop
  while(*p && *p == *q)
 1d4:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 1d6:	29 d8                	sub    %ebx,%eax
}
 1d8:	5b                   	pop    %ebx
 1d9:	5e                   	pop    %esi
 1da:	5d                   	pop    %ebp
 1db:	c3                   	ret    

000001dc <strlen>:

uint
strlen(char *s)
{
 1dc:	55                   	push   %ebp
 1dd:	89 e5                	mov    %esp,%ebp
 1df:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 1e2:	80 39 00             	cmpb   $0x0,(%ecx)
 1e5:	74 10                	je     1f7 <strlen+0x1b>
 1e7:	31 d2                	xor    %edx,%edx
 1e9:	8d 76 00             	lea    0x0(%esi),%esi
 1ec:	42                   	inc    %edx
 1ed:	89 d0                	mov    %edx,%eax
 1ef:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1f3:	75 f7                	jne    1ec <strlen+0x10>
    ;
  return n;
}
 1f5:	5d                   	pop    %ebp
 1f6:	c3                   	ret    
  for(n = 0; s[n]; n++)
 1f7:	31 c0                	xor    %eax,%eax
}
 1f9:	5d                   	pop    %ebp
 1fa:	c3                   	ret    
 1fb:	90                   	nop

000001fc <memset>:

void*
memset(void *dst, int c, uint n)
{
 1fc:	55                   	push   %ebp
 1fd:	89 e5                	mov    %esp,%ebp
 1ff:	57                   	push   %edi
 200:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 203:	89 d7                	mov    %edx,%edi
 205:	8b 4d 10             	mov    0x10(%ebp),%ecx
 208:	8b 45 0c             	mov    0xc(%ebp),%eax
 20b:	fc                   	cld    
 20c:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 20e:	89 d0                	mov    %edx,%eax
 210:	5f                   	pop    %edi
 211:	5d                   	pop    %ebp
 212:	c3                   	ret    
 213:	90                   	nop

00000214 <strchr>:

char*
strchr(const char *s, char c)
{
 214:	55                   	push   %ebp
 215:	89 e5                	mov    %esp,%ebp
 217:	8b 45 08             	mov    0x8(%ebp),%eax
 21a:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
 21d:	8a 10                	mov    (%eax),%dl
 21f:	84 d2                	test   %dl,%dl
 221:	75 0c                	jne    22f <strchr+0x1b>
 223:	eb 13                	jmp    238 <strchr+0x24>
 225:	8d 76 00             	lea    0x0(%esi),%esi
 228:	40                   	inc    %eax
 229:	8a 10                	mov    (%eax),%dl
 22b:	84 d2                	test   %dl,%dl
 22d:	74 09                	je     238 <strchr+0x24>
    if(*s == c)
 22f:	38 ca                	cmp    %cl,%dl
 231:	75 f5                	jne    228 <strchr+0x14>
      return (char*)s;
  return 0;
}
 233:	5d                   	pop    %ebp
 234:	c3                   	ret    
 235:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
 238:	31 c0                	xor    %eax,%eax
}
 23a:	5d                   	pop    %ebp
 23b:	c3                   	ret    

0000023c <gets>:

char*
gets(char *buf, int max)
{
 23c:	55                   	push   %ebp
 23d:	89 e5                	mov    %esp,%ebp
 23f:	57                   	push   %edi
 240:	56                   	push   %esi
 241:	53                   	push   %ebx
 242:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 245:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
 247:	8d 7d e7             	lea    -0x19(%ebp),%edi
 24a:	66 90                	xchg   %ax,%ax
  for(i=0; i+1 < max; ){
 24c:	8d 73 01             	lea    0x1(%ebx),%esi
 24f:	3b 75 0c             	cmp    0xc(%ebp),%esi
 252:	7d 40                	jge    294 <gets+0x58>
    cc = read(0, &c, 1);
 254:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 25b:	00 
 25c:	89 7c 24 04          	mov    %edi,0x4(%esp)
 260:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 267:	e8 fb 00 00 00       	call   367 <read>
    if(cc < 1)
 26c:	85 c0                	test   %eax,%eax
 26e:	7e 24                	jle    294 <gets+0x58>
      break;
    buf[i++] = c;
 270:	8a 45 e7             	mov    -0x19(%ebp),%al
 273:	8b 55 08             	mov    0x8(%ebp),%edx
 276:	88 44 32 ff          	mov    %al,-0x1(%edx,%esi,1)
    if(c == '\n' || c == '\r')
 27a:	3c 0a                	cmp    $0xa,%al
 27c:	74 06                	je     284 <gets+0x48>
 27e:	89 f3                	mov    %esi,%ebx
 280:	3c 0d                	cmp    $0xd,%al
 282:	75 c8                	jne    24c <gets+0x10>
      break;
  }
  buf[i] = '\0';
 284:	8b 45 08             	mov    0x8(%ebp),%eax
 287:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 28b:	83 c4 2c             	add    $0x2c,%esp
 28e:	5b                   	pop    %ebx
 28f:	5e                   	pop    %esi
 290:	5f                   	pop    %edi
 291:	5d                   	pop    %ebp
 292:	c3                   	ret    
 293:	90                   	nop
    if(cc < 1)
 294:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 296:	8b 45 08             	mov    0x8(%ebp),%eax
 299:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 29d:	83 c4 2c             	add    $0x2c,%esp
 2a0:	5b                   	pop    %ebx
 2a1:	5e                   	pop    %esi
 2a2:	5f                   	pop    %edi
 2a3:	5d                   	pop    %ebp
 2a4:	c3                   	ret    
 2a5:	8d 76 00             	lea    0x0(%esi),%esi

000002a8 <stat>:

int
stat(char *n, struct stat *st)
{
 2a8:	55                   	push   %ebp
 2a9:	89 e5                	mov    %esp,%ebp
 2ab:	56                   	push   %esi
 2ac:	53                   	push   %ebx
 2ad:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2b0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2b7:	00 
 2b8:	8b 45 08             	mov    0x8(%ebp),%eax
 2bb:	89 04 24             	mov    %eax,(%esp)
 2be:	e8 cc 00 00 00       	call   38f <open>
 2c3:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 2c5:	85 c0                	test   %eax,%eax
 2c7:	78 23                	js     2ec <stat+0x44>
    return -1;
  r = fstat(fd, st);
 2c9:	8b 45 0c             	mov    0xc(%ebp),%eax
 2cc:	89 44 24 04          	mov    %eax,0x4(%esp)
 2d0:	89 1c 24             	mov    %ebx,(%esp)
 2d3:	e8 cf 00 00 00       	call   3a7 <fstat>
 2d8:	89 c6                	mov    %eax,%esi
  close(fd);
 2da:	89 1c 24             	mov    %ebx,(%esp)
 2dd:	e8 95 00 00 00       	call   377 <close>
  return r;
}
 2e2:	89 f0                	mov    %esi,%eax
 2e4:	83 c4 10             	add    $0x10,%esp
 2e7:	5b                   	pop    %ebx
 2e8:	5e                   	pop    %esi
 2e9:	5d                   	pop    %ebp
 2ea:	c3                   	ret    
 2eb:	90                   	nop
    return -1;
 2ec:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2f1:	eb ef                	jmp    2e2 <stat+0x3a>
 2f3:	90                   	nop

000002f4 <atoi>:

int
atoi(const char *s)
{
 2f4:	55                   	push   %ebp
 2f5:	89 e5                	mov    %esp,%ebp
 2f7:	53                   	push   %ebx
 2f8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2fb:	0f be 11             	movsbl (%ecx),%edx
 2fe:	8d 42 d0             	lea    -0x30(%edx),%eax
 301:	3c 09                	cmp    $0x9,%al
 303:	b8 00 00 00 00       	mov    $0x0,%eax
 308:	77 15                	ja     31f <atoi+0x2b>
 30a:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 30c:	8d 04 80             	lea    (%eax,%eax,4),%eax
 30f:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
 313:	41                   	inc    %ecx
  while('0' <= *s && *s <= '9')
 314:	0f be 11             	movsbl (%ecx),%edx
 317:	8d 5a d0             	lea    -0x30(%edx),%ebx
 31a:	80 fb 09             	cmp    $0x9,%bl
 31d:	76 ed                	jbe    30c <atoi+0x18>
  return n;
}
 31f:	5b                   	pop    %ebx
 320:	5d                   	pop    %ebp
 321:	c3                   	ret    
 322:	66 90                	xchg   %ax,%ax

00000324 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 324:	55                   	push   %ebp
 325:	89 e5                	mov    %esp,%ebp
 327:	56                   	push   %esi
 328:	53                   	push   %ebx
 329:	8b 45 08             	mov    0x8(%ebp),%eax
 32c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 32f:	8b 75 10             	mov    0x10(%ebp),%esi
memmove(void *vdst, void *vsrc, int n)
 332:	31 d2                	xor    %edx,%edx
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 334:	85 f6                	test   %esi,%esi
 336:	7e 0b                	jle    343 <memmove+0x1f>
    *dst++ = *src++;
 338:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 33b:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 33e:	42                   	inc    %edx
  while(n-- > 0)
 33f:	39 f2                	cmp    %esi,%edx
 341:	75 f5                	jne    338 <memmove+0x14>
  return vdst;
}
 343:	5b                   	pop    %ebx
 344:	5e                   	pop    %esi
 345:	5d                   	pop    %ebp
 346:	c3                   	ret    

00000347 <fork>:
 347:	b8 01 00 00 00       	mov    $0x1,%eax
 34c:	cd 40                	int    $0x40
 34e:	c3                   	ret    

0000034f <exit>:
 34f:	b8 02 00 00 00       	mov    $0x2,%eax
 354:	cd 40                	int    $0x40
 356:	c3                   	ret    

00000357 <wait>:
 357:	b8 03 00 00 00       	mov    $0x3,%eax
 35c:	cd 40                	int    $0x40
 35e:	c3                   	ret    

0000035f <pipe>:
 35f:	b8 04 00 00 00       	mov    $0x4,%eax
 364:	cd 40                	int    $0x40
 366:	c3                   	ret    

00000367 <read>:
 367:	b8 05 00 00 00       	mov    $0x5,%eax
 36c:	cd 40                	int    $0x40
 36e:	c3                   	ret    

0000036f <write>:
 36f:	b8 10 00 00 00       	mov    $0x10,%eax
 374:	cd 40                	int    $0x40
 376:	c3                   	ret    

00000377 <close>:
 377:	b8 15 00 00 00       	mov    $0x15,%eax
 37c:	cd 40                	int    $0x40
 37e:	c3                   	ret    

0000037f <kill>:
 37f:	b8 06 00 00 00       	mov    $0x6,%eax
 384:	cd 40                	int    $0x40
 386:	c3                   	ret    

00000387 <exec>:
 387:	b8 07 00 00 00       	mov    $0x7,%eax
 38c:	cd 40                	int    $0x40
 38e:	c3                   	ret    

0000038f <open>:
 38f:	b8 0f 00 00 00       	mov    $0xf,%eax
 394:	cd 40                	int    $0x40
 396:	c3                   	ret    

00000397 <mknod>:
 397:	b8 11 00 00 00       	mov    $0x11,%eax
 39c:	cd 40                	int    $0x40
 39e:	c3                   	ret    

0000039f <unlink>:
 39f:	b8 12 00 00 00       	mov    $0x12,%eax
 3a4:	cd 40                	int    $0x40
 3a6:	c3                   	ret    

000003a7 <fstat>:
 3a7:	b8 08 00 00 00       	mov    $0x8,%eax
 3ac:	cd 40                	int    $0x40
 3ae:	c3                   	ret    

000003af <link>:
 3af:	b8 13 00 00 00       	mov    $0x13,%eax
 3b4:	cd 40                	int    $0x40
 3b6:	c3                   	ret    

000003b7 <mkdir>:
 3b7:	b8 14 00 00 00       	mov    $0x14,%eax
 3bc:	cd 40                	int    $0x40
 3be:	c3                   	ret    

000003bf <chdir>:
 3bf:	b8 09 00 00 00       	mov    $0x9,%eax
 3c4:	cd 40                	int    $0x40
 3c6:	c3                   	ret    

000003c7 <dup>:
 3c7:	b8 0a 00 00 00       	mov    $0xa,%eax
 3cc:	cd 40                	int    $0x40
 3ce:	c3                   	ret    

000003cf <getpid>:
 3cf:	b8 0b 00 00 00       	mov    $0xb,%eax
 3d4:	cd 40                	int    $0x40
 3d6:	c3                   	ret    

000003d7 <sbrk>:
 3d7:	b8 0c 00 00 00       	mov    $0xc,%eax
 3dc:	cd 40                	int    $0x40
 3de:	c3                   	ret    

000003df <sleep>:
 3df:	b8 0d 00 00 00       	mov    $0xd,%eax
 3e4:	cd 40                	int    $0x40
 3e6:	c3                   	ret    

000003e7 <uptime>:
 3e7:	b8 0e 00 00 00       	mov    $0xe,%eax
 3ec:	cd 40                	int    $0x40
 3ee:	c3                   	ret    

000003ef <getprocnum>:
 3ef:	b8 16 00 00 00       	mov    $0x16,%eax
 3f4:	cd 40                	int    $0x40
 3f6:	c3                   	ret    

000003f7 <mempagenum>:
 3f7:	b8 17 00 00 00       	mov    $0x17,%eax
 3fc:	cd 40                	int    $0x40
 3fe:	c3                   	ret    

000003ff <syscallnum>:
 3ff:	b8 18 00 00 00       	mov    $0x18,%eax
 404:	cd 40                	int    $0x40
 406:	c3                   	ret    

00000407 <settickets>:
 407:	b8 19 00 00 00       	mov    $0x19,%eax
 40c:	cd 40                	int    $0x40
 40e:	c3                   	ret    

0000040f <getsheltime>:
 40f:	b8 1a 00 00 00       	mov    $0x1a,%eax
 414:	cd 40                	int    $0x40
 416:	c3                   	ret    

00000417 <setstride>:
 417:	b8 1b 00 00 00       	mov    $0x1b,%eax
 41c:	cd 40                	int    $0x40
 41e:	c3                   	ret    

0000041f <setpass>:
 41f:	b8 1c 00 00 00       	mov    $0x1c,%eax
 424:	cd 40                	int    $0x40
 426:	c3                   	ret    

00000427 <join>:
 427:	b8 1d 00 00 00       	mov    $0x1d,%eax
 42c:	cd 40                	int    $0x40
 42e:	c3                   	ret    

0000042f <clone1>:
 42f:	b8 1e 00 00 00       	mov    $0x1e,%eax
 434:	cd 40                	int    $0x40
 436:	c3                   	ret    
 437:	90                   	nop

00000438 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 438:	55                   	push   %ebp
 439:	89 e5                	mov    %esp,%ebp
 43b:	57                   	push   %edi
 43c:	56                   	push   %esi
 43d:	53                   	push   %ebx
 43e:	83 ec 3c             	sub    $0x3c,%esp
 441:	89 c7                	mov    %eax,%edi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 443:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 445:	8b 5d 08             	mov    0x8(%ebp),%ebx
 448:	85 db                	test   %ebx,%ebx
 44a:	74 04                	je     450 <printint+0x18>
 44c:	85 d2                	test   %edx,%edx
 44e:	78 5d                	js     4ad <printint+0x75>
  neg = 0;
 450:	31 db                	xor    %ebx,%ebx
  } else {
    x = xx;
  }

  i = 0;
 452:	31 f6                	xor    %esi,%esi
 454:	eb 04                	jmp    45a <printint+0x22>
 456:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 458:	89 d6                	mov    %edx,%esi
 45a:	31 d2                	xor    %edx,%edx
 45c:	f7 f1                	div    %ecx
 45e:	8a 92 18 08 00 00    	mov    0x818(%edx),%dl
 464:	88 54 35 d8          	mov    %dl,-0x28(%ebp,%esi,1)
 468:	8d 56 01             	lea    0x1(%esi),%edx
  }while((x /= base) != 0);
 46b:	85 c0                	test   %eax,%eax
 46d:	75 e9                	jne    458 <printint+0x20>
  if(neg)
 46f:	85 db                	test   %ebx,%ebx
 471:	74 08                	je     47b <printint+0x43>
    buf[i++] = '-';
 473:	c6 44 15 d8 2d       	movb   $0x2d,-0x28(%ebp,%edx,1)
 478:	8d 56 02             	lea    0x2(%esi),%edx

  while(--i >= 0)
 47b:	8d 5a ff             	lea    -0x1(%edx),%ebx
 47e:	8d 75 d7             	lea    -0x29(%ebp),%esi
 481:	8d 76 00             	lea    0x0(%esi),%esi
 484:	8a 44 1d d8          	mov    -0x28(%ebp,%ebx,1),%al
 488:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 48b:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 492:	00 
 493:	89 74 24 04          	mov    %esi,0x4(%esp)
 497:	89 3c 24             	mov    %edi,(%esp)
 49a:	e8 d0 fe ff ff       	call   36f <write>
  while(--i >= 0)
 49f:	4b                   	dec    %ebx
 4a0:	83 fb ff             	cmp    $0xffffffff,%ebx
 4a3:	75 df                	jne    484 <printint+0x4c>
    putc(fd, buf[i]);
}
 4a5:	83 c4 3c             	add    $0x3c,%esp
 4a8:	5b                   	pop    %ebx
 4a9:	5e                   	pop    %esi
 4aa:	5f                   	pop    %edi
 4ab:	5d                   	pop    %ebp
 4ac:	c3                   	ret    
    x = -xx;
 4ad:	f7 d8                	neg    %eax
    neg = 1;
 4af:	bb 01 00 00 00       	mov    $0x1,%ebx
    x = -xx;
 4b4:	eb 9c                	jmp    452 <printint+0x1a>
 4b6:	66 90                	xchg   %ax,%ax

000004b8 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4b8:	55                   	push   %ebp
 4b9:	89 e5                	mov    %esp,%ebp
 4bb:	57                   	push   %edi
 4bc:	56                   	push   %esi
 4bd:	53                   	push   %ebx
 4be:	83 ec 3c             	sub    $0x3c,%esp
 4c1:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4c4:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 4c7:	8a 03                	mov    (%ebx),%al
 4c9:	84 c0                	test   %al,%al
 4cb:	0f 84 bb 00 00 00    	je     58c <printf+0xd4>
printf(int fd, char *fmt, ...)
 4d1:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
 4d2:	8d 55 10             	lea    0x10(%ebp),%edx
 4d5:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  state = 0;
 4d8:	31 ff                	xor    %edi,%edi
 4da:	eb 2f                	jmp    50b <printf+0x53>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 4dc:	83 f9 25             	cmp    $0x25,%ecx
 4df:	0f 84 af 00 00 00    	je     594 <printf+0xdc>
        state = '%';
      } else {
        putc(fd, c);
 4e5:	88 4d e2             	mov    %cl,-0x1e(%ebp)
  write(fd, &c, 1);
 4e8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4ef:	00 
 4f0:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 4f3:	89 44 24 04          	mov    %eax,0x4(%esp)
 4f7:	89 34 24             	mov    %esi,(%esp)
 4fa:	e8 70 fe ff ff       	call   36f <write>
 4ff:	43                   	inc    %ebx
  for(i = 0; fmt[i]; i++){
 500:	8a 43 ff             	mov    -0x1(%ebx),%al
 503:	84 c0                	test   %al,%al
 505:	0f 84 81 00 00 00    	je     58c <printf+0xd4>
    c = fmt[i] & 0xff;
 50b:	0f b6 c8             	movzbl %al,%ecx
    if(state == 0){
 50e:	85 ff                	test   %edi,%edi
 510:	74 ca                	je     4dc <printf+0x24>
      }
    } else if(state == '%'){
 512:	83 ff 25             	cmp    $0x25,%edi
 515:	75 e8                	jne    4ff <printf+0x47>
      if(c == 'd'){
 517:	83 f9 64             	cmp    $0x64,%ecx
 51a:	0f 84 14 01 00 00    	je     634 <printf+0x17c>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 520:	83 f9 78             	cmp    $0x78,%ecx
 523:	74 7b                	je     5a0 <printf+0xe8>
 525:	83 f9 70             	cmp    $0x70,%ecx
 528:	74 76                	je     5a0 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 52a:	83 f9 73             	cmp    $0x73,%ecx
 52d:	0f 84 91 00 00 00    	je     5c4 <printf+0x10c>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 533:	83 f9 63             	cmp    $0x63,%ecx
 536:	0f 84 cc 00 00 00    	je     608 <printf+0x150>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 53c:	83 f9 25             	cmp    $0x25,%ecx
 53f:	0f 84 13 01 00 00    	je     658 <printf+0x1a0>
 545:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
  write(fd, &c, 1);
 549:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 550:	00 
 551:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 554:	89 44 24 04          	mov    %eax,0x4(%esp)
 558:	89 34 24             	mov    %esi,(%esp)
 55b:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 55e:	e8 0c fe ff ff       	call   36f <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 563:	8b 4d d0             	mov    -0x30(%ebp),%ecx
 566:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
 569:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 570:	00 
 571:	8d 55 e7             	lea    -0x19(%ebp),%edx
 574:	89 54 24 04          	mov    %edx,0x4(%esp)
 578:	89 34 24             	mov    %esi,(%esp)
 57b:	e8 ef fd ff ff       	call   36f <write>
      }
      state = 0;
 580:	31 ff                	xor    %edi,%edi
 582:	43                   	inc    %ebx
  for(i = 0; fmt[i]; i++){
 583:	8a 43 ff             	mov    -0x1(%ebx),%al
 586:	84 c0                	test   %al,%al
 588:	75 81                	jne    50b <printf+0x53>
 58a:	66 90                	xchg   %ax,%ax
    }
  }
}
 58c:	83 c4 3c             	add    $0x3c,%esp
 58f:	5b                   	pop    %ebx
 590:	5e                   	pop    %esi
 591:	5f                   	pop    %edi
 592:	5d                   	pop    %ebp
 593:	c3                   	ret    
        state = '%';
 594:	bf 25 00 00 00       	mov    $0x25,%edi
 599:	e9 61 ff ff ff       	jmp    4ff <printf+0x47>
 59e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 5a0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 5a7:	b9 10 00 00 00       	mov    $0x10,%ecx
 5ac:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 5af:	8b 10                	mov    (%eax),%edx
 5b1:	89 f0                	mov    %esi,%eax
 5b3:	e8 80 fe ff ff       	call   438 <printint>
        ap++;
 5b8:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 5bc:	31 ff                	xor    %edi,%edi
        ap++;
 5be:	e9 3c ff ff ff       	jmp    4ff <printf+0x47>
 5c3:	90                   	nop
        s = (char*)*ap;
 5c4:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 5c7:	8b 3a                	mov    (%edx),%edi
        ap++;
 5c9:	83 c2 04             	add    $0x4,%edx
 5cc:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
 5cf:	85 ff                	test   %edi,%edi
 5d1:	0f 84 a3 00 00 00    	je     67a <printf+0x1c2>
        while(*s != 0){
 5d7:	8a 07                	mov    (%edi),%al
 5d9:	84 c0                	test   %al,%al
 5db:	74 24                	je     601 <printf+0x149>
 5dd:	8d 76 00             	lea    0x0(%esi),%esi
 5e0:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 5e3:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5ea:	00 
 5eb:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 5ee:	89 44 24 04          	mov    %eax,0x4(%esp)
 5f2:	89 34 24             	mov    %esi,(%esp)
 5f5:	e8 75 fd ff ff       	call   36f <write>
          s++;
 5fa:	47                   	inc    %edi
        while(*s != 0){
 5fb:	8a 07                	mov    (%edi),%al
 5fd:	84 c0                	test   %al,%al
 5ff:	75 df                	jne    5e0 <printf+0x128>
      state = 0;
 601:	31 ff                	xor    %edi,%edi
 603:	e9 f7 fe ff ff       	jmp    4ff <printf+0x47>
        putc(fd, *ap);
 608:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 60b:	8b 02                	mov    (%edx),%eax
 60d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 610:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 617:	00 
 618:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 61b:	89 44 24 04          	mov    %eax,0x4(%esp)
 61f:	89 34 24             	mov    %esi,(%esp)
 622:	e8 48 fd ff ff       	call   36f <write>
        ap++;
 627:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 62b:	31 ff                	xor    %edi,%edi
 62d:	e9 cd fe ff ff       	jmp    4ff <printf+0x47>
 632:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 634:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 63b:	b1 0a                	mov    $0xa,%cl
 63d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 640:	8b 10                	mov    (%eax),%edx
 642:	89 f0                	mov    %esi,%eax
 644:	e8 ef fd ff ff       	call   438 <printint>
        ap++;
 649:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 64d:	66 31 ff             	xor    %di,%di
 650:	e9 aa fe ff ff       	jmp    4ff <printf+0x47>
 655:	8d 76 00             	lea    0x0(%esi),%esi
 658:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
  write(fd, &c, 1);
 65c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 663:	00 
 664:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 667:	89 44 24 04          	mov    %eax,0x4(%esp)
 66b:	89 34 24             	mov    %esi,(%esp)
 66e:	e8 fc fc ff ff       	call   36f <write>
      state = 0;
 673:	31 ff                	xor    %edi,%edi
 675:	e9 85 fe ff ff       	jmp    4ff <printf+0x47>
          s = "(null)";
 67a:	bf 11 08 00 00       	mov    $0x811,%edi
 67f:	e9 53 ff ff ff       	jmp    5d7 <printf+0x11f>

00000684 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 684:	55                   	push   %ebp
 685:	89 e5                	mov    %esp,%ebp
 687:	57                   	push   %edi
 688:	56                   	push   %esi
 689:	53                   	push   %ebx
 68a:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 68d:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 690:	a1 e0 0a 00 00       	mov    0xae0,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 695:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 697:	39 d0                	cmp    %edx,%eax
 699:	72 11                	jb     6ac <free+0x28>
 69b:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 69c:	39 c8                	cmp    %ecx,%eax
 69e:	72 04                	jb     6a4 <free+0x20>
 6a0:	39 ca                	cmp    %ecx,%edx
 6a2:	72 10                	jb     6b4 <free+0x30>
 6a4:	89 c8                	mov    %ecx,%eax
 6a6:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a8:	39 d0                	cmp    %edx,%eax
 6aa:	73 f0                	jae    69c <free+0x18>
 6ac:	39 ca                	cmp    %ecx,%edx
 6ae:	72 04                	jb     6b4 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6b0:	39 c8                	cmp    %ecx,%eax
 6b2:	72 f0                	jb     6a4 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6b4:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6b7:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 6ba:	39 cf                	cmp    %ecx,%edi
 6bc:	74 1a                	je     6d8 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6be:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6c1:	8b 48 04             	mov    0x4(%eax),%ecx
 6c4:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 6c7:	39 f2                	cmp    %esi,%edx
 6c9:	74 24                	je     6ef <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6cb:	89 10                	mov    %edx,(%eax)
  freep = p;
 6cd:	a3 e0 0a 00 00       	mov    %eax,0xae0
}
 6d2:	5b                   	pop    %ebx
 6d3:	5e                   	pop    %esi
 6d4:	5f                   	pop    %edi
 6d5:	5d                   	pop    %ebp
 6d6:	c3                   	ret    
 6d7:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 6d8:	03 71 04             	add    0x4(%ecx),%esi
 6db:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6de:	8b 08                	mov    (%eax),%ecx
 6e0:	8b 09                	mov    (%ecx),%ecx
 6e2:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6e5:	8b 48 04             	mov    0x4(%eax),%ecx
 6e8:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 6eb:	39 f2                	cmp    %esi,%edx
 6ed:	75 dc                	jne    6cb <free+0x47>
    p->s.size += bp->s.size;
 6ef:	03 4b fc             	add    -0x4(%ebx),%ecx
 6f2:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6f5:	8b 53 f8             	mov    -0x8(%ebx),%edx
 6f8:	89 10                	mov    %edx,(%eax)
  freep = p;
 6fa:	a3 e0 0a 00 00       	mov    %eax,0xae0
}
 6ff:	5b                   	pop    %ebx
 700:	5e                   	pop    %esi
 701:	5f                   	pop    %edi
 702:	5d                   	pop    %ebp
 703:	c3                   	ret    

00000704 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 704:	55                   	push   %ebp
 705:	89 e5                	mov    %esp,%ebp
 707:	57                   	push   %edi
 708:	56                   	push   %esi
 709:	53                   	push   %ebx
 70a:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 70d:	8b 75 08             	mov    0x8(%ebp),%esi
 710:	83 c6 07             	add    $0x7,%esi
 713:	c1 ee 03             	shr    $0x3,%esi
 716:	46                   	inc    %esi
  if((prevp = freep) == 0){
 717:	8b 15 e0 0a 00 00    	mov    0xae0,%edx
 71d:	85 d2                	test   %edx,%edx
 71f:	0f 84 8d 00 00 00    	je     7b2 <malloc+0xae>
 725:	8b 02                	mov    (%edx),%eax
 727:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 72a:	39 ce                	cmp    %ecx,%esi
 72c:	76 52                	jbe    780 <malloc+0x7c>
 72e:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 735:	eb 0a                	jmp    741 <malloc+0x3d>
 737:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 738:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 73a:	8b 48 04             	mov    0x4(%eax),%ecx
 73d:	39 ce                	cmp    %ecx,%esi
 73f:	76 3f                	jbe    780 <malloc+0x7c>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 741:	89 c2                	mov    %eax,%edx
 743:	3b 05 e0 0a 00 00    	cmp    0xae0,%eax
 749:	75 ed                	jne    738 <malloc+0x34>
  if(nu < 4096)
 74b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 751:	76 4d                	jbe    7a0 <malloc+0x9c>
 753:	89 d8                	mov    %ebx,%eax
 755:	89 f7                	mov    %esi,%edi
  p = sbrk(nu * sizeof(Header));
 757:	89 04 24             	mov    %eax,(%esp)
 75a:	e8 78 fc ff ff       	call   3d7 <sbrk>
  if(p == (char*)-1)
 75f:	83 f8 ff             	cmp    $0xffffffff,%eax
 762:	74 18                	je     77c <malloc+0x78>
  hp->s.size = nu;
 764:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 767:	83 c0 08             	add    $0x8,%eax
 76a:	89 04 24             	mov    %eax,(%esp)
 76d:	e8 12 ff ff ff       	call   684 <free>
  return freep;
 772:	8b 15 e0 0a 00 00    	mov    0xae0,%edx
      if((p = morecore(nunits)) == 0)
 778:	85 d2                	test   %edx,%edx
 77a:	75 bc                	jne    738 <malloc+0x34>
        return 0;
 77c:	31 c0                	xor    %eax,%eax
 77e:	eb 18                	jmp    798 <malloc+0x94>
      if(p->s.size == nunits)
 780:	39 ce                	cmp    %ecx,%esi
 782:	74 28                	je     7ac <malloc+0xa8>
        p->s.size -= nunits;
 784:	29 f1                	sub    %esi,%ecx
 786:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 789:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 78c:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 78f:	89 15 e0 0a 00 00    	mov    %edx,0xae0
      return (void*)(p + 1);
 795:	83 c0 08             	add    $0x8,%eax
  }
}
 798:	83 c4 1c             	add    $0x1c,%esp
 79b:	5b                   	pop    %ebx
 79c:	5e                   	pop    %esi
 79d:	5f                   	pop    %edi
 79e:	5d                   	pop    %ebp
 79f:	c3                   	ret    
  if(nu < 4096)
 7a0:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 7a5:	bf 00 10 00 00       	mov    $0x1000,%edi
 7aa:	eb ab                	jmp    757 <malloc+0x53>
        prevp->s.ptr = p->s.ptr;
 7ac:	8b 08                	mov    (%eax),%ecx
 7ae:	89 0a                	mov    %ecx,(%edx)
 7b0:	eb dd                	jmp    78f <malloc+0x8b>
    base.s.ptr = freep = prevp = &base;
 7b2:	c7 05 e0 0a 00 00 e4 	movl   $0xae4,0xae0
 7b9:	0a 00 00 
 7bc:	c7 05 e4 0a 00 00 e4 	movl   $0xae4,0xae4
 7c3:	0a 00 00 
    base.s.size = 0;
 7c6:	c7 05 e8 0a 00 00 00 	movl   $0x0,0xae8
 7cd:	00 00 00 
 7d0:	b8 e4 0a 00 00       	mov    $0xae4,%eax
 7d5:	e9 54 ff ff ff       	jmp    72e <malloc+0x2a>
