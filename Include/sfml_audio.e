include std/ffi.e
include std/machine.e
include std/os.e

include sfml_system.e
include sfml_window.e

atom aud = 0

ifdef WINDOWS then
	aud = open_dll("csfml-audio-2.dll")
	elsifdef LINUX or FREEBSD then
	aud = open_dll("libcsfml-audio-2.so")
end ifdef

if aud = -1 then
	puts(1,"Failed to load SFML Audio!\n")
	abort(0)
end if

--SoundStatus

public enum type sfSoundStatus
	sfStopped = 0,
	sfPaused,
	sfPlaying
end type

--Listener

public constant xsfListener_setGlobalVolume = define_c_proc(aud,"+sfListener_setGlobalVolume",{C_FLOAT})

public procedure sfListener_setGlobalVolume(atom vol)
	c_proc(xsfListener_setGlobalVolume,{vol})
end procedure

public constant xsfListener_getGlobalVolume = define_c_func(aud,"+sfListener_getGlobalVolume",{},C_FLOAT)

public function sfListener_getGlobalVolume()
	return c_func(xsfListener_getGlobalVolume,{})
end function

public constant xsfListener_setPosition = define_c_proc(aud,"+sfListener_setPosition",{sfVector3f})

public procedure sfListener_setPosition(sequence pos)
	c_proc(xsfListener_setPosition,{pos})
end procedure

public constant xsfListener_getPosition = define_c_func(aud,"+sfListener_getPosition",{},sfVector3f)

public function sfListener_getPosition()
	return c_func(xsfListener_getPosition,{})
end function

public constant xsfListener_setDirection = define_c_proc(aud,"+sfListener_setDirection",{sfVector3f})

public procedure sfListener_setDirection(sequence direction)
	c_proc(xsfListener_setDirection,{direction})
end procedure

public constant xsfListener_getDirection = define_c_func(aud,"+sfListener_getDirection",{},sfVector3f)

public function sfListener_getDirection()
	return c_func(xsfListener_getDirection,{})
end function

public constant xsfListener_setUpVector = define_c_proc(aud,"+sfListener_setUpVector",{sfVector3f})

public procedure sfListener_setUpVector(sequence up)
	c_proc(xsfListener_setUpVector,{up})
end procedure

public constant xsfListener_getUpVector = define_c_func(aud,"+sfListener_getUpVector",{},sfVector3f)

public function sfListener_getUpVector()
	return c_func(xsfListener_getUpVector,{})
end function

--Music

public constant sfTimeSpan = define_c_struct({
	sfTime, --offset
	sfTime --length
})

public constant xsfMusic_createFromFile = define_c_func(aud,"+sfMusic_createFromFile",{C_STRING},C_POINTER)

public function sfMusic_createFromFile(sequence fname)
	return c_func(xsfMusic_createFromFile,{fname})
end function

public constant xsfMusic_createFromMemory = define_c_func(aud,"+sfMusic_createFromMemory",{C_POINTER,C_SIZE_T},C_POINTER)

public function sfMusic_createFromMemory(atom data,atom size)
	return c_func(xsfMusic_createFromMemory,{data,size})
end function

public constant xsfMusic_createFromStream = define_c_func(aud,"+sfMusic_createFromStream",{C_POINTER},C_POINTER)

public function sfMusic_createFromStream(atom s)
	return c_func(xsfMusic_createFromStream,{s})
end function

public constant xsfMusic_destroy = define_c_proc(aud,"+sfMusic_destroy",{C_POINTER})

public procedure sfMusic_destroy(atom m)
	c_proc(xsfMusic_destroy,{m})
end procedure

public constant xsfMusic_setLoop = define_c_proc(aud,"+sfMusic_setLoop",{C_POINTER,C_BOOL})

public procedure sfMusic_setLoop(atom m,atom l)
	c_proc(xsfMusic_setLoop,{m,l})
end procedure

public constant xsfMusic_getLoop = define_c_func(aud,"+sfMusic_getLoop",{C_POINTER},C_BOOL)

public function sfMusic_getLoop(atom m)
	return c_func(xsfMusic_getLoop,{m})
end function

public constant xsfMusic_getDuration = define_c_func(aud,"+sfMusic_getDuration",{C_POINTER},sfTime)

