
_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 08             	sub    $0x8,%esp
  14:	8b 31                	mov    (%ecx),%esi
  16:	8b 79 04             	mov    0x4(%ecx),%edi
  int i;

  if(argc < 2){
  19:	83 fe 01             	cmp    $0x1,%esi
  1c:	7e 26                	jle    44 <main+0x44>
  1e:	bb 01 00 00 00       	mov    $0x1,%ebx
  23:	90                   	nop
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  24:	83 ec 0c             	sub    $0xc,%esp
  27:	ff 34 9f             	pushl  (%edi,%ebx,4)
  2a:	e8 79 01 00 00       	call   1a8 <atoi>
  2f:	89 04 24             	mov    %eax,(%esp)
  32:	e8 fc 01 00 00       	call   233 <kill>

  if(argc < 2){
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
  37:	43                   	inc    %ebx
  38:	83 c4 10             	add    $0x10,%esp
  3b:	39 de                	cmp    %ebx,%esi
  3d:	75 e5                	jne    24 <main+0x24>
    kill(atoi(argv[i]));
  exit();
  3f:	e8 bf 01 00 00       	call   203 <exit>
main(int argc, char **argv)
{
  int i;

  if(argc < 2){
    printf(2, "usage: kill pid...\n");
  44:	50                   	push   %eax
  45:	50                   	push   %eax
  46:	68 28 06 00 00       	push   $0x628
  4b:	6a 02                	push   $0x2
  4d:	e8 d6 02 00 00       	call   328 <printf>
    exit();
  52:	e8 ac 01 00 00       	call   203 <exit>
  57:	90                   	nop

00000058 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  58:	55                   	push   %ebp
  59:	89 e5                	mov    %esp,%ebp
  5b:	53                   	push   %ebx
  5c:	8b 45 08             	mov    0x8(%ebp),%eax
  5f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  62:	89 c2                	mov    %eax,%edx
  64:	42                   	inc    %edx
  65:	41                   	inc    %ecx
  66:	8a 59 ff             	mov    -0x1(%ecx),%bl
  69:	88 5a ff             	mov    %bl,-0x1(%edx)
  6c:	84 db                	test   %bl,%bl
  6e:	75 f4                	jne    64 <strcpy+0xc>
    ;
  return os;
}
  70:	5b                   	pop    %ebx
  71:	5d                   	pop    %ebp
  72:	c3                   	ret    
  73:	90                   	nop

00000074 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  74:	55                   	push   %ebp
  75:	89 e5                	mov    %esp,%ebp
  77:	56                   	push   %esi
  78:	53                   	push   %ebx
  79:	8b 55 08             	mov    0x8(%ebp),%edx
  7c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  7f:	0f b6 02             	movzbl (%edx),%eax
  82:	0f b6 0b             	movzbl (%ebx),%ecx
  85:	84 c0                	test   %al,%al
  87:	75 14                	jne    9d <strcmp+0x29>
  89:	eb 1d                	jmp    a8 <strcmp+0x34>
  8b:	90                   	nop
    p++, q++;
  8c:	42                   	inc    %edx
  8d:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  90:	0f b6 02             	movzbl (%edx),%eax
  93:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
  97:	84 c0                	test   %al,%al
  99:	74 0d                	je     a8 <strcmp+0x34>
  9b:	89 f3                	mov    %esi,%ebx
  9d:	38 c8                	cmp    %cl,%al
  9f:	74 eb                	je     8c <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  a1:	29 c8                	sub    %ecx,%eax
}
  a3:	5b                   	pop    %ebx
  a4:	5e                   	pop    %esi
  a5:	5d                   	pop    %ebp
  a6:	c3                   	ret    
  a7:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  a8:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
  aa:	29 c8                	sub    %ecx,%eax
}
  ac:	5b                   	pop    %ebx
  ad:	5e                   	pop    %esi
  ae:	5d                   	pop    %ebp
  af:	c3                   	ret    

000000b0 <strlen>:

uint
strlen(const char *s)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  b6:	80 39 00             	cmpb   $0x0,(%ecx)
  b9:	74 10                	je     cb <strlen+0x1b>
  bb:	31 d2                	xor    %edx,%edx
  bd:	8d 76 00             	lea    0x0(%esi),%esi
  c0:	42                   	inc    %edx
  c1:	89 d0                	mov    %edx,%eax
  c3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  c7:	75 f7                	jne    c0 <strlen+0x10>
    ;
  return n;
}
  c9:	5d                   	pop    %ebp
  ca:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
  cb:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
  cd:	5d                   	pop    %ebp
  ce:	c3                   	ret    
  cf:	90                   	nop

