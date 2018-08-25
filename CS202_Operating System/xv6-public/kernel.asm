
kernel：     文件格式 elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc b0 b5 10 80       	mov    $0x8010b5b0,%esp
8010002d:	b8 30 2a 10 80       	mov    $0x80102a30,%eax
80100032:	ff e0                	jmp    *%eax

80100034 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100034:	55                   	push   %ebp
80100035:	89 e5                	mov    %esp,%ebp
80100037:	53                   	push   %ebx
80100038:	83 ec 14             	sub    $0x14,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010003b:	c7 44 24 04 60 6d 10 	movl   $0x80106d60,0x4(%esp)
80100042:	80 
80100043:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010004a:	e8 c9 42 00 00       	call   80104318 <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010004f:	c7 05 0c fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd0c
80100056:	fc 10 80 
  bcache.head.next = &bcache.head;
80100059:	c7 05 10 fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd10
80100060:	fc 10 80 
80100063:	ba bc fc 10 80       	mov    $0x8010fcbc,%edx
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100068:	bb f4 b5 10 80       	mov    $0x8010b5f4,%ebx
8010006d:	eb 03                	jmp    80100072 <binit+0x3e>
8010006f:	90                   	nop
80100070:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
80100072:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
80100075:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
8010007c:	c7 44 24 04 67 6d 10 	movl   $0x80106d67,0x4(%esp)
80100083:	80 
80100084:	8d 43 0c             	lea    0xc(%ebx),%eax
80100087:	89 04 24             	mov    %eax,(%esp)
8010008a:	e8 99 41 00 00       	call   80104228 <initsleeplock>
    bcache.head.next->prev = b;
8010008f:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
80100094:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100097:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010009d:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
801000a3:	89 da                	mov    %ebx,%edx
801000a5:	3d bc fc 10 80       	cmp    $0x8010fcbc,%eax
801000aa:	75 c4                	jne    80100070 <binit+0x3c>
  }
}
801000ac:	83 c4 14             	add    $0x14,%esp
801000af:	5b                   	pop    %ebx
801000b0:	5d                   	pop    %ebp
801000b1:	c3                   	ret    
801000b2:	66 90                	xchg   %ax,%ax

801000b4 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000b4:	55                   	push   %ebp
801000b5:	89 e5                	mov    %esp,%ebp
801000b7:	57                   	push   %edi
801000b8:	56                   	push   %esi
801000b9:	53                   	push   %ebx
801000ba:	83 ec 1c             	sub    $0x1c,%esp
801000bd:	8b 75 08             	mov    0x8(%ebp),%esi
801000c0:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000c3:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
801000ca:	e8 11 43 00 00       	call   801043e0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000cf:	8b 1d 10 fd 10 80    	mov    0x8010fd10,%ebx
801000d5:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
801000db:	75 0e                	jne    801000eb <bread+0x37>
801000dd:	eb 1d                	jmp    801000fc <bread+0x48>
801000df:	90                   	nop
801000e0:	8b 5b 54             	mov    0x54(%ebx),%ebx
801000e3:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
801000e9:	74 11                	je     801000fc <bread+0x48>
    if(b->dev == dev && b->blockno == blockno){
801000eb:	3b 73 04             	cmp    0x4(%ebx),%esi
801000ee:	75 f0                	jne    801000e0 <bread+0x2c>
801000f0:	3b 7b 08             	cmp    0x8(%ebx),%edi
801000f3:	75 eb                	jne    801000e0 <bread+0x2c>
      b->refcnt++;
801000f5:	ff 43 4c             	incl   0x4c(%ebx)
801000f8:	eb 3c                	jmp    80100136 <bread+0x82>
801000fa:	66 90                	xchg   %ax,%ax
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
801000fc:	8b 1d 0c fd 10 80    	mov    0x8010fd0c,%ebx
80100102:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100108:	75 0d                	jne    80100117 <bread+0x63>
8010010a:	eb 58                	jmp    80100164 <bread+0xb0>
8010010c:	8b 5b 50             	mov    0x50(%ebx),%ebx
8010010f:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100115:	74 4d                	je     80100164 <bread+0xb0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
80100117:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010011a:	85 c0                	test   %eax,%eax
8010011c:	75 ee                	jne    8010010c <bread+0x58>
8010011e:	f6 03 04             	testb  $0x4,(%ebx)
80100121:	75 e9                	jne    8010010c <bread+0x58>
      b->dev = dev;
80100123:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
80100126:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
80100129:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
8010012f:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100136:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010013d:	e8 5a 43 00 00       	call   8010449c <release>
      acquiresleep(&b->lock);
80100142:	8d 43 0c             	lea    0xc(%ebx),%eax
80100145:	89 04 24             	mov    %eax,(%esp)
80100148:	e8 13 41 00 00       	call   80104260 <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
8010014d:	f6 03 02             	testb  $0x2,(%ebx)
80100150:	75 08                	jne    8010015a <bread+0xa6>
    iderw(b);
80100152:	89 1c 24             	mov    %ebx,(%esp)
80100155:	e8 a2 1d 00 00       	call   80101efc <iderw>
  }
  return b;
}
8010015a:	89 d8                	mov    %ebx,%eax
8010015c:	83 c4 1c             	add    $0x1c,%esp
8010015f:	5b                   	pop    %ebx
80100160:	5e                   	pop    %esi
80100161:	5f                   	pop    %edi
80100162:	5d                   	pop    %ebp
80100163:	c3                   	ret    
  panic("bget: no buffers");
80100164:	c7 04 24 6e 6d 10 80 	movl   $0x80106d6e,(%esp)
8010016b:	e8 a0 01 00 00       	call   80100310 <panic>

80100170 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
80100170:	55                   	push   %ebp
80100171:	89 e5                	mov    %esp,%ebp
80100173:	53                   	push   %ebx
80100174:	83 ec 14             	sub    $0x14,%esp
80100177:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
8010017a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010017d:	89 04 24             	mov    %eax,(%esp)
80100180:	e8 67 41 00 00       	call   801042ec <holdingsleep>
80100185:	85 c0                	test   %eax,%eax
80100187:	74 10                	je     80100199 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
80100189:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
8010018c:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010018f:	83 c4 14             	add    $0x14,%esp
80100192:	5b                   	pop    %ebx
80100193:	5d                   	pop    %ebp
  iderw(b);
80100194:	e9 63 1d 00 00       	jmp    80101efc <iderw>
    panic("bwrite");
80100199:	c7 04 24 7f 6d 10 80 	movl   $0x80106d7f,(%esp)
801001a0:	e8 6b 01 00 00       	call   80100310 <panic>
801001a5:	8d 76 00             	lea    0x0(%esi),%esi

801001a8 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001a8:	55                   	push   %ebp
801001a9:	89 e5                	mov    %esp,%ebp
801001ab:	56                   	push   %esi
801001ac:	53                   	push   %ebx
801001ad:	83 ec 10             	sub    $0x10,%esp
801001b0:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001b3:	8d 73 0c             	lea    0xc(%ebx),%esi
801001b6:	89 34 24             	mov    %esi,(%esp)
801001b9:	e8 2e 41 00 00       	call   801042ec <holdingsleep>
801001be:	85 c0                	test   %eax,%eax
801001c0:	74 5a                	je     8010021c <brelse+0x74>
    panic("brelse");

  releasesleep(&b->lock);
801001c2:	89 34 24             	mov    %esi,(%esp)
801001c5:	e8 e6 40 00 00       	call   801042b0 <releasesleep>

  acquire(&bcache.lock);
801001ca:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
801001d1:	e8 0a 42 00 00       	call   801043e0 <acquire>
  b->refcnt--;
  if (b->refcnt == 0) {
801001d6:	ff 4b 4c             	decl   0x4c(%ebx)
801001d9:	75 2f                	jne    8010020a <brelse+0x62>
    // no one is waiting for it.
    b->next->prev = b->prev;
801001db:	8b 43 54             	mov    0x54(%ebx),%eax
801001de:	8b 53 50             	mov    0x50(%ebx),%edx
801001e1:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
801001e4:	8b 43 50             	mov    0x50(%ebx),%eax
801001e7:	8b 53 54             	mov    0x54(%ebx),%edx
801001ea:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
801001ed:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
801001f2:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
801001f5:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    bcache.head.next->prev = b;
801001fc:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
80100201:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100204:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  }
  
  release(&bcache.lock);
8010020a:	c7 45 08 c0 b5 10 80 	movl   $0x8010b5c0,0x8(%ebp)
}
80100211:	83 c4 10             	add    $0x10,%esp
80100214:	5b                   	pop    %ebx
80100215:	5e                   	pop    %esi
80100216:	5d                   	pop    %ebp
  release(&bcache.lock);
80100217:	e9 80 42 00 00       	jmp    8010449c <release>
    panic("brelse");
8010021c:	c7 04 24 86 6d 10 80 	movl   $0x80106d86,(%esp)
80100223:	e8 e8 00 00 00       	call   80100310 <panic>

80100228 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100228:	55                   	push   %ebp
80100229:	89 e5                	mov    %esp,%ebp
8010022b:	57                   	push   %edi
8010022c:	56                   	push   %esi
8010022d:	53                   	push   %ebx
8010022e:	83 ec 1c             	sub    $0x1c,%esp
80100231:	8b 5d 10             	mov    0x10(%ebp),%ebx
  uint target;
  int c;

  iunlock(ip);
80100234:	8b 55 08             	mov    0x8(%ebp),%edx
80100237:	89 14 24             	mov    %edx,(%esp)
8010023a:	e8 e1 13 00 00       	call   80101620 <iunlock>
  target = n;
  acquire(&cons.lock);
8010023f:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100246:	e8 95 41 00 00       	call   801043e0 <acquire>
  while(n > 0){
8010024b:	89 de                	mov    %ebx,%esi
8010024d:	85 db                	test   %ebx,%ebx
8010024f:	7f 27                	jg     80100278 <consoleread+0x50>
80100251:	e9 b6 00 00 00       	jmp    8010030c <consoleread+0xe4>
80100256:	66 90                	xchg   %ax,%ax
    while(input.r == input.w){
      if(myproc()->killed){
80100258:	e8 2b 30 00 00       	call   80103288 <myproc>
8010025d:	8b 40 24             	mov    0x24(%eax),%eax
80100260:	85 c0                	test   %eax,%eax
80100262:	75 74                	jne    801002d8 <consoleread+0xb0>
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
80100264:	c7 44 24 04 20 a5 10 	movl   $0x8010a520,0x4(%esp)
8010026b:	80 
8010026c:	c7 04 24 a0 ff 10 80 	movl   $0x8010ffa0,(%esp)
80100273:	e8 04 39 00 00       	call   80103b7c <sleep>
    while(input.r == input.w){
80100278:	8b 15 a0 ff 10 80    	mov    0x8010ffa0,%edx
8010027e:	3b 15 a4 ff 10 80    	cmp    0x8010ffa4,%edx
80100284:	74 d2                	je     80100258 <consoleread+0x30>
    }
    c = input.buf[input.r++ % INPUT_BUF];
80100286:	89 d0                	mov    %edx,%eax
80100288:	83 e0 7f             	and    $0x7f,%eax
8010028b:	8a 80 20 ff 10 80    	mov    -0x7fef00e0(%eax),%al
80100291:	0f be c8             	movsbl %al,%ecx
80100294:	8d 7a 01             	lea    0x1(%edx),%edi
80100297:	89 3d a0 ff 10 80    	mov    %edi,0x8010ffa0
    if(c == C('D')){  // EOF
8010029d:	83 f9 04             	cmp    $0x4,%ecx
801002a0:	74 5c                	je     801002fe <consoleread+0xd6>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
801002a2:	8b 55 0c             	mov    0xc(%ebp),%edx
801002a5:	88 02                	mov    %al,(%edx)
801002a7:	42                   	inc    %edx
801002a8:	89 55 0c             	mov    %edx,0xc(%ebp)
    --n;
801002ab:	4e                   	dec    %esi
    if(c == '\n')
801002ac:	83 f9 0a             	cmp    $0xa,%ecx
801002af:	74 57                	je     80100308 <consoleread+0xe0>
  while(n > 0){
801002b1:	85 f6                	test   %esi,%esi
801002b3:	75 c3                	jne    80100278 <consoleread+0x50>
      break;
  }
  release(&cons.lock);
801002b5:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801002bc:	e8 db 41 00 00       	call   8010449c <release>
  ilock(ip);
801002c1:	8b 55 08             	mov    0x8(%ebp),%edx
801002c4:	89 14 24             	mov    %edx,(%esp)
801002c7:	e8 84 12 00 00       	call   80101550 <ilock>

  return target - n;
}
801002cc:	89 d8                	mov    %ebx,%eax
801002ce:	83 c4 1c             	add    $0x1c,%esp
801002d1:	5b                   	pop    %ebx
801002d2:	5e                   	pop    %esi
801002d3:	5f                   	pop    %edi
801002d4:	5d                   	pop    %ebp
801002d5:	c3                   	ret    
801002d6:	66 90                	xchg   %ax,%ax
        release(&cons.lock);
801002d8:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801002df:	e8 b8 41 00 00       	call   8010449c <release>
        ilock(ip);
801002e4:	8b 55 08             	mov    0x8(%ebp),%edx
801002e7:	89 14 24             	mov    %edx,(%esp)
801002ea:	e8 61 12 00 00       	call   80101550 <ilock>
        return -1;
801002ef:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
801002f4:	89 d8                	mov    %ebx,%eax
801002f6:	83 c4 1c             	add    $0x1c,%esp
801002f9:	5b                   	pop    %ebx
801002fa:	5e                   	pop    %esi
801002fb:	5f                   	pop    %edi
801002fc:	5d                   	pop    %ebp
801002fd:	c3                   	ret    
      if(n < target){
801002fe:	39 f3                	cmp    %esi,%ebx
80100300:	76 06                	jbe    80100308 <consoleread+0xe0>
        input.r--;
80100302:	89 15 a0 ff 10 80    	mov    %edx,0x8010ffa0
80100308:	29 f3                	sub    %esi,%ebx
8010030a:	eb a9                	jmp    801002b5 <consoleread+0x8d>
  while(n > 0){
8010030c:	31 db                	xor    %ebx,%ebx
8010030e:	eb a5                	jmp    801002b5 <consoleread+0x8d>

80100310 <panic>:
{
80100310:	55                   	push   %ebp
80100311:	89 e5                	mov    %esp,%ebp
80100313:	56                   	push   %esi
80100314:	53                   	push   %ebx
80100315:	83 ec 40             	sub    $0x40,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100318:	fa                   	cli    
  cons.locking = 0;
80100319:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
80100320:	00 00 00 
  cprintf("lapicid %d: panic: ", lapicid());
80100323:	e8 38 21 00 00       	call   80102460 <lapicid>
80100328:	89 44 24 04          	mov    %eax,0x4(%esp)
8010032c:	c7 04 24 8d 6d 10 80 	movl   $0x80106d8d,(%esp)
80100333:	e8 7c 02 00 00       	call   801005b4 <cprintf>
  cprintf(s);
80100338:	8b 45 08             	mov    0x8(%ebp),%eax
8010033b:	89 04 24             	mov    %eax,(%esp)
8010033e:	e8 71 02 00 00       	call   801005b4 <cprintf>
  cprintf("\n");
80100343:	c7 04 24 1b 78 10 80 	movl   $0x8010781b,(%esp)
8010034a:	e8 65 02 00 00       	call   801005b4 <cprintf>
  getcallerpcs(&s, pcs);
8010034f:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100352:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100356:	8d 45 08             	lea    0x8(%ebp),%eax
80100359:	89 04 24             	mov    %eax,(%esp)
8010035c:	e8 d3 3f 00 00       	call   80104334 <getcallerpcs>
panic(char *s)
80100361:	8d 75 f8             	lea    -0x8(%ebp),%esi
    cprintf(" %p", pcs[i]);
80100364:	8b 03                	mov    (%ebx),%eax
80100366:	89 44 24 04          	mov    %eax,0x4(%esp)
8010036a:	c7 04 24 a1 6d 10 80 	movl   $0x80106da1,(%esp)
80100371:	e8 3e 02 00 00       	call   801005b4 <cprintf>
80100376:	83 c3 04             	add    $0x4,%ebx
  for(i=0; i<10; i++)
80100379:	39 f3                	cmp    %esi,%ebx
8010037b:	75 e7                	jne    80100364 <panic+0x54>
  panicked = 1; // freeze other CPU
8010037d:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
80100384:	00 00 00 
80100387:	eb fe                	jmp    80100387 <panic+0x77>
80100389:	8d 76 00             	lea    0x0(%esi),%esi

8010038c <consputc>:
  if(panicked){
8010038c:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
80100392:	85 d2                	test   %edx,%edx
80100394:	74 06                	je     8010039c <consputc+0x10>
80100396:	fa                   	cli    
80100397:	eb fe                	jmp    80100397 <consputc+0xb>
80100399:	8d 76 00             	lea    0x0(%esi),%esi
{
8010039c:	55                   	push   %ebp
8010039d:	89 e5                	mov    %esp,%ebp
8010039f:	57                   	push   %edi
801003a0:	56                   	push   %esi
801003a1:	53                   	push   %ebx
801003a2:	83 ec 1c             	sub    $0x1c,%esp
801003a5:	89 c6                	mov    %eax,%esi
  if(c == BACKSPACE){
801003a7:	3d 00 01 00 00       	cmp    $0x100,%eax
801003ac:	0f 84 a1 00 00 00    	je     80100453 <consputc+0xc7>
    uartputc(c);
801003b2:	89 04 24             	mov    %eax,(%esp)
801003b5:	e8 62 55 00 00       	call   8010591c <uartputc>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801003ba:	bf d4 03 00 00       	mov    $0x3d4,%edi
801003bf:	b0 0e                	mov    $0xe,%al
801003c1:	89 fa                	mov    %edi,%edx
801003c3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801003c4:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
801003c9:	89 ca                	mov    %ecx,%edx
801003cb:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
801003cc:	0f b6 d8             	movzbl %al,%ebx
801003cf:	c1 e3 08             	shl    $0x8,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801003d2:	b0 0f                	mov    $0xf,%al
801003d4:	89 fa                	mov    %edi,%edx
801003d6:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801003d7:	89 ca                	mov    %ecx,%edx
801003d9:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
801003da:	0f b6 c0             	movzbl %al,%eax
801003dd:	09 c3                	or     %eax,%ebx
  if(c == '\n')
801003df:	83 fe 0a             	cmp    $0xa,%esi
801003e2:	0f 84 f8 00 00 00    	je     801004e0 <consputc+0x154>
  else if(c == BACKSPACE){
801003e8:	81 fe 00 01 00 00    	cmp    $0x100,%esi
801003ee:	0f 84 de 00 00 00    	je     801004d2 <consputc+0x146>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
801003f4:	81 e6 ff 00 00 00    	and    $0xff,%esi
801003fa:	81 ce 00 07 00 00    	or     $0x700,%esi
80100400:	66 89 b4 1b 00 80 0b 	mov    %si,-0x7ff48000(%ebx,%ebx,1)
80100407:	80 
80100408:	43                   	inc    %ebx
  if(pos < 0 || pos > 25*80)
80100409:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
8010040f:	0f 87 b1 00 00 00    	ja     801004c6 <consputc+0x13a>
  if((pos/80) >= 24){  // Scroll up.
80100415:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
8010041b:	7f 5f                	jg     8010047c <consputc+0xf0>
8010041d:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100424:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100429:	b0 0e                	mov    $0xe,%al
8010042b:	89 fa                	mov    %edi,%edx
8010042d:	ee                   	out    %al,(%dx)
  outb(CRTPORT+1, pos>>8);
8010042e:	89 d8                	mov    %ebx,%eax
80100430:	c1 f8 08             	sar    $0x8,%eax
80100433:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100438:	89 ca                	mov    %ecx,%edx
8010043a:	ee                   	out    %al,(%dx)
8010043b:	b0 0f                	mov    $0xf,%al
8010043d:	89 fa                	mov    %edi,%edx
8010043f:	ee                   	out    %al,(%dx)
  outb(CRTPORT+1, pos);
80100440:	0f b6 c3             	movzbl %bl,%eax
80100443:	89 ca                	mov    %ecx,%edx
80100445:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
80100446:	66 c7 06 20 07       	movw   $0x720,(%esi)
}
8010044b:	83 c4 1c             	add    $0x1c,%esp
8010044e:	5b                   	pop    %ebx
8010044f:	5e                   	pop    %esi
80100450:	5f                   	pop    %edi
80100451:	5d                   	pop    %ebp
80100452:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100453:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010045a:	e8 bd 54 00 00       	call   8010591c <uartputc>
8010045f:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100466:	e8 b1 54 00 00       	call   8010591c <uartputc>
8010046b:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100472:	e8 a5 54 00 00       	call   8010591c <uartputc>
80100477:	e9 3e ff ff ff       	jmp    801003ba <consputc+0x2e>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010047c:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
80100483:	00 
80100484:	c7 44 24 04 a0 80 0b 	movl   $0x800b80a0,0x4(%esp)
8010048b:	80 
8010048c:	c7 04 24 00 80 0b 80 	movl   $0x800b8000,(%esp)
80100493:	e8 e0 40 00 00       	call   80104578 <memmove>
    pos -= 80;
80100498:	8d 7b b0             	lea    -0x50(%ebx),%edi
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010049b:	8d b4 3f 00 80 0b 80 	lea    -0x7ff48000(%edi,%edi,1),%esi
801004a2:	b8 d0 07 00 00       	mov    $0x7d0,%eax
801004a7:	29 d8                	sub    %ebx,%eax
801004a9:	d1 e0                	shl    %eax
801004ab:	89 44 24 08          	mov    %eax,0x8(%esp)
801004af:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801004b6:	00 
801004b7:	89 34 24             	mov    %esi,(%esp)
801004ba:	e8 25 40 00 00       	call   801044e4 <memset>
    pos -= 80;
801004bf:	89 fb                	mov    %edi,%ebx
801004c1:	e9 5e ff ff ff       	jmp    80100424 <consputc+0x98>
    panic("pos under/overflow");
801004c6:	c7 04 24 a5 6d 10 80 	movl   $0x80106da5,(%esp)
801004cd:	e8 3e fe ff ff       	call   80100310 <panic>
    if(pos > 0) --pos;
801004d2:	85 db                	test   %ebx,%ebx
801004d4:	0f 8e 2f ff ff ff    	jle    80100409 <consputc+0x7d>
801004da:	4b                   	dec    %ebx
801004db:	e9 29 ff ff ff       	jmp    80100409 <consputc+0x7d>
    pos += 80 - pos%80;
801004e0:	b9 50 00 00 00       	mov    $0x50,%ecx
801004e5:	89 d8                	mov    %ebx,%eax
801004e7:	99                   	cltd   
801004e8:	f7 f9                	idiv   %ecx
801004ea:	29 d1                	sub    %edx,%ecx
801004ec:	01 cb                	add    %ecx,%ebx
801004ee:	e9 16 ff ff ff       	jmp    80100409 <consputc+0x7d>
801004f3:	90                   	nop

801004f4 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
801004f4:	55                   	push   %ebp
801004f5:	89 e5                	mov    %esp,%ebp
801004f7:	57                   	push   %edi
801004f8:	56                   	push   %esi
801004f9:	53                   	push   %ebx
801004fa:	83 ec 1c             	sub    $0x1c,%esp
801004fd:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
80100500:	8b 45 08             	mov    0x8(%ebp),%eax
80100503:	89 04 24             	mov    %eax,(%esp)
80100506:	e8 15 11 00 00       	call   80101620 <iunlock>
  acquire(&cons.lock);
8010050b:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100512:	e8 c9 3e 00 00       	call   801043e0 <acquire>
  for(i = 0; i < n; i++)
80100517:	85 f6                	test   %esi,%esi
80100519:	7e 16                	jle    80100531 <consolewrite+0x3d>
8010051b:	8b 7d 0c             	mov    0xc(%ebp),%edi
consolewrite(struct inode *ip, char *buf, int n)
8010051e:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
80100521:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100524:	0f b6 07             	movzbl (%edi),%eax
80100527:	e8 60 fe ff ff       	call   8010038c <consputc>
8010052c:	47                   	inc    %edi
  for(i = 0; i < n; i++)
8010052d:	39 df                	cmp    %ebx,%edi
8010052f:	75 f3                	jne    80100524 <consolewrite+0x30>
  release(&cons.lock);
80100531:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100538:	e8 5f 3f 00 00       	call   8010449c <release>
  ilock(ip);
8010053d:	8b 45 08             	mov    0x8(%ebp),%eax
80100540:	89 04 24             	mov    %eax,(%esp)
80100543:	e8 08 10 00 00       	call   80101550 <ilock>

  return n;
}
80100548:	89 f0                	mov    %esi,%eax
8010054a:	83 c4 1c             	add    $0x1c,%esp
8010054d:	5b                   	pop    %ebx
8010054e:	5e                   	pop    %esi
8010054f:	5f                   	pop    %edi
80100550:	5d                   	pop    %ebp
80100551:	c3                   	ret    
80100552:	66 90                	xchg   %ax,%ax

80100554 <printint>:
{
80100554:	55                   	push   %ebp
80100555:	89 e5                	mov    %esp,%ebp
80100557:	57                   	push   %edi
80100558:	56                   	push   %esi
80100559:	53                   	push   %ebx
8010055a:	83 ec 1c             	sub    $0x1c,%esp
8010055d:	89 d6                	mov    %edx,%esi
  if(sign && (sign = xx < 0))
8010055f:	85 c9                	test   %ecx,%ecx
80100561:	74 4d                	je     801005b0 <printint+0x5c>
80100563:	85 c0                	test   %eax,%eax
80100565:	79 49                	jns    801005b0 <printint+0x5c>
    x = -xx;
80100567:	f7 d8                	neg    %eax
80100569:	bf 01 00 00 00       	mov    $0x1,%edi
  i = 0;
8010056e:	31 c9                	xor    %ecx,%ecx
80100570:	eb 04                	jmp    80100576 <printint+0x22>
80100572:	66 90                	xchg   %ax,%ax
    buf[i++] = digits[x % base];
80100574:	89 d9                	mov    %ebx,%ecx
80100576:	31 d2                	xor    %edx,%edx
80100578:	f7 f6                	div    %esi
8010057a:	8a 92 d0 6d 10 80    	mov    -0x7fef9230(%edx),%dl
80100580:	88 54 0d d8          	mov    %dl,-0x28(%ebp,%ecx,1)
80100584:	8d 59 01             	lea    0x1(%ecx),%ebx
  }while((x /= base) != 0);
80100587:	85 c0                	test   %eax,%eax
80100589:	75 e9                	jne    80100574 <printint+0x20>
  if(sign)
8010058b:	85 ff                	test   %edi,%edi
8010058d:	74 08                	je     80100597 <printint+0x43>
    buf[i++] = '-';
8010058f:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
80100594:	8d 59 02             	lea    0x2(%ecx),%ebx
  while(--i >= 0)
80100597:	4b                   	dec    %ebx
    consputc(buf[i]);
80100598:	0f be 44 1d d8       	movsbl -0x28(%ebp,%ebx,1),%eax
8010059d:	e8 ea fd ff ff       	call   8010038c <consputc>
  while(--i >= 0)
801005a2:	4b                   	dec    %ebx
801005a3:	83 fb ff             	cmp    $0xffffffff,%ebx
801005a6:	75 f0                	jne    80100598 <printint+0x44>
}
801005a8:	83 c4 1c             	add    $0x1c,%esp
801005ab:	5b                   	pop    %ebx
801005ac:	5e                   	pop    %esi
801005ad:	5f                   	pop    %edi
801005ae:	5d                   	pop    %ebp
801005af:	c3                   	ret    
    x = xx;
801005b0:	31 ff                	xor    %edi,%edi
801005b2:	eb ba                	jmp    8010056e <printint+0x1a>

801005b4 <cprintf>:
{
801005b4:	55                   	push   %ebp
801005b5:	89 e5                	mov    %esp,%ebp
801005b7:	57                   	push   %edi
801005b8:	56                   	push   %esi
801005b9:	53                   	push   %ebx
801005ba:	83 ec 2c             	sub    $0x2c,%esp
  locking = cons.locking;
801005bd:	a1 54 a5 10 80       	mov    0x8010a554,%eax
801005c2:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
801005c5:	85 c0                	test   %eax,%eax
801005c7:	0f 85 0b 01 00 00    	jne    801006d8 <cprintf+0x124>
  if (fmt == 0)
801005cd:	8b 75 08             	mov    0x8(%ebp),%esi
801005d0:	85 f6                	test   %esi,%esi
801005d2:	0f 84 1b 01 00 00    	je     801006f3 <cprintf+0x13f>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801005d8:	0f b6 06             	movzbl (%esi),%eax
801005db:	85 c0                	test   %eax,%eax
801005dd:	74 7d                	je     8010065c <cprintf+0xa8>
  argp = (uint*)(void*)(&fmt + 1);
801005df:	8d 55 0c             	lea    0xc(%ebp),%edx
801005e2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801005e5:	31 db                	xor    %ebx,%ebx
801005e7:	eb 31                	jmp    8010061a <cprintf+0x66>
801005e9:	8d 76 00             	lea    0x0(%esi),%esi
    switch(c){
801005ec:	83 fa 25             	cmp    $0x25,%edx
801005ef:	0f 84 a3 00 00 00    	je     80100698 <cprintf+0xe4>
801005f5:	83 fa 64             	cmp    $0x64,%edx
801005f8:	74 7e                	je     80100678 <cprintf+0xc4>
      consputc('%');
801005fa:	b8 25 00 00 00       	mov    $0x25,%eax
801005ff:	89 55 dc             	mov    %edx,-0x24(%ebp)
80100602:	e8 85 fd ff ff       	call   8010038c <consputc>
      consputc(c);
80100607:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010060a:	89 d0                	mov    %edx,%eax
8010060c:	e8 7b fd ff ff       	call   8010038c <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100611:	43                   	inc    %ebx
80100612:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100616:	85 c0                	test   %eax,%eax
80100618:	74 42                	je     8010065c <cprintf+0xa8>
    if(c != '%'){
8010061a:	83 f8 25             	cmp    $0x25,%eax
8010061d:	75 ed                	jne    8010060c <cprintf+0x58>
    c = fmt[++i] & 0xff;
8010061f:	43                   	inc    %ebx
80100620:	0f b6 14 1e          	movzbl (%esi,%ebx,1),%edx
    if(c == 0)
80100624:	85 d2                	test   %edx,%edx
80100626:	74 34                	je     8010065c <cprintf+0xa8>
    switch(c){
80100628:	83 fa 70             	cmp    $0x70,%edx
8010062b:	74 0c                	je     80100639 <cprintf+0x85>
8010062d:	7e bd                	jle    801005ec <cprintf+0x38>
8010062f:	83 fa 73             	cmp    $0x73,%edx
80100632:	74 74                	je     801006a8 <cprintf+0xf4>
80100634:	83 fa 78             	cmp    $0x78,%edx
80100637:	75 c1                	jne    801005fa <cprintf+0x46>
      printint(*argp++, 16, 0);
80100639:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010063c:	8b 02                	mov    (%edx),%eax
8010063e:	83 c2 04             	add    $0x4,%edx
80100641:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80100644:	31 c9                	xor    %ecx,%ecx
80100646:	ba 10 00 00 00       	mov    $0x10,%edx
8010064b:	e8 04 ff ff ff       	call   80100554 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100650:	43                   	inc    %ebx
80100651:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100655:	85 c0                	test   %eax,%eax
80100657:	75 c1                	jne    8010061a <cprintf+0x66>
80100659:	8d 76 00             	lea    0x0(%esi),%esi
  if(locking)
8010065c:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010065f:	85 c9                	test   %ecx,%ecx
80100661:	74 0c                	je     8010066f <cprintf+0xbb>
    release(&cons.lock);
80100663:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010066a:	e8 2d 3e 00 00       	call   8010449c <release>
}
8010066f:	83 c4 2c             	add    $0x2c,%esp
80100672:	5b                   	pop    %ebx
80100673:	5e                   	pop    %esi
80100674:	5f                   	pop    %edi
80100675:	5d                   	pop    %ebp
80100676:	c3                   	ret    
80100677:	90                   	nop
      printint(*argp++, 10, 1);
80100678:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010067b:	8b 02                	mov    (%edx),%eax
8010067d:	83 c2 04             	add    $0x4,%edx
80100680:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80100683:	b9 01 00 00 00       	mov    $0x1,%ecx
80100688:	ba 0a 00 00 00       	mov    $0xa,%edx
8010068d:	e8 c2 fe ff ff       	call   80100554 <printint>
      break;
80100692:	e9 7a ff ff ff       	jmp    80100611 <cprintf+0x5d>
80100697:	90                   	nop
      consputc('%');
80100698:	b8 25 00 00 00       	mov    $0x25,%eax
8010069d:	e8 ea fc ff ff       	call   8010038c <consputc>
      break;
801006a2:	e9 6a ff ff ff       	jmp    80100611 <cprintf+0x5d>
801006a7:	90                   	nop
      if((s = (char*)*argp++) == 0)
801006a8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801006ab:	8b 38                	mov    (%eax),%edi
801006ad:	83 c0 04             	add    $0x4,%eax
801006b0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006b3:	85 ff                	test   %edi,%edi
801006b5:	74 35                	je     801006ec <cprintf+0x138>
      for(; *s; s++)
801006b7:	0f be 07             	movsbl (%edi),%eax
801006ba:	84 c0                	test   %al,%al
801006bc:	0f 84 4f ff ff ff    	je     80100611 <cprintf+0x5d>
801006c2:	66 90                	xchg   %ax,%ax
        consputc(*s);
801006c4:	e8 c3 fc ff ff       	call   8010038c <consputc>
      for(; *s; s++)
801006c9:	47                   	inc    %edi
801006ca:	0f be 07             	movsbl (%edi),%eax
801006cd:	84 c0                	test   %al,%al
801006cf:	75 f3                	jne    801006c4 <cprintf+0x110>
801006d1:	e9 3b ff ff ff       	jmp    80100611 <cprintf+0x5d>
801006d6:	66 90                	xchg   %ax,%ax
    acquire(&cons.lock);
801006d8:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801006df:	e8 fc 3c 00 00       	call   801043e0 <acquire>
801006e4:	e9 e4 fe ff ff       	jmp    801005cd <cprintf+0x19>
801006e9:	8d 76 00             	lea    0x0(%esi),%esi
        s = "(null)";
801006ec:	bf b8 6d 10 80       	mov    $0x80106db8,%edi
801006f1:	eb c4                	jmp    801006b7 <cprintf+0x103>
    panic("null fmt");
801006f3:	c7 04 24 bf 6d 10 80 	movl   $0x80106dbf,(%esp)
801006fa:	e8 11 fc ff ff       	call   80100310 <panic>
801006ff:	90                   	nop

80100700 <consoleintr>:
{
80100700:	55                   	push   %ebp
80100701:	89 e5                	mov    %esp,%ebp
80100703:	57                   	push   %edi
80100704:	56                   	push   %esi
80100705:	53                   	push   %ebx
80100706:	83 ec 1c             	sub    $0x1c,%esp
80100709:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
8010070c:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100713:	e8 c8 3c 00 00       	call   801043e0 <acquire>
  int c, doprocdump = 0;
80100718:	31 f6                	xor    %esi,%esi
8010071a:	66 90                	xchg   %ax,%ax
  while((c = getc()) >= 0){
8010071c:	ff d3                	call   *%ebx
8010071e:	89 c7                	mov    %eax,%edi
80100720:	85 c0                	test   %eax,%eax
80100722:	0f 88 90 00 00 00    	js     801007b8 <consoleintr+0xb8>
    switch(c){
80100728:	83 ff 10             	cmp    $0x10,%edi
8010072b:	0f 84 d7 00 00 00    	je     80100808 <consoleintr+0x108>
80100731:	0f 8f 9d 00 00 00    	jg     801007d4 <consoleintr+0xd4>
80100737:	83 ff 08             	cmp    $0x8,%edi
8010073a:	0f 84 a2 00 00 00    	je     801007e2 <consoleintr+0xe2>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100740:	85 ff                	test   %edi,%edi
80100742:	74 d8                	je     8010071c <consoleintr+0x1c>
80100744:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100749:	89 c2                	mov    %eax,%edx
8010074b:	2b 15 a0 ff 10 80    	sub    0x8010ffa0,%edx
80100751:	83 fa 7f             	cmp    $0x7f,%edx
80100754:	77 c6                	ja     8010071c <consoleintr+0x1c>
        input.buf[input.e++ % INPUT_BUF] = c;
80100756:	89 c2                	mov    %eax,%edx
80100758:	83 e2 7f             	and    $0x7f,%edx
        c = (c == '\r') ? '\n' : c;
8010075b:	83 ff 0d             	cmp    $0xd,%edi
8010075e:	0f 84 04 01 00 00    	je     80100868 <consoleintr+0x168>
        input.buf[input.e++ % INPUT_BUF] = c;
80100764:	89 f9                	mov    %edi,%ecx
80100766:	88 8a 20 ff 10 80    	mov    %cl,-0x7fef00e0(%edx)
8010076c:	40                   	inc    %eax
8010076d:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(c);
80100772:	89 f8                	mov    %edi,%eax
80100774:	e8 13 fc ff ff       	call   8010038c <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100779:	83 ff 0a             	cmp    $0xa,%edi
8010077c:	0f 84 fd 00 00 00    	je     8010087f <consoleintr+0x17f>
80100782:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100787:	83 ff 04             	cmp    $0x4,%edi
8010078a:	74 0d                	je     80100799 <consoleintr+0x99>
8010078c:	8b 15 a0 ff 10 80    	mov    0x8010ffa0,%edx
80100792:	83 ea 80             	sub    $0xffffff80,%edx
80100795:	39 d0                	cmp    %edx,%eax
80100797:	75 83                	jne    8010071c <consoleintr+0x1c>
          input.w = input.e;
80100799:	a3 a4 ff 10 80       	mov    %eax,0x8010ffa4
          wakeup(&input.r);
8010079e:	c7 04 24 a0 ff 10 80 	movl   $0x8010ffa0,(%esp)
801007a5:	e8 9e 35 00 00       	call   80103d48 <wakeup>
  while((c = getc()) >= 0){
801007aa:	ff d3                	call   *%ebx
801007ac:	89 c7                	mov    %eax,%edi
801007ae:	85 c0                	test   %eax,%eax
801007b0:	0f 89 72 ff ff ff    	jns    80100728 <consoleintr+0x28>
801007b6:	66 90                	xchg   %ax,%ax
  release(&cons.lock);
801007b8:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801007bf:	e8 d8 3c 00 00       	call   8010449c <release>
  if(doprocdump) {
801007c4:	85 f6                	test   %esi,%esi
801007c6:	0f 85 90 00 00 00    	jne    8010085c <consoleintr+0x15c>
}
801007cc:	83 c4 1c             	add    $0x1c,%esp
801007cf:	5b                   	pop    %ebx
801007d0:	5e                   	pop    %esi
801007d1:	5f                   	pop    %edi
801007d2:	5d                   	pop    %ebp
801007d3:	c3                   	ret    
    switch(c){
801007d4:	83 ff 15             	cmp    $0x15,%edi
801007d7:	74 3b                	je     80100814 <consoleintr+0x114>
801007d9:	83 ff 7f             	cmp    $0x7f,%edi
801007dc:	0f 85 5e ff ff ff    	jne    80100740 <consoleintr+0x40>
      if(input.e != input.w){
801007e2:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801007e7:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801007ed:	0f 84 29 ff ff ff    	je     8010071c <consoleintr+0x1c>
        input.e--;
801007f3:	48                   	dec    %eax
801007f4:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
801007f9:	b8 00 01 00 00       	mov    $0x100,%eax
801007fe:	e8 89 fb ff ff       	call   8010038c <consputc>
80100803:	e9 14 ff ff ff       	jmp    8010071c <consoleintr+0x1c>
      doprocdump = 1;
80100808:	be 01 00 00 00       	mov    $0x1,%esi
8010080d:	e9 0a ff ff ff       	jmp    8010071c <consoleintr+0x1c>
80100812:	66 90                	xchg   %ax,%ax
      while(input.e != input.w &&
80100814:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100819:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
8010081f:	75 27                	jne    80100848 <consoleintr+0x148>
80100821:	e9 f6 fe ff ff       	jmp    8010071c <consoleintr+0x1c>
80100826:	66 90                	xchg   %ax,%ax
        input.e--;
80100828:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
8010082d:	b8 00 01 00 00       	mov    $0x100,%eax
80100832:	e8 55 fb ff ff       	call   8010038c <consputc>
      while(input.e != input.w &&
80100837:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010083c:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
80100842:	0f 84 d4 fe ff ff    	je     8010071c <consoleintr+0x1c>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100848:	48                   	dec    %eax
80100849:	89 c2                	mov    %eax,%edx
8010084b:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
8010084e:	80 ba 20 ff 10 80 0a 	cmpb   $0xa,-0x7fef00e0(%edx)
80100855:	75 d1                	jne    80100828 <consoleintr+0x128>
80100857:	e9 c0 fe ff ff       	jmp    8010071c <consoleintr+0x1c>
}
8010085c:	83 c4 1c             	add    $0x1c,%esp
8010085f:	5b                   	pop    %ebx
80100860:	5e                   	pop    %esi
80100861:	5f                   	pop    %edi
80100862:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100863:	e9 b8 35 00 00       	jmp    80103e20 <procdump>
        input.buf[input.e++ % INPUT_BUF] = c;
80100868:	c6 82 20 ff 10 80 0a 	movb   $0xa,-0x7fef00e0(%edx)
8010086f:	40                   	inc    %eax
80100870:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(c);
80100875:	b8 0a 00 00 00       	mov    $0xa,%eax
8010087a:	e8 0d fb ff ff       	call   8010038c <consputc>
8010087f:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100884:	e9 10 ff ff ff       	jmp    80100799 <consoleintr+0x99>
80100889:	8d 76 00             	lea    0x0(%esi),%esi

8010088c <consoleinit>:

void
consoleinit(void)
{
8010088c:	55                   	push   %ebp
8010088d:	89 e5                	mov    %esp,%ebp
8010088f:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
80100892:	c7 44 24 04 c8 6d 10 	movl   $0x80106dc8,0x4(%esp)
80100899:	80 
8010089a:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801008a1:	e8 72 3a 00 00       	call   80104318 <initlock>

  devsw[CONSOLE].write = consolewrite;
801008a6:	c7 05 6c 09 11 80 f4 	movl   $0x801004f4,0x8011096c
801008ad:	04 10 80 
  devsw[CONSOLE].read = consoleread;
801008b0:	c7 05 68 09 11 80 28 	movl   $0x80100228,0x80110968
801008b7:	02 10 80 
  cons.locking = 1;
801008ba:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
801008c1:	00 00 00 

  ioapicenable(IRQ_KBD, 0);
801008c4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801008cb:	00 
801008cc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801008d3:	e8 a4 17 00 00       	call   8010207c <ioapicenable>
}
801008d8:	c9                   	leave  
801008d9:	c3                   	ret    
801008da:	66 90                	xchg   %ax,%ax

801008dc <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801008dc:	55                   	push   %ebp
801008dd:	89 e5                	mov    %esp,%ebp
801008df:	57                   	push   %edi
801008e0:	56                   	push   %esi
801008e1:	53                   	push   %ebx
801008e2:	81 ec 2c 01 00 00    	sub    $0x12c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
801008e8:	e8 9b 29 00 00       	call   80103288 <myproc>
801008ed:	89 c7                	mov    %eax,%edi

  begin_op();
801008ef:	e8 a4 1e 00 00       	call   80102798 <begin_op>

  if((ip = namei(path)) == 0){
801008f4:	8b 55 08             	mov    0x8(%ebp),%edx
801008f7:	89 14 24             	mov    %edx,(%esp)
801008fa:	e8 29 14 00 00       	call   80101d28 <namei>
801008ff:	89 c3                	mov    %eax,%ebx
80100901:	85 c0                	test   %eax,%eax
80100903:	0f 84 cb 01 00 00    	je     80100ad4 <exec+0x1f8>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100909:	89 04 24             	mov    %eax,(%esp)
8010090c:	e8 3f 0c 00 00       	call   80101550 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100911:	c7 44 24 0c 34 00 00 	movl   $0x34,0xc(%esp)
80100918:	00 
80100919:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80100920:	00 
80100921:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100927:	89 44 24 04          	mov    %eax,0x4(%esp)
8010092b:	89 1c 24             	mov    %ebx,(%esp)
8010092e:	e8 b9 0e 00 00       	call   801017ec <readi>
80100933:	83 f8 34             	cmp    $0x34,%eax
80100936:	74 20                	je     80100958 <exec+0x7c>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100938:	89 1c 24             	mov    %ebx,(%esp)
8010093b:	e8 60 0e 00 00       	call   801017a0 <iunlockput>
    end_op();
80100940:	e8 af 1e 00 00       	call   801027f4 <end_op>
  }
  return -1;
80100945:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010094a:	81 c4 2c 01 00 00    	add    $0x12c,%esp
80100950:	5b                   	pop    %ebx
80100951:	5e                   	pop    %esi
80100952:	5f                   	pop    %edi
80100953:	5d                   	pop    %ebp
80100954:	c3                   	ret    
80100955:	8d 76 00             	lea    0x0(%esi),%esi
  if(elf.magic != ELF_MAGIC)
80100958:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
8010095f:	45 4c 46 
80100962:	75 d4                	jne    80100938 <exec+0x5c>
  if((pgdir = setupkvm()) == 0)
80100964:	e8 83 61 00 00       	call   80106aec <setupkvm>
80100969:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
8010096f:	85 c0                	test   %eax,%eax
80100971:	74 c5                	je     80100938 <exec+0x5c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100973:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100979:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100980:	00 
80100981:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
80100988:	00 00 00 
8010098b:	0f 84 e8 00 00 00    	je     80100a79 <exec+0x19d>
80100991:	31 d2                	xor    %edx,%edx
80100993:	89 bd ec fe ff ff    	mov    %edi,-0x114(%ebp)
80100999:	89 d7                	mov    %edx,%edi
8010099b:	eb 16                	jmp    801009b3 <exec+0xd7>
8010099d:	8d 76 00             	lea    0x0(%esi),%esi
801009a0:	47                   	inc    %edi
exec(char *path, char **argv)
801009a1:	83 c6 20             	add    $0x20,%esi
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
801009a4:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
801009ab:	39 f8                	cmp    %edi,%eax
801009ad:	0f 8e c0 00 00 00    	jle    80100a73 <exec+0x197>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
801009b3:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
801009ba:	00 
801009bb:	89 74 24 08          	mov    %esi,0x8(%esp)
801009bf:	8d 8d 04 ff ff ff    	lea    -0xfc(%ebp),%ecx
801009c5:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801009c9:	89 1c 24             	mov    %ebx,(%esp)
801009cc:	e8 1b 0e 00 00       	call   801017ec <readi>
801009d1:	83 f8 20             	cmp    $0x20,%eax
801009d4:	0f 85 86 00 00 00    	jne    80100a60 <exec+0x184>
    if(ph.type != ELF_PROG_LOAD)
801009da:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
801009e1:	75 bd                	jne    801009a0 <exec+0xc4>
    if(ph.memsz < ph.filesz)
801009e3:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
801009e9:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
801009ef:	72 6f                	jb     80100a60 <exec+0x184>
    if(ph.vaddr + ph.memsz < ph.vaddr)
801009f1:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
801009f7:	72 67                	jb     80100a60 <exec+0x184>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
801009f9:	89 44 24 08          	mov    %eax,0x8(%esp)
801009fd:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100a03:	89 44 24 04          	mov    %eax,0x4(%esp)
80100a07:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100a0d:	89 04 24             	mov    %eax,(%esp)
80100a10:	e8 33 5f 00 00       	call   80106948 <allocuvm>
80100a15:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100a1b:	85 c0                	test   %eax,%eax
80100a1d:	74 41                	je     80100a60 <exec+0x184>
    if(ph.vaddr % PGSIZE != 0)
80100a1f:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100a25:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100a2a:	75 34                	jne    80100a60 <exec+0x184>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100a2c:	8b 95 14 ff ff ff    	mov    -0xec(%ebp),%edx
80100a32:	89 54 24 10          	mov    %edx,0x10(%esp)
80100a36:	8b 95 08 ff ff ff    	mov    -0xf8(%ebp),%edx
80100a3c:	89 54 24 0c          	mov    %edx,0xc(%esp)
80100a40:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80100a44:	89 44 24 04          	mov    %eax,0x4(%esp)
80100a48:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100a4e:	89 04 24             	mov    %eax,(%esp)
80100a51:	e8 8e 5d 00 00       	call   801067e4 <loaduvm>
80100a56:	85 c0                	test   %eax,%eax
80100a58:	0f 89 42 ff ff ff    	jns    801009a0 <exec+0xc4>
80100a5e:	66 90                	xchg   %ax,%ax
    freevm(pgdir);
80100a60:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100a66:	89 04 24             	mov    %eax,(%esp)
80100a69:	e8 0a 60 00 00       	call   80106a78 <freevm>
80100a6e:	e9 c5 fe ff ff       	jmp    80100938 <exec+0x5c>
80100a73:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
  iunlockput(ip);
80100a79:	89 1c 24             	mov    %ebx,(%esp)
80100a7c:	e8 1f 0d 00 00       	call   801017a0 <iunlockput>
  end_op();
80100a81:	e8 6e 1d 00 00       	call   801027f4 <end_op>
  sz = PGROUNDUP(sz);
80100a86:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100a8c:	05 ff 0f 00 00       	add    $0xfff,%eax
80100a91:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100a96:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
80100a9c:	89 54 24 08          	mov    %edx,0x8(%esp)
80100aa0:	89 44 24 04          	mov    %eax,0x4(%esp)
80100aa4:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100aaa:	89 04 24             	mov    %eax,(%esp)
80100aad:	e8 96 5e 00 00       	call   80106948 <allocuvm>
80100ab2:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100ab8:	85 c0                	test   %eax,%eax
80100aba:	75 33                	jne    80100aef <exec+0x213>
    freevm(pgdir);
80100abc:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100ac2:	89 04 24             	mov    %eax,(%esp)
80100ac5:	e8 ae 5f 00 00       	call   80106a78 <freevm>
  return -1;
80100aca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100acf:	e9 76 fe ff ff       	jmp    8010094a <exec+0x6e>
    end_op();
80100ad4:	e8 1b 1d 00 00       	call   801027f4 <end_op>
    cprintf("exec: fail\n");
80100ad9:	c7 04 24 e1 6d 10 80 	movl   $0x80106de1,(%esp)
80100ae0:	e8 cf fa ff ff       	call   801005b4 <cprintf>
    return -1;
80100ae5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100aea:	e9 5b fe ff ff       	jmp    8010094a <exec+0x6e>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100aef:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100af5:	2d 00 20 00 00       	sub    $0x2000,%eax
80100afa:	89 44 24 04          	mov    %eax,0x4(%esp)
80100afe:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100b04:	89 04 24             	mov    %eax,(%esp)
80100b07:	e8 74 60 00 00       	call   80106b80 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100b0c:	8b 55 0c             	mov    0xc(%ebp),%edx
80100b0f:	8b 02                	mov    (%edx),%eax
80100b11:	85 c0                	test   %eax,%eax
80100b13:	0f 84 4e 01 00 00    	je     80100c67 <exec+0x38b>
exec(char *path, char **argv)
80100b19:	89 d1                	mov    %edx,%ecx
80100b1b:	83 c1 04             	add    $0x4,%ecx
80100b1e:	8b 9d f4 fe ff ff    	mov    -0x10c(%ebp),%ebx
  for(argc = 0; argv[argc]; argc++) {
80100b24:	31 f6                	xor    %esi,%esi
80100b26:	89 bd ec fe ff ff    	mov    %edi,-0x114(%ebp)
80100b2c:	89 cf                	mov    %ecx,%edi
80100b2e:	eb 08                	jmp    80100b38 <exec+0x25c>
80100b30:	83 c7 04             	add    $0x4,%edi
    if(argc >= MAXARG)
80100b33:	83 fe 20             	cmp    $0x20,%esi
80100b36:	74 84                	je     80100abc <exec+0x1e0>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100b38:	89 04 24             	mov    %eax,(%esp)
80100b3b:	e8 6c 3b 00 00       	call   801046ac <strlen>
80100b40:	f7 d0                	not    %eax
80100b42:	01 c3                	add    %eax,%ebx
80100b44:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100b47:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80100b4a:	8b 01                	mov    (%ecx),%eax
80100b4c:	89 04 24             	mov    %eax,(%esp)
80100b4f:	e8 58 3b 00 00       	call   801046ac <strlen>
80100b54:	40                   	inc    %eax
80100b55:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100b59:	8b 55 0c             	mov    0xc(%ebp),%edx
80100b5c:	8b 02                	mov    (%edx),%eax
80100b5e:	89 44 24 08          	mov    %eax,0x8(%esp)
80100b62:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100b66:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100b6c:	89 04 24             	mov    %eax,(%esp)
80100b6f:	e8 40 61 00 00       	call   80106cb4 <copyout>
80100b74:	85 c0                	test   %eax,%eax
80100b76:	0f 88 40 ff ff ff    	js     80100abc <exec+0x1e0>
    ustack[3+argc] = sp;
80100b7c:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100b82:	89 9c b5 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%esi,4)
  for(argc = 0; argv[argc]; argc++) {
80100b89:	46                   	inc    %esi
80100b8a:	89 7d 0c             	mov    %edi,0xc(%ebp)
80100b8d:	8b 07                	mov    (%edi),%eax
80100b8f:	85 c0                	test   %eax,%eax
80100b91:	75 9d                	jne    80100b30 <exec+0x254>
80100b93:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
  ustack[3+argc] = 0;
80100b99:	c7 84 b5 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%esi,4)
80100ba0:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
80100ba4:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100bab:	ff ff ff 
  ustack[1] = argc;
80100bae:	89 b5 5c ff ff ff    	mov    %esi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100bb4:	8d 04 b5 04 00 00 00 	lea    0x4(,%esi,4),%eax
80100bbb:	89 d9                	mov    %ebx,%ecx
80100bbd:	29 c1                	sub    %eax,%ecx
80100bbf:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  sp -= (3+argc+1) * 4;
80100bc5:	8d 04 b5 10 00 00 00 	lea    0x10(,%esi,4),%eax
80100bcc:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100bce:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100bd2:	89 54 24 08          	mov    %edx,0x8(%esp)
80100bd6:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100bda:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100be0:	89 04 24             	mov    %eax,(%esp)
80100be3:	e8 cc 60 00 00       	call   80106cb4 <copyout>
80100be8:	85 c0                	test   %eax,%eax
80100bea:	0f 88 cc fe ff ff    	js     80100abc <exec+0x1e0>
  for(last=s=path; *s; s++)
80100bf0:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100bf3:	8a 11                	mov    (%ecx),%dl
80100bf5:	84 d2                	test   %dl,%dl
80100bf7:	74 17                	je     80100c10 <exec+0x334>
exec(char *path, char **argv)
80100bf9:	89 c8                	mov    %ecx,%eax
80100bfb:	40                   	inc    %eax
80100bfc:	eb 09                	jmp    80100c07 <exec+0x32b>
80100bfe:	66 90                	xchg   %ax,%ax
  for(last=s=path; *s; s++)
80100c00:	8a 10                	mov    (%eax),%dl
80100c02:	40                   	inc    %eax
80100c03:	84 d2                	test   %dl,%dl
80100c05:	74 0c                	je     80100c13 <exec+0x337>
    if(*s == '/')
80100c07:	80 fa 2f             	cmp    $0x2f,%dl
80100c0a:	75 f4                	jne    80100c00 <exec+0x324>
      last = s+1;
80100c0c:	89 c1                	mov    %eax,%ecx
80100c0e:	eb f0                	jmp    80100c00 <exec+0x324>
  for(last=s=path; *s; s++)
80100c10:	8b 4d 08             	mov    0x8(%ebp),%ecx
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100c13:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80100c1a:	00 
80100c1b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80100c1f:	8d 47 6c             	lea    0x6c(%edi),%eax
80100c22:	89 04 24             	mov    %eax,(%esp)
80100c25:	e8 52 3a 00 00       	call   8010467c <safestrcpy>
  oldpgdir = curproc->pgdir;
80100c2a:	8b 77 04             	mov    0x4(%edi),%esi
  curproc->pgdir = pgdir;
80100c2d:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100c33:	89 47 04             	mov    %eax,0x4(%edi)
  curproc->sz = sz;
80100c36:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100c3c:	89 07                	mov    %eax,(%edi)
  curproc->tf->eip = elf.entry;  // main
80100c3e:	8b 47 18             	mov    0x18(%edi),%eax
80100c41:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100c47:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100c4a:	8b 47 18             	mov    0x18(%edi),%eax
80100c4d:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100c50:	89 3c 24             	mov    %edi,(%esp)
80100c53:	e8 10 5a 00 00       	call   80106668 <switchuvm>
  freevm(oldpgdir);
80100c58:	89 34 24             	mov    %esi,(%esp)
80100c5b:	e8 18 5e 00 00       	call   80106a78 <freevm>
  return 0;
80100c60:	31 c0                	xor    %eax,%eax
80100c62:	e9 e3 fc ff ff       	jmp    8010094a <exec+0x6e>
  for(argc = 0; argv[argc]; argc++) {
80100c67:	8b 9d f4 fe ff ff    	mov    -0x10c(%ebp),%ebx
80100c6d:	31 f6                	xor    %esi,%esi
80100c6f:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c75:	e9 1f ff ff ff       	jmp    80100b99 <exec+0x2bd>
80100c7a:	66 90                	xchg   %ax,%ax

80100c7c <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100c7c:	55                   	push   %ebp
80100c7d:	89 e5                	mov    %esp,%ebp
80100c7f:	83 ec 18             	sub    $0x18,%esp
  initlock(&ftable.lock, "ftable");
80100c82:	c7 44 24 04 ed 6d 10 	movl   $0x80106ded,0x4(%esp)
80100c89:	80 
80100c8a:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100c91:	e8 82 36 00 00       	call   80104318 <initlock>
}
80100c96:	c9                   	leave  
80100c97:	c3                   	ret    

80100c98 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100c98:	55                   	push   %ebp
80100c99:	89 e5                	mov    %esp,%ebp
80100c9b:	53                   	push   %ebx
80100c9c:	83 ec 14             	sub    $0x14,%esp
  struct file *f;

  acquire(&ftable.lock);
80100c9f:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100ca6:	e8 35 37 00 00       	call   801043e0 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100cab:	bb f4 ff 10 80       	mov    $0x8010fff4,%ebx
80100cb0:	eb 0d                	jmp    80100cbf <filealloc+0x27>
80100cb2:	66 90                	xchg   %ax,%ax
80100cb4:	83 c3 18             	add    $0x18,%ebx
80100cb7:	81 fb 54 09 11 80    	cmp    $0x80110954,%ebx
80100cbd:	74 25                	je     80100ce4 <filealloc+0x4c>
    if(f->ref == 0){
80100cbf:	8b 43 04             	mov    0x4(%ebx),%eax
80100cc2:	85 c0                	test   %eax,%eax
80100cc4:	75 ee                	jne    80100cb4 <filealloc+0x1c>
      f->ref = 1;
80100cc6:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100ccd:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100cd4:	e8 c3 37 00 00       	call   8010449c <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100cd9:	89 d8                	mov    %ebx,%eax
80100cdb:	83 c4 14             	add    $0x14,%esp
80100cde:	5b                   	pop    %ebx
80100cdf:	5d                   	pop    %ebp
80100ce0:	c3                   	ret    
80100ce1:	8d 76 00             	lea    0x0(%esi),%esi
  release(&ftable.lock);
80100ce4:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100ceb:	e8 ac 37 00 00       	call   8010449c <release>
  return 0;
80100cf0:	31 db                	xor    %ebx,%ebx
}
80100cf2:	89 d8                	mov    %ebx,%eax
80100cf4:	83 c4 14             	add    $0x14,%esp
80100cf7:	5b                   	pop    %ebx
80100cf8:	5d                   	pop    %ebp
80100cf9:	c3                   	ret    
80100cfa:	66 90                	xchg   %ax,%ax

80100cfc <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100cfc:	55                   	push   %ebp
80100cfd:	89 e5                	mov    %esp,%ebp
80100cff:	53                   	push   %ebx
80100d00:	83 ec 14             	sub    $0x14,%esp
80100d03:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100d06:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100d0d:	e8 ce 36 00 00       	call   801043e0 <acquire>
  if(f->ref < 1)
80100d12:	8b 43 04             	mov    0x4(%ebx),%eax
80100d15:	85 c0                	test   %eax,%eax
80100d17:	7e 18                	jle    80100d31 <filedup+0x35>
    panic("filedup");
  f->ref++;
80100d19:	40                   	inc    %eax
80100d1a:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100d1d:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100d24:	e8 73 37 00 00       	call   8010449c <release>
  return f;
}
80100d29:	89 d8                	mov    %ebx,%eax
80100d2b:	83 c4 14             	add    $0x14,%esp
80100d2e:	5b                   	pop    %ebx
80100d2f:	5d                   	pop    %ebp
80100d30:	c3                   	ret    
    panic("filedup");
80100d31:	c7 04 24 f4 6d 10 80 	movl   $0x80106df4,(%esp)
80100d38:	e8 d3 f5 ff ff       	call   80100310 <panic>
80100d3d:	8d 76 00             	lea    0x0(%esi),%esi

80100d40 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100d40:	55                   	push   %ebp
80100d41:	89 e5                	mov    %esp,%ebp
80100d43:	57                   	push   %edi
80100d44:	56                   	push   %esi
80100d45:	53                   	push   %ebx
80100d46:	83 ec 2c             	sub    $0x2c,%esp
80100d49:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct file ff;

  acquire(&ftable.lock);
80100d4c:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100d53:	e8 88 36 00 00       	call   801043e0 <acquire>
  if(f->ref < 1)
80100d58:	8b 57 04             	mov    0x4(%edi),%edx
80100d5b:	85 d2                	test   %edx,%edx
80100d5d:	0f 8e 85 00 00 00    	jle    80100de8 <fileclose+0xa8>
    panic("fileclose");
  if(--f->ref > 0){
80100d63:	4a                   	dec    %edx
80100d64:	89 57 04             	mov    %edx,0x4(%edi)
80100d67:	85 d2                	test   %edx,%edx
80100d69:	74 15                	je     80100d80 <fileclose+0x40>
    release(&ftable.lock);
80100d6b:	c7 45 08 c0 ff 10 80 	movl   $0x8010ffc0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100d72:	83 c4 2c             	add    $0x2c,%esp
80100d75:	5b                   	pop    %ebx
80100d76:	5e                   	pop    %esi
80100d77:	5f                   	pop    %edi
80100d78:	5d                   	pop    %ebp
    release(&ftable.lock);
80100d79:	e9 1e 37 00 00       	jmp    8010449c <release>
80100d7e:	66 90                	xchg   %ax,%ax
  ff = *f;
80100d80:	8b 1f                	mov    (%edi),%ebx
80100d82:	8a 47 09             	mov    0x9(%edi),%al
80100d85:	88 45 e7             	mov    %al,-0x19(%ebp)
80100d88:	8b 77 0c             	mov    0xc(%edi),%esi
80100d8b:	8b 47 10             	mov    0x10(%edi),%eax
80100d8e:	89 45 e0             	mov    %eax,-0x20(%ebp)
  f->type = FD_NONE;
80100d91:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
  release(&ftable.lock);
80100d97:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100d9e:	e8 f9 36 00 00       	call   8010449c <release>
  if(ff.type == FD_PIPE)
80100da3:	83 fb 01             	cmp    $0x1,%ebx
80100da6:	74 10                	je     80100db8 <fileclose+0x78>
  else if(ff.type == FD_INODE){
80100da8:	83 fb 02             	cmp    $0x2,%ebx
80100dab:	74 1f                	je     80100dcc <fileclose+0x8c>
}
80100dad:	83 c4 2c             	add    $0x2c,%esp
80100db0:	5b                   	pop    %ebx
80100db1:	5e                   	pop    %esi
80100db2:	5f                   	pop    %edi
80100db3:	5d                   	pop    %ebp
80100db4:	c3                   	ret    
80100db5:	8d 76 00             	lea    0x0(%esi),%esi
    pipeclose(ff.pipe, ff.writable);
80100db8:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
80100dbc:	89 44 24 04          	mov    %eax,0x4(%esp)
80100dc0:	89 34 24             	mov    %esi,(%esp)
80100dc3:	e8 8c 20 00 00       	call   80102e54 <pipeclose>
80100dc8:	eb e3                	jmp    80100dad <fileclose+0x6d>
80100dca:	66 90                	xchg   %ax,%ax
    begin_op();
80100dcc:	e8 c7 19 00 00       	call   80102798 <begin_op>
    iput(ff.ip);
80100dd1:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100dd4:	89 04 24             	mov    %eax,(%esp)
80100dd7:	e8 84 08 00 00       	call   80101660 <iput>
}
80100ddc:	83 c4 2c             	add    $0x2c,%esp
80100ddf:	5b                   	pop    %ebx
80100de0:	5e                   	pop    %esi
80100de1:	5f                   	pop    %edi
80100de2:	5d                   	pop    %ebp
    end_op();
80100de3:	e9 0c 1a 00 00       	jmp    801027f4 <end_op>
    panic("fileclose");
80100de8:	c7 04 24 fc 6d 10 80 	movl   $0x80106dfc,(%esp)
80100def:	e8 1c f5 ff ff       	call   80100310 <panic>

80100df4 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100df4:	55                   	push   %ebp
80100df5:	89 e5                	mov    %esp,%ebp
80100df7:	53                   	push   %ebx
80100df8:	83 ec 14             	sub    $0x14,%esp
80100dfb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100dfe:	83 3b 02             	cmpl   $0x2,(%ebx)
80100e01:	75 31                	jne    80100e34 <filestat+0x40>
    ilock(f->ip);
80100e03:	8b 43 10             	mov    0x10(%ebx),%eax
80100e06:	89 04 24             	mov    %eax,(%esp)
80100e09:	e8 42 07 00 00       	call   80101550 <ilock>
    stati(f->ip, st);
80100e0e:	8b 45 0c             	mov    0xc(%ebp),%eax
80100e11:	89 44 24 04          	mov    %eax,0x4(%esp)
80100e15:	8b 43 10             	mov    0x10(%ebx),%eax
80100e18:	89 04 24             	mov    %eax,(%esp)
80100e1b:	e8 a0 09 00 00       	call   801017c0 <stati>
    iunlock(f->ip);
80100e20:	8b 43 10             	mov    0x10(%ebx),%eax
80100e23:	89 04 24             	mov    %eax,(%esp)
80100e26:	e8 f5 07 00 00       	call   80101620 <iunlock>
    return 0;
80100e2b:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100e2d:	83 c4 14             	add    $0x14,%esp
80100e30:	5b                   	pop    %ebx
80100e31:	5d                   	pop    %ebp
80100e32:	c3                   	ret    
80100e33:	90                   	nop
  return -1;
80100e34:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100e39:	83 c4 14             	add    $0x14,%esp
80100e3c:	5b                   	pop    %ebx
80100e3d:	5d                   	pop    %ebp
80100e3e:	c3                   	ret    
80100e3f:	90                   	nop

80100e40 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100e40:	55                   	push   %ebp
80100e41:	89 e5                	mov    %esp,%ebp
80100e43:	57                   	push   %edi
80100e44:	56                   	push   %esi
80100e45:	53                   	push   %ebx
80100e46:	83 ec 2c             	sub    $0x2c,%esp
80100e49:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100e4c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100e4f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100e52:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100e56:	74 68                	je     80100ec0 <fileread+0x80>
    return -1;
  if(f->type == FD_PIPE)
80100e58:	8b 03                	mov    (%ebx),%eax
80100e5a:	83 f8 01             	cmp    $0x1,%eax
80100e5d:	74 4d                	je     80100eac <fileread+0x6c>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100e5f:	83 f8 02             	cmp    $0x2,%eax
80100e62:	75 63                	jne    80100ec7 <fileread+0x87>
    ilock(f->ip);
80100e64:	8b 43 10             	mov    0x10(%ebx),%eax
80100e67:	89 04 24             	mov    %eax,(%esp)
80100e6a:	e8 e1 06 00 00       	call   80101550 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100e6f:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80100e73:	8b 43 14             	mov    0x14(%ebx),%eax
80100e76:	89 44 24 08          	mov    %eax,0x8(%esp)
80100e7a:	89 74 24 04          	mov    %esi,0x4(%esp)
80100e7e:	8b 43 10             	mov    0x10(%ebx),%eax
80100e81:	89 04 24             	mov    %eax,(%esp)
80100e84:	e8 63 09 00 00       	call   801017ec <readi>
80100e89:	85 c0                	test   %eax,%eax
80100e8b:	7e 03                	jle    80100e90 <fileread+0x50>
      f->off += r;
80100e8d:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100e90:	8b 53 10             	mov    0x10(%ebx),%edx
80100e93:	89 14 24             	mov    %edx,(%esp)
80100e96:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100e99:	e8 82 07 00 00       	call   80101620 <iunlock>
    return r;
80100e9e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  }
  panic("fileread");
}
80100ea1:	83 c4 2c             	add    $0x2c,%esp
80100ea4:	5b                   	pop    %ebx
80100ea5:	5e                   	pop    %esi
80100ea6:	5f                   	pop    %edi
80100ea7:	5d                   	pop    %ebp
80100ea8:	c3                   	ret    
80100ea9:	8d 76 00             	lea    0x0(%esi),%esi
    return piperead(f->pipe, addr, n);
80100eac:	8b 43 0c             	mov    0xc(%ebx),%eax
80100eaf:	89 45 08             	mov    %eax,0x8(%ebp)
}
80100eb2:	83 c4 2c             	add    $0x2c,%esp
80100eb5:	5b                   	pop    %ebx
80100eb6:	5e                   	pop    %esi
80100eb7:	5f                   	pop    %edi
80100eb8:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80100eb9:	e9 f6 20 00 00       	jmp    80102fb4 <piperead>
80100ebe:	66 90                	xchg   %ax,%ax
    return -1;
80100ec0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100ec5:	eb da                	jmp    80100ea1 <fileread+0x61>
  panic("fileread");
80100ec7:	c7 04 24 06 6e 10 80 	movl   $0x80106e06,(%esp)
80100ece:	e8 3d f4 ff ff       	call   80100310 <panic>
80100ed3:	90                   	nop

80100ed4 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100ed4:	55                   	push   %ebp
80100ed5:	89 e5                	mov    %esp,%ebp
80100ed7:	57                   	push   %edi
80100ed8:	56                   	push   %esi
80100ed9:	53                   	push   %ebx
80100eda:	83 ec 2c             	sub    $0x2c,%esp
80100edd:	8b 7d 08             	mov    0x8(%ebp),%edi
80100ee0:	8b 45 0c             	mov    0xc(%ebp),%eax
80100ee3:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100ee6:	8b 45 10             	mov    0x10(%ebp),%eax
80100ee9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int r;

  if(f->writable == 0)
80100eec:	80 7f 09 00          	cmpb   $0x0,0x9(%edi)
80100ef0:	0f 84 a9 00 00 00    	je     80100f9f <filewrite+0xcb>
    return -1;
  if(f->type == FD_PIPE)
80100ef6:	8b 07                	mov    (%edi),%eax
80100ef8:	83 f8 01             	cmp    $0x1,%eax
80100efb:	0f 84 c3 00 00 00    	je     80100fc4 <filewrite+0xf0>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f01:	83 f8 02             	cmp    $0x2,%eax
80100f04:	0f 85 d8 00 00 00    	jne    80100fe2 <filewrite+0x10e>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80100f0a:	31 db                	xor    %ebx,%ebx
80100f0c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100f0f:	85 d2                	test   %edx,%edx
80100f11:	7f 2d                	jg     80100f40 <filewrite+0x6c>
80100f13:	e9 9c 00 00 00       	jmp    80100fb4 <filewrite+0xe0>
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80100f18:	01 47 14             	add    %eax,0x14(%edi)
      iunlock(f->ip);
80100f1b:	8b 4f 10             	mov    0x10(%edi),%ecx
80100f1e:	89 0c 24             	mov    %ecx,(%esp)
80100f21:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100f24:	e8 f7 06 00 00       	call   80101620 <iunlock>
      end_op();
80100f29:	e8 c6 18 00 00       	call   801027f4 <end_op>
80100f2e:	8b 45 dc             	mov    -0x24(%ebp),%eax

      if(r < 0)
        break;
      if(r != n1)
80100f31:	39 f0                	cmp    %esi,%eax
80100f33:	0f 85 9d 00 00 00    	jne    80100fd6 <filewrite+0x102>
        panic("short filewrite");
      i += r;
80100f39:	01 c3                	add    %eax,%ebx
    while(i < n){
80100f3b:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
80100f3e:	7e 74                	jle    80100fb4 <filewrite+0xe0>
80100f40:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80100f43:	29 de                	sub    %ebx,%esi
80100f45:	81 fe 00 1a 00 00    	cmp    $0x1a00,%esi
80100f4b:	7e 05                	jle    80100f52 <filewrite+0x7e>
80100f4d:	be 00 1a 00 00       	mov    $0x1a00,%esi
      begin_op();
80100f52:	e8 41 18 00 00       	call   80102798 <begin_op>
      ilock(f->ip);
80100f57:	8b 47 10             	mov    0x10(%edi),%eax
80100f5a:	89 04 24             	mov    %eax,(%esp)
80100f5d:	e8 ee 05 00 00       	call   80101550 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80100f62:	89 74 24 0c          	mov    %esi,0xc(%esp)
80100f66:	8b 47 14             	mov    0x14(%edi),%eax
80100f69:	89 44 24 08          	mov    %eax,0x8(%esp)
80100f6d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100f70:	01 d8                	add    %ebx,%eax
80100f72:	89 44 24 04          	mov    %eax,0x4(%esp)
80100f76:	8b 47 10             	mov    0x10(%edi),%eax
80100f79:	89 04 24             	mov    %eax,(%esp)
80100f7c:	e8 6f 09 00 00       	call   801018f0 <writei>
80100f81:	85 c0                	test   %eax,%eax
80100f83:	7f 93                	jg     80100f18 <filewrite+0x44>
      iunlock(f->ip);
80100f85:	8b 4f 10             	mov    0x10(%edi),%ecx
80100f88:	89 0c 24             	mov    %ecx,(%esp)
80100f8b:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100f8e:	e8 8d 06 00 00       	call   80101620 <iunlock>
      end_op();
80100f93:	e8 5c 18 00 00       	call   801027f4 <end_op>
      if(r < 0)
80100f98:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100f9b:	85 c0                	test   %eax,%eax
80100f9d:	74 92                	je     80100f31 <filewrite+0x5d>
    return -1;
80100f9f:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
80100fa6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100fa9:	83 c4 2c             	add    $0x2c,%esp
80100fac:	5b                   	pop    %ebx
80100fad:	5e                   	pop    %esi
80100fae:	5f                   	pop    %edi
80100faf:	5d                   	pop    %ebp
80100fb0:	c3                   	ret    
80100fb1:	8d 76 00             	lea    0x0(%esi),%esi
    return i == n ? n : -1;
80100fb4:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
80100fb7:	75 e6                	jne    80100f9f <filewrite+0xcb>
}
80100fb9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100fbc:	83 c4 2c             	add    $0x2c,%esp
80100fbf:	5b                   	pop    %ebx
80100fc0:	5e                   	pop    %esi
80100fc1:	5f                   	pop    %edi
80100fc2:	5d                   	pop    %ebp
80100fc3:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
80100fc4:	8b 47 0c             	mov    0xc(%edi),%eax
80100fc7:	89 45 08             	mov    %eax,0x8(%ebp)
}
80100fca:	83 c4 2c             	add    $0x2c,%esp
80100fcd:	5b                   	pop    %ebx
80100fce:	5e                   	pop    %esi
80100fcf:	5f                   	pop    %edi
80100fd0:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
80100fd1:	e9 06 1f 00 00       	jmp    80102edc <pipewrite>
        panic("short filewrite");
80100fd6:	c7 04 24 0f 6e 10 80 	movl   $0x80106e0f,(%esp)
80100fdd:	e8 2e f3 ff ff       	call   80100310 <panic>
  panic("filewrite");
80100fe2:	c7 04 24 15 6e 10 80 	movl   $0x80106e15,(%esp)
80100fe9:	e8 22 f3 ff ff       	call   80100310 <panic>
80100fee:	66 90                	xchg   %ax,%ax

80100ff0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80100ff0:	55                   	push   %ebp
80100ff1:	89 e5                	mov    %esp,%ebp
80100ff3:	57                   	push   %edi
80100ff4:	56                   	push   %esi
80100ff5:	53                   	push   %ebx
80100ff6:	83 ec 2c             	sub    $0x2c,%esp
80100ff9:	89 c7                	mov    %eax,%edi
80100ffb:	89 d3                	mov    %edx,%ebx
  struct inode *ip, *empty;

  acquire(&icache.lock);
80100ffd:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101004:	e8 d7 33 00 00       	call   801043e0 <acquire>

  // Is the inode already cached?
  empty = 0;
80101009:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010100b:	b8 14 0a 11 80       	mov    $0x80110a14,%eax
80101010:	eb 12                	jmp    80101024 <iget+0x34>
80101012:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101014:	85 f6                	test   %esi,%esi
80101016:	74 3c                	je     80101054 <iget+0x64>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101018:	05 90 00 00 00       	add    $0x90,%eax
8010101d:	3d 34 26 11 80       	cmp    $0x80112634,%eax
80101022:	74 44                	je     80101068 <iget+0x78>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101024:	8b 48 08             	mov    0x8(%eax),%ecx
80101027:	85 c9                	test   %ecx,%ecx
80101029:	7e e9                	jle    80101014 <iget+0x24>
8010102b:	39 38                	cmp    %edi,(%eax)
8010102d:	75 e5                	jne    80101014 <iget+0x24>
8010102f:	39 58 04             	cmp    %ebx,0x4(%eax)
80101032:	75 e0                	jne    80101014 <iget+0x24>
      ip->ref++;
80101034:	41                   	inc    %ecx
80101035:	89 48 08             	mov    %ecx,0x8(%eax)
      release(&icache.lock);
80101038:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010103f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101042:	e8 55 34 00 00       	call   8010449c <release>
      return ip;
80101047:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);

  return ip;
}
8010104a:	83 c4 2c             	add    $0x2c,%esp
8010104d:	5b                   	pop    %ebx
8010104e:	5e                   	pop    %esi
8010104f:	5f                   	pop    %edi
80101050:	5d                   	pop    %ebp
80101051:	c3                   	ret    
80101052:	66 90                	xchg   %ax,%ax
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101054:	85 c9                	test   %ecx,%ecx
80101056:	75 c0                	jne    80101018 <iget+0x28>
80101058:	89 c6                	mov    %eax,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010105a:	05 90 00 00 00       	add    $0x90,%eax
8010105f:	3d 34 26 11 80       	cmp    $0x80112634,%eax
80101064:	75 be                	jne    80101024 <iget+0x34>
80101066:	66 90                	xchg   %ax,%ax
  if(empty == 0)
80101068:	85 f6                	test   %esi,%esi
8010106a:	74 29                	je     80101095 <iget+0xa5>
  ip->dev = dev;
8010106c:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
8010106e:	89 5e 04             	mov    %ebx,0x4(%esi)
  ip->ref = 1;
80101071:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101078:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
8010107f:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101086:	e8 11 34 00 00       	call   8010449c <release>
  return ip;
8010108b:	89 f0                	mov    %esi,%eax
}
8010108d:	83 c4 2c             	add    $0x2c,%esp
80101090:	5b                   	pop    %ebx
80101091:	5e                   	pop    %esi
80101092:	5f                   	pop    %edi
80101093:	5d                   	pop    %ebp
80101094:	c3                   	ret    
    panic("iget: no inodes");
80101095:	c7 04 24 1f 6e 10 80 	movl   $0x80106e1f,(%esp)
8010109c:	e8 6f f2 ff ff       	call   80100310 <panic>
801010a1:	8d 76 00             	lea    0x0(%esi),%esi

801010a4 <balloc>:
{
801010a4:	55                   	push   %ebp
801010a5:	89 e5                	mov    %esp,%ebp
801010a7:	57                   	push   %edi
801010a8:	56                   	push   %esi
801010a9:	53                   	push   %ebx
801010aa:	83 ec 2c             	sub    $0x2c,%esp
801010ad:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801010b0:	a1 c0 09 11 80       	mov    0x801109c0,%eax
801010b5:	85 c0                	test   %eax,%eax
801010b7:	0f 84 83 00 00 00    	je     80101140 <balloc+0x9c>
801010bd:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
801010c4:	8b 45 dc             	mov    -0x24(%ebp),%eax
801010c7:	c1 f8 0c             	sar    $0xc,%eax
801010ca:	03 05 d8 09 11 80    	add    0x801109d8,%eax
801010d0:	89 44 24 04          	mov    %eax,0x4(%esp)
801010d4:	8b 45 d8             	mov    -0x28(%ebp),%eax
801010d7:	89 04 24             	mov    %eax,(%esp)
801010da:	e8 d5 ef ff ff       	call   801000b4 <bread>
801010df:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801010e2:	8b 15 c0 09 11 80    	mov    0x801109c0,%edx
801010e8:	89 55 e0             	mov    %edx,-0x20(%ebp)
801010eb:	8b 75 dc             	mov    -0x24(%ebp),%esi
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801010ee:	31 c0                	xor    %eax,%eax
801010f0:	eb 2c                	jmp    8010111e <balloc+0x7a>
801010f2:	66 90                	xchg   %ax,%ax
      m = 1 << (bi % 8);
801010f4:	89 c1                	mov    %eax,%ecx
801010f6:	83 e1 07             	and    $0x7,%ecx
801010f9:	bf 01 00 00 00       	mov    $0x1,%edi
801010fe:	d3 e7                	shl    %cl,%edi
80101100:	89 f9                	mov    %edi,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101102:	89 c3                	mov    %eax,%ebx
80101104:	c1 fb 03             	sar    $0x3,%ebx
80101107:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010110a:	8a 54 1f 5c          	mov    0x5c(%edi,%ebx,1),%dl
8010110e:	0f b6 fa             	movzbl %dl,%edi
80101111:	85 cf                	test   %ecx,%edi
80101113:	74 37                	je     8010114c <balloc+0xa8>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101115:	40                   	inc    %eax
80101116:	46                   	inc    %esi
80101117:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010111c:	74 05                	je     80101123 <balloc+0x7f>
8010111e:	39 75 e0             	cmp    %esi,-0x20(%ebp)
80101121:	77 d1                	ja     801010f4 <balloc+0x50>
    brelse(bp);
80101123:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101126:	89 04 24             	mov    %eax,(%esp)
80101129:	e8 7a f0 ff ff       	call   801001a8 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010112e:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101135:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101138:	3b 15 c0 09 11 80    	cmp    0x801109c0,%edx
8010113e:	72 84                	jb     801010c4 <balloc+0x20>
  panic("balloc: out of blocks");
80101140:	c7 04 24 2f 6e 10 80 	movl   $0x80106e2f,(%esp)
80101147:	e8 c4 f1 ff ff       	call   80100310 <panic>
        bp->data[bi/8] |= m;  // Mark block in use.
8010114c:	09 ca                	or     %ecx,%edx
8010114e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101151:	88 54 18 5c          	mov    %dl,0x5c(%eax,%ebx,1)
        log_write(bp);
80101155:	89 04 24             	mov    %eax,(%esp)
80101158:	e8 bf 17 00 00       	call   8010291c <log_write>
        brelse(bp);
8010115d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101160:	89 04 24             	mov    %eax,(%esp)
80101163:	e8 40 f0 ff ff       	call   801001a8 <brelse>
  bp = bread(dev, bno);
80101168:	89 74 24 04          	mov    %esi,0x4(%esp)
8010116c:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010116f:	89 04 24             	mov    %eax,(%esp)
80101172:	e8 3d ef ff ff       	call   801000b4 <bread>
80101177:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101179:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80101180:	00 
80101181:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80101188:	00 
80101189:	8d 40 5c             	lea    0x5c(%eax),%eax
8010118c:	89 04 24             	mov    %eax,(%esp)
8010118f:	e8 50 33 00 00       	call   801044e4 <memset>
  log_write(bp);
80101194:	89 1c 24             	mov    %ebx,(%esp)
80101197:	e8 80 17 00 00       	call   8010291c <log_write>
  brelse(bp);
8010119c:	89 1c 24             	mov    %ebx,(%esp)
8010119f:	e8 04 f0 ff ff       	call   801001a8 <brelse>
}
801011a4:	89 f0                	mov    %esi,%eax
801011a6:	83 c4 2c             	add    $0x2c,%esp
801011a9:	5b                   	pop    %ebx
801011aa:	5e                   	pop    %esi
801011ab:	5f                   	pop    %edi
801011ac:	5d                   	pop    %ebp
801011ad:	c3                   	ret    
801011ae:	66 90                	xchg   %ax,%ax

801011b0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801011b0:	55                   	push   %ebp
801011b1:	89 e5                	mov    %esp,%ebp
801011b3:	57                   	push   %edi
801011b4:	56                   	push   %esi
801011b5:	53                   	push   %ebx
801011b6:	83 ec 2c             	sub    $0x2c,%esp
801011b9:	89 c6                	mov    %eax,%esi
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801011bb:	83 fa 0b             	cmp    $0xb,%edx
801011be:	77 14                	ja     801011d4 <bmap+0x24>
    if((addr = ip->addrs[bn]) == 0)
801011c0:	8d 7a 14             	lea    0x14(%edx),%edi
801011c3:	8b 44 b8 0c          	mov    0xc(%eax,%edi,4),%eax
801011c7:	85 c0                	test   %eax,%eax
801011c9:	74 65                	je     80101230 <bmap+0x80>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801011cb:	83 c4 2c             	add    $0x2c,%esp
801011ce:	5b                   	pop    %ebx
801011cf:	5e                   	pop    %esi
801011d0:	5f                   	pop    %edi
801011d1:	5d                   	pop    %ebp
801011d2:	c3                   	ret    
801011d3:	90                   	nop
  bn -= NDIRECT;
801011d4:	8d 5a f4             	lea    -0xc(%edx),%ebx
  if(bn < NINDIRECT){
801011d7:	83 fb 7f             	cmp    $0x7f,%ebx
801011da:	77 77                	ja     80101253 <bmap+0xa3>
    if((addr = ip->addrs[NDIRECT]) == 0)
801011dc:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
801011e2:	85 c0                	test   %eax,%eax
801011e4:	74 5e                	je     80101244 <bmap+0x94>
    bp = bread(ip->dev, addr);
801011e6:	89 44 24 04          	mov    %eax,0x4(%esp)
801011ea:	8b 06                	mov    (%esi),%eax
801011ec:	89 04 24             	mov    %eax,(%esp)
801011ef:	e8 c0 ee ff ff       	call   801000b4 <bread>
801011f4:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
801011f6:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
801011fa:	8b 03                	mov    (%ebx),%eax
801011fc:	85 c0                	test   %eax,%eax
801011fe:	75 17                	jne    80101217 <bmap+0x67>
      a[bn] = addr = balloc(ip->dev);
80101200:	8b 06                	mov    (%esi),%eax
80101202:	e8 9d fe ff ff       	call   801010a4 <balloc>
80101207:	89 03                	mov    %eax,(%ebx)
      log_write(bp);
80101209:	89 3c 24             	mov    %edi,(%esp)
8010120c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010120f:	e8 08 17 00 00       	call   8010291c <log_write>
80101214:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    brelse(bp);
80101217:	89 3c 24             	mov    %edi,(%esp)
8010121a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010121d:	e8 86 ef ff ff       	call   801001a8 <brelse>
80101222:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101225:	83 c4 2c             	add    $0x2c,%esp
80101228:	5b                   	pop    %ebx
80101229:	5e                   	pop    %esi
8010122a:	5f                   	pop    %edi
8010122b:	5d                   	pop    %ebp
8010122c:	c3                   	ret    
8010122d:	8d 76 00             	lea    0x0(%esi),%esi
      ip->addrs[bn] = addr = balloc(ip->dev);
80101230:	8b 06                	mov    (%esi),%eax
80101232:	e8 6d fe ff ff       	call   801010a4 <balloc>
80101237:	89 44 be 0c          	mov    %eax,0xc(%esi,%edi,4)
}
8010123b:	83 c4 2c             	add    $0x2c,%esp
8010123e:	5b                   	pop    %ebx
8010123f:	5e                   	pop    %esi
80101240:	5f                   	pop    %edi
80101241:	5d                   	pop    %ebp
80101242:	c3                   	ret    
80101243:	90                   	nop
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101244:	8b 06                	mov    (%esi),%eax
80101246:	e8 59 fe ff ff       	call   801010a4 <balloc>
8010124b:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80101251:	eb 93                	jmp    801011e6 <bmap+0x36>
  panic("bmap: out of range");
80101253:	c7 04 24 45 6e 10 80 	movl   $0x80106e45,(%esp)
8010125a:	e8 b1 f0 ff ff       	call   80100310 <panic>
8010125f:	90                   	nop

80101260 <readsb>:
{
80101260:	55                   	push   %ebp
80101261:	89 e5                	mov    %esp,%ebp
80101263:	56                   	push   %esi
80101264:	53                   	push   %ebx
80101265:	83 ec 10             	sub    $0x10,%esp
80101268:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
8010126b:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80101272:	00 
80101273:	8b 45 08             	mov    0x8(%ebp),%eax
80101276:	89 04 24             	mov    %eax,(%esp)
80101279:	e8 36 ee ff ff       	call   801000b4 <bread>
8010127e:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101280:	c7 44 24 08 1c 00 00 	movl   $0x1c,0x8(%esp)
80101287:	00 
80101288:	8d 40 5c             	lea    0x5c(%eax),%eax
8010128b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010128f:	89 34 24             	mov    %esi,(%esp)
80101292:	e8 e1 32 00 00       	call   80104578 <memmove>
  brelse(bp);
80101297:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010129a:	83 c4 10             	add    $0x10,%esp
8010129d:	5b                   	pop    %ebx
8010129e:	5e                   	pop    %esi
8010129f:	5d                   	pop    %ebp
  brelse(bp);
801012a0:	e9 03 ef ff ff       	jmp    801001a8 <brelse>
801012a5:	8d 76 00             	lea    0x0(%esi),%esi

801012a8 <bfree>:
{
801012a8:	55                   	push   %ebp
801012a9:	89 e5                	mov    %esp,%ebp
801012ab:	57                   	push   %edi
801012ac:	56                   	push   %esi
801012ad:	53                   	push   %ebx
801012ae:	83 ec 1c             	sub    $0x1c,%esp
801012b1:	89 c3                	mov    %eax,%ebx
801012b3:	89 d7                	mov    %edx,%edi
  readsb(dev, &sb);
801012b5:	c7 44 24 04 c0 09 11 	movl   $0x801109c0,0x4(%esp)
801012bc:	80 
801012bd:	89 04 24             	mov    %eax,(%esp)
801012c0:	e8 9b ff ff ff       	call   80101260 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
801012c5:	89 fa                	mov    %edi,%edx
801012c7:	c1 ea 0c             	shr    $0xc,%edx
801012ca:	03 15 d8 09 11 80    	add    0x801109d8,%edx
801012d0:	89 54 24 04          	mov    %edx,0x4(%esp)
801012d4:	89 1c 24             	mov    %ebx,(%esp)
801012d7:	e8 d8 ed ff ff       	call   801000b4 <bread>
801012dc:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
801012de:	89 f9                	mov    %edi,%ecx
801012e0:	83 e1 07             	and    $0x7,%ecx
801012e3:	bb 01 00 00 00       	mov    $0x1,%ebx
801012e8:	d3 e3                	shl    %cl,%ebx
  bi = b % BPB;
801012ea:	89 fa                	mov    %edi,%edx
801012ec:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
  if((bp->data[bi/8] & m) == 0)
801012f2:	c1 fa 03             	sar    $0x3,%edx
801012f5:	8a 44 10 5c          	mov    0x5c(%eax,%edx,1),%al
801012f9:	0f b6 c8             	movzbl %al,%ecx
801012fc:	85 d9                	test   %ebx,%ecx
801012fe:	74 20                	je     80101320 <bfree+0x78>
  bp->data[bi/8] &= ~m;
80101300:	f7 d3                	not    %ebx
80101302:	21 c3                	and    %eax,%ebx
80101304:	88 5c 16 5c          	mov    %bl,0x5c(%esi,%edx,1)
  log_write(bp);
80101308:	89 34 24             	mov    %esi,(%esp)
8010130b:	e8 0c 16 00 00       	call   8010291c <log_write>
  brelse(bp);
80101310:	89 34 24             	mov    %esi,(%esp)
80101313:	e8 90 ee ff ff       	call   801001a8 <brelse>
}
80101318:	83 c4 1c             	add    $0x1c,%esp
8010131b:	5b                   	pop    %ebx
8010131c:	5e                   	pop    %esi
8010131d:	5f                   	pop    %edi
8010131e:	5d                   	pop    %ebp
8010131f:	c3                   	ret    
    panic("freeing free block");
80101320:	c7 04 24 58 6e 10 80 	movl   $0x80106e58,(%esp)
80101327:	e8 e4 ef ff ff       	call   80100310 <panic>

8010132c <iinit>:
{
8010132c:	55                   	push   %ebp
8010132d:	89 e5                	mov    %esp,%ebp
8010132f:	53                   	push   %ebx
80101330:	83 ec 24             	sub    $0x24,%esp
  initlock(&icache.lock, "icache");
80101333:	c7 44 24 04 6b 6e 10 	movl   $0x80106e6b,0x4(%esp)
8010133a:	80 
8010133b:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101342:	e8 d1 2f 00 00       	call   80104318 <initlock>
  for(i = 0; i < NINODE; i++) {
80101347:	31 db                	xor    %ebx,%ebx
80101349:	8d 76 00             	lea    0x0(%esi),%esi
    initsleeplock(&icache.inode[i].lock, "inode");
8010134c:	c7 44 24 04 72 6e 10 	movl   $0x80106e72,0x4(%esp)
80101353:	80 
80101354:	8d 04 db             	lea    (%ebx,%ebx,8),%eax
80101357:	c1 e0 04             	shl    $0x4,%eax
8010135a:	05 20 0a 11 80       	add    $0x80110a20,%eax
8010135f:	89 04 24             	mov    %eax,(%esp)
80101362:	e8 c1 2e 00 00       	call   80104228 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101367:	43                   	inc    %ebx
80101368:	83 fb 32             	cmp    $0x32,%ebx
8010136b:	75 df                	jne    8010134c <iinit+0x20>
  readsb(dev, &sb);
8010136d:	c7 44 24 04 c0 09 11 	movl   $0x801109c0,0x4(%esp)
80101374:	80 
80101375:	8b 45 08             	mov    0x8(%ebp),%eax
80101378:	89 04 24             	mov    %eax,(%esp)
8010137b:	e8 e0 fe ff ff       	call   80101260 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101380:	a1 d8 09 11 80       	mov    0x801109d8,%eax
80101385:	89 44 24 1c          	mov    %eax,0x1c(%esp)
80101389:	a1 d4 09 11 80       	mov    0x801109d4,%eax
8010138e:	89 44 24 18          	mov    %eax,0x18(%esp)
80101392:	a1 d0 09 11 80       	mov    0x801109d0,%eax
80101397:	89 44 24 14          	mov    %eax,0x14(%esp)
8010139b:	a1 cc 09 11 80       	mov    0x801109cc,%eax
801013a0:	89 44 24 10          	mov    %eax,0x10(%esp)
801013a4:	a1 c8 09 11 80       	mov    0x801109c8,%eax
801013a9:	89 44 24 0c          	mov    %eax,0xc(%esp)
801013ad:	a1 c4 09 11 80       	mov    0x801109c4,%eax
801013b2:	89 44 24 08          	mov    %eax,0x8(%esp)
801013b6:	a1 c0 09 11 80       	mov    0x801109c0,%eax
801013bb:	89 44 24 04          	mov    %eax,0x4(%esp)
801013bf:	c7 04 24 d8 6e 10 80 	movl   $0x80106ed8,(%esp)
801013c6:	e8 e9 f1 ff ff       	call   801005b4 <cprintf>
}
801013cb:	83 c4 24             	add    $0x24,%esp
801013ce:	5b                   	pop    %ebx
801013cf:	5d                   	pop    %ebp
801013d0:	c3                   	ret    
801013d1:	8d 76 00             	lea    0x0(%esi),%esi

801013d4 <ialloc>:
{
801013d4:	55                   	push   %ebp
801013d5:	89 e5                	mov    %esp,%ebp
801013d7:	57                   	push   %edi
801013d8:	56                   	push   %esi
801013d9:	53                   	push   %ebx
801013da:	83 ec 2c             	sub    $0x2c,%esp
801013dd:	8b 45 08             	mov    0x8(%ebp),%eax
801013e0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801013e3:	8b 45 0c             	mov    0xc(%ebp),%eax
801013e6:	66 89 45 e2          	mov    %ax,-0x1e(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
801013ea:	83 3d c8 09 11 80 01 	cmpl   $0x1,0x801109c8
801013f1:	0f 86 94 00 00 00    	jbe    8010148b <ialloc+0xb7>
801013f7:	bf 01 00 00 00       	mov    $0x1,%edi
801013fc:	bb 01 00 00 00       	mov    $0x1,%ebx
80101401:	eb 14                	jmp    80101417 <ialloc+0x43>
80101403:	90                   	nop
    brelse(bp);
80101404:	89 34 24             	mov    %esi,(%esp)
80101407:	e8 9c ed ff ff       	call   801001a8 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010140c:	43                   	inc    %ebx
8010140d:	89 df                	mov    %ebx,%edi
8010140f:	3b 1d c8 09 11 80    	cmp    0x801109c8,%ebx
80101415:	73 74                	jae    8010148b <ialloc+0xb7>
    bp = bread(dev, IBLOCK(inum, sb));
80101417:	89 f8                	mov    %edi,%eax
80101419:	c1 e8 03             	shr    $0x3,%eax
8010141c:	03 05 d4 09 11 80    	add    0x801109d4,%eax
80101422:	89 44 24 04          	mov    %eax,0x4(%esp)
80101426:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101429:	89 04 24             	mov    %eax,(%esp)
8010142c:	e8 83 ec ff ff       	call   801000b4 <bread>
80101431:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + inum%IPB;
80101433:	89 d8                	mov    %ebx,%eax
80101435:	83 e0 07             	and    $0x7,%eax
80101438:	c1 e0 06             	shl    $0x6,%eax
8010143b:	8d 4c 06 5c          	lea    0x5c(%esi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010143f:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101443:	75 bf                	jne    80101404 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101445:	c7 44 24 08 40 00 00 	movl   $0x40,0x8(%esp)
8010144c:	00 
8010144d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80101454:	00 
80101455:	89 0c 24             	mov    %ecx,(%esp)
80101458:	89 4d dc             	mov    %ecx,-0x24(%ebp)
8010145b:	e8 84 30 00 00       	call   801044e4 <memset>
      dip->type = type;
80101460:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80101463:	66 8b 45 e2          	mov    -0x1e(%ebp),%ax
80101467:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010146a:	89 34 24             	mov    %esi,(%esp)
8010146d:	e8 aa 14 00 00       	call   8010291c <log_write>
      brelse(bp);
80101472:	89 34 24             	mov    %esi,(%esp)
80101475:	e8 2e ed ff ff       	call   801001a8 <brelse>
      return iget(dev, inum);
8010147a:	89 fa                	mov    %edi,%edx
8010147c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
8010147f:	83 c4 2c             	add    $0x2c,%esp
80101482:	5b                   	pop    %ebx
80101483:	5e                   	pop    %esi
80101484:	5f                   	pop    %edi
80101485:	5d                   	pop    %ebp
      return iget(dev, inum);
80101486:	e9 65 fb ff ff       	jmp    80100ff0 <iget>
  panic("ialloc: no inodes");
8010148b:	c7 04 24 78 6e 10 80 	movl   $0x80106e78,(%esp)
80101492:	e8 79 ee ff ff       	call   80100310 <panic>
80101497:	90                   	nop

80101498 <iupdate>:
{
80101498:	55                   	push   %ebp
80101499:	89 e5                	mov    %esp,%ebp
8010149b:	56                   	push   %esi
8010149c:	53                   	push   %ebx
8010149d:	83 ec 10             	sub    $0x10,%esp
801014a0:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801014a3:	8b 43 04             	mov    0x4(%ebx),%eax
801014a6:	c1 e8 03             	shr    $0x3,%eax
801014a9:	03 05 d4 09 11 80    	add    0x801109d4,%eax
801014af:	89 44 24 04          	mov    %eax,0x4(%esp)
801014b3:	8b 03                	mov    (%ebx),%eax
801014b5:	89 04 24             	mov    %eax,(%esp)
801014b8:	e8 f7 eb ff ff       	call   801000b4 <bread>
801014bd:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801014bf:	8b 53 04             	mov    0x4(%ebx),%edx
801014c2:	83 e2 07             	and    $0x7,%edx
801014c5:	c1 e2 06             	shl    $0x6,%edx
801014c8:	8d 54 10 5c          	lea    0x5c(%eax,%edx,1),%edx
  dip->type = ip->type;
801014cc:	8b 43 50             	mov    0x50(%ebx),%eax
801014cf:	66 89 02             	mov    %ax,(%edx)
  dip->major = ip->major;
801014d2:	66 8b 43 52          	mov    0x52(%ebx),%ax
801014d6:	66 89 42 02          	mov    %ax,0x2(%edx)
  dip->minor = ip->minor;
801014da:	8b 43 54             	mov    0x54(%ebx),%eax
801014dd:	66 89 42 04          	mov    %ax,0x4(%edx)
  dip->nlink = ip->nlink;
801014e1:	66 8b 43 56          	mov    0x56(%ebx),%ax
801014e5:	66 89 42 06          	mov    %ax,0x6(%edx)
  dip->size = ip->size;
801014e9:	8b 43 58             	mov    0x58(%ebx),%eax
801014ec:	89 42 08             	mov    %eax,0x8(%edx)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801014ef:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
801014f6:	00 
801014f7:	83 c3 5c             	add    $0x5c,%ebx
801014fa:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801014fe:	83 c2 0c             	add    $0xc,%edx
80101501:	89 14 24             	mov    %edx,(%esp)
80101504:	e8 6f 30 00 00       	call   80104578 <memmove>
  log_write(bp);
80101509:	89 34 24             	mov    %esi,(%esp)
8010150c:	e8 0b 14 00 00       	call   8010291c <log_write>
  brelse(bp);
80101511:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101514:	83 c4 10             	add    $0x10,%esp
80101517:	5b                   	pop    %ebx
80101518:	5e                   	pop    %esi
80101519:	5d                   	pop    %ebp
  brelse(bp);
8010151a:	e9 89 ec ff ff       	jmp    801001a8 <brelse>
8010151f:	90                   	nop

80101520 <idup>:
{
80101520:	55                   	push   %ebp
80101521:	89 e5                	mov    %esp,%ebp
80101523:	53                   	push   %ebx
80101524:	83 ec 14             	sub    $0x14,%esp
80101527:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010152a:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101531:	e8 aa 2e 00 00       	call   801043e0 <acquire>
  ip->ref++;
80101536:	ff 43 08             	incl   0x8(%ebx)
  release(&icache.lock);
80101539:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101540:	e8 57 2f 00 00       	call   8010449c <release>
}
80101545:	89 d8                	mov    %ebx,%eax
80101547:	83 c4 14             	add    $0x14,%esp
8010154a:	5b                   	pop    %ebx
8010154b:	5d                   	pop    %ebp
8010154c:	c3                   	ret    
8010154d:	8d 76 00             	lea    0x0(%esi),%esi

80101550 <ilock>:
{
80101550:	55                   	push   %ebp
80101551:	89 e5                	mov    %esp,%ebp
80101553:	56                   	push   %esi
80101554:	53                   	push   %ebx
80101555:	83 ec 10             	sub    $0x10,%esp
80101558:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
8010155b:	85 db                	test   %ebx,%ebx
8010155d:	0f 84 b1 00 00 00    	je     80101614 <ilock+0xc4>
80101563:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101566:	85 c9                	test   %ecx,%ecx
80101568:	0f 8e a6 00 00 00    	jle    80101614 <ilock+0xc4>
  acquiresleep(&ip->lock);
8010156e:	8d 43 0c             	lea    0xc(%ebx),%eax
80101571:	89 04 24             	mov    %eax,(%esp)
80101574:	e8 e7 2c 00 00       	call   80104260 <acquiresleep>
  if(ip->valid == 0){
80101579:	8b 53 4c             	mov    0x4c(%ebx),%edx
8010157c:	85 d2                	test   %edx,%edx
8010157e:	74 08                	je     80101588 <ilock+0x38>
}
80101580:	83 c4 10             	add    $0x10,%esp
80101583:	5b                   	pop    %ebx
80101584:	5e                   	pop    %esi
80101585:	5d                   	pop    %ebp
80101586:	c3                   	ret    
80101587:	90                   	nop
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101588:	8b 43 04             	mov    0x4(%ebx),%eax
8010158b:	c1 e8 03             	shr    $0x3,%eax
8010158e:	03 05 d4 09 11 80    	add    0x801109d4,%eax
80101594:	89 44 24 04          	mov    %eax,0x4(%esp)
80101598:	8b 03                	mov    (%ebx),%eax
8010159a:	89 04 24             	mov    %eax,(%esp)
8010159d:	e8 12 eb ff ff       	call   801000b4 <bread>
801015a2:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801015a4:	8b 53 04             	mov    0x4(%ebx),%edx
801015a7:	83 e2 07             	and    $0x7,%edx
801015aa:	c1 e2 06             	shl    $0x6,%edx
801015ad:	8d 54 10 5c          	lea    0x5c(%eax,%edx,1),%edx
    ip->type = dip->type;
801015b1:	8b 02                	mov    (%edx),%eax
801015b3:	66 89 43 50          	mov    %ax,0x50(%ebx)
    ip->major = dip->major;
801015b7:	66 8b 42 02          	mov    0x2(%edx),%ax
801015bb:	66 89 43 52          	mov    %ax,0x52(%ebx)
    ip->minor = dip->minor;
801015bf:	8b 42 04             	mov    0x4(%edx),%eax
801015c2:	66 89 43 54          	mov    %ax,0x54(%ebx)
    ip->nlink = dip->nlink;
801015c6:	66 8b 42 06          	mov    0x6(%edx),%ax
801015ca:	66 89 43 56          	mov    %ax,0x56(%ebx)
    ip->size = dip->size;
801015ce:	8b 42 08             	mov    0x8(%edx),%eax
801015d1:	89 43 58             	mov    %eax,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801015d4:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
801015db:	00 
801015dc:	83 c2 0c             	add    $0xc,%edx
801015df:	89 54 24 04          	mov    %edx,0x4(%esp)
801015e3:	8d 43 5c             	lea    0x5c(%ebx),%eax
801015e6:	89 04 24             	mov    %eax,(%esp)
801015e9:	e8 8a 2f 00 00       	call   80104578 <memmove>
    brelse(bp);
801015ee:	89 34 24             	mov    %esi,(%esp)
801015f1:	e8 b2 eb ff ff       	call   801001a8 <brelse>
    ip->valid = 1;
801015f6:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
801015fd:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
80101602:	0f 85 78 ff ff ff    	jne    80101580 <ilock+0x30>
      panic("ilock: no type");
80101608:	c7 04 24 90 6e 10 80 	movl   $0x80106e90,(%esp)
8010160f:	e8 fc ec ff ff       	call   80100310 <panic>
    panic("ilock");
80101614:	c7 04 24 8a 6e 10 80 	movl   $0x80106e8a,(%esp)
8010161b:	e8 f0 ec ff ff       	call   80100310 <panic>

80101620 <iunlock>:
{
80101620:	55                   	push   %ebp
80101621:	89 e5                	mov    %esp,%ebp
80101623:	56                   	push   %esi
80101624:	53                   	push   %ebx
80101625:	83 ec 10             	sub    $0x10,%esp
80101628:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
8010162b:	85 db                	test   %ebx,%ebx
8010162d:	74 24                	je     80101653 <iunlock+0x33>
8010162f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101632:	89 34 24             	mov    %esi,(%esp)
80101635:	e8 b2 2c 00 00       	call   801042ec <holdingsleep>
8010163a:	85 c0                	test   %eax,%eax
8010163c:	74 15                	je     80101653 <iunlock+0x33>
8010163e:	8b 5b 08             	mov    0x8(%ebx),%ebx
80101641:	85 db                	test   %ebx,%ebx
80101643:	7e 0e                	jle    80101653 <iunlock+0x33>
  releasesleep(&ip->lock);
80101645:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101648:	83 c4 10             	add    $0x10,%esp
8010164b:	5b                   	pop    %ebx
8010164c:	5e                   	pop    %esi
8010164d:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010164e:	e9 5d 2c 00 00       	jmp    801042b0 <releasesleep>
    panic("iunlock");
80101653:	c7 04 24 9f 6e 10 80 	movl   $0x80106e9f,(%esp)
8010165a:	e8 b1 ec ff ff       	call   80100310 <panic>
8010165f:	90                   	nop

80101660 <iput>:
{
80101660:	55                   	push   %ebp
80101661:	89 e5                	mov    %esp,%ebp
80101663:	57                   	push   %edi
80101664:	56                   	push   %esi
80101665:	53                   	push   %ebx
80101666:	83 ec 2c             	sub    $0x2c,%esp
80101669:	8b 75 08             	mov    0x8(%ebp),%esi
  acquiresleep(&ip->lock);
8010166c:	8d 7e 0c             	lea    0xc(%esi),%edi
8010166f:	89 3c 24             	mov    %edi,(%esp)
80101672:	e8 e9 2b 00 00       	call   80104260 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101677:	8b 46 4c             	mov    0x4c(%esi),%eax
8010167a:	85 c0                	test   %eax,%eax
8010167c:	74 07                	je     80101685 <iput+0x25>
8010167e:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
80101683:	74 2b                	je     801016b0 <iput+0x50>
  releasesleep(&ip->lock);
80101685:	89 3c 24             	mov    %edi,(%esp)
80101688:	e8 23 2c 00 00       	call   801042b0 <releasesleep>
  acquire(&icache.lock);
8010168d:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101694:	e8 47 2d 00 00       	call   801043e0 <acquire>
  ip->ref--;
80101699:	ff 4e 08             	decl   0x8(%esi)
  release(&icache.lock);
8010169c:	c7 45 08 e0 09 11 80 	movl   $0x801109e0,0x8(%ebp)
}
801016a3:	83 c4 2c             	add    $0x2c,%esp
801016a6:	5b                   	pop    %ebx
801016a7:	5e                   	pop    %esi
801016a8:	5f                   	pop    %edi
801016a9:	5d                   	pop    %ebp
  release(&icache.lock);
801016aa:	e9 ed 2d 00 00       	jmp    8010449c <release>
801016af:	90                   	nop
    acquire(&icache.lock);
801016b0:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801016b7:	e8 24 2d 00 00       	call   801043e0 <acquire>
    int r = ip->ref;
801016bc:	8b 5e 08             	mov    0x8(%esi),%ebx
    release(&icache.lock);
801016bf:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801016c6:	e8 d1 2d 00 00       	call   8010449c <release>
    if(r == 1){
801016cb:	4b                   	dec    %ebx
801016cc:	75 b7                	jne    80101685 <iput+0x25>
801016ce:	89 f3                	mov    %esi,%ebx
iput(struct inode *ip)
801016d0:	8d 4e 30             	lea    0x30(%esi),%ecx
801016d3:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801016d6:	89 cf                	mov    %ecx,%edi
801016d8:	eb 09                	jmp    801016e3 <iput+0x83>
801016da:	66 90                	xchg   %ax,%ax
801016dc:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
801016df:	39 fb                	cmp    %edi,%ebx
801016e1:	74 19                	je     801016fc <iput+0x9c>
    if(ip->addrs[i]){
801016e3:	8b 53 5c             	mov    0x5c(%ebx),%edx
801016e6:	85 d2                	test   %edx,%edx
801016e8:	74 f2                	je     801016dc <iput+0x7c>
      bfree(ip->dev, ip->addrs[i]);
801016ea:	8b 06                	mov    (%esi),%eax
801016ec:	e8 b7 fb ff ff       	call   801012a8 <bfree>
      ip->addrs[i] = 0;
801016f1:	c7 43 5c 00 00 00 00 	movl   $0x0,0x5c(%ebx)
801016f8:	eb e2                	jmp    801016dc <iput+0x7c>
801016fa:	66 90                	xchg   %ax,%ax
801016fc:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    }
  }

  if(ip->addrs[NDIRECT]){
801016ff:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
80101705:	85 c0                	test   %eax,%eax
80101707:	75 2b                	jne    80101734 <iput+0xd4>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
80101709:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
  iupdate(ip);
80101710:	89 34 24             	mov    %esi,(%esp)
80101713:	e8 80 fd ff ff       	call   80101498 <iupdate>
      ip->type = 0;
80101718:	66 c7 46 50 00 00    	movw   $0x0,0x50(%esi)
      iupdate(ip);
8010171e:	89 34 24             	mov    %esi,(%esp)
80101721:	e8 72 fd ff ff       	call   80101498 <iupdate>
      ip->valid = 0;
80101726:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
8010172d:	e9 53 ff ff ff       	jmp    80101685 <iput+0x25>
80101732:	66 90                	xchg   %ax,%ax
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101734:	89 44 24 04          	mov    %eax,0x4(%esp)
80101738:	8b 06                	mov    (%esi),%eax
8010173a:	89 04 24             	mov    %eax,(%esp)
8010173d:	e8 72 e9 ff ff       	call   801000b4 <bread>
80101742:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
80101745:	89 c1                	mov    %eax,%ecx
80101747:	83 c1 5c             	add    $0x5c,%ecx
    for(j = 0; j < NINDIRECT; j++){
8010174a:	31 db                	xor    %ebx,%ebx
8010174c:	31 c0                	xor    %eax,%eax
8010174e:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101751:	89 cf                	mov    %ecx,%edi
80101753:	eb 0e                	jmp    80101763 <iput+0x103>
80101755:	8d 76 00             	lea    0x0(%esi),%esi
80101758:	43                   	inc    %ebx
80101759:	89 d8                	mov    %ebx,%eax
8010175b:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
80101761:	74 10                	je     80101773 <iput+0x113>
      if(a[j])
80101763:	8b 14 87             	mov    (%edi,%eax,4),%edx
80101766:	85 d2                	test   %edx,%edx
80101768:	74 ee                	je     80101758 <iput+0xf8>
        bfree(ip->dev, a[j]);
8010176a:	8b 06                	mov    (%esi),%eax
8010176c:	e8 37 fb ff ff       	call   801012a8 <bfree>
80101771:	eb e5                	jmp    80101758 <iput+0xf8>
80101773:	8b 7d e0             	mov    -0x20(%ebp),%edi
    brelse(bp);
80101776:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101779:	89 04 24             	mov    %eax,(%esp)
8010177c:	e8 27 ea ff ff       	call   801001a8 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101781:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
80101787:	8b 06                	mov    (%esi),%eax
80101789:	e8 1a fb ff ff       	call   801012a8 <bfree>
    ip->addrs[NDIRECT] = 0;
8010178e:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
80101795:	00 00 00 
80101798:	e9 6c ff ff ff       	jmp    80101709 <iput+0xa9>
8010179d:	8d 76 00             	lea    0x0(%esi),%esi

801017a0 <iunlockput>:
{
801017a0:	55                   	push   %ebp
801017a1:	89 e5                	mov    %esp,%ebp
801017a3:	53                   	push   %ebx
801017a4:	83 ec 14             	sub    $0x14,%esp
801017a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
801017aa:	89 1c 24             	mov    %ebx,(%esp)
801017ad:	e8 6e fe ff ff       	call   80101620 <iunlock>
  iput(ip);
801017b2:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801017b5:	83 c4 14             	add    $0x14,%esp
801017b8:	5b                   	pop    %ebx
801017b9:	5d                   	pop    %ebp
  iput(ip);
801017ba:	e9 a1 fe ff ff       	jmp    80101660 <iput>
801017bf:	90                   	nop

801017c0 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
801017c0:	55                   	push   %ebp
801017c1:	89 e5                	mov    %esp,%ebp
801017c3:	8b 55 08             	mov    0x8(%ebp),%edx
801017c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
801017c9:	8b 0a                	mov    (%edx),%ecx
801017cb:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
801017ce:	8b 4a 04             	mov    0x4(%edx),%ecx
801017d1:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
801017d4:	8b 4a 50             	mov    0x50(%edx),%ecx
801017d7:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
801017da:	66 8b 4a 56          	mov    0x56(%edx),%cx
801017de:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
801017e2:	8b 52 58             	mov    0x58(%edx),%edx
801017e5:	89 50 10             	mov    %edx,0x10(%eax)
}
801017e8:	5d                   	pop    %ebp
801017e9:	c3                   	ret    
801017ea:	66 90                	xchg   %ax,%ax

801017ec <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
801017ec:	55                   	push   %ebp
801017ed:	89 e5                	mov    %esp,%ebp
801017ef:	57                   	push   %edi
801017f0:	56                   	push   %esi
801017f1:	53                   	push   %ebx
801017f2:	83 ec 2c             	sub    $0x2c,%esp
801017f5:	8b 7d 08             	mov    0x8(%ebp),%edi
801017f8:	8b 45 0c             	mov    0xc(%ebp),%eax
801017fb:	89 45 e0             	mov    %eax,-0x20(%ebp)
801017fe:	8b 75 10             	mov    0x10(%ebp),%esi
80101801:	8b 55 14             	mov    0x14(%ebp),%edx
80101804:	89 55 dc             	mov    %edx,-0x24(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101807:	66 83 7f 50 03       	cmpw   $0x3,0x50(%edi)
8010180c:	0f 84 b2 00 00 00    	je     801018c4 <readi+0xd8>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101812:	8b 47 58             	mov    0x58(%edi),%eax
80101815:	39 f0                	cmp    %esi,%eax
80101817:	0f 82 cb 00 00 00    	jb     801018e8 <readi+0xfc>
8010181d:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101820:	01 f2                	add    %esi,%edx
80101822:	0f 82 c0 00 00 00    	jb     801018e8 <readi+0xfc>
    return -1;
  if(off + n > ip->size)
80101828:	39 d0                	cmp    %edx,%eax
8010182a:	0f 82 88 00 00 00    	jb     801018b8 <readi+0xcc>
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101830:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101837:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010183a:	85 c0                	test   %eax,%eax
8010183c:	74 6d                	je     801018ab <readi+0xbf>
8010183e:	66 90                	xchg   %ax,%ax
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101840:	89 f2                	mov    %esi,%edx
80101842:	c1 ea 09             	shr    $0x9,%edx
80101845:	89 f8                	mov    %edi,%eax
80101847:	e8 64 f9 ff ff       	call   801011b0 <bmap>
8010184c:	89 44 24 04          	mov    %eax,0x4(%esp)
80101850:	8b 07                	mov    (%edi),%eax
80101852:	89 04 24             	mov    %eax,(%esp)
80101855:	e8 5a e8 ff ff       	call   801000b4 <bread>
8010185a:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
8010185c:	89 f0                	mov    %esi,%eax
8010185e:	25 ff 01 00 00       	and    $0x1ff,%eax
80101863:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80101866:	2b 4d e4             	sub    -0x1c(%ebp),%ecx
80101869:	bb 00 02 00 00       	mov    $0x200,%ebx
8010186e:	29 c3                	sub    %eax,%ebx
80101870:	39 cb                	cmp    %ecx,%ebx
80101872:	76 02                	jbe    80101876 <readi+0x8a>
80101874:	89 cb                	mov    %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101876:	89 5c 24 08          	mov    %ebx,0x8(%esp)
8010187a:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
8010187e:	89 44 24 04          	mov    %eax,0x4(%esp)
80101882:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101885:	89 04 24             	mov    %eax,(%esp)
80101888:	89 55 d8             	mov    %edx,-0x28(%ebp)
8010188b:	e8 e8 2c 00 00       	call   80104578 <memmove>
    brelse(bp);
80101890:	8b 55 d8             	mov    -0x28(%ebp),%edx
80101893:	89 14 24             	mov    %edx,(%esp)
80101896:	e8 0d e9 ff ff       	call   801001a8 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010189b:	01 5d e4             	add    %ebx,-0x1c(%ebp)
8010189e:	01 de                	add    %ebx,%esi
801018a0:	01 5d e0             	add    %ebx,-0x20(%ebp)
801018a3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801018a6:	39 55 dc             	cmp    %edx,-0x24(%ebp)
801018a9:	77 95                	ja     80101840 <readi+0x54>
  }
  return n;
801018ab:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
801018ae:	83 c4 2c             	add    $0x2c,%esp
801018b1:	5b                   	pop    %ebx
801018b2:	5e                   	pop    %esi
801018b3:	5f                   	pop    %edi
801018b4:	5d                   	pop    %ebp
801018b5:	c3                   	ret    
801018b6:	66 90                	xchg   %ax,%ax
    n = ip->size - off;
801018b8:	29 f0                	sub    %esi,%eax
801018ba:	89 45 dc             	mov    %eax,-0x24(%ebp)
801018bd:	e9 6e ff ff ff       	jmp    80101830 <readi+0x44>
801018c2:	66 90                	xchg   %ax,%ax
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
801018c4:	0f bf 47 52          	movswl 0x52(%edi),%eax
801018c8:	66 83 f8 09          	cmp    $0x9,%ax
801018cc:	77 1a                	ja     801018e8 <readi+0xfc>
801018ce:	8b 04 c5 60 09 11 80 	mov    -0x7feef6a0(,%eax,8),%eax
801018d5:	85 c0                	test   %eax,%eax
801018d7:	74 0f                	je     801018e8 <readi+0xfc>
    return devsw[ip->major].read(ip, dst, n);
801018d9:	89 55 10             	mov    %edx,0x10(%ebp)
}
801018dc:	83 c4 2c             	add    $0x2c,%esp
801018df:	5b                   	pop    %ebx
801018e0:	5e                   	pop    %esi
801018e1:	5f                   	pop    %edi
801018e2:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
801018e3:	ff e0                	jmp    *%eax
801018e5:	8d 76 00             	lea    0x0(%esi),%esi
      return -1;
801018e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801018ed:	eb bf                	jmp    801018ae <readi+0xc2>
801018ef:	90                   	nop

801018f0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
801018f0:	55                   	push   %ebp
801018f1:	89 e5                	mov    %esp,%ebp
801018f3:	57                   	push   %edi
801018f4:	56                   	push   %esi
801018f5:	53                   	push   %ebx
801018f6:	83 ec 2c             	sub    $0x2c,%esp
801018f9:	8b 7d 08             	mov    0x8(%ebp),%edi
801018fc:	8b 45 0c             	mov    0xc(%ebp),%eax
801018ff:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101902:	8b 55 10             	mov    0x10(%ebp),%edx
80101905:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101908:	8b 45 14             	mov    0x14(%ebp),%eax
8010190b:	89 45 d8             	mov    %eax,-0x28(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
8010190e:	66 83 7f 50 03       	cmpw   $0x3,0x50(%edi)
80101913:	0f 84 b7 00 00 00    	je     801019d0 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101919:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010191c:	39 47 58             	cmp    %eax,0x58(%edi)
8010191f:	0f 82 df 00 00 00    	jb     80101a04 <writei+0x114>
80101925:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101928:	03 45 e4             	add    -0x1c(%ebp),%eax
8010192b:	0f 82 d3 00 00 00    	jb     80101a04 <writei+0x114>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101931:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101936:	0f 87 c8 00 00 00    	ja     80101a04 <writei+0x114>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
8010193c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80101943:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101946:	85 c0                	test   %eax,%eax
80101948:	74 7a                	je     801019c4 <writei+0xd4>
8010194a:	66 90                	xchg   %ax,%ax
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
8010194c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010194f:	c1 ea 09             	shr    $0x9,%edx
80101952:	89 f8                	mov    %edi,%eax
80101954:	e8 57 f8 ff ff       	call   801011b0 <bmap>
80101959:	89 44 24 04          	mov    %eax,0x4(%esp)
8010195d:	8b 07                	mov    (%edi),%eax
8010195f:	89 04 24             	mov    %eax,(%esp)
80101962:	e8 4d e7 ff ff       	call   801000b4 <bread>
80101967:	89 c6                	mov    %eax,%esi
    m = min(n - tot, BSIZE - off%BSIZE);
80101969:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010196c:	25 ff 01 00 00       	and    $0x1ff,%eax
80101971:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80101974:	2b 4d e0             	sub    -0x20(%ebp),%ecx
80101977:	bb 00 02 00 00       	mov    $0x200,%ebx
8010197c:	29 c3                	sub    %eax,%ebx
8010197e:	39 cb                	cmp    %ecx,%ebx
80101980:	76 02                	jbe    80101984 <writei+0x94>
80101982:	89 cb                	mov    %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101984:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101988:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010198b:	89 54 24 04          	mov    %edx,0x4(%esp)
8010198f:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
80101993:	89 04 24             	mov    %eax,(%esp)
80101996:	e8 dd 2b 00 00       	call   80104578 <memmove>
    log_write(bp);
8010199b:	89 34 24             	mov    %esi,(%esp)
8010199e:	e8 79 0f 00 00       	call   8010291c <log_write>
    brelse(bp);
801019a3:	89 34 24             	mov    %esi,(%esp)
801019a6:	e8 fd e7 ff ff       	call   801001a8 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801019ab:	01 5d e0             	add    %ebx,-0x20(%ebp)
801019ae:	01 5d e4             	add    %ebx,-0x1c(%ebp)
801019b1:	01 5d dc             	add    %ebx,-0x24(%ebp)
801019b4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801019b7:	39 45 d8             	cmp    %eax,-0x28(%ebp)
801019ba:	77 90                	ja     8010194c <writei+0x5c>
  }

  if(n > 0 && off > ip->size){
801019bc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801019bf:	3b 47 58             	cmp    0x58(%edi),%eax
801019c2:	77 30                	ja     801019f4 <writei+0x104>
    ip->size = off;
    iupdate(ip);
  }
  return n;
801019c4:	8b 45 d8             	mov    -0x28(%ebp),%eax
}
801019c7:	83 c4 2c             	add    $0x2c,%esp
801019ca:	5b                   	pop    %ebx
801019cb:	5e                   	pop    %esi
801019cc:	5f                   	pop    %edi
801019cd:	5d                   	pop    %ebp
801019ce:	c3                   	ret    
801019cf:	90                   	nop
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
801019d0:	0f bf 47 52          	movswl 0x52(%edi),%eax
801019d4:	66 83 f8 09          	cmp    $0x9,%ax
801019d8:	77 2a                	ja     80101a04 <writei+0x114>
801019da:	8b 04 c5 64 09 11 80 	mov    -0x7feef69c(,%eax,8),%eax
801019e1:	85 c0                	test   %eax,%eax
801019e3:	74 1f                	je     80101a04 <writei+0x114>
    return devsw[ip->major].write(ip, src, n);
801019e5:	8b 55 d8             	mov    -0x28(%ebp),%edx
801019e8:	89 55 10             	mov    %edx,0x10(%ebp)
}
801019eb:	83 c4 2c             	add    $0x2c,%esp
801019ee:	5b                   	pop    %ebx
801019ef:	5e                   	pop    %esi
801019f0:	5f                   	pop    %edi
801019f1:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
801019f2:	ff e0                	jmp    *%eax
    ip->size = off;
801019f4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801019f7:	89 57 58             	mov    %edx,0x58(%edi)
    iupdate(ip);
801019fa:	89 3c 24             	mov    %edi,(%esp)
801019fd:	e8 96 fa ff ff       	call   80101498 <iupdate>
80101a02:	eb c0                	jmp    801019c4 <writei+0xd4>
      return -1;
80101a04:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101a09:	83 c4 2c             	add    $0x2c,%esp
80101a0c:	5b                   	pop    %ebx
80101a0d:	5e                   	pop    %esi
80101a0e:	5f                   	pop    %edi
80101a0f:	5d                   	pop    %ebp
80101a10:	c3                   	ret    
80101a11:	8d 76 00             	lea    0x0(%esi),%esi

80101a14 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101a14:	55                   	push   %ebp
80101a15:	89 e5                	mov    %esp,%ebp
80101a17:	83 ec 18             	sub    $0x18,%esp
  return strncmp(s, t, DIRSIZ);
80101a1a:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101a21:	00 
80101a22:	8b 45 0c             	mov    0xc(%ebp),%eax
80101a25:	89 44 24 04          	mov    %eax,0x4(%esp)
80101a29:	8b 45 08             	mov    0x8(%ebp),%eax
80101a2c:	89 04 24             	mov    %eax,(%esp)
80101a2f:	e8 b4 2b 00 00       	call   801045e8 <strncmp>
}
80101a34:	c9                   	leave  
80101a35:	c3                   	ret    
80101a36:	66 90                	xchg   %ax,%ax

80101a38 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101a38:	55                   	push   %ebp
80101a39:	89 e5                	mov    %esp,%ebp
80101a3b:	57                   	push   %edi
80101a3c:	56                   	push   %esi
80101a3d:	53                   	push   %ebx
80101a3e:	83 ec 2c             	sub    $0x2c,%esp
80101a41:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101a44:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101a49:	0f 85 8b 00 00 00    	jne    80101ada <dirlookup+0xa2>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101a4f:	8b 43 58             	mov    0x58(%ebx),%eax
80101a52:	85 c0                	test   %eax,%eax
80101a54:	74 6e                	je     80101ac4 <dirlookup+0x8c>
80101a56:	31 ff                	xor    %edi,%edi
80101a58:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101a5b:	eb 0b                	jmp    80101a68 <dirlookup+0x30>
80101a5d:	8d 76 00             	lea    0x0(%esi),%esi
80101a60:	83 c7 10             	add    $0x10,%edi
80101a63:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101a66:	76 5c                	jbe    80101ac4 <dirlookup+0x8c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101a68:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101a6f:	00 
80101a70:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101a74:	89 74 24 04          	mov    %esi,0x4(%esp)
80101a78:	89 1c 24             	mov    %ebx,(%esp)
80101a7b:	e8 6c fd ff ff       	call   801017ec <readi>
80101a80:	83 f8 10             	cmp    $0x10,%eax
80101a83:	75 49                	jne    80101ace <dirlookup+0x96>
      panic("dirlookup read");
    if(de.inum == 0)
80101a85:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101a8a:	74 d4                	je     80101a60 <dirlookup+0x28>
      continue;
    if(namecmp(name, de.name) == 0){
80101a8c:	8d 45 da             	lea    -0x26(%ebp),%eax
80101a8f:	89 44 24 04          	mov    %eax,0x4(%esp)
80101a93:	8b 45 0c             	mov    0xc(%ebp),%eax
80101a96:	89 04 24             	mov    %eax,(%esp)
80101a99:	e8 76 ff ff ff       	call   80101a14 <namecmp>
80101a9e:	85 c0                	test   %eax,%eax
80101aa0:	75 be                	jne    80101a60 <dirlookup+0x28>
      // entry matches path element
      if(poff)
80101aa2:	8b 45 10             	mov    0x10(%ebp),%eax
80101aa5:	85 c0                	test   %eax,%eax
80101aa7:	74 05                	je     80101aae <dirlookup+0x76>
        *poff = off;
80101aa9:	8b 45 10             	mov    0x10(%ebp),%eax
80101aac:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101aae:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101ab2:	8b 03                	mov    (%ebx),%eax
80101ab4:	e8 37 f5 ff ff       	call   80100ff0 <iget>
    }
  }

  return 0;
}
80101ab9:	83 c4 2c             	add    $0x2c,%esp
80101abc:	5b                   	pop    %ebx
80101abd:	5e                   	pop    %esi
80101abe:	5f                   	pop    %edi
80101abf:	5d                   	pop    %ebp
80101ac0:	c3                   	ret    
80101ac1:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
80101ac4:	31 c0                	xor    %eax,%eax
}
80101ac6:	83 c4 2c             	add    $0x2c,%esp
80101ac9:	5b                   	pop    %ebx
80101aca:	5e                   	pop    %esi
80101acb:	5f                   	pop    %edi
80101acc:	5d                   	pop    %ebp
80101acd:	c3                   	ret    
      panic("dirlookup read");
80101ace:	c7 04 24 b9 6e 10 80 	movl   $0x80106eb9,(%esp)
80101ad5:	e8 36 e8 ff ff       	call   80100310 <panic>
    panic("dirlookup not DIR");
80101ada:	c7 04 24 a7 6e 10 80 	movl   $0x80106ea7,(%esp)
80101ae1:	e8 2a e8 ff ff       	call   80100310 <panic>
80101ae6:	66 90                	xchg   %ax,%ax

80101ae8 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101ae8:	55                   	push   %ebp
80101ae9:	89 e5                	mov    %esp,%ebp
80101aeb:	57                   	push   %edi
80101aec:	56                   	push   %esi
80101aed:	53                   	push   %ebx
80101aee:	83 ec 2c             	sub    $0x2c,%esp
80101af1:	89 c3                	mov    %eax,%ebx
80101af3:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101af6:	89 cf                	mov    %ecx,%edi
  struct inode *ip, *next;

  if(*path == '/')
80101af8:	80 38 2f             	cmpb   $0x2f,(%eax)
80101afb:	0f 84 eb 00 00 00    	je     80101bec <namex+0x104>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101b01:	e8 82 17 00 00       	call   80103288 <myproc>
80101b06:	8b 40 68             	mov    0x68(%eax),%eax
80101b09:	89 04 24             	mov    %eax,(%esp)
80101b0c:	e8 0f fa ff ff       	call   80101520 <idup>
80101b11:	89 c6                	mov    %eax,%esi
80101b13:	eb 04                	jmp    80101b19 <namex+0x31>
80101b15:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
80101b18:	43                   	inc    %ebx
  while(*path == '/')
80101b19:	8a 03                	mov    (%ebx),%al
80101b1b:	3c 2f                	cmp    $0x2f,%al
80101b1d:	74 f9                	je     80101b18 <namex+0x30>
  if(*path == 0)
80101b1f:	84 c0                	test   %al,%al
80101b21:	0f 84 ef 00 00 00    	je     80101c16 <namex+0x12e>
  while(*path != '/' && *path != 0)
80101b27:	8a 03                	mov    (%ebx),%al
80101b29:	89 da                	mov    %ebx,%edx
80101b2b:	3c 2f                	cmp    $0x2f,%al
80101b2d:	0f 84 93 00 00 00    	je     80101bc6 <namex+0xde>
80101b33:	84 c0                	test   %al,%al
80101b35:	75 09                	jne    80101b40 <namex+0x58>
80101b37:	e9 8a 00 00 00       	jmp    80101bc6 <namex+0xde>
80101b3c:	84 c0                	test   %al,%al
80101b3e:	74 07                	je     80101b47 <namex+0x5f>
    path++;
80101b40:	42                   	inc    %edx
  while(*path != '/' && *path != 0)
80101b41:	8a 02                	mov    (%edx),%al
80101b43:	3c 2f                	cmp    $0x2f,%al
80101b45:	75 f5                	jne    80101b3c <namex+0x54>
80101b47:	89 d1                	mov    %edx,%ecx
80101b49:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101b4b:	83 f9 0d             	cmp    $0xd,%ecx
80101b4e:	7e 78                	jle    80101bc8 <namex+0xe0>
    memmove(name, s, DIRSIZ);
80101b50:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101b57:	00 
80101b58:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101b5c:	89 3c 24             	mov    %edi,(%esp)
80101b5f:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101b62:	e8 11 2a 00 00       	call   80104578 <memmove>
80101b67:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101b6a:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101b6c:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101b6f:	75 09                	jne    80101b7a <namex+0x92>
80101b71:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
80101b74:	43                   	inc    %ebx
  while(*path == '/')
80101b75:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101b78:	74 fa                	je     80101b74 <namex+0x8c>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101b7a:	89 34 24             	mov    %esi,(%esp)
80101b7d:	e8 ce f9 ff ff       	call   80101550 <ilock>
    if(ip->type != T_DIR){
80101b82:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101b87:	75 79                	jne    80101c02 <namex+0x11a>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101b89:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101b8c:	85 d2                	test   %edx,%edx
80101b8e:	74 09                	je     80101b99 <namex+0xb1>
80101b90:	80 3b 00             	cmpb   $0x0,(%ebx)
80101b93:	0f 84 a4 00 00 00    	je     80101c3d <namex+0x155>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101b99:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80101ba0:	00 
80101ba1:	89 7c 24 04          	mov    %edi,0x4(%esp)
80101ba5:	89 34 24             	mov    %esi,(%esp)
80101ba8:	e8 8b fe ff ff       	call   80101a38 <dirlookup>
      iunlockput(ip);
80101bad:	89 34 24             	mov    %esi,(%esp)
    if((next = dirlookup(ip, name, 0)) == 0){
80101bb0:	85 c0                	test   %eax,%eax
80101bb2:	74 78                	je     80101c2c <namex+0x144>
      return 0;
    }
    iunlockput(ip);
80101bb4:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101bb7:	e8 e4 fb ff ff       	call   801017a0 <iunlockput>
    ip = next;
80101bbc:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101bbf:	89 c6                	mov    %eax,%esi
80101bc1:	e9 53 ff ff ff       	jmp    80101b19 <namex+0x31>
  while(*path != '/' && *path != 0)
80101bc6:	31 c9                	xor    %ecx,%ecx
    memmove(name, s, len);
80101bc8:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80101bcc:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101bd0:	89 3c 24             	mov    %edi,(%esp)
80101bd3:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101bd6:	89 4d dc             	mov    %ecx,-0x24(%ebp)
80101bd9:	e8 9a 29 00 00       	call   80104578 <memmove>
    name[len] = 0;
80101bde:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80101be1:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101be5:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101be8:	89 d3                	mov    %edx,%ebx
80101bea:	eb 80                	jmp    80101b6c <namex+0x84>
    ip = iget(ROOTDEV, ROOTINO);
80101bec:	ba 01 00 00 00       	mov    $0x1,%edx
80101bf1:	b8 01 00 00 00       	mov    $0x1,%eax
80101bf6:	e8 f5 f3 ff ff       	call   80100ff0 <iget>
80101bfb:	89 c6                	mov    %eax,%esi
80101bfd:	e9 17 ff ff ff       	jmp    80101b19 <namex+0x31>
      iunlockput(ip);
80101c02:	89 34 24             	mov    %esi,(%esp)
80101c05:	e8 96 fb ff ff       	call   801017a0 <iunlockput>
      return 0;
80101c0a:	31 f6                	xor    %esi,%esi
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101c0c:	89 f0                	mov    %esi,%eax
80101c0e:	83 c4 2c             	add    $0x2c,%esp
80101c11:	5b                   	pop    %ebx
80101c12:	5e                   	pop    %esi
80101c13:	5f                   	pop    %edi
80101c14:	5d                   	pop    %ebp
80101c15:	c3                   	ret    
  if(nameiparent){
80101c16:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101c19:	85 c0                	test   %eax,%eax
80101c1b:	74 ef                	je     80101c0c <namex+0x124>
    iput(ip);
80101c1d:	89 34 24             	mov    %esi,(%esp)
80101c20:	e8 3b fa ff ff       	call   80101660 <iput>
    return 0;
80101c25:	31 f6                	xor    %esi,%esi
80101c27:	eb e3                	jmp    80101c0c <namex+0x124>
80101c29:	8d 76 00             	lea    0x0(%esi),%esi
      iunlockput(ip);
80101c2c:	e8 6f fb ff ff       	call   801017a0 <iunlockput>
      return 0;
80101c31:	31 f6                	xor    %esi,%esi
}
80101c33:	89 f0                	mov    %esi,%eax
80101c35:	83 c4 2c             	add    $0x2c,%esp
80101c38:	5b                   	pop    %ebx
80101c39:	5e                   	pop    %esi
80101c3a:	5f                   	pop    %edi
80101c3b:	5d                   	pop    %ebp
80101c3c:	c3                   	ret    
      iunlock(ip);
80101c3d:	89 34 24             	mov    %esi,(%esp)
80101c40:	e8 db f9 ff ff       	call   80101620 <iunlock>
}
80101c45:	89 f0                	mov    %esi,%eax
80101c47:	83 c4 2c             	add    $0x2c,%esp
80101c4a:	5b                   	pop    %ebx
80101c4b:	5e                   	pop    %esi
80101c4c:	5f                   	pop    %edi
80101c4d:	5d                   	pop    %ebp
80101c4e:	c3                   	ret    
80101c4f:	90                   	nop

80101c50 <dirlink>:
{
80101c50:	55                   	push   %ebp
80101c51:	89 e5                	mov    %esp,%ebp
80101c53:	57                   	push   %edi
80101c54:	56                   	push   %esi
80101c55:	53                   	push   %ebx
80101c56:	83 ec 2c             	sub    $0x2c,%esp
80101c59:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101c5c:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80101c63:	00 
80101c64:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c67:	89 44 24 04          	mov    %eax,0x4(%esp)
80101c6b:	89 1c 24             	mov    %ebx,(%esp)
80101c6e:	e8 c5 fd ff ff       	call   80101a38 <dirlookup>
80101c73:	85 c0                	test   %eax,%eax
80101c75:	0f 85 85 00 00 00    	jne    80101d00 <dirlink+0xb0>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101c7b:	31 ff                	xor    %edi,%edi
80101c7d:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101c80:	8b 4b 58             	mov    0x58(%ebx),%ecx
80101c83:	85 c9                	test   %ecx,%ecx
80101c85:	75 0d                	jne    80101c94 <dirlink+0x44>
80101c87:	eb 2f                	jmp    80101cb8 <dirlink+0x68>
80101c89:	8d 76 00             	lea    0x0(%esi),%esi
80101c8c:	83 c7 10             	add    $0x10,%edi
80101c8f:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101c92:	76 24                	jbe    80101cb8 <dirlink+0x68>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101c94:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101c9b:	00 
80101c9c:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101ca0:	89 74 24 04          	mov    %esi,0x4(%esp)
80101ca4:	89 1c 24             	mov    %ebx,(%esp)
80101ca7:	e8 40 fb ff ff       	call   801017ec <readi>
80101cac:	83 f8 10             	cmp    $0x10,%eax
80101caf:	75 5e                	jne    80101d0f <dirlink+0xbf>
    if(de.inum == 0)
80101cb1:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101cb6:	75 d4                	jne    80101c8c <dirlink+0x3c>
  strncpy(de.name, name, DIRSIZ);
80101cb8:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101cbf:	00 
80101cc0:	8b 45 0c             	mov    0xc(%ebp),%eax
80101cc3:	89 44 24 04          	mov    %eax,0x4(%esp)
80101cc7:	8d 45 da             	lea    -0x26(%ebp),%eax
80101cca:	89 04 24             	mov    %eax,(%esp)
80101ccd:	e8 6a 29 00 00       	call   8010463c <strncpy>
  de.inum = inum;
80101cd2:	8b 45 10             	mov    0x10(%ebp),%eax
80101cd5:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101cd9:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101ce0:	00 
80101ce1:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101ce5:	89 74 24 04          	mov    %esi,0x4(%esp)
80101ce9:	89 1c 24             	mov    %ebx,(%esp)
80101cec:	e8 ff fb ff ff       	call   801018f0 <writei>
80101cf1:	83 f8 10             	cmp    $0x10,%eax
80101cf4:	75 25                	jne    80101d1b <dirlink+0xcb>
  return 0;
80101cf6:	31 c0                	xor    %eax,%eax
}
80101cf8:	83 c4 2c             	add    $0x2c,%esp
80101cfb:	5b                   	pop    %ebx
80101cfc:	5e                   	pop    %esi
80101cfd:	5f                   	pop    %edi
80101cfe:	5d                   	pop    %ebp
80101cff:	c3                   	ret    
    iput(ip);
80101d00:	89 04 24             	mov    %eax,(%esp)
80101d03:	e8 58 f9 ff ff       	call   80101660 <iput>
    return -1;
80101d08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101d0d:	eb e9                	jmp    80101cf8 <dirlink+0xa8>
      panic("dirlink read");
80101d0f:	c7 04 24 c8 6e 10 80 	movl   $0x80106ec8,(%esp)
80101d16:	e8 f5 e5 ff ff       	call   80100310 <panic>
    panic("dirlink");
80101d1b:	c7 04 24 02 76 10 80 	movl   $0x80107602,(%esp)
80101d22:	e8 e9 e5 ff ff       	call   80100310 <panic>
80101d27:	90                   	nop

80101d28 <namei>:

struct inode*
namei(char *path)
{
80101d28:	55                   	push   %ebp
80101d29:	89 e5                	mov    %esp,%ebp
80101d2b:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101d2e:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101d31:	31 d2                	xor    %edx,%edx
80101d33:	8b 45 08             	mov    0x8(%ebp),%eax
80101d36:	e8 ad fd ff ff       	call   80101ae8 <namex>
}
80101d3b:	c9                   	leave  
80101d3c:	c3                   	ret    
80101d3d:	8d 76 00             	lea    0x0(%esi),%esi

80101d40 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101d40:	55                   	push   %ebp
80101d41:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101d43:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101d46:	ba 01 00 00 00       	mov    $0x1,%edx
80101d4b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101d4e:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101d4f:	e9 94 fd ff ff       	jmp    80101ae8 <namex>

80101d54 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101d54:	55                   	push   %ebp
80101d55:	89 e5                	mov    %esp,%ebp
80101d57:	56                   	push   %esi
80101d58:	53                   	push   %ebx
80101d59:	83 ec 10             	sub    $0x10,%esp
80101d5c:	89 c6                	mov    %eax,%esi
  if(b == 0)
80101d5e:	85 c0                	test   %eax,%eax
80101d60:	0f 84 8a 00 00 00    	je     80101df0 <idestart+0x9c>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101d66:	8b 48 08             	mov    0x8(%eax),%ecx
80101d69:	81 f9 e7 03 00 00    	cmp    $0x3e7,%ecx
80101d6f:	77 73                	ja     80101de4 <idestart+0x90>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101d71:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101d76:	66 90                	xchg   %ax,%ax
80101d78:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101d79:	83 e0 c0             	and    $0xffffffc0,%eax
80101d7c:	3c 40                	cmp    $0x40,%al
80101d7e:	75 f8                	jne    80101d78 <idestart+0x24>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101d80:	31 db                	xor    %ebx,%ebx
80101d82:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101d87:	88 d8                	mov    %bl,%al
80101d89:	ee                   	out    %al,(%dx)
80101d8a:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101d8f:	b0 01                	mov    $0x1,%al
80101d91:	ee                   	out    %al,(%dx)
    sleep(b, &idelock);
  }


  release(&idelock);
}
80101d92:	0f b6 c1             	movzbl %cl,%eax
80101d95:	b2 f3                	mov    $0xf3,%dl
80101d97:	ee                   	out    %al,(%dx)
  outb(0x1f4, (sector >> 8) & 0xff);
80101d98:	89 c8                	mov    %ecx,%eax
80101d9a:	c1 f8 08             	sar    $0x8,%eax
80101d9d:	b2 f4                	mov    $0xf4,%dl
80101d9f:	ee                   	out    %al,(%dx)
80101da0:	b2 f5                	mov    $0xf5,%dl
80101da2:	88 d8                	mov    %bl,%al
80101da4:	ee                   	out    %al,(%dx)
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80101da5:	8b 46 04             	mov    0x4(%esi),%eax
80101da8:	83 e0 01             	and    $0x1,%eax
80101dab:	c1 e0 04             	shl    $0x4,%eax
80101dae:	83 c8 e0             	or     $0xffffffe0,%eax
80101db1:	b2 f6                	mov    $0xf6,%dl
80101db3:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80101db4:	f6 06 04             	testb  $0x4,(%esi)
80101db7:	75 0f                	jne    80101dc8 <idestart+0x74>
80101db9:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101dbe:	b0 20                	mov    $0x20,%al
80101dc0:	ee                   	out    %al,(%dx)
}
80101dc1:	83 c4 10             	add    $0x10,%esp
80101dc4:	5b                   	pop    %ebx
80101dc5:	5e                   	pop    %esi
80101dc6:	5d                   	pop    %ebp
80101dc7:	c3                   	ret    
80101dc8:	b2 f7                	mov    $0xf7,%dl
80101dca:	b0 30                	mov    $0x30,%al
80101dcc:	ee                   	out    %al,(%dx)
    outsl(0x1f0, b->data, BSIZE/4);
80101dcd:	83 c6 5c             	add    $0x5c,%esi
  asm volatile("cld; rep outsl" :
80101dd0:	b9 80 00 00 00       	mov    $0x80,%ecx
80101dd5:	ba f0 01 00 00       	mov    $0x1f0,%edx
80101dda:	fc                   	cld    
80101ddb:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80101ddd:	83 c4 10             	add    $0x10,%esp
80101de0:	5b                   	pop    %ebx
80101de1:	5e                   	pop    %esi
80101de2:	5d                   	pop    %ebp
80101de3:	c3                   	ret    
    panic("incorrect blockno");
80101de4:	c7 04 24 34 6f 10 80 	movl   $0x80106f34,(%esp)
80101deb:	e8 20 e5 ff ff       	call   80100310 <panic>
    panic("idestart");
80101df0:	c7 04 24 2b 6f 10 80 	movl   $0x80106f2b,(%esp)
80101df7:	e8 14 e5 ff ff       	call   80100310 <panic>

80101dfc <ideinit>:
{
80101dfc:	55                   	push   %ebp
80101dfd:	89 e5                	mov    %esp,%ebp
80101dff:	83 ec 18             	sub    $0x18,%esp
  initlock(&idelock, "ide");
80101e02:	c7 44 24 04 46 6f 10 	movl   $0x80106f46,0x4(%esp)
80101e09:	80 
80101e0a:	c7 04 24 60 a5 10 80 	movl   $0x8010a560,(%esp)
80101e11:	e8 02 25 00 00       	call   80104318 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80101e16:	a1 00 2d 11 80       	mov    0x80112d00,%eax
80101e1b:	48                   	dec    %eax
80101e1c:	89 44 24 04          	mov    %eax,0x4(%esp)
80101e20:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
80101e27:	e8 50 02 00 00       	call   8010207c <ioapicenable>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101e2c:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101e31:	8d 76 00             	lea    0x0(%esi),%esi
80101e34:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101e35:	83 e0 c0             	and    $0xffffffc0,%eax
80101e38:	3c 40                	cmp    $0x40,%al
80101e3a:	75 f8                	jne    80101e34 <ideinit+0x38>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101e3c:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101e41:	b0 f0                	mov    $0xf0,%al
80101e43:	ee                   	out    %al,(%dx)
80101e44:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101e49:	b2 f7                	mov    $0xf7,%dl
80101e4b:	eb 06                	jmp    80101e53 <ideinit+0x57>
80101e4d:	8d 76 00             	lea    0x0(%esi),%esi
  for(i=0; i<1000; i++){
80101e50:	49                   	dec    %ecx
80101e51:	74 0f                	je     80101e62 <ideinit+0x66>
80101e53:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80101e54:	84 c0                	test   %al,%al
80101e56:	74 f8                	je     80101e50 <ideinit+0x54>
      havedisk1 = 1;
80101e58:	c7 05 94 a5 10 80 01 	movl   $0x1,0x8010a594
80101e5f:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101e62:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101e67:	b0 e0                	mov    $0xe0,%al
80101e69:	ee                   	out    %al,(%dx)
}
80101e6a:	c9                   	leave  
80101e6b:	c3                   	ret    

80101e6c <ideintr>:
{
80101e6c:	55                   	push   %ebp
80101e6d:	89 e5                	mov    %esp,%ebp
80101e6f:	57                   	push   %edi
80101e70:	56                   	push   %esi
80101e71:	53                   	push   %ebx
80101e72:	83 ec 1c             	sub    $0x1c,%esp
  acquire(&idelock);
80101e75:	c7 04 24 60 a5 10 80 	movl   $0x8010a560,(%esp)
80101e7c:	e8 5f 25 00 00       	call   801043e0 <acquire>
  if((b = idequeue) == 0){
80101e81:	8b 1d 98 a5 10 80    	mov    0x8010a598,%ebx
80101e87:	85 db                	test   %ebx,%ebx
80101e89:	74 30                	je     80101ebb <ideintr+0x4f>
  idequeue = b->qnext;
80101e8b:	8b 43 58             	mov    0x58(%ebx),%eax
80101e8e:	a3 98 a5 10 80       	mov    %eax,0x8010a598
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80101e93:	8b 33                	mov    (%ebx),%esi
80101e95:	f7 c6 04 00 00 00    	test   $0x4,%esi
80101e9b:	74 33                	je     80101ed0 <ideintr+0x64>
  b->flags &= ~B_DIRTY;
80101e9d:	83 e6 fb             	and    $0xfffffffb,%esi
80101ea0:	83 ce 02             	or     $0x2,%esi
80101ea3:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
80101ea5:	89 1c 24             	mov    %ebx,(%esp)
80101ea8:	e8 9b 1e 00 00       	call   80103d48 <wakeup>
  if(idequeue != 0)
80101ead:	a1 98 a5 10 80       	mov    0x8010a598,%eax
80101eb2:	85 c0                	test   %eax,%eax
80101eb4:	74 05                	je     80101ebb <ideintr+0x4f>
    idestart(idequeue);
80101eb6:	e8 99 fe ff ff       	call   80101d54 <idestart>
    release(&idelock);
80101ebb:	c7 04 24 60 a5 10 80 	movl   $0x8010a560,(%esp)
80101ec2:	e8 d5 25 00 00       	call   8010449c <release>
}
80101ec7:	83 c4 1c             	add    $0x1c,%esp
80101eca:	5b                   	pop    %ebx
80101ecb:	5e                   	pop    %esi
80101ecc:	5f                   	pop    %edi
80101ecd:	5d                   	pop    %ebp
80101ece:	c3                   	ret    
80101ecf:	90                   	nop
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101ed0:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101ed5:	8d 76 00             	lea    0x0(%esi),%esi
80101ed8:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101ed9:	88 c1                	mov    %al,%cl
80101edb:	83 e1 c0             	and    $0xffffffc0,%ecx
80101ede:	80 f9 40             	cmp    $0x40,%cl
80101ee1:	75 f5                	jne    80101ed8 <ideintr+0x6c>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80101ee3:	a8 21                	test   $0x21,%al
80101ee5:	75 b6                	jne    80101e9d <ideintr+0x31>
    insl(0x1f0, b->data, BSIZE/4);
80101ee7:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80101eea:	b9 80 00 00 00       	mov    $0x80,%ecx
80101eef:	ba f0 01 00 00       	mov    $0x1f0,%edx
80101ef4:	fc                   	cld    
80101ef5:	f3 6d                	rep insl (%dx),%es:(%edi)
80101ef7:	8b 33                	mov    (%ebx),%esi
80101ef9:	eb a2                	jmp    80101e9d <ideintr+0x31>
80101efb:	90                   	nop

80101efc <iderw>:
{
80101efc:	55                   	push   %ebp
80101efd:	89 e5                	mov    %esp,%ebp
80101eff:	53                   	push   %ebx
80101f00:	83 ec 14             	sub    $0x14,%esp
80101f03:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
80101f06:	8d 43 0c             	lea    0xc(%ebx),%eax
80101f09:	89 04 24             	mov    %eax,(%esp)
80101f0c:	e8 db 23 00 00       	call   801042ec <holdingsleep>
80101f11:	85 c0                	test   %eax,%eax
80101f13:	0f 84 9e 00 00 00    	je     80101fb7 <iderw+0xbb>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80101f19:	8b 03                	mov    (%ebx),%eax
80101f1b:	83 e0 06             	and    $0x6,%eax
80101f1e:	83 f8 02             	cmp    $0x2,%eax
80101f21:	0f 84 a8 00 00 00    	je     80101fcf <iderw+0xd3>
  if(b->dev != 0 && !havedisk1)
80101f27:	8b 53 04             	mov    0x4(%ebx),%edx
80101f2a:	85 d2                	test   %edx,%edx
80101f2c:	74 0d                	je     80101f3b <iderw+0x3f>
80101f2e:	a1 94 a5 10 80       	mov    0x8010a594,%eax
80101f33:	85 c0                	test   %eax,%eax
80101f35:	0f 84 88 00 00 00    	je     80101fc3 <iderw+0xc7>
  acquire(&idelock);  //DOC:acquire-lock
80101f3b:	c7 04 24 60 a5 10 80 	movl   $0x8010a560,(%esp)
80101f42:	e8 99 24 00 00       	call   801043e0 <acquire>
  b->qnext = 0;
80101f47:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80101f4e:	a1 98 a5 10 80       	mov    0x8010a598,%eax
80101f53:	85 c0                	test   %eax,%eax
80101f55:	75 07                	jne    80101f5e <iderw+0x62>
80101f57:	eb 4e                	jmp    80101fa7 <iderw+0xab>
80101f59:	8d 76 00             	lea    0x0(%esi),%esi
80101f5c:	89 d0                	mov    %edx,%eax
80101f5e:	8b 50 58             	mov    0x58(%eax),%edx
80101f61:	85 d2                	test   %edx,%edx
80101f63:	75 f7                	jne    80101f5c <iderw+0x60>
80101f65:	83 c0 58             	add    $0x58,%eax
  *pp = b;
80101f68:	89 18                	mov    %ebx,(%eax)
  if(idequeue == b)
80101f6a:	39 1d 98 a5 10 80    	cmp    %ebx,0x8010a598
80101f70:	74 3c                	je     80101fae <iderw+0xb2>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80101f72:	8b 03                	mov    (%ebx),%eax
80101f74:	83 e0 06             	and    $0x6,%eax
80101f77:	83 f8 02             	cmp    $0x2,%eax
80101f7a:	74 1a                	je     80101f96 <iderw+0x9a>
    sleep(b, &idelock);
80101f7c:	c7 44 24 04 60 a5 10 	movl   $0x8010a560,0x4(%esp)
80101f83:	80 
80101f84:	89 1c 24             	mov    %ebx,(%esp)
80101f87:	e8 f0 1b 00 00       	call   80103b7c <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80101f8c:	8b 13                	mov    (%ebx),%edx
80101f8e:	83 e2 06             	and    $0x6,%edx
80101f91:	83 fa 02             	cmp    $0x2,%edx
80101f94:	75 e6                	jne    80101f7c <iderw+0x80>
  release(&idelock);
80101f96:	c7 45 08 60 a5 10 80 	movl   $0x8010a560,0x8(%ebp)
}
80101f9d:	83 c4 14             	add    $0x14,%esp
80101fa0:	5b                   	pop    %ebx
80101fa1:	5d                   	pop    %ebp
  release(&idelock);
80101fa2:	e9 f5 24 00 00       	jmp    8010449c <release>
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80101fa7:	b8 98 a5 10 80       	mov    $0x8010a598,%eax
80101fac:	eb ba                	jmp    80101f68 <iderw+0x6c>
    idestart(b);
80101fae:	89 d8                	mov    %ebx,%eax
80101fb0:	e8 9f fd ff ff       	call   80101d54 <idestart>
80101fb5:	eb bb                	jmp    80101f72 <iderw+0x76>
    panic("iderw: buf not locked");
80101fb7:	c7 04 24 4a 6f 10 80 	movl   $0x80106f4a,(%esp)
80101fbe:	e8 4d e3 ff ff       	call   80100310 <panic>
    panic("iderw: ide disk 1 not present");
80101fc3:	c7 04 24 75 6f 10 80 	movl   $0x80106f75,(%esp)
80101fca:	e8 41 e3 ff ff       	call   80100310 <panic>
    panic("iderw: nothing to do");
80101fcf:	c7 04 24 60 6f 10 80 	movl   $0x80106f60,(%esp)
80101fd6:	e8 35 e3 ff ff       	call   80100310 <panic>
80101fdb:	90                   	nop

80101fdc <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80101fdc:	55                   	push   %ebp
80101fdd:	89 e5                	mov    %esp,%ebp
80101fdf:	56                   	push   %esi
80101fe0:	53                   	push   %ebx
80101fe1:	83 ec 10             	sub    $0x10,%esp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80101fe4:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
80101feb:	00 c0 fe 
  ioapic->reg = reg;
80101fee:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80101ff5:	00 00 00 
  return ioapic->data;
80101ff8:	8b 35 10 00 c0 fe    	mov    0xfec00010,%esi
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80101ffe:	c1 ee 10             	shr    $0x10,%esi
80102001:	81 e6 ff 00 00 00    	and    $0xff,%esi
  ioapic->reg = reg;
80102007:	c7 05 00 00 c0 fe 00 	movl   $0x0,0xfec00000
8010200e:	00 00 00 
  return ioapic->data;
80102011:	bb 00 00 c0 fe       	mov    $0xfec00000,%ebx
80102016:	a1 10 00 c0 fe       	mov    0xfec00010,%eax
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010201b:	0f b6 15 60 27 11 80 	movzbl 0x80112760,%edx
  id = ioapicread(REG_ID) >> 24;
80102022:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102025:	39 c2                	cmp    %eax,%edx
80102027:	74 12                	je     8010203b <ioapicinit+0x5f>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102029:	c7 04 24 94 6f 10 80 	movl   $0x80106f94,(%esp)
80102030:	e8 7f e5 ff ff       	call   801005b4 <cprintf>
80102035:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
{
8010203b:	ba 10 00 00 00       	mov    $0x10,%edx
80102040:	31 c0                	xor    %eax,%eax
80102042:	66 90                	xchg   %ax,%ax
ioapicinit(void)
80102044:	8d 48 20             	lea    0x20(%eax),%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102047:	81 c9 00 00 01 00    	or     $0x10000,%ecx
  ioapic->reg = reg;
8010204d:	89 13                	mov    %edx,(%ebx)
  ioapic->data = data;
8010204f:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
80102055:	89 4b 10             	mov    %ecx,0x10(%ebx)
ioapicinit(void)
80102058:	8d 4a 01             	lea    0x1(%edx),%ecx
  ioapic->reg = reg;
8010205b:	89 0b                	mov    %ecx,(%ebx)
  ioapic->data = data;
8010205d:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
80102063:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
  for(i = 0; i <= maxintr; i++){
8010206a:	40                   	inc    %eax
8010206b:	83 c2 02             	add    $0x2,%edx
8010206e:	39 c6                	cmp    %eax,%esi
80102070:	7d d2                	jge    80102044 <ioapicinit+0x68>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80102072:	83 c4 10             	add    $0x10,%esp
80102075:	5b                   	pop    %ebx
80102076:	5e                   	pop    %esi
80102077:	5d                   	pop    %ebp
80102078:	c3                   	ret    
80102079:	8d 76 00             	lea    0x0(%esi),%esi

8010207c <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
8010207c:	55                   	push   %ebp
8010207d:	89 e5                	mov    %esp,%ebp
8010207f:	53                   	push   %ebx
80102080:	8b 55 08             	mov    0x8(%ebp),%edx
80102083:	8b 45 0c             	mov    0xc(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102086:	8d 5a 20             	lea    0x20(%edx),%ebx
80102089:	8d 4c 12 10          	lea    0x10(%edx,%edx,1),%ecx
  ioapic->reg = reg;
8010208d:	8b 15 34 26 11 80    	mov    0x80112634,%edx
80102093:	89 0a                	mov    %ecx,(%edx)
  ioapic->data = data;
80102095:	8b 15 34 26 11 80    	mov    0x80112634,%edx
8010209b:	89 5a 10             	mov    %ebx,0x10(%edx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010209e:	c1 e0 18             	shl    $0x18,%eax
801020a1:	41                   	inc    %ecx
  ioapic->reg = reg;
801020a2:	89 0a                	mov    %ecx,(%edx)
  ioapic->data = data;
801020a4:	8b 15 34 26 11 80    	mov    0x80112634,%edx
801020aa:	89 42 10             	mov    %eax,0x10(%edx)
}
801020ad:	5b                   	pop    %ebx
801020ae:	5d                   	pop    %ebp
801020af:	c3                   	ret    

801020b0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801020b0:	55                   	push   %ebp
801020b1:	89 e5                	mov    %esp,%ebp
801020b3:	53                   	push   %ebx
801020b4:	83 ec 14             	sub    $0x14,%esp
801020b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801020ba:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801020c0:	75 78                	jne    8010213a <kfree+0x8a>
801020c2:	81 fb a8 5b 11 80    	cmp    $0x80115ba8,%ebx
801020c8:	72 70                	jb     8010213a <kfree+0x8a>
801020ca:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801020d0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801020d5:	77 63                	ja     8010213a <kfree+0x8a>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801020d7:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
801020de:	00 
801020df:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
801020e6:	00 
801020e7:	89 1c 24             	mov    %ebx,(%esp)
801020ea:	e8 f5 23 00 00       	call   801044e4 <memset>

  if(kmem.use_lock)
801020ef:	8b 15 74 26 11 80    	mov    0x80112674,%edx
801020f5:	85 d2                	test   %edx,%edx
801020f7:	75 33                	jne    8010212c <kfree+0x7c>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801020f9:	a1 78 26 11 80       	mov    0x80112678,%eax
801020fe:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
80102100:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
  if(kmem.use_lock)
80102106:	a1 74 26 11 80       	mov    0x80112674,%eax
8010210b:	85 c0                	test   %eax,%eax
8010210d:	75 09                	jne    80102118 <kfree+0x68>
    release(&kmem.lock);
}
8010210f:	83 c4 14             	add    $0x14,%esp
80102112:	5b                   	pop    %ebx
80102113:	5d                   	pop    %ebp
80102114:	c3                   	ret    
80102115:	8d 76 00             	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102118:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
8010211f:	83 c4 14             	add    $0x14,%esp
80102122:	5b                   	pop    %ebx
80102123:	5d                   	pop    %ebp
    release(&kmem.lock);
80102124:	e9 73 23 00 00       	jmp    8010449c <release>
80102129:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&kmem.lock);
8010212c:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
80102133:	e8 a8 22 00 00       	call   801043e0 <acquire>
80102138:	eb bf                	jmp    801020f9 <kfree+0x49>
    panic("kfree");
8010213a:	c7 04 24 c6 6f 10 80 	movl   $0x80106fc6,(%esp)
80102141:	e8 ca e1 ff ff       	call   80100310 <panic>
80102146:	66 90                	xchg   %ax,%ax

80102148 <freerange>:
{
80102148:	55                   	push   %ebp
80102149:	89 e5                	mov    %esp,%ebp
8010214b:	56                   	push   %esi
8010214c:	53                   	push   %ebx
8010214d:	83 ec 10             	sub    $0x10,%esp
80102150:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
80102153:	8b 45 08             	mov    0x8(%ebp),%eax
80102156:	05 ff 0f 00 00       	add    $0xfff,%eax
8010215b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102160:	8d 98 00 10 00 00    	lea    0x1000(%eax),%ebx
80102166:	39 de                	cmp    %ebx,%esi
80102168:	72 16                	jb     80102180 <freerange+0x38>
8010216a:	66 90                	xchg   %ax,%ax
    kfree(p);
8010216c:	89 04 24             	mov    %eax,(%esp)
8010216f:	e8 3c ff ff ff       	call   801020b0 <kfree>
80102174:	89 d8                	mov    %ebx,%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102176:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010217c:	39 f3                	cmp    %esi,%ebx
8010217e:	76 ec                	jbe    8010216c <freerange+0x24>
}
80102180:	83 c4 10             	add    $0x10,%esp
80102183:	5b                   	pop    %ebx
80102184:	5e                   	pop    %esi
80102185:	5d                   	pop    %ebp
80102186:	c3                   	ret    
80102187:	90                   	nop

80102188 <kinit2>:
{
80102188:	55                   	push   %ebp
80102189:	89 e5                	mov    %esp,%ebp
8010218b:	83 ec 18             	sub    $0x18,%esp
  freerange(vstart, vend);
8010218e:	8b 45 0c             	mov    0xc(%ebp),%eax
80102191:	89 44 24 04          	mov    %eax,0x4(%esp)
80102195:	8b 45 08             	mov    0x8(%ebp),%eax
80102198:	89 04 24             	mov    %eax,(%esp)
8010219b:	e8 a8 ff ff ff       	call   80102148 <freerange>
  kmem.use_lock = 1;
801021a0:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
801021a7:	00 00 00 
}
801021aa:	c9                   	leave  
801021ab:	c3                   	ret    

801021ac <kinit1>:
{
801021ac:	55                   	push   %ebp
801021ad:	89 e5                	mov    %esp,%ebp
801021af:	56                   	push   %esi
801021b0:	53                   	push   %ebx
801021b1:	83 ec 10             	sub    $0x10,%esp
801021b4:	8b 5d 08             	mov    0x8(%ebp),%ebx
801021b7:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801021ba:	c7 44 24 04 cc 6f 10 	movl   $0x80106fcc,0x4(%esp)
801021c1:	80 
801021c2:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
801021c9:	e8 4a 21 00 00       	call   80104318 <initlock>
  kmem.use_lock = 0;
801021ce:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
801021d5:	00 00 00 
  freerange(vstart, vend);
801021d8:	89 75 0c             	mov    %esi,0xc(%ebp)
801021db:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801021de:	83 c4 10             	add    $0x10,%esp
801021e1:	5b                   	pop    %ebx
801021e2:	5e                   	pop    %esi
801021e3:	5d                   	pop    %ebp
  freerange(vstart, vend);
801021e4:	e9 5f ff ff ff       	jmp    80102148 <freerange>
801021e9:	8d 76 00             	lea    0x0(%esi),%esi

801021ec <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
801021ec:	55                   	push   %ebp
801021ed:	89 e5                	mov    %esp,%ebp
801021ef:	83 ec 28             	sub    $0x28,%esp
  struct run *r;

  if(kmem.use_lock)
801021f2:	8b 0d 74 26 11 80    	mov    0x80112674,%ecx
801021f8:	85 c9                	test   %ecx,%ecx
801021fa:	75 30                	jne    8010222c <kalloc+0x40>
801021fc:	31 d2                	xor    %edx,%edx
    acquire(&kmem.lock);
  r = kmem.freelist;
801021fe:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(r)
80102203:	85 c0                	test   %eax,%eax
80102205:	74 08                	je     8010220f <kalloc+0x23>
    kmem.freelist = r->next;
80102207:	8b 08                	mov    (%eax),%ecx
80102209:	89 0d 78 26 11 80    	mov    %ecx,0x80112678
  if(kmem.use_lock)
8010220f:	85 d2                	test   %edx,%edx
80102211:	75 05                	jne    80102218 <kalloc+0x2c>
    release(&kmem.lock);
  return (char*)r;
}
80102213:	c9                   	leave  
80102214:	c3                   	ret    
80102215:	8d 76 00             	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102218:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
8010221f:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102222:	e8 75 22 00 00       	call   8010449c <release>
80102227:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010222a:	c9                   	leave  
8010222b:	c3                   	ret    
    acquire(&kmem.lock);
8010222c:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
80102233:	e8 a8 21 00 00       	call   801043e0 <acquire>
80102238:	8b 15 74 26 11 80    	mov    0x80112674,%edx
8010223e:	eb be                	jmp    801021fe <kalloc+0x12>

80102240 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102240:	ba 64 00 00 00       	mov    $0x64,%edx
80102245:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102246:	a8 01                	test   $0x1,%al
80102248:	0f 84 ae 00 00 00    	je     801022fc <kbdgetc+0xbc>
8010224e:	b2 60                	mov    $0x60,%dl
80102250:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102251:	0f b6 c8             	movzbl %al,%ecx

  if(data == 0xE0){
80102254:	81 f9 e0 00 00 00    	cmp    $0xe0,%ecx
8010225a:	0f 84 80 00 00 00    	je     801022e0 <kbdgetc+0xa0>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102260:	84 c0                	test   %al,%al
80102262:	79 28                	jns    8010228c <kbdgetc+0x4c>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102264:	8b 15 9c a5 10 80    	mov    0x8010a59c,%edx
8010226a:	f6 c2 40             	test   $0x40,%dl
8010226d:	75 05                	jne    80102274 <kbdgetc+0x34>
8010226f:	89 c1                	mov    %eax,%ecx
80102271:	83 e1 7f             	and    $0x7f,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80102274:	8a 81 e0 6f 10 80    	mov    -0x7fef9020(%ecx),%al
8010227a:	83 c8 40             	or     $0x40,%eax
8010227d:	0f b6 c0             	movzbl %al,%eax
80102280:	f7 d0                	not    %eax
80102282:	21 d0                	and    %edx,%eax
80102284:	a3 9c a5 10 80       	mov    %eax,0x8010a59c
    return 0;
80102289:	31 c0                	xor    %eax,%eax
8010228b:	c3                   	ret    
{
8010228c:	55                   	push   %ebp
8010228d:	89 e5                	mov    %esp,%ebp
8010228f:	53                   	push   %ebx
  } else if(shift & E0ESC){
80102290:	8b 1d 9c a5 10 80    	mov    0x8010a59c,%ebx
80102296:	f6 c3 40             	test   $0x40,%bl
80102299:	74 09                	je     801022a4 <kbdgetc+0x64>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010229b:	83 c8 80             	or     $0xffffff80,%eax
8010229e:	0f b6 c8             	movzbl %al,%ecx
    shift &= ~E0ESC;
801022a1:	83 e3 bf             	and    $0xffffffbf,%ebx
  }

  shift |= shiftcode[data];
801022a4:	0f b6 91 e0 6f 10 80 	movzbl -0x7fef9020(%ecx),%edx
801022ab:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
801022ad:	0f b6 81 e0 70 10 80 	movzbl -0x7fef8f20(%ecx),%eax
801022b4:	31 c2                	xor    %eax,%edx
801022b6:	89 15 9c a5 10 80    	mov    %edx,0x8010a59c
  c = charcode[shift & (CTL | SHIFT)][data];
801022bc:	89 d0                	mov    %edx,%eax
801022be:	83 e0 03             	and    $0x3,%eax
801022c1:	8b 04 85 e0 71 10 80 	mov    -0x7fef8e20(,%eax,4),%eax
801022c8:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
801022cc:	83 e2 08             	and    $0x8,%edx
801022cf:	74 0b                	je     801022dc <kbdgetc+0x9c>
    if('a' <= c && c <= 'z')
801022d1:	8d 50 9f             	lea    -0x61(%eax),%edx
801022d4:	83 fa 19             	cmp    $0x19,%edx
801022d7:	77 13                	ja     801022ec <kbdgetc+0xac>
      c += 'A' - 'a';
801022d9:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801022dc:	5b                   	pop    %ebx
801022dd:	5d                   	pop    %ebp
801022de:	c3                   	ret    
801022df:	90                   	nop
    shift |= E0ESC;
801022e0:	83 0d 9c a5 10 80 40 	orl    $0x40,0x8010a59c
    return 0;
801022e7:	31 c0                	xor    %eax,%eax
801022e9:	c3                   	ret    
801022ea:	66 90                	xchg   %ax,%ax
    else if('A' <= c && c <= 'Z')
801022ec:	8d 50 bf             	lea    -0x41(%eax),%edx
801022ef:	83 fa 19             	cmp    $0x19,%edx
801022f2:	77 e8                	ja     801022dc <kbdgetc+0x9c>
      c += 'a' - 'A';
801022f4:	83 c0 20             	add    $0x20,%eax
  return c;
801022f7:	eb e3                	jmp    801022dc <kbdgetc+0x9c>
801022f9:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801022fc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102301:	c3                   	ret    
80102302:	66 90                	xchg   %ax,%ax

80102304 <kbdintr>:

void
kbdintr(void)
{
80102304:	55                   	push   %ebp
80102305:	89 e5                	mov    %esp,%ebp
80102307:	83 ec 18             	sub    $0x18,%esp
  consoleintr(kbdgetc);
8010230a:	c7 04 24 40 22 10 80 	movl   $0x80102240,(%esp)
80102311:	e8 ea e3 ff ff       	call   80100700 <consoleintr>
}
80102316:	c9                   	leave  
80102317:	c3                   	ret    

80102318 <fill_rtcdate>:

  return inb(CMOS_RETURN);
}

static void fill_rtcdate(struct rtcdate *r)
{
80102318:	55                   	push   %ebp
80102319:	89 e5                	mov    %esp,%ebp
8010231b:	53                   	push   %ebx
8010231c:	89 c1                	mov    %eax,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010231e:	ba 70 00 00 00       	mov    $0x70,%edx
80102323:	31 c0                	xor    %eax,%eax
80102325:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102326:	bb 71 00 00 00       	mov    $0x71,%ebx
8010232b:	89 da                	mov    %ebx,%edx
8010232d:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
8010232e:	0f b6 c0             	movzbl %al,%eax
80102331:	89 01                	mov    %eax,(%ecx)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102333:	b2 70                	mov    $0x70,%dl
80102335:	b0 02                	mov    $0x2,%al
80102337:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102338:	89 da                	mov    %ebx,%edx
8010233a:	ec                   	in     (%dx),%al
8010233b:	0f b6 c0             	movzbl %al,%eax
8010233e:	89 41 04             	mov    %eax,0x4(%ecx)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102341:	b2 70                	mov    $0x70,%dl
80102343:	b0 04                	mov    $0x4,%al
80102345:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102346:	89 da                	mov    %ebx,%edx
80102348:	ec                   	in     (%dx),%al
80102349:	0f b6 c0             	movzbl %al,%eax
8010234c:	89 41 08             	mov    %eax,0x8(%ecx)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010234f:	b2 70                	mov    $0x70,%dl
80102351:	b0 07                	mov    $0x7,%al
80102353:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102354:	89 da                	mov    %ebx,%edx
80102356:	ec                   	in     (%dx),%al
80102357:	0f b6 c0             	movzbl %al,%eax
8010235a:	89 41 0c             	mov    %eax,0xc(%ecx)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010235d:	b2 70                	mov    $0x70,%dl
8010235f:	b0 08                	mov    $0x8,%al
80102361:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102362:	89 da                	mov    %ebx,%edx
80102364:	ec                   	in     (%dx),%al
80102365:	0f b6 c0             	movzbl %al,%eax
80102368:	89 41 10             	mov    %eax,0x10(%ecx)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010236b:	b2 70                	mov    $0x70,%dl
8010236d:	b0 09                	mov    $0x9,%al
8010236f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102370:	89 da                	mov    %ebx,%edx
80102372:	ec                   	in     (%dx),%al
80102373:	0f b6 d8             	movzbl %al,%ebx
80102376:	89 59 14             	mov    %ebx,0x14(%ecx)
  r->minute = cmos_read(MINS);
  r->hour   = cmos_read(HOURS);
  r->day    = cmos_read(DAY);
  r->month  = cmos_read(MONTH);
  r->year   = cmos_read(YEAR);
}
80102379:	5b                   	pop    %ebx
8010237a:	5d                   	pop    %ebp
8010237b:	c3                   	ret    

8010237c <lapicinit>:
{
8010237c:	55                   	push   %ebp
8010237d:	89 e5                	mov    %esp,%ebp
  if(!lapic)
8010237f:	a1 7c 26 11 80       	mov    0x8011267c,%eax
80102384:	85 c0                	test   %eax,%eax
80102386:	0f 84 c0 00 00 00    	je     8010244c <lapicinit+0xd0>
  lapic[index] = value;
8010238c:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102393:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102396:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102399:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
801023a0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801023a3:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801023a6:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801023ad:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
801023b0:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801023b3:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801023ba:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
801023bd:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801023c0:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
801023c7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801023ca:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801023cd:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
801023d4:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801023d7:	8b 50 20             	mov    0x20(%eax),%edx
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801023da:	8b 50 30             	mov    0x30(%eax),%edx
801023dd:	c1 ea 10             	shr    $0x10,%edx
801023e0:	80 fa 03             	cmp    $0x3,%dl
801023e3:	77 6b                	ja     80102450 <lapicinit+0xd4>
  lapic[index] = value;
801023e5:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801023ec:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801023ef:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801023f2:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801023f9:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801023fc:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801023ff:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102406:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102409:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010240c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102413:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102416:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102419:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102420:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102423:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102426:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
8010242d:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102430:	8b 50 20             	mov    0x20(%eax),%edx
80102433:	90                   	nop
  while(lapic[ICRLO] & DELIVS)
80102434:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
8010243a:	80 e6 10             	and    $0x10,%dh
8010243d:	75 f5                	jne    80102434 <lapicinit+0xb8>
  lapic[index] = value;
8010243f:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102446:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102449:	8b 40 20             	mov    0x20(%eax),%eax
}
8010244c:	5d                   	pop    %ebp
8010244d:	c3                   	ret    
8010244e:	66 90                	xchg   %ax,%ax
  lapic[index] = value;
80102450:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102457:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010245a:	8b 50 20             	mov    0x20(%eax),%edx
8010245d:	eb 86                	jmp    801023e5 <lapicinit+0x69>
8010245f:	90                   	nop

80102460 <lapicid>:
{
80102460:	55                   	push   %ebp
80102461:	89 e5                	mov    %esp,%ebp
  if (!lapic)
80102463:	a1 7c 26 11 80       	mov    0x8011267c,%eax
80102468:	85 c0                	test   %eax,%eax
8010246a:	74 08                	je     80102474 <lapicid+0x14>
  return lapic[ID] >> 24;
8010246c:	8b 40 20             	mov    0x20(%eax),%eax
8010246f:	c1 e8 18             	shr    $0x18,%eax
}
80102472:	5d                   	pop    %ebp
80102473:	c3                   	ret    
    return 0;
80102474:	31 c0                	xor    %eax,%eax
}
80102476:	5d                   	pop    %ebp
80102477:	c3                   	ret    

80102478 <lapiceoi>:
{
80102478:	55                   	push   %ebp
80102479:	89 e5                	mov    %esp,%ebp
  if(lapic)
8010247b:	a1 7c 26 11 80       	mov    0x8011267c,%eax
80102480:	85 c0                	test   %eax,%eax
80102482:	74 0d                	je     80102491 <lapiceoi+0x19>
  lapic[index] = value;
80102484:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
8010248b:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010248e:	8b 40 20             	mov    0x20(%eax),%eax
}
80102491:	5d                   	pop    %ebp
80102492:	c3                   	ret    
80102493:	90                   	nop

80102494 <microdelay>:
{
80102494:	55                   	push   %ebp
80102495:	89 e5                	mov    %esp,%ebp
}
80102497:	5d                   	pop    %ebp
80102498:	c3                   	ret    
80102499:	8d 76 00             	lea    0x0(%esi),%esi

8010249c <lapicstartap>:
{
8010249c:	55                   	push   %ebp
8010249d:	89 e5                	mov    %esp,%ebp
8010249f:	53                   	push   %ebx
801024a0:	8a 4d 08             	mov    0x8(%ebp),%cl
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801024a3:	ba 70 00 00 00       	mov    $0x70,%edx
801024a8:	b0 0f                	mov    $0xf,%al
801024aa:	ee                   	out    %al,(%dx)
801024ab:	b2 71                	mov    $0x71,%dl
801024ad:	b0 0a                	mov    $0xa,%al
801024af:	ee                   	out    %al,(%dx)
  wrv[0] = 0;
801024b0:	66 c7 05 67 04 00 80 	movw   $0x0,0x80000467
801024b7:	00 00 
  wrv[1] = addr >> 4;
801024b9:	8b 45 0c             	mov    0xc(%ebp),%eax
801024bc:	c1 e8 04             	shr    $0x4,%eax
801024bf:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
801024c5:	a1 7c 26 11 80       	mov    0x8011267c,%eax
  lapicw(ICRHI, apicid<<24);
801024ca:	c1 e1 18             	shl    $0x18,%ecx
  lapic[index] = value;
801024cd:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801024d3:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801024d6:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801024dd:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801024e0:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801024e3:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801024ea:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801024ed:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801024f0:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801024f6:	8b 50 20             	mov    0x20(%eax),%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
801024f9:	8b 55 0c             	mov    0xc(%ebp),%edx
801024fc:	c1 ea 0c             	shr    $0xc,%edx
801024ff:	80 ce 06             	or     $0x6,%dh
  lapic[index] = value;
80102502:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102508:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010250b:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102511:	8b 48 20             	mov    0x20(%eax),%ecx
  lapic[index] = value;
80102514:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010251a:	8b 40 20             	mov    0x20(%eax),%eax
}
8010251d:	5b                   	pop    %ebx
8010251e:	5d                   	pop    %ebp
8010251f:	c3                   	ret    

80102520 <cmostime>:

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
80102520:	55                   	push   %ebp
80102521:	89 e5                	mov    %esp,%ebp
80102523:	57                   	push   %edi
80102524:	56                   	push   %esi
80102525:	53                   	push   %ebx
80102526:	83 ec 5c             	sub    $0x5c,%esp
80102529:	ba 70 00 00 00       	mov    $0x70,%edx
8010252e:	b0 0b                	mov    $0xb,%al
80102530:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102531:	b2 71                	mov    $0x71,%dl
80102533:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
80102534:	83 e0 04             	and    $0x4,%eax
80102537:	88 45 b7             	mov    %al,-0x49(%ebp)
8010253a:	8d 75 b8             	lea    -0x48(%ebp),%esi
8010253d:	8d 7d d0             	lea    -0x30(%ebp),%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102540:	bb 70 00 00 00       	mov    $0x70,%ebx
80102545:	8d 76 00             	lea    0x0(%esi),%esi

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
80102548:	89 f0                	mov    %esi,%eax
8010254a:	e8 c9 fd ff ff       	call   80102318 <fill_rtcdate>
8010254f:	b0 0a                	mov    $0xa,%al
80102551:	89 da                	mov    %ebx,%edx
80102553:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102554:	ba 71 00 00 00       	mov    $0x71,%edx
80102559:	ec                   	in     (%dx),%al
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
8010255a:	84 c0                	test   %al,%al
8010255c:	78 ea                	js     80102548 <cmostime+0x28>
        continue;
    fill_rtcdate(&t2);
8010255e:	89 f8                	mov    %edi,%eax
80102560:	e8 b3 fd ff ff       	call   80102318 <fill_rtcdate>
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102565:	c7 44 24 08 18 00 00 	movl   $0x18,0x8(%esp)
8010256c:	00 
8010256d:	89 7c 24 04          	mov    %edi,0x4(%esp)
80102571:	89 34 24             	mov    %esi,(%esp)
80102574:	e8 b7 1f 00 00       	call   80104530 <memcmp>
80102579:	85 c0                	test   %eax,%eax
8010257b:	75 cb                	jne    80102548 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
8010257d:	80 7d b7 00          	cmpb   $0x0,-0x49(%ebp)
80102581:	75 78                	jne    801025fb <cmostime+0xdb>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102583:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102586:	89 c2                	mov    %eax,%edx
80102588:	c1 ea 04             	shr    $0x4,%edx
8010258b:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010258e:	83 e0 0f             	and    $0xf,%eax
80102591:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102594:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102597:	8b 45 bc             	mov    -0x44(%ebp),%eax
8010259a:	89 c2                	mov    %eax,%edx
8010259c:	c1 ea 04             	shr    $0x4,%edx
8010259f:	8d 14 92             	lea    (%edx,%edx,4),%edx
801025a2:	83 e0 0f             	and    $0xf,%eax
801025a5:	8d 04 50             	lea    (%eax,%edx,2),%eax
801025a8:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
801025ab:	8b 45 c0             	mov    -0x40(%ebp),%eax
801025ae:	89 c2                	mov    %eax,%edx
801025b0:	c1 ea 04             	shr    $0x4,%edx
801025b3:	8d 14 92             	lea    (%edx,%edx,4),%edx
801025b6:	83 e0 0f             	and    $0xf,%eax
801025b9:	8d 04 50             	lea    (%eax,%edx,2),%eax
801025bc:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
801025bf:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801025c2:	89 c2                	mov    %eax,%edx
801025c4:	c1 ea 04             	shr    $0x4,%edx
801025c7:	8d 14 92             	lea    (%edx,%edx,4),%edx
801025ca:	83 e0 0f             	and    $0xf,%eax
801025cd:	8d 04 50             	lea    (%eax,%edx,2),%eax
801025d0:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
801025d3:	8b 45 c8             	mov    -0x38(%ebp),%eax
801025d6:	89 c2                	mov    %eax,%edx
801025d8:	c1 ea 04             	shr    $0x4,%edx
801025db:	8d 14 92             	lea    (%edx,%edx,4),%edx
801025de:	83 e0 0f             	and    $0xf,%eax
801025e1:	8d 04 50             	lea    (%eax,%edx,2),%eax
801025e4:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
801025e7:	8b 45 cc             	mov    -0x34(%ebp),%eax
801025ea:	89 c2                	mov    %eax,%edx
801025ec:	c1 ea 04             	shr    $0x4,%edx
801025ef:	8d 14 92             	lea    (%edx,%edx,4),%edx
801025f2:	83 e0 0f             	and    $0xf,%eax
801025f5:	8d 04 50             	lea    (%eax,%edx,2),%eax
801025f8:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
801025fb:	b9 06 00 00 00       	mov    $0x6,%ecx
80102600:	8b 7d 08             	mov    0x8(%ebp),%edi
80102603:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  r->year += 2000;
80102605:	8b 45 08             	mov    0x8(%ebp),%eax
80102608:	81 40 14 d0 07 00 00 	addl   $0x7d0,0x14(%eax)
}
8010260f:	83 c4 5c             	add    $0x5c,%esp
80102612:	5b                   	pop    %ebx
80102613:	5e                   	pop    %esi
80102614:	5f                   	pop    %edi
80102615:	5d                   	pop    %ebp
80102616:	c3                   	ret    
80102617:	90                   	nop

80102618 <install_trans>:
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80102618:	55                   	push   %ebp
80102619:	89 e5                	mov    %esp,%ebp
8010261b:	57                   	push   %edi
8010261c:	56                   	push   %esi
8010261d:	53                   	push   %ebx
8010261e:	83 ec 1c             	sub    $0x1c,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102621:	31 db                	xor    %ebx,%ebx
80102623:	a1 c8 26 11 80       	mov    0x801126c8,%eax
80102628:	85 c0                	test   %eax,%eax
8010262a:	7e 70                	jle    8010269c <install_trans+0x84>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
8010262c:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102631:	01 d8                	add    %ebx,%eax
80102633:	40                   	inc    %eax
80102634:	89 44 24 04          	mov    %eax,0x4(%esp)
80102638:	a1 c4 26 11 80       	mov    0x801126c4,%eax
8010263d:	89 04 24             	mov    %eax,(%esp)
80102640:	e8 6f da ff ff       	call   801000b4 <bread>
80102645:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102647:	8b 04 9d cc 26 11 80 	mov    -0x7feed934(,%ebx,4),%eax
8010264e:	89 44 24 04          	mov    %eax,0x4(%esp)
80102652:	a1 c4 26 11 80       	mov    0x801126c4,%eax
80102657:	89 04 24             	mov    %eax,(%esp)
8010265a:	e8 55 da ff ff       	call   801000b4 <bread>
8010265f:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102661:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80102668:	00 
80102669:	8d 47 5c             	lea    0x5c(%edi),%eax
8010266c:	89 44 24 04          	mov    %eax,0x4(%esp)
80102670:	8d 46 5c             	lea    0x5c(%esi),%eax
80102673:	89 04 24             	mov    %eax,(%esp)
80102676:	e8 fd 1e 00 00       	call   80104578 <memmove>
    bwrite(dbuf);  // write dst to disk
8010267b:	89 34 24             	mov    %esi,(%esp)
8010267e:	e8 ed da ff ff       	call   80100170 <bwrite>
    brelse(lbuf);
80102683:	89 3c 24             	mov    %edi,(%esp)
80102686:	e8 1d db ff ff       	call   801001a8 <brelse>
    brelse(dbuf);
8010268b:	89 34 24             	mov    %esi,(%esp)
8010268e:	e8 15 db ff ff       	call   801001a8 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102693:	43                   	inc    %ebx
80102694:	39 1d c8 26 11 80    	cmp    %ebx,0x801126c8
8010269a:	7f 90                	jg     8010262c <install_trans+0x14>
  }
}
8010269c:	83 c4 1c             	add    $0x1c,%esp
8010269f:	5b                   	pop    %ebx
801026a0:	5e                   	pop    %esi
801026a1:	5f                   	pop    %edi
801026a2:	5d                   	pop    %ebp
801026a3:	c3                   	ret    

801026a4 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
801026a4:	55                   	push   %ebp
801026a5:	89 e5                	mov    %esp,%ebp
801026a7:	57                   	push   %edi
801026a8:	56                   	push   %esi
801026a9:	53                   	push   %ebx
801026aa:	83 ec 1c             	sub    $0x1c,%esp
  struct buf *buf = bread(log.dev, log.start);
801026ad:	a1 b4 26 11 80       	mov    0x801126b4,%eax
801026b2:	89 44 24 04          	mov    %eax,0x4(%esp)
801026b6:	a1 c4 26 11 80       	mov    0x801126c4,%eax
801026bb:	89 04 24             	mov    %eax,(%esp)
801026be:	e8 f1 d9 ff ff       	call   801000b4 <bread>
801026c3:	89 c7                	mov    %eax,%edi
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
801026c5:	8b 1d c8 26 11 80    	mov    0x801126c8,%ebx
801026cb:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
801026ce:	85 db                	test   %ebx,%ebx
801026d0:	7e 16                	jle    801026e8 <write_head+0x44>
801026d2:	31 d2                	xor    %edx,%edx
801026d4:	8d 70 5c             	lea    0x5c(%eax),%esi
801026d7:	90                   	nop
    hb->block[i] = log.lh.block[i];
801026d8:	8b 0c 95 cc 26 11 80 	mov    -0x7feed934(,%edx,4),%ecx
801026df:	89 4c 96 04          	mov    %ecx,0x4(%esi,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
801026e3:	42                   	inc    %edx
801026e4:	39 da                	cmp    %ebx,%edx
801026e6:	75 f0                	jne    801026d8 <write_head+0x34>
  }
  bwrite(buf);
801026e8:	89 3c 24             	mov    %edi,(%esp)
801026eb:	e8 80 da ff ff       	call   80100170 <bwrite>
  brelse(buf);
801026f0:	89 3c 24             	mov    %edi,(%esp)
801026f3:	e8 b0 da ff ff       	call   801001a8 <brelse>
}
801026f8:	83 c4 1c             	add    $0x1c,%esp
801026fb:	5b                   	pop    %ebx
801026fc:	5e                   	pop    %esi
801026fd:	5f                   	pop    %edi
801026fe:	5d                   	pop    %ebp
801026ff:	c3                   	ret    

80102700 <initlog>:
{
80102700:	55                   	push   %ebp
80102701:	89 e5                	mov    %esp,%ebp
80102703:	56                   	push   %esi
80102704:	53                   	push   %ebx
80102705:	83 ec 30             	sub    $0x30,%esp
80102708:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
8010270b:	c7 44 24 04 f0 71 10 	movl   $0x801071f0,0x4(%esp)
80102712:	80 
80102713:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
8010271a:	e8 f9 1b 00 00       	call   80104318 <initlock>
  readsb(dev, &sb);
8010271f:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102722:	89 44 24 04          	mov    %eax,0x4(%esp)
80102726:	89 1c 24             	mov    %ebx,(%esp)
80102729:	e8 32 eb ff ff       	call   80101260 <readsb>
  log.start = sb.logstart;
8010272e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102731:	a3 b4 26 11 80       	mov    %eax,0x801126b4
  log.size = sb.nlog;
80102736:	8b 55 e8             	mov    -0x18(%ebp),%edx
80102739:	89 15 b8 26 11 80    	mov    %edx,0x801126b8
  log.dev = dev;
8010273f:	89 1d c4 26 11 80    	mov    %ebx,0x801126c4
  struct buf *buf = bread(log.dev, log.start);
80102745:	89 44 24 04          	mov    %eax,0x4(%esp)
80102749:	89 1c 24             	mov    %ebx,(%esp)
8010274c:	e8 63 d9 ff ff       	call   801000b4 <bread>
  log.lh.n = lh->n;
80102751:	8b 58 5c             	mov    0x5c(%eax),%ebx
80102754:	89 1d c8 26 11 80    	mov    %ebx,0x801126c8
  for (i = 0; i < log.lh.n; i++) {
8010275a:	85 db                	test   %ebx,%ebx
8010275c:	7e 16                	jle    80102774 <initlog+0x74>
8010275e:	31 d2                	xor    %edx,%edx
80102760:	8d 70 5c             	lea    0x5c(%eax),%esi
80102763:	90                   	nop
    log.lh.block[i] = lh->block[i];
80102764:	8b 4c 96 04          	mov    0x4(%esi,%edx,4),%ecx
80102768:	89 0c 95 cc 26 11 80 	mov    %ecx,-0x7feed934(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
8010276f:	42                   	inc    %edx
80102770:	39 da                	cmp    %ebx,%edx
80102772:	75 f0                	jne    80102764 <initlog+0x64>
  brelse(buf);
80102774:	89 04 24             	mov    %eax,(%esp)
80102777:	e8 2c da ff ff       	call   801001a8 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
8010277c:	e8 97 fe ff ff       	call   80102618 <install_trans>
  log.lh.n = 0;
80102781:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102788:	00 00 00 
  write_head(); // clear the log
8010278b:	e8 14 ff ff ff       	call   801026a4 <write_head>
}
80102790:	83 c4 30             	add    $0x30,%esp
80102793:	5b                   	pop    %ebx
80102794:	5e                   	pop    %esi
80102795:	5d                   	pop    %ebp
80102796:	c3                   	ret    
80102797:	90                   	nop

80102798 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102798:	55                   	push   %ebp
80102799:	89 e5                	mov    %esp,%ebp
8010279b:	83 ec 18             	sub    $0x18,%esp
  acquire(&log.lock);
8010279e:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
801027a5:	e8 36 1c 00 00       	call   801043e0 <acquire>
801027aa:	eb 14                	jmp    801027c0 <begin_op+0x28>
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
801027ac:	c7 44 24 04 80 26 11 	movl   $0x80112680,0x4(%esp)
801027b3:	80 
801027b4:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
801027bb:	e8 bc 13 00 00       	call   80103b7c <sleep>
    if(log.committing){
801027c0:	8b 15 c0 26 11 80    	mov    0x801126c0,%edx
801027c6:	85 d2                	test   %edx,%edx
801027c8:	75 e2                	jne    801027ac <begin_op+0x14>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
801027ca:	a1 bc 26 11 80       	mov    0x801126bc,%eax
801027cf:	40                   	inc    %eax
801027d0:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
801027d3:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
801027d9:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
801027dc:	83 fa 1e             	cmp    $0x1e,%edx
801027df:	7f cb                	jg     801027ac <begin_op+0x14>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
801027e1:	a3 bc 26 11 80       	mov    %eax,0x801126bc
      release(&log.lock);
801027e6:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
801027ed:	e8 aa 1c 00 00       	call   8010449c <release>
      break;
    }
  }
}
801027f2:	c9                   	leave  
801027f3:	c3                   	ret    

801027f4 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
801027f4:	55                   	push   %ebp
801027f5:	89 e5                	mov    %esp,%ebp
801027f7:	57                   	push   %edi
801027f8:	56                   	push   %esi
801027f9:	53                   	push   %ebx
801027fa:	83 ec 1c             	sub    $0x1c,%esp
  int do_commit = 0;

  acquire(&log.lock);
801027fd:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102804:	e8 d7 1b 00 00       	call   801043e0 <acquire>
  log.outstanding -= 1;
80102809:	a1 bc 26 11 80       	mov    0x801126bc,%eax
8010280e:	48                   	dec    %eax
8010280f:	a3 bc 26 11 80       	mov    %eax,0x801126bc
  if(log.committing)
80102814:	8b 1d c0 26 11 80    	mov    0x801126c0,%ebx
8010281a:	85 db                	test   %ebx,%ebx
8010281c:	0f 85 ed 00 00 00    	jne    8010290f <end_op+0x11b>
    panic("log.committing");
  if(log.outstanding == 0){
80102822:	85 c0                	test   %eax,%eax
80102824:	0f 85 c5 00 00 00    	jne    801028ef <end_op+0xfb>
    do_commit = 1;
    log.committing = 1;
8010282a:	c7 05 c0 26 11 80 01 	movl   $0x1,0x801126c0
80102831:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102834:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
8010283b:	e8 5c 1c 00 00       	call   8010449c <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102840:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102846:	85 c9                	test   %ecx,%ecx
80102848:	0f 8e 8b 00 00 00    	jle    801028d9 <end_op+0xe5>
8010284e:	31 db                	xor    %ebx,%ebx
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102850:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102855:	01 d8                	add    %ebx,%eax
80102857:	40                   	inc    %eax
80102858:	89 44 24 04          	mov    %eax,0x4(%esp)
8010285c:	a1 c4 26 11 80       	mov    0x801126c4,%eax
80102861:	89 04 24             	mov    %eax,(%esp)
80102864:	e8 4b d8 ff ff       	call   801000b4 <bread>
80102869:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010286b:	8b 04 9d cc 26 11 80 	mov    -0x7feed934(,%ebx,4),%eax
80102872:	89 44 24 04          	mov    %eax,0x4(%esp)
80102876:	a1 c4 26 11 80       	mov    0x801126c4,%eax
8010287b:	89 04 24             	mov    %eax,(%esp)
8010287e:	e8 31 d8 ff ff       	call   801000b4 <bread>
80102883:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102885:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
8010288c:	00 
8010288d:	8d 40 5c             	lea    0x5c(%eax),%eax
80102890:	89 44 24 04          	mov    %eax,0x4(%esp)
80102894:	8d 46 5c             	lea    0x5c(%esi),%eax
80102897:	89 04 24             	mov    %eax,(%esp)
8010289a:	e8 d9 1c 00 00       	call   80104578 <memmove>
    bwrite(to);  // write the log
8010289f:	89 34 24             	mov    %esi,(%esp)
801028a2:	e8 c9 d8 ff ff       	call   80100170 <bwrite>
    brelse(from);
801028a7:	89 3c 24             	mov    %edi,(%esp)
801028aa:	e8 f9 d8 ff ff       	call   801001a8 <brelse>
    brelse(to);
801028af:	89 34 24             	mov    %esi,(%esp)
801028b2:	e8 f1 d8 ff ff       	call   801001a8 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
801028b7:	43                   	inc    %ebx
801028b8:	3b 1d c8 26 11 80    	cmp    0x801126c8,%ebx
801028be:	7c 90                	jl     80102850 <end_op+0x5c>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
801028c0:	e8 df fd ff ff       	call   801026a4 <write_head>
    install_trans(); // Now install writes to home locations
801028c5:	e8 4e fd ff ff       	call   80102618 <install_trans>
    log.lh.n = 0;
801028ca:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
801028d1:	00 00 00 
    write_head();    // Erase the transaction from the log
801028d4:	e8 cb fd ff ff       	call   801026a4 <write_head>
    acquire(&log.lock);
801028d9:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
801028e0:	e8 fb 1a 00 00       	call   801043e0 <acquire>
    log.committing = 0;
801028e5:	c7 05 c0 26 11 80 00 	movl   $0x0,0x801126c0
801028ec:	00 00 00 
    wakeup(&log);
801028ef:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
801028f6:	e8 4d 14 00 00       	call   80103d48 <wakeup>
    release(&log.lock);
801028fb:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102902:	e8 95 1b 00 00       	call   8010449c <release>
}
80102907:	83 c4 1c             	add    $0x1c,%esp
8010290a:	5b                   	pop    %ebx
8010290b:	5e                   	pop    %esi
8010290c:	5f                   	pop    %edi
8010290d:	5d                   	pop    %ebp
8010290e:	c3                   	ret    
    panic("log.committing");
8010290f:	c7 04 24 f4 71 10 80 	movl   $0x801071f4,(%esp)
80102916:	e8 f5 d9 ff ff       	call   80100310 <panic>
8010291b:	90                   	nop

8010291c <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
8010291c:	55                   	push   %ebp
8010291d:	89 e5                	mov    %esp,%ebp
8010291f:	53                   	push   %ebx
80102920:	83 ec 14             	sub    $0x14,%esp
80102923:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102926:	a1 c8 26 11 80       	mov    0x801126c8,%eax
8010292b:	83 f8 1d             	cmp    $0x1d,%eax
8010292e:	0f 8f 84 00 00 00    	jg     801029b8 <log_write+0x9c>
80102934:	8b 15 b8 26 11 80    	mov    0x801126b8,%edx
8010293a:	4a                   	dec    %edx
8010293b:	39 d0                	cmp    %edx,%eax
8010293d:	7d 79                	jge    801029b8 <log_write+0x9c>
    panic("too big a transaction");
  if (log.outstanding < 1)
8010293f:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102944:	85 c0                	test   %eax,%eax
80102946:	7e 7c                	jle    801029c4 <log_write+0xa8>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102948:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
8010294f:	e8 8c 1a 00 00       	call   801043e0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102954:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
8010295a:	83 fa 00             	cmp    $0x0,%edx
8010295d:	7e 4a                	jle    801029a9 <log_write+0x8d>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
8010295f:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102962:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102964:	39 0d cc 26 11 80    	cmp    %ecx,0x801126cc
8010296a:	75 0d                	jne    80102979 <log_write+0x5d>
8010296c:	eb 32                	jmp    801029a0 <log_write+0x84>
8010296e:	66 90                	xchg   %ax,%ax
80102970:	39 0c 85 cc 26 11 80 	cmp    %ecx,-0x7feed934(,%eax,4)
80102977:	74 27                	je     801029a0 <log_write+0x84>
  for (i = 0; i < log.lh.n; i++) {
80102979:	40                   	inc    %eax
8010297a:	39 d0                	cmp    %edx,%eax
8010297c:	75 f2                	jne    80102970 <log_write+0x54>
      break;
  }
  log.lh.block[i] = b->blockno;
8010297e:	89 0c 95 cc 26 11 80 	mov    %ecx,-0x7feed934(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80102985:	42                   	inc    %edx
80102986:	89 15 c8 26 11 80    	mov    %edx,0x801126c8
  b->flags |= B_DIRTY; // prevent eviction
8010298c:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
8010298f:	c7 45 08 80 26 11 80 	movl   $0x80112680,0x8(%ebp)
}
80102996:	83 c4 14             	add    $0x14,%esp
80102999:	5b                   	pop    %ebx
8010299a:	5d                   	pop    %ebp
  release(&log.lock);
8010299b:	e9 fc 1a 00 00       	jmp    8010449c <release>
  log.lh.block[i] = b->blockno;
801029a0:	89 0c 85 cc 26 11 80 	mov    %ecx,-0x7feed934(,%eax,4)
801029a7:	eb e3                	jmp    8010298c <log_write+0x70>
801029a9:	8b 43 08             	mov    0x8(%ebx),%eax
801029ac:	a3 cc 26 11 80       	mov    %eax,0x801126cc
  if (i == log.lh.n)
801029b1:	75 d9                	jne    8010298c <log_write+0x70>
801029b3:	eb d0                	jmp    80102985 <log_write+0x69>
801029b5:	8d 76 00             	lea    0x0(%esi),%esi
    panic("too big a transaction");
801029b8:	c7 04 24 03 72 10 80 	movl   $0x80107203,(%esp)
801029bf:	e8 4c d9 ff ff       	call   80100310 <panic>
    panic("log_write outside of trans");
801029c4:	c7 04 24 19 72 10 80 	movl   $0x80107219,(%esp)
801029cb:	e8 40 d9 ff ff       	call   80100310 <panic>

801029d0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801029d0:	55                   	push   %ebp
801029d1:	89 e5                	mov    %esp,%ebp
801029d3:	53                   	push   %ebx
801029d4:	83 ec 14             	sub    $0x14,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
801029d7:	e8 78 08 00 00       	call   80103254 <cpuid>
801029dc:	89 c3                	mov    %eax,%ebx
801029de:	e8 71 08 00 00       	call   80103254 <cpuid>
801029e3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
801029e7:	89 44 24 04          	mov    %eax,0x4(%esp)
801029eb:	c7 04 24 34 72 10 80 	movl   $0x80107234,(%esp)
801029f2:	e8 bd db ff ff       	call   801005b4 <cprintf>
  idtinit();       // load idt register
801029f7:	e8 88 2c 00 00       	call   80105684 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
801029fc:	e8 df 07 00 00       	call   801031e0 <mycpu>
80102a01:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102a03:	b8 01 00 00 00       	mov    $0x1,%eax
80102a08:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102a0f:	e8 e8 0b 00 00       	call   801035fc <scheduler>

80102a14 <mpenter>:
{
80102a14:	55                   	push   %ebp
80102a15:	89 e5                	mov    %esp,%ebp
80102a17:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102a1a:	e8 35 3c 00 00       	call   80106654 <switchkvm>
  seginit();
80102a1f:	e8 54 3b 00 00       	call   80106578 <seginit>
  lapicinit();
80102a24:	e8 53 f9 ff ff       	call   8010237c <lapicinit>
  mpmain();
80102a29:	e8 a2 ff ff ff       	call   801029d0 <mpmain>
80102a2e:	66 90                	xchg   %ax,%ax

80102a30 <main>:
{
80102a30:	55                   	push   %ebp
80102a31:	89 e5                	mov    %esp,%ebp
80102a33:	53                   	push   %ebx
80102a34:	83 e4 f0             	and    $0xfffffff0,%esp
80102a37:	83 ec 10             	sub    $0x10,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102a3a:	c7 44 24 04 00 00 40 	movl   $0x80400000,0x4(%esp)
80102a41:	80 
80102a42:	c7 04 24 a8 5b 11 80 	movl   $0x80115ba8,(%esp)
80102a49:	e8 5e f7 ff ff       	call   801021ac <kinit1>
  kvmalloc();      // kernel page table
80102a4e:	e8 11 41 00 00       	call   80106b64 <kvmalloc>
  mpinit();        // detect other processors
80102a53:	e8 54 01 00 00       	call   80102bac <mpinit>
  lapicinit();     // interrupt controller
80102a58:	e8 1f f9 ff ff       	call   8010237c <lapicinit>
  seginit();       // segment descriptors
80102a5d:	e8 16 3b 00 00       	call   80106578 <seginit>
  picinit();       // disable pic
80102a62:	e8 ed 02 00 00       	call   80102d54 <picinit>
  ioapicinit();    // another interrupt controller
80102a67:	e8 70 f5 ff ff       	call   80101fdc <ioapicinit>
  consoleinit();   // console hardware
80102a6c:	e8 1b de ff ff       	call   8010088c <consoleinit>
  uartinit();      // serial port
80102a71:	e8 ee 2e 00 00       	call   80105964 <uartinit>
  pinit();         // process table
80102a76:	e8 49 07 00 00       	call   801031c4 <pinit>
  tvinit();        // trap vectors
80102a7b:	e8 7c 2b 00 00       	call   801055fc <tvinit>
  binit();         // buffer cache
80102a80:	e8 af d5 ff ff       	call   80100034 <binit>
  fileinit();      // file table
80102a85:	e8 f2 e1 ff ff       	call   80100c7c <fileinit>
  ideinit();       // disk 
80102a8a:	e8 6d f3 ff ff       	call   80101dfc <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102a8f:	c7 44 24 08 8a 00 00 	movl   $0x8a,0x8(%esp)
80102a96:	00 
80102a97:	c7 44 24 04 8c a4 10 	movl   $0x8010a48c,0x4(%esp)
80102a9e:	80 
80102a9f:	c7 04 24 00 70 00 80 	movl   $0x80007000,(%esp)
80102aa6:	e8 cd 1a 00 00       	call   80104578 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102aab:	a1 00 2d 11 80       	mov    0x80112d00,%eax
80102ab0:	8d 14 80             	lea    (%eax,%eax,4),%edx
80102ab3:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102ab6:	c1 e0 04             	shl    $0x4,%eax
80102ab9:	05 80 27 11 80       	add    $0x80112780,%eax
80102abe:	bb 80 27 11 80       	mov    $0x80112780,%ebx
80102ac3:	39 d8                	cmp    %ebx,%eax
80102ac5:	76 68                	jbe    80102b2f <main+0xff>
80102ac7:	90                   	nop
    if(c == mycpu())  // We've started already.
80102ac8:	e8 13 07 00 00       	call   801031e0 <mycpu>
80102acd:	39 d8                	cmp    %ebx,%eax
80102acf:	74 41                	je     80102b12 <main+0xe2>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102ad1:	e8 16 f7 ff ff       	call   801021ec <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
80102ad6:	05 00 10 00 00       	add    $0x1000,%eax
80102adb:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void**)(code-8) = mpenter;
80102ae0:	c7 05 f8 6f 00 80 14 	movl   $0x80102a14,0x80006ff8
80102ae7:	2a 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102aea:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80102af1:	90 10 00 

    lapicstartap(c->apicid, V2P(code));
80102af4:	c7 44 24 04 00 70 00 	movl   $0x7000,0x4(%esp)
80102afb:	00 
80102afc:	0f b6 03             	movzbl (%ebx),%eax
80102aff:	89 04 24             	mov    %eax,(%esp)
80102b02:	e8 95 f9 ff ff       	call   8010249c <lapicstartap>
80102b07:	90                   	nop

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102b08:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102b0e:	85 c0                	test   %eax,%eax
80102b10:	74 f6                	je     80102b08 <main+0xd8>
  for(c = cpus; c < cpus+ncpu; c++){
80102b12:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80102b18:	a1 00 2d 11 80       	mov    0x80112d00,%eax
80102b1d:	8d 14 80             	lea    (%eax,%eax,4),%edx
80102b20:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b23:	c1 e0 04             	shl    $0x4,%eax
80102b26:	05 80 27 11 80       	add    $0x80112780,%eax
80102b2b:	39 c3                	cmp    %eax,%ebx
80102b2d:	72 99                	jb     80102ac8 <main+0x98>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102b2f:	c7 44 24 04 00 00 00 	movl   $0x8e000000,0x4(%esp)
80102b36:	8e 
80102b37:	c7 04 24 00 00 40 80 	movl   $0x80400000,(%esp)
80102b3e:	e8 45 f6 ff ff       	call   80102188 <kinit2>
  userinit();      // first user process
80102b43:	e8 60 07 00 00       	call   801032a8 <userinit>
  mpmain();        // finish this processor's setup
80102b48:	e8 83 fe ff ff       	call   801029d0 <mpmain>
80102b4d:	66 90                	xchg   %ax,%ax
80102b4f:	90                   	nop

80102b50 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102b50:	55                   	push   %ebp
80102b51:	89 e5                	mov    %esp,%ebp
80102b53:	57                   	push   %edi
80102b54:	56                   	push   %esi
80102b55:	53                   	push   %ebx
80102b56:	83 ec 1c             	sub    $0x1c,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
80102b59:	8d b8 00 00 00 80    	lea    -0x80000000(%eax),%edi
  e = addr+len;
80102b5f:	8d 1c 17             	lea    (%edi,%edx,1),%ebx
  for(p = addr; p < e; p += sizeof(struct mp))
80102b62:	39 df                	cmp    %ebx,%edi
80102b64:	73 39                	jae    80102b9f <mpsearch1+0x4f>
80102b66:	66 90                	xchg   %ax,%ax
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102b68:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
80102b6f:	00 
80102b70:	c7 44 24 04 48 72 10 	movl   $0x80107248,0x4(%esp)
80102b77:	80 
80102b78:	89 3c 24             	mov    %edi,(%esp)
80102b7b:	e8 b0 19 00 00       	call   80104530 <memcmp>
80102b80:	85 c0                	test   %eax,%eax
80102b82:	75 14                	jne    80102b98 <mpsearch1+0x48>
80102b84:	31 c9                	xor    %ecx,%ecx
80102b86:	31 d2                	xor    %edx,%edx
    sum += addr[i];
80102b88:	0f b6 34 17          	movzbl (%edi,%edx,1),%esi
80102b8c:	01 f1                	add    %esi,%ecx
  for(i=0; i<len; i++)
80102b8e:	42                   	inc    %edx
80102b8f:	83 fa 10             	cmp    $0x10,%edx
80102b92:	75 f4                	jne    80102b88 <mpsearch1+0x38>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102b94:	84 c9                	test   %cl,%cl
80102b96:	74 09                	je     80102ba1 <mpsearch1+0x51>
  for(p = addr; p < e; p += sizeof(struct mp))
80102b98:	83 c7 10             	add    $0x10,%edi
80102b9b:	39 fb                	cmp    %edi,%ebx
80102b9d:	77 c9                	ja     80102b68 <mpsearch1+0x18>
      return (struct mp*)p;
  return 0;
80102b9f:	31 ff                	xor    %edi,%edi
}
80102ba1:	89 f8                	mov    %edi,%eax
80102ba3:	83 c4 1c             	add    $0x1c,%esp
80102ba6:	5b                   	pop    %ebx
80102ba7:	5e                   	pop    %esi
80102ba8:	5f                   	pop    %edi
80102ba9:	5d                   	pop    %ebp
80102baa:	c3                   	ret    
80102bab:	90                   	nop

80102bac <mpinit>:
  return conf;
}

void
mpinit(void)
{
80102bac:	55                   	push   %ebp
80102bad:	89 e5                	mov    %esp,%ebp
80102baf:	57                   	push   %edi
80102bb0:	56                   	push   %esi
80102bb1:	53                   	push   %ebx
80102bb2:	83 ec 2c             	sub    $0x2c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80102bb5:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80102bbc:	c1 e0 08             	shl    $0x8,%eax
80102bbf:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80102bc6:	09 d0                	or     %edx,%eax
80102bc8:	c1 e0 04             	shl    $0x4,%eax
80102bcb:	75 1b                	jne    80102be8 <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80102bcd:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80102bd4:	c1 e0 08             	shl    $0x8,%eax
80102bd7:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80102bde:	09 d0                	or     %edx,%eax
80102be0:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80102be3:	2d 00 04 00 00       	sub    $0x400,%eax
80102be8:	ba 00 04 00 00       	mov    $0x400,%edx
80102bed:	e8 5e ff ff ff       	call   80102b50 <mpsearch1>
80102bf2:	89 c7                	mov    %eax,%edi
80102bf4:	85 c0                	test   %eax,%eax
80102bf6:	0f 84 25 01 00 00    	je     80102d21 <mpinit+0x175>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80102bfc:	8b 5f 04             	mov    0x4(%edi),%ebx
80102bff:	85 db                	test   %ebx,%ebx
80102c01:	0f 84 35 01 00 00    	je     80102d3c <mpinit+0x190>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80102c07:	8d 93 00 00 00 80    	lea    -0x80000000(%ebx),%edx
80102c0d:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80102c10:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
80102c17:	00 
80102c18:	c7 44 24 04 4d 72 10 	movl   $0x8010724d,0x4(%esp)
80102c1f:	80 
80102c20:	89 14 24             	mov    %edx,(%esp)
80102c23:	e8 08 19 00 00       	call   80104530 <memcmp>
80102c28:	85 c0                	test   %eax,%eax
80102c2a:	0f 85 0c 01 00 00    	jne    80102d3c <mpinit+0x190>
  if(conf->version != 1 && conf->version != 4)
80102c30:	8a 83 06 00 00 80    	mov    -0x7ffffffa(%ebx),%al
80102c36:	3c 01                	cmp    $0x1,%al
80102c38:	74 08                	je     80102c42 <mpinit+0x96>
80102c3a:	3c 04                	cmp    $0x4,%al
80102c3c:	0f 85 fa 00 00 00    	jne    80102d3c <mpinit+0x190>
  if(sum((uchar*)conf, conf->length) != 0)
80102c42:	0f b7 83 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%eax
  for(i=0; i<len; i++)
80102c49:	85 c0                	test   %eax,%eax
80102c4b:	74 1e                	je     80102c6b <mpinit+0xbf>
80102c4d:	31 c9                	xor    %ecx,%ecx
80102c4f:	31 d2                	xor    %edx,%edx
80102c51:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80102c54:	0f b6 b4 13 00 00 00 	movzbl -0x80000000(%ebx,%edx,1),%esi
80102c5b:	80 
80102c5c:	01 f1                	add    %esi,%ecx
  for(i=0; i<len; i++)
80102c5e:	42                   	inc    %edx
80102c5f:	39 d0                	cmp    %edx,%eax
80102c61:	7f f1                	jg     80102c54 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
80102c63:	84 c9                	test   %cl,%cl
80102c65:	0f 85 d1 00 00 00    	jne    80102d3c <mpinit+0x190>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80102c6b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102c6e:	85 c0                	test   %eax,%eax
80102c70:	0f 84 c6 00 00 00    	je     80102d3c <mpinit+0x190>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80102c76:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80102c7c:	a3 7c 26 11 80       	mov    %eax,0x8011267c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80102c81:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
80102c87:	0f b7 8b 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%ecx
80102c8e:	03 4d e4             	add    -0x1c(%ebp),%ecx
  ismp = 1;
80102c91:	bb 01 00 00 00       	mov    $0x1,%ebx
80102c96:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80102c99:	8d 76 00             	lea    0x0(%esi),%esi
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80102c9c:	39 c1                	cmp    %eax,%ecx
80102c9e:	76 23                	jbe    80102cc3 <mpinit+0x117>
80102ca0:	0f b6 10             	movzbl (%eax),%edx
    switch(*p){
80102ca3:	80 fa 04             	cmp    $0x4,%dl
80102ca6:	76 0c                	jbe    80102cb4 <mpinit+0x108>
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      ismp = 0;
80102ca8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    switch(*p){
80102caf:	80 fa 04             	cmp    $0x4,%dl
80102cb2:	77 f4                	ja     80102ca8 <mpinit+0xfc>
80102cb4:	ff 24 95 8c 72 10 80 	jmp    *-0x7fef8d74(,%edx,4)
80102cbb:	90                   	nop
      p += 8;
80102cbc:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80102cbf:	39 c1                	cmp    %eax,%ecx
80102cc1:	77 dd                	ja     80102ca0 <mpinit+0xf4>
80102cc3:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
      break;
    }
  }
  if(!ismp)
80102cc6:	85 db                	test   %ebx,%ebx
80102cc8:	74 7e                	je     80102d48 <mpinit+0x19c>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
80102cca:	80 7f 0c 00          	cmpb   $0x0,0xc(%edi)
80102cce:	74 0f                	je     80102cdf <mpinit+0x133>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102cd0:	ba 22 00 00 00       	mov    $0x22,%edx
80102cd5:	b0 70                	mov    $0x70,%al
80102cd7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102cd8:	b2 23                	mov    $0x23,%dl
80102cda:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80102cdb:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102cde:	ee                   	out    %al,(%dx)
  }
}
80102cdf:	83 c4 2c             	add    $0x2c,%esp
80102ce2:	5b                   	pop    %ebx
80102ce3:	5e                   	pop    %esi
80102ce4:	5f                   	pop    %edi
80102ce5:	5d                   	pop    %ebp
80102ce6:	c3                   	ret    
80102ce7:	90                   	nop
      if(ncpu < NCPU) {
80102ce8:	8b 15 00 2d 11 80    	mov    0x80112d00,%edx
80102cee:	83 fa 07             	cmp    $0x7,%edx
80102cf1:	7f 18                	jg     80102d0b <mpinit+0x15f>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80102cf3:	8d 34 92             	lea    (%edx,%edx,4),%esi
80102cf6:	8d 14 72             	lea    (%edx,%esi,2),%edx
80102cf9:	c1 e2 04             	shl    $0x4,%edx
80102cfc:	8a 58 01             	mov    0x1(%eax),%bl
80102cff:	88 9a 80 27 11 80    	mov    %bl,-0x7feed880(%edx)
        ncpu++;
80102d05:	ff 05 00 2d 11 80    	incl   0x80112d00
      p += sizeof(struct mpproc);
80102d0b:	83 c0 14             	add    $0x14,%eax
      continue;
80102d0e:	eb 8c                	jmp    80102c9c <mpinit+0xf0>
      ioapicid = ioapic->apicno;
80102d10:	8a 50 01             	mov    0x1(%eax),%dl
80102d13:	88 15 60 27 11 80    	mov    %dl,0x80112760
      p += sizeof(struct mpioapic);
80102d19:	83 c0 08             	add    $0x8,%eax
      continue;
80102d1c:	e9 7b ff ff ff       	jmp    80102c9c <mpinit+0xf0>
  return mpsearch1(0xF0000, 0x10000);
80102d21:	ba 00 00 01 00       	mov    $0x10000,%edx
80102d26:	b8 00 00 0f 00       	mov    $0xf0000,%eax
80102d2b:	e8 20 fe ff ff       	call   80102b50 <mpsearch1>
80102d30:	89 c7                	mov    %eax,%edi
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80102d32:	85 c0                	test   %eax,%eax
80102d34:	0f 85 c2 fe ff ff    	jne    80102bfc <mpinit+0x50>
80102d3a:	66 90                	xchg   %ax,%ax
    panic("Expect to run on an SMP");
80102d3c:	c7 04 24 52 72 10 80 	movl   $0x80107252,(%esp)
80102d43:	e8 c8 d5 ff ff       	call   80100310 <panic>
    panic("Didn't find a suitable machine");
80102d48:	c7 04 24 6c 72 10 80 	movl   $0x8010726c,(%esp)
80102d4f:	e8 bc d5 ff ff       	call   80100310 <panic>

80102d54 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80102d54:	55                   	push   %ebp
80102d55:	89 e5                	mov    %esp,%ebp
80102d57:	ba 21 00 00 00       	mov    $0x21,%edx
80102d5c:	b0 ff                	mov    $0xff,%al
80102d5e:	ee                   	out    %al,(%dx)
80102d5f:	b2 a1                	mov    $0xa1,%dl
80102d61:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80102d62:	5d                   	pop    %ebp
80102d63:	c3                   	ret    

80102d64 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80102d64:	55                   	push   %ebp
80102d65:	89 e5                	mov    %esp,%ebp
80102d67:	56                   	push   %esi
80102d68:	53                   	push   %ebx
80102d69:	83 ec 20             	sub    $0x20,%esp
80102d6c:	8b 75 08             	mov    0x8(%ebp),%esi
80102d6f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
80102d72:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80102d78:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80102d7e:	e8 15 df ff ff       	call   80100c98 <filealloc>
80102d83:	89 06                	mov    %eax,(%esi)
80102d85:	85 c0                	test   %eax,%eax
80102d87:	0f 84 a1 00 00 00    	je     80102e2e <pipealloc+0xca>
80102d8d:	e8 06 df ff ff       	call   80100c98 <filealloc>
80102d92:	89 03                	mov    %eax,(%ebx)
80102d94:	85 c0                	test   %eax,%eax
80102d96:	0f 84 84 00 00 00    	je     80102e20 <pipealloc+0xbc>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80102d9c:	e8 4b f4 ff ff       	call   801021ec <kalloc>
80102da1:	85 c0                	test   %eax,%eax
80102da3:	74 7b                	je     80102e20 <pipealloc+0xbc>
    goto bad;
  p->readopen = 1;
80102da5:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80102dac:	00 00 00 
  p->writeopen = 1;
80102daf:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80102db6:	00 00 00 
  p->nwrite = 0;
80102db9:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80102dc0:	00 00 00 
  p->nread = 0;
80102dc3:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80102dca:	00 00 00 
  initlock(&p->lock, "pipe");
80102dcd:	c7 44 24 04 a0 72 10 	movl   $0x801072a0,0x4(%esp)
80102dd4:	80 
80102dd5:	89 04 24             	mov    %eax,(%esp)
80102dd8:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102ddb:	e8 38 15 00 00       	call   80104318 <initlock>
  (*f0)->type = FD_PIPE;
80102de0:	8b 16                	mov    (%esi),%edx
80102de2:	c7 02 01 00 00 00    	movl   $0x1,(%edx)
  (*f0)->readable = 1;
80102de8:	8b 16                	mov    (%esi),%edx
80102dea:	c6 42 08 01          	movb   $0x1,0x8(%edx)
  (*f0)->writable = 0;
80102dee:	8b 16                	mov    (%esi),%edx
80102df0:	c6 42 09 00          	movb   $0x0,0x9(%edx)
  (*f0)->pipe = p;
80102df4:	8b 16                	mov    (%esi),%edx
80102df6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102df9:	89 42 0c             	mov    %eax,0xc(%edx)
  (*f1)->type = FD_PIPE;
80102dfc:	8b 13                	mov    (%ebx),%edx
80102dfe:	c7 02 01 00 00 00    	movl   $0x1,(%edx)
  (*f1)->readable = 0;
80102e04:	8b 13                	mov    (%ebx),%edx
80102e06:	c6 42 08 00          	movb   $0x0,0x8(%edx)
  (*f1)->writable = 1;
80102e0a:	8b 13                	mov    (%ebx),%edx
80102e0c:	c6 42 09 01          	movb   $0x1,0x9(%edx)
  (*f1)->pipe = p;
80102e10:	8b 13                	mov    (%ebx),%edx
80102e12:	89 42 0c             	mov    %eax,0xc(%edx)
  return 0;
80102e15:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80102e17:	83 c4 20             	add    $0x20,%esp
80102e1a:	5b                   	pop    %ebx
80102e1b:	5e                   	pop    %esi
80102e1c:	5d                   	pop    %ebp
80102e1d:	c3                   	ret    
80102e1e:	66 90                	xchg   %ax,%ax
  if(*f0)
80102e20:	8b 06                	mov    (%esi),%eax
80102e22:	85 c0                	test   %eax,%eax
80102e24:	74 08                	je     80102e2e <pipealloc+0xca>
    fileclose(*f0);
80102e26:	89 04 24             	mov    %eax,(%esp)
80102e29:	e8 12 df ff ff       	call   80100d40 <fileclose>
  if(*f1)
80102e2e:	8b 03                	mov    (%ebx),%eax
80102e30:	85 c0                	test   %eax,%eax
80102e32:	74 14                	je     80102e48 <pipealloc+0xe4>
    fileclose(*f1);
80102e34:	89 04 24             	mov    %eax,(%esp)
80102e37:	e8 04 df ff ff       	call   80100d40 <fileclose>
  return -1;
80102e3c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102e41:	83 c4 20             	add    $0x20,%esp
80102e44:	5b                   	pop    %ebx
80102e45:	5e                   	pop    %esi
80102e46:	5d                   	pop    %ebp
80102e47:	c3                   	ret    
  return -1;
80102e48:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102e4d:	83 c4 20             	add    $0x20,%esp
80102e50:	5b                   	pop    %ebx
80102e51:	5e                   	pop    %esi
80102e52:	5d                   	pop    %ebp
80102e53:	c3                   	ret    

80102e54 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80102e54:	55                   	push   %ebp
80102e55:	89 e5                	mov    %esp,%ebp
80102e57:	56                   	push   %esi
80102e58:	53                   	push   %ebx
80102e59:	83 ec 10             	sub    $0x10,%esp
80102e5c:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102e5f:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
80102e62:	89 1c 24             	mov    %ebx,(%esp)
80102e65:	e8 76 15 00 00       	call   801043e0 <acquire>
  if(writable){
80102e6a:	85 f6                	test   %esi,%esi
80102e6c:	74 3a                	je     80102ea8 <pipeclose+0x54>
    p->writeopen = 0;
80102e6e:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
80102e75:	00 00 00 
    wakeup(&p->nread);
80102e78:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80102e7e:	89 04 24             	mov    %eax,(%esp)
80102e81:	e8 c2 0e 00 00       	call   80103d48 <wakeup>
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80102e86:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
80102e8c:	85 d2                	test   %edx,%edx
80102e8e:	75 0a                	jne    80102e9a <pipeclose+0x46>
80102e90:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80102e96:	85 c0                	test   %eax,%eax
80102e98:	74 2a                	je     80102ec4 <pipeclose+0x70>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80102e9a:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80102e9d:	83 c4 10             	add    $0x10,%esp
80102ea0:	5b                   	pop    %ebx
80102ea1:	5e                   	pop    %esi
80102ea2:	5d                   	pop    %ebp
    release(&p->lock);
80102ea3:	e9 f4 15 00 00       	jmp    8010449c <release>
    p->readopen = 0;
80102ea8:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80102eaf:	00 00 00 
    wakeup(&p->nwrite);
80102eb2:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80102eb8:	89 04 24             	mov    %eax,(%esp)
80102ebb:	e8 88 0e 00 00       	call   80103d48 <wakeup>
80102ec0:	eb c4                	jmp    80102e86 <pipeclose+0x32>
80102ec2:	66 90                	xchg   %ax,%ax
    release(&p->lock);
80102ec4:	89 1c 24             	mov    %ebx,(%esp)
80102ec7:	e8 d0 15 00 00       	call   8010449c <release>
    kfree((char*)p);
80102ecc:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80102ecf:	83 c4 10             	add    $0x10,%esp
80102ed2:	5b                   	pop    %ebx
80102ed3:	5e                   	pop    %esi
80102ed4:	5d                   	pop    %ebp
    kfree((char*)p);
80102ed5:	e9 d6 f1 ff ff       	jmp    801020b0 <kfree>
80102eda:	66 90                	xchg   %ax,%ax

80102edc <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80102edc:	55                   	push   %ebp
80102edd:	89 e5                	mov    %esp,%ebp
80102edf:	57                   	push   %edi
80102ee0:	56                   	push   %esi
80102ee1:	53                   	push   %ebx
80102ee2:	83 ec 2c             	sub    $0x2c,%esp
80102ee5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
80102ee8:	89 1c 24             	mov    %ebx,(%esp)
80102eeb:	e8 f0 14 00 00       	call   801043e0 <acquire>
  for(i = 0; i < n; i++){
80102ef0:	8b 45 10             	mov    0x10(%ebp),%eax
80102ef3:	85 c0                	test   %eax,%eax
80102ef5:	0f 8e 84 00 00 00    	jle    80102f7f <pipewrite+0xa3>
80102efb:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
80102f01:	8b 55 0c             	mov    0xc(%ebp),%edx
80102f04:	89 55 e4             	mov    %edx,-0x1c(%ebp)
pipewrite(struct pipe *p, char *addr, int n)
80102f07:	03 55 10             	add    0x10(%ebp),%edx
80102f0a:	89 55 e0             	mov    %edx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80102f0d:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80102f13:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80102f19:	eb 31                	jmp    80102f4c <pipewrite+0x70>
80102f1b:	90                   	nop
      if(p->readopen == 0 || myproc()->killed){
80102f1c:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80102f22:	85 c0                	test   %eax,%eax
80102f24:	74 72                	je     80102f98 <pipewrite+0xbc>
80102f26:	e8 5d 03 00 00       	call   80103288 <myproc>
80102f2b:	8b 48 24             	mov    0x24(%eax),%ecx
80102f2e:	85 c9                	test   %ecx,%ecx
80102f30:	75 66                	jne    80102f98 <pipewrite+0xbc>
      wakeup(&p->nread);
80102f32:	89 3c 24             	mov    %edi,(%esp)
80102f35:	e8 0e 0e 00 00       	call   80103d48 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80102f3a:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80102f3e:	89 34 24             	mov    %esi,(%esp)
80102f41:	e8 36 0c 00 00       	call   80103b7c <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80102f46:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
80102f4c:	8b 93 34 02 00 00    	mov    0x234(%ebx),%edx
80102f52:	81 c2 00 02 00 00    	add    $0x200,%edx
80102f58:	39 d0                	cmp    %edx,%eax
80102f5a:	74 c0                	je     80102f1c <pipewrite+0x40>
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80102f5c:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80102f5f:	8a 09                	mov    (%ecx),%cl
80102f61:	89 c2                	mov    %eax,%edx
80102f63:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80102f69:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
80102f6d:	40                   	inc    %eax
80102f6e:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80102f74:	ff 45 e4             	incl   -0x1c(%ebp)
  for(i = 0; i < n; i++){
80102f77:	8b 55 e0             	mov    -0x20(%ebp),%edx
80102f7a:	39 55 e4             	cmp    %edx,-0x1c(%ebp)
80102f7d:	75 cd                	jne    80102f4c <pipewrite+0x70>
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80102f7f:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80102f85:	89 04 24             	mov    %eax,(%esp)
80102f88:	e8 bb 0d 00 00       	call   80103d48 <wakeup>
  release(&p->lock);
80102f8d:	89 1c 24             	mov    %ebx,(%esp)
80102f90:	e8 07 15 00 00       	call   8010449c <release>
  return n;
80102f95:	eb 10                	jmp    80102fa7 <pipewrite+0xcb>
80102f97:	90                   	nop
        release(&p->lock);
80102f98:	89 1c 24             	mov    %ebx,(%esp)
80102f9b:	e8 fc 14 00 00       	call   8010449c <release>
        return -1;
80102fa0:	c7 45 10 ff ff ff ff 	movl   $0xffffffff,0x10(%ebp)
}
80102fa7:	8b 45 10             	mov    0x10(%ebp),%eax
80102faa:	83 c4 2c             	add    $0x2c,%esp
80102fad:	5b                   	pop    %ebx
80102fae:	5e                   	pop    %esi
80102faf:	5f                   	pop    %edi
80102fb0:	5d                   	pop    %ebp
80102fb1:	c3                   	ret    
80102fb2:	66 90                	xchg   %ax,%ax

80102fb4 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80102fb4:	55                   	push   %ebp
80102fb5:	89 e5                	mov    %esp,%ebp
80102fb7:	57                   	push   %edi
80102fb8:	56                   	push   %esi
80102fb9:	53                   	push   %ebx
80102fba:	83 ec 2c             	sub    $0x2c,%esp
80102fbd:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
80102fc0:	89 1c 24             	mov    %ebx,(%esp)
80102fc3:	e8 18 14 00 00       	call   801043e0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80102fc8:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
80102fce:	3b 8b 38 02 00 00    	cmp    0x238(%ebx),%ecx
80102fd4:	75 5a                	jne    80103030 <piperead+0x7c>
80102fd6:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80102fdc:	85 c0                	test   %eax,%eax
80102fde:	74 50                	je     80103030 <piperead+0x7c>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80102fe0:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
80102fe6:	eb 24                	jmp    8010300c <piperead+0x58>
80102fe8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80102fec:	89 34 24             	mov    %esi,(%esp)
80102fef:	e8 88 0b 00 00       	call   80103b7c <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80102ff4:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
80102ffa:	3b 8b 38 02 00 00    	cmp    0x238(%ebx),%ecx
80103000:	75 2e                	jne    80103030 <piperead+0x7c>
80103002:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103008:	85 c0                	test   %eax,%eax
8010300a:	74 24                	je     80103030 <piperead+0x7c>
    if(myproc()->killed){
8010300c:	e8 77 02 00 00       	call   80103288 <myproc>
80103011:	8b 40 24             	mov    0x24(%eax),%eax
80103014:	85 c0                	test   %eax,%eax
80103016:	74 d0                	je     80102fe8 <piperead+0x34>
      release(&p->lock);
80103018:	89 1c 24             	mov    %ebx,(%esp)
8010301b:	e8 7c 14 00 00       	call   8010449c <release>
      return -1;
80103020:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103025:	83 c4 2c             	add    $0x2c,%esp
80103028:	5b                   	pop    %ebx
80103029:	5e                   	pop    %esi
8010302a:	5f                   	pop    %edi
8010302b:	5d                   	pop    %ebp
8010302c:	c3                   	ret    
8010302d:	8d 76 00             	lea    0x0(%esi),%esi
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103030:	8b 45 10             	mov    0x10(%ebp),%eax
80103033:	85 c0                	test   %eax,%eax
80103035:	7e 62                	jle    80103099 <piperead+0xe5>
    if(p->nread == p->nwrite)
80103037:	3b 8b 38 02 00 00    	cmp    0x238(%ebx),%ecx
8010303d:	74 5a                	je     80103099 <piperead+0xe5>
piperead(struct pipe *p, char *addr, int n)
8010303f:	8b 7d 10             	mov    0x10(%ebp),%edi
80103042:	01 cf                	add    %ecx,%edi
80103044:	89 ca                	mov    %ecx,%edx
80103046:	8b 75 0c             	mov    0xc(%ebp),%esi
80103049:	29 ce                	sub    %ecx,%esi
8010304b:	eb 0b                	jmp    80103058 <piperead+0xa4>
8010304d:	8d 76 00             	lea    0x0(%esi),%esi
    if(p->nread == p->nwrite)
80103050:	39 93 38 02 00 00    	cmp    %edx,0x238(%ebx)
80103056:	74 1d                	je     80103075 <piperead+0xc1>
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103058:	89 d0                	mov    %edx,%eax
8010305a:	25 ff 01 00 00       	and    $0x1ff,%eax
8010305f:	8a 44 03 34          	mov    0x34(%ebx,%eax,1),%al
80103063:	88 04 16             	mov    %al,(%esi,%edx,1)
80103066:	42                   	inc    %edx
80103067:	89 93 34 02 00 00    	mov    %edx,0x234(%ebx)
piperead(struct pipe *p, char *addr, int n)
8010306d:	89 d0                	mov    %edx,%eax
8010306f:	29 c8                	sub    %ecx,%eax
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103071:	39 fa                	cmp    %edi,%edx
80103073:	75 db                	jne    80103050 <piperead+0x9c>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103075:	8d 93 38 02 00 00    	lea    0x238(%ebx),%edx
8010307b:	89 14 24             	mov    %edx,(%esp)
8010307e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103081:	e8 c2 0c 00 00       	call   80103d48 <wakeup>
  release(&p->lock);
80103086:	89 1c 24             	mov    %ebx,(%esp)
80103089:	e8 0e 14 00 00       	call   8010449c <release>
8010308e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80103091:	83 c4 2c             	add    $0x2c,%esp
80103094:	5b                   	pop    %ebx
80103095:	5e                   	pop    %esi
80103096:	5f                   	pop    %edi
80103097:	5d                   	pop    %ebp
80103098:	c3                   	ret    
    if(p->nread == p->nwrite)
80103099:	31 c0                	xor    %eax,%eax
8010309b:	eb d8                	jmp    80103075 <piperead+0xc1>
8010309d:	66 90                	xchg   %ax,%ax
8010309f:	90                   	nop

801030a0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801030a0:	55                   	push   %ebp
801030a1:	89 e5                	mov    %esp,%ebp
801030a3:	53                   	push   %ebx
801030a4:	83 ec 14             	sub    $0x14,%esp
  procnum++;  //a new prcess. Increase the process number.
801030a7:	ff 05 a0 a5 10 80    	incl   0x8010a5a0
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
801030ad:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801030b4:	e8 27 13 00 00       	call   801043e0 <acquire>

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801030b9:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
801030be:	eb 12                	jmp    801030d2 <allocproc+0x32>
801030c0:	81 c3 98 00 00 00    	add    $0x98,%ebx
801030c6:	81 fb 54 53 11 80    	cmp    $0x80115354,%ebx
801030cc:	0f 84 8a 00 00 00    	je     8010315c <allocproc+0xbc>
    if(p->state == UNUSED)
801030d2:	8b 43 0c             	mov    0xc(%ebx),%eax
801030d5:	85 c0                	test   %eax,%eax
801030d7:	75 e7                	jne    801030c0 <allocproc+0x20>

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
801030d9:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
801030e0:	a1 04 a0 10 80       	mov    0x8010a004,%eax
801030e5:	89 43 10             	mov    %eax,0x10(%ebx)
801030e8:	40                   	inc    %eax
801030e9:	a3 04 a0 10 80       	mov    %eax,0x8010a004

  release(&ptable.lock);
801030ee:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801030f5:	e8 a2 13 00 00       	call   8010449c <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801030fa:	e8 ed f0 ff ff       	call   801021ec <kalloc>
801030ff:	89 43 08             	mov    %eax,0x8(%ebx)
80103102:	85 c0                	test   %eax,%eax
80103104:	74 6c                	je     80103172 <allocproc+0xd2>
  }
    //cprintf("after kalloc\n");
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103106:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
8010310c:	89 53 18             	mov    %edx,0x18(%ebx)
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
8010310f:	c7 80 b0 0f 00 00 ef 	movl   $0x801055ef,0xfb0(%eax)
80103116:	55 10 80 

  sp -= sizeof *p->context;
80103119:	05 9c 0f 00 00       	add    $0xf9c,%eax
  p->context = (struct context*)sp;
8010311e:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103121:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
80103128:	00 
80103129:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80103130:	00 
80103131:	89 04 24             	mov    %eax,(%esp)
80103134:	e8 ab 13 00 00       	call   801044e4 <memset>
  p->context->eip = (uint)forkret;
80103139:	8b 43 1c             	mov    0x1c(%ebx),%eax
8010313c:	c7 40 10 80 31 10 80 	movl   $0x80103180,0x10(%eax)

    p->reference_count = (int*)kalloc();
80103143:	e8 a4 f0 ff ff       	call   801021ec <kalloc>
80103148:	89 83 94 00 00 00    	mov    %eax,0x94(%ebx)
    *(p->reference_count) = 1;
8010314e:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  return p;
}
80103154:	89 d8                	mov    %ebx,%eax
80103156:	83 c4 14             	add    $0x14,%esp
80103159:	5b                   	pop    %ebx
8010315a:	5d                   	pop    %ebp
8010315b:	c3                   	ret    
  release(&ptable.lock);
8010315c:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103163:	e8 34 13 00 00       	call   8010449c <release>
  return 0;
80103168:	31 db                	xor    %ebx,%ebx
}
8010316a:	89 d8                	mov    %ebx,%eax
8010316c:	83 c4 14             	add    $0x14,%esp
8010316f:	5b                   	pop    %ebx
80103170:	5d                   	pop    %ebp
80103171:	c3                   	ret    
    p->state = UNUSED;
80103172:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103179:	31 db                	xor    %ebx,%ebx
8010317b:	eb d7                	jmp    80103154 <allocproc+0xb4>
8010317d:	8d 76 00             	lea    0x0(%esi),%esi

80103180 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103180:	55                   	push   %ebp
80103181:	89 e5                	mov    %esp,%ebp
80103183:	83 ec 18             	sub    $0x18,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103186:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
8010318d:	e8 0a 13 00 00       	call   8010449c <release>

  if (first) {
80103192:	8b 15 08 a0 10 80    	mov    0x8010a008,%edx
80103198:	85 d2                	test   %edx,%edx
8010319a:	75 04                	jne    801031a0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010319c:	c9                   	leave  
8010319d:	c3                   	ret    
8010319e:	66 90                	xchg   %ax,%ax
    first = 0;
801031a0:	c7 05 08 a0 10 80 00 	movl   $0x0,0x8010a008
801031a7:	00 00 00 
    iinit(ROOTDEV);
801031aa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801031b1:	e8 76 e1 ff ff       	call   8010132c <iinit>
    initlog(ROOTDEV);
801031b6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801031bd:	e8 3e f5 ff ff       	call   80102700 <initlog>
}
801031c2:	c9                   	leave  
801031c3:	c3                   	ret    

801031c4 <pinit>:
{
801031c4:	55                   	push   %ebp
801031c5:	89 e5                	mov    %esp,%ebp
801031c7:	83 ec 18             	sub    $0x18,%esp
  initlock(&ptable.lock, "ptable");
801031ca:	c7 44 24 04 a5 72 10 	movl   $0x801072a5,0x4(%esp)
801031d1:	80 
801031d2:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801031d9:	e8 3a 11 00 00       	call   80104318 <initlock>
}
801031de:	c9                   	leave  
801031df:	c3                   	ret    

801031e0 <mycpu>:
{
801031e0:	55                   	push   %ebp
801031e1:	89 e5                	mov    %esp,%ebp
801031e3:	56                   	push   %esi
801031e4:	53                   	push   %ebx
801031e5:	83 ec 10             	sub    $0x10,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801031e8:	9c                   	pushf  
801031e9:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801031ea:	f6 c4 02             	test   $0x2,%ah
801031ed:	75 58                	jne    80103247 <mycpu+0x67>
  apicid = lapicid();
801031ef:	e8 6c f2 ff ff       	call   80102460 <lapicid>
  for (i = 0; i < ncpu; ++i) {
801031f4:	8b 35 00 2d 11 80    	mov    0x80112d00,%esi
801031fa:	85 f6                	test   %esi,%esi
801031fc:	7e 3d                	jle    8010323b <mycpu+0x5b>
    if (cpus[i].apicid == apicid)
801031fe:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
80103205:	39 c2                	cmp    %eax,%edx
80103207:	74 2e                	je     80103237 <mycpu+0x57>
80103209:	b9 30 28 11 80       	mov    $0x80112830,%ecx
  for (i = 0; i < ncpu; ++i) {
8010320e:	31 d2                	xor    %edx,%edx
80103210:	42                   	inc    %edx
80103211:	39 f2                	cmp    %esi,%edx
80103213:	74 26                	je     8010323b <mycpu+0x5b>
    if (cpus[i].apicid == apicid)
80103215:	0f b6 19             	movzbl (%ecx),%ebx
80103218:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
8010321e:	39 c3                	cmp    %eax,%ebx
80103220:	75 ee                	jne    80103210 <mycpu+0x30>
      return &cpus[i];
80103222:	8d 04 92             	lea    (%edx,%edx,4),%eax
80103225:	8d 04 42             	lea    (%edx,%eax,2),%eax
80103228:	c1 e0 04             	shl    $0x4,%eax
8010322b:	05 80 27 11 80       	add    $0x80112780,%eax
}
80103230:	83 c4 10             	add    $0x10,%esp
80103233:	5b                   	pop    %ebx
80103234:	5e                   	pop    %esi
80103235:	5d                   	pop    %ebp
80103236:	c3                   	ret    
  for (i = 0; i < ncpu; ++i) {
80103237:	31 d2                	xor    %edx,%edx
80103239:	eb e7                	jmp    80103222 <mycpu+0x42>
  panic("unknown apicid\n");
8010323b:	c7 04 24 ac 72 10 80 	movl   $0x801072ac,(%esp)
80103242:	e8 c9 d0 ff ff       	call   80100310 <panic>
    panic("mycpu called with interrupts enabled\n");
80103247:	c7 04 24 bc 73 10 80 	movl   $0x801073bc,(%esp)
8010324e:	e8 bd d0 ff ff       	call   80100310 <panic>
80103253:	90                   	nop

80103254 <cpuid>:
cpuid() {
80103254:	55                   	push   %ebp
80103255:	89 e5                	mov    %esp,%ebp
80103257:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
8010325a:	e8 81 ff ff ff       	call   801031e0 <mycpu>
8010325f:	2d 80 27 11 80       	sub    $0x80112780,%eax
80103264:	c1 f8 04             	sar    $0x4,%eax
80103267:	8d 0c c0             	lea    (%eax,%eax,8),%ecx
8010326a:	89 ca                	mov    %ecx,%edx
8010326c:	c1 e2 05             	shl    $0x5,%edx
8010326f:	29 ca                	sub    %ecx,%edx
80103271:	8d 14 90             	lea    (%eax,%edx,4),%edx
80103274:	8d 0c d0             	lea    (%eax,%edx,8),%ecx
80103277:	89 ca                	mov    %ecx,%edx
80103279:	c1 e2 0f             	shl    $0xf,%edx
8010327c:	29 ca                	sub    %ecx,%edx
8010327e:	8d 04 90             	lea    (%eax,%edx,4),%eax
80103281:	f7 d8                	neg    %eax
}
80103283:	c9                   	leave  
80103284:	c3                   	ret    
80103285:	8d 76 00             	lea    0x0(%esi),%esi

80103288 <myproc>:
myproc(void) {
80103288:	55                   	push   %ebp
80103289:	89 e5                	mov    %esp,%ebp
8010328b:	53                   	push   %ebx
8010328c:	51                   	push   %ecx
  pushcli();
8010328d:	e8 16 11 00 00       	call   801043a8 <pushcli>
  c = mycpu();
80103292:	e8 49 ff ff ff       	call   801031e0 <mycpu>
  p = c->proc;
80103297:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010329d:	e8 a2 11 00 00       	call   80104444 <popcli>
}
801032a2:	89 d8                	mov    %ebx,%eax
801032a4:	5b                   	pop    %ebx
801032a5:	5b                   	pop    %ebx
801032a6:	5d                   	pop    %ebp
801032a7:	c3                   	ret    

801032a8 <userinit>:
{
801032a8:	55                   	push   %ebp
801032a9:	89 e5                	mov    %esp,%ebp
801032ab:	53                   	push   %ebx
801032ac:	83 ec 14             	sub    $0x14,%esp
  p = allocproc();
801032af:	e8 ec fd ff ff       	call   801030a0 <allocproc>
801032b4:	89 c3                	mov    %eax,%ebx
  initproc = p;
801032b6:	a3 a4 a5 10 80       	mov    %eax,0x8010a5a4
  if((p->pgdir = setupkvm()) == 0)
801032bb:	e8 2c 38 00 00       	call   80106aec <setupkvm>
801032c0:	89 43 04             	mov    %eax,0x4(%ebx)
801032c3:	85 c0                	test   %eax,%eax
801032c5:	0f 84 fb 00 00 00    	je     801033c6 <userinit+0x11e>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801032cb:	c7 44 24 08 2c 00 00 	movl   $0x2c,0x8(%esp)
801032d2:	00 
801032d3:	c7 44 24 04 60 a4 10 	movl   $0x8010a460,0x4(%esp)
801032da:	80 
801032db:	89 04 24             	mov    %eax,(%esp)
801032de:	e8 81 34 00 00       	call   80106764 <inituvm>
  p->sz = PGSIZE;
801032e3:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801032e9:	c7 44 24 08 4c 00 00 	movl   $0x4c,0x8(%esp)
801032f0:	00 
801032f1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801032f8:	00 
801032f9:	8b 43 18             	mov    0x18(%ebx),%eax
801032fc:	89 04 24             	mov    %eax,(%esp)
801032ff:	e8 e0 11 00 00       	call   801044e4 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103304:	8b 43 18             	mov    0x18(%ebx),%eax
80103307:	66 c7 40 3c 1b 00    	movw   $0x1b,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010330d:	8b 43 18             	mov    0x18(%ebx),%eax
80103310:	66 c7 40 2c 23 00    	movw   $0x23,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103316:	8b 43 18             	mov    0x18(%ebx),%eax
80103319:	8b 50 2c             	mov    0x2c(%eax),%edx
8010331c:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103320:	8b 43 18             	mov    0x18(%ebx),%eax
80103323:	8b 50 2c             	mov    0x2c(%eax),%edx
80103326:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010332a:	8b 43 18             	mov    0x18(%ebx),%eax
8010332d:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103334:	8b 43 18             	mov    0x18(%ebx),%eax
80103337:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
8010333e:	8b 43 18             	mov    0x18(%ebx),%eax
80103341:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  p->tickets = 0;   //initiate ticket number
80103348:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
8010334f:	00 00 00 
  p->schetimes = 0; //initiate the time of this process be scheduled
80103352:	c7 83 84 00 00 00 00 	movl   $0x0,0x84(%ebx)
80103359:	00 00 00 
  p->pass = 0;    //initiate pass number(using to add the stride)
8010335c:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80103363:	00 00 00 
  p->stride = 0;   //initiate stride number
80103366:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
8010336d:	00 00 00 
  p->syscallnum = 0;  //initiate system call number
80103370:	c7 43 7c 00 00 00 00 	movl   $0x0,0x7c(%ebx)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103377:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
8010337e:	00 
8010337f:	c7 44 24 04 d5 72 10 	movl   $0x801072d5,0x4(%esp)
80103386:	80 
80103387:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010338a:	89 04 24             	mov    %eax,(%esp)
8010338d:	e8 ea 12 00 00       	call   8010467c <safestrcpy>
  p->cwd = namei("/");
80103392:	c7 04 24 de 72 10 80 	movl   $0x801072de,(%esp)
80103399:	e8 8a e9 ff ff       	call   80101d28 <namei>
8010339e:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
801033a1:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801033a8:	e8 33 10 00 00       	call   801043e0 <acquire>
  p->state = RUNNABLE;
801033ad:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
801033b4:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801033bb:	e8 dc 10 00 00       	call   8010449c <release>
}
801033c0:	83 c4 14             	add    $0x14,%esp
801033c3:	5b                   	pop    %ebx
801033c4:	5d                   	pop    %ebp
801033c5:	c3                   	ret    
    panic("userinit: out of memory?");
801033c6:	c7 04 24 bc 72 10 80 	movl   $0x801072bc,(%esp)
801033cd:	e8 3e cf ff ff       	call   80100310 <panic>
801033d2:	66 90                	xchg   %ax,%ax

801033d4 <growproc>:
{
801033d4:	55                   	push   %ebp
801033d5:	89 e5                	mov    %esp,%ebp
801033d7:	53                   	push   %ebx
801033d8:	83 ec 14             	sub    $0x14,%esp
  struct proc *curproc = myproc();
801033db:	e8 a8 fe ff ff       	call   80103288 <myproc>
801033e0:	89 c3                	mov    %eax,%ebx
  sz = curproc->sz;
801033e2:	8b 00                	mov    (%eax),%eax
  if(n > 0){
801033e4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801033e8:	7e 2e                	jle    80103418 <growproc+0x44>
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
801033ea:	8b 55 08             	mov    0x8(%ebp),%edx
801033ed:	01 c2                	add    %eax,%edx
801033ef:	89 54 24 08          	mov    %edx,0x8(%esp)
801033f3:	89 44 24 04          	mov    %eax,0x4(%esp)
801033f7:	8b 43 04             	mov    0x4(%ebx),%eax
801033fa:	89 04 24             	mov    %eax,(%esp)
801033fd:	e8 46 35 00 00       	call   80106948 <allocuvm>
80103402:	85 c0                	test   %eax,%eax
80103404:	74 32                	je     80103438 <growproc+0x64>
  curproc->sz = sz;
80103406:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103408:	89 1c 24             	mov    %ebx,(%esp)
8010340b:	e8 58 32 00 00       	call   80106668 <switchuvm>
  return 0;
80103410:	31 c0                	xor    %eax,%eax
}
80103412:	83 c4 14             	add    $0x14,%esp
80103415:	5b                   	pop    %ebx
80103416:	5d                   	pop    %ebp
80103417:	c3                   	ret    
  } else if(n < 0){
80103418:	74 ec                	je     80103406 <growproc+0x32>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
8010341a:	8b 55 08             	mov    0x8(%ebp),%edx
8010341d:	01 c2                	add    %eax,%edx
8010341f:	89 54 24 08          	mov    %edx,0x8(%esp)
80103423:	89 44 24 04          	mov    %eax,0x4(%esp)
80103427:	8b 43 04             	mov    0x4(%ebx),%eax
8010342a:	89 04 24             	mov    %eax,(%esp)
8010342d:	e8 6e 34 00 00       	call   801068a0 <deallocuvm>
80103432:	85 c0                	test   %eax,%eax
80103434:	75 d0                	jne    80103406 <growproc+0x32>
80103436:	66 90                	xchg   %ax,%ax
      return -1;
80103438:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010343d:	eb d3                	jmp    80103412 <growproc+0x3e>
8010343f:	90                   	nop

80103440 <fork>:
{
80103440:	55                   	push   %ebp
80103441:	89 e5                	mov    %esp,%ebp
80103443:	57                   	push   %edi
80103444:	56                   	push   %esi
80103445:	53                   	push   %ebx
80103446:	83 ec 2c             	sub    $0x2c,%esp
  struct proc *curproc = myproc();
80103449:	e8 3a fe ff ff       	call   80103288 <myproc>
8010344e:	89 c3                	mov    %eax,%ebx
  if((np = allocproc()) == 0){
80103450:	e8 4b fc ff ff       	call   801030a0 <allocproc>
80103455:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103458:	85 c0                	test   %eax,%eax
8010345a:	0f 84 c4 00 00 00    	je     80103524 <fork+0xe4>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103460:	8b 03                	mov    (%ebx),%eax
80103462:	89 44 24 04          	mov    %eax,0x4(%esp)
80103466:	8b 43 04             	mov    0x4(%ebx),%eax
80103469:	89 04 24             	mov    %eax,(%esp)
8010346c:	e8 37 37 00 00       	call   80106ba8 <copyuvm>
80103471:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103474:	89 42 04             	mov    %eax,0x4(%edx)
80103477:	85 c0                	test   %eax,%eax
80103479:	0f 84 ac 00 00 00    	je     8010352b <fork+0xeb>
  np->sz = curproc->sz;
8010347f:	8b 03                	mov    (%ebx),%eax
80103481:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103484:	89 02                	mov    %eax,(%edx)
  np->parent = curproc;
80103486:	89 5a 14             	mov    %ebx,0x14(%edx)
  *np->tf = *curproc->tf;
80103489:	8b 42 18             	mov    0x18(%edx),%eax
8010348c:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010348f:	8b 73 18             	mov    0x18(%ebx),%esi
80103492:	b9 13 00 00 00       	mov    $0x13,%ecx
80103497:	89 c7                	mov    %eax,%edi
80103499:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  np->tf->eax = 0;
8010349b:	8b 42 18             	mov    0x18(%edx),%eax
8010349e:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for(i = 0; i < NOFILE; i++)
801034a5:	31 f6                	xor    %esi,%esi
801034a7:	90                   	nop
    if(curproc->ofile[i])
801034a8:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
801034ac:	85 c0                	test   %eax,%eax
801034ae:	74 0f                	je     801034bf <fork+0x7f>
      np->ofile[i] = filedup(curproc->ofile[i]);
801034b0:	89 04 24             	mov    %eax,(%esp)
801034b3:	e8 44 d8 ff ff       	call   80100cfc <filedup>
801034b8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801034bb:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
801034bf:	46                   	inc    %esi
801034c0:	83 fe 10             	cmp    $0x10,%esi
801034c3:	75 e3                	jne    801034a8 <fork+0x68>
  np->cwd = idup(curproc->cwd);
801034c5:	8b 43 68             	mov    0x68(%ebx),%eax
801034c8:	89 04 24             	mov    %eax,(%esp)
801034cb:	e8 50 e0 ff ff       	call   80101520 <idup>
801034d0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801034d3:	89 42 68             	mov    %eax,0x68(%edx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801034d6:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
801034dd:	00 
801034de:	83 c3 6c             	add    $0x6c,%ebx
801034e1:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801034e5:	89 d0                	mov    %edx,%eax
801034e7:	83 c0 6c             	add    $0x6c,%eax
801034ea:	89 04 24             	mov    %eax,(%esp)
801034ed:	e8 8a 11 00 00       	call   8010467c <safestrcpy>
  pid = np->pid;
801034f2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801034f5:	8b 58 10             	mov    0x10(%eax),%ebx
  acquire(&ptable.lock);
801034f8:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801034ff:	e8 dc 0e 00 00       	call   801043e0 <acquire>
  np->state = RUNNABLE;
80103504:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103507:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  release(&ptable.lock);
8010350e:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103515:	e8 82 0f 00 00       	call   8010449c <release>
}
8010351a:	89 d8                	mov    %ebx,%eax
8010351c:	83 c4 2c             	add    $0x2c,%esp
8010351f:	5b                   	pop    %ebx
80103520:	5e                   	pop    %esi
80103521:	5f                   	pop    %edi
80103522:	5d                   	pop    %ebp
80103523:	c3                   	ret    
    return -1;
80103524:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103529:	eb ef                	jmp    8010351a <fork+0xda>
      cprintf("copy process state from proc\n");
8010352b:	c7 04 24 e0 72 10 80 	movl   $0x801072e0,(%esp)
80103532:	e8 7d d0 ff ff       	call   801005b4 <cprintf>
    kfree(np->kstack);
80103537:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010353a:	8b 42 08             	mov    0x8(%edx),%eax
8010353d:	89 04 24             	mov    %eax,(%esp)
80103540:	e8 6b eb ff ff       	call   801020b0 <kfree>
    np->kstack = 0;
80103545:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103548:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    np->state = UNUSED;
8010354f:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return -1;
80103556:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010355b:	eb bd                	jmp    8010351a <fork+0xda>
8010355d:	8d 76 00             	lea    0x0(%esi),%esi

80103560 <rand>:
{
80103560:	55                   	push   %ebp
80103561:	89 e5                	mov    %esp,%ebp
  randstate = randstate * 1664525 + 1013904223;
80103563:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80103568:	8d 14 40             	lea    (%eax,%eax,2),%edx
8010356b:	8d 14 90             	lea    (%eax,%edx,4),%edx
8010356e:	c1 e2 08             	shl    $0x8,%edx
80103571:	01 c2                	add    %eax,%edx
80103573:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103576:	8d 04 90             	lea    (%eax,%edx,4),%eax
80103579:	8d 04 80             	lea    (%eax,%eax,4),%eax
8010357c:	8d 84 80 5f f3 6e 3c 	lea    0x3c6ef35f(%eax,%eax,4),%eax
80103583:	a3 00 a0 10 80       	mov    %eax,0x8010a000
}
80103588:	5d                   	pop    %ebp
80103589:	c3                   	ret    
8010358a:	66 90                	xchg   %ax,%ax

8010358c <GetTotalTickets>:
{
8010358c:	55                   	push   %ebp
8010358d:	89 e5                	mov    %esp,%ebp
  int temp = 0;
8010358f:	31 c0                	xor    %eax,%eax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103591:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80103596:	eb 0e                	jmp    801035a6 <GetTotalTickets+0x1a>
80103598:	81 c2 98 00 00 00    	add    $0x98,%edx
8010359e:	81 fa 54 53 11 80    	cmp    $0x80115354,%edx
801035a4:	74 1a                	je     801035c0 <GetTotalTickets+0x34>
    if(p->state == RUNNABLE){
801035a6:	83 7a 0c 03          	cmpl   $0x3,0xc(%edx)
801035aa:	75 ec                	jne    80103598 <GetTotalTickets+0xc>
      temp = temp + p->tickets;
801035ac:	03 82 80 00 00 00    	add    0x80(%edx),%eax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801035b2:	81 c2 98 00 00 00    	add    $0x98,%edx
801035b8:	81 fa 54 53 11 80    	cmp    $0x80115354,%edx
801035be:	75 e6                	jne    801035a6 <GetTotalTickets+0x1a>
}
801035c0:	5d                   	pop    %ebp
801035c1:	c3                   	ret    
801035c2:	66 90                	xchg   %ax,%ax

801035c4 <GetTotalStride>:
{
801035c4:	55                   	push   %ebp
801035c5:	89 e5                	mov    %esp,%ebp
    int temp = 0;
801035c7:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801035c9:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
801035ce:	eb 0e                	jmp    801035de <GetTotalStride+0x1a>
801035d0:	81 c2 98 00 00 00    	add    $0x98,%edx
801035d6:	81 fa 54 53 11 80    	cmp    $0x80115354,%edx
801035dc:	74 1a                	je     801035f8 <GetTotalStride+0x34>
        if(p->state == RUNNABLE){
801035de:	83 7a 0c 03          	cmpl   $0x3,0xc(%edx)
801035e2:	75 ec                	jne    801035d0 <GetTotalStride+0xc>
            temp = temp + p->stride;
801035e4:	03 82 88 00 00 00    	add    0x88(%edx),%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801035ea:	81 c2 98 00 00 00    	add    $0x98,%edx
801035f0:	81 fa 54 53 11 80    	cmp    $0x80115354,%edx
801035f6:	75 e6                	jne    801035de <GetTotalStride+0x1a>
}
801035f8:	5d                   	pop    %ebp
801035f9:	c3                   	ret    
801035fa:	66 90                	xchg   %ax,%ax

801035fc <scheduler>:
{
801035fc:	55                   	push   %ebp
801035fd:	89 e5                	mov    %esp,%ebp
801035ff:	57                   	push   %edi
80103600:	56                   	push   %esi
80103601:	53                   	push   %ebx
80103602:	83 ec 2c             	sub    $0x2c,%esp
  struct cpu *c = mycpu();
80103605:	e8 d6 fb ff ff       	call   801031e0 <mycpu>
8010360a:	89 c3                	mov    %eax,%ebx
  c->proc = 0;
8010360c:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103613:	00 00 00 
80103616:	8d 40 04             	lea    0x4(%eax),%eax
80103619:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  asm volatile("sti");
8010361c:	fb                   	sti    
    acquire(&ptable.lock);
8010361d:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103624:	e8 b7 0d 00 00       	call   801043e0 <acquire>
  int temp = 0;
80103629:	31 c9                	xor    %ecx,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010362b:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103630:	eb 0e                	jmp    80103640 <scheduler+0x44>
80103632:	66 90                	xchg   %ax,%ax
80103634:	05 98 00 00 00       	add    $0x98,%eax
80103639:	3d 54 53 11 80       	cmp    $0x80115354,%eax
8010363e:	74 18                	je     80103658 <scheduler+0x5c>
    if(p->state == RUNNABLE){
80103640:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80103644:	75 ee                	jne    80103634 <scheduler+0x38>
      temp = temp + p->tickets;
80103646:	03 88 80 00 00 00    	add    0x80(%eax),%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010364c:	05 98 00 00 00       	add    $0x98,%eax
80103651:	3d 54 53 11 80       	cmp    $0x80115354,%eax
80103656:	75 e8                	jne    80103640 <scheduler+0x44>
    if(totaltickets < 0){
80103658:	83 f9 00             	cmp    $0x0,%ecx
8010365b:	0f 8c ca 01 00 00    	jl     8010382b <scheduler+0x22f>
    else if(totaltickets == 0) {
80103661:	0f 85 aa 00 00 00    	jne    80103711 <scheduler+0x115>
80103667:	31 d2                	xor    %edx,%edx
80103669:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010366e:	eb 0c                	jmp    8010367c <scheduler+0x80>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103670:	05 98 00 00 00       	add    $0x98,%eax
80103675:	3d 54 53 11 80       	cmp    $0x80115354,%eax
8010367a:	74 18                	je     80103694 <scheduler+0x98>
        if(p->state == RUNNABLE){
8010367c:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80103680:	75 ee                	jne    80103670 <scheduler+0x74>
            temp = temp + p->stride;
80103682:	03 90 88 00 00 00    	add    0x88(%eax),%edx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103688:	05 98 00 00 00       	add    $0x98,%eax
8010368d:	3d 54 53 11 80       	cmp    $0x80115354,%eax
80103692:	75 e8                	jne    8010367c <scheduler+0x80>
      if(totalstride == 0) {  //there are no strides in all processes, run them by using round-robin
80103694:	85 d2                	test   %edx,%edx
80103696:	0f 85 1d 01 00 00    	jne    801037b9 <scheduler+0x1bd>
8010369c:	bf 54 2d 11 80       	mov    $0x80112d54,%edi
801036a1:	89 75 e0             	mov    %esi,-0x20(%ebp)
801036a4:	89 de                	mov    %ebx,%esi
801036a6:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801036a9:	eb 0f                	jmp    801036ba <scheduler+0xbe>
801036ab:	90                   	nop
          for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801036ac:	81 c7 98 00 00 00    	add    $0x98,%edi
801036b2:	81 ff 54 53 11 80    	cmp    $0x80115354,%edi
801036b8:	74 4d                	je     80103707 <scheduler+0x10b>
              if (p->state != RUNNABLE)
801036ba:	83 7f 0c 03          	cmpl   $0x3,0xc(%edi)
801036be:	75 ec                	jne    801036ac <scheduler+0xb0>
              p->schetimes = p->schetimes + 1;
801036c0:	ff 87 84 00 00 00    	incl   0x84(%edi)
              c->proc = p;
801036c6:	89 be ac 00 00 00    	mov    %edi,0xac(%esi)
              switchuvm(p);
801036cc:	89 3c 24             	mov    %edi,(%esp)
801036cf:	e8 94 2f 00 00       	call   80106668 <switchuvm>
              p->state = RUNNING;
801036d4:	c7 47 0c 04 00 00 00 	movl   $0x4,0xc(%edi)
              swtch(&(c->scheduler), p->context);
801036db:	8b 57 1c             	mov    0x1c(%edi),%edx
801036de:	89 54 24 04          	mov    %edx,0x4(%esp)
801036e2:	89 1c 24             	mov    %ebx,(%esp)
801036e5:	e8 db 0f 00 00       	call   801046c5 <swtch>
              switchkvm();
801036ea:	e8 65 2f 00 00       	call   80106654 <switchkvm>
              c->proc = 0;
801036ef:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
801036f6:	00 00 00 
          for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801036f9:	81 c7 98 00 00 00    	add    $0x98,%edi
801036ff:	81 ff 54 53 11 80    	cmp    $0x80115354,%edi
80103705:	75 b3                	jne    801036ba <scheduler+0xbe>
80103707:	89 f3                	mov    %esi,%ebx
80103709:	8b 75 e0             	mov    -0x20(%ebp),%esi
8010370c:	e9 97 00 00 00       	jmp    801037a8 <scheduler+0x1ac>
  randstate = randstate * 1664525 + 1013904223;
80103711:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80103716:	8d 14 40             	lea    (%eax,%eax,2),%edx
80103719:	8d 14 90             	lea    (%eax,%edx,4),%edx
8010371c:	c1 e2 08             	shl    $0x8,%edx
8010371f:	01 c2                	add    %eax,%edx
80103721:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103724:	8d 04 90             	lea    (%eax,%edx,4),%eax
80103727:	8d 04 80             	lea    (%eax,%eax,4),%eax
8010372a:	8d 94 80 5f f3 6e 3c 	lea    0x3c6ef35f(%eax,%eax,4),%edx
80103731:	89 15 00 a0 10 80    	mov    %edx,0x8010a000
80103737:	85 d2                	test   %edx,%edx
80103739:	0f 88 fd 00 00 00    	js     8010383c <scheduler+0x240>
      if(randtickets > totaltickets){   //if random number is too bigger, decrease it
8010373f:	39 ca                	cmp    %ecx,%edx
80103741:	7e 05                	jle    80103748 <scheduler+0x14c>
        randtickets = randtickets % totaltickets;
80103743:	89 d0                	mov    %edx,%eax
80103745:	99                   	cltd   
80103746:	f7 f9                	idiv   %ecx
          for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {  //to find the process with smallest stride
80103748:	bf 54 2d 11 80       	mov    $0x80112d54,%edi
8010374d:	eb 0f                	jmp    8010375e <scheduler+0x162>
8010374f:	90                   	nop
      for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {  //choose a process to run
80103750:	81 c7 98 00 00 00    	add    $0x98,%edi
80103756:	81 ff 54 53 11 80    	cmp    $0x80115354,%edi
8010375c:	74 4a                	je     801037a8 <scheduler+0x1ac>
          if (p->state == RUNNABLE) {
8010375e:	83 7f 0c 03          	cmpl   $0x3,0xc(%edi)
80103762:	75 ec                	jne    80103750 <scheduler+0x154>
          if (p->state != RUNNABLE || randtickets >= 0) {
80103764:	2b 97 80 00 00 00    	sub    0x80(%edi),%edx
8010376a:	79 e4                	jns    80103750 <scheduler+0x154>
          p->schetimes = p->schetimes + 1;  //increase scheduled time
8010376c:	ff 87 84 00 00 00    	incl   0x84(%edi)
          c->proc = p;
80103772:	89 bb ac 00 00 00    	mov    %edi,0xac(%ebx)
          switchuvm(p);
80103778:	89 3c 24             	mov    %edi,(%esp)
8010377b:	e8 e8 2e 00 00       	call   80106668 <switchuvm>
          p->state = RUNNING;
80103780:	c7 47 0c 04 00 00 00 	movl   $0x4,0xc(%edi)
          swtch(&(c->scheduler), p->context);
80103787:	8b 47 1c             	mov    0x1c(%edi),%eax
8010378a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010378e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103791:	89 04 24             	mov    %eax,(%esp)
80103794:	e8 2c 0f 00 00       	call   801046c5 <swtch>
          switchkvm();
80103799:	e8 b6 2e 00 00       	call   80106654 <switchkvm>
          c->proc = 0;
8010379e:	c7 83 ac 00 00 00 00 	movl   $0x0,0xac(%ebx)
801037a5:	00 00 00 
    release(&ptable.lock);
801037a8:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801037af:	e8 e8 0c 00 00       	call   8010449c <release>
  }
801037b4:	e9 63 fe ff ff       	jmp    8010361c <scheduler+0x20>
      if(totalstride == 0) {  //there are no strides in all processes, run them by using round-robin
801037b9:	31 ff                	xor    %edi,%edi
801037bb:	b9 40 42 0f 00       	mov    $0xf4240,%ecx
801037c0:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
801037c5:	eb 0d                	jmp    801037d4 <scheduler+0x1d8>
801037c7:	90                   	nop
          for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {  //to find the process with smallest stride
801037c8:	05 98 00 00 00       	add    $0x98,%eax
801037cd:	3d 54 53 11 80       	cmp    $0x80115354,%eax
801037d2:	74 25                	je     801037f9 <scheduler+0x1fd>
              if (p->state != RUNNABLE)
801037d4:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
801037d8:	75 ee                	jne    801037c8 <scheduler+0x1cc>
              if (p->stride < smallest){
801037da:	8b 90 88 00 00 00    	mov    0x88(%eax),%edx
801037e0:	39 ca                	cmp    %ecx,%edx
801037e2:	7d e4                	jge    801037c8 <scheduler+0x1cc>
801037e4:	89 c6                	mov    %eax,%esi
801037e6:	89 d1                	mov    %edx,%ecx
                  findit = 1;
801037e8:	bf 01 00 00 00       	mov    $0x1,%edi
          for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {  //to find the process with smallest stride
801037ed:	05 98 00 00 00       	add    $0x98,%eax
801037f2:	3d 54 53 11 80       	cmp    $0x80115354,%eax
801037f7:	75 db                	jne    801037d4 <scheduler+0x1d8>
          if(findit == 1){
801037f9:	4f                   	dec    %edi
801037fa:	75 ac                	jne    801037a8 <scheduler+0x1ac>
              schelit->stride = schelit->stride + schelit->pass;  //increase the chosen process's stride by pass
801037fc:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
80103802:	01 86 88 00 00 00    	add    %eax,0x88(%esi)
              schelit->schetimes = schelit->schetimes + 1;  //scheduled time + 1
80103808:	ff 86 84 00 00 00    	incl   0x84(%esi)
              c->proc = schelit;
8010380e:	89 b3 ac 00 00 00    	mov    %esi,0xac(%ebx)
              switchuvm(schelit);
80103814:	89 34 24             	mov    %esi,(%esp)
80103817:	e8 4c 2e 00 00       	call   80106668 <switchuvm>
              schelit->state = RUNNING;
8010381c:	c7 46 0c 04 00 00 00 	movl   $0x4,0xc(%esi)
              swtch(&(c->scheduler), schelit->context);
80103823:	8b 46 1c             	mov    0x1c(%esi),%eax
80103826:	e9 5f ff ff ff       	jmp    8010378a <scheduler+0x18e>
      cprintf("error total tickets\n");
8010382b:	c7 04 24 fe 72 10 80 	movl   $0x801072fe,(%esp)
80103832:	e8 7d cd ff ff       	call   801005b4 <cprintf>
80103837:	e9 6c ff ff ff       	jmp    801037a8 <scheduler+0x1ac>
8010383c:	f7 da                	neg    %edx
8010383e:	e9 fc fe ff ff       	jmp    8010373f <scheduler+0x143>
80103843:	90                   	nop

80103844 <sched>:
{
80103844:	55                   	push   %ebp
80103845:	89 e5                	mov    %esp,%ebp
80103847:	56                   	push   %esi
80103848:	53                   	push   %ebx
80103849:	83 ec 10             	sub    $0x10,%esp
  struct proc *p = myproc();
8010384c:	e8 37 fa ff ff       	call   80103288 <myproc>
80103851:	89 c3                	mov    %eax,%ebx
  if(!holding(&ptable.lock))
80103853:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
8010385a:	e8 21 0b 00 00       	call   80104380 <holding>
8010385f:	85 c0                	test   %eax,%eax
80103861:	74 4f                	je     801038b2 <sched+0x6e>
  if(mycpu()->ncli != 1)
80103863:	e8 78 f9 ff ff       	call   801031e0 <mycpu>
80103868:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
8010386f:	75 65                	jne    801038d6 <sched+0x92>
  if(p->state == RUNNING)
80103871:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103875:	74 53                	je     801038ca <sched+0x86>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103877:	9c                   	pushf  
80103878:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103879:	f6 c4 02             	test   $0x2,%ah
8010387c:	75 40                	jne    801038be <sched+0x7a>
  intena = mycpu()->intena;
8010387e:	e8 5d f9 ff ff       	call   801031e0 <mycpu>
80103883:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103889:	e8 52 f9 ff ff       	call   801031e0 <mycpu>
8010388e:	8b 40 04             	mov    0x4(%eax),%eax
80103891:	89 44 24 04          	mov    %eax,0x4(%esp)
80103895:	83 c3 1c             	add    $0x1c,%ebx
80103898:	89 1c 24             	mov    %ebx,(%esp)
8010389b:	e8 25 0e 00 00       	call   801046c5 <swtch>
  mycpu()->intena = intena;
801038a0:	e8 3b f9 ff ff       	call   801031e0 <mycpu>
801038a5:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
801038ab:	83 c4 10             	add    $0x10,%esp
801038ae:	5b                   	pop    %ebx
801038af:	5e                   	pop    %esi
801038b0:	5d                   	pop    %ebp
801038b1:	c3                   	ret    
    panic("sched ptable.lock");
801038b2:	c7 04 24 13 73 10 80 	movl   $0x80107313,(%esp)
801038b9:	e8 52 ca ff ff       	call   80100310 <panic>
    panic("sched interruptible");
801038be:	c7 04 24 3f 73 10 80 	movl   $0x8010733f,(%esp)
801038c5:	e8 46 ca ff ff       	call   80100310 <panic>
    panic("sched running");
801038ca:	c7 04 24 31 73 10 80 	movl   $0x80107331,(%esp)
801038d1:	e8 3a ca ff ff       	call   80100310 <panic>
    panic("sched locks");
801038d6:	c7 04 24 25 73 10 80 	movl   $0x80107325,(%esp)
801038dd:	e8 2e ca ff ff       	call   80100310 <panic>
801038e2:	66 90                	xchg   %ax,%ax

801038e4 <exit>:
{
801038e4:	55                   	push   %ebp
801038e5:	89 e5                	mov    %esp,%ebp
801038e7:	56                   	push   %esi
801038e8:	53                   	push   %ebx
801038e9:	83 ec 10             	sub    $0x10,%esp
  struct proc *curproc = myproc();
801038ec:	e8 97 f9 ff ff       	call   80103288 <myproc>
801038f1:	89 c6                	mov    %eax,%esi
  procnum--;     //One process exits, decrease the process number.
801038f3:	ff 0d a0 a5 10 80    	decl   0x8010a5a0
  curproc->syscallnum = 0;
801038f9:	c7 40 7c 00 00 00 00 	movl   $0x0,0x7c(%eax)
  if(curproc == initproc)
80103900:	31 db                	xor    %ebx,%ebx
80103902:	3b 05 a4 a5 10 80    	cmp    0x8010a5a4,%eax
80103908:	0f 84 2e 02 00 00    	je     80103b3c <exit+0x258>
8010390e:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd]){
80103910:	8b 44 9e 28          	mov    0x28(%esi,%ebx,4),%eax
80103914:	85 c0                	test   %eax,%eax
80103916:	74 10                	je     80103928 <exit+0x44>
      fileclose(curproc->ofile[fd]);
80103918:	89 04 24             	mov    %eax,(%esp)
8010391b:	e8 20 d4 ff ff       	call   80100d40 <fileclose>
      curproc->ofile[fd] = 0;
80103920:	c7 44 9e 28 00 00 00 	movl   $0x0,0x28(%esi,%ebx,4)
80103927:	00 
  for(fd = 0; fd < NOFILE; fd++){
80103928:	43                   	inc    %ebx
80103929:	83 fb 10             	cmp    $0x10,%ebx
8010392c:	75 e2                	jne    80103910 <exit+0x2c>
  begin_op();
8010392e:	e8 65 ee ff ff       	call   80102798 <begin_op>
  iput(curproc->cwd);
80103933:	8b 46 68             	mov    0x68(%esi),%eax
80103936:	89 04 24             	mov    %eax,(%esp)
80103939:	e8 22 dd ff ff       	call   80101660 <iput>
  end_op();
8010393e:	e8 b1 ee ff ff       	call   801027f4 <end_op>
  curproc->cwd = 0;
80103943:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
8010394a:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103951:	e8 8a 0a 00 00       	call   801043e0 <acquire>
  wakeup1(curproc->parent);
80103956:	8b 46 14             	mov    0x14(%esi),%eax
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103959:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
8010395e:	eb 0e                	jmp    8010396e <exit+0x8a>
80103960:	81 c2 98 00 00 00    	add    $0x98,%edx
80103966:	81 fa 54 53 11 80    	cmp    $0x80115354,%edx
8010396c:	74 20                	je     8010398e <exit+0xaa>
    if(p->state == SLEEPING && p->chan == chan)
8010396e:	83 7a 0c 02          	cmpl   $0x2,0xc(%edx)
80103972:	75 ec                	jne    80103960 <exit+0x7c>
80103974:	3b 42 20             	cmp    0x20(%edx),%eax
80103977:	75 e7                	jne    80103960 <exit+0x7c>
      p->state = RUNNABLE;
80103979:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103980:	81 c2 98 00 00 00    	add    $0x98,%edx
80103986:	81 fa 54 53 11 80    	cmp    $0x80115354,%edx
8010398c:	75 e0                	jne    8010396e <exit+0x8a>
            p->parent = initproc;
8010398e:	a1 a4 a5 10 80       	mov    0x8010a5a4,%eax
80103993:	b9 54 2d 11 80       	mov    $0x80112d54,%ecx
80103998:	eb 10                	jmp    801039aa <exit+0xc6>
8010399a:	66 90                	xchg   %ax,%ax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010399c:	81 c1 98 00 00 00    	add    $0x98,%ecx
801039a2:	81 f9 54 53 11 80    	cmp    $0x80115354,%ecx
801039a8:	74 5c                	je     80103a06 <exit+0x122>
    if(p->parent == curproc){
801039aa:	39 71 14             	cmp    %esi,0x14(%ecx)
801039ad:	75 ed                	jne    8010399c <exit+0xb8>
        if(p->pgdir != curproc->pgdir) {
801039af:	8b 56 04             	mov    0x4(%esi),%edx
801039b2:	39 51 04             	cmp    %edx,0x4(%ecx)
801039b5:	74 33                	je     801039ea <exit+0x106>
            p->parent = initproc;
801039b7:	89 41 14             	mov    %eax,0x14(%ecx)
            if (p->state == ZOMBIE)
801039ba:	83 79 0c 05          	cmpl   $0x5,0xc(%ecx)
801039be:	75 dc                	jne    8010399c <exit+0xb8>
801039c0:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
801039c5:	eb 0f                	jmp    801039d6 <exit+0xf2>
801039c7:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801039c8:	81 c2 98 00 00 00    	add    $0x98,%edx
801039ce:	81 fa 54 53 11 80    	cmp    $0x80115354,%edx
801039d4:	74 c6                	je     8010399c <exit+0xb8>
    if(p->state == SLEEPING && p->chan == chan)
801039d6:	83 7a 0c 02          	cmpl   $0x2,0xc(%edx)
801039da:	75 ec                	jne    801039c8 <exit+0xe4>
801039dc:	3b 42 20             	cmp    0x20(%edx),%eax
801039df:	75 e7                	jne    801039c8 <exit+0xe4>
      p->state = RUNNABLE;
801039e1:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
801039e8:	eb de                	jmp    801039c8 <exit+0xe4>
            p->parent = 0;
801039ea:	c7 41 14 00 00 00 00 	movl   $0x0,0x14(%ecx)
            p->state =ZOMBIE;
801039f1:	c7 41 0c 05 00 00 00 	movl   $0x5,0xc(%ecx)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801039f8:	81 c1 98 00 00 00    	add    $0x98,%ecx
801039fe:	81 f9 54 53 11 80    	cmp    $0x80115354,%ecx
80103a04:	75 a4                	jne    801039aa <exit+0xc6>
    if(curproc->tickets > 0) {
80103a06:	8b 86 80 00 00 00    	mov    0x80(%esi),%eax
80103a0c:	85 c0                	test   %eax,%eax
80103a0e:	7e 7a                	jle    80103a8a <exit+0x1a6>
        cprintf("Prog with %d tickets has been scheduled %d times, and it exits now\n",curproc->tickets,curproc->schetimes);
80103a10:	8b 96 84 00 00 00    	mov    0x84(%esi),%edx
80103a16:	89 54 24 08          	mov    %edx,0x8(%esp)
80103a1a:	89 44 24 04          	mov    %eax,0x4(%esp)
80103a1e:	c7 04 24 e4 73 10 80 	movl   $0x801073e4,(%esp)
80103a25:	e8 8a cb ff ff       	call   801005b4 <cprintf>
        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103a2a:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80103a2f:	eb 11                	jmp    80103a42 <exit+0x15e>
80103a31:	8d 76 00             	lea    0x0(%esi),%esi
80103a34:	81 c3 98 00 00 00    	add    $0x98,%ebx
80103a3a:	81 fb 54 53 11 80    	cmp    $0x80115354,%ebx
80103a40:	74 3c                	je     80103a7e <exit+0x19a>
            if ( p->tickets > 0 && p != curproc && p->state == RUNNABLE) {
80103a42:	8b 83 80 00 00 00    	mov    0x80(%ebx),%eax
80103a48:	85 c0                	test   %eax,%eax
80103a4a:	7e e8                	jle    80103a34 <exit+0x150>
80103a4c:	39 f3                	cmp    %esi,%ebx
80103a4e:	74 e4                	je     80103a34 <exit+0x150>
80103a50:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103a54:	75 de                	jne    80103a34 <exit+0x150>
                cprintf("Prog with %d tickets has been scheduled %d times\n",p->tickets,p->schetimes);
80103a56:	8b 93 84 00 00 00    	mov    0x84(%ebx),%edx
80103a5c:	89 54 24 08          	mov    %edx,0x8(%esp)
80103a60:	89 44 24 04          	mov    %eax,0x4(%esp)
80103a64:	c7 04 24 28 74 10 80 	movl   $0x80107428,(%esp)
80103a6b:	e8 44 cb ff ff       	call   801005b4 <cprintf>
        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103a70:	81 c3 98 00 00 00    	add    $0x98,%ebx
80103a76:	81 fb 54 53 11 80    	cmp    $0x80115354,%ebx
80103a7c:	75 c4                	jne    80103a42 <exit+0x15e>
        cprintf("\n");
80103a7e:	c7 04 24 1b 78 10 80 	movl   $0x8010781b,(%esp)
80103a85:	e8 2a cb ff ff       	call   801005b4 <cprintf>
    if(curproc->stride > 0) {
80103a8a:	8b 86 88 00 00 00    	mov    0x88(%esi),%eax
80103a90:	85 c0                	test   %eax,%eax
80103a92:	0f 8e 8c 00 00 00    	jle    80103b24 <exit+0x240>
        cprintf("Prog with %d strides and %d passes has been scheduled %d times, and it exits now\n",
80103a98:	8b 96 84 00 00 00    	mov    0x84(%esi),%edx
80103a9e:	89 54 24 0c          	mov    %edx,0xc(%esp)
80103aa2:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
80103aa8:	89 54 24 08          	mov    %edx,0x8(%esp)
80103aac:	89 44 24 04          	mov    %eax,0x4(%esp)
80103ab0:	c7 04 24 5c 74 10 80 	movl   $0x8010745c,(%esp)
80103ab7:	e8 f8 ca ff ff       	call   801005b4 <cprintf>
        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103abc:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80103ac1:	eb 0f                	jmp    80103ad2 <exit+0x1ee>
80103ac3:	90                   	nop
80103ac4:	81 c3 98 00 00 00    	add    $0x98,%ebx
80103aca:	81 fb 54 53 11 80    	cmp    $0x80115354,%ebx
80103ad0:	74 46                	je     80103b18 <exit+0x234>
            if ( p->stride > 0 && p != curproc && p->state == RUNNABLE) {
80103ad2:	8b 83 88 00 00 00    	mov    0x88(%ebx),%eax
80103ad8:	85 c0                	test   %eax,%eax
80103ada:	7e e8                	jle    80103ac4 <exit+0x1e0>
80103adc:	39 f3                	cmp    %esi,%ebx
80103ade:	74 e4                	je     80103ac4 <exit+0x1e0>
80103ae0:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103ae4:	75 de                	jne    80103ac4 <exit+0x1e0>
                cprintf("Prog with %d stride and %d passes has been scheduled %d times\n",
80103ae6:	8b 93 84 00 00 00    	mov    0x84(%ebx),%edx
80103aec:	89 54 24 0c          	mov    %edx,0xc(%esp)
80103af0:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80103af6:	89 54 24 08          	mov    %edx,0x8(%esp)
80103afa:	89 44 24 04          	mov    %eax,0x4(%esp)
80103afe:	c7 04 24 b0 74 10 80 	movl   $0x801074b0,(%esp)
80103b05:	e8 aa ca ff ff       	call   801005b4 <cprintf>
        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103b0a:	81 c3 98 00 00 00    	add    $0x98,%ebx
80103b10:	81 fb 54 53 11 80    	cmp    $0x80115354,%ebx
80103b16:	75 ba                	jne    80103ad2 <exit+0x1ee>
        cprintf("\n");
80103b18:	c7 04 24 1b 78 10 80 	movl   $0x8010781b,(%esp)
80103b1f:	e8 90 ca ff ff       	call   801005b4 <cprintf>
  curproc->state = ZOMBIE;
80103b24:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103b2b:	e8 14 fd ff ff       	call   80103844 <sched>
  panic("zombie exit");
80103b30:	c7 04 24 60 73 10 80 	movl   $0x80107360,(%esp)
80103b37:	e8 d4 c7 ff ff       	call   80100310 <panic>
    panic("init exiting");
80103b3c:	c7 04 24 53 73 10 80 	movl   $0x80107353,(%esp)
80103b43:	e8 c8 c7 ff ff       	call   80100310 <panic>

80103b48 <yield>:
{
80103b48:	55                   	push   %ebp
80103b49:	89 e5                	mov    %esp,%ebp
80103b4b:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103b4e:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103b55:	e8 86 08 00 00       	call   801043e0 <acquire>
  myproc()->state = RUNNABLE;
80103b5a:	e8 29 f7 ff ff       	call   80103288 <myproc>
80103b5f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80103b66:	e8 d9 fc ff ff       	call   80103844 <sched>
  release(&ptable.lock);
80103b6b:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103b72:	e8 25 09 00 00       	call   8010449c <release>
}
80103b77:	c9                   	leave  
80103b78:	c3                   	ret    
80103b79:	8d 76 00             	lea    0x0(%esi),%esi

80103b7c <sleep>:
{
80103b7c:	55                   	push   %ebp
80103b7d:	89 e5                	mov    %esp,%ebp
80103b7f:	57                   	push   %edi
80103b80:	56                   	push   %esi
80103b81:	53                   	push   %ebx
80103b82:	83 ec 1c             	sub    $0x1c,%esp
80103b85:	8b 7d 08             	mov    0x8(%ebp),%edi
80103b88:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct proc *p = myproc();
80103b8b:	e8 f8 f6 ff ff       	call   80103288 <myproc>
80103b90:	89 c3                	mov    %eax,%ebx
  if(p == 0)
80103b92:	85 c0                	test   %eax,%eax
80103b94:	74 7c                	je     80103c12 <sleep+0x96>
  if(lk == 0)
80103b96:	85 f6                	test   %esi,%esi
80103b98:	74 6c                	je     80103c06 <sleep+0x8a>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103b9a:	81 fe 20 2d 11 80    	cmp    $0x80112d20,%esi
80103ba0:	74 46                	je     80103be8 <sleep+0x6c>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103ba2:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103ba9:	e8 32 08 00 00       	call   801043e0 <acquire>
    release(lk);
80103bae:	89 34 24             	mov    %esi,(%esp)
80103bb1:	e8 e6 08 00 00       	call   8010449c <release>
  p->chan = chan;
80103bb6:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103bb9:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103bc0:	e8 7f fc ff ff       	call   80103844 <sched>
  p->chan = 0;
80103bc5:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80103bcc:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103bd3:	e8 c4 08 00 00       	call   8010449c <release>
    acquire(lk);
80103bd8:	89 75 08             	mov    %esi,0x8(%ebp)
}
80103bdb:	83 c4 1c             	add    $0x1c,%esp
80103bde:	5b                   	pop    %ebx
80103bdf:	5e                   	pop    %esi
80103be0:	5f                   	pop    %edi
80103be1:	5d                   	pop    %ebp
    acquire(lk);
80103be2:	e9 f9 07 00 00       	jmp    801043e0 <acquire>
80103be7:	90                   	nop
  p->chan = chan;
80103be8:	89 78 20             	mov    %edi,0x20(%eax)
  p->state = SLEEPING;
80103beb:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80103bf2:	e8 4d fc ff ff       	call   80103844 <sched>
  p->chan = 0;
80103bf7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103bfe:	83 c4 1c             	add    $0x1c,%esp
80103c01:	5b                   	pop    %ebx
80103c02:	5e                   	pop    %esi
80103c03:	5f                   	pop    %edi
80103c04:	5d                   	pop    %ebp
80103c05:	c3                   	ret    
    panic("sleep without lk");
80103c06:	c7 04 24 72 73 10 80 	movl   $0x80107372,(%esp)
80103c0d:	e8 fe c6 ff ff       	call   80100310 <panic>
    panic("sleep");
80103c12:	c7 04 24 6c 73 10 80 	movl   $0x8010736c,(%esp)
80103c19:	e8 f2 c6 ff ff       	call   80100310 <panic>
80103c1e:	66 90                	xchg   %ax,%ax

80103c20 <wait>:
{
80103c20:	55                   	push   %ebp
80103c21:	89 e5                	mov    %esp,%ebp
80103c23:	56                   	push   %esi
80103c24:	53                   	push   %ebx
80103c25:	83 ec 20             	sub    $0x20,%esp
  struct proc *curproc = myproc();
80103c28:	e8 5b f6 ff ff       	call   80103288 <myproc>
80103c2d:	89 c6                	mov    %eax,%esi
  acquire(&ptable.lock);
80103c2f:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103c36:	e8 a5 07 00 00       	call   801043e0 <acquire>
80103c3b:	90                   	nop
    havekids = 0;
80103c3c:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c3e:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80103c43:	eb 11                	jmp    80103c56 <wait+0x36>
80103c45:	8d 76 00             	lea    0x0(%esi),%esi
80103c48:	81 c3 98 00 00 00    	add    $0x98,%ebx
80103c4e:	81 fb 54 53 11 80    	cmp    $0x80115354,%ebx
80103c54:	74 26                	je     80103c7c <wait+0x5c>
      if(p->parent != curproc || p->pgdir == curproc->pgdir)
80103c56:	39 73 14             	cmp    %esi,0x14(%ebx)
80103c59:	75 ed                	jne    80103c48 <wait+0x28>
80103c5b:	8b 56 04             	mov    0x4(%esi),%edx
80103c5e:	39 53 04             	cmp    %edx,0x4(%ebx)
80103c61:	74 e5                	je     80103c48 <wait+0x28>
      if(p->state == ZOMBIE && *(p->reference_count) == 1){
80103c63:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103c67:	74 3b                	je     80103ca4 <wait+0x84>
      havekids = 1;
80103c69:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c6e:	81 c3 98 00 00 00    	add    $0x98,%ebx
80103c74:	81 fb 54 53 11 80    	cmp    $0x80115354,%ebx
80103c7a:	75 da                	jne    80103c56 <wait+0x36>
    if(!havekids || curproc->killed){
80103c7c:	85 c0                	test   %eax,%eax
80103c7e:	0f 84 ac 00 00 00    	je     80103d30 <wait+0x110>
80103c84:	8b 46 24             	mov    0x24(%esi),%eax
80103c87:	85 c0                	test   %eax,%eax
80103c89:	0f 85 a1 00 00 00    	jne    80103d30 <wait+0x110>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80103c8f:	c7 44 24 04 20 2d 11 	movl   $0x80112d20,0x4(%esp)
80103c96:	80 
80103c97:	89 34 24             	mov    %esi,(%esp)
80103c9a:	e8 dd fe ff ff       	call   80103b7c <sleep>
  }
80103c9f:	eb 9b                	jmp    80103c3c <wait+0x1c>
80103ca1:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->state == ZOMBIE && *(p->reference_count) == 1){
80103ca4:	8b 83 94 00 00 00    	mov    0x94(%ebx),%eax
80103caa:	83 38 01             	cmpl   $0x1,(%eax)
80103cad:	75 ba                	jne    80103c69 <wait+0x49>
        pid = p->pid;
80103caf:	8b 43 10             	mov    0x10(%ebx),%eax
        kfree(p->kstack);
80103cb2:	8b 53 08             	mov    0x8(%ebx),%edx
80103cb5:	89 14 24             	mov    %edx,(%esp)
80103cb8:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103cbb:	e8 f0 e3 ff ff       	call   801020b0 <kfree>
        p->kstack = 0;
80103cc0:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103cc7:	8b 53 04             	mov    0x4(%ebx),%edx
80103cca:	89 14 24             	mov    %edx,(%esp)
80103ccd:	e8 a6 2d 00 00       	call   80106a78 <freevm>
        p->pid = 0;
80103cd2:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103cd9:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103ce0:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103ce4:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103ceb:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        p->schetimes = 0;
80103cf2:	c7 83 84 00 00 00 00 	movl   $0x0,0x84(%ebx)
80103cf9:	00 00 00 
        p->tickets = 0;
80103cfc:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
80103d03:	00 00 00 
        p->stride = 0;
80103d06:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
80103d0d:	00 00 00 
        p->pass = 0;
80103d10:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80103d17:	00 00 00 
        release(&ptable.lock);
80103d1a:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103d21:	e8 76 07 00 00       	call   8010449c <release>
        return pid;
80103d26:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80103d29:	83 c4 20             	add    $0x20,%esp
80103d2c:	5b                   	pop    %ebx
80103d2d:	5e                   	pop    %esi
80103d2e:	5d                   	pop    %ebp
80103d2f:	c3                   	ret    
      release(&ptable.lock);
80103d30:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103d37:	e8 60 07 00 00       	call   8010449c <release>
      return -1;
80103d3c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103d41:	83 c4 20             	add    $0x20,%esp
80103d44:	5b                   	pop    %ebx
80103d45:	5e                   	pop    %esi
80103d46:	5d                   	pop    %ebp
80103d47:	c3                   	ret    

80103d48 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80103d48:	55                   	push   %ebp
80103d49:	89 e5                	mov    %esp,%ebp
80103d4b:	53                   	push   %ebx
80103d4c:	83 ec 14             	sub    $0x14,%esp
80103d4f:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80103d52:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103d59:	e8 82 06 00 00       	call   801043e0 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d5e:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103d63:	eb 0f                	jmp    80103d74 <wakeup+0x2c>
80103d65:	8d 76 00             	lea    0x0(%esi),%esi
80103d68:	05 98 00 00 00       	add    $0x98,%eax
80103d6d:	3d 54 53 11 80       	cmp    $0x80115354,%eax
80103d72:	74 20                	je     80103d94 <wakeup+0x4c>
    if(p->state == SLEEPING && p->chan == chan)
80103d74:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103d78:	75 ee                	jne    80103d68 <wakeup+0x20>
80103d7a:	3b 58 20             	cmp    0x20(%eax),%ebx
80103d7d:	75 e9                	jne    80103d68 <wakeup+0x20>
      p->state = RUNNABLE;
80103d7f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d86:	05 98 00 00 00       	add    $0x98,%eax
80103d8b:	3d 54 53 11 80       	cmp    $0x80115354,%eax
80103d90:	75 e2                	jne    80103d74 <wakeup+0x2c>
80103d92:	66 90                	xchg   %ax,%ax
  wakeup1(chan);
  release(&ptable.lock);
80103d94:	c7 45 08 20 2d 11 80 	movl   $0x80112d20,0x8(%ebp)
}
80103d9b:	83 c4 14             	add    $0x14,%esp
80103d9e:	5b                   	pop    %ebx
80103d9f:	5d                   	pop    %ebp
  release(&ptable.lock);
80103da0:	e9 f7 06 00 00       	jmp    8010449c <release>
80103da5:	8d 76 00             	lea    0x0(%esi),%esi

80103da8 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80103da8:	55                   	push   %ebp
80103da9:	89 e5                	mov    %esp,%ebp
80103dab:	53                   	push   %ebx
80103dac:	83 ec 14             	sub    $0x14,%esp
80103daf:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80103db2:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103db9:	e8 22 06 00 00       	call   801043e0 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103dbe:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103dc3:	eb 0f                	jmp    80103dd4 <kill+0x2c>
80103dc5:	8d 76 00             	lea    0x0(%esi),%esi
80103dc8:	05 98 00 00 00       	add    $0x98,%eax
80103dcd:	3d 54 53 11 80       	cmp    $0x80115354,%eax
80103dd2:	74 34                	je     80103e08 <kill+0x60>
    if(p->pid == pid){
80103dd4:	39 58 10             	cmp    %ebx,0x10(%eax)
80103dd7:	75 ef                	jne    80103dc8 <kill+0x20>
      p->killed = 1;
80103dd9:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80103de0:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103de4:	74 16                	je     80103dfc <kill+0x54>
        p->state = RUNNABLE;
      release(&ptable.lock);
80103de6:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103ded:	e8 aa 06 00 00       	call   8010449c <release>
      return 0;
80103df2:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80103df4:	83 c4 14             	add    $0x14,%esp
80103df7:	5b                   	pop    %ebx
80103df8:	5d                   	pop    %ebp
80103df9:	c3                   	ret    
80103dfa:	66 90                	xchg   %ax,%ax
        p->state = RUNNABLE;
80103dfc:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103e03:	eb e1                	jmp    80103de6 <kill+0x3e>
80103e05:	8d 76 00             	lea    0x0(%esi),%esi
  release(&ptable.lock);
80103e08:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103e0f:	e8 88 06 00 00       	call   8010449c <release>
  return -1;
80103e14:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103e19:	83 c4 14             	add    $0x14,%esp
80103e1c:	5b                   	pop    %ebx
80103e1d:	5d                   	pop    %ebp
80103e1e:	c3                   	ret    
80103e1f:	90                   	nop

80103e20 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80103e20:	55                   	push   %ebp
80103e21:	89 e5                	mov    %esp,%ebp
80103e23:	57                   	push   %edi
80103e24:	56                   	push   %esi
80103e25:	53                   	push   %ebx
80103e26:	83 ec 4c             	sub    $0x4c,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e29:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
procdump(void)
80103e2e:	8d 75 e8             	lea    -0x18(%ebp),%esi
80103e31:	eb 4a                	jmp    80103e7d <procdump+0x5d>
80103e33:	90                   	nop
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80103e34:	8b 04 85 f0 74 10 80 	mov    -0x7fef8b10(,%eax,4),%eax
80103e3b:	85 c0                	test   %eax,%eax
80103e3d:	74 4a                	je     80103e89 <procdump+0x69>
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
80103e3f:	8d 53 6c             	lea    0x6c(%ebx),%edx
80103e42:	89 54 24 0c          	mov    %edx,0xc(%esp)
80103e46:	89 44 24 08          	mov    %eax,0x8(%esp)
80103e4a:	8b 43 10             	mov    0x10(%ebx),%eax
80103e4d:	89 44 24 04          	mov    %eax,0x4(%esp)
80103e51:	c7 04 24 87 73 10 80 	movl   $0x80107387,(%esp)
80103e58:	e8 57 c7 ff ff       	call   801005b4 <cprintf>
    if(p->state == SLEEPING){
80103e5d:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80103e61:	74 2d                	je     80103e90 <procdump+0x70>
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80103e63:	c7 04 24 1b 78 10 80 	movl   $0x8010781b,(%esp)
80103e6a:	e8 45 c7 ff ff       	call   801005b4 <cprintf>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e6f:	81 c3 98 00 00 00    	add    $0x98,%ebx
80103e75:	81 fb 54 53 11 80    	cmp    $0x80115354,%ebx
80103e7b:	74 4f                	je     80103ecc <procdump+0xac>
    if(p->state == UNUSED)
80103e7d:	8b 43 0c             	mov    0xc(%ebx),%eax
80103e80:	85 c0                	test   %eax,%eax
80103e82:	74 eb                	je     80103e6f <procdump+0x4f>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80103e84:	83 f8 05             	cmp    $0x5,%eax
80103e87:	76 ab                	jbe    80103e34 <procdump+0x14>
      state = "???";
80103e89:	b8 83 73 10 80       	mov    $0x80107383,%eax
80103e8e:	eb af                	jmp    80103e3f <procdump+0x1f>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80103e90:	8d 45 c0             	lea    -0x40(%ebp),%eax
80103e93:	89 44 24 04          	mov    %eax,0x4(%esp)
80103e97:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103e9a:	8b 40 0c             	mov    0xc(%eax),%eax
80103e9d:	83 c0 08             	add    $0x8,%eax
80103ea0:	89 04 24             	mov    %eax,(%esp)
80103ea3:	e8 8c 04 00 00       	call   80104334 <getcallerpcs>
80103ea8:	8d 7d c0             	lea    -0x40(%ebp),%edi
80103eab:	90                   	nop
      for(i=0; i<10 && pc[i] != 0; i++)
80103eac:	8b 17                	mov    (%edi),%edx
80103eae:	85 d2                	test   %edx,%edx
80103eb0:	74 b1                	je     80103e63 <procdump+0x43>
        cprintf(" %p", pc[i]);
80103eb2:	89 54 24 04          	mov    %edx,0x4(%esp)
80103eb6:	c7 04 24 a1 6d 10 80 	movl   $0x80106da1,(%esp)
80103ebd:	e8 f2 c6 ff ff       	call   801005b4 <cprintf>
80103ec2:	83 c7 04             	add    $0x4,%edi
      for(i=0; i<10 && pc[i] != 0; i++)
80103ec5:	39 f7                	cmp    %esi,%edi
80103ec7:	75 e3                	jne    80103eac <procdump+0x8c>
80103ec9:	eb 98                	jmp    80103e63 <procdump+0x43>
80103ecb:	90                   	nop
  }
}
80103ecc:	83 c4 4c             	add    $0x4c,%esp
80103ecf:	5b                   	pop    %ebx
80103ed0:	5e                   	pop    %esi
80103ed1:	5f                   	pop    %edi
80103ed2:	5d                   	pop    %ebp
80103ed3:	c3                   	ret    

80103ed4 <sys_getprocnum>:

int
sys_getprocnum(void)    //return process number
{
80103ed4:	55                   	push   %ebp
80103ed5:	89 e5                	mov    %esp,%ebp

  return procnum;
}
80103ed7:	a1 a0 a5 10 80       	mov    0x8010a5a0,%eax
80103edc:	5d                   	pop    %ebp
80103edd:	c3                   	ret    
80103ede:	66 90                	xchg   %ax,%ax

80103ee0 <sys_mempagenum>:

int
sys_mempagenum(void) //return number of memory pages
{
80103ee0:	55                   	push   %ebp
80103ee1:	89 e5                	mov    %esp,%ebp
80103ee3:	83 ec 08             	sub    $0x8,%esp
  uint sz;
  struct proc *curproc = myproc();
80103ee6:	e8 9d f3 ff ff       	call   80103288 <myproc>
  sz = curproc->sz;
  return sz/PGSIZE;   //using page size to divide this process's memory size
80103eeb:	8b 00                	mov    (%eax),%eax
80103eed:	c1 e8 0c             	shr    $0xc,%eax
}
80103ef0:	c9                   	leave  
80103ef1:	c3                   	ret    
80103ef2:	66 90                	xchg   %ax,%ax

80103ef4 <sys_getsheltime>:

int
sys_getsheltime(void)   //return scheduled time
{
80103ef4:	55                   	push   %ebp
80103ef5:	89 e5                	mov    %esp,%ebp
80103ef7:	83 ec 08             	sub    $0x8,%esp
  struct proc *p;
  p = myproc();
80103efa:	e8 89 f3 ff ff       	call   80103288 <myproc>
  return p->schetimes;
80103eff:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
}
80103f05:	c9                   	leave  
80103f06:	c3                   	ret    
80103f07:	90                   	nop

80103f08 <settickets>:

int
settickets(int t)    //initiate tickets to this process
{
80103f08:	55                   	push   %ebp
80103f09:	89 e5                	mov    %esp,%ebp
80103f0b:	56                   	push   %esi
80103f0c:	53                   	push   %ebx
80103f0d:	83 ec 10             	sub    $0x10,%esp
80103f10:	8b 75 08             	mov    0x8(%ebp),%esi
  struct proc *curproc = myproc();
80103f13:	e8 70 f3 ff ff       	call   80103288 <myproc>
80103f18:	89 c3                	mov    %eax,%ebx
    curproc->tickets = MAXTICKETS;
  }
  else{
    curproc->tickets = t;
  }*/
    acquire(&ptable.lock);
80103f1a:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103f21:	e8 ba 04 00 00       	call   801043e0 <acquire>
    curproc->stride = 0;
80103f26:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
80103f2d:	00 00 00 
    curproc->pass = 0;
80103f30:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80103f37:	00 00 00 
    curproc->tickets = t;
80103f3a:	89 b3 80 00 00 00    	mov    %esi,0x80(%ebx)
  cprintf("%d\n",t);
80103f40:	89 74 24 04          	mov    %esi,0x4(%esp)
80103f44:	c7 04 24 44 72 10 80 	movl   $0x80107244,(%esp)
80103f4b:	e8 64 c6 ff ff       	call   801005b4 <cprintf>
    release(&ptable.lock);
80103f50:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103f57:	e8 40 05 00 00       	call   8010449c <release>
  return 0;
}
80103f5c:	31 c0                	xor    %eax,%eax
80103f5e:	83 c4 10             	add    $0x10,%esp
80103f61:	5b                   	pop    %ebx
80103f62:	5e                   	pop    %esi
80103f63:	5d                   	pop    %ebp
80103f64:	c3                   	ret    
80103f65:	8d 76 00             	lea    0x0(%esi),%esi

80103f68 <setstride>:

int
setstride(int s)  //initiate strides to this process
{
80103f68:	55                   	push   %ebp
80103f69:	89 e5                	mov    %esp,%ebp
80103f6b:	56                   	push   %esi
80103f6c:	53                   	push   %ebx
80103f6d:	83 ec 10             	sub    $0x10,%esp
80103f70:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct proc *curproc = myproc();
80103f73:	e8 10 f3 ff ff       	call   80103288 <myproc>
80103f78:	89 c6                	mov    %eax,%esi
    acquire(&ptable.lock);
80103f7a:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103f81:	e8 5a 04 00 00       	call   801043e0 <acquire>

    curproc->stride = s;
80103f86:	89 9e 88 00 00 00    	mov    %ebx,0x88(%esi)
    cprintf("%d\n",curproc->stride);
80103f8c:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80103f90:	c7 04 24 44 72 10 80 	movl   $0x80107244,(%esp)
80103f97:	e8 18 c6 ff ff       	call   801005b4 <cprintf>
    curproc->tickets = 0;
80103f9c:	c7 86 80 00 00 00 00 	movl   $0x0,0x80(%esi)
80103fa3:	00 00 00 
    release(&ptable.lock);
80103fa6:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103fad:	e8 ea 04 00 00       	call   8010449c <release>
    return 0;
}
80103fb2:	31 c0                	xor    %eax,%eax
80103fb4:	83 c4 10             	add    $0x10,%esp
80103fb7:	5b                   	pop    %ebx
80103fb8:	5e                   	pop    %esi
80103fb9:	5d                   	pop    %ebp
80103fba:	c3                   	ret    
80103fbb:	90                   	nop

80103fbc <setpass>:

int
setpass(int p)  //initiate passess to this process
{
80103fbc:	55                   	push   %ebp
80103fbd:	89 e5                	mov    %esp,%ebp
80103fbf:	56                   	push   %esi
80103fc0:	53                   	push   %ebx
80103fc1:	83 ec 10             	sub    $0x10,%esp
80103fc4:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct proc *curproc = myproc();
80103fc7:	e8 bc f2 ff ff       	call   80103288 <myproc>
80103fcc:	89 c6                	mov    %eax,%esi
    acquire(&ptable.lock);
80103fce:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103fd5:	e8 06 04 00 00       	call   801043e0 <acquire>

    curproc->pass = p;
80103fda:	89 9e 8c 00 00 00    	mov    %ebx,0x8c(%esi)
    cprintf("%d\n",curproc->pass);
80103fe0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80103fe4:	c7 04 24 44 72 10 80 	movl   $0x80107244,(%esp)
80103feb:	e8 c4 c5 ff ff       	call   801005b4 <cprintf>
    curproc->tickets = 0;
80103ff0:	c7 86 80 00 00 00 00 	movl   $0x0,0x80(%esi)
80103ff7:	00 00 00 
    release(&ptable.lock);
80103ffa:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104001:	e8 96 04 00 00       	call   8010449c <release>
    return 0;
}
80104006:	31 c0                	xor    %eax,%eax
80104008:	83 c4 10             	add    $0x10,%esp
8010400b:	5b                   	pop    %ebx
8010400c:	5e                   	pop    %esi
8010400d:	5d                   	pop    %ebp
8010400e:	c3                   	ret    
8010400f:	90                   	nop

80104010 <sys_syscallnum>:

int
sys_syscallnum(void)   //return this process's system call number
{
80104010:	55                   	push   %ebp
80104011:	89 e5                	mov    %esp,%ebp
80104013:	83 ec 08             	sub    $0x8,%esp
    struct proc *curproc = myproc();
80104016:	e8 6d f2 ff ff       	call   80103288 <myproc>
    return curproc->syscallnum;
8010401b:	8b 40 7c             	mov    0x7c(%eax),%eax
}
8010401e:	c9                   	leave  
8010401f:	c3                   	ret    

80104020 <clone1>:



int
clone1(void *stack, int size)
{
80104020:	55                   	push   %ebp
80104021:	89 e5                	mov    %esp,%ebp
80104023:	57                   	push   %edi
80104024:	56                   	push   %esi
80104025:	53                   	push   %ebx
80104026:	83 ec 2c             	sub    $0x2c,%esp

    int i, pid;
    struct proc *np;
    struct proc *curproc = myproc();
80104029:	e8 5a f2 ff ff       	call   80103288 <myproc>
    // Allocate process.
    if((np = allocproc()) == 0)
8010402e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104031:	e8 6a f0 ff ff       	call   801030a0 <allocproc>
80104036:	89 c3                	mov    %eax,%ebx
80104038:	85 c0                	test   %eax,%eax
8010403a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010403d:	0f 84 cd 00 00 00    	je     80104110 <clone1+0xf0>
        return -1;

    //struct proc *procCopy = curproc;

    np->pgdir = curproc->pgdir;
80104043:	8b 42 04             	mov    0x4(%edx),%eax
80104046:	89 43 04             	mov    %eax,0x4(%ebx)
    np->sz = curproc->sz;
80104049:	8b 02                	mov    (%edx),%eax
8010404b:	89 03                	mov    %eax,(%ebx)
    np->parent = curproc;
8010404d:	89 53 14             	mov    %edx,0x14(%ebx)


    *np->tf = *curproc->tf;
80104050:	8b 72 18             	mov    0x18(%edx),%esi
80104053:	b9 13 00 00 00       	mov    $0x13,%ecx
80104058:	8b 7b 18             	mov    0x18(%ebx),%edi
8010405b:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    //Copy the current frame into the stack
    void *startCopy = (void *)curproc->tf->ebp + 16;
8010405d:	8b 42 18             	mov    0x18(%edx),%eax
    void *endCopy = (void *)curproc->tf->esp;
80104060:	8b 70 44             	mov    0x44(%eax),%esi
    void *startCopy = (void *)curproc->tf->ebp + 16;
80104063:	8b 40 08             	mov    0x8(%eax),%eax
80104066:	83 c0 10             	add    $0x10,%eax
    uint copySize = (uint) (startCopy - endCopy);
80104069:	29 f0                	sub    %esi,%eax

    np->tf->esp = (uint) (stack - copySize);//Swap to our address space
8010406b:	8b 7b 18             	mov    0x18(%ebx),%edi
8010406e:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104071:	29 c1                	sub    %eax,%ecx
80104073:	89 4d dc             	mov    %ecx,-0x24(%ebp)
80104076:	89 4f 44             	mov    %ecx,0x44(%edi)
    np->tf->ebp = (uint) (stack - 16);
80104079:	8b 7d 08             	mov    0x8(%ebp),%edi
8010407c:	83 ef 10             	sub    $0x10,%edi
8010407f:	8b 4b 18             	mov    0x18(%ebx),%ecx
80104082:	89 79 08             	mov    %edi,0x8(%ecx)

    memmove(stack - copySize, endCopy, copySize);
80104085:	89 44 24 08          	mov    %eax,0x8(%esp)
80104089:	89 74 24 04          	mov    %esi,0x4(%esp)
8010408d:	8b 7d dc             	mov    -0x24(%ebp),%edi
80104090:	89 3c 24             	mov    %edi,(%esp)
80104093:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80104096:	e8 dd 04 00 00       	call   80104578 <memmove>


    // Clear %eax so that fork returns 0 in the child.
    np->tf->eax = 0;
8010409b:	8b 43 18             	mov    0x18(%ebx),%eax
8010409e:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

    for(i = 0; i < NOFILE; i++)
801040a5:	31 f6                	xor    %esi,%esi
801040a7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801040aa:	89 d7                	mov    %edx,%edi
        if(curproc->ofile[i])
801040ac:	8b 44 b7 28          	mov    0x28(%edi,%esi,4),%eax
801040b0:	85 c0                	test   %eax,%eax
801040b2:	74 0c                	je     801040c0 <clone1+0xa0>
            np->ofile[i] = filedup(curproc->ofile[i]);
801040b4:	89 04 24             	mov    %eax,(%esp)
801040b7:	e8 40 cc ff ff       	call   80100cfc <filedup>
801040bc:	89 44 b3 28          	mov    %eax,0x28(%ebx,%esi,4)
    for(i = 0; i < NOFILE; i++)
801040c0:	46                   	inc    %esi
801040c1:	83 fe 10             	cmp    $0x10,%esi
801040c4:	75 e6                	jne    801040ac <clone1+0x8c>
    np->cwd = idup(curproc->cwd);
801040c6:	8b 47 68             	mov    0x68(%edi),%eax
801040c9:	89 04 24             	mov    %eax,(%esp)
801040cc:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801040cf:	e8 4c d4 ff ff       	call   80101520 <idup>
801040d4:	89 43 68             	mov    %eax,0x68(%ebx)
    *(np->reference_count) = *(np->reference_count) + 1;
801040d7:	8b 83 94 00 00 00    	mov    0x94(%ebx),%eax
801040dd:	ff 00                	incl   (%eax)
    pid = np->pid;
801040df:	8b 73 10             	mov    0x10(%ebx),%esi
    np->state = RUNNABLE;
801040e2:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
    safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801040e9:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
801040f0:	00 
801040f1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801040f4:	83 c2 6c             	add    $0x6c,%edx
801040f7:	89 54 24 04          	mov    %edx,0x4(%esp)
801040fb:	83 c3 6c             	add    $0x6c,%ebx
801040fe:	89 1c 24             	mov    %ebx,(%esp)
80104101:	e8 76 05 00 00       	call   8010467c <safestrcpy>
    return pid;
}
80104106:	89 f0                	mov    %esi,%eax
80104108:	83 c4 2c             	add    $0x2c,%esp
8010410b:	5b                   	pop    %ebx
8010410c:	5e                   	pop    %esi
8010410d:	5f                   	pop    %edi
8010410e:	5d                   	pop    %ebp
8010410f:	c3                   	ret    
        return -1;
80104110:	be ff ff ff ff       	mov    $0xffffffff,%esi
80104115:	eb ef                	jmp    80104106 <clone1+0xe6>
80104117:	90                   	nop

80104118 <join>:

int
join(void** stack)  //join those threads to their parent
{
80104118:	55                   	push   %ebp
80104119:	89 e5                	mov    %esp,%ebp
8010411b:	57                   	push   %edi
8010411c:	56                   	push   %esi
8010411d:	53                   	push   %ebx
8010411e:	83 ec 2c             	sub    $0x2c,%esp
80104121:	8b 7d 08             	mov    0x8(%ebp),%edi
    struct proc *curproc = myproc();
80104124:	e8 5f f1 ff ff       	call   80103288 <myproc>
80104129:	89 c6                	mov    %eax,%esi
    if ((uint) stack + sizeof(uint) > (curproc->sz)) {
8010412b:	8d 47 04             	lea    0x4(%edi),%eax
8010412e:	3b 06                	cmp    (%esi),%eax
80104130:	0f 87 e3 00 00 00    	ja     80104219 <join+0x101>
    }

    struct proc *p;
    int havekids, pid;

    acquire(&ptable.lock);
80104136:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
8010413d:	e8 9e 02 00 00       	call   801043e0 <acquire>
80104142:	66 90                	xchg   %ax,%ax
    for(;;){
        // Scan through table looking for zombie children.
        havekids = 0;
80104144:	31 c0                	xor    %eax,%eax
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104146:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
8010414b:	eb 11                	jmp    8010415e <join+0x46>
8010414d:	8d 76 00             	lea    0x0(%esi),%esi
80104150:	81 c3 98 00 00 00    	add    $0x98,%ebx
80104156:	81 fb 54 53 11 80    	cmp    $0x80115354,%ebx
8010415c:	74 26                	je     80104184 <join+0x6c>
            if(p->parent != curproc || p->pgdir != curproc->pgdir)
8010415e:	39 73 14             	cmp    %esi,0x14(%ebx)
80104161:	75 ed                	jne    80104150 <join+0x38>
80104163:	8b 56 04             	mov    0x4(%esi),%edx
80104166:	39 53 04             	cmp    %edx,0x4(%ebx)
80104169:	75 e5                	jne    80104150 <join+0x38>
                continue;
            havekids = 1;
            if(p->state == ZOMBIE){
8010416b:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010416f:	74 30                	je     801041a1 <join+0x89>
            havekids = 1;
80104171:	b8 01 00 00 00       	mov    $0x1,%eax
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104176:	81 c3 98 00 00 00    	add    $0x98,%ebx
8010417c:	81 fb 54 53 11 80    	cmp    $0x80115354,%ebx
80104182:	75 da                	jne    8010415e <join+0x46>
                return pid;
            }
        }

        // No point waiting if we don't have any children.
        if(!havekids || curproc->killed){
80104184:	85 c0                	test   %eax,%eax
80104186:	74 78                	je     80104200 <join+0xe8>
80104188:	8b 46 24             	mov    0x24(%esi),%eax
8010418b:	85 c0                	test   %eax,%eax
8010418d:	75 71                	jne    80104200 <join+0xe8>
            release(&ptable.lock);
            return -1;
        }

        // Wait for children to exit.  (See wakeup1 call in proc_exit.)
        sleep(curproc, &ptable.lock);  //DOC: wait-sleep
8010418f:	c7 44 24 04 20 2d 11 	movl   $0x80112d20,0x4(%esp)
80104196:	80 
80104197:	89 34 24             	mov    %esi,(%esp)
8010419a:	e8 dd f9 ff ff       	call   80103b7c <sleep>
    }
8010419f:	eb a3                	jmp    80104144 <join+0x2c>
                *stack = p->ustack;
801041a1:	8b 83 90 00 00 00    	mov    0x90(%ebx),%eax
801041a7:	89 07                	mov    %eax,(%edi)
                pid = p->pid;
801041a9:	8b 43 10             	mov    0x10(%ebx),%eax
                kfree(p->kstack);
801041ac:	8b 53 08             	mov    0x8(%ebx),%edx
801041af:	89 14 24             	mov    %edx,(%esp)
801041b2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801041b5:	e8 f6 de ff ff       	call   801020b0 <kfree>
                p->kstack = 0;
801041ba:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
                p->state = UNUSED;
801041c1:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
                p->pid = 0;
801041c8:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
                p->parent = 0;
801041cf:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
                p->name[0] = 0;
801041d6:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
                p->killed = 0;
801041da:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
                release(&ptable.lock);
801041e1:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801041e8:	e8 af 02 00 00       	call   8010449c <release>
                *(p->reference_count) = *(p->reference_count) - 1;
801041ed:	8b 93 94 00 00 00    	mov    0x94(%ebx),%edx
801041f3:	ff 0a                	decl   (%edx)
                return pid;
801041f5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801041f8:	83 c4 2c             	add    $0x2c,%esp
801041fb:	5b                   	pop    %ebx
801041fc:	5e                   	pop    %esi
801041fd:	5f                   	pop    %edi
801041fe:	5d                   	pop    %ebp
801041ff:	c3                   	ret    
            release(&ptable.lock);
80104200:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104207:	e8 90 02 00 00       	call   8010449c <release>
            return -1;
8010420c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104211:	83 c4 2c             	add    $0x2c,%esp
80104214:	5b                   	pop    %ebx
80104215:	5e                   	pop    %esi
80104216:	5f                   	pop    %edi
80104217:	5d                   	pop    %ebp
80104218:	c3                   	ret    
        return -1;
80104219:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010421e:	83 c4 2c             	add    $0x2c,%esp
80104221:	5b                   	pop    %ebx
80104222:	5e                   	pop    %esi
80104223:	5f                   	pop    %edi
80104224:	5d                   	pop    %ebp
80104225:	c3                   	ret    
80104226:	66 90                	xchg   %ax,%ax

80104228 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104228:	55                   	push   %ebp
80104229:	89 e5                	mov    %esp,%ebp
8010422b:	53                   	push   %ebx
8010422c:	83 ec 14             	sub    $0x14,%esp
8010422f:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80104232:	c7 44 24 04 08 75 10 	movl   $0x80107508,0x4(%esp)
80104239:	80 
8010423a:	8d 43 04             	lea    0x4(%ebx),%eax
8010423d:	89 04 24             	mov    %eax,(%esp)
80104240:	e8 d3 00 00 00       	call   80104318 <initlock>
  lk->name = name;
80104245:	8b 45 0c             	mov    0xc(%ebp),%eax
80104248:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
8010424b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104251:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
}
80104258:	83 c4 14             	add    $0x14,%esp
8010425b:	5b                   	pop    %ebx
8010425c:	5d                   	pop    %ebp
8010425d:	c3                   	ret    
8010425e:	66 90                	xchg   %ax,%ax

80104260 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104260:	55                   	push   %ebp
80104261:	89 e5                	mov    %esp,%ebp
80104263:	56                   	push   %esi
80104264:	53                   	push   %ebx
80104265:	83 ec 10             	sub    $0x10,%esp
80104268:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
8010426b:	8d 73 04             	lea    0x4(%ebx),%esi
8010426e:	89 34 24             	mov    %esi,(%esp)
80104271:	e8 6a 01 00 00       	call   801043e0 <acquire>
  while (lk->locked) {
80104276:	8b 13                	mov    (%ebx),%edx
80104278:	85 d2                	test   %edx,%edx
8010427a:	74 12                	je     8010428e <acquiresleep+0x2e>
    sleep(lk, &lk->lk);
8010427c:	89 74 24 04          	mov    %esi,0x4(%esp)
80104280:	89 1c 24             	mov    %ebx,(%esp)
80104283:	e8 f4 f8 ff ff       	call   80103b7c <sleep>
  while (lk->locked) {
80104288:	8b 03                	mov    (%ebx),%eax
8010428a:	85 c0                	test   %eax,%eax
8010428c:	75 ee                	jne    8010427c <acquiresleep+0x1c>
  }
  lk->locked = 1;
8010428e:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104294:	e8 ef ef ff ff       	call   80103288 <myproc>
80104299:	8b 40 10             	mov    0x10(%eax),%eax
8010429c:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
8010429f:	89 75 08             	mov    %esi,0x8(%ebp)
}
801042a2:	83 c4 10             	add    $0x10,%esp
801042a5:	5b                   	pop    %ebx
801042a6:	5e                   	pop    %esi
801042a7:	5d                   	pop    %ebp
  release(&lk->lk);
801042a8:	e9 ef 01 00 00       	jmp    8010449c <release>
801042ad:	8d 76 00             	lea    0x0(%esi),%esi

801042b0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801042b0:	55                   	push   %ebp
801042b1:	89 e5                	mov    %esp,%ebp
801042b3:	56                   	push   %esi
801042b4:	53                   	push   %ebx
801042b5:	83 ec 10             	sub    $0x10,%esp
801042b8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801042bb:	8d 73 04             	lea    0x4(%ebx),%esi
801042be:	89 34 24             	mov    %esi,(%esp)
801042c1:	e8 1a 01 00 00       	call   801043e0 <acquire>
  lk->locked = 0;
801042c6:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801042cc:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801042d3:	89 1c 24             	mov    %ebx,(%esp)
801042d6:	e8 6d fa ff ff       	call   80103d48 <wakeup>
  release(&lk->lk);
801042db:	89 75 08             	mov    %esi,0x8(%ebp)
}
801042de:	83 c4 10             	add    $0x10,%esp
801042e1:	5b                   	pop    %ebx
801042e2:	5e                   	pop    %esi
801042e3:	5d                   	pop    %ebp
  release(&lk->lk);
801042e4:	e9 b3 01 00 00       	jmp    8010449c <release>
801042e9:	8d 76 00             	lea    0x0(%esi),%esi

801042ec <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
801042ec:	55                   	push   %ebp
801042ed:	89 e5                	mov    %esp,%ebp
801042ef:	56                   	push   %esi
801042f0:	53                   	push   %ebx
801042f1:	83 ec 10             	sub    $0x10,%esp
801042f4:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
801042f7:	8d 73 04             	lea    0x4(%ebx),%esi
801042fa:	89 34 24             	mov    %esi,(%esp)
801042fd:	e8 de 00 00 00       	call   801043e0 <acquire>
  r = lk->locked;
80104302:	8b 1b                	mov    (%ebx),%ebx
  release(&lk->lk);
80104304:	89 34 24             	mov    %esi,(%esp)
80104307:	e8 90 01 00 00       	call   8010449c <release>
  return r;
}
8010430c:	89 d8                	mov    %ebx,%eax
8010430e:	83 c4 10             	add    $0x10,%esp
80104311:	5b                   	pop    %ebx
80104312:	5e                   	pop    %esi
80104313:	5d                   	pop    %ebp
80104314:	c3                   	ret    
80104315:	66 90                	xchg   %ax,%ax
80104317:	90                   	nop

80104318 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104318:	55                   	push   %ebp
80104319:	89 e5                	mov    %esp,%ebp
8010431b:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
8010431e:	8b 55 0c             	mov    0xc(%ebp),%edx
80104321:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
80104324:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
8010432a:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104331:	5d                   	pop    %ebp
80104332:	c3                   	ret    
80104333:	90                   	nop

80104334 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104334:	55                   	push   %ebp
80104335:	89 e5                	mov    %esp,%ebp
80104337:	53                   	push   %ebx
80104338:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
8010433b:	8b 55 08             	mov    0x8(%ebp),%edx
8010433e:	83 ea 08             	sub    $0x8,%edx
  for(i = 0; i < 10; i++){
80104341:	31 c0                	xor    %eax,%eax
80104343:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104344:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
8010434a:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104350:	77 12                	ja     80104364 <getcallerpcs+0x30>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104352:	8b 5a 04             	mov    0x4(%edx),%ebx
80104355:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
    ebp = (uint*)ebp[0]; // saved %ebp
80104358:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
8010435a:	40                   	inc    %eax
8010435b:	83 f8 0a             	cmp    $0xa,%eax
8010435e:	75 e4                	jne    80104344 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80104360:	5b                   	pop    %ebx
80104361:	5d                   	pop    %ebp
80104362:	c3                   	ret    
80104363:	90                   	nop
    pcs[i] = 0;
80104364:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
  for(; i < 10; i++)
8010436b:	40                   	inc    %eax
8010436c:	83 f8 0a             	cmp    $0xa,%eax
8010436f:	74 ef                	je     80104360 <getcallerpcs+0x2c>
    pcs[i] = 0;
80104371:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
  for(; i < 10; i++)
80104378:	40                   	inc    %eax
80104379:	83 f8 0a             	cmp    $0xa,%eax
8010437c:	75 e6                	jne    80104364 <getcallerpcs+0x30>
8010437e:	eb e0                	jmp    80104360 <getcallerpcs+0x2c>

80104380 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104380:	55                   	push   %ebp
80104381:	89 e5                	mov    %esp,%ebp
80104383:	53                   	push   %ebx
80104384:	51                   	push   %ecx
80104385:	8b 45 08             	mov    0x8(%ebp),%eax
  return lock->locked && lock->cpu == mycpu();
80104388:	8b 18                	mov    (%eax),%ebx
8010438a:	85 db                	test   %ebx,%ebx
8010438c:	75 06                	jne    80104394 <holding+0x14>
8010438e:	31 c0                	xor    %eax,%eax
}
80104390:	5a                   	pop    %edx
80104391:	5b                   	pop    %ebx
80104392:	5d                   	pop    %ebp
80104393:	c3                   	ret    
  return lock->locked && lock->cpu == mycpu();
80104394:	8b 58 08             	mov    0x8(%eax),%ebx
80104397:	e8 44 ee ff ff       	call   801031e0 <mycpu>
8010439c:	39 c3                	cmp    %eax,%ebx
8010439e:	0f 94 c0             	sete   %al
801043a1:	0f b6 c0             	movzbl %al,%eax
}
801043a4:	5a                   	pop    %edx
801043a5:	5b                   	pop    %ebx
801043a6:	5d                   	pop    %ebp
801043a7:	c3                   	ret    

801043a8 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801043a8:	55                   	push   %ebp
801043a9:	89 e5                	mov    %esp,%ebp
801043ab:	53                   	push   %ebx
801043ac:	50                   	push   %eax
801043ad:	9c                   	pushf  
801043ae:	5b                   	pop    %ebx
  asm volatile("cli");
801043af:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801043b0:	e8 2b ee ff ff       	call   801031e0 <mycpu>
801043b5:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801043bb:	85 c0                	test   %eax,%eax
801043bd:	75 11                	jne    801043d0 <pushcli+0x28>
    mycpu()->intena = eflags & FL_IF;
801043bf:	e8 1c ee ff ff       	call   801031e0 <mycpu>
801043c4:	81 e3 00 02 00 00    	and    $0x200,%ebx
801043ca:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
801043d0:	e8 0b ee ff ff       	call   801031e0 <mycpu>
801043d5:	ff 80 a4 00 00 00    	incl   0xa4(%eax)
}
801043db:	58                   	pop    %eax
801043dc:	5b                   	pop    %ebx
801043dd:	5d                   	pop    %ebp
801043de:	c3                   	ret    
801043df:	90                   	nop

801043e0 <acquire>:
{
801043e0:	55                   	push   %ebp
801043e1:	89 e5                	mov    %esp,%ebp
801043e3:	53                   	push   %ebx
801043e4:	83 ec 14             	sub    $0x14,%esp
  pushcli(); // disable interrupts to avoid deadlock.
801043e7:	e8 bc ff ff ff       	call   801043a8 <pushcli>
  if(holding(lk))
801043ec:	8b 45 08             	mov    0x8(%ebp),%eax
801043ef:	89 04 24             	mov    %eax,(%esp)
801043f2:	e8 89 ff ff ff       	call   80104380 <holding>
801043f7:	85 c0                	test   %eax,%eax
801043f9:	75 3c                	jne    80104437 <acquire+0x57>
  asm volatile("lock; xchgl %0, %1" :
801043fb:	b9 01 00 00 00       	mov    $0x1,%ecx
  while(xchg(&lk->locked, 1) != 0)
80104400:	8b 55 08             	mov    0x8(%ebp),%edx
80104403:	89 c8                	mov    %ecx,%eax
80104405:	f0 87 02             	lock xchg %eax,(%edx)
80104408:	85 c0                	test   %eax,%eax
8010440a:	75 f4                	jne    80104400 <acquire+0x20>
  __sync_synchronize();
8010440c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104411:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104414:	e8 c7 ed ff ff       	call   801031e0 <mycpu>
80104419:	89 43 08             	mov    %eax,0x8(%ebx)
  getcallerpcs(&lk, lk->pcs);
8010441c:	8b 45 08             	mov    0x8(%ebp),%eax
8010441f:	83 c0 0c             	add    $0xc,%eax
80104422:	89 44 24 04          	mov    %eax,0x4(%esp)
80104426:	8d 45 08             	lea    0x8(%ebp),%eax
80104429:	89 04 24             	mov    %eax,(%esp)
8010442c:	e8 03 ff ff ff       	call   80104334 <getcallerpcs>
}
80104431:	83 c4 14             	add    $0x14,%esp
80104434:	5b                   	pop    %ebx
80104435:	5d                   	pop    %ebp
80104436:	c3                   	ret    
    panic("acquire");
80104437:	c7 04 24 13 75 10 80 	movl   $0x80107513,(%esp)
8010443e:	e8 cd be ff ff       	call   80100310 <panic>
80104443:	90                   	nop

80104444 <popcli>:

void
popcli(void)
{
80104444:	55                   	push   %ebp
80104445:	89 e5                	mov    %esp,%ebp
80104447:	83 ec 18             	sub    $0x18,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
8010444a:	9c                   	pushf  
8010444b:	58                   	pop    %eax
  if(readeflags()&FL_IF)
8010444c:	f6 c4 02             	test   $0x2,%ah
8010444f:	75 3d                	jne    8010448e <popcli+0x4a>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80104451:	e8 8a ed ff ff       	call   801031e0 <mycpu>
80104456:	ff 88 a4 00 00 00    	decl   0xa4(%eax)
8010445c:	78 24                	js     80104482 <popcli+0x3e>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010445e:	e8 7d ed ff ff       	call   801031e0 <mycpu>
80104463:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104469:	85 c0                	test   %eax,%eax
8010446b:	74 03                	je     80104470 <popcli+0x2c>
    sti();
}
8010446d:	c9                   	leave  
8010446e:	c3                   	ret    
8010446f:	90                   	nop
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104470:	e8 6b ed ff ff       	call   801031e0 <mycpu>
80104475:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010447b:	85 c0                	test   %eax,%eax
8010447d:	74 ee                	je     8010446d <popcli+0x29>
  asm volatile("sti");
8010447f:	fb                   	sti    
}
80104480:	c9                   	leave  
80104481:	c3                   	ret    
    panic("popcli");
80104482:	c7 04 24 32 75 10 80 	movl   $0x80107532,(%esp)
80104489:	e8 82 be ff ff       	call   80100310 <panic>
    panic("popcli - interruptible");
8010448e:	c7 04 24 1b 75 10 80 	movl   $0x8010751b,(%esp)
80104495:	e8 76 be ff ff       	call   80100310 <panic>
8010449a:	66 90                	xchg   %ax,%ax

8010449c <release>:
{
8010449c:	55                   	push   %ebp
8010449d:	89 e5                	mov    %esp,%ebp
8010449f:	53                   	push   %ebx
801044a0:	83 ec 14             	sub    $0x14,%esp
801044a3:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
801044a6:	89 1c 24             	mov    %ebx,(%esp)
801044a9:	e8 d2 fe ff ff       	call   80104380 <holding>
801044ae:	85 c0                	test   %eax,%eax
801044b0:	74 23                	je     801044d5 <release+0x39>
  lk->pcs[0] = 0;
801044b2:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
801044b9:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
801044c0:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
801044c5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
801044cb:	83 c4 14             	add    $0x14,%esp
801044ce:	5b                   	pop    %ebx
801044cf:	5d                   	pop    %ebp
  popcli();
801044d0:	e9 6f ff ff ff       	jmp    80104444 <popcli>
    panic("release");
801044d5:	c7 04 24 39 75 10 80 	movl   $0x80107539,(%esp)
801044dc:	e8 2f be ff ff       	call   80100310 <panic>
801044e1:	66 90                	xchg   %ax,%ax
801044e3:	90                   	nop

801044e4 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801044e4:	55                   	push   %ebp
801044e5:	89 e5                	mov    %esp,%ebp
801044e7:	57                   	push   %edi
801044e8:	53                   	push   %ebx
801044e9:	8b 55 08             	mov    0x8(%ebp),%edx
  if ((int)dst%4 == 0 && n%4 == 0){
801044ec:	f6 c2 03             	test   $0x3,%dl
801044ef:	75 06                	jne    801044f7 <memset+0x13>
801044f1:	f6 45 10 03          	testb  $0x3,0x10(%ebp)
801044f5:	74 11                	je     80104508 <memset+0x24>
  asm volatile("cld; rep stosb" :
801044f7:	89 d7                	mov    %edx,%edi
801044f9:	8b 4d 10             	mov    0x10(%ebp),%ecx
801044fc:	8b 45 0c             	mov    0xc(%ebp),%eax
801044ff:	fc                   	cld    
80104500:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80104502:	89 d0                	mov    %edx,%eax
80104504:	5b                   	pop    %ebx
80104505:	5f                   	pop    %edi
80104506:	5d                   	pop    %ebp
80104507:	c3                   	ret    
    c &= 0xFF;
80104508:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010450c:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010450f:	c1 e9 02             	shr    $0x2,%ecx
80104512:	89 f8                	mov    %edi,%eax
80104514:	c1 e0 18             	shl    $0x18,%eax
80104517:	89 fb                	mov    %edi,%ebx
80104519:	c1 e3 10             	shl    $0x10,%ebx
8010451c:	09 d8                	or     %ebx,%eax
8010451e:	09 f8                	or     %edi,%eax
80104520:	c1 e7 08             	shl    $0x8,%edi
80104523:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104525:	89 d7                	mov    %edx,%edi
80104527:	fc                   	cld    
80104528:	f3 ab                	rep stos %eax,%es:(%edi)
}
8010452a:	89 d0                	mov    %edx,%eax
8010452c:	5b                   	pop    %ebx
8010452d:	5f                   	pop    %edi
8010452e:	5d                   	pop    %ebp
8010452f:	c3                   	ret    

80104530 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104530:	55                   	push   %ebp
80104531:	89 e5                	mov    %esp,%ebp
80104533:	57                   	push   %edi
80104534:	56                   	push   %esi
80104535:	53                   	push   %ebx
80104536:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104539:	8b 75 0c             	mov    0xc(%ebp),%esi
8010453c:	8b 45 10             	mov    0x10(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010453f:	8d 78 ff             	lea    -0x1(%eax),%edi
80104542:	85 c0                	test   %eax,%eax
80104544:	74 20                	je     80104566 <memcmp+0x36>
    if(*s1 != *s2)
80104546:	0f b6 03             	movzbl (%ebx),%eax
80104549:	0f b6 0e             	movzbl (%esi),%ecx
8010454c:	38 c8                	cmp    %cl,%al
8010454e:	75 20                	jne    80104570 <memcmp+0x40>
80104550:	31 d2                	xor    %edx,%edx
80104552:	eb 0e                	jmp    80104562 <memcmp+0x32>
80104554:	0f b6 44 13 01       	movzbl 0x1(%ebx,%edx,1),%eax
80104559:	42                   	inc    %edx
8010455a:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
8010455e:	38 c8                	cmp    %cl,%al
80104560:	75 0e                	jne    80104570 <memcmp+0x40>
  while(n-- > 0){
80104562:	39 d7                	cmp    %edx,%edi
80104564:	75 ee                	jne    80104554 <memcmp+0x24>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
80104566:	31 c0                	xor    %eax,%eax
}
80104568:	5b                   	pop    %ebx
80104569:	5e                   	pop    %esi
8010456a:	5f                   	pop    %edi
8010456b:	5d                   	pop    %ebp
8010456c:	c3                   	ret    
8010456d:	8d 76 00             	lea    0x0(%esi),%esi
      return *s1 - *s2;
80104570:	29 c8                	sub    %ecx,%eax
}
80104572:	5b                   	pop    %ebx
80104573:	5e                   	pop    %esi
80104574:	5f                   	pop    %edi
80104575:	5d                   	pop    %ebp
80104576:	c3                   	ret    
80104577:	90                   	nop

80104578 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104578:	55                   	push   %ebp
80104579:	89 e5                	mov    %esp,%ebp
8010457b:	57                   	push   %edi
8010457c:	56                   	push   %esi
8010457d:	53                   	push   %ebx
8010457e:	8b 45 08             	mov    0x8(%ebp),%eax
80104581:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104584:	39 c3                	cmp    %eax,%ebx
80104586:	73 38                	jae    801045c0 <memmove+0x48>
80104588:	8b 75 10             	mov    0x10(%ebp),%esi
8010458b:	01 de                	add    %ebx,%esi
8010458d:	39 f0                	cmp    %esi,%eax
8010458f:	73 2f                	jae    801045c0 <memmove+0x48>
    s += n;
    d += n;
80104591:	8b 7d 10             	mov    0x10(%ebp),%edi
80104594:	01 c7                	add    %eax,%edi
    while(n-- > 0)
80104596:	8b 55 10             	mov    0x10(%ebp),%edx
80104599:	4a                   	dec    %edx
8010459a:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010459d:	85 c9                	test   %ecx,%ecx
8010459f:	74 17                	je     801045b8 <memmove+0x40>
memmove(void *dst, const void *src, uint n)
801045a1:	8b 4d 10             	mov    0x10(%ebp),%ecx
801045a4:	f7 d9                	neg    %ecx
801045a6:	8d 1c 0e             	lea    (%esi,%ecx,1),%ebx
801045a9:	01 cf                	add    %ecx,%edi
801045ab:	90                   	nop
      *--d = *--s;
801045ac:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
801045af:	88 0c 17             	mov    %cl,(%edi,%edx,1)
    while(n-- > 0)
801045b2:	4a                   	dec    %edx
801045b3:	83 fa ff             	cmp    $0xffffffff,%edx
801045b6:	75 f4                	jne    801045ac <memmove+0x34>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
801045b8:	5b                   	pop    %ebx
801045b9:	5e                   	pop    %esi
801045ba:	5f                   	pop    %edi
801045bb:	5d                   	pop    %ebp
801045bc:	c3                   	ret    
801045bd:	8d 76 00             	lea    0x0(%esi),%esi
    while(n-- > 0)
801045c0:	31 d2                	xor    %edx,%edx
801045c2:	8b 75 10             	mov    0x10(%ebp),%esi
801045c5:	85 f6                	test   %esi,%esi
801045c7:	74 ef                	je     801045b8 <memmove+0x40>
801045c9:	8d 76 00             	lea    0x0(%esi),%esi
      *d++ = *s++;
801045cc:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
801045cf:	88 0c 10             	mov    %cl,(%eax,%edx,1)
801045d2:	42                   	inc    %edx
    while(n-- > 0)
801045d3:	3b 55 10             	cmp    0x10(%ebp),%edx
801045d6:	75 f4                	jne    801045cc <memmove+0x54>
}
801045d8:	5b                   	pop    %ebx
801045d9:	5e                   	pop    %esi
801045da:	5f                   	pop    %edi
801045db:	5d                   	pop    %ebp
801045dc:	c3                   	ret    
801045dd:	8d 76 00             	lea    0x0(%esi),%esi

801045e0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
801045e0:	55                   	push   %ebp
801045e1:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
801045e3:	5d                   	pop    %ebp
  return memmove(dst, src, n);
801045e4:	eb 92                	jmp    80104578 <memmove>
801045e6:	66 90                	xchg   %ax,%ax

801045e8 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
801045e8:	55                   	push   %ebp
801045e9:	89 e5                	mov    %esp,%ebp
801045eb:	57                   	push   %edi
801045ec:	56                   	push   %esi
801045ed:	53                   	push   %ebx
801045ee:	8b 4d 08             	mov    0x8(%ebp),%ecx
801045f1:	8b 75 0c             	mov    0xc(%ebp),%esi
801045f4:	8b 7d 10             	mov    0x10(%ebp),%edi
  while(n > 0 && *p && *p == *q)
801045f7:	85 ff                	test   %edi,%edi
801045f9:	74 2d                	je     80104628 <strncmp+0x40>
801045fb:	0f b6 01             	movzbl (%ecx),%eax
801045fe:	0f b6 1e             	movzbl (%esi),%ebx
80104601:	84 c0                	test   %al,%al
80104603:	74 2f                	je     80104634 <strncmp+0x4c>
80104605:	38 d8                	cmp    %bl,%al
80104607:	75 2b                	jne    80104634 <strncmp+0x4c>
strncmp(const char *p, const char *q, uint n)
80104609:	8d 51 01             	lea    0x1(%ecx),%edx
8010460c:	01 cf                	add    %ecx,%edi
8010460e:	eb 11                	jmp    80104621 <strncmp+0x39>
  while(n > 0 && *p && *p == *q)
80104610:	0f b6 02             	movzbl (%edx),%eax
80104613:	84 c0                	test   %al,%al
80104615:	74 19                	je     80104630 <strncmp+0x48>
80104617:	0f b6 19             	movzbl (%ecx),%ebx
8010461a:	42                   	inc    %edx
    n--, p++, q++;
8010461b:	89 ce                	mov    %ecx,%esi
  while(n > 0 && *p && *p == *q)
8010461d:	38 d8                	cmp    %bl,%al
8010461f:	75 13                	jne    80104634 <strncmp+0x4c>
    n--, p++, q++;
80104621:	8d 4e 01             	lea    0x1(%esi),%ecx
  while(n > 0 && *p && *p == *q)
80104624:	39 fa                	cmp    %edi,%edx
80104626:	75 e8                	jne    80104610 <strncmp+0x28>
  if(n == 0)
    return 0;
80104628:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
8010462a:	5b                   	pop    %ebx
8010462b:	5e                   	pop    %esi
8010462c:	5f                   	pop    %edi
8010462d:	5d                   	pop    %ebp
8010462e:	c3                   	ret    
8010462f:	90                   	nop
80104630:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
80104634:	29 d8                	sub    %ebx,%eax
}
80104636:	5b                   	pop    %ebx
80104637:	5e                   	pop    %esi
80104638:	5f                   	pop    %edi
80104639:	5d                   	pop    %ebp
8010463a:	c3                   	ret    
8010463b:	90                   	nop

8010463c <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
8010463c:	55                   	push   %ebp
8010463d:	89 e5                	mov    %esp,%ebp
8010463f:	57                   	push   %edi
80104640:	56                   	push   %esi
80104641:	53                   	push   %ebx
80104642:	8b 7d 08             	mov    0x8(%ebp),%edi
80104645:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104648:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010464b:	89 fa                	mov    %edi,%edx
8010464d:	eb 0b                	jmp    8010465a <strncpy+0x1e>
8010464f:	90                   	nop
80104650:	8a 03                	mov    (%ebx),%al
80104652:	88 02                	mov    %al,(%edx)
80104654:	42                   	inc    %edx
80104655:	43                   	inc    %ebx
80104656:	84 c0                	test   %al,%al
80104658:	74 08                	je     80104662 <strncpy+0x26>
8010465a:	49                   	dec    %ecx
strncpy(char *s, const char *t, int n)
8010465b:	8d 71 01             	lea    0x1(%ecx),%esi
  while(n-- > 0 && (*s++ = *t++) != 0)
8010465e:	85 f6                	test   %esi,%esi
80104660:	7f ee                	jg     80104650 <strncpy+0x14>
strncpy(char *s, const char *t, int n)
80104662:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    ;
  while(n-- > 0)
80104665:	85 c9                	test   %ecx,%ecx
80104667:	7e 0b                	jle    80104674 <strncpy+0x38>
80104669:	8d 76 00             	lea    0x0(%esi),%esi
    *s++ = 0;
8010466c:	c6 02 00             	movb   $0x0,(%edx)
8010466f:	42                   	inc    %edx
  while(n-- > 0)
80104670:	39 c2                	cmp    %eax,%edx
80104672:	75 f8                	jne    8010466c <strncpy+0x30>
  return os;
}
80104674:	89 f8                	mov    %edi,%eax
80104676:	5b                   	pop    %ebx
80104677:	5e                   	pop    %esi
80104678:	5f                   	pop    %edi
80104679:	5d                   	pop    %ebp
8010467a:	c3                   	ret    
8010467b:	90                   	nop

8010467c <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
8010467c:	55                   	push   %ebp
8010467d:	89 e5                	mov    %esp,%ebp
8010467f:	56                   	push   %esi
80104680:	53                   	push   %ebx
80104681:	8b 45 08             	mov    0x8(%ebp),%eax
80104684:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104687:	8b 55 10             	mov    0x10(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
8010468a:	85 d2                	test   %edx,%edx
8010468c:	7e 17                	jle    801046a5 <safestrcpy+0x29>
safestrcpy(char *s, const char *t, int n)
8010468e:	8d 74 10 ff          	lea    -0x1(%eax,%edx,1),%esi
80104692:	89 c2                	mov    %eax,%edx
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104694:	39 f2                	cmp    %esi,%edx
80104696:	74 0a                	je     801046a2 <safestrcpy+0x26>
80104698:	8a 19                	mov    (%ecx),%bl
8010469a:	88 1a                	mov    %bl,(%edx)
8010469c:	42                   	inc    %edx
8010469d:	41                   	inc    %ecx
8010469e:	84 db                	test   %bl,%bl
801046a0:	75 f2                	jne    80104694 <safestrcpy+0x18>
    ;
  *s = 0;
801046a2:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
801046a5:	5b                   	pop    %ebx
801046a6:	5e                   	pop    %esi
801046a7:	5d                   	pop    %ebp
801046a8:	c3                   	ret    
801046a9:	8d 76 00             	lea    0x0(%esi),%esi

801046ac <strlen>:

int
strlen(const char *s)
{
801046ac:	55                   	push   %ebp
801046ad:	89 e5                	mov    %esp,%ebp
801046af:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
801046b2:	31 c0                	xor    %eax,%eax
801046b4:	80 3a 00             	cmpb   $0x0,(%edx)
801046b7:	74 0a                	je     801046c3 <strlen+0x17>
801046b9:	8d 76 00             	lea    0x0(%esi),%esi
801046bc:	40                   	inc    %eax
801046bd:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801046c1:	75 f9                	jne    801046bc <strlen+0x10>
    ;
  return n;
}
801046c3:	5d                   	pop    %ebp
801046c4:	c3                   	ret    

801046c5 <swtch>:
801046c5:	8b 44 24 04          	mov    0x4(%esp),%eax
801046c9:	8b 54 24 08          	mov    0x8(%esp),%edx
801046cd:	55                   	push   %ebp
801046ce:	53                   	push   %ebx
801046cf:	56                   	push   %esi
801046d0:	57                   	push   %edi
801046d1:	89 20                	mov    %esp,(%eax)
801046d3:	89 d4                	mov    %edx,%esp
801046d5:	5f                   	pop    %edi
801046d6:	5e                   	pop    %esi
801046d7:	5b                   	pop    %ebx
801046d8:	5d                   	pop    %ebp
801046d9:	c3                   	ret    
801046da:	66 90                	xchg   %ax,%ax

801046dc <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801046dc:	55                   	push   %ebp
801046dd:	89 e5                	mov    %esp,%ebp
801046df:	53                   	push   %ebx
801046e0:	51                   	push   %ecx
801046e1:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801046e4:	e8 9f eb ff ff       	call   80103288 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801046e9:	8b 00                	mov    (%eax),%eax
801046eb:	39 d8                	cmp    %ebx,%eax
801046ed:	76 15                	jbe    80104704 <fetchint+0x28>
801046ef:	8d 53 04             	lea    0x4(%ebx),%edx
801046f2:	39 d0                	cmp    %edx,%eax
801046f4:	72 0e                	jb     80104704 <fetchint+0x28>
    return -1;
  *ip = *(int*)(addr);
801046f6:	8b 13                	mov    (%ebx),%edx
801046f8:	8b 45 0c             	mov    0xc(%ebp),%eax
801046fb:	89 10                	mov    %edx,(%eax)
  return 0;
801046fd:	31 c0                	xor    %eax,%eax
}
801046ff:	5a                   	pop    %edx
80104700:	5b                   	pop    %ebx
80104701:	5d                   	pop    %ebp
80104702:	c3                   	ret    
80104703:	90                   	nop
    return -1;
80104704:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104709:	eb f4                	jmp    801046ff <fetchint+0x23>
8010470b:	90                   	nop

8010470c <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
8010470c:	55                   	push   %ebp
8010470d:	89 e5                	mov    %esp,%ebp
8010470f:	53                   	push   %ebx
80104710:	50                   	push   %eax
80104711:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104714:	e8 6f eb ff ff       	call   80103288 <myproc>

  if(addr >= curproc->sz)
80104719:	39 18                	cmp    %ebx,(%eax)
8010471b:	76 21                	jbe    8010473e <fetchstr+0x32>
    return -1;
  *pp = (char*)addr;
8010471d:	89 da                	mov    %ebx,%edx
8010471f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104722:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
80104724:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
80104726:	39 c3                	cmp    %eax,%ebx
80104728:	73 14                	jae    8010473e <fetchstr+0x32>
    if(*s == 0)
8010472a:	80 3b 00             	cmpb   $0x0,(%ebx)
8010472d:	75 0a                	jne    80104739 <fetchstr+0x2d>
8010472f:	eb 17                	jmp    80104748 <fetchstr+0x3c>
80104731:	8d 76 00             	lea    0x0(%esi),%esi
80104734:	80 3a 00             	cmpb   $0x0,(%edx)
80104737:	74 0f                	je     80104748 <fetchstr+0x3c>
  for(s = *pp; s < ep; s++){
80104739:	42                   	inc    %edx
8010473a:	39 d0                	cmp    %edx,%eax
8010473c:	77 f6                	ja     80104734 <fetchstr+0x28>
    return -1;
8010473e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80104743:	5b                   	pop    %ebx
80104744:	5b                   	pop    %ebx
80104745:	5d                   	pop    %ebp
80104746:	c3                   	ret    
80104747:	90                   	nop
      return s - *pp;
80104748:	89 d0                	mov    %edx,%eax
8010474a:	29 d8                	sub    %ebx,%eax
}
8010474c:	5b                   	pop    %ebx
8010474d:	5b                   	pop    %ebx
8010474e:	5d                   	pop    %ebp
8010474f:	c3                   	ret    

80104750 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104750:	55                   	push   %ebp
80104751:	89 e5                	mov    %esp,%ebp
80104753:	56                   	push   %esi
80104754:	53                   	push   %ebx
80104755:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104758:	8b 75 0c             	mov    0xc(%ebp),%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010475b:	e8 28 eb ff ff       	call   80103288 <myproc>
80104760:	89 75 0c             	mov    %esi,0xc(%ebp)
80104763:	8b 40 18             	mov    0x18(%eax),%eax
80104766:	8b 40 44             	mov    0x44(%eax),%eax
80104769:	8d 44 98 04          	lea    0x4(%eax,%ebx,4),%eax
8010476d:	89 45 08             	mov    %eax,0x8(%ebp)
}
80104770:	5b                   	pop    %ebx
80104771:	5e                   	pop    %esi
80104772:	5d                   	pop    %ebp
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104773:	e9 64 ff ff ff       	jmp    801046dc <fetchint>

80104778 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104778:	55                   	push   %ebp
80104779:	89 e5                	mov    %esp,%ebp
8010477b:	56                   	push   %esi
8010477c:	53                   	push   %ebx
8010477d:	83 ec 20             	sub    $0x20,%esp
80104780:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80104783:	e8 00 eb ff ff       	call   80103288 <myproc>
80104788:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
8010478a:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010478d:	89 44 24 04          	mov    %eax,0x4(%esp)
80104791:	8b 45 08             	mov    0x8(%ebp),%eax
80104794:	89 04 24             	mov    %eax,(%esp)
80104797:	e8 b4 ff ff ff       	call   80104750 <argint>
8010479c:	85 c0                	test   %eax,%eax
8010479e:	78 24                	js     801047c4 <argptr+0x4c>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801047a0:	85 db                	test   %ebx,%ebx
801047a2:	78 20                	js     801047c4 <argptr+0x4c>
801047a4:	8b 55 f4             	mov    -0xc(%ebp),%edx
801047a7:	8b 06                	mov    (%esi),%eax
801047a9:	39 c2                	cmp    %eax,%edx
801047ab:	73 17                	jae    801047c4 <argptr+0x4c>
801047ad:	01 d3                	add    %edx,%ebx
801047af:	39 d8                	cmp    %ebx,%eax
801047b1:	72 11                	jb     801047c4 <argptr+0x4c>
    return -1;
  *pp = (char*)i;
801047b3:	8b 45 0c             	mov    0xc(%ebp),%eax
801047b6:	89 10                	mov    %edx,(%eax)
  return 0;
801047b8:	31 c0                	xor    %eax,%eax
}
801047ba:	83 c4 20             	add    $0x20,%esp
801047bd:	5b                   	pop    %ebx
801047be:	5e                   	pop    %esi
801047bf:	5d                   	pop    %ebp
801047c0:	c3                   	ret    
801047c1:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801047c4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801047c9:	83 c4 20             	add    $0x20,%esp
801047cc:	5b                   	pop    %ebx
801047cd:	5e                   	pop    %esi
801047ce:	5d                   	pop    %ebp
801047cf:	c3                   	ret    

801047d0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801047d0:	55                   	push   %ebp
801047d1:	89 e5                	mov    %esp,%ebp
801047d3:	83 ec 28             	sub    $0x28,%esp
  int addr;
  if(argint(n, &addr) < 0)
801047d6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801047d9:	89 44 24 04          	mov    %eax,0x4(%esp)
801047dd:	8b 45 08             	mov    0x8(%ebp),%eax
801047e0:	89 04 24             	mov    %eax,(%esp)
801047e3:	e8 68 ff ff ff       	call   80104750 <argint>
801047e8:	85 c0                	test   %eax,%eax
801047ea:	78 14                	js     80104800 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
801047ec:	8b 45 0c             	mov    0xc(%ebp),%eax
801047ef:	89 44 24 04          	mov    %eax,0x4(%esp)
801047f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801047f6:	89 04 24             	mov    %eax,(%esp)
801047f9:	e8 0e ff ff ff       	call   8010470c <fetchstr>
}
801047fe:	c9                   	leave  
801047ff:	c3                   	ret    
    return -1;
80104800:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104805:	c9                   	leave  
80104806:	c3                   	ret    
80104807:	90                   	nop

80104808 <syscall>:
};


void
syscall(void)
{
80104808:	55                   	push   %ebp
80104809:	89 e5                	mov    %esp,%ebp
8010480b:	53                   	push   %ebx
8010480c:	83 ec 24             	sub    $0x24,%esp
  int num;
  struct proc *curproc = myproc();
8010480f:	e8 74 ea ff ff       	call   80103288 <myproc>
  (curproc->syscallnum) ++;  //to count the number of system calls
80104814:	ff 40 7c             	incl   0x7c(%eax)
  num = curproc->tf->eax;
80104817:	8b 58 18             	mov    0x18(%eax),%ebx
8010481a:	8b 53 1c             	mov    0x1c(%ebx),%edx
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
8010481d:	8d 4a ff             	lea    -0x1(%edx),%ecx
80104820:	83 f9 1d             	cmp    $0x1d,%ecx
80104823:	77 17                	ja     8010483c <syscall+0x34>
80104825:	8b 0c 95 60 75 10 80 	mov    -0x7fef8aa0(,%edx,4),%ecx
8010482c:	85 c9                	test   %ecx,%ecx
8010482e:	74 0c                	je     8010483c <syscall+0x34>
    curproc->tf->eax = syscalls[num]();
80104830:	ff d1                	call   *%ecx
80104832:	89 43 1c             	mov    %eax,0x1c(%ebx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104835:	83 c4 24             	add    $0x24,%esp
80104838:	5b                   	pop    %ebx
80104839:	5d                   	pop    %ebp
8010483a:	c3                   	ret    
8010483b:	90                   	nop
    cprintf("%d %s: unknown sys call %d\n",
8010483c:	89 54 24 0c          	mov    %edx,0xc(%esp)
            curproc->pid, curproc->name, num);
80104840:	8d 50 6c             	lea    0x6c(%eax),%edx
80104843:	89 54 24 08          	mov    %edx,0x8(%esp)
    cprintf("%d %s: unknown sys call %d\n",
80104847:	8b 50 10             	mov    0x10(%eax),%edx
8010484a:	89 54 24 04          	mov    %edx,0x4(%esp)
8010484e:	c7 04 24 41 75 10 80 	movl   $0x80107541,(%esp)
80104855:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104858:	e8 57 bd ff ff       	call   801005b4 <cprintf>
    curproc->tf->eax = -1;
8010485d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104860:	8b 40 18             	mov    0x18(%eax),%eax
80104863:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
8010486a:	83 c4 24             	add    $0x24,%esp
8010486d:	5b                   	pop    %ebx
8010486e:	5d                   	pop    %ebp
8010486f:	c3                   	ret    

80104870 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
80104870:	55                   	push   %ebp
80104871:	89 e5                	mov    %esp,%ebp
80104873:	53                   	push   %ebx
80104874:	51                   	push   %ecx
80104875:	89 c3                	mov    %eax,%ebx
  int fd;
  struct proc *curproc = myproc();
80104877:	e8 0c ea ff ff       	call   80103288 <myproc>
8010487c:	89 c1                	mov    %eax,%ecx

  for(fd = 0; fd < NOFILE; fd++){
8010487e:	31 c0                	xor    %eax,%eax
    if(curproc->ofile[fd] == 0){
80104880:	8b 54 81 28          	mov    0x28(%ecx,%eax,4),%edx
80104884:	85 d2                	test   %edx,%edx
80104886:	74 10                	je     80104898 <fdalloc+0x28>
  for(fd = 0; fd < NOFILE; fd++){
80104888:	40                   	inc    %eax
80104889:	83 f8 10             	cmp    $0x10,%eax
8010488c:	75 f2                	jne    80104880 <fdalloc+0x10>
      curproc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
8010488e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104893:	5a                   	pop    %edx
80104894:	5b                   	pop    %ebx
80104895:	5d                   	pop    %ebp
80104896:	c3                   	ret    
80104897:	90                   	nop
      curproc->ofile[fd] = f;
80104898:	89 5c 81 28          	mov    %ebx,0x28(%ecx,%eax,4)
}
8010489c:	5a                   	pop    %edx
8010489d:	5b                   	pop    %ebx
8010489e:	5d                   	pop    %ebp
8010489f:	c3                   	ret    

801048a0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
801048a0:	55                   	push   %ebp
801048a1:	89 e5                	mov    %esp,%ebp
801048a3:	57                   	push   %edi
801048a4:	56                   	push   %esi
801048a5:	53                   	push   %ebx
801048a6:	83 ec 4c             	sub    $0x4c,%esp
801048a9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
801048ac:	8b 4d 08             	mov    0x8(%ebp),%ecx
801048af:	89 4d c0             	mov    %ecx,-0x40(%ebp)
801048b2:	89 d6                	mov    %edx,%esi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801048b4:	8d 55 da             	lea    -0x26(%ebp),%edx
801048b7:	89 54 24 04          	mov    %edx,0x4(%esp)
801048bb:	89 04 24             	mov    %eax,(%esp)
801048be:	e8 7d d4 ff ff       	call   80101d40 <nameiparent>
801048c3:	89 c3                	mov    %eax,%ebx
801048c5:	85 c0                	test   %eax,%eax
801048c7:	0f 84 cf 00 00 00    	je     8010499c <create+0xfc>
    return 0;
  ilock(dp);
801048cd:	89 04 24             	mov    %eax,(%esp)
801048d0:	e8 7b cc ff ff       	call   80101550 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
801048d5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
801048d8:	89 44 24 08          	mov    %eax,0x8(%esp)
801048dc:	8d 4d da             	lea    -0x26(%ebp),%ecx
801048df:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801048e3:	89 1c 24             	mov    %ebx,(%esp)
801048e6:	e8 4d d1 ff ff       	call   80101a38 <dirlookup>
801048eb:	89 c7                	mov    %eax,%edi
801048ed:	85 c0                	test   %eax,%eax
801048ef:	74 3b                	je     8010492c <create+0x8c>
    iunlockput(dp);
801048f1:	89 1c 24             	mov    %ebx,(%esp)
801048f4:	e8 a7 ce ff ff       	call   801017a0 <iunlockput>
    ilock(ip);
801048f9:	89 3c 24             	mov    %edi,(%esp)
801048fc:	e8 4f cc ff ff       	call   80101550 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104901:	66 83 fe 02          	cmp    $0x2,%si
80104905:	75 11                	jne    80104918 <create+0x78>
80104907:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
8010490c:	75 0a                	jne    80104918 <create+0x78>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
8010490e:	89 f8                	mov    %edi,%eax
80104910:	83 c4 4c             	add    $0x4c,%esp
80104913:	5b                   	pop    %ebx
80104914:	5e                   	pop    %esi
80104915:	5f                   	pop    %edi
80104916:	5d                   	pop    %ebp
80104917:	c3                   	ret    
    iunlockput(ip);
80104918:	89 3c 24             	mov    %edi,(%esp)
8010491b:	e8 80 ce ff ff       	call   801017a0 <iunlockput>
    return 0;
80104920:	31 ff                	xor    %edi,%edi
}
80104922:	89 f8                	mov    %edi,%eax
80104924:	83 c4 4c             	add    $0x4c,%esp
80104927:	5b                   	pop    %ebx
80104928:	5e                   	pop    %esi
80104929:	5f                   	pop    %edi
8010492a:	5d                   	pop    %ebp
8010492b:	c3                   	ret    
  if((ip = ialloc(dp->dev, type)) == 0)
8010492c:	0f bf c6             	movswl %si,%eax
8010492f:	89 44 24 04          	mov    %eax,0x4(%esp)
80104933:	8b 03                	mov    (%ebx),%eax
80104935:	89 04 24             	mov    %eax,(%esp)
80104938:	e8 97 ca ff ff       	call   801013d4 <ialloc>
8010493d:	89 c7                	mov    %eax,%edi
8010493f:	85 c0                	test   %eax,%eax
80104941:	0f 84 b7 00 00 00    	je     801049fe <create+0x15e>
  ilock(ip);
80104947:	89 04 24             	mov    %eax,(%esp)
8010494a:	e8 01 cc ff ff       	call   80101550 <ilock>
  ip->major = major;
8010494f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80104952:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
80104956:	8b 55 c0             	mov    -0x40(%ebp),%edx
80104959:	66 89 57 54          	mov    %dx,0x54(%edi)
  ip->nlink = 1;
8010495d:	66 c7 47 56 01 00    	movw   $0x1,0x56(%edi)
  iupdate(ip);
80104963:	89 3c 24             	mov    %edi,(%esp)
80104966:	e8 2d cb ff ff       	call   80101498 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
8010496b:	66 4e                	dec    %si
8010496d:	74 35                	je     801049a4 <create+0x104>
  if(dirlink(dp, name, ip->inum) < 0)
8010496f:	8b 47 04             	mov    0x4(%edi),%eax
80104972:	89 44 24 08          	mov    %eax,0x8(%esp)
80104976:	8d 4d da             	lea    -0x26(%ebp),%ecx
80104979:	89 4c 24 04          	mov    %ecx,0x4(%esp)
8010497d:	89 1c 24             	mov    %ebx,(%esp)
80104980:	e8 cb d2 ff ff       	call   80101c50 <dirlink>
80104985:	85 c0                	test   %eax,%eax
80104987:	78 69                	js     801049f2 <create+0x152>
  iunlockput(dp);
80104989:	89 1c 24             	mov    %ebx,(%esp)
8010498c:	e8 0f ce ff ff       	call   801017a0 <iunlockput>
}
80104991:	89 f8                	mov    %edi,%eax
80104993:	83 c4 4c             	add    $0x4c,%esp
80104996:	5b                   	pop    %ebx
80104997:	5e                   	pop    %esi
80104998:	5f                   	pop    %edi
80104999:	5d                   	pop    %ebp
8010499a:	c3                   	ret    
8010499b:	90                   	nop
    return 0;
8010499c:	31 ff                	xor    %edi,%edi
8010499e:	e9 6b ff ff ff       	jmp    8010490e <create+0x6e>
801049a3:	90                   	nop
    dp->nlink++;  // for ".."
801049a4:	66 ff 43 56          	incw   0x56(%ebx)
    iupdate(dp);
801049a8:	89 1c 24             	mov    %ebx,(%esp)
801049ab:	e8 e8 ca ff ff       	call   80101498 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801049b0:	8b 47 04             	mov    0x4(%edi),%eax
801049b3:	89 44 24 08          	mov    %eax,0x8(%esp)
801049b7:	c7 44 24 04 f8 75 10 	movl   $0x801075f8,0x4(%esp)
801049be:	80 
801049bf:	89 3c 24             	mov    %edi,(%esp)
801049c2:	e8 89 d2 ff ff       	call   80101c50 <dirlink>
801049c7:	85 c0                	test   %eax,%eax
801049c9:	78 1b                	js     801049e6 <create+0x146>
801049cb:	8b 43 04             	mov    0x4(%ebx),%eax
801049ce:	89 44 24 08          	mov    %eax,0x8(%esp)
801049d2:	c7 44 24 04 f7 75 10 	movl   $0x801075f7,0x4(%esp)
801049d9:	80 
801049da:	89 3c 24             	mov    %edi,(%esp)
801049dd:	e8 6e d2 ff ff       	call   80101c50 <dirlink>
801049e2:	85 c0                	test   %eax,%eax
801049e4:	79 89                	jns    8010496f <create+0xcf>
      panic("create dots");
801049e6:	c7 04 24 eb 75 10 80 	movl   $0x801075eb,(%esp)
801049ed:	e8 1e b9 ff ff       	call   80100310 <panic>
    panic("create: dirlink");
801049f2:	c7 04 24 fa 75 10 80 	movl   $0x801075fa,(%esp)
801049f9:	e8 12 b9 ff ff       	call   80100310 <panic>
    panic("create: ialloc");
801049fe:	c7 04 24 dc 75 10 80 	movl   $0x801075dc,(%esp)
80104a05:	e8 06 b9 ff ff       	call   80100310 <panic>
80104a0a:	66 90                	xchg   %ax,%ax

80104a0c <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80104a0c:	55                   	push   %ebp
80104a0d:	89 e5                	mov    %esp,%ebp
80104a0f:	56                   	push   %esi
80104a10:	53                   	push   %ebx
80104a11:	83 ec 20             	sub    $0x20,%esp
80104a14:	89 c6                	mov    %eax,%esi
80104a16:	89 d3                	mov    %edx,%ebx
  if(argint(n, &fd) < 0)
80104a18:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104a1b:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a1f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104a26:	e8 25 fd ff ff       	call   80104750 <argint>
80104a2b:	85 c0                	test   %eax,%eax
80104a2d:	78 2d                	js     80104a5c <argfd.constprop.0+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104a2f:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104a33:	77 27                	ja     80104a5c <argfd.constprop.0+0x50>
80104a35:	e8 4e e8 ff ff       	call   80103288 <myproc>
80104a3a:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104a3d:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104a41:	85 c0                	test   %eax,%eax
80104a43:	74 17                	je     80104a5c <argfd.constprop.0+0x50>
  if(pfd)
80104a45:	85 f6                	test   %esi,%esi
80104a47:	74 02                	je     80104a4b <argfd.constprop.0+0x3f>
    *pfd = fd;
80104a49:	89 16                	mov    %edx,(%esi)
  if(pf)
80104a4b:	85 db                	test   %ebx,%ebx
80104a4d:	74 19                	je     80104a68 <argfd.constprop.0+0x5c>
    *pf = f;
80104a4f:	89 03                	mov    %eax,(%ebx)
  return 0;
80104a51:	31 c0                	xor    %eax,%eax
}
80104a53:	83 c4 20             	add    $0x20,%esp
80104a56:	5b                   	pop    %ebx
80104a57:	5e                   	pop    %esi
80104a58:	5d                   	pop    %ebp
80104a59:	c3                   	ret    
80104a5a:	66 90                	xchg   %ax,%ax
    return -1;
80104a5c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104a61:	83 c4 20             	add    $0x20,%esp
80104a64:	5b                   	pop    %ebx
80104a65:	5e                   	pop    %esi
80104a66:	5d                   	pop    %ebp
80104a67:	c3                   	ret    
  return 0;
80104a68:	31 c0                	xor    %eax,%eax
80104a6a:	eb e7                	jmp    80104a53 <argfd.constprop.0+0x47>

80104a6c <sys_dup>:
{
80104a6c:	55                   	push   %ebp
80104a6d:	89 e5                	mov    %esp,%ebp
80104a6f:	53                   	push   %ebx
80104a70:	83 ec 24             	sub    $0x24,%esp
  if(argfd(0, 0, &f) < 0)
80104a73:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104a76:	31 c0                	xor    %eax,%eax
80104a78:	e8 8f ff ff ff       	call   80104a0c <argfd.constprop.0>
80104a7d:	85 c0                	test   %eax,%eax
80104a7f:	78 23                	js     80104aa4 <sys_dup+0x38>
  if((fd=fdalloc(f)) < 0)
80104a81:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a84:	e8 e7 fd ff ff       	call   80104870 <fdalloc>
80104a89:	89 c3                	mov    %eax,%ebx
80104a8b:	85 c0                	test   %eax,%eax
80104a8d:	78 15                	js     80104aa4 <sys_dup+0x38>
  filedup(f);
80104a8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a92:	89 04 24             	mov    %eax,(%esp)
80104a95:	e8 62 c2 ff ff       	call   80100cfc <filedup>
}
80104a9a:	89 d8                	mov    %ebx,%eax
80104a9c:	83 c4 24             	add    $0x24,%esp
80104a9f:	5b                   	pop    %ebx
80104aa0:	5d                   	pop    %ebp
80104aa1:	c3                   	ret    
80104aa2:	66 90                	xchg   %ax,%ax
    return -1;
80104aa4:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104aa9:	eb ef                	jmp    80104a9a <sys_dup+0x2e>
80104aab:	90                   	nop

80104aac <sys_read>:
{
80104aac:	55                   	push   %ebp
80104aad:	89 e5                	mov    %esp,%ebp
80104aaf:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104ab2:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104ab5:	31 c0                	xor    %eax,%eax
80104ab7:	e8 50 ff ff ff       	call   80104a0c <argfd.constprop.0>
80104abc:	85 c0                	test   %eax,%eax
80104abe:	78 50                	js     80104b10 <sys_read+0x64>
80104ac0:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104ac3:	89 44 24 04          	mov    %eax,0x4(%esp)
80104ac7:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80104ace:	e8 7d fc ff ff       	call   80104750 <argint>
80104ad3:	85 c0                	test   %eax,%eax
80104ad5:	78 39                	js     80104b10 <sys_read+0x64>
80104ad7:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104ada:	89 44 24 08          	mov    %eax,0x8(%esp)
80104ade:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104ae1:	89 44 24 04          	mov    %eax,0x4(%esp)
80104ae5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104aec:	e8 87 fc ff ff       	call   80104778 <argptr>
80104af1:	85 c0                	test   %eax,%eax
80104af3:	78 1b                	js     80104b10 <sys_read+0x64>
  return fileread(f, p, n);
80104af5:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104af8:	89 44 24 08          	mov    %eax,0x8(%esp)
80104afc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104aff:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b03:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104b06:	89 04 24             	mov    %eax,(%esp)
80104b09:	e8 32 c3 ff ff       	call   80100e40 <fileread>
}
80104b0e:	c9                   	leave  
80104b0f:	c3                   	ret    
    return -1;
80104b10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104b15:	c9                   	leave  
80104b16:	c3                   	ret    
80104b17:	90                   	nop

80104b18 <sys_write>:
{
80104b18:	55                   	push   %ebp
80104b19:	89 e5                	mov    %esp,%ebp
80104b1b:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104b1e:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104b21:	31 c0                	xor    %eax,%eax
80104b23:	e8 e4 fe ff ff       	call   80104a0c <argfd.constprop.0>
80104b28:	85 c0                	test   %eax,%eax
80104b2a:	78 50                	js     80104b7c <sys_write+0x64>
80104b2c:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104b2f:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b33:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80104b3a:	e8 11 fc ff ff       	call   80104750 <argint>
80104b3f:	85 c0                	test   %eax,%eax
80104b41:	78 39                	js     80104b7c <sys_write+0x64>
80104b43:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104b46:	89 44 24 08          	mov    %eax,0x8(%esp)
80104b4a:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104b4d:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b51:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104b58:	e8 1b fc ff ff       	call   80104778 <argptr>
80104b5d:	85 c0                	test   %eax,%eax
80104b5f:	78 1b                	js     80104b7c <sys_write+0x64>
  return filewrite(f, p, n);
80104b61:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104b64:	89 44 24 08          	mov    %eax,0x8(%esp)
80104b68:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b6b:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b6f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104b72:	89 04 24             	mov    %eax,(%esp)
80104b75:	e8 5a c3 ff ff       	call   80100ed4 <filewrite>
}
80104b7a:	c9                   	leave  
80104b7b:	c3                   	ret    
    return -1;
80104b7c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104b81:	c9                   	leave  
80104b82:	c3                   	ret    
80104b83:	90                   	nop

80104b84 <sys_close>:
{
80104b84:	55                   	push   %ebp
80104b85:	89 e5                	mov    %esp,%ebp
80104b87:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, &fd, &f) < 0)
80104b8a:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104b8d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104b90:	e8 77 fe ff ff       	call   80104a0c <argfd.constprop.0>
80104b95:	85 c0                	test   %eax,%eax
80104b97:	78 1f                	js     80104bb8 <sys_close+0x34>
  myproc()->ofile[fd] = 0;
80104b99:	e8 ea e6 ff ff       	call   80103288 <myproc>
80104b9e:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104ba1:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104ba8:	00 
  fileclose(f);
80104ba9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bac:	89 04 24             	mov    %eax,(%esp)
80104baf:	e8 8c c1 ff ff       	call   80100d40 <fileclose>
  return 0;
80104bb4:	31 c0                	xor    %eax,%eax
}
80104bb6:	c9                   	leave  
80104bb7:	c3                   	ret    
    return -1;
80104bb8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104bbd:	c9                   	leave  
80104bbe:	c3                   	ret    
80104bbf:	90                   	nop

80104bc0 <sys_fstat>:
{
80104bc0:	55                   	push   %ebp
80104bc1:	89 e5                	mov    %esp,%ebp
80104bc3:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104bc6:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104bc9:	31 c0                	xor    %eax,%eax
80104bcb:	e8 3c fe ff ff       	call   80104a0c <argfd.constprop.0>
80104bd0:	85 c0                	test   %eax,%eax
80104bd2:	78 34                	js     80104c08 <sys_fstat+0x48>
80104bd4:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
80104bdb:	00 
80104bdc:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104bdf:	89 44 24 04          	mov    %eax,0x4(%esp)
80104be3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104bea:	e8 89 fb ff ff       	call   80104778 <argptr>
80104bef:	85 c0                	test   %eax,%eax
80104bf1:	78 15                	js     80104c08 <sys_fstat+0x48>
  return filestat(f, st);
80104bf3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bf6:	89 44 24 04          	mov    %eax,0x4(%esp)
80104bfa:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104bfd:	89 04 24             	mov    %eax,(%esp)
80104c00:	e8 ef c1 ff ff       	call   80100df4 <filestat>
}
80104c05:	c9                   	leave  
80104c06:	c3                   	ret    
80104c07:	90                   	nop
    return -1;
80104c08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104c0d:	c9                   	leave  
80104c0e:	c3                   	ret    
80104c0f:	90                   	nop

80104c10 <sys_link>:
{
80104c10:	55                   	push   %ebp
80104c11:	89 e5                	mov    %esp,%ebp
80104c13:	57                   	push   %edi
80104c14:	56                   	push   %esi
80104c15:	53                   	push   %ebx
80104c16:	83 ec 3c             	sub    $0x3c,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104c19:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104c1c:	89 44 24 04          	mov    %eax,0x4(%esp)
80104c20:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104c27:	e8 a4 fb ff ff       	call   801047d0 <argstr>
80104c2c:	85 c0                	test   %eax,%eax
80104c2e:	0f 88 e1 00 00 00    	js     80104d15 <sys_link+0x105>
80104c34:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104c37:	89 44 24 04          	mov    %eax,0x4(%esp)
80104c3b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104c42:	e8 89 fb ff ff       	call   801047d0 <argstr>
80104c47:	85 c0                	test   %eax,%eax
80104c49:	0f 88 c6 00 00 00    	js     80104d15 <sys_link+0x105>
  begin_op();
80104c4f:	e8 44 db ff ff       	call   80102798 <begin_op>
  if((ip = namei(old)) == 0){
80104c54:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80104c57:	89 04 24             	mov    %eax,(%esp)
80104c5a:	e8 c9 d0 ff ff       	call   80101d28 <namei>
80104c5f:	89 c3                	mov    %eax,%ebx
80104c61:	85 c0                	test   %eax,%eax
80104c63:	0f 84 a7 00 00 00    	je     80104d10 <sys_link+0x100>
  ilock(ip);
80104c69:	89 04 24             	mov    %eax,(%esp)
80104c6c:	e8 df c8 ff ff       	call   80101550 <ilock>
  if(ip->type == T_DIR){
80104c71:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104c76:	0f 84 8c 00 00 00    	je     80104d08 <sys_link+0xf8>
  ip->nlink++;
80104c7c:	66 ff 43 56          	incw   0x56(%ebx)
  iupdate(ip);
80104c80:	89 1c 24             	mov    %ebx,(%esp)
80104c83:	e8 10 c8 ff ff       	call   80101498 <iupdate>
  iunlock(ip);
80104c88:	89 1c 24             	mov    %ebx,(%esp)
80104c8b:	e8 90 c9 ff ff       	call   80101620 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80104c90:	8d 7d da             	lea    -0x26(%ebp),%edi
80104c93:	89 7c 24 04          	mov    %edi,0x4(%esp)
80104c97:	8b 45 d0             	mov    -0x30(%ebp),%eax
80104c9a:	89 04 24             	mov    %eax,(%esp)
80104c9d:	e8 9e d0 ff ff       	call   80101d40 <nameiparent>
80104ca2:	89 c6                	mov    %eax,%esi
80104ca4:	85 c0                	test   %eax,%eax
80104ca6:	74 4c                	je     80104cf4 <sys_link+0xe4>
  ilock(dp);
80104ca8:	89 04 24             	mov    %eax,(%esp)
80104cab:	e8 a0 c8 ff ff       	call   80101550 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104cb0:	8b 03                	mov    (%ebx),%eax
80104cb2:	39 06                	cmp    %eax,(%esi)
80104cb4:	75 36                	jne    80104cec <sys_link+0xdc>
80104cb6:	8b 43 04             	mov    0x4(%ebx),%eax
80104cb9:	89 44 24 08          	mov    %eax,0x8(%esp)
80104cbd:	89 7c 24 04          	mov    %edi,0x4(%esp)
80104cc1:	89 34 24             	mov    %esi,(%esp)
80104cc4:	e8 87 cf ff ff       	call   80101c50 <dirlink>
80104cc9:	85 c0                	test   %eax,%eax
80104ccb:	78 1f                	js     80104cec <sys_link+0xdc>
  iunlockput(dp);
80104ccd:	89 34 24             	mov    %esi,(%esp)
80104cd0:	e8 cb ca ff ff       	call   801017a0 <iunlockput>
  iput(ip);
80104cd5:	89 1c 24             	mov    %ebx,(%esp)
80104cd8:	e8 83 c9 ff ff       	call   80101660 <iput>
  end_op();
80104cdd:	e8 12 db ff ff       	call   801027f4 <end_op>
  return 0;
80104ce2:	31 c0                	xor    %eax,%eax
}
80104ce4:	83 c4 3c             	add    $0x3c,%esp
80104ce7:	5b                   	pop    %ebx
80104ce8:	5e                   	pop    %esi
80104ce9:	5f                   	pop    %edi
80104cea:	5d                   	pop    %ebp
80104ceb:	c3                   	ret    
    iunlockput(dp);
80104cec:	89 34 24             	mov    %esi,(%esp)
80104cef:	e8 ac ca ff ff       	call   801017a0 <iunlockput>
  ilock(ip);
80104cf4:	89 1c 24             	mov    %ebx,(%esp)
80104cf7:	e8 54 c8 ff ff       	call   80101550 <ilock>
  ip->nlink--;
80104cfc:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
80104d00:	89 1c 24             	mov    %ebx,(%esp)
80104d03:	e8 90 c7 ff ff       	call   80101498 <iupdate>
  iunlockput(ip);
80104d08:	89 1c 24             	mov    %ebx,(%esp)
80104d0b:	e8 90 ca ff ff       	call   801017a0 <iunlockput>
  end_op();
80104d10:	e8 df da ff ff       	call   801027f4 <end_op>
  return -1;
80104d15:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d1a:	83 c4 3c             	add    $0x3c,%esp
80104d1d:	5b                   	pop    %ebx
80104d1e:	5e                   	pop    %esi
80104d1f:	5f                   	pop    %edi
80104d20:	5d                   	pop    %ebp
80104d21:	c3                   	ret    
80104d22:	66 90                	xchg   %ax,%ax

80104d24 <sys_unlink>:
{
80104d24:	55                   	push   %ebp
80104d25:	89 e5                	mov    %esp,%ebp
80104d27:	57                   	push   %edi
80104d28:	56                   	push   %esi
80104d29:	53                   	push   %ebx
80104d2a:	83 ec 5c             	sub    $0x5c,%esp
  if(argstr(0, &path) < 0)
80104d2d:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104d30:	89 44 24 04          	mov    %eax,0x4(%esp)
80104d34:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104d3b:	e8 90 fa ff ff       	call   801047d0 <argstr>
80104d40:	85 c0                	test   %eax,%eax
80104d42:	0f 88 70 01 00 00    	js     80104eb8 <sys_unlink+0x194>
  begin_op();
80104d48:	e8 4b da ff ff       	call   80102798 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80104d4d:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80104d50:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104d54:	8b 45 c0             	mov    -0x40(%ebp),%eax
80104d57:	89 04 24             	mov    %eax,(%esp)
80104d5a:	e8 e1 cf ff ff       	call   80101d40 <nameiparent>
80104d5f:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80104d62:	85 c0                	test   %eax,%eax
80104d64:	0f 84 49 01 00 00    	je     80104eb3 <sys_unlink+0x18f>
  ilock(dp);
80104d6a:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104d6d:	89 04 24             	mov    %eax,(%esp)
80104d70:	e8 db c7 ff ff       	call   80101550 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80104d75:	c7 44 24 04 f8 75 10 	movl   $0x801075f8,0x4(%esp)
80104d7c:	80 
80104d7d:	89 1c 24             	mov    %ebx,(%esp)
80104d80:	e8 8f cc ff ff       	call   80101a14 <namecmp>
80104d85:	85 c0                	test   %eax,%eax
80104d87:	0f 84 1b 01 00 00    	je     80104ea8 <sys_unlink+0x184>
80104d8d:	c7 44 24 04 f7 75 10 	movl   $0x801075f7,0x4(%esp)
80104d94:	80 
80104d95:	89 1c 24             	mov    %ebx,(%esp)
80104d98:	e8 77 cc ff ff       	call   80101a14 <namecmp>
80104d9d:	85 c0                	test   %eax,%eax
80104d9f:	0f 84 03 01 00 00    	je     80104ea8 <sys_unlink+0x184>
  if((ip = dirlookup(dp, name, &off)) == 0)
80104da5:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104da8:	89 44 24 08          	mov    %eax,0x8(%esp)
80104dac:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104db0:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104db3:	89 04 24             	mov    %eax,(%esp)
80104db6:	e8 7d cc ff ff       	call   80101a38 <dirlookup>
80104dbb:	89 c3                	mov    %eax,%ebx
80104dbd:	85 c0                	test   %eax,%eax
80104dbf:	0f 84 e3 00 00 00    	je     80104ea8 <sys_unlink+0x184>
  ilock(ip);
80104dc5:	89 04 24             	mov    %eax,(%esp)
80104dc8:	e8 83 c7 ff ff       	call   80101550 <ilock>
  if(ip->nlink < 1)
80104dcd:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80104dd2:	0f 8e 1c 01 00 00    	jle    80104ef4 <sys_unlink+0x1d0>
  if(ip->type == T_DIR && !isdirempty(ip)){
80104dd8:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104ddd:	74 7d                	je     80104e5c <sys_unlink+0x138>
80104ddf:	8d 75 d8             	lea    -0x28(%ebp),%esi
  memset(&de, 0, sizeof(de));
80104de2:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80104de9:	00 
80104dea:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80104df1:	00 
80104df2:	89 34 24             	mov    %esi,(%esp)
80104df5:	e8 ea f6 ff ff       	call   801044e4 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104dfa:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80104e01:	00 
80104e02:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80104e05:	89 44 24 08          	mov    %eax,0x8(%esp)
80104e09:	89 74 24 04          	mov    %esi,0x4(%esp)
80104e0d:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104e10:	89 04 24             	mov    %eax,(%esp)
80104e13:	e8 d8 ca ff ff       	call   801018f0 <writei>
80104e18:	83 f8 10             	cmp    $0x10,%eax
80104e1b:	0f 85 c7 00 00 00    	jne    80104ee8 <sys_unlink+0x1c4>
  if(ip->type == T_DIR){
80104e21:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104e26:	0f 84 9c 00 00 00    	je     80104ec8 <sys_unlink+0x1a4>
  iunlockput(dp);
80104e2c:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104e2f:	89 04 24             	mov    %eax,(%esp)
80104e32:	e8 69 c9 ff ff       	call   801017a0 <iunlockput>
  ip->nlink--;
80104e37:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
80104e3b:	89 1c 24             	mov    %ebx,(%esp)
80104e3e:	e8 55 c6 ff ff       	call   80101498 <iupdate>
  iunlockput(ip);
80104e43:	89 1c 24             	mov    %ebx,(%esp)
80104e46:	e8 55 c9 ff ff       	call   801017a0 <iunlockput>
  end_op();
80104e4b:	e8 a4 d9 ff ff       	call   801027f4 <end_op>
  return 0;
80104e50:	31 c0                	xor    %eax,%eax
}
80104e52:	83 c4 5c             	add    $0x5c,%esp
80104e55:	5b                   	pop    %ebx
80104e56:	5e                   	pop    %esi
80104e57:	5f                   	pop    %edi
80104e58:	5d                   	pop    %ebp
80104e59:	c3                   	ret    
80104e5a:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80104e5c:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80104e60:	0f 86 79 ff ff ff    	jbe    80104ddf <sys_unlink+0xbb>
80104e66:	bf 20 00 00 00       	mov    $0x20,%edi
80104e6b:	8d 75 d8             	lea    -0x28(%ebp),%esi
80104e6e:	eb 0c                	jmp    80104e7c <sys_unlink+0x158>
80104e70:	83 c7 10             	add    $0x10,%edi
80104e73:	3b 7b 58             	cmp    0x58(%ebx),%edi
80104e76:	0f 83 66 ff ff ff    	jae    80104de2 <sys_unlink+0xbe>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104e7c:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80104e83:	00 
80104e84:	89 7c 24 08          	mov    %edi,0x8(%esp)
80104e88:	89 74 24 04          	mov    %esi,0x4(%esp)
80104e8c:	89 1c 24             	mov    %ebx,(%esp)
80104e8f:	e8 58 c9 ff ff       	call   801017ec <readi>
80104e94:	83 f8 10             	cmp    $0x10,%eax
80104e97:	75 43                	jne    80104edc <sys_unlink+0x1b8>
    if(de.inum != 0)
80104e99:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80104e9e:	74 d0                	je     80104e70 <sys_unlink+0x14c>
    iunlockput(ip);
80104ea0:	89 1c 24             	mov    %ebx,(%esp)
80104ea3:	e8 f8 c8 ff ff       	call   801017a0 <iunlockput>
  iunlockput(dp);
80104ea8:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104eab:	89 04 24             	mov    %eax,(%esp)
80104eae:	e8 ed c8 ff ff       	call   801017a0 <iunlockput>
  end_op();
80104eb3:	e8 3c d9 ff ff       	call   801027f4 <end_op>
  return -1;
80104eb8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ebd:	83 c4 5c             	add    $0x5c,%esp
80104ec0:	5b                   	pop    %ebx
80104ec1:	5e                   	pop    %esi
80104ec2:	5f                   	pop    %edi
80104ec3:	5d                   	pop    %ebp
80104ec4:	c3                   	ret    
80104ec5:	8d 76 00             	lea    0x0(%esi),%esi
    dp->nlink--;
80104ec8:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104ecb:	66 ff 48 56          	decw   0x56(%eax)
    iupdate(dp);
80104ecf:	89 04 24             	mov    %eax,(%esp)
80104ed2:	e8 c1 c5 ff ff       	call   80101498 <iupdate>
80104ed7:	e9 50 ff ff ff       	jmp    80104e2c <sys_unlink+0x108>
      panic("isdirempty: readi");
80104edc:	c7 04 24 1c 76 10 80 	movl   $0x8010761c,(%esp)
80104ee3:	e8 28 b4 ff ff       	call   80100310 <panic>
    panic("unlink: writei");
80104ee8:	c7 04 24 2e 76 10 80 	movl   $0x8010762e,(%esp)
80104eef:	e8 1c b4 ff ff       	call   80100310 <panic>
    panic("unlink: nlink < 1");
80104ef4:	c7 04 24 0a 76 10 80 	movl   $0x8010760a,(%esp)
80104efb:	e8 10 b4 ff ff       	call   80100310 <panic>

80104f00 <sys_open>:

int
sys_open(void)
{
80104f00:	55                   	push   %ebp
80104f01:	89 e5                	mov    %esp,%ebp
80104f03:	56                   	push   %esi
80104f04:	53                   	push   %ebx
80104f05:	83 ec 30             	sub    $0x30,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80104f08:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104f0b:	89 44 24 04          	mov    %eax,0x4(%esp)
80104f0f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104f16:	e8 b5 f8 ff ff       	call   801047d0 <argstr>
80104f1b:	85 c0                	test   %eax,%eax
80104f1d:	0f 88 ce 00 00 00    	js     80104ff1 <sys_open+0xf1>
80104f23:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104f26:	89 44 24 04          	mov    %eax,0x4(%esp)
80104f2a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104f31:	e8 1a f8 ff ff       	call   80104750 <argint>
80104f36:	85 c0                	test   %eax,%eax
80104f38:	0f 88 b3 00 00 00    	js     80104ff1 <sys_open+0xf1>
    return -1;

  begin_op();
80104f3e:	e8 55 d8 ff ff       	call   80102798 <begin_op>

  if(omode & O_CREATE){
80104f43:	f6 45 f5 02          	testb  $0x2,-0xb(%ebp)
80104f47:	0f 85 83 00 00 00    	jne    80104fd0 <sys_open+0xd0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80104f4d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104f50:	89 04 24             	mov    %eax,(%esp)
80104f53:	e8 d0 cd ff ff       	call   80101d28 <namei>
80104f58:	89 c6                	mov    %eax,%esi
80104f5a:	85 c0                	test   %eax,%eax
80104f5c:	0f 84 8a 00 00 00    	je     80104fec <sys_open+0xec>
      end_op();
      return -1;
    }
    ilock(ip);
80104f62:	89 04 24             	mov    %eax,(%esp)
80104f65:	e8 e6 c5 ff ff       	call   80101550 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80104f6a:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80104f6f:	0f 84 8b 00 00 00    	je     80105000 <sys_open+0x100>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80104f75:	e8 1e bd ff ff       	call   80100c98 <filealloc>
80104f7a:	89 c3                	mov    %eax,%ebx
80104f7c:	85 c0                	test   %eax,%eax
80104f7e:	0f 84 88 00 00 00    	je     8010500c <sys_open+0x10c>
80104f84:	e8 e7 f8 ff ff       	call   80104870 <fdalloc>
80104f89:	85 c0                	test   %eax,%eax
80104f8b:	0f 88 87 00 00 00    	js     80105018 <sys_open+0x118>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80104f91:	89 34 24             	mov    %esi,(%esp)
80104f94:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104f97:	e8 84 c6 ff ff       	call   80101620 <iunlock>
  end_op();
80104f9c:	e8 53 d8 ff ff       	call   801027f4 <end_op>

  f->type = FD_INODE;
80104fa1:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  f->ip = ip;
80104fa7:	89 73 10             	mov    %esi,0x10(%ebx)
  f->off = 0;
80104faa:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
  f->readable = !(omode & O_WRONLY);
80104fb1:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80104fb4:	89 ca                	mov    %ecx,%edx
80104fb6:	83 e2 01             	and    $0x1,%edx
80104fb9:	83 f2 01             	xor    $0x1,%edx
80104fbc:	88 53 08             	mov    %dl,0x8(%ebx)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80104fbf:	83 e1 03             	and    $0x3,%ecx
80104fc2:	0f 95 43 09          	setne  0x9(%ebx)
80104fc6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  return fd;
}
80104fc9:	83 c4 30             	add    $0x30,%esp
80104fcc:	5b                   	pop    %ebx
80104fcd:	5e                   	pop    %esi
80104fce:	5d                   	pop    %ebp
80104fcf:	c3                   	ret    
    ip = create(path, T_FILE, 0, 0);
80104fd0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104fd7:	31 c9                	xor    %ecx,%ecx
80104fd9:	ba 02 00 00 00       	mov    $0x2,%edx
80104fde:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104fe1:	e8 ba f8 ff ff       	call   801048a0 <create>
80104fe6:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80104fe8:	85 c0                	test   %eax,%eax
80104fea:	75 89                	jne    80104f75 <sys_open+0x75>
    end_op();
80104fec:	e8 03 d8 ff ff       	call   801027f4 <end_op>
    return -1;
80104ff1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ff6:	83 c4 30             	add    $0x30,%esp
80104ff9:	5b                   	pop    %ebx
80104ffa:	5e                   	pop    %esi
80104ffb:	5d                   	pop    %ebp
80104ffc:	c3                   	ret    
80104ffd:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105000:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105003:	85 db                	test   %ebx,%ebx
80105005:	0f 84 6a ff ff ff    	je     80104f75 <sys_open+0x75>
8010500b:	90                   	nop
    iunlockput(ip);
8010500c:	89 34 24             	mov    %esi,(%esp)
8010500f:	e8 8c c7 ff ff       	call   801017a0 <iunlockput>
80105014:	eb d6                	jmp    80104fec <sys_open+0xec>
80105016:	66 90                	xchg   %ax,%ax
      fileclose(f);
80105018:	89 1c 24             	mov    %ebx,(%esp)
8010501b:	e8 20 bd ff ff       	call   80100d40 <fileclose>
80105020:	eb ea                	jmp    8010500c <sys_open+0x10c>
80105022:	66 90                	xchg   %ax,%ax

80105024 <sys_mkdir>:

int
sys_mkdir(void)
{
80105024:	55                   	push   %ebp
80105025:	89 e5                	mov    %esp,%ebp
80105027:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_op();
8010502a:	e8 69 d7 ff ff       	call   80102798 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010502f:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105032:	89 44 24 04          	mov    %eax,0x4(%esp)
80105036:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010503d:	e8 8e f7 ff ff       	call   801047d0 <argstr>
80105042:	85 c0                	test   %eax,%eax
80105044:	78 2e                	js     80105074 <sys_mkdir+0x50>
80105046:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010504d:	31 c9                	xor    %ecx,%ecx
8010504f:	ba 01 00 00 00       	mov    $0x1,%edx
80105054:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105057:	e8 44 f8 ff ff       	call   801048a0 <create>
8010505c:	85 c0                	test   %eax,%eax
8010505e:	74 14                	je     80105074 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105060:	89 04 24             	mov    %eax,(%esp)
80105063:	e8 38 c7 ff ff       	call   801017a0 <iunlockput>
  end_op();
80105068:	e8 87 d7 ff ff       	call   801027f4 <end_op>
  return 0;
8010506d:	31 c0                	xor    %eax,%eax
}
8010506f:	c9                   	leave  
80105070:	c3                   	ret    
80105071:	8d 76 00             	lea    0x0(%esi),%esi
    end_op();
80105074:	e8 7b d7 ff ff       	call   801027f4 <end_op>
    return -1;
80105079:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010507e:	c9                   	leave  
8010507f:	c3                   	ret    

80105080 <sys_mknod>:

int
sys_mknod(void)
{
80105080:	55                   	push   %ebp
80105081:	89 e5                	mov    %esp,%ebp
80105083:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105086:	e8 0d d7 ff ff       	call   80102798 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010508b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010508e:	89 44 24 04          	mov    %eax,0x4(%esp)
80105092:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105099:	e8 32 f7 ff ff       	call   801047d0 <argstr>
8010509e:	85 c0                	test   %eax,%eax
801050a0:	78 5e                	js     80105100 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801050a2:	8d 45 f0             	lea    -0x10(%ebp),%eax
801050a5:	89 44 24 04          	mov    %eax,0x4(%esp)
801050a9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801050b0:	e8 9b f6 ff ff       	call   80104750 <argint>
  if((argstr(0, &path)) < 0 ||
801050b5:	85 c0                	test   %eax,%eax
801050b7:	78 47                	js     80105100 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801050b9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801050bc:	89 44 24 04          	mov    %eax,0x4(%esp)
801050c0:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
801050c7:	e8 84 f6 ff ff       	call   80104750 <argint>
     argint(1, &major) < 0 ||
801050cc:	85 c0                	test   %eax,%eax
801050ce:	78 30                	js     80105100 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
801050d0:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
801050d4:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
801050d8:	89 04 24             	mov    %eax,(%esp)
     argint(2, &minor) < 0 ||
801050db:	ba 03 00 00 00       	mov    $0x3,%edx
801050e0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801050e3:	e8 b8 f7 ff ff       	call   801048a0 <create>
801050e8:	85 c0                	test   %eax,%eax
801050ea:	74 14                	je     80105100 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
801050ec:	89 04 24             	mov    %eax,(%esp)
801050ef:	e8 ac c6 ff ff       	call   801017a0 <iunlockput>
  end_op();
801050f4:	e8 fb d6 ff ff       	call   801027f4 <end_op>
  return 0;
801050f9:	31 c0                	xor    %eax,%eax
}
801050fb:	c9                   	leave  
801050fc:	c3                   	ret    
801050fd:	8d 76 00             	lea    0x0(%esi),%esi
    end_op();
80105100:	e8 ef d6 ff ff       	call   801027f4 <end_op>
    return -1;
80105105:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010510a:	c9                   	leave  
8010510b:	c3                   	ret    

8010510c <sys_chdir>:

int
sys_chdir(void)
{
8010510c:	55                   	push   %ebp
8010510d:	89 e5                	mov    %esp,%ebp
8010510f:	56                   	push   %esi
80105110:	53                   	push   %ebx
80105111:	83 ec 20             	sub    $0x20,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105114:	e8 6f e1 ff ff       	call   80103288 <myproc>
80105119:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010511b:	e8 78 d6 ff ff       	call   80102798 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105120:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105123:	89 44 24 04          	mov    %eax,0x4(%esp)
80105127:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010512e:	e8 9d f6 ff ff       	call   801047d0 <argstr>
80105133:	85 c0                	test   %eax,%eax
80105135:	78 4a                	js     80105181 <sys_chdir+0x75>
80105137:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010513a:	89 04 24             	mov    %eax,(%esp)
8010513d:	e8 e6 cb ff ff       	call   80101d28 <namei>
80105142:	89 c3                	mov    %eax,%ebx
80105144:	85 c0                	test   %eax,%eax
80105146:	74 39                	je     80105181 <sys_chdir+0x75>
    end_op();
    return -1;
  }
  ilock(ip);
80105148:	89 04 24             	mov    %eax,(%esp)
8010514b:	e8 00 c4 ff ff       	call   80101550 <ilock>
  if(ip->type != T_DIR){
80105150:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
    iunlockput(ip);
80105155:	89 1c 24             	mov    %ebx,(%esp)
  if(ip->type != T_DIR){
80105158:	75 22                	jne    8010517c <sys_chdir+0x70>
    end_op();
    return -1;
  }
  iunlock(ip);
8010515a:	e8 c1 c4 ff ff       	call   80101620 <iunlock>
  iput(curproc->cwd);
8010515f:	8b 46 68             	mov    0x68(%esi),%eax
80105162:	89 04 24             	mov    %eax,(%esp)
80105165:	e8 f6 c4 ff ff       	call   80101660 <iput>
  end_op();
8010516a:	e8 85 d6 ff ff       	call   801027f4 <end_op>
  curproc->cwd = ip;
8010516f:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
80105172:	31 c0                	xor    %eax,%eax
}
80105174:	83 c4 20             	add    $0x20,%esp
80105177:	5b                   	pop    %ebx
80105178:	5e                   	pop    %esi
80105179:	5d                   	pop    %ebp
8010517a:	c3                   	ret    
8010517b:	90                   	nop
    iunlockput(ip);
8010517c:	e8 1f c6 ff ff       	call   801017a0 <iunlockput>
    end_op();
80105181:	e8 6e d6 ff ff       	call   801027f4 <end_op>
    return -1;
80105186:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010518b:	83 c4 20             	add    $0x20,%esp
8010518e:	5b                   	pop    %ebx
8010518f:	5e                   	pop    %esi
80105190:	5d                   	pop    %ebp
80105191:	c3                   	ret    
80105192:	66 90                	xchg   %ax,%ax

80105194 <sys_exec>:

int
sys_exec(void)
{
80105194:	55                   	push   %ebp
80105195:	89 e5                	mov    %esp,%ebp
80105197:	57                   	push   %edi
80105198:	56                   	push   %esi
80105199:	53                   	push   %ebx
8010519a:	81 ec ac 00 00 00    	sub    $0xac,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801051a0:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
801051a6:	89 44 24 04          	mov    %eax,0x4(%esp)
801051aa:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801051b1:	e8 1a f6 ff ff       	call   801047d0 <argstr>
801051b6:	85 c0                	test   %eax,%eax
801051b8:	0f 88 89 00 00 00    	js     80105247 <sys_exec+0xb3>
801051be:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801051c4:	89 44 24 04          	mov    %eax,0x4(%esp)
801051c8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801051cf:	e8 7c f5 ff ff       	call   80104750 <argint>
801051d4:	85 c0                	test   %eax,%eax
801051d6:	78 6f                	js     80105247 <sys_exec+0xb3>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801051d8:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
801051df:	00 
801051e0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801051e7:	00 
801051e8:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801051ee:	89 04 24             	mov    %eax,(%esp)
801051f1:	e8 ee f2 ff ff       	call   801044e4 <memset>
  for(i=0;; i++){
801051f6:	31 db                	xor    %ebx,%ebx
801051f8:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801051fe:	66 90                	xchg   %ax,%ax
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105200:	89 7c 24 04          	mov    %edi,0x4(%esp)
sys_exec(void)
80105204:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
8010520b:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105211:	01 f0                	add    %esi,%eax
80105213:	89 04 24             	mov    %eax,(%esp)
80105216:	e8 c1 f4 ff ff       	call   801046dc <fetchint>
8010521b:	85 c0                	test   %eax,%eax
8010521d:	78 28                	js     80105247 <sys_exec+0xb3>
      return -1;
    if(uarg == 0){
8010521f:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105225:	85 c0                	test   %eax,%eax
80105227:	74 2f                	je     80105258 <sys_exec+0xc4>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105229:	8d 95 68 ff ff ff    	lea    -0x98(%ebp),%edx
8010522f:	01 d6                	add    %edx,%esi
80105231:	89 74 24 04          	mov    %esi,0x4(%esp)
80105235:	89 04 24             	mov    %eax,(%esp)
80105238:	e8 cf f4 ff ff       	call   8010470c <fetchstr>
8010523d:	85 c0                	test   %eax,%eax
8010523f:	78 06                	js     80105247 <sys_exec+0xb3>
  for(i=0;; i++){
80105241:	43                   	inc    %ebx
    if(i >= NELEM(argv))
80105242:	83 fb 20             	cmp    $0x20,%ebx
80105245:	75 b9                	jne    80105200 <sys_exec+0x6c>
    return -1;
80105247:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return -1;
  }
  return exec(path, argv);
}
8010524c:	81 c4 ac 00 00 00    	add    $0xac,%esp
80105252:	5b                   	pop    %ebx
80105253:	5e                   	pop    %esi
80105254:	5f                   	pop    %edi
80105255:	5d                   	pop    %ebp
80105256:	c3                   	ret    
80105257:	90                   	nop
      argv[i] = 0;
80105258:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
8010525f:	00 00 00 00 
  return exec(path, argv);
80105263:	8d 95 68 ff ff ff    	lea    -0x98(%ebp),%edx
80105269:	89 54 24 04          	mov    %edx,0x4(%esp)
8010526d:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
80105273:	89 04 24             	mov    %eax,(%esp)
80105276:	e8 61 b6 ff ff       	call   801008dc <exec>
}
8010527b:	81 c4 ac 00 00 00    	add    $0xac,%esp
80105281:	5b                   	pop    %ebx
80105282:	5e                   	pop    %esi
80105283:	5f                   	pop    %edi
80105284:	5d                   	pop    %ebp
80105285:	c3                   	ret    
80105286:	66 90                	xchg   %ax,%ax

80105288 <sys_pipe>:

int
sys_pipe(void)
{
80105288:	55                   	push   %ebp
80105289:	89 e5                	mov    %esp,%ebp
8010528b:	53                   	push   %ebx
8010528c:	83 ec 24             	sub    $0x24,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010528f:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
80105296:	00 
80105297:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010529a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010529e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801052a5:	e8 ce f4 ff ff       	call   80104778 <argptr>
801052aa:	85 c0                	test   %eax,%eax
801052ac:	78 69                	js     80105317 <sys_pipe+0x8f>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801052ae:	8d 45 f4             	lea    -0xc(%ebp),%eax
801052b1:	89 44 24 04          	mov    %eax,0x4(%esp)
801052b5:	8d 45 f0             	lea    -0x10(%ebp),%eax
801052b8:	89 04 24             	mov    %eax,(%esp)
801052bb:	e8 a4 da ff ff       	call   80102d64 <pipealloc>
801052c0:	85 c0                	test   %eax,%eax
801052c2:	78 53                	js     80105317 <sys_pipe+0x8f>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801052c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801052c7:	e8 a4 f5 ff ff       	call   80104870 <fdalloc>
801052cc:	89 c3                	mov    %eax,%ebx
801052ce:	85 c0                	test   %eax,%eax
801052d0:	78 2f                	js     80105301 <sys_pipe+0x79>
801052d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801052d5:	e8 96 f5 ff ff       	call   80104870 <fdalloc>
801052da:	85 c0                	test   %eax,%eax
801052dc:	78 16                	js     801052f4 <sys_pipe+0x6c>
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
801052de:	8b 55 ec             	mov    -0x14(%ebp),%edx
801052e1:	89 1a                	mov    %ebx,(%edx)
  fd[1] = fd1;
801052e3:	8b 55 ec             	mov    -0x14(%ebp),%edx
801052e6:	89 42 04             	mov    %eax,0x4(%edx)
  return 0;
801052e9:	31 c0                	xor    %eax,%eax
}
801052eb:	83 c4 24             	add    $0x24,%esp
801052ee:	5b                   	pop    %ebx
801052ef:	5d                   	pop    %ebp
801052f0:	c3                   	ret    
801052f1:	8d 76 00             	lea    0x0(%esi),%esi
      myproc()->ofile[fd0] = 0;
801052f4:	e8 8f df ff ff       	call   80103288 <myproc>
801052f9:	c7 44 98 28 00 00 00 	movl   $0x0,0x28(%eax,%ebx,4)
80105300:	00 
    fileclose(rf);
80105301:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105304:	89 04 24             	mov    %eax,(%esp)
80105307:	e8 34 ba ff ff       	call   80100d40 <fileclose>
    fileclose(wf);
8010530c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010530f:	89 04 24             	mov    %eax,(%esp)
80105312:	e8 29 ba ff ff       	call   80100d40 <fileclose>
    return -1;
80105317:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010531c:	83 c4 24             	add    $0x24,%esp
8010531f:	5b                   	pop    %ebx
80105320:	5d                   	pop    %ebp
80105321:	c3                   	ret    
80105322:	66 90                	xchg   %ax,%ax

80105324 <sys_fork>:

//int numsyscall = -1;

int
sys_fork(void)
{
80105324:	55                   	push   %ebp
80105325:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105327:	5d                   	pop    %ebp
  return fork();
80105328:	e9 13 e1 ff ff       	jmp    80103440 <fork>
8010532d:	8d 76 00             	lea    0x0(%esi),%esi

80105330 <sys_exit>:

int
sys_exit(void)
{
80105330:	55                   	push   %ebp
80105331:	89 e5                	mov    %esp,%ebp
80105333:	83 ec 08             	sub    $0x8,%esp
  exit();
80105336:	e8 a9 e5 ff ff       	call   801038e4 <exit>
  return 0;  // not reached
}
8010533b:	31 c0                	xor    %eax,%eax
8010533d:	c9                   	leave  
8010533e:	c3                   	ret    
8010533f:	90                   	nop

80105340 <sys_wait>:

int
sys_wait(void)
{
80105340:	55                   	push   %ebp
80105341:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105343:	5d                   	pop    %ebp
  return wait();
80105344:	e9 d7 e8 ff ff       	jmp    80103c20 <wait>
80105349:	8d 76 00             	lea    0x0(%esi),%esi

8010534c <sys_kill>:

int
sys_kill(void)
{
8010534c:	55                   	push   %ebp
8010534d:	89 e5                	mov    %esp,%ebp
8010534f:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105352:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105355:	89 44 24 04          	mov    %eax,0x4(%esp)
80105359:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105360:	e8 eb f3 ff ff       	call   80104750 <argint>
80105365:	85 c0                	test   %eax,%eax
80105367:	78 0f                	js     80105378 <sys_kill+0x2c>
    return -1;
  return kill(pid);
80105369:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010536c:	89 04 24             	mov    %eax,(%esp)
8010536f:	e8 34 ea ff ff       	call   80103da8 <kill>
}
80105374:	c9                   	leave  
80105375:	c3                   	ret    
80105376:	66 90                	xchg   %ax,%ax
    return -1;
80105378:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010537d:	c9                   	leave  
8010537e:	c3                   	ret    
8010537f:	90                   	nop

80105380 <sys_getpid>:

int
sys_getpid(void)
{
80105380:	55                   	push   %ebp
80105381:	89 e5                	mov    %esp,%ebp
80105383:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105386:	e8 fd de ff ff       	call   80103288 <myproc>
8010538b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010538e:	c9                   	leave  
8010538f:	c3                   	ret    

80105390 <sys_sbrk>:

int
sys_sbrk(void)
{
80105390:	55                   	push   %ebp
80105391:	89 e5                	mov    %esp,%ebp
80105393:	53                   	push   %ebx
80105394:	83 ec 24             	sub    $0x24,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105397:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010539a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010539e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801053a5:	e8 a6 f3 ff ff       	call   80104750 <argint>
801053aa:	85 c0                	test   %eax,%eax
801053ac:	78 1e                	js     801053cc <sys_sbrk+0x3c>
    return -1;
  addr = myproc()->sz;
801053ae:	e8 d5 de ff ff       	call   80103288 <myproc>
801053b3:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801053b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801053b8:	89 04 24             	mov    %eax,(%esp)
801053bb:	e8 14 e0 ff ff       	call   801033d4 <growproc>
801053c0:	85 c0                	test   %eax,%eax
801053c2:	78 08                	js     801053cc <sys_sbrk+0x3c>
    return -1;
  return addr;
}
801053c4:	89 d8                	mov    %ebx,%eax
801053c6:	83 c4 24             	add    $0x24,%esp
801053c9:	5b                   	pop    %ebx
801053ca:	5d                   	pop    %ebp
801053cb:	c3                   	ret    
    return -1;
801053cc:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801053d1:	eb f1                	jmp    801053c4 <sys_sbrk+0x34>
801053d3:	90                   	nop

801053d4 <sys_sleep>:

int
sys_sleep(void)
{
801053d4:	55                   	push   %ebp
801053d5:	89 e5                	mov    %esp,%ebp
801053d7:	53                   	push   %ebx
801053d8:	83 ec 24             	sub    $0x24,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801053db:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053de:	89 44 24 04          	mov    %eax,0x4(%esp)
801053e2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801053e9:	e8 62 f3 ff ff       	call   80104750 <argint>
801053ee:	85 c0                	test   %eax,%eax
801053f0:	78 76                	js     80105468 <sys_sleep+0x94>
    return -1;
  acquire(&tickslock);
801053f2:	c7 04 24 60 53 11 80 	movl   $0x80115360,(%esp)
801053f9:	e8 e2 ef ff ff       	call   801043e0 <acquire>
  ticks0 = ticks;
801053fe:	8b 1d a0 5b 11 80    	mov    0x80115ba0,%ebx
  while(ticks - ticks0 < n){
80105404:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105407:	85 d2                	test   %edx,%edx
80105409:	75 25                	jne    80105430 <sys_sleep+0x5c>
8010540b:	eb 47                	jmp    80105454 <sys_sleep+0x80>
8010540d:	8d 76 00             	lea    0x0(%esi),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105410:	c7 44 24 04 60 53 11 	movl   $0x80115360,0x4(%esp)
80105417:	80 
80105418:	c7 04 24 a0 5b 11 80 	movl   $0x80115ba0,(%esp)
8010541f:	e8 58 e7 ff ff       	call   80103b7c <sleep>
  while(ticks - ticks0 < n){
80105424:	a1 a0 5b 11 80       	mov    0x80115ba0,%eax
80105429:	29 d8                	sub    %ebx,%eax
8010542b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010542e:	73 24                	jae    80105454 <sys_sleep+0x80>
    if(myproc()->killed){
80105430:	e8 53 de ff ff       	call   80103288 <myproc>
80105435:	8b 40 24             	mov    0x24(%eax),%eax
80105438:	85 c0                	test   %eax,%eax
8010543a:	74 d4                	je     80105410 <sys_sleep+0x3c>
      release(&tickslock);
8010543c:	c7 04 24 60 53 11 80 	movl   $0x80115360,(%esp)
80105443:	e8 54 f0 ff ff       	call   8010449c <release>
      return -1;
80105448:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
8010544d:	83 c4 24             	add    $0x24,%esp
80105450:	5b                   	pop    %ebx
80105451:	5d                   	pop    %ebp
80105452:	c3                   	ret    
80105453:	90                   	nop
  release(&tickslock);
80105454:	c7 04 24 60 53 11 80 	movl   $0x80115360,(%esp)
8010545b:	e8 3c f0 ff ff       	call   8010449c <release>
  return 0;
80105460:	31 c0                	xor    %eax,%eax
}
80105462:	83 c4 24             	add    $0x24,%esp
80105465:	5b                   	pop    %ebx
80105466:	5d                   	pop    %ebp
80105467:	c3                   	ret    
    return -1;
80105468:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010546d:	eb de                	jmp    8010544d <sys_sleep+0x79>
8010546f:	90                   	nop

80105470 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105470:	55                   	push   %ebp
80105471:	89 e5                	mov    %esp,%ebp
80105473:	53                   	push   %ebx
80105474:	83 ec 14             	sub    $0x14,%esp
  uint xticks;

  acquire(&tickslock);
80105477:	c7 04 24 60 53 11 80 	movl   $0x80115360,(%esp)
8010547e:	e8 5d ef ff ff       	call   801043e0 <acquire>
  xticks = ticks;
80105483:	8b 1d a0 5b 11 80    	mov    0x80115ba0,%ebx
  release(&tickslock);
80105489:	c7 04 24 60 53 11 80 	movl   $0x80115360,(%esp)
80105490:	e8 07 f0 ff ff       	call   8010449c <release>
  return xticks;
}
80105495:	89 d8                	mov    %ebx,%eax
80105497:	83 c4 14             	add    $0x14,%esp
8010549a:	5b                   	pop    %ebx
8010549b:	5d                   	pop    %ebp
8010549c:	c3                   	ret    
8010549d:	8d 76 00             	lea    0x0(%esi),%esi

801054a0 <sys_settickets>:

int
sys_settickets(void)   //system call to initiate tickets
{
801054a0:	55                   	push   %ebp
801054a1:	89 e5                	mov    %esp,%ebp
801054a3:	83 ec 28             	sub    $0x28,%esp
  int t;

  if(argint(0, &t) < 0)  //get the function parameter(tickets) like settickets(30) 30 is the parameter
801054a6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054a9:	89 44 24 04          	mov    %eax,0x4(%esp)
801054ad:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801054b4:	e8 97 f2 ff ff       	call   80104750 <argint>
801054b9:	85 c0                	test   %eax,%eax
801054bb:	78 0f                	js     801054cc <sys_settickets+0x2c>
    return -1;
  return settickets(t);
801054bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801054c0:	89 04 24             	mov    %eax,(%esp)
801054c3:	e8 40 ea ff ff       	call   80103f08 <settickets>
}
801054c8:	c9                   	leave  
801054c9:	c3                   	ret    
801054ca:	66 90                	xchg   %ax,%ax
    return -1;
801054cc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801054d1:	c9                   	leave  
801054d2:	c3                   	ret    
801054d3:	90                   	nop

801054d4 <sys_setstride>:

int sys_setstride(void)  //system call to initiate stride
{
801054d4:	55                   	push   %ebp
801054d5:	89 e5                	mov    %esp,%ebp
801054d7:	83 ec 28             	sub    $0x28,%esp
    int t;

    if(argint(0, &t) < 0)  //get the function parameter(strides)
801054da:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054dd:	89 44 24 04          	mov    %eax,0x4(%esp)
801054e1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801054e8:	e8 63 f2 ff ff       	call   80104750 <argint>
801054ed:	85 c0                	test   %eax,%eax
801054ef:	78 0f                	js     80105500 <sys_setstride+0x2c>
        return -1;
    return setstride(t);
801054f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801054f4:	89 04 24             	mov    %eax,(%esp)
801054f7:	e8 6c ea ff ff       	call   80103f68 <setstride>
}
801054fc:	c9                   	leave  
801054fd:	c3                   	ret    
801054fe:	66 90                	xchg   %ax,%ax
        return -1;
80105500:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105505:	c9                   	leave  
80105506:	c3                   	ret    
80105507:	90                   	nop

80105508 <sys_setpass>:

int sys_setpass(void)  //system call to initiate pass
{
80105508:	55                   	push   %ebp
80105509:	89 e5                	mov    %esp,%ebp
8010550b:	83 ec 28             	sub    $0x28,%esp
    int t;

    if(argint(0, &t) < 0)  //get the function parameter(passes)
8010550e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105511:	89 44 24 04          	mov    %eax,0x4(%esp)
80105515:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010551c:	e8 2f f2 ff ff       	call   80104750 <argint>
80105521:	85 c0                	test   %eax,%eax
80105523:	78 0f                	js     80105534 <sys_setpass+0x2c>
        return -1;
    return setpass(t);
80105525:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105528:	89 04 24             	mov    %eax,(%esp)
8010552b:	e8 8c ea ff ff       	call   80103fbc <setpass>
}
80105530:	c9                   	leave  
80105531:	c3                   	ret    
80105532:	66 90                	xchg   %ax,%ax
        return -1;
80105534:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105539:	c9                   	leave  
8010553a:	c3                   	ret    
8010553b:	90                   	nop

8010553c <sys_join>:


int
sys_join(void){
8010553c:	55                   	push   %ebp
8010553d:	89 e5                	mov    %esp,%ebp
8010553f:	83 ec 28             	sub    $0x28,%esp
    void **stack;
    if(argptr(0, (void*)&stack, sizeof(void**)) < 0)
80105542:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
80105549:	00 
8010554a:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010554d:	89 44 24 04          	mov    %eax,0x4(%esp)
80105551:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105558:	e8 1b f2 ff ff       	call   80104778 <argptr>
8010555d:	85 c0                	test   %eax,%eax
8010555f:	78 0f                	js     80105570 <sys_join+0x34>
        return -1;
    return join(stack);
80105561:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105564:	89 04 24             	mov    %eax,(%esp)
80105567:	e8 ac eb ff ff       	call   80104118 <join>
}
8010556c:	c9                   	leave  
8010556d:	c3                   	ret    
8010556e:	66 90                	xchg   %ax,%ax
        return -1;
80105570:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105575:	c9                   	leave  
80105576:	c3                   	ret    
80105577:	90                   	nop

80105578 <sys_clone1>:



int
sys_clone1(void) {
80105578:	55                   	push   %ebp
80105579:	89 e5                	mov    %esp,%ebp
8010557b:	83 ec 28             	sub    $0x28,%esp
    int size;
    void *stack;
    if (argptr(0, (void *) &stack, sizeof(stack)) < 0)  //get the function parameter(passes)
8010557e:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
80105585:	00 
80105586:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105589:	89 44 24 04          	mov    %eax,0x4(%esp)
8010558d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105594:	e8 df f1 ff ff       	call   80104778 <argptr>
80105599:	85 c0                	test   %eax,%eax
8010559b:	78 33                	js     801055d0 <sys_clone1+0x58>
        return -1;
    if (argptr(1, (void *) &size, sizeof(int)) < 0)  //get the function parameter(passes)
8010559d:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
801055a4:	00 
801055a5:	8d 45 f0             	lea    -0x10(%ebp),%eax
801055a8:	89 44 24 04          	mov    %eax,0x4(%esp)
801055ac:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801055b3:	e8 c0 f1 ff ff       	call   80104778 <argptr>
801055b8:	85 c0                	test   %eax,%eax
801055ba:	78 14                	js     801055d0 <sys_clone1+0x58>
        return -1;
    return clone1(stack, size);
801055bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801055bf:	89 44 24 04          	mov    %eax,0x4(%esp)
801055c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055c6:	89 04 24             	mov    %eax,(%esp)
801055c9:	e8 52 ea ff ff       	call   80104020 <clone1>
}
801055ce:	c9                   	leave  
801055cf:	c3                   	ret    
        return -1;
801055d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055d5:	c9                   	leave  
801055d6:	c3                   	ret    

801055d7 <alltraps>:
801055d7:	1e                   	push   %ds
801055d8:	06                   	push   %es
801055d9:	0f a0                	push   %fs
801055db:	0f a8                	push   %gs
801055dd:	60                   	pusha  
801055de:	66 b8 10 00          	mov    $0x10,%ax
801055e2:	8e d8                	mov    %eax,%ds
801055e4:	8e c0                	mov    %eax,%es
801055e6:	54                   	push   %esp
801055e7:	e8 bc 00 00 00       	call   801056a8 <trap>
801055ec:	83 c4 04             	add    $0x4,%esp

801055ef <trapret>:
801055ef:	61                   	popa   
801055f0:	0f a9                	pop    %gs
801055f2:	0f a1                	pop    %fs
801055f4:	07                   	pop    %es
801055f5:	1f                   	pop    %ds
801055f6:	83 c4 08             	add    $0x8,%esp
801055f9:	cf                   	iret   
801055fa:	66 90                	xchg   %ax,%ax

801055fc <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
801055fc:	31 c0                	xor    %eax,%eax
801055fe:	66 90                	xchg   %ax,%ax
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105600:	8b 14 85 0c a0 10 80 	mov    -0x7fef5ff4(,%eax,4),%edx
80105607:	66 89 14 c5 a0 53 11 	mov    %dx,-0x7feeac60(,%eax,8)
8010560e:	80 
8010560f:	66 c7 04 c5 a2 53 11 	movw   $0x8,-0x7feeac5e(,%eax,8)
80105616:	80 08 00 
80105619:	c6 04 c5 a4 53 11 80 	movb   $0x0,-0x7feeac5c(,%eax,8)
80105620:	00 
80105621:	c6 04 c5 a5 53 11 80 	movb   $0x8e,-0x7feeac5b(,%eax,8)
80105628:	8e 
80105629:	c1 ea 10             	shr    $0x10,%edx
8010562c:	66 89 14 c5 a6 53 11 	mov    %dx,-0x7feeac5a(,%eax,8)
80105633:	80 
  for(i = 0; i < 256; i++)
80105634:	40                   	inc    %eax
80105635:	3d 00 01 00 00       	cmp    $0x100,%eax
8010563a:	75 c4                	jne    80105600 <tvinit+0x4>
{
8010563c:	55                   	push   %ebp
8010563d:	89 e5                	mov    %esp,%ebp
8010563f:	83 ec 18             	sub    $0x18,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105642:	a1 0c a1 10 80       	mov    0x8010a10c,%eax
80105647:	66 a3 a0 55 11 80    	mov    %ax,0x801155a0
8010564d:	66 c7 05 a2 55 11 80 	movw   $0x8,0x801155a2
80105654:	08 00 
80105656:	c6 05 a4 55 11 80 00 	movb   $0x0,0x801155a4
8010565d:	c6 05 a5 55 11 80 ef 	movb   $0xef,0x801155a5
80105664:	c1 e8 10             	shr    $0x10,%eax
80105667:	66 a3 a6 55 11 80    	mov    %ax,0x801155a6

  initlock(&tickslock, "time");
8010566d:	c7 44 24 04 3d 76 10 	movl   $0x8010763d,0x4(%esp)
80105674:	80 
80105675:	c7 04 24 60 53 11 80 	movl   $0x80115360,(%esp)
8010567c:	e8 97 ec ff ff       	call   80104318 <initlock>
}
80105681:	c9                   	leave  
80105682:	c3                   	ret    
80105683:	90                   	nop

80105684 <idtinit>:

void
idtinit(void)
{
80105684:	55                   	push   %ebp
80105685:	89 e5                	mov    %esp,%ebp
80105687:	83 ec 10             	sub    $0x10,%esp
  pd[0] = size-1;
8010568a:	66 c7 45 fa ff 07    	movw   $0x7ff,-0x6(%ebp)
  pd[1] = (uint)p;
80105690:	b8 a0 53 11 80       	mov    $0x801153a0,%eax
80105695:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105699:	c1 e8 10             	shr    $0x10,%eax
8010569c:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
801056a0:	8d 45 fa             	lea    -0x6(%ebp),%eax
801056a3:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801056a6:	c9                   	leave  
801056a7:	c3                   	ret    

801056a8 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801056a8:	55                   	push   %ebp
801056a9:	89 e5                	mov    %esp,%ebp
801056ab:	57                   	push   %edi
801056ac:	56                   	push   %esi
801056ad:	53                   	push   %ebx
801056ae:	83 ec 3c             	sub    $0x3c,%esp
801056b1:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
801056b4:	8b 43 30             	mov    0x30(%ebx),%eax
801056b7:	83 f8 40             	cmp    $0x40,%eax
801056ba:	0f 84 b0 01 00 00    	je     80105870 <trap+0x1c8>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
801056c0:	83 e8 20             	sub    $0x20,%eax
801056c3:	83 f8 1f             	cmp    $0x1f,%eax
801056c6:	0f 86 f4 00 00 00    	jbe    801057c0 <trap+0x118>
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
801056cc:	e8 b7 db ff ff       	call   80103288 <myproc>
801056d1:	85 c0                	test   %eax,%eax
801056d3:	0f 84 e2 01 00 00    	je     801058bb <trap+0x213>
801056d9:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
801056dd:	0f 84 d8 01 00 00    	je     801058bb <trap+0x213>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801056e3:	0f 20 d1             	mov    %cr2,%ecx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801056e6:	8b 53 38             	mov    0x38(%ebx),%edx
801056e9:	89 55 dc             	mov    %edx,-0x24(%ebp)
801056ec:	89 4d d8             	mov    %ecx,-0x28(%ebp)
801056ef:	e8 60 db ff ff       	call   80103254 <cpuid>
801056f4:	89 c7                	mov    %eax,%edi
801056f6:	8b 73 34             	mov    0x34(%ebx),%esi
801056f9:	8b 43 30             	mov    0x30(%ebx),%eax
801056fc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
801056ff:	e8 84 db ff ff       	call   80103288 <myproc>
80105704:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105707:	e8 7c db ff ff       	call   80103288 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010570c:	8b 4d d8             	mov    -0x28(%ebp),%ecx
8010570f:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
80105713:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105716:	89 54 24 18          	mov    %edx,0x18(%esp)
8010571a:	89 7c 24 14          	mov    %edi,0x14(%esp)
8010571e:	89 74 24 10          	mov    %esi,0x10(%esp)
80105722:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80105725:	89 54 24 0c          	mov    %edx,0xc(%esp)
            myproc()->pid, myproc()->name, tf->trapno,
80105729:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010572c:	83 c2 6c             	add    $0x6c,%edx
8010572f:	89 54 24 08          	mov    %edx,0x8(%esp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105733:	8b 40 10             	mov    0x10(%eax),%eax
80105736:	89 44 24 04          	mov    %eax,0x4(%esp)
8010573a:	c7 04 24 a0 76 10 80 	movl   $0x801076a0,(%esp)
80105741:	e8 6e ae ff ff       	call   801005b4 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80105746:	e8 3d db ff ff       	call   80103288 <myproc>
8010574b:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80105752:	66 90                	xchg   %ax,%ax
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105754:	e8 2f db ff ff       	call   80103288 <myproc>
80105759:	85 c0                	test   %eax,%eax
8010575b:	74 1c                	je     80105779 <trap+0xd1>
8010575d:	e8 26 db ff ff       	call   80103288 <myproc>
80105762:	8b 50 24             	mov    0x24(%eax),%edx
80105765:	85 d2                	test   %edx,%edx
80105767:	74 10                	je     80105779 <trap+0xd1>
80105769:	8b 43 3c             	mov    0x3c(%ebx),%eax
8010576c:	83 e0 03             	and    $0x3,%eax
8010576f:	66 83 f8 03          	cmp    $0x3,%ax
80105773:	0f 84 2f 01 00 00    	je     801058a8 <trap+0x200>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105779:	e8 0a db ff ff       	call   80103288 <myproc>
8010577e:	85 c0                	test   %eax,%eax
80105780:	74 0f                	je     80105791 <trap+0xe9>
80105782:	e8 01 db ff ff       	call   80103288 <myproc>
80105787:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
8010578b:	0f 84 cb 00 00 00    	je     8010585c <trap+0x1b4>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105791:	e8 f2 da ff ff       	call   80103288 <myproc>
80105796:	85 c0                	test   %eax,%eax
80105798:	74 1c                	je     801057b6 <trap+0x10e>
8010579a:	e8 e9 da ff ff       	call   80103288 <myproc>
8010579f:	8b 40 24             	mov    0x24(%eax),%eax
801057a2:	85 c0                	test   %eax,%eax
801057a4:	74 10                	je     801057b6 <trap+0x10e>
801057a6:	8b 43 3c             	mov    0x3c(%ebx),%eax
801057a9:	83 e0 03             	and    $0x3,%eax
801057ac:	66 83 f8 03          	cmp    $0x3,%ax
801057b0:	0f 84 e3 00 00 00    	je     80105899 <trap+0x1f1>
    exit();
}
801057b6:	83 c4 3c             	add    $0x3c,%esp
801057b9:	5b                   	pop    %ebx
801057ba:	5e                   	pop    %esi
801057bb:	5f                   	pop    %edi
801057bc:	5d                   	pop    %ebp
801057bd:	c3                   	ret    
801057be:	66 90                	xchg   %ax,%ax
  switch(tf->trapno){
801057c0:	ff 24 85 e4 76 10 80 	jmp    *-0x7fef891c(,%eax,4)
801057c7:	90                   	nop
    ideintr();
801057c8:	e8 9f c6 ff ff       	call   80101e6c <ideintr>
    lapiceoi();
801057cd:	e8 a6 cc ff ff       	call   80102478 <lapiceoi>
    break;
801057d2:	eb 80                	jmp    80105754 <trap+0xac>
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801057d4:	8b 7b 38             	mov    0x38(%ebx),%edi
801057d7:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
801057db:	e8 74 da ff ff       	call   80103254 <cpuid>
801057e0:	89 7c 24 0c          	mov    %edi,0xc(%esp)
801057e4:	89 74 24 08          	mov    %esi,0x8(%esp)
801057e8:	89 44 24 04          	mov    %eax,0x4(%esp)
801057ec:	c7 04 24 48 76 10 80 	movl   $0x80107648,(%esp)
801057f3:	e8 bc ad ff ff       	call   801005b4 <cprintf>
    lapiceoi();
801057f8:	e8 7b cc ff ff       	call   80102478 <lapiceoi>
    break;
801057fd:	e9 52 ff ff ff       	jmp    80105754 <trap+0xac>
80105802:	66 90                	xchg   %ax,%ax
    uartintr();
80105804:	e8 eb 01 00 00       	call   801059f4 <uartintr>
    lapiceoi();
80105809:	e8 6a cc ff ff       	call   80102478 <lapiceoi>
    break;
8010580e:	e9 41 ff ff ff       	jmp    80105754 <trap+0xac>
80105813:	90                   	nop
    kbdintr();
80105814:	e8 eb ca ff ff       	call   80102304 <kbdintr>
    lapiceoi();
80105819:	e8 5a cc ff ff       	call   80102478 <lapiceoi>
    break;
8010581e:	e9 31 ff ff ff       	jmp    80105754 <trap+0xac>
80105823:	90                   	nop
    if(cpuid() == 0){
80105824:	e8 2b da ff ff       	call   80103254 <cpuid>
80105829:	85 c0                	test   %eax,%eax
8010582b:	75 a0                	jne    801057cd <trap+0x125>
      acquire(&tickslock);
8010582d:	c7 04 24 60 53 11 80 	movl   $0x80115360,(%esp)
80105834:	e8 a7 eb ff ff       	call   801043e0 <acquire>
      ticks++;
80105839:	ff 05 a0 5b 11 80    	incl   0x80115ba0
      wakeup(&ticks);
8010583f:	c7 04 24 a0 5b 11 80 	movl   $0x80115ba0,(%esp)
80105846:	e8 fd e4 ff ff       	call   80103d48 <wakeup>
      release(&tickslock);
8010584b:	c7 04 24 60 53 11 80 	movl   $0x80115360,(%esp)
80105852:	e8 45 ec ff ff       	call   8010449c <release>
80105857:	e9 71 ff ff ff       	jmp    801057cd <trap+0x125>
  if(myproc() && myproc()->state == RUNNING &&
8010585c:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105860:	0f 85 2b ff ff ff    	jne    80105791 <trap+0xe9>
    yield();
80105866:	e8 dd e2 ff ff       	call   80103b48 <yield>
8010586b:	e9 21 ff ff ff       	jmp    80105791 <trap+0xe9>
    if(myproc()->killed)
80105870:	e8 13 da ff ff       	call   80103288 <myproc>
80105875:	8b 70 24             	mov    0x24(%eax),%esi
80105878:	85 f6                	test   %esi,%esi
8010587a:	75 38                	jne    801058b4 <trap+0x20c>
    myproc()->tf = tf;
8010587c:	e8 07 da ff ff       	call   80103288 <myproc>
80105881:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105884:	e8 7f ef ff ff       	call   80104808 <syscall>
    if(myproc()->killed)
80105889:	e8 fa d9 ff ff       	call   80103288 <myproc>
8010588e:	8b 48 24             	mov    0x24(%eax),%ecx
80105891:	85 c9                	test   %ecx,%ecx
80105893:	0f 84 1d ff ff ff    	je     801057b6 <trap+0x10e>
}
80105899:	83 c4 3c             	add    $0x3c,%esp
8010589c:	5b                   	pop    %ebx
8010589d:	5e                   	pop    %esi
8010589e:	5f                   	pop    %edi
8010589f:	5d                   	pop    %ebp
      exit();
801058a0:	e9 3f e0 ff ff       	jmp    801038e4 <exit>
801058a5:	8d 76 00             	lea    0x0(%esi),%esi
    exit();
801058a8:	e8 37 e0 ff ff       	call   801038e4 <exit>
801058ad:	e9 c7 fe ff ff       	jmp    80105779 <trap+0xd1>
801058b2:	66 90                	xchg   %ax,%ax
      exit();
801058b4:	e8 2b e0 ff ff       	call   801038e4 <exit>
801058b9:	eb c1                	jmp    8010587c <trap+0x1d4>
801058bb:	0f 20 d7             	mov    %cr2,%edi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801058be:	8b 73 38             	mov    0x38(%ebx),%esi
801058c1:	e8 8e d9 ff ff       	call   80103254 <cpuid>
801058c6:	89 7c 24 10          	mov    %edi,0x10(%esp)
801058ca:	89 74 24 0c          	mov    %esi,0xc(%esp)
801058ce:	89 44 24 08          	mov    %eax,0x8(%esp)
801058d2:	8b 43 30             	mov    0x30(%ebx),%eax
801058d5:	89 44 24 04          	mov    %eax,0x4(%esp)
801058d9:	c7 04 24 6c 76 10 80 	movl   $0x8010766c,(%esp)
801058e0:	e8 cf ac ff ff       	call   801005b4 <cprintf>
      panic("trap");
801058e5:	c7 04 24 42 76 10 80 	movl   $0x80107642,(%esp)
801058ec:	e8 1f aa ff ff       	call   80100310 <panic>
801058f1:	66 90                	xchg   %ax,%ax
801058f3:	90                   	nop

801058f4 <uartgetc>:
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
801058f4:	55                   	push   %ebp
801058f5:	89 e5                	mov    %esp,%ebp
  if(!uart)
801058f7:	a1 a8 a5 10 80       	mov    0x8010a5a8,%eax
801058fc:	85 c0                	test   %eax,%eax
801058fe:	74 14                	je     80105914 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105900:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105905:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105906:	a8 01                	test   $0x1,%al
80105908:	74 0a                	je     80105914 <uartgetc+0x20>
8010590a:	b2 f8                	mov    $0xf8,%dl
8010590c:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
8010590d:	0f b6 c0             	movzbl %al,%eax
}
80105910:	5d                   	pop    %ebp
80105911:	c3                   	ret    
80105912:	66 90                	xchg   %ax,%ax
    return -1;
80105914:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105919:	5d                   	pop    %ebp
8010591a:	c3                   	ret    
8010591b:	90                   	nop

8010591c <uartputc>:
  if(!uart)
8010591c:	8b 15 a8 a5 10 80    	mov    0x8010a5a8,%edx
80105922:	85 d2                	test   %edx,%edx
80105924:	74 3c                	je     80105962 <uartputc+0x46>
{
80105926:	55                   	push   %ebp
80105927:	89 e5                	mov    %esp,%ebp
80105929:	56                   	push   %esi
8010592a:	53                   	push   %ebx
8010592b:	83 ec 10             	sub    $0x10,%esp
  if(!uart)
8010592e:	bb 80 00 00 00       	mov    $0x80,%ebx
80105933:	be fd 03 00 00       	mov    $0x3fd,%esi
80105938:	eb 11                	jmp    8010594b <uartputc+0x2f>
8010593a:	66 90                	xchg   %ax,%ax
    microdelay(10);
8010593c:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
80105943:	e8 4c cb ff ff       	call   80102494 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105948:	4b                   	dec    %ebx
80105949:	74 07                	je     80105952 <uartputc+0x36>
8010594b:	89 f2                	mov    %esi,%edx
8010594d:	ec                   	in     (%dx),%al
8010594e:	a8 20                	test   $0x20,%al
80105950:	74 ea                	je     8010593c <uartputc+0x20>
  outb(COM1+0, c);
80105952:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105956:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010595b:	ee                   	out    %al,(%dx)
}
8010595c:	83 c4 10             	add    $0x10,%esp
8010595f:	5b                   	pop    %ebx
80105960:	5e                   	pop    %esi
80105961:	5d                   	pop    %ebp
80105962:	c3                   	ret    
80105963:	90                   	nop

80105964 <uartinit>:
{
80105964:	55                   	push   %ebp
80105965:	89 e5                	mov    %esp,%ebp
80105967:	57                   	push   %edi
80105968:	56                   	push   %esi
80105969:	53                   	push   %ebx
8010596a:	83 ec 1c             	sub    $0x1c,%esp
8010596d:	bf fa 03 00 00       	mov    $0x3fa,%edi
80105972:	31 c0                	xor    %eax,%eax
80105974:	89 fa                	mov    %edi,%edx
80105976:	ee                   	out    %al,(%dx)
80105977:	bb fb 03 00 00       	mov    $0x3fb,%ebx
8010597c:	b0 80                	mov    $0x80,%al
8010597e:	89 da                	mov    %ebx,%edx
80105980:	ee                   	out    %al,(%dx)
80105981:	be f8 03 00 00       	mov    $0x3f8,%esi
80105986:	b0 0c                	mov    $0xc,%al
80105988:	89 f2                	mov    %esi,%edx
8010598a:	ee                   	out    %al,(%dx)
8010598b:	b9 f9 03 00 00       	mov    $0x3f9,%ecx
80105990:	31 c0                	xor    %eax,%eax
80105992:	89 ca                	mov    %ecx,%edx
80105994:	ee                   	out    %al,(%dx)
80105995:	b0 03                	mov    $0x3,%al
80105997:	89 da                	mov    %ebx,%edx
80105999:	ee                   	out    %al,(%dx)
8010599a:	b2 fc                	mov    $0xfc,%dl
8010599c:	31 c0                	xor    %eax,%eax
8010599e:	ee                   	out    %al,(%dx)
8010599f:	b0 01                	mov    $0x1,%al
801059a1:	89 ca                	mov    %ecx,%edx
801059a3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801059a4:	b2 fd                	mov    $0xfd,%dl
801059a6:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
801059a7:	fe c0                	inc    %al
801059a9:	74 41                	je     801059ec <uartinit+0x88>
  uart = 1;
801059ab:	c7 05 a8 a5 10 80 01 	movl   $0x1,0x8010a5a8
801059b2:	00 00 00 
801059b5:	89 fa                	mov    %edi,%edx
801059b7:	ec                   	in     (%dx),%al
801059b8:	89 f2                	mov    %esi,%edx
801059ba:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
801059bb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801059c2:	00 
801059c3:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
801059ca:	e8 ad c6 ff ff       	call   8010207c <ioapicenable>
  for(p="xv6...\n"; *p; p++)
801059cf:	b8 78 00 00 00       	mov    $0x78,%eax
801059d4:	bb 64 77 10 80       	mov    $0x80107764,%ebx
801059d9:	8d 76 00             	lea    0x0(%esi),%esi
    uartputc(*p);
801059dc:	89 04 24             	mov    %eax,(%esp)
801059df:	e8 38 ff ff ff       	call   8010591c <uartputc>
  for(p="xv6...\n"; *p; p++)
801059e4:	43                   	inc    %ebx
801059e5:	0f be 03             	movsbl (%ebx),%eax
801059e8:	84 c0                	test   %al,%al
801059ea:	75 f0                	jne    801059dc <uartinit+0x78>
}
801059ec:	83 c4 1c             	add    $0x1c,%esp
801059ef:	5b                   	pop    %ebx
801059f0:	5e                   	pop    %esi
801059f1:	5f                   	pop    %edi
801059f2:	5d                   	pop    %ebp
801059f3:	c3                   	ret    

801059f4 <uartintr>:

void
uartintr(void)
{
801059f4:	55                   	push   %ebp
801059f5:	89 e5                	mov    %esp,%ebp
801059f7:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
801059fa:	c7 04 24 f4 58 10 80 	movl   $0x801058f4,(%esp)
80105a01:	e8 fa ac ff ff       	call   80100700 <consoleintr>
}
80105a06:	c9                   	leave  
80105a07:	c3                   	ret    

80105a08 <vector0>:
80105a08:	6a 00                	push   $0x0
80105a0a:	6a 00                	push   $0x0
80105a0c:	e9 c6 fb ff ff       	jmp    801055d7 <alltraps>

80105a11 <vector1>:
80105a11:	6a 00                	push   $0x0
80105a13:	6a 01                	push   $0x1
80105a15:	e9 bd fb ff ff       	jmp    801055d7 <alltraps>

80105a1a <vector2>:
80105a1a:	6a 00                	push   $0x0
80105a1c:	6a 02                	push   $0x2
80105a1e:	e9 b4 fb ff ff       	jmp    801055d7 <alltraps>

80105a23 <vector3>:
80105a23:	6a 00                	push   $0x0
80105a25:	6a 03                	push   $0x3
80105a27:	e9 ab fb ff ff       	jmp    801055d7 <alltraps>

80105a2c <vector4>:
80105a2c:	6a 00                	push   $0x0
80105a2e:	6a 04                	push   $0x4
80105a30:	e9 a2 fb ff ff       	jmp    801055d7 <alltraps>

80105a35 <vector5>:
80105a35:	6a 00                	push   $0x0
80105a37:	6a 05                	push   $0x5
80105a39:	e9 99 fb ff ff       	jmp    801055d7 <alltraps>

80105a3e <vector6>:
80105a3e:	6a 00                	push   $0x0
80105a40:	6a 06                	push   $0x6
80105a42:	e9 90 fb ff ff       	jmp    801055d7 <alltraps>

80105a47 <vector7>:
80105a47:	6a 00                	push   $0x0
80105a49:	6a 07                	push   $0x7
80105a4b:	e9 87 fb ff ff       	jmp    801055d7 <alltraps>

80105a50 <vector8>:
80105a50:	6a 08                	push   $0x8
80105a52:	e9 80 fb ff ff       	jmp    801055d7 <alltraps>

80105a57 <vector9>:
80105a57:	6a 00                	push   $0x0
80105a59:	6a 09                	push   $0x9
80105a5b:	e9 77 fb ff ff       	jmp    801055d7 <alltraps>

80105a60 <vector10>:
80105a60:	6a 0a                	push   $0xa
80105a62:	e9 70 fb ff ff       	jmp    801055d7 <alltraps>

80105a67 <vector11>:
80105a67:	6a 0b                	push   $0xb
80105a69:	e9 69 fb ff ff       	jmp    801055d7 <alltraps>

80105a6e <vector12>:
80105a6e:	6a 0c                	push   $0xc
80105a70:	e9 62 fb ff ff       	jmp    801055d7 <alltraps>

80105a75 <vector13>:
80105a75:	6a 0d                	push   $0xd
80105a77:	e9 5b fb ff ff       	jmp    801055d7 <alltraps>

80105a7c <vector14>:
80105a7c:	6a 0e                	push   $0xe
80105a7e:	e9 54 fb ff ff       	jmp    801055d7 <alltraps>

80105a83 <vector15>:
80105a83:	6a 00                	push   $0x0
80105a85:	6a 0f                	push   $0xf
80105a87:	e9 4b fb ff ff       	jmp    801055d7 <alltraps>

80105a8c <vector16>:
80105a8c:	6a 00                	push   $0x0
80105a8e:	6a 10                	push   $0x10
80105a90:	e9 42 fb ff ff       	jmp    801055d7 <alltraps>

80105a95 <vector17>:
80105a95:	6a 11                	push   $0x11
80105a97:	e9 3b fb ff ff       	jmp    801055d7 <alltraps>

80105a9c <vector18>:
80105a9c:	6a 00                	push   $0x0
80105a9e:	6a 12                	push   $0x12
80105aa0:	e9 32 fb ff ff       	jmp    801055d7 <alltraps>

80105aa5 <vector19>:
80105aa5:	6a 00                	push   $0x0
80105aa7:	6a 13                	push   $0x13
80105aa9:	e9 29 fb ff ff       	jmp    801055d7 <alltraps>

80105aae <vector20>:
80105aae:	6a 00                	push   $0x0
80105ab0:	6a 14                	push   $0x14
80105ab2:	e9 20 fb ff ff       	jmp    801055d7 <alltraps>

80105ab7 <vector21>:
80105ab7:	6a 00                	push   $0x0
80105ab9:	6a 15                	push   $0x15
80105abb:	e9 17 fb ff ff       	jmp    801055d7 <alltraps>

80105ac0 <vector22>:
80105ac0:	6a 00                	push   $0x0
80105ac2:	6a 16                	push   $0x16
80105ac4:	e9 0e fb ff ff       	jmp    801055d7 <alltraps>

80105ac9 <vector23>:
80105ac9:	6a 00                	push   $0x0
80105acb:	6a 17                	push   $0x17
80105acd:	e9 05 fb ff ff       	jmp    801055d7 <alltraps>

80105ad2 <vector24>:
80105ad2:	6a 00                	push   $0x0
80105ad4:	6a 18                	push   $0x18
80105ad6:	e9 fc fa ff ff       	jmp    801055d7 <alltraps>

80105adb <vector25>:
80105adb:	6a 00                	push   $0x0
80105add:	6a 19                	push   $0x19
80105adf:	e9 f3 fa ff ff       	jmp    801055d7 <alltraps>

80105ae4 <vector26>:
80105ae4:	6a 00                	push   $0x0
80105ae6:	6a 1a                	push   $0x1a
80105ae8:	e9 ea fa ff ff       	jmp    801055d7 <alltraps>

80105aed <vector27>:
80105aed:	6a 00                	push   $0x0
80105aef:	6a 1b                	push   $0x1b
80105af1:	e9 e1 fa ff ff       	jmp    801055d7 <alltraps>

80105af6 <vector28>:
80105af6:	6a 00                	push   $0x0
80105af8:	6a 1c                	push   $0x1c
80105afa:	e9 d8 fa ff ff       	jmp    801055d7 <alltraps>

80105aff <vector29>:
80105aff:	6a 00                	push   $0x0
80105b01:	6a 1d                	push   $0x1d
80105b03:	e9 cf fa ff ff       	jmp    801055d7 <alltraps>

80105b08 <vector30>:
80105b08:	6a 00                	push   $0x0
80105b0a:	6a 1e                	push   $0x1e
80105b0c:	e9 c6 fa ff ff       	jmp    801055d7 <alltraps>

80105b11 <vector31>:
80105b11:	6a 00                	push   $0x0
80105b13:	6a 1f                	push   $0x1f
80105b15:	e9 bd fa ff ff       	jmp    801055d7 <alltraps>

80105b1a <vector32>:
80105b1a:	6a 00                	push   $0x0
80105b1c:	6a 20                	push   $0x20
80105b1e:	e9 b4 fa ff ff       	jmp    801055d7 <alltraps>

80105b23 <vector33>:
80105b23:	6a 00                	push   $0x0
80105b25:	6a 21                	push   $0x21
80105b27:	e9 ab fa ff ff       	jmp    801055d7 <alltraps>

80105b2c <vector34>:
80105b2c:	6a 00                	push   $0x0
80105b2e:	6a 22                	push   $0x22
80105b30:	e9 a2 fa ff ff       	jmp    801055d7 <alltraps>

80105b35 <vector35>:
80105b35:	6a 00                	push   $0x0
80105b37:	6a 23                	push   $0x23
80105b39:	e9 99 fa ff ff       	jmp    801055d7 <alltraps>

80105b3e <vector36>:
80105b3e:	6a 00                	push   $0x0
80105b40:	6a 24                	push   $0x24
80105b42:	e9 90 fa ff ff       	jmp    801055d7 <alltraps>

80105b47 <vector37>:
80105b47:	6a 00                	push   $0x0
80105b49:	6a 25                	push   $0x25
80105b4b:	e9 87 fa ff ff       	jmp    801055d7 <alltraps>

80105b50 <vector38>:
80105b50:	6a 00                	push   $0x0
80105b52:	6a 26                	push   $0x26
80105b54:	e9 7e fa ff ff       	jmp    801055d7 <alltraps>

80105b59 <vector39>:
80105b59:	6a 00                	push   $0x0
80105b5b:	6a 27                	push   $0x27
80105b5d:	e9 75 fa ff ff       	jmp    801055d7 <alltraps>

80105b62 <vector40>:
80105b62:	6a 00                	push   $0x0
80105b64:	6a 28                	push   $0x28
80105b66:	e9 6c fa ff ff       	jmp    801055d7 <alltraps>

80105b6b <vector41>:
80105b6b:	6a 00                	push   $0x0
80105b6d:	6a 29                	push   $0x29
80105b6f:	e9 63 fa ff ff       	jmp    801055d7 <alltraps>

80105b74 <vector42>:
80105b74:	6a 00                	push   $0x0
80105b76:	6a 2a                	push   $0x2a
80105b78:	e9 5a fa ff ff       	jmp    801055d7 <alltraps>

80105b7d <vector43>:
80105b7d:	6a 00                	push   $0x0
80105b7f:	6a 2b                	push   $0x2b
80105b81:	e9 51 fa ff ff       	jmp    801055d7 <alltraps>

80105b86 <vector44>:
80105b86:	6a 00                	push   $0x0
80105b88:	6a 2c                	push   $0x2c
80105b8a:	e9 48 fa ff ff       	jmp    801055d7 <alltraps>

80105b8f <vector45>:
80105b8f:	6a 00                	push   $0x0
80105b91:	6a 2d                	push   $0x2d
80105b93:	e9 3f fa ff ff       	jmp    801055d7 <alltraps>

80105b98 <vector46>:
80105b98:	6a 00                	push   $0x0
80105b9a:	6a 2e                	push   $0x2e
80105b9c:	e9 36 fa ff ff       	jmp    801055d7 <alltraps>

80105ba1 <vector47>:
80105ba1:	6a 00                	push   $0x0
80105ba3:	6a 2f                	push   $0x2f
80105ba5:	e9 2d fa ff ff       	jmp    801055d7 <alltraps>

80105baa <vector48>:
80105baa:	6a 00                	push   $0x0
80105bac:	6a 30                	push   $0x30
80105bae:	e9 24 fa ff ff       	jmp    801055d7 <alltraps>

80105bb3 <vector49>:
80105bb3:	6a 00                	push   $0x0
80105bb5:	6a 31                	push   $0x31
80105bb7:	e9 1b fa ff ff       	jmp    801055d7 <alltraps>

80105bbc <vector50>:
80105bbc:	6a 00                	push   $0x0
80105bbe:	6a 32                	push   $0x32
80105bc0:	e9 12 fa ff ff       	jmp    801055d7 <alltraps>

80105bc5 <vector51>:
80105bc5:	6a 00                	push   $0x0
80105bc7:	6a 33                	push   $0x33
80105bc9:	e9 09 fa ff ff       	jmp    801055d7 <alltraps>

80105bce <vector52>:
80105bce:	6a 00                	push   $0x0
80105bd0:	6a 34                	push   $0x34
80105bd2:	e9 00 fa ff ff       	jmp    801055d7 <alltraps>

80105bd7 <vector53>:
80105bd7:	6a 00                	push   $0x0
80105bd9:	6a 35                	push   $0x35
80105bdb:	e9 f7 f9 ff ff       	jmp    801055d7 <alltraps>

80105be0 <vector54>:
80105be0:	6a 00                	push   $0x0
80105be2:	6a 36                	push   $0x36
80105be4:	e9 ee f9 ff ff       	jmp    801055d7 <alltraps>

80105be9 <vector55>:
80105be9:	6a 00                	push   $0x0
80105beb:	6a 37                	push   $0x37
80105bed:	e9 e5 f9 ff ff       	jmp    801055d7 <alltraps>

80105bf2 <vector56>:
80105bf2:	6a 00                	push   $0x0
80105bf4:	6a 38                	push   $0x38
80105bf6:	e9 dc f9 ff ff       	jmp    801055d7 <alltraps>

80105bfb <vector57>:
80105bfb:	6a 00                	push   $0x0
80105bfd:	6a 39                	push   $0x39
80105bff:	e9 d3 f9 ff ff       	jmp    801055d7 <alltraps>

80105c04 <vector58>:
80105c04:	6a 00                	push   $0x0
80105c06:	6a 3a                	push   $0x3a
80105c08:	e9 ca f9 ff ff       	jmp    801055d7 <alltraps>

80105c0d <vector59>:
80105c0d:	6a 00                	push   $0x0
80105c0f:	6a 3b                	push   $0x3b
80105c11:	e9 c1 f9 ff ff       	jmp    801055d7 <alltraps>

80105c16 <vector60>:
80105c16:	6a 00                	push   $0x0
80105c18:	6a 3c                	push   $0x3c
80105c1a:	e9 b8 f9 ff ff       	jmp    801055d7 <alltraps>

80105c1f <vector61>:
80105c1f:	6a 00                	push   $0x0
80105c21:	6a 3d                	push   $0x3d
80105c23:	e9 af f9 ff ff       	jmp    801055d7 <alltraps>

80105c28 <vector62>:
80105c28:	6a 00                	push   $0x0
80105c2a:	6a 3e                	push   $0x3e
80105c2c:	e9 a6 f9 ff ff       	jmp    801055d7 <alltraps>

80105c31 <vector63>:
80105c31:	6a 00                	push   $0x0
80105c33:	6a 3f                	push   $0x3f
80105c35:	e9 9d f9 ff ff       	jmp    801055d7 <alltraps>

80105c3a <vector64>:
80105c3a:	6a 00                	push   $0x0
80105c3c:	6a 40                	push   $0x40
80105c3e:	e9 94 f9 ff ff       	jmp    801055d7 <alltraps>

80105c43 <vector65>:
80105c43:	6a 00                	push   $0x0
80105c45:	6a 41                	push   $0x41
80105c47:	e9 8b f9 ff ff       	jmp    801055d7 <alltraps>

80105c4c <vector66>:
80105c4c:	6a 00                	push   $0x0
80105c4e:	6a 42                	push   $0x42
80105c50:	e9 82 f9 ff ff       	jmp    801055d7 <alltraps>

80105c55 <vector67>:
80105c55:	6a 00                	push   $0x0
80105c57:	6a 43                	push   $0x43
80105c59:	e9 79 f9 ff ff       	jmp    801055d7 <alltraps>

80105c5e <vector68>:
80105c5e:	6a 00                	push   $0x0
80105c60:	6a 44                	push   $0x44
80105c62:	e9 70 f9 ff ff       	jmp    801055d7 <alltraps>

80105c67 <vector69>:
80105c67:	6a 00                	push   $0x0
80105c69:	6a 45                	push   $0x45
80105c6b:	e9 67 f9 ff ff       	jmp    801055d7 <alltraps>

80105c70 <vector70>:
80105c70:	6a 00                	push   $0x0
80105c72:	6a 46                	push   $0x46
80105c74:	e9 5e f9 ff ff       	jmp    801055d7 <alltraps>

80105c79 <vector71>:
80105c79:	6a 00                	push   $0x0
80105c7b:	6a 47                	push   $0x47
80105c7d:	e9 55 f9 ff ff       	jmp    801055d7 <alltraps>

80105c82 <vector72>:
80105c82:	6a 00                	push   $0x0
80105c84:	6a 48                	push   $0x48
80105c86:	e9 4c f9 ff ff       	jmp    801055d7 <alltraps>

80105c8b <vector73>:
80105c8b:	6a 00                	push   $0x0
80105c8d:	6a 49                	push   $0x49
80105c8f:	e9 43 f9 ff ff       	jmp    801055d7 <alltraps>

80105c94 <vector74>:
80105c94:	6a 00                	push   $0x0
80105c96:	6a 4a                	push   $0x4a
80105c98:	e9 3a f9 ff ff       	jmp    801055d7 <alltraps>

80105c9d <vector75>:
80105c9d:	6a 00                	push   $0x0
80105c9f:	6a 4b                	push   $0x4b
80105ca1:	e9 31 f9 ff ff       	jmp    801055d7 <alltraps>

80105ca6 <vector76>:
80105ca6:	6a 00                	push   $0x0
80105ca8:	6a 4c                	push   $0x4c
80105caa:	e9 28 f9 ff ff       	jmp    801055d7 <alltraps>

80105caf <vector77>:
80105caf:	6a 00                	push   $0x0
80105cb1:	6a 4d                	push   $0x4d
80105cb3:	e9 1f f9 ff ff       	jmp    801055d7 <alltraps>

80105cb8 <vector78>:
80105cb8:	6a 00                	push   $0x0
80105cba:	6a 4e                	push   $0x4e
80105cbc:	e9 16 f9 ff ff       	jmp    801055d7 <alltraps>

80105cc1 <vector79>:
80105cc1:	6a 00                	push   $0x0
80105cc3:	6a 4f                	push   $0x4f
80105cc5:	e9 0d f9 ff ff       	jmp    801055d7 <alltraps>

80105cca <vector80>:
80105cca:	6a 00                	push   $0x0
80105ccc:	6a 50                	push   $0x50
80105cce:	e9 04 f9 ff ff       	jmp    801055d7 <alltraps>

80105cd3 <vector81>:
80105cd3:	6a 00                	push   $0x0
80105cd5:	6a 51                	push   $0x51
80105cd7:	e9 fb f8 ff ff       	jmp    801055d7 <alltraps>

80105cdc <vector82>:
80105cdc:	6a 00                	push   $0x0
80105cde:	6a 52                	push   $0x52
80105ce0:	e9 f2 f8 ff ff       	jmp    801055d7 <alltraps>

80105ce5 <vector83>:
80105ce5:	6a 00                	push   $0x0
80105ce7:	6a 53                	push   $0x53
80105ce9:	e9 e9 f8 ff ff       	jmp    801055d7 <alltraps>

80105cee <vector84>:
80105cee:	6a 00                	push   $0x0
80105cf0:	6a 54                	push   $0x54
80105cf2:	e9 e0 f8 ff ff       	jmp    801055d7 <alltraps>

80105cf7 <vector85>:
80105cf7:	6a 00                	push   $0x0
80105cf9:	6a 55                	push   $0x55
80105cfb:	e9 d7 f8 ff ff       	jmp    801055d7 <alltraps>

80105d00 <vector86>:
80105d00:	6a 00                	push   $0x0
80105d02:	6a 56                	push   $0x56
80105d04:	e9 ce f8 ff ff       	jmp    801055d7 <alltraps>

80105d09 <vector87>:
80105d09:	6a 00                	push   $0x0
80105d0b:	6a 57                	push   $0x57
80105d0d:	e9 c5 f8 ff ff       	jmp    801055d7 <alltraps>

80105d12 <vector88>:
80105d12:	6a 00                	push   $0x0
80105d14:	6a 58                	push   $0x58
80105d16:	e9 bc f8 ff ff       	jmp    801055d7 <alltraps>

80105d1b <vector89>:
80105d1b:	6a 00                	push   $0x0
80105d1d:	6a 59                	push   $0x59
80105d1f:	e9 b3 f8 ff ff       	jmp    801055d7 <alltraps>

80105d24 <vector90>:
80105d24:	6a 00                	push   $0x0
80105d26:	6a 5a                	push   $0x5a
80105d28:	e9 aa f8 ff ff       	jmp    801055d7 <alltraps>

80105d2d <vector91>:
80105d2d:	6a 00                	push   $0x0
80105d2f:	6a 5b                	push   $0x5b
80105d31:	e9 a1 f8 ff ff       	jmp    801055d7 <alltraps>

80105d36 <vector92>:
80105d36:	6a 00                	push   $0x0
80105d38:	6a 5c                	push   $0x5c
80105d3a:	e9 98 f8 ff ff       	jmp    801055d7 <alltraps>

80105d3f <vector93>:
80105d3f:	6a 00                	push   $0x0
80105d41:	6a 5d                	push   $0x5d
80105d43:	e9 8f f8 ff ff       	jmp    801055d7 <alltraps>

80105d48 <vector94>:
80105d48:	6a 00                	push   $0x0
80105d4a:	6a 5e                	push   $0x5e
80105d4c:	e9 86 f8 ff ff       	jmp    801055d7 <alltraps>

80105d51 <vector95>:
80105d51:	6a 00                	push   $0x0
80105d53:	6a 5f                	push   $0x5f
80105d55:	e9 7d f8 ff ff       	jmp    801055d7 <alltraps>

80105d5a <vector96>:
80105d5a:	6a 00                	push   $0x0
80105d5c:	6a 60                	push   $0x60
80105d5e:	e9 74 f8 ff ff       	jmp    801055d7 <alltraps>

80105d63 <vector97>:
80105d63:	6a 00                	push   $0x0
80105d65:	6a 61                	push   $0x61
80105d67:	e9 6b f8 ff ff       	jmp    801055d7 <alltraps>

80105d6c <vector98>:
80105d6c:	6a 00                	push   $0x0
80105d6e:	6a 62                	push   $0x62
80105d70:	e9 62 f8 ff ff       	jmp    801055d7 <alltraps>

80105d75 <vector99>:
80105d75:	6a 00                	push   $0x0
80105d77:	6a 63                	push   $0x63
80105d79:	e9 59 f8 ff ff       	jmp    801055d7 <alltraps>

80105d7e <vector100>:
80105d7e:	6a 00                	push   $0x0
80105d80:	6a 64                	push   $0x64
80105d82:	e9 50 f8 ff ff       	jmp    801055d7 <alltraps>

80105d87 <vector101>:
80105d87:	6a 00                	push   $0x0
80105d89:	6a 65                	push   $0x65
80105d8b:	e9 47 f8 ff ff       	jmp    801055d7 <alltraps>

80105d90 <vector102>:
80105d90:	6a 00                	push   $0x0
80105d92:	6a 66                	push   $0x66
80105d94:	e9 3e f8 ff ff       	jmp    801055d7 <alltraps>

80105d99 <vector103>:
80105d99:	6a 00                	push   $0x0
80105d9b:	6a 67                	push   $0x67
80105d9d:	e9 35 f8 ff ff       	jmp    801055d7 <alltraps>

80105da2 <vector104>:
80105da2:	6a 00                	push   $0x0
80105da4:	6a 68                	push   $0x68
80105da6:	e9 2c f8 ff ff       	jmp    801055d7 <alltraps>

80105dab <vector105>:
80105dab:	6a 00                	push   $0x0
80105dad:	6a 69                	push   $0x69
80105daf:	e9 23 f8 ff ff       	jmp    801055d7 <alltraps>

80105db4 <vector106>:
80105db4:	6a 00                	push   $0x0
80105db6:	6a 6a                	push   $0x6a
80105db8:	e9 1a f8 ff ff       	jmp    801055d7 <alltraps>

80105dbd <vector107>:
80105dbd:	6a 00                	push   $0x0
80105dbf:	6a 6b                	push   $0x6b
80105dc1:	e9 11 f8 ff ff       	jmp    801055d7 <alltraps>

80105dc6 <vector108>:
80105dc6:	6a 00                	push   $0x0
80105dc8:	6a 6c                	push   $0x6c
80105dca:	e9 08 f8 ff ff       	jmp    801055d7 <alltraps>

80105dcf <vector109>:
80105dcf:	6a 00                	push   $0x0
80105dd1:	6a 6d                	push   $0x6d
80105dd3:	e9 ff f7 ff ff       	jmp    801055d7 <alltraps>

80105dd8 <vector110>:
80105dd8:	6a 00                	push   $0x0
80105dda:	6a 6e                	push   $0x6e
80105ddc:	e9 f6 f7 ff ff       	jmp    801055d7 <alltraps>

80105de1 <vector111>:
80105de1:	6a 00                	push   $0x0
80105de3:	6a 6f                	push   $0x6f
80105de5:	e9 ed f7 ff ff       	jmp    801055d7 <alltraps>

80105dea <vector112>:
80105dea:	6a 00                	push   $0x0
80105dec:	6a 70                	push   $0x70
80105dee:	e9 e4 f7 ff ff       	jmp    801055d7 <alltraps>

80105df3 <vector113>:
80105df3:	6a 00                	push   $0x0
80105df5:	6a 71                	push   $0x71
80105df7:	e9 db f7 ff ff       	jmp    801055d7 <alltraps>

80105dfc <vector114>:
80105dfc:	6a 00                	push   $0x0
80105dfe:	6a 72                	push   $0x72
80105e00:	e9 d2 f7 ff ff       	jmp    801055d7 <alltraps>

80105e05 <vector115>:
80105e05:	6a 00                	push   $0x0
80105e07:	6a 73                	push   $0x73
80105e09:	e9 c9 f7 ff ff       	jmp    801055d7 <alltraps>

80105e0e <vector116>:
80105e0e:	6a 00                	push   $0x0
80105e10:	6a 74                	push   $0x74
80105e12:	e9 c0 f7 ff ff       	jmp    801055d7 <alltraps>

80105e17 <vector117>:
80105e17:	6a 00                	push   $0x0
80105e19:	6a 75                	push   $0x75
80105e1b:	e9 b7 f7 ff ff       	jmp    801055d7 <alltraps>

80105e20 <vector118>:
80105e20:	6a 00                	push   $0x0
80105e22:	6a 76                	push   $0x76
80105e24:	e9 ae f7 ff ff       	jmp    801055d7 <alltraps>

80105e29 <vector119>:
80105e29:	6a 00                	push   $0x0
80105e2b:	6a 77                	push   $0x77
80105e2d:	e9 a5 f7 ff ff       	jmp    801055d7 <alltraps>

80105e32 <vector120>:
80105e32:	6a 00                	push   $0x0
80105e34:	6a 78                	push   $0x78
80105e36:	e9 9c f7 ff ff       	jmp    801055d7 <alltraps>

80105e3b <vector121>:
80105e3b:	6a 00                	push   $0x0
80105e3d:	6a 79                	push   $0x79
80105e3f:	e9 93 f7 ff ff       	jmp    801055d7 <alltraps>

80105e44 <vector122>:
80105e44:	6a 00                	push   $0x0
80105e46:	6a 7a                	push   $0x7a
80105e48:	e9 8a f7 ff ff       	jmp    801055d7 <alltraps>

80105e4d <vector123>:
80105e4d:	6a 00                	push   $0x0
80105e4f:	6a 7b                	push   $0x7b
80105e51:	e9 81 f7 ff ff       	jmp    801055d7 <alltraps>

80105e56 <vector124>:
80105e56:	6a 00                	push   $0x0
80105e58:	6a 7c                	push   $0x7c
80105e5a:	e9 78 f7 ff ff       	jmp    801055d7 <alltraps>

80105e5f <vector125>:
80105e5f:	6a 00                	push   $0x0
80105e61:	6a 7d                	push   $0x7d
80105e63:	e9 6f f7 ff ff       	jmp    801055d7 <alltraps>

80105e68 <vector126>:
80105e68:	6a 00                	push   $0x0
80105e6a:	6a 7e                	push   $0x7e
80105e6c:	e9 66 f7 ff ff       	jmp    801055d7 <alltraps>

80105e71 <vector127>:
80105e71:	6a 00                	push   $0x0
80105e73:	6a 7f                	push   $0x7f
80105e75:	e9 5d f7 ff ff       	jmp    801055d7 <alltraps>

80105e7a <vector128>:
80105e7a:	6a 00                	push   $0x0
80105e7c:	68 80 00 00 00       	push   $0x80
80105e81:	e9 51 f7 ff ff       	jmp    801055d7 <alltraps>

80105e86 <vector129>:
80105e86:	6a 00                	push   $0x0
80105e88:	68 81 00 00 00       	push   $0x81
80105e8d:	e9 45 f7 ff ff       	jmp    801055d7 <alltraps>

80105e92 <vector130>:
80105e92:	6a 00                	push   $0x0
80105e94:	68 82 00 00 00       	push   $0x82
80105e99:	e9 39 f7 ff ff       	jmp    801055d7 <alltraps>

80105e9e <vector131>:
80105e9e:	6a 00                	push   $0x0
80105ea0:	68 83 00 00 00       	push   $0x83
80105ea5:	e9 2d f7 ff ff       	jmp    801055d7 <alltraps>

80105eaa <vector132>:
80105eaa:	6a 00                	push   $0x0
80105eac:	68 84 00 00 00       	push   $0x84
80105eb1:	e9 21 f7 ff ff       	jmp    801055d7 <alltraps>

80105eb6 <vector133>:
80105eb6:	6a 00                	push   $0x0
80105eb8:	68 85 00 00 00       	push   $0x85
80105ebd:	e9 15 f7 ff ff       	jmp    801055d7 <alltraps>

80105ec2 <vector134>:
80105ec2:	6a 00                	push   $0x0
80105ec4:	68 86 00 00 00       	push   $0x86
80105ec9:	e9 09 f7 ff ff       	jmp    801055d7 <alltraps>

80105ece <vector135>:
80105ece:	6a 00                	push   $0x0
80105ed0:	68 87 00 00 00       	push   $0x87
80105ed5:	e9 fd f6 ff ff       	jmp    801055d7 <alltraps>

80105eda <vector136>:
80105eda:	6a 00                	push   $0x0
80105edc:	68 88 00 00 00       	push   $0x88
80105ee1:	e9 f1 f6 ff ff       	jmp    801055d7 <alltraps>

80105ee6 <vector137>:
80105ee6:	6a 00                	push   $0x0
80105ee8:	68 89 00 00 00       	push   $0x89
80105eed:	e9 e5 f6 ff ff       	jmp    801055d7 <alltraps>

80105ef2 <vector138>:
80105ef2:	6a 00                	push   $0x0
80105ef4:	68 8a 00 00 00       	push   $0x8a
80105ef9:	e9 d9 f6 ff ff       	jmp    801055d7 <alltraps>

80105efe <vector139>:
80105efe:	6a 00                	push   $0x0
80105f00:	68 8b 00 00 00       	push   $0x8b
80105f05:	e9 cd f6 ff ff       	jmp    801055d7 <alltraps>

80105f0a <vector140>:
80105f0a:	6a 00                	push   $0x0
80105f0c:	68 8c 00 00 00       	push   $0x8c
80105f11:	e9 c1 f6 ff ff       	jmp    801055d7 <alltraps>

80105f16 <vector141>:
80105f16:	6a 00                	push   $0x0
80105f18:	68 8d 00 00 00       	push   $0x8d
80105f1d:	e9 b5 f6 ff ff       	jmp    801055d7 <alltraps>

80105f22 <vector142>:
80105f22:	6a 00                	push   $0x0
80105f24:	68 8e 00 00 00       	push   $0x8e
80105f29:	e9 a9 f6 ff ff       	jmp    801055d7 <alltraps>

80105f2e <vector143>:
80105f2e:	6a 00                	push   $0x0
80105f30:	68 8f 00 00 00       	push   $0x8f
80105f35:	e9 9d f6 ff ff       	jmp    801055d7 <alltraps>

80105f3a <vector144>:
80105f3a:	6a 00                	push   $0x0
80105f3c:	68 90 00 00 00       	push   $0x90
80105f41:	e9 91 f6 ff ff       	jmp    801055d7 <alltraps>

80105f46 <vector145>:
80105f46:	6a 00                	push   $0x0
80105f48:	68 91 00 00 00       	push   $0x91
80105f4d:	e9 85 f6 ff ff       	jmp    801055d7 <alltraps>

80105f52 <vector146>:
80105f52:	6a 00                	push   $0x0
80105f54:	68 92 00 00 00       	push   $0x92
80105f59:	e9 79 f6 ff ff       	jmp    801055d7 <alltraps>

80105f5e <vector147>:
80105f5e:	6a 00                	push   $0x0
80105f60:	68 93 00 00 00       	push   $0x93
80105f65:	e9 6d f6 ff ff       	jmp    801055d7 <alltraps>

80105f6a <vector148>:
80105f6a:	6a 00                	push   $0x0
80105f6c:	68 94 00 00 00       	push   $0x94
80105f71:	e9 61 f6 ff ff       	jmp    801055d7 <alltraps>

80105f76 <vector149>:
80105f76:	6a 00                	push   $0x0
80105f78:	68 95 00 00 00       	push   $0x95
80105f7d:	e9 55 f6 ff ff       	jmp    801055d7 <alltraps>

80105f82 <vector150>:
80105f82:	6a 00                	push   $0x0
80105f84:	68 96 00 00 00       	push   $0x96
80105f89:	e9 49 f6 ff ff       	jmp    801055d7 <alltraps>

80105f8e <vector151>:
80105f8e:	6a 00                	push   $0x0
80105f90:	68 97 00 00 00       	push   $0x97
80105f95:	e9 3d f6 ff ff       	jmp    801055d7 <alltraps>

80105f9a <vector152>:
80105f9a:	6a 00                	push   $0x0
80105f9c:	68 98 00 00 00       	push   $0x98
80105fa1:	e9 31 f6 ff ff       	jmp    801055d7 <alltraps>

80105fa6 <vector153>:
80105fa6:	6a 00                	push   $0x0
80105fa8:	68 99 00 00 00       	push   $0x99
80105fad:	e9 25 f6 ff ff       	jmp    801055d7 <alltraps>

80105fb2 <vector154>:
80105fb2:	6a 00                	push   $0x0
80105fb4:	68 9a 00 00 00       	push   $0x9a
80105fb9:	e9 19 f6 ff ff       	jmp    801055d7 <alltraps>

80105fbe <vector155>:
80105fbe:	6a 00                	push   $0x0
80105fc0:	68 9b 00 00 00       	push   $0x9b
80105fc5:	e9 0d f6 ff ff       	jmp    801055d7 <alltraps>

80105fca <vector156>:
80105fca:	6a 00                	push   $0x0
80105fcc:	68 9c 00 00 00       	push   $0x9c
80105fd1:	e9 01 f6 ff ff       	jmp    801055d7 <alltraps>

80105fd6 <vector157>:
80105fd6:	6a 00                	push   $0x0
80105fd8:	68 9d 00 00 00       	push   $0x9d
80105fdd:	e9 f5 f5 ff ff       	jmp    801055d7 <alltraps>

80105fe2 <vector158>:
80105fe2:	6a 00                	push   $0x0
80105fe4:	68 9e 00 00 00       	push   $0x9e
80105fe9:	e9 e9 f5 ff ff       	jmp    801055d7 <alltraps>

80105fee <vector159>:
80105fee:	6a 00                	push   $0x0
80105ff0:	68 9f 00 00 00       	push   $0x9f
80105ff5:	e9 dd f5 ff ff       	jmp    801055d7 <alltraps>

80105ffa <vector160>:
80105ffa:	6a 00                	push   $0x0
80105ffc:	68 a0 00 00 00       	push   $0xa0
80106001:	e9 d1 f5 ff ff       	jmp    801055d7 <alltraps>

80106006 <vector161>:
80106006:	6a 00                	push   $0x0
80106008:	68 a1 00 00 00       	push   $0xa1
8010600d:	e9 c5 f5 ff ff       	jmp    801055d7 <alltraps>

80106012 <vector162>:
80106012:	6a 00                	push   $0x0
80106014:	68 a2 00 00 00       	push   $0xa2
80106019:	e9 b9 f5 ff ff       	jmp    801055d7 <alltraps>

8010601e <vector163>:
8010601e:	6a 00                	push   $0x0
80106020:	68 a3 00 00 00       	push   $0xa3
80106025:	e9 ad f5 ff ff       	jmp    801055d7 <alltraps>

8010602a <vector164>:
8010602a:	6a 00                	push   $0x0
8010602c:	68 a4 00 00 00       	push   $0xa4
80106031:	e9 a1 f5 ff ff       	jmp    801055d7 <alltraps>

80106036 <vector165>:
80106036:	6a 00                	push   $0x0
80106038:	68 a5 00 00 00       	push   $0xa5
8010603d:	e9 95 f5 ff ff       	jmp    801055d7 <alltraps>

80106042 <vector166>:
80106042:	6a 00                	push   $0x0
80106044:	68 a6 00 00 00       	push   $0xa6
80106049:	e9 89 f5 ff ff       	jmp    801055d7 <alltraps>

8010604e <vector167>:
8010604e:	6a 00                	push   $0x0
80106050:	68 a7 00 00 00       	push   $0xa7
80106055:	e9 7d f5 ff ff       	jmp    801055d7 <alltraps>

8010605a <vector168>:
8010605a:	6a 00                	push   $0x0
8010605c:	68 a8 00 00 00       	push   $0xa8
80106061:	e9 71 f5 ff ff       	jmp    801055d7 <alltraps>

80106066 <vector169>:
80106066:	6a 00                	push   $0x0
80106068:	68 a9 00 00 00       	push   $0xa9
8010606d:	e9 65 f5 ff ff       	jmp    801055d7 <alltraps>

80106072 <vector170>:
80106072:	6a 00                	push   $0x0
80106074:	68 aa 00 00 00       	push   $0xaa
80106079:	e9 59 f5 ff ff       	jmp    801055d7 <alltraps>

8010607e <vector171>:
8010607e:	6a 00                	push   $0x0
80106080:	68 ab 00 00 00       	push   $0xab
80106085:	e9 4d f5 ff ff       	jmp    801055d7 <alltraps>

8010608a <vector172>:
8010608a:	6a 00                	push   $0x0
8010608c:	68 ac 00 00 00       	push   $0xac
80106091:	e9 41 f5 ff ff       	jmp    801055d7 <alltraps>

80106096 <vector173>:
80106096:	6a 00                	push   $0x0
80106098:	68 ad 00 00 00       	push   $0xad
8010609d:	e9 35 f5 ff ff       	jmp    801055d7 <alltraps>

801060a2 <vector174>:
801060a2:	6a 00                	push   $0x0
801060a4:	68 ae 00 00 00       	push   $0xae
801060a9:	e9 29 f5 ff ff       	jmp    801055d7 <alltraps>

801060ae <vector175>:
801060ae:	6a 00                	push   $0x0
801060b0:	68 af 00 00 00       	push   $0xaf
801060b5:	e9 1d f5 ff ff       	jmp    801055d7 <alltraps>

801060ba <vector176>:
801060ba:	6a 00                	push   $0x0
801060bc:	68 b0 00 00 00       	push   $0xb0
801060c1:	e9 11 f5 ff ff       	jmp    801055d7 <alltraps>

801060c6 <vector177>:
801060c6:	6a 00                	push   $0x0
801060c8:	68 b1 00 00 00       	push   $0xb1
801060cd:	e9 05 f5 ff ff       	jmp    801055d7 <alltraps>

801060d2 <vector178>:
801060d2:	6a 00                	push   $0x0
801060d4:	68 b2 00 00 00       	push   $0xb2
801060d9:	e9 f9 f4 ff ff       	jmp    801055d7 <alltraps>

801060de <vector179>:
801060de:	6a 00                	push   $0x0
801060e0:	68 b3 00 00 00       	push   $0xb3
801060e5:	e9 ed f4 ff ff       	jmp    801055d7 <alltraps>

801060ea <vector180>:
801060ea:	6a 00                	push   $0x0
801060ec:	68 b4 00 00 00       	push   $0xb4
801060f1:	e9 e1 f4 ff ff       	jmp    801055d7 <alltraps>

801060f6 <vector181>:
801060f6:	6a 00                	push   $0x0
801060f8:	68 b5 00 00 00       	push   $0xb5
801060fd:	e9 d5 f4 ff ff       	jmp    801055d7 <alltraps>

80106102 <vector182>:
80106102:	6a 00                	push   $0x0
80106104:	68 b6 00 00 00       	push   $0xb6
80106109:	e9 c9 f4 ff ff       	jmp    801055d7 <alltraps>

8010610e <vector183>:
8010610e:	6a 00                	push   $0x0
80106110:	68 b7 00 00 00       	push   $0xb7
80106115:	e9 bd f4 ff ff       	jmp    801055d7 <alltraps>

8010611a <vector184>:
8010611a:	6a 00                	push   $0x0
8010611c:	68 b8 00 00 00       	push   $0xb8
80106121:	e9 b1 f4 ff ff       	jmp    801055d7 <alltraps>

80106126 <vector185>:
80106126:	6a 00                	push   $0x0
80106128:	68 b9 00 00 00       	push   $0xb9
8010612d:	e9 a5 f4 ff ff       	jmp    801055d7 <alltraps>

80106132 <vector186>:
80106132:	6a 00                	push   $0x0
80106134:	68 ba 00 00 00       	push   $0xba
80106139:	e9 99 f4 ff ff       	jmp    801055d7 <alltraps>

8010613e <vector187>:
8010613e:	6a 00                	push   $0x0
80106140:	68 bb 00 00 00       	push   $0xbb
80106145:	e9 8d f4 ff ff       	jmp    801055d7 <alltraps>

8010614a <vector188>:
8010614a:	6a 00                	push   $0x0
8010614c:	68 bc 00 00 00       	push   $0xbc
80106151:	e9 81 f4 ff ff       	jmp    801055d7 <alltraps>

80106156 <vector189>:
80106156:	6a 00                	push   $0x0
80106158:	68 bd 00 00 00       	push   $0xbd
8010615d:	e9 75 f4 ff ff       	jmp    801055d7 <alltraps>

80106162 <vector190>:
80106162:	6a 00                	push   $0x0
80106164:	68 be 00 00 00       	push   $0xbe
80106169:	e9 69 f4 ff ff       	jmp    801055d7 <alltraps>

8010616e <vector191>:
8010616e:	6a 00                	push   $0x0
80106170:	68 bf 00 00 00       	push   $0xbf
80106175:	e9 5d f4 ff ff       	jmp    801055d7 <alltraps>

8010617a <vector192>:
8010617a:	6a 00                	push   $0x0
8010617c:	68 c0 00 00 00       	push   $0xc0
80106181:	e9 51 f4 ff ff       	jmp    801055d7 <alltraps>

80106186 <vector193>:
80106186:	6a 00                	push   $0x0
80106188:	68 c1 00 00 00       	push   $0xc1
8010618d:	e9 45 f4 ff ff       	jmp    801055d7 <alltraps>

80106192 <vector194>:
80106192:	6a 00                	push   $0x0
80106194:	68 c2 00 00 00       	push   $0xc2
80106199:	e9 39 f4 ff ff       	jmp    801055d7 <alltraps>

8010619e <vector195>:
8010619e:	6a 00                	push   $0x0
801061a0:	68 c3 00 00 00       	push   $0xc3
801061a5:	e9 2d f4 ff ff       	jmp    801055d7 <alltraps>

801061aa <vector196>:
801061aa:	6a 00                	push   $0x0
801061ac:	68 c4 00 00 00       	push   $0xc4
801061b1:	e9 21 f4 ff ff       	jmp    801055d7 <alltraps>

801061b6 <vector197>:
801061b6:	6a 00                	push   $0x0
801061b8:	68 c5 00 00 00       	push   $0xc5
801061bd:	e9 15 f4 ff ff       	jmp    801055d7 <alltraps>

801061c2 <vector198>:
801061c2:	6a 00                	push   $0x0
801061c4:	68 c6 00 00 00       	push   $0xc6
801061c9:	e9 09 f4 ff ff       	jmp    801055d7 <alltraps>

801061ce <vector199>:
801061ce:	6a 00                	push   $0x0
801061d0:	68 c7 00 00 00       	push   $0xc7
801061d5:	e9 fd f3 ff ff       	jmp    801055d7 <alltraps>

801061da <vector200>:
801061da:	6a 00                	push   $0x0
801061dc:	68 c8 00 00 00       	push   $0xc8
801061e1:	e9 f1 f3 ff ff       	jmp    801055d7 <alltraps>

801061e6 <vector201>:
801061e6:	6a 00                	push   $0x0
801061e8:	68 c9 00 00 00       	push   $0xc9
801061ed:	e9 e5 f3 ff ff       	jmp    801055d7 <alltraps>

801061f2 <vector202>:
801061f2:	6a 00                	push   $0x0
801061f4:	68 ca 00 00 00       	push   $0xca
801061f9:	e9 d9 f3 ff ff       	jmp    801055d7 <alltraps>

801061fe <vector203>:
801061fe:	6a 00                	push   $0x0
80106200:	68 cb 00 00 00       	push   $0xcb
80106205:	e9 cd f3 ff ff       	jmp    801055d7 <alltraps>

8010620a <vector204>:
8010620a:	6a 00                	push   $0x0
8010620c:	68 cc 00 00 00       	push   $0xcc
80106211:	e9 c1 f3 ff ff       	jmp    801055d7 <alltraps>

80106216 <vector205>:
80106216:	6a 00                	push   $0x0
80106218:	68 cd 00 00 00       	push   $0xcd
8010621d:	e9 b5 f3 ff ff       	jmp    801055d7 <alltraps>

80106222 <vector206>:
80106222:	6a 00                	push   $0x0
80106224:	68 ce 00 00 00       	push   $0xce
80106229:	e9 a9 f3 ff ff       	jmp    801055d7 <alltraps>

8010622e <vector207>:
8010622e:	6a 00                	push   $0x0
80106230:	68 cf 00 00 00       	push   $0xcf
80106235:	e9 9d f3 ff ff       	jmp    801055d7 <alltraps>

8010623a <vector208>:
8010623a:	6a 00                	push   $0x0
8010623c:	68 d0 00 00 00       	push   $0xd0
80106241:	e9 91 f3 ff ff       	jmp    801055d7 <alltraps>

80106246 <vector209>:
80106246:	6a 00                	push   $0x0
80106248:	68 d1 00 00 00       	push   $0xd1
8010624d:	e9 85 f3 ff ff       	jmp    801055d7 <alltraps>

80106252 <vector210>:
80106252:	6a 00                	push   $0x0
80106254:	68 d2 00 00 00       	push   $0xd2
80106259:	e9 79 f3 ff ff       	jmp    801055d7 <alltraps>

8010625e <vector211>:
8010625e:	6a 00                	push   $0x0
80106260:	68 d3 00 00 00       	push   $0xd3
80106265:	e9 6d f3 ff ff       	jmp    801055d7 <alltraps>

8010626a <vector212>:
8010626a:	6a 00                	push   $0x0
8010626c:	68 d4 00 00 00       	push   $0xd4
80106271:	e9 61 f3 ff ff       	jmp    801055d7 <alltraps>

80106276 <vector213>:
80106276:	6a 00                	push   $0x0
80106278:	68 d5 00 00 00       	push   $0xd5
8010627d:	e9 55 f3 ff ff       	jmp    801055d7 <alltraps>

80106282 <vector214>:
80106282:	6a 00                	push   $0x0
80106284:	68 d6 00 00 00       	push   $0xd6
80106289:	e9 49 f3 ff ff       	jmp    801055d7 <alltraps>

8010628e <vector215>:
8010628e:	6a 00                	push   $0x0
80106290:	68 d7 00 00 00       	push   $0xd7
80106295:	e9 3d f3 ff ff       	jmp    801055d7 <alltraps>

8010629a <vector216>:
8010629a:	6a 00                	push   $0x0
8010629c:	68 d8 00 00 00       	push   $0xd8
801062a1:	e9 31 f3 ff ff       	jmp    801055d7 <alltraps>

801062a6 <vector217>:
801062a6:	6a 00                	push   $0x0
801062a8:	68 d9 00 00 00       	push   $0xd9
801062ad:	e9 25 f3 ff ff       	jmp    801055d7 <alltraps>

801062b2 <vector218>:
801062b2:	6a 00                	push   $0x0
801062b4:	68 da 00 00 00       	push   $0xda
801062b9:	e9 19 f3 ff ff       	jmp    801055d7 <alltraps>

801062be <vector219>:
801062be:	6a 00                	push   $0x0
801062c0:	68 db 00 00 00       	push   $0xdb
801062c5:	e9 0d f3 ff ff       	jmp    801055d7 <alltraps>

801062ca <vector220>:
801062ca:	6a 00                	push   $0x0
801062cc:	68 dc 00 00 00       	push   $0xdc
801062d1:	e9 01 f3 ff ff       	jmp    801055d7 <alltraps>

801062d6 <vector221>:
801062d6:	6a 00                	push   $0x0
801062d8:	68 dd 00 00 00       	push   $0xdd
801062dd:	e9 f5 f2 ff ff       	jmp    801055d7 <alltraps>

801062e2 <vector222>:
801062e2:	6a 00                	push   $0x0
801062e4:	68 de 00 00 00       	push   $0xde
801062e9:	e9 e9 f2 ff ff       	jmp    801055d7 <alltraps>

801062ee <vector223>:
801062ee:	6a 00                	push   $0x0
801062f0:	68 df 00 00 00       	push   $0xdf
801062f5:	e9 dd f2 ff ff       	jmp    801055d7 <alltraps>

801062fa <vector224>:
801062fa:	6a 00                	push   $0x0
801062fc:	68 e0 00 00 00       	push   $0xe0
80106301:	e9 d1 f2 ff ff       	jmp    801055d7 <alltraps>

80106306 <vector225>:
80106306:	6a 00                	push   $0x0
80106308:	68 e1 00 00 00       	push   $0xe1
8010630d:	e9 c5 f2 ff ff       	jmp    801055d7 <alltraps>

80106312 <vector226>:
80106312:	6a 00                	push   $0x0
80106314:	68 e2 00 00 00       	push   $0xe2
80106319:	e9 b9 f2 ff ff       	jmp    801055d7 <alltraps>

8010631e <vector227>:
8010631e:	6a 00                	push   $0x0
80106320:	68 e3 00 00 00       	push   $0xe3
80106325:	e9 ad f2 ff ff       	jmp    801055d7 <alltraps>

8010632a <vector228>:
8010632a:	6a 00                	push   $0x0
8010632c:	68 e4 00 00 00       	push   $0xe4
80106331:	e9 a1 f2 ff ff       	jmp    801055d7 <alltraps>

80106336 <vector229>:
80106336:	6a 00                	push   $0x0
80106338:	68 e5 00 00 00       	push   $0xe5
8010633d:	e9 95 f2 ff ff       	jmp    801055d7 <alltraps>

80106342 <vector230>:
80106342:	6a 00                	push   $0x0
80106344:	68 e6 00 00 00       	push   $0xe6
80106349:	e9 89 f2 ff ff       	jmp    801055d7 <alltraps>

8010634e <vector231>:
8010634e:	6a 00                	push   $0x0
80106350:	68 e7 00 00 00       	push   $0xe7
80106355:	e9 7d f2 ff ff       	jmp    801055d7 <alltraps>

8010635a <vector232>:
8010635a:	6a 00                	push   $0x0
8010635c:	68 e8 00 00 00       	push   $0xe8
80106361:	e9 71 f2 ff ff       	jmp    801055d7 <alltraps>

80106366 <vector233>:
80106366:	6a 00                	push   $0x0
80106368:	68 e9 00 00 00       	push   $0xe9
8010636d:	e9 65 f2 ff ff       	jmp    801055d7 <alltraps>

80106372 <vector234>:
80106372:	6a 00                	push   $0x0
80106374:	68 ea 00 00 00       	push   $0xea
80106379:	e9 59 f2 ff ff       	jmp    801055d7 <alltraps>

8010637e <vector235>:
8010637e:	6a 00                	push   $0x0
80106380:	68 eb 00 00 00       	push   $0xeb
80106385:	e9 4d f2 ff ff       	jmp    801055d7 <alltraps>

8010638a <vector236>:
8010638a:	6a 00                	push   $0x0
8010638c:	68 ec 00 00 00       	push   $0xec
80106391:	e9 41 f2 ff ff       	jmp    801055d7 <alltraps>

80106396 <vector237>:
80106396:	6a 00                	push   $0x0
80106398:	68 ed 00 00 00       	push   $0xed
8010639d:	e9 35 f2 ff ff       	jmp    801055d7 <alltraps>

801063a2 <vector238>:
801063a2:	6a 00                	push   $0x0
801063a4:	68 ee 00 00 00       	push   $0xee
801063a9:	e9 29 f2 ff ff       	jmp    801055d7 <alltraps>

801063ae <vector239>:
801063ae:	6a 00                	push   $0x0
801063b0:	68 ef 00 00 00       	push   $0xef
801063b5:	e9 1d f2 ff ff       	jmp    801055d7 <alltraps>

801063ba <vector240>:
801063ba:	6a 00                	push   $0x0
801063bc:	68 f0 00 00 00       	push   $0xf0
801063c1:	e9 11 f2 ff ff       	jmp    801055d7 <alltraps>

801063c6 <vector241>:
801063c6:	6a 00                	push   $0x0
801063c8:	68 f1 00 00 00       	push   $0xf1
801063cd:	e9 05 f2 ff ff       	jmp    801055d7 <alltraps>

801063d2 <vector242>:
801063d2:	6a 00                	push   $0x0
801063d4:	68 f2 00 00 00       	push   $0xf2
801063d9:	e9 f9 f1 ff ff       	jmp    801055d7 <alltraps>

801063de <vector243>:
801063de:	6a 00                	push   $0x0
801063e0:	68 f3 00 00 00       	push   $0xf3
801063e5:	e9 ed f1 ff ff       	jmp    801055d7 <alltraps>

801063ea <vector244>:
801063ea:	6a 00                	push   $0x0
801063ec:	68 f4 00 00 00       	push   $0xf4
801063f1:	e9 e1 f1 ff ff       	jmp    801055d7 <alltraps>

801063f6 <vector245>:
801063f6:	6a 00                	push   $0x0
801063f8:	68 f5 00 00 00       	push   $0xf5
801063fd:	e9 d5 f1 ff ff       	jmp    801055d7 <alltraps>

80106402 <vector246>:
80106402:	6a 00                	push   $0x0
80106404:	68 f6 00 00 00       	push   $0xf6
80106409:	e9 c9 f1 ff ff       	jmp    801055d7 <alltraps>

8010640e <vector247>:
8010640e:	6a 00                	push   $0x0
80106410:	68 f7 00 00 00       	push   $0xf7
80106415:	e9 bd f1 ff ff       	jmp    801055d7 <alltraps>

8010641a <vector248>:
8010641a:	6a 00                	push   $0x0
8010641c:	68 f8 00 00 00       	push   $0xf8
80106421:	e9 b1 f1 ff ff       	jmp    801055d7 <alltraps>

80106426 <vector249>:
80106426:	6a 00                	push   $0x0
80106428:	68 f9 00 00 00       	push   $0xf9
8010642d:	e9 a5 f1 ff ff       	jmp    801055d7 <alltraps>

80106432 <vector250>:
80106432:	6a 00                	push   $0x0
80106434:	68 fa 00 00 00       	push   $0xfa
80106439:	e9 99 f1 ff ff       	jmp    801055d7 <alltraps>

8010643e <vector251>:
8010643e:	6a 00                	push   $0x0
80106440:	68 fb 00 00 00       	push   $0xfb
80106445:	e9 8d f1 ff ff       	jmp    801055d7 <alltraps>

8010644a <vector252>:
8010644a:	6a 00                	push   $0x0
8010644c:	68 fc 00 00 00       	push   $0xfc
80106451:	e9 81 f1 ff ff       	jmp    801055d7 <alltraps>

80106456 <vector253>:
80106456:	6a 00                	push   $0x0
80106458:	68 fd 00 00 00       	push   $0xfd
8010645d:	e9 75 f1 ff ff       	jmp    801055d7 <alltraps>

80106462 <vector254>:
80106462:	6a 00                	push   $0x0
80106464:	68 fe 00 00 00       	push   $0xfe
80106469:	e9 69 f1 ff ff       	jmp    801055d7 <alltraps>

8010646e <vector255>:
8010646e:	6a 00                	push   $0x0
80106470:	68 ff 00 00 00       	push   $0xff
80106475:	e9 5d f1 ff ff       	jmp    801055d7 <alltraps>
8010647a:	66 90                	xchg   %ax,%ax

8010647c <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
8010647c:	55                   	push   %ebp
8010647d:	89 e5                	mov    %esp,%ebp
8010647f:	57                   	push   %edi
80106480:	56                   	push   %esi
80106481:	53                   	push   %ebx
80106482:	83 ec 1c             	sub    $0x1c,%esp
80106485:	89 d7                	mov    %edx,%edi
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106487:	89 d3                	mov    %edx,%ebx
80106489:	c1 eb 16             	shr    $0x16,%ebx
8010648c:	8d 34 98             	lea    (%eax,%ebx,4),%esi
  if(*pde & PTE_P){
8010648f:	8b 1e                	mov    (%esi),%ebx
80106491:	f6 c3 01             	test   $0x1,%bl
80106494:	74 22                	je     801064b8 <walkpgdir+0x3c>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106496:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
8010649c:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801064a2:	89 fa                	mov    %edi,%edx
801064a4:	c1 ea 0a             	shr    $0xa,%edx
801064a7:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801064ad:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
801064b0:	83 c4 1c             	add    $0x1c,%esp
801064b3:	5b                   	pop    %ebx
801064b4:	5e                   	pop    %esi
801064b5:	5f                   	pop    %edi
801064b6:	5d                   	pop    %ebp
801064b7:	c3                   	ret    
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801064b8:	85 c9                	test   %ecx,%ecx
801064ba:	74 30                	je     801064ec <walkpgdir+0x70>
801064bc:	e8 2b bd ff ff       	call   801021ec <kalloc>
801064c1:	89 c3                	mov    %eax,%ebx
801064c3:	85 c0                	test   %eax,%eax
801064c5:	74 25                	je     801064ec <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
801064c7:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
801064ce:	00 
801064cf:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801064d6:	00 
801064d7:	89 04 24             	mov    %eax,(%esp)
801064da:	e8 05 e0 ff ff       	call   801044e4 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801064df:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801064e5:	83 c8 07             	or     $0x7,%eax
801064e8:	89 06                	mov    %eax,(%esi)
801064ea:	eb b6                	jmp    801064a2 <walkpgdir+0x26>
      return 0;
801064ec:	31 c0                	xor    %eax,%eax
}
801064ee:	83 c4 1c             	add    $0x1c,%esp
801064f1:	5b                   	pop    %ebx
801064f2:	5e                   	pop    %esi
801064f3:	5f                   	pop    %edi
801064f4:	5d                   	pop    %ebp
801064f5:	c3                   	ret    
801064f6:	66 90                	xchg   %ax,%ax

801064f8 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801064f8:	55                   	push   %ebp
801064f9:	89 e5                	mov    %esp,%ebp
801064fb:	57                   	push   %edi
801064fc:	56                   	push   %esi
801064fd:	53                   	push   %ebx
801064fe:	83 ec 2c             	sub    $0x2c,%esp
80106501:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106504:	8b 7d 08             	mov    0x8(%ebp),%edi
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106507:	89 d3                	mov    %edx,%ebx
80106509:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
8010650f:	8d 4c 0a ff          	lea    -0x1(%edx,%ecx,1),%ecx
80106513:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80106516:	81 65 e4 00 f0 ff ff 	andl   $0xfffff000,-0x1c(%ebp)
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
8010651d:	29 df                	sub    %ebx,%edi
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
8010651f:	83 4d 0c 01          	orl    $0x1,0xc(%ebp)
80106523:	eb 18                	jmp    8010653d <mappages+0x45>
80106525:	8d 76 00             	lea    0x0(%esi),%esi
    if(*pte & PTE_P)
80106528:	f6 00 01             	testb  $0x1,(%eax)
8010652b:	75 3d                	jne    8010656a <mappages+0x72>
    *pte = pa | perm | PTE_P;
8010652d:	0b 75 0c             	or     0xc(%ebp),%esi
80106530:	89 30                	mov    %esi,(%eax)
    if(a == last)
80106532:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
80106535:	74 29                	je     80106560 <mappages+0x68>
      break;
    a += PGSIZE;
80106537:	81 c3 00 10 00 00    	add    $0x1000,%ebx
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
8010653d:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106540:	b9 01 00 00 00       	mov    $0x1,%ecx
80106545:	89 da                	mov    %ebx,%edx
80106547:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010654a:	e8 2d ff ff ff       	call   8010647c <walkpgdir>
8010654f:	85 c0                	test   %eax,%eax
80106551:	75 d5                	jne    80106528 <mappages+0x30>
      return -1;
80106553:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    pa += PGSIZE;
  }
  return 0;
}
80106558:	83 c4 2c             	add    $0x2c,%esp
8010655b:	5b                   	pop    %ebx
8010655c:	5e                   	pop    %esi
8010655d:	5f                   	pop    %edi
8010655e:	5d                   	pop    %ebp
8010655f:	c3                   	ret    
  return 0;
80106560:	31 c0                	xor    %eax,%eax
}
80106562:	83 c4 2c             	add    $0x2c,%esp
80106565:	5b                   	pop    %ebx
80106566:	5e                   	pop    %esi
80106567:	5f                   	pop    %edi
80106568:	5d                   	pop    %ebp
80106569:	c3                   	ret    
      panic("remap");
8010656a:	c7 04 24 6c 77 10 80 	movl   $0x8010776c,(%esp)
80106571:	e8 9a 9d ff ff       	call   80100310 <panic>
80106576:	66 90                	xchg   %ax,%ax

80106578 <seginit>:
{
80106578:	55                   	push   %ebp
80106579:	89 e5                	mov    %esp,%ebp
8010657b:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
8010657e:	e8 d1 cc ff ff       	call   80103254 <cpuid>
80106583:	8d 14 80             	lea    (%eax,%eax,4),%edx
80106586:	8d 04 50             	lea    (%eax,%edx,2),%eax
80106589:	c1 e0 04             	shl    $0x4,%eax
8010658c:	05 80 27 11 80       	add    $0x80112780,%eax
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106591:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
80106597:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
8010659d:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
801065a1:	c6 40 7d 9a          	movb   $0x9a,0x7d(%eax)
801065a5:	c6 40 7e cf          	movb   $0xcf,0x7e(%eax)
801065a9:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801065ad:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
801065b4:	ff ff 
801065b6:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
801065bd:	00 00 
801065bf:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
801065c6:	c6 80 85 00 00 00 92 	movb   $0x92,0x85(%eax)
801065cd:	c6 80 86 00 00 00 cf 	movb   $0xcf,0x86(%eax)
801065d4:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801065db:	66 c7 80 88 00 00 00 	movw   $0xffff,0x88(%eax)
801065e2:	ff ff 
801065e4:	66 c7 80 8a 00 00 00 	movw   $0x0,0x8a(%eax)
801065eb:	00 00 
801065ed:	c6 80 8c 00 00 00 00 	movb   $0x0,0x8c(%eax)
801065f4:	c6 80 8d 00 00 00 fa 	movb   $0xfa,0x8d(%eax)
801065fb:	c6 80 8e 00 00 00 cf 	movb   $0xcf,0x8e(%eax)
80106602:	c6 80 8f 00 00 00 00 	movb   $0x0,0x8f(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106609:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
80106610:	ff ff 
80106612:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
80106619:	00 00 
8010661b:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
80106622:	c6 80 95 00 00 00 f2 	movb   $0xf2,0x95(%eax)
80106629:	c6 80 96 00 00 00 cf 	movb   $0xcf,0x96(%eax)
80106630:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
80106637:	83 c0 70             	add    $0x70,%eax
  pd[0] = size-1;
8010663a:	66 c7 45 f2 2f 00    	movw   $0x2f,-0xe(%ebp)
  pd[1] = (uint)p;
80106640:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106644:	c1 e8 10             	shr    $0x10,%eax
80106647:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
8010664b:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010664e:	0f 01 10             	lgdtl  (%eax)
}
80106651:	c9                   	leave  
80106652:	c3                   	ret    
80106653:	90                   	nop

80106654 <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80106654:	55                   	push   %ebp
80106655:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106657:	a1 a4 5b 11 80       	mov    0x80115ba4,%eax
8010665c:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106661:	0f 22 d8             	mov    %eax,%cr3
}
80106664:	5d                   	pop    %ebp
80106665:	c3                   	ret    
80106666:	66 90                	xchg   %ax,%ax

80106668 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80106668:	55                   	push   %ebp
80106669:	89 e5                	mov    %esp,%ebp
8010666b:	57                   	push   %edi
8010666c:	56                   	push   %esi
8010666d:	53                   	push   %ebx
8010666e:	83 ec 2c             	sub    $0x2c,%esp
80106671:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80106674:	85 f6                	test   %esi,%esi
80106676:	0f 84 c4 00 00 00    	je     80106740 <switchuvm+0xd8>
    panic("switchuvm: no process");
  if(p->kstack == 0)
8010667c:	8b 56 08             	mov    0x8(%esi),%edx
8010667f:	85 d2                	test   %edx,%edx
80106681:	0f 84 d1 00 00 00    	je     80106758 <switchuvm+0xf0>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
80106687:	8b 46 04             	mov    0x4(%esi),%eax
8010668a:	85 c0                	test   %eax,%eax
8010668c:	0f 84 ba 00 00 00    	je     8010674c <switchuvm+0xe4>
    panic("switchuvm: no pgdir");

  pushcli();
80106692:	e8 11 dd ff ff       	call   801043a8 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106697:	e8 44 cb ff ff       	call   801031e0 <mycpu>
8010669c:	89 c3                	mov    %eax,%ebx
8010669e:	e8 3d cb ff ff       	call   801031e0 <mycpu>
801066a3:	89 c7                	mov    %eax,%edi
801066a5:	e8 36 cb ff ff       	call   801031e0 <mycpu>
801066aa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801066ad:	e8 2e cb ff ff       	call   801031e0 <mycpu>
801066b2:	66 c7 83 98 00 00 00 	movw   $0x67,0x98(%ebx)
801066b9:	67 00 
801066bb:	83 c7 08             	add    $0x8,%edi
801066be:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
801066c5:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801066c8:	83 c1 08             	add    $0x8,%ecx
801066cb:	c1 e9 10             	shr    $0x10,%ecx
801066ce:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
801066d4:	c6 83 9d 00 00 00 99 	movb   $0x99,0x9d(%ebx)
801066db:	c6 83 9e 00 00 00 40 	movb   $0x40,0x9e(%ebx)
801066e2:	83 c0 08             	add    $0x8,%eax
801066e5:	c1 e8 18             	shr    $0x18,%eax
801066e8:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
801066ee:	e8 ed ca ff ff       	call   801031e0 <mycpu>
801066f3:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801066fa:	e8 e1 ca ff ff       	call   801031e0 <mycpu>
801066ff:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106705:	e8 d6 ca ff ff       	call   801031e0 <mycpu>
8010670a:	8b 4e 08             	mov    0x8(%esi),%ecx
8010670d:	81 c1 00 10 00 00    	add    $0x1000,%ecx
80106713:	89 48 0c             	mov    %ecx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106716:	e8 c5 ca ff ff       	call   801031e0 <mycpu>
8010671b:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106721:	b8 28 00 00 00       	mov    $0x28,%eax
80106726:	0f 00 d8             	ltr    %ax
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106729:	8b 46 04             	mov    0x4(%esi),%eax
8010672c:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106731:	0f 22 d8             	mov    %eax,%cr3
  popcli();
}
80106734:	83 c4 2c             	add    $0x2c,%esp
80106737:	5b                   	pop    %ebx
80106738:	5e                   	pop    %esi
80106739:	5f                   	pop    %edi
8010673a:	5d                   	pop    %ebp
  popcli();
8010673b:	e9 04 dd ff ff       	jmp    80104444 <popcli>
    panic("switchuvm: no process");
80106740:	c7 04 24 72 77 10 80 	movl   $0x80107772,(%esp)
80106747:	e8 c4 9b ff ff       	call   80100310 <panic>
    panic("switchuvm: no pgdir");
8010674c:	c7 04 24 9d 77 10 80 	movl   $0x8010779d,(%esp)
80106753:	e8 b8 9b ff ff       	call   80100310 <panic>
    panic("switchuvm: no kstack");
80106758:	c7 04 24 88 77 10 80 	movl   $0x80107788,(%esp)
8010675f:	e8 ac 9b ff ff       	call   80100310 <panic>

80106764 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106764:	55                   	push   %ebp
80106765:	89 e5                	mov    %esp,%ebp
80106767:	57                   	push   %edi
80106768:	56                   	push   %esi
80106769:	53                   	push   %ebx
8010676a:	83 ec 2c             	sub    $0x2c,%esp
8010676d:	8b 45 08             	mov    0x8(%ebp),%eax
80106770:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106773:	8b 7d 0c             	mov    0xc(%ebp),%edi
80106776:	8b 75 10             	mov    0x10(%ebp),%esi
  char *mem;

  if(sz >= PGSIZE)
80106779:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010677f:	77 54                	ja     801067d5 <inituvm+0x71>
    panic("inituvm: more than a page");
  mem = kalloc();
80106781:	e8 66 ba ff ff       	call   801021ec <kalloc>
80106786:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106788:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
8010678f:	00 
80106790:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106797:	00 
80106798:	89 04 24             	mov    %eax,(%esp)
8010679b:	e8 44 dd ff ff       	call   801044e4 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
801067a0:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
801067a7:	00 
801067a8:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801067ae:	89 04 24             	mov    %eax,(%esp)
801067b1:	b9 00 10 00 00       	mov    $0x1000,%ecx
801067b6:	31 d2                	xor    %edx,%edx
801067b8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801067bb:	e8 38 fd ff ff       	call   801064f8 <mappages>
  memmove(mem, init, sz);
801067c0:	89 75 10             	mov    %esi,0x10(%ebp)
801067c3:	89 7d 0c             	mov    %edi,0xc(%ebp)
801067c6:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801067c9:	83 c4 2c             	add    $0x2c,%esp
801067cc:	5b                   	pop    %ebx
801067cd:	5e                   	pop    %esi
801067ce:	5f                   	pop    %edi
801067cf:	5d                   	pop    %ebp
  memmove(mem, init, sz);
801067d0:	e9 a3 dd ff ff       	jmp    80104578 <memmove>
    panic("inituvm: more than a page");
801067d5:	c7 04 24 b1 77 10 80 	movl   $0x801077b1,(%esp)
801067dc:	e8 2f 9b ff ff       	call   80100310 <panic>
801067e1:	8d 76 00             	lea    0x0(%esi),%esi

801067e4 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
801067e4:	55                   	push   %ebp
801067e5:	89 e5                	mov    %esp,%ebp
801067e7:	57                   	push   %edi
801067e8:	56                   	push   %esi
801067e9:	53                   	push   %ebx
801067ea:	83 ec 1c             	sub    $0x1c,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
801067ed:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
801067f4:	0f 85 97 00 00 00    	jne    80106891 <loaduvm+0xad>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
801067fa:	8b 4d 18             	mov    0x18(%ebp),%ecx
801067fd:	85 c9                	test   %ecx,%ecx
801067ff:	74 6b                	je     8010686c <loaduvm+0x88>
80106801:	8b 75 18             	mov    0x18(%ebp),%esi
80106804:	31 db                	xor    %ebx,%ebx
80106806:	eb 3b                	jmp    80106843 <loaduvm+0x5f>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
80106808:	bf 00 10 00 00       	mov    $0x1000,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010680d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
80106811:	8b 4d 14             	mov    0x14(%ebp),%ecx
80106814:	01 d9                	add    %ebx,%ecx
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106816:	89 4c 24 08          	mov    %ecx,0x8(%esp)
8010681a:	05 00 00 00 80       	add    $0x80000000,%eax
8010681f:	89 44 24 04          	mov    %eax,0x4(%esp)
80106823:	8b 45 10             	mov    0x10(%ebp),%eax
80106826:	89 04 24             	mov    %eax,(%esp)
80106829:	e8 be af ff ff       	call   801017ec <readi>
8010682e:	39 f8                	cmp    %edi,%eax
80106830:	75 46                	jne    80106878 <loaduvm+0x94>
  for(i = 0; i < sz; i += PGSIZE){
80106832:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106838:	81 ee 00 10 00 00    	sub    $0x1000,%esi
8010683e:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106841:	76 29                	jbe    8010686c <loaduvm+0x88>
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
80106843:	8b 55 0c             	mov    0xc(%ebp),%edx
80106846:	01 da                	add    %ebx,%edx
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106848:	31 c9                	xor    %ecx,%ecx
8010684a:	8b 45 08             	mov    0x8(%ebp),%eax
8010684d:	e8 2a fc ff ff       	call   8010647c <walkpgdir>
80106852:	85 c0                	test   %eax,%eax
80106854:	74 2f                	je     80106885 <loaduvm+0xa1>
    pa = PTE_ADDR(*pte);
80106856:	8b 00                	mov    (%eax),%eax
80106858:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
8010685d:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106863:	77 a3                	ja     80106808 <loaduvm+0x24>
80106865:	89 f7                	mov    %esi,%edi
80106867:	eb a4                	jmp    8010680d <loaduvm+0x29>
80106869:	8d 76 00             	lea    0x0(%esi),%esi
      return -1;
  }
  return 0;
8010686c:	31 c0                	xor    %eax,%eax
}
8010686e:	83 c4 1c             	add    $0x1c,%esp
80106871:	5b                   	pop    %ebx
80106872:	5e                   	pop    %esi
80106873:	5f                   	pop    %edi
80106874:	5d                   	pop    %ebp
80106875:	c3                   	ret    
80106876:	66 90                	xchg   %ax,%ax
      return -1;
80106878:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010687d:	83 c4 1c             	add    $0x1c,%esp
80106880:	5b                   	pop    %ebx
80106881:	5e                   	pop    %esi
80106882:	5f                   	pop    %edi
80106883:	5d                   	pop    %ebp
80106884:	c3                   	ret    
      panic("loaduvm: address should exist");
80106885:	c7 04 24 cb 77 10 80 	movl   $0x801077cb,(%esp)
8010688c:	e8 7f 9a ff ff       	call   80100310 <panic>
    panic("loaduvm: addr must be page aligned");
80106891:	c7 04 24 6c 78 10 80 	movl   $0x8010786c,(%esp)
80106898:	e8 73 9a ff ff       	call   80100310 <panic>
8010689d:	8d 76 00             	lea    0x0(%esi),%esi

801068a0 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
801068a0:	55                   	push   %ebp
801068a1:	89 e5                	mov    %esp,%ebp
801068a3:	57                   	push   %edi
801068a4:	56                   	push   %esi
801068a5:	53                   	push   %ebx
801068a6:	83 ec 2c             	sub    $0x2c,%esp
801068a9:	8b 7d 08             	mov    0x8(%ebp),%edi
801068ac:	8b 75 0c             	mov    0xc(%ebp),%esi
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
801068af:	39 75 10             	cmp    %esi,0x10(%ebp)
801068b2:	73 7c                	jae    80106930 <deallocuvm+0x90>
    return oldsz;

  a = PGROUNDUP(newsz);
801068b4:	8b 5d 10             	mov    0x10(%ebp),%ebx
801068b7:	81 c3 ff 0f 00 00    	add    $0xfff,%ebx
801068bd:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
801068c3:	39 de                	cmp    %ebx,%esi
801068c5:	77 38                	ja     801068ff <deallocuvm+0x5f>
801068c7:	eb 5b                	jmp    80106924 <deallocuvm+0x84>
801068c9:	8d 76 00             	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
801068cc:	8b 10                	mov    (%eax),%edx
801068ce:	f6 c2 01             	test   $0x1,%dl
801068d1:	74 22                	je     801068f5 <deallocuvm+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
801068d3:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
801068d9:	74 5f                	je     8010693a <deallocuvm+0x9a>
        panic("kfree");
      char *v = P2V(pa);
801068db:	81 c2 00 00 00 80    	add    $0x80000000,%edx
      kfree(v);
801068e1:	89 14 24             	mov    %edx,(%esp)
801068e4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801068e7:	e8 c4 b7 ff ff       	call   801020b0 <kfree>
      *pte = 0;
801068ec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801068ef:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
801068f5:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801068fb:	39 de                	cmp    %ebx,%esi
801068fd:	76 25                	jbe    80106924 <deallocuvm+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
801068ff:	31 c9                	xor    %ecx,%ecx
80106901:	89 da                	mov    %ebx,%edx
80106903:	89 f8                	mov    %edi,%eax
80106905:	e8 72 fb ff ff       	call   8010647c <walkpgdir>
    if(!pte)
8010690a:	85 c0                	test   %eax,%eax
8010690c:	75 be                	jne    801068cc <deallocuvm+0x2c>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
8010690e:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106914:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
8010691a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106920:	39 de                	cmp    %ebx,%esi
80106922:	77 db                	ja     801068ff <deallocuvm+0x5f>
    }
  }
  return newsz;
80106924:	8b 45 10             	mov    0x10(%ebp),%eax
}
80106927:	83 c4 2c             	add    $0x2c,%esp
8010692a:	5b                   	pop    %ebx
8010692b:	5e                   	pop    %esi
8010692c:	5f                   	pop    %edi
8010692d:	5d                   	pop    %ebp
8010692e:	c3                   	ret    
8010692f:	90                   	nop
    return oldsz;
80106930:	89 f0                	mov    %esi,%eax
}
80106932:	83 c4 2c             	add    $0x2c,%esp
80106935:	5b                   	pop    %ebx
80106936:	5e                   	pop    %esi
80106937:	5f                   	pop    %edi
80106938:	5d                   	pop    %ebp
80106939:	c3                   	ret    
        panic("kfree");
8010693a:	c7 04 24 c6 6f 10 80 	movl   $0x80106fc6,(%esp)
80106941:	e8 ca 99 ff ff       	call   80100310 <panic>
80106946:	66 90                	xchg   %ax,%ax

80106948 <allocuvm>:
{
80106948:	55                   	push   %ebp
80106949:	89 e5                	mov    %esp,%ebp
8010694b:	57                   	push   %edi
8010694c:	56                   	push   %esi
8010694d:	53                   	push   %ebx
8010694e:	83 ec 2c             	sub    $0x2c,%esp
  if(newsz >= KERNBASE)
80106951:	8b 7d 10             	mov    0x10(%ebp),%edi
80106954:	85 ff                	test   %edi,%edi
80106956:	0f 88 c4 00 00 00    	js     80106a20 <allocuvm+0xd8>
  if(newsz < oldsz)
8010695c:	3b 7d 0c             	cmp    0xc(%ebp),%edi
8010695f:	0f 82 ab 00 00 00    	jb     80106a10 <allocuvm+0xc8>
  a = PGROUNDUP(oldsz);
80106965:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80106968:	81 c3 ff 0f 00 00    	add    $0xfff,%ebx
8010696e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106974:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106977:	0f 86 96 00 00 00    	jbe    80106a13 <allocuvm+0xcb>
8010697d:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80106980:	8b 7d 08             	mov    0x8(%ebp),%edi
80106983:	eb 4d                	jmp    801069d2 <allocuvm+0x8a>
80106985:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80106988:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
8010698f:	00 
80106990:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106997:	00 
80106998:	89 04 24             	mov    %eax,(%esp)
8010699b:	e8 44 db ff ff       	call   801044e4 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801069a0:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
801069a7:	00 
801069a8:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801069ae:	89 04 24             	mov    %eax,(%esp)
801069b1:	b9 00 10 00 00       	mov    $0x1000,%ecx
801069b6:	89 da                	mov    %ebx,%edx
801069b8:	89 f8                	mov    %edi,%eax
801069ba:	e8 39 fb ff ff       	call   801064f8 <mappages>
801069bf:	85 c0                	test   %eax,%eax
801069c1:	78 69                	js     80106a2c <allocuvm+0xe4>
  for(; a < newsz; a += PGSIZE){
801069c3:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801069c9:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801069cc:	0f 86 96 00 00 00    	jbe    80106a68 <allocuvm+0x120>
    mem = kalloc();
801069d2:	e8 15 b8 ff ff       	call   801021ec <kalloc>
801069d7:	89 c6                	mov    %eax,%esi
    if(mem == 0){
801069d9:	85 c0                	test   %eax,%eax
801069db:	75 ab                	jne    80106988 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
801069dd:	c7 04 24 e9 77 10 80 	movl   $0x801077e9,(%esp)
801069e4:	e8 cb 9b ff ff       	call   801005b4 <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
801069e9:	8b 45 0c             	mov    0xc(%ebp),%eax
801069ec:	89 44 24 08          	mov    %eax,0x8(%esp)
801069f0:	8b 45 10             	mov    0x10(%ebp),%eax
801069f3:	89 44 24 04          	mov    %eax,0x4(%esp)
801069f7:	8b 45 08             	mov    0x8(%ebp),%eax
801069fa:	89 04 24             	mov    %eax,(%esp)
801069fd:	e8 9e fe ff ff       	call   801068a0 <deallocuvm>
      return 0;
80106a02:	31 ff                	xor    %edi,%edi
}
80106a04:	89 f8                	mov    %edi,%eax
80106a06:	83 c4 2c             	add    $0x2c,%esp
80106a09:	5b                   	pop    %ebx
80106a0a:	5e                   	pop    %esi
80106a0b:	5f                   	pop    %edi
80106a0c:	5d                   	pop    %ebp
80106a0d:	c3                   	ret    
80106a0e:	66 90                	xchg   %ax,%ax
    return oldsz;
80106a10:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80106a13:	89 f8                	mov    %edi,%eax
80106a15:	83 c4 2c             	add    $0x2c,%esp
80106a18:	5b                   	pop    %ebx
80106a19:	5e                   	pop    %esi
80106a1a:	5f                   	pop    %edi
80106a1b:	5d                   	pop    %ebp
80106a1c:	c3                   	ret    
80106a1d:	8d 76 00             	lea    0x0(%esi),%esi
    return 0;
80106a20:	31 ff                	xor    %edi,%edi
}
80106a22:	89 f8                	mov    %edi,%eax
80106a24:	83 c4 2c             	add    $0x2c,%esp
80106a27:	5b                   	pop    %ebx
80106a28:	5e                   	pop    %esi
80106a29:	5f                   	pop    %edi
80106a2a:	5d                   	pop    %ebp
80106a2b:	c3                   	ret    
      cprintf("allocuvm out of memory (2)\n");
80106a2c:	c7 04 24 01 78 10 80 	movl   $0x80107801,(%esp)
80106a33:	e8 7c 9b ff ff       	call   801005b4 <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
80106a38:	8b 45 0c             	mov    0xc(%ebp),%eax
80106a3b:	89 44 24 08          	mov    %eax,0x8(%esp)
80106a3f:	8b 45 10             	mov    0x10(%ebp),%eax
80106a42:	89 44 24 04          	mov    %eax,0x4(%esp)
80106a46:	8b 45 08             	mov    0x8(%ebp),%eax
80106a49:	89 04 24             	mov    %eax,(%esp)
80106a4c:	e8 4f fe ff ff       	call   801068a0 <deallocuvm>
      kfree(mem);
80106a51:	89 34 24             	mov    %esi,(%esp)
80106a54:	e8 57 b6 ff ff       	call   801020b0 <kfree>
      return 0;
80106a59:	31 ff                	xor    %edi,%edi
}
80106a5b:	89 f8                	mov    %edi,%eax
80106a5d:	83 c4 2c             	add    $0x2c,%esp
80106a60:	5b                   	pop    %ebx
80106a61:	5e                   	pop    %esi
80106a62:	5f                   	pop    %edi
80106a63:	5d                   	pop    %ebp
80106a64:	c3                   	ret    
80106a65:	8d 76 00             	lea    0x0(%esi),%esi
80106a68:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80106a6b:	89 f8                	mov    %edi,%eax
80106a6d:	83 c4 2c             	add    $0x2c,%esp
80106a70:	5b                   	pop    %ebx
80106a71:	5e                   	pop    %esi
80106a72:	5f                   	pop    %edi
80106a73:	5d                   	pop    %ebp
80106a74:	c3                   	ret    
80106a75:	8d 76 00             	lea    0x0(%esi),%esi

80106a78 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106a78:	55                   	push   %ebp
80106a79:	89 e5                	mov    %esp,%ebp
80106a7b:	56                   	push   %esi
80106a7c:	53                   	push   %ebx
80106a7d:	83 ec 10             	sub    $0x10,%esp
80106a80:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106a83:	85 f6                	test   %esi,%esi
80106a85:	74 56                	je     80106add <freevm+0x65>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
80106a87:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80106a8e:	00 
80106a8f:	c7 44 24 04 00 00 00 	movl   $0x80000000,0x4(%esp)
80106a96:	80 
80106a97:	89 34 24             	mov    %esi,(%esp)
80106a9a:	e8 01 fe ff ff       	call   801068a0 <deallocuvm>
  for(i = 0; i < NPDENTRIES; i++){
80106a9f:	31 db                	xor    %ebx,%ebx
80106aa1:	eb 0a                	jmp    80106aad <freevm+0x35>
80106aa3:	90                   	nop
80106aa4:	43                   	inc    %ebx
80106aa5:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
80106aab:	74 22                	je     80106acf <freevm+0x57>
    if(pgdir[i] & PTE_P){
80106aad:	8b 04 9e             	mov    (%esi,%ebx,4),%eax
80106ab0:	a8 01                	test   $0x1,%al
80106ab2:	74 f0                	je     80106aa4 <freevm+0x2c>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106ab4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106ab9:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106abe:	89 04 24             	mov    %eax,(%esp)
80106ac1:	e8 ea b5 ff ff       	call   801020b0 <kfree>
  for(i = 0; i < NPDENTRIES; i++){
80106ac6:	43                   	inc    %ebx
80106ac7:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
80106acd:	75 de                	jne    80106aad <freevm+0x35>
    }
  }
  kfree((char*)pgdir);
80106acf:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106ad2:	83 c4 10             	add    $0x10,%esp
80106ad5:	5b                   	pop    %ebx
80106ad6:	5e                   	pop    %esi
80106ad7:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80106ad8:	e9 d3 b5 ff ff       	jmp    801020b0 <kfree>
    panic("freevm: no pgdir");
80106add:	c7 04 24 1d 78 10 80 	movl   $0x8010781d,(%esp)
80106ae4:	e8 27 98 ff ff       	call   80100310 <panic>
80106ae9:	8d 76 00             	lea    0x0(%esi),%esi

80106aec <setupkvm>:
{
80106aec:	55                   	push   %ebp
80106aed:	89 e5                	mov    %esp,%ebp
80106aef:	56                   	push   %esi
80106af0:	53                   	push   %ebx
80106af1:	83 ec 10             	sub    $0x10,%esp
  if((pgdir = (pde_t*)kalloc()) == 0)
80106af4:	e8 f3 b6 ff ff       	call   801021ec <kalloc>
80106af9:	89 c6                	mov    %eax,%esi
80106afb:	85 c0                	test   %eax,%eax
80106afd:	74 47                	je     80106b46 <setupkvm+0x5a>
  memset(pgdir, 0, PGSIZE);
80106aff:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106b06:	00 
80106b07:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106b0e:	00 
80106b0f:	89 04 24             	mov    %eax,(%esp)
80106b12:	e8 cd d9 ff ff       	call   801044e4 <memset>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106b17:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106b1c:	8b 43 04             	mov    0x4(%ebx),%eax
80106b1f:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106b22:	29 c1                	sub    %eax,%ecx
80106b24:	8b 53 0c             	mov    0xc(%ebx),%edx
80106b27:	89 54 24 04          	mov    %edx,0x4(%esp)
80106b2b:	89 04 24             	mov    %eax,(%esp)
80106b2e:	8b 13                	mov    (%ebx),%edx
80106b30:	89 f0                	mov    %esi,%eax
80106b32:	e8 c1 f9 ff ff       	call   801064f8 <mappages>
80106b37:	85 c0                	test   %eax,%eax
80106b39:	78 15                	js     80106b50 <setupkvm+0x64>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106b3b:	83 c3 10             	add    $0x10,%ebx
80106b3e:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106b44:	72 d6                	jb     80106b1c <setupkvm+0x30>
}
80106b46:	89 f0                	mov    %esi,%eax
80106b48:	83 c4 10             	add    $0x10,%esp
80106b4b:	5b                   	pop    %ebx
80106b4c:	5e                   	pop    %esi
80106b4d:	5d                   	pop    %ebp
80106b4e:	c3                   	ret    
80106b4f:	90                   	nop
      freevm(pgdir);
80106b50:	89 34 24             	mov    %esi,(%esp)
80106b53:	e8 20 ff ff ff       	call   80106a78 <freevm>
      return 0;
80106b58:	31 f6                	xor    %esi,%esi
}
80106b5a:	89 f0                	mov    %esi,%eax
80106b5c:	83 c4 10             	add    $0x10,%esp
80106b5f:	5b                   	pop    %ebx
80106b60:	5e                   	pop    %esi
80106b61:	5d                   	pop    %ebp
80106b62:	c3                   	ret    
80106b63:	90                   	nop

80106b64 <kvmalloc>:
{
80106b64:	55                   	push   %ebp
80106b65:	89 e5                	mov    %esp,%ebp
80106b67:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106b6a:	e8 7d ff ff ff       	call   80106aec <setupkvm>
80106b6f:	a3 a4 5b 11 80       	mov    %eax,0x80115ba4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106b74:	05 00 00 00 80       	add    $0x80000000,%eax
80106b79:	0f 22 d8             	mov    %eax,%cr3
}
80106b7c:	c9                   	leave  
80106b7d:	c3                   	ret    
80106b7e:	66 90                	xchg   %ax,%ax

80106b80 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106b80:	55                   	push   %ebp
80106b81:	89 e5                	mov    %esp,%ebp
80106b83:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106b86:	31 c9                	xor    %ecx,%ecx
80106b88:	8b 55 0c             	mov    0xc(%ebp),%edx
80106b8b:	8b 45 08             	mov    0x8(%ebp),%eax
80106b8e:	e8 e9 f8 ff ff       	call   8010647c <walkpgdir>
  if(pte == 0)
80106b93:	85 c0                	test   %eax,%eax
80106b95:	74 05                	je     80106b9c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80106b97:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106b9a:	c9                   	leave  
80106b9b:	c3                   	ret    
    panic("clearpteu");
80106b9c:	c7 04 24 2e 78 10 80 	movl   $0x8010782e,(%esp)
80106ba3:	e8 68 97 ff ff       	call   80100310 <panic>

80106ba8 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106ba8:	55                   	push   %ebp
80106ba9:	89 e5                	mov    %esp,%ebp
80106bab:	57                   	push   %edi
80106bac:	56                   	push   %esi
80106bad:	53                   	push   %ebx
80106bae:	83 ec 2c             	sub    $0x2c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80106bb1:	e8 36 ff ff ff       	call   80106aec <setupkvm>
80106bb6:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106bb9:	85 c0                	test   %eax,%eax
80106bbb:	0f 84 9f 00 00 00    	je     80106c60 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106bc1:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80106bc4:	85 db                	test   %ebx,%ebx
80106bc6:	0f 84 94 00 00 00    	je     80106c60 <copyuvm+0xb8>
80106bcc:	31 db                	xor    %ebx,%ebx
80106bce:	eb 48                	jmp    80106c18 <copyuvm+0x70>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80106bd0:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106bd7:	00 
80106bd8:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80106bde:	89 7c 24 04          	mov    %edi,0x4(%esp)
80106be2:	89 04 24             	mov    %eax,(%esp)
80106be5:	e8 8e d9 ff ff       	call   80104578 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
80106bea:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106bed:	89 44 24 04          	mov    %eax,0x4(%esp)
80106bf1:	8d 96 00 00 00 80    	lea    -0x80000000(%esi),%edx
80106bf7:	89 14 24             	mov    %edx,(%esp)
80106bfa:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106bff:	89 da                	mov    %ebx,%edx
80106c01:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106c04:	e8 ef f8 ff ff       	call   801064f8 <mappages>
80106c09:	85 c0                	test   %eax,%eax
80106c0b:	78 41                	js     80106c4e <copyuvm+0xa6>
  for(i = 0; i < sz; i += PGSIZE){
80106c0d:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106c13:	39 5d 0c             	cmp    %ebx,0xc(%ebp)
80106c16:	76 48                	jbe    80106c60 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80106c18:	31 c9                	xor    %ecx,%ecx
80106c1a:	89 da                	mov    %ebx,%edx
80106c1c:	8b 45 08             	mov    0x8(%ebp),%eax
80106c1f:	e8 58 f8 ff ff       	call   8010647c <walkpgdir>
80106c24:	85 c0                	test   %eax,%eax
80106c26:	74 43                	je     80106c6b <copyuvm+0xc3>
    if(!(*pte & PTE_P))
80106c28:	8b 30                	mov    (%eax),%esi
80106c2a:	f7 c6 01 00 00 00    	test   $0x1,%esi
80106c30:	74 45                	je     80106c77 <copyuvm+0xcf>
    pa = PTE_ADDR(*pte);
80106c32:	89 f7                	mov    %esi,%edi
80106c34:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    flags = PTE_FLAGS(*pte);
80106c3a:	81 e6 ff 0f 00 00    	and    $0xfff,%esi
80106c40:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80106c43:	e8 a4 b5 ff ff       	call   801021ec <kalloc>
80106c48:	89 c6                	mov    %eax,%esi
80106c4a:	85 c0                	test   %eax,%eax
80106c4c:	75 82                	jne    80106bd0 <copyuvm+0x28>
      goto bad;
  }
  return d;

bad:
  freevm(d);
80106c4e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106c51:	89 04 24             	mov    %eax,(%esp)
80106c54:	e8 1f fe ff ff       	call   80106a78 <freevm>
  return 0;
80106c59:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80106c60:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106c63:	83 c4 2c             	add    $0x2c,%esp
80106c66:	5b                   	pop    %ebx
80106c67:	5e                   	pop    %esi
80106c68:	5f                   	pop    %edi
80106c69:	5d                   	pop    %ebp
80106c6a:	c3                   	ret    
      panic("copyuvm: pte should exist");
80106c6b:	c7 04 24 38 78 10 80 	movl   $0x80107838,(%esp)
80106c72:	e8 99 96 ff ff       	call   80100310 <panic>
      panic("copyuvm: page not present");
80106c77:	c7 04 24 52 78 10 80 	movl   $0x80107852,(%esp)
80106c7e:	e8 8d 96 ff ff       	call   80100310 <panic>
80106c83:	90                   	nop

80106c84 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80106c84:	55                   	push   %ebp
80106c85:	89 e5                	mov    %esp,%ebp
80106c87:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106c8a:	31 c9                	xor    %ecx,%ecx
80106c8c:	8b 55 0c             	mov    0xc(%ebp),%edx
80106c8f:	8b 45 08             	mov    0x8(%ebp),%eax
80106c92:	e8 e5 f7 ff ff       	call   8010647c <walkpgdir>
  if((*pte & PTE_P) == 0)
80106c97:	8b 00                	mov    (%eax),%eax
80106c99:	a8 01                	test   $0x1,%al
80106c9b:	74 13                	je     80106cb0 <uva2ka+0x2c>
    return 0;
  if((*pte & PTE_U) == 0)
80106c9d:	a8 04                	test   $0x4,%al
80106c9f:	74 0f                	je     80106cb0 <uva2ka+0x2c>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80106ca1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106ca6:	05 00 00 00 80       	add    $0x80000000,%eax
}
80106cab:	c9                   	leave  
80106cac:	c3                   	ret    
80106cad:	8d 76 00             	lea    0x0(%esi),%esi
    return 0;
80106cb0:	31 c0                	xor    %eax,%eax
}
80106cb2:	c9                   	leave  
80106cb3:	c3                   	ret    

80106cb4 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80106cb4:	55                   	push   %ebp
80106cb5:	89 e5                	mov    %esp,%ebp
80106cb7:	57                   	push   %edi
80106cb8:	56                   	push   %esi
80106cb9:	53                   	push   %ebx
80106cba:	83 ec 2c             	sub    $0x2c,%esp
80106cbd:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80106cc0:	8b 7d 10             	mov    0x10(%ebp),%edi
80106cc3:	8b 45 14             	mov    0x14(%ebp),%eax
80106cc6:	85 c0                	test   %eax,%eax
80106cc8:	74 6e                	je     80106d38 <copyout+0x84>
80106cca:	89 f0                	mov    %esi,%eax
80106ccc:	89 fe                	mov    %edi,%esi
80106cce:	89 c7                	mov    %eax,%edi
80106cd0:	eb 3d                	jmp    80106d0f <copyout+0x5b>
80106cd2:	66 90                	xchg   %ax,%ax
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80106cd4:	89 da                	mov    %ebx,%edx
80106cd6:	29 fa                	sub    %edi,%edx
80106cd8:	81 c2 00 10 00 00    	add    $0x1000,%edx
80106cde:	3b 55 14             	cmp    0x14(%ebp),%edx
80106ce1:	76 03                	jbe    80106ce6 <copyout+0x32>
80106ce3:	8b 55 14             	mov    0x14(%ebp),%edx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80106ce6:	89 54 24 08          	mov    %edx,0x8(%esp)
80106cea:	89 74 24 04          	mov    %esi,0x4(%esp)
80106cee:	89 f9                	mov    %edi,%ecx
80106cf0:	29 d9                	sub    %ebx,%ecx
80106cf2:	01 c8                	add    %ecx,%eax
80106cf4:	89 04 24             	mov    %eax,(%esp)
80106cf7:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80106cfa:	e8 79 d8 ff ff       	call   80104578 <memmove>
    len -= n;
    buf += n;
80106cff:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106d02:	01 d6                	add    %edx,%esi
    va = va0 + PGSIZE;
80106d04:	8d bb 00 10 00 00    	lea    0x1000(%ebx),%edi
  while(len > 0){
80106d0a:	29 55 14             	sub    %edx,0x14(%ebp)
80106d0d:	74 29                	je     80106d38 <copyout+0x84>
    va0 = (uint)PGROUNDDOWN(va);
80106d0f:	89 fb                	mov    %edi,%ebx
80106d11:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    pa0 = uva2ka(pgdir, (char*)va0);
80106d17:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80106d1b:	8b 45 08             	mov    0x8(%ebp),%eax
80106d1e:	89 04 24             	mov    %eax,(%esp)
80106d21:	e8 5e ff ff ff       	call   80106c84 <uva2ka>
    if(pa0 == 0)
80106d26:	85 c0                	test   %eax,%eax
80106d28:	75 aa                	jne    80106cd4 <copyout+0x20>
      return -1;
80106d2a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
80106d2f:	83 c4 2c             	add    $0x2c,%esp
80106d32:	5b                   	pop    %ebx
80106d33:	5e                   	pop    %esi
80106d34:	5f                   	pop    %edi
80106d35:	5d                   	pop    %ebp
80106d36:	c3                   	ret    
80106d37:	90                   	nop
  return 0;
80106d38:	31 c0                	xor    %eax,%eax
}
80106d3a:	83 c4 2c             	add    $0x2c,%esp
80106d3d:	5b                   	pop    %ebx
80106d3e:	5e                   	pop    %esi
80106d3f:	5f                   	pop    %edi
80106d40:	5d                   	pop    %ebp
80106d41:	c3                   	ret    
