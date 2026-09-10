; ======================================================================
; 安装校验 (授权检查)
; RVA 0x1e6c0 .. 0x1eb10   VA 0x1001e6c0 .. 0x1001eb10   (1104 bytes)
; ======================================================================

1001e6c0  55                       push     ebp
1001e6c1  8b ec                    mov      ebp, esp
1001e6c3  81 ec 40 01 00 00        sub      esp, 0x140
1001e6c9  89 7c 24 08              mov      dword ptr [esp + 8], edi
1001e6cd  89 74 24 04              mov      dword ptr [esp + 4], esi
1001e6d1  89 1c 24                 mov      dword ptr [esp], ebx
1001e6d4  8b d9                    mov      ebx, ecx
1001e6d6  8b cb                    mov      ecx, ebx
1001e6d8  e8 33 08 00 00           call     0x1001ef10
1001e6dd  80 33 aa                 xor      byte ptr [ebx], 0xaa
1001e6e0  32 c0                    xor      al, al
1001e6e2  8b cb                    mov      ecx, ebx
1001e6e4  88 85 fc fe ff ff        mov      byte ptr [ebp - 0x104], al
1001e6ea  8a 63 01                 mov      ah, byte ptr [ebx + 1]
1001e6ed  80 f4 aa                 xor      ah, 0xaa
1001e6f0  88 63 01                 mov      byte ptr [ebx + 1], ah
1001e6f3  88 85 fd fe ff ff        mov      byte ptr [ebp - 0x103], al
1001e6f9  8a 63 02                 mov      ah, byte ptr [ebx + 2]
1001e6fc  80 f4 aa                 xor      ah, 0xaa
1001e6ff  88 63 02                 mov      byte ptr [ebx + 2], ah
1001e702  88 85 fe fe ff ff        mov      byte ptr [ebp - 0x102], al
1001e708  8a 63 03                 mov      ah, byte ptr [ebx + 3]
1001e70b  80 f4 aa                 xor      ah, 0xaa
1001e70e  88 63 03                 mov      byte ptr [ebx + 3], ah
1001e711  88 85 ff fe ff ff        mov      byte ptr [ebp - 0x101], al
1001e717  8a 63 04                 mov      ah, byte ptr [ebx + 4]
1001e71a  80 f4 aa                 xor      ah, 0xaa
1001e71d  88 63 04                 mov      byte ptr [ebx + 4], ah
1001e720  88 85 00 ff ff ff        mov      byte ptr [ebp - 0x100], al
1001e726  8a 63 05                 mov      ah, byte ptr [ebx + 5]
1001e729  80 f4 aa                 xor      ah, 0xaa
1001e72c  88 63 05                 mov      byte ptr [ebx + 5], ah
1001e72f  88 85 01 ff ff ff        mov      byte ptr [ebp - 0xff], al
1001e735  8a 63 06                 mov      ah, byte ptr [ebx + 6]
1001e738  80 f4 aa                 xor      ah, 0xaa
1001e73b  88 63 06                 mov      byte ptr [ebx + 6], ah
1001e73e  88 85 02 ff ff ff        mov      byte ptr [ebp - 0xfe], al
1001e744  8a 63 07                 mov      ah, byte ptr [ebx + 7]
1001e747  80 f4 aa                 xor      ah, 0xaa
1001e74a  88 63 07                 mov      byte ptr [ebx + 7], ah
1001e74d  88 85 03 ff ff ff        mov      byte ptr [ebp - 0xfd], al
1001e753  8a 63 08                 mov      ah, byte ptr [ebx + 8]
1001e756  80 f4 aa                 xor      ah, 0xaa
1001e759  88 63 08                 mov      byte ptr [ebx + 8], ah
1001e75c  88 85 04 ff ff ff        mov      byte ptr [ebp - 0xfc], al
1001e762  8a 63 09                 mov      ah, byte ptr [ebx + 9]
1001e765  80 f4 aa                 xor      ah, 0xaa
1001e768  88 63 09                 mov      byte ptr [ebx + 9], ah
1001e76b  88 85 05 ff ff ff        mov      byte ptr [ebp - 0xfb], al
1001e771  8a 63 0a                 mov      ah, byte ptr [ebx + 0xa]
1001e774  80 f4 aa                 xor      ah, 0xaa
1001e777  88 63 0a                 mov      byte ptr [ebx + 0xa], ah
1001e77a  88 85 06 ff ff ff        mov      byte ptr [ebp - 0xfa], al
1001e780  8a 63 0b                 mov      ah, byte ptr [ebx + 0xb]
1001e783  80 f4 aa                 xor      ah, 0xaa
1001e786  88 63 0b                 mov      byte ptr [ebx + 0xb], ah
1001e789  88 85 07 ff ff ff        mov      byte ptr [ebp - 0xf9], al
1001e78f  8a 63 0c                 mov      ah, byte ptr [ebx + 0xc]
1001e792  80 f4 aa                 xor      ah, 0xaa
1001e795  88 63 0c                 mov      byte ptr [ebx + 0xc], ah
1001e798  88 85 08 ff ff ff        mov      byte ptr [ebp - 0xf8], al
1001e79e  8a 63 0d                 mov      ah, byte ptr [ebx + 0xd]
1001e7a1  80 f4 aa                 xor      ah, 0xaa
1001e7a4  88 63 0d                 mov      byte ptr [ebx + 0xd], ah
1001e7a7  88 85 09 ff ff ff        mov      byte ptr [ebp - 0xf7], al
1001e7ad  8a 63 0e                 mov      ah, byte ptr [ebx + 0xe]
1001e7b0  80 f4 aa                 xor      ah, 0xaa
1001e7b3  88 63 0e                 mov      byte ptr [ebx + 0xe], ah
1001e7b6  88 85 0a ff ff ff        mov      byte ptr [ebp - 0xf6], al
1001e7bc  8a 63 0f                 mov      ah, byte ptr [ebx + 0xf]
1001e7bf  80 f4 aa                 xor      ah, 0xaa
1001e7c2  88 63 0f                 mov      byte ptr [ebx + 0xf], ah
1001e7c5  88 85 0b ff ff ff        mov      byte ptr [ebp - 0xf5], al
1001e7cb  e8 c0 04 00 00           call     0x1001ec90
1001e7d0  0f be c0                 movsx    eax, al
1001e7d3  85 c0                    test     eax, eax
1001e7d5  75 11                    jne      0x1001e7e8
1001e7d7  33 c0                    xor      eax, eax
1001e7d9  8b 1c 24                 mov      ebx, dword ptr [esp]
1001e7dc  8b 74 24 04              mov      esi, dword ptr [esp + 4]
1001e7e0  8b 7c 24 08              mov      edi, dword ptr [esp + 8]
1001e7e4  8b e5                    mov      esp, ebp
1001e7e6  5d                       pop      ebp
1001e7e7  c3                       ret      
1001e7e8  ba 7f 00 00 00           mov      edx, 0x7f
1001e7ed  8d 76 00                 lea      esi, [esi]
1001e7f0  8a 04 1a                 mov      al, byte ptr [edx + ebx]
1001e7f3  88 82 80 96 10 10        mov      byte ptr [edx + 0x10109680], al
1001e7f9  8a 44 1a ff              mov      al, byte ptr [edx + ebx - 1]
1001e7fd  88 82 7f 96 10 10        mov      byte ptr [edx + 0x1010967f], al
1001e803  8a 44 1a fe              mov      al, byte ptr [edx + ebx - 2]
1001e807  88 82 7e 96 10 10        mov      byte ptr [edx + 0x1010967e], al
1001e80d  8a 44 1a fd              mov      al, byte ptr [edx + ebx - 3]
1001e811  88 82 7d 96 10 10        mov      byte ptr [edx + 0x1010967d], al
1001e817  83 c2 fc                 add      edx, -4
1001e81a  85 d2                    test     edx, edx
1001e81c  7d d2                    jge      0x1001e7f0
1001e81e  8b cb                    mov      ecx, ebx
1001e820  e8 4b 03 00 00           call     0x1001eb70
1001e825  83 c4 f8                 add      esp, -8
1001e828  8d 95 fc fe ff ff        lea      edx, [ebp - 0x104]
1001e82e  8b f0                    mov      esi, eax
1001e830  8b cb                    mov      ecx, ebx
1001e832  c7 44 24 04 80 00 00 00  mov      dword ptr [esp + 4], 0x80
1001e83a  89 14 24                 mov      dword ptr [esp], edx
1001e83d  e8 6e 08 00 00           call     0x1001f0b0
1001e842  85 c0                    test     eax, eax
1001e844  0f 84 a3 02 00 00        je       0x1001eaed
1001e84a  83 c4 f8                 add      esp, -8
1001e84d  8d 85 fc fe ff ff        lea      eax, [ebp - 0x104]
1001e853  8b cb                    mov      ecx, ebx
1001e855  89 04 24                 mov      dword ptr [esp], eax
1001e858  c7 44 24 04 23 45 01 00  mov      dword ptr [esp + 4], 0x14523
1001e860  e8 8b 07 00 00           call     0x1001eff0
1001e865  0f be 15 80 96 10 10     movsx    edx, byte ptr [0x10109680]
1001e86c  0f be 1d 81 96 10 10     movsx    ebx, byte ptr [0x10109681]
1001e873  8b fe                    mov      edi, esi
1001e875  c1 ef 18                 shr      edi, 0x18
1001e878  c1 e6 08                 shl      esi, 8
1001e87b  33 fa                    xor      edi, edx
1001e87d  0f be 15 82 96 10 10     movsx    edx, byte ptr [0x10109682]
1001e884  8b c7                    mov      eax, edi
1001e886  0f b6 c0                 movzx    eax, al
1001e889  0f be 3d 83 96 10 10     movsx    edi, byte ptr [0x10109683]
1001e890  33 34 85 00 97 10 10     xor      esi, dword ptr [eax*4 + 0x10109700]
1001e897  0f be 05 84 96 10 10     movsx    eax, byte ptr [0x10109684]
1001e89e  8b ce                    mov      ecx, esi
1001e8a0  c1 e9 18                 shr      ecx, 0x18
1001e8a3  c1 e6 08                 shl      esi, 8
1001e8a6  33 cb                    xor      ecx, ebx
1001e8a8  0f b6 c9                 movzx    ecx, cl
1001e8ab  33 34 8d 00 97 10 10     xor      esi, dword ptr [ecx*4 + 0x10109700]
1001e8b2  0f be 1d 85 96 10 10     movsx    ebx, byte ptr [0x10109685]
1001e8b9  8b ce                    mov      ecx, esi
1001e8bb  c1 e9 18                 shr      ecx, 0x18
1001e8be  c1 e6 08                 shl      esi, 8
1001e8c1  33 ca                    xor      ecx, edx
1001e8c3  0f b6 c9                 movzx    ecx, cl
1001e8c6  33 34 8d 00 97 10 10     xor      esi, dword ptr [ecx*4 + 0x10109700]
1001e8cd  0f be 15 86 96 10 10     movsx    edx, byte ptr [0x10109686]
1001e8d4  8b ce                    mov      ecx, esi
1001e8d6  c1 e9 18                 shr      ecx, 0x18
1001e8d9  c1 e6 08                 shl      esi, 8
1001e8dc  33 cf                    xor      ecx, edi
1001e8de  0f b6 c9                 movzx    ecx, cl
1001e8e1  33 34 8d 00 97 10 10     xor      esi, dword ptr [ecx*4 + 0x10109700]
1001e8e8  0f be 3d 87 96 10 10     movsx    edi, byte ptr [0x10109687]
1001e8ef  8b ce                    mov      ecx, esi
1001e8f1  c1 e9 18                 shr      ecx, 0x18
1001e8f4  c1 e6 08                 shl      esi, 8
1001e8f7  33 c8                    xor      ecx, eax
1001e8f9  0f b6 c9                 movzx    ecx, cl
1001e8fc  33 34 8d 00 97 10 10     xor      esi, dword ptr [ecx*4 + 0x10109700]
1001e903  0f be 05 88 96 10 10     movsx    eax, byte ptr [0x10109688]
1001e90a  8b ce                    mov      ecx, esi
1001e90c  c1 e9 18                 shr      ecx, 0x18
1001e90f  c1 e6 08                 shl      esi, 8
1001e912  33 cb                    xor      ecx, ebx
1001e914  0f b6 c9                 movzx    ecx, cl
1001e917  33 34 8d 00 97 10 10     xor      esi, dword ptr [ecx*4 + 0x10109700]
1001e91e  0f be 1d 89 96 10 10     movsx    ebx, byte ptr [0x10109689]
1001e925  8b ce                    mov      ecx, esi
1001e927  c1 e9 18                 shr      ecx, 0x18
1001e92a  c1 e6 08                 shl      esi, 8
1001e92d  33 ca                    xor      ecx, edx
1001e92f  0f b6 c9                 movzx    ecx, cl
1001e932  33 34 8d 00 97 10 10     xor      esi, dword ptr [ecx*4 + 0x10109700]
1001e939  0f be 15 8a 96 10 10     movsx    edx, byte ptr [0x1010968a]
1001e940  8b ce                    mov      ecx, esi
1001e942  c1 e9 18                 shr      ecx, 0x18
1001e945  c1 e6 08                 shl      esi, 8
1001e948  33 cf                    xor      ecx, edi
1001e94a  0f b6 c9                 movzx    ecx, cl
1001e94d  33 34 8d 00 97 10 10     xor      esi, dword ptr [ecx*4 + 0x10109700]
1001e954  0f be 3d 8b 96 10 10     movsx    edi, byte ptr [0x1010968b]
1001e95b  8b ce                    mov      ecx, esi
1001e95d  c1 e9 18                 shr      ecx, 0x18
1001e960  c1 e6 08                 shl      esi, 8
1001e963  33 c8                    xor      ecx, eax
1001e965  0f b6 c9                 movzx    ecx, cl
1001e968  33 34 8d 00 97 10 10     xor      esi, dword ptr [ecx*4 + 0x10109700]
1001e96f  0f be 05 8c 96 10 10     movsx    eax, byte ptr [0x1010968c]
1001e976  8b ce                    mov      ecx, esi
1001e978  c1 e9 18                 shr      ecx, 0x18
1001e97b  c1 e6 08                 shl      esi, 8
1001e97e  33 cb                    xor      ecx, ebx
1001e980  0f b6 c9                 movzx    ecx, cl
1001e983  33 34 8d 00 97 10 10     xor      esi, dword ptr [ecx*4 + 0x10109700]
1001e98a  0f be 1d 8d 96 10 10     movsx    ebx, byte ptr [0x1010968d]
1001e991  8b ce                    mov      ecx, esi
1001e993  c1 e9 18                 shr      ecx, 0x18
1001e996  c1 e6 08                 shl      esi, 8
1001e999  33 ca                    xor      ecx, edx
1001e99b  0f b6 c9                 movzx    ecx, cl
1001e99e  33 34 8d 00 97 10 10     xor      esi, dword ptr [ecx*4 + 0x10109700]
1001e9a5  0f be 0d 8e 96 10 10     movsx    ecx, byte ptr [0x1010968e]
1001e9ac  8b d6                    mov      edx, esi
1001e9ae  c1 ea 18                 shr      edx, 0x18
1001e9b1  c1 e6 08                 shl      esi, 8
1001e9b4  33 d7                    xor      edx, edi
1001e9b6  0f b6 d2                 movzx    edx, dl
1001e9b9  33 34 95 00 97 10 10     xor      esi, dword ptr [edx*4 + 0x10109700]
1001e9c0  8b d6                    mov      edx, esi
1001e9c2  c1 ea 18                 shr      edx, 0x18
1001e9c5  c1 e6 08                 shl      esi, 8
1001e9c8  33 d0                    xor      edx, eax
1001e9ca  0f b6 d2                 movzx    edx, dl
1001e9cd  33 34 95 00 97 10 10     xor      esi, dword ptr [edx*4 + 0x10109700]
1001e9d4  8b d6                    mov      edx, esi
1001e9d6  c1 ea 18                 shr      edx, 0x18
1001e9d9  c1 e6 08                 shl      esi, 8
1001e9dc  33 d3                    xor      edx, ebx
1001e9de  0f b6 d2                 movzx    edx, dl
1001e9e1  8b c6                    mov      eax, esi
1001e9e3  33 04 95 00 97 10 10     xor      eax, dword ptr [edx*4 + 0x10109700]
1001e9ea  0f be 15 8f 96 10 10     movsx    edx, byte ptr [0x1010968f]
1001e9f1  8b d8                    mov      ebx, eax
1001e9f3  c1 eb 18                 shr      ebx, 0x18
1001e9f6  c1 e0 08                 shl      eax, 8
1001e9f9  33 d9                    xor      ebx, ecx
1001e9fb  0f be 35 90 96 10 10     movsx    esi, byte ptr [0x10109690]
1001ea02  0f b6 db                 movzx    ebx, bl
1001ea05  0f be 3d 91 96 10 10     movsx    edi, byte ptr [0x10109691]
1001ea0c  33 04 9d 00 97 10 10     xor      eax, dword ptr [ebx*4 + 0x10109700]
1001ea13  0f be 1d 92 96 10 10     movsx    ebx, byte ptr [0x10109692]
1001ea1a  8b c8                    mov      ecx, eax
1001ea1c  c1 e9 18                 shr      ecx, 0x18
1001ea1f  c1 e0 08                 shl      eax, 8
1001ea22  33 ca                    xor      ecx, edx
1001ea24  83 c4 f0                 add      esp, -0x10
1001ea27  0f b6 c9                 movzx    ecx, cl
1001ea2a  33 04 8d 00 97 10 10     xor      eax, dword ptr [ecx*4 + 0x10109700]
1001ea31  0f be 15 93 96 10 10     movsx    edx, byte ptr [0x10109693]
1001ea38  8b c8                    mov      ecx, eax
1001ea3a  c1 e9 18                 shr      ecx, 0x18
1001ea3d  c1 e0 08                 shl      eax, 8
1001ea40  33 ce                    xor      ecx, esi
1001ea42  0f b6 c9                 movzx    ecx, cl
1001ea45  33 04 8d 00 97 10 10     xor      eax, dword ptr [ecx*4 + 0x10109700]
1001ea4c  8d b5 7c ff ff ff        lea      esi, [ebp - 0x84]
1001ea52  8b c8                    mov      ecx, eax
1001ea54  c1 e9 18                 shr      ecx, 0x18
1001ea57  c1 e0 08                 shl      eax, 8
1001ea5a  33 cf                    xor      ecx, edi
1001ea5c  0f b6 c9                 movzx    ecx, cl
1001ea5f  33 04 8d 00 97 10 10     xor      eax, dword ptr [ecx*4 + 0x10109700]
1001ea66  8b f8                    mov      edi, eax
1001ea68  c1 ef 18                 shr      edi, 0x18
1001ea6b  c1 e0 08                 shl      eax, 8
1001ea6e  33 fb                    xor      edi, ebx
1001ea70  8b df                    mov      ebx, edi
1001ea72  0f b6 db                 movzx    ebx, bl
1001ea75  33 04 9d 00 97 10 10     xor      eax, dword ptr [ebx*4 + 0x10109700]
1001ea7c  8b d8                    mov      ebx, eax
1001ea7e  c1 eb 18                 shr      ebx, 0x18
1001ea81  c1 e0 08                 shl      eax, 8
1001ea84  33 da                    xor      ebx, edx
1001ea86  0f b6 db                 movzx    ebx, bl
1001ea89  33 04 9d 00 97 10 10     xor      eax, dword ptr [ebx*4 + 0x10109700]
1001ea90  40                       inc      eax
1001ea91  89 44 24 08              mov      dword ptr [esp + 8], eax
1001ea95  c7 44 24 04 c0 85 18 10  mov      dword ptr [esp + 4], 0x101885c0
1001ea9d  89 34 24                 mov      dword ptr [esp], esi
1001eaa0  e8 0f 85 0d 00           call     0x100f6fb4
1001eaa5  33 c9                    xor      ecx, ecx
1001eaa7  83 c4 10                 add      esp, 0x10
1001eaaa  8a 85 7c ff ff ff        mov      al, byte ptr [ebp - 0x84]
1001eab0  84 c0                    test     al, al
1001eab2  74 25                    je       0x1001ead9
1001eab4  8a 85 7c ff ff ff        mov      al, byte ptr [ebp - 0x84]
1001eaba  8d b6 00 00 00 00        lea      esi, [esi]
1001eac0  8d 95 fc fe ff ff        lea      edx, [ebp - 0x104]
1001eac6  3a 04 11                 cmp      al, byte ptr [ecx + edx]
1001eac9  75 33                    jne      0x1001eafe
1001eacb  41                       inc      ecx
1001eacc  8d 95 7c ff ff ff        lea      edx, [ebp - 0x84]
1001ead2  8a 04 11                 mov      al, byte ptr [ecx + edx]
1001ead5  84 c0                    test     al, al
1001ead7  75 e7                    jne      0x1001eac0
1001ead9  b8 01 00 00 00           mov      eax, 1
1001eade  8b 1c 24                 mov      ebx, dword ptr [esp]
1001eae1  8b 74 24 04              mov      esi, dword ptr [esp + 4]
1001eae5  8b 7c 24 08              mov      edi, dword ptr [esp + 8]
1001eae9  8b e5                    mov      esp, ebp
1001eaeb  5d                       pop      ebp
1001eaec  c3                       ret      
1001eaed  33 c0                    xor      eax, eax
1001eaef  8b 1c 24                 mov      ebx, dword ptr [esp]
1001eaf2  8b 74 24 04              mov      esi, dword ptr [esp + 4]
1001eaf6  8b 7c 24 08              mov      edi, dword ptr [esp + 8]
1001eafa  8b e5                    mov      esp, ebp
1001eafc  5d                       pop      ebp
1001eafd  c3                       ret      
1001eafe  33 c0                    xor      eax, eax
1001eb00  8b 1c 24                 mov      ebx, dword ptr [esp]
1001eb03  8b 74 24 04              mov      esi, dword ptr [esp + 4]
1001eb07  8b 7c 24 08              mov      edi, dword ptr [esp + 8]
1001eb0b  8b e5                    mov      esp, ebp
1001eb0d  5d                       pop      ebp
1001eb0e  c3                       ret      
1001eb0f  90                       nop      
