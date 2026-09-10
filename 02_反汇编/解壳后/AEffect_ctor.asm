; ======================================================================
; AEffect 构造
; RVA 0x13a60 .. 0x13e40   VA 0x10013a60 .. 0x10013e40   (992 bytes)
; ======================================================================

10013a60  55                       push     ebp
10013a61  8b ec                    mov      ebp, esp
10013a63  6a ff                    push     -1
10013a65  68 30 3e 01 10           push     0x10013e30
10013a6a  64 a1 00 00 00 00        mov      eax, dword ptr fs:[0]
10013a70  50                       push     eax
10013a71  64 89 25 00 00 00 00     mov      dword ptr fs:[0], esp
10013a78  81 ec 40 02 00 00        sub      esp, 0x240
10013a7e  89 7c 24 08              mov      dword ptr [esp + 8], edi
10013a82  89 74 24 04              mov      dword ptr [esp + 4], esi
10013a86  89 1c 24                 mov      dword ptr [esp], ebx
10013a89  89 65 f0                 mov      dword ptr [ebp - 0x10], esp
10013a8c  8b c1                    mov      eax, ecx
10013a8e  8b 55 08                 mov      edx, dword ptr [ebp + 8]
10013a91  83 c4 f4                 add      esp, -0xc
10013a94  89 85 d4 fd ff ff        mov      dword ptr [ebp - 0x22c], eax
10013a9a  89 55 e4                 mov      dword ptr [ebp - 0x1c], edx
10013a9d  8b c8                    mov      ecx, eax
10013a9f  c7 44 24 08 92 00 00 00  mov      dword ptr [esp + 8], 0x92
10013aa7  89 14 24                 mov      dword ptr [esp], edx
10013aaa  c7 44 24 04 14 00 00 00  mov      dword ptr [esp + 4], 0x14
10013ab2  e8 19 a2 0c 00           call     0x100ddcd0
10013ab7  c7 45 fc 00 00 00 00     mov      dword ptr [ebp - 4], 0
10013abe  8b 8d d4 fd ff ff        mov      ecx, dword ptr [ebp - 0x22c]
10013ac4  8b 85 d4 fd ff ff        mov      eax, dword ptr [ebp - 0x22c]
10013aca  81 c1 64 06 00 00        add      ecx, 0x664
10013ad0  c7 00 c0 3a 10 10        mov      dword ptr [eax], 0x10103ac0
10013ad6  57                       push     edi
10013ad7  c7 04 24 00 00 00 00     mov      dword ptr [esp], 0
10013ade  e8 ed 54 03 00           call     0x10048fd0
10013ae3  c7 45 fc 01 00 00 00     mov      dword ptr [ebp - 4], 1
10013aea  e8 a1 32 01 00           call     0x10026d90
10013aef  e8 5c 33 01 00           call     0x10026e50
10013af4  83 c4 f8                 add      esp, -8
10013af7  c6 04 24 01              mov      byte ptr [esp], 1
10013afb  e8 d0 45 01 00           call     0x100280d0
10013b00  8b b5 d4 fd ff ff        mov      esi, dword ptr [ebp - 0x22c]
10013b06  bf e0 78 18 10           mov      edi, 0x101878e0
10013b0b  81 c6 d0 00 00 00        add      esi, 0xd0
10013b11  83 c4 08                 add      esp, 8
10013b14  8a 17                    mov      dl, byte ptr [edi]
10013b16  47                       inc      edi
10013b17  88 16                    mov      byte ptr [esi], dl
10013b19  46                       inc      esi
10013b1a  84 d2                    test     dl, dl
10013b1c  75 f6                    jne      0x10013b14
10013b1e  8b 85 d4 fd ff ff        mov      eax, dword ptr [ebp - 0x22c]
10013b24  32 d2                    xor      dl, dl
10013b26  b6 01                    mov      dh, 1
10013b28  88 90 79 06 00 00        mov      byte ptr [eax + 0x679], dl
10013b2e  c7 80 74 06 00 00 ff ff ff ff mov      dword ptr [eax + 0x674], 0xffffffff
10013b38  88 90 3d 06 00 00        mov      byte ptr [eax + 0x63d], dl
10013b3e  88 90 7a 06 00 00        mov      byte ptr [eax + 0x67a], dl
10013b44  88 b0 78 06 00 00        mov      byte ptr [eax + 0x678], dh
10013b4a  88 b0 3e 06 00 00        mov      byte ptr [eax + 0x63e], dh
10013b50  8b 8d d4 fd ff ff        mov      ecx, dword ptr [ebp - 0x22c]
10013b56  8b 5d e4                 mov      ebx, dword ptr [ebp - 0x1c]
10013b59  88 91 47 06 00 00        mov      byte ptr [ecx + 0x647], dl
10013b5f  88 b0 7b 06 00 00        mov      byte ptr [eax + 0x67b], dh
10013b65  85 db                    test     ebx, ebx
10013b67  0f 84 a2 00 00 00        je       0x10013c0f
10013b6d  8b 8d d4 fd ff ff        mov      ecx, dword ptr [ebp - 0x22c]
10013b73  57                       push     edi
10013b74  8b 11                    mov      edx, dword ptr [ecx]
10013b76  c6 04 24 01              mov      byte ptr [esp], 1
10013b7a  8b 82 84 01 00 00        mov      eax, dword ptr [edx + 0x184]
10013b80  ff d0                    call     eax
10013b82  8b 8d d4 fd ff ff        mov      ecx, dword ptr [ebp - 0x22c]
10013b88  57                       push     edi
10013b89  8b 11                    mov      edx, dword ptr [ecx]
10013b8b  c7 04 24 00 00 00 00     mov      dword ptr [esp], 0
10013b92  8b 42 60                 mov      eax, dword ptr [edx + 0x60]
10013b95  ff d0                    call     eax
10013b97  8b 8d d4 fd ff ff        mov      ecx, dword ptr [ebp - 0x22c]
10013b9d  57                       push     edi
10013b9e  8b 11                    mov      edx, dword ptr [ecx]
10013ba0  c7 04 24 0c 00 00 00     mov      dword ptr [esp], 0xc
10013ba7  8b 42 64                 mov      eax, dword ptr [edx + 0x64]
10013baa  ff d0                    call     eax
10013bac  8b 8d d4 fd ff ff        mov      ecx, dword ptr [ebp - 0x22c]
10013bb2  57                       push     edi
10013bb3  8b 11                    mov      edx, dword ptr [ecx]
10013bb5  c6 04 24 01              mov      byte ptr [esp], 1
10013bb9  8b 42 74                 mov      eax, dword ptr [edx + 0x74]
10013bbc  ff d0                    call     eax
10013bbe  8b 8d d4 fd ff ff        mov      ecx, dword ptr [ebp - 0x22c]
10013bc4  57                       push     edi
10013bc5  8b 11                    mov      edx, dword ptr [ecx]
10013bc7  c6 04 24 00              mov      byte ptr [esp], 0
10013bcb  8b 42 68                 mov      eax, dword ptr [edx + 0x68]
10013bce  ff d0                    call     eax
10013bd0  8b 8d d4 fd ff ff        mov      ecx, dword ptr [ebp - 0x22c]
10013bd6  57                       push     edi
10013bd7  8b 11                    mov      edx, dword ptr [ecx]
10013bd9  c6 04 24 00              mov      byte ptr [esp], 0
10013bdd  8b 42 6c                 mov      eax, dword ptr [edx + 0x6c]
10013be0  ff d0                    call     eax
10013be2  8b 8d d4 fd ff ff        mov      ecx, dword ptr [ebp - 0x22c]
10013be8  57                       push     edi
10013be9  8b 11                    mov      edx, dword ptr [ecx]
10013beb  c6 04 24 01              mov      byte ptr [esp], 1
10013bef  8b 42 78                 mov      eax, dword ptr [edx + 0x78]
10013bf2  ff d0                    call     eax
10013bf4  8b 8d d4 fd ff ff        mov      ecx, dword ptr [ebp - 0x22c]
10013bfa  57                       push     edi
10013bfb  8b 11                    mov      edx, dword ptr [ecx]
10013bfd  c7 04 24 32 34 4d 4c     mov      dword ptr [esp], 0x4c4d3432
10013c04  8b 42 5c                 mov      eax, dword ptr [edx + 0x5c]
10013c07  ff d0                    call     eax
10013c09  8b 85 d4 fd ff ff        mov      eax, dword ptr [ebp - 0x22c]
10013c0f  33 d2                    xor      edx, edx
10013c11  83 c4 f8                 add      esp, -8
10013c14  89 95 d8 fd ff ff        mov      dword ptr [ebp - 0x228], edx
10013c1a  c7 04 24 10 00 00 00     mov      dword ptr [esp], 0x10
10013c21  89 90 ec 01 00 00        mov      dword ptr [eax + 0x1ec], edx
10013c27  e8 da 33 0e 00           call     0x100f7006
10013c2c  83 c4 08                 add      esp, 8
10013c2f  85 c0                    test     eax, eax
10013c31  89 85 dc fd ff ff        mov      dword ptr [ebp - 0x224], eax
10013c37  0f 84 e0 01 00 00        je       0x10013e1d
10013c3d  c7 85 d8 fd ff ff 01 00 00 00 mov      dword ptr [ebp - 0x228], 1
10013c47  c7 45 fc 02 00 00 00     mov      dword ptr [ebp - 4], 2
10013c4e  57                       push     edi
10013c4f  8b 8d dc fd ff ff        mov      ecx, dword ptr [ebp - 0x224]
10013c55  c7 04 24 e0 78 18 10     mov      dword ptr [esp], 0x101878e0
10013c5c  e8 df ad 04 00           call     0x1005ea40
10013c61  c7 85 d8 fd ff ff 00 00 00 00 mov      dword ptr [ebp - 0x228], 0
10013c6b  8b 85 dc fd ff ff        mov      eax, dword ptr [ebp - 0x224]
10013c71  8b 8d d4 fd ff ff        mov      ecx, dword ptr [ebp - 0x22c]
10013c77  89 81 fc 01 00 00        mov      dword ptr [ecx + 0x1fc], eax
10013c7d  c7 45 fc 01 00 00 00     mov      dword ptr [ebp - 4], 1
10013c84  e8 47 3c 00 00           call     0x100178d0
10013c89  8b 8d d4 fd ff ff        mov      ecx, dword ptr [ebp - 0x22c]
10013c8f  e8 2c 0a 00 00           call     0x100146c0
10013c94  8b 85 d4 fd ff ff        mov      eax, dword ptr [ebp - 0x22c]
10013c9a  33 db                    xor      ebx, ebx
10013c9c  c7 40 18 00 00 00 00     mov      dword ptr [eax + 0x18], 0
10013ca3  83 c4 f0                 add      esp, -0x10
10013ca6  8d 85 e0 fd ff ff        lea      eax, [ebp - 0x220]
10013cac  8b 95 d4 fd ff ff        mov      edx, dword ptr [ebp - 0x22c]
10013cb2  8b b4 9a 88 01 00 00     mov      esi, dword ptr [edx + ebx*4 + 0x188]
10013cb9  43                       inc      ebx
10013cba  89 5c 24 08              mov      dword ptr [esp + 8], ebx
10013cbe  c7 44 24 04 60 64 18 10  mov      dword ptr [esp + 4], 0x10186460
10013cc6  89 04 24                 mov      dword ptr [esp], eax
10013cc9  e8 e6 32 0e 00           call     0x100f6fb4
10013cce  83 c4 08                 add      esp, 8
10013cd1  8d 85 e0 fd ff ff        lea      eax, [ebp - 0x220]
10013cd7  8b 8d d4 fd ff ff        mov      ecx, dword ptr [ebp - 0x22c]
10013cdd  89 44 24 04              mov      dword ptr [esp + 4], eax
10013ce1  89 34 24                 mov      dword ptr [esp], esi
10013ce4  e8 37 7e 0d 00           call     0x100ebb20
10013ce9  57                       push     edi
10013cea  8b 16                    mov      edx, dword ptr [esi]
10013cec  8b ce                    mov      ecx, esi
10013cee  8b 82 14 01 00 00        mov      eax, dword ptr [edx + 0x114]
10013cf4  c7 04 24 00 00 00 00     mov      dword ptr [esp], 0
10013cfb  ff d0                    call     eax
10013cfd  85 c0                    test     eax, eax
10013cff  74 07                    je       0x10013d08
10013d01  c7 40 0c 40 00 00 00     mov      dword ptr [eax + 0xc], 0x40
10013d08  33 ff                    xor      edi, edi
10013d0a  8b 16                    mov      edx, dword ptr [esi]
10013d0c  8b ce                    mov      ecx, esi
10013d0e  8b 42 70                 mov      eax, dword ptr [edx + 0x70]
10013d11  ff d0                    call     eax
10013d13  83 c4 f0                 add      esp, -0x10
10013d16  47                       inc      edi
10013d17  8d 95 e0 fe ff ff        lea      edx, [ebp - 0x120]
10013d1d  89 7c 24 08              mov      dword ptr [esp + 8], edi
10013d21  c7 44 24 04 a0 63 18 10  mov      dword ptr [esp + 4], 0x101863a0
10013d29  89 14 24                 mov      dword ptr [esp], edx
10013d2c  89 45 e0                 mov      dword ptr [ebp - 0x20], eax
10013d2f  e8 80 32 0e 00           call     0x100f6fb4
10013d34  83 c4 08                 add      esp, 8
10013d37  8b 45 e0                 mov      eax, dword ptr [ebp - 0x20]
10013d3a  8d 95 e0 fe ff ff        lea      edx, [ebp - 0x120]
10013d40  89 04 24                 mov      dword ptr [esp], eax
10013d43  89 54 24 04              mov      dword ptr [esp + 4], edx
10013d47  8b 8d d4 fd ff ff        mov      ecx, dword ptr [ebp - 0x22c]
10013d4d  e8 ce 7d 0d 00           call     0x100ebb20
10013d52  8b 4d e0                 mov      ecx, dword ptr [ebp - 0x20]
10013d55  57                       push     edi
10013d56  8b 11                    mov      edx, dword ptr [ecx]
10013d58  c7 04 24 00 00 00 00     mov      dword ptr [esp], 0
10013d5f  8b 82 14 01 00 00        mov      eax, dword ptr [edx + 0x114]
10013d65  ff d0                    call     eax
10013d67  85 c0                    test     eax, eax
10013d69  74 07                    je       0x10013d72
10013d6b  c7 40 0c 40 00 00 00     mov      dword ptr [eax + 0xc], 0x40
10013d72  83 ff 12                 cmp      edi, 0x12
10013d75  7c 93                    jl       0x10013d0a
10013d77  83 fb 14                 cmp      ebx, 0x14
10013d7a  0f 8c 23 ff ff ff        jl       0x10013ca3
10013d80  8b 85 d4 fd ff ff        mov      eax, dword ptr [ebp - 0x22c]
10013d86  57                       push     edi
10013d87  8b 80 88 01 00 00        mov      eax, dword ptr [eax + 0x188]
10013d8d  8b 8d d4 fd ff ff        mov      ecx, dword ptr [ebp - 0x22c]
10013d93  89 04 24                 mov      dword ptr [esp], eax
10013d96  e8 e5 7a 0d 00           call     0x100eb880
10013d9b  57                       push     edi
10013d9c  8b 8d d4 fd ff ff        mov      ecx, dword ptr [ebp - 0x22c]
10013da2  c7 04 24 00 00 00 00     mov      dword ptr [esp], 0
10013da9  e8 e2 7c 0d 00           call     0x100eba90
10013dae  33 d2                    xor      edx, edx
10013db0  8b 85 d4 fd ff ff        mov      eax, dword ptr [ebp - 0x22c]
10013db6  c6 84 10 50 06 00 00 00  mov      byte ptr [eax + edx + 0x650], 0
10013dbe  42                       inc      edx
10013dbf  83 fa 12                 cmp      edx, 0x12
10013dc2  7c f2                    jl       0x10013db6
10013dc4  c7 45 fc ff ff ff ff     mov      dword ptr [ebp - 4], 0xffffffff
10013dcb  8b 4d f4                 mov      ecx, dword ptr [ebp - 0xc]
10013dce  64 89 0d 00 00 00 00     mov      dword ptr fs:[0], ecx
10013dd5  8b 1c 24                 mov      ebx, dword ptr [esp]
10013dd8  8b 74 24 04              mov      esi, dword ptr [esp + 4]
10013ddc  8b 7c 24 08              mov      edi, dword ptr [esp + 8]
10013de0  8b e5                    mov      esp, ebp
10013de2  5d                       pop      ebp
10013de3  c2 04 00                 ret      4
10013de6  8b 8d d4 fd ff ff        mov      ecx, dword ptr [ebp - 0x22c]
10013dec  81 c1 64 06 00 00        add      ecx, 0x664
10013df2  e8 35 34 0e 00           call     0x100f722c
10013df7  c3                       ret      
10013df8  8b 85 d8 fd ff ff        mov      eax, dword ptr [ebp - 0x228]
10013dfe  83 f8 01                 cmp      eax, 1
10013e01  74 01                    je       0x10013e04
10013e03  c3                       ret      
10013e04  8d 8d dc fd ff ff        lea      ecx, [ebp - 0x224]
10013e0a  e8 05 32 0e 00           call     0x100f7014
10013e0f  eb f2                    jmp      0x10013e03
10013e11  8b 8d d4 fd ff ff        mov      ecx, dword ptr [ebp - 0x22c]
10013e17  e8 e4 93 0c 00           call     0x100dd200
10013e1c  c3                       ret      
10013e1d  33 c0                    xor      eax, eax
10013e1f  e9 4d fe ff ff           jmp      0x10013c71
10013e24  8d b6 00 00 00 00        lea      esi, [esi]
10013e2a  8d bf 00 00 00 00        lea      edi, [edi]
10013e30  b8 78 75 18 10           mov      eax, 0x10187578
10013e35  e9 25 2f 0e 00           jmp      0x100f6d5f
10013e3a  90                       nop      
10013e3b  90                       nop      
10013e3c  90                       nop      
10013e3d  90                       nop      
10013e3e  90                       nop      
10013e3f  90                       nop      
