include std/ffi.e
include std/machine.e
include std/os.e

atom win = 0

include sfml_system.e

ifdef WINDOWS then
	win = open_dll("csfml-window-2.dll")
	elsifdef LINUX or FREEBSD then
	win = open_dll("libcsmfl-window-2.so")
end ifdef

--VideoMode (VideoMode.h)
public constant sfVideoMode = define_c_struct({
	C_UINT, --width
	C_UINT, --height
	C_UINT --bitsPerPixel
})

public constant xsfVideoMode_getDesktopMode = define_c_func(win,"+sfVideoMode_getDesktopMode",{},sfVideoMode)

public function sfVideoMode_getDesktopMode()
	return c_func(xsfVideoMode_getDesktopMode,{})
end function

public constant xsfVideoMode_getFullscreenModes = define_c_func(win,"+sfVideoMode_getFullscreenModes",{C_POINTER},C_POINTER)

public function sfVideoMode_getFullscreenModes(atom count)
	return c_func(xsfVideoMode_getFullscreenModes,{count})
end function

public constant xsfVideoMode_isValid = define_c_func(win,"+sfVideoMode_isValid",{sfVideoMode},C_BOOL)

public function sfVideoMode_isValid(sequence mode)
	return c_func(xsfVideoMode_isValid,{mode})
end function

--Clipboard (Clipboard.h)

public constant xsfClipboard_getString = define_c_func(win,"+sfClipboard_getString",{},C_STRING)

public function sfClipboard_getString()
	return c_func(xsfClipboard_getString,{})
end function

public constant xsfClipboard_getUnicodeString = define_c_func(win,"+sfClipboard_getUnicodeString",{},C_POINTER)

public function sfClipboard_getUnicodeString()
	return c_func(xsfClipboard_getUnicodeString,{})
end function

public constant xsfClipboard_setString = define_c_proc(win,"+sfClipboard_setString",{C_STRING})

public procedure sfClipboard_setString(sequence text)
	c_proc(xsfClipboard_setString,{text})
end procedure

public constant xsfClipboard_setUnicodeString = define_c_proc(win,"+sfClipboard_setUnicodeString",{C_POINTER})

public procedure sfClipboard_setUnicodeString(atom text)
	c_proc(xsfClipboard_setUnicodeString,{text})
end procedure

--Cursor (Cursor.h)
public enum type sfCursorType
	sfCursorArrow = 0,
	sfCursorArrowWait,
	sfCursorWait,
	sfCursorText,
	sfCursorHand,
	sfCursorSizeHorizontal,
	sfCursorSizeVertical,
	sfCursorSizeTopLeftBottomRight,
	sfCursorSizeBottomLeftTopRight,
	sfCursorSizeLeft,
	sfCursorSizeRight,
	sfCursorSizeTop,
	sfCursorSizeBottom,
	sfCursorSizeTopLeft,
	sfCursorSizeBottomRight,
	sfCursorSizeBottomLeft,
	sfCursorSizeTopRight,
	sfCursorSizeAll,
	sfCursorCross,
	sfCursorHelp,
	sfCursorNotAllowed
end type

public constant xsfCursor_createFromPixels = define_c_func(win,"+sfCursor_createFromPixels",{C_POINTER,sfVector2u,sfVector2u},C_POINTER)

public function sfCursor_createFromPixels(atom pixels,sequence size,sequence hotspot)
	return c_func(xsfCursor_createFromPixels,{pixels,size,hotspot})
end function

public constant xsfCursor_createFromSystem = define_c_func(win,"+sfCursor_createFromSystem",{C_INT},C_POINTER)

public function sfCursor_createFromSystem(sfCursorType ctype)
	return c_func(xsfCursor_createFromSystem,{ctype})
end function

public constant xsfCursor_destroy = define_c_proc(win,"+sfCursor_destroy",{C_POINTER})

public procedure sfCursor_destroy(atom cursor)
	c_proc(xsfCursor_destroy,{cursor})
end procedure

--Keyboard (Keyboard.h)

public enum type sfKeyCode
	sfKeyUnknown = -1,
	sfKeyA,
	sfKeyB,
	sfKeyC,
	sfKeyD,
	sfKeyE,
	sfKeyF,
	sfKeyG,
	sfKeyH,
	sfKeyI,
	sfKeyJ,
	sfKeyK,
	sfKeyL,
	sfKeyM,
	sfKeyN,
	sfKeyO,
	sfKeyP,
	sfKeyQ,
	sfKeyR,
	sfKeyS,
	sfKeyT,
	sfKeyU,
	sfKeyV,
	sfKeyW,
	sfKeyX,
	sfKeyY,
	sfKeyZ,
	sfKeyNum0,
	sfKeyNum1,
	sfKeyNum2,
	sfKeyNum3,
	sfKeyNum4,
	sfKeyNum5,
	sfKeyNum6,
	sfKeyNum7,
	sfKeyNum8,
	sfKeyNum9,
	sfKeyEscape,
	sfKeyLControl,
	sfKeyLShift,
	sfKeyLAlt,
	sfKeyLSystem,
	sfKeyRControl,
	sfKeyRShift,
	sfKeyRAlt,
	sfKeyRSystem,
	sfKeyMenu,
	sfKeyLBracket,
	sfKeyRBracket,
	sfKeySemicolon,
	sfKeyComma,
	sfKeyPeriod,
	sfKeyQuote,
	sfKeySlash,
	sfKeyBackslash,
	sfKeyTilde,
	sfKeyEqual,
	sfKeyHyphen,
	sfKeySpace,
	sfKeyEnter,
	sfKeyBackspace,
	sfKeyTab,
	sfKeyPageUp,
	sfKeyPageDown,
	sfKeyEnd,
	sfKeyHome,
	sfKeyInsert,
	sfKeyDelete,
	sfKeyAdd,
	sfKeySubtract,
	sfKeyMultiply,
	sfKeyDivide,
	sfKeyLeft,
	sfKeyRight,
	sfKeyUp,
	sfKeyDown,
	sfKeyNumpad0,
	sfKeyNumpad1,
	sfKeyNumpad2,
	sfKeyNumpad3,
	sfKeyNumpad4,
	sfKeyNumpad5,
	sfKeyNumpad6,
	sfKeyNumpad7,
	sfKeyNumpad8,
	sfKeyNumpad9,
	sfKeyF1,
	sfKeyF2,
	sfKeyF3,
	sfKeyF4,
	sfKeyF5,
	sfKeyF6,
	sfKeyF7,
	sfKeyF8,
	sfKeyF9,
	sfKeyF10,
	sfKeyF11,
	sfKeyF12,
	sfKeyF13,
	sfKeyF14,
	sfKeyF15,
	sfKeyPause,
	sfKeyCount
end type

--Scancodes

public enum type sfScancode
	sfScanUnknown = -1,
	sfScanA = 0,
	sfScanB,
	sfScanC,
	sfScanD,
	sfScanE,
	sfScanF,
	sfScanG,
	sfScanH,
	sfScanI,
	sfScanJ,
	sfScanK,
	sfScanL,
	sfScanM,
	sfScanN,
	sfScanO,
	sfScanP,
	sfScanQ,
	sfScanR,
	sfScanS,
	sfScanT,
	sfScanU,
	sfScanV,
	sfScanW,
	sfScanX,
	sfScanY,
	sfScanZ,
	sfScanNum1,
	sfScanNum2,
	sfScanNum3,
	sfScanNum4,
	sfScanNum5,
	sfScanNum6,
	sfScanNum7,
	sfScanNum8,
	sfScanNum9,
	sfScanNum0,
	sfScanEnter,
	sfScanEscape,
	sfScanBackspace,
	sfScanTab,
	sfScanSpace,
	sfScanHyphen,
	sfScanEqual,
	sfLBracket,
	sfRBracket,
	sfScanBackslash,
	sfScanSemicolon,
	sfScanApostrophe,
	sfScanGrave,
	sfScanComma,
	sfScanPeriod,
	sfScanSlash,
	sfScanF1,
	sfScanF2,
	sfScanF3,
	sfScanF4,
	sfScanF5,
	sfScanF6,
	sfScanF7,
	sfScanF8,
	sfScanF9,
	sfScanF10,
	sfScanF11,
	sfScanF12,
	sfScanF13,
	sfScanF14,
	sfScanF15,
	sfScanF16,
	sfScanF17,
	sfScanF18,
	sfScanF19,
	sfScanF20,
	sfScanF21,
	sfScanF22,
	sfScanF23,
	sfScanF24,
	sfScanCapsLock,
	sfScanPrintScreen,
	sfScanScrollLock,
	sfScanPause,
	sfScanInsert,
	sfScanHome,
	sfScanPageUp,
	sfScanEnd,
	sfScanPageDown,
	sfScanRight,
	sfScanLeft,
	sfScanDown,
	sfScanUp,
	sfScanNumLock,
	sfScanNumpadDivide,
	sfScanNumpadMultiply,
	sfScanNumpadMinus,
	sfScanNumpadPlus,
	sfScanNumpadEqual,
	sfScanNumpadEnter,
	sfScanNumpadDecimal,
	sfScanNumpad1,
	sfScanNumpad2,
	sfScanNumpad3,
	sfScanNumpad4,
	sfScanNumpad5,
	sfScanNumpad6,
	sfScanNumpad7,
	sfScanNumpad8,
	sfScanNumpad9,
	sfScanNumpad0,
	sfScanNonUsBackslash,
	sfScanApplication,
	sfScanExecute,
	sfScanModeChange,
	sfScanHelp,
	sfScanMenu,
	sfScanSelect,
	sfScanRedo,
	sfScanUndo,
	sfScanCut,
	sfScanCopy,
	sfScanPaste,
	sfScanVolumeMute,
	sfScanVolumeUp,
	sfScanVolumeDown,
	sfScanMediaPlayPause,
	sfScanMediaStop,
	sfScanMediaNextTrack,
	sfScanMediaPreviousTrack,
	sfScanLControl,
	sfScanLShift,
	sfScanLAlt,
	sfScanLSystem,
	sfScanRControl,
	sfScanRShift,
	sfScanRAlt,
	sfScanRSystem,
	sfScanBack,
	sfScanForward,
	sfScanRefresh,
	sfScanStop,
	sfScanSearch,
	sfScanFavorites,
	sfScanHomePage,
	sfScanLaunchApplication1,
	sfScanLaunchApplication2,
	sfScanLaunchMail,
	sfScanLaunchMediaSelect,
	sfScancodeCount