000000d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	57                   	push   %edi
  d4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  d7:	89 d7                	mov    %edx,%edi
  d9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  df:	fc                   	cld    
  e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  e2:	89 d0                	mov    %edx,%eax
  e4:	5f                   	pop    %edi
  e5:	5d                   	pop    %ebp
  e6:	c3                   	ret    
  e7:	90                   	nop

000000e8 <strchr>:

char*
strchr(const char *s, char c)
{
  e8:	55                   	push   %ebp
  e9:	89 e5                	mov    %esp,%ebp
  eb:	53                   	push   %ebx
  ec:	8b 45 08             	mov    0x8(%ebp),%eax
  ef:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
  f2:	8a 10                	mov    (%eax),%dl
  f4:	84 d2                	test   %dl,%dl
  f6:	74 13                	je     10b <strchr+0x23>
  f8:	88 d9                	mov    %bl,%cl
    if(*s == c)
  fa:	38 d3                	cmp    %dl,%bl
  fc:	75 06                	jne    104 <strchr+0x1c>
  fe:	eb 0d                	jmp    10d <strchr+0x25>
 100:	38 ca                	cmp    %cl,%dl
 102:	74 09                	je     10d <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 104:	40                   	inc    %eax
 105:	8a 10                	mov    (%eax),%dl
 107:	84 d2                	test   %dl,%dl
 109:	75 f5                	jne    100 <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
 10b:	31 c0                	xor    %eax,%eax
}
 10d:	5b                   	pop    %ebx
 10e:	5d                   	pop    %ebp
 10f:	c3                   	ret    

00000110 <gets>:

char*
gets(char *buf, int max)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	57                   	push   %edi
 114:	56                   	push   %esi
 115:	53                   	push   %ebx
 116:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 119:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 11b:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 11e:	eb 26                	jmp    146 <gets+0x36>
    cc = read(0, &c, 1);
 120:	50                   	push   %eax
 121:	6a 01                	push   $0x1
 123:	57                   	push   %edi
 124:	6a 00                	push   $0x0
 126:	e8 f0 00 00 00       	call   21b <read>
    if(cc < 1)
 12b:	83 c4 10             	add    $0x10,%esp
 12e:	85 c0                	test   %eax,%eax
 130:	7e 1c                	jle    14e <gets+0x3e>
      break;
    buf[i++] = c;
 132:	8a 45 e7             	mov    -0x19(%ebp),%al
 135:	8b 55 08             	mov    0x8(%ebp),%edx
 138:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 13c:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 13e:	3c 0a                	cmp    $0xa,%al
 140:	74 0c                	je     14e <gets+0x3e>
 142:	3c 0d                	cmp    $0xd,%al
 144:	74 08                	je     14e <gets+0x3e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 146:	8d 5e 01             	lea    0x1(%esi),%ebx
 149:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 14c:	7c d2                	jl     120 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 14e:	8b 45 08             	mov    0x8(%ebp),%eax
 151:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 155:	8d 65 f4             	lea    -0xc(%ebp),%esp
 158:	5b                   	pop    %ebx
 159:	5e                   	pop    %esi
 15a:	5f                   	pop    %edi
 15b:	5d                   	pop    %ebp
 15c:	c3                   	ret    
 15d:	8d 76 00             	lea    0x0(%esi),%esi

00000160 <stat>:

int
stat(const char *n, struct stat *st)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	56                   	push   %esi
 164:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 165:	83 ec 08             	sub    $0x8,%esp
 168:	6a 00                	push   $0x0
 16a:	ff 75 08             	pushl  0x8(%ebp)
 16d:	e8 d1 00 00 00       	call   243 <open>
  if(fd < 0)
 172:	83 c4 10             	add    $0x10,%esp
 175:	85 c0                	test   %eax,%eax
 177:	78 27                	js     1a0 <stat+0x40>
 179:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 17b:	83 ec 08             	sub    $0x8,%esp
 17e:	ff 75 0c             	pushl  0xc(%ebp)
 181:	50                   	push   %eax
 182:	e8 d4 00 00 00       	call   25b <fstat>
 187:	89 c6                	mov    %eax,%esi
  close(fd);
 189:	89 1c 24             	mov    %ebx,(%esp)
 18c:	e8 9a 00 00 00       	call   22b <close>
  return r;
 191:	83 c4 10             	add    $0x10,%esp
 194:	89 f0                	mov    %esi,%eax
}
 196:	8d 65 f8             	lea    -0x8(%ebp),%esp
 199:	5b                   	pop    %ebx
 19a:	5e                   	pop    %esi
 19b:	5d                   	pop    %ebp
 19c:	c3                   	ret    
 19d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 1a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1a5:	eb ef                	jmp    196 <stat+0x36>
 1a7:	90                   	nop

000001a8 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 1a8:	55                   	push   %ebp
 1a9:	89 e5                	mov    %esp,%ebp
 1ab:	53                   	push   %ebx
 1ac:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1af:	0f be 11             	movsbl (%ecx),%edx
 1b2:	8d 42 d0             	lea    -0x30(%edx),%eax
 1b5:	3c 09                	cmp    $0x9,%al
 1b7:	b8 00 00 00 00       	mov    $0x0,%eax
 1bc:	77 15                	ja     1d3 <atoi+0x2b>
 1be:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 1c0:	41                   	inc    %ecx
 1c1:	8d 04 80             	lea    (%eax,%eax,4),%eax
 1c4:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1c8:	0f be 11             	movsbl (%ecx),%edx
 1cb:	8d 5a d0             	lea    -0x30(%edx),%ebx
 1ce:	80 fb 09             	cmp    $0x9,%bl
 1d1:	76 ed                	jbe    1c0 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 1d3:	5b                   	pop    %ebx
 1d4:	5d                   	pop    %ebp
 1d5:	c3                   	ret    
 1d6:	66 90                	xchg   %ax,%ax

000001d8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1d8:	55                   	push   %ebp
 1d9:	89 e5                	mov    %esp,%ebp
 1db:	56                   	push   %esi
 1dc:	53                   	push   %ebx
 1dd:	8b 45 08             	mov    0x8(%ebp),%eax
 1e0:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1e3:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1e6:	85 f6                	test   %esi,%esi
 1e8:	7e 0d                	jle    1f7 <memmove+0x1f>
 1ea:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 1ec:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 1ef:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 1f2:	42                   	inc    %edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1f3:	39 f2                	cmp    %esi,%edx
 1f5:	75 f5                	jne    1ec <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 1f7:	5b                   	pop    %ebx
 1f8:	5e                   	pop    %esi
 1f9:	5d                   	pop    %ebp
 1fa:	c3                   	ret    

000001fb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 1fb:	b8 01 00 00 00       	mov    $0x1,%eax
 200:	cd 40                	int    $0x40
 202:	c3                   	ret    

00000203 <exit>:
SYSCALL(exit)
 203:	b8 02 00 00 00       	mov    $0x2,%eax
 208:	cd 40                	int    $0x40
 20a:	c3                   	ret    

0000020b <wait>:
SYSCALL(wait)
 20b:	b8 03 00 00 00       	mov    $0x3,%eax
 210:	cd 40                	int    $0x40
 212:	c3                   	ret    

00000213 <pipe>:
SYSCALL(pipe)
 213:	b8 04 00 00 00       	mov    $0x4,%eax
 218:	cd 40                	int    $0x40
 21a:	c3                   	ret    

0000021b <read>:
SYSCALL(read)
 21b:	b8 05 00 00 00       	mov    $0x5,%eax
 220:	cd 40                	int    $0x40
 222:	c3                   	ret    

00000223 <write>:
SYSCALL(write)
 223:	b8 10 00 00 00       	mov    $0x10,%eax
 228:	cd 40                	int    $0x40
 22a:	c3                   	ret    

0000022b <close>:
SYSCALL(close)
 22b:	b8 15 00 00 00       	mov    $0x15,%eax
 230:	cd 40                	int    $0x40
 232:	c3                   	ret    

00000233 <kill>:
SYSCALL(kill)
 233:	b8 06 00 00 00       	mov    $0x6,%eax
 238:	cd 40                	int    $0x40
 23a:	c3                   	ret    

0000023b <exec>:
SYSCALL(exec)
 23b:	b8 07 00 00 00       	mov    $0x7,%eax
 240:	cd 40                	int    $0x40
 242:	c3                   	ret    

00000243 <open>:
SYSCALL(open)
 243:	b8 0f 00 00 00       	mov    $0xf,%eax
 248:	cd 40                	int    $0x40
 24a:	c3                   	ret    

0000024b <mknod>:
SYSCALL(mknod)
 24b:	b8 11 00 00 00       	mov    $0x11,%eax
 250:	cd 40                	int    $0x40
 252:	c3                   	ret    

00000253 <unlink>:
SYSCALL(unlink)
 253:	b8 12 00 00 00       	mov    $0x12,%eax
 258:	cd 40                	int    $0x40
 25a:	c3                   	ret    

0000025b <fstat>:
SYSCALL(fstat)
 25b:	b8 08 00 00 00       	mov    $0x8,%eax
 260:	cd 40                	int    $0x40
 262:	c3                   	ret    

00000263 <link>:
SYSCALL(link)
 263:	b8 13 00 00 00       	mov    $0x13,%eax
 268:	cd 40                	int    $0x40
 26a:	c3                   	ret    

0000026b <mkdir>:
SYSCALL(mkdir)
 26b:	b8 14 00 00 00       	mov    $0x14,%eax
 270:	cd 40                	int    $0x40
 272:	c3                   	ret    

00000273 <chdir>:
SYSCALL(chdir)
 273:	b8 09 00 00 00       	mov    $0x9,%eax
 278:	cd 40                	int    $0x40
 27a:	c3                   	ret    

0000027b <dup>:
SYSCALL(dup)
 27b:	b8 0a 00 00 00       	mov    $0xa,%eax
 280:	cd 40                	int    $0x40
 282:	c3                   	ret    

00000283 <getpid>:
SYSCALL(getpid)
 283:	b8 0b 00 00 00       	mov    $0xb,%eax
 288:	cd 40                	int    $0x40
 28a:	c3                   	ret    

0000028b <sbrk>:
SYSCALL(sbrk)
 28b:	b8 0c 00 00 00       	mov    $0xc,%eax
 290:	cd 40                	int    $0x40
 292:	c3                   	ret    

00000293 <sleep>:
SYSCALL(sleep)
 293:	b8 0d 00 00 00       	mov    $0xd,%eax
 298:	cd 40                	int    $0x40
 29a:	c3                   	ret    

0000029b <uptime>:
SYSCALL(uptime)
 29b:	b8 0e 00 00 00       	mov    $0xe,%eax
 2a0:	cd 40                	int    $0x40
 2a2:	c3                   	ret    
 2a3:	90                   	nop

