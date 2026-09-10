; ======================================================================
; VST dispatcher (opcode 0x19..0x44)
; RVA 0x21d90 .. 0x22450   VA 0x10021d90 .. 0x10022450   (1728 bytes)
; ======================================================================

10021d90  55                       push     ebp
10021d91  8b ec                    mov      ebp, esp
10021d93  81 ec 90 00 00 00        sub      esp, 0x90
10021d99  89 7c 24 08              mov      dword ptr [esp + 8], edi
10021d9d  89 74 24 04              mov      dword ptr [esp + 4], esi
10021da1  89 1c 24                 mov      dword ptr [esp], ebx
10021da4  d9 45 18                 fld      dword ptr [ebp + 0x18]
10021da7  8b 75 08                 mov      esi, dword ptr [ebp + 8]
10021daa  33 d2                    xor      edx, edx
10021dac  dd 5d f0                 fstp     qword ptr [ebp - 0x10]
10021daf  8d 46 e7                 lea      eax, [esi - 0x19]
10021db2  8b 7d 18                 mov      edi, dword ptr [ebp + 0x18]
10021db5  83 f8 2b                 cmp      eax, 0x2b
10021db8  89 7d e4                 mov      dword ptr [ebp - 0x1c], edi
10021dbb  8b 7d 14                 mov      edi, dword ptr [ebp + 0x14]
10021dbe  89 7d f8                 mov      dword ptr [ebp - 8], edi
10021dc1  8b 7d 0c                 mov      edi, dword ptr [ebp + 0xc]
10021dc4  89 7d e8                 mov      dword ptr [ebp - 0x18], edi
10021dc7  8b 5d 10                 mov      ebx, dword ptr [ebp + 0x10]
10021dca  0f 87 70 06 00 00        ja       0x10022440
10021dd0  8b 04 85 e0 89 18 10     mov      eax, dword ptr [eax*4 + 0x101889e0]
10021dd7  ff e0                    jmp      eax
10021dd9  8b 55 f8                 mov      edx, dword ptr [ebp - 8]
10021ddc  8b 19                    mov      ebx, dword ptr [ecx]
10021dde  52                       push     edx
10021ddf  8b 83 c8 00 00 00        mov      eax, dword ptr [ebx + 0xc8]
10021de5  ff d0                    call     eax
10021de7  8b d0                    mov      edx, eax
10021de9  e9 77 06 00 00           jmp      0x10022465
10021dee  8b d7                    mov      edx, edi
10021df0  8b 19                    mov      ebx, dword ptr [ecx]
10021df2  52                       push     edx
10021df3  8b 83 d4 00 00 00        mov      eax, dword ptr [ebx + 0xd4]
10021df9  ff d0                    call     eax
10021dfb  0f be c0                 movsx    eax, al
10021dfe  85 c0                    test     eax, eax
10021e00  74 0a                    je       0x10021e0c
10021e02  ba 01 00 00 00           mov      edx, 1
10021e07  e9 59 06 00 00           jmp      0x10022465
10021e0c  33 d2                    xor      edx, edx
10021e0e  e9 52 06 00 00           jmp      0x10022465
10021e13  83 c4 f8                 add      esp, -8
10021e16  8b d7                    mov      edx, edi
10021e18  8b 5d f8                 mov      ebx, dword ptr [ebp - 8]
10021e1b  8b 31                    mov      esi, dword ptr [ecx]
10021e1d  89 14 24                 mov      dword ptr [esp], edx
10021e20  8b 86 d8 00 00 00        mov      eax, dword ptr [esi + 0xd8]
10021e26  89 5c 24 04              mov      dword ptr [esp + 4], ebx
10021e2a  ff d0                    call     eax
10021e2c  0f be c0                 movsx    eax, al
10021e2f  85 c0                    test     eax, eax
10021e31  74 0a                    je       0x10021e3d
10021e33  ba 01 00 00 00           mov      edx, 1
10021e38  e9 28 06 00 00           jmp      0x10022465
10021e3d  33 d2                    xor      edx, edx
10021e3f  e9 21 06 00 00           jmp      0x10022465
10021e44  8b 11                    mov      edx, dword ptr [ecx]
10021e46  8b 82 e0 00 00 00        mov      eax, dword ptr [edx + 0xe0]
10021e4c  ff d0                    call     eax
10021e4e  8b d0                    mov      edx, eax
10021e50  e9 10 06 00 00           jmp      0x10022465
10021e55  83 c4 f4                 add      esp, -0xc
10021e58  8b d7                    mov      edx, edi
10021e5a  8b 75 f8                 mov      esi, dword ptr [ebp - 8]
10021e5d  89 1c 24                 mov      dword ptr [esp], ebx
10021e60  8b 39                    mov      edi, dword ptr [ecx]
10021e62  89 54 24 04              mov      dword ptr [esp + 4], edx
10021e66  8b 87 e4 00 00 00        mov      eax, dword ptr [edi + 0xe4]
10021e6c  89 74 24 08              mov      dword ptr [esp + 8], esi
10021e70  ff d0                    call     eax
10021e72  0f be c0                 movsx    eax, al
10021e75  85 c0                    test     eax, eax
10021e77  74 0a                    je       0x10021e83
10021e79  ba 01 00 00 00           mov      edx, 1
10021e7e  e9 e2 05 00 00           jmp      0x10022465
10021e83  33 d2                    xor      edx, edx
10021e85  e9 db 05 00 00           jmp      0x10022465
10021e8a  8b d7                    mov      edx, edi
10021e8c  8b 19                    mov      ebx, dword ptr [ecx]
10021e8e  52                       push     edx
10021e8f  8b 83 e8 00 00 00        mov      eax, dword ptr [ebx + 0xe8]
10021e95  ff d0                    call     eax
10021e97  0f be c0                 movsx    eax, al
10021e9a  85 c0                    test     eax, eax
10021e9c  74 0a                    je       0x10021ea8
10021e9e  ba 01 00 00 00           mov      edx, 1
10021ea3  e9 bd 05 00 00           jmp      0x10022465
10021ea8  33 d2                    xor      edx, edx
10021eaa  e9 b6 05 00 00           jmp      0x10022465
10021eaf  85 db                    test     ebx, ebx
10021eb1  74 04                    je       0x10021eb7
10021eb3  b0 01                    mov      al, 1
10021eb5  eb 02                    jmp      0x10021eb9
10021eb7  32 c0                    xor      al, al
10021eb9  83 c4 f8                 add      esp, -8
10021ebc  8b d7                    mov      edx, edi
10021ebe  8b 19                    mov      ebx, dword ptr [ecx]
10021ec0  88 44 24 04              mov      byte ptr [esp + 4], al
10021ec4  8b 83 10 01 00 00        mov      eax, dword ptr [ebx + 0x110]
10021eca  89 14 24                 mov      dword ptr [esp], edx
10021ecd  ff d0                    call     eax
10021ecf  ba 01 00 00 00           mov      edx, 1
10021ed4  e9 8c 05 00 00           jmp      0x10022465
10021ed9  85 db                    test     ebx, ebx
10021edb  74 04                    je       0x10021ee1
10021edd  b0 01                    mov      al, 1
10021edf  eb 02                    jmp      0x10021ee3
10021ee1  32 c0                    xor      al, al
10021ee3  83 c4 f8                 add      esp, -8
10021ee6  8b d7                    mov      edx, edi
10021ee8  8b 19                    mov      ebx, dword ptr [ecx]
10021eea  88 44 24 04              mov      byte ptr [esp + 4], al
10021eee  8b 83 14 01 00 00        mov      eax, dword ptr [ebx + 0x114]
10021ef4  89 14 24                 mov      dword ptr [esp], edx
10021ef7  ff d0                    call     eax
10021ef9  ba 01 00 00 00           mov      edx, 1
10021efe  e9 62 05 00 00           jmp      0x10022465
10021f03  83 c4 f8                 add      esp, -8
10021f06  8b d7                    mov      edx, edi
10021f08  8b 5d f8                 mov      ebx, dword ptr [ebp - 8]
10021f0b  8b 31                    mov      esi, dword ptr [ecx]
10021f0d  89 14 24                 mov      dword ptr [esp], edx
10021f10  8b 86 18 01 00 00        mov      eax, dword ptr [esi + 0x118]
10021f16  89 5c 24 04              mov      dword ptr [esp + 4], ebx
10021f1a  ff d0                    call     eax
10021f1c  0f be c0                 movsx    eax, al
10021f1f  85 c0                    test     eax, eax
10021f21  74 0a                    je       0x10021f2d
10021f23  ba 01 00 00 00           mov      edx, 1
10021f28  e9 38 05 00 00           jmp      0x10022465
10021f2d  33 d2                    xor      edx, edx
10021f2f  e9 31 05 00 00           jmp      0x10022465
10021f34  83 c4 f8                 add      esp, -8
10021f37  8b d7                    mov      edx, edi
10021f39  8b 5d f8                 mov      ebx, dword ptr [ebp - 8]
10021f3c  8b 31                    mov      esi, dword ptr [ecx]
10021f3e  89 14 24                 mov      dword ptr [esp], edx
10021f41  8b 86 1c 01 00 00        mov      eax, dword ptr [esi + 0x11c]
10021f47  89 5c 24 04              mov      dword ptr [esp + 4], ebx
10021f4b  ff d0                    call     eax
10021f4d  0f be c0                 movsx    eax, al
10021f50  85 c0                    test     eax, eax
10021f52  74 0a                    je       0x10021f5e
10021f54  ba 01 00 00 00           mov      edx, 1
10021f59  e9 07 05 00 00           jmp      0x10022465
10021f5e  33 d2                    xor      edx, edx
10021f60  e9 00 05 00 00           jmp      0x10022465
10021f65  8b 11                    mov      edx, dword ptr [ecx]
10021f67  8b 82 20 01 00 00        mov      eax, dword ptr [edx + 0x120]
10021f6d  ff d0                    call     eax
10021f6f  8b d0                    mov      edx, eax
10021f71  e9 ef 04 00 00           jmp      0x10022465
10021f76  8b 11                    mov      edx, dword ptr [ecx]
10021f78  8b 82 38 01 00 00        mov      eax, dword ptr [edx + 0x138]
10021f7e  ff d0                    call     eax
10021f80  8b d0                    mov      edx, eax
10021f82  e9 de 04 00 00           jmp      0x10022465
10021f87  8b 11                    mov      edx, dword ptr [ecx]
10021f89  8b 82 3c 01 00 00        mov      eax, dword ptr [edx + 0x13c]
10021f8f  ff d0                    call     eax
10021f91  8b d0                    mov      edx, eax
10021f93  e9 cd 04 00 00           jmp      0x10022465
10021f98  33 d2                    xor      edx, edx
10021f9a  83 c4 f4                 add      esp, -0xc
10021f9d  8b f7                    mov      esi, edi
10021f9f  89 5c 24 04              mov      dword ptr [esp + 4], ebx
10021fa3  85 f6                    test     esi, esi
10021fa5  0f 95 c2                 setne    dl
10021fa8  8b 75 f8                 mov      esi, dword ptr [ebp - 8]
10021fab  88 54 24 08              mov      byte ptr [esp + 8], dl
10021faf  8b 11                    mov      edx, dword ptr [ecx]
10021fb1  89 34 24                 mov      dword ptr [esp], esi
10021fb4  8b 82 54 01 00 00        mov      eax, dword ptr [edx + 0x154]
10021fba  ff d0                    call     eax
10021fbc  0f be d0                 movsx    edx, al
10021fbf  e9 a1 04 00 00           jmp      0x10022465
10021fc4  83 c4 f8                 add      esp, -8
10021fc7  8b 55 f8                 mov      edx, dword ptr [ebp - 8]
10021fca  8b 31                    mov      esi, dword ptr [ecx]
10021fcc  89 5c 24 04              mov      dword ptr [esp + 4], ebx
10021fd0  8b 86 58 01 00 00        mov      eax, dword ptr [esi + 0x158]
10021fd6  89 14 24                 mov      dword ptr [esp], edx
10021fd9  ff d0                    call     eax
10021fdb  0f be d0                 movsx    edx, al
10021fde  e9 82 04 00 00           jmp      0x10022465
10021fe3  83 c4 f8                 add      esp, -8
10021fe6  8b 55 f8                 mov      edx, dword ptr [ebp - 8]
10021fe9  8b 31                    mov      esi, dword ptr [ecx]
10021feb  89 5c 24 04              mov      dword ptr [esp + 4], ebx
10021fef  8b 86 5c 01 00 00        mov      eax, dword ptr [esi + 0x15c]
10021ff5  89 14 24                 mov      dword ptr [esp], edx
10021ff8  ff d0                    call     eax
10021ffa  0f be d0                 movsx    edx, al
10021ffd  e9 63 04 00 00           jmp      0x10022465
10022002  8b 55 f8                 mov      edx, dword ptr [ebp - 8]
10022005  8b 19                    mov      ebx, dword ptr [ecx]
10022007  52                       push     edx
10022008  8b 83 a0 01 00 00        mov      eax, dword ptr [ebx + 0x1a0]
1002200e  ff d0                    call     eax
10022010  0f be c0                 movsx    eax, al
10022013  85 c0                    test     eax, eax
10022015  74 0a                    je       0x10022021
10022017  ba 01 00 00 00           mov      edx, 1
1002201c  e9 44 04 00 00           jmp      0x10022465
10022021  33 d2                    xor      edx, edx
10022023  e9 3d 04 00 00           jmp      0x10022465
10022028  83 c4 f8                 add      esp, -8
1002202b  8b 55 f8                 mov      edx, dword ptr [ebp - 8]
1002202e  8b 31                    mov      esi, dword ptr [ecx]
10022030  89 1c 24                 mov      dword ptr [esp], ebx
10022033  8b 86 a4 01 00 00        mov      eax, dword ptr [esi + 0x1a4]
10022039  89 54 24 04              mov      dword ptr [esp + 4], edx
1002203d  ff d0                    call     eax
1002203f  0f be c0                 movsx    eax, al
10022042  85 c0                    test     eax, eax
10022044  74 0a                    je       0x10022050
10022046  ba 01 00 00 00           mov      edx, 1
1002204b  e9 15 04 00 00           jmp      0x10022465
10022050  33 d2                    xor      edx, edx
10022052  e9 0e 04 00 00           jmp      0x10022465
10022057  83 c4 f8                 add      esp, -8
1002205a  8b 55 e4                 mov      edx, dword ptr [ebp - 0x1c]
1002205d  8b 31                    mov      esi, dword ptr [ecx]
1002205f  89 1c 24                 mov      dword ptr [esp], ebx
10022062  8b 86 a8 01 00 00        mov      eax, dword ptr [esi + 0x1a8]
10022068  89 54 24 04              mov      dword ptr [esp + 4], edx
1002206c  ff d0                    call     eax
1002206e  ba 01 00 00 00           mov      edx, 1
10022073  e9 ed 03 00 00           jmp      0x10022465
10022078  85 db                    test     ebx, ebx
1002207a  74 04                    je       0x10022080
1002207c  b0 01                    mov      al, 1
1002207e  eb 02                    jmp      0x10022082
10022080  32 c0                    xor      al, al
10022082  57                       push     edi
10022083  8b 11                    mov      edx, dword ptr [ecx]
10022085  88 04 24                 mov      byte ptr [esp], al
10022088  8b 82 ac 01 00 00        mov      eax, dword ptr [edx + 0x1ac]
1002208e  ff d0                    call     eax
10022090  0f be c0                 movsx    eax, al
10022093  85 c0                    test     eax, eax
10022095  74 0a                    je       0x100220a1
10022097  ba 01 00 00 00           mov      edx, 1
1002209c  e9 c4 03 00 00           jmp      0x10022465
100220a1  33 d2                    xor      edx, edx
100220a3  e9 bd 03 00 00           jmp      0x10022465
100220a8  8b 55 f8                 mov      edx, dword ptr [ebp - 8]
100220ab  8b 19                    mov      ebx, dword ptr [ecx]
100220ad  52                       push     edx
100220ae  8b 83 b0 01 00 00        mov      eax, dword ptr [ebx + 0x1b0]
100220b4  ff d0                    call     eax
100220b6  0f be c0                 movsx    eax, al
100220b9  85 c0                    test     eax, eax
100220bb  74 0a                    je       0x100220c7
100220bd  ba 01 00 00 00           mov      edx, 1
100220c2  e9 9e 03 00 00           jmp      0x10022465
100220c7  33 d2                    xor      edx, edx
100220c9  e9 97 03 00 00           jmp      0x10022465
100220ce  8b 55 f8                 mov      edx, dword ptr [ebp - 8]
100220d1  8b 19                    mov      ebx, dword ptr [ecx]
100220d3  52                       push     edx
100220d4  8b 83 b4 01 00 00        mov      eax, dword ptr [ebx + 0x1b4]
100220da  ff d0                    call     eax
100220dc  0f be c0                 movsx    eax, al
100220df  85 c0                    test     eax, eax
100220e1  74 0a                    je       0x100220ed
100220e3  ba 01 00 00 00           mov      edx, 1
100220e8  e9 78 03 00 00           jmp      0x10022465
100220ed  33 d2                    xor      edx, edx
100220ef  e9 71 03 00 00           jmp      0x10022465
100220f4  8b 55 f8                 mov      edx, dword ptr [ebp - 8]
100220f7  8b 19                    mov      ebx, dword ptr [ecx]
100220f9  52                       push     edx
100220fa  8b 83 b8 01 00 00        mov      eax, dword ptr [ebx + 0x1b8]
10022100  ff d0                    call     eax
10022102  0f be c0                 movsx    eax, al
10022105  85 c0                    test     eax, eax
10022107  74 0a                    je       0x10022113
10022109  ba 01 00 00 00           mov      edx, 1
1002210e  e9 52 03 00 00           jmp      0x10022465
10022113  33 d2                    xor      edx, edx
10022115  e9 4b 03 00 00           jmp      0x10022465
1002211a  8b 55 f8                 mov      edx, dword ptr [ebp - 8]
1002211d  8b 19                    mov      ebx, dword ptr [ecx]
1002211f  52                       push     edx
10022120  8b 83 bc 01 00 00        mov      eax, dword ptr [ebx + 0x1bc]
10022126  ff d0                    call     eax
10022128  0f be c0                 movsx    eax, al
1002212b  85 c0                    test     eax, eax
1002212d  74 0a                    je       0x10022139
1002212f  ba 01 00 00 00           mov      edx, 1
10022134  e9 2c 03 00 00           jmp      0x10022465
10022139  33 d2                    xor      edx, edx
1002213b  e9 25 03 00 00           jmp      0x10022465
10022140  8b 11                    mov      edx, dword ptr [ecx]
10022142  8b 82 c0 01 00 00        mov      eax, dword ptr [edx + 0x1c0]
10022148  ff d0                    call     eax
1002214a  8b d0                    mov      edx, eax
1002214c  e9 14 03 00 00           jmp      0x10022465
10022151  83 c4 f0                 add      esp, -0x10
10022154  8b d7                    mov      edx, edi
10022156  8b 75 f8                 mov      esi, dword ptr [ebp - 8]
10022159  89 5c 24 04              mov      dword ptr [esp + 4], ebx
1002215d  89 14 24                 mov      dword ptr [esp], edx
10022160  8b 55 e4                 mov      edx, dword ptr [ebp - 0x1c]
10022163  8b 39                    mov      edi, dword ptr [ecx]
10022165  89 74 24 08              mov      dword ptr [esp + 8], esi
10022169  8b 87 c4 01 00 00        mov      eax, dword ptr [edi + 0x1c4]
1002216f  89 54 24 0c              mov      dword ptr [esp + 0xc], edx
10022173  ff d0                    call     eax
10022175  8b d0                    mov      edx, eax
10022177  e9 e9 02 00 00           jmp      0x10022465
1002217c  8b 55 f8                 mov      edx, dword ptr [ebp - 8]
1002217f  8b 19                    mov      ebx, dword ptr [ecx]
10022181  52                       push     edx
10022182  8b 83 c8 01 00 00        mov      eax, dword ptr [ebx + 0x1c8]
10022188  ff d0                    call     eax
1002218a  8b d0                    mov      edx, eax
1002218c  e9 d4 02 00 00           jmp      0x10022465
10022191  8b 11                    mov      edx, dword ptr [ecx]
10022193  8b 82 d4 01 00 00        mov      eax, dword ptr [edx + 0x1d4]
10022199  ff d0                    call     eax
1002219b  8b d0                    mov      edx, eax
1002219d  e9 c3 02 00 00           jmp      0x10022465
100221a2  8b 11                    mov      edx, dword ptr [ecx]
100221a4  8b 82 d8 01 00 00        mov      eax, dword ptr [edx + 0x1d8]
100221aa  ff d0                    call     eax
100221ac  8b d0                    mov      edx, eax
100221ae  e9 b2 02 00 00           jmp      0x10022465
100221b3  8b 11                    mov      edx, dword ptr [ecx]
100221b5  8b 82 cc 01 00 00        mov      eax, dword ptr [edx + 0x1cc]
100221bb  ff d0                    call     eax
100221bd  8b d0                    mov      edx, eax
100221bf  e9 a1 02 00 00           jmp      0x10022465
100221c4  83 c4 f8                 add      esp, -8
100221c7  8b d7                    mov      edx, edi
100221c9  8b 31                    mov      esi, dword ptr [ecx]
100221cb  89 5c 24 04              mov      dword ptr [esp + 4], ebx
100221cf  8b 86 d0 01 00 00        mov      eax, dword ptr [esi + 0x1d0]
100221d5  89 14 24                 mov      dword ptr [esp], edx
100221d8  ff d0                    call     eax
100221da  0f be c0                 movsx    eax, al
100221dd  85 c0                    test     eax, eax
100221df  74 0a                    je       0x100221eb
100221e1  ba 01 00 00 00           mov      edx, 1
100221e6  e9 7a 02 00 00           jmp      0x10022465
100221eb  33 d2                    xor      edx, edx
100221ed  e9 73 02 00 00           jmp      0x10022465
100221f2  83 c4 f8                 add      esp, -8
100221f5  8b d7                    mov      edx, edi
100221f7  8b 5d f8                 mov      ebx, dword ptr [ebp - 8]
100221fa  8b 31                    mov      esi, dword ptr [ecx]
100221fc  89 14 24                 mov      dword ptr [esp], edx
100221ff  8b 86 dc 01 00 00        mov      eax, dword ptr [esi + 0x1dc]
10022205  89 5c 24 04              mov      dword ptr [esp + 4], ebx
10022209  ff d0                    call     eax
1002220b  0f be c0                 movsx    eax, al
1002220e  85 c0                    test     eax, eax
10022210  74 0a                    je       0x1002221c
10022212  ba 01 00 00 00           mov      edx, 1
10022217  e9 49 02 00 00           jmp      0x10022465
1002221c  33 d2                    xor      edx, edx
1002221e  e9 42 02 00 00           jmp      0x10022465
10022223  8b 11                    mov      edx, dword ptr [ecx]
10022225  8b 82 e0 01 00 00        mov      eax, dword ptr [edx + 0x1e0]
1002222b  ff d0                    call     eax
1002222d  0f be c0                 movsx    eax, al
10022230  85 c0                    test     eax, eax
10022232  74 07                    je       0x1002223b
10022234  33 d2                    xor      edx, edx
10022236  e9 2a 02 00 00           jmp      0x10022465
1002223b  ba 01 00 00 00           mov      edx, 1
10022240  e9 20 02 00 00           jmp      0x10022465
10022245  8b 11                    mov      edx, dword ptr [ecx]
10022247  8b 82 e4 01 00 00        mov      eax, dword ptr [edx + 0x1e4]
1002224d  ff d0                    call     eax
1002224f  8b d0                    mov      edx, eax
10022251  e9 0f 02 00 00           jmp      0x10022465
10022256  8b 41 08                 mov      eax, dword ptr [ecx + 8]
10022259  85 c0                    test     eax, eax
1002225b  0f 84 04 02 00 00        je       0x10022465
10022261  dd 45 f0                 fld      qword ptr [ebp - 0x10]
10022264  8b f7                    mov      esi, edi
10022266  88 5d a0                 mov      byte ptr [ebp - 0x60], bl
10022269  dd 5d c8                 fstp     qword ptr [ebp - 0x38]
1002226c  89 75 9c                 mov      dword ptr [ebp - 0x64], esi
1002226f  8b 55 cc                 mov      edx, dword ptr [ebp - 0x34]
10022272  8b 5d c8                 mov      ebx, dword ptr [ebp - 0x38]
10022275  8b f2                    mov      esi, edx
10022277  c1 ee 14                 shr      esi, 0x14
1002227a  8b ce                    mov      ecx, esi
1002227c  81 e1 ff 07 00 00        and      ecx, 0x7ff
10022282  81 f9 fe 03 00 00        cmp      ecx, 0x3fe
10022288  7e 22                    jle      0x100222ac
1002228a  f7 d9                    neg      ecx
1002228c  81 c1 1e 04 00 00        add      ecx, 0x41e
10022292  8b f2                    mov      esi, edx
10022294  0f a4 de 0b              shld     esi, ebx, 0xb
10022298  81 ce 00 00 00 80        or       esi, 0x80000000
1002229e  8b fa                    mov      edi, edx
100222a0  8b d6                    mov      edx, esi
100222a2  d3 ea                    shr      edx, cl
100222a4  85 ff                    test     edi, edi
100222a6  7d 06                    jge      0x100222ae
100222a8  f7 da                    neg      edx
100222aa  eb 02                    jmp      0x100222ae
100222ac  33 d2                    xor      edx, edx
100222ae  8a da                    mov      bl, dl
100222b0  88 5d a1                 mov      byte ptr [ebp - 0x5f], bl
100222b3  8b 18                    mov      ebx, dword ptr [eax]
100222b5  8d 75 9c                 lea      esi, [ebp - 0x64]
100222b8  89 55 b0                 mov      dword ptr [ebp - 0x50], edx
100222bb  56                       push     esi
100222bc  8b c8                    mov      ecx, eax
100222be  8b 43 1c                 mov      eax, dword ptr [ebx + 0x1c]
100222c1  ff d0                    call     eax
100222c3  8b d0                    mov      edx, eax
100222c5  e9 9b 01 00 00           jmp      0x10022465
100222ca  8b 41 08                 mov      eax, dword ptr [ecx + 8]
100222cd  85 c0                    test     eax, eax
100222cf  0f 84 90 01 00 00        je       0x10022465
100222d5  dd 45 f0                 fld      qword ptr [ebp - 0x10]
100222d8  8b f7                    mov      esi, edi
100222da  88 5d a8                 mov      byte ptr [ebp - 0x58], bl
100222dd  dd 5d d8                 fstp     qword ptr [ebp - 0x28]
100222e0  89 75 a4                 mov      dword ptr [ebp - 0x5c], esi
100222e3  8b 55 dc                 mov      edx, dword ptr [ebp - 0x24]
100222e6  8b 5d d8                 mov      ebx, dword ptr [ebp - 0x28]
100222e9  8b f2                    mov      esi, edx
100222eb  c1 ee 14                 shr      esi, 0x14
100222ee  8b ce                    mov      ecx, esi
100222f0  81 e1 ff 07 00 00        and      ecx, 0x7ff
100222f6  81 f9 fe 03 00 00        cmp      ecx, 0x3fe
100222fc  7e 22                    jle      0x10022320
100222fe  f7 d9                    neg      ecx
10022300  81 c1 1e 04 00 00        add      ecx, 0x41e
10022306  8b f2                    mov      esi, edx
10022308  0f a4 de 0b              shld     esi, ebx, 0xb
1002230c  81 ce 00 00 00 80        or       esi, 0x80000000
10022312  8b fa                    mov      edi, edx
10022314  8b d6                    mov      edx, esi
10022316  d3 ea                    shr      edx, cl
10022318  85 ff                    test     edi, edi
1002231a  7d 06                    jge      0x10022322
1002231c  f7 da                    neg      edx
1002231e  eb 02                    jmp      0x10022322
10022320  33 d2                    xor      edx, edx
10022322  8a da                    mov      bl, dl
10022324  88 5d a9                 mov      byte ptr [ebp - 0x57], bl
10022327  8b 18                    mov      ebx, dword ptr [eax]
10022329  8d 75 a4                 lea      esi, [ebp - 0x5c]
1002232c  89 55 b0                 mov      dword ptr [ebp - 0x50], edx
1002232f  56                       push     esi
10022330  8b c8                    mov      ecx, eax
10022332  8b 43 20                 mov      eax, dword ptr [ebx + 0x20]
10022335  ff d0                    call     eax
10022337  8b d0                    mov      edx, eax
10022339  e9 27 01 00 00           jmp      0x10022465
1002233e  8b 49 08                 mov      ecx, dword ptr [ecx + 8]
10022341  85 c9                    test     ecx, ecx
10022343  0f 84 1c 01 00 00        je       0x10022465
10022349  8b 11                    mov      edx, dword ptr [ecx]
1002234b  8b 42 24                 mov      eax, dword ptr [edx + 0x24]
1002234e  53                       push     ebx
1002234f  ff d0                    call     eax
10022351  8b d0                    mov      edx, eax
10022353  e9 0d 01 00 00           jmp      0x10022465
10022358  83 c4 f8                 add      esp, -8
1002235b  8b d7                    mov      edx, edi
1002235d  8b 5d f8                 mov      ebx, dword ptr [ebp - 8]
10022360  8b 31                    mov      esi, dword ptr [ecx]
10022362  89 14 24                 mov      dword ptr [esp], edx
10022365  8b 86 e8 01 00 00        mov      eax, dword ptr [esi + 0x1e8]
1002236b  89 5c 24 04              mov      dword ptr [esp + 4], ebx
1002236f  ff d0                    call     eax
10022371  8b d0                    mov      edx, eax
10022373  e9 ed 00 00 00           jmp      0x10022465
10022378  83 c4 f8                 add      esp, -8
1002237b  8b d7                    mov      edx, edi
1002237d  8b 5d f8                 mov      ebx, dword ptr [ebp - 8]
10022380  8b 31                    mov      esi, dword ptr [ecx]
10022382  89 14 24                 mov      dword ptr [esp], edx
10022385  8b 86 ec 01 00 00        mov      eax, dword ptr [esi + 0x1ec]
1002238b  89 5c 24 04              mov      dword ptr [esp + 4], ebx
1002238f  ff d0                    call     eax
10022391  8b d0                    mov      edx, eax
10022393  e9 cd 00 00 00           jmp      0x10022465
10022398  83 c4 f8                 add      esp, -8
1002239b  8b d7                    mov      edx, edi
1002239d  8b 5d f8                 mov      ebx, dword ptr [ebp - 8]
100223a0  8b 31                    mov      esi, dword ptr [ecx]
100223a2  89 14 24                 mov      dword ptr [esp], edx
100223a5  8b 86 f0 01 00 00        mov      eax, dword ptr [esi + 0x1f0]
100223ab  89 5c 24 04              mov      dword ptr [esp + 4], ebx
100223af  ff d0                    call     eax
100223b1  8b d0                    mov      edx, eax
100223b3  e9 ad 00 00 00           jmp      0x10022465
100223b8  8b d7                    mov      edx, edi
100223ba  8b 19                    mov      ebx, dword ptr [ecx]
100223bc  52                       push     edx
100223bd  8b 83 f4 01 00 00        mov      eax, dword ptr [ebx + 0x1f4]
100223c3  ff d0                    call     eax
100223c5  0f be c0                 movsx    eax, al
100223c8  85 c0                    test     eax, eax
100223ca  74 0a                    je       0x100223d6
100223cc  ba 01 00 00 00           mov      edx, 1
100223d1  e9 8f 00 00 00           jmp      0x10022465
100223d6  33 d2                    xor      edx, edx
100223d8  e9 88 00 00 00           jmp      0x10022465
100223dd  83 c4 f8                 add      esp, -8
100223e0  8b d7                    mov      edx, edi
100223e2  8b 5d f8                 mov      ebx, dword ptr [ebp - 8]
100223e5  8b 31                    mov      esi, dword ptr [ecx]
100223e7  89 14 24                 mov      dword ptr [esp], edx
100223ea  8b 86 f8 01 00 00        mov      eax, dword ptr [esi + 0x1f8]
100223f0  89 5c 24 04              mov      dword ptr [esp + 4], ebx
100223f4  ff d0                    call     eax
100223f6  0f be c0                 movsx    eax, al
100223f9  85 c0                    test     eax, eax
100223fb  74 07                    je       0x10022404
100223fd  ba 01 00 00 00           mov      edx, 1
10022402  eb 61                    jmp      0x10022465
10022404  33 d2                    xor      edx, edx
10022406  eb 5d                    jmp      0x10022465
10022408  8b 11                    mov      edx, dword ptr [ecx]
1002240a  8b 82 fc 01 00 00        mov      eax, dword ptr [edx + 0x1fc]
10022410  ff d0                    call     eax
10022412  0f be c0                 movsx    eax, al
10022415  85 c0                    test     eax, eax
10022417  74 07                    je       0x10022420
10022419  ba 01 00 00 00           mov      edx, 1
1002241e  eb 45                    jmp      0x10022465
10022420  33 d2                    xor      edx, edx
10022422  eb 41                    jmp      0x10022465
10022424  8b 11                    mov      edx, dword ptr [ecx]
10022426  8b 82 00 02 00 00        mov      eax, dword ptr [edx + 0x200]
1002242c  ff d0                    call     eax
1002242e  0f be c0                 movsx    eax, al
10022431  85 c0                    test     eax, eax
10022433  74 07                    je       0x1002243c
10022435  ba 01 00 00 00           mov      edx, 1
1002243a  eb 29                    jmp      0x10022465
1002243c  33 d2                    xor      edx, edx
1002243e  eb 25                    jmp      0x10022465
10022440  83 c4 ec                 add      esp, -0x14
10022443  8b c7                    mov      eax, edi
10022445  89 5c 24 08              mov      dword ptr [esp + 8], ebx
10022449  89 34 24                 mov      dword ptr [esp], esi
1002244c  8b 55 f8                 mov      edx, dword ptr [ebp - 8]
