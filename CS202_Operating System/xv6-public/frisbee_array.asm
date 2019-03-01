
_frisbee_array：     文件格式 elf32-i386


Disassembly of section .text:

00000000 <main>:
    }

}

int main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
   6:	83 e4 f0             	and    $0xfffffff0,%esp
   9:	83 ec 30             	sub    $0x30,%esp
   c:	8b 75 0c             	mov    0xc(%ebp),%esi
    int i,j, temp = 0;
    int arg = 1;
   f:	c7 44 24 2c 01 00 00 	movl   $0x1,0x2c(%esp)
  16:	00 

    //Get the parameters from the terminal

    for(i=0;i<strlen(argv[1]);i++){
  17:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
  1e:	00 
  1f:	90                   	nop
  20:	8b 46 04             	mov    0x4(%esi),%eax
  23:	89 04 24             	mov    %eax,(%esp)
  26:	e8 25 04 00 00       	call   450 <strlen>
  2b:	39 44 24 1c          	cmp    %eax,0x1c(%esp)
  2f:	73 36                	jae    67 <main+0x67>
        temp = *(argv[1] + i) - '0';
  31:	8b 46 04             	mov    0x4(%esi),%eax
  34:	8b 4c 24 1c          	mov    0x1c(%esp),%ecx
  38:	0f be 14 08          	movsbl (%eax,%ecx,1),%edx
  3c:	8d 7a d0             	lea    -0x30(%edx),%edi
        //printf(1,"%d\n",temp);
        for(j=i;j<strlen(argv[1]) - 1;j++){
  3f:	89 cb                	mov    %ecx,%ebx
  41:	eb 0b                	jmp    4e <main+0x4e>
  43:	90                   	nop
            temp = temp * 10;
  44:	8d 14 bf             	lea    (%edi,%edi,4),%edx
  47:	8d 3c 12             	lea    (%edx,%edx,1),%edi
        for(j=i;j<strlen(argv[1]) - 1;j++){
  4a:	43                   	inc    %ebx
  4b:	8b 46 04             	mov    0x4(%esi),%eax
  4e:	89 04 24             	mov    %eax,(%esp)
  51:	e8 fa 03 00 00       	call   450 <strlen>
  56:	48                   	dec    %eax
  57:	39 c3                	cmp    %eax,%ebx
  59:	72 e9                	jb     44 <main+0x44>
        }
        t = t + temp;
  5b:	01 3d 0c 0e 00 00    	add    %edi,0xe0c
    for(i=0;i<strlen(argv[1]);i++){
  61:	ff 44 24 1c          	incl   0x1c(%esp)
  65:	eb b9                	jmp    20 <main+0x20>
  67:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
  6e:	00 
  6f:	90                   	nop
    }
    for(i=0;i<strlen(argv[2]);i++){
  70:	8b 46 08             	mov    0x8(%esi),%eax
  73:	89 04 24             	mov    %eax,(%esp)
  76:	e8 d5 03 00 00       	call   450 <strlen>
  7b:	39 44 24 1c          	cmp    %eax,0x1c(%esp)
  7f:	73 36                	jae    b7 <main+0xb7>
        temp = *(argv[2] + i) - '0';
  81:	8b 46 08             	mov    0x8(%esi),%eax
  84:	8b 4c 24 1c          	mov    0x1c(%esp),%ecx
  88:	0f be 14 08          	movsbl (%eax,%ecx,1),%edx
  8c:	8d 7a d0             	lea    -0x30(%edx),%edi
        //printf(1,"%d\n",temp);
        for(j=i;j<strlen(argv[2]) - 1;j++){
  8f:	89 cb                	mov    %ecx,%ebx
  91:	eb 0b                	jmp    9e <main+0x9e>
  93:	90                   	nop
            temp = temp * 10;
  94:	8d 14 bf             	lea    (%edi,%edi,4),%edx
  97:	8d 3c 12             	lea    (%edx,%edx,1),%edi
        for(j=i;j<strlen(argv[2]) - 1;j++){
  9a:	43                   	inc    %ebx
  9b:	8b 46 08             	mov    0x8(%esi),%eax
  9e:	89 04 24             	mov    %eax,(%esp)
  a1:	e8 aa 03 00 00       	call   450 <strlen>
  a6:	48                   	dec    %eax
  a7:	39 c3                	cmp    %eax,%ebx
  a9:	72 e9                	jb     94 <main+0x94>
        }
        round = round + temp;
  ab:	01 3d 10 0e 00 00    	add    %edi,0xe10
    for(i=0;i<strlen(argv[2]);i++){
  b1:	ff 44 24 1c          	incl   0x1c(%esp)
  b5:	eb b9                	jmp    70 <main+0x70>
    for(i=0;i<t;i++){
  b7:	8b 0d 0c 0e 00 00    	mov    0xe0c,%ecx
  bd:	85 c9                	test   %ecx,%ecx
  bf:	0f 8e 85 00 00 00    	jle    14a <main+0x14a>
  c5:	ba 44 0f 00 00       	mov    $0xf44,%edx
  ca:	31 c0                	xor    %eax,%eax
        flag[i] = 0;
  cc:	c7 04 85 40 0e 00 00 	movl   $0x0,0xe40(,%eax,4)
  d3:	00 00 00 00 
        fr[i].lock = 0;
  d7:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
    for(i=0;i<t;i++){
  dd:	40                   	inc    %eax
  de:	83 c2 0c             	add    $0xc,%edx
  e1:	39 c8                	cmp    %ecx,%eax
  e3:	75 e7                	jne    cc <main+0xcc>
    countflag = t - 1;
  e5:	48                   	dec    %eax
  e6:	a3 14 0e 00 00       	mov    %eax,0xe14
    fr[0].lock = 1;
  eb:	c7 05 44 0f 00 00 01 	movl   $0x1,0xf44
  f2:	00 00 00 
  f5:	31 db                	xor    %ebx,%ebx
  f7:	8d 74 24 2c          	lea    0x2c(%esp),%esi
  fb:	90                   	nop


    lock_init();
    for(i=0;i<t;i++){

        arg = i+1;
  fc:	43                   	inc    %ebx
  fd:	89 5c 24 2c          	mov    %ebx,0x2c(%esp)
        thread_create(&pass, &arg);
 101:	89 74 24 04          	mov    %esi,0x4(%esp)
 105:	c7 04 24 84 02 00 00 	movl   $0x284,(%esp)
 10c:	e8 57 02 00 00       	call   368 <thread_create>
    for(i=0;i<t;i++){
 111:	39 1d 0c 0e 00 00    	cmp    %ebx,0xe0c
 117:	7f e3                	jg     fc <main+0xfc>
        //printf(1, "%d\n", result);
    }
    void **join_stack = (void**) ((uint)sbrk(0) - 4);
 119:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 120:	e8 26 05 00 00       	call   64b <sbrk>
 125:	8d 70 fc             	lea    -0x4(%eax),%esi
    for(i=0;i<t;i++){
 128:	a1 0c 0e 00 00       	mov    0xe0c,%eax
 12d:	85 c0                	test   %eax,%eax
 12f:	7e 14                	jle    145 <main+0x145>
 131:	31 db                	xor    %ebx,%ebx
 133:	90                   	nop
        join(join_stack);
 134:	89 34 24             	mov    %esi,(%esp)
 137:	e8 5f 05 00 00       	call   69b <join>
    for(i=0;i<t;i++){
 13c:	43                   	inc    %ebx
 13d:	39 1d 0c 0e 00 00    	cmp    %ebx,0xe0c
 143:	7f ef                	jg     134 <main+0x134>
    }




    exit();
 145:	e8 79 04 00 00       	call   5c3 <exit>
    countflag = t - 1;
 14a:	49                   	dec    %ecx
 14b:	89 0d 14 0e 00 00    	mov    %ecx,0xe14
    fr[0].lock = 1;
 151:	c7 05 44 0f 00 00 01 	movl   $0x1,0xf44
 158:	00 00 00 
 15b:	eb bc                	jmp    119 <main+0x119>
 15d:	66 90                	xchg   %ax,%ax
 15f:	90                   	nop

00000160 <lock_init>:
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
    for(i=0;i<t;i++){
 163:	8b 0d 0c 0e 00 00    	mov    0xe0c,%ecx
 169:	85 c9                	test   %ecx,%ecx
 16b:	7e 20                	jle    18d <lock_init+0x2d>
 16d:	ba 44 0f 00 00       	mov    $0xf44,%edx
 172:	31 c0                	xor    %eax,%eax
        flag[i] = 0;
 174:	c7 04 85 40 0e 00 00 	movl   $0x0,0xe40(,%eax,4)
 17b:	00 00 00 00 
        fr[i].lock = 0;
 17f:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
    for(i=0;i<t;i++){
 185:	40                   	inc    %eax
 186:	83 c2 0c             	add    $0xc,%edx
 189:	39 c8                	cmp    %ecx,%eax
 18b:	75 e7                	jne    174 <lock_init+0x14>
    countflag = t - 1;
 18d:	49                   	dec    %ecx
 18e:	89 0d 14 0e 00 00    	mov    %ecx,0xe14
    fr[0].lock = 1;
 194:	c7 05 44 0f 00 00 01 	movl   $0x1,0xf44
 19b:	00 00 00 
}
 19e:	5d                   	pop    %ebp
 19f:	c3                   	ret    

000001a0 <lock_acquire>:
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	53                   	push   %ebx
 1a4:	83 ec 14             	sub    $0x14,%esp
    pid = getpid();
 1a7:	e8 97 04 00 00       	call   643 <getpid>
    for(i=0;i<t;i++){
 1ac:	8b 1d 0c 0e 00 00    	mov    0xe0c,%ebx
 1b2:	85 db                	test   %ebx,%ebx
 1b4:	7e 1f                	jle    1d5 <lock_acquire+0x35>
        if(fr[i].pid == pid){
 1b6:	39 05 40 0f 00 00    	cmp    %eax,0xf40
 1bc:	74 1d                	je     1db <lock_acquire+0x3b>
 1be:	b9 4c 0f 00 00       	mov    $0xf4c,%ecx
    for(i=0;i<t;i++){
 1c3:	31 d2                	xor    %edx,%edx
 1c5:	eb 09                	jmp    1d0 <lock_acquire+0x30>
 1c7:	90                   	nop
 1c8:	83 c1 0c             	add    $0xc,%ecx
        if(fr[i].pid == pid){
 1cb:	39 41 f4             	cmp    %eax,-0xc(%ecx)
 1ce:	74 10                	je     1e0 <lock_acquire+0x40>
    for(i=0;i<t;i++){
 1d0:	42                   	inc    %edx
 1d1:	39 da                	cmp    %ebx,%edx
 1d3:	75 f3                	jne    1c8 <lock_acquire+0x28>
}
 1d5:	83 c4 14             	add    $0x14,%esp
 1d8:	5b                   	pop    %ebx
 1d9:	5d                   	pop    %ebp
 1da:	c3                   	ret    
    for(i=0;i<t;i++){
 1db:	31 d2                	xor    %edx,%edx
 1dd:	8d 76 00             	lea    0x0(%esi),%esi
            while(!(fr[i].lock)){
 1e0:	8d 1c 52             	lea    (%edx,%edx,2),%ebx
 1e3:	c1 e3 02             	shl    $0x2,%ebx
 1e6:	8b 93 44 0f 00 00    	mov    0xf44(%ebx),%edx
 1ec:	85 d2                	test   %edx,%edx
 1ee:	75 e5                	jne    1d5 <lock_acquire+0x35>
                sleep(5);
 1f0:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 1f7:	e8 57 04 00 00       	call   653 <sleep>
            while(!(fr[i].lock)){
 1fc:	8b 83 44 0f 00 00    	mov    0xf44(%ebx),%eax
 202:	85 c0                	test   %eax,%eax
 204:	74 ea                	je     1f0 <lock_acquire+0x50>
}
 206:	83 c4 14             	add    $0x14,%esp
 209:	5b                   	pop    %ebx
 20a:	5d                   	pop    %ebp
 20b:	c3                   	ret    

0000020c <lock_release>:
{
 20c:	55                   	push   %ebp
 20d:	89 e5                	mov    %esp,%ebp
 20f:	53                   	push   %ebx
 210:	83 ec 14             	sub    $0x14,%esp
    pid = getpid();
 213:	e8 2b 04 00 00       	call   643 <getpid>
    for(i=0;i<t;i++){
 218:	8b 1d 0c 0e 00 00    	mov    0xe0c,%ebx
 21e:	85 db                	test   %ebx,%ebx
 220:	7e 1f                	jle    241 <lock_release+0x35>
        if(fr[i].pid == pid){
 222:	39 05 40 0f 00 00    	cmp    %eax,0xf40
 228:	74 4e                	je     278 <lock_release+0x6c>
 22a:	ba 4c 0f 00 00       	mov    $0xf4c,%edx
    for(i=0;i<t;i++){
 22f:	31 c9                	xor    %ecx,%ecx
 231:	eb 09                	jmp    23c <lock_release+0x30>
 233:	90                   	nop
 234:	83 c2 0c             	add    $0xc,%edx
        if(fr[i].pid == pid){
 237:	39 42 f4             	cmp    %eax,-0xc(%edx)
 23a:	74 18                	je     254 <lock_release+0x48>
    for(i=0;i<t;i++){
 23c:	41                   	inc    %ecx
 23d:	39 d9                	cmp    %ebx,%ecx
 23f:	75 f3                	jne    234 <lock_release+0x28>
    sleep(100);
 241:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
 248:	e8 06 04 00 00       	call   653 <sleep>
}
 24d:	83 c4 14             	add    $0x14,%esp
 250:	5b                   	pop    %ebx
 251:	5d                   	pop    %ebp
 252:	c3                   	ret    
 253:	90                   	nop
 254:	8d 41 01             	lea    0x1(%ecx),%eax
            fr[i].lock = 0;
 257:	8d 14 49             	lea    (%ecx,%ecx,2),%edx
 25a:	c7 04 95 44 0f 00 00 	movl   $0x0,0xf44(,%edx,4)
 261:	00 00 00 00 
            j = (i+1)%t;
 265:	99                   	cltd   
 266:	f7 fb                	idiv   %ebx
            fr[j].lock = 1;
 268:	8d 04 52             	lea    (%edx,%edx,2),%eax
 26b:	c7 04 85 44 0f 00 00 	movl   $0x1,0xf44(,%eax,4)
 272:	01 00 00 00 
            break;
 276:	eb c9                	jmp    241 <lock_release+0x35>
        if(fr[i].pid == pid){
 278:	b8 01 00 00 00       	mov    $0x1,%eax
    for(i=0;i<t;i++){
 27d:	31 c9                	xor    %ecx,%ecx
 27f:	eb d6                	jmp    257 <lock_release+0x4b>
 281:	8d 76 00             	lea    0x0(%esi),%esi

00000284 <pass>:
pass(void *arg){
 284:	55                   	push   %ebp
 285:	89 e5                	mov    %esp,%ebp
 287:	56                   	push   %esi
 288:	53                   	push   %ebx
 289:	83 ec 20             	sub    $0x20,%esp
    sleep(100);
 28c:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
 293:	e8 bb 03 00 00       	call   653 <sleep>
    for(; x < round; )
 298:	a1 10 0e 00 00       	mov    0xe10,%eax
 29d:	39 05 08 0e 00 00    	cmp    %eax,0xe08
 2a3:	7d 56                	jge    2fb <pass+0x77>
 2a5:	8d 76 00             	lea    0x0(%esi),%esi
        lock_acquire();
 2a8:	e8 f3 fe ff ff       	call   1a0 <lock_acquire>
        id = getpid();
 2ad:	e8 91 03 00 00       	call   643 <getpid>
        if(x==round){
 2b2:	8b 15 10 0e 00 00    	mov    0xe10,%edx
 2b8:	39 15 08 0e 00 00    	cmp    %edx,0xe08
 2be:	74 3b                	je     2fb <pass+0x77>
        for(i = 0;i<t;i++){
 2c0:	8b 1d 0c 0e 00 00    	mov    0xe0c,%ebx
 2c6:	85 db                	test   %ebx,%ebx
 2c8:	7e 1f                	jle    2e9 <pass+0x65>
            if(fr[i].pid == id){
 2ca:	39 05 40 0f 00 00    	cmp    %eax,0xf40
 2d0:	74 30                	je     302 <pass+0x7e>
 2d2:	ba 4c 0f 00 00       	mov    $0xf4c,%edx
 2d7:	31 c9                	xor    %ecx,%ecx
 2d9:	eb 09                	jmp    2e4 <pass+0x60>
 2db:	90                   	nop
 2dc:	83 c2 0c             	add    $0xc,%edx
 2df:	39 42 f4             	cmp    %eax,-0xc(%edx)
 2e2:	74 20                	je     304 <pass+0x80>
        for(i = 0;i<t;i++){
 2e4:	41                   	inc    %ecx
 2e5:	39 d9                	cmp    %ebx,%ecx
 2e7:	75 f3                	jne    2dc <pass+0x58>
        lock_release();
 2e9:	e8 1e ff ff ff       	call   20c <lock_release>
    for(; x < round; )
 2ee:	a1 10 0e 00 00       	mov    0xe10,%eax
 2f3:	39 05 08 0e 00 00    	cmp    %eax,0xe08
 2f9:	7c ad                	jl     2a8 <pass+0x24>
}
 2fb:	83 c4 20             	add    $0x20,%esp
 2fe:	5b                   	pop    %ebx
 2ff:	5e                   	pop    %esi
 300:	5d                   	pop    %ebp
 301:	c3                   	ret    
            if(fr[i].pid == id){
 302:	31 c9                	xor    %ecx,%ecx
                if(fr[i].hasFrisbee == 0){
 304:	8d 04 49             	lea    (%ecx,%ecx,2),%eax
 307:	8d 34 85 40 0f 00 00 	lea    0xf40(,%eax,4),%esi
 30e:	8b 46 08             	mov    0x8(%esi),%eax
 311:	85 c0                	test   %eax,%eax
 313:	74 d4                	je     2e9 <pass+0x65>
                    j = (i + 1) % t;
 315:	8d 41 01             	lea    0x1(%ecx),%eax
 318:	99                   	cltd   
 319:	f7 fb                	idiv   %ebx
                    fr[j].hasFrisbee = 1;
 31b:	8d 04 52             	lea    (%edx,%edx,2),%eax
 31e:	c7 04 85 48 0f 00 00 	movl   $0x1,0xf48(,%eax,4)
 325:	01 00 00 00 
                    fr[i].hasFrisbee = 0;
 329:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
                    printf(1, "Pass number no: %d, Thread %d is passing the token to thread %d\n", number++,i,j);
 330:	a1 04 0e 00 00       	mov    0xe04,%eax
 335:	8d 58 01             	lea    0x1(%eax),%ebx
 338:	89 1d 04 0e 00 00    	mov    %ebx,0xe04
 33e:	89 54 24 10          	mov    %edx,0x10(%esp)
 342:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
 346:	89 44 24 08          	mov    %eax,0x8(%esp)
 34a:	c7 44 24 04 50 0a 00 	movl   $0xa50,0x4(%esp)
 351:	00 
 352:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 359:	e8 ce 03 00 00       	call   72c <printf>
                    x++;
 35e:	ff 05 08 0e 00 00    	incl   0xe08
                    break;
 364:	eb 83                	jmp    2e9 <pass+0x65>
 366:	66 90                	xchg   %ax,%ax

00000368 <thread_create>:
thread_create(void (*start_routine)(void*), void *arg){
 368:	55                   	push   %ebp
 369:	89 e5                	mov    %esp,%ebp
 36b:	53                   	push   %ebx
 36c:	83 ec 14             	sub    $0x14,%esp
    void *stack = malloc(PGSIZE);
 36f:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 376:	e8 fd 05 00 00       	call   978 <malloc>
    for(i = 0;i<t;i++){
 37b:	8b 0d 0c 0e 00 00    	mov    0xe0c,%ecx
 381:	85 c9                	test   %ecx,%ecx
 383:	7e 23                	jle    3a8 <thread_create+0x40>
 385:	ba 48 0f 00 00       	mov    $0xf48,%edx
thread_create(void (*start_routine)(void*), void *arg){
 38a:	8d 0c 49             	lea    (%ecx,%ecx,2),%ecx
 38d:	8d 0c 8d 48 0f 00 00 	lea    0xf48(,%ecx,4),%ecx
        fr[i].hasFrisbee = 0;
 394:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
        fr[i].pid = 0;
 39a:	c7 42 f8 00 00 00 00 	movl   $0x0,-0x8(%edx)
 3a1:	83 c2 0c             	add    $0xc,%edx
    for(i = 0;i<t;i++){
 3a4:	39 ca                	cmp    %ecx,%edx
 3a6:	75 ec                	jne    394 <thread_create+0x2c>
    fr[0].hasFrisbee = 1;
 3a8:	c7 05 48 0f 00 00 01 	movl   $0x1,0xf48
 3af:	00 00 00 
    rc = clone1(stack, PGSIZE);
 3b2:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
 3b9:	00 
 3ba:	89 04 24             	mov    %eax,(%esp)
 3bd:	e8 e1 02 00 00       	call   6a3 <clone1>
    if(rc == 0)
 3c2:	85 c0                	test   %eax,%eax
 3c4:	74 06                	je     3cc <thread_create+0x64>
}
 3c6:	83 c4 14             	add    $0x14,%esp
 3c9:	5b                   	pop    %ebx
 3ca:	5d                   	pop    %ebp
 3cb:	c3                   	ret    
        fr[itt].pid = getpid();
 3cc:	8b 1d 00 0e 00 00    	mov    0xe00,%ebx
 3d2:	e8 6c 02 00 00       	call   643 <getpid>
 3d7:	8d 14 5b             	lea    (%ebx,%ebx,2),%edx
 3da:	89 04 95 40 0f 00 00 	mov    %eax,0xf40(,%edx,4)
        itt++;
 3e1:	ff 05 00 0e 00 00    	incl   0xe00
        start_routine(arg);
 3e7:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ea:	89 04 24             	mov    %eax,(%esp)
 3ed:	ff 55 08             	call   *0x8(%ebp)
        exit();
 3f0:	e8 ce 01 00 00       	call   5c3 <exit>
 3f5:	66 90                	xchg   %ax,%ax
 3f7:	90                   	nop

000003f8 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 3f8:	55                   	push   %ebp
 3f9:	89 e5                	mov    %esp,%ebp
 3fb:	53                   	push   %ebx
 3fc:	8b 45 08             	mov    0x8(%ebp),%eax
 3ff:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 402:	89 c2                	mov    %eax,%edx
 404:	8a 19                	mov    (%ecx),%bl
 406:	88 1a                	mov    %bl,(%edx)
 408:	42                   	inc    %edx
 409:	41                   	inc    %ecx
 40a:	84 db                	test   %bl,%bl
 40c:	75 f6                	jne    404 <strcpy+0xc>
    ;
  return os;
}
 40e:	5b                   	pop    %ebx
 40f:	5d                   	pop    %ebp
 410:	c3                   	ret    
 411:	8d 76 00             	lea    0x0(%esi),%esi

00000414 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 414:	55                   	push   %ebp
 415:	89 e5                	mov    %esp,%ebp
 417:	56                   	push   %esi
 418:	53                   	push   %ebx
 419:	8b 55 08             	mov    0x8(%ebp),%edx
 41c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 41f:	0f b6 02             	movzbl (%edx),%eax
 422:	0f b6 19             	movzbl (%ecx),%ebx
 425:	84 c0                	test   %al,%al
 427:	75 14                	jne    43d <strcmp+0x29>
 429:	eb 1d                	jmp    448 <strcmp+0x34>
 42b:	90                   	nop
    p++, q++;
 42c:	42                   	inc    %edx
 42d:	8d 71 01             	lea    0x1(%ecx),%esi
  while(*p && *p == *q)
 430:	0f b6 02             	movzbl (%edx),%eax
 433:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 437:	84 c0                	test   %al,%al
 439:	74 0d                	je     448 <strcmp+0x34>
    p++, q++;
 43b:	89 f1                	mov    %esi,%ecx
  while(*p && *p == *q)
 43d:	38 d8                	cmp    %bl,%al
 43f:	74 eb                	je     42c <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 441:	29 d8                	sub    %ebx,%eax
}
 443:	5b                   	pop    %ebx
 444:	5e                   	pop    %esi
 445:	5d                   	pop    %ebp
 446:	c3                   	ret    
 447:	90                   	nop
  while(*p && *p == *q)
 448:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 44a:	29 d8                	sub    %ebx,%eax
}
 44c:	5b                   	pop    %ebx
 44d:	5e                   	pop    %esi
 44e:	5d                   	pop    %ebp
 44f:	c3                   	ret    

00000450 <strlen>:

uint
strlen(char *s)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 456:	80 39 00             	cmpb   $0x0,(%ecx)
 459:	74 10                	je     46b <strlen+0x1b>
 45b:	31 d2                	xor    %edx,%edx
 45d:	8d 76 00             	lea    0x0(%esi),%esi
 460:	42                   	inc    %edx
 461:	89 d0                	mov    %edx,%eax
 463:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 467:	75 f7                	jne    460 <strlen+0x10>
    ;
  return n;
}
 469:	5d                   	pop    %ebp
 46a:	c3                   	ret    
  for(n = 0; s[n]; n++)
 46b:	31 c0                	xor    %eax,%eax
}
 46d:	5d                   	pop    %ebp
 46e:	c3                   	ret    
 46f:	90                   	nop

00000470 <memset>:

void*
memset(void *dst, int c, uint n)
{
 470:	55                   	push   %ebp
 471:	89 e5                	mov    %esp,%ebp
 473:	57                   	push   %edi
 474:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 477:	89 d7                	mov    %edx,%edi
 479:	8b 4d 10             	mov    0x10(%ebp),%ecx
 47c:	8b 45 0c             	mov    0xc(%ebp),%eax
 47f:	fc                   	cld    
 480:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 482:	89 d0                	mov    %edx,%eax
 484:	5f                   	pop    %edi
 485:	5d                   	pop    %ebp
 486:	c3                   	ret    
 487:	90                   	nop

00000488 <strchr>:

char*
strchr(const char *s, char c)
{
 488:	55                   	push   %ebp
 489:	89 e5                	mov    %esp,%ebp
 48b:	8b 45 08             	mov    0x8(%ebp),%eax
 48e:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
 491:	8a 10                	mov    (%eax),%dl
 493:	84 d2                	test   %dl,%dl
 495:	75 0c                	jne    4a3 <strchr+0x1b>
 497:	eb 13                	jmp    4ac <strchr+0x24>
 499:	8d 76 00             	lea    0x0(%esi),%esi
 49c:	40                   	inc    %eax
 49d:	8a 10                	mov    (%eax),%dl
 49f:	84 d2                	test   %dl,%dl
 4a1:	74 09                	je     4ac <strchr+0x24>
    if(*s == c)
 4a3:	38 ca                	cmp    %cl,%dl
 4a5:	75 f5                	jne    49c <strchr+0x14>
      return (char*)s;
  return 0;
}
 4a7:	5d                   	pop    %ebp
 4a8:	c3                   	ret    
 4a9:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
 4ac:	31 c0                	xor    %eax,%eax
}
 4ae:	5d                   	pop    %ebp
 4af:	c3                   	ret    

000004b0 <gets>:

char*
gets(char *buf, int max)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	57                   	push   %edi
 4b4:	56                   	push   %esi
 4b5:	53                   	push   %ebx
 4b6:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4b9:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
 4bb:	8d 7d e7             	lea    -0x19(%ebp),%edi
 4be:	66 90                	xchg   %ax,%ax
  for(i=0; i+1 < max; ){
 4c0:	8d 73 01             	lea    0x1(%ebx),%esi
 4c3:	3b 75 0c             	cmp    0xc(%ebp),%esi
 4c6:	7d 40                	jge    508 <gets+0x58>
    cc = read(0, &c, 1);
 4c8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4cf:	00 
 4d0:	89 7c 24 04          	mov    %edi,0x4(%esp)
 4d4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4db:	e8 fb 00 00 00       	call   5db <read>
    if(cc < 1)
 4e0:	85 c0                	test   %eax,%eax
 4e2:	7e 24                	jle    508 <gets+0x58>
      break;
    buf[i++] = c;
 4e4:	8a 45 e7             	mov    -0x19(%ebp),%al
 4e7:	8b 55 08             	mov    0x8(%ebp),%edx
 4ea:	88 44 32 ff          	mov    %al,-0x1(%edx,%esi,1)
    if(c == '\n' || c == '\r')
 4ee:	3c 0a                	cmp    $0xa,%al
 4f0:	74 06                	je     4f8 <gets+0x48>
 4f2:	89 f3                	mov    %esi,%ebx
 4f4:	3c 0d                	cmp    $0xd,%al
 4f6:	75 c8                	jne    4c0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 4f8:	8b 45 08             	mov    0x8(%ebp),%eax
 4fb:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 4ff:	83 c4 2c             	add    $0x2c,%esp
 502:	5b                   	pop    %ebx
 503:	5e                   	pop    %esi
 504:	5f                   	pop    %edi
 505:	5d                   	pop    %ebp
 506:	c3                   	ret    
 507:	90                   	nop
    if(cc < 1)
 508:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 50a:	8b 45 08             	mov    0x8(%ebp),%eax
 50d:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 511:	83 c4 2c             	add    $0x2c,%esp
 514:	5b                   	pop    %ebx
 515:	5e                   	pop    %esi
 516:	5f                   	pop    %edi
 517:	5d                   	pop    %ebp
 518:	c3                   	ret    
 519:	8d 76 00             	lea    0x0(%esi),%esi

0000051c <stat>:

int
stat(char *n, struct stat *st)
{
 51c:	55                   	push   %ebp
 51d:	89 e5                	mov    %esp,%ebp
 51f:	56                   	push   %esi
 520:	53                   	push   %ebx
 521:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 524:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 52b:	00 
 52c:	8b 45 08             	mov    0x8(%ebp),%eax
 52f:	89 04 24             	mov    %eax,(%esp)
 532:	e8 cc 00 00 00       	call   603 <open>
 537:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 539:	85 c0                	test   %eax,%eax
 53b:	78 23                	js     560 <stat+0x44>
    return -1;
  r = fstat(fd, st);
 53d:	8b 45 0c             	mov    0xc(%ebp),%eax
 540:	89 44 24 04          	mov    %eax,0x4(%esp)
 544:	89 1c 24             	mov    %ebx,(%esp)
 547:	e8 cf 00 00 00       	call   61b <fstat>
 54c:	89 c6                	mov    %eax,%esi
  close(fd);
 54e:	89 1c 24             	mov    %ebx,(%esp)
 551:	e8 95 00 00 00       	call   5eb <close>
  return r;
}
 556:	89 f0                	mov    %esi,%eax
 558:	83 c4 10             	add    $0x10,%esp
 55b:	5b                   	pop    %ebx
 55c:	5e                   	pop    %esi
 55d:	5d                   	pop    %ebp
 55e:	c3                   	ret    
 55f:	90                   	nop
    return -1;
 560:	be ff ff ff ff       	mov    $0xffffffff,%esi
 565:	eb ef                	jmp    556 <stat+0x3a>
 567:	90                   	nop

00000568 <atoi>:

int
atoi(const char *s)
{
 568:	55                   	push   %ebp
 569:	89 e5                	mov    %esp,%ebp
 56b:	53                   	push   %ebx
 56c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 56f:	0f be 11             	movsbl (%ecx),%edx
 572:	8d 42 d0             	lea    -0x30(%edx),%eax
 575:	3c 09                	cmp    $0x9,%al
 577:	b8 00 00 00 00       	mov    $0x0,%eax
 57c:	77 15                	ja     593 <atoi+0x2b>
 57e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 580:	8d 04 80             	lea    (%eax,%eax,4),%eax
 583:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
 587:	41                   	inc    %ecx
  while('0' <= *s && *s <= '9')
 588:	0f be 11             	movsbl (%ecx),%edx
 58b:	8d 5a d0             	lea    -0x30(%edx),%ebx
 58e:	80 fb 09             	cmp    $0x9,%bl
 591:	76 ed                	jbe    580 <atoi+0x18>
  return n;
}
 593:	5b                   	pop    %ebx
 594:	5d                   	pop    %ebp
 595:	c3                   	ret    
 596:	66 90                	xchg   %ax,%ax

00000598 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 598:	55                   	push   %ebp
 599:	89 e5                	mov    %esp,%ebp
 59b:	56                   	push   %esi
 59c:	53                   	push   %ebx
 59d:	8b 45 08             	mov    0x8(%ebp),%eax
 5a0:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 5a3:	8b 75 10             	mov    0x10(%ebp),%esi
memmove(void *vdst, void *vsrc, int n)
 5a6:	31 d2                	xor    %edx,%edx
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 5a8:	85 f6                	test   %esi,%esi
 5aa:	7e 0b                	jle    5b7 <memmove+0x1f>
    *dst++ = *src++;
 5ac:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 5af:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 5b2:	42                   	inc    %edx
  while(n-- > 0)
 5b3:	39 f2                	cmp    %esi,%edx
 5b5:	75 f5                	jne    5ac <memmove+0x14>
  return vdst;
}
 5b7:	5b                   	pop    %ebx
 5b8:	5e                   	pop    %esi
 5b9:	5d                   	pop    %ebp
 5ba:	c3                   	ret    

000005bb <fork>:
 5bb:	b8 01 00 00 00       	mov    $0x1,%eax
 5c0:	cd 40                	int    $0x40
 5c2:	c3                   	ret    

000005c3 <exit>:
 5c3:	b8 02 00 00 00       	mov    $0x2,%eax
 5c8:	cd 40                	int    $0x40
 5ca:	c3                   	ret    

000005cb <wait>:
 5cb:	b8 03 00 00 00       	mov    $0x3,%eax
 5d0:	cd 40                	int    $0x40
 5d2:	c3                   	ret    

000005d3 <pipe>:
 5d3:	b8 04 00 00 00       	mov    $0x4,%eax
 5d8:	cd 40                	int    $0x40
 5da:	c3                   	ret    

000005db <read>:
 5db:	b8 05 00 00 00       	mov    $0x5,%eax
 5e0:	cd 40                	int    $0x40
 5e2:	c3                   	ret    

000005e3 <write>:
 5e3:	b8 10 00 00 00       	mov    $0x10,%eax
 5e8:	cd 40                	int    $0x40
 5ea:	c3                   	ret    

000005eb <close>:
 5eb:	b8 15 00 00 00       	mov    $0x15,%eax
 5f0:	cd 40                	int    $0x40
 5f2:	c3                   	ret    

000005f3 <kill>:
 5f3:	b8 06 00 00 00       	mov    $0x6,%eax
 5f8:	cd 40                	int    $0x40
 5fa:	c3                   	ret    

000005fb <exec>:
 5fb:	b8 07 00 00 00       	mov    $0x7,%eax
 600:	cd 40                	int    $0x40
 602:	c3                   	ret    

00000603 <open>:
 603:	b8 0f 00 00 00       	mov    $0xf,%eax
 608:	cd 40                	int    $0x40
 60a:	c3                   	ret    

0000060b <mknod>:
 60b:	b8 11 00 00 00       	mov    $0x11,%eax
 610:	cd 40                	int    $0x40
 612:	c3                   	ret    

00000613 <unlink>:
 613:	b8 12 00 00 00       	mov    $0x12,%eax
 618:	cd 40                	int    $0x40
 61a:	c3                   	ret    

0000061b <fstat>:
 61b:	b8 08 00 00 00       	mov    $0x8,%eax
 620:	cd 40                	int    $0x40
 622:	c3                   	ret    

00000623 <link>:
 623:	b8 13 00 00 00       	mov    $0x13,%eax
 628:	cd 40                	int    $0x40
 62a:	c3                   	ret    

0000062b <mkdir>:
 62b:	b8 14 00 00 00       	mov    $0x14,%eax
 630:	cd 40                	int    $0x40
 632:	c3                   	ret    

00000633 <chdir>:
 633:	b8 09 00 00 00       	mov    $0x9,%eax
 638:	cd 40                	int    $0x40
 63a:	c3                   	ret    

0000063b <dup>:
 63b:	b8 0a 00 00 00       	mov    $0xa,%eax
 640:	cd 40                	int    $0x40
 642:	c3                   	ret    

00000643 <getpid>:
 643:	b8 0b 00 00 00       	mov    $0xb,%eax
 648:	cd 40                	int    $0x40
 64a:	c3                   	ret    

0000064b <sbrk>:
 64b:	b8 0c 00 00 00       	mov    $0xc,%eax
 650:	cd 40                	int    $0x40
 652:	c3                   	ret    

00000653 <sleep>:
 653:	b8 0d 00 00 00       	mov    $0xd,%eax
 658:	cd 40                	int    $0x40
 65a:	c3                   	ret    

0000065b <uptime>:
 65b:	b8 0e 00 00 00       	mov    $0xe,%eax
 660:	cd 40                	int    $0x40
 662:	c3                   	ret    

00000663 <getprocnum>:
 663:	b8 16 00 00 00       	mov    $0x16,%eax
 668:	cd 40                	int    $0x40
 66a:	c3                   	ret    

0000066b <mempagenum>:
 66b:	b8 17 00 00 00       	mov    $0x17,%eax
 670:	cd 40                	int    $0x40
 672:	c3                   	ret    

00000673 <syscallnum>:
 673:	b8 18 00 00 00       	mov    $0x18,%eax
 678:	cd 40                	int    $0x40
 67a:	c3                   	ret    

0000067b <settickets>:
 67b:	b8 19 00 00 00       	mov    $0x19,%eax
 680:	cd 40                	int    $0x40
 682:	c3                   	ret    

00000683 <getsheltime>:
 683:	b8 1a 00 00 00       	mov    $0x1a,%eax
 688:	cd 40                	int    $0x40
 68a:	c3                   	ret    

0000068b <setstride>:
 68b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 690:	cd 40                	int    $0x40
 692:	c3                   	ret    

00000693 <setpass>:
 693:	b8 1c 00 00 00       	mov    $0x1c,%eax
 698:	cd 40                	int    $0x40
 69a:	c3                   	ret    

0000069b <join>:
 69b:	b8 1d 00 00 00       	mov    $0x1d,%eax
 6a0:	cd 40                	int    $0x40
 6a2:	c3                   	ret    

000006a3 <clone1>:
 6a3:	b8 1e 00 00 00       	mov    $0x1e,%eax
 6a8:	cd 40                	int    $0x40
 6aa:	c3                   	ret    
 6ab:	90                   	nop

000006ac <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 6ac:	55                   	push   %ebp
 6ad:	89 e5                	mov    %esp,%ebp
 6af:	57                   	push   %edi
 6b0:	56                   	push   %esi
 6b1:	53                   	push   %ebx
 6b2:	83 ec 3c             	sub    $0x3c,%esp
 6b5:	89 c7                	mov    %eax,%edi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 6b7:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 6b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6bc:	85 db                	test   %ebx,%ebx
 6be:	74 04                	je     6c4 <printint+0x18>
 6c0:	85 d2                	test   %edx,%edx
 6c2:	78 5d                	js     721 <printint+0x75>
  neg = 0;
 6c4:	31 db                	xor    %ebx,%ebx
  } else {
    x = xx;
  }

  i = 0;
 6c6:	31 f6                	xor    %esi,%esi
 6c8:	eb 04                	jmp    6ce <printint+0x22>
 6ca:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 6cc:	89 d6                	mov    %edx,%esi
 6ce:	31 d2                	xor    %edx,%edx
 6d0:	f7 f1                	div    %ecx
 6d2:	8a 92 9b 0a 00 00    	mov    0xa9b(%edx),%dl
 6d8:	88 54 35 d8          	mov    %dl,-0x28(%ebp,%esi,1)
 6dc:	8d 56 01             	lea    0x1(%esi),%edx
  }while((x /= base) != 0);
 6df:	85 c0                	test   %eax,%eax
 6e1:	75 e9                	jne    6cc <printint+0x20>
  if(neg)
 6e3:	85 db                	test   %ebx,%ebx
 6e5:	74 08                	je     6ef <printint+0x43>
    buf[i++] = '-';
 6e7:	c6 44 15 d8 2d       	movb   $0x2d,-0x28(%ebp,%edx,1)
 6ec:	8d 56 02             	lea    0x2(%esi),%edx

  while(--i >= 0)
 6ef:	8d 5a ff             	lea    -0x1(%edx),%ebx
 6f2:	8d 75 d7             	lea    -0x29(%ebp),%esi
 6f5:	8d 76 00             	lea    0x0(%esi),%esi
 6f8:	8a 44 1d d8          	mov    -0x28(%ebp,%ebx,1),%al
 6fc:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 6ff:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 706:	00 
 707:	89 74 24 04          	mov    %esi,0x4(%esp)
 70b:	89 3c 24             	mov    %edi,(%esp)
 70e:	e8 d0 fe ff ff       	call   5e3 <write>
  while(--i >= 0)
 713:	4b                   	dec    %ebx
 714:	83 fb ff             	cmp    $0xffffffff,%ebx
 717:	75 df                	jne    6f8 <printint+0x4c>
    putc(fd, buf[i]);
}
 719:	83 c4 3c             	add    $0x3c,%esp
 71c:	5b                   	pop    %ebx
 71d:	5e                   	pop    %esi
 71e:	5f                   	pop    %edi
 71f:	5d                   	pop    %ebp
 720:	c3                   	ret    
    x = -xx;
 721:	f7 d8                	neg    %eax
    neg = 1;
 723:	bb 01 00 00 00       	mov    $0x1,%ebx
    x = -xx;
 728:	eb 9c                	jmp    6c6 <printint+0x1a>
 72a:	66 90                	xchg   %ax,%ax

0000072c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 72c:	55                   	push   %ebp
 72d:	89 e5                	mov    %esp,%ebp
 72f:	57                   	push   %edi
 730:	56                   	push   %esi
 731:	53                   	push   %ebx
 732:	83 ec 3c             	sub    $0x3c,%esp
 735:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 738:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 73b:	8a 03                	mov    (%ebx),%al
 73d:	84 c0                	test   %al,%al
 73f:	0f 84 bb 00 00 00    	je     800 <printf+0xd4>
printf(int fd, char *fmt, ...)
 745:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
 746:	8d 55 10             	lea    0x10(%ebp),%edx
 749:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  state = 0;
 74c:	31 ff                	xor    %edi,%edi
 74e:	eb 2f                	jmp    77f <printf+0x53>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 750:	83 f9 25             	cmp    $0x25,%ecx
 753:	0f 84 af 00 00 00    	je     808 <printf+0xdc>
        state = '%';
      } else {
        putc(fd, c);
 759:	88 4d e2             	mov    %cl,-0x1e(%ebp)
  write(fd, &c, 1);
 75c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 763:	00 
 764:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 767:	89 44 24 04          	mov    %eax,0x4(%esp)
 76b:	89 34 24             	mov    %esi,(%esp)
 76e:	e8 70 fe ff ff       	call   5e3 <write>
 773:	43                   	inc    %ebx
  for(i = 0; fmt[i]; i++){
 774:	8a 43 ff             	mov    -0x1(%ebx),%al
 777:	84 c0                	test   %al,%al
 779:	0f 84 81 00 00 00    	je     800 <printf+0xd4>
    c = fmt[i] & 0xff;
 77f:	0f b6 c8             	movzbl %al,%ecx
    if(state == 0){
 782:	85 ff                	test   %edi,%edi
 784:	74 ca                	je     750 <printf+0x24>
      }
    } else if(state == '%'){
 786:	83 ff 25             	cmp    $0x25,%edi
 789:	75 e8                	jne    773 <printf+0x47>
      if(c == 'd'){
 78b:	83 f9 64             	cmp    $0x64,%ecx
 78e:	0f 84 14 01 00 00    	je     8a8 <printf+0x17c>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 794:	83 f9 78             	cmp    $0x78,%ecx
 797:	74 7b                	je     814 <printf+0xe8>
 799:	83 f9 70             	cmp    $0x70,%ecx
 79c:	74 76                	je     814 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 79e:	83 f9 73             	cmp    $0x73,%ecx
 7a1:	0f 84 91 00 00 00    	je     838 <printf+0x10c>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7a7:	83 f9 63             	cmp    $0x63,%ecx
 7aa:	0f 84 cc 00 00 00    	je     87c <printf+0x150>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 7b0:	83 f9 25             	cmp    $0x25,%ecx
 7b3:	0f 84 13 01 00 00    	je     8cc <printf+0x1a0>
 7b9:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
  write(fd, &c, 1);
 7bd:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 7c4:	00 
 7c5:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 7c8:	89 44 24 04          	mov    %eax,0x4(%esp)
 7cc:	89 34 24             	mov    %esi,(%esp)
 7cf:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 7d2:	e8 0c fe ff ff       	call   5e3 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 7d7:	8b 4d d0             	mov    -0x30(%ebp),%ecx
 7da:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
 7dd:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 7e4:	00 
 7e5:	8d 55 e7             	lea    -0x19(%ebp),%edx
 7e8:	89 54 24 04          	mov    %edx,0x4(%esp)
 7ec:	89 34 24             	mov    %esi,(%esp)
 7ef:	e8 ef fd ff ff       	call   5e3 <write>
      }
      state = 0;
 7f4:	31 ff                	xor    %edi,%edi
 7f6:	43                   	inc    %ebx
  for(i = 0; fmt[i]; i++){
 7f7:	8a 43 ff             	mov    -0x1(%ebx),%al
 7fa:	84 c0                	test   %al,%al
 7fc:	75 81                	jne    77f <printf+0x53>
 7fe:	66 90                	xchg   %ax,%ax
    }
  }
}
 800:	83 c4 3c             	add    $0x3c,%esp
 803:	5b                   	pop    %ebx
 804:	5e                   	pop    %esi
 805:	5f                   	pop    %edi
 806:	5d                   	pop    %ebp
 807:	c3                   	ret    
        state = '%';
 808:	bf 25 00 00 00       	mov    $0x25,%edi
 80d:	e9 61 ff ff ff       	jmp    773 <printf+0x47>
 812:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 814:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 81b:	b9 10 00 00 00       	mov    $0x10,%ecx
 820:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 823:	8b 10                	mov    (%eax),%edx
 825:	89 f0                	mov    %esi,%eax
 827:	e8 80 fe ff ff       	call   6ac <printint>
        ap++;
 82c:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 830:	31 ff                	xor    %edi,%edi
        ap++;
 832:	e9 3c ff ff ff       	jmp    773 <printf+0x47>
 837:	90                   	nop
        s = (char*)*ap;
 838:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 83b:	8b 3a                	mov    (%edx),%edi
        ap++;
 83d:	83 c2 04             	add    $0x4,%edx
 840:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
 843:	85 ff                	test   %edi,%edi
 845:	0f 84 a3 00 00 00    	je     8ee <printf+0x1c2>
        while(*s != 0){
 84b:	8a 07                	mov    (%edi),%al
 84d:	84 c0                	test   %al,%al
 84f:	74 24                	je     875 <printf+0x149>
 851:	8d 76 00             	lea    0x0(%esi),%esi
 854:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 857:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 85e:	00 
 85f:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 862:	89 44 24 04          	mov    %eax,0x4(%esp)
 866:	89 34 24             	mov    %esi,(%esp)
 869:	e8 75 fd ff ff       	call   5e3 <write>
          s++;
 86e:	47                   	inc    %edi
        while(*s != 0){
 86f:	8a 07                	mov    (%edi),%al
 871:	84 c0                	test   %al,%al
 873:	75 df                	jne    854 <printf+0x128>
      state = 0;
 875:	31 ff                	xor    %edi,%edi
 877:	e9 f7 fe ff ff       	jmp    773 <printf+0x47>
        putc(fd, *ap);
 87c:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 87f:	8b 02                	mov    (%edx),%eax
 881:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 884:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 88b:	00 
 88c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 88f:	89 44 24 04          	mov    %eax,0x4(%esp)
 893:	89 34 24             	mov    %esi,(%esp)
 896:	e8 48 fd ff ff       	call   5e3 <write>
        ap++;
 89b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 89f:	31 ff                	xor    %edi,%edi
 8a1:	e9 cd fe ff ff       	jmp    773 <printf+0x47>
 8a6:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 8a8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 8af:	b1 0a                	mov    $0xa,%cl
 8b1:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 8b4:	8b 10                	mov    (%eax),%edx
 8b6:	89 f0                	mov    %esi,%eax
 8b8:	e8 ef fd ff ff       	call   6ac <printint>
        ap++;
 8bd:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
 8c1:	66 31 ff             	xor    %di,%di
 8c4:	e9 aa fe ff ff       	jmp    773 <printf+0x47>
 8c9:	8d 76 00             	lea    0x0(%esi),%esi
 8cc:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
  write(fd, &c, 1);
 8d0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 8d7:	00 
 8d8:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 8db:	89 44 24 04          	mov    %eax,0x4(%esp)
 8df:	89 34 24             	mov    %esi,(%esp)
 8e2:	e8 fc fc ff ff       	call   5e3 <write>
      state = 0;
 8e7:	31 ff                	xor    %edi,%edi
 8e9:	e9 85 fe ff ff       	jmp    773 <printf+0x47>
          s = "(null)";
 8ee:	bf 94 0a 00 00       	mov    $0xa94,%edi
 8f3:	e9 53 ff ff ff       	jmp    84b <printf+0x11f>

000008f8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8f8:	55                   	push   %ebp
 8f9:	89 e5                	mov    %esp,%ebp
 8fb:	57                   	push   %edi
 8fc:	56                   	push   %esi
 8fd:	53                   	push   %ebx
 8fe:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 901:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 904:	a1 18 0e 00 00       	mov    0xe18,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 909:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 90b:	39 d0                	cmp    %edx,%eax
 90d:	72 11                	jb     920 <free+0x28>
 90f:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 910:	39 c8                	cmp    %ecx,%eax
 912:	72 04                	jb     918 <free+0x20>
 914:	39 ca                	cmp    %ecx,%edx
 916:	72 10                	jb     928 <free+0x30>
 918:	89 c8                	mov    %ecx,%eax
 91a:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 91c:	39 d0                	cmp    %edx,%eax
 91e:	73 f0                	jae    910 <free+0x18>
 920:	39 ca                	cmp    %ecx,%edx
 922:	72 04                	jb     928 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 924:	39 c8                	cmp    %ecx,%eax
 926:	72 f0                	jb     918 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 928:	8b 73 fc             	mov    -0x4(%ebx),%esi
 92b:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 92e:	39 cf                	cmp    %ecx,%edi
 930:	74 1a                	je     94c <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 932:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 935:	8b 48 04             	mov    0x4(%eax),%ecx
 938:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 93b:	39 f2                	cmp    %esi,%edx
 93d:	74 24                	je     963 <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 93f:	89 10                	mov    %edx,(%eax)
  freep = p;
 941:	a3 18 0e 00 00       	mov    %eax,0xe18
}
 946:	5b                   	pop    %ebx
 947:	5e                   	pop    %esi
 948:	5f                   	pop    %edi
 949:	5d                   	pop    %ebp
 94a:	c3                   	ret    
 94b:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 94c:	03 71 04             	add    0x4(%ecx),%esi
 94f:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 952:	8b 08                	mov    (%eax),%ecx
 954:	8b 09                	mov    (%ecx),%ecx
 956:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 959:	8b 48 04             	mov    0x4(%eax),%ecx
 95c:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 95f:	39 f2                	cmp    %esi,%edx
 961:	75 dc                	jne    93f <free+0x47>
    p->s.size += bp->s.size;
 963:	03 4b fc             	add    -0x4(%ebx),%ecx
 966:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 969:	8b 53 f8             	mov    -0x8(%ebx),%edx
 96c:	89 10                	mov    %edx,(%eax)
  freep = p;
 96e:	a3 18 0e 00 00       	mov    %eax,0xe18
}
 973:	5b                   	pop    %ebx
 974:	5e                   	pop    %esi
 975:	5f                   	pop    %edi
 976:	5d                   	pop    %ebp
 977:	c3                   	ret    

00000978 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 978:	55                   	push   %ebp
 979:	89 e5                	mov    %esp,%ebp
 97b:	57                   	push   %edi
 97c:	56                   	push   %esi
 97d:	53                   	push   %ebx
 97e:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 981:	8b 75 08             	mov    0x8(%ebp),%esi
 984:	83 c6 07             	add    $0x7,%esi
 987:	c1 ee 03             	shr    $0x3,%esi
 98a:	46                   	inc    %esi
  if((prevp = freep) == 0){
 98b:	8b 15 18 0e 00 00    	mov    0xe18,%edx
 991:	85 d2                	test   %edx,%edx
 993:	0f 84 8d 00 00 00    	je     a26 <malloc+0xae>
 999:	8b 02                	mov    (%edx),%eax
 99b:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 99e:	39 ce                	cmp    %ecx,%esi
 9a0:	76 52                	jbe    9f4 <malloc+0x7c>
 9a2:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 9a9:	eb 0a                	jmp    9b5 <malloc+0x3d>
 9ab:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9ac:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 9ae:	8b 48 04             	mov    0x4(%eax),%ecx
 9b1:	39 ce                	cmp    %ecx,%esi
 9b3:	76 3f                	jbe    9f4 <malloc+0x7c>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9b5:	89 c2                	mov    %eax,%edx
 9b7:	3b 05 18 0e 00 00    	cmp    0xe18,%eax
 9bd:	75 ed                	jne    9ac <malloc+0x34>
  if(nu < 4096)
 9bf:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 9c5:	76 4d                	jbe    a14 <malloc+0x9c>
 9c7:	89 d8                	mov    %ebx,%eax
 9c9:	89 f7                	mov    %esi,%edi
  p = sbrk(nu * sizeof(Header));
 9cb:	89 04 24             	mov    %eax,(%esp)
 9ce:	e8 78 fc ff ff       	call   64b <sbrk>
  if(p == (char*)-1)
 9d3:	83 f8 ff             	cmp    $0xffffffff,%eax
 9d6:	74 18                	je     9f0 <malloc+0x78>
  hp->s.size = nu;
 9d8:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 9db:	83 c0 08             	add    $0x8,%eax
 9de:	89 04 24             	mov    %eax,(%esp)
 9e1:	e8 12 ff ff ff       	call   8f8 <free>
  return freep;
 9e6:	8b 15 18 0e 00 00    	mov    0xe18,%edx
      if((p = morecore(nunits)) == 0)
 9ec:	85 d2                	test   %edx,%edx
 9ee:	75 bc                	jne    9ac <malloc+0x34>
        return 0;
 9f0:	31 c0                	xor    %eax,%eax
 9f2:	eb 18                	jmp    a0c <malloc+0x94>
      if(p->s.size == nunits)
 9f4:	39 ce                	cmp    %ecx,%esi
 9f6:	74 28                	je     a20 <malloc+0xa8>
        p->s.size -= nunits;
 9f8:	29 f1                	sub    %esi,%ecx
 9fa:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 9fd:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 a00:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 a03:	89 15 18 0e 00 00    	mov    %edx,0xe18
      return (void*)(p + 1);
 a09:	83 c0 08             	add    $0x8,%eax
  }
}
 a0c:	83 c4 1c             	add    $0x1c,%esp
 a0f:	5b                   	pop    %ebx
 a10:	5e                   	pop    %esi
 a11:	5f                   	pop    %edi
 a12:	5d                   	pop    %ebp
 a13:	c3                   	ret    
  if(nu < 4096)
 a14:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 a19:	bf 00 10 00 00       	mov    $0x1000,%edi
 a1e:	eb ab                	jmp    9cb <malloc+0x53>
        prevp->s.ptr = p->s.ptr;
 a20:	8b 08                	mov    (%eax),%ecx
 a22:	89 0a                	mov    %ecx,(%edx)
 a24:	eb dd                	jmp    a03 <malloc+0x8b>
    base.s.ptr = freep = prevp = &base;
 a26:	c7 05 18 0e 00 00 1c 	movl   $0xe1c,0xe18
 a2d:	0e 00 00 
 a30:	c7 05 1c 0e 00 00 1c 	movl   $0xe1c,0xe1c
 a37:	0e 00 00 
    base.s.size = 0;
 a3a:	c7 05 20 0e 00 00 00 	movl   $0x0,0xe20
 a41:	00 00 00 
 a44:	b8 1c 0e 00 00       	mov    $0xe1c,%eax
 a49:	e9 54 ff ff ff       	jmp    9a2 <malloc+0x2a>
