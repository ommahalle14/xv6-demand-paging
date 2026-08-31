
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return randstate;
}

int
main(int argc, char *argv[])
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "usertests starting\n");
      11:	68 da 49 00 00       	push   $0x49da
      16:	6a 01                	push   $0x1
      18:	e8 cf 36 00 00       	call   36ec <printf>

  if(open("usertests.ran", 0) >= 0){
      1d:	5a                   	pop    %edx
      1e:	59                   	pop    %ecx
      1f:	6a 00                	push   $0x0
      21:	68 ee 49 00 00       	push   $0x49ee
      26:	e8 dc 35 00 00       	call   3607 <open>
      2b:	83 c4 10             	add    $0x10,%esp
      2e:	85 c0                	test   %eax,%eax
      30:	78 14                	js     46 <main+0x46>
    printf(1, "already ran user tests -- rebuild fs.img\n");
      32:	83 ec 08             	sub    $0x8,%esp
      35:	68 58 51 00 00       	push   $0x5158
      3a:	6a 01                	push   $0x1
      3c:	e8 ab 36 00 00       	call   36ec <printf>
    exit();
      41:	e8 81 35 00 00       	call   35c7 <exit>
  }
  close(open("usertests.ran", O_CREATE));
      46:	50                   	push   %eax
      47:	50                   	push   %eax
      48:	68 00 02 00 00       	push   $0x200
      4d:	68 ee 49 00 00       	push   $0x49ee
      52:	e8 b0 35 00 00       	call   3607 <open>
      57:	89 04 24             	mov    %eax,(%esp)
      5a:	e8 90 35 00 00       	call   35ef <close>

  argptest();
      5f:	e8 28 33 00 00       	call   338c <argptest>
  createdelete();
      64:	e8 8f 10 00 00       	call   10f8 <createdelete>
  linkunlink();
      69:	e8 96 18 00 00       	call   1904 <linkunlink>
  concreate();
      6e:	e8 d1 15 00 00       	call   1644 <concreate>
  fourfiles();
      73:	e8 c8 0e 00 00       	call   f40 <fourfiles>
  sharedfd();
      78:	e8 23 0d 00 00       	call   da0 <sharedfd>

  bigargtest();
      7d:	e8 9e 2f 00 00       	call   3020 <bigargtest>
  bigwrite();
      82:	e8 91 21 00 00       	call   2218 <bigwrite>
  bigargtest();
      87:	e8 94 2f 00 00       	call   3020 <bigargtest>
  bsstest();
      8c:	e8 27 2f 00 00       	call   2fb8 <bsstest>
  sbrktest();
      91:	e8 66 2a 00 00       	call   2afc <sbrktest>
  validatetest();
      96:	e8 71 2e 00 00       	call   2f0c <validatetest>

  opentest();
      9b:	e8 38 03 00 00       	call   3d8 <opentest>
  writetest();
      a0:	e8 c3 03 00 00       	call   468 <writetest>
  writetest1();
      a5:	e8 8e 05 00 00       	call   638 <writetest1>
  createtest();
      aa:	e8 39 07 00 00       	call   7e8 <createtest>

  openiputtest();
      af:	e8 30 02 00 00       	call   2e4 <openiputtest>
  exitiputtest();
      b4:	e8 3b 01 00 00       	call   1f4 <exitiputtest>
  iputtest();
      b9:	e8 56 00 00 00       	call   114 <iputtest>

  mem();
      be:	e8 29 0c 00 00       	call   cec <mem>
  pipe1();
      c3:	e8 e8 08 00 00       	call   9b0 <pipe1>
  preempt();
      c8:	e8 6f 0a 00 00       	call   b3c <preempt>
  exitwait();
      cd:	e8 9e 0b 00 00       	call   c70 <exitwait>

  rmdot();
      d2:	e8 01 25 00 00       	call   25d8 <rmdot>
  fourteen();
      d7:	e8 c8 23 00 00       	call   24a4 <fourteen>
  bigfile();
      dc:	e8 0b 22 00 00       	call   22ec <bigfile>
  subdir();
      e1:	e8 5a 1a 00 00       	call   1b40 <subdir>
  linktest();
      e6:	e8 4d 13 00 00       	call   1438 <linktest>
  unlinkread();
      eb:	e8 c4 11 00 00       	call   12b4 <unlinkread>
  dirfile();
      f0:	e8 57 26 00 00       	call   274c <dirfile>
  iref();
      f5:	e8 4a 28 00 00       	call   2944 <iref>
  forktest();
      fa:	e8 5d 29 00 00       	call   2a5c <forktest>
  bigdir(); // slow
      ff:	e8 10 19 00 00       	call   1a14 <bigdir>

  uio();
     104:	e8 13 32 00 00       	call   331c <uio>

  exectest();
     109:	e8 5a 08 00 00       	call   968 <exectest>

  exit();
     10e:	e8 b4 34 00 00       	call   35c7 <exit>
     113:	90                   	nop

00000114 <iputtest>:
int stdout = 1;

// does chdir() call iput(p->cwd) in a transaction?
void
iputtest(void)
{
     114:	55                   	push   %ebp
     115:	89 e5                	mov    %esp,%ebp
     117:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "iput test\n");
     11a:	68 80 3a 00 00       	push   $0x3a80
     11f:	ff 35 80 5a 00 00    	pushl  0x5a80
     125:	e8 c2 35 00 00       	call   36ec <printf>

  if(mkdir("iputdir") < 0){
     12a:	c7 04 24 13 3a 00 00 	movl   $0x3a13,(%esp)
     131:	e8 f9 34 00 00       	call   362f <mkdir>
     136:	83 c4 10             	add    $0x10,%esp
     139:	85 c0                	test   %eax,%eax
     13b:	78 58                	js     195 <iputtest+0x81>
    printf(stdout, "mkdir failed\n");
    exit();
  }
  if(chdir("iputdir") < 0){
     13d:	83 ec 0c             	sub    $0xc,%esp
     140:	68 13 3a 00 00       	push   $0x3a13
     145:	e8 ed 34 00 00       	call   3637 <chdir>
     14a:	83 c4 10             	add    $0x10,%esp
     14d:	85 c0                	test   %eax,%eax
     14f:	0f 88 85 00 00 00    	js     1da <iputtest+0xc6>
    printf(stdout, "chdir iputdir failed\n");
    exit();
  }
  if(unlink("../iputdir") < 0){
     155:	83 ec 0c             	sub    $0xc,%esp
     158:	68 10 3a 00 00       	push   $0x3a10
     15d:	e8 b5 34 00 00       	call   3617 <unlink>
     162:	83 c4 10             	add    $0x10,%esp
     165:	85 c0                	test   %eax,%eax
     167:	78 5a                	js     1c3 <iputtest+0xaf>
    printf(stdout, "unlink ../iputdir failed\n");
    exit();
  }
  if(chdir("/") < 0){
     169:	83 ec 0c             	sub    $0xc,%esp
     16c:	68 35 3a 00 00       	push   $0x3a35
     171:	e8 c1 34 00 00       	call   3637 <chdir>
     176:	83 c4 10             	add    $0x10,%esp
     179:	85 c0                	test   %eax,%eax
     17b:	78 2f                	js     1ac <iputtest+0x98>
    printf(stdout, "chdir / failed\n");
    exit();
  }
  printf(stdout, "iput test ok\n");
     17d:	83 ec 08             	sub    $0x8,%esp
     180:	68 b8 3a 00 00       	push   $0x3ab8
     185:	ff 35 80 5a 00 00    	pushl  0x5a80
     18b:	e8 5c 35 00 00       	call   36ec <printf>
}
     190:	83 c4 10             	add    $0x10,%esp
     193:	c9                   	leave  
     194:	c3                   	ret    
iputtest(void)
{
  printf(stdout, "iput test\n");

  if(mkdir("iputdir") < 0){
    printf(stdout, "mkdir failed\n");
     195:	50                   	push   %eax
     196:	50                   	push   %eax
     197:	68 ec 39 00 00       	push   $0x39ec
     19c:	ff 35 80 5a 00 00    	pushl  0x5a80
     1a2:	e8 45 35 00 00       	call   36ec <printf>
    exit();
     1a7:	e8 1b 34 00 00       	call   35c7 <exit>
  if(unlink("../iputdir") < 0){
    printf(stdout, "unlink ../iputdir failed\n");
    exit();
  }
  if(chdir("/") < 0){
    printf(stdout, "chdir / failed\n");
     1ac:	50                   	push   %eax
     1ad:	50                   	push   %eax
     1ae:	68 37 3a 00 00       	push   $0x3a37
     1b3:	ff 35 80 5a 00 00    	pushl  0x5a80
     1b9:	e8 2e 35 00 00       	call   36ec <printf>
    exit();
     1be:	e8 04 34 00 00       	call   35c7 <exit>
  if(chdir("iputdir") < 0){
    printf(stdout, "chdir iputdir failed\n");
    exit();
  }
  if(unlink("../iputdir") < 0){
    printf(stdout, "unlink ../iputdir failed\n");
     1c3:	52                   	push   %edx
     1c4:	52                   	push   %edx
     1c5:	68 1b 3a 00 00       	push   $0x3a1b
     1ca:	ff 35 80 5a 00 00    	pushl  0x5a80
     1d0:	e8 17 35 00 00       	call   36ec <printf>
    exit();
     1d5:	e8 ed 33 00 00       	call   35c7 <exit>
  if(mkdir("iputdir") < 0){
    printf(stdout, "mkdir failed\n");
    exit();
  }
  if(chdir("iputdir") < 0){
    printf(stdout, "chdir iputdir failed\n");
     1da:	51                   	push   %ecx
     1db:	51                   	push   %ecx
     1dc:	68 fa 39 00 00       	push   $0x39fa
     1e1:	ff 35 80 5a 00 00    	pushl  0x5a80
     1e7:	e8 00 35 00 00       	call   36ec <printf>
    exit();
     1ec:	e8 d6 33 00 00       	call   35c7 <exit>
     1f1:	8d 76 00             	lea    0x0(%esi),%esi

000001f4 <exitiputtest>:
}

// does exit() call iput(p->cwd) in a transaction?
void
exitiputtest(void)
{
     1f4:	55                   	push   %ebp
     1f5:	89 e5                	mov    %esp,%ebp
     1f7:	83 ec 10             	sub    $0x10,%esp
  int pid;

  printf(stdout, "exitiput test\n");
     1fa:	68 47 3a 00 00       	push   $0x3a47
     1ff:	ff 35 80 5a 00 00    	pushl  0x5a80
     205:	e8 e2 34 00 00       	call   36ec <printf>

  pid = fork();
     20a:	e8 b0 33 00 00       	call   35bf <fork>
  if(pid < 0){
     20f:	83 c4 10             	add    $0x10,%esp
     212:	85 c0                	test   %eax,%eax
     214:	0f 88 82 00 00 00    	js     29c <exitiputtest+0xa8>
    printf(stdout, "fork failed\n");
    exit();
  }
  if(pid == 0){
     21a:	75 48                	jne    264 <exitiputtest+0x70>
    if(mkdir("iputdir") < 0){
     21c:	83 ec 0c             	sub    $0xc,%esp
     21f:	68 13 3a 00 00       	push   $0x3a13
     224:	e8 06 34 00 00       	call   362f <mkdir>
     229:	83 c4 10             	add    $0x10,%esp
     22c:	85 c0                	test   %eax,%eax
     22e:	0f 88 96 00 00 00    	js     2ca <exitiputtest+0xd6>
      printf(stdout, "mkdir failed\n");
      exit();
    }
    if(chdir("iputdir") < 0){
     234:	83 ec 0c             	sub    $0xc,%esp
     237:	68 13 3a 00 00       	push   $0x3a13
     23c:	e8 f6 33 00 00       	call   3637 <chdir>
     241:	83 c4 10             	add    $0x10,%esp
     244:	85 c0                	test   %eax,%eax
     246:	78 6b                	js     2b3 <exitiputtest+0xbf>
      printf(stdout, "child chdir failed\n");
      exit();
    }
    if(unlink("../iputdir") < 0){
     248:	83 ec 0c             	sub    $0xc,%esp
     24b:	68 10 3a 00 00       	push   $0x3a10
     250:	e8 c2 33 00 00       	call   3617 <unlink>
     255:	83 c4 10             	add    $0x10,%esp
     258:	85 c0                	test   %eax,%eax
     25a:	78 28                	js     284 <exitiputtest+0x90>
      printf(stdout, "unlink ../iputdir failed\n");
      exit();
    }
    exit();
     25c:	e8 66 33 00 00       	call   35c7 <exit>
     261:	8d 76 00             	lea    0x0(%esi),%esi
  }
  wait();
     264:	e8 66 33 00 00       	call   35cf <wait>
  printf(stdout, "exitiput test ok\n");
     269:	83 ec 08             	sub    $0x8,%esp
     26c:	68 6a 3a 00 00       	push   $0x3a6a
     271:	ff 35 80 5a 00 00    	pushl  0x5a80
     277:	e8 70 34 00 00       	call   36ec <printf>
}
     27c:	83 c4 10             	add    $0x10,%esp
     27f:	c9                   	leave  
     280:	c3                   	ret    
     281:	8d 76 00             	lea    0x0(%esi),%esi
    if(chdir("iputdir") < 0){
      printf(stdout, "child chdir failed\n");
      exit();
    }
    if(unlink("../iputdir") < 0){
      printf(stdout, "unlink ../iputdir failed\n");
     284:	83 ec 08             	sub    $0x8,%esp
     287:	68 1b 3a 00 00       	push   $0x3a1b
     28c:	ff 35 80 5a 00 00    	pushl  0x5a80
     292:	e8 55 34 00 00       	call   36ec <printf>
      exit();
     297:	e8 2b 33 00 00       	call   35c7 <exit>

  printf(stdout, "exitiput test\n");

  pid = fork();
  if(pid < 0){
    printf(stdout, "fork failed\n");
     29c:	51                   	push   %ecx
     29d:	51                   	push   %ecx
     29e:	68 2d 49 00 00       	push   $0x492d
     2a3:	ff 35 80 5a 00 00    	pushl  0x5a80
     2a9:	e8 3e 34 00 00       	call   36ec <printf>
    exit();
     2ae:	e8 14 33 00 00       	call   35c7 <exit>
    if(mkdir("iputdir") < 0){
      printf(stdout, "mkdir failed\n");
      exit();
    }
    if(chdir("iputdir") < 0){
      printf(stdout, "child chdir failed\n");
     2b3:	50                   	push   %eax
     2b4:	50                   	push   %eax
     2b5:	68 56 3a 00 00       	push   $0x3a56
     2ba:	ff 35 80 5a 00 00    	pushl  0x5a80
     2c0:	e8 27 34 00 00       	call   36ec <printf>
      exit();
     2c5:	e8 fd 32 00 00       	call   35c7 <exit>
    printf(stdout, "fork failed\n");
    exit();
  }
  if(pid == 0){
    if(mkdir("iputdir") < 0){
      printf(stdout, "mkdir failed\n");
     2ca:	52                   	push   %edx
     2cb:	52                   	push   %edx
     2cc:	68 ec 39 00 00       	push   $0x39ec
     2d1:	ff 35 80 5a 00 00    	pushl  0x5a80
     2d7:	e8 10 34 00 00       	call   36ec <printf>
      exit();
     2dc:	e8 e6 32 00 00       	call   35c7 <exit>
     2e1:	8d 76 00             	lea    0x0(%esi),%esi

000002e4 <openiputtest>:
//      for(i = 0; i < 10000; i++)
//        yield();
//    }
void
openiputtest(void)
{
     2e4:	55                   	push   %ebp
     2e5:	89 e5                	mov    %esp,%ebp
     2e7:	83 ec 10             	sub    $0x10,%esp
  int pid;

  printf(stdout, "openiput test\n");
     2ea:	68 7c 3a 00 00       	push   $0x3a7c
     2ef:	ff 35 80 5a 00 00    	pushl  0x5a80
     2f5:	e8 f2 33 00 00       	call   36ec <printf>
  if(mkdir("oidir") < 0){
     2fa:	c7 04 24 8b 3a 00 00 	movl   $0x3a8b,(%esp)
     301:	e8 29 33 00 00       	call   362f <mkdir>
     306:	83 c4 10             	add    $0x10,%esp
     309:	85 c0                	test   %eax,%eax
     30b:	0f 88 80 00 00 00    	js     391 <openiputtest+0xad>
    printf(stdout, "mkdir oidir failed\n");
    exit();
  }
  pid = fork();
     311:	e8 a9 32 00 00       	call   35bf <fork>
  if(pid < 0){
     316:	85 c0                	test   %eax,%eax
     318:	0f 88 8a 00 00 00    	js     3a8 <openiputtest+0xc4>
    printf(stdout, "fork failed\n");
    exit();
  }
  if(pid == 0){
     31e:	75 30                	jne    350 <openiputtest+0x6c>
    int fd = open("oidir", O_RDWR);
     320:	83 ec 08             	sub    $0x8,%esp
     323:	6a 02                	push   $0x2
     325:	68 8b 3a 00 00       	push   $0x3a8b
     32a:	e8 d8 32 00 00       	call   3607 <open>
    if(fd >= 0){
     32f:	83 c4 10             	add    $0x10,%esp
     332:	85 c0                	test   %eax,%eax
     334:	78 56                	js     38c <openiputtest+0xa8>
      printf(stdout, "open directory for write succeeded\n");
     336:	83 ec 08             	sub    $0x8,%esp
     339:	68 10 4a 00 00       	push   $0x4a10
     33e:	ff 35 80 5a 00 00    	pushl  0x5a80
     344:	e8 a3 33 00 00       	call   36ec <printf>
      exit();
     349:	e8 79 32 00 00       	call   35c7 <exit>
     34e:	66 90                	xchg   %ax,%ax
    }
    exit();
  }
  sleep(1);
     350:	83 ec 0c             	sub    $0xc,%esp
     353:	6a 01                	push   $0x1
     355:	e8 fd 32 00 00       	call   3657 <sleep>
  if(unlink("oidir") != 0){
     35a:	c7 04 24 8b 3a 00 00 	movl   $0x3a8b,(%esp)
     361:	e8 b1 32 00 00       	call   3617 <unlink>
     366:	83 c4 10             	add    $0x10,%esp
     369:	85 c0                	test   %eax,%eax
     36b:	75 52                	jne    3bf <openiputtest+0xdb>
    printf(stdout, "unlink failed\n");
    exit();
  }
  wait();
     36d:	e8 5d 32 00 00       	call   35cf <wait>
  printf(stdout, "openiput test ok\n");
     372:	83 ec 08             	sub    $0x8,%esp
     375:	68 b4 3a 00 00       	push   $0x3ab4
     37a:	ff 35 80 5a 00 00    	pushl  0x5a80
     380:	e8 67 33 00 00       	call   36ec <printf>
     385:	83 c4 10             	add    $0x10,%esp
}
     388:	c9                   	leave  
     389:	c3                   	ret    
     38a:	66 90                	xchg   %ax,%ax
    int fd = open("oidir", O_RDWR);
    if(fd >= 0){
      printf(stdout, "open directory for write succeeded\n");
      exit();
    }
    exit();
     38c:	e8 36 32 00 00       	call   35c7 <exit>
{
  int pid;

  printf(stdout, "openiput test\n");
  if(mkdir("oidir") < 0){
    printf(stdout, "mkdir oidir failed\n");
     391:	51                   	push   %ecx
     392:	51                   	push   %ecx
     393:	68 91 3a 00 00       	push   $0x3a91
     398:	ff 35 80 5a 00 00    	pushl  0x5a80
     39e:	e8 49 33 00 00       	call   36ec <printf>
    exit();
     3a3:	e8 1f 32 00 00       	call   35c7 <exit>
  }
  pid = fork();
  if(pid < 0){
    printf(stdout, "fork failed\n");
     3a8:	52                   	push   %edx
     3a9:	52                   	push   %edx
     3aa:	68 2d 49 00 00       	push   $0x492d
     3af:	ff 35 80 5a 00 00    	pushl  0x5a80
     3b5:	e8 32 33 00 00       	call   36ec <printf>
    exit();
     3ba:	e8 08 32 00 00       	call   35c7 <exit>
    }
    exit();
  }
  sleep(1);
  if(unlink("oidir") != 0){
    printf(stdout, "unlink failed\n");
     3bf:	50                   	push   %eax
     3c0:	50                   	push   %eax
     3c1:	68 a5 3a 00 00       	push   $0x3aa5
     3c6:	ff 35 80 5a 00 00    	pushl  0x5a80
     3cc:	e8 1b 33 00 00       	call   36ec <printf>
    exit();
     3d1:	e8 f1 31 00 00       	call   35c7 <exit>
     3d6:	66 90                	xchg   %ax,%ax

000003d8 <opentest>:

// simple file system tests

void
opentest(void)
{
     3d8:	55                   	push   %ebp
     3d9:	89 e5                	mov    %esp,%ebp
     3db:	83 ec 10             	sub    $0x10,%esp
  int fd;

  printf(stdout, "open test\n");
     3de:	68 c6 3a 00 00       	push   $0x3ac6
     3e3:	ff 35 80 5a 00 00    	pushl  0x5a80
     3e9:	e8 fe 32 00 00       	call   36ec <printf>
  fd = open("echo", 0);
     3ee:	58                   	pop    %eax
     3ef:	5a                   	pop    %edx
     3f0:	6a 00                	push   $0x0
     3f2:	68 d1 3a 00 00       	push   $0x3ad1
     3f7:	e8 0b 32 00 00       	call   3607 <open>
  if(fd < 0){
     3fc:	83 c4 10             	add    $0x10,%esp
     3ff:	85 c0                	test   %eax,%eax
     401:	78 36                	js     439 <opentest+0x61>
    printf(stdout, "open echo failed!\n");
    exit();
  }
  close(fd);
     403:	83 ec 0c             	sub    $0xc,%esp
     406:	50                   	push   %eax
     407:	e8 e3 31 00 00       	call   35ef <close>
  fd = open("doesnotexist", 0);
     40c:	5a                   	pop    %edx
     40d:	59                   	pop    %ecx
     40e:	6a 00                	push   $0x0
     410:	68 e9 3a 00 00       	push   $0x3ae9
     415:	e8 ed 31 00 00       	call   3607 <open>
  if(fd >= 0){
     41a:	83 c4 10             	add    $0x10,%esp
     41d:	85 c0                	test   %eax,%eax
     41f:	79 2f                	jns    450 <opentest+0x78>
    printf(stdout, "open doesnotexist succeeded!\n");
    exit();
  }
  printf(stdout, "open test ok\n");
     421:	83 ec 08             	sub    $0x8,%esp
     424:	68 14 3b 00 00       	push   $0x3b14
     429:	ff 35 80 5a 00 00    	pushl  0x5a80
     42f:	e8 b8 32 00 00       	call   36ec <printf>
}
     434:	83 c4 10             	add    $0x10,%esp
     437:	c9                   	leave  
     438:	c3                   	ret    
  int fd;

  printf(stdout, "open test\n");
  fd = open("echo", 0);
  if(fd < 0){
    printf(stdout, "open echo failed!\n");
     439:	50                   	push   %eax
     43a:	50                   	push   %eax
     43b:	68 d6 3a 00 00       	push   $0x3ad6
     440:	ff 35 80 5a 00 00    	pushl  0x5a80
     446:	e8 a1 32 00 00       	call   36ec <printf>
    exit();
     44b:	e8 77 31 00 00       	call   35c7 <exit>
  }
  close(fd);
  fd = open("doesnotexist", 0);
  if(fd >= 0){
    printf(stdout, "open doesnotexist succeeded!\n");
     450:	50                   	push   %eax
     451:	50                   	push   %eax
     452:	68 f6 3a 00 00       	push   $0x3af6
     457:	ff 35 80 5a 00 00    	pushl  0x5a80
     45d:	e8 8a 32 00 00       	call   36ec <printf>
    exit();
     462:	e8 60 31 00 00       	call   35c7 <exit>
     467:	90                   	nop

00000468 <writetest>:
  printf(stdout, "open test ok\n");
}

void
writetest(void)
{
     468:	55                   	push   %ebp
     469:	89 e5                	mov    %esp,%ebp
     46b:	56                   	push   %esi
     46c:	53                   	push   %ebx
  int fd;
  int i;

  printf(stdout, "small file test\n");
     46d:	83 ec 08             	sub    $0x8,%esp
     470:	68 22 3b 00 00       	push   $0x3b22
     475:	ff 35 80 5a 00 00    	pushl  0x5a80
     47b:	e8 6c 32 00 00       	call   36ec <printf>
  fd = open("small", O_CREATE|O_RDWR);
     480:	58                   	pop    %eax
     481:	5a                   	pop    %edx
     482:	68 02 02 00 00       	push   $0x202
     487:	68 33 3b 00 00       	push   $0x3b33
     48c:	e8 76 31 00 00       	call   3607 <open>
  if(fd >= 0){
     491:	83 c4 10             	add    $0x10,%esp
     494:	85 c0                	test   %eax,%eax
     496:	0f 88 81 01 00 00    	js     61d <writetest+0x1b5>
     49c:	89 c6                	mov    %eax,%esi
    printf(stdout, "creat small succeeded; ok\n");
     49e:	83 ec 08             	sub    $0x8,%esp
     4a1:	68 39 3b 00 00       	push   $0x3b39
     4a6:	ff 35 80 5a 00 00    	pushl  0x5a80
     4ac:	e8 3b 32 00 00       	call   36ec <printf>
     4b1:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
     4b4:	31 db                	xor    %ebx,%ebx
     4b6:	66 90                	xchg   %ax,%ax
    if(write(fd, "aaaaaaaaaa", 10) != 10){
     4b8:	50                   	push   %eax
     4b9:	6a 0a                	push   $0xa
     4bb:	68 70 3b 00 00       	push   $0x3b70
     4c0:	56                   	push   %esi
     4c1:	e8 21 31 00 00       	call   35e7 <write>
     4c6:	83 c4 10             	add    $0x10,%esp
     4c9:	83 f8 0a             	cmp    $0xa,%eax
     4cc:	0f 85 d5 00 00 00    	jne    5a7 <writetest+0x13f>
      printf(stdout, "error: write aa %d new file failed\n", i);
      exit();
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
     4d2:	50                   	push   %eax
     4d3:	6a 0a                	push   $0xa
     4d5:	68 7b 3b 00 00       	push   $0x3b7b
     4da:	56                   	push   %esi
     4db:	e8 07 31 00 00       	call   35e7 <write>
     4e0:	83 c4 10             	add    $0x10,%esp
     4e3:	83 f8 0a             	cmp    $0xa,%eax
     4e6:	0f 85 d2 00 00 00    	jne    5be <writetest+0x156>
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
     4ec:	43                   	inc    %ebx
     4ed:	83 fb 64             	cmp    $0x64,%ebx
     4f0:	75 c6                	jne    4b8 <writetest+0x50>
    if(write(fd, "bbbbbbbbbb", 10) != 10){
      printf(stdout, "error: write bb %d new file failed\n", i);
      exit();
    }
  }
  printf(stdout, "writes ok\n");
     4f2:	83 ec 08             	sub    $0x8,%esp
     4f5:	68 86 3b 00 00       	push   $0x3b86
     4fa:	ff 35 80 5a 00 00    	pushl  0x5a80
     500:	e8 e7 31 00 00       	call   36ec <printf>
  close(fd);
     505:	89 34 24             	mov    %esi,(%esp)
     508:	e8 e2 30 00 00       	call   35ef <close>
  fd = open("small", O_RDONLY);
     50d:	58                   	pop    %eax
     50e:	5a                   	pop    %edx
     50f:	6a 00                	push   $0x0
     511:	68 33 3b 00 00       	push   $0x3b33
     516:	e8 ec 30 00 00       	call   3607 <open>
     51b:	89 c3                	mov    %eax,%ebx
  if(fd >= 0){
     51d:	83 c4 10             	add    $0x10,%esp
     520:	85 c0                	test   %eax,%eax
     522:	0f 88 ad 00 00 00    	js     5d5 <writetest+0x16d>
    printf(stdout, "open small succeeded ok\n");
     528:	83 ec 08             	sub    $0x8,%esp
     52b:	68 91 3b 00 00       	push   $0x3b91
     530:	ff 35 80 5a 00 00    	pushl  0x5a80
     536:	e8 b1 31 00 00       	call   36ec <printf>
  } else {
    printf(stdout, "error: open small failed!\n");
    exit();
  }
  i = read(fd, buf, 2000);
     53b:	83 c4 0c             	add    $0xc,%esp
     53e:	68 d0 07 00 00       	push   $0x7d0
     543:	68 60 82 00 00       	push   $0x8260
     548:	53                   	push   %ebx
     549:	e8 91 30 00 00       	call   35df <read>
  if(i == 2000){
     54e:	83 c4 10             	add    $0x10,%esp
     551:	3d d0 07 00 00       	cmp    $0x7d0,%eax
     556:	0f 85 91 00 00 00    	jne    5ed <writetest+0x185>
    printf(stdout, "read succeeded ok\n");
     55c:	83 ec 08             	sub    $0x8,%esp
     55f:	68 c5 3b 00 00       	push   $0x3bc5
     564:	ff 35 80 5a 00 00    	pushl  0x5a80
     56a:	e8 7d 31 00 00       	call   36ec <printf>
  } else {
    printf(stdout, "read failed\n");
    exit();
  }
  close(fd);
     56f:	89 1c 24             	mov    %ebx,(%esp)
     572:	e8 78 30 00 00       	call   35ef <close>

  if(unlink("small") < 0){
     577:	c7 04 24 33 3b 00 00 	movl   $0x3b33,(%esp)
     57e:	e8 94 30 00 00       	call   3617 <unlink>
     583:	83 c4 10             	add    $0x10,%esp
     586:	85 c0                	test   %eax,%eax
     588:	78 7b                	js     605 <writetest+0x19d>
    printf(stdout, "unlink small failed\n");
    exit();
  }
  printf(stdout, "small file test ok\n");
     58a:	83 ec 08             	sub    $0x8,%esp
     58d:	68 ed 3b 00 00       	push   $0x3bed
     592:	ff 35 80 5a 00 00    	pushl  0x5a80
     598:	e8 4f 31 00 00       	call   36ec <printf>
}
     59d:	83 c4 10             	add    $0x10,%esp
     5a0:	8d 65 f8             	lea    -0x8(%ebp),%esp
     5a3:	5b                   	pop    %ebx
     5a4:	5e                   	pop    %esi
     5a5:	5d                   	pop    %ebp
     5a6:	c3                   	ret    
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
    if(write(fd, "aaaaaaaaaa", 10) != 10){
      printf(stdout, "error: write aa %d new file failed\n", i);
     5a7:	50                   	push   %eax
     5a8:	53                   	push   %ebx
     5a9:	68 34 4a 00 00       	push   $0x4a34
     5ae:	ff 35 80 5a 00 00    	pushl  0x5a80
     5b4:	e8 33 31 00 00       	call   36ec <printf>
      exit();
     5b9:	e8 09 30 00 00       	call   35c7 <exit>
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
      printf(stdout, "error: write bb %d new file failed\n", i);
     5be:	51                   	push   %ecx
     5bf:	53                   	push   %ebx
     5c0:	68 58 4a 00 00       	push   $0x4a58
     5c5:	ff 35 80 5a 00 00    	pushl  0x5a80
     5cb:	e8 1c 31 00 00       	call   36ec <printf>
      exit();
     5d0:	e8 f2 2f 00 00       	call   35c7 <exit>
  close(fd);
  fd = open("small", O_RDONLY);
  if(fd >= 0){
    printf(stdout, "open small succeeded ok\n");
  } else {
    printf(stdout, "error: open small failed!\n");
     5d5:	83 ec 08             	sub    $0x8,%esp
     5d8:	68 aa 3b 00 00       	push   $0x3baa
     5dd:	ff 35 80 5a 00 00    	pushl  0x5a80
     5e3:	e8 04 31 00 00       	call   36ec <printf>
    exit();
     5e8:	e8 da 2f 00 00       	call   35c7 <exit>
  }
  i = read(fd, buf, 2000);
  if(i == 2000){
    printf(stdout, "read succeeded ok\n");
  } else {
    printf(stdout, "read failed\n");
     5ed:	83 ec 08             	sub    $0x8,%esp
     5f0:	68 f1 3e 00 00       	push   $0x3ef1
     5f5:	ff 35 80 5a 00 00    	pushl  0x5a80
     5fb:	e8 ec 30 00 00       	call   36ec <printf>
    exit();
     600:	e8 c2 2f 00 00       	call   35c7 <exit>
  }
  close(fd);

  if(unlink("small") < 0){
    printf(stdout, "unlink small failed\n");
     605:	83 ec 08             	sub    $0x8,%esp
     608:	68 d8 3b 00 00       	push   $0x3bd8
     60d:	ff 35 80 5a 00 00    	pushl  0x5a80
     613:	e8 d4 30 00 00       	call   36ec <printf>
    exit();
     618:	e8 aa 2f 00 00       	call   35c7 <exit>
  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_RDWR);
  if(fd >= 0){
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
     61d:	83 ec 08             	sub    $0x8,%esp
     620:	68 54 3b 00 00       	push   $0x3b54
     625:	ff 35 80 5a 00 00    	pushl  0x5a80
     62b:	e8 bc 30 00 00       	call   36ec <printf>
    exit();
     630:	e8 92 2f 00 00       	call   35c7 <exit>
     635:	8d 76 00             	lea    0x0(%esi),%esi

00000638 <writetest1>:
  printf(stdout, "small file test ok\n");
}

void
writetest1(void)
{
     638:	55                   	push   %ebp
     639:	89 e5                	mov    %esp,%ebp
     63b:	56                   	push   %esi
     63c:	53                   	push   %ebx
  int i, fd, n;

  printf(stdout, "big files test\n");
     63d:	83 ec 08             	sub    $0x8,%esp
     640:	68 01 3c 00 00       	push   $0x3c01
     645:	ff 35 80 5a 00 00    	pushl  0x5a80
     64b:	e8 9c 30 00 00       	call   36ec <printf>

  fd = open("big", O_CREATE|O_RDWR);
     650:	58                   	pop    %eax
     651:	5a                   	pop    %edx
     652:	68 02 02 00 00       	push   $0x202
     657:	68 7b 3c 00 00       	push   $0x3c7b
     65c:	e8 a6 2f 00 00       	call   3607 <open>
  if(fd < 0){
     661:	83 c4 10             	add    $0x10,%esp
     664:	85 c0                	test   %eax,%eax
     666:	0f 88 4a 01 00 00    	js     7b6 <writetest1+0x17e>
     66c:	89 c6                	mov    %eax,%esi
     66e:	31 db                	xor    %ebx,%ebx
    printf(stdout, "error: creat big failed!\n");
    exit();
  }

  for(i = 0; i < MAXFILE; i++){
    ((int*)buf)[0] = i;
     670:	89 1d 60 82 00 00    	mov    %ebx,0x8260
    if(write(fd, buf, 512) != 512){
     676:	50                   	push   %eax
     677:	68 00 02 00 00       	push   $0x200
     67c:	68 60 82 00 00       	push   $0x8260
     681:	56                   	push   %esi
     682:	e8 60 2f 00 00       	call   35e7 <write>
     687:	83 c4 10             	add    $0x10,%esp
     68a:	3d 00 02 00 00       	cmp    $0x200,%eax
     68f:	0f 85 a9 00 00 00    	jne    73e <writetest1+0x106>
  if(fd < 0){
    printf(stdout, "error: creat big failed!\n");
    exit();
  }

  for(i = 0; i < MAXFILE; i++){
     695:	43                   	inc    %ebx
     696:	81 fb 8c 00 00 00    	cmp    $0x8c,%ebx
     69c:	75 d2                	jne    670 <writetest1+0x38>
      printf(stdout, "error: write big file failed\n", i);
      exit();
    }
  }

  close(fd);
     69e:	83 ec 0c             	sub    $0xc,%esp
     6a1:	56                   	push   %esi
     6a2:	e8 48 2f 00 00       	call   35ef <close>

  fd = open("big", O_RDONLY);
     6a7:	58                   	pop    %eax
     6a8:	5a                   	pop    %edx
     6a9:	6a 00                	push   $0x0
     6ab:	68 7b 3c 00 00       	push   $0x3c7b
     6b0:	e8 52 2f 00 00       	call   3607 <open>
     6b5:	89 c6                	mov    %eax,%esi
  if(fd < 0){
     6b7:	83 c4 10             	add    $0x10,%esp
     6ba:	85 c0                	test   %eax,%eax
     6bc:	0f 88 dc 00 00 00    	js     79e <writetest1+0x166>
     6c2:	31 db                	xor    %ebx,%ebx
     6c4:	eb 17                	jmp    6dd <writetest1+0xa5>
     6c6:	66 90                	xchg   %ax,%ax
      if(n == MAXFILE - 1){
        printf(stdout, "read only %d blocks from big", n);
        exit();
      }
      break;
    } else if(i != 512){
     6c8:	3d 00 02 00 00       	cmp    $0x200,%eax
     6cd:	0f 85 99 00 00 00    	jne    76c <writetest1+0x134>
      printf(stdout, "read failed %d\n", i);
      exit();
    }
    if(((int*)buf)[0] != n){
     6d3:	a1 60 82 00 00       	mov    0x8260,%eax
     6d8:	39 c3                	cmp    %eax,%ebx
     6da:	75 79                	jne    755 <writetest1+0x11d>
      printf(stdout, "read content of block %d is %d\n",
             n, ((int*)buf)[0]);
      exit();
    }
    n++;
     6dc:	43                   	inc    %ebx
    exit();
  }

  n = 0;
  for(;;){
    i = read(fd, buf, 512);
     6dd:	50                   	push   %eax
     6de:	68 00 02 00 00       	push   $0x200
     6e3:	68 60 82 00 00       	push   $0x8260
     6e8:	56                   	push   %esi
     6e9:	e8 f1 2e 00 00       	call   35df <read>
    if(i == 0){
     6ee:	83 c4 10             	add    $0x10,%esp
     6f1:	85 c0                	test   %eax,%eax
     6f3:	75 d3                	jne    6c8 <writetest1+0x90>
      if(n == MAXFILE - 1){
     6f5:	81 fb 8b 00 00 00    	cmp    $0x8b,%ebx
     6fb:	0f 84 82 00 00 00    	je     783 <writetest1+0x14b>
             n, ((int*)buf)[0]);
      exit();
    }
    n++;
  }
  close(fd);
     701:	83 ec 0c             	sub    $0xc,%esp
     704:	56                   	push   %esi
     705:	e8 e5 2e 00 00       	call   35ef <close>
  if(unlink("big") < 0){
     70a:	c7 04 24 7b 3c 00 00 	movl   $0x3c7b,(%esp)
     711:	e8 01 2f 00 00       	call   3617 <unlink>
     716:	83 c4 10             	add    $0x10,%esp
     719:	85 c0                	test   %eax,%eax
     71b:	0f 88 ad 00 00 00    	js     7ce <writetest1+0x196>
    printf(stdout, "unlink big failed\n");
    exit();
  }
  printf(stdout, "big files ok\n");
     721:	83 ec 08             	sub    $0x8,%esp
     724:	68 a2 3c 00 00       	push   $0x3ca2
     729:	ff 35 80 5a 00 00    	pushl  0x5a80
     72f:	e8 b8 2f 00 00       	call   36ec <printf>
}
     734:	83 c4 10             	add    $0x10,%esp
     737:	8d 65 f8             	lea    -0x8(%ebp),%esp
     73a:	5b                   	pop    %ebx
     73b:	5e                   	pop    %esi
     73c:	5d                   	pop    %ebp
     73d:	c3                   	ret    
  }

  for(i = 0; i < MAXFILE; i++){
    ((int*)buf)[0] = i;
    if(write(fd, buf, 512) != 512){
      printf(stdout, "error: write big file failed\n", i);
     73e:	51                   	push   %ecx
     73f:	53                   	push   %ebx
     740:	68 2b 3c 00 00       	push   $0x3c2b
     745:	ff 35 80 5a 00 00    	pushl  0x5a80
     74b:	e8 9c 2f 00 00       	call   36ec <printf>
      exit();
     750:	e8 72 2e 00 00       	call   35c7 <exit>
    } else if(i != 512){
      printf(stdout, "read failed %d\n", i);
      exit();
    }
    if(((int*)buf)[0] != n){
      printf(stdout, "read content of block %d is %d\n",
     755:	50                   	push   %eax
     756:	53                   	push   %ebx
     757:	68 7c 4a 00 00       	push   $0x4a7c
     75c:	ff 35 80 5a 00 00    	pushl  0x5a80
     762:	e8 85 2f 00 00       	call   36ec <printf>
             n, ((int*)buf)[0]);
      exit();
     767:	e8 5b 2e 00 00       	call   35c7 <exit>
        printf(stdout, "read only %d blocks from big", n);
        exit();
      }
      break;
    } else if(i != 512){
      printf(stdout, "read failed %d\n", i);
     76c:	52                   	push   %edx
     76d:	50                   	push   %eax
     76e:	68 7f 3c 00 00       	push   $0x3c7f
     773:	ff 35 80 5a 00 00    	pushl  0x5a80
     779:	e8 6e 2f 00 00       	call   36ec <printf>
      exit();
     77e:	e8 44 2e 00 00       	call   35c7 <exit>
  n = 0;
  for(;;){
    i = read(fd, buf, 512);
    if(i == 0){
      if(n == MAXFILE - 1){
        printf(stdout, "read only %d blocks from big", n);
     783:	51                   	push   %ecx
     784:	68 8b 00 00 00       	push   $0x8b
     789:	68 62 3c 00 00       	push   $0x3c62
     78e:	ff 35 80 5a 00 00    	pushl  0x5a80
     794:	e8 53 2f 00 00       	call   36ec <printf>
        exit();
     799:	e8 29 2e 00 00       	call   35c7 <exit>

  close(fd);

  fd = open("big", O_RDONLY);
  if(fd < 0){
    printf(stdout, "error: open big failed!\n");
     79e:	83 ec 08             	sub    $0x8,%esp
     7a1:	68 49 3c 00 00       	push   $0x3c49
     7a6:	ff 35 80 5a 00 00    	pushl  0x5a80
     7ac:	e8 3b 2f 00 00       	call   36ec <printf>
    exit();
     7b1:	e8 11 2e 00 00       	call   35c7 <exit>

  printf(stdout, "big files test\n");

  fd = open("big", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(stdout, "error: creat big failed!\n");
     7b6:	83 ec 08             	sub    $0x8,%esp
     7b9:	68 11 3c 00 00       	push   $0x3c11
     7be:	ff 35 80 5a 00 00    	pushl  0x5a80
     7c4:	e8 23 2f 00 00       	call   36ec <printf>
    exit();
     7c9:	e8 f9 2d 00 00       	call   35c7 <exit>
    }
    n++;
  }
  close(fd);
  if(unlink("big") < 0){
    printf(stdout, "unlink big failed\n");
     7ce:	83 ec 08             	sub    $0x8,%esp
     7d1:	68 8f 3c 00 00       	push   $0x3c8f
     7d6:	ff 35 80 5a 00 00    	pushl  0x5a80
     7dc:	e8 0b 2f 00 00       	call   36ec <printf>
    exit();
     7e1:	e8 e1 2d 00 00       	call   35c7 <exit>
     7e6:	66 90                	xchg   %ax,%ax

000007e8 <createtest>:
  printf(stdout, "big files ok\n");
}

void
createtest(void)
{
     7e8:	55                   	push   %ebp
     7e9:	89 e5                	mov    %esp,%ebp
     7eb:	53                   	push   %ebx
     7ec:	83 ec 0c             	sub    $0xc,%esp
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");
     7ef:	68 9c 4a 00 00       	push   $0x4a9c
     7f4:	ff 35 80 5a 00 00    	pushl  0x5a80
     7fa:	e8 ed 2e 00 00       	call   36ec <printf>

  name[0] = 'a';
     7ff:	c6 05 60 a2 00 00 61 	movb   $0x61,0xa260
  name[2] = '\0';
     806:	c6 05 62 a2 00 00 00 	movb   $0x0,0xa262
     80d:	83 c4 10             	add    $0x10,%esp
     810:	b3 30                	mov    $0x30,%bl
     812:	66 90                	xchg   %ax,%ax
  for(i = 0; i < 52; i++){
    name[1] = '0' + i;
     814:	88 1d 61 a2 00 00    	mov    %bl,0xa261
    fd = open(name, O_CREATE|O_RDWR);
     81a:	83 ec 08             	sub    $0x8,%esp
     81d:	68 02 02 00 00       	push   $0x202
     822:	68 60 a2 00 00       	push   $0xa260
     827:	e8 db 2d 00 00       	call   3607 <open>
    close(fd);
     82c:	89 04 24             	mov    %eax,(%esp)
     82f:	e8 bb 2d 00 00       	call   35ef <close>
     834:	43                   	inc    %ebx

  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
     835:	83 c4 10             	add    $0x10,%esp
     838:	80 fb 64             	cmp    $0x64,%bl
     83b:	75 d7                	jne    814 <createtest+0x2c>
    name[1] = '0' + i;
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
     83d:	c6 05 60 a2 00 00 61 	movb   $0x61,0xa260
  name[2] = '\0';
     844:	c6 05 62 a2 00 00 00 	movb   $0x0,0xa262
     84b:	b3 30                	mov    $0x30,%bl
     84d:	8d 76 00             	lea    0x0(%esi),%esi
  for(i = 0; i < 52; i++){
    name[1] = '0' + i;
     850:	88 1d 61 a2 00 00    	mov    %bl,0xa261
    unlink(name);
     856:	83 ec 0c             	sub    $0xc,%esp
     859:	68 60 a2 00 00       	push   $0xa260
     85e:	e8 b4 2d 00 00       	call   3617 <unlink>
     863:	43                   	inc    %ebx
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
     864:	83 c4 10             	add    $0x10,%esp
     867:	80 fb 64             	cmp    $0x64,%bl
     86a:	75 e4                	jne    850 <createtest+0x68>
    name[1] = '0' + i;
    unlink(name);
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
     86c:	83 ec 08             	sub    $0x8,%esp
     86f:	68 c4 4a 00 00       	push   $0x4ac4
     874:	ff 35 80 5a 00 00    	pushl  0x5a80
     87a:	e8 6d 2e 00 00       	call   36ec <printf>
}
     87f:	83 c4 10             	add    $0x10,%esp
     882:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     885:	c9                   	leave  
     886:	c3                   	ret    
     887:	90                   	nop

00000888 <dirtest>:

void dirtest(void)
{
     888:	55                   	push   %ebp
     889:	89 e5                	mov    %esp,%ebp
     88b:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "mkdir test\n");
     88e:	68 b0 3c 00 00       	push   $0x3cb0
     893:	ff 35 80 5a 00 00    	pushl  0x5a80
     899:	e8 4e 2e 00 00       	call   36ec <printf>

  if(mkdir("dir0") < 0){
     89e:	c7 04 24 bc 3c 00 00 	movl   $0x3cbc,(%esp)
     8a5:	e8 85 2d 00 00       	call   362f <mkdir>
     8aa:	83 c4 10             	add    $0x10,%esp
     8ad:	85 c0                	test   %eax,%eax
     8af:	78 58                	js     909 <dirtest+0x81>
    printf(stdout, "mkdir failed\n");
    exit();
  }

  if(chdir("dir0") < 0){
     8b1:	83 ec 0c             	sub    $0xc,%esp
     8b4:	68 bc 3c 00 00       	push   $0x3cbc
     8b9:	e8 79 2d 00 00       	call   3637 <chdir>
     8be:	83 c4 10             	add    $0x10,%esp
     8c1:	85 c0                	test   %eax,%eax
     8c3:	0f 88 85 00 00 00    	js     94e <dirtest+0xc6>
    printf(stdout, "chdir dir0 failed\n");
    exit();
  }

  if(chdir("..") < 0){
     8c9:	83 ec 0c             	sub    $0xc,%esp
     8cc:	68 61 42 00 00       	push   $0x4261
     8d1:	e8 61 2d 00 00       	call   3637 <chdir>
     8d6:	83 c4 10             	add    $0x10,%esp
     8d9:	85 c0                	test   %eax,%eax
     8db:	78 5a                	js     937 <dirtest+0xaf>
    printf(stdout, "chdir .. failed\n");
    exit();
  }

  if(unlink("dir0") < 0){
     8dd:	83 ec 0c             	sub    $0xc,%esp
     8e0:	68 bc 3c 00 00       	push   $0x3cbc
     8e5:	e8 2d 2d 00 00       	call   3617 <unlink>
     8ea:	83 c4 10             	add    $0x10,%esp
     8ed:	85 c0                	test   %eax,%eax
     8ef:	78 2f                	js     920 <dirtest+0x98>
    printf(stdout, "unlink dir0 failed\n");
    exit();
  }
  printf(stdout, "mkdir test ok\n");
     8f1:	83 ec 08             	sub    $0x8,%esp
     8f4:	68 f9 3c 00 00       	push   $0x3cf9
     8f9:	ff 35 80 5a 00 00    	pushl  0x5a80
     8ff:	e8 e8 2d 00 00       	call   36ec <printf>
}
     904:	83 c4 10             	add    $0x10,%esp
     907:	c9                   	leave  
     908:	c3                   	ret    
void dirtest(void)
{
  printf(stdout, "mkdir test\n");

  if(mkdir("dir0") < 0){
    printf(stdout, "mkdir failed\n");
     909:	50                   	push   %eax
     90a:	50                   	push   %eax
     90b:	68 ec 39 00 00       	push   $0x39ec
     910:	ff 35 80 5a 00 00    	pushl  0x5a80
     916:	e8 d1 2d 00 00       	call   36ec <printf>
    exit();
     91b:	e8 a7 2c 00 00       	call   35c7 <exit>
    printf(stdout, "chdir .. failed\n");
    exit();
  }

  if(unlink("dir0") < 0){
    printf(stdout, "unlink dir0 failed\n");
     920:	50                   	push   %eax
     921:	50                   	push   %eax
     922:	68 e5 3c 00 00       	push   $0x3ce5
     927:	ff 35 80 5a 00 00    	pushl  0x5a80
     92d:	e8 ba 2d 00 00       	call   36ec <printf>
    exit();
     932:	e8 90 2c 00 00       	call   35c7 <exit>
    printf(stdout, "chdir dir0 failed\n");
    exit();
  }

  if(chdir("..") < 0){
    printf(stdout, "chdir .. failed\n");
     937:	52                   	push   %edx
     938:	52                   	push   %edx
     939:	68 d4 3c 00 00       	push   $0x3cd4
     93e:	ff 35 80 5a 00 00    	pushl  0x5a80
     944:	e8 a3 2d 00 00       	call   36ec <printf>
    exit();
     949:	e8 79 2c 00 00       	call   35c7 <exit>
    printf(stdout, "mkdir failed\n");
    exit();
  }

  if(chdir("dir0") < 0){
    printf(stdout, "chdir dir0 failed\n");
     94e:	51                   	push   %ecx
     94f:	51                   	push   %ecx
     950:	68 c1 3c 00 00       	push   $0x3cc1
     955:	ff 35 80 5a 00 00    	pushl  0x5a80
     95b:	e8 8c 2d 00 00       	call   36ec <printf>
    exit();
     960:	e8 62 2c 00 00       	call   35c7 <exit>
     965:	8d 76 00             	lea    0x0(%esi),%esi

00000968 <exectest>:
  printf(stdout, "mkdir test ok\n");
}

void
exectest(void)
{
     968:	55                   	push   %ebp
     969:	89 e5                	mov    %esp,%ebp
     96b:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "exec test\n");
     96e:	68 08 3d 00 00       	push   $0x3d08
     973:	ff 35 80 5a 00 00    	pushl  0x5a80
     979:	e8 6e 2d 00 00       	call   36ec <printf>
  if(exec("echo", echoargv) < 0){
     97e:	5a                   	pop    %edx
     97f:	59                   	pop    %ecx
     980:	68 84 5a 00 00       	push   $0x5a84
     985:	68 d1 3a 00 00       	push   $0x3ad1
     98a:	e8 70 2c 00 00       	call   35ff <exec>
     98f:	83 c4 10             	add    $0x10,%esp
     992:	85 c0                	test   %eax,%eax
     994:	78 02                	js     998 <exectest+0x30>
    printf(stdout, "exec echo failed\n");
    exit();
  }
}
     996:	c9                   	leave  
     997:	c3                   	ret    
void
exectest(void)
{
  printf(stdout, "exec test\n");
  if(exec("echo", echoargv) < 0){
    printf(stdout, "exec echo failed\n");
     998:	50                   	push   %eax
     999:	50                   	push   %eax
     99a:	68 13 3d 00 00       	push   $0x3d13
     99f:	ff 35 80 5a 00 00    	pushl  0x5a80
     9a5:	e8 42 2d 00 00       	call   36ec <printf>
    exit();
     9aa:	e8 18 2c 00 00       	call   35c7 <exit>
     9af:	90                   	nop

000009b0 <pipe1>:

// simple fork and pipe read/write

void
pipe1(void)
{
     9b0:	55                   	push   %ebp
     9b1:	89 e5                	mov    %esp,%ebp
     9b3:	57                   	push   %edi
     9b4:	56                   	push   %esi
     9b5:	53                   	push   %ebx
     9b6:	83 ec 38             	sub    $0x38,%esp
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
     9b9:	8d 45 e0             	lea    -0x20(%ebp),%eax
     9bc:	50                   	push   %eax
     9bd:	e8 15 2c 00 00       	call   35d7 <pipe>
     9c2:	83 c4 10             	add    $0x10,%esp
     9c5:	85 c0                	test   %eax,%eax
     9c7:	0f 85 33 01 00 00    	jne    b00 <pipe1+0x150>
    printf(1, "pipe() failed\n");
    exit();
  }
  pid = fork();
     9cd:	e8 ed 2b 00 00       	call   35bf <fork>
  seq = 0;
  if(pid == 0){
     9d2:	83 f8 00             	cmp    $0x0,%eax
     9d5:	0f 84 8b 00 00 00    	je     a66 <pipe1+0xb6>
        printf(1, "pipe1 oops 1\n");
        exit();
      }
    }
    exit();
  } else if(pid > 0){
     9db:	0f 8e 33 01 00 00    	jle    b14 <pipe1+0x164>
    close(fds[1]);
     9e1:	83 ec 0c             	sub    $0xc,%esp
     9e4:	ff 75 e4             	pushl  -0x1c(%ebp)
     9e7:	e8 03 2c 00 00       	call   35ef <close>
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
     9ec:	83 c4 10             	add    $0x10,%esp
      }
    }
    exit();
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
     9ef:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    cc = 1;
     9f6:	bf 01 00 00 00       	mov    $0x1,%edi
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit();
  }
  pid = fork();
  seq = 0;
     9fb:	31 db                	xor    %ebx,%ebx
    exit();
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
     9fd:	56                   	push   %esi
     9fe:	57                   	push   %edi
     9ff:	68 60 82 00 00       	push   $0x8260
     a04:	ff 75 e0             	pushl  -0x20(%ebp)
     a07:	e8 d3 2b 00 00       	call   35df <read>
     a0c:	83 c4 10             	add    $0x10,%esp
     a0f:	85 c0                	test   %eax,%eax
     a11:	0f 8e a5 00 00 00    	jle    abc <pipe1+0x10c>
     a17:	8d 34 18             	lea    (%eax,%ebx,1),%esi
      for(i = 0; i < n; i++){
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     a1a:	89 d9                	mov    %ebx,%ecx
     a1c:	f7 d9                	neg    %ecx
     a1e:	66 90                	xchg   %ax,%ax
     a20:	8d 53 01             	lea    0x1(%ebx),%edx
     a23:	38 9c 0b 60 82 00 00 	cmp    %bl,0x8260(%ebx,%ecx,1)
     a2a:	75 17                	jne    a43 <pipe1+0x93>
     a2c:	89 d3                	mov    %edx,%ebx
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
     a2e:	39 f2                	cmp    %esi,%edx
     a30:	75 ee                	jne    a20 <pipe1+0x70>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
          printf(1, "pipe1 oops 2\n");
          return;
        }
      }
      total += n;
     a32:	01 45 d4             	add    %eax,-0x2c(%ebp)
     a35:	01 ff                	add    %edi,%edi
     a37:	81 ff 00 20 00 00    	cmp    $0x2000,%edi
     a3d:	7f 1e                	jg     a5d <pipe1+0xad>
      cc = cc * 2;
     a3f:	89 f3                	mov    %esi,%ebx
     a41:	eb ba                	jmp    9fd <pipe1+0x4d>
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
        if((buf[i] & 0xff) != (seq++ & 0xff)){
          printf(1, "pipe1 oops 2\n");
     a43:	83 ec 08             	sub    $0x8,%esp
     a46:	68 42 3d 00 00       	push   $0x3d42
     a4b:	6a 01                	push   $0x1
     a4d:	e8 9a 2c 00 00       	call   36ec <printf>
          return;
     a52:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
}
     a55:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a58:	5b                   	pop    %ebx
     a59:	5e                   	pop    %esi
     a5a:	5f                   	pop    %edi
     a5b:	5d                   	pop    %ebp
     a5c:	c3                   	ret    
     a5d:	bf 00 20 00 00       	mov    $0x2000,%edi
          printf(1, "pipe1 oops 2\n");
          return;
        }
      }
      total += n;
      cc = cc * 2;
     a62:	89 f3                	mov    %esi,%ebx
     a64:	eb 97                	jmp    9fd <pipe1+0x4d>
    exit();
  }
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
     a66:	83 ec 0c             	sub    $0xc,%esp
     a69:	ff 75 e0             	pushl  -0x20(%ebp)
     a6c:	e8 7e 2b 00 00       	call   35ef <close>
     a71:	83 c4 10             	add    $0x10,%esp
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit();
  }
  pid = fork();
  seq = 0;
     a74:	31 f6                	xor    %esi,%esi
     a76:	8d 96 09 04 00 00    	lea    0x409(%esi),%edx

// simple fork and pipe read/write

void
pipe1(void)
{
     a7c:	89 f3                	mov    %esi,%ebx
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
        buf[i] = seq++;
     a7e:	89 f0                	mov    %esi,%eax
     a80:	f7 d8                	neg    %eax
     a82:	66 90                	xchg   %ax,%ax
     a84:	88 9c 18 60 82 00 00 	mov    %bl,0x8260(%eax,%ebx,1)
     a8b:	43                   	inc    %ebx
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
     a8c:	39 d3                	cmp    %edx,%ebx
     a8e:	75 f4                	jne    a84 <pipe1+0xd4>
     a90:	89 de                	mov    %ebx,%esi
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
     a92:	57                   	push   %edi
     a93:	68 09 04 00 00       	push   $0x409
     a98:	68 60 82 00 00       	push   $0x8260
     a9d:	ff 75 e4             	pushl  -0x1c(%ebp)
     aa0:	e8 42 2b 00 00       	call   35e7 <write>
     aa5:	83 c4 10             	add    $0x10,%esp
     aa8:	3d 09 04 00 00       	cmp    $0x409,%eax
     aad:	75 79                	jne    b28 <pipe1+0x178>
  }
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
     aaf:	81 fb 2d 14 00 00    	cmp    $0x142d,%ebx
     ab5:	75 bf                	jne    a76 <pipe1+0xc6>
      if(write(fds[1], buf, 1033) != 1033){
        printf(1, "pipe1 oops 1\n");
        exit();
      }
    }
    exit();
     ab7:	e8 0b 2b 00 00       	call   35c7 <exit>
      total += n;
      cc = cc * 2;
      if(cc > sizeof(buf))
        cc = sizeof(buf);
    }
    if(total != 5 * 1033){
     abc:	81 7d d4 2d 14 00 00 	cmpl   $0x142d,-0x2c(%ebp)
     ac3:	75 26                	jne    aeb <pipe1+0x13b>
      printf(1, "pipe1 oops 3 total %d\n", total);
      exit();
    }
    close(fds[0]);
     ac5:	83 ec 0c             	sub    $0xc,%esp
     ac8:	ff 75 e0             	pushl  -0x20(%ebp)
     acb:	e8 1f 2b 00 00       	call   35ef <close>
    wait();
     ad0:	e8 fa 2a 00 00       	call   35cf <wait>
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
     ad5:	58                   	pop    %eax
     ad6:	5a                   	pop    %edx
     ad7:	68 67 3d 00 00       	push   $0x3d67
     adc:	6a 01                	push   $0x1
     ade:	e8 09 2c 00 00       	call   36ec <printf>
     ae3:	83 c4 10             	add    $0x10,%esp
     ae6:	e9 6a ff ff ff       	jmp    a55 <pipe1+0xa5>
      cc = cc * 2;
      if(cc > sizeof(buf))
        cc = sizeof(buf);
    }
    if(total != 5 * 1033){
      printf(1, "pipe1 oops 3 total %d\n", total);
     aeb:	51                   	push   %ecx
     aec:	ff 75 d4             	pushl  -0x2c(%ebp)
     aef:	68 50 3d 00 00       	push   $0x3d50
     af4:	6a 01                	push   $0x1
     af6:	e8 f1 2b 00 00       	call   36ec <printf>
      exit();
     afb:	e8 c7 2a 00 00       	call   35c7 <exit>
{
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
     b00:	83 ec 08             	sub    $0x8,%esp
     b03:	68 25 3d 00 00       	push   $0x3d25
     b08:	6a 01                	push   $0x1
     b0a:	e8 dd 2b 00 00       	call   36ec <printf>
    exit();
     b0f:	e8 b3 2a 00 00       	call   35c7 <exit>
      exit();
    }
    close(fds[0]);
    wait();
  } else {
    printf(1, "fork() failed\n");
     b14:	83 ec 08             	sub    $0x8,%esp
     b17:	68 71 3d 00 00       	push   $0x3d71
     b1c:	6a 01                	push   $0x1
     b1e:	e8 c9 2b 00 00       	call   36ec <printf>
    exit();
     b23:	e8 9f 2a 00 00       	call   35c7 <exit>
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
        printf(1, "pipe1 oops 1\n");
     b28:	83 ec 08             	sub    $0x8,%esp
     b2b:	68 34 3d 00 00       	push   $0x3d34
     b30:	6a 01                	push   $0x1
     b32:	e8 b5 2b 00 00       	call   36ec <printf>
        exit();
     b37:	e8 8b 2a 00 00       	call   35c7 <exit>

00000b3c <preempt>:
}

// meant to be run w/ at most two CPUs
void
preempt(void)
{
     b3c:	55                   	push   %ebp
     b3d:	89 e5                	mov    %esp,%ebp
     b3f:	57                   	push   %edi
     b40:	56                   	push   %esi
     b41:	53                   	push   %ebx
     b42:	83 ec 24             	sub    $0x24,%esp
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
     b45:	68 80 3d 00 00       	push   $0x3d80
     b4a:	6a 01                	push   $0x1
     b4c:	e8 9b 2b 00 00       	call   36ec <printf>
  pid1 = fork();
     b51:	e8 69 2a 00 00       	call   35bf <fork>
  if(pid1 == 0)
     b56:	83 c4 10             	add    $0x10,%esp
     b59:	85 c0                	test   %eax,%eax
     b5b:	75 02                	jne    b5f <preempt+0x23>
     b5d:	eb fe                	jmp    b5d <preempt+0x21>
     b5f:	89 c7                	mov    %eax,%edi
    for(;;)
      ;

  pid2 = fork();
     b61:	e8 59 2a 00 00       	call   35bf <fork>
     b66:	89 c6                	mov    %eax,%esi
  if(pid2 == 0)
     b68:	85 c0                	test   %eax,%eax
     b6a:	75 02                	jne    b6e <preempt+0x32>
     b6c:	eb fe                	jmp    b6c <preempt+0x30>
    for(;;)
      ;

  pipe(pfds);
     b6e:	83 ec 0c             	sub    $0xc,%esp
     b71:	8d 45 e0             	lea    -0x20(%ebp),%eax
     b74:	50                   	push   %eax
     b75:	e8 5d 2a 00 00       	call   35d7 <pipe>
  pid3 = fork();
     b7a:	e8 40 2a 00 00       	call   35bf <fork>
     b7f:	89 c3                	mov    %eax,%ebx
  if(pid3 == 0){
     b81:	83 c4 10             	add    $0x10,%esp
     b84:	85 c0                	test   %eax,%eax
     b86:	75 45                	jne    bcd <preempt+0x91>
    close(pfds[0]);
     b88:	83 ec 0c             	sub    $0xc,%esp
     b8b:	ff 75 e0             	pushl  -0x20(%ebp)
     b8e:	e8 5c 2a 00 00       	call   35ef <close>
    if(write(pfds[1], "x", 1) != 1)
     b93:	83 c4 0c             	add    $0xc,%esp
     b96:	6a 01                	push   $0x1
     b98:	68 45 43 00 00       	push   $0x4345
     b9d:	ff 75 e4             	pushl  -0x1c(%ebp)
     ba0:	e8 42 2a 00 00       	call   35e7 <write>
     ba5:	83 c4 10             	add    $0x10,%esp
     ba8:	48                   	dec    %eax
     ba9:	74 12                	je     bbd <preempt+0x81>
      printf(1, "preempt write error");
     bab:	83 ec 08             	sub    $0x8,%esp
     bae:	68 8a 3d 00 00       	push   $0x3d8a
     bb3:	6a 01                	push   $0x1
     bb5:	e8 32 2b 00 00       	call   36ec <printf>
     bba:	83 c4 10             	add    $0x10,%esp
    close(pfds[1]);
     bbd:	83 ec 0c             	sub    $0xc,%esp
     bc0:	ff 75 e4             	pushl  -0x1c(%ebp)
     bc3:	e8 27 2a 00 00       	call   35ef <close>
     bc8:	83 c4 10             	add    $0x10,%esp
     bcb:	eb fe                	jmp    bcb <preempt+0x8f>
    for(;;)
      ;
  }

  close(pfds[1]);
     bcd:	83 ec 0c             	sub    $0xc,%esp
     bd0:	ff 75 e4             	pushl  -0x1c(%ebp)
     bd3:	e8 17 2a 00 00       	call   35ef <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     bd8:	83 c4 0c             	add    $0xc,%esp
     bdb:	68 00 20 00 00       	push   $0x2000
     be0:	68 60 82 00 00       	push   $0x8260
     be5:	ff 75 e0             	pushl  -0x20(%ebp)
     be8:	e8 f2 29 00 00       	call   35df <read>
     bed:	83 c4 10             	add    $0x10,%esp
     bf0:	48                   	dec    %eax
     bf1:	74 1a                	je     c0d <preempt+0xd1>
    printf(1, "preempt read error");
     bf3:	83 ec 08             	sub    $0x8,%esp
     bf6:	68 9e 3d 00 00       	push   $0x3d9e
     bfb:	6a 01                	push   $0x1
     bfd:	e8 ea 2a 00 00       	call   36ec <printf>
    return;
     c02:	83 c4 10             	add    $0x10,%esp
  printf(1, "wait... ");
  wait();
  wait();
  wait();
  printf(1, "preempt ok\n");
}
     c05:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c08:	5b                   	pop    %ebx
     c09:	5e                   	pop    %esi
     c0a:	5f                   	pop    %edi
     c0b:	5d                   	pop    %ebp
     c0c:	c3                   	ret    
  close(pfds[1]);
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    printf(1, "preempt read error");
    return;
  }
  close(pfds[0]);
     c0d:	83 ec 0c             	sub    $0xc,%esp
     c10:	ff 75 e0             	pushl  -0x20(%ebp)
     c13:	e8 d7 29 00 00       	call   35ef <close>
  printf(1, "kill... ");
     c18:	58                   	pop    %eax
     c19:	5a                   	pop    %edx
     c1a:	68 b1 3d 00 00       	push   $0x3db1
     c1f:	6a 01                	push   $0x1
     c21:	e8 c6 2a 00 00       	call   36ec <printf>
  kill(pid1);
     c26:	89 3c 24             	mov    %edi,(%esp)
     c29:	e8 c9 29 00 00       	call   35f7 <kill>
  kill(pid2);
     c2e:	89 34 24             	mov    %esi,(%esp)
     c31:	e8 c1 29 00 00       	call   35f7 <kill>
  kill(pid3);
     c36:	89 1c 24             	mov    %ebx,(%esp)
     c39:	e8 b9 29 00 00       	call   35f7 <kill>
  printf(1, "wait... ");
     c3e:	59                   	pop    %ecx
     c3f:	5b                   	pop    %ebx
     c40:	68 ba 3d 00 00       	push   $0x3dba
     c45:	6a 01                	push   $0x1
     c47:	e8 a0 2a 00 00       	call   36ec <printf>
  wait();
     c4c:	e8 7e 29 00 00       	call   35cf <wait>
  wait();
     c51:	e8 79 29 00 00       	call   35cf <wait>
  wait();
     c56:	e8 74 29 00 00       	call   35cf <wait>
  printf(1, "preempt ok\n");
     c5b:	5e                   	pop    %esi
     c5c:	5f                   	pop    %edi
     c5d:	68 c3 3d 00 00       	push   $0x3dc3
     c62:	6a 01                	push   $0x1
     c64:	e8 83 2a 00 00       	call   36ec <printf>
     c69:	83 c4 10             	add    $0x10,%esp
     c6c:	eb 97                	jmp    c05 <preempt+0xc9>
     c6e:	66 90                	xchg   %ax,%ax

00000c70 <exitwait>:
}

// try to find any races between exit and wait
void
exitwait(void)
{
     c70:	55                   	push   %ebp
     c71:	89 e5                	mov    %esp,%ebp
     c73:	56                   	push   %esi
     c74:	53                   	push   %ebx
     c75:	be 64 00 00 00       	mov    $0x64,%esi
     c7a:	eb 0e                	jmp    c8a <exitwait+0x1a>
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
      return;
    }
    if(pid){
     c7c:	74 67                	je     ce5 <exitwait+0x75>
      if(wait() != pid){
     c7e:	e8 4c 29 00 00       	call   35cf <wait>
     c83:	39 c3                	cmp    %eax,%ebx
     c85:	75 29                	jne    cb0 <exitwait+0x40>
void
exitwait(void)
{
  int i, pid;

  for(i = 0; i < 100; i++){
     c87:	4e                   	dec    %esi
     c88:	74 42                	je     ccc <exitwait+0x5c>
    pid = fork();
     c8a:	e8 30 29 00 00       	call   35bf <fork>
     c8f:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
     c91:	85 c0                	test   %eax,%eax
     c93:	79 e7                	jns    c7c <exitwait+0xc>
      printf(1, "fork failed\n");
     c95:	83 ec 08             	sub    $0x8,%esp
     c98:	68 2d 49 00 00       	push   $0x492d
     c9d:	6a 01                	push   $0x1
     c9f:	e8 48 2a 00 00       	call   36ec <printf>
      return;
     ca4:	83 c4 10             	add    $0x10,%esp
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
}
     ca7:	8d 65 f8             	lea    -0x8(%ebp),%esp
     caa:	5b                   	pop    %ebx
     cab:	5e                   	pop    %esi
     cac:	5d                   	pop    %ebp
     cad:	c3                   	ret    
     cae:	66 90                	xchg   %ax,%ax
      printf(1, "fork failed\n");
      return;
    }
    if(pid){
      if(wait() != pid){
        printf(1, "wait wrong pid\n");
     cb0:	83 ec 08             	sub    $0x8,%esp
     cb3:	68 cf 3d 00 00       	push   $0x3dcf
     cb8:	6a 01                	push   $0x1
     cba:	e8 2d 2a 00 00       	call   36ec <printf>
        return;
     cbf:	83 c4 10             	add    $0x10,%esp
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
}
     cc2:	8d 65 f8             	lea    -0x8(%ebp),%esp
     cc5:	5b                   	pop    %ebx
     cc6:	5e                   	pop    %esi
     cc7:	5d                   	pop    %ebp
     cc8:	c3                   	ret    
     cc9:	8d 76 00             	lea    0x0(%esi),%esi
      }
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
     ccc:	83 ec 08             	sub    $0x8,%esp
     ccf:	68 df 3d 00 00       	push   $0x3ddf
     cd4:	6a 01                	push   $0x1
     cd6:	e8 11 2a 00 00       	call   36ec <printf>
     cdb:	83 c4 10             	add    $0x10,%esp
}
     cde:	8d 65 f8             	lea    -0x8(%ebp),%esp
     ce1:	5b                   	pop    %ebx
     ce2:	5e                   	pop    %esi
     ce3:	5d                   	pop    %ebp
     ce4:	c3                   	ret    
      if(wait() != pid){
        printf(1, "wait wrong pid\n");
        return;
      }
    } else {
      exit();
     ce5:	e8 dd 28 00 00       	call   35c7 <exit>
     cea:	66 90                	xchg   %ax,%ax

00000cec <mem>:
  printf(1, "exitwait ok\n");
}

void
mem(void)
{
     cec:	55                   	push   %ebp
     ced:	89 e5                	mov    %esp,%ebp
     cef:	57                   	push   %edi
     cf0:	56                   	push   %esi
     cf1:	53                   	push   %ebx
     cf2:	83 ec 14             	sub    $0x14,%esp
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
     cf5:	68 ec 3d 00 00       	push   $0x3dec
     cfa:	6a 01                	push   $0x1
     cfc:	e8 eb 29 00 00       	call   36ec <printf>
  ppid = getpid();
     d01:	e8 41 29 00 00       	call   3647 <getpid>
     d06:	89 c6                	mov    %eax,%esi
  if((pid = fork()) == 0){
     d08:	e8 b2 28 00 00       	call   35bf <fork>
     d0d:	83 c4 10             	add    $0x10,%esp
     d10:	85 c0                	test   %eax,%eax
     d12:	75 64                	jne    d78 <mem+0x8c>
     d14:	31 db                	xor    %ebx,%ebx
     d16:	eb 04                	jmp    d1c <mem+0x30>
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
      *(char**)m2 = m1;
     d18:	89 18                	mov    %ebx,(%eax)
     d1a:	89 c3                	mov    %eax,%ebx

  printf(1, "mem test\n");
  ppid = getpid();
  if((pid = fork()) == 0){
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
     d1c:	83 ec 0c             	sub    $0xc,%esp
     d1f:	68 11 27 00 00       	push   $0x2711
     d24:	e8 c7 2b 00 00       	call   38f0 <malloc>
     d29:	83 c4 10             	add    $0x10,%esp
     d2c:	85 c0                	test   %eax,%eax
     d2e:	75 e8                	jne    d18 <mem+0x2c>
      *(char**)m2 = m1;
      m1 = m2;
    }
    while(m1){
     d30:	85 db                	test   %ebx,%ebx
     d32:	74 14                	je     d48 <mem+0x5c>
      m2 = *(char**)m1;
     d34:	8b 3b                	mov    (%ebx),%edi
      free(m1);
     d36:	83 ec 0c             	sub    $0xc,%esp
     d39:	53                   	push   %ebx
     d3a:	e8 31 2b 00 00       	call   3870 <free>
     d3f:	89 fb                	mov    %edi,%ebx
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
      *(char**)m2 = m1;
      m1 = m2;
    }
    while(m1){
     d41:	83 c4 10             	add    $0x10,%esp
     d44:	85 db                	test   %ebx,%ebx
     d46:	75 ec                	jne    d34 <mem+0x48>
      m2 = *(char**)m1;
      free(m1);
      m1 = m2;
    }
    m1 = malloc(1024*20);
     d48:	83 ec 0c             	sub    $0xc,%esp
     d4b:	68 00 50 00 00       	push   $0x5000
     d50:	e8 9b 2b 00 00       	call   38f0 <malloc>
    if(m1 == 0){
     d55:	83 c4 10             	add    $0x10,%esp
     d58:	85 c0                	test   %eax,%eax
     d5a:	74 28                	je     d84 <mem+0x98>
      printf(1, "couldn't allocate mem?!!\n");
      kill(ppid);
      exit();
    }
    free(m1);
     d5c:	83 ec 0c             	sub    $0xc,%esp
     d5f:	50                   	push   %eax
     d60:	e8 0b 2b 00 00       	call   3870 <free>
    printf(1, "mem ok\n");
     d65:	58                   	pop    %eax
     d66:	5a                   	pop    %edx
     d67:	68 10 3e 00 00       	push   $0x3e10
     d6c:	6a 01                	push   $0x1
     d6e:	e8 79 29 00 00       	call   36ec <printf>
    exit();
     d73:	e8 4f 28 00 00       	call   35c7 <exit>
  } else {
    wait();
  }
}
     d78:	8d 65 f4             	lea    -0xc(%ebp),%esp
     d7b:	5b                   	pop    %ebx
     d7c:	5e                   	pop    %esi
     d7d:	5f                   	pop    %edi
     d7e:	5d                   	pop    %ebp
    }
    free(m1);
    printf(1, "mem ok\n");
    exit();
  } else {
    wait();
     d7f:	e9 4b 28 00 00       	jmp    35cf <wait>
      free(m1);
      m1 = m2;
    }
    m1 = malloc(1024*20);
    if(m1 == 0){
      printf(1, "couldn't allocate mem?!!\n");
     d84:	83 ec 08             	sub    $0x8,%esp
     d87:	68 f6 3d 00 00       	push   $0x3df6
     d8c:	6a 01                	push   $0x1
     d8e:	e8 59 29 00 00       	call   36ec <printf>
      kill(ppid);
     d93:	89 34 24             	mov    %esi,(%esp)
     d96:	e8 5c 28 00 00       	call   35f7 <kill>
      exit();
     d9b:	e8 27 28 00 00       	call   35c7 <exit>

00000da0 <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
{
     da0:	55                   	push   %ebp
     da1:	89 e5                	mov    %esp,%ebp
     da3:	57                   	push   %edi
     da4:	56                   	push   %esi
     da5:	53                   	push   %ebx
     da6:	83 ec 34             	sub    $0x34,%esp
  int fd, pid, i, n, nc, np;
  char buf[10];

  printf(1, "sharedfd test\n");
     da9:	68 18 3e 00 00       	push   $0x3e18
     dae:	6a 01                	push   $0x1
     db0:	e8 37 29 00 00       	call   36ec <printf>

  unlink("sharedfd");
     db5:	c7 04 24 27 3e 00 00 	movl   $0x3e27,(%esp)
     dbc:	e8 56 28 00 00       	call   3617 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
     dc1:	59                   	pop    %ecx
     dc2:	5b                   	pop    %ebx
     dc3:	68 02 02 00 00       	push   $0x202
     dc8:	68 27 3e 00 00       	push   $0x3e27
     dcd:	e8 35 28 00 00       	call   3607 <open>
  if(fd < 0){
     dd2:	83 c4 10             	add    $0x10,%esp
     dd5:	85 c0                	test   %eax,%eax
     dd7:	0f 88 17 01 00 00    	js     ef4 <sharedfd+0x154>
     ddd:	89 c7                	mov    %eax,%edi
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
     ddf:	e8 db 27 00 00       	call   35bf <fork>
     de4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
     de7:	83 f8 01             	cmp    $0x1,%eax
     dea:	19 c0                	sbb    %eax,%eax
     dec:	83 e0 f3             	and    $0xfffffff3,%eax
     def:	83 c0 70             	add    $0x70,%eax
     df2:	52                   	push   %edx
     df3:	6a 0a                	push   $0xa
     df5:	50                   	push   %eax
     df6:	8d 75 de             	lea    -0x22(%ebp),%esi
     df9:	56                   	push   %esi
     dfa:	e8 95 26 00 00       	call   3494 <memset>
     dff:	83 c4 10             	add    $0x10,%esp
     e02:	bb e8 03 00 00       	mov    $0x3e8,%ebx
     e07:	eb 06                	jmp    e0f <sharedfd+0x6f>
     e09:	8d 76 00             	lea    0x0(%esi),%esi
  for(i = 0; i < 1000; i++){
     e0c:	4b                   	dec    %ebx
     e0d:	74 24                	je     e33 <sharedfd+0x93>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
     e0f:	50                   	push   %eax
     e10:	6a 0a                	push   $0xa
     e12:	56                   	push   %esi
     e13:	57                   	push   %edi
     e14:	e8 ce 27 00 00       	call   35e7 <write>
     e19:	83 c4 10             	add    $0x10,%esp
     e1c:	83 f8 0a             	cmp    $0xa,%eax
     e1f:	74 eb                	je     e0c <sharedfd+0x6c>
      printf(1, "fstests: write sharedfd failed\n");
     e21:	83 ec 08             	sub    $0x8,%esp
     e24:	68 18 4b 00 00       	push   $0x4b18
     e29:	6a 01                	push   $0x1
     e2b:	e8 bc 28 00 00       	call   36ec <printf>
      break;
     e30:	83 c4 10             	add    $0x10,%esp
    }
  }
  if(pid == 0)
     e33:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
     e36:	85 db                	test   %ebx,%ebx
     e38:	0f 84 ea 00 00 00    	je     f28 <sharedfd+0x188>
    exit();
  else
    wait();
     e3e:	e8 8c 27 00 00       	call   35cf <wait>
  close(fd);
     e43:	83 ec 0c             	sub    $0xc,%esp
     e46:	57                   	push   %edi
     e47:	e8 a3 27 00 00       	call   35ef <close>
  fd = open("sharedfd", 0);
     e4c:	5a                   	pop    %edx
     e4d:	59                   	pop    %ecx
     e4e:	6a 00                	push   $0x0
     e50:	68 27 3e 00 00       	push   $0x3e27
     e55:	e8 ad 27 00 00       	call   3607 <open>
     e5a:	89 45 d0             	mov    %eax,-0x30(%ebp)
  if(fd < 0){
     e5d:	83 c4 10             	add    $0x10,%esp
     e60:	85 c0                	test   %eax,%eax
     e62:	0f 88 a6 00 00 00    	js     f0e <sharedfd+0x16e>
     e68:	31 ff                	xor    %edi,%edi
     e6a:	8d 5d e8             	lea    -0x18(%ebp),%ebx
     e6d:	89 7d d4             	mov    %edi,-0x2c(%ebp)
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
     e70:	50                   	push   %eax
     e71:	6a 0a                	push   $0xa
     e73:	56                   	push   %esi
     e74:	ff 75 d0             	pushl  -0x30(%ebp)
     e77:	e8 63 27 00 00       	call   35df <read>
     e7c:	83 c4 10             	add    $0x10,%esp
     e7f:	85 c0                	test   %eax,%eax
     e81:	7e 24                	jle    ea7 <sharedfd+0x107>
     e83:	89 f1                	mov    %esi,%ecx
     e85:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     e88:	eb 0c                	jmp    e96 <sharedfd+0xf6>
     e8a:	66 90                	xchg   %ax,%ax
    for(i = 0; i < sizeof(buf); i++){
      if(buf[i] == 'c')
        nc++;
      if(buf[i] == 'p')
     e8c:	3c 70                	cmp    $0x70,%al
     e8e:	75 01                	jne    e91 <sharedfd+0xf1>
        np++;
     e90:	47                   	inc    %edi
     e91:	41                   	inc    %ecx
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i = 0; i < sizeof(buf); i++){
     e92:	39 cb                	cmp    %ecx,%ebx
     e94:	74 0c                	je     ea2 <sharedfd+0x102>
      if(buf[i] == 'c')
     e96:	8a 01                	mov    (%ecx),%al
     e98:	3c 63                	cmp    $0x63,%al
     e9a:	75 f0                	jne    e8c <sharedfd+0xec>
        nc++;
     e9c:	42                   	inc    %edx
     e9d:	41                   	inc    %ecx
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i = 0; i < sizeof(buf); i++){
     e9e:	39 cb                	cmp    %ecx,%ebx
     ea0:	75 f4                	jne    e96 <sharedfd+0xf6>
     ea2:	89 55 d4             	mov    %edx,-0x2c(%ebp)
     ea5:	eb c9                	jmp    e70 <sharedfd+0xd0>
     ea7:	89 7d cc             	mov    %edi,-0x34(%ebp)
     eaa:	8b 7d d4             	mov    -0x2c(%ebp),%edi
        nc++;
      if(buf[i] == 'p')
        np++;
    }
  }
  close(fd);
     ead:	83 ec 0c             	sub    $0xc,%esp
     eb0:	ff 75 d0             	pushl  -0x30(%ebp)
     eb3:	e8 37 27 00 00       	call   35ef <close>
  unlink("sharedfd");
     eb8:	c7 04 24 27 3e 00 00 	movl   $0x3e27,(%esp)
     ebf:	e8 53 27 00 00       	call   3617 <unlink>
  if(nc == 10000 && np == 10000){
     ec4:	83 c4 10             	add    $0x10,%esp
     ec7:	81 ff 10 27 00 00    	cmp    $0x2710,%edi
     ecd:	8b 55 cc             	mov    -0x34(%ebp),%edx
     ed0:	75 5b                	jne    f2d <sharedfd+0x18d>
     ed2:	81 fa 10 27 00 00    	cmp    $0x2710,%edx
     ed8:	75 53                	jne    f2d <sharedfd+0x18d>
    printf(1, "sharedfd ok\n");
     eda:	83 ec 08             	sub    $0x8,%esp
     edd:	68 30 3e 00 00       	push   $0x3e30
     ee2:	6a 01                	push   $0x1
     ee4:	e8 03 28 00 00       	call   36ec <printf>
     ee9:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    exit();
  }
}
     eec:	8d 65 f4             	lea    -0xc(%ebp),%esp
     eef:	5b                   	pop    %ebx
     ef0:	5e                   	pop    %esi
     ef1:	5f                   	pop    %edi
     ef2:	5d                   	pop    %ebp
     ef3:	c3                   	ret    
  printf(1, "sharedfd test\n");

  unlink("sharedfd");
  fd = open("sharedfd", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for writing");
     ef4:	83 ec 08             	sub    $0x8,%esp
     ef7:	68 ec 4a 00 00       	push   $0x4aec
     efc:	6a 01                	push   $0x1
     efe:	e8 e9 27 00 00       	call   36ec <printf>
    return;
     f03:	83 c4 10             	add    $0x10,%esp
    printf(1, "sharedfd ok\n");
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    exit();
  }
}
     f06:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f09:	5b                   	pop    %ebx
     f0a:	5e                   	pop    %esi
     f0b:	5f                   	pop    %edi
     f0c:	5d                   	pop    %ebp
     f0d:	c3                   	ret    
  else
    wait();
  close(fd);
  fd = open("sharedfd", 0);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for reading\n");
     f0e:	83 ec 08             	sub    $0x8,%esp
     f11:	68 38 4b 00 00       	push   $0x4b38
     f16:	6a 01                	push   $0x1
     f18:	e8 cf 27 00 00       	call   36ec <printf>
    return;
     f1d:	83 c4 10             	add    $0x10,%esp
    printf(1, "sharedfd ok\n");
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    exit();
  }
}
     f20:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f23:	5b                   	pop    %ebx
     f24:	5e                   	pop    %esi
     f25:	5f                   	pop    %edi
     f26:	5d                   	pop    %ebp
     f27:	c3                   	ret    
      printf(1, "fstests: write sharedfd failed\n");
      break;
    }
  }
  if(pid == 0)
    exit();
     f28:	e8 9a 26 00 00       	call   35c7 <exit>
  close(fd);
  unlink("sharedfd");
  if(nc == 10000 && np == 10000){
    printf(1, "sharedfd ok\n");
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
     f2d:	52                   	push   %edx
     f2e:	57                   	push   %edi
     f2f:	68 3d 3e 00 00       	push   $0x3e3d
     f34:	6a 01                	push   $0x1
     f36:	e8 b1 27 00 00       	call   36ec <printf>
    exit();
     f3b:	e8 87 26 00 00       	call   35c7 <exit>

00000f40 <fourfiles>:

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(void)
{
     f40:	55                   	push   %ebp
     f41:	89 e5                	mov    %esp,%ebp
     f43:	57                   	push   %edi
     f44:	56                   	push   %esi
     f45:	53                   	push   %ebx
     f46:	83 ec 34             	sub    $0x34,%esp
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
     f49:	be 84 51 00 00       	mov    $0x5184,%esi
     f4e:	b9 04 00 00 00       	mov    $0x4,%ecx
     f53:	8d 7d d8             	lea    -0x28(%ebp),%edi
     f56:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  char *fname;

  printf(1, "fourfiles test\n");
     f58:	68 52 3e 00 00       	push   $0x3e52
     f5d:	6a 01                	push   $0x1
     f5f:	e8 88 27 00 00       	call   36ec <printf>
     f64:	83 c4 10             	add    $0x10,%esp

  for(pi = 0; pi < 4; pi++){
     f67:	31 db                	xor    %ebx,%ebx
    fname = names[pi];
     f69:	8b 74 9d d8          	mov    -0x28(%ebp,%ebx,4),%esi
    unlink(fname);
     f6d:	83 ec 0c             	sub    $0xc,%esp
     f70:	56                   	push   %esi
     f71:	e8 a1 26 00 00       	call   3617 <unlink>

    pid = fork();
     f76:	e8 44 26 00 00       	call   35bf <fork>
    if(pid < 0){
     f7b:	83 c4 10             	add    $0x10,%esp
     f7e:	85 c0                	test   %eax,%eax
     f80:	0f 88 5c 01 00 00    	js     10e2 <fourfiles+0x1a2>
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
     f86:	0f 84 c6 00 00 00    	je     1052 <fourfiles+0x112>
  char *names[] = { "f0", "f1", "f2", "f3" };
  char *fname;

  printf(1, "fourfiles test\n");

  for(pi = 0; pi < 4; pi++){
     f8c:	43                   	inc    %ebx
     f8d:	83 fb 04             	cmp    $0x4,%ebx
     f90:	75 d7                	jne    f69 <fourfiles+0x29>
      exit();
    }
  }

  for(pi = 0; pi < 4; pi++){
    wait();
     f92:	e8 38 26 00 00       	call   35cf <wait>
     f97:	e8 33 26 00 00       	call   35cf <wait>
     f9c:	e8 2e 26 00 00       	call   35cf <wait>
     fa1:	e8 29 26 00 00       	call   35cf <wait>
     fa6:	bf 30 00 00 00       	mov    $0x30,%edi
  }

  for(i = 0; i < 2; i++){
    fname = names[i];
     fab:	8b 84 bd 18 ff ff ff 	mov    -0xe8(%ebp,%edi,4),%eax
     fb2:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    fd = open(fname, 0);
     fb5:	83 ec 08             	sub    $0x8,%esp
     fb8:	6a 00                	push   $0x0
     fba:	50                   	push   %eax
     fbb:	e8 47 26 00 00       	call   3607 <open>
     fc0:	89 c3                	mov    %eax,%ebx
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
     fc2:	83 c4 10             	add    $0x10,%esp
  }

  for(i = 0; i < 2; i++){
    fname = names[i];
    fd = open(fname, 0);
    total = 0;
     fc5:	31 f6                	xor    %esi,%esi
     fc7:	90                   	nop
    while((n = read(fd, buf, sizeof(buf))) > 0){
     fc8:	52                   	push   %edx
     fc9:	68 00 20 00 00       	push   $0x2000
     fce:	68 60 82 00 00       	push   $0x8260
     fd3:	53                   	push   %ebx
     fd4:	e8 06 26 00 00       	call   35df <read>
     fd9:	83 c4 10             	add    $0x10,%esp
     fdc:	85 c0                	test   %eax,%eax
     fde:	7e 18                	jle    ff8 <fourfiles+0xb8>
     fe0:	31 d2                	xor    %edx,%edx
     fe2:	66 90                	xchg   %ax,%ax
      for(j = 0; j < n; j++){
        if(buf[j] != '0'+i){
     fe4:	0f be 8a 60 82 00 00 	movsbl 0x8260(%edx),%ecx
     feb:	39 cf                	cmp    %ecx,%edi
     fed:	75 4f                	jne    103e <fourfiles+0xfe>
  for(i = 0; i < 2; i++){
    fname = names[i];
    fd = open(fname, 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
     fef:	42                   	inc    %edx
     ff0:	39 d0                	cmp    %edx,%eax
     ff2:	75 f0                	jne    fe4 <fourfiles+0xa4>
        if(buf[j] != '0'+i){
          printf(1, "wrong char\n");
          exit();
        }
      }
      total += n;
     ff4:	01 c6                	add    %eax,%esi
     ff6:	eb d0                	jmp    fc8 <fourfiles+0x88>
    }
    close(fd);
     ff8:	83 ec 0c             	sub    $0xc,%esp
     ffb:	53                   	push   %ebx
     ffc:	e8 ee 25 00 00       	call   35ef <close>
    if(total != 12*500){
    1001:	83 c4 10             	add    $0x10,%esp
    1004:	81 fe 70 17 00 00    	cmp    $0x1770,%esi
    100a:	0f 85 bf 00 00 00    	jne    10cf <fourfiles+0x18f>
      printf(1, "wrong length %d\n", total);
      exit();
    }
    unlink(fname);
    1010:	83 ec 0c             	sub    $0xc,%esp
    1013:	ff 75 d4             	pushl  -0x2c(%ebp)
    1016:	e8 fc 25 00 00       	call   3617 <unlink>
    101b:	47                   	inc    %edi

  for(pi = 0; pi < 4; pi++){
    wait();
  }

  for(i = 0; i < 2; i++){
    101c:	83 c4 10             	add    $0x10,%esp
    101f:	83 ff 32             	cmp    $0x32,%edi
    1022:	75 87                	jne    fab <fourfiles+0x6b>
      exit();
    }
    unlink(fname);
  }

  printf(1, "fourfiles ok\n");
    1024:	83 ec 08             	sub    $0x8,%esp
    1027:	68 90 3e 00 00       	push   $0x3e90
    102c:	6a 01                	push   $0x1
    102e:	e8 b9 26 00 00       	call   36ec <printf>
}
    1033:	83 c4 10             	add    $0x10,%esp
    1036:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1039:	5b                   	pop    %ebx
    103a:	5e                   	pop    %esi
    103b:	5f                   	pop    %edi
    103c:	5d                   	pop    %ebp
    103d:	c3                   	ret    
    fd = open(fname, 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
        if(buf[j] != '0'+i){
          printf(1, "wrong char\n");
    103e:	83 ec 08             	sub    $0x8,%esp
    1041:	68 73 3e 00 00       	push   $0x3e73
    1046:	6a 01                	push   $0x1
    1048:	e8 9f 26 00 00       	call   36ec <printf>
          exit();
    104d:	e8 75 25 00 00       	call   35c7 <exit>
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
      fd = open(fname, O_CREATE | O_RDWR);
    1052:	83 ec 08             	sub    $0x8,%esp
    1055:	68 02 02 00 00       	push   $0x202
    105a:	56                   	push   %esi
    105b:	e8 a7 25 00 00       	call   3607 <open>
    1060:	89 c6                	mov    %eax,%esi
      if(fd < 0){
    1062:	83 c4 10             	add    $0x10,%esp
    1065:	85 c0                	test   %eax,%eax
    1067:	78 52                	js     10bb <fourfiles+0x17b>
        printf(1, "create failed\n");
        exit();
      }

      memset(buf, '0'+pi, 512);
    1069:	50                   	push   %eax
    106a:	68 00 02 00 00       	push   $0x200
    106f:	83 c3 30             	add    $0x30,%ebx
    1072:	53                   	push   %ebx
    1073:	68 60 82 00 00       	push   $0x8260
    1078:	e8 17 24 00 00       	call   3494 <memset>
    107d:	83 c4 10             	add    $0x10,%esp
    1080:	bb 0c 00 00 00       	mov    $0xc,%ebx
      for(i = 0; i < 12; i++){
        if((n = write(fd, buf, 500)) != 500){
    1085:	57                   	push   %edi
    1086:	68 f4 01 00 00       	push   $0x1f4
    108b:	68 60 82 00 00       	push   $0x8260
    1090:	56                   	push   %esi
    1091:	e8 51 25 00 00       	call   35e7 <write>
    1096:	83 c4 10             	add    $0x10,%esp
    1099:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    109e:	75 08                	jne    10a8 <fourfiles+0x168>
        printf(1, "create failed\n");
        exit();
      }

      memset(buf, '0'+pi, 512);
      for(i = 0; i < 12; i++){
    10a0:	4b                   	dec    %ebx
    10a1:	75 e2                	jne    1085 <fourfiles+0x145>
        if((n = write(fd, buf, 500)) != 500){
          printf(1, "write failed %d\n", n);
          exit();
        }
      }
      exit();
    10a3:	e8 1f 25 00 00       	call   35c7 <exit>
      }

      memset(buf, '0'+pi, 512);
      for(i = 0; i < 12; i++){
        if((n = write(fd, buf, 500)) != 500){
          printf(1, "write failed %d\n", n);
    10a8:	51                   	push   %ecx
    10a9:	50                   	push   %eax
    10aa:	68 62 3e 00 00       	push   $0x3e62
    10af:	6a 01                	push   $0x1
    10b1:	e8 36 26 00 00       	call   36ec <printf>
          exit();
    10b6:	e8 0c 25 00 00       	call   35c7 <exit>
    }

    if(pid == 0){
      fd = open(fname, O_CREATE | O_RDWR);
      if(fd < 0){
        printf(1, "create failed\n");
    10bb:	83 ec 08             	sub    $0x8,%esp
    10be:	68 f3 40 00 00       	push   $0x40f3
    10c3:	6a 01                	push   $0x1
    10c5:	e8 22 26 00 00       	call   36ec <printf>
        exit();
    10ca:	e8 f8 24 00 00       	call   35c7 <exit>
      }
      total += n;
    }
    close(fd);
    if(total != 12*500){
      printf(1, "wrong length %d\n", total);
    10cf:	50                   	push   %eax
    10d0:	56                   	push   %esi
    10d1:	68 7f 3e 00 00       	push   $0x3e7f
    10d6:	6a 01                	push   $0x1
    10d8:	e8 0f 26 00 00       	call   36ec <printf>
      exit();
    10dd:	e8 e5 24 00 00       	call   35c7 <exit>
    fname = names[pi];
    unlink(fname);

    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
    10e2:	83 ec 08             	sub    $0x8,%esp
    10e5:	68 2d 49 00 00       	push   $0x492d
    10ea:	6a 01                	push   $0x1
    10ec:	e8 fb 25 00 00       	call   36ec <printf>
      exit();
    10f1:	e8 d1 24 00 00       	call   35c7 <exit>
    10f6:	66 90                	xchg   %ax,%ax

000010f8 <createdelete>:
}

// four processes create and delete different files in same directory
void
createdelete(void)
{
    10f8:	55                   	push   %ebp
    10f9:	89 e5                	mov    %esp,%ebp
    10fb:	57                   	push   %edi
    10fc:	56                   	push   %esi
    10fd:	53                   	push   %ebx
    10fe:	83 ec 44             	sub    $0x44,%esp
  enum { N = 20 };
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");
    1101:	68 a4 3e 00 00       	push   $0x3ea4
    1106:	6a 01                	push   $0x1
    1108:	e8 df 25 00 00       	call   36ec <printf>
    110d:	83 c4 10             	add    $0x10,%esp

  for(pi = 0; pi < 4; pi++){
    1110:	31 db                	xor    %ebx,%ebx
    pid = fork();
    1112:	e8 a8 24 00 00       	call   35bf <fork>
    if(pid < 0){
    1117:	85 c0                	test   %eax,%eax
    1119:	0f 88 6c 01 00 00    	js     128b <createdelete+0x193>
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
    111f:	0f 84 d3 00 00 00    	je     11f8 <createdelete+0x100>
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");

  for(pi = 0; pi < 4; pi++){
    1125:	43                   	inc    %ebx
    1126:	83 fb 04             	cmp    $0x4,%ebx
    1129:	75 e7                	jne    1112 <createdelete+0x1a>
      exit();
    }
  }

  for(pi = 0; pi < 4; pi++){
    wait();
    112b:	e8 9f 24 00 00       	call   35cf <wait>
    1130:	e8 9a 24 00 00       	call   35cf <wait>
    1135:	e8 95 24 00 00       	call   35cf <wait>
    113a:	e8 90 24 00 00       	call   35cf <wait>
  }

  name[0] = name[1] = name[2] = 0;
    113f:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
  for(i = 0; i < N; i++){
    1143:	31 f6                	xor    %esi,%esi
    1145:	8d 7d c8             	lea    -0x38(%ebp),%edi
    1148:	8d 46 30             	lea    0x30(%esi),%eax
    114b:	88 45 c7             	mov    %al,-0x39(%ebp)
      exit();
    }

    if(pid == 0){
      name[0] = 'p' + pi;
      name[2] = '\0';
    114e:	b3 70                	mov    $0x70,%bl
      name[1] = '0' + i;
      fd = open(name, 0);
      if((i == 0 || i >= N/2) && fd < 0){
        printf(1, "oops createdelete %s didn't exist\n", name);
        exit();
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1150:	8d 46 ff             	lea    -0x1(%esi),%eax
    1153:	89 45 c0             	mov    %eax,-0x40(%ebp)
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + pi;
    1156:	88 5d c8             	mov    %bl,-0x38(%ebp)
      name[1] = '0' + i;
    1159:	8a 45 c7             	mov    -0x39(%ebp),%al
    115c:	88 45 c9             	mov    %al,-0x37(%ebp)
      fd = open(name, 0);
    115f:	83 ec 08             	sub    $0x8,%esp
    1162:	6a 00                	push   $0x0
    1164:	57                   	push   %edi
    1165:	e8 9d 24 00 00       	call   3607 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    116a:	83 c4 10             	add    $0x10,%esp
    116d:	85 f6                	test   %esi,%esi
    116f:	74 05                	je     1176 <createdelete+0x7e>
    1171:	83 fe 09             	cmp    $0x9,%esi
    1174:	7e 6a                	jle    11e0 <createdelete+0xe8>
    1176:	85 c0                	test   %eax,%eax
    1178:	0f 88 fa 00 00 00    	js     1278 <createdelete+0x180>
        printf(1, "oops createdelete %s didn't exist\n", name);
        exit();
      } else if((i >= 1 && i < N/2) && fd >= 0){
    117e:	83 7d c0 08          	cmpl   $0x8,-0x40(%ebp)
    1182:	76 60                	jbe    11e4 <createdelete+0xec>
        printf(1, "oops createdelete %s did exist\n", name);
        exit();
      }
      if(fd >= 0)
        close(fd);
    1184:	83 ec 0c             	sub    $0xc,%esp
    1187:	50                   	push   %eax
    1188:	e8 62 24 00 00       	call   35ef <close>
    118d:	83 c4 10             	add    $0x10,%esp
    1190:	43                   	inc    %ebx
    wait();
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
    1191:	80 fb 74             	cmp    $0x74,%bl
    1194:	75 c0                	jne    1156 <createdelete+0x5e>
  for(pi = 0; pi < 4; pi++){
    wait();
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    1196:	46                   	inc    %esi
    1197:	83 fe 14             	cmp    $0x14,%esi
    119a:	75 ac                	jne    1148 <createdelete+0x50>
    119c:	b3 70                	mov    $0x70,%bl
    119e:	66 90                	xchg   %ax,%ax
    11a0:	8d 43 c0             	lea    -0x40(%ebx),%eax
    11a3:	88 45 c7             	mov    %al,-0x39(%ebp)
    11a6:	be 04 00 00 00       	mov    $0x4,%esi
    }
  }

  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + i;
    11ab:	88 5d c8             	mov    %bl,-0x38(%ebp)
      name[1] = '0' + i;
    11ae:	8a 45 c7             	mov    -0x39(%ebp),%al
    11b1:	88 45 c9             	mov    %al,-0x37(%ebp)
      unlink(name);
    11b4:	83 ec 0c             	sub    $0xc,%esp
    11b7:	57                   	push   %edi
    11b8:	e8 5a 24 00 00       	call   3617 <unlink>
        close(fd);
    }
  }

  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
    11bd:	83 c4 10             	add    $0x10,%esp
    11c0:	4e                   	dec    %esi
    11c1:	75 e8                	jne    11ab <createdelete+0xb3>
    11c3:	43                   	inc    %ebx
      if(fd >= 0)
        close(fd);
    }
  }

  for(i = 0; i < N; i++){
    11c4:	80 fb 84             	cmp    $0x84,%bl
    11c7:	75 d7                	jne    11a0 <createdelete+0xa8>
      name[1] = '0' + i;
      unlink(name);
    }
  }

  printf(1, "createdelete ok\n");
    11c9:	83 ec 08             	sub    $0x8,%esp
    11cc:	68 b7 3e 00 00       	push   $0x3eb7
    11d1:	6a 01                	push   $0x1
    11d3:	e8 14 25 00 00       	call   36ec <printf>
}
    11d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11db:	5b                   	pop    %ebx
    11dc:	5e                   	pop    %esi
    11dd:	5f                   	pop    %edi
    11de:	5d                   	pop    %ebp
    11df:	c3                   	ret    
      name[1] = '0' + i;
      fd = open(name, 0);
      if((i == 0 || i >= N/2) && fd < 0){
        printf(1, "oops createdelete %s didn't exist\n", name);
        exit();
      } else if((i >= 1 && i < N/2) && fd >= 0){
    11e0:	85 c0                	test   %eax,%eax
    11e2:	78 ac                	js     1190 <createdelete+0x98>
        printf(1, "oops createdelete %s did exist\n", name);
    11e4:	50                   	push   %eax
    11e5:	57                   	push   %edi
    11e6:	68 88 4b 00 00       	push   $0x4b88
    11eb:	6a 01                	push   $0x1
    11ed:	e8 fa 24 00 00       	call   36ec <printf>
        exit();
    11f2:	e8 d0 23 00 00       	call   35c7 <exit>
    11f7:	90                   	nop
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
      name[0] = 'p' + pi;
    11f8:	83 c3 70             	add    $0x70,%ebx
    11fb:	88 5d c8             	mov    %bl,-0x38(%ebp)
      name[2] = '\0';
    11fe:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    1202:	be 01 00 00 00       	mov    $0x1,%esi
    1207:	31 db                	xor    %ebx,%ebx
    1209:	8d 7d c8             	lea    -0x38(%ebp),%edi
      for(i = 0; i < N; i++){
        name[1] = '0' + i;
    120c:	8d 43 30             	lea    0x30(%ebx),%eax
    120f:	88 45 c9             	mov    %al,-0x37(%ebp)
        fd = open(name, O_CREATE | O_RDWR);
    1212:	83 ec 08             	sub    $0x8,%esp
    1215:	68 02 02 00 00       	push   $0x202
    121a:	57                   	push   %edi
    121b:	e8 e7 23 00 00       	call   3607 <open>
        if(fd < 0){
    1220:	83 c4 10             	add    $0x10,%esp
    1223:	85 c0                	test   %eax,%eax
    1225:	78 78                	js     129f <createdelete+0x1a7>
          printf(1, "create failed\n");
          exit();
        }
        close(fd);
    1227:	83 ec 0c             	sub    $0xc,%esp
    122a:	50                   	push   %eax
    122b:	e8 bf 23 00 00       	call   35ef <close>
        if(i > 0 && (i % 2 ) == 0){
    1230:	83 c4 10             	add    $0x10,%esp
    1233:	85 db                	test   %ebx,%ebx
    1235:	74 0a                	je     1241 <createdelete+0x149>
    1237:	f6 c3 01             	test   $0x1,%bl
    123a:	74 0e                	je     124a <createdelete+0x152>
    }

    if(pid == 0){
      name[0] = 'p' + pi;
      name[2] = '\0';
      for(i = 0; i < N; i++){
    123c:	83 fe 14             	cmp    $0x14,%esi
    123f:	74 04                	je     1245 <createdelete+0x14d>
    1241:	43                   	inc    %ebx
    1242:	46                   	inc    %esi
    1243:	eb c7                	jmp    120c <createdelete+0x114>
            printf(1, "unlink failed\n");
            exit();
          }
        }
      }
      exit();
    1245:	e8 7d 23 00 00       	call   35c7 <exit>
          printf(1, "create failed\n");
          exit();
        }
        close(fd);
        if(i > 0 && (i % 2 ) == 0){
          name[1] = '0' + (i / 2);
    124a:	89 d8                	mov    %ebx,%eax
    124c:	d1 f8                	sar    %eax
    124e:	83 c0 30             	add    $0x30,%eax
    1251:	88 45 c9             	mov    %al,-0x37(%ebp)
          if(unlink(name) < 0){
    1254:	83 ec 0c             	sub    $0xc,%esp
    1257:	57                   	push   %edi
    1258:	e8 ba 23 00 00       	call   3617 <unlink>
    125d:	83 c4 10             	add    $0x10,%esp
    1260:	85 c0                	test   %eax,%eax
    1262:	79 d8                	jns    123c <createdelete+0x144>
            printf(1, "unlink failed\n");
    1264:	83 ec 08             	sub    $0x8,%esp
    1267:	68 a5 3a 00 00       	push   $0x3aa5
    126c:	6a 01                	push   $0x1
    126e:	e8 79 24 00 00       	call   36ec <printf>
            exit();
    1273:	e8 4f 23 00 00       	call   35c7 <exit>
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + pi;
      name[1] = '0' + i;
      fd = open(name, 0);
      if((i == 0 || i >= N/2) && fd < 0){
        printf(1, "oops createdelete %s didn't exist\n", name);
    1278:	52                   	push   %edx
    1279:	57                   	push   %edi
    127a:	68 64 4b 00 00       	push   $0x4b64
    127f:	6a 01                	push   $0x1
    1281:	e8 66 24 00 00       	call   36ec <printf>
        exit();
    1286:	e8 3c 23 00 00       	call   35c7 <exit>
  printf(1, "createdelete test\n");

  for(pi = 0; pi < 4; pi++){
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
    128b:	83 ec 08             	sub    $0x8,%esp
    128e:	68 2d 49 00 00       	push   $0x492d
    1293:	6a 01                	push   $0x1
    1295:	e8 52 24 00 00       	call   36ec <printf>
      exit();
    129a:	e8 28 23 00 00       	call   35c7 <exit>
      name[2] = '\0';
      for(i = 0; i < N; i++){
        name[1] = '0' + i;
        fd = open(name, O_CREATE | O_RDWR);
        if(fd < 0){
          printf(1, "create failed\n");
    129f:	83 ec 08             	sub    $0x8,%esp
    12a2:	68 f3 40 00 00       	push   $0x40f3
    12a7:	6a 01                	push   $0x1
    12a9:	e8 3e 24 00 00       	call   36ec <printf>
          exit();
    12ae:	e8 14 23 00 00       	call   35c7 <exit>
    12b3:	90                   	nop

000012b4 <unlinkread>:
}

// can I unlink a file and still read it?
void
unlinkread(void)
{
    12b4:	55                   	push   %ebp
    12b5:	89 e5                	mov    %esp,%ebp
    12b7:	56                   	push   %esi
    12b8:	53                   	push   %ebx
  int fd, fd1;

  printf(1, "unlinkread test\n");
    12b9:	83 ec 08             	sub    $0x8,%esp
    12bc:	68 c8 3e 00 00       	push   $0x3ec8
    12c1:	6a 01                	push   $0x1
    12c3:	e8 24 24 00 00       	call   36ec <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
    12c8:	5b                   	pop    %ebx
    12c9:	5e                   	pop    %esi
    12ca:	68 02 02 00 00       	push   $0x202
    12cf:	68 d9 3e 00 00       	push   $0x3ed9
    12d4:	e8 2e 23 00 00       	call   3607 <open>
  if(fd < 0){
    12d9:	83 c4 10             	add    $0x10,%esp
    12dc:	85 c0                	test   %eax,%eax
    12de:	0f 88 e2 00 00 00    	js     13c6 <unlinkread+0x112>
    12e4:	89 c3                	mov    %eax,%ebx
    printf(1, "create unlinkread failed\n");
    exit();
  }
  write(fd, "hello", 5);
    12e6:	50                   	push   %eax
    12e7:	6a 05                	push   $0x5
    12e9:	68 fe 3e 00 00       	push   $0x3efe
    12ee:	53                   	push   %ebx
    12ef:	e8 f3 22 00 00       	call   35e7 <write>
  close(fd);
    12f4:	89 1c 24             	mov    %ebx,(%esp)
    12f7:	e8 f3 22 00 00       	call   35ef <close>

  fd = open("unlinkread", O_RDWR);
    12fc:	58                   	pop    %eax
    12fd:	5a                   	pop    %edx
    12fe:	6a 02                	push   $0x2
    1300:	68 d9 3e 00 00       	push   $0x3ed9
    1305:	e8 fd 22 00 00       	call   3607 <open>
    130a:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    130c:	83 c4 10             	add    $0x10,%esp
    130f:	85 c0                	test   %eax,%eax
    1311:	0f 88 0e 01 00 00    	js     1425 <unlinkread+0x171>
    printf(1, "open unlinkread failed\n");
    exit();
  }
  if(unlink("unlinkread") != 0){
    1317:	83 ec 0c             	sub    $0xc,%esp
    131a:	68 d9 3e 00 00       	push   $0x3ed9
    131f:	e8 f3 22 00 00       	call   3617 <unlink>
    1324:	83 c4 10             	add    $0x10,%esp
    1327:	85 c0                	test   %eax,%eax
    1329:	0f 85 e3 00 00 00    	jne    1412 <unlinkread+0x15e>
    printf(1, "unlink unlinkread failed\n");
    exit();
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    132f:	83 ec 08             	sub    $0x8,%esp
    1332:	68 02 02 00 00       	push   $0x202
    1337:	68 d9 3e 00 00       	push   $0x3ed9
    133c:	e8 c6 22 00 00       	call   3607 <open>
    1341:	89 c6                	mov    %eax,%esi
  write(fd1, "yyy", 3);
    1343:	83 c4 0c             	add    $0xc,%esp
    1346:	6a 03                	push   $0x3
    1348:	68 36 3f 00 00       	push   $0x3f36
    134d:	50                   	push   %eax
    134e:	e8 94 22 00 00       	call   35e7 <write>
  close(fd1);
    1353:	89 34 24             	mov    %esi,(%esp)
    1356:	e8 94 22 00 00       	call   35ef <close>

  if(read(fd, buf, sizeof(buf)) != 5){
    135b:	83 c4 0c             	add    $0xc,%esp
    135e:	68 00 20 00 00       	push   $0x2000
    1363:	68 60 82 00 00       	push   $0x8260
    1368:	53                   	push   %ebx
    1369:	e8 71 22 00 00       	call   35df <read>
    136e:	83 c4 10             	add    $0x10,%esp
    1371:	83 f8 05             	cmp    $0x5,%eax
    1374:	0f 85 85 00 00 00    	jne    13ff <unlinkread+0x14b>
    printf(1, "unlinkread read failed");
    exit();
  }
  if(buf[0] != 'h'){
    137a:	80 3d 60 82 00 00 68 	cmpb   $0x68,0x8260
    1381:	75 69                	jne    13ec <unlinkread+0x138>
    printf(1, "unlinkread wrong data\n");
    exit();
  }
  if(write(fd, buf, 10) != 10){
    1383:	56                   	push   %esi
    1384:	6a 0a                	push   $0xa
    1386:	68 60 82 00 00       	push   $0x8260
    138b:	53                   	push   %ebx
    138c:	e8 56 22 00 00       	call   35e7 <write>
    1391:	83 c4 10             	add    $0x10,%esp
    1394:	83 f8 0a             	cmp    $0xa,%eax
    1397:	75 40                	jne    13d9 <unlinkread+0x125>
    printf(1, "unlinkread write failed\n");
    exit();
  }
  close(fd);
    1399:	83 ec 0c             	sub    $0xc,%esp
    139c:	53                   	push   %ebx
    139d:	e8 4d 22 00 00       	call   35ef <close>
  unlink("unlinkread");
    13a2:	c7 04 24 d9 3e 00 00 	movl   $0x3ed9,(%esp)
    13a9:	e8 69 22 00 00       	call   3617 <unlink>
  printf(1, "unlinkread ok\n");
    13ae:	58                   	pop    %eax
    13af:	5a                   	pop    %edx
    13b0:	68 81 3f 00 00       	push   $0x3f81
    13b5:	6a 01                	push   $0x1
    13b7:	e8 30 23 00 00       	call   36ec <printf>
}
    13bc:	83 c4 10             	add    $0x10,%esp
    13bf:	8d 65 f8             	lea    -0x8(%ebp),%esp
    13c2:	5b                   	pop    %ebx
    13c3:	5e                   	pop    %esi
    13c4:	5d                   	pop    %ebp
    13c5:	c3                   	ret    
  int fd, fd1;

  printf(1, "unlinkread test\n");
  fd = open("unlinkread", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create unlinkread failed\n");
    13c6:	51                   	push   %ecx
    13c7:	51                   	push   %ecx
    13c8:	68 e4 3e 00 00       	push   $0x3ee4
    13cd:	6a 01                	push   $0x1
    13cf:	e8 18 23 00 00       	call   36ec <printf>
    exit();
    13d4:	e8 ee 21 00 00       	call   35c7 <exit>
  if(buf[0] != 'h'){
    printf(1, "unlinkread wrong data\n");
    exit();
  }
  if(write(fd, buf, 10) != 10){
    printf(1, "unlinkread write failed\n");
    13d9:	51                   	push   %ecx
    13da:	51                   	push   %ecx
    13db:	68 68 3f 00 00       	push   $0x3f68
    13e0:	6a 01                	push   $0x1
    13e2:	e8 05 23 00 00       	call   36ec <printf>
    exit();
    13e7:	e8 db 21 00 00       	call   35c7 <exit>
  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "unlinkread read failed");
    exit();
  }
  if(buf[0] != 'h'){
    printf(1, "unlinkread wrong data\n");
    13ec:	50                   	push   %eax
    13ed:	50                   	push   %eax
    13ee:	68 51 3f 00 00       	push   $0x3f51
    13f3:	6a 01                	push   $0x1
    13f5:	e8 f2 22 00 00       	call   36ec <printf>
    exit();
    13fa:	e8 c8 21 00 00       	call   35c7 <exit>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
  write(fd1, "yyy", 3);
  close(fd1);

  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "unlinkread read failed");
    13ff:	50                   	push   %eax
    1400:	50                   	push   %eax
    1401:	68 3a 3f 00 00       	push   $0x3f3a
    1406:	6a 01                	push   $0x1
    1408:	e8 df 22 00 00       	call   36ec <printf>
    exit();
    140d:	e8 b5 21 00 00       	call   35c7 <exit>
  if(fd < 0){
    printf(1, "open unlinkread failed\n");
    exit();
  }
  if(unlink("unlinkread") != 0){
    printf(1, "unlink unlinkread failed\n");
    1412:	50                   	push   %eax
    1413:	50                   	push   %eax
    1414:	68 1c 3f 00 00       	push   $0x3f1c
    1419:	6a 01                	push   $0x1
    141b:	e8 cc 22 00 00       	call   36ec <printf>
    exit();
    1420:	e8 a2 21 00 00       	call   35c7 <exit>
  write(fd, "hello", 5);
  close(fd);

  fd = open("unlinkread", O_RDWR);
  if(fd < 0){
    printf(1, "open unlinkread failed\n");
    1425:	50                   	push   %eax
    1426:	50                   	push   %eax
    1427:	68 04 3f 00 00       	push   $0x3f04
    142c:	6a 01                	push   $0x1
    142e:	e8 b9 22 00 00       	call   36ec <printf>
    exit();
    1433:	e8 8f 21 00 00       	call   35c7 <exit>

00001438 <linktest>:
  printf(1, "unlinkread ok\n");
}

void
linktest(void)
{
    1438:	55                   	push   %ebp
    1439:	89 e5                	mov    %esp,%ebp
    143b:	53                   	push   %ebx
    143c:	83 ec 0c             	sub    $0xc,%esp
  int fd;

  printf(1, "linktest\n");
    143f:	68 90 3f 00 00       	push   $0x3f90
    1444:	6a 01                	push   $0x1
    1446:	e8 a1 22 00 00       	call   36ec <printf>

  unlink("lf1");
    144b:	c7 04 24 9a 3f 00 00 	movl   $0x3f9a,(%esp)
    1452:	e8 c0 21 00 00       	call   3617 <unlink>
  unlink("lf2");
    1457:	c7 04 24 9e 3f 00 00 	movl   $0x3f9e,(%esp)
    145e:	e8 b4 21 00 00       	call   3617 <unlink>

  fd = open("lf1", O_CREATE|O_RDWR);
    1463:	58                   	pop    %eax
    1464:	5a                   	pop    %edx
    1465:	68 02 02 00 00       	push   $0x202
    146a:	68 9a 3f 00 00       	push   $0x3f9a
    146f:	e8 93 21 00 00       	call   3607 <open>
  if(fd < 0){
    1474:	83 c4 10             	add    $0x10,%esp
    1477:	85 c0                	test   %eax,%eax
    1479:	0f 88 1a 01 00 00    	js     1599 <linktest+0x161>
    147f:	89 c3                	mov    %eax,%ebx
    printf(1, "create lf1 failed\n");
    exit();
  }
  if(write(fd, "hello", 5) != 5){
    1481:	50                   	push   %eax
    1482:	6a 05                	push   $0x5
    1484:	68 fe 3e 00 00       	push   $0x3efe
    1489:	53                   	push   %ebx
    148a:	e8 58 21 00 00       	call   35e7 <write>
    148f:	83 c4 10             	add    $0x10,%esp
    1492:	83 f8 05             	cmp    $0x5,%eax
    1495:	0f 85 96 01 00 00    	jne    1631 <linktest+0x1f9>
    printf(1, "write lf1 failed\n");
    exit();
  }
  close(fd);
    149b:	83 ec 0c             	sub    $0xc,%esp
    149e:	53                   	push   %ebx
    149f:	e8 4b 21 00 00       	call   35ef <close>

  if(link("lf1", "lf2") < 0){
    14a4:	5b                   	pop    %ebx
    14a5:	58                   	pop    %eax
    14a6:	68 9e 3f 00 00       	push   $0x3f9e
    14ab:	68 9a 3f 00 00       	push   $0x3f9a
    14b0:	e8 72 21 00 00       	call   3627 <link>
    14b5:	83 c4 10             	add    $0x10,%esp
    14b8:	85 c0                	test   %eax,%eax
    14ba:	0f 88 5e 01 00 00    	js     161e <linktest+0x1e6>
    printf(1, "link lf1 lf2 failed\n");
    exit();
  }
  unlink("lf1");
    14c0:	83 ec 0c             	sub    $0xc,%esp
    14c3:	68 9a 3f 00 00       	push   $0x3f9a
    14c8:	e8 4a 21 00 00       	call   3617 <unlink>

  if(open("lf1", 0) >= 0){
    14cd:	58                   	pop    %eax
    14ce:	5a                   	pop    %edx
    14cf:	6a 00                	push   $0x0
    14d1:	68 9a 3f 00 00       	push   $0x3f9a
    14d6:	e8 2c 21 00 00       	call   3607 <open>
    14db:	83 c4 10             	add    $0x10,%esp
    14de:	85 c0                	test   %eax,%eax
    14e0:	0f 89 25 01 00 00    	jns    160b <linktest+0x1d3>
    printf(1, "unlinked lf1 but it is still there!\n");
    exit();
  }

  fd = open("lf2", 0);
    14e6:	83 ec 08             	sub    $0x8,%esp
    14e9:	6a 00                	push   $0x0
    14eb:	68 9e 3f 00 00       	push   $0x3f9e
    14f0:	e8 12 21 00 00       	call   3607 <open>
    14f5:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    14f7:	83 c4 10             	add    $0x10,%esp
    14fa:	85 c0                	test   %eax,%eax
    14fc:	0f 88 f6 00 00 00    	js     15f8 <linktest+0x1c0>
    printf(1, "open lf2 failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    1502:	50                   	push   %eax
    1503:	68 00 20 00 00       	push   $0x2000
    1508:	68 60 82 00 00       	push   $0x8260
    150d:	53                   	push   %ebx
    150e:	e8 cc 20 00 00       	call   35df <read>
    1513:	83 c4 10             	add    $0x10,%esp
    1516:	83 f8 05             	cmp    $0x5,%eax
    1519:	0f 85 c6 00 00 00    	jne    15e5 <linktest+0x1ad>
    printf(1, "read lf2 failed\n");
    exit();
  }
  close(fd);
    151f:	83 ec 0c             	sub    $0xc,%esp
    1522:	53                   	push   %ebx
    1523:	e8 c7 20 00 00       	call   35ef <close>

  if(link("lf2", "lf2") >= 0){
    1528:	58                   	pop    %eax
    1529:	5a                   	pop    %edx
    152a:	68 9e 3f 00 00       	push   $0x3f9e
    152f:	68 9e 3f 00 00       	push   $0x3f9e
    1534:	e8 ee 20 00 00       	call   3627 <link>
    1539:	83 c4 10             	add    $0x10,%esp
    153c:	85 c0                	test   %eax,%eax
    153e:	0f 89 8e 00 00 00    	jns    15d2 <linktest+0x19a>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    exit();
  }

  unlink("lf2");
    1544:	83 ec 0c             	sub    $0xc,%esp
    1547:	68 9e 3f 00 00       	push   $0x3f9e
    154c:	e8 c6 20 00 00       	call   3617 <unlink>
  if(link("lf2", "lf1") >= 0){
    1551:	59                   	pop    %ecx
    1552:	5b                   	pop    %ebx
    1553:	68 9a 3f 00 00       	push   $0x3f9a
    1558:	68 9e 3f 00 00       	push   $0x3f9e
    155d:	e8 c5 20 00 00       	call   3627 <link>
    1562:	83 c4 10             	add    $0x10,%esp
    1565:	85 c0                	test   %eax,%eax
    1567:	79 56                	jns    15bf <linktest+0x187>
    printf(1, "link non-existant succeeded! oops\n");
    exit();
  }

  if(link(".", "lf1") >= 0){
    1569:	83 ec 08             	sub    $0x8,%esp
    156c:	68 9a 3f 00 00       	push   $0x3f9a
    1571:	68 62 42 00 00       	push   $0x4262
    1576:	e8 ac 20 00 00       	call   3627 <link>
    157b:	83 c4 10             	add    $0x10,%esp
    157e:	85 c0                	test   %eax,%eax
    1580:	79 2a                	jns    15ac <linktest+0x174>
    printf(1, "link . lf1 succeeded! oops\n");
    exit();
  }

  printf(1, "linktest ok\n");
    1582:	83 ec 08             	sub    $0x8,%esp
    1585:	68 38 40 00 00       	push   $0x4038
    158a:	6a 01                	push   $0x1
    158c:	e8 5b 21 00 00       	call   36ec <printf>
}
    1591:	83 c4 10             	add    $0x10,%esp
    1594:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1597:	c9                   	leave  
    1598:	c3                   	ret    
  unlink("lf1");
  unlink("lf2");

  fd = open("lf1", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "create lf1 failed\n");
    1599:	50                   	push   %eax
    159a:	50                   	push   %eax
    159b:	68 a2 3f 00 00       	push   $0x3fa2
    15a0:	6a 01                	push   $0x1
    15a2:	e8 45 21 00 00       	call   36ec <printf>
    exit();
    15a7:	e8 1b 20 00 00       	call   35c7 <exit>
    printf(1, "link non-existant succeeded! oops\n");
    exit();
  }

  if(link(".", "lf1") >= 0){
    printf(1, "link . lf1 succeeded! oops\n");
    15ac:	50                   	push   %eax
    15ad:	50                   	push   %eax
    15ae:	68 1c 40 00 00       	push   $0x401c
    15b3:	6a 01                	push   $0x1
    15b5:	e8 32 21 00 00       	call   36ec <printf>
    exit();
    15ba:	e8 08 20 00 00       	call   35c7 <exit>
    exit();
  }

  unlink("lf2");
  if(link("lf2", "lf1") >= 0){
    printf(1, "link non-existant succeeded! oops\n");
    15bf:	52                   	push   %edx
    15c0:	52                   	push   %edx
    15c1:	68 d0 4b 00 00       	push   $0x4bd0
    15c6:	6a 01                	push   $0x1
    15c8:	e8 1f 21 00 00       	call   36ec <printf>
    exit();
    15cd:	e8 f5 1f 00 00       	call   35c7 <exit>
    exit();
  }
  close(fd);

  if(link("lf2", "lf2") >= 0){
    printf(1, "link lf2 lf2 succeeded! oops\n");
    15d2:	50                   	push   %eax
    15d3:	50                   	push   %eax
    15d4:	68 fe 3f 00 00       	push   $0x3ffe
    15d9:	6a 01                	push   $0x1
    15db:	e8 0c 21 00 00       	call   36ec <printf>
    exit();
    15e0:	e8 e2 1f 00 00       	call   35c7 <exit>
  if(fd < 0){
    printf(1, "open lf2 failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "read lf2 failed\n");
    15e5:	51                   	push   %ecx
    15e6:	51                   	push   %ecx
    15e7:	68 ed 3f 00 00       	push   $0x3fed
    15ec:	6a 01                	push   $0x1
    15ee:	e8 f9 20 00 00       	call   36ec <printf>
    exit();
    15f3:	e8 cf 1f 00 00       	call   35c7 <exit>
    exit();
  }

  fd = open("lf2", 0);
  if(fd < 0){
    printf(1, "open lf2 failed\n");
    15f8:	50                   	push   %eax
    15f9:	50                   	push   %eax
    15fa:	68 dc 3f 00 00       	push   $0x3fdc
    15ff:	6a 01                	push   $0x1
    1601:	e8 e6 20 00 00       	call   36ec <printf>
    exit();
    1606:	e8 bc 1f 00 00       	call   35c7 <exit>
    exit();
  }
  unlink("lf1");

  if(open("lf1", 0) >= 0){
    printf(1, "unlinked lf1 but it is still there!\n");
    160b:	50                   	push   %eax
    160c:	50                   	push   %eax
    160d:	68 a8 4b 00 00       	push   $0x4ba8
    1612:	6a 01                	push   $0x1
    1614:	e8 d3 20 00 00       	call   36ec <printf>
    exit();
    1619:	e8 a9 1f 00 00       	call   35c7 <exit>
    exit();
  }
  close(fd);

  if(link("lf1", "lf2") < 0){
    printf(1, "link lf1 lf2 failed\n");
    161e:	51                   	push   %ecx
    161f:	51                   	push   %ecx
    1620:	68 c7 3f 00 00       	push   $0x3fc7
    1625:	6a 01                	push   $0x1
    1627:	e8 c0 20 00 00       	call   36ec <printf>
    exit();
    162c:	e8 96 1f 00 00       	call   35c7 <exit>
  if(fd < 0){
    printf(1, "create lf1 failed\n");
    exit();
  }
  if(write(fd, "hello", 5) != 5){
    printf(1, "write lf1 failed\n");
    1631:	50                   	push   %eax
    1632:	50                   	push   %eax
    1633:	68 b5 3f 00 00       	push   $0x3fb5
    1638:	6a 01                	push   $0x1
    163a:	e8 ad 20 00 00       	call   36ec <printf>
    exit();
    163f:	e8 83 1f 00 00       	call   35c7 <exit>

00001644 <concreate>:
}

// test concurrent create/link/unlink of the same file
void
concreate(void)
{
    1644:	55                   	push   %ebp
    1645:	89 e5                	mov    %esp,%ebp
    1647:	57                   	push   %edi
    1648:	56                   	push   %esi
    1649:	53                   	push   %ebx
    164a:	83 ec 64             	sub    $0x64,%esp
  struct {
    ushort inum;
    char name[14];
  } de;

  printf(1, "concreate test\n");
    164d:	68 45 40 00 00       	push   $0x4045
    1652:	6a 01                	push   $0x1
    1654:	e8 93 20 00 00       	call   36ec <printf>
  file[0] = 'C';
    1659:	c6 45 ad 43          	movb   $0x43,-0x53(%ebp)
  file[2] = '\0';
    165d:	c6 45 af 00          	movb   $0x0,-0x51(%ebp)
    1661:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 40; i++){
    1664:	31 f6                	xor    %esi,%esi
    1666:	8d 5d ad             	lea    -0x53(%ebp),%ebx
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
    1669:	bf 03 00 00 00       	mov    $0x3,%edi
    166e:	eb 3c                	jmp    16ac <concreate+0x68>
    1670:	89 f0                	mov    %esi,%eax
    1672:	99                   	cltd   
    1673:	f7 ff                	idiv   %edi
    1675:	4a                   	dec    %edx
    1676:	0f 84 9c 00 00 00    	je     1718 <concreate+0xd4>
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
      link("C0", file);
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    167c:	83 ec 08             	sub    $0x8,%esp
    167f:	68 02 02 00 00       	push   $0x202
    1684:	53                   	push   %ebx
    1685:	e8 7d 1f 00 00       	call   3607 <open>
      if(fd < 0){
    168a:	83 c4 10             	add    $0x10,%esp
    168d:	85 c0                	test   %eax,%eax
    168f:	78 5c                	js     16ed <concreate+0xa9>
        printf(1, "concreate create %s failed\n", file);
        exit();
      }
      close(fd);
    1691:	83 ec 0c             	sub    $0xc,%esp
    1694:	50                   	push   %eax
    1695:	e8 55 1f 00 00       	call   35ef <close>
    169a:	83 c4 10             	add    $0x10,%esp
    }
    if(pid == 0)
      exit();
    else
      wait();
    169d:	e8 2d 1f 00 00       	call   35cf <wait>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    16a2:	46                   	inc    %esi
    16a3:	83 fe 28             	cmp    $0x28,%esi
    16a6:	0f 84 8c 00 00 00    	je     1738 <concreate+0xf4>
    file[1] = '0' + i;
    16ac:	8d 46 30             	lea    0x30(%esi),%eax
    16af:	88 45 ae             	mov    %al,-0x52(%ebp)
    unlink(file);
    16b2:	83 ec 0c             	sub    $0xc,%esp
    16b5:	53                   	push   %ebx
    16b6:	e8 5c 1f 00 00       	call   3617 <unlink>
    pid = fork();
    16bb:	e8 ff 1e 00 00       	call   35bf <fork>
    if(pid && (i % 3) == 1){
    16c0:	83 c4 10             	add    $0x10,%esp
    16c3:	85 c0                	test   %eax,%eax
    16c5:	75 a9                	jne    1670 <concreate+0x2c>
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
    16c7:	b9 05 00 00 00       	mov    $0x5,%ecx
    16cc:	89 f0                	mov    %esi,%eax
    16ce:	99                   	cltd   
    16cf:	f7 f9                	idiv   %ecx
    16d1:	4a                   	dec    %edx
    16d2:	74 2c                	je     1700 <concreate+0xbc>
      link("C0", file);
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    16d4:	83 ec 08             	sub    $0x8,%esp
    16d7:	68 02 02 00 00       	push   $0x202
    16dc:	53                   	push   %ebx
    16dd:	e8 25 1f 00 00       	call   3607 <open>
      if(fd < 0){
    16e2:	83 c4 10             	add    $0x10,%esp
    16e5:	85 c0                	test   %eax,%eax
    16e7:	0f 89 06 02 00 00    	jns    18f3 <concreate+0x2af>
        printf(1, "concreate create %s failed\n", file);
    16ed:	51                   	push   %ecx
    16ee:	53                   	push   %ebx
    16ef:	68 58 40 00 00       	push   $0x4058
    16f4:	6a 01                	push   $0x1
    16f6:	e8 f1 1f 00 00       	call   36ec <printf>
        exit();
    16fb:	e8 c7 1e 00 00       	call   35c7 <exit>
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
      link("C0", file);
    1700:	83 ec 08             	sub    $0x8,%esp
    1703:	53                   	push   %ebx
    1704:	68 55 40 00 00       	push   $0x4055
    1709:	e8 19 1f 00 00       	call   3627 <link>
    170e:	83 c4 10             	add    $0x10,%esp
        exit();
      }
      close(fd);
    }
    if(pid == 0)
      exit();
    1711:	e8 b1 1e 00 00       	call   35c7 <exit>
    1716:	66 90                	xchg   %ax,%ax
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
      link("C0", file);
    1718:	83 ec 08             	sub    $0x8,%esp
    171b:	53                   	push   %ebx
    171c:	68 55 40 00 00       	push   $0x4055
    1721:	e8 01 1f 00 00       	call   3627 <link>
    1726:	83 c4 10             	add    $0x10,%esp
      close(fd);
    }
    if(pid == 0)
      exit();
    else
      wait();
    1729:	e8 a1 1e 00 00       	call   35cf <wait>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    172e:	46                   	inc    %esi
    172f:	83 fe 28             	cmp    $0x28,%esi
    1732:	0f 85 74 ff ff ff    	jne    16ac <concreate+0x68>
      exit();
    else
      wait();
  }

  memset(fa, 0, sizeof(fa));
    1738:	57                   	push   %edi
    1739:	6a 28                	push   $0x28
    173b:	6a 00                	push   $0x0
    173d:	8d 45 c0             	lea    -0x40(%ebp),%eax
    1740:	50                   	push   %eax
    1741:	e8 4e 1d 00 00       	call   3494 <memset>
  fd = open(".", 0);
    1746:	58                   	pop    %eax
    1747:	5a                   	pop    %edx
    1748:	6a 00                	push   $0x0
    174a:	68 62 42 00 00       	push   $0x4262
    174f:	e8 b3 1e 00 00       	call   3607 <open>
    1754:	89 c6                	mov    %eax,%esi
  n = 0;
  while(read(fd, &de, sizeof(de)) > 0){
    1756:	83 c4 10             	add    $0x10,%esp
      wait();
  }

  memset(fa, 0, sizeof(fa));
  fd = open(".", 0);
  n = 0;
    1759:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
    1760:	8d 7d b0             	lea    -0x50(%ebp),%edi
    1763:	90                   	nop
  while(read(fd, &de, sizeof(de)) > 0){
    1764:	51                   	push   %ecx
    1765:	6a 10                	push   $0x10
    1767:	57                   	push   %edi
    1768:	56                   	push   %esi
    1769:	e8 71 1e 00 00       	call   35df <read>
    176e:	83 c4 10             	add    $0x10,%esp
    1771:	85 c0                	test   %eax,%eax
    1773:	7e 3b                	jle    17b0 <concreate+0x16c>
    if(de.inum == 0)
    1775:	66 83 7d b0 00       	cmpw   $0x0,-0x50(%ebp)
    177a:	74 e8                	je     1764 <concreate+0x120>
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    177c:	80 7d b2 43          	cmpb   $0x43,-0x4e(%ebp)
    1780:	75 e2                	jne    1764 <concreate+0x120>
    1782:	80 7d b4 00          	cmpb   $0x0,-0x4c(%ebp)
    1786:	75 dc                	jne    1764 <concreate+0x120>
      i = de.name[1] - '0';
    1788:	0f be 45 b3          	movsbl -0x4d(%ebp),%eax
    178c:	83 e8 30             	sub    $0x30,%eax
      if(i < 0 || i >= sizeof(fa)){
    178f:	83 f8 27             	cmp    $0x27,%eax
    1792:	0f 87 45 01 00 00    	ja     18dd <concreate+0x299>
        printf(1, "concreate weird file %s\n", de.name);
        exit();
      }
      if(fa[i]){
    1798:	80 7c 05 c0 00       	cmpb   $0x0,-0x40(%ebp,%eax,1)
    179d:	0f 85 24 01 00 00    	jne    18c7 <concreate+0x283>
        printf(1, "concreate duplicate file %s\n", de.name);
        exit();
      }
      fa[i] = 1;
    17a3:	c6 44 05 c0 01       	movb   $0x1,-0x40(%ebp,%eax,1)
      n++;
    17a8:	ff 45 a4             	incl   -0x5c(%ebp)
    17ab:	eb b7                	jmp    1764 <concreate+0x120>
    17ad:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
  close(fd);
    17b0:	83 ec 0c             	sub    $0xc,%esp
    17b3:	56                   	push   %esi
    17b4:	e8 36 1e 00 00       	call   35ef <close>

  if(n != 40){
    17b9:	83 c4 10             	add    $0x10,%esp
    17bc:	83 7d a4 28          	cmpl   $0x28,-0x5c(%ebp)
    17c0:	0f 85 ed 00 00 00    	jne    18b3 <concreate+0x26f>
    17c6:	31 f6                	xor    %esi,%esi
    17c8:	eb 69                	jmp    1833 <concreate+0x1ef>
    17ca:	66 90                	xchg   %ax,%ax
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
      exit();
    }
    if(((i % 3) == 0 && pid == 0) ||
    17cc:	85 ff                	test   %edi,%edi
    17ce:	0f 85 8d 00 00 00    	jne    1861 <concreate+0x21d>
       ((i % 3) == 1 && pid != 0)){
      close(open(file, 0));
    17d4:	83 ec 08             	sub    $0x8,%esp
    17d7:	6a 00                	push   $0x0
    17d9:	53                   	push   %ebx
    17da:	e8 28 1e 00 00       	call   3607 <open>
    17df:	89 04 24             	mov    %eax,(%esp)
    17e2:	e8 08 1e 00 00       	call   35ef <close>
      close(open(file, 0));
    17e7:	58                   	pop    %eax
    17e8:	5a                   	pop    %edx
    17e9:	6a 00                	push   $0x0
    17eb:	53                   	push   %ebx
    17ec:	e8 16 1e 00 00       	call   3607 <open>
    17f1:	89 04 24             	mov    %eax,(%esp)
    17f4:	e8 f6 1d 00 00       	call   35ef <close>
      close(open(file, 0));
    17f9:	59                   	pop    %ecx
    17fa:	58                   	pop    %eax
    17fb:	6a 00                	push   $0x0
    17fd:	53                   	push   %ebx
    17fe:	e8 04 1e 00 00       	call   3607 <open>
    1803:	89 04 24             	mov    %eax,(%esp)
    1806:	e8 e4 1d 00 00       	call   35ef <close>
      close(open(file, 0));
    180b:	58                   	pop    %eax
    180c:	5a                   	pop    %edx
    180d:	6a 00                	push   $0x0
    180f:	53                   	push   %ebx
    1810:	e8 f2 1d 00 00       	call   3607 <open>
    1815:	89 04 24             	mov    %eax,(%esp)
    1818:	e8 d2 1d 00 00       	call   35ef <close>
    181d:	83 c4 10             	add    $0x10,%esp
      unlink(file);
      unlink(file);
      unlink(file);
      unlink(file);
    }
    if(pid == 0)
    1820:	85 ff                	test   %edi,%edi
    1822:	0f 84 e9 fe ff ff    	je     1711 <concreate+0xcd>
      exit();
    else
      wait();
    1828:	e8 a2 1d 00 00       	call   35cf <wait>
  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    exit();
  }

  for(i = 0; i < 40; i++){
    182d:	46                   	inc    %esi
    182e:	83 fe 28             	cmp    $0x28,%esi
    1831:	74 55                	je     1888 <concreate+0x244>
    file[1] = '0' + i;
    1833:	8d 46 30             	lea    0x30(%esi),%eax
    1836:	88 45 ae             	mov    %al,-0x52(%ebp)
    pid = fork();
    1839:	e8 81 1d 00 00       	call   35bf <fork>
    183e:	89 c7                	mov    %eax,%edi
    if(pid < 0){
    1840:	85 c0                	test   %eax,%eax
    1842:	78 5b                	js     189f <concreate+0x25b>
      printf(1, "fork failed\n");
      exit();
    }
    if(((i % 3) == 0 && pid == 0) ||
    1844:	89 f0                	mov    %esi,%eax
    1846:	b9 03 00 00 00       	mov    $0x3,%ecx
    184b:	99                   	cltd   
    184c:	f7 f9                	idiv   %ecx
    184e:	85 d2                	test   %edx,%edx
    1850:	0f 84 76 ff ff ff    	je     17cc <concreate+0x188>
    1856:	4a                   	dec    %edx
    1857:	75 08                	jne    1861 <concreate+0x21d>
       ((i % 3) == 1 && pid != 0)){
    1859:	85 ff                	test   %edi,%edi
    185b:	0f 85 73 ff ff ff    	jne    17d4 <concreate+0x190>
      close(open(file, 0));
      close(open(file, 0));
      close(open(file, 0));
      close(open(file, 0));
    } else {
      unlink(file);
    1861:	83 ec 0c             	sub    $0xc,%esp
    1864:	53                   	push   %ebx
    1865:	e8 ad 1d 00 00       	call   3617 <unlink>
      unlink(file);
    186a:	89 1c 24             	mov    %ebx,(%esp)
    186d:	e8 a5 1d 00 00       	call   3617 <unlink>
      unlink(file);
    1872:	89 1c 24             	mov    %ebx,(%esp)
    1875:	e8 9d 1d 00 00       	call   3617 <unlink>
      unlink(file);
    187a:	89 1c 24             	mov    %ebx,(%esp)
    187d:	e8 95 1d 00 00       	call   3617 <unlink>
    1882:	83 c4 10             	add    $0x10,%esp
    1885:	eb 99                	jmp    1820 <concreate+0x1dc>
    1887:	90                   	nop
      exit();
    else
      wait();
  }

  printf(1, "concreate ok\n");
    1888:	83 ec 08             	sub    $0x8,%esp
    188b:	68 aa 40 00 00       	push   $0x40aa
    1890:	6a 01                	push   $0x1
    1892:	e8 55 1e 00 00       	call   36ec <printf>
}
    1897:	8d 65 f4             	lea    -0xc(%ebp),%esp
    189a:	5b                   	pop    %ebx
    189b:	5e                   	pop    %esi
    189c:	5f                   	pop    %edi
    189d:	5d                   	pop    %ebp
    189e:	c3                   	ret    

  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
    189f:	83 ec 08             	sub    $0x8,%esp
    18a2:	68 2d 49 00 00       	push   $0x492d
    18a7:	6a 01                	push   $0x1
    18a9:	e8 3e 1e 00 00       	call   36ec <printf>
      exit();
    18ae:	e8 14 1d 00 00       	call   35c7 <exit>
    }
  }
  close(fd);

  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    18b3:	83 ec 08             	sub    $0x8,%esp
    18b6:	68 f4 4b 00 00       	push   $0x4bf4
    18bb:	6a 01                	push   $0x1
    18bd:	e8 2a 1e 00 00       	call   36ec <printf>
    exit();
    18c2:	e8 00 1d 00 00       	call   35c7 <exit>
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
        exit();
      }
      if(fa[i]){
        printf(1, "concreate duplicate file %s\n", de.name);
    18c7:	53                   	push   %ebx
    18c8:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    18cb:	50                   	push   %eax
    18cc:	68 8d 40 00 00       	push   $0x408d
    18d1:	6a 01                	push   $0x1
    18d3:	e8 14 1e 00 00       	call   36ec <printf>
        exit();
    18d8:	e8 ea 1c 00 00       	call   35c7 <exit>
    if(de.inum == 0)
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
      i = de.name[1] - '0';
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
    18dd:	56                   	push   %esi
    18de:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    18e1:	50                   	push   %eax
    18e2:	68 74 40 00 00       	push   $0x4074
    18e7:	6a 01                	push   $0x1
    18e9:	e8 fe 1d 00 00       	call   36ec <printf>
        exit();
    18ee:	e8 d4 1c 00 00       	call   35c7 <exit>
      fd = open(file, O_CREATE | O_RDWR);
      if(fd < 0){
        printf(1, "concreate create %s failed\n", file);
        exit();
      }
      close(fd);
    18f3:	83 ec 0c             	sub    $0xc,%esp
    18f6:	50                   	push   %eax
    18f7:	e8 f3 1c 00 00       	call   35ef <close>
    18fc:	83 c4 10             	add    $0x10,%esp
    18ff:	e9 0d fe ff ff       	jmp    1711 <concreate+0xcd>

00001904 <linkunlink>:

// another concurrent link/unlink/create test,
// to look for deadlocks.
void
linkunlink()
{
    1904:	55                   	push   %ebp
    1905:	89 e5                	mov    %esp,%ebp
    1907:	57                   	push   %edi
    1908:	56                   	push   %esi
    1909:	53                   	push   %ebx
    190a:	83 ec 24             	sub    $0x24,%esp
  int pid, i;

  printf(1, "linkunlink test\n");
    190d:	68 b8 40 00 00       	push   $0x40b8
    1912:	6a 01                	push   $0x1
    1914:	e8 d3 1d 00 00       	call   36ec <printf>

  unlink("x");
    1919:	c7 04 24 45 43 00 00 	movl   $0x4345,(%esp)
    1920:	e8 f2 1c 00 00       	call   3617 <unlink>
  pid = fork();
    1925:	e8 95 1c 00 00       	call   35bf <fork>
    192a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(pid < 0){
    192d:	83 c4 10             	add    $0x10,%esp
    1930:	85 c0                	test   %eax,%eax
    1932:	0f 88 c2 00 00 00    	js     19fa <linkunlink+0xf6>
    printf(1, "fork failed\n");
    exit();
  }

  unsigned int x = (pid ? 1 : 97);
    1938:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
    193c:	19 ff                	sbb    %edi,%edi
    193e:	83 e7 60             	and    $0x60,%edi
    1941:	47                   	inc    %edi
    1942:	bb 64 00 00 00       	mov    $0x64,%ebx
  for(i = 0; i < 100; i++){
    x = x * 1103515245 + 12345;
    if((x % 3) == 0){
    1947:	be 03 00 00 00       	mov    $0x3,%esi
    194c:	eb 1c                	jmp    196a <linkunlink+0x66>
    194e:	66 90                	xchg   %ax,%ax
      close(open("x", O_RDWR | O_CREATE));
    } else if((x % 3) == 1){
    1950:	4a                   	dec    %edx
    1951:	0f 84 89 00 00 00    	je     19e0 <linkunlink+0xdc>
      link("cat", "x");
    } else {
      unlink("x");
    1957:	83 ec 0c             	sub    $0xc,%esp
    195a:	68 45 43 00 00       	push   $0x4345
    195f:	e8 b3 1c 00 00       	call   3617 <unlink>
    1964:	83 c4 10             	add    $0x10,%esp
    printf(1, "fork failed\n");
    exit();
  }

  unsigned int x = (pid ? 1 : 97);
  for(i = 0; i < 100; i++){
    1967:	4b                   	dec    %ebx
    1968:	74 52                	je     19bc <linkunlink+0xb8>
    x = x * 1103515245 + 12345;
    196a:	89 f8                	mov    %edi,%eax
    196c:	c1 e0 09             	shl    $0x9,%eax
    196f:	29 f8                	sub    %edi,%eax
    1971:	8d 14 87             	lea    (%edi,%eax,4),%edx
    1974:	89 d0                	mov    %edx,%eax
    1976:	c1 e0 09             	shl    $0x9,%eax
    1979:	29 d0                	sub    %edx,%eax
    197b:	01 c0                	add    %eax,%eax
    197d:	01 f8                	add    %edi,%eax
    197f:	89 c2                	mov    %eax,%edx
    1981:	c1 e2 05             	shl    $0x5,%edx
    1984:	01 d0                	add    %edx,%eax
    1986:	c1 e0 02             	shl    $0x2,%eax
    1989:	29 f8                	sub    %edi,%eax
    198b:	8d bc 87 39 30 00 00 	lea    0x3039(%edi,%eax,4),%edi
    if((x % 3) == 0){
    1992:	89 f8                	mov    %edi,%eax
    1994:	31 d2                	xor    %edx,%edx
    1996:	f7 f6                	div    %esi
    1998:	85 d2                	test   %edx,%edx
    199a:	75 b4                	jne    1950 <linkunlink+0x4c>
      close(open("x", O_RDWR | O_CREATE));
    199c:	83 ec 08             	sub    $0x8,%esp
    199f:	68 02 02 00 00       	push   $0x202
    19a4:	68 45 43 00 00       	push   $0x4345
    19a9:	e8 59 1c 00 00       	call   3607 <open>
    19ae:	89 04 24             	mov    %eax,(%esp)
    19b1:	e8 39 1c 00 00       	call   35ef <close>
    19b6:	83 c4 10             	add    $0x10,%esp
    printf(1, "fork failed\n");
    exit();
  }

  unsigned int x = (pid ? 1 : 97);
  for(i = 0; i < 100; i++){
    19b9:	4b                   	dec    %ebx
    19ba:	75 ae                	jne    196a <linkunlink+0x66>
    } else {
      unlink("x");
    }
  }

  if(pid)
    19bc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    19bf:	85 c0                	test   %eax,%eax
    19c1:	74 4b                	je     1a0e <linkunlink+0x10a>
    wait();
    19c3:	e8 07 1c 00 00       	call   35cf <wait>
  else
    exit();

  printf(1, "linkunlink ok\n");
    19c8:	83 ec 08             	sub    $0x8,%esp
    19cb:	68 cd 40 00 00       	push   $0x40cd
    19d0:	6a 01                	push   $0x1
    19d2:	e8 15 1d 00 00       	call   36ec <printf>
}
    19d7:	8d 65 f4             	lea    -0xc(%ebp),%esp
    19da:	5b                   	pop    %ebx
    19db:	5e                   	pop    %esi
    19dc:	5f                   	pop    %edi
    19dd:	5d                   	pop    %ebp
    19de:	c3                   	ret    
    19df:	90                   	nop
  for(i = 0; i < 100; i++){
    x = x * 1103515245 + 12345;
    if((x % 3) == 0){
      close(open("x", O_RDWR | O_CREATE));
    } else if((x % 3) == 1){
      link("cat", "x");
    19e0:	83 ec 08             	sub    $0x8,%esp
    19e3:	68 45 43 00 00       	push   $0x4345
    19e8:	68 c9 40 00 00       	push   $0x40c9
    19ed:	e8 35 1c 00 00       	call   3627 <link>
    19f2:	83 c4 10             	add    $0x10,%esp
    19f5:	e9 6d ff ff ff       	jmp    1967 <linkunlink+0x63>
  printf(1, "linkunlink test\n");

  unlink("x");
  pid = fork();
  if(pid < 0){
    printf(1, "fork failed\n");
    19fa:	83 ec 08             	sub    $0x8,%esp
    19fd:	68 2d 49 00 00       	push   $0x492d
    1a02:	6a 01                	push   $0x1
    1a04:	e8 e3 1c 00 00       	call   36ec <printf>
    exit();
    1a09:	e8 b9 1b 00 00       	call   35c7 <exit>
  }

  if(pid)
    wait();
  else
    exit();
    1a0e:	e8 b4 1b 00 00       	call   35c7 <exit>
    1a13:	90                   	nop

00001a14 <bigdir>:
}

// directory that uses indirect blocks
void
bigdir(void)
{
    1a14:	55                   	push   %ebp
    1a15:	89 e5                	mov    %esp,%ebp
    1a17:	56                   	push   %esi
    1a18:	53                   	push   %ebx
    1a19:	83 ec 18             	sub    $0x18,%esp
  int i, fd;
  char name[10];

  printf(1, "bigdir test\n");
    1a1c:	68 dc 40 00 00       	push   $0x40dc
    1a21:	6a 01                	push   $0x1
    1a23:	e8 c4 1c 00 00       	call   36ec <printf>
  unlink("bd");
    1a28:	c7 04 24 e9 40 00 00 	movl   $0x40e9,(%esp)
    1a2f:	e8 e3 1b 00 00       	call   3617 <unlink>

  fd = open("bd", O_CREATE);
    1a34:	58                   	pop    %eax
    1a35:	5a                   	pop    %edx
    1a36:	68 00 02 00 00       	push   $0x200
    1a3b:	68 e9 40 00 00       	push   $0x40e9
    1a40:	e8 c2 1b 00 00       	call   3607 <open>
  if(fd < 0){
    1a45:	83 c4 10             	add    $0x10,%esp
    1a48:	85 c0                	test   %eax,%eax
    1a4a:	0f 88 dc 00 00 00    	js     1b2c <bigdir+0x118>
    printf(1, "bigdir create failed\n");
    exit();
  }
  close(fd);
    1a50:	83 ec 0c             	sub    $0xc,%esp
    1a53:	50                   	push   %eax
    1a54:	e8 96 1b 00 00       	call   35ef <close>
    1a59:	83 c4 10             	add    $0x10,%esp

  for(i = 0; i < 500; i++){
    1a5c:	31 db                	xor    %ebx,%ebx
    1a5e:	8d 75 ee             	lea    -0x12(%ebp),%esi
    1a61:	8d 76 00             	lea    0x0(%esi),%esi
    name[0] = 'x';
    1a64:	c6 45 ee 78          	movb   $0x78,-0x12(%ebp)
    name[1] = '0' + (i / 64);
    1a68:	89 d8                	mov    %ebx,%eax
    1a6a:	c1 f8 06             	sar    $0x6,%eax
    1a6d:	83 c0 30             	add    $0x30,%eax
    1a70:	88 45 ef             	mov    %al,-0x11(%ebp)
    name[2] = '0' + (i % 64);
    1a73:	89 d8                	mov    %ebx,%eax
    1a75:	83 e0 3f             	and    $0x3f,%eax
    1a78:	83 c0 30             	add    $0x30,%eax
    1a7b:	88 45 f0             	mov    %al,-0x10(%ebp)
    name[3] = '\0';
    1a7e:	c6 45 f1 00          	movb   $0x0,-0xf(%ebp)
    if(link("bd", name) != 0){
    1a82:	83 ec 08             	sub    $0x8,%esp
    1a85:	56                   	push   %esi
    1a86:	68 e9 40 00 00       	push   $0x40e9
    1a8b:	e8 97 1b 00 00       	call   3627 <link>
    1a90:	83 c4 10             	add    $0x10,%esp
    1a93:	85 c0                	test   %eax,%eax
    1a95:	75 6d                	jne    1b04 <bigdir+0xf0>
    printf(1, "bigdir create failed\n");
    exit();
  }
  close(fd);

  for(i = 0; i < 500; i++){
    1a97:	43                   	inc    %ebx
    1a98:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    1a9e:	75 c4                	jne    1a64 <bigdir+0x50>
      printf(1, "bigdir link failed\n");
      exit();
    }
  }

  unlink("bd");
    1aa0:	83 ec 0c             	sub    $0xc,%esp
    1aa3:	68 e9 40 00 00       	push   $0x40e9
    1aa8:	e8 6a 1b 00 00       	call   3617 <unlink>
    1aad:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 500; i++){
    1ab0:	31 db                	xor    %ebx,%ebx
    1ab2:	66 90                	xchg   %ax,%ax
    name[0] = 'x';
    1ab4:	c6 45 ee 78          	movb   $0x78,-0x12(%ebp)
    name[1] = '0' + (i / 64);
    1ab8:	89 d8                	mov    %ebx,%eax
    1aba:	c1 f8 06             	sar    $0x6,%eax
    1abd:	83 c0 30             	add    $0x30,%eax
    1ac0:	88 45 ef             	mov    %al,-0x11(%ebp)
    name[2] = '0' + (i % 64);
    1ac3:	89 d8                	mov    %ebx,%eax
    1ac5:	83 e0 3f             	and    $0x3f,%eax
    1ac8:	83 c0 30             	add    $0x30,%eax
    1acb:	88 45 f0             	mov    %al,-0x10(%ebp)
    name[3] = '\0';
    1ace:	c6 45 f1 00          	movb   $0x0,-0xf(%ebp)
    if(unlink(name) != 0){
    1ad2:	83 ec 0c             	sub    $0xc,%esp
    1ad5:	56                   	push   %esi
    1ad6:	e8 3c 1b 00 00       	call   3617 <unlink>
    1adb:	83 c4 10             	add    $0x10,%esp
    1ade:	85 c0                	test   %eax,%eax
    1ae0:	75 36                	jne    1b18 <bigdir+0x104>
      exit();
    }
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    1ae2:	43                   	inc    %ebx
    1ae3:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    1ae9:	75 c9                	jne    1ab4 <bigdir+0xa0>
      printf(1, "bigdir unlink failed");
      exit();
    }
  }

  printf(1, "bigdir ok\n");
    1aeb:	83 ec 08             	sub    $0x8,%esp
    1aee:	68 2b 41 00 00       	push   $0x412b
    1af3:	6a 01                	push   $0x1
    1af5:	e8 f2 1b 00 00       	call   36ec <printf>
}
    1afa:	83 c4 10             	add    $0x10,%esp
    1afd:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1b00:	5b                   	pop    %ebx
    1b01:	5e                   	pop    %esi
    1b02:	5d                   	pop    %ebp
    1b03:	c3                   	ret    
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(link("bd", name) != 0){
      printf(1, "bigdir link failed\n");
    1b04:	83 ec 08             	sub    $0x8,%esp
    1b07:	68 02 41 00 00       	push   $0x4102
    1b0c:	6a 01                	push   $0x1
    1b0e:	e8 d9 1b 00 00       	call   36ec <printf>
      exit();
    1b13:	e8 af 1a 00 00       	call   35c7 <exit>
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(unlink(name) != 0){
      printf(1, "bigdir unlink failed");
    1b18:	83 ec 08             	sub    $0x8,%esp
    1b1b:	68 16 41 00 00       	push   $0x4116
    1b20:	6a 01                	push   $0x1
    1b22:	e8 c5 1b 00 00       	call   36ec <printf>
      exit();
    1b27:	e8 9b 1a 00 00       	call   35c7 <exit>
  printf(1, "bigdir test\n");
  unlink("bd");

  fd = open("bd", O_CREATE);
  if(fd < 0){
    printf(1, "bigdir create failed\n");
    1b2c:	83 ec 08             	sub    $0x8,%esp
    1b2f:	68 ec 40 00 00       	push   $0x40ec
    1b34:	6a 01                	push   $0x1
    1b36:	e8 b1 1b 00 00       	call   36ec <printf>
    exit();
    1b3b:	e8 87 1a 00 00       	call   35c7 <exit>

00001b40 <subdir>:
  printf(1, "bigdir ok\n");
}

void
subdir(void)
{
    1b40:	55                   	push   %ebp
    1b41:	89 e5                	mov    %esp,%ebp
    1b43:	53                   	push   %ebx
    1b44:	83 ec 0c             	sub    $0xc,%esp
  int fd, cc;

  printf(1, "subdir test\n");
    1b47:	68 36 41 00 00       	push   $0x4136
    1b4c:	6a 01                	push   $0x1
    1b4e:	e8 99 1b 00 00       	call   36ec <printf>

  unlink("ff");
    1b53:	c7 04 24 bf 41 00 00 	movl   $0x41bf,(%esp)
    1b5a:	e8 b8 1a 00 00       	call   3617 <unlink>
  if(mkdir("dd") != 0){
    1b5f:	c7 04 24 5c 42 00 00 	movl   $0x425c,(%esp)
    1b66:	e8 c4 1a 00 00       	call   362f <mkdir>
    1b6b:	83 c4 10             	add    $0x10,%esp
    1b6e:	85 c0                	test   %eax,%eax
    1b70:	0f 85 ab 05 00 00    	jne    2121 <subdir+0x5e1>
    printf(1, "subdir mkdir dd failed\n");
    exit();
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    1b76:	83 ec 08             	sub    $0x8,%esp
    1b79:	68 02 02 00 00       	push   $0x202
    1b7e:	68 95 41 00 00       	push   $0x4195
    1b83:	e8 7f 1a 00 00       	call   3607 <open>
    1b88:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1b8a:	83 c4 10             	add    $0x10,%esp
    1b8d:	85 c0                	test   %eax,%eax
    1b8f:	0f 88 79 05 00 00    	js     210e <subdir+0x5ce>
    printf(1, "create dd/ff failed\n");
    exit();
  }
  write(fd, "ff", 2);
    1b95:	50                   	push   %eax
    1b96:	6a 02                	push   $0x2
    1b98:	68 bf 41 00 00       	push   $0x41bf
    1b9d:	53                   	push   %ebx
    1b9e:	e8 44 1a 00 00       	call   35e7 <write>
  close(fd);
    1ba3:	89 1c 24             	mov    %ebx,(%esp)
    1ba6:	e8 44 1a 00 00       	call   35ef <close>

  if(unlink("dd") >= 0){
    1bab:	c7 04 24 5c 42 00 00 	movl   $0x425c,(%esp)
    1bb2:	e8 60 1a 00 00       	call   3617 <unlink>
    1bb7:	83 c4 10             	add    $0x10,%esp
    1bba:	85 c0                	test   %eax,%eax
    1bbc:	0f 89 39 05 00 00    	jns    20fb <subdir+0x5bb>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    exit();
  }

  if(mkdir("/dd/dd") != 0){
    1bc2:	83 ec 0c             	sub    $0xc,%esp
    1bc5:	68 70 41 00 00       	push   $0x4170
    1bca:	e8 60 1a 00 00       	call   362f <mkdir>
    1bcf:	83 c4 10             	add    $0x10,%esp
    1bd2:	85 c0                	test   %eax,%eax
    1bd4:	0f 85 0e 05 00 00    	jne    20e8 <subdir+0x5a8>
    printf(1, "subdir mkdir dd/dd failed\n");
    exit();
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1bda:	83 ec 08             	sub    $0x8,%esp
    1bdd:	68 02 02 00 00       	push   $0x202
    1be2:	68 92 41 00 00       	push   $0x4192
    1be7:	e8 1b 1a 00 00       	call   3607 <open>
    1bec:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1bee:	83 c4 10             	add    $0x10,%esp
    1bf1:	85 c0                	test   %eax,%eax
    1bf3:	0f 88 1e 04 00 00    	js     2017 <subdir+0x4d7>
    printf(1, "create dd/dd/ff failed\n");
    exit();
  }
  write(fd, "FF", 2);
    1bf9:	50                   	push   %eax
    1bfa:	6a 02                	push   $0x2
    1bfc:	68 b3 41 00 00       	push   $0x41b3
    1c01:	53                   	push   %ebx
    1c02:	e8 e0 19 00 00       	call   35e7 <write>
  close(fd);
    1c07:	89 1c 24             	mov    %ebx,(%esp)
    1c0a:	e8 e0 19 00 00       	call   35ef <close>

  fd = open("dd/dd/../ff", 0);
    1c0f:	58                   	pop    %eax
    1c10:	5a                   	pop    %edx
    1c11:	6a 00                	push   $0x0
    1c13:	68 b6 41 00 00       	push   $0x41b6
    1c18:	e8 ea 19 00 00       	call   3607 <open>
    1c1d:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1c1f:	83 c4 10             	add    $0x10,%esp
    1c22:	85 c0                	test   %eax,%eax
    1c24:	0f 88 da 03 00 00    	js     2004 <subdir+0x4c4>
    printf(1, "open dd/dd/../ff failed\n");
    exit();
  }
  cc = read(fd, buf, sizeof(buf));
    1c2a:	50                   	push   %eax
    1c2b:	68 00 20 00 00       	push   $0x2000
    1c30:	68 60 82 00 00       	push   $0x8260
    1c35:	53                   	push   %ebx
    1c36:	e8 a4 19 00 00       	call   35df <read>
  if(cc != 2 || buf[0] != 'f'){
    1c3b:	83 c4 10             	add    $0x10,%esp
    1c3e:	83 f8 02             	cmp    $0x2,%eax
    1c41:	0f 85 38 03 00 00    	jne    1f7f <subdir+0x43f>
    1c47:	80 3d 60 82 00 00 66 	cmpb   $0x66,0x8260
    1c4e:	0f 85 2b 03 00 00    	jne    1f7f <subdir+0x43f>
    printf(1, "dd/dd/../ff wrong content\n");
    exit();
  }
  close(fd);
    1c54:	83 ec 0c             	sub    $0xc,%esp
    1c57:	53                   	push   %ebx
    1c58:	e8 92 19 00 00       	call   35ef <close>

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    1c5d:	58                   	pop    %eax
    1c5e:	5a                   	pop    %edx
    1c5f:	68 f6 41 00 00       	push   $0x41f6
    1c64:	68 92 41 00 00       	push   $0x4192
    1c69:	e8 b9 19 00 00       	call   3627 <link>
    1c6e:	83 c4 10             	add    $0x10,%esp
    1c71:	85 c0                	test   %eax,%eax
    1c73:	0f 85 c4 03 00 00    	jne    203d <subdir+0x4fd>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    exit();
  }

  if(unlink("dd/dd/ff") != 0){
    1c79:	83 ec 0c             	sub    $0xc,%esp
    1c7c:	68 92 41 00 00       	push   $0x4192
    1c81:	e8 91 19 00 00       	call   3617 <unlink>
    1c86:	83 c4 10             	add    $0x10,%esp
    1c89:	85 c0                	test   %eax,%eax
    1c8b:	0f 85 14 03 00 00    	jne    1fa5 <subdir+0x465>
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1c91:	83 ec 08             	sub    $0x8,%esp
    1c94:	6a 00                	push   $0x0
    1c96:	68 92 41 00 00       	push   $0x4192
    1c9b:	e8 67 19 00 00       	call   3607 <open>
    1ca0:	83 c4 10             	add    $0x10,%esp
    1ca3:	85 c0                	test   %eax,%eax
    1ca5:	0f 89 2a 04 00 00    	jns    20d5 <subdir+0x595>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    exit();
  }

  if(chdir("dd") != 0){
    1cab:	83 ec 0c             	sub    $0xc,%esp
    1cae:	68 5c 42 00 00       	push   $0x425c
    1cb3:	e8 7f 19 00 00       	call   3637 <chdir>
    1cb8:	83 c4 10             	add    $0x10,%esp
    1cbb:	85 c0                	test   %eax,%eax
    1cbd:	0f 85 ff 03 00 00    	jne    20c2 <subdir+0x582>
    printf(1, "chdir dd failed\n");
    exit();
  }
  if(chdir("dd/../../dd") != 0){
    1cc3:	83 ec 0c             	sub    $0xc,%esp
    1cc6:	68 2a 42 00 00       	push   $0x422a
    1ccb:	e8 67 19 00 00       	call   3637 <chdir>
    1cd0:	83 c4 10             	add    $0x10,%esp
    1cd3:	85 c0                	test   %eax,%eax
    1cd5:	0f 85 b7 02 00 00    	jne    1f92 <subdir+0x452>
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("dd/../../../dd") != 0){
    1cdb:	83 ec 0c             	sub    $0xc,%esp
    1cde:	68 50 42 00 00       	push   $0x4250
    1ce3:	e8 4f 19 00 00       	call   3637 <chdir>
    1ce8:	83 c4 10             	add    $0x10,%esp
    1ceb:	85 c0                	test   %eax,%eax
    1ced:	0f 85 9f 02 00 00    	jne    1f92 <subdir+0x452>
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("./..") != 0){
    1cf3:	83 ec 0c             	sub    $0xc,%esp
    1cf6:	68 5f 42 00 00       	push   $0x425f
    1cfb:	e8 37 19 00 00       	call   3637 <chdir>
    1d00:	83 c4 10             	add    $0x10,%esp
    1d03:	85 c0                	test   %eax,%eax
    1d05:	0f 85 1f 03 00 00    	jne    202a <subdir+0x4ea>
    printf(1, "chdir ./.. failed\n");
    exit();
  }

  fd = open("dd/dd/ffff", 0);
    1d0b:	83 ec 08             	sub    $0x8,%esp
    1d0e:	6a 00                	push   $0x0
    1d10:	68 f6 41 00 00       	push   $0x41f6
    1d15:	e8 ed 18 00 00       	call   3607 <open>
    1d1a:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1d1c:	83 c4 10             	add    $0x10,%esp
    1d1f:	85 c0                	test   %eax,%eax
    1d21:	0f 88 de 04 00 00    	js     2205 <subdir+0x6c5>
    printf(1, "open dd/dd/ffff failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    1d27:	50                   	push   %eax
    1d28:	68 00 20 00 00       	push   $0x2000
    1d2d:	68 60 82 00 00       	push   $0x8260
    1d32:	53                   	push   %ebx
    1d33:	e8 a7 18 00 00       	call   35df <read>
    1d38:	83 c4 10             	add    $0x10,%esp
    1d3b:	83 f8 02             	cmp    $0x2,%eax
    1d3e:	0f 85 ae 04 00 00    	jne    21f2 <subdir+0x6b2>
    printf(1, "read dd/dd/ffff wrong len\n");
    exit();
  }
  close(fd);
    1d44:	83 ec 0c             	sub    $0xc,%esp
    1d47:	53                   	push   %ebx
    1d48:	e8 a2 18 00 00       	call   35ef <close>

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1d4d:	59                   	pop    %ecx
    1d4e:	5b                   	pop    %ebx
    1d4f:	6a 00                	push   $0x0
    1d51:	68 92 41 00 00       	push   $0x4192
    1d56:	e8 ac 18 00 00       	call   3607 <open>
    1d5b:	83 c4 10             	add    $0x10,%esp
    1d5e:	85 c0                	test   %eax,%eax
    1d60:	0f 89 65 02 00 00    	jns    1fcb <subdir+0x48b>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    exit();
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    1d66:	83 ec 08             	sub    $0x8,%esp
    1d69:	68 02 02 00 00       	push   $0x202
    1d6e:	68 aa 42 00 00       	push   $0x42aa
    1d73:	e8 8f 18 00 00       	call   3607 <open>
    1d78:	83 c4 10             	add    $0x10,%esp
    1d7b:	85 c0                	test   %eax,%eax
    1d7d:	0f 89 35 02 00 00    	jns    1fb8 <subdir+0x478>
    printf(1, "create dd/ff/ff succeeded!\n");
    exit();
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    1d83:	83 ec 08             	sub    $0x8,%esp
    1d86:	68 02 02 00 00       	push   $0x202
    1d8b:	68 cf 42 00 00       	push   $0x42cf
    1d90:	e8 72 18 00 00       	call   3607 <open>
    1d95:	83 c4 10             	add    $0x10,%esp
    1d98:	85 c0                	test   %eax,%eax
    1d9a:	0f 89 0f 03 00 00    	jns    20af <subdir+0x56f>
    printf(1, "create dd/xx/ff succeeded!\n");
    exit();
  }
  if(open("dd", O_CREATE) >= 0){
    1da0:	83 ec 08             	sub    $0x8,%esp
    1da3:	68 00 02 00 00       	push   $0x200
    1da8:	68 5c 42 00 00       	push   $0x425c
    1dad:	e8 55 18 00 00       	call   3607 <open>
    1db2:	83 c4 10             	add    $0x10,%esp
    1db5:	85 c0                	test   %eax,%eax
    1db7:	0f 89 df 02 00 00    	jns    209c <subdir+0x55c>
    printf(1, "create dd succeeded!\n");
    exit();
  }
  if(open("dd", O_RDWR) >= 0){
    1dbd:	83 ec 08             	sub    $0x8,%esp
    1dc0:	6a 02                	push   $0x2
    1dc2:	68 5c 42 00 00       	push   $0x425c
    1dc7:	e8 3b 18 00 00       	call   3607 <open>
    1dcc:	83 c4 10             	add    $0x10,%esp
    1dcf:	85 c0                	test   %eax,%eax
    1dd1:	0f 89 b2 02 00 00    	jns    2089 <subdir+0x549>
    printf(1, "open dd rdwr succeeded!\n");
    exit();
  }
  if(open("dd", O_WRONLY) >= 0){
    1dd7:	83 ec 08             	sub    $0x8,%esp
    1dda:	6a 01                	push   $0x1
    1ddc:	68 5c 42 00 00       	push   $0x425c
    1de1:	e8 21 18 00 00       	call   3607 <open>
    1de6:	83 c4 10             	add    $0x10,%esp
    1de9:	85 c0                	test   %eax,%eax
    1deb:	0f 89 85 02 00 00    	jns    2076 <subdir+0x536>
    printf(1, "open dd wronly succeeded!\n");
    exit();
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    1df1:	83 ec 08             	sub    $0x8,%esp
    1df4:	68 3e 43 00 00       	push   $0x433e
    1df9:	68 aa 42 00 00       	push   $0x42aa
    1dfe:	e8 24 18 00 00       	call   3627 <link>
    1e03:	83 c4 10             	add    $0x10,%esp
    1e06:	85 c0                	test   %eax,%eax
    1e08:	0f 84 55 02 00 00    	je     2063 <subdir+0x523>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    1e0e:	83 ec 08             	sub    $0x8,%esp
    1e11:	68 3e 43 00 00       	push   $0x433e
    1e16:	68 cf 42 00 00       	push   $0x42cf
    1e1b:	e8 07 18 00 00       	call   3627 <link>
    1e20:	83 c4 10             	add    $0x10,%esp
    1e23:	85 c0                	test   %eax,%eax
    1e25:	0f 84 25 02 00 00    	je     2050 <subdir+0x510>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    1e2b:	83 ec 08             	sub    $0x8,%esp
    1e2e:	68 f6 41 00 00       	push   $0x41f6
    1e33:	68 95 41 00 00       	push   $0x4195
    1e38:	e8 ea 17 00 00       	call   3627 <link>
    1e3d:	83 c4 10             	add    $0x10,%esp
    1e40:	85 c0                	test   %eax,%eax
    1e42:	0f 84 a9 01 00 00    	je     1ff1 <subdir+0x4b1>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    exit();
  }
  if(mkdir("dd/ff/ff") == 0){
    1e48:	83 ec 0c             	sub    $0xc,%esp
    1e4b:	68 aa 42 00 00       	push   $0x42aa
    1e50:	e8 da 17 00 00       	call   362f <mkdir>
    1e55:	83 c4 10             	add    $0x10,%esp
    1e58:	85 c0                	test   %eax,%eax
    1e5a:	0f 84 7e 01 00 00    	je     1fde <subdir+0x49e>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/xx/ff") == 0){
    1e60:	83 ec 0c             	sub    $0xc,%esp
    1e63:	68 cf 42 00 00       	push   $0x42cf
    1e68:	e8 c2 17 00 00       	call   362f <mkdir>
    1e6d:	83 c4 10             	add    $0x10,%esp
    1e70:	85 c0                	test   %eax,%eax
    1e72:	0f 84 67 03 00 00    	je     21df <subdir+0x69f>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/dd/ffff") == 0){
    1e78:	83 ec 0c             	sub    $0xc,%esp
    1e7b:	68 f6 41 00 00       	push   $0x41f6
    1e80:	e8 aa 17 00 00       	call   362f <mkdir>
    1e85:	83 c4 10             	add    $0x10,%esp
    1e88:	85 c0                	test   %eax,%eax
    1e8a:	0f 84 3c 03 00 00    	je     21cc <subdir+0x68c>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    exit();
  }
  if(unlink("dd/xx/ff") == 0){
    1e90:	83 ec 0c             	sub    $0xc,%esp
    1e93:	68 cf 42 00 00       	push   $0x42cf
    1e98:	e8 7a 17 00 00       	call   3617 <unlink>
    1e9d:	83 c4 10             	add    $0x10,%esp
    1ea0:	85 c0                	test   %eax,%eax
    1ea2:	0f 84 11 03 00 00    	je     21b9 <subdir+0x679>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    exit();
  }
  if(unlink("dd/ff/ff") == 0){
    1ea8:	83 ec 0c             	sub    $0xc,%esp
    1eab:	68 aa 42 00 00       	push   $0x42aa
    1eb0:	e8 62 17 00 00       	call   3617 <unlink>
    1eb5:	83 c4 10             	add    $0x10,%esp
    1eb8:	85 c0                	test   %eax,%eax
    1eba:	0f 84 e6 02 00 00    	je     21a6 <subdir+0x666>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/ff") == 0){
    1ec0:	83 ec 0c             	sub    $0xc,%esp
    1ec3:	68 95 41 00 00       	push   $0x4195
    1ec8:	e8 6a 17 00 00       	call   3637 <chdir>
    1ecd:	83 c4 10             	add    $0x10,%esp
    1ed0:	85 c0                	test   %eax,%eax
    1ed2:	0f 84 bb 02 00 00    	je     2193 <subdir+0x653>
    printf(1, "chdir dd/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/xx") == 0){
    1ed8:	83 ec 0c             	sub    $0xc,%esp
    1edb:	68 41 43 00 00       	push   $0x4341
    1ee0:	e8 52 17 00 00       	call   3637 <chdir>
    1ee5:	83 c4 10             	add    $0x10,%esp
    1ee8:	85 c0                	test   %eax,%eax
    1eea:	0f 84 90 02 00 00    	je     2180 <subdir+0x640>
    printf(1, "chdir dd/xx succeeded!\n");
    exit();
  }

  if(unlink("dd/dd/ffff") != 0){
    1ef0:	83 ec 0c             	sub    $0xc,%esp
    1ef3:	68 f6 41 00 00       	push   $0x41f6
    1ef8:	e8 1a 17 00 00       	call   3617 <unlink>
    1efd:	83 c4 10             	add    $0x10,%esp
    1f00:	85 c0                	test   %eax,%eax
    1f02:	0f 85 9d 00 00 00    	jne    1fa5 <subdir+0x465>
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(unlink("dd/ff") != 0){
    1f08:	83 ec 0c             	sub    $0xc,%esp
    1f0b:	68 95 41 00 00       	push   $0x4195
    1f10:	e8 02 17 00 00       	call   3617 <unlink>
    1f15:	83 c4 10             	add    $0x10,%esp
    1f18:	85 c0                	test   %eax,%eax
    1f1a:	0f 85 4d 02 00 00    	jne    216d <subdir+0x62d>
    printf(1, "unlink dd/ff failed\n");
    exit();
  }
  if(unlink("dd") == 0){
    1f20:	83 ec 0c             	sub    $0xc,%esp
    1f23:	68 5c 42 00 00       	push   $0x425c
    1f28:	e8 ea 16 00 00       	call   3617 <unlink>
    1f2d:	83 c4 10             	add    $0x10,%esp
    1f30:	85 c0                	test   %eax,%eax
    1f32:	0f 84 22 02 00 00    	je     215a <subdir+0x61a>
    printf(1, "unlink non-empty dd succeeded!\n");
    exit();
  }
  if(unlink("dd/dd") < 0){
    1f38:	83 ec 0c             	sub    $0xc,%esp
    1f3b:	68 71 41 00 00       	push   $0x4171
    1f40:	e8 d2 16 00 00       	call   3617 <unlink>
    1f45:	83 c4 10             	add    $0x10,%esp
    1f48:	85 c0                	test   %eax,%eax
    1f4a:	0f 88 f7 01 00 00    	js     2147 <subdir+0x607>
    printf(1, "unlink dd/dd failed\n");
    exit();
  }
  if(unlink("dd") < 0){
    1f50:	83 ec 0c             	sub    $0xc,%esp
    1f53:	68 5c 42 00 00       	push   $0x425c
    1f58:	e8 ba 16 00 00       	call   3617 <unlink>
    1f5d:	83 c4 10             	add    $0x10,%esp
    1f60:	85 c0                	test   %eax,%eax
    1f62:	0f 88 cc 01 00 00    	js     2134 <subdir+0x5f4>
    printf(1, "unlink dd failed\n");
    exit();
  }

  printf(1, "subdir ok\n");
    1f68:	83 ec 08             	sub    $0x8,%esp
    1f6b:	68 3e 44 00 00       	push   $0x443e
    1f70:	6a 01                	push   $0x1
    1f72:	e8 75 17 00 00       	call   36ec <printf>
}
    1f77:	83 c4 10             	add    $0x10,%esp
    1f7a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1f7d:	c9                   	leave  
    1f7e:	c3                   	ret    
    printf(1, "open dd/dd/../ff failed\n");
    exit();
  }
  cc = read(fd, buf, sizeof(buf));
  if(cc != 2 || buf[0] != 'f'){
    printf(1, "dd/dd/../ff wrong content\n");
    1f7f:	51                   	push   %ecx
    1f80:	51                   	push   %ecx
    1f81:	68 db 41 00 00       	push   $0x41db
    1f86:	6a 01                	push   $0x1
    1f88:	e8 5f 17 00 00       	call   36ec <printf>
    exit();
    1f8d:	e8 35 16 00 00       	call   35c7 <exit>
  if(chdir("dd") != 0){
    printf(1, "chdir dd failed\n");
    exit();
  }
  if(chdir("dd/../../dd") != 0){
    printf(1, "chdir dd/../../dd failed\n");
    1f92:	50                   	push   %eax
    1f93:	50                   	push   %eax
    1f94:	68 36 42 00 00       	push   $0x4236
    1f99:	6a 01                	push   $0x1
    1f9b:	e8 4c 17 00 00       	call   36ec <printf>
    exit();
    1fa0:	e8 22 16 00 00       	call   35c7 <exit>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    exit();
  }

  if(unlink("dd/dd/ff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    1fa5:	51                   	push   %ecx
    1fa6:	51                   	push   %ecx
    1fa7:	68 01 42 00 00       	push   $0x4201
    1fac:	6a 01                	push   $0x1
    1fae:	e8 39 17 00 00       	call   36ec <printf>
    exit();
    1fb3:	e8 0f 16 00 00       	call   35c7 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    exit();
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/ff/ff succeeded!\n");
    1fb8:	50                   	push   %eax
    1fb9:	50                   	push   %eax
    1fba:	68 b3 42 00 00       	push   $0x42b3
    1fbf:	6a 01                	push   $0x1
    1fc1:	e8 26 17 00 00       	call   36ec <printf>
    exit();
    1fc6:	e8 fc 15 00 00       	call   35c7 <exit>
    exit();
  }
  close(fd);

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    1fcb:	52                   	push   %edx
    1fcc:	52                   	push   %edx
    1fcd:	68 98 4c 00 00       	push   $0x4c98
    1fd2:	6a 01                	push   $0x1
    1fd4:	e8 13 17 00 00       	call   36ec <printf>
    exit();
    1fd9:	e8 e9 15 00 00       	call   35c7 <exit>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    exit();
  }
  if(mkdir("dd/ff/ff") == 0){
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    1fde:	52                   	push   %edx
    1fdf:	52                   	push   %edx
    1fe0:	68 47 43 00 00       	push   $0x4347
    1fe5:	6a 01                	push   $0x1
    1fe7:	e8 00 17 00 00       	call   36ec <printf>
    exit();
    1fec:	e8 d6 15 00 00       	call   35c7 <exit>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    1ff1:	51                   	push   %ecx
    1ff2:	51                   	push   %ecx
    1ff3:	68 08 4d 00 00       	push   $0x4d08
    1ff8:	6a 01                	push   $0x1
    1ffa:	e8 ed 16 00 00       	call   36ec <printf>
    exit();
    1fff:	e8 c3 15 00 00       	call   35c7 <exit>
  write(fd, "FF", 2);
  close(fd);

  fd = open("dd/dd/../ff", 0);
  if(fd < 0){
    printf(1, "open dd/dd/../ff failed\n");
    2004:	50                   	push   %eax
    2005:	50                   	push   %eax
    2006:	68 c2 41 00 00       	push   $0x41c2
    200b:	6a 01                	push   $0x1
    200d:	e8 da 16 00 00       	call   36ec <printf>
    exit();
    2012:	e8 b0 15 00 00       	call   35c7 <exit>
    exit();
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create dd/dd/ff failed\n");
    2017:	51                   	push   %ecx
    2018:	51                   	push   %ecx
    2019:	68 9b 41 00 00       	push   $0x419b
    201e:	6a 01                	push   $0x1
    2020:	e8 c7 16 00 00       	call   36ec <printf>
    exit();
    2025:	e8 9d 15 00 00       	call   35c7 <exit>
  if(chdir("dd/../../../dd") != 0){
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("./..") != 0){
    printf(1, "chdir ./.. failed\n");
    202a:	50                   	push   %eax
    202b:	50                   	push   %eax
    202c:	68 64 42 00 00       	push   $0x4264
    2031:	6a 01                	push   $0x1
    2033:	e8 b4 16 00 00       	call   36ec <printf>
    exit();
    2038:	e8 8a 15 00 00       	call   35c7 <exit>
    exit();
  }
  close(fd);

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    203d:	53                   	push   %ebx
    203e:	53                   	push   %ebx
    203f:	68 50 4c 00 00       	push   $0x4c50
    2044:	6a 01                	push   $0x1
    2046:	e8 a1 16 00 00       	call   36ec <printf>
    exit();
    204b:	e8 77 15 00 00       	call   35c7 <exit>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    2050:	53                   	push   %ebx
    2051:	53                   	push   %ebx
    2052:	68 e4 4c 00 00       	push   $0x4ce4
    2057:	6a 01                	push   $0x1
    2059:	e8 8e 16 00 00       	call   36ec <printf>
    exit();
    205e:	e8 64 15 00 00       	call   35c7 <exit>
  if(open("dd", O_WRONLY) >= 0){
    printf(1, "open dd wronly succeeded!\n");
    exit();
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    2063:	50                   	push   %eax
    2064:	50                   	push   %eax
    2065:	68 c0 4c 00 00       	push   $0x4cc0
    206a:	6a 01                	push   $0x1
    206c:	e8 7b 16 00 00       	call   36ec <printf>
    exit();
    2071:	e8 51 15 00 00       	call   35c7 <exit>
  if(open("dd", O_RDWR) >= 0){
    printf(1, "open dd rdwr succeeded!\n");
    exit();
  }
  if(open("dd", O_WRONLY) >= 0){
    printf(1, "open dd wronly succeeded!\n");
    2076:	50                   	push   %eax
    2077:	50                   	push   %eax
    2078:	68 23 43 00 00       	push   $0x4323
    207d:	6a 01                	push   $0x1
    207f:	e8 68 16 00 00       	call   36ec <printf>
    exit();
    2084:	e8 3e 15 00 00       	call   35c7 <exit>
  if(open("dd", O_CREATE) >= 0){
    printf(1, "create dd succeeded!\n");
    exit();
  }
  if(open("dd", O_RDWR) >= 0){
    printf(1, "open dd rdwr succeeded!\n");
    2089:	50                   	push   %eax
    208a:	50                   	push   %eax
    208b:	68 0a 43 00 00       	push   $0x430a
    2090:	6a 01                	push   $0x1
    2092:	e8 55 16 00 00       	call   36ec <printf>
    exit();
    2097:	e8 2b 15 00 00       	call   35c7 <exit>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/xx/ff succeeded!\n");
    exit();
  }
  if(open("dd", O_CREATE) >= 0){
    printf(1, "create dd succeeded!\n");
    209c:	50                   	push   %eax
    209d:	50                   	push   %eax
    209e:	68 f4 42 00 00       	push   $0x42f4
    20a3:	6a 01                	push   $0x1
    20a5:	e8 42 16 00 00       	call   36ec <printf>
    exit();
    20aa:	e8 18 15 00 00       	call   35c7 <exit>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/ff/ff succeeded!\n");
    exit();
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/xx/ff succeeded!\n");
    20af:	50                   	push   %eax
    20b0:	50                   	push   %eax
    20b1:	68 d8 42 00 00       	push   $0x42d8
    20b6:	6a 01                	push   $0x1
    20b8:	e8 2f 16 00 00       	call   36ec <printf>
    exit();
    20bd:	e8 05 15 00 00       	call   35c7 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    exit();
  }

  if(chdir("dd") != 0){
    printf(1, "chdir dd failed\n");
    20c2:	50                   	push   %eax
    20c3:	50                   	push   %eax
    20c4:	68 19 42 00 00       	push   $0x4219
    20c9:	6a 01                	push   $0x1
    20cb:	e8 1c 16 00 00       	call   36ec <printf>
    exit();
    20d0:	e8 f2 14 00 00       	call   35c7 <exit>
  if(unlink("dd/dd/ff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    20d5:	52                   	push   %edx
    20d6:	52                   	push   %edx
    20d7:	68 74 4c 00 00       	push   $0x4c74
    20dc:	6a 01                	push   $0x1
    20de:	e8 09 16 00 00       	call   36ec <printf>
    exit();
    20e3:	e8 df 14 00 00       	call   35c7 <exit>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    exit();
  }

  if(mkdir("/dd/dd") != 0){
    printf(1, "subdir mkdir dd/dd failed\n");
    20e8:	53                   	push   %ebx
    20e9:	53                   	push   %ebx
    20ea:	68 77 41 00 00       	push   $0x4177
    20ef:	6a 01                	push   $0x1
    20f1:	e8 f6 15 00 00       	call   36ec <printf>
    exit();
    20f6:	e8 cc 14 00 00       	call   35c7 <exit>
  }
  write(fd, "ff", 2);
  close(fd);

  if(unlink("dd") >= 0){
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    20fb:	50                   	push   %eax
    20fc:	50                   	push   %eax
    20fd:	68 28 4c 00 00       	push   $0x4c28
    2102:	6a 01                	push   $0x1
    2104:	e8 e3 15 00 00       	call   36ec <printf>
    exit();
    2109:	e8 b9 14 00 00       	call   35c7 <exit>
    exit();
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create dd/ff failed\n");
    210e:	50                   	push   %eax
    210f:	50                   	push   %eax
    2110:	68 5b 41 00 00       	push   $0x415b
    2115:	6a 01                	push   $0x1
    2117:	e8 d0 15 00 00       	call   36ec <printf>
    exit();
    211c:	e8 a6 14 00 00       	call   35c7 <exit>

  printf(1, "subdir test\n");

  unlink("ff");
  if(mkdir("dd") != 0){
    printf(1, "subdir mkdir dd failed\n");
    2121:	50                   	push   %eax
    2122:	50                   	push   %eax
    2123:	68 43 41 00 00       	push   $0x4143
    2128:	6a 01                	push   $0x1
    212a:	e8 bd 15 00 00       	call   36ec <printf>
    exit();
    212f:	e8 93 14 00 00       	call   35c7 <exit>
  if(unlink("dd/dd") < 0){
    printf(1, "unlink dd/dd failed\n");
    exit();
  }
  if(unlink("dd") < 0){
    printf(1, "unlink dd failed\n");
    2134:	50                   	push   %eax
    2135:	50                   	push   %eax
    2136:	68 2c 44 00 00       	push   $0x442c
    213b:	6a 01                	push   $0x1
    213d:	e8 aa 15 00 00       	call   36ec <printf>
    exit();
    2142:	e8 80 14 00 00       	call   35c7 <exit>
  if(unlink("dd") == 0){
    printf(1, "unlink non-empty dd succeeded!\n");
    exit();
  }
  if(unlink("dd/dd") < 0){
    printf(1, "unlink dd/dd failed\n");
    2147:	52                   	push   %edx
    2148:	52                   	push   %edx
    2149:	68 17 44 00 00       	push   $0x4417
    214e:	6a 01                	push   $0x1
    2150:	e8 97 15 00 00       	call   36ec <printf>
    exit();
    2155:	e8 6d 14 00 00       	call   35c7 <exit>
  if(unlink("dd/ff") != 0){
    printf(1, "unlink dd/ff failed\n");
    exit();
  }
  if(unlink("dd") == 0){
    printf(1, "unlink non-empty dd succeeded!\n");
    215a:	51                   	push   %ecx
    215b:	51                   	push   %ecx
    215c:	68 2c 4d 00 00       	push   $0x4d2c
    2161:	6a 01                	push   $0x1
    2163:	e8 84 15 00 00       	call   36ec <printf>
    exit();
    2168:	e8 5a 14 00 00       	call   35c7 <exit>
  if(unlink("dd/dd/ffff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(unlink("dd/ff") != 0){
    printf(1, "unlink dd/ff failed\n");
    216d:	53                   	push   %ebx
    216e:	53                   	push   %ebx
    216f:	68 02 44 00 00       	push   $0x4402
    2174:	6a 01                	push   $0x1
    2176:	e8 71 15 00 00       	call   36ec <printf>
    exit();
    217b:	e8 47 14 00 00       	call   35c7 <exit>
  if(chdir("dd/ff") == 0){
    printf(1, "chdir dd/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/xx") == 0){
    printf(1, "chdir dd/xx succeeded!\n");
    2180:	50                   	push   %eax
    2181:	50                   	push   %eax
    2182:	68 ea 43 00 00       	push   $0x43ea
    2187:	6a 01                	push   $0x1
    2189:	e8 5e 15 00 00       	call   36ec <printf>
    exit();
    218e:	e8 34 14 00 00       	call   35c7 <exit>
  if(unlink("dd/ff/ff") == 0){
    printf(1, "unlink dd/ff/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/ff") == 0){
    printf(1, "chdir dd/ff succeeded!\n");
    2193:	50                   	push   %eax
    2194:	50                   	push   %eax
    2195:	68 d2 43 00 00       	push   $0x43d2
    219a:	6a 01                	push   $0x1
    219c:	e8 4b 15 00 00       	call   36ec <printf>
    exit();
    21a1:	e8 21 14 00 00       	call   35c7 <exit>
  if(unlink("dd/xx/ff") == 0){
    printf(1, "unlink dd/xx/ff succeeded!\n");
    exit();
  }
  if(unlink("dd/ff/ff") == 0){
    printf(1, "unlink dd/ff/ff succeeded!\n");
    21a6:	50                   	push   %eax
    21a7:	50                   	push   %eax
    21a8:	68 b6 43 00 00       	push   $0x43b6
    21ad:	6a 01                	push   $0x1
    21af:	e8 38 15 00 00       	call   36ec <printf>
    exit();
    21b4:	e8 0e 14 00 00       	call   35c7 <exit>
  if(mkdir("dd/dd/ffff") == 0){
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    exit();
  }
  if(unlink("dd/xx/ff") == 0){
    printf(1, "unlink dd/xx/ff succeeded!\n");
    21b9:	50                   	push   %eax
    21ba:	50                   	push   %eax
    21bb:	68 9a 43 00 00       	push   $0x439a
    21c0:	6a 01                	push   $0x1
    21c2:	e8 25 15 00 00       	call   36ec <printf>
    exit();
    21c7:	e8 fb 13 00 00       	call   35c7 <exit>
  if(mkdir("dd/xx/ff") == 0){
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/dd/ffff") == 0){
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    21cc:	50                   	push   %eax
    21cd:	50                   	push   %eax
    21ce:	68 7d 43 00 00       	push   $0x437d
    21d3:	6a 01                	push   $0x1
    21d5:	e8 12 15 00 00       	call   36ec <printf>
    exit();
    21da:	e8 e8 13 00 00       	call   35c7 <exit>
  if(mkdir("dd/ff/ff") == 0){
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/xx/ff") == 0){
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    21df:	50                   	push   %eax
    21e0:	50                   	push   %eax
    21e1:	68 62 43 00 00       	push   $0x4362
    21e6:	6a 01                	push   $0x1
    21e8:	e8 ff 14 00 00       	call   36ec <printf>
    exit();
    21ed:	e8 d5 13 00 00       	call   35c7 <exit>
  if(fd < 0){
    printf(1, "open dd/dd/ffff failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    printf(1, "read dd/dd/ffff wrong len\n");
    21f2:	50                   	push   %eax
    21f3:	50                   	push   %eax
    21f4:	68 8f 42 00 00       	push   $0x428f
    21f9:	6a 01                	push   $0x1
    21fb:	e8 ec 14 00 00       	call   36ec <printf>
    exit();
    2200:	e8 c2 13 00 00       	call   35c7 <exit>
    exit();
  }

  fd = open("dd/dd/ffff", 0);
  if(fd < 0){
    printf(1, "open dd/dd/ffff failed\n");
    2205:	50                   	push   %eax
    2206:	50                   	push   %eax
    2207:	68 77 42 00 00       	push   $0x4277
    220c:	6a 01                	push   $0x1
    220e:	e8 d9 14 00 00       	call   36ec <printf>
    exit();
    2213:	e8 af 13 00 00       	call   35c7 <exit>

00002218 <bigwrite>:
}

// test writes that are larger than the log.
void
bigwrite(void)
{
    2218:	55                   	push   %ebp
    2219:	89 e5                	mov    %esp,%ebp
    221b:	56                   	push   %esi
    221c:	53                   	push   %ebx
  int fd, sz;

  printf(1, "bigwrite test\n");
    221d:	83 ec 08             	sub    $0x8,%esp
    2220:	68 49 44 00 00       	push   $0x4449
    2225:	6a 01                	push   $0x1
    2227:	e8 c0 14 00 00       	call   36ec <printf>

  unlink("bigwrite");
    222c:	c7 04 24 58 44 00 00 	movl   $0x4458,(%esp)
    2233:	e8 df 13 00 00       	call   3617 <unlink>
    2238:	83 c4 10             	add    $0x10,%esp
  for(sz = 499; sz < 12*512; sz += 471){
    223b:	bb f3 01 00 00       	mov    $0x1f3,%ebx
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2240:	83 ec 08             	sub    $0x8,%esp
    2243:	68 02 02 00 00       	push   $0x202
    2248:	68 58 44 00 00       	push   $0x4458
    224d:	e8 b5 13 00 00       	call   3607 <open>
    2252:	89 c6                	mov    %eax,%esi
    if(fd < 0){
    2254:	83 c4 10             	add    $0x10,%esp
    2257:	85 c0                	test   %eax,%eax
    2259:	78 7a                	js     22d5 <bigwrite+0xbd>
      printf(1, "cannot create bigwrite\n");
      exit();
    }
    int i;
    for(i = 0; i < 2; i++){
      int cc = write(fd, buf, sz);
    225b:	52                   	push   %edx
    225c:	53                   	push   %ebx
    225d:	68 60 82 00 00       	push   $0x8260
    2262:	50                   	push   %eax
    2263:	e8 7f 13 00 00       	call   35e7 <write>
      if(cc != sz){
    2268:	83 c4 10             	add    $0x10,%esp
    226b:	39 c3                	cmp    %eax,%ebx
    226d:	75 53                	jne    22c2 <bigwrite+0xaa>
      printf(1, "cannot create bigwrite\n");
      exit();
    }
    int i;
    for(i = 0; i < 2; i++){
      int cc = write(fd, buf, sz);
    226f:	50                   	push   %eax
    2270:	53                   	push   %ebx
    2271:	68 60 82 00 00       	push   $0x8260
    2276:	56                   	push   %esi
    2277:	e8 6b 13 00 00       	call   35e7 <write>
      if(cc != sz){
    227c:	83 c4 10             	add    $0x10,%esp
    227f:	39 c3                	cmp    %eax,%ebx
    2281:	75 3f                	jne    22c2 <bigwrite+0xaa>
        printf(1, "write(%d) ret %d\n", sz, cc);
        exit();
      }
    }
    close(fd);
    2283:	83 ec 0c             	sub    $0xc,%esp
    2286:	56                   	push   %esi
    2287:	e8 63 13 00 00       	call   35ef <close>
    unlink("bigwrite");
    228c:	c7 04 24 58 44 00 00 	movl   $0x4458,(%esp)
    2293:	e8 7f 13 00 00       	call   3617 <unlink>
  int fd, sz;

  printf(1, "bigwrite test\n");

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    2298:	81 c3 d7 01 00 00    	add    $0x1d7,%ebx
    229e:	83 c4 10             	add    $0x10,%esp
    22a1:	81 fb 07 18 00 00    	cmp    $0x1807,%ebx
    22a7:	75 97                	jne    2240 <bigwrite+0x28>
    }
    close(fd);
    unlink("bigwrite");
  }

  printf(1, "bigwrite ok\n");
    22a9:	83 ec 08             	sub    $0x8,%esp
    22ac:	68 8b 44 00 00       	push   $0x448b
    22b1:	6a 01                	push   $0x1
    22b3:	e8 34 14 00 00       	call   36ec <printf>
}
    22b8:	83 c4 10             	add    $0x10,%esp
    22bb:	8d 65 f8             	lea    -0x8(%ebp),%esp
    22be:	5b                   	pop    %ebx
    22bf:	5e                   	pop    %esi
    22c0:	5d                   	pop    %ebp
    22c1:	c3                   	ret    
    }
    int i;
    for(i = 0; i < 2; i++){
      int cc = write(fd, buf, sz);
      if(cc != sz){
        printf(1, "write(%d) ret %d\n", sz, cc);
    22c2:	50                   	push   %eax
    22c3:	53                   	push   %ebx
    22c4:	68 79 44 00 00       	push   $0x4479
    22c9:	6a 01                	push   $0x1
    22cb:	e8 1c 14 00 00       	call   36ec <printf>
        exit();
    22d0:	e8 f2 12 00 00       	call   35c7 <exit>

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    fd = open("bigwrite", O_CREATE | O_RDWR);
    if(fd < 0){
      printf(1, "cannot create bigwrite\n");
    22d5:	83 ec 08             	sub    $0x8,%esp
    22d8:	68 61 44 00 00       	push   $0x4461
    22dd:	6a 01                	push   $0x1
    22df:	e8 08 14 00 00       	call   36ec <printf>
      exit();
    22e4:	e8 de 12 00 00       	call   35c7 <exit>
    22e9:	8d 76 00             	lea    0x0(%esi),%esi

000022ec <bigfile>:
  printf(1, "bigwrite ok\n");
}

void
bigfile(void)
{
    22ec:	55                   	push   %ebp
    22ed:	89 e5                	mov    %esp,%ebp
    22ef:	57                   	push   %edi
    22f0:	56                   	push   %esi
    22f1:	53                   	push   %ebx
    22f2:	83 ec 14             	sub    $0x14,%esp
  int fd, i, total, cc;

  printf(1, "bigfile test\n");
    22f5:	68 98 44 00 00       	push   $0x4498
    22fa:	6a 01                	push   $0x1
    22fc:	e8 eb 13 00 00       	call   36ec <printf>

  unlink("bigfile");
    2301:	c7 04 24 b4 44 00 00 	movl   $0x44b4,(%esp)
    2308:	e8 0a 13 00 00       	call   3617 <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
    230d:	58                   	pop    %eax
    230e:	5a                   	pop    %edx
    230f:	68 02 02 00 00       	push   $0x202
    2314:	68 b4 44 00 00       	push   $0x44b4
    2319:	e8 e9 12 00 00       	call   3607 <open>
  if(fd < 0){
    231e:	83 c4 10             	add    $0x10,%esp
    2321:	85 c0                	test   %eax,%eax
    2323:	0f 88 53 01 00 00    	js     247c <bigfile+0x190>
    2329:	89 c6                	mov    %eax,%esi
    232b:	31 db                	xor    %ebx,%ebx
    232d:	8d 76 00             	lea    0x0(%esi),%esi
    printf(1, "cannot create bigfile");
    exit();
  }
  for(i = 0; i < 20; i++){
    memset(buf, i, 600);
    2330:	57                   	push   %edi
    2331:	68 58 02 00 00       	push   $0x258
    2336:	53                   	push   %ebx
    2337:	68 60 82 00 00       	push   $0x8260
    233c:	e8 53 11 00 00       	call   3494 <memset>
    if(write(fd, buf, 600) != 600){
    2341:	83 c4 0c             	add    $0xc,%esp
    2344:	68 58 02 00 00       	push   $0x258
    2349:	68 60 82 00 00       	push   $0x8260
    234e:	56                   	push   %esi
    234f:	e8 93 12 00 00       	call   35e7 <write>
    2354:	83 c4 10             	add    $0x10,%esp
    2357:	3d 58 02 00 00       	cmp    $0x258,%eax
    235c:	0f 85 f2 00 00 00    	jne    2454 <bigfile+0x168>
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "cannot create bigfile");
    exit();
  }
  for(i = 0; i < 20; i++){
    2362:	43                   	inc    %ebx
    2363:	83 fb 14             	cmp    $0x14,%ebx
    2366:	75 c8                	jne    2330 <bigfile+0x44>
    if(write(fd, buf, 600) != 600){
      printf(1, "write bigfile failed\n");
      exit();
    }
  }
  close(fd);
    2368:	83 ec 0c             	sub    $0xc,%esp
    236b:	56                   	push   %esi
    236c:	e8 7e 12 00 00       	call   35ef <close>

  fd = open("bigfile", 0);
    2371:	5b                   	pop    %ebx
    2372:	5e                   	pop    %esi
    2373:	6a 00                	push   $0x0
    2375:	68 b4 44 00 00       	push   $0x44b4
    237a:	e8 88 12 00 00       	call   3607 <open>
    237f:	89 c7                	mov    %eax,%edi
  if(fd < 0){
    2381:	83 c4 10             	add    $0x10,%esp
    2384:	85 c0                	test   %eax,%eax
    2386:	0f 88 dc 00 00 00    	js     2468 <bigfile+0x17c>
    238c:	31 f6                	xor    %esi,%esi
    238e:	31 db                	xor    %ebx,%ebx
    2390:	eb 2e                	jmp    23c0 <bigfile+0xd4>
    2392:	66 90                	xchg   %ax,%ax
      printf(1, "read bigfile failed\n");
      exit();
    }
    if(cc == 0)
      break;
    if(cc != 300){
    2394:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    2399:	0f 85 8d 00 00 00    	jne    242c <bigfile+0x140>
      printf(1, "short read bigfile\n");
      exit();
    }
    if(buf[0] != i/2 || buf[299] != i/2){
    239f:	0f be 05 60 82 00 00 	movsbl 0x8260,%eax
    23a6:	89 da                	mov    %ebx,%edx
    23a8:	d1 fa                	sar    %edx
    23aa:	39 d0                	cmp    %edx,%eax
    23ac:	75 6a                	jne    2418 <bigfile+0x12c>
    23ae:	0f be 15 8b 83 00 00 	movsbl 0x838b,%edx
    23b5:	39 d0                	cmp    %edx,%eax
    23b7:	75 5f                	jne    2418 <bigfile+0x12c>
      printf(1, "read bigfile wrong data\n");
      exit();
    }
    total += cc;
    23b9:	81 c6 2c 01 00 00    	add    $0x12c,%esi
  if(fd < 0){
    printf(1, "cannot open bigfile\n");
    exit();
  }
  total = 0;
  for(i = 0; ; i++){
    23bf:	43                   	inc    %ebx
    cc = read(fd, buf, 300);
    23c0:	51                   	push   %ecx
    23c1:	68 2c 01 00 00       	push   $0x12c
    23c6:	68 60 82 00 00       	push   $0x8260
    23cb:	57                   	push   %edi
    23cc:	e8 0e 12 00 00       	call   35df <read>
    if(cc < 0){
    23d1:	83 c4 10             	add    $0x10,%esp
    23d4:	85 c0                	test   %eax,%eax
    23d6:	78 68                	js     2440 <bigfile+0x154>
      printf(1, "read bigfile failed\n");
      exit();
    }
    if(cc == 0)
    23d8:	75 ba                	jne    2394 <bigfile+0xa8>
      printf(1, "read bigfile wrong data\n");
      exit();
    }
    total += cc;
  }
  close(fd);
    23da:	83 ec 0c             	sub    $0xc,%esp
    23dd:	57                   	push   %edi
    23de:	e8 0c 12 00 00       	call   35ef <close>
  if(total != 20*600){
    23e3:	83 c4 10             	add    $0x10,%esp
    23e6:	81 fe e0 2e 00 00    	cmp    $0x2ee0,%esi
    23ec:	0f 85 9e 00 00 00    	jne    2490 <bigfile+0x1a4>
    printf(1, "read bigfile wrong total\n");
    exit();
  }
  unlink("bigfile");
    23f2:	83 ec 0c             	sub    $0xc,%esp
    23f5:	68 b4 44 00 00       	push   $0x44b4
    23fa:	e8 18 12 00 00       	call   3617 <unlink>

  printf(1, "bigfile test ok\n");
    23ff:	58                   	pop    %eax
    2400:	5a                   	pop    %edx
    2401:	68 43 45 00 00       	push   $0x4543
    2406:	6a 01                	push   $0x1
    2408:	e8 df 12 00 00       	call   36ec <printf>
}
    240d:	83 c4 10             	add    $0x10,%esp
    2410:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2413:	5b                   	pop    %ebx
    2414:	5e                   	pop    %esi
    2415:	5f                   	pop    %edi
    2416:	5d                   	pop    %ebp
    2417:	c3                   	ret    
    if(cc != 300){
      printf(1, "short read bigfile\n");
      exit();
    }
    if(buf[0] != i/2 || buf[299] != i/2){
      printf(1, "read bigfile wrong data\n");
    2418:	83 ec 08             	sub    $0x8,%esp
    241b:	68 10 45 00 00       	push   $0x4510
    2420:	6a 01                	push   $0x1
    2422:	e8 c5 12 00 00       	call   36ec <printf>
      exit();
    2427:	e8 9b 11 00 00       	call   35c7 <exit>
      exit();
    }
    if(cc == 0)
      break;
    if(cc != 300){
      printf(1, "short read bigfile\n");
    242c:	83 ec 08             	sub    $0x8,%esp
    242f:	68 fc 44 00 00       	push   $0x44fc
    2434:	6a 01                	push   $0x1
    2436:	e8 b1 12 00 00       	call   36ec <printf>
      exit();
    243b:	e8 87 11 00 00       	call   35c7 <exit>
  }
  total = 0;
  for(i = 0; ; i++){
    cc = read(fd, buf, 300);
    if(cc < 0){
      printf(1, "read bigfile failed\n");
    2440:	83 ec 08             	sub    $0x8,%esp
    2443:	68 e7 44 00 00       	push   $0x44e7
    2448:	6a 01                	push   $0x1
    244a:	e8 9d 12 00 00       	call   36ec <printf>
      exit();
    244f:	e8 73 11 00 00       	call   35c7 <exit>
    exit();
  }
  for(i = 0; i < 20; i++){
    memset(buf, i, 600);
    if(write(fd, buf, 600) != 600){
      printf(1, "write bigfile failed\n");
    2454:	83 ec 08             	sub    $0x8,%esp
    2457:	68 bc 44 00 00       	push   $0x44bc
    245c:	6a 01                	push   $0x1
    245e:	e8 89 12 00 00       	call   36ec <printf>
      exit();
    2463:	e8 5f 11 00 00       	call   35c7 <exit>
  }
  close(fd);

  fd = open("bigfile", 0);
  if(fd < 0){
    printf(1, "cannot open bigfile\n");
    2468:	83 ec 08             	sub    $0x8,%esp
    246b:	68 d2 44 00 00       	push   $0x44d2
    2470:	6a 01                	push   $0x1
    2472:	e8 75 12 00 00       	call   36ec <printf>
    exit();
    2477:	e8 4b 11 00 00       	call   35c7 <exit>
  printf(1, "bigfile test\n");

  unlink("bigfile");
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "cannot create bigfile");
    247c:	83 ec 08             	sub    $0x8,%esp
    247f:	68 a6 44 00 00       	push   $0x44a6
    2484:	6a 01                	push   $0x1
    2486:	e8 61 12 00 00       	call   36ec <printf>
    exit();
    248b:	e8 37 11 00 00       	call   35c7 <exit>
    }
    total += cc;
  }
  close(fd);
  if(total != 20*600){
    printf(1, "read bigfile wrong total\n");
    2490:	83 ec 08             	sub    $0x8,%esp
    2493:	68 29 45 00 00       	push   $0x4529
    2498:	6a 01                	push   $0x1
    249a:	e8 4d 12 00 00       	call   36ec <printf>
    exit();
    249f:	e8 23 11 00 00       	call   35c7 <exit>

000024a4 <fourteen>:
  printf(1, "bigfile test ok\n");
}

void
fourteen(void)
{
    24a4:	55                   	push   %ebp
    24a5:	89 e5                	mov    %esp,%ebp
    24a7:	83 ec 10             	sub    $0x10,%esp
  int fd;

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");
    24aa:	68 54 45 00 00       	push   $0x4554
    24af:	6a 01                	push   $0x1
    24b1:	e8 36 12 00 00       	call   36ec <printf>

  if(mkdir("12345678901234") != 0){
    24b6:	c7 04 24 8f 45 00 00 	movl   $0x458f,(%esp)
    24bd:	e8 6d 11 00 00       	call   362f <mkdir>
    24c2:	83 c4 10             	add    $0x10,%esp
    24c5:	85 c0                	test   %eax,%eax
    24c7:	0f 85 97 00 00 00    	jne    2564 <fourteen+0xc0>
    printf(1, "mkdir 12345678901234 failed\n");
    exit();
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    24cd:	83 ec 0c             	sub    $0xc,%esp
    24d0:	68 4c 4d 00 00       	push   $0x4d4c
    24d5:	e8 55 11 00 00       	call   362f <mkdir>
    24da:	83 c4 10             	add    $0x10,%esp
    24dd:	85 c0                	test   %eax,%eax
    24df:	0f 85 de 00 00 00    	jne    25c3 <fourteen+0x11f>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    exit();
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    24e5:	83 ec 08             	sub    $0x8,%esp
    24e8:	68 00 02 00 00       	push   $0x200
    24ed:	68 9c 4d 00 00       	push   $0x4d9c
    24f2:	e8 10 11 00 00       	call   3607 <open>
  if(fd < 0){
    24f7:	83 c4 10             	add    $0x10,%esp
    24fa:	85 c0                	test   %eax,%eax
    24fc:	0f 88 ae 00 00 00    	js     25b0 <fourteen+0x10c>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    exit();
  }
  close(fd);
    2502:	83 ec 0c             	sub    $0xc,%esp
    2505:	50                   	push   %eax
    2506:	e8 e4 10 00 00       	call   35ef <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    250b:	58                   	pop    %eax
    250c:	5a                   	pop    %edx
    250d:	6a 00                	push   $0x0
    250f:	68 0c 4e 00 00       	push   $0x4e0c
    2514:	e8 ee 10 00 00       	call   3607 <open>
  if(fd < 0){
    2519:	83 c4 10             	add    $0x10,%esp
    251c:	85 c0                	test   %eax,%eax
    251e:	78 7d                	js     259d <fourteen+0xf9>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    exit();
  }
  close(fd);
    2520:	83 ec 0c             	sub    $0xc,%esp
    2523:	50                   	push   %eax
    2524:	e8 c6 10 00 00       	call   35ef <close>

  if(mkdir("12345678901234/12345678901234") == 0){
    2529:	c7 04 24 80 45 00 00 	movl   $0x4580,(%esp)
    2530:	e8 fa 10 00 00       	call   362f <mkdir>
    2535:	83 c4 10             	add    $0x10,%esp
    2538:	85 c0                	test   %eax,%eax
    253a:	74 4e                	je     258a <fourteen+0xe6>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    exit();
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    253c:	83 ec 0c             	sub    $0xc,%esp
    253f:	68 a8 4e 00 00       	push   $0x4ea8
    2544:	e8 e6 10 00 00       	call   362f <mkdir>
    2549:	83 c4 10             	add    $0x10,%esp
    254c:	85 c0                	test   %eax,%eax
    254e:	74 27                	je     2577 <fourteen+0xd3>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    exit();
  }

  printf(1, "fourteen ok\n");
    2550:	83 ec 08             	sub    $0x8,%esp
    2553:	68 9e 45 00 00       	push   $0x459e
    2558:	6a 01                	push   $0x1
    255a:	e8 8d 11 00 00       	call   36ec <printf>
}
    255f:	83 c4 10             	add    $0x10,%esp
    2562:	c9                   	leave  
    2563:	c3                   	ret    

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");

  if(mkdir("12345678901234") != 0){
    printf(1, "mkdir 12345678901234 failed\n");
    2564:	50                   	push   %eax
    2565:	50                   	push   %eax
    2566:	68 63 45 00 00       	push   $0x4563
    256b:	6a 01                	push   $0x1
    256d:	e8 7a 11 00 00       	call   36ec <printf>
    exit();
    2572:	e8 50 10 00 00       	call   35c7 <exit>
  if(mkdir("12345678901234/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    exit();
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    2577:	50                   	push   %eax
    2578:	50                   	push   %eax
    2579:	68 c8 4e 00 00       	push   $0x4ec8
    257e:	6a 01                	push   $0x1
    2580:	e8 67 11 00 00       	call   36ec <printf>
    exit();
    2585:	e8 3d 10 00 00       	call   35c7 <exit>
    exit();
  }
  close(fd);

  if(mkdir("12345678901234/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    258a:	52                   	push   %edx
    258b:	52                   	push   %edx
    258c:	68 78 4e 00 00       	push   $0x4e78
    2591:	6a 01                	push   $0x1
    2593:	e8 54 11 00 00       	call   36ec <printf>
    exit();
    2598:	e8 2a 10 00 00       	call   35c7 <exit>
    exit();
  }
  close(fd);
  fd = open("12345678901234/12345678901234/12345678901234", 0);
  if(fd < 0){
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    259d:	51                   	push   %ecx
    259e:	51                   	push   %ecx
    259f:	68 3c 4e 00 00       	push   $0x4e3c
    25a4:	6a 01                	push   $0x1
    25a6:	e8 41 11 00 00       	call   36ec <printf>
    exit();
    25ab:	e8 17 10 00 00       	call   35c7 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    exit();
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
  if(fd < 0){
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    25b0:	51                   	push   %ecx
    25b1:	51                   	push   %ecx
    25b2:	68 cc 4d 00 00       	push   $0x4dcc
    25b7:	6a 01                	push   $0x1
    25b9:	e8 2e 11 00 00       	call   36ec <printf>
    exit();
    25be:	e8 04 10 00 00       	call   35c7 <exit>
  if(mkdir("12345678901234") != 0){
    printf(1, "mkdir 12345678901234 failed\n");
    exit();
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    25c3:	50                   	push   %eax
    25c4:	50                   	push   %eax
    25c5:	68 6c 4d 00 00       	push   $0x4d6c
    25ca:	6a 01                	push   $0x1
    25cc:	e8 1b 11 00 00       	call   36ec <printf>
    exit();
    25d1:	e8 f1 0f 00 00       	call   35c7 <exit>
    25d6:	66 90                	xchg   %ax,%ax

000025d8 <rmdot>:
  printf(1, "fourteen ok\n");
}

void
rmdot(void)
{
    25d8:	55                   	push   %ebp
    25d9:	89 e5                	mov    %esp,%ebp
    25db:	83 ec 10             	sub    $0x10,%esp
  printf(1, "rmdot test\n");
    25de:	68 ab 45 00 00       	push   $0x45ab
    25e3:	6a 01                	push   $0x1
    25e5:	e8 02 11 00 00       	call   36ec <printf>
  if(mkdir("dots") != 0){
    25ea:	c7 04 24 b7 45 00 00 	movl   $0x45b7,(%esp)
    25f1:	e8 39 10 00 00       	call   362f <mkdir>
    25f6:	83 c4 10             	add    $0x10,%esp
    25f9:	85 c0                	test   %eax,%eax
    25fb:	0f 85 b0 00 00 00    	jne    26b1 <rmdot+0xd9>
    printf(1, "mkdir dots failed\n");
    exit();
  }
  if(chdir("dots") != 0){
    2601:	83 ec 0c             	sub    $0xc,%esp
    2604:	68 b7 45 00 00       	push   $0x45b7
    2609:	e8 29 10 00 00       	call   3637 <chdir>
    260e:	83 c4 10             	add    $0x10,%esp
    2611:	85 c0                	test   %eax,%eax
    2613:	0f 85 1d 01 00 00    	jne    2736 <rmdot+0x15e>
    printf(1, "chdir dots failed\n");
    exit();
  }
  if(unlink(".") == 0){
    2619:	83 ec 0c             	sub    $0xc,%esp
    261c:	68 62 42 00 00       	push   $0x4262
    2621:	e8 f1 0f 00 00       	call   3617 <unlink>
    2626:	83 c4 10             	add    $0x10,%esp
    2629:	85 c0                	test   %eax,%eax
    262b:	0f 84 f2 00 00 00    	je     2723 <rmdot+0x14b>
    printf(1, "rm . worked!\n");
    exit();
  }
  if(unlink("..") == 0){
    2631:	83 ec 0c             	sub    $0xc,%esp
    2634:	68 61 42 00 00       	push   $0x4261
    2639:	e8 d9 0f 00 00       	call   3617 <unlink>
    263e:	83 c4 10             	add    $0x10,%esp
    2641:	85 c0                	test   %eax,%eax
    2643:	0f 84 c7 00 00 00    	je     2710 <rmdot+0x138>
    printf(1, "rm .. worked!\n");
    exit();
  }
  if(chdir("/") != 0){
    2649:	83 ec 0c             	sub    $0xc,%esp
    264c:	68 35 3a 00 00       	push   $0x3a35
    2651:	e8 e1 0f 00 00       	call   3637 <chdir>
    2656:	83 c4 10             	add    $0x10,%esp
    2659:	85 c0                	test   %eax,%eax
    265b:	0f 85 9c 00 00 00    	jne    26fd <rmdot+0x125>
    printf(1, "chdir / failed\n");
    exit();
  }
  if(unlink("dots/.") == 0){
    2661:	83 ec 0c             	sub    $0xc,%esp
    2664:	68 ff 45 00 00       	push   $0x45ff
    2669:	e8 a9 0f 00 00       	call   3617 <unlink>
    266e:	83 c4 10             	add    $0x10,%esp
    2671:	85 c0                	test   %eax,%eax
    2673:	74 75                	je     26ea <rmdot+0x112>
    printf(1, "unlink dots/. worked!\n");
    exit();
  }
  if(unlink("dots/..") == 0){
    2675:	83 ec 0c             	sub    $0xc,%esp
    2678:	68 1d 46 00 00       	push   $0x461d
    267d:	e8 95 0f 00 00       	call   3617 <unlink>
    2682:	83 c4 10             	add    $0x10,%esp
    2685:	85 c0                	test   %eax,%eax
    2687:	74 4e                	je     26d7 <rmdot+0xff>
    printf(1, "unlink dots/.. worked!\n");
    exit();
  }
  if(unlink("dots") != 0){
    2689:	83 ec 0c             	sub    $0xc,%esp
    268c:	68 b7 45 00 00       	push   $0x45b7
    2691:	e8 81 0f 00 00       	call   3617 <unlink>
    2696:	83 c4 10             	add    $0x10,%esp
    2699:	85 c0                	test   %eax,%eax
    269b:	75 27                	jne    26c4 <rmdot+0xec>
    printf(1, "unlink dots failed!\n");
    exit();
  }
  printf(1, "rmdot ok\n");
    269d:	83 ec 08             	sub    $0x8,%esp
    26a0:	68 52 46 00 00       	push   $0x4652
    26a5:	6a 01                	push   $0x1
    26a7:	e8 40 10 00 00       	call   36ec <printf>
}
    26ac:	83 c4 10             	add    $0x10,%esp
    26af:	c9                   	leave  
    26b0:	c3                   	ret    
void
rmdot(void)
{
  printf(1, "rmdot test\n");
  if(mkdir("dots") != 0){
    printf(1, "mkdir dots failed\n");
    26b1:	50                   	push   %eax
    26b2:	50                   	push   %eax
    26b3:	68 bc 45 00 00       	push   $0x45bc
    26b8:	6a 01                	push   $0x1
    26ba:	e8 2d 10 00 00       	call   36ec <printf>
    exit();
    26bf:	e8 03 0f 00 00       	call   35c7 <exit>
  if(unlink("dots/..") == 0){
    printf(1, "unlink dots/.. worked!\n");
    exit();
  }
  if(unlink("dots") != 0){
    printf(1, "unlink dots failed!\n");
    26c4:	50                   	push   %eax
    26c5:	50                   	push   %eax
    26c6:	68 3d 46 00 00       	push   $0x463d
    26cb:	6a 01                	push   $0x1
    26cd:	e8 1a 10 00 00       	call   36ec <printf>
    exit();
    26d2:	e8 f0 0e 00 00       	call   35c7 <exit>
  if(unlink("dots/.") == 0){
    printf(1, "unlink dots/. worked!\n");
    exit();
  }
  if(unlink("dots/..") == 0){
    printf(1, "unlink dots/.. worked!\n");
    26d7:	52                   	push   %edx
    26d8:	52                   	push   %edx
    26d9:	68 25 46 00 00       	push   $0x4625
    26de:	6a 01                	push   $0x1
    26e0:	e8 07 10 00 00       	call   36ec <printf>
    exit();
    26e5:	e8 dd 0e 00 00       	call   35c7 <exit>
  if(chdir("/") != 0){
    printf(1, "chdir / failed\n");
    exit();
  }
  if(unlink("dots/.") == 0){
    printf(1, "unlink dots/. worked!\n");
    26ea:	51                   	push   %ecx
    26eb:	51                   	push   %ecx
    26ec:	68 06 46 00 00       	push   $0x4606
    26f1:	6a 01                	push   $0x1
    26f3:	e8 f4 0f 00 00       	call   36ec <printf>
    exit();
    26f8:	e8 ca 0e 00 00       	call   35c7 <exit>
  if(unlink("..") == 0){
    printf(1, "rm .. worked!\n");
    exit();
  }
  if(chdir("/") != 0){
    printf(1, "chdir / failed\n");
    26fd:	50                   	push   %eax
    26fe:	50                   	push   %eax
    26ff:	68 37 3a 00 00       	push   $0x3a37
    2704:	6a 01                	push   $0x1
    2706:	e8 e1 0f 00 00       	call   36ec <printf>
    exit();
    270b:	e8 b7 0e 00 00       	call   35c7 <exit>
  if(unlink(".") == 0){
    printf(1, "rm . worked!\n");
    exit();
  }
  if(unlink("..") == 0){
    printf(1, "rm .. worked!\n");
    2710:	50                   	push   %eax
    2711:	50                   	push   %eax
    2712:	68 f0 45 00 00       	push   $0x45f0
    2717:	6a 01                	push   $0x1
    2719:	e8 ce 0f 00 00       	call   36ec <printf>
    exit();
    271e:	e8 a4 0e 00 00       	call   35c7 <exit>
  if(chdir("dots") != 0){
    printf(1, "chdir dots failed\n");
    exit();
  }
  if(unlink(".") == 0){
    printf(1, "rm . worked!\n");
    2723:	50                   	push   %eax
    2724:	50                   	push   %eax
    2725:	68 e2 45 00 00       	push   $0x45e2
    272a:	6a 01                	push   $0x1
    272c:	e8 bb 0f 00 00       	call   36ec <printf>
    exit();
    2731:	e8 91 0e 00 00       	call   35c7 <exit>
  if(mkdir("dots") != 0){
    printf(1, "mkdir dots failed\n");
    exit();
  }
  if(chdir("dots") != 0){
    printf(1, "chdir dots failed\n");
    2736:	50                   	push   %eax
    2737:	50                   	push   %eax
    2738:	68 cf 45 00 00       	push   $0x45cf
    273d:	6a 01                	push   $0x1
    273f:	e8 a8 0f 00 00       	call   36ec <printf>
    exit();
    2744:	e8 7e 0e 00 00       	call   35c7 <exit>
    2749:	8d 76 00             	lea    0x0(%esi),%esi

0000274c <dirfile>:
  printf(1, "rmdot ok\n");
}

void
dirfile(void)
{
    274c:	55                   	push   %ebp
    274d:	89 e5                	mov    %esp,%ebp
    274f:	53                   	push   %ebx
    2750:	83 ec 0c             	sub    $0xc,%esp
  int fd;

  printf(1, "dir vs file\n");
    2753:	68 5c 46 00 00       	push   $0x465c
    2758:	6a 01                	push   $0x1
    275a:	e8 8d 0f 00 00       	call   36ec <printf>

  fd = open("dirfile", O_CREATE);
    275f:	59                   	pop    %ecx
    2760:	5b                   	pop    %ebx
    2761:	68 00 02 00 00       	push   $0x200
    2766:	68 69 46 00 00       	push   $0x4669
    276b:	e8 97 0e 00 00       	call   3607 <open>
  if(fd < 0){
    2770:	83 c4 10             	add    $0x10,%esp
    2773:	85 c0                	test   %eax,%eax
    2775:	0f 88 43 01 00 00    	js     28be <dirfile+0x172>
    printf(1, "create dirfile failed\n");
    exit();
  }
  close(fd);
    277b:	83 ec 0c             	sub    $0xc,%esp
    277e:	50                   	push   %eax
    277f:	e8 6b 0e 00 00       	call   35ef <close>
  if(chdir("dirfile") == 0){
    2784:	c7 04 24 69 46 00 00 	movl   $0x4669,(%esp)
    278b:	e8 a7 0e 00 00       	call   3637 <chdir>
    2790:	83 c4 10             	add    $0x10,%esp
    2793:	85 c0                	test   %eax,%eax
    2795:	0f 84 10 01 00 00    	je     28ab <dirfile+0x15f>
    printf(1, "chdir dirfile succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", 0);
    279b:	83 ec 08             	sub    $0x8,%esp
    279e:	6a 00                	push   $0x0
    27a0:	68 a2 46 00 00       	push   $0x46a2
    27a5:	e8 5d 0e 00 00       	call   3607 <open>
  if(fd >= 0){
    27aa:	83 c4 10             	add    $0x10,%esp
    27ad:	85 c0                	test   %eax,%eax
    27af:	0f 89 e3 00 00 00    	jns    2898 <dirfile+0x14c>
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", O_CREATE);
    27b5:	83 ec 08             	sub    $0x8,%esp
    27b8:	68 00 02 00 00       	push   $0x200
    27bd:	68 a2 46 00 00       	push   $0x46a2
    27c2:	e8 40 0e 00 00       	call   3607 <open>
  if(fd >= 0){
    27c7:	83 c4 10             	add    $0x10,%esp
    27ca:	85 c0                	test   %eax,%eax
    27cc:	0f 89 c6 00 00 00    	jns    2898 <dirfile+0x14c>
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  if(mkdir("dirfile/xx") == 0){
    27d2:	83 ec 0c             	sub    $0xc,%esp
    27d5:	68 a2 46 00 00       	push   $0x46a2
    27da:	e8 50 0e 00 00       	call   362f <mkdir>
    27df:	83 c4 10             	add    $0x10,%esp
    27e2:	85 c0                	test   %eax,%eax
    27e4:	0f 84 46 01 00 00    	je     2930 <dirfile+0x1e4>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile/xx") == 0){
    27ea:	83 ec 0c             	sub    $0xc,%esp
    27ed:	68 a2 46 00 00       	push   $0x46a2
    27f2:	e8 20 0e 00 00       	call   3617 <unlink>
    27f7:	83 c4 10             	add    $0x10,%esp
    27fa:	85 c0                	test   %eax,%eax
    27fc:	0f 84 1b 01 00 00    	je     291d <dirfile+0x1d1>
    printf(1, "unlink dirfile/xx succeeded!\n");
    exit();
  }
  if(link("README", "dirfile/xx") == 0){
    2802:	83 ec 08             	sub    $0x8,%esp
    2805:	68 a2 46 00 00       	push   $0x46a2
    280a:	68 06 47 00 00       	push   $0x4706
    280f:	e8 13 0e 00 00       	call   3627 <link>
    2814:	83 c4 10             	add    $0x10,%esp
    2817:	85 c0                	test   %eax,%eax
    2819:	0f 84 eb 00 00 00    	je     290a <dirfile+0x1be>
    printf(1, "link to dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile") != 0){
    281f:	83 ec 0c             	sub    $0xc,%esp
    2822:	68 69 46 00 00       	push   $0x4669
    2827:	e8 eb 0d 00 00       	call   3617 <unlink>
    282c:	83 c4 10             	add    $0x10,%esp
    282f:	85 c0                	test   %eax,%eax
    2831:	0f 85 c0 00 00 00    	jne    28f7 <dirfile+0x1ab>
    printf(1, "unlink dirfile failed!\n");
    exit();
  }

  fd = open(".", O_RDWR);
    2837:	83 ec 08             	sub    $0x8,%esp
    283a:	6a 02                	push   $0x2
    283c:	68 62 42 00 00       	push   $0x4262
    2841:	e8 c1 0d 00 00       	call   3607 <open>
  if(fd >= 0){
    2846:	83 c4 10             	add    $0x10,%esp
    2849:	85 c0                	test   %eax,%eax
    284b:	0f 89 93 00 00 00    	jns    28e4 <dirfile+0x198>
    printf(1, "open . for writing succeeded!\n");
    exit();
  }
  fd = open(".", 0);
    2851:	83 ec 08             	sub    $0x8,%esp
    2854:	6a 00                	push   $0x0
    2856:	68 62 42 00 00       	push   $0x4262
    285b:	e8 a7 0d 00 00       	call   3607 <open>
    2860:	89 c3                	mov    %eax,%ebx
  if(write(fd, "x", 1) > 0){
    2862:	83 c4 0c             	add    $0xc,%esp
    2865:	6a 01                	push   $0x1
    2867:	68 45 43 00 00       	push   $0x4345
    286c:	50                   	push   %eax
    286d:	e8 75 0d 00 00       	call   35e7 <write>
    2872:	83 c4 10             	add    $0x10,%esp
    2875:	85 c0                	test   %eax,%eax
    2877:	7f 58                	jg     28d1 <dirfile+0x185>
    printf(1, "write . succeeded!\n");
    exit();
  }
  close(fd);
    2879:	83 ec 0c             	sub    $0xc,%esp
    287c:	53                   	push   %ebx
    287d:	e8 6d 0d 00 00       	call   35ef <close>

  printf(1, "dir vs file OK\n");
    2882:	58                   	pop    %eax
    2883:	5a                   	pop    %edx
    2884:	68 39 47 00 00       	push   $0x4739
    2889:	6a 01                	push   $0x1
    288b:	e8 5c 0e 00 00       	call   36ec <printf>
}
    2890:	83 c4 10             	add    $0x10,%esp
    2893:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2896:	c9                   	leave  
    2897:	c3                   	ret    
    printf(1, "chdir dirfile succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", 0);
  if(fd >= 0){
    printf(1, "create dirfile/xx succeeded!\n");
    2898:	50                   	push   %eax
    2899:	50                   	push   %eax
    289a:	68 ad 46 00 00       	push   $0x46ad
    289f:	6a 01                	push   $0x1
    28a1:	e8 46 0e 00 00       	call   36ec <printf>
    exit();
    28a6:	e8 1c 0d 00 00       	call   35c7 <exit>
    printf(1, "create dirfile failed\n");
    exit();
  }
  close(fd);
  if(chdir("dirfile") == 0){
    printf(1, "chdir dirfile succeeded!\n");
    28ab:	50                   	push   %eax
    28ac:	50                   	push   %eax
    28ad:	68 88 46 00 00       	push   $0x4688
    28b2:	6a 01                	push   $0x1
    28b4:	e8 33 0e 00 00       	call   36ec <printf>
    exit();
    28b9:	e8 09 0d 00 00       	call   35c7 <exit>

  printf(1, "dir vs file\n");

  fd = open("dirfile", O_CREATE);
  if(fd < 0){
    printf(1, "create dirfile failed\n");
    28be:	52                   	push   %edx
    28bf:	52                   	push   %edx
    28c0:	68 71 46 00 00       	push   $0x4671
    28c5:	6a 01                	push   $0x1
    28c7:	e8 20 0e 00 00       	call   36ec <printf>
    exit();
    28cc:	e8 f6 0c 00 00       	call   35c7 <exit>
    printf(1, "open . for writing succeeded!\n");
    exit();
  }
  fd = open(".", 0);
  if(write(fd, "x", 1) > 0){
    printf(1, "write . succeeded!\n");
    28d1:	51                   	push   %ecx
    28d2:	51                   	push   %ecx
    28d3:	68 25 47 00 00       	push   $0x4725
    28d8:	6a 01                	push   $0x1
    28da:	e8 0d 0e 00 00       	call   36ec <printf>
    exit();
    28df:	e8 e3 0c 00 00       	call   35c7 <exit>
    exit();
  }

  fd = open(".", O_RDWR);
  if(fd >= 0){
    printf(1, "open . for writing succeeded!\n");
    28e4:	53                   	push   %ebx
    28e5:	53                   	push   %ebx
    28e6:	68 1c 4f 00 00       	push   $0x4f1c
    28eb:	6a 01                	push   $0x1
    28ed:	e8 fa 0d 00 00       	call   36ec <printf>
    exit();
    28f2:	e8 d0 0c 00 00       	call   35c7 <exit>
  if(link("README", "dirfile/xx") == 0){
    printf(1, "link to dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile") != 0){
    printf(1, "unlink dirfile failed!\n");
    28f7:	50                   	push   %eax
    28f8:	50                   	push   %eax
    28f9:	68 0d 47 00 00       	push   $0x470d
    28fe:	6a 01                	push   $0x1
    2900:	e8 e7 0d 00 00       	call   36ec <printf>
    exit();
    2905:	e8 bd 0c 00 00       	call   35c7 <exit>
  if(unlink("dirfile/xx") == 0){
    printf(1, "unlink dirfile/xx succeeded!\n");
    exit();
  }
  if(link("README", "dirfile/xx") == 0){
    printf(1, "link to dirfile/xx succeeded!\n");
    290a:	50                   	push   %eax
    290b:	50                   	push   %eax
    290c:	68 fc 4e 00 00       	push   $0x4efc
    2911:	6a 01                	push   $0x1
    2913:	e8 d4 0d 00 00       	call   36ec <printf>
    exit();
    2918:	e8 aa 0c 00 00       	call   35c7 <exit>
  if(mkdir("dirfile/xx") == 0){
    printf(1, "mkdir dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile/xx") == 0){
    printf(1, "unlink dirfile/xx succeeded!\n");
    291d:	50                   	push   %eax
    291e:	50                   	push   %eax
    291f:	68 e8 46 00 00       	push   $0x46e8
    2924:	6a 01                	push   $0x1
    2926:	e8 c1 0d 00 00       	call   36ec <printf>
    exit();
    292b:	e8 97 0c 00 00       	call   35c7 <exit>
  if(fd >= 0){
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  if(mkdir("dirfile/xx") == 0){
    printf(1, "mkdir dirfile/xx succeeded!\n");
    2930:	50                   	push   %eax
    2931:	50                   	push   %eax
    2932:	68 cb 46 00 00       	push   $0x46cb
    2937:	6a 01                	push   $0x1
    2939:	e8 ae 0d 00 00       	call   36ec <printf>
    exit();
    293e:	e8 84 0c 00 00       	call   35c7 <exit>
    2943:	90                   	nop

00002944 <iref>:
}

// test that iput() is called at the end of _namei()
void
iref(void)
{
    2944:	55                   	push   %ebp
    2945:	89 e5                	mov    %esp,%ebp
    2947:	53                   	push   %ebx
    2948:	83 ec 0c             	sub    $0xc,%esp
  int i, fd;

  printf(1, "empty file name\n");
    294b:	68 49 47 00 00       	push   $0x4749
    2950:	6a 01                	push   $0x1
    2952:	e8 95 0d 00 00       	call   36ec <printf>
    2957:	83 c4 10             	add    $0x10,%esp
    295a:	bb 33 00 00 00       	mov    $0x33,%ebx
    295f:	90                   	nop

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    if(mkdir("irefd") != 0){
    2960:	83 ec 0c             	sub    $0xc,%esp
    2963:	68 5a 47 00 00       	push   $0x475a
    2968:	e8 c2 0c 00 00       	call   362f <mkdir>
    296d:	83 c4 10             	add    $0x10,%esp
    2970:	85 c0                	test   %eax,%eax
    2972:	0f 85 b9 00 00 00    	jne    2a31 <iref+0xed>
      printf(1, "mkdir irefd failed\n");
      exit();
    }
    if(chdir("irefd") != 0){
    2978:	83 ec 0c             	sub    $0xc,%esp
    297b:	68 5a 47 00 00       	push   $0x475a
    2980:	e8 b2 0c 00 00       	call   3637 <chdir>
    2985:	83 c4 10             	add    $0x10,%esp
    2988:	85 c0                	test   %eax,%eax
    298a:	0f 85 b5 00 00 00    	jne    2a45 <iref+0x101>
      printf(1, "chdir irefd failed\n");
      exit();
    }

    mkdir("");
    2990:	83 ec 0c             	sub    $0xc,%esp
    2993:	68 0f 3e 00 00       	push   $0x3e0f
    2998:	e8 92 0c 00 00       	call   362f <mkdir>
    link("README", "");
    299d:	59                   	pop    %ecx
    299e:	58                   	pop    %eax
    299f:	68 0f 3e 00 00       	push   $0x3e0f
    29a4:	68 06 47 00 00       	push   $0x4706
    29a9:	e8 79 0c 00 00       	call   3627 <link>
    fd = open("", O_CREATE);
    29ae:	58                   	pop    %eax
    29af:	5a                   	pop    %edx
    29b0:	68 00 02 00 00       	push   $0x200
    29b5:	68 0f 3e 00 00       	push   $0x3e0f
    29ba:	e8 48 0c 00 00       	call   3607 <open>
    if(fd >= 0)
    29bf:	83 c4 10             	add    $0x10,%esp
    29c2:	85 c0                	test   %eax,%eax
    29c4:	78 0c                	js     29d2 <iref+0x8e>
      close(fd);
    29c6:	83 ec 0c             	sub    $0xc,%esp
    29c9:	50                   	push   %eax
    29ca:	e8 20 0c 00 00       	call   35ef <close>
    29cf:	83 c4 10             	add    $0x10,%esp
    fd = open("xx", O_CREATE);
    29d2:	83 ec 08             	sub    $0x8,%esp
    29d5:	68 00 02 00 00       	push   $0x200
    29da:	68 44 43 00 00       	push   $0x4344
    29df:	e8 23 0c 00 00       	call   3607 <open>
    if(fd >= 0)
    29e4:	83 c4 10             	add    $0x10,%esp
    29e7:	85 c0                	test   %eax,%eax
    29e9:	78 0c                	js     29f7 <iref+0xb3>
      close(fd);
    29eb:	83 ec 0c             	sub    $0xc,%esp
    29ee:	50                   	push   %eax
    29ef:	e8 fb 0b 00 00       	call   35ef <close>
    29f4:	83 c4 10             	add    $0x10,%esp
    unlink("xx");
    29f7:	83 ec 0c             	sub    $0xc,%esp
    29fa:	68 44 43 00 00       	push   $0x4344
    29ff:	e8 13 0c 00 00       	call   3617 <unlink>
  int i, fd;

  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    2a04:	83 c4 10             	add    $0x10,%esp
    2a07:	4b                   	dec    %ebx
    2a08:	0f 85 52 ff ff ff    	jne    2960 <iref+0x1c>
    if(fd >= 0)
      close(fd);
    unlink("xx");
  }

  chdir("/");
    2a0e:	83 ec 0c             	sub    $0xc,%esp
    2a11:	68 35 3a 00 00       	push   $0x3a35
    2a16:	e8 1c 0c 00 00       	call   3637 <chdir>
  printf(1, "empty file name OK\n");
    2a1b:	58                   	pop    %eax
    2a1c:	5a                   	pop    %edx
    2a1d:	68 88 47 00 00       	push   $0x4788
    2a22:	6a 01                	push   $0x1
    2a24:	e8 c3 0c 00 00       	call   36ec <printf>
}
    2a29:	83 c4 10             	add    $0x10,%esp
    2a2c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2a2f:	c9                   	leave  
    2a30:	c3                   	ret    
  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    if(mkdir("irefd") != 0){
      printf(1, "mkdir irefd failed\n");
    2a31:	83 ec 08             	sub    $0x8,%esp
    2a34:	68 60 47 00 00       	push   $0x4760
    2a39:	6a 01                	push   $0x1
    2a3b:	e8 ac 0c 00 00       	call   36ec <printf>
      exit();
    2a40:	e8 82 0b 00 00       	call   35c7 <exit>
    }
    if(chdir("irefd") != 0){
      printf(1, "chdir irefd failed\n");
    2a45:	83 ec 08             	sub    $0x8,%esp
    2a48:	68 74 47 00 00       	push   $0x4774
    2a4d:	6a 01                	push   $0x1
    2a4f:	e8 98 0c 00 00       	call   36ec <printf>
      exit();
    2a54:	e8 6e 0b 00 00       	call   35c7 <exit>
    2a59:	8d 76 00             	lea    0x0(%esi),%esi

00002a5c <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    2a5c:	55                   	push   %ebp
    2a5d:	89 e5                	mov    %esp,%ebp
    2a5f:	53                   	push   %ebx
    2a60:	83 ec 0c             	sub    $0xc,%esp
  int n, pid;

  printf(1, "fork test\n");
    2a63:	68 9c 47 00 00       	push   $0x479c
    2a68:	6a 01                	push   $0x1
    2a6a:	e8 7d 0c 00 00       	call   36ec <printf>
    2a6f:	83 c4 10             	add    $0x10,%esp

  for(n=0; n<1000; n++){
    2a72:	31 db                	xor    %ebx,%ebx
    2a74:	eb 0d                	jmp    2a83 <forktest+0x27>
    2a76:	66 90                	xchg   %ax,%ax
    pid = fork();
    if(pid < 0)
      break;
    if(pid == 0)
    2a78:	74 52                	je     2acc <forktest+0x70>
{
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<1000; n++){
    2a7a:	43                   	inc    %ebx
    2a7b:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    2a81:	74 35                	je     2ab8 <forktest+0x5c>
    pid = fork();
    2a83:	e8 37 0b 00 00       	call   35bf <fork>
    if(pid < 0)
    2a88:	85 c0                	test   %eax,%eax
    2a8a:	79 ec                	jns    2a78 <forktest+0x1c>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit();
  }

  for(; n > 0; n--){
    2a8c:	85 db                	test   %ebx,%ebx
    2a8e:	74 0c                	je     2a9c <forktest+0x40>
    if(wait() < 0){
    2a90:	e8 3a 0b 00 00       	call   35cf <wait>
    2a95:	85 c0                	test   %eax,%eax
    2a97:	78 38                	js     2ad1 <forktest+0x75>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit();
  }

  for(; n > 0; n--){
    2a99:	4b                   	dec    %ebx
    2a9a:	75 f4                	jne    2a90 <forktest+0x34>
      printf(1, "wait stopped early\n");
      exit();
    }
  }

  if(wait() != -1){
    2a9c:	e8 2e 0b 00 00       	call   35cf <wait>
    2aa1:	40                   	inc    %eax
    2aa2:	75 41                	jne    2ae5 <forktest+0x89>
    printf(1, "wait got too many\n");
    exit();
  }

  printf(1, "fork test OK\n");
    2aa4:	83 ec 08             	sub    $0x8,%esp
    2aa7:	68 ce 47 00 00       	push   $0x47ce
    2aac:	6a 01                	push   $0x1
    2aae:	e8 39 0c 00 00       	call   36ec <printf>
}
    2ab3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2ab6:	c9                   	leave  
    2ab7:	c3                   	ret    
    if(pid == 0)
      exit();
  }

  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    2ab8:	83 ec 08             	sub    $0x8,%esp
    2abb:	68 3c 4f 00 00       	push   $0x4f3c
    2ac0:	6a 01                	push   $0x1
    2ac2:	e8 25 0c 00 00       	call   36ec <printf>
    exit();
    2ac7:	e8 fb 0a 00 00       	call   35c7 <exit>
  for(n=0; n<1000; n++){
    pid = fork();
    if(pid < 0)
      break;
    if(pid == 0)
      exit();
    2acc:	e8 f6 0a 00 00       	call   35c7 <exit>
    exit();
  }

  for(; n > 0; n--){
    if(wait() < 0){
      printf(1, "wait stopped early\n");
    2ad1:	83 ec 08             	sub    $0x8,%esp
    2ad4:	68 a7 47 00 00       	push   $0x47a7
    2ad9:	6a 01                	push   $0x1
    2adb:	e8 0c 0c 00 00       	call   36ec <printf>
      exit();
    2ae0:	e8 e2 0a 00 00       	call   35c7 <exit>
    }
  }

  if(wait() != -1){
    printf(1, "wait got too many\n");
    2ae5:	83 ec 08             	sub    $0x8,%esp
    2ae8:	68 bb 47 00 00       	push   $0x47bb
    2aed:	6a 01                	push   $0x1
    2aef:	e8 f8 0b 00 00       	call   36ec <printf>
    exit();
    2af4:	e8 ce 0a 00 00       	call   35c7 <exit>
    2af9:	8d 76 00             	lea    0x0(%esi),%esi

00002afc <sbrktest>:
  printf(1, "fork test OK\n");
}

void
sbrktest(void)
{
    2afc:	55                   	push   %ebp
    2afd:	89 e5                	mov    %esp,%ebp
    2aff:	57                   	push   %edi
    2b00:	56                   	push   %esi
    2b01:	53                   	push   %ebx
    2b02:	83 ec 64             	sub    $0x64,%esp
  int fds[2], pid, pids[10], ppid;
  char *a, *b, *c, *lastaddr, *oldbrk, *p, scratch;
  uint amt;

  printf(stdout, "sbrk test\n");
    2b05:	68 dc 47 00 00       	push   $0x47dc
    2b0a:	ff 35 80 5a 00 00    	pushl  0x5a80
    2b10:	e8 d7 0b 00 00       	call   36ec <printf>
  oldbrk = sbrk(0);
    2b15:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2b1c:	e8 2e 0b 00 00       	call   364f <sbrk>
    2b21:	89 45 a4             	mov    %eax,-0x5c(%ebp)

  // can one sbrk() less than a page?
  a = sbrk(0);
    2b24:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2b2b:	e8 1f 0b 00 00       	call   364f <sbrk>
    2b30:	89 c3                	mov    %eax,%ebx
    2b32:	83 c4 10             	add    $0x10,%esp
  int i;
  for(i = 0; i < 5000; i++){
    2b35:	31 ff                	xor    %edi,%edi
    2b37:	90                   	nop
    b = sbrk(1);
    2b38:	83 ec 0c             	sub    $0xc,%esp
    2b3b:	6a 01                	push   $0x1
    2b3d:	e8 0d 0b 00 00       	call   364f <sbrk>
    if(b != a){
    2b42:	83 c4 10             	add    $0x10,%esp
    2b45:	39 d8                	cmp    %ebx,%eax
    2b47:	0f 85 71 02 00 00    	jne    2dbe <sbrktest+0x2c2>
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
      exit();
    }
    *b = 1;
    2b4d:	c6 03 01             	movb   $0x1,(%ebx)
    a = b + 1;
    2b50:	43                   	inc    %ebx
  oldbrk = sbrk(0);

  // can one sbrk() less than a page?
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
    2b51:	47                   	inc    %edi
    2b52:	81 ff 88 13 00 00    	cmp    $0x1388,%edi
    2b58:	75 de                	jne    2b38 <sbrktest+0x3c>
      exit();
    }
    *b = 1;
    a = b + 1;
  }
  pid = fork();
    2b5a:	e8 60 0a 00 00       	call   35bf <fork>
    2b5f:	89 c7                	mov    %eax,%edi
  if(pid < 0){
    2b61:	85 c0                	test   %eax,%eax
    2b63:	0f 88 83 03 00 00    	js     2eec <sbrktest+0x3f0>
    printf(stdout, "sbrk test fork failed\n");
    exit();
  }
  c = sbrk(1);
    2b69:	83 ec 0c             	sub    $0xc,%esp
    2b6c:	6a 01                	push   $0x1
    2b6e:	e8 dc 0a 00 00       	call   364f <sbrk>
  c = sbrk(1);
    2b73:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2b7a:	e8 d0 0a 00 00       	call   364f <sbrk>
  if(c != a + 1){
    2b7f:	43                   	inc    %ebx
    2b80:	83 c4 10             	add    $0x10,%esp
    2b83:	39 d8                	cmp    %ebx,%eax
    2b85:	0f 85 49 03 00 00    	jne    2ed4 <sbrktest+0x3d8>
    printf(stdout, "sbrk test failed post-fork\n");
    exit();
  }
  if(pid == 0)
    2b8b:	85 ff                	test   %edi,%edi
    2b8d:	0f 84 3c 03 00 00    	je     2ecf <sbrktest+0x3d3>
    exit();
  wait();
    2b93:	e8 37 0a 00 00       	call   35cf <wait>

  // can one grow address space to something big?
#define BIG (100*1024*1024)
  a = sbrk(0);
    2b98:	83 ec 0c             	sub    $0xc,%esp
    2b9b:	6a 00                	push   $0x0
    2b9d:	e8 ad 0a 00 00       	call   364f <sbrk>
    2ba2:	89 c3                	mov    %eax,%ebx
  amt = (BIG) - (uint)a;
  p = sbrk(amt);
    2ba4:	b8 00 00 40 06       	mov    $0x6400000,%eax
    2ba9:	29 d8                	sub    %ebx,%eax
    2bab:	89 04 24             	mov    %eax,(%esp)
    2bae:	e8 9c 0a 00 00       	call   364f <sbrk>
  if (p != a) {
    2bb3:	83 c4 10             	add    $0x10,%esp
    2bb6:	39 c3                	cmp    %eax,%ebx
    2bb8:	0f 85 f9 02 00 00    	jne    2eb7 <sbrktest+0x3bb>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    exit();
  }
  lastaddr = (char*) (BIG-1);
  *lastaddr = 99;
    2bbe:	c6 05 ff ff 3f 06 63 	movb   $0x63,0x63fffff

  // can one de-allocate?
  a = sbrk(0);
    2bc5:	83 ec 0c             	sub    $0xc,%esp
    2bc8:	6a 00                	push   $0x0
    2bca:	e8 80 0a 00 00       	call   364f <sbrk>
    2bcf:	89 c3                	mov    %eax,%ebx
  c = sbrk(-4096);
    2bd1:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
    2bd8:	e8 72 0a 00 00       	call   364f <sbrk>
  if(c == (char*)0xffffffff){
    2bdd:	83 c4 10             	add    $0x10,%esp
    2be0:	40                   	inc    %eax
    2be1:	0f 84 b8 02 00 00    	je     2e9f <sbrktest+0x3a3>
    printf(stdout, "sbrk could not deallocate\n");
    exit();
  }
  c = sbrk(0);
    2be7:	83 ec 0c             	sub    $0xc,%esp
    2bea:	6a 00                	push   $0x0
    2bec:	e8 5e 0a 00 00       	call   364f <sbrk>
  if(c != a - 4096){
    2bf1:	8d 93 00 f0 ff ff    	lea    -0x1000(%ebx),%edx
    2bf7:	83 c4 10             	add    $0x10,%esp
    2bfa:	39 d0                	cmp    %edx,%eax
    2bfc:	0f 85 86 02 00 00    	jne    2e88 <sbrktest+0x38c>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    exit();
  }

  // can one re-allocate that page?
  a = sbrk(0);
    2c02:	83 ec 0c             	sub    $0xc,%esp
    2c05:	6a 00                	push   $0x0
    2c07:	e8 43 0a 00 00       	call   364f <sbrk>
    2c0c:	89 c3                	mov    %eax,%ebx
  c = sbrk(4096);
    2c0e:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    2c15:	e8 35 0a 00 00       	call   364f <sbrk>
    2c1a:	89 c7                	mov    %eax,%edi
  if(c != a || sbrk(0) != a + 4096){
    2c1c:	83 c4 10             	add    $0x10,%esp
    2c1f:	39 c3                	cmp    %eax,%ebx
    2c21:	0f 85 4a 02 00 00    	jne    2e71 <sbrktest+0x375>
    2c27:	83 ec 0c             	sub    $0xc,%esp
    2c2a:	6a 00                	push   $0x0
    2c2c:	e8 1e 0a 00 00       	call   364f <sbrk>
    2c31:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
    2c37:	83 c4 10             	add    $0x10,%esp
    2c3a:	39 d0                	cmp    %edx,%eax
    2c3c:	0f 85 2f 02 00 00    	jne    2e71 <sbrktest+0x375>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    exit();
  }
  if(*lastaddr == 99){
    2c42:	80 3d ff ff 3f 06 63 	cmpb   $0x63,0x63fffff
    2c49:	0f 84 0a 02 00 00    	je     2e59 <sbrktest+0x35d>
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    exit();
  }

  a = sbrk(0);
    2c4f:	83 ec 0c             	sub    $0xc,%esp
    2c52:	6a 00                	push   $0x0
    2c54:	e8 f6 09 00 00       	call   364f <sbrk>
    2c59:	89 c3                	mov    %eax,%ebx
  c = sbrk(-(sbrk(0) - oldbrk));
    2c5b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2c62:	e8 e8 09 00 00       	call   364f <sbrk>
    2c67:	8b 4d a4             	mov    -0x5c(%ebp),%ecx
    2c6a:	29 c1                	sub    %eax,%ecx
    2c6c:	89 0c 24             	mov    %ecx,(%esp)
    2c6f:	e8 db 09 00 00       	call   364f <sbrk>
  if(c != a){
    2c74:	83 c4 10             	add    $0x10,%esp
    2c77:	39 c3                	cmp    %eax,%ebx
    2c79:	0f 85 c3 01 00 00    	jne    2e42 <sbrktest+0x346>
    2c7f:	bb 00 00 00 80       	mov    $0x80000000,%ebx
    exit();
  }

  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    ppid = getpid();
    2c84:	e8 be 09 00 00       	call   3647 <getpid>
    2c89:	89 c7                	mov    %eax,%edi
    pid = fork();
    2c8b:	e8 2f 09 00 00       	call   35bf <fork>
    if(pid < 0){
    2c90:	85 c0                	test   %eax,%eax
    2c92:	0f 88 92 01 00 00    	js     2e2a <sbrktest+0x32e>
      printf(stdout, "fork failed\n");
      exit();
    }
    if(pid == 0){
    2c98:	0f 84 6a 01 00 00    	je     2e08 <sbrktest+0x30c>
      printf(stdout, "oops could read %x = %x\n", a, *a);
      kill(ppid);
      exit();
    }
    wait();
    2c9e:	e8 2c 09 00 00       	call   35cf <wait>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    exit();
  }

  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2ca3:	81 c3 50 c3 00 00    	add    $0xc350,%ebx
    2ca9:	81 fb 80 84 1e 80    	cmp    $0x801e8480,%ebx
    2caf:	75 d3                	jne    2c84 <sbrktest+0x188>
    wait();
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    2cb1:	83 ec 0c             	sub    $0xc,%esp
    2cb4:	8d 45 b8             	lea    -0x48(%ebp),%eax
    2cb7:	50                   	push   %eax
    2cb8:	e8 1a 09 00 00       	call   35d7 <pipe>
    2cbd:	83 c4 10             	add    $0x10,%esp
    2cc0:	85 c0                	test   %eax,%eax
    2cc2:	0f 85 2c 01 00 00    	jne    2df4 <sbrktest+0x2f8>
    2cc8:	8d 5d c0             	lea    -0x40(%ebp),%ebx
    2ccb:	8d 7d e8             	lea    -0x18(%ebp),%edi
    2cce:	89 de                	mov    %ebx,%esi
    printf(1, "pipe() failed\n");
    exit();
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if((pids[i] = fork()) == 0){
    2cd0:	e8 ea 08 00 00       	call   35bf <fork>
    2cd5:	89 06                	mov    %eax,(%esi)
    2cd7:	85 c0                	test   %eax,%eax
    2cd9:	0f 84 9d 00 00 00    	je     2d7c <sbrktest+0x280>
      sbrk(BIG - (uint)sbrk(0));
      write(fds[1], "x", 1);
      // sit around until killed
      for(;;) sleep(1000);
    }
    if(pids[i] != -1)
    2cdf:	40                   	inc    %eax
    2ce0:	74 12                	je     2cf4 <sbrktest+0x1f8>
      read(fds[0], &scratch, 1);
    2ce2:	50                   	push   %eax
    2ce3:	6a 01                	push   $0x1
    2ce5:	8d 45 b7             	lea    -0x49(%ebp),%eax
    2ce8:	50                   	push   %eax
    2ce9:	ff 75 b8             	pushl  -0x48(%ebp)
    2cec:	e8 ee 08 00 00       	call   35df <read>
    2cf1:	83 c4 10             	add    $0x10,%esp
    2cf4:	83 c6 04             	add    $0x4,%esi
  // failed allocation?
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit();
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    2cf7:	39 f7                	cmp    %esi,%edi
    2cf9:	75 d5                	jne    2cd0 <sbrktest+0x1d4>
    if(pids[i] != -1)
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
    2cfb:	83 ec 0c             	sub    $0xc,%esp
    2cfe:	68 00 10 00 00       	push   $0x1000
    2d03:	e8 47 09 00 00       	call   364f <sbrk>
    2d08:	89 c6                	mov    %eax,%esi
    2d0a:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if(pids[i] == -1)
    2d0d:	8b 03                	mov    (%ebx),%eax
    2d0f:	83 f8 ff             	cmp    $0xffffffff,%eax
    2d12:	74 11                	je     2d25 <sbrktest+0x229>
      continue;
    kill(pids[i]);
    2d14:	83 ec 0c             	sub    $0xc,%esp
    2d17:	50                   	push   %eax
    2d18:	e8 da 08 00 00       	call   35f7 <kill>
    wait();
    2d1d:	e8 ad 08 00 00       	call   35cf <wait>
    2d22:	83 c4 10             	add    $0x10,%esp
    2d25:	83 c3 04             	add    $0x4,%ebx
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    2d28:	39 fb                	cmp    %edi,%ebx
    2d2a:	75 e1                	jne    2d0d <sbrktest+0x211>
    if(pids[i] == -1)
      continue;
    kill(pids[i]);
    wait();
  }
  if(c == (char*)0xffffffff){
    2d2c:	89 f0                	mov    %esi,%eax
    2d2e:	40                   	inc    %eax
    2d2f:	0f 84 a7 00 00 00    	je     2ddc <sbrktest+0x2e0>
    printf(stdout, "failed sbrk leaked memory\n");
    exit();
  }

  if(sbrk(0) > oldbrk)
    2d35:	83 ec 0c             	sub    $0xc,%esp
    2d38:	6a 00                	push   $0x0
    2d3a:	e8 10 09 00 00       	call   364f <sbrk>
    2d3f:	83 c4 10             	add    $0x10,%esp
    2d42:	39 45 a4             	cmp    %eax,-0x5c(%ebp)
    2d45:	73 1a                	jae    2d61 <sbrktest+0x265>
    sbrk(-(sbrk(0) - oldbrk));
    2d47:	83 ec 0c             	sub    $0xc,%esp
    2d4a:	6a 00                	push   $0x0
    2d4c:	e8 fe 08 00 00       	call   364f <sbrk>
    2d51:	8b 75 a4             	mov    -0x5c(%ebp),%esi
    2d54:	29 c6                	sub    %eax,%esi
    2d56:	89 34 24             	mov    %esi,(%esp)
    2d59:	e8 f1 08 00 00       	call   364f <sbrk>
    2d5e:	83 c4 10             	add    $0x10,%esp

  printf(stdout, "sbrk test OK\n");
    2d61:	83 ec 08             	sub    $0x8,%esp
    2d64:	68 84 48 00 00       	push   $0x4884
    2d69:	ff 35 80 5a 00 00    	pushl  0x5a80
    2d6f:	e8 78 09 00 00       	call   36ec <printf>
}
    2d74:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2d77:	5b                   	pop    %ebx
    2d78:	5e                   	pop    %esi
    2d79:	5f                   	pop    %edi
    2d7a:	5d                   	pop    %ebp
    2d7b:	c3                   	ret    
    exit();
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if((pids[i] = fork()) == 0){
      // allocate a lot of memory
      sbrk(BIG - (uint)sbrk(0));
    2d7c:	83 ec 0c             	sub    $0xc,%esp
    2d7f:	6a 00                	push   $0x0
    2d81:	e8 c9 08 00 00       	call   364f <sbrk>
    2d86:	ba 00 00 40 06       	mov    $0x6400000,%edx
    2d8b:	29 c2                	sub    %eax,%edx
    2d8d:	89 14 24             	mov    %edx,(%esp)
    2d90:	e8 ba 08 00 00       	call   364f <sbrk>
      write(fds[1], "x", 1);
    2d95:	83 c4 0c             	add    $0xc,%esp
    2d98:	6a 01                	push   $0x1
    2d9a:	68 45 43 00 00       	push   $0x4345
    2d9f:	ff 75 bc             	pushl  -0x44(%ebp)
    2da2:	e8 40 08 00 00       	call   35e7 <write>
    2da7:	83 c4 10             	add    $0x10,%esp
    2daa:	66 90                	xchg   %ax,%ax
      // sit around until killed
      for(;;) sleep(1000);
    2dac:	83 ec 0c             	sub    $0xc,%esp
    2daf:	68 e8 03 00 00       	push   $0x3e8
    2db4:	e8 9e 08 00 00       	call   3657 <sleep>
    2db9:	83 c4 10             	add    $0x10,%esp
    2dbc:	eb ee                	jmp    2dac <sbrktest+0x2b0>
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
    b = sbrk(1);
    if(b != a){
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    2dbe:	83 ec 0c             	sub    $0xc,%esp
    2dc1:	50                   	push   %eax
    2dc2:	53                   	push   %ebx
    2dc3:	57                   	push   %edi
    2dc4:	68 e7 47 00 00       	push   $0x47e7
    2dc9:	ff 35 80 5a 00 00    	pushl  0x5a80
    2dcf:	e8 18 09 00 00       	call   36ec <printf>
      exit();
    2dd4:	83 c4 20             	add    $0x20,%esp
    2dd7:	e8 eb 07 00 00       	call   35c7 <exit>
      continue;
    kill(pids[i]);
    wait();
  }
  if(c == (char*)0xffffffff){
    printf(stdout, "failed sbrk leaked memory\n");
    2ddc:	83 ec 08             	sub    $0x8,%esp
    2ddf:	68 69 48 00 00       	push   $0x4869
    2de4:	ff 35 80 5a 00 00    	pushl  0x5a80
    2dea:	e8 fd 08 00 00       	call   36ec <printf>
    exit();
    2def:	e8 d3 07 00 00       	call   35c7 <exit>
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    2df4:	83 ec 08             	sub    $0x8,%esp
    2df7:	68 25 3d 00 00       	push   $0x3d25
    2dfc:	6a 01                	push   $0x1
    2dfe:	e8 e9 08 00 00       	call   36ec <printf>
    exit();
    2e03:	e8 bf 07 00 00       	call   35c7 <exit>
    if(pid < 0){
      printf(stdout, "fork failed\n");
      exit();
    }
    if(pid == 0){
      printf(stdout, "oops could read %x = %x\n", a, *a);
    2e08:	0f be 03             	movsbl (%ebx),%eax
    2e0b:	50                   	push   %eax
    2e0c:	53                   	push   %ebx
    2e0d:	68 50 48 00 00       	push   $0x4850
    2e12:	ff 35 80 5a 00 00    	pushl  0x5a80
    2e18:	e8 cf 08 00 00       	call   36ec <printf>
      kill(ppid);
    2e1d:	89 3c 24             	mov    %edi,(%esp)
    2e20:	e8 d2 07 00 00       	call   35f7 <kill>
      exit();
    2e25:	e8 9d 07 00 00       	call   35c7 <exit>
  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    ppid = getpid();
    pid = fork();
    if(pid < 0){
      printf(stdout, "fork failed\n");
    2e2a:	83 ec 08             	sub    $0x8,%esp
    2e2d:	68 2d 49 00 00       	push   $0x492d
    2e32:	ff 35 80 5a 00 00    	pushl  0x5a80
    2e38:	e8 af 08 00 00       	call   36ec <printf>
      exit();
    2e3d:	e8 85 07 00 00       	call   35c7 <exit>
  }

  a = sbrk(0);
  c = sbrk(-(sbrk(0) - oldbrk));
  if(c != a){
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    2e42:	50                   	push   %eax
    2e43:	53                   	push   %ebx
    2e44:	68 30 50 00 00       	push   $0x5030
    2e49:	ff 35 80 5a 00 00    	pushl  0x5a80
    2e4f:	e8 98 08 00 00       	call   36ec <printf>
    exit();
    2e54:	e8 6e 07 00 00       	call   35c7 <exit>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    exit();
  }
  if(*lastaddr == 99){
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    2e59:	83 ec 08             	sub    $0x8,%esp
    2e5c:	68 00 50 00 00       	push   $0x5000
    2e61:	ff 35 80 5a 00 00    	pushl  0x5a80
    2e67:	e8 80 08 00 00       	call   36ec <printf>
    exit();
    2e6c:	e8 56 07 00 00       	call   35c7 <exit>

  // can one re-allocate that page?
  a = sbrk(0);
  c = sbrk(4096);
  if(c != a || sbrk(0) != a + 4096){
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    2e71:	57                   	push   %edi
    2e72:	53                   	push   %ebx
    2e73:	68 d8 4f 00 00       	push   $0x4fd8
    2e78:	ff 35 80 5a 00 00    	pushl  0x5a80
    2e7e:	e8 69 08 00 00       	call   36ec <printf>
    exit();
    2e83:	e8 3f 07 00 00       	call   35c7 <exit>
    printf(stdout, "sbrk could not deallocate\n");
    exit();
  }
  c = sbrk(0);
  if(c != a - 4096){
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    2e88:	50                   	push   %eax
    2e89:	53                   	push   %ebx
    2e8a:	68 a0 4f 00 00       	push   $0x4fa0
    2e8f:	ff 35 80 5a 00 00    	pushl  0x5a80
    2e95:	e8 52 08 00 00       	call   36ec <printf>
    exit();
    2e9a:	e8 28 07 00 00       	call   35c7 <exit>

  // can one de-allocate?
  a = sbrk(0);
  c = sbrk(-4096);
  if(c == (char*)0xffffffff){
    printf(stdout, "sbrk could not deallocate\n");
    2e9f:	83 ec 08             	sub    $0x8,%esp
    2ea2:	68 35 48 00 00       	push   $0x4835
    2ea7:	ff 35 80 5a 00 00    	pushl  0x5a80
    2ead:	e8 3a 08 00 00       	call   36ec <printf>
    exit();
    2eb2:	e8 10 07 00 00       	call   35c7 <exit>
#define BIG (100*1024*1024)
  a = sbrk(0);
  amt = (BIG) - (uint)a;
  p = sbrk(amt);
  if (p != a) {
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    2eb7:	83 ec 08             	sub    $0x8,%esp
    2eba:	68 60 4f 00 00       	push   $0x4f60
    2ebf:	ff 35 80 5a 00 00    	pushl  0x5a80
    2ec5:	e8 22 08 00 00       	call   36ec <printf>
    exit();
    2eca:	e8 f8 06 00 00       	call   35c7 <exit>
  if(c != a + 1){
    printf(stdout, "sbrk test failed post-fork\n");
    exit();
  }
  if(pid == 0)
    exit();
    2ecf:	e8 f3 06 00 00       	call   35c7 <exit>
    exit();
  }
  c = sbrk(1);
  c = sbrk(1);
  if(c != a + 1){
    printf(stdout, "sbrk test failed post-fork\n");
    2ed4:	83 ec 08             	sub    $0x8,%esp
    2ed7:	68 19 48 00 00       	push   $0x4819
    2edc:	ff 35 80 5a 00 00    	pushl  0x5a80
    2ee2:	e8 05 08 00 00       	call   36ec <printf>
    exit();
    2ee7:	e8 db 06 00 00       	call   35c7 <exit>
    *b = 1;
    a = b + 1;
  }
  pid = fork();
  if(pid < 0){
    printf(stdout, "sbrk test fork failed\n");
    2eec:	83 ec 08             	sub    $0x8,%esp
    2eef:	68 02 48 00 00       	push   $0x4802
    2ef4:	ff 35 80 5a 00 00    	pushl  0x5a80
    2efa:	e8 ed 07 00 00       	call   36ec <printf>
    exit();
    2eff:	e8 c3 06 00 00       	call   35c7 <exit>

00002f04 <validateint>:
  printf(stdout, "sbrk test OK\n");
}

void
validateint(int *p)
{
    2f04:	55                   	push   %ebp
    2f05:	89 e5                	mov    %esp,%ebp
      "int %2\n\t"
      "mov %%ebx, %%esp" :
      "=a" (res) :
      "a" (SYS_sleep), "n" (T_SYSCALL), "c" (p) :
      "ebx");
}
    2f07:	5d                   	pop    %ebp
    2f08:	c3                   	ret    
    2f09:	8d 76 00             	lea    0x0(%esi),%esi

00002f0c <validatetest>:

void
validatetest(void)
{
    2f0c:	55                   	push   %ebp
    2f0d:	89 e5                	mov    %esp,%ebp
    2f0f:	56                   	push   %esi
    2f10:	53                   	push   %ebx
  int hi, pid;
  uint p;

  printf(stdout, "validate test\n");
    2f11:	83 ec 08             	sub    $0x8,%esp
    2f14:	68 92 48 00 00       	push   $0x4892
    2f19:	ff 35 80 5a 00 00    	pushl  0x5a80
    2f1f:	e8 c8 07 00 00       	call   36ec <printf>
    2f24:	83 c4 10             	add    $0x10,%esp
  hi = 1100*1024;

  for(p = 0; p <= (uint)hi; p += 4096){
    2f27:	31 db                	xor    %ebx,%ebx
    2f29:	8d 76 00             	lea    0x0(%esi),%esi
    if((pid = fork()) == 0){
    2f2c:	e8 8e 06 00 00       	call   35bf <fork>
    2f31:	89 c6                	mov    %eax,%esi
    2f33:	85 c0                	test   %eax,%eax
    2f35:	74 61                	je     2f98 <validatetest+0x8c>
      // try to crash the kernel by passing in a badly placed integer
      validateint((int*)p);
      exit();
    }
    sleep(0);
    2f37:	83 ec 0c             	sub    $0xc,%esp
    2f3a:	6a 00                	push   $0x0
    2f3c:	e8 16 07 00 00       	call   3657 <sleep>
    sleep(0);
    2f41:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2f48:	e8 0a 07 00 00       	call   3657 <sleep>
    kill(pid);
    2f4d:	89 34 24             	mov    %esi,(%esp)
    2f50:	e8 a2 06 00 00       	call   35f7 <kill>
    wait();
    2f55:	e8 75 06 00 00       	call   35cf <wait>

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
    2f5a:	58                   	pop    %eax
    2f5b:	5a                   	pop    %edx
    2f5c:	53                   	push   %ebx
    2f5d:	68 a1 48 00 00       	push   $0x48a1
    2f62:	e8 c0 06 00 00       	call   3627 <link>
    2f67:	83 c4 10             	add    $0x10,%esp
    2f6a:	40                   	inc    %eax
    2f6b:	75 30                	jne    2f9d <validatetest+0x91>
  uint p;

  printf(stdout, "validate test\n");
  hi = 1100*1024;

  for(p = 0; p <= (uint)hi; p += 4096){
    2f6d:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    2f73:	81 fb 00 40 11 00    	cmp    $0x114000,%ebx
    2f79:	75 b1                	jne    2f2c <validatetest+0x20>
      printf(stdout, "link should not succeed\n");
      exit();
    }
  }

  printf(stdout, "validate ok\n");
    2f7b:	83 ec 08             	sub    $0x8,%esp
    2f7e:	68 c5 48 00 00       	push   $0x48c5
    2f83:	ff 35 80 5a 00 00    	pushl  0x5a80
    2f89:	e8 5e 07 00 00       	call   36ec <printf>
}
    2f8e:	83 c4 10             	add    $0x10,%esp
    2f91:	8d 65 f8             	lea    -0x8(%ebp),%esp
    2f94:	5b                   	pop    %ebx
    2f95:	5e                   	pop    %esi
    2f96:	5d                   	pop    %ebp
    2f97:	c3                   	ret    

  for(p = 0; p <= (uint)hi; p += 4096){
    if((pid = fork()) == 0){
      // try to crash the kernel by passing in a badly placed integer
      validateint((int*)p);
      exit();
    2f98:	e8 2a 06 00 00       	call   35c7 <exit>
    kill(pid);
    wait();

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
      printf(stdout, "link should not succeed\n");
    2f9d:	83 ec 08             	sub    $0x8,%esp
    2fa0:	68 ac 48 00 00       	push   $0x48ac
    2fa5:	ff 35 80 5a 00 00    	pushl  0x5a80
    2fab:	e8 3c 07 00 00       	call   36ec <printf>
      exit();
    2fb0:	e8 12 06 00 00       	call   35c7 <exit>
    2fb5:	8d 76 00             	lea    0x0(%esi),%esi

00002fb8 <bsstest>:

// does unintialized data start out zero?
char uninit[10000];
void
bsstest(void)
{
    2fb8:	55                   	push   %ebp
    2fb9:	89 e5                	mov    %esp,%ebp
    2fbb:	83 ec 10             	sub    $0x10,%esp
  int i;

  printf(stdout, "bss test\n");
    2fbe:	68 d2 48 00 00       	push   $0x48d2
    2fc3:	ff 35 80 5a 00 00    	pushl  0x5a80
    2fc9:	e8 1e 07 00 00       	call   36ec <printf>
  for(i = 0; i < sizeof(uninit); i++){
    if(uninit[i] != '\0'){
    2fce:	83 c4 10             	add    $0x10,%esp
    2fd1:	80 3d 40 5b 00 00 00 	cmpb   $0x0,0x5b40
    2fd8:	75 2b                	jne    3005 <bsstest+0x4d>
    2fda:	b8 41 5b 00 00       	mov    $0x5b41,%eax
    2fdf:	90                   	nop
    2fe0:	80 38 00             	cmpb   $0x0,(%eax)
    2fe3:	75 20                	jne    3005 <bsstest+0x4d>
    2fe5:	40                   	inc    %eax
bsstest(void)
{
  int i;

  printf(stdout, "bss test\n");
  for(i = 0; i < sizeof(uninit); i++){
    2fe6:	3d 50 82 00 00       	cmp    $0x8250,%eax
    2feb:	75 f3                	jne    2fe0 <bsstest+0x28>
    if(uninit[i] != '\0'){
      printf(stdout, "bss test failed\n");
      exit();
    }
  }
  printf(stdout, "bss test ok\n");
    2fed:	83 ec 08             	sub    $0x8,%esp
    2ff0:	68 ed 48 00 00       	push   $0x48ed
    2ff5:	ff 35 80 5a 00 00    	pushl  0x5a80
    2ffb:	e8 ec 06 00 00       	call   36ec <printf>
}
    3000:	83 c4 10             	add    $0x10,%esp
    3003:	c9                   	leave  
    3004:	c3                   	ret    
  int i;

  printf(stdout, "bss test\n");
  for(i = 0; i < sizeof(uninit); i++){
    if(uninit[i] != '\0'){
      printf(stdout, "bss test failed\n");
    3005:	83 ec 08             	sub    $0x8,%esp
    3008:	68 dc 48 00 00       	push   $0x48dc
    300d:	ff 35 80 5a 00 00    	pushl  0x5a80
    3013:	e8 d4 06 00 00       	call   36ec <printf>
      exit();
    3018:	e8 aa 05 00 00       	call   35c7 <exit>
    301d:	8d 76 00             	lea    0x0(%esi),%esi

00003020 <bigargtest>:
// does exec return an error if the arguments
// are larger than a page? or does it write
// below the stack and wreck the instructions/data?
void
bigargtest(void)
{
    3020:	55                   	push   %ebp
    3021:	89 e5                	mov    %esp,%ebp
    3023:	83 ec 14             	sub    $0x14,%esp
  int pid, fd;

  unlink("bigarg-ok");
    3026:	68 fa 48 00 00       	push   $0x48fa
    302b:	e8 e7 05 00 00       	call   3617 <unlink>
  pid = fork();
    3030:	e8 8a 05 00 00       	call   35bf <fork>
  if(pid == 0){
    3035:	83 c4 10             	add    $0x10,%esp
    3038:	85 c0                	test   %eax,%eax
    303a:	74 3f                	je     307b <bigargtest+0x5b>
    exec("echo", args);
    printf(stdout, "bigarg test ok\n");
    fd = open("bigarg-ok", O_CREATE);
    close(fd);
    exit();
  } else if(pid < 0){
    303c:	0f 88 c2 00 00 00    	js     3104 <bigargtest+0xe4>
    printf(stdout, "bigargtest: fork failed\n");
    exit();
  }
  wait();
    3042:	e8 88 05 00 00       	call   35cf <wait>
  fd = open("bigarg-ok", 0);
    3047:	83 ec 08             	sub    $0x8,%esp
    304a:	6a 00                	push   $0x0
    304c:	68 fa 48 00 00       	push   $0x48fa
    3051:	e8 b1 05 00 00       	call   3607 <open>
  if(fd < 0){
    3056:	83 c4 10             	add    $0x10,%esp
    3059:	85 c0                	test   %eax,%eax
    305b:	0f 88 8c 00 00 00    	js     30ed <bigargtest+0xcd>
    printf(stdout, "bigarg test failed!\n");
    exit();
  }
  close(fd);
    3061:	83 ec 0c             	sub    $0xc,%esp
    3064:	50                   	push   %eax
    3065:	e8 85 05 00 00       	call   35ef <close>
  unlink("bigarg-ok");
    306a:	c7 04 24 fa 48 00 00 	movl   $0x48fa,(%esp)
    3071:	e8 a1 05 00 00       	call   3617 <unlink>
}
    3076:	83 c4 10             	add    $0x10,%esp
    3079:	c9                   	leave  
    307a:	c3                   	ret    
    307b:	b8 a0 5a 00 00       	mov    $0x5aa0,%eax
  pid = fork();
  if(pid == 0){
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    3080:	c7 00 54 50 00 00    	movl   $0x5054,(%eax)
    3086:	83 c0 04             	add    $0x4,%eax
  unlink("bigarg-ok");
  pid = fork();
  if(pid == 0){
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
    3089:	3d 1c 5b 00 00       	cmp    $0x5b1c,%eax
    308e:	75 f0                	jne    3080 <bigargtest+0x60>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    args[MAXARG-1] = 0;
    3090:	c7 05 1c 5b 00 00 00 	movl   $0x0,0x5b1c
    3097:	00 00 00 
    printf(stdout, "bigarg test\n");
    309a:	51                   	push   %ecx
    309b:	51                   	push   %ecx
    309c:	68 04 49 00 00       	push   $0x4904
    30a1:	ff 35 80 5a 00 00    	pushl  0x5a80
    30a7:	e8 40 06 00 00       	call   36ec <printf>
    exec("echo", args);
    30ac:	58                   	pop    %eax
    30ad:	5a                   	pop    %edx
    30ae:	68 a0 5a 00 00       	push   $0x5aa0
    30b3:	68 d1 3a 00 00       	push   $0x3ad1
    30b8:	e8 42 05 00 00       	call   35ff <exec>
    printf(stdout, "bigarg test ok\n");
    30bd:	59                   	pop    %ecx
    30be:	58                   	pop    %eax
    30bf:	68 11 49 00 00       	push   $0x4911
    30c4:	ff 35 80 5a 00 00    	pushl  0x5a80
    30ca:	e8 1d 06 00 00       	call   36ec <printf>
    fd = open("bigarg-ok", O_CREATE);
    30cf:	58                   	pop    %eax
    30d0:	5a                   	pop    %edx
    30d1:	68 00 02 00 00       	push   $0x200
    30d6:	68 fa 48 00 00       	push   $0x48fa
    30db:	e8 27 05 00 00       	call   3607 <open>
    close(fd);
    30e0:	89 04 24             	mov    %eax,(%esp)
    30e3:	e8 07 05 00 00       	call   35ef <close>
    exit();
    30e8:	e8 da 04 00 00       	call   35c7 <exit>
    exit();
  }
  wait();
  fd = open("bigarg-ok", 0);
  if(fd < 0){
    printf(stdout, "bigarg test failed!\n");
    30ed:	50                   	push   %eax
    30ee:	50                   	push   %eax
    30ef:	68 3a 49 00 00       	push   $0x493a
    30f4:	ff 35 80 5a 00 00    	pushl  0x5a80
    30fa:	e8 ed 05 00 00       	call   36ec <printf>
    exit();
    30ff:	e8 c3 04 00 00       	call   35c7 <exit>
    printf(stdout, "bigarg test ok\n");
    fd = open("bigarg-ok", O_CREATE);
    close(fd);
    exit();
  } else if(pid < 0){
    printf(stdout, "bigargtest: fork failed\n");
    3104:	52                   	push   %edx
    3105:	52                   	push   %edx
    3106:	68 21 49 00 00       	push   $0x4921
    310b:	ff 35 80 5a 00 00    	pushl  0x5a80
    3111:	e8 d6 05 00 00       	call   36ec <printf>
    exit();
    3116:	e8 ac 04 00 00       	call   35c7 <exit>
    311b:	90                   	nop

0000311c <fsfull>:

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    311c:	55                   	push   %ebp
    311d:	89 e5                	mov    %esp,%ebp
    311f:	57                   	push   %edi
    3120:	56                   	push   %esi
    3121:	53                   	push   %ebx
    3122:	83 ec 54             	sub    $0x54,%esp
  int nfiles;
  int fsblocks = 0;

  printf(1, "fsfull test\n");
    3125:	68 4f 49 00 00       	push   $0x494f
    312a:	6a 01                	push   $0x1
    312c:	e8 bb 05 00 00       	call   36ec <printf>
    3131:	83 c4 10             	add    $0x10,%esp

  for(nfiles = 0; ; nfiles++){
    3134:	31 f6                	xor    %esi,%esi
    3136:	66 90                	xchg   %ax,%ax
    char name[64];
    name[0] = 'f';
    3138:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    313c:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    3141:	f7 ee                	imul   %esi
    3143:	89 d0                	mov    %edx,%eax
    3145:	c1 f8 06             	sar    $0x6,%eax
    3148:	89 f3                	mov    %esi,%ebx
    314a:	c1 fb 1f             	sar    $0x1f,%ebx
    314d:	29 d8                	sub    %ebx,%eax
    314f:	8d 50 30             	lea    0x30(%eax),%edx
    3152:	88 55 a9             	mov    %dl,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    3155:	8d 04 80             	lea    (%eax,%eax,4),%eax
    3158:	8d 04 80             	lea    (%eax,%eax,4),%eax
    315b:	8d 04 80             	lea    (%eax,%eax,4),%eax
    315e:	c1 e0 03             	shl    $0x3,%eax
    3161:	89 f1                	mov    %esi,%ecx
    3163:	29 c1                	sub    %eax,%ecx
    3165:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    316a:	f7 e9                	imul   %ecx
    316c:	89 d0                	mov    %edx,%eax
    316e:	c1 f8 05             	sar    $0x5,%eax
    3171:	c1 f9 1f             	sar    $0x1f,%ecx
    3174:	29 c8                	sub    %ecx,%eax
    3176:	83 c0 30             	add    $0x30,%eax
    3179:	88 45 aa             	mov    %al,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    317c:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    3181:	f7 ee                	imul   %esi
    3183:	89 d0                	mov    %edx,%eax
    3185:	c1 f8 05             	sar    $0x5,%eax
    3188:	29 d8                	sub    %ebx,%eax
    318a:	8d 04 80             	lea    (%eax,%eax,4),%eax
    318d:	8d 04 80             	lea    (%eax,%eax,4),%eax
    3190:	c1 e0 02             	shl    $0x2,%eax
    3193:	89 f7                	mov    %esi,%edi
    3195:	29 c7                	sub    %eax,%edi
    3197:	b9 67 66 66 66       	mov    $0x66666667,%ecx
    319c:	89 f8                	mov    %edi,%eax
    319e:	f7 e9                	imul   %ecx
    31a0:	c1 fa 02             	sar    $0x2,%edx
    31a3:	c1 ff 1f             	sar    $0x1f,%edi
    31a6:	29 fa                	sub    %edi,%edx
    31a8:	83 c2 30             	add    $0x30,%edx
    31ab:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    31ae:	89 c8                	mov    %ecx,%eax
    31b0:	f7 ee                	imul   %esi
    31b2:	89 d0                	mov    %edx,%eax
    31b4:	c1 f8 02             	sar    $0x2,%eax
    31b7:	29 d8                	sub    %ebx,%eax
    31b9:	8d 04 80             	lea    (%eax,%eax,4),%eax
    31bc:	01 c0                	add    %eax,%eax
    31be:	89 f1                	mov    %esi,%ecx
    31c0:	29 c1                	sub    %eax,%ecx
    31c2:	89 c8                	mov    %ecx,%eax
    31c4:	83 c0 30             	add    $0x30,%eax
    31c7:	88 45 ac             	mov    %al,-0x54(%ebp)
    name[5] = '\0';
    31ca:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    printf(1, "writing %s\n", name);
    31ce:	53                   	push   %ebx
    31cf:	8d 45 a8             	lea    -0x58(%ebp),%eax
    31d2:	50                   	push   %eax
    31d3:	68 5c 49 00 00       	push   $0x495c
    31d8:	6a 01                	push   $0x1
    31da:	e8 0d 05 00 00       	call   36ec <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    31df:	5f                   	pop    %edi
    31e0:	58                   	pop    %eax
    31e1:	68 02 02 00 00       	push   $0x202
    31e6:	8d 45 a8             	lea    -0x58(%ebp),%eax
    31e9:	50                   	push   %eax
    31ea:	e8 18 04 00 00       	call   3607 <open>
    31ef:	89 c7                	mov    %eax,%edi
    if(fd < 0){
    31f1:	83 c4 10             	add    $0x10,%esp
    31f4:	85 c0                	test   %eax,%eax
    31f6:	78 44                	js     323c <fsfull+0x120>
    31f8:	31 db                	xor    %ebx,%ebx
    31fa:	eb 02                	jmp    31fe <fsfull+0xe2>
    int total = 0;
    while(1){
      int cc = write(fd, buf, 512);
      if(cc < 512)
        break;
      total += cc;
    31fc:	01 c3                	add    %eax,%ebx
      printf(1, "open %s failed\n", name);
      break;
    }
    int total = 0;
    while(1){
      int cc = write(fd, buf, 512);
    31fe:	52                   	push   %edx
    31ff:	68 00 02 00 00       	push   $0x200
    3204:	68 60 82 00 00       	push   $0x8260
    3209:	57                   	push   %edi
    320a:	e8 d8 03 00 00       	call   35e7 <write>
      if(cc < 512)
    320f:	83 c4 10             	add    $0x10,%esp
    3212:	3d ff 01 00 00       	cmp    $0x1ff,%eax
    3217:	7f e3                	jg     31fc <fsfull+0xe0>
        break;
      total += cc;
      fsblocks++;
    }
    printf(1, "wrote %d bytes\n", total);
    3219:	50                   	push   %eax
    321a:	53                   	push   %ebx
    321b:	68 78 49 00 00       	push   $0x4978
    3220:	6a 01                	push   $0x1
    3222:	e8 c5 04 00 00       	call   36ec <printf>
    close(fd);
    3227:	89 3c 24             	mov    %edi,(%esp)
    322a:	e8 c0 03 00 00       	call   35ef <close>
    if(total == 0)
    322f:	83 c4 10             	add    $0x10,%esp
    3232:	85 db                	test   %ebx,%ebx
    3234:	74 1a                	je     3250 <fsfull+0x134>
  int nfiles;
  int fsblocks = 0;

  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    3236:	46                   	inc    %esi
    }
    printf(1, "wrote %d bytes\n", total);
    close(fd);
    if(total == 0)
      break;
  }
    3237:	e9 fc fe ff ff       	jmp    3138 <fsfull+0x1c>
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    printf(1, "writing %s\n", name);
    int fd = open(name, O_CREATE|O_RDWR);
    if(fd < 0){
      printf(1, "open %s failed\n", name);
    323c:	51                   	push   %ecx
    323d:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3240:	50                   	push   %eax
    3241:	68 68 49 00 00       	push   $0x4968
    3246:	6a 01                	push   $0x1
    3248:	e8 9f 04 00 00       	call   36ec <printf>
      break;
    324d:	83 c4 10             	add    $0x10,%esp
      break;
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    3250:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    3254:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    3259:	f7 ee                	imul   %esi
    325b:	89 d0                	mov    %edx,%eax
    325d:	c1 f8 06             	sar    $0x6,%eax
    3260:	89 f3                	mov    %esi,%ebx
    3262:	c1 fb 1f             	sar    $0x1f,%ebx
    3265:	29 d8                	sub    %ebx,%eax
    3267:	8d 50 30             	lea    0x30(%eax),%edx
    326a:	88 55 a9             	mov    %dl,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    326d:	8d 04 80             	lea    (%eax,%eax,4),%eax
    3270:	8d 04 80             	lea    (%eax,%eax,4),%eax
    3273:	8d 04 80             	lea    (%eax,%eax,4),%eax
    3276:	c1 e0 03             	shl    $0x3,%eax
    3279:	89 f1                	mov    %esi,%ecx
    327b:	29 c1                	sub    %eax,%ecx
    327d:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    3282:	f7 e9                	imul   %ecx
    3284:	89 d0                	mov    %edx,%eax
    3286:	c1 f8 05             	sar    $0x5,%eax
    3289:	c1 f9 1f             	sar    $0x1f,%ecx
    328c:	29 c8                	sub    %ecx,%eax
    328e:	83 c0 30             	add    $0x30,%eax
    3291:	88 45 aa             	mov    %al,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    3294:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    3299:	f7 ee                	imul   %esi
    329b:	89 d0                	mov    %edx,%eax
    329d:	c1 f8 05             	sar    $0x5,%eax
    32a0:	29 d8                	sub    %ebx,%eax
    32a2:	8d 04 80             	lea    (%eax,%eax,4),%eax
    32a5:	8d 04 80             	lea    (%eax,%eax,4),%eax
    32a8:	c1 e0 02             	shl    $0x2,%eax
    32ab:	89 f7                	mov    %esi,%edi
    32ad:	29 c7                	sub    %eax,%edi
    32af:	b9 67 66 66 66       	mov    $0x66666667,%ecx
    32b4:	89 f8                	mov    %edi,%eax
    32b6:	f7 e9                	imul   %ecx
    32b8:	c1 fa 02             	sar    $0x2,%edx
    32bb:	c1 ff 1f             	sar    $0x1f,%edi
    32be:	29 fa                	sub    %edi,%edx
    32c0:	83 c2 30             	add    $0x30,%edx
    32c3:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    32c6:	89 c8                	mov    %ecx,%eax
    32c8:	f7 ee                	imul   %esi
    32ca:	89 d0                	mov    %edx,%eax
    32cc:	c1 f8 02             	sar    $0x2,%eax
    32cf:	29 d8                	sub    %ebx,%eax
    32d1:	8d 04 80             	lea    (%eax,%eax,4),%eax
    32d4:	01 c0                	add    %eax,%eax
    32d6:	89 f1                	mov    %esi,%ecx
    32d8:	29 c1                	sub    %eax,%ecx
    32da:	89 c8                	mov    %ecx,%eax
    32dc:	83 c0 30             	add    $0x30,%eax
    32df:	88 45 ac             	mov    %al,-0x54(%ebp)
    name[5] = '\0';
    32e2:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    unlink(name);
    32e6:	83 ec 0c             	sub    $0xc,%esp
    32e9:	8d 45 a8             	lea    -0x58(%ebp),%eax
    32ec:	50                   	push   %eax
    32ed:	e8 25 03 00 00       	call   3617 <unlink>
    nfiles--;
    32f2:	4e                   	dec    %esi
    close(fd);
    if(total == 0)
      break;
  }

  while(nfiles >= 0){
    32f3:	83 c4 10             	add    $0x10,%esp
    32f6:	83 fe ff             	cmp    $0xffffffff,%esi
    32f9:	0f 85 51 ff ff ff    	jne    3250 <fsfull+0x134>
    name[5] = '\0';
    unlink(name);
    nfiles--;
  }

  printf(1, "fsfull test finished\n");
    32ff:	83 ec 08             	sub    $0x8,%esp
    3302:	68 88 49 00 00       	push   $0x4988
    3307:	6a 01                	push   $0x1
    3309:	e8 de 03 00 00       	call   36ec <printf>
}
    330e:	83 c4 10             	add    $0x10,%esp
    3311:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3314:	5b                   	pop    %ebx
    3315:	5e                   	pop    %esi
    3316:	5f                   	pop    %edi
    3317:	5d                   	pop    %ebp
    3318:	c3                   	ret    
    3319:	8d 76 00             	lea    0x0(%esi),%esi

0000331c <uio>:

void
uio()
{
    331c:	55                   	push   %ebp
    331d:	89 e5                	mov    %esp,%ebp
    331f:	83 ec 10             	sub    $0x10,%esp

  ushort port = 0;
  uchar val = 0;
  int pid;

  printf(1, "uio test\n");
    3322:	68 9e 49 00 00       	push   $0x499e
    3327:	6a 01                	push   $0x1
    3329:	e8 be 03 00 00       	call   36ec <printf>
  pid = fork();
    332e:	e8 8c 02 00 00       	call   35bf <fork>
  if(pid == 0){
    3333:	83 c4 10             	add    $0x10,%esp
    3336:	85 c0                	test   %eax,%eax
    3338:	74 1b                	je     3355 <uio+0x39>
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    port = RTC_DATA;
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    printf(1, "uio: uio succeeded; test FAILED\n");
    exit();
  } else if(pid < 0){
    333a:	78 3a                	js     3376 <uio+0x5a>
    printf (1, "fork failed\n");
    exit();
  }
  wait();
    333c:	e8 8e 02 00 00       	call   35cf <wait>
  printf(1, "uio test done\n");
    3341:	83 ec 08             	sub    $0x8,%esp
    3344:	68 a8 49 00 00       	push   $0x49a8
    3349:	6a 01                	push   $0x1
    334b:	e8 9c 03 00 00       	call   36ec <printf>
}
    3350:	83 c4 10             	add    $0x10,%esp
    3353:	c9                   	leave  
    3354:	c3                   	ret    
  pid = fork();
  if(pid == 0){
    port = RTC_ADDR;
    val = 0x09;  /* year */
    /* http://wiki.osdev.org/Inline_Assembly/Examples */
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    3355:	ba 70 00 00 00       	mov    $0x70,%edx
    335a:	b0 09                	mov    $0x9,%al
    335c:	ee                   	out    %al,(%dx)
    port = RTC_DATA;
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    335d:	ba 71 00 00 00       	mov    $0x71,%edx
    3362:	ec                   	in     (%dx),%al
    printf(1, "uio: uio succeeded; test FAILED\n");
    3363:	52                   	push   %edx
    3364:	52                   	push   %edx
    3365:	68 34 51 00 00       	push   $0x5134
    336a:	6a 01                	push   $0x1
    336c:	e8 7b 03 00 00       	call   36ec <printf>
    exit();
    3371:	e8 51 02 00 00       	call   35c7 <exit>
  } else if(pid < 0){
    printf (1, "fork failed\n");
    3376:	50                   	push   %eax
    3377:	50                   	push   %eax
    3378:	68 2d 49 00 00       	push   $0x492d
    337d:	6a 01                	push   $0x1
    337f:	e8 68 03 00 00       	call   36ec <printf>
    exit();
    3384:	e8 3e 02 00 00       	call   35c7 <exit>
    3389:	8d 76 00             	lea    0x0(%esi),%esi

0000338c <argptest>:
  wait();
  printf(1, "uio test done\n");
}

void argptest()
{
    338c:	55                   	push   %ebp
    338d:	89 e5                	mov    %esp,%ebp
    338f:	53                   	push   %ebx
    3390:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  fd = open("init", O_RDONLY);
    3393:	6a 00                	push   $0x0
    3395:	68 b7 49 00 00       	push   $0x49b7
    339a:	e8 68 02 00 00       	call   3607 <open>
  if (fd < 0) {
    339f:	83 c4 10             	add    $0x10,%esp
    33a2:	85 c0                	test   %eax,%eax
    33a4:	78 37                	js     33dd <argptest+0x51>
    33a6:	89 c3                	mov    %eax,%ebx
    printf(2, "open failed\n");
    exit();
  }
  read(fd, sbrk(0) - 1, -1);
    33a8:	83 ec 0c             	sub    $0xc,%esp
    33ab:	6a 00                	push   $0x0
    33ad:	e8 9d 02 00 00       	call   364f <sbrk>
    33b2:	83 c4 0c             	add    $0xc,%esp
    33b5:	6a ff                	push   $0xffffffff
    33b7:	48                   	dec    %eax
    33b8:	50                   	push   %eax
    33b9:	53                   	push   %ebx
    33ba:	e8 20 02 00 00       	call   35df <read>
  close(fd);
    33bf:	89 1c 24             	mov    %ebx,(%esp)
    33c2:	e8 28 02 00 00       	call   35ef <close>
  printf(1, "arg test passed\n");
    33c7:	58                   	pop    %eax
    33c8:	5a                   	pop    %edx
    33c9:	68 c9 49 00 00       	push   $0x49c9
    33ce:	6a 01                	push   $0x1
    33d0:	e8 17 03 00 00       	call   36ec <printf>
}
    33d5:	83 c4 10             	add    $0x10,%esp
    33d8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    33db:	c9                   	leave  
    33dc:	c3                   	ret    
void argptest()
{
  int fd;
  fd = open("init", O_RDONLY);
  if (fd < 0) {
    printf(2, "open failed\n");
    33dd:	51                   	push   %ecx
    33de:	51                   	push   %ecx
    33df:	68 bc 49 00 00       	push   $0x49bc
    33e4:	6a 02                	push   $0x2
    33e6:	e8 01 03 00 00       	call   36ec <printf>
    exit();
    33eb:	e8 d7 01 00 00       	call   35c7 <exit>

000033f0 <rand>:
}

unsigned long randstate = 1;
unsigned int
rand()
{
    33f0:	55                   	push   %ebp
    33f1:	89 e5                	mov    %esp,%ebp
  randstate = randstate * 1664525 + 1013904223;
    33f3:	a1 7c 5a 00 00       	mov    0x5a7c,%eax
    33f8:	8d 14 00             	lea    (%eax,%eax,1),%edx
    33fb:	01 c2                	add    %eax,%edx
    33fd:	8d 14 90             	lea    (%eax,%edx,4),%edx
    3400:	c1 e2 08             	shl    $0x8,%edx
    3403:	01 c2                	add    %eax,%edx
    3405:	8d 14 92             	lea    (%edx,%edx,4),%edx
    3408:	8d 04 90             	lea    (%eax,%edx,4),%eax
    340b:	8d 04 80             	lea    (%eax,%eax,4),%eax
    340e:	8d 84 80 5f f3 6e 3c 	lea    0x3c6ef35f(%eax,%eax,4),%eax
    3415:	a3 7c 5a 00 00       	mov    %eax,0x5a7c
  return randstate;
}
    341a:	5d                   	pop    %ebp
    341b:	c3                   	ret    

0000341c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    341c:	55                   	push   %ebp
    341d:	89 e5                	mov    %esp,%ebp
    341f:	53                   	push   %ebx
    3420:	8b 45 08             	mov    0x8(%ebp),%eax
    3423:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3426:	89 c2                	mov    %eax,%edx
    3428:	42                   	inc    %edx
    3429:	41                   	inc    %ecx
    342a:	8a 59 ff             	mov    -0x1(%ecx),%bl
    342d:	88 5a ff             	mov    %bl,-0x1(%edx)
    3430:	84 db                	test   %bl,%bl
    3432:	75 f4                	jne    3428 <strcpy+0xc>
    ;
  return os;
}
    3434:	5b                   	pop    %ebx
    3435:	5d                   	pop    %ebp
    3436:	c3                   	ret    
    3437:	90                   	nop

00003438 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3438:	55                   	push   %ebp
    3439:	89 e5                	mov    %esp,%ebp
    343b:	56                   	push   %esi
    343c:	53                   	push   %ebx
    343d:	8b 55 08             	mov    0x8(%ebp),%edx
    3440:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
    3443:	0f b6 02             	movzbl (%edx),%eax
    3446:	0f b6 0b             	movzbl (%ebx),%ecx
    3449:	84 c0                	test   %al,%al
    344b:	75 14                	jne    3461 <strcmp+0x29>
    344d:	eb 1d                	jmp    346c <strcmp+0x34>
    344f:	90                   	nop
    p++, q++;
    3450:	42                   	inc    %edx
    3451:	8d 73 01             	lea    0x1(%ebx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    3454:	0f b6 02             	movzbl (%edx),%eax
    3457:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
    345b:	84 c0                	test   %al,%al
    345d:	74 0d                	je     346c <strcmp+0x34>
    345f:	89 f3                	mov    %esi,%ebx
    3461:	38 c8                	cmp    %cl,%al
    3463:	74 eb                	je     3450 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    3465:	29 c8                	sub    %ecx,%eax
}
    3467:	5b                   	pop    %ebx
    3468:	5e                   	pop    %esi
    3469:	5d                   	pop    %ebp
    346a:	c3                   	ret    
    346b:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    346c:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
    346e:	29 c8                	sub    %ecx,%eax
}
    3470:	5b                   	pop    %ebx
    3471:	5e                   	pop    %esi
    3472:	5d                   	pop    %ebp
    3473:	c3                   	ret    

00003474 <strlen>:

uint
strlen(const char *s)
{
    3474:	55                   	push   %ebp
    3475:	89 e5                	mov    %esp,%ebp
    3477:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    347a:	80 39 00             	cmpb   $0x0,(%ecx)
    347d:	74 10                	je     348f <strlen+0x1b>
    347f:	31 d2                	xor    %edx,%edx
    3481:	8d 76 00             	lea    0x0(%esi),%esi
    3484:	42                   	inc    %edx
    3485:	89 d0                	mov    %edx,%eax
    3487:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    348b:	75 f7                	jne    3484 <strlen+0x10>
    ;
  return n;
}
    348d:	5d                   	pop    %ebp
    348e:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
    348f:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
    3491:	5d                   	pop    %ebp
    3492:	c3                   	ret    
    3493:	90                   	nop

00003494 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3494:	55                   	push   %ebp
    3495:	89 e5                	mov    %esp,%ebp
    3497:	57                   	push   %edi
    3498:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    349b:	89 d7                	mov    %edx,%edi
    349d:	8b 4d 10             	mov    0x10(%ebp),%ecx
    34a0:	8b 45 0c             	mov    0xc(%ebp),%eax
    34a3:	fc                   	cld    
    34a4:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    34a6:	89 d0                	mov    %edx,%eax
    34a8:	5f                   	pop    %edi
    34a9:	5d                   	pop    %ebp
    34aa:	c3                   	ret    
    34ab:	90                   	nop

000034ac <strchr>:

char*
strchr(const char *s, char c)
{
    34ac:	55                   	push   %ebp
    34ad:	89 e5                	mov    %esp,%ebp
    34af:	53                   	push   %ebx
    34b0:	8b 45 08             	mov    0x8(%ebp),%eax
    34b3:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    34b6:	8a 10                	mov    (%eax),%dl
    34b8:	84 d2                	test   %dl,%dl
    34ba:	74 13                	je     34cf <strchr+0x23>
    34bc:	88 d9                	mov    %bl,%cl
    if(*s == c)
    34be:	38 d3                	cmp    %dl,%bl
    34c0:	75 06                	jne    34c8 <strchr+0x1c>
    34c2:	eb 0d                	jmp    34d1 <strchr+0x25>
    34c4:	38 ca                	cmp    %cl,%dl
    34c6:	74 09                	je     34d1 <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    34c8:	40                   	inc    %eax
    34c9:	8a 10                	mov    (%eax),%dl
    34cb:	84 d2                	test   %dl,%dl
    34cd:	75 f5                	jne    34c4 <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
    34cf:	31 c0                	xor    %eax,%eax
}
    34d1:	5b                   	pop    %ebx
    34d2:	5d                   	pop    %ebp
    34d3:	c3                   	ret    

000034d4 <gets>:

char*
gets(char *buf, int max)
{
    34d4:	55                   	push   %ebp
    34d5:	89 e5                	mov    %esp,%ebp
    34d7:	57                   	push   %edi
    34d8:	56                   	push   %esi
    34d9:	53                   	push   %ebx
    34da:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    34dd:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
    34df:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    34e2:	eb 26                	jmp    350a <gets+0x36>
    cc = read(0, &c, 1);
    34e4:	50                   	push   %eax
    34e5:	6a 01                	push   $0x1
    34e7:	57                   	push   %edi
    34e8:	6a 00                	push   $0x0
    34ea:	e8 f0 00 00 00       	call   35df <read>
    if(cc < 1)
    34ef:	83 c4 10             	add    $0x10,%esp
    34f2:	85 c0                	test   %eax,%eax
    34f4:	7e 1c                	jle    3512 <gets+0x3e>
      break;
    buf[i++] = c;
    34f6:	8a 45 e7             	mov    -0x19(%ebp),%al
    34f9:	8b 55 08             	mov    0x8(%ebp),%edx
    34fc:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3500:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    3502:	3c 0a                	cmp    $0xa,%al
    3504:	74 0c                	je     3512 <gets+0x3e>
    3506:	3c 0d                	cmp    $0xd,%al
    3508:	74 08                	je     3512 <gets+0x3e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    350a:	8d 5e 01             	lea    0x1(%esi),%ebx
    350d:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    3510:	7c d2                	jl     34e4 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    3512:	8b 45 08             	mov    0x8(%ebp),%eax
    3515:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    3519:	8d 65 f4             	lea    -0xc(%ebp),%esp
    351c:	5b                   	pop    %ebx
    351d:	5e                   	pop    %esi
    351e:	5f                   	pop    %edi
    351f:	5d                   	pop    %ebp
    3520:	c3                   	ret    
    3521:	8d 76 00             	lea    0x0(%esi),%esi

00003524 <stat>:

int
stat(const char *n, struct stat *st)
{
    3524:	55                   	push   %ebp
    3525:	89 e5                	mov    %esp,%ebp
    3527:	56                   	push   %esi
    3528:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3529:	83 ec 08             	sub    $0x8,%esp
    352c:	6a 00                	push   $0x0
    352e:	ff 75 08             	pushl  0x8(%ebp)
    3531:	e8 d1 00 00 00       	call   3607 <open>
  if(fd < 0)
    3536:	83 c4 10             	add    $0x10,%esp
    3539:	85 c0                	test   %eax,%eax
    353b:	78 27                	js     3564 <stat+0x40>
    353d:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    353f:	83 ec 08             	sub    $0x8,%esp
    3542:	ff 75 0c             	pushl  0xc(%ebp)
    3545:	50                   	push   %eax
    3546:	e8 d4 00 00 00       	call   361f <fstat>
    354b:	89 c6                	mov    %eax,%esi
  close(fd);
    354d:	89 1c 24             	mov    %ebx,(%esp)
    3550:	e8 9a 00 00 00       	call   35ef <close>
  return r;
    3555:	83 c4 10             	add    $0x10,%esp
    3558:	89 f0                	mov    %esi,%eax
}
    355a:	8d 65 f8             	lea    -0x8(%ebp),%esp
    355d:	5b                   	pop    %ebx
    355e:	5e                   	pop    %esi
    355f:	5d                   	pop    %ebp
    3560:	c3                   	ret    
    3561:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
    3564:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    3569:	eb ef                	jmp    355a <stat+0x36>
    356b:	90                   	nop

0000356c <atoi>:
  return r;
}

int
atoi(const char *s)
{
    356c:	55                   	push   %ebp
    356d:	89 e5                	mov    %esp,%ebp
    356f:	53                   	push   %ebx
    3570:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3573:	0f be 11             	movsbl (%ecx),%edx
    3576:	8d 42 d0             	lea    -0x30(%edx),%eax
    3579:	3c 09                	cmp    $0x9,%al
    357b:	b8 00 00 00 00       	mov    $0x0,%eax
    3580:	77 15                	ja     3597 <atoi+0x2b>
    3582:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    3584:	41                   	inc    %ecx
    3585:	8d 04 80             	lea    (%eax,%eax,4),%eax
    3588:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    358c:	0f be 11             	movsbl (%ecx),%edx
    358f:	8d 5a d0             	lea    -0x30(%edx),%ebx
    3592:	80 fb 09             	cmp    $0x9,%bl
    3595:	76 ed                	jbe    3584 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
    3597:	5b                   	pop    %ebx
    3598:	5d                   	pop    %ebp
    3599:	c3                   	ret    
    359a:	66 90                	xchg   %ax,%ax

0000359c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    359c:	55                   	push   %ebp
    359d:	89 e5                	mov    %esp,%ebp
    359f:	56                   	push   %esi
    35a0:	53                   	push   %ebx
    35a1:	8b 45 08             	mov    0x8(%ebp),%eax
    35a4:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    35a7:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    35aa:	85 f6                	test   %esi,%esi
    35ac:	7e 0d                	jle    35bb <memmove+0x1f>
    35ae:	31 d2                	xor    %edx,%edx
    *dst++ = *src++;
    35b0:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
    35b3:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    35b6:	42                   	inc    %edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    35b7:	39 f2                	cmp    %esi,%edx
    35b9:	75 f5                	jne    35b0 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
    35bb:	5b                   	pop    %ebx
    35bc:	5e                   	pop    %esi
    35bd:	5d                   	pop    %ebp
    35be:	c3                   	ret    

000035bf <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    35bf:	b8 01 00 00 00       	mov    $0x1,%eax
    35c4:	cd 40                	int    $0x40
    35c6:	c3                   	ret    

000035c7 <exit>:
SYSCALL(exit)
    35c7:	b8 02 00 00 00       	mov    $0x2,%eax
    35cc:	cd 40                	int    $0x40
    35ce:	c3                   	ret    

000035cf <wait>:
SYSCALL(wait)
    35cf:	b8 03 00 00 00       	mov    $0x3,%eax
    35d4:	cd 40                	int    $0x40
    35d6:	c3                   	ret    

000035d7 <pipe>:
SYSCALL(pipe)
    35d7:	b8 04 00 00 00       	mov    $0x4,%eax
    35dc:	cd 40                	int    $0x40
    35de:	c3                   	ret    

000035df <read>:
SYSCALL(read)
    35df:	b8 05 00 00 00       	mov    $0x5,%eax
    35e4:	cd 40                	int    $0x40
    35e6:	c3                   	ret    

000035e7 <write>:
SYSCALL(write)
    35e7:	b8 10 00 00 00       	mov    $0x10,%eax
    35ec:	cd 40                	int    $0x40
    35ee:	c3                   	ret    

000035ef <close>:
SYSCALL(close)
    35ef:	b8 15 00 00 00       	mov    $0x15,%eax
    35f4:	cd 40                	int    $0x40
    35f6:	c3                   	ret    

000035f7 <kill>:
SYSCALL(kill)
    35f7:	b8 06 00 00 00       	mov    $0x6,%eax
    35fc:	cd 40                	int    $0x40
    35fe:	c3                   	ret    

000035ff <exec>:
SYSCALL(exec)
    35ff:	b8 07 00 00 00       	mov    $0x7,%eax
    3604:	cd 40                	int    $0x40
    3606:	c3                   	ret    

00003607 <open>:
SYSCALL(open)
    3607:	b8 0f 00 00 00       	mov    $0xf,%eax
    360c:	cd 40                	int    $0x40
    360e:	c3                   	ret    

0000360f <mknod>:
SYSCALL(mknod)
    360f:	b8 11 00 00 00       	mov    $0x11,%eax
    3614:	cd 40                	int    $0x40
    3616:	c3                   	ret    

00003617 <unlink>:
SYSCALL(unlink)
    3617:	b8 12 00 00 00       	mov    $0x12,%eax
    361c:	cd 40                	int    $0x40
    361e:	c3                   	ret    

0000361f <fstat>:
SYSCALL(fstat)
    361f:	b8 08 00 00 00       	mov    $0x8,%eax
    3624:	cd 40                	int    $0x40
    3626:	c3                   	ret    

00003627 <link>:
SYSCALL(link)
    3627:	b8 13 00 00 00       	mov    $0x13,%eax
    362c:	cd 40                	int    $0x40
    362e:	c3                   	ret    

0000362f <mkdir>:
SYSCALL(mkdir)
    362f:	b8 14 00 00 00       	mov    $0x14,%eax
    3634:	cd 40                	int    $0x40
    3636:	c3                   	ret    

00003637 <chdir>:
SYSCALL(chdir)
    3637:	b8 09 00 00 00       	mov    $0x9,%eax
    363c:	cd 40                	int    $0x40
    363e:	c3                   	ret    

0000363f <dup>:
SYSCALL(dup)
    363f:	b8 0a 00 00 00       	mov    $0xa,%eax
    3644:	cd 40                	int    $0x40
    3646:	c3                   	ret    

00003647 <getpid>:
SYSCALL(getpid)
    3647:	b8 0b 00 00 00       	mov    $0xb,%eax
    364c:	cd 40                	int    $0x40
    364e:	c3                   	ret    

0000364f <sbrk>:
SYSCALL(sbrk)
    364f:	b8 0c 00 00 00       	mov    $0xc,%eax
    3654:	cd 40                	int    $0x40
    3656:	c3                   	ret    

00003657 <sleep>:
SYSCALL(sleep)
    3657:	b8 0d 00 00 00       	mov    $0xd,%eax
    365c:	cd 40                	int    $0x40
    365e:	c3                   	ret    

0000365f <uptime>:
SYSCALL(uptime)
    365f:	b8 0e 00 00 00       	mov    $0xe,%eax
    3664:	cd 40                	int    $0x40
    3666:	c3                   	ret    
    3667:	90                   	nop

00003668 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    3668:	55                   	push   %ebp
    3669:	89 e5                	mov    %esp,%ebp
    366b:	57                   	push   %edi
    366c:	56                   	push   %esi
    366d:	53                   	push   %ebx
    366e:	83 ec 3c             	sub    $0x3c,%esp
    3671:	89 c6                	mov    %eax,%esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    3673:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    3675:	8b 5d 08             	mov    0x8(%ebp),%ebx
    3678:	85 db                	test   %ebx,%ebx
    367a:	74 04                	je     3680 <printint+0x18>
    367c:	85 d2                	test   %edx,%edx
    367e:	78 5f                	js     36df <printint+0x77>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    3680:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
    3687:	31 ff                	xor    %edi,%edi
    3689:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    368c:	89 75 c4             	mov    %esi,-0x3c(%ebp)
    368f:	89 ce                	mov    %ecx,%esi
    3691:	eb 03                	jmp    3696 <printint+0x2e>
    3693:	90                   	nop
  do{
    buf[i++] = digits[x % base];
    3694:	89 cf                	mov    %ecx,%edi
    3696:	8d 4f 01             	lea    0x1(%edi),%ecx
    3699:	31 d2                	xor    %edx,%edx
    369b:	f7 f6                	div    %esi
    369d:	8a 92 9c 51 00 00    	mov    0x519c(%edx),%dl
    36a3:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
    36a6:	85 c0                	test   %eax,%eax
    36a8:	75 ea                	jne    3694 <printint+0x2c>
    36aa:	8b 75 c4             	mov    -0x3c(%ebp),%esi
  if(neg)
    36ad:	8b 55 c0             	mov    -0x40(%ebp),%edx
    36b0:	85 d2                	test   %edx,%edx
    36b2:	74 08                	je     36bc <printint+0x54>
    buf[i++] = '-';
    36b4:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
    36b9:	8d 4f 02             	lea    0x2(%edi),%ecx
    36bc:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
    36c0:	8a 07                	mov    (%edi),%al
    36c2:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    36c5:	50                   	push   %eax
    36c6:	6a 01                	push   $0x1
    36c8:	53                   	push   %ebx
    36c9:	56                   	push   %esi
    36ca:	e8 18 ff ff ff       	call   35e7 <write>
    36cf:	4f                   	dec    %edi
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    36d0:	83 c4 10             	add    $0x10,%esp
    36d3:	39 df                	cmp    %ebx,%edi
    36d5:	75 e9                	jne    36c0 <printint+0x58>
    putc(fd, buf[i]);
}
    36d7:	8d 65 f4             	lea    -0xc(%ebp),%esp
    36da:	5b                   	pop    %ebx
    36db:	5e                   	pop    %esi
    36dc:	5f                   	pop    %edi
    36dd:	5d                   	pop    %ebp
    36de:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    36df:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    36e1:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
    36e8:	eb 9d                	jmp    3687 <printint+0x1f>
    36ea:	66 90                	xchg   %ax,%ax

000036ec <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    36ec:	55                   	push   %ebp
    36ed:	89 e5                	mov    %esp,%ebp
    36ef:	57                   	push   %edi
    36f0:	56                   	push   %esi
    36f1:	53                   	push   %ebx
    36f2:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    36f5:	8b 75 0c             	mov    0xc(%ebp),%esi
    36f8:	8a 1e                	mov    (%esi),%bl
    36fa:	84 db                	test   %bl,%bl
    36fc:	0f 84 a6 00 00 00    	je     37a8 <printf+0xbc>
    3702:	46                   	inc    %esi
    3703:	8d 45 10             	lea    0x10(%ebp),%eax
    3706:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    3709:	31 ff                	xor    %edi,%edi
    370b:	eb 29                	jmp    3736 <printf+0x4a>
    370d:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    3710:	83 f8 25             	cmp    $0x25,%eax
    3713:	0f 84 97 00 00 00    	je     37b0 <printf+0xc4>
    3719:	88 5d e2             	mov    %bl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    371c:	50                   	push   %eax
    371d:	6a 01                	push   $0x1
    371f:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    3722:	50                   	push   %eax
    3723:	ff 75 08             	pushl  0x8(%ebp)
    3726:	e8 bc fe ff ff       	call   35e7 <write>
    372b:	83 c4 10             	add    $0x10,%esp
    372e:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    372f:	8a 5e ff             	mov    -0x1(%esi),%bl
    3732:	84 db                	test   %bl,%bl
    3734:	74 72                	je     37a8 <printf+0xbc>
    c = fmt[i] & 0xff;
    3736:	0f be cb             	movsbl %bl,%ecx
    3739:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    373c:	85 ff                	test   %edi,%edi
    373e:	74 d0                	je     3710 <printf+0x24>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    3740:	83 ff 25             	cmp    $0x25,%edi
    3743:	75 e9                	jne    372e <printf+0x42>
      if(c == 'd'){
    3745:	83 f8 64             	cmp    $0x64,%eax
    3748:	0f 84 f6 00 00 00    	je     3844 <printf+0x158>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    374e:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    3754:	83 f9 70             	cmp    $0x70,%ecx
    3757:	74 63                	je     37bc <printf+0xd0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    3759:	83 f8 73             	cmp    $0x73,%eax
    375c:	0f 84 86 00 00 00    	je     37e8 <printf+0xfc>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    3762:	83 f8 63             	cmp    $0x63,%eax
    3765:	0f 84 be 00 00 00    	je     3829 <printf+0x13d>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    376b:	83 f8 25             	cmp    $0x25,%eax
    376e:	0f 84 e0 00 00 00    	je     3854 <printf+0x168>
    3774:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3778:	50                   	push   %eax
    3779:	6a 01                	push   $0x1
    377b:	8d 45 e7             	lea    -0x19(%ebp),%eax
    377e:	50                   	push   %eax
    377f:	ff 75 08             	pushl  0x8(%ebp)
    3782:	e8 60 fe ff ff       	call   35e7 <write>
    3787:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    378a:	83 c4 0c             	add    $0xc,%esp
    378d:	6a 01                	push   $0x1
    378f:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    3792:	50                   	push   %eax
    3793:	ff 75 08             	pushl  0x8(%ebp)
    3796:	e8 4c fe ff ff       	call   35e7 <write>
    379b:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    379e:	31 ff                	xor    %edi,%edi
    37a0:	46                   	inc    %esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    37a1:	8a 5e ff             	mov    -0x1(%esi),%bl
    37a4:	84 db                	test   %bl,%bl
    37a6:	75 8e                	jne    3736 <printf+0x4a>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    37a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    37ab:	5b                   	pop    %ebx
    37ac:	5e                   	pop    %esi
    37ad:	5f                   	pop    %edi
    37ae:	5d                   	pop    %ebp
    37af:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    37b0:	bf 25 00 00 00       	mov    $0x25,%edi
    37b5:	e9 74 ff ff ff       	jmp    372e <printf+0x42>
    37ba:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    37bc:	83 ec 0c             	sub    $0xc,%esp
    37bf:	6a 00                	push   $0x0
    37c1:	b9 10 00 00 00       	mov    $0x10,%ecx
    37c6:	8b 7d d4             	mov    -0x2c(%ebp),%edi
    37c9:	8b 17                	mov    (%edi),%edx
    37cb:	8b 45 08             	mov    0x8(%ebp),%eax
    37ce:	e8 95 fe ff ff       	call   3668 <printint>
        ap++;
    37d3:	89 f8                	mov    %edi,%eax
    37d5:	83 c0 04             	add    $0x4,%eax
    37d8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    37db:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    37de:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
    37e0:	e9 49 ff ff ff       	jmp    372e <printf+0x42>
    37e5:	8d 76 00             	lea    0x0(%esi),%esi
      } else if(c == 's'){
        s = (char*)*ap;
    37e8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    37eb:	8b 38                	mov    (%eax),%edi
        ap++;
    37ed:	83 c0 04             	add    $0x4,%eax
    37f0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
    37f3:	85 ff                	test   %edi,%edi
    37f5:	74 6b                	je     3862 <printf+0x176>
          s = "(null)";
        while(*s != 0){
    37f7:	8a 07                	mov    (%edi),%al
    37f9:	84 c0                	test   %al,%al
    37fb:	74 6c                	je     3869 <printf+0x17d>
    37fd:	8d 5d e3             	lea    -0x1d(%ebp),%ebx
    3800:	89 75 d0             	mov    %esi,-0x30(%ebp)
    3803:	89 fe                	mov    %edi,%esi
    3805:	8b 7d 08             	mov    0x8(%ebp),%edi
    3808:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    380b:	50                   	push   %eax
    380c:	6a 01                	push   $0x1
    380e:	53                   	push   %ebx
    380f:	57                   	push   %edi
    3810:	e8 d2 fd ff ff       	call   35e7 <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
    3815:	46                   	inc    %esi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    3816:	8a 06                	mov    (%esi),%al
    3818:	83 c4 10             	add    $0x10,%esp
    381b:	84 c0                	test   %al,%al
    381d:	75 e9                	jne    3808 <printf+0x11c>
    381f:	8b 75 d0             	mov    -0x30(%ebp),%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3822:	31 ff                	xor    %edi,%edi
    3824:	e9 05 ff ff ff       	jmp    372e <printf+0x42>
    3829:	8b 7d d4             	mov    -0x2c(%ebp),%edi
    382c:	8b 07                	mov    (%edi),%eax
    382e:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3831:	51                   	push   %ecx
    3832:	6a 01                	push   $0x1
    3834:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    3837:	50                   	push   %eax
    3838:	ff 75 08             	pushl  0x8(%ebp)
    383b:	e8 a7 fd ff ff       	call   35e7 <write>
    3840:	eb 91                	jmp    37d3 <printf+0xe7>
    3842:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    3844:	83 ec 0c             	sub    $0xc,%esp
    3847:	6a 01                	push   $0x1
    3849:	b9 0a 00 00 00       	mov    $0xa,%ecx
    384e:	e9 73 ff ff ff       	jmp    37c6 <printf+0xda>
    3853:	90                   	nop
    3854:	88 5d e5             	mov    %bl,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3857:	52                   	push   %edx
    3858:	6a 01                	push   $0x1
    385a:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    385d:	e9 30 ff ff ff       	jmp    3792 <printf+0xa6>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
    3862:	bf 94 51 00 00       	mov    $0x5194,%edi
    3867:	eb 8e                	jmp    37f7 <printf+0x10b>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3869:	31 ff                	xor    %edi,%edi
    386b:	e9 be fe ff ff       	jmp    372e <printf+0x42>

00003870 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3870:	55                   	push   %ebp
    3871:	89 e5                	mov    %esp,%ebp
    3873:	57                   	push   %edi
    3874:	56                   	push   %esi
    3875:	53                   	push   %ebx
    3876:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    3879:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    387c:	a1 20 5b 00 00       	mov    0x5b20,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3881:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3883:	39 c8                	cmp    %ecx,%eax
    3885:	73 11                	jae    3898 <free+0x28>
    3887:	90                   	nop
    3888:	39 d1                	cmp    %edx,%ecx
    388a:	72 14                	jb     38a0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    388c:	39 d0                	cmp    %edx,%eax
    388e:	73 10                	jae    38a0 <free+0x30>
static Header base;
static Header *freep;

void
free(void *ap)
{
    3890:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3892:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3894:	39 c8                	cmp    %ecx,%eax
    3896:	72 f0                	jb     3888 <free+0x18>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3898:	39 d0                	cmp    %edx,%eax
    389a:	72 f4                	jb     3890 <free+0x20>
    389c:	39 d1                	cmp    %edx,%ecx
    389e:	73 f0                	jae    3890 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
    38a0:	8b 73 fc             	mov    -0x4(%ebx),%esi
    38a3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    38a6:	39 d7                	cmp    %edx,%edi
    38a8:	74 19                	je     38c3 <free+0x53>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    38aa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    38ad:	8b 50 04             	mov    0x4(%eax),%edx
    38b0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    38b3:	39 f1                	cmp    %esi,%ecx
    38b5:	74 23                	je     38da <free+0x6a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    38b7:	89 08                	mov    %ecx,(%eax)
  freep = p;
    38b9:	a3 20 5b 00 00       	mov    %eax,0x5b20
}
    38be:	5b                   	pop    %ebx
    38bf:	5e                   	pop    %esi
    38c0:	5f                   	pop    %edi
    38c1:	5d                   	pop    %ebp
    38c2:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    38c3:	03 72 04             	add    0x4(%edx),%esi
    38c6:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    38c9:	8b 10                	mov    (%eax),%edx
    38cb:	8b 12                	mov    (%edx),%edx
    38cd:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    38d0:	8b 50 04             	mov    0x4(%eax),%edx
    38d3:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    38d6:	39 f1                	cmp    %esi,%ecx
    38d8:	75 dd                	jne    38b7 <free+0x47>
    p->s.size += bp->s.size;
    38da:	03 53 fc             	add    -0x4(%ebx),%edx
    38dd:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    38e0:	8b 53 f8             	mov    -0x8(%ebx),%edx
    38e3:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
    38e5:	a3 20 5b 00 00       	mov    %eax,0x5b20
}
    38ea:	5b                   	pop    %ebx
    38eb:	5e                   	pop    %esi
    38ec:	5f                   	pop    %edi
    38ed:	5d                   	pop    %ebp
    38ee:	c3                   	ret    
    38ef:	90                   	nop

000038f0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    38f0:	55                   	push   %ebp
    38f1:	89 e5                	mov    %esp,%ebp
    38f3:	57                   	push   %edi
    38f4:	56                   	push   %esi
    38f5:	53                   	push   %ebx
    38f6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    38f9:	8b 45 08             	mov    0x8(%ebp),%eax
    38fc:	8d 78 07             	lea    0x7(%eax),%edi
    38ff:	c1 ef 03             	shr    $0x3,%edi
    3902:	47                   	inc    %edi
  if((prevp = freep) == 0){
    3903:	8b 15 20 5b 00 00    	mov    0x5b20,%edx
    3909:	85 d2                	test   %edx,%edx
    390b:	0f 84 b1 00 00 00    	je     39c2 <malloc+0xd2>
    3911:	8b 02                	mov    (%edx),%eax
    3913:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    3916:	39 cf                	cmp    %ecx,%edi
    3918:	76 66                	jbe    3980 <malloc+0x90>
    391a:	89 fb                	mov    %edi,%ebx
    391c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    3922:	0f 82 80 00 00 00    	jb     39a8 <malloc+0xb8>
    3928:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
    392e:	76 70                	jbe    39a0 <malloc+0xb0>
    3930:	8d 34 fd 00 00 00 00 	lea    0x0(,%edi,8),%esi
    3937:	eb 0c                	jmp    3945 <malloc+0x55>
    3939:	8d 76 00             	lea    0x0(%esi),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    393c:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    393e:	8b 48 04             	mov    0x4(%eax),%ecx
    3941:	39 cf                	cmp    %ecx,%edi
    3943:	76 3b                	jbe    3980 <malloc+0x90>
    3945:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    3947:	39 05 20 5b 00 00    	cmp    %eax,0x5b20
    394d:	75 ed                	jne    393c <malloc+0x4c>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    394f:	83 ec 0c             	sub    $0xc,%esp
    3952:	56                   	push   %esi
    3953:	e8 f7 fc ff ff       	call   364f <sbrk>
  if(p == (char*)-1)
    3958:	83 c4 10             	add    $0x10,%esp
    395b:	83 f8 ff             	cmp    $0xffffffff,%eax
    395e:	74 1c                	je     397c <malloc+0x8c>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    3960:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    3963:	83 ec 0c             	sub    $0xc,%esp
    3966:	83 c0 08             	add    $0x8,%eax
    3969:	50                   	push   %eax
    396a:	e8 01 ff ff ff       	call   3870 <free>
  return freep;
    396f:	8b 15 20 5b 00 00    	mov    0x5b20,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    3975:	83 c4 10             	add    $0x10,%esp
    3978:	85 d2                	test   %edx,%edx
    397a:	75 c0                	jne    393c <malloc+0x4c>
        return 0;
    397c:	31 c0                	xor    %eax,%eax
    397e:	eb 18                	jmp    3998 <malloc+0xa8>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    3980:	39 cf                	cmp    %ecx,%edi
    3982:	74 38                	je     39bc <malloc+0xcc>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    3984:	29 f9                	sub    %edi,%ecx
    3986:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    3989:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    398c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
    398f:	89 15 20 5b 00 00    	mov    %edx,0x5b20
      return (void*)(p + 1);
    3995:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    3998:	8d 65 f4             	lea    -0xc(%ebp),%esp
    399b:	5b                   	pop    %ebx
    399c:	5e                   	pop    %esi
    399d:	5f                   	pop    %edi
    399e:	5d                   	pop    %ebp
    399f:	c3                   	ret    
    39a0:	be 00 80 00 00       	mov    $0x8000,%esi
    39a5:	eb 9e                	jmp    3945 <malloc+0x55>
    39a7:	90                   	nop
    39a8:	bb 00 10 00 00       	mov    $0x1000,%ebx
    39ad:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
    39b3:	76 eb                	jbe    39a0 <malloc+0xb0>
    39b5:	e9 76 ff ff ff       	jmp    3930 <malloc+0x40>
    39ba:	66 90                	xchg   %ax,%ax
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    39bc:	8b 08                	mov    (%eax),%ecx
    39be:	89 0a                	mov    %ecx,(%edx)
    39c0:	eb cd                	jmp    398f <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    39c2:	c7 05 20 5b 00 00 24 	movl   $0x5b24,0x5b20
    39c9:	5b 00 00 
    39cc:	c7 05 24 5b 00 00 24 	movl   $0x5b24,0x5b24
    39d3:	5b 00 00 
    base.s.size = 0;
    39d6:	c7 05 28 5b 00 00 00 	movl   $0x0,0x5b28
    39dd:	00 00 00 
    39e0:	b8 24 5b 00 00       	mov    $0x5b24,%eax
    39e5:	e9 30 ff ff ff       	jmp    391a <malloc+0x2a>
