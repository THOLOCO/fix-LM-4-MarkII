; ======================================================================
; 重定位遍历
; VA 0x102a8e6e .. 0x102a8ece   file 0x3e6e .. 0x3ece   (96 bytes)
; ======================================================================

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
102a8ec3  29 ce                    sub      esi, ecx
102a8ec5  01 c8                    add      eax, ecx
102a8ec7  eb b3                    jmp      0x102a8e7c
102a8ec9  c9                       leave    
102a8eca  5f                       pop      edi
102a8ecb  5e                       pop      esi
102a8ecc  c3                       ret      
102a8ecd  53                       push     ebx
