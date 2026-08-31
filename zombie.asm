
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	50                   	push   %eax
  if(fork() > 0)
   f:	e8 bb 01 00 00       	call   1cf <fork>
  14:	85 c0                	test   %eax,%eax
  16:	7e 0d                	jle    25 <main+0x25>
    sleep(5);  // Let child exit before parent.
  18:	83 ec 0c             	sub    $0xc,%esp
  1b:	6a 05                	push   $0x5
  1d:	e8 45 02 00 00       	call   267 <sleep>
  22:	83 c4 10             	add    $0x10,%esp
  exit();
  25:	e8 ad 01 00 00       	call   1d7 <exit>
  2a:	66 90                	xchg   %ax,%ax

0000002c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  2c:	55                   	push   %ebp
  2d:	89 e5                	mov    %esp,%ebp
  2f:	53                   	push   %ebx
  30:	8b 45 08             	mov    0x8(%ebp),%eax
  33:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  36:	89 c2                	mov    %eax,%edx
  38:	42                   	inc    %edx
  39:	41                   	inc    %ecx
  3a:	8a 59 ff             	mov    -0x1(%ecx),%bl
  3d:	88 5a ff             	mov    %bl,-0x1(%edx)
  40:	84 db                	test   %bl,%bl
  42:	75 f4                	jne    38 <strcpy+0xc>
    ;
  return os;
}
  44:	5b                   	pop    %ebx
  45:	5d                   	pop    %ebp
  46:	c3                   	ret    
  47:	90                   	nop

00000048 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  48:	55                   	push   %ebp
  49:	89 e5                	mov    %esp,%ebp
  4b:	56                   	push   %esi
  4c:	53                   	push   %ebx
  4d:	8b 55 08             	mov    0x8(%ebp),%edx
  50:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  53:	0f b6 02             	movzbl (%edx),%eax
  56:	0f b6 0b             	movzbl (%ebx),%ecx
  59:	84 c0                	test   %al,%al
  5b:	75 14                	jne    71 <strcmp+0x29>
  5d:	eb 1d                	jmp    7c <strcmp+0x34>
  5f:	90                   	nop
    p++, q++;
  60:	42                   	inc    %edx
  61:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  64:	0f b6 02             	movzbl (%edx),%eax
  67:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
  6b:	84 c0                	test   %al,%al
  6d:	74 0d                	je     7c <strcmp+0x34>
  6f:	89 f3                	mov    %esi,%ebx
  71:	38 c8                	cmp    %cl,%al
  73:	74 eb                	je     60 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  75:	29 c8                	sub    %ecx,%eax
}
  77:	5b                   	pop    %ebx
  78:	5e                   	pop    %esi
  79:	5d                   	pop    %ebp
  7a:	c3                   	ret    
  7b:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  7c:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
  7e:	29 c8                	sub    %ecx,%eax
}
  80:	5b                   	pop    %ebx
  81:	5e                   	pop    %esi
  82:	5d                   	pop    %ebp
  83:	c3                   	ret    

00000084 <strlen>:

uint
strlen(const char *s)
{
  84:	55                   	push   %ebp
  85:	89 e5                	mov    %esp,%ebp
  87:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  8a:	80 39 00             	cmpb   $0x0,(%ecx)
  8d:	74 10                	je     9f <strlen+0x1b>
  8f:	31 d2                	xor    %edx,%edx
  91:	8d 76 00             	lea    0x0(%esi),%esi
  94:	42                   	inc    %edx
  95:	89 d0                	mov    %edx,%eax
  97:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  9b:	75 f7                	jne    94 <strlen+0x10>
    ;
  return n;
}
  9d:	5d                   	pop    %ebp
  9e:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
  9f:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
  a1:	5d                   	pop    %ebp
  a2:	c3                   	ret    
  a3:	90                   	nop

000000a4 <memset>:

void*
memset(void *dst, int c, uint n)
{
  a4:	55                   	push   %ebp
  a5:	89 e5                	mov    %esp,%ebp
  a7:	57                   	push   %edi
  a8:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  ab:	89 d7                	mov    %edx,%edi
  ad:	8b 4d 10             	mov    0x10(%ebp),%ecx
  b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  b3:	fc                   	cld    
  b4:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  b6:	89 d0                	mov    %edx,%eax
  b8:	5f                   	pop    %edi
  b9:	5d                   	pop    %ebp
  ba:	c3                   	ret    
  bb:	90                   	nop

000000bc <strchr>:

char*
strchr(const char *s, char c)
{
  bc:	55                   	push   %ebp
  bd:	89 e5                	mov    %esp,%ebp
  bf:	53                   	push   %ebx
  c0:	8b 45 08             	mov    0x8(%ebp),%eax
  c3:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
  c6:	8a 10                	mov    (%eax),%dl
  c8:	84 d2                	test   %dl,%dl
  ca:	74 13                	je     df <strchr+0x23>
  cc:	88 d9                	mov    %bl,%cl
    if(*s == c)
  ce:	38 d3                	cmp    %dl,%bl
  d0:	75 06                	jne    d8 <strchr+0x1c>
  d2:	eb 0d                	jmp    e1 <strchr+0x25>
  d4:	38 ca                	cmp    %cl,%dl
  d6:	74 09                	je     e1 <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
  d8:	40                   	inc    %eax
  d9:	8a 10                	mov    (%eax),%dl
  db:	84 d2                	test   %dl,%dl
  dd:	75 f5                	jne    d4 <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
  df:	31 c0                	xor    %eax,%eax
}
  e1:	5b                   	pop    %ebx
  e2:	5d                   	pop    %ebp
  e3:	c3                   	ret    

000000e4 <gets>:

char*
gets(char *buf, int max)
{
  e4:	55                   	push   %ebp
  e5:	89 e5                	mov    %esp,%ebp
  e7:	57                   	push   %edi
  e8:	56                   	push   %esi
  e9:	53                   	push   %ebx
  ea:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
  ed:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
  ef:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
  f2:	eb 26                	jmp    11a <gets+0x36>
    cc = read(0, &c, 1);
  f4:	50                   	push   %eax
  f5:	6a 01                	push   $0x1
  f7:	57                   	push   %edi
  f8:	6a 00                	push   $0x0
  fa:	e8 f0 00 00 00       	call   1ef <read>
    if(cc < 1)
  ff:	83 c4 10             	add    $0x10,%esp
 102:	85 c0                	test   %eax,%eax
 104:	7e 1c                	jle    122 <gets+0x3e>
      break;
    buf[i++] = c;
 106:	8a 45 e7             	mov    -0x19(%ebp),%al
 109:	8b 55 08             	mov    0x8(%ebp),%edx
 10c:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 110:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 112:	3c 0a                	cmp    $0xa,%al
 114:	74 0c                	je     122 <gets+0x3e>
 116:	3c 0d                	cmp    $0xd,%al
 118:	74 08                	je     122 <gets+0x3e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 11a:	8d 5e 01             	lea    0x1(%esi),%ebx
 11d:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 120:	7c d2                	jl     f4 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 122:	8b 45 08             	mov    0x8(%ebp),%eax
 125:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 129:	8d 65 f4             	lea    -0xc(%ebp),%esp
 12c:	5b                   	pop    %ebx
 12d:	5e                   	pop    %esi
 12e:	5f                   	pop    %edi
 12f:	5d                   	pop    %ebp
 130:	c3                   	ret    
 131:	8d 76 00             	lea    0x0(%esi),%esi

00000134 <stat>:

int
stat(const char *n, struct stat *st)
{
 134:	55                   	push   %ebp
 135:	89 e5                	mov    %esp,%ebp
 137:	56                   	push   %esi
 138:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 139:	83 ec 08             	sub    $0x8,%esp
 13c:	6a 00                	push   $0x0
 13e:	ff 75 08             	pushl  0x8(%ebp)
 141:	e8 d1 00 00 00       	call   217 <open>
  if(fd < 0)
 146:	83 c4 10             	add    $0x10,%esp
 149:	85 c0                	test   %eax,%eax
 14b:	78 27                	js     174 <stat+0x40>
 14d:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 14f:	83 ec 08             	sub    $0x8,%esp
 152:	ff 75 0c             	pushl  0xc(%ebp)
 155:	50                   	push   %eax
 156:	e8 d4 00 00 00       	call   22f <fstat>
 15b:	89 c6                	mov    %eax,%esi
  close(fd);
 15d:	89 1c 24             	mov    %ebx,(%esp)
 160:	e8 9a 00 00 00       	call   1ff <close>
  return r;
 165:	83 c4 10             	add    $0x10,%esp
 168:	89 f0                	mov    %esi,%eax
}
 16a:	8d 65 f8             	lea    -0x8(%ebp),%esp
 16d:	5b                   	pop    %ebx
 16e:	5e                   	pop    %esi
 16f:	5d                   	pop    %ebp
 170:	c3                   	ret    
 171:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 174:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 179:	eb ef                	jmp    16a <stat+0x36>
 17b:	90                   	nop

0000017c <atoi>:
  return r;
}

int
atoi(const char *s)
{
 17c:	55                   	push   %ebp
 17d:	89 e5                	mov    %esp,%ebp
 17f:	53                   	push   %ebx
 180:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 183:	0f be 11             	movsbl (%ecx),%edx
 186:	8d 42 d0             	lea    -0x30(%edx),%eax
 189:	3c 09                	cmp    $0x9,%al
 18b:	b8 00 00 00 00       	mov    $0x0,%eax
 190:	77 15                	ja     1a7 <atoi+0x2b>
 192:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 194:	41                   	inc    %ecx
 195:	8d 04 80             	lea    (%eax,%eax,4),%eax
 198:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 19c:	0f be 11             	movsbl (%ecx),%edx
 19f:	8d 5a d0             	lea    -0x30(%edx),%ebx
 1a2:	80 fb 09             	cmp    $0x9,%bl
 1a5:	76 ed                	jbe    194 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 1a7:	5b                   	pop    %ebx
 1a8:	5d                   	pop    %ebp
 1a9:	c3                   	ret    
 1aa:	66 90                	xchg   %ax,%ax

000001ac <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1ac:	55                   	push   %ebp
 1ad:	89 e5                	mov    %esp,%ebp
 1af:	56                   	push   %esi
 1b0:	53                   	push   %ebx
 1b1:	8b 45 08             	mov    0x8(%ebp),%eax
 1b4:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1b7:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1ba:	85 f6                	test   %esi,%esi
 1bc:	7e 0d                	jle    1cb <memmove+0x1f>
 1be:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 1c0:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 1c3:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 1c6:	42                   	inc    %edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1c7:	39 f2                	cmp    %esi,%edx
 1c9:	75 f5                	jne    1c0 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 1cb:	5b                   	pop    %ebx
 1cc:	5e                   	pop    %esi
 1cd:	5d                   	pop    %ebp
 1ce:	c3                   	ret    

000001cf <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 1cf:	b8 01 00 00 00       	mov    $0x1,%eax
 1d4:	cd 40                	int    $0x40
 1d6:	c3                   	ret    

000001d7 <exit>:
SYSCALL(exit)
 1d7:	b8 02 00 00 00       	mov    $0x2,%eax
 1dc:	cd 40                	int    $0x40
 1de:	c3                   	ret    

000001df <wait>:
SYSCALL(wait)
 1df:	b8 03 00 00 00       	mov    $0x3,%eax
 1e4:	cd 40                	int    $0x40
 1e6:	c3                   	ret    

000001e7 <pipe>:
SYSCALL(pipe)
 1e7:	b8 04 00 00 00       	mov    $0x4,%eax
 1ec:	cd 40                	int    $0x40
 1ee:	c3                   	ret    

000001ef <read>:
SYSCALL(read)
 1ef:	b8 05 00 00 00       	mov    $0x5,%eax
 1f4:	cd 40                	int    $0x40
 1f6:	c3                   	ret    

000001f7 <write>:
SYSCALL(write)
 1f7:	b8 10 00 00 00       	mov    $0x10,%eax
 1fc:	cd 40                	int    $0x40
 1fe:	c3                   	ret    

000001ff <close>:
SYSCALL(close)
 1ff:	b8 15 00 00 00       	mov    $0x15,%eax
 204:	cd 40                	int    $0x40
 206:	c3                   	ret    

00000207 <kill>:
SYSCALL(kill)
 207:	b8 06 00 00 00       	mov    $0x6,%eax
 20c:	cd 40                	int    $0x40
 20e:	c3                   	ret    

0000020f <exec>:
SYSCALL(exec)
 20f:	b8 07 00 00 00       	mov    $0x7,%eax
 214:	cd 40                	int    $0x40
 216:	c3                   	ret    

00000217 <open>:
SYSCALL(open)
 217:	b8 0f 00 00 00       	mov    $0xf,%eax
 21c:	cd 40                	int    $0x40
 21e:	c3                   	ret    

0000021f <mknod>:
SYSCALL(mknod)
 21f:	b8 11 00 00 00       	mov    $0x11,%eax
 224:	cd 40                	int    $0x40
 226:	c3                   	ret    

00000227 <unlink>:
SYSCALL(unlink)
 227:	b8 12 00 00 00       	mov    $0x12,%eax
 22c:	cd 40                	int    $0x40
 22e:	c3                   	ret    

0000022f <fstat>:
SYSCALL(fstat)
 22f:	b8 08 00 00 00       	mov    $0x8,%eax
 234:	cd 40                	int    $0x40
 236:	c3                   	ret    

00000237 <link>:
SYSCALL(link)
 237:	b8 13 00 00 00       	mov    $0x13,%eax
 23c:	cd 40                	int    $0x40
 23e:	c3                   	ret    

0000023f <mkdir>:
SYSCALL(mkdir)
 23f:	b8 14 00 00 00       	mov    $0x14,%eax
 244:	cd 40                	int    $0x40
 246:	c3                   	ret    

00000247 <chdir>:
SYSCALL(chdir)
 247:	b8 09 00 00 00       	mov    $0x9,%eax
 24c:	cd 40                	int    $0x40
 24e:	c3                   	ret    

0000024f <dup>:
SYSCALL(dup)
 24f:	b8 0a 00 00 00       	mov    $0xa,%eax
 254:	cd 40                	int    $0x40
 256:	c3                   	ret    

00000257 <getpid>:
SYSCALL(getpid)
 257:	b8 0b 00 00 00       	mov    $0xb,%eax
 25c:	cd 40                	int    $0x40
 25e:	c3                   	ret    

0000025f <sbrk>:
SYSCALL(sbrk)
 25f:	b8 0c 00 00 00       	mov    $0xc,%eax
 264:	cd 40                	int    $0x40
 266:	c3                   	ret    

00000267 <sleep>:
SYSCALL(sleep)
 267:	b8 0d 00 00 00       	mov    $0xd,%eax
 26c:	cd 40                	int    $0x40
 26e:	c3                   	ret    

0000026f <uptime>:
SYSCALL(uptime)
 26f:	b8 0e 00 00 00       	mov    $0xe,%eax
 274:	cd 40                	int    $0x40
 276:	c3                   	ret    
 277:	90                   	nop

00000278 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 278:	55                   	push   %ebp
 279:	89 e5                	mov    %esp,%ebp
 27b:	57                   	push   %edi
 27c:	56                   	push   %esi
 27d:	53                   	push   %ebx
 27e:	83 ec 3c             	sub    $0x3c,%esp
 281:	89 c6                	mov    %eax,%esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 283:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 285:	8b 5d 08             	mov    0x8(%ebp),%ebx
 288:	85 db                	test   %ebx,%ebx
 28a:	74 04                	je     290 <printint+0x18>
 28c:	85 d2                	test   %edx,%edx
 28e:	78 5f                	js     2ef <printint+0x77>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 290:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 297:	31 ff                	xor    %edi,%edi
 299:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 29c:	89 75 c4             	mov    %esi,-0x3c(%ebp)
 29f:	89 ce                	mov    %ecx,%esi
 2a1:	eb 03                	jmp    2a6 <printint+0x2e>
 2a3:	90                   	nop
  do{
    buf[i++] = digits[x % base];
 2a4:	89 cf                	mov    %ecx,%edi
 2a6:	8d 4f 01             	lea    0x1(%edi),%ecx
 2a9:	31 d2                	xor    %edx,%edx
 2ab:	f7 f6                	div    %esi
 2ad:	8a 92 04 06 00 00    	mov    0x604(%edx),%dl
 2b3:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 2b6:	85 c0                	test   %eax,%eax
 2b8:	75 ea                	jne    2a4 <printint+0x2c>
 2ba:	8b 75 c4             	mov    -0x3c(%ebp),%esi
  if(neg)
 2bd:	8b 55 c0             	mov    -0x40(%ebp),%edx
 2c0:	85 d2                	test   %edx,%edx
 2c2:	74 08                	je     2cc <printint+0x54>
    buf[i++] = '-';
 2c4:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 2c9:	8d 4f 02             	lea    0x2(%edi),%ecx
 2cc:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 2d0:	8a 07                	mov    (%edi),%al
 2d2:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 2d5:	50                   	push   %eax
 2d6:	6a 01                	push   $0x1
 2d8:	53                   	push   %ebx
 2d9:	56                   	push   %esi
 2da:	e8 18 ff ff ff       	call   1f7 <write>
 2df:	4f                   	dec    %edi
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 2e0:	83 c4 10             	add    $0x10,%esp
 2e3:	39 df                	cmp    %ebx,%edi
 2e5:	75 e9                	jne    2d0 <printint+0x58>
    putc(fd, buf[i]);
}
 2e7:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2ea:	5b                   	pop    %ebx
 2eb:	5e                   	pop    %esi
 2ec:	5f                   	pop    %edi
 2ed:	5d                   	pop    %ebp
 2ee:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 2ef:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 2f1:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 2f8:	eb 9d                	jmp    297 <printint+0x1f>
 2fa:	66 90                	xchg   %ax,%ax

000002fc <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 2fc:	55                   	push   %ebp
 2fd:	89 e5                	mov    %esp,%ebp
 2ff:	57                   	push   %edi
 300:	56                   	push   %esi
 301:	53                   	push   %ebx
 302:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 305:	8b 75 0c             	mov    0xc(%ebp),%esi
 308:	8a 1e                	mov    (%esi),%bl
 30a:	84 db                	test   %bl,%bl
 30c:	0f 84 a6 00 00 00    	je     3b8 <printf+0xbc>
 312:	46                   	inc    %esi
 313:	8d 45 10             	lea    0x10(%ebp),%eax
 316:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 319:	31 ff                	xor    %edi,%edi
 31b:	eb 29                	jmp    346 <printf+0x4a>
 31d:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 320:	83 f8 25             	cmp    $0x25,%eax
 323:	0f 84 97 00 00 00    	je     3c0 <printf+0xc4>
 329:	88 5d e2             	mov    %bl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 32c:	50                   	push   %eax
 32d:	6a 01                	push   $0x1
 32f:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 332:	50                   	push   %eax
 333:	ff 75 08             	pushl  0x8(%ebp)
 336:	e8 bc fe ff ff       	call   1f7 <write>
 33b:	83 c4 10             	add    $0x10,%esp
 33e:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 33f:	8a 5e ff             	mov    -0x1(%esi),%bl
 342:	84 db                	test   %bl,%bl
 344:	74 72                	je     3b8 <printf+0xbc>
    c = fmt[i] & 0xff;
 346:	0f be cb             	movsbl %bl,%ecx
 349:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 34c:	85 ff                	test   %edi,%edi
 34e:	74 d0                	je     320 <printf+0x24>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 350:	83 ff 25             	cmp    $0x25,%edi
 353:	75 e9                	jne    33e <printf+0x42>
      if(c == 'd'){
 355:	83 f8 64             	cmp    $0x64,%eax
 358:	0f 84 f6 00 00 00    	je     454 <printf+0x158>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 35e:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 364:	83 f9 70             	cmp    $0x70,%ecx
 367:	74 63                	je     3cc <printf+0xd0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 369:	83 f8 73             	cmp    $0x73,%eax
 36c:	0f 84 86 00 00 00    	je     3f8 <printf+0xfc>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 372:	83 f8 63             	cmp    $0x63,%eax
 375:	0f 84 be 00 00 00    	je     439 <printf+0x13d>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 37b:	83 f8 25             	cmp    $0x25,%eax
 37e:	0f 84 e0 00 00 00    	je     464 <printf+0x168>
 384:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 388:	50                   	push   %eax
 389:	6a 01                	push   $0x1
 38b:	8d 45 e7             	lea    -0x19(%ebp),%eax
 38e:	50                   	push   %eax
 38f:	ff 75 08             	pushl  0x8(%ebp)
 392:	e8 60 fe ff ff       	call   1f7 <write>
 397:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 39a:	83 c4 0c             	add    $0xc,%esp
 39d:	6a 01                	push   $0x1
 39f:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 3a2:	50                   	push   %eax
 3a3:	ff 75 08             	pushl  0x8(%ebp)
 3a6:	e8 4c fe ff ff       	call   1f7 <write>
 3ab:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 3ae:	31 ff                	xor    %edi,%edi
 3b0:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3b1:	8a 5e ff             	mov    -0x1(%esi),%bl
 3b4:	84 db                	test   %bl,%bl
 3b6:	75 8e                	jne    346 <printf+0x4a>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 3b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3bb:	5b                   	pop    %ebx
 3bc:	5e                   	pop    %esi
 3bd:	5f                   	pop    %edi
 3be:	5d                   	pop    %ebp
 3bf:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 3c0:	bf 25 00 00 00       	mov    $0x25,%edi
 3c5:	e9 74 ff ff ff       	jmp    33e <printf+0x42>
 3ca:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 3cc:	83 ec 0c             	sub    $0xc,%esp
 3cf:	6a 00                	push   $0x0
 3d1:	b9 10 00 00 00       	mov    $0x10,%ecx
 3d6:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 3d9:	8b 17                	mov    (%edi),%edx
 3db:	8b 45 08             	mov    0x8(%ebp),%eax
 3de:	e8 95 fe ff ff       	call   278 <printint>
        ap++;
 3e3:	89 f8                	mov    %edi,%eax
 3e5:	83 c0 04             	add    $0x4,%eax
 3e8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 3eb:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 3ee:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 3f0:	e9 49 ff ff ff       	jmp    33e <printf+0x42>
 3f5:	8d 76 00             	lea    0x0(%esi),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 3f8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 3fb:	8b 38                	mov    (%eax),%edi
        ap++;
 3fd:	83 c0 04             	add    $0x4,%eax
 400:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 403:	85 ff                	test   %edi,%edi
 405:	74 6b                	je     472 <printf+0x176>
          s = "(null)";
        while(*s != 0){
 407:	8a 07                	mov    (%edi),%al
 409:	84 c0                	test   %al,%al
 40b:	74 6c                	je     479 <printf+0x17d>
 40d:	8d 5d e3             	lea    -0x1d(%ebp),%ebx
 410:	89 75 d0             	mov    %esi,-0x30(%ebp)
 413:	89 fe                	mov    %edi,%esi
 415:	8b 7d 08             	mov    0x8(%ebp),%edi
 418:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 41b:	50                   	push   %eax
 41c:	6a 01                	push   $0x1
 41e:	53                   	push   %ebx
 41f:	57                   	push   %edi
 420:	e8 d2 fd ff ff       	call   1f7 <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 425:	46                   	inc    %esi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 426:	8a 06                	mov    (%esi),%al
 428:	83 c4 10             	add    $0x10,%esp
 42b:	84 c0                	test   %al,%al
 42d:	75 e9                	jne    418 <printf+0x11c>
 42f:	8b 75 d0             	mov    -0x30(%ebp),%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 432:	31 ff                	xor    %edi,%edi
 434:	e9 05 ff ff ff       	jmp    33e <printf+0x42>
 439:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 43c:	8b 07                	mov    (%edi),%eax
 43e:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 441:	51                   	push   %ecx
 442:	6a 01                	push   $0x1
 444:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 447:	50                   	push   %eax
 448:	ff 75 08             	pushl  0x8(%ebp)
 44b:	e8 a7 fd ff ff       	call   1f7 <write>
 450:	eb 91                	jmp    3e3 <printf+0xe7>
 452:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 454:	83 ec 0c             	sub    $0xc,%esp
 457:	6a 01                	push   $0x1
 459:	b9 0a 00 00 00       	mov    $0xa,%ecx
 45e:	e9 73 ff ff ff       	jmp    3d6 <printf+0xda>
 463:	90                   	nop
 464:	88 5d e5             	mov    %bl,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 467:	52                   	push   %edx
 468:	6a 01                	push   $0x1
 46a:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 46d:	e9 30 ff ff ff       	jmp    3a2 <printf+0xa6>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
 472:	bf fc 05 00 00       	mov    $0x5fc,%edi
 477:	eb 8e                	jmp    407 <printf+0x10b>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 479:	31 ff                	xor    %edi,%edi
 47b:	e9 be fe ff ff       	jmp    33e <printf+0x42>

00000480 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	57                   	push   %edi
 484:	56                   	push   %esi
 485:	53                   	push   %ebx
 486:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 489:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 48c:	a1 8c 08 00 00       	mov    0x88c,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 491:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 493:	39 c8                	cmp    %ecx,%eax
 495:	73 11                	jae    4a8 <free+0x28>
 497:	90                   	nop
 498:	39 d1                	cmp    %edx,%ecx
 49a:	72 14                	jb     4b0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 49c:	39 d0                	cmp    %edx,%eax
 49e:	73 10                	jae    4b0 <free+0x30>
static Header base;
static Header *freep;

void
free(void *ap)
{
 4a0:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4a2:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4a4:	39 c8                	cmp    %ecx,%eax
 4a6:	72 f0                	jb     498 <free+0x18>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4a8:	39 d0                	cmp    %edx,%eax
 4aa:	72 f4                	jb     4a0 <free+0x20>
 4ac:	39 d1                	cmp    %edx,%ecx
 4ae:	73 f0                	jae    4a0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 4b0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 4b3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 4b6:	39 d7                	cmp    %edx,%edi
 4b8:	74 19                	je     4d3 <free+0x53>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 4ba:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 4bd:	8b 50 04             	mov    0x4(%eax),%edx
 4c0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 4c3:	39 f1                	cmp    %esi,%ecx
 4c5:	74 23                	je     4ea <free+0x6a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 4c7:	89 08                	mov    %ecx,(%eax)
  freep = p;
 4c9:	a3 8c 08 00 00       	mov    %eax,0x88c
}
 4ce:	5b                   	pop    %ebx
 4cf:	5e                   	pop    %esi
 4d0:	5f                   	pop    %edi
 4d1:	5d                   	pop    %ebp
 4d2:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 4d3:	03 72 04             	add    0x4(%edx),%esi
 4d6:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 4d9:	8b 10                	mov    (%eax),%edx
 4db:	8b 12                	mov    (%edx),%edx
 4dd:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 4e0:	8b 50 04             	mov    0x4(%eax),%edx
 4e3:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 4e6:	39 f1                	cmp    %esi,%ecx
 4e8:	75 dd                	jne    4c7 <free+0x47>
    p->s.size += bp->s.size;
 4ea:	03 53 fc             	add    -0x4(%ebx),%edx
 4ed:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 4f0:	8b 53 f8             	mov    -0x8(%ebx),%edx
 4f3:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 4f5:	a3 8c 08 00 00       	mov    %eax,0x88c
}
 4fa:	5b                   	pop    %ebx
 4fb:	5e                   	pop    %esi
 4fc:	5f                   	pop    %edi
 4fd:	5d                   	pop    %ebp
 4fe:	c3                   	ret    
 4ff:	90                   	nop

00000500 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 500:	55                   	push   %ebp
 501:	89 e5                	mov    %esp,%ebp
 503:	57                   	push   %edi
 504:	56                   	push   %esi
 505:	53                   	push   %ebx
 506:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 509:	8b 45 08             	mov    0x8(%ebp),%eax
 50c:	8d 78 07             	lea    0x7(%eax),%edi
 50f:	c1 ef 03             	shr    $0x3,%edi
 512:	47                   	inc    %edi
  if((prevp = freep) == 0){
 513:	8b 15 8c 08 00 00    	mov    0x88c,%edx
 519:	85 d2                	test   %edx,%edx
 51b:	0f 84 b1 00 00 00    	je     5d2 <malloc+0xd2>
 521:	8b 02                	mov    (%edx),%eax
 523:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 526:	39 cf                	cmp    %ecx,%edi
 528:	76 66                	jbe    590 <malloc+0x90>
 52a:	89 fb                	mov    %edi,%ebx
 52c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 532:	0f 82 80 00 00 00    	jb     5b8 <malloc+0xb8>
 538:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 53e:	76 70                	jbe    5b0 <malloc+0xb0>
 540:	8d 34 fd 00 00 00 00 	lea    0x0(,%edi,8),%esi
 547:	eb 0c                	jmp    555 <malloc+0x55>
 549:	8d 76 00             	lea    0x0(%esi),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 54c:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 54e:	8b 48 04             	mov    0x4(%eax),%ecx
 551:	39 cf                	cmp    %ecx,%edi
 553:	76 3b                	jbe    590 <malloc+0x90>
 555:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 557:	39 05 8c 08 00 00    	cmp    %eax,0x88c
 55d:	75 ed                	jne    54c <malloc+0x4c>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 55f:	83 ec 0c             	sub    $0xc,%esp
 562:	56                   	push   %esi
 563:	e8 f7 fc ff ff       	call   25f <sbrk>
  if(p == (char*)-1)
 568:	83 c4 10             	add    $0x10,%esp
 56b:	83 f8 ff             	cmp    $0xffffffff,%eax
 56e:	74 1c                	je     58c <malloc+0x8c>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 570:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 573:	83 ec 0c             	sub    $0xc,%esp
 576:	83 c0 08             	add    $0x8,%eax
 579:	50                   	push   %eax
 57a:	e8 01 ff ff ff       	call   480 <free>
  return freep;
 57f:	8b 15 8c 08 00 00    	mov    0x88c,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 585:	83 c4 10             	add    $0x10,%esp
 588:	85 d2                	test   %edx,%edx
 58a:	75 c0                	jne    54c <malloc+0x4c>
        return 0;
 58c:	31 c0                	xor    %eax,%eax
 58e:	eb 18                	jmp    5a8 <malloc+0xa8>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 590:	39 cf                	cmp    %ecx,%edi
 592:	74 38                	je     5cc <malloc+0xcc>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 594:	29 f9                	sub    %edi,%ecx
 596:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 599:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 59c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 59f:	89 15 8c 08 00 00    	mov    %edx,0x88c
      return (void*)(p + 1);
 5a5:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 5a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5ab:	5b                   	pop    %ebx
 5ac:	5e                   	pop    %esi
 5ad:	5f                   	pop    %edi
 5ae:	5d                   	pop    %ebp
 5af:	c3                   	ret    
 5b0:	be 00 80 00 00       	mov    $0x8000,%esi
 5b5:	eb 9e                	jmp    555 <malloc+0x55>
 5b7:	90                   	nop
 5b8:	bb 00 10 00 00       	mov    $0x1000,%ebx
 5bd:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 5c3:	76 eb                	jbe    5b0 <malloc+0xb0>
 5c5:	e9 76 ff ff ff       	jmp    540 <malloc+0x40>
 5ca:	66 90                	xchg   %ax,%ax
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 5cc:	8b 08                	mov    (%eax),%ecx
 5ce:	89 0a                	mov    %ecx,(%edx)
 5d0:	eb cd                	jmp    59f <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 5d2:	c7 05 8c 08 00 00 90 	movl   $0x890,0x88c
 5d9:	08 00 00 
 5dc:	c7 05 90 08 00 00 90 	movl   $0x890,0x890
 5e3:	08 00 00 
    base.s.size = 0;
 5e6:	c7 05 94 08 00 00 00 	movl   $0x0,0x894
 5ed:	00 00 00 
 5f0:	b8 90 08 00 00       	mov    $0x890,%eax
 5f5:	e9 30 ff ff ff       	jmp    52a <malloc+0x2a>
