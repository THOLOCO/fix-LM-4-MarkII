; ======================================================================
; 主加载器
; VA 0x102a8625 .. 0x102a88d5   file 0x3625 .. 0x38d5   (688 bytes)
; ======================================================================

102a8625  53                       push     ebx
102a8626  51                       push     ecx
102a8627  52                       push     edx
102a8628  56                       push     esi
102a8629  57                       push     edi
102a862a  c8 e8 02 00              enter    0x2e8, 0
102a862e  50                       push     eax
102a862f  81 ed 82 00 00 00        sub      ebp, 0x82
102a8635  8d 95 9e fe ff ff        lea      edx, [ebp - 0x162]
102a863b  b8 d9 82 2a 10           mov      eax, 0x102a82d9
102a8640  8b 1d 03 82 2a 10        mov      ebx, dword ptr [0x102a8203]
102a8646  e8 82 08 00 00           call     0x102a8ecd
102a864b  50                       push     eax
102a864c  ff 13                    call     dword ptr [ebx]
102a864e  8d 95 9e fe ff ff        lea      edx, [ebp - 0x162]
102a8654  89 c6                    mov      esi, eax
102a8656  89 c3                    mov      ebx, eax
102a8658  b8 f9 82 2a 10           mov      eax, 0x102a82f9
102a865d  8b 3d 07 82 2a 10        mov      edi, dword ptr [0x102a8207]
102a8663  e8 65 08 00 00           call     0x102a8ecd
102a8668  50                       push     eax
102a8669  56                       push     esi
102a866a  ff 17                    call     dword ptr [edi]
102a866c  89 45 f2                 mov      dword ptr [ebp - 0xe], eax
102a866f  83 bd 96 fd ff ff 00     cmp      dword ptr [ebp - 0x26a], 0
102a8676  75 0b                    jne      0x102a8683
102a8678  6a 00                    push     0
102a867a  ff 55 f2                 call     dword ptr [ebp - 0xe]
102a867d  89 85 96 fd ff ff        mov      dword ptr [ebp - 0x26a], eax
102a8683  8d 95 9e fe ff ff        lea      edx, [ebp - 0x162]
102a8689  b8 0a 83 2a 10           mov      eax, 0x102a830a
102a868e  8b 35 07 82 2a 10        mov      esi, dword ptr [0x102a8207]
102a8694  e8 34 08 00 00           call     0x102a8ecd
102a8699  50                       push     eax
102a869a  53                       push     ebx
102a869b  ff 16                    call     dword ptr [esi]
102a869d  68 04 01 00 00           push     0x104
102a86a2  89 45 ae                 mov      dword ptr [ebp - 0x52], eax
102a86a5  8d 85 9a fd ff ff        lea      eax, [ebp - 0x266]
102a86ab  50                       push     eax
102a86ac  ff b5 96 fd ff ff        push     dword ptr [ebp - 0x26a]
102a86b2  ff 55 ae                 call     dword ptr [ebp - 0x52]
102a86b5  8b 85 96 fd ff ff        mov      eax, dword ptr [ebp - 0x26a]
102a86bb  89 c7                    mov      edi, eax
102a86bd  03 78 3c                 add      edi, dword ptr [eax + 0x3c]
102a86c0  8d 47 18                 lea      eax, [edi + 0x18]
102a86c3  0f b7 57 14              movzx    edx, word ptr [edi + 0x14]
102a86c7  01 d0                    add      eax, edx
102a86c9  89 45 1e                 mov      dword ptr [ebp + 0x1e], eax
102a86cc  0f b7 47 06              movzx    eax, word ptr [edi + 6]
102a86d0  8d 95 9e fe ff ff        lea      edx, [ebp - 0x162]
102a86d6  89 45 2a                 mov      dword ptr [ebp + 0x2a], eax
102a86d9  b8 e2 82 2a 10           mov      eax, 0x102a82e2
102a86de  8b 35 07 82 2a 10        mov      esi, dword ptr [0x102a8207]
102a86e4  e8 e4 07 00 00           call     0x102a8ecd
102a86e9  50                       push     eax
102a86ea  53                       push     ebx
102a86eb  ff 16                    call     dword ptr [esi]
102a86ed  8d 95 9e fe ff ff        lea      edx, [ebp - 0x162]
102a86f3  89 45 fa                 mov      dword ptr [ebp - 6], eax
102a86f6  b8 1d 83 2a 10           mov      eax, 0x102a831d
102a86fb  8b 35 07 82 2a 10        mov      esi, dword ptr [0x102a8207]
102a8701  e8 c7 07 00 00           call     0x102a8ecd
102a8706  50                       push     eax
102a8707  53                       push     ebx
102a8708  ff 16                    call     dword ptr [esi]
102a870a  8d 95 9e fe ff ff        lea      edx, [ebp - 0x162]
102a8710  89 45 e2                 mov      dword ptr [ebp - 0x1e], eax
102a8713  b8 29 83 2a 10           mov      eax, 0x102a8329
102a8718  8b 35 07 82 2a 10        mov      esi, dword ptr [0x102a8207]
102a871e  e8 aa 07 00 00           call     0x102a8ecd
102a8723  50                       push     eax
102a8724  53                       push     ebx
102a8725  ff 16                    call     dword ptr [esi]
102a8727  8d 95 9e fe ff ff        lea      edx, [ebp - 0x162]
102a872d  89 45 e6                 mov      dword ptr [ebp - 0x1a], eax
102a8730  b8 3c 83 2a 10           mov      eax, 0x102a833c
102a8735  8b 35 07 82 2a 10        mov      esi, dword ptr [0x102a8207]
102a873b  e8 8d 07 00 00           call     0x102a8ecd
102a8740  50                       push     eax
102a8741  53                       push     ebx
102a8742  ff 16                    call     dword ptr [esi]
102a8744  89 45 da                 mov      dword ptr [ebp - 0x26], eax
102a8747  8d 95 9e fe ff ff        lea      edx, [ebp - 0x162]
102a874d  b8 4a 83 2a 10           mov      eax, 0x102a834a
102a8752  8b 35 07 82 2a 10        mov      esi, dword ptr [0x102a8207]
102a8758  e8 70 07 00 00           call     0x102a8ecd
102a875d  50                       push     eax
102a875e  53                       push     ebx
102a875f  ff 16                    call     dword ptr [esi]
102a8761  8d 95 9e fe ff ff        lea      edx, [ebp - 0x162]
102a8767  89 45 9e                 mov      dword ptr [ebp - 0x62], eax
102a876a  b8 5a 83 2a 10           mov      eax, 0x102a835a
102a876f  8b 35 07 82 2a 10        mov      esi, dword ptr [0x102a8207]
102a8775  e8 53 07 00 00           call     0x102a8ecd
102a877a  50                       push     eax
102a877b  53                       push     ebx
102a877c  ff 16                    call     dword ptr [esi]
102a877e  8d 95 9e fe ff ff        lea      edx, [ebp - 0x162]
102a8784  89 45 0e                 mov      dword ptr [ebp + 0xe], eax
102a8787  b8 66 83 2a 10           mov      eax, 0x102a8366
102a878c  8b 35 07 82 2a 10        mov      esi, dword ptr [0x102a8207]
102a8792  e8 36 07 00 00           call     0x102a8ecd
102a8797  50                       push     eax
102a8798  53                       push     ebx
102a8799  ff 16                    call     dword ptr [esi]
102a879b  8d 95 9e fe ff ff        lea      edx, [ebp - 0x162]
102a87a1  89 45 6e                 mov      dword ptr [ebp + 0x6e], eax
102a87a4  b8 75 83 2a 10           mov      eax, 0x102a8375
102a87a9  8b 35 07 82 2a 10        mov      esi, dword ptr [0x102a8207]
102a87af  e8 19 07 00 00           call     0x102a8ecd
102a87b4  50                       push     eax
102a87b5  53                       push     ebx
102a87b6  ff 16                    call     dword ptr [esi]
102a87b8  8d 95 9e fe ff ff        lea      edx, [ebp - 0x162]
102a87be  89 45 de                 mov      dword ptr [ebp - 0x22], eax
102a87c1  b8 87 83 2a 10           mov      eax, 0x102a8387
102a87c6  8b 35 07 82 2a 10        mov      esi, dword ptr [0x102a8207]
102a87cc  e8 fc 06 00 00           call     0x102a8ecd
102a87d1  50                       push     eax
102a87d2  53                       push     ebx
102a87d3  ff 16                    call     dword ptr [esi]
102a87d5  8d 95 9e fe ff ff        lea      edx, [ebp - 0x162]
102a87db  89 45 06                 mov      dword ptr [ebp + 6], eax
102a87de  b8 ee 82 2a 10           mov      eax, 0x102a82ee
102a87e3  8b 35 07 82 2a 10        mov      esi, dword ptr [0x102a8207]
102a87e9  e8 df 06 00 00           call     0x102a8ecd
102a87ee  50                       push     eax
102a87ef  53                       push     ebx
102a87f0  ff 16                    call     dword ptr [esi]
102a87f2  6a 00                    push     0
102a87f4  68 80 00 00 00           push     0x80
102a87f9  6a 03                    push     3
102a87fb  6a 00                    push     0
102a87fd  6a 01                    push     1
102a87ff  68 00 00 00 80           push     0x80000000
102a8804  89 45 5a                 mov      dword ptr [ebp + 0x5a], eax
102a8807  8d 85 9a fd ff ff        lea      eax, [ebp - 0x266]
102a880d  50                       push     eax
102a880e  ff 55 e2                 call     dword ptr [ebp - 0x1e]
102a8811  89 45 42                 mov      dword ptr [ebp + 0x42], eax
102a8814  83 f8 ff                 cmp      eax, -1
102a8817  75 0b                    jne      0x102a8824
102a8819  8d 85 9a fd ff ff        lea      eax, [ebp - 0x266]
102a881f  e8 a0 fc ff ff           call     0x102a84c4
102a8824  6a 00                    push     0
102a8826  6a 00                    push     0
102a8828  6a 00                    push     0
102a882a  6a 02                    push     2
102a882c  6a 00                    push     0
102a882e  ff 75 42                 push     dword ptr [ebp + 0x42]
102a8831  ff 55 e6                 call     dword ptr [ebp - 0x1a]
102a8834  89 45 0a                 mov      dword ptr [ebp + 0xa], eax
102a8837  85 c0                    test     eax, eax
102a8839  75 0b                    jne      0x102a8846
102a883b  8d 85 9a fd ff ff        lea      eax, [ebp - 0x266]
102a8841  e8 7e fc ff ff           call     0x102a84c4
102a8846  6a 00                    push     0
102a8848  6a 00                    push     0
102a884a  6a 00                    push     0
102a884c  6a 04                    push     4
102a884e  ff 75 0a                 push     dword ptr [ebp + 0xa]
102a8851  ff 55 da                 call     dword ptr [ebp - 0x26]
102a8854  89 45 12                 mov      dword ptr [ebp + 0x12], eax
102a8857  85 c0                    test     eax, eax
102a8859  75 0b                    jne      0x102a8866
102a885b  8d 85 9a fd ff ff        lea      eax, [ebp - 0x266]
102a8861  e8 5e fc ff ff           call     0x102a84c4
102a8866  8b 75 12                 mov      esi, dword ptr [ebp + 0x12]
102a8869  03 35 0f 82 2a 10        add      esi, dword ptr [0x102a820f]
102a886f  81 3e 96 19 18 04        cmp      dword ptr [esi], 0x4181996
102a8875  74 0b                    je       0x102a8882
102a8877  8d 85 9a fd ff ff        lea      eax, [ebp - 0x266]
102a887d  e8 2d fc ff ff           call     0x102a84af
102a8882  8d 46 54                 lea      eax, [esi + 0x54]
102a8885  89 45 52                 mov      dword ptr [ebp + 0x52], eax
102a8888  8b 46 1c                 mov      eax, dword ptr [esi + 0x1c]
102a888b  8b 55 52                 mov      edx, dword ptr [ebp + 0x52]
102a888e  c1 e0 04                 shl      eax, 4
102a8891  68 04 00 01 00           push     0x10004
102a8896  01 c2                    add      edx, eax
102a8898  6a 00                    push     0
102a889a  89 55 b2                 mov      dword ptr [ebp - 0x4e], edx
102a889d  ff 55 fa                 call     dword ptr [ebp - 6]
102a88a0  89 45 6a                 mov      dword ptr [ebp + 0x6a], eax
102a88a3  85 c0                    test     eax, eax
102a88a5  75 0b                    jne      0x102a88b2
102a88a7  8d 85 9a fd ff ff        lea      eax, [ebp - 0x266]
102a88ad  e8 d8 fb ff ff           call     0x102a848a
102a88b2  8b 95 96 fd ff ff        mov      edx, dword ptr [ebp - 0x26a]
102a88b8  8b 4d 6a                 mov      ecx, dword ptr [ebp + 0x6a]
102a88bb  8b 47 28                 mov      eax, dword ptr [edi + 0x28]
102a88be  8b 5e 0c                 mov      ebx, dword ptr [esi + 0xc]
102a88c1  01 c2                    add      edx, eax
102a88c3  8b 45 b2                 mov      eax, dword ptr [ebp - 0x4e]
102a88c6  89 55 1a                 mov      dword ptr [ebp + 0x1a], edx
102a88c9  03 56 08                 add      edx, dword ptr [esi + 8]
102a88cc  e8 01 07 00 00           call     0x102a8fd2
102a88d1  89 45 b2                 mov      dword ptr [ebp - 0x4e], eax
