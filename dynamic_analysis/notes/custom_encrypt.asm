
./Dy_task1:     file format elf64-x86-64


Disassembly of section .init:

Disassembly of section .plt:

Disassembly of section .plt.got:

Disassembly of section .plt.sec:

Disassembly of section .text:

000000000000137f <custom_encrypt>:
    137f:	f3 0f 1e fa          	endbr64
    1383:	55                   	push   rbp
    1384:	48 89 e5             	mov    rbp,rsp
    1387:	48 83 ec 20          	sub    rsp,0x20
    138b:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    138f:	89 75 e4             	mov    DWORD PTR [rbp-0x1c],esi
    1392:	89 55 e0             	mov    DWORD PTR [rbp-0x20],edx
    1395:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [rbp-0x4],0x0
    139c:	e9 95 00 00 00       	jmp    1436 <custom_encrypt+0xb7>
    13a1:	48 8d 45 e0          	lea    rax,[rbp-0x20]
    13a5:	48 89 c7             	mov    rdi,rax
    13a8:	e8 9d ff ff ff       	call   134a <prng>
    13ad:	88 45 fb             	mov    BYTE PTR [rbp-0x5],al
    13b0:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    13b3:	48 63 d0             	movsxd rdx,eax
    13b6:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    13ba:	48 01 d0             	add    rax,rdx
    13bd:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    13c0:	8b 55 fc             	mov    edx,DWORD PTR [rbp-0x4]
    13c3:	48 63 ca             	movsxd rcx,edx
    13c6:	48 8b 55 e8          	mov    rdx,QWORD PTR [rbp-0x18]
    13ca:	48 01 ca             	add    rdx,rcx
    13cd:	32 45 fb             	xor    al,BYTE PTR [rbp-0x5]
    13d0:	88 02                	mov    BYTE PTR [rdx],al
    13d2:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    13d5:	48 63 d0             	movsxd rdx,eax
    13d8:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    13dc:	48 01 d0             	add    rax,rdx
    13df:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    13e2:	0f b6 c0             	movzx  eax,al
    13e5:	c1 e0 03             	shl    eax,0x3
    13e8:	89 c1                	mov    ecx,eax
    13ea:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    13ed:	48 63 d0             	movsxd rdx,eax
    13f0:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    13f4:	48 01 d0             	add    rax,rdx
    13f7:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    13fa:	c0 e8 05             	shr    al,0x5
    13fd:	09 c1                	or     ecx,eax
    13ff:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    1402:	48 63 d0             	movsxd rdx,eax
    1405:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    1409:	48 01 d0             	add    rax,rdx
    140c:	89 ca                	mov    edx,ecx
    140e:	88 10                	mov    BYTE PTR [rax],dl
    1410:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    1413:	48 63 d0             	movsxd rdx,eax
    1416:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    141a:	48 01 d0             	add    rax,rdx
    141d:	0f b6 10             	movzx  edx,BYTE PTR [rax]
    1420:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    1423:	48 63 c8             	movsxd rcx,eax
    1426:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    142a:	48 01 c8             	add    rax,rcx
    142d:	83 ea 5b             	sub    edx,0x5b
    1430:	88 10                	mov    BYTE PTR [rax],dl
    1432:	83 45 fc 01          	add    DWORD PTR [rbp-0x4],0x1
    1436:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    1439:	3b 45 e4             	cmp    eax,DWORD PTR [rbp-0x1c]
    143c:	0f 8c 5f ff ff ff    	jl     13a1 <custom_encrypt+0x22>
    1442:	90                   	nop
    1443:	90                   	nop
    1444:	c9                   	leave
    1445:	c3                   	ret

Disassembly of section .fini:
