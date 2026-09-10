; ======================================================================
; 字符串解密（XOR 0xFF）
; VA 0x102a8ecd .. 0x102a8eed   file 0x3ecd .. 0x3eed   (32 bytes)
; ======================================================================

102a8ecd  53                       push     ebx
102a8ece  51                       push     ecx
102a8ecf  89 c3                    mov      ebx, eax
102a8ed1  89 d0                    mov      eax, edx
102a8ed3  8a 0b                    mov      cl, byte ptr [ebx]
102a8ed5  43                       inc      ebx
102a8ed6  84 c9                    test     cl, cl
102a8ed8  74 08                    je       0x102a8ee2
102a8eda  80 f1 ff                 xor      cl, 0xff
102a8edd  88 08                    mov      byte ptr [eax], cl
102a8edf  40                       inc      eax
102a8ee0  eb f1                    jmp      0x102a8ed3
102a8ee2  88 08                    mov      byte ptr [eax], cl
102a8ee4  89 d0                    mov      eax, edx
102a8ee6  59                       pop      ecx
102a8ee7  5b                       pop      ebx
102a8ee8  c3                       ret      
102a8ee9  53                       push     ebx
102a8eea  51                       push     ecx
102a8eeb  89 d3                    mov      ebx, edx
