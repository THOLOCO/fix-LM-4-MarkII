; ======================================================================
; effGetProgramNameIndexed (20 个上限)
; RVA 0x140a0 .. 0x14120   VA 0x100140a0 .. 0x10014120   (128 bytes)
; ======================================================================

100140a0  55                       push     ebp
100140a1  8b ec                    mov      ebp, esp
100140a3  83 ec 20                 sub      esp, 0x20
100140a6  89 7c 24 08              mov      dword ptr [esp + 8], edi
100140aa  89 74 24 04              mov      dword ptr [esp + 4], esi
100140ae  89 1c 24                 mov      dword ptr [esp], ebx
100140b1  8b 45 0c                 mov      eax, dword ptr [ebp + 0xc]
100140b4  83 f8 14                 cmp      eax, 0x14
100140b7  7d 33                    jge      0x100140ec
100140b9  8b 75 10                 mov      esi, dword ptr [ebp + 0x10]
100140bc  85 f6                    test     esi, esi
100140be  74 2c                    je       0x100140ec
100140c0  8b 8c 81 88 01 00 00     mov      ecx, dword ptr [ecx + eax*4 + 0x188]
100140c7  85 c9                    test     ecx, ecx
100140c9  74 34                    je       0x100140ff
100140cb  8b 11                    mov      edx, dword ptr [ecx]
100140cd  8b 82 f4 00 00 00        mov      eax, dword ptr [edx + 0xf4]
100140d3  56                       push     esi
100140d4  ff d0                    call     eax
100140d6  b8 01 00 00 00           mov      eax, 1
100140db  8b 1c 24                 mov      ebx, dword ptr [esp]
100140de  8b 74 24 04              mov      esi, dword ptr [esp + 4]
100140e2  8b 7c 24 08              mov      edi, dword ptr [esp + 8]
100140e6  8b e5                    mov      esp, ebp
100140e8  5d                       pop      ebp
100140e9  c2 0c 00                 ret      0xc
100140ec  33 c0                    xor      eax, eax
100140ee  8b 1c 24                 mov      ebx, dword ptr [esp]
100140f1  8b 74 24 04              mov      esi, dword ptr [esp + 4]
100140f5  8b 7c 24 08              mov      edi, dword ptr [esp + 8]
100140f9  8b e5                    mov      esp, ebp
100140fb  5d                       pop      ebp
100140fc  c2 0c 00                 ret      0xc
100140ff  bf 20 79 18 10           mov      edi, 0x10187920
10014104  8a 17                    mov      dl, byte ptr [edi]
10014106  47                       inc      edi
10014107  88 16                    mov      byte ptr [esi], dl
10014109  46                       inc      esi
1001410a  84 d2                    test     dl, dl
1001410c  75 f6                    jne      0x10014104
1001410e  eb c6                    jmp      0x100140d6
10014110  53                       push     ebx
10014111  8b dc                    mov      ebx, esp
10014113  83 ec 08                 sub      esp, 8
10014116  83 e4 f0                 and      esp, 0xfffffff0
10014119  83 c4 08                 add      esp, 8
1001411c  eb 03                    jmp      0x10014121
1001411e  53                       push     ebx
