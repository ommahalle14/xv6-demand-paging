
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return 0;
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
   e:	52                   	push   %edx
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
   f:	eb 0c                	jmp    1d <main+0x1d>
  11:	8d 76 00             	lea    0x0(%esi),%esi
    if(fd >= 3){
  14:	83 f8 02             	cmp    $0x2,%eax
  17:	0f 8f bb 00 00 00    	jg     d8 <main+0xd8>
{
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
  1d:	83 ec 08             	sub    $0x8,%esp
  20:	6a 02                	push   $0x2
  22:	68 81 10 00 00       	push   $0x1081
  27:	e8 cf 0b 00 00       	call   bfb <open>
  2c:	83 c4 10             	add    $0x10,%esp
  2f:	85 c0                	test   %eax,%eax
  31:	79 e1                	jns    14 <main+0x14>
  33:	eb 26                	jmp    5b <main+0x5b>
  35:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
  38:	80 3d a2 16 00 00 20 	cmpb   $0x20,0x16a2
  3f:	74 59                	je     9a <main+0x9a>
  41:	8d 76 00             	lea    0x0(%esi),%esi
int
fork1(void)
{
  int pid;

  pid = fork();
  44:	e8 6a 0b 00 00       	call   bb3 <fork>
  if(pid == -1)
  49:	83 f8 ff             	cmp    $0xffffffff,%eax
  4c:	74 3f                	je     8d <main+0x8d>
      buf[strlen(buf)-1] = 0;  // chop \n
      if(chdir(buf+3) < 0)
        printf(2, "cannot cd %s\n", buf+3);
      continue;
    }
    if(fork1() == 0)
  4e:	85 c0                	test   %eax,%eax
  50:	0f 84 98 00 00 00    	je     ee <main+0xee>
      runcmd(parsecmd(buf));
    wait();
  56:	e8 68 0b 00 00       	call   bc3 <wait>
      break;
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
  5b:	83 ec 08             	sub    $0x8,%esp
  5e:	6a 64                	push   $0x64
  60:	68 a0 16 00 00       	push   $0x16a0
  65:	e8 9a 00 00 00       	call   104 <getcmd>
  6a:	83 c4 10             	add    $0x10,%esp
  6d:	85 c0                	test   %eax,%eax
  6f:	78 78                	js     e9 <main+0xe9>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
  71:	80 3d a0 16 00 00 63 	cmpb   $0x63,0x16a0
  78:	75 ca                	jne    44 <main+0x44>
  7a:	80 3d a1 16 00 00 64 	cmpb   $0x64,0x16a1
  81:	74 b5                	je     38 <main+0x38>
int
fork1(void)
{
  int pid;

  pid = fork();
  83:	e8 2b 0b 00 00       	call   bb3 <fork>
  if(pid == -1)
  88:	83 f8 ff             	cmp    $0xffffffff,%eax
  8b:	75 c1                	jne    4e <main+0x4e>
    panic("fork");
  8d:	83 ec 0c             	sub    $0xc,%esp
  90:	68 0a 10 00 00       	push   $0x100a
  95:	e8 ae 00 00 00       	call   148 <panic>

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      // Chdir must be called by the parent, not the child.
      buf[strlen(buf)-1] = 0;  // chop \n
  9a:	83 ec 0c             	sub    $0xc,%esp
  9d:	68 a0 16 00 00       	push   $0x16a0
  a2:	e8 c1 09 00 00       	call   a68 <strlen>
  a7:	c6 80 9f 16 00 00 00 	movb   $0x0,0x169f(%eax)
      if(chdir(buf+3) < 0)
  ae:	c7 04 24 a3 16 00 00 	movl   $0x16a3,(%esp)
  b5:	e8 71 0b 00 00       	call   c2b <chdir>
  ba:	83 c4 10             	add    $0x10,%esp
  bd:	85 c0                	test   %eax,%eax
  bf:	79 9a                	jns    5b <main+0x5b>
        printf(2, "cannot cd %s\n", buf+3);
  c1:	50                   	push   %eax
  c2:	68 a3 16 00 00       	push   $0x16a3
  c7:	68 89 10 00 00       	push   $0x1089
  cc:	6a 02                	push   $0x2
  ce:	e8 0d 0c 00 00       	call   ce0 <printf>
  d3:	83 c4 10             	add    $0x10,%esp
  d6:	eb 83                	jmp    5b <main+0x5b>
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
    if(fd >= 3){
      close(fd);
  d8:	83 ec 0c             	sub    $0xc,%esp
  db:	50                   	push   %eax
  dc:	e8 02 0b 00 00       	call   be3 <close>
      break;
  e1:	83 c4 10             	add    $0x10,%esp
  e4:	e9 72 ff ff ff       	jmp    5b <main+0x5b>
    }
    if(fork1() == 0)
      runcmd(parsecmd(buf));
    wait();
  }
  exit();
  e9:	e8 cd 0a 00 00       	call   bbb <exit>
      if(chdir(buf+3) < 0)
        printf(2, "cannot cd %s\n", buf+3);
      continue;
    }
    if(fork1() == 0)
      runcmd(parsecmd(buf));
  ee:	83 ec 0c             	sub    $0xc,%esp
  f1:	68 a0 16 00 00       	push   $0x16a0
  f6:	e8 a9 08 00 00       	call   9a4 <parsecmd>
  fb:	89 04 24             	mov    %eax,(%esp)
  fe:	e8 61 00 00 00       	call   164 <runcmd>
 103:	90                   	nop

00000104 <getcmd>:
  exit();
}

int
getcmd(char *buf, int nbuf)
{
 104:	55                   	push   %ebp
 105:	89 e5                	mov    %esp,%ebp
 107:	56                   	push   %esi
 108:	53                   	push   %ebx
 109:	8b 5d 08             	mov    0x8(%ebp),%ebx
 10c:	8b 75 0c             	mov    0xc(%ebp),%esi
  printf(2, "$ ");
 10f:	83 ec 08             	sub    $0x8,%esp
 112:	68 e0 0f 00 00       	push   $0xfe0
 117:	6a 02                	push   $0x2
 119:	e8 c2 0b 00 00       	call   ce0 <printf>
  memset(buf, 0, nbuf);
 11e:	83 c4 0c             	add    $0xc,%esp
 121:	56                   	push   %esi
 122:	6a 00                	push   $0x0
 124:	53                   	push   %ebx
 125:	e8 5e 09 00 00       	call   a88 <memset>
  gets(buf, nbuf);
 12a:	58                   	pop    %eax
 12b:	5a                   	pop    %edx
 12c:	56                   	push   %esi
 12d:	53                   	push   %ebx
 12e:	e8 95 09 00 00       	call   ac8 <gets>
 133:	83 c4 10             	add    $0x10,%esp
 136:	31 c0                	xor    %eax,%eax
 138:	80 3b 00             	cmpb   $0x0,(%ebx)
 13b:	0f 94 c0             	sete   %al
 13e:	f7 d8                	neg    %eax
  if(buf[0] == 0) // EOF
    return -1;
  return 0;
}
 140:	8d 65 f8             	lea    -0x8(%ebp),%esp
 143:	5b                   	pop    %ebx
 144:	5e                   	pop    %esi
 145:	5d                   	pop    %ebp
 146:	c3                   	ret    
 147:	90                   	nop

00000148 <panic>:
  exit();
}

