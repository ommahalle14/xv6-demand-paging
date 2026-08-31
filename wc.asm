
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "%d %d %d %s\n", l, w, c, name);
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
  1c:	7e 5a                	jle    78 <main+0x78>
  1e:	83 c3 04             	add    $0x4,%ebx
  21:	be 01 00 00 00       	mov    $0x1,%esi
  26:	66 90                	xchg   %ax,%ax
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  28:	83 ec 08             	sub    $0x8,%esp
  2b:	6a 00                	push   $0x0
  2d:	ff 33                	pushl  (%ebx)
  2f:	e8 0f 03 00 00       	call   343 <open>
  34:	83 c4 10             	add    $0x10,%esp
  37:	85 c0                	test   %eax,%eax
  39:	78 29                	js     64 <main+0x64>
      printf(1, "wc: cannot open %s\n", argv[i]);
      exit();
    }
    wc(fd, argv[i]);
  3b:	83 ec 08             	sub    $0x8,%esp
  3e:	ff 33                	pushl  (%ebx)
  40:	50                   	push   %eax
  41:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  44:	e8 43 00 00 00       	call   8c <wc>
    close(fd);
  49:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  4c:	89 04 24             	mov    %eax,(%esp)
  4f:	e8 d7 02 00 00       	call   32b <close>
  if(argc <= 1){
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
  54:	46                   	inc    %esi
  55:	83 c3 04             	add    $0x4,%ebx
  58:	83 c4 10             	add    $0x10,%esp
  5b:	39 f7                	cmp    %esi,%edi
  5d:	75 c9                	jne    28 <main+0x28>
      exit();
    }
    wc(fd, argv[i]);
    close(fd);
  }
  exit();
  5f:	e8 9f 02 00 00       	call   303 <exit>
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "wc: cannot open %s\n", argv[i]);
  64:	50                   	push   %eax
  65:	ff 33                	pushl  (%ebx)
  67:	68 4b 07 00 00       	push   $0x74b
  6c:	6a 01                	push   $0x1
  6e:	e8 b5 03 00 00       	call   428 <printf>
      exit();
  73:	e8 8b 02 00 00       	call   303 <exit>
main(int argc, char *argv[])
{
  int fd, i;

  if(argc <= 1){
    wc(0, "");
  78:	52                   	push   %edx
  79:	52                   	push   %edx
  7a:	68 3d 07 00 00       	push   $0x73d
  7f:	6a 00                	push   $0x0
  81:	e8 06 00 00 00       	call   8c <wc>
    exit();
  86:	e8 78 02 00 00       	call   303 <exit>
  8b:	90                   	nop

0000008c <wc>:

char buf[512];

void
wc(int fd, char *name)
{
  8c:	55                   	push   %ebp
  8d:	89 e5                	mov    %esp,%ebp
  8f:	57                   	push   %edi
  90:	56                   	push   %esi
  91:	53                   	push   %ebx
  92:	83 ec 1c             	sub    $0x1c,%esp
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  95:	31 db                	xor    %ebx,%ebx
wc(int fd, char *name)
{
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  97:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  9e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  a5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
  ac:	50                   	push   %eax
  ad:	68 00 02 00 00       	push   $0x200
  b2:	68 60 0a 00 00       	push   $0xa60
  b7:	ff 75 08             	pushl  0x8(%ebp)
  ba:	e8 5c 02 00 00       	call   31b <read>
  bf:	89 c6                	mov    %eax,%esi
  c1:	83 c4 10             	add    $0x10,%esp
  c4:	83 f8 00             	cmp    $0x0,%eax
  c7:	7e 52                	jle    11b <wc+0x8f>
  c9:	31 ff                	xor    %edi,%edi
  cb:	eb 1f                	jmp    ec <wc+0x60>
  cd:	8d 76 00             	lea    0x0(%esi),%esi
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
  d0:	83 ec 08             	sub    $0x8,%esp
  d3:	50                   	push   %eax
  d4:	68 28 07 00 00       	push   $0x728
  d9:	e8 0a 01 00 00       	call   1e8 <strchr>
  de:	83 c4 10             	add    $0x10,%esp
  e1:	85 c0                	test   %eax,%eax
  e3:	74 17                	je     fc <wc+0x70>
        inword = 0;
  e5:	31 db                	xor    %ebx,%ebx
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
  e7:	47                   	inc    %edi
  e8:	39 fe                	cmp    %edi,%esi
  ea:	74 21                	je     10d <wc+0x81>
      c++;
      if(buf[i] == '\n')
  ec:	0f be 87 60 0a 00 00 	movsbl 0xa60(%edi),%eax
  f3:	3c 0a                	cmp    $0xa,%al
  f5:	75 d9                	jne    d0 <wc+0x44>
        l++;
  f7:	ff 45 e4             	incl   -0x1c(%ebp)
  fa:	eb d4                	jmp    d0 <wc+0x44>
      if(strchr(" \r\t\n\v", buf[i]))
        inword = 0;
      else if(!inword){
  fc:	85 db                	test   %ebx,%ebx
  fe:	75 14                	jne    114 <wc+0x88>
        w++;
 100:	ff 45 e0             	incl   -0x20(%ebp)
        inword = 1;
 103:	bb 01 00 00 00       	mov    $0x1,%ebx
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
 108:	47                   	inc    %edi
 109:	39 fe                	cmp    %edi,%esi
 10b:	75 df                	jne    ec <wc+0x60>
 10d:	01 75 dc             	add    %esi,-0x24(%ebp)
 110:	eb 9a                	jmp    ac <wc+0x20>
 112:	66 90                	xchg   %ax,%ax
 114:	bb 01 00 00 00       	mov    $0x1,%ebx
 119:	eb cc                	jmp    e7 <wc+0x5b>
        w++;
        inword = 1;
      }
    }
  }
  if(n < 0){
 11b:	75 26                	jne    143 <wc+0xb7>
    printf(1, "wc: read error\n");
    exit();
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
 11d:	83 ec 08             	sub    $0x8,%esp
 120:	ff 75 0c             	pushl  0xc(%ebp)
 123:	ff 75 dc             	pushl  -0x24(%ebp)
 126:	ff 75 e0             	pushl  -0x20(%ebp)
 129:	ff 75 e4             	pushl  -0x1c(%ebp)
 12c:	68 3e 07 00 00       	push   $0x73e
 131:	6a 01                	push   $0x1
 133:	e8 f0 02 00 00       	call   428 <printf>
}
 138:	83 c4 20             	add    $0x20,%esp
 13b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 13e:	5b                   	pop    %ebx
 13f:	5e                   	pop    %esi
 140:	5f                   	pop    %edi
 141:	5d                   	pop    %ebp
 142:	c3                   	ret    
        inword = 1;
      }
    }
  }
  if(n < 0){
    printf(1, "wc: read error\n");
 143:	83 ec 08             	sub    $0x8,%esp
 146:	68 2e 07 00 00       	push   $0x72e
 14b:	6a 01                	push   $0x1
 14d:	e8 d6 02 00 00       	call   428 <printf>
    exit();
 152:	e8 ac 01 00 00       	call   303 <exit>
 157:	90                   	nop

00000158 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 158:	55                   	push   %ebp
 159:	89 e5                	mov    %esp,%ebp
 15b:	53                   	push   %ebx
 15c:	8b 45 08             	mov    0x8(%ebp),%eax
 15f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 162:	89 c2                	mov    %eax,%edx
 164:	42                   	inc    %edx
 165:	41                   	inc    %ecx
 166:	8a 59 ff             	mov    -0x1(%ecx),%bl
 169:	88 5a ff             	mov    %bl,-0x1(%edx)
 16c:	84 db                	test   %bl,%bl
 16e:	75 f4                	jne    164 <strcpy+0xc>
    ;
  return os;
}
 170:	5b                   	pop    %ebx
 171:	5d                   	pop    %ebp
 172:	c3                   	ret    
 173:	90                   	nop

00000174 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 174:	55                   	push   %ebp
 175:	89 e5                	mov    %esp,%ebp
 177:	56                   	push   %esi
 178:	53                   	push   %ebx
 179:	8b 55 08             	mov    0x8(%ebp),%edx
 17c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 17f:	0f b6 02             	movzbl (%edx),%eax
 182:	0f b6 0b             	movzbl (%ebx),%ecx
 185:	84 c0                	test   %al,%al
 187:	75 14                	jne    19d <strcmp+0x29>
 189:	eb 1d                	jmp    1a8 <strcmp+0x34>
 18b:	90                   	nop
    p++, q++;
 18c:	42                   	inc    %edx
 18d:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 190:	0f b6 02             	movzbl (%edx),%eax
 193:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 197:	84 c0                	test   %al,%al
 199:	74 0d                	je     1a8 <strcmp+0x34>
 19b:	89 f3                	mov    %esi,%ebx
 19d:	38 c8                	cmp    %cl,%al
 19f:	74 eb                	je     18c <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1a1:	29 c8                	sub    %ecx,%eax
}
 1a3:	5b                   	pop    %ebx
 1a4:	5e                   	pop    %esi
 1a5:	5d                   	pop    %ebp
 1a6:	c3                   	ret    
 1a7:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1a8:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1aa:	29 c8                	sub    %ecx,%eax
}
 1ac:	5b                   	pop    %ebx
 1ad:	5e                   	pop    %esi
 1ae:	5d                   	pop    %ebp
 1af:	c3                   	ret    

000001b0 <strlen>:

uint
strlen(const char *s)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 1b6:	80 39 00             	cmpb   $0x0,(%ecx)
 1b9:	74 10                	je     1cb <strlen+0x1b>
 1bb:	31 d2                	xor    %edx,%edx
 1bd:	8d 76 00             	lea    0x0(%esi),%esi
 1c0:	42                   	inc    %edx
 1c1:	89 d0                	mov    %edx,%eax
 1c3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1c7:	75 f7                	jne    1c0 <strlen+0x10>
    ;
  return n;
}
 1c9:	5d                   	pop    %ebp
 1ca:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 1cb:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 1cd:	5d                   	pop    %ebp
 1ce:	c3                   	ret    
 1cf:	90                   	nop

000001d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	57                   	push   %edi
 1d4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1d7:	89 d7                	mov    %edx,%edi
 1d9:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1dc:	8b 45 0c             	mov    0xc(%ebp),%eax
 1df:	fc                   	cld    
 1e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1e2:	89 d0                	mov    %edx,%eax
 1e4:	5f                   	pop    %edi
 1e5:	5d                   	pop    %ebp
 1e6:	c3                   	ret    
 1e7:	90                   	nop

000001e8 <strchr>:

char*
strchr(const char *s, char c)
{
 1e8:	55                   	push   %ebp
 1e9:	89 e5                	mov    %esp,%ebp
 1eb:	53                   	push   %ebx
 1ec:	8b 45 08             	mov    0x8(%ebp),%eax
 1ef:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 1f2:	8a 10                	mov    (%eax),%dl
 1f4:	84 d2                	test   %dl,%dl
 1f6:	74 13                	je     20b <strchr+0x23>
 1f8:	88 d9                	mov    %bl,%cl
    if(*s == c)
 1fa:	38 d3                	cmp    %dl,%bl
 1fc:	75 06                	jne    204 <strchr+0x1c>
 1fe:	eb 0d                	jmp    20d <strchr+0x25>
 200:	38 ca                	cmp    %cl,%dl
 202:	74 09                	je     20d <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 204:	40                   	inc    %eax
 205:	8a 10                	mov    (%eax),%dl
 207:	84 d2                	test   %dl,%dl
 209:	75 f5                	jne    200 <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
 20b:	31 c0                	xor    %eax,%eax
}
 20d:	5b                   	pop    %ebx
 20e:	5d                   	pop    %ebp
 20f:	c3                   	ret    

00000210 <gets>:

char*
gets(char *buf, int max)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	57                   	push   %edi
 214:	56                   	push   %esi
 215:	53                   	push   %ebx
 216:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 219:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 21b:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 21e:	eb 26                	jmp    246 <gets+0x36>
    cc = read(0, &c, 1);
 220:	50                   	push   %eax
 221:	6a 01                	push   $0x1
 223:	57                   	push   %edi
 224:	6a 00                	push   $0x0
 226:	e8 f0 00 00 00       	call   31b <read>
    if(cc < 1)
 22b:	83 c4 10             	add    $0x10,%esp
 22e:	85 c0                	test   %eax,%eax
 230:	7e 1c                	jle    24e <gets+0x3e>
      break;
    buf[i++] = c;
 232:	8a 45 e7             	mov    -0x19(%ebp),%al
 235:	8b 55 08             	mov    0x8(%ebp),%edx
 238:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 23c:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 23e:	3c 0a                	cmp    $0xa,%al
 240:	74 0c                	je     24e <gets+0x3e>
 242:	3c 0d                	cmp    $0xd,%al
 244:	74 08                	je     24e <gets+0x3e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 246:	8d 5e 01             	lea    0x1(%esi),%ebx
 249:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 24c:	7c d2                	jl     220 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 24e:	8b 45 08             	mov    0x8(%ebp),%eax
 251:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 255:	8d 65 f4             	lea    -0xc(%ebp),%esp
 258:	5b                   	pop    %ebx
 259:	5e                   	pop    %esi
 25a:	5f                   	pop    %edi
 25b:	5d                   	pop    %ebp
 25c:	c3                   	ret    
 25d:	8d 76 00             	lea    0x0(%esi),%esi

00000260 <stat>:

int
stat(const char *n, struct stat *st)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	56                   	push   %esi
 264:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 265:	83 ec 08             	sub    $0x8,%esp
 268:	6a 00                	push   $0x0
 26a:	ff 75 08             	pushl  0x8(%ebp)
 26d:	e8 d1 00 00 00       	call   343 <open>
  if(fd < 0)
 272:	83 c4 10             	add    $0x10,%esp
 275:	85 c0                	test   %eax,%eax
 277:	78 27                	js     2a0 <stat+0x40>
 279:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 27b:	83 ec 08             	sub    $0x8,%esp
 27e:	ff 75 0c             	pushl  0xc(%ebp)
 281:	50                   	push   %eax
 282:	e8 d4 00 00 00       	call   35b <fstat>
 287:	89 c6                	mov    %eax,%esi
  close(fd);
 289:	89 1c 24             	mov    %ebx,(%esp)
 28c:	e8 9a 00 00 00       	call   32b <close>
  return r;
 291:	83 c4 10             	add    $0x10,%esp
 294:	89 f0                	mov    %esi,%eax
}
 296:	8d 65 f8             	lea    -0x8(%ebp),%esp
 299:	5b                   	pop    %ebx
 29a:	5e                   	pop    %esi
 29b:	5d                   	pop    %ebp
 29c:	c3                   	ret    
 29d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 2a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2a5:	eb ef                	jmp    296 <stat+0x36>
 2a7:	90                   	nop

000002a8 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 2a8:	55                   	push   %ebp
 2a9:	89 e5                	mov    %esp,%ebp
 2ab:	53                   	push   %ebx
 2ac:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2af:	0f be 11             	movsbl (%ecx),%edx
 2b2:	8d 42 d0             	lea    -0x30(%edx),%eax
 2b5:	3c 09                	cmp    $0x9,%al
 2b7:	b8 00 00 00 00       	mov    $0x0,%eax
 2bc:	77 15                	ja     2d3 <atoi+0x2b>
 2be:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 2c0:	41                   	inc    %ecx
 2c1:	8d 04 80             	lea    (%eax,%eax,4),%eax
 2c4:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2c8:	0f be 11             	movsbl (%ecx),%edx
 2cb:	8d 5a d0             	lea    -0x30(%edx),%ebx
 2ce:	80 fb 09             	cmp    $0x9,%bl
 2d1:	76 ed                	jbe    2c0 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 2d3:	5b                   	pop    %ebx
 2d4:	5d                   	pop    %ebp
 2d5:	c3                   	ret    
 2d6:	66 90                	xchg   %ax,%ax

000002d8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2d8:	55                   	push   %ebp
 2d9:	89 e5                	mov    %esp,%ebp
 2db:	56                   	push   %esi
 2dc:	53                   	push   %ebx
 2dd:	8b 45 08             	mov    0x8(%ebp),%eax
 2e0:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 2e3:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2e6:	85 f6                	test   %esi,%esi
 2e8:	7e 0d                	jle    2f7 <memmove+0x1f>
 2ea:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 2ec:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 2ef:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2f2:	42                   	inc    %edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2f3:	39 f2                	cmp    %esi,%edx
 2f5:	75 f5                	jne    2ec <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 2f7:	5b                   	pop    %ebx
 2f8:	5e                   	pop    %esi
 2f9:	5d                   	pop    %ebp
 2fa:	c3                   	ret    

000002fb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2fb:	b8 01 00 00 00       	mov    $0x1,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret    

00000303 <exit>:
SYSCALL(exit)
 303:	b8 02 00 00 00       	mov    $0x2,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret    

0000030b <wait>:
SYSCALL(wait)
 30b:	b8 03 00 00 00       	mov    $0x3,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret    

00000313 <pipe>:
SYSCALL(pipe)
 313:	b8 04 00 00 00       	mov    $0x4,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret    

0000031b <read>:
SYSCALL(read)
 31b:	b8 05 00 00 00       	mov    $0x5,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <write>:
SYSCALL(write)
 323:	b8 10 00 00 00       	mov    $0x10,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    

0000032b <close>:
SYSCALL(close)
 32b:	b8 15 00 00 00       	mov    $0x15,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    

00000333 <kill>:
SYSCALL(kill)
 333:	b8 06 00 00 00       	mov    $0x6,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <exec>:
SYSCALL(exec)
 33b:	b8 07 00 00 00       	mov    $0x7,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    

00000343 <open>:
SYSCALL(open)
 343:	b8 0f 00 00 00       	mov    $0xf,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret    

0000034b <mknod>:
SYSCALL(mknod)
 34b:	b8 11 00 00 00       	mov    $0x11,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <unlink>:
SYSCALL(unlink)
 353:	b8 12 00 00 00       	mov    $0x12,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    

0000035b <fstat>:
SYSCALL(fstat)
 35b:	b8 08 00 00 00       	mov    $0x8,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret    

00000363 <link>:
SYSCALL(link)
 363:	b8 13 00 00 00       	mov    $0x13,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret    

0000036b <mkdir>:
SYSCALL(mkdir)
 36b:	b8 14 00 00 00       	mov    $0x14,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    

00000373 <chdir>:
SYSCALL(chdir)
 373:	b8 09 00 00 00       	mov    $0x9,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret    

0000037b <dup>:
SYSCALL(dup)
 37b:	b8 0a 00 00 00       	mov    $0xa,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret    

00000383 <getpid>:
SYSCALL(getpid)
 383:	b8 0b 00 00 00       	mov    $0xb,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret    

0000038b <sbrk>:
SYSCALL(sbrk)
 38b:	b8 0c 00 00 00       	mov    $0xc,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <sleep>:
SYSCALL(sleep)
 393:	b8 0d 00 00 00       	mov    $0xd,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret    

0000039b <uptime>:
SYSCALL(uptime)
 39b:	b8 0e 00 00 00       	mov    $0xe,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret    
 3a3:	90                   	nop

000003a4 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3a4:	55                   	push   %ebp
 3a5:	89 e5                	mov    %esp,%ebp
 3a7:	57                   	push   %edi
 3a8:	56                   	push   %esi
 3a9:	53                   	push   %ebx
 3aa:	83 ec 3c             	sub    $0x3c,%esp
 3ad:	89 c6                	mov    %eax,%esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3af:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3b1:	8b 5d 08             	mov    0x8(%ebp),%ebx
 3b4:	85 db                	test   %ebx,%ebx
 3b6:	74 04                	je     3bc <printint+0x18>
 3b8:	85 d2                	test   %edx,%edx
 3ba:	78 5f                	js     41b <printint+0x77>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3bc:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 3c3:	31 ff                	xor    %edi,%edi
 3c5:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 3c8:	89 75 c4             	mov    %esi,-0x3c(%ebp)
 3cb:	89 ce                	mov    %ecx,%esi
 3cd:	eb 03                	jmp    3d2 <printint+0x2e>
 3cf:	90                   	nop
  do{
    buf[i++] = digits[x % base];
 3d0:	89 cf                	mov    %ecx,%edi
 3d2:	8d 4f 01             	lea    0x1(%edi),%ecx
 3d5:	31 d2                	xor    %edx,%edx
 3d7:	f7 f6                	div    %esi
 3d9:	8a 92 68 07 00 00    	mov    0x768(%edx),%dl
 3df:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 3e2:	85 c0                	test   %eax,%eax
 3e4:	75 ea                	jne    3d0 <printint+0x2c>
 3e6:	8b 75 c4             	mov    -0x3c(%ebp),%esi
  if(neg)
 3e9:	8b 55 c0             	mov    -0x40(%ebp),%edx
 3ec:	85 d2                	test   %edx,%edx
 3ee:	74 08                	je     3f8 <printint+0x54>
    buf[i++] = '-';
 3f0:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 3f5:	8d 4f 02             	lea    0x2(%edi),%ecx
 3f8:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 3fc:	8a 07                	mov    (%edi),%al
 3fe:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 401:	50                   	push   %eax
 402:	6a 01                	push   $0x1
 404:	53                   	push   %ebx
 405:	56                   	push   %esi
 406:	e8 18 ff ff ff       	call   323 <write>
 40b:	4f                   	dec    %edi
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 40c:	83 c4 10             	add    $0x10,%esp
 40f:	39 df                	cmp    %ebx,%edi
 411:	75 e9                	jne    3fc <printint+0x58>
    putc(fd, buf[i]);
}
 413:	8d 65 f4             	lea    -0xc(%ebp),%esp
 416:	5b                   	pop    %ebx
 417:	5e                   	pop    %esi
 418:	5f                   	pop    %edi
 419:	5d                   	pop    %ebp
 41a:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 41b:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 41d:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 424:	eb 9d                	jmp    3c3 <printint+0x1f>
 426:	66 90                	xchg   %ax,%ax

