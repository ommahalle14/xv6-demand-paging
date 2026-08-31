
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4 0f                	in     $0xf,%al

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 80 10 00       	mov    $0x108000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc c0 a5 10 80       	mov    $0x8010a5c0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 30 2a 10 80       	mov    $0x80102a30,%eax
  jmp *%eax
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
80100038:	83 ec 0c             	sub    $0xc,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010003b:	68 60 65 10 80       	push   $0x80106560
80100040:	68 c0 a5 10 80       	push   $0x8010a5c0
80100045:	e8 e6 3b 00 00       	call   80103c30 <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010004a:	c7 05 0c ed 10 80 bc 	movl   $0x8010ecbc,0x8010ed0c
80100051:	ec 10 80 
  bcache.head.next = &bcache.head;
80100054:	c7 05 10 ed 10 80 bc 	movl   $0x8010ecbc,0x8010ed10
8010005b:	ec 10 80 
8010005e:	83 c4 10             	add    $0x10,%esp
80100061:	ba bc ec 10 80       	mov    $0x8010ecbc,%edx
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100066:	bb f4 a5 10 80       	mov    $0x8010a5f4,%ebx
8010006b:	eb 05                	jmp    80100072 <binit+0x3e>
8010006d:	8d 76 00             	lea    0x0(%esi),%esi
80100070:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
80100072:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
80100075:	c7 43 50 bc ec 10 80 	movl   $0x8010ecbc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
8010007c:	83 ec 08             	sub    $0x8,%esp
8010007f:	68 67 65 10 80       	push   $0x80106567
80100084:	8d 43 0c             	lea    0xc(%ebx),%eax
80100087:	50                   	push   %eax
80100088:	e8 97 3a 00 00       	call   80103b24 <initsleeplock>
    bcache.head.next->prev = b;
8010008d:	a1 10 ed 10 80       	mov    0x8010ed10,%eax
80100092:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100095:	89 1d 10 ed 10 80    	mov    %ebx,0x8010ed10

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010009b:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
801000a1:	89 da                	mov    %ebx,%edx
801000a3:	83 c4 10             	add    $0x10,%esp
801000a6:	3d bc ec 10 80       	cmp    $0x8010ecbc,%eax
801000ab:	72 c3                	jb     80100070 <binit+0x3c>
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000ad:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000b0:	c9                   	leave  
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
801000ba:	83 ec 28             	sub    $0x28,%esp
801000bd:	8b 75 08             	mov    0x8(%ebp),%esi
801000c0:	8b 7d 0c             	mov    0xc(%ebp),%edi
static struct buf*
bget(uint dev, uint blockno)
{
  struct buf *b;

  acquire(&bcache.lock);
801000c3:	68 c0 a5 10 80       	push   $0x8010a5c0
801000c8:	e8 9f 3c 00 00       	call   80103d6c <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000cd:	8b 1d 10 ed 10 80    	mov    0x8010ed10,%ebx
801000d3:	83 c4 10             	add    $0x10,%esp
801000d6:	81 fb bc ec 10 80    	cmp    $0x8010ecbc,%ebx
801000dc:	75 0d                	jne    801000eb <bread+0x37>
801000de:	eb 1c                	jmp    801000fc <bread+0x48>
801000e0:	8b 5b 54             	mov    0x54(%ebx),%ebx
801000e3:	81 fb bc ec 10 80    	cmp    $0x8010ecbc,%ebx
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
  }

  // Not cached; recycle an unused buffer.
  // Even if refcnt==0, B_DIRTY indicates a buffer is in use
  // because log.c has modified it but not yet committed it.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
801000fc:	8b 1d 0c ed 10 80    	mov    0x8010ed0c,%ebx
80100102:	81 fb bc ec 10 80    	cmp    $0x8010ecbc,%ebx
80100108:	75 0d                	jne    80100117 <bread+0x63>
8010010a:	eb 66                	jmp    80100172 <bread+0xbe>
8010010c:	8b 5b 50             	mov    0x50(%ebx),%ebx
8010010f:	81 fb bc ec 10 80    	cmp    $0x8010ecbc,%ebx
80100115:	74 5b                	je     80100172 <bread+0xbe>
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
80100136:	83 ec 0c             	sub    $0xc,%esp
80100139:	68 c0 a5 10 80       	push   $0x8010a5c0
8010013e:	e8 c1 3c 00 00       	call   80103e04 <release>
      acquiresleep(&b->lock);
80100143:	8d 43 0c             	lea    0xc(%ebx),%eax
80100146:	89 04 24             	mov    %eax,(%esp)
80100149:	e8 0a 3a 00 00       	call   80103b58 <acquiresleep>
8010014e:	83 c4 10             	add    $0x10,%esp
80100151:	89 d8                	mov    %ebx,%eax
bread(uint dev, uint blockno)
{
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100153:	f6 03 02             	testb  $0x2,(%ebx)
80100156:	75 12                	jne    8010016a <bread+0xb6>
    iderw(b);
80100158:	83 ec 0c             	sub    $0xc,%esp
8010015b:	53                   	push   %ebx
8010015c:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
8010015f:	e8 d4 1c 00 00       	call   80101e38 <iderw>
80100164:	83 c4 10             	add    $0x10,%esp
80100167:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  }
  return b;
}
8010016a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010016d:	5b                   	pop    %ebx
8010016e:	5e                   	pop    %esi
8010016f:	5f                   	pop    %edi
80100170:	5d                   	pop    %ebp
80100171:	c3                   	ret    
      release(&bcache.lock);
      acquiresleep(&b->lock);
      return b;
    }
  }
  panic("bget: no buffers");
80100172:	83 ec 0c             	sub    $0xc,%esp
80100175:	68 6e 65 10 80       	push   $0x8010656e
8010017a:	e8 b9 01 00 00       	call   80100338 <panic>
8010017f:	90                   	nop

80100180 <bwrite>:
}

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
80100180:	55                   	push   %ebp
80100181:	89 e5                	mov    %esp,%ebp
80100183:	53                   	push   %ebx
80100184:	83 ec 10             	sub    $0x10,%esp
80100187:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
8010018a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010018d:	50                   	push   %eax
8010018e:	e8 55 3a 00 00       	call   80103be8 <holdingsleep>
80100193:	83 c4 10             	add    $0x10,%esp
80100196:	85 c0                	test   %eax,%eax
80100198:	74 0f                	je     801001a9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
8010019a:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
8010019d:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001a0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001a3:	c9                   	leave  
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
  b->flags |= B_DIRTY;
  iderw(b);
801001a4:	e9 8f 1c 00 00       	jmp    80101e38 <iderw>
// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
801001a9:	83 ec 0c             	sub    $0xc,%esp
801001ac:	68 7f 65 10 80       	push   $0x8010657f
801001b1:	e8 82 01 00 00       	call   80100338 <panic>
801001b6:	66 90                	xchg   %ax,%ax

801001b8 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001b8:	55                   	push   %ebp
801001b9:	89 e5                	mov    %esp,%ebp
801001bb:	56                   	push   %esi
801001bc:	53                   	push   %ebx
801001bd:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001c0:	8d 73 0c             	lea    0xc(%ebx),%esi
801001c3:	83 ec 0c             	sub    $0xc,%esp
801001c6:	56                   	push   %esi
801001c7:	e8 1c 3a 00 00       	call   80103be8 <holdingsleep>
801001cc:	83 c4 10             	add    $0x10,%esp
801001cf:	85 c0                	test   %eax,%eax
801001d1:	74 64                	je     80100237 <brelse+0x7f>
    panic("brelse");

  releasesleep(&b->lock);
801001d3:	83 ec 0c             	sub    $0xc,%esp
801001d6:	56                   	push   %esi
801001d7:	e8 d0 39 00 00       	call   80103bac <releasesleep>

  acquire(&bcache.lock);
801001dc:	c7 04 24 c0 a5 10 80 	movl   $0x8010a5c0,(%esp)
801001e3:	e8 84 3b 00 00       	call   80103d6c <acquire>
  b->refcnt--;
801001e8:	8b 43 4c             	mov    0x4c(%ebx),%eax
801001eb:	48                   	dec    %eax
801001ec:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
801001ef:	83 c4 10             	add    $0x10,%esp
801001f2:	85 c0                	test   %eax,%eax
801001f4:	75 2f                	jne    80100225 <brelse+0x6d>
    // no one is waiting for it.
    b->next->prev = b->prev;
801001f6:	8b 43 54             	mov    0x54(%ebx),%eax
801001f9:	8b 53 50             	mov    0x50(%ebx),%edx
801001fc:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
801001ff:	8b 43 50             	mov    0x50(%ebx),%eax
80100202:	8b 53 54             	mov    0x54(%ebx),%edx
80100205:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100208:	a1 10 ed 10 80       	mov    0x8010ed10,%eax
8010020d:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
80100210:	c7 43 50 bc ec 10 80 	movl   $0x8010ecbc,0x50(%ebx)
    bcache.head.next->prev = b;
80100217:	a1 10 ed 10 80       	mov    0x8010ed10,%eax
8010021c:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
8010021f:	89 1d 10 ed 10 80    	mov    %ebx,0x8010ed10
  }
  
  release(&bcache.lock);
80100225:	c7 45 08 c0 a5 10 80 	movl   $0x8010a5c0,0x8(%ebp)
}
8010022c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010022f:	5b                   	pop    %ebx
80100230:	5e                   	pop    %esi
80100231:	5d                   	pop    %ebp
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
  
  release(&bcache.lock);
80100232:	e9 cd 3b 00 00       	jmp    80103e04 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");
80100237:	83 ec 0c             	sub    $0xc,%esp
8010023a:	68 86 65 10 80       	push   $0x80106586
8010023f:	e8 f4 00 00 00       	call   80100338 <panic>

80100244 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100244:	55                   	push   %ebp
80100245:	89 e5                	mov    %esp,%ebp
80100247:	57                   	push   %edi
80100248:	56                   	push   %esi
80100249:	53                   	push   %ebx
8010024a:	83 ec 28             	sub    $0x28,%esp
8010024d:	8b 7d 08             	mov    0x8(%ebp),%edi
80100250:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
80100253:	57                   	push   %edi
80100254:	e8 1b 13 00 00       	call   80101574 <iunlock>
  target = n;
  acquire(&cons.lock);
80100259:	c7 04 24 20 95 10 80 	movl   $0x80109520,(%esp)
80100260:	e8 07 3b 00 00       	call   80103d6c <acquire>
  while(n > 0){
80100265:	83 c4 10             	add    $0x10,%esp
80100268:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010026b:	31 c0                	xor    %eax,%eax
8010026d:	85 db                	test   %ebx,%ebx
8010026f:	0f 8e 92 00 00 00    	jle    80100307 <consoleread+0xc3>
    while(input.r == input.w){
80100275:	a1 a0 ef 10 80       	mov    0x8010efa0,%eax
8010027a:	3b 05 a4 ef 10 80    	cmp    0x8010efa4,%eax
80100280:	74 24                	je     801002a6 <consoleread+0x62>
80100282:	eb 54                	jmp    801002d8 <consoleread+0x94>
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
80100284:	83 ec 08             	sub    $0x8,%esp
80100287:	68 20 95 10 80       	push   $0x80109520
8010028c:	68 a0 ef 10 80       	push   $0x8010efa0
80100291:	e8 66 35 00 00       	call   801037fc <sleep>

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
80100296:	a1 a0 ef 10 80       	mov    0x8010efa0,%eax
8010029b:	83 c4 10             	add    $0x10,%esp
8010029e:	3b 05 a4 ef 10 80    	cmp    0x8010efa4,%eax
801002a4:	75 32                	jne    801002d8 <consoleread+0x94>
      if(myproc()->killed){
801002a6:	e8 15 30 00 00       	call   801032c0 <myproc>
801002ab:	8b 40 24             	mov    0x24(%eax),%eax
801002ae:	85 c0                	test   %eax,%eax
801002b0:	74 d2                	je     80100284 <consoleread+0x40>
        release(&cons.lock);
801002b2:	83 ec 0c             	sub    $0xc,%esp
801002b5:	68 20 95 10 80       	push   $0x80109520
801002ba:	e8 45 3b 00 00       	call   80103e04 <release>
        ilock(ip);
801002bf:	89 3c 24             	mov    %edi,(%esp)
801002c2:	e8 e5 11 00 00       	call   801014ac <ilock>
        return -1;
801002c7:	83 c4 10             	add    $0x10,%esp
801002ca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002cf:	8d 65 f4             	lea    -0xc(%ebp),%esp
801002d2:	5b                   	pop    %ebx
801002d3:	5e                   	pop    %esi
801002d4:	5f                   	pop    %edi
801002d5:	5d                   	pop    %ebp
801002d6:	c3                   	ret    
801002d7:	90                   	nop
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
801002d8:	8d 50 01             	lea    0x1(%eax),%edx
801002db:	89 15 a0 ef 10 80    	mov    %edx,0x8010efa0
801002e1:	89 c2                	mov    %eax,%edx
801002e3:	83 e2 7f             	and    $0x7f,%edx
801002e6:	0f be 92 20 ef 10 80 	movsbl -0x7fef10e0(%edx),%edx
    if(c == C('D')){  // EOF
801002ed:	83 fa 04             	cmp    $0x4,%edx
801002f0:	74 35                	je     80100327 <consoleread+0xe3>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
801002f2:	46                   	inc    %esi
801002f3:	88 56 ff             	mov    %dl,-0x1(%esi)
    --n;
801002f6:	4b                   	dec    %ebx
    if(c == '\n')
801002f7:	83 fa 0a             	cmp    $0xa,%edx
801002fa:	74 35                	je     80100331 <consoleread+0xed>
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
801002fc:	85 db                	test   %ebx,%ebx
801002fe:	0f 85 71 ff ff ff    	jne    80100275 <consoleread+0x31>
80100304:	8b 45 10             	mov    0x10(%ebp),%eax
80100307:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&cons.lock);
8010030a:	83 ec 0c             	sub    $0xc,%esp
8010030d:	68 20 95 10 80       	push   $0x80109520
80100312:	e8 ed 3a 00 00       	call   80103e04 <release>
  ilock(ip);
80100317:	89 3c 24             	mov    %edi,(%esp)
8010031a:	e8 8d 11 00 00       	call   801014ac <ilock>

  return target - n;
8010031f:	83 c4 10             	add    $0x10,%esp
80100322:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100325:	eb a8                	jmp    801002cf <consoleread+0x8b>
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
80100327:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010032a:	76 05                	jbe    80100331 <consoleread+0xed>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
8010032c:	a3 a0 ef 10 80       	mov    %eax,0x8010efa0
80100331:	8b 45 10             	mov    0x10(%ebp),%eax
80100334:	29 d8                	sub    %ebx,%eax
80100336:	eb cf                	jmp    80100307 <consoleread+0xc3>

80100338 <panic>:
    release(&cons.lock);
}

void
panic(char *s)
{
80100338:	55                   	push   %ebp
80100339:	89 e5                	mov    %esp,%ebp
8010033b:	56                   	push   %esi
8010033c:	53                   	push   %ebx
8010033d:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100340:	fa                   	cli    
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
80100341:	c7 05 54 95 10 80 00 	movl   $0x0,0x80109554
80100348:	00 00 00 
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
8010034b:	e8 4c 20 00 00       	call   8010239c <lapicid>
80100350:	83 ec 08             	sub    $0x8,%esp
80100353:	50                   	push   %eax
80100354:	68 8d 65 10 80       	push   $0x8010658d
80100359:	e8 9a 02 00 00       	call   801005f8 <cprintf>
  cprintf(s);
8010035e:	58                   	pop    %eax
8010035f:	ff 75 08             	pushl  0x8(%ebp)
80100362:	e8 91 02 00 00       	call   801005f8 <cprintf>
  cprintf("\n");
80100367:	c7 04 24 d7 6e 10 80 	movl   $0x80106ed7,(%esp)
8010036e:	e8 85 02 00 00       	call   801005f8 <cprintf>
  getcallerpcs(&s, pcs);
80100373:	5a                   	pop    %edx
80100374:	59                   	pop    %ecx
80100375:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100378:	53                   	push   %ebx
80100379:	8d 45 08             	lea    0x8(%ebp),%eax
8010037c:	50                   	push   %eax
8010037d:	e8 ca 38 00 00       	call   80103c4c <getcallerpcs>
80100382:	8d 75 f8             	lea    -0x8(%ebp),%esi
80100385:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
80100388:	83 ec 08             	sub    $0x8,%esp
8010038b:	ff 33                	pushl  (%ebx)
8010038d:	68 a1 65 10 80       	push   $0x801065a1
80100392:	e8 61 02 00 00       	call   801005f8 <cprintf>
80100397:	83 c3 04             	add    $0x4,%ebx
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
8010039a:	83 c4 10             	add    $0x10,%esp
8010039d:	39 f3                	cmp    %esi,%ebx
8010039f:	75 e7                	jne    80100388 <panic+0x50>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801003a1:	c7 05 58 95 10 80 01 	movl   $0x1,0x80109558
801003a8:	00 00 00 
801003ab:	eb fe                	jmp    801003ab <panic+0x73>
801003ad:	8d 76 00             	lea    0x0(%esi),%esi

801003b0 <consputc>:
}

void
consputc(int c)
{
  if(panicked){
801003b0:	8b 15 58 95 10 80    	mov    0x80109558,%edx
801003b6:	85 d2                	test   %edx,%edx
801003b8:	74 06                	je     801003c0 <consputc+0x10>
801003ba:	fa                   	cli    
801003bb:	eb fe                	jmp    801003bb <consputc+0xb>
801003bd:	8d 76 00             	lea    0x0(%esi),%esi
  crt[pos] = ' ' | 0x0700;
}

void
consputc(int c)
{
801003c0:	55                   	push   %ebp
801003c1:	89 e5                	mov    %esp,%ebp
801003c3:	57                   	push   %edi
801003c4:	56                   	push   %esi
801003c5:	53                   	push   %ebx
801003c6:	83 ec 1c             	sub    $0x1c,%esp
801003c9:	89 c3                	mov    %eax,%ebx
    cli();
    for(;;)
      ;
  }

  if(c == BACKSPACE){
801003cb:	3d 00 01 00 00       	cmp    $0x100,%eax
801003d0:	0f 84 a8 00 00 00    	je     8010047e <consputc+0xce>
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
801003d6:	83 ec 0c             	sub    $0xc,%esp
801003d9:	50                   	push   %eax
801003da:	e8 55 4e 00 00       	call   80105234 <uartputc>
801003df:	83 c4 10             	add    $0x10,%esp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801003e2:	bf d4 03 00 00       	mov    $0x3d4,%edi
801003e7:	b0 0e                	mov    $0xe,%al
801003e9:	89 fa                	mov    %edi,%edx
801003eb:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801003ec:	be d5 03 00 00       	mov    $0x3d5,%esi
801003f1:	89 f2                	mov    %esi,%edx
801003f3:	ec                   	in     (%dx),%al
{
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
801003f4:	0f b6 c8             	movzbl %al,%ecx
801003f7:	c1 e1 08             	shl    $0x8,%ecx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801003fa:	b0 0f                	mov    $0xf,%al
801003fc:	89 fa                	mov    %edi,%edx
801003fe:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801003ff:	89 f2                	mov    %esi,%edx
80100401:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
80100402:	0f b6 c0             	movzbl %al,%eax
80100405:	09 c1                	or     %eax,%ecx

  if(c == '\n')
80100407:	83 fb 0a             	cmp    $0xa,%ebx
8010040a:	0f 84 f3 00 00 00    	je     80100503 <consputc+0x153>
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
80100410:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
80100416:	0f 84 db 00 00 00    	je     801004f7 <consputc+0x147>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
8010041c:	8d 71 01             	lea    0x1(%ecx),%esi
8010041f:	0f b6 c3             	movzbl %bl,%eax
80100422:	80 cc 07             	or     $0x7,%ah
80100425:	66 89 84 09 00 80 0b 	mov    %ax,-0x7ff48000(%ecx,%ecx,1)
8010042c:	80 

  if(pos < 0 || pos > 25*80)
8010042d:	81 fe d0 07 00 00    	cmp    $0x7d0,%esi
80100433:	0f 8f b1 00 00 00    	jg     801004ea <consputc+0x13a>
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
80100439:	81 fe 7f 07 00 00    	cmp    $0x77f,%esi
8010043f:	7f 67                	jg     801004a8 <consputc+0xf8>
80100441:	89 f0                	mov    %esi,%eax
80100443:	c1 e8 08             	shr    $0x8,%eax
80100446:	89 45 d8             	mov    %eax,-0x28(%ebp)
80100449:	89 f3                	mov    %esi,%ebx
8010044b:	8d 8c 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%ecx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100452:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100457:	b0 0e                	mov    $0xe,%al
80100459:	89 fa                	mov    %edi,%edx
8010045b:	ee                   	out    %al,(%dx)
8010045c:	be d5 03 00 00       	mov    $0x3d5,%esi
80100461:	8a 45 d8             	mov    -0x28(%ebp),%al
80100464:	89 f2                	mov    %esi,%edx
80100466:	ee                   	out    %al,(%dx)
80100467:	b0 0f                	mov    $0xf,%al
80100469:	89 fa                	mov    %edi,%edx
8010046b:	ee                   	out    %al,(%dx)
8010046c:	88 d8                	mov    %bl,%al
8010046e:	89 f2                	mov    %esi,%edx
80100470:	ee                   	out    %al,(%dx)

  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
80100471:	66 c7 01 20 07       	movw   $0x720,(%ecx)
  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
}
80100476:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100479:	5b                   	pop    %ebx
8010047a:	5e                   	pop    %esi
8010047b:	5f                   	pop    %edi
8010047c:	5d                   	pop    %ebp
8010047d:	c3                   	ret    
    for(;;)
      ;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
8010047e:	83 ec 0c             	sub    $0xc,%esp
80100481:	6a 08                	push   $0x8
80100483:	e8 ac 4d 00 00       	call   80105234 <uartputc>
80100488:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
8010048f:	e8 a0 4d 00 00       	call   80105234 <uartputc>
80100494:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010049b:	e8 94 4d 00 00       	call   80105234 <uartputc>
801004a0:	83 c4 10             	add    $0x10,%esp
801004a3:	e9 3a ff ff ff       	jmp    801003e2 <consputc+0x32>

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004a8:	50                   	push   %eax
801004a9:	68 60 0e 00 00       	push   $0xe60
801004ae:	68 a0 80 0b 80       	push   $0x800b80a0
801004b3:	68 00 80 0b 80       	push   $0x800b8000
801004b8:	e8 23 3a 00 00       	call   80103ee0 <memmove>
    pos -= 80;
801004bd:	8d 5e b0             	lea    -0x50(%esi),%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801004c0:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi
801004c7:	83 c4 0c             	add    $0xc,%esp
801004ca:	b8 80 07 00 00       	mov    $0x780,%eax
801004cf:	29 d8                	sub    %ebx,%eax
801004d1:	01 c0                	add    %eax,%eax
801004d3:	50                   	push   %eax
801004d4:	6a 00                	push   $0x0
801004d6:	56                   	push   %esi
801004d7:	e8 70 39 00 00       	call   80103e4c <memset>
801004dc:	83 c4 10             	add    $0x10,%esp
801004df:	89 f1                	mov    %esi,%ecx
801004e1:	c6 45 d8 07          	movb   $0x7,-0x28(%ebp)
801004e5:	e9 68 ff ff ff       	jmp    80100452 <consputc+0xa2>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");
801004ea:	83 ec 0c             	sub    $0xc,%esp
801004ed:	68 a5 65 10 80       	push   $0x801065a5
801004f2:	e8 41 fe ff ff       	call   80100338 <panic>
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
801004f7:	85 c9                	test   %ecx,%ecx
801004f9:	74 1c                	je     80100517 <consputc+0x167>
801004fb:	8d 71 ff             	lea    -0x1(%ecx),%esi
801004fe:	e9 2a ff ff ff       	jmp    8010042d <consputc+0x7d>
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
80100503:	bb 50 00 00 00       	mov    $0x50,%ebx
80100508:	89 c8                	mov    %ecx,%eax
8010050a:	99                   	cltd   
8010050b:	f7 fb                	idiv   %ebx
8010050d:	29 d3                	sub    %edx,%ebx
8010050f:	8d 34 19             	lea    (%ecx,%ebx,1),%esi
80100512:	e9 16 ff ff ff       	jmp    8010042d <consputc+0x7d>
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
80100517:	b9 00 80 0b 80       	mov    $0x800b8000,%ecx
8010051c:	31 db                	xor    %ebx,%ebx
8010051e:	c6 45 d8 00          	movb   $0x0,-0x28(%ebp)
80100522:	e9 2b ff ff ff       	jmp    80100452 <consputc+0xa2>
80100527:	90                   	nop

80100528 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
80100528:	55                   	push   %ebp
80100529:	89 e5                	mov    %esp,%ebp
8010052b:	57                   	push   %edi
8010052c:	56                   	push   %esi
8010052d:	53                   	push   %ebx
8010052e:	83 ec 2c             	sub    $0x2c,%esp
80100531:	89 d6                	mov    %edx,%esi
80100533:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
80100536:	85 c9                	test   %ecx,%ecx
80100538:	74 0c                	je     80100546 <printint+0x1e>
8010053a:	89 c7                	mov    %eax,%edi
8010053c:	c1 ef 1f             	shr    $0x1f,%edi
8010053f:	89 7d d4             	mov    %edi,-0x2c(%ebp)
80100542:	85 c0                	test   %eax,%eax
80100544:	78 4b                	js     80100591 <printint+0x69>
    x = -xx;
  else
    x = xx;

  i = 0;
80100546:	31 ff                	xor    %edi,%edi
80100548:	8d 5d d7             	lea    -0x29(%ebp),%ebx
8010054b:	eb 05                	jmp    80100552 <printint+0x2a>
8010054d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
80100550:	89 cf                	mov    %ecx,%edi
80100552:	8d 4f 01             	lea    0x1(%edi),%ecx
80100555:	31 d2                	xor    %edx,%edx
80100557:	f7 f6                	div    %esi
80100559:	8a 92 d0 65 10 80    	mov    -0x7fef9a30(%edx),%dl
8010055f:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
80100562:	85 c0                	test   %eax,%eax
80100564:	75 ea                	jne    80100550 <printint+0x28>

  if(sign)
80100566:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100569:	85 c0                	test   %eax,%eax
8010056b:	74 08                	je     80100575 <printint+0x4d>
    buf[i++] = '-';
8010056d:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
80100572:	8d 4f 02             	lea    0x2(%edi),%ecx
80100575:	8d 74 0d d7          	lea    -0x29(%ebp,%ecx,1),%esi
80100579:	8d 76 00             	lea    0x0(%esi),%esi

  while(--i >= 0)
    consputc(buf[i]);
8010057c:	0f be 06             	movsbl (%esi),%eax
8010057f:	e8 2c fe ff ff       	call   801003b0 <consputc>
80100584:	4e                   	dec    %esi
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
80100585:	39 de                	cmp    %ebx,%esi
80100587:	75 f3                	jne    8010057c <printint+0x54>
    consputc(buf[i]);
}
80100589:	83 c4 2c             	add    $0x2c,%esp
8010058c:	5b                   	pop    %ebx
8010058d:	5e                   	pop    %esi
8010058e:	5f                   	pop    %edi
8010058f:	5d                   	pop    %ebp
80100590:	c3                   	ret    
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
80100591:	f7 d8                	neg    %eax
80100593:	eb b1                	jmp    80100546 <printint+0x1e>
80100595:	8d 76 00             	lea    0x0(%esi),%esi

80100598 <consolewrite>:
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100598:	55                   	push   %ebp
80100599:	89 e5                	mov    %esp,%ebp
8010059b:	57                   	push   %edi
8010059c:	56                   	push   %esi
8010059d:	53                   	push   %ebx
8010059e:	83 ec 18             	sub    $0x18,%esp
801005a1:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
801005a4:	ff 75 08             	pushl  0x8(%ebp)
801005a7:	e8 c8 0f 00 00       	call   80101574 <iunlock>
  acquire(&cons.lock);
801005ac:	c7 04 24 20 95 10 80 	movl   $0x80109520,(%esp)
801005b3:	e8 b4 37 00 00       	call   80103d6c <acquire>
  for(i = 0; i < n; i++)
801005b8:	83 c4 10             	add    $0x10,%esp
801005bb:	85 f6                	test   %esi,%esi
801005bd:	7e 16                	jle    801005d5 <consolewrite+0x3d>
801005bf:	8b 7d 0c             	mov    0xc(%ebp),%edi
801005c2:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
801005c5:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
801005c8:	0f b6 07             	movzbl (%edi),%eax
801005cb:	e8 e0 fd ff ff       	call   801003b0 <consputc>
801005d0:	47                   	inc    %edi
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
801005d1:	39 df                	cmp    %ebx,%edi
801005d3:	75 f3                	jne    801005c8 <consolewrite+0x30>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
801005d5:	83 ec 0c             	sub    $0xc,%esp
801005d8:	68 20 95 10 80       	push   $0x80109520
801005dd:	e8 22 38 00 00       	call   80103e04 <release>
  ilock(ip);
801005e2:	58                   	pop    %eax
801005e3:	ff 75 08             	pushl  0x8(%ebp)
801005e6:	e8 c1 0e 00 00       	call   801014ac <ilock>

  return n;
}
801005eb:	89 f0                	mov    %esi,%eax
801005ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
801005f0:	5b                   	pop    %ebx
801005f1:	5e                   	pop    %esi
801005f2:	5f                   	pop    %edi
801005f3:	5d                   	pop    %ebp
801005f4:	c3                   	ret    
801005f5:	8d 76 00             	lea    0x0(%esi),%esi

801005f8 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
801005f8:	55                   	push   %ebp
801005f9:	89 e5                	mov    %esp,%ebp
801005fb:	57                   	push   %edi
801005fc:	56                   	push   %esi
801005fd:	53                   	push   %ebx
801005fe:	83 ec 1c             	sub    $0x1c,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100601:	a1 54 95 10 80       	mov    0x80109554,%eax
80100606:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
80100609:	85 c0                	test   %eax,%eax
8010060b:	0f 85 07 01 00 00    	jne    80100718 <cprintf+0x120>
    acquire(&cons.lock);

  if (fmt == 0)
80100611:	8b 75 08             	mov    0x8(%ebp),%esi
80100614:	85 f6                	test   %esi,%esi
80100616:	0f 84 1b 01 00 00    	je     80100737 <cprintf+0x13f>
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010061c:	0f b6 06             	movzbl (%esi),%eax
8010061f:	85 c0                	test   %eax,%eax
80100621:	74 5d                	je     80100680 <cprintf+0x88>
80100623:	8d 7d 0c             	lea    0xc(%ebp),%edi
80100626:	31 db                	xor    %ebx,%ebx
80100628:	eb 43                	jmp    8010066d <cprintf+0x75>
8010062a:	66 90                	xchg   %ax,%ax
    if(c != '%'){
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
8010062c:	43                   	inc    %ebx
8010062d:	0f b6 14 1e          	movzbl (%esi,%ebx,1),%edx
    if(c == 0)
80100631:	85 d2                	test   %edx,%edx
80100633:	74 4b                	je     80100680 <cprintf+0x88>
      break;
    switch(c){
80100635:	83 fa 70             	cmp    $0x70,%edx
80100638:	74 70                	je     801006aa <cprintf+0xb2>
8010063a:	7f 64                	jg     801006a0 <cprintf+0xa8>
8010063c:	83 fa 25             	cmp    $0x25,%edx
8010063f:	0f 84 9b 00 00 00    	je     801006e0 <cprintf+0xe8>
80100645:	83 fa 64             	cmp    $0x64,%edx
80100648:	75 7a                	jne    801006c4 <cprintf+0xcc>
    case 'd':
      printint(*argp++, 10, 1);
8010064a:	8d 47 04             	lea    0x4(%edi),%eax
8010064d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100650:	b9 01 00 00 00       	mov    $0x1,%ecx
80100655:	ba 0a 00 00 00       	mov    $0xa,%edx
8010065a:	8b 07                	mov    (%edi),%eax
8010065c:	e8 c7 fe ff ff       	call   80100528 <printint>
80100661:	8b 7d e4             	mov    -0x1c(%ebp),%edi

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100664:	43                   	inc    %ebx
80100665:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100669:	85 c0                	test   %eax,%eax
8010066b:	74 13                	je     80100680 <cprintf+0x88>
    if(c != '%'){
8010066d:	83 f8 25             	cmp    $0x25,%eax
80100670:	74 ba                	je     8010062c <cprintf+0x34>
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
80100672:	e8 39 fd ff ff       	call   801003b0 <consputc>

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100677:	43                   	inc    %ebx
80100678:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
8010067c:	85 c0                	test   %eax,%eax
8010067e:	75 ed                	jne    8010066d <cprintf+0x75>
      consputc(c);
      break;
    }
  }

  if(locking)
80100680:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100683:	85 c0                	test   %eax,%eax
80100685:	74 10                	je     80100697 <cprintf+0x9f>
    release(&cons.lock);
80100687:	83 ec 0c             	sub    $0xc,%esp
8010068a:	68 20 95 10 80       	push   $0x80109520
8010068f:	e8 70 37 00 00       	call   80103e04 <release>
80100694:	83 c4 10             	add    $0x10,%esp
}
80100697:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010069a:	5b                   	pop    %ebx
8010069b:	5e                   	pop    %esi
8010069c:	5f                   	pop    %edi
8010069d:	5d                   	pop    %ebp
8010069e:	c3                   	ret    
8010069f:	90                   	nop
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
801006a0:	83 fa 73             	cmp    $0x73,%edx
801006a3:	74 47                	je     801006ec <cprintf+0xf4>
801006a5:	83 fa 78             	cmp    $0x78,%edx
801006a8:	75 1a                	jne    801006c4 <cprintf+0xcc>
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
801006aa:	8d 47 04             	lea    0x4(%edi),%eax
801006ad:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006b0:	31 c9                	xor    %ecx,%ecx
801006b2:	ba 10 00 00 00       	mov    $0x10,%edx
801006b7:	8b 07                	mov    (%edi),%eax
801006b9:	e8 6a fe ff ff       	call   80100528 <printint>
801006be:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      break;
801006c1:	eb a1                	jmp    80100664 <cprintf+0x6c>
801006c3:	90                   	nop
801006c4:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
801006c7:	b8 25 00 00 00       	mov    $0x25,%eax
801006cc:	e8 df fc ff ff       	call   801003b0 <consputc>
      consputc(c);
801006d1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801006d4:	89 d0                	mov    %edx,%eax
801006d6:	e8 d5 fc ff ff       	call   801003b0 <consputc>
      break;
801006db:	eb 87                	jmp    80100664 <cprintf+0x6c>
801006dd:	8d 76 00             	lea    0x0(%esi),%esi
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
801006e0:	b8 25 00 00 00       	mov    $0x25,%eax
801006e5:	e8 c6 fc ff ff       	call   801003b0 <consputc>
801006ea:	eb 8b                	jmp    80100677 <cprintf+0x7f>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
801006ec:	8d 47 04             	lea    0x4(%edi),%eax
801006ef:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006f2:	8b 3f                	mov    (%edi),%edi
801006f4:	85 ff                	test   %edi,%edi
801006f6:	74 38                	je     80100730 <cprintf+0x138>
        s = "(null)";
      for(; *s; s++)
801006f8:	0f be 07             	movsbl (%edi),%eax
801006fb:	84 c0                	test   %al,%al
801006fd:	74 0e                	je     8010070d <cprintf+0x115>
801006ff:	90                   	nop
        consputc(*s);
80100700:	e8 ab fc ff ff       	call   801003b0 <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
80100705:	47                   	inc    %edi
80100706:	0f be 07             	movsbl (%edi),%eax
80100709:	84 c0                	test   %al,%al
8010070b:	75 f3                	jne    80100700 <cprintf+0x108>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
8010070d:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80100710:	e9 4f ff ff ff       	jmp    80100664 <cprintf+0x6c>
80100715:	8d 76 00             	lea    0x0(%esi),%esi
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);
80100718:	83 ec 0c             	sub    $0xc,%esp
8010071b:	68 20 95 10 80       	push   $0x80109520
80100720:	e8 47 36 00 00       	call   80103d6c <acquire>
80100725:	83 c4 10             	add    $0x10,%esp
80100728:	e9 e4 fe ff ff       	jmp    80100611 <cprintf+0x19>
8010072d:	8d 76 00             	lea    0x0(%esi),%esi
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
80100730:	bf b8 65 10 80       	mov    $0x801065b8,%edi
80100735:	eb c1                	jmp    801006f8 <cprintf+0x100>
  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);

  if (fmt == 0)
    panic("null fmt");
80100737:	83 ec 0c             	sub    $0xc,%esp
8010073a:	68 bf 65 10 80       	push   $0x801065bf
8010073f:	e8 f4 fb ff ff       	call   80100338 <panic>

80100744 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
80100744:	55                   	push   %ebp
80100745:	89 e5                	mov    %esp,%ebp
80100747:	57                   	push   %edi
80100748:	56                   	push   %esi
80100749:	53                   	push   %ebx
8010074a:	83 ec 18             	sub    $0x18,%esp
8010074d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int c, doprocdump = 0;

  acquire(&cons.lock);
80100750:	68 20 95 10 80       	push   $0x80109520
80100755:	e8 12 36 00 00       	call   80103d6c <acquire>
  while((c = getc()) >= 0){
8010075a:	83 c4 10             	add    $0x10,%esp
#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;
8010075d:	31 f6                	xor    %esi,%esi
8010075f:	90                   	nop

  acquire(&cons.lock);
  while((c = getc()) >= 0){
80100760:	ff d3                	call   *%ebx
80100762:	89 c7                	mov    %eax,%edi
80100764:	85 c0                	test   %eax,%eax
80100766:	78 40                	js     801007a8 <consoleintr+0x64>
    switch(c){
80100768:	83 ff 10             	cmp    $0x10,%edi
8010076b:	0f 84 23 01 00 00    	je     80100894 <consoleintr+0x150>
80100771:	7e 55                	jle    801007c8 <consoleintr+0x84>
80100773:	83 ff 15             	cmp    $0x15,%edi
80100776:	0f 84 d0 00 00 00    	je     8010084c <consoleintr+0x108>
8010077c:	83 ff 7f             	cmp    $0x7f,%edi
8010077f:	75 4c                	jne    801007cd <consoleintr+0x89>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
80100781:	a1 a8 ef 10 80       	mov    0x8010efa8,%eax
80100786:	3b 05 a4 ef 10 80    	cmp    0x8010efa4,%eax
8010078c:	74 d2                	je     80100760 <consoleintr+0x1c>
        input.e--;
8010078e:	48                   	dec    %eax
8010078f:	a3 a8 ef 10 80       	mov    %eax,0x8010efa8
        consputc(BACKSPACE);
80100794:	b8 00 01 00 00       	mov    $0x100,%eax
80100799:	e8 12 fc ff ff       	call   801003b0 <consputc>
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
8010079e:	ff d3                	call   *%ebx
801007a0:	89 c7                	mov    %eax,%edi
801007a2:	85 c0                	test   %eax,%eax
801007a4:	79 c2                	jns    80100768 <consoleintr+0x24>
801007a6:	66 90                	xchg   %ax,%ax
        }
      }
      break;
    }
  }
  release(&cons.lock);
801007a8:	83 ec 0c             	sub    $0xc,%esp
801007ab:	68 20 95 10 80       	push   $0x80109520
801007b0:	e8 4f 36 00 00       	call   80103e04 <release>
  if(doprocdump) {
801007b5:	83 c4 10             	add    $0x10,%esp
801007b8:	85 f6                	test   %esi,%esi
801007ba:	0f 85 e0 00 00 00    	jne    801008a0 <consoleintr+0x15c>
    procdump();  // now call procdump() wo. cons.lock held
  }
}
801007c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801007c3:	5b                   	pop    %ebx
801007c4:	5e                   	pop    %esi
801007c5:	5f                   	pop    %edi
801007c6:	5d                   	pop    %ebp
801007c7:	c3                   	ret    
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
801007c8:	83 ff 08             	cmp    $0x8,%edi
801007cb:	74 b4                	je     80100781 <consoleintr+0x3d>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
801007cd:	85 ff                	test   %edi,%edi
801007cf:	74 8f                	je     80100760 <consoleintr+0x1c>
801007d1:	a1 a8 ef 10 80       	mov    0x8010efa8,%eax
801007d6:	89 c2                	mov    %eax,%edx
801007d8:	2b 15 a0 ef 10 80    	sub    0x8010efa0,%edx
801007de:	83 fa 7f             	cmp    $0x7f,%edx
801007e1:	0f 87 79 ff ff ff    	ja     80100760 <consoleintr+0x1c>
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
801007e7:	8d 50 01             	lea    0x1(%eax),%edx
801007ea:	89 15 a8 ef 10 80    	mov    %edx,0x8010efa8
801007f0:	83 e0 7f             	and    $0x7f,%eax
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
801007f3:	83 ff 0d             	cmp    $0xd,%edi
801007f6:	0f 84 b0 00 00 00    	je     801008ac <consoleintr+0x168>
        input.buf[input.e++ % INPUT_BUF] = c;
801007fc:	89 f9                	mov    %edi,%ecx
801007fe:	88 88 20 ef 10 80    	mov    %cl,-0x7fef10e0(%eax)
        consputc(c);
80100804:	89 f8                	mov    %edi,%eax
80100806:	e8 a5 fb ff ff       	call   801003b0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
8010080b:	83 ff 0a             	cmp    $0xa,%edi
8010080e:	0f 84 a9 00 00 00    	je     801008bd <consoleintr+0x179>
80100814:	83 ff 04             	cmp    $0x4,%edi
80100817:	0f 84 a0 00 00 00    	je     801008bd <consoleintr+0x179>
8010081d:	a1 a0 ef 10 80       	mov    0x8010efa0,%eax
80100822:	83 e8 80             	sub    $0xffffff80,%eax
80100825:	39 05 a8 ef 10 80    	cmp    %eax,0x8010efa8
8010082b:	0f 85 2f ff ff ff    	jne    80100760 <consoleintr+0x1c>
          input.w = input.e;
80100831:	a3 a4 ef 10 80       	mov    %eax,0x8010efa4
          wakeup(&input.r);
80100836:	83 ec 0c             	sub    $0xc,%esp
80100839:	68 a0 ef 10 80       	push   $0x8010efa0
8010083e:	e8 61 31 00 00       	call   801039a4 <wakeup>
80100843:	83 c4 10             	add    $0x10,%esp
80100846:	e9 15 ff ff ff       	jmp    80100760 <consoleintr+0x1c>
8010084b:	90                   	nop
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010084c:	a1 a8 ef 10 80       	mov    0x8010efa8,%eax
80100851:	39 05 a4 ef 10 80    	cmp    %eax,0x8010efa4
80100857:	75 27                	jne    80100880 <consoleintr+0x13c>
80100859:	e9 02 ff ff ff       	jmp    80100760 <consoleintr+0x1c>
8010085e:	66 90                	xchg   %ax,%ax
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100860:	a3 a8 ef 10 80       	mov    %eax,0x8010efa8
        consputc(BACKSPACE);
80100865:	b8 00 01 00 00       	mov    $0x100,%eax
8010086a:	e8 41 fb ff ff       	call   801003b0 <consputc>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010086f:	a1 a8 ef 10 80       	mov    0x8010efa8,%eax
80100874:	3b 05 a4 ef 10 80    	cmp    0x8010efa4,%eax
8010087a:	0f 84 e0 fe ff ff    	je     80100760 <consoleintr+0x1c>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100880:	48                   	dec    %eax
80100881:	89 c2                	mov    %eax,%edx
80100883:	83 e2 7f             	and    $0x7f,%edx
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100886:	80 ba 20 ef 10 80 0a 	cmpb   $0xa,-0x7fef10e0(%edx)
8010088d:	75 d1                	jne    80100860 <consoleintr+0x11c>
8010088f:	e9 cc fe ff ff       	jmp    80100760 <consoleintr+0x1c>
  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
80100894:	be 01 00 00 00       	mov    $0x1,%esi
80100899:	e9 c2 fe ff ff       	jmp    80100760 <consoleintr+0x1c>
8010089e:	66 90                	xchg   %ax,%ax
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
  }
}
801008a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801008a3:	5b                   	pop    %ebx
801008a4:	5e                   	pop    %esi
801008a5:	5f                   	pop    %edi
801008a6:	5d                   	pop    %ebp
      break;
    }
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
801008a7:	e9 cc 31 00 00       	jmp    80103a78 <procdump>
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
801008ac:	c6 80 20 ef 10 80 0a 	movb   $0xa,-0x7fef10e0(%eax)
        consputc(c);
801008b3:	b8 0a 00 00 00       	mov    $0xa,%eax
801008b8:	e8 f3 fa ff ff       	call   801003b0 <consputc>
801008bd:	a1 a8 ef 10 80       	mov    0x8010efa8,%eax
801008c2:	e9 6a ff ff ff       	jmp    80100831 <consoleintr+0xed>
801008c7:	90                   	nop

801008c8 <consoleinit>:
  return n;
}

void
consoleinit(void)
{
801008c8:	55                   	push   %ebp
801008c9:	89 e5                	mov    %esp,%ebp
801008cb:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801008ce:	68 c8 65 10 80       	push   $0x801065c8
801008d3:	68 20 95 10 80       	push   $0x80109520
801008d8:	e8 53 33 00 00       	call   80103c30 <initlock>

  devsw[CONSOLE].write = consolewrite;
801008dd:	c7 05 6c f9 10 80 98 	movl   $0x80100598,0x8010f96c
801008e4:	05 10 80 
  devsw[CONSOLE].read = consoleread;
801008e7:	c7 05 68 f9 10 80 44 	movl   $0x80100244,0x8010f968
801008ee:	02 10 80 
  cons.locking = 1;
801008f1:	c7 05 54 95 10 80 01 	movl   $0x1,0x80109554
801008f8:	00 00 00 

  ioapicenable(IRQ_KBD, 0);
801008fb:	58                   	pop    %eax
801008fc:	5a                   	pop    %edx
801008fd:	6a 00                	push   $0x0
801008ff:	6a 01                	push   $0x1
80100901:	e8 ba 16 00 00       	call   80101fc0 <ioapicenable>
}
80100906:	83 c4 10             	add    $0x10,%esp
80100909:	c9                   	leave  
8010090a:	c3                   	ret    
8010090b:	90                   	nop

8010090c <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
8010090c:	55                   	push   %ebp
8010090d:	89 e5                	mov    %esp,%ebp
8010090f:	57                   	push   %edi
80100910:	56                   	push   %esi
80100911:	53                   	push   %ebx
80100912:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100918:	e8 a3 29 00 00       	call   801032c0 <myproc>
8010091d:	89 c7                	mov    %eax,%edi

  begin_op();
8010091f:	e8 40 1e 00 00       	call   80102764 <begin_op>

  if((ip = namei(path)) == 0){
80100924:	83 ec 0c             	sub    $0xc,%esp
80100927:	ff 75 08             	pushl  0x8(%ebp)
8010092a:	e8 2d 13 00 00       	call   80101c5c <namei>
8010092f:	83 c4 10             	add    $0x10,%esp
80100932:	85 c0                	test   %eax,%eax
80100934:	0f 84 a2 01 00 00    	je     80100adc <exec+0x1d0>
8010093a:	89 c3                	mov    %eax,%ebx
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
8010093c:	83 ec 0c             	sub    $0xc,%esp
8010093f:	50                   	push   %eax
80100940:	e8 67 0b 00 00       	call   801014ac <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100945:	6a 34                	push   $0x34
80100947:	6a 00                	push   $0x0
80100949:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
8010094f:	50                   	push   %eax
80100950:	53                   	push   %ebx
80100951:	e8 f6 0d 00 00       	call   8010174c <readi>
80100956:	83 c4 20             	add    $0x20,%esp
80100959:	83 f8 34             	cmp    $0x34,%eax
8010095c:	74 1e                	je     8010097c <exec+0x70>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
8010095e:	83 ec 0c             	sub    $0xc,%esp
80100961:	53                   	push   %ebx
80100962:	e8 99 0d 00 00       	call   80101700 <iunlockput>
    end_op();
80100967:	e8 60 1e 00 00       	call   801027cc <end_op>
8010096c:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
8010096f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100974:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100977:	5b                   	pop    %ebx
80100978:	5e                   	pop    %esi
80100979:	5f                   	pop    %edi
8010097a:	5d                   	pop    %ebp
8010097b:	c3                   	ret    
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
8010097c:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100983:	45 4c 46 
80100986:	75 d6                	jne    8010095e <exec+0x52>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100988:	e8 73 59 00 00       	call   80106300 <setupkvm>
8010098d:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100993:	85 c0                	test   %eax,%eax
80100995:	74 c7                	je     8010095e <exec+0x52>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100997:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
8010099d:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
801009a4:	00 
801009a5:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
801009ac:	00 00 00 
801009af:	0f 84 cb 00 00 00    	je     80100a80 <exec+0x174>
801009b5:	31 c0                	xor    %eax,%eax
801009b7:	89 bd ec fe ff ff    	mov    %edi,-0x114(%ebp)
801009bd:	89 c7                	mov    %eax,%edi
801009bf:	eb 16                	jmp    801009d7 <exec+0xcb>
801009c1:	8d 76 00             	lea    0x0(%esi),%esi
801009c4:	47                   	inc    %edi
801009c5:	83 c6 20             	add    $0x20,%esi
801009c8:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
801009cf:	39 f8                	cmp    %edi,%eax
801009d1:	0f 8e a3 00 00 00    	jle    80100a7a <exec+0x16e>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
801009d7:	6a 20                	push   $0x20
801009d9:	56                   	push   %esi
801009da:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
801009e0:	50                   	push   %eax
801009e1:	53                   	push   %ebx
801009e2:	e8 65 0d 00 00       	call   8010174c <readi>
801009e7:	83 c4 10             	add    $0x10,%esp
801009ea:	83 f8 20             	cmp    $0x20,%eax
801009ed:	75 75                	jne    80100a64 <exec+0x158>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
801009ef:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
801009f6:	75 cc                	jne    801009c4 <exec+0xb8>
      continue;
    if(ph.memsz < ph.filesz)
801009f8:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
801009fe:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100a04:	72 5e                	jb     80100a64 <exec+0x158>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100a06:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100a0c:	72 56                	jb     80100a64 <exec+0x158>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100a0e:	51                   	push   %ecx
80100a0f:	50                   	push   %eax
80100a10:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100a16:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100a1c:	e8 67 57 00 00       	call   80106188 <allocuvm>
80100a21:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100a27:	83 c4 10             	add    $0x10,%esp
80100a2a:	85 c0                	test   %eax,%eax
80100a2c:	74 36                	je     80100a64 <exec+0x158>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100a2e:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100a34:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100a39:	75 29                	jne    80100a64 <exec+0x158>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100a3b:	83 ec 0c             	sub    $0xc,%esp
80100a3e:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100a44:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100a4a:	53                   	push   %ebx
80100a4b:	50                   	push   %eax
80100a4c:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100a52:	e8 81 56 00 00       	call   801060d8 <loaduvm>
80100a57:	83 c4 20             	add    $0x20,%esp
80100a5a:	85 c0                	test   %eax,%eax
80100a5c:	0f 89 62 ff ff ff    	jns    801009c4 <exec+0xb8>
80100a62:	66 90                	xchg   %ax,%ax
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100a64:	83 ec 0c             	sub    $0xc,%esp
80100a67:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100a6d:	e8 1e 58 00 00       	call   80106290 <freevm>
80100a72:	83 c4 10             	add    $0x10,%esp
80100a75:	e9 e4 fe ff ff       	jmp    8010095e <exec+0x52>
80100a7a:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100a80:	83 ec 0c             	sub    $0xc,%esp
80100a83:	53                   	push   %ebx
80100a84:	e8 77 0c 00 00       	call   80101700 <iunlockput>
  end_op();
80100a89:	e8 3e 1d 00 00       	call   801027cc <end_op>
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100a8e:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100a94:	05 ff 0f 00 00       	add    $0xfff,%eax
80100a99:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100a9e:	83 c4 0c             	add    $0xc,%esp
80100aa1:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
80100aa7:	52                   	push   %edx
80100aa8:	50                   	push   %eax
80100aa9:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100aaf:	e8 d4 56 00 00       	call   80106188 <allocuvm>
80100ab4:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100aba:	83 c4 10             	add    $0x10,%esp
80100abd:	85 c0                	test   %eax,%eax
80100abf:	75 3a                	jne    80100afb <exec+0x1ef>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100ac1:	83 ec 0c             	sub    $0xc,%esp
80100ac4:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100aca:	e8 c1 57 00 00       	call   80106290 <freevm>
80100acf:	83 c4 10             	add    $0x10,%esp
  if(ip){
    iunlockput(ip);
    end_op();
  }
  return -1;
80100ad2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100ad7:	e9 98 fe ff ff       	jmp    80100974 <exec+0x68>
  struct proc *curproc = myproc();

  begin_op();

  if((ip = namei(path)) == 0){
    end_op();
80100adc:	e8 eb 1c 00 00       	call   801027cc <end_op>
    cprintf("exec: fail\n");
80100ae1:	83 ec 0c             	sub    $0xc,%esp
80100ae4:	68 e1 65 10 80       	push   $0x801065e1
80100ae9:	e8 0a fb ff ff       	call   801005f8 <cprintf>
    return -1;
80100aee:	83 c4 10             	add    $0x10,%esp
80100af1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100af6:	e9 79 fe ff ff       	jmp    80100974 <exec+0x68>
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100afb:	83 ec 08             	sub    $0x8,%esp
80100afe:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100b04:	2d 00 20 00 00       	sub    $0x2000,%eax
80100b09:	50                   	push   %eax
80100b0a:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b10:	e8 7f 58 00 00       	call   80106394 <clearpteu>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100b15:	8b 45 0c             	mov    0xc(%ebp),%eax
80100b18:	8b 00                	mov    (%eax),%eax
80100b1a:	83 c4 10             	add    $0x10,%esp
80100b1d:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100b23:	31 db                	xor    %ebx,%ebx
80100b25:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100b2b:	85 c0                	test   %eax,%eax
80100b2d:	74 6e                	je     80100b9d <exec+0x291>
80100b2f:	89 bd ec fe ff ff    	mov    %edi,-0x114(%ebp)
80100b35:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100b3b:	eb 0c                	jmp    80100b49 <exec+0x23d>
80100b3d:	8d 76 00             	lea    0x0(%esi),%esi
    if(argc >= MAXARG)
80100b40:	83 fb 20             	cmp    $0x20,%ebx
80100b43:	0f 84 78 ff ff ff    	je     80100ac1 <exec+0x1b5>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100b49:	83 ec 0c             	sub    $0xc,%esp
80100b4c:	50                   	push   %eax
80100b4d:	e8 c2 34 00 00       	call   80104014 <strlen>
80100b52:	f7 d0                	not    %eax
80100b54:	01 c6                	add    %eax,%esi
80100b56:	83 e6 fc             	and    $0xfffffffc,%esi
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100b59:	5a                   	pop    %edx
80100b5a:	8b 45 0c             	mov    0xc(%ebp),%eax
80100b5d:	ff 34 98             	pushl  (%eax,%ebx,4)
80100b60:	e8 af 34 00 00       	call   80104014 <strlen>
80100b65:	40                   	inc    %eax
80100b66:	50                   	push   %eax
80100b67:	8b 45 0c             	mov    0xc(%ebp),%eax
80100b6a:	ff 34 98             	pushl  (%eax,%ebx,4)
80100b6d:	56                   	push   %esi
80100b6e:	57                   	push   %edi
80100b6f:	e8 68 59 00 00       	call   801064dc <copyout>
80100b74:	83 c4 20             	add    $0x20,%esp
80100b77:	85 c0                	test   %eax,%eax
80100b79:	0f 88 42 ff ff ff    	js     80100ac1 <exec+0x1b5>
      goto bad;
    ustack[3+argc] = sp;
80100b7f:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100b85:	89 b4 9d 64 ff ff ff 	mov    %esi,-0x9c(%ebp,%ebx,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100b8c:	43                   	inc    %ebx
80100b8d:	8b 45 0c             	mov    0xc(%ebp),%eax
80100b90:	8b 04 98             	mov    (%eax,%ebx,4),%eax
80100b93:	85 c0                	test   %eax,%eax
80100b95:	75 a9                	jne    80100b40 <exec+0x234>
80100b97:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100b9d:	c7 84 9d 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%ebx,4)
80100ba4:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100ba8:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100baf:	ff ff ff 
  ustack[1] = argc;
80100bb2:	89 9d 5c ff ff ff    	mov    %ebx,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100bb8:	8d 04 9d 04 00 00 00 	lea    0x4(,%ebx,4),%eax
80100bbf:	89 f1                	mov    %esi,%ecx
80100bc1:	29 c1                	sub    %eax,%ecx
80100bc3:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)

  sp -= (3+argc+1) * 4;
80100bc9:	83 c0 0c             	add    $0xc,%eax
80100bcc:	29 c6                	sub    %eax,%esi
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100bce:	50                   	push   %eax
80100bcf:	52                   	push   %edx
80100bd0:	56                   	push   %esi
80100bd1:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100bd7:	e8 00 59 00 00       	call   801064dc <copyout>
80100bdc:	83 c4 10             	add    $0x10,%esp
80100bdf:	85 c0                	test   %eax,%eax
80100be1:	0f 88 da fe ff ff    	js     80100ac1 <exec+0x1b5>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100be7:	8b 45 08             	mov    0x8(%ebp),%eax
80100bea:	8a 10                	mov    (%eax),%dl
80100bec:	84 d2                	test   %dl,%dl
80100bee:	74 1b                	je     80100c0b <exec+0x2ff>
80100bf0:	40                   	inc    %eax
80100bf1:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100bf4:	eb 09                	jmp    80100bff <exec+0x2f3>
80100bf6:	66 90                	xchg   %ax,%ax
80100bf8:	8a 10                	mov    (%eax),%dl
80100bfa:	40                   	inc    %eax
80100bfb:	84 d2                	test   %dl,%dl
80100bfd:	74 09                	je     80100c08 <exec+0x2fc>
    if(*s == '/')
80100bff:	80 fa 2f             	cmp    $0x2f,%dl
80100c02:	75 f4                	jne    80100bf8 <exec+0x2ec>
      last = s+1;
80100c04:	89 c1                	mov    %eax,%ecx
80100c06:	eb f0                	jmp    80100bf8 <exec+0x2ec>
80100c08:	89 4d 08             	mov    %ecx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100c0b:	50                   	push   %eax
80100c0c:	6a 10                	push   $0x10
80100c0e:	ff 75 08             	pushl  0x8(%ebp)
80100c11:	8d 47 6c             	lea    0x6c(%edi),%eax
80100c14:	50                   	push   %eax
80100c15:	e8 c6 33 00 00       	call   80103fe0 <safestrcpy>

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
80100c1a:	8b 5f 04             	mov    0x4(%edi),%ebx
  curproc->pgdir = pgdir;
80100c1d:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100c23:	89 47 04             	mov    %eax,0x4(%edi)
  curproc->sz = sz;
80100c26:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100c2c:	89 07                	mov    %eax,(%edi)
  curproc->tf->eip = elf.entry;  // main
80100c2e:	8b 47 18             	mov    0x18(%edi),%eax
80100c31:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100c37:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100c3a:	8b 47 18             	mov    0x18(%edi),%eax
80100c3d:	89 70 44             	mov    %esi,0x44(%eax)
  switchuvm(curproc);
80100c40:	89 3c 24             	mov    %edi,(%esp)
80100c43:	e8 1c 53 00 00       	call   80105f64 <switchuvm>
  freevm(oldpgdir);
80100c48:	89 1c 24             	mov    %ebx,(%esp)
80100c4b:	e8 40 56 00 00       	call   80106290 <freevm>
  return 0;
80100c50:	83 c4 10             	add    $0x10,%esp
80100c53:	31 c0                	xor    %eax,%eax
80100c55:	e9 1a fd ff ff       	jmp    80100974 <exec+0x68>
80100c5a:	66 90                	xchg   %ax,%ax

80100c5c <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100c5c:	55                   	push   %ebp
80100c5d:	89 e5                	mov    %esp,%ebp
80100c5f:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100c62:	68 ed 65 10 80       	push   $0x801065ed
80100c67:	68 c0 ef 10 80       	push   $0x8010efc0
80100c6c:	e8 bf 2f 00 00       	call   80103c30 <initlock>
}
80100c71:	83 c4 10             	add    $0x10,%esp
80100c74:	c9                   	leave  
80100c75:	c3                   	ret    
80100c76:	66 90                	xchg   %ax,%ax

80100c78 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100c78:	55                   	push   %ebp
80100c79:	89 e5                	mov    %esp,%ebp
80100c7b:	53                   	push   %ebx
80100c7c:	83 ec 10             	sub    $0x10,%esp
  struct file *f;

  acquire(&ftable.lock);
80100c7f:	68 c0 ef 10 80       	push   $0x8010efc0
80100c84:	e8 e3 30 00 00       	call   80103d6c <acquire>
80100c89:	83 c4 10             	add    $0x10,%esp
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100c8c:	bb f4 ef 10 80       	mov    $0x8010eff4,%ebx
80100c91:	eb 0c                	jmp    80100c9f <filealloc+0x27>
80100c93:	90                   	nop
80100c94:	83 c3 18             	add    $0x18,%ebx
80100c97:	81 fb 54 f9 10 80    	cmp    $0x8010f954,%ebx
80100c9d:	73 25                	jae    80100cc4 <filealloc+0x4c>
    if(f->ref == 0){
80100c9f:	8b 43 04             	mov    0x4(%ebx),%eax
80100ca2:	85 c0                	test   %eax,%eax
80100ca4:	75 ee                	jne    80100c94 <filealloc+0x1c>
      f->ref = 1;
80100ca6:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100cad:	83 ec 0c             	sub    $0xc,%esp
80100cb0:	68 c0 ef 10 80       	push   $0x8010efc0
80100cb5:	e8 4a 31 00 00       	call   80103e04 <release>
      return f;
80100cba:	83 c4 10             	add    $0x10,%esp
80100cbd:	89 d8                	mov    %ebx,%eax
    }
  }
  release(&ftable.lock);
  return 0;
}
80100cbf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100cc2:	c9                   	leave  
80100cc3:	c3                   	ret    
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100cc4:	83 ec 0c             	sub    $0xc,%esp
80100cc7:	68 c0 ef 10 80       	push   $0x8010efc0
80100ccc:	e8 33 31 00 00       	call   80103e04 <release>
  return 0;
80100cd1:	83 c4 10             	add    $0x10,%esp
80100cd4:	31 c0                	xor    %eax,%eax
}
80100cd6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100cd9:	c9                   	leave  
80100cda:	c3                   	ret    
80100cdb:	90                   	nop

80100cdc <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100cdc:	55                   	push   %ebp
80100cdd:	89 e5                	mov    %esp,%ebp
80100cdf:	53                   	push   %ebx
80100ce0:	83 ec 10             	sub    $0x10,%esp
80100ce3:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100ce6:	68 c0 ef 10 80       	push   $0x8010efc0
80100ceb:	e8 7c 30 00 00       	call   80103d6c <acquire>
  if(f->ref < 1)
80100cf0:	8b 43 04             	mov    0x4(%ebx),%eax
80100cf3:	83 c4 10             	add    $0x10,%esp
80100cf6:	85 c0                	test   %eax,%eax
80100cf8:	7e 18                	jle    80100d12 <filedup+0x36>
    panic("filedup");
  f->ref++;
80100cfa:	40                   	inc    %eax
80100cfb:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100cfe:	83 ec 0c             	sub    $0xc,%esp
80100d01:	68 c0 ef 10 80       	push   $0x8010efc0
80100d06:	e8 f9 30 00 00       	call   80103e04 <release>
  return f;
}
80100d0b:	89 d8                	mov    %ebx,%eax
80100d0d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100d10:	c9                   	leave  
80100d11:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
80100d12:	83 ec 0c             	sub    $0xc,%esp
80100d15:	68 f4 65 10 80       	push   $0x801065f4
80100d1a:	e8 19 f6 ff ff       	call   80100338 <panic>
80100d1f:	90                   	nop

80100d20 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100d20:	55                   	push   %ebp
80100d21:	89 e5                	mov    %esp,%ebp
80100d23:	57                   	push   %edi
80100d24:	56                   	push   %esi
80100d25:	53                   	push   %ebx
80100d26:	83 ec 28             	sub    $0x28,%esp
80100d29:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct file ff;

  acquire(&ftable.lock);
80100d2c:	68 c0 ef 10 80       	push   $0x8010efc0
80100d31:	e8 36 30 00 00       	call   80103d6c <acquire>
  if(f->ref < 1)
80100d36:	8b 47 04             	mov    0x4(%edi),%eax
80100d39:	83 c4 10             	add    $0x10,%esp
80100d3c:	85 c0                	test   %eax,%eax
80100d3e:	0f 8e 8b 00 00 00    	jle    80100dcf <fileclose+0xaf>
    panic("fileclose");
  if(--f->ref > 0){
80100d44:	48                   	dec    %eax
80100d45:	89 47 04             	mov    %eax,0x4(%edi)
80100d48:	85 c0                	test   %eax,%eax
80100d4a:	74 14                	je     80100d60 <fileclose+0x40>
    release(&ftable.lock);
80100d4c:	c7 45 08 c0 ef 10 80 	movl   $0x8010efc0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100d53:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100d56:	5b                   	pop    %ebx
80100d57:	5e                   	pop    %esi
80100d58:	5f                   	pop    %edi
80100d59:	5d                   	pop    %ebp

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
80100d5a:	e9 a5 30 00 00       	jmp    80103e04 <release>
80100d5f:	90                   	nop
    return;
  }
  ff = *f;
80100d60:	8b 1f                	mov    (%edi),%ebx
80100d62:	8a 47 09             	mov    0x9(%edi),%al
80100d65:	88 45 e7             	mov    %al,-0x19(%ebp)
80100d68:	8b 77 0c             	mov    0xc(%edi),%esi
80100d6b:	8b 47 10             	mov    0x10(%edi),%eax
80100d6e:	89 45 e0             	mov    %eax,-0x20(%ebp)
  f->ref = 0;
  f->type = FD_NONE;
80100d71:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
  release(&ftable.lock);
80100d77:	83 ec 0c             	sub    $0xc,%esp
80100d7a:	68 c0 ef 10 80       	push   $0x8010efc0
80100d7f:	e8 80 30 00 00       	call   80103e04 <release>

  if(ff.type == FD_PIPE)
80100d84:	83 c4 10             	add    $0x10,%esp
80100d87:	83 fb 01             	cmp    $0x1,%ebx
80100d8a:	74 10                	je     80100d9c <fileclose+0x7c>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100d8c:	83 fb 02             	cmp    $0x2,%ebx
80100d8f:	74 1f                	je     80100db0 <fileclose+0x90>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100d91:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100d94:	5b                   	pop    %ebx
80100d95:	5e                   	pop    %esi
80100d96:	5f                   	pop    %edi
80100d97:	5d                   	pop    %ebp
80100d98:	c3                   	ret    
80100d99:	8d 76 00             	lea    0x0(%esi),%esi
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);

  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
80100d9c:	83 ec 08             	sub    $0x8,%esp
80100d9f:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
80100da3:	50                   	push   %eax
80100da4:	56                   	push   %esi
80100da5:	e8 b6 20 00 00       	call   80102e60 <pipeclose>
80100daa:	83 c4 10             	add    $0x10,%esp
80100dad:	eb e2                	jmp    80100d91 <fileclose+0x71>
80100daf:	90                   	nop
  else if(ff.type == FD_INODE){
    begin_op();
80100db0:	e8 af 19 00 00       	call   80102764 <begin_op>
    iput(ff.ip);
80100db5:	83 ec 0c             	sub    $0xc,%esp
80100db8:	ff 75 e0             	pushl  -0x20(%ebp)
80100dbb:	e8 f8 07 00 00       	call   801015b8 <iput>
    end_op();
80100dc0:	83 c4 10             	add    $0x10,%esp
  }
}
80100dc3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100dc6:	5b                   	pop    %ebx
80100dc7:	5e                   	pop    %esi
80100dc8:	5f                   	pop    %edi
80100dc9:	5d                   	pop    %ebp
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
80100dca:	e9 fd 19 00 00       	jmp    801027cc <end_op>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
80100dcf:	83 ec 0c             	sub    $0xc,%esp
80100dd2:	68 fc 65 10 80       	push   $0x801065fc
80100dd7:	e8 5c f5 ff ff       	call   80100338 <panic>

80100ddc <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100ddc:	55                   	push   %ebp
80100ddd:	89 e5                	mov    %esp,%ebp
80100ddf:	53                   	push   %ebx
80100de0:	53                   	push   %ebx
80100de1:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100de4:	83 3b 02             	cmpl   $0x2,(%ebx)
80100de7:	75 2b                	jne    80100e14 <filestat+0x38>
    ilock(f->ip);
80100de9:	83 ec 0c             	sub    $0xc,%esp
80100dec:	ff 73 10             	pushl  0x10(%ebx)
80100def:	e8 b8 06 00 00       	call   801014ac <ilock>
    stati(f->ip, st);
80100df4:	58                   	pop    %eax
80100df5:	5a                   	pop    %edx
80100df6:	ff 75 0c             	pushl  0xc(%ebp)
80100df9:	ff 73 10             	pushl  0x10(%ebx)
80100dfc:	e8 1f 09 00 00       	call   80101720 <stati>
    iunlock(f->ip);
80100e01:	59                   	pop    %ecx
80100e02:	ff 73 10             	pushl  0x10(%ebx)
80100e05:	e8 6a 07 00 00       	call   80101574 <iunlock>
    return 0;
80100e0a:	83 c4 10             	add    $0x10,%esp
80100e0d:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100e0f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e12:	c9                   	leave  
80100e13:	c3                   	ret    
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
80100e14:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100e19:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e1c:	c9                   	leave  
80100e1d:	c3                   	ret    
80100e1e:	66 90                	xchg   %ax,%ax

80100e20 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100e20:	55                   	push   %ebp
80100e21:	89 e5                	mov    %esp,%ebp
80100e23:	57                   	push   %edi
80100e24:	56                   	push   %esi
80100e25:	53                   	push   %ebx
80100e26:	83 ec 0c             	sub    $0xc,%esp
80100e29:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100e2c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100e2f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100e32:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100e36:	74 5c                	je     80100e94 <fileread+0x74>
    return -1;
  if(f->type == FD_PIPE)
80100e38:	8b 03                	mov    (%ebx),%eax
80100e3a:	83 f8 01             	cmp    $0x1,%eax
80100e3d:	74 41                	je     80100e80 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100e3f:	83 f8 02             	cmp    $0x2,%eax
80100e42:	75 57                	jne    80100e9b <fileread+0x7b>
    ilock(f->ip);
80100e44:	83 ec 0c             	sub    $0xc,%esp
80100e47:	ff 73 10             	pushl  0x10(%ebx)
80100e4a:	e8 5d 06 00 00       	call   801014ac <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100e4f:	57                   	push   %edi
80100e50:	ff 73 14             	pushl  0x14(%ebx)
80100e53:	56                   	push   %esi
80100e54:	ff 73 10             	pushl  0x10(%ebx)
80100e57:	e8 f0 08 00 00       	call   8010174c <readi>
80100e5c:	89 c6                	mov    %eax,%esi
80100e5e:	83 c4 20             	add    $0x20,%esp
80100e61:	85 c0                	test   %eax,%eax
80100e63:	7e 03                	jle    80100e68 <fileread+0x48>
      f->off += r;
80100e65:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100e68:	83 ec 0c             	sub    $0xc,%esp
80100e6b:	ff 73 10             	pushl  0x10(%ebx)
80100e6e:	e8 01 07 00 00       	call   80101574 <iunlock>
    return r;
80100e73:	83 c4 10             	add    $0x10,%esp
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
    ilock(f->ip);
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100e76:	89 f0                	mov    %esi,%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100e78:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e7b:	5b                   	pop    %ebx
80100e7c:	5e                   	pop    %esi
80100e7d:	5f                   	pop    %edi
80100e7e:	5d                   	pop    %ebp
80100e7f:	c3                   	ret    
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100e80:	8b 43 0c             	mov    0xc(%ebx),%eax
80100e83:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100e86:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e89:	5b                   	pop    %ebx
80100e8a:	5e                   	pop    %esi
80100e8b:	5f                   	pop    %edi
80100e8c:	5d                   	pop    %ebp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100e8d:	e9 5e 21 00 00       	jmp    80102ff0 <piperead>
80100e92:	66 90                	xchg   %ax,%ax
fileread(struct file *f, char *addr, int n)
{
  int r;

  if(f->readable == 0)
    return -1;
80100e94:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100e99:	eb dd                	jmp    80100e78 <fileread+0x58>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
80100e9b:	83 ec 0c             	sub    $0xc,%esp
80100e9e:	68 06 66 10 80       	push   $0x80106606
80100ea3:	e8 90 f4 ff ff       	call   80100338 <panic>

80100ea8 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100ea8:	55                   	push   %ebp
80100ea9:	89 e5                	mov    %esp,%ebp
80100eab:	57                   	push   %edi
80100eac:	56                   	push   %esi
80100ead:	53                   	push   %ebx
80100eae:	83 ec 1c             	sub    $0x1c,%esp
80100eb1:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100eb4:	8b 45 0c             	mov    0xc(%ebp),%eax
80100eb7:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100eba:	8b 45 10             	mov    0x10(%ebp),%eax
80100ebd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int r;

  if(f->writable == 0)
80100ec0:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
80100ec4:	0f 84 be 00 00 00    	je     80100f88 <filewrite+0xe0>
    return -1;
  if(f->type == FD_PIPE)
80100eca:	8b 03                	mov    (%ebx),%eax
80100ecc:	83 f8 01             	cmp    $0x1,%eax
80100ecf:	0f 84 c0 00 00 00    	je     80100f95 <filewrite+0xed>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100ed5:	83 f8 02             	cmp    $0x2,%eax
80100ed8:	0f 85 c9 00 00 00    	jne    80100fa7 <filewrite+0xff>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80100ede:	31 ff                	xor    %edi,%edi
80100ee0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100ee3:	85 c0                	test   %eax,%eax
80100ee5:	7f 2c                	jg     80100f13 <filewrite+0x6b>
80100ee7:	e9 8c 00 00 00       	jmp    80100f78 <filewrite+0xd0>
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80100eec:	01 43 14             	add    %eax,0x14(%ebx)
80100eef:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80100ef2:	83 ec 0c             	sub    $0xc,%esp
80100ef5:	ff 73 10             	pushl  0x10(%ebx)
80100ef8:	e8 77 06 00 00       	call   80101574 <iunlock>
      end_op();
80100efd:	e8 ca 18 00 00       	call   801027cc <end_op>

      if(r < 0)
        break;
      if(r != n1)
80100f02:	83 c4 10             	add    $0x10,%esp
80100f05:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100f08:	39 f0                	cmp    %esi,%eax
80100f0a:	75 5f                	jne    80100f6b <filewrite+0xc3>
        panic("short filewrite");
      i += r;
80100f0c:	01 f7                	add    %esi,%edi
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80100f0e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80100f11:	7e 65                	jle    80100f78 <filewrite+0xd0>
80100f13:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80100f16:	29 fe                	sub    %edi,%esi
80100f18:	81 fe 00 06 00 00    	cmp    $0x600,%esi
80100f1e:	7e 05                	jle    80100f25 <filewrite+0x7d>
80100f20:	be 00 06 00 00       	mov    $0x600,%esi
      int n1 = n - i;
      if(n1 > max)
        n1 = max;

      begin_op();
80100f25:	e8 3a 18 00 00       	call   80102764 <begin_op>
      ilock(f->ip);
80100f2a:	83 ec 0c             	sub    $0xc,%esp
80100f2d:	ff 73 10             	pushl  0x10(%ebx)
80100f30:	e8 77 05 00 00       	call   801014ac <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80100f35:	56                   	push   %esi
80100f36:	ff 73 14             	pushl  0x14(%ebx)
80100f39:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100f3c:	01 f8                	add    %edi,%eax
80100f3e:	50                   	push   %eax
80100f3f:	ff 73 10             	pushl  0x10(%ebx)
80100f42:	e8 09 09 00 00       	call   80101850 <writei>
80100f47:	83 c4 20             	add    $0x20,%esp
80100f4a:	85 c0                	test   %eax,%eax
80100f4c:	7f 9e                	jg     80100eec <filewrite+0x44>
80100f4e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        f->off += r;
      iunlock(f->ip);
80100f51:	83 ec 0c             	sub    $0xc,%esp
80100f54:	ff 73 10             	pushl  0x10(%ebx)
80100f57:	e8 18 06 00 00       	call   80101574 <iunlock>
      end_op();
80100f5c:	e8 6b 18 00 00       	call   801027cc <end_op>

      if(r < 0)
80100f61:	83 c4 10             	add    $0x10,%esp
80100f64:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100f67:	85 c0                	test   %eax,%eax
80100f69:	75 1d                	jne    80100f88 <filewrite+0xe0>
        break;
      if(r != n1)
        panic("short filewrite");
80100f6b:	83 ec 0c             	sub    $0xc,%esp
80100f6e:	68 0f 66 10 80       	push   $0x8010660f
80100f73:	e8 c0 f3 ff ff       	call   80100338 <panic>
      i += r;
    }
    return i == n ? n : -1;
80100f78:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
80100f7b:	75 0b                	jne    80100f88 <filewrite+0xe0>
80100f7d:	89 f8                	mov    %edi,%eax
  }
  panic("filewrite");
}
80100f7f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f82:	5b                   	pop    %ebx
80100f83:	5e                   	pop    %esi
80100f84:	5f                   	pop    %edi
80100f85:	5d                   	pop    %ebp
80100f86:	c3                   	ret    
80100f87:	90                   	nop
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
80100f88:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
80100f8d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f90:	5b                   	pop    %ebx
80100f91:	5e                   	pop    %esi
80100f92:	5f                   	pop    %edi
80100f93:	5d                   	pop    %ebp
80100f94:	c3                   	ret    
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
80100f95:	8b 43 0c             	mov    0xc(%ebx),%eax
80100f98:	89 45 08             	mov    %eax,0x8(%ebp)
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
80100f9b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f9e:	5b                   	pop    %ebx
80100f9f:	5e                   	pop    %esi
80100fa0:	5f                   	pop    %edi
80100fa1:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
80100fa2:	e9 51 1f 00 00       	jmp    80102ef8 <pipewrite>
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
80100fa7:	83 ec 0c             	sub    $0xc,%esp
80100faa:	68 15 66 10 80       	push   $0x80106615
80100faf:	e8 84 f3 ff ff       	call   80100338 <panic>

80100fb4 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80100fb4:	55                   	push   %ebp
80100fb5:	89 e5                	mov    %esp,%ebp
80100fb7:	56                   	push   %esi
80100fb8:	53                   	push   %ebx
80100fb9:	89 d3                	mov    %edx,%ebx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
80100fbb:	83 ec 08             	sub    $0x8,%esp
80100fbe:	c1 ea 0c             	shr    $0xc,%edx
80100fc1:	03 15 d8 f9 10 80    	add    0x8010f9d8,%edx
80100fc7:	52                   	push   %edx
80100fc8:	50                   	push   %eax
80100fc9:	e8 e6 f0 ff ff       	call   801000b4 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
80100fce:	89 d9                	mov    %ebx,%ecx
80100fd0:	83 e1 07             	and    $0x7,%ecx
80100fd3:	ba 01 00 00 00       	mov    $0x1,%edx
80100fd8:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80100fda:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
80100fe0:	c1 fb 03             	sar    $0x3,%ebx
80100fe3:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80100fe8:	83 c4 10             	add    $0x10,%esp
80100feb:	85 d1                	test   %edx,%ecx
80100fed:	74 27                	je     80101016 <bfree+0x62>
80100fef:	89 c6                	mov    %eax,%esi
80100ff1:	89 c8                	mov    %ecx,%eax
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80100ff3:	f7 d2                	not    %edx
80100ff5:	21 d0                	and    %edx,%eax
80100ff7:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
80100ffb:	83 ec 0c             	sub    $0xc,%esp
80100ffe:	56                   	push   %esi
80100fff:	e8 1c 19 00 00       	call   80102920 <log_write>
  brelse(bp);
80101004:	89 34 24             	mov    %esi,(%esp)
80101007:	e8 ac f1 ff ff       	call   801001b8 <brelse>
}
8010100c:	83 c4 10             	add    $0x10,%esp
8010100f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101012:	5b                   	pop    %ebx
80101013:	5e                   	pop    %esi
80101014:	5d                   	pop    %ebp
80101015:	c3                   	ret    

  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
80101016:	83 ec 0c             	sub    $0xc,%esp
80101019:	68 1f 66 10 80       	push   $0x8010661f
8010101e:	e8 15 f3 ff ff       	call   80100338 <panic>
80101023:	90                   	nop

80101024 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101024:	55                   	push   %ebp
80101025:	89 e5                	mov    %esp,%ebp
80101027:	57                   	push   %edi
80101028:	56                   	push   %esi
80101029:	53                   	push   %ebx
8010102a:	83 ec 1c             	sub    $0x1c,%esp
8010102d:	89 45 d8             	mov    %eax,-0x28(%ebp)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101030:	8b 0d c0 f9 10 80    	mov    0x8010f9c0,%ecx
80101036:	85 c9                	test   %ecx,%ecx
80101038:	74 7c                	je     801010b6 <balloc+0x92>
8010103a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101041:	83 ec 08             	sub    $0x8,%esp
80101044:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101047:	89 f0                	mov    %esi,%eax
80101049:	c1 f8 0c             	sar    $0xc,%eax
8010104c:	03 05 d8 f9 10 80    	add    0x8010f9d8,%eax
80101052:	50                   	push   %eax
80101053:	ff 75 d8             	pushl  -0x28(%ebp)
80101056:	e8 59 f0 ff ff       	call   801000b4 <bread>
8010105b:	89 c2                	mov    %eax,%edx
8010105d:	a1 c0 f9 10 80       	mov    0x8010f9c0,%eax
80101062:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101065:	83 c4 10             	add    $0x10,%esp
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101068:	31 c0                	xor    %eax,%eax
8010106a:	eb 27                	jmp    80101093 <balloc+0x6f>
      m = 1 << (bi % 8);
8010106c:	89 c1                	mov    %eax,%ecx
8010106e:	83 e1 07             	and    $0x7,%ecx
80101071:	bf 01 00 00 00       	mov    $0x1,%edi
80101076:	d3 e7                	shl    %cl,%edi
80101078:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010107b:	89 c1                	mov    %eax,%ecx
8010107d:	c1 f9 03             	sar    $0x3,%ecx
80101080:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101085:	85 7d e4             	test   %edi,-0x1c(%ebp)
80101088:	74 3a                	je     801010c4 <balloc+0xa0>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010108a:	40                   	inc    %eax
8010108b:	46                   	inc    %esi
8010108c:	3d 00 10 00 00       	cmp    $0x1000,%eax
80101091:	74 05                	je     80101098 <balloc+0x74>
80101093:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80101096:	72 d4                	jb     8010106c <balloc+0x48>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101098:	83 ec 0c             	sub    $0xc,%esp
8010109b:	52                   	push   %edx
8010109c:	e8 17 f1 ff ff       	call   801001b8 <brelse>
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801010a1:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801010a8:	8b 45 dc             	mov    -0x24(%ebp),%eax
801010ab:	83 c4 10             	add    $0x10,%esp
801010ae:	39 05 c0 f9 10 80    	cmp    %eax,0x8010f9c0
801010b4:	77 8b                	ja     80101041 <balloc+0x1d>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
801010b6:	83 ec 0c             	sub    $0xc,%esp
801010b9:	68 32 66 10 80       	push   $0x80106632
801010be:	e8 75 f2 ff ff       	call   80100338 <panic>
801010c3:	90                   	nop
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
801010c4:	8a 45 e4             	mov    -0x1c(%ebp),%al
801010c7:	09 f8                	or     %edi,%eax
801010c9:	88 44 0a 5c          	mov    %al,0x5c(%edx,%ecx,1)
        log_write(bp);
801010cd:	83 ec 0c             	sub    $0xc,%esp
801010d0:	52                   	push   %edx
801010d1:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801010d4:	e8 47 18 00 00       	call   80102920 <log_write>
        brelse(bp);
801010d9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801010dc:	89 14 24             	mov    %edx,(%esp)
801010df:	e8 d4 f0 ff ff       	call   801001b8 <brelse>
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
801010e4:	58                   	pop    %eax
801010e5:	5a                   	pop    %edx
801010e6:	56                   	push   %esi
801010e7:	ff 75 d8             	pushl  -0x28(%ebp)
801010ea:	e8 c5 ef ff ff       	call   801000b4 <bread>
801010ef:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801010f1:	83 c4 0c             	add    $0xc,%esp
801010f4:	68 00 02 00 00       	push   $0x200
801010f9:	6a 00                	push   $0x0
801010fb:	8d 40 5c             	lea    0x5c(%eax),%eax
801010fe:	50                   	push   %eax
801010ff:	e8 48 2d 00 00       	call   80103e4c <memset>
  log_write(bp);
80101104:	89 1c 24             	mov    %ebx,(%esp)
80101107:	e8 14 18 00 00       	call   80102920 <log_write>
  brelse(bp);
8010110c:	89 1c 24             	mov    %ebx,(%esp)
8010110f:	e8 a4 f0 ff ff       	call   801001b8 <brelse>
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
80101114:	89 f0                	mov    %esi,%eax
80101116:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101119:	5b                   	pop    %ebx
8010111a:	5e                   	pop    %esi
8010111b:	5f                   	pop    %edi
8010111c:	5d                   	pop    %ebp
8010111d:	c3                   	ret    
8010111e:	66 90                	xchg   %ax,%ax

80101120 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101120:	55                   	push   %ebp
80101121:	89 e5                	mov    %esp,%ebp
80101123:	57                   	push   %edi
80101124:	56                   	push   %esi
80101125:	53                   	push   %ebx
80101126:	83 ec 28             	sub    $0x28,%esp
80101129:	89 c7                	mov    %eax,%edi
8010112b:	89 d6                	mov    %edx,%esi
  struct inode *ip, *empty;

  acquire(&icache.lock);
8010112d:	68 e0 f9 10 80       	push   $0x8010f9e0
80101132:	e8 35 2c 00 00       	call   80103d6c <acquire>
80101137:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
8010113a:	31 c0                	xor    %eax,%eax
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010113c:	bb 14 fa 10 80       	mov    $0x8010fa14,%ebx
80101141:	eb 13                	jmp    80101156 <iget+0x36>
80101143:	90                   	nop
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101144:	85 c0                	test   %eax,%eax
80101146:	74 3c                	je     80101184 <iget+0x64>

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101148:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010114e:	81 fb 34 16 11 80    	cmp    $0x80111634,%ebx
80101154:	73 42                	jae    80101198 <iget+0x78>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101156:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101159:	85 c9                	test   %ecx,%ecx
8010115b:	7e e7                	jle    80101144 <iget+0x24>
8010115d:	39 3b                	cmp    %edi,(%ebx)
8010115f:	75 e3                	jne    80101144 <iget+0x24>
80101161:	39 73 04             	cmp    %esi,0x4(%ebx)
80101164:	75 de                	jne    80101144 <iget+0x24>
      ip->ref++;
80101166:	41                   	inc    %ecx
80101167:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
8010116a:	83 ec 0c             	sub    $0xc,%esp
8010116d:	68 e0 f9 10 80       	push   $0x8010f9e0
80101172:	e8 8d 2c 00 00       	call   80103e04 <release>
      return ip;
80101177:	83 c4 10             	add    $0x10,%esp
8010117a:	89 d8                	mov    %ebx,%eax
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);

  return ip;
}
8010117c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010117f:	5b                   	pop    %ebx
80101180:	5e                   	pop    %esi
80101181:	5f                   	pop    %edi
80101182:	5d                   	pop    %ebp
80101183:	c3                   	ret    
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101184:	85 c9                	test   %ecx,%ecx
80101186:	75 c0                	jne    80101148 <iget+0x28>
80101188:	89 d8                	mov    %ebx,%eax

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010118a:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101190:	81 fb 34 16 11 80    	cmp    $0x80111634,%ebx
80101196:	72 be                	jb     80101156 <iget+0x36>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101198:	85 c0                	test   %eax,%eax
8010119a:	74 31                	je     801011cd <iget+0xad>
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
8010119c:	89 38                	mov    %edi,(%eax)
  ip->inum = inum;
8010119e:	89 70 04             	mov    %esi,0x4(%eax)
  ip->ref = 1;
801011a1:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  ip->valid = 0;
801011a8:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
801011af:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  release(&icache.lock);
801011b2:	83 ec 0c             	sub    $0xc,%esp
801011b5:	68 e0 f9 10 80       	push   $0x8010f9e0
801011ba:	e8 45 2c 00 00       	call   80103e04 <release>

  return ip;
801011bf:	83 c4 10             	add    $0x10,%esp
801011c2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
801011c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011c8:	5b                   	pop    %ebx
801011c9:	5e                   	pop    %esi
801011ca:	5f                   	pop    %edi
801011cb:	5d                   	pop    %ebp
801011cc:	c3                   	ret    
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");
801011cd:	83 ec 0c             	sub    $0xc,%esp
801011d0:	68 48 66 10 80       	push   $0x80106648
801011d5:	e8 5e f1 ff ff       	call   80100338 <panic>
801011da:	66 90                	xchg   %ax,%ax

801011dc <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801011dc:	55                   	push   %ebp
801011dd:	89 e5                	mov    %esp,%ebp
801011df:	57                   	push   %edi
801011e0:	56                   	push   %esi
801011e1:	53                   	push   %ebx
801011e2:	83 ec 1c             	sub    $0x1c,%esp
801011e5:	89 c6                	mov    %eax,%esi
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801011e7:	83 fa 0b             	cmp    $0xb,%edx
801011ea:	77 14                	ja     80101200 <bmap+0x24>
801011ec:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
    if((addr = ip->addrs[bn]) == 0)
801011ef:	8b 43 5c             	mov    0x5c(%ebx),%eax
801011f2:	85 c0                	test   %eax,%eax
801011f4:	74 6a                	je     80101260 <bmap+0x84>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801011f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011f9:	5b                   	pop    %ebx
801011fa:	5e                   	pop    %esi
801011fb:	5f                   	pop    %edi
801011fc:	5d                   	pop    %ebp
801011fd:	c3                   	ret    
801011fe:	66 90                	xchg   %ax,%ax
  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101200:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80101203:	83 fb 7f             	cmp    $0x7f,%ebx
80101206:	77 7b                	ja     80101283 <bmap+0xa7>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101208:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
8010120e:	85 c0                	test   %eax,%eax
80101210:	74 62                	je     80101274 <bmap+0x98>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
80101212:	83 ec 08             	sub    $0x8,%esp
80101215:	50                   	push   %eax
80101216:	ff 36                	pushl  (%esi)
80101218:	e8 97 ee ff ff       	call   801000b4 <bread>
8010121d:	89 c7                	mov    %eax,%edi
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
8010121f:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
80101223:	8b 1a                	mov    (%edx),%ebx
80101225:	83 c4 10             	add    $0x10,%esp
80101228:	85 db                	test   %ebx,%ebx
8010122a:	75 1d                	jne    80101249 <bmap+0x6d>
8010122c:	89 55 e4             	mov    %edx,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
8010122f:	8b 06                	mov    (%esi),%eax
80101231:	e8 ee fd ff ff       	call   80101024 <balloc>
80101236:	89 c3                	mov    %eax,%ebx
80101238:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010123b:	89 02                	mov    %eax,(%edx)
      log_write(bp);
8010123d:	83 ec 0c             	sub    $0xc,%esp
80101240:	57                   	push   %edi
80101241:	e8 da 16 00 00       	call   80102920 <log_write>
80101246:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
80101249:	83 ec 0c             	sub    $0xc,%esp
8010124c:	57                   	push   %edi
8010124d:	e8 66 ef ff ff       	call   801001b8 <brelse>
80101252:	83 c4 10             	add    $0x10,%esp
80101255:	89 d8                	mov    %ebx,%eax
    return addr;
  }

  panic("bmap: out of range");
}
80101257:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010125a:	5b                   	pop    %ebx
8010125b:	5e                   	pop    %esi
8010125c:	5f                   	pop    %edi
8010125d:	5d                   	pop    %ebp
8010125e:	c3                   	ret    
8010125f:	90                   	nop
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
80101260:	8b 06                	mov    (%esi),%eax
80101262:	e8 bd fd ff ff       	call   80101024 <balloc>
80101267:	89 43 5c             	mov    %eax,0x5c(%ebx)
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010126a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010126d:	5b                   	pop    %ebx
8010126e:	5e                   	pop    %esi
8010126f:	5f                   	pop    %edi
80101270:	5d                   	pop    %ebp
80101271:	c3                   	ret    
80101272:	66 90                	xchg   %ax,%ax
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101274:	8b 06                	mov    (%esi),%eax
80101276:	e8 a9 fd ff ff       	call   80101024 <balloc>
8010127b:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80101281:	eb 8f                	jmp    80101212 <bmap+0x36>
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
80101283:	83 ec 0c             	sub    $0xc,%esp
80101286:	68 58 66 10 80       	push   $0x80106658
8010128b:	e8 a8 f0 ff ff       	call   80100338 <panic>

80101290 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101290:	55                   	push   %ebp
80101291:	89 e5                	mov    %esp,%ebp
80101293:	56                   	push   %esi
80101294:	53                   	push   %ebx
80101295:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct buf *bp;

  bp = bread(dev, 1);
80101298:	83 ec 08             	sub    $0x8,%esp
8010129b:	6a 01                	push   $0x1
8010129d:	ff 75 08             	pushl  0x8(%ebp)
801012a0:	e8 0f ee ff ff       	call   801000b4 <bread>
801012a5:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801012a7:	83 c4 0c             	add    $0xc,%esp
801012aa:	6a 1c                	push   $0x1c
801012ac:	8d 40 5c             	lea    0x5c(%eax),%eax
801012af:	50                   	push   %eax
801012b0:	56                   	push   %esi
801012b1:	e8 2a 2c 00 00       	call   80103ee0 <memmove>
  brelse(bp);
801012b6:	83 c4 10             	add    $0x10,%esp
801012b9:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801012bc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801012bf:	5b                   	pop    %ebx
801012c0:	5e                   	pop    %esi
801012c1:	5d                   	pop    %ebp
{
  struct buf *bp;

  bp = bread(dev, 1);
  memmove(sb, bp->data, sizeof(*sb));
  brelse(bp);
801012c2:	e9 f1 ee ff ff       	jmp    801001b8 <brelse>
801012c7:	90                   	nop

801012c8 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
801012c8:	55                   	push   %ebp
801012c9:	89 e5                	mov    %esp,%ebp
801012cb:	53                   	push   %ebx
801012cc:	83 ec 0c             	sub    $0xc,%esp
  int i = 0;
  
  initlock(&icache.lock, "icache");
801012cf:	68 6b 66 10 80       	push   $0x8010666b
801012d4:	68 e0 f9 10 80       	push   $0x8010f9e0
801012d9:	e8 52 29 00 00       	call   80103c30 <initlock>
801012de:	bb 20 fa 10 80       	mov    $0x8010fa20,%ebx
801012e3:	83 c4 10             	add    $0x10,%esp
801012e6:	66 90                	xchg   %ax,%ax
  for(i = 0; i < NINODE; i++) {
    initsleeplock(&icache.inode[i].lock, "inode");
801012e8:	83 ec 08             	sub    $0x8,%esp
801012eb:	68 72 66 10 80       	push   $0x80106672
801012f0:	53                   	push   %ebx
801012f1:	e8 2e 28 00 00       	call   80103b24 <initsleeplock>
801012f6:	81 c3 90 00 00 00    	add    $0x90,%ebx
iinit(int dev)
{
  int i = 0;
  
  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
801012fc:	83 c4 10             	add    $0x10,%esp
801012ff:	81 fb 40 16 11 80    	cmp    $0x80111640,%ebx
80101305:	75 e1                	jne    801012e8 <iinit+0x20>
    initsleeplock(&icache.inode[i].lock, "inode");
  }

  readsb(dev, &sb);
80101307:	83 ec 08             	sub    $0x8,%esp
8010130a:	68 c0 f9 10 80       	push   $0x8010f9c0
8010130f:	ff 75 08             	pushl  0x8(%ebp)
80101312:	e8 79 ff ff ff       	call   80101290 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101317:	ff 35 d8 f9 10 80    	pushl  0x8010f9d8
8010131d:	ff 35 d4 f9 10 80    	pushl  0x8010f9d4
80101323:	ff 35 d0 f9 10 80    	pushl  0x8010f9d0
80101329:	ff 35 cc f9 10 80    	pushl  0x8010f9cc
8010132f:	ff 35 c8 f9 10 80    	pushl  0x8010f9c8
80101335:	ff 35 c4 f9 10 80    	pushl  0x8010f9c4
8010133b:	ff 35 c0 f9 10 80    	pushl  0x8010f9c0
80101341:	68 d8 66 10 80       	push   $0x801066d8
80101346:	e8 ad f2 ff ff       	call   801005f8 <cprintf>
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
8010134b:	83 c4 30             	add    $0x30,%esp
8010134e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101351:	c9                   	leave  
80101352:	c3                   	ret    
80101353:	90                   	nop

80101354 <ialloc>:
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
80101354:	55                   	push   %ebp
80101355:	89 e5                	mov    %esp,%ebp
80101357:	57                   	push   %edi
80101358:	56                   	push   %esi
80101359:	53                   	push   %ebx
8010135a:	83 ec 1c             	sub    $0x1c,%esp
8010135d:	8b 75 08             	mov    0x8(%ebp),%esi
80101360:	8b 45 0c             	mov    0xc(%ebp),%eax
80101363:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101366:	83 3d c8 f9 10 80 01 	cmpl   $0x1,0x8010f9c8
8010136d:	0f 86 84 00 00 00    	jbe    801013f7 <ialloc+0xa3>
80101373:	bb 01 00 00 00       	mov    $0x1,%ebx
80101378:	eb 17                	jmp    80101391 <ialloc+0x3d>
8010137a:	66 90                	xchg   %ax,%ax
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
8010137c:	83 ec 0c             	sub    $0xc,%esp
8010137f:	57                   	push   %edi
80101380:	e8 33 ee ff ff       	call   801001b8 <brelse>
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101385:	43                   	inc    %ebx
80101386:	83 c4 10             	add    $0x10,%esp
80101389:	39 1d c8 f9 10 80    	cmp    %ebx,0x8010f9c8
8010138f:	76 66                	jbe    801013f7 <ialloc+0xa3>
    bp = bread(dev, IBLOCK(inum, sb));
80101391:	83 ec 08             	sub    $0x8,%esp
80101394:	89 d8                	mov    %ebx,%eax
80101396:	c1 e8 03             	shr    $0x3,%eax
80101399:	03 05 d4 f9 10 80    	add    0x8010f9d4,%eax
8010139f:	50                   	push   %eax
801013a0:	56                   	push   %esi
801013a1:	e8 0e ed ff ff       	call   801000b4 <bread>
801013a6:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
801013a8:	89 d8                	mov    %ebx,%eax
801013aa:	83 e0 07             	and    $0x7,%eax
801013ad:	c1 e0 06             	shl    $0x6,%eax
801013b0:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801013b4:	83 c4 10             	add    $0x10,%esp
801013b7:	66 83 39 00          	cmpw   $0x0,(%ecx)
801013bb:	75 bf                	jne    8010137c <ialloc+0x28>
      memset(dip, 0, sizeof(*dip));
801013bd:	50                   	push   %eax
801013be:	6a 40                	push   $0x40
801013c0:	6a 00                	push   $0x0
801013c2:	51                   	push   %ecx
801013c3:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801013c6:	e8 81 2a 00 00       	call   80103e4c <memset>
      dip->type = type;
801013cb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801013ce:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801013d1:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801013d4:	89 3c 24             	mov    %edi,(%esp)
801013d7:	e8 44 15 00 00       	call   80102920 <log_write>
      brelse(bp);
801013dc:	89 3c 24             	mov    %edi,(%esp)
801013df:	e8 d4 ed ff ff       	call   801001b8 <brelse>
      return iget(dev, inum);
801013e4:	83 c4 10             	add    $0x10,%esp
801013e7:	89 da                	mov    %ebx,%edx
801013e9:	89 f0                	mov    %esi,%eax
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
801013eb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013ee:	5b                   	pop    %ebx
801013ef:	5e                   	pop    %esi
801013f0:	5f                   	pop    %edi
801013f1:	5d                   	pop    %ebp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
801013f2:	e9 29 fd ff ff       	jmp    80101120 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
801013f7:	83 ec 0c             	sub    $0xc,%esp
801013fa:	68 78 66 10 80       	push   $0x80106678
801013ff:	e8 34 ef ff ff       	call   80100338 <panic>

80101404 <iupdate>:
// Must be called after every change to an ip->xxx field
// that lives on disk, since i-node cache is write-through.
// Caller must hold ip->lock.
void
iupdate(struct inode *ip)
{
80101404:	55                   	push   %ebp
80101405:	89 e5                	mov    %esp,%ebp
80101407:	56                   	push   %esi
80101408:	53                   	push   %ebx
80101409:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010140c:	83 ec 08             	sub    $0x8,%esp
8010140f:	8b 43 04             	mov    0x4(%ebx),%eax
80101412:	c1 e8 03             	shr    $0x3,%eax
80101415:	03 05 d4 f9 10 80    	add    0x8010f9d4,%eax
8010141b:	50                   	push   %eax
8010141c:	ff 33                	pushl  (%ebx)
8010141e:	e8 91 ec ff ff       	call   801000b4 <bread>
80101423:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101425:	8b 43 04             	mov    0x4(%ebx),%eax
80101428:	83 e0 07             	and    $0x7,%eax
8010142b:	c1 e0 06             	shl    $0x6,%eax
8010142e:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101432:	8b 53 50             	mov    0x50(%ebx),%edx
80101435:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
80101438:	66 8b 53 52          	mov    0x52(%ebx),%dx
8010143c:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
80101440:	8b 53 54             	mov    0x54(%ebx),%edx
80101443:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
80101447:	66 8b 53 56          	mov    0x56(%ebx),%dx
8010144b:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
8010144f:	8b 53 58             	mov    0x58(%ebx),%edx
80101452:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101455:	83 c4 0c             	add    $0xc,%esp
80101458:	6a 34                	push   $0x34
8010145a:	83 c3 5c             	add    $0x5c,%ebx
8010145d:	53                   	push   %ebx
8010145e:	83 c0 0c             	add    $0xc,%eax
80101461:	50                   	push   %eax
80101462:	e8 79 2a 00 00       	call   80103ee0 <memmove>
  log_write(bp);
80101467:	89 34 24             	mov    %esi,(%esp)
8010146a:	e8 b1 14 00 00       	call   80102920 <log_write>
  brelse(bp);
8010146f:	83 c4 10             	add    $0x10,%esp
80101472:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101475:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101478:	5b                   	pop    %ebx
80101479:	5e                   	pop    %esi
8010147a:	5d                   	pop    %ebp
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  log_write(bp);
  brelse(bp);
8010147b:	e9 38 ed ff ff       	jmp    801001b8 <brelse>

80101480 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80101480:	55                   	push   %ebp
80101481:	89 e5                	mov    %esp,%ebp
80101483:	53                   	push   %ebx
80101484:	83 ec 10             	sub    $0x10,%esp
80101487:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010148a:	68 e0 f9 10 80       	push   $0x8010f9e0
8010148f:	e8 d8 28 00 00       	call   80103d6c <acquire>
  ip->ref++;
80101494:	ff 43 08             	incl   0x8(%ebx)
  release(&icache.lock);
80101497:	c7 04 24 e0 f9 10 80 	movl   $0x8010f9e0,(%esp)
8010149e:	e8 61 29 00 00       	call   80103e04 <release>
  return ip;
}
801014a3:	89 d8                	mov    %ebx,%eax
801014a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801014a8:	c9                   	leave  
801014a9:	c3                   	ret    
801014aa:	66 90                	xchg   %ax,%ax

801014ac <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
801014ac:	55                   	push   %ebp
801014ad:	89 e5                	mov    %esp,%ebp
801014af:	56                   	push   %esi
801014b0:	53                   	push   %ebx
801014b1:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
801014b4:	85 db                	test   %ebx,%ebx
801014b6:	0f 84 a9 00 00 00    	je     80101565 <ilock+0xb9>
801014bc:	8b 53 08             	mov    0x8(%ebx),%edx
801014bf:	85 d2                	test   %edx,%edx
801014c1:	0f 8e 9e 00 00 00    	jle    80101565 <ilock+0xb9>
    panic("ilock");

  acquiresleep(&ip->lock);
801014c7:	83 ec 0c             	sub    $0xc,%esp
801014ca:	8d 43 0c             	lea    0xc(%ebx),%eax
801014cd:	50                   	push   %eax
801014ce:	e8 85 26 00 00       	call   80103b58 <acquiresleep>

  if(ip->valid == 0){
801014d3:	83 c4 10             	add    $0x10,%esp
801014d6:	8b 43 4c             	mov    0x4c(%ebx),%eax
801014d9:	85 c0                	test   %eax,%eax
801014db:	74 07                	je     801014e4 <ilock+0x38>
    brelse(bp);
    ip->valid = 1;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
801014dd:	8d 65 f8             	lea    -0x8(%ebp),%esp
801014e0:	5b                   	pop    %ebx
801014e1:	5e                   	pop    %esi
801014e2:	5d                   	pop    %ebp
801014e3:	c3                   	ret    
    panic("ilock");

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801014e4:	83 ec 08             	sub    $0x8,%esp
801014e7:	8b 43 04             	mov    0x4(%ebx),%eax
801014ea:	c1 e8 03             	shr    $0x3,%eax
801014ed:	03 05 d4 f9 10 80    	add    0x8010f9d4,%eax
801014f3:	50                   	push   %eax
801014f4:	ff 33                	pushl  (%ebx)
801014f6:	e8 b9 eb ff ff       	call   801000b4 <bread>
801014fb:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801014fd:	8b 43 04             	mov    0x4(%ebx),%eax
80101500:	83 e0 07             	and    $0x7,%eax
80101503:	c1 e0 06             	shl    $0x6,%eax
80101506:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
8010150a:	8b 10                	mov    (%eax),%edx
8010150c:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101510:	66 8b 50 02          	mov    0x2(%eax),%dx
80101514:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
80101518:	8b 50 04             	mov    0x4(%eax),%edx
8010151b:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
8010151f:	66 8b 50 06          	mov    0x6(%eax),%dx
80101523:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
80101527:	8b 50 08             	mov    0x8(%eax),%edx
8010152a:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010152d:	83 c4 0c             	add    $0xc,%esp
80101530:	6a 34                	push   $0x34
80101532:	83 c0 0c             	add    $0xc,%eax
80101535:	50                   	push   %eax
80101536:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101539:	50                   	push   %eax
8010153a:	e8 a1 29 00 00       	call   80103ee0 <memmove>
    brelse(bp);
8010153f:	89 34 24             	mov    %esi,(%esp)
80101542:	e8 71 ec ff ff       	call   801001b8 <brelse>
    ip->valid = 1;
80101547:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
8010154e:	83 c4 10             	add    $0x10,%esp
80101551:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
80101556:	75 85                	jne    801014dd <ilock+0x31>
      panic("ilock: no type");
80101558:	83 ec 0c             	sub    $0xc,%esp
8010155b:	68 90 66 10 80       	push   $0x80106690
80101560:	e8 d3 ed ff ff       	call   80100338 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
80101565:	83 ec 0c             	sub    $0xc,%esp
80101568:	68 8a 66 10 80       	push   $0x8010668a
8010156d:	e8 c6 ed ff ff       	call   80100338 <panic>
80101572:	66 90                	xchg   %ax,%ax

80101574 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101574:	55                   	push   %ebp
80101575:	89 e5                	mov    %esp,%ebp
80101577:	56                   	push   %esi
80101578:	53                   	push   %ebx
80101579:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
8010157c:	85 db                	test   %ebx,%ebx
8010157e:	74 28                	je     801015a8 <iunlock+0x34>
80101580:	8d 73 0c             	lea    0xc(%ebx),%esi
80101583:	83 ec 0c             	sub    $0xc,%esp
80101586:	56                   	push   %esi
80101587:	e8 5c 26 00 00       	call   80103be8 <holdingsleep>
8010158c:	83 c4 10             	add    $0x10,%esp
8010158f:	85 c0                	test   %eax,%eax
80101591:	74 15                	je     801015a8 <iunlock+0x34>
80101593:	8b 43 08             	mov    0x8(%ebx),%eax
80101596:	85 c0                	test   %eax,%eax
80101598:	7e 0e                	jle    801015a8 <iunlock+0x34>
    panic("iunlock");

  releasesleep(&ip->lock);
8010159a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010159d:	8d 65 f8             	lea    -0x8(%ebp),%esp
801015a0:	5b                   	pop    %ebx
801015a1:	5e                   	pop    %esi
801015a2:	5d                   	pop    %ebp
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");

  releasesleep(&ip->lock);
801015a3:	e9 04 26 00 00       	jmp    80103bac <releasesleep>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");
801015a8:	83 ec 0c             	sub    $0xc,%esp
801015ab:	68 9f 66 10 80       	push   $0x8010669f
801015b0:	e8 83 ed ff ff       	call   80100338 <panic>
801015b5:	8d 76 00             	lea    0x0(%esi),%esi

801015b8 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
801015b8:	55                   	push   %ebp
801015b9:	89 e5                	mov    %esp,%ebp
801015bb:	57                   	push   %edi
801015bc:	56                   	push   %esi
801015bd:	53                   	push   %ebx
801015be:	83 ec 28             	sub    $0x28,%esp
801015c1:	8b 7d 08             	mov    0x8(%ebp),%edi
  acquiresleep(&ip->lock);
801015c4:	8d 77 0c             	lea    0xc(%edi),%esi
801015c7:	56                   	push   %esi
801015c8:	e8 8b 25 00 00       	call   80103b58 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801015cd:	83 c4 10             	add    $0x10,%esp
801015d0:	8b 47 4c             	mov    0x4c(%edi),%eax
801015d3:	85 c0                	test   %eax,%eax
801015d5:	74 07                	je     801015de <iput+0x26>
801015d7:	66 83 7f 56 00       	cmpw   $0x0,0x56(%edi)
801015dc:	74 2e                	je     8010160c <iput+0x54>
      ip->type = 0;
      iupdate(ip);
      ip->valid = 0;
    }
  }
  releasesleep(&ip->lock);
801015de:	83 ec 0c             	sub    $0xc,%esp
801015e1:	56                   	push   %esi
801015e2:	e8 c5 25 00 00       	call   80103bac <releasesleep>

  acquire(&icache.lock);
801015e7:	c7 04 24 e0 f9 10 80 	movl   $0x8010f9e0,(%esp)
801015ee:	e8 79 27 00 00       	call   80103d6c <acquire>
  ip->ref--;
801015f3:	ff 4f 08             	decl   0x8(%edi)
  release(&icache.lock);
801015f6:	83 c4 10             	add    $0x10,%esp
801015f9:	c7 45 08 e0 f9 10 80 	movl   $0x8010f9e0,0x8(%ebp)
}
80101600:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101603:	5b                   	pop    %ebx
80101604:	5e                   	pop    %esi
80101605:	5f                   	pop    %edi
80101606:	5d                   	pop    %ebp
  }
  releasesleep(&ip->lock);

  acquire(&icache.lock);
  ip->ref--;
  release(&icache.lock);
80101607:	e9 f8 27 00 00       	jmp    80103e04 <release>
void
iput(struct inode *ip)
{
  acquiresleep(&ip->lock);
  if(ip->valid && ip->nlink == 0){
    acquire(&icache.lock);
8010160c:	83 ec 0c             	sub    $0xc,%esp
8010160f:	68 e0 f9 10 80       	push   $0x8010f9e0
80101614:	e8 53 27 00 00       	call   80103d6c <acquire>
    int r = ip->ref;
80101619:	8b 5f 08             	mov    0x8(%edi),%ebx
    release(&icache.lock);
8010161c:	c7 04 24 e0 f9 10 80 	movl   $0x8010f9e0,(%esp)
80101623:	e8 dc 27 00 00       	call   80103e04 <release>
    if(r == 1){
80101628:	83 c4 10             	add    $0x10,%esp
8010162b:	4b                   	dec    %ebx
8010162c:	75 b0                	jne    801015de <iput+0x26>
8010162e:	8d 5f 5c             	lea    0x5c(%edi),%ebx
80101631:	8d 8f 8c 00 00 00    	lea    0x8c(%edi),%ecx
80101637:	89 75 e4             	mov    %esi,-0x1c(%ebp)
8010163a:	89 ce                	mov    %ecx,%esi
8010163c:	eb 09                	jmp    80101647 <iput+0x8f>
8010163e:	66 90                	xchg   %ax,%ax
80101640:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101643:	39 f3                	cmp    %esi,%ebx
80101645:	74 15                	je     8010165c <iput+0xa4>
    if(ip->addrs[i]){
80101647:	8b 13                	mov    (%ebx),%edx
80101649:	85 d2                	test   %edx,%edx
8010164b:	74 f3                	je     80101640 <iput+0x88>
      bfree(ip->dev, ip->addrs[i]);
8010164d:	8b 07                	mov    (%edi),%eax
8010164f:	e8 60 f9 ff ff       	call   80100fb4 <bfree>
      ip->addrs[i] = 0;
80101654:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
8010165a:	eb e4                	jmp    80101640 <iput+0x88>
8010165c:	8b 75 e4             	mov    -0x1c(%ebp),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
8010165f:	8b 87 8c 00 00 00    	mov    0x8c(%edi),%eax
80101665:	85 c0                	test   %eax,%eax
80101667:	75 2f                	jne    80101698 <iput+0xe0>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
80101669:	c7 47 58 00 00 00 00 	movl   $0x0,0x58(%edi)
  iupdate(ip);
80101670:	83 ec 0c             	sub    $0xc,%esp
80101673:	57                   	push   %edi
80101674:	e8 8b fd ff ff       	call   80101404 <iupdate>
    int r = ip->ref;
    release(&icache.lock);
    if(r == 1){
      // inode has no links and no other references: truncate and free.
      itrunc(ip);
      ip->type = 0;
80101679:	66 c7 47 50 00 00    	movw   $0x0,0x50(%edi)
      iupdate(ip);
8010167f:	89 3c 24             	mov    %edi,(%esp)
80101682:	e8 7d fd ff ff       	call   80101404 <iupdate>
      ip->valid = 0;
80101687:	c7 47 4c 00 00 00 00 	movl   $0x0,0x4c(%edi)
8010168e:	83 c4 10             	add    $0x10,%esp
80101691:	e9 48 ff ff ff       	jmp    801015de <iput+0x26>
80101696:	66 90                	xchg   %ax,%ax
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101698:	83 ec 08             	sub    $0x8,%esp
8010169b:	50                   	push   %eax
8010169c:	ff 37                	pushl  (%edi)
8010169e:	e8 11 ea ff ff       	call   801000b4 <bread>
801016a3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
801016a6:	8d 58 5c             	lea    0x5c(%eax),%ebx
801016a9:	05 5c 02 00 00       	add    $0x25c,%eax
801016ae:	83 c4 10             	add    $0x10,%esp
801016b1:	89 75 e0             	mov    %esi,-0x20(%ebp)
801016b4:	89 de                	mov    %ebx,%esi
801016b6:	89 c3                	mov    %eax,%ebx
801016b8:	eb 09                	jmp    801016c3 <iput+0x10b>
801016ba:	66 90                	xchg   %ax,%ax
801016bc:	83 c6 04             	add    $0x4,%esi
    for(j = 0; j < NINDIRECT; j++){
801016bf:	39 de                	cmp    %ebx,%esi
801016c1:	74 0f                	je     801016d2 <iput+0x11a>
      if(a[j])
801016c3:	8b 16                	mov    (%esi),%edx
801016c5:	85 d2                	test   %edx,%edx
801016c7:	74 f3                	je     801016bc <iput+0x104>
        bfree(ip->dev, a[j]);
801016c9:	8b 07                	mov    (%edi),%eax
801016cb:	e8 e4 f8 ff ff       	call   80100fb4 <bfree>
801016d0:	eb ea                	jmp    801016bc <iput+0x104>
801016d2:	8b 75 e0             	mov    -0x20(%ebp),%esi
    }
    brelse(bp);
801016d5:	83 ec 0c             	sub    $0xc,%esp
801016d8:	ff 75 e4             	pushl  -0x1c(%ebp)
801016db:	e8 d8 ea ff ff       	call   801001b8 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801016e0:	8b 97 8c 00 00 00    	mov    0x8c(%edi),%edx
801016e6:	8b 07                	mov    (%edi),%eax
801016e8:	e8 c7 f8 ff ff       	call   80100fb4 <bfree>
    ip->addrs[NDIRECT] = 0;
801016ed:	c7 87 8c 00 00 00 00 	movl   $0x0,0x8c(%edi)
801016f4:	00 00 00 
801016f7:	83 c4 10             	add    $0x10,%esp
801016fa:	e9 6a ff ff ff       	jmp    80101669 <iput+0xb1>
801016ff:	90                   	nop

80101700 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101700:	55                   	push   %ebp
80101701:	89 e5                	mov    %esp,%ebp
80101703:	53                   	push   %ebx
80101704:	83 ec 10             	sub    $0x10,%esp
80101707:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
8010170a:	53                   	push   %ebx
8010170b:	e8 64 fe ff ff       	call   80101574 <iunlock>
  iput(ip);
80101710:	83 c4 10             	add    $0x10,%esp
80101713:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101716:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101719:	c9                   	leave  
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
8010171a:	e9 99 fe ff ff       	jmp    801015b8 <iput>
8010171f:	90                   	nop

80101720 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101720:	55                   	push   %ebp
80101721:	89 e5                	mov    %esp,%ebp
80101723:	8b 55 08             	mov    0x8(%ebp),%edx
80101726:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101729:	8b 0a                	mov    (%edx),%ecx
8010172b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010172e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101731:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101734:	8b 4a 50             	mov    0x50(%edx),%ecx
80101737:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010173a:	66 8b 4a 56          	mov    0x56(%edx),%cx
8010173e:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101742:	8b 52 58             	mov    0x58(%edx),%edx
80101745:	89 50 10             	mov    %edx,0x10(%eax)
}
80101748:	5d                   	pop    %ebp
80101749:	c3                   	ret    
8010174a:	66 90                	xchg   %ax,%ax

8010174c <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
8010174c:	55                   	push   %ebp
8010174d:	89 e5                	mov    %esp,%ebp
8010174f:	57                   	push   %edi
80101750:	56                   	push   %esi
80101751:	53                   	push   %ebx
80101752:	83 ec 1c             	sub    $0x1c,%esp
80101755:	8b 45 08             	mov    0x8(%ebp),%eax
80101758:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010175b:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010175e:	8b 75 10             	mov    0x10(%ebp),%esi
80101761:	8b 4d 14             	mov    0x14(%ebp),%ecx
80101764:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101767:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
8010176c:	0f 84 b2 00 00 00    	je     80101824 <readi+0xd8>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101772:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101775:	8b 40 58             	mov    0x58(%eax),%eax
80101778:	39 f0                	cmp    %esi,%eax
8010177a:	0f 82 c8 00 00 00    	jb     80101848 <readi+0xfc>
80101780:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101783:	01 f2                	add    %esi,%edx
80101785:	0f 82 bd 00 00 00    	jb     80101848 <readi+0xfc>
    return -1;
  if(off + n > ip->size)
8010178b:	39 d0                	cmp    %edx,%eax
8010178d:	0f 82 85 00 00 00    	jb     80101818 <readi+0xcc>
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101793:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010179a:	8b 5d e0             	mov    -0x20(%ebp),%ebx
8010179d:	85 db                	test   %ebx,%ebx
8010179f:	74 69                	je     8010180a <readi+0xbe>
801017a1:	8d 76 00             	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801017a4:	89 f2                	mov    %esi,%edx
801017a6:	c1 ea 09             	shr    $0x9,%edx
801017a9:	8b 5d d8             	mov    -0x28(%ebp),%ebx
801017ac:	89 d8                	mov    %ebx,%eax
801017ae:	e8 29 fa ff ff       	call   801011dc <bmap>
801017b3:	83 ec 08             	sub    $0x8,%esp
801017b6:	50                   	push   %eax
801017b7:	ff 33                	pushl  (%ebx)
801017b9:	e8 f6 e8 ff ff       	call   801000b4 <bread>
801017be:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
801017c0:	89 f0                	mov    %esi,%eax
801017c2:	25 ff 01 00 00       	and    $0x1ff,%eax
801017c7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801017ca:	2b 4d e4             	sub    -0x1c(%ebp),%ecx
801017cd:	bb 00 02 00 00       	mov    $0x200,%ebx
801017d2:	29 c3                	sub    %eax,%ebx
801017d4:	83 c4 10             	add    $0x10,%esp
801017d7:	39 cb                	cmp    %ecx,%ebx
801017d9:	76 02                	jbe    801017dd <readi+0x91>
801017db:	89 cb                	mov    %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
801017dd:	51                   	push   %ecx
801017de:	53                   	push   %ebx
801017df:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
801017e3:	89 55 dc             	mov    %edx,-0x24(%ebp)
801017e6:	50                   	push   %eax
801017e7:	57                   	push   %edi
801017e8:	e8 f3 26 00 00       	call   80103ee0 <memmove>
    brelse(bp);
801017ed:	8b 55 dc             	mov    -0x24(%ebp),%edx
801017f0:	89 14 24             	mov    %edx,(%esp)
801017f3:	e8 c0 e9 ff ff       	call   801001b8 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801017f8:	01 5d e4             	add    %ebx,-0x1c(%ebp)
801017fb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801017fe:	01 de                	add    %ebx,%esi
80101800:	01 df                	add    %ebx,%edi
80101802:	83 c4 10             	add    $0x10,%esp
80101805:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101808:	77 9a                	ja     801017a4 <readi+0x58>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
8010180a:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
8010180d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101810:	5b                   	pop    %ebx
80101811:	5e                   	pop    %esi
80101812:	5f                   	pop    %edi
80101813:	5d                   	pop    %ebp
80101814:	c3                   	ret    
80101815:	8d 76 00             	lea    0x0(%esi),%esi
  }

  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101818:	29 f0                	sub    %esi,%eax
8010181a:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010181d:	e9 71 ff ff ff       	jmp    80101793 <readi+0x47>
80101822:	66 90                	xchg   %ax,%ax
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101824:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101828:	66 83 f8 09          	cmp    $0x9,%ax
8010182c:	77 1a                	ja     80101848 <readi+0xfc>
8010182e:	8b 04 c5 60 f9 10 80 	mov    -0x7fef06a0(,%eax,8),%eax
80101835:	85 c0                	test   %eax,%eax
80101837:	74 0f                	je     80101848 <readi+0xfc>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101839:	89 4d 10             	mov    %ecx,0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
8010183c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010183f:	5b                   	pop    %ebx
80101840:	5e                   	pop    %esi
80101841:	5f                   	pop    %edi
80101842:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101843:	ff e0                	jmp    *%eax
80101845:	8d 76 00             	lea    0x0(%esi),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
80101848:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010184d:	eb be                	jmp    8010180d <readi+0xc1>
8010184f:	90                   	nop

80101850 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101850:	55                   	push   %ebp
80101851:	89 e5                	mov    %esp,%ebp
80101853:	57                   	push   %edi
80101854:	56                   	push   %esi
80101855:	53                   	push   %ebx
80101856:	83 ec 1c             	sub    $0x1c,%esp
80101859:	8b 45 08             	mov    0x8(%ebp),%eax
8010185c:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010185f:	8b 75 0c             	mov    0xc(%ebp),%esi
80101862:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101865:	8b 75 10             	mov    0x10(%ebp),%esi
80101868:	8b 55 14             	mov    0x14(%ebp),%edx
8010186b:	89 55 e0             	mov    %edx,-0x20(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
8010186e:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
80101873:	0f 84 af 00 00 00    	je     80101928 <writei+0xd8>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101879:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010187c:	39 70 58             	cmp    %esi,0x58(%eax)
8010187f:	0f 82 db 00 00 00    	jb     80101960 <writei+0x110>
80101885:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101888:	89 d0                	mov    %edx,%eax
8010188a:	01 f0                	add    %esi,%eax
8010188c:	0f 82 ce 00 00 00    	jb     80101960 <writei+0x110>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101892:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101897:	0f 87 c3 00 00 00    	ja     80101960 <writei+0x110>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
8010189d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801018a4:	85 d2                	test   %edx,%edx
801018a6:	74 73                	je     8010191b <writei+0xcb>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801018a8:	89 f2                	mov    %esi,%edx
801018aa:	c1 ea 09             	shr    $0x9,%edx
801018ad:	8b 7d d8             	mov    -0x28(%ebp),%edi
801018b0:	89 f8                	mov    %edi,%eax
801018b2:	e8 25 f9 ff ff       	call   801011dc <bmap>
801018b7:	83 ec 08             	sub    $0x8,%esp
801018ba:	50                   	push   %eax
801018bb:	ff 37                	pushl  (%edi)
801018bd:	e8 f2 e7 ff ff       	call   801000b4 <bread>
801018c2:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
801018c4:	89 f0                	mov    %esi,%eax
801018c6:	25 ff 01 00 00       	and    $0x1ff,%eax
801018cb:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801018ce:	2b 4d e4             	sub    -0x1c(%ebp),%ecx
801018d1:	bb 00 02 00 00       	mov    $0x200,%ebx
801018d6:	29 c3                	sub    %eax,%ebx
801018d8:	83 c4 10             	add    $0x10,%esp
801018db:	39 cb                	cmp    %ecx,%ebx
801018dd:	76 02                	jbe    801018e1 <writei+0x91>
801018df:	89 cb                	mov    %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
801018e1:	52                   	push   %edx
801018e2:	53                   	push   %ebx
801018e3:	ff 75 dc             	pushl  -0x24(%ebp)
801018e6:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
801018ea:	50                   	push   %eax
801018eb:	e8 f0 25 00 00       	call   80103ee0 <memmove>
    log_write(bp);
801018f0:	89 3c 24             	mov    %edi,(%esp)
801018f3:	e8 28 10 00 00       	call   80102920 <log_write>
    brelse(bp);
801018f8:	89 3c 24             	mov    %edi,(%esp)
801018fb:	e8 b8 e8 ff ff       	call   801001b8 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101900:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101903:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101906:	01 de                	add    %ebx,%esi
80101908:	01 5d dc             	add    %ebx,-0x24(%ebp)
8010190b:	83 c4 10             	add    $0x10,%esp
8010190e:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101911:	77 95                	ja     801018a8 <writei+0x58>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
80101913:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101916:	3b 70 58             	cmp    0x58(%eax),%esi
80101919:	77 31                	ja     8010194c <writei+0xfc>
    ip->size = off;
    iupdate(ip);
  }
  return n;
8010191b:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
8010191e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101921:	5b                   	pop    %ebx
80101922:	5e                   	pop    %esi
80101923:	5f                   	pop    %edi
80101924:	5d                   	pop    %ebp
80101925:	c3                   	ret    
80101926:	66 90                	xchg   %ax,%ax
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101928:	0f bf 40 52          	movswl 0x52(%eax),%eax
8010192c:	66 83 f8 09          	cmp    $0x9,%ax
80101930:	77 2e                	ja     80101960 <writei+0x110>
80101932:	8b 04 c5 64 f9 10 80 	mov    -0x7fef069c(,%eax,8),%eax
80101939:	85 c0                	test   %eax,%eax
8010193b:	74 23                	je     80101960 <writei+0x110>
      return -1;
    return devsw[ip->major].write(ip, src, n);
8010193d:	89 55 10             	mov    %edx,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
80101940:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101943:	5b                   	pop    %ebx
80101944:	5e                   	pop    %esi
80101945:	5f                   	pop    %edi
80101946:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101947:	ff e0                	jmp    *%eax
80101949:	8d 76 00             	lea    0x0(%esi),%esi
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
8010194c:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010194f:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101952:	83 ec 0c             	sub    $0xc,%esp
80101955:	50                   	push   %eax
80101956:	e8 a9 fa ff ff       	call   80101404 <iupdate>
8010195b:	83 c4 10             	add    $0x10,%esp
8010195e:	eb bb                	jmp    8010191b <writei+0xcb>
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
80101960:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101965:	eb b7                	jmp    8010191e <writei+0xce>
80101967:	90                   	nop

80101968 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101968:	55                   	push   %ebp
80101969:	89 e5                	mov    %esp,%ebp
8010196b:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
8010196e:	6a 0e                	push   $0xe
80101970:	ff 75 0c             	pushl  0xc(%ebp)
80101973:	ff 75 08             	pushl  0x8(%ebp)
80101976:	e8 c5 25 00 00       	call   80103f40 <strncmp>
}
8010197b:	c9                   	leave  
8010197c:	c3                   	ret    
8010197d:	8d 76 00             	lea    0x0(%esi),%esi

80101980 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101980:	55                   	push   %ebp
80101981:	89 e5                	mov    %esp,%ebp
80101983:	57                   	push   %edi
80101984:	56                   	push   %esi
80101985:	53                   	push   %ebx
80101986:	83 ec 1c             	sub    $0x1c,%esp
80101989:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
8010198c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101991:	0f 85 80 00 00 00    	jne    80101a17 <dirlookup+0x97>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101997:	8b 4b 58             	mov    0x58(%ebx),%ecx
8010199a:	85 c9                	test   %ecx,%ecx
8010199c:	74 62                	je     80101a00 <dirlookup+0x80>
8010199e:	31 ff                	xor    %edi,%edi
801019a0:	8d 75 d8             	lea    -0x28(%ebp),%esi
801019a3:	eb 0b                	jmp    801019b0 <dirlookup+0x30>
801019a5:	8d 76 00             	lea    0x0(%esi),%esi
801019a8:	83 c7 10             	add    $0x10,%edi
801019ab:	39 7b 58             	cmp    %edi,0x58(%ebx)
801019ae:	76 50                	jbe    80101a00 <dirlookup+0x80>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801019b0:	6a 10                	push   $0x10
801019b2:	57                   	push   %edi
801019b3:	56                   	push   %esi
801019b4:	53                   	push   %ebx
801019b5:	e8 92 fd ff ff       	call   8010174c <readi>
801019ba:	83 c4 10             	add    $0x10,%esp
801019bd:	83 f8 10             	cmp    $0x10,%eax
801019c0:	75 48                	jne    80101a0a <dirlookup+0x8a>
      panic("dirlookup read");
    if(de.inum == 0)
801019c2:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801019c7:	74 df                	je     801019a8 <dirlookup+0x28>
// Directories

int
namecmp(const char *s, const char *t)
{
  return strncmp(s, t, DIRSIZ);
801019c9:	52                   	push   %edx
801019ca:	6a 0e                	push   $0xe
801019cc:	8d 45 da             	lea    -0x26(%ebp),%eax
801019cf:	50                   	push   %eax
801019d0:	ff 75 0c             	pushl  0xc(%ebp)
801019d3:	e8 68 25 00 00       	call   80103f40 <strncmp>
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
801019d8:	83 c4 10             	add    $0x10,%esp
801019db:	85 c0                	test   %eax,%eax
801019dd:	75 c9                	jne    801019a8 <dirlookup+0x28>
      // entry matches path element
      if(poff)
801019df:	8b 45 10             	mov    0x10(%ebp),%eax
801019e2:	85 c0                	test   %eax,%eax
801019e4:	74 05                	je     801019eb <dirlookup+0x6b>
        *poff = off;
801019e6:	8b 45 10             	mov    0x10(%ebp),%eax
801019e9:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
      return iget(dp->dev, inum);
801019eb:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
801019ef:	8b 03                	mov    (%ebx),%eax
801019f1:	e8 2a f7 ff ff       	call   80101120 <iget>
    }
  }

  return 0;
}
801019f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801019f9:	5b                   	pop    %ebx
801019fa:	5e                   	pop    %esi
801019fb:	5f                   	pop    %edi
801019fc:	5d                   	pop    %ebp
801019fd:	c3                   	ret    
801019fe:	66 90                	xchg   %ax,%ax
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80101a00:	31 c0                	xor    %eax,%eax
}
80101a02:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a05:	5b                   	pop    %ebx
80101a06:	5e                   	pop    %esi
80101a07:	5f                   	pop    %edi
80101a08:	5d                   	pop    %ebp
80101a09:	c3                   	ret    
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
80101a0a:	83 ec 0c             	sub    $0xc,%esp
80101a0d:	68 b9 66 10 80       	push   $0x801066b9
80101a12:	e8 21 e9 ff ff       	call   80100338 <panic>
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
80101a17:	83 ec 0c             	sub    $0xc,%esp
80101a1a:	68 a7 66 10 80       	push   $0x801066a7
80101a1f:	e8 14 e9 ff ff       	call   80100338 <panic>

80101a24 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101a24:	55                   	push   %ebp
80101a25:	89 e5                	mov    %esp,%ebp
80101a27:	57                   	push   %edi
80101a28:	56                   	push   %esi
80101a29:	53                   	push   %ebx
80101a2a:	83 ec 1c             	sub    $0x1c,%esp
80101a2d:	89 c3                	mov    %eax,%ebx
80101a2f:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101a32:	89 cf                	mov    %ecx,%edi
  struct inode *ip, *next;

  if(*path == '/')
80101a34:	80 38 2f             	cmpb   $0x2f,(%eax)
80101a37:	0f 84 2e 01 00 00    	je     80101b6b <namex+0x147>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101a3d:	e8 7e 18 00 00       	call   801032c0 <myproc>
80101a42:	8b 70 68             	mov    0x68(%eax),%esi
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101a45:	83 ec 0c             	sub    $0xc,%esp
80101a48:	68 e0 f9 10 80       	push   $0x8010f9e0
80101a4d:	e8 1a 23 00 00       	call   80103d6c <acquire>
  ip->ref++;
80101a52:	ff 46 08             	incl   0x8(%esi)
  release(&icache.lock);
80101a55:	c7 04 24 e0 f9 10 80 	movl   $0x8010f9e0,(%esp)
80101a5c:	e8 a3 23 00 00       	call   80103e04 <release>
80101a61:	83 c4 10             	add    $0x10,%esp
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80101a64:	8a 03                	mov    (%ebx),%al
80101a66:	3c 2f                	cmp    $0x2f,%al
80101a68:	75 09                	jne    80101a73 <namex+0x4f>
80101a6a:	66 90                	xchg   %ax,%ax
    path++;
80101a6c:	43                   	inc    %ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80101a6d:	8a 03                	mov    (%ebx),%al
80101a6f:	3c 2f                	cmp    $0x2f,%al
80101a71:	74 f9                	je     80101a6c <namex+0x48>
    path++;
  if(*path == 0)
80101a73:	84 c0                	test   %al,%al
80101a75:	0f 84 c1 00 00 00    	je     80101b3c <namex+0x118>
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101a7b:	89 da                	mov    %ebx,%edx
80101a7d:	31 c9                	xor    %ecx,%ecx
80101a7f:	80 3b 00             	cmpb   $0x0,(%ebx)
80101a82:	75 0c                	jne    80101a90 <namex+0x6c>
80101a84:	e9 8f 00 00 00       	jmp    80101b18 <namex+0xf4>
80101a89:	8d 76 00             	lea    0x0(%esi),%esi
80101a8c:	84 c0                	test   %al,%al
80101a8e:	74 07                	je     80101a97 <namex+0x73>
    path++;
80101a90:	42                   	inc    %edx
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101a91:	8a 02                	mov    (%edx),%al
80101a93:	3c 2f                	cmp    $0x2f,%al
80101a95:	75 f5                	jne    80101a8c <namex+0x68>
80101a97:	89 d1                	mov    %edx,%ecx
80101a99:	29 d9                	sub    %ebx,%ecx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
80101a9b:	83 f9 0d             	cmp    $0xd,%ecx
80101a9e:	7e 78                	jle    80101b18 <namex+0xf4>
80101aa0:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    memmove(name, s, DIRSIZ);
80101aa3:	51                   	push   %ecx
80101aa4:	6a 0e                	push   $0xe
80101aa6:	53                   	push   %ebx
80101aa7:	57                   	push   %edi
80101aa8:	e8 33 24 00 00       	call   80103ee0 <memmove>
80101aad:	83 c4 10             	add    $0x10,%esp
80101ab0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101ab3:	89 d3                	mov    %edx,%ebx
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101ab5:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101ab8:	75 08                	jne    80101ac2 <namex+0x9e>
80101aba:	66 90                	xchg   %ax,%ax
    path++;
80101abc:	43                   	inc    %ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101abd:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101ac0:	74 fa                	je     80101abc <namex+0x98>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101ac2:	83 ec 0c             	sub    $0xc,%esp
80101ac5:	56                   	push   %esi
80101ac6:	e8 e1 f9 ff ff       	call   801014ac <ilock>
    if(ip->type != T_DIR){
80101acb:	83 c4 10             	add    $0x10,%esp
80101ace:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101ad3:	75 78                	jne    80101b4d <namex+0x129>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101ad5:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101ad8:	85 c0                	test   %eax,%eax
80101ada:	74 09                	je     80101ae5 <namex+0xc1>
80101adc:	80 3b 00             	cmpb   $0x0,(%ebx)
80101adf:	0f 84 9c 00 00 00    	je     80101b81 <namex+0x15d>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101ae5:	50                   	push   %eax
80101ae6:	6a 00                	push   $0x0
80101ae8:	57                   	push   %edi
80101ae9:	56                   	push   %esi
80101aea:	e8 91 fe ff ff       	call   80101980 <dirlookup>
80101aef:	83 c4 10             	add    $0x10,%esp
80101af2:	85 c0                	test   %eax,%eax
80101af4:	74 57                	je     80101b4d <namex+0x129>
80101af6:	89 45 e4             	mov    %eax,-0x1c(%ebp)

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101af9:	83 ec 0c             	sub    $0xc,%esp
80101afc:	56                   	push   %esi
80101afd:	e8 72 fa ff ff       	call   80101574 <iunlock>
  iput(ip);
80101b02:	89 34 24             	mov    %esi,(%esp)
80101b05:	e8 ae fa ff ff       	call   801015b8 <iput>
80101b0a:	83 c4 10             	add    $0x10,%esp
80101b0d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101b10:	89 c6                	mov    %eax,%esi
80101b12:	e9 4d ff ff ff       	jmp    80101a64 <namex+0x40>
80101b17:	90                   	nop
80101b18:	89 55 dc             	mov    %edx,-0x24(%ebp)
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
80101b1b:	52                   	push   %edx
80101b1c:	51                   	push   %ecx
80101b1d:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101b20:	53                   	push   %ebx
80101b21:	57                   	push   %edi
80101b22:	e8 b9 23 00 00       	call   80103ee0 <memmove>
    name[len] = 0;
80101b27:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101b2a:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101b2e:	83 c4 10             	add    $0x10,%esp
80101b31:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101b34:	89 d3                	mov    %edx,%ebx
80101b36:	e9 7a ff ff ff       	jmp    80101ab5 <namex+0x91>
80101b3b:	90                   	nop
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101b3c:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101b3f:	85 c0                	test   %eax,%eax
80101b41:	75 54                	jne    80101b97 <namex+0x173>
80101b43:	89 f0                	mov    %esi,%eax
    iput(ip);
    return 0;
  }
  return ip;
}
80101b45:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b48:	5b                   	pop    %ebx
80101b49:	5e                   	pop    %esi
80101b4a:	5f                   	pop    %edi
80101b4b:	5d                   	pop    %ebp
80101b4c:	c3                   	ret    

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101b4d:	83 ec 0c             	sub    $0xc,%esp
80101b50:	56                   	push   %esi
80101b51:	e8 1e fa ff ff       	call   80101574 <iunlock>
  iput(ip);
80101b56:	89 34 24             	mov    %esi,(%esp)
80101b59:	e8 5a fa ff ff       	call   801015b8 <iput>
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101b5e:	83 c4 10             	add    $0x10,%esp
80101b61:	31 c0                	xor    %eax,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101b63:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b66:	5b                   	pop    %ebx
80101b67:	5e                   	pop    %esi
80101b68:	5f                   	pop    %edi
80101b69:	5d                   	pop    %ebp
80101b6a:	c3                   	ret    
namex(char *path, int nameiparent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
80101b6b:	ba 01 00 00 00       	mov    $0x1,%edx
80101b70:	b8 01 00 00 00       	mov    $0x1,%eax
80101b75:	e8 a6 f5 ff ff       	call   80101120 <iget>
80101b7a:	89 c6                	mov    %eax,%esi
80101b7c:	e9 e3 fe ff ff       	jmp    80101a64 <namex+0x40>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
80101b81:	83 ec 0c             	sub    $0xc,%esp
80101b84:	56                   	push   %esi
80101b85:	e8 ea f9 ff ff       	call   80101574 <iunlock>
      return ip;
80101b8a:	83 c4 10             	add    $0x10,%esp
80101b8d:	89 f0                	mov    %esi,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101b8f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b92:	5b                   	pop    %ebx
80101b93:	5e                   	pop    %esi
80101b94:	5f                   	pop    %edi
80101b95:	5d                   	pop    %ebp
80101b96:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
80101b97:	83 ec 0c             	sub    $0xc,%esp
80101b9a:	56                   	push   %esi
80101b9b:	e8 18 fa ff ff       	call   801015b8 <iput>
    return 0;
80101ba0:	83 c4 10             	add    $0x10,%esp
80101ba3:	31 c0                	xor    %eax,%eax
80101ba5:	eb 9e                	jmp    80101b45 <namex+0x121>
80101ba7:	90                   	nop

80101ba8 <dirlink>:
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80101ba8:	55                   	push   %ebp
80101ba9:	89 e5                	mov    %esp,%ebp
80101bab:	57                   	push   %edi
80101bac:	56                   	push   %esi
80101bad:	53                   	push   %ebx
80101bae:	83 ec 20             	sub    $0x20,%esp
80101bb1:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80101bb4:	6a 00                	push   $0x0
80101bb6:	ff 75 0c             	pushl  0xc(%ebp)
80101bb9:	53                   	push   %ebx
80101bba:	e8 c1 fd ff ff       	call   80101980 <dirlookup>
80101bbf:	83 c4 10             	add    $0x10,%esp
80101bc2:	85 c0                	test   %eax,%eax
80101bc4:	75 67                	jne    80101c2d <dirlink+0x85>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80101bc6:	8b 7b 58             	mov    0x58(%ebx),%edi
80101bc9:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101bcc:	85 ff                	test   %edi,%edi
80101bce:	74 2b                	je     80101bfb <dirlink+0x53>
80101bd0:	31 ff                	xor    %edi,%edi
80101bd2:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101bd5:	eb 0b                	jmp    80101be2 <dirlink+0x3a>
80101bd7:	90                   	nop
80101bd8:	8d 57 10             	lea    0x10(%edi),%edx
80101bdb:	89 d7                	mov    %edx,%edi
80101bdd:	39 53 58             	cmp    %edx,0x58(%ebx)
80101be0:	76 19                	jbe    80101bfb <dirlink+0x53>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101be2:	6a 10                	push   $0x10
80101be4:	57                   	push   %edi
80101be5:	56                   	push   %esi
80101be6:	53                   	push   %ebx
80101be7:	e8 60 fb ff ff       	call   8010174c <readi>
80101bec:	83 c4 10             	add    $0x10,%esp
80101bef:	83 f8 10             	cmp    $0x10,%eax
80101bf2:	75 4c                	jne    80101c40 <dirlink+0x98>
      panic("dirlink read");
    if(de.inum == 0)
80101bf4:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101bf9:	75 dd                	jne    80101bd8 <dirlink+0x30>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
80101bfb:	50                   	push   %eax
80101bfc:	6a 0e                	push   $0xe
80101bfe:	ff 75 0c             	pushl  0xc(%ebp)
80101c01:	8d 45 da             	lea    -0x26(%ebp),%eax
80101c04:	50                   	push   %eax
80101c05:	e8 92 23 00 00       	call   80103f9c <strncpy>
  de.inum = inum;
80101c0a:	8b 45 10             	mov    0x10(%ebp),%eax
80101c0d:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101c11:	6a 10                	push   $0x10
80101c13:	57                   	push   %edi
80101c14:	56                   	push   %esi
80101c15:	53                   	push   %ebx
80101c16:	e8 35 fc ff ff       	call   80101850 <writei>
80101c1b:	83 c4 20             	add    $0x20,%esp
80101c1e:	83 f8 10             	cmp    $0x10,%eax
80101c21:	75 2a                	jne    80101c4d <dirlink+0xa5>
    panic("dirlink");

  return 0;
80101c23:	31 c0                	xor    %eax,%eax
}
80101c25:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c28:	5b                   	pop    %ebx
80101c29:	5e                   	pop    %esi
80101c2a:	5f                   	pop    %edi
80101c2b:	5d                   	pop    %ebp
80101c2c:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
80101c2d:	83 ec 0c             	sub    $0xc,%esp
80101c30:	50                   	push   %eax
80101c31:	e8 82 f9 ff ff       	call   801015b8 <iput>
    return -1;
80101c36:	83 c4 10             	add    $0x10,%esp
80101c39:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101c3e:	eb e5                	jmp    80101c25 <dirlink+0x7d>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80101c40:	83 ec 0c             	sub    $0xc,%esp
80101c43:	68 c8 66 10 80       	push   $0x801066c8
80101c48:	e8 eb e6 ff ff       	call   80100338 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
80101c4d:	83 ec 0c             	sub    $0xc,%esp
80101c50:	68 be 6c 10 80       	push   $0x80106cbe
80101c55:	e8 de e6 ff ff       	call   80100338 <panic>
80101c5a:	66 90                	xchg   %ax,%ax

80101c5c <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
80101c5c:	55                   	push   %ebp
80101c5d:	89 e5                	mov    %esp,%ebp
80101c5f:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101c62:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101c65:	31 d2                	xor    %edx,%edx
80101c67:	8b 45 08             	mov    0x8(%ebp),%eax
80101c6a:	e8 b5 fd ff ff       	call   80101a24 <namex>
}
80101c6f:	c9                   	leave  
80101c70:	c3                   	ret    
80101c71:	8d 76 00             	lea    0x0(%esi),%esi

80101c74 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101c74:	55                   	push   %ebp
80101c75:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101c77:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101c7a:	ba 01 00 00 00       	mov    $0x1,%edx
80101c7f:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101c82:	5d                   	pop    %ebp
}

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
80101c83:	e9 9c fd ff ff       	jmp    80101a24 <namex>

80101c88 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101c88:	55                   	push   %ebp
80101c89:	89 e5                	mov    %esp,%ebp
80101c8b:	56                   	push   %esi
80101c8c:	53                   	push   %ebx
  if(b == 0)
80101c8d:	85 c0                	test   %eax,%eax
80101c8f:	0f 84 96 00 00 00    	je     80101d2b <idestart+0xa3>
80101c95:	89 c1                	mov    %eax,%ecx
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101c97:	8b 58 08             	mov    0x8(%eax),%ebx
80101c9a:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101ca0:	77 7c                	ja     80101d1e <idestart+0x96>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101ca2:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101ca7:	90                   	nop
80101ca8:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101ca9:	83 e0 c0             	and    $0xffffffc0,%eax
80101cac:	3c 40                	cmp    $0x40,%al
80101cae:	75 f8                	jne    80101ca8 <idestart+0x20>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101cb0:	31 f6                	xor    %esi,%esi
80101cb2:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101cb7:	89 f0                	mov    %esi,%eax
80101cb9:	ee                   	out    %al,(%dx)
80101cba:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101cbf:	b0 01                	mov    $0x1,%al
80101cc1:	ee                   	out    %al,(%dx)
80101cc2:	ba f3 01 00 00       	mov    $0x1f3,%edx
80101cc7:	88 d8                	mov    %bl,%al
80101cc9:	ee                   	out    %al,(%dx)
80101cca:	89 d8                	mov    %ebx,%eax
80101ccc:	c1 f8 08             	sar    $0x8,%eax
80101ccf:	ba f4 01 00 00       	mov    $0x1f4,%edx
80101cd4:	ee                   	out    %al,(%dx)
80101cd5:	ba f5 01 00 00       	mov    $0x1f5,%edx
80101cda:	89 f0                	mov    %esi,%eax
80101cdc:	ee                   	out    %al,(%dx)
80101cdd:	8a 41 04             	mov    0x4(%ecx),%al
80101ce0:	83 e0 01             	and    $0x1,%eax
80101ce3:	c1 e0 04             	shl    $0x4,%eax
80101ce6:	83 c8 e0             	or     $0xffffffe0,%eax
80101ce9:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101cee:	ee                   	out    %al,(%dx)
80101cef:	ba f7 01 00 00       	mov    $0x1f7,%edx
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
80101cf4:	f6 01 04             	testb  $0x4,(%ecx)
80101cf7:	75 0b                	jne    80101d04 <idestart+0x7c>
80101cf9:	b0 20                	mov    $0x20,%al
80101cfb:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101cfc:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101cff:	5b                   	pop    %ebx
80101d00:	5e                   	pop    %esi
80101d01:	5d                   	pop    %ebp
80101d02:	c3                   	ret    
80101d03:	90                   	nop
80101d04:	b0 30                	mov    $0x30,%al
80101d06:	ee                   	out    %al,(%dx)
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
80101d07:	8d 71 5c             	lea    0x5c(%ecx),%esi
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
80101d0a:	b9 80 00 00 00       	mov    $0x80,%ecx
80101d0f:	ba f0 01 00 00       	mov    $0x1f0,%edx
80101d14:	fc                   	cld    
80101d15:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101d17:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101d1a:	5b                   	pop    %ebx
80101d1b:	5e                   	pop    %esi
80101d1c:	5d                   	pop    %ebp
80101d1d:	c3                   	ret    
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
  if(b->blockno >= FSSIZE)
    panic("incorrect blockno");
80101d1e:	83 ec 0c             	sub    $0xc,%esp
80101d21:	68 34 67 10 80       	push   $0x80106734
80101d26:	e8 0d e6 ff ff       	call   80100338 <panic>
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
80101d2b:	83 ec 0c             	sub    $0xc,%esp
80101d2e:	68 2b 67 10 80       	push   $0x8010672b
80101d33:	e8 00 e6 ff ff       	call   80100338 <panic>

80101d38 <ideinit>:
  return 0;
}

void
ideinit(void)
{
80101d38:	55                   	push   %ebp
80101d39:	89 e5                	mov    %esp,%ebp
80101d3b:	83 ec 10             	sub    $0x10,%esp
  int i;

  initlock(&idelock, "ide");
80101d3e:	68 46 67 10 80       	push   $0x80106746
80101d43:	68 80 95 10 80       	push   $0x80109580
80101d48:	e8 e3 1e 00 00       	call   80103c30 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80101d4d:	58                   	pop    %eax
80101d4e:	5a                   	pop    %edx
80101d4f:	a1 00 1d 11 80       	mov    0x80111d00,%eax
80101d54:	48                   	dec    %eax
80101d55:	50                   	push   %eax
80101d56:	6a 0e                	push   $0xe
80101d58:	e8 63 02 00 00       	call   80101fc0 <ioapicenable>
80101d5d:	83 c4 10             	add    $0x10,%esp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101d60:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101d65:	8d 76 00             	lea    0x0(%esi),%esi
80101d68:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101d69:	83 e0 c0             	and    $0xffffffc0,%eax
80101d6c:	3c 40                	cmp    $0x40,%al
80101d6e:	75 f8                	jne    80101d68 <ideinit+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101d70:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101d75:	b0 f0                	mov    $0xf0,%al
80101d77:	ee                   	out    %al,(%dx)
80101d78:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101d7d:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101d82:	eb 03                	jmp    80101d87 <ideinit+0x4f>
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80101d84:	49                   	dec    %ecx
80101d85:	74 0f                	je     80101d96 <ideinit+0x5e>
80101d87:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80101d88:	84 c0                	test   %al,%al
80101d8a:	74 f8                	je     80101d84 <ideinit+0x4c>
      havedisk1 = 1;
80101d8c:	c7 05 60 95 10 80 01 	movl   $0x1,0x80109560
80101d93:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101d96:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101d9b:	b0 e0                	mov    $0xe0,%al
80101d9d:	ee                   	out    %al,(%dx)
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
80101d9e:	c9                   	leave  
80101d9f:	c3                   	ret    

80101da0 <ideintr>:
}

// Interrupt handler.
void
ideintr(void)
{
80101da0:	55                   	push   %ebp
80101da1:	89 e5                	mov    %esp,%ebp
80101da3:	57                   	push   %edi
80101da4:	56                   	push   %esi
80101da5:	53                   	push   %ebx
80101da6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80101da9:	68 80 95 10 80       	push   $0x80109580
80101dae:	e8 b9 1f 00 00       	call   80103d6c <acquire>

  if((b = idequeue) == 0){
80101db3:	8b 1d 64 95 10 80    	mov    0x80109564,%ebx
80101db9:	83 c4 10             	add    $0x10,%esp
80101dbc:	85 db                	test   %ebx,%ebx
80101dbe:	74 34                	je     80101df4 <ideintr+0x54>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80101dc0:	8b 43 58             	mov    0x58(%ebx),%eax
80101dc3:	a3 64 95 10 80       	mov    %eax,0x80109564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80101dc8:	8b 33                	mov    (%ebx),%esi
80101dca:	f7 c6 04 00 00 00    	test   $0x4,%esi
80101dd0:	74 3a                	je     80101e0c <ideintr+0x6c>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80101dd2:	83 e6 fb             	and    $0xfffffffb,%esi
80101dd5:	83 ce 02             	or     $0x2,%esi
80101dd8:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
80101dda:	83 ec 0c             	sub    $0xc,%esp
80101ddd:	53                   	push   %ebx
80101dde:	e8 c1 1b 00 00       	call   801039a4 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80101de3:	a1 64 95 10 80       	mov    0x80109564,%eax
80101de8:	83 c4 10             	add    $0x10,%esp
80101deb:	85 c0                	test   %eax,%eax
80101ded:	74 05                	je     80101df4 <ideintr+0x54>
    idestart(idequeue);
80101def:	e8 94 fe ff ff       	call   80101c88 <idestart>

  // First queued buffer is the active request.
  acquire(&idelock);

  if((b = idequeue) == 0){
    release(&idelock);
80101df4:	83 ec 0c             	sub    $0xc,%esp
80101df7:	68 80 95 10 80       	push   $0x80109580
80101dfc:	e8 03 20 00 00       	call   80103e04 <release>
  // Start disk on next buf in queue.
  if(idequeue != 0)
    idestart(idequeue);

  release(&idelock);
}
80101e01:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e04:	5b                   	pop    %ebx
80101e05:	5e                   	pop    %esi
80101e06:	5f                   	pop    %edi
80101e07:	5d                   	pop    %ebp
80101e08:	c3                   	ret    
80101e09:	8d 76 00             	lea    0x0(%esi),%esi
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101e0c:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101e11:	8d 76 00             	lea    0x0(%esi),%esi
80101e14:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101e15:	88 c1                	mov    %al,%cl
80101e17:	83 e1 c0             	and    $0xffffffc0,%ecx
80101e1a:	80 f9 40             	cmp    $0x40,%cl
80101e1d:	75 f5                	jne    80101e14 <ideintr+0x74>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80101e1f:	a8 21                	test   $0x21,%al
80101e21:	75 af                	jne    80101dd2 <ideintr+0x32>
  }
  idequeue = b->qnext;

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);
80101e23:	8d 7b 5c             	lea    0x5c(%ebx),%edi
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
80101e26:	b9 80 00 00 00       	mov    $0x80,%ecx
80101e2b:	ba f0 01 00 00       	mov    $0x1f0,%edx
80101e30:	fc                   	cld    
80101e31:	f3 6d                	rep insl (%dx),%es:(%edi)
80101e33:	8b 33                	mov    (%ebx),%esi
80101e35:	eb 9b                	jmp    80101dd2 <ideintr+0x32>
80101e37:	90                   	nop

80101e38 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80101e38:	55                   	push   %ebp
80101e39:	89 e5                	mov    %esp,%ebp
80101e3b:	53                   	push   %ebx
80101e3c:	83 ec 10             	sub    $0x10,%esp
80101e3f:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
80101e42:	8d 43 0c             	lea    0xc(%ebx),%eax
80101e45:	50                   	push   %eax
80101e46:	e8 9d 1d 00 00       	call   80103be8 <holdingsleep>
80101e4b:	83 c4 10             	add    $0x10,%esp
80101e4e:	85 c0                	test   %eax,%eax
80101e50:	0f 84 a1 00 00 00    	je     80101ef7 <iderw+0xbf>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80101e56:	8b 03                	mov    (%ebx),%eax
80101e58:	83 e0 06             	and    $0x6,%eax
80101e5b:	83 f8 02             	cmp    $0x2,%eax
80101e5e:	0f 84 ad 00 00 00    	je     80101f11 <iderw+0xd9>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
80101e64:	8b 53 04             	mov    0x4(%ebx),%edx
80101e67:	85 d2                	test   %edx,%edx
80101e69:	74 0d                	je     80101e78 <iderw+0x40>
80101e6b:	a1 60 95 10 80       	mov    0x80109560,%eax
80101e70:	85 c0                	test   %eax,%eax
80101e72:	0f 84 8c 00 00 00    	je     80101f04 <iderw+0xcc>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80101e78:	83 ec 0c             	sub    $0xc,%esp
80101e7b:	68 80 95 10 80       	push   $0x80109580
80101e80:	e8 e7 1e 00 00       	call   80103d6c <acquire>

  // Append b to idequeue.
  b->qnext = 0;
80101e85:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80101e8c:	8b 15 64 95 10 80    	mov    0x80109564,%edx
80101e92:	83 c4 10             	add    $0x10,%esp
80101e95:	85 d2                	test   %edx,%edx
80101e97:	75 05                	jne    80101e9e <iderw+0x66>
80101e99:	eb 4c                	jmp    80101ee7 <iderw+0xaf>
80101e9b:	90                   	nop
80101e9c:	89 c2                	mov    %eax,%edx
80101e9e:	8b 42 58             	mov    0x58(%edx),%eax
80101ea1:	85 c0                	test   %eax,%eax
80101ea3:	75 f7                	jne    80101e9c <iderw+0x64>
80101ea5:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80101ea8:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80101eaa:	3b 1d 64 95 10 80    	cmp    0x80109564,%ebx
80101eb0:	74 3c                	je     80101eee <iderw+0xb6>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80101eb2:	8b 03                	mov    (%ebx),%eax
80101eb4:	83 e0 06             	and    $0x6,%eax
80101eb7:	83 f8 02             	cmp    $0x2,%eax
80101eba:	74 1b                	je     80101ed7 <iderw+0x9f>
    sleep(b, &idelock);
80101ebc:	83 ec 08             	sub    $0x8,%esp
80101ebf:	68 80 95 10 80       	push   $0x80109580
80101ec4:	53                   	push   %ebx
80101ec5:	e8 32 19 00 00       	call   801037fc <sleep>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80101eca:	8b 03                	mov    (%ebx),%eax
80101ecc:	83 e0 06             	and    $0x6,%eax
80101ecf:	83 c4 10             	add    $0x10,%esp
80101ed2:	83 f8 02             	cmp    $0x2,%eax
80101ed5:	75 e5                	jne    80101ebc <iderw+0x84>
    sleep(b, &idelock);
  }


  release(&idelock);
80101ed7:	c7 45 08 80 95 10 80 	movl   $0x80109580,0x8(%ebp)
}
80101ede:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101ee1:	c9                   	leave  
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
  }


  release(&idelock);
80101ee2:	e9 1d 1f 00 00       	jmp    80103e04 <release>

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80101ee7:	ba 64 95 10 80       	mov    $0x80109564,%edx
80101eec:	eb ba                	jmp    80101ea8 <iderw+0x70>
    ;
  *pp = b;

  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
80101eee:	89 d8                	mov    %ebx,%eax
80101ef0:	e8 93 fd ff ff       	call   80101c88 <idestart>
80101ef5:	eb bb                	jmp    80101eb2 <iderw+0x7a>
iderw(struct buf *b)
{
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
80101ef7:	83 ec 0c             	sub    $0xc,%esp
80101efa:	68 4a 67 10 80       	push   $0x8010674a
80101eff:	e8 34 e4 ff ff       	call   80100338 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("iderw: ide disk 1 not present");
80101f04:	83 ec 0c             	sub    $0xc,%esp
80101f07:	68 75 67 10 80       	push   $0x80106775
80101f0c:	e8 27 e4 ff ff       	call   80100338 <panic>
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
80101f11:	83 ec 0c             	sub    $0xc,%esp
80101f14:	68 60 67 10 80       	push   $0x80106760
80101f19:	e8 1a e4 ff ff       	call   80100338 <panic>
80101f1e:	66 90                	xchg   %ax,%ax

80101f20 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80101f20:	55                   	push   %ebp
80101f21:	89 e5                	mov    %esp,%ebp
80101f23:	56                   	push   %esi
80101f24:	53                   	push   %ebx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80101f25:	c7 05 34 16 11 80 00 	movl   $0xfec00000,0x80111634
80101f2c:	00 c0 fe 
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
80101f2f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80101f36:	00 00 00 
  return ioapic->data;
80101f39:	8b 15 34 16 11 80    	mov    0x80111634,%edx
80101f3f:	8b 72 10             	mov    0x10(%edx),%esi
ioapicinit(void)
{
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80101f42:	89 f0                	mov    %esi,%eax
80101f44:	c1 e8 10             	shr    $0x10,%eax
80101f47:	0f b6 f0             	movzbl %al,%esi
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
80101f4a:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80101f50:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
80101f56:	8b 41 10             	mov    0x10(%ecx),%eax
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80101f59:	c1 e8 18             	shr    $0x18,%eax
80101f5c:	0f b6 15 60 17 11 80 	movzbl 0x80111760,%edx
80101f63:	39 d0                	cmp    %edx,%eax
80101f65:	74 16                	je     80101f7d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80101f67:	83 ec 0c             	sub    $0xc,%esp
80101f6a:	68 94 67 10 80       	push   $0x80106794
80101f6f:	e8 84 e6 ff ff       	call   801005f8 <cprintf>
80101f74:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
80101f7a:	83 c4 10             	add    $0x10,%esp
80101f7d:	83 c6 21             	add    $0x21,%esi
  ioapic->data = data;
}

void
ioapicinit(void)
{
80101f80:	ba 10 00 00 00       	mov    $0x10,%edx
80101f85:	b8 20 00 00 00       	mov    $0x20,%eax
80101f8a:	66 90                	xchg   %ax,%ax
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80101f8c:	89 c3                	mov    %eax,%ebx
80101f8e:	81 cb 00 00 01 00    	or     $0x10000,%ebx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80101f94:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80101f96:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
80101f9c:	89 59 10             	mov    %ebx,0x10(%ecx)
80101f9f:	8d 5a 01             	lea    0x1(%edx),%ebx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80101fa2:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
80101fa4:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
80101faa:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
80101fb1:	40                   	inc    %eax
80101fb2:	83 c2 02             	add    $0x2,%edx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80101fb5:	39 f0                	cmp    %esi,%eax
80101fb7:	75 d3                	jne    80101f8c <ioapicinit+0x6c>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80101fb9:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101fbc:	5b                   	pop    %ebx
80101fbd:	5e                   	pop    %esi
80101fbe:	5d                   	pop    %ebp
80101fbf:	c3                   	ret    

80101fc0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80101fc0:	55                   	push   %ebp
80101fc1:	89 e5                	mov    %esp,%ebp
80101fc3:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80101fc6:	8d 50 20             	lea    0x20(%eax),%edx
80101fc9:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80101fcd:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
80101fd3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80101fd5:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
80101fdb:	89 51 10             	mov    %edx,0x10(%ecx)
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80101fde:	8b 55 0c             	mov    0xc(%ebp),%edx
80101fe1:	c1 e2 18             	shl    $0x18,%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80101fe4:	40                   	inc    %eax
80101fe5:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80101fe7:	a1 34 16 11 80       	mov    0x80111634,%eax
80101fec:	89 50 10             	mov    %edx,0x10(%eax)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
80101fef:	5d                   	pop    %ebp
80101ff0:	c3                   	ret    
80101ff1:	66 90                	xchg   %ax,%ax
80101ff3:	90                   	nop

80101ff4 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80101ff4:	55                   	push   %ebp
80101ff5:	89 e5                	mov    %esp,%ebp
80101ff7:	53                   	push   %ebx
80101ff8:	53                   	push   %ebx
80101ff9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
80101ffc:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102002:	75 6e                	jne    80102072 <kfree+0x7e>
80102004:	81 fb a8 44 11 80    	cmp    $0x801144a8,%ebx
8010200a:	72 66                	jb     80102072 <kfree+0x7e>
8010200c:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102012:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102017:	77 59                	ja     80102072 <kfree+0x7e>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102019:	52                   	push   %edx
8010201a:	68 00 10 00 00       	push   $0x1000
8010201f:	6a 01                	push   $0x1
80102021:	53                   	push   %ebx
80102022:	e8 25 1e 00 00       	call   80103e4c <memset>

  if(kmem.use_lock)
80102027:	83 c4 10             	add    $0x10,%esp
8010202a:	8b 0d 74 16 11 80    	mov    0x80111674,%ecx
80102030:	85 c9                	test   %ecx,%ecx
80102032:	75 2c                	jne    80102060 <kfree+0x6c>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102034:	a1 78 16 11 80       	mov    0x80111678,%eax
80102039:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
8010203b:	89 1d 78 16 11 80    	mov    %ebx,0x80111678
  if(kmem.use_lock)
80102041:	a1 74 16 11 80       	mov    0x80111674,%eax
80102046:	85 c0                	test   %eax,%eax
80102048:	75 06                	jne    80102050 <kfree+0x5c>
    release(&kmem.lock);
}
8010204a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010204d:	c9                   	leave  
8010204e:	c3                   	ret    
8010204f:	90                   	nop
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
80102050:	c7 45 08 40 16 11 80 	movl   $0x80111640,0x8(%ebp)
}
80102057:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010205a:	c9                   	leave  
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
8010205b:	e9 a4 1d 00 00       	jmp    80103e04 <release>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102060:	83 ec 0c             	sub    $0xc,%esp
80102063:	68 40 16 11 80       	push   $0x80111640
80102068:	e8 ff 1c 00 00       	call   80103d6c <acquire>
8010206d:	83 c4 10             	add    $0x10,%esp
80102070:	eb c2                	jmp    80102034 <kfree+0x40>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
80102072:	83 ec 0c             	sub    $0xc,%esp
80102075:	68 c6 67 10 80       	push   $0x801067c6
8010207a:	e8 b9 e2 ff ff       	call   80100338 <panic>
8010207f:	90                   	nop

80102080 <freerange>:
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
80102080:	55                   	push   %ebp
80102081:	89 e5                	mov    %esp,%ebp
80102083:	56                   	push   %esi
80102084:	53                   	push   %ebx
80102085:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102088:	8b 45 08             	mov    0x8(%ebp),%eax
8010208b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102091:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102097:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010209d:	39 de                	cmp    %ebx,%esi
8010209f:	72 1f                	jb     801020c0 <freerange+0x40>
801020a1:	8d 76 00             	lea    0x0(%esi),%esi
    kfree(p);
801020a4:	83 ec 0c             	sub    $0xc,%esp
801020a7:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801020ad:	50                   	push   %eax
801020ae:	e8 41 ff ff ff       	call   80101ff4 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801020b3:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801020b9:	83 c4 10             	add    $0x10,%esp
801020bc:	39 f3                	cmp    %esi,%ebx
801020be:	76 e4                	jbe    801020a4 <freerange+0x24>
    kfree(p);
}
801020c0:	8d 65 f8             	lea    -0x8(%ebp),%esp
801020c3:	5b                   	pop    %ebx
801020c4:	5e                   	pop    %esi
801020c5:	5d                   	pop    %ebp
801020c6:	c3                   	ret    
801020c7:	90                   	nop

801020c8 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
801020c8:	55                   	push   %ebp
801020c9:	89 e5                	mov    %esp,%ebp
801020cb:	56                   	push   %esi
801020cc:	53                   	push   %ebx
801020cd:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801020d0:	83 ec 08             	sub    $0x8,%esp
801020d3:	68 cc 67 10 80       	push   $0x801067cc
801020d8:	68 40 16 11 80       	push   $0x80111640
801020dd:	e8 4e 1b 00 00       	call   80103c30 <initlock>
  kmem.use_lock = 0;
801020e2:	c7 05 74 16 11 80 00 	movl   $0x0,0x80111674
801020e9:	00 00 00 

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801020ec:	8b 45 08             	mov    0x8(%ebp),%eax
801020ef:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801020f5:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801020fb:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102101:	83 c4 10             	add    $0x10,%esp
80102104:	39 de                	cmp    %ebx,%esi
80102106:	72 1c                	jb     80102124 <kinit1+0x5c>
    kfree(p);
80102108:	83 ec 0c             	sub    $0xc,%esp
8010210b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102111:	50                   	push   %eax
80102112:	e8 dd fe ff ff       	call   80101ff4 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102117:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010211d:	83 c4 10             	add    $0x10,%esp
80102120:	39 de                	cmp    %ebx,%esi
80102122:	73 e4                	jae    80102108 <kinit1+0x40>
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
}
80102124:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102127:	5b                   	pop    %ebx
80102128:	5e                   	pop    %esi
80102129:	5d                   	pop    %ebp
8010212a:	c3                   	ret    
8010212b:	90                   	nop

8010212c <kinit2>:

void
kinit2(void *vstart, void *vend)
{
8010212c:	55                   	push   %ebp
8010212d:	89 e5                	mov    %esp,%ebp
8010212f:	56                   	push   %esi
80102130:	53                   	push   %ebx
80102131:	8b 75 0c             	mov    0xc(%ebp),%esi

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102134:	8b 45 08             	mov    0x8(%ebp),%eax
80102137:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
8010213d:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102143:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102149:	39 de                	cmp    %ebx,%esi
8010214b:	72 1f                	jb     8010216c <kinit2+0x40>
8010214d:	8d 76 00             	lea    0x0(%esi),%esi
    kfree(p);
80102150:	83 ec 0c             	sub    $0xc,%esp
80102153:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102159:	50                   	push   %eax
8010215a:	e8 95 fe ff ff       	call   80101ff4 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010215f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102165:	83 c4 10             	add    $0x10,%esp
80102168:	39 de                	cmp    %ebx,%esi
8010216a:	73 e4                	jae    80102150 <kinit2+0x24>

void
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
8010216c:	c7 05 74 16 11 80 01 	movl   $0x1,0x80111674
80102173:	00 00 00 
}
80102176:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102179:	5b                   	pop    %ebx
8010217a:	5e                   	pop    %esi
8010217b:	5d                   	pop    %ebp
8010217c:	c3                   	ret    
8010217d:	8d 76 00             	lea    0x0(%esi),%esi

80102180 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102180:	55                   	push   %ebp
80102181:	89 e5                	mov    %esp,%ebp
80102183:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if(kmem.use_lock)
80102186:	8b 15 74 16 11 80    	mov    0x80111674,%edx
8010218c:	85 d2                	test   %edx,%edx
8010218e:	75 30                	jne    801021c0 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102190:	a1 78 16 11 80       	mov    0x80111678,%eax
  if(r)
80102195:	85 c0                	test   %eax,%eax
80102197:	74 0c                	je     801021a5 <kalloc+0x25>
    kmem.freelist = r->next;
80102199:	8b 08                	mov    (%eax),%ecx
8010219b:	89 0d 78 16 11 80    	mov    %ecx,0x80111678
  if(kmem.use_lock)
801021a1:	85 d2                	test   %edx,%edx
801021a3:	75 03                	jne    801021a8 <kalloc+0x28>
    release(&kmem.lock);
  return (char*)r;
}
801021a5:	c9                   	leave  
801021a6:	c3                   	ret    
801021a7:	90                   	nop
801021a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    acquire(&kmem.lock);
  r = kmem.freelist;
  if(r)
    kmem.freelist = r->next;
  if(kmem.use_lock)
    release(&kmem.lock);
801021ab:	83 ec 0c             	sub    $0xc,%esp
801021ae:	68 40 16 11 80       	push   $0x80111640
801021b3:	e8 4c 1c 00 00       	call   80103e04 <release>
801021b8:	83 c4 10             	add    $0x10,%esp
801021bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  return (char*)r;
}
801021be:	c9                   	leave  
801021bf:	c3                   	ret    
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
801021c0:	83 ec 0c             	sub    $0xc,%esp
801021c3:	68 40 16 11 80       	push   $0x80111640
801021c8:	e8 9f 1b 00 00       	call   80103d6c <acquire>
  r = kmem.freelist;
801021cd:	a1 78 16 11 80       	mov    0x80111678,%eax
  if(r)
801021d2:	83 c4 10             	add    $0x10,%esp
801021d5:	8b 15 74 16 11 80    	mov    0x80111674,%edx
801021db:	85 c0                	test   %eax,%eax
801021dd:	75 ba                	jne    80102199 <kalloc+0x19>
801021df:	eb c0                	jmp    801021a1 <kalloc+0x21>
801021e1:	66 90                	xchg   %ax,%ax
801021e3:	90                   	nop

801021e4 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
801021e4:	55                   	push   %ebp
801021e5:	89 e5                	mov    %esp,%ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801021e7:	ba 64 00 00 00       	mov    $0x64,%edx
801021ec:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801021ed:	a8 01                	test   $0x1,%al
801021ef:	0f 84 a3 00 00 00    	je     80102298 <kbdgetc+0xb4>
801021f5:	ba 60 00 00 00       	mov    $0x60,%edx
801021fa:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
801021fb:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
801021fe:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102204:	74 76                	je     8010227c <kbdgetc+0x98>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102206:	8b 0d b4 95 10 80    	mov    0x801095b4,%ecx
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
8010220c:	84 c0                	test   %al,%al
8010220e:	79 24                	jns    80102234 <kbdgetc+0x50>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102210:	f6 c1 40             	test   $0x40,%cl
80102213:	75 05                	jne    8010221a <kbdgetc+0x36>
80102215:	89 c2                	mov    %eax,%edx
80102217:	83 e2 7f             	and    $0x7f,%edx
    shift &= ~(shiftcode[data] | E0ESC);
8010221a:	8a 82 00 69 10 80    	mov    -0x7fef9700(%edx),%al
80102220:	83 c8 40             	or     $0x40,%eax
80102223:	0f b6 c0             	movzbl %al,%eax
80102226:	f7 d0                	not    %eax
80102228:	21 c8                	and    %ecx,%eax
8010222a:	a3 b4 95 10 80       	mov    %eax,0x801095b4
    return 0;
8010222f:	31 c0                	xor    %eax,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102231:	5d                   	pop    %ebp
80102232:	c3                   	ret    
80102233:	90                   	nop
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102234:	f6 c1 40             	test   $0x40,%cl
80102237:	74 09                	je     80102242 <kbdgetc+0x5e>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102239:	83 c8 80             	or     $0xffffff80,%eax
8010223c:	0f b6 d0             	movzbl %al,%edx
    shift &= ~E0ESC;
8010223f:	83 e1 bf             	and    $0xffffffbf,%ecx
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
80102242:	0f b6 82 00 69 10 80 	movzbl -0x7fef9700(%edx),%eax
80102249:	09 c1                	or     %eax,%ecx
8010224b:	0f b6 82 00 68 10 80 	movzbl -0x7fef9800(%edx),%eax
80102252:	31 c1                	xor    %eax,%ecx
80102254:	89 0d b4 95 10 80    	mov    %ecx,0x801095b4
  c = charcode[shift & (CTL | SHIFT)][data];
8010225a:	89 c8                	mov    %ecx,%eax
8010225c:	83 e0 03             	and    $0x3,%eax
8010225f:	8b 04 85 e0 67 10 80 	mov    -0x7fef9820(,%eax,4),%eax
80102266:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
8010226a:	83 e1 08             	and    $0x8,%ecx
8010226d:	74 c2                	je     80102231 <kbdgetc+0x4d>
    if('a' <= c && c <= 'z')
8010226f:	8d 50 9f             	lea    -0x61(%eax),%edx
80102272:	83 fa 19             	cmp    $0x19,%edx
80102275:	77 11                	ja     80102288 <kbdgetc+0xa4>
      c += 'A' - 'a';
80102277:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
8010227a:	5d                   	pop    %ebp
8010227b:	c3                   	ret    
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
8010227c:	83 0d b4 95 10 80 40 	orl    $0x40,0x801095b4
    return 0;
80102283:	31 c0                	xor    %eax,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102285:	5d                   	pop    %ebp
80102286:	c3                   	ret    
80102287:	90                   	nop
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
80102288:	8d 50 bf             	lea    -0x41(%eax),%edx
8010228b:	83 fa 19             	cmp    $0x19,%edx
8010228e:	77 a1                	ja     80102231 <kbdgetc+0x4d>
      c += 'a' - 'A';
80102290:	83 c0 20             	add    $0x20,%eax
  }
  return c;
}
80102293:	5d                   	pop    %ebp
80102294:	c3                   	ret    
80102295:	8d 76 00             	lea    0x0(%esi),%esi
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
80102298:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
8010229d:	5d                   	pop    %ebp
8010229e:	c3                   	ret    
8010229f:	90                   	nop

801022a0 <kbdintr>:

void
kbdintr(void)
{
801022a0:	55                   	push   %ebp
801022a1:	89 e5                	mov    %esp,%ebp
801022a3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801022a6:	68 e4 21 10 80       	push   $0x801021e4
801022ab:	e8 94 e4 ff ff       	call   80100744 <consoleintr>
}
801022b0:	83 c4 10             	add    $0x10,%esp
801022b3:	c9                   	leave  
801022b4:	c3                   	ret    
801022b5:	66 90                	xchg   %ax,%ax
801022b7:	90                   	nop

801022b8 <lapicinit>:
  lapic[ID];  // wait for write to finish, by reading
}

void
lapicinit(void)
{
801022b8:	55                   	push   %ebp
801022b9:	89 e5                	mov    %esp,%ebp
  if(!lapic)
801022bb:	a1 7c 16 11 80       	mov    0x8011167c,%eax
801022c0:	85 c0                	test   %eax,%eax
801022c2:	0f 84 c0 00 00 00    	je     80102388 <lapicinit+0xd0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801022c8:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801022cf:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
801022d2:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801022d5:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
801022dc:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801022df:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801022e2:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801022e9:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
801022ec:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801022ef:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801022f6:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
801022f9:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801022fc:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102303:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102306:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102309:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102310:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102313:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102316:	8b 50 30             	mov    0x30(%eax),%edx
80102319:	c1 ea 10             	shr    $0x10,%edx
8010231c:	80 fa 03             	cmp    $0x3,%dl
8010231f:	77 6b                	ja     8010238c <lapicinit+0xd4>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102321:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102328:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010232b:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010232e:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102335:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102338:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010233b:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102342:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102345:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102348:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
8010234f:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102352:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102355:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
8010235c:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010235f:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102362:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102369:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
8010236c:	8b 50 20             	mov    0x20(%eax),%edx
8010236f:	90                   	nop
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102370:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102376:	80 e6 10             	and    $0x10,%dh
80102379:	75 f5                	jne    80102370 <lapicinit+0xb8>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010237b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102382:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102385:	8b 40 20             	mov    0x20(%eax),%eax
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102388:	5d                   	pop    %ebp
80102389:	c3                   	ret    
8010238a:	66 90                	xchg   %ax,%ax

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010238c:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102393:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102396:	8b 50 20             	mov    0x20(%eax),%edx
80102399:	eb 86                	jmp    80102321 <lapicinit+0x69>
8010239b:	90                   	nop

8010239c <lapicid>:
  lapicw(TPR, 0);
}

int
lapicid(void)
{
8010239c:	55                   	push   %ebp
8010239d:	89 e5                	mov    %esp,%ebp
  if (!lapic)
8010239f:	a1 7c 16 11 80       	mov    0x8011167c,%eax
801023a4:	85 c0                	test   %eax,%eax
801023a6:	74 08                	je     801023b0 <lapicid+0x14>
    return 0;
  return lapic[ID] >> 24;
801023a8:	8b 40 20             	mov    0x20(%eax),%eax
801023ab:	c1 e8 18             	shr    $0x18,%eax
}
801023ae:	5d                   	pop    %ebp
801023af:	c3                   	ret    

int
lapicid(void)
{
  if (!lapic)
    return 0;
801023b0:	31 c0                	xor    %eax,%eax
  return lapic[ID] >> 24;
}
801023b2:	5d                   	pop    %ebp
801023b3:	c3                   	ret    

801023b4 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
801023b4:	55                   	push   %ebp
801023b5:	89 e5                	mov    %esp,%ebp
  if(lapic)
801023b7:	a1 7c 16 11 80       	mov    0x8011167c,%eax
801023bc:	85 c0                	test   %eax,%eax
801023be:	74 0d                	je     801023cd <lapiceoi+0x19>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801023c0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801023c7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801023ca:	8b 40 20             	mov    0x20(%eax),%eax
void
lapiceoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
}
801023cd:	5d                   	pop    %ebp
801023ce:	c3                   	ret    
801023cf:	90                   	nop

801023d0 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
801023d0:	55                   	push   %ebp
801023d1:	89 e5                	mov    %esp,%ebp
}
801023d3:	5d                   	pop    %ebp
801023d4:	c3                   	ret    
801023d5:	8d 76 00             	lea    0x0(%esi),%esi

801023d8 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
801023d8:	55                   	push   %ebp
801023d9:	89 e5                	mov    %esp,%ebp
801023db:	53                   	push   %ebx
801023dc:	8b 5d 08             	mov    0x8(%ebp),%ebx
801023df:	8b 4d 0c             	mov    0xc(%ebp),%ecx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801023e2:	ba 70 00 00 00       	mov    $0x70,%edx
801023e7:	b0 0f                	mov    $0xf,%al
801023e9:	ee                   	out    %al,(%dx)
801023ea:	ba 71 00 00 00       	mov    $0x71,%edx
801023ef:	b0 0a                	mov    $0xa,%al
801023f1:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
801023f2:	66 c7 05 67 04 00 80 	movw   $0x0,0x80000467
801023f9:	00 00 
  wrv[1] = addr >> 4;
801023fb:	89 c8                	mov    %ecx,%eax
801023fd:	c1 e8 04             	shr    $0x4,%eax
80102400:	66 a3 69 04 00 80    	mov    %ax,0x80000469

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102406:	a1 7c 16 11 80       	mov    0x8011167c,%eax
8010240b:	c1 e3 18             	shl    $0x18,%ebx
8010240e:	89 da                	mov    %ebx,%edx
80102410:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102416:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102419:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102420:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102423:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102426:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
8010242d:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102430:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102433:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102439:	8b 58 20             	mov    0x20(%eax),%ebx
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010243c:	c1 e9 0c             	shr    $0xc,%ecx
8010243f:	80 cd 06             	or     $0x6,%ch

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102442:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102448:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010244b:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102451:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102454:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010245a:	8b 40 20             	mov    0x20(%eax),%eax
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
8010245d:	5b                   	pop    %ebx
8010245e:	5d                   	pop    %ebp
8010245f:	c3                   	ret    

80102460 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102460:	55                   	push   %ebp
80102461:	89 e5                	mov    %esp,%ebp
80102463:	57                   	push   %edi
80102464:	56                   	push   %esi
80102465:	53                   	push   %ebx
80102466:	83 ec 4c             	sub    $0x4c,%esp
80102469:	ba 70 00 00 00       	mov    $0x70,%edx
8010246e:	b0 0b                	mov    $0xb,%al
80102470:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102471:	ba 71 00 00 00       	mov    $0x71,%edx
80102476:	ec                   	in     (%dx),%al
80102477:	83 e0 04             	and    $0x4,%eax
8010247a:	88 45 b7             	mov    %al,-0x49(%ebp)
8010247d:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80102480:	8d 75 b8             	lea    -0x48(%ebp),%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102483:	bf 70 00 00 00       	mov    $0x70,%edi
80102488:	31 c0                	xor    %eax,%eax
8010248a:	89 fa                	mov    %edi,%edx
8010248c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010248d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102492:	89 ca                	mov    %ecx,%edx
80102494:	ec                   	in     (%dx),%al
}

static void
fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
80102495:	0f b6 c0             	movzbl %al,%eax
80102498:	89 45 b8             	mov    %eax,-0x48(%ebp)
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010249b:	b0 02                	mov    $0x2,%al
8010249d:	89 fa                	mov    %edi,%edx
8010249f:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801024a0:	89 ca                	mov    %ecx,%edx
801024a2:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
801024a3:	0f b6 c0             	movzbl %al,%eax
801024a6:	89 45 bc             	mov    %eax,-0x44(%ebp)
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801024a9:	b0 04                	mov    $0x4,%al
801024ab:	89 fa                	mov    %edi,%edx
801024ad:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801024ae:	89 ca                	mov    %ecx,%edx
801024b0:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
801024b1:	0f b6 c0             	movzbl %al,%eax
801024b4:	89 45 c0             	mov    %eax,-0x40(%ebp)
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801024b7:	b0 07                	mov    $0x7,%al
801024b9:	89 fa                	mov    %edi,%edx
801024bb:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801024bc:	89 ca                	mov    %ecx,%edx
801024be:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
801024bf:	0f b6 c0             	movzbl %al,%eax
801024c2:	89 45 c4             	mov    %eax,-0x3c(%ebp)
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801024c5:	b0 08                	mov    $0x8,%al
801024c7:	89 fa                	mov    %edi,%edx
801024c9:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801024ca:	89 ca                	mov    %ecx,%edx
801024cc:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
801024cd:	0f b6 c0             	movzbl %al,%eax
801024d0:	89 45 c8             	mov    %eax,-0x38(%ebp)
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801024d3:	b0 09                	mov    $0x9,%al
801024d5:	89 fa                	mov    %edi,%edx
801024d7:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801024d8:	89 ca                	mov    %ecx,%edx
801024da:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
801024db:	0f b6 c0             	movzbl %al,%eax
801024de:	89 45 cc             	mov    %eax,-0x34(%ebp)
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801024e1:	b0 0a                	mov    $0xa,%al
801024e3:	89 fa                	mov    %edi,%edx
801024e5:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801024e6:	89 ca                	mov    %ecx,%edx
801024e8:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
801024e9:	84 c0                	test   %al,%al
801024eb:	78 9b                	js     80102488 <cmostime+0x28>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801024ed:	31 c0                	xor    %eax,%eax
801024ef:	89 fa                	mov    %edi,%edx
801024f1:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801024f2:	89 ca                	mov    %ecx,%edx
801024f4:	ec                   	in     (%dx),%al
}

static void
fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
801024f5:	0f b6 c0             	movzbl %al,%eax
801024f8:	89 45 d0             	mov    %eax,-0x30(%ebp)
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801024fb:	b0 02                	mov    $0x2,%al
801024fd:	89 fa                	mov    %edi,%edx
801024ff:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102500:	89 ca                	mov    %ecx,%edx
80102502:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
80102503:	0f b6 c0             	movzbl %al,%eax
80102506:	89 45 d4             	mov    %eax,-0x2c(%ebp)
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102509:	b0 04                	mov    $0x4,%al
8010250b:	89 fa                	mov    %edi,%edx
8010250d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010250e:	89 ca                	mov    %ecx,%edx
80102510:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
80102511:	0f b6 c0             	movzbl %al,%eax
80102514:	89 45 d8             	mov    %eax,-0x28(%ebp)
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102517:	b0 07                	mov    $0x7,%al
80102519:	89 fa                	mov    %edi,%edx
8010251b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010251c:	89 ca                	mov    %ecx,%edx
8010251e:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
8010251f:	0f b6 c0             	movzbl %al,%eax
80102522:	89 45 dc             	mov    %eax,-0x24(%ebp)
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102525:	b0 08                	mov    $0x8,%al
80102527:	89 fa                	mov    %edi,%edx
80102529:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010252a:	89 ca                	mov    %ecx,%edx
8010252c:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
8010252d:	0f b6 c0             	movzbl %al,%eax
80102530:	89 45 e0             	mov    %eax,-0x20(%ebp)
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102533:	b0 09                	mov    $0x9,%al
80102535:	89 fa                	mov    %edi,%edx
80102537:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102538:	89 ca                	mov    %ecx,%edx
8010253a:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
8010253b:	0f b6 c0             	movzbl %al,%eax
8010253e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102541:	50                   	push   %eax
80102542:	6a 18                	push   $0x18
80102544:	53                   	push   %ebx
80102545:	56                   	push   %esi
80102546:	e8 4d 19 00 00       	call   80103e98 <memcmp>
8010254b:	83 c4 10             	add    $0x10,%esp
8010254e:	85 c0                	test   %eax,%eax
80102550:	0f 85 32 ff ff ff    	jne    80102488 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102556:	80 7d b7 00          	cmpb   $0x0,-0x49(%ebp)
8010255a:	75 78                	jne    801025d4 <cmostime+0x174>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010255c:	8b 45 b8             	mov    -0x48(%ebp),%eax
8010255f:	89 c2                	mov    %eax,%edx
80102561:	c1 ea 04             	shr    $0x4,%edx
80102564:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102567:	83 e0 0f             	and    $0xf,%eax
8010256a:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010256d:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102570:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102573:	89 c2                	mov    %eax,%edx
80102575:	c1 ea 04             	shr    $0x4,%edx
80102578:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010257b:	83 e0 0f             	and    $0xf,%eax
8010257e:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102581:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102584:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102587:	89 c2                	mov    %eax,%edx
80102589:	c1 ea 04             	shr    $0x4,%edx
8010258c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010258f:	83 e0 0f             	and    $0xf,%eax
80102592:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102595:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102598:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010259b:	89 c2                	mov    %eax,%edx
8010259d:	c1 ea 04             	shr    $0x4,%edx
801025a0:	8d 14 92             	lea    (%edx,%edx,4),%edx
801025a3:	83 e0 0f             	and    $0xf,%eax
801025a6:	8d 04 50             	lea    (%eax,%edx,2),%eax
801025a9:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
801025ac:	8b 45 c8             	mov    -0x38(%ebp),%eax
801025af:	89 c2                	mov    %eax,%edx
801025b1:	c1 ea 04             	shr    $0x4,%edx
801025b4:	8d 14 92             	lea    (%edx,%edx,4),%edx
801025b7:	83 e0 0f             	and    $0xf,%eax
801025ba:	8d 04 50             	lea    (%eax,%edx,2),%eax
801025bd:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
801025c0:	8b 45 cc             	mov    -0x34(%ebp),%eax
801025c3:	89 c2                	mov    %eax,%edx
801025c5:	c1 ea 04             	shr    $0x4,%edx
801025c8:	8d 14 92             	lea    (%edx,%edx,4),%edx
801025cb:	83 e0 0f             	and    $0xf,%eax
801025ce:	8d 04 50             	lea    (%eax,%edx,2),%eax
801025d1:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
801025d4:	b9 06 00 00 00       	mov    $0x6,%ecx
801025d9:	8b 7d 08             	mov    0x8(%ebp),%edi
801025dc:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  r->year += 2000;
801025de:	8b 45 08             	mov    0x8(%ebp),%eax
801025e1:	81 40 14 d0 07 00 00 	addl   $0x7d0,0x14(%eax)
}
801025e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801025eb:	5b                   	pop    %ebx
801025ec:	5e                   	pop    %esi
801025ed:	5f                   	pop    %edi
801025ee:	5d                   	pop    %ebp
801025ef:	c3                   	ret    

801025f0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801025f0:	8b 0d c8 16 11 80    	mov    0x801116c8,%ecx
801025f6:	85 c9                	test   %ecx,%ecx
801025f8:	7e 7d                	jle    80102677 <install_trans+0x87>
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
801025fa:	55                   	push   %ebp
801025fb:	89 e5                	mov    %esp,%ebp
801025fd:	57                   	push   %edi
801025fe:	56                   	push   %esi
801025ff:	53                   	push   %ebx
80102600:	83 ec 0c             	sub    $0xc,%esp
80102603:	31 db                	xor    %ebx,%ebx
80102605:	8d 76 00             	lea    0x0(%esi),%esi
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102608:	83 ec 08             	sub    $0x8,%esp
8010260b:	a1 b4 16 11 80       	mov    0x801116b4,%eax
80102610:	01 d8                	add    %ebx,%eax
80102612:	40                   	inc    %eax
80102613:	50                   	push   %eax
80102614:	ff 35 c4 16 11 80    	pushl  0x801116c4
8010261a:	e8 95 da ff ff       	call   801000b4 <bread>
8010261f:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102621:	58                   	pop    %eax
80102622:	5a                   	pop    %edx
80102623:	ff 34 9d cc 16 11 80 	pushl  -0x7feee934(,%ebx,4)
8010262a:	ff 35 c4 16 11 80    	pushl  0x801116c4
80102630:	e8 7f da ff ff       	call   801000b4 <bread>
80102635:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102637:	83 c4 0c             	add    $0xc,%esp
8010263a:	68 00 02 00 00       	push   $0x200
8010263f:	8d 47 5c             	lea    0x5c(%edi),%eax
80102642:	50                   	push   %eax
80102643:	8d 46 5c             	lea    0x5c(%esi),%eax
80102646:	50                   	push   %eax
80102647:	e8 94 18 00 00       	call   80103ee0 <memmove>
    bwrite(dbuf);  // write dst to disk
8010264c:	89 34 24             	mov    %esi,(%esp)
8010264f:	e8 2c db ff ff       	call   80100180 <bwrite>
    brelse(lbuf);
80102654:	89 3c 24             	mov    %edi,(%esp)
80102657:	e8 5c db ff ff       	call   801001b8 <brelse>
    brelse(dbuf);
8010265c:	89 34 24             	mov    %esi,(%esp)
8010265f:	e8 54 db ff ff       	call   801001b8 <brelse>
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102664:	43                   	inc    %ebx
80102665:	83 c4 10             	add    $0x10,%esp
80102668:	39 1d c8 16 11 80    	cmp    %ebx,0x801116c8
8010266e:	7f 98                	jg     80102608 <install_trans+0x18>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
80102670:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102673:	5b                   	pop    %ebx
80102674:	5e                   	pop    %esi
80102675:	5f                   	pop    %edi
80102676:	5d                   	pop    %ebp
80102677:	c3                   	ret    

80102678 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102678:	55                   	push   %ebp
80102679:	89 e5                	mov    %esp,%ebp
8010267b:	56                   	push   %esi
8010267c:	53                   	push   %ebx
  struct buf *buf = bread(log.dev, log.start);
8010267d:	83 ec 08             	sub    $0x8,%esp
80102680:	ff 35 b4 16 11 80    	pushl  0x801116b4
80102686:	ff 35 c4 16 11 80    	pushl  0x801116c4
8010268c:	e8 23 da ff ff       	call   801000b4 <bread>
80102691:	89 c6                	mov    %eax,%esi
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102693:	8b 1d c8 16 11 80    	mov    0x801116c8,%ebx
80102699:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
8010269c:	83 c4 10             	add    $0x10,%esp
8010269f:	85 db                	test   %ebx,%ebx
801026a1:	7e 16                	jle    801026b9 <write_head+0x41>
801026a3:	c1 e3 02             	shl    $0x2,%ebx
801026a6:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
801026a8:	8b 8a cc 16 11 80    	mov    -0x7feee934(%edx),%ecx
801026ae:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
801026b2:	83 c2 04             	add    $0x4,%edx
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
801026b5:	39 da                	cmp    %ebx,%edx
801026b7:	75 ef                	jne    801026a8 <write_head+0x30>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
801026b9:	83 ec 0c             	sub    $0xc,%esp
801026bc:	56                   	push   %esi
801026bd:	e8 be da ff ff       	call   80100180 <bwrite>
  brelse(buf);
801026c2:	89 34 24             	mov    %esi,(%esp)
801026c5:	e8 ee da ff ff       	call   801001b8 <brelse>
}
801026ca:	8d 65 f8             	lea    -0x8(%ebp),%esp
801026cd:	5b                   	pop    %ebx
801026ce:	5e                   	pop    %esi
801026cf:	5d                   	pop    %ebp
801026d0:	c3                   	ret    
801026d1:	8d 76 00             	lea    0x0(%esi),%esi

801026d4 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
801026d4:	55                   	push   %ebp
801026d5:	89 e5                	mov    %esp,%ebp
801026d7:	53                   	push   %ebx
801026d8:	83 ec 2c             	sub    $0x2c,%esp
801026db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
801026de:	68 00 6a 10 80       	push   $0x80106a00
801026e3:	68 80 16 11 80       	push   $0x80111680
801026e8:	e8 43 15 00 00       	call   80103c30 <initlock>
  readsb(dev, &sb);
801026ed:	58                   	pop    %eax
801026ee:	5a                   	pop    %edx
801026ef:	8d 45 dc             	lea    -0x24(%ebp),%eax
801026f2:	50                   	push   %eax
801026f3:	53                   	push   %ebx
801026f4:	e8 97 eb ff ff       	call   80101290 <readsb>
  log.start = sb.logstart;
801026f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
801026fc:	a3 b4 16 11 80       	mov    %eax,0x801116b4
  log.size = sb.nlog;
80102701:	8b 55 e8             	mov    -0x18(%ebp),%edx
80102704:	89 15 b8 16 11 80    	mov    %edx,0x801116b8
  log.dev = dev;
8010270a:	89 1d c4 16 11 80    	mov    %ebx,0x801116c4

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102710:	59                   	pop    %ecx
80102711:	5a                   	pop    %edx
80102712:	50                   	push   %eax
80102713:	53                   	push   %ebx
80102714:	e8 9b d9 ff ff       	call   801000b4 <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102719:	8b 58 5c             	mov    0x5c(%eax),%ebx
8010271c:	89 1d c8 16 11 80    	mov    %ebx,0x801116c8
  for (i = 0; i < log.lh.n; i++) {
80102722:	83 c4 10             	add    $0x10,%esp
80102725:	85 db                	test   %ebx,%ebx
80102727:	7e 18                	jle    80102741 <initlog+0x6d>
80102729:	c1 e3 02             	shl    $0x2,%ebx
8010272c:	31 d2                	xor    %edx,%edx
8010272e:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102730:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102734:	89 8a cc 16 11 80    	mov    %ecx,-0x7feee934(%edx)
8010273a:	83 c2 04             	add    $0x4,%edx
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
8010273d:	39 da                	cmp    %ebx,%edx
8010273f:	75 ef                	jne    80102730 <initlog+0x5c>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
80102741:	83 ec 0c             	sub    $0xc,%esp
80102744:	50                   	push   %eax
80102745:	e8 6e da ff ff       	call   801001b8 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
8010274a:	e8 a1 fe ff ff       	call   801025f0 <install_trans>
  log.lh.n = 0;
8010274f:	c7 05 c8 16 11 80 00 	movl   $0x0,0x801116c8
80102756:	00 00 00 
  write_head(); // clear the log
80102759:	e8 1a ff ff ff       	call   80102678 <write_head>
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
  recover_from_log();
}
8010275e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102761:	c9                   	leave  
80102762:	c3                   	ret    
80102763:	90                   	nop

80102764 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102764:	55                   	push   %ebp
80102765:	89 e5                	mov    %esp,%ebp
80102767:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
8010276a:	68 80 16 11 80       	push   $0x80111680
8010276f:	e8 f8 15 00 00       	call   80103d6c <acquire>
80102774:	83 c4 10             	add    $0x10,%esp
80102777:	eb 18                	jmp    80102791 <begin_op+0x2d>
80102779:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
8010277c:	83 ec 08             	sub    $0x8,%esp
8010277f:	68 80 16 11 80       	push   $0x80111680
80102784:	68 80 16 11 80       	push   $0x80111680
80102789:	e8 6e 10 00 00       	call   801037fc <sleep>
8010278e:	83 c4 10             	add    $0x10,%esp
void
begin_op(void)
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
80102791:	a1 c0 16 11 80       	mov    0x801116c0,%eax
80102796:	85 c0                	test   %eax,%eax
80102798:	75 e2                	jne    8010277c <begin_op+0x18>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
8010279a:	a1 bc 16 11 80       	mov    0x801116bc,%eax
8010279f:	8d 50 01             	lea    0x1(%eax),%edx
801027a2:	8d 04 92             	lea    (%edx,%edx,4),%eax
801027a5:	01 c0                	add    %eax,%eax
801027a7:	03 05 c8 16 11 80    	add    0x801116c8,%eax
801027ad:	83 f8 1e             	cmp    $0x1e,%eax
801027b0:	7f ca                	jg     8010277c <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
801027b2:	89 15 bc 16 11 80    	mov    %edx,0x801116bc
      release(&log.lock);
801027b8:	83 ec 0c             	sub    $0xc,%esp
801027bb:	68 80 16 11 80       	push   $0x80111680
801027c0:	e8 3f 16 00 00       	call   80103e04 <release>
      break;
    }
  }
}
801027c5:	83 c4 10             	add    $0x10,%esp
801027c8:	c9                   	leave  
801027c9:	c3                   	ret    
801027ca:	66 90                	xchg   %ax,%ax

801027cc <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
801027cc:	55                   	push   %ebp
801027cd:	89 e5                	mov    %esp,%ebp
801027cf:	57                   	push   %edi
801027d0:	56                   	push   %esi
801027d1:	53                   	push   %ebx
801027d2:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
801027d5:	68 80 16 11 80       	push   $0x80111680
801027da:	e8 8d 15 00 00       	call   80103d6c <acquire>
  log.outstanding -= 1;
801027df:	a1 bc 16 11 80       	mov    0x801116bc,%eax
801027e4:	48                   	dec    %eax
801027e5:	a3 bc 16 11 80       	mov    %eax,0x801116bc
  if(log.committing)
801027ea:	83 c4 10             	add    $0x10,%esp
801027ed:	8b 1d c0 16 11 80    	mov    0x801116c0,%ebx
801027f3:	85 db                	test   %ebx,%ebx
801027f5:	0f 85 15 01 00 00    	jne    80102910 <end_op+0x144>
    panic("log.committing");
  if(log.outstanding == 0){
801027fb:	85 c0                	test   %eax,%eax
801027fd:	0f 85 e9 00 00 00    	jne    801028ec <end_op+0x120>
    do_commit = 1;
    log.committing = 1;
80102803:	c7 05 c0 16 11 80 01 	movl   $0x1,0x801116c0
8010280a:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
8010280d:	83 ec 0c             	sub    $0xc,%esp
80102810:	68 80 16 11 80       	push   $0x80111680
80102815:	e8 ea 15 00 00       	call   80103e04 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
8010281a:	83 c4 10             	add    $0x10,%esp
8010281d:	8b 0d c8 16 11 80    	mov    0x801116c8,%ecx
80102823:	85 c9                	test   %ecx,%ecx
80102825:	0f 8e 86 00 00 00    	jle    801028b1 <end_op+0xe5>
8010282b:	31 db                	xor    %ebx,%ebx
8010282d:	8d 76 00             	lea    0x0(%esi),%esi
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102830:	83 ec 08             	sub    $0x8,%esp
80102833:	a1 b4 16 11 80       	mov    0x801116b4,%eax
80102838:	01 d8                	add    %ebx,%eax
8010283a:	40                   	inc    %eax
8010283b:	50                   	push   %eax
8010283c:	ff 35 c4 16 11 80    	pushl  0x801116c4
80102842:	e8 6d d8 ff ff       	call   801000b4 <bread>
80102847:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102849:	58                   	pop    %eax
8010284a:	5a                   	pop    %edx
8010284b:	ff 34 9d cc 16 11 80 	pushl  -0x7feee934(,%ebx,4)
80102852:	ff 35 c4 16 11 80    	pushl  0x801116c4
80102858:	e8 57 d8 ff ff       	call   801000b4 <bread>
8010285d:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
8010285f:	83 c4 0c             	add    $0xc,%esp
80102862:	68 00 02 00 00       	push   $0x200
80102867:	8d 40 5c             	lea    0x5c(%eax),%eax
8010286a:	50                   	push   %eax
8010286b:	8d 46 5c             	lea    0x5c(%esi),%eax
8010286e:	50                   	push   %eax
8010286f:	e8 6c 16 00 00       	call   80103ee0 <memmove>
    bwrite(to);  // write the log
80102874:	89 34 24             	mov    %esi,(%esp)
80102877:	e8 04 d9 ff ff       	call   80100180 <bwrite>
    brelse(from);
8010287c:	89 3c 24             	mov    %edi,(%esp)
8010287f:	e8 34 d9 ff ff       	call   801001b8 <brelse>
    brelse(to);
80102884:	89 34 24             	mov    %esi,(%esp)
80102887:	e8 2c d9 ff ff       	call   801001b8 <brelse>
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
8010288c:	43                   	inc    %ebx
8010288d:	83 c4 10             	add    $0x10,%esp
80102890:	3b 1d c8 16 11 80    	cmp    0x801116c8,%ebx
80102896:	7c 98                	jl     80102830 <end_op+0x64>
static void
commit()
{
  if (log.lh.n > 0) {
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102898:	e8 db fd ff ff       	call   80102678 <write_head>
    install_trans(); // Now install writes to home locations
8010289d:	e8 4e fd ff ff       	call   801025f0 <install_trans>
    log.lh.n = 0;
801028a2:	c7 05 c8 16 11 80 00 	movl   $0x0,0x801116c8
801028a9:	00 00 00 
    write_head();    // Erase the transaction from the log
801028ac:	e8 c7 fd ff ff       	call   80102678 <write_head>

  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
801028b1:	83 ec 0c             	sub    $0xc,%esp
801028b4:	68 80 16 11 80       	push   $0x80111680
801028b9:	e8 ae 14 00 00       	call   80103d6c <acquire>
    log.committing = 0;
801028be:	c7 05 c0 16 11 80 00 	movl   $0x0,0x801116c0
801028c5:	00 00 00 
    wakeup(&log);
801028c8:	c7 04 24 80 16 11 80 	movl   $0x80111680,(%esp)
801028cf:	e8 d0 10 00 00       	call   801039a4 <wakeup>
    release(&log.lock);
801028d4:	c7 04 24 80 16 11 80 	movl   $0x80111680,(%esp)
801028db:	e8 24 15 00 00       	call   80103e04 <release>
801028e0:	83 c4 10             	add    $0x10,%esp
  }
}
801028e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801028e6:	5b                   	pop    %ebx
801028e7:	5e                   	pop    %esi
801028e8:	5f                   	pop    %edi
801028e9:	5d                   	pop    %ebp
801028ea:	c3                   	ret    
801028eb:	90                   	nop
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
801028ec:	83 ec 0c             	sub    $0xc,%esp
801028ef:	68 80 16 11 80       	push   $0x80111680
801028f4:	e8 ab 10 00 00       	call   801039a4 <wakeup>
  }
  release(&log.lock);
801028f9:	c7 04 24 80 16 11 80 	movl   $0x80111680,(%esp)
80102900:	e8 ff 14 00 00       	call   80103e04 <release>
80102905:	83 c4 10             	add    $0x10,%esp
    acquire(&log.lock);
    log.committing = 0;
    wakeup(&log);
    release(&log.lock);
  }
}
80102908:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010290b:	5b                   	pop    %ebx
8010290c:	5e                   	pop    %esi
8010290d:	5f                   	pop    %edi
8010290e:	5d                   	pop    %ebp
8010290f:	c3                   	ret    
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
80102910:	83 ec 0c             	sub    $0xc,%esp
80102913:	68 04 6a 10 80       	push   $0x80106a04
80102918:	e8 1b da ff ff       	call   80100338 <panic>
8010291d:	8d 76 00             	lea    0x0(%esi),%esi

80102920 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102920:	55                   	push   %ebp
80102921:	89 e5                	mov    %esp,%ebp
80102923:	53                   	push   %ebx
80102924:	52                   	push   %edx
80102925:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102928:	8b 15 c8 16 11 80    	mov    0x801116c8,%edx
8010292e:	83 fa 1d             	cmp    $0x1d,%edx
80102931:	0f 8f 85 00 00 00    	jg     801029bc <log_write+0x9c>
80102937:	a1 b8 16 11 80       	mov    0x801116b8,%eax
8010293c:	48                   	dec    %eax
8010293d:	39 c2                	cmp    %eax,%edx
8010293f:	7d 7b                	jge    801029bc <log_write+0x9c>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102941:	a1 bc 16 11 80       	mov    0x801116bc,%eax
80102946:	85 c0                	test   %eax,%eax
80102948:	7e 7f                	jle    801029c9 <log_write+0xa9>
    panic("log_write outside of trans");

  acquire(&log.lock);
8010294a:	83 ec 0c             	sub    $0xc,%esp
8010294d:	68 80 16 11 80       	push   $0x80111680
80102952:	e8 15 14 00 00       	call   80103d6c <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102957:	8b 15 c8 16 11 80    	mov    0x801116c8,%edx
8010295d:	83 c4 10             	add    $0x10,%esp
80102960:	83 fa 00             	cmp    $0x0,%edx
80102963:	7e 48                	jle    801029ad <log_write+0x8d>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102965:	8b 4b 08             	mov    0x8(%ebx),%ecx
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102968:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
8010296a:	3b 0d cc 16 11 80    	cmp    0x801116cc,%ecx
80102970:	75 0b                	jne    8010297d <log_write+0x5d>
80102972:	eb 30                	jmp    801029a4 <log_write+0x84>
80102974:	39 0c 85 cc 16 11 80 	cmp    %ecx,-0x7feee934(,%eax,4)
8010297b:	74 27                	je     801029a4 <log_write+0x84>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
8010297d:	40                   	inc    %eax
8010297e:	39 d0                	cmp    %edx,%eax
80102980:	75 f2                	jne    80102974 <log_write+0x54>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102982:	89 0c 95 cc 16 11 80 	mov    %ecx,-0x7feee934(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80102989:	42                   	inc    %edx
8010298a:	89 15 c8 16 11 80    	mov    %edx,0x801116c8
  b->flags |= B_DIRTY; // prevent eviction
80102990:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102993:	c7 45 08 80 16 11 80 	movl   $0x80111680,0x8(%ebp)
}
8010299a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010299d:	c9                   	leave  
  }
  log.lh.block[i] = b->blockno;
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
  release(&log.lock);
8010299e:	e9 61 14 00 00       	jmp    80103e04 <release>
801029a3:	90                   	nop
  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
801029a4:	89 0c 85 cc 16 11 80 	mov    %ecx,-0x7feee934(,%eax,4)
801029ab:	eb e3                	jmp    80102990 <log_write+0x70>
801029ad:	8b 43 08             	mov    0x8(%ebx),%eax
801029b0:	a3 cc 16 11 80       	mov    %eax,0x801116cc
  if (i == log.lh.n)
801029b5:	75 d9                	jne    80102990 <log_write+0x70>
801029b7:	eb d0                	jmp    80102989 <log_write+0x69>
801029b9:	8d 76 00             	lea    0x0(%esi),%esi
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
801029bc:	83 ec 0c             	sub    $0xc,%esp
801029bf:	68 13 6a 10 80       	push   $0x80106a13
801029c4:	e8 6f d9 ff ff       	call   80100338 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
801029c9:	83 ec 0c             	sub    $0xc,%esp
801029cc:	68 29 6a 10 80       	push   $0x80106a29
801029d1:	e8 62 d9 ff ff       	call   80100338 <panic>
801029d6:	66 90                	xchg   %ax,%ax

801029d8 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801029d8:	55                   	push   %ebp
801029d9:	89 e5                	mov    %esp,%ebp
801029db:	53                   	push   %ebx
801029dc:	50                   	push   %eax
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
801029dd:	e8 aa 08 00 00       	call   8010328c <cpuid>
801029e2:	89 c3                	mov    %eax,%ebx
801029e4:	e8 a3 08 00 00       	call   8010328c <cpuid>
801029e9:	52                   	push   %edx
801029ea:	53                   	push   %ebx
801029eb:	50                   	push   %eax
801029ec:	68 44 6a 10 80       	push   $0x80106a44
801029f1:	e8 02 dc ff ff       	call   801005f8 <cprintf>
  idtinit();       // load idt register
801029f6:	e8 ed 24 00 00       	call   80104ee8 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
801029fb:	e8 14 08 00 00       	call   80103214 <mycpu>
80102a00:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102a02:	b8 01 00 00 00       	mov    $0x1,%eax
80102a07:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102a0e:	e8 35 0b 00 00       	call   80103548 <scheduler>
80102a13:	90                   	nop

80102a14 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80102a14:	55                   	push   %ebp
80102a15:	89 e5                	mov    %esp,%ebp
80102a17:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102a1a:	e8 31 35 00 00       	call   80105f50 <switchkvm>
  seginit();
80102a1f:	e8 40 34 00 00       	call   80105e64 <seginit>
  lapicinit();
80102a24:	e8 8f f8 ff ff       	call   801022b8 <lapicinit>
  mpmain();
80102a29:	e8 aa ff ff ff       	call   801029d8 <mpmain>
80102a2e:	66 90                	xchg   %ax,%ax

80102a30 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80102a30:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102a34:	83 e4 f0             	and    $0xfffffff0,%esp
80102a37:	ff 71 fc             	pushl  -0x4(%ecx)
80102a3a:	55                   	push   %ebp
80102a3b:	89 e5                	mov    %esp,%ebp
80102a3d:	53                   	push   %ebx
80102a3e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102a3f:	83 ec 08             	sub    $0x8,%esp
80102a42:	68 00 00 40 80       	push   $0x80400000
80102a47:	68 a8 44 11 80       	push   $0x801144a8
80102a4c:	e8 77 f6 ff ff       	call   801020c8 <kinit1>
  kvmalloc();      // kernel page table
80102a51:	e8 22 39 00 00       	call   80106378 <kvmalloc>
  mpinit();        // detect other processors
80102a56:	e8 59 01 00 00       	call   80102bb4 <mpinit>
  lapicinit();     // interrupt controller
80102a5b:	e8 58 f8 ff ff       	call   801022b8 <lapicinit>
  seginit();       // segment descriptors
80102a60:	e8 ff 33 00 00       	call   80105e64 <seginit>
  picinit();       // disable pic
80102a65:	e8 ea 02 00 00       	call   80102d54 <picinit>
  ioapicinit();    // another interrupt controller
80102a6a:	e8 b1 f4 ff ff       	call   80101f20 <ioapicinit>
  consoleinit();   // console hardware
80102a6f:	e8 54 de ff ff       	call   801008c8 <consoleinit>
  uartinit();      // serial port
80102a74:	e8 1b 27 00 00       	call   80105194 <uartinit>
  pinit();         // process table
80102a79:	e8 7a 07 00 00       	call   801031f8 <pinit>
  tvinit();        // trap vectors
80102a7e:	e8 dd 23 00 00       	call   80104e60 <tvinit>
  binit();         // buffer cache
80102a83:	e8 ac d5 ff ff       	call   80100034 <binit>
  fileinit();      // file table
80102a88:	e8 cf e1 ff ff       	call   80100c5c <fileinit>
  ideinit();       // disk 
80102a8d:	e8 a6 f2 ff ff       	call   80101d38 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102a92:	83 c4 0c             	add    $0xc,%esp
80102a95:	68 8a 00 00 00       	push   $0x8a
80102a9a:	68 8c 94 10 80       	push   $0x8010948c
80102a9f:	68 00 70 00 80       	push   $0x80007000
80102aa4:	e8 37 14 00 00       	call   80103ee0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102aa9:	a1 00 1d 11 80       	mov    0x80111d00,%eax
80102aae:	8d 14 80             	lea    (%eax,%eax,4),%edx
80102ab1:	01 d2                	add    %edx,%edx
80102ab3:	01 d0                	add    %edx,%eax
80102ab5:	c1 e0 04             	shl    $0x4,%eax
80102ab8:	05 80 17 11 80       	add    $0x80111780,%eax
80102abd:	83 c4 10             	add    $0x10,%esp
80102ac0:	bb 80 17 11 80       	mov    $0x80111780,%ebx
80102ac5:	39 d8                	cmp    %ebx,%eax
80102ac7:	76 6b                	jbe    80102b34 <main+0x104>
80102ac9:	8d 76 00             	lea    0x0(%esi),%esi
    if(c == mycpu())  // We've started already.
80102acc:	e8 43 07 00 00       	call   80103214 <mycpu>
80102ad1:	39 d8                	cmp    %ebx,%eax
80102ad3:	74 41                	je     80102b16 <main+0xe6>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102ad5:	e8 a6 f6 ff ff       	call   80102180 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
80102ada:	05 00 10 00 00       	add    $0x1000,%eax
80102adf:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void(**)(void))(code-8) = mpenter;
80102ae4:	c7 05 f8 6f 00 80 14 	movl   $0x80102a14,0x80006ff8
80102aeb:	2a 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102aee:	c7 05 f4 6f 00 80 00 	movl   $0x108000,0x80006ff4
80102af5:	80 10 00 

    lapicstartap(c->apicid, V2P(code));
80102af8:	83 ec 08             	sub    $0x8,%esp
80102afb:	68 00 70 00 00       	push   $0x7000
80102b00:	0f b6 03             	movzbl (%ebx),%eax
80102b03:	50                   	push   %eax
80102b04:	e8 cf f8 ff ff       	call   801023d8 <lapicstartap>
80102b09:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102b0c:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102b12:	85 c0                	test   %eax,%eax
80102b14:	74 f6                	je     80102b0c <main+0xdc>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80102b16:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80102b1c:	a1 00 1d 11 80       	mov    0x80111d00,%eax
80102b21:	8d 14 80             	lea    (%eax,%eax,4),%edx
80102b24:	01 d2                	add    %edx,%edx
80102b26:	01 d0                	add    %edx,%eax
80102b28:	c1 e0 04             	shl    $0x4,%eax
80102b2b:	05 80 17 11 80       	add    $0x80111780,%eax
80102b30:	39 c3                	cmp    %eax,%ebx
80102b32:	72 98                	jb     80102acc <main+0x9c>
  tvinit();        // trap vectors
  binit();         // buffer cache
  fileinit();      // file table
  ideinit();       // disk 
  startothers();   // start other processors
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102b34:	83 ec 08             	sub    $0x8,%esp
80102b37:	68 00 00 00 8e       	push   $0x8e000000
80102b3c:	68 00 00 40 80       	push   $0x80400000
80102b41:	e8 e6 f5 ff ff       	call   8010212c <kinit2>
  userinit();      // first user process
80102b46:	e8 95 07 00 00       	call   801032e0 <userinit>
  mpmain();        // finish this processor's setup
80102b4b:	e8 88 fe ff ff       	call   801029d8 <mpmain>

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
80102b56:	83 ec 0c             	sub    $0xc,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
80102b59:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
  e = addr+len;
80102b5f:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
  for(p = addr; p < e; p += sizeof(struct mp))
80102b62:	39 de                	cmp    %ebx,%esi
80102b64:	72 0b                	jb     80102b71 <mpsearch1+0x21>
80102b66:	eb 40                	jmp    80102ba8 <mpsearch1+0x58>
80102b68:	8d 7e 10             	lea    0x10(%esi),%edi
80102b6b:	89 fe                	mov    %edi,%esi
80102b6d:	39 fb                	cmp    %edi,%ebx
80102b6f:	76 37                	jbe    80102ba8 <mpsearch1+0x58>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102b71:	50                   	push   %eax
80102b72:	6a 04                	push   $0x4
80102b74:	68 58 6a 10 80       	push   $0x80106a58
80102b79:	56                   	push   %esi
80102b7a:	e8 19 13 00 00       	call   80103e98 <memcmp>
80102b7f:	83 c4 10             	add    $0x10,%esp
80102b82:	85 c0                	test   %eax,%eax
80102b84:	75 e2                	jne    80102b68 <mpsearch1+0x18>
80102b86:	89 f2                	mov    %esi,%edx
80102b88:	8d 7e 10             	lea    0x10(%esi),%edi
80102b8b:	31 c9                	xor    %ecx,%ecx
80102b8d:	8d 76 00             	lea    0x0(%esi),%esi
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
80102b90:	0f b6 02             	movzbl (%edx),%eax
80102b93:	01 c1                	add    %eax,%ecx
80102b95:	42                   	inc    %edx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80102b96:	39 fa                	cmp    %edi,%edx
80102b98:	75 f6                	jne    80102b90 <mpsearch1+0x40>
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102b9a:	84 c9                	test   %cl,%cl
80102b9c:	75 cd                	jne    80102b6b <mpsearch1+0x1b>
80102b9e:	89 f0                	mov    %esi,%eax
      return (struct mp*)p;
  return 0;
}
80102ba0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ba3:	5b                   	pop    %ebx
80102ba4:	5e                   	pop    %esi
80102ba5:	5f                   	pop    %edi
80102ba6:	5d                   	pop    %ebp
80102ba7:	c3                   	ret    
  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80102ba8:	31 c0                	xor    %eax,%eax
}
80102baa:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102bad:	5b                   	pop    %ebx
80102bae:	5e                   	pop    %esi
80102baf:	5f                   	pop    %edi
80102bb0:	5d                   	pop    %ebp
80102bb1:	c3                   	ret    
80102bb2:	66 90                	xchg   %ax,%ax

80102bb4 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80102bb4:	55                   	push   %ebp
80102bb5:	89 e5                	mov    %esp,%ebp
80102bb7:	57                   	push   %edi
80102bb8:	56                   	push   %esi
80102bb9:	53                   	push   %ebx
80102bba:	83 ec 1c             	sub    $0x1c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80102bbd:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80102bc4:	c1 e0 08             	shl    $0x8,%eax
80102bc7:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80102bce:	09 d0                	or     %edx,%eax
80102bd0:	c1 e0 04             	shl    $0x4,%eax
80102bd3:	75 1b                	jne    80102bf0 <mpinit+0x3c>
    if((mp = mpsearch1(p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
80102bd5:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80102bdc:	c1 e0 08             	shl    $0x8,%eax
80102bdf:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80102be6:	09 d0                	or     %edx,%eax
80102be8:	c1 e0 0a             	shl    $0xa,%eax
80102beb:	2d 00 04 00 00       	sub    $0x400,%eax
80102bf0:	ba 00 04 00 00       	mov    $0x400,%edx
80102bf5:	e8 56 ff ff ff       	call   80102b50 <mpsearch1>
80102bfa:	85 c0                	test   %eax,%eax
80102bfc:	0f 84 13 01 00 00    	je     80102d15 <mpinit+0x161>
80102c02:	89 c7                	mov    %eax,%edi
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80102c04:	8b 5f 04             	mov    0x4(%edi),%ebx
80102c07:	85 db                	test   %ebx,%ebx
80102c09:	0f 84 1f 01 00 00    	je     80102d2e <mpinit+0x17a>
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80102c0f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102c15:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80102c18:	52                   	push   %edx
80102c19:	6a 04                	push   $0x4
80102c1b:	68 5d 6a 10 80       	push   $0x80106a5d
80102c20:	50                   	push   %eax
80102c21:	e8 72 12 00 00       	call   80103e98 <memcmp>
80102c26:	83 c4 10             	add    $0x10,%esp
80102c29:	85 c0                	test   %eax,%eax
80102c2b:	0f 85 fd 00 00 00    	jne    80102d2e <mpinit+0x17a>
    return 0;
  if(conf->version != 1 && conf->version != 4)
80102c31:	8a 83 06 00 00 80    	mov    -0x7ffffffa(%ebx),%al
80102c37:	3c 01                	cmp    $0x1,%al
80102c39:	74 08                	je     80102c43 <mpinit+0x8f>
80102c3b:	3c 04                	cmp    $0x4,%al
80102c3d:	0f 85 eb 00 00 00    	jne    80102d2e <mpinit+0x17a>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
80102c43:	0f b7 83 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%eax
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80102c4a:	85 c0                	test   %eax,%eax
80102c4c:	74 1d                	je     80102c6b <mpinit+0xb7>
80102c4e:	31 c9                	xor    %ecx,%ecx
80102c50:	31 d2                	xor    %edx,%edx
80102c52:	66 90                	xchg   %ax,%ax
    sum += addr[i];
80102c54:	0f b6 b4 13 00 00 00 	movzbl -0x80000000(%ebx,%edx,1),%esi
80102c5b:	80 
80102c5c:	01 f1                	add    %esi,%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80102c5e:	42                   	inc    %edx
80102c5f:	39 d0                	cmp    %edx,%eax
80102c61:	7f f1                	jg     80102c54 <mpinit+0xa0>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
80102c63:	84 c9                	test   %cl,%cl
80102c65:	0f 85 c3 00 00 00    	jne    80102d2e <mpinit+0x17a>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80102c6b:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80102c6e:	85 f6                	test   %esi,%esi
80102c70:	0f 84 b8 00 00 00    	je     80102d2e <mpinit+0x17a>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80102c76:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80102c7c:	a3 7c 16 11 80       	mov    %eax,0x8011167c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80102c81:	8d 93 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%edx
80102c87:	0f b7 8b 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%ecx
80102c8e:	01 f1                	add    %esi,%ecx
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
80102c90:	bb 01 00 00 00       	mov    $0x1,%ebx
80102c95:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80102c98:	39 d1                	cmp    %edx,%ecx
80102c9a:	76 1b                	jbe    80102cb7 <mpinit+0x103>
80102c9c:	0f b6 02             	movzbl (%edx),%eax
    switch(*p){
80102c9f:	3c 04                	cmp    $0x4,%al
80102ca1:	0f 87 a1 00 00 00    	ja     80102d48 <mpinit+0x194>
80102ca7:	ff 24 85 9c 6a 10 80 	jmp    *-0x7fef9564(,%eax,4)
80102cae:	66 90                	xchg   %ax,%ax
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80102cb0:	83 c2 08             	add    $0x8,%edx

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80102cb3:	39 d1                	cmp    %edx,%ecx
80102cb5:	77 e5                	ja     80102c9c <mpinit+0xe8>
80102cb7:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80102cba:	85 db                	test   %ebx,%ebx
80102cbc:	74 7d                	je     80102d3b <mpinit+0x187>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
80102cbe:	80 7f 0c 00          	cmpb   $0x0,0xc(%edi)
80102cc2:	74 12                	je     80102cd6 <mpinit+0x122>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102cc4:	ba 22 00 00 00       	mov    $0x22,%edx
80102cc9:	b0 70                	mov    $0x70,%al
80102ccb:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ccc:	ba 23 00 00 00       	mov    $0x23,%edx
80102cd1:	ec                   	in     (%dx),%al
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102cd2:	83 c8 01             	or     $0x1,%eax
80102cd5:	ee                   	out    %al,(%dx)
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
80102cd6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102cd9:	5b                   	pop    %ebx
80102cda:	5e                   	pop    %esi
80102cdb:	5f                   	pop    %edi
80102cdc:	5d                   	pop    %ebp
80102cdd:	c3                   	ret    
80102cde:	66 90                	xchg   %ax,%ax
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
80102ce0:	a1 00 1d 11 80       	mov    0x80111d00,%eax
80102ce5:	83 f8 07             	cmp    $0x7,%eax
80102ce8:	7f 19                	jg     80102d03 <mpinit+0x14f>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80102cea:	8d 34 80             	lea    (%eax,%eax,4),%esi
80102ced:	01 f6                	add    %esi,%esi
80102cef:	01 c6                	add    %eax,%esi
80102cf1:	c1 e6 04             	shl    $0x4,%esi
80102cf4:	8a 5a 01             	mov    0x1(%edx),%bl
80102cf7:	88 9e 80 17 11 80    	mov    %bl,-0x7feee880(%esi)
        ncpu++;
80102cfd:	40                   	inc    %eax
80102cfe:	a3 00 1d 11 80       	mov    %eax,0x80111d00
      }
      p += sizeof(struct mpproc);
80102d03:	83 c2 14             	add    $0x14,%edx
      continue;
80102d06:	eb 90                	jmp    80102c98 <mpinit+0xe4>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
80102d08:	8a 42 01             	mov    0x1(%edx),%al
80102d0b:	a2 60 17 11 80       	mov    %al,0x80111760
      p += sizeof(struct mpioapic);
80102d10:	83 c2 08             	add    $0x8,%edx
      continue;
80102d13:	eb 83                	jmp    80102c98 <mpinit+0xe4>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
80102d15:	ba 00 00 01 00       	mov    $0x10000,%edx
80102d1a:	b8 00 00 0f 00       	mov    $0xf0000,%eax
80102d1f:	e8 2c fe ff ff       	call   80102b50 <mpsearch1>
80102d24:	89 c7                	mov    %eax,%edi
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80102d26:	85 c0                	test   %eax,%eax
80102d28:	0f 85 d6 fe ff ff    	jne    80102c04 <mpinit+0x50>
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
80102d2e:	83 ec 0c             	sub    $0xc,%esp
80102d31:	68 62 6a 10 80       	push   $0x80106a62
80102d36:	e8 fd d5 ff ff       	call   80100338 <panic>
      ismp = 0;
      break;
    }
  }
  if(!ismp)
    panic("Didn't find a suitable machine");
80102d3b:	83 ec 0c             	sub    $0xc,%esp
80102d3e:	68 7c 6a 10 80       	push   $0x80106a7c
80102d43:	e8 f0 d5 ff ff       	call   80100338 <panic>
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      ismp = 0;
80102d48:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80102d4f:	e9 4b ff ff ff       	jmp    80102c9f <mpinit+0xeb>

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
80102d5f:	ba a1 00 00 00       	mov    $0xa1,%edx
80102d64:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80102d65:	5d                   	pop    %ebp
80102d66:	c3                   	ret    
80102d67:	90                   	nop

80102d68 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80102d68:	55                   	push   %ebp
80102d69:	89 e5                	mov    %esp,%ebp
80102d6b:	56                   	push   %esi
80102d6c:	53                   	push   %ebx
80102d6d:	83 ec 10             	sub    $0x10,%esp
80102d70:	8b 75 08             	mov    0x8(%ebp),%esi
80102d73:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
80102d76:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80102d7c:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80102d82:	e8 f1 de ff ff       	call   80100c78 <filealloc>
80102d87:	89 06                	mov    %eax,(%esi)
80102d89:	85 c0                	test   %eax,%eax
80102d8b:	0f 84 a9 00 00 00    	je     80102e3a <pipealloc+0xd2>
80102d91:	e8 e2 de ff ff       	call   80100c78 <filealloc>
80102d96:	89 03                	mov    %eax,(%ebx)
80102d98:	85 c0                	test   %eax,%eax
80102d9a:	0f 84 88 00 00 00    	je     80102e28 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80102da0:	e8 db f3 ff ff       	call   80102180 <kalloc>
80102da5:	85 c0                	test   %eax,%eax
80102da7:	0f 84 ab 00 00 00    	je     80102e58 <pipealloc+0xf0>
    goto bad;
  p->readopen = 1;
80102dad:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80102db4:	00 00 00 
  p->writeopen = 1;
80102db7:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80102dbe:	00 00 00 
  p->nwrite = 0;
80102dc1:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80102dc8:	00 00 00 
  p->nread = 0;
80102dcb:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80102dd2:	00 00 00 
  initlock(&p->lock, "pipe");
80102dd5:	83 ec 08             	sub    $0x8,%esp
80102dd8:	68 b0 6a 10 80       	push   $0x80106ab0
80102ddd:	50                   	push   %eax
80102dde:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102de1:	e8 4a 0e 00 00       	call   80103c30 <initlock>
  (*f0)->type = FD_PIPE;
80102de6:	8b 16                	mov    (%esi),%edx
80102de8:	c7 02 01 00 00 00    	movl   $0x1,(%edx)
  (*f0)->readable = 1;
80102dee:	8b 16                	mov    (%esi),%edx
80102df0:	c6 42 08 01          	movb   $0x1,0x8(%edx)
  (*f0)->writable = 0;
80102df4:	8b 16                	mov    (%esi),%edx
80102df6:	c6 42 09 00          	movb   $0x0,0x9(%edx)
  (*f0)->pipe = p;
80102dfa:	8b 16                	mov    (%esi),%edx
80102dfc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102dff:	89 42 0c             	mov    %eax,0xc(%edx)
  (*f1)->type = FD_PIPE;
80102e02:	8b 13                	mov    (%ebx),%edx
80102e04:	c7 02 01 00 00 00    	movl   $0x1,(%edx)
  (*f1)->readable = 0;
80102e0a:	8b 13                	mov    (%ebx),%edx
80102e0c:	c6 42 08 00          	movb   $0x0,0x8(%edx)
  (*f1)->writable = 1;
80102e10:	8b 13                	mov    (%ebx),%edx
80102e12:	c6 42 09 01          	movb   $0x1,0x9(%edx)
  (*f1)->pipe = p;
80102e16:	8b 13                	mov    (%ebx),%edx
80102e18:	89 42 0c             	mov    %eax,0xc(%edx)
  return 0;
80102e1b:	83 c4 10             	add    $0x10,%esp
80102e1e:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80102e20:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102e23:	5b                   	pop    %ebx
80102e24:	5e                   	pop    %esi
80102e25:	5d                   	pop    %ebp
80102e26:	c3                   	ret    
80102e27:	90                   	nop

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
80102e28:	8b 06                	mov    (%esi),%eax
80102e2a:	85 c0                	test   %eax,%eax
80102e2c:	74 1e                	je     80102e4c <pipealloc+0xe4>
    fileclose(*f0);
80102e2e:	83 ec 0c             	sub    $0xc,%esp
80102e31:	50                   	push   %eax
80102e32:	e8 e9 de ff ff       	call   80100d20 <fileclose>
80102e37:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80102e3a:	8b 03                	mov    (%ebx),%eax
80102e3c:	85 c0                	test   %eax,%eax
80102e3e:	74 0c                	je     80102e4c <pipealloc+0xe4>
    fileclose(*f1);
80102e40:	83 ec 0c             	sub    $0xc,%esp
80102e43:	50                   	push   %eax
80102e44:	e8 d7 de ff ff       	call   80100d20 <fileclose>
80102e49:	83 c4 10             	add    $0x10,%esp
  return -1;
80102e4c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102e51:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102e54:	5b                   	pop    %ebx
80102e55:	5e                   	pop    %esi
80102e56:	5d                   	pop    %ebp
80102e57:	c3                   	ret    

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
80102e58:	8b 06                	mov    (%esi),%eax
80102e5a:	85 c0                	test   %eax,%eax
80102e5c:	75 d0                	jne    80102e2e <pipealloc+0xc6>
80102e5e:	eb da                	jmp    80102e3a <pipealloc+0xd2>

80102e60 <pipeclose>:
  return -1;
}

void
pipeclose(struct pipe *p, int writable)
{
80102e60:	55                   	push   %ebp
80102e61:	89 e5                	mov    %esp,%ebp
80102e63:	56                   	push   %esi
80102e64:	53                   	push   %ebx
80102e65:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102e68:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
80102e6b:	83 ec 0c             	sub    $0xc,%esp
80102e6e:	53                   	push   %ebx
80102e6f:	e8 f8 0e 00 00       	call   80103d6c <acquire>
  if(writable){
80102e74:	83 c4 10             	add    $0x10,%esp
80102e77:	85 f6                	test   %esi,%esi
80102e79:	74 41                	je     80102ebc <pipeclose+0x5c>
    p->writeopen = 0;
80102e7b:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
80102e82:	00 00 00 
    wakeup(&p->nread);
80102e85:	83 ec 0c             	sub    $0xc,%esp
80102e88:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80102e8e:	50                   	push   %eax
80102e8f:	e8 10 0b 00 00       	call   801039a4 <wakeup>
80102e94:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80102e97:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
80102e9d:	85 d2                	test   %edx,%edx
80102e9f:	75 0a                	jne    80102eab <pipeclose+0x4b>
80102ea1:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80102ea7:	85 c0                	test   %eax,%eax
80102ea9:	74 31                	je     80102edc <pipeclose+0x7c>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80102eab:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80102eae:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102eb1:	5b                   	pop    %ebx
80102eb2:	5e                   	pop    %esi
80102eb3:	5d                   	pop    %ebp
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80102eb4:	e9 4b 0f 00 00       	jmp    80103e04 <release>
80102eb9:	8d 76 00             	lea    0x0(%esi),%esi
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
80102ebc:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80102ec3:	00 00 00 
    wakeup(&p->nwrite);
80102ec6:	83 ec 0c             	sub    $0xc,%esp
80102ec9:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80102ecf:	50                   	push   %eax
80102ed0:	e8 cf 0a 00 00       	call   801039a4 <wakeup>
80102ed5:	83 c4 10             	add    $0x10,%esp
80102ed8:	eb bd                	jmp    80102e97 <pipeclose+0x37>
80102eda:	66 90                	xchg   %ax,%ax
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
80102edc:	83 ec 0c             	sub    $0xc,%esp
80102edf:	53                   	push   %ebx
80102ee0:	e8 1f 0f 00 00       	call   80103e04 <release>
    kfree((char*)p);
80102ee5:	83 c4 10             	add    $0x10,%esp
80102ee8:	89 5d 08             	mov    %ebx,0x8(%ebp)
  } else
    release(&p->lock);
}
80102eeb:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102eee:	5b                   	pop    %ebx
80102eef:	5e                   	pop    %esi
80102ef0:	5d                   	pop    %ebp
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
80102ef1:	e9 fe f0 ff ff       	jmp    80101ff4 <kfree>
80102ef6:	66 90                	xchg   %ax,%ax

80102ef8 <pipewrite>:
}

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80102ef8:	55                   	push   %ebp
80102ef9:	89 e5                	mov    %esp,%ebp
80102efb:	57                   	push   %edi
80102efc:	56                   	push   %esi
80102efd:	53                   	push   %ebx
80102efe:	83 ec 28             	sub    $0x28,%esp
80102f01:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
80102f04:	53                   	push   %ebx
80102f05:	e8 62 0e 00 00       	call   80103d6c <acquire>
  for(i = 0; i < n; i++){
80102f0a:	83 c4 10             	add    $0x10,%esp
80102f0d:	8b 45 10             	mov    0x10(%ebp),%eax
80102f10:	85 c0                	test   %eax,%eax
80102f12:	0f 8e b6 00 00 00    	jle    80102fce <pipewrite+0xd6>
80102f18:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
80102f1e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102f21:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80102f24:	03 4d 10             	add    0x10(%ebp),%ecx
80102f27:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80102f2a:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80102f30:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80102f36:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
80102f3c:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
80102f42:	39 d0                	cmp    %edx,%eax
80102f44:	74 38                	je     80102f7e <pipewrite+0x86>
80102f46:	eb 59                	jmp    80102fa1 <pipewrite+0xa9>
      if(p->readopen == 0 || myproc()->killed){
80102f48:	e8 73 03 00 00       	call   801032c0 <myproc>
80102f4d:	8b 48 24             	mov    0x24(%eax),%ecx
80102f50:	85 c9                	test   %ecx,%ecx
80102f52:	75 34                	jne    80102f88 <pipewrite+0x90>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80102f54:	83 ec 0c             	sub    $0xc,%esp
80102f57:	57                   	push   %edi
80102f58:	e8 47 0a 00 00       	call   801039a4 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80102f5d:	58                   	pop    %eax
80102f5e:	5a                   	pop    %edx
80102f5f:	53                   	push   %ebx
80102f60:	56                   	push   %esi
80102f61:	e8 96 08 00 00       	call   801037fc <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80102f66:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80102f6c:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80102f72:	05 00 02 00 00       	add    $0x200,%eax
80102f77:	83 c4 10             	add    $0x10,%esp
80102f7a:	39 c2                	cmp    %eax,%edx
80102f7c:	75 26                	jne    80102fa4 <pipewrite+0xac>
      if(p->readopen == 0 || myproc()->killed){
80102f7e:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80102f84:	85 c0                	test   %eax,%eax
80102f86:	75 c0                	jne    80102f48 <pipewrite+0x50>
        release(&p->lock);
80102f88:	83 ec 0c             	sub    $0xc,%esp
80102f8b:	53                   	push   %ebx
80102f8c:	e8 73 0e 00 00       	call   80103e04 <release>
        return -1;
80102f91:	83 c4 10             	add    $0x10,%esp
80102f94:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80102f99:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f9c:	5b                   	pop    %ebx
80102f9d:	5e                   	pop    %esi
80102f9e:	5f                   	pop    %edi
80102f9f:	5d                   	pop    %ebp
80102fa0:	c3                   	ret    
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80102fa1:	89 c2                	mov    %eax,%edx
80102fa3:	90                   	nop
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80102fa4:	8d 42 01             	lea    0x1(%edx),%eax
80102fa7:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80102fad:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80102fb0:	8a 09                	mov    (%ecx),%cl
80102fb2:	88 4d df             	mov    %cl,-0x21(%ebp)
80102fb5:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80102fbb:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
80102fbf:	ff 45 e4             	incl   -0x1c(%ebp)
80102fc2:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
80102fc5:	3b 4d e0             	cmp    -0x20(%ebp),%ecx
80102fc8:	0f 85 68 ff ff ff    	jne    80102f36 <pipewrite+0x3e>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80102fce:	83 ec 0c             	sub    $0xc,%esp
80102fd1:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80102fd7:	50                   	push   %eax
80102fd8:	e8 c7 09 00 00       	call   801039a4 <wakeup>
  release(&p->lock);
80102fdd:	89 1c 24             	mov    %ebx,(%esp)
80102fe0:	e8 1f 0e 00 00       	call   80103e04 <release>
  return n;
80102fe5:	83 c4 10             	add    $0x10,%esp
80102fe8:	8b 45 10             	mov    0x10(%ebp),%eax
80102feb:	eb ac                	jmp    80102f99 <pipewrite+0xa1>
80102fed:	8d 76 00             	lea    0x0(%esi),%esi

80102ff0 <piperead>:
}

int
piperead(struct pipe *p, char *addr, int n)
{
80102ff0:	55                   	push   %ebp
80102ff1:	89 e5                	mov    %esp,%ebp
80102ff3:	57                   	push   %edi
80102ff4:	56                   	push   %esi
80102ff5:	53                   	push   %ebx
80102ff6:	83 ec 18             	sub    $0x18,%esp
80102ff9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102ffc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
80102fff:	53                   	push   %ebx
80103000:	e8 67 0d 00 00       	call   80103d6c <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103005:	83 c4 10             	add    $0x10,%esp
80103008:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010300e:	39 83 38 02 00 00    	cmp    %eax,0x238(%ebx)
80103014:	75 66                	jne    8010307c <piperead+0x8c>
80103016:	8b b3 40 02 00 00    	mov    0x240(%ebx),%esi
8010301c:	85 f6                	test   %esi,%esi
8010301e:	0f 84 bc 00 00 00    	je     801030e0 <piperead+0xf0>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103024:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
8010302a:	eb 29                	jmp    80103055 <piperead+0x65>
8010302c:	83 ec 08             	sub    $0x8,%esp
8010302f:	53                   	push   %ebx
80103030:	56                   	push   %esi
80103031:	e8 c6 07 00 00       	call   801037fc <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103036:	83 c4 10             	add    $0x10,%esp
80103039:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
8010303f:	39 83 34 02 00 00    	cmp    %eax,0x234(%ebx)
80103045:	75 35                	jne    8010307c <piperead+0x8c>
80103047:	8b 93 40 02 00 00    	mov    0x240(%ebx),%edx
8010304d:	85 d2                	test   %edx,%edx
8010304f:	0f 84 8b 00 00 00    	je     801030e0 <piperead+0xf0>
    if(myproc()->killed){
80103055:	e8 66 02 00 00       	call   801032c0 <myproc>
8010305a:	8b 48 24             	mov    0x24(%eax),%ecx
8010305d:	85 c9                	test   %ecx,%ecx
8010305f:	74 cb                	je     8010302c <piperead+0x3c>
      release(&p->lock);
80103061:	83 ec 0c             	sub    $0xc,%esp
80103064:	53                   	push   %ebx
80103065:	e8 9a 0d 00 00       	call   80103e04 <release>
      return -1;
8010306a:	83 c4 10             	add    $0x10,%esp
8010306d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103072:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103075:	5b                   	pop    %ebx
80103076:	5e                   	pop    %esi
80103077:	5f                   	pop    %edi
80103078:	5d                   	pop    %ebp
80103079:	c3                   	ret    
8010307a:	66 90                	xchg   %ax,%ax
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010307c:	8b 45 10             	mov    0x10(%ebp),%eax
8010307f:	85 c0                	test   %eax,%eax
80103081:	7e 5d                	jle    801030e0 <piperead+0xf0>
    if(p->nread == p->nwrite)
80103083:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103089:	31 c9                	xor    %ecx,%ecx
8010308b:	eb 11                	jmp    8010309e <piperead+0xae>
8010308d:	8d 76 00             	lea    0x0(%esi),%esi
80103090:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103096:	3b 83 38 02 00 00    	cmp    0x238(%ebx),%eax
8010309c:	74 4e                	je     801030ec <piperead+0xfc>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
8010309e:	8d 70 01             	lea    0x1(%eax),%esi
801030a1:	89 b3 34 02 00 00    	mov    %esi,0x234(%ebx)
801030a7:	25 ff 01 00 00       	and    $0x1ff,%eax
801030ac:	8a 44 03 34          	mov    0x34(%ebx,%eax,1),%al
801030b0:	88 04 0f             	mov    %al,(%edi,%ecx,1)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801030b3:	41                   	inc    %ecx
801030b4:	39 4d 10             	cmp    %ecx,0x10(%ebp)
801030b7:	75 d7                	jne    80103090 <piperead+0xa0>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801030b9:	83 ec 0c             	sub    $0xc,%esp
801030bc:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
801030c2:	50                   	push   %eax
801030c3:	e8 dc 08 00 00       	call   801039a4 <wakeup>
  release(&p->lock);
801030c8:	89 1c 24             	mov    %ebx,(%esp)
801030cb:	e8 34 0d 00 00       	call   80103e04 <release>
  return i;
801030d0:	83 c4 10             	add    $0x10,%esp
801030d3:	8b 45 10             	mov    0x10(%ebp),%eax
}
801030d6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801030d9:	5b                   	pop    %ebx
801030da:	5e                   	pop    %esi
801030db:	5f                   	pop    %edi
801030dc:	5d                   	pop    %ebp
801030dd:	c3                   	ret    
801030de:	66 90                	xchg   %ax,%ax
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801030e0:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
801030e7:	eb d0                	jmp    801030b9 <piperead+0xc9>
801030e9:	8d 76 00             	lea    0x0(%esi),%esi
801030ec:	89 4d 10             	mov    %ecx,0x10(%ebp)
801030ef:	eb c8                	jmp    801030b9 <piperead+0xc9>
801030f1:	66 90                	xchg   %ax,%ax
801030f3:	90                   	nop

801030f4 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801030f4:	55                   	push   %ebp
801030f5:	89 e5                	mov    %esp,%ebp
801030f7:	53                   	push   %ebx
801030f8:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
801030fb:	68 20 1d 11 80       	push   $0x80111d20
80103100:	e8 67 0c 00 00       	call   80103d6c <acquire>
80103105:	83 c4 10             	add    $0x10,%esp

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103108:	bb 54 1d 11 80       	mov    $0x80111d54,%ebx
8010310d:	eb 0c                	jmp    8010311b <allocproc+0x27>
8010310f:	90                   	nop
80103110:	83 c3 7c             	add    $0x7c,%ebx
80103113:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
80103119:	73 75                	jae    80103190 <allocproc+0x9c>
    if(p->state == UNUSED)
8010311b:	8b 4b 0c             	mov    0xc(%ebx),%ecx
8010311e:	85 c9                	test   %ecx,%ecx
80103120:	75 ee                	jne    80103110 <allocproc+0x1c>

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
80103122:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103129:	a1 04 90 10 80       	mov    0x80109004,%eax
8010312e:	8d 50 01             	lea    0x1(%eax),%edx
80103131:	89 15 04 90 10 80    	mov    %edx,0x80109004
80103137:	89 43 10             	mov    %eax,0x10(%ebx)

  release(&ptable.lock);
8010313a:	83 ec 0c             	sub    $0xc,%esp
8010313d:	68 20 1d 11 80       	push   $0x80111d20
80103142:	e8 bd 0c 00 00       	call   80103e04 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103147:	e8 34 f0 ff ff       	call   80102180 <kalloc>
8010314c:	89 43 08             	mov    %eax,0x8(%ebx)
8010314f:	83 c4 10             	add    $0x10,%esp
80103152:	85 c0                	test   %eax,%eax
80103154:	74 51                	je     801031a7 <allocproc+0xb3>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103156:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
8010315c:	89 53 18             	mov    %edx,0x18(%ebx)
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
8010315f:	c7 80 b0 0f 00 00 52 	movl   $0x80104e52,0xfb0(%eax)
80103166:	4e 10 80 

  sp -= sizeof *p->context;
80103169:	05 9c 0f 00 00       	add    $0xf9c,%eax
  p->context = (struct context*)sp;
8010316e:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103171:	52                   	push   %edx
80103172:	6a 14                	push   $0x14
80103174:	6a 00                	push   $0x0
80103176:	50                   	push   %eax
80103177:	e8 d0 0c 00 00       	call   80103e4c <memset>
  p->context->eip = (uint)forkret;
8010317c:	8b 43 1c             	mov    0x1c(%ebx),%eax
8010317f:	c7 40 10 b0 31 10 80 	movl   $0x801031b0,0x10(%eax)

  return p;
80103186:	83 c4 10             	add    $0x10,%esp
80103189:	89 d8                	mov    %ebx,%eax
}
8010318b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010318e:	c9                   	leave  
8010318f:	c3                   	ret    

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
80103190:	83 ec 0c             	sub    $0xc,%esp
80103193:	68 20 1d 11 80       	push   $0x80111d20
80103198:	e8 67 0c 00 00       	call   80103e04 <release>
  return 0;
8010319d:	83 c4 10             	add    $0x10,%esp
801031a0:	31 c0                	xor    %eax,%eax
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}
801031a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801031a5:	c9                   	leave  
801031a6:	c3                   	ret    

  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
801031a7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801031ae:	eb db                	jmp    8010318b <allocproc+0x97>

801031b0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801031b0:	55                   	push   %ebp
801031b1:	89 e5                	mov    %esp,%ebp
801031b3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801031b6:	68 20 1d 11 80       	push   $0x80111d20
801031bb:	e8 44 0c 00 00       	call   80103e04 <release>

  if (first) {
801031c0:	83 c4 10             	add    $0x10,%esp
801031c3:	a1 00 90 10 80       	mov    0x80109000,%eax
801031c8:	85 c0                	test   %eax,%eax
801031ca:	75 04                	jne    801031d0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801031cc:	c9                   	leave  
801031cd:	c3                   	ret    
801031ce:	66 90                	xchg   %ax,%ax

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
801031d0:	c7 05 00 90 10 80 00 	movl   $0x0,0x80109000
801031d7:	00 00 00 
    iinit(ROOTDEV);
801031da:	83 ec 0c             	sub    $0xc,%esp
801031dd:	6a 01                	push   $0x1
801031df:	e8 e4 e0 ff ff       	call   801012c8 <iinit>
    initlog(ROOTDEV);
801031e4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801031eb:	e8 e4 f4 ff ff       	call   801026d4 <initlog>
801031f0:	83 c4 10             	add    $0x10,%esp
  }

  // Return to "caller", actually trapret (see allocproc).
}
801031f3:	c9                   	leave  
801031f4:	c3                   	ret    
801031f5:	8d 76 00             	lea    0x0(%esi),%esi

801031f8 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
801031f8:	55                   	push   %ebp
801031f9:	89 e5                	mov    %esp,%ebp
801031fb:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
801031fe:	68 b5 6a 10 80       	push   $0x80106ab5
80103203:	68 20 1d 11 80       	push   $0x80111d20
80103208:	e8 23 0a 00 00       	call   80103c30 <initlock>
}
8010320d:	83 c4 10             	add    $0x10,%esp
80103210:	c9                   	leave  
80103211:	c3                   	ret    
80103212:	66 90                	xchg   %ax,%ax

80103214 <mycpu>:

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
80103214:	55                   	push   %ebp
80103215:	89 e5                	mov    %esp,%ebp
80103217:	56                   	push   %esi
80103218:	53                   	push   %ebx

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103219:	9c                   	pushf  
8010321a:	58                   	pop    %eax
  int apicid, i;
  
  if(readeflags()&FL_IF)
8010321b:	f6 c4 02             	test   $0x2,%ah
8010321e:	75 5e                	jne    8010327e <mycpu+0x6a>
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
80103220:	e8 77 f1 ff ff       	call   8010239c <lapicid>
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103225:	8b 35 00 1d 11 80    	mov    0x80111d00,%esi
8010322b:	85 f6                	test   %esi,%esi
8010322d:	7e 42                	jle    80103271 <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
8010322f:	0f b6 15 80 17 11 80 	movzbl 0x80111780,%edx
80103236:	39 d0                	cmp    %edx,%eax
80103238:	74 33                	je     8010326d <mycpu+0x59>
8010323a:	b9 30 18 11 80       	mov    $0x80111830,%ecx
8010323f:	31 d2                	xor    %edx,%edx
80103241:	8d 76 00             	lea    0x0(%esi),%esi
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103244:	42                   	inc    %edx
80103245:	39 f2                	cmp    %esi,%edx
80103247:	74 28                	je     80103271 <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103249:	0f b6 19             	movzbl (%ecx),%ebx
8010324c:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103252:	39 d8                	cmp    %ebx,%eax
80103254:	75 ee                	jne    80103244 <mycpu+0x30>
      return &cpus[i];
80103256:	8d 04 92             	lea    (%edx,%edx,4),%eax
80103259:	01 c0                	add    %eax,%eax
8010325b:	01 d0                	add    %edx,%eax
8010325d:	c1 e0 04             	shl    $0x4,%eax
80103260:	8d 80 80 17 11 80    	lea    -0x7feee880(%eax),%eax
  }
  panic("unknown apicid\n");
}
80103266:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103269:	5b                   	pop    %ebx
8010326a:	5e                   	pop    %esi
8010326b:	5d                   	pop    %ebp
8010326c:	c3                   	ret    
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
8010326d:	31 d2                	xor    %edx,%edx
8010326f:	eb e5                	jmp    80103256 <mycpu+0x42>
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
80103271:	83 ec 0c             	sub    $0xc,%esp
80103274:	68 bc 6a 10 80       	push   $0x80106abc
80103279:	e8 ba d0 ff ff       	call   80100338 <panic>
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
8010327e:	83 ec 0c             	sub    $0xc,%esp
80103281:	68 98 6b 10 80       	push   $0x80106b98
80103286:	e8 ad d0 ff ff       	call   80100338 <panic>
8010328b:	90                   	nop

8010328c <cpuid>:
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
8010328c:	55                   	push   %ebp
8010328d:	89 e5                	mov    %esp,%ebp
8010328f:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103292:	e8 7d ff ff ff       	call   80103214 <mycpu>
80103297:	2d 80 17 11 80       	sub    $0x80111780,%eax
8010329c:	c1 f8 04             	sar    $0x4,%eax
8010329f:	8d 0c c0             	lea    (%eax,%eax,8),%ecx
801032a2:	89 ca                	mov    %ecx,%edx
801032a4:	c1 e2 05             	shl    $0x5,%edx
801032a7:	29 ca                	sub    %ecx,%edx
801032a9:	8d 14 90             	lea    (%eax,%edx,4),%edx
801032ac:	8d 0c d0             	lea    (%eax,%edx,8),%ecx
801032af:	89 ca                	mov    %ecx,%edx
801032b1:	c1 e2 0f             	shl    $0xf,%edx
801032b4:	29 ca                	sub    %ecx,%edx
801032b6:	8d 04 90             	lea    (%eax,%edx,4),%eax
801032b9:	f7 d8                	neg    %eax
}
801032bb:	c9                   	leave  
801032bc:	c3                   	ret    
801032bd:	8d 76 00             	lea    0x0(%esi),%esi

801032c0 <myproc>:
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
801032c0:	55                   	push   %ebp
801032c1:	89 e5                	mov    %esp,%ebp
801032c3:	53                   	push   %ebx
801032c4:	50                   	push   %eax
  struct cpu *c;
  struct proc *p;
  pushcli();
801032c5:	e8 ca 09 00 00       	call   80103c94 <pushcli>
  c = mycpu();
801032ca:	e8 45 ff ff ff       	call   80103214 <mycpu>
  p = c->proc;
801032cf:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801032d5:	e8 f2 09 00 00       	call   80103ccc <popcli>
  return p;
}
801032da:	89 d8                	mov    %ebx,%eax
801032dc:	5a                   	pop    %edx
801032dd:	5b                   	pop    %ebx
801032de:	5d                   	pop    %ebp
801032df:	c3                   	ret    

801032e0 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
801032e0:	55                   	push   %ebp
801032e1:	89 e5                	mov    %esp,%ebp
801032e3:	53                   	push   %ebx
801032e4:	51                   	push   %ecx
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
801032e5:	e8 0a fe ff ff       	call   801030f4 <allocproc>
801032ea:	89 c3                	mov    %eax,%ebx
  
  initproc = p;
801032ec:	a3 b8 95 10 80       	mov    %eax,0x801095b8
  if((p->pgdir = setupkvm()) == 0)
801032f1:	e8 0a 30 00 00       	call   80106300 <setupkvm>
801032f6:	89 43 04             	mov    %eax,0x4(%ebx)
801032f9:	85 c0                	test   %eax,%eax
801032fb:	0f 84 b3 00 00 00    	je     801033b4 <userinit+0xd4>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103301:	52                   	push   %edx
80103302:	68 2c 00 00 00       	push   $0x2c
80103307:	68 60 94 10 80       	push   $0x80109460
8010330c:	50                   	push   %eax
8010330d:	e8 52 2d 00 00       	call   80106064 <inituvm>
  p->sz = PGSIZE;
80103312:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103318:	83 c4 0c             	add    $0xc,%esp
8010331b:	6a 4c                	push   $0x4c
8010331d:	6a 00                	push   $0x0
8010331f:	ff 73 18             	pushl  0x18(%ebx)
80103322:	e8 25 0b 00 00       	call   80103e4c <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103327:	8b 43 18             	mov    0x18(%ebx),%eax
8010332a:	66 c7 40 3c 1b 00    	movw   $0x1b,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103330:	8b 43 18             	mov    0x18(%ebx),%eax
80103333:	66 c7 40 2c 23 00    	movw   $0x23,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103339:	8b 43 18             	mov    0x18(%ebx),%eax
8010333c:	8b 50 2c             	mov    0x2c(%eax),%edx
8010333f:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103343:	8b 43 18             	mov    0x18(%ebx),%eax
80103346:	8b 50 2c             	mov    0x2c(%eax),%edx
80103349:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010334d:	8b 43 18             	mov    0x18(%ebx),%eax
80103350:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103357:	8b 43 18             	mov    0x18(%ebx),%eax
8010335a:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103361:	8b 43 18             	mov    0x18(%ebx),%eax
80103364:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
8010336b:	83 c4 0c             	add    $0xc,%esp
8010336e:	6a 10                	push   $0x10
80103370:	68 e5 6a 10 80       	push   $0x80106ae5
80103375:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103378:	50                   	push   %eax
80103379:	e8 62 0c 00 00       	call   80103fe0 <safestrcpy>
  p->cwd = namei("/");
8010337e:	c7 04 24 ee 6a 10 80 	movl   $0x80106aee,(%esp)
80103385:	e8 d2 e8 ff ff       	call   80101c5c <namei>
8010338a:	89 43 68             	mov    %eax,0x68(%ebx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
8010338d:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103394:	e8 d3 09 00 00       	call   80103d6c <acquire>

  p->state = RUNNABLE;
80103399:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
801033a0:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
801033a7:	e8 58 0a 00 00       	call   80103e04 <release>
}
801033ac:	83 c4 10             	add    $0x10,%esp
801033af:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801033b2:	c9                   	leave  
801033b3:	c3                   	ret    

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
801033b4:	83 ec 0c             	sub    $0xc,%esp
801033b7:	68 cc 6a 10 80       	push   $0x80106acc
801033bc:	e8 77 cf ff ff       	call   80100338 <panic>
801033c1:	8d 76 00             	lea    0x0(%esi),%esi

801033c4 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
801033c4:	55                   	push   %ebp
801033c5:	89 e5                	mov    %esp,%ebp
801033c7:	53                   	push   %ebx
801033c8:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
801033c9:	e8 c6 08 00 00       	call   80103c94 <pushcli>
  c = mycpu();
801033ce:	e8 41 fe ff ff       	call   80103214 <mycpu>
  p = c->proc;
801033d3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801033d9:	e8 ee 08 00 00       	call   80103ccc <popcli>
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
801033de:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
801033e0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801033e4:	7e 2e                	jle    80103414 <growproc+0x50>
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
801033e6:	51                   	push   %ecx
801033e7:	8b 55 08             	mov    0x8(%ebp),%edx
801033ea:	01 c2                	add    %eax,%edx
801033ec:	52                   	push   %edx
801033ed:	50                   	push   %eax
801033ee:	ff 73 04             	pushl  0x4(%ebx)
801033f1:	e8 92 2d 00 00       	call   80106188 <allocuvm>
801033f6:	83 c4 10             	add    $0x10,%esp
801033f9:	85 c0                	test   %eax,%eax
801033fb:	74 33                	je     80103430 <growproc+0x6c>
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
801033fd:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
801033ff:	83 ec 0c             	sub    $0xc,%esp
80103402:	53                   	push   %ebx
80103403:	e8 5c 2b 00 00       	call   80105f64 <switchuvm>
  return 0;
80103408:	83 c4 10             	add    $0x10,%esp
8010340b:	31 c0                	xor    %eax,%eax
}
8010340d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103410:	c9                   	leave  
80103411:	c3                   	ret    
80103412:	66 90                	xchg   %ax,%ax

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
80103414:	74 e7                	je     801033fd <growproc+0x39>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103416:	52                   	push   %edx
80103417:	8b 55 08             	mov    0x8(%ebp),%edx
8010341a:	01 c2                	add    %eax,%edx
8010341c:	52                   	push   %edx
8010341d:	50                   	push   %eax
8010341e:	ff 73 04             	pushl  0x4(%ebx)
80103421:	e8 4e 2e 00 00       	call   80106274 <deallocuvm>
80103426:	83 c4 10             	add    $0x10,%esp
80103429:	85 c0                	test   %eax,%eax
8010342b:	75 d0                	jne    801033fd <growproc+0x39>
8010342d:	8d 76 00             	lea    0x0(%esi),%esi
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
80103430:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103435:	eb d6                	jmp    8010340d <growproc+0x49>
80103437:	90                   	nop

80103438 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80103438:	55                   	push   %ebp
80103439:	89 e5                	mov    %esp,%ebp
8010343b:	57                   	push   %edi
8010343c:	56                   	push   %esi
8010343d:	53                   	push   %ebx
8010343e:	83 ec 1c             	sub    $0x1c,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103441:	e8 4e 08 00 00       	call   80103c94 <pushcli>
  c = mycpu();
80103446:	e8 c9 fd ff ff       	call   80103214 <mycpu>
  p = c->proc;
8010344b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103451:	e8 76 08 00 00       	call   80103ccc <popcli>
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
80103456:	e8 99 fc ff ff       	call   801030f4 <allocproc>
8010345b:	89 c7                	mov    %eax,%edi
8010345d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103460:	85 c0                	test   %eax,%eax
80103462:	0f 84 b3 00 00 00    	je     8010351b <fork+0xe3>
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103468:	83 ec 08             	sub    $0x8,%esp
8010346b:	ff 33                	pushl  (%ebx)
8010346d:	ff 73 04             	pushl  0x4(%ebx)
80103470:	e8 4b 2f 00 00       	call   801063c0 <copyuvm>
80103475:	89 47 04             	mov    %eax,0x4(%edi)
80103478:	83 c4 10             	add    $0x10,%esp
8010347b:	85 c0                	test   %eax,%eax
8010347d:	0f 84 9f 00 00 00    	je     80103522 <fork+0xea>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
80103483:	8b 03                	mov    (%ebx),%eax
80103485:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103488:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
8010348a:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
8010348d:	89 c8                	mov    %ecx,%eax
8010348f:	8b 79 18             	mov    0x18(%ecx),%edi
80103492:	8b 73 18             	mov    0x18(%ebx),%esi
80103495:	b9 13 00 00 00       	mov    $0x13,%ecx
8010349a:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
8010349c:	8b 40 18             	mov    0x18(%eax),%eax
8010349f:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
801034a6:	31 f6                	xor    %esi,%esi
    if(curproc->ofile[i])
801034a8:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
801034ac:	85 c0                	test   %eax,%eax
801034ae:	74 13                	je     801034c3 <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
801034b0:	83 ec 0c             	sub    $0xc,%esp
801034b3:	50                   	push   %eax
801034b4:	e8 23 d8 ff ff       	call   80100cdc <filedup>
801034b9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801034bc:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
801034c0:	83 c4 10             	add    $0x10,%esp
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
801034c3:	46                   	inc    %esi
801034c4:	83 fe 10             	cmp    $0x10,%esi
801034c7:	75 df                	jne    801034a8 <fork+0x70>
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
801034c9:	83 ec 0c             	sub    $0xc,%esp
801034cc:	ff 73 68             	pushl  0x68(%ebx)
801034cf:	e8 ac df ff ff       	call   80101480 <idup>
801034d4:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801034d7:	89 47 68             	mov    %eax,0x68(%edi)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801034da:	83 c4 0c             	add    $0xc,%esp
801034dd:	6a 10                	push   $0x10
801034df:	83 c3 6c             	add    $0x6c,%ebx
801034e2:	53                   	push   %ebx
801034e3:	8d 47 6c             	lea    0x6c(%edi),%eax
801034e6:	50                   	push   %eax
801034e7:	e8 f4 0a 00 00       	call   80103fe0 <safestrcpy>

  pid = np->pid;
801034ec:	8b 5f 10             	mov    0x10(%edi),%ebx

  acquire(&ptable.lock);
801034ef:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
801034f6:	e8 71 08 00 00       	call   80103d6c <acquire>

  np->state = RUNNABLE;
801034fb:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)

  release(&ptable.lock);
80103502:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103509:	e8 f6 08 00 00       	call   80103e04 <release>

  return pid;
8010350e:	83 c4 10             	add    $0x10,%esp
80103511:	89 d8                	mov    %ebx,%eax
}
80103513:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103516:	5b                   	pop    %ebx
80103517:	5e                   	pop    %esi
80103518:	5f                   	pop    %edi
80103519:	5d                   	pop    %ebp
8010351a:	c3                   	ret    
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
8010351b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103520:	eb f1                	jmp    80103513 <fork+0xdb>
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
80103522:	83 ec 0c             	sub    $0xc,%esp
80103525:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103528:	ff 77 08             	pushl  0x8(%edi)
8010352b:	e8 c4 ea ff ff       	call   80101ff4 <kfree>
    np->kstack = 0;
80103530:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
80103537:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
8010353e:	83 c4 10             	add    $0x10,%esp
80103541:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103546:	eb cb                	jmp    80103513 <fork+0xdb>

80103548 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80103548:	55                   	push   %ebp
80103549:	89 e5                	mov    %esp,%ebp
8010354b:	57                   	push   %edi
8010354c:	56                   	push   %esi
8010354d:	53                   	push   %ebx
8010354e:	83 ec 0c             	sub    $0xc,%esp
  struct proc *p;
  struct cpu *c = mycpu();
80103551:	e8 be fc ff ff       	call   80103214 <mycpu>
80103556:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103558:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
8010355f:	00 00 00 
80103562:	8d 78 04             	lea    0x4(%eax),%edi
80103565:	8d 76 00             	lea    0x0(%esi),%esi
}

static inline void
sti(void)
{
  asm volatile("sti");
80103568:	fb                   	sti    
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103569:	83 ec 0c             	sub    $0xc,%esp
8010356c:	68 20 1d 11 80       	push   $0x80111d20
80103571:	e8 f6 07 00 00       	call   80103d6c <acquire>
80103576:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103579:	bb 54 1d 11 80       	mov    $0x80111d54,%ebx
8010357e:	eb 0b                	jmp    8010358b <scheduler+0x43>
80103580:	83 c3 7c             	add    $0x7c,%ebx
80103583:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
80103589:	73 45                	jae    801035d0 <scheduler+0x88>
      if(p->state != RUNNABLE)
8010358b:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
8010358f:	75 ef                	jne    80103580 <scheduler+0x38>
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
80103591:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103597:	83 ec 0c             	sub    $0xc,%esp
8010359a:	53                   	push   %ebx
8010359b:	e8 c4 29 00 00       	call   80105f64 <switchuvm>
      p->state = RUNNING;
801035a0:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)

      swtch(&(c->scheduler), p->context);
801035a7:	58                   	pop    %eax
801035a8:	5a                   	pop    %edx
801035a9:	ff 73 1c             	pushl  0x1c(%ebx)
801035ac:	57                   	push   %edi
801035ad:	e8 7b 0a 00 00       	call   8010402d <swtch>
      switchkvm();
801035b2:	e8 99 29 00 00       	call   80105f50 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
801035b7:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
801035be:	00 00 00 
801035c1:	83 c4 10             	add    $0x10,%esp
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801035c4:	83 c3 7c             	add    $0x7c,%ebx
801035c7:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
801035cd:	72 bc                	jb     8010358b <scheduler+0x43>
801035cf:	90                   	nop

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
    release(&ptable.lock);
801035d0:	83 ec 0c             	sub    $0xc,%esp
801035d3:	68 20 1d 11 80       	push   $0x80111d20
801035d8:	e8 27 08 00 00       	call   80103e04 <release>

  }
801035dd:	83 c4 10             	add    $0x10,%esp
801035e0:	eb 86                	jmp    80103568 <scheduler+0x20>
801035e2:	66 90                	xchg   %ax,%ax

801035e4 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
801035e4:	55                   	push   %ebp
801035e5:	89 e5                	mov    %esp,%ebp
801035e7:	56                   	push   %esi
801035e8:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
801035e9:	e8 a6 06 00 00       	call   80103c94 <pushcli>
  c = mycpu();
801035ee:	e8 21 fc ff ff       	call   80103214 <mycpu>
  p = c->proc;
801035f3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801035f9:	e8 ce 06 00 00       	call   80103ccc <popcli>
sched(void)
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
801035fe:	83 ec 0c             	sub    $0xc,%esp
80103601:	68 20 1d 11 80       	push   $0x80111d20
80103606:	e8 25 07 00 00       	call   80103d30 <holding>
8010360b:	83 c4 10             	add    $0x10,%esp
8010360e:	85 c0                	test   %eax,%eax
80103610:	74 4f                	je     80103661 <sched+0x7d>
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
80103612:	e8 fd fb ff ff       	call   80103214 <mycpu>
80103617:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
8010361e:	75 68                	jne    80103688 <sched+0xa4>
    panic("sched locks");
  if(p->state == RUNNING)
80103620:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103624:	74 55                	je     8010367b <sched+0x97>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103626:	9c                   	pushf  
80103627:	58                   	pop    %eax
    panic("sched running");
  if(readeflags()&FL_IF)
80103628:	f6 c4 02             	test   $0x2,%ah
8010362b:	75 41                	jne    8010366e <sched+0x8a>
    panic("sched interruptible");
  intena = mycpu()->intena;
8010362d:	e8 e2 fb ff ff       	call   80103214 <mycpu>
80103632:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103638:	e8 d7 fb ff ff       	call   80103214 <mycpu>
8010363d:	83 ec 08             	sub    $0x8,%esp
80103640:	ff 70 04             	pushl  0x4(%eax)
80103643:	83 c3 1c             	add    $0x1c,%ebx
80103646:	53                   	push   %ebx
80103647:	e8 e1 09 00 00       	call   8010402d <swtch>
  mycpu()->intena = intena;
8010364c:	e8 c3 fb ff ff       	call   80103214 <mycpu>
80103651:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103657:	83 c4 10             	add    $0x10,%esp
8010365a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010365d:	5b                   	pop    %ebx
8010365e:	5e                   	pop    %esi
8010365f:	5d                   	pop    %ebp
80103660:	c3                   	ret    
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
80103661:	83 ec 0c             	sub    $0xc,%esp
80103664:	68 f0 6a 10 80       	push   $0x80106af0
80103669:	e8 ca cc ff ff       	call   80100338 <panic>
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
8010366e:	83 ec 0c             	sub    $0xc,%esp
80103671:	68 1c 6b 10 80       	push   $0x80106b1c
80103676:	e8 bd cc ff ff       	call   80100338 <panic>
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
8010367b:	83 ec 0c             	sub    $0xc,%esp
8010367e:	68 0e 6b 10 80       	push   $0x80106b0e
80103683:	e8 b0 cc ff ff       	call   80100338 <panic>
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
80103688:	83 ec 0c             	sub    $0xc,%esp
8010368b:	68 02 6b 10 80       	push   $0x80106b02
80103690:	e8 a3 cc ff ff       	call   80100338 <panic>
80103695:	8d 76 00             	lea    0x0(%esi),%esi

80103698 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80103698:	55                   	push   %ebp
80103699:	89 e5                	mov    %esp,%ebp
8010369b:	57                   	push   %edi
8010369c:	56                   	push   %esi
8010369d:	53                   	push   %ebx
8010369e:	83 ec 0c             	sub    $0xc,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
801036a1:	e8 ee 05 00 00       	call   80103c94 <pushcli>
  c = mycpu();
801036a6:	e8 69 fb ff ff       	call   80103214 <mycpu>
  p = c->proc;
801036ab:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801036b1:	e8 16 06 00 00       	call   80103ccc <popcli>
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
801036b6:	39 35 b8 95 10 80    	cmp    %esi,0x801095b8
801036bc:	0f 84 e5 00 00 00    	je     801037a7 <exit+0x10f>
801036c2:	8d 5e 28             	lea    0x28(%esi),%ebx
801036c5:	8d 7e 68             	lea    0x68(%esi),%edi
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
801036c8:	8b 03                	mov    (%ebx),%eax
801036ca:	85 c0                	test   %eax,%eax
801036cc:	74 12                	je     801036e0 <exit+0x48>
      fileclose(curproc->ofile[fd]);
801036ce:	83 ec 0c             	sub    $0xc,%esp
801036d1:	50                   	push   %eax
801036d2:	e8 49 d6 ff ff       	call   80100d20 <fileclose>
      curproc->ofile[fd] = 0;
801036d7:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801036dd:	83 c4 10             	add    $0x10,%esp
801036e0:	83 c3 04             	add    $0x4,%ebx

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
801036e3:	39 fb                	cmp    %edi,%ebx
801036e5:	75 e1                	jne    801036c8 <exit+0x30>
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
801036e7:	e8 78 f0 ff ff       	call   80102764 <begin_op>
  iput(curproc->cwd);
801036ec:	83 ec 0c             	sub    $0xc,%esp
801036ef:	ff 76 68             	pushl  0x68(%esi)
801036f2:	e8 c1 de ff ff       	call   801015b8 <iput>
  end_op();
801036f7:	e8 d0 f0 ff ff       	call   801027cc <end_op>
  curproc->cwd = 0;
801036fc:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)

  acquire(&ptable.lock);
80103703:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
8010370a:	e8 5d 06 00 00       	call   80103d6c <acquire>

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);
8010370f:	8b 56 14             	mov    0x14(%esi),%edx
80103712:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103715:	b8 54 1d 11 80       	mov    $0x80111d54,%eax
8010371a:	eb 0a                	jmp    80103726 <exit+0x8e>
8010371c:	83 c0 7c             	add    $0x7c,%eax
8010371f:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80103724:	73 1c                	jae    80103742 <exit+0xaa>
    if(p->state == SLEEPING && p->chan == chan)
80103726:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010372a:	75 f0                	jne    8010371c <exit+0x84>
8010372c:	3b 50 20             	cmp    0x20(%eax),%edx
8010372f:	75 eb                	jne    8010371c <exit+0x84>
      p->state = RUNNABLE;
80103731:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103738:	83 c0 7c             	add    $0x7c,%eax
8010373b:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80103740:	72 e4                	jb     80103726 <exit+0x8e>
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103742:	8b 0d b8 95 10 80    	mov    0x801095b8,%ecx
80103748:	ba 54 1d 11 80       	mov    $0x80111d54,%edx
8010374d:	eb 0c                	jmp    8010375b <exit+0xc3>
8010374f:	90                   	nop

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103750:	83 c2 7c             	add    $0x7c,%edx
80103753:	81 fa 54 3c 11 80    	cmp    $0x80113c54,%edx
80103759:	73 33                	jae    8010378e <exit+0xf6>
    if(p->parent == curproc){
8010375b:	39 72 14             	cmp    %esi,0x14(%edx)
8010375e:	75 f0                	jne    80103750 <exit+0xb8>
      p->parent = initproc;
80103760:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103763:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
80103767:	75 e7                	jne    80103750 <exit+0xb8>
80103769:	b8 54 1d 11 80       	mov    $0x80111d54,%eax
8010376e:	eb 0a                	jmp    8010377a <exit+0xe2>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103770:	83 c0 7c             	add    $0x7c,%eax
80103773:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80103778:	73 d6                	jae    80103750 <exit+0xb8>
    if(p->state == SLEEPING && p->chan == chan)
8010377a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010377e:	75 f0                	jne    80103770 <exit+0xd8>
80103780:	3b 48 20             	cmp    0x20(%eax),%ecx
80103783:	75 eb                	jne    80103770 <exit+0xd8>
      p->state = RUNNABLE;
80103785:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010378c:	eb e2                	jmp    80103770 <exit+0xd8>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
8010378e:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103795:	e8 4a fe ff ff       	call   801035e4 <sched>
  panic("zombie exit");
8010379a:	83 ec 0c             	sub    $0xc,%esp
8010379d:	68 3d 6b 10 80       	push   $0x80106b3d
801037a2:	e8 91 cb ff ff       	call   80100338 <panic>
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");
801037a7:	83 ec 0c             	sub    $0xc,%esp
801037aa:	68 30 6b 10 80       	push   $0x80106b30
801037af:	e8 84 cb ff ff       	call   80100338 <panic>

801037b4 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
801037b4:	55                   	push   %ebp
801037b5:	89 e5                	mov    %esp,%ebp
801037b7:	53                   	push   %ebx
801037b8:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
801037bb:	68 20 1d 11 80       	push   $0x80111d20
801037c0:	e8 a7 05 00 00       	call   80103d6c <acquire>
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
801037c5:	e8 ca 04 00 00       	call   80103c94 <pushcli>
  c = mycpu();
801037ca:	e8 45 fa ff ff       	call   80103214 <mycpu>
  p = c->proc;
801037cf:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801037d5:	e8 f2 04 00 00       	call   80103ccc <popcli>
// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  myproc()->state = RUNNABLE;
801037da:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
801037e1:	e8 fe fd ff ff       	call   801035e4 <sched>
  release(&ptable.lock);
801037e6:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
801037ed:	e8 12 06 00 00       	call   80103e04 <release>
}
801037f2:	83 c4 10             	add    $0x10,%esp
801037f5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801037f8:	c9                   	leave  
801037f9:	c3                   	ret    
801037fa:	66 90                	xchg   %ax,%ax

801037fc <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
801037fc:	55                   	push   %ebp
801037fd:	89 e5                	mov    %esp,%ebp
801037ff:	57                   	push   %edi
80103800:	56                   	push   %esi
80103801:	53                   	push   %ebx
80103802:	83 ec 0c             	sub    $0xc,%esp
80103805:	8b 7d 08             	mov    0x8(%ebp),%edi
80103808:	8b 75 0c             	mov    0xc(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
8010380b:	e8 84 04 00 00       	call   80103c94 <pushcli>
  c = mycpu();
80103810:	e8 ff f9 ff ff       	call   80103214 <mycpu>
  p = c->proc;
80103815:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010381b:	e8 ac 04 00 00       	call   80103ccc <popcli>
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
80103820:	85 db                	test   %ebx,%ebx
80103822:	0f 84 83 00 00 00    	je     801038ab <sleep+0xaf>
    panic("sleep");

  if(lk == 0)
80103828:	85 f6                	test   %esi,%esi
8010382a:	74 72                	je     8010389e <sleep+0xa2>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
8010382c:	81 fe 20 1d 11 80    	cmp    $0x80111d20,%esi
80103832:	74 4c                	je     80103880 <sleep+0x84>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103834:	83 ec 0c             	sub    $0xc,%esp
80103837:	68 20 1d 11 80       	push   $0x80111d20
8010383c:	e8 2b 05 00 00       	call   80103d6c <acquire>
    release(lk);
80103841:	89 34 24             	mov    %esi,(%esp)
80103844:	e8 bb 05 00 00       	call   80103e04 <release>
  }
  // Go to sleep.
  p->chan = chan;
80103849:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
8010384c:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80103853:	e8 8c fd ff ff       	call   801035e4 <sched>

  // Tidy up.
  p->chan = 0;
80103858:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
8010385f:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103866:	e8 99 05 00 00       	call   80103e04 <release>
    acquire(lk);
8010386b:	83 c4 10             	add    $0x10,%esp
8010386e:	89 75 08             	mov    %esi,0x8(%ebp)
  }
}
80103871:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103874:	5b                   	pop    %ebx
80103875:	5e                   	pop    %esi
80103876:	5f                   	pop    %edi
80103877:	5d                   	pop    %ebp
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
80103878:	e9 ef 04 00 00       	jmp    80103d6c <acquire>
8010387d:	8d 76 00             	lea    0x0(%esi),%esi
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
80103880:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103883:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
8010388a:	e8 55 fd ff ff       	call   801035e4 <sched>

  // Tidy up.
  p->chan = 0;
8010388f:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
80103896:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103899:	5b                   	pop    %ebx
8010389a:	5e                   	pop    %esi
8010389b:	5f                   	pop    %edi
8010389c:	5d                   	pop    %ebp
8010389d:	c3                   	ret    
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
8010389e:	83 ec 0c             	sub    $0xc,%esp
801038a1:	68 4f 6b 10 80       	push   $0x80106b4f
801038a6:	e8 8d ca ff ff       	call   80100338 <panic>
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
    panic("sleep");
801038ab:	83 ec 0c             	sub    $0xc,%esp
801038ae:	68 49 6b 10 80       	push   $0x80106b49
801038b3:	e8 80 ca ff ff       	call   80100338 <panic>

801038b8 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
801038b8:	55                   	push   %ebp
801038b9:	89 e5                	mov    %esp,%ebp
801038bb:	56                   	push   %esi
801038bc:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
801038bd:	e8 d2 03 00 00       	call   80103c94 <pushcli>
  c = mycpu();
801038c2:	e8 4d f9 ff ff       	call   80103214 <mycpu>
  p = c->proc;
801038c7:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801038cd:	e8 fa 03 00 00       	call   80103ccc <popcli>
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
  
  acquire(&ptable.lock);
801038d2:	83 ec 0c             	sub    $0xc,%esp
801038d5:	68 20 1d 11 80       	push   $0x80111d20
801038da:	e8 8d 04 00 00       	call   80103d6c <acquire>
801038df:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
801038e2:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801038e4:	bb 54 1d 11 80       	mov    $0x80111d54,%ebx
801038e9:	eb 0c                	jmp    801038f7 <wait+0x3f>
801038eb:	90                   	nop
801038ec:	83 c3 7c             	add    $0x7c,%ebx
801038ef:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
801038f5:	73 1d                	jae    80103914 <wait+0x5c>
      if(p->parent != curproc)
801038f7:	39 73 14             	cmp    %esi,0x14(%ebx)
801038fa:	75 f0                	jne    801038ec <wait+0x34>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
801038fc:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103900:	74 30                	je     80103932 <wait+0x7a>
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != curproc)
        continue;
      havekids = 1;
80103902:	b8 01 00 00 00       	mov    $0x1,%eax
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103907:	83 c3 7c             	add    $0x7c,%ebx
8010390a:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
80103910:	72 e5                	jb     801038f7 <wait+0x3f>
80103912:	66 90                	xchg   %ax,%ax
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
80103914:	85 c0                	test   %eax,%eax
80103916:	74 70                	je     80103988 <wait+0xd0>
80103918:	8b 46 24             	mov    0x24(%esi),%eax
8010391b:	85 c0                	test   %eax,%eax
8010391d:	75 69                	jne    80103988 <wait+0xd0>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
8010391f:	83 ec 08             	sub    $0x8,%esp
80103922:	68 20 1d 11 80       	push   $0x80111d20
80103927:	56                   	push   %esi
80103928:	e8 cf fe ff ff       	call   801037fc <sleep>
  }
8010392d:	83 c4 10             	add    $0x10,%esp
80103930:	eb b0                	jmp    801038e2 <wait+0x2a>
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
80103932:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103935:	83 ec 0c             	sub    $0xc,%esp
80103938:	ff 73 08             	pushl  0x8(%ebx)
8010393b:	e8 b4 e6 ff ff       	call   80101ff4 <kfree>
        p->kstack = 0;
80103940:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103947:	5a                   	pop    %edx
80103948:	ff 73 04             	pushl  0x4(%ebx)
8010394b:	e8 40 29 00 00       	call   80106290 <freevm>
        p->pid = 0;
80103950:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103957:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010395e:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103962:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103969:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103970:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103977:	e8 88 04 00 00       	call   80103e04 <release>
        return pid;
8010397c:	83 c4 10             	add    $0x10,%esp
8010397f:	89 f0                	mov    %esi,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103981:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103984:	5b                   	pop    %ebx
80103985:	5e                   	pop    %esi
80103986:	5d                   	pop    %ebp
80103987:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
80103988:	83 ec 0c             	sub    $0xc,%esp
8010398b:	68 20 1d 11 80       	push   $0x80111d20
80103990:	e8 6f 04 00 00       	call   80103e04 <release>
      return -1;
80103995:	83 c4 10             	add    $0x10,%esp
80103998:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
8010399d:	8d 65 f8             	lea    -0x8(%ebp),%esp
801039a0:	5b                   	pop    %ebx
801039a1:	5e                   	pop    %esi
801039a2:	5d                   	pop    %ebp
801039a3:	c3                   	ret    

801039a4 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801039a4:	55                   	push   %ebp
801039a5:	89 e5                	mov    %esp,%ebp
801039a7:	53                   	push   %ebx
801039a8:	83 ec 10             	sub    $0x10,%esp
801039ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801039ae:	68 20 1d 11 80       	push   $0x80111d20
801039b3:	e8 b4 03 00 00       	call   80103d6c <acquire>
801039b8:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801039bb:	b8 54 1d 11 80       	mov    $0x80111d54,%eax
801039c0:	eb 0c                	jmp    801039ce <wakeup+0x2a>
801039c2:	66 90                	xchg   %ax,%ax
801039c4:	83 c0 7c             	add    $0x7c,%eax
801039c7:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
801039cc:	73 1c                	jae    801039ea <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
801039ce:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801039d2:	75 f0                	jne    801039c4 <wakeup+0x20>
801039d4:	3b 58 20             	cmp    0x20(%eax),%ebx
801039d7:	75 eb                	jne    801039c4 <wakeup+0x20>
      p->state = RUNNABLE;
801039d9:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801039e0:	83 c0 7c             	add    $0x7c,%eax
801039e3:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
801039e8:	72 e4                	jb     801039ce <wakeup+0x2a>
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
801039ea:	c7 45 08 20 1d 11 80 	movl   $0x80111d20,0x8(%ebp)
}
801039f1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039f4:	c9                   	leave  
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
801039f5:	e9 0a 04 00 00       	jmp    80103e04 <release>
801039fa:	66 90                	xchg   %ax,%ax

801039fc <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801039fc:	55                   	push   %ebp
801039fd:	89 e5                	mov    %esp,%ebp
801039ff:	53                   	push   %ebx
80103a00:	83 ec 10             	sub    $0x10,%esp
80103a03:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80103a06:	68 20 1d 11 80       	push   $0x80111d20
80103a0b:	e8 5c 03 00 00       	call   80103d6c <acquire>
80103a10:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103a13:	b8 54 1d 11 80       	mov    $0x80111d54,%eax
80103a18:	eb 0c                	jmp    80103a26 <kill+0x2a>
80103a1a:	66 90                	xchg   %ax,%ax
80103a1c:	83 c0 7c             	add    $0x7c,%eax
80103a1f:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80103a24:	73 36                	jae    80103a5c <kill+0x60>
    if(p->pid == pid){
80103a26:	39 58 10             	cmp    %ebx,0x10(%eax)
80103a29:	75 f1                	jne    80103a1c <kill+0x20>
      p->killed = 1;
80103a2b:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80103a32:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103a36:	74 18                	je     80103a50 <kill+0x54>
        p->state = RUNNABLE;
      release(&ptable.lock);
80103a38:	83 ec 0c             	sub    $0xc,%esp
80103a3b:	68 20 1d 11 80       	push   $0x80111d20
80103a40:	e8 bf 03 00 00       	call   80103e04 <release>
      return 0;
80103a45:	83 c4 10             	add    $0x10,%esp
80103a48:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80103a4a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a4d:	c9                   	leave  
80103a4e:	c3                   	ret    
80103a4f:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
80103a50:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103a57:	eb df                	jmp    80103a38 <kill+0x3c>
80103a59:	8d 76 00             	lea    0x0(%esi),%esi
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80103a5c:	83 ec 0c             	sub    $0xc,%esp
80103a5f:	68 20 1d 11 80       	push   $0x80111d20
80103a64:	e8 9b 03 00 00       	call   80103e04 <release>
  return -1;
80103a69:	83 c4 10             	add    $0x10,%esp
80103a6c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103a71:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a74:	c9                   	leave  
80103a75:	c3                   	ret    
80103a76:	66 90                	xchg   %ax,%ax

80103a78 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80103a78:	55                   	push   %ebp
80103a79:	89 e5                	mov    %esp,%ebp
80103a7b:	57                   	push   %edi
80103a7c:	56                   	push   %esi
80103a7d:	53                   	push   %ebx
80103a7e:	83 ec 3c             	sub    $0x3c,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103a81:	bb 54 1d 11 80       	mov    $0x80111d54,%ebx
80103a86:	8d 75 e8             	lea    -0x18(%ebp),%esi
80103a89:	eb 42                	jmp    80103acd <procdump+0x55>
80103a8b:	90                   	nop
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80103a8c:	8b 04 85 c0 6b 10 80 	mov    -0x7fef9440(,%eax,4),%eax
80103a93:	85 c0                	test   %eax,%eax
80103a95:	74 42                	je     80103ad9 <procdump+0x61>
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
80103a97:	8d 53 6c             	lea    0x6c(%ebx),%edx
80103a9a:	52                   	push   %edx
80103a9b:	50                   	push   %eax
80103a9c:	ff 73 10             	pushl  0x10(%ebx)
80103a9f:	68 64 6b 10 80       	push   $0x80106b64
80103aa4:	e8 4f cb ff ff       	call   801005f8 <cprintf>
    if(p->state == SLEEPING){
80103aa9:	83 c4 10             	add    $0x10,%esp
80103aac:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80103ab0:	74 2e                	je     80103ae0 <procdump+0x68>
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80103ab2:	83 ec 0c             	sub    $0xc,%esp
80103ab5:	68 d7 6e 10 80       	push   $0x80106ed7
80103aba:	e8 39 cb ff ff       	call   801005f8 <cprintf>
80103abf:	83 c4 10             	add    $0x10,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ac2:	83 c3 7c             	add    $0x7c,%ebx
80103ac5:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
80103acb:	73 4f                	jae    80103b1c <procdump+0xa4>
    if(p->state == UNUSED)
80103acd:	8b 43 0c             	mov    0xc(%ebx),%eax
80103ad0:	85 c0                	test   %eax,%eax
80103ad2:	74 ee                	je     80103ac2 <procdump+0x4a>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80103ad4:	83 f8 05             	cmp    $0x5,%eax
80103ad7:	76 b3                	jbe    80103a8c <procdump+0x14>
      state = states[p->state];
    else
      state = "???";
80103ad9:	b8 60 6b 10 80       	mov    $0x80106b60,%eax
80103ade:	eb b7                	jmp    80103a97 <procdump+0x1f>
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
80103ae0:	83 ec 08             	sub    $0x8,%esp
80103ae3:	8d 45 c0             	lea    -0x40(%ebp),%eax
80103ae6:	50                   	push   %eax
80103ae7:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103aea:	8b 40 0c             	mov    0xc(%eax),%eax
80103aed:	83 c0 08             	add    $0x8,%eax
80103af0:	50                   	push   %eax
80103af1:	e8 56 01 00 00       	call   80103c4c <getcallerpcs>
80103af6:	8d 7d c0             	lea    -0x40(%ebp),%edi
80103af9:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80103afc:	8b 17                	mov    (%edi),%edx
80103afe:	85 d2                	test   %edx,%edx
80103b00:	74 b0                	je     80103ab2 <procdump+0x3a>
        cprintf(" %p", pc[i]);
80103b02:	83 ec 08             	sub    $0x8,%esp
80103b05:	52                   	push   %edx
80103b06:	68 a1 65 10 80       	push   $0x801065a1
80103b0b:	e8 e8 ca ff ff       	call   801005f8 <cprintf>
80103b10:	83 c7 04             	add    $0x4,%edi
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80103b13:	83 c4 10             	add    $0x10,%esp
80103b16:	39 fe                	cmp    %edi,%esi
80103b18:	75 e2                	jne    80103afc <procdump+0x84>
80103b1a:	eb 96                	jmp    80103ab2 <procdump+0x3a>
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80103b1c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b1f:	5b                   	pop    %ebx
80103b20:	5e                   	pop    %esi
80103b21:	5f                   	pop    %edi
80103b22:	5d                   	pop    %ebp
80103b23:	c3                   	ret    

80103b24 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80103b24:	55                   	push   %ebp
80103b25:	89 e5                	mov    %esp,%ebp
80103b27:	53                   	push   %ebx
80103b28:	83 ec 0c             	sub    $0xc,%esp
80103b2b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80103b2e:	68 d8 6b 10 80       	push   $0x80106bd8
80103b33:	8d 43 04             	lea    0x4(%ebx),%eax
80103b36:	50                   	push   %eax
80103b37:	e8 f4 00 00 00       	call   80103c30 <initlock>
  lk->name = name;
80103b3c:	8b 45 0c             	mov    0xc(%ebp),%eax
80103b3f:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
80103b42:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80103b48:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
}
80103b4f:	83 c4 10             	add    $0x10,%esp
80103b52:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103b55:	c9                   	leave  
80103b56:	c3                   	ret    
80103b57:	90                   	nop

80103b58 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80103b58:	55                   	push   %ebp
80103b59:	89 e5                	mov    %esp,%ebp
80103b5b:	56                   	push   %esi
80103b5c:	53                   	push   %ebx
80103b5d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80103b60:	8d 73 04             	lea    0x4(%ebx),%esi
80103b63:	83 ec 0c             	sub    $0xc,%esp
80103b66:	56                   	push   %esi
80103b67:	e8 00 02 00 00       	call   80103d6c <acquire>
  while (lk->locked) {
80103b6c:	83 c4 10             	add    $0x10,%esp
80103b6f:	8b 13                	mov    (%ebx),%edx
80103b71:	85 d2                	test   %edx,%edx
80103b73:	74 16                	je     80103b8b <acquiresleep+0x33>
80103b75:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80103b78:	83 ec 08             	sub    $0x8,%esp
80103b7b:	56                   	push   %esi
80103b7c:	53                   	push   %ebx
80103b7d:	e8 7a fc ff ff       	call   801037fc <sleep>

void
acquiresleep(struct sleeplock *lk)
{
  acquire(&lk->lk);
  while (lk->locked) {
80103b82:	83 c4 10             	add    $0x10,%esp
80103b85:	8b 03                	mov    (%ebx),%eax
80103b87:	85 c0                	test   %eax,%eax
80103b89:	75 ed                	jne    80103b78 <acquiresleep+0x20>
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
80103b8b:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80103b91:	e8 2a f7 ff ff       	call   801032c0 <myproc>
80103b96:	8b 40 10             	mov    0x10(%eax),%eax
80103b99:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80103b9c:	89 75 08             	mov    %esi,0x8(%ebp)
}
80103b9f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103ba2:	5b                   	pop    %ebx
80103ba3:	5e                   	pop    %esi
80103ba4:	5d                   	pop    %ebp
  while (lk->locked) {
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
  lk->pid = myproc()->pid;
  release(&lk->lk);
80103ba5:	e9 5a 02 00 00       	jmp    80103e04 <release>
80103baa:	66 90                	xchg   %ax,%ax

80103bac <releasesleep>:
}

void
releasesleep(struct sleeplock *lk)
{
80103bac:	55                   	push   %ebp
80103bad:	89 e5                	mov    %esp,%ebp
80103baf:	56                   	push   %esi
80103bb0:	53                   	push   %ebx
80103bb1:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80103bb4:	8d 73 04             	lea    0x4(%ebx),%esi
80103bb7:	83 ec 0c             	sub    $0xc,%esp
80103bba:	56                   	push   %esi
80103bbb:	e8 ac 01 00 00       	call   80103d6c <acquire>
  lk->locked = 0;
80103bc0:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80103bc6:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80103bcd:	89 1c 24             	mov    %ebx,(%esp)
80103bd0:	e8 cf fd ff ff       	call   801039a4 <wakeup>
  release(&lk->lk);
80103bd5:	83 c4 10             	add    $0x10,%esp
80103bd8:	89 75 08             	mov    %esi,0x8(%ebp)
}
80103bdb:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103bde:	5b                   	pop    %ebx
80103bdf:	5e                   	pop    %esi
80103be0:	5d                   	pop    %ebp
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
80103be1:	e9 1e 02 00 00       	jmp    80103e04 <release>
80103be6:	66 90                	xchg   %ax,%ax

80103be8 <holdingsleep>:
}

int
holdingsleep(struct sleeplock *lk)
{
80103be8:	55                   	push   %ebp
80103be9:	89 e5                	mov    %esp,%ebp
80103beb:	56                   	push   %esi
80103bec:	53                   	push   %ebx
80103bed:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80103bf0:	8d 73 04             	lea    0x4(%ebx),%esi
80103bf3:	83 ec 0c             	sub    $0xc,%esp
80103bf6:	56                   	push   %esi
80103bf7:	e8 70 01 00 00       	call   80103d6c <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80103bfc:	83 c4 10             	add    $0x10,%esp
80103bff:	8b 03                	mov    (%ebx),%eax
80103c01:	85 c0                	test   %eax,%eax
80103c03:	75 17                	jne    80103c1c <holdingsleep+0x34>
80103c05:	31 db                	xor    %ebx,%ebx
  release(&lk->lk);
80103c07:	83 ec 0c             	sub    $0xc,%esp
80103c0a:	56                   	push   %esi
80103c0b:	e8 f4 01 00 00       	call   80103e04 <release>
  return r;
}
80103c10:	89 d8                	mov    %ebx,%eax
80103c12:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103c15:	5b                   	pop    %ebx
80103c16:	5e                   	pop    %esi
80103c17:	5d                   	pop    %ebp
80103c18:	c3                   	ret    
80103c19:	8d 76 00             	lea    0x0(%esi),%esi
holdingsleep(struct sleeplock *lk)
{
  int r;
  
  acquire(&lk->lk);
  r = lk->locked && (lk->pid == myproc()->pid);
80103c1c:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80103c1f:	e8 9c f6 ff ff       	call   801032c0 <myproc>
80103c24:	39 58 10             	cmp    %ebx,0x10(%eax)
80103c27:	0f 94 c3             	sete   %bl
80103c2a:	0f b6 db             	movzbl %bl,%ebx
80103c2d:	eb d8                	jmp    80103c07 <holdingsleep+0x1f>
80103c2f:	90                   	nop

80103c30 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80103c30:	55                   	push   %ebp
80103c31:	89 e5                	mov    %esp,%ebp
80103c33:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80103c36:	8b 55 0c             	mov    0xc(%ebp),%edx
80103c39:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
80103c3c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
80103c42:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80103c49:	5d                   	pop    %ebp
80103c4a:	c3                   	ret    
80103c4b:	90                   	nop

80103c4c <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80103c4c:	55                   	push   %ebp
80103c4d:	89 e5                	mov    %esp,%ebp
80103c4f:	53                   	push   %ebx
80103c50:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80103c53:	8b 45 08             	mov    0x8(%ebp),%eax
80103c56:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
80103c59:	31 d2                	xor    %edx,%edx
80103c5b:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80103c5c:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80103c62:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80103c68:	77 12                	ja     80103c7c <getcallerpcs+0x30>
      break;
    pcs[i] = ebp[1];     // saved %eip
80103c6a:	8b 58 04             	mov    0x4(%eax),%ebx
80103c6d:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
    ebp = (uint*)ebp[0]; // saved %ebp
80103c70:	8b 00                	mov    (%eax),%eax
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80103c72:	42                   	inc    %edx
80103c73:	83 fa 0a             	cmp    $0xa,%edx
80103c76:	75 e4                	jne    80103c5c <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80103c78:	5b                   	pop    %ebx
80103c79:	5d                   	pop    %ebp
80103c7a:	c3                   	ret    
80103c7b:	90                   	nop
80103c7c:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80103c7f:	8d 51 28             	lea    0x28(%ecx),%edx
80103c82:	66 90                	xchg   %ax,%ax
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80103c84:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80103c8a:	83 c0 04             	add    $0x4,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80103c8d:	39 d0                	cmp    %edx,%eax
80103c8f:	75 f3                	jne    80103c84 <getcallerpcs+0x38>
    pcs[i] = 0;
}
80103c91:	5b                   	pop    %ebx
80103c92:	5d                   	pop    %ebp
80103c93:	c3                   	ret    

80103c94 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80103c94:	55                   	push   %ebp
80103c95:	89 e5                	mov    %esp,%ebp
80103c97:	53                   	push   %ebx
80103c98:	52                   	push   %edx
80103c99:	9c                   	pushf  
80103c9a:	5b                   	pop    %ebx
}

static inline void
cli(void)
{
  asm volatile("cli");
80103c9b:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80103c9c:	e8 73 f5 ff ff       	call   80103214 <mycpu>
80103ca1:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
80103ca7:	85 c9                	test   %ecx,%ecx
80103ca9:	75 11                	jne    80103cbc <pushcli+0x28>
    mycpu()->intena = eflags & FL_IF;
80103cab:	e8 64 f5 ff ff       	call   80103214 <mycpu>
80103cb0:	81 e3 00 02 00 00    	and    $0x200,%ebx
80103cb6:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
80103cbc:	e8 53 f5 ff ff       	call   80103214 <mycpu>
80103cc1:	ff 80 a4 00 00 00    	incl   0xa4(%eax)
}
80103cc7:	58                   	pop    %eax
80103cc8:	5b                   	pop    %ebx
80103cc9:	5d                   	pop    %ebp
80103cca:	c3                   	ret    
80103ccb:	90                   	nop

80103ccc <popcli>:

void
popcli(void)
{
80103ccc:	55                   	push   %ebp
80103ccd:	89 e5                	mov    %esp,%ebp
80103ccf:	83 ec 08             	sub    $0x8,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103cd2:	9c                   	pushf  
80103cd3:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103cd4:	f6 c4 02             	test   $0x2,%ah
80103cd7:	75 4a                	jne    80103d23 <popcli+0x57>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80103cd9:	e8 36 f5 ff ff       	call   80103214 <mycpu>
80103cde:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
80103ce4:	8d 51 ff             	lea    -0x1(%ecx),%edx
80103ce7:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
80103ced:	85 d2                	test   %edx,%edx
80103cef:	78 25                	js     80103d16 <popcli+0x4a>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80103cf1:	e8 1e f5 ff ff       	call   80103214 <mycpu>
80103cf6:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80103cfc:	85 d2                	test   %edx,%edx
80103cfe:	74 04                	je     80103d04 <popcli+0x38>
    sti();
}
80103d00:	c9                   	leave  
80103d01:	c3                   	ret    
80103d02:	66 90                	xchg   %ax,%ax
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80103d04:	e8 0b f5 ff ff       	call   80103214 <mycpu>
80103d09:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80103d0f:	85 c0                	test   %eax,%eax
80103d11:	74 ed                	je     80103d00 <popcli+0x34>
}

static inline void
sti(void)
{
  asm volatile("sti");
80103d13:	fb                   	sti    
    sti();
}
80103d14:	c9                   	leave  
80103d15:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
80103d16:	83 ec 0c             	sub    $0xc,%esp
80103d19:	68 fa 6b 10 80       	push   $0x80106bfa
80103d1e:	e8 15 c6 ff ff       	call   80100338 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
80103d23:	83 ec 0c             	sub    $0xc,%esp
80103d26:	68 e3 6b 10 80       	push   $0x80106be3
80103d2b:	e8 08 c6 ff ff       	call   80100338 <panic>

80103d30 <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80103d30:	55                   	push   %ebp
80103d31:	89 e5                	mov    %esp,%ebp
80103d33:	53                   	push   %ebx
80103d34:	51                   	push   %ecx
80103d35:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  pushcli();
80103d38:	e8 57 ff ff ff       	call   80103c94 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80103d3d:	8b 03                	mov    (%ebx),%eax
80103d3f:	85 c0                	test   %eax,%eax
80103d41:	75 0d                	jne    80103d50 <holding+0x20>
80103d43:	31 db                	xor    %ebx,%ebx
  popcli();
80103d45:	e8 82 ff ff ff       	call   80103ccc <popcli>
  return r;
}
80103d4a:	89 d8                	mov    %ebx,%eax
80103d4c:	5a                   	pop    %edx
80103d4d:	5b                   	pop    %ebx
80103d4e:	5d                   	pop    %ebp
80103d4f:	c3                   	ret    
int
holding(struct spinlock *lock)
{
  int r;
  pushcli();
  r = lock->locked && lock->cpu == mycpu();
80103d50:	8b 5b 08             	mov    0x8(%ebx),%ebx
80103d53:	e8 bc f4 ff ff       	call   80103214 <mycpu>
80103d58:	39 c3                	cmp    %eax,%ebx
80103d5a:	0f 94 c3             	sete   %bl
80103d5d:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80103d60:	e8 67 ff ff ff       	call   80103ccc <popcli>
  return r;
}
80103d65:	89 d8                	mov    %ebx,%eax
80103d67:	5a                   	pop    %edx
80103d68:	5b                   	pop    %ebx
80103d69:	5d                   	pop    %ebp
80103d6a:	c3                   	ret    
80103d6b:	90                   	nop

80103d6c <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80103d6c:	55                   	push   %ebp
80103d6d:	89 e5                	mov    %esp,%ebp
80103d6f:	56                   	push   %esi
80103d70:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80103d71:	e8 1e ff ff ff       	call   80103c94 <pushcli>
  if(holding(lk))
80103d76:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103d79:	83 ec 0c             	sub    $0xc,%esp
80103d7c:	53                   	push   %ebx
80103d7d:	e8 ae ff ff ff       	call   80103d30 <holding>
80103d82:	83 c4 10             	add    $0x10,%esp
80103d85:	85 c0                	test   %eax,%eax
80103d87:	75 6b                	jne    80103df4 <acquire+0x88>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80103d89:	ba 01 00 00 00       	mov    $0x1,%edx
80103d8e:	eb 03                	jmp    80103d93 <acquire+0x27>
80103d90:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103d93:	89 d0                	mov    %edx,%eax
80103d95:	f0 87 03             	lock xchg %eax,(%ebx)
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
80103d98:	85 c0                	test   %eax,%eax
80103d9a:	75 f4                	jne    80103d90 <acquire+0x24>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
80103d9c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
80103da1:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103da4:	e8 6b f4 ff ff       	call   80103214 <mycpu>
80103da9:	89 43 08             	mov    %eax,0x8(%ebx)
  getcallerpcs(&lk, lk->pcs);
80103dac:	8d 73 0c             	lea    0xc(%ebx),%esi
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80103daf:	31 c0                	xor    %eax,%eax
getcallerpcs(void *v, uint pcs[])
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80103db1:	89 ea                	mov    %ebp,%edx
80103db3:	90                   	nop
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80103db4:	8d 8a 00 00 00 80    	lea    -0x80000000(%edx),%ecx
80103dba:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80103dc0:	77 16                	ja     80103dd8 <acquire+0x6c>
      break;
    pcs[i] = ebp[1];     // saved %eip
80103dc2:	8b 4a 04             	mov    0x4(%edx),%ecx
80103dc5:	89 0c 86             	mov    %ecx,(%esi,%eax,4)
    ebp = (uint*)ebp[0]; // saved %ebp
80103dc8:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80103dca:	40                   	inc    %eax
80103dcb:	83 f8 0a             	cmp    $0xa,%eax
80103dce:	75 e4                	jne    80103db4 <acquire+0x48>
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
}
80103dd0:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103dd3:	5b                   	pop    %ebx
80103dd4:	5e                   	pop    %esi
80103dd5:	5d                   	pop    %ebp
80103dd6:	c3                   	ret    
80103dd7:	90                   	nop
80103dd8:	8d 04 86             	lea    (%esi,%eax,4),%eax
80103ddb:	8d 53 34             	lea    0x34(%ebx),%edx
80103dde:	66 90                	xchg   %ax,%ax
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80103de0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80103de6:	83 c0 04             	add    $0x4,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80103de9:	39 d0                	cmp    %edx,%eax
80103deb:	75 f3                	jne    80103de0 <acquire+0x74>
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
}
80103ded:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103df0:	5b                   	pop    %ebx
80103df1:	5e                   	pop    %esi
80103df2:	5d                   	pop    %ebp
80103df3:	c3                   	ret    
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");
80103df4:	83 ec 0c             	sub    $0xc,%esp
80103df7:	68 01 6c 10 80       	push   $0x80106c01
80103dfc:	e8 37 c5 ff ff       	call   80100338 <panic>
80103e01:	8d 76 00             	lea    0x0(%esi),%esi

80103e04 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
80103e04:	55                   	push   %ebp
80103e05:	89 e5                	mov    %esp,%ebp
80103e07:	53                   	push   %ebx
80103e08:	83 ec 10             	sub    $0x10,%esp
80103e0b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
80103e0e:	53                   	push   %ebx
80103e0f:	e8 1c ff ff ff       	call   80103d30 <holding>
80103e14:	83 c4 10             	add    $0x10,%esp
80103e17:	85 c0                	test   %eax,%eax
80103e19:	74 22                	je     80103e3d <release+0x39>
    panic("release");

  lk->pcs[0] = 0;
80103e1b:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80103e22:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
80103e29:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80103e2e:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)

  popcli();
}
80103e34:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103e37:	c9                   	leave  
  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );

  popcli();
80103e38:	e9 8f fe ff ff       	jmp    80103ccc <popcli>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
80103e3d:	83 ec 0c             	sub    $0xc,%esp
80103e40:	68 09 6c 10 80       	push   $0x80106c09
80103e45:	e8 ee c4 ff ff       	call   80100338 <panic>
80103e4a:	66 90                	xchg   %ax,%ax

80103e4c <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80103e4c:	55                   	push   %ebp
80103e4d:	89 e5                	mov    %esp,%ebp
80103e4f:	57                   	push   %edi
80103e50:	53                   	push   %ebx
80103e51:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if ((int)dst%4 == 0 && n%4 == 0){
80103e54:	f6 c3 03             	test   $0x3,%bl
80103e57:	75 06                	jne    80103e5f <memset+0x13>
80103e59:	f6 45 10 03          	testb  $0x3,0x10(%ebp)
80103e5d:	74 11                	je     80103e70 <memset+0x24>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
80103e5f:	89 df                	mov    %ebx,%edi
80103e61:	8b 4d 10             	mov    0x10(%ebp),%ecx
80103e64:	8b 45 0c             	mov    0xc(%ebp),%eax
80103e67:	fc                   	cld    
80103e68:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80103e6a:	89 d8                	mov    %ebx,%eax
80103e6c:	5b                   	pop    %ebx
80103e6d:	5f                   	pop    %edi
80103e6e:	5d                   	pop    %ebp
80103e6f:	c3                   	ret    

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
    c &= 0xFF;
80103e70:	0f b6 55 0c          	movzbl 0xc(%ebp),%edx
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
80103e74:	8b 4d 10             	mov    0x10(%ebp),%ecx
80103e77:	c1 e9 02             	shr    $0x2,%ecx
80103e7a:	89 d7                	mov    %edx,%edi
80103e7c:	c1 e7 18             	shl    $0x18,%edi
80103e7f:	89 d0                	mov    %edx,%eax
80103e81:	c1 e0 10             	shl    $0x10,%eax
80103e84:	09 f8                	or     %edi,%eax
80103e86:	09 d0                	or     %edx,%eax
80103e88:	c1 e2 08             	shl    $0x8,%edx
80103e8b:	09 d0                	or     %edx,%eax
80103e8d:	89 df                	mov    %ebx,%edi
80103e8f:	fc                   	cld    
80103e90:	f3 ab                	rep stos %eax,%es:(%edi)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80103e92:	89 d8                	mov    %ebx,%eax
80103e94:	5b                   	pop    %ebx
80103e95:	5f                   	pop    %edi
80103e96:	5d                   	pop    %ebp
80103e97:	c3                   	ret    

80103e98 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80103e98:	55                   	push   %ebp
80103e99:	89 e5                	mov    %esp,%ebp
80103e9b:	57                   	push   %edi
80103e9c:	56                   	push   %esi
80103e9d:	53                   	push   %ebx
80103e9e:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103ea1:	8b 75 0c             	mov    0xc(%ebp),%esi
80103ea4:	8b 45 10             	mov    0x10(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80103ea7:	85 c0                	test   %eax,%eax
80103ea9:	74 22                	je     80103ecd <memcmp+0x35>
    if(*s1 != *s2)
80103eab:	8a 13                	mov    (%ebx),%dl
80103ead:	0f b6 0e             	movzbl (%esi),%ecx
80103eb0:	38 d1                	cmp    %dl,%cl
80103eb2:	75 20                	jne    80103ed4 <memcmp+0x3c>
80103eb4:	8d 78 ff             	lea    -0x1(%eax),%edi
80103eb7:	31 c0                	xor    %eax,%eax
80103eb9:	eb 0e                	jmp    80103ec9 <memcmp+0x31>
80103ebb:	90                   	nop
80103ebc:	8a 54 03 01          	mov    0x1(%ebx,%eax,1),%dl
80103ec0:	40                   	inc    %eax
80103ec1:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80103ec5:	38 ca                	cmp    %cl,%dl
80103ec7:	75 0b                	jne    80103ed4 <memcmp+0x3c>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80103ec9:	39 f8                	cmp    %edi,%eax
80103ecb:	75 ef                	jne    80103ebc <memcmp+0x24>
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
80103ecd:	31 c0                	xor    %eax,%eax
}
80103ecf:	5b                   	pop    %ebx
80103ed0:	5e                   	pop    %esi
80103ed1:	5f                   	pop    %edi
80103ed2:	5d                   	pop    %ebp
80103ed3:	c3                   	ret    

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
80103ed4:	0f b6 c2             	movzbl %dl,%eax
80103ed7:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
80103ed9:	5b                   	pop    %ebx
80103eda:	5e                   	pop    %esi
80103edb:	5f                   	pop    %edi
80103edc:	5d                   	pop    %ebp
80103edd:	c3                   	ret    
80103ede:	66 90                	xchg   %ax,%ax

80103ee0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80103ee0:	55                   	push   %ebp
80103ee1:	89 e5                	mov    %esp,%ebp
80103ee3:	57                   	push   %edi
80103ee4:	56                   	push   %esi
80103ee5:	53                   	push   %ebx
80103ee6:	8b 45 08             	mov    0x8(%ebp),%eax
80103ee9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80103eec:	8b 7d 10             	mov    0x10(%ebp),%edi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80103eef:	39 c3                	cmp    %eax,%ebx
80103ef1:	73 29                	jae    80103f1c <memmove+0x3c>
80103ef3:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80103ef6:	39 f0                	cmp    %esi,%eax
80103ef8:	73 22                	jae    80103f1c <memmove+0x3c>
    s += n;
    d += n;
    while(n-- > 0)
80103efa:	8d 57 ff             	lea    -0x1(%edi),%edx
80103efd:	85 ff                	test   %edi,%edi
80103eff:	74 13                	je     80103f14 <memmove+0x34>
      *--d = *--s;
80103f01:	29 fe                	sub    %edi,%esi
80103f03:	89 f1                	mov    %esi,%ecx
80103f05:	8d 76 00             	lea    0x0(%esi),%esi
80103f08:	8a 1c 11             	mov    (%ecx,%edx,1),%bl
80103f0b:	88 1c 10             	mov    %bl,(%eax,%edx,1)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
80103f0e:	4a                   	dec    %edx
80103f0f:	83 fa ff             	cmp    $0xffffffff,%edx
80103f12:	75 f4                	jne    80103f08 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80103f14:	5b                   	pop    %ebx
80103f15:	5e                   	pop    %esi
80103f16:	5f                   	pop    %edi
80103f17:	5d                   	pop    %ebp
80103f18:	c3                   	ret    
80103f19:	8d 76 00             	lea    0x0(%esi),%esi
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80103f1c:	31 d2                	xor    %edx,%edx
80103f1e:	85 ff                	test   %edi,%edi
80103f20:	74 f2                	je     80103f14 <memmove+0x34>
80103f22:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80103f24:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
80103f27:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80103f2a:	42                   	inc    %edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80103f2b:	39 d7                	cmp    %edx,%edi
80103f2d:	75 f5                	jne    80103f24 <memmove+0x44>
      *d++ = *s++;

  return dst;
}
80103f2f:	5b                   	pop    %ebx
80103f30:	5e                   	pop    %esi
80103f31:	5f                   	pop    %edi
80103f32:	5d                   	pop    %ebp
80103f33:	c3                   	ret    

80103f34 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80103f34:	55                   	push   %ebp
80103f35:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80103f37:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80103f38:	e9 a3 ff ff ff       	jmp    80103ee0 <memmove>
80103f3d:	8d 76 00             	lea    0x0(%esi),%esi

80103f40 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80103f40:	55                   	push   %ebp
80103f41:	89 e5                	mov    %esp,%ebp
80103f43:	57                   	push   %edi
80103f44:	56                   	push   %esi
80103f45:	53                   	push   %ebx
80103f46:	8b 7d 08             	mov    0x8(%ebp),%edi
80103f49:	8b 75 0c             	mov    0xc(%ebp),%esi
80103f4c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  while(n > 0 && *p && *p == *q)
80103f4f:	85 db                	test   %ebx,%ebx
80103f51:	74 2c                	je     80103f7f <strncmp+0x3f>
80103f53:	8a 17                	mov    (%edi),%dl
80103f55:	0f b6 0e             	movzbl (%esi),%ecx
80103f58:	84 d2                	test   %dl,%dl
80103f5a:	74 3a                	je     80103f96 <strncmp+0x56>
80103f5c:	38 d1                	cmp    %dl,%cl
80103f5e:	75 2c                	jne    80103f8c <strncmp+0x4c>
80103f60:	8d 47 01             	lea    0x1(%edi),%eax
80103f63:	01 df                	add    %ebx,%edi
80103f65:	eb 11                	jmp    80103f78 <strncmp+0x38>
80103f67:	90                   	nop
80103f68:	8a 10                	mov    (%eax),%dl
80103f6a:	84 d2                	test   %dl,%dl
80103f6c:	74 1a                	je     80103f88 <strncmp+0x48>
80103f6e:	0f b6 0b             	movzbl (%ebx),%ecx
80103f71:	40                   	inc    %eax
80103f72:	89 de                	mov    %ebx,%esi
80103f74:	38 ca                	cmp    %cl,%dl
80103f76:	75 14                	jne    80103f8c <strncmp+0x4c>
    n--, p++, q++;
80103f78:	8d 5e 01             	lea    0x1(%esi),%ebx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80103f7b:	39 c7                	cmp    %eax,%edi
80103f7d:	75 e9                	jne    80103f68 <strncmp+0x28>
    n--, p++, q++;
  if(n == 0)
    return 0;
80103f7f:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
80103f81:	5b                   	pop    %ebx
80103f82:	5e                   	pop    %esi
80103f83:	5f                   	pop    %edi
80103f84:	5d                   	pop    %ebp
80103f85:	c3                   	ret    
80103f86:	66 90                	xchg   %ax,%ax
80103f88:	0f b6 4e 01          	movzbl 0x1(%esi),%ecx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80103f8c:	0f b6 c2             	movzbl %dl,%eax
80103f8f:	29 c8                	sub    %ecx,%eax
}
80103f91:	5b                   	pop    %ebx
80103f92:	5e                   	pop    %esi
80103f93:	5f                   	pop    %edi
80103f94:	5d                   	pop    %ebp
80103f95:	c3                   	ret    
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80103f96:	31 d2                	xor    %edx,%edx
80103f98:	eb f2                	jmp    80103f8c <strncmp+0x4c>
80103f9a:	66 90                	xchg   %ax,%ax

80103f9c <strncpy>:
  return (uchar)*p - (uchar)*q;
}

char*
strncpy(char *s, const char *t, int n)
{
80103f9c:	55                   	push   %ebp
80103f9d:	89 e5                	mov    %esp,%ebp
80103f9f:	56                   	push   %esi
80103fa0:	53                   	push   %ebx
80103fa1:	8b 45 08             	mov    0x8(%ebp),%eax
80103fa4:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80103fa7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80103faa:	89 c2                	mov    %eax,%edx
80103fac:	eb 10                	jmp    80103fbe <strncpy+0x22>
80103fae:	66 90                	xchg   %ax,%ax
80103fb0:	42                   	inc    %edx
80103fb1:	43                   	inc    %ebx
80103fb2:	8a 4b ff             	mov    -0x1(%ebx),%cl
80103fb5:	88 4a ff             	mov    %cl,-0x1(%edx)
80103fb8:	84 c9                	test   %cl,%cl
80103fba:	74 09                	je     80103fc5 <strncpy+0x29>
80103fbc:	89 f1                	mov    %esi,%ecx
80103fbe:	8d 71 ff             	lea    -0x1(%ecx),%esi
80103fc1:	85 c9                	test   %ecx,%ecx
80103fc3:	7f eb                	jg     80103fb0 <strncpy+0x14>
    ;
  while(n-- > 0)
80103fc5:	31 c9                	xor    %ecx,%ecx
80103fc7:	85 f6                	test   %esi,%esi
80103fc9:	7e 0e                	jle    80103fd9 <strncpy+0x3d>
80103fcb:	90                   	nop
    *s++ = 0;
80103fcc:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80103fd0:	41                   	inc    %ecx
80103fd1:	89 f3                	mov    %esi,%ebx
80103fd3:	29 cb                	sub    %ecx,%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
80103fd5:	85 db                	test   %ebx,%ebx
80103fd7:	7f f3                	jg     80103fcc <strncpy+0x30>
    *s++ = 0;
  return os;
}
80103fd9:	5b                   	pop    %ebx
80103fda:	5e                   	pop    %esi
80103fdb:	5d                   	pop    %ebp
80103fdc:	c3                   	ret    
80103fdd:	8d 76 00             	lea    0x0(%esi),%esi

80103fe0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80103fe0:	55                   	push   %ebp
80103fe1:	89 e5                	mov    %esp,%ebp
80103fe3:	56                   	push   %esi
80103fe4:	53                   	push   %ebx
80103fe5:	8b 45 08             	mov    0x8(%ebp),%eax
80103fe8:	8b 55 0c             	mov    0xc(%ebp),%edx
80103feb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  if(n <= 0)
80103fee:	85 c9                	test   %ecx,%ecx
80103ff0:	7e 1d                	jle    8010400f <safestrcpy+0x2f>
80103ff2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80103ff6:	89 c1                	mov    %eax,%ecx
80103ff8:	eb 0e                	jmp    80104008 <safestrcpy+0x28>
80103ffa:	66 90                	xchg   %ax,%ax
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80103ffc:	41                   	inc    %ecx
80103ffd:	42                   	inc    %edx
80103ffe:	8a 5a ff             	mov    -0x1(%edx),%bl
80104001:	88 59 ff             	mov    %bl,-0x1(%ecx)
80104004:	84 db                	test   %bl,%bl
80104006:	74 04                	je     8010400c <safestrcpy+0x2c>
80104008:	39 f2                	cmp    %esi,%edx
8010400a:	75 f0                	jne    80103ffc <safestrcpy+0x1c>
    ;
  *s = 0;
8010400c:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
8010400f:	5b                   	pop    %ebx
80104010:	5e                   	pop    %esi
80104011:	5d                   	pop    %ebp
80104012:	c3                   	ret    
80104013:	90                   	nop

80104014 <strlen>:

int
strlen(const char *s)
{
80104014:	55                   	push   %ebp
80104015:	89 e5                	mov    %esp,%ebp
80104017:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
8010401a:	31 c0                	xor    %eax,%eax
8010401c:	80 3a 00             	cmpb   $0x0,(%edx)
8010401f:	74 0a                	je     8010402b <strlen+0x17>
80104021:	8d 76 00             	lea    0x0(%esi),%esi
80104024:	40                   	inc    %eax
80104025:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104029:	75 f9                	jne    80104024 <strlen+0x10>
    ;
  return n;
}
8010402b:	5d                   	pop    %ebp
8010402c:	c3                   	ret    

8010402d <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010402d:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104031:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104035:	55                   	push   %ebp
  pushl %ebx
80104036:	53                   	push   %ebx
  pushl %esi
80104037:	56                   	push   %esi
  pushl %edi
80104038:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104039:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
8010403b:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
8010403d:	5f                   	pop    %edi
  popl %esi
8010403e:	5e                   	pop    %esi
  popl %ebx
8010403f:	5b                   	pop    %ebx
  popl %ebp
80104040:	5d                   	pop    %ebp
  ret
80104041:	c3                   	ret    
80104042:	66 90                	xchg   %ax,%ax

80104044 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104044:	55                   	push   %ebp
80104045:	89 e5                	mov    %esp,%ebp
80104047:	53                   	push   %ebx
80104048:	51                   	push   %ecx
80104049:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010404c:	e8 6f f2 ff ff       	call   801032c0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104051:	8b 00                	mov    (%eax),%eax
80104053:	39 d8                	cmp    %ebx,%eax
80104055:	76 15                	jbe    8010406c <fetchint+0x28>
80104057:	8d 53 04             	lea    0x4(%ebx),%edx
8010405a:	39 d0                	cmp    %edx,%eax
8010405c:	72 0e                	jb     8010406c <fetchint+0x28>
    return -1;
  *ip = *(int*)(addr);
8010405e:	8b 13                	mov    (%ebx),%edx
80104060:	8b 45 0c             	mov    0xc(%ebp),%eax
80104063:	89 10                	mov    %edx,(%eax)
  return 0;
80104065:	31 c0                	xor    %eax,%eax
}
80104067:	5a                   	pop    %edx
80104068:	5b                   	pop    %ebx
80104069:	5d                   	pop    %ebp
8010406a:	c3                   	ret    
8010406b:	90                   	nop
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
8010406c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104071:	eb f4                	jmp    80104067 <fetchint+0x23>
80104073:	90                   	nop

80104074 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104074:	55                   	push   %ebp
80104075:	89 e5                	mov    %esp,%ebp
80104077:	53                   	push   %ebx
80104078:	51                   	push   %ecx
80104079:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010407c:	e8 3f f2 ff ff       	call   801032c0 <myproc>

  if(addr >= curproc->sz)
80104081:	39 18                	cmp    %ebx,(%eax)
80104083:	76 21                	jbe    801040a6 <fetchstr+0x32>
    return -1;
  *pp = (char*)addr;
80104085:	89 da                	mov    %ebx,%edx
80104087:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010408a:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
8010408c:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
8010408e:	39 c3                	cmp    %eax,%ebx
80104090:	73 14                	jae    801040a6 <fetchstr+0x32>
    if(*s == 0)
80104092:	80 3b 00             	cmpb   $0x0,(%ebx)
80104095:	75 0a                	jne    801040a1 <fetchstr+0x2d>
80104097:	eb 17                	jmp    801040b0 <fetchstr+0x3c>
80104099:	8d 76 00             	lea    0x0(%esi),%esi
8010409c:	80 3a 00             	cmpb   $0x0,(%edx)
8010409f:	74 0f                	je     801040b0 <fetchstr+0x3c>

  if(addr >= curproc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
801040a1:	42                   	inc    %edx
801040a2:	39 d0                	cmp    %edx,%eax
801040a4:	77 f6                	ja     8010409c <fetchstr+0x28>
{
  char *s, *ep;
  struct proc *curproc = myproc();

  if(addr >= curproc->sz)
    return -1;
801040a6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
801040ab:	5a                   	pop    %edx
801040ac:	5b                   	pop    %ebx
801040ad:	5d                   	pop    %ebp
801040ae:	c3                   	ret    
801040af:	90                   	nop
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
801040b0:	89 d0                	mov    %edx,%eax
801040b2:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
801040b4:	5a                   	pop    %edx
801040b5:	5b                   	pop    %ebx
801040b6:	5d                   	pop    %ebp
801040b7:	c3                   	ret    

801040b8 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801040b8:	55                   	push   %ebp
801040b9:	89 e5                	mov    %esp,%ebp
801040bb:	56                   	push   %esi
801040bc:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801040bd:	e8 fe f1 ff ff       	call   801032c0 <myproc>
801040c2:	8b 40 18             	mov    0x18(%eax),%eax
801040c5:	8b 40 44             	mov    0x44(%eax),%eax
801040c8:	8b 55 08             	mov    0x8(%ebp),%edx
801040cb:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
801040ce:	8d 73 04             	lea    0x4(%ebx),%esi

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();
801040d1:	e8 ea f1 ff ff       	call   801032c0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801040d6:	8b 00                	mov    (%eax),%eax
801040d8:	39 c6                	cmp    %eax,%esi
801040da:	73 18                	jae    801040f4 <argint+0x3c>
801040dc:	8d 53 08             	lea    0x8(%ebx),%edx
801040df:	39 d0                	cmp    %edx,%eax
801040e1:	72 11                	jb     801040f4 <argint+0x3c>
    return -1;
  *ip = *(int*)(addr);
801040e3:	8b 53 04             	mov    0x4(%ebx),%edx
801040e6:	8b 45 0c             	mov    0xc(%ebp),%eax
801040e9:	89 10                	mov    %edx,(%eax)
  return 0;
801040eb:	31 c0                	xor    %eax,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
}
801040ed:	5b                   	pop    %ebx
801040ee:	5e                   	pop    %esi
801040ef:	5d                   	pop    %ebp
801040f0:	c3                   	ret    
801040f1:	8d 76 00             	lea    0x0(%esi),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
801040f4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801040f9:	eb f2                	jmp    801040ed <argint+0x35>
801040fb:	90                   	nop

801040fc <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801040fc:	55                   	push   %ebp
801040fd:	89 e5                	mov    %esp,%ebp
801040ff:	56                   	push   %esi
80104100:	53                   	push   %ebx
80104101:	83 ec 10             	sub    $0x10,%esp
80104104:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80104107:	e8 b4 f1 ff ff       	call   801032c0 <myproc>
8010410c:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
8010410e:	83 ec 08             	sub    $0x8,%esp
80104111:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104114:	50                   	push   %eax
80104115:	ff 75 08             	pushl  0x8(%ebp)
80104118:	e8 9b ff ff ff       	call   801040b8 <argint>
8010411d:	83 c4 10             	add    $0x10,%esp
80104120:	85 c0                	test   %eax,%eax
80104122:	78 24                	js     80104148 <argptr+0x4c>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104124:	85 db                	test   %ebx,%ebx
80104126:	78 20                	js     80104148 <argptr+0x4c>
80104128:	8b 16                	mov    (%esi),%edx
8010412a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010412d:	39 c2                	cmp    %eax,%edx
8010412f:	76 17                	jbe    80104148 <argptr+0x4c>
80104131:	01 c3                	add    %eax,%ebx
80104133:	39 da                	cmp    %ebx,%edx
80104135:	72 11                	jb     80104148 <argptr+0x4c>
    return -1;
  *pp = (char*)i;
80104137:	8b 55 0c             	mov    0xc(%ebp),%edx
8010413a:	89 02                	mov    %eax,(%edx)
  return 0;
8010413c:	31 c0                	xor    %eax,%eax
}
8010413e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104141:	5b                   	pop    %ebx
80104142:	5e                   	pop    %esi
80104143:	5d                   	pop    %ebp
80104144:	c3                   	ret    
80104145:	8d 76 00             	lea    0x0(%esi),%esi
{
  int i;
  struct proc *curproc = myproc();
 
  if(argint(n, &i) < 0)
    return -1;
80104148:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
    return -1;
  *pp = (char*)i;
  return 0;
}
8010414d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104150:	5b                   	pop    %ebx
80104151:	5e                   	pop    %esi
80104152:	5d                   	pop    %ebp
80104153:	c3                   	ret    

80104154 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104154:	55                   	push   %ebp
80104155:	89 e5                	mov    %esp,%ebp
80104157:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
8010415a:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010415d:	50                   	push   %eax
8010415e:	ff 75 08             	pushl  0x8(%ebp)
80104161:	e8 52 ff ff ff       	call   801040b8 <argint>
80104166:	83 c4 10             	add    $0x10,%esp
80104169:	85 c0                	test   %eax,%eax
8010416b:	78 13                	js     80104180 <argstr+0x2c>
    return -1;
  return fetchstr(addr, pp);
8010416d:	83 ec 08             	sub    $0x8,%esp
80104170:	ff 75 0c             	pushl  0xc(%ebp)
80104173:	ff 75 f4             	pushl  -0xc(%ebp)
80104176:	e8 f9 fe ff ff       	call   80104074 <fetchstr>
8010417b:	83 c4 10             	add    $0x10,%esp
}
8010417e:	c9                   	leave  
8010417f:	c3                   	ret    
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
80104180:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
80104185:	c9                   	leave  
80104186:	c3                   	ret    
80104187:	90                   	nop

80104188 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
80104188:	55                   	push   %ebp
80104189:	89 e5                	mov    %esp,%ebp
8010418b:	53                   	push   %ebx
8010418c:	83 ec 14             	sub    $0x14,%esp
  int num;
  struct proc *curproc = myproc();
8010418f:	e8 2c f1 ff ff       	call   801032c0 <myproc>

  num = curproc->tf->eax;
80104194:	8b 58 18             	mov    0x18(%eax),%ebx
80104197:	8b 53 1c             	mov    0x1c(%ebx),%edx
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
8010419a:	8d 4a ff             	lea    -0x1(%edx),%ecx
8010419d:	83 f9 14             	cmp    $0x14,%ecx
801041a0:	77 16                	ja     801041b8 <syscall+0x30>
801041a2:	8b 0c 95 40 6c 10 80 	mov    -0x7fef93c0(,%edx,4),%ecx
801041a9:	85 c9                	test   %ecx,%ecx
801041ab:	74 0b                	je     801041b8 <syscall+0x30>
    curproc->tf->eax = syscalls[num]();
801041ad:	ff d1                	call   *%ecx
801041af:	89 43 1c             	mov    %eax,0x1c(%ebx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
801041b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801041b5:	c9                   	leave  
801041b6:	c3                   	ret    
801041b7:	90                   	nop

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
801041b8:	52                   	push   %edx
            curproc->pid, curproc->name, num);
801041b9:	8d 50 6c             	lea    0x6c(%eax),%edx

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
801041bc:	52                   	push   %edx
801041bd:	ff 70 10             	pushl  0x10(%eax)
801041c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
801041c3:	68 11 6c 10 80       	push   $0x80106c11
801041c8:	e8 2b c4 ff ff       	call   801005f8 <cprintf>
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
801041cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041d0:	8b 40 18             	mov    0x18(%eax),%eax
801041d3:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
801041da:	83 c4 10             	add    $0x10,%esp
  }
}
801041dd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801041e0:	c9                   	leave  
801041e1:	c3                   	ret    
801041e2:	66 90                	xchg   %ax,%ax

801041e4 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
801041e4:	55                   	push   %ebp
801041e5:	89 e5                	mov    %esp,%ebp
801041e7:	57                   	push   %edi
801041e8:	56                   	push   %esi
801041e9:	53                   	push   %ebx
801041ea:	83 ec 34             	sub    $0x34,%esp
801041ed:	89 55 d4             	mov    %edx,-0x2c(%ebp)
801041f0:	89 4d d0             	mov    %ecx,-0x30(%ebp)
801041f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
801041f6:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801041f9:	8d 75 da             	lea    -0x26(%ebp),%esi
801041fc:	56                   	push   %esi
801041fd:	50                   	push   %eax
801041fe:	e8 71 da ff ff       	call   80101c74 <nameiparent>
80104203:	83 c4 10             	add    $0x10,%esp
80104206:	85 c0                	test   %eax,%eax
80104208:	0f 84 da 00 00 00    	je     801042e8 <create+0x104>
8010420e:	89 c7                	mov    %eax,%edi
    return 0;
  ilock(dp);
80104210:	83 ec 0c             	sub    $0xc,%esp
80104213:	50                   	push   %eax
80104214:	e8 93 d2 ff ff       	call   801014ac <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80104219:	83 c4 0c             	add    $0xc,%esp
8010421c:	6a 00                	push   $0x0
8010421e:	56                   	push   %esi
8010421f:	57                   	push   %edi
80104220:	e8 5b d7 ff ff       	call   80101980 <dirlookup>
80104225:	89 c3                	mov    %eax,%ebx
80104227:	83 c4 10             	add    $0x10,%esp
8010422a:	85 c0                	test   %eax,%eax
8010422c:	74 46                	je     80104274 <create+0x90>
    iunlockput(dp);
8010422e:	83 ec 0c             	sub    $0xc,%esp
80104231:	57                   	push   %edi
80104232:	e8 c9 d4 ff ff       	call   80101700 <iunlockput>
    ilock(ip);
80104237:	89 1c 24             	mov    %ebx,(%esp)
8010423a:	e8 6d d2 ff ff       	call   801014ac <ilock>
    if(type == T_FILE && ip->type == T_FILE)
8010423f:	83 c4 10             	add    $0x10,%esp
80104242:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80104247:	75 13                	jne    8010425c <create+0x78>
80104249:	66 83 7b 50 02       	cmpw   $0x2,0x50(%ebx)
8010424e:	75 0c                	jne    8010425c <create+0x78>
80104250:	89 d8                	mov    %ebx,%eax
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104252:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104255:	5b                   	pop    %ebx
80104256:	5e                   	pop    %esi
80104257:	5f                   	pop    %edi
80104258:	5d                   	pop    %ebp
80104259:	c3                   	ret    
8010425a:	66 90                	xchg   %ax,%ax
  if((ip = dirlookup(dp, name, 0)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
8010425c:	83 ec 0c             	sub    $0xc,%esp
8010425f:	53                   	push   %ebx
80104260:	e8 9b d4 ff ff       	call   80101700 <iunlockput>
    return 0;
80104265:	83 c4 10             	add    $0x10,%esp
80104268:	31 c0                	xor    %eax,%eax
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
8010426a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010426d:	5b                   	pop    %ebx
8010426e:	5e                   	pop    %esi
8010426f:	5f                   	pop    %edi
80104270:	5d                   	pop    %ebp
80104271:	c3                   	ret    
80104272:	66 90                	xchg   %ax,%ax
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80104274:	83 ec 08             	sub    $0x8,%esp
80104277:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
8010427b:	50                   	push   %eax
8010427c:	ff 37                	pushl  (%edi)
8010427e:	e8 d1 d0 ff ff       	call   80101354 <ialloc>
80104283:	89 c3                	mov    %eax,%ebx
80104285:	83 c4 10             	add    $0x10,%esp
80104288:	85 c0                	test   %eax,%eax
8010428a:	0f 84 b5 00 00 00    	je     80104345 <create+0x161>
    panic("create: ialloc");

  ilock(ip);
80104290:	83 ec 0c             	sub    $0xc,%esp
80104293:	50                   	push   %eax
80104294:	e8 13 d2 ff ff       	call   801014ac <ilock>
  ip->major = major;
80104299:	8b 45 d0             	mov    -0x30(%ebp),%eax
8010429c:	66 89 43 52          	mov    %ax,0x52(%ebx)
  ip->minor = minor;
801042a0:	8b 45 cc             	mov    -0x34(%ebp),%eax
801042a3:	66 89 43 54          	mov    %ax,0x54(%ebx)
  ip->nlink = 1;
801042a7:	66 c7 43 56 01 00    	movw   $0x1,0x56(%ebx)
  iupdate(ip);
801042ad:	89 1c 24             	mov    %ebx,(%esp)
801042b0:	e8 4f d1 ff ff       	call   80101404 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
801042b5:	83 c4 10             	add    $0x10,%esp
801042b8:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
801042bd:	74 31                	je     801042f0 <create+0x10c>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
801042bf:	50                   	push   %eax
801042c0:	ff 73 04             	pushl  0x4(%ebx)
801042c3:	56                   	push   %esi
801042c4:	57                   	push   %edi
801042c5:	e8 de d8 ff ff       	call   80101ba8 <dirlink>
801042ca:	83 c4 10             	add    $0x10,%esp
801042cd:	85 c0                	test   %eax,%eax
801042cf:	78 67                	js     80104338 <create+0x154>
    panic("create: dirlink");

  iunlockput(dp);
801042d1:	83 ec 0c             	sub    $0xc,%esp
801042d4:	57                   	push   %edi
801042d5:	e8 26 d4 ff ff       	call   80101700 <iunlockput>

  return ip;
801042da:	83 c4 10             	add    $0x10,%esp
801042dd:	89 d8                	mov    %ebx,%eax
}
801042df:	8d 65 f4             	lea    -0xc(%ebp),%esp
801042e2:	5b                   	pop    %ebx
801042e3:	5e                   	pop    %esi
801042e4:	5f                   	pop    %edi
801042e5:	5d                   	pop    %ebp
801042e6:	c3                   	ret    
801042e7:	90                   	nop
{
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
801042e8:	31 c0                	xor    %eax,%eax
801042ea:	e9 63 ff ff ff       	jmp    80104252 <create+0x6e>
801042ef:	90                   	nop
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
801042f0:	66 ff 47 56          	incw   0x56(%edi)
    iupdate(dp);
801042f4:	83 ec 0c             	sub    $0xc,%esp
801042f7:	57                   	push   %edi
801042f8:	e8 07 d1 ff ff       	call   80101404 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801042fd:	83 c4 0c             	add    $0xc,%esp
80104300:	ff 73 04             	pushl  0x4(%ebx)
80104303:	68 b4 6c 10 80       	push   $0x80106cb4
80104308:	53                   	push   %ebx
80104309:	e8 9a d8 ff ff       	call   80101ba8 <dirlink>
8010430e:	83 c4 10             	add    $0x10,%esp
80104311:	85 c0                	test   %eax,%eax
80104313:	78 16                	js     8010432b <create+0x147>
80104315:	52                   	push   %edx
80104316:	ff 77 04             	pushl  0x4(%edi)
80104319:	68 b3 6c 10 80       	push   $0x80106cb3
8010431e:	53                   	push   %ebx
8010431f:	e8 84 d8 ff ff       	call   80101ba8 <dirlink>
80104324:	83 c4 10             	add    $0x10,%esp
80104327:	85 c0                	test   %eax,%eax
80104329:	79 94                	jns    801042bf <create+0xdb>
      panic("create dots");
8010432b:	83 ec 0c             	sub    $0xc,%esp
8010432e:	68 a7 6c 10 80       	push   $0x80106ca7
80104333:	e8 00 c0 ff ff       	call   80100338 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
80104338:	83 ec 0c             	sub    $0xc,%esp
8010433b:	68 b6 6c 10 80       	push   $0x80106cb6
80104340:	e8 f3 bf ff ff       	call   80100338 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
80104345:	83 ec 0c             	sub    $0xc,%esp
80104348:	68 98 6c 10 80       	push   $0x80106c98
8010434d:	e8 e6 bf ff ff       	call   80100338 <panic>
80104352:	66 90                	xchg   %ax,%ax

80104354 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104354:	55                   	push   %ebp
80104355:	89 e5                	mov    %esp,%ebp
80104357:	56                   	push   %esi
80104358:	53                   	push   %ebx
80104359:	83 ec 18             	sub    $0x18,%esp
8010435c:	89 c6                	mov    %eax,%esi
8010435e:	89 d3                	mov    %edx,%ebx
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104360:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104363:	50                   	push   %eax
80104364:	6a 00                	push   $0x0
80104366:	e8 4d fd ff ff       	call   801040b8 <argint>
8010436b:	83 c4 10             	add    $0x10,%esp
8010436e:	85 c0                	test   %eax,%eax
80104370:	78 2e                	js     801043a0 <argfd.constprop.0+0x4c>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104372:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104376:	77 28                	ja     801043a0 <argfd.constprop.0+0x4c>
80104378:	e8 43 ef ff ff       	call   801032c0 <myproc>
8010437d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104380:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104384:	85 c0                	test   %eax,%eax
80104386:	74 18                	je     801043a0 <argfd.constprop.0+0x4c>
    return -1;
  if(pfd)
80104388:	85 f6                	test   %esi,%esi
8010438a:	74 02                	je     8010438e <argfd.constprop.0+0x3a>
    *pfd = fd;
8010438c:	89 16                	mov    %edx,(%esi)
  if(pf)
8010438e:	85 db                	test   %ebx,%ebx
80104390:	74 1a                	je     801043ac <argfd.constprop.0+0x58>
    *pf = f;
80104392:	89 03                	mov    %eax,(%ebx)
  return 0;
80104394:	31 c0                	xor    %eax,%eax
}
80104396:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104399:	5b                   	pop    %ebx
8010439a:	5e                   	pop    %esi
8010439b:	5d                   	pop    %ebp
8010439c:	c3                   	ret    
8010439d:	8d 76 00             	lea    0x0(%esi),%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
801043a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
}
801043a5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801043a8:	5b                   	pop    %ebx
801043a9:	5e                   	pop    %esi
801043aa:	5d                   	pop    %ebp
801043ab:	c3                   	ret    
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
801043ac:	31 c0                	xor    %eax,%eax
801043ae:	eb e6                	jmp    80104396 <argfd.constprop.0+0x42>

801043b0 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
801043b0:	55                   	push   %ebp
801043b1:	89 e5                	mov    %esp,%ebp
801043b3:	56                   	push   %esi
801043b4:	53                   	push   %ebx
801043b5:	83 ec 10             	sub    $0x10,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
801043b8:	8d 55 f4             	lea    -0xc(%ebp),%edx
801043bb:	31 c0                	xor    %eax,%eax
801043bd:	e8 92 ff ff ff       	call   80104354 <argfd.constprop.0>
801043c2:	85 c0                	test   %eax,%eax
801043c4:	78 18                	js     801043de <sys_dup+0x2e>
    return -1;
  if((fd=fdalloc(f)) < 0)
801043c6:	8b 75 f4             	mov    -0xc(%ebp),%esi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
801043c9:	e8 f2 ee ff ff       	call   801032c0 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
801043ce:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
801043d0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801043d4:	85 d2                	test   %edx,%edx
801043d6:	74 14                	je     801043ec <sys_dup+0x3c>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801043d8:	43                   	inc    %ebx
801043d9:	83 fb 10             	cmp    $0x10,%ebx
801043dc:	75 f2                	jne    801043d0 <sys_dup+0x20>
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
801043de:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
801043e3:	8d 65 f8             	lea    -0x8(%ebp),%esp
801043e6:	5b                   	pop    %ebx
801043e7:	5e                   	pop    %esi
801043e8:	5d                   	pop    %ebp
801043e9:	c3                   	ret    
801043ea:	66 90                	xchg   %ax,%ax
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
801043ec:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
801043f0:	83 ec 0c             	sub    $0xc,%esp
801043f3:	ff 75 f4             	pushl  -0xc(%ebp)
801043f6:	e8 e1 c8 ff ff       	call   80100cdc <filedup>
  return fd;
801043fb:	83 c4 10             	add    $0x10,%esp
801043fe:	89 d8                	mov    %ebx,%eax
}
80104400:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104403:	5b                   	pop    %ebx
80104404:	5e                   	pop    %esi
80104405:	5d                   	pop    %ebp
80104406:	c3                   	ret    
80104407:	90                   	nop

80104408 <sys_read>:

int
sys_read(void)
{
80104408:	55                   	push   %ebp
80104409:	89 e5                	mov    %esp,%ebp
8010440b:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
8010440e:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104411:	31 c0                	xor    %eax,%eax
80104413:	e8 3c ff ff ff       	call   80104354 <argfd.constprop.0>
80104418:	85 c0                	test   %eax,%eax
8010441a:	78 40                	js     8010445c <sys_read+0x54>
8010441c:	83 ec 08             	sub    $0x8,%esp
8010441f:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104422:	50                   	push   %eax
80104423:	6a 02                	push   $0x2
80104425:	e8 8e fc ff ff       	call   801040b8 <argint>
8010442a:	83 c4 10             	add    $0x10,%esp
8010442d:	85 c0                	test   %eax,%eax
8010442f:	78 2b                	js     8010445c <sys_read+0x54>
80104431:	52                   	push   %edx
80104432:	ff 75 f0             	pushl  -0x10(%ebp)
80104435:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104438:	50                   	push   %eax
80104439:	6a 01                	push   $0x1
8010443b:	e8 bc fc ff ff       	call   801040fc <argptr>
80104440:	83 c4 10             	add    $0x10,%esp
80104443:	85 c0                	test   %eax,%eax
80104445:	78 15                	js     8010445c <sys_read+0x54>
    return -1;
  return fileread(f, p, n);
80104447:	50                   	push   %eax
80104448:	ff 75 f0             	pushl  -0x10(%ebp)
8010444b:	ff 75 f4             	pushl  -0xc(%ebp)
8010444e:	ff 75 ec             	pushl  -0x14(%ebp)
80104451:	e8 ca c9 ff ff       	call   80100e20 <fileread>
80104456:	83 c4 10             	add    $0x10,%esp
}
80104459:	c9                   	leave  
8010445a:	c3                   	ret    
8010445b:	90                   	nop
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
8010445c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fileread(f, p, n);
}
80104461:	c9                   	leave  
80104462:	c3                   	ret    
80104463:	90                   	nop

80104464 <sys_write>:

int
sys_write(void)
{
80104464:	55                   	push   %ebp
80104465:	89 e5                	mov    %esp,%ebp
80104467:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
8010446a:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010446d:	31 c0                	xor    %eax,%eax
8010446f:	e8 e0 fe ff ff       	call   80104354 <argfd.constprop.0>
80104474:	85 c0                	test   %eax,%eax
80104476:	78 40                	js     801044b8 <sys_write+0x54>
80104478:	83 ec 08             	sub    $0x8,%esp
8010447b:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010447e:	50                   	push   %eax
8010447f:	6a 02                	push   $0x2
80104481:	e8 32 fc ff ff       	call   801040b8 <argint>
80104486:	83 c4 10             	add    $0x10,%esp
80104489:	85 c0                	test   %eax,%eax
8010448b:	78 2b                	js     801044b8 <sys_write+0x54>
8010448d:	52                   	push   %edx
8010448e:	ff 75 f0             	pushl  -0x10(%ebp)
80104491:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104494:	50                   	push   %eax
80104495:	6a 01                	push   $0x1
80104497:	e8 60 fc ff ff       	call   801040fc <argptr>
8010449c:	83 c4 10             	add    $0x10,%esp
8010449f:	85 c0                	test   %eax,%eax
801044a1:	78 15                	js     801044b8 <sys_write+0x54>
    return -1;
  return filewrite(f, p, n);
801044a3:	50                   	push   %eax
801044a4:	ff 75 f0             	pushl  -0x10(%ebp)
801044a7:	ff 75 f4             	pushl  -0xc(%ebp)
801044aa:	ff 75 ec             	pushl  -0x14(%ebp)
801044ad:	e8 f6 c9 ff ff       	call   80100ea8 <filewrite>
801044b2:	83 c4 10             	add    $0x10,%esp
}
801044b5:	c9                   	leave  
801044b6:	c3                   	ret    
801044b7:	90                   	nop
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
801044b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filewrite(f, p, n);
}
801044bd:	c9                   	leave  
801044be:	c3                   	ret    
801044bf:	90                   	nop

801044c0 <sys_close>:

int
sys_close(void)
{
801044c0:	55                   	push   %ebp
801044c1:	89 e5                	mov    %esp,%ebp
801044c3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
801044c6:	8d 55 f4             	lea    -0xc(%ebp),%edx
801044c9:	8d 45 f0             	lea    -0x10(%ebp),%eax
801044cc:	e8 83 fe ff ff       	call   80104354 <argfd.constprop.0>
801044d1:	85 c0                	test   %eax,%eax
801044d3:	78 23                	js     801044f8 <sys_close+0x38>
    return -1;
  myproc()->ofile[fd] = 0;
801044d5:	e8 e6 ed ff ff       	call   801032c0 <myproc>
801044da:	8b 55 f0             	mov    -0x10(%ebp),%edx
801044dd:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
801044e4:	00 
  fileclose(f);
801044e5:	83 ec 0c             	sub    $0xc,%esp
801044e8:	ff 75 f4             	pushl  -0xc(%ebp)
801044eb:	e8 30 c8 ff ff       	call   80100d20 <fileclose>
  return 0;
801044f0:	83 c4 10             	add    $0x10,%esp
801044f3:	31 c0                	xor    %eax,%eax
}
801044f5:	c9                   	leave  
801044f6:	c3                   	ret    
801044f7:	90                   	nop
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
801044f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  myproc()->ofile[fd] = 0;
  fileclose(f);
  return 0;
}
801044fd:	c9                   	leave  
801044fe:	c3                   	ret    
801044ff:	90                   	nop

80104500 <sys_fstat>:

int
sys_fstat(void)
{
80104500:	55                   	push   %ebp
80104501:	89 e5                	mov    %esp,%ebp
80104503:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104506:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104509:	31 c0                	xor    %eax,%eax
8010450b:	e8 44 fe ff ff       	call   80104354 <argfd.constprop.0>
80104510:	85 c0                	test   %eax,%eax
80104512:	78 28                	js     8010453c <sys_fstat+0x3c>
80104514:	50                   	push   %eax
80104515:	6a 14                	push   $0x14
80104517:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010451a:	50                   	push   %eax
8010451b:	6a 01                	push   $0x1
8010451d:	e8 da fb ff ff       	call   801040fc <argptr>
80104522:	83 c4 10             	add    $0x10,%esp
80104525:	85 c0                	test   %eax,%eax
80104527:	78 13                	js     8010453c <sys_fstat+0x3c>
    return -1;
  return filestat(f, st);
80104529:	83 ec 08             	sub    $0x8,%esp
8010452c:	ff 75 f4             	pushl  -0xc(%ebp)
8010452f:	ff 75 f0             	pushl  -0x10(%ebp)
80104532:	e8 a5 c8 ff ff       	call   80100ddc <filestat>
80104537:	83 c4 10             	add    $0x10,%esp
}
8010453a:	c9                   	leave  
8010453b:	c3                   	ret    
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
8010453c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filestat(f, st);
}
80104541:	c9                   	leave  
80104542:	c3                   	ret    
80104543:	90                   	nop

80104544 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104544:	55                   	push   %ebp
80104545:	89 e5                	mov    %esp,%ebp
80104547:	57                   	push   %edi
80104548:	56                   	push   %esi
80104549:	53                   	push   %ebx
8010454a:	83 ec 34             	sub    $0x34,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010454d:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104550:	50                   	push   %eax
80104551:	6a 00                	push   $0x0
80104553:	e8 fc fb ff ff       	call   80104154 <argstr>
80104558:	83 c4 10             	add    $0x10,%esp
8010455b:	85 c0                	test   %eax,%eax
8010455d:	0f 88 f2 00 00 00    	js     80104655 <sys_link+0x111>
80104563:	83 ec 08             	sub    $0x8,%esp
80104566:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104569:	50                   	push   %eax
8010456a:	6a 01                	push   $0x1
8010456c:	e8 e3 fb ff ff       	call   80104154 <argstr>
80104571:	83 c4 10             	add    $0x10,%esp
80104574:	85 c0                	test   %eax,%eax
80104576:	0f 88 d9 00 00 00    	js     80104655 <sys_link+0x111>
    return -1;

  begin_op();
8010457c:	e8 e3 e1 ff ff       	call   80102764 <begin_op>
  if((ip = namei(old)) == 0){
80104581:	83 ec 0c             	sub    $0xc,%esp
80104584:	ff 75 d4             	pushl  -0x2c(%ebp)
80104587:	e8 d0 d6 ff ff       	call   80101c5c <namei>
8010458c:	89 c3                	mov    %eax,%ebx
8010458e:	83 c4 10             	add    $0x10,%esp
80104591:	85 c0                	test   %eax,%eax
80104593:	0f 84 e3 00 00 00    	je     8010467c <sys_link+0x138>
    end_op();
    return -1;
  }

  ilock(ip);
80104599:	83 ec 0c             	sub    $0xc,%esp
8010459c:	50                   	push   %eax
8010459d:	e8 0a cf ff ff       	call   801014ac <ilock>
  if(ip->type == T_DIR){
801045a2:	83 c4 10             	add    $0x10,%esp
801045a5:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801045aa:	0f 84 b4 00 00 00    	je     80104664 <sys_link+0x120>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
801045b0:	66 ff 43 56          	incw   0x56(%ebx)
  iupdate(ip);
801045b4:	83 ec 0c             	sub    $0xc,%esp
801045b7:	53                   	push   %ebx
801045b8:	e8 47 ce ff ff       	call   80101404 <iupdate>
  iunlock(ip);
801045bd:	89 1c 24             	mov    %ebx,(%esp)
801045c0:	e8 af cf ff ff       	call   80101574 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
801045c5:	5a                   	pop    %edx
801045c6:	59                   	pop    %ecx
801045c7:	8d 7d da             	lea    -0x26(%ebp),%edi
801045ca:	57                   	push   %edi
801045cb:	ff 75 d0             	pushl  -0x30(%ebp)
801045ce:	e8 a1 d6 ff ff       	call   80101c74 <nameiparent>
801045d3:	89 c6                	mov    %eax,%esi
801045d5:	83 c4 10             	add    $0x10,%esp
801045d8:	85 c0                	test   %eax,%eax
801045da:	74 54                	je     80104630 <sys_link+0xec>
    goto bad;
  ilock(dp);
801045dc:	83 ec 0c             	sub    $0xc,%esp
801045df:	50                   	push   %eax
801045e0:	e8 c7 ce ff ff       	call   801014ac <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801045e5:	83 c4 10             	add    $0x10,%esp
801045e8:	8b 03                	mov    (%ebx),%eax
801045ea:	39 06                	cmp    %eax,(%esi)
801045ec:	75 36                	jne    80104624 <sys_link+0xe0>
801045ee:	50                   	push   %eax
801045ef:	ff 73 04             	pushl  0x4(%ebx)
801045f2:	57                   	push   %edi
801045f3:	56                   	push   %esi
801045f4:	e8 af d5 ff ff       	call   80101ba8 <dirlink>
801045f9:	83 c4 10             	add    $0x10,%esp
801045fc:	85 c0                	test   %eax,%eax
801045fe:	78 24                	js     80104624 <sys_link+0xe0>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
80104600:	83 ec 0c             	sub    $0xc,%esp
80104603:	56                   	push   %esi
80104604:	e8 f7 d0 ff ff       	call   80101700 <iunlockput>
  iput(ip);
80104609:	89 1c 24             	mov    %ebx,(%esp)
8010460c:	e8 a7 cf ff ff       	call   801015b8 <iput>

  end_op();
80104611:	e8 b6 e1 ff ff       	call   801027cc <end_op>

  return 0;
80104616:	83 c4 10             	add    $0x10,%esp
80104619:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
8010461b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010461e:	5b                   	pop    %ebx
8010461f:	5e                   	pop    %esi
80104620:	5f                   	pop    %edi
80104621:	5d                   	pop    %ebp
80104622:	c3                   	ret    
80104623:	90                   	nop

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
80104624:	83 ec 0c             	sub    $0xc,%esp
80104627:	56                   	push   %esi
80104628:	e8 d3 d0 ff ff       	call   80101700 <iunlockput>
    goto bad;
8010462d:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  ilock(ip);
80104630:	83 ec 0c             	sub    $0xc,%esp
80104633:	53                   	push   %ebx
80104634:	e8 73 ce ff ff       	call   801014ac <ilock>
  ip->nlink--;
80104639:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
8010463d:	89 1c 24             	mov    %ebx,(%esp)
80104640:	e8 bf cd ff ff       	call   80101404 <iupdate>
  iunlockput(ip);
80104645:	89 1c 24             	mov    %ebx,(%esp)
80104648:	e8 b3 d0 ff ff       	call   80101700 <iunlockput>
  end_op();
8010464d:	e8 7a e1 ff ff       	call   801027cc <end_op>
  return -1;
80104652:	83 c4 10             	add    $0x10,%esp
80104655:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010465a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010465d:	5b                   	pop    %ebx
8010465e:	5e                   	pop    %esi
8010465f:	5f                   	pop    %edi
80104660:	5d                   	pop    %ebp
80104661:	c3                   	ret    
80104662:	66 90                	xchg   %ax,%ax
    return -1;
  }

  ilock(ip);
  if(ip->type == T_DIR){
    iunlockput(ip);
80104664:	83 ec 0c             	sub    $0xc,%esp
80104667:	53                   	push   %ebx
80104668:	e8 93 d0 ff ff       	call   80101700 <iunlockput>
    end_op();
8010466d:	e8 5a e1 ff ff       	call   801027cc <end_op>
    return -1;
80104672:	83 c4 10             	add    $0x10,%esp
80104675:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010467a:	eb 9f                	jmp    8010461b <sys_link+0xd7>
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
    return -1;

  begin_op();
  if((ip = namei(old)) == 0){
    end_op();
8010467c:	e8 4b e1 ff ff       	call   801027cc <end_op>
    return -1;
80104681:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104686:	eb 93                	jmp    8010461b <sys_link+0xd7>

80104688 <sys_unlink>:
}

//PAGEBREAK!
int
sys_unlink(void)
{
80104688:	55                   	push   %ebp
80104689:	89 e5                	mov    %esp,%ebp
8010468b:	57                   	push   %edi
8010468c:	56                   	push   %esi
8010468d:	53                   	push   %ebx
8010468e:	83 ec 54             	sub    $0x54,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80104691:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104694:	50                   	push   %eax
80104695:	6a 00                	push   $0x0
80104697:	e8 b8 fa ff ff       	call   80104154 <argstr>
8010469c:	83 c4 10             	add    $0x10,%esp
8010469f:	85 c0                	test   %eax,%eax
801046a1:	0f 88 75 01 00 00    	js     8010481c <sys_unlink+0x194>
    return -1;

  begin_op();
801046a7:	e8 b8 e0 ff ff       	call   80102764 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801046ac:	83 ec 08             	sub    $0x8,%esp
801046af:	8d 5d ca             	lea    -0x36(%ebp),%ebx
801046b2:	53                   	push   %ebx
801046b3:	ff 75 c0             	pushl  -0x40(%ebp)
801046b6:	e8 b9 d5 ff ff       	call   80101c74 <nameiparent>
801046bb:	89 45 b4             	mov    %eax,-0x4c(%ebp)
801046be:	83 c4 10             	add    $0x10,%esp
801046c1:	85 c0                	test   %eax,%eax
801046c3:	0f 84 5d 01 00 00    	je     80104826 <sys_unlink+0x19e>
    end_op();
    return -1;
  }

  ilock(dp);
801046c9:	83 ec 0c             	sub    $0xc,%esp
801046cc:	8b 75 b4             	mov    -0x4c(%ebp),%esi
801046cf:	56                   	push   %esi
801046d0:	e8 d7 cd ff ff       	call   801014ac <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801046d5:	59                   	pop    %ecx
801046d6:	5f                   	pop    %edi
801046d7:	68 b4 6c 10 80       	push   $0x80106cb4
801046dc:	53                   	push   %ebx
801046dd:	e8 86 d2 ff ff       	call   80101968 <namecmp>
801046e2:	83 c4 10             	add    $0x10,%esp
801046e5:	85 c0                	test   %eax,%eax
801046e7:	0f 84 f4 00 00 00    	je     801047e1 <sys_unlink+0x159>
801046ed:	83 ec 08             	sub    $0x8,%esp
801046f0:	68 b3 6c 10 80       	push   $0x80106cb3
801046f5:	53                   	push   %ebx
801046f6:	e8 6d d2 ff ff       	call   80101968 <namecmp>
801046fb:	83 c4 10             	add    $0x10,%esp
801046fe:	85 c0                	test   %eax,%eax
80104700:	0f 84 db 00 00 00    	je     801047e1 <sys_unlink+0x159>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80104706:	52                   	push   %edx
80104707:	8d 45 c4             	lea    -0x3c(%ebp),%eax
8010470a:	50                   	push   %eax
8010470b:	53                   	push   %ebx
8010470c:	56                   	push   %esi
8010470d:	e8 6e d2 ff ff       	call   80101980 <dirlookup>
80104712:	89 c7                	mov    %eax,%edi
80104714:	83 c4 10             	add    $0x10,%esp
80104717:	85 c0                	test   %eax,%eax
80104719:	0f 84 c2 00 00 00    	je     801047e1 <sys_unlink+0x159>
    goto bad;
  ilock(ip);
8010471f:	83 ec 0c             	sub    $0xc,%esp
80104722:	50                   	push   %eax
80104723:	e8 84 cd ff ff       	call   801014ac <ilock>

  if(ip->nlink < 1)
80104728:	83 c4 10             	add    $0x10,%esp
8010472b:	66 83 7f 56 00       	cmpw   $0x0,0x56(%edi)
80104730:	0f 8e 19 01 00 00    	jle    8010484f <sys_unlink+0x1c7>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
80104736:	66 83 7f 50 01       	cmpw   $0x1,0x50(%edi)
8010473b:	74 67                	je     801047a4 <sys_unlink+0x11c>
8010473d:	8d 75 d8             	lea    -0x28(%ebp),%esi
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
80104740:	50                   	push   %eax
80104741:	6a 10                	push   $0x10
80104743:	6a 00                	push   $0x0
80104745:	56                   	push   %esi
80104746:	e8 01 f7 ff ff       	call   80103e4c <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010474b:	6a 10                	push   $0x10
8010474d:	ff 75 c4             	pushl  -0x3c(%ebp)
80104750:	56                   	push   %esi
80104751:	ff 75 b4             	pushl  -0x4c(%ebp)
80104754:	e8 f7 d0 ff ff       	call   80101850 <writei>
80104759:	83 c4 20             	add    $0x20,%esp
8010475c:	83 f8 10             	cmp    $0x10,%eax
8010475f:	0f 85 dd 00 00 00    	jne    80104842 <sys_unlink+0x1ba>
    panic("unlink: writei");
  if(ip->type == T_DIR){
80104765:	66 83 7f 50 01       	cmpw   $0x1,0x50(%edi)
8010476a:	0f 84 94 00 00 00    	je     80104804 <sys_unlink+0x17c>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
80104770:	83 ec 0c             	sub    $0xc,%esp
80104773:	ff 75 b4             	pushl  -0x4c(%ebp)
80104776:	e8 85 cf ff ff       	call   80101700 <iunlockput>

  ip->nlink--;
8010477b:	66 ff 4f 56          	decw   0x56(%edi)
  iupdate(ip);
8010477f:	89 3c 24             	mov    %edi,(%esp)
80104782:	e8 7d cc ff ff       	call   80101404 <iupdate>
  iunlockput(ip);
80104787:	89 3c 24             	mov    %edi,(%esp)
8010478a:	e8 71 cf ff ff       	call   80101700 <iunlockput>

  end_op();
8010478f:	e8 38 e0 ff ff       	call   801027cc <end_op>

  return 0;
80104794:	83 c4 10             	add    $0x10,%esp
80104797:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
80104799:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010479c:	5b                   	pop    %ebx
8010479d:	5e                   	pop    %esi
8010479e:	5f                   	pop    %edi
8010479f:	5d                   	pop    %ebp
801047a0:	c3                   	ret    
801047a1:	8d 76 00             	lea    0x0(%esi),%esi
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801047a4:	83 7f 58 20          	cmpl   $0x20,0x58(%edi)
801047a8:	76 93                	jbe    8010473d <sys_unlink+0xb5>
801047aa:	bb 20 00 00 00       	mov    $0x20,%ebx
801047af:	8d 75 d8             	lea    -0x28(%ebp),%esi
801047b2:	eb 08                	jmp    801047bc <sys_unlink+0x134>
801047b4:	83 c3 10             	add    $0x10,%ebx
801047b7:	3b 5f 58             	cmp    0x58(%edi),%ebx
801047ba:	73 84                	jae    80104740 <sys_unlink+0xb8>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801047bc:	6a 10                	push   $0x10
801047be:	53                   	push   %ebx
801047bf:	56                   	push   %esi
801047c0:	57                   	push   %edi
801047c1:	e8 86 cf ff ff       	call   8010174c <readi>
801047c6:	83 c4 10             	add    $0x10,%esp
801047c9:	83 f8 10             	cmp    $0x10,%eax
801047cc:	75 67                	jne    80104835 <sys_unlink+0x1ad>
      panic("isdirempty: readi");
    if(de.inum != 0)
801047ce:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801047d3:	74 df                	je     801047b4 <sys_unlink+0x12c>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
801047d5:	83 ec 0c             	sub    $0xc,%esp
801047d8:	57                   	push   %edi
801047d9:	e8 22 cf ff ff       	call   80101700 <iunlockput>
    goto bad;
801047de:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  iunlockput(dp);
801047e1:	83 ec 0c             	sub    $0xc,%esp
801047e4:	ff 75 b4             	pushl  -0x4c(%ebp)
801047e7:	e8 14 cf ff ff       	call   80101700 <iunlockput>
  end_op();
801047ec:	e8 db df ff ff       	call   801027cc <end_op>
  return -1;
801047f1:	83 c4 10             	add    $0x10,%esp
801047f4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801047f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801047fc:	5b                   	pop    %ebx
801047fd:	5e                   	pop    %esi
801047fe:	5f                   	pop    %edi
801047ff:	5d                   	pop    %ebp
80104800:	c3                   	ret    
80104801:	8d 76 00             	lea    0x0(%esi),%esi

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
80104804:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104807:	66 ff 48 56          	decw   0x56(%eax)
    iupdate(dp);
8010480b:	83 ec 0c             	sub    $0xc,%esp
8010480e:	50                   	push   %eax
8010480f:	e8 f0 cb ff ff       	call   80101404 <iupdate>
80104814:	83 c4 10             	add    $0x10,%esp
80104817:	e9 54 ff ff ff       	jmp    80104770 <sys_unlink+0xe8>
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;
8010481c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104821:	e9 73 ff ff ff       	jmp    80104799 <sys_unlink+0x111>

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
    end_op();
80104826:	e8 a1 df ff ff       	call   801027cc <end_op>
    return -1;
8010482b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104830:	e9 64 ff ff ff       	jmp    80104799 <sys_unlink+0x111>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
80104835:	83 ec 0c             	sub    $0xc,%esp
80104838:	68 d8 6c 10 80       	push   $0x80106cd8
8010483d:	e8 f6 ba ff ff       	call   80100338 <panic>
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
80104842:	83 ec 0c             	sub    $0xc,%esp
80104845:	68 ea 6c 10 80       	push   $0x80106cea
8010484a:	e8 e9 ba ff ff       	call   80100338 <panic>
  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
8010484f:	83 ec 0c             	sub    $0xc,%esp
80104852:	68 c6 6c 10 80       	push   $0x80106cc6
80104857:	e8 dc ba ff ff       	call   80100338 <panic>

8010485c <sys_open>:
  return ip;
}

int
sys_open(void)
{
8010485c:	55                   	push   %ebp
8010485d:	89 e5                	mov    %esp,%ebp
8010485f:	57                   	push   %edi
80104860:	56                   	push   %esi
80104861:	53                   	push   %ebx
80104862:	83 ec 24             	sub    $0x24,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80104865:	8d 45 e0             	lea    -0x20(%ebp),%eax
80104868:	50                   	push   %eax
80104869:	6a 00                	push   $0x0
8010486b:	e8 e4 f8 ff ff       	call   80104154 <argstr>
80104870:	83 c4 10             	add    $0x10,%esp
80104873:	85 c0                	test   %eax,%eax
80104875:	0f 88 88 00 00 00    	js     80104903 <sys_open+0xa7>
8010487b:	83 ec 08             	sub    $0x8,%esp
8010487e:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80104881:	50                   	push   %eax
80104882:	6a 01                	push   $0x1
80104884:	e8 2f f8 ff ff       	call   801040b8 <argint>
80104889:	83 c4 10             	add    $0x10,%esp
8010488c:	85 c0                	test   %eax,%eax
8010488e:	78 73                	js     80104903 <sys_open+0xa7>
    return -1;

  begin_op();
80104890:	e8 cf de ff ff       	call   80102764 <begin_op>

  if(omode & O_CREATE){
80104895:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80104899:	75 75                	jne    80104910 <sys_open+0xb4>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
8010489b:	83 ec 0c             	sub    $0xc,%esp
8010489e:	ff 75 e0             	pushl  -0x20(%ebp)
801048a1:	e8 b6 d3 ff ff       	call   80101c5c <namei>
801048a6:	89 c6                	mov    %eax,%esi
801048a8:	83 c4 10             	add    $0x10,%esp
801048ab:	85 c0                	test   %eax,%eax
801048ad:	74 7e                	je     8010492d <sys_open+0xd1>
      end_op();
      return -1;
    }
    ilock(ip);
801048af:	83 ec 0c             	sub    $0xc,%esp
801048b2:	50                   	push   %eax
801048b3:	e8 f4 cb ff ff       	call   801014ac <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801048b8:	83 c4 10             	add    $0x10,%esp
801048bb:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801048c0:	0f 84 ba 00 00 00    	je     80104980 <sys_open+0x124>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801048c6:	e8 ad c3 ff ff       	call   80100c78 <filealloc>
801048cb:	89 c7                	mov    %eax,%edi
801048cd:	85 c0                	test   %eax,%eax
801048cf:	74 21                	je     801048f2 <sys_open+0x96>
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
801048d1:	e8 ea e9 ff ff       	call   801032c0 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
801048d6:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
801048d8:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801048dc:	85 d2                	test   %edx,%edx
801048de:	74 5c                	je     8010493c <sys_open+0xe0>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801048e0:	43                   	inc    %ebx
801048e1:	83 fb 10             	cmp    $0x10,%ebx
801048e4:	75 f2                	jne    801048d8 <sys_open+0x7c>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
801048e6:	83 ec 0c             	sub    $0xc,%esp
801048e9:	57                   	push   %edi
801048ea:	e8 31 c4 ff ff       	call   80100d20 <fileclose>
801048ef:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
801048f2:	83 ec 0c             	sub    $0xc,%esp
801048f5:	56                   	push   %esi
801048f6:	e8 05 ce ff ff       	call   80101700 <iunlockput>
    end_op();
801048fb:	e8 cc de ff ff       	call   801027cc <end_op>
    return -1;
80104900:	83 c4 10             	add    $0x10,%esp
80104903:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
80104908:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010490b:	5b                   	pop    %ebx
8010490c:	5e                   	pop    %esi
8010490d:	5f                   	pop    %edi
8010490e:	5d                   	pop    %ebp
8010490f:	c3                   	ret    
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80104910:	83 ec 0c             	sub    $0xc,%esp
80104913:	6a 00                	push   $0x0
80104915:	31 c9                	xor    %ecx,%ecx
80104917:	ba 02 00 00 00       	mov    $0x2,%edx
8010491c:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010491f:	e8 c0 f8 ff ff       	call   801041e4 <create>
80104924:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80104926:	83 c4 10             	add    $0x10,%esp
80104929:	85 c0                	test   %eax,%eax
8010492b:	75 99                	jne    801048c6 <sys_open+0x6a>
      end_op();
8010492d:	e8 9a de ff ff       	call   801027cc <end_op>
      return -1;
80104932:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104937:	eb 3f                	jmp    80104978 <sys_open+0x11c>
80104939:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
8010493c:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80104940:	83 ec 0c             	sub    $0xc,%esp
80104943:	56                   	push   %esi
80104944:	e8 2b cc ff ff       	call   80101574 <iunlock>
  end_op();
80104949:	e8 7e de ff ff       	call   801027cc <end_op>

  f->type = FD_INODE;
8010494e:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
80104954:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80104957:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
8010495e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104961:	89 d0                	mov    %edx,%eax
80104963:	83 e0 01             	and    $0x1,%eax
80104966:	83 f0 01             	xor    $0x1,%eax
80104969:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010496c:	83 c4 10             	add    $0x10,%esp
8010496f:	83 e2 03             	and    $0x3,%edx
80104972:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
80104976:	89 d8                	mov    %ebx,%eax
}
80104978:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010497b:	5b                   	pop    %ebx
8010497c:	5e                   	pop    %esi
8010497d:	5f                   	pop    %edi
8010497e:	5d                   	pop    %ebp
8010497f:	c3                   	ret    
    if((ip = namei(path)) == 0){
      end_op();
      return -1;
    }
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
80104980:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104983:	85 c9                	test   %ecx,%ecx
80104985:	0f 84 3b ff ff ff    	je     801048c6 <sys_open+0x6a>
8010498b:	e9 62 ff ff ff       	jmp    801048f2 <sys_open+0x96>

80104990 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
80104990:	55                   	push   %ebp
80104991:	89 e5                	mov    %esp,%ebp
80104993:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80104996:	e8 c9 dd ff ff       	call   80102764 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010499b:	83 ec 08             	sub    $0x8,%esp
8010499e:	8d 45 f4             	lea    -0xc(%ebp),%eax
801049a1:	50                   	push   %eax
801049a2:	6a 00                	push   $0x0
801049a4:	e8 ab f7 ff ff       	call   80104154 <argstr>
801049a9:	83 c4 10             	add    $0x10,%esp
801049ac:	85 c0                	test   %eax,%eax
801049ae:	78 30                	js     801049e0 <sys_mkdir+0x50>
801049b0:	83 ec 0c             	sub    $0xc,%esp
801049b3:	6a 00                	push   $0x0
801049b5:	31 c9                	xor    %ecx,%ecx
801049b7:	ba 01 00 00 00       	mov    $0x1,%edx
801049bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049bf:	e8 20 f8 ff ff       	call   801041e4 <create>
801049c4:	83 c4 10             	add    $0x10,%esp
801049c7:	85 c0                	test   %eax,%eax
801049c9:	74 15                	je     801049e0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801049cb:	83 ec 0c             	sub    $0xc,%esp
801049ce:	50                   	push   %eax
801049cf:	e8 2c cd ff ff       	call   80101700 <iunlockput>
  end_op();
801049d4:	e8 f3 dd ff ff       	call   801027cc <end_op>
  return 0;
801049d9:	83 c4 10             	add    $0x10,%esp
801049dc:	31 c0                	xor    %eax,%eax
}
801049de:	c9                   	leave  
801049df:	c3                   	ret    
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
801049e0:	e8 e7 dd ff ff       	call   801027cc <end_op>
    return -1;
801049e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
801049ea:	c9                   	leave  
801049eb:	c3                   	ret    

801049ec <sys_mknod>:

int
sys_mknod(void)
{
801049ec:	55                   	push   %ebp
801049ed:	89 e5                	mov    %esp,%ebp
801049ef:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801049f2:	e8 6d dd ff ff       	call   80102764 <begin_op>
  if((argstr(0, &path)) < 0 ||
801049f7:	83 ec 08             	sub    $0x8,%esp
801049fa:	8d 45 ec             	lea    -0x14(%ebp),%eax
801049fd:	50                   	push   %eax
801049fe:	6a 00                	push   $0x0
80104a00:	e8 4f f7 ff ff       	call   80104154 <argstr>
80104a05:	83 c4 10             	add    $0x10,%esp
80104a08:	85 c0                	test   %eax,%eax
80104a0a:	78 60                	js     80104a6c <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80104a0c:	83 ec 08             	sub    $0x8,%esp
80104a0f:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104a12:	50                   	push   %eax
80104a13:	6a 01                	push   $0x1
80104a15:	e8 9e f6 ff ff       	call   801040b8 <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
80104a1a:	83 c4 10             	add    $0x10,%esp
80104a1d:	85 c0                	test   %eax,%eax
80104a1f:	78 4b                	js     80104a6c <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80104a21:	83 ec 08             	sub    $0x8,%esp
80104a24:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104a27:	50                   	push   %eax
80104a28:	6a 02                	push   $0x2
80104a2a:	e8 89 f6 ff ff       	call   801040b8 <argint>
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
80104a2f:	83 c4 10             	add    $0x10,%esp
80104a32:	85 c0                	test   %eax,%eax
80104a34:	78 36                	js     80104a6c <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80104a36:	83 ec 0c             	sub    $0xc,%esp
80104a39:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80104a3d:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80104a41:	50                   	push   %eax
80104a42:	ba 03 00 00 00       	mov    $0x3,%edx
80104a47:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104a4a:	e8 95 f7 ff ff       	call   801041e4 <create>
80104a4f:	83 c4 10             	add    $0x10,%esp
80104a52:	85 c0                	test   %eax,%eax
80104a54:	74 16                	je     80104a6c <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
80104a56:	83 ec 0c             	sub    $0xc,%esp
80104a59:	50                   	push   %eax
80104a5a:	e8 a1 cc ff ff       	call   80101700 <iunlockput>
  end_op();
80104a5f:	e8 68 dd ff ff       	call   801027cc <end_op>
  return 0;
80104a64:	83 c4 10             	add    $0x10,%esp
80104a67:	31 c0                	xor    %eax,%eax
}
80104a69:	c9                   	leave  
80104a6a:	c3                   	ret    
80104a6b:	90                   	nop
  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
80104a6c:	e8 5b dd ff ff       	call   801027cc <end_op>
    return -1;
80104a71:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
80104a76:	c9                   	leave  
80104a77:	c3                   	ret    

80104a78 <sys_chdir>:

int
sys_chdir(void)
{
80104a78:	55                   	push   %ebp
80104a79:	89 e5                	mov    %esp,%ebp
80104a7b:	56                   	push   %esi
80104a7c:	53                   	push   %ebx
80104a7d:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80104a80:	e8 3b e8 ff ff       	call   801032c0 <myproc>
80104a85:	89 c6                	mov    %eax,%esi
  
  begin_op();
80104a87:	e8 d8 dc ff ff       	call   80102764 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80104a8c:	83 ec 08             	sub    $0x8,%esp
80104a8f:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104a92:	50                   	push   %eax
80104a93:	6a 00                	push   $0x0
80104a95:	e8 ba f6 ff ff       	call   80104154 <argstr>
80104a9a:	83 c4 10             	add    $0x10,%esp
80104a9d:	85 c0                	test   %eax,%eax
80104a9f:	78 67                	js     80104b08 <sys_chdir+0x90>
80104aa1:	83 ec 0c             	sub    $0xc,%esp
80104aa4:	ff 75 f4             	pushl  -0xc(%ebp)
80104aa7:	e8 b0 d1 ff ff       	call   80101c5c <namei>
80104aac:	89 c3                	mov    %eax,%ebx
80104aae:	83 c4 10             	add    $0x10,%esp
80104ab1:	85 c0                	test   %eax,%eax
80104ab3:	74 53                	je     80104b08 <sys_chdir+0x90>
    end_op();
    return -1;
  }
  ilock(ip);
80104ab5:	83 ec 0c             	sub    $0xc,%esp
80104ab8:	50                   	push   %eax
80104ab9:	e8 ee c9 ff ff       	call   801014ac <ilock>
  if(ip->type != T_DIR){
80104abe:	83 c4 10             	add    $0x10,%esp
80104ac1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104ac6:	75 28                	jne    80104af0 <sys_chdir+0x78>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80104ac8:	83 ec 0c             	sub    $0xc,%esp
80104acb:	53                   	push   %ebx
80104acc:	e8 a3 ca ff ff       	call   80101574 <iunlock>
  iput(curproc->cwd);
80104ad1:	58                   	pop    %eax
80104ad2:	ff 76 68             	pushl  0x68(%esi)
80104ad5:	e8 de ca ff ff       	call   801015b8 <iput>
  end_op();
80104ada:	e8 ed dc ff ff       	call   801027cc <end_op>
  curproc->cwd = ip;
80104adf:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
80104ae2:	83 c4 10             	add    $0x10,%esp
80104ae5:	31 c0                	xor    %eax,%eax
}
80104ae7:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104aea:	5b                   	pop    %ebx
80104aeb:	5e                   	pop    %esi
80104aec:	5d                   	pop    %ebp
80104aed:	c3                   	ret    
80104aee:	66 90                	xchg   %ax,%ax
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
80104af0:	83 ec 0c             	sub    $0xc,%esp
80104af3:	53                   	push   %ebx
80104af4:	e8 07 cc ff ff       	call   80101700 <iunlockput>
    end_op();
80104af9:	e8 ce dc ff ff       	call   801027cc <end_op>
    return -1;
80104afe:	83 c4 10             	add    $0x10,%esp
80104b01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104b06:	eb df                	jmp    80104ae7 <sys_chdir+0x6f>
  struct inode *ip;
  struct proc *curproc = myproc();
  
  begin_op();
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
80104b08:	e8 bf dc ff ff       	call   801027cc <end_op>
    return -1;
80104b0d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104b12:	eb d3                	jmp    80104ae7 <sys_chdir+0x6f>

80104b14 <sys_exec>:
  return 0;
}

int
sys_exec(void)
{
80104b14:	55                   	push   %ebp
80104b15:	89 e5                	mov    %esp,%ebp
80104b17:	57                   	push   %edi
80104b18:	56                   	push   %esi
80104b19:	53                   	push   %ebx
80104b1a:	81 ec b4 00 00 00    	sub    $0xb4,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80104b20:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
80104b26:	50                   	push   %eax
80104b27:	6a 00                	push   $0x0
80104b29:	e8 26 f6 ff ff       	call   80104154 <argstr>
80104b2e:	83 c4 10             	add    $0x10,%esp
80104b31:	85 c0                	test   %eax,%eax
80104b33:	0f 88 8b 00 00 00    	js     80104bc4 <sys_exec+0xb0>
80104b39:	83 ec 08             	sub    $0x8,%esp
80104b3c:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80104b42:	50                   	push   %eax
80104b43:	6a 01                	push   $0x1
80104b45:	e8 6e f5 ff ff       	call   801040b8 <argint>
80104b4a:	83 c4 10             	add    $0x10,%esp
80104b4d:	85 c0                	test   %eax,%eax
80104b4f:	78 73                	js     80104bc4 <sys_exec+0xb0>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80104b51:	50                   	push   %eax
80104b52:	68 80 00 00 00       	push   $0x80
80104b57:	6a 00                	push   $0x0
80104b59:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
80104b5f:	56                   	push   %esi
80104b60:	e8 e7 f2 ff ff       	call   80103e4c <memset>
80104b65:	83 c4 10             	add    $0x10,%esp
80104b68:	31 db                	xor    %ebx,%ebx
80104b6a:	c7 85 54 ff ff ff 00 	movl   $0x0,-0xac(%ebp)
80104b71:	00 00 00 
80104b74:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80104b7a:	66 90                	xchg   %ax,%ax
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80104b7c:	83 ec 08             	sub    $0x8,%esp
80104b7f:	57                   	push   %edi
80104b80:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80104b86:	01 d8                	add    %ebx,%eax
80104b88:	50                   	push   %eax
80104b89:	e8 b6 f4 ff ff       	call   80104044 <fetchint>
80104b8e:	83 c4 10             	add    $0x10,%esp
80104b91:	85 c0                	test   %eax,%eax
80104b93:	78 2f                	js     80104bc4 <sys_exec+0xb0>
      return -1;
    if(uarg == 0){
80104b95:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80104b9b:	85 c0                	test   %eax,%eax
80104b9d:	74 35                	je     80104bd4 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80104b9f:	83 ec 08             	sub    $0x8,%esp
80104ba2:	8d 14 1e             	lea    (%esi,%ebx,1),%edx
80104ba5:	52                   	push   %edx
80104ba6:	50                   	push   %eax
80104ba7:	e8 c8 f4 ff ff       	call   80104074 <fetchstr>
80104bac:	83 c4 10             	add    $0x10,%esp
80104baf:	85 c0                	test   %eax,%eax
80104bb1:	78 11                	js     80104bc4 <sys_exec+0xb0>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80104bb3:	ff 85 54 ff ff ff    	incl   -0xac(%ebp)
80104bb9:	83 c3 04             	add    $0x4,%ebx
    if(i >= NELEM(argv))
80104bbc:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
80104bc2:	75 b8                	jne    80104b7c <sys_exec+0x68>
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
80104bc4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80104bc9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104bcc:	5b                   	pop    %ebx
80104bcd:	5e                   	pop    %esi
80104bce:	5f                   	pop    %edi
80104bcf:	5d                   	pop    %ebp
80104bd0:	c3                   	ret    
80104bd1:	8d 76 00             	lea    0x0(%esi),%esi
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
80104bd4:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
80104bda:	c7 84 85 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%eax,4)
80104be1:	00 00 00 00 
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80104be5:	83 ec 08             	sub    $0x8,%esp
80104be8:	56                   	push   %esi
80104be9:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
80104bef:	e8 18 bd ff ff       	call   8010090c <exec>
80104bf4:	83 c4 10             	add    $0x10,%esp
}
80104bf7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104bfa:	5b                   	pop    %ebx
80104bfb:	5e                   	pop    %esi
80104bfc:	5f                   	pop    %edi
80104bfd:	5d                   	pop    %ebp
80104bfe:	c3                   	ret    
80104bff:	90                   	nop

80104c00 <sys_pipe>:

int
sys_pipe(void)
{
80104c00:	55                   	push   %ebp
80104c01:	89 e5                	mov    %esp,%ebp
80104c03:	57                   	push   %edi
80104c04:	56                   	push   %esi
80104c05:	53                   	push   %ebx
80104c06:	83 ec 20             	sub    $0x20,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80104c09:	6a 08                	push   $0x8
80104c0b:	8d 45 dc             	lea    -0x24(%ebp),%eax
80104c0e:	50                   	push   %eax
80104c0f:	6a 00                	push   $0x0
80104c11:	e8 e6 f4 ff ff       	call   801040fc <argptr>
80104c16:	83 c4 10             	add    $0x10,%esp
80104c19:	85 c0                	test   %eax,%eax
80104c1b:	78 48                	js     80104c65 <sys_pipe+0x65>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80104c1d:	83 ec 08             	sub    $0x8,%esp
80104c20:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80104c23:	50                   	push   %eax
80104c24:	8d 45 e0             	lea    -0x20(%ebp),%eax
80104c27:	50                   	push   %eax
80104c28:	e8 3b e1 ff ff       	call   80102d68 <pipealloc>
80104c2d:	83 c4 10             	add    $0x10,%esp
80104c30:	85 c0                	test   %eax,%eax
80104c32:	78 31                	js     80104c65 <sys_pipe+0x65>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80104c34:	8b 7d e0             	mov    -0x20(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80104c37:	e8 84 e6 ff ff       	call   801032c0 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
80104c3c:	31 db                	xor    %ebx,%ebx
80104c3e:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
80104c40:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80104c44:	85 f6                	test   %esi,%esi
80104c46:	74 2c                	je     80104c74 <sys_pipe+0x74>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80104c48:	43                   	inc    %ebx
80104c49:	83 fb 10             	cmp    $0x10,%ebx
80104c4c:	75 f2                	jne    80104c40 <sys_pipe+0x40>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80104c4e:	83 ec 0c             	sub    $0xc,%esp
80104c51:	ff 75 e0             	pushl  -0x20(%ebp)
80104c54:	e8 c7 c0 ff ff       	call   80100d20 <fileclose>
    fileclose(wf);
80104c59:	58                   	pop    %eax
80104c5a:	ff 75 e4             	pushl  -0x1c(%ebp)
80104c5d:	e8 be c0 ff ff       	call   80100d20 <fileclose>
    return -1;
80104c62:	83 c4 10             	add    $0x10,%esp
80104c65:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
80104c6a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104c6d:	5b                   	pop    %ebx
80104c6e:	5e                   	pop    %esi
80104c6f:	5f                   	pop    %edi
80104c70:	5d                   	pop    %ebp
80104c71:	c3                   	ret    
80104c72:	66 90                	xchg   %ax,%ax
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80104c74:	8d 73 08             	lea    0x8(%ebx),%esi
80104c77:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80104c7b:	8b 7d e4             	mov    -0x1c(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80104c7e:	e8 3d e6 ff ff       	call   801032c0 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
80104c83:	31 d2                	xor    %edx,%edx
80104c85:	8d 76 00             	lea    0x0(%esi),%esi
    if(curproc->ofile[fd] == 0){
80104c88:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80104c8c:	85 c9                	test   %ecx,%ecx
80104c8e:	74 18                	je     80104ca8 <sys_pipe+0xa8>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80104c90:	42                   	inc    %edx
80104c91:	83 fa 10             	cmp    $0x10,%edx
80104c94:	75 f2                	jne    80104c88 <sys_pipe+0x88>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80104c96:	e8 25 e6 ff ff       	call   801032c0 <myproc>
80104c9b:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80104ca2:	00 
80104ca3:	eb a9                	jmp    80104c4e <sys_pipe+0x4e>
80104ca5:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80104ca8:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80104cac:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104caf:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80104cb1:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104cb4:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80104cb7:	31 c0                	xor    %eax,%eax
}
80104cb9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104cbc:	5b                   	pop    %ebx
80104cbd:	5e                   	pop    %esi
80104cbe:	5f                   	pop    %edi
80104cbf:	5d                   	pop    %ebp
80104cc0:	c3                   	ret    
80104cc1:	66 90                	xchg   %ax,%ax
80104cc3:	90                   	nop

80104cc4 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80104cc4:	55                   	push   %ebp
80104cc5:	89 e5                	mov    %esp,%ebp
  return fork();
}
80104cc7:	5d                   	pop    %ebp
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80104cc8:	e9 6b e7 ff ff       	jmp    80103438 <fork>
80104ccd:	8d 76 00             	lea    0x0(%esi),%esi

80104cd0 <sys_exit>:
}

int
sys_exit(void)
{
80104cd0:	55                   	push   %ebp
80104cd1:	89 e5                	mov    %esp,%ebp
80104cd3:	83 ec 08             	sub    $0x8,%esp
  exit();
80104cd6:	e8 bd e9 ff ff       	call   80103698 <exit>
  return 0;  // not reached
}
80104cdb:	31 c0                	xor    %eax,%eax
80104cdd:	c9                   	leave  
80104cde:	c3                   	ret    
80104cdf:	90                   	nop

80104ce0 <sys_wait>:

int
sys_wait(void)
{
80104ce0:	55                   	push   %ebp
80104ce1:	89 e5                	mov    %esp,%ebp
  return wait();
}
80104ce3:	5d                   	pop    %ebp
}

int
sys_wait(void)
{
  return wait();
80104ce4:	e9 cf eb ff ff       	jmp    801038b8 <wait>
80104ce9:	8d 76 00             	lea    0x0(%esi),%esi

80104cec <sys_kill>:
}

int
sys_kill(void)
{
80104cec:	55                   	push   %ebp
80104ced:	89 e5                	mov    %esp,%ebp
80104cef:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80104cf2:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104cf5:	50                   	push   %eax
80104cf6:	6a 00                	push   $0x0
80104cf8:	e8 bb f3 ff ff       	call   801040b8 <argint>
80104cfd:	83 c4 10             	add    $0x10,%esp
80104d00:	85 c0                	test   %eax,%eax
80104d02:	78 10                	js     80104d14 <sys_kill+0x28>
    return -1;
  return kill(pid);
80104d04:	83 ec 0c             	sub    $0xc,%esp
80104d07:	ff 75 f4             	pushl  -0xc(%ebp)
80104d0a:	e8 ed ec ff ff       	call   801039fc <kill>
80104d0f:	83 c4 10             	add    $0x10,%esp
}
80104d12:	c9                   	leave  
80104d13:	c3                   	ret    
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
80104d14:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return kill(pid);
}
80104d19:	c9                   	leave  
80104d1a:	c3                   	ret    
80104d1b:	90                   	nop

80104d1c <sys_getpid>:

int
sys_getpid(void)
{
80104d1c:	55                   	push   %ebp
80104d1d:	89 e5                	mov    %esp,%ebp
80104d1f:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80104d22:	e8 99 e5 ff ff       	call   801032c0 <myproc>
80104d27:	8b 40 10             	mov    0x10(%eax),%eax
}
80104d2a:	c9                   	leave  
80104d2b:	c3                   	ret    

80104d2c <sys_sbrk>:

int
sys_sbrk(void)
{
80104d2c:	55                   	push   %ebp
80104d2d:	89 e5                	mov    %esp,%ebp
80104d2f:	53                   	push   %ebx
80104d30:	83 ec 1c             	sub    $0x1c,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80104d33:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d36:	50                   	push   %eax
80104d37:	6a 00                	push   $0x0
80104d39:	e8 7a f3 ff ff       	call   801040b8 <argint>
80104d3e:	83 c4 10             	add    $0x10,%esp
80104d41:	85 c0                	test   %eax,%eax
80104d43:	78 23                	js     80104d68 <sys_sbrk+0x3c>
    return -1;
  addr = myproc()->sz;
80104d45:	e8 76 e5 ff ff       	call   801032c0 <myproc>
80104d4a:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80104d4c:	83 ec 0c             	sub    $0xc,%esp
80104d4f:	ff 75 f4             	pushl  -0xc(%ebp)
80104d52:	e8 6d e6 ff ff       	call   801033c4 <growproc>
80104d57:	83 c4 10             	add    $0x10,%esp
80104d5a:	85 c0                	test   %eax,%eax
80104d5c:	78 0a                	js     80104d68 <sys_sbrk+0x3c>
    return -1;
  return addr;
80104d5e:	89 d8                	mov    %ebx,%eax
}
80104d60:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d63:	c9                   	leave  
80104d64:	c3                   	ret    
80104d65:	8d 76 00             	lea    0x0(%esi),%esi
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
80104d68:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104d6d:	eb f1                	jmp    80104d60 <sys_sbrk+0x34>
80104d6f:	90                   	nop

80104d70 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
80104d70:	55                   	push   %ebp
80104d71:	89 e5                	mov    %esp,%ebp
80104d73:	53                   	push   %ebx
80104d74:	83 ec 1c             	sub    $0x1c,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80104d77:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d7a:	50                   	push   %eax
80104d7b:	6a 00                	push   $0x0
80104d7d:	e8 36 f3 ff ff       	call   801040b8 <argint>
80104d82:	83 c4 10             	add    $0x10,%esp
80104d85:	85 c0                	test   %eax,%eax
80104d87:	78 7e                	js     80104e07 <sys_sleep+0x97>
    return -1;
  acquire(&tickslock);
80104d89:	83 ec 0c             	sub    $0xc,%esp
80104d8c:	68 60 3c 11 80       	push   $0x80113c60
80104d91:	e8 d6 ef ff ff       	call   80103d6c <acquire>
  ticks0 = ticks;
80104d96:	8b 1d a0 44 11 80    	mov    0x801144a0,%ebx
  while(ticks - ticks0 < n){
80104d9c:	83 c4 10             	add    $0x10,%esp
80104d9f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104da2:	85 d2                	test   %edx,%edx
80104da4:	75 23                	jne    80104dc9 <sys_sleep+0x59>
80104da6:	eb 48                	jmp    80104df0 <sys_sleep+0x80>
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80104da8:	83 ec 08             	sub    $0x8,%esp
80104dab:	68 60 3c 11 80       	push   $0x80113c60
80104db0:	68 a0 44 11 80       	push   $0x801144a0
80104db5:	e8 42 ea ff ff       	call   801037fc <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80104dba:	a1 a0 44 11 80       	mov    0x801144a0,%eax
80104dbf:	29 d8                	sub    %ebx,%eax
80104dc1:	83 c4 10             	add    $0x10,%esp
80104dc4:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80104dc7:	73 27                	jae    80104df0 <sys_sleep+0x80>
    if(myproc()->killed){
80104dc9:	e8 f2 e4 ff ff       	call   801032c0 <myproc>
80104dce:	8b 40 24             	mov    0x24(%eax),%eax
80104dd1:	85 c0                	test   %eax,%eax
80104dd3:	74 d3                	je     80104da8 <sys_sleep+0x38>
      release(&tickslock);
80104dd5:	83 ec 0c             	sub    $0xc,%esp
80104dd8:	68 60 3c 11 80       	push   $0x80113c60
80104ddd:	e8 22 f0 ff ff       	call   80103e04 <release>
      return -1;
80104de2:	83 c4 10             	add    $0x10,%esp
80104de5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
80104dea:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ded:	c9                   	leave  
80104dee:	c3                   	ret    
80104def:	90                   	nop
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80104df0:	83 ec 0c             	sub    $0xc,%esp
80104df3:	68 60 3c 11 80       	push   $0x80113c60
80104df8:	e8 07 f0 ff ff       	call   80103e04 <release>
  return 0;
80104dfd:	83 c4 10             	add    $0x10,%esp
80104e00:	31 c0                	xor    %eax,%eax
}
80104e02:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e05:	c9                   	leave  
80104e06:	c3                   	ret    
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
80104e07:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e0c:	eb dc                	jmp    80104dea <sys_sleep+0x7a>
80104e0e:	66 90                	xchg   %ax,%ax

80104e10 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80104e10:	55                   	push   %ebp
80104e11:	89 e5                	mov    %esp,%ebp
80104e13:	53                   	push   %ebx
80104e14:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80104e17:	68 60 3c 11 80       	push   $0x80113c60
80104e1c:	e8 4b ef ff ff       	call   80103d6c <acquire>
  xticks = ticks;
80104e21:	8b 1d a0 44 11 80    	mov    0x801144a0,%ebx
  release(&tickslock);
80104e27:	c7 04 24 60 3c 11 80 	movl   $0x80113c60,(%esp)
80104e2e:	e8 d1 ef ff ff       	call   80103e04 <release>
  return xticks;
}
80104e33:	89 d8                	mov    %ebx,%eax
80104e35:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e38:	c9                   	leave  
80104e39:	c3                   	ret    

80104e3a <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80104e3a:	1e                   	push   %ds
  pushl %es
80104e3b:	06                   	push   %es
  pushl %fs
80104e3c:	0f a0                	push   %fs
  pushl %gs
80104e3e:	0f a8                	push   %gs
  pushal
80104e40:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80104e41:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80104e45:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80104e47:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80104e49:	54                   	push   %esp
  call trap
80104e4a:	e8 bd 00 00 00       	call   80104f0c <trap>
  addl $4, %esp
80104e4f:	83 c4 04             	add    $0x4,%esp

80104e52 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80104e52:	61                   	popa   
  popl %gs
80104e53:	0f a9                	pop    %gs
  popl %fs
80104e55:	0f a1                	pop    %fs
  popl %es
80104e57:	07                   	pop    %es
  popl %ds
80104e58:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80104e59:	83 c4 08             	add    $0x8,%esp
  iret
80104e5c:	cf                   	iret   
80104e5d:	66 90                	xchg   %ax,%ax
80104e5f:	90                   	nop

80104e60 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80104e60:	31 c0                	xor    %eax,%eax
80104e62:	66 90                	xchg   %ax,%ax
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80104e64:	8b 14 85 08 90 10 80 	mov    -0x7fef6ff8(,%eax,4),%edx
80104e6b:	66 89 14 c5 a0 3c 11 	mov    %dx,-0x7feec360(,%eax,8)
80104e72:	80 
80104e73:	66 c7 04 c5 a2 3c 11 	movw   $0x8,-0x7feec35e(,%eax,8)
80104e7a:	80 08 00 
80104e7d:	c6 04 c5 a4 3c 11 80 	movb   $0x0,-0x7feec35c(,%eax,8)
80104e84:	00 
80104e85:	c6 04 c5 a5 3c 11 80 	movb   $0x8e,-0x7feec35b(,%eax,8)
80104e8c:	8e 
80104e8d:	c1 ea 10             	shr    $0x10,%edx
80104e90:	66 89 14 c5 a6 3c 11 	mov    %dx,-0x7feec35a(,%eax,8)
80104e97:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80104e98:	40                   	inc    %eax
80104e99:	3d 00 01 00 00       	cmp    $0x100,%eax
80104e9e:	75 c4                	jne    80104e64 <tvinit+0x4>
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80104ea0:	55                   	push   %ebp
80104ea1:	89 e5                	mov    %esp,%ebp
80104ea3:	83 ec 10             	sub    $0x10,%esp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80104ea6:	a1 08 91 10 80       	mov    0x80109108,%eax
80104eab:	66 a3 a0 3e 11 80    	mov    %ax,0x80113ea0
80104eb1:	66 c7 05 a2 3e 11 80 	movw   $0x8,0x80113ea2
80104eb8:	08 00 
80104eba:	c6 05 a4 3e 11 80 00 	movb   $0x0,0x80113ea4
80104ec1:	c6 05 a5 3e 11 80 ef 	movb   $0xef,0x80113ea5
80104ec8:	c1 e8 10             	shr    $0x10,%eax
80104ecb:	66 a3 a6 3e 11 80    	mov    %ax,0x80113ea6

  initlock(&tickslock, "time");
80104ed1:	68 f9 6c 10 80       	push   $0x80106cf9
80104ed6:	68 60 3c 11 80       	push   $0x80113c60
80104edb:	e8 50 ed ff ff       	call   80103c30 <initlock>
}
80104ee0:	83 c4 10             	add    $0x10,%esp
80104ee3:	c9                   	leave  
80104ee4:	c3                   	ret    
80104ee5:	8d 76 00             	lea    0x0(%esi),%esi

80104ee8 <idtinit>:

void
idtinit(void)
{
80104ee8:	55                   	push   %ebp
80104ee9:	89 e5                	mov    %esp,%ebp
80104eeb:	83 ec 10             	sub    $0x10,%esp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80104eee:	66 c7 45 fa ff 07    	movw   $0x7ff,-0x6(%ebp)
  pd[1] = (uint)p;
80104ef4:	b8 a0 3c 11 80       	mov    $0x80113ca0,%eax
80104ef9:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80104efd:	c1 e8 10             	shr    $0x10,%eax
80104f00:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
80104f04:	8d 45 fa             	lea    -0x6(%ebp),%eax
80104f07:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80104f0a:	c9                   	leave  
80104f0b:	c3                   	ret    

80104f0c <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80104f0c:	55                   	push   %ebp
80104f0d:	89 e5                	mov    %esp,%ebp
80104f0f:	57                   	push   %edi
80104f10:	56                   	push   %esi
80104f11:	53                   	push   %ebx
80104f12:	83 ec 1c             	sub    $0x1c,%esp
80104f15:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
80104f18:	8b 47 30             	mov    0x30(%edi),%eax
80104f1b:	83 f8 40             	cmp    $0x40,%eax
80104f1e:	0f 84 64 01 00 00    	je     80105088 <trap+0x17c>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80104f24:	83 e8 20             	sub    $0x20,%eax
80104f27:	83 f8 1f             	cmp    $0x1f,%eax
80104f2a:	77 08                	ja     80104f34 <trap+0x28>
80104f2c:	ff 24 85 a0 6d 10 80 	jmp    *-0x7fef9260(,%eax,4)
80104f33:	90                   	nop
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80104f34:	e8 87 e3 ff ff       	call   801032c0 <myproc>
80104f39:	85 c0                	test   %eax,%eax
80104f3b:	0f 84 ba 01 00 00    	je     801050fb <trap+0x1ef>
80104f41:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80104f45:	0f 84 b0 01 00 00    	je     801050fb <trap+0x1ef>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80104f4b:	0f 20 d1             	mov    %cr2,%ecx
80104f4e:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80104f51:	8b 57 38             	mov    0x38(%edi),%edx
80104f54:	89 55 dc             	mov    %edx,-0x24(%ebp)
80104f57:	e8 30 e3 ff ff       	call   8010328c <cpuid>
80104f5c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104f5f:	8b 77 34             	mov    0x34(%edi),%esi
80104f62:	8b 5f 30             	mov    0x30(%edi),%ebx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80104f65:	e8 56 e3 ff ff       	call   801032c0 <myproc>
80104f6a:	89 45 e0             	mov    %eax,-0x20(%ebp)
80104f6d:	e8 4e e3 ff ff       	call   801032c0 <myproc>
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80104f72:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80104f75:	51                   	push   %ecx
80104f76:	8b 55 dc             	mov    -0x24(%ebp),%edx
80104f79:	52                   	push   %edx
80104f7a:	ff 75 e4             	pushl  -0x1c(%ebp)
80104f7d:	56                   	push   %esi
80104f7e:	53                   	push   %ebx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80104f7f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80104f82:	83 c2 6c             	add    $0x6c,%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80104f85:	52                   	push   %edx
80104f86:	ff 70 10             	pushl  0x10(%eax)
80104f89:	68 5c 6d 10 80       	push   $0x80106d5c
80104f8e:	e8 65 b6 ff ff       	call   801005f8 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80104f93:	83 c4 20             	add    $0x20,%esp
80104f96:	e8 25 e3 ff ff       	call   801032c0 <myproc>
80104f9b:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80104fa2:	66 90                	xchg   %ax,%ax
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80104fa4:	e8 17 e3 ff ff       	call   801032c0 <myproc>
80104fa9:	85 c0                	test   %eax,%eax
80104fab:	74 0c                	je     80104fb9 <trap+0xad>
80104fad:	e8 0e e3 ff ff       	call   801032c0 <myproc>
80104fb2:	8b 50 24             	mov    0x24(%eax),%edx
80104fb5:	85 d2                	test   %edx,%edx
80104fb7:	75 43                	jne    80104ffc <trap+0xf0>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80104fb9:	e8 02 e3 ff ff       	call   801032c0 <myproc>
80104fbe:	85 c0                	test   %eax,%eax
80104fc0:	74 0b                	je     80104fcd <trap+0xc1>
80104fc2:	e8 f9 e2 ff ff       	call   801032c0 <myproc>
80104fc7:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80104fcb:	74 43                	je     80105010 <trap+0x104>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80104fcd:	e8 ee e2 ff ff       	call   801032c0 <myproc>
80104fd2:	85 c0                	test   %eax,%eax
80104fd4:	74 1c                	je     80104ff2 <trap+0xe6>
80104fd6:	e8 e5 e2 ff ff       	call   801032c0 <myproc>
80104fdb:	8b 40 24             	mov    0x24(%eax),%eax
80104fde:	85 c0                	test   %eax,%eax
80104fe0:	74 10                	je     80104ff2 <trap+0xe6>
80104fe2:	8b 47 3c             	mov    0x3c(%edi),%eax
80104fe5:	83 e0 03             	and    $0x3,%eax
80104fe8:	66 83 f8 03          	cmp    $0x3,%ax
80104fec:	0f 84 bf 00 00 00    	je     801050b1 <trap+0x1a5>
    exit();
}
80104ff2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ff5:	5b                   	pop    %ebx
80104ff6:	5e                   	pop    %esi
80104ff7:	5f                   	pop    %edi
80104ff8:	5d                   	pop    %ebp
80104ff9:	c3                   	ret    
80104ffa:	66 90                	xchg   %ax,%ax
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80104ffc:	8b 47 3c             	mov    0x3c(%edi),%eax
80104fff:	83 e0 03             	and    $0x3,%eax
80105002:	66 83 f8 03          	cmp    $0x3,%ax
80105006:	75 b1                	jne    80104fb9 <trap+0xad>
    exit();
80105008:	e8 8b e6 ff ff       	call   80103698 <exit>
8010500d:	eb aa                	jmp    80104fb9 <trap+0xad>
8010500f:	90                   	nop

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105010:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80105014:	75 b7                	jne    80104fcd <trap+0xc1>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();
80105016:	e8 99 e7 ff ff       	call   801037b4 <yield>
8010501b:	eb b0                	jmp    80104fcd <trap+0xc1>
8010501d:	8d 76 00             	lea    0x0(%esi),%esi
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
80105020:	e8 67 e2 ff ff       	call   8010328c <cpuid>
80105025:	85 c0                	test   %eax,%eax
80105027:	0f 84 9b 00 00 00    	je     801050c8 <trap+0x1bc>
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
8010502d:	e8 82 d3 ff ff       	call   801023b4 <lapiceoi>
    break;
80105032:	e9 6d ff ff ff       	jmp    80104fa4 <trap+0x98>
80105037:	90                   	nop
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80105038:	e8 63 d2 ff ff       	call   801022a0 <kbdintr>
    lapiceoi();
8010503d:	e8 72 d3 ff ff       	call   801023b4 <lapiceoi>
    break;
80105042:	e9 5d ff ff ff       	jmp    80104fa4 <trap+0x98>
80105047:	90                   	nop
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80105048:	e8 03 02 00 00       	call   80105250 <uartintr>
    lapiceoi();
8010504d:	e8 62 d3 ff ff       	call   801023b4 <lapiceoi>
    break;
80105052:	e9 4d ff ff ff       	jmp    80104fa4 <trap+0x98>
80105057:	90                   	nop
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105058:	8b 77 38             	mov    0x38(%edi),%esi
8010505b:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
8010505f:	e8 28 e2 ff ff       	call   8010328c <cpuid>
80105064:	56                   	push   %esi
80105065:	53                   	push   %ebx
80105066:	50                   	push   %eax
80105067:	68 04 6d 10 80       	push   $0x80106d04
8010506c:	e8 87 b5 ff ff       	call   801005f8 <cprintf>
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
80105071:	e8 3e d3 ff ff       	call   801023b4 <lapiceoi>
    break;
80105076:	83 c4 10             	add    $0x10,%esp
80105079:	e9 26 ff ff ff       	jmp    80104fa4 <trap+0x98>
8010507e:	66 90                	xchg   %ax,%ax
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105080:	e8 1b cd ff ff       	call   80101da0 <ideintr>
80105085:	eb a6                	jmp    8010502d <trap+0x121>
80105087:	90                   	nop
//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
80105088:	e8 33 e2 ff ff       	call   801032c0 <myproc>
8010508d:	8b 58 24             	mov    0x24(%eax),%ebx
80105090:	85 db                	test   %ebx,%ebx
80105092:	75 2c                	jne    801050c0 <trap+0x1b4>
      exit();
    myproc()->tf = tf;
80105094:	e8 27 e2 ff ff       	call   801032c0 <myproc>
80105099:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
8010509c:	e8 e7 f0 ff ff       	call   80104188 <syscall>
    if(myproc()->killed)
801050a1:	e8 1a e2 ff ff       	call   801032c0 <myproc>
801050a6:	8b 48 24             	mov    0x24(%eax),%ecx
801050a9:	85 c9                	test   %ecx,%ecx
801050ab:	0f 84 41 ff ff ff    	je     80104ff2 <trap+0xe6>
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();
}
801050b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801050b4:	5b                   	pop    %ebx
801050b5:	5e                   	pop    %esi
801050b6:	5f                   	pop    %edi
801050b7:	5d                   	pop    %ebp
    if(myproc()->killed)
      exit();
    myproc()->tf = tf;
    syscall();
    if(myproc()->killed)
      exit();
801050b8:	e9 db e5 ff ff       	jmp    80103698 <exit>
801050bd:	8d 76 00             	lea    0x0(%esi),%esi
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
      exit();
801050c0:	e8 d3 e5 ff ff       	call   80103698 <exit>
801050c5:	eb cd                	jmp    80105094 <trap+0x188>
801050c7:	90                   	nop
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
801050c8:	83 ec 0c             	sub    $0xc,%esp
801050cb:	68 60 3c 11 80       	push   $0x80113c60
801050d0:	e8 97 ec ff ff       	call   80103d6c <acquire>
      ticks++;
801050d5:	ff 05 a0 44 11 80    	incl   0x801144a0
      wakeup(&ticks);
801050db:	c7 04 24 a0 44 11 80 	movl   $0x801144a0,(%esp)
801050e2:	e8 bd e8 ff ff       	call   801039a4 <wakeup>
      release(&tickslock);
801050e7:	c7 04 24 60 3c 11 80 	movl   $0x80113c60,(%esp)
801050ee:	e8 11 ed ff ff       	call   80103e04 <release>
801050f3:	83 c4 10             	add    $0x10,%esp
801050f6:	e9 32 ff ff ff       	jmp    8010502d <trap+0x121>
801050fb:	0f 20 d6             	mov    %cr2,%esi

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801050fe:	8b 5f 38             	mov    0x38(%edi),%ebx
80105101:	e8 86 e1 ff ff       	call   8010328c <cpuid>
80105106:	83 ec 0c             	sub    $0xc,%esp
80105109:	56                   	push   %esi
8010510a:	53                   	push   %ebx
8010510b:	50                   	push   %eax
8010510c:	ff 77 30             	pushl  0x30(%edi)
8010510f:	68 28 6d 10 80       	push   $0x80106d28
80105114:	e8 df b4 ff ff       	call   801005f8 <cprintf>
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
80105119:	83 c4 14             	add    $0x14,%esp
8010511c:	68 fe 6c 10 80       	push   $0x80106cfe
80105121:	e8 12 b2 ff ff       	call   80100338 <panic>
80105126:	66 90                	xchg   %ax,%ax

80105128 <uartgetc>:
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80105128:	55                   	push   %ebp
80105129:	89 e5                	mov    %esp,%ebp
  if(!uart)
8010512b:	a1 bc 95 10 80       	mov    0x801095bc,%eax
80105130:	85 c0                	test   %eax,%eax
80105132:	74 18                	je     8010514c <uartgetc+0x24>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105134:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105139:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
8010513a:	a8 01                	test   $0x1,%al
8010513c:	74 0e                	je     8010514c <uartgetc+0x24>
8010513e:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105143:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105144:	0f b6 c0             	movzbl %al,%eax
}
80105147:	5d                   	pop    %ebp
80105148:	c3                   	ret    
80105149:	8d 76 00             	lea    0x0(%esi),%esi

static int
uartgetc(void)
{
  if(!uart)
    return -1;
8010514c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
80105151:	5d                   	pop    %ebp
80105152:	c3                   	ret    
80105153:	90                   	nop

80105154 <uartputc.part.0>:
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}

void
uartputc(int c)
80105154:	55                   	push   %ebp
80105155:	89 e5                	mov    %esp,%ebp
80105157:	57                   	push   %edi
80105158:	56                   	push   %esi
80105159:	53                   	push   %ebx
8010515a:	83 ec 0c             	sub    $0xc,%esp
8010515d:	89 c7                	mov    %eax,%edi
8010515f:	bb 80 00 00 00       	mov    $0x80,%ebx
80105164:	be fd 03 00 00       	mov    $0x3fd,%esi
80105169:	eb 11                	jmp    8010517c <uartputc.part.0+0x28>
8010516b:	90                   	nop
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
8010516c:	83 ec 0c             	sub    $0xc,%esp
8010516f:	6a 0a                	push   $0xa
80105171:	e8 5a d2 ff ff       	call   801023d0 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105176:	83 c4 10             	add    $0x10,%esp
80105179:	4b                   	dec    %ebx
8010517a:	74 07                	je     80105183 <uartputc.part.0+0x2f>
8010517c:	89 f2                	mov    %esi,%edx
8010517e:	ec                   	in     (%dx),%al
8010517f:	a8 20                	test   $0x20,%al
80105181:	74 e9                	je     8010516c <uartputc.part.0+0x18>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105183:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105188:	89 f8                	mov    %edi,%eax
8010518a:	ee                   	out    %al,(%dx)
    microdelay(10);
  outb(COM1+0, c);
}
8010518b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010518e:	5b                   	pop    %ebx
8010518f:	5e                   	pop    %esi
80105190:	5f                   	pop    %edi
80105191:	5d                   	pop    %ebp
80105192:	c3                   	ret    
80105193:	90                   	nop

80105194 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80105194:	55                   	push   %ebp
80105195:	89 e5                	mov    %esp,%ebp
80105197:	57                   	push   %edi
80105198:	56                   	push   %esi
80105199:	53                   	push   %ebx
8010519a:	83 ec 0c             	sub    $0xc,%esp
8010519d:	bb fa 03 00 00       	mov    $0x3fa,%ebx
801051a2:	31 c0                	xor    %eax,%eax
801051a4:	89 da                	mov    %ebx,%edx
801051a6:	ee                   	out    %al,(%dx)
801051a7:	bf fb 03 00 00       	mov    $0x3fb,%edi
801051ac:	b0 80                	mov    $0x80,%al
801051ae:	89 fa                	mov    %edi,%edx
801051b0:	ee                   	out    %al,(%dx)
801051b1:	b9 f8 03 00 00       	mov    $0x3f8,%ecx
801051b6:	b0 0c                	mov    $0xc,%al
801051b8:	89 ca                	mov    %ecx,%edx
801051ba:	ee                   	out    %al,(%dx)
801051bb:	be f9 03 00 00       	mov    $0x3f9,%esi
801051c0:	31 c0                	xor    %eax,%eax
801051c2:	89 f2                	mov    %esi,%edx
801051c4:	ee                   	out    %al,(%dx)
801051c5:	b0 03                	mov    $0x3,%al
801051c7:	89 fa                	mov    %edi,%edx
801051c9:	ee                   	out    %al,(%dx)
801051ca:	ba fc 03 00 00       	mov    $0x3fc,%edx
801051cf:	31 c0                	xor    %eax,%eax
801051d1:	ee                   	out    %al,(%dx)
801051d2:	b0 01                	mov    $0x1,%al
801051d4:	89 f2                	mov    %esi,%edx
801051d6:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801051d7:	ba fd 03 00 00       	mov    $0x3fd,%edx
801051dc:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
801051dd:	fe c0                	inc    %al
801051df:	74 4a                	je     8010522b <uartinit+0x97>
    return;
  uart = 1;
801051e1:	c7 05 bc 95 10 80 01 	movl   $0x1,0x801095bc
801051e8:	00 00 00 
801051eb:	89 da                	mov    %ebx,%edx
801051ed:	ec                   	in     (%dx),%al
801051ee:	89 ca                	mov    %ecx,%edx
801051f0:	ec                   	in     (%dx),%al

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);
801051f1:	83 ec 08             	sub    $0x8,%esp
801051f4:	6a 00                	push   $0x0
801051f6:	6a 04                	push   $0x4
801051f8:	e8 c3 cd ff ff       	call   80101fc0 <ioapicenable>
801051fd:	83 c4 10             	add    $0x10,%esp
80105200:	b8 78 00 00 00       	mov    $0x78,%eax
80105205:	bb 20 6e 10 80       	mov    $0x80106e20,%ebx
8010520a:	eb 08                	jmp    80105214 <uartinit+0x80>

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
8010520c:	43                   	inc    %ebx
8010520d:	0f be 03             	movsbl (%ebx),%eax
80105210:	84 c0                	test   %al,%al
80105212:	74 17                	je     8010522b <uartinit+0x97>
void
uartputc(int c)
{
  int i;

  if(!uart)
80105214:	8b 15 bc 95 10 80    	mov    0x801095bc,%edx
8010521a:	85 d2                	test   %edx,%edx
8010521c:	74 ee                	je     8010520c <uartinit+0x78>
8010521e:	e8 31 ff ff ff       	call   80105154 <uartputc.part.0>
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105223:	43                   	inc    %ebx
80105224:	0f be 03             	movsbl (%ebx),%eax
80105227:	84 c0                	test   %al,%al
80105229:	75 e9                	jne    80105214 <uartinit+0x80>
    uartputc(*p);
}
8010522b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010522e:	5b                   	pop    %ebx
8010522f:	5e                   	pop    %esi
80105230:	5f                   	pop    %edi
80105231:	5d                   	pop    %ebp
80105232:	c3                   	ret    
80105233:	90                   	nop

80105234 <uartputc>:

void
uartputc(int c)
{
80105234:	55                   	push   %ebp
80105235:	89 e5                	mov    %esp,%ebp
80105237:	8b 45 08             	mov    0x8(%ebp),%eax
  int i;

  if(!uart)
8010523a:	8b 15 bc 95 10 80    	mov    0x801095bc,%edx
80105240:	85 d2                	test   %edx,%edx
80105242:	74 08                	je     8010524c <uartputc+0x18>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80105244:	5d                   	pop    %ebp
80105245:	e9 0a ff ff ff       	jmp    80105154 <uartputc.part.0>
8010524a:	66 90                	xchg   %ax,%ax
8010524c:	5d                   	pop    %ebp
8010524d:	c3                   	ret    
8010524e:	66 90                	xchg   %ax,%ax

80105250 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
80105250:	55                   	push   %ebp
80105251:	89 e5                	mov    %esp,%ebp
80105253:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105256:	68 28 51 10 80       	push   $0x80105128
8010525b:	e8 e4 b4 ff ff       	call   80100744 <consoleintr>
}
80105260:	83 c4 10             	add    $0x10,%esp
80105263:	c9                   	leave  
80105264:	c3                   	ret    

80105265 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105265:	6a 00                	push   $0x0
  pushl $0
80105267:	6a 00                	push   $0x0
  jmp alltraps
80105269:	e9 cc fb ff ff       	jmp    80104e3a <alltraps>

8010526e <vector1>:
.globl vector1
vector1:
  pushl $0
8010526e:	6a 00                	push   $0x0
  pushl $1
80105270:	6a 01                	push   $0x1
  jmp alltraps
80105272:	e9 c3 fb ff ff       	jmp    80104e3a <alltraps>

80105277 <vector2>:
.globl vector2
vector2:
  pushl $0
80105277:	6a 00                	push   $0x0
  pushl $2
80105279:	6a 02                	push   $0x2
  jmp alltraps
8010527b:	e9 ba fb ff ff       	jmp    80104e3a <alltraps>

80105280 <vector3>:
.globl vector3
vector3:
  pushl $0
80105280:	6a 00                	push   $0x0
  pushl $3
80105282:	6a 03                	push   $0x3
  jmp alltraps
80105284:	e9 b1 fb ff ff       	jmp    80104e3a <alltraps>

80105289 <vector4>:
.globl vector4
vector4:
  pushl $0
80105289:	6a 00                	push   $0x0
  pushl $4
8010528b:	6a 04                	push   $0x4
  jmp alltraps
8010528d:	e9 a8 fb ff ff       	jmp    80104e3a <alltraps>

80105292 <vector5>:
.globl vector5
vector5:
  pushl $0
80105292:	6a 00                	push   $0x0
  pushl $5
80105294:	6a 05                	push   $0x5
  jmp alltraps
80105296:	e9 9f fb ff ff       	jmp    80104e3a <alltraps>

8010529b <vector6>:
.globl vector6
vector6:
  pushl $0
8010529b:	6a 00                	push   $0x0
  pushl $6
8010529d:	6a 06                	push   $0x6
  jmp alltraps
8010529f:	e9 96 fb ff ff       	jmp    80104e3a <alltraps>

801052a4 <vector7>:
.globl vector7
vector7:
  pushl $0
801052a4:	6a 00                	push   $0x0
  pushl $7
801052a6:	6a 07                	push   $0x7
  jmp alltraps
801052a8:	e9 8d fb ff ff       	jmp    80104e3a <alltraps>

801052ad <vector8>:
.globl vector8
vector8:
  pushl $8
801052ad:	6a 08                	push   $0x8
  jmp alltraps
801052af:	e9 86 fb ff ff       	jmp    80104e3a <alltraps>

801052b4 <vector9>:
.globl vector9
vector9:
  pushl $0
801052b4:	6a 00                	push   $0x0
  pushl $9
801052b6:	6a 09                	push   $0x9
  jmp alltraps
801052b8:	e9 7d fb ff ff       	jmp    80104e3a <alltraps>

801052bd <vector10>:
.globl vector10
vector10:
  pushl $10
801052bd:	6a 0a                	push   $0xa
  jmp alltraps
801052bf:	e9 76 fb ff ff       	jmp    80104e3a <alltraps>

801052c4 <vector11>:
.globl vector11
vector11:
  pushl $11
801052c4:	6a 0b                	push   $0xb
  jmp alltraps
801052c6:	e9 6f fb ff ff       	jmp    80104e3a <alltraps>

801052cb <vector12>:
.globl vector12
vector12:
  pushl $12
801052cb:	6a 0c                	push   $0xc
  jmp alltraps
801052cd:	e9 68 fb ff ff       	jmp    80104e3a <alltraps>

801052d2 <vector13>:
.globl vector13
vector13:
  pushl $13
801052d2:	6a 0d                	push   $0xd
  jmp alltraps
801052d4:	e9 61 fb ff ff       	jmp    80104e3a <alltraps>

801052d9 <vector14>:
.globl vector14
vector14:
  pushl $14
801052d9:	6a 0e                	push   $0xe
  jmp alltraps
801052db:	e9 5a fb ff ff       	jmp    80104e3a <alltraps>

801052e0 <vector15>:
.globl vector15
vector15:
  pushl $0
801052e0:	6a 00                	push   $0x0
  pushl $15
801052e2:	6a 0f                	push   $0xf
  jmp alltraps
801052e4:	e9 51 fb ff ff       	jmp    80104e3a <alltraps>

801052e9 <vector16>:
.globl vector16
vector16:
  pushl $0
801052e9:	6a 00                	push   $0x0
  pushl $16
801052eb:	6a 10                	push   $0x10
  jmp alltraps
801052ed:	e9 48 fb ff ff       	jmp    80104e3a <alltraps>

801052f2 <vector17>:
.globl vector17
vector17:
  pushl $17
801052f2:	6a 11                	push   $0x11
  jmp alltraps
801052f4:	e9 41 fb ff ff       	jmp    80104e3a <alltraps>

801052f9 <vector18>:
.globl vector18
vector18:
  pushl $0
801052f9:	6a 00                	push   $0x0
  pushl $18
801052fb:	6a 12                	push   $0x12
  jmp alltraps
801052fd:	e9 38 fb ff ff       	jmp    80104e3a <alltraps>

80105302 <vector19>:
.globl vector19
vector19:
  pushl $0
80105302:	6a 00                	push   $0x0
  pushl $19
80105304:	6a 13                	push   $0x13
  jmp alltraps
80105306:	e9 2f fb ff ff       	jmp    80104e3a <alltraps>

8010530b <vector20>:
.globl vector20
vector20:
  pushl $0
8010530b:	6a 00                	push   $0x0
  pushl $20
8010530d:	6a 14                	push   $0x14
  jmp alltraps
8010530f:	e9 26 fb ff ff       	jmp    80104e3a <alltraps>

80105314 <vector21>:
.globl vector21
vector21:
  pushl $0
80105314:	6a 00                	push   $0x0
  pushl $21
80105316:	6a 15                	push   $0x15
  jmp alltraps
80105318:	e9 1d fb ff ff       	jmp    80104e3a <alltraps>

8010531d <vector22>:
.globl vector22
vector22:
  pushl $0
8010531d:	6a 00                	push   $0x0
  pushl $22
8010531f:	6a 16                	push   $0x16
  jmp alltraps
80105321:	e9 14 fb ff ff       	jmp    80104e3a <alltraps>

80105326 <vector23>:
.globl vector23
vector23:
  pushl $0
80105326:	6a 00                	push   $0x0
  pushl $23
80105328:	6a 17                	push   $0x17
  jmp alltraps
8010532a:	e9 0b fb ff ff       	jmp    80104e3a <alltraps>

8010532f <vector24>:
.globl vector24
vector24:
  pushl $0
8010532f:	6a 00                	push   $0x0
  pushl $24
80105331:	6a 18                	push   $0x18
  jmp alltraps
80105333:	e9 02 fb ff ff       	jmp    80104e3a <alltraps>

80105338 <vector25>:
.globl vector25
vector25:
  pushl $0
80105338:	6a 00                	push   $0x0
  pushl $25
8010533a:	6a 19                	push   $0x19
  jmp alltraps
8010533c:	e9 f9 fa ff ff       	jmp    80104e3a <alltraps>

80105341 <vector26>:
.globl vector26
vector26:
  pushl $0
80105341:	6a 00                	push   $0x0
  pushl $26
80105343:	6a 1a                	push   $0x1a
  jmp alltraps
80105345:	e9 f0 fa ff ff       	jmp    80104e3a <alltraps>

8010534a <vector27>:
.globl vector27
vector27:
  pushl $0
8010534a:	6a 00                	push   $0x0
  pushl $27
8010534c:	6a 1b                	push   $0x1b
  jmp alltraps
8010534e:	e9 e7 fa ff ff       	jmp    80104e3a <alltraps>

80105353 <vector28>:
.globl vector28
vector28:
  pushl $0
80105353:	6a 00                	push   $0x0
  pushl $28
80105355:	6a 1c                	push   $0x1c
  jmp alltraps
80105357:	e9 de fa ff ff       	jmp    80104e3a <alltraps>

8010535c <vector29>:
.globl vector29
vector29:
  pushl $0
8010535c:	6a 00                	push   $0x0
  pushl $29
8010535e:	6a 1d                	push   $0x1d
  jmp alltraps
80105360:	e9 d5 fa ff ff       	jmp    80104e3a <alltraps>

80105365 <vector30>:
.globl vector30
vector30:
  pushl $0
80105365:	6a 00                	push   $0x0
  pushl $30
80105367:	6a 1e                	push   $0x1e
  jmp alltraps
80105369:	e9 cc fa ff ff       	jmp    80104e3a <alltraps>

8010536e <vector31>:
.globl vector31
vector31:
  pushl $0
8010536e:	6a 00                	push   $0x0
  pushl $31
80105370:	6a 1f                	push   $0x1f
  jmp alltraps
80105372:	e9 c3 fa ff ff       	jmp    80104e3a <alltraps>

80105377 <vector32>:
.globl vector32
vector32:
  pushl $0
80105377:	6a 00                	push   $0x0
  pushl $32
80105379:	6a 20                	push   $0x20
  jmp alltraps
8010537b:	e9 ba fa ff ff       	jmp    80104e3a <alltraps>

80105380 <vector33>:
.globl vector33
vector33:
  pushl $0
80105380:	6a 00                	push   $0x0
  pushl $33
80105382:	6a 21                	push   $0x21
  jmp alltraps
80105384:	e9 b1 fa ff ff       	jmp    80104e3a <alltraps>

80105389 <vector34>:
.globl vector34
vector34:
  pushl $0
80105389:	6a 00                	push   $0x0
  pushl $34
8010538b:	6a 22                	push   $0x22
  jmp alltraps
8010538d:	e9 a8 fa ff ff       	jmp    80104e3a <alltraps>

80105392 <vector35>:
.globl vector35
vector35:
  pushl $0
80105392:	6a 00                	push   $0x0
  pushl $35
80105394:	6a 23                	push   $0x23
  jmp alltraps
80105396:	e9 9f fa ff ff       	jmp    80104e3a <alltraps>

8010539b <vector36>:
.globl vector36
vector36:
  pushl $0
8010539b:	6a 00                	push   $0x0
  pushl $36
8010539d:	6a 24                	push   $0x24
  jmp alltraps
8010539f:	e9 96 fa ff ff       	jmp    80104e3a <alltraps>

801053a4 <vector37>:
.globl vector37
vector37:
  pushl $0
801053a4:	6a 00                	push   $0x0
  pushl $37
801053a6:	6a 25                	push   $0x25
  jmp alltraps
801053a8:	e9 8d fa ff ff       	jmp    80104e3a <alltraps>

801053ad <vector38>:
.globl vector38
vector38:
  pushl $0
801053ad:	6a 00                	push   $0x0
  pushl $38
801053af:	6a 26                	push   $0x26
  jmp alltraps
801053b1:	e9 84 fa ff ff       	jmp    80104e3a <alltraps>

801053b6 <vector39>:
.globl vector39
vector39:
  pushl $0
801053b6:	6a 00                	push   $0x0
  pushl $39
801053b8:	6a 27                	push   $0x27
  jmp alltraps
801053ba:	e9 7b fa ff ff       	jmp    80104e3a <alltraps>

801053bf <vector40>:
.globl vector40
vector40:
  pushl $0
801053bf:	6a 00                	push   $0x0
  pushl $40
801053c1:	6a 28                	push   $0x28
  jmp alltraps
801053c3:	e9 72 fa ff ff       	jmp    80104e3a <alltraps>

801053c8 <vector41>:
.globl vector41
vector41:
  pushl $0
801053c8:	6a 00                	push   $0x0
  pushl $41
801053ca:	6a 29                	push   $0x29
  jmp alltraps
801053cc:	e9 69 fa ff ff       	jmp    80104e3a <alltraps>

801053d1 <vector42>:
.globl vector42
vector42:
  pushl $0
801053d1:	6a 00                	push   $0x0
  pushl $42
801053d3:	6a 2a                	push   $0x2a
  jmp alltraps
801053d5:	e9 60 fa ff ff       	jmp    80104e3a <alltraps>

801053da <vector43>:
.globl vector43
vector43:
  pushl $0
801053da:	6a 00                	push   $0x0
  pushl $43
801053dc:	6a 2b                	push   $0x2b
  jmp alltraps
801053de:	e9 57 fa ff ff       	jmp    80104e3a <alltraps>

801053e3 <vector44>:
.globl vector44
vector44:
  pushl $0
801053e3:	6a 00                	push   $0x0
  pushl $44
801053e5:	6a 2c                	push   $0x2c
  jmp alltraps
801053e7:	e9 4e fa ff ff       	jmp    80104e3a <alltraps>

801053ec <vector45>:
.globl vector45
vector45:
  pushl $0
801053ec:	6a 00                	push   $0x0
  pushl $45
801053ee:	6a 2d                	push   $0x2d
  jmp alltraps
801053f0:	e9 45 fa ff ff       	jmp    80104e3a <alltraps>

801053f5 <vector46>:
.globl vector46
vector46:
  pushl $0
801053f5:	6a 00                	push   $0x0
  pushl $46
801053f7:	6a 2e                	push   $0x2e
  jmp alltraps
801053f9:	e9 3c fa ff ff       	jmp    80104e3a <alltraps>

801053fe <vector47>:
.globl vector47
vector47:
  pushl $0
801053fe:	6a 00                	push   $0x0
  pushl $47
80105400:	6a 2f                	push   $0x2f
  jmp alltraps
80105402:	e9 33 fa ff ff       	jmp    80104e3a <alltraps>

80105407 <vector48>:
.globl vector48
vector48:
  pushl $0
80105407:	6a 00                	push   $0x0
  pushl $48
80105409:	6a 30                	push   $0x30
  jmp alltraps
8010540b:	e9 2a fa ff ff       	jmp    80104e3a <alltraps>

80105410 <vector49>:
.globl vector49
vector49:
  pushl $0
80105410:	6a 00                	push   $0x0
  pushl $49
80105412:	6a 31                	push   $0x31
  jmp alltraps
80105414:	e9 21 fa ff ff       	jmp    80104e3a <alltraps>

80105419 <vector50>:
.globl vector50
vector50:
  pushl $0
80105419:	6a 00                	push   $0x0
  pushl $50
8010541b:	6a 32                	push   $0x32
  jmp alltraps
8010541d:	e9 18 fa ff ff       	jmp    80104e3a <alltraps>

80105422 <vector51>:
.globl vector51
vector51:
  pushl $0
80105422:	6a 00                	push   $0x0
  pushl $51
80105424:	6a 33                	push   $0x33
  jmp alltraps
80105426:	e9 0f fa ff ff       	jmp    80104e3a <alltraps>

8010542b <vector52>:
.globl vector52
vector52:
  pushl $0
8010542b:	6a 00                	push   $0x0
  pushl $52
8010542d:	6a 34                	push   $0x34
  jmp alltraps
8010542f:	e9 06 fa ff ff       	jmp    80104e3a <alltraps>

80105434 <vector53>:
.globl vector53
vector53:
  pushl $0
80105434:	6a 00                	push   $0x0
  pushl $53
80105436:	6a 35                	push   $0x35
  jmp alltraps
80105438:	e9 fd f9 ff ff       	jmp    80104e3a <alltraps>

8010543d <vector54>:
.globl vector54
vector54:
  pushl $0
8010543d:	6a 00                	push   $0x0
  pushl $54
8010543f:	6a 36                	push   $0x36
  jmp alltraps
80105441:	e9 f4 f9 ff ff       	jmp    80104e3a <alltraps>

80105446 <vector55>:
.globl vector55
vector55:
  pushl $0
80105446:	6a 00                	push   $0x0
  pushl $55
80105448:	6a 37                	push   $0x37
  jmp alltraps
8010544a:	e9 eb f9 ff ff       	jmp    80104e3a <alltraps>

8010544f <vector56>:
.globl vector56
vector56:
  pushl $0
8010544f:	6a 00                	push   $0x0
  pushl $56
80105451:	6a 38                	push   $0x38
  jmp alltraps
80105453:	e9 e2 f9 ff ff       	jmp    80104e3a <alltraps>

80105458 <vector57>:
.globl vector57
vector57:
  pushl $0
80105458:	6a 00                	push   $0x0
  pushl $57
8010545a:	6a 39                	push   $0x39
  jmp alltraps
8010545c:	e9 d9 f9 ff ff       	jmp    80104e3a <alltraps>

80105461 <vector58>:
.globl vector58
vector58:
  pushl $0
80105461:	6a 00                	push   $0x0
  pushl $58
80105463:	6a 3a                	push   $0x3a
  jmp alltraps
80105465:	e9 d0 f9 ff ff       	jmp    80104e3a <alltraps>

8010546a <vector59>:
.globl vector59
vector59:
  pushl $0
8010546a:	6a 00                	push   $0x0
  pushl $59
8010546c:	6a 3b                	push   $0x3b
  jmp alltraps
8010546e:	e9 c7 f9 ff ff       	jmp    80104e3a <alltraps>

80105473 <vector60>:
.globl vector60
vector60:
  pushl $0
80105473:	6a 00                	push   $0x0
  pushl $60
80105475:	6a 3c                	push   $0x3c
  jmp alltraps
80105477:	e9 be f9 ff ff       	jmp    80104e3a <alltraps>

8010547c <vector61>:
.globl vector61
vector61:
  pushl $0
8010547c:	6a 00                	push   $0x0
  pushl $61
8010547e:	6a 3d                	push   $0x3d
  jmp alltraps
80105480:	e9 b5 f9 ff ff       	jmp    80104e3a <alltraps>

80105485 <vector62>:
.globl vector62
vector62:
  pushl $0
80105485:	6a 00                	push   $0x0
  pushl $62
80105487:	6a 3e                	push   $0x3e
  jmp alltraps
80105489:	e9 ac f9 ff ff       	jmp    80104e3a <alltraps>

8010548e <vector63>:
.globl vector63
vector63:
  pushl $0
8010548e:	6a 00                	push   $0x0
  pushl $63
80105490:	6a 3f                	push   $0x3f
  jmp alltraps
80105492:	e9 a3 f9 ff ff       	jmp    80104e3a <alltraps>

80105497 <vector64>:
.globl vector64
vector64:
  pushl $0
80105497:	6a 00                	push   $0x0
  pushl $64
80105499:	6a 40                	push   $0x40
  jmp alltraps
8010549b:	e9 9a f9 ff ff       	jmp    80104e3a <alltraps>

801054a0 <vector65>:
.globl vector65
vector65:
  pushl $0
801054a0:	6a 00                	push   $0x0
  pushl $65
801054a2:	6a 41                	push   $0x41
  jmp alltraps
801054a4:	e9 91 f9 ff ff       	jmp    80104e3a <alltraps>

801054a9 <vector66>:
.globl vector66
vector66:
  pushl $0
801054a9:	6a 00                	push   $0x0
  pushl $66
801054ab:	6a 42                	push   $0x42
  jmp alltraps
801054ad:	e9 88 f9 ff ff       	jmp    80104e3a <alltraps>

801054b2 <vector67>:
.globl vector67
vector67:
  pushl $0
801054b2:	6a 00                	push   $0x0
  pushl $67
801054b4:	6a 43                	push   $0x43
  jmp alltraps
801054b6:	e9 7f f9 ff ff       	jmp    80104e3a <alltraps>

801054bb <vector68>:
.globl vector68
vector68:
  pushl $0
801054bb:	6a 00                	push   $0x0
  pushl $68
801054bd:	6a 44                	push   $0x44
  jmp alltraps
801054bf:	e9 76 f9 ff ff       	jmp    80104e3a <alltraps>

801054c4 <vector69>:
.globl vector69
vector69:
  pushl $0
801054c4:	6a 00                	push   $0x0
  pushl $69
801054c6:	6a 45                	push   $0x45
  jmp alltraps
801054c8:	e9 6d f9 ff ff       	jmp    80104e3a <alltraps>

801054cd <vector70>:
.globl vector70
vector70:
  pushl $0
801054cd:	6a 00                	push   $0x0
  pushl $70
801054cf:	6a 46                	push   $0x46
  jmp alltraps
801054d1:	e9 64 f9 ff ff       	jmp    80104e3a <alltraps>

801054d6 <vector71>:
.globl vector71
vector71:
  pushl $0
801054d6:	6a 00                	push   $0x0
  pushl $71
801054d8:	6a 47                	push   $0x47
  jmp alltraps
801054da:	e9 5b f9 ff ff       	jmp    80104e3a <alltraps>

801054df <vector72>:
.globl vector72
vector72:
  pushl $0
801054df:	6a 00                	push   $0x0
  pushl $72
801054e1:	6a 48                	push   $0x48
  jmp alltraps
801054e3:	e9 52 f9 ff ff       	jmp    80104e3a <alltraps>

801054e8 <vector73>:
.globl vector73
vector73:
  pushl $0
801054e8:	6a 00                	push   $0x0
  pushl $73
801054ea:	6a 49                	push   $0x49
  jmp alltraps
801054ec:	e9 49 f9 ff ff       	jmp    80104e3a <alltraps>

801054f1 <vector74>:
.globl vector74
vector74:
  pushl $0
801054f1:	6a 00                	push   $0x0
  pushl $74
801054f3:	6a 4a                	push   $0x4a
  jmp alltraps
801054f5:	e9 40 f9 ff ff       	jmp    80104e3a <alltraps>

801054fa <vector75>:
.globl vector75
vector75:
  pushl $0
801054fa:	6a 00                	push   $0x0
  pushl $75
801054fc:	6a 4b                	push   $0x4b
  jmp alltraps
801054fe:	e9 37 f9 ff ff       	jmp    80104e3a <alltraps>

80105503 <vector76>:
.globl vector76
vector76:
  pushl $0
80105503:	6a 00                	push   $0x0
  pushl $76
80105505:	6a 4c                	push   $0x4c
  jmp alltraps
80105507:	e9 2e f9 ff ff       	jmp    80104e3a <alltraps>

8010550c <vector77>:
.globl vector77
vector77:
  pushl $0
8010550c:	6a 00                	push   $0x0
  pushl $77
8010550e:	6a 4d                	push   $0x4d
  jmp alltraps
80105510:	e9 25 f9 ff ff       	jmp    80104e3a <alltraps>

80105515 <vector78>:
.globl vector78
vector78:
  pushl $0
80105515:	6a 00                	push   $0x0
  pushl $78
80105517:	6a 4e                	push   $0x4e
  jmp alltraps
80105519:	e9 1c f9 ff ff       	jmp    80104e3a <alltraps>

8010551e <vector79>:
.globl vector79
vector79:
  pushl $0
8010551e:	6a 00                	push   $0x0
  pushl $79
80105520:	6a 4f                	push   $0x4f
  jmp alltraps
80105522:	e9 13 f9 ff ff       	jmp    80104e3a <alltraps>

80105527 <vector80>:
.globl vector80
vector80:
  pushl $0
80105527:	6a 00                	push   $0x0
  pushl $80
80105529:	6a 50                	push   $0x50
  jmp alltraps
8010552b:	e9 0a f9 ff ff       	jmp    80104e3a <alltraps>

80105530 <vector81>:
.globl vector81
vector81:
  pushl $0
80105530:	6a 00                	push   $0x0
  pushl $81
80105532:	6a 51                	push   $0x51
  jmp alltraps
80105534:	e9 01 f9 ff ff       	jmp    80104e3a <alltraps>

80105539 <vector82>:
.globl vector82
vector82:
  pushl $0
80105539:	6a 00                	push   $0x0
  pushl $82
8010553b:	6a 52                	push   $0x52
  jmp alltraps
8010553d:	e9 f8 f8 ff ff       	jmp    80104e3a <alltraps>

80105542 <vector83>:
.globl vector83
vector83:
  pushl $0
80105542:	6a 00                	push   $0x0
  pushl $83
80105544:	6a 53                	push   $0x53
  jmp alltraps
80105546:	e9 ef f8 ff ff       	jmp    80104e3a <alltraps>

8010554b <vector84>:
.globl vector84
vector84:
  pushl $0
8010554b:	6a 00                	push   $0x0
  pushl $84
8010554d:	6a 54                	push   $0x54
  jmp alltraps
8010554f:	e9 e6 f8 ff ff       	jmp    80104e3a <alltraps>

80105554 <vector85>:
.globl vector85
vector85:
  pushl $0
80105554:	6a 00                	push   $0x0
  pushl $85
80105556:	6a 55                	push   $0x55
  jmp alltraps
80105558:	e9 dd f8 ff ff       	jmp    80104e3a <alltraps>

8010555d <vector86>:
.globl vector86
vector86:
  pushl $0
8010555d:	6a 00                	push   $0x0
  pushl $86
8010555f:	6a 56                	push   $0x56
  jmp alltraps
80105561:	e9 d4 f8 ff ff       	jmp    80104e3a <alltraps>

80105566 <vector87>:
.globl vector87
vector87:
  pushl $0
80105566:	6a 00                	push   $0x0
  pushl $87
80105568:	6a 57                	push   $0x57
  jmp alltraps
8010556a:	e9 cb f8 ff ff       	jmp    80104e3a <alltraps>

8010556f <vector88>:
.globl vector88
vector88:
  pushl $0
8010556f:	6a 00                	push   $0x0
  pushl $88
80105571:	6a 58                	push   $0x58
  jmp alltraps
80105573:	e9 c2 f8 ff ff       	jmp    80104e3a <alltraps>

80105578 <vector89>:
.globl vector89
vector89:
  pushl $0
80105578:	6a 00                	push   $0x0
  pushl $89
8010557a:	6a 59                	push   $0x59
  jmp alltraps
8010557c:	e9 b9 f8 ff ff       	jmp    80104e3a <alltraps>

80105581 <vector90>:
.globl vector90
vector90:
  pushl $0
80105581:	6a 00                	push   $0x0
  pushl $90
80105583:	6a 5a                	push   $0x5a
  jmp alltraps
80105585:	e9 b0 f8 ff ff       	jmp    80104e3a <alltraps>

8010558a <vector91>:
.globl vector91
vector91:
  pushl $0
8010558a:	6a 00                	push   $0x0
  pushl $91
8010558c:	6a 5b                	push   $0x5b
  jmp alltraps
8010558e:	e9 a7 f8 ff ff       	jmp    80104e3a <alltraps>

80105593 <vector92>:
.globl vector92
vector92:
  pushl $0
80105593:	6a 00                	push   $0x0
  pushl $92
80105595:	6a 5c                	push   $0x5c
  jmp alltraps
80105597:	e9 9e f8 ff ff       	jmp    80104e3a <alltraps>

8010559c <vector93>:
.globl vector93
vector93:
  pushl $0
8010559c:	6a 00                	push   $0x0
  pushl $93
8010559e:	6a 5d                	push   $0x5d
  jmp alltraps
801055a0:	e9 95 f8 ff ff       	jmp    80104e3a <alltraps>

801055a5 <vector94>:
.globl vector94
vector94:
  pushl $0
801055a5:	6a 00                	push   $0x0
  pushl $94
801055a7:	6a 5e                	push   $0x5e
  jmp alltraps
801055a9:	e9 8c f8 ff ff       	jmp    80104e3a <alltraps>

801055ae <vector95>:
.globl vector95
vector95:
  pushl $0
801055ae:	6a 00                	push   $0x0
  pushl $95
801055b0:	6a 5f                	push   $0x5f
  jmp alltraps
801055b2:	e9 83 f8 ff ff       	jmp    80104e3a <alltraps>

801055b7 <vector96>:
.globl vector96
vector96:
  pushl $0
801055b7:	6a 00                	push   $0x0
  pushl $96
801055b9:	6a 60                	push   $0x60
  jmp alltraps
801055bb:	e9 7a f8 ff ff       	jmp    80104e3a <alltraps>

801055c0 <vector97>:
.globl vector97
vector97:
  pushl $0
801055c0:	6a 00                	push   $0x0
  pushl $97
801055c2:	6a 61                	push   $0x61
  jmp alltraps
801055c4:	e9 71 f8 ff ff       	jmp    80104e3a <alltraps>

801055c9 <vector98>:
.globl vector98
vector98:
  pushl $0
801055c9:	6a 00                	push   $0x0
  pushl $98
801055cb:	6a 62                	push   $0x62
  jmp alltraps
801055cd:	e9 68 f8 ff ff       	jmp    80104e3a <alltraps>

801055d2 <vector99>:
.globl vector99
vector99:
  pushl $0
801055d2:	6a 00                	push   $0x0
  pushl $99
801055d4:	6a 63                	push   $0x63
  jmp alltraps
801055d6:	e9 5f f8 ff ff       	jmp    80104e3a <alltraps>

801055db <vector100>:
.globl vector100
vector100:
  pushl $0
801055db:	6a 00                	push   $0x0
  pushl $100
801055dd:	6a 64                	push   $0x64
  jmp alltraps
801055df:	e9 56 f8 ff ff       	jmp    80104e3a <alltraps>

801055e4 <vector101>:
.globl vector101
vector101:
  pushl $0
801055e4:	6a 00                	push   $0x0
  pushl $101
801055e6:	6a 65                	push   $0x65
  jmp alltraps
801055e8:	e9 4d f8 ff ff       	jmp    80104e3a <alltraps>

801055ed <vector102>:
.globl vector102
vector102:
  pushl $0
801055ed:	6a 00                	push   $0x0
  pushl $102
801055ef:	6a 66                	push   $0x66
  jmp alltraps
801055f1:	e9 44 f8 ff ff       	jmp    80104e3a <alltraps>

801055f6 <vector103>:
.globl vector103
vector103:
  pushl $0
801055f6:	6a 00                	push   $0x0
  pushl $103
801055f8:	6a 67                	push   $0x67
  jmp alltraps
801055fa:	e9 3b f8 ff ff       	jmp    80104e3a <alltraps>

801055ff <vector104>:
.globl vector104
vector104:
  pushl $0
801055ff:	6a 00                	push   $0x0
  pushl $104
80105601:	6a 68                	push   $0x68
  jmp alltraps
80105603:	e9 32 f8 ff ff       	jmp    80104e3a <alltraps>

80105608 <vector105>:
.globl vector105
vector105:
  pushl $0
80105608:	6a 00                	push   $0x0
  pushl $105
8010560a:	6a 69                	push   $0x69
  jmp alltraps
8010560c:	e9 29 f8 ff ff       	jmp    80104e3a <alltraps>

80105611 <vector106>:
.globl vector106
vector106:
  pushl $0
80105611:	6a 00                	push   $0x0
  pushl $106
80105613:	6a 6a                	push   $0x6a
  jmp alltraps
80105615:	e9 20 f8 ff ff       	jmp    80104e3a <alltraps>

8010561a <vector107>:
.globl vector107
vector107:
  pushl $0
8010561a:	6a 00                	push   $0x0
  pushl $107
8010561c:	6a 6b                	push   $0x6b
  jmp alltraps
8010561e:	e9 17 f8 ff ff       	jmp    80104e3a <alltraps>

80105623 <vector108>:
.globl vector108
vector108:
  pushl $0
80105623:	6a 00                	push   $0x0
  pushl $108
80105625:	6a 6c                	push   $0x6c
  jmp alltraps
80105627:	e9 0e f8 ff ff       	jmp    80104e3a <alltraps>

8010562c <vector109>:
.globl vector109
vector109:
  pushl $0
8010562c:	6a 00                	push   $0x0
  pushl $109
8010562e:	6a 6d                	push   $0x6d
  jmp alltraps
80105630:	e9 05 f8 ff ff       	jmp    80104e3a <alltraps>

80105635 <vector110>:
.globl vector110
vector110:
  pushl $0
80105635:	6a 00                	push   $0x0
  pushl $110
80105637:	6a 6e                	push   $0x6e
  jmp alltraps
80105639:	e9 fc f7 ff ff       	jmp    80104e3a <alltraps>

8010563e <vector111>:
.globl vector111
vector111:
  pushl $0
8010563e:	6a 00                	push   $0x0
  pushl $111
80105640:	6a 6f                	push   $0x6f
  jmp alltraps
80105642:	e9 f3 f7 ff ff       	jmp    80104e3a <alltraps>

80105647 <vector112>:
.globl vector112
vector112:
  pushl $0
80105647:	6a 00                	push   $0x0
  pushl $112
80105649:	6a 70                	push   $0x70
  jmp alltraps
8010564b:	e9 ea f7 ff ff       	jmp    80104e3a <alltraps>

80105650 <vector113>:
.globl vector113
vector113:
  pushl $0
80105650:	6a 00                	push   $0x0
  pushl $113
80105652:	6a 71                	push   $0x71
  jmp alltraps
80105654:	e9 e1 f7 ff ff       	jmp    80104e3a <alltraps>

80105659 <vector114>:
.globl vector114
vector114:
  pushl $0
80105659:	6a 00                	push   $0x0
  pushl $114
8010565b:	6a 72                	push   $0x72
  jmp alltraps
8010565d:	e9 d8 f7 ff ff       	jmp    80104e3a <alltraps>

80105662 <vector115>:
.globl vector115
vector115:
  pushl $0
80105662:	6a 00                	push   $0x0
  pushl $115
80105664:	6a 73                	push   $0x73
  jmp alltraps
80105666:	e9 cf f7 ff ff       	jmp    80104e3a <alltraps>

8010566b <vector116>:
.globl vector116
vector116:
  pushl $0
8010566b:	6a 00                	push   $0x0
  pushl $116
8010566d:	6a 74                	push   $0x74
  jmp alltraps
8010566f:	e9 c6 f7 ff ff       	jmp    80104e3a <alltraps>

80105674 <vector117>:
.globl vector117
vector117:
  pushl $0
80105674:	6a 00                	push   $0x0
  pushl $117
80105676:	6a 75                	push   $0x75
  jmp alltraps
80105678:	e9 bd f7 ff ff       	jmp    80104e3a <alltraps>

8010567d <vector118>:
.globl vector118
vector118:
  pushl $0
8010567d:	6a 00                	push   $0x0
  pushl $118
8010567f:	6a 76                	push   $0x76
  jmp alltraps
80105681:	e9 b4 f7 ff ff       	jmp    80104e3a <alltraps>

80105686 <vector119>:
.globl vector119
vector119:
  pushl $0
80105686:	6a 00                	push   $0x0
  pushl $119
80105688:	6a 77                	push   $0x77
  jmp alltraps
8010568a:	e9 ab f7 ff ff       	jmp    80104e3a <alltraps>

8010568f <vector120>:
.globl vector120
vector120:
  pushl $0
8010568f:	6a 00                	push   $0x0
  pushl $120
80105691:	6a 78                	push   $0x78
  jmp alltraps
80105693:	e9 a2 f7 ff ff       	jmp    80104e3a <alltraps>

80105698 <vector121>:
.globl vector121
vector121:
  pushl $0
80105698:	6a 00                	push   $0x0
  pushl $121
8010569a:	6a 79                	push   $0x79
  jmp alltraps
8010569c:	e9 99 f7 ff ff       	jmp    80104e3a <alltraps>

801056a1 <vector122>:
.globl vector122
vector122:
  pushl $0
801056a1:	6a 00                	push   $0x0
  pushl $122
801056a3:	6a 7a                	push   $0x7a
  jmp alltraps
801056a5:	e9 90 f7 ff ff       	jmp    80104e3a <alltraps>

801056aa <vector123>:
.globl vector123
vector123:
  pushl $0
801056aa:	6a 00                	push   $0x0
  pushl $123
801056ac:	6a 7b                	push   $0x7b
  jmp alltraps
801056ae:	e9 87 f7 ff ff       	jmp    80104e3a <alltraps>

801056b3 <vector124>:
.globl vector124
vector124:
  pushl $0
801056b3:	6a 00                	push   $0x0
  pushl $124
801056b5:	6a 7c                	push   $0x7c
  jmp alltraps
801056b7:	e9 7e f7 ff ff       	jmp    80104e3a <alltraps>

801056bc <vector125>:
.globl vector125
vector125:
  pushl $0
801056bc:	6a 00                	push   $0x0
  pushl $125
801056be:	6a 7d                	push   $0x7d
  jmp alltraps
801056c0:	e9 75 f7 ff ff       	jmp    80104e3a <alltraps>

801056c5 <vector126>:
.globl vector126
vector126:
  pushl $0
801056c5:	6a 00                	push   $0x0
  pushl $126
801056c7:	6a 7e                	push   $0x7e
  jmp alltraps
801056c9:	e9 6c f7 ff ff       	jmp    80104e3a <alltraps>

801056ce <vector127>:
.globl vector127
vector127:
  pushl $0
801056ce:	6a 00                	push   $0x0
  pushl $127
801056d0:	6a 7f                	push   $0x7f
  jmp alltraps
801056d2:	e9 63 f7 ff ff       	jmp    80104e3a <alltraps>

801056d7 <vector128>:
.globl vector128
vector128:
  pushl $0
801056d7:	6a 00                	push   $0x0
  pushl $128
801056d9:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801056de:	e9 57 f7 ff ff       	jmp    80104e3a <alltraps>

801056e3 <vector129>:
.globl vector129
vector129:
  pushl $0
801056e3:	6a 00                	push   $0x0
  pushl $129
801056e5:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801056ea:	e9 4b f7 ff ff       	jmp    80104e3a <alltraps>

801056ef <vector130>:
.globl vector130
vector130:
  pushl $0
801056ef:	6a 00                	push   $0x0
  pushl $130
801056f1:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801056f6:	e9 3f f7 ff ff       	jmp    80104e3a <alltraps>

801056fb <vector131>:
.globl vector131
vector131:
  pushl $0
801056fb:	6a 00                	push   $0x0
  pushl $131
801056fd:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80105702:	e9 33 f7 ff ff       	jmp    80104e3a <alltraps>

80105707 <vector132>:
.globl vector132
vector132:
  pushl $0
80105707:	6a 00                	push   $0x0
  pushl $132
80105709:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010570e:	e9 27 f7 ff ff       	jmp    80104e3a <alltraps>

80105713 <vector133>:
.globl vector133
vector133:
  pushl $0
80105713:	6a 00                	push   $0x0
  pushl $133
80105715:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010571a:	e9 1b f7 ff ff       	jmp    80104e3a <alltraps>

8010571f <vector134>:
.globl vector134
vector134:
  pushl $0
8010571f:	6a 00                	push   $0x0
  pushl $134
80105721:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80105726:	e9 0f f7 ff ff       	jmp    80104e3a <alltraps>

8010572b <vector135>:
.globl vector135
vector135:
  pushl $0
8010572b:	6a 00                	push   $0x0
  pushl $135
8010572d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80105732:	e9 03 f7 ff ff       	jmp    80104e3a <alltraps>

80105737 <vector136>:
.globl vector136
vector136:
  pushl $0
80105737:	6a 00                	push   $0x0
  pushl $136
80105739:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010573e:	e9 f7 f6 ff ff       	jmp    80104e3a <alltraps>

80105743 <vector137>:
.globl vector137
vector137:
  pushl $0
80105743:	6a 00                	push   $0x0
  pushl $137
80105745:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010574a:	e9 eb f6 ff ff       	jmp    80104e3a <alltraps>

8010574f <vector138>:
.globl vector138
vector138:
  pushl $0
8010574f:	6a 00                	push   $0x0
  pushl $138
80105751:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80105756:	e9 df f6 ff ff       	jmp    80104e3a <alltraps>

8010575b <vector139>:
.globl vector139
vector139:
  pushl $0
8010575b:	6a 00                	push   $0x0
  pushl $139
8010575d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80105762:	e9 d3 f6 ff ff       	jmp    80104e3a <alltraps>

80105767 <vector140>:
.globl vector140
vector140:
  pushl $0
80105767:	6a 00                	push   $0x0
  pushl $140
80105769:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010576e:	e9 c7 f6 ff ff       	jmp    80104e3a <alltraps>

80105773 <vector141>:
.globl vector141
vector141:
  pushl $0
80105773:	6a 00                	push   $0x0
  pushl $141
80105775:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010577a:	e9 bb f6 ff ff       	jmp    80104e3a <alltraps>

8010577f <vector142>:
.globl vector142
vector142:
  pushl $0
8010577f:	6a 00                	push   $0x0
  pushl $142
80105781:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80105786:	e9 af f6 ff ff       	jmp    80104e3a <alltraps>

8010578b <vector143>:
.globl vector143
vector143:
  pushl $0
8010578b:	6a 00                	push   $0x0
  pushl $143
8010578d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80105792:	e9 a3 f6 ff ff       	jmp    80104e3a <alltraps>

80105797 <vector144>:
.globl vector144
vector144:
  pushl $0
80105797:	6a 00                	push   $0x0
  pushl $144
80105799:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010579e:	e9 97 f6 ff ff       	jmp    80104e3a <alltraps>

801057a3 <vector145>:
.globl vector145
vector145:
  pushl $0
801057a3:	6a 00                	push   $0x0
  pushl $145
801057a5:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801057aa:	e9 8b f6 ff ff       	jmp    80104e3a <alltraps>

801057af <vector146>:
.globl vector146
vector146:
  pushl $0
801057af:	6a 00                	push   $0x0
  pushl $146
801057b1:	68 92 00 00 00       	push   $0x92
  jmp alltraps
801057b6:	e9 7f f6 ff ff       	jmp    80104e3a <alltraps>

801057bb <vector147>:
.globl vector147
vector147:
  pushl $0
801057bb:	6a 00                	push   $0x0
  pushl $147
801057bd:	68 93 00 00 00       	push   $0x93
  jmp alltraps
801057c2:	e9 73 f6 ff ff       	jmp    80104e3a <alltraps>

801057c7 <vector148>:
.globl vector148
vector148:
  pushl $0
801057c7:	6a 00                	push   $0x0
  pushl $148
801057c9:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801057ce:	e9 67 f6 ff ff       	jmp    80104e3a <alltraps>

801057d3 <vector149>:
.globl vector149
vector149:
  pushl $0
801057d3:	6a 00                	push   $0x0
  pushl $149
801057d5:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801057da:	e9 5b f6 ff ff       	jmp    80104e3a <alltraps>

801057df <vector150>:
.globl vector150
vector150:
  pushl $0
801057df:	6a 00                	push   $0x0
  pushl $150
801057e1:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801057e6:	e9 4f f6 ff ff       	jmp    80104e3a <alltraps>

801057eb <vector151>:
.globl vector151
vector151:
  pushl $0
801057eb:	6a 00                	push   $0x0
  pushl $151
801057ed:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801057f2:	e9 43 f6 ff ff       	jmp    80104e3a <alltraps>

801057f7 <vector152>:
.globl vector152
vector152:
  pushl $0
801057f7:	6a 00                	push   $0x0
  pushl $152
801057f9:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801057fe:	e9 37 f6 ff ff       	jmp    80104e3a <alltraps>

80105803 <vector153>:
.globl vector153
vector153:
  pushl $0
80105803:	6a 00                	push   $0x0
  pushl $153
80105805:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010580a:	e9 2b f6 ff ff       	jmp    80104e3a <alltraps>

8010580f <vector154>:
.globl vector154
vector154:
  pushl $0
8010580f:	6a 00                	push   $0x0
  pushl $154
80105811:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80105816:	e9 1f f6 ff ff       	jmp    80104e3a <alltraps>

8010581b <vector155>:
.globl vector155
vector155:
  pushl $0
8010581b:	6a 00                	push   $0x0
  pushl $155
8010581d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80105822:	e9 13 f6 ff ff       	jmp    80104e3a <alltraps>

80105827 <vector156>:
.globl vector156
vector156:
  pushl $0
80105827:	6a 00                	push   $0x0
  pushl $156
80105829:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010582e:	e9 07 f6 ff ff       	jmp    80104e3a <alltraps>

80105833 <vector157>:
.globl vector157
vector157:
  pushl $0
80105833:	6a 00                	push   $0x0
  pushl $157
80105835:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010583a:	e9 fb f5 ff ff       	jmp    80104e3a <alltraps>

8010583f <vector158>:
.globl vector158
vector158:
  pushl $0
8010583f:	6a 00                	push   $0x0
  pushl $158
80105841:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80105846:	e9 ef f5 ff ff       	jmp    80104e3a <alltraps>

8010584b <vector159>:
.globl vector159
vector159:
  pushl $0
8010584b:	6a 00                	push   $0x0
  pushl $159
8010584d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80105852:	e9 e3 f5 ff ff       	jmp    80104e3a <alltraps>

80105857 <vector160>:
.globl vector160
vector160:
  pushl $0
80105857:	6a 00                	push   $0x0
  pushl $160
80105859:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010585e:	e9 d7 f5 ff ff       	jmp    80104e3a <alltraps>

80105863 <vector161>:
.globl vector161
vector161:
  pushl $0
80105863:	6a 00                	push   $0x0
  pushl $161
80105865:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010586a:	e9 cb f5 ff ff       	jmp    80104e3a <alltraps>

8010586f <vector162>:
.globl vector162
vector162:
  pushl $0
8010586f:	6a 00                	push   $0x0
  pushl $162
80105871:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80105876:	e9 bf f5 ff ff       	jmp    80104e3a <alltraps>

8010587b <vector163>:
.globl vector163
vector163:
  pushl $0
8010587b:	6a 00                	push   $0x0
  pushl $163
8010587d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80105882:	e9 b3 f5 ff ff       	jmp    80104e3a <alltraps>

80105887 <vector164>:
.globl vector164
vector164:
  pushl $0
80105887:	6a 00                	push   $0x0
  pushl $164
80105889:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010588e:	e9 a7 f5 ff ff       	jmp    80104e3a <alltraps>

80105893 <vector165>:
.globl vector165
vector165:
  pushl $0
80105893:	6a 00                	push   $0x0
  pushl $165
80105895:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010589a:	e9 9b f5 ff ff       	jmp    80104e3a <alltraps>

8010589f <vector166>:
.globl vector166
vector166:
  pushl $0
8010589f:	6a 00                	push   $0x0
  pushl $166
801058a1:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
801058a6:	e9 8f f5 ff ff       	jmp    80104e3a <alltraps>

801058ab <vector167>:
.globl vector167
vector167:
  pushl $0
801058ab:	6a 00                	push   $0x0
  pushl $167
801058ad:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
801058b2:	e9 83 f5 ff ff       	jmp    80104e3a <alltraps>

801058b7 <vector168>:
.globl vector168
vector168:
  pushl $0
801058b7:	6a 00                	push   $0x0
  pushl $168
801058b9:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
801058be:	e9 77 f5 ff ff       	jmp    80104e3a <alltraps>

801058c3 <vector169>:
.globl vector169
vector169:
  pushl $0
801058c3:	6a 00                	push   $0x0
  pushl $169
801058c5:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
801058ca:	e9 6b f5 ff ff       	jmp    80104e3a <alltraps>

801058cf <vector170>:
.globl vector170
vector170:
  pushl $0
801058cf:	6a 00                	push   $0x0
  pushl $170
801058d1:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801058d6:	e9 5f f5 ff ff       	jmp    80104e3a <alltraps>

801058db <vector171>:
.globl vector171
vector171:
  pushl $0
801058db:	6a 00                	push   $0x0
  pushl $171
801058dd:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
801058e2:	e9 53 f5 ff ff       	jmp    80104e3a <alltraps>

801058e7 <vector172>:
.globl vector172
vector172:
  pushl $0
801058e7:	6a 00                	push   $0x0
  pushl $172
801058e9:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801058ee:	e9 47 f5 ff ff       	jmp    80104e3a <alltraps>

801058f3 <vector173>:
.globl vector173
vector173:
  pushl $0
801058f3:	6a 00                	push   $0x0
  pushl $173
801058f5:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801058fa:	e9 3b f5 ff ff       	jmp    80104e3a <alltraps>

801058ff <vector174>:
.globl vector174
vector174:
  pushl $0
801058ff:	6a 00                	push   $0x0
  pushl $174
80105901:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80105906:	e9 2f f5 ff ff       	jmp    80104e3a <alltraps>

8010590b <vector175>:
.globl vector175
vector175:
  pushl $0
8010590b:	6a 00                	push   $0x0
  pushl $175
8010590d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80105912:	e9 23 f5 ff ff       	jmp    80104e3a <alltraps>

80105917 <vector176>:
.globl vector176
vector176:
  pushl $0
80105917:	6a 00                	push   $0x0
  pushl $176
80105919:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010591e:	e9 17 f5 ff ff       	jmp    80104e3a <alltraps>

80105923 <vector177>:
.globl vector177
vector177:
  pushl $0
80105923:	6a 00                	push   $0x0
  pushl $177
80105925:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010592a:	e9 0b f5 ff ff       	jmp    80104e3a <alltraps>

8010592f <vector178>:
.globl vector178
vector178:
  pushl $0
8010592f:	6a 00                	push   $0x0
  pushl $178
80105931:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80105936:	e9 ff f4 ff ff       	jmp    80104e3a <alltraps>

8010593b <vector179>:
.globl vector179
vector179:
  pushl $0
8010593b:	6a 00                	push   $0x0
  pushl $179
8010593d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80105942:	e9 f3 f4 ff ff       	jmp    80104e3a <alltraps>

80105947 <vector180>:
.globl vector180
vector180:
  pushl $0
80105947:	6a 00                	push   $0x0
  pushl $180
80105949:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010594e:	e9 e7 f4 ff ff       	jmp    80104e3a <alltraps>

80105953 <vector181>:
.globl vector181
vector181:
  pushl $0
80105953:	6a 00                	push   $0x0
  pushl $181
80105955:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010595a:	e9 db f4 ff ff       	jmp    80104e3a <alltraps>

8010595f <vector182>:
.globl vector182
vector182:
  pushl $0
8010595f:	6a 00                	push   $0x0
  pushl $182
80105961:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80105966:	e9 cf f4 ff ff       	jmp    80104e3a <alltraps>

8010596b <vector183>:
.globl vector183
vector183:
  pushl $0
8010596b:	6a 00                	push   $0x0
  pushl $183
8010596d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80105972:	e9 c3 f4 ff ff       	jmp    80104e3a <alltraps>

80105977 <vector184>:
.globl vector184
vector184:
  pushl $0
80105977:	6a 00                	push   $0x0
  pushl $184
80105979:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010597e:	e9 b7 f4 ff ff       	jmp    80104e3a <alltraps>

80105983 <vector185>:
.globl vector185
vector185:
  pushl $0
80105983:	6a 00                	push   $0x0
  pushl $185
80105985:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010598a:	e9 ab f4 ff ff       	jmp    80104e3a <alltraps>

8010598f <vector186>:
.globl vector186
vector186:
  pushl $0
8010598f:	6a 00                	push   $0x0
  pushl $186
80105991:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80105996:	e9 9f f4 ff ff       	jmp    80104e3a <alltraps>

8010599b <vector187>:
.globl vector187
vector187:
  pushl $0
8010599b:	6a 00                	push   $0x0
  pushl $187
8010599d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
801059a2:	e9 93 f4 ff ff       	jmp    80104e3a <alltraps>

801059a7 <vector188>:
.globl vector188
vector188:
  pushl $0
801059a7:	6a 00                	push   $0x0
  pushl $188
801059a9:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
801059ae:	e9 87 f4 ff ff       	jmp    80104e3a <alltraps>

801059b3 <vector189>:
.globl vector189
vector189:
  pushl $0
801059b3:	6a 00                	push   $0x0
  pushl $189
801059b5:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
801059ba:	e9 7b f4 ff ff       	jmp    80104e3a <alltraps>

801059bf <vector190>:
.globl vector190
vector190:
  pushl $0
801059bf:	6a 00                	push   $0x0
  pushl $190
801059c1:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
801059c6:	e9 6f f4 ff ff       	jmp    80104e3a <alltraps>

801059cb <vector191>:
.globl vector191
vector191:
  pushl $0
801059cb:	6a 00                	push   $0x0
  pushl $191
801059cd:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
801059d2:	e9 63 f4 ff ff       	jmp    80104e3a <alltraps>

801059d7 <vector192>:
.globl vector192
vector192:
  pushl $0
801059d7:	6a 00                	push   $0x0
  pushl $192
801059d9:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
801059de:	e9 57 f4 ff ff       	jmp    80104e3a <alltraps>

801059e3 <vector193>:
.globl vector193
vector193:
  pushl $0
801059e3:	6a 00                	push   $0x0
  pushl $193
801059e5:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
801059ea:	e9 4b f4 ff ff       	jmp    80104e3a <alltraps>

801059ef <vector194>:
.globl vector194
vector194:
  pushl $0
801059ef:	6a 00                	push   $0x0
  pushl $194
801059f1:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801059f6:	e9 3f f4 ff ff       	jmp    80104e3a <alltraps>

801059fb <vector195>:
.globl vector195
vector195:
  pushl $0
801059fb:	6a 00                	push   $0x0
  pushl $195
801059fd:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80105a02:	e9 33 f4 ff ff       	jmp    80104e3a <alltraps>

80105a07 <vector196>:
.globl vector196
vector196:
  pushl $0
80105a07:	6a 00                	push   $0x0
  pushl $196
80105a09:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80105a0e:	e9 27 f4 ff ff       	jmp    80104e3a <alltraps>

80105a13 <vector197>:
.globl vector197
vector197:
  pushl $0
80105a13:	6a 00                	push   $0x0
  pushl $197
80105a15:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80105a1a:	e9 1b f4 ff ff       	jmp    80104e3a <alltraps>

80105a1f <vector198>:
.globl vector198
vector198:
  pushl $0
80105a1f:	6a 00                	push   $0x0
  pushl $198
80105a21:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80105a26:	e9 0f f4 ff ff       	jmp    80104e3a <alltraps>

80105a2b <vector199>:
.globl vector199
vector199:
  pushl $0
80105a2b:	6a 00                	push   $0x0
  pushl $199
80105a2d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80105a32:	e9 03 f4 ff ff       	jmp    80104e3a <alltraps>

80105a37 <vector200>:
.globl vector200
vector200:
  pushl $0
80105a37:	6a 00                	push   $0x0
  pushl $200
80105a39:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80105a3e:	e9 f7 f3 ff ff       	jmp    80104e3a <alltraps>

80105a43 <vector201>:
.globl vector201
vector201:
  pushl $0
80105a43:	6a 00                	push   $0x0
  pushl $201
80105a45:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80105a4a:	e9 eb f3 ff ff       	jmp    80104e3a <alltraps>

80105a4f <vector202>:
.globl vector202
vector202:
  pushl $0
80105a4f:	6a 00                	push   $0x0
  pushl $202
80105a51:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80105a56:	e9 df f3 ff ff       	jmp    80104e3a <alltraps>

80105a5b <vector203>:
.globl vector203
vector203:
  pushl $0
80105a5b:	6a 00                	push   $0x0
  pushl $203
80105a5d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80105a62:	e9 d3 f3 ff ff       	jmp    80104e3a <alltraps>

80105a67 <vector204>:
.globl vector204
vector204:
  pushl $0
80105a67:	6a 00                	push   $0x0
  pushl $204
80105a69:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80105a6e:	e9 c7 f3 ff ff       	jmp    80104e3a <alltraps>

80105a73 <vector205>:
.globl vector205
vector205:
  pushl $0
80105a73:	6a 00                	push   $0x0
  pushl $205
80105a75:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80105a7a:	e9 bb f3 ff ff       	jmp    80104e3a <alltraps>

80105a7f <vector206>:
.globl vector206
vector206:
  pushl $0
80105a7f:	6a 00                	push   $0x0
  pushl $206
80105a81:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80105a86:	e9 af f3 ff ff       	jmp    80104e3a <alltraps>

80105a8b <vector207>:
.globl vector207
vector207:
  pushl $0
80105a8b:	6a 00                	push   $0x0
  pushl $207
80105a8d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80105a92:	e9 a3 f3 ff ff       	jmp    80104e3a <alltraps>

80105a97 <vector208>:
.globl vector208
vector208:
  pushl $0
80105a97:	6a 00                	push   $0x0
  pushl $208
80105a99:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80105a9e:	e9 97 f3 ff ff       	jmp    80104e3a <alltraps>

80105aa3 <vector209>:
.globl vector209
vector209:
  pushl $0
80105aa3:	6a 00                	push   $0x0
  pushl $209
80105aa5:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80105aaa:	e9 8b f3 ff ff       	jmp    80104e3a <alltraps>

80105aaf <vector210>:
.globl vector210
vector210:
  pushl $0
80105aaf:	6a 00                	push   $0x0
  pushl $210
80105ab1:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80105ab6:	e9 7f f3 ff ff       	jmp    80104e3a <alltraps>

80105abb <vector211>:
.globl vector211
vector211:
  pushl $0
80105abb:	6a 00                	push   $0x0
  pushl $211
80105abd:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80105ac2:	e9 73 f3 ff ff       	jmp    80104e3a <alltraps>

80105ac7 <vector212>:
.globl vector212
vector212:
  pushl $0
80105ac7:	6a 00                	push   $0x0
  pushl $212
80105ac9:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80105ace:	e9 67 f3 ff ff       	jmp    80104e3a <alltraps>

80105ad3 <vector213>:
.globl vector213
vector213:
  pushl $0
80105ad3:	6a 00                	push   $0x0
  pushl $213
80105ad5:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80105ada:	e9 5b f3 ff ff       	jmp    80104e3a <alltraps>

80105adf <vector214>:
.globl vector214
vector214:
  pushl $0
80105adf:	6a 00                	push   $0x0
  pushl $214
80105ae1:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80105ae6:	e9 4f f3 ff ff       	jmp    80104e3a <alltraps>

80105aeb <vector215>:
.globl vector215
vector215:
  pushl $0
80105aeb:	6a 00                	push   $0x0
  pushl $215
80105aed:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80105af2:	e9 43 f3 ff ff       	jmp    80104e3a <alltraps>

80105af7 <vector216>:
.globl vector216
vector216:
  pushl $0
80105af7:	6a 00                	push   $0x0
  pushl $216
80105af9:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80105afe:	e9 37 f3 ff ff       	jmp    80104e3a <alltraps>

80105b03 <vector217>:
.globl vector217
vector217:
  pushl $0
80105b03:	6a 00                	push   $0x0
  pushl $217
80105b05:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80105b0a:	e9 2b f3 ff ff       	jmp    80104e3a <alltraps>

80105b0f <vector218>:
.globl vector218
vector218:
  pushl $0
80105b0f:	6a 00                	push   $0x0
  pushl $218
80105b11:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80105b16:	e9 1f f3 ff ff       	jmp    80104e3a <alltraps>

80105b1b <vector219>:
.globl vector219
vector219:
  pushl $0
80105b1b:	6a 00                	push   $0x0
  pushl $219
80105b1d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80105b22:	e9 13 f3 ff ff       	jmp    80104e3a <alltraps>

80105b27 <vector220>:
.globl vector220
vector220:
  pushl $0
80105b27:	6a 00                	push   $0x0
  pushl $220
80105b29:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80105b2e:	e9 07 f3 ff ff       	jmp    80104e3a <alltraps>

80105b33 <vector221>:
.globl vector221
vector221:
  pushl $0
80105b33:	6a 00                	push   $0x0
  pushl $221
80105b35:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80105b3a:	e9 fb f2 ff ff       	jmp    80104e3a <alltraps>

80105b3f <vector222>:
.globl vector222
vector222:
  pushl $0
80105b3f:	6a 00                	push   $0x0
  pushl $222
80105b41:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80105b46:	e9 ef f2 ff ff       	jmp    80104e3a <alltraps>

80105b4b <vector223>:
.globl vector223
vector223:
  pushl $0
80105b4b:	6a 00                	push   $0x0
  pushl $223
80105b4d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80105b52:	e9 e3 f2 ff ff       	jmp    80104e3a <alltraps>

80105b57 <vector224>:
.globl vector224
vector224:
  pushl $0
80105b57:	6a 00                	push   $0x0
  pushl $224
80105b59:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80105b5e:	e9 d7 f2 ff ff       	jmp    80104e3a <alltraps>

80105b63 <vector225>:
.globl vector225
vector225:
  pushl $0
80105b63:	6a 00                	push   $0x0
  pushl $225
80105b65:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80105b6a:	e9 cb f2 ff ff       	jmp    80104e3a <alltraps>

80105b6f <vector226>:
.globl vector226
vector226:
  pushl $0
80105b6f:	6a 00                	push   $0x0
  pushl $226
80105b71:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80105b76:	e9 bf f2 ff ff       	jmp    80104e3a <alltraps>

80105b7b <vector227>:
.globl vector227
vector227:
  pushl $0
80105b7b:	6a 00                	push   $0x0
  pushl $227
80105b7d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80105b82:	e9 b3 f2 ff ff       	jmp    80104e3a <alltraps>

80105b87 <vector228>:
.globl vector228
vector228:
  pushl $0
80105b87:	6a 00                	push   $0x0
  pushl $228
80105b89:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80105b8e:	e9 a7 f2 ff ff       	jmp    80104e3a <alltraps>

80105b93 <vector229>:
.globl vector229
vector229:
  pushl $0
80105b93:	6a 00                	push   $0x0
  pushl $229
80105b95:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80105b9a:	e9 9b f2 ff ff       	jmp    80104e3a <alltraps>

80105b9f <vector230>:
.globl vector230
vector230:
  pushl $0
80105b9f:	6a 00                	push   $0x0
  pushl $230
80105ba1:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80105ba6:	e9 8f f2 ff ff       	jmp    80104e3a <alltraps>

80105bab <vector231>:
.globl vector231
vector231:
  pushl $0
80105bab:	6a 00                	push   $0x0
  pushl $231
80105bad:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80105bb2:	e9 83 f2 ff ff       	jmp    80104e3a <alltraps>

80105bb7 <vector232>:
.globl vector232
vector232:
  pushl $0
80105bb7:	6a 00                	push   $0x0
  pushl $232
80105bb9:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80105bbe:	e9 77 f2 ff ff       	jmp    80104e3a <alltraps>

80105bc3 <vector233>:
.globl vector233
vector233:
  pushl $0
80105bc3:	6a 00                	push   $0x0
  pushl $233
80105bc5:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80105bca:	e9 6b f2 ff ff       	jmp    80104e3a <alltraps>

80105bcf <vector234>:
.globl vector234
vector234:
  pushl $0
80105bcf:	6a 00                	push   $0x0
  pushl $234
80105bd1:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80105bd6:	e9 5f f2 ff ff       	jmp    80104e3a <alltraps>

80105bdb <vector235>:
.globl vector235
vector235:
  pushl $0
80105bdb:	6a 00                	push   $0x0
  pushl $235
80105bdd:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80105be2:	e9 53 f2 ff ff       	jmp    80104e3a <alltraps>

80105be7 <vector236>:
.globl vector236
vector236:
  pushl $0
80105be7:	6a 00                	push   $0x0
  pushl $236
80105be9:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80105bee:	e9 47 f2 ff ff       	jmp    80104e3a <alltraps>

80105bf3 <vector237>:
.globl vector237
vector237:
  pushl $0
80105bf3:	6a 00                	push   $0x0
  pushl $237
80105bf5:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80105bfa:	e9 3b f2 ff ff       	jmp    80104e3a <alltraps>

80105bff <vector238>:
.globl vector238
vector238:
  pushl $0
80105bff:	6a 00                	push   $0x0
  pushl $238
80105c01:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80105c06:	e9 2f f2 ff ff       	jmp    80104e3a <alltraps>

80105c0b <vector239>:
.globl vector239
vector239:
  pushl $0
80105c0b:	6a 00                	push   $0x0
  pushl $239
80105c0d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80105c12:	e9 23 f2 ff ff       	jmp    80104e3a <alltraps>

80105c17 <vector240>:
.globl vector240
vector240:
  pushl $0
80105c17:	6a 00                	push   $0x0
  pushl $240
80105c19:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80105c1e:	e9 17 f2 ff ff       	jmp    80104e3a <alltraps>

80105c23 <vector241>:
.globl vector241
vector241:
  pushl $0
80105c23:	6a 00                	push   $0x0
  pushl $241
80105c25:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80105c2a:	e9 0b f2 ff ff       	jmp    80104e3a <alltraps>

80105c2f <vector242>:
.globl vector242
vector242:
  pushl $0
80105c2f:	6a 00                	push   $0x0
  pushl $242
80105c31:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80105c36:	e9 ff f1 ff ff       	jmp    80104e3a <alltraps>

80105c3b <vector243>:
.globl vector243
vector243:
  pushl $0
80105c3b:	6a 00                	push   $0x0
  pushl $243
80105c3d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80105c42:	e9 f3 f1 ff ff       	jmp    80104e3a <alltraps>

80105c47 <vector244>:
.globl vector244
vector244:
  pushl $0
80105c47:	6a 00                	push   $0x0
  pushl $244
80105c49:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80105c4e:	e9 e7 f1 ff ff       	jmp    80104e3a <alltraps>

80105c53 <vector245>:
.globl vector245
vector245:
  pushl $0
80105c53:	6a 00                	push   $0x0
  pushl $245
80105c55:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80105c5a:	e9 db f1 ff ff       	jmp    80104e3a <alltraps>

80105c5f <vector246>:
.globl vector246
vector246:
  pushl $0
80105c5f:	6a 00                	push   $0x0
  pushl $246
80105c61:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80105c66:	e9 cf f1 ff ff       	jmp    80104e3a <alltraps>

80105c6b <vector247>:
.globl vector247
vector247:
  pushl $0
80105c6b:	6a 00                	push   $0x0
  pushl $247
80105c6d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80105c72:	e9 c3 f1 ff ff       	jmp    80104e3a <alltraps>

80105c77 <vector248>:
.globl vector248
vector248:
  pushl $0
80105c77:	6a 00                	push   $0x0
  pushl $248
80105c79:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80105c7e:	e9 b7 f1 ff ff       	jmp    80104e3a <alltraps>

80105c83 <vector249>:
.globl vector249
vector249:
  pushl $0
80105c83:	6a 00                	push   $0x0
  pushl $249
80105c85:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80105c8a:	e9 ab f1 ff ff       	jmp    80104e3a <alltraps>

80105c8f <vector250>:
.globl vector250
vector250:
  pushl $0
80105c8f:	6a 00                	push   $0x0
  pushl $250
80105c91:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80105c96:	e9 9f f1 ff ff       	jmp    80104e3a <alltraps>

80105c9b <vector251>:
.globl vector251
vector251:
  pushl $0
80105c9b:	6a 00                	push   $0x0
  pushl $251
80105c9d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80105ca2:	e9 93 f1 ff ff       	jmp    80104e3a <alltraps>

80105ca7 <vector252>:
.globl vector252
vector252:
  pushl $0
80105ca7:	6a 00                	push   $0x0
  pushl $252
80105ca9:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80105cae:	e9 87 f1 ff ff       	jmp    80104e3a <alltraps>

80105cb3 <vector253>:
.globl vector253
vector253:
  pushl $0
80105cb3:	6a 00                	push   $0x0
  pushl $253
80105cb5:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80105cba:	e9 7b f1 ff ff       	jmp    80104e3a <alltraps>

80105cbf <vector254>:
.globl vector254
vector254:
  pushl $0
80105cbf:	6a 00                	push   $0x0
  pushl $254
80105cc1:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80105cc6:	e9 6f f1 ff ff       	jmp    80104e3a <alltraps>

80105ccb <vector255>:
.globl vector255
vector255:
  pushl $0
80105ccb:	6a 00                	push   $0x0
  pushl $255
80105ccd:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80105cd2:	e9 63 f1 ff ff       	jmp    80104e3a <alltraps>
80105cd7:	90                   	nop

80105cd8 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80105cd8:	55                   	push   %ebp
80105cd9:	89 e5                	mov    %esp,%ebp
80105cdb:	57                   	push   %edi
80105cdc:	56                   	push   %esi
80105cdd:	53                   	push   %ebx
80105cde:	83 ec 0c             	sub    $0xc,%esp
80105ce1:	89 d3                	mov    %edx,%ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80105ce3:	c1 ea 16             	shr    $0x16,%edx
80105ce6:	8d 3c 90             	lea    (%eax,%edx,4),%edi
  if(*pde & PTE_P){
80105ce9:	8b 07                	mov    (%edi),%eax
80105ceb:	a8 01                	test   $0x1,%al
80105ced:	74 21                	je     80105d10 <walkpgdir+0x38>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80105cef:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80105cf4:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80105cfa:	c1 eb 0a             	shr    $0xa,%ebx
80105cfd:	81 e3 fc 0f 00 00    	and    $0xffc,%ebx
80105d03:	8d 04 1e             	lea    (%esi,%ebx,1),%eax
}
80105d06:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d09:	5b                   	pop    %ebx
80105d0a:	5e                   	pop    %esi
80105d0b:	5f                   	pop    %edi
80105d0c:	5d                   	pop    %ebp
80105d0d:	c3                   	ret    
80105d0e:	66 90                	xchg   %ax,%ax

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80105d10:	85 c9                	test   %ecx,%ecx
80105d12:	74 2c                	je     80105d40 <walkpgdir+0x68>
80105d14:	e8 67 c4 ff ff       	call   80102180 <kalloc>
80105d19:	89 c6                	mov    %eax,%esi
80105d1b:	85 c0                	test   %eax,%eax
80105d1d:	74 21                	je     80105d40 <walkpgdir+0x68>
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80105d1f:	50                   	push   %eax
80105d20:	68 00 10 00 00       	push   $0x1000
80105d25:	6a 00                	push   $0x0
80105d27:	56                   	push   %esi
80105d28:	e8 1f e1 ff ff       	call   80103e4c <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80105d2d:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80105d33:	83 c8 07             	or     $0x7,%eax
80105d36:	89 07                	mov    %eax,(%edi)
80105d38:	83 c4 10             	add    $0x10,%esp
80105d3b:	eb bd                	jmp    80105cfa <walkpgdir+0x22>
80105d3d:	8d 76 00             	lea    0x0(%esi),%esi
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
80105d40:	31 c0                	xor    %eax,%eax
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80105d42:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d45:	5b                   	pop    %ebx
80105d46:	5e                   	pop    %esi
80105d47:	5f                   	pop    %edi
80105d48:	5d                   	pop    %ebp
80105d49:	c3                   	ret    
80105d4a:	66 90                	xchg   %ax,%ax

80105d4c <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80105d4c:	55                   	push   %ebp
80105d4d:	89 e5                	mov    %esp,%ebp
80105d4f:	57                   	push   %edi
80105d50:	56                   	push   %esi
80105d51:	53                   	push   %ebx
80105d52:	83 ec 1c             	sub    $0x1c,%esp
80105d55:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80105d58:	89 d3                	mov    %edx,%ebx
80105d5a:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80105d60:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80105d64:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80105d69:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105d6c:	8b 7d 08             	mov    0x8(%ebp),%edi
80105d6f:	29 df                	sub    %ebx,%edi
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80105d71:	8b 45 0c             	mov    0xc(%ebp),%eax
80105d74:	83 c8 01             	or     $0x1,%eax
80105d77:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105d7a:	eb 15                	jmp    80105d91 <mappages+0x45>
  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80105d7c:	f6 00 01             	testb  $0x1,(%eax)
80105d7f:	75 3d                	jne    80105dbe <mappages+0x72>
      panic("remap");
    *pte = pa | perm | PTE_P;
80105d81:	0b 75 dc             	or     -0x24(%ebp),%esi
80105d84:	89 30                	mov    %esi,(%eax)
    if(a == last)
80105d86:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
80105d89:	74 29                	je     80105db4 <mappages+0x68>
      break;
    a += PGSIZE;
80105d8b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80105d91:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80105d94:	b9 01 00 00 00       	mov    $0x1,%ecx
80105d99:	89 da                	mov    %ebx,%edx
80105d9b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105d9e:	e8 35 ff ff ff       	call   80105cd8 <walkpgdir>
80105da3:	85 c0                	test   %eax,%eax
80105da5:	75 d5                	jne    80105d7c <mappages+0x30>
      return -1;
80105da7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
80105dac:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105daf:	5b                   	pop    %ebx
80105db0:	5e                   	pop    %esi
80105db1:	5f                   	pop    %edi
80105db2:	5d                   	pop    %ebp
80105db3:	c3                   	ret    
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80105db4:	31 c0                	xor    %eax,%eax
}
80105db6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105db9:	5b                   	pop    %ebx
80105dba:	5e                   	pop    %esi
80105dbb:	5f                   	pop    %edi
80105dbc:	5d                   	pop    %ebp
80105dbd:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
80105dbe:	83 ec 0c             	sub    $0xc,%esp
80105dc1:	68 28 6e 10 80       	push   $0x80106e28
80105dc6:	e8 6d a5 ff ff       	call   80100338 <panic>
80105dcb:	90                   	nop

80105dcc <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80105dcc:	55                   	push   %ebp
80105dcd:	89 e5                	mov    %esp,%ebp
80105dcf:	57                   	push   %edi
80105dd0:	56                   	push   %esi
80105dd1:	53                   	push   %ebx
80105dd2:	83 ec 1c             	sub    $0x1c,%esp
80105dd5:	89 c7                	mov    %eax,%edi
80105dd7:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80105dda:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
80105de0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80105de6:	39 d3                	cmp    %edx,%ebx
80105de8:	73 62                	jae    80105e4c <deallocuvm.part.0+0x80>
80105dea:	89 d6                	mov    %edx,%esi
80105dec:	eb 39                	jmp    80105e27 <deallocuvm.part.0+0x5b>
80105dee:	66 90                	xchg   %ax,%ax
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80105df0:	8b 10                	mov    (%eax),%edx
80105df2:	f6 c2 01             	test   $0x1,%dl
80105df5:	74 26                	je     80105e1d <deallocuvm.part.0+0x51>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80105df7:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80105dfd:	74 58                	je     80105e57 <deallocuvm.part.0+0x8b>
80105dff:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80105e02:	83 ec 0c             	sub    $0xc,%esp
80105e05:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80105e0b:	52                   	push   %edx
80105e0c:	e8 e3 c1 ff ff       	call   80101ff4 <kfree>
      *pte = 0;
80105e11:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105e14:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105e1a:	83 c4 10             	add    $0x10,%esp

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80105e1d:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80105e23:	39 f3                	cmp    %esi,%ebx
80105e25:	73 25                	jae    80105e4c <deallocuvm.part.0+0x80>
    pte = walkpgdir(pgdir, (char*)a, 0);
80105e27:	31 c9                	xor    %ecx,%ecx
80105e29:	89 da                	mov    %ebx,%edx
80105e2b:	89 f8                	mov    %edi,%eax
80105e2d:	e8 a6 fe ff ff       	call   80105cd8 <walkpgdir>
    if(!pte)
80105e32:	85 c0                	test   %eax,%eax
80105e34:	75 ba                	jne    80105df0 <deallocuvm.part.0+0x24>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80105e36:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80105e3c:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80105e42:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80105e48:	39 f3                	cmp    %esi,%ebx
80105e4a:	72 db                	jb     80105e27 <deallocuvm.part.0+0x5b>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80105e4c:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105e4f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e52:	5b                   	pop    %ebx
80105e53:	5e                   	pop    %esi
80105e54:	5f                   	pop    %edi
80105e55:	5d                   	pop    %ebp
80105e56:	c3                   	ret    
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
80105e57:	83 ec 0c             	sub    $0xc,%esp
80105e5a:	68 c6 67 10 80       	push   $0x801067c6
80105e5f:	e8 d4 a4 ff ff       	call   80100338 <panic>

80105e64 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80105e64:	55                   	push   %ebp
80105e65:	89 e5                	mov    %esp,%ebp
80105e67:	83 ec 18             	sub    $0x18,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
80105e6a:	e8 1d d4 ff ff       	call   8010328c <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80105e6f:	8d 14 80             	lea    (%eax,%eax,4),%edx
80105e72:	01 d2                	add    %edx,%edx
80105e74:	01 d0                	add    %edx,%eax
80105e76:	c1 e0 04             	shl    $0x4,%eax
80105e79:	66 c7 80 f8 17 11 80 	movw   $0xffff,-0x7feee808(%eax)
80105e80:	ff ff 
80105e82:	66 c7 80 fa 17 11 80 	movw   $0x0,-0x7feee806(%eax)
80105e89:	00 00 
80105e8b:	c6 80 fc 17 11 80 00 	movb   $0x0,-0x7feee804(%eax)
80105e92:	c6 80 fd 17 11 80 9a 	movb   $0x9a,-0x7feee803(%eax)
80105e99:	c6 80 fe 17 11 80 cf 	movb   $0xcf,-0x7feee802(%eax)
80105ea0:	c6 80 ff 17 11 80 00 	movb   $0x0,-0x7feee801(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80105ea7:	66 c7 80 00 18 11 80 	movw   $0xffff,-0x7feee800(%eax)
80105eae:	ff ff 
80105eb0:	66 c7 80 02 18 11 80 	movw   $0x0,-0x7feee7fe(%eax)
80105eb7:	00 00 
80105eb9:	c6 80 04 18 11 80 00 	movb   $0x0,-0x7feee7fc(%eax)
80105ec0:	c6 80 05 18 11 80 92 	movb   $0x92,-0x7feee7fb(%eax)
80105ec7:	c6 80 06 18 11 80 cf 	movb   $0xcf,-0x7feee7fa(%eax)
80105ece:	c6 80 07 18 11 80 00 	movb   $0x0,-0x7feee7f9(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80105ed5:	66 c7 80 08 18 11 80 	movw   $0xffff,-0x7feee7f8(%eax)
80105edc:	ff ff 
80105ede:	66 c7 80 0a 18 11 80 	movw   $0x0,-0x7feee7f6(%eax)
80105ee5:	00 00 
80105ee7:	c6 80 0c 18 11 80 00 	movb   $0x0,-0x7feee7f4(%eax)
80105eee:	c6 80 0d 18 11 80 fa 	movb   $0xfa,-0x7feee7f3(%eax)
80105ef5:	c6 80 0e 18 11 80 cf 	movb   $0xcf,-0x7feee7f2(%eax)
80105efc:	c6 80 0f 18 11 80 00 	movb   $0x0,-0x7feee7f1(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80105f03:	66 c7 80 10 18 11 80 	movw   $0xffff,-0x7feee7f0(%eax)
80105f0a:	ff ff 
80105f0c:	66 c7 80 12 18 11 80 	movw   $0x0,-0x7feee7ee(%eax)
80105f13:	00 00 
80105f15:	c6 80 14 18 11 80 00 	movb   $0x0,-0x7feee7ec(%eax)
80105f1c:	c6 80 15 18 11 80 f2 	movb   $0xf2,-0x7feee7eb(%eax)
80105f23:	c6 80 16 18 11 80 cf 	movb   $0xcf,-0x7feee7ea(%eax)
80105f2a:	c6 80 17 18 11 80 00 	movb   $0x0,-0x7feee7e9(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
80105f31:	05 f0 17 11 80       	add    $0x801117f0,%eax
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80105f36:	66 c7 45 f2 2f 00    	movw   $0x2f,-0xe(%ebp)
  pd[1] = (uint)p;
80105f3c:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80105f40:	c1 e8 10             	shr    $0x10,%eax
80105f43:	66 89 45 f6          	mov    %ax,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80105f47:	8d 45 f2             	lea    -0xe(%ebp),%eax
80105f4a:	0f 01 10             	lgdtl  (%eax)
}
80105f4d:	c9                   	leave  
80105f4e:	c3                   	ret    
80105f4f:	90                   	nop

80105f50 <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80105f50:	55                   	push   %ebp
80105f51:	89 e5                	mov    %esp,%ebp
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80105f53:	a1 a4 44 11 80       	mov    0x801144a4,%eax
80105f58:	05 00 00 00 80       	add    $0x80000000,%eax
80105f5d:	0f 22 d8             	mov    %eax,%cr3
  lcr3(V2P(kpgdir));   // switch to the kernel page table
}
80105f60:	5d                   	pop    %ebp
80105f61:	c3                   	ret    
80105f62:	66 90                	xchg   %ax,%ax

80105f64 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80105f64:	55                   	push   %ebp
80105f65:	89 e5                	mov    %esp,%ebp
80105f67:	57                   	push   %edi
80105f68:	56                   	push   %esi
80105f69:	53                   	push   %ebx
80105f6a:	83 ec 1c             	sub    $0x1c,%esp
80105f6d:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80105f70:	85 f6                	test   %esi,%esi
80105f72:	0f 84 c4 00 00 00    	je     8010603c <switchuvm+0xd8>
    panic("switchuvm: no process");
  if(p->kstack == 0)
80105f78:	8b 56 08             	mov    0x8(%esi),%edx
80105f7b:	85 d2                	test   %edx,%edx
80105f7d:	0f 84 d3 00 00 00    	je     80106056 <switchuvm+0xf2>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
80105f83:	8b 46 04             	mov    0x4(%esi),%eax
80105f86:	85 c0                	test   %eax,%eax
80105f88:	0f 84 bb 00 00 00    	je     80106049 <switchuvm+0xe5>
    panic("switchuvm: no pgdir");

  pushcli();
80105f8e:	e8 01 dd ff ff       	call   80103c94 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80105f93:	e8 7c d2 ff ff       	call   80103214 <mycpu>
80105f98:	89 c3                	mov    %eax,%ebx
80105f9a:	e8 75 d2 ff ff       	call   80103214 <mycpu>
80105f9f:	89 c7                	mov    %eax,%edi
80105fa1:	e8 6e d2 ff ff       	call   80103214 <mycpu>
80105fa6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80105fa9:	e8 66 d2 ff ff       	call   80103214 <mycpu>
80105fae:	66 c7 83 98 00 00 00 	movw   $0x67,0x98(%ebx)
80105fb5:	67 00 
80105fb7:	83 c7 08             	add    $0x8,%edi
80105fba:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80105fc1:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105fc4:	83 c1 08             	add    $0x8,%ecx
80105fc7:	c1 e9 10             	shr    $0x10,%ecx
80105fca:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80105fd0:	c6 83 9d 00 00 00 99 	movb   $0x99,0x9d(%ebx)
80105fd7:	c6 83 9e 00 00 00 40 	movb   $0x40,0x9e(%ebx)
80105fde:	83 c0 08             	add    $0x8,%eax
80105fe1:	c1 e8 18             	shr    $0x18,%eax
80105fe4:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
80105fea:	e8 25 d2 ff ff       	call   80103214 <mycpu>
80105fef:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80105ff6:	e8 19 d2 ff ff       	call   80103214 <mycpu>
80105ffb:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106001:	e8 0e d2 ff ff       	call   80103214 <mycpu>
80106006:	8b 56 08             	mov    0x8(%esi),%edx
80106009:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
8010600f:	89 48 0c             	mov    %ecx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106012:	e8 fd d1 ff ff       	call   80103214 <mycpu>
80106017:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
8010601d:	b8 28 00 00 00       	mov    $0x28,%eax
80106022:	0f 00 d8             	ltr    %ax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106025:	8b 46 04             	mov    0x4(%esi),%eax
80106028:	05 00 00 00 80       	add    $0x80000000,%eax
8010602d:	0f 22 d8             	mov    %eax,%cr3
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
}
80106030:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106033:	5b                   	pop    %ebx
80106034:	5e                   	pop    %esi
80106035:	5f                   	pop    %edi
80106036:	5d                   	pop    %ebp
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
80106037:	e9 90 dc ff ff       	jmp    80103ccc <popcli>
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
8010603c:	83 ec 0c             	sub    $0xc,%esp
8010603f:	68 2e 6e 10 80       	push   $0x80106e2e
80106044:	e8 ef a2 ff ff       	call   80100338 <panic>
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
80106049:	83 ec 0c             	sub    $0xc,%esp
8010604c:	68 59 6e 10 80       	push   $0x80106e59
80106051:	e8 e2 a2 ff ff       	call   80100338 <panic>
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
80106056:	83 ec 0c             	sub    $0xc,%esp
80106059:	68 44 6e 10 80       	push   $0x80106e44
8010605e:	e8 d5 a2 ff ff       	call   80100338 <panic>
80106063:	90                   	nop

80106064 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106064:	55                   	push   %ebp
80106065:	89 e5                	mov    %esp,%ebp
80106067:	57                   	push   %edi
80106068:	56                   	push   %esi
80106069:	53                   	push   %ebx
8010606a:	83 ec 1c             	sub    $0x1c,%esp
8010606d:	8b 45 08             	mov    0x8(%ebp),%eax
80106070:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106073:	8b 7d 0c             	mov    0xc(%ebp),%edi
80106076:	8b 75 10             	mov    0x10(%ebp),%esi
  char *mem;

  if(sz >= PGSIZE)
80106079:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010607f:	77 47                	ja     801060c8 <inituvm+0x64>
    panic("inituvm: more than a page");
  mem = kalloc();
80106081:	e8 fa c0 ff ff       	call   80102180 <kalloc>
80106086:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106088:	50                   	push   %eax
80106089:	68 00 10 00 00       	push   $0x1000
8010608e:	6a 00                	push   $0x0
80106090:	53                   	push   %ebx
80106091:	e8 b6 dd ff ff       	call   80103e4c <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106096:	5a                   	pop    %edx
80106097:	59                   	pop    %ecx
80106098:	6a 06                	push   $0x6
8010609a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801060a0:	50                   	push   %eax
801060a1:	b9 00 10 00 00       	mov    $0x1000,%ecx
801060a6:	31 d2                	xor    %edx,%edx
801060a8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801060ab:	e8 9c fc ff ff       	call   80105d4c <mappages>
  memmove(mem, init, sz);
801060b0:	83 c4 10             	add    $0x10,%esp
801060b3:	89 75 10             	mov    %esi,0x10(%ebp)
801060b6:	89 7d 0c             	mov    %edi,0xc(%ebp)
801060b9:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801060bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801060bf:	5b                   	pop    %ebx
801060c0:	5e                   	pop    %esi
801060c1:	5f                   	pop    %edi
801060c2:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
801060c3:	e9 18 de ff ff       	jmp    80103ee0 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
801060c8:	83 ec 0c             	sub    $0xc,%esp
801060cb:	68 6d 6e 10 80       	push   $0x80106e6d
801060d0:	e8 63 a2 ff ff       	call   80100338 <panic>
801060d5:	8d 76 00             	lea    0x0(%esi),%esi

801060d8 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
801060d8:	55                   	push   %ebp
801060d9:	89 e5                	mov    %esp,%ebp
801060db:	57                   	push   %edi
801060dc:	56                   	push   %esi
801060dd:	53                   	push   %ebx
801060de:	83 ec 0c             	sub    $0xc,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
801060e1:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
801060e8:	0f 85 8c 00 00 00    	jne    8010617a <loaduvm+0xa2>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
801060ee:	8b 45 18             	mov    0x18(%ebp),%eax
801060f1:	85 c0                	test   %eax,%eax
801060f3:	74 5f                	je     80106154 <loaduvm+0x7c>
801060f5:	31 db                	xor    %ebx,%ebx
801060f7:	8b 75 18             	mov    0x18(%ebp),%esi
801060fa:	eb 2f                	jmp    8010612b <loaduvm+0x53>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
801060fc:	89 f7                	mov    %esi,%edi
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
801060fe:	57                   	push   %edi
801060ff:	8b 4d 14             	mov    0x14(%ebp),%ecx
80106102:	01 d9                	add    %ebx,%ecx
80106104:	51                   	push   %ecx
80106105:	05 00 00 00 80       	add    $0x80000000,%eax
8010610a:	50                   	push   %eax
8010610b:	ff 75 10             	pushl  0x10(%ebp)
8010610e:	e8 39 b6 ff ff       	call   8010174c <readi>
80106113:	83 c4 10             	add    $0x10,%esp
80106116:	39 c7                	cmp    %eax,%edi
80106118:	75 46                	jne    80106160 <loaduvm+0x88>
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
8010611a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106120:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106126:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106129:	76 29                	jbe    80106154 <loaduvm+0x7c>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
8010612b:	8b 55 0c             	mov    0xc(%ebp),%edx
8010612e:	01 da                	add    %ebx,%edx
80106130:	31 c9                	xor    %ecx,%ecx
80106132:	8b 45 08             	mov    0x8(%ebp),%eax
80106135:	e8 9e fb ff ff       	call   80105cd8 <walkpgdir>
8010613a:	85 c0                	test   %eax,%eax
8010613c:	74 2f                	je     8010616d <loaduvm+0x95>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
8010613e:	8b 00                	mov    (%eax),%eax
80106140:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106145:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010614b:	76 af                	jbe    801060fc <loaduvm+0x24>
      n = sz - i;
    else
      n = PGSIZE;
8010614d:	bf 00 10 00 00       	mov    $0x1000,%edi
80106152:	eb aa                	jmp    801060fe <loaduvm+0x26>
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80106154:	31 c0                	xor    %eax,%eax
}
80106156:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106159:	5b                   	pop    %ebx
8010615a:	5e                   	pop    %esi
8010615b:	5f                   	pop    %edi
8010615c:	5d                   	pop    %ebp
8010615d:	c3                   	ret    
8010615e:	66 90                	xchg   %ax,%ax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
80106160:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
80106165:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106168:	5b                   	pop    %ebx
80106169:	5e                   	pop    %esi
8010616a:	5f                   	pop    %edi
8010616b:	5d                   	pop    %ebp
8010616c:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
8010616d:	83 ec 0c             	sub    $0xc,%esp
80106170:	68 87 6e 10 80       	push   $0x80106e87
80106175:	e8 be a1 ff ff       	call   80100338 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
8010617a:	83 ec 0c             	sub    $0xc,%esp
8010617d:	68 28 6f 10 80       	push   $0x80106f28
80106182:	e8 b1 a1 ff ff       	call   80100338 <panic>
80106187:	90                   	nop

80106188 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106188:	55                   	push   %ebp
80106189:	89 e5                	mov    %esp,%ebp
8010618b:	57                   	push   %edi
8010618c:	56                   	push   %esi
8010618d:	53                   	push   %ebx
8010618e:	83 ec 0c             	sub    $0xc,%esp
80106191:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80106194:	85 ff                	test   %edi,%edi
80106196:	0f 88 c2 00 00 00    	js     8010625e <allocuvm+0xd6>
    return 0;
  if(newsz < oldsz)
    return oldsz;
8010619c:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
8010619f:	3b 7d 0c             	cmp    0xc(%ebp),%edi
801061a2:	0f 82 80 00 00 00    	jb     80106228 <allocuvm+0xa0>
    return oldsz;

  a = PGROUNDUP(oldsz);
801061a8:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801061ae:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
801061b4:	39 df                	cmp    %ebx,%edi
801061b6:	77 41                	ja     801061f9 <allocuvm+0x71>
801061b8:	e9 ab 00 00 00       	jmp    80106268 <allocuvm+0xe0>
801061bd:	8d 76 00             	lea    0x0(%esi),%esi
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
801061c0:	50                   	push   %eax
801061c1:	68 00 10 00 00       	push   $0x1000
801061c6:	6a 00                	push   $0x0
801061c8:	56                   	push   %esi
801061c9:	e8 7e dc ff ff       	call   80103e4c <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801061ce:	5a                   	pop    %edx
801061cf:	59                   	pop    %ecx
801061d0:	6a 06                	push   $0x6
801061d2:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801061d8:	50                   	push   %eax
801061d9:	b9 00 10 00 00       	mov    $0x1000,%ecx
801061de:	89 da                	mov    %ebx,%edx
801061e0:	8b 45 08             	mov    0x8(%ebp),%eax
801061e3:	e8 64 fb ff ff       	call   80105d4c <mappages>
801061e8:	83 c4 10             	add    $0x10,%esp
801061eb:	85 c0                	test   %eax,%eax
801061ed:	78 41                	js     80106230 <allocuvm+0xa8>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
801061ef:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801061f5:	39 df                	cmp    %ebx,%edi
801061f7:	76 6f                	jbe    80106268 <allocuvm+0xe0>
    mem = kalloc();
801061f9:	e8 82 bf ff ff       	call   80102180 <kalloc>
801061fe:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106200:	85 c0                	test   %eax,%eax
80106202:	75 bc                	jne    801061c0 <allocuvm+0x38>
      cprintf("allocuvm out of memory\n");
80106204:	83 ec 0c             	sub    $0xc,%esp
80106207:	68 a5 6e 10 80       	push   $0x80106ea5
8010620c:	e8 e7 a3 ff ff       	call   801005f8 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106211:	83 c4 10             	add    $0x10,%esp
80106214:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106217:	76 45                	jbe    8010625e <allocuvm+0xd6>
80106219:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010621c:	89 fa                	mov    %edi,%edx
8010621e:	8b 45 08             	mov    0x8(%ebp),%eax
80106221:	e8 a6 fb ff ff       	call   80105dcc <deallocuvm.part.0>
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
80106226:	31 c0                	xor    %eax,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106228:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010622b:	5b                   	pop    %ebx
8010622c:	5e                   	pop    %esi
8010622d:	5f                   	pop    %edi
8010622e:	5d                   	pop    %ebp
8010622f:	c3                   	ret    
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
80106230:	83 ec 0c             	sub    $0xc,%esp
80106233:	68 bd 6e 10 80       	push   $0x80106ebd
80106238:	e8 bb a3 ff ff       	call   801005f8 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
8010623d:	83 c4 10             	add    $0x10,%esp
80106240:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106243:	76 0d                	jbe    80106252 <allocuvm+0xca>
80106245:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106248:	89 fa                	mov    %edi,%edx
8010624a:	8b 45 08             	mov    0x8(%ebp),%eax
8010624d:	e8 7a fb ff ff       	call   80105dcc <deallocuvm.part.0>
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
80106252:	83 ec 0c             	sub    $0xc,%esp
80106255:	56                   	push   %esi
80106256:	e8 99 bd ff ff       	call   80101ff4 <kfree>
      return 0;
8010625b:	83 c4 10             	add    $0x10,%esp
8010625e:	31 c0                	xor    %eax,%eax
    }
  }
  return newsz;
}
80106260:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106263:	5b                   	pop    %ebx
80106264:	5e                   	pop    %esi
80106265:	5f                   	pop    %edi
80106266:	5d                   	pop    %ebp
80106267:	c3                   	ret    
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106268:	89 f8                	mov    %edi,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
8010626a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010626d:	5b                   	pop    %ebx
8010626e:	5e                   	pop    %esi
8010626f:	5f                   	pop    %edi
80106270:	5d                   	pop    %ebp
80106271:	c3                   	ret    
80106272:	66 90                	xchg   %ax,%ax

80106274 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106274:	55                   	push   %ebp
80106275:	89 e5                	mov    %esp,%ebp
80106277:	8b 45 08             	mov    0x8(%ebp),%eax
8010627a:	8b 55 0c             	mov    0xc(%ebp),%edx
8010627d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106280:	39 d1                	cmp    %edx,%ecx
80106282:	73 08                	jae    8010628c <deallocuvm+0x18>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106284:	5d                   	pop    %ebp
80106285:	e9 42 fb ff ff       	jmp    80105dcc <deallocuvm.part.0>
8010628a:	66 90                	xchg   %ax,%ax
8010628c:	89 d0                	mov    %edx,%eax
8010628e:	5d                   	pop    %ebp
8010628f:	c3                   	ret    

80106290 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106290:	55                   	push   %ebp
80106291:	89 e5                	mov    %esp,%ebp
80106293:	57                   	push   %edi
80106294:	56                   	push   %esi
80106295:	53                   	push   %ebx
80106296:	83 ec 0c             	sub    $0xc,%esp
80106299:	8b 7d 08             	mov    0x8(%ebp),%edi
  uint i;

  if(pgdir == 0)
8010629c:	85 ff                	test   %edi,%edi
8010629e:	74 51                	je     801062f1 <freevm+0x61>
801062a0:	31 c9                	xor    %ecx,%ecx
801062a2:	ba 00 00 00 80       	mov    $0x80000000,%edx
801062a7:	89 f8                	mov    %edi,%eax
801062a9:	e8 1e fb ff ff       	call   80105dcc <deallocuvm.part.0>
801062ae:	89 fb                	mov    %edi,%ebx
801062b0:	8d b7 00 10 00 00    	lea    0x1000(%edi),%esi
801062b6:	eb 07                	jmp    801062bf <freevm+0x2f>
801062b8:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801062bb:	39 f3                	cmp    %esi,%ebx
801062bd:	74 23                	je     801062e2 <freevm+0x52>
    if(pgdir[i] & PTE_P){
801062bf:	8b 03                	mov    (%ebx),%eax
801062c1:	a8 01                	test   $0x1,%al
801062c3:	74 f3                	je     801062b8 <freevm+0x28>
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
801062c5:	83 ec 0c             	sub    $0xc,%esp
801062c8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801062cd:	05 00 00 00 80       	add    $0x80000000,%eax
801062d2:	50                   	push   %eax
801062d3:	e8 1c bd ff ff       	call   80101ff4 <kfree>
801062d8:	83 c4 10             	add    $0x10,%esp
801062db:	83 c3 04             	add    $0x4,%ebx
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801062de:	39 f3                	cmp    %esi,%ebx
801062e0:	75 dd                	jne    801062bf <freevm+0x2f>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
801062e2:	89 7d 08             	mov    %edi,0x8(%ebp)
}
801062e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801062e8:	5b                   	pop    %ebx
801062e9:	5e                   	pop    %esi
801062ea:	5f                   	pop    %edi
801062eb:	5d                   	pop    %ebp
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
801062ec:	e9 03 bd ff ff       	jmp    80101ff4 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
801062f1:	83 ec 0c             	sub    $0xc,%esp
801062f4:	68 d9 6e 10 80       	push   $0x80106ed9
801062f9:	e8 3a a0 ff ff       	call   80100338 <panic>
801062fe:	66 90                	xchg   %ax,%ax

80106300 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80106300:	55                   	push   %ebp
80106301:	89 e5                	mov    %esp,%ebp
80106303:	56                   	push   %esi
80106304:	53                   	push   %ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80106305:	e8 76 be ff ff       	call   80102180 <kalloc>
8010630a:	85 c0                	test   %eax,%eax
8010630c:	74 66                	je     80106374 <setupkvm+0x74>
8010630e:	89 c6                	mov    %eax,%esi
    return 0;
  memset(pgdir, 0, PGSIZE);
80106310:	50                   	push   %eax
80106311:	68 00 10 00 00       	push   $0x1000
80106316:	6a 00                	push   $0x0
80106318:	56                   	push   %esi
80106319:	e8 2e db ff ff       	call   80103e4c <memset>
8010631e:	83 c4 10             	add    $0x10,%esp
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106321:	bb 20 94 10 80       	mov    $0x80109420,%ebx
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106326:	8b 43 04             	mov    0x4(%ebx),%eax
80106329:	83 ec 08             	sub    $0x8,%esp
8010632c:	8b 4b 08             	mov    0x8(%ebx),%ecx
8010632f:	29 c1                	sub    %eax,%ecx
80106331:	ff 73 0c             	pushl  0xc(%ebx)
80106334:	50                   	push   %eax
80106335:	8b 13                	mov    (%ebx),%edx
80106337:	89 f0                	mov    %esi,%eax
80106339:	e8 0e fa ff ff       	call   80105d4c <mappages>
8010633e:	83 c4 10             	add    $0x10,%esp
80106341:	85 c0                	test   %eax,%eax
80106343:	78 17                	js     8010635c <setupkvm+0x5c>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106345:	83 c3 10             	add    $0x10,%ebx
80106348:	81 fb 60 94 10 80    	cmp    $0x80109460,%ebx
8010634e:	75 d6                	jne    80106326 <setupkvm+0x26>
80106350:	89 f0                	mov    %esi,%eax
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
    }
  return pgdir;
}
80106352:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106355:	5b                   	pop    %ebx
80106356:	5e                   	pop    %esi
80106357:	5d                   	pop    %ebp
80106358:	c3                   	ret    
80106359:	8d 76 00             	lea    0x0(%esi),%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
8010635c:	83 ec 0c             	sub    $0xc,%esp
8010635f:	56                   	push   %esi
80106360:	e8 2b ff ff ff       	call   80106290 <freevm>
      return 0;
80106365:	83 c4 10             	add    $0x10,%esp
80106368:	31 c0                	xor    %eax,%eax
    }
  return pgdir;
}
8010636a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010636d:	5b                   	pop    %ebx
8010636e:	5e                   	pop    %esi
8010636f:	5d                   	pop    %ebp
80106370:	c3                   	ret    
80106371:	8d 76 00             	lea    0x0(%esi),%esi
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
80106374:	31 c0                	xor    %eax,%eax
80106376:	eb da                	jmp    80106352 <setupkvm+0x52>

80106378 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80106378:	55                   	push   %ebp
80106379:	89 e5                	mov    %esp,%ebp
8010637b:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
8010637e:	e8 7d ff ff ff       	call   80106300 <setupkvm>
80106383:	a3 a4 44 11 80       	mov    %eax,0x801144a4
80106388:	05 00 00 00 80       	add    $0x80000000,%eax
8010638d:	0f 22 d8             	mov    %eax,%cr3
  switchkvm();
}
80106390:	c9                   	leave  
80106391:	c3                   	ret    
80106392:	66 90                	xchg   %ax,%ax

80106394 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106394:	55                   	push   %ebp
80106395:	89 e5                	mov    %esp,%ebp
80106397:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
8010639a:	31 c9                	xor    %ecx,%ecx
8010639c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010639f:	8b 45 08             	mov    0x8(%ebp),%eax
801063a2:	e8 31 f9 ff ff       	call   80105cd8 <walkpgdir>
  if(pte == 0)
801063a7:	85 c0                	test   %eax,%eax
801063a9:	74 05                	je     801063b0 <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
801063ab:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
801063ae:	c9                   	leave  
801063af:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
801063b0:	83 ec 0c             	sub    $0xc,%esp
801063b3:	68 ea 6e 10 80       	push   $0x80106eea
801063b8:	e8 7b 9f ff ff       	call   80100338 <panic>
801063bd:	8d 76 00             	lea    0x0(%esi),%esi

801063c0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801063c0:	55                   	push   %ebp
801063c1:	89 e5                	mov    %esp,%ebp
801063c3:	57                   	push   %edi
801063c4:	56                   	push   %esi
801063c5:	53                   	push   %ebx
801063c6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801063c9:	e8 32 ff ff ff       	call   80106300 <setupkvm>
801063ce:	89 45 e0             	mov    %eax,-0x20(%ebp)
801063d1:	85 c0                	test   %eax,%eax
801063d3:	0f 84 b5 00 00 00    	je     8010648e <copyuvm+0xce>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801063d9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801063dc:	85 db                	test   %ebx,%ebx
801063de:	0f 84 90 00 00 00    	je     80106474 <copyuvm+0xb4>
801063e4:	31 ff                	xor    %edi,%edi
801063e6:	eb 40                	jmp    80106428 <copyuvm+0x68>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
801063e8:	50                   	push   %eax
801063e9:	68 00 10 00 00       	push   $0x1000
801063ee:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801063f1:	05 00 00 00 80       	add    $0x80000000,%eax
801063f6:	50                   	push   %eax
801063f7:	56                   	push   %esi
801063f8:	e8 e3 da ff ff       	call   80103ee0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
801063fd:	5a                   	pop    %edx
801063fe:	59                   	pop    %ecx
801063ff:	53                   	push   %ebx
80106400:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106406:	50                   	push   %eax
80106407:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010640c:	89 fa                	mov    %edi,%edx
8010640e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106411:	e8 36 f9 ff ff       	call   80105d4c <mappages>
80106416:	83 c4 10             	add    $0x10,%esp
80106419:	85 c0                	test   %eax,%eax
8010641b:	78 63                	js     80106480 <copyuvm+0xc0>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
8010641d:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106423:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80106426:	76 4c                	jbe    80106474 <copyuvm+0xb4>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80106428:	31 c9                	xor    %ecx,%ecx
8010642a:	89 fa                	mov    %edi,%edx
8010642c:	8b 45 08             	mov    0x8(%ebp),%eax
8010642f:	e8 a4 f8 ff ff       	call   80105cd8 <walkpgdir>
80106434:	85 c0                	test   %eax,%eax
80106436:	74 67                	je     8010649f <copyuvm+0xdf>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
80106438:	8b 18                	mov    (%eax),%ebx
8010643a:	f6 c3 01             	test   $0x1,%bl
8010643d:	74 53                	je     80106492 <copyuvm+0xd2>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
8010643f:	89 d8                	mov    %ebx,%eax
80106441:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106446:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    flags = PTE_FLAGS(*pte);
80106449:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
    if((mem = kalloc()) == 0)
8010644f:	e8 2c bd ff ff       	call   80102180 <kalloc>
80106454:	89 c6                	mov    %eax,%esi
80106456:	85 c0                	test   %eax,%eax
80106458:	75 8e                	jne    801063e8 <copyuvm+0x28>
    }
  }
  return d;

bad:
  freevm(d);
8010645a:	83 ec 0c             	sub    $0xc,%esp
8010645d:	ff 75 e0             	pushl  -0x20(%ebp)
80106460:	e8 2b fe ff ff       	call   80106290 <freevm>
  return 0;
80106465:	83 c4 10             	add    $0x10,%esp
80106468:	31 c0                	xor    %eax,%eax
}
8010646a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010646d:	5b                   	pop    %ebx
8010646e:	5e                   	pop    %esi
8010646f:	5f                   	pop    %edi
80106470:	5d                   	pop    %ebp
80106471:	c3                   	ret    
80106472:	66 90                	xchg   %ax,%ax
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106474:	8b 45 e0             	mov    -0x20(%ebp),%eax
  return d;

bad:
  freevm(d);
  return 0;
}
80106477:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010647a:	5b                   	pop    %ebx
8010647b:	5e                   	pop    %esi
8010647c:	5f                   	pop    %edi
8010647d:	5d                   	pop    %ebp
8010647e:	c3                   	ret    
8010647f:	90                   	nop
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
      kfree(mem);
80106480:	83 ec 0c             	sub    $0xc,%esp
80106483:	56                   	push   %esi
80106484:	e8 6b bb ff ff       	call   80101ff4 <kfree>
      goto bad;
80106489:	83 c4 10             	add    $0x10,%esp
8010648c:	eb cc                	jmp    8010645a <copyuvm+0x9a>
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
8010648e:	31 c0                	xor    %eax,%eax
80106490:	eb d8                	jmp    8010646a <copyuvm+0xaa>
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
80106492:	83 ec 0c             	sub    $0xc,%esp
80106495:	68 0e 6f 10 80       	push   $0x80106f0e
8010649a:	e8 99 9e ff ff       	call   80100338 <panic>

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
8010649f:	83 ec 0c             	sub    $0xc,%esp
801064a2:	68 f4 6e 10 80       	push   $0x80106ef4
801064a7:	e8 8c 9e ff ff       	call   80100338 <panic>

801064ac <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801064ac:	55                   	push   %ebp
801064ad:	89 e5                	mov    %esp,%ebp
801064af:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801064b2:	31 c9                	xor    %ecx,%ecx
801064b4:	8b 55 0c             	mov    0xc(%ebp),%edx
801064b7:	8b 45 08             	mov    0x8(%ebp),%eax
801064ba:	e8 19 f8 ff ff       	call   80105cd8 <walkpgdir>
  if((*pte & PTE_P) == 0)
801064bf:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
801064c1:	89 c2                	mov    %eax,%edx
801064c3:	83 e2 05             	and    $0x5,%edx
801064c6:	83 fa 05             	cmp    $0x5,%edx
801064c9:	75 0d                	jne    801064d8 <uva2ka+0x2c>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
801064cb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801064d0:	05 00 00 00 80       	add    $0x80000000,%eax
}
801064d5:	c9                   	leave  
801064d6:	c3                   	ret    
801064d7:	90                   	nop

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
801064d8:	31 c0                	xor    %eax,%eax
  return (char*)P2V(PTE_ADDR(*pte));
}
801064da:	c9                   	leave  
801064db:	c3                   	ret    

801064dc <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801064dc:	55                   	push   %ebp
801064dd:	89 e5                	mov    %esp,%ebp
801064df:	57                   	push   %edi
801064e0:	56                   	push   %esi
801064e1:	53                   	push   %ebx
801064e2:	83 ec 0c             	sub    $0xc,%esp
801064e5:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801064e8:	8b 4d 14             	mov    0x14(%ebp),%ecx
801064eb:	89 df                	mov    %ebx,%edi
801064ed:	85 c9                	test   %ecx,%ecx
801064ef:	75 37                	jne    80106528 <copyout+0x4c>
801064f1:	eb 5d                	jmp    80106550 <copyout+0x74>
801064f3:	90                   	nop
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801064f4:	89 f2                	mov    %esi,%edx
801064f6:	29 fa                	sub    %edi,%edx
801064f8:	8d 9a 00 10 00 00    	lea    0x1000(%edx),%ebx
801064fe:	3b 5d 14             	cmp    0x14(%ebp),%ebx
80106501:	76 03                	jbe    80106506 <copyout+0x2a>
80106503:	8b 5d 14             	mov    0x14(%ebp),%ebx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80106506:	52                   	push   %edx
80106507:	53                   	push   %ebx
80106508:	ff 75 10             	pushl  0x10(%ebp)
8010650b:	89 f9                	mov    %edi,%ecx
8010650d:	29 f1                	sub    %esi,%ecx
8010650f:	01 c8                	add    %ecx,%eax
80106511:	50                   	push   %eax
80106512:	e8 c9 d9 ff ff       	call   80103ee0 <memmove>
    len -= n;
    buf += n;
80106517:	01 5d 10             	add    %ebx,0x10(%ebp)
    va = va0 + PGSIZE;
8010651a:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80106520:	83 c4 10             	add    $0x10,%esp
80106523:	29 5d 14             	sub    %ebx,0x14(%ebp)
80106526:	74 28                	je     80106550 <copyout+0x74>
    va0 = (uint)PGROUNDDOWN(va);
80106528:	89 fe                	mov    %edi,%esi
8010652a:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80106530:	83 ec 08             	sub    $0x8,%esp
80106533:	56                   	push   %esi
80106534:	ff 75 08             	pushl  0x8(%ebp)
80106537:	e8 70 ff ff ff       	call   801064ac <uva2ka>
    if(pa0 == 0)
8010653c:	83 c4 10             	add    $0x10,%esp
8010653f:	85 c0                	test   %eax,%eax
80106541:	75 b1                	jne    801064f4 <copyout+0x18>
      return -1;
80106543:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
80106548:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010654b:	5b                   	pop    %ebx
8010654c:	5e                   	pop    %esi
8010654d:	5f                   	pop    %edi
8010654e:	5d                   	pop    %ebp
8010654f:	c3                   	ret    
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
80106550:	31 c0                	xor    %eax,%eax
}
80106552:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106555:	5b                   	pop    %ebx
80106556:	5e                   	pop    %esi
80106557:	5f                   	pop    %edi
80106558:	5d                   	pop    %ebp
80106559:	c3                   	ret    
