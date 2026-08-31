
_cp:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main (int argc , char* argv[] ) {
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	81 ec 18 02 00 00    	sub    $0x218,%esp
  17:	8b 59 04             	mov    0x4(%ecx),%ebx

	char buff[512];
	int n =0;
	int srcfd = 0;
	int desfd = 0;
	if(argc != 3){
  1a:	83 39 03             	cmpl   $0x3,(%ecx)
  1d:	74 14                	je     33 <main+0x33>
	printf(2,"not enough arguments\n");
  1f:	83 ec 08             	sub    $0x8,%esp
  22:	68 e0 06 00 00       	push   $0x6e0
  27:	6a 02                	push   $0x2
  29:	e8 b2 03 00 00       	call   3e0 <printf>
	exit();
  2e:	e8 88 02 00 00       	call   2bb <exit>
	}
	
	srcfd = open(argv[1] , O_RDONLY);
  33:	50                   	push   %eax
  34:	50                   	push   %eax
  35:	6a 00                	push   $0x0
  37:	ff 73 04             	pushl  0x4(%ebx)
  3a:	e8 bc 02 00 00       	call   2fb <open>
  3f:	89 c6                	mov    %eax,%esi
	
	if(srcfd < 0){
  41:	83 c4 10             	add    $0x10,%esp
  44:	85 c0                	test   %eax,%eax
  46:	0f 88 9b 00 00 00    	js     e7 <main+0xe7>
	printf(2,"unable to open sourcefile\n");
	exit();
	}
	
	 desfd = open(argv[2], O_CREATE | O_WRONLY);
  4c:	50                   	push   %eax
  4d:	50                   	push   %eax
  4e:	68 01 02 00 00       	push   $0x201
  53:	ff 73 08             	pushl  0x8(%ebx)
  56:	e8 a0 02 00 00       	call   2fb <open>
  5b:	89 85 e4 fd ff ff    	mov    %eax,-0x21c(%ebp)
	 
	 if(desfd < 0){
  61:	83 c4 10             	add    $0x10,%esp
  64:	8d 9d e8 fd ff ff    	lea    -0x218(%ebp),%ebx
  6a:	85 c0                	test   %eax,%eax
  6c:	79 33                	jns    a1 <main+0xa1>
	printf(2,"unable to open destinationfile\n");
  6e:	50                   	push   %eax
  6f:	50                   	push   %eax
  70:	68 34 07 00 00       	push   $0x734
  75:	6a 02                	push   $0x2
  77:	e8 64 03 00 00       	call   3e0 <printf>
	close(srcfd);
  7c:	89 34 24             	mov    %esi,(%esp)
  7f:	e8 5f 02 00 00       	call   2e3 <close>
	exit();
  84:	e8 32 02 00 00       	call   2bb <exit>
  89:	8d 76 00             	lea    0x0(%esi),%esi
	}
	
	while((n = read(srcfd,buff,sizeof(buff))) >0){
	if(write(desfd , buff , n ) != n){
  8c:	50                   	push   %eax
  8d:	57                   	push   %edi
  8e:	53                   	push   %ebx
  8f:	ff b5 e4 fd ff ff    	pushl  -0x21c(%ebp)
  95:	e8 41 02 00 00       	call   2db <write>
  9a:	83 c4 10             	add    $0x10,%esp
  9d:	39 c7                	cmp    %eax,%edi
  9f:	75 33                	jne    d4 <main+0xd4>
	printf(2,"unable to open destinationfile\n");
	close(srcfd);
	exit();
	}
	
	while((n = read(srcfd,buff,sizeof(buff))) >0){
  a1:	51                   	push   %ecx
  a2:	68 00 02 00 00       	push   $0x200
  a7:	53                   	push   %ebx
  a8:	56                   	push   %esi
  a9:	e8 25 02 00 00       	call   2d3 <read>
  ae:	89 c7                	mov    %eax,%edi
  b0:	83 c4 10             	add    $0x10,%esp
  b3:	83 f8 00             	cmp    $0x0,%eax
  b6:	7f d4                	jg     8c <main+0x8c>
            close(srcfd);
            close(desfd);
            exit();
	}
	}
	if(n< 0){
  b8:	75 40                	jne    fa <main+0xfa>
	printf(2,"unable to read\n");
	}
	
	close(srcfd);
  ba:	83 ec 0c             	sub    $0xc,%esp
  bd:	56                   	push   %esi
  be:	e8 20 02 00 00       	call   2e3 <close>
	close(desfd);
  c3:	58                   	pop    %eax
  c4:	ff b5 e4 fd ff ff    	pushl  -0x21c(%ebp)
  ca:	e8 14 02 00 00       	call   2e3 <close>
	exit();
  cf:	e8 e7 01 00 00       	call   2bb <exit>
	exit();
	}
	
	while((n = read(srcfd,buff,sizeof(buff))) >0){
	if(write(desfd , buff , n ) != n){
            printf(2, "unable to write\n");
  d4:	53                   	push   %ebx
  d5:	53                   	push   %ebx
  d6:	68 11 07 00 00       	push   $0x711
  db:	6a 02                	push   $0x2
  dd:	e8 fe 02 00 00       	call   3e0 <printf>
            close(srcfd);
  e2:	89 34 24             	mov    %esi,(%esp)
  e5:	eb d7                	jmp    be <main+0xbe>
	}
	
	srcfd = open(argv[1] , O_RDONLY);
	
	if(srcfd < 0){
	printf(2,"unable to open sourcefile\n");
  e7:	50                   	push   %eax
  e8:	50                   	push   %eax
  e9:	68 f6 06 00 00       	push   $0x6f6
  ee:	6a 02                	push   $0x2
  f0:	e8 eb 02 00 00       	call   3e0 <printf>
	exit();
  f5:	e8 c1 01 00 00       	call   2bb <exit>
            close(desfd);
            exit();
	}
	}
	if(n< 0){
	printf(2,"unable to read\n");
  fa:	52                   	push   %edx
  fb:	52                   	push   %edx
  fc:	68 22 07 00 00       	push   $0x722
 101:	6a 02                	push   $0x2
 103:	e8 d8 02 00 00       	call   3e0 <printf>
 108:	83 c4 10             	add    $0x10,%esp
 10b:	eb ad                	jmp    ba <main+0xba>
 10d:	66 90                	xchg   %ax,%ax
 10f:	90                   	nop

00000110 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	53                   	push   %ebx
 114:	8b 45 08             	mov    0x8(%ebp),%eax
 117:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 11a:	89 c2                	mov    %eax,%edx
 11c:	42                   	inc    %edx
 11d:	41                   	inc    %ecx
 11e:	8a 59 ff             	mov    -0x1(%ecx),%bl
 121:	88 5a ff             	mov    %bl,-0x1(%edx)
 124:	84 db                	test   %bl,%bl
 126:	75 f4                	jne    11c <strcpy+0xc>
    ;
  return os;
}
 128:	5b                   	pop    %ebx
 129:	5d                   	pop    %ebp
 12a:	c3                   	ret    
 12b:	90                   	nop

