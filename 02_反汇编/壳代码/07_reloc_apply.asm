; ======================================================================
; 重定位应用
; VA 0x102a8e04 .. 0x102a8ec4   file 0x3e04 .. 0x3ec4   (192 bytes)
; ======================================================================

102a8e04  56                       push     esi
102a8e05  57                       push     edi
102a8e06  c8 10 00 00              enter    0x10, 0
102a8e0a  89 c7                    mov      edi, eax
102a8e0c  89 d6                    mov      esi, edx
102a8e0e  89 4d f4                 mov      dword ptr [ebp - 0xc], ecx
102a8e11  8b 03                    mov      eax, dword ptr [ebx]
102a8e13  89 45 fc                 mov      dword ptr [ebp - 4], eax
102a8e16  85 c0                    test     eax, eax
102a8e18  75 1d                    jne      0x102a8e37
102a8e1a  ff 75 10                 push     dword ptr [ebp + 0x10]
102a8e1d  50                       push     eax
102a8e1e  ff 15 82 84 2a 10        call     dword ptr [0x102a8482]
102a8e24  89 45 fc                 mov      dword ptr [ebp - 4], eax
102a8e27  85 c0                    test     eax, eax
102a8e29  75 07                    jne      0x102a8e32
102a8e2b  89 f8                    mov      eax, edi
102a8e2d  e8 58 f6 ff ff           call     0x102a848a
102a8e32  8b 45 fc                 mov      eax, dword ptr [ebp - 4]
102a8e35  89 03                    mov      dword ptr [ebx], eax
102a8e37  8b 4d f4                 mov      ecx, dword ptr [ebp - 0xc]
102a8e3a  8b 06                    mov      eax, dword ptr [esi]
102a8e3c  8d 55 f0                 lea      edx, [ebp - 0x10]
102a8e3f  89 45 f8                 mov      dword ptr [ebp - 8], eax
102a8e42  8b 45 10                 mov      eax, dword ptr [ebp + 0x10]
102a8e45  8b 5d f8                 mov      ebx, dword ptr [ebp - 8]
102a8e48  89 45 f0                 mov      dword ptr [ebp - 0x10], eax
102a8e4b  8b 45 fc                 mov      eax, dword ptr [ebp - 4]
102a8e4e  e8 23 0d 00 00           call     0x102a9b76
102a8e53  85 c0                    test     eax, eax
102a8e55  74 09                    je       0x102a8e60
102a8e57  89 c2                    mov      edx, eax
102a8e59  89 f8                    mov      eax, edi
102a8e5b  e8 af f7 ff ff           call     0x102a860f
102a8e60  8b 45 f8                 mov      eax, dword ptr [ebp - 8]
102a8e63  03 45 f4                 add      eax, dword ptr [ebp - 0xc]
102a8e66  89 06                    mov      dword ptr [esi], eax
102a8e68  c9                       leave    
102a8e69  5f                       pop      edi
102a8e6a  5e                       pop      esi
102a8e6b  c2 08 00                 ret      8
102a8e6e  56                       push     esi
102a8e6f  57                       push     edi
102a8e70  c8 10 00 00              enter    0x10, 0
102a8e74  89 d6                    mov      esi, edx
102a8e76  89 5d f0                 mov      dword ptr [ebp - 0x10], ebx
102a8e79  89 4d f4                 mov      dword ptr [ebp - 0xc], ecx
102a8e7c  85 f6                    test     esi, esi
102a8e7e  74 49                    je       0x102a8ec9
102a8e80  8b 55 f4                 mov      edx, dword ptr [ebp - 0xc]
102a8e83  03 10                    add      edx, dword ptr [eax]
102a8e85  8b 48 04                 mov      ecx, dword ptr [eax + 4]
102a8e88  89 55 f8                 mov      dword ptr [ebp - 8], edx
102a8e8b  85 c9                    test     ecx, ecx
102a8e8d  74 3a                    je       0x102a8ec9
102a8e8f  8d 51 f8                 lea      edx, [ecx - 8]
102a8e92  d1 ea                    shr      edx, 1
102a8e94  8d 58 08                 lea      ebx, [eax + 8]
102a8e97  89 55 fc                 mov      dword ptr [ebp - 4], edx
102a8e9a  ff 4d fc                 dec      dword ptr [ebp - 4]
102a8e9d  83 7d fc ff              cmp      dword ptr [ebp - 4], -1
102a8ea1  74 20                    je       0x102a8ec3
102a8ea3  66 8b 13                 mov      dx, word ptr [ebx]
102a8ea6  0f b7 fa                 movzx    edi, dx
102a8ea9  c1 ff 0c                 sar      edi, 0xc
102a8eac  43                       inc      ebx
102a8ead  43                       inc      ebx
102a8eae  83 ff 03                 cmp      edi, 3
102a8eb1  75 e7                    jne      0x102a8e9a
102a8eb3  80 e6 0f                 and      dh, 0xf
102a8eb6  0f b7 d2                 movzx    edx, dx
102a8eb9  03 55 f8                 add      edx, dword ptr [ebp - 8]
102a8ebc  8b 7d f0                 mov      edi, dword ptr [ebp - 0x10]
102a8ebf  01 3a                    add      dword ptr [edx], edi
102a8ec1  eb d7                    jmp      0x102a8e9a
