
_grep:     file format elf32-i386


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
  14:	8b 01                	mov    (%ecx),%eax
  16:	89 45 e0             	mov    %eax,-0x20(%ebp)
  19:	8b 59 04             	mov    0x4(%ecx),%ebx
  int fd, i;
  char *pattern;

  if(argc <= 1){
  1c:	48                   	dec    %eax
  1d:	7e 70                	jle    8f <main+0x8f>
    printf(2, "usage: grep pattern [file ...]\n");
    exit();
  }
  pattern = argv[1];
  1f:	8b 7b 04             	mov    0x4(%ebx),%edi

  if(argc <= 2){
  22:	83 7d e0 02          	cmpl   $0x2,-0x20(%ebp)
  26:	74 58                	je     80 <main+0x80>
  28:	83 c3 08             	add    $0x8,%ebx
  2b:	be 02 00 00 00       	mov    $0x2,%esi
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  30:	83 ec 08             	sub    $0x8,%esp
  33:	6a 00                	push   $0x0
  35:	ff 33                	pushl  (%ebx)
  37:	e8 47 04 00 00       	call   483 <open>
  3c:	83 c4 10             	add    $0x10,%esp
  3f:	85 c0                	test   %eax,%eax
  41:	78 29                	js     6c <main+0x6c>
      printf(1, "grep: cannot open %s\n", argv[i]);
      exit();
    }
    grep(pattern, fd);
  43:	83 ec 08             	sub    $0x8,%esp
  46:	50                   	push   %eax
  47:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  4a:	57                   	push   %edi
  4b:	e8 64 01 00 00       	call   1b4 <grep>
    close(fd);
  50:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  53:	89 04 24             	mov    %eax,(%esp)
  56:	e8 10 04 00 00       	call   46b <close>
  if(argc <= 2){
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
  5b:	46                   	inc    %esi
  5c:	83 c3 04             	add    $0x4,%ebx
  5f:	83 c4 10             	add    $0x10,%esp
  62:	39 75 e0             	cmp    %esi,-0x20(%ebp)
  65:	7f c9                	jg     30 <main+0x30>
      exit();
    }
    grep(pattern, fd);
    close(fd);
  }
  exit();
  67:	e8 d7 03 00 00       	call   443 <exit>
    exit();
  }

  for(i = 2; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "grep: cannot open %s\n", argv[i]);
  6c:	50                   	push   %eax
  6d:	ff 33                	pushl  (%ebx)
  6f:	68 88 08 00 00       	push   $0x888
  74:	6a 01                	push   $0x1
  76:	e8 ed 04 00 00       	call   568 <printf>
      exit();
  7b:	e8 c3 03 00 00       	call   443 <exit>
    exit();
  }
  pattern = argv[1];

  if(argc <= 2){
    grep(pattern, 0);
  80:	52                   	push   %edx
  81:	52                   	push   %edx
  82:	6a 00                	push   $0x0
  84:	57                   	push   %edi
  85:	e8 2a 01 00 00       	call   1b4 <grep>
    exit();
  8a:	e8 b4 03 00 00       	call   443 <exit>
{
  int fd, i;
  char *pattern;

  if(argc <= 1){
    printf(2, "usage: grep pattern [file ...]\n");
  8f:	51                   	push   %ecx
  90:	51                   	push   %ecx
  91:	68 68 08 00 00       	push   $0x868
  96:	6a 02                	push   $0x2
  98:	e8 cb 04 00 00       	call   568 <printf>
    exit();
  9d:	e8 a1 03 00 00       	call   443 <exit>
  a2:	66 90                	xchg   %ax,%ax

000000a4 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
  a4:	55                   	push   %ebp
  a5:	89 e5                	mov    %esp,%ebp
  a7:	57                   	push   %edi
  a8:	56                   	push   %esi
  a9:	53                   	push   %ebx
  aa:	83 ec 0c             	sub    $0xc,%esp
  ad:	8b 5d 08             	mov    0x8(%ebp),%ebx
  b0:	8b 75 0c             	mov    0xc(%ebp),%esi
  b3:	8b 7d 10             	mov    0x10(%ebp),%edi
  b6:	66 90                	xchg   %ax,%ax
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
  b8:	83 ec 08             	sub    $0x8,%esp
  bb:	57                   	push   %edi
  bc:	56                   	push   %esi
  bd:	e8 32 00 00 00       	call   f4 <matchhere>
  c2:	83 c4 10             	add    $0x10,%esp
  c5:	85 c0                	test   %eax,%eax
  c7:	75 1b                	jne    e4 <matchstar+0x40>
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  c9:	0f be 17             	movsbl (%edi),%edx
  cc:	84 d2                	test   %dl,%dl
  ce:	74 0a                	je     da <matchstar+0x36>
  d0:	47                   	inc    %edi
  d1:	39 da                	cmp    %ebx,%edx
  d3:	74 e3                	je     b8 <matchstar+0x14>
  d5:	83 fb 2e             	cmp    $0x2e,%ebx
  d8:	74 de                	je     b8 <matchstar+0x14>
  return 0;
}
  da:	8d 65 f4             	lea    -0xc(%ebp),%esp
  dd:	5b                   	pop    %ebx
  de:	5e                   	pop    %esi
  df:	5f                   	pop    %edi
  e0:	5d                   	pop    %ebp
  e1:	c3                   	ret    
  e2:	66 90                	xchg   %ax,%ax
// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  e4:	b8 01 00 00 00       	mov    $0x1,%eax
  }while(*text!='\0' && (*text++==c || c=='.'));
  return 0;
}
  e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
  ec:	5b                   	pop    %ebx
  ed:	5e                   	pop    %esi
  ee:	5f                   	pop    %edi
  ef:	5d                   	pop    %ebp
  f0:	c3                   	ret    
  f1:	8d 76 00             	lea    0x0(%esi),%esi