0000012c <strcmp>:

int
strcmp(const char *p, const char *q)
{
 12c:	55                   	push   %ebp
 12d:	89 e5                	mov    %esp,%ebp
 12f:	56                   	push   %esi
 130:	53                   	push   %ebx
 131:	8b 55 08             	mov    0x8(%ebp),%edx
 134:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 137:	0f b6 02             	movzbl (%edx),%eax
 13a:	0f b6 0b             	movzbl (%ebx),%ecx
 13d:	84 c0                	test   %al,%al
 13f:	75 14                	jne    155 <strcmp+0x29>
 141:	eb 1d                	jmp    160 <strcmp+0x34>
 143:	90                   	nop
    p++, q++;
 144:	42                   	inc    %edx
 145:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 148:	0f b6 02             	movzbl (%edx),%eax
 14b:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 14f:	84 c0                	test   %al,%al
 151:	74 0d                	je     160 <strcmp+0x34>
 153:	89 f3                	mov    %esi,%ebx
 155:	38 c8                	cmp    %cl,%al
 157:	74 eb                	je     144 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 159:	29 c8                	sub    %ecx,%eax
}
 15b:	5b                   	pop    %ebx
 15c:	5e                   	pop    %esi
 15d:	5d                   	pop    %ebp
 15e:	c3                   	ret    
 15f:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 160:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 162:	29 c8                	sub    %ecx,%eax
}
 164:	5b                   	pop    %ebx
 165:	5e                   	pop    %esi
 166:	5d                   	pop    %ebp
 167:	c3                   	ret    

00000168 <strlen>:

uint
strlen(const char *s)
{
 168:	55                   	push   %ebp
 169:	89 e5                	mov    %esp,%ebp
 16b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 16e:	80 39 00             	cmpb   $0x0,(%ecx)
 171:	74 10                	je     183 <strlen+0x1b>
 173:	31 d2                	xor    %edx,%edx
 175:	8d 76 00             	lea    0x0(%esi),%esi
 178:	42                   	inc    %edx
 179:	89 d0                	mov    %edx,%eax
 17b:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 17f:	75 f7                	jne    178 <strlen+0x10>
    ;
  return n;
}
 181:	5d                   	pop    %ebp
 182:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 183:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 185:	5d                   	pop    %ebp
 186:	c3                   	ret    
 187:	90                   	nop

00000188 <memset>:

void*
memset(void *dst, int c, uint n)
{
 188:	55                   	push   %ebp
 189:	89 e5                	mov    %esp,%ebp
 18b:	57                   	push   %edi
 18c:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 18f:	89 d7                	mov    %edx,%edi
 191:	8b 4d 10             	mov    0x10(%ebp),%ecx
 194:	8b 45 0c             	mov    0xc(%ebp),%eax
 197:	fc                   	cld    
 198:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 19a:	89 d0                	mov    %edx,%eax
 19c:	5f                   	pop    %edi
 19d:	5d                   	pop    %ebp
 19e:	c3                   	ret    
 19f:	90                   	nop

000001a0 <strchr>:

char*
strchr(const char *s, char c)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	53                   	push   %ebx
 1a4:	8b 45 08             	mov    0x8(%ebp),%eax
 1a7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 1aa:	8a 10                	mov    (%eax),%dl
 1ac:	84 d2                	test   %dl,%dl
 1ae:	74 13                	je     1c3 <strchr+0x23>
 1b0:	88 d9                	mov    %bl,%cl
    if(*s == c)
 1b2:	38 d3                	cmp    %dl,%bl
 1b4:	75 06                	jne    1bc <strchr+0x1c>
 1b6:	eb 0d                	jmp    1c5 <strchr+0x25>
 1b8:	38 ca                	cmp    %cl,%dl
 1ba:	74 09                	je     1c5 <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 1bc:	40                   	inc    %eax
 1bd:	8a 10                	mov    (%eax),%dl
 1bf:	84 d2                	test   %dl,%dl
 1c1:	75 f5                	jne    1b8 <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
 1c3:	31 c0                	xor    %eax,%eax
}
 1c5:	5b                   	pop    %ebx
 1c6:	5d                   	pop    %ebp
 1c7:	c3                   	ret    

000001c8 <gets>:

char*
gets(char *buf, int max)
{
 1c8:	55                   	push   %ebp
 1c9:	89 e5                	mov    %esp,%ebp
 1cb:	57                   	push   %edi
 1cc:	56                   	push   %esi
 1cd:	53                   	push   %ebx
 1ce:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1d1:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 1d3:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1d6:	eb 26                	jmp    1fe <gets+0x36>
    cc = read(0, &c, 1);
 1d8:	50                   	push   %eax
 1d9:	6a 01                	push   $0x1
 1db:	57                   	push   %edi
 1dc:	6a 00                	push   $0x0
 1de:	e8 f0 00 00 00       	call   2d3 <read>
    if(cc < 1)
 1e3:	83 c4 10             	add    $0x10,%esp
 1e6:	85 c0                	test   %eax,%eax
 1e8:	7e 1c                	jle    206 <gets+0x3e>
      break;
    buf[i++] = c;
 1ea:	8a 45 e7             	mov    -0x19(%ebp),%al
 1ed:	8b 55 08             	mov    0x8(%ebp),%edx
 1f0:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1f4:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1f6:	3c 0a                	cmp    $0xa,%al
 1f8:	74 0c                	je     206 <gets+0x3e>
 1fa:	3c 0d                	cmp    $0xd,%al
 1fc:	74 08                	je     206 <gets+0x3e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1fe:	8d 5e 01             	lea    0x1(%esi),%ebx
 201:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 204:	7c d2                	jl     1d8 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 206:	8b 45 08             	mov    0x8(%ebp),%eax
 209:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 20d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 210:	5b                   	pop    %ebx
 211:	5e                   	pop    %esi
 212:	5f                   	pop    %edi
 213:	5d                   	pop    %ebp
 214:	c3                   	ret    
 215:	8d 76 00             	lea    0x0(%esi),%esi

00000218 <stat>:

int
stat(const char *n, struct stat *st)
{
 218:	55                   	push   %ebp
 219:	89 e5                	mov    %esp,%ebp
 21b:	56                   	push   %esi
 21c:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 21d:	83 ec 08             	sub    $0x8,%esp
 220:	6a 00                	push   $0x0
 222:	ff 75 08             	pushl  0x8(%ebp)
 225:	e8 d1 00 00 00       	call   2fb <open>
  if(fd < 0)
 22a:	83 c4 10             	add    $0x10,%esp
 22d:	85 c0                	test   %eax,%eax
 22f:	78 27                	js     258 <stat+0x40>
 231:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 233:	83 ec 08             	sub    $0x8,%esp
 236:	ff 75 0c             	pushl  0xc(%ebp)
 239:	50                   	push   %eax
 23a:	e8 d4 00 00 00       	call   313 <fstat>
 23f:	89 c6                	mov    %eax,%esi
  close(fd);
 241:	89 1c 24             	mov    %ebx,(%esp)
 244:	e8 9a 00 00 00       	call   2e3 <close>
  return r;
 249:	83 c4 10             	add    $0x10,%esp
 24c:	89 f0                	mov    %esi,%eax
}
 24e:	8d 65 f8             	lea    -0x8(%ebp),%esp
 251:	5b                   	pop    %ebx
 252:	5e                   	pop    %esi
 253:	5d                   	pop    %ebp
 254:	c3                   	ret    
 255:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 258:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 25d:	eb ef                	jmp    24e <stat+0x36>
 25f:	90                   	nop

00000260 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	53                   	push   %ebx
 264:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 267:	0f be 11             	movsbl (%ecx),%edx
 26a:	8d 42 d0             	lea    -0x30(%edx),%eax
 26d:	3c 09                	cmp    $0x9,%al
 26f:	b8 00 00 00 00       	mov    $0x0,%eax
 274:	77 15                	ja     28b <atoi+0x2b>
 276:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 278:	41                   	inc    %ecx
 279:	8d 04 80             	lea    (%eax,%eax,4),%eax
 27c:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 280:	0f be 11             	movsbl (%ecx),%edx
 283:	8d 5a d0             	lea    -0x30(%edx),%ebx
 286:	80 fb 09             	cmp    $0x9,%bl
 289:	76 ed                	jbe    278 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 28b:	5b                   	pop    %ebx
 28c:	5d                   	pop    %ebp
 28d:	c3                   	ret    
 28e:	66 90                	xchg   %ax,%ax

00000290 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	56                   	push   %esi
 294:	53                   	push   %ebx
 295:	8b 45 08             	mov    0x8(%ebp),%eax
 298:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 29b:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 29e:	85 f6                	test   %esi,%esi
 2a0:	7e 0d                	jle    2af <memmove+0x1f>
 2a2:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 2a4:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 2a7:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2aa:	42                   	inc    %edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2ab:	39 f2                	cmp    %esi,%edx
 2ad:	75 f5                	jne    2a4 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 2af:	5b                   	pop    %ebx
 2b0:	5e                   	pop    %esi
 2b1:	5d                   	pop    %ebp
 2b2:	c3                   	ret    

000002b3 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2b3:	b8 01 00 00 00       	mov    $0x1,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret    

000002bb <exit>:
SYSCALL(exit)
 2bb:	b8 02 00 00 00       	mov    $0x2,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret    

000002c3 <wait>:
SYSCALL(wait)
 2c3:	b8 03 00 00 00       	mov    $0x3,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret    

000002cb <pipe>:
SYSCALL(pipe)
 2cb:	b8 04 00 00 00       	mov    $0x4,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret    

000002d3 <read>:
SYSCALL(read)
 2d3:	b8 05 00 00 00       	mov    $0x5,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret    

000002db <write>:
SYSCALL(write)
 2db:	b8 10 00 00 00       	mov    $0x10,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret    

000002e3 <close>:
SYSCALL(close)
 2e3:	b8 15 00 00 00       	mov    $0x15,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret    

000002eb <kill>:
SYSCALL(kill)
 2eb:	b8 06 00 00 00       	mov    $0x6,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret    

000002f3 <exec>:
SYSCALL(exec)
 2f3:	b8 07 00 00 00       	mov    $0x7,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret    

000002fb <open>:
SYSCALL(open)
 2fb:	b8 0f 00 00 00       	mov    $0xf,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret    

00000303 <mknod>:
SYSCALL(mknod)
 303:	b8 11 00 00 00       	mov    $0x11,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret    

0000030b <unlink>:
SYSCALL(unlink)
 30b:	b8 12 00 00 00       	mov    $0x12,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret    

00000313 <fstat>:
SYSCALL(fstat)
 313:	b8 08 00 00 00       	mov    $0x8,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret    

0000031b <link>:
SYSCALL(link)
 31b:	b8 13 00 00 00       	mov    $0x13,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <mkdir>:
SYSCALL(mkdir)
 323:	b8 14 00 00 00       	mov    $0x14,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    

0000032b <chdir>:
SYSCALL(chdir)
 32b:	b8 09 00 00 00       	mov    $0x9,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    

00000333 <dup>:
SYSCALL(dup)
 333:	b8 0a 00 00 00       	mov    $0xa,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <getpid>:
SYSCALL(getpid)
 33b:	b8 0b 00 00 00       	mov    $0xb,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    

00000343 <sbrk>:
SYSCALL(sbrk)
 343:	b8 0c 00 00 00       	mov    $0xc,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret    

0000034b <sleep>:
SYSCALL(sleep)
 34b:	b8 0d 00 00 00       	mov    $0xd,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <uptime>:
SYSCALL(uptime)
 353:	b8 0e 00 00 00       	mov    $0xe,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    
 35b:	90                   	nop

0000035c <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 35c:	55                   	push   %ebp
 35d:	89 e5                	mov    %esp,%ebp
 35f:	57                   	push   %edi
 360:	56                   	push   %esi
 361:	53                   	push   %ebx
 362:	83 ec 3c             	sub    $0x3c,%esp
 365:	89 c6                	mov    %eax,%esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 367:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 369:	8b 5d 08             	mov    0x8(%ebp),%ebx
 36c:	85 db                	test   %ebx,%ebx
 36e:	74 04                	je     374 <printint+0x18>
 370:	85 d2                	test   %edx,%edx
 372:	78 5f                	js     3d3 <printint+0x77>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 374:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 37b:	31 ff                	xor    %edi,%edi
 37d:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 380:	89 75 c4             	mov    %esi,-0x3c(%ebp)
 383:	89 ce                	mov    %ecx,%esi
 385:	eb 03                	jmp    38a <printint+0x2e>
 387:	90                   	nop
  do{
    buf[i++] = digits[x % base];
 388:	89 cf                	mov    %ecx,%edi
 38a:	8d 4f 01             	lea    0x1(%edi),%ecx
 38d:	31 d2                	xor    %edx,%edx
 38f:	f7 f6                	div    %esi
 391:	8a 92 5c 07 00 00    	mov    0x75c(%edx),%dl
 397:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 39a:	85 c0                	test   %eax,%eax
 39c:	75 ea                	jne    388 <printint+0x2c>
 39e:	8b 75 c4             	mov    -0x3c(%ebp),%esi
  if(neg)
 3a1:	8b 55 c0             	mov    -0x40(%ebp),%edx
 3a4:	85 d2                	test   %edx,%edx
 3a6:	74 08                	je     3b0 <printint+0x54>
    buf[i++] = '-';
 3a8:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 3ad:	8d 4f 02             	lea    0x2(%edi),%ecx
 3b0:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 3b4:	8a 07                	mov    (%edi),%al
 3b6:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3b9:	50                   	push   %eax
 3ba:	6a 01                	push   $0x1
 3bc:	53                   	push   %ebx
 3bd:	56                   	push   %esi
 3be:	e8 18 ff ff ff       	call   2db <write>
 3c3:	4f                   	dec    %edi
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3c4:	83 c4 10             	add    $0x10,%esp
 3c7:	39 df                	cmp    %ebx,%edi
 3c9:	75 e9                	jne    3b4 <printint+0x58>
    putc(fd, buf[i]);
}
 3cb:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3ce:	5b                   	pop    %ebx
 3cf:	5e                   	pop    %esi
 3d0:	5f                   	pop    %edi
 3d1:	5d                   	pop    %ebp
 3d2:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3d3:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 3d5:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 3dc:	eb 9d                	jmp    37b <printint+0x1f>
 3de:	66 90                	xchg   %ax,%ax

000003e0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	57                   	push   %edi
 3e4:	56                   	push   %esi
 3e5:	53                   	push   %ebx
 3e6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3e9:	8b 75 0c             	mov    0xc(%ebp),%esi
 3ec:	8a 1e                	mov    (%esi),%bl
 3ee:	84 db                	test   %bl,%bl
 3f0:	0f 84 a6 00 00 00    	je     49c <printf+0xbc>
 3f6:	46                   	inc    %esi
 3f7:	8d 45 10             	lea    0x10(%ebp),%eax
 3fa:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 3fd:	31 ff                	xor    %edi,%edi
 3ff:	eb 29                	jmp    42a <printf+0x4a>
 401:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 404:	83 f8 25             	cmp    $0x25,%eax
 407:	0f 84 97 00 00 00    	je     4a4 <printf+0xc4>
 40d:	88 5d e2             	mov    %bl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 410:	50                   	push   %eax
 411:	6a 01                	push   $0x1
 413:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 416:	50                   	push   %eax
 417:	ff 75 08             	pushl  0x8(%ebp)
 41a:	e8 bc fe ff ff       	call   2db <write>
 41f:	83 c4 10             	add    $0x10,%esp
 422:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 423:	8a 5e ff             	mov    -0x1(%esi),%bl
 426:	84 db                	test   %bl,%bl
 428:	74 72                	je     49c <printf+0xbc>
    c = fmt[i] & 0xff;
 42a:	0f be cb             	movsbl %bl,%ecx
 42d:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 430:	85 ff                	test   %edi,%edi
 432:	74 d0                	je     404 <printf+0x24>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 434:	83 ff 25             	cmp    $0x25,%edi
 437:	75 e9                	jne    422 <printf+0x42>
      if(c == 'd'){
 439:	83 f8 64             	cmp    $0x64,%eax
 43c:	0f 84 f6 00 00 00    	je     538 <printf+0x158>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 442:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 448:	83 f9 70             	cmp    $0x70,%ecx
 44b:	74 63                	je     4b0 <printf+0xd0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 44d:	83 f8 73             	cmp    $0x73,%eax
 450:	0f 84 86 00 00 00    	je     4dc <printf+0xfc>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 456:	83 f8 63             	cmp    $0x63,%eax
 459:	0f 84 be 00 00 00    	je     51d <printf+0x13d>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 45f:	83 f8 25             	cmp    $0x25,%eax
 462:	0f 84 e0 00 00 00    	je     548 <printf+0x168>
 468:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 46c:	50                   	push   %eax
 46d:	6a 01                	push   $0x1
 46f:	8d 45 e7             	lea    -0x19(%ebp),%eax
 472:	50                   	push   %eax
 473:	ff 75 08             	pushl  0x8(%ebp)
 476:	e8 60 fe ff ff       	call   2db <write>
 47b:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 47e:	83 c4 0c             	add    $0xc,%esp
 481:	6a 01                	push   $0x1
 483:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 486:	50                   	push   %eax
 487:	ff 75 08             	pushl  0x8(%ebp)
 48a:	e8 4c fe ff ff       	call   2db <write>
 48f:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 492:	31 ff                	xor    %edi,%edi
 494:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 495:	8a 5e ff             	mov    -0x1(%esi),%bl
 498:	84 db                	test   %bl,%bl
 49a:	75 8e                	jne    42a <printf+0x4a>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 49c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 49f:	5b                   	pop    %ebx
 4a0:	5e                   	pop    %esi
 4a1:	5f                   	pop    %edi
 4a2:	5d                   	pop    %ebp
 4a3:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 4a4:	bf 25 00 00 00       	mov    $0x25,%edi
 4a9:	e9 74 ff ff ff       	jmp    422 <printf+0x42>
 4ae:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 4b0:	83 ec 0c             	sub    $0xc,%esp
 4b3:	6a 00                	push   $0x0
 4b5:	b9 10 00 00 00       	mov    $0x10,%ecx
 4ba:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 4bd:	8b 17                	mov    (%edi),%edx
 4bf:	8b 45 08             	mov    0x8(%ebp),%eax
 4c2:	e8 95 fe ff ff       	call   35c <printint>
        ap++;
 4c7:	89 f8                	mov    %edi,%eax
 4c9:	83 c0 04             	add    $0x4,%eax
 4cc:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 4cf:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4d2:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 4d4:	e9 49 ff ff ff       	jmp    422 <printf+0x42>
 4d9:	8d 76 00             	lea    0x0(%esi),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 4dc:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 4df:	8b 38                	mov    (%eax),%edi
        ap++;
 4e1:	83 c0 04             	add    $0x4,%eax
 4e4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 4e7:	85 ff                	test   %edi,%edi
 4e9:	74 6b                	je     556 <printf+0x176>
          s = "(null)";
        while(*s != 0){
 4eb:	8a 07                	mov    (%edi),%al
 4ed:	84 c0                	test   %al,%al
 4ef:	74 6c                	je     55d <printf+0x17d>
 4f1:	8d 5d e3             	lea    -0x1d(%ebp),%ebx
 4f4:	89 75 d0             	mov    %esi,-0x30(%ebp)
 4f7:	89 fe                	mov    %edi,%esi
 4f9:	8b 7d 08             	mov    0x8(%ebp),%edi
 4fc:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4ff:	50                   	push   %eax
 500:	6a 01                	push   $0x1
 502:	53                   	push   %ebx
 503:	57                   	push   %edi
 504:	e8 d2 fd ff ff       	call   2db <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 509:	46                   	inc    %esi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 50a:	8a 06                	mov    (%esi),%al
 50c:	83 c4 10             	add    $0x10,%esp
 50f:	84 c0                	test   %al,%al
 511:	75 e9                	jne    4fc <printf+0x11c>
 513:	8b 75 d0             	mov    -0x30(%ebp),%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 516:	31 ff                	xor    %edi,%edi
 518:	e9 05 ff ff ff       	jmp    422 <printf+0x42>
 51d:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 520:	8b 07                	mov    (%edi),%eax
 522:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 525:	51                   	push   %ecx
 526:	6a 01                	push   $0x1
 528:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 52b:	50                   	push   %eax
 52c:	ff 75 08             	pushl  0x8(%ebp)
 52f:	e8 a7 fd ff ff       	call   2db <write>
 534:	eb 91                	jmp    4c7 <printf+0xe7>
 536:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 538:	83 ec 0c             	sub    $0xc,%esp
 53b:	6a 01                	push   $0x1
 53d:	b9 0a 00 00 00       	mov    $0xa,%ecx
 542:	e9 73 ff ff ff       	jmp    4ba <printf+0xda>
 547:	90                   	nop
 548:	88 5d e5             	mov    %bl,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 54b:	52                   	push   %edx
 54c:	6a 01                	push   $0x1
 54e:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 551:	e9 30 ff ff ff       	jmp    486 <printf+0xa6>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
 556:	bf 54 07 00 00       	mov    $0x754,%edi
 55b:	eb 8e                	jmp    4eb <printf+0x10b>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 55d:	31 ff                	xor    %edi,%edi
 55f:	e9 be fe ff ff       	jmp    422 <printf+0x42>

00000564 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 564:	55                   	push   %ebp
 565:	89 e5                	mov    %esp,%ebp
 567:	57                   	push   %edi
 568:	56                   	push   %esi
 569:	53                   	push   %ebx
 56a:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 56d:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 570:	a1 f0 09 00 00       	mov    0x9f0,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 575:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 577:	39 c8                	cmp    %ecx,%eax
 579:	73 11                	jae    58c <free+0x28>
 57b:	90                   	nop
 57c:	39 d1                	cmp    %edx,%ecx
 57e:	72 14                	jb     594 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 580:	39 d0                	cmp    %edx,%eax
 582:	73 10                	jae    594 <free+0x30>
static Header base;
static Header *freep;

void
free(void *ap)
{
 584:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 586:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 588:	39 c8                	cmp    %ecx,%eax
 58a:	72 f0                	jb     57c <free+0x18>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 58c:	39 d0                	cmp    %edx,%eax
 58e:	72 f4                	jb     584 <free+0x20>
 590:	39 d1                	cmp    %edx,%ecx
 592:	73 f0                	jae    584 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 594:	8b 73 fc             	mov    -0x4(%ebx),%esi
 597:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 59a:	39 d7                	cmp    %edx,%edi
 59c:	74 19                	je     5b7 <free+0x53>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 59e:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5a1:	8b 50 04             	mov    0x4(%eax),%edx
 5a4:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5a7:	39 f1                	cmp    %esi,%ecx
 5a9:	74 23                	je     5ce <free+0x6a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 5ab:	89 08                	mov    %ecx,(%eax)
  freep = p;
 5ad:	a3 f0 09 00 00       	mov    %eax,0x9f0
}
 5b2:	5b                   	pop    %ebx
 5b3:	5e                   	pop    %esi
 5b4:	5f                   	pop    %edi
 5b5:	5d                   	pop    %ebp
 5b6:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 5b7:	03 72 04             	add    0x4(%edx),%esi
 5ba:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5bd:	8b 10                	mov    (%eax),%edx
 5bf:	8b 12                	mov    (%edx),%edx
 5c1:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 5c4:	8b 50 04             	mov    0x4(%eax),%edx
 5c7:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5ca:	39 f1                	cmp    %esi,%ecx
 5cc:	75 dd                	jne    5ab <free+0x47>
    p->s.size += bp->s.size;
 5ce:	03 53 fc             	add    -0x4(%ebx),%edx
 5d1:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 5d4:	8b 53 f8             	mov    -0x8(%ebx),%edx
 5d7:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 5d9:	a3 f0 09 00 00       	mov    %eax,0x9f0
}
 5de:	5b                   	pop    %ebx
 5df:	5e                   	pop    %esi
 5e0:	5f                   	pop    %edi
 5e1:	5d                   	pop    %ebp
 5e2:	c3                   	ret    
 5e3:	90                   	nop

000005e4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 5e4:	55                   	push   %ebp
 5e5:	89 e5                	mov    %esp,%ebp
 5e7:	57                   	push   %edi
 5e8:	56                   	push   %esi
 5e9:	53                   	push   %ebx
 5ea:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5ed:	8b 45 08             	mov    0x8(%ebp),%eax
 5f0:	8d 78 07             	lea    0x7(%eax),%edi
 5f3:	c1 ef 03             	shr    $0x3,%edi
 5f6:	47                   	inc    %edi
  if((prevp = freep) == 0){
 5f7:	8b 15 f0 09 00 00    	mov    0x9f0,%edx
 5fd:	85 d2                	test   %edx,%edx
 5ff:	0f 84 b1 00 00 00    	je     6b6 <malloc+0xd2>
 605:	8b 02                	mov    (%edx),%eax
 607:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 60a:	39 cf                	cmp    %ecx,%edi
 60c:	76 66                	jbe    674 <malloc+0x90>
 60e:	89 fb                	mov    %edi,%ebx
 610:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 616:	0f 82 80 00 00 00    	jb     69c <malloc+0xb8>
 61c:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 622:	76 70                	jbe    694 <malloc+0xb0>
 624:	8d 34 fd 00 00 00 00 	lea    0x0(,%edi,8),%esi
 62b:	eb 0c                	jmp    639 <malloc+0x55>
 62d:	8d 76 00             	lea    0x0(%esi),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 630:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 632:	8b 48 04             	mov    0x4(%eax),%ecx
 635:	39 cf                	cmp    %ecx,%edi
 637:	76 3b                	jbe    674 <malloc+0x90>
 639:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 63b:	39 05 f0 09 00 00    	cmp    %eax,0x9f0
 641:	75 ed                	jne    630 <malloc+0x4c>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 643:	83 ec 0c             	sub    $0xc,%esp
 646:	56                   	push   %esi
 647:	e8 f7 fc ff ff       	call   343 <sbrk>
  if(p == (char*)-1)
 64c:	83 c4 10             	add    $0x10,%esp
 64f:	83 f8 ff             	cmp    $0xffffffff,%eax
 652:	74 1c                	je     670 <malloc+0x8c>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 654:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 657:	83 ec 0c             	sub    $0xc,%esp
 65a:	83 c0 08             	add    $0x8,%eax
 65d:	50                   	push   %eax
 65e:	e8 01 ff ff ff       	call   564 <free>
  return freep;
 663:	8b 15 f0 09 00 00    	mov    0x9f0,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 669:	83 c4 10             	add    $0x10,%esp
 66c:	85 d2                	test   %edx,%edx
 66e:	75 c0                	jne    630 <malloc+0x4c>
        return 0;
 670:	31 c0                	xor    %eax,%eax
 672:	eb 18                	jmp    68c <malloc+0xa8>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 674:	39 cf                	cmp    %ecx,%edi
 676:	74 38                	je     6b0 <malloc+0xcc>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 678:	29 f9                	sub    %edi,%ecx
 67a:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 67d:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 680:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 683:	89 15 f0 09 00 00    	mov    %edx,0x9f0
      return (void*)(p + 1);
 689:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 68c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 68f:	5b                   	pop    %ebx
 690:	5e                   	pop    %esi
 691:	5f                   	pop    %edi
 692:	5d                   	pop    %ebp
 693:	c3                   	ret    
 694:	be 00 80 00 00       	mov    $0x8000,%esi
 699:	eb 9e                	jmp    639 <malloc+0x55>
 69b:	90                   	nop
 69c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6a1:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 6a7:	76 eb                	jbe    694 <malloc+0xb0>
 6a9:	e9 76 ff ff ff       	jmp    624 <malloc+0x40>
 6ae:	66 90                	xchg   %ax,%ax
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 6b0:	8b 08                	mov    (%eax),%ecx
 6b2:	89 0a                	mov    %ecx,(%edx)
 6b4:	eb cd                	jmp    683 <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 6b6:	c7 05 f0 09 00 00 f4 	movl   $0x9f4,0x9f0
 6bd:	09 00 00 
 6c0:	c7 05 f4 09 00 00 f4 	movl   $0x9f4,0x9f4
 6c7:	09 00 00 
    base.s.size = 0;
 6ca:	c7 05 f8 09 00 00 00 	movl   $0x0,0x9f8
 6d1:	00 00 00 
 6d4:	b8 f4 09 00 00       	mov    $0x9f4,%eax
 6d9:	e9 30 ff ff ff       	jmp    60e <malloc+0x2a>
