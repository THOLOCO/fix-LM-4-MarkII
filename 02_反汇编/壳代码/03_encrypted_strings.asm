; ======================================================================
; 加密字符串数据（XOR 0xFF）
; VA 0x102a82d9 .. 0x102a8309   file 0x32d9 .. 0x3309   (48 bytes)
; ======================================================================

102a82d9  94                       xchg     esp, eax
102a82da  9a 8d 91 9a 93 cc cd     lcall    0xcdcc, 0x939a918d
102a82e1  00 b8 93 90 9d 9e        add      byte ptr [eax - 0x61626f6d], bh
102a82e7  93                       xchg     ebx, eax
102a82e8  be 93 93 90 9c           mov      esi, 0x9c909393
102a82ed  00 b8 93 90 9d 9e        add      byte ptr [eax - 0x61626f6d], bh
102a82f3  93                       xchg     ebx, eax
102a82f4  b9 8d 9a 9a 00           mov      ecx, 0x9a9a8d
102a82f9  b8 9a 8b b2 90           mov      eax, 0x90b28b9a
102a82fe  9b                       wait     
102a82ff  8a 93 9a b7 9e 91        mov      dl, byte ptr [ebx - 0x6e614866]
102a8305  9b                       wait     
102a8306  93                       xchg     ebx, eax
