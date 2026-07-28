
./Dy_task0:     file format elf64-x86-64


Disassembly of section .init:

Disassembly of section .plt:

Disassembly of section .plt.got:

Disassembly of section .plt.sec:

Disassembly of section .text:

0000000000001209 <verify_flag>:
    1209:	f3 0f 1e fa          	endbr64
    120d:	55                   	push   rbp
    120e:	48 89 e5             	mov    rbp,rsp
    1211:	48 83 ec 60          	sub    rsp,0x60
    1215:	48 89 7d a8          	mov    QWORD PTR [rbp-0x58],rdi
    1219:	64 48 8b 04 25 28 00 	mov    rax,QWORD PTR fs:0x28
    1220:	00 00 
    1222:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    1226:	31 c0                	xor    eax,eax
    1228:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    122c:	48 89 c7             	mov    rdi,rax
    122f:	e8 ac fe ff ff       	call   10e0 <strlen@plt>
    1234:	48 83 f8 23          	cmp    rax,0x23
    1238:	74 0a                	je     1244 <verify_flag+0x3b>
    123a:	b8 00 00 00 00       	mov    eax,0x0
    123f:	e9 c2 01 00 00       	jmp    1406 <verify_flag+0x1fd>
    1244:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1248:	ba 0a 00 00 00       	mov    edx,0xa
    124d:	48 8d 35 b0 0d 00 00 	lea    rsi,[rip+0xdb0]        # 2004 <_IO_stdin_used+0x4>
    1254:	48 89 c7             	mov    rdi,rax
    1257:	e8 64 fe ff ff       	call   10c0 <strncmp@plt>
    125c:	85 c0                	test   eax,eax
    125e:	74 0a                	je     126a <verify_flag+0x61>
    1260:	b8 00 00 00 00       	mov    eax,0x0
    1265:	e9 9c 01 00 00       	jmp    1406 <verify_flag+0x1fd>
    126a:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    126e:	48 83 c0 22          	add    rax,0x22
    1272:	0f b6 00             	movzx  eax,BYTE PTR [rax]
    1275:	3c 7d                	cmp    al,0x7d
    1277:	74 0a                	je     1283 <verify_flag+0x7a>
    1279:	b8 00 00 00 00       	mov    eax,0x0
    127e:	e9 83 01 00 00       	jmp    1406 <verify_flag+0x1fd>
    1283:	48 8b 45 a8          	mov    rax,QWORD PTR [rbp-0x58]
    1287:	48 8d 48 0a          	lea    rcx,[rax+0xa]
    128b:	48 8d 45 d0          	lea    rax,[rbp-0x30]
    128f:	ba 18 00 00 00       	mov    edx,0x18
    1294:	48 89 ce             	mov    rsi,rcx
    1297:	48 89 c7             	mov    rdi,rax
    129a:	e8 11 fe ff ff       	call   10b0 <strncpy@plt>
    129f:	c6 45 e8 00          	mov    BYTE PTR [rbp-0x18],0x0
    12a3:	c7 45 b4 00 00 00 00 	mov    DWORD PTR [rbp-0x4c],0x0
    12aa:	c7 45 b8 01 00 00 00 	mov    DWORD PTR [rbp-0x48],0x1
    12b1:	c7 45 bc 00 00 00 00 	mov    DWORD PTR [rbp-0x44],0x0
    12b8:	c7 45 c0 01 00 00 00 	mov    DWORD PTR [rbp-0x40],0x1
    12bf:	c7 45 c4 00 00 00 00 	mov    DWORD PTR [rbp-0x3c],0x0
    12c6:	e9 c4 00 00 00       	jmp    138f <verify_flag+0x186>
    12cb:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    12ce:	48 98                	cdqe
    12d0:	0f b6 44 05 d0       	movzx  eax,BYTE PTR [rbp+rax*1-0x30]
    12d5:	0f be c0             	movsx  eax,al
    12d8:	89 45 cc             	mov    DWORD PTR [rbp-0x34],eax
    12db:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    12de:	83 c0 01             	add    eax,0x1
    12e1:	0f af 45 cc          	imul   eax,DWORD PTR [rbp-0x34]
    12e5:	8b 55 c4             	mov    edx,DWORD PTR [rbp-0x3c]
    12e8:	83 c2 02             	add    edx,0x2
    12eb:	0f af c2             	imul   eax,edx
    12ee:	99                   	cdq
    12ef:	c1 ea 18             	shr    edx,0x18
    12f2:	01 d0                	add    eax,edx
    12f4:	0f b6 c0             	movzx  eax,al
    12f7:	29 d0                	sub    eax,edx
    12f9:	01 45 b4             	add    DWORD PTR [rbp-0x4c],eax
    12fc:	8b 55 c4             	mov    edx,DWORD PTR [rbp-0x3c]
    12ff:	89 d0                	mov    eax,edx
    1301:	c1 e0 03             	shl    eax,0x3
    1304:	29 d0                	sub    eax,edx
    1306:	89 c2                	mov    edx,eax
    1308:	8b 45 cc             	mov    eax,DWORD PTR [rbp-0x34]
    130b:	01 d0                	add    eax,edx
    130d:	8d 50 1f             	lea    edx,[rax+0x1f]
    1310:	48 63 c2             	movsxd rax,edx
    1313:	48 69 c0 15 02 4d 21 	imul   rax,rax,0x214d0215
    131a:	48 c1 e8 20          	shr    rax,0x20
    131e:	89 c1                	mov    ecx,eax
    1320:	c1 f9 04             	sar    ecx,0x4
    1323:	89 d0                	mov    eax,edx
    1325:	c1 f8 1f             	sar    eax,0x1f
    1328:	29 c1                	sub    ecx,eax
    132a:	89 c8                	mov    eax,ecx
    132c:	6b c0 7b             	imul   eax,eax,0x7b
    132f:	29 c2                	sub    edx,eax
    1331:	89 d0                	mov    eax,edx
    1333:	8b 55 b8             	mov    edx,DWORD PTR [rbp-0x48]
    1336:	0f af c2             	imul   eax,edx
    1339:	89 45 b8             	mov    DWORD PTR [rbp-0x48],eax
    133c:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    133f:	83 c0 01             	add    eax,0x1
    1342:	0f af 45 cc          	imul   eax,DWORD PTR [rbp-0x34]
    1346:	89 c2                	mov    edx,eax
    1348:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    134b:	0f af c0             	imul   eax,eax
    134e:	01 c2                	add    edx,eax
    1350:	89 d0                	mov    eax,edx
    1352:	c1 f8 1f             	sar    eax,0x1f
    1355:	c1 e8 17             	shr    eax,0x17
    1358:	01 c2                	add    edx,eax
    135a:	81 e2 ff 01 00 00    	and    edx,0x1ff
    1360:	29 c2                	sub    edx,eax
    1362:	89 d0                	mov    eax,edx
    1364:	01 45 bc             	add    DWORD PTR [rbp-0x44],eax
    1367:	8b 45 c4             	mov    eax,DWORD PTR [rbp-0x3c]
    136a:	83 c0 03             	add    eax,0x3
    136d:	0f af 45 cc          	imul   eax,DWORD PTR [rbp-0x34]
    1371:	8d 50 11             	lea    edx,[rax+0x11]
    1374:	89 d0                	mov    eax,edx
    1376:	c1 f8 1f             	sar    eax,0x1f
    1379:	c1 e8 16             	shr    eax,0x16
    137c:	01 c2                	add    edx,eax
    137e:	81 e2 ff 03 00 00    	and    edx,0x3ff
    1384:	29 c2                	sub    edx,eax
    1386:	89 d0                	mov    eax,edx
    1388:	31 45 c0             	xor    DWORD PTR [rbp-0x40],eax
    138b:	83 45 c4 01          	add    DWORD PTR [rbp-0x3c],0x1
    138f:	83 7d c4 17          	cmp    DWORD PTR [rbp-0x3c],0x17
    1393:	0f 8e 32 ff ff ff    	jle    12cb <verify_flag+0xc2>
    1399:	8b 45 b4             	mov    eax,DWORD PTR [rbp-0x4c]
    139c:	0f af 45 b8          	imul   eax,DWORD PTR [rbp-0x48]
    13a0:	89 c2                	mov    edx,eax
    13a2:	8b 45 bc             	mov    eax,DWORD PTR [rbp-0x44]
    13a5:	01 d0                	add    eax,edx
    13a7:	2b 45 c0             	sub    eax,DWORD PTR [rbp-0x40]
    13aa:	35 ef be ad de       	xor    eax,0xdeadbeef
    13af:	25 ff ff ff 00       	and    eax,0xffffff
    13b4:	89 45 c8             	mov    DWORD PTR [rbp-0x38],eax
    13b7:	8b 45 b4             	mov    eax,DWORD PTR [rbp-0x4c]
    13ba:	0f af 45 b8          	imul   eax,DWORD PTR [rbp-0x48]
    13be:	89 c2                	mov    edx,eax
    13c0:	8b 45 c8             	mov    eax,DWORD PTR [rbp-0x38]
    13c3:	01 c2                	add    edx,eax
    13c5:	8b 45 bc             	mov    eax,DWORD PTR [rbp-0x44]
    13c8:	0f af 45 c0          	imul   eax,DWORD PTR [rbp-0x40]
    13cc:	29 c2                	sub    edx,eax
    13ce:	89 d0                	mov    eax,edx
    13d0:	8d 90 be ba fe ca    	lea    edx,[rax-0x35014542]
    13d6:	89 d0                	mov    eax,edx
    13d8:	d1 e8                	shr    eax,1
    13da:	89 c1                	mov    ecx,eax
    13dc:	b8 15 3f e5 87       	mov    eax,0x87e53f15
    13e1:	48 0f af c1          	imul   rax,rcx
    13e5:	48 c1 e8 20          	shr    rax,0x20
    13e9:	c1 e8 12             	shr    eax,0x12
    13ec:	69 c0 06 12 0f 00    	imul   eax,eax,0xf1206
    13f2:	29 c2                	sub    edx,eax
    13f4:	89 d0                	mov    eax,edx
    13f6:	89 45 c8             	mov    DWORD PTR [rbp-0x38],eax
    13f9:	81 7d c8 44 ae 00 00 	cmp    DWORD PTR [rbp-0x38],0xae44
    1400:	0f 94 c0             	sete   al
    1403:	0f b6 c0             	movzx  eax,al
    1406:	48 8b 75 f8          	mov    rsi,QWORD PTR [rbp-0x8]
    140a:	64 48 33 34 25 28 00 	xor    rsi,QWORD PTR fs:0x28
    1411:	00 00 
    1413:	74 05                	je     141a <verify_flag+0x211>
    1415:	e8 d6 fc ff ff       	call   10f0 <__stack_chk_fail@plt>
    141a:	c9                   	leave
    141b:	c3                   	ret

Disassembly of section .fini:
