
_sh：     文件格式 elf32-i386


Disassembly of section .text:

00000000 <main>:
  return 0;
}

int
main(void)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 e4 f0             	and    $0xfffffff0,%esp
       6:	83 ec 10             	sub    $0x10,%esp
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
       9:	eb 0a                	jmp    15 <main+0x15>
       b:	90                   	nop
    if(fd >= 3){
       c:	83 f8 02             	cmp    $0x2,%eax
       f:	0f 8f c5 00 00 00    	jg     da <main+0xda>
  while((fd = open("console", O_RDWR)) >= 0){
      15:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
      1c:	00 
      1d:	c7 04 24 fd 11 00 00 	movl   $0x11fd,(%esp)
      24:	e8 e6 0c 00 00       	call   d0f <open>
      29:	85 c0                	test   %eax,%eax
      2b:	79 df                	jns    c <main+0xc>
      2d:	eb 1b                	jmp    4a <main+0x4a>
      2f:	90                   	nop
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      30:	80 3d 22 18 00 00 20 	cmpb   $0x20,0x1822
      37:	74 5d                	je     96 <main+0x96>
      39:	8d 76 00             	lea    0x0(%esi),%esi
      buf[strlen(buf)-1] = 0;  // chop \n
      if(chdir(buf+3) < 0)
        printf(2, "cannot cd %s\n", buf+3);
      continue;
    }
    if(fork1() == 0)
      3c:	e8 1f 01 00 00       	call   160 <fork1>
      41:	85 c0                	test   %eax,%eax
      43:	74 38                	je     7d <main+0x7d>
      runcmd(parsecmd(buf));
    wait();
      45:	e8 8d 0c 00 00       	call   cd7 <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
      4a:	c7 44 24 04 64 00 00 	movl   $0x64,0x4(%esp)
      51:	00 
      52:	c7 04 24 20 18 00 00 	movl   $0x1820,(%esp)
      59:	e8 8a 00 00 00       	call   e8 <getcmd>
      5e:	85 c0                	test   %eax,%eax
      60:	78 2f                	js     91 <main+0x91>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      62:	80 3d 20 18 00 00 63 	cmpb   $0x63,0x1820
      69:	75 d1                	jne    3c <main+0x3c>
      6b:	80 3d 21 18 00 00 64 	cmpb   $0x64,0x1821
      72:	74 bc                	je     30 <main+0x30>
    if(fork1() == 0)
      74:	e8 e7 00 00 00       	call   160 <fork1>
      79:	85 c0                	test   %eax,%eax
      7b:	75 c8                	jne    45 <main+0x45>
      runcmd(parsecmd(buf));
      7d:	c7 04 24 20 18 00 00 	movl   $0x1820,(%esp)
      84:	e8 ff 09 00 00       	call   a88 <parsecmd>
      89:	89 04 24             	mov    %eax,(%esp)
      8c:	e8 ef 00 00 00       	call   180 <runcmd>
  }
  exit();
      91:	e8 39 0c 00 00       	call   ccf <exit>
      buf[strlen(buf)-1] = 0;  // chop \n
      96:	c7 04 24 20 18 00 00 	movl   $0x1820,(%esp)
      9d:	e8 ba 0a 00 00       	call   b5c <strlen>
      a2:	c6 80 1f 18 00 00 00 	movb   $0x0,0x181f(%eax)
      if(chdir(buf+3) < 0)
      a9:	c7 04 24 23 18 00 00 	movl   $0x1823,(%esp)
      b0:	e8 8a 0c 00 00       	call   d3f <chdir>
      b5:	85 c0                	test   %eax,%eax
      b7:	79 91                	jns    4a <main+0x4a>
        printf(2, "cannot cd %s\n", buf+3);
      b9:	c7 44 24 08 23 18 00 	movl   $0x1823,0x8(%esp)
      c0:	00 
      c1:	c7 44 24 04 05 12 00 	movl   $0x1205,0x4(%esp)
      c8:	00 
      c9:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
      d0:	e8 63 0d 00 00       	call   e38 <printf>
      d5:	e9 70 ff ff ff       	jmp    4a <main+0x4a>
      close(fd);
      da:	89 04 24             	mov    %eax,(%esp)
      dd:	e8 15 0c 00 00       	call   cf7 <close>
      break;
      e2:	e9 63 ff ff ff       	jmp    4a <main+0x4a>
      e7:	90                   	nop

000000e8 <getcmd>:
{
      e8:	55                   	push   %ebp
      e9:	89 e5                	mov    %esp,%ebp
      eb:	56                   	push   %esi
      ec:	53                   	push   %ebx
      ed:	83 ec 10             	sub    $0x10,%esp
      f0:	8b 5d 08             	mov    0x8(%ebp),%ebx
      f3:	8b 75 0c             	mov    0xc(%ebp),%esi
  printf(2, "$ ");
      f6:	c7 44 24 04 5c 11 00 	movl   $0x115c,0x4(%esp)
      fd:	00 
      fe:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     105:	e8 2e 0d 00 00       	call   e38 <printf>
  memset(buf, 0, nbuf);
     10a:	89 74 24 08          	mov    %esi,0x8(%esp)
     10e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     115:	00 
     116:	89 1c 24             	mov    %ebx,(%esp)
     119:	e8 5e 0a 00 00       	call   b7c <memset>
  gets(buf, nbuf);
     11e:	89 74 24 04          	mov    %esi,0x4(%esp)
     122:	89 1c 24             	mov    %ebx,(%esp)
     125:	e8 92 0a 00 00       	call   bbc <gets>
    return -1;
     12a:	80 3b 01             	cmpb   $0x1,(%ebx)
     12d:	19 c0                	sbb    %eax,%eax
}
     12f:	83 c4 10             	add    $0x10,%esp
     132:	5b                   	pop    %ebx
     133:	5e                   	pop    %esi
     134:	5d                   	pop    %ebp
     135:	c3                   	ret    
     136:	66 90                	xchg   %ax,%ax

00000138 <panic>:
}

void
panic(char *s)
{
     138:	55                   	push   %ebp
     139:	89 e5                	mov    %esp,%ebp
     13b:	83 ec 18             	sub    $0x18,%esp
  printf(2, "%s\n", s);
     13e:	8b 45 08             	mov    0x8(%ebp),%eax
     141:	89 44 24 08          	mov    %eax,0x8(%esp)
     145:	c7 44 24 04 f9 11 00 	movl   $0x11f9,0x4(%esp)
     14c:	00 
     14d:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     154:	e8 df 0c 00 00       	call   e38 <printf>
  exit();
     159:	e8 71 0b 00 00       	call   ccf <exit>
     15e:	66 90                	xchg   %ax,%ax

00000160 <fork1>:
}

int
fork1(void)
{
     160:	55                   	push   %ebp
     161:	89 e5                	mov    %esp,%ebp
     163:	83 ec 18             	sub    $0x18,%esp
  int pid;

  pid = fork();
     166:	e8 5c 0b 00 00       	call   cc7 <fork>
  if(pid == -1)
     16b:	83 f8 ff             	cmp    $0xffffffff,%eax
     16e:	74 02                	je     172 <fork1+0x12>
    panic("fork");
  return pid;
}
     170:	c9                   	leave  
     171:	c3                   	ret    
    panic("fork");
     172:	c7 04 24 5f 11 00 00 	movl   $0x115f,(%esp)
     179:	e8 ba ff ff ff       	call   138 <panic>
     17e:	66 90                	xchg   %ax,%ax

00000180 <runcmd>:
{
     180:	55                   	push   %ebp
     181:	89 e5                	mov    %esp,%ebp
     183:	53                   	push   %ebx
     184:	83 ec 24             	sub    $0x24,%esp
     187:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(cmd == 0)
     18a:	85 db                	test   %ebx,%ebx
     18c:	74 5e                	je     1ec <runcmd+0x6c>
  switch(cmd->type){
     18e:	83 3b 05             	cmpl   $0x5,(%ebx)
     191:	76 5e                	jbe    1f1 <runcmd+0x71>
    panic("runcmd");
     193:	c7 04 24 64 11 00 00 	movl   $0x1164,(%esp)
     19a:	e8 99 ff ff ff       	call   138 <panic>
    if(pipe(p) < 0)
     19f:	8d 45 f0             	lea    -0x10(%ebp),%eax
     1a2:	89 04 24             	mov    %eax,(%esp)
     1a5:	e8 35 0b 00 00       	call   cdf <pipe>
     1aa:	85 c0                	test   %eax,%eax
     1ac:	0f 88 ee 00 00 00    	js     2a0 <runcmd+0x120>
    if(fork1() == 0){
     1b2:	e8 a9 ff ff ff       	call   160 <fork1>
     1b7:	85 c0                	test   %eax,%eax
     1b9:	0f 84 25 01 00 00    	je     2e4 <runcmd+0x164>
    if(fork1() == 0){
     1bf:	e8 9c ff ff ff       	call   160 <fork1>
     1c4:	85 c0                	test   %eax,%eax
     1c6:	0f 84 e0 00 00 00    	je     2ac <runcmd+0x12c>
    close(p[0]);
     1cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
     1cf:	89 04 24             	mov    %eax,(%esp)
     1d2:	e8 20 0b 00 00       	call   cf7 <close>
    close(p[1]);
     1d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1da:	89 04 24             	mov    %eax,(%esp)
     1dd:	e8 15 0b 00 00       	call   cf7 <close>
    wait();
     1e2:	e8 f0 0a 00 00       	call   cd7 <wait>
    wait();
     1e7:	e8 eb 0a 00 00       	call   cd7 <wait>
      exit();
     1ec:	e8 de 0a 00 00       	call   ccf <exit>
  switch(cmd->type){
     1f1:	8b 03                	mov    (%ebx),%eax
     1f3:	ff 24 85 14 12 00 00 	jmp    *0x1214(,%eax,4)
    if(fork1() == 0)
     1fa:	e8 61 ff ff ff       	call   160 <fork1>
     1ff:	85 c0                	test   %eax,%eax
     201:	75 e9                	jne    1ec <runcmd+0x6c>
     203:	eb 3a                	jmp    23f <runcmd+0xbf>
    if(fork1() == 0)
     205:	e8 56 ff ff ff       	call   160 <fork1>
     20a:	85 c0                	test   %eax,%eax
     20c:	74 31                	je     23f <runcmd+0xbf>
    wait();
     20e:	e8 c4 0a 00 00       	call   cd7 <wait>
    runcmd(lcmd->right);
     213:	8b 43 08             	mov    0x8(%ebx),%eax
     216:	89 04 24             	mov    %eax,(%esp)
     219:	e8 62 ff ff ff       	call   180 <runcmd>
    close(rcmd->fd);
     21e:	8b 43 14             	mov    0x14(%ebx),%eax
     221:	89 04 24             	mov    %eax,(%esp)
     224:	e8 ce 0a 00 00       	call   cf7 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     229:	8b 43 10             	mov    0x10(%ebx),%eax
     22c:	89 44 24 04          	mov    %eax,0x4(%esp)
     230:	8b 43 08             	mov    0x8(%ebx),%eax
     233:	89 04 24             	mov    %eax,(%esp)
     236:	e8 d4 0a 00 00       	call   d0f <open>
     23b:	85 c0                	test   %eax,%eax
     23d:	78 41                	js     280 <runcmd+0x100>
      runcmd(bcmd->cmd);
     23f:	8b 43 04             	mov    0x4(%ebx),%eax
     242:	89 04 24             	mov    %eax,(%esp)
     245:	e8 36 ff ff ff       	call   180 <runcmd>
    if(ecmd->argv[0] == 0)
     24a:	8b 43 04             	mov    0x4(%ebx),%eax
     24d:	85 c0                	test   %eax,%eax
     24f:	74 9b                	je     1ec <runcmd+0x6c>
    exec(ecmd->argv[0], ecmd->argv);
     251:	8d 53 04             	lea    0x4(%ebx),%edx
     254:	89 54 24 04          	mov    %edx,0x4(%esp)
     258:	89 04 24             	mov    %eax,(%esp)
     25b:	e8 a7 0a 00 00       	call   d07 <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
     260:	8b 43 04             	mov    0x4(%ebx),%eax
     263:	89 44 24 08          	mov    %eax,0x8(%esp)
     267:	c7 44 24 04 6b 11 00 	movl   $0x116b,0x4(%esp)
     26e:	00 
     26f:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     276:	e8 bd 0b 00 00       	call   e38 <printf>
    break;
     27b:	e9 6c ff ff ff       	jmp    1ec <runcmd+0x6c>
      printf(2, "open %s failed\n", rcmd->file);
     280:	8b 43 08             	mov    0x8(%ebx),%eax
     283:	89 44 24 08          	mov    %eax,0x8(%esp)
     287:	c7 44 24 04 7b 11 00 	movl   $0x117b,0x4(%esp)
     28e:	00 
     28f:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     296:	e8 9d 0b 00 00       	call   e38 <printf>
     29b:	e9 4c ff ff ff       	jmp    1ec <runcmd+0x6c>
      panic("pipe");
     2a0:	c7 04 24 8b 11 00 00 	movl   $0x118b,(%esp)
     2a7:	e8 8c fe ff ff       	call   138 <panic>
      close(0);
     2ac:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     2b3:	e8 3f 0a 00 00       	call   cf7 <close>
      dup(p[0]);
     2b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
     2bb:	89 04 24             	mov    %eax,(%esp)
     2be:	e8 84 0a 00 00       	call   d47 <dup>
      close(p[0]);
     2c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     2c6:	89 04 24             	mov    %eax,(%esp)
     2c9:	e8 29 0a 00 00       	call   cf7 <close>
      close(p[1]);
     2ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
     2d1:	89 04 24             	mov    %eax,(%esp)
     2d4:	e8 1e 0a 00 00       	call   cf7 <close>
      runcmd(pcmd->right);
     2d9:	8b 43 08             	mov    0x8(%ebx),%eax
     2dc:	89 04 24             	mov    %eax,(%esp)
     2df:	e8 9c fe ff ff       	call   180 <runcmd>
      close(1);
     2e4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     2eb:	e8 07 0a 00 00       	call   cf7 <close>
      dup(p[1]);
     2f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     2f3:	89 04 24             	mov    %eax,(%esp)
     2f6:	e8 4c 0a 00 00       	call   d47 <dup>
      close(p[0]);
     2fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
     2fe:	89 04 24             	mov    %eax,(%esp)
     301:	e8 f1 09 00 00       	call   cf7 <close>
      close(p[1]);
     306:	8b 45 f4             	mov    -0xc(%ebp),%eax
     309:	89 04 24             	mov    %eax,(%esp)
     30c:	e8 e6 09 00 00       	call   cf7 <close>
      runcmd(pcmd->left);
     311:	8b 43 04             	mov    0x4(%ebx),%eax
     314:	89 04 24             	mov    %eax,(%esp)
     317:	e8 64 fe ff ff       	call   180 <runcmd>

0000031c <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     31c:	55                   	push   %ebp
     31d:	89 e5                	mov    %esp,%ebp
     31f:	53                   	push   %ebx
     320:	83 ec 14             	sub    $0x14,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     323:	c7 04 24 54 00 00 00 	movl   $0x54,(%esp)
     32a:	e8 55 0d 00 00       	call   1084 <malloc>
     32f:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     331:	c7 44 24 08 54 00 00 	movl   $0x54,0x8(%esp)
     338:	00 
     339:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     340:	00 
     341:	89 04 24             	mov    %eax,(%esp)
     344:	e8 33 08 00 00       	call   b7c <memset>
  cmd->type = EXEC;
     349:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
     34f:	89 d8                	mov    %ebx,%eax
     351:	83 c4 14             	add    $0x14,%esp
     354:	5b                   	pop    %ebx
     355:	5d                   	pop    %ebp
     356:	c3                   	ret    
     357:	90                   	nop

00000358 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     358:	55                   	push   %ebp
     359:	89 e5                	mov    %esp,%ebp
     35b:	53                   	push   %ebx
     35c:	83 ec 14             	sub    $0x14,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     35f:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
     366:	e8 19 0d 00 00       	call   1084 <malloc>
     36b:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     36d:	c7 44 24 08 18 00 00 	movl   $0x18,0x8(%esp)
     374:	00 
     375:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     37c:	00 
     37d:	89 04 24             	mov    %eax,(%esp)
     380:	e8 f7 07 00 00       	call   b7c <memset>
  cmd->type = REDIR;
     385:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     38b:	8b 45 08             	mov    0x8(%ebp),%eax
     38e:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     391:	8b 45 0c             	mov    0xc(%ebp),%eax
     394:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     397:	8b 45 10             	mov    0x10(%ebp),%eax
     39a:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     39d:	8b 45 14             	mov    0x14(%ebp),%eax
     3a0:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     3a3:	8b 45 18             	mov    0x18(%ebp),%eax
     3a6:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     3a9:	89 d8                	mov    %ebx,%eax
     3ab:	83 c4 14             	add    $0x14,%esp
     3ae:	5b                   	pop    %ebx
     3af:	5d                   	pop    %ebp
     3b0:	c3                   	ret    
     3b1:	8d 76 00             	lea    0x0(%esi),%esi

000003b4 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     3b4:	55                   	push   %ebp
     3b5:	89 e5                	mov    %esp,%ebp
     3b7:	53                   	push   %ebx
     3b8:	83 ec 14             	sub    $0x14,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3bb:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     3c2:	e8 bd 0c 00 00       	call   1084 <malloc>
     3c7:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3c9:	c7 44 24 08 0c 00 00 	movl   $0xc,0x8(%esp)
     3d0:	00 
     3d1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     3d8:	00 
     3d9:	89 04 24             	mov    %eax,(%esp)
     3dc:	e8 9b 07 00 00       	call   b7c <memset>
  cmd->type = PIPE;
     3e1:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     3e7:	8b 45 08             	mov    0x8(%ebp),%eax
     3ea:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     3ed:	8b 45 0c             	mov    0xc(%ebp),%eax
     3f0:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     3f3:	89 d8                	mov    %ebx,%eax
     3f5:	83 c4 14             	add    $0x14,%esp
     3f8:	5b                   	pop    %ebx
     3f9:	5d                   	pop    %ebp
     3fa:	c3                   	ret    
     3fb:	90                   	nop

000003fc <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     3fc:	55                   	push   %ebp
     3fd:	89 e5                	mov    %esp,%ebp
     3ff:	53                   	push   %ebx
     400:	83 ec 14             	sub    $0x14,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     403:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     40a:	e8 75 0c 00 00       	call   1084 <malloc>
     40f:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     411:	c7 44 24 08 0c 00 00 	movl   $0xc,0x8(%esp)
     418:	00 
     419:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     420:	00 
     421:	89 04 24             	mov    %eax,(%esp)
     424:	e8 53 07 00 00       	call   b7c <memset>
  cmd->type = LIST;
     429:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     42f:	8b 45 08             	mov    0x8(%ebp),%eax
     432:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     435:	8b 45 0c             	mov    0xc(%ebp),%eax
     438:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     43b:	89 d8                	mov    %ebx,%eax
     43d:	83 c4 14             	add    $0x14,%esp
     440:	5b                   	pop    %ebx
     441:	5d                   	pop    %ebp
     442:	c3                   	ret    
     443:	90                   	nop

00000444 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     444:	55                   	push   %ebp
     445:	89 e5                	mov    %esp,%ebp
     447:	53                   	push   %ebx
     448:	83 ec 14             	sub    $0x14,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     44b:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     452:	e8 2d 0c 00 00       	call   1084 <malloc>
     457:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     459:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
     460:	00 
     461:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     468:	00 
     469:	89 04 24             	mov    %eax,(%esp)
     46c:	e8 0b 07 00 00       	call   b7c <memset>
  cmd->type = BACK;
     471:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     477:	8b 45 08             	mov    0x8(%ebp),%eax
     47a:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     47d:	89 d8                	mov    %ebx,%eax
     47f:	83 c4 14             	add    $0x14,%esp
     482:	5b                   	pop    %ebx
     483:	5d                   	pop    %ebp
     484:	c3                   	ret    
     485:	8d 76 00             	lea    0x0(%esi),%esi

00000488 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     488:	55                   	push   %ebp
     489:	89 e5                	mov    %esp,%ebp
     48b:	57                   	push   %edi
     48c:	56                   	push   %esi
     48d:	53                   	push   %ebx
     48e:	83 ec 1c             	sub    $0x1c,%esp
     491:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     494:	8b 75 10             	mov    0x10(%ebp),%esi
  char *s;
  int ret;

  s = *ps;
     497:	8b 45 08             	mov    0x8(%ebp),%eax
     49a:	8b 38                	mov    (%eax),%edi
  while(s < es && strchr(whitespace, *s))
     49c:	39 df                	cmp    %ebx,%edi
     49e:	72 09                	jb     4a9 <gettoken+0x21>
     4a0:	eb 1e                	jmp    4c0 <gettoken+0x38>
     4a2:	66 90                	xchg   %ax,%ax
    s++;
     4a4:	47                   	inc    %edi
  while(s < es && strchr(whitespace, *s))
     4a5:	39 df                	cmp    %ebx,%edi
     4a7:	74 17                	je     4c0 <gettoken+0x38>
     4a9:	0f be 07             	movsbl (%edi),%eax
     4ac:	89 44 24 04          	mov    %eax,0x4(%esp)
     4b0:	c7 04 24 18 18 00 00 	movl   $0x1818,(%esp)
     4b7:	e8 d8 06 00 00       	call   b94 <strchr>
     4bc:	85 c0                	test   %eax,%eax
     4be:	75 e4                	jne    4a4 <gettoken+0x1c>
  if(q)
     4c0:	85 f6                	test   %esi,%esi
     4c2:	74 02                	je     4c6 <gettoken+0x3e>
    *q = s;
     4c4:	89 3e                	mov    %edi,(%esi)
  ret = *s;
     4c6:	8a 0f                	mov    (%edi),%cl
     4c8:	0f be f1             	movsbl %cl,%esi
     4cb:	89 f0                	mov    %esi,%eax
  switch(*s){
     4cd:	80 f9 3c             	cmp    $0x3c,%cl
     4d0:	7f 4a                	jg     51c <gettoken+0x94>
     4d2:	80 f9 3b             	cmp    $0x3b,%cl
     4d5:	0f 8c 91 00 00 00    	jl     56c <gettoken+0xe4>
  case '&':
  case '<':
    s++;
    break;
  case '>':
    s++;
     4db:	47                   	inc    %edi
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     4dc:	8b 45 14             	mov    0x14(%ebp),%eax
     4df:	85 c0                	test   %eax,%eax
     4e1:	74 05                	je     4e8 <gettoken+0x60>
    *eq = s;
     4e3:	8b 45 14             	mov    0x14(%ebp),%eax
     4e6:	89 38                	mov    %edi,(%eax)

  while(s < es && strchr(whitespace, *s))
     4e8:	39 df                	cmp    %ebx,%edi
     4ea:	72 09                	jb     4f5 <gettoken+0x6d>
     4ec:	eb 1e                	jmp    50c <gettoken+0x84>
     4ee:	66 90                	xchg   %ax,%ax
    s++;
     4f0:	47                   	inc    %edi
  while(s < es && strchr(whitespace, *s))
     4f1:	39 df                	cmp    %ebx,%edi
     4f3:	74 17                	je     50c <gettoken+0x84>
     4f5:	0f be 07             	movsbl (%edi),%eax
     4f8:	89 44 24 04          	mov    %eax,0x4(%esp)
     4fc:	c7 04 24 18 18 00 00 	movl   $0x1818,(%esp)
     503:	e8 8c 06 00 00       	call   b94 <strchr>
     508:	85 c0                	test   %eax,%eax
     50a:	75 e4                	jne    4f0 <gettoken+0x68>
  *ps = s;
     50c:	8b 45 08             	mov    0x8(%ebp),%eax
     50f:	89 38                	mov    %edi,(%eax)
  return ret;
}
     511:	89 f0                	mov    %esi,%eax
     513:	83 c4 1c             	add    $0x1c,%esp
     516:	5b                   	pop    %ebx
     517:	5e                   	pop    %esi
     518:	5f                   	pop    %edi
     519:	5d                   	pop    %ebp
     51a:	c3                   	ret    
     51b:	90                   	nop
  switch(*s){
     51c:	80 f9 3e             	cmp    $0x3e,%cl
     51f:	74 6b                	je     58c <gettoken+0x104>
     521:	80 f9 7c             	cmp    $0x7c,%cl
     524:	74 b5                	je     4db <gettoken+0x53>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     526:	39 fb                	cmp    %edi,%ebx
     528:	77 21                	ja     54b <gettoken+0xc3>
     52a:	eb 33                	jmp    55f <gettoken+0xd7>
     52c:	0f be 07             	movsbl (%edi),%eax
     52f:	89 44 24 04          	mov    %eax,0x4(%esp)
     533:	c7 04 24 10 18 00 00 	movl   $0x1810,(%esp)
     53a:	e8 55 06 00 00       	call   b94 <strchr>
     53f:	85 c0                	test   %eax,%eax
     541:	75 1c                	jne    55f <gettoken+0xd7>
      s++;
     543:	47                   	inc    %edi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     544:	39 df                	cmp    %ebx,%edi
     546:	74 17                	je     55f <gettoken+0xd7>
     548:	0f be 07             	movsbl (%edi),%eax
     54b:	89 44 24 04          	mov    %eax,0x4(%esp)
     54f:	c7 04 24 18 18 00 00 	movl   $0x1818,(%esp)
     556:	e8 39 06 00 00       	call   b94 <strchr>
     55b:	85 c0                	test   %eax,%eax
     55d:	74 cd                	je     52c <gettoken+0xa4>
    ret = 'a';
     55f:	be 61 00 00 00       	mov    $0x61,%esi
     564:	e9 73 ff ff ff       	jmp    4dc <gettoken+0x54>
     569:	8d 76 00             	lea    0x0(%esi),%esi
  switch(*s){
     56c:	80 f9 29             	cmp    $0x29,%cl
     56f:	7f b5                	jg     526 <gettoken+0x9e>
     571:	80 f9 28             	cmp    $0x28,%cl
     574:	0f 8d 61 ff ff ff    	jge    4db <gettoken+0x53>
     57a:	84 c9                	test   %cl,%cl
     57c:	0f 84 5a ff ff ff    	je     4dc <gettoken+0x54>
     582:	80 f9 26             	cmp    $0x26,%cl
     585:	75 9f                	jne    526 <gettoken+0x9e>
     587:	e9 4f ff ff ff       	jmp    4db <gettoken+0x53>
    if(*s == '>'){
     58c:	80 7f 01 3e          	cmpb   $0x3e,0x1(%edi)
     590:	0f 85 45 ff ff ff    	jne    4db <gettoken+0x53>
      s++;
     596:	83 c7 02             	add    $0x2,%edi
      ret = '+';
     599:	be 2b 00 00 00       	mov    $0x2b,%esi
     59e:	e9 39 ff ff ff       	jmp    4dc <gettoken+0x54>
     5a3:	90                   	nop

000005a4 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     5a4:	55                   	push   %ebp
     5a5:	89 e5                	mov    %esp,%ebp
     5a7:	57                   	push   %edi
     5a8:	56                   	push   %esi
     5a9:	53                   	push   %ebx
     5aa:	83 ec 1c             	sub    $0x1c,%esp
     5ad:	8b 7d 08             	mov    0x8(%ebp),%edi
     5b0:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
     5b3:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     5b5:	39 f3                	cmp    %esi,%ebx
     5b7:	72 08                	jb     5c1 <peek+0x1d>
     5b9:	eb 1d                	jmp    5d8 <peek+0x34>
     5bb:	90                   	nop
    s++;
     5bc:	43                   	inc    %ebx
  while(s < es && strchr(whitespace, *s))
     5bd:	39 f3                	cmp    %esi,%ebx
     5bf:	74 17                	je     5d8 <peek+0x34>
     5c1:	0f be 03             	movsbl (%ebx),%eax
     5c4:	89 44 24 04          	mov    %eax,0x4(%esp)
     5c8:	c7 04 24 18 18 00 00 	movl   $0x1818,(%esp)
     5cf:	e8 c0 05 00 00       	call   b94 <strchr>
     5d4:	85 c0                	test   %eax,%eax
     5d6:	75 e4                	jne    5bc <peek+0x18>
  *ps = s;
     5d8:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     5da:	0f be 03             	movsbl (%ebx),%eax
     5dd:	84 c0                	test   %al,%al
     5df:	75 0b                	jne    5ec <peek+0x48>
     5e1:	31 c0                	xor    %eax,%eax
}
     5e3:	83 c4 1c             	add    $0x1c,%esp
     5e6:	5b                   	pop    %ebx
     5e7:	5e                   	pop    %esi
     5e8:	5f                   	pop    %edi
     5e9:	5d                   	pop    %ebp
     5ea:	c3                   	ret    
     5eb:	90                   	nop
  return *s && strchr(toks, *s);
     5ec:	89 44 24 04          	mov    %eax,0x4(%esp)
     5f0:	8b 45 10             	mov    0x10(%ebp),%eax
     5f3:	89 04 24             	mov    %eax,(%esp)
     5f6:	e8 99 05 00 00       	call   b94 <strchr>
     5fb:	85 c0                	test   %eax,%eax
     5fd:	0f 95 c0             	setne  %al
     600:	0f b6 c0             	movzbl %al,%eax
}
     603:	83 c4 1c             	add    $0x1c,%esp
     606:	5b                   	pop    %ebx
     607:	5e                   	pop    %esi
     608:	5f                   	pop    %edi
     609:	5d                   	pop    %ebp
     60a:	c3                   	ret    
     60b:	90                   	nop

0000060c <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     60c:	55                   	push   %ebp
     60d:	89 e5                	mov    %esp,%ebp
     60f:	57                   	push   %edi
     610:	56                   	push   %esi
     611:	53                   	push   %ebx
     612:	83 ec 3c             	sub    $0x3c,%esp
     615:	8b 75 0c             	mov    0xc(%ebp),%esi
     618:	8b 5d 10             	mov    0x10(%ebp),%ebx
     61b:	90                   	nop
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     61c:	c7 44 24 08 ad 11 00 	movl   $0x11ad,0x8(%esp)
     623:	00 
     624:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     628:	89 34 24             	mov    %esi,(%esp)
     62b:	e8 74 ff ff ff       	call   5a4 <peek>
     630:	85 c0                	test   %eax,%eax
     632:	0f 84 94 00 00 00    	je     6cc <parseredirs+0xc0>
    tok = gettoken(ps, es, 0, 0);
     638:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     63f:	00 
     640:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     647:	00 
     648:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     64c:	89 34 24             	mov    %esi,(%esp)
     64f:	e8 34 fe ff ff       	call   488 <gettoken>
     654:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
     656:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     659:	89 44 24 0c          	mov    %eax,0xc(%esp)
     65d:	8d 45 e0             	lea    -0x20(%ebp),%eax
     660:	89 44 24 08          	mov    %eax,0x8(%esp)
     664:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     668:	89 34 24             	mov    %esi,(%esp)
     66b:	e8 18 fe ff ff       	call   488 <gettoken>
     670:	83 f8 61             	cmp    $0x61,%eax
     673:	75 62                	jne    6d7 <parseredirs+0xcb>
      panic("missing file for redirection");
    switch(tok){
     675:	83 ff 3c             	cmp    $0x3c,%edi
     678:	74 3e                	je     6b8 <parseredirs+0xac>
     67a:	83 ff 3e             	cmp    $0x3e,%edi
     67d:	74 05                	je     684 <parseredirs+0x78>
     67f:	83 ff 2b             	cmp    $0x2b,%edi
     682:	75 98                	jne    61c <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     684:	c7 44 24 10 01 00 00 	movl   $0x1,0x10(%esp)
     68b:	00 
     68c:	c7 44 24 0c 01 02 00 	movl   $0x201,0xc(%esp)
     693:	00 
     694:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     697:	89 44 24 08          	mov    %eax,0x8(%esp)
     69b:	8b 45 e0             	mov    -0x20(%ebp),%eax
     69e:	89 44 24 04          	mov    %eax,0x4(%esp)
     6a2:	8b 45 08             	mov    0x8(%ebp),%eax
     6a5:	89 04 24             	mov    %eax,(%esp)
     6a8:	e8 ab fc ff ff       	call   358 <redircmd>
     6ad:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     6b0:	e9 67 ff ff ff       	jmp    61c <parseredirs+0x10>
     6b5:	8d 76 00             	lea    0x0(%esi),%esi
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     6b8:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
     6bf:	00 
     6c0:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     6c7:	00 
     6c8:	eb ca                	jmp    694 <parseredirs+0x88>
     6ca:	66 90                	xchg   %ax,%ax
    }
  }
  return cmd;
}
     6cc:	8b 45 08             	mov    0x8(%ebp),%eax
     6cf:	83 c4 3c             	add    $0x3c,%esp
     6d2:	5b                   	pop    %ebx
     6d3:	5e                   	pop    %esi
     6d4:	5f                   	pop    %edi
     6d5:	5d                   	pop    %ebp
     6d6:	c3                   	ret    
      panic("missing file for redirection");
     6d7:	c7 04 24 90 11 00 00 	movl   $0x1190,(%esp)
     6de:	e8 55 fa ff ff       	call   138 <panic>
     6e3:	90                   	nop

000006e4 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     6e4:	55                   	push   %ebp
     6e5:	89 e5                	mov    %esp,%ebp
     6e7:	57                   	push   %edi
     6e8:	56                   	push   %esi
     6e9:	53                   	push   %ebx
     6ea:	83 ec 3c             	sub    $0x3c,%esp
     6ed:	8b 75 08             	mov    0x8(%ebp),%esi
     6f0:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     6f3:	c7 44 24 08 b0 11 00 	movl   $0x11b0,0x8(%esp)
     6fa:	00 
     6fb:	89 7c 24 04          	mov    %edi,0x4(%esp)
     6ff:	89 34 24             	mov    %esi,(%esp)
     702:	e8 9d fe ff ff       	call   5a4 <peek>
     707:	85 c0                	test   %eax,%eax
     709:	0f 85 a1 00 00 00    	jne    7b0 <parseexec+0xcc>
    return parseblock(ps, es);

  ret = execcmd();
     70f:	e8 08 fc ff ff       	call   31c <execcmd>
     714:	89 45 cc             	mov    %eax,-0x34(%ebp)
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     717:	89 7c 24 08          	mov    %edi,0x8(%esp)
     71b:	89 74 24 04          	mov    %esi,0x4(%esp)
     71f:	89 04 24             	mov    %eax,(%esp)
     722:	e8 e5 fe ff ff       	call   60c <parseredirs>
     727:	89 45 d0             	mov    %eax,-0x30(%ebp)
     72a:	8b 5d cc             	mov    -0x34(%ebp),%ebx
  argc = 0;
     72d:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     734:	eb 18                	jmp    74e <parseexec+0x6a>
     736:	66 90                	xchg   %ax,%ax
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     738:	89 7c 24 08          	mov    %edi,0x8(%esp)
     73c:	89 74 24 04          	mov    %esi,0x4(%esp)
     740:	8b 45 d0             	mov    -0x30(%ebp),%eax
     743:	89 04 24             	mov    %eax,(%esp)
     746:	e8 c1 fe ff ff       	call   60c <parseredirs>
     74b:	89 45 d0             	mov    %eax,-0x30(%ebp)
  while(!peek(ps, es, "|)&;")){
     74e:	c7 44 24 08 c7 11 00 	movl   $0x11c7,0x8(%esp)
     755:	00 
     756:	89 7c 24 04          	mov    %edi,0x4(%esp)
     75a:	89 34 24             	mov    %esi,(%esp)
     75d:	e8 42 fe ff ff       	call   5a4 <peek>
     762:	85 c0                	test   %eax,%eax
     764:	75 66                	jne    7cc <parseexec+0xe8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     766:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     769:	89 44 24 0c          	mov    %eax,0xc(%esp)
     76d:	8d 55 e0             	lea    -0x20(%ebp),%edx
     770:	89 54 24 08          	mov    %edx,0x8(%esp)
     774:	89 7c 24 04          	mov    %edi,0x4(%esp)
     778:	89 34 24             	mov    %esi,(%esp)
     77b:	e8 08 fd ff ff       	call   488 <gettoken>
     780:	85 c0                	test   %eax,%eax
     782:	74 48                	je     7cc <parseexec+0xe8>
    if(tok != 'a')
     784:	83 f8 61             	cmp    $0x61,%eax
     787:	75 64                	jne    7ed <parseexec+0x109>
    cmd->argv[argc] = q;
     789:	8b 45 e0             	mov    -0x20(%ebp),%eax
     78c:	89 43 04             	mov    %eax,0x4(%ebx)
    cmd->eargv[argc] = eq;
     78f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     792:	89 43 2c             	mov    %eax,0x2c(%ebx)
    argc++;
     795:	ff 45 d4             	incl   -0x2c(%ebp)
     798:	83 c3 04             	add    $0x4,%ebx
    if(argc >= MAXARGS)
     79b:	83 7d d4 0a          	cmpl   $0xa,-0x2c(%ebp)
     79f:	75 97                	jne    738 <parseexec+0x54>
      panic("too many args");
     7a1:	c7 04 24 b9 11 00 00 	movl   $0x11b9,(%esp)
     7a8:	e8 8b f9 ff ff       	call   138 <panic>
     7ad:	8d 76 00             	lea    0x0(%esi),%esi
    return parseblock(ps, es);
     7b0:	89 7c 24 04          	mov    %edi,0x4(%esp)
     7b4:	89 34 24             	mov    %esi,(%esp)
     7b7:	e8 78 01 00 00       	call   934 <parseblock>
     7bc:	89 45 d0             	mov    %eax,-0x30(%ebp)
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     7bf:	8b 45 d0             	mov    -0x30(%ebp),%eax
     7c2:	83 c4 3c             	add    $0x3c,%esp
     7c5:	5b                   	pop    %ebx
     7c6:	5e                   	pop    %esi
     7c7:	5f                   	pop    %edi
     7c8:	5d                   	pop    %ebp
     7c9:	c3                   	ret    
     7ca:	66 90                	xchg   %ax,%ax
  cmd->argv[argc] = 0;
     7cc:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     7cf:	8b 45 cc             	mov    -0x34(%ebp),%eax
     7d2:	c7 44 90 04 00 00 00 	movl   $0x0,0x4(%eax,%edx,4)
     7d9:	00 
  cmd->eargv[argc] = 0;
     7da:	c7 44 90 2c 00 00 00 	movl   $0x0,0x2c(%eax,%edx,4)
     7e1:	00 
}
     7e2:	8b 45 d0             	mov    -0x30(%ebp),%eax
     7e5:	83 c4 3c             	add    $0x3c,%esp
     7e8:	5b                   	pop    %ebx
     7e9:	5e                   	pop    %esi
     7ea:	5f                   	pop    %edi
     7eb:	5d                   	pop    %ebp
     7ec:	c3                   	ret    
      panic("syntax");
     7ed:	c7 04 24 b2 11 00 00 	movl   $0x11b2,(%esp)
     7f4:	e8 3f f9 ff ff       	call   138 <panic>
     7f9:	8d 76 00             	lea    0x0(%esi),%esi

000007fc <parsepipe>:
{
     7fc:	55                   	push   %ebp
     7fd:	89 e5                	mov    %esp,%ebp
     7ff:	57                   	push   %edi
     800:	56                   	push   %esi
     801:	53                   	push   %ebx
     802:	83 ec 1c             	sub    $0x1c,%esp
     805:	8b 5d 08             	mov    0x8(%ebp),%ebx
     808:	8b 75 0c             	mov    0xc(%ebp),%esi
  cmd = parseexec(ps, es);
     80b:	89 74 24 04          	mov    %esi,0x4(%esp)
     80f:	89 1c 24             	mov    %ebx,(%esp)
     812:	e8 cd fe ff ff       	call   6e4 <parseexec>
     817:	89 c7                	mov    %eax,%edi
  if(peek(ps, es, "|")){
     819:	c7 44 24 08 cc 11 00 	movl   $0x11cc,0x8(%esp)
     820:	00 
     821:	89 74 24 04          	mov    %esi,0x4(%esp)
     825:	89 1c 24             	mov    %ebx,(%esp)
     828:	e8 77 fd ff ff       	call   5a4 <peek>
     82d:	85 c0                	test   %eax,%eax
     82f:	75 0b                	jne    83c <parsepipe+0x40>
}
     831:	89 f8                	mov    %edi,%eax
     833:	83 c4 1c             	add    $0x1c,%esp
     836:	5b                   	pop    %ebx
     837:	5e                   	pop    %esi
     838:	5f                   	pop    %edi
     839:	5d                   	pop    %ebp
     83a:	c3                   	ret    
     83b:	90                   	nop
    gettoken(ps, es, 0, 0);
     83c:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     843:	00 
     844:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     84b:	00 
     84c:	89 74 24 04          	mov    %esi,0x4(%esp)
     850:	89 1c 24             	mov    %ebx,(%esp)
     853:	e8 30 fc ff ff       	call   488 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     858:	89 74 24 04          	mov    %esi,0x4(%esp)
     85c:	89 1c 24             	mov    %ebx,(%esp)
     85f:	e8 98 ff ff ff       	call   7fc <parsepipe>
     864:	89 45 0c             	mov    %eax,0xc(%ebp)
     867:	89 7d 08             	mov    %edi,0x8(%ebp)
}
     86a:	83 c4 1c             	add    $0x1c,%esp
     86d:	5b                   	pop    %ebx
     86e:	5e                   	pop    %esi
     86f:	5f                   	pop    %edi
     870:	5d                   	pop    %ebp
    cmd = pipecmd(cmd, parsepipe(ps, es));
     871:	e9 3e fb ff ff       	jmp    3b4 <pipecmd>
     876:	66 90                	xchg   %ax,%ax

00000878 <parseline>:
{
     878:	55                   	push   %ebp
     879:	89 e5                	mov    %esp,%ebp
     87b:	57                   	push   %edi
     87c:	56                   	push   %esi
     87d:	53                   	push   %ebx
     87e:	83 ec 1c             	sub    $0x1c,%esp
     881:	8b 5d 08             	mov    0x8(%ebp),%ebx
     884:	8b 75 0c             	mov    0xc(%ebp),%esi
  cmd = parsepipe(ps, es);
     887:	89 74 24 04          	mov    %esi,0x4(%esp)
     88b:	89 1c 24             	mov    %ebx,(%esp)
     88e:	e8 69 ff ff ff       	call   7fc <parsepipe>
     893:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
     895:	eb 27                	jmp    8be <parseline+0x46>
     897:	90                   	nop
    gettoken(ps, es, 0, 0);
     898:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     89f:	00 
     8a0:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     8a7:	00 
     8a8:	89 74 24 04          	mov    %esi,0x4(%esp)
     8ac:	89 1c 24             	mov    %ebx,(%esp)
     8af:	e8 d4 fb ff ff       	call   488 <gettoken>
    cmd = backcmd(cmd);
     8b4:	89 3c 24             	mov    %edi,(%esp)
     8b7:	e8 88 fb ff ff       	call   444 <backcmd>
     8bc:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
     8be:	c7 44 24 08 ce 11 00 	movl   $0x11ce,0x8(%esp)
     8c5:	00 
     8c6:	89 74 24 04          	mov    %esi,0x4(%esp)
     8ca:	89 1c 24             	mov    %ebx,(%esp)
     8cd:	e8 d2 fc ff ff       	call   5a4 <peek>
     8d2:	85 c0                	test   %eax,%eax
     8d4:	75 c2                	jne    898 <parseline+0x20>
  if(peek(ps, es, ";")){
     8d6:	c7 44 24 08 ca 11 00 	movl   $0x11ca,0x8(%esp)
     8dd:	00 
     8de:	89 74 24 04          	mov    %esi,0x4(%esp)
     8e2:	89 1c 24             	mov    %ebx,(%esp)
     8e5:	e8 ba fc ff ff       	call   5a4 <peek>
     8ea:	85 c0                	test   %eax,%eax
     8ec:	75 0a                	jne    8f8 <parseline+0x80>
}
     8ee:	89 f8                	mov    %edi,%eax
     8f0:	83 c4 1c             	add    $0x1c,%esp
     8f3:	5b                   	pop    %ebx
     8f4:	5e                   	pop    %esi
     8f5:	5f                   	pop    %edi
     8f6:	5d                   	pop    %ebp
     8f7:	c3                   	ret    
    gettoken(ps, es, 0, 0);
     8f8:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     8ff:	00 
     900:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     907:	00 
     908:	89 74 24 04          	mov    %esi,0x4(%esp)
     90c:	89 1c 24             	mov    %ebx,(%esp)
     90f:	e8 74 fb ff ff       	call   488 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     914:	89 74 24 04          	mov    %esi,0x4(%esp)
     918:	89 1c 24             	mov    %ebx,(%esp)
     91b:	e8 58 ff ff ff       	call   878 <parseline>
     920:	89 45 0c             	mov    %eax,0xc(%ebp)
     923:	89 7d 08             	mov    %edi,0x8(%ebp)
}
     926:	83 c4 1c             	add    $0x1c,%esp
     929:	5b                   	pop    %ebx
     92a:	5e                   	pop    %esi
     92b:	5f                   	pop    %edi
     92c:	5d                   	pop    %ebp
    cmd = listcmd(cmd, parseline(ps, es));
     92d:	e9 ca fa ff ff       	jmp    3fc <listcmd>
     932:	66 90                	xchg   %ax,%ax

00000934 <parseblock>:
{
     934:	55                   	push   %ebp
     935:	89 e5                	mov    %esp,%ebp
     937:	57                   	push   %edi
     938:	56                   	push   %esi
     939:	53                   	push   %ebx
     93a:	83 ec 1c             	sub    $0x1c,%esp
     93d:	8b 5d 08             	mov    0x8(%ebp),%ebx
     940:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(!peek(ps, es, "("))
     943:	c7 44 24 08 b0 11 00 	movl   $0x11b0,0x8(%esp)
     94a:	00 
     94b:	89 74 24 04          	mov    %esi,0x4(%esp)
     94f:	89 1c 24             	mov    %ebx,(%esp)
     952:	e8 4d fc ff ff       	call   5a4 <peek>
     957:	85 c0                	test   %eax,%eax
     959:	74 76                	je     9d1 <parseblock+0x9d>
  gettoken(ps, es, 0, 0);
     95b:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     962:	00 
     963:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     96a:	00 
     96b:	89 74 24 04          	mov    %esi,0x4(%esp)
     96f:	89 1c 24             	mov    %ebx,(%esp)
     972:	e8 11 fb ff ff       	call   488 <gettoken>
  cmd = parseline(ps, es);
     977:	89 74 24 04          	mov    %esi,0x4(%esp)
     97b:	89 1c 24             	mov    %ebx,(%esp)
     97e:	e8 f5 fe ff ff       	call   878 <parseline>
     983:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     985:	c7 44 24 08 ec 11 00 	movl   $0x11ec,0x8(%esp)
     98c:	00 
     98d:	89 74 24 04          	mov    %esi,0x4(%esp)
     991:	89 1c 24             	mov    %ebx,(%esp)
     994:	e8 0b fc ff ff       	call   5a4 <peek>
     999:	85 c0                	test   %eax,%eax
     99b:	74 40                	je     9dd <parseblock+0xa9>
  gettoken(ps, es, 0, 0);
     99d:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     9a4:	00 
     9a5:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     9ac:	00 
     9ad:	89 74 24 04          	mov    %esi,0x4(%esp)
     9b1:	89 1c 24             	mov    %ebx,(%esp)
     9b4:	e8 cf fa ff ff       	call   488 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     9b9:	89 74 24 08          	mov    %esi,0x8(%esp)
     9bd:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     9c1:	89 3c 24             	mov    %edi,(%esp)
     9c4:	e8 43 fc ff ff       	call   60c <parseredirs>
}
     9c9:	83 c4 1c             	add    $0x1c,%esp
     9cc:	5b                   	pop    %ebx
     9cd:	5e                   	pop    %esi
     9ce:	5f                   	pop    %edi
     9cf:	5d                   	pop    %ebp
     9d0:	c3                   	ret    
    panic("parseblock");
     9d1:	c7 04 24 d0 11 00 00 	movl   $0x11d0,(%esp)
     9d8:	e8 5b f7 ff ff       	call   138 <panic>
    panic("syntax - missing )");
     9dd:	c7 04 24 db 11 00 00 	movl   $0x11db,(%esp)
     9e4:	e8 4f f7 ff ff       	call   138 <panic>
     9e9:	8d 76 00             	lea    0x0(%esi),%esi

000009ec <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     9ec:	55                   	push   %ebp
     9ed:	89 e5                	mov    %esp,%ebp
     9ef:	53                   	push   %ebx
     9f0:	83 ec 14             	sub    $0x14,%esp
     9f3:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     9f6:	85 db                	test   %ebx,%ebx
     9f8:	74 05                	je     9ff <nulterminate+0x13>
    return 0;

  switch(cmd->type){
     9fa:	83 3b 05             	cmpl   $0x5,(%ebx)
     9fd:	76 09                	jbe    a08 <nulterminate+0x1c>
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     9ff:	89 d8                	mov    %ebx,%eax
     a01:	83 c4 14             	add    $0x14,%esp
     a04:	5b                   	pop    %ebx
     a05:	5d                   	pop    %ebp
     a06:	c3                   	ret    
     a07:	90                   	nop
  switch(cmd->type){
     a08:	8b 03                	mov    (%ebx),%eax
     a0a:	ff 24 85 2c 12 00 00 	jmp    *0x122c(,%eax,4)
     a11:	8d 76 00             	lea    0x0(%esi),%esi
    nulterminate(lcmd->left);
     a14:	8b 43 04             	mov    0x4(%ebx),%eax
     a17:	89 04 24             	mov    %eax,(%esp)
     a1a:	e8 cd ff ff ff       	call   9ec <nulterminate>
    nulterminate(lcmd->right);
     a1f:	8b 43 08             	mov    0x8(%ebx),%eax
     a22:	89 04 24             	mov    %eax,(%esp)
     a25:	e8 c2 ff ff ff       	call   9ec <nulterminate>
}
     a2a:	89 d8                	mov    %ebx,%eax
     a2c:	83 c4 14             	add    $0x14,%esp
     a2f:	5b                   	pop    %ebx
     a30:	5d                   	pop    %ebp
     a31:	c3                   	ret    
     a32:	66 90                	xchg   %ax,%ax
    nulterminate(bcmd->cmd);
     a34:	8b 43 04             	mov    0x4(%ebx),%eax
     a37:	89 04 24             	mov    %eax,(%esp)
     a3a:	e8 ad ff ff ff       	call   9ec <nulterminate>
}
     a3f:	89 d8                	mov    %ebx,%eax
     a41:	83 c4 14             	add    $0x14,%esp
     a44:	5b                   	pop    %ebx
     a45:	5d                   	pop    %ebp
     a46:	c3                   	ret    
     a47:	90                   	nop
    nulterminate(rcmd->cmd);
     a48:	8b 43 04             	mov    0x4(%ebx),%eax
     a4b:	89 04 24             	mov    %eax,(%esp)
     a4e:	e8 99 ff ff ff       	call   9ec <nulterminate>
    *rcmd->efile = 0;
     a53:	8b 43 0c             	mov    0xc(%ebx),%eax
     a56:	c6 00 00             	movb   $0x0,(%eax)
}
     a59:	89 d8                	mov    %ebx,%eax
     a5b:	83 c4 14             	add    $0x14,%esp
     a5e:	5b                   	pop    %ebx
     a5f:	5d                   	pop    %ebp
     a60:	c3                   	ret    
     a61:	8d 76 00             	lea    0x0(%esi),%esi
     a64:	89 da                	mov    %ebx,%edx
    for(i=0; ecmd->argv[i]; i++)
     a66:	8b 43 04             	mov    0x4(%ebx),%eax
     a69:	85 c0                	test   %eax,%eax
     a6b:	74 92                	je     9ff <nulterminate+0x13>
     a6d:	8d 76 00             	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
     a70:	8b 42 2c             	mov    0x2c(%edx),%eax
     a73:	c6 00 00             	movb   $0x0,(%eax)
     a76:	83 c2 04             	add    $0x4,%edx
    for(i=0; ecmd->argv[i]; i++)
     a79:	8b 4a 04             	mov    0x4(%edx),%ecx
     a7c:	85 c9                	test   %ecx,%ecx
     a7e:	75 f0                	jne    a70 <nulterminate+0x84>
}
     a80:	89 d8                	mov    %ebx,%eax
     a82:	83 c4 14             	add    $0x14,%esp
     a85:	5b                   	pop    %ebx
     a86:	5d                   	pop    %ebp
     a87:	c3                   	ret    

00000a88 <parsecmd>:
{
     a88:	55                   	push   %ebp
     a89:	89 e5                	mov    %esp,%ebp
     a8b:	56                   	push   %esi
     a8c:	53                   	push   %ebx
     a8d:	83 ec 10             	sub    $0x10,%esp
  es = s + strlen(s);
     a90:	8b 5d 08             	mov    0x8(%ebp),%ebx
     a93:	89 1c 24             	mov    %ebx,(%esp)
     a96:	e8 c1 00 00 00       	call   b5c <strlen>
     a9b:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     a9d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     aa1:	8d 45 08             	lea    0x8(%ebp),%eax
     aa4:	89 04 24             	mov    %eax,(%esp)
     aa7:	e8 cc fd ff ff       	call   878 <parseline>
     aac:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     aae:	c7 44 24 08 7a 11 00 	movl   $0x117a,0x8(%esp)
     ab5:	00 
     ab6:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     aba:	8d 45 08             	lea    0x8(%ebp),%eax
     abd:	89 04 24             	mov    %eax,(%esp)
     ac0:	e8 df fa ff ff       	call   5a4 <peek>
  if(s != es){
     ac5:	8b 45 08             	mov    0x8(%ebp),%eax
     ac8:	39 d8                	cmp    %ebx,%eax
     aca:	75 11                	jne    add <parsecmd+0x55>
  nulterminate(cmd);
     acc:	89 34 24             	mov    %esi,(%esp)
     acf:	e8 18 ff ff ff       	call   9ec <nulterminate>
}
     ad4:	89 f0                	mov    %esi,%eax
     ad6:	83 c4 10             	add    $0x10,%esp
     ad9:	5b                   	pop    %ebx
     ada:	5e                   	pop    %esi
     adb:	5d                   	pop    %ebp
     adc:	c3                   	ret    
    printf(2, "leftovers: %s\n", s);
     add:	89 44 24 08          	mov    %eax,0x8(%esp)
     ae1:	c7 44 24 04 ee 11 00 	movl   $0x11ee,0x4(%esp)
     ae8:	00 
     ae9:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     af0:	e8 43 03 00 00       	call   e38 <printf>
    panic("syntax");
     af5:	c7 04 24 b2 11 00 00 	movl   $0x11b2,(%esp)
     afc:	e8 37 f6 ff ff       	call   138 <panic>
     b01:	66 90                	xchg   %ax,%ax
     b03:	90                   	nop

00000b04 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     b04:	55                   	push   %ebp
     b05:	89 e5                	mov    %esp,%ebp
     b07:	53                   	push   %ebx
     b08:	8b 45 08             	mov    0x8(%ebp),%eax
     b0b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     b0e:	89 c2                	mov    %eax,%edx
     b10:	8a 19                	mov    (%ecx),%bl
     b12:	88 1a                	mov    %bl,(%edx)
     b14:	42                   	inc    %edx
     b15:	41                   	inc    %ecx
     b16:	84 db                	test   %bl,%bl
     b18:	75 f6                	jne    b10 <strcpy+0xc>
    ;
  return os;
}
     b1a:	5b                   	pop    %ebx
     b1b:	5d                   	pop    %ebp
     b1c:	c3                   	ret    
     b1d:	8d 76 00             	lea    0x0(%esi),%esi

00000b20 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     b20:	55                   	push   %ebp
     b21:	89 e5                	mov    %esp,%ebp
     b23:	56                   	push   %esi
     b24:	53                   	push   %ebx
     b25:	8b 55 08             	mov    0x8(%ebp),%edx
     b28:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     b2b:	0f b6 02             	movzbl (%edx),%eax
     b2e:	0f b6 19             	movzbl (%ecx),%ebx
     b31:	84 c0                	test   %al,%al
     b33:	75 14                	jne    b49 <strcmp+0x29>
     b35:	eb 1d                	jmp    b54 <strcmp+0x34>
     b37:	90                   	nop
    p++, q++;
     b38:	42                   	inc    %edx
     b39:	8d 71 01             	lea    0x1(%ecx),%esi
  while(*p && *p == *q)
     b3c:	0f b6 02             	movzbl (%edx),%eax
     b3f:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
     b43:	84 c0                	test   %al,%al
     b45:	74 0d                	je     b54 <strcmp+0x34>
    p++, q++;
     b47:	89 f1                	mov    %esi,%ecx
  while(*p && *p == *q)
     b49:	38 d8                	cmp    %bl,%al
     b4b:	74 eb                	je     b38 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
     b4d:	29 d8                	sub    %ebx,%eax
}
     b4f:	5b                   	pop    %ebx
     b50:	5e                   	pop    %esi
     b51:	5d                   	pop    %ebp
     b52:	c3                   	ret    
     b53:	90                   	nop
  while(*p && *p == *q)
     b54:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
     b56:	29 d8                	sub    %ebx,%eax
}
     b58:	5b                   	pop    %ebx
     b59:	5e                   	pop    %esi
     b5a:	5d                   	pop    %ebp
     b5b:	c3                   	ret    

00000b5c <strlen>:

uint
strlen(char *s)
{
     b5c:	55                   	push   %ebp
     b5d:	89 e5                	mov    %esp,%ebp
     b5f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     b62:	80 39 00             	cmpb   $0x0,(%ecx)
     b65:	74 10                	je     b77 <strlen+0x1b>
     b67:	31 d2                	xor    %edx,%edx
     b69:	8d 76 00             	lea    0x0(%esi),%esi
     b6c:	42                   	inc    %edx
     b6d:	89 d0                	mov    %edx,%eax
     b6f:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     b73:	75 f7                	jne    b6c <strlen+0x10>
    ;
  return n;
}
     b75:	5d                   	pop    %ebp
     b76:	c3                   	ret    
  for(n = 0; s[n]; n++)
     b77:	31 c0                	xor    %eax,%eax
}
     b79:	5d                   	pop    %ebp
     b7a:	c3                   	ret    
     b7b:	90                   	nop

00000b7c <memset>:

void*
memset(void *dst, int c, uint n)
{
     b7c:	55                   	push   %ebp
     b7d:	89 e5                	mov    %esp,%ebp
     b7f:	57                   	push   %edi
     b80:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     b83:	89 d7                	mov    %edx,%edi
     b85:	8b 4d 10             	mov    0x10(%ebp),%ecx
     b88:	8b 45 0c             	mov    0xc(%ebp),%eax
     b8b:	fc                   	cld    
     b8c:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     b8e:	89 d0                	mov    %edx,%eax
     b90:	5f                   	pop    %edi
     b91:	5d                   	pop    %ebp
     b92:	c3                   	ret    
     b93:	90                   	nop

00000b94 <strchr>:

char*
strchr(const char *s, char c)
{
     b94:	55                   	push   %ebp
     b95:	89 e5                	mov    %esp,%ebp
     b97:	8b 45 08             	mov    0x8(%ebp),%eax
     b9a:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
     b9d:	8a 10                	mov    (%eax),%dl
     b9f:	84 d2                	test   %dl,%dl
     ba1:	75 0c                	jne    baf <strchr+0x1b>
     ba3:	eb 13                	jmp    bb8 <strchr+0x24>
     ba5:	8d 76 00             	lea    0x0(%esi),%esi
     ba8:	40                   	inc    %eax
     ba9:	8a 10                	mov    (%eax),%dl
     bab:	84 d2                	test   %dl,%dl
     bad:	74 09                	je     bb8 <strchr+0x24>
    if(*s == c)
     baf:	38 ca                	cmp    %cl,%dl
     bb1:	75 f5                	jne    ba8 <strchr+0x14>
      return (char*)s;
  return 0;
}
     bb3:	5d                   	pop    %ebp
     bb4:	c3                   	ret    
     bb5:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
     bb8:	31 c0                	xor    %eax,%eax
}
     bba:	5d                   	pop    %ebp
     bbb:	c3                   	ret    

00000bbc <gets>:

char*
gets(char *buf, int max)
{
     bbc:	55                   	push   %ebp
     bbd:	89 e5                	mov    %esp,%ebp
     bbf:	57                   	push   %edi
     bc0:	56                   	push   %esi
     bc1:	53                   	push   %ebx
     bc2:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     bc5:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
     bc7:	8d 7d e7             	lea    -0x19(%ebp),%edi
     bca:	66 90                	xchg   %ax,%ax
  for(i=0; i+1 < max; ){
     bcc:	8d 73 01             	lea    0x1(%ebx),%esi
     bcf:	3b 75 0c             	cmp    0xc(%ebp),%esi
     bd2:	7d 40                	jge    c14 <gets+0x58>
    cc = read(0, &c, 1);
     bd4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     bdb:	00 
     bdc:	89 7c 24 04          	mov    %edi,0x4(%esp)
     be0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     be7:	e8 fb 00 00 00       	call   ce7 <read>
    if(cc < 1)
     bec:	85 c0                	test   %eax,%eax
     bee:	7e 24                	jle    c14 <gets+0x58>
      break;
    buf[i++] = c;
     bf0:	8a 45 e7             	mov    -0x19(%ebp),%al
     bf3:	8b 55 08             	mov    0x8(%ebp),%edx
     bf6:	88 44 32 ff          	mov    %al,-0x1(%edx,%esi,1)
    if(c == '\n' || c == '\r')
     bfa:	3c 0a                	cmp    $0xa,%al
     bfc:	74 06                	je     c04 <gets+0x48>
     bfe:	89 f3                	mov    %esi,%ebx
     c00:	3c 0d                	cmp    $0xd,%al
     c02:	75 c8                	jne    bcc <gets+0x10>
      break;
  }
  buf[i] = '\0';
     c04:	8b 45 08             	mov    0x8(%ebp),%eax
     c07:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
     c0b:	83 c4 2c             	add    $0x2c,%esp
     c0e:	5b                   	pop    %ebx
     c0f:	5e                   	pop    %esi
     c10:	5f                   	pop    %edi
     c11:	5d                   	pop    %ebp
     c12:	c3                   	ret    
     c13:	90                   	nop
    if(cc < 1)
     c14:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
     c16:	8b 45 08             	mov    0x8(%ebp),%eax
     c19:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
     c1d:	83 c4 2c             	add    $0x2c,%esp
     c20:	5b                   	pop    %ebx
     c21:	5e                   	pop    %esi
     c22:	5f                   	pop    %edi
     c23:	5d                   	pop    %ebp
     c24:	c3                   	ret    
     c25:	8d 76 00             	lea    0x0(%esi),%esi

00000c28 <stat>:

int
stat(char *n, struct stat *st)
{
     c28:	55                   	push   %ebp
     c29:	89 e5                	mov    %esp,%ebp
     c2b:	56                   	push   %esi
     c2c:	53                   	push   %ebx
     c2d:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     c30:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     c37:	00 
     c38:	8b 45 08             	mov    0x8(%ebp),%eax
     c3b:	89 04 24             	mov    %eax,(%esp)
     c3e:	e8 cc 00 00 00       	call   d0f <open>
     c43:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
     c45:	85 c0                	test   %eax,%eax
     c47:	78 23                	js     c6c <stat+0x44>
    return -1;
  r = fstat(fd, st);
     c49:	8b 45 0c             	mov    0xc(%ebp),%eax
     c4c:	89 44 24 04          	mov    %eax,0x4(%esp)
     c50:	89 1c 24             	mov    %ebx,(%esp)
     c53:	e8 cf 00 00 00       	call   d27 <fstat>
     c58:	89 c6                	mov    %eax,%esi
  close(fd);
     c5a:	89 1c 24             	mov    %ebx,(%esp)
     c5d:	e8 95 00 00 00       	call   cf7 <close>
  return r;
}
     c62:	89 f0                	mov    %esi,%eax
     c64:	83 c4 10             	add    $0x10,%esp
     c67:	5b                   	pop    %ebx
     c68:	5e                   	pop    %esi
     c69:	5d                   	pop    %ebp
     c6a:	c3                   	ret    
     c6b:	90                   	nop
    return -1;
     c6c:	be ff ff ff ff       	mov    $0xffffffff,%esi
     c71:	eb ef                	jmp    c62 <stat+0x3a>
     c73:	90                   	nop

00000c74 <atoi>:

int
atoi(const char *s)
{
     c74:	55                   	push   %ebp
     c75:	89 e5                	mov    %esp,%ebp
     c77:	53                   	push   %ebx
     c78:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     c7b:	0f be 11             	movsbl (%ecx),%edx
     c7e:	8d 42 d0             	lea    -0x30(%edx),%eax
     c81:	3c 09                	cmp    $0x9,%al
     c83:	b8 00 00 00 00       	mov    $0x0,%eax
     c88:	77 15                	ja     c9f <atoi+0x2b>
     c8a:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
     c8c:	8d 04 80             	lea    (%eax,%eax,4),%eax
     c8f:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
     c93:	41                   	inc    %ecx
  while('0' <= *s && *s <= '9')
     c94:	0f be 11             	movsbl (%ecx),%edx
     c97:	8d 5a d0             	lea    -0x30(%edx),%ebx
     c9a:	80 fb 09             	cmp    $0x9,%bl
     c9d:	76 ed                	jbe    c8c <atoi+0x18>
  return n;
}
     c9f:	5b                   	pop    %ebx
     ca0:	5d                   	pop    %ebp
     ca1:	c3                   	ret    
     ca2:	66 90                	xchg   %ax,%ax

00000ca4 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     ca4:	55                   	push   %ebp
     ca5:	89 e5                	mov    %esp,%ebp
     ca7:	56                   	push   %esi
     ca8:	53                   	push   %ebx
     ca9:	8b 45 08             	mov    0x8(%ebp),%eax
     cac:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     caf:	8b 75 10             	mov    0x10(%ebp),%esi
memmove(void *vdst, void *vsrc, int n)
     cb2:	31 d2                	xor    %edx,%edx
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     cb4:	85 f6                	test   %esi,%esi
     cb6:	7e 0b                	jle    cc3 <memmove+0x1f>
    *dst++ = *src++;
     cb8:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
     cbb:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     cbe:	42                   	inc    %edx
  while(n-- > 0)
     cbf:	39 f2                	cmp    %esi,%edx
     cc1:	75 f5                	jne    cb8 <memmove+0x14>
  return vdst;
}
     cc3:	5b                   	pop    %ebx
     cc4:	5e                   	pop    %esi
     cc5:	5d                   	pop    %ebp
     cc6:	c3                   	ret    

