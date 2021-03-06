
_grep：     文件格式 elf32-i386


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
   c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  int fd, i;
  char *pattern;

  if(argc <= 1){
   f:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  13:	0f 8e 87 00 00 00    	jle    a0 <main+0xa0>
    printf(2, "usage: grep pattern [file ...]\n");
    exit();
  }
  pattern = argv[1];
  19:	8b 7b 04             	mov    0x4(%ebx),%edi

  if(argc <= 2){
  1c:	83 7d 08 02          	cmpl   $0x2,0x8(%ebp)
  20:	74 69                	je     8b <main+0x8b>
main(int argc, char *argv[])
  22:	83 c3 08             	add    $0x8,%ebx
  25:	be 02 00 00 00       	mov    $0x2,%esi
  2a:	66 90                	xchg   %ax,%ax
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  2c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  33:	00 
  34:	8b 03                	mov    (%ebx),%eax
  36:	89 04 24             	mov    %eax,(%esp)
  39:	e8 9d 04 00 00       	call   4db <open>
  3e:	85 c0                	test   %eax,%eax
  40:	78 2a                	js     6c <main+0x6c>
      printf(1, "grep: cannot open %s\n", argv[i]);
      exit();
    }
    grep(pattern, fd);
  42:	89 44 24 04          	mov    %eax,0x4(%esp)
  46:	89 3c 24             	mov    %edi,(%esp)
  49:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  4d:	e8 8a 01 00 00       	call   1dc <grep>
    close(fd);
  52:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  56:	89 04 24             	mov    %eax,(%esp)
  59:	e8 65 04 00 00       	call   4c3 <close>
  for(i = 2; i < argc; i++){
  5e:	46                   	inc    %esi
  5f:	83 c3 04             	add    $0x4,%ebx
  62:	39 75 08             	cmp    %esi,0x8(%ebp)
  65:	7f c5                	jg     2c <main+0x2c>
  }
  exit();
  67:	e8 2f 04 00 00       	call   49b <exit>
      printf(1, "grep: cannot open %s\n", argv[i]);
  6c:	8b 03                	mov    (%ebx),%eax
  6e:	89 44 24 08          	mov    %eax,0x8(%esp)
  72:	c7 44 24 04 48 09 00 	movl   $0x948,0x4(%esp)
  79:	00 
  7a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  81:	e8 7e 05 00 00       	call   604 <printf>
      exit();
  86:	e8 10 04 00 00       	call   49b <exit>
    grep(pattern, 0);
  8b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  92:	00 
  93:	89 3c 24             	mov    %edi,(%esp)
  96:	e8 41 01 00 00       	call   1dc <grep>
    exit();
  9b:	e8 fb 03 00 00       	call   49b <exit>
    printf(2, "usage: grep pattern [file ...]\n");
  a0:	c7 44 24 04 28 09 00 	movl   $0x928,0x4(%esp)
  a7:	00 
  a8:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  af:	e8 50 05 00 00       	call   604 <printf>
    exit();
  b4:	e8 e2 03 00 00       	call   49b <exit>
  b9:	66 90                	xchg   %ax,%ax
  bb:	90                   	nop

000000bc <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
  bc:	55                   	push   %ebp
  bd:	89 e5                	mov    %esp,%ebp
  bf:	57                   	push   %edi
  c0:	56                   	push   %esi
  c1:	53                   	push   %ebx
  c2:	83 ec 1c             	sub    $0x1c,%esp
  c5:	8b 75 08             	mov    0x8(%ebp),%esi
  c8:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cb:	8b 5d 10             	mov    0x10(%ebp),%ebx
  ce:	66 90                	xchg   %ax,%ax
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
  d0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  d4:	89 3c 24             	mov    %edi,(%esp)
  d7:	e8 30 00 00 00       	call   10c <matchhere>
  dc:	85 c0                	test   %eax,%eax
  de:	75 1c                	jne    fc <matchstar+0x40>
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  e0:	0f be 03             	movsbl (%ebx),%eax
  e3:	84 c0                	test   %al,%al
  e5:	74 0a                	je     f1 <matchstar+0x35>
  e7:	43                   	inc    %ebx
  e8:	39 f0                	cmp    %esi,%eax
  ea:	74 e4                	je     d0 <matchstar+0x14>
  ec:	83 fe 2e             	cmp    $0x2e,%esi
  ef:	74 df                	je     d0 <matchstar+0x14>
  return 0;
  f1:	31 c0                	xor    %eax,%eax
}
  f3:	83 c4 1c             	add    $0x1c,%esp
  f6:	5b                   	pop    %ebx
  f7:	5e                   	pop    %esi
  f8:	5f                   	pop    %edi
  f9:	5d                   	pop    %ebp
  fa:	c3                   	ret    
  fb:	90                   	nop
      return 1;
  fc:	b8 01 00 00 00       	mov    $0x1,%eax
}
 101:	83 c4 1c             	add    $0x1c,%esp
 104:	5b                   	pop    %ebx
 105:	5e                   	pop    %esi
 106:	5f                   	pop    %edi
 107:	5d                   	pop    %ebp
 108:	c3                   	ret    
 109:	8d 76 00             	lea    0x0(%esi),%esi

0000010c <matchhere>:
{
 10c:	55                   	push   %ebp
 10d:	89 e5                	mov    %esp,%ebp
 10f:	53                   	push   %ebx
 110:	83 ec 14             	sub    $0x14,%esp
 113:	8b 55 08             	mov    0x8(%ebp),%edx
 116:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  if(re[0] == '\0')
 119:	0f be 02             	movsbl (%edx),%eax
 11c:	84 c0                	test   %al,%al
 11e:	75 1b                	jne    13b <matchhere+0x2f>
 120:	eb 3a                	jmp    15c <matchhere+0x50>
 122:	66 90                	xchg   %ax,%ax
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 124:	8a 19                	mov    (%ecx),%bl
 126:	84 db                	test   %bl,%bl
 128:	74 2a                	je     154 <matchhere+0x48>
 12a:	3c 2e                	cmp    $0x2e,%al
 12c:	74 04                	je     132 <matchhere+0x26>
 12e:	38 d8                	cmp    %bl,%al
 130:	75 22                	jne    154 <matchhere+0x48>
    return matchhere(re+1, text+1);
 132:	41                   	inc    %ecx
 133:	42                   	inc    %edx
  if(re[0] == '\0')
 134:	0f be 02             	movsbl (%edx),%eax
 137:	84 c0                	test   %al,%al
 139:	74 21                	je     15c <matchhere+0x50>
  if(re[1] == '*')
 13b:	8a 5a 01             	mov    0x1(%edx),%bl
 13e:	80 fb 2a             	cmp    $0x2a,%bl
 141:	74 25                	je     168 <matchhere+0x5c>
  if(re[0] == '$' && re[1] == '\0')
 143:	3c 24                	cmp    $0x24,%al
 145:	75 dd                	jne    124 <matchhere+0x18>
 147:	84 db                	test   %bl,%bl
 149:	74 36                	je     181 <matchhere+0x75>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 14b:	8a 19                	mov    (%ecx),%bl
 14d:	84 db                	test   %bl,%bl
 14f:	75 dd                	jne    12e <matchhere+0x22>
 151:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
 154:	31 c0                	xor    %eax,%eax
}
 156:	83 c4 14             	add    $0x14,%esp
 159:	5b                   	pop    %ebx
 15a:	5d                   	pop    %ebp
 15b:	c3                   	ret    
    return 1;
 15c:	b8 01 00 00 00       	mov    $0x1,%eax
}
 161:	83 c4 14             	add    $0x14,%esp
 164:	5b                   	pop    %ebx
 165:	5d                   	pop    %ebp
 166:	c3                   	ret    
 167:	90                   	nop
    return matchstar(re[0], re+2, text);
 168:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 16c:	83 c2 02             	add    $0x2,%edx
 16f:	89 54 24 04          	mov    %edx,0x4(%esp)
 173:	89 04 24             	mov    %eax,(%esp)
 176:	e8 41 ff ff ff       	call   bc <matchstar>
}
 17b:	83 c4 14             	add    $0x14,%esp
 17e:	5b                   	pop    %ebx
 17f:	5d                   	pop    %ebp
 180:	c3                   	ret    
    return *text == '\0';
 181:	31 c0                	xor    %eax,%eax
 183:	80 39 00             	cmpb   $0x0,(%ecx)
 186:	0f 94 c0             	sete   %al
 189:	eb cb                	jmp    156 <matchhere+0x4a>
 18b:	90                   	nop

0000018c <match>:
{
 18c:	55                   	push   %ebp
 18d:	89 e5                	mov    %esp,%ebp
 18f:	56                   	push   %esi
 190:	53                   	push   %ebx
 191:	83 ec 10             	sub    $0x10,%esp
 194:	8b 75 08             	mov    0x8(%ebp),%esi
 197:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(re[0] == '^')
 19a:	80 3e 5e             	cmpb   $0x5e,(%esi)
 19d:	74 2d                	je     1cc <match+0x40>
 19f:	90                   	nop
    if(matchhere(re, text))
 1a0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 1a4:	89 34 24             	mov    %esi,(%esp)
 1a7:	e8 60 ff ff ff       	call   10c <matchhere>
 1ac:	85 c0                	test   %eax,%eax
 1ae:	75 10                	jne    1c0 <match+0x34>
  }while(*text++ != '\0');
 1b0:	8a 03                	mov    (%ebx),%al
 1b2:	43                   	inc    %ebx
 1b3:	84 c0                	test   %al,%al
 1b5:	75 e9                	jne    1a0 <match+0x14>
  return 0;
 1b7:	31 c0                	xor    %eax,%eax
}
 1b9:	83 c4 10             	add    $0x10,%esp
 1bc:	5b                   	pop    %ebx
 1bd:	5e                   	pop    %esi
 1be:	5d                   	pop    %ebp
 1bf:	c3                   	ret    
      return 1;
 1c0:	b8 01 00 00 00       	mov    $0x1,%eax
}
 1c5:	83 c4 10             	add    $0x10,%esp
 1c8:	5b                   	pop    %ebx
 1c9:	5e                   	pop    %esi
 1ca:	5d                   	pop    %ebp
 1cb:	c3                   	ret    
    return matchhere(re+1, text);
 1cc:	46                   	inc    %esi
 1cd:	89 75 08             	mov    %esi,0x8(%ebp)
}
 1d0:	83 c4 10             	add    $0x10,%esp
 1d3:	5b                   	pop    %ebx
 1d4:	5e                   	pop    %esi
 1d5:	5d                   	pop    %ebp
    return matchhere(re+1, text);
 1d6:	e9 31 ff ff ff       	jmp    10c <matchhere>
 1db:	90                   	nop

000001dc <grep>:
{
 1dc:	55                   	push   %ebp
 1dd:	89 e5                	mov    %esp,%ebp
 1df:	57                   	push   %edi
 1e0:	56                   	push   %esi
 1e1:	53                   	push   %ebx
 1e2:	83 ec 2c             	sub    $0x2c,%esp
 1e5:	8b 75 08             	mov    0x8(%ebp),%esi
  m = 0;
 1e8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 1ef:	90                   	nop
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 1f0:	b8 ff 03 00 00       	mov    $0x3ff,%eax
 1f5:	2b 45 e4             	sub    -0x1c(%ebp),%eax
 1f8:	89 44 24 08          	mov    %eax,0x8(%esp)
 1fc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 1ff:	05 00 0d 00 00       	add    $0xd00,%eax
 204:	89 44 24 04          	mov    %eax,0x4(%esp)
 208:	8b 45 0c             	mov    0xc(%ebp),%eax
 20b:	89 04 24             	mov    %eax,(%esp)
 20e:	e8 a0 02 00 00       	call   4b3 <read>
 213:	85 c0                	test   %eax,%eax
 215:	0f 8e ad 00 00 00    	jle    2c8 <grep+0xec>
    m += n;
 21b:	01 45 e4             	add    %eax,-0x1c(%ebp)
    buf[m] = '\0';
 21e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 221:	c6 80 00 0d 00 00 00 	movb   $0x0,0xd00(%eax)
    p = buf;
 228:	bb 00 0d 00 00       	mov    $0xd00,%ebx
 22d:	8d 76 00             	lea    0x0(%esi),%esi
    while((q = strchr(p, '\n')) != 0){
 230:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
 237:	00 
 238:	89 1c 24             	mov    %ebx,(%esp)
 23b:	e8 20 01 00 00       	call   360 <strchr>
 240:	89 c7                	mov    %eax,%edi
 242:	85 c0                	test   %eax,%eax
 244:	74 3a                	je     280 <grep+0xa4>
      *q = 0;
 246:	c6 07 00             	movb   $0x0,(%edi)
      if(match(pattern, p)){
 249:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 24d:	89 34 24             	mov    %esi,(%esp)
 250:	e8 37 ff ff ff       	call   18c <match>
 255:	85 c0                	test   %eax,%eax
 257:	75 07                	jne    260 <grep+0x84>
 259:	8d 5f 01             	lea    0x1(%edi),%ebx
 25c:	eb d2                	jmp    230 <grep+0x54>
 25e:	66 90                	xchg   %ax,%ax
        *q = '\n';
 260:	c6 07 0a             	movb   $0xa,(%edi)
        write(1, p, q+1 - p);
 263:	47                   	inc    %edi
 264:	89 f8                	mov    %edi,%eax
 266:	29 d8                	sub    %ebx,%eax
 268:	89 44 24 08          	mov    %eax,0x8(%esp)
 26c:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 270:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 277:	e8 3f 02 00 00       	call   4bb <write>
 27c:	89 fb                	mov    %edi,%ebx
 27e:	eb b0                	jmp    230 <grep+0x54>
    if(p == buf)
 280:	81 fb 00 0d 00 00    	cmp    $0xd00,%ebx
 286:	74 34                	je     2bc <grep+0xe0>
    if(m > 0){
 288:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 28b:	85 c0                	test   %eax,%eax
 28d:	0f 8e 5d ff ff ff    	jle    1f0 <grep+0x14>
      m -= p - buf;
 293:	b8 00 0d 00 00       	mov    $0xd00,%eax
 298:	29 d8                	sub    %ebx,%eax
 29a:	01 45 e4             	add    %eax,-0x1c(%ebp)
      memmove(buf, p, m);
 29d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 2a0:	89 44 24 08          	mov    %eax,0x8(%esp)
 2a4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 2a8:	c7 04 24 00 0d 00 00 	movl   $0xd00,(%esp)
 2af:	e8 bc 01 00 00       	call   470 <memmove>
 2b4:	e9 37 ff ff ff       	jmp    1f0 <grep+0x14>
 2b9:	8d 76 00             	lea    0x0(%esi),%esi
      m = 0;
 2bc:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 2c3:	e9 28 ff ff ff       	jmp    1f0 <grep+0x14>
}
 2c8:	83 c4 2c             	add    $0x2c,%esp
 2cb:	5b                   	pop    %ebx
 2cc:	5e                   	pop    %esi
 2cd:	5f                   	pop    %edi
 2ce:	5d                   	pop    %ebp
 2cf:	c3                   	ret    

000002d0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	53                   	push   %ebx
 2d4:	8b 45 08             	mov    0x8(%ebp),%eax
 2d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2da:	89 c2                	mov    %eax,%edx
 2dc:	8a 19                	mov    (%ecx),%bl
 2de:	88 1a                	mov    %bl,(%edx)
 2e0:	42                   	inc    %edx
 2e1:	41                   	inc    %ecx
 2e2:	84 db                	test   %bl,%bl
 2e4:	75 f6                	jne    2dc <strcpy+0xc>
    ;
  return os;
}
 2e6:	5b                   	pop    %ebx
 2e7:	5d                   	pop    %ebp
 2e8:	c3                   	ret    
 2e9:	8d 76 00             	lea    0x0(%esi),%esi

000002ec <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2ec:	55                   	push   %ebp
 2ed:	89 e5                	mov    %esp,%ebp
 2ef:	56                   	push   %esi
 2f0:	53                   	push   %ebx
 2f1:	8b 55 08             	mov    0x8(%ebp),%edx
 2f4:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 2f7:	0f b6 02             	movzbl (%edx),%eax
 2fa:	0f b6 19             	movzbl (%ecx),%ebx
 2fd:	84 c0                	test   %al,%al
 2ff:	75 14                	jne    315 <strcmp+0x29>
 301:	eb 1d                	jmp    320 <strcmp+0x34>
 303:	90                   	nop
    p++, q++;
 304:	42                   	inc    %edx
 305:	8d 71 01             	lea    0x1(%ecx),%esi
  while(*p && *p == *q)
 308:	0f b6 02             	movzbl (%edx),%eax
 30b:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 30f:	84 c0                	test   %al,%al
 311:	74 0d                	je     320 <strcmp+0x34>
    p++, q++;
 313:	89 f1                	mov    %esi,%ecx
  while(*p && *p == *q)
 315:	38 d8                	cmp    %bl,%al
 317:	74 eb                	je     304 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 319:	29 d8                	sub    %ebx,%eax
}
 31b:	5b                   	pop    %ebx
 31c:	5e                   	pop    %esi
 31d:	5d                   	pop    %ebp
 31e:	c3                   	ret    
 31f:	90                   	nop
  while(*p && *p == *q)
 320:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 322:	29 d8                	sub    %ebx,%eax
}
 324:	5b                   	pop    %ebx
 325:	5e                   	pop    %esi
 326:	5d                   	pop    %ebp
 327:	c3                   	ret    

00000328 <strlen>:

uint
strlen(char *s)
{
 328:	55                   	push   %ebp
 329:	89 e5                	mov    %esp,%ebp
 32b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 32e:	80 39 00             	cmpb   $0x0,(%ecx)
 331:	74 10                	je     343 <strlen+0x1b>
 333:	31 d2                	xor    %edx,%edx
 335:	8d 76 00             	lea    0x0(%esi),%esi
 338:	42                   	inc    %edx
 339:	89 d0                	mov    %edx,%eax
 33b:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 33f:	75 f7                	jne    338 <strlen+0x10>
    ;
  return n;
}
 341:	5d                   	pop    %ebp
 342:	c3                   	ret    
  for(n = 0; s[n]; n++)
 343:	31 c0                	xor    %eax,%eax
}
 345:	5d                   	pop    %ebp
 346:	c3                   	ret    
 347:	90                   	nop

00000348 <memset>:

void*
memset(void *dst, int c, uint n)
{
 348:	55                   	push   %ebp
 349:	89 e5                	mov    %esp,%ebp
 34b:	57                   	push   %edi
 34c:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 34f:	89 d7                	mov    %edx,%edi
 351:	8b 4d 10             	mov    0x10(%ebp),%ecx
 354:	8b 45 0c             	mov    0xc(%ebp),%eax
 357:	fc                   	cld    
 358:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 35a:	89 d0                	mov    %edx,%eax
 35c:	5f                   	pop    %edi
 35d:	5d                   	pop    %ebp
 35e:	c3                   	ret    
 35f:	90                   	nop

00000360 <strchr>:

char*
strchr(const char *s, char c)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	8b 45 08             	mov    0x8(%ebp),%eax
 366:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
 369:	8a 10                	mov    (%eax),%dl
 36b:	84 d2                	test   %dl,%dl
 36d:	75 0c                	jne    37b <strchr+0x1b>
 36f:	eb 13                	jmp    384 <strchr+0x24>
 371:	8d 76 00             	lea    0x0(%esi),%esi
 374:	40                   	inc    %eax
 375:	8a 10                	mov    (%eax),%dl
 377:	84 d2                	test   %dl,%dl
 379:	74 09                	je     384 <strchr+0x24>
    if(*s == c)
 37b:	38 ca                	cmp    %cl,%dl
 37d:	75 f5                	jne    374 <strchr+0x14>
      return (char*)s;
  return 0;
}
 37f:	5d                   	pop    %ebp
 380:	c3                   	ret    
 381:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
 384:	31 c0                	xor    %eax,%eax
}
 386:	5d                   	pop    %ebp
 387:	c3                   	ret    

00000388 <gets>:

char*
gets(char *buf, int max)
{
 388:	55                   	push   %ebp
 389:	89 e5                	mov    %esp,%ebp
 38b:	57                   	push   %edi
 38c:	56                   	push   %esi
 38d:	53                   	push   %ebx
 38e:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 391:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
 393:	8d 7d e7             	lea    -0x19(%ebp),%edi
 396:	66 90                	xchg   %ax,%ax
  for(i=0; i+1 < max; ){
 398:	8d 73 01             	lea    0x1(%ebx),%esi
 39b:	3b 75 0c             	cmp    0xc(%ebp),%esi
 39e:	7d 40                	jge    3e0 <gets+0x58>
    cc = read(0, &c, 1);
 3a0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3a7:	00 
 3a8:	89 7c 24 04          	mov    %edi,0x4(%esp)
 3ac:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 3b3:	e8 fb 00 00 00       	call   4b3 <read>
    if(cc < 1)
 3b8:	85 c0                	test   %eax,%eax
 3ba:	7e 24                	jle    3e0 <gets+0x58>
      break;
    buf[i++] = c;
 3bc:	8a 45 e7             	mov    -0x19(%ebp),%al
 3bf:	8b 55 08             	mov    0x8(%ebp),%edx
 3c2:	88 44 32 ff          	mov    %al,-0x1(%edx,%esi,1)
    if(c == '\n' || c == '\r')
 3c6:	3c 0a                	cmp    $0xa,%al
 3c8:	74 06                	je     3d0 <gets+0x48>
 3ca:	89 f3                	mov    %esi,%ebx
 3cc:	3c 0d                	cmp    $0xd,%al
 3ce:	75 c8                	jne    398 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 3d0:	8b 45 08             	mov    0x8(%ebp),%eax
 3d3:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 3d7:	83 c4 2c             	add    $0x2c,%esp
 3da:	5b                   	pop    %ebx
 3db:	5e                   	pop    %esi
 3dc:	5f                   	pop    %edi
 3dd:	5d                   	pop    %ebp
 3de:	c3                   	ret    
 3df:	90                   	nop
    if(cc < 1)
 3e0:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 3e2:	8b 45 08             	mov    0x8(%ebp),%eax
 3e5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 3e9:	83 c4 2c             	add    $0x2c,%esp
 3ec:	5b                   	pop    %ebx
 3ed:	5e                   	pop    %esi
 3ee:	5f                   	pop    %edi
 3ef:	5d                   	pop    %ebp
 3f0:	c3                   	ret    
 3f1:	8d 76 00             	lea    0x0(%esi),%esi

000003f4 <stat>:

int
stat(char *n, struct stat *st)
{
 3f4:	55                   	push   %ebp
 3f5:	89 e5                	mov    %esp,%ebp
 3f7:	56                   	push   %esi
 3f8:	53                   	push   %ebx
 3f9:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3fc:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 403:	00 
 404:	8b 45 08             	mov    0x8(%ebp),%eax
 407:	89 04 24             	mov    %eax,(%esp)
 40a:	e8 cc 00 00 00       	call   4db <open>
 40f:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 411:	85 c0                	test   %eax,%eax
 413:	78 23                	js     438 <stat+0x44>
    return -1;
  r = fstat(fd, st);
 415:	8b 45 0c             	mov    0xc(%ebp),%eax
 418:	89 44 24 04          	mov    %eax,0x4(%esp)
 41c:	89 1c 24             	mov    %ebx,(%esp)
 41f:	e8 cf 00 00 00       	call   4f3 <fstat>
 424:	89 c6                	mov    %eax,%esi
  close(fd);
 426:	89 1c 24             	mov    %ebx,(%esp)
 429:	e8 95 00 00 00       	call   4c3 <close>
  return r;
}
 42e:	89 f0                	mov    %esi,%eax
 430:	83 c4 10             	add    $0x10,%esp
 433:	5b                   	pop    %ebx
 434:	5e                   	pop    %esi
 435:	5d                   	pop    %ebp
 436:	c3                   	ret    
 437:	90                   	nop
    return -1;
 438:	be ff ff ff ff       	mov    $0xffffffff,%esi
 43d:	eb ef                	jmp    42e <stat+0x3a>
 43f:	90                   	nop

00000440 <atoi>:

int
atoi(const char *s)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	53                   	push   %ebx
 444:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 447:	0f be 11             	movsbl (%ecx),%edx
 44a:	8d 42 d0             	lea    -0x30(%edx),%eax
 44d:	3c 09                	cmp    $0x9,%al
 44f:	b8 00 00 00 00       	mov    $0x0,%eax
 454:	77 15                	ja     46b <atoi+0x2b>
 456:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 458:	8d 04 80             	lea    (%eax,%eax,4),%eax
 45b:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
 45f:	41                   	inc    %ecx
  while('0' <= *s && *s <= '9')
 460:	0f be 11             	movsbl (%ecx),%edx
 463:	8d 5a d0             	lea    -0x30(%edx),%ebx
 466:	80 fb 09             	cmp    $0x9,%bl
 469:	76 ed                	jbe    458 <atoi+0x18>
  return n;
}
 46b:	5b                   	pop    %ebx
 46c:	5d                   	pop    %ebp
 46d:	c3                   	ret    
 46e:	66 90                	xchg   %ax,%ax

00000470 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 470:	55                   	push   %ebp
 471:	89 e5                	mov    %esp,%ebp
 473:	56                   	push   %esi
 474:	53                   	push   %ebx
 475:	8b 45 08             	mov    0x8(%ebp),%eax
 478:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 47b:	8b 75 10             	mov    0x10(%ebp),%esi
memmove(void *vdst, void *vsrc, int n)
 47e:	31 d2                	xor    %edx,%edx
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 480:	85 f6                	test   %esi,%esi
 482:	7e 0b                	jle    48f <memmove+0x1f>
    *dst++ = *src++;
 484:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 487:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 48a:	42                   	inc    %edx
  while(n-- > 0)
 48b:	39 f2                	cmp    %esi,%edx
 48d:	75 f5                	jne    484 <memmove+0x14>
  return vdst;
}
 48f:	5b                   	pop    %ebx
 490:	5e                   	pop    %esi
 491:	5d                   	pop    %ebp
 492:	c3                   	ret    

00000493 <fork>:
 493:	b8 01 00 00 00       	mov    $0x1,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret    

0000049b <exit>:
 49b:	b8 02 00 00 00       	mov    $0x2,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret    

000004a3 <wait>:
 4a3:	b8 03 00 00 00       	mov    $0x3,%eax
 4a8:	cd 40                	int    $0x40
 4aa:	c3                   	ret    

000004ab <pipe>:
 4ab:	b8 04 00 00 00       	mov    $0x4,%eax
 4b0:	cd 40                	int    $0x40
 4b2:	c3                   	ret    

000004b3 <read>:
 4b3:	b8 05 00 00 00       	mov    $0x5,%eax
 4b8:	cd 40                	int    $0x40
 4ba:	c3                   	ret    

000004bb <write>:
 4bb:	b8 10 00 00 00       	mov    $0x10,%eax
 4c0:	cd 40                	int    $0x40
 4c2:	c3                   	ret    

000004c3 <close>:
 4c3:	b8 15 00 00 00       	mov    $0x15,%eax
 4c8:	cd 40                	int    $0x40
 4ca:	c3                   	ret    

000004cb <kill>:
 4cb:	b8 06 00 00 00       	mov    $0x6,%eax
 4d0:	cd 40                	int    $0x40
 4d2:	c3                   	ret    

000004d3 <exec>:
 4d3:	b8 07 00 00 00       	mov    $0x7,%eax
 4d8:	cd 40                	int    $0x40
 4da:	c3                   	ret    

000004db <open>:
 4db:	b8 0f 00 00 00       	mov    $0xf,%eax
 4e0:	cd 40                	int    $0x40
 4e2:	c3                   	ret    

000004e3 <mknod>:
 4e3:	b8 11 00 00 00       	mov    $0x11,%eax
 4e8:	cd 40                	int    $0x40
 4ea:	c3                   	ret    

000004eb <unlink>:
 4eb:	b8 12 00 00 00       	mov    $0x12,%eax
 4f0:	cd 40                	int    $0x40
 4f2:	c3                   	ret    

000004f3 <fstat>:
 4f3:	b8 08 00 00 00       	mov    $0x8,%eax
 4f8:	cd 40                	int    $0x40
 4fa:	c3                   	ret    

000004fb <link>:
 4fb:	b8 13 00 00 00       	mov    $0x13,%eax
 500:	cd 40                	int    $0x40
 502:	c3                   	ret    

00000503 <mkdir>:
 503:	b8 14 00 00 00       	mov    $0x14,%eax
 508:	cd 40                	int    $0x40
 50a:	c3                   	ret    

0000050b <chdir>:
 50b:	b8 09 00 00 00       	mov    $0x9,%eax
 510:	cd 40                	int    $0x40
 512:	c3                   	ret    

00000513 <dup>:
 513:	b8 0a 00 00 00       	mov    $0xa,%eax
 518:	cd 40                	int    $0x40
 51a:	c3                   	ret    

0000051b <getpid>:
 51b:	b8 0b 00 00 00       	mov    $0xb,%eax
 520:	cd 40                	int    $0x40
 522:	c3                   	ret    

00000523 <sbrk>:
 523:	b8 0c 00 00 00       	mov    $0xc,%eax
 528:	cd 40                	int    $0x40
 52a:	c3                   	ret    

0000052b <sleep>:
 52b:	b8 0d 00 00 00       	mov    $0xd,%eax
 530:	cd 40                	int    $0x40
 532:	c3                   	ret    

00000533 <uptime>:
 533:	b8 0e 00 00 00       	mov    $0xe,%eax
 538:	cd 40                	int    $0x40
 53a:	c3                   	ret    

0000053b <getprocnum>:
 53b:	b8 16 00 00 00       	mov    $0x16,%eax
 540:	cd 40                	int    $0x40
 542:	c3                   	ret    

00000543 <mempagenum>:
 543:	b8 17 00 00 00       	mov    $0x17,%eax
 548:	cd 40                	int    $0x40
 54a:	c3                   	ret    

0000054b <syscallnum>:
 54b:	b8 18 00 00 00       	mov    $0x18,%eax
 550:	cd 40                	int    $0x40
 552:	c3                   	ret    

00000553 <settickets>:
 553:	b8 19 00 00 00       	mov    $0x19,%eax
 558:	cd 40                	int    $0x40
 55a:	c3                   	ret    

0000055b <getsheltime>:
 55b:	b8 1a 00 00 00       	mov    $0x1a,%eax
 560:	cd 40                	int    $0x40
 562:	c3                   	ret    

00000563 <setstride>:
 563:	b8 1b 00 00 00       	mov    $0x1b,%eax
 568:	cd 40                	int    $0x40
 56a:	c3                   	ret    

0000056b <setpass>:
 56b:	b8 1c 00 00 00       	mov    $0x1c,%eax
 570:	cd 40                	int    $0x40
 572:	c3                   	ret    

00000573 <join>:
 573:	b8 1d 00 00 00       	mov    $0x1d,%eax
 578:	cd 40                	int    $0x40
 57a:	c3                   	ret    

0000057b <clone1>:
 57b:	b8 1e 00 00 00       	mov    $0x1e,%eax
 580:	cd 40                	int    $0x40
 582:	c3                   	ret    
 583:	90                   	nop

00000584 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 584:	55                   	push   %ebp
 585:	89 e5                	mov    %esp,%ebp
 587:	57                   	push   %edi
 588:	56                   	push   %esi
 589:	53                   	push   %ebx
 58a:	83 ec 3c             	sub    $0x3c,%esp
 58d:	89 c7                	mov    %eax,%edi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 58f:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 591:	8b 5d 08             	mov    0x8(%ebp),%ebx
 594:	85 db                	test   %ebx,%ebx
 596:	74 04                	je     59c <printint+0x18>
 598:	85 d2                	test   %edx,%edx
 59a:	78 5d                	js     5f9 <printint+0x75>
  neg = 0;
 59c:	31 db                	xor    %ebx,%ebx
  } else {
    x = xx;
  }

  i = 0;
 59e:	31 f6                	xor    %esi,%esi
 5a0:	eb 04                	jmp    5a6 <printint+0x22>
 5a2:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 5a4:	89 d6                	mov    %edx,%esi
 5a6:	31 d2                	xor    %edx,%edx
 5a8:	f7 f1                	div    %ecx
 5aa:	8a 92 65 09 00 00    	mov    0x965(%edx),%dl
 5b0:	88 54 35 d8          	mov    %dl,-0x28(%ebp,%esi,1)
 5b4:	8d 56 01             	lea    0x1(%esi),%edx
  }while((x /= base) != 0);
 5b7:	85 c0                	test   %eax,%eax
 5b9:	75 e9                	jne    5a4 <printint+0x20>
  if(neg)
 5bb:	85 db                	test   %ebx,%ebx
 5bd:	74 08                	je     5c7 <printint+0x43>
    buf[i++] = '-';
 5bf:	c6 44 15 d8 2d       	movb   $0x2d,-0x28(%ebp,%edx,1)
 5c4:	8d 56 02             	lea    0x2(%esi),%edx

  while(--i >= 0)
 5c7:	8d 5a ff             	lea    -0x1(%edx),%ebx
 5ca:	8d 75 d7             	lea    -0x29(%ebp),%esi
 5cd:	8d 76 00             	lea    0x0(%esi),%esi
 5d0:	8a 44 1d d8          	mov    -0x28(%ebp,%ebx,1),%al
 5d4:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 5d7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5de:	00 
 5df:	89 74 24 04          	mov    %esi,0x4(%esp)
 5e3:	89 3c 24             	mov    %edi,(%esp)
 5e6:	e8 d0 fe ff ff       	call   4bb <write>
  while(--i >= 0)
 5eb:	4b                   	dec    %ebx
 5ec:	83 fb ff             	cmp    $0xffffffff,%ebx
 5ef:	75 df                	jne    5d0 <printint+0x4c>
    putc(fd, buf[i]);
}
 5f1:	83 c4 3c             	add    $0x3c,%esp
 5f4:	5b                   	pop    %ebx
 5f5:	5e                   	pop    %esi
 5f6:	5f                   	pop    %edi
 5f7:	5d                   	pop    %ebp
 5f8:	c3                   	ret    
    x = -xx;
 5f9:	f7 d8                	neg    %eax
    neg = 1;
 5fb:	bb 01 00 00 00       	mov    $0x1,%ebx
    x = -xx;
 600:	eb 9c                	jmp    59e <printint+0x1a>
 602:	66 90                	xchg   %ax,%ax

00000604 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 604:	55                   	push   %ebp
 605:	89 e5                	mov    %esp,%ebp
 607:	57                   	push   %edi
 608:	56                   	push   %esi
 609:	53                   	push   %ebx
 60a:	83 ec 3c             	sub    $0x3c,%esp
 60d:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 610:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 613:	8a 03                	mov    (%ebx),%al
 615:	84 c0                	test   %al,%al
 617:	0f 84 bb 00 00 00    	je     6d8 <printf+0xd4>
printf(int fd, char *fmt, ...)
 61d:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
 61e:	8d 55 10             	lea    0x10(%ebp),%edx
 621:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  state = 0;
 624:	31 ff                	xor    %edi,%edi
 626:	eb 2f                	jmp    657 <printf+0x53>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 628:	83 f9 25             	cmp    $0x25,%ecx
 62b:	0f 84 af 00 00 00    	je     6e0 <printf+0xdc>
        state = '%';
      } else {
        putc(fd, c);
 631:	88 4d e2             	mov    %cl,-0x1e(%ebp)
  write(fd, &c, 1);
 634:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 63b:	00 
 63c:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 63f:	89 44 24 04          	mov    %eax,0x4(%esp)
 643:	89 34 24             	mov    %esi,(%esp)
 646:	e8 70 fe ff ff       	call   4bb <write>
 64b:	43                   	inc    %ebx
  for(i = 0; fmt[i]; i++){
 64c:	8a 43 ff             	mov    -0x1(%ebx),%al
 64f:	84 c0                	test   %al,%al
 651:	0f 84 81 00 00 00    	je     6d8 <printf+0xd4>
    c = fmt[i] & 0xff;
 657:	0f b6 c8             	movzbl %al,%ecx
    if(state == 0){
 65a:	85 ff                	test   %edi,%edi
 65c:	74 ca                	je     628 <printf+0x24>
      }
    } else if(state == '%'){
 65e:	83 ff 25             	cmp    $0x25,%edi
 661:	75 e8                	jne    64b <printf+0x47>
      if(c == 'd'){
 663:	83 f9 64             	cmp    $0x64,%ecx
 666:	0f 84 14 01 00 00    	je     780 <printf+0x17c>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 66c:	83 f9 78             	cmp    $0x78,%ecx
 66f:	74 7b                	je     6ec <printf+0xe8>
 671:	83 f9 70             	cmp    $0x70,%ecx
 674:	74 76                	je     6ec <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 676:	83 f9 73             	cmp    $0x73,%ecx
 679:	0f 84 91 00 00 00    	je     710 <printf+0x10c>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 67f:	83 f9 63             	cmp    $0x63,%ecx
 682:	0f 84 cc 00 00 00    	je     754 <printf+0x150>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 688:	83 f9 25             	cmp    $0x25,%ecx
 68b:	0f 84 13 01 00 00    	je     7a4 <printf+0x1a0>
 691:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
  write(fd, &c, 1);
 695:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 69c:	00 
 69d:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 6a0:	89 44 24 04          	mov    %eax,0x4(%esp)
 6a4:	89 34 24             	mov    %esi,(%esp)
 6a7:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 6aa:	e8 0c fe ff ff       	call   4bb <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 6af:	8b 4d d0             	mov    -0x30(%ebp),%ecx
 6b2:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
 6b5:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6bc:	00 
 6bd:	8d 55 e7             	lea    -0x19(%ebp),%edx
 6c0:	89 54 24 04          	mov    %edx,0x4(%esp)
 6c4:	89 34 24             	mov    %esi,(%esp)
 6c7:	e8 ef fd ff ff       	call   4bb <write>
      }
      state = 0;
 6cc:	31 ff                	xor    %edi,%edi
 6ce:	43                   	inc    %ebx
  for(i = 0; fmt[i]; i++){
 6cf:	8a 43 ff             	mov    -0x1(%ebx),%al
 6d2:	84 c0                	test   %al,%al
 6d4:	75 81                	jne    657 <printf+0x53>
 6d6:	66 90                	xchg   %ax,%ax
    }
  }
}
 6d8:	83 c4 3c             	add    $0x3c,%esp
 6db:	5b                   	pop    %ebx
 6dc:	5e                   	pop    %esi
 6dd:	5f                   	pop    %edi
 6de:	5d                   	pop    %ebp
 6df:	c3                   	ret    
        state = '%';
 6e0:	bf 25 00 00 00       	mov    $0x25,%edi
 6e5:	e9 61 ff ff ff       	jmp    64b <printf+0x47>
 6ea:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 6ec:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 6f3:	b9 10 00 00 00       	mov    $0x10,%ecx
 6f8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 6fb:	8b 10                	mov    (%eax),%edx
 6fd:	89 f0                	mov    %esi,%eax
 6ff:	e8 80 fe ff ff       	call   584 <printint>
        ap++;
 704:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 708:	31 ff                	xor    %edi,%edi
        ap++;
 70a:	e9 3c ff ff ff       	jmp    64b <printf+0x47>
 70f:	90                   	nop
        s = (char*)*ap;
 710:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 713:	8b 3a                	mov    (%edx),%edi
        ap++;
 715:	83 c2 04             	add    $0x4,%edx
 718:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
 71b:	85 ff                	test   %edi,%edi
 71d:	0f 84 a3 00 00 00    	je     7c6 <printf+0x1c2>
        while(*s != 0){
 723:	8a 07                	mov    (%edi),%al
 725:	84 c0                	test   %al,%al
 727:	74 24                	je     74d <printf+0x149>
 729:	8d 76 00             	lea    0x0(%esi),%esi
 72c:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 72f:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 736:	00 
 737:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 73a:	89 44 24 04          	mov    %eax,0x4(%esp)
 73e:	89 34 24             	mov    %esi,(%esp)
 741:	e8 75 fd ff ff       	call   4bb <write>
          s++;
 746:	47                   	inc    %edi
        while(*s != 0){
 747:	8a 07                	mov    (%edi),%al
 749:	84 c0                	test   %al,%al
 74b:	75 df                	jne    72c <printf+0x128>
      state = 0;
 74d:	31 ff                	xor    %edi,%edi
 74f:	e9 f7 fe ff ff       	jmp    64b <printf+0x47>
        putc(fd, *ap);
 754:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 757:	8b 02                	mov    (%edx),%eax
 759:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 75c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 763:	00 
 764:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 767:	89 44 24 04          	mov    %eax,0x4(%esp)
 76b:	89 34 24             	mov    %esi,(%esp)
 76e:	e8 48 fd ff ff       	call   4bb <write>
        ap++;
 773:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 777:	31 ff                	xor    %edi,%edi
 779:	e9 cd fe ff ff       	jmp    64b <printf+0x47>
 77e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 780:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 787:	b1 0a                	mov    $0xa,%cl
 789:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 78c:	8b 10                	mov    (%eax),%edx
 78e:	89 f0                	mov    %esi,%eax
 790:	e8 ef fd ff ff       	call   584 <printint>
        ap++;
 795:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 799:	66 31 ff             	xor    %di,%di
 79c:	e9 aa fe ff ff       	jmp    64b <printf+0x47>
 7a1:	8d 76 00             	lea    0x0(%esi),%esi
 7a4:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
  write(fd, &c, 1);
 7a8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 7af:	00 
 7b0:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 7b3:	89 44 24 04          	mov    %eax,0x4(%esp)
 7b7:	89 34 24             	mov    %esi,(%esp)
 7ba:	e8 fc fc ff ff       	call   4bb <write>
      state = 0;
 7bf:	31 ff                	xor    %edi,%edi
 7c1:	e9 85 fe ff ff       	jmp    64b <printf+0x47>
          s = "(null)";
 7c6:	bf 5e 09 00 00       	mov    $0x95e,%edi
 7cb:	e9 53 ff ff ff       	jmp    723 <printf+0x11f>

000007d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7d0:	55                   	push   %ebp
 7d1:	89 e5                	mov    %esp,%ebp
 7d3:	57                   	push   %edi
 7d4:	56                   	push   %esi
 7d5:	53                   	push   %ebx
 7d6:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7d9:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7dc:	a1 e0 0c 00 00       	mov    0xce0,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7e1:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7e3:	39 d0                	cmp    %edx,%eax
 7e5:	72 11                	jb     7f8 <free+0x28>
 7e7:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7e8:	39 c8                	cmp    %ecx,%eax
 7ea:	72 04                	jb     7f0 <free+0x20>
 7ec:	39 ca                	cmp    %ecx,%edx
 7ee:	72 10                	jb     800 <free+0x30>
 7f0:	89 c8                	mov    %ecx,%eax
 7f2:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7f4:	39 d0                	cmp    %edx,%eax
 7f6:	73 f0                	jae    7e8 <free+0x18>
 7f8:	39 ca                	cmp    %ecx,%edx
 7fa:	72 04                	jb     800 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7fc:	39 c8                	cmp    %ecx,%eax
 7fe:	72 f0                	jb     7f0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 800:	8b 73 fc             	mov    -0x4(%ebx),%esi
 803:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 806:	39 cf                	cmp    %ecx,%edi
 808:	74 1a                	je     824 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 80a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 80d:	8b 48 04             	mov    0x4(%eax),%ecx
 810:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 813:	39 f2                	cmp    %esi,%edx
 815:	74 24                	je     83b <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 817:	89 10                	mov    %edx,(%eax)
  freep = p;
 819:	a3 e0 0c 00 00       	mov    %eax,0xce0
}
 81e:	5b                   	pop    %ebx
 81f:	5e                   	pop    %esi
 820:	5f                   	pop    %edi
 821:	5d                   	pop    %ebp
 822:	c3                   	ret    
 823:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 824:	03 71 04             	add    0x4(%ecx),%esi
 827:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 82a:	8b 08                	mov    (%eax),%ecx
 82c:	8b 09                	mov    (%ecx),%ecx
 82e:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 831:	8b 48 04             	mov    0x4(%eax),%ecx
 834:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 837:	39 f2                	cmp    %esi,%edx
 839:	75 dc                	jne    817 <free+0x47>
    p->s.size += bp->s.size;
 83b:	03 4b fc             	add    -0x4(%ebx),%ecx
 83e:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 841:	8b 53 f8             	mov    -0x8(%ebx),%edx
 844:	89 10                	mov    %edx,(%eax)
  freep = p;
 846:	a3 e0 0c 00 00       	mov    %eax,0xce0
}
 84b:	5b                   	pop    %ebx
 84c:	5e                   	pop    %esi
 84d:	5f                   	pop    %edi
 84e:	5d                   	pop    %ebp
 84f:	c3                   	ret    

00000850 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 850:	55                   	push   %ebp
 851:	89 e5                	mov    %esp,%ebp
 853:	57                   	push   %edi
 854:	56                   	push   %esi
 855:	53                   	push   %ebx
 856:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 859:	8b 75 08             	mov    0x8(%ebp),%esi
 85c:	83 c6 07             	add    $0x7,%esi
 85f:	c1 ee 03             	shr    $0x3,%esi
 862:	46                   	inc    %esi
  if((prevp = freep) == 0){
 863:	8b 15 e0 0c 00 00    	mov    0xce0,%edx
 869:	85 d2                	test   %edx,%edx
 86b:	0f 84 8d 00 00 00    	je     8fe <malloc+0xae>
 871:	8b 02                	mov    (%edx),%eax
 873:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 876:	39 ce                	cmp    %ecx,%esi
 878:	76 52                	jbe    8cc <malloc+0x7c>
 87a:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 881:	eb 0a                	jmp    88d <malloc+0x3d>
 883:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 884:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 886:	8b 48 04             	mov    0x4(%eax),%ecx
 889:	39 ce                	cmp    %ecx,%esi
 88b:	76 3f                	jbe    8cc <malloc+0x7c>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 88d:	89 c2                	mov    %eax,%edx
 88f:	3b 05 e0 0c 00 00    	cmp    0xce0,%eax
 895:	75 ed                	jne    884 <malloc+0x34>
  if(nu < 4096)
 897:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 89d:	76 4d                	jbe    8ec <malloc+0x9c>
 89f:	89 d8                	mov    %ebx,%eax
 8a1:	89 f7                	mov    %esi,%edi
  p = sbrk(nu * sizeof(Header));
 8a3:	89 04 24             	mov    %eax,(%esp)
 8a6:	e8 78 fc ff ff       	call   523 <sbrk>
  if(p == (char*)-1)
 8ab:	83 f8 ff             	cmp    $0xffffffff,%eax
 8ae:	74 18                	je     8c8 <malloc+0x78>
  hp->s.size = nu;
 8b0:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 8b3:	83 c0 08             	add    $0x8,%eax
 8b6:	89 04 24             	mov    %eax,(%esp)
 8b9:	e8 12 ff ff ff       	call   7d0 <free>
  return freep;
 8be:	8b 15 e0 0c 00 00    	mov    0xce0,%edx
      if((p = morecore(nunits)) == 0)
 8c4:	85 d2                	test   %edx,%edx
 8c6:	75 bc                	jne    884 <malloc+0x34>
        return 0;
 8c8:	31 c0                	xor    %eax,%eax
 8ca:	eb 18                	jmp    8e4 <malloc+0x94>
      if(p->s.size == nunits)
 8cc:	39 ce                	cmp    %ecx,%esi
 8ce:	74 28                	je     8f8 <malloc+0xa8>
        p->s.size -= nunits;
 8d0:	29 f1                	sub    %esi,%ecx
 8d2:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 8d5:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 8d8:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 8db:	89 15 e0 0c 00 00    	mov    %edx,0xce0
      return (void*)(p + 1);
 8e1:	83 c0 08             	add    $0x8,%eax
  }
}
 8e4:	83 c4 1c             	add    $0x1c,%esp
 8e7:	5b                   	pop    %ebx
 8e8:	5e                   	pop    %esi
 8e9:	5f                   	pop    %edi
 8ea:	5d                   	pop    %ebp
 8eb:	c3                   	ret    
  if(nu < 4096)
 8ec:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 8f1:	bf 00 10 00 00       	mov    $0x1000,%edi
 8f6:	eb ab                	jmp    8a3 <malloc+0x53>
        prevp->s.ptr = p->s.ptr;
 8f8:	8b 08                	mov    (%eax),%ecx
 8fa:	89 0a                	mov    %ecx,(%edx)
 8fc:	eb dd                	jmp    8db <malloc+0x8b>
    base.s.ptr = freep = prevp = &base;
 8fe:	c7 05 e0 0c 00 00 e4 	movl   $0xce4,0xce0
 905:	0c 00 00 
 908:	c7 05 e4 0c 00 00 e4 	movl   $0xce4,0xce4
 90f:	0c 00 00 
    base.s.size = 0;
 912:	c7 05 e8 0c 00 00 00 	movl   $0x0,0xce8
 919:	00 00 00 
 91c:	b8 e4 0c 00 00       	mov    $0xce4,%eax
 921:	e9 54 ff ff ff       	jmp    87a <malloc+0x2a>
