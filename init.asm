
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   f:	83 ec 08             	sub    $0x8,%esp
  12:	6a 02                	push   $0x2
  14:	68 b4 06 00 00       	push   $0x6b4
  19:	e8 b1 02 00 00       	call   2cf <open>
  1e:	83 c4 10             	add    $0x10,%esp
  21:	85 c0                	test   %eax,%eax
  23:	0f 88 93 00 00 00    	js     bc <main+0xbc>
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  29:	83 ec 0c             	sub    $0xc,%esp
  2c:	6a 00                	push   $0x0
  2e:	e8 d4 02 00 00       	call   307 <dup>
  dup(0);  // stderr
  33:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  3a:	e8 c8 02 00 00       	call   307 <dup>
  3f:	83 c4 10             	add    $0x10,%esp
  42:	66 90                	xchg   %ax,%ax

  for(;;){
    printf(1, "init: starting sh\n");
  44:	83 ec 08             	sub    $0x8,%esp
  47:	68 bc 06 00 00       	push   $0x6bc
  4c:	6a 01                	push   $0x1
  4e:	e8 61 03 00 00       	call   3b4 <printf>
    pid = fork();
  53:	e8 2f 02 00 00       	call   287 <fork>
  58:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
  5a:	83 c4 10             	add    $0x10,%esp
  5d:	85 c0                	test   %eax,%eax
  5f:	78 24                	js     85 <main+0x85>
      printf(1, "init: fork failed\n");
      exit();
    }
    if(pid == 0){
  61:	74 35                	je     98 <main+0x98>
  63:	90                   	nop
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  64:	e8 2e 02 00 00       	call   297 <wait>
  69:	85 c0                	test   %eax,%eax
  6b:	78 d7                	js     44 <main+0x44>
  6d:	39 c3                	cmp    %eax,%ebx
  6f:	74 d3                	je     44 <main+0x44>
      printf(1, "zombie!\n");
  71:	83 ec 08             	sub    $0x8,%esp
  74:	68 fb 06 00 00       	push   $0x6fb
  79:	6a 01                	push   $0x1
  7b:	e8 34 03 00 00       	call   3b4 <printf>
  80:	83 c4 10             	add    $0x10,%esp
  83:	eb df                	jmp    64 <main+0x64>

  for(;;){
    printf(1, "init: starting sh\n");
    pid = fork();
    if(pid < 0){
      printf(1, "init: fork failed\n");
  85:	53                   	push   %ebx
  86:	53                   	push   %ebx
  87:	68 cf 06 00 00       	push   $0x6cf
  8c:	6a 01                	push   $0x1
  8e:	e8 21 03 00 00       	call   3b4 <printf>
      exit();
  93:	e8 f7 01 00 00       	call   28f <exit>
    }
    if(pid == 0){
      exec("sh", argv);
  98:	50                   	push   %eax
  99:	50                   	push   %eax
  9a:	68 98 09 00 00       	push   $0x998
  9f:	68 e2 06 00 00       	push   $0x6e2
  a4:	e8 1e 02 00 00       	call   2c7 <exec>
      printf(1, "init: exec sh failed\n");
  a9:	5a                   	pop    %edx
  aa:	59                   	pop    %ecx
  ab:	68 e5 06 00 00       	push   $0x6e5
  b0:	6a 01                	push   $0x1
  b2:	e8 fd 02 00 00       	call   3b4 <printf>
      exit();
  b7:	e8 d3 01 00 00       	call   28f <exit>
main(void)
{
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
    mknod("console", 1, 1);
  bc:	50                   	push   %eax
  bd:	6a 01                	push   $0x1
  bf:	6a 01                	push   $0x1
  c1:	68 b4 06 00 00       	push   $0x6b4
  c6:	e8 0c 02 00 00       	call   2d7 <mknod>
    open("console", O_RDWR);
  cb:	58                   	pop    %eax
  cc:	5a                   	pop    %edx
  cd:	6a 02                	push   $0x2
  cf:	68 b4 06 00 00       	push   $0x6b4
  d4:	e8 f6 01 00 00       	call   2cf <open>
  d9:	83 c4 10             	add    $0x10,%esp
  dc:	e9 48 ff ff ff       	jmp    29 <main+0x29>
  e1:	66 90                	xchg   %ax,%ax
  e3:	90                   	nop

000000e4 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  e4:	55                   	push   %ebp
  e5:	89 e5                	mov    %esp,%ebp
  e7:	53                   	push   %ebx
  e8:	8b 45 08             	mov    0x8(%ebp),%eax
  eb:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  ee:	89 c2                	mov    %eax,%edx
  f0:	42                   	inc    %edx
  f1:	41                   	inc    %ecx
  f2:	8a 59 ff             	mov    -0x1(%ecx),%bl
  f5:	88 5a ff             	mov    %bl,-0x1(%edx)
  f8:	84 db                	test   %bl,%bl
  fa:	75 f4                	jne    f0 <strcpy+0xc>
    ;
  return os;
}
  fc:	5b                   	pop    %ebx
  fd:	5d                   	pop    %ebp
  fe:	c3                   	ret    
  ff:	90                   	nop

00000100 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	56                   	push   %esi
 104:	53                   	push   %ebx
 105:	8b 55 08             	mov    0x8(%ebp),%edx
 108:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 10b:	0f b6 02             	movzbl (%edx),%eax
 10e:	0f b6 0b             	movzbl (%ebx),%ecx
 111:	84 c0                	test   %al,%al
 113:	75 14                	jne    129 <strcmp+0x29>
 115:	eb 1d                	jmp    134 <strcmp+0x34>
 117:	90                   	nop
    p++, q++;
 118:	42                   	inc    %edx
 119:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 11c:	0f b6 02             	movzbl (%edx),%eax
 11f:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 123:	84 c0                	test   %al,%al
 125:	74 0d                	je     134 <strcmp+0x34>
 127:	89 f3                	mov    %esi,%ebx
 129:	38 c8                	cmp    %cl,%al
 12b:	74 eb                	je     118 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 12d:	29 c8                	sub    %ecx,%eax
}
 12f:	5b                   	pop    %ebx
 130:	5e                   	pop    %esi
 131:	5d                   	pop    %ebp
 132:	c3                   	ret    
 133:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 134:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 136:	29 c8                	sub    %ecx,%eax
}
 138:	5b                   	pop    %ebx
 139:	5e                   	pop    %esi
 13a:	5d                   	pop    %ebp
 13b:	c3                   	ret    

0000013c <strlen>:

uint
strlen(const char *s)
{
 13c:	55                   	push   %ebp
 13d:	89 e5                	mov    %esp,%ebp
 13f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 142:	80 39 00             	cmpb   $0x0,(%ecx)
 145:	74 10                	je     157 <strlen+0x1b>
 147:	31 d2                	xor    %edx,%edx
 149:	8d 76 00             	lea    0x0(%esi),%esi
 14c:	42                   	inc    %edx
 14d:	89 d0                	mov    %edx,%eax
 14f:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 153:	75 f7                	jne    14c <strlen+0x10>
    ;
  return n;
}
 155:	5d                   	pop    %ebp
 156:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 157:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 159:	5d                   	pop    %ebp
 15a:	c3                   	ret    
 15b:	90                   	nop

0000015c <memset>:

void*
memset(void *dst, int c, uint n)
{
 15c:	55                   	push   %ebp
 15d:	89 e5                	mov    %esp,%ebp
 15f:	57                   	push   %edi
 160:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 163:	89 d7                	mov    %edx,%edi
 165:	8b 4d 10             	mov    0x10(%ebp),%ecx
 168:	8b 45 0c             	mov    0xc(%ebp),%eax
 16b:	fc                   	cld    
 16c:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 16e:	89 d0                	mov    %edx,%eax
 170:	5f                   	pop    %edi
 171:	5d                   	pop    %ebp
 172:	c3                   	ret    
 173:	90                   	nop

00000174 <strchr>:

char*
strchr(const char *s, char c)
{
 174:	55                   	push   %ebp
 175:	89 e5                	mov    %esp,%ebp
 177:	53                   	push   %ebx
 178:	8b 45 08             	mov    0x8(%ebp),%eax
 17b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 17e:	8a 10                	mov    (%eax),%dl
 180:	84 d2                	test   %dl,%dl
 182:	74 13                	je     197 <strchr+0x23>
 184:	88 d9                	mov    %bl,%cl
    if(*s == c)
 186:	38 d3                	cmp    %dl,%bl
 188:	75 06                	jne    190 <strchr+0x1c>
 18a:	eb 0d                	jmp    199 <strchr+0x25>
 18c:	38 ca                	cmp    %cl,%dl
 18e:	74 09                	je     199 <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 190:	40                   	inc    %eax
 191:	8a 10                	mov    (%eax),%dl
 193:	84 d2                	test   %dl,%dl
 195:	75 f5                	jne    18c <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
 197:	31 c0                	xor    %eax,%eax
}
 199:	5b                   	pop    %ebx
 19a:	5d                   	pop    %ebp
 19b:	c3                   	ret    

0000019c <gets>:

char*
gets(char *buf, int max)
{
 19c:	55                   	push   %ebp
 19d:	89 e5                	mov    %esp,%ebp
 19f:	57                   	push   %edi
 1a0:	56                   	push   %esi
 1a1:	53                   	push   %ebx
 1a2:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1a5:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 1a7:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1aa:	eb 26                	jmp    1d2 <gets+0x36>
    cc = read(0, &c, 1);
 1ac:	50                   	push   %eax
 1ad:	6a 01                	push   $0x1
 1af:	57                   	push   %edi
 1b0:	6a 00                	push   $0x0
 1b2:	e8 f0 00 00 00       	call   2a7 <read>
    if(cc < 1)
 1b7:	83 c4 10             	add    $0x10,%esp
 1ba:	85 c0                	test   %eax,%eax
 1bc:	7e 1c                	jle    1da <gets+0x3e>
      break;
    buf[i++] = c;
 1be:	8a 45 e7             	mov    -0x19(%ebp),%al
 1c1:	8b 55 08             	mov    0x8(%ebp),%edx
 1c4:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1c8:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1ca:	3c 0a                	cmp    $0xa,%al
 1cc:	74 0c                	je     1da <gets+0x3e>
 1ce:	3c 0d                	cmp    $0xd,%al
 1d0:	74 08                	je     1da <gets+0x3e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1d2:	8d 5e 01             	lea    0x1(%esi),%ebx
 1d5:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1d8:	7c d2                	jl     1ac <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1da:	8b 45 08             	mov    0x8(%ebp),%eax
 1dd:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 1e1:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1e4:	5b                   	pop    %ebx
 1e5:	5e                   	pop    %esi
 1e6:	5f                   	pop    %edi
 1e7:	5d                   	pop    %ebp
 1e8:	c3                   	ret    
 1e9:	8d 76 00             	lea    0x0(%esi),%esi

000001ec <stat>:

int
stat(const char *n, struct stat *st)
{
 1ec:	55                   	push   %ebp
 1ed:	89 e5                	mov    %esp,%ebp
 1ef:	56                   	push   %esi
 1f0:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f1:	83 ec 08             	sub    $0x8,%esp
 1f4:	6a 00                	push   $0x0
 1f6:	ff 75 08             	pushl  0x8(%ebp)
 1f9:	e8 d1 00 00 00       	call   2cf <open>
  if(fd < 0)
 1fe:	83 c4 10             	add    $0x10,%esp
 201:	85 c0                	test   %eax,%eax
 203:	78 27                	js     22c <stat+0x40>
 205:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 207:	83 ec 08             	sub    $0x8,%esp
 20a:	ff 75 0c             	pushl  0xc(%ebp)
 20d:	50                   	push   %eax
 20e:	e8 d4 00 00 00       	call   2e7 <fstat>
 213:	89 c6                	mov    %eax,%esi
  close(fd);
 215:	89 1c 24             	mov    %ebx,(%esp)
 218:	e8 9a 00 00 00       	call   2b7 <close>
  return r;
 21d:	83 c4 10             	add    $0x10,%esp
 220:	89 f0                	mov    %esi,%eax
}
 222:	8d 65 f8             	lea    -0x8(%ebp),%esp
 225:	5b                   	pop    %ebx
 226:	5e                   	pop    %esi
 227:	5d                   	pop    %ebp
 228:	c3                   	ret    
 229:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 22c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 231:	eb ef                	jmp    222 <stat+0x36>
 233:	90                   	nop

00000234 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 234:	55                   	push   %ebp
 235:	89 e5                	mov    %esp,%ebp
 237:	53                   	push   %ebx
 238:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 23b:	0f be 11             	movsbl (%ecx),%edx
 23e:	8d 42 d0             	lea    -0x30(%edx),%eax
 241:	3c 09                	cmp    $0x9,%al
 243:	b8 00 00 00 00       	mov    $0x0,%eax
 248:	77 15                	ja     25f <atoi+0x2b>
 24a:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 24c:	41                   	inc    %ecx
 24d:	8d 04 80             	lea    (%eax,%eax,4),%eax
 250:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 254:	0f be 11             	movsbl (%ecx),%edx
 257:	8d 5a d0             	lea    -0x30(%edx),%ebx
 25a:	80 fb 09             	cmp    $0x9,%bl
 25d:	76 ed                	jbe    24c <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 25f:	5b                   	pop    %ebx
 260:	5d                   	pop    %ebp
 261:	c3                   	ret    
 262:	66 90                	xchg   %ax,%ax

00000264 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 264:	55                   	push   %ebp
 265:	89 e5                	mov    %esp,%ebp
 267:	56                   	push   %esi
 268:	53                   	push   %ebx
 269:	8b 45 08             	mov    0x8(%ebp),%eax
 26c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 26f:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 272:	85 f6                	test   %esi,%esi
 274:	7e 0d                	jle    283 <memmove+0x1f>
 276:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 278:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 27b:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 27e:	42                   	inc    %edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 27f:	39 f2                	cmp    %esi,%edx
 281:	75 f5                	jne    278 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 283:	5b                   	pop    %ebx
 284:	5e                   	pop    %esi
 285:	5d                   	pop    %ebp
 286:	c3                   	ret    

00000287 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 287:	b8 01 00 00 00       	mov    $0x1,%eax
 28c:	cd 40                	int    $0x40
 28e:	c3                   	ret    

0000028f <exit>:
SYSCALL(exit)
 28f:	b8 02 00 00 00       	mov    $0x2,%eax
 294:	cd 40                	int    $0x40
 296:	c3                   	ret    

00000297 <wait>:
SYSCALL(wait)
 297:	b8 03 00 00 00       	mov    $0x3,%eax
 29c:	cd 40                	int    $0x40
 29e:	c3                   	ret    

0000029f <pipe>:
SYSCALL(pipe)
 29f:	b8 04 00 00 00       	mov    $0x4,%eax
 2a4:	cd 40                	int    $0x40
 2a6:	c3                   	ret    

000002a7 <read>:
SYSCALL(read)
 2a7:	b8 05 00 00 00       	mov    $0x5,%eax
 2ac:	cd 40                	int    $0x40
 2ae:	c3                   	ret    

000002af <write>:
SYSCALL(write)
 2af:	b8 10 00 00 00       	mov    $0x10,%eax
 2b4:	cd 40                	int    $0x40
 2b6:	c3                   	ret    

000002b7 <close>:
SYSCALL(close)
 2b7:	b8 15 00 00 00       	mov    $0x15,%eax
 2bc:	cd 40                	int    $0x40
 2be:	c3                   	ret    

000002bf <kill>:
SYSCALL(kill)
 2bf:	b8 06 00 00 00       	mov    $0x6,%eax
 2c4:	cd 40                	int    $0x40
 2c6:	c3                   	ret    

000002c7 <exec>:
SYSCALL(exec)
 2c7:	b8 07 00 00 00       	mov    $0x7,%eax
 2cc:	cd 40                	int    $0x40
 2ce:	c3                   	ret    

000002cf <open>:
SYSCALL(open)
 2cf:	b8 0f 00 00 00       	mov    $0xf,%eax
 2d4:	cd 40                	int    $0x40
 2d6:	c3                   	ret    

000002d7 <mknod>:
SYSCALL(mknod)
 2d7:	b8 11 00 00 00       	mov    $0x11,%eax
 2dc:	cd 40                	int    $0x40
 2de:	c3                   	ret    

000002df <unlink>:
SYSCALL(unlink)
 2df:	b8 12 00 00 00       	mov    $0x12,%eax
 2e4:	cd 40                	int    $0x40
 2e6:	c3                   	ret    

000002e7 <fstat>:
SYSCALL(fstat)
 2e7:	b8 08 00 00 00       	mov    $0x8,%eax
 2ec:	cd 40                	int    $0x40
 2ee:	c3                   	ret    

000002ef <link>:
SYSCALL(link)
 2ef:	b8 13 00 00 00       	mov    $0x13,%eax
 2f4:	cd 40                	int    $0x40
 2f6:	c3                   	ret    

000002f7 <mkdir>:
SYSCALL(mkdir)
 2f7:	b8 14 00 00 00       	mov    $0x14,%eax
 2fc:	cd 40                	int    $0x40
 2fe:	c3                   	ret    

000002ff <chdir>:
SYSCALL(chdir)
 2ff:	b8 09 00 00 00       	mov    $0x9,%eax
 304:	cd 40                	int    $0x40
 306:	c3                   	ret    

00000307 <dup>:
SYSCALL(dup)
 307:	b8 0a 00 00 00       	mov    $0xa,%eax
 30c:	cd 40                	int    $0x40
 30e:	c3                   	ret    

0000030f <getpid>:
SYSCALL(getpid)
 30f:	b8 0b 00 00 00       	mov    $0xb,%eax
 314:	cd 40                	int    $0x40
 316:	c3                   	ret    

00000317 <sbrk>:
SYSCALL(sbrk)
 317:	b8 0c 00 00 00       	mov    $0xc,%eax
 31c:	cd 40                	int    $0x40
 31e:	c3                   	ret    

0000031f <sleep>:
SYSCALL(sleep)
 31f:	b8 0d 00 00 00       	mov    $0xd,%eax
 324:	cd 40                	int    $0x40
 326:	c3                   	ret    

00000327 <uptime>:
SYSCALL(uptime)
 327:	b8 0e 00 00 00       	mov    $0xe,%eax
 32c:	cd 40                	int    $0x40
 32e:	c3                   	ret    
 32f:	90                   	nop

00000330 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	57                   	push   %edi
 334:	56                   	push   %esi
 335:	53                   	push   %ebx
 336:	83 ec 3c             	sub    $0x3c,%esp
 339:	89 c6                	mov    %eax,%esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 33b:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 33d:	8b 5d 08             	mov    0x8(%ebp),%ebx
 340:	85 db                	test   %ebx,%ebx
 342:	74 04                	je     348 <printint+0x18>
 344:	85 d2                	test   %edx,%edx
 346:	78 5f                	js     3a7 <printint+0x77>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 348:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 34f:	31 ff                	xor    %edi,%edi
 351:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 354:	89 75 c4             	mov    %esi,-0x3c(%ebp)
 357:	89 ce                	mov    %ecx,%esi
 359:	eb 03                	jmp    35e <printint+0x2e>
 35b:	90                   	nop
  do{
    buf[i++] = digits[x % base];
 35c:	89 cf                	mov    %ecx,%edi
 35e:	8d 4f 01             	lea    0x1(%edi),%ecx
 361:	31 d2                	xor    %edx,%edx
 363:	f7 f6                	div    %esi
 365:	8a 92 0c 07 00 00    	mov    0x70c(%edx),%dl
 36b:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 36e:	85 c0                	test   %eax,%eax
 370:	75 ea                	jne    35c <printint+0x2c>
 372:	8b 75 c4             	mov    -0x3c(%ebp),%esi
  if(neg)
 375:	8b 55 c0             	mov    -0x40(%ebp),%edx
 378:	85 d2                	test   %edx,%edx
 37a:	74 08                	je     384 <printint+0x54>
    buf[i++] = '-';
 37c:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 381:	8d 4f 02             	lea    0x2(%edi),%ecx
 384:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 388:	8a 07                	mov    (%edi),%al
 38a:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 38d:	50                   	push   %eax
 38e:	6a 01                	push   $0x1
 390:	53                   	push   %ebx
 391:	56                   	push   %esi
 392:	e8 18 ff ff ff       	call   2af <write>
 397:	4f                   	dec    %edi
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 398:	83 c4 10             	add    $0x10,%esp
 39b:	39 df                	cmp    %ebx,%edi
 39d:	75 e9                	jne    388 <printint+0x58>
    putc(fd, buf[i]);
}
 39f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3a2:	5b                   	pop    %ebx
 3a3:	5e                   	pop    %esi
 3a4:	5f                   	pop    %edi
 3a5:	5d                   	pop    %ebp
 3a6:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3a7:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 3a9:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 3b0:	eb 9d                	jmp    34f <printint+0x1f>
 3b2:	66 90                	xchg   %ax,%ax

000003b4 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 3b4:	55                   	push   %ebp
 3b5:	89 e5                	mov    %esp,%ebp
 3b7:	57                   	push   %edi
 3b8:	56                   	push   %esi
 3b9:	53                   	push   %ebx
 3ba:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3bd:	8b 75 0c             	mov    0xc(%ebp),%esi
 3c0:	8a 1e                	mov    (%esi),%bl
 3c2:	84 db                	test   %bl,%bl
 3c4:	0f 84 a6 00 00 00    	je     470 <printf+0xbc>
 3ca:	46                   	inc    %esi
 3cb:	8d 45 10             	lea    0x10(%ebp),%eax
 3ce:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 3d1:	31 ff                	xor    %edi,%edi
 3d3:	eb 29                	jmp    3fe <printf+0x4a>
 3d5:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 3d8:	83 f8 25             	cmp    $0x25,%eax
 3db:	0f 84 97 00 00 00    	je     478 <printf+0xc4>
 3e1:	88 5d e2             	mov    %bl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3e4:	50                   	push   %eax
 3e5:	6a 01                	push   $0x1
 3e7:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 3ea:	50                   	push   %eax
 3eb:	ff 75 08             	pushl  0x8(%ebp)
 3ee:	e8 bc fe ff ff       	call   2af <write>
 3f3:	83 c4 10             	add    $0x10,%esp
 3f6:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3f7:	8a 5e ff             	mov    -0x1(%esi),%bl
 3fa:	84 db                	test   %bl,%bl
 3fc:	74 72                	je     470 <printf+0xbc>
    c = fmt[i] & 0xff;
 3fe:	0f be cb             	movsbl %bl,%ecx
 401:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 404:	85 ff                	test   %edi,%edi
 406:	74 d0                	je     3d8 <printf+0x24>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 408:	83 ff 25             	cmp    $0x25,%edi
 40b:	75 e9                	jne    3f6 <printf+0x42>
      if(c == 'd'){
 40d:	83 f8 64             	cmp    $0x64,%eax
 410:	0f 84 f6 00 00 00    	je     50c <printf+0x158>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 416:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 41c:	83 f9 70             	cmp    $0x70,%ecx
 41f:	74 63                	je     484 <printf+0xd0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 421:	83 f8 73             	cmp    $0x73,%eax
 424:	0f 84 86 00 00 00    	je     4b0 <printf+0xfc>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 42a:	83 f8 63             	cmp    $0x63,%eax
 42d:	0f 84 be 00 00 00    	je     4f1 <printf+0x13d>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 433:	83 f8 25             	cmp    $0x25,%eax
 436:	0f 84 e0 00 00 00    	je     51c <printf+0x168>
 43c:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 440:	50                   	push   %eax
 441:	6a 01                	push   $0x1
 443:	8d 45 e7             	lea    -0x19(%ebp),%eax
 446:	50                   	push   %eax
 447:	ff 75 08             	pushl  0x8(%ebp)
 44a:	e8 60 fe ff ff       	call   2af <write>
 44f:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 452:	83 c4 0c             	add    $0xc,%esp
 455:	6a 01                	push   $0x1
 457:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 45a:	50                   	push   %eax
 45b:	ff 75 08             	pushl  0x8(%ebp)
 45e:	e8 4c fe ff ff       	call   2af <write>
 463:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 466:	31 ff                	xor    %edi,%edi
 468:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 469:	8a 5e ff             	mov    -0x1(%esi),%bl
 46c:	84 db                	test   %bl,%bl
 46e:	75 8e                	jne    3fe <printf+0x4a>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 470:	8d 65 f4             	lea    -0xc(%ebp),%esp
 473:	5b                   	pop    %ebx
 474:	5e                   	pop    %esi
 475:	5f                   	pop    %edi
 476:	5d                   	pop    %ebp
 477:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 478:	bf 25 00 00 00       	mov    $0x25,%edi
 47d:	e9 74 ff ff ff       	jmp    3f6 <printf+0x42>
 482:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 484:	83 ec 0c             	sub    $0xc,%esp
 487:	6a 00                	push   $0x0
 489:	b9 10 00 00 00       	mov    $0x10,%ecx
 48e:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 491:	8b 17                	mov    (%edi),%edx
 493:	8b 45 08             	mov    0x8(%ebp),%eax
 496:	e8 95 fe ff ff       	call   330 <printint>
        ap++;
 49b:	89 f8                	mov    %edi,%eax
 49d:	83 c0 04             	add    $0x4,%eax
 4a0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 4a3:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4a6:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 4a8:	e9 49 ff ff ff       	jmp    3f6 <printf+0x42>
 4ad:	8d 76 00             	lea    0x0(%esi),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 4b0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 4b3:	8b 38                	mov    (%eax),%edi
        ap++;
 4b5:	83 c0 04             	add    $0x4,%eax
 4b8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 4bb:	85 ff                	test   %edi,%edi
 4bd:	74 6b                	je     52a <printf+0x176>
          s = "(null)";
        while(*s != 0){
 4bf:	8a 07                	mov    (%edi),%al
 4c1:	84 c0                	test   %al,%al
 4c3:	74 6c                	je     531 <printf+0x17d>
 4c5:	8d 5d e3             	lea    -0x1d(%ebp),%ebx
 4c8:	89 75 d0             	mov    %esi,-0x30(%ebp)
 4cb:	89 fe                	mov    %edi,%esi
 4cd:	8b 7d 08             	mov    0x8(%ebp),%edi
 4d0:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4d3:	50                   	push   %eax
 4d4:	6a 01                	push   $0x1
 4d6:	53                   	push   %ebx
 4d7:	57                   	push   %edi
 4d8:	e8 d2 fd ff ff       	call   2af <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 4dd:	46                   	inc    %esi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 4de:	8a 06                	mov    (%esi),%al
 4e0:	83 c4 10             	add    $0x10,%esp
 4e3:	84 c0                	test   %al,%al
 4e5:	75 e9                	jne    4d0 <printf+0x11c>
 4e7:	8b 75 d0             	mov    -0x30(%ebp),%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4ea:	31 ff                	xor    %edi,%edi
 4ec:	e9 05 ff ff ff       	jmp    3f6 <printf+0x42>
 4f1:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 4f4:	8b 07                	mov    (%edi),%eax
 4f6:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4f9:	51                   	push   %ecx
 4fa:	6a 01                	push   $0x1
 4fc:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 4ff:	50                   	push   %eax
 500:	ff 75 08             	pushl  0x8(%ebp)
 503:	e8 a7 fd ff ff       	call   2af <write>
 508:	eb 91                	jmp    49b <printf+0xe7>
 50a:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 50c:	83 ec 0c             	sub    $0xc,%esp
 50f:	6a 01                	push   $0x1
 511:	b9 0a 00 00 00       	mov    $0xa,%ecx
 516:	e9 73 ff ff ff       	jmp    48e <printf+0xda>
 51b:	90                   	nop
 51c:	88 5d e5             	mov    %bl,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 51f:	52                   	push   %edx
 520:	6a 01                	push   $0x1
 522:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 525:	e9 30 ff ff ff       	jmp    45a <printf+0xa6>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
 52a:	bf 04 07 00 00       	mov    $0x704,%edi
 52f:	eb 8e                	jmp    4bf <printf+0x10b>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 531:	31 ff                	xor    %edi,%edi
 533:	e9 be fe ff ff       	jmp    3f6 <printf+0x42>

00000538 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 538:	55                   	push   %ebp
 539:	89 e5                	mov    %esp,%ebp
 53b:	57                   	push   %edi
 53c:	56                   	push   %esi
 53d:	53                   	push   %ebx
 53e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 541:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 544:	a1 a0 09 00 00       	mov    0x9a0,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 549:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 54b:	39 c8                	cmp    %ecx,%eax
 54d:	73 11                	jae    560 <free+0x28>
 54f:	90                   	nop
 550:	39 d1                	cmp    %edx,%ecx
 552:	72 14                	jb     568 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 554:	39 d0                	cmp    %edx,%eax
 556:	73 10                	jae    568 <free+0x30>
static Header base;
static Header *freep;

void
free(void *ap)
{
 558:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 55a:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 55c:	39 c8                	cmp    %ecx,%eax
 55e:	72 f0                	jb     550 <free+0x18>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 560:	39 d0                	cmp    %edx,%eax
 562:	72 f4                	jb     558 <free+0x20>
 564:	39 d1                	cmp    %edx,%ecx
 566:	73 f0                	jae    558 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 568:	8b 73 fc             	mov    -0x4(%ebx),%esi
 56b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 56e:	39 d7                	cmp    %edx,%edi
 570:	74 19                	je     58b <free+0x53>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 572:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 575:	8b 50 04             	mov    0x4(%eax),%edx
 578:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 57b:	39 f1                	cmp    %esi,%ecx
 57d:	74 23                	je     5a2 <free+0x6a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 57f:	89 08                	mov    %ecx,(%eax)
  freep = p;
 581:	a3 a0 09 00 00       	mov    %eax,0x9a0
}
 586:	5b                   	pop    %ebx
 587:	5e                   	pop    %esi
 588:	5f                   	pop    %edi
 589:	5d                   	pop    %ebp
 58a:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 58b:	03 72 04             	add    0x4(%edx),%esi
 58e:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 591:	8b 10                	mov    (%eax),%edx
 593:	8b 12                	mov    (%edx),%edx
 595:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 598:	8b 50 04             	mov    0x4(%eax),%edx
 59b:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 59e:	39 f1                	cmp    %esi,%ecx
 5a0:	75 dd                	jne    57f <free+0x47>
    p->s.size += bp->s.size;
 5a2:	03 53 fc             	add    -0x4(%ebx),%edx
 5a5:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 5a8:	8b 53 f8             	mov    -0x8(%ebx),%edx
 5ab:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 5ad:	a3 a0 09 00 00       	mov    %eax,0x9a0
}
 5b2:	5b                   	pop    %ebx
 5b3:	5e                   	pop    %esi
 5b4:	5f                   	pop    %edi
 5b5:	5d                   	pop    %ebp
 5b6:	c3                   	ret    
 5b7:	90                   	nop

000005b8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 5b8:	55                   	push   %ebp
 5b9:	89 e5                	mov    %esp,%ebp
 5bb:	57                   	push   %edi
 5bc:	56                   	push   %esi
 5bd:	53                   	push   %ebx
 5be:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5c1:	8b 45 08             	mov    0x8(%ebp),%eax
 5c4:	8d 78 07             	lea    0x7(%eax),%edi
 5c7:	c1 ef 03             	shr    $0x3,%edi
 5ca:	47                   	inc    %edi
  if((prevp = freep) == 0){
 5cb:	8b 15 a0 09 00 00    	mov    0x9a0,%edx
 5d1:	85 d2                	test   %edx,%edx
 5d3:	0f 84 b1 00 00 00    	je     68a <malloc+0xd2>
 5d9:	8b 02                	mov    (%edx),%eax
 5db:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 5de:	39 cf                	cmp    %ecx,%edi
 5e0:	76 66                	jbe    648 <malloc+0x90>
 5e2:	89 fb                	mov    %edi,%ebx
 5e4:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 5ea:	0f 82 80 00 00 00    	jb     670 <malloc+0xb8>
 5f0:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 5f6:	76 70                	jbe    668 <malloc+0xb0>
 5f8:	8d 34 fd 00 00 00 00 	lea    0x0(,%edi,8),%esi
 5ff:	eb 0c                	jmp    60d <malloc+0x55>
 601:	8d 76 00             	lea    0x0(%esi),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 604:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 606:	8b 48 04             	mov    0x4(%eax),%ecx
 609:	39 cf                	cmp    %ecx,%edi
 60b:	76 3b                	jbe    648 <malloc+0x90>
 60d:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 60f:	39 05 a0 09 00 00    	cmp    %eax,0x9a0
 615:	75 ed                	jne    604 <malloc+0x4c>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 617:	83 ec 0c             	sub    $0xc,%esp
 61a:	56                   	push   %esi
 61b:	e8 f7 fc ff ff       	call   317 <sbrk>
  if(p == (char*)-1)
 620:	83 c4 10             	add    $0x10,%esp
 623:	83 f8 ff             	cmp    $0xffffffff,%eax
 626:	74 1c                	je     644 <malloc+0x8c>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 628:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 62b:	83 ec 0c             	sub    $0xc,%esp
 62e:	83 c0 08             	add    $0x8,%eax
 631:	50                   	push   %eax
 632:	e8 01 ff ff ff       	call   538 <free>
  return freep;
 637:	8b 15 a0 09 00 00    	mov    0x9a0,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 63d:	83 c4 10             	add    $0x10,%esp
 640:	85 d2                	test   %edx,%edx
 642:	75 c0                	jne    604 <malloc+0x4c>
        return 0;
 644:	31 c0                	xor    %eax,%eax
 646:	eb 18                	jmp    660 <malloc+0xa8>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 648:	39 cf                	cmp    %ecx,%edi
 64a:	74 38                	je     684 <malloc+0xcc>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 64c:	29 f9                	sub    %edi,%ecx
 64e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 651:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 654:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 657:	89 15 a0 09 00 00    	mov    %edx,0x9a0
      return (void*)(p + 1);
 65d:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 660:	8d 65 f4             	lea    -0xc(%ebp),%esp
 663:	5b                   	pop    %ebx
 664:	5e                   	pop    %esi
 665:	5f                   	pop    %edi
 666:	5d                   	pop    %ebp
 667:	c3                   	ret    
 668:	be 00 80 00 00       	mov    $0x8000,%esi
 66d:	eb 9e                	jmp    60d <malloc+0x55>
 66f:	90                   	nop
 670:	bb 00 10 00 00       	mov    $0x1000,%ebx
 675:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 67b:	76 eb                	jbe    668 <malloc+0xb0>
 67d:	e9 76 ff ff ff       	jmp    5f8 <malloc+0x40>
 682:	66 90                	xchg   %ax,%ax
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 684:	8b 08                	mov    (%eax),%ecx
 686:	89 0a                	mov    %ecx,(%edx)
 688:	eb cd                	jmp    657 <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 68a:	c7 05 a0 09 00 00 a4 	movl   $0x9a4,0x9a0
 691:	09 00 00 
 694:	c7 05 a4 09 00 00 a4 	movl   $0x9a4,0x9a4
 69b:	09 00 00 
    base.s.size = 0;
 69e:	c7 05 a8 09 00 00 00 	movl   $0x0,0x9a8
 6a5:	00 00 00 
 6a8:	b8 a4 09 00 00       	mov    $0x9a4,%eax
 6ad:	e9 30 ff ff ff       	jmp    5e2 <malloc+0x2a>