void
panic(char *s)
{
 148:	55                   	push   %ebp
 149:	89 e5                	mov    %esp,%ebp
 14b:	83 ec 0c             	sub    $0xc,%esp
  printf(2, "%s\n", s);
 14e:	ff 75 08             	pushl  0x8(%ebp)
 151:	68 7d 10 00 00       	push   $0x107d
 156:	6a 02                	push   $0x2
 158:	e8 83 0b 00 00       	call   ce0 <printf>
  exit();
 15d:	e8 59 0a 00 00       	call   bbb <exit>
 162:	66 90                	xchg   %ax,%ax

00000164 <runcmd>:
struct cmd *parsecmd(char*);

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
 164:	55                   	push   %ebp
 165:	89 e5                	mov    %esp,%ebp
 167:	53                   	push   %ebx
 168:	83 ec 14             	sub    $0x14,%esp
 16b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
 16e:	85 db                	test   %ebx,%ebx
 170:	74 76                	je     1e8 <runcmd+0x84>
    exit();

  switch(cmd->type){
 172:	83 3b 05             	cmpl   $0x5,(%ebx)
 175:	0f 87 f8 00 00 00    	ja     273 <runcmd+0x10f>
 17b:	8b 03                	mov    (%ebx),%eax
 17d:	ff 24 85 98 10 00 00 	jmp    *0x1098(,%eax,4)
    runcmd(lcmd->right);
    break;

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if(pipe(p) < 0)
 184:	83 ec 0c             	sub    $0xc,%esp
 187:	8d 45 f0             	lea    -0x10(%ebp),%eax
 18a:	50                   	push   %eax
 18b:	e8 3b 0a 00 00       	call   bcb <pipe>
 190:	83 c4 10             	add    $0x10,%esp
 193:	85 c0                	test   %eax,%eax
 195:	0f 88 07 01 00 00    	js     2a2 <runcmd+0x13e>
int
fork1(void)
{
  int pid;

  pid = fork();
 19b:	e8 13 0a 00 00       	call   bb3 <fork>
  if(pid == -1)
 1a0:	83 f8 ff             	cmp    $0xffffffff,%eax
 1a3:	0f 84 d7 00 00 00    	je     280 <runcmd+0x11c>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if(pipe(p) < 0)
      panic("pipe");
    if(fork1() == 0){
 1a9:	85 c0                	test   %eax,%eax
 1ab:	0f 84 fe 00 00 00    	je     2af <runcmd+0x14b>
int
fork1(void)
{
  int pid;

  pid = fork();
 1b1:	e8 fd 09 00 00       	call   bb3 <fork>
  if(pid == -1)
 1b6:	83 f8 ff             	cmp    $0xffffffff,%eax
 1b9:	0f 84 c1 00 00 00    	je     280 <runcmd+0x11c>
      dup(p[1]);
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->left);
    }
    if(fork1() == 0){
 1bf:	85 c0                	test   %eax,%eax
 1c1:	0f 84 16 01 00 00    	je     2dd <runcmd+0x179>
      dup(p[0]);
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->right);
    }
    close(p[0]);
 1c7:	83 ec 0c             	sub    $0xc,%esp
 1ca:	ff 75 f0             	pushl  -0x10(%ebp)
 1cd:	e8 11 0a 00 00       	call   be3 <close>
    close(p[1]);
 1d2:	58                   	pop    %eax
 1d3:	ff 75 f4             	pushl  -0xc(%ebp)
 1d6:	e8 08 0a 00 00       	call   be3 <close>
    wait();
 1db:	e8 e3 09 00 00       	call   bc3 <wait>
    wait();
 1e0:	e8 de 09 00 00       	call   bc3 <wait>
    break;
 1e5:	83 c4 10             	add    $0x10,%esp
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
    exit();
 1e8:	e8 ce 09 00 00       	call   bbb <exit>
int
fork1(void)
{
  int pid;

  pid = fork();
 1ed:	e8 c1 09 00 00       	call   bb3 <fork>
  if(pid == -1)
 1f2:	83 f8 ff             	cmp    $0xffffffff,%eax
 1f5:	0f 84 85 00 00 00    	je     280 <runcmd+0x11c>
    wait();
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    if(fork1() == 0)
 1fb:	85 c0                	test   %eax,%eax
 1fd:	75 e9                	jne    1e8 <runcmd+0x84>
 1ff:	eb 49                	jmp    24a <runcmd+0xe6>
  default:
    panic("runcmd");

  case EXEC:
    ecmd = (struct execcmd*)cmd;
    if(ecmd->argv[0] == 0)
 201:	8b 43 04             	mov    0x4(%ebx),%eax
 204:	85 c0                	test   %eax,%eax
 206:	74 e0                	je     1e8 <runcmd+0x84>
      exit();
    exec(ecmd->argv[0], ecmd->argv);
 208:	52                   	push   %edx
 209:	52                   	push   %edx
 20a:	8d 53 04             	lea    0x4(%ebx),%edx
 20d:	52                   	push   %edx
 20e:	50                   	push   %eax
 20f:	e8 df 09 00 00       	call   bf3 <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
 214:	83 c4 0c             	add    $0xc,%esp
 217:	ff 73 04             	pushl  0x4(%ebx)
 21a:	68 ea 0f 00 00       	push   $0xfea
 21f:	6a 02                	push   $0x2
 221:	e8 ba 0a 00 00       	call   ce0 <printf>
    break;
 226:	83 c4 10             	add    $0x10,%esp
 229:	eb bd                	jmp    1e8 <runcmd+0x84>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    close(rcmd->fd);
 22b:	83 ec 0c             	sub    $0xc,%esp
 22e:	ff 73 14             	pushl  0x14(%ebx)
 231:	e8 ad 09 00 00       	call   be3 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
 236:	59                   	pop    %ecx
 237:	58                   	pop    %eax
 238:	ff 73 10             	pushl  0x10(%ebx)
 23b:	ff 73 08             	pushl  0x8(%ebx)
 23e:	e8 b8 09 00 00       	call   bfb <open>
 243:	83 c4 10             	add    $0x10,%esp
 246:	85 c0                	test   %eax,%eax
 248:	78 43                	js     28d <runcmd+0x129>
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    if(fork1() == 0)
      runcmd(bcmd->cmd);
 24a:	83 ec 0c             	sub    $0xc,%esp
 24d:	ff 73 04             	pushl  0x4(%ebx)
 250:	e8 0f ff ff ff       	call   164 <runcmd>
int
fork1(void)
{
  int pid;

  pid = fork();
 255:	e8 59 09 00 00       	call   bb3 <fork>
  if(pid == -1)
 25a:	83 f8 ff             	cmp    $0xffffffff,%eax
 25d:	74 21                	je     280 <runcmd+0x11c>
    runcmd(rcmd->cmd);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    if(fork1() == 0)
 25f:	85 c0                	test   %eax,%eax
 261:	74 e7                	je     24a <runcmd+0xe6>
      runcmd(lcmd->left);
    wait();
 263:	e8 5b 09 00 00       	call   bc3 <wait>
    runcmd(lcmd->right);
 268:	83 ec 0c             	sub    $0xc,%esp
 26b:	ff 73 08             	pushl  0x8(%ebx)
 26e:	e8 f1 fe ff ff       	call   164 <runcmd>
  if(cmd == 0)
    exit();

  switch(cmd->type){
  default:
    panic("runcmd");
 273:	83 ec 0c             	sub    $0xc,%esp
 276:	68 e3 0f 00 00       	push   $0xfe3
 27b:	e8 c8 fe ff ff       	call   148 <panic>
{
  int pid;

  pid = fork();
  if(pid == -1)
    panic("fork");
 280:	83 ec 0c             	sub    $0xc,%esp
 283:	68 0a 10 00 00       	push   $0x100a
 288:	e8 bb fe ff ff       	call   148 <panic>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    close(rcmd->fd);
    if(open(rcmd->file, rcmd->mode) < 0){
      printf(2, "open %s failed\n", rcmd->file);
 28d:	52                   	push   %edx
 28e:	ff 73 08             	pushl  0x8(%ebx)
 291:	68 fa 0f 00 00       	push   $0xffa
 296:	6a 02                	push   $0x2
 298:	e8 43 0a 00 00       	call   ce0 <printf>
      exit();
 29d:	e8 19 09 00 00       	call   bbb <exit>
    break;

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if(pipe(p) < 0)
      panic("pipe");
 2a2:	83 ec 0c             	sub    $0xc,%esp
 2a5:	68 0f 10 00 00       	push   $0x100f
 2aa:	e8 99 fe ff ff       	call   148 <panic>
    if(fork1() == 0){
      close(1);
 2af:	83 ec 0c             	sub    $0xc,%esp
 2b2:	6a 01                	push   $0x1
 2b4:	e8 2a 09 00 00       	call   be3 <close>
      dup(p[1]);
 2b9:	58                   	pop    %eax
 2ba:	ff 75 f4             	pushl  -0xc(%ebp)
 2bd:	e8 71 09 00 00       	call   c33 <dup>
      close(p[0]);
 2c2:	58                   	pop    %eax
 2c3:	ff 75 f0             	pushl  -0x10(%ebp)
 2c6:	e8 18 09 00 00       	call   be3 <close>
      close(p[1]);
 2cb:	58                   	pop    %eax
 2cc:	ff 75 f4             	pushl  -0xc(%ebp)
 2cf:	e8 0f 09 00 00       	call   be3 <close>
      runcmd(pcmd->left);
 2d4:	58                   	pop    %eax
 2d5:	ff 73 04             	pushl  0x4(%ebx)
 2d8:	e8 87 fe ff ff       	call   164 <runcmd>
    }
    if(fork1() == 0){
      close(0);
 2dd:	83 ec 0c             	sub    $0xc,%esp
 2e0:	6a 00                	push   $0x0
 2e2:	e8 fc 08 00 00       	call   be3 <close>
      dup(p[0]);
 2e7:	5a                   	pop    %edx
 2e8:	ff 75 f0             	pushl  -0x10(%ebp)
 2eb:	e8 43 09 00 00       	call   c33 <dup>
      close(p[0]);
 2f0:	59                   	pop    %ecx
 2f1:	ff 75 f0             	pushl  -0x10(%ebp)
 2f4:	e8 ea 08 00 00       	call   be3 <close>
      close(p[1]);
 2f9:	58                   	pop    %eax
 2fa:	ff 75 f4             	pushl  -0xc(%ebp)
 2fd:	e8 e1 08 00 00       	call   be3 <close>
      runcmd(pcmd->right);
 302:	58                   	pop    %eax
 303:	ff 73 08             	pushl  0x8(%ebx)
 306:	e8 59 fe ff ff       	call   164 <runcmd>
 30b:	90                   	nop

0000030c <fork1>:
  exit();
}

int
fork1(void)
{
 30c:	55                   	push   %ebp
 30d:	89 e5                	mov    %esp,%ebp
 30f:	83 ec 08             	sub    $0x8,%esp
  int pid;

  pid = fork();
 312:	e8 9c 08 00 00       	call   bb3 <fork>
  if(pid == -1)
 317:	83 f8 ff             	cmp    $0xffffffff,%eax
 31a:	74 02                	je     31e <fork1+0x12>
    panic("fork");
  return pid;
}
 31c:	c9                   	leave  
 31d:	c3                   	ret    
{
  int pid;

  pid = fork();
  if(pid == -1)
    panic("fork");
 31e:	83 ec 0c             	sub    $0xc,%esp
 321:	68 0a 10 00 00       	push   $0x100a
 326:	e8 1d fe ff ff       	call   148 <panic>
 32b:	90                   	nop

0000032c <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
 32c:	55                   	push   %ebp
 32d:	89 e5                	mov    %esp,%ebp
 32f:	53                   	push   %ebx
 330:	83 ec 10             	sub    $0x10,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
 333:	6a 54                	push   $0x54
 335:	e8 aa 0b 00 00       	call   ee4 <malloc>
 33a:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
 33c:	83 c4 0c             	add    $0xc,%esp
 33f:	6a 54                	push   $0x54
 341:	6a 00                	push   $0x0
 343:	50                   	push   %eax
 344:	e8 3f 07 00 00       	call   a88 <memset>
  cmd->type = EXEC;
 349:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
 34f:	89 d8                	mov    %ebx,%eax
 351:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 354:	c9                   	leave  
 355:	c3                   	ret    
 356:	66 90                	xchg   %ax,%ax

00000358 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
 358:	55                   	push   %ebp
 359:	89 e5                	mov    %esp,%ebp
 35b:	53                   	push   %ebx
 35c:	83 ec 10             	sub    $0x10,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
 35f:	6a 18                	push   $0x18
 361:	e8 7e 0b 00 00       	call   ee4 <malloc>
 366:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
 368:	83 c4 0c             	add    $0xc,%esp
 36b:	6a 18                	push   $0x18
 36d:	6a 00                	push   $0x0
 36f:	50                   	push   %eax
 370:	e8 13 07 00 00       	call   a88 <memset>
  cmd->type = REDIR;
 375:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
 37b:	8b 45 08             	mov    0x8(%ebp),%eax
 37e:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
 381:	8b 45 0c             	mov    0xc(%ebp),%eax
 384:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
 387:	8b 45 10             	mov    0x10(%ebp),%eax
 38a:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
 38d:	8b 45 14             	mov    0x14(%ebp),%eax
 390:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
 393:	8b 45 18             	mov    0x18(%ebp),%eax
 396:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
 399:	89 d8                	mov    %ebx,%eax
 39b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 39e:	c9                   	leave  
 39f:	c3                   	ret    

000003a0 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	53                   	push   %ebx
 3a4:	83 ec 10             	sub    $0x10,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
 3a7:	6a 0c                	push   $0xc
 3a9:	e8 36 0b 00 00       	call   ee4 <malloc>
 3ae:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
 3b0:	83 c4 0c             	add    $0xc,%esp
 3b3:	6a 0c                	push   $0xc
 3b5:	6a 00                	push   $0x0
 3b7:	50                   	push   %eax
 3b8:	e8 cb 06 00 00       	call   a88 <memset>
  cmd->type = PIPE;
 3bd:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
 3c3:	8b 45 08             	mov    0x8(%ebp),%eax
 3c6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
 3c9:	8b 45 0c             	mov    0xc(%ebp),%eax
 3cc:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
 3cf:	89 d8                	mov    %ebx,%eax
 3d1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3d4:	c9                   	leave  
 3d5:	c3                   	ret    
 3d6:	66 90                	xchg   %ax,%ax

000003d8 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
 3d8:	55                   	push   %ebp
 3d9:	89 e5                	mov    %esp,%ebp
 3db:	53                   	push   %ebx
 3dc:	83 ec 10             	sub    $0x10,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
 3df:	6a 0c                	push   $0xc
 3e1:	e8 fe 0a 00 00       	call   ee4 <malloc>
 3e6:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
 3e8:	83 c4 0c             	add    $0xc,%esp
 3eb:	6a 0c                	push   $0xc
 3ed:	6a 00                	push   $0x0
 3ef:	50                   	push   %eax
 3f0:	e8 93 06 00 00       	call   a88 <memset>
  cmd->type = LIST;
 3f5:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
 3fb:	8b 45 08             	mov    0x8(%ebp),%eax
 3fe:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
 401:	8b 45 0c             	mov    0xc(%ebp),%eax
 404:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
 407:	89 d8                	mov    %ebx,%eax
 409:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 40c:	c9                   	leave  
 40d:	c3                   	ret    
 40e:	66 90                	xchg   %ax,%ax

00000410 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	53                   	push   %ebx
 414:	83 ec 10             	sub    $0x10,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
 417:	6a 08                	push   $0x8
 419:	e8 c6 0a 00 00       	call   ee4 <malloc>
 41e:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
 420:	83 c4 0c             	add    $0xc,%esp
 423:	6a 08                	push   $0x8
 425:	6a 00                	push   $0x0
 427:	50                   	push   %eax
 428:	e8 5b 06 00 00       	call   a88 <memset>
  cmd->type = BACK;
 42d:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
 433:	8b 45 08             	mov    0x8(%ebp),%eax
 436:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
 439:	89 d8                	mov    %ebx,%eax
 43b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 43e:	c9                   	leave  
 43f:	c3                   	ret    

00000440 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	57                   	push   %edi
 444:	56                   	push   %esi
 445:	53                   	push   %ebx
 446:	83 ec 0c             	sub    $0xc,%esp
 449:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 44c:	8b 75 10             	mov    0x10(%ebp),%esi
  char *s;
  int ret;

  s = *ps;
 44f:	8b 45 08             	mov    0x8(%ebp),%eax
 452:	8b 38                	mov    (%eax),%edi
  while(s < es && strchr(whitespace, *s))
 454:	39 df                	cmp    %ebx,%edi
 456:	72 0d                	jb     465 <gettoken+0x25>
 458:	eb 23                	jmp    47d <gettoken+0x3d>
 45a:	66 90                	xchg   %ax,%ax
    s++;
 45c:	47                   	inc    %edi
{
  char *s;
  int ret;

  s = *ps;
  while(s < es && strchr(whitespace, *s))
 45d:	39 fb                	cmp    %edi,%ebx
 45f:	0f 84 d7 00 00 00    	je     53c <gettoken+0xfc>
 465:	83 ec 08             	sub    $0x8,%esp
 468:	0f be 07             	movsbl (%edi),%eax
 46b:	50                   	push   %eax
 46c:	68 88 16 00 00       	push   $0x1688
 471:	e8 2a 06 00 00       	call   aa0 <strchr>
 476:	83 c4 10             	add    $0x10,%esp
 479:	85 c0                	test   %eax,%eax
 47b:	75 df                	jne    45c <gettoken+0x1c>
    s++;
  if(q)
 47d:	85 f6                	test   %esi,%esi
 47f:	74 02                	je     483 <gettoken+0x43>
    *q = s;
 481:	89 3e                	mov    %edi,(%esi)
  ret = *s;
 483:	0f be 37             	movsbl (%edi),%esi
 486:	89 f1                	mov    %esi,%ecx
 488:	89 f0                	mov    %esi,%eax
  switch(*s){
 48a:	80 f9 29             	cmp    $0x29,%cl
 48d:	7f 4d                	jg     4dc <gettoken+0x9c>
 48f:	80 f9 28             	cmp    $0x28,%cl
 492:	7d 53                	jge    4e7 <gettoken+0xa7>
 494:	84 c9                	test   %cl,%cl
 496:	0f 85 c4 00 00 00    	jne    560 <gettoken+0x120>
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
 49c:	8b 55 14             	mov    0x14(%ebp),%edx
 49f:	85 d2                	test   %edx,%edx
 4a1:	74 05                	je     4a8 <gettoken+0x68>
    *eq = s;
 4a3:	8b 45 14             	mov    0x14(%ebp),%eax
 4a6:	89 38                	mov    %edi,(%eax)

  while(s < es && strchr(whitespace, *s))
 4a8:	39 fb                	cmp    %edi,%ebx
 4aa:	77 09                	ja     4b5 <gettoken+0x75>
 4ac:	eb 1f                	jmp    4cd <gettoken+0x8d>
 4ae:	66 90                	xchg   %ax,%ax
    s++;
 4b0:	47                   	inc    %edi
    break;
  }
  if(eq)
    *eq = s;

  while(s < es && strchr(whitespace, *s))
 4b1:	39 fb                	cmp    %edi,%ebx
 4b3:	74 18                	je     4cd <gettoken+0x8d>
 4b5:	83 ec 08             	sub    $0x8,%esp
 4b8:	0f be 07             	movsbl (%edi),%eax
 4bb:	50                   	push   %eax
 4bc:	68 88 16 00 00       	push   $0x1688
 4c1:	e8 da 05 00 00       	call   aa0 <strchr>
 4c6:	83 c4 10             	add    $0x10,%esp
 4c9:	85 c0                	test   %eax,%eax
 4cb:	75 e3                	jne    4b0 <gettoken+0x70>
    s++;
  *ps = s;
 4cd:	8b 45 08             	mov    0x8(%ebp),%eax
 4d0:	89 38                	mov    %edi,(%eax)
  return ret;
}
 4d2:	89 f0                	mov    %esi,%eax
 4d4:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4d7:	5b                   	pop    %ebx
 4d8:	5e                   	pop    %esi
 4d9:	5f                   	pop    %edi
 4da:	5d                   	pop    %ebp
 4db:	c3                   	ret    
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
 4dc:	80 f9 3e             	cmp    $0x3e,%cl
 4df:	75 0b                	jne    4ec <gettoken+0xac>
  case '<':
    s++;
    break;
  case '>':
    s++;
    if(*s == '>'){
 4e1:	80 7f 01 3e          	cmpb   $0x3e,0x1(%edi)
 4e5:	74 69                	je     550 <gettoken+0x110>
  case '&':
  case '<':
    s++;
    break;
  case '>':
    s++;
 4e7:	47                   	inc    %edi
 4e8:	eb b2                	jmp    49c <gettoken+0x5c>
 4ea:	66 90                	xchg   %ax,%ax
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
 4ec:	7f 56                	jg     544 <gettoken+0x104>
 4ee:	83 e9 3b             	sub    $0x3b,%ecx
 4f1:	80 f9 01             	cmp    $0x1,%cl
 4f4:	76 f1                	jbe    4e7 <gettoken+0xa7>
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
 4f6:	39 fb                	cmp    %edi,%ebx
 4f8:	77 22                	ja     51c <gettoken+0xdc>
 4fa:	eb 71                	jmp    56d <gettoken+0x12d>
 4fc:	83 ec 08             	sub    $0x8,%esp
 4ff:	0f be 07             	movsbl (%edi),%eax
 502:	50                   	push   %eax
 503:	68 80 16 00 00       	push   $0x1680
 508:	e8 93 05 00 00       	call   aa0 <strchr>
 50d:	83 c4 10             	add    $0x10,%esp
 510:	85 c0                	test   %eax,%eax
 512:	75 1d                	jne    531 <gettoken+0xf1>
      s++;
 514:	47                   	inc    %edi
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
 515:	39 fb                	cmp    %edi,%ebx
 517:	74 52                	je     56b <gettoken+0x12b>
 519:	0f be 07             	movsbl (%edi),%eax
 51c:	83 ec 08             	sub    $0x8,%esp
 51f:	50                   	push   %eax
 520:	68 88 16 00 00       	push   $0x1688
 525:	e8 76 05 00 00       	call   aa0 <strchr>
 52a:	83 c4 10             	add    $0x10,%esp
 52d:	85 c0                	test   %eax,%eax
 52f:	74 cb                	je     4fc <gettoken+0xbc>
      ret = '+';
      s++;
    }
    break;
  default:
    ret = 'a';
 531:	be 61 00 00 00       	mov    $0x61,%esi
 536:	e9 61 ff ff ff       	jmp    49c <gettoken+0x5c>
 53b:	90                   	nop
 53c:	89 df                	mov    %ebx,%edi
 53e:	e9 3a ff ff ff       	jmp    47d <gettoken+0x3d>
 543:	90                   	nop
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
 544:	80 f9 7c             	cmp    $0x7c,%cl
 547:	75 ad                	jne    4f6 <gettoken+0xb6>
  case '&':
  case '<':
    s++;
    break;
  case '>':
    s++;
 549:	47                   	inc    %edi
 54a:	e9 4d ff ff ff       	jmp    49c <gettoken+0x5c>
 54f:	90                   	nop
    if(*s == '>'){
      ret = '+';
      s++;
 550:	83 c7 02             	add    $0x2,%edi
    s++;
    break;
  case '>':
    s++;
    if(*s == '>'){
      ret = '+';
 553:	be 2b 00 00 00       	mov    $0x2b,%esi
 558:	e9 3f ff ff ff       	jmp    49c <gettoken+0x5c>
 55d:	8d 76 00             	lea    0x0(%esi),%esi
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
 560:	80 f9 26             	cmp    $0x26,%cl
 563:	75 91                	jne    4f6 <gettoken+0xb6>
  case '&':
  case '<':
    s++;
    break;
  case '>':
    s++;
 565:	47                   	inc    %edi
 566:	e9 31 ff ff ff       	jmp    49c <gettoken+0x5c>
 56b:	89 df                	mov    %ebx,%edi
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
 56d:	be 61 00 00 00       	mov    $0x61,%esi
 572:	8b 45 14             	mov    0x14(%ebp),%eax
 575:	85 c0                	test   %eax,%eax
 577:	0f 85 26 ff ff ff    	jne    4a3 <gettoken+0x63>
 57d:	e9 4b ff ff ff       	jmp    4cd <gettoken+0x8d>
 582:	66 90                	xchg   %ax,%ax

00000584 <peek>:
  return ret;
}

int
peek(char **ps, char *es, char *toks)
{
 584:	55                   	push   %ebp
 585:	89 e5                	mov    %esp,%ebp
 587:	57                   	push   %edi
 588:	56                   	push   %esi
 589:	53                   	push   %ebx
 58a:	83 ec 0c             	sub    $0xc,%esp
 58d:	8b 7d 08             	mov    0x8(%ebp),%edi
 590:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
 593:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
 595:	39 f3                	cmp    %esi,%ebx
 597:	72 08                	jb     5a1 <peek+0x1d>
 599:	eb 1e                	jmp    5b9 <peek+0x35>
 59b:	90                   	nop
    s++;
 59c:	43                   	inc    %ebx
peek(char **ps, char *es, char *toks)
{
  char *s;

  s = *ps;
  while(s < es && strchr(whitespace, *s))
 59d:	39 de                	cmp    %ebx,%esi
 59f:	74 18                	je     5b9 <peek+0x35>
 5a1:	83 ec 08             	sub    $0x8,%esp
 5a4:	0f be 03             	movsbl (%ebx),%eax
 5a7:	50                   	push   %eax
 5a8:	68 88 16 00 00       	push   $0x1688
 5ad:	e8 ee 04 00 00       	call   aa0 <strchr>
 5b2:	83 c4 10             	add    $0x10,%esp
 5b5:	85 c0                	test   %eax,%eax
 5b7:	75 e3                	jne    59c <peek+0x18>
    s++;
  *ps = s;
 5b9:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
 5bb:	0f be 03             	movsbl (%ebx),%eax
 5be:	84 c0                	test   %al,%al
 5c0:	75 0a                	jne    5cc <peek+0x48>
 5c2:	31 c0                	xor    %eax,%eax
}
 5c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5c7:	5b                   	pop    %ebx
 5c8:	5e                   	pop    %esi
 5c9:	5f                   	pop    %edi
 5ca:	5d                   	pop    %ebp
 5cb:	c3                   	ret    

  s = *ps;
  while(s < es && strchr(whitespace, *s))
    s++;
  *ps = s;
  return *s && strchr(toks, *s);
 5cc:	83 ec 08             	sub    $0x8,%esp
 5cf:	50                   	push   %eax
 5d0:	ff 75 10             	pushl  0x10(%ebp)
 5d3:	e8 c8 04 00 00       	call   aa0 <strchr>
 5d8:	83 c4 10             	add    $0x10,%esp
 5db:	85 c0                	test   %eax,%eax
 5dd:	0f 95 c0             	setne  %al
 5e0:	0f b6 c0             	movzbl %al,%eax
}
 5e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5e6:	5b                   	pop    %ebx
 5e7:	5e                   	pop    %esi
 5e8:	5f                   	pop    %edi
 5e9:	5d                   	pop    %ebp
 5ea:	c3                   	ret    
 5eb:	90                   	nop

000005ec <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
 5ec:	55                   	push   %ebp
 5ed:	89 e5                	mov    %esp,%ebp
 5ef:	57                   	push   %edi
 5f0:	56                   	push   %esi
 5f1:	53                   	push   %ebx
 5f2:	83 ec 1c             	sub    $0x1c,%esp
 5f5:	8b 75 0c             	mov    0xc(%ebp),%esi
 5f8:	8b 5d 10             	mov    0x10(%ebp),%ebx
 5fb:	90                   	nop
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
 5fc:	50                   	push   %eax
 5fd:	68 31 10 00 00       	push   $0x1031
 602:	53                   	push   %ebx
 603:	56                   	push   %esi
 604:	e8 7b ff ff ff       	call   584 <peek>
 609:	83 c4 10             	add    $0x10,%esp
 60c:	85 c0                	test   %eax,%eax
 60e:	74 60                	je     670 <parseredirs+0x84>
    tok = gettoken(ps, es, 0, 0);
 610:	6a 00                	push   $0x0
 612:	6a 00                	push   $0x0
 614:	53                   	push   %ebx
 615:	56                   	push   %esi
 616:	e8 25 fe ff ff       	call   440 <gettoken>
 61b:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
 61d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 620:	50                   	push   %eax
 621:	8d 45 e0             	lea    -0x20(%ebp),%eax
 624:	50                   	push   %eax
 625:	53                   	push   %ebx
 626:	56                   	push   %esi
 627:	e8 14 fe ff ff       	call   440 <gettoken>
 62c:	83 c4 20             	add    $0x20,%esp
 62f:	83 f8 61             	cmp    $0x61,%eax
 632:	75 47                	jne    67b <parseredirs+0x8f>
      panic("missing file for redirection");
    switch(tok){
 634:	83 ff 3c             	cmp    $0x3c,%edi
 637:	74 2b                	je     664 <parseredirs+0x78>
 639:	83 ff 3e             	cmp    $0x3e,%edi
 63c:	74 05                	je     643 <parseredirs+0x57>
 63e:	83 ff 2b             	cmp    $0x2b,%edi
 641:	75 b9                	jne    5fc <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
 643:	83 ec 0c             	sub    $0xc,%esp
 646:	6a 01                	push   $0x1
 648:	68 01 02 00 00       	push   $0x201
 64d:	ff 75 e4             	pushl  -0x1c(%ebp)
 650:	ff 75 e0             	pushl  -0x20(%ebp)
 653:	ff 75 08             	pushl  0x8(%ebp)
 656:	e8 fd fc ff ff       	call   358 <redircmd>
 65b:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
 65e:	83 c4 20             	add    $0x20,%esp
 661:	eb 99                	jmp    5fc <parseredirs+0x10>
 663:	90                   	nop
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
      panic("missing file for redirection");
    switch(tok){
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
 664:	83 ec 0c             	sub    $0xc,%esp
 667:	6a 00                	push   $0x0
 669:	6a 00                	push   $0x0
 66b:	eb e0                	jmp    64d <parseredirs+0x61>
 66d:	8d 76 00             	lea    0x0(%esi),%esi
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    }
  }
  return cmd;
}
 670:	8b 45 08             	mov    0x8(%ebp),%eax
 673:	8d 65 f4             	lea    -0xc(%ebp),%esp
 676:	5b                   	pop    %ebx
 677:	5e                   	pop    %esi
 678:	5f                   	pop    %edi
 679:	5d                   	pop    %ebp
 67a:	c3                   	ret    
  char *q, *eq;

  while(peek(ps, es, "<>")){
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
      panic("missing file for redirection");
 67b:	83 ec 0c             	sub    $0xc,%esp
 67e:	68 14 10 00 00       	push   $0x1014
 683:	e8 c0 fa ff ff       	call   148 <panic>

00000688 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
 688:	55                   	push   %ebp
 689:	89 e5                	mov    %esp,%ebp
 68b:	57                   	push   %edi
 68c:	56                   	push   %esi
 68d:	53                   	push   %ebx
 68e:	83 ec 30             	sub    $0x30,%esp
 691:	8b 75 08             	mov    0x8(%ebp),%esi
 694:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
 697:	68 34 10 00 00       	push   $0x1034
 69c:	57                   	push   %edi
 69d:	56                   	push   %esi
 69e:	e8 e1 fe ff ff       	call   584 <peek>
 6a3:	83 c4 10             	add    $0x10,%esp
 6a6:	85 c0                	test   %eax,%eax
 6a8:	0f 85 8e 00 00 00    	jne    73c <parseexec+0xb4>
    return parseblock(ps, es);

  ret = execcmd();
 6ae:	e8 79 fc ff ff       	call   32c <execcmd>
 6b3:	89 c3                	mov    %eax,%ebx
 6b5:	89 45 cc             	mov    %eax,-0x34(%ebp)
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
 6b8:	51                   	push   %ecx
 6b9:	57                   	push   %edi
 6ba:	56                   	push   %esi
 6bb:	50                   	push   %eax
 6bc:	e8 2b ff ff ff       	call   5ec <parseredirs>
 6c1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 6c4:	8d 5b 04             	lea    0x4(%ebx),%ebx
 6c7:	83 c4 10             	add    $0x10,%esp
    return parseblock(ps, es);

  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
 6ca:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
 6d1:	eb 12                	jmp    6e5 <parseexec+0x5d>
 6d3:	90                   	nop
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
 6d4:	52                   	push   %edx
 6d5:	57                   	push   %edi
 6d6:	56                   	push   %esi
 6d7:	ff 75 d0             	pushl  -0x30(%ebp)
 6da:	e8 0d ff ff ff       	call   5ec <parseredirs>
 6df:	89 45 d0             	mov    %eax,-0x30(%ebp)
 6e2:	83 c4 10             	add    $0x10,%esp
  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
 6e5:	50                   	push   %eax
 6e6:	68 4b 10 00 00       	push   $0x104b
 6eb:	57                   	push   %edi
 6ec:	56                   	push   %esi
 6ed:	e8 92 fe ff ff       	call   584 <peek>
 6f2:	83 c4 10             	add    $0x10,%esp
 6f5:	85 c0                	test   %eax,%eax
 6f7:	75 5b                	jne    754 <parseexec+0xcc>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
 6f9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 6fc:	50                   	push   %eax
 6fd:	8d 45 e0             	lea    -0x20(%ebp),%eax
 700:	50                   	push   %eax
 701:	57                   	push   %edi
 702:	56                   	push   %esi
 703:	e8 38 fd ff ff       	call   440 <gettoken>
 708:	83 c4 10             	add    $0x10,%esp
 70b:	85 c0                	test   %eax,%eax
 70d:	74 45                	je     754 <parseexec+0xcc>
      break;
    if(tok != 'a')
 70f:	83 f8 61             	cmp    $0x61,%eax
 712:	75 62                	jne    776 <parseexec+0xee>
      panic("syntax");
    cmd->argv[argc] = q;
 714:	8b 45 e0             	mov    -0x20(%ebp),%eax
 717:	89 03                	mov    %eax,(%ebx)
    cmd->eargv[argc] = eq;
 719:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 71c:	89 43 28             	mov    %eax,0x28(%ebx)
    argc++;
 71f:	ff 45 d4             	incl   -0x2c(%ebp)
 722:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 725:	83 c3 04             	add    $0x4,%ebx
    if(argc >= MAXARGS)
 728:	83 f8 0a             	cmp    $0xa,%eax
 72b:	75 a7                	jne    6d4 <parseexec+0x4c>
      panic("too many args");
 72d:	83 ec 0c             	sub    $0xc,%esp
 730:	68 3d 10 00 00       	push   $0x103d
 735:	e8 0e fa ff ff       	call   148 <panic>
 73a:	66 90                	xchg   %ax,%ax
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
    return parseblock(ps, es);
 73c:	83 ec 08             	sub    $0x8,%esp
 73f:	57                   	push   %edi
 740:	56                   	push   %esi
 741:	e8 3a 01 00 00       	call   880 <parseblock>
 746:	83 c4 10             	add    $0x10,%esp
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
 749:	8d 65 f4             	lea    -0xc(%ebp),%esp
 74c:	5b                   	pop    %ebx
 74d:	5e                   	pop    %esi
 74e:	5f                   	pop    %edi
 74f:	5d                   	pop    %ebp
 750:	c3                   	ret    
 751:	8d 76 00             	lea    0x0(%esi),%esi
 754:	8b 45 cc             	mov    -0x34(%ebp),%eax
 757:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 75a:	8d 04 90             	lea    (%eax,%edx,4),%eax
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
 75d:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  cmd->eargv[argc] = 0;
 764:	c7 40 2c 00 00 00 00 	movl   $0x0,0x2c(%eax)
 76b:	8b 45 d0             	mov    -0x30(%ebp),%eax
  return ret;
}
 76e:	8d 65 f4             	lea    -0xc(%ebp),%esp
 771:	5b                   	pop    %ebx
 772:	5e                   	pop    %esi
 773:	5f                   	pop    %edi
 774:	5d                   	pop    %ebp
 775:	c3                   	ret    
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
    if(tok != 'a')
      panic("syntax");
 776:	83 ec 0c             	sub    $0xc,%esp
 779:	68 36 10 00 00       	push   $0x1036
 77e:	e8 c5 f9 ff ff       	call   148 <panic>
 783:	90                   	nop

00000784 <parsepipe>:
  return cmd;
}

struct cmd*
parsepipe(char **ps, char *es)
{
 784:	55                   	push   %ebp
 785:	89 e5                	mov    %esp,%ebp
 787:	57                   	push   %edi
 788:	56                   	push   %esi
 789:	53                   	push   %ebx
 78a:	83 ec 14             	sub    $0x14,%esp
 78d:	8b 5d 08             	mov    0x8(%ebp),%ebx
 790:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct cmd *cmd;

  cmd = parseexec(ps, es);
 793:	56                   	push   %esi
 794:	53                   	push   %ebx
 795:	e8 ee fe ff ff       	call   688 <parseexec>
 79a:	89 c7                	mov    %eax,%edi
  if(peek(ps, es, "|")){
 79c:	83 c4 0c             	add    $0xc,%esp
 79f:	68 50 10 00 00       	push   $0x1050
 7a4:	56                   	push   %esi
 7a5:	53                   	push   %ebx
 7a6:	e8 d9 fd ff ff       	call   584 <peek>
 7ab:	83 c4 10             	add    $0x10,%esp
 7ae:	85 c0                	test   %eax,%eax
 7b0:	75 0a                	jne    7bc <parsepipe+0x38>
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
  }
  return cmd;
}
 7b2:	89 f8                	mov    %edi,%eax
 7b4:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7b7:	5b                   	pop    %ebx
 7b8:	5e                   	pop    %esi
 7b9:	5f                   	pop    %edi
 7ba:	5d                   	pop    %ebp
 7bb:	c3                   	ret    
{
  struct cmd *cmd;

  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
 7bc:	6a 00                	push   $0x0
 7be:	6a 00                	push   $0x0
 7c0:	56                   	push   %esi
 7c1:	53                   	push   %ebx
 7c2:	e8 79 fc ff ff       	call   440 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
 7c7:	58                   	pop    %eax
 7c8:	5a                   	pop    %edx
 7c9:	56                   	push   %esi
 7ca:	53                   	push   %ebx
 7cb:	e8 b4 ff ff ff       	call   784 <parsepipe>
 7d0:	83 c4 10             	add    $0x10,%esp
 7d3:	89 45 0c             	mov    %eax,0xc(%ebp)
 7d6:	89 7d 08             	mov    %edi,0x8(%ebp)
  }
  return cmd;
}
 7d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7dc:	5b                   	pop    %ebx
 7dd:	5e                   	pop    %esi
 7de:	5f                   	pop    %edi
 7df:	5d                   	pop    %ebp
  struct cmd *cmd;

  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
 7e0:	e9 bb fb ff ff       	jmp    3a0 <pipecmd>
 7e5:	8d 76 00             	lea    0x0(%esi),%esi

000007e8 <parseline>:
  return cmd;
}

struct cmd*
parseline(char **ps, char *es)
{
 7e8:	55                   	push   %ebp
 7e9:	89 e5                	mov    %esp,%ebp
 7eb:	57                   	push   %edi
 7ec:	56                   	push   %esi
 7ed:	53                   	push   %ebx
 7ee:	83 ec 14             	sub    $0x14,%esp
 7f1:	8b 5d 08             	mov    0x8(%ebp),%ebx
 7f4:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
 7f7:	56                   	push   %esi
 7f8:	53                   	push   %ebx
 7f9:	e8 86 ff ff ff       	call   784 <parsepipe>
 7fe:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
 800:	83 c4 10             	add    $0x10,%esp
 803:	eb 1b                	jmp    820 <parseline+0x38>
 805:	8d 76 00             	lea    0x0(%esi),%esi
    gettoken(ps, es, 0, 0);
 808:	6a 00                	push   $0x0
 80a:	6a 00                	push   $0x0
 80c:	56                   	push   %esi
 80d:	53                   	push   %ebx
 80e:	e8 2d fc ff ff       	call   440 <gettoken>
    cmd = backcmd(cmd);
 813:	89 3c 24             	mov    %edi,(%esp)
 816:	e8 f5 fb ff ff       	call   410 <backcmd>
 81b:	89 c7                	mov    %eax,%edi
 81d:	83 c4 10             	add    $0x10,%esp
parseline(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
  while(peek(ps, es, "&")){
 820:	50                   	push   %eax
 821:	68 52 10 00 00       	push   $0x1052
 826:	56                   	push   %esi
 827:	53                   	push   %ebx
 828:	e8 57 fd ff ff       	call   584 <peek>
 82d:	83 c4 10             	add    $0x10,%esp
 830:	85 c0                	test   %eax,%eax
 832:	75 d4                	jne    808 <parseline+0x20>
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
 834:	51                   	push   %ecx
 835:	68 4e 10 00 00       	push   $0x104e
 83a:	56                   	push   %esi
 83b:	53                   	push   %ebx
 83c:	e8 43 fd ff ff       	call   584 <peek>
 841:	83 c4 10             	add    $0x10,%esp
 844:	85 c0                	test   %eax,%eax
 846:	75 0c                	jne    854 <parseline+0x6c>
    gettoken(ps, es, 0, 0);
    cmd = listcmd(cmd, parseline(ps, es));
  }
  return cmd;
}
 848:	89 f8                	mov    %edi,%eax
 84a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 84d:	5b                   	pop    %ebx
 84e:	5e                   	pop    %esi
 84f:	5f                   	pop    %edi
 850:	5d                   	pop    %ebp
 851:	c3                   	ret    
 852:	66 90                	xchg   %ax,%ax
  while(peek(ps, es, "&")){
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
    gettoken(ps, es, 0, 0);
 854:	6a 00                	push   $0x0
 856:	6a 00                	push   $0x0
 858:	56                   	push   %esi
 859:	53                   	push   %ebx
 85a:	e8 e1 fb ff ff       	call   440 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
 85f:	58                   	pop    %eax
 860:	5a                   	pop    %edx
 861:	56                   	push   %esi
 862:	53                   	push   %ebx
 863:	e8 80 ff ff ff       	call   7e8 <parseline>
 868:	83 c4 10             	add    $0x10,%esp
 86b:	89 45 0c             	mov    %eax,0xc(%ebp)
 86e:	89 7d 08             	mov    %edi,0x8(%ebp)
  }
  return cmd;
}
 871:	8d 65 f4             	lea    -0xc(%ebp),%esp
 874:	5b                   	pop    %ebx
 875:	5e                   	pop    %esi
 876:	5f                   	pop    %edi
 877:	5d                   	pop    %ebp
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
    gettoken(ps, es, 0, 0);
    cmd = listcmd(cmd, parseline(ps, es));
 878:	e9 5b fb ff ff       	jmp    3d8 <listcmd>
 87d:	8d 76 00             	lea    0x0(%esi),%esi

00000880 <parseblock>:
  return cmd;
}

struct cmd*
parseblock(char **ps, char *es)
{
 880:	55                   	push   %ebp
 881:	89 e5                	mov    %esp,%ebp
 883:	57                   	push   %edi
 884:	56                   	push   %esi
 885:	53                   	push   %ebx
 886:	83 ec 10             	sub    $0x10,%esp
 889:	8b 5d 08             	mov    0x8(%ebp),%ebx
 88c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct cmd *cmd;

  if(!peek(ps, es, "("))
 88f:	68 34 10 00 00       	push   $0x1034
 894:	56                   	push   %esi
 895:	53                   	push   %ebx
 896:	e8 e9 fc ff ff       	call   584 <peek>
 89b:	83 c4 10             	add    $0x10,%esp
 89e:	85 c0                	test   %eax,%eax
 8a0:	74 4a                	je     8ec <parseblock+0x6c>
    panic("parseblock");
  gettoken(ps, es, 0, 0);
 8a2:	6a 00                	push   $0x0
 8a4:	6a 00                	push   $0x0
 8a6:	56                   	push   %esi
 8a7:	53                   	push   %ebx
 8a8:	e8 93 fb ff ff       	call   440 <gettoken>
  cmd = parseline(ps, es);
 8ad:	58                   	pop    %eax
 8ae:	5a                   	pop    %edx
 8af:	56                   	push   %esi
 8b0:	53                   	push   %ebx
 8b1:	e8 32 ff ff ff       	call   7e8 <parseline>
 8b6:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
 8b8:	83 c4 0c             	add    $0xc,%esp
 8bb:	68 70 10 00 00       	push   $0x1070
 8c0:	56                   	push   %esi
 8c1:	53                   	push   %ebx
 8c2:	e8 bd fc ff ff       	call   584 <peek>
 8c7:	83 c4 10             	add    $0x10,%esp
 8ca:	85 c0                	test   %eax,%eax
 8cc:	74 2b                	je     8f9 <parseblock+0x79>
    panic("syntax - missing )");
  gettoken(ps, es, 0, 0);
 8ce:	6a 00                	push   $0x0
 8d0:	6a 00                	push   $0x0
 8d2:	56                   	push   %esi
 8d3:	53                   	push   %ebx
 8d4:	e8 67 fb ff ff       	call   440 <gettoken>
  cmd = parseredirs(cmd, ps, es);
 8d9:	83 c4 0c             	add    $0xc,%esp
 8dc:	56                   	push   %esi
 8dd:	53                   	push   %ebx
 8de:	57                   	push   %edi
 8df:	e8 08 fd ff ff       	call   5ec <parseredirs>
  return cmd;
}
 8e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8e7:	5b                   	pop    %ebx
 8e8:	5e                   	pop    %esi
 8e9:	5f                   	pop    %edi
 8ea:	5d                   	pop    %ebp
 8eb:	c3                   	ret    
parseblock(char **ps, char *es)
{
  struct cmd *cmd;

  if(!peek(ps, es, "("))
    panic("parseblock");
 8ec:	83 ec 0c             	sub    $0xc,%esp
 8ef:	68 54 10 00 00       	push   $0x1054
 8f4:	e8 4f f8 ff ff       	call   148 <panic>
  gettoken(ps, es, 0, 0);
  cmd = parseline(ps, es);
  if(!peek(ps, es, ")"))
    panic("syntax - missing )");
 8f9:	83 ec 0c             	sub    $0xc,%esp
 8fc:	68 5f 10 00 00       	push   $0x105f
 901:	e8 42 f8 ff ff       	call   148 <panic>
 906:	66 90                	xchg   %ax,%ax

00000908 <nulterminate>:
}

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
 908:	55                   	push   %ebp
 909:	89 e5                	mov    %esp,%ebp
 90b:	53                   	push   %ebx
 90c:	53                   	push   %ebx
 90d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
 910:	85 db                	test   %ebx,%ebx
 912:	0f 84 88 00 00 00    	je     9a0 <nulterminate+0x98>
    return 0;

  switch(cmd->type){
 918:	83 3b 05             	cmpl   $0x5,(%ebx)
 91b:	77 46                	ja     963 <nulterminate+0x5b>
 91d:	8b 03                	mov    (%ebx),%eax
 91f:	ff 24 85 b0 10 00 00 	jmp    *0x10b0(,%eax,4)
 926:	66 90                	xchg   %ax,%ax
    nulterminate(pcmd->right);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
 928:	83 ec 0c             	sub    $0xc,%esp
 92b:	ff 73 04             	pushl  0x4(%ebx)
 92e:	e8 d5 ff ff ff       	call   908 <nulterminate>
    nulterminate(lcmd->right);
 933:	58                   	pop    %eax
 934:	ff 73 08             	pushl  0x8(%ebx)
 937:	e8 cc ff ff ff       	call   908 <nulterminate>
    break;
 93c:	83 c4 10             	add    $0x10,%esp
 93f:	89 d8                	mov    %ebx,%eax
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
 941:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 944:	c9                   	leave  
 945:	c3                   	ret    
 946:	66 90                	xchg   %ax,%ax
 948:	8d 43 2c             	lea    0x2c(%ebx),%eax
    return 0;

  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
 94b:	8b 4b 04             	mov    0x4(%ebx),%ecx
 94e:	85 c9                	test   %ecx,%ecx
 950:	74 11                	je     963 <nulterminate+0x5b>
 952:	66 90                	xchg   %ax,%ax
      *ecmd->eargv[i] = 0;
 954:	8b 10                	mov    (%eax),%edx
 956:	c6 02 00             	movb   $0x0,(%edx)
 959:	83 c0 04             	add    $0x4,%eax
    return 0;

  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
 95c:	8b 50 d8             	mov    -0x28(%eax),%edx
 95f:	85 d2                	test   %edx,%edx
 961:	75 f1                	jne    954 <nulterminate+0x4c>
  struct redircmd *rcmd;

  if(cmd == 0)
    return 0;

  switch(cmd->type){
 963:	89 d8                	mov    %ebx,%eax
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
 965:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 968:	c9                   	leave  
 969:	c3                   	ret    
 96a:	66 90                	xchg   %ax,%ax
    nulterminate(lcmd->right);
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
 96c:	83 ec 0c             	sub    $0xc,%esp
 96f:	ff 73 04             	pushl  0x4(%ebx)
 972:	e8 91 ff ff ff       	call   908 <nulterminate>
    break;
 977:	83 c4 10             	add    $0x10,%esp
 97a:	89 d8                	mov    %ebx,%eax
  }
  return cmd;
}
 97c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 97f:	c9                   	leave  
 980:	c3                   	ret    
 981:	8d 76 00             	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
 984:	83 ec 0c             	sub    $0xc,%esp
 987:	ff 73 04             	pushl  0x4(%ebx)
 98a:	e8 79 ff ff ff       	call   908 <nulterminate>
    *rcmd->efile = 0;
 98f:	8b 43 0c             	mov    0xc(%ebx),%eax
 992:	c6 00 00             	movb   $0x0,(%eax)
    break;
 995:	83 c4 10             	add    $0x10,%esp
 998:	89 d8                	mov    %ebx,%eax
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
 99a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 99d:	c9                   	leave  
 99e:	c3                   	ret    
 99f:	90                   	nop
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
    return 0;
 9a0:	31 c0                	xor    %eax,%eax
 9a2:	eb 9d                	jmp    941 <nulterminate+0x39>

000009a4 <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
 9a4:	55                   	push   %ebp
 9a5:	89 e5                	mov    %esp,%ebp
 9a7:	56                   	push   %esi
 9a8:	53                   	push   %ebx
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
 9a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
 9ac:	83 ec 0c             	sub    $0xc,%esp
 9af:	53                   	push   %ebx
 9b0:	e8 b3 00 00 00       	call   a68 <strlen>
 9b5:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
 9b7:	59                   	pop    %ecx
 9b8:	5e                   	pop    %esi
 9b9:	53                   	push   %ebx
 9ba:	8d 45 08             	lea    0x8(%ebp),%eax
 9bd:	50                   	push   %eax
 9be:	e8 25 fe ff ff       	call   7e8 <parseline>
 9c3:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
 9c5:	83 c4 0c             	add    $0xc,%esp
 9c8:	68 f9 0f 00 00       	push   $0xff9
 9cd:	53                   	push   %ebx
 9ce:	8d 45 08             	lea    0x8(%ebp),%eax
 9d1:	50                   	push   %eax
 9d2:	e8 ad fb ff ff       	call   584 <peek>
  if(s != es){
 9d7:	8b 45 08             	mov    0x8(%ebp),%eax
 9da:	83 c4 10             	add    $0x10,%esp
 9dd:	39 c3                	cmp    %eax,%ebx
 9df:	75 12                	jne    9f3 <parsecmd+0x4f>
    printf(2, "leftovers: %s\n", s);
    panic("syntax");
  }
  nulterminate(cmd);
 9e1:	83 ec 0c             	sub    $0xc,%esp
 9e4:	56                   	push   %esi
 9e5:	e8 1e ff ff ff       	call   908 <nulterminate>
  return cmd;
}
 9ea:	89 f0                	mov    %esi,%eax
 9ec:	8d 65 f8             	lea    -0x8(%ebp),%esp
 9ef:	5b                   	pop    %ebx
 9f0:	5e                   	pop    %esi
 9f1:	5d                   	pop    %ebp
 9f2:	c3                   	ret    

  es = s + strlen(s);
  cmd = parseline(&s, es);
  peek(&s, es, "");
  if(s != es){
    printf(2, "leftovers: %s\n", s);
 9f3:	52                   	push   %edx
 9f4:	50                   	push   %eax
 9f5:	68 72 10 00 00       	push   $0x1072
 9fa:	6a 02                	push   $0x2
 9fc:	e8 df 02 00 00       	call   ce0 <printf>
    panic("syntax");
 a01:	c7 04 24 36 10 00 00 	movl   $0x1036,(%esp)
 a08:	e8 3b f7 ff ff       	call   148 <panic>
 a0d:	66 90                	xchg   %ax,%ax
 a0f:	90                   	nop

00000a10 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 a10:	55                   	push   %ebp
 a11:	89 e5                	mov    %esp,%ebp
 a13:	53                   	push   %ebx
 a14:	8b 45 08             	mov    0x8(%ebp),%eax
 a17:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 a1a:	89 c2                	mov    %eax,%edx
 a1c:	42                   	inc    %edx
 a1d:	41                   	inc    %ecx
 a1e:	8a 59 ff             	mov    -0x1(%ecx),%bl
 a21:	88 5a ff             	mov    %bl,-0x1(%edx)
 a24:	84 db                	test   %bl,%bl
 a26:	75 f4                	jne    a1c <strcpy+0xc>
    ;
  return os;
}
 a28:	5b                   	pop    %ebx
 a29:	5d                   	pop    %ebp
 a2a:	c3                   	ret    
 a2b:	90                   	nop

00000a2c <strcmp>:

int
strcmp(const char *p, const char *q)
{
 a2c:	55                   	push   %ebp
 a2d:	89 e5                	mov    %esp,%ebp
 a2f:	56                   	push   %esi
 a30:	53                   	push   %ebx
 a31:	8b 55 08             	mov    0x8(%ebp),%edx
 a34:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 a37:	0f b6 02             	movzbl (%edx),%eax
 a3a:	0f b6 0b             	movzbl (%ebx),%ecx
 a3d:	84 c0                	test   %al,%al
 a3f:	75 14                	jne    a55 <strcmp+0x29>
 a41:	eb 1d                	jmp    a60 <strcmp+0x34>
 a43:	90                   	nop
    p++, q++;
 a44:	42                   	inc    %edx
 a45:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 a48:	0f b6 02             	movzbl (%edx),%eax
 a4b:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 a4f:	84 c0                	test   %al,%al
 a51:	74 0d                	je     a60 <strcmp+0x34>
 a53:	89 f3                	mov    %esi,%ebx
 a55:	38 c8                	cmp    %cl,%al
 a57:	74 eb                	je     a44 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 a59:	29 c8                	sub    %ecx,%eax
}
 a5b:	5b                   	pop    %ebx
 a5c:	5e                   	pop    %esi
 a5d:	5d                   	pop    %ebp
 a5e:	c3                   	ret    
 a5f:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 a60:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 a62:	29 c8                	sub    %ecx,%eax
}
 a64:	5b                   	pop    %ebx
 a65:	5e                   	pop    %esi
 a66:	5d                   	pop    %ebp
 a67:	c3                   	ret    

00000a68 <strlen>:

uint
strlen(const char *s)
{
 a68:	55                   	push   %ebp
 a69:	89 e5                	mov    %esp,%ebp
 a6b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 a6e:	80 39 00             	cmpb   $0x0,(%ecx)
 a71:	74 10                	je     a83 <strlen+0x1b>
 a73:	31 d2                	xor    %edx,%edx
 a75:	8d 76 00             	lea    0x0(%esi),%esi
 a78:	42                   	inc    %edx
 a79:	89 d0                	mov    %edx,%eax
 a7b:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 a7f:	75 f7                	jne    a78 <strlen+0x10>
    ;
  return n;
}
 a81:	5d                   	pop    %ebp
 a82:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 a83:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 a85:	5d                   	pop    %ebp
 a86:	c3                   	ret    
 a87:	90                   	nop

00000a88 <memset>:

void*
memset(void *dst, int c, uint n)
{
 a88:	55                   	push   %ebp
 a89:	89 e5                	mov    %esp,%ebp
 a8b:	57                   	push   %edi
 a8c:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 a8f:	89 d7                	mov    %edx,%edi
 a91:	8b 4d 10             	mov    0x10(%ebp),%ecx
 a94:	8b 45 0c             	mov    0xc(%ebp),%eax
 a97:	fc                   	cld    
 a98:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 a9a:	89 d0                	mov    %edx,%eax
 a9c:	5f                   	pop    %edi
 a9d:	5d                   	pop    %ebp
 a9e:	c3                   	ret    
 a9f:	90                   	nop

00000aa0 <strchr>:

char*
strchr(const char *s, char c)
{
 aa0:	55                   	push   %ebp
 aa1:	89 e5                	mov    %esp,%ebp
 aa3:	53                   	push   %ebx
 aa4:	8b 45 08             	mov    0x8(%ebp),%eax
 aa7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 aaa:	8a 10                	mov    (%eax),%dl
 aac:	84 d2                	test   %dl,%dl
 aae:	74 13                	je     ac3 <strchr+0x23>
 ab0:	88 d9                	mov    %bl,%cl
    if(*s == c)
 ab2:	38 d3                	cmp    %dl,%bl
 ab4:	75 06                	jne    abc <strchr+0x1c>
 ab6:	eb 0d                	jmp    ac5 <strchr+0x25>
 ab8:	38 ca                	cmp    %cl,%dl
 aba:	74 09                	je     ac5 <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 abc:	40                   	inc    %eax
 abd:	8a 10                	mov    (%eax),%dl
 abf:	84 d2                	test   %dl,%dl
 ac1:	75 f5                	jne    ab8 <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
 ac3:	31 c0                	xor    %eax,%eax
}
 ac5:	5b                   	pop    %ebx
 ac6:	5d                   	pop    %ebp
 ac7:	c3                   	ret    

00000ac8 <gets>:

char*
gets(char *buf, int max)
{
 ac8:	55                   	push   %ebp
 ac9:	89 e5                	mov    %esp,%ebp
 acb:	57                   	push   %edi
 acc:	56                   	push   %esi
 acd:	53                   	push   %ebx
 ace:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 ad1:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 ad3:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 ad6:	eb 26                	jmp    afe <gets+0x36>
    cc = read(0, &c, 1);
 ad8:	50                   	push   %eax
 ad9:	6a 01                	push   $0x1
 adb:	57                   	push   %edi
 adc:	6a 00                	push   $0x0
 ade:	e8 f0 00 00 00       	call   bd3 <read>
    if(cc < 1)
 ae3:	83 c4 10             	add    $0x10,%esp
 ae6:	85 c0                	test   %eax,%eax
 ae8:	7e 1c                	jle    b06 <gets+0x3e>
      break;
    buf[i++] = c;
 aea:	8a 45 e7             	mov    -0x19(%ebp),%al
 aed:	8b 55 08             	mov    0x8(%ebp),%edx
 af0:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 af4:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 af6:	3c 0a                	cmp    $0xa,%al
 af8:	74 0c                	je     b06 <gets+0x3e>
 afa:	3c 0d                	cmp    $0xd,%al
 afc:	74 08                	je     b06 <gets+0x3e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 afe:	8d 5e 01             	lea    0x1(%esi),%ebx
 b01:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 b04:	7c d2                	jl     ad8 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 b06:	8b 45 08             	mov    0x8(%ebp),%eax
 b09:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 b0d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 b10:	5b                   	pop    %ebx
 b11:	5e                   	pop    %esi
 b12:	5f                   	pop    %edi
 b13:	5d                   	pop    %ebp
 b14:	c3                   	ret    
 b15:	8d 76 00             	lea    0x0(%esi),%esi

00000b18 <stat>:

int
stat(const char *n, struct stat *st)
{
 b18:	55                   	push   %ebp
 b19:	89 e5                	mov    %esp,%ebp
 b1b:	56                   	push   %esi
 b1c:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 b1d:	83 ec 08             	sub    $0x8,%esp
 b20:	6a 00                	push   $0x0
 b22:	ff 75 08             	pushl  0x8(%ebp)
 b25:	e8 d1 00 00 00       	call   bfb <open>
  if(fd < 0)
 b2a:	83 c4 10             	add    $0x10,%esp
 b2d:	85 c0                	test   %eax,%eax
 b2f:	78 27                	js     b58 <stat+0x40>
 b31:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 b33:	83 ec 08             	sub    $0x8,%esp
 b36:	ff 75 0c             	pushl  0xc(%ebp)
 b39:	50                   	push   %eax
 b3a:	e8 d4 00 00 00       	call   c13 <fstat>
 b3f:	89 c6                	mov    %eax,%esi
  close(fd);
 b41:	89 1c 24             	mov    %ebx,(%esp)
 b44:	e8 9a 00 00 00       	call   be3 <close>
  return r;
 b49:	83 c4 10             	add    $0x10,%esp
 b4c:	89 f0                	mov    %esi,%eax
}
 b4e:	8d 65 f8             	lea    -0x8(%ebp),%esp
 b51:	5b                   	pop    %ebx
 b52:	5e                   	pop    %esi
 b53:	5d                   	pop    %ebp
 b54:	c3                   	ret    
 b55:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 b58:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 b5d:	eb ef                	jmp    b4e <stat+0x36>
 b5f:	90                   	nop

00000b60 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 b60:	55                   	push   %ebp
 b61:	89 e5                	mov    %esp,%ebp
 b63:	53                   	push   %ebx
 b64:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 b67:	0f be 11             	movsbl (%ecx),%edx
 b6a:	8d 42 d0             	lea    -0x30(%edx),%eax
 b6d:	3c 09                	cmp    $0x9,%al
 b6f:	b8 00 00 00 00       	mov    $0x0,%eax
 b74:	77 15                	ja     b8b <atoi+0x2b>
 b76:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 b78:	41                   	inc    %ecx
 b79:	8d 04 80             	lea    (%eax,%eax,4),%eax
 b7c:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 b80:	0f be 11             	movsbl (%ecx),%edx
 b83:	8d 5a d0             	lea    -0x30(%edx),%ebx
 b86:	80 fb 09             	cmp    $0x9,%bl
 b89:	76 ed                	jbe    b78 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 b8b:	5b                   	pop    %ebx
 b8c:	5d                   	pop    %ebp
 b8d:	c3                   	ret    
 b8e:	66 90                	xchg   %ax,%ax

00000b90 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 b90:	55                   	push   %ebp
 b91:	89 e5                	mov    %esp,%ebp
 b93:	56                   	push   %esi
 b94:	53                   	push   %ebx
 b95:	8b 45 08             	mov    0x8(%ebp),%eax
 b98:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 b9b:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 b9e:	85 f6                	test   %esi,%esi
 ba0:	7e 0d                	jle    baf <memmove+0x1f>
 ba2:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
 ba4:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 ba7:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 baa:	42                   	inc    %edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 bab:	39 f2                	cmp    %esi,%edx
 bad:	75 f5                	jne    ba4 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 baf:	5b                   	pop    %ebx
 bb0:	5e                   	pop    %esi
 bb1:	5d                   	pop    %ebp
 bb2:	c3                   	ret    

00000bb3 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 bb3:	b8 01 00 00 00       	mov    $0x1,%eax
 bb8:	cd 40                	int    $0x40
 bba:	c3                   	ret    

00000bbb <exit>:
SYSCALL(exit)
 bbb:	b8 02 00 00 00       	mov    $0x2,%eax
 bc0:	cd 40                	int    $0x40
 bc2:	c3                   	ret    

00000bc3 <wait>:
SYSCALL(wait)
 bc3:	b8 03 00 00 00       	mov    $0x3,%eax
 bc8:	cd 40                	int    $0x40
 bca:	c3                   	ret    

00000bcb <pipe>:
SYSCALL(pipe)
 bcb:	b8 04 00 00 00       	mov    $0x4,%eax
 bd0:	cd 40                	int    $0x40
 bd2:	c3                   	ret    

00000bd3 <read>:
SYSCALL(read)
 bd3:	b8 05 00 00 00       	mov    $0x5,%eax
 bd8:	cd 40                	int    $0x40
 bda:	c3                   	ret    

00000bdb <write>:
SYSCALL(write)
 bdb:	b8 10 00 00 00       	mov    $0x10,%eax
 be0:	cd 40                	int    $0x40
 be2:	c3                   	ret    

00000be3 <close>:
SYSCALL(close)
 be3:	b8 15 00 00 00       	mov    $0x15,%eax
 be8:	cd 40                	int    $0x40
 bea:	c3                   	ret    

00000beb <kill>:
SYSCALL(kill)
 beb:	b8 06 00 00 00       	mov    $0x6,%eax
 bf0:	cd 40                	int    $0x40
 bf2:	c3                   	ret    

00000bf3 <exec>:
SYSCALL(exec)
 bf3:	b8 07 00 00 00       	mov    $0x7,%eax
 bf8:	cd 40                	int    $0x40
 bfa:	c3                   	ret    

00000bfb <open>:
SYSCALL(open)
 bfb:	b8 0f 00 00 00       	mov    $0xf,%eax
 c00:	cd 40                	int    $0x40
 c02:	c3                   	ret    

00000c03 <mknod>:
SYSCALL(mknod)
 c03:	b8 11 00 00 00       	mov    $0x11,%eax
 c08:	cd 40                	int    $0x40
 c0a:	c3                   	ret    

00000c0b <unlink>:
SYSCALL(unlink)
 c0b:	b8 12 00 00 00       	mov    $0x12,%eax
 c10:	cd 40                	int    $0x40
 c12:	c3                   	ret    

00000c13 <fstat>:
SYSCALL(fstat)
 c13:	b8 08 00 00 00       	mov    $0x8,%eax
 c18:	cd 40                	int    $0x40
 c1a:	c3                   	ret    

00000c1b <link>:
SYSCALL(link)
 c1b:	b8 13 00 00 00       	mov    $0x13,%eax
 c20:	cd 40                	int    $0x40
 c22:	c3                   	ret    

00000c23 <mkdir>:
SYSCALL(mkdir)
 c23:	b8 14 00 00 00       	mov    $0x14,%eax
 c28:	cd 40                	int    $0x40
 c2a:	c3                   	ret    

00000c2b <chdir>:
SYSCALL(chdir)
 c2b:	b8 09 00 00 00       	mov    $0x9,%eax
 c30:	cd 40                	int    $0x40
 c32:	c3                   	ret    

00000c33 <dup>:
SYSCALL(dup)
 c33:	b8 0a 00 00 00       	mov    $0xa,%eax
 c38:	cd 40                	int    $0x40
 c3a:	c3                   	ret    

00000c3b <getpid>:
SYSCALL(getpid)
 c3b:	b8 0b 00 00 00       	mov    $0xb,%eax
 c40:	cd 40                	int    $0x40
 c42:	c3                   	ret    

00000c43 <sbrk>:
SYSCALL(sbrk)
 c43:	b8 0c 00 00 00       	mov    $0xc,%eax
 c48:	cd 40                	int    $0x40
 c4a:	c3                   	ret    

00000c4b <sleep>:
SYSCALL(sleep)
 c4b:	b8 0d 00 00 00       	mov    $0xd,%eax
 c50:	cd 40                	int    $0x40
 c52:	c3                   	ret    

00000c53 <uptime>:
SYSCALL(uptime)
 c53:	b8 0e 00 00 00       	mov    $0xe,%eax
 c58:	cd 40                	int    $0x40
 c5a:	c3                   	ret    
 c5b:	90                   	nop

00000c5c <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 c5c:	55                   	push   %ebp
 c5d:	89 e5                	mov    %esp,%ebp
 c5f:	57                   	push   %edi
 c60:	56                   	push   %esi
 c61:	53                   	push   %ebx
 c62:	83 ec 3c             	sub    $0x3c,%esp
 c65:	89 c6                	mov    %eax,%esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 c67:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 c69:	8b 5d 08             	mov    0x8(%ebp),%ebx
 c6c:	85 db                	test   %ebx,%ebx
 c6e:	74 04                	je     c74 <printint+0x18>
 c70:	85 d2                	test   %edx,%edx
 c72:	78 5f                	js     cd3 <printint+0x77>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 c74:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 c7b:	31 ff                	xor    %edi,%edi
 c7d:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 c80:	89 75 c4             	mov    %esi,-0x3c(%ebp)
 c83:	89 ce                	mov    %ecx,%esi
 c85:	eb 03                	jmp    c8a <printint+0x2e>
 c87:	90                   	nop
  do{
    buf[i++] = digits[x % base];
 c88:	89 cf                	mov    %ecx,%edi
 c8a:	8d 4f 01             	lea    0x1(%edi),%ecx
 c8d:	31 d2                	xor    %edx,%edx
 c8f:	f7 f6                	div    %esi
 c91:	8a 92 d0 10 00 00    	mov    0x10d0(%edx),%dl
 c97:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 c9a:	85 c0                	test   %eax,%eax
 c9c:	75 ea                	jne    c88 <printint+0x2c>
 c9e:	8b 75 c4             	mov    -0x3c(%ebp),%esi
  if(neg)
 ca1:	8b 55 c0             	mov    -0x40(%ebp),%edx
 ca4:	85 d2                	test   %edx,%edx
 ca6:	74 08                	je     cb0 <printint+0x54>
    buf[i++] = '-';
 ca8:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 cad:	8d 4f 02             	lea    0x2(%edi),%ecx
 cb0:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 cb4:	8a 07                	mov    (%edi),%al
 cb6:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 cb9:	50                   	push   %eax
 cba:	6a 01                	push   $0x1
 cbc:	53                   	push   %ebx
 cbd:	56                   	push   %esi
 cbe:	e8 18 ff ff ff       	call   bdb <write>
 cc3:	4f                   	dec    %edi
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 cc4:	83 c4 10             	add    $0x10,%esp
 cc7:	39 df                	cmp    %ebx,%edi
 cc9:	75 e9                	jne    cb4 <printint+0x58>
    putc(fd, buf[i]);
}
 ccb:	8d 65 f4             	lea    -0xc(%ebp),%esp
 cce:	5b                   	pop    %ebx
 ccf:	5e                   	pop    %esi
 cd0:	5f                   	pop    %edi
 cd1:	5d                   	pop    %ebp
 cd2:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 cd3:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 cd5:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 cdc:	eb 9d                	jmp    c7b <printint+0x1f>
 cde:	66 90                	xchg   %ax,%ax

00000ce0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 ce0:	55                   	push   %ebp
 ce1:	89 e5                	mov    %esp,%ebp
 ce3:	57                   	push   %edi
 ce4:	56                   	push   %esi
 ce5:	53                   	push   %ebx
 ce6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 ce9:	8b 75 0c             	mov    0xc(%ebp),%esi
 cec:	8a 1e                	mov    (%esi),%bl
 cee:	84 db                	test   %bl,%bl
 cf0:	0f 84 a6 00 00 00    	je     d9c <printf+0xbc>
 cf6:	46                   	inc    %esi
 cf7:	8d 45 10             	lea    0x10(%ebp),%eax
 cfa:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 cfd:	31 ff                	xor    %edi,%edi
 cff:	eb 29                	jmp    d2a <printf+0x4a>
 d01:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 d04:	83 f8 25             	cmp    $0x25,%eax
 d07:	0f 84 97 00 00 00    	je     da4 <printf+0xc4>
 d0d:	88 5d e2             	mov    %bl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 d10:	50                   	push   %eax
 d11:	6a 01                	push   $0x1
 d13:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 d16:	50                   	push   %eax
 d17:	ff 75 08             	pushl  0x8(%ebp)
 d1a:	e8 bc fe ff ff       	call   bdb <write>
 d1f:	83 c4 10             	add    $0x10,%esp
 d22:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 d23:	8a 5e ff             	mov    -0x1(%esi),%bl
 d26:	84 db                	test   %bl,%bl
 d28:	74 72                	je     d9c <printf+0xbc>
    c = fmt[i] & 0xff;
 d2a:	0f be cb             	movsbl %bl,%ecx
 d2d:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 d30:	85 ff                	test   %edi,%edi
 d32:	74 d0                	je     d04 <printf+0x24>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 d34:	83 ff 25             	cmp    $0x25,%edi
 d37:	75 e9                	jne    d22 <printf+0x42>
      if(c == 'd'){
 d39:	83 f8 64             	cmp    $0x64,%eax
 d3c:	0f 84 f6 00 00 00    	je     e38 <printf+0x158>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 d42:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 d48:	83 f9 70             	cmp    $0x70,%ecx
 d4b:	74 63                	je     db0 <printf+0xd0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 d4d:	83 f8 73             	cmp    $0x73,%eax
 d50:	0f 84 86 00 00 00    	je     ddc <printf+0xfc>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 d56:	83 f8 63             	cmp    $0x63,%eax
 d59:	0f 84 be 00 00 00    	je     e1d <printf+0x13d>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 d5f:	83 f8 25             	cmp    $0x25,%eax
 d62:	0f 84 e0 00 00 00    	je     e48 <printf+0x168>
 d68:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 d6c:	50                   	push   %eax
 d6d:	6a 01                	push   $0x1
 d6f:	8d 45 e7             	lea    -0x19(%ebp),%eax
 d72:	50                   	push   %eax
 d73:	ff 75 08             	pushl  0x8(%ebp)
 d76:	e8 60 fe ff ff       	call   bdb <write>
 d7b:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 d7e:	83 c4 0c             	add    $0xc,%esp
 d81:	6a 01                	push   $0x1
 d83:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 d86:	50                   	push   %eax
 d87:	ff 75 08             	pushl  0x8(%ebp)
 d8a:	e8 4c fe ff ff       	call   bdb <write>
 d8f:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 d92:	31 ff                	xor    %edi,%edi
 d94:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 d95:	8a 5e ff             	mov    -0x1(%esi),%bl
 d98:	84 db                	test   %bl,%bl
 d9a:	75 8e                	jne    d2a <printf+0x4a>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 d9c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 d9f:	5b                   	pop    %ebx
 da0:	5e                   	pop    %esi
 da1:	5f                   	pop    %edi
 da2:	5d                   	pop    %ebp
 da3:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 da4:	bf 25 00 00 00       	mov    $0x25,%edi
 da9:	e9 74 ff ff ff       	jmp    d22 <printf+0x42>
 dae:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 db0:	83 ec 0c             	sub    $0xc,%esp
 db3:	6a 00                	push   $0x0
 db5:	b9 10 00 00 00       	mov    $0x10,%ecx
 dba:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 dbd:	8b 17                	mov    (%edi),%edx
 dbf:	8b 45 08             	mov    0x8(%ebp),%eax
 dc2:	e8 95 fe ff ff       	call   c5c <printint>
        ap++;
 dc7:	89 f8                	mov    %edi,%eax
 dc9:	83 c0 04             	add    $0x4,%eax
 dcc:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 dcf:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 dd2:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 dd4:	e9 49 ff ff ff       	jmp    d22 <printf+0x42>
 dd9:	8d 76 00             	lea    0x0(%esi),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 ddc:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 ddf:	8b 38                	mov    (%eax),%edi
        ap++;
 de1:	83 c0 04             	add    $0x4,%eax
 de4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 de7:	85 ff                	test   %edi,%edi
 de9:	74 6b                	je     e56 <printf+0x176>
          s = "(null)";
        while(*s != 0){
 deb:	8a 07                	mov    (%edi),%al
 ded:	84 c0                	test   %al,%al
 def:	74 6c                	je     e5d <printf+0x17d>
 df1:	8d 5d e3             	lea    -0x1d(%ebp),%ebx
 df4:	89 75 d0             	mov    %esi,-0x30(%ebp)
 df7:	89 fe                	mov    %edi,%esi
 df9:	8b 7d 08             	mov    0x8(%ebp),%edi
 dfc:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 dff:	50                   	push   %eax
 e00:	6a 01                	push   $0x1
 e02:	53                   	push   %ebx
 e03:	57                   	push   %edi
 e04:	e8 d2 fd ff ff       	call   bdb <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 e09:	46                   	inc    %esi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 e0a:	8a 06                	mov    (%esi),%al
 e0c:	83 c4 10             	add    $0x10,%esp
 e0f:	84 c0                	test   %al,%al
 e11:	75 e9                	jne    dfc <printf+0x11c>
 e13:	8b 75 d0             	mov    -0x30(%ebp),%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 e16:	31 ff                	xor    %edi,%edi
 e18:	e9 05 ff ff ff       	jmp    d22 <printf+0x42>
 e1d:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 e20:	8b 07                	mov    (%edi),%eax
 e22:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 e25:	51                   	push   %ecx
 e26:	6a 01                	push   $0x1
 e28:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 e2b:	50                   	push   %eax
 e2c:	ff 75 08             	pushl  0x8(%ebp)
 e2f:	e8 a7 fd ff ff       	call   bdb <write>
 e34:	eb 91                	jmp    dc7 <printf+0xe7>
 e36:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 e38:	83 ec 0c             	sub    $0xc,%esp
 e3b:	6a 01                	push   $0x1
 e3d:	b9 0a 00 00 00       	mov    $0xa,%ecx
 e42:	e9 73 ff ff ff       	jmp    dba <printf+0xda>
 e47:	90                   	nop
 e48:	88 5d e5             	mov    %bl,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 e4b:	52                   	push   %edx
 e4c:	6a 01                	push   $0x1
 e4e:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 e51:	e9 30 ff ff ff       	jmp    d86 <printf+0xa6>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
 e56:	bf c8 10 00 00       	mov    $0x10c8,%edi
 e5b:	eb 8e                	jmp    deb <printf+0x10b>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 e5d:	31 ff                	xor    %edi,%edi
 e5f:	e9 be fe ff ff       	jmp    d22 <printf+0x42>

00000e64 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 e64:	55                   	push   %ebp
 e65:	89 e5                	mov    %esp,%ebp
 e67:	57                   	push   %edi
 e68:	56                   	push   %esi
 e69:	53                   	push   %ebx
 e6a:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 e6d:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 e70:	a1 04 17 00 00       	mov    0x1704,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 e75:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 e77:	39 c8                	cmp    %ecx,%eax
 e79:	73 11                	jae    e8c <free+0x28>
 e7b:	90                   	nop
 e7c:	39 d1                	cmp    %edx,%ecx
 e7e:	72 14                	jb     e94 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 e80:	39 d0                	cmp    %edx,%eax
 e82:	73 10                	jae    e94 <free+0x30>
static Header base;
static Header *freep;

void
free(void *ap)
{
 e84:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 e86:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 e88:	39 c8                	cmp    %ecx,%eax
 e8a:	72 f0                	jb     e7c <free+0x18>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 e8c:	39 d0                	cmp    %edx,%eax
 e8e:	72 f4                	jb     e84 <free+0x20>
 e90:	39 d1                	cmp    %edx,%ecx
 e92:	73 f0                	jae    e84 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 e94:	8b 73 fc             	mov    -0x4(%ebx),%esi
 e97:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 e9a:	39 d7                	cmp    %edx,%edi
 e9c:	74 19                	je     eb7 <free+0x53>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 e9e:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 ea1:	8b 50 04             	mov    0x4(%eax),%edx
 ea4:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 ea7:	39 f1                	cmp    %esi,%ecx
 ea9:	74 23                	je     ece <free+0x6a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 eab:	89 08                	mov    %ecx,(%eax)
  freep = p;
 ead:	a3 04 17 00 00       	mov    %eax,0x1704
}
 eb2:	5b                   	pop    %ebx
 eb3:	5e                   	pop    %esi
 eb4:	5f                   	pop    %edi
 eb5:	5d                   	pop    %ebp
 eb6:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 eb7:	03 72 04             	add    0x4(%edx),%esi
 eba:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 ebd:	8b 10                	mov    (%eax),%edx
 ebf:	8b 12                	mov    (%edx),%edx
 ec1:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 ec4:	8b 50 04             	mov    0x4(%eax),%edx
 ec7:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 eca:	39 f1                	cmp    %esi,%ecx
 ecc:	75 dd                	jne    eab <free+0x47>
    p->s.size += bp->s.size;
 ece:	03 53 fc             	add    -0x4(%ebx),%edx
 ed1:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 ed4:	8b 53 f8             	mov    -0x8(%ebx),%edx
 ed7:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 ed9:	a3 04 17 00 00       	mov    %eax,0x1704
}
 ede:	5b                   	pop    %ebx
 edf:	5e                   	pop    %esi
 ee0:	5f                   	pop    %edi
 ee1:	5d                   	pop    %ebp
 ee2:	c3                   	ret    
 ee3:	90                   	nop

00000ee4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 ee4:	55                   	push   %ebp
 ee5:	89 e5                	mov    %esp,%ebp
 ee7:	57                   	push   %edi
 ee8:	56                   	push   %esi
 ee9:	53                   	push   %ebx
 eea:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 eed:	8b 45 08             	mov    0x8(%ebp),%eax
 ef0:	8d 78 07             	lea    0x7(%eax),%edi
 ef3:	c1 ef 03             	shr    $0x3,%edi
 ef6:	47                   	inc    %edi
  if((prevp = freep) == 0){
 ef7:	8b 15 04 17 00 00    	mov    0x1704,%edx
 efd:	85 d2                	test   %edx,%edx
 eff:	0f 84 b1 00 00 00    	je     fb6 <malloc+0xd2>
 f05:	8b 02                	mov    (%edx),%eax
 f07:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 f0a:	39 cf                	cmp    %ecx,%edi
 f0c:	76 66                	jbe    f74 <malloc+0x90>
 f0e:	89 fb                	mov    %edi,%ebx
 f10:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 f16:	0f 82 80 00 00 00    	jb     f9c <malloc+0xb8>
 f1c:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 f22:	76 70                	jbe    f94 <malloc+0xb0>
 f24:	8d 34 fd 00 00 00 00 	lea    0x0(,%edi,8),%esi
 f2b:	eb 0c                	jmp    f39 <malloc+0x55>
 f2d:	8d 76 00             	lea    0x0(%esi),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 f30:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 f32:	8b 48 04             	mov    0x4(%eax),%ecx
 f35:	39 cf                	cmp    %ecx,%edi
 f37:	76 3b                	jbe    f74 <malloc+0x90>
 f39:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 f3b:	39 05 04 17 00 00    	cmp    %eax,0x1704
 f41:	75 ed                	jne    f30 <malloc+0x4c>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 f43:	83 ec 0c             	sub    $0xc,%esp
 f46:	56                   	push   %esi
 f47:	e8 f7 fc ff ff       	call   c43 <sbrk>
  if(p == (char*)-1)
 f4c:	83 c4 10             	add    $0x10,%esp
 f4f:	83 f8 ff             	cmp    $0xffffffff,%eax
 f52:	74 1c                	je     f70 <malloc+0x8c>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 f54:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 f57:	83 ec 0c             	sub    $0xc,%esp
 f5a:	83 c0 08             	add    $0x8,%eax
 f5d:	50                   	push   %eax
 f5e:	e8 01 ff ff ff       	call   e64 <free>
  return freep;
 f63:	8b 15 04 17 00 00    	mov    0x1704,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 f69:	83 c4 10             	add    $0x10,%esp
 f6c:	85 d2                	test   %edx,%edx
 f6e:	75 c0                	jne    f30 <malloc+0x4c>
        return 0;
 f70:	31 c0                	xor    %eax,%eax
 f72:	eb 18                	jmp    f8c <malloc+0xa8>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 f74:	39 cf                	cmp    %ecx,%edi
 f76:	74 38                	je     fb0 <malloc+0xcc>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 f78:	29 f9                	sub    %edi,%ecx
 f7a:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 f7d:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 f80:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 f83:	89 15 04 17 00 00    	mov    %edx,0x1704
      return (void*)(p + 1);
 f89:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 f8c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 f8f:	5b                   	pop    %ebx
 f90:	5e                   	pop    %esi
 f91:	5f                   	pop    %edi
 f92:	5d                   	pop    %ebp
 f93:	c3                   	ret    
 f94:	be 00 80 00 00       	mov    $0x8000,%esi
 f99:	eb 9e                	jmp    f39 <malloc+0x55>
 f9b:	90                   	nop
 f9c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 fa1:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 fa7:	76 eb                	jbe    f94 <malloc+0xb0>
 fa9:	e9 76 ff ff ff       	jmp    f24 <malloc+0x40>
 fae:	66 90                	xchg   %ax,%ax
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 fb0:	8b 08                	mov    (%eax),%ecx
 fb2:	89 0a                	mov    %ecx,(%edx)
 fb4:	eb cd                	jmp    f83 <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 fb6:	c7 05 04 17 00 00 08 	movl   $0x1708,0x1704
 fbd:	17 00 00 
 fc0:	c7 05 08 17 00 00 08 	movl   $0x1708,0x1708
 fc7:	17 00 00 
    base.s.size = 0;
 fca:	c7 05 0c 17 00 00 00 	movl   $0x0,0x170c
 fd1:	00 00 00 
 fd4:	b8 08 17 00 00       	mov    $0x1708,%eax
 fd9:	e9 30 ff ff ff       	jmp    f0e <malloc+0x2a>
