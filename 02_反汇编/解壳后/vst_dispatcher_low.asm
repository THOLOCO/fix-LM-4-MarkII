; ======================================================================
; VST dispatcher (opcode 0..0x18)
; RVA 0x21180 .. 0x21390   VA 0x10021180 .. 0x10021390   (528 bytes)
; ======================================================================

10021180  55                       push     ebp
10021181  8b ec                    mov      ebp, esp
10021183  83 ec 4c                 sub      esp, 0x4c
10021186  89 7c 24 08              mov      dword ptr [esp + 8], edi
1002118a  89 74 24 04              mov      dword ptr [esp + 4], esi
1002118e  89 1c 24                 mov      dword ptr [esp], ebx
10021191  33 db                    xor      ebx, ebx
10021193  8b 45 08                 mov      eax, dword ptr [ebp + 8]
10021196  83 f8 18                 cmp      eax, 0x18
10021199  0f 87 d2 01 00 00        ja       0x10021371
1002119f  8b 55 14                 mov      edx, dword ptr [ebp + 0x14]
100211a2  8b 75 10                 mov      esi, dword ptr [ebp + 0x10]
100211a5  8b 04 85 00 88 18 10     mov      eax, dword ptr [eax*4 + 0x10188800]
100211ac  8b f8                    mov      edi, eax
100211ae  8b 45 0c                 mov      eax, dword ptr [ebp + 0xc]
100211b1  ff e7                    jmp      edi
100211b3  8b 11                    mov      edx, dword ptr [ecx]
100211b5  8b 42 1c                 mov      eax, dword ptr [edx + 0x1c]
100211b8  ff d0                    call     eax
100211ba  e9 b2 01 00 00           jmp      0x10021371
100211bf  8b 11                    mov      edx, dword ptr [ecx]
100211c1  8b 42 20                 mov      eax, dword ptr [edx + 0x20]
100211c4  ff d0                    call     eax
100211c6  e9 a6 01 00 00           jmp      0x10021371
100211cb  3b 71 10                 cmp      esi, dword ptr [ecx + 0x10]
100211ce  0f 8d 9d 01 00 00        jge      0x10021371
100211d4  8b 11                    mov      edx, dword ptr [ecx]
100211d6  8b 42 28                 mov      eax, dword ptr [edx + 0x28]
100211d9  56                       push     esi
100211da  ff d0                    call     eax
100211dc  e9 90 01 00 00           jmp      0x10021371
100211e1  8b 11                    mov      edx, dword ptr [ecx]
100211e3  8b 42 24                 mov      eax, dword ptr [edx + 0x24]
100211e6  ff d0                    call     eax
100211e8  8b d8                    mov      ebx, eax
100211ea  e9 82 01 00 00           jmp      0x10021371
100211ef  8b 31                    mov      esi, dword ptr [ecx]
100211f1  8b 46 2c                 mov      eax, dword ptr [esi + 0x2c]
100211f4  52                       push     edx
100211f5  ff d0                    call     eax
100211f7  e9 75 01 00 00           jmp      0x10021371
100211fc  8b 31                    mov      esi, dword ptr [ecx]
100211fe  8b 46 30                 mov      eax, dword ptr [esi + 0x30]
10021201  52                       push     edx
10021202  ff d0                    call     eax
10021204  e9 68 01 00 00           jmp      0x10021371
10021209  83 c4 f8                 add      esp, -8
1002120c  8b 31                    mov      esi, dword ptr [ecx]
1002120e  89 54 24 04              mov      dword ptr [esp + 4], edx
10021212  89 04 24                 mov      dword ptr [esp], eax
10021215  8b 46 34                 mov      eax, dword ptr [esi + 0x34]
10021218  ff d0                    call     eax
1002121a  e9 52 01 00 00           jmp      0x10021371
1002121f  83 c4 f8                 add      esp, -8
10021222  8b 31                    mov      esi, dword ptr [ecx]
10021224  89 54 24 04              mov      dword ptr [esp + 4], edx
10021228  89 04 24                 mov      dword ptr [esp], eax
1002122b  8b 46 38                 mov      eax, dword ptr [esi + 0x38]
1002122e  ff d0                    call     eax
10021230  e9 3c 01 00 00           jmp      0x10021371
10021235  83 c4 f8                 add      esp, -8
10021238  8b 31                    mov      esi, dword ptr [ecx]
1002123a  89 54 24 04              mov      dword ptr [esp + 4], edx
1002123e  89 04 24                 mov      dword ptr [esp], eax
10021241  8b 46 3c                 mov      eax, dword ptr [esi + 0x3c]
10021244  ff d0                    call     eax
10021246  e9 26 01 00 00           jmp      0x10021371
1002124b  8b 11                    mov      edx, dword ptr [ecx]
1002124d  8b 42 40                 mov      eax, dword ptr [edx + 0x40]
10021250  ff d0                    call     eax
10021252  dc 0d 68 88 18 10        fmul     qword ptr [0x10188868]
10021258  dd 5d f0                 fstp     qword ptr [ebp - 0x10]
1002125b  8b 45 f4                 mov      eax, dword ptr [ebp - 0xc]
1002125e  8b 4d f0                 mov      ecx, dword ptr [ebp - 0x10]
10021261  8b d8                    mov      ebx, eax
10021263  c1 eb 14                 shr      ebx, 0x14
10021266  8b d3                    mov      edx, ebx
10021268  81 e2 ff 07 00 00        and      edx, 0x7ff
1002126e  81 fa fe 03 00 00        cmp      edx, 0x3fe
10021274  7e 24                    jle      0x1002129a
10021276  f7 da                    neg      edx
10021278  81 c2 1e 04 00 00        add      edx, 0x41e
1002127e  8b f1                    mov      esi, ecx
10021280  8b ca                    mov      ecx, edx
10021282  8b f8                    mov      edi, eax
10021284  0f a4 f7 0b              shld     edi, esi, 0xb
10021288  81 cf 00 00 00 80        or       edi, 0x80000000
1002128e  8b df                    mov      ebx, edi
10021290  d3 eb                    shr      ebx, cl
10021292  85 c0                    test     eax, eax
10021294  7d 06                    jge      0x1002129c
10021296  f7 db                    neg      ebx
10021298  eb 02                    jmp      0x1002129c
1002129a  33 db                    xor      ebx, ebx
1002129c  89 5d d8                 mov      dword ptr [ebp - 0x28], ebx
1002129f  e9 cd 00 00 00           jmp      0x10021371
100212a4  8b 55 18                 mov      edx, dword ptr [ebp + 0x18]
100212a7  8b 31                    mov      esi, dword ptr [ecx]
100212a9  52                       push     edx
100212aa  8b 46 4c                 mov      eax, dword ptr [esi + 0x4c]
100212ad  ff d0                    call     eax
100212af  e9 bd 00 00 00           jmp      0x10021371
100212b4  8b 11                    mov      edx, dword ptr [ecx]
100212b6  8b 42 50                 mov      eax, dword ptr [edx + 0x50]
100212b9  56                       push     esi
100212ba  ff d0                    call     eax
100212bc  e9 b0 00 00 00           jmp      0x10021371
100212c1  85 f6                    test     esi, esi
100212c3  75 0c                    jne      0x100212d1
100212c5  8b 11                    mov      edx, dword ptr [ecx]
100212c7  8b 42 54                 mov      eax, dword ptr [edx + 0x54]
100212ca  ff d0                    call     eax
100212cc  e9 a0 00 00 00           jmp      0x10021371
100212d1  8b 11                    mov      edx, dword ptr [ecx]
100212d3  8b 42 58                 mov      eax, dword ptr [edx + 0x58]
100212d6  ff d0                    call     eax
100212d8  e9 94 00 00 00           jmp      0x10021371
100212dd  8b 49 08                 mov      ecx, dword ptr [ecx + 8]
100212e0  85 c9                    test     ecx, ecx
100212e2  0f 84 89 00 00 00        je       0x10021371
100212e8  8b 19                    mov      ebx, dword ptr [ecx]
100212ea  8b 43 04                 mov      eax, dword ptr [ebx + 4]
100212ed  52                       push     edx
100212ee  ff d0                    call     eax
100212f0  8b d8                    mov      ebx, eax
100212f2  e9 7a 00 00 00           jmp      0x10021371
100212f7  8b 49 08                 mov      ecx, dword ptr [ecx + 8]
100212fa  85 c9                    test     ecx, ecx
100212fc  74 73                    je       0x10021371
100212fe  8b 19                    mov      ebx, dword ptr [ecx]
10021300  8b 43 08                 mov      eax, dword ptr [ebx + 8]
10021303  52                       push     edx
10021304  ff d0                    call     eax
10021306  8b d8                    mov      ebx, eax
10021308  eb 67                    jmp      0x10021371
1002130a  8b 49 08                 mov      ecx, dword ptr [ecx + 8]
1002130d  85 c9                    test     ecx, ecx
1002130f  74 60                    je       0x10021371
10021311  8b 11                    mov      edx, dword ptr [ecx]
10021313  8b 42 0c                 mov      eax, dword ptr [edx + 0xc]
10021316  ff d0                    call     eax
10021318  eb 57                    jmp      0x10021371
1002131a  8b 49 08                 mov      ecx, dword ptr [ecx + 8]
1002131d  85 c9                    test     ecx, ecx
1002131f  74 50                    je       0x10021371
10021321  8b 11                    mov      edx, dword ptr [ecx]
10021323  8b 42 10                 mov      eax, dword ptr [edx + 0x10]
10021326  ff d0                    call     eax
10021328  eb 47                    jmp      0x10021371
1002132a  bb 66 45 76 4e           mov      ebx, 0x4e764566
1002132f  eb 40                    jmp      0x10021371
10021331  85 c0                    test     eax, eax
10021333  74 04                    je       0x10021339
10021335  b0 01                    mov      al, 1
10021337  eb 02                    jmp      0x1002133b
10021339  32 c0                    xor      al, al
1002133b  83 c4 f8                 add      esp, -8
1002133e  8b 19                    mov      ebx, dword ptr [ecx]
10021340  88 44 24 04              mov      byte ptr [esp + 4], al
10021344  8b 43 44                 mov      eax, dword ptr [ebx + 0x44]
10021347  89 14 24                 mov      dword ptr [esp], edx
1002134a  ff d0                    call     eax
1002134c  8b d8                    mov      ebx, eax
1002134e  eb 21                    jmp      0x10021371
10021350  85 c0                    test     eax, eax
10021352  74 04                    je       0x10021358
10021354  b0 01                    mov      al, 1
10021356  eb 02                    jmp      0x1002135a
10021358  32 c0                    xor      al, al
1002135a  83 c4 f4                 add      esp, -0xc
1002135d  8b 19                    mov      ebx, dword ptr [ecx]
1002135f  88 44 24 08              mov      byte ptr [esp + 8], al
10021363  89 74 24 04              mov      dword ptr [esp + 4], esi
10021367  89 14 24                 mov      dword ptr [esp], edx
1002136a  8b 43 48                 mov      eax, dword ptr [ebx + 0x48]
1002136d  ff d0                    call     eax
1002136f  8b d8                    mov      ebx, eax
10021371  8b c3                    mov      eax, ebx
10021373  8b 1c 24                 mov      ebx, dword ptr [esp]
10021376  8b 74 24 04              mov      esi, dword ptr [esp + 4]
1002137a  8b 7c 24 08              mov      edi, dword ptr [esp + 8]
1002137e  8b e5                    mov      esp, ebp
10021380  5d                       pop      ebp
10021381  c2 14 00                 ret      0x14
10021384  8d b6 00 00 00 00        lea      esi, [esi]
1002138a  8d bf 00 00 00 00        lea      edi, [edi]
