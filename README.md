# SFML2Wrapper

# ABOUT
This is wrapper of SFML 2.5.2/2.6.0 being developed for the OpenEuphoria Programming Language. It allows you to use the SFML library while using OpenEuphoria. SFML is a multimedia library similar to SDL. You can use it to create games and other multimedia projects. This library was built using the 32-Bit Binaries of SFML2. You may use the 64-bit DLLs, but they have not been tested. 

This wrapper is updated as the CSFML port is updated. SFML Net is not wrapped as OpenEuphoria has network functions built in. 

# Example
```euphoria
--EuSFML RenderWindow Example
--Written By Icy_Viking

include std/ffi.e
include std/math.e

include sfml_system.e
include sfml_window.e
include sfml_graphics.e

sequence mode = {800,600,32}

atom win = sfRenderWindow_create(mode,"Window",sfClose,NULL)

if win = -1 then
	puts(1,"Failed to create window!\n")
	abort(0)
end if

atom evt = allocate_struct(sfEvent)
atom evt_type = 0

while sfRenderWindow_isOpen(win) do

	while sfRenderWindow_pollEvent(win,evt) do
			evt_type = peek_type(evt,C_UINT32)
			if evt_type = sfEvtClosed then
				sfRenderWindow_close(win)
			end if
	end while
	
	sfRenderWindow_clear(win,sfBlack)
	
	sfRenderWindow_display(win)
end while

sfRenderWindow_destroy(win)
```

# LICENSE
You use this software at your own-risk. There is no warranty for this software. You may not hold the developer liable for anything you do this software. You may use this software to create your own projects. Projects you create with this library are yours to distribute as you please. You may not claim you wrote the original wrapper. This library is provided in the event that it is helpful.