00000cc7 <fork>:
     cc7:	b8 01 00 00 00       	mov    $0x1,%eax
     ccc:	cd 40                	int    $0x40
     cce:	c3                   	ret    

00000ccf <exit>:
     ccf:	b8 02 00 00 00       	mov    $0x2,%eax
     cd4:	cd 40                	int    $0x40
     cd6:	c3                   	ret    

00000cd7 <wait>:
     cd7:	b8 03 00 00 00       	mov    $0x3,%eax
     cdc:	cd 40                	int    $0x40
     cde:	c3                   	ret    

00000cdf <pipe>:
     cdf:	b8 04 00 00 00       	mov    $0x4,%eax
     ce4:	cd 40                	int    $0x40
     ce6:	c3                   	ret    

00000ce7 <read>:
     ce7:	b8 05 00 00 00       	mov    $0x5,%eax
     cec:	cd 40                	int    $0x40
     cee:	c3                   	ret    

00000cef <write>:
     cef:	b8 10 00 00 00       	mov    $0x10,%eax
     cf4:	cd 40                	int    $0x40
     cf6:	c3                   	ret    

00000cf7 <close>:
     cf7:	b8 15 00 00 00       	mov    $0x15,%eax
     cfc:	cd 40                	int    $0x40
     cfe:	c3                   	ret    

00000cff <kill>:
     cff:	b8 06 00 00 00       	mov    $0x6,%eax
     d04:	cd 40                	int    $0x40
     d06:	c3                   	ret    

00000d07 <exec>:
     d07:	b8 07 00 00 00       	mov    $0x7,%eax
     d0c:	cd 40                	int    $0x40
     d0e:	c3                   	ret    

00000d0f <open>:
     d0f:	b8 0f 00 00 00       	mov    $0xf,%eax
     d14:	cd 40                	int    $0x40
     d16:	c3                   	ret    

00000d17 <mknod>:
     d17:	b8 11 00 00 00       	mov    $0x11,%eax
     d1c:	cd 40                	int    $0x40
     d1e:	c3                   	ret    

00000d1f <unlink>:
     d1f:	b8 12 00 00 00       	mov    $0x12,%eax
     d24:	cd 40                	int    $0x40
     d26:	c3                   	ret    

00000d27 <fstat>:
     d27:	b8 08 00 00 00       	mov    $0x8,%eax
     d2c:	cd 40                	int    $0x40
     d2e:	c3                   	ret    

00000d2f <link>:
     d2f:	b8 13 00 00 00       	mov    $0x13,%eax
     d34:	cd 40                	int    $0x40
     d36:	c3                   	ret    

