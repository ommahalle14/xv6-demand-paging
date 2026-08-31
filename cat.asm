
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  }
}

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
  11:	83 ec 18             	sub    $0x18,%esp
  14:	8b 39                	mov    (%ecx),%edi
  16:	8b 59 04             	mov    0x4(%ecx),%ebx
  int fd, i;

  if(argc <= 1){
  19:	83 ff 01             	cmp    $0x1,%edi
  1c:	7e 58                	jle    76 <main+0x76>
  1e:	83 c3 04             	add    $0x4,%ebx
  21:	be 01 00 00 00       	mov    $0x1,%esi
  26:	66 90                	xchg   %ax,%ax
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  28:	83 ec 08             	sub    $0x8,%esp
  2b:	6a 00                	push   $0x0
  2d:	ff 33                	pushl  (%ebx)
  2f:	e8 af 02 00 00       	call   2e3 <open>
  34:	83 c4 10             	add    $0x10,%esp
  37:	85 c0                	test   %eax,%eax
  39:	78 27                	js     62 <main+0x62>
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
  3b:	83 ec 0c             	sub    $0xc,%esp
  3e:	50                   	push   %eax
  3f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  42:	e8 41 00 00 00       	call   88 <cat>
    close(fd);
  47:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  4a:	89 04 24             	mov    %eax,(%esp)
  4d:	e8 79 02 00 00       	call   2cb <close>
  if(argc <= 1){
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
  52:	46                   	inc    %esi
  53:	83 c3 04             	add    $0x4,%ebx
  56:	83 c4 10             	add    $0x10,%esp
  59:	39 f7                	cmp    %esi,%edi
  5b:	75 cb                	jne    28 <main+0x28>
      exit();
    }
    cat(fd);
    close(fd);
  }
  exit();
  5d:	e8 41 02 00 00       	call   2a3 <exit>
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
  62:	50                   	push   %eax
  63:	ff 33                	pushl  (%ebx)
  65:	68 eb 06 00 00       	push   $0x6eb
  6a:	6a 01                	push   $0x1
  6c:	e8 57 03 00 00       	call   3c8 <printf>
      exit();
  71:	e8 2d 02 00 00       	call   2a3 <exit>
