
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  close(fd);
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
  11:	83 ec 08             	sub    $0x8,%esp
  14:	8b 31                	mov    (%ecx),%esi
  16:	8b 79 04             	mov    0x4(%ecx),%edi
  int i;

  if(argc < 2){
  19:	83 fe 01             	cmp    $0x1,%esi
  1c:	7e 1e                	jle    3c <main+0x3c>
  1e:	bb 01 00 00 00       	mov    $0x1,%ebx
  23:	90                   	nop
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
  24:	83 ec 0c             	sub    $0xc,%esp
  27:	ff 34 9f             	pushl  (%edi,%ebx,4)
  2a:	e8 b9 00 00 00       	call   e8 <ls>

  if(argc < 2){
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
  2f:	43                   	inc    %ebx
  30:	83 c4 10             	add    $0x10,%esp
  33:	39 de                	cmp    %ebx,%esi
  35:	75 ed                	jne    24 <main+0x24>
    ls(argv[i]);
  exit();
  37:	e8 7b 04 00 00       	call   4b7 <exit>
main(int argc, char *argv[])
{
  int i;

  if(argc < 2){
    ls(".");
  3c:	83 ec 0c             	sub    $0xc,%esp
  3f:	68 24 09 00 00       	push   $0x924
  44:	e8 9f 00 00 00       	call   e8 <ls>
    exit();
  49:	e8 69 04 00 00       	call   4b7 <exit>
  4e:	66 90                	xchg   %ax,%ax

00000050 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
  50:	55                   	push   %ebp
  51:	89 e5                	mov    %esp,%ebp
  53:	56                   	push   %esi
  54:	53                   	push   %ebx
  55:	8b 5d 08             	mov    0x8(%ebp),%ebx
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  58:	83 ec 0c             	sub    $0xc,%esp
  5b:	53                   	push   %ebx
  5c:	e8 03 03 00 00       	call   364 <strlen>
  61:	83 c4 10             	add    $0x10,%esp
  64:	01 d8                	add    %ebx,%eax
  66:	73 09                	jae    71 <fmtname+0x21>
  68:	eb 0c                	jmp    76 <fmtname+0x26>
  6a:	66 90                	xchg   %ax,%ax
  6c:	48                   	dec    %eax
  6d:	39 c3                	cmp    %eax,%ebx
  6f:	77 05                	ja     76 <fmtname+0x26>
  71:	80 38 2f             	cmpb   $0x2f,(%eax)
  74:	75 f6                	jne    6c <fmtname+0x1c>
    ;
  p++;
  76:	8d 58 01             	lea    0x1(%eax),%ebx

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  79:	83 ec 0c             	sub    $0xc,%esp
  7c:	53                   	push   %ebx
  7d:	e8 e2 02 00 00       	call   364 <strlen>
  82:	83 c4 10             	add    $0x10,%esp
  85:	83 f8 0d             	cmp    $0xd,%eax
  88:	76 0a                	jbe    94 <fmtname+0x44>
    return p;
  8a:	89 d8                	mov    %ebx,%eax
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}
  8c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8f:	5b                   	pop    %ebx
  90:	5e                   	pop    %esi
  91:	5d                   	pop    %ebp
  92:	c3                   	ret    
  93:	90                   	nop
  p++;

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
    return p;
  memmove(buf, p, strlen(p));
  94:	83 ec 0c             	sub    $0xc,%esp
  97:	53                   	push   %ebx
  98:	e8 c7 02 00 00       	call   364 <strlen>
  9d:	83 c4 0c             	add    $0xc,%esp
  a0:	50                   	push   %eax
  a1:	53                   	push   %ebx
  a2:	68 38 0c 00 00       	push   $0xc38
  a7:	e8 e0 03 00 00       	call   48c <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  ac:	89 1c 24             	mov    %ebx,(%esp)
  af:	e8 b0 02 00 00       	call   364 <strlen>
  b4:	89 c6                	mov    %eax,%esi
  b6:	89 1c 24             	mov    %ebx,(%esp)
  b9:	e8 a6 02 00 00       	call   364 <strlen>
  be:	83 c4 0c             	add    $0xc,%esp
  c1:	ba 0e 00 00 00       	mov    $0xe,%edx
  c6:	29 f2                	sub    %esi,%edx
  c8:	52                   	push   %edx
  c9:	6a 20                	push   $0x20
  cb:	05 38 0c 00 00       	add    $0xc38,%eax
  d0:	50                   	push   %eax
  d1:	e8 ae 02 00 00       	call   384 <memset>
  return buf;
  d6:	83 c4 10             	add    $0x10,%esp
  d9:	b8 38 0c 00 00       	mov    $0xc38,%eax
}
  de:	8d 65 f8             	lea    -0x8(%ebp),%esp
  e1:	5b                   	pop    %ebx
  e2:	5e                   	pop    %esi
  e3:	5d                   	pop    %ebp
  e4:	c3                   	ret    
  e5:	8d 76 00             	lea    0x0(%esi),%esi

000000e8 <ls>:

void
ls(char *path)
{
  e8:	55                   	push   %ebp
  e9:	89 e5                	mov    %esp,%ebp
  eb:	57                   	push   %edi
  ec:	56                   	push   %esi
  ed:	53                   	push   %ebx
  ee:	81 ec 64 02 00 00    	sub    $0x264,%esp
  f4:	8b 7d 08             	mov    0x8(%ebp),%edi
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
  f7:	6a 00                	push   $0x0
  f9:	57                   	push   %edi
  fa:	e8 f8 03 00 00       	call   4f7 <open>
  ff:	83 c4 10             	add    $0x10,%esp
 102:	85 c0                	test   %eax,%eax
 104:	0f 88 92 01 00 00    	js     29c <ls+0x1b4>
 10a:	89 c3                	mov    %eax,%ebx
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
 10c:	83 ec 08             	sub    $0x8,%esp
 10f:	8d b5 d4 fd ff ff    	lea    -0x22c(%ebp),%esi
 115:	56                   	push   %esi
 116:	50                   	push   %eax
 117:	e8 f3 03 00 00       	call   50f <fstat>
 11c:	83 c4 10             	add    $0x10,%esp
 11f:	85 c0                	test   %eax,%eax
 121:	0f 88 a9 01 00 00    	js     2d0 <ls+0x1e8>
    printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
 127:	8b 85 d4 fd ff ff    	mov    -0x22c(%ebp),%eax
 12d:	66 83 f8 01          	cmp    $0x1,%ax
 131:	74 51                	je     184 <ls+0x9c>
 133:	66 83 f8 02          	cmp    $0x2,%ax
 137:	75 37                	jne    170 <ls+0x88>
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 139:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 13f:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 145:	8b b5 dc fd ff ff    	mov    -0x224(%ebp),%esi
 14b:	83 ec 0c             	sub    $0xc,%esp
 14e:	57                   	push   %edi
 14f:	e8 fc fe ff ff       	call   50 <fmtname>
 154:	59                   	pop    %ecx
 155:	5f                   	pop    %edi
 156:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 15c:	52                   	push   %edx
 15d:	56                   	push   %esi
 15e:	6a 02                	push   $0x2
 160:	50                   	push   %eax
 161:	68 04 09 00 00       	push   $0x904
 166:	6a 01                	push   $0x1
 168:	e8 6f 04 00 00       	call   5dc <printf>
    break;
 16d:	83 c4 20             	add    $0x20,%esp
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
 170:	83 ec 0c             	sub    $0xc,%esp
 173:	53                   	push   %ebx
 174:	e8 66 03 00 00       	call   4df <close>
 179:	83 c4 10             	add    $0x10,%esp
}
 17c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 17f:	5b                   	pop    %ebx
 180:	5e                   	pop    %esi
 181:	5f                   	pop    %edi
 182:	5d                   	pop    %ebp
 183:	c3                   	ret    
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
    break;

  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 184:	83 ec 0c             	sub    $0xc,%esp
 187:	57                   	push   %edi
 188:	e8 d7 01 00 00       	call   364 <strlen>
 18d:	83 c0 10             	add    $0x10,%eax
 190:	83 c4 10             	add    $0x10,%esp
 193:	3d 00 02 00 00       	cmp    $0x200,%eax
 198:	0f 87 1a 01 00 00    	ja     2b8 <ls+0x1d0>
      printf(1, "ls: path too long\n");
      break;
    }
    strcpy(buf, path);
 19e:	83 ec 08             	sub    $0x8,%esp
 1a1:	57                   	push   %edi
 1a2:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 1a8:	50                   	push   %eax
 1a9:	e8 5e 01 00 00       	call   30c <strcpy>
    p = buf+strlen(buf);
 1ae:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 1b4:	89 04 24             	mov    %eax,(%esp)
 1b7:	e8 a8 01 00 00       	call   364 <strlen>
 1bc:	8d 95 e8 fd ff ff    	lea    -0x218(%ebp),%edx
 1c2:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
 1c5:	89 8d a8 fd ff ff    	mov    %ecx,-0x258(%ebp)
    *p++ = '/';
 1cb:	8d 84 05 e9 fd ff ff 	lea    -0x217(%ebp,%eax,1),%eax
 1d2:	89 85 a4 fd ff ff    	mov    %eax,-0x25c(%ebp)
 1d8:	c6 01 2f             	movb   $0x2f,(%ecx)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1db:	83 c4 10             	add    $0x10,%esp
 1de:	8d bd c4 fd ff ff    	lea    -0x23c(%ebp),%edi
 1e4:	50                   	push   %eax
 1e5:	6a 10                	push   $0x10
 1e7:	57                   	push   %edi
 1e8:	53                   	push   %ebx
 1e9:	e8 e1 02 00 00       	call   4cf <read>
 1ee:	83 c4 10             	add    $0x10,%esp
 1f1:	83 f8 10             	cmp    $0x10,%eax
 1f4:	0f 85 76 ff ff ff    	jne    170 <ls+0x88>
      if(de.inum == 0)
 1fa:	66 83 bd c4 fd ff ff 	cmpw   $0x0,-0x23c(%ebp)
 201:	00 
 202:	74 e0                	je     1e4 <ls+0xfc>
        continue;
      memmove(p, de.name, DIRSIZ);
 204:	50                   	push   %eax
 205:	6a 0e                	push   $0xe
 207:	8d 85 c6 fd ff ff    	lea    -0x23a(%ebp),%eax
 20d:	50                   	push   %eax
 20e:	ff b5 a4 fd ff ff    	pushl  -0x25c(%ebp)
 214:	e8 73 02 00 00       	call   48c <memmove>
      p[DIRSIZ] = 0;
 219:	8b 85 a8 fd ff ff    	mov    -0x258(%ebp),%eax
 21f:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
 223:	58                   	pop    %eax
 224:	5a                   	pop    %edx
 225:	56                   	push   %esi
 226:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 22c:	50                   	push   %eax
 22d:	e8 e2 01 00 00       	call   414 <stat>
 232:	83 c4 10             	add    $0x10,%esp
 235:	85 c0                	test   %eax,%eax
 237:	0f 88 b3 00 00 00    	js     2f0 <ls+0x208>
        printf(1, "ls: cannot stat %s\n", buf);
        continue;
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 23d:	8b 8d e4 fd ff ff    	mov    -0x21c(%ebp),%ecx
 243:	89 8d ac fd ff ff    	mov    %ecx,-0x254(%ebp)
 249:	8b 95 dc fd ff ff    	mov    -0x224(%ebp),%edx
 24f:	89 95 b0 fd ff ff    	mov    %edx,-0x250(%ebp)
 255:	0f bf 85 d4 fd ff ff 	movswl -0x22c(%ebp),%eax
 25c:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
 262:	83 ec 0c             	sub    $0xc,%esp
 265:	8d 8d e8 fd ff ff    	lea    -0x218(%ebp),%ecx
 26b:	51                   	push   %ecx
 26c:	e8 df fd ff ff       	call   50 <fmtname>
 271:	5a                   	pop    %edx
 272:	59                   	pop    %ecx
 273:	8b 8d ac fd ff ff    	mov    -0x254(%ebp),%ecx
 279:	51                   	push   %ecx
 27a:	8b 95 b0 fd ff ff    	mov    -0x250(%ebp),%edx
 280:	52                   	push   %edx
 281:	ff b5 b4 fd ff ff    	pushl  -0x24c(%ebp)
 287:	50                   	push   %eax
 288:	68 04 09 00 00       	push   $0x904
 28d:	6a 01                	push   $0x1
 28f:	e8 48 03 00 00       	call   5dc <printf>
 294:	83 c4 20             	add    $0x20,%esp
 297:	e9 48 ff ff ff       	jmp    1e4 <ls+0xfc>
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
    printf(2, "ls: cannot open %s\n", path);
 29c:	50                   	push   %eax
 29d:	57                   	push   %edi
 29e:	68 dc 08 00 00       	push   $0x8dc
 2a3:	6a 02                	push   $0x2
 2a5:	e8 32 03 00 00       	call   5dc <printf>
    return;
 2aa:	83 c4 10             	add    $0x10,%esp
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
}
 2ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2b0:	5b                   	pop    %ebx
 2b1:	5e                   	pop    %esi
 2b2:	5f                   	pop    %edi
 2b3:	5d                   	pop    %ebp
 2b4:	c3                   	ret    
 2b5:	8d 76 00             	lea    0x0(%esi),%esi
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
    break;

  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
      printf(1, "ls: path too long\n");
 2b8:	83 ec 08             	sub    $0x8,%esp
 2bb:	68 11 09 00 00       	push   $0x911
 2c0:	6a 01                	push   $0x1
 2c2:	e8 15 03 00 00       	call   5dc <printf>
      break;
 2c7:	83 c4 10             	add    $0x10,%esp
 2ca:	e9 a1 fe ff ff       	jmp    170 <ls+0x88>
 2cf:	90                   	nop
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
    printf(2, "ls: cannot stat %s\n", path);
 2d0:	50                   	push   %eax
 2d1:	57                   	push   %edi
 2d2:	68 f0 08 00 00       	push   $0x8f0
 2d7:	6a 02                	push   $0x2
 2d9:	e8 fe 02 00 00       	call   5dc <printf>
    close(fd);
 2de:	89 1c 24             	mov    %ebx,(%esp)
 2e1:	e8 f9 01 00 00       	call   4df <close>
    return;
 2e6:	83 c4 10             	add    $0x10,%esp
 2e9:	e9 8e fe ff ff       	jmp    17c <ls+0x94>
 2ee:	66 90                	xchg   %ax,%ax
      if(de.inum == 0)
        continue;
      memmove(p, de.name, DIRSIZ);
      p[DIRSIZ] = 0;
      if(stat(buf, &st) < 0){
        printf(1, "ls: cannot stat %s\n", buf);
 2f0:	50                   	push   %eax
 2f1:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 2f7:	50                   	push   %eax
 2f8:	68 f0 08 00 00       	push   $0x8f0
 2fd:	6a 01                	push   $0x1
 2ff:	e8 d8 02 00 00       	call   5dc <printf>
        continue;
 304:	83 c4 10             	add    $0x10,%esp
 307:	e9 d8 fe ff ff       	jmp    1e4 <ls+0xfc>

0000030c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 30c:	55                   	push   %ebp
 30d:	89 e5                	mov    %esp,%ebp
 30f:	53                   	push   %ebx
 310:	8b 45 08             	mov    0x8(%ebp),%eax
 313:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 316:	89 c2                	mov    %eax,%edx
 318:	42                   	inc    %edx
 319:	41                   	inc    %ecx
 31a:	8a 59 ff             	mov    -0x1(%ecx),%bl
 31d:	88 5a ff             	mov    %bl,-0x1(%edx)
 320:	84 db                	test   %bl,%bl
 322:	75 f4                	jne    318 <strcpy+0xc>
    ;
  return os;
}
 324:	5b                   	pop    %ebx
 325:	5d                   	pop    %ebp
 326:	c3                   	ret    
 327:	90                   	nop

00000328 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 328:	55                   	push   %ebp
 329:	89 e5                	mov    %esp,%ebp
 32b:	56                   	push   %esi
 32c:	53                   	push   %ebx
 32d:	8b 55 08             	mov    0x8(%ebp),%edx
 330:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 333:	0f b6 02             	movzbl (%edx),%eax
 336:	0f b6 0b             	movzbl (%ebx),%ecx
 339:	84 c0                	test   %al,%al
 33b:	75 14                	jne    351 <strcmp+0x29>
 33d:	eb 1d                	jmp    35c <strcmp+0x34>
 33f:	90                   	nop
    p++, q++;
 340:	42                   	inc    %edx
 341:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 344:	0f b6 02             	movzbl (%edx),%eax
 347:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 34b:	84 c0                	test   %al,%al
 34d:	74 0d                	je     35c <strcmp+0x34>
 34f:	89 f3                	mov    %esi,%ebx
 351:	38 c8                	cmp    %cl,%al
 353:	74 eb                	je     340 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 355:	29 c8                	sub    %ecx,%eax
}
 357:	5b                   	pop    %ebx
 358:	5e                   	pop    %esi
 359:	5d                   	pop    %ebp
 35a:	c3                   	ret    
 35b:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 35c:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 35e:	29 c8                	sub    %ecx,%eax
}
 360:	5b                   	pop    %ebx
 361:	5e                   	pop    %esi
 362:	5d                   	pop    %ebp
 363:	c3                   	ret    

00000364 <strlen>:

uint
strlen(const char *s)
{
 364:	55                   	push   %ebp
 365:	89 e5                	mov    %esp,%ebp
 367:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 36a:	80 39 00             	cmpb   $0x0,(%ecx)
 36d:	74 10                	je     37f <strlen+0x1b>
 36f:	31 d2                	xor    %edx,%edx
 371:	8d 76 00             	lea    0x0(%esi),%esi
 374:	42                   	inc    %edx
 375:	89 d0                	mov    %edx,%eax
 377:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 37b:	75 f7                	jne    374 <strlen+0x10>
    ;
  return n;
}
 37d:	5d                   	pop    %ebp
 37e:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 37f:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 381:	5d                   	pop    %ebp
 382:	c3                   	ret    
 383:	90                   	nop

00000384 <memset>:

void*
memset(void *dst, int c, uint n)
{
 384:	55                   	push   %ebp
 385:	89 e5                	mov    %esp,%ebp
 387:	57                   	push   %edi
 388:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 38b:	89 d7                	mov    %edx,%edi
 38d:	8b 4d 10             	mov    0x10(%ebp),%ecx
 390:	8b 45 0c             	mov    0xc(%ebp),%eax
 393:	fc                   	cld    
 394:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 396:	89 d0                	mov    %edx,%eax
 398:	5f                   	pop    %edi
 399:	5d                   	pop    %ebp
 39a:	c3                   	ret    
 39b:	90                   	nop

0000039c <strchr>:

char*
strchr(const char *s, char c)
{
 39c:	55                   	push   %ebp
 39d:	89 e5                	mov    %esp,%ebp
 39f:	53                   	push   %ebx
 3a0:	8b 45 08             	mov    0x8(%ebp),%eax
 3a3:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 3a6:	8a 10                	mov    (%eax),%dl
 3a8:	84 d2                	test   %dl,%dl
 3aa:	74 13                	je     3bf <strchr+0x23>
 3ac:	88 d9                	mov    %bl,%cl
    if(*s == c)
 3ae:	38 d3                	cmp    %dl,%bl
 3b0:	75 06                	jne    3b8 <strchr+0x1c>
 3b2:	eb 0d                	jmp    3c1 <strchr+0x25>
 3b4:	38 ca                	cmp    %cl,%dl
 3b6:	74 09                	je     3c1 <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 3b8:	40                   	inc    %eax
 3b9:	8a 10                	mov    (%eax),%dl
 3bb:	84 d2                	test   %dl,%dl
 3bd:	75 f5                	jne    3b4 <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
 3bf:	31 c0                	xor    %eax,%eax
}
 3c1:	5b                   	pop    %ebx
 3c2:	5d                   	pop    %ebp
 3c3:	c3                   	ret    

000003c4 <gets>:

char*
gets(char *buf, int max)
{
 3c4:	55                   	push   %ebp
 3c5:	89 e5                	mov    %esp,%ebp
 3c7:	57                   	push   %edi
 3c8:	56                   	push   %esi
 3c9:	53                   	push   %ebx
 3ca:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3cd:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 3cf:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3d2:	eb 26                	jmp    3fa <gets+0x36>
    cc = read(0, &c, 1);
 3d4:	50                   	push   %eax
 3d5:	6a 01                	push   $0x1
 3d7:	57                   	push   %edi
 3d8:	6a 00                	push   $0x0
 3da:	e8 f0 00 00 00       	call   4cf <read>
    if(cc < 1)
 3df:	83 c4 10             	add    $0x10,%esp
 3e2:	85 c0                	test   %eax,%eax
 3e4:	7e 1c                	jle    402 <gets+0x3e>
      break;
    buf[i++] = c;
 3e6:	8a 45 e7             	mov    -0x19(%ebp),%al
 3e9:	8b 55 08             	mov    0x8(%ebp),%edx
 3ec:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3f0:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3f2:	3c 0a                	cmp    $0xa,%al
 3f4:	74 0c                	je     402 <gets+0x3e>
 3f6:	3c 0d                	cmp    $0xd,%al
 3f8:	74 08                	je     402 <gets+0x3e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3fa:	8d 5e 01             	lea    0x1(%esi),%ebx
 3fd:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 400:	7c d2                	jl     3d4 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 402:	8b 45 08             	mov    0x8(%ebp),%eax
 405:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 409:	8d 65 f4             	lea    -0xc(%ebp),%esp
 40c:	5b                   	pop    %ebx
 40d:	5e                   	pop    %esi
 40e:	5f                   	pop    %edi
 40f:	5d                   	pop    %ebp
 410:	c3                   	ret    
 411:	8d 76 00             	lea    0x0(%esi),%esi

00000414 <stat>:

int
stat(const char *n, struct stat *st)
{
 414:	55                   	push   %ebp
 415:	89 e5                	mov    %esp,%ebp
 417:	56                   	push   %esi
 418:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 419:	83 ec 08             	sub    $0x8,%esp
 41c:	6a 00                	push   $0x0
 41e:	ff 75 08             	pushl  0x8(%ebp)
 421:	e8 d1 00 00 00       	call   4f7 <open>
  if(fd < 0)
 426:	83 c4 10             	add    $0x10,%esp
 429:	85 c0                	test   %eax,%eax
 42b:	78 27                	js     454 <stat+0x40>
 42d:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 42f:	83 ec 08             	sub    $0x8,%esp
 432:	ff 75 0c             	pushl  0xc(%ebp)
 435:	50                   	push   %eax
 436:	e8 d4 00 00 00       	call   50f <fstat>
 43b:	89 c6                	mov    %eax,%esi
  close(fd);
 43d:	89 1c 24             	mov    %ebx,(%esp)
 440:	e8 9a 00 00 00       	call   4df <close>
  return r;
 445:	83 c4 10             	add    $0x10,%esp
 448:	89 f0                	mov    %esi,%eax
}
 44a:	8d 65 f8             	lea    -0x8(%ebp),%esp
 44d:	5b                   	pop    %ebx
 44e:	5e                   	pop    %esi
 44f:	5d                   	pop    %ebp
 450:	c3                   	ret    
 451:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 454:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 459:	eb ef                	jmp    44a <stat+0x36>
 45b:	90                   	nop

0000045c <atoi>:
  return r;
}

int
atoi(const char *s)
{
 45c:	55                   	push   %ebp
 45d:	89 e5                	mov    %esp,%ebp
 45f:	53                   	push   %ebx
 460:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 463:	0f be 11             	movsbl (%ecx),%edx
 466:	8d 42 d0             	lea    -0x30(%edx),%eax
 469:	3c 09                	cmp    $0x9,%al
 46b:	b8 00 00 00 00       	mov    $0x0,%eax
 470:	77 15                	ja     487 <atoi+0x2b>
 472:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 474:	41                   	inc    %ecx
 475:	8d 04 80             	lea    (%eax,%eax,4),%eax
 478:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 47c:	0f be 11             	movsbl (%ecx),%edx
 47f:	8d 5a d0             	lea    -0x30(%edx),%ebx
 482:	80 fb 09             	cmp    $0x9,%bl
 485:	76 ed                	jbe    474 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 487:	5b                   	pop    %ebx
 488:	5d                   	pop    %ebp
 489:	c3                   	ret    
 48a:	66 90                	xchg   %ax,%ax

0000048c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 48c:	55                   	push   %ebp
 48d:	89 e5                	mov    %esp,%ebp
 48f:	56                   	push   %esi
 490:	53                   	push   %ebx
 491:	8b 45 08             	mov    0x8(%ebp),%eax
 494:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 497:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 49a:	85 f6                	test   %esi,%esi
 49c:	7e 0d                	jle    4ab <memmove+0x1f>
 49e:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 4a0:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 4a3:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 4a6:	42                   	inc    %edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4a7:	39 f2                	cmp    %esi,%edx
 4a9:	75 f5                	jne    4a0 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 4ab:	5b                   	pop    %ebx
 4ac:	5e                   	pop    %esi
 4ad:	5d                   	pop    %ebp
 4ae:	c3                   	ret    

000004af <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 4af:	b8 01 00 00 00       	mov    $0x1,%eax
 4b4:	cd 40                	int    $0x40
 4b6:	c3                   	ret    

000004b7 <exit>:
SYSCALL(exit)
 4b7:	b8 02 00 00 00       	mov    $0x2,%eax
 4bc:	cd 40                	int    $0x40
 4be:	c3                   	ret    

000004bf <wait>:
SYSCALL(wait)
 4bf:	b8 03 00 00 00       	mov    $0x3,%eax
 4c4:	cd 40                	int    $0x40
 4c6:	c3                   	ret    

000004c7 <pipe>:
SYSCALL(pipe)
 4c7:	b8 04 00 00 00       	mov    $0x4,%eax
 4cc:	cd 40                	int    $0x40
 4ce:	c3                   	ret    

000004cf <read>:
SYSCALL(read)
 4cf:	b8 05 00 00 00       	mov    $0x5,%eax
 4d4:	cd 40                	int    $0x40
 4d6:	c3                   	ret    

000004d7 <write>:
SYSCALL(write)
 4d7:	b8 10 00 00 00       	mov    $0x10,%eax
 4dc:	cd 40                	int    $0x40
 4de:	c3                   	ret    

000004df <close>:
SYSCALL(close)
 4df:	b8 15 00 00 00       	mov    $0x15,%eax
 4e4:	cd 40                	int    $0x40
 4e6:	c3                   	ret    

000004e7 <kill>:
SYSCALL(kill)
 4e7:	b8 06 00 00 00       	mov    $0x6,%eax
 4ec:	cd 40                	int    $0x40
 4ee:	c3                   	ret    

000004ef <exec>:
SYSCALL(exec)
 4ef:	b8 07 00 00 00       	mov    $0x7,%eax
 4f4:	cd 40                	int    $0x40
 4f6:	c3                   	ret    

000004f7 <open>:
SYSCALL(open)
 4f7:	b8 0f 00 00 00       	mov    $0xf,%eax
 4fc:	cd 40                	int    $0x40
 4fe:	c3                   	ret    

000004ff <mknod>:
SYSCALL(mknod)
 4ff:	b8 11 00 00 00       	mov    $0x11,%eax
 504:	cd 40                	int    $0x40
 506:	c3                   	ret    

00000507 <unlink>:
SYSCALL(unlink)
 507:	b8 12 00 00 00       	mov    $0x12,%eax
 50c:	cd 40                	int    $0x40
 50e:	c3                   	ret    

0000050f <fstat>:
SYSCALL(fstat)
 50f:	b8 08 00 00 00       	mov    $0x8,%eax
 514:	cd 40                	int    $0x40
 516:	c3                   	ret    

00000517 <link>:
SYSCALL(link)
 517:	b8 13 00 00 00       	mov    $0x13,%eax
 51c:	cd 40                	int    $0x40
 51e:	c3                   	ret    

0000051f <mkdir>:
SYSCALL(mkdir)
 51f:	b8 14 00 00 00       	mov    $0x14,%eax
 524:	cd 40                	int    $0x40
 526:	c3                   	ret    

00000527 <chdir>:
SYSCALL(chdir)
 527:	b8 09 00 00 00       	mov    $0x9,%eax
 52c:	cd 40                	int    $0x40
 52e:	c3                   	ret    

0000052f <dup>:
SYSCALL(dup)
 52f:	b8 0a 00 00 00       	mov    $0xa,%eax
 534:	cd 40                	int    $0x40
 536:	c3                   	ret    

00000537 <getpid>:
SYSCALL(getpid)
 537:	b8 0b 00 00 00       	mov    $0xb,%eax
 53c:	cd 40                	int    $0x40
 53e:	c3                   	ret    

0000053f <sbrk>:
SYSCALL(sbrk)
 53f:	b8 0c 00 00 00       	mov    $0xc,%eax
 544:	cd 40                	int    $0x40
 546:	c3                   	ret    

00000547 <sleep>:
SYSCALL(sleep)
 547:	b8 0d 00 00 00       	mov    $0xd,%eax
 54c:	cd 40                	int    $0x40
 54e:	c3                   	ret    

0000054f <uptime>:
SYSCALL(uptime)
 54f:	b8 0e 00 00 00       	mov    $0xe,%eax
 554:	cd 40                	int    $0x40
 556:	c3                   	ret    
 557:	90                   	nop

00000558 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 558:	55                   	push   %ebp
 559:	89 e5                	mov    %esp,%ebp
 55b:	57                   	push   %edi
 55c:	56                   	push   %esi
 55d:	53                   	push   %ebx
 55e:	83 ec 3c             	sub    $0x3c,%esp
 561:	89 c6                	mov    %eax,%esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 563:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 565:	8b 5d 08             	mov    0x8(%ebp),%ebx
 568:	85 db                	test   %ebx,%ebx
 56a:	74 04                	je     570 <printint+0x18>
 56c:	85 d2                	test   %edx,%edx
 56e:	78 5f                	js     5cf <printint+0x77>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 570:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 577:	31 ff                	xor    %edi,%edi
 579:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 57c:	89 75 c4             	mov    %esi,-0x3c(%ebp)
 57f:	89 ce                	mov    %ecx,%esi
 581:	eb 03                	jmp    586 <printint+0x2e>
 583:	90                   	nop
  do{
    buf[i++] = digits[x % base];
 584:	89 cf                	mov    %ecx,%edi
 586:	8d 4f 01             	lea    0x1(%edi),%ecx
 589:	31 d2                	xor    %edx,%edx
 58b:	f7 f6                	div    %esi
 58d:	8a 92 30 09 00 00    	mov    0x930(%edx),%dl
 593:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 596:	85 c0                	test   %eax,%eax
 598:	75 ea                	jne    584 <printint+0x2c>
 59a:	8b 75 c4             	mov    -0x3c(%ebp),%esi
  if(neg)
 59d:	8b 55 c0             	mov    -0x40(%ebp),%edx
 5a0:	85 d2                	test   %edx,%edx
 5a2:	74 08                	je     5ac <printint+0x54>
    buf[i++] = '-';
 5a4:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 5a9:	8d 4f 02             	lea    0x2(%edi),%ecx
 5ac:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 5b0:	8a 07                	mov    (%edi),%al
 5b2:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5b5:	50                   	push   %eax
 5b6:	6a 01                	push   $0x1
 5b8:	53                   	push   %ebx
 5b9:	56                   	push   %esi
 5ba:	e8 18 ff ff ff       	call   4d7 <write>
 5bf:	4f                   	dec    %edi
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 5c0:	83 c4 10             	add    $0x10,%esp
 5c3:	39 df                	cmp    %ebx,%edi
 5c5:	75 e9                	jne    5b0 <printint+0x58>
    putc(fd, buf[i]);
}
 5c7:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5ca:	5b                   	pop    %ebx
 5cb:	5e                   	pop    %esi
 5cc:	5f                   	pop    %edi
 5cd:	5d                   	pop    %ebp
 5ce:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 5cf:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 5d1:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 5d8:	eb 9d                	jmp    577 <printint+0x1f>
 5da:	66 90                	xchg   %ax,%ax

000005dc <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 5dc:	55                   	push   %ebp
 5dd:	89 e5                	mov    %esp,%ebp
 5df:	57                   	push   %edi
 5e0:	56                   	push   %esi
 5e1:	53                   	push   %ebx
 5e2:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5e5:	8b 75 0c             	mov    0xc(%ebp),%esi
 5e8:	8a 1e                	mov    (%esi),%bl
 5ea:	84 db                	test   %bl,%bl
 5ec:	0f 84 a6 00 00 00    	je     698 <printf+0xbc>
 5f2:	46                   	inc    %esi
 5f3:	8d 45 10             	lea    0x10(%ebp),%eax
 5f6:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 5f9:	31 ff                	xor    %edi,%edi
 5fb:	eb 29                	jmp    626 <printf+0x4a>
 5fd:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 600:	83 f8 25             	cmp    $0x25,%eax
 603:	0f 84 97 00 00 00    	je     6a0 <printf+0xc4>
 609:	88 5d e2             	mov    %bl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 60c:	50                   	push   %eax
 60d:	6a 01                	push   $0x1
 60f:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 612:	50                   	push   %eax
 613:	ff 75 08             	pushl  0x8(%ebp)
 616:	e8 bc fe ff ff       	call   4d7 <write>
 61b:	83 c4 10             	add    $0x10,%esp
 61e:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 61f:	8a 5e ff             	mov    -0x1(%esi),%bl
 622:	84 db                	test   %bl,%bl
 624:	74 72                	je     698 <printf+0xbc>
    c = fmt[i] & 0xff;
 626:	0f be cb             	movsbl %bl,%ecx
 629:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 62c:	85 ff                	test   %edi,%edi
 62e:	74 d0                	je     600 <printf+0x24>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 630:	83 ff 25             	cmp    $0x25,%edi
 633:	75 e9                	jne    61e <printf+0x42>
      if(c == 'd'){
 635:	83 f8 64             	cmp    $0x64,%eax
 638:	0f 84 f6 00 00 00    	je     734 <printf+0x158>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 63e:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 644:	83 f9 70             	cmp    $0x70,%ecx
 647:	74 63                	je     6ac <printf+0xd0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 649:	83 f8 73             	cmp    $0x73,%eax
 64c:	0f 84 86 00 00 00    	je     6d8 <printf+0xfc>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 652:	83 f8 63             	cmp    $0x63,%eax
 655:	0f 84 be 00 00 00    	je     719 <printf+0x13d>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 65b:	83 f8 25             	cmp    $0x25,%eax
 65e:	0f 84 e0 00 00 00    	je     744 <printf+0x168>
 664:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 668:	50                   	push   %eax
 669:	6a 01                	push   $0x1
 66b:	8d 45 e7             	lea    -0x19(%ebp),%eax
 66e:	50                   	push   %eax
 66f:	ff 75 08             	pushl  0x8(%ebp)
 672:	e8 60 fe ff ff       	call   4d7 <write>
 677:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 67a:	83 c4 0c             	add    $0xc,%esp
 67d:	6a 01                	push   $0x1
 67f:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 682:	50                   	push   %eax
 683:	ff 75 08             	pushl  0x8(%ebp)
 686:	e8 4c fe ff ff       	call   4d7 <write>
 68b:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 68e:	31 ff                	xor    %edi,%edi
 690:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 691:	8a 5e ff             	mov    -0x1(%esi),%bl
 694:	84 db                	test   %bl,%bl
 696:	75 8e                	jne    626 <printf+0x4a>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 698:	8d 65 f4             	lea    -0xc(%ebp),%esp
 69b:	5b                   	pop    %ebx
 69c:	5e                   	pop    %esi
 69d:	5f                   	pop    %edi
 69e:	5d                   	pop    %ebp
 69f:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 6a0:	bf 25 00 00 00       	mov    $0x25,%edi
 6a5:	e9 74 ff ff ff       	jmp    61e <printf+0x42>
 6aa:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 6ac:	83 ec 0c             	sub    $0xc,%esp
 6af:	6a 00                	push   $0x0
 6b1:	b9 10 00 00 00       	mov    $0x10,%ecx
 6b6:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 6b9:	8b 17                	mov    (%edi),%edx
 6bb:	8b 45 08             	mov    0x8(%ebp),%eax
 6be:	e8 95 fe ff ff       	call   558 <printint>
        ap++;
 6c3:	89 f8                	mov    %edi,%eax
 6c5:	83 c0 04             	add    $0x4,%eax
 6c8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 6cb:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6ce:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 6d0:	e9 49 ff ff ff       	jmp    61e <printf+0x42>
 6d5:	8d 76 00             	lea    0x0(%esi),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 6d8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 6db:	8b 38                	mov    (%eax),%edi
        ap++;
 6dd:	83 c0 04             	add    $0x4,%eax
 6e0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 6e3:	85 ff                	test   %edi,%edi
 6e5:	74 6b                	je     752 <printf+0x176>
          s = "(null)";
        while(*s != 0){
 6e7:	8a 07                	mov    (%edi),%al
 6e9:	84 c0                	test   %al,%al
 6eb:	74 6c                	je     759 <printf+0x17d>
 6ed:	8d 5d e3             	lea    -0x1d(%ebp),%ebx
 6f0:	89 75 d0             	mov    %esi,-0x30(%ebp)
 6f3:	89 fe                	mov    %edi,%esi
 6f5:	8b 7d 08             	mov    0x8(%ebp),%edi
 6f8:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6fb:	50                   	push   %eax
 6fc:	6a 01                	push   $0x1
 6fe:	53                   	push   %ebx
 6ff:	57                   	push   %edi
 700:	e8 d2 fd ff ff       	call   4d7 <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 705:	46                   	inc    %esi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 706:	8a 06                	mov    (%esi),%al
 708:	83 c4 10             	add    $0x10,%esp
 70b:	84 c0                	test   %al,%al
 70d:	75 e9                	jne    6f8 <printf+0x11c>
 70f:	8b 75 d0             	mov    -0x30(%ebp),%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 712:	31 ff                	xor    %edi,%edi
 714:	e9 05 ff ff ff       	jmp    61e <printf+0x42>
 719:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 71c:	8b 07                	mov    (%edi),%eax
 71e:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 721:	51                   	push   %ecx
 722:	6a 01                	push   $0x1
 724:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 727:	50                   	push   %eax
 728:	ff 75 08             	pushl  0x8(%ebp)
 72b:	e8 a7 fd ff ff       	call   4d7 <write>
 730:	eb 91                	jmp    6c3 <printf+0xe7>
 732:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 734:	83 ec 0c             	sub    $0xc,%esp
 737:	6a 01                	push   $0x1
 739:	b9 0a 00 00 00       	mov    $0xa,%ecx
 73e:	e9 73 ff ff ff       	jmp    6b6 <printf+0xda>
 743:	90                   	nop
 744:	88 5d e5             	mov    %bl,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 747:	52                   	push   %edx
 748:	6a 01                	push   $0x1
 74a:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 74d:	e9 30 ff ff ff       	jmp    682 <printf+0xa6>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
 752:	bf 26 09 00 00       	mov    $0x926,%edi
 757:	eb 8e                	jmp    6e7 <printf+0x10b>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 759:	31 ff                	xor    %edi,%edi
 75b:	e9 be fe ff ff       	jmp    61e <printf+0x42>

00000760 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 760:	55                   	push   %ebp
 761:	89 e5                	mov    %esp,%ebp
 763:	57                   	push   %edi
 764:	56                   	push   %esi
 765:	53                   	push   %ebx
 766:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 769:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 76c:	a1 48 0c 00 00       	mov    0xc48,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 771:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 773:	39 c8                	cmp    %ecx,%eax
 775:	73 11                	jae    788 <free+0x28>
 777:	90                   	nop
 778:	39 d1                	cmp    %edx,%ecx
 77a:	72 14                	jb     790 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 77c:	39 d0                	cmp    %edx,%eax
 77e:	73 10                	jae    790 <free+0x30>
static Header base;
static Header *freep;

void
free(void *ap)
{
 780:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 782:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 784:	39 c8                	cmp    %ecx,%eax
 786:	72 f0                	jb     778 <free+0x18>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 788:	39 d0                	cmp    %edx,%eax
 78a:	72 f4                	jb     780 <free+0x20>
 78c:	39 d1                	cmp    %edx,%ecx
 78e:	73 f0                	jae    780 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 790:	8b 73 fc             	mov    -0x4(%ebx),%esi
 793:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 796:	39 d7                	cmp    %edx,%edi
 798:	74 19                	je     7b3 <free+0x53>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 79a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 79d:	8b 50 04             	mov    0x4(%eax),%edx
 7a0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7a3:	39 f1                	cmp    %esi,%ecx
 7a5:	74 23                	je     7ca <free+0x6a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 7a7:	89 08                	mov    %ecx,(%eax)
  freep = p;
 7a9:	a3 48 0c 00 00       	mov    %eax,0xc48
}
 7ae:	5b                   	pop    %ebx
 7af:	5e                   	pop    %esi
 7b0:	5f                   	pop    %edi
 7b1:	5d                   	pop    %ebp
 7b2:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7b3:	03 72 04             	add    0x4(%edx),%esi
 7b6:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7b9:	8b 10                	mov    (%eax),%edx
 7bb:	8b 12                	mov    (%edx),%edx
 7bd:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 7c0:	8b 50 04             	mov    0x4(%eax),%edx
 7c3:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7c6:	39 f1                	cmp    %esi,%ecx
 7c8:	75 dd                	jne    7a7 <free+0x47>
    p->s.size += bp->s.size;
 7ca:	03 53 fc             	add    -0x4(%ebx),%edx
 7cd:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7d0:	8b 53 f8             	mov    -0x8(%ebx),%edx
 7d3:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 7d5:	a3 48 0c 00 00       	mov    %eax,0xc48
}
 7da:	5b                   	pop    %ebx
 7db:	5e                   	pop    %esi
 7dc:	5f                   	pop    %edi
 7dd:	5d                   	pop    %ebp
 7de:	c3                   	ret    
 7df:	90                   	nop

000007e0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7e0:	55                   	push   %ebp
 7e1:	89 e5                	mov    %esp,%ebp
 7e3:	57                   	push   %edi
 7e4:	56                   	push   %esi
 7e5:	53                   	push   %ebx
 7e6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7e9:	8b 45 08             	mov    0x8(%ebp),%eax
 7ec:	8d 78 07             	lea    0x7(%eax),%edi
 7ef:	c1 ef 03             	shr    $0x3,%edi
 7f2:	47                   	inc    %edi
  if((prevp = freep) == 0){
 7f3:	8b 15 48 0c 00 00    	mov    0xc48,%edx
 7f9:	85 d2                	test   %edx,%edx
 7fb:	0f 84 b1 00 00 00    	je     8b2 <malloc+0xd2>
 801:	8b 02                	mov    (%edx),%eax
 803:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 806:	39 cf                	cmp    %ecx,%edi
 808:	76 66                	jbe    870 <malloc+0x90>
 80a:	89 fb                	mov    %edi,%ebx
 80c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 812:	0f 82 80 00 00 00    	jb     898 <malloc+0xb8>
 818:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 81e:	76 70                	jbe    890 <malloc+0xb0>
 820:	8d 34 fd 00 00 00 00 	lea    0x0(,%edi,8),%esi
 827:	eb 0c                	jmp    835 <malloc+0x55>
 829:	8d 76 00             	lea    0x0(%esi),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 82c:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 82e:	8b 48 04             	mov    0x4(%eax),%ecx
 831:	39 cf                	cmp    %ecx,%edi
 833:	76 3b                	jbe    870 <malloc+0x90>
 835:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 837:	39 05 48 0c 00 00    	cmp    %eax,0xc48
 83d:	75 ed                	jne    82c <malloc+0x4c>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 83f:	83 ec 0c             	sub    $0xc,%esp
 842:	56                   	push   %esi
 843:	e8 f7 fc ff ff       	call   53f <sbrk>
  if(p == (char*)-1)
 848:	83 c4 10             	add    $0x10,%esp
 84b:	83 f8 ff             	cmp    $0xffffffff,%eax
 84e:	74 1c                	je     86c <malloc+0x8c>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 850:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 853:	83 ec 0c             	sub    $0xc,%esp
 856:	83 c0 08             	add    $0x8,%eax
 859:	50                   	push   %eax
 85a:	e8 01 ff ff ff       	call   760 <free>
  return freep;
 85f:	8b 15 48 0c 00 00    	mov    0xc48,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 865:	83 c4 10             	add    $0x10,%esp
 868:	85 d2                	test   %edx,%edx
 86a:	75 c0                	jne    82c <malloc+0x4c>
        return 0;
 86c:	31 c0                	xor    %eax,%eax
 86e:	eb 18                	jmp    888 <malloc+0xa8>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 870:	39 cf                	cmp    %ecx,%edi
 872:	74 38                	je     8ac <malloc+0xcc>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 874:	29 f9                	sub    %edi,%ecx
 876:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 879:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 87c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 87f:	89 15 48 0c 00 00    	mov    %edx,0xc48
      return (void*)(p + 1);
 885:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 888:	8d 65 f4             	lea    -0xc(%ebp),%esp
 88b:	5b                   	pop    %ebx
 88c:	5e                   	pop    %esi
 88d:	5f                   	pop    %edi
 88e:	5d                   	pop    %ebp
 88f:	c3                   	ret    
 890:	be 00 80 00 00       	mov    $0x8000,%esi
 895:	eb 9e                	jmp    835 <malloc+0x55>
 897:	90                   	nop
 898:	bb 00 10 00 00       	mov    $0x1000,%ebx
 89d:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 8a3:	76 eb                	jbe    890 <malloc+0xb0>
 8a5:	e9 76 ff ff ff       	jmp    820 <malloc+0x40>
 8aa:	66 90                	xchg   %ax,%ax
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 8ac:	8b 08                	mov    (%eax),%ecx
 8ae:	89 0a                	mov    %ecx,(%edx)
 8b0:	eb cd                	jmp    87f <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 8b2:	c7 05 48 0c 00 00 4c 	movl   $0xc4c,0xc48
 8b9:	0c 00 00 
 8bc:	c7 05 4c 0c 00 00 4c 	movl   $0xc4c,0xc4c
 8c3:	0c 00 00 
    base.s.size = 0;
 8c6:	c7 05 50 0c 00 00 00 	movl   $0x0,0xc50
 8cd:	00 00 00 
 8d0:	b8 4c 0c 00 00       	mov    $0xc4c,%eax
 8d5:	e9 30 ff ff ff       	jmp    80a <malloc+0x2a>
