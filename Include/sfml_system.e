include std/ffi.e
include std/machine.e
include std/os.e

atom sys = 0

ifdef WINDOWS then
	sys = open_dll("csfml-system-2.dll")
	elsifdef LINUX or FREEBSD then
	sys = open_dll("libcsmfl-system-2.so")
end ifdef

--SFML System Structs
--Vector2
public constant sfVector2i = define_c_struct({
	C_INT, --x
	C_INT --y
})

public constant sfVector2u = define_c_struct({
	C_UINT, --x
	C_UINT --y
})

public constant sfVector2f = define_c_struct({
	C_FLOAT, --x
	C_FLOAT --y
})

--Vector3
public constant sfVector3f = define_c_struct({
	C_FLOAT, --x
	C_FLOAT, --y
	C_FLOAT --z
})

--SFML System (Time.h)
public constant sfTime = define_c_struct({
	C_INT64 --microseconds
})

public constant xsfTime_Zero = define_c_func(sys,"+sfTime_Zero",{},sfTime)

public function sfTime_Zero()
	return c_func(xsfTime_Zero,{})
end function

public constant xsfTime_asSeconds = define_c_func(sys,"+sfTime_asSeconds",{sfTime},C_FLOAT)

public function sfTime_asSeconds(atom stime)
	return c_func(xsfTime_asSeconds,{stime})
end function

public constant xsfTime_asMilliseconds = define_c_func(sys,"+sfTime_asMilliseconds",{sfTime},C_INT32)

public function sfTime_asMilliseconds(atom stime)
	return c_func(xsfTime_asMilliseconds,{stime})
end function

public constant xsfTime_asMicroseconds = define_c_func(sys,"+sfTime_asMicroseconds",{sfTime},C_INT64)

public function sfTime_asMicroseconds(atom stime)
	return c_func(xsfTime_asMicroseconds,{stime})
end function

public constant xsfSeconds = define_c_func(sys,"+sfSeconds",{C_FLOAT},sfTime)

public function sfSeconds(atom amount)
	return c_func(xsfSeconds,{amount})
end function

public constant xsfMilliseconds = define_c_func(sys,"+sfMilliseconds",{C_INT32},sfTime)

public function sfMilliseconds(atom amount)
	return c_func(xsfMilliseconds,{amount})
end function

public constant xsfMicroseconds = define_c_func(sys,"+sfMicroseconds",{C_INT64},sfTime)

public function sfMicroseconds(atom amount)
	return c_func(xsfMicroseconds,{amount})
end function

--SFML Clock (clock.h)

public constant xsfClock_create = define_c_func(sys,"+sfClock_create",{},C_POINTER)

public function sfClock_create()
	return c_func(xsfClock_create,{})
end function

public constant xsfClock_copy = define_c_func(sys,"+sfClock_copy",{C_POINTER},C_POINTER)

public function sfClock_copy(atom clock)
	return c_func(xsfClock_copy,{clock})
end function

public constant xsfClock_destroy = define_c_proc(sys,"+sfClock_destroy",{C_POINTER})

public procedure sfClock_destroy(atom clock)
	c_proc(xsfClock_destroy,{clock})
end procedure

public constant xsfClock_getElapsedTime = define_c_func(sys,"+sfClock_getElapsedTime",{C_POINTER},sfTime)

public function sfClock_getElapsedTime(atom clock)
	return c_func(xsfClock_getElapsedTime,{clock})
end function

public constant xsfClock_restart = define_c_func(sys,"+sfClock_restart",{C_POINTER},sfTime)

public function sfClock_restart(atom clock)
	return c_func(xsfClock_restart,{clock})
end function

--SFML InputStream (InputStream.h)
public constant sfInputStream = define_c_struct({
	C_POINTER, --read sfInputStreamReadFunc
	C_POINTER, --seek sfInputStreamSeekFunc
	C_POINTER, --tell sfInputStreamTellFunc
	C_POINTER, --getSize sfInputStreamGetSizeFunc
	C_POINTER --userData
})

--SFML Mutex (mutex.h)

public constant xsfMutex_create = define_c_func(sys,"+sfMutex_create",{},C_POINTER)

public function sfMutex_create()
	return c_func(xsfMutex_create,{})
end function

public constant xsfMutex_destroy = define_c_proc(sys,"+sfMutex_destroy",{C_POINTER})

public procedure sfMutex_destroy(atom mutex)
	c_proc(xsfMutex_destroy,{mutex})
end procedure

public constant xsfMutex_lock = define_c_proc(sys,"+sfMutex_lock",{C_POINTER})

public procedure sfMutex_lock(atom mutex)
	c_proc(xsfMutex_lock,{mutex})
end procedure

public constant xsfMutex_unlock = define_c_proc(sys,"+sfMutex_unlock",{C_POINTER})

public procedure sfMutex_unlock(atom mutex)
	c_proc(xsfMutex_unlock,{mutex})
end procedure

--SFML Sleep (sleep.h)

public constant xsfSleep = define_c_proc(sys,"+sfSleep",{sfTime})

public procedure sfSleep(atom duration)
	c_proc(xsfSleep,{duration})
end procedure

--SFML Thread (thread.h)

public constant xsfThread_create = define_c_func(sys,"+sfThread_create",{C_POINTER,C_POINTER},C_POINTER)

public function sfThread_create(atom func,atom userData)
	return c_func(xsfThread_create,{func,userData})
end function

public constant xsfThread_destroy = define_c_proc(sys,"+sfThread_destroy",{C_POINTER})

public procedure sfThread_destroy(atom thread)
	c_proc(xsfThread_destroy,{thread})
end procedure

public constant xsfThread_launch = define_c_proc(sys,"+sfThread_launch",{C_POINTER})

public procedure sfThread_launch(atom thread)
	c_proc(xsfThread_launch,{thread})
end procedure

public constant xsfThread_wait = define_c_proc(sys,"+sfThread_wait",{C_POINTER})

public procedure sfThread_wait(atom thread)
	c_proc(xsfThread_wait,{thread})
end procedure

public constant xsfThread_terminate = define_c_proc(sys,"+sfThread_terminate",{C_POINTER})

public procedure sfThread_terminate(atom thread)
	c_proc(xsfThread_terminate,{thread})
end procedure

--Buffer Functions (buffer.h)

public constant xsfBuffer_create = define_c_func(sys,"+sfBuffer_create",{},C_POINTER)

public function sfBuffer_create()
	return c_func(xsfBuffer_create,{})
end function

public constant xsfBuffer_destroy = define_c_proc(sys,"+sfBuffer_destroy",{C_POINTER})

public procedure sfBuffer_destroy(atom buff)
	c_proc(xsfBuffer_destroy,{buff})
end procedure

public constant xsfBuffer_getSize = define_c_func(sys,"+sfBuffer_getSize",{C_POINTER},C_SIZE_T)

public function sfBuffer_getSize(atom buff)
	return c_func(xsfBuffer_getSize,{buff})
end function

public constant xsfBuffer_getData = define_c_func(sys,"+sfBuffer_getData",{C_POINTER},C_POINTER)

public function sfBuffer_getData(atom buff)
	return c_func(xsfBuffer_getData,{buff})
end function
­214.40