000002a4 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 2a4:	55                   	push   %ebp
 2a5:	89 e5                	mov    %esp,%ebp
 2a7:	57                   	push   %edi
 2a8:	56                   	push   %esi
 2a9:	53                   	push   %ebx
 2aa:	83 ec 3c             	sub    $0x3c,%esp
 2ad:	89 c6                	mov    %eax,%esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 2af:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 2b1:	8b 5d 08             	mov    0x8(%ebp),%ebx
 2b4:	85 db                	test   %ebx,%ebx
 2b6:	74 04                	je     2bc <printint+0x18>
 2b8:	85 d2                	test   %edx,%edx
 2ba:	78 5f                	js     31b <printint+0x77>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 2bc:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 2c3:	31 ff                	xor    %edi,%edi
 2c5:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 2c8:	89 75 c4             	mov    %esi,-0x3c(%ebp)
 2cb:	89 ce                	mov    %ecx,%esi
 2cd:	eb 03                	jmp    2d2 <printint+0x2e>
 2cf:	90                   	nop
  do{
    buf[i++] = digits[x % base];
 2d0:	89 cf                	mov    %ecx,%edi
 2d2:	8d 4f 01             	lea    0x1(%edi),%ecx
 2d5:	31 d2                	xor    %edx,%edx
 2d7:	f7 f6                	div    %esi
 2d9:	8a 92 44 06 00 00    	mov    0x644(%edx),%dl
 2df:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 2e2:	85 c0                	test   %eax,%eax
 2e4:	75 ea                	jne    2d0 <printint+0x2c>
 2e6:	8b 75 c4             	mov    -0x3c(%ebp),%esi
  if(neg)
 2e9:	8b 55 c0             	mov    -0x40(%ebp),%edx
 2ec:	85 d2                	test   %edx,%edx
 2ee:	74 08                	je     2f8 <printint+0x54>
    buf[i++] = '-';
 2f0:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 2f5:	8d 4f 02             	lea    0x2(%edi),%ecx
 2f8:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 2fc:	8a 07                	mov    (%edi),%al
 2fe:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 301:	50                   	push   %eax
 302:	6a 01                	push   $0x1
 304:	53                   	push   %ebx
 305:	56                   	push   %esi
 306:	e8 18 ff ff ff       	call   223 <write>
 30b:	4f                   	dec    %edi
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 30c:	83 c4 10             	add    $0x10,%esp
 30f:	39 df                	cmp    %ebx,%edi
 311:	75 e9                	jne    2fc <printint+0x58>
    putc(fd, buf[i]);
}
 313:	8d 65 f4             	lea    -0xc(%ebp),%esp
 316:	5b                   	pop    %ebx
 317:	5e                   	pop    %esi
 318:	5f                   	pop    %edi
 319:	5d                   	pop    %ebp
 31a:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 31b:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 31d:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 324:	eb 9d                	jmp    2c3 <printint+0x1f>
 326:	66 90                	xchg   %ax,%ax

