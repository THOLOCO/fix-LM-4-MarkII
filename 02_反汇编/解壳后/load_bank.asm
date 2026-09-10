; ======================================================================
; Bank 加载 (解析 fxb)
; RVA 0xec750 .. 0xec9f0   VA 0x100ec750 .. 0x100ec9f0   (672 bytes)
; ======================================================================

100ec750  55                       push     ebp
100ec751  8b ec                    mov      ebp, esp
100ec753  6a ff                    push     -1
100ec755  68 c0 c9 0e 10           push     0x100ec9c0
100ec75a  64 a1 00 00 00 00        mov      eax, dword ptr fs:[0]
100ec760  50                       push     eax
100ec761  64 89 25 00 00 00 00     mov      dword ptr fs:[0], esp
100ec768  83 ec 50                 sub      esp, 0x50
100ec76b  89 7c 24 08              mov      dword ptr [esp + 8], edi
100ec76f  89 74 24 04              mov      dword ptr [esp + 4], esi
100ec773  89 1c 24                 mov      dword ptr [esp], ebx
100ec776  89 65 f0                 mov      dword ptr [ebp - 0x10], esp
100ec779  8b 45 08                 mov      eax, dword ptr [ebp + 8]
100ec77c  89 4d e4                 mov      dword ptr [ebp - 0x1c], ecx
100ec77f  8d 4d c4                 lea      ecx, [ebp - 0x3c]
100ec782  c7 45 c0 00 00 00 00     mov      dword ptr [ebp - 0x40], 0
100ec789  50                       push     eax
100ec78a  e8 d1 9a f3 ff           call     0x10026260
100ec78f  c7 45 fc 00 00 00 00     mov      dword ptr [ebp - 4], 0
100ec796  b8 01 00 00 00           mov      eax, 1
100ec79b  8d 4d c4                 lea      ecx, [ebp - 0x3c]
100ec79e  50                       push     eax
100ec79f  89 45 d0                 mov      dword ptr [ebp - 0x30], eax
100ec7a2  e8 39 9c f3 ff           call     0x100263e0
100ec7a7  0f be c0                 movsx    eax, al
100ec7aa  85 c0                    test     eax, eax
100ec7ac  75 2c                    jne      0x100ec7da
100ec7ae  c7 45 fc ff ff ff ff     mov      dword ptr [ebp - 4], 0xffffffff
100ec7b5  8d 4d c4                 lea      ecx, [ebp - 0x3c]
100ec7b8  e8 73 9b f3 ff           call     0x10026330
100ec7bd  33 c0                    xor      eax, eax
100ec7bf  8b 4d f4                 mov      ecx, dword ptr [ebp - 0xc]
100ec7c2  64 89 0d 00 00 00 00     mov      dword ptr fs:[0], ecx
100ec7c9  8b 1c 24                 mov      ebx, dword ptr [esp]
100ec7cc  8b 74 24 04              mov      esi, dword ptr [esp + 4]
100ec7d0  8b 7c 24 08              mov      edi, dword ptr [esp + 8]
100ec7d4  8b e5                    mov      esp, ebp
100ec7d6  5d                       pop      ebp
100ec7d7  c2 04 00                 ret      4
100ec7da  8d 45 c0                 lea      eax, [ebp - 0x40]
100ec7dd  8d 4d c4                 lea      ecx, [ebp - 0x3c]
100ec7e0  50                       push     eax
100ec7e1  e8 ba a1 f3 ff           call     0x100269a0
100ec7e6  8b 45 c0                 mov      eax, dword ptr [ebp - 0x40]
100ec7e9  3d 4b 6e 63 43           cmp      eax, 0x43636e4b
100ec7ee  74 2c                    je       0x100ec81c
100ec7f0  c7 45 fc ff ff ff ff     mov      dword ptr [ebp - 4], 0xffffffff
100ec7f7  8d 4d c4                 lea      ecx, [ebp - 0x3c]
100ec7fa  e8 31 9b f3 ff           call     0x10026330
100ec7ff  33 c0                    xor      eax, eax
100ec801  8b 4d f4                 mov      ecx, dword ptr [ebp - 0xc]
100ec804  64 89 0d 00 00 00 00     mov      dword ptr fs:[0], ecx
100ec80b  8b 1c 24                 mov      ebx, dword ptr [esp]
100ec80e  8b 74 24 04              mov      esi, dword ptr [esp + 4]
100ec812  8b 7c 24 08              mov      edi, dword ptr [esp + 8]
100ec816  8b e5                    mov      esp, ebp
100ec818  5d                       pop      ebp
100ec819  c2 04 00                 ret      4
100ec81c  57                       push     edi
100ec81d  8d 45 c0                 lea      eax, [ebp - 0x40]
100ec820  8d 4d c4                 lea      ecx, [ebp - 0x3c]
100ec823  89 04 24                 mov      dword ptr [esp], eax
100ec826  e8 75 a1 f3 ff           call     0x100269a0
100ec82b  8d 45 c0                 lea      eax, [ebp - 0x40]
100ec82e  8d 4d c4                 lea      ecx, [ebp - 0x3c]
100ec831  50                       push     eax
100ec832  e8 69 a1 f3 ff           call     0x100269a0
100ec837  8b 45 c0                 mov      eax, dword ptr [ebp - 0x40]
100ec83a  3d 68 43 42 46           cmp      eax, 0x46424368
100ec83f  74 2c                    je       0x100ec86d
100ec841  c7 45 fc ff ff ff ff     mov      dword ptr [ebp - 4], 0xffffffff
100ec848  8d 4d c4                 lea      ecx, [ebp - 0x3c]
100ec84b  e8 e0 9a f3 ff           call     0x10026330
100ec850  33 c0                    xor      eax, eax
100ec852  8b 4d f4                 mov      ecx, dword ptr [ebp - 0xc]
100ec855  64 89 0d 00 00 00 00     mov      dword ptr fs:[0], ecx
100ec85c  8b 1c 24                 mov      ebx, dword ptr [esp]
100ec85f  8b 74 24 04              mov      esi, dword ptr [esp + 4]
100ec863  8b 7c 24 08              mov      edi, dword ptr [esp + 8]
100ec867  8b e5                    mov      esp, ebp
100ec869  5d                       pop      ebp
100ec86a  c2 04 00                 ret      4
100ec86d  57                       push     edi
100ec86e  8d 45 c0                 lea      eax, [ebp - 0x40]
100ec871  8d 4d c4                 lea      ecx, [ebp - 0x3c]
100ec874  89 04 24                 mov      dword ptr [esp], eax
100ec877  e8 24 a1 f3 ff           call     0x100269a0
100ec87c  8d 45 c0                 lea      eax, [ebp - 0x40]
100ec87f  8d 4d c4                 lea      ecx, [ebp - 0x3c]
100ec882  50                       push     eax
100ec883  e8 18 a1 f3 ff           call     0x100269a0
100ec888  8b 45 c0                 mov      eax, dword ptr [ebp - 0x40]
100ec88b  3d 32 34 4d 4c           cmp      eax, 0x4c4d3432
100ec890  74 2e                    je       0x100ec8c0
100ec892  74 2c                    je       0x100ec8c0
100ec894  c7 45 fc ff ff ff ff     mov      dword ptr [ebp - 4], 0xffffffff
100ec89b  8d 4d c4                 lea      ecx, [ebp - 0x3c]
100ec89e  e8 8d 9a f3 ff           call     0x10026330
100ec8a3  33 c0                    xor      eax, eax
100ec8a5  8b 4d f4                 mov      ecx, dword ptr [ebp - 0xc]
100ec8a8  64 89 0d 00 00 00 00     mov      dword ptr fs:[0], ecx
100ec8af  8b 1c 24                 mov      ebx, dword ptr [esp]
100ec8b2  8b 74 24 04              mov      esi, dword ptr [esp + 4]
100ec8b6  8b 7c 24 08              mov      edi, dword ptr [esp + 8]
100ec8ba  8b e5                    mov      esp, ebp
100ec8bc  5d                       pop      ebp
100ec8bd  c2 04 00                 ret      4
100ec8c0  57                       push     edi
100ec8c1  8d 45 c0                 lea      eax, [ebp - 0x40]
100ec8c4  8d 4d c4                 lea      ecx, [ebp - 0x3c]
100ec8c7  89 04 24                 mov      dword ptr [esp], eax
100ec8ca  e8 d1 a0 f3 ff           call     0x100269a0
100ec8cf  8d 45 c0                 lea      eax, [ebp - 0x40]
100ec8d2  8d 4d c4                 lea      ecx, [ebp - 0x3c]
100ec8d5  50                       push     eax
100ec8d6  e8 c5 a0 f3 ff           call     0x100269a0
100ec8db  8b 45 c0                 mov      eax, dword ptr [ebp - 0x40]
100ec8de  85 c0                    test     eax, eax
100ec8e0  7d 2c                    jge      0x100ec90e
100ec8e2  c7 45 fc ff ff ff ff     mov      dword ptr [ebp - 4], 0xffffffff
100ec8e9  8d 4d c4                 lea      ecx, [ebp - 0x3c]
100ec8ec  e8 3f 9a f3 ff           call     0x10026330
100ec8f1  33 c0                    xor      eax, eax
100ec8f3  8b 4d f4                 mov      ecx, dword ptr [ebp - 0xc]
100ec8f6  64 89 0d 00 00 00 00     mov      dword ptr fs:[0], ecx
100ec8fd  8b 1c 24                 mov      ebx, dword ptr [esp]
100ec900  8b 74 24 04              mov      esi, dword ptr [esp + 4]
100ec904  8b 7c 24 08              mov      edi, dword ptr [esp + 8]
100ec908  8b e5                    mov      esp, ebp
100ec90a  5d                       pop      ebp
100ec90b  c2 04 00                 ret      4
100ec90e  83 c4 f8                 add      esp, -8
100ec911  8d 4d c4                 lea      ecx, [ebp - 0x3c]
100ec914  c7 44 24 04 01 00 00 00  mov      dword ptr [esp + 4], 1
100ec91c  c7 04 24 80 00 00 00     mov      dword ptr [esp], 0x80
100ec923  e8 48 9c f3 ff           call     0x10026570
100ec928  57                       push     edi
100ec929  8d 45 c0                 lea      eax, [ebp - 0x40]
100ec92c  8d 4d c4                 lea      ecx, [ebp - 0x3c]
100ec92f  89 04 24                 mov      dword ptr [esp], eax
100ec932  e8 69 a0 f3 ff           call     0x100269a0
100ec937  8b 4d e4                 mov      ecx, dword ptr [ebp - 0x1c]
100ec93a  8b 11                    mov      edx, dword ptr [ecx]
100ec93c  8d 5d c4                 lea      ebx, [ebp - 0x3c]
100ec93f  8b 82 30 02 00 00        mov      eax, dword ptr [edx + 0x230]
100ec945  53                       push     ebx
100ec946  ff d0                    call     eax
100ec948  8d 4d c4                 lea      ecx, [ebp - 0x3c]
100ec94b  e8 a0 a3 f3 ff           call     0x10026cf0
100ec950  8b 4d e4                 mov      ecx, dword ptr [ebp - 0x1c]
100ec953  83 c4 f8                 add      esp, -8
100ec956  8b 11                    mov      edx, dword ptr [ecx]
100ec958  8b 5d 08                 mov      ebx, dword ptr [ebp + 8]
100ec95b  8b 82 20 02 00 00        mov      eax, dword ptr [edx + 0x220]
100ec961  89 1c 24                 mov      dword ptr [esp], ebx
100ec964  c6 44 24 04 00           mov      byte ptr [esp + 4], 0
100ec969  ff d0                    call     eax
100ec96b  8b 4d e4                 mov      ecx, dword ptr [ebp - 0x1c]
100ec96e  81 c1 6c 01 00 00        add      ecx, 0x16c
100ec974  8b c3                    mov      eax, ebx
100ec976  50                       push     eax
100ec977  e8 e4 c8 f5 ff           call     0x10049260
100ec97c  c7 45 fc ff ff ff ff     mov      dword ptr [ebp - 4], 0xffffffff
100ec983  8d 4d c4                 lea      ecx, [ebp - 0x3c]
100ec986  e8 a5 99 f3 ff           call     0x10026330
100ec98b  b8 01 00 00 00           mov      eax, 1
100ec990  8b 4d f4                 mov      ecx, dword ptr [ebp - 0xc]
100ec993  64 89 0d 00 00 00 00     mov      dword ptr fs:[0], ecx
100ec99a  8b 1c 24                 mov      ebx, dword ptr [esp]
100ec99d  8b 74 24 04              mov      esi, dword ptr [esp + 4]
100ec9a1  8b 7c 24 08              mov      edi, dword ptr [esp + 8]
100ec9a5  8b e5                    mov      esp, ebp
100ec9a7  5d                       pop      ebp
100ec9a8  c2 04 00                 ret      4
100ec9ab  8d 4d c4                 lea      ecx, [ebp - 0x3c]
100ec9ae  e8 7d 99 f3 ff           call     0x10026330
100ec9b3  c3                       ret      
100ec9b4  8d b6 00 00 00 00        lea      esi, [esi]
100ec9ba  8d bf 00 00 00 00        lea      edi, [edi]
100ec9c0  b8 78 03 1a 10           mov      eax, 0x101a0378
100ec9c5  e9 95 a3 00 00           jmp      0x100f6d5f
100ec9ca  90                       nop      
100ec9cb  90                       nop      
100ec9cc  90                       nop      
100ec9cd  90                       nop      
100ec9ce  90                       nop      
100ec9cf  90                       nop      
100ec9d0  55                       push     ebp
100ec9d1  8b ec                    mov      ebp, esp
100ec9d3  6a ff                    push     -1
100ec9d5  68 90 cc 0e 10           push     0x100ecc90
100ec9da  64 a1 00 00 00 00        mov      eax, dword ptr fs:[0]
100ec9e0  50                       push     eax
100ec9e1  64 89 25 00 00 00 00     mov      dword ptr fs:[0], esp
100ec9e8  81 ec d0 00 00 00        sub      esp, 0xd0
