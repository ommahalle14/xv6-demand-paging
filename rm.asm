
_rm:     file format elf32-i386


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
  16:	8b 59 04             	mov    0x4(%ecx),%ebx
  int i;

  if(argc < 2){
  19:	83 fe 01             	cmp    $0x1,%esi
  1c:	7e 3c                	jle    5a <main+0x5a>
  1e:	83 c3 04             	add    $0x4,%ebx
  21:	bf 01 00 00 00       	mov    $0x1,%edi
  26:	66 90                	xchg   %ax,%ax
    printf(2, "Usage: rm files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
    if(unlink(argv[i]) < 0){
  28:	83 ec 0c             	sub    $0xc,%esp
  2b:	ff 33                	pushl  (%ebx)
  2d:	e8 39 02 00 00       	call   26b <unlink>
  32:	83 c4 10             	add    $0x10,%esp
  35:	85 c0                	test   %eax,%eax
  37:	78 0d                	js     46 <main+0x46>
  if(argc < 2){
    printf(2, "Usage: rm files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
  39:	47                   	inc    %edi
  3a:	83 c3 04             	add    $0x4,%ebx
  3d:	39 fe                	cmp    %edi,%esi
  3f:	75 e7                	jne    28 <main+0x28>
      printf(2, "rm: %s failed to delete\n", argv[i]);
      break;
    }
  }

  exit();
  41:	e8 d5 01 00 00       	call   21b <exit>
    exit();
  }

  for(i = 1; i < argc; i++){
    if(unlink(argv[i]) < 0){
      printf(2, "rm: %s failed to delete\n", argv[i]);
  46:	50                   	push   %eax
  47:	ff 33                	pushl  (%ebx)
  49:	68 54 06 00 00       	push   $0x654
  4e:	6a 02                	push   $0x2
  50:	e8 eb 02 00 00       	call   340 <printf>
      break;
  55:	83 c4 10             	add    $0x10,%esp
  58:	eb e7                	jmp    41 <main+0x41>
main(int argc, char *argv[])
{
  int i;

  if(argc < 2){
    printf(2, "Usage: rm files...\n");
  5a:	52                   	push   %edx
  5b:	52                   	push   %edx
  5c:	68 40 06 00 00       	push   $0x640
  61:	6a 02                	push   $0x2
  63:	e8 d8 02 00 00       	call   340 <printf>
    exit();
  68:	e8 ae 01 00 00       	call   21b <exit>
  6d:	66 90                	xchg   %ax,%ax
  6f:	90                   	nop

00000070 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  70:	55                   	push   %ebp
  71:	89 e5                	mov    %esp,%ebp
  73:	53                   	push   %ebx
  74:	8b 45 08             	mov    0x8(%ebp),%eax
  77:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  7a:	89 c2                	mov    %eax,%edx
  7c:	42                   	inc    %edx
  7d:	41                   	inc    %ecx
  7e:	8a 59 ff             	mov    -0x1(%ecx),%bl
  81:	88 5a ff             	mov    %bl,-0x1(%edx)
  84:	84 db                	test   %bl,%bl
  86:	75 f4                	jne    7c <strcpy+0xc>
    ;
  return os;
}
  88:	5b                   	pop    %ebx
  89:	5d                   	pop    %ebp
  8a:	c3                   	ret    
  8b:	90                   	nop

0000008c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8c:	55                   	push   %ebp
  8d:	89 e5                	mov    %esp,%ebp
  8f:	56                   	push   %esi
  90:	53                   	push   %ebx
  91:	8b 55 08             	mov    0x8(%ebp),%edx
  94:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  97:	0f b6 02             	movzbl (%edx),%eax
  9a:	0f b6 0b             	movzbl (%ebx),%ecx
  9d:	84 c0                	test   %al,%al
  9f:	75 14                	jne    b5 <strcmp+0x29>
  a1:	eb 1d                	jmp    c0 <strcmp+0x34>
  a3:	90                   	nop
    p++, q++;
  a4:	42                   	inc    %edx
  a5:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  a8:	0f b6 02             	movzbl (%edx),%eax
  ab:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
  af:	84 c0                	test   %al,%al
  b1:	74 0d                	je     c0 <strcmp+0x34>
  b3:	89 f3                	mov    %esi,%ebx
  b5:	38 c8                	cmp    %cl,%al
  b7:	74 eb                	je     a4 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  b9:	29 c8                	sub    %ecx,%eax
}
  bb:	5b                   	pop    %ebx
  bc:	5e                   	pop    %esi
  bd:	5d                   	pop    %ebp
  be:	c3                   	ret    
  bf:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  c0:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
  c2:	29 c8                	sub    %ecx,%eax
}
  c4:	5b                   	pop    %ebx
  c5:	5e                   	pop    %esi
  c6:	5d                   	pop    %ebp
  c7:	c3                   	ret    

000000c8 <strlen>:

uint
strlen(const char *s)
{
  c8:	55                   	push   %ebp
  c9:	89 e5                	mov    %esp,%ebp
  cb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  ce:	80 39 00             	cmpb   $0x0,(%ecx)
  d1:	74 10                	je     e3 <strlen+0x1b>
  d3:	31 d2                	xor    %edx,%edx
  d5:	8d 76 00             	lea    0x0(%esi),%esi
  d8:	42                   	inc    %edx
  d9:	89 d0                	mov    %edx,%eax
  db:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  df:	75 f7                	jne    d8 <strlen+0x10>
    ;
  return n;
}
  e1:	5d                   	pop    %ebp
  e2:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
  e3:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
  e5:	5d                   	pop    %ebp
  e6:	c3                   	ret    
  e7:	90                   	nop

000000e8 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e8:	55                   	push   %ebp
  e9:	89 e5                	mov    %esp,%ebp
  eb:	57                   	push   %edi
  ec:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  ef:	89 d7                	mov    %edx,%edi
  f1:	8b 4d 10             	mov    0x10(%ebp),%ecx
  f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  f7:	fc                   	cld    
  f8:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  fa:	89 d0                	mov    %edx,%eax
  fc:	5f                   	pop    %edi
  fd:	5d                   	pop    %ebp
  fe:	c3                   	ret    
  ff:	90                   	nop

00000100 <strchr>:

char*
strchr(const char *s, char c)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	53                   	push   %ebx
 104:	8b 45 08             	mov    0x8(%ebp),%eax
 107:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 10a:	8a 10                	mov    (%eax),%dl
 10c:	84 d2                	test   %dl,%dl
 10e:	74 13                	je     123 <strchr+0x23>
 110:	88 d9                	mov    %bl,%cl
    if(*s == c)
 112:	38 d3                	cmp    %dl,%bl
 114:	75 06                	jne    11c <strchr+0x1c>
 116:	eb 0d                	jmp    125 <strchr+0x25>
 118:	38 ca                	cmp    %cl,%dl
 11a:	74 09                	je     125 <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 11c:	40                   	inc    %eax
 11d:	8a 10                	mov    (%eax),%dl
 11f:	84 d2                	test   %dl,%dl
 121:	75 f5                	jne    118 <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
 123:	31 c0                	xor    %eax,%eax
}
 125:	5b                   	pop    %ebx
 126:	5d                   	pop    %ebp
 127:	c3                   	ret    

00000128 <gets>:

char*
gets(char *buf, int max)
{
 128:	55                   	push   %ebp
 129:	89 e5                	mov    %esp,%ebp
 12b:	57                   	push   %edi
 12c:	56                   	push   %esi
 12d:	53                   	push   %ebx
 12e:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 131:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 133:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 136:	eb 26                	jmp    15e <gets+0x36>
    cc = read(0, &c, 1);
 138:	50                   	push   %eax
 139:	6a 01                	push   $0x1
 13b:	57                   	push   %edi
 13c:	6a 00                	push   $0x0
 13e:	e8 f0 00 00 00       	call   233 <read>
    if(cc < 1)
 143:	83 c4 10             	add    $0x10,%esp
 146:	85 c0                	test   %eax,%eax
 148:	7e 1c                	jle    166 <gets+0x3e>
      break;
    buf[i++] = c;
 14a:	8a 45 e7             	mov    -0x19(%ebp),%al
 14d:	8b 55 08             	mov    0x8(%ebp),%edx
 150:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 154:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 156:	3c 0a                	cmp    $0xa,%al
 158:	74 0c                	je     166 <gets+0x3e>
 15a:	3c 0d                	cmp    $0xd,%al
 15c:	74 08                	je     166 <gets+0x3e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 15e:	8d 5e 01             	lea    0x1(%esi),%ebx
 161:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 164:	7c d2                	jl     138 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 166:	8b 45 08             	mov    0x8(%ebp),%eax
 169:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 16d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 170:	5b                   	pop    %ebx
 171:	5e                   	pop    %esi
 172:	5f                   	pop    %edi
 173:	5d                   	pop    %ebp
 174:	c3                   	ret    
 175:	8d 76 00             	lea    0x0(%esi),%esi

00000178 <stat>:

int
stat(const char *n, struct stat *st)
{
 178:	55                   	push   %ebp
 179:	89 e5                	mov    %esp,%ebp
 17b:	56                   	push   %esi
 17c:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 17d:	83 ec 08             	sub    $0x8,%esp
 180:	6a 00                	push   $0x0
 182:	ff 75 08             	pushl  0x8(%ebp)
 185:	e8 d1 00 00 00       	call   25b <open>
  if(fd < 0)
 18a:	83 c4 10             	add    $0x10,%esp
 18d:	85 c0                	test   %eax,%eax
 18f:	78 27                	js     1b8 <stat+0x40>
 191:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 193:	83 ec 08             	sub    $0x8,%esp
 196:	ff 75 0c             	pushl  0xc(%ebp)
 199:	50                   	push   %eax
 19a:	e8 d4 00 00 00       	call   273 <fstat>
 19f:	89 c6                	mov    %eax,%esi
  close(fd);
 1a1:	89 1c 24             	mov    %ebx,(%esp)
 1a4:	e8 9a 00 00 00       	call   243 <close>
  return r;
 1a9:	83 c4 10             	add    $0x10,%esp
 1ac:	89 f0                	mov    %esi,%eax
}
 1ae:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1b1:	5b                   	pop    %ebx
 1b2:	5e                   	pop    %esi
 1b3:	5d                   	pop    %ebp
 1b4:	c3                   	ret    
 1b5:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 1b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1bd:	eb ef                	jmp    1ae <stat+0x36>
 1bf:	90                   	nop

000001c0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	53                   	push   %ebx
 1c4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1c7:	0f be 11             	movsbl (%ecx),%edx
 1ca:	8d 42 d0             	lea    -0x30(%edx),%eax
 1cd:	3c 09                	cmp    $0x9,%al
 1cf:	b8 00 00 00 00       	mov    $0x0,%eax
 1d4:	77 15                	ja     1eb <atoi+0x2b>
 1d6:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 1d8:	41                   	inc    %ecx
 1d9:	8d 04 80             	lea    (%eax,%eax,4),%eax
 1dc:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1e0:	0f be 11             	movsbl (%ecx),%edx
 1e3:	8d 5a d0             	lea    -0x30(%edx),%ebx
 1e6:	80 fb 09             	cmp    $0x9,%bl
 1e9:	76 ed                	jbe    1d8 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 1eb:	5b                   	pop    %ebx
 1ec:	5d                   	pop    %ebp
 1ed:	c3                   	ret    
 1ee:	66 90                	xchg   %ax,%ax

000001f0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	56                   	push   %esi
 1f4:	53                   	push   %ebx
 1f5:	8b 45 08             	mov    0x8(%ebp),%eax
 1f8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1fb:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1fe:	85 f6                	test   %esi,%esi
 200:	7e 0d                	jle    20f <memmove+0x1f>
 202:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 204:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 207:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 20a:	42                   	inc    %edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 20b:	39 f2                	cmp    %esi,%edx
 20d:	75 f5                	jne    204 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 20f:	5b                   	pop    %ebx
 210:	5e                   	pop    %esi
 211:	5d                   	pop    %ebp
 212:	c3                   	ret    

00000213 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 213:	b8 01 00 00 00       	mov    $0x1,%eax
 218:	cd 40                	int    $0x40
 21a:	c3                   	ret    

0000021b <exit>:
SYSCALL(exit)
 21b:	b8 02 00 00 00       	mov    $0x2,%eax
 220:	cd 40                	int    $0x40
 222:	c3                   	ret    

00000223 <wait>:
SYSCALL(wait)
 223:	b8 03 00 00 00       	mov    $0x3,%eax
 228:	cd 40                	int    $0x40
 22a:	c3                   	ret    

0000022b <pipe>:
SYSCALL(pipe)
 22b:	b8 04 00 00 00       	mov    $0x4,%eax
 230:	cd 40                	int    $0x40
 232:	c3                   	ret    

00000233 <read>:
SYSCALL(read)
 233:	b8 05 00 00 00       	mov    $0x5,%eax
 238:	cd 40                	int    $0x40
 23a:	c3                   	ret    

0000023b <write>:
SYSCALL(write)
 23b:	b8 10 00 00 00       	mov    $0x10,%eax
 240:	cd 40                	int    $0x40
 242:	c3                   	ret    

00000243 <close>:
SYSCALL(close)
 243:	b8 15 00 00 00       	mov    $0x15,%eax
 248:	cd 40                	int    $0x40
 24a:	c3                   	ret    

0000024b <kill>:
SYSCALL(kill)
 24b:	b8 06 00 00 00       	mov    $0x6,%eax
 250:	cd 40                	int    $0x40
 252:	c3                   	ret    

00000253 <exec>:
SYSCALL(exec)
 253:	b8 07 00 00 00       	mov    $0x7,%eax
 258:	cd 40                	int    $0x40
 25a:	c3                   	ret    

0000025b <open>:
SYSCALL(open)
 25b:	b8 0f 00 00 00       	mov    $0xf,%eax
 260:	cd 40                	int    $0x40
 262:	c3                   	ret    

00000263 <mknod>:
SYSCALL(mknod)
 263:	b8 11 00 00 00       	mov    $0x11,%eax
 268:	cd 40                	int    $0x40
 26a:	c3                   	ret    

0000026b <unlink>:
SYSCALL(unlink)
 26b:	b8 12 00 00 00       	mov    $0x12,%eax
 270:	cd 40                	int    $0x40
 272:	c3                   	ret    

00000273 <fstat>:
SYSCALL(fstat)
 273:	b8 08 00 00 00       	mov    $0x8,%eax
 278:	cd 40                	int    $0x40
 27a:	c3                   	ret    

0000027b <link>:
SYSCALL(link)
 27b:	b8 13 00 00 00       	mov    $0x13,%eax
 280:	cd 40                	int    $0x40
 282:	c3                   	ret    

00000283 <mkdir>:
SYSCALL(mkdir)
 283:	b8 14 00 00 00       	mov    $0x14,%eax
 288:	cd 40                	int    $0x40
 28a:	c3                   	ret    

0000028b <chdir>:
SYSCALL(chdir)
 28b:	b8 09 00 00 00       	mov    $0x9,%eax
 290:	cd 40                	int    $0x40
 292:	c3                   	ret    

00000293 <dup>:
SYSCALL(dup)
 293:	b8 0a 00 00 00       	mov    $0xa,%eax
 298:	cd 40                	int    $0x40
 29a:	c3                   	ret    

0000029b <getpid>:
SYSCALL(getpid)
 29b:	b8 0b 00 00 00       	mov    $0xb,%eax
 2a0:	cd 40                	int    $0x40
 2a2:	c3                   	ret    

000002a3 <sbrk>:
SYSCALL(sbrk)
 2a3:	b8 0c 00 00 00       	mov    $0xc,%eax
 2a8:	cd 40                	int    $0x40
 2aa:	c3                   	ret    

000002ab <sleep>:
SYSCALL(sleep)
 2ab:	b8 0d 00 00 00       	mov    $0xd,%eax
 2b0:	cd 40                	int    $0x40
 2b2:	c3                   	ret    

000002b3 <uptime>:
SYSCALL(uptime)
 2b3:	b8 0e 00 00 00       	mov    $0xe,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret    
 2bb:	90                   	nop

000002bc <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 2bc:	55                   	push   %ebp
 2bd:	89 e5                	mov    %esp,%ebp
 2bf:	57                   	push   %edi
 2c0:	56                   	push   %esi
 2c1:	53                   	push   %ebx
 2c2:	83 ec 3c             	sub    $0x3c,%esp
 2c5:	89 c6                	mov    %eax,%esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 2c7:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 2c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
 2cc:	85 db                	test   %ebx,%ebx
 2ce:	74 04                	je     2d4 <printint+0x18>
 2d0:	85 d2                	test   %edx,%edx
 2d2:	78 5f                	js     333 <printint+0x77>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 2d4:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 2db:	31 ff                	xor    %edi,%edi
 2dd:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 2e0:	89 75 c4             	mov    %esi,-0x3c(%ebp)
 2e3:	89 ce                	mov    %ecx,%esi
 2e5:	eb 03                	jmp    2ea <printint+0x2e>
 2e7:	90                   	nop
  do{
    buf[i++] = digits[x % base];
 2e8:	89 cf                	mov    %ecx,%edi
 2ea:	8d 4f 01             	lea    0x1(%edi),%ecx
 2ed:	31 d2                	xor    %edx,%edx
 2ef:	f7 f6                	div    %esi
 2f1:	8a 92 74 06 00 00    	mov    0x674(%edx),%dl
 2f7:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 2fa:	85 c0                	test   %eax,%eax
 2fc:	75 ea                	jne    2e8 <printint+0x2c>
 2fe:	8b 75 c4             	mov    -0x3c(%ebp),%esi
  if(neg)
 301:	8b 55 c0             	mov    -0x40(%ebp),%edx
 304:	85 d2                	test   %edx,%edx
 306:	74 08                	je     310 <printint+0x54>
    buf[i++] = '-';
 308:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 30d:	8d 4f 02             	lea    0x2(%edi),%ecx
 310:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 314:	8a 07                	mov    (%edi),%al
 316:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 319:	50                   	push   %eax
 31a:	6a 01                	push   $0x1
 31c:	53                   	push   %ebx
 31d:	56                   	push   %esi
 31e:	e8 18 ff ff ff       	call   23b <write>
 323:	4f                   	dec    %edi
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 324:	83 c4 10             	add    $0x10,%esp
 327:	39 df                	cmp    %ebx,%edi
 329:	75 e9                	jne    314 <printint+0x58>
    putc(fd, buf[i]);
}
 32b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 32e:	5b                   	pop    %ebx
 32f:	5e                   	pop    %esi
 330:	5f                   	pop    %edi
 331:	5d                   	pop    %ebp
 332:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 333:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 335:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 33c:	eb 9d                	jmp    2db <printint+0x1f>
 33e:	66 90                	xchg   %ax,%ax

00000340 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	57                   	push   %edi
 344:	56                   	push   %esi
 345:	53                   	push   %ebx
 346:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 349:	8b 75 0c             	mov    0xc(%ebp),%esi
 34c:	8a 1e                	mov    (%esi),%bl
 34e:	84 db                	test   %bl,%bl
 350:	0f 84 a6 00 00 00    	je     3fc <printf+0xbc>
 356:	46                   	inc    %esi
 357:	8d 45 10             	lea    0x10(%ebp),%eax
 35a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 35d:	31 ff                	xor    %edi,%edi
 35f:	eb 29                	jmp    38a <printf+0x4a>
 361:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 364:	83 f8 25             	cmp    $0x25,%eax
 367:	0f 84 97 00 00 00    	je     404 <printf+0xc4>
 36d:	88 5d e2             	mov    %bl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 370:	50                   	push   %eax
 371:	6a 01                	push   $0x1
 373:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 376:	50                   	push   %eax
 377:	ff 75 08             	pushl  0x8(%ebp)
 37a:	e8 bc fe ff ff       	call   23b <write>
 37f:	83 c4 10             	add    $0x10,%esp
 382:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 383:	8a 5e ff             	mov    -0x1(%esi),%bl
 386:	84 db                	test   %bl,%bl
 388:	74 72                	je     3fc <printf+0xbc>
    c = fmt[i] & 0xff;
 38a:	0f be cb             	movsbl %bl,%ecx
 38d:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 390:	85 ff                	test   %edi,%edi
 392:	74 d0                	je     364 <printf+0x24>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 394:	83 ff 25             	cmp    $0x25,%edi
 397:	75 e9                	jne    382 <printf+0x42>
      if(c == 'd'){
 399:	83 f8 64             	cmp    $0x64,%eax
 39c:	0f 84 f6 00 00 00    	je     498 <printf+0x158>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 3a2:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 3a8:	83 f9 70             	cmp    $0x70,%ecx
 3ab:	74 63                	je     410 <printf+0xd0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 3ad:	83 f8 73             	cmp    $0x73,%eax
 3b0:	0f 84 86 00 00 00    	je     43c <printf+0xfc>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 3b6:	83 f8 63             	cmp    $0x63,%eax
 3b9:	0f 84 be 00 00 00    	je     47d <printf+0x13d>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 3bf:	83 f8 25             	cmp    $0x25,%eax
 3c2:	0f 84 e0 00 00 00    	je     4a8 <printf+0x168>
 3c8:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3cc:	50                   	push   %eax
 3cd:	6a 01                	push   $0x1
 3cf:	8d 45 e7             	lea    -0x19(%ebp),%eax
 3d2:	50                   	push   %eax
 3d3:	ff 75 08             	pushl  0x8(%ebp)
 3d6:	e8 60 fe ff ff       	call   23b <write>
 3db:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 3de:	83 c4 0c             	add    $0xc,%esp
 3e1:	6a 01                	push   $0x1
 3e3:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 3e6:	50                   	push   %eax
 3e7:	ff 75 08             	pushl  0x8(%ebp)
 3ea:	e8 4c fe ff ff       	call   23b <write>
 3ef:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 3f2:	31 ff                	xor    %edi,%edi
 3f4:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3f5:	8a 5e ff             	mov    -0x1(%esi),%bl
 3f8:	84 db                	test   %bl,%bl
 3fa:	75 8e                	jne    38a <printf+0x4a>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 3fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3ff:	5b                   	pop    %ebx
 400:	5e                   	pop    %esi
 401:	5f                   	pop    %edi
 402:	5d                   	pop    %ebp
 403:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 404:	bf 25 00 00 00       	mov    $0x25,%edi
 409:	e9 74 ff ff ff       	jmp    382 <printf+0x42>
 40e:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 410:	83 ec 0c             	sub    $0xc,%esp
 413:	6a 00                	push   $0x0
 415:	b9 10 00 00 00       	mov    $0x10,%ecx
 41a:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 41d:	8b 17                	mov    (%edi),%edx
 41f:	8b 45 08             	mov    0x8(%ebp),%eax
 422:	e8 95 fe ff ff       	call   2bc <printint>
        ap++;
 427:	89 f8                	mov    %edi,%eax
 429:	83 c0 04             	add    $0x4,%eax
 42c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 42f:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 432:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 434:	e9 49 ff ff ff       	jmp    382 <printf+0x42>
 439:	8d 76 00             	lea    0x0(%esi),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 43c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 43f:	8b 38                	mov    (%eax),%edi
        ap++;
 441:	83 c0 04             	add    $0x4,%eax
 444:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 447:	85 ff                	test   %edi,%edi
 449:	74 6b                	je     4b6 <printf+0x176>
          s = "(null)";
        while(*s != 0){
 44b:	8a 07                	mov    (%edi),%al
 44d:	84 c0                	test   %al,%al
 44f:	74 6c                	je     4bd <printf+0x17d>
 451:	8d 5d e3             	lea    -0x1d(%ebp),%ebx
 454:	89 75 d0             	mov    %esi,-0x30(%ebp)
 457:	89 fe                	mov    %edi,%esi
 459:	8b 7d 08             	mov    0x8(%ebp),%edi
 45c:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 45f:	50                   	push   %eax
 460:	6a 01                	push   $0x1
 462:	53                   	push   %ebx
 463:	57                   	push   %edi
 464:	e8 d2 fd ff ff       	call   23b <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 469:	46                   	inc    %esi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 46a:	8a 06                	mov    (%esi),%al
 46c:	83 c4 10             	add    $0x10,%esp
 46f:	84 c0                	test   %al,%al
 471:	75 e9                	jne    45c <printf+0x11c>
 473:	8b 75 d0             	mov    -0x30(%ebp),%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 476:	31 ff                	xor    %edi,%edi
 478:	e9 05 ff ff ff       	jmp    382 <printf+0x42>
 47d:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 480:	8b 07                	mov    (%edi),%eax
 482:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 485:	51                   	push   %ecx
 486:	6a 01                	push   $0x1
 488:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 48b:	50                   	push   %eax
 48c:	ff 75 08             	pushl  0x8(%ebp)
 48f:	e8 a7 fd ff ff       	call   23b <write>
 494:	eb 91                	jmp    427 <printf+0xe7>
 496:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 498:	83 ec 0c             	sub    $0xc,%esp
 49b:	6a 01                	push   $0x1
 49d:	b9 0a 00 00 00       	mov    $0xa,%ecx
 4a2:	e9 73 ff ff ff       	jmp    41a <printf+0xda>
 4a7:	90                   	nop
 4a8:	88 5d e5             	mov    %bl,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4ab:	52                   	push   %edx
 4ac:	6a 01                	push   $0x1
 4ae:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 4b1:	e9 30 ff ff ff       	jmp    3e6 <printf+0xa6>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
 4b6:	bf 6d 06 00 00       	mov    $0x66d,%edi
 4bb:	eb 8e                	jmp    44b <printf+0x10b>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4bd:	31 ff                	xor    %edi,%edi
 4bf:	e9 be fe ff ff       	jmp    382 <printf+0x42>

000004c4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 4c4:	55                   	push   %ebp
 4c5:	89 e5                	mov    %esp,%ebp
 4c7:	57                   	push   %edi
 4c8:	56                   	push   %esi
 4c9:	53                   	push   %ebx
 4ca:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 4cd:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4d0:	a1 08 09 00 00       	mov    0x908,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4d5:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4d7:	39 c8                	cmp    %ecx,%eax
 4d9:	73 11                	jae    4ec <free+0x28>
 4db:	90                   	nop
 4dc:	39 d1                	cmp    %edx,%ecx
 4de:	72 14                	jb     4f4 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4e0:	39 d0                	cmp    %edx,%eax
 4e2:	73 10                	jae    4f4 <free+0x30>
static Header base;
static Header *freep;

void
free(void *ap)
{
 4e4:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4e6:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4e8:	39 c8                	cmp    %ecx,%eax
 4ea:	72 f0                	jb     4dc <free+0x18>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4ec:	39 d0                	cmp    %edx,%eax
 4ee:	72 f4                	jb     4e4 <free+0x20>
 4f0:	39 d1                	cmp    %edx,%ecx
 4f2:	73 f0                	jae    4e4 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 4f4:	8b 73 fc             	mov    -0x4(%ebx),%esi
 4f7:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 4fa:	39 d7                	cmp    %edx,%edi
 4fc:	74 19                	je     517 <free+0x53>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 4fe:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 501:	8b 50 04             	mov    0x4(%eax),%edx
 504:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 507:	39 f1                	cmp    %esi,%ecx
 509:	74 23                	je     52e <free+0x6a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 50b:	89 08                	mov    %ecx,(%eax)
  freep = p;
 50d:	a3 08 09 00 00       	mov    %eax,0x908
}
 512:	5b                   	pop    %ebx
 513:	5e                   	pop    %esi
 514:	5f                   	pop    %edi
 515:	5d                   	pop    %ebp
 516:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 517:	03 72 04             	add    0x4(%edx),%esi
 51a:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 51d:	8b 10                	mov    (%eax),%edx
 51f:	8b 12                	mov    (%edx),%edx
 521:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 524:	8b 50 04             	mov    0x4(%eax),%edx
 527:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 52a:	39 f1                	cmp    %esi,%ecx
 52c:	75 dd                	jne    50b <free+0x47>
    p->s.size += bp->s.size;
 52e:	03 53 fc             	add    -0x4(%ebx),%edx
 531:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 534:	8b 53 f8             	mov    -0x8(%ebx),%edx
 537:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 539:	a3 08 09 00 00       	mov    %eax,0x908
}
 53e:	5b                   	pop    %ebx
 53f:	5e                   	pop    %esi
 540:	5f                   	pop    %edi
 541:	5d                   	pop    %ebp
 542:	c3                   	ret    
 543:	90                   	nop

00000544 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 544:	55                   	push   %ebp
 545:	89 e5                	mov    %esp,%ebp
 547:	57                   	push   %edi
 548:	56                   	push   %esi
 549:	53                   	push   %ebx
 54a:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 54d:	8b 45 08             	mov    0x8(%ebp),%eax
 550:	8d 78 07             	lea    0x7(%eax),%edi
 553:	c1 ef 03             	shr    $0x3,%edi
 556:	47                   	inc    %edi
  if((prevp = freep) == 0){
 557:	8b 15 08 09 00 00    	mov    0x908,%edx
 55d:	85 d2                	test   %edx,%edx
 55f:	0f 84 b1 00 00 00    	je     616 <malloc+0xd2>
 565:	8b 02                	mov    (%edx),%eax
 567:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 56a:	39 cf                	cmp    %ecx,%edi
 56c:	76 66                	jbe    5d4 <malloc+0x90>
 56e:	89 fb                	mov    %edi,%ebx
 570:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 576:	0f 82 80 00 00 00    	jb     5fc <malloc+0xb8>
 57c:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 582:	76 70                	jbe    5f4 <malloc+0xb0>
 584:	8d 34 fd 00 00 00 00 	lea    0x0(,%edi,8),%esi
 58b:	eb 0c                	jmp    599 <malloc+0x55>
 58d:	8d 76 00             	lea    0x0(%esi),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 590:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 592:	8b 48 04             	mov    0x4(%eax),%ecx
 595:	39 cf                	cmp    %ecx,%edi
 597:	76 3b                	jbe    5d4 <malloc+0x90>
 599:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 59b:	39 05 08 09 00 00    	cmp    %eax,0x908
 5a1:	75 ed                	jne    590 <malloc+0x4c>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 5a3:	83 ec 0c             	sub    $0xc,%esp
 5a6:	56                   	push   %esi
 5a7:	e8 f7 fc ff ff       	call   2a3 <sbrk>
  if(p == (char*)-1)
 5ac:	83 c4 10             	add    $0x10,%esp
 5af:	83 f8 ff             	cmp    $0xffffffff,%eax
 5b2:	74 1c                	je     5d0 <malloc+0x8c>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 5b4:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 5b7:	83 ec 0c             	sub    $0xc,%esp
 5ba:	83 c0 08             	add    $0x8,%eax
 5bd:	50                   	push   %eax
 5be:	e8 01 ff ff ff       	call   4c4 <free>
  return freep;
 5c3:	8b 15 08 09 00 00    	mov    0x908,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 5c9:	83 c4 10             	add    $0x10,%esp
 5cc:	85 d2                	test   %edx,%edx
 5ce:	75 c0                	jne    590 <malloc+0x4c>
        return 0;
 5d0:	31 c0                	xor    %eax,%eax
 5d2:	eb 18                	jmp    5ec <malloc+0xa8>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 5d4:	39 cf                	cmp    %ecx,%edi
 5d6:	74 38                	je     610 <malloc+0xcc>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 5d8:	29 f9                	sub    %edi,%ecx
 5da:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 5dd:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 5e0:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 5e3:	89 15 08 09 00 00    	mov    %edx,0x908
      return (void*)(p + 1);
 5e9:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 5ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5ef:	5b                   	pop    %ebx
 5f0:	5e                   	pop    %esi
 5f1:	5f                   	pop    %edi
 5f2:	5d                   	pop    %ebp
 5f3:	c3                   	ret    
 5f4:	be 00 80 00 00       	mov    $0x8000,%esi
 5f9:	eb 9e                	jmp    599 <malloc+0x55>
 5fb:	90                   	nop
 5fc:	bb 00 10 00 00       	mov    $0x1000,%ebx
 601:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 607:	76 eb                	jbe    5f4 <malloc+0xb0>
 609:	e9 76 ff ff ff       	jmp    584 <malloc+0x40>
 60e:	66 90                	xchg   %ax,%ax
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 610:	8b 08                	mov    (%eax),%ecx
 612:	89 0a                	mov    %ecx,(%edx)
 614:	eb cd                	jmp    5e3 <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 616:	c7 05 08 09 00 00 0c 	movl   $0x90c,0x908
 61d:	09 00 00 
 620:	c7 05 0c 09 00 00 0c 	movl   $0x90c,0x90c
 627:	09 00 00 
    base.s.size = 0;
 62a:	c7 05 10 09 00 00 00 	movl   $0x0,0x910
 631:	00 00 00 
 634:	b8 0c 09 00 00       	mov    $0x90c,%eax
 639:	e9 30 ff ff ff       	jmp    56e <malloc+0x2a>
