; ======================================================================
; 跳转到 OEP
; VA 0x102a8dee .. 0x102a8e0e   file 0x3dee .. 0x3e0e   (32 bytes)
; ======================================================================

102a8dee  8b 85 96 fd ff ff        mov      eax, dword ptr [ebp - 0x26a]
102a8df4  03 45 aa                 add      eax, dword ptr [ebp - 0x56]
102a8df7  8d a5 82 00 00 00        lea      esp, [ebp + 0x82]
102a8dfd  5d                       pop      ebp
102a8dfe  5f                       pop      edi
102a8dff  5e                       pop      esi
102a8e00  5a                       pop      edx
102a8e01  59                       pop      ecx
102a8e02  5b                       pop      ebx
102a8e03  c3                       ret      
102a8e04  56                       push     esi
102a8e05  57                       push     edi
102a8e06  c8 10 00 00              enter    0x10, 0
102a8e0a  89 c7                    mov      edi, eax
102a8e0c  89 d6                    mov      esi, edx