end type

public constant xsfKeyboard_isKeyPressed = define_c_func(win,"+sfKeyboard_isKeyPressed",{C_INT},C_BOOL)

public function sfKeyboard_isKeyPressed(sfKeyCode key)
	return c_func(xsfKeyboard_isKeyPressed,{key})
end function

public constant xsfKeyboard_isScancodePressed = define_c_func(win,"+sfKeyboard_isScancodePressed",{C_INT},C_BOOL)

public function sfKeyboard_isScancodePressed(sfScancode code)
	return c_func(xsfKeyboard_isScancodePressed,{code})
end function

public constant xsfKeyboard_localize = define_c_func(win,"+sfKeyboard_localize",{C_INT},C_INT)

public function sfKeyboard_localize(sfScancode code)
	return c_func(xsfKeyboard_localize,{code})
end function

public constant xsfKeyboard_delocalize = define_c_func(win,"+sfKeyboard_delocalize",{C_INT},C_INT)

public function sfKeyboard_delocalize(sfKeyCode key)
	return c_func(xsfKeyboard_delocalize,{key})
end function

public constant xsfKeyboard_getDescription = define_c_func(win,"+sfKeyboard_getDescription",{C_INT},C_STRING)

public function sfKeyboard_getDescription(sfScancode code)
	return c_func(xsfKeyboard_getDescription,{code})
end function

public constant xsfKeyboard_setVirtualKeyboardVisible = define_c_proc(win,"+sfKeyboard_setVirtualKeyboardVisible",{C_BOOL})

public procedure sfKeyboard_setVirtualKeyboardVisible(atom visible)
	c_proc(xsfKeyboard_setVirtualKeyboardVisible,{visible})
end procedure

--Mouse (Mouse.h)

public enum type sfMouseButton
	sfMouseLeft = 0,
	sfMouseRight,
	sfMouseMiddle,
	sfMouseXButton1,
	sfMouseXButton2,
	sfMouseButtonCount
end type

public enum type sfMouseWheel
	sfMouseVerticalWheel = 0,
	sfMouseHorizontalWheel
end type

public constant xsfMouse_isButtonPressed = define_c_func(win,"+sfMouse_isButtonPressed",{C_INT},C_BOOL)

public function sfMouse_isButtonPressed(sfMouseButton button)
	return c_func(xsfMouse_isButtonPressed,{button})
end function

public constant xsfMouse_getPosition = define_c_func(win,"+sfMouse_getPosition",{C_POINTER},sfVector2i)

public function sfMouse_getPosition(atom relativeTo)
	return c_func(xsfMouse_getPosition,{relativeTo})
end function

public constant xsfMouse_setPosition = define_c_proc(win,"+sfMouse_setPosition",{sfVector2i,C_POINTER})

public procedure sfMouse_setPosition(sequence pos,atom relativeTo)
	c_proc(xsfMouse_setPosition,{pos,relativeTo})
end procedure

--JoystickIdentification (JoystickIdentification.h)

public constant sfJoystickIdentification = define_c_struct({
	C_STRING, --name
	C_UINT, --vendorID
	C_UINT --productID
})

--Joystick (Joystick.h)

public enum sfJoystickCount = 8,
		sfJoystickButtonCount = 32,
		sfJoystickAxisCount = 8
		
public enum type sfJoystickAxis
	sfJoystickX = 0,
	sfJoystickY,
	sfJoystickZ,
	sfJoystickR,
	sfJoystickU,
	sfJoystickV,
	sfJoystickPovX,
	sfJoystickPovY
end type

public constant xsfJoystick_isConnected = define_c_func(win,"+sfJoystick_isConnected",{C_UINT},C_BOOL)

public function sfJoystick_isConnected(atom joystick)
	return c_func(xsfJoystick_isConnected,{joystick})
end function