000000f4 <matchhere>:
  return 0;
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  f4:	55                   	push   %ebp
  f5:	89 e5                	mov    %esp,%ebp
  f7:	53                   	push   %ebx
  f8:	50                   	push   %eax
  f9:	8b 55 08             	mov    0x8(%ebp),%edx
  fc:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  if(re[0] == '\0')
  ff:	0f be 02             	movsbl (%edx),%eax
 102:	84 c0                	test   %al,%al
 104:	75 19                	jne    11f <matchhere+0x2b>
 106:	eb 38                	jmp    140 <matchhere+0x4c>
    return 1;
  if(re[1] == '*')
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 108:	8a 19                	mov    (%ecx),%bl
 10a:	84 db                	test   %bl,%bl
 10c:	74 2a                	je     138 <matchhere+0x44>
 10e:	3c 2e                	cmp    $0x2e,%al
 110:	74 04                	je     116 <matchhere+0x22>
 112:	38 c3                	cmp    %al,%bl
 114:	75 22                	jne    138 <matchhere+0x44>
    return matchhere(re+1, text+1);
 116:	41                   	inc    %ecx
 117:	42                   	inc    %edx
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
 118:	0f be 02             	movsbl (%edx),%eax
 11b:	84 c0                	test   %al,%al
 11d:	74 21                	je     140 <matchhere+0x4c>
    return 1;
  if(re[1] == '*')
 11f:	8a 5a 01             	mov    0x1(%edx),%bl
 122:	80 fb 2a             	cmp    $0x2a,%bl
 125:	74 25                	je     14c <matchhere+0x58>
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
 127:	3c 24                	cmp    $0x24,%al
 129:	75 dd                	jne    108 <matchhere+0x14>
 12b:	84 db                	test   %bl,%bl
 12d:	74 31                	je     160 <matchhere+0x6c>
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 12f:	8a 19                	mov    (%ecx),%bl
 131:	84 db                	test   %bl,%bl
 133:	75 dd                	jne    112 <matchhere+0x1e>
 135:	8d 76 00             	lea    0x0(%esi),%esi
    return matchhere(re+1, text+1);
  return 0;
 138:	31 c0                	xor    %eax,%eax
}
 13a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 13d:	c9                   	leave  
 13e:	c3                   	ret    
 13f:	90                   	nop

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
    return 1;
 140:	b8 01 00 00 00       	mov    $0x1,%eax
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    return matchhere(re+1, text+1);
  return 0;
}
 145:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 148:	c9                   	leave  
 149:	c3                   	ret    
 14a:	66 90                	xchg   %ax,%ax
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
    return 1;
  if(re[1] == '*')
    return matchstar(re[0], re+2, text);
 14c:	53                   	push   %ebx
 14d:	51                   	push   %ecx
 14e:	83 c2 02             	add    $0x2,%edx
 151:	52                   	push   %edx
 152:	50                   	push   %eax
 153:	e8 4c ff ff ff       	call   a4 <matchstar>
 158:	83 c4 10             	add    $0x10,%esp
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    return matchhere(re+1, text+1);
  return 0;
}
 15b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 15e:	c9                   	leave  
 15f:	c3                   	ret    
  if(re[0] == '\0')
    return 1;
  if(re[1] == '*')
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
 160:	31 c0                	xor    %eax,%eax
 162:	80 39 00             	cmpb   $0x0,(%ecx)
 165:	0f 94 c0             	sete   %al
 168:	eb d0                	jmp    13a <matchhere+0x46>
 16a:	66 90                	xchg   %ax,%ax

0000016c <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
 16c:	55                   	push   %ebp
 16d:	89 e5                	mov    %esp,%ebp
 16f:	56                   	push   %esi
 170:	53                   	push   %ebx
 171:	8b 75 08             	mov    0x8(%ebp),%esi
 174:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(re[0] == '^')
 177:	80 3e 5e             	cmpb   $0x5e,(%esi)
 17a:	75 0b                	jne    187 <match+0x1b>
 17c:	eb 26                	jmp    1a4 <match+0x38>
 17e:	66 90                	xchg   %ax,%ax
    return matchhere(re+1, text);
  do{  // must look at empty string
    if(matchhere(re, text))
      return 1;
  }while(*text++ != '\0');
 180:	43                   	inc    %ebx
 181:	80 7b ff 00          	cmpb   $0x0,-0x1(%ebx)
 185:	74 16                	je     19d <match+0x31>
match(char *re, char *text)
{
  if(re[0] == '^')
    return matchhere(re+1, text);
  do{  // must look at empty string
    if(matchhere(re, text))
 187:	83 ec 08             	sub    $0x8,%esp
 18a:	53                   	push   %ebx
 18b:	56                   	push   %esi
 18c:	e8 63 ff ff ff       	call   f4 <matchhere>
 191:	83 c4 10             	add    $0x10,%esp
 194:	85 c0                	test   %eax,%eax
 196:	74 e8                	je     180 <match+0x14>
      return 1;
 198:	b8 01 00 00 00       	mov    $0x1,%eax
  }while(*text++ != '\0');
  return 0;
}
 19d:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1a0:	5b                   	pop    %ebx
 1a1:	5e                   	pop    %esi
 1a2:	5d                   	pop    %ebp
 1a3:	c3                   	ret    

int
match(char *re, char *text)
{
  if(re[0] == '^')
    return matchhere(re+1, text);
 1a4:	46                   	inc    %esi
 1a5:	89 75 08             	mov    %esi,0x8(%ebp)
  do{  // must look at empty string
    if(matchhere(re, text))
      return 1;
  }while(*text++ != '\0');
  return 0;
}
 1a8:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1ab:	5b                   	pop    %ebx
 1ac:	5e                   	pop    %esi
 1ad:	5d                   	pop    %ebp

int
match(char *re, char *text)
{
  if(re[0] == '^')
    return matchhere(re+1, text);
 1ae:	e9 41 ff ff ff       	jmp    f4 <matchhere>
 1b3:	90                   	nop

000001b4 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
 1b4:	55                   	push   %ebp
 1b5:	89 e5                	mov    %esp,%ebp
 1b7:	57                   	push   %edi
 1b8:	56                   	push   %esi
 1b9:	53                   	push   %ebx
 1ba:	83 ec 1c             	sub    $0x1c,%esp
 1bd:	8b 7d 08             	mov    0x8(%ebp),%edi
  int n, m;
  char *p, *q;

  m = 0;
 1c0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 1c7:	90                   	nop
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 1c8:	50                   	push   %eax
 1c9:	b8 ff 03 00 00       	mov    $0x3ff,%eax
 1ce:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
 1d1:	29 c8                	sub    %ecx,%eax
 1d3:	50                   	push   %eax
 1d4:	8d 81 40 0c 00 00    	lea    0xc40(%ecx),%eax
 1da:	50                   	push   %eax
 1db:	ff 75 0c             	pushl  0xc(%ebp)
 1de:	e8 78 02 00 00       	call   45b <read>
 1e3:	83 c4 10             	add    $0x10,%esp
 1e6:	85 c0                	test   %eax,%eax
 1e8:	0f 8e a2 00 00 00    	jle    290 <grep+0xdc>
    m += n;
 1ee:	01 45 e4             	add    %eax,-0x1c(%ebp)
 1f1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    buf[m] = '\0';
 1f4:	c6 82 40 0c 00 00 00 	movb   $0x0,0xc40(%edx)
    p = buf;
 1fb:	be 40 0c 00 00       	mov    $0xc40,%esi
    while((q = strchr(p, '\n')) != 0){
 200:	83 ec 08             	sub    $0x8,%esp
 203:	6a 0a                	push   $0xa
 205:	56                   	push   %esi
 206:	e8 1d 01 00 00       	call   328 <strchr>
 20b:	89 c3                	mov    %eax,%ebx
 20d:	83 c4 10             	add    $0x10,%esp
 210:	85 c0                	test   %eax,%eax
 212:	74 38                	je     24c <grep+0x98>
      *q = 0;
 214:	c6 03 00             	movb   $0x0,(%ebx)
      if(match(pattern, p)){
 217:	83 ec 08             	sub    $0x8,%esp
 21a:	56                   	push   %esi
 21b:	57                   	push   %edi
 21c:	e8 4b ff ff ff       	call   16c <match>
 221:	83 c4 10             	add    $0x10,%esp
 224:	85 c0                	test   %eax,%eax
 226:	75 08                	jne    230 <grep+0x7c>
 228:	8d 73 01             	lea    0x1(%ebx),%esi
 22b:	eb d3                	jmp    200 <grep+0x4c>
 22d:	8d 76 00             	lea    0x0(%esi),%esi
        *q = '\n';
 230:	c6 03 0a             	movb   $0xa,(%ebx)
        write(1, p, q+1 - p);
 233:	43                   	inc    %ebx
 234:	50                   	push   %eax
 235:	89 d8                	mov    %ebx,%eax
 237:	29 f0                	sub    %esi,%eax
 239:	50                   	push   %eax
 23a:	56                   	push   %esi
 23b:	6a 01                	push   $0x1
 23d:	e8 21 02 00 00       	call   463 <write>
 242:	83 c4 10             	add    $0x10,%esp
 245:	89 de                	mov    %ebx,%esi
 247:	eb b7                	jmp    200 <grep+0x4c>
 249:	8d 76 00             	lea    0x0(%esi),%esi
      }
      p = q+1;
    }
    if(p == buf)
 24c:	81 fe 40 0c 00 00    	cmp    $0xc40,%esi
 252:	74 30                	je     284 <grep+0xd0>
      m = 0;
    if(m > 0){
 254:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
 257:	85 c9                	test   %ecx,%ecx
 259:	0f 8e 69 ff ff ff    	jle    1c8 <grep+0x14>
      m -= p - buf;
 25f:	b8 40 0c 00 00       	mov    $0xc40,%eax
 264:	29 f0                	sub    %esi,%eax
 266:	01 45 e4             	add    %eax,-0x1c(%ebp)
 269:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
      memmove(buf, p, m);
 26c:	52                   	push   %edx
 26d:	51                   	push   %ecx
 26e:	56                   	push   %esi
 26f:	68 40 0c 00 00       	push   $0xc40
 274:	e8 9f 01 00 00       	call   418 <memmove>
 279:	83 c4 10             	add    $0x10,%esp
 27c:	e9 47 ff ff ff       	jmp    1c8 <grep+0x14>
 281:	8d 76 00             	lea    0x0(%esi),%esi
        write(1, p, q+1 - p);
      }
      p = q+1;
    }
    if(p == buf)
      m = 0;
 284:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 28b:	e9 38 ff ff ff       	jmp    1c8 <grep+0x14>
    if(m > 0){
      m -= p - buf;
      memmove(buf, p, m);
    }
  }
}
 290:	8d 65 f4             	lea    -0xc(%ebp),%esp
 293:	5b                   	pop    %ebx
 294:	5e                   	pop    %esi
 295:	5f                   	pop    %edi
 296:	5d                   	pop    %ebp
 297:	c3                   	ret    

00000298 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 298:	55                   	push   %ebp
 299:	89 e5                	mov    %esp,%ebp
 29b:	53                   	push   %ebx
 29c:	8b 45 08             	mov    0x8(%ebp),%eax
 29f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2a2:	89 c2                	mov    %eax,%edx
 2a4:	42                   	inc    %edx
 2a5:	41                   	inc    %ecx
 2a6:	8a 59 ff             	mov    -0x1(%ecx),%bl
 2a9:	88 5a ff             	mov    %bl,-0x1(%edx)
 2ac:	84 db                	test   %bl,%bl
 2ae:	75 f4                	jne    2a4 <strcpy+0xc>
    ;
  return os;
}
 2b0:	5b                   	pop    %ebx
 2b1:	5d                   	pop    %ebp
 2b2:	c3                   	ret    
 2b3:	90                   	nop