00000428 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 428:	55                   	push   %ebp
 429:	89 e5                	mov    %esp,%ebp
 42b:	57                   	push   %edi
 42c:	56                   	push   %esi
 42d:	53                   	push   %ebx
 42e:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 431:	8b 75 0c             	mov    0xc(%ebp),%esi
 434:	8a 1e                	mov    (%esi),%bl
 436:	84 db                	test   %bl,%bl
 438:	0f 84 a6 00 00 00    	je     4e4 <printf+0xbc>
 43e:	46                   	inc    %esi
 43f:	8d 45 10             	lea    0x10(%ebp),%eax
 442:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 445:	31 ff                	xor    %edi,%edi
 447:	eb 29                	jmp    472 <printf+0x4a>
 449:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 44c:	83 f8 25             	cmp    $0x25,%eax
 44f:	0f 84 97 00 00 00    	je     4ec <printf+0xc4>
 455:	88 5d e2             	mov    %bl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 458:	50                   	push   %eax
 459:	6a 01                	push   $0x1
 45b:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 45e:	50                   	push   %eax
 45f:	ff 75 08             	pushl  0x8(%ebp)
 462:	e8 bc fe ff ff       	call   323 <write>
 467:	83 c4 10             	add    $0x10,%esp
 46a:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 46b:	8a 5e ff             	mov    -0x1(%esi),%bl
 46e:	84 db                	test   %bl,%bl
 470:	74 72                	je     4e4 <printf+0xbc>
    c = fmt[i] & 0xff;
 472:	0f be cb             	movsbl %bl,%ecx
 475:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 478:	85 ff                	test   %edi,%edi
 47a:	74 d0                	je     44c <printf+0x24>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 47c:	83 ff 25             	cmp    $0x25,%edi
 47f:	75 e9                	jne    46a <printf+0x42>
      if(c == 'd'){
 481:	83 f8 64             	cmp    $0x64,%eax
 484:	0f 84 f6 00 00 00    	je     580 <printf+0x158>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 48a:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 490:	83 f9 70             	cmp    $0x70,%ecx
 493:	74 63                	je     4f8 <printf+0xd0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 495:	83 f8 73             	cmp    $0x73,%eax
 498:	0f 84 86 00 00 00    	je     524 <printf+0xfc>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 49e:	83 f8 63             	cmp    $0x63,%eax
 4a1:	0f 84 be 00 00 00    	je     565 <printf+0x13d>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4a7:	83 f8 25             	cmp    $0x25,%eax
 4aa:	0f 84 e0 00 00 00    	je     590 <printf+0x168>
 4b0:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4b4:	50                   	push   %eax
 4b5:	6a 01                	push   $0x1
 4b7:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4ba:	50                   	push   %eax
 4bb:	ff 75 08             	pushl  0x8(%ebp)
 4be:	e8 60 fe ff ff       	call   323 <write>
 4c3:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 4c6:	83 c4 0c             	add    $0xc,%esp
 4c9:	6a 01                	push   $0x1
 4cb:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4ce:	50                   	push   %eax
 4cf:	ff 75 08             	pushl  0x8(%ebp)
 4d2:	e8 4c fe ff ff       	call   323 <write>
 4d7:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4da:	31 ff                	xor    %edi,%edi
 4dc:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4dd:	8a 5e ff             	mov    -0x1(%esi),%bl
 4e0:	84 db                	test   %bl,%bl
 4e2:	75 8e                	jne    472 <printf+0x4a>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 4e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4e7:	5b                   	pop    %ebx
 4e8:	5e                   	pop    %esi
 4e9:	5f                   	pop    %edi
 4ea:	5d                   	pop    %ebp
 4eb:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 4ec:	bf 25 00 00 00       	mov    $0x25,%edi
 4f1:	e9 74 ff ff ff       	jmp    46a <printf+0x42>
 4f6:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 4f8:	83 ec 0c             	sub    $0xc,%esp
 4fb:	6a 00                	push   $0x0
 4fd:	b9 10 00 00 00       	mov    $0x10,%ecx
 502:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 505:	8b 17                	mov    (%edi),%edx
 507:	8b 45 08             	mov    0x8(%ebp),%eax
 50a:	e8 95 fe ff ff       	call   3a4 <printint>
        ap++;
 50f:	89 f8                	mov    %edi,%eax
 511:	83 c0 04             	add    $0x4,%eax
 514:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 517:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 51a:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 51c:	e9 49 ff ff ff       	jmp    46a <printf+0x42>
 521:	8d 76 00             	lea    0x0(%esi),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 524:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 527:	8b 38                	mov    (%eax),%edi
        ap++;
 529:	83 c0 04             	add    $0x4,%eax
 52c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 52f:	85 ff                	test   %edi,%edi
 531:	74 6b                	je     59e <printf+0x176>
          s = "(null)";
        while(*s != 0){
 533:	8a 07                	mov    (%edi),%al
 535:	84 c0                	test   %al,%al
 537:	74 6c                	je     5a5 <printf+0x17d>
 539:	8d 5d e3             	lea    -0x1d(%ebp),%ebx
 53c:	89 75 d0             	mov    %esi,-0x30(%ebp)
 53f:	89 fe                	mov    %edi,%esi
 541:	8b 7d 08             	mov    0x8(%ebp),%edi
 544:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 547:	50                   	push   %eax
 548:	6a 01                	push   $0x1
 54a:	53                   	push   %ebx
 54b:	57                   	push   %edi
 54c:	e8 d2 fd ff ff       	call   323 <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 551:	46                   	inc    %esi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 552:	8a 06                	mov    (%esi),%al
 554:	83 c4 10             	add    $0x10,%esp
 557:	84 c0                	test   %al,%al
 559:	75 e9                	jne    544 <printf+0x11c>
 55b:	8b 75 d0             	mov    -0x30(%ebp),%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 55e:	31 ff                	xor    %edi,%edi
 560:	e9 05 ff ff ff       	jmp    46a <printf+0x42>
 565:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 568:	8b 07                	mov    (%edi),%eax
 56a:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 56d:	51                   	push   %ecx
 56e:	6a 01                	push   $0x1
 570:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 573:	50                   	push   %eax
 574:	ff 75 08             	pushl  0x8(%ebp)
 577:	e8 a7 fd ff ff       	call   323 <write>
 57c:	eb 91                	jmp    50f <printf+0xe7>
 57e:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 580:	83 ec 0c             	sub    $0xc,%esp
 583:	6a 01                	push   $0x1
 585:	b9 0a 00 00 00       	mov    $0xa,%ecx
 58a:	e9 73 ff ff ff       	jmp    502 <printf+0xda>
 58f:	90                   	nop
 590:	88 5d e5             	mov    %bl,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 593:	52                   	push   %edx
 594:	6a 01                	push   $0x1
 596:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 599:	e9 30 ff ff ff       	jmp    4ce <printf+0xa6>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
 59e:	bf 5f 07 00 00       	mov    $0x75f,%edi
 5a3:	eb 8e                	jmp    533 <printf+0x10b>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5a5:	31 ff                	xor    %edi,%edi
 5a7:	e9 be fe ff ff       	jmp    46a <printf+0x42>

000005ac <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5ac:	55                   	push   %ebp
 5ad:	89 e5                	mov    %esp,%ebp
 5af:	57                   	push   %edi
 5b0:	56                   	push   %esi
 5b1:	53                   	push   %ebx
 5b2:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5b5:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5b8:	a1 40 0a 00 00       	mov    0xa40,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5bd:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5bf:	39 c8                	cmp    %ecx,%eax
 5c1:	73 11                	jae    5d4 <free+0x28>
 5c3:	90                   	nop
 5c4:	39 d1                	cmp    %edx,%ecx
 5c6:	72 14                	jb     5dc <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5c8:	39 d0                	cmp    %edx,%eax
 5ca:	73 10                	jae    5dc <free+0x30>
static Header base;
static Header *freep;

void
free(void *ap)
{
 5cc:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5ce:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5d0:	39 c8                	cmp    %ecx,%eax
 5d2:	72 f0                	jb     5c4 <free+0x18>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5d4:	39 d0                	cmp    %edx,%eax
 5d6:	72 f4                	jb     5cc <free+0x20>
 5d8:	39 d1                	cmp    %edx,%ecx
 5da:	73 f0                	jae    5cc <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 5dc:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5df:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5e2:	39 d7                	cmp    %edx,%edi
 5e4:	74 19                	je     5ff <free+0x53>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 5e6:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5e9:	8b 50 04             	mov    0x4(%eax),%edx
 5ec:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5ef:	39 f1                	cmp    %esi,%ecx
 5f1:	74 23                	je     616 <free+0x6a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 5f3:	89 08                	mov    %ecx,(%eax)
  freep = p;
 5f5:	a3 40 0a 00 00       	mov    %eax,0xa40
}
 5fa:	5b                   	pop    %ebx
 5fb:	5e                   	pop    %esi
 5fc:	5f                   	pop    %edi
 5fd:	5d                   	pop    %ebp
 5fe:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 5ff:	03 72 04             	add    0x4(%edx),%esi
 602:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 605:	8b 10                	mov    (%eax),%edx
 607:	8b 12                	mov    (%edx),%edx
 609:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 60c:	8b 50 04             	mov    0x4(%eax),%edx
 60f:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 612:	39 f1                	cmp    %esi,%ecx
 614:	75 dd                	jne    5f3 <free+0x47>
    p->s.size += bp->s.size;
 616:	03 53 fc             	add    -0x4(%ebx),%edx
 619:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 61c:	8b 53 f8             	mov    -0x8(%ebx),%edx
 61f:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 621:	a3 40 0a 00 00       	mov    %eax,0xa40
}
 626:	5b                   	pop    %ebx
 627:	5e                   	pop    %esi
 628:	5f                   	pop    %edi
 629:	5d                   	pop    %ebp
 62a:	c3                   	ret    
 62b:	90                   	nop

0000062c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 62c:	55                   	push   %ebp
 62d:	89 e5                	mov    %esp,%ebp
 62f:	57                   	push   %edi
 630:	56                   	push   %esi
 631:	53                   	push   %ebx
 632:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 635:	8b 45 08             	mov    0x8(%ebp),%eax
 638:	8d 78 07             	lea    0x7(%eax),%edi
 63b:	c1 ef 03             	shr    $0x3,%edi
 63e:	47                   	inc    %edi
  if((prevp = freep) == 0){
 63f:	8b 15 40 0a 00 00    	mov    0xa40,%edx
 645:	85 d2                	test   %edx,%edx
 647:	0f 84 b1 00 00 00    	je     6fe <malloc+0xd2>
 64d:	8b 02                	mov    (%edx),%eax
 64f:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 652:	39 cf                	cmp    %ecx,%edi
 654:	76 66                	jbe    6bc <malloc+0x90>
 656:	89 fb                	mov    %edi,%ebx
 658:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 65e:	0f 82 80 00 00 00    	jb     6e4 <malloc+0xb8>
 664:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 66a:	76 70                	jbe    6dc <malloc+0xb0>
 66c:	8d 34 fd 00 00 00 00 	lea    0x0(,%edi,8),%esi
 673:	eb 0c                	jmp    681 <malloc+0x55>
 675:	8d 76 00             	lea    0x0(%esi),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 678:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 67a:	8b 48 04             	mov    0x4(%eax),%ecx
 67d:	39 cf                	cmp    %ecx,%edi
 67f:	76 3b                	jbe    6bc <malloc+0x90>
 681:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 683:	39 05 40 0a 00 00    	cmp    %eax,0xa40
 689:	75 ed                	jne    678 <malloc+0x4c>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 68b:	83 ec 0c             	sub    $0xc,%esp
 68e:	56                   	push   %esi
 68f:	e8 f7 fc ff ff       	call   38b <sbrk>
  if(p == (char*)-1)
 694:	83 c4 10             	add    $0x10,%esp
 697:	83 f8 ff             	cmp    $0xffffffff,%eax
 69a:	74 1c                	je     6b8 <malloc+0x8c>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 69c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 69f:	83 ec 0c             	sub    $0xc,%esp
 6a2:	83 c0 08             	add    $0x8,%eax
 6a5:	50                   	push   %eax
 6a6:	e8 01 ff ff ff       	call   5ac <free>
  return freep;
 6ab:	8b 15 40 0a 00 00    	mov    0xa40,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 6b1:	83 c4 10             	add    $0x10,%esp
 6b4:	85 d2                	test   %edx,%edx
 6b6:	75 c0                	jne    678 <malloc+0x4c>
        return 0;
 6b8:	31 c0                	xor    %eax,%eax
 6ba:	eb 18                	jmp    6d4 <malloc+0xa8>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 6bc:	39 cf                	cmp    %ecx,%edi
 6be:	74 38                	je     6f8 <malloc+0xcc>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 6c0:	29 f9                	sub    %edi,%ecx
 6c2:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 6c5:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 6c8:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 6cb:	89 15 40 0a 00 00    	mov    %edx,0xa40
      return (void*)(p + 1);
 6d1:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 6d4:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6d7:	5b                   	pop    %ebx
 6d8:	5e                   	pop    %esi
 6d9:	5f                   	pop    %edi
 6da:	5d                   	pop    %ebp
 6db:	c3                   	ret    
 6dc:	be 00 80 00 00       	mov    $0x8000,%esi
 6e1:	eb 9e                	jmp    681 <malloc+0x55>
 6e3:	90                   	nop
 6e4:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6e9:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 6ef:	76 eb                	jbe    6dc <malloc+0xb0>
 6f1:	e9 76 ff ff ff       	jmp    66c <malloc+0x40>
 6f6:	66 90                	xchg   %ax,%ax
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 6f8:	8b 08                	mov    (%eax),%ecx
 6fa:	89 0a                	mov    %ecx,(%edx)
 6fc:	eb cd                	jmp    6cb <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 6fe:	c7 05 40 0a 00 00 44 	movl   $0xa44,0xa40
 705:	0a 00 00 
 708:	c7 05 44 0a 00 00 44 	movl   $0xa44,0xa44
 70f:	0a 00 00 
    base.s.size = 0;
 712:	c7 05 48 0a 00 00 00 	movl   $0x0,0xa48
 719:	00 00 00 
 71c:	b8 44 0a 00 00       	mov    $0xa44,%eax
 721:	e9 30 ff ff ff       	jmp    656 <malloc+0x2a>
