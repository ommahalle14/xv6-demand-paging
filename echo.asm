
_echo:     file format elf32-i386


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
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 08             	sub    $0x8,%esp
  14:	8b 31                	mov    (%ecx),%esi
  16:	8b 79 04             	mov    0x4(%ecx),%edi
  int i;

  for(i = 1; i < argc; i++)
  19:	83 fe 01             	cmp    $0x1,%esi
  1c:	7e 3f                	jle    5d <main+0x5d>
  1e:	bb 01 00 00 00       	mov    $0x1,%ebx
  23:	eb 1b                	jmp    40 <main+0x40>
  25:	8d 76 00             	lea    0x0(%esi),%esi
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  28:	68 34 06 00 00       	push   $0x634
  2d:	ff 74 9f fc          	pushl  -0x4(%edi,%ebx,4)
  31:	68 36 06 00 00       	push   $0x636
  36:	6a 01                	push   $0x1
  38:	e8 f7 02 00 00       	call   334 <printf>
  3d:	83 c4 10             	add    $0x10,%esp
  40:	43                   	inc    %ebx
  41:	39 de                	cmp    %ebx,%esi
  43:	75 e3                	jne    28 <main+0x28>
  45:	68 3b 06 00 00       	push   $0x63b
  4a:	ff 74 b7 fc          	pushl  -0x4(%edi,%esi,4)
  4e:	68 36 06 00 00       	push   $0x636
  53:	6a 01                	push   $0x1
  55:	e8 da 02 00 00       	call   334 <printf>
  5a:	83 c4 10             	add    $0x10,%esp
  exit();
  5d:	e8 ad 01 00 00       	call   20f <exit>
  62:	66 90                	xchg   %ax,%ax

00000064 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  64:	55                   	push   %ebp
  65:	89 e5                	mov    %esp,%ebp
  67:	53                   	push   %ebx
  68:	8b 45 08             	mov    0x8(%ebp),%eax
  6b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  6e:	89 c2                	mov    %eax,%edx
  70:	42                   	inc    %edx
  71:	41                   	inc    %ecx
  72:	8a 59 ff             	mov    -0x1(%ecx),%bl
  75:	88 5a ff             	mov    %bl,-0x1(%edx)
  78:	84 db                	test   %bl,%bl
  7a:	75 f4                	jne    70 <strcpy+0xc>
    ;
  return os;
}
  7c:	5b                   	pop    %ebx
  7d:	5d                   	pop    %ebp
  7e:	c3                   	ret    
  7f:	90                   	nop

00000080 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80:	55                   	push   %ebp
  81:	89 e5                	mov    %esp,%ebp
  83:	56                   	push   %esi
  84:	53                   	push   %ebx
  85:	8b 55 08             	mov    0x8(%ebp),%edx
  88:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  8b:	0f b6 02             	movzbl (%edx),%eax
  8e:	0f b6 0b             	movzbl (%ebx),%ecx
  91:	84 c0                	test   %al,%al
  93:	75 14                	jne    a9 <strcmp+0x29>
  95:	eb 1d                	jmp    b4 <strcmp+0x34>
  97:	90                   	nop
    p++, q++;
  98:	42                   	inc    %edx
  99:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  9c:	0f b6 02             	movzbl (%edx),%eax
  9f:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
  a3:	84 c0                	test   %al,%al
  a5:	74 0d                	je     b4 <strcmp+0x34>
  a7:	89 f3                	mov    %esi,%ebx
  a9:	38 c8                	cmp    %cl,%al
  ab:	74 eb                	je     98 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  ad:	29 c8                	sub    %ecx,%eax
}
  af:	5b                   	pop    %ebx
  b0:	5e                   	pop    %esi
  b1:	5d                   	pop    %ebp
  b2:	c3                   	ret    
  b3:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  b4:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
  b6:	29 c8                	sub    %ecx,%eax
}
  b8:	5b                   	pop    %ebx
  b9:	5e                   	pop    %esi
  ba:	5d                   	pop    %ebp
  bb:	c3                   	ret    

000000bc <strlen>:

uint
strlen(const char *s)
{
  bc:	55                   	push   %ebp
  bd:	89 e5                	mov    %esp,%ebp
  bf:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  c2:	80 39 00             	cmpb   $0x0,(%ecx)
  c5:	74 10                	je     d7 <strlen+0x1b>
  c7:	31 d2                	xor    %edx,%edx
  c9:	8d 76 00             	lea    0x0(%esi),%esi
  cc:	42                   	inc    %edx
  cd:	89 d0                	mov    %edx,%eax
  cf:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  d3:	75 f7                	jne    cc <strlen+0x10>
    ;
  return n;
}
  d5:	5d                   	pop    %ebp
  d6:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
  d7:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
  d9:	5d                   	pop    %ebp
  da:	c3                   	ret    
  db:	90                   	nop

000000dc <memset>:

void*
memset(void *dst, int c, uint n)
{
  dc:	55                   	push   %ebp
  dd:	89 e5                	mov    %esp,%ebp
  df:	57                   	push   %edi
  e0:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  e3:	89 d7                	mov    %edx,%edi
  e5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  eb:	fc                   	cld    
  ec:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  ee:	89 d0                	mov    %edx,%eax
  f0:	5f                   	pop    %edi
  f1:	5d                   	pop    %ebp
  f2:	c3                   	ret    
  f3:	90                   	nop

000000f4 <strchr>:

char*
strchr(const char *s, char c)
{
  f4:	55                   	push   %ebp
  f5:	89 e5                	mov    %esp,%ebp
  f7:	53                   	push   %ebx
  f8:	8b 45 08             	mov    0x8(%ebp),%eax
  fb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
  fe:	8a 10                	mov    (%eax),%dl
 100:	84 d2                	test   %dl,%dl
 102:	74 13                	je     117 <strchr+0x23>
 104:	88 d9                	mov    %bl,%cl
    if(*s == c)
 106:	38 d3                	cmp    %dl,%bl
 108:	75 06                	jne    110 <strchr+0x1c>
 10a:	eb 0d                	jmp    119 <strchr+0x25>
 10c:	38 ca                	cmp    %cl,%dl
 10e:	74 09                	je     119 <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 110:	40                   	inc    %eax
 111:	8a 10                	mov    (%eax),%dl
 113:	84 d2                	test   %dl,%dl
 115:	75 f5                	jne    10c <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
 117:	31 c0                	xor    %eax,%eax
}
 119:	5b                   	pop    %ebx
 11a:	5d                   	pop    %ebp
 11b:	c3                   	ret    

0000011c <gets>:

char*
gets(char *buf, int max)
{
 11c:	55                   	push   %ebp
 11d:	89 e5                	mov    %esp,%ebp
 11f:	57                   	push   %edi
 120:	56                   	push   %esi
 121:	53                   	push   %ebx
 122:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 125:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 127:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 12a:	eb 26                	jmp    152 <gets+0x36>
    cc = read(0, &c, 1);
 12c:	50                   	push   %eax
 12d:	6a 01                	push   $0x1
 12f:	57                   	push   %edi
 130:	6a 00                	push   $0x0
 132:	e8 f0 00 00 00       	call   227 <read>
    if(cc < 1)
 137:	83 c4 10             	add    $0x10,%esp
 13a:	85 c0                	test   %eax,%eax
 13c:	7e 1c                	jle    15a <gets+0x3e>
      break;
    buf[i++] = c;
 13e:	8a 45 e7             	mov    -0x19(%ebp),%al
 141:	8b 55 08             	mov    0x8(%ebp),%edx
 144:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 148:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 14a:	3c 0a                	cmp    $0xa,%al
 14c:	74 0c                	je     15a <gets+0x3e>
 14e:	3c 0d                	cmp    $0xd,%al
 150:	74 08                	je     15a <gets+0x3e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 152:	8d 5e 01             	lea    0x1(%esi),%ebx
 155:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 158:	7c d2                	jl     12c <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 15a:	8b 45 08             	mov    0x8(%ebp),%eax
 15d:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 161:	8d 65 f4             	lea    -0xc(%ebp),%esp
 164:	5b                   	pop    %ebx
 165:	5e                   	pop    %esi
 166:	5f                   	pop    %edi
 167:	5d                   	pop    %ebp
 168:	c3                   	ret    
 169:	8d 76 00             	lea    0x0(%esi),%esi

0000016c <stat>:

int
stat(const char *n, struct stat *st)
{
 16c:	55                   	push   %ebp
 16d:	89 e5                	mov    %esp,%ebp
 16f:	56                   	push   %esi
 170:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 171:	83 ec 08             	sub    $0x8,%esp
 174:	6a 00                	push   $0x0
 176:	ff 75 08             	pushl  0x8(%ebp)
 179:	e8 d1 00 00 00       	call   24f <open>
  if(fd < 0)
 17e:	83 c4 10             	add    $0x10,%esp
 181:	85 c0                	test   %eax,%eax
 183:	78 27                	js     1ac <stat+0x40>
 185:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 187:	83 ec 08             	sub    $0x8,%esp
 18a:	ff 75 0c             	pushl  0xc(%ebp)
 18d:	50                   	push   %eax
 18e:	e8 d4 00 00 00       	call   267 <fstat>
 193:	89 c6                	mov    %eax,%esi
  close(fd);
 195:	89 1c 24             	mov    %ebx,(%esp)
 198:	e8 9a 00 00 00       	call   237 <close>
  return r;
 19d:	83 c4 10             	add    $0x10,%esp
 1a0:	89 f0                	mov    %esi,%eax
}
 1a2:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1a5:	5b                   	pop    %ebx
 1a6:	5e                   	pop    %esi
 1a7:	5d                   	pop    %ebp
 1a8:	c3                   	ret    
 1a9:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 1ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1b1:	eb ef                	jmp    1a2 <stat+0x36>
 1b3:	90                   	nop

000001b4 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 1b4:	55                   	push   %ebp
 1b5:	89 e5                	mov    %esp,%ebp
 1b7:	53                   	push   %ebx
 1b8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1bb:	0f be 11             	movsbl (%ecx),%edx
 1be:	8d 42 d0             	lea    -0x30(%edx),%eax
 1c1:	3c 09                	cmp    $0x9,%al
 1c3:	b8 00 00 00 00       	mov    $0x0,%eax
 1c8:	77 15                	ja     1df <atoi+0x2b>
 1ca:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 1cc:	41                   	inc    %ecx
 1cd:	8d 04 80             	lea    (%eax,%eax,4),%eax
 1d0:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1d4:	0f be 11             	movsbl (%ecx),%edx
 1d7:	8d 5a d0             	lea    -0x30(%edx),%ebx
 1da:	80 fb 09             	cmp    $0x9,%bl
 1dd:	76 ed                	jbe    1cc <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 1df:	5b                   	pop    %ebx
 1e0:	5d                   	pop    %ebp
 1e1:	c3                   	ret    
 1e2:	66 90                	xchg   %ax,%ax

000001e4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1e4:	55                   	push   %ebp
 1e5:	89 e5                	mov    %esp,%ebp
 1e7:	56                   	push   %esi
 1e8:	53                   	push   %ebx
 1e9:	8b 45 08             	mov    0x8(%ebp),%eax
 1ec:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1ef:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1f2:	85 f6                	test   %esi,%esi
 1f4:	7e 0d                	jle    203 <memmove+0x1f>
 1f6:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 1f8:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 1fb:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 1fe:	42                   	inc    %edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1ff:	39 f2                	cmp    %esi,%edx
 201:	75 f5                	jne    1f8 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 203:	5b                   	pop    %ebx
 204:	5e                   	pop    %esi
 205:	5d                   	pop    %ebp
 206:	c3                   	ret    

00000207 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 207:	b8 01 00 00 00       	mov    $0x1,%eax
 20c:	cd 40                	int    $0x40
 20e:	c3                   	ret    

0000020f <exit>:
SYSCALL(exit)
 20f:	b8 02 00 00 00       	mov    $0x2,%eax
 214:	cd 40                	int    $0x40
 216:	c3                   	ret    

00000217 <wait>:
SYSCALL(wait)
 217:	b8 03 00 00 00       	mov    $0x3,%eax
 21c:	cd 40                	int    $0x40
 21e:	c3                   	ret    

0000021f <pipe>:
SYSCALL(pipe)
 21f:	b8 04 00 00 00       	mov    $0x4,%eax
 224:	cd 40                	int    $0x40
 226:	c3                   	ret    

00000227 <read>:
SYSCALL(read)
 227:	b8 05 00 00 00       	mov    $0x5,%eax
 22c:	cd 40                	int    $0x40
 22e:	c3                   	ret    

0000022f <write>:
SYSCALL(write)
 22f:	b8 10 00 00 00       	mov    $0x10,%eax
 234:	cd 40                	int    $0x40
 236:	c3                   	ret    

00000237 <close>:
SYSCALL(close)
 237:	b8 15 00 00 00       	mov    $0x15,%eax
 23c:	cd 40                	int    $0x40
 23e:	c3                   	ret    

0000023f <kill>:
SYSCALL(kill)
 23f:	b8 06 00 00 00       	mov    $0x6,%eax
 244:	cd 40                	int    $0x40
 246:	c3                   	ret    

00000247 <exec>:
SYSCALL(exec)
 247:	b8 07 00 00 00       	mov    $0x7,%eax
 24c:	cd 40                	int    $0x40
 24e:	c3                   	ret    

0000024f <open>:
SYSCALL(open)
 24f:	b8 0f 00 00 00       	mov    $0xf,%eax
 254:	cd 40                	int    $0x40
 256:	c3                   	ret    

00000257 <mknod>:
SYSCALL(mknod)
 257:	b8 11 00 00 00       	mov    $0x11,%eax
 25c:	cd 40                	int    $0x40
 25e:	c3                   	ret    

0000025f <unlink>:
SYSCALL(unlink)
 25f:	b8 12 00 00 00       	mov    $0x12,%eax
 264:	cd 40                	int    $0x40
 266:	c3                   	ret    

00000267 <fstat>:
SYSCALL(fstat)
 267:	b8 08 00 00 00       	mov    $0x8,%eax
 26c:	cd 40                	int    $0x40
 26e:	c3                   	ret    

0000026f <link>:
SYSCALL(link)
 26f:	b8 13 00 00 00       	mov    $0x13,%eax
 274:	cd 40                	int    $0x40
 276:	c3                   	ret    

00000277 <mkdir>:
SYSCALL(mkdir)
 277:	b8 14 00 00 00       	mov    $0x14,%eax
 27c:	cd 40                	int    $0x40
 27e:	c3                   	ret    

0000027f <chdir>:
SYSCALL(chdir)
 27f:	b8 09 00 00 00       	mov    $0x9,%eax
 284:	cd 40                	int    $0x40
 286:	c3                   	ret    

00000287 <dup>:
SYSCALL(dup)
 287:	b8 0a 00 00 00       	mov    $0xa,%eax
 28c:	cd 40                	int    $0x40
 28e:	c3                   	ret    

0000028f <getpid>:
SYSCALL(getpid)
 28f:	b8 0b 00 00 00       	mov    $0xb,%eax
 294:	cd 40                	int    $0x40
 296:	c3                   	ret    

00000297 <sbrk>:
SYSCALL(sbrk)
 297:	b8 0c 00 00 00       	mov    $0xc,%eax
 29c:	cd 40                	int    $0x40
 29e:	c3                   	ret    

0000029f <sleep>:
SYSCALL(sleep)
 29f:	b8 0d 00 00 00       	mov    $0xd,%eax
 2a4:	cd 40                	int    $0x40
 2a6:	c3                   	ret    

000002a7 <uptime>:
SYSCALL(uptime)
 2a7:	b8 0e 00 00 00       	mov    $0xe,%eax
 2ac:	cd 40                	int    $0x40
 2ae:	c3                   	ret    
 2af:	90                   	nop

000002b0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	57                   	push   %edi
 2b4:	56                   	push   %esi
 2b5:	53                   	push   %ebx
 2b6:	83 ec 3c             	sub    $0x3c,%esp
 2b9:	89 c6                	mov    %eax,%esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 2bb:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 2bd:	8b 5d 08             	mov    0x8(%ebp),%ebx
 2c0:	85 db                	test   %ebx,%ebx
 2c2:	74 04                	je     2c8 <printint+0x18>
 2c4:	85 d2                	test   %edx,%edx
 2c6:	78 5f                	js     327 <printint+0x77>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 2c8:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 2cf:	31 ff                	xor    %edi,%edi
 2d1:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 2d4:	89 75 c4             	mov    %esi,-0x3c(%ebp)
 2d7:	89 ce                	mov    %ecx,%esi
 2d9:	eb 03                	jmp    2de <printint+0x2e>
 2db:	90                   	nop
  do{
    buf[i++] = digits[x % base];
 2dc:	89 cf                	mov    %ecx,%edi
 2de:	8d 4f 01             	lea    0x1(%edi),%ecx
 2e1:	31 d2                	xor    %edx,%edx
 2e3:	f7 f6                	div    %esi
 2e5:	8a 92 44 06 00 00    	mov    0x644(%edx),%dl
 2eb:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 2ee:	85 c0                	test   %eax,%eax
 2f0:	75 ea                	jne    2dc <printint+0x2c>
 2f2:	8b 75 c4             	mov    -0x3c(%ebp),%esi
  if(neg)
 2f5:	8b 55 c0             	mov    -0x40(%ebp),%edx
 2f8:	85 d2                	test   %edx,%edx
 2fa:	74 08                	je     304 <printint+0x54>
    buf[i++] = '-';
 2fc:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 301:	8d 4f 02             	lea    0x2(%edi),%ecx
 304:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 308:	8a 07                	mov    (%edi),%al
 30a:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 30d:	50                   	push   %eax
 30e:	6a 01                	push   $0x1
 310:	53                   	push   %ebx
 311:	56                   	push   %esi
 312:	e8 18 ff ff ff       	call   22f <write>
 317:	4f                   	dec    %edi
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 318:	83 c4 10             	add    $0x10,%esp
 31b:	39 df                	cmp    %ebx,%edi
 31d:	75 e9                	jne    308 <printint+0x58>
    putc(fd, buf[i]);
}
 31f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 322:	5b                   	pop    %ebx
 323:	5e                   	pop    %esi
 324:	5f                   	pop    %edi
 325:	5d                   	pop    %ebp
 326:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 327:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 329:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 330:	eb 9d                	jmp    2cf <printint+0x1f>
 332:	66 90                	xchg   %ax,%ax

00000334 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 334:	55                   	push   %ebp
 335:	89 e5                	mov    %esp,%ebp
 337:	57                   	push   %edi
 338:	56                   	push   %esi
 339:	53                   	push   %ebx
 33a:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 33d:	8b 75 0c             	mov    0xc(%ebp),%esi
 340:	8a 1e                	mov    (%esi),%bl
 342:	84 db                	test   %bl,%bl
 344:	0f 84 a6 00 00 00    	je     3f0 <printf+0xbc>
 34a:	46                   	inc    %esi
 34b:	8d 45 10             	lea    0x10(%ebp),%eax
 34e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 351:	31 ff                	xor    %edi,%edi
 353:	eb 29                	jmp    37e <printf+0x4a>
 355:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 358:	83 f8 25             	cmp    $0x25,%eax
 35b:	0f 84 97 00 00 00    	je     3f8 <printf+0xc4>
 361:	88 5d e2             	mov    %bl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 364:	50                   	push   %eax
 365:	6a 01                	push   $0x1
 367:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 36a:	50                   	push   %eax
 36b:	ff 75 08             	pushl  0x8(%ebp)
 36e:	e8 bc fe ff ff       	call   22f <write>
 373:	83 c4 10             	add    $0x10,%esp
 376:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 377:	8a 5e ff             	mov    -0x1(%esi),%bl
 37a:	84 db                	test   %bl,%bl
 37c:	74 72                	je     3f0 <printf+0xbc>
    c = fmt[i] & 0xff;
 37e:	0f be cb             	movsbl %bl,%ecx
 381:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 384:	85 ff                	test   %edi,%edi
 386:	74 d0                	je     358 <printf+0x24>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 388:	83 ff 25             	cmp    $0x25,%edi
 38b:	75 e9                	jne    376 <printf+0x42>
      if(c == 'd'){
 38d:	83 f8 64             	cmp    $0x64,%eax
 390:	0f 84 f6 00 00 00    	je     48c <printf+0x158>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 396:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 39c:	83 f9 70             	cmp    $0x70,%ecx
 39f:	74 63                	je     404 <printf+0xd0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 3a1:	83 f8 73             	cmp    $0x73,%eax
 3a4:	0f 84 86 00 00 00    	je     430 <printf+0xfc>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 3aa:	83 f8 63             	cmp    $0x63,%eax
 3ad:	0f 84 be 00 00 00    	je     471 <printf+0x13d>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 3b3:	83 f8 25             	cmp    $0x25,%eax
 3b6:	0f 84 e0 00 00 00    	je     49c <printf+0x168>
 3bc:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3c0:	50                   	push   %eax
 3c1:	6a 01                	push   $0x1
 3c3:	8d 45 e7             	lea    -0x19(%ebp),%eax
 3c6:	50                   	push   %eax
 3c7:	ff 75 08             	pushl  0x8(%ebp)
 3ca:	e8 60 fe ff ff       	call   22f <write>
 3cf:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 3d2:	83 c4 0c             	add    $0xc,%esp
 3d5:	6a 01                	push   $0x1
 3d7:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 3da:	50                   	push   %eax
 3db:	ff 75 08             	pushl  0x8(%ebp)
 3de:	e8 4c fe ff ff       	call   22f <write>
 3e3:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 3e6:	31 ff                	xor    %edi,%edi
 3e8:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3e9:	8a 5e ff             	mov    -0x1(%esi),%bl
 3ec:	84 db                	test   %bl,%bl
 3ee:	75 8e                	jne    37e <printf+0x4a>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 3f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3f3:	5b                   	pop    %ebx
 3f4:	5e                   	pop    %esi
 3f5:	5f                   	pop    %edi
 3f6:	5d                   	pop    %ebp
 3f7:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 3f8:	bf 25 00 00 00       	mov    $0x25,%edi
 3fd:	e9 74 ff ff ff       	jmp    376 <printf+0x42>
 402:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 404:	83 ec 0c             	sub    $0xc,%esp
 407:	6a 00                	push   $0x0
 409:	b9 10 00 00 00       	mov    $0x10,%ecx
 40e:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 411:	8b 17                	mov    (%edi),%edx
 413:	8b 45 08             	mov    0x8(%ebp),%eax
 416:	e8 95 fe ff ff       	call   2b0 <printint>
        ap++;
 41b:	89 f8                	mov    %edi,%eax
 41d:	83 c0 04             	add    $0x4,%eax
 420:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 423:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 426:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 428:	e9 49 ff ff ff       	jmp    376 <printf+0x42>
 42d:	8d 76 00             	lea    0x0(%esi),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 430:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 433:	8b 38                	mov    (%eax),%edi
        ap++;
 435:	83 c0 04             	add    $0x4,%eax
 438:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 43b:	85 ff                	test   %edi,%edi
 43d:	74 6b                	je     4aa <printf+0x176>
          s = "(null)";
        while(*s != 0){
 43f:	8a 07                	mov    (%edi),%al
 441:	84 c0                	test   %al,%al
 443:	74 6c                	je     4b1 <printf+0x17d>
 445:	8d 5d e3             	lea    -0x1d(%ebp),%ebx
 448:	89 75 d0             	mov    %esi,-0x30(%ebp)
 44b:	89 fe                	mov    %edi,%esi
 44d:	8b 7d 08             	mov    0x8(%ebp),%edi
 450:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 453:	50                   	push   %eax
 454:	6a 01                	push   $0x1
 456:	53                   	push   %ebx
 457:	57                   	push   %edi
 458:	e8 d2 fd ff ff       	call   22f <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 45d:	46                   	inc    %esi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 45e:	8a 06                	mov    (%esi),%al
 460:	83 c4 10             	add    $0x10,%esp
 463:	84 c0                	test   %al,%al
 465:	75 e9                	jne    450 <printf+0x11c>
 467:	8b 75 d0             	mov    -0x30(%ebp),%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 46a:	31 ff                	xor    %edi,%edi
 46c:	e9 05 ff ff ff       	jmp    376 <printf+0x42>
 471:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 474:	8b 07                	mov    (%edi),%eax
 476:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 479:	51                   	push   %ecx
 47a:	6a 01                	push   $0x1
 47c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 47f:	50                   	push   %eax
 480:	ff 75 08             	pushl  0x8(%ebp)
 483:	e8 a7 fd ff ff       	call   22f <write>
 488:	eb 91                	jmp    41b <printf+0xe7>
 48a:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 48c:	83 ec 0c             	sub    $0xc,%esp
 48f:	6a 01                	push   $0x1
 491:	b9 0a 00 00 00       	mov    $0xa,%ecx
 496:	e9 73 ff ff ff       	jmp    40e <printf+0xda>
 49b:	90                   	nop
 49c:	88 5d e5             	mov    %bl,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 49f:	52                   	push   %edx
 4a0:	6a 01                	push   $0x1
 4a2:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 4a5:	e9 30 ff ff ff       	jmp    3da <printf+0xa6>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
 4aa:	bf 3d 06 00 00       	mov    $0x63d,%edi
 4af:	eb 8e                	jmp    43f <printf+0x10b>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4b1:	31 ff                	xor    %edi,%edi
 4b3:	e9 be fe ff ff       	jmp    376 <printf+0x42>

000004b8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 4b8:	55                   	push   %ebp
 4b9:	89 e5                	mov    %esp,%ebp
 4bb:	57                   	push   %edi
 4bc:	56                   	push   %esi
 4bd:	53                   	push   %ebx
 4be:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 4c1:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4c4:	a1 d8 08 00 00       	mov    0x8d8,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4c9:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4cb:	39 c8                	cmp    %ecx,%eax
 4cd:	73 11                	jae    4e0 <free+0x28>
 4cf:	90                   	nop
 4d0:	39 d1                	cmp    %edx,%ecx
 4d2:	72 14                	jb     4e8 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4d4:	39 d0                	cmp    %edx,%eax
 4d6:	73 10                	jae    4e8 <free+0x30>
static Header base;
static Header *freep;

void
free(void *ap)
{
 4d8:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4da:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4dc:	39 c8                	cmp    %ecx,%eax
 4de:	72 f0                	jb     4d0 <free+0x18>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4e0:	39 d0                	cmp    %edx,%eax
 4e2:	72 f4                	jb     4d8 <free+0x20>
 4e4:	39 d1                	cmp    %edx,%ecx
 4e6:	73 f0                	jae    4d8 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 4e8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 4eb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 4ee:	39 d7                	cmp    %edx,%edi
 4f0:	74 19                	je     50b <free+0x53>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 4f2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 4f5:	8b 50 04             	mov    0x4(%eax),%edx
 4f8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 4fb:	39 f1                	cmp    %esi,%ecx
 4fd:	74 23                	je     522 <free+0x6a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 4ff:	89 08                	mov    %ecx,(%eax)
  freep = p;
 501:	a3 d8 08 00 00       	mov    %eax,0x8d8
}
 506:	5b                   	pop    %ebx
 507:	5e                   	pop    %esi
 508:	5f                   	pop    %edi
 509:	5d                   	pop    %ebp
 50a:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 50b:	03 72 04             	add    0x4(%edx),%esi
 50e:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 511:	8b 10                	mov    (%eax),%edx
 513:	8b 12                	mov    (%edx),%edx
 515:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 518:	8b 50 04             	mov    0x4(%eax),%edx
 51b:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 51e:	39 f1                	cmp    %esi,%ecx
 520:	75 dd                	jne    4ff <free+0x47>
    p->s.size += bp->s.size;
 522:	03 53 fc             	add    -0x4(%ebx),%edx
 525:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 528:	8b 53 f8             	mov    -0x8(%ebx),%edx
 52b:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 52d:	a3 d8 08 00 00       	mov    %eax,0x8d8
}
 532:	5b                   	pop    %ebx
 533:	5e                   	pop    %esi
 534:	5f                   	pop    %edi
 535:	5d                   	pop    %ebp
 536:	c3                   	ret    
 537:	90                   	nop

00000538 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 538:	55                   	push   %ebp
 539:	89 e5                	mov    %esp,%ebp
 53b:	57                   	push   %edi
 53c:	56                   	push   %esi
 53d:	53                   	push   %ebx
 53e:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 541:	8b 45 08             	mov    0x8(%ebp),%eax
 544:	8d 78 07             	lea    0x7(%eax),%edi
 547:	c1 ef 03             	shr    $0x3,%edi
 54a:	47                   	inc    %edi
  if((prevp = freep) == 0){
 54b:	8b 15 d8 08 00 00    	mov    0x8d8,%edx
 551:	85 d2                	test   %edx,%edx
 553:	0f 84 b1 00 00 00    	je     60a <malloc+0xd2>
 559:	8b 02                	mov    (%edx),%eax
 55b:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 55e:	39 cf                	cmp    %ecx,%edi
 560:	76 66                	jbe    5c8 <malloc+0x90>
 562:	89 fb                	mov    %edi,%ebx
 564:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 56a:	0f 82 80 00 00 00    	jb     5f0 <malloc+0xb8>
 570:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 576:	76 70                	jbe    5e8 <malloc+0xb0>
 578:	8d 34 fd 00 00 00 00 	lea    0x0(,%edi,8),%esi
 57f:	eb 0c                	jmp    58d <malloc+0x55>
 581:	8d 76 00             	lea    0x0(%esi),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 584:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 586:	8b 48 04             	mov    0x4(%eax),%ecx
 589:	39 cf                	cmp    %ecx,%edi
 58b:	76 3b                	jbe    5c8 <malloc+0x90>
 58d:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 58f:	39 05 d8 08 00 00    	cmp    %eax,0x8d8
 595:	75 ed                	jne    584 <malloc+0x4c>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 597:	83 ec 0c             	sub    $0xc,%esp
 59a:	56                   	push   %esi
 59b:	e8 f7 fc ff ff       	call   297 <sbrk>
  if(p == (char*)-1)
 5a0:	83 c4 10             	add    $0x10,%esp
 5a3:	83 f8 ff             	cmp    $0xffffffff,%eax
 5a6:	74 1c                	je     5c4 <malloc+0x8c>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 5a8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 5ab:	83 ec 0c             	sub    $0xc,%esp
 5ae:	83 c0 08             	add    $0x8,%eax
 5b1:	50                   	push   %eax
 5b2:	e8 01 ff ff ff       	call   4b8 <free>
  return freep;
 5b7:	8b 15 d8 08 00 00    	mov    0x8d8,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 5bd:	83 c4 10             	add    $0x10,%esp
 5c0:	85 d2                	test   %edx,%edx
 5c2:	75 c0                	jne    584 <malloc+0x4c>
        return 0;
 5c4:	31 c0                	xor    %eax,%eax
 5c6:	eb 18                	jmp    5e0 <malloc+0xa8>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 5c8:	39 cf                	cmp    %ecx,%edi
 5ca:	74 38                	je     604 <malloc+0xcc>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 5cc:	29 f9                	sub    %edi,%ecx
 5ce:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 5d1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 5d4:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 5d7:	89 15 d8 08 00 00    	mov    %edx,0x8d8
      return (void*)(p + 1);
 5dd:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 5e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5e3:	5b                   	pop    %ebx
 5e4:	5e                   	pop    %esi
 5e5:	5f                   	pop    %edi
 5e6:	5d                   	pop    %ebp
 5e7:	c3                   	ret    
 5e8:	be 00 80 00 00       	mov    $0x8000,%esi
 5ed:	eb 9e                	jmp    58d <malloc+0x55>
 5ef:	90                   	nop
 5f0:	bb 00 10 00 00       	mov    $0x1000,%ebx
 5f5:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 5fb:	76 eb                	jbe    5e8 <malloc+0xb0>
 5fd:	e9 76 ff ff ff       	jmp    578 <malloc+0x40>
 602:	66 90                	xchg   %ax,%ax
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 604:	8b 08                	mov    (%eax),%ecx
 606:	89 0a                	mov    %ecx,(%edx)
 608:	eb cd                	jmp    5d7 <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 60a:	c7 05 d8 08 00 00 dc 	movl   $0x8dc,0x8d8
 611:	08 00 00 
 614:	c7 05 dc 08 00 00 dc 	movl   $0x8dc,0x8dc
 61b:	08 00 00 
    base.s.size = 0;
 61e:	c7 05 e0 08 00 00 00 	movl   $0x0,0x8e0
 625:	00 00 00 
 628:	b8 dc 08 00 00       	mov    $0x8dc,%eax
 62d:	e9 30 ff ff ff       	jmp    562 <malloc+0x2a>
