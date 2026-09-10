; ======================================================================
; DllMain 入口
; VA 0x102a81fa .. 0x102a822a   file 0x31fa .. 0x322a   (48 bytes)
; ======================================================================

102a81fa  e9 a6 00 00 00           jmp      0x102a82a5
102a81ff  0a 9b 2a 10 a0 80        or       bl, byte ptr [ebx - 0x7f5fefd6]
102a8205  2a 10                    sub      dl, byte ptr [eax]
102a8207  a4                       movsb    byte ptr es:[edi], byte ptr [esi]
102a8208  80 2a 10                 sub      byte ptr [edx], 0x10