main(int argc, char *argv[])
{
  int fd, i;

  if(argc <= 1){
    cat(0);
  76:	83 ec 0c             	sub    $0xc,%esp
  79:	6a 00                	push   $0x0
  7b:	e8 08 00 00 00       	call   88 <cat>
    exit();
  80:	e8 1e 02 00 00       	call   2a3 <exit>
  85:	66 90                	xchg   %ax,%ax
  87:	90                   	nop

00000088 <cat>:

char buf[512];

void
cat(int fd)
{
  88:	55                   	push   %ebp
  89:	89 e5                	mov    %esp,%ebp
  8b:	56                   	push   %esi
  8c:	53                   	push   %ebx
  8d:	8b 75 08             	mov    0x8(%ebp),%esi
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
  90:	eb 17                	jmp    a9 <cat+0x21>
  92:	66 90                	xchg   %ax,%ax
    if (write(1, buf, n) != n) {
  94:	52                   	push   %edx
  95:	53                   	push   %ebx
  96:	68 00 0a 00 00       	push   $0xa00
  9b:	6a 01                	push   $0x1
  9d:	e8 21 02 00 00       	call   2c3 <write>
  a2:	83 c4 10             	add    $0x10,%esp
  a5:	39 c3                	cmp    %eax,%ebx
  a7:	75 24                	jne    cd <cat+0x45>
void
cat(int fd)
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
  a9:	50                   	push   %eax
  aa:	68 00 02 00 00       	push   $0x200
  af:	68 00 0a 00 00       	push   $0xa00
  b4:	56                   	push   %esi
  b5:	e8 01 02 00 00       	call   2bb <read>
  ba:	89 c3                	mov    %eax,%ebx
  bc:	83 c4 10             	add    $0x10,%esp
  bf:	83 f8 00             	cmp    $0x0,%eax
  c2:	7f d0                	jg     94 <cat+0xc>
    if (write(1, buf, n) != n) {
      printf(1, "cat: write error\n");
      exit();
    }
  }
  if(n < 0){
  c4:	75 1b                	jne    e1 <cat+0x59>
    printf(1, "cat: read error\n");
    exit();
  }
}
  c6:	8d 65 f8             	lea    -0x8(%ebp),%esp
  c9:	5b                   	pop    %ebx
  ca:	5e                   	pop    %esi
  cb:	5d                   	pop    %ebp
  cc:	c3                   	ret    
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
    if (write(1, buf, n) != n) {
      printf(1, "cat: write error\n");
  cd:	83 ec 08             	sub    $0x8,%esp
  d0:	68 c8 06 00 00       	push   $0x6c8
  d5:	6a 01                	push   $0x1
  d7:	e8 ec 02 00 00       	call   3c8 <printf>
      exit();
  dc:	e8 c2 01 00 00       	call   2a3 <exit>
    }
  }
  if(n < 0){
    printf(1, "cat: read error\n");
  e1:	83 ec 08             	sub    $0x8,%esp
  e4:	68 da 06 00 00       	push   $0x6da
  e9:	6a 01                	push   $0x1
  eb:	e8 d8 02 00 00       	call   3c8 <printf>
    exit();
  f0:	e8 ae 01 00 00       	call   2a3 <exit>
  f5:	66 90                	xchg   %ax,%ax
  f7:	90                   	nop

000000f8 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  f8:	55                   	push   %ebp
  f9:	89 e5                	mov    %esp,%ebp
  fb:	53                   	push   %ebx
  fc:	8b 45 08             	mov    0x8(%ebp),%eax
  ff:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 102:	89 c2                	mov    %eax,%edx
 104:	42                   	inc    %edx
 105:	41                   	inc    %ecx
 106:	8a 59 ff             	mov    -0x1(%ecx),%bl
 109:	88 5a ff             	mov    %bl,-0x1(%edx)
 10c:	84 db                	test   %bl,%bl
 10e:	75 f4                	jne    104 <strcpy+0xc>
    ;
  return os;
}
 110:	5b                   	pop    %ebx
 111:	5d                   	pop    %ebp
 112:	c3                   	ret    
 113:	90                   	nop

00000114 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 114:	55                   	push   %ebp
 115:	89 e5                	mov    %esp,%ebp
 117:	56                   	push   %esi
 118:	53                   	push   %ebx
 119:	8b 55 08             	mov    0x8(%ebp),%edx
 11c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 11f:	0f b6 02             	movzbl (%edx),%eax
 122:	0f b6 0b             	movzbl (%ebx),%ecx
 125:	84 c0                	test   %al,%al
 127:	75 14                	jne    13d <strcmp+0x29>
 129:	eb 1d                	jmp    148 <strcmp+0x34>
 12b:	90                   	nop
    p++, q++;
 12c:	42                   	inc    %edx
 12d:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 130:	0f b6 02             	movzbl (%edx),%eax
 133:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 137:	84 c0                	test   %al,%al
 139:	74 0d                	je     148 <strcmp+0x34>
 13b:	89 f3                	mov    %esi,%ebx
 13d:	38 c8                	cmp    %cl,%al
 13f:	74 eb                	je     12c <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 141:	29 c8                	sub    %ecx,%eax
}
 143:	5b                   	pop    %ebx
 144:	5e                   	pop    %esi
 145:	5d                   	pop    %ebp
 146:	c3                   	ret    
 147:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 148:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 14a:	29 c8                	sub    %ecx,%eax
}
 14c:	5b                   	pop    %ebx
 14d:	5e                   	pop    %esi
 14e:	5d                   	pop    %ebp
 14f:	c3                   	ret    

00000150 <strlen>:

uint
strlen(const char *s)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 156:	80 39 00             	cmpb   $0x0,(%ecx)
 159:	74 10                	je     16b <strlen+0x1b>
 15b:	31 d2                	xor    %edx,%edx
 15d:	8d 76 00             	lea    0x0(%esi),%esi
 160:	42                   	inc    %edx
 161:	89 d0                	mov    %edx,%eax
 163:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 167:	75 f7                	jne    160 <strlen+0x10>
    ;
  return n;
}
 169:	5d                   	pop    %ebp
 16a:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 16b:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 16d:	5d                   	pop    %ebp
 16e:	c3                   	ret    
 16f:	90                   	nop

00000170 <memset>:

void*
memset(void *dst, int c, uint n)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	57                   	push   %edi
 174:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 177:	89 d7                	mov    %edx,%edi
 179:	8b 4d 10             	mov    0x10(%ebp),%ecx
 17c:	8b 45 0c             	mov    0xc(%ebp),%eax
 17f:	fc                   	cld    
 180:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 182:	89 d0                	mov    %edx,%eax
 184:	5f                   	pop    %edi
 185:	5d                   	pop    %ebp
 186:	c3                   	ret    
 187:	90                   	nop

00000188 <strchr>:

char*
strchr(const char *s, char c)
{
 188:	55                   	push   %ebp
 189:	89 e5                	mov    %esp,%ebp
 18b:	53                   	push   %ebx
 18c:	8b 45 08             	mov    0x8(%ebp),%eax
 18f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 192:	8a 10                	mov    (%eax),%dl
 194:	84 d2                	test   %dl,%dl
 196:	74 13                	je     1ab <strchr+0x23>
 198:	88 d9                	mov    %bl,%cl
    if(*s == c)
 19a:	38 d3                	cmp    %dl,%bl
 19c:	75 06                	jne    1a4 <strchr+0x1c>
 19e:	eb 0d                	jmp    1ad <strchr+0x25>
 1a0:	38 ca                	cmp    %cl,%dl
 1a2:	74 09                	je     1ad <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 1a4:	40                   	inc    %eax
 1a5:	8a 10                	mov    (%eax),%dl
 1a7:	84 d2                	test   %dl,%dl
 1a9:	75 f5                	jne    1a0 <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
 1ab:	31 c0                	xor    %eax,%eax
}
 1ad:	5b                   	pop    %ebx
 1ae:	5d                   	pop    %ebp
 1af:	c3                   	ret    

000001b0 <gets>:

char*
gets(char *buf, int max)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	57                   	push   %edi
 1b4:	56                   	push   %esi
 1b5:	53                   	push   %ebx
 1b6:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1b9:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 1bb:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1be:	eb 26                	jmp    1e6 <gets+0x36>
    cc = read(0, &c, 1);
 1c0:	50                   	push   %eax
 1c1:	6a 01                	push   $0x1
 1c3:	57                   	push   %edi
 1c4:	6a 00                	push   $0x0
 1c6:	e8 f0 00 00 00       	call   2bb <read>
    if(cc < 1)
 1cb:	83 c4 10             	add    $0x10,%esp
 1ce:	85 c0                	test   %eax,%eax
 1d0:	7e 1c                	jle    1ee <gets+0x3e>
      break;
    buf[i++] = c;
 1d2:	8a 45 e7             	mov    -0x19(%ebp),%al
 1d5:	8b 55 08             	mov    0x8(%ebp),%edx
 1d8:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1dc:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1de:	3c 0a                	cmp    $0xa,%al
 1e0:	74 0c                	je     1ee <gets+0x3e>
 1e2:	3c 0d                	cmp    $0xd,%al
 1e4:	74 08                	je     1ee <gets+0x3e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e6:	8d 5e 01             	lea    0x1(%esi),%ebx
 1e9:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1ec:	7c d2                	jl     1c0 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1ee:	8b 45 08             	mov    0x8(%ebp),%eax
 1f1:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 1f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1f8:	5b                   	pop    %ebx
 1f9:	5e                   	pop    %esi
 1fa:	5f                   	pop    %edi
 1fb:	5d                   	pop    %ebp
 1fc:	c3                   	ret    
 1fd:	8d 76 00             	lea    0x0(%esi),%esi

00000200 <stat>:

int
stat(const char *n, struct stat *st)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	56                   	push   %esi
 204:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 205:	83 ec 08             	sub    $0x8,%esp
 208:	6a 00                	push   $0x0
 20a:	ff 75 08             	pushl  0x8(%ebp)
 20d:	e8 d1 00 00 00       	call   2e3 <open>
  if(fd < 0)
 212:	83 c4 10             	add    $0x10,%esp
 215:	85 c0                	test   %eax,%eax
 217:	78 27                	js     240 <stat+0x40>
 219:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 21b:	83 ec 08             	sub    $0x8,%esp
 21e:	ff 75 0c             	pushl  0xc(%ebp)
 221:	50                   	push   %eax
 222:	e8 d4 00 00 00       	call   2fb <fstat>
 227:	89 c6                	mov    %eax,%esi
  close(fd);
 229:	89 1c 24             	mov    %ebx,(%esp)
 22c:	e8 9a 00 00 00       	call   2cb <close>
  return r;
 231:	83 c4 10             	add    $0x10,%esp
 234:	89 f0                	mov    %esi,%eax
}
 236:	8d 65 f8             	lea    -0x8(%ebp),%esp
 239:	5b                   	pop    %ebx
 23a:	5e                   	pop    %esi
 23b:	5d                   	pop    %ebp
 23c:	c3                   	ret    
 23d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 240:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 245:	eb ef                	jmp    236 <stat+0x36>
 247:	90                   	nop

00000248 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 248:	55                   	push   %ebp
 249:	89 e5                	mov    %esp,%ebp
 24b:	53                   	push   %ebx
 24c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 24f:	0f be 11             	movsbl (%ecx),%edx
 252:	8d 42 d0             	lea    -0x30(%edx),%eax
 255:	3c 09                	cmp    $0x9,%al
 257:	b8 00 00 00 00       	mov    $0x0,%eax
 25c:	77 15                	ja     273 <atoi+0x2b>
 25e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 260:	41                   	inc    %ecx
 261:	8d 04 80             	lea    (%eax,%eax,4),%eax
 264:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 268:	0f be 11             	movsbl (%ecx),%edx
 26b:	8d 5a d0             	lea    -0x30(%edx),%ebx
 26e:	80 fb 09             	cmp    $0x9,%bl
 271:	76 ed                	jbe    260 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 273:	5b                   	pop    %ebx
 274:	5d                   	pop    %ebp
 275:	c3                   	ret    
 276:	66 90                	xchg   %ax,%ax

00000278 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 278:	55                   	push   %ebp
 279:	89 e5                	mov    %esp,%ebp
 27b:	56                   	push   %esi
 27c:	53                   	push   %ebx
 27d:	8b 45 08             	mov    0x8(%ebp),%eax
 280:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 283:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 286:	85 f6                	test   %esi,%esi
 288:	7e 0d                	jle    297 <memmove+0x1f>
 28a:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 28c:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 28f:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 292:	42                   	inc    %edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 293:	39 f2                	cmp    %esi,%edx
 295:	75 f5                	jne    28c <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 297:	5b                   	pop    %ebx
 298:	5e                   	pop    %esi
 299:	5d                   	pop    %ebp
 29a:	c3                   	ret    

0000029b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 29b:	b8 01 00 00 00       	mov    $0x1,%eax
 2a0:	cd 40                	int    $0x40
 2a2:	c3                   	ret    

000002a3 <exit>:
SYSCALL(exit)
 2a3:	b8 02 00 00 00       	mov    $0x2,%eax
 2a8:	cd 40                	int    $0x40
 2aa:	c3                   	ret    

000002ab <wait>:
SYSCALL(wait)
 2ab:	b8 03 00 00 00       	mov    $0x3,%eax
 2b0:	cd 40                	int    $0x40
 2b2:	c3                   	ret    

000002b3 <pipe>:
SYSCALL(pipe)
 2b3:	b8 04 00 00 00       	mov    $0x4,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret    

000002bb <read>:
SYSCALL(read)
 2bb:	b8 05 00 00 00       	mov    $0x5,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret    

000002c3 <write>:
SYSCALL(write)
 2c3:	b8 10 00 00 00       	mov    $0x10,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret    

000002cb <close>:
SYSCALL(close)
 2cb:	b8 15 00 00 00       	mov    $0x15,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret    

000002d3 <kill>:
SYSCALL(kill)
 2d3:	b8 06 00 00 00       	mov    $0x6,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret    

000002db <exec>:
SYSCALL(exec)
 2db:	b8 07 00 00 00       	mov    $0x7,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret    

000002e3 <open>:
SYSCALL(open)
 2e3:	b8 0f 00 00 00       	mov    $0xf,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret    

000002eb <mknod>:
SYSCALL(mknod)
 2eb:	b8 11 00 00 00       	mov    $0x11,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret    

000002f3 <unlink>:
SYSCALL(unlink)
 2f3:	b8 12 00 00 00       	mov    $0x12,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret    

000002fb <fstat>:
SYSCALL(fstat)
 2fb:	b8 08 00 00 00       	mov    $0x8,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret    

00000303 <link>:
SYSCALL(link)
 303:	b8 13 00 00 00       	mov    $0x13,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret    

0000030b <mkdir>:
SYSCALL(mkdir)
 30b:	b8 14 00 00 00       	mov    $0x14,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret    

00000313 <chdir>:
SYSCALL(chdir)
 313:	b8 09 00 00 00       	mov    $0x9,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret    

0000031b <dup>:
SYSCALL(dup)
 31b:	b8 0a 00 00 00       	mov    $0xa,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <getpid>:
SYSCALL(getpid)
 323:	b8 0b 00 00 00       	mov    $0xb,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    

0000032b <sbrk>:
SYSCALL(sbrk)
 32b:	b8 0c 00 00 00       	mov    $0xc,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    

00000333 <sleep>:
SYSCALL(sleep)
 333:	b8 0d 00 00 00       	mov    $0xd,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <uptime>:
SYSCALL(uptime)
 33b:	b8 0e 00 00 00       	mov    $0xe,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    
 343:	90                   	nop

00000344 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 344:	55                   	push   %ebp
 345:	89 e5                	mov    %esp,%ebp
 347:	57                   	push   %edi
 348:	56                   	push   %esi
 349:	53                   	push   %ebx
 34a:	83 ec 3c             	sub    $0x3c,%esp
 34d:	89 c6                	mov    %eax,%esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 34f:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 351:	8b 5d 08             	mov    0x8(%ebp),%ebx
 354:	85 db                	test   %ebx,%ebx
 356:	74 04                	je     35c <printint+0x18>
 358:	85 d2                	test   %edx,%edx
 35a:	78 5f                	js     3bb <printint+0x77>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 35c:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 363:	31 ff                	xor    %edi,%edi
 365:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 368:	89 75 c4             	mov    %esi,-0x3c(%ebp)
 36b:	89 ce                	mov    %ecx,%esi
 36d:	eb 03                	jmp    372 <printint+0x2e>
 36f:	90                   	nop
  do{
    buf[i++] = digits[x % base];
 370:	89 cf                	mov    %ecx,%edi
 372:	8d 4f 01             	lea    0x1(%edi),%ecx
 375:	31 d2                	xor    %edx,%edx
 377:	f7 f6                	div    %esi
 379:	8a 92 08 07 00 00    	mov    0x708(%edx),%dl
 37f:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 382:	85 c0                	test   %eax,%eax
 384:	75 ea                	jne    370 <printint+0x2c>
 386:	8b 75 c4             	mov    -0x3c(%ebp),%esi
  if(neg)
 389:	8b 55 c0             	mov    -0x40(%ebp),%edx
 38c:	85 d2                	test   %edx,%edx
 38e:	74 08                	je     398 <printint+0x54>
    buf[i++] = '-';
 390:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 395:	8d 4f 02             	lea    0x2(%edi),%ecx
 398:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 39c:	8a 07                	mov    (%edi),%al
 39e:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3a1:	50                   	push   %eax
 3a2:	6a 01                	push   $0x1
 3a4:	53                   	push   %ebx
 3a5:	56                   	push   %esi
 3a6:	e8 18 ff ff ff       	call   2c3 <write>
 3ab:	4f                   	dec    %edi
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3ac:	83 c4 10             	add    $0x10,%esp
 3af:	39 df                	cmp    %ebx,%edi
 3b1:	75 e9                	jne    39c <printint+0x58>
    putc(fd, buf[i]);
}
 3b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3b6:	5b                   	pop    %ebx
 3b7:	5e                   	pop    %esi
 3b8:	5f                   	pop    %edi
 3b9:	5d                   	pop    %ebp
 3ba:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3bb:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 3bd:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 3c4:	eb 9d                	jmp    363 <printint+0x1f>
 3c6:	66 90                	xchg   %ax,%ax

000003c8 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 3c8:	55                   	push   %ebp
 3c9:	89 e5                	mov    %esp,%ebp
 3cb:	57                   	push   %edi
 3cc:	56                   	push   %esi
 3cd:	53                   	push   %ebx
 3ce:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3d1:	8b 75 0c             	mov    0xc(%ebp),%esi
 3d4:	8a 1e                	mov    (%esi),%bl
 3d6:	84 db                	test   %bl,%bl
 3d8:	0f 84 a6 00 00 00    	je     484 <printf+0xbc>
 3de:	46                   	inc    %esi
 3df:	8d 45 10             	lea    0x10(%ebp),%eax
 3e2:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 3e5:	31 ff                	xor    %edi,%edi
 3e7:	eb 29                	jmp    412 <printf+0x4a>
 3e9:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 3ec:	83 f8 25             	cmp    $0x25,%eax
 3ef:	0f 84 97 00 00 00    	je     48c <printf+0xc4>
 3f5:	88 5d e2             	mov    %bl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3f8:	50                   	push   %eax
 3f9:	6a 01                	push   $0x1
 3fb:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 3fe:	50                   	push   %eax
 3ff:	ff 75 08             	pushl  0x8(%ebp)
 402:	e8 bc fe ff ff       	call   2c3 <write>
 407:	83 c4 10             	add    $0x10,%esp
 40a:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 40b:	8a 5e ff             	mov    -0x1(%esi),%bl
 40e:	84 db                	test   %bl,%bl
 410:	74 72                	je     484 <printf+0xbc>
    c = fmt[i] & 0xff;
 412:	0f be cb             	movsbl %bl,%ecx
 415:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 418:	85 ff                	test   %edi,%edi
 41a:	74 d0                	je     3ec <printf+0x24>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 41c:	83 ff 25             	cmp    $0x25,%edi
 41f:	75 e9                	jne    40a <printf+0x42>
      if(c == 'd'){
 421:	83 f8 64             	cmp    $0x64,%eax
 424:	0f 84 f6 00 00 00    	je     520 <printf+0x158>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 42a:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 430:	83 f9 70             	cmp    $0x70,%ecx
 433:	74 63                	je     498 <printf+0xd0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 435:	83 f8 73             	cmp    $0x73,%eax
 438:	0f 84 86 00 00 00    	je     4c4 <printf+0xfc>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 43e:	83 f8 63             	cmp    $0x63,%eax
 441:	0f 84 be 00 00 00    	je     505 <printf+0x13d>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 447:	83 f8 25             	cmp    $0x25,%eax
 44a:	0f 84 e0 00 00 00    	je     530 <printf+0x168>
 450:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 454:	50                   	push   %eax
 455:	6a 01                	push   $0x1
 457:	8d 45 e7             	lea    -0x19(%ebp),%eax
 45a:	50                   	push   %eax
 45b:	ff 75 08             	pushl  0x8(%ebp)
 45e:	e8 60 fe ff ff       	call   2c3 <write>
 463:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 466:	83 c4 0c             	add    $0xc,%esp
 469:	6a 01                	push   $0x1
 46b:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 46e:	50                   	push   %eax
 46f:	ff 75 08             	pushl  0x8(%ebp)
 472:	e8 4c fe ff ff       	call   2c3 <write>
 477:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 47a:	31 ff                	xor    %edi,%edi
 47c:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 47d:	8a 5e ff             	mov    -0x1(%esi),%bl
 480:	84 db                	test   %bl,%bl
 482:	75 8e                	jne    412 <printf+0x4a>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 484:	8d 65 f4             	lea    -0xc(%ebp),%esp
 487:	5b                   	pop    %ebx
 488:	5e                   	pop    %esi
 489:	5f                   	pop    %edi
 48a:	5d                   	pop    %ebp
 48b:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 48c:	bf 25 00 00 00       	mov    $0x25,%edi
 491:	e9 74 ff ff ff       	jmp    40a <printf+0x42>
 496:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 498:	83 ec 0c             	sub    $0xc,%esp
 49b:	6a 00                	push   $0x0
 49d:	b9 10 00 00 00       	mov    $0x10,%ecx
 4a2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 4a5:	8b 17                	mov    (%edi),%edx
 4a7:	8b 45 08             	mov    0x8(%ebp),%eax
 4aa:	e8 95 fe ff ff       	call   344 <printint>
        ap++;
 4af:	89 f8                	mov    %edi,%eax
 4b1:	83 c0 04             	add    $0x4,%eax
 4b4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 4b7:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4ba:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 4bc:	e9 49 ff ff ff       	jmp    40a <printf+0x42>
 4c1:	8d 76 00             	lea    0x0(%esi),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 4c4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 4c7:	8b 38                	mov    (%eax),%edi
        ap++;
 4c9:	83 c0 04             	add    $0x4,%eax
 4cc:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 4cf:	85 ff                	test   %edi,%edi
 4d1:	74 6b                	je     53e <printf+0x176>
          s = "(null)";
        while(*s != 0){
 4d3:	8a 07                	mov    (%edi),%al
 4d5:	84 c0                	test   %al,%al
 4d7:	74 6c                	je     545 <printf+0x17d>
 4d9:	8d 5d e3             	lea    -0x1d(%ebp),%ebx
 4dc:	89 75 d0             	mov    %esi,-0x30(%ebp)
 4df:	89 fe                	mov    %edi,%esi
 4e1:	8b 7d 08             	mov    0x8(%ebp),%edi
 4e4:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4e7:	50                   	push   %eax
 4e8:	6a 01                	push   $0x1
 4ea:	53                   	push   %ebx
 4eb:	57                   	push   %edi
 4ec:	e8 d2 fd ff ff       	call   2c3 <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 4f1:	46                   	inc    %esi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 4f2:	8a 06                	mov    (%esi),%al
 4f4:	83 c4 10             	add    $0x10,%esp
 4f7:	84 c0                	test   %al,%al
 4f9:	75 e9                	jne    4e4 <printf+0x11c>
 4fb:	8b 75 d0             	mov    -0x30(%ebp),%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4fe:	31 ff                	xor    %edi,%edi
 500:	e9 05 ff ff ff       	jmp    40a <printf+0x42>
 505:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 508:	8b 07                	mov    (%edi),%eax
 50a:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 50d:	51                   	push   %ecx
 50e:	6a 01                	push   $0x1
 510:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 513:	50                   	push   %eax
 514:	ff 75 08             	pushl  0x8(%ebp)
 517:	e8 a7 fd ff ff       	call   2c3 <write>
 51c:	eb 91                	jmp    4af <printf+0xe7>
 51e:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 520:	83 ec 0c             	sub    $0xc,%esp
 523:	6a 01                	push   $0x1
 525:	b9 0a 00 00 00       	mov    $0xa,%ecx
 52a:	e9 73 ff ff ff       	jmp    4a2 <printf+0xda>
 52f:	90                   	nop
 530:	88 5d e5             	mov    %bl,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 533:	52                   	push   %edx
 534:	6a 01                	push   $0x1
 536:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 539:	e9 30 ff ff ff       	jmp    46e <printf+0xa6>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
 53e:	bf 00 07 00 00       	mov    $0x700,%edi
 543:	eb 8e                	jmp    4d3 <printf+0x10b>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 545:	31 ff                	xor    %edi,%edi
 547:	e9 be fe ff ff       	jmp    40a <printf+0x42>

0000054c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 54c:	55                   	push   %ebp
 54d:	89 e5                	mov    %esp,%ebp
 54f:	57                   	push   %edi
 550:	56                   	push   %esi
 551:	53                   	push   %ebx
 552:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 555:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 558:	a1 e0 09 00 00       	mov    0x9e0,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 55d:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 55f:	39 c8                	cmp    %ecx,%eax
 561:	73 11                	jae    574 <free+0x28>
 563:	90                   	nop
 564:	39 d1                	cmp    %edx,%ecx
 566:	72 14                	jb     57c <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 568:	39 d0                	cmp    %edx,%eax
 56a:	73 10                	jae    57c <free+0x30>
static Header base;
static Header *freep;

void
free(void *ap)
{
 56c:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 56e:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 570:	39 c8                	cmp    %ecx,%eax
 572:	72 f0                	jb     564 <free+0x18>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 574:	39 d0                	cmp    %edx,%eax
 576:	72 f4                	jb     56c <free+0x20>
 578:	39 d1                	cmp    %edx,%ecx
 57a:	73 f0                	jae    56c <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 57c:	8b 73 fc             	mov    -0x4(%ebx),%esi
 57f:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 582:	39 d7                	cmp    %edx,%edi
 584:	74 19                	je     59f <free+0x53>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 586:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 589:	8b 50 04             	mov    0x4(%eax),%edx
 58c:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 58f:	39 f1                	cmp    %esi,%ecx
 591:	74 23                	je     5b6 <free+0x6a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 593:	89 08                	mov    %ecx,(%eax)
  freep = p;
 595:	a3 e0 09 00 00       	mov    %eax,0x9e0
}
 59a:	5b                   	pop    %ebx
 59b:	5e                   	pop    %esi
 59c:	5f                   	pop    %edi
 59d:	5d                   	pop    %ebp
 59e:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 59f:	03 72 04             	add    0x4(%edx),%esi
 5a2:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5a5:	8b 10                	mov    (%eax),%edx
 5a7:	8b 12                	mov    (%edx),%edx
 5a9:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 5ac:	8b 50 04             	mov    0x4(%eax),%edx
 5af:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5b2:	39 f1                	cmp    %esi,%ecx
 5b4:	75 dd                	jne    593 <free+0x47>
    p->s.size += bp->s.size;
 5b6:	03 53 fc             	add    -0x4(%ebx),%edx
 5b9:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 5bc:	8b 53 f8             	mov    -0x8(%ebx),%edx
 5bf:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 5c1:	a3 e0 09 00 00       	mov    %eax,0x9e0
}
 5c6:	5b                   	pop    %ebx
 5c7:	5e                   	pop    %esi
 5c8:	5f                   	pop    %edi
 5c9:	5d                   	pop    %ebp
 5ca:	c3                   	ret    
 5cb:	90                   	nop

000005cc <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 5cc:	55                   	push   %ebp
 5cd:	89 e5                	mov    %esp,%ebp
 5cf:	57                   	push   %edi
 5d0:	56                   	push   %esi
 5d1:	53                   	push   %ebx
 5d2:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5d5:	8b 45 08             	mov    0x8(%ebp),%eax
 5d8:	8d 78 07             	lea    0x7(%eax),%edi
 5db:	c1 ef 03             	shr    $0x3,%edi
 5de:	47                   	inc    %edi
  if((prevp = freep) == 0){
 5df:	8b 15 e0 09 00 00    	mov    0x9e0,%edx
 5e5:	85 d2                	test   %edx,%edx
 5e7:	0f 84 b1 00 00 00    	je     69e <malloc+0xd2>
 5ed:	8b 02                	mov    (%edx),%eax
 5ef:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 5f2:	39 cf                	cmp    %ecx,%edi
 5f4:	76 66                	jbe    65c <malloc+0x90>
 5f6:	89 fb                	mov    %edi,%ebx
 5f8:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 5fe:	0f 82 80 00 00 00    	jb     684 <malloc+0xb8>
 604:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 60a:	76 70                	jbe    67c <malloc+0xb0>
 60c:	8d 34 fd 00 00 00 00 	lea    0x0(,%edi,8),%esi
 613:	eb 0c                	jmp    621 <malloc+0x55>
 615:	8d 76 00             	lea    0x0(%esi),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 618:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 61a:	8b 48 04             	mov    0x4(%eax),%ecx
 61d:	39 cf                	cmp    %ecx,%edi
 61f:	76 3b                	jbe    65c <malloc+0x90>
 621:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 623:	39 05 e0 09 00 00    	cmp    %eax,0x9e0
 629:	75 ed                	jne    618 <malloc+0x4c>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 62b:	83 ec 0c             	sub    $0xc,%esp
 62e:	56                   	push   %esi
 62f:	e8 f7 fc ff ff       	call   32b <sbrk>
  if(p == (char*)-1)
 634:	83 c4 10             	add    $0x10,%esp
 637:	83 f8 ff             	cmp    $0xffffffff,%eax
 63a:	74 1c                	je     658 <malloc+0x8c>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 63c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 63f:	83 ec 0c             	sub    $0xc,%esp
 642:	83 c0 08             	add    $0x8,%eax
 645:	50                   	push   %eax
 646:	e8 01 ff ff ff       	call   54c <free>
  return freep;
 64b:	8b 15 e0 09 00 00    	mov    0x9e0,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 651:	83 c4 10             	add    $0x10,%esp
 654:	85 d2                	test   %edx,%edx
 656:	75 c0                	jne    618 <malloc+0x4c>
        return 0;
 658:	31 c0                	xor    %eax,%eax
 65a:	eb 18                	jmp    674 <malloc+0xa8>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 65c:	39 cf                	cmp    %ecx,%edi
 65e:	74 38                	je     698 <malloc+0xcc>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 660:	29 f9                	sub    %edi,%ecx
 662:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 665:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 668:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 66b:	89 15 e0 09 00 00    	mov    %edx,0x9e0
      return (void*)(p + 1);
 671:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 674:	8d 65 f4             	lea    -0xc(%ebp),%esp
 677:	5b                   	pop    %ebx
 678:	5e                   	pop    %esi
 679:	5f                   	pop    %edi
 67a:	5d                   	pop    %ebp
 67b:	c3                   	ret    
 67c:	be 00 80 00 00       	mov    $0x8000,%esi
 681:	eb 9e                	jmp    621 <malloc+0x55>
 683:	90                   	nop
 684:	bb 00 10 00 00       	mov    $0x1000,%ebx
 689:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 68f:	76 eb                	jbe    67c <malloc+0xb0>
 691:	e9 76 ff ff ff       	jmp    60c <malloc+0x40>
 696:	66 90                	xchg   %ax,%ax
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 698:	8b 08                	mov    (%eax),%ecx
 69a:	89 0a                	mov    %ecx,(%edx)
 69c:	eb cd                	jmp    66b <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 69e:	c7 05 e0 09 00 00 e4 	movl   $0x9e4,0x9e0
 6a5:	09 00 00 
 6a8:	c7 05 e4 09 00 00 e4 	movl   $0x9e4,0x9e4
 6af:	09 00 00 
    base.s.size = 0;
 6b2:	c7 05 e8 09 00 00 00 	movl   $0x0,0x9e8
 6b9:	00 00 00 
 6bc:	b8 e4 09 00 00       	mov    $0x9e4,%eax
 6c1:	e9 30 ff ff ff       	jmp    5f6 <malloc+0x2a>
