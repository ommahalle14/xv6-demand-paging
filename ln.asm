
_ln:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
   f:	8b 59 04             	mov    0x4(%ecx),%ebx
  if(argc != 3){
  12:	83 39 03             	cmpl   $0x3,(%ecx)
  15:	74 14                	je     2b <main+0x2b>
    printf(2, "Usage: ln old new\n");
  17:	83 ec 08             	sub    $0x8,%esp
  1a:	68 2c 06 00 00       	push   $0x62c
  1f:	6a 02                	push   $0x2
  21:	e8 06 03 00 00       	call   32c <printf>
    exit();
  26:	e8 dc 01 00 00       	call   207 <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  2b:	50                   	push   %eax
  2c:	50                   	push   %eax
  2d:	ff 73 08             	pushl  0x8(%ebx)
  30:	ff 73 04             	pushl  0x4(%ebx)
  33:	e8 2f 02 00 00       	call   267 <link>
  38:	83 c4 10             	add    $0x10,%esp
  3b:	85 c0                	test   %eax,%eax
  3d:	78 05                	js     44 <main+0x44>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit();
  3f:	e8 c3 01 00 00       	call   207 <exit>
  if(argc != 3){
    printf(2, "Usage: ln old new\n");
    exit();
  }
  if(link(argv[1], argv[2]) < 0)
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  44:	ff 73 08             	pushl  0x8(%ebx)
  47:	ff 73 04             	pushl  0x4(%ebx)
  4a:	68 3f 06 00 00       	push   $0x63f
  4f:	6a 02                	push   $0x2
  51:	e8 d6 02 00 00       	call   32c <printf>
  56:	83 c4 10             	add    $0x10,%esp
  59:	eb e4                	jmp    3f <main+0x3f>
  5b:	90                   	nop

0000005c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  5c:	55                   	push   %ebp
  5d:	89 e5                	mov    %esp,%ebp
  5f:	53                   	push   %ebx
  60:	8b 45 08             	mov    0x8(%ebp),%eax
  63:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  66:	89 c2                	mov    %eax,%edx
  68:	42                   	inc    %edx
  69:	41                   	inc    %ecx
  6a:	8a 59 ff             	mov    -0x1(%ecx),%bl
  6d:	88 5a ff             	mov    %bl,-0x1(%edx)
  70:	84 db                	test   %bl,%bl
  72:	75 f4                	jne    68 <strcpy+0xc>
    ;
  return os;
}
  74:	5b                   	pop    %ebx
  75:	5d                   	pop    %ebp
  76:	c3                   	ret    
  77:	90                   	nop

00000078 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  78:	55                   	push   %ebp
  79:	89 e5                	mov    %esp,%ebp
  7b:	56                   	push   %esi
  7c:	53                   	push   %ebx
  7d:	8b 55 08             	mov    0x8(%ebp),%edx
  80:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  83:	0f b6 02             	movzbl (%edx),%eax
  86:	0f b6 0b             	movzbl (%ebx),%ecx
  89:	84 c0                	test   %al,%al
  8b:	75 14                	jne    a1 <strcmp+0x29>
  8d:	eb 1d                	jmp    ac <strcmp+0x34>
  8f:	90                   	nop
    p++, q++;
  90:	42                   	inc    %edx
  91:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  94:	0f b6 02             	movzbl (%edx),%eax
  97:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
  9b:	84 c0                	test   %al,%al
  9d:	74 0d                	je     ac <strcmp+0x34>
  9f:	89 f3                	mov    %esi,%ebx
  a1:	38 c8                	cmp    %cl,%al
  a3:	74 eb                	je     90 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  a5:	29 c8                	sub    %ecx,%eax
}
  a7:	5b                   	pop    %ebx
  a8:	5e                   	pop    %esi
  a9:	5d                   	pop    %ebp
  aa:	c3                   	ret    
  ab:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  ac:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
  ae:	29 c8                	sub    %ecx,%eax
}
  b0:	5b                   	pop    %ebx
  b1:	5e                   	pop    %esi
  b2:	5d                   	pop    %ebp
  b3:	c3                   	ret    

000000b4 <strlen>:

uint
strlen(const char *s)
{
  b4:	55                   	push   %ebp
  b5:	89 e5                	mov    %esp,%ebp
  b7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  ba:	80 39 00             	cmpb   $0x0,(%ecx)
  bd:	74 10                	je     cf <strlen+0x1b>
  bf:	31 d2                	xor    %edx,%edx
  c1:	8d 76 00             	lea    0x0(%esi),%esi
  c4:	42                   	inc    %edx
  c5:	89 d0                	mov    %edx,%eax
  c7:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  cb:	75 f7                	jne    c4 <strlen+0x10>
    ;
  return n;
}
  cd:	5d                   	pop    %ebp
  ce:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
  cf:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
  d1:	5d                   	pop    %ebp
  d2:	c3                   	ret    
  d3:	90                   	nop

000000d4 <memset>:

void*
memset(void *dst, int c, uint n)
{
  d4:	55                   	push   %ebp
  d5:	89 e5                	mov    %esp,%ebp
  d7:	57                   	push   %edi
  d8:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  db:	89 d7                	mov    %edx,%edi
  dd:	8b 4d 10             	mov    0x10(%ebp),%ecx
  e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  e3:	fc                   	cld    
  e4:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  e6:	89 d0                	mov    %edx,%eax
  e8:	5f                   	pop    %edi
  e9:	5d                   	pop    %ebp
  ea:	c3                   	ret    
  eb:	90                   	nop

000000ec <strchr>:

char*
strchr(const char *s, char c)
{
  ec:	55                   	push   %ebp
  ed:	89 e5                	mov    %esp,%ebp
  ef:	53                   	push   %ebx
  f0:	8b 45 08             	mov    0x8(%ebp),%eax
  f3:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
  f6:	8a 10                	mov    (%eax),%dl
  f8:	84 d2                	test   %dl,%dl
  fa:	74 13                	je     10f <strchr+0x23>
  fc:	88 d9                	mov    %bl,%cl
    if(*s == c)
  fe:	38 d3                	cmp    %dl,%bl
 100:	75 06                	jne    108 <strchr+0x1c>
 102:	eb 0d                	jmp    111 <strchr+0x25>
 104:	38 ca                	cmp    %cl,%dl
 106:	74 09                	je     111 <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 108:	40                   	inc    %eax
 109:	8a 10                	mov    (%eax),%dl
 10b:	84 d2                	test   %dl,%dl
 10d:	75 f5                	jne    104 <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
 10f:	31 c0                	xor    %eax,%eax
}
 111:	5b                   	pop    %ebx
 112:	5d                   	pop    %ebp
 113:	c3                   	ret    

00000114 <gets>:

char*
gets(char *buf, int max)
{
 114:	55                   	push   %ebp
 115:	89 e5                	mov    %esp,%ebp
 117:	57                   	push   %edi
 118:	56                   	push   %esi
 119:	53                   	push   %ebx
 11a:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 11d:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 11f:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 122:	eb 26                	jmp    14a <gets+0x36>
    cc = read(0, &c, 1);
 124:	50                   	push   %eax
 125:	6a 01                	push   $0x1
 127:	57                   	push   %edi
 128:	6a 00                	push   $0x0
 12a:	e8 f0 00 00 00       	call   21f <read>
    if(cc < 1)
 12f:	83 c4 10             	add    $0x10,%esp
 132:	85 c0                	test   %eax,%eax
 134:	7e 1c                	jle    152 <gets+0x3e>
      break;
    buf[i++] = c;
 136:	8a 45 e7             	mov    -0x19(%ebp),%al
 139:	8b 55 08             	mov    0x8(%ebp),%edx
 13c:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 140:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 142:	3c 0a                	cmp    $0xa,%al
 144:	74 0c                	je     152 <gets+0x3e>
 146:	3c 0d                	cmp    $0xd,%al
 148:	74 08                	je     152 <gets+0x3e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 14a:	8d 5e 01             	lea    0x1(%esi),%ebx
 14d:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 150:	7c d2                	jl     124 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 152:	8b 45 08             	mov    0x8(%ebp),%eax
 155:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 159:	8d 65 f4             	lea    -0xc(%ebp),%esp
 15c:	5b                   	pop    %ebx
 15d:	5e                   	pop    %esi
 15e:	5f                   	pop    %edi
 15f:	5d                   	pop    %ebp
 160:	c3                   	ret    
 161:	8d 76 00             	lea    0x0(%esi),%esi

00000164 <stat>:

int
stat(const char *n, struct stat *st)
{
 164:	55                   	push   %ebp
 165:	89 e5                	mov    %esp,%ebp
 167:	56                   	push   %esi
 168:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 169:	83 ec 08             	sub    $0x8,%esp
 16c:	6a 00                	push   $0x0
 16e:	ff 75 08             	pushl  0x8(%ebp)
 171:	e8 d1 00 00 00       	call   247 <open>
  if(fd < 0)
 176:	83 c4 10             	add    $0x10,%esp
 179:	85 c0                	test   %eax,%eax
 17b:	78 27                	js     1a4 <stat+0x40>
 17d:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 17f:	83 ec 08             	sub    $0x8,%esp
 182:	ff 75 0c             	pushl  0xc(%ebp)
 185:	50                   	push   %eax
 186:	e8 d4 00 00 00       	call   25f <fstat>
 18b:	89 c6                	mov    %eax,%esi
  close(fd);
 18d:	89 1c 24             	mov    %ebx,(%esp)
 190:	e8 9a 00 00 00       	call   22f <close>
  return r;
 195:	83 c4 10             	add    $0x10,%esp
 198:	89 f0                	mov    %esi,%eax
}
 19a:	8d 65 f8             	lea    -0x8(%ebp),%esp
 19d:	5b                   	pop    %ebx
 19e:	5e                   	pop    %esi
 19f:	5d                   	pop    %ebp
 1a0:	c3                   	ret    
 1a1:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 1a4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1a9:	eb ef                	jmp    19a <stat+0x36>
 1ab:	90                   	nop

000001ac <atoi>:
  return r;
}

int
atoi(const char *s)
{
 1ac:	55                   	push   %ebp
 1ad:	89 e5                	mov    %esp,%ebp
 1af:	53                   	push   %ebx
 1b0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1b3:	0f be 11             	movsbl (%ecx),%edx
 1b6:	8d 42 d0             	lea    -0x30(%edx),%eax
 1b9:	3c 09                	cmp    $0x9,%al
 1bb:	b8 00 00 00 00       	mov    $0x0,%eax
 1c0:	77 15                	ja     1d7 <atoi+0x2b>
 1c2:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 1c4:	41                   	inc    %ecx
 1c5:	8d 04 80             	lea    (%eax,%eax,4),%eax
 1c8:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1cc:	0f be 11             	movsbl (%ecx),%edx
 1cf:	8d 5a d0             	lea    -0x30(%edx),%ebx
 1d2:	80 fb 09             	cmp    $0x9,%bl
 1d5:	76 ed                	jbe    1c4 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 1d7:	5b                   	pop    %ebx
 1d8:	5d                   	pop    %ebp
 1d9:	c3                   	ret    
 1da:	66 90                	xchg   %ax,%ax

000001dc <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1dc:	55                   	push   %ebp
 1dd:	89 e5                	mov    %esp,%ebp
 1df:	56                   	push   %esi
 1e0:	53                   	push   %ebx
 1e1:	8b 45 08             	mov    0x8(%ebp),%eax
 1e4:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1e7:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1ea:	85 f6                	test   %esi,%esi
 1ec:	7e 0d                	jle    1fb <memmove+0x1f>
 1ee:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 1f0:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 1f3:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 1f6:	42                   	inc    %edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1f7:	39 f2                	cmp    %esi,%edx
 1f9:	75 f5                	jne    1f0 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 1fb:	5b                   	pop    %ebx
 1fc:	5e                   	pop    %esi
 1fd:	5d                   	pop    %ebp
 1fe:	c3                   	ret    

000001ff <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 1ff:	b8 01 00 00 00       	mov    $0x1,%eax
 204:	cd 40                	int    $0x40
 206:	c3                   	ret    

00000207 <exit>:
SYSCALL(exit)
 207:	b8 02 00 00 00       	mov    $0x2,%eax
 20c:	cd 40                	int    $0x40
 20e:	c3                   	ret    

0000020f <wait>:
SYSCALL(wait)
 20f:	b8 03 00 00 00       	mov    $0x3,%eax
 214:	cd 40                	int    $0x40
 216:	c3                   	ret    

00000217 <pipe>:
SYSCALL(pipe)
 217:	b8 04 00 00 00       	mov    $0x4,%eax
 21c:	cd 40                	int    $0x40
 21e:	c3                   	ret    

0000021f <read>:
SYSCALL(read)
 21f:	b8 05 00 00 00       	mov    $0x5,%eax
 224:	cd 40                	int    $0x40
 226:	c3                   	ret    

00000227 <write>:
SYSCALL(write)
 227:	b8 10 00 00 00       	mov    $0x10,%eax
 22c:	cd 40                	int    $0x40
 22e:	c3                   	ret    

0000022f <close>:
SYSCALL(close)
 22f:	b8 15 00 00 00       	mov    $0x15,%eax
 234:	cd 40                	int    $0x40
 236:	c3                   	ret    

00000237 <kill>:
SYSCALL(kill)
 237:	b8 06 00 00 00       	mov    $0x6,%eax
 23c:	cd 40                	int    $0x40
 23e:	c3                   	ret    

0000023f <exec>:
SYSCALL(exec)
 23f:	b8 07 00 00 00       	mov    $0x7,%eax
 244:	cd 40                	int    $0x40
 246:	c3                   	ret    

00000247 <open>:
SYSCALL(open)
 247:	b8 0f 00 00 00       	mov    $0xf,%eax
 24c:	cd 40                	int    $0x40
 24e:	c3                   	ret    

0000024f <mknod>:
SYSCALL(mknod)
 24f:	b8 11 00 00 00       	mov    $0x11,%eax
 254:	cd 40                	int    $0x40
 256:	c3                   	ret    

00000257 <unlink>:
SYSCALL(unlink)
 257:	b8 12 00 00 00       	mov    $0x12,%eax
 25c:	cd 40                	int    $0x40
 25e:	c3                   	ret    

0000025f <fstat>:
SYSCALL(fstat)
 25f:	b8 08 00 00 00       	mov    $0x8,%eax
 264:	cd 40                	int    $0x40
 266:	c3                   	ret    

00000267 <link>:
SYSCALL(link)
 267:	b8 13 00 00 00       	mov    $0x13,%eax
 26c:	cd 40                	int    $0x40
 26e:	c3                   	ret    

0000026f <mkdir>:
SYSCALL(mkdir)
 26f:	b8 14 00 00 00       	mov    $0x14,%eax
 274:	cd 40                	int    $0x40
 276:	c3                   	ret    

00000277 <chdir>:
SYSCALL(chdir)
 277:	b8 09 00 00 00       	mov    $0x9,%eax
 27c:	cd 40                	int    $0x40
 27e:	c3                   	ret    

0000027f <dup>:
SYSCALL(dup)
 27f:	b8 0a 00 00 00       	mov    $0xa,%eax
 284:	cd 40                	int    $0x40
 286:	c3                   	ret    

00000287 <getpid>:
SYSCALL(getpid)
 287:	b8 0b 00 00 00       	mov    $0xb,%eax
 28c:	cd 40                	int    $0x40
 28e:	c3                   	ret    

0000028f <sbrk>:
SYSCALL(sbrk)
 28f:	b8 0c 00 00 00       	mov    $0xc,%eax
 294:	cd 40                	int    $0x40
 296:	c3                   	ret    

00000297 <sleep>:
SYSCALL(sleep)
 297:	b8 0d 00 00 00       	mov    $0xd,%eax
 29c:	cd 40                	int    $0x40
 29e:	c3                   	ret    

0000029f <uptime>:
SYSCALL(uptime)
 29f:	b8 0e 00 00 00       	mov    $0xe,%eax
 2a4:	cd 40                	int    $0x40
 2a6:	c3                   	ret    
 2a7:	90                   	nop

000002a8 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 2a8:	55                   	push   %ebp
 2a9:	89 e5                	mov    %esp,%ebp
 2ab:	57                   	push   %edi
 2ac:	56                   	push   %esi
 2ad:	53                   	push   %ebx
 2ae:	83 ec 3c             	sub    $0x3c,%esp
 2b1:	89 c6                	mov    %eax,%esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 2b3:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 2b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
 2b8:	85 db                	test   %ebx,%ebx
 2ba:	74 04                	je     2c0 <printint+0x18>
 2bc:	85 d2                	test   %edx,%edx
 2be:	78 5f                	js     31f <printint+0x77>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 2c0:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 2c7:	31 ff                	xor    %edi,%edi
 2c9:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 2cc:	89 75 c4             	mov    %esi,-0x3c(%ebp)
 2cf:	89 ce                	mov    %ecx,%esi
 2d1:	eb 03                	jmp    2d6 <printint+0x2e>
 2d3:	90                   	nop
  do{
    buf[i++] = digits[x % base];
 2d4:	89 cf                	mov    %ecx,%edi
 2d6:	8d 4f 01             	lea    0x1(%edi),%ecx
 2d9:	31 d2                	xor    %edx,%edx
 2db:	f7 f6                	div    %esi
 2dd:	8a 92 5c 06 00 00    	mov    0x65c(%edx),%dl
 2e3:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 2e6:	85 c0                	test   %eax,%eax
 2e8:	75 ea                	jne    2d4 <printint+0x2c>
 2ea:	8b 75 c4             	mov    -0x3c(%ebp),%esi
  if(neg)
 2ed:	8b 55 c0             	mov    -0x40(%ebp),%edx
 2f0:	85 d2                	test   %edx,%edx
 2f2:	74 08                	je     2fc <printint+0x54>
    buf[i++] = '-';
 2f4:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 2f9:	8d 4f 02             	lea    0x2(%edi),%ecx
 2fc:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 300:	8a 07                	mov    (%edi),%al
 302:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 305:	50                   	push   %eax
 306:	6a 01                	push   $0x1
 308:	53                   	push   %ebx
 309:	56                   	push   %esi
 30a:	e8 18 ff ff ff       	call   227 <write>
 30f:	4f                   	dec    %edi
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 310:	83 c4 10             	add    $0x10,%esp
 313:	39 df                	cmp    %ebx,%edi
 315:	75 e9                	jne    300 <printint+0x58>
    putc(fd, buf[i]);
}
 317:	8d 65 f4             	lea    -0xc(%ebp),%esp
 31a:	5b                   	pop    %ebx
 31b:	5e                   	pop    %esi
 31c:	5f                   	pop    %edi
 31d:	5d                   	pop    %ebp
 31e:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 31f:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 321:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 328:	eb 9d                	jmp    2c7 <printint+0x1f>
 32a:	66 90                	xchg   %ax,%ax

0000032c <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 32c:	55                   	push   %ebp
 32d:	89 e5                	mov    %esp,%ebp
 32f:	57                   	push   %edi
 330:	56                   	push   %esi
 331:	53                   	push   %ebx
 332:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 335:	8b 75 0c             	mov    0xc(%ebp),%esi
 338:	8a 1e                	mov    (%esi),%bl
 33a:	84 db                	test   %bl,%bl
 33c:	0f 84 a6 00 00 00    	je     3e8 <printf+0xbc>
 342:	46                   	inc    %esi
 343:	8d 45 10             	lea    0x10(%ebp),%eax
 346:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 349:	31 ff                	xor    %edi,%edi
 34b:	eb 29                	jmp    376 <printf+0x4a>
 34d:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 350:	83 f8 25             	cmp    $0x25,%eax
 353:	0f 84 97 00 00 00    	je     3f0 <printf+0xc4>
 359:	88 5d e2             	mov    %bl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 35c:	50                   	push   %eax
 35d:	6a 01                	push   $0x1
 35f:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 362:	50                   	push   %eax
 363:	ff 75 08             	pushl  0x8(%ebp)
 366:	e8 bc fe ff ff       	call   227 <write>
 36b:	83 c4 10             	add    $0x10,%esp
 36e:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 36f:	8a 5e ff             	mov    -0x1(%esi),%bl
 372:	84 db                	test   %bl,%bl
 374:	74 72                	je     3e8 <printf+0xbc>
    c = fmt[i] & 0xff;
 376:	0f be cb             	movsbl %bl,%ecx
 379:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 37c:	85 ff                	test   %edi,%edi
 37e:	74 d0                	je     350 <printf+0x24>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 380:	83 ff 25             	cmp    $0x25,%edi
 383:	75 e9                	jne    36e <printf+0x42>
      if(c == 'd'){
 385:	83 f8 64             	cmp    $0x64,%eax
 388:	0f 84 f6 00 00 00    	je     484 <printf+0x158>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 38e:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 394:	83 f9 70             	cmp    $0x70,%ecx
 397:	74 63                	je     3fc <printf+0xd0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 399:	83 f8 73             	cmp    $0x73,%eax
 39c:	0f 84 86 00 00 00    	je     428 <printf+0xfc>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 3a2:	83 f8 63             	cmp    $0x63,%eax
 3a5:	0f 84 be 00 00 00    	je     469 <printf+0x13d>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 3ab:	83 f8 25             	cmp    $0x25,%eax
 3ae:	0f 84 e0 00 00 00    	je     494 <printf+0x168>
 3b4:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3b8:	50                   	push   %eax
 3b9:	6a 01                	push   $0x1
 3bb:	8d 45 e7             	lea    -0x19(%ebp),%eax
 3be:	50                   	push   %eax
 3bf:	ff 75 08             	pushl  0x8(%ebp)
 3c2:	e8 60 fe ff ff       	call   227 <write>
 3c7:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 3ca:	83 c4 0c             	add    $0xc,%esp
 3cd:	6a 01                	push   $0x1
 3cf:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 3d2:	50                   	push   %eax
 3d3:	ff 75 08             	pushl  0x8(%ebp)
 3d6:	e8 4c fe ff ff       	call   227 <write>
 3db:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 3de:	31 ff                	xor    %edi,%edi
 3e0:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3e1:	8a 5e ff             	mov    -0x1(%esi),%bl
 3e4:	84 db                	test   %bl,%bl
 3e6:	75 8e                	jne    376 <printf+0x4a>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 3e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3eb:	5b                   	pop    %ebx
 3ec:	5e                   	pop    %esi
 3ed:	5f                   	pop    %edi
 3ee:	5d                   	pop    %ebp
 3ef:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 3f0:	bf 25 00 00 00       	mov    $0x25,%edi
 3f5:	e9 74 ff ff ff       	jmp    36e <printf+0x42>
 3fa:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 3fc:	83 ec 0c             	sub    $0xc,%esp
 3ff:	6a 00                	push   $0x0
 401:	b9 10 00 00 00       	mov    $0x10,%ecx
 406:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 409:	8b 17                	mov    (%edi),%edx
 40b:	8b 45 08             	mov    0x8(%ebp),%eax
 40e:	e8 95 fe ff ff       	call   2a8 <printint>
        ap++;
 413:	89 f8                	mov    %edi,%eax
 415:	83 c0 04             	add    $0x4,%eax
 418:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 41b:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 41e:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 420:	e9 49 ff ff ff       	jmp    36e <printf+0x42>
 425:	8d 76 00             	lea    0x0(%esi),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 428:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 42b:	8b 38                	mov    (%eax),%edi
        ap++;
 42d:	83 c0 04             	add    $0x4,%eax
 430:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 433:	85 ff                	test   %edi,%edi
 435:	74 6b                	je     4a2 <printf+0x176>
          s = "(null)";
        while(*s != 0){
 437:	8a 07                	mov    (%edi),%al
 439:	84 c0                	test   %al,%al
 43b:	74 6c                	je     4a9 <printf+0x17d>
 43d:	8d 5d e3             	lea    -0x1d(%ebp),%ebx
 440:	89 75 d0             	mov    %esi,-0x30(%ebp)
 443:	89 fe                	mov    %edi,%esi
 445:	8b 7d 08             	mov    0x8(%ebp),%edi
 448:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 44b:	50                   	push   %eax
 44c:	6a 01                	push   $0x1
 44e:	53                   	push   %ebx
 44f:	57                   	push   %edi
 450:	e8 d2 fd ff ff       	call   227 <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 455:	46                   	inc    %esi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 456:	8a 06                	mov    (%esi),%al
 458:	83 c4 10             	add    $0x10,%esp
 45b:	84 c0                	test   %al,%al
 45d:	75 e9                	jne    448 <printf+0x11c>
 45f:	8b 75 d0             	mov    -0x30(%ebp),%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 462:	31 ff                	xor    %edi,%edi
 464:	e9 05 ff ff ff       	jmp    36e <printf+0x42>
 469:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 46c:	8b 07                	mov    (%edi),%eax
 46e:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 471:	51                   	push   %ecx
 472:	6a 01                	push   $0x1
 474:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 477:	50                   	push   %eax
 478:	ff 75 08             	pushl  0x8(%ebp)
 47b:	e8 a7 fd ff ff       	call   227 <write>
 480:	eb 91                	jmp    413 <printf+0xe7>
 482:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 484:	83 ec 0c             	sub    $0xc,%esp
 487:	6a 01                	push   $0x1
 489:	b9 0a 00 00 00       	mov    $0xa,%ecx
 48e:	e9 73 ff ff ff       	jmp    406 <printf+0xda>
 493:	90                   	nop
 494:	88 5d e5             	mov    %bl,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 497:	52                   	push   %edx
 498:	6a 01                	push   $0x1
 49a:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 49d:	e9 30 ff ff ff       	jmp    3d2 <printf+0xa6>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
 4a2:	bf 53 06 00 00       	mov    $0x653,%edi
 4a7:	eb 8e                	jmp    437 <printf+0x10b>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4a9:	31 ff                	xor    %edi,%edi
 4ab:	e9 be fe ff ff       	jmp    36e <printf+0x42>

000004b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	57                   	push   %edi
 4b4:	56                   	push   %esi
 4b5:	53                   	push   %ebx
 4b6:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 4b9:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4bc:	a1 e8 08 00 00       	mov    0x8e8,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4c1:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4c3:	39 c8                	cmp    %ecx,%eax
 4c5:	73 11                	jae    4d8 <free+0x28>
 4c7:	90                   	nop
 4c8:	39 d1                	cmp    %edx,%ecx
 4ca:	72 14                	jb     4e0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4cc:	39 d0                	cmp    %edx,%eax
 4ce:	73 10                	jae    4e0 <free+0x30>
static Header base;
static Header *freep;

void
free(void *ap)
{
 4d0:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4d2:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4d4:	39 c8                	cmp    %ecx,%eax
 4d6:	72 f0                	jb     4c8 <free+0x18>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4d8:	39 d0                	cmp    %edx,%eax
 4da:	72 f4                	jb     4d0 <free+0x20>
 4dc:	39 d1                	cmp    %edx,%ecx
 4de:	73 f0                	jae    4d0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 4e0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 4e3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 4e6:	39 d7                	cmp    %edx,%edi
 4e8:	74 19                	je     503 <free+0x53>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 4ea:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 4ed:	8b 50 04             	mov    0x4(%eax),%edx
 4f0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 4f3:	39 f1                	cmp    %esi,%ecx
 4f5:	74 23                	je     51a <free+0x6a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 4f7:	89 08                	mov    %ecx,(%eax)
  freep = p;
 4f9:	a3 e8 08 00 00       	mov    %eax,0x8e8
}
 4fe:	5b                   	pop    %ebx
 4ff:	5e                   	pop    %esi
 500:	5f                   	pop    %edi
 501:	5d                   	pop    %ebp
 502:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 503:	03 72 04             	add    0x4(%edx),%esi
 506:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 509:	8b 10                	mov    (%eax),%edx
 50b:	8b 12                	mov    (%edx),%edx
 50d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 510:	8b 50 04             	mov    0x4(%eax),%edx
 513:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 516:	39 f1                	cmp    %esi,%ecx
 518:	75 dd                	jne    4f7 <free+0x47>
    p->s.size += bp->s.size;
 51a:	03 53 fc             	add    -0x4(%ebx),%edx
 51d:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 520:	8b 53 f8             	mov    -0x8(%ebx),%edx
 523:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 525:	a3 e8 08 00 00       	mov    %eax,0x8e8
}
 52a:	5b                   	pop    %ebx
 52b:	5e                   	pop    %esi
 52c:	5f                   	pop    %edi
 52d:	5d                   	pop    %ebp
 52e:	c3                   	ret    
 52f:	90                   	nop

00000530 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	57                   	push   %edi
 534:	56                   	push   %esi
 535:	53                   	push   %ebx
 536:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 539:	8b 45 08             	mov    0x8(%ebp),%eax
 53c:	8d 78 07             	lea    0x7(%eax),%edi
 53f:	c1 ef 03             	shr    $0x3,%edi
 542:	47                   	inc    %edi
  if((prevp = freep) == 0){
 543:	8b 15 e8 08 00 00    	mov    0x8e8,%edx
 549:	85 d2                	test   %edx,%edx
 54b:	0f 84 b1 00 00 00    	je     602 <malloc+0xd2>
 551:	8b 02                	mov    (%edx),%eax
 553:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 556:	39 cf                	cmp    %ecx,%edi
 558:	76 66                	jbe    5c0 <malloc+0x90>
 55a:	89 fb                	mov    %edi,%ebx
 55c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 562:	0f 82 80 00 00 00    	jb     5e8 <malloc+0xb8>
 568:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 56e:	76 70                	jbe    5e0 <malloc+0xb0>
 570:	8d 34 fd 00 00 00 00 	lea    0x0(,%edi,8),%esi
 577:	eb 0c                	jmp    585 <malloc+0x55>
 579:	8d 76 00             	lea    0x0(%esi),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 57c:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 57e:	8b 48 04             	mov    0x4(%eax),%ecx
 581:	39 cf                	cmp    %ecx,%edi
 583:	76 3b                	jbe    5c0 <malloc+0x90>
 585:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 587:	39 05 e8 08 00 00    	cmp    %eax,0x8e8
 58d:	75 ed                	jne    57c <malloc+0x4c>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 58f:	83 ec 0c             	sub    $0xc,%esp
 592:	56                   	push   %esi
 593:	e8 f7 fc ff ff       	call   28f <sbrk>
  if(p == (char*)-1)
 598:	83 c4 10             	add    $0x10,%esp
 59b:	83 f8 ff             	cmp    $0xffffffff,%eax
 59e:	74 1c                	je     5bc <malloc+0x8c>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 5a0:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 5a3:	83 ec 0c             	sub    $0xc,%esp
 5a6:	83 c0 08             	add    $0x8,%eax
 5a9:	50                   	push   %eax
 5aa:	e8 01 ff ff ff       	call   4b0 <free>
  return freep;
 5af:	8b 15 e8 08 00 00    	mov    0x8e8,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 5b5:	83 c4 10             	add    $0x10,%esp
 5b8:	85 d2                	test   %edx,%edx
 5ba:	75 c0                	jne    57c <malloc+0x4c>
        return 0;
 5bc:	31 c0                	xor    %eax,%eax
 5be:	eb 18                	jmp    5d8 <malloc+0xa8>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 5c0:	39 cf                	cmp    %ecx,%edi
 5c2:	74 38                	je     5fc <malloc+0xcc>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 5c4:	29 f9                	sub    %edi,%ecx
 5c6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 5c9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 5cc:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 5cf:	89 15 e8 08 00 00    	mov    %edx,0x8e8
      return (void*)(p + 1);
 5d5:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 5d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5db:	5b                   	pop    %ebx
 5dc:	5e                   	pop    %esi
 5dd:	5f                   	pop    %edi
 5de:	5d                   	pop    %ebp
 5df:	c3                   	ret    
 5e0:	be 00 80 00 00       	mov    $0x8000,%esi
 5e5:	eb 9e                	jmp    585 <malloc+0x55>
 5e7:	90                   	nop
 5e8:	bb 00 10 00 00       	mov    $0x1000,%ebx
 5ed:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 5f3:	76 eb                	jbe    5e0 <malloc+0xb0>
 5f5:	e9 76 ff ff ff       	jmp    570 <malloc+0x40>
 5fa:	66 90                	xchg   %ax,%ax
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 5fc:	8b 08                	mov    (%eax),%ecx
 5fe:	89 0a                	mov    %ecx,(%edx)
 600:	eb cd                	jmp    5cf <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 602:	c7 05 e8 08 00 00 ec 	movl   $0x8ec,0x8e8
 609:	08 00 00 
 60c:	c7 05 ec 08 00 00 ec 	movl   $0x8ec,0x8ec
 613:	08 00 00 
    base.s.size = 0;
 616:	c7 05 f0 08 00 00 00 	movl   $0x0,0x8f0
 61d:	00 00 00 
 620:	b8 ec 08 00 00       	mov    $0x8ec,%eax
 625:	e9 30 ff ff ff       	jmp    55a <malloc+0x2a>
