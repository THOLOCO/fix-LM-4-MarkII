; ======================================================================
; 解压调用点
; VA 0x102a88cc .. 0x102a892c   file 0x38cc .. 0x392c   (96 bytes)
; ======================================================================

102a88cc  e8 01 07 00 00           call     0x102a8fd2
102a88d1  89 45 b2                 mov      dword ptr [ebp - 0x4e], eax
102a88d4  85 c0                    test     eax, eax
102a88d6  75 10                    jne      0x102a88e8
102a88d8  ba fd ff ff ff           mov      edx, 0xfffffffd
102a88dd  8d 85 9a fd ff ff        lea      eax, [ebp - 0x266]
102a88e3  e8 27 fd ff ff           call     0x102a860f
102a88e8  8b 55 1a                 mov      edx, dword ptr [ebp + 0x1a]
102a88eb  8b 4d 6a                 mov      ecx, dword ptr [ebp + 0x6a]
102a88ee  8b 45 b2                 mov      eax, dword ptr [ebp - 0x4e]
102a88f1  8b 5e 14                 mov      ebx, dword ptr [esi + 0x14]
102a88f4  03 56 10                 add      edx, dword ptr [esi + 0x10]
102a88f7  e8 d6 06 00 00           call     0x102a8fd2
102a88fc  89 45 b2                 mov      dword ptr [ebp - 0x4e], eax
102a88ff  85 c0                    test     eax, eax
102a8901  75 10                    jne      0x102a8913
102a8903  ba fd ff ff ff           mov      edx, 0xfffffffd
102a8908  8d 85 9a fd ff ff        lea      eax, [ebp - 0x266]
102a890e  e8 fc fc ff ff           call     0x102a860f
102a8913  8b 47 38                 mov      eax, dword ptr [edi + 0x38]
102a8916  48                       dec      eax
102a8917  89 45 3a                 mov      dword ptr [ebp + 0x3a], eax
102a891a  8d 47 78                 lea      eax, [edi + 0x78]
102a891d  8b 9d 96 fd ff ff        mov      ebx, dword ptr [ebp - 0x26a]
102a8923  89 45 4a                 mov      dword ptr [ebp + 0x4a], eax
102a8926  2b 5f 34                 sub      ebx, dword ptr [edi + 0x34]
102a8929  74 22                    je       0x102a894d
