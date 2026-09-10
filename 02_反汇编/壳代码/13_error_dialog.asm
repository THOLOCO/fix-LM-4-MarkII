; ======================================================================
; 错误提示
; VA 0x102a848a .. 0x102a84ea   file 0x348a .. 0x34ea   (96 bytes)
; ======================================================================

102a848a  53                       push     ebx
102a848b  52                       push     edx
102a848c  c8 00 01 00              enter    0x100, 0
102a8490  89 c3                    mov      ebx, eax
102a8492  8d 95 00 ff ff ff        lea      edx, [ebp - 0x100]
102a8498  b8 c6 83 2a 10           mov      eax, 0x102a83c6
102a849d  e8 2b 0a 00 00           call     0x102a8ecd
102a84a2  89 c2                    mov      edx, eax
102a84a4  89 d8                    mov      eax, ebx
102a84a6  e8 c4 0a 00 00           call     0x102a8f6f
102a84ab  c9                       leave    
102a84ac  5a                       pop      edx
102a84ad  5b                       pop      ebx
102a84ae  c3                       ret      
102a84af  53                       push     ebx
102a84b0  52                       push     edx
102a84b1  c8 00 01 00              enter    0x100, 0
102a84b5  89 c3                    mov      ebx, eax
102a84b7  8d 95 00 ff ff ff        lea      edx, [ebp - 0x100]
102a84bd  b8 e1 83 2a 10           mov      eax, 0x102a83e1
102a84c2  eb d9                    jmp      0x102a849d
102a84c4  53                       push     ebx
102a84c5  52                       push     edx
102a84c6  c8 00 01 00              enter    0x100, 0
102a84ca  89 c3                    mov      ebx, eax
102a84cc  8d 95 00 ff ff ff        lea      edx, [ebp - 0x100]
102a84d2  b8 ff 83 2a 10           mov      eax, 0x102a83ff
102a84d7  eb c4                    jmp      0x102a849d
102a84d9  53                       push     ebx
102a84da  56                       push     esi
102a84db  57                       push     edi
102a84dc  c8 00 02 00              enter    0x200, 0
102a84e0  89 c3                    mov      ebx, eax
102a84e2  89 d6                    mov      esi, edx
102a84e4  8d 95 00 fe ff ff        lea      edx, [ebp - 0x200]