public constant xsfJoystick_getButtonCount = define_c_func(win,"+sfJoystick_getButtonCount",{C_UINT},C_UINT)

public function sfJoystick_getButtonCount(atom joystick)
	return c_func(xsfJoystick_getButtonCount,{joystick})
end function

public constant xsfJoystick_hasAxis = define_c_func(win,"+sfJoystick_hasAxis",{C_UINT,C_INT},C_BOOL)

public function sfJoystick_hasAxis(atom joystick,sfJoystickAxis axis)
	return c_func(xsfJoystick_hasAxis,{joystick,axis})
end function

public constant xsfJoystick_isButtonPressed = define_c_func(win,"+sfJoystick_isButtonPressed",{C_UINT,C_UINT},C_BOOL)

public function sfJoystick_isButtonPressed(atom joystick,atom button)
	return c_func(xsfJoystick_isButtonPressed,{joystick,button})
end function

public constant xsfJoystick_getAxisPosition = define_c_func(win,"+sfJoystick_getAxisPosition",{C_UINT,C_INT},C_FLOAT)

public function sfJoystick_getAxisPosition(atom joystick,sfJoystickAxis axis)
	return c_func(xsfJoystick_getAxisPosition,{joystick,axis})
end function

public constant xsfJoystick_getIdentification = define_c_func(win,"+sfJoystick_getIdentification",{C_UINT},sfJoystickIdentification)

public function sfJoystick_getIdentification(atom joystick)
	return c_func(xsfJoystick_getIdentification,{joystick})
end function

public constant xsfJoystick_update = define_c_proc(win,"+sfJoystick_update",{})

public procedure sfJoystick_update()
	c_proc(xsfJoystick_update,{})
end procedure

--Sensor (Sensor.h)

public enum type sfSensorType
	sfSensorAccelerometer = 0,
	sfSensorGyroscope,
	sfSensorMagnetometer,
	sfSensorGravity,
	sfSensorUserAcceleration,
	sfSensorOrientation,
	sfSensorCount
end type

public constant xsfSensor_isAvailable = define_c_func(win,"+sfSensor_isAvailable",{C_INT},C_BOOL)

public function sfSensor_isAvailable(sfSensorType sensor)
	return c_func(xsfSensor_isAvailable,{sensor})
end function

public constant xsfSensor_setEnabled = define_c_proc(win,"+sfSensor_setEnabled",{C_INT,C_BOOL})

public procedure sfSensor_setEnabled(sfSensorType sensor,atom enabled)
	c_proc(xsfSensor_setEnabled,{sensor,enabled})
end procedure

public constant xsfSensor_getValue = define_c_func(win,"+sfSensor_getValue",{C_INT},sfVector3f)

public function sfSensor_getValue(sfSensorType sensor)
	return c_func(xsfSensor_getValue,{sensor})
end function

--Touch (Touch.h)

public constant xsfTouch_isDown = define_c_func(win,"+sfTouch_isDown",{C_UINT},C_BOOL)

public function sfTouch_isDown(atom finger)
	return c_func(xsfTouch_isDown,{finger})
end function

public constant xsfTouch_getPosition = define_c_func(win,"+sfTouch_getPosition",{C_UINT,C_POINTER},sfVector2i)

public function sfTouch_getPosition(atom finger,atom relTo)
	return c_func(xsfTouch_getPosition,{finger,relTo})
end function

--Event (Event.h)

public enum type sfEventType
	sfEvtClosed = 0,
	sfEvtResized,
	sfEvtLostFocus,
	sfEvtGainedFocus,
	sfEvtTextEntered,
	sfEvtKeyPressed,
	sfEvtKeyReleased,
	sfEvtMouseWheelMoved,
	sfEvtMouseWheelScrolled,
	sfEvtMouseButtonPressed,
	sfEvtMouseButtonReleased,
	sfEvtMouseMoved,
	sfEvtMouseEntered,
	sfEvtMouseLeft,
	sfEvtJoystickButtonPressed,
	sfEvtJoystickButtonReleased,
	sfEvtJoystickMoved,
	sfEvtJoystickConnected,
	sfEvtJoystickDisconnected,
	sfEvtTouchBegan,
	sfEvtTouchMoved,
	sfEvtTouchEnded,
	sfEvtSensorChanged,
	sfEvtCount
end type

public constant sfKeyEvent = define_c_struct({
	C_INT, --type sfEventType
	C_INT, --code sfKeycode
	C_INT, --scancode sfScancode
	C_BOOL, --alt
	C_BOOL, --control
	C_BOOL, --shift
	C_BOOL --system
})

public constant sfTextEvent = define_c_struct({
	C_INT, --type sfEventType
	C_UINT32 --unicode
})

public constant sfMouseMoveEvent = define_c_struct({
	C_INT, --type sfEventType
	C_INT, --x
	C_INT --y
})

public constant sfMouseButtonEvent = define_c_struct({
	C_INT, --type sfEventType
	C_INT, --button sfMouseButton
	C_INT, --x
	C_INT --y
})

public constant sfMouseWheelScrollEvent = define_c_struct({
	C_INT, --type sfEventType
	C_INT, --wheel sfMouseWheel
	C_FLOAT, --delta
	C_INT, --x
	C_INT --y
})

public constant sfJoystickMoveEvent = define_c_struct({
	C_INT, --type sfEventType
	C_UINT, --joystickID
	C_INT, --sfJoystickAxis axis
	C_FLOAT --position
})

public constant sfJoystickButtonEvent = define_c_struct({
	C_INT, --type sfEventType
	C_UINT, --joystickid
	C_UINT --button
})

public constant sfJoystickConnectEvent = define_c_struct({
	C_INT, --type
	C_UINT --joystickId
})

public constant sfSizeEvent = define_c_struct({
	C_INT, --type
	C_UINT, --width
	C_UINT --height
})

public constant sfTouchEvent = define_c_struct({
	C_INT, --type
	C_UINT, --finger
	C_INT, --x
	C_INT --y
})

public constant sfSensorEvent = define_c_struct({
	C_INT, --type
	C_INT, --sensorType
	C_FLOAT, --x
	C_FLOAT, --y
	C_FLOAT --z
})

public constant xsfMouseWheelEvent = define_c_struct({
	C_INT, --sfEventType
	C_INT, --delta
	C_INT, --x
	C_INT --y
})

public constant sfEvent = define_c_union({
	C_INT, --sfEventType
	sfSizeEvent,
	sfKeyEvent,
	sfTextEvent,
	sfMouseMoveEvent,
	sfMouseButtonEvent,
	--sfMouseWheelEvent,
	sfMouseWheelScrollEvent,
	sfJoystickMoveEvent,
	sfJoystickButtonEvent,
	sfJoystickConnectEvent,
	sfTouchEvent,
	sfSensorEvent
})

--Window (window.h)

public enum type sfWindowStyle
	sfNone = 0,
	sfTitlebar = 1,
	sfResize = 2,
	sfClose = 4,
	sfFullscreen = 8,
	sfDefaultStyle = 7 -- sfTitlebar | sfResize | sfClose
end type

public enum type sfContextAttribute
	sfContextDefault = 0,
	sfContextCore = 1,
	sfContextDebug = 4
end type

public constant sfContextSettings = define_c_struct({
	C_UINT, --depthBits
	C_UINT, --stencilBits
	C_UINT, --antialiaslevel
	C_UINT, --majorVersion
	C_UINT, --minorVersion
	C_UINT32, --attributeFlags
	C_BOOL --sRgbCapable
})

public constant xsfWindow_create = define_c_func(win,"sfWindow_create",{sfVideoMode,C_STRING,C_UINT32,C_POINTER},C_POINTER)

public function sfWindow_create(sequence mode,sequence title,atom style,atom settings)
	return c_func(xsfWindow_create,{mode,title,style,settings})
end function

public constant xsfWindow_createUnicode = define_c_func(win,"+sfWindow_createUnicode",{sfVideoMode,C_POINTER,C_UINT32,C_POINTER},C_POINTER)

public function sfWindow_createUnicode(sequence mode,atom title,atom style,atom settings)
	return c_func(xsfWindow_createUnicode,{mode,title,style,settings})
end function

public constant xsfWindow_createFromHandle = define_c_func(win,"+sfWindow_createFromHandle",{C_POINTER,C_POINTER},C_POINTER)

public function sfWindow_createFromHandle(atom handle,atom settings)
	return c_func(xsfWindow_createFromHandle,{handle,settings})
end function

public constant xsfWindow_destroy = define_c_proc(win,"+sfWindow_destroy",{C_POINTER})

public procedure sfWindow_destroy(atom window)
	c_proc(xsfWindow_destroy,{window})
end procedure

public constant xsfWindow_close = define_c_proc(win,"+sfWindow_close",{C_POINTER})

public procedure sfWindow_close(atom window)
	c_proc(xsfWindow_close,{window})
end procedure

public constant xsfWindow_isOpen = define_c_func(win,"+sfWindow_isOpen",{C_POINTER},C_BOOL)

public function sfWindow_isOpen(atom window)
	return c_func(xsfWindow_isOpen,{window})
end function

public constant xsfWindow_getSettings = define_c_func(win,"+sfWindow_getSettings",{C_POINTER},C_POINTER)

public function sfWindow_getSettings(atom window)
	return c_func(xsfWindow_getSettings,{window})
end function

public constant xsfWindow_pollEvent = define_c_func(win,"+sfWindow_pollEvent",{C_POINTER,C_POINTER},C_BOOL)

public function sfWindow_pollEvent(atom window,atom event)
	return c_func(xsfWindow_pollEvent,{window,event})
end function

public constant xsfWindow_waitEvent = define_c_func(win,"+sfWindow_waitEvent",{C_POINTER,C_POINTER},C_BOOL)

public function sfWindow_waitEvent(atom window,atom event)
	return c_func(xsfWindow_waitEvent,{window,event})
end function

public constant xsfWindow_getPosition = define_c_func(win,"+sfWindow_getPosition",{C_POINTER},sfVector2i)

public function sfWindow_getPosition(atom window)
	return c_func(xsfWindow_getPosition,{window})
end function

public constant xsfWindow_setPosition = define_c_proc(win,"+sfWindow_setPosition",{C_POINTER,sfVector2i})

public procedure sfWindow_setPosition(atom window,sequence pos)
	c_proc(xsfWindow_setPosition,{window,pos})
end procedure

public constant xsfWindow_getSize = define_c_func(win,"+sfWindow_getSize",{C_POINTER},sfVector2u)

public function sfWindow_getSize(atom window)
	return c_func(xsfWindow_getSize,{window})
end function

public constant xsfWindow_setSize = define_c_proc(win,"+sfWindow_setSize",{C_POINTER,sfVector2u})

public procedure sfWindow_setSize(atom window,atom size)
	c_proc(xsfWindow_setSize,{window,size})
end procedure

public constant xsfWindow_setTitle = define_c_proc(win,"+sfWindow_setTitle",{C_POINTER,C_STRING})

public procedure sfWindow_setTitle(atom window,sequence title)
	c_proc(xsfWindow_setTitle,{window,title})
end procedure

public constant xsfWindow_setUnicodeTitle = define_c_proc(win,"+sfWindow_setUnicodeTitle",{C_POINTER,C_POINTER})

public procedure sfWindow_setUnicodeTitle(atom window,atom title)
	c_proc(xsfWindow_setUnicodeTitle,{window,title})
end procedure

public constant xsfWindow_setIcon = define_c_proc(win,"+sfWindow_setIcon",{C_POINTER,C_UINT,C_UINT,C_POINTER})

public procedure sfWindow_setIcon(atom window,atom width,atom height,atom pixels)
	c_proc(xsfWindow_setIcon,{window,width,height,pixels})
end procedure

public constant xsfWindow_setVisible = define_c_proc(win,"+sfWindow_setVisible",{C_POINTER,C_BOOL})

public procedure sfWindow_setVisible(atom window,atom vis)
	c_proc(xsfWindow_setVisible,{window,vis})
end procedure

public constant xsfWindow_setVerticalSyncEnabled = define_c_proc(win,"+sfWindow_setVerticalSyncEnabled",{C_POINTER,C_BOOL})

public procedure sfWindow_setVerticalSyncEnabled(atom window,atom en)
	c_proc(xsfWindow_setVerticalSyncEnabled,{window,en})
end procedure

public constant xsfWindow_setMouseCursorVisible = define_c_proc(win,"+sfWindow_setMouseCursorVisible",{C_POINTER,C_BOOL})

public procedure sfWindow_setMouseCursorVisible(atom window,atom vis)
	c_proc(xsfWindow_setMouseCursorVisible,{window,vis})
end procedure

public constant xsfWindow_setMouseCursorGrabbed = define_c_proc(win,"+sfWindow_setMouseCursorGrabbed",{C_POINTER,C_BOOL})

public procedure sfWindow_setMouseCursorGrabbed(atom window,atom grab)
	c_proc(xsfWindow_setMouseCursorGrabbed,{window,grab})
end procedure

public constant xsfWindow_setMouseCursor = define_c_proc(win,"+sfWindow_setMouseCursor",{C_POINTER,C_POINTER})

public procedure sfWindow_setMouseCursor(atom window,atom cur)
	c_proc(xsfWindow_setMouseCursor,{window,cur})
end procedure

public constant xsfWindow_setKeyRepeatEnabled = define_c_proc(win,"+sfWindow_setKeyRepeatEnabled",{C_POINTER,C_BOOL})

public procedure sfWindow_setKeyRepeatEnabled(atom window,atom en)
	c_proc(xsfWindow_setKeyRepeatEnabled,{window,en})
end procedure

public constant xsfWindow_setFramerateLimit = define_c_proc(win,"+sfWindow_setFramerateLimit",{C_POINTER,C_UINT})

public procedure sfWindow_setFramerateLimit(atom window,atom limit)
	c_proc(xsfWindow_setFramerateLimit,{window,limit})
end procedure

public constant xsfWindow_setJoystickThreshold = define_c_proc(win,"+sfWindow_setJoystickThreshold",{C_POINTER,C_FLOAT})

public procedure sfWindow_setJoystickThreshold(atom window,atom thres)
	c_proc(xsfWindow_setJoystickThreshold,{window,thres})
end procedure

public constant xsfWindow_setActive = define_c_func(win,"+sfWindow_setActive",{C_POINTER,C_BOOL},C_BOOL)

public function sfWindow_setActive(atom window,atom act)
	return c_func(xsfWindow_setActive,{window,act})
end function

public constant xsfWindow_requestFocus = define_c_proc(win,"+sfWindow_requestFocus",{C_POINTER})

public procedure sfWindow_requestFocus(atom window)
	c_proc(xsfWindow_requestFocus,{window})
end procedure

public constant xsfWindow_hasFocus = define_c_func(win,"+sfWindow_hasFocus",{C_POINTER},C_BOOL)

public function sfWindow_hasFocus(atom window)
	return c_func(xsfWindow_hasFocus,{window})
end function

public constant xsfWindow_display = define_c_proc(win,"+sfWindow_display",{C_POINTER})

public procedure sfWindow_display(atom window)
	c_proc(xsfWindow_display,{window})
end procedure

public constant xsfWindow_getSystemHandle = define_c_func(win,"+sfWindow_getSystemHandle",{C_POINTER},C_POINTER)

public function sfWindow_getSystemHandle(atom window)
	return c_func(xsfWindow_getSystemHandle,{window})
end function

--WindowBase

public constant xsfWindowBase_create = define_c_func(win,"+sfWindowBase_create",{sfVideoMode,C_STRING,C_UINT32},C_POINTER)

public function sfWindowBase_create(sequence mode,sequence title,atom style)
	return c_func(xsfWindowBase_create,{mode,title,style})
end function

public constant xsfWindowBase_createUnicode = define_c_func(win,"+sfWindowBase_createUnicode",{sfVideoMode,C_POINTER,C_UINT32},C_POINTER)

public function sfWindowBase_createUnicode(sequence mode,object title,atom style)
	return c_func(xsfWindowBase_createUnicode,{mode,title,style})
end function

public constant xsfWindowBase_createFromHandle = define_c_func(win,"+sfWindowBase_createFromHandle",{C_POINTER},C_POINTER)

public function sfWindowBase_createFromHandle(atom handle)
	return c_func(xsfWindowBase_createFromHandle,{handle})
end function

public constant xsfWindowBase_destroy = define_c_proc(win,"+sfWindowBase_destroy",{C_POINTER})

public procedure sfWindowBase_destroy(atom win)
	c_proc(xsfWindowBase_destroy,{win})
end procedure

public constant xsfWindowBase_close = define_c_proc(win,"+sfWindowBase_close",{C_POINTER})

public procedure sfWindowBase_close(atom win)
	c_proc(xsfWindowBase_close,{win})
end procedure

public constant xsfWindowBase_isOpen = define_c_func(win,"+sfWindowBase_isOpen",{C_POINTER},C_BOOL)

public function sfWindowBase_isOpen(atom win)
	return c_func(xsfWindowBase_isOpen,{win})
end function

public constant xsfWindowBase_pollEvent = define_c_func(win,"+sfWindowBase_pollEvent",{C_POINTER,C_POINTER},C_BOOL)

public function sfWindowBase_pollEvent(atom win,atom evt)
	return c_func(xsfWindowBase_pollEvent,{win,evt})
end function

public constant xsfWindowBase_waitEvent = define_c_func(win,"+sfWindowBase_waitEvent",{C_POINTER,C_POINTER},C_BOOL)

public function sfWindowBase_waitEvent(atom win,atom evt)
	return c_func(xsfWindowBase_waitEvent,{win,evt})
end function

public constant xsfWindowBase_getPosition = define_c_func(win,"+sfWindowBase_getPosition",{C_POINTER},sfVector2i)

public function sfWindowBase_getPosition(atom win)
	return c_func(xsfWindowBase_getPosition,{win})
end function

public constant xsfWindowBase_setPosition = define_c_proc(win,"+sfWindowBase_setPosition",{C_POINTER,sfVector2i})

public procedure sfWindowBase_setPosition(atom win,sequence pos)
	c_proc(xsfWindowBase_setPosition,{win,pos})
end procedure

public constant xsfWindowBase_getSize = define_c_func(win,"+sfWindowBase_getSize",{C_POINTER},sfVector2u)

public function sfWindowBase_getSize(atom win)
	return c_func(xsfWindowBase_getSize,{win})
end function

public constant xsfWindowBase_setSize = define_c_proc(win,"+sfWindowBase_setSize",{C_POINTER,sfVector2u})

public procedure sfWindowBase_setSize(atom win,sequence size)
	c_proc(xsfWindowBase_setSize,{win,size})
end procedure

public constant xsfWindowBase_setTitle = define_c_proc(win,"+sfWindowBase_setTitle",{C_POINTER,C_STRING})

public procedure sfWindowBase_setTitle(atom win,sequence title)
	c_proc(xsfWindowBase_setTitle,{win,title})
end procedure

public constant xsfWindowBase_setUnicodeTitle = define_c_proc(win,"+sfWindowBase_setUnicodeTitle",{C_POINTER,C_POINTER})

public procedure sfWindowBase_setUnicodeTitle(atom win,object title)
	c_proc(xsfWindowBase_setUnicodeTitle,{win,title})
end procedure

public constant xsfWindowBase_setIcon = define_c_proc(win,"+sfWindowBase_setIcon",{C_POINTER,C_UINT,C_UINT,C_POINTER})

public procedure sfWindowBase_setIcon(atom win,atom w,atom h,atom pix)
	c_proc(xsfWindowBase_setIcon,{win,w,h,pix})
end procedure

public constant xsfWindowBase_setVisible = define_c_proc(win,"+sfWindowBase_setVisible",{C_POINTER,C_BOOL})

public procedure sfWindowBase_setVisible(atom win,atom vis)
	c_proc(xsfWindowBase_setVisible,{win,vis})
end procedure

public constant xsfWindowBase_setMouseCursorVisible = define_c_proc(win,"+sfWindowBase_setMouseCursorVisible",{C_POINTER,C_BOOL})

public procedure sfWindowBase_setMouseCursorVisible(atom win,atom vis)
	c_proc(xsfWindowBase_setMouseCursorVisible,{win,vis})
end procedure

public constant xsfWindowBase_setMouseCursorGrabbed = define_c_proc(win,"+sfWindowBase_setMouseCursorGrabbed",{C_POINTER,C_BOOL})

public procedure sfWindowBase_setMouseCursorGrabbed(atom win,atom grab)
	c_proc(xsfWindowBase_setMouseCursorGrabbed,{win,grab})
end procedure

public constant xsfWindowBase_setMouseCursor = define_c_proc(win,"+sfWindowBase_setMouseCursor",{C_POINTER,C_POINTER})

public procedure sfWindowBase_setMouseCursor(atom win,atom cur)
	c_proc(xsfWindowBase_setMouseCursor,{win,cur})
end procedure

public constant xsfWindowBase_setKeyRepeatEnabled = define_c_proc(win,"+sfWindowBase_setKeyRepeatEnabled",{C_POINTER,C_BOOL})

public procedure sfWindowBase_setKeyRepeatEnabled(atom win,atom en)
	c_proc(xsfWindowBase_setKeyRepeatEnabled,{win,en})
end procedure

public constant xsfWindowBase_setJoystickThreshold = define_c_proc(win,"+sfWindowBase_setJoystickThreshold",{C_POINTER,C_FLOAT})

public procedure sfWindowBase_setJoystickThreshold(atom win,atom thres)
	c_proc(xsfWindowBase_setJoystickThreshold,{win,thres})
end procedure

public constant xsfWindowBase_requestFocus = define_c_proc(win,"+sfWindowBase_requestFocus",{C_POINTER})

public procedure sfWindowBase_requestFocus(atom win)
	c_proc(xsfWindowBase_requestFocus,{win})
end procedure

public constant xsfWindowBase_hasFocus = define_c_func(win,"+sfWindowBase_hasFocus",{C_POINTER},C_BOOL)

public function sfWindowBase_hasFocus(atom win)
	return c_func(xsfWindowBase_hasFocus,{win})
end function

public constant xsfWindowBase_getSystemHandle = define_c_func(win,"+sfWindowBase_getSystemHandle",{C_POINTER},C_POINTER)

public function sfWindowBase_getSystemHandle(atom win)
	return c_func(xsfWindowBase_getSystemHandle,{win})
end function

public constant xsfWindowBase_createVulkanSurface = define_c_func(win,"+sfWindowBase_createVulkanSurface",{C_POINTER,C_POINTER,C_POINTER},C_BOOL)

public function sfWindowBase_createVulkanSurface(atom win,atom inst,atom all)
	return c_func(xsfWindowBase_createVulkanSurface,{win,inst,all})
end function

--Vulkan

public constant xsfVulkan_isAvailable = define_c_func(win,"+sfVulkan_isAvailable",{C_BOOL},C_BOOL)

public function sfVulkan_isAvailable(atom requireGfx)
	return c_func(xsfVulkan_isAvailable,{requireGfx})
end function

public constant xsfVulkan_getFunction = define_c_func(win,"+sfVulkan_getFunction",{C_STRING},C_POINTER)

public function sfVulkan_getFunction(sequence name)
	return c_func(xsfVulkan_getFunction,{name})
end function

public constant xsfVulkan_getGraphicsRequiredInstanceExtensions = define_c_func(win,"+sfVulkan_getGraphicsRequiredInstanceExtensions",{},C_STRING)

public function sfVulkan_getGraphicsRequiredInstanceExtensions()
	return c_func(xsfVulkan_getGraphicsRequiredInstanceExtensions,{})
end function
­1027.64