00000d37 <mkdir>:
     d37:	b8 14 00 00 00       	mov    $0x14,%eax
     d3c:	cd 40                	int    $0x40
     d3e:	c3                   	ret    

00000d3f <chdir>:
     d3f:	b8 09 00 00 00       	mov    $0x9,%eax
     d44:	cd 40                	int    $0x40
     d46:	c3                   	ret    

00000d47 <dup>:
     d47:	b8 0a 00 00 00       	mov    $0xa,%eax
     d4c:	cd 40                	int    $0x40
     d4e:	c3                   	ret    

00000d4f <getpid>:
     d4f:	b8 0b 00 00 00       	mov    $0xb,%eax
     d54:	cd 40                	int    $0x40
     d56:	c3                   	ret    

00000d57 <sbrk>:
     d57:	b8 0c 00 00 00       	mov    $0xc,%eax
     d5c:	cd 40                	int    $0x40
     d5e:	c3                   	ret    

00000d5f <sleep>:
     d5f:	b8 0d 00 00 00       	mov    $0xd,%eax
     d64:	cd 40                	int    $0x40
     d66:	c3                   	ret    

00000d67 <uptime>:
     d67:	b8 0e 00 00 00       	mov    $0xe,%eax
     d6c:	cd 40                	int    $0x40
     d6e:	c3                   	ret    

00000d6f <getprocnum>:
     d6f:	b8 16 00 00 00       	mov    $0x16,%eax
     d74:	cd 40                	int    $0x40
     d76:	c3                   	ret    

00000d77 <mempagenum>:
     d77:	b8 17 00 00 00       	mov    $0x17,%eax
     d7c:	cd 40                	int    $0x40
     d7e:	c3                   	ret    

00000d7f <syscallnum>:
     d7f:	b8 18 00 00 00       	mov    $0x18,%eax
     d84:	cd 40                	int    $0x40
     d86:	c3                   	ret    

00000d87 <settickets>:
     d87:	b8 19 00 00 00       	mov    $0x19,%eax
     d8c:	cd 40                	int    $0x40
     d8e:	c3                   	ret    

00000d8f <getsheltime>:
     d8f:	b8 1a 00 00 00       	mov    $0x1a,%eax
     d94:	cd 40                	int    $0x40
     d96:	c3                   	ret    

00000d97 <setstride>:
     d97:	b8 1b 00 00 00       	mov    $0x1b,%eax
     d9c:	cd 40                	int    $0x40
     d9e:	c3                   	ret    

00000d9f <setpass>:
     d9f:	b8 1c 00 00 00       	mov    $0x1c,%eax
     da4:	cd 40                	int    $0x40
     da6:	c3                   	ret    

00000da7 <join>:
     da7:	b8 1d 00 00 00       	mov    $0x1d,%eax
     dac:	cd 40                	int    $0x40
     dae:	c3                   	ret    

00000daf <clone1>:
     daf:	b8 1e 00 00 00       	mov    $0x1e,%eax
     db4:	cd 40                	int    $0x40
     db6:	c3                   	ret    
     db7:	90                   	nop

00000db8 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     db8:	55                   	push   %ebp
     db9:	89 e5                	mov    %esp,%ebp
     dbb:	57                   	push   %edi
     dbc:	56                   	push   %esi
     dbd:	53                   	push   %ebx
     dbe:	83 ec 3c             	sub    $0x3c,%esp
     dc1:	89 c7                	mov    %eax,%edi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
     dc3:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
     dc5:	8b 5d 08             	mov    0x8(%ebp),%ebx
     dc8:	85 db                	test   %ebx,%ebx
     dca:	74 04                	je     dd0 <printint+0x18>
     dcc:	85 d2                	test   %edx,%edx
     dce:	78 5d                	js     e2d <printint+0x75>
  neg = 0;
     dd0:	31 db                	xor    %ebx,%ebx
  } else {
    x = xx;
  }

  i = 0;
     dd2:	31 f6                	xor    %esi,%esi
     dd4:	eb 04                	jmp    dda <printint+0x22>
     dd6:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
     dd8:	89 d6                	mov    %edx,%esi
     dda:	31 d2                	xor    %edx,%edx
     ddc:	f7 f1                	div    %ecx
     dde:	8a 92 4b 12 00 00    	mov    0x124b(%edx),%dl
     de4:	88 54 35 d8          	mov    %dl,-0x28(%ebp,%esi,1)
     de8:	8d 56 01             	lea    0x1(%esi),%edx
  }while((x /= base) != 0);
     deb:	85 c0                	test   %eax,%eax
     ded:	75 e9                	jne    dd8 <printint+0x20>
  if(neg)
     def:	85 db                	test   %ebx,%ebx
     df1:	74 08                	je     dfb <printint+0x43>
    buf[i++] = '-';
     df3:	c6 44 15 d8 2d       	movb   $0x2d,-0x28(%ebp,%edx,1)
     df8:	8d 56 02             	lea    0x2(%esi),%edx

  while(--i >= 0)
     dfb:	8d 5a ff             	lea    -0x1(%edx),%ebx
     dfe:	8d 75 d7             	lea    -0x29(%ebp),%esi
     e01:	8d 76 00             	lea    0x0(%esi),%esi
     e04:	8a 44 1d d8          	mov    -0x28(%ebp,%ebx,1),%al
     e08:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
     e0b:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     e12:	00 
     e13:	89 74 24 04          	mov    %esi,0x4(%esp)
     e17:	89 3c 24             	mov    %edi,(%esp)
     e1a:	e8 d0 fe ff ff       	call   cef <write>
  while(--i >= 0)
     e1f:	4b                   	dec    %ebx
     e20:	83 fb ff             	cmp    $0xffffffff,%ebx
     e23:	75 df                	jne    e04 <printint+0x4c>
    putc(fd, buf[i]);
}
     e25:	83 c4 3c             	add    $0x3c,%esp
     e28:	5b                   	pop    %ebx
     e29:	5e                   	pop    %esi
     e2a:	5f                   	pop    %edi
     e2b:	5d                   	pop    %ebp
     e2c:	c3                   	ret    
    x = -xx;
     e2d:	f7 d8                	neg    %eax
    neg = 1;
     e2f:	bb 01 00 00 00       	mov    $0x1,%ebx
    x = -xx;
     e34:	eb 9c                	jmp    dd2 <printint+0x1a>
     e36:	66 90                	xchg   %ax,%ax

00000e38 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     e38:	55                   	push   %ebp
     e39:	89 e5                	mov    %esp,%ebp
     e3b:	57                   	push   %edi
     e3c:	56                   	push   %esi
     e3d:	53                   	push   %ebx
     e3e:	83 ec 3c             	sub    $0x3c,%esp
     e41:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     e44:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     e47:	8a 03                	mov    (%ebx),%al
     e49:	84 c0                	test   %al,%al
     e4b:	0f 84 bb 00 00 00    	je     f0c <printf+0xd4>
