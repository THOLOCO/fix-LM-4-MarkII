; ======================================================================
; LZ77 解压核心
; VA 0x102a907e .. 0x102a977e   file 0x407e .. 0x477e   (1792 bytes)
; ======================================================================

102a907e  53                       push     ebx
102a907f  51                       push     ecx
102a9080  52                       push     edx
102a9081  55                       push     ebp
102a9082  56                       push     esi
102a9083  57                       push     edi
102a9084  83 ec 08                 sub      esp, 8
102a9087  8b 6c 24 2c              mov      ebp, dword ptr [esp + 0x2c]
102a908b  8b 74 24 28              mov      esi, dword ptr [esp + 0x28]
102a908f  8b 7c 24 24              mov      edi, dword ptr [esp + 0x24]
102a9093  8b c7                    mov      eax, edi
102a9095  05 00 80 00 00           add      eax, 0x8000
102a909a  89 04 24                 mov      dword ptr [esp], eax
102a909d  8b c6                    mov      eax, esi
102a909f  05 00 80 00 00           add      eax, 0x8000
102a90a4  89 44 24 04              mov      dword ptr [esp + 4], eax
102a90a8  33 c0                    xor      eax, eax
102a90aa  33 db                    xor      ebx, ebx
102a90ac  33 c9                    xor      ecx, ecx
102a90ae  33 d2                    xor      edx, edx
102a90b0  42                       inc      edx
102a90b1  90                       nop      
102a90b2  85 c0                    test     eax, eax
102a90b4  75 6d                    jne      0x102a9123
102a90b6  90                       nop      
102a90b7  90                       nop      
102a90b8  90                       nop      
102a90b9  90                       nop      
102a90ba  8b 06                    mov      eax, dword ptr [esi]
102a90bc  83 c6 04                 add      esi, 4
102a90bf  8b d8                    mov      ebx, eax
102a90c1  f9                       stc      
102a90c2  d1 d8                    rcr      eax, 1
102a90c4  83 e3 0f                 and      ebx, 0xf
102a90c7  c1 e8 03                 shr      eax, 3
102a90ca  ff 24 9d 3e 90 2a 10     jmp      dword ptr [ebx*4 + 0x102a903e]
102a90d1  90                       nop      
102a90d2  8a 1e                    mov      bl, byte ptr [esi]
102a90d4  46                       inc      esi
102a90d5  03 db                    add      ebx, ebx
102a90d7  56                       push     esi
102a90d8  33 f6                    xor      esi, esi
102a90da  f7 db                    neg      ebx
102a90dc  66 8b 74 1d fe           mov      si, word ptr [ebp + ebx - 2]
102a90e1  8b df                    mov      ebx, edi
102a90e3  03 74 24 28              add      esi, dword ptr [esp + 0x28]
102a90e7  3b f7                    cmp      esi, edi
102a90e9  0f 87 01 0a 00 00        ja       0x102a9af0
102a90ef  2b 5c 24 28              sub      ebx, dword ptr [esp + 0x28]
102a90f3  a4                       movsb    byte ptr es:[edi], byte ptr [esi]
102a90f4  66 89 5d 00              mov      word ptr [ebp], bx
102a90f8  83 c5 02                 add      ebp, 2
102a90fb  66 a5                    movsw    word ptr es:[edi], word ptr [esi]
102a90fd  5e                       pop      esi
102a90fe  8b d8                    mov      ebx, eax
102a9100  3b 3c 24                 cmp      edi, dword ptr [esp]
102a9103  0f 87 ef 09 00 00        ja       0x102a9af8
102a9109  3b 74 24 04              cmp      esi, dword ptr [esp + 4]
102a910d  0f 87 e5 09 00 00        ja       0x102a9af8
102a9113  c1 e8 04                 shr      eax, 4
102a9116  83 e3 0f                 and      ebx, 0xf
102a9119  2e ff 24 9d 3e 90 2a 10  jmp      dword ptr cs:[ebx*4 + 0x102a903e]
102a9121  90                       nop      
102a9122  41                       inc      ecx
102a9123  83 c1 04                 add      ecx, 4
102a9126  8a 1e                    mov      bl, byte ptr [esi]
102a9128  46                       inc      esi
102a9129  03 db                    add      ebx, ebx
102a912b  56                       push     esi
102a912c  33 f6                    xor      esi, esi
102a912e  f7 db                    neg      ebx
102a9130  66 8b 74 1d fe           mov      si, word ptr [ebp + ebx - 2]
102a9135  8b df                    mov      ebx, edi
102a9137  03 74 24 28              add      esi, dword ptr [esp + 0x28]
102a913b  2b 5c 24 28              sub      ebx, dword ptr [esp + 0x28]
102a913f  3b f7                    cmp      esi, edi
102a9141  0f 87 a9 09 00 00        ja       0x102a9af0
102a9147  66 89 5d 00              mov      word ptr [ebp], bx
102a914b  83 c5 02                 add      ebp, 2
102a914e  f3 a4                    rep movsb byte ptr es:[edi], byte ptr [esi]
102a9150  5e                       pop      esi
102a9151  8b d8                    mov      ebx, eax
102a9153  3b 3c 24                 cmp      edi, dword ptr [esp]
102a9156  0f 87 9c 09 00 00        ja       0x102a9af8
102a915c  3b 74 24 04              cmp      esi, dword ptr [esp + 4]
102a9160  0f 87 92 09 00 00        ja       0x102a9af8
102a9166  c1 e8 04                 shr      eax, 4
102a9169  83 e3 0f                 and      ebx, 0xf
102a916c  2e ff 24 9d 3e 90 2a 10  jmp      dword ptr cs:[ebx*4 + 0x102a903e]
102a9174  87 db                    xchg     ebx, ebx
102a9176  8a 1e                    mov      bl, byte ptr [esi]
102a9178  81 c3 00 01 00 00        add      ebx, 0x100
102a917e  46                       inc      esi
102a917f  03 db                    add      ebx, ebx
102a9181  56                       push     esi
102a9182  33 f6                    xor      esi, esi
102a9184  f7 db                    neg      ebx
102a9186  66 8b 74 1d fe           mov      si, word ptr [ebp + ebx - 2]
102a918b  8b df                    mov      ebx, edi
102a918d  03 74 24 28              add      esi, dword ptr [esp + 0x28]
102a9191  3b f7                    cmp      esi, edi
102a9193  0f 87 57 09 00 00        ja       0x102a9af0
102a9199  2b 5c 24 28              sub      ebx, dword ptr [esp + 0x28]
102a919d  a4                       movsb    byte ptr es:[edi], byte ptr [esi]
102a919e  66 89 5d 00              mov      word ptr [ebp], bx
102a91a2  83 c5 02                 add      ebp, 2
102a91a5  66 a5                    movsw    word ptr es:[edi], word ptr [esi]
102a91a7  5e                       pop      esi
102a91a8  8b d8                    mov      ebx, eax
102a91aa  3b 3c 24                 cmp      edi, dword ptr [esp]
102a91ad  0f 87 45 09 00 00        ja       0x102a9af8
102a91b3  3b 74 24 04              cmp      esi, dword ptr [esp + 4]
102a91b7  0f 87 3b 09 00 00        ja       0x102a9af8
102a91bd  c1 e8 04                 shr      eax, 4
102a91c0  83 e3 0f                 and      ebx, 0xf
102a91c3  2e ff 24 9d 3e 90 2a 10  jmp      dword ptr cs:[ebx*4 + 0x102a903e]
102a91cb  87 db                    xchg     ebx, ebx
102a91cd  90                       nop      
102a91ce  b9 03 00 00 00           mov      ecx, 3
102a91d3  8b d8                    mov      ebx, eax
102a91d5  d1 e8                    shr      eax, 1
102a91d7  0f 84 b1 00 00 00        je       0x102a928e
102a91dd  c1 e8 03                 shr      eax, 3
102a91e0  83 e3 0f                 and      ebx, 0xf
102a91e3  83 fb 02                 cmp      ebx, 2
102a91e6  72 55                    jb       0x102a923d
102a91e8  90                       nop      
102a91e9  90                       nop      
102a91ea  90                       nop      
102a91eb  90                       nop      
102a91ec  c1 e3 08                 shl      ebx, 8
102a91ef  8a 1e                    mov      bl, byte ptr [esi]
102a91f1  46                       inc      esi
102a91f2  03 db                    add      ebx, ebx
102a91f4  56                       push     esi
102a91f5  33 f6                    xor      esi, esi
102a91f7  f7 db                    neg      ebx
102a91f9  66 8b 74 1d fe           mov      si, word ptr [ebp + ebx - 2]
102a91fe  8b df                    mov      ebx, edi
102a9200  03 74 24 28              add      esi, dword ptr [esp + 0x28]
102a9204  2b 5c 24 28              sub      ebx, dword ptr [esp + 0x28]
102a9208  3b f7                    cmp      esi, edi
102a920a  0f 87 e0 08 00 00        ja       0x102a9af0
102a9210  66 89 5d 00              mov      word ptr [ebp], bx
102a9214  83 c5 02                 add      ebp, 2
102a9217  f3 a4                    rep movsb byte ptr es:[edi], byte ptr [esi]
102a9219  5e                       pop      esi
102a921a  8b d8                    mov      ebx, eax
102a921c  3b 3c 24                 cmp      edi, dword ptr [esp]
102a921f  0f 87 d3 08 00 00        ja       0x102a9af8
102a9225  3b 74 24 04              cmp      esi, dword ptr [esp + 4]
102a9229  0f 87 c9 08 00 00        ja       0x102a9af8
102a922f  c1 e8 04                 shr      eax, 4
102a9232  83 e3 0f                 and      ebx, 0xf
102a9235  2e ff 24 9d 3e 90 2a 10  jmp      dword ptr cs:[ebx*4 + 0x102a903e]
102a923d  03 cb                    add      ecx, ebx
102a923f  33 db                    xor      ebx, ebx
102a9241  03 db                    add      ebx, ebx
102a9243  56                       push     esi
102a9244  33 f6                    xor      esi, esi
102a9246  f7 db                    neg      ebx
102a9248  66 8b 74 1d fe           mov      si, word ptr [ebp + ebx - 2]
102a924d  8b df                    mov      ebx, edi
102a924f  03 74 24 28              add      esi, dword ptr [esp + 0x28]
102a9253  2b 5c 24 28              sub      ebx, dword ptr [esp + 0x28]
102a9257  3b f7                    cmp      esi, edi
102a9259  0f 87 91 08 00 00        ja       0x102a9af0
102a925f  66 89 5d 00              mov      word ptr [ebp], bx
102a9263  83 c5 02                 add      ebp, 2
102a9266  f3 a4                    rep movsb byte ptr es:[edi], byte ptr [esi]
102a9268  5e                       pop      esi
102a9269  8b d8                    mov      ebx, eax
102a926b  3b 3c 24                 cmp      edi, dword ptr [esp]
102a926e  0f 87 84 08 00 00        ja       0x102a9af8
102a9274  3b 74 24 04              cmp      esi, dword ptr [esp + 4]
102a9278  0f 87 7a 08 00 00        ja       0x102a9af8
102a927e  c1 e8 04                 shr      eax, 4
102a9281  83 e3 0f                 and      ebx, 0xf
102a9284  2e ff 24 9d 3e 90 2a 10  jmp      dword ptr cs:[ebx*4 + 0x102a903e]
102a928c  87 db                    xchg     ebx, ebx
102a928e  8b 06                    mov      eax, dword ptr [esi]
102a9290  8d 76 04                 lea      esi, [esi + 4]
102a9293  8b d8                    mov      ebx, eax
102a9295  d1 d8                    rcr      eax, 1
102a9297  e9 41 ff ff ff           jmp      0x102a91dd
102a929c  87 db                    xchg     ebx, ebx
102a929e  41                       inc      ecx
102a929f  83 c1 04                 add      ecx, 4
102a92a2  8b d8                    mov      ebx, eax
102a92a4  d1 e8                    shr      eax, 1
102a92a6  74 76                    je       0x102a931e
102a92a8  90                       nop      
102a92a9  90                       nop      
102a92aa  90                       nop      
102a92ab  90                       nop      
102a92ac  c1 e8 03                 shr      eax, 3
102a92af  83 e3 0f                 and      ebx, 0xf
102a92b2  85 db                    test     ebx, ebx
102a92b4  75 17                    jne      0x102a92cd
102a92b6  90                       nop      
102a92b7  90                       nop      
102a92b8  90                       nop      
102a92b9  90                       nop      
102a92ba  8b d8                    mov      ebx, eax
102a92bc  d1 e8                    shr      eax, 1
102a92be  74 6a                    je       0x102a932a
102a92c0  90                       nop      
102a92c1  90                       nop      
102a92c2  90                       nop      
102a92c3  90                       nop      
102a92c4  c1 e8 03                 shr      eax, 3
102a92c7  83 e3 0f                 and      ebx, 0xf
102a92ca  83 cb 10                 or       ebx, 0x10
102a92cd  c1 e3 08                 shl      ebx, 8
102a92d0  8a 1e                    mov      bl, byte ptr [esi]
102a92d2  46                       inc      esi
102a92d3  03 db                    add      ebx, ebx
102a92d5  56                       push     esi
102a92d6  33 f6                    xor      esi, esi
102a92d8  f7 db                    neg      ebx
102a92da  66 8b 74 1d fe           mov      si, word ptr [ebp + ebx - 2]
102a92df  8b df                    mov      ebx, edi
102a92e1  03 74 24 28              add      esi, dword ptr [esp + 0x28]
102a92e5  2b 5c 24 28              sub      ebx, dword ptr [esp + 0x28]
102a92e9  3b f7                    cmp      esi, edi
102a92eb  0f 87 ff 07 00 00        ja       0x102a9af0
102a92f1  66 89 5d 00              mov      word ptr [ebp], bx
102a92f5  83 c5 02                 add      ebp, 2
102a92f8  f3 a4                    rep movsb byte ptr es:[edi], byte ptr [esi]
102a92fa  5e                       pop      esi
102a92fb  8b d8                    mov      ebx, eax
102a92fd  3b 3c 24                 cmp      edi, dword ptr [esp]
102a9300  0f 87 f2 07 00 00        ja       0x102a9af8
102a9306  3b 74 24 04              cmp      esi, dword ptr [esp + 4]
102a930a  0f 87 e8 07 00 00        ja       0x102a9af8
102a9310  c1 e8 04                 shr      eax, 4
102a9313  83 e3 0f                 and      ebx, 0xf
102a9316  2e ff 24 9d 3e 90 2a 10  jmp      dword ptr cs:[ebx*4 + 0x102a903e]
102a931e  8b 06                    mov      eax, dword ptr [esi]
102a9320  8d 76 04                 lea      esi, [esi + 4]
102a9323  8b d8                    mov      ebx, eax
102a9325  d1 d8                    rcr      eax, 1
102a9327  eb 83                    jmp      0x102a92ac
102a9329  90                       nop      
102a932a  8b 06                    mov      eax, dword ptr [esi]
102a932c  8d 76 04                 lea      esi, [esi + 4]
102a932f  8b d8                    mov      ebx, eax
102a9331  d1 d8                    rcr      eax, 1
102a9333  eb 8f                    jmp      0x102a92c4
102a9335  90                       nop      
102a9336  b9 06 00 00 00           mov      ecx, 6
102a933b  d1 ea                    shr      edx, 1
102a933d  0f 84 83 00 00 00        je       0x102a93c6
102a9343  73 32                    jae      0x102a9377
102a9345  90                       nop      
102a9346  90                       nop      
102a9347  90                       nop      
102a9348  90                       nop      
102a9349  8b d8                    mov      ebx, eax
102a934b  d1 e8                    shr      eax, 1
102a934d  0f 84 7f 00 00 00        je       0x102a93d2
102a9353  c1 e8 03                 shr      eax, 3
102a9356  83 e3 0f                 and      ebx, 0xf
102a9359  85 db                    test     ebx, ebx
102a935b  75 17                    jne      0x102a9374
102a935d  90                       nop      
102a935e  90                       nop      
102a935f  90                       nop      
102a9360  90                       nop      
102a9361  8b d8                    mov      ebx, eax
102a9363  d1 e8                    shr      eax, 1
102a9365  74 7b                    je       0x102a93e2
102a9367  90                       nop      
102a9368  90                       nop      
102a9369  90                       nop      
102a936a  90                       nop      
102a936b  c1 e8 03                 shr      eax, 3
102a936e  83 e3 0f                 and      ebx, 0xf
102a9371  83 cb 10                 or       ebx, 0x10
102a9374  c1 e3 08                 shl      ebx, 8
102a9377  8a 1e                    mov      bl, byte ptr [esi]
102a9379  46                       inc      esi
102a937a  03 db                    add      ebx, ebx
102a937c  56                       push     esi
102a937d  33 f6                    xor      esi, esi
102a937f  f7 db                    neg      ebx
102a9381  66 8b 74 1d fe           mov      si, word ptr [ebp + ebx - 2]
102a9386  8b df                    mov      ebx, edi
102a9388  03 74 24 28              add      esi, dword ptr [esp + 0x28]
102a938c  2b 5c 24 28              sub      ebx, dword ptr [esp + 0x28]
102a9390  3b f7                    cmp      esi, edi
102a9392  0f 87 58 07 00 00        ja       0x102a9af0
102a9398  66 89 5d 00              mov      word ptr [ebp], bx
102a939c  83 c5 02                 add      ebp, 2
102a939f  f3 a4                    rep movsb byte ptr es:[edi], byte ptr [esi]
102a93a1  5e                       pop      esi
102a93a2  8b d8                    mov      ebx, eax
102a93a4  3b 3c 24                 cmp      edi, dword ptr [esp]
102a93a7  0f 87 4b 07 00 00        ja       0x102a9af8
102a93ad  3b 74 24 04              cmp      esi, dword ptr [esp + 4]
102a93b1  0f 87 41 07 00 00        ja       0x102a9af8
102a93b7  c1 e8 04                 shr      eax, 4
102a93ba  83 e3 0f                 and      ebx, 0xf
102a93bd  2e ff 24 9d 3e 90 2a 10  jmp      dword ptr cs:[ebx*4 + 0x102a903e]
102a93c5  90                       nop      
102a93c6  8b 16                    mov      edx, dword ptr [esi]
102a93c8  8d 76 04                 lea      esi, [esi + 4]
102a93cb  d1 da                    rcr      edx, 1
102a93cd  e9 71 ff ff ff           jmp      0x102a9343
102a93d2  8b 06                    mov      eax, dword ptr [esi]
102a93d4  8d 76 04                 lea      esi, [esi + 4]
102a93d7  8b d8                    mov      ebx, eax
102a93d9  d1 d8                    rcr      eax, 1
102a93db  e9 73 ff ff ff           jmp      0x102a9353
102a93e0  87 db                    xchg     ebx, ebx
102a93e2  8b 06                    mov      eax, dword ptr [esi]
102a93e4  8d 76 04                 lea      esi, [esi + 4]
102a93e7  8b d8                    mov      ebx, eax
102a93e9  d1 d8                    rcr      eax, 1
102a93eb  e9 7b ff ff ff           jmp      0x102a936b
102a93f0  87 db                    xchg     ebx, ebx
102a93f2  d1 ea                    shr      edx, 1
102a93f4  0f 84 90 00 00 00        je       0x102a948a
102a93fa  13 c9                    adc      ecx, ecx
102a93fc  83 c1 07                 add      ecx, 7
102a93ff  d1 ea                    shr      edx, 1
102a9401  0f 84 8f 00 00 00        je       0x102a9496
102a9407  73 32                    jae      0x102a943b
102a9409  90                       nop      
102a940a  90                       nop      
102a940b  90                       nop      
102a940c  90                       nop      
102a940d  8b d8                    mov      ebx, eax
102a940f  d1 e8                    shr      eax, 1
102a9411  0f 84 8b 00 00 00        je       0x102a94a2
102a9417  c1 e8 03                 shr      eax, 3
102a941a  83 e3 0f                 and      ebx, 0xf
102a941d  85 db                    test     ebx, ebx
102a941f  75 17                    jne      0x102a9438
102a9421  90                       nop      
102a9422  90                       nop      
102a9423  90                       nop      
102a9424  90                       nop      
102a9425  8b d8                    mov      ebx, eax
102a9427  d1 e8                    shr      eax, 1
102a9429  0f 84 83 00 00 00        je       0x102a94b2
102a942f  c1 e8 03                 shr      eax, 3
102a9432  83 e3 0f                 and      ebx, 0xf
102a9435  83 cb 10                 or       ebx, 0x10
102a9438  c1 e3 08                 shl      ebx, 8
102a943b  8a 1e                    mov      bl, byte ptr [esi]
102a943d  46                       inc      esi
102a943e  03 db                    add      ebx, ebx
102a9440  56                       push     esi
102a9441  33 f6                    xor      esi, esi
102a9443  f7 db                    neg      ebx
102a9445  66 8b 74 1d fe           mov      si, word ptr [ebp + ebx - 2]
102a944a  8b df                    mov      ebx, edi
102a944c  03 74 24 28              add      esi, dword ptr [esp + 0x28]
102a9450  2b 5c 24 28              sub      ebx, dword ptr [esp + 0x28]
102a9454  3b f7                    cmp      esi, edi
102a9456  0f 87 94 06 00 00        ja       0x102a9af0
102a945c  66 89 5d 00              mov      word ptr [ebp], bx
102a9460  83 c5 02                 add      ebp, 2
102a9463  f3 a4                    rep movsb byte ptr es:[edi], byte ptr [esi]
102a9465  5e                       pop      esi
102a9466  8b d8                    mov      ebx, eax
102a9468  3b 3c 24                 cmp      edi, dword ptr [esp]
102a946b  0f 87 87 06 00 00        ja       0x102a9af8
102a9471  3b 74 24 04              cmp      esi, dword ptr [esp + 4]
102a9475  0f 87 7d 06 00 00        ja       0x102a9af8
102a947b  c1 e8 04                 shr      eax, 4
102a947e  83 e3 0f                 and      ebx, 0xf
102a9481  2e ff 24 9d 3e 90 2a 10  jmp      dword ptr cs:[ebx*4 + 0x102a903e]
102a9489  90                       nop      
102a948a  8b 16                    mov      edx, dword ptr [esi]
102a948c  8d 76 04                 lea      esi, [esi + 4]
102a948f  d1 da                    rcr      edx, 1
102a9491  e9 64 ff ff ff           jmp      0x102a93fa
102a9496  8b 16                    mov      edx, dword ptr [esi]
102a9498  8d 76 04                 lea      esi, [esi + 4]
102a949b  d1 da                    rcr      edx, 1
102a949d  e9 65 ff ff ff           jmp      0x102a9407
102a94a2  8b 06                    mov      eax, dword ptr [esi]
102a94a4  8d 76 04                 lea      esi, [esi + 4]
102a94a7  8b d8                    mov      ebx, eax
102a94a9  d1 d8                    rcr      eax, 1
102a94ab  e9 67 ff ff ff           jmp      0x102a9417
102a94b0  87 db                    xchg     ebx, ebx
102a94b2  8b 06                    mov      eax, dword ptr [esi]
102a94b4  8d 76 04                 lea      esi, [esi + 4]
102a94b7  8b d8                    mov      ebx, eax
102a94b9  d1 d8                    rcr      eax, 1
102a94bb  e9 6f ff ff ff           jmp      0x102a942f
102a94c0  87 db                    xchg     ebx, ebx
102a94c2  d1 ea                    shr      edx, 1
102a94c4  0f 84 ec 00 00 00        je       0x102a95b6
102a94ca  13 c9                    adc      ecx, ecx
102a94cc  d1 ea                    shr      edx, 1
102a94ce  0f 84 ee 00 00 00        je       0x102a95c2
102a94d4  13 c9                    adc      ecx, ecx
102a94d6  d1 ea                    shr      edx, 1
102a94d8  0f 84 f0 00 00 00        je       0x102a95ce
102a94de  73 32                    jae      0x102a9512
102a94e0  90                       nop      
102a94e1  90                       nop      
102a94e2  90                       nop      
102a94e3  90                       nop      
102a94e4  8b d8                    mov      ebx, eax
102a94e6  d1 e8                    shr      eax, 1
102a94e8  0f 84 ec 00 00 00        je       0x102a95da
102a94ee  c1 e8 03                 shr      eax, 3
102a94f1  83 e3 0f                 and      ebx, 0xf
102a94f4  85 db                    test     ebx, ebx
102a94f6  75 17                    jne      0x102a950f
102a94f8  90                       nop      
102a94f9  90                       nop      
102a94fa  90                       nop      
102a94fb  90                       nop      
102a94fc  8b d8                    mov      ebx, eax
102a94fe  d1 e8                    shr      eax, 1
102a9500  0f 84 e4 00 00 00        je       0x102a95ea
102a9506  c1 e8 03                 shr      eax, 3
102a9509  83 e3 0f                 and      ebx, 0xf
102a950c  83 cb 10                 or       ebx, 0x10
102a950f  c1 e3 08                 shl      ebx, 8
102a9512  8a 1e                    mov      bl, byte ptr [esi]
102a9514  46                       inc      esi
102a9515  83 c1 09                 add      ecx, 9
102a9518  03 db                    add      ebx, ebx
102a951a  56                       push     esi
102a951b  33 f6                    xor      esi, esi
102a951d  f7 db                    neg      ebx
102a951f  66 8b 74 1d fe           mov      si, word ptr [ebp + ebx - 2]
102a9524  8b df                    mov      ebx, edi
102a9526  03 74 24 28              add      esi, dword ptr [esp + 0x28]
102a952a  2b 5c 24 28              sub      ebx, dword ptr [esp + 0x28]
102a952e  46                       inc      esi
102a952f  66 89 5d 00              mov      word ptr [ebp], bx
102a9533  83 c5 02                 add      ebp, 2
102a9536  3b f7                    cmp      esi, edi
102a9538  74 38                    je       0x102a9572
102a953a  90                       nop      
102a953b  90                       nop      
102a953c  90                       nop      
102a953d  90                       nop      
102a953e  0f 87 ac 05 00 00        ja       0x102a9af0
102a9544  4e                       dec      esi
102a9545  d1 e9                    shr      ecx, 1
102a9547  f3 66 a5                 rep movsw word ptr es:[edi], word ptr [esi]
102a954a  13 c9                    adc      ecx, ecx
102a954c  f3 a4                    rep movsb byte ptr es:[edi], byte ptr [esi]
102a954e  5e                       pop      esi
102a954f  8b d8                    mov      ebx, eax
102a9551  3b 3c 24                 cmp      edi, dword ptr [esp]
102a9554  0f 87 9e 05 00 00        ja       0x102a9af8
102a955a  3b 74 24 04              cmp      esi, dword ptr [esp + 4]
102a955e  0f 87 94 05 00 00        ja       0x102a9af8
102a9564  c1 e8 04                 shr      eax, 4
102a9567  83 e3 0f                 and      ebx, 0xf
102a956a  2e ff 24 9d 3e 90 2a 10  jmp      dword ptr cs:[ebx*4 + 0x102a903e]
102a9572  50                       push     eax
102a9573  8a 47 ff                 mov      al, byte ptr [edi - 1]
102a9576  8b f1                    mov      esi, ecx
102a9578  8a e0                    mov      ah, al
102a957a  c1 e9 02                 shr      ecx, 2
102a957d  8b d8                    mov      ebx, eax
102a957f  c1 e0 10                 shl      eax, 0x10
102a9582  83 e6 03                 and      esi, 3
102a9585  66 8b c3                 mov      ax, bx
102a9588  f3 ab                    rep stosd dword ptr es:[edi], eax
102a958a  8b ce                    mov      ecx, esi
102a958c  f3 aa                    rep stosb byte ptr es:[edi], al
102a958e  58                       pop      eax
102a958f  5e                       pop      esi
102a9590  8b d8                    mov      ebx, eax
102a9592  3b 3c 24                 cmp      edi, dword ptr [esp]
102a9595  0f 87 5d 05 00 00        ja       0x102a9af8
102a959b  3b 74 24 04              cmp      esi, dword ptr [esp + 4]
102a959f  0f 87 53 05 00 00        ja       0x102a9af8
102a95a5  c1 e8 04                 shr      eax, 4
102a95a8  83 e3 0f                 and      ebx, 0xf
102a95ab  2e ff 24 9d 3e 90 2a 10  jmp      dword ptr cs:[ebx*4 + 0x102a903e]
102a95b3  87 db                    xchg     ebx, ebx
102a95b5  90                       nop      
102a95b6  8b 16                    mov      edx, dword ptr [esi]
102a95b8  8d 76 04                 lea      esi, [esi + 4]
102a95bb  d1 da                    rcr      edx, 1
102a95bd  e9 08 ff ff ff           jmp      0x102a94ca
102a95c2  8b 16                    mov      edx, dword ptr [esi]
102a95c4  8d 76 04                 lea      esi, [esi + 4]
102a95c7  d1 da                    rcr      edx, 1
102a95c9  e9 06 ff ff ff           jmp      0x102a94d4
102a95ce  8b 16                    mov      edx, dword ptr [esi]
102a95d0  8d 76 04                 lea      esi, [esi + 4]
102a95d3  d1 da                    rcr      edx, 1
102a95d5  e9 04 ff ff ff           jmp      0x102a94de
102a95da  8b 06                    mov      eax, dword ptr [esi]
102a95dc  8d 76 04                 lea      esi, [esi + 4]
102a95df  8b d8                    mov      ebx, eax
102a95e1  d1 d8                    rcr      eax, 1
102a95e3  e9 06 ff ff ff           jmp      0x102a94ee
102a95e8  87 db                    xchg     ebx, ebx
102a95ea  8b 06                    mov      eax, dword ptr [esi]
102a95ec  8d 76 04                 lea      esi, [esi + 4]
102a95ef  8b d8                    mov      ebx, eax
102a95f1  d1 d8                    rcr      eax, 1
102a95f3  e9 0e ff ff ff           jmp      0x102a9506
102a95f8  87 db                    xchg     ebx, ebx
102a95fa  8b df                    mov      ebx, edi
102a95fc  8a 0e                    mov      cl, byte ptr [esi]
102a95fe  2b 5c 24 24              sub      ebx, dword ptr [esp + 0x24]
102a9602  46                       inc      esi
102a9603  66 89 5d 00              mov      word ptr [ebp], bx
102a9607  83 c5 02                 add      ebp, 2
102a960a  88 0f                    mov      byte ptr [edi], cl
102a960c  47                       inc      edi
102a960d  33 c9                    xor      ecx, ecx
102a960f  8b d8                    mov      ebx, eax
102a9611  3b 3c 24                 cmp      edi, dword ptr [esp]
102a9614  0f 87 de 04 00 00        ja       0x102a9af8
102a961a  3b 74 24 04              cmp      esi, dword ptr [esp + 4]
102a961e  0f 87 d4 04 00 00        ja       0x102a9af8
102a9624  c1 e8 04                 shr      eax, 4
102a9627  83 e3 0f                 and      ebx, 0xf
102a962a  2e ff 24 9d 3e 90 2a 10  jmp      dword ptr cs:[ebx*4 + 0x102a903e]
102a9632  8b df                    mov      ebx, edi
102a9634  8b 0e                    mov      ecx, dword ptr [esi]
102a9636  2b 5c 24 24              sub      ebx, dword ptr [esp + 0x24]
102a963a  83 c6 02                 add      esi, 2
102a963d  66 89 5d 00              mov      word ptr [ebp], bx
102a9641  43                       inc      ebx
102a9642  89 0f                    mov      dword ptr [edi], ecx
102a9644  83 c7 02                 add      edi, 2
102a9647  66 89 5d 02              mov      word ptr [ebp + 2], bx
102a964b  83 c5 04                 add      ebp, 4
102a964e  33 c9                    xor      ecx, ecx
102a9650  8b d8                    mov      ebx, eax
102a9652  3b 3c 24                 cmp      edi, dword ptr [esp]
102a9655  0f 87 9d 04 00 00        ja       0x102a9af8
102a965b  3b 74 24 04              cmp      esi, dword ptr [esp + 4]
102a965f  0f 87 93 04 00 00        ja       0x102a9af8
102a9665  c1 e8 04                 shr      eax, 4
102a9668  83 e3 0f                 and      ebx, 0xf
102a966b  2e ff 24 9d 3e 90 2a 10  jmp      dword ptr cs:[ebx*4 + 0x102a903e]
102a9673  87 db                    xchg     ebx, ebx
102a9675  90                       nop      
102a9676  8b df                    mov      ebx, edi
102a9678  2b 5c 24 24              sub      ebx, dword ptr [esp + 0x24]
102a967c  66 89 5d 00              mov      word ptr [ebp], bx
102a9680  43                       inc      ebx
102a9681  66 89 5d 02              mov      word ptr [ebp + 2], bx
102a9685  43                       inc      ebx
102a9686  66 89 5d 04              mov      word ptr [ebp + 4], bx
102a968a  83 c5 06                 add      ebp, 6
102a968d  d1 ea                    shr      edx, 1
102a968f  74 3d                    je       0x102a96ce
102a9691  90                       nop      
102a9692  90                       nop      
102a9693  90                       nop      
102a9694  90                       nop      
102a9695  66 a5                    movsw    word ptr es:[edi], word ptr [esi]
102a9697  a4                       movsb    byte ptr es:[edi], byte ptr [esi]
102a9698  73 0e                    jae      0x102a96a8
102a969a  90                       nop      
102a969b  90                       nop      
102a969c  90                       nop      
102a969d  90                       nop      
102a969e  43                       inc      ebx
102a969f  a4                       movsb    byte ptr es:[edi], byte ptr [esi]
102a96a0  66 3e 89 5d 00           mov      word ptr ds:[ebp], bx
102a96a5  83 c5 02                 add      ebp, 2
102a96a8  8b d8                    mov      ebx, eax
102a96aa  3b 3c 24                 cmp      edi, dword ptr [esp]
102a96ad  0f 87 45 04 00 00        ja       0x102a9af8
102a96b3  3b 74 24 04              cmp      esi, dword ptr [esp + 4]
102a96b7  0f 87 3b 04 00 00        ja       0x102a9af8
102a96bd  c1 e8 04                 shr      eax, 4
102a96c0  83 e3 0f                 and      ebx, 0xf
102a96c3  2e ff 24 9d 3e 90 2a 10  jmp      dword ptr cs:[ebx*4 + 0x102a903e]
102a96cb  87 db                    xchg     ebx, ebx
102a96cd  90                       nop      
102a96ce  8b 16                    mov      edx, dword ptr [esi]
102a96d0  8d 76 04                 lea      esi, [esi + 4]
102a96d3  d1 da                    rcr      edx, 1
102a96d5  eb be                    jmp      0x102a9695
102a96d7  87 db                    xchg     ebx, ebx
102a96d9  90                       nop      
102a96da  d1 ea                    shr      edx, 1
102a96dc  74 7c                    je       0x102a975a
102a96de  90                       nop      
102a96df  90                       nop      
102a96e0  90                       nop      
102a96e1  90                       nop      
102a96e2  13 c9                    adc      ecx, ecx
102a96e4  d1 ea                    shr      edx, 1
102a96e6  74 7e                    je       0x102a9766
102a96e8  90                       nop      
102a96e9  90                       nop      
102a96ea  90                       nop      
102a96eb  90                       nop      
102a96ec  13 c9                    adc      ecx, ecx
102a96ee  83 c1 05                 add      ecx, 5
102a96f1  8b df                    mov      ebx, edi
102a96f3  50                       push     eax
102a96f4  2b 5c 24 28              sub      ebx, dword ptr [esp + 0x28]
102a96f8  f7 c1 01 00 00 00        test     ecx, 1
102a96fe  74 0e                    je       0x102a970e
102a9700  90                       nop      
102a9701  90                       nop      
102a9702  90                       nop      
102a9703  90                       nop      
102a9704  a4                       movsb    byte ptr es:[edi], byte ptr [esi]
102a9705  66 89 5d 00              mov      word ptr [ebp], bx
102a9709  43                       inc      ebx
102a970a  83 c5 02                 add      ebp, 2
102a970d  49                       dec      ecx
102a970e  8b c3                    mov      eax, ebx
102a9710  43                       inc      ebx
102a9711  c1 e3 10                 shl      ebx, 0x10
102a9714  66 8b d8                 mov      bx, ax
102a9717  66 8b 06                 mov      ax, word ptr [esi]
102a971a  89 5d 00                 mov      dword ptr [ebp], ebx
102a971d  83 c6 02                 add      esi, 2
102a9720  81 c3 02 00 02 00        add      ebx, 0x20002
102a9726  66 89 07                 mov      word ptr [edi], ax
102a9729  83 c7 02                 add      edi, 2
102a972c  83 c5 04                 add      ebp, 4
102a972f  83 e9 02                 sub      ecx, 2
102a9732  75 e3                    jne      0x102a9717
102a9734  58                       pop      eax
102a9735  8b d8                    mov      ebx, eax
102a9737  3b 3c 24                 cmp      edi, dword ptr [esp]
102a973a  0f 87 b8 03 00 00        ja       0x102a9af8
102a9740  3b 74 24 04              cmp      esi, dword ptr [esp + 4]
102a9744  0f 87 ae 03 00 00        ja       0x102a9af8
102a974a  c1 e8 04                 shr      eax, 4
102a974d  83 e3 0f                 and      ebx, 0xf
102a9750  2e ff 24 9d 3e 90 2a 10  jmp      dword ptr cs:[ebx*4 + 0x102a903e]
102a9758  87 db                    xchg     ebx, ebx
102a975a  8b 16                    mov      edx, dword ptr [esi]
102a975c  8d 76 04                 lea      esi, [esi + 4]
102a975f  d1 da                    rcr      edx, 1
102a9761  e9 7c ff ff ff           jmp      0x102a96e2
102a9766  8b 16                    mov      edx, dword ptr [esi]
102a9768  8d 76 04                 lea      esi, [esi + 4]
102a976b  d1 da                    rcr      edx, 1
102a976d  e9 7a ff ff ff           jmp      0x102a96ec
102a9772  8b d8                    mov      ebx, eax
102a9774  d1 e8                    shr      eax, 1
102a9776  74 76                    je       0x102a97ee
102a9778  90                       nop      
102a9779  90                       nop      
102a977a  90                       nop      
102a977b  90                       nop      