000002b4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2b4:	55                   	push   %ebp
 2b5:	89 e5                	mov    %esp,%ebp
 2b7:	56                   	push   %esi
 2b8:	53                   	push   %ebx
 2b9:	8b 55 08             	mov    0x8(%ebp),%edx
 2bc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 2bf:	0f b6 02             	movzbl (%edx),%eax
 2c2:	0f b6 0b             	movzbl (%ebx),%ecx
 2c5:	84 c0                	test   %al,%al
 2c7:	75 14                	jne    2dd <strcmp+0x29>
 2c9:	eb 1d                	jmp    2e8 <strcmp+0x34>
 2cb:	90                   	nop
    p++, q++;
 2cc:	42                   	inc    %edx
 2cd:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2d0:	0f b6 02             	movzbl (%edx),%eax
 2d3:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 2d7:	84 c0                	test   %al,%al
 2d9:	74 0d                	je     2e8 <strcmp+0x34>
 2db:	89 f3                	mov    %esi,%ebx
 2dd:	38 c8                	cmp    %cl,%al
 2df:	74 eb                	je     2cc <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 2e1:	29 c8                	sub    %ecx,%eax
}
 2e3:	5b                   	pop    %ebx
 2e4:	5e                   	pop    %esi
 2e5:	5d                   	pop    %ebp
 2e6:	c3                   	ret    
 2e7:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2e8:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 2ea:	29 c8                	sub    %ecx,%eax
}
 2ec:	5b                   	pop    %ebx
 2ed:	5e                   	pop    %esi
 2ee:	5d                   	pop    %ebp
 2ef:	c3                   	ret    

000002f0 <strlen>:

uint
strlen(const char *s)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 2f6:	80 39 00             	cmpb   $0x0,(%ecx)
 2f9:	74 10                	je     30b <strlen+0x1b>
 2fb:	31 d2                	xor    %edx,%edx
 2fd:	8d 76 00             	lea    0x0(%esi),%esi
 300:	42                   	inc    %edx
 301:	89 d0                	mov    %edx,%eax
 303:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 307:	75 f7                	jne    300 <strlen+0x10>
    ;
  return n;
}
 309:	5d                   	pop    %ebp
 30a:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 30b:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 30d:	5d                   	pop    %ebp
 30e:	c3                   	ret    
 30f:	90                   	nop

00000310 <memset>:

void*
memset(void *dst, int c, uint n)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	57                   	push   %edi
 314:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 317:	89 d7                	mov    %edx,%edi
 319:	8b 4d 10             	mov    0x10(%ebp),%ecx
 31c:	8b 45 0c             	mov    0xc(%ebp),%eax
 31f:	fc                   	cld    
 320:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 322:	89 d0                	mov    %edx,%eax
 324:	5f                   	pop    %edi
 325:	5d                   	pop    %ebp
 326:	c3                   	ret    
 327:	90                   	nop

00000328 <strchr>:

char*
strchr(const char *s, char c)
{
 328:	55                   	push   %ebp
 329:	89 e5                	mov    %esp,%ebp
 32b:	53                   	push   %ebx
 32c:	8b 45 08             	mov    0x8(%ebp),%eax
 32f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 332:	8a 10                	mov    (%eax),%dl
 334:	84 d2                	test   %dl,%dl
 336:	74 13                	je     34b <strchr+0x23>
 338:	88 d9                	mov    %bl,%cl
    if(*s == c)
 33a:	38 d3                	cmp    %dl,%bl
 33c:	75 06                	jne    344 <strchr+0x1c>
 33e:	eb 0d                	jmp    34d <strchr+0x25>
 340:	38 ca                	cmp    %cl,%dl
 342:	74 09                	je     34d <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 344:	40                   	inc    %eax
 345:	8a 10                	mov    (%eax),%dl
 347:	84 d2                	test   %dl,%dl
 349:	75 f5                	jne    340 <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
 34b:	31 c0                	xor    %eax,%eax
}
 34d:	5b                   	pop    %ebx
 34e:	5d                   	pop    %ebp
 34f:	c3                   	ret    

00000350 <gets>:

char*
gets(char *buf, int max)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	57                   	push   %edi
 354:	56                   	push   %esi
 355:	53                   	push   %ebx
 356:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 359:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 35b:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 35e:	eb 26                	jmp    386 <gets+0x36>
    cc = read(0, &c, 1);
 360:	50                   	push   %eax
 361:	6a 01                	push   $0x1
 363:	57                   	push   %edi
 364:	6a 00                	push   $0x0
 366:	e8 f0 00 00 00       	call   45b <read>
    if(cc < 1)
 36b:	83 c4 10             	add    $0x10,%esp
 36e:	85 c0                	test   %eax,%eax
 370:	7e 1c                	jle    38e <gets+0x3e>
      break;
    buf[i++] = c;
 372:	8a 45 e7             	mov    -0x19(%ebp),%al
 375:	8b 55 08             	mov    0x8(%ebp),%edx
 378:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 37c:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 37e:	3c 0a                	cmp    $0xa,%al
 380:	74 0c                	je     38e <gets+0x3e>
 382:	3c 0d                	cmp    $0xd,%al
 384:	74 08                	je     38e <gets+0x3e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 386:	8d 5e 01             	lea    0x1(%esi),%ebx
 389:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 38c:	7c d2                	jl     360 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 38e:	8b 45 08             	mov    0x8(%ebp),%eax
 391:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 395:	8d 65 f4             	lea    -0xc(%ebp),%esp
 398:	5b                   	pop    %ebx
 399:	5e                   	pop    %esi
 39a:	5f                   	pop    %edi
 39b:	5d                   	pop    %ebp
 39c:	c3                   	ret    
 39d:	8d 76 00             	lea    0x0(%esi),%esi

000003a0 <stat>:

int
stat(const char *n, struct stat *st)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	56                   	push   %esi
 3a4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3a5:	83 ec 08             	sub    $0x8,%esp
 3a8:	6a 00                	push   $0x0
 3aa:	ff 75 08             	pushl  0x8(%ebp)
 3ad:	e8 d1 00 00 00       	call   483 <open>
  if(fd < 0)
 3b2:	83 c4 10             	add    $0x10,%esp
 3b5:	85 c0                	test   %eax,%eax
 3b7:	78 27                	js     3e0 <stat+0x40>
 3b9:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 3bb:	83 ec 08             	sub    $0x8,%esp
 3be:	ff 75 0c             	pushl  0xc(%ebp)
 3c1:	50                   	push   %eax
 3c2:	e8 d4 00 00 00       	call   49b <fstat>
 3c7:	89 c6                	mov    %eax,%esi
  close(fd);
 3c9:	89 1c 24             	mov    %ebx,(%esp)
 3cc:	e8 9a 00 00 00       	call   46b <close>
  return r;
 3d1:	83 c4 10             	add    $0x10,%esp
 3d4:	89 f0                	mov    %esi,%eax
}
 3d6:	8d 65 f8             	lea    -0x8(%ebp),%esp
 3d9:	5b                   	pop    %ebx
 3da:	5e                   	pop    %esi
 3db:	5d                   	pop    %ebp
 3dc:	c3                   	ret    
 3dd:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 3e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 3e5:	eb ef                	jmp    3d6 <stat+0x36>
 3e7:	90                   	nop

000003e8 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 3e8:	55                   	push   %ebp
 3e9:	89 e5                	mov    %esp,%ebp
 3eb:	53                   	push   %ebx
 3ec:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3ef:	0f be 11             	movsbl (%ecx),%edx
 3f2:	8d 42 d0             	lea    -0x30(%edx),%eax
 3f5:	3c 09                	cmp    $0x9,%al
 3f7:	b8 00 00 00 00       	mov    $0x0,%eax
 3fc:	77 15                	ja     413 <atoi+0x2b>
 3fe:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 400:	41                   	inc    %ecx
 401:	8d 04 80             	lea    (%eax,%eax,4),%eax
 404:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 408:	0f be 11             	movsbl (%ecx),%edx
 40b:	8d 5a d0             	lea    -0x30(%edx),%ebx
 40e:	80 fb 09             	cmp    $0x9,%bl
 411:	76 ed                	jbe    400 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 413:	5b                   	pop    %ebx
 414:	5d                   	pop    %ebp
 415:	c3                   	ret    
 416:	66 90                	xchg   %ax,%ax

00000418 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 418:	55                   	push   %ebp
 419:	89 e5                	mov    %esp,%ebp
 41b:	56                   	push   %esi
 41c:	53                   	push   %ebx
 41d:	8b 45 08             	mov    0x8(%ebp),%eax
 420:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 423:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 426:	85 f6                	test   %esi,%esi
 428:	7e 0d                	jle    437 <memmove+0x1f>
 42a:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 42c:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 42f:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 432:	42                   	inc    %edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 433:	39 f2                	cmp    %esi,%edx
 435:	75 f5                	jne    42c <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 437:	5b                   	pop    %ebx
 438:	5e                   	pop    %esi
 439:	5d                   	pop    %ebp
 43a:	c3                   	ret    

0000043b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 43b:	b8 01 00 00 00       	mov    $0x1,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret    

00000443 <exit>:
SYSCALL(exit)
 443:	b8 02 00 00 00       	mov    $0x2,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret    

0000044b <wait>:
SYSCALL(wait)
 44b:	b8 03 00 00 00       	mov    $0x3,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret    

00000453 <pipe>:
SYSCALL(pipe)
 453:	b8 04 00 00 00       	mov    $0x4,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret    

0000045b <read>:
SYSCALL(read)
 45b:	b8 05 00 00 00       	mov    $0x5,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret    

00000463 <write>:
SYSCALL(write)
 463:	b8 10 00 00 00       	mov    $0x10,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret    

0000046b <close>:
SYSCALL(close)
 46b:	b8 15 00 00 00       	mov    $0x15,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret    

00000473 <kill>:
SYSCALL(kill)
 473:	b8 06 00 00 00       	mov    $0x6,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret    

0000047b <exec>:
SYSCALL(exec)
 47b:	b8 07 00 00 00       	mov    $0x7,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret    

00000483 <open>:
SYSCALL(open)
 483:	b8 0f 00 00 00       	mov    $0xf,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret    

0000048b <mknod>:
SYSCALL(mknod)
 48b:	b8 11 00 00 00       	mov    $0x11,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret    

00000493 <unlink>:
SYSCALL(unlink)
 493:	b8 12 00 00 00       	mov    $0x12,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret    

0000049b <fstat>:
SYSCALL(fstat)
 49b:	b8 08 00 00 00       	mov    $0x8,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret    

000004a3 <link>:
SYSCALL(link)
 4a3:	b8 13 00 00 00       	mov    $0x13,%eax
 4a8:	cd 40                	int    $0x40
 4aa:	c3                   	ret    

000004ab <mkdir>:
SYSCALL(mkdir)
 4ab:	b8 14 00 00 00       	mov    $0x14,%eax
 4b0:	cd 40                	int    $0x40
 4b2:	c3                   	ret    

000004b3 <chdir>:
SYSCALL(chdir)
 4b3:	b8 09 00 00 00       	mov    $0x9,%eax
 4b8:	cd 40                	int    $0x40
 4ba:	c3                   	ret    

000004bb <dup>:
SYSCALL(dup)
 4bb:	b8 0a 00 00 00       	mov    $0xa,%eax
 4c0:	cd 40                	int    $0x40
 4c2:	c3                   	ret    

000004c3 <getpid>:
SYSCALL(getpid)
 4c3:	b8 0b 00 00 00       	mov    $0xb,%eax
 4c8:	cd 40                	int    $0x40
 4ca:	c3                   	ret    

000004cb <sbrk>:
SYSCALL(sbrk)
 4cb:	b8 0c 00 00 00       	mov    $0xc,%eax
 4d0:	cd 40                	int    $0x40
 4d2:	c3                   	ret    

000004d3 <sleep>:
SYSCALL(sleep)
 4d3:	b8 0d 00 00 00       	mov    $0xd,%eax
 4d8:	cd 40                	int    $0x40
 4da:	c3                   	ret    

000004db <uptime>:
SYSCALL(uptime)
 4db:	b8 0e 00 00 00       	mov    $0xe,%eax
 4e0:	cd 40                	int    $0x40
 4e2:	c3                   	ret    
 4e3:	90                   	nop

000004e4 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4e4:	55                   	push   %ebp
 4e5:	89 e5                	mov    %esp,%ebp
 4e7:	57                   	push   %edi
 4e8:	56                   	push   %esi
 4e9:	53                   	push   %ebx
 4ea:	83 ec 3c             	sub    $0x3c,%esp
 4ed:	89 c6                	mov    %eax,%esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 4ef:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4f1:	8b 5d 08             	mov    0x8(%ebp),%ebx
 4f4:	85 db                	test   %ebx,%ebx
 4f6:	74 04                	je     4fc <printint+0x18>
 4f8:	85 d2                	test   %edx,%edx
 4fa:	78 5f                	js     55b <printint+0x77>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4fc:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 503:	31 ff                	xor    %edi,%edi
 505:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 508:	89 75 c4             	mov    %esi,-0x3c(%ebp)
 50b:	89 ce                	mov    %ecx,%esi
 50d:	eb 03                	jmp    512 <printint+0x2e>
 50f:	90                   	nop
  do{
    buf[i++] = digits[x % base];
 510:	89 cf                	mov    %ecx,%edi
 512:	8d 4f 01             	lea    0x1(%edi),%ecx
 515:	31 d2                	xor    %edx,%edx
 517:	f7 f6                	div    %esi
 519:	8a 92 a8 08 00 00    	mov    0x8a8(%edx),%dl
 51f:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 522:	85 c0                	test   %eax,%eax
 524:	75 ea                	jne    510 <printint+0x2c>
 526:	8b 75 c4             	mov    -0x3c(%ebp),%esi
  if(neg)
 529:	8b 55 c0             	mov    -0x40(%ebp),%edx
 52c:	85 d2                	test   %edx,%edx
 52e:	74 08                	je     538 <printint+0x54>
    buf[i++] = '-';
 530:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 535:	8d 4f 02             	lea    0x2(%edi),%ecx
 538:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 53c:	8a 07                	mov    (%edi),%al
 53e:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 541:	50                   	push   %eax
 542:	6a 01                	push   $0x1
 544:	53                   	push   %ebx
 545:	56                   	push   %esi
 546:	e8 18 ff ff ff       	call   463 <write>
 54b:	4f                   	dec    %edi
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 54c:	83 c4 10             	add    $0x10,%esp
 54f:	39 df                	cmp    %ebx,%edi
 551:	75 e9                	jne    53c <printint+0x58>
    putc(fd, buf[i]);
}
 553:	8d 65 f4             	lea    -0xc(%ebp),%esp
 556:	5b                   	pop    %ebx
 557:	5e                   	pop    %esi
 558:	5f                   	pop    %edi
 559:	5d                   	pop    %ebp
 55a:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 55b:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 55d:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 564:	eb 9d                	jmp    503 <printint+0x1f>
 566:	66 90                	xchg   %ax,%ax

00000568 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 568:	55                   	push   %ebp
 569:	89 e5                	mov    %esp,%ebp
 56b:	57                   	push   %edi
 56c:	56                   	push   %esi
 56d:	53                   	push   %ebx
 56e:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 571:	8b 75 0c             	mov    0xc(%ebp),%esi
 574:	8a 1e                	mov    (%esi),%bl
 576:	84 db                	test   %bl,%bl
 578:	0f 84 a6 00 00 00    	je     624 <printf+0xbc>
 57e:	46                   	inc    %esi
 57f:	8d 45 10             	lea    0x10(%ebp),%eax
 582:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 585:	31 ff                	xor    %edi,%edi
 587:	eb 29                	jmp    5b2 <printf+0x4a>
 589:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 58c:	83 f8 25             	cmp    $0x25,%eax
 58f:	0f 84 97 00 00 00    	je     62c <printf+0xc4>
 595:	88 5d e2             	mov    %bl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 598:	50                   	push   %eax
 599:	6a 01                	push   $0x1
 59b:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 59e:	50                   	push   %eax
 59f:	ff 75 08             	pushl  0x8(%ebp)
 5a2:	e8 bc fe ff ff       	call   463 <write>
 5a7:	83 c4 10             	add    $0x10,%esp
 5aa:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5ab:	8a 5e ff             	mov    -0x1(%esi),%bl
 5ae:	84 db                	test   %bl,%bl
 5b0:	74 72                	je     624 <printf+0xbc>
    c = fmt[i] & 0xff;
 5b2:	0f be cb             	movsbl %bl,%ecx
 5b5:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 5b8:	85 ff                	test   %edi,%edi
 5ba:	74 d0                	je     58c <printf+0x24>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5bc:	83 ff 25             	cmp    $0x25,%edi
 5bf:	75 e9                	jne    5aa <printf+0x42>
      if(c == 'd'){
 5c1:	83 f8 64             	cmp    $0x64,%eax
 5c4:	0f 84 f6 00 00 00    	je     6c0 <printf+0x158>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 5ca:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 5d0:	83 f9 70             	cmp    $0x70,%ecx
 5d3:	74 63                	je     638 <printf+0xd0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5d5:	83 f8 73             	cmp    $0x73,%eax
 5d8:	0f 84 86 00 00 00    	je     664 <printf+0xfc>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5de:	83 f8 63             	cmp    $0x63,%eax
 5e1:	0f 84 be 00 00 00    	je     6a5 <printf+0x13d>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5e7:	83 f8 25             	cmp    $0x25,%eax
 5ea:	0f 84 e0 00 00 00    	je     6d0 <printf+0x168>
 5f0:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5f4:	50                   	push   %eax
 5f5:	6a 01                	push   $0x1
 5f7:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5fa:	50                   	push   %eax
 5fb:	ff 75 08             	pushl  0x8(%ebp)
 5fe:	e8 60 fe ff ff       	call   463 <write>
 603:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 606:	83 c4 0c             	add    $0xc,%esp
 609:	6a 01                	push   $0x1
 60b:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 60e:	50                   	push   %eax
 60f:	ff 75 08             	pushl  0x8(%ebp)
 612:	e8 4c fe ff ff       	call   463 <write>
 617:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 61a:	31 ff                	xor    %edi,%edi
 61c:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 61d:	8a 5e ff             	mov    -0x1(%esi),%bl
 620:	84 db                	test   %bl,%bl
 622:	75 8e                	jne    5b2 <printf+0x4a>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 624:	8d 65 f4             	lea    -0xc(%ebp),%esp
 627:	5b                   	pop    %ebx
 628:	5e                   	pop    %esi
 629:	5f                   	pop    %edi
 62a:	5d                   	pop    %ebp
 62b:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 62c:	bf 25 00 00 00       	mov    $0x25,%edi
 631:	e9 74 ff ff ff       	jmp    5aa <printf+0x42>
 636:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 638:	83 ec 0c             	sub    $0xc,%esp
 63b:	6a 00                	push   $0x0
 63d:	b9 10 00 00 00       	mov    $0x10,%ecx
 642:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 645:	8b 17                	mov    (%edi),%edx
 647:	8b 45 08             	mov    0x8(%ebp),%eax
 64a:	e8 95 fe ff ff       	call   4e4 <printint>
        ap++;
 64f:	89 f8                	mov    %edi,%eax
 651:	83 c0 04             	add    $0x4,%eax
 654:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 657:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 65a:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 65c:	e9 49 ff ff ff       	jmp    5aa <printf+0x42>
 661:	8d 76 00             	lea    0x0(%esi),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 664:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 667:	8b 38                	mov    (%eax),%edi
        ap++;
 669:	83 c0 04             	add    $0x4,%eax
 66c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 66f:	85 ff                	test   %edi,%edi
 671:	74 6b                	je     6de <printf+0x176>
          s = "(null)";
        while(*s != 0){
 673:	8a 07                	mov    (%edi),%al
 675:	84 c0                	test   %al,%al
 677:	74 6c                	je     6e5 <printf+0x17d>
 679:	8d 5d e3             	lea    -0x1d(%ebp),%ebx
 67c:	89 75 d0             	mov    %esi,-0x30(%ebp)
 67f:	89 fe                	mov    %edi,%esi
 681:	8b 7d 08             	mov    0x8(%ebp),%edi
 684:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 687:	50                   	push   %eax
 688:	6a 01                	push   $0x1
 68a:	53                   	push   %ebx
 68b:	57                   	push   %edi
 68c:	e8 d2 fd ff ff       	call   463 <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 691:	46                   	inc    %esi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 692:	8a 06                	mov    (%esi),%al
 694:	83 c4 10             	add    $0x10,%esp
 697:	84 c0                	test   %al,%al
 699:	75 e9                	jne    684 <printf+0x11c>
 69b:	8b 75 d0             	mov    -0x30(%ebp),%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 69e:	31 ff                	xor    %edi,%edi
 6a0:	e9 05 ff ff ff       	jmp    5aa <printf+0x42>
 6a5:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 6a8:	8b 07                	mov    (%edi),%eax
 6aa:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6ad:	51                   	push   %ecx
 6ae:	6a 01                	push   $0x1
 6b0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 6b3:	50                   	push   %eax
 6b4:	ff 75 08             	pushl  0x8(%ebp)
 6b7:	e8 a7 fd ff ff       	call   463 <write>
 6bc:	eb 91                	jmp    64f <printf+0xe7>
 6be:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 6c0:	83 ec 0c             	sub    $0xc,%esp
 6c3:	6a 01                	push   $0x1
 6c5:	b9 0a 00 00 00       	mov    $0xa,%ecx
 6ca:	e9 73 ff ff ff       	jmp    642 <printf+0xda>
 6cf:	90                   	nop
 6d0:	88 5d e5             	mov    %bl,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6d3:	52                   	push   %edx
 6d4:	6a 01                	push   $0x1
 6d6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 6d9:	e9 30 ff ff ff       	jmp    60e <printf+0xa6>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
 6de:	bf 9e 08 00 00       	mov    $0x89e,%edi
 6e3:	eb 8e                	jmp    673 <printf+0x10b>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6e5:	31 ff                	xor    %edi,%edi
 6e7:	e9 be fe ff ff       	jmp    5aa <printf+0x42>

000006ec <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6ec:	55                   	push   %ebp
 6ed:	89 e5                	mov    %esp,%ebp
 6ef:	57                   	push   %edi
 6f0:	56                   	push   %esi
 6f1:	53                   	push   %ebx
 6f2:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6f5:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f8:	a1 20 0c 00 00       	mov    0xc20,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6fd:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6ff:	39 c8                	cmp    %ecx,%eax
 701:	73 11                	jae    714 <free+0x28>
 703:	90                   	nop
 704:	39 d1                	cmp    %edx,%ecx
 706:	72 14                	jb     71c <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 708:	39 d0                	cmp    %edx,%eax
 70a:	73 10                	jae    71c <free+0x30>
static Header base;
static Header *freep;

void
free(void *ap)
{
 70c:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 70e:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 710:	39 c8                	cmp    %ecx,%eax
 712:	72 f0                	jb     704 <free+0x18>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 714:	39 d0                	cmp    %edx,%eax
 716:	72 f4                	jb     70c <free+0x20>
 718:	39 d1                	cmp    %edx,%ecx
 71a:	73 f0                	jae    70c <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 71c:	8b 73 fc             	mov    -0x4(%ebx),%esi
 71f:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 722:	39 d7                	cmp    %edx,%edi
 724:	74 19                	je     73f <free+0x53>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 726:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 729:	8b 50 04             	mov    0x4(%eax),%edx
 72c:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 72f:	39 f1                	cmp    %esi,%ecx
 731:	74 23                	je     756 <free+0x6a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 733:	89 08                	mov    %ecx,(%eax)
  freep = p;
 735:	a3 20 0c 00 00       	mov    %eax,0xc20
}
 73a:	5b                   	pop    %ebx
 73b:	5e                   	pop    %esi
 73c:	5f                   	pop    %edi
 73d:	5d                   	pop    %ebp
 73e:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 73f:	03 72 04             	add    0x4(%edx),%esi
 742:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 745:	8b 10                	mov    (%eax),%edx
 747:	8b 12                	mov    (%edx),%edx
 749:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 74c:	8b 50 04             	mov    0x4(%eax),%edx
 74f:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 752:	39 f1                	cmp    %esi,%ecx
 754:	75 dd                	jne    733 <free+0x47>
    p->s.size += bp->s.size;
 756:	03 53 fc             	add    -0x4(%ebx),%edx
 759:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 75c:	8b 53 f8             	mov    -0x8(%ebx),%edx
 75f:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 761:	a3 20 0c 00 00       	mov    %eax,0xc20
}
 766:	5b                   	pop    %ebx
 767:	5e                   	pop    %esi
 768:	5f                   	pop    %edi
 769:	5d                   	pop    %ebp
 76a:	c3                   	ret    
 76b:	90                   	nop

0000076c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 76c:	55                   	push   %ebp
 76d:	89 e5                	mov    %esp,%ebp
 76f:	57                   	push   %edi
 770:	56                   	push   %esi
 771:	53                   	push   %ebx
 772:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 775:	8b 45 08             	mov    0x8(%ebp),%eax
 778:	8d 78 07             	lea    0x7(%eax),%edi
 77b:	c1 ef 03             	shr    $0x3,%edi
 77e:	47                   	inc    %edi
  if((prevp = freep) == 0){
 77f:	8b 15 20 0c 00 00    	mov    0xc20,%edx
 785:	85 d2                	test   %edx,%edx
 787:	0f 84 b1 00 00 00    	je     83e <malloc+0xd2>
 78d:	8b 02                	mov    (%edx),%eax
 78f:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 792:	39 cf                	cmp    %ecx,%edi
 794:	76 66                	jbe    7fc <malloc+0x90>
 796:	89 fb                	mov    %edi,%ebx
 798:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 79e:	0f 82 80 00 00 00    	jb     824 <malloc+0xb8>
 7a4:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 7aa:	76 70                	jbe    81c <malloc+0xb0>
 7ac:	8d 34 fd 00 00 00 00 	lea    0x0(,%edi,8),%esi
 7b3:	eb 0c                	jmp    7c1 <malloc+0x55>
 7b5:	8d 76 00             	lea    0x0(%esi),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7b8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7ba:	8b 48 04             	mov    0x4(%eax),%ecx
 7bd:	39 cf                	cmp    %ecx,%edi
 7bf:	76 3b                	jbe    7fc <malloc+0x90>
 7c1:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7c3:	39 05 20 0c 00 00    	cmp    %eax,0xc20
 7c9:	75 ed                	jne    7b8 <malloc+0x4c>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 7cb:	83 ec 0c             	sub    $0xc,%esp
 7ce:	56                   	push   %esi
 7cf:	e8 f7 fc ff ff       	call   4cb <sbrk>
  if(p == (char*)-1)
 7d4:	83 c4 10             	add    $0x10,%esp
 7d7:	83 f8 ff             	cmp    $0xffffffff,%eax
 7da:	74 1c                	je     7f8 <malloc+0x8c>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 7dc:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 7df:	83 ec 0c             	sub    $0xc,%esp
 7e2:	83 c0 08             	add    $0x8,%eax
 7e5:	50                   	push   %eax
 7e6:	e8 01 ff ff ff       	call   6ec <free>
  return freep;
 7eb:	8b 15 20 0c 00 00    	mov    0xc20,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 7f1:	83 c4 10             	add    $0x10,%esp
 7f4:	85 d2                	test   %edx,%edx
 7f6:	75 c0                	jne    7b8 <malloc+0x4c>
        return 0;
 7f8:	31 c0                	xor    %eax,%eax
 7fa:	eb 18                	jmp    814 <malloc+0xa8>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 7fc:	39 cf                	cmp    %ecx,%edi
 7fe:	74 38                	je     838 <malloc+0xcc>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 800:	29 f9                	sub    %edi,%ecx
 802:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 805:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 808:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 80b:	89 15 20 0c 00 00    	mov    %edx,0xc20
      return (void*)(p + 1);
 811:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 814:	8d 65 f4             	lea    -0xc(%ebp),%esp
 817:	5b                   	pop    %ebx
 818:	5e                   	pop    %esi
 819:	5f                   	pop    %edi
 81a:	5d                   	pop    %ebp
 81b:	c3                   	ret    
 81c:	be 00 80 00 00       	mov    $0x8000,%esi
 821:	eb 9e                	jmp    7c1 <malloc+0x55>
 823:	90                   	nop
 824:	bb 00 10 00 00       	mov    $0x1000,%ebx
 829:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 82f:	76 eb                	jbe    81c <malloc+0xb0>
 831:	e9 76 ff ff ff       	jmp    7ac <malloc+0x40>
 836:	66 90                	xchg   %ax,%ax
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 838:	8b 08                	mov    (%eax),%ecx
 83a:	89 0a                	mov    %ecx,(%edx)
 83c:	eb cd                	jmp    80b <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 83e:	c7 05 20 0c 00 00 24 	movl   $0xc24,0xc20
 845:	0c 00 00 
 848:	c7 05 24 0c 00 00 24 	movl   $0xc24,0xc24
 84f:	0c 00 00 
    base.s.size = 0;
 852:	c7 05 28 0c 00 00 00 	movl   $0x0,0xc28
 859:	00 00 00 
 85c:	b8 24 0c 00 00       	mov    $0xc24,%eax
 861:	e9 30 ff ff ff       	jmp    796 <malloc+0x2a>
