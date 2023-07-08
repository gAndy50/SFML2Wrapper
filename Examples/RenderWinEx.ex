--EuSFML RenderWindow Example
--Written By Andy P. (Icy_Viking)

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
