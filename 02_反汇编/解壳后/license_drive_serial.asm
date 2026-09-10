; ======================================================================
; 安装校验 —— 卷序列号/注册表
; RVA 0x1ec90 .. 0x1eec0   VA 0x1001ec90 .. 0x1001eec0   (560 bytes)
; ======================================================================

1001ec90  55                       push     ebp
1001ec91  8b ec                    mov      ebp, esp
1001ec93  81 ec 60 03 00 00        sub      esp, 0x360
1001ec99  89 7c 24 08              mov      dword ptr [esp + 8], edi
1001ec9d  89 74 24 04              mov      dword ptr [esp + 4], esi
1001eca1  89 1c 24                 mov      dword ptr [esp], ebx
1001eca4  83 c4 f8                 add      esp, -8
1001eca7  8d 85 e4 fc ff ff        lea      eax, [ebp - 0x31c]
1001ecad  8b d9                    mov      ebx, ecx
1001ecaf  33 f6                    xor      esi, esi
1001ecb1  c7 44 24 04 04 01 00 00  mov      dword ptr [esp + 4], 0x104
1001ecb9  89 04 24                 mov      dword ptr [esp], eax
1001ecbc  ff 15 cc 11 10 10        call     dword ptr [0x101011cc]
1001ecc2  85 c0                    test     eax, eax
1001ecc4  0f 84 d3 01 00 00        je       0x1001ee9d
1001ecca  8a 85 e5 fc ff ff        mov      al, byte ptr [ebp - 0x31b]
1001ecd0  3c 3a                    cmp      al, 0x3a
1001ecd2  0f 84 2a 02 00 00        je       0x1001ef02
1001ecd8  8a a5 e4 fc ff ff        mov      ah, byte ptr [ebp - 0x31c]
1001ecde  80 fc 5c                 cmp      ah, 0x5c
1001ece1  0f 84 c7 01 00 00        je       0x1001eeae
1001ece7  83 c4 e0                 add      esp, -0x20
1001ecea  b8 00 01 00 00           mov      eax, 0x100
1001ecef  8d 95 f4 fe ff ff        lea      edx, [ebp - 0x10c]
1001ecf5  8d 8d f0 fe ff ff        lea      ecx, [ebp - 0x110]
1001ecfb  89 44 24 1c              mov      dword ptr [esp + 0x1c], eax
1001ecff  89 54 24 18              mov      dword ptr [esp + 0x18], edx
1001ed03  89 4c 24 14              mov      dword ptr [esp + 0x14], ecx
1001ed07  8d 95 ec fe ff ff        lea      edx, [ebp - 0x114]
1001ed0d  8d 8d e8 fe ff ff        lea      ecx, [ebp - 0x118]
1001ed13  89 54 24 10              mov      dword ptr [esp + 0x10], edx
1001ed17  89 4c 24 0c              mov      dword ptr [esp + 0xc], ecx
1001ed1b  89 44 24 08              mov      dword ptr [esp + 8], eax
1001ed1f  8d 85 e8 fd ff ff        lea      eax, [ebp - 0x218]
1001ed25  8d 95 e4 fc ff ff        lea      edx, [ebp - 0x31c]
1001ed2b  89 44 24 04              mov      dword ptr [esp + 4], eax
1001ed2f  89 14 24                 mov      dword ptr [esp], edx
1001ed32  ff 15 d0 11 10 10        call     dword ptr [0x101011d0]
1001ed38  c7 85 e8 fe ff ff dc 14 4c 46 mov      dword ptr [ebp - 0x118], 0x464c14dc
1001ed42  90                       nop      
1001ed43  8d 43 02                 lea      eax, [ebx + 2]
1001ed46  bf f8 ff ff ff           mov      edi, 0xfffffff8
1001ed4b  89 45 fc                 mov      dword ptr [ebp - 4], eax
1001ed4e  8b f6                    mov      esi, esi
1001ed50  8b 95 e8 fe ff ff        mov      edx, dword ptr [ebp - 0x118]
1001ed56  b9 0f 00 00 00           mov      ecx, 0xf
1001ed5b  23 ca                    and      ecx, edx
1001ed5d  83 c1 30                 add      ecx, 0x30
1001ed60  0f be c9                 movsx    ecx, cl
1001ed63  8b c1                    mov      eax, ecx
1001ed65  0f be c9                 movsx    ecx, cl
1001ed68  89 45 f8                 mov      dword ptr [ebp - 8], eax
1001ed6b  83 f9 39                 cmp      ecx, 0x39
1001ed6e  7e 09                    jle      0x1001ed79
1001ed70  83 c1 07                 add      ecx, 7
1001ed73  0f be c9                 movsx    ecx, cl
1001ed76  89 4d f8                 mov      dword ptr [ebp - 8], ecx
1001ed79  8d 73 01                 lea      esi, [ebx + 1]
1001ed7c  8b 45 f8                 mov      eax, dword ptr [ebp - 8]
1001ed7f  88 03                    mov      byte ptr [ebx], al
1001ed81  8b c2                    mov      eax, edx
1001ed83  c1 e8 04                 shr      eax, 4
1001ed86  83 e0 0f                 and      eax, 0xf
1001ed89  83 c0 30                 add      eax, 0x30
1001ed8c  0f be c8                 movsx    ecx, al
1001ed8f  0f be d9                 movsx    ebx, cl
1001ed92  83 fb 39                 cmp      ebx, 0x39
1001ed95  7e 08                    jle      0x1001ed9f
1001ed97  83 c3 07                 add      ebx, 7
1001ed9a  8b cb                    mov      ecx, ebx
1001ed9c  0f be c9                 movsx    ecx, cl
1001ed9f  88 0e                    mov      byte ptr [esi], cl
1001eda1  8b c2                    mov      eax, edx
1001eda3  c1 e8 08                 shr      eax, 8
1001eda6  83 e0 0f                 and      eax, 0xf
1001eda9  83 c0 30                 add      eax, 0x30
1001edac  0f be d8                 movsx    ebx, al
1001edaf  8b cb                    mov      ecx, ebx
1001edb1  0f be c9                 movsx    ecx, cl
1001edb4  83 f9 39                 cmp      ecx, 0x39
1001edb7  7e 06                    jle      0x1001edbf
1001edb9  83 c1 07                 add      ecx, 7
1001edbc  0f be d9                 movsx    ebx, cl
1001edbf  88 5e 01                 mov      byte ptr [esi + 1], bl
1001edc2  8b c2                    mov      eax, edx
1001edc4  c1 e8 0c                 shr      eax, 0xc
1001edc7  83 e0 0f                 and      eax, 0xf
1001edca  83 c0 30                 add      eax, 0x30
1001edcd  0f be c8                 movsx    ecx, al
1001edd0  0f be d9                 movsx    ebx, cl
1001edd3  83 fb 39                 cmp      ebx, 0x39
1001edd6  7e 08                    jle      0x1001ede0
1001edd8  83 c3 07                 add      ebx, 7
1001eddb  8b cb                    mov      ecx, ebx
1001eddd  0f be c9                 movsx    ecx, cl
1001ede0  88 4e 02                 mov      byte ptr [esi + 2], cl
1001ede3  8b c2                    mov      eax, edx
1001ede5  c1 e8 10                 shr      eax, 0x10
1001ede8  83 e0 0f                 and      eax, 0xf
1001edeb  83 c0 30                 add      eax, 0x30
1001edee  0f be d8                 movsx    ebx, al
1001edf1  8b cb                    mov      ecx, ebx
1001edf3  0f be c9                 movsx    ecx, cl
1001edf6  83 f9 39                 cmp      ecx, 0x39
1001edf9  7e 06                    jle      0x1001ee01
1001edfb  83 c1 07                 add      ecx, 7
1001edfe  0f be d9                 movsx    ebx, cl
1001ee01  88 5e 03                 mov      byte ptr [esi + 3], bl
1001ee04  8b c2                    mov      eax, edx
1001ee06  c1 e8 14                 shr      eax, 0x14
1001ee09  83 e0 0f                 and      eax, 0xf
1001ee0c  83 c0 30                 add      eax, 0x30
1001ee0f  0f be c8                 movsx    ecx, al
1001ee12  0f be d9                 movsx    ebx, cl
1001ee15  83 fb 39                 cmp      ebx, 0x39
1001ee18  7e 08                    jle      0x1001ee22
1001ee1a  83 c3 07                 add      ebx, 7
1001ee1d  8b cb                    mov      ecx, ebx
1001ee1f  0f be c9                 movsx    ecx, cl
1001ee22  88 4e 04                 mov      byte ptr [esi + 4], cl
1001ee25  8b c2                    mov      eax, edx
1001ee27  c1 e8 18                 shr      eax, 0x18
1001ee2a  83 e0 0f                 and      eax, 0xf
1001ee2d  83 c0 30                 add      eax, 0x30
1001ee30  0f be d8                 movsx    ebx, al
1001ee33  8b cb                    mov      ecx, ebx
1001ee35  0f be c9                 movsx    ecx, cl
1001ee38  83 f9 39                 cmp      ecx, 0x39
1001ee3b  7e 06                    jle      0x1001ee43
1001ee3d  83 c1 07                 add      ecx, 7
1001ee40  0f be d9                 movsx    ebx, cl
1001ee43  c1 ea 1c                 shr      edx, 0x1c
1001ee46  88 5e 05                 mov      byte ptr [esi + 5], bl
1001ee49  83 e2 0f                 and      edx, 0xf
1001ee4c  83 c2 30                 add      edx, 0x30
1001ee4f  0f be d2                 movsx    edx, dl
1001ee52  0f be ca                 movsx    ecx, dl
1001ee55  83 f9 39                 cmp      ecx, 0x39
1001ee58  7e 06                    jle      0x1001ee60
1001ee5a  83 c1 07                 add      ecx, 7
1001ee5d  0f be d1                 movsx    edx, cl
1001ee60  8d 5e 07                 lea      ebx, [esi + 7]
1001ee63  47                       inc      edi
1001ee64  88 56 06                 mov      byte ptr [esi + 6], dl
1001ee67  0f 85 e3 fe ff ff        jne      0x1001ed50
1001ee6d  8b 45 fc                 mov      eax, dword ptr [ebp - 4]
1001ee70  be 01 00 00 00           mov      esi, 1
1001ee75  0f be 10                 movsx    edx, byte ptr [eax]
1001ee78  0f be 48 01              movsx    ecx, byte ptr [eax + 1]
1001ee7c  8d 1c 09                 lea      ebx, [ecx + ecx]
1001ee7f  0f af da                 imul     ebx, edx
1001ee82  8b fa                    mov      edi, edx
1001ee84  0f af ff                 imul     edi, edi
1001ee87  03 fa                    add      edi, edx
1001ee89  66 89 7d f4              mov      word ptr [ebp - 0xc], di
1001ee8d  0f be 55 f5              movsx    edx, byte ptr [ebp - 0xb]
1001ee91  03 d1                    add      edx, ecx
1001ee93  03 d3                    add      edx, ebx
1001ee95  88 50 01                 mov      byte ptr [eax + 1], dl
1001ee98  8a 55 f4                 mov      dl, byte ptr [ebp - 0xc]
1001ee9b  88 10                    mov      byte ptr [eax], dl
1001ee9d  8b c6                    mov      eax, esi
1001ee9f  8b 1c 24                 mov      ebx, dword ptr [esp]
1001eea2  8b 74 24 04              mov      esi, dword ptr [esp + 4]
1001eea6  8b 7c 24 08              mov      edi, dword ptr [esp + 8]
1001eeaa  8b e5                    mov      esp, ebp
1001eeac  5d                       pop      ebp
1001eead  c3                       ret      
1001eeae  3c 5c                    cmp      al, 0x5c
1001eeb0  0f 85 31 fe ff ff        jne      0x1001ece7
1001eeb6  83 c4 f8                 add      esp, -8
1001eeb9  8d 85 e6 fc ff ff        lea      eax, [ebp - 0x31a]
