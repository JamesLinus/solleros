filetypes db 255,44
progstart:		;programs start here
indexfiles:
	mov esi, progstart
	mov ebx, fileindex
	mov edi, progstart
	sub edi, 2
indexloop:
	mov cx, [esi]
	indexloop2:
		cmp cx, [edi]
		je indexloop2done
		sub edi, 2
		cmp edi, filetypes
		jae indexloop2
	mov edi, progstart
	sub edi, 2
	inc esi
	cmp esi, batchprogend
	jae indexloopdone
	jmp indexloop
indexloop2done:
	mov [ebx], cx
	add ebx, 2
	add esi, 2
	nameindex:
		mov cl, [esi]
		cmp cl, 0
		je nameindexdone
		mov [ebx], cl
		inc esi
		inc ebx
		jmp nameindex
	nameindexdone:
		inc ebx
		mov word [ebx], 0
		add ebx, 2
		inc esi
		mov [ebx], esi
		add ebx, 4
		mov word [ebx], 0
		add ebx, 2
		cmp ebx, fileindexend
		jae indexloopdone
		add esi, 1
		jmp indexloop
indexloopdone: 	mov byte [indexdone], 1
		ret
indexdone db 0
%include 'source/programs/_comment.asm' ;#
%include 'source/programs/_math.asm' ;!
%include 'source/programs/_variables.asm' ;% and $
%include 'source/programs/_run.asm' ;./
%ifdef network.included
	%include 'source/programs/arp.asm'
%endif
%include 'source/programs/batch.asm'
%ifdef gui.background
	%include 'source/programs/background.asm'
%endif
%include 'source/programs/beep.asm'
%ifdef dos.compatible
%else
	%include 'source/programs/boot.asm'
%endif
%include 'source/programs/cd.asm'
%include 'source/programs/charmap.asm'
%ifdef gui.included
	%include 'source/programs/circle.asm'
%endif
%include 'source/programs/clear.asm'
%include 'source/programs/cpuid.asm'
%include 'source/programs/date.asm'
%ifdef network.included
	%include 'source/programs/dhcp.asm'
%endif
%ifdef disk.none
%else
	%include 'source/programs/dos.asm'
%endif
%include 'source/programs/dump.asm'
%include 'source/programs/echo.asm'
%include 'source/programs/else.asm'
%include 'source/programs/exit.asm'
%include 'source/programs/fi.asm'
%ifdef gui.included
	%include 'source/programs/gui.asm'
%endif
%include 'source/programs/help.asm'
%include 'source/programs/if.asm'
%ifdef network.included
	%include 'source/programs/ipconfig.asm'
%endif
%include 'source/programs/keycode.asm'
%ifdef gui.included
	%include 'source/programs/line.asm'
%endif
%include 'source/programs/logout.asm'
%include 'source/programs/loop.asm'
%ifdef disk.none
%else
	%include 'source/programs/ls.asm'
%endif
%include 'source/programs/memory.asm'
%include 'source/programs/pci.asm'
%ifdef network.included
	%include 'source/programs/ping.asm'
%endif
%ifdef disk.none
%else
	%include 'source/programs/play.asm'
%endif
%include 'source/programs/pwd.asm'
%include 'source/programs/reboot.asm'
%include 'source/programs/reg.asm'
%ifdef disk.none
%else
	%include 'source/programs/show.asm'
%endif
%include 'source/programs/shush.asm'
%include 'source/programs/system.asm'
%include 'source/programs/time.asm'
%include 'source/programs/turnoff.asm'
%include 'source/programs/wait.asm'
%include 'source/programs/while.asm'
progend:		;programs end here	
batchprogend:
