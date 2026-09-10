; ======================================================================
; Bank 解析核心
; RVA 0xee140 .. 0xee560   VA 0x100ee140 .. 0x100ee560   (1056 bytes)
; ======================================================================

100ee140  55                       push     ebp
100ee141  8b ec                    mov      ebp, esp
100ee143  6a ff                    push     -1
100ee145  68 20 e5 0e 10           push     0x100ee520
100ee14a  64 a1 00 00 00 00        mov      eax, dword ptr fs:[0]
100ee150  50                       push     eax
100ee151  64 89 25 00 00 00 00     mov      dword ptr fs:[0], esp
100ee158  81 ec d8 01 00 00        sub      esp, 0x1d8
100ee15e  89 7c 24 08              mov      dword ptr [esp + 8], edi
100ee162  89 74 24 04              mov      dword ptr [esp + 4], esi
100ee166  89 1c 24                 mov      dword ptr [esp], ebx
100ee169  89 65 f0                 mov      dword ptr [ebp - 0x10], esp
100ee16c  8b 55 08                 mov      edx, dword ptr [ebp + 8]
100ee16f  89 4d e8                 mov      dword ptr [ebp - 0x18], ecx
100ee172  8b 1a                    mov      ebx, dword ptr [edx]
100ee174  c7 45 d4 00 00 00 00     mov      dword ptr [ebp - 0x2c], 0
100ee17b  8b 43 10                 mov      eax, dword ptr [ebx + 0x10]
100ee17e  8b ca                    mov      ecx, edx
100ee180  ff d0                    call     eax
100ee182  8b 4d 08                 mov      ecx, dword ptr [ebp + 8]
100ee185  8b d8                    mov      ebx, eax
100ee187  8b 11                    mov      edx, dword ptr [ecx]
100ee189  8b 42 5c                 mov      eax, dword ptr [edx + 0x5c]
100ee18c  8d 55 d4                 lea      edx, [ebp - 0x2c]
100ee18f  52                       push     edx
100ee190  ff d0                    call     eax
100ee192  8b 45 d4                 mov      eax, dword ptr [ebp - 0x2c]
100ee195  3d 32 34 4d 4c           cmp      eax, 0x4c4d3432
100ee19a  74 1d                    je       0x100ee1b9
100ee19c  74 1b                    je       0x100ee1b9
100ee19e  8b 4d f4                 mov      ecx, dword ptr [ebp - 0xc]
100ee1a1  64 89 0d 00 00 00 00     mov      dword ptr fs:[0], ecx
100ee1a8  8b 1c 24                 mov      ebx, dword ptr [esp]
100ee1ab  8b 74 24 04              mov      esi, dword ptr [esp + 4]
100ee1af  8b 7c 24 08              mov      edi, dword ptr [esp + 8]
100ee1b3  8b e5                    mov      esp, ebp
100ee1b5  5d                       pop      ebp
100ee1b6  c2 04 00                 ret      4
100ee1b9  8b 4d 08                 mov      ecx, dword ptr [ebp + 8]
100ee1bc  57                       push     edi
100ee1bd  8b 11                    mov      edx, dword ptr [ecx]
100ee1bf  8d 75 d8                 lea      esi, [ebp - 0x28]
100ee1c2  8b 42 5c                 mov      eax, dword ptr [edx + 0x5c]
100ee1c5  89 34 24                 mov      dword ptr [esp], esi
100ee1c8  ff d0                    call     eax
100ee1ca  8b 4d 08                 mov      ecx, dword ptr [ebp + 8]
100ee1cd  8b 11                    mov      edx, dword ptr [ecx]
100ee1cf  8d 75 dc                 lea      esi, [ebp - 0x24]
100ee1d2  8b 42 5c                 mov      eax, dword ptr [edx + 0x5c]
100ee1d5  56                       push     esi
100ee1d6  ff d0                    call     eax
100ee1d8  8b 45 dc                 mov      eax, dword ptr [ebp - 0x24]
100ee1db  3d 09 10 00 00           cmp      eax, 0x1009
100ee1e0  7d 1b                    jge      0x100ee1fd
100ee1e2  8b 4d f4                 mov      ecx, dword ptr [ebp - 0xc]
100ee1e5  64 89 0d 00 00 00 00     mov      dword ptr fs:[0], ecx
100ee1ec  8b 1c 24                 mov      ebx, dword ptr [esp]
100ee1ef  8b 74 24 04              mov      esi, dword ptr [esp + 4]
100ee1f3  8b 7c 24 08              mov      edi, dword ptr [esp + 8]
100ee1f7  8b e5                    mov      esp, ebp
100ee1f9  5d                       pop      ebp
100ee1fa  c2 04 00                 ret      4
100ee1fd  8b 4d 08                 mov      ecx, dword ptr [ebp + 8]
100ee200  57                       push     edi
100ee201  8b 11                    mov      edx, dword ptr [ecx]
100ee203  8d 75 d4                 lea      esi, [ebp - 0x2c]
100ee206  8b 42 5c                 mov      eax, dword ptr [edx + 0x5c]
100ee209  89 34 24                 mov      dword ptr [esp], esi
100ee20c  ff d0                    call     eax
100ee20e  8b 4d 08                 mov      ecx, dword ptr [ebp + 8]
100ee211  57                       push     edi
100ee212  8b 11                    mov      edx, dword ptr [ecx]
100ee214  8d 75 e0                 lea      esi, [ebp - 0x20]
100ee217  8b 42 5c                 mov      eax, dword ptr [edx + 0x5c]
100ee21a  89 34 24                 mov      dword ptr [esp], esi
100ee21d  ff d0                    call     eax
100ee21f  8b 4d 08                 mov      ecx, dword ptr [ebp + 8]
100ee222  57                       push     edi
100ee223  8b 11                    mov      edx, dword ptr [ecx]
100ee225  8d 75 d4                 lea      esi, [ebp - 0x2c]
100ee228  8b 42 5c                 mov      eax, dword ptr [edx + 0x5c]
100ee22b  89 34 24                 mov      dword ptr [esp], esi
100ee22e  ff d0                    call     eax
100ee230  8b 4d 08                 mov      ecx, dword ptr [ebp + 8]
100ee233  57                       push     edi
100ee234  8b 11                    mov      edx, dword ptr [ecx]
100ee236  8d 75 d4                 lea      esi, [ebp - 0x2c]
100ee239  8b 42 5c                 mov      eax, dword ptr [edx + 0x5c]
100ee23c  89 34 24                 mov      dword ptr [esp], esi
100ee23f  ff d0                    call     eax
100ee241  8b 4d 08                 mov      ecx, dword ptr [ebp + 8]
100ee244  57                       push     edi
100ee245  8b 11                    mov      edx, dword ptr [ecx]
100ee247  8d 75 d4                 lea      esi, [ebp - 0x2c]
100ee24a  8b 42 5c                 mov      eax, dword ptr [edx + 0x5c]
100ee24d  89 34 24                 mov      dword ptr [esp], esi
100ee250  ff d0                    call     eax
100ee252  8b 4d 08                 mov      ecx, dword ptr [ebp + 8]
100ee255  57                       push     edi
100ee256  8b 11                    mov      edx, dword ptr [ecx]
100ee258  8d 75 d4                 lea      esi, [ebp - 0x2c]
100ee25b  8b 42 5c                 mov      eax, dword ptr [edx + 0x5c]
100ee25e  89 34 24                 mov      dword ptr [esp], esi
100ee261  ff d0                    call     eax
100ee263  8b 4d 08                 mov      ecx, dword ptr [ebp + 8]
100ee266  57                       push     edi
100ee267  8b 11                    mov      edx, dword ptr [ecx]
100ee269  8d 75 d4                 lea      esi, [ebp - 0x2c]
100ee26c  8b 42 5c                 mov      eax, dword ptr [edx + 0x5c]
100ee26f  89 34 24                 mov      dword ptr [esp], esi
100ee272  ff d0                    call     eax
100ee274  8b 4d 08                 mov      ecx, dword ptr [ebp + 8]
100ee277  57                       push     edi
100ee278  8b 11                    mov      edx, dword ptr [ecx]
100ee27a  8d 75 d4                 lea      esi, [ebp - 0x2c]
100ee27d  8b 42 5c                 mov      eax, dword ptr [edx + 0x5c]
100ee280  89 34 24                 mov      dword ptr [esp], esi
100ee283  ff d0                    call     eax
100ee285  8b 4d 08                 mov      ecx, dword ptr [ebp + 8]
100ee288  57                       push     edi
100ee289  8b 11                    mov      edx, dword ptr [ecx]
100ee28b  8d 75 d4                 lea      esi, [ebp - 0x2c]
100ee28e  8b 42 5c                 mov      eax, dword ptr [edx + 0x5c]
100ee291  89 34 24                 mov      dword ptr [esp], esi
100ee294  ff d0                    call     eax
100ee296  8b 4d 08                 mov      ecx, dword ptr [ebp + 8]
100ee299  57                       push     edi
100ee29a  8b 11                    mov      edx, dword ptr [ecx]
100ee29c  8d 75 d4                 lea      esi, [ebp - 0x2c]
100ee29f  8b 42 5c                 mov      eax, dword ptr [edx + 0x5c]
100ee2a2  89 34 24                 mov      dword ptr [esp], esi
100ee2a5  ff d0                    call     eax
100ee2a7  8b 4d 08                 mov      ecx, dword ptr [ebp + 8]
100ee2aa  57                       push     edi
100ee2ab  8b 11                    mov      edx, dword ptr [ecx]
100ee2ad  8d 75 d4                 lea      esi, [ebp - 0x2c]
100ee2b0  8b 42 5c                 mov      eax, dword ptr [edx + 0x5c]
100ee2b3  89 34 24                 mov      dword ptr [esp], esi
100ee2b6  ff d0                    call     eax
100ee2b8  8b 4d 08                 mov      ecx, dword ptr [ebp + 8]
100ee2bb  57                       push     edi
100ee2bc  8b 11                    mov      edx, dword ptr [ecx]
100ee2be  8d 75 e4                 lea      esi, [ebp - 0x1c]
100ee2c1  8b 42 5c                 mov      eax, dword ptr [edx + 0x5c]
100ee2c4  89 34 24                 mov      dword ptr [esp], esi
100ee2c7  ff d0                    call     eax
100ee2c9  8b 4d 08                 mov      ecx, dword ptr [ebp + 8]
100ee2cc  57                       push     edi
100ee2cd  8b 11                    mov      edx, dword ptr [ecx]
100ee2cf  8d 75 d4                 lea      esi, [ebp - 0x2c]
100ee2d2  8b 42 5c                 mov      eax, dword ptr [edx + 0x5c]
100ee2d5  89 34 24                 mov      dword ptr [esp], esi
100ee2d8  ff d0                    call     eax
100ee2da  8b 4d 08                 mov      ecx, dword ptr [ebp + 8]
100ee2dd  57                       push     edi
100ee2de  8b 11                    mov      edx, dword ptr [ecx]
100ee2e0  8d 75 d4                 lea      esi, [ebp - 0x2c]
100ee2e3  8b 42 5c                 mov      eax, dword ptr [edx + 0x5c]
100ee2e6  89 34 24                 mov      dword ptr [esp], esi
100ee2e9  ff d0                    call     eax
100ee2eb  8b 4d 08                 mov      ecx, dword ptr [ebp + 8]
100ee2ee  57                       push     edi
100ee2ef  8b 11                    mov      edx, dword ptr [ecx]
100ee2f1  8d 75 d4                 lea      esi, [ebp - 0x2c]
100ee2f4  8b 42 5c                 mov      eax, dword ptr [edx + 0x5c]
100ee2f7  89 34 24                 mov      dword ptr [esp], esi
100ee2fa  ff d0                    call     eax
100ee2fc  8b 4d 08                 mov      ecx, dword ptr [ebp + 8]
100ee2ff  57                       push     edi
100ee300  8b 11                    mov      edx, dword ptr [ecx]
100ee302  8d 75 d4                 lea      esi, [ebp - 0x2c]
100ee305  8b 42 5c                 mov      eax, dword ptr [edx + 0x5c]
100ee308  89 34 24                 mov      dword ptr [esp], esi
100ee30b  ff d0                    call     eax
100ee30d  8b 4d 08                 mov      ecx, dword ptr [ebp + 8]
100ee310  57                       push     edi
100ee311  8b 11                    mov      edx, dword ptr [ecx]
100ee313  8d 75 d4                 lea      esi, [ebp - 0x2c]
100ee316  8b 42 5c                 mov      eax, dword ptr [edx + 0x5c]
100ee319  89 34 24                 mov      dword ptr [esp], esi
100ee31c  ff d0                    call     eax
100ee31e  8b 55 e8                 mov      edx, dword ptr [ebp - 0x18]
100ee321  57                       push     edi
100ee322  81 c2 38 06 00 00        add      edx, 0x638
100ee328  8b 4d 08                 mov      ecx, dword ptr [ebp + 8]
100ee32b  89 14 24                 mov      dword ptr [esp], edx
100ee32e  8b 11                    mov      edx, dword ptr [ecx]
100ee330  8b 42 5c                 mov      eax, dword ptr [edx + 0x5c]
100ee333  ff d0                    call     eax
100ee335  8b 4d 08                 mov      ecx, dword ptr [ebp + 8]
100ee338  57                       push     edi
100ee339  8b 11                    mov      edx, dword ptr [ecx]
100ee33b  8d 75 d4                 lea      esi, [ebp - 0x2c]
100ee33e  8b 42 5c                 mov      eax, dword ptr [edx + 0x5c]
100ee341  89 34 24                 mov      dword ptr [esp], esi
100ee344  ff d0                    call     eax
100ee346  8b 55 e0                 mov      edx, dword ptr [ebp - 0x20]
100ee349  83 c4 f8                 add      esp, -8
100ee34c  8d 54 1a 08              lea      edx, [edx + ebx + 8]
100ee350  8b 4d 08                 mov      ecx, dword ptr [ebp + 8]
100ee353  89 14 24                 mov      dword ptr [esp], edx
100ee356  8b 11                    mov      edx, dword ptr [ecx]
100ee358  c7 44 24 04 00 00 00 00  mov      dword ptr [esp + 4], 0
100ee360  8b 42 18                 mov      eax, dword ptr [edx + 0x18]
100ee363  ff d0                    call     eax
100ee365  8b 45 08                 mov      eax, dword ptr [ebp + 8]
100ee368  8b 4d e8                 mov      ecx, dword ptr [ebp - 0x18]
100ee36b  50                       push     eax
100ee36c  e8 2f 05 00 00           call     0x100ee8a0
100ee371  8b 4d e8                 mov      ecx, dword ptr [ebp - 0x18]
100ee374  8b 11                    mov      edx, dword ptr [ecx]
100ee376  8b 82 88 00 00 00        mov      eax, dword ptr [edx + 0x88]
100ee37c  ff d0                    call     eax
100ee37e  83 c4 f8                 add      esp, -8
100ee381  8b 45 e8                 mov      eax, dword ptr [ebp - 0x18]
100ee384  8b 88 e0 01 00 00        mov      ecx, dword ptr [eax + 0x1e0]
100ee38a  dd 1c 24                 fstp     qword ptr [esp]
100ee38d  e8 0e 66 00 00           call     0x100f49a0
100ee392  8b 4d e8                 mov      ecx, dword ptr [ebp - 0x18]
100ee395  8b 11                    mov      edx, dword ptr [ecx]
100ee397  8b 82 8c 00 00 00        mov      eax, dword ptr [edx + 0x8c]
100ee39d  ff d0                    call     eax
100ee39f  8b 55 e8                 mov      edx, dword ptr [ebp - 0x18]
100ee3a2  8b 8a e0 01 00 00        mov      ecx, dword ptr [edx + 0x1e0]
100ee3a8  50                       push     eax
100ee3a9  e8 d2 66 00 00           call     0x100f4a80
100ee3ae  8b 45 e4                 mov      eax, dword ptr [ebp - 0x1c]
100ee3b1  83 f8 14                 cmp      eax, 0x14
100ee3b4  7f 2f                    jg       0x100ee3e5
100ee3b6  33 db                    xor      ebx, ebx
100ee3b8  85 c0                    test     eax, eax
100ee3ba  0f 8e 4d 01 00 00        jle      0x100ee50d
100ee3c0  8b 55 e8                 mov      edx, dword ptr [ebp - 0x18]
100ee3c3  8b 8c 9a 88 01 00 00     mov      ecx, dword ptr [edx + ebx*4 + 0x188]
100ee3ca  8b 55 08                 mov      edx, dword ptr [ebp + 8]
100ee3cd  8b 31                    mov      esi, dword ptr [ecx]
100ee3cf  52                       push     edx
100ee3d0  8b 86 d8 00 00 00        mov      eax, dword ptr [esi + 0xd8]
100ee3d6  ff d0                    call     eax
100ee3d8  43                       inc      ebx
100ee3d9  8b 45 e4                 mov      eax, dword ptr [ebp - 0x1c]
100ee3dc  3b d8                    cmp      ebx, eax
100ee3de  7c e0                    jl       0x100ee3c0
100ee3e0  e9 28 01 00 00           jmp      0x100ee50d
100ee3e5  33 db                    xor      ebx, ebx
100ee3e7  8b 55 e8                 mov      edx, dword ptr [ebp - 0x18]
100ee3ea  8b 8c 9a 88 01 00 00     mov      ecx, dword ptr [edx + ebx*4 + 0x188]
100ee3f1  8b 55 08                 mov      edx, dword ptr [ebp + 8]
100ee3f4  8b 31                    mov      esi, dword ptr [ecx]
100ee3f6  52                       push     edx
100ee3f7  8b 86 d8 00 00 00        mov      eax, dword ptr [esi + 0xd8]
100ee3fd  ff d0                    call     eax
100ee3ff  43                       inc      ebx
100ee400  83 fb 14                 cmp      ebx, 0x14
100ee403  7c e2                    jl       0x100ee3e7
100ee405  83 c4 f4                 add      esp, -0xc
100ee408  8b 45 e8                 mov      eax, dword ptr [ebp - 0x18]
100ee40b  33 d2                    xor      edx, edx
100ee40d  89 04 24                 mov      dword ptr [esp], eax
100ee410  8d 8d 44 fe ff ff        lea      ecx, [ebp - 0x1bc]
100ee416  89 54 24 08              mov      dword ptr [esp + 8], edx
100ee41a  89 54 24 04              mov      dword ptr [esp + 4], edx
100ee41e  e8 6d 6c ff ff           call     0x100e5090
100ee423  c7 45 fc 00 00 00 00     mov      dword ptr [ebp - 4], 0
100ee42a  8b 45 e4                 mov      eax, dword ptr [ebp - 0x1c]
100ee42d  33 db                    xor      ebx, ebx
100ee42f  83 c0 ec                 add      eax, -0x14
100ee432  85 c0                    test     eax, eax
100ee434  7e 1a                    jle      0x100ee450
100ee436  8b 45 08                 mov      eax, dword ptr [ebp + 8]
100ee439  8d 8d 44 fe ff ff        lea      ecx, [ebp - 0x1bc]
100ee43f  50                       push     eax
100ee440  e8 6b 98 ff ff           call     0x100e7cb0
100ee445  8b 45 e4                 mov      eax, dword ptr [ebp - 0x1c]
100ee448  43                       inc      ebx
100ee449  83 c0 ec                 add      eax, -0x14
100ee44c  3b d8                    cmp      ebx, eax
100ee44e  7c e6                    jl       0x100ee436
100ee450  c7 45 fc ff ff ff ff     mov      dword ptr [ebp - 4], 0xffffffff
100ee457  8d 8d 44 fe ff ff        lea      ecx, [ebp - 0x1bc]
100ee45d  e8 ae 6e ff ff           call     0x100e5310
100ee462  8b 4d e8                 mov      ecx, dword ptr [ebp - 0x18]
100ee465  e8 a6 d9 ff ff           call     0x100ebe10
100ee46a  8b 45 e8                 mov      eax, dword ptr [ebp - 0x18]
100ee46d  8b 90 2c 02 00 00        mov      edx, dword ptr [eax + 0x22c]
100ee473  8b 94 90 30 01 00 00     mov      edx, dword ptr [eax + edx*4 + 0x130]
100ee47a  8b 9c 90 88 01 00 00     mov      ebx, dword ptr [eax + edx*4 + 0x188]
100ee481  85 db                    test     ebx, ebx
100ee483  74 3d                    je       0x100ee4c2
100ee485  8b d0                    mov      edx, eax
100ee487  33 f6                    xor      esi, esi
100ee489  89 9a 84 01 00 00        mov      dword ptr [edx + 0x184], ebx
100ee48f  8b 13                    mov      edx, dword ptr [ebx]
100ee491  8b cb                    mov      ecx, ebx
100ee493  8b 42 1c                 mov      eax, dword ptr [edx + 0x1c]
100ee496  ff d0                    call     eax
100ee498  85 c0                    test     eax, eax
100ee49a  7e 26                    jle      0x100ee4c2
100ee49c  8b 13                    mov      edx, dword ptr [ebx]
100ee49e  8b cb                    mov      ecx, ebx
100ee4a0  8b 42 24                 mov      eax, dword ptr [edx + 0x24]
100ee4a3  56                       push     esi
100ee4a4  ff d0                    call     eax
100ee4a6  85 c0                    test     eax, eax
100ee4a8  74 0a                    je       0x100ee4b4
100ee4aa  8a 90 50 03 00 00        mov      dl, byte ptr [eax + 0x350]
100ee4b0  84 d2                    test     dl, dl
100ee4b2  75 42                    jne      0x100ee4f6
100ee4b4  8b 13                    mov      edx, dword ptr [ebx]
100ee4b6  46                       inc      esi
100ee4b7  8b 42 1c                 mov      eax, dword ptr [edx + 0x1c]
100ee4ba  8b cb                    mov      ecx, ebx
100ee4bc  ff d0                    call     eax
100ee4be  3b f0                    cmp      esi, eax
100ee4c0  7c da                    jl       0x100ee49c
100ee4c2  8b 45 e8                 mov      eax, dword ptr [ebp - 0x18]
100ee4c5  8b 48 08                 mov      ecx, dword ptr [eax + 8]
100ee4c8  85 c9                    test     ecx, ecx
100ee4ca  74 07                    je       0x100ee4d3
100ee4cc  8b 11                    mov      edx, dword ptr [ecx]
100ee4ce  8b 42 58                 mov      eax, dword ptr [edx + 0x58]
100ee4d1  ff d0                    call     eax
100ee4d3  8b 4d e8                 mov      ecx, dword ptr [ebp - 0x18]
100ee4d6  e8 35 d3 ff ff           call     0x100eb810
100ee4db  8b 4d f4                 mov      ecx, dword ptr [ebp - 0xc]
100ee4de  64 89 0d 00 00 00 00     mov      dword ptr fs:[0], ecx
100ee4e5  8b 1c 24                 mov      ebx, dword ptr [esp]
100ee4e8  8b 74 24 04              mov      esi, dword ptr [esp + 4]
100ee4ec  8b 7c 24 08              mov      edi, dword ptr [esp + 8]
100ee4f0  8b e5                    mov      esp, ebp
100ee4f2  5d                       pop      ebp
100ee4f3  c2 04 00                 ret      4
100ee4f6  8b 4d e8                 mov      ecx, dword ptr [ebp - 0x18]
100ee4f9  50                       push     eax
100ee4fa  e8 41 d7 ff ff           call     0x100ebc40
100ee4ff  eb c1                    jmp      0x100ee4c2
100ee501  8d 8d 44 fe ff ff        lea      ecx, [ebp - 0x1bc]
100ee507  e8 04 6e ff ff           call     0x100e5310
100ee50c  c3                       ret      
100ee50d  8b 4d e8                 mov      ecx, dword ptr [ebp - 0x18]
100ee510  8b 11                    mov      edx, dword ptr [ecx]
100ee512  50                       push     eax
100ee513  8b 82 2c 02 00 00        mov      eax, dword ptr [edx + 0x22c]
100ee519  ff d0                    call     eax
100ee51b  e9 42 ff ff ff           jmp      0x100ee462
100ee520  b8 00 05 1a 10           mov      eax, 0x101a0500
100ee525  e9 35 88 00 00           jmp      0x100f6d5f
100ee52a  90                       nop      
100ee52b  90                       nop      
100ee52c  90                       nop      
100ee52d  90                       nop      
100ee52e  90                       nop      
100ee52f  90                       nop      
100ee530  55                       push     ebp
100ee531  8b ec                    mov      ebp, esp
100ee533  83 ec 48                 sub      esp, 0x48
100ee536  89 7c 24 08              mov      dword ptr [esp + 8], edi
100ee53a  89 74 24 04              mov      dword ptr [esp + 4], esi
100ee53e  89 1c 24                 mov      dword ptr [esp], ebx
100ee541  bf 40 a3 15 10           mov      edi, 0x1015a340
100ee546  89 4d f4                 mov      dword ptr [ebp - 0xc], ecx
100ee549  b9 fe 03 00 00           mov      ecx, 0x3fe
100ee54e  33 c0                    xor      eax, eax
100ee550  f3 ab                    rep stosd dword ptr es:[edi], eax
100ee552  8b 75 08                 mov      esi, dword ptr [ebp + 8]
100ee555  8b 16                    mov      edx, dword ptr [esi]
100ee557  8b ce                    mov      ecx, esi
100ee559  8b 42 10                 mov      eax, dword ptr [edx + 0x10]
100ee55c  ff d0                    call     eax
100ee55e  57                       push     edi