public function sfMusic_getDuration(atom m)
	return c_func(xsfMusic_getDuration,{m})
end function

public constant xsfMusic_getLoopPoints = define_c_func(aud,"+sfMusic_getLoopPoints",{C_POINTER},sfTimeSpan)

public function sfMusic_getLoopPoints(atom m)
	return c_func(xsfMusic_getLoopPoints,{m})
end function

public constant xsfMusic_setLoopPoints = define_c_proc(aud,"+sfMusic_setLoopPoints",{C_POINTER,sfTimeSpan})

public procedure sfMusic_setLoopPoints(atom m,atom tp)
	c_proc(xsfMusic_setLoopPoints,{m,tp})
end procedure

public constant xsfMusic_play = define_c_proc(aud,"+sfMusic_play",{C_POINTER})

public procedure sfMusic_play(atom m)
	c_proc(xsfMusic_play,{m})
end procedure

public constant xsfMusic_pause = define_c_proc(aud,"+sfMusic_pause",{C_POINTER})

public procedure sfMusic_pause(atom m)
	c_proc(xsfMusic_pause,{m})
end procedure

public constant xsfMusic_stop = define_c_proc(aud,"+sfMusic_stop",{C_POINTER})

public procedure sfMusic_stop(atom m)
	c_proc(xsfMusic_stop,{m})
end procedure

public constant xsfMusic_getChannelCount = define_c_func(aud,"+sfMusic_getChannelCount",{C_POINTER},C_UINT)

public function sfMusic_getChannelCount(atom m)
	return c_func(xsfMusic_getChannelCount,{m})
end function

public constant xsfMusic_getSampleRate = define_c_func(aud,"+sfMusic_getSampleRate",{C_POINTER},C_UINT)

public function sfMusic_getSampleRate(atom m)
	return c_func(xsfMusic_getSampleRate,{m})
end function

public constant xsfMusic_getStatus = define_c_func(aud,"+sfMusic_getStatus",{C_POINTER},C_INT)

public function sfMusic_getStatus(atom m)
	return c_func(xsfMusic_getStatus,{m})
end function

public constant xsfMusic_getPlayingOffset = define_c_func(aud,"+sfMusic_getPlayingOffset",{C_POINTER},sfTime)

public function sfMusic_getPlayingOffset(atom m)
	return c_func(xsfMusic_getPlayingOffset,{m})
end function

public constant xsfMusic_setPitch = define_c_proc(aud,"+sfMusic_setPitch",{C_POINTER,C_FLOAT})

public procedure sfMusic_setPitch(atom m,atom p)
	c_proc(xsfMusic_setPitch,{m,p})
end procedure

public constant xsfMusic_setVolume = define_c_proc(aud,"+sfMusic_setVolume",{C_POINTER,C_FLOAT})

public procedure sfMusic_setVolume(atom m,atom v)
	c_proc(xsfMusic_setVolume,{m,v})
end procedure

public constant xsfMusic_setPosition = define_c_proc(aud,"+sfMusic_setPosition",{C_POINTER,sfVector3f})

public procedure sfMusic_setPosition(atom m,sequence pos)
	c_proc(xsfMusic_setPosition,{m,pos})
end procedure

public constant xsfMusic_setRelativeToListener = define_c_proc(aud,"+sfMusic_setRelativeToListener",{C_POINTER,C_BOOL})

public procedure sfMusic_setRelativeToListener(atom m,atom r)
	c_proc(xsfMusic_setRelativeToListener,{m,r})
end procedure

public constant xsfMusic_setMinDistance = define_c_proc(aud,"+sfMusic_setMinDistance",{C_POINTER,C_FLOAT})

public procedure sfMusic_setMinDistance(atom m,atom d)
	c_proc(xsfMusic_setMinDistance,{m,d})
end procedure

public constant xsfMusic_setAttenuation = define_c_proc(aud,"+sfMusic_setAttenuation",{C_POINTER,C_FLOAT})

public procedure sfMusic_setAttenuation(atom m,atom a)
	c_proc(xsfMusic_setAttenuation,{m,a})
end procedure

public constant xsfMusic_setPlayingOffset = define_c_proc(aud,"+sfMusic_setPlayingOffset",{C_POINTER,sfTime})

