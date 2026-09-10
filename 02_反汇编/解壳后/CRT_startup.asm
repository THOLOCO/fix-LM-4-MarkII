; ======================================================================
; CRT 启动
; RVA 0xf8559 .. 0xf8659   VA 0x100f8559 .. 0x100f8659   (256 bytes)
; ======================================================================

100f8559  55                       push     ebp
100f855a  8b ec                    mov      ebp, esp
100f855c  53                       push     ebx
100f855d  8b 5d 08                 mov      ebx, dword ptr [ebp + 8]
100f8560  56                       push     esi
100f8561  8b 75 0c                 mov      esi, dword ptr [ebp + 0xc]
100f8564  57                       push     edi
100f8565  8b 7d 10                 mov      edi, dword ptr [ebp + 0x10]
100f8568  85 f6                    test     esi, esi
100f856a  75 09                    jne      0x100f8575
100f856c  83 3d 8c 3c 18 10 00     cmp      dword ptr [0x10183c8c], 0
100f8573  eb 26                    jmp      0x100f859b
100f8575  83 fe 01                 cmp      esi, 1
100f8578  74 05                    je       0x100f857f
100f857a  83 fe 02                 cmp      esi, 2
100f857d  75 22                    jne      0x100f85a1
100f857f  a1 70 43 18 10           mov      eax, dword ptr [0x10184370]
100f8584  85 c0                    test     eax, eax
100f8586  74 09                    je       0x100f8591
100f8588  57                       push     edi
100f8589  56                       push     esi
100f858a  53                       push     ebx
100f858b  ff d0                    call     eax
100f858d  85 c0                    test     eax, eax
100f858f  74 0c                    je       0x100f859d
100f8591  57                       push     edi
100f8592  56                       push     esi
100f8593  53                       push     ebx
100f8594  e8 e7 fe ff ff           call     0x100f8480
100f8599  85 c0                    test     eax, eax
100f859b  75 04                    jne      0x100f85a1
100f859d  33 c0                    xor      eax, eax
100f859f  eb 4e                    jmp      0x100f85ef
100f85a1  57                       push     edi
100f85a2  56                       push     esi
100f85a3  53                       push     ebx
100f85a4  e8 e7 35 f2 ff           call     0x1001bb90
100f85a9  83 fe 01                 cmp      esi, 1
100f85ac  89 45 0c                 mov      dword ptr [ebp + 0xc], eax
100f85af  75 0c                    jne      0x100f85bd
100f85b1  85 c0                    test     eax, eax
100f85b3  75 37                    jne      0x100f85ec
100f85b5  57                       push     edi
100f85b6  50                       push     eax
100f85b7  53                       push     ebx
100f85b8  e8 c3 fe ff ff           call     0x100f8480
100f85bd  85 f6                    test     esi, esi
100f85bf  74 05                    je       0x100f85c6
100f85c1  83 fe 03                 cmp      esi, 3
100f85c4  75 26                    jne      0x100f85ec
100f85c6  57                       push     edi
100f85c7  56                       push     esi
100f85c8  53                       push     ebx
100f85c9  e8 b2 fe ff ff           call     0x100f8480
100f85ce  85 c0                    test     eax, eax
100f85d0  75 03                    jne      0x100f85d5
100f85d2  21 45 0c                 and      dword ptr [ebp + 0xc], eax
100f85d5  83 7d 0c 00              cmp      dword ptr [ebp + 0xc], 0
100f85d9  74 11                    je       0x100f85ec
100f85db  a1 70 43 18 10           mov      eax, dword ptr [0x10184370]
100f85e0  85 c0                    test     eax, eax
100f85e2  74 08                    je       0x100f85ec
100f85e4  57                       push     edi
100f85e5  56                       push     esi
100f85e6  53                       push     ebx
100f85e7  ff d0                    call     eax
100f85e9  89 45 0c                 mov      dword ptr [ebp + 0xc], eax
100f85ec  8b 45 0c                 mov      eax, dword ptr [ebp + 0xc]
100f85ef  5f                       pop      edi
100f85f0  5e                       pop      esi
100f85f1  5b                       pop      ebx
100f85f2  5d                       pop      ebp
100f85f3  c2 0c 00                 ret      0xc
100f85f6  a1 98 3c 18 10           mov      eax, dword ptr [0x10183c98]
100f85fb  83 f8 01                 cmp      eax, 1
100f85fe  74 0d                    je       0x100f860d
100f8600  85 c0                    test     eax, eax
100f8602  75 0e                    jne      0x100f8612
100f8604  83 3d 9c 3c 18 10 01     cmp      dword ptr [0x10183c9c], 1
100f860b  75 05                    jne      0x100f8612
100f860d  e8 79 4d 00 00           call     0x100fd38b
100f8612  ff 74 24 04              push     dword ptr [esp + 4]
100f8616  e8 a9 4d 00 00           call     0x100fd3c4
100f861b  68 ff 00 00 00           push     0xff
100f8620  ff 15 a0 87 10 10        call     dword ptr [0x101087a0]
100f8626  59                       pop      ecx
100f8627  59                       pop      ecx
100f8628  c3                       ret      
100f8629  56                       push     esi
100f862a  e8 76 00 00 00           call     0x100f86a5
100f862f  8b 4c 24 08              mov      ecx, dword ptr [esp + 8]
100f8633  33 f6                    xor      esi, esi
100f8635  89 08                    mov      dword ptr [eax], ecx
100f8637  b8 a8 87 10 10           mov      eax, 0x101087a8
100f863c  3b 08                    cmp      ecx, dword ptr [eax]
100f863e  74 22                    je       0x100f8662
100f8640  83 c0 08                 add      eax, 8
100f8643  46                       inc      esi
100f8644  3d 10 89 10 10           cmp      eax, 0x10108910
100f8649  7c f1                    jl       0x100f863c
100f864b  83 f9 13                 cmp      ecx, 0x13
100f864e  72 22                    jb       0x100f8672
100f8650  83 f9 24                 cmp      ecx, 0x24
100f8653  77 1d                    ja       0x100f8672
