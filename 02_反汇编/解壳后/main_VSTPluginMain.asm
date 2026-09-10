; ======================================================================
; main() —— VST 插件入口 (导出函数)
; RVA 0x1b8e0 .. 0x1bba0   VA 0x1001b8e0 .. 0x1001bba0   (704 bytes)
; ======================================================================

1001b8e0  55                       push     ebp
1001b8e1  8b ec                    mov      ebp, esp
1001b8e3  6a ff                    push     -1
1001b8e5  68 80 bb 01 10           push     0x1001bb80
1001b8ea  64 a1 00 00 00 00        mov      eax, dword ptr fs:[0]
1001b8f0  50                       push     eax
1001b8f1  64 89 25 00 00 00 00     mov      dword ptr fs:[0], esp
1001b8f8  83 ec 54                 sub      esp, 0x54
1001b8fb  89 7c 24 08              mov      dword ptr [esp + 8], edi
1001b8ff  89 74 24 04              mov      dword ptr [esp + 4], esi
1001b903  89 1c 24                 mov      dword ptr [esp], ebx
1001b906  89 65 f0                 mov      dword ptr [ebp - 0x10], esp
1001b909  83 c4 f8                 add      esp, -8
1001b90c  c7 45 d0 00 00 00 00     mov      dword ptr [ebp - 0x30], 0
1001b913  c7 04 24 90 00 00 00     mov      dword ptr [esp], 0x90
1001b91a  e8 e7 b6 0d 00           call     0x100f7006
1001b91f  83 c4 08                 add      esp, 8
1001b922  85 c0                    test     eax, eax
1001b924  89 45 d4                 mov      dword ptr [ebp - 0x2c], eax
1001b927  0f 84 30 02 00 00        je       0x1001bb5d
1001b92d  c7 45 d0 01 00 00 00     mov      dword ptr [ebp - 0x30], 1
1001b934  c7 45 fc 00 00 00 00     mov      dword ptr [ebp - 4], 0
1001b93b  57                       push     edi
1001b93c  8b 4d d4                 mov      ecx, dword ptr [ebp - 0x2c]
1001b93f  c7 04 24 20 81 18 10     mov      dword ptr [esp], 0x10188120
1001b946  e8 a5 2c 00 00           call     0x1001e5f0
1001b94b  c7 45 d0 00 00 00 00     mov      dword ptr [ebp - 0x30], 0
1001b952  8b 5d d4                 mov      ebx, dword ptr [ebp - 0x2c]
1001b955  c7 45 fc ff ff ff ff     mov      dword ptr [ebp - 4], 0xffffffff
1001b95c  8b cb                    mov      ecx, ebx
1001b95e  e8 5d 2d 00 00           call     0x1001e6c0
1001b963  0f be c0                 movsx    eax, al
1001b966  85 c0                    test     eax, eax
1001b968  75 35                    jne      0x1001b99f
1001b96a  8b cb                    mov      ecx, ebx
1001b96c  e8 9f 31 00 00           call     0x1001eb10
1001b971  85 db                    test     ebx, ebx
1001b973  74 0f                    je       0x1001b984
1001b975  57                       push     edi
1001b976  8b cb                    mov      ecx, ebx
1001b978  c7 04 24 01 00 00 00     mov      dword ptr [esp], 1
1001b97f  e8 0c 03 00 00           call     0x1001bc90
1001b984  33 c0                    xor      eax, eax
1001b986  8b 4d f4                 mov      ecx, dword ptr [ebp - 0xc]
1001b989  64 89 0d 00 00 00 00     mov      dword ptr fs:[0], ecx
1001b990  8b 1c 24                 mov      ebx, dword ptr [esp]
1001b993  8b 74 24 04              mov      esi, dword ptr [esp + 4]
1001b997  8b 7c 24 08              mov      edi, dword ptr [esp + 8]
1001b99b  8b e5                    mov      esp, ebp
1001b99d  5d                       pop      ebp
1001b99e  c3                       ret      
1001b99f  83 c4 e8                 add      esp, -0x18
1001b9a2  33 c0                    xor      eax, eax
1001b9a4  c7 44 24 14 00 00 00 00  mov      dword ptr [esp + 0x14], 0
1001b9ac  89 44 24 10              mov      dword ptr [esp + 0x10], eax
1001b9b0  89 44 24 0c              mov      dword ptr [esp + 0xc], eax
1001b9b4  89 44 24 08              mov      dword ptr [esp + 8], eax
1001b9b8  c7 44 24 04 01 00 00 00  mov      dword ptr [esp + 4], 1
1001b9c0  89 04 24                 mov      dword ptr [esp], eax
1001b9c3  8b 55 08                 mov      edx, dword ptr [ebp + 8]
1001b9c6  ff d2                    call     edx
1001b9c8  83 c4 18                 add      esp, 0x18
1001b9cb  8b 55 08                 mov      edx, dword ptr [ebp + 8]
1001b9ce  85 c0                    test     eax, eax
1001b9d0  75 1b                    jne      0x1001b9ed
1001b9d2  33 c0                    xor      eax, eax
1001b9d4  8b 4d f4                 mov      ecx, dword ptr [ebp - 0xc]
1001b9d7  64 89 0d 00 00 00 00     mov      dword ptr fs:[0], ecx
1001b9de  8b 1c 24                 mov      ebx, dword ptr [esp]
1001b9e1  8b 74 24 04              mov      esi, dword ptr [esp + 4]
1001b9e5  8b 7c 24 08              mov      edi, dword ptr [esp + 8]
1001b9e9  8b e5                    mov      esp, ebp
1001b9eb  5d                       pop      ebp
1001b9ec  c3                       ret      
1001b9ed  33 c0                    xor      eax, eax
1001b9ef  83 c4 f8                 add      esp, -8
1001b9f2  89 45 d8                 mov      dword ptr [ebp - 0x28], eax
1001b9f5  c7 04 24 80 06 00 00     mov      dword ptr [esp], 0x680
1001b9fc  a2 44 96 10 10           mov      byte ptr [0x10109644], al
1001ba01  e8 ba e5 02 00           call     0x10049fc0
1001ba06  83 c4 08                 add      esp, 8
1001ba09  85 c0                    test     eax, eax
1001ba0b  89 45 dc                 mov      dword ptr [ebp - 0x24], eax
1001ba0e  8b 55 08                 mov      edx, dword ptr [ebp + 8]
1001ba11  0f 84 3f 01 00 00        je       0x1001bb56
1001ba17  c7 45 d8 01 00 00 00     mov      dword ptr [ebp - 0x28], 1
1001ba1e  c7 45 fc 01 00 00 00     mov      dword ptr [ebp - 4], 1
1001ba25  8b 4d dc                 mov      ecx, dword ptr [ebp - 0x24]
1001ba28  89 4d c8                 mov      dword ptr [ebp - 0x38], ecx
1001ba2b  52                       push     edx
1001ba2c  e8 2f 80 ff ff           call     0x10013a60
1001ba31  c7 45 fc 02 00 00 00     mov      dword ptr [ebp - 4], 2
1001ba38  8b 45 c8                 mov      eax, dword ptr [ebp - 0x38]
1001ba3b  83 c4 f8                 add      esp, -8
1001ba3e  c7 45 e0 00 00 00 00     mov      dword ptr [ebp - 0x20], 0
1001ba45  c7 04 24 38 01 00 00     mov      dword ptr [esp], 0x138
1001ba4c  c7 00 e0 3f 10 10        mov      dword ptr [eax], 0x10103fe0
1001ba52  e8 69 e5 02 00           call     0x10049fc0
1001ba57  83 c4 08                 add      esp, 8
1001ba5a  85 c0                    test     eax, eax
1001ba5c  89 45 e4                 mov      dword ptr [ebp - 0x1c], eax
1001ba5f  0f 84 ea 00 00 00        je       0x1001bb4f
1001ba65  c7 45 e0 01 00 00 00     mov      dword ptr [ebp - 0x20], 1
1001ba6c  c7 45 fc 03 00 00 00     mov      dword ptr [ebp - 4], 3
1001ba73  8b 45 c8                 mov      eax, dword ptr [ebp - 0x38]
1001ba76  8b 4d e4                 mov      ecx, dword ptr [ebp - 0x1c]
1001ba79  50                       push     eax
1001ba7a  e8 71 c0 ff ff           call     0x10017af0
1001ba7f  c7 45 e0 00 00 00 00     mov      dword ptr [ebp - 0x20], 0
1001ba86  8b 45 e4                 mov      eax, dword ptr [ebp - 0x1c]
1001ba89  8b 55 c8                 mov      edx, dword ptr [ebp - 0x38]
1001ba8c  89 42 08                 mov      dword ptr [edx + 8], eax
1001ba8f  c7 45 fc 02 00 00 00     mov      dword ptr [ebp - 4], 2
1001ba96  c7 45 fc 01 00 00 00     mov      dword ptr [ebp - 4], 1
1001ba9d  c7 45 d8 00 00 00 00     mov      dword ptr [ebp - 0x28], 0
1001baa4  8b 4d dc                 mov      ecx, dword ptr [ebp - 0x24]
1001baa7  c7 45 fc ff ff ff ff     mov      dword ptr [ebp - 4], 0xffffffff
1001baae  85 c9                    test     ecx, ecx
1001bab0  0f 84 ae 00 00 00        je       0x1001bb64
1001bab6  a0 44 96 10 10           mov      al, byte ptr [0x10109644]
1001babb  84 c0                    test     al, al
1001babd  74 30                    je       0x1001baef
1001babf  57                       push     edi
1001bac0  8b 11                    mov      edx, dword ptr [ecx]
1001bac2  8b 02                    mov      eax, dword ptr [edx]
1001bac4  c7 04 24 01 00 00 00     mov      dword ptr [esp], 1
1001bacb  ff d0                    call     eax
1001bacd  c6 05 44 96 10 10 00     mov      byte ptr [0x10109644], 0
1001bad4  33 c0                    xor      eax, eax
1001bad6  8b 4d f4                 mov      ecx, dword ptr [ebp - 0xc]
1001bad9  64 89 0d 00 00 00 00     mov      dword ptr fs:[0], ecx
1001bae0  8b 1c 24                 mov      ebx, dword ptr [esp]
1001bae3  8b 74 24 04              mov      esi, dword ptr [esp + 4]
1001bae7  8b 7c 24 08              mov      edi, dword ptr [esp + 8]
1001baeb  8b e5                    mov      esp, ebp
1001baed  5d                       pop      ebp
1001baee  c3                       ret      
1001baef  83 c1 20                 add      ecx, 0x20
1001baf2  8b c1                    mov      eax, ecx
1001baf4  8b 4d f4                 mov      ecx, dword ptr [ebp - 0xc]
1001baf7  64 89 0d 00 00 00 00     mov      dword ptr fs:[0], ecx
1001bafe  8b 1c 24                 mov      ebx, dword ptr [esp]
1001bb01  8b 74 24 04              mov      esi, dword ptr [esp + 4]
1001bb05  8b 7c 24 08              mov      edi, dword ptr [esp + 8]
1001bb09  8b e5                    mov      esp, ebp
1001bb0b  5d                       pop      ebp
1001bb0c  c3                       ret      
1001bb0d  8b 45 d0                 mov      eax, dword ptr [ebp - 0x30]
1001bb10  83 f8 01                 cmp      eax, 1
1001bb13  74 01                    je       0x1001bb16
1001bb15  c3                       ret      
1001bb16  8d 4d d4                 lea      ecx, [ebp - 0x2c]
1001bb19  e8 f6 b4 0d 00           call     0x100f7014
1001bb1e  eb f5                    jmp      0x1001bb15
1001bb20  8b 45 d8                 mov      eax, dword ptr [ebp - 0x28]
1001bb23  83 f8 01                 cmp      eax, 1
1001bb26  74 01                    je       0x1001bb29
1001bb28  c3                       ret      
1001bb29  8d 4d dc                 lea      ecx, [ebp - 0x24]
1001bb2c  e8 ff e4 02 00           call     0x1004a030
1001bb31  eb f5                    jmp      0x1001bb28
1001bb33  8b 4d c8                 mov      ecx, dword ptr [ebp - 0x38]
1001bb36  e8 05 83 ff ff           call     0x10013e40
1001bb3b  c3                       ret      
1001bb3c  8b 45 e0                 mov      eax, dword ptr [ebp - 0x20]
1001bb3f  83 f8 01                 cmp      eax, 1
1001bb42  74 01                    je       0x1001bb45
1001bb44  c3                       ret      
1001bb45  8d 4d e4                 lea      ecx, [ebp - 0x1c]
1001bb48  e8 e3 e4 02 00           call     0x1004a030
1001bb4d  eb f5                    jmp      0x1001bb44
1001bb4f  33 c0                    xor      eax, eax
1001bb51  e9 33 ff ff ff           jmp      0x1001ba89
1001bb56  33 c9                    xor      ecx, ecx
1001bb58  e9 4a ff ff ff           jmp      0x1001baa7
1001bb5d  33 db                    xor      ebx, ebx
1001bb5f  e9 f1 fd ff ff           jmp      0x1001b955
1001bb64  33 c0                    xor      eax, eax
1001bb66  8b 4d f4                 mov      ecx, dword ptr [ebp - 0xc]
1001bb69  64 89 0d 00 00 00 00     mov      dword ptr fs:[0], ecx
1001bb70  8b 1c 24                 mov      ebx, dword ptr [esp]
1001bb73  8b 74 24 04              mov      esi, dword ptr [esp + 4]
1001bb77  8b 7c 24 08              mov      edi, dword ptr [esp + 8]
1001bb7b  8b e5                    mov      esp, ebp
1001bb7d  5d                       pop      ebp
1001bb7e  c3                       ret      
1001bb7f  90                       nop      
1001bb80  b8 a0 80 18 10           mov      eax, 0x101880a0
1001bb85  e9 d5 b1 0d 00           jmp      0x100f6d5f
1001bb8a  90                       nop      
1001bb8b  90                       nop      
1001bb8c  90                       nop      
1001bb8d  90                       nop      
1001bb8e  90                       nop      
1001bb8f  90                       nop      
1001bb90  55                       push     ebp
1001bb91  8b ec                    mov      ebp, esp
1001bb93  8b 45 0c                 mov      eax, dword ptr [ebp + 0xc]
1001bb96  83 f8 01                 cmp      eax, 1
1001bb99  74 0b                    je       0x1001bba6
1001bb9b  b8 01 00 00 00           mov      eax, 1