printf(int fd, char *fmt, ...)
     e51:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
     e52:	8d 55 10             	lea    0x10(%ebp),%edx
     e55:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  state = 0;
     e58:	31 ff                	xor    %edi,%edi
     e5a:	eb 2f                	jmp    e8b <printf+0x53>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
     e5c:	83 f9 25             	cmp    $0x25,%ecx
     e5f:	0f 84 af 00 00 00    	je     f14 <printf+0xdc>
        state = '%';
      } else {
        putc(fd, c);
     e65:	88 4d e2             	mov    %cl,-0x1e(%ebp)
  write(fd, &c, 1);
     e68:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     e6f:	00 
     e70:	8d 45 e2             	lea    -0x1e(%ebp),%eax
     e73:	89 44 24 04          	mov    %eax,0x4(%esp)
     e77:	89 34 24             	mov    %esi,(%esp)
     e7a:	e8 70 fe ff ff       	call   cef <write>
     e7f:	43                   	inc    %ebx
  for(i = 0; fmt[i]; i++){
     e80:	8a 43 ff             	mov    -0x1(%ebx),%al
     e83:	84 c0                	test   %al,%al
     e85:	0f 84 81 00 00 00    	je     f0c <printf+0xd4>
    c = fmt[i] & 0xff;
     e8b:	0f b6 c8             	movzbl %al,%ecx
    if(state == 0){
     e8e:	85 ff                	test   %edi,%edi
     e90:	74 ca                	je     e5c <printf+0x24>
      }
    } else if(state == '%'){
     e92:	83 ff 25             	cmp    $0x25,%edi
     e95:	75 e8                	jne    e7f <printf+0x47>
      if(c == 'd'){
     e97:	83 f9 64             	cmp    $0x64,%ecx
     e9a:	0f 84 14 01 00 00    	je     fb4 <printf+0x17c>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
     ea0:	83 f9 78             	cmp    $0x78,%ecx
     ea3:	74 7b                	je     f20 <printf+0xe8>
     ea5:	83 f9 70             	cmp    $0x70,%ecx
     ea8:	74 76                	je     f20 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
     eaa:	83 f9 73             	cmp    $0x73,%ecx
     ead:	0f 84 91 00 00 00    	je     f44 <printf+0x10c>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     eb3:	83 f9 63             	cmp    $0x63,%ecx
     eb6:	0f 84 cc 00 00 00    	je     f88 <printf+0x150>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
     ebc:	83 f9 25             	cmp    $0x25,%ecx
     ebf:	0f 84 13 01 00 00    	je     fd8 <printf+0x1a0>
     ec5:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
  write(fd, &c, 1);
     ec9:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     ed0:	00 
     ed1:	8d 45 e6             	lea    -0x1a(%ebp),%eax
     ed4:	89 44 24 04          	mov    %eax,0x4(%esp)
     ed8:	89 34 24             	mov    %esi,(%esp)
     edb:	89 4d d0             	mov    %ecx,-0x30(%ebp)
     ede:	e8 0c fe ff ff       	call   cef <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
     ee3:	8b 4d d0             	mov    -0x30(%ebp),%ecx
     ee6:	88 4d e7             	mov    %cl,-0x19(%ebp)
  write(fd, &c, 1);
     ee9:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     ef0:	00 
     ef1:	8d 55 e7             	lea    -0x19(%ebp),%edx
     ef4:	89 54 24 04          	mov    %edx,0x4(%esp)
     ef8:	89 34 24             	mov    %esi,(%esp)
     efb:	e8 ef fd ff ff       	call   cef <write>
      }
      state = 0;
     f00:	31 ff                	xor    %edi,%edi
     f02:	43                   	inc    %ebx
  for(i = 0; fmt[i]; i++){
     f03:	8a 43 ff             	mov    -0x1(%ebx),%al
     f06:	84 c0                	test   %al,%al
     f08:	75 81                	jne    e8b <printf+0x53>
     f0a:	66 90                	xchg   %ax,%ax
    }
  }
}
     f0c:	83 c4 3c             	add    $0x3c,%esp
     f0f:	5b                   	pop    %ebx
     f10:	5e                   	pop    %esi
     f11:	5f                   	pop    %edi
     f12:	5d                   	pop    %ebp
     f13:	c3                   	ret    
        state = '%';
     f14:	bf 25 00 00 00       	mov    $0x25,%edi
     f19:	e9 61 ff ff ff       	jmp    e7f <printf+0x47>
     f1e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
     f20:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     f27:	b9 10 00 00 00       	mov    $0x10,%ecx
     f2c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     f2f:	8b 10                	mov    (%eax),%edx
     f31:	89 f0                	mov    %esi,%eax
     f33:	e8 80 fe ff ff       	call   db8 <printint>
        ap++;
     f38:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
     f3c:	31 ff                	xor    %edi,%edi
        ap++;
     f3e:	e9 3c ff ff ff       	jmp    e7f <printf+0x47>
     f43:	90                   	nop
        s = (char*)*ap;
     f44:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     f47:	8b 3a                	mov    (%edx),%edi
        ap++;
     f49:	83 c2 04             	add    $0x4,%edx
     f4c:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
     f4f:	85 ff                	test   %edi,%edi
     f51:	0f 84 a3 00 00 00    	je     ffa <printf+0x1c2>
        while(*s != 0){
     f57:	8a 07                	mov    (%edi),%al
     f59:	84 c0                	test   %al,%al
     f5b:	74 24                	je     f81 <printf+0x149>
     f5d:	8d 76 00             	lea    0x0(%esi),%esi
     f60:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
     f63:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     f6a:	00 
     f6b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
     f6e:	89 44 24 04          	mov    %eax,0x4(%esp)
     f72:	89 34 24             	mov    %esi,(%esp)
     f75:	e8 75 fd ff ff       	call   cef <write>
          s++;
     f7a:	47                   	inc    %edi
        while(*s != 0){
     f7b:	8a 07                	mov    (%edi),%al
     f7d:	84 c0                	test   %al,%al
     f7f:	75 df                	jne    f60 <printf+0x128>
      state = 0;
     f81:	31 ff                	xor    %edi,%edi
     f83:	e9 f7 fe ff ff       	jmp    e7f <printf+0x47>
        putc(fd, *ap);
     f88:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     f8b:	8b 02                	mov    (%edx),%eax
     f8d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
     f90:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     f97:	00 
     f98:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     f9b:	89 44 24 04          	mov    %eax,0x4(%esp)
     f9f:	89 34 24             	mov    %esi,(%esp)
     fa2:	e8 48 fd ff ff       	call   cef <write>
        ap++;
     fa7:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
     fab:	31 ff                	xor    %edi,%edi
     fad:	e9 cd fe ff ff       	jmp    e7f <printf+0x47>
     fb2:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
     fb4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     fbb:	b1 0a                	mov    $0xa,%cl
     fbd:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     fc0:	8b 10                	mov    (%eax),%edx
     fc2:	89 f0                	mov    %esi,%eax
     fc4:	e8 ef fd ff ff       	call   db8 <printint>
        ap++;
     fc9:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      state = 0;
     fcd:	66 31 ff             	xor    %di,%di
     fd0:	e9 aa fe ff ff       	jmp    e7f <printf+0x47>
     fd5:	8d 76 00             	lea    0x0(%esi),%esi
     fd8:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
  write(fd, &c, 1);
     fdc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     fe3:	00 
     fe4:	8d 45 e5             	lea    -0x1b(%ebp),%eax
     fe7:	89 44 24 04          	mov    %eax,0x4(%esp)
     feb:	89 34 24             	mov    %esi,(%esp)
     fee:	e8 fc fc ff ff       	call   cef <write>
      state = 0;
     ff3:	31 ff                	xor    %edi,%edi
     ff5:	e9 85 fe ff ff       	jmp    e7f <printf+0x47>
          s = "(null)";
     ffa:	bf 44 12 00 00       	mov    $0x1244,%edi
     fff:	e9 53 ff ff ff       	jmp    f57 <printf+0x11f>

00001004 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1004:	55                   	push   %ebp
    1005:	89 e5                	mov    %esp,%ebp
    1007:	57                   	push   %edi
    1008:	56                   	push   %esi
    1009:	53                   	push   %ebx
    100a:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    100d:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1010:	a1 84 18 00 00       	mov    0x1884,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1015:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1017:	39 d0                	cmp    %edx,%eax
    1019:	72 11                	jb     102c <free+0x28>
    101b:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    101c:	39 c8                	cmp    %ecx,%eax
    101e:	72 04                	jb     1024 <free+0x20>
    1020:	39 ca                	cmp    %ecx,%edx
    1022:	72 10                	jb     1034 <free+0x30>
    1024:	89 c8                	mov    %ecx,%eax
    1026:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1028:	39 d0                	cmp    %edx,%eax
    102a:	73 f0                	jae    101c <free+0x18>
    102c:	39 ca                	cmp    %ecx,%edx
    102e:	72 04                	jb     1034 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1030:	39 c8                	cmp    %ecx,%eax
    1032:	72 f0                	jb     1024 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1034:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1037:	8d 3c f2             	lea    (%edx,%esi,8),%edi
    103a:	39 cf                	cmp    %ecx,%edi
    103c:	74 1a                	je     1058 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    103e:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1041:	8b 48 04             	mov    0x4(%eax),%ecx
    1044:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
    1047:	39 f2                	cmp    %esi,%edx
    1049:	74 24                	je     106f <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    104b:	89 10                	mov    %edx,(%eax)
  freep = p;
    104d:	a3 84 18 00 00       	mov    %eax,0x1884
}
    1052:	5b                   	pop    %ebx
    1053:	5e                   	pop    %esi
    1054:	5f                   	pop    %edi
    1055:	5d                   	pop    %ebp
    1056:	c3                   	ret    
    1057:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
    1058:	03 71 04             	add    0x4(%ecx),%esi
    105b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    105e:	8b 08                	mov    (%eax),%ecx
    1060:	8b 09                	mov    (%ecx),%ecx
    1062:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1065:	8b 48 04             	mov    0x4(%eax),%ecx
    1068:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
    106b:	39 f2                	cmp    %esi,%edx
    106d:	75 dc                	jne    104b <free+0x47>
    p->s.size += bp->s.size;
    106f:	03 4b fc             	add    -0x4(%ebx),%ecx
    1072:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1075:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1078:	89 10                	mov    %edx,(%eax)
  freep = p;
    107a:	a3 84 18 00 00       	mov    %eax,0x1884
}
    107f:	5b                   	pop    %ebx
    1080:	5e                   	pop    %esi
    1081:	5f                   	pop    %edi
    1082:	5d                   	pop    %ebp
    1083:	c3                   	ret    

00001084 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1084:	55                   	push   %ebp
    1085:	89 e5                	mov    %esp,%ebp
    1087:	57                   	push   %edi
    1088:	56                   	push   %esi
    1089:	53                   	push   %ebx
    108a:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    108d:	8b 75 08             	mov    0x8(%ebp),%esi
    1090:	83 c6 07             	add    $0x7,%esi
    1093:	c1 ee 03             	shr    $0x3,%esi
    1096:	46                   	inc    %esi
  if((prevp = freep) == 0){
    1097:	8b 15 84 18 00 00    	mov    0x1884,%edx
    109d:	85 d2                	test   %edx,%edx
    109f:	0f 84 8d 00 00 00    	je     1132 <malloc+0xae>
    10a5:	8b 02                	mov    (%edx),%eax
    10a7:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    10aa:	39 ce                	cmp    %ecx,%esi
    10ac:	76 52                	jbe    1100 <malloc+0x7c>
    10ae:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
    10b5:	eb 0a                	jmp    10c1 <malloc+0x3d>
    10b7:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    10b8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    10ba:	8b 48 04             	mov    0x4(%eax),%ecx
    10bd:	39 ce                	cmp    %ecx,%esi
    10bf:	76 3f                	jbe    1100 <malloc+0x7c>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    10c1:	89 c2                	mov    %eax,%edx
    10c3:	3b 05 84 18 00 00    	cmp    0x1884,%eax
    10c9:	75 ed                	jne    10b8 <malloc+0x34>
  if(nu < 4096)
    10cb:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
    10d1:	76 4d                	jbe    1120 <malloc+0x9c>
    10d3:	89 d8                	mov    %ebx,%eax
    10d5:	89 f7                	mov    %esi,%edi
  p = sbrk(nu * sizeof(Header));
    10d7:	89 04 24             	mov    %eax,(%esp)
    10da:	e8 78 fc ff ff       	call   d57 <sbrk>
  if(p == (char*)-1)
    10df:	83 f8 ff             	cmp    $0xffffffff,%eax
    10e2:	74 18                	je     10fc <malloc+0x78>
  hp->s.size = nu;
    10e4:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
    10e7:	83 c0 08             	add    $0x8,%eax
    10ea:	89 04 24             	mov    %eax,(%esp)
    10ed:	e8 12 ff ff ff       	call   1004 <free>
  return freep;
    10f2:	8b 15 84 18 00 00    	mov    0x1884,%edx
      if((p = morecore(nunits)) == 0)
    10f8:	85 d2                	test   %edx,%edx
    10fa:	75 bc                	jne    10b8 <malloc+0x34>
        return 0;
    10fc:	31 c0                	xor    %eax,%eax
    10fe:	eb 18                	jmp    1118 <malloc+0x94>
      if(p->s.size == nunits)
    1100:	39 ce                	cmp    %ecx,%esi
    1102:	74 28                	je     112c <malloc+0xa8>
        p->s.size -= nunits;
    1104:	29 f1                	sub    %esi,%ecx
    1106:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1109:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    110c:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
    110f:	89 15 84 18 00 00    	mov    %edx,0x1884
      return (void*)(p + 1);
    1115:	83 c0 08             	add    $0x8,%eax
  }
}
    1118:	83 c4 1c             	add    $0x1c,%esp
    111b:	5b                   	pop    %ebx
    111c:	5e                   	pop    %esi
    111d:	5f                   	pop    %edi
    111e:	5d                   	pop    %ebp
    111f:	c3                   	ret    
  if(nu < 4096)
    1120:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
    1125:	bf 00 10 00 00       	mov    $0x1000,%edi
    112a:	eb ab                	jmp    10d7 <malloc+0x53>
        prevp->s.ptr = p->s.ptr;
    112c:	8b 08                	mov    (%eax),%ecx
    112e:	89 0a                	mov    %ecx,(%edx)
    1130:	eb dd                	jmp    110f <malloc+0x8b>
    base.s.ptr = freep = prevp = &base;
    1132:	c7 05 84 18 00 00 88 	movl   $0x1888,0x1884
    1139:	18 00 00 
    113c:	c7 05 88 18 00 00 88 	movl   $0x1888,0x1888
    1143:	18 00 00 
    base.s.size = 0;
    1146:	c7 05 8c 18 00 00 00 	movl   $0x0,0x188c
    114d:	00 00 00 
    1150:	b8 88 18 00 00       	mov    $0x1888,%eax
    1155:	e9 54 ff ff ff       	jmp    10ae <malloc+0x2a>
