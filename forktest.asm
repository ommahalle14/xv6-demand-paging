
_forktest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "fork test OK\n");
}

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
  forktest();
   f:	e8 30 00 00 00       	call   44 <forktest>
  exit();
  14:	e8 ba 02 00 00       	call   2d3 <exit>
  19:	66 90                	xchg   %ax,%ax
  1b:	90                   	nop

0000001c <printf>:

#define N  1000

void
printf(int fd, const char *s, ...)
{
  1c:	55                   	push   %ebp
  1d:	89 e5                	mov    %esp,%ebp
  1f:	53                   	push   %ebx
  20:	83 ec 10             	sub    $0x10,%esp
  23:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  write(fd, s, strlen(s));
  26:	53                   	push   %ebx
  27:	e8 54 01 00 00       	call   180 <strlen>
  2c:	83 c4 0c             	add    $0xc,%esp
  2f:	50                   	push   %eax
  30:	53                   	push   %ebx
  31:	ff 75 08             	pushl  0x8(%ebp)
  34:	e8 ba 02 00 00       	call   2f3 <write>
}
  39:	83 c4 10             	add    $0x10,%esp
  3c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  3f:	c9                   	leave  
  40:	c3                   	ret    
  41:	8d 76 00             	lea    0x0(%esi),%esi

00000044 <forktest>:

void
forktest(void)
{
  44:	55                   	push   %ebp
  45:	89 e5                	mov    %esp,%ebp
  47:	53                   	push   %ebx
  48:	83 ec 10             	sub    $0x10,%esp
#define N  1000

void
printf(int fd, const char *s, ...)
{
  write(fd, s, strlen(s));
  4b:	68 74 03 00 00       	push   $0x374
  50:	e8 2b 01 00 00       	call   180 <strlen>
  55:	83 c4 0c             	add    $0xc,%esp
  58:	50                   	push   %eax
  59:	68 74 03 00 00       	push   $0x374
  5e:	6a 01                	push   $0x1
  60:	e8 8e 02 00 00       	call   2f3 <write>
  65:	83 c4 10             	add    $0x10,%esp
{
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<N; n++){
  68:	31 db                	xor    %ebx,%ebx
  6a:	eb 0b                	jmp    77 <forktest+0x33>
    pid = fork();
    if(pid < 0)
      break;
    if(pid == 0)
  6c:	74 70                	je     de <forktest+0x9a>
{
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<N; n++){
  6e:	43                   	inc    %ebx
  6f:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
  75:	74 45                	je     bc <forktest+0x78>
    pid = fork();
  77:	e8 4f 02 00 00       	call   2cb <fork>
    if(pid < 0)
  7c:	85 c0                	test   %eax,%eax
  7e:	79 ec                	jns    6c <forktest+0x28>
  if(n == N){
    printf(1, "fork claimed to work N times!\n", N);
    exit();
  }

  for(; n > 0; n--){
  80:	85 db                	test   %ebx,%ebx
  82:	74 0c                	je     90 <forktest+0x4c>
    if(wait() < 0){
  84:	e8 52 02 00 00       	call   2db <wait>
  89:	85 c0                	test   %eax,%eax
  8b:	78 56                	js     e3 <forktest+0x9f>
  if(n == N){
    printf(1, "fork claimed to work N times!\n", N);
    exit();
  }

  for(; n > 0; n--){
  8d:	4b                   	dec    %ebx
  8e:	75 f4                	jne    84 <forktest+0x40>
      printf(1, "wait stopped early\n");
      exit();
    }
  }

  if(wait() != -1){
  90:	e8 46 02 00 00       	call   2db <wait>
  95:	40                   	inc    %eax
  96:	75 6d                	jne    105 <forktest+0xc1>
#define N  1000

void
printf(int fd, const char *s, ...)
{
  write(fd, s, strlen(s));
  98:	83 ec 0c             	sub    $0xc,%esp
  9b:	68 a6 03 00 00       	push   $0x3a6
  a0:	e8 db 00 00 00       	call   180 <strlen>
  a5:	83 c4 0c             	add    $0xc,%esp
  a8:	50                   	push   %eax
  a9:	68 a6 03 00 00       	push   $0x3a6
  ae:	6a 01                	push   $0x1
  b0:	e8 3e 02 00 00       	call   2f3 <write>
    printf(1, "wait got too many\n");
    exit();
  }

  printf(1, "fork test OK\n");
}
  b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  b8:	c9                   	leave  
  b9:	c3                   	ret    
  ba:	66 90                	xchg   %ax,%ax
#define N  1000

void
printf(int fd, const char *s, ...)
{
  write(fd, s, strlen(s));
  bc:	83 ec 0c             	sub    $0xc,%esp
  bf:	68 b4 03 00 00       	push   $0x3b4
  c4:	e8 b7 00 00 00       	call   180 <strlen>
  c9:	83 c4 0c             	add    $0xc,%esp
  cc:	50                   	push   %eax
  cd:	68 b4 03 00 00       	push   $0x3b4
  d2:	6a 01                	push   $0x1
  d4:	e8 1a 02 00 00       	call   2f3 <write>
      exit();
  }

  if(n == N){
    printf(1, "fork claimed to work N times!\n", N);
    exit();
  d9:	e8 f5 01 00 00       	call   2d3 <exit>
  for(n=0; n<N; n++){
    pid = fork();
    if(pid < 0)
      break;
    if(pid == 0)
      exit();
  de:	e8 f0 01 00 00       	call   2d3 <exit>
#define N  1000

void
printf(int fd, const char *s, ...)
{
  write(fd, s, strlen(s));
  e3:	83 ec 0c             	sub    $0xc,%esp
  e6:	68 7f 03 00 00       	push   $0x37f
  eb:	e8 90 00 00 00       	call   180 <strlen>
  f0:	83 c4 0c             	add    $0xc,%esp
  f3:	50                   	push   %eax
  f4:	68 7f 03 00 00       	push   $0x37f
  f9:	6a 01                	push   $0x1
  fb:	e8 f3 01 00 00       	call   2f3 <write>
  }

  for(; n > 0; n--){
    if(wait() < 0){
      printf(1, "wait stopped early\n");
      exit();
 100:	e8 ce 01 00 00       	call   2d3 <exit>
#define N  1000

void
printf(int fd, const char *s, ...)
{
  write(fd, s, strlen(s));
 105:	83 ec 0c             	sub    $0xc,%esp
 108:	68 93 03 00 00       	push   $0x393
 10d:	e8 6e 00 00 00       	call   180 <strlen>
 112:	83 c4 0c             	add    $0xc,%esp
 115:	50                   	push   %eax
 116:	68 93 03 00 00       	push   $0x393
 11b:	6a 01                	push   $0x1
 11d:	e8 d1 01 00 00       	call   2f3 <write>
    }
  }

  if(wait() != -1){
    printf(1, "wait got too many\n");
    exit();
 122:	e8 ac 01 00 00       	call   2d3 <exit>
 127:	90                   	nop

00000128 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 128:	55                   	push   %ebp
 129:	89 e5                	mov    %esp,%ebp
 12b:	53                   	push   %ebx
 12c:	8b 45 08             	mov    0x8(%ebp),%eax
 12f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 132:	89 c2                	mov    %eax,%edx
 134:	42                   	inc    %edx
 135:	41                   	inc    %ecx
 136:	8a 59 ff             	mov    -0x1(%ecx),%bl
 139:	88 5a ff             	mov    %bl,-0x1(%edx)
 13c:	84 db                	test   %bl,%bl
 13e:	75 f4                	jne    134 <strcpy+0xc>
    ;
  return os;
}
 140:	5b                   	pop    %ebx
 141:	5d                   	pop    %ebp
 142:	c3                   	ret    
 143:	90                   	nop

00000144 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 144:	55                   	push   %ebp
 145:	89 e5                	mov    %esp,%ebp
 147:	56                   	push   %esi
 148:	53                   	push   %ebx
 149:	8b 55 08             	mov    0x8(%ebp),%edx
 14c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 14f:	0f b6 02             	movzbl (%edx),%eax
 152:	0f b6 0b             	movzbl (%ebx),%ecx
 155:	84 c0                	test   %al,%al
 157:	75 14                	jne    16d <strcmp+0x29>
 159:	eb 1d                	jmp    178 <strcmp+0x34>
 15b:	90                   	nop
    p++, q++;
 15c:	42                   	inc    %edx
 15d:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 160:	0f b6 02             	movzbl (%edx),%eax
 163:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 167:	84 c0                	test   %al,%al
 169:	74 0d                	je     178 <strcmp+0x34>
 16b:	89 f3                	mov    %esi,%ebx
 16d:	38 c8                	cmp    %cl,%al
 16f:	74 eb                	je     15c <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 171:	29 c8                	sub    %ecx,%eax
}
 173:	5b                   	pop    %ebx
 174:	5e                   	pop    %esi
 175:	5d                   	pop    %ebp
 176:	c3                   	ret    
 177:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 178:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 17a:	29 c8                	sub    %ecx,%eax
}
 17c:	5b                   	pop    %ebx
 17d:	5e                   	pop    %esi
 17e:	5d                   	pop    %ebp
 17f:	c3                   	ret    

00000180 <strlen>:

uint
strlen(const char *s)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 186:	80 39 00             	cmpb   $0x0,(%ecx)
 189:	74 10                	je     19b <strlen+0x1b>
 18b:	31 d2                	xor    %edx,%edx
 18d:	8d 76 00             	lea    0x0(%esi),%esi
 190:	42                   	inc    %edx
 191:	89 d0                	mov    %edx,%eax
 193:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 197:	75 f7                	jne    190 <strlen+0x10>
    ;
  return n;
}
 199:	5d                   	pop    %ebp
 19a:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 19b:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 19d:	5d                   	pop    %ebp
 19e:	c3                   	ret    
 19f:	90                   	nop

000001a0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	57                   	push   %edi
 1a4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1a7:	89 d7                	mov    %edx,%edi
 1a9:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1ac:	8b 45 0c             	mov    0xc(%ebp),%eax
 1af:	fc                   	cld    
 1b0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1b2:	89 d0                	mov    %edx,%eax
 1b4:	5f                   	pop    %edi
 1b5:	5d                   	pop    %ebp
 1b6:	c3                   	ret    
 1b7:	90                   	nop

000001b8 <strchr>:

char*
strchr(const char *s, char c)
{
 1b8:	55                   	push   %ebp
 1b9:	89 e5                	mov    %esp,%ebp
 1bb:	53                   	push   %ebx
 1bc:	8b 45 08             	mov    0x8(%ebp),%eax
 1bf:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 1c2:	8a 10                	mov    (%eax),%dl
 1c4:	84 d2                	test   %dl,%dl
 1c6:	74 13                	je     1db <strchr+0x23>
 1c8:	88 d9                	mov    %bl,%cl
    if(*s == c)
 1ca:	38 d3                	cmp    %dl,%bl
 1cc:	75 06                	jne    1d4 <strchr+0x1c>
 1ce:	eb 0d                	jmp    1dd <strchr+0x25>
 1d0:	38 ca                	cmp    %cl,%dl
 1d2:	74 09                	je     1dd <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 1d4:	40                   	inc    %eax
 1d5:	8a 10                	mov    (%eax),%dl
 1d7:	84 d2                	test   %dl,%dl
 1d9:	75 f5                	jne    1d0 <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
 1db:	31 c0                	xor    %eax,%eax
}
 1dd:	5b                   	pop    %ebx
 1de:	5d                   	pop    %ebp
 1df:	c3                   	ret    

000001e0 <gets>:

char*
gets(char *buf, int max)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	57                   	push   %edi
 1e4:	56                   	push   %esi
 1e5:	53                   	push   %ebx
 1e6:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e9:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 1eb:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1ee:	eb 26                	jmp    216 <gets+0x36>
    cc = read(0, &c, 1);
 1f0:	50                   	push   %eax
 1f1:	6a 01                	push   $0x1
 1f3:	57                   	push   %edi
 1f4:	6a 00                	push   $0x0
 1f6:	e8 f0 00 00 00       	call   2eb <read>
    if(cc < 1)
 1fb:	83 c4 10             	add    $0x10,%esp
 1fe:	85 c0                	test   %eax,%eax
 200:	7e 1c                	jle    21e <gets+0x3e>
      break;
    buf[i++] = c;
 202:	8a 45 e7             	mov    -0x19(%ebp),%al
 205:	8b 55 08             	mov    0x8(%ebp),%edx
 208:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 20c:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 20e:	3c 0a                	cmp    $0xa,%al
 210:	74 0c                	je     21e <gets+0x3e>
 212:	3c 0d                	cmp    $0xd,%al
 214:	74 08                	je     21e <gets+0x3e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 216:	8d 5e 01             	lea    0x1(%esi),%ebx
 219:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 21c:	7c d2                	jl     1f0 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 21e:	8b 45 08             	mov    0x8(%ebp),%eax
 221:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 225:	8d 65 f4             	lea    -0xc(%ebp),%esp
 228:	5b                   	pop    %ebx
 229:	5e                   	pop    %esi
 22a:	5f                   	pop    %edi
 22b:	5d                   	pop    %ebp
 22c:	c3                   	ret    
 22d:	8d 76 00             	lea    0x0(%esi),%esi

00000230 <stat>:

int
stat(const char *n, struct stat *st)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	56                   	push   %esi
 234:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 235:	83 ec 08             	sub    $0x8,%esp
 238:	6a 00                	push   $0x0
 23a:	ff 75 08             	pushl  0x8(%ebp)
 23d:	e8 d1 00 00 00       	call   313 <open>
  if(fd < 0)
 242:	83 c4 10             	add    $0x10,%esp
 245:	85 c0                	test   %eax,%eax
 247:	78 27                	js     270 <stat+0x40>
 249:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 24b:	83 ec 08             	sub    $0x8,%esp
 24e:	ff 75 0c             	pushl  0xc(%ebp)
 251:	50                   	push   %eax
 252:	e8 d4 00 00 00       	call   32b <fstat>
 257:	89 c6                	mov    %eax,%esi
  close(fd);
 259:	89 1c 24             	mov    %ebx,(%esp)
 25c:	e8 9a 00 00 00       	call   2fb <close>
  return r;
 261:	83 c4 10             	add    $0x10,%esp
 264:	89 f0                	mov    %esi,%eax
}
 266:	8d 65 f8             	lea    -0x8(%ebp),%esp
 269:	5b                   	pop    %ebx
 26a:	5e                   	pop    %esi
 26b:	5d                   	pop    %ebp
 26c:	c3                   	ret    
 26d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 270:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 275:	eb ef                	jmp    266 <stat+0x36>
 277:	90                   	nop

00000278 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 278:	55                   	push   %ebp
 279:	89 e5                	mov    %esp,%ebp
 27b:	53                   	push   %ebx
 27c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 27f:	0f be 11             	movsbl (%ecx),%edx
 282:	8d 42 d0             	lea    -0x30(%edx),%eax
 285:	3c 09                	cmp    $0x9,%al
 287:	b8 00 00 00 00       	mov    $0x0,%eax
 28c:	77 15                	ja     2a3 <atoi+0x2b>
 28e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 290:	41                   	inc    %ecx
 291:	8d 04 80             	lea    (%eax,%eax,4),%eax
 294:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 298:	0f be 11             	movsbl (%ecx),%edx
 29b:	8d 5a d0             	lea    -0x30(%edx),%ebx
 29e:	80 fb 09             	cmp    $0x9,%bl
 2a1:	76 ed                	jbe    290 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 2a3:	5b                   	pop    %ebx
 2a4:	5d                   	pop    %ebp
 2a5:	c3                   	ret    
 2a6:	66 90                	xchg   %ax,%ax

000002a8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2a8:	55                   	push   %ebp
 2a9:	89 e5                	mov    %esp,%ebp
 2ab:	56                   	push   %esi
 2ac:	53                   	push   %ebx
 2ad:	8b 45 08             	mov    0x8(%ebp),%eax
 2b0:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 2b3:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2b6:	85 f6                	test   %esi,%esi
 2b8:	7e 0d                	jle    2c7 <memmove+0x1f>
 2ba:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 2bc:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 2bf:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2c2:	42                   	inc    %edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2c3:	39 f2                	cmp    %esi,%edx
 2c5:	75 f5                	jne    2bc <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 2c7:	5b                   	pop    %ebx
 2c8:	5e                   	pop    %esi
 2c9:	5d                   	pop    %ebp
 2ca:	c3                   	ret    

000002cb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2cb:	b8 01 00 00 00       	mov    $0x1,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret    

000002d3 <exit>:
SYSCALL(exit)
 2d3:	b8 02 00 00 00       	mov    $0x2,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret    

000002db <wait>:
SYSCALL(wait)
 2db:	b8 03 00 00 00       	mov    $0x3,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret    

000002e3 <pipe>:
SYSCALL(pipe)
 2e3:	b8 04 00 00 00       	mov    $0x4,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret    

000002eb <read>:
SYSCALL(read)
 2eb:	b8 05 00 00 00       	mov    $0x5,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret    

000002f3 <write>:
SYSCALL(write)
 2f3:	b8 10 00 00 00       	mov    $0x10,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret    

000002fb <close>:
SYSCALL(close)
 2fb:	b8 15 00 00 00       	mov    $0x15,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret    

00000303 <kill>:
SYSCALL(kill)
 303:	b8 06 00 00 00       	mov    $0x6,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret    

0000030b <exec>:
SYSCALL(exec)
 30b:	b8 07 00 00 00       	mov    $0x7,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret    

00000313 <open>:
SYSCALL(open)
 313:	b8 0f 00 00 00       	mov    $0xf,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret    

0000031b <mknod>:
SYSCALL(mknod)
 31b:	b8 11 00 00 00       	mov    $0x11,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <unlink>:
SYSCALL(unlink)
 323:	b8 12 00 00 00       	mov    $0x12,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    

0000032b <fstat>:
SYSCALL(fstat)
 32b:	b8 08 00 00 00       	mov    $0x8,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    

00000333 <link>:
SYSCALL(link)
 333:	b8 13 00 00 00       	mov    $0x13,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <mkdir>:
SYSCALL(mkdir)
 33b:	b8 14 00 00 00       	mov    $0x14,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    

00000343 <chdir>:
SYSCALL(chdir)
 343:	b8 09 00 00 00       	mov    $0x9,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret    

0000034b <dup>:
SYSCALL(dup)
 34b:	b8 0a 00 00 00       	mov    $0xa,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <getpid>:
SYSCALL(getpid)
 353:	b8 0b 00 00 00       	mov    $0xb,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    

0000035b <sbrk>:
SYSCALL(sbrk)
 35b:	b8 0c 00 00 00       	mov    $0xc,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret    

00000363 <sleep>:
SYSCALL(sleep)
 363:	b8 0d 00 00 00       	mov    $0xd,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret    

0000036b <uptime>:
SYSCALL(uptime)
 36b:	b8 0e 00 00 00       	mov    $0xe,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    