00000328 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 328:	55                   	push   %ebp
 329:	89 e5                	mov    %esp,%ebp
 32b:	57                   	push   %edi
 32c:	56                   	push   %esi
 32d:	53                   	push   %ebx
 32e:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 331:	8b 75 0c             	mov    0xc(%ebp),%esi
 334:	8a 1e                	mov    (%esi),%bl
 336:	84 db                	test   %bl,%bl
 338:	0f 84 a6 00 00 00    	je     3e4 <printf+0xbc>
 33e:	46                   	inc    %esi
 33f:	8d 45 10             	lea    0x10(%ebp),%eax
 342:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 345:	31 ff                	xor    %edi,%edi
 347:	eb 29                	jmp    372 <printf+0x4a>
 349:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 34c:	83 f8 25             	cmp    $0x25,%eax
 34f:	0f 84 97 00 00 00    	je     3ec <printf+0xc4>
 355:	88 5d e2             	mov    %bl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 358:	50                   	push   %eax
 359:	6a 01                	push   $0x1
 35b:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 35e:	50                   	push   %eax
 35f:	ff 75 08             	pushl  0x8(%ebp)
 362:	e8 bc fe ff ff       	call   223 <write>
 367:	83 c4 10             	add    $0x10,%esp
 36a:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 36b:	8a 5e ff             	mov    -0x1(%esi),%bl
 36e:	84 db                	test   %bl,%bl
 370:	74 72                	je     3e4 <printf+0xbc>
    c = fmt[i] & 0xff;
 372:	0f be cb             	movsbl %bl,%ecx
 375:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 378:	85 ff                	test   %edi,%edi
 37a:	74 d0                	je     34c <printf+0x24>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 37c:	83 ff 25             	cmp    $0x25,%edi
 37f:	75 e9                	jne    36a <printf+0x42>
      if(c == 'd'){
 381:	83 f8 64             	cmp    $0x64,%eax
 384:	0f 84 f6 00 00 00    	je     480 <printf+0x158>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 38a:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 390:	83 f9 70             	cmp    $0x70,%ecx
 393:	74 63                	je     3f8 <printf+0xd0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 395:	83 f8 73             	cmp    $0x73,%eax
 398:	0f 84 86 00 00 00    	je     424 <printf+0xfc>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 39e:	83 f8 63             	cmp    $0x63,%eax
 3a1:	0f 84 be 00 00 00    	je     465 <printf+0x13d>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 3a7:	83 f8 25             	cmp    $0x25,%eax
 3aa:	0f 84 e0 00 00 00    	je     490 <printf+0x168>
 3b0:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3b4:	50                   	push   %eax
 3b5:	6a 01                	push   $0x1
 3b7:	8d 45 e7             	lea    -0x19(%ebp),%eax
 3ba:	50                   	push   %eax
 3bb:	ff 75 08             	pushl  0x8(%ebp)
 3be:	e8 60 fe ff ff       	call   223 <write>
 3c3:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 3c6:	83 c4 0c             	add    $0xc,%esp
 3c9:	6a 01                	push   $0x1
 3cb:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 3ce:	50                   	push   %eax
 3cf:	ff 75 08             	pushl  0x8(%ebp)
 3d2:	e8 4c fe ff ff       	call   223 <write>
 3d7:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 3da:	31 ff                	xor    %edi,%edi
 3dc:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3dd:	8a 5e ff             	mov    -0x1(%esi),%bl
 3e0:	84 db                	test   %bl,%bl
 3e2:	75 8e                	jne    372 <printf+0x4a>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 3e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3e7:	5b                   	pop    %ebx
 3e8:	5e                   	pop    %esi
 3e9:	5f                   	pop    %edi
 3ea:	5d                   	pop    %ebp
 3eb:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 3ec:	bf 25 00 00 00       	mov    $0x25,%edi
 3f1:	e9 74 ff ff ff       	jmp    36a <printf+0x42>
 3f6:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 3f8:	83 ec 0c             	sub    $0xc,%esp
 3fb:	6a 00                	push   $0x0
 3fd:	b9 10 00 00 00       	mov    $0x10,%ecx
 402:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 405:	8b 17                	mov    (%edi),%edx
 407:	8b 45 08             	mov    0x8(%ebp),%eax
 40a:	e8 95 fe ff ff       	call   2a4 <printint>
        ap++;
 40f:	89 f8                	mov    %edi,%eax
 411:	83 c0 04             	add    $0x4,%eax
 414:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 417:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 41a:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 41c:	e9 49 ff ff ff       	jmp    36a <printf+0x42>
 421:	8d 76 00             	lea    0x0(%esi),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 424:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 427:	8b 38                	mov    (%eax),%edi
        ap++;
 429:	83 c0 04             	add    $0x4,%eax
 42c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 42f:	85 ff                	test   %edi,%edi
 431:	74 6b                	je     49e <printf+0x176>
          s = "(null)";
        while(*s != 0){
 433:	8a 07                	mov    (%edi),%al
 435:	84 c0                	test   %al,%al
 437:	74 6c                	je     4a5 <printf+0x17d>
 439:	8d 5d e3             	lea    -0x1d(%ebp),%ebx
 43c:	89 75 d0             	mov    %esi,-0x30(%ebp)
 43f:	89 fe                	mov    %edi,%esi
 441:	8b 7d 08             	mov    0x8(%ebp),%edi
 444:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 447:	50                   	push   %eax
 448:	6a 01                	push   $0x1
 44a:	53                   	push   %ebx
 44b:	57                   	push   %edi
 44c:	e8 d2 fd ff ff       	call   223 <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 451:	46                   	inc    %esi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 452:	8a 06                	mov    (%esi),%al
 454:	83 c4 10             	add    $0x10,%esp
 457:	84 c0                	test   %al,%al
 459:	75 e9                	jne    444 <printf+0x11c>
 45b:	8b 75 d0             	mov    -0x30(%ebp),%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 45e:	31 ff                	xor    %edi,%edi
 460:	e9 05 ff ff ff       	jmp    36a <printf+0x42>
 465:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 468:	8b 07                	mov    (%edi),%eax
 46a:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 46d:	51                   	push   %ecx
 46e:	6a 01                	push   $0x1
 470:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 473:	50                   	push   %eax
 474:	ff 75 08             	pushl  0x8(%ebp)
 477:	e8 a7 fd ff ff       	call   223 <write>
 47c:	eb 91                	jmp    40f <printf+0xe7>
 47e:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 480:	83 ec 0c             	sub    $0xc,%esp
 483:	6a 01                	push   $0x1
 485:	b9 0a 00 00 00       	mov    $0xa,%ecx
 48a:	e9 73 ff ff ff       	jmp    402 <printf+0xda>
 48f:	90                   	nop
 490:	88 5d e5             	mov    %bl,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 493:	52                   	push   %edx
 494:	6a 01                	push   $0x1
 496:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 499:	e9 30 ff ff ff       	jmp    3ce <printf+0xa6>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
 49e:	bf 3c 06 00 00       	mov    $0x63c,%edi
 4a3:	eb 8e                	jmp    433 <printf+0x10b>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4a5:	31 ff                	xor    %edi,%edi
 4a7:	e9 be fe ff ff       	jmp    36a <printf+0x42>

000004ac <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 4ac:	55                   	push   %ebp
 4ad:	89 e5                	mov    %esp,%ebp
 4af:	57                   	push   %edi
 4b0:	56                   	push   %esi
 4b1:	53                   	push   %ebx
 4b2:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 4b5:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4b8:	a1 d8 08 00 00       	mov    0x8d8,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4bd:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4bf:	39 c8                	cmp    %ecx,%eax
 4c1:	73 11                	jae    4d4 <free+0x28>
 4c3:	90                   	nop
 4c4:	39 d1                	cmp    %edx,%ecx
 4c6:	72 14                	jb     4dc <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4c8:	39 d0                	cmp    %edx,%eax
 4ca:	73 10                	jae    4dc <free+0x30>
static Header base;
static Header *freep;

void
free(void *ap)
{
 4cc:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4ce:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4d0:	39 c8                	cmp    %ecx,%eax
 4d2:	72 f0                	jb     4c4 <free+0x18>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4d4:	39 d0                	cmp    %edx,%eax
 4d6:	72 f4                	jb     4cc <free+0x20>
 4d8:	39 d1                	cmp    %edx,%ecx
 4da:	73 f0                	jae    4cc <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 4dc:	8b 73 fc             	mov    -0x4(%ebx),%esi
 4df:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 4e2:	39 d7                	cmp    %edx,%edi
 4e4:	74 19                	je     4ff <free+0x53>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 4e6:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 4e9:	8b 50 04             	mov    0x4(%eax),%edx
 4ec:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 4ef:	39 f1                	cmp    %esi,%ecx
 4f1:	74 23                	je     516 <free+0x6a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 4f3:	89 08                	mov    %ecx,(%eax)
  freep = p;
 4f5:	a3 d8 08 00 00       	mov    %eax,0x8d8
}
 4fa:	5b                   	pop    %ebx
 4fb:	5e                   	pop    %esi
 4fc:	5f                   	pop    %edi
 4fd:	5d                   	pop    %ebp
 4fe:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 4ff:	03 72 04             	add    0x4(%edx),%esi
 502:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 505:	8b 10                	mov    (%eax),%edx
 507:	8b 12                	mov    (%edx),%edx
 509:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 50c:	8b 50 04             	mov    0x4(%eax),%edx
 50f:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 512:	39 f1                	cmp    %esi,%ecx
 514:	75 dd                	jne    4f3 <free+0x47>
    p->s.size += bp->s.size;
 516:	03 53 fc             	add    -0x4(%ebx),%edx
 519:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 51c:	8b 53 f8             	mov    -0x8(%ebx),%edx
 51f:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 521:	a3 d8 08 00 00       	mov    %eax,0x8d8
}
 526:	5b                   	pop    %ebx
 527:	5e                   	pop    %esi
 528:	5f                   	pop    %edi
 529:	5d                   	pop    %ebp
 52a:	c3                   	ret    
 52b:	90                   	nop

0000052c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 52c:	55                   	push   %ebp
 52d:	89 e5                	mov    %esp,%ebp
 52f:	57                   	push   %edi
 530:	56                   	push   %esi
 531:	53                   	push   %ebx
 532:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 535:	8b 45 08             	mov    0x8(%ebp),%eax
 538:	8d 78 07             	lea    0x7(%eax),%edi
 53b:	c1 ef 03             	shr    $0x3,%edi
 53e:	47                   	inc    %edi
  if((prevp = freep) == 0){
 53f:	8b 15 d8 08 00 00    	mov    0x8d8,%edx
 545:	85 d2                	test   %edx,%edx
 547:	0f 84 b1 00 00 00    	je     5fe <malloc+0xd2>
 54d:	8b 02                	mov    (%edx),%eax
 54f:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 552:	39 cf                	cmp    %ecx,%edi
 554:	76 66                	jbe    5bc <malloc+0x90>
 556:	89 fb                	mov    %edi,%ebx
 558:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 55e:	0f 82 80 00 00 00    	jb     5e4 <malloc+0xb8>
 564:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 56a:	76 70                	jbe    5dc <malloc+0xb0>
 56c:	8d 34 fd 00 00 00 00 	lea    0x0(,%edi,8),%esi
 573:	eb 0c                	jmp    581 <malloc+0x55>
 575:	8d 76 00             	lea    0x0(%esi),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 578:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 57a:	8b 48 04             	mov    0x4(%eax),%ecx
 57d:	39 cf                	cmp    %ecx,%edi
 57f:	76 3b                	jbe    5bc <malloc+0x90>
 581:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 583:	39 05 d8 08 00 00    	cmp    %eax,0x8d8
 589:	75 ed                	jne    578 <malloc+0x4c>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 58b:	83 ec 0c             	sub    $0xc,%esp
 58e:	56                   	push   %esi
 58f:	e8 f7 fc ff ff       	call   28b <sbrk>
  if(p == (char*)-1)
 594:	83 c4 10             	add    $0x10,%esp
 597:	83 f8 ff             	cmp    $0xffffffff,%eax
 59a:	74 1c                	je     5b8 <malloc+0x8c>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 59c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 59f:	83 ec 0c             	sub    $0xc,%esp
 5a2:	83 c0 08             	add    $0x8,%eax
 5a5:	50                   	push   %eax
 5a6:	e8 01 ff ff ff       	call   4ac <free>
  return freep;
 5ab:	8b 15 d8 08 00 00    	mov    0x8d8,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 5b1:	83 c4 10             	add    $0x10,%esp
 5b4:	85 d2                	test   %edx,%edx
 5b6:	75 c0                	jne    578 <malloc+0x4c>
        return 0;
 5b8:	31 c0                	xor    %eax,%eax
 5ba:	eb 18                	jmp    5d4 <malloc+0xa8>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 5bc:	39 cf                	cmp    %ecx,%edi
 5be:	74 38                	je     5f8 <malloc+0xcc>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 5c0:	29 f9                	sub    %edi,%ecx
 5c2:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 5c5:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 5c8:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 5cb:	89 15 d8 08 00 00    	mov    %edx,0x8d8
      return (void*)(p + 1);
 5d1:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 5d4:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5d7:	5b                   	pop    %ebx
 5d8:	5e                   	pop    %esi
 5d9:	5f                   	pop    %edi
 5da:	5d                   	pop    %ebp
 5db:	c3                   	ret    
 5dc:	be 00 80 00 00       	mov    $0x8000,%esi
 5e1:	eb 9e                	jmp    581 <malloc+0x55>
 5e3:	90                   	nop
 5e4:	bb 00 10 00 00       	mov    $0x1000,%ebx
 5e9:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 5ef:	76 eb                	jbe    5dc <malloc+0xb0>
 5f1:	e9 76 ff ff ff       	jmp    56c <malloc+0x40>
 5f6:	66 90                	xchg   %ax,%ax
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 5f8:	8b 08                	mov    (%eax),%ecx
 5fa:	89 0a                	mov    %ecx,(%edx)
 5fc:	eb cd                	jmp    5cb <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 5fe:	c7 05 d8 08 00 00 dc 	movl   $0x8dc,0x8d8
 605:	08 00 00 
 608:	c7 05 dc 08 00 00 dc 	movl   $0x8dc,0x8dc
 60f:	08 00 00 
    base.s.size = 0;
 612:	c7 05 e0 08 00 00 00 	movl   $0x0,0x8e0
 619:	00 00 00 
 61c:	b8 dc 08 00 00       	mov    $0x8dc,%eax
 621:	e9 30 ff ff ff       	jmp    556 <malloc+0x2a>
