; ======================================================================
; 入口调度
; VA 0x102a82a5 .. 0x102a82e5   file 0x32a5 .. 0x32e5   (64 bytes)
; ======================================================================

102a82a5  8b 44 24 04              mov      eax, dword ptr [esp + 4]
102a82a9  23 05 0b 82 2a 10        and      eax, dword ptr [0x102a820b]
102a82af  e8 71 03 00 00           call     0x102a8625
102a82b4  fe 05 a4 82 2a 10        inc      byte ptr [0x102a82a4]
102a82ba  e9 61 ff ff ff           jmp      0x102a8220
102a82bf  82 2a 10                 sub      byte ptr [edx], 0x10
102a82c2  00 75 13                 add      byte ptr [ebp + 0x13], dh
102a82c5  90                       nop      
102a82c6  90                       nop      
102a82c7  90                       nop      
102a82c8  90                       nop      
102a82c9  50                       push     eax
102a82ca  2b c0                    sub      eax, eax
102a82cc  e8 54 03 00 00           call     0x102a8625
102a82d1  58                       pop      eax
102a82d2  fe 05 a4 82 2a 10        inc      byte ptr [0x102a82a4]
102a82d8  c3                       ret      
102a82d9  94                       xchg     esp, eax
102a82da  9a 8d 91 9a 93 cc cd     lcall    0xcdcc, 0x939a918d
