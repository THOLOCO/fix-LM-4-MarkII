; ======================================================================
; 导出表（数据）
; VA 0x102a81b4 .. 0x102a8204   file 0x31b4 .. 0x3204   (80 bytes)
; ======================================================================

102a81b4  00 00                    add      byte ptr [eax], al
102a81b6  00 00                    add      byte ptr [eax], al
102a81b8  a9 7a bc 3b 00           test     eax, 0x3bbc7a
102a81bd  00 00                    add      byte ptr [eax], al
102a81bf  00 e6                    add      dh, ah
102a81c1  81 2a 00 01 00 00        sub      dword ptr [edx], 0x100
102a81c7  00 01                    add      byte ptr [ecx], al
102a81c9  00 00                    add      byte ptr [eax], al
102a81cb  00 01                    add      byte ptr [ecx], al
102a81cd  00 00                    add      byte ptr [eax], al
102a81cf  00 dc                    add      ah, bl
102a81d1  81 2a 00 e0 81 2a        sub      dword ptr [edx], 0x2a81e000
102a81d7  00 e4                    add      ah, ah
102a81d9  81 2a 00 e0 b8 01        sub      dword ptr [edx], 0x1b8e000
102a81df  00 f5                    add      ch, dh
102a81e1  81 2a 00 00 00 4c        sub      dword ptr [edx], 0x4c000000
102a81e7  4d                       dec      ebp
102a81e8  34 2d                    xor      al, 0x2d
102a81ea  4d                       dec      ebp
102a81eb  41                       inc      ecx
102a81ec  52                       push     edx
102a81ed  4b                       dec      ebx
102a81ee  49                       dec      ecx
102a81ef  49                       dec      ecx
102a81f0  2e 64 6c                 insb     byte ptr es:[edi], dx
102a81f3  6c                       insb     byte ptr es:[edi], dx
102a81f4  00 6d 61                 add      byte ptr [ebp + 0x61], ch
102a81f7  69 6e 00 e9 a6 00 00     imul     ebp, dword ptr [esi], 0xa6e9
102a81fe  00 0a                    add      byte ptr [edx], cl
102a8200  9b                       wait     
102a8201  2a 10                    sub      dl, byte ptr [eax]
