
./Dy_task0:     file format elf64-x86-64


Disassembly of section .init:

Disassembly of section .plt:

Disassembly of section .plt.got:

Disassembly of section .plt.sec:

Disassembly of section .text:

000000000000141c <main>:
    141c:	f3 0f 1e fa          	endbr64
    1420:	55                   	push   rbp
    1421:	48 89 e5             	mov    rbp,rsp
    1424:	48 83 ec 40          	sub    rsp,0x40
    1428:	64 48 8b 04 25 28 00 	mov    rax,QWORD PTR fs:0x28
    142f:	00 00 
    1431:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    1435:	31 c0                	xor    eax,eax
    1437:	48 8d 3d d1 0b 00 00 	lea    rdi,[rip+0xbd1]        # 200f <_IO_stdin_used+0xf>
    143e:	b8 00 00 00 00       	mov    eax,0x0
    1443:	e8 b8 fc ff ff       	call   1100 <printf@plt>
    1448:	48 8d 45 c0          	lea    rax,[rbp-0x40]
    144c:	48 89 c6             	mov    rsi,rax
    144f:	48 8d 3d ca 0b 00 00 	lea    rdi,[rip+0xbca]        # 2020 <_IO_stdin_used+0x20>
    1456:	b8 00 00 00 00       	mov    eax,0x0
    145b:	e8 b0 fc ff ff       	call   1110 <__isoc99_scanf@plt>
    1460:	48 8d 45 c0          	lea    rax,[rbp-0x40]
    1464:	48 89 c7             	mov    rdi,rax
    1467:	e8 9d fd ff ff       	call   1209 <verify_flag>
    146c:	85 c0                	test   eax,eax
    146e:	74 0e                	je     147e <main+0x62>
    1470:	48 8d 3d ae 0b 00 00 	lea    rdi,[rip+0xbae]        # 2025 <_IO_stdin_used+0x25>
    1477:	e8 54 fc ff ff       	call   10d0 <puts@plt>
    147c:	eb 0c                	jmp    148a <main+0x6e>
    147e:	48 8d 3d ae 0b 00 00 	lea    rdi,[rip+0xbae]        # 2033 <_IO_stdin_used+0x33>
    1485:	e8 46 fc ff ff       	call   10d0 <puts@plt>
    148a:	b8 00 00 00 00       	mov    eax,0x0
    148f:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    1493:	64 48 33 14 25 28 00 	xor    rdx,QWORD PTR fs:0x28
    149a:	00 00 
    149c:	74 05                	je     14a3 <main+0x87>
    149e:	e8 4d fc ff ff       	call   10f0 <__stack_chk_fail@plt>
    14a3:	c9                   	leave
    14a4:	c3                   	ret

Disassembly of section .fini:
