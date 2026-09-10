; ======================================================================
; 启动加载默认音色库
; RVA 0x13ef0 .. 0x14070   VA 0x10013ef0 .. 0x10014070   (384 bytes)
; ======================================================================

10013ef0  55                       push     ebp
10013ef1  8b ec                    mov      ebp, esp
10013ef3  6a ff                    push     -1
10013ef5  68 60 40 01 10           push     0x10014060
10013efa  64 a1 00 00 00 00        mov      eax, dword ptr fs:[0]
10013f00  50                       push     eax
10013f01  64 89 25 00 00 00 00     mov      dword ptr fs:[0], esp
10013f08  83 ec 40                 sub      esp, 0x40
10013f0b  89 7c 24 08              mov      dword ptr [esp + 8], edi
10013f0f  89 74 24 04              mov      dword ptr [esp + 4], esi
10013f13  89 1c 24                 mov      dword ptr [esp], ebx
10013f16  89 65 f0                 mov      dword ptr [ebp - 0x10], esp
10013f19  8a 81 48 06 00 00        mov      al, byte ptr [ecx + 0x648]
10013f1f  89 4d e8                 mov      dword ptr [ebp - 0x18], ecx
10013f22  84 c0                    test     al, al
10013f24  0f 84 fe 00 00 00        je       0x10014028
10013f2a  8b 11                    mov      edx, dword ptr [ecx]
10013f2c  c6 81 48 06 00 00 00     mov      byte ptr [ecx + 0x648], 0
10013f33  8b 82 98 01 00 00        mov      eax, dword ptr [edx + 0x198]
10013f39  ff d0                    call     eax
10013f3b  8d 4d d8                 lea      ecx, [ebp - 0x28]
10013f3e  50                       push     eax
10013f3f  e8 8c 50 03 00           call     0x10048fd0
10013f44  c7 45 fc 00 00 00 00     mov      dword ptr [ebp - 4], 0
10013f4b  57                       push     edi
10013f4c  8d 4d d8                 lea      ecx, [ebp - 0x28]
10013f4f  c7 04 24 00 79 18 10     mov      dword ptr [esp], 0x10187900
10013f56  e8 95 55 03 00           call     0x100494f0
10013f5b  8d 4d d8                 lea      ecx, [ebp - 0x28]
10013f5e  e8 8d 5e 03 00           call     0x10049df0
10013f63  0f be c0                 movsx    eax, al
10013f66  85 c0                    test     eax, eax
10013f68  0f 84 ab 00 00 00        je       0x10014019
10013f6e  8d 45 d8                 lea      eax, [ebp - 0x28]
10013f71  8b 4d e8                 mov      ecx, dword ptr [ebp - 0x18]
10013f74  50                       push     eax
10013f75  e8 d6 87 0d 00           call     0x100ec750
10013f7a  0f be c0                 movsx    eax, al
10013f7d  85 c0                    test     eax, eax
10013f7f  0f 84 94 00 00 00        je       0x10014019
10013f85  8b 45 e8                 mov      eax, dword ptr [ebp - 0x18]
10013f88  8b 88 e0 01 00 00        mov      ecx, dword ptr [eax + 0x1e0]
10013f8e  85 c9                    test     ecx, ecx
10013f90  0f 84 83 00 00 00        je       0x10014019
10013f96  e8 95 0b 0e 00           call     0x100f4b30
10013f9b  85 c0                    test     eax, eax
10013f9d  74 7a                    je       0x10014019
10013f9f  8b 4d e8                 mov      ecx, dword ptr [ebp - 0x18]
10013fa2  83 c4 f8                 add      esp, -8
10013fa5  8b 11                    mov      edx, dword ptr [ecx]
10013fa7  8d 5d d8                 lea      ebx, [ebp - 0x28]
10013faa  8b 82 20 02 00 00        mov      eax, dword ptr [edx + 0x220]
10013fb0  89 1c 24                 mov      dword ptr [esp], ebx
10013fb3  c6 44 24 04 01           mov      byte ptr [esp + 4], 1
10013fb8  ff d0                    call     eax
10013fba  8b 4d e8                 mov      ecx, dword ptr [ebp - 0x18]
10013fbd  81 c1 6c 01 00 00        add      ecx, 0x16c
10013fc3  8d 45 d8                 lea      eax, [ebp - 0x28]
10013fc6  50                       push     eax
10013fc7  e8 94 52 03 00           call     0x10049260
10013fcc  8b 45 e8                 mov      eax, dword ptr [ebp - 0x18]
10013fcf  8b 88 e0 01 00 00        mov      ecx, dword ptr [eax + 0x1e0]
10013fd5  e8 56 0b 0e 00           call     0x100f4b30
10013fda  85 c0                    test     eax, eax
10013fdc  74 3b                    je       0x10014019
10013fde  57                       push     edi
10013fdf  8d 4d d8                 lea      ecx, [ebp - 0x28]
10013fe2  c7 04 24 e0 61 18 10     mov      dword ptr [esp], 0x101861e0
10013fe9  e8 02 55 03 00           call     0x100494f0
10013fee  8b 45 e8                 mov      eax, dword ptr [ebp - 0x18]
10013ff1  83 c4 f4                 add      esp, -0xc
10013ff4  8b 88 e0 01 00 00        mov      ecx, dword ptr [eax + 0x1e0]
10013ffa  8d 45 d8                 lea      eax, [ebp - 0x28]
10013ffd  c7 44 24 04 01 00 00 00  mov      dword ptr [esp + 4], 1
10014005  89 04 24                 mov      dword ptr [esp], eax
10014008  c6 44 24 08 00           mov      byte ptr [esp + 8], 0
1001400d  e8 be 0d 0e 00           call     0x100f4dd0
10014012  0f be c0                 movsx    eax, al
10014015  85 c0                    test     eax, eax
10014017  74 31                    je       0x1001404a
10014019  c7 45 fc ff ff ff ff     mov      dword ptr [ebp - 4], 0xffffffff
10014020  8d 4d d8                 lea      ecx, [ebp - 0x28]
10014023  e8 08 51 03 00           call     0x10049130
10014028  8b 4d f4                 mov      ecx, dword ptr [ebp - 0xc]
1001402b  64 89 0d 00 00 00 00     mov      dword ptr fs:[0], ecx
10014032  8b 1c 24                 mov      ebx, dword ptr [esp]
10014035  8b 74 24 04              mov      esi, dword ptr [esp + 4]
10014039  8b 7c 24 08              mov      edi, dword ptr [esp + 8]
1001403d  8b e5                    mov      esp, ebp
1001403f  5d                       pop      ebp
10014040  c3                       ret      
10014041  8d 4d d8                 lea      ecx, [ebp - 0x28]
10014044  e8 e7 50 03 00           call     0x10049130
10014049  c3                       ret      
1001404a  8b 45 e8                 mov      eax, dword ptr [ebp - 0x18]
1001404d  8b 80 e0 01 00 00        mov      eax, dword ptr [eax + 0x1e0]
10014053  c6 40 2c 01              mov      byte ptr [eax + 0x2c], 1
10014057  eb c0                    jmp      0x10014019
10014059  8d b4 26 00 00 00 00     lea      esi, [esi]
10014060  b8 d0 75 18 10           mov      eax, 0x101875d0
10014065  e9 f5 2c 0e 00           jmp      0x100f6d5f
1001406a  90                       nop      
1001406b  90                       nop      
1001406c  90                       nop      
1001406d  90                       nop      
1001406e  90                       nop      
1001406f  90                       nop      