public procedure sfMusic_setPlayingOffset(atom m,sequence toff)
	c_proc(xsfMusic_setPlayingOffset,{m,toff})
end procedure

public constant xsfMusic_getPitch = define_c_func(aud,"+sfMusic_getPitch",{C_POINTER},C_FLOAT)

public function sfMusic_getPitch(atom m)
	return c_func(xsfMusic_getPitch,{m})
end function

public constant xsfMusic_getVolume = define_c_func(aud,"+sfMusic_getVolume",{C_POINTER},C_FLOAT)

public function sfMusic_getVolume(atom m)
	return c_func(xsfMusic_getVolume,{m})
end function

public constant xsfMusic_getPosition = define_c_func(aud,"+sfMusic_getPosition",{C_POINTER},sfVector3f)

public function sfMusic_getPosition(atom m)
	return c_func(xsfMusic_getPosition,{m})
end function

public constant xsfMusic_isRelativeToListener = define_c_func(aud,"+sfMusic_isRelativeToListener",{C_POINTER},C_BOOL)

public function sfMusic_isRelativeToListener(atom m)
	return c_func(xsfMusic_isRelativeToListener,{m})
end function

public constant xsfMusic_getMinDistance = define_c_func(aud,"+sfMusic_getMinDistance",{C_POINTER},C_FLOAT)

public function sfMusic_getMinDistance(atom m)
	return c_func(xsfMusic_getMinDistance,{m})
end function

public constant xsfMusic_getAttenuation = define_c_func(aud,"+sfMusic_getAttenuation",{C_POINTER},C_FLOAT)

public function sfMusic_getAttenuation(atom m)
	return c_func(xsfMusic_getAttenuation,{m})
end function

--Sound

public constant xsfSound_create = define_c_func(aud,"+sfSound_create",{},C_POINTER)

public function sfSound_create()
	return c_func(xsfSound_create,{})
end function

public constant xsfSound_copy = define_c_func(aud,"+sfSound_copy",{C_POINTER},C_POINTER)

public function sfSound_copy(atom snd)
	return c_func(xsfSound_copy,{snd})
end function

public constant xsfSound_destroy = define_c_proc(aud,"+sfSound_destroy",{C_POINTER})

public procedure sfSound_destroy(atom snd)
	c_proc(xsfSound_destroy,{snd})
end procedure

public constant xsfSound_play = define_c_proc(aud,"+sfSound_play",{C_POINTER})

public procedure sfSound_play(atom snd)
	c_proc(xsfSound_play,{snd})
end procedure

public constant xsfSound_pause = define_c_proc(aud,"+sfSound_pause",{C_POINTER})

public procedure sfSound_pause(atom snd)
	c_proc(xsfSound_pause,{snd})
end procedure

public constant xsfSound_stop = define_c_proc(aud,"+sfSound_stop",{C_POINTER})

public procedure sfSound_stop(atom snd)
	c_proc(xsfSound_stop,{snd})
end procedure

public constant xsfSound_setBuffer = define_c_proc(aud,"+sfSound_setBuffer",{C_POINTER,C_POINTER})

public procedure sfSound_setBuffer(atom snd,atom buf)
	c_proc(xsfSound_setBuffer,{snd,buf})
end procedure

public constant xsfSound_getBuffer = define_c_func(aud,"+sfSound_getBuffer",{C_POINTER},C_POINTER)

public function sfSound_getBuffer(atom snd)
	return c_func(xsfSound_getBuffer,{snd})
end function

public constant xsfSound_setLoop = define_c_proc(aud,"+sfSound_setLoop",{C_POINTER,C_BOOL})

public procedure sfSound_setLoop(atom snd,atom l)
	c_proc(xsfSound_setLoop,{snd,l})
end procedure

public constant xsfSound_getLoop = define_c_func(aud,"+sfSound_getLoop",{C_POINTER},C_BOOL)

public function sfSound_getLoop(atom snd)
	return c_func(xsfSound_getLoop,{snd})
end function

public constant xsfSound_getStatus = define_c_func(aud,"+sfSound_getStatus",{C_POINTER},C_INT)

public function sfSound_getStatus(atom snd)
	return c_func(xsfSound_getStatus,{snd})
end function

public constant xsfSound_setPitch = define_c_proc(aud,"+sfSound_setPitch",{C_POINTER,C_FLOAT})

public procedure sfSound_setPitch(atom snd,atom p)
	c_proc(xsfSound_setPitch,{snd,p})
end procedure

public constant xsfSound_setVolume = define_c_proc(aud,"+sfSound_setVolume",{C_POINTER,C_FLOAT})

public procedure sfSound_setVolume(atom snd,atom v)
	c_proc(xsfSound_setVolume,{snd,v})
end procedure

public constant xsfSound_setPosition = define_c_proc(aud,"+sfSound_setPosition",{C_POINTER,sfVector3f})

public procedure sfSound_setPosition(atom snd,sequence pos)
	c_proc(xsfSound_setPosition,{snd,pos})
end procedure

public constant xsfSound_setRelativeToListener = define_c_proc(aud,"+sfSound_setRelativeToListener",{C_POINTER,C_BOOL})

public procedure sfSound_setRelativeToListener(atom snd,atom rel)
	c_proc(xsfSound_setRelativeToListener,{snd,rel})
end procedure

public constant xsfSound_setMinDistance = define_c_proc(aud,"+sfSound_setMinDistance",{C_POINTER,C_FLOAT})

public procedure sfSound_setMinDistance(atom snd,atom d)
	c_proc(xsfSound_setMinDistance,{snd,d})
end procedure

public constant xsfSound_setAttenuation = define_c_proc(aud,"+sfSound_setAttenuation",{C_POINTER,C_FLOAT})

public procedure sfSound_setAttenuation(atom snd,atom att)
	c_proc(xsfSound_setAttenuation,{snd,att})
end procedure

public constant xsfSound_setPlayingOffset = define_c_proc(aud,"+sfSound_setPlayingOffset",{C_POINTER,sfTime})

public procedure sfSound_setPlayingOffset(atom snd,sequence toff)
	c_proc(xsfSound_setPlayingOffset,{snd,toff})
end procedure

public constant xsfSound_getPitch = define_c_func(aud,"+sfSound_getPitch",{C_POINTER},C_FLOAT)

public function sfSound_getPitch(atom snd)
	return c_func(xsfSound_getPitch,{snd})
end function

public constant xsfSound_getVolume = define_c_func(aud,"+sfSound_getVolume",{C_POINTER},C_FLOAT)

public function sfSound_getVolume(atom snd)
	return c_func(xsfSound_getVolume,{snd})	
end function

public constant xsfSound_getPosition = define_c_func(aud,"+sfSound_getPosition",{C_POINTER},sfVector3f)

public function sfSound_getPosition(atom snd)
	return c_func(xsfSound_getPosition,{snd})
end function

public constant xsfSound_isRelativeToListener = define_c_func(aud,"+sfSound_isRelativeToListener",{C_POINTER},C_BOOL)

public function sfSound_isRelativeToListener(atom snd)
	return c_func(xsfSound_isRelativeToListener,{snd})
end function

public constant xsfSound_getMinDistance = define_c_func(aud,"+sfSound_getMinDistance",{C_POINTER},C_FLOAT)

public function sfSound_getMinDistance(atom snd)
	return c_func(xsfSound_getMinDistance,{snd})
end function

public constant xsfSound_getAttenuation = define_c_func(aud,"+sfSound_getAttenuation",{C_POINTER},C_FLOAT)

public function sfSound_getAttenuation(atom snd)
	return c_func(xsfSound_getAttenuation,{snd})
end function

public constant xsfSound_getPlayingOffset = define_c_func(aud,"+sfSound_getPlayingOffset",{C_POINTER},sfTime)

public function sfSound_getPlayingOffset(atom snd)
	return c_func(xsfSound_getPlayingOffset,{snd})
end function

--SoundBuffer

public constant xsfSoundBuffer_createFromFile = define_c_func(aud,"+sfSoundBuffer_createFromFile",{C_STRING},C_POINTER)

public function sfSoundBuffer_createFromFile(sequence fname)
	return c_func(xsfSoundBuffer_createFromFile,{fname})
end function

public constant xsfSoundBuffer_createFromMemory = define_c_func(aud,"+sfSoundBuffer_createFromMemory",{C_POINTER,C_SIZE_T},C_POINTER)

