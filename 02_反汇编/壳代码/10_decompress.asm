; ======================================================================
; 解压器入口
; VA 0x102a8fd2 .. 0x102a9052   file 0x3fd2 .. 0x4052   (128 bytes)
; ======================================================================

102a8fd2  56                       push     esi
102a8fd3  57                       push     edi
102a8fd4  55                       push     ebp
102a8fd5  89 e5                    mov      ebp, esp
102a8fd7  50                       push     eax
102a8fd8  52                       push     edx
102a8fd9  53                       push     ebx
102a8fda  51                       push     ecx
102a8fdb  eb 0f                    jmp      0x102a8fec
102a8fdd  81 e3 ff 7f 00 00        and      ebx, 0x7fff
102a8fe3  01 45 f8                 add      dword ptr [ebp - 8], eax
102a8fe6  29 45 f4                 sub      dword ptr [ebp - 0xc], eax
102a8fe9  01 5d fc                 add      dword ptr [ebp - 4], ebx
102a8fec  83 7d f4 00              cmp      dword ptr [ebp - 0xc], 0
102a8ff0  76 42                    jbe      0x102a9034
102a8ff2  8b 5d fc                 mov      ebx, dword ptr [ebp - 4]
102a8ff5  0f b7 1b                 movzx    ebx, word ptr [ebx]
102a8ff8  83 45 fc 02              add      dword ptr [ebp - 4], 2
102a8ffc  f6 c7 80                 test     bh, 0x80
102a8fff  74 1e                    je       0x102a901f
102a9001  ff 75 f0                 push     dword ptr [ebp - 0x10]
102a9004  ff 75 fc                 push     dword ptr [ebp - 4]
102a9007  ff 75 f8                 push     dword ptr [ebp - 8]
102a900a  e8 6f 00 00 00           call     0x102a907e
102a900f  83 c4 0c                 add      esp, 0xc
102a9012  3d 00 80 00 00           cmp      eax, 0x8000
102a9017  76 c4                    jbe      0x102a8fdd
102a9019  31 c0                    xor      eax, eax
102a901b  c9                       leave    
102a901c  5f                       pop      edi
102a901d  5e                       pop      esi
102a901e  c3                       ret      
102a901f  8b 75 fc                 mov      esi, dword ptr [ebp - 4]
102a9022  43                       inc      ebx
102a9023  8b 7d f8                 mov      edi, dword ptr [ebp - 8]
102a9026  89 d9                    mov      ecx, ebx
102a9028  29 5d f4                 sub      dword ptr [ebp - 0xc], ebx
102a902b  57                       push     edi
102a902c  f2 a4                    repne movsb byte ptr es:[edi], byte ptr [esi]
102a902e  5f                       pop      edi
102a902f  01 5d f8                 add      dword ptr [ebp - 8], ebx
102a9032  eb b5                    jmp      0x102a8fe9
102a9034  8b 45 fc                 mov      eax, dword ptr [ebp - 4]
102a9037  c9                       leave    
102a9038  5f                       pop      edi
102a9039  5e                       pop      esi
102a903a  c3                       ret      
102a903b  00 00                    add      byte ptr [eax], al
102a903d  00 d2                    add      dl, dl
102a903f  90                       nop      
102a9040  2a 10                    sub      dl, byte ptr [eax]
102a9042  b2 90                    mov      dl, 0x90
102a9044  2a 10                    sub      dl, byte ptr [eax]
102a9046  22 91 2a 10 76 91        and      dl, byte ptr [ecx - 0x6e89efd6]
102a904c  2a 10                    sub      dl, byte ptr [eax]
102a904e  ce                       into     
102a904f  91                       xchg     ecx, eax
102a9050  2a 10                    sub      dl, byte ptr [eax]