public function sfSoundBuffer_createFromMemory(atom data,atom size)
	return c_func(xsfSoundBuffer_createFromMemory,{data,size})
end function

public constant xsfSoundBuffer_createFromStream = define_c_func(aud,"+sfSoundBuffer_createFromStream",{C_POINTER},C_POINTER)

public function sfSoundBuffer_createFromStream(atom s)
	return c_func(xsfSoundBuffer_createFromStream,{s})
end function

public constant xsfSoundBuffer_createFromSamples = define_c_func(aud,"+sfSoundBuffer_createFromSamples",{C_POINTER,C_UINT64,C_UINT,C_UINT},C_POINTER)

public function sfSoundBuffer_createFromSamples(atom samp,atom cnt,atom chan,atom rate)
	return c_func(xsfSoundBuffer_createFromSamples,{samp,cnt,chan,rate})
end function

public constant xsfSoundBuffer_copy = define_c_func(aud,"+sfSoundBuffer_copy",{C_POINTER},C_POINTER)

public function sfSoundBuffer_copy(atom sb)
	return c_func(xsfSoundBuffer_copy,{sb})
end function

public constant xsfSoundBuffer_destroy = define_c_proc(aud,"+sfSoundBuffer_destroy",{C_POINTER})

public procedure sfSoundBuffer_destroy(atom sb)
	c_proc(xsfSoundBuffer_destroy,{sb})
end procedure

public constant xsfSoundBuffer_saveToFile = define_c_func(aud,"+sfSoundBuffer_saveToFile",{C_POINTER,C_STRING},C_BOOL)

public function sfSoundBuffer_saveToFile(atom sb,sequence fname)
	return c_func(xsfSoundBuffer_saveToFile,{sb,fname})
end function

public constant xsfSoundBuffer_getSamples = define_c_func(aud,"+sfSoundBuffer_getSamples",{C_POINTER},C_POINTER)

public function sfSoundBuffer_getSamples(atom sb)
	return c_func(xsfSoundBuffer_getSamples,{sb})
end function

public constant xsfSoundBuffer_getSampleCount = define_c_func(aud,"+sfSoundBuffer_getSampleCount",{C_POINTER},C_UINT64)

public function sfSoundBuffer_getSampleCount(atom sb)
	return c_func(xsfSoundBuffer_getSampleCount,{sb})
end function

public constant xsfSoundBuffer_getSampleRate = define_c_func(aud,"+sfSoundBuffer_getSampleRate",{C_POINTER},C_UINT)

public function sfSoundBuffer_getSampleRate(atom sb)
	return c_func(xsfSoundBuffer_getSampleRate,{sb})
end function

public constant xsfSoundBuffer_getChannelCount = define_c_func(aud,"+sfSoundBuffer_getChannelCount",{C_POINTER},C_UINT)

public function sfSoundBuffer_getChannelCount(atom sb)
	return c_func(xsfSoundBuffer_getChannelCount,{sb})
end function

public constant xsfSoundBuffer_getDuration = define_c_func(aud,"+sfSoundBuffer_getDuration",{C_POINTER},sfTime)

public function sfSoundBuffer_getDuration(atom sb)
	return c_func(xsfSoundBuffer_getDuration,{sb})
end function

--SoundBufferRecorder

public constant xsfSoundBufferRecorder_create = define_c_func(aud,"+sfSoundBufferRecorder_create",{},C_POINTER)

public function sfSoundBufferRecorder_create()
	return c_func(xsfSoundBufferRecorder_create,{})
end function

public constant xsfSoundBufferRecorder_destroy = define_c_proc(aud,"+sfSoundBufferRecorder_destroy",{C_POINTER})

public procedure sfSoundBufferRecorder_destroy(atom sbr)
	c_proc(xsfSoundBufferRecorder_destroy,{sbr})
end procedure

public constant xsfSoundBufferRecorder_start = define_c_func(aud,"+sfSoundBufferRecorder_start",{C_POINTER,C_UINT},C_BOOL)

public function sfSoundBufferRecorder_start(atom sbr,atom samp)
	return c_func(xsfSoundBufferRecorder_start,{sbr,samp})
end function

public constant xsfSoundBufferRecorder_stop = define_c_proc(aud,"+sfSoundBufferRecorder_stop",{C_POINTER})

public procedure sfSoundBufferRecorder_stop(atom sbr)
	c_proc(xsfSoundBufferRecorder_stop,{sbr})
end procedure

public constant xsfSoundBufferRecorder_getSampleRate = define_c_func(aud,"+sfSoundBufferRecorder_getSampleRate",{C_POINTER},C_UINT)

public function sfSoundBufferRecorder_getSampleRate(atom sbr)
	return c_func(xsfSoundBufferRecorder_getSampleRate,{sbr})
end function

public constant xsfSoundBufferRecorder_getBuffer = define_c_func(aud,"+sfSoundBufferRecorder_getBuffer",{C_POINTER},C_POINTER)

public function sfSoundBufferRecorder_getBuffer(atom sbr)
	return c_func(xsfSoundBufferRecorder_getBuffer,{sbr})
end function

public constant xsfSoundBufferRecorder_setDevice = define_c_func(aud,"+sfSoundBufferRecorder_setDevice",{C_POINTER,C_STRING},C_BOOL)

public function sfSoundBufferRecorder_setDevice(atom sbr,sequence name)
	return c_func(xsfSoundBufferRecorder_setDevice,{sbr,name})
end function

public constant xsfSoundBufferRecorder_getDevice = define_c_func(aud,"+sfSoundBufferRecorder_getDevice",{C_POINTER},C_STRING)

public function sfSoundBufferRecorder_getDevice(atom sbr)
	return c_func(xsfSoundBufferRecorder_getDevice,{sbr})
end function

--SoundRecorder

public constant xsfSoundRecorder_create = define_c_func(aud,"+sfSoundRecorder_create",{C_POINTER,C_POINTER,C_POINTER,C_POINTER},C_POINTER)

public function sfSoundRecorder_create(atom onStart,atom onProcess,atom onStop,atom userData)
	return c_func(xsfSoundRecorder_create,{onStart,onProcess,onStop,userData})
end function

public constant xsfSoundRecorder_destroy = define_c_proc(aud,"+sfSoundRecorder_destroy",{C_POINTER})

public procedure sfSoundRecorder_destroy(atom sr)
	c_proc(xsfSoundRecorder_destroy,{sr})
end procedure

public constant xsfSoundRecorder_start = define_c_func(aud,"+sfSoundRecorder_start",{C_POINTER,C_UINT},C_BOOL)

public function sfSoundRecorder_start(atom sr,atom samp)
	return c_func(xsfSoundRecorder_start,{sr,samp})
end function

public constant xsfSoundRecorder_stop = define_c_proc(aud,"+sfSoundRecorder_stop",{C_POINTER})

public procedure sfSoundRecorder_stop(atom sr)
	c_proc(xsfSoundRecorder_stop,{sr})
end procedure

public constant xsfSoundRecorder_getSampleRate = define_c_func(aud,"+sfSoundRecorder_getSampleRate",{C_POINTER},C_UINT)

public function sfSoundRecorder_getSampleRate(atom sr)
	return c_func(xsfSoundRecorder_getSampleRate,{sr})
end function

public constant xsfSoundRecorder_isAvailable = define_c_func(aud,"+sfSoundRecorder_isAvailable",{},C_BOOL)

public function sfSoundRecorder_isAvailable()
	return c_func(xsfSoundRecorder_isAvailable,{})
end function

public constant xsfSoundRecorder_setProcessingInterval = define_c_proc(aud,"+sfSoundRecorder_setProcessingInterval",{C_POINTER,sfTime})

public procedure sfSoundRecorder_setProcessingInterval(atom sr,atom interval)
	c_proc(xsfSoundRecorder_setProcessingInterval,{sr,interval})
end procedure

public constant xsfSoundRecorder_getAvailableDevices = define_c_func(aud,"+sfSoundRecorder_getAvailableDevices",{C_POINTER},C_STRING)

public function sfSoundRecorder_getAvailableDevices(atom cnt)
	return c_func(xsfSoundRecorder_getAvailableDevices,{cnt})
end function

public constant xsfSoundRecorder_getDefaultDevice = define_c_func(aud,"+sfSoundRecorder_getDefaultDevice",{},C_STRING)

public function sfSoundRecorder_getDefaultDevice()
	return c_func(xsfSoundRecorder_getDefaultDevice,{})
end function

public constant xsfSoundRecorder_setDevice = define_c_func(aud,"+sfSoundRecorder_setDevice",{C_POINTER,C_STRING},C_BOOL)

public function sfSoundRecorder_setDevice(atom sr,sequence name)
	return c_func(xsfSoundRecorder_setDevice,{sr,name})
end function

public constant xsfSoundRecorder_getDevice = define_c_func(aud,"+sfSoundRecorder_getDevice",{C_POINTER},C_STRING)

public function sfSoundRecorder_getDevice(atom sr)
	return c_func(xsfSoundRecorder_getDevice,{sr})
end function

public constant xsfSoundRecorder_setChannelCount = define_c_proc(aud,"+sfSoundRecorder_setChannelCount",{C_POINTER,C_UINT})

public procedure sfSoundRecorder_setChannelCount(atom sr,atom cnt)
	c_proc(xsfSoundRecorder_setChannelCount,{sr,cnt})
end procedure

public constant xsfSoundRecorder_getChannelCount = define_c_func(aud,"+sfSoundRecorder_getChannelCount",{C_POINTER},C_UINT)

public function sfSoundRecorder_getChannelCount(atom sr)
	return c_func(xsfSoundRecorder_getChannelCount,{sr})
end function

--SoundStream

public constant sfSoundStreamChunk = define_c_struct({
	C_POINTER, --samples
	C_UINT --sampleCount
})

public constant xsfSoundStream_create = define_c_func(aud,"+sfSoundStream_create",{C_POINTER,C_POINTER,C_UINT,C_UINT,C_POINTER},C_POINTER)

public function sfSoundStream_create(atom onGetData,atom onSeek,atom channelCount,atom sampRate,atom userData)
	return c_func(xsfSoundStream_create,{onGetData,onSeek,channelCount,sampRate,userData})
end function

public constant xsfSoundStream_destroy = define_c_proc(aud,"+sfSoundStream_destroy",{C_POINTER})

public procedure sfSoundStream_destroy(atom ss)
	c_proc(xsfSoundStream_destroy,{ss})
end procedure

public constant xsfSoundStream_play = define_c_proc(aud,"+sfSoundStream_play",{C_POINTER})

public procedure sfSoundStream_play(atom ss)
	c_proc(xsfSoundStream_play,{ss})
end procedure

public constant xsfSoundStream_pause = define_c_proc(aud,"+sfSoundStream_pause",{C_POINTER})

public procedure sfSoundStream_pause(atom ss)
	c_proc(xsfSoundStream_pause,{ss})
end procedure

public constant xsfSoundStream_stop = define_c_proc(aud,"+sfSoundStream_stop",{C_POINTER})

public procedure sfSoundStream_stop(atom ss)
	c_proc(xsfSoundStream_stop,{ss})
end procedure

public constant xsfSoundStream_getStatus = define_c_func(aud,"+sfSoundStream_getStatus",{C_POINTER},C_INT)

public function sfSoundStream_getStatus(atom ss)
	return c_func(xsfSoundStream_getStatus,{ss})
end function

public constant xsfSoundStream_getChannelCount = define_c_func(aud,"+sfSoundStream_getChannelCount",{C_POINTER},C_UINT)

public function sfSoundStream_getChannelCount(atom ss)
	return c_func(xsfSoundStream_getChannelCount,{ss})
end function

public constant xsfSoundStream_getSampleRate = define_c_func(aud,"+sfSoundStream_getSampleRate",{C_POINTER},C_UINT)

public function sfSoundStream_getSampleRate(atom ss)
	return c_func(xsfSoundStream_getSampleRate,{ss})
end function

public constant xsfSoundStream_setPitch = define_c_proc(aud,"+sfSoundStream_setPitch",{C_POINTER,C_FLOAT})

public procedure sfSoundStream_setPitch(atom ss,atom p)
	c_proc(xsfSoundStream_setPitch,{ss,p})
end procedure

public constant xsfSoundStream_setVolume = define_c_proc(aud,"+sfSoundStream_setVolume",{C_POINTER,C_FLOAT})

public procedure sfSoundStream_setVolume(atom ss,atom vol)
	c_proc(xsfSoundStream_setVolume,{ss,vol})
end procedure

public constant xsfSoundStream_setPosition = define_c_proc(aud,"+sfSoundStream_setPosition",{C_POINTER,sfVector3f})

public procedure sfSoundStream_setPosition(atom ss,sequence pos)
	c_proc(xsfSoundStream_setPosition,{ss,pos})
end procedure

public constant xsfSoundStream_setRelativeToListener = define_c_proc(aud,"+sfSoundStream_setRelativeToListener",{C_POINTER,C_BOOL})

public procedure sfSoundStream_setRelativeToListener(atom ss,atom rel)
	c_proc(xsfSoundStream_setRelativeToListener,{ss,rel})
end procedure

public constant xsfSoundStream_setMinDistance = define_c_proc(aud,"+sfSoundStream_setMinDistance",{C_POINTER,C_FLOAT})

public procedure sfSoundStream_setMinDistance(atom ss,atom dis)
	c_proc(xsfSoundStream_setMinDistance,{ss,dis})
end procedure

public constant xsfSoundStream_setAttenuation = define_c_proc(aud,"+sfSoundStream_setAttenuation",{C_POINTER,C_FLOAT})

public procedure sfSoundStream_setAttenuation(atom ss,atom att)
	c_proc(xsfSoundStream_setAttenuation,{ss,att})
end procedure

public constant xsfSoundStream_setPlayingOffset = define_c_proc(aud,"+sfSoundStream_setPlayingOffset",{C_POINTER,sfTime})

public procedure sfSoundStream_setPlayingOffset(atom ss,sequence t)
	c_proc(xsfSoundStream_setPlayingOffset,{ss,t})
end procedure

public constant xsfSoundStream_setLoop = define_c_proc(aud,"+sfSoundStream_setLoop",{C_POINTER,C_BOOL})

public procedure sfSoundStream_setLoop(atom ss,atom l)
	c_proc(xsfSoundStream_setLoop,{ss,l})
end procedure

public constant xsfSoundStream_getPitch = define_c_func(aud,"+sfSoundStream_getPitch",{C_POINTER},C_FLOAT)

public function sfSoundStream_getPitch(atom ss)
	return c_func(xsfSoundStream_getPitch,{ss})
end function

public constant xsfSoundStream_getVolume = define_c_func(aud,"+sfSoundStream_getVolume",{C_POINTER},C_FLOAT)

public function sfSoundStream_getVolume(atom ss)
	return c_func(xsfSoundStream_getVolume,{ss})
end function

public constant xsfSoundStream_getPosition = define_c_func(aud,"+sfSoundStream_getPosition",{C_POINTER},sfVector3f)

public function sfSoundStream_getPosition(atom ss)
	return c_func(xsfSoundStream_getPosition,{ss})
end function

public constant xsfSoundStream_isRelativeToListener = define_c_func(aud,"+sfSoundStream_isRelativeToListener",{C_POINTER},C_BOOL)

public function sfSoundStream_isRelativeToListener(atom ss)
	return c_func(xsfSoundStream_isRelativeToListener,{ss})
end function

public constant xsfSoundStream_getMinDistance = define_c_func(aud,"+sfSoundStream_getMinDistance",{C_POINTER},C_FLOAT)

public function sfSoundStream_getMinDistance(atom ss)
	return c_func(xsfSoundStream_getMinDistance,{ss})
end function

public constant xsfSoundStream_getAttenuation = define_c_func(aud,"+sfSoundStream_getAttenuation",{C_POINTER},C_FLOAT)

public function sfSoundStream_getAttenuation(atom ss)
	return c_func(xsfSoundStream_getAttenuation,{ss})
end function

public constant xsfSoundStream_getLoop = define_c_func(aud,"+sfSoundStream_getLoop",{C_POINTER},C_BOOL)

public function sfSoundStream_getLoop(atom ss)
	return c_func(xsfSoundStream_getLoop,{ss})
end function

public constant xsfSoundStream_getPlayingOffset = define_c_func(aud,"+sfSoundStream_getPlayingOffset",{C_POINTER},sfTime)

public function sfSoundStream_getPlayingOffset(atom ss)
	return c_func(xsfSoundStream_getPlayingOffset,{ss})
end function
­707.42