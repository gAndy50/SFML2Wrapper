include std/ffi.e
include std/machine.e
include std/os.e

include sfml_system.e
include sfml_window.e

atom gfx = 0

ifdef WINDOWS then
	gfx = open_dll("csfml-graphics-2.dll")
	elsifdef LINUX or FREEBSD then
	gfx = open_dll("libcsfml-graphics-2.so")
end ifdef

--BlendMode
public enum type sfBlendFactor
	sfBlendFactorZero = 0,
	sfBlendFactorOne,
	sfBlendFactorSrcColor,
	sfBlendFactorOneMinusSrcColor,
	sfBlendFactorDstColor,
	sfBlendFactorOneMiusDstColor,
	sfBlendFactorSrcAlpha,
	sfBlendFactorOneMinusSrcAlpha,
	sfBlendFactorDstAlpha,
	sfBlendFactorOneMinusDstAlpha
end type

public enum type sfBlendEquation
	sfBlendEquationAdd = 0,
	sfBlendEquationSubtract,
	sfBlendEquationReverseSubtract,
	sfBlendEquationMin,
	sfBlendEquationMax
end type

public constant sfBlendMode = define_c_struct({
	C_INT, --colorSrcFactor
	C_INT, --colorDstFactor
	C_INT, --colorEquation
	C_INT, --alphaSrcFactor
	C_INT, --alphaDstFactor
	C_INT --alphaEquation
})

public constant sfBlendAlpha = sfBlendMode,
				sfBlendAdd = sfBlendMode,
				sfBlendMultiply = sfBlendMode,
				sfBlendNone = sfBlendMode
				
--Color
public constant sfColor = define_c_struct({
	C_UINT8, --r
	C_UINT8, --g
	C_UINT8, --g
	C_UINT8 --a
})

public constant sfGlslVec2 = sfVector2f
public constant sfGlslIvec2 = sfVector2i

public constant sfGlslBvec2 = define_c_struct({
	C_BOOL, --x
	C_BOOL --y
})

public constant sfGlslVec3 = sfVector3f

public constant sfGlslIvec3 = define_c_struct({
	C_INT, --x
	C_INT, --y
	C_INT --z
})

public constant sfGlslBvec3 = define_c_struct({
	C_BOOL, --x
	C_BOOL, --y
	C_BOOL --z
})

public constant sfGlslVec4 = define_c_struct({
	C_FLOAT, --x
	C_FLOAT, --y
	C_FLOAT, --z
	C_FLOAT --w
})

public constant sfGlslIvec4 = define_c_struct({
	C_INT, --x
	C_INT, --y
	C_INT, --z
	C_INT --w
})

public constant sfGlslBvec4 = define_c_struct({
	C_BOOL, --x
	C_BOOL, --y
	C_BOOL, --w
	C_BOOL --z
})

public constant sfGlslMat3 = define_c_struct({
	{C_FLOAT,3 * 3} --array
})

public constant sfGlslMat4 = define_c_struct({
	{C_FLOAT,4 * 4} --array
})

--SFML Colors
public constant sfBlack = {0,0,0,0}
public constant sfWhite = {255,255,255,255}
public constant sfRed = {255,0,0,255}
public constant sfGreen = {0,255,0,255}
public constant sfBlue = {0,0,255,255}
public constant sfYellow = {255,255,0,1}
public constant sfMagenta = {255,0,255,1}
public constant sfCyan = {0,255,255,1}
public constant sfTransparent = {0,0,0,255}

public constant xsfColor_fromRGB = define_c_func(gfx,"+sfColor_fromRGB",{C_UINT8,C_UINT8,C_UINT8},sfColor)

public function sfColor_fromRGB(atom r,atom g,atom b)
	return c_func(xsfColor_fromRGB,{r,g,b})
end function

public constant xsfColor_fromRGBA = define_c_func(gfx,"+sfColor_fromRGBA",{C_UINT8,C_UINT8,C_UINT8,C_UINT8},sfColor)

public function sfColor_fromRGBA(atom r,atom g,atom b,atom a)
	return c_func(xsfColor_fromRGBA,{r,g,b,a})
end function

public constant xsfColor_fromInteger = define_c_func(gfx,"+sfColor_fromInteger",{C_UINT32},sfColor)

public function sfColor_fromInteger(atom color)
	return c_func(xsfColor_fromInteger,{color})
end function

public constant xsfColor_toInteger = define_c_func(gfx,"+sfColor_toInteger",{sfColor},C_UINT32)

public function sfColor_toInteger(atom color)
	return c_func(xsfColor_toInteger,{color})
end function

public constant xsfColor_add = define_c_func(gfx,"+sfColor_add",{sfColor,sfColor},sfColor)

public function sfColor_add(sequence col,sequence col2)
	return c_func(xsfColor_add,{col,col2})
end function

public constant xsfColor_subtract = define_c_func(gfx,"+sfColor_subtract",{sfColor,sfColor},sfColor)

public function sfColor_subtract(sequence col,sequence col2)
	return c_func(xsfColor_subtract,{col,col2})
end function

public constant xsfColor_modulate = define_c_func(gfx,"+sfColor_modulate",{sfColor,sfColor},sfColor)

public function sfColor_modulate(sequence col,sequence col2)
	return c_func(xsfColor_modulate,{col,col2})
end function

--Rect

public constant sfFloatRect = define_c_struct({
	C_FLOAT, --left
	C_FLOAT, --top
	C_FLOAT, --width
	C_FLOAT --height
})

public constant sfIntRect = define_c_struct({
	C_INT, --left
	C_INT, --top
	C_INT, --width
	C_INT --height
})

public constant xsfFloatRect_contains = define_c_func(gfx,"+sfFloatRect_contains",{C_POINTER,C_FLOAT,C_FLOAT},C_BOOL),
				xsfIntRect_contains = define_c_func(gfx,"+sfIntRect_contains",{C_POINTER,C_INT,C_INT},C_BOOL)
				
public function sfFloatRect_contains(atom rect,atom x,atom y)
	return c_func(xsfFloatRect_contains,{rect,x,y})
end function

public function sfIntRect_contains(atom rect,atom x,atom y)
	return c_func(xsfIntRect_contains,{rect,x,y})
end function

public constant xsfFloatRect_intersects = define_c_func(gfx,"+sfFloatRect_intersects",{C_POINTER,C_POINTER,C_POINTER},C_BOOL),
				xsfIntRect_intersects = define_c_func(gfx,"+sfIntRect_intersects",{C_POINTER,C_POINTER,C_POINTER},C_BOOL)
				
public function sfFloatRect_intersects(atom rect,atom rect2,atom intersection)
	return c_func(xsfFloatRect_intersects,{rect,rect2,intersection})
end function

public function sfIntRect_intersects(atom rect,atom rect2,atom intersection)
	return c_func(xsfIntRect_intersects,{rect,rect2,intersection})
end function

public constant xsfFloatRect_getPosition = define_c_func(gfx,"+sfFloatRect_getPosition",{C_POINTER},sfVector2f),
				xsfIntRect_getPosition = define_c_func(gfx,"+sfIntRect_getPosition",{C_POINTER},sfVector2i)
				
public function sfFloatRect_getPosition(atom r)
	return c_func(xsfFloatRect_getPosition,{r})
end function

public function sfIntRect_getPosition(atom r)
	return c_func(xsfIntRect_getPosition,{r})
end function

public constant xsfFloatRect_getSize = define_c_func(gfx,"+sfFloatRect_getSize",{C_POINTER},sfVector2f),
				xsfIntRect_getSize = define_c_func(gfx,"+sfIntRect_getSize",{C_POINTER},sfVector2i)
				
public function sfFloatRect_getSize(atom r)
	return c_func(xsfFloatRect_getSize,{r})
end function

public function sfIntRect_getSize(atom r)
	return c_func(xsfIntRect_getSize,{r})
end function

--Transform
public constant sfTransform = define_c_struct({
	{C_FLOAT,9} --matrix[9]
})

public constant xsfTransform_Identity = define_c_func(gfx,"+sfTransform_Identity",{},sfTransform)

public function sfTransform_Identity()
	return c_func(xsfTransform_Identity,{})
end function

public constant xsfTransform_fromMatrix = define_c_func(gfx,"+sfTransform_fromMatrix",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT},sfTransform)

public function sfTransform_fromMatrix(atom a00,atom a01,atom a02,atom a10,atom a11,atom a12,atom a20,atom a21,atom a22)
	return c_func(xsfTransform_fromMatrix,{a00,a01,a02,a10,a11,a12,a20,a21,a22})
end function

public constant xsfTransform_getMatrix = define_c_proc(gfx,"+sfTransform_getMatrix",{C_POINTER,C_POINTER})

public procedure sfTransform_getMatrix(atom transform,atom matrix)
	c_proc(xsfTransform_getMatrix,{transform,matrix})
end procedure

public constant xsfTransform_getInverse = define_c_func(gfx,"+sfTransform_getInverse",{C_POINTER},sfTransform)

public function sfTransform_getInverse(atom trans)
	return c_func(xsfTransform_getInverse,{trans})
end function

public constant xsfTransform_transformPoint = define_c_func(gfx,"+sfTransform_transformPoint",{C_POINTER,sfVector2f},sfVector2f)

public function sfTransform_transformPoint(atom trans,sequence point)
	return c_func(xsfTransform_transformPoint,{trans,point})
end function

public constant xsfTransform_transformRect = define_c_func(gfx,"+sfTransform_transformRect",{C_POINTER,sfFloatRect},sfFloatRect)

public function sfTransform_transformRect(atom transform,sequence rect)
	return c_func(xsfTransform_transformRect,{transform,rect})
end function

public constant xsfTransform_combine = define_c_proc(gfx,"+sfTransform_combine",{C_POINTER,C_POINTER})

public procedure sfTransform_combine(atom trans,atom other)
	c_proc(xsfTransform_combine,{trans,other})
end procedure

public constant xsfTransform_translate = define_c_proc(gfx,"+sfTransform_translate",{C_POINTER,C_FLOAT,C_FLOAT})

public procedure sfTransform_translate(atom trans,atom x,atom y)
	c_proc(xsfTransform_translate,{trans,x,y})
end procedure

public constant xsfTransform_rotate = define_c_proc(gfx,"+sfTransform_rotate",{C_POINTER,C_FLOAT})

public procedure sfTransform_rotate(atom trans,atom angle)
	c_proc(xsfTransform_rotate,{trans,angle})
end procedure

public constant xsfTransform_rotateWithCenter = define_c_proc(gfx,"+sfTransform_rotateWithCenter",{C_POINTER,C_FLOAT,C_FLOAT,C_FLOAT})

public procedure sfTransform_rotateWithCenter(atom trans,atom angle,atom x,atom y)
	c_proc(xsfTransform_rotateWithCenter,{trans,angle,x,y})
end procedure

public constant xsfTransform_scale = define_c_proc(gfx,"+sfTransform_scale",{C_POINTER,C_FLOAT,C_FLOAT})

public procedure sfTransform_scale(atom trans,atom x,atom y)
	c_proc(xsfTransform_scale,{trans,x,y})
end procedure

public constant xsfTransform_scaleWithCenter = define_c_proc(gfx,"+sfTransform_scaleWithCenter",{C_POINTER,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT})

public procedure sfTransform_scaleWithCenter(atom trans,atom x,atom y,atom cx,atom cy)
	c_proc(xsfTransform_scaleWithCenter,{trans,x,y,cx,cy})
end procedure

public constant xsfTransform_equal = define_c_func(gfx,"+sfTransform_equal",{C_POINTER,C_POINTER},C_BOOL)

public function sfTransform_equal(atom left,atom right)
	return c_func(xsfTransform_equal,{left,right})
end function

--Circle

public constant xsfCircleShape_create = define_c_func(gfx,"+sfCircleShape_create",{},C_POINTER)

public function sfCircleShape_create()
	return c_func(xsfCircleShape_create,{})
end function

public constant xsfCircleShape_copy = define_c_func(gfx,"+sfCircleShape_copy",{C_POINTER},C_POINTER)

public function sfCircleShape_copy(atom shape)
	return c_func(xsfCircleShape_copy,{shape})
end function

public constant xsfCircleShape_destroy = define_c_proc(gfx,"+sfCircleShape_destroy",{C_POINTER})

public procedure sfCircleShape_destroy(atom shape)
	c_proc(xsfCircleShape_destroy,{shape})
end procedure

public constant xsfCircleShape_setPosition = define_c_proc(gfx,"+sfCircleShape_setPosition",{C_POINTER,sfVector2f})

public procedure sfCircleShape_setPosition(atom shape,sequence pos)
	c_proc(xsfCircleShape_setPosition,{shape,pos})
end procedure

public constant xsfCircleShape_setRotation = define_c_proc(gfx,"+sfCircleShape_setRotation",{C_POINTER,C_FLOAT})

public procedure sfCircleShape_setRotation(atom shape,atom ang)
	c_proc(xsfCircleShape_setRotation,{shape,ang})
end procedure

public constant xsfCircleShape_setScale = define_c_proc(gfx,"+sfCircleShape_setScale",{C_POINTER,sfVector2f})

public procedure sfCircleShape_setScale(atom shape,sequence scale)
	c_proc(xsfCircleShape_setScale,{shape,scale})
end procedure

public constant xsfCircleShape_setOrigin = define_c_proc(gfx,"+sfCircleShape_setOrigin",{C_POINTER,sfVector2f})

public procedure sfCircleShape_setOrigin(atom shape,sequence ori)
	c_proc(xsfCircleShape_setOrigin,{shape,ori})
end procedure

public constant xsfCircleShape_getPosition = define_c_func(gfx,"+sfCircleShape_getPosition",{C_POINTER},sfVector2f)

public function sfCircleShape_getPosition(atom shape)
	return c_func(xsfCircleShape_getPosition,{shape})
end function

public constant xsfCircleShape_getRotation = define_c_func(gfx,"+sfCircleShape_getRotation",{C_POINTER},C_FLOAT)

public function sfCircleShape_getRotation(atom shape)
	return c_func(xsfCircleShape_getRotation,{shape})
end function

public constant xsfCircleShape_getScale = define_c_func(gfx,"+sfCircleShape_getScale",{C_POINTER},sfVector2f)

public function sfCircleShape_getScale(atom shape)
	return c_func(xsfCircleShape_getScale,{shape})
end function

public constant xsfCircleShape_getOrigin = define_c_func(gfx,"+sfCircleShape_getOrigin",{C_POINTER},sfVector2f)

public function sfCircleShape_getOrigin(atom shape)
	return c_func(xsfCircleShape_getOrigin,{shape})
end function

public constant xsfCircleShape_move = define_c_proc(gfx,"+sfCircleShape_move",{C_POINTER,sfVector2f})

public procedure sfCircleShape_move(atom shape,sequence offset)
	c_proc(xsfCircleShape_move,{shape,offset})
end procedure

public constant xsfCircleShape_rotate = define_c_proc(gfx,"+sfCircleShape_rotate",{C_POINTER,C_FLOAT})

public procedure sfCircleShape_rotate(atom shape,atom ang)
	c_proc(xsfCircleShape_rotate,{shape,ang})
end procedure

public constant xsfCircleShape_scale = define_c_proc(gfx,"+sfCircleShape_scale",{C_POINTER,sfVector2f})

public procedure sfCircleShape_scale(atom shape,sequence factors)
	c_proc(xsfCircleShape_scale,{shape,factors})
end procedure

public constant xsfCircleShape_getTransform = define_c_func(gfx,"+sfCircleShape_getTransform",{C_POINTER},sfTransform)

public function sfCircleShape_getTransform(atom shape)
	return c_func(xsfCircleShape_getTransform,{shape})
end function

public constant xsfCircleShape_getInverseTransform = define_c_func(gfx,"+sfCircleShape_getInverseTransform",{C_POINTER},sfTransform)

public function sfCircleShape_getInverseTransform(atom shape)
	return c_func(xsfCircleShape_getInverseTransform,{shape})
end function

public constant xsfCircleShape_setTexture = define_c_proc(gfx,"+sfCircleShape_setTexture",{C_POINTER,C_POINTER,C_BOOL})

public procedure sfCircleShape_setTexture(atom shape,atom tex,atom reset)
	c_proc(xsfCircleShape_setTexture,{shape,tex,reset})
end procedure

public constant xsfCircleShape_setTextureRect = define_c_proc(gfx,"+sfCircleShape_setTextureRect",{C_POINTER,sfIntRect})

public procedure sfCircleShape_setTextureRect(atom shape,sequence rect)
	c_proc(xsfCircleShape_setTextureRect,{shape,rect})
end procedure

public constant xsfCircleShape_setFillColor = define_c_proc(gfx,"+sfCircleShape_setFillColor",{C_POINTER,sfColor})

public procedure sfCircleShape_setFillColor(atom shape,sequence col)
	c_proc(xsfCircleShape_setFillColor,{shape,col})
end procedure

public constant xsfCircleShape_setOutlineColor = define_c_proc(gfx,"+sfCircleShape_setOutlineColor",{C_POINTER,sfColor})

public procedure sfCircleShape_setOutlineColor(atom shape,sequence col)
	c_proc(xsfCircleShape_setOutlineColor,{shape,col})
end procedure

public constant xsfCircleShape_setOutlineThickness = define_c_proc(gfx,"+sfCircleShape_setOutlineThickness",{C_POINTER,C_FLOAT})

public procedure sfCircleShape_setOutlineThickness(atom shape,atom thick)
	c_proc(xsfCircleShape_setOutlineThickness,{shape,thick})
end procedure

public constant xsfCircleShape_getTexture = define_c_func(gfx,"+sfCircleShape_getTexture",{C_POINTER},C_POINTER)

public function sfCircleShape_getTexture(atom shape)
	return c_func(xsfCircleShape_getTexture,{shape})
end function

public constant xsfCircleShape_getTextureRect = define_c_func(gfx,"+sfCircleShape_getTextureRect",{C_POINTER},sfIntRect)

public function sfCircleShape_getTextureRect(atom shape)
	return c_func(xsfCircleShape_getTextureRect,{shape})
end function

public constant xsfCircleShape_getFillColor = define_c_func(gfx,"+sfCircleShape_getFillColor",{C_POINTER},sfColor)

public function sfCircleShape_getFillColor(atom shape)
	return c_func(xsfCircleShape_getFillColor,{shape})
end function

public constant xsfCircleShape_getOutlineColor = define_c_func(gfx,"+sfCircleShape_getOutlineColor",{C_POINTER},sfColor)

public function sfCircleShape_getOutlineColor(atom shape)
	return c_func(xsfCircleShape_getOutlineColor,{shape})
end function

public constant xsfCircleShape_getOutlineThickness = define_c_func(gfx,"+sfCircleShape_getOutlineThickness",{C_POINTER},C_FLOAT)

public function sfCircleShape_getOutlineThickness(atom shape)
	return c_func(xsfCircleShape_getOutlineThickness,{shape})
end function

public constant xsfCircleShape_getPointCount = define_c_func(gfx,"+sfCircleShape_getPointCount",{C_POINTER},C_SIZE_T)

public function sfCircleShape_getPointCount(atom shape)
	return c_func(xsfCircleShape_getPointCount,{shape})
end function

public constant xsfCircleShape_getPoint = define_c_func(gfx,"+sfCircleShape_getPoint",{C_POINTER,C_SIZE_T},sfVector2f)

public function sfCircleShape_getPoint(atom shape,atom index)
	return c_func(xsfCircleShape_getPoint,{shape,index})
end function

public constant xsfCircleShape_setRadius = define_c_proc(gfx,"+sfCircleShape_setRadius",{C_POINTER,C_FLOAT})

public procedure sfCircleShape_setRadius(atom shape,atom rad)
	c_proc(xsfCircleShape_setRadius,{shape,rad})
end procedure

public constant xsfCircleShape_getRadius = define_c_func(gfx,"+sfCircleShape_getRadius",{C_POINTER},C_FLOAT)

public function sfCircleShape_getRadius(atom shape)
	return c_func(xsfCircleShape_getRadius,{shape})
end function

public constant xsfCircleShape_setPointCount = define_c_proc(gfx,"+sfCircleShape_setPointCount",{C_POINTER,C_SIZE_T})

public procedure sfCircleShape_setPointCount(atom shape,atom count)
	c_proc(xsfCircleShape_setPointCount,{shape,count})
end procedure

public constant xsfCircleShape_getLocalBounds = define_c_func(gfx,"+sfCircleShape_getLocalBounds",{C_POINTER},sfFloatRect)

public function sfCircleShape_getLocalBounds(atom shape)
	return c_func(xsfCircleShape_getLocalBounds,{shape})
end function

public constant xsfCircleShape_getGlobalBounds = define_c_func(gfx,"+sfCircleShape_getGlobalBounds",{C_POINTER},sfFloatRect)

public function sfCircleShape_getGlobalBounds(atom shape)
	return c_func(xsfCircleShape_getGlobalBounds,{shape})
end function

--ConvexShape

public constant xsfConvexShape_create = define_c_func(gfx,"+sfConvexShape_create",{},C_POINTER)

public function sfConvexShape_create()
	return c_func(xsfConvexShape_create,{})
end function

public constant xsfConvexShape_copy = define_c_func(gfx,"+sfConvexShape_copy",{C_POINTER},C_POINTER)

public function sfConvexShape_copy(atom shape)
	return c_func(xsfConvexShape_copy,{shape})
end function

public constant xsfConvexShape_destroy = define_c_proc(gfx,"+sfConvexShape_destroy",{C_POINTER})

public procedure sfConvexShape_destroy(atom shape)
	c_proc(xsfConvexShape_destroy,{shape})
end procedure

public constant xsfConvexShape_setPosition = define_c_proc(gfx,"+sfConvexShape_setPosition",{C_POINTER,sfVector2f})

public procedure sfConvexShape_setPosition(atom shape,sequence pos)
	c_proc(xsfConvexShape_setPosition,{shape,pos})
end procedure

public constant xsfConvexShape_setRotation = define_c_proc(gfx,"+sfConvexShape_setRotation",{C_POINTER,C_FLOAT})

public procedure sfConvexShape_setRotation(atom shape,atom ang)
	c_proc(xsfConvexShape_setRotation,{shape,ang})
end procedure

public constant xsfConvexShape_setScale = define_c_proc(gfx,"+sfConvexShape_setScale",{C_POINTER,sfVector2f})

public procedure sfConvexShape_setScale(atom shape,sequence scale)
	c_proc(xsfConvexShape_setScale,{shape,scale})
end procedure

public constant xsfConvexShape_setOrigin = define_c_proc(gfx,"+sfConvexShape_setOrigin",{C_POINTER,sfVector2f})

public procedure sfConvexShape_setOrigin(atom shape,sequence ori)
	c_proc(xsfConvexShape_setOrigin,{shape,ori})
end procedure

public constant xsfConvexShape_getPosition = define_c_func(gfx,"+sfConvexShape_getPosition",{C_POINTER},sfVector2f)

public function sfConvexShape_getPosition(atom shape)
	return c_func(xsfConvexShape_getPosition,{shape})
end function

public constant xsfConvexShape_getRotation = define_c_func(gfx,"+sfConvexShape_getRotation",{C_POINTER},C_FLOAT)

public function sfConvexShape_getRotation(atom shape)
	return c_func(xsfConvexShape_getRotation,{shape})
end function

public constant xsfConvexShape_getScale = define_c_func(gfx,"+sfConvexShape_getScale",{C_POINTER},sfVector2f)

public function sfConvexShape_getScale(atom shape)
	return c_func(xsfConvexShape_getScale,{shape})
end function

public constant xsfConvexShape_getOrigin = define_c_func(gfx,"+sfConvexShape_getOrigin",{C_POINTER},sfVector2f)

public function sfConvexShape_getOrigin(atom shape)
	return c_func(xsfConvexShape_getOrigin,{shape})
end function

public constant xsfConvexShape_move = define_c_proc(gfx,"+sfConvexShape_move",{C_POINTER,sfVector2f})

public procedure sfConvexShape_move(atom shape,sequence off)
	c_proc(xsfConvexShape_move,{shape,off})
end procedure

public constant xsfConvexShape_rotate = define_c_proc(gfx,"+sfConvexShape_rotate",{C_POINTER,C_FLOAT})

public procedure sfConvexShape_rotate(atom shape,atom ang)
	c_proc(xsfConvexShape_rotate,{shape,ang})
end procedure

public constant xsfConvexShape_scale = define_c_proc(gfx,"+sfConvexShape_scale",{C_POINTER,sfVector2f})

public procedure sfConvexShape_scale(atom shape,sequence factor)
	c_proc(xsfConvexShape_scale,{shape,factor})
end procedure

public constant xsfConvexShape_getTransform = define_c_func(gfx,"+sfConvexShape_getTransform",{C_POINTER},sfTransform)

public function sfConvexShape_getTransform(atom shape)
	return c_func(xsfConvexShape_getTransform,{shape})
end function

public constant xsfConvexShape_getInverseTransform = define_c_func(gfx,"+sfConvexShape_getInverseTransform",{C_POINTER},sfTransform)

public function sfConvexShape_getInverseTransform(atom shape)
	return c_func(xsfConvexShape_getInverseTransform,{shape})
end function

public constant xsfConvexShape_setTexture = define_c_proc(gfx,"+sfConvexShape_setTexture",{C_POINTER,C_POINTER,C_BOOL})

public procedure sfConvexShape_setTexture(atom shape,atom tex,atom reset)
	c_proc(xsfConvexShape_setTexture,{shape,tex,reset})
end procedure

public constant xsfConvexShape_setTextureRect = define_c_proc(gfx,"+sfConvexShape_setTextureRect",{C_POINTER,sfIntRect})

public procedure sfConvexShape_setTextureRect(atom shape,sequence rect)
	c_proc(xsfConvexShape_setTextureRect,{shape,rect})
end procedure

public constant xsfConvexShape_setFillColor = define_c_proc(gfx,"+sfConvexShape_setFillColor",{C_POINTER,sfColor})

public procedure sfConvexShape_setFillColor(atom shape,sequence col)
	c_proc(xsfConvexShape_setFillColor,{shape,col})
end procedure

public constant xsfConvexShape_setOutlineColor = define_c_proc(gfx,"+sfConvexShape_setOutlineColor",{C_POINTER,sfColor})

public procedure sfConvexShape_setOutlineColor(atom shape,sequence col)
	c_proc(xsfConvexShape_setOutlineColor,{shape,col})
end procedure

public constant xsfConvexShape_setOutlineThickness = define_c_proc(gfx,"+sfConvexShape_setOutlineThickness",{C_POINTER,C_FLOAT})

public procedure sfConvexShape_setOutlineThickness(atom shape,atom thick)
	c_proc(xsfConvexShape_setOutlineThickness,{shape,thick})
end procedure

public constant xsfConvexShape_getTexture = define_c_func(gfx,"+sfConvexShape_getTexture",{C_POINTER},C_POINTER)

public function sfConvexShape_getTexture(atom shape)
	return c_func(xsfConvexShape_getTexture,{shape})
end function

public constant xsfConvexShape_getTextureRect = define_c_func(gfx,"+sfConvexShape_getTextureRect",{C_POINTER},sfIntRect)

public function sfConvexShape_getTextureRect(atom shape)
	return c_func(xsfConvexShape_getTextureRect,{shape})
end function

public constant xsfConvexShape_getFillColor = define_c_func(gfx,"+sfConvexShape_getFillColor",{C_POINTER},sfColor)

public function sfConvexShape_getFillColor(atom shape)
	return c_func(xsfConvexShape_getFillColor,{shape})
end function

public constant xsfConvexShape_getOutlineColor = define_c_func(gfx,"+sfConvexShape_getOutlineColor",{C_POINTER},sfColor)

public function sfConvexShape_getOutlineColor(atom shape)
	return c_func(xsfConvexShape_getOutlineColor,{shape})
end function

public constant xsfConvexShape_getOutlineThickness = define_c_func(gfx,"+sfConvexShape_getOutlineThickness",{C_POINTER},C_FLOAT)

public function sfConvexShape_getOutlineThickness(atom shape)
	return c_func(xsfConvexShape_getOutlineThickness,{shape})
end function

public constant xsfConvexShape_getPointCount = define_c_func(gfx,"+sfConvexShape_getPointCount",{C_POINTER},C_SIZE_T)

public function sfConvexShape_getPointCount(atom shape)
	return c_func(xsfConvexShape_getPointCount,{shape})
end function

public constant xsfConvexShape_getPoint = define_c_func(gfx,"+sfConvexShape_getPoint",{C_POINTER,C_SIZE_T},sfVector2f)

public function sfConvexShape_getPoint(atom shape,atom index)
	return c_func(xsfConvexShape_getPoint,{shape,index})
end function

public constant xsfConvexShape_setPointCount = define_c_proc(gfx,"+sfConvexShape_setPointCount",{C_POINTER,C_SIZE_T})

public procedure sfConvexShape_setPointCount(atom shape,atom count)
	c_proc(xsfConvexShape_setPointCount,{shape,count})
end procedure

public constant xsfConvexShape_setPoint = define_c_proc(gfx,"+sfConvexShape_setPoint",{C_POINTER,C_SIZE_T,sfVector2f})

public procedure sfConvexShape_setPoint(atom shape,atom index,sequence pt)
	c_proc(xsfConvexShape_setPoint,{shape,index,pt})
end procedure

public constant xsfConvexShape_getLocalBounds = define_c_func(gfx,"+sfConvexShape_getLocalBounds",{C_POINTER},sfFloatRect)

public function sfConvexShape_getLocalBounds(atom shape)
	return c_func(xsfConvexShape_getLocalBounds,{shape})
end function

public constant xsfConvexShape_getGlobalBounds = define_c_func(gfx,"+sfConvexShape_getGlobalBounds",{C_POINTER},sfFloatRect)

public function sfConvexShape_getGlobalBounds(atom shape)
	return c_func(xsfConvexShape_getGlobalBounds,{shape})
end function

--Glyph

public constant sfGlyph = define_c_struct({
	C_FLOAT, --advance
	sfFloatRect, --bounds
	sfIntRect --textureRect
})

--Font Info
public constant sfFontInfo = define_c_struct({
	C_STRING --family
})

--Font

public constant xsfFont_createFromFile = define_c_func(gfx,"+sfFont_createFromFile",{C_STRING},C_POINTER)

public function sfFont_createFromFile(sequence file)
	return c_func(xsfFont_createFromFile,{file})
end function

public constant xsfFont_createFromMemory = define_c_func(gfx,"+sfFont_createFromMemory",{C_POINTER,C_SIZE_T},C_POINTER)

public function sfFont_createFromMemory(atom data,atom size)
	return c_func(xsfFont_createFromMemory,{data,size})
end function

public constant xsfFont_createFromStream = define_c_func(gfx,"+sfFont_createFromStream",{C_POINTER},C_POINTER)

public function sfFont_createFromStream(atom stream)
	return c_func(xsfFont_createFromStream,{stream})
end function

public constant xsfFont_copy = define_c_func(gfx,"+sfFont_copy",{C_POINTER},C_POINTER)

public function sfFont_copy(atom font)
	return c_func(xsfFont_copy,{font})
end function

public constant xsfFont_destroy = define_c_proc(gfx,"+sfFont_destroy",{C_POINTER})

public procedure sfFont_destroy(atom font)
	c_proc(xsfFont_destroy,{font})
end procedure

public constant xsfFont_getGlyph = define_c_func(gfx,"+sfFont_getGlyph",{C_POINTER,C_UINT32,C_UINT,C_BOOL,C_FLOAT},sfGlyph)

public function sfFont_getGlyph(atom font,atom cpt,atom size,atom bold,atom thick)
	return c_func(xsfFont_getGlyph,{font,cpt,size,bold,thick})
end function

public constant xsfFont_getKerning = define_c_func(gfx,"+sfFont_getKerning",{C_POINTER,C_UINT32,C_UINT32,C_UINT},C_FLOAT)

public function sfFont_getKerning(atom font,atom first,atom second,atom size)
	return c_func(xsfFont_getKerning,{font,first,second,size})
end function

public constant xsfFont_getBoldKerning = define_c_func(gfx,"+sfFont_getBoldKerning",{C_POINTER,C_UINT32,C_UINT32,C_UINT},C_FLOAT)

public function sfFont_getBoldKerning(atom font,atom f,atom s,atom size)
	return c_func(xsfFont_getBoldKerning,{font,f,s,size})
end function

public constant xsfFont_getLineSpacing = define_c_func(gfx,"+sfFont_getLineSpacing",{C_POINTER,C_UINT},C_FLOAT)

public function sfFont_getLineSpacing(atom font,atom size)
	return c_func(xsfFont_getLineSpacing,{font,size})
end function

public constant xsfFont_getUnderlinePosition = define_c_func(gfx,"+sfFont_getUnderlinePosition",{C_POINTER,C_UINT},C_FLOAT)

public function sfFont_getUnderlinePosition(atom font,atom size)
	return c_func(xsfFont_getUnderlinePosition,{font,size})
end function

public constant xsfFont_getUnderlineThickness = define_c_func(gfx,"+sfFont_getUnderlineThickness",{C_POINTER,C_UINT},C_FLOAT)

public function sfFont_getUnderlineThickness(atom font,atom size)
	return c_func(xsfFont_getUnderlineThickness,{font,size})
end function

public constant xsfFont_getTexture = define_c_func(gfx,"+sfFont_getTexture",{C_POINTER,C_UINT},C_POINTER)

public function sfFont_getTexture(atom font,atom size)
	return c_func(xsfFont_getTexture,{font,size})
end function

public constant xsfFont_setSmooth = define_c_proc(gfx,"+sfFont_setSmooth",{C_POINTER,C_BOOL})

public procedure sfFont_setSmooth(atom font,atom smooth)
	c_proc(xsfFont_setSmooth,{font,smooth})
end procedure

public constant xsfFont_isSmooth = define_c_func(gfx,"+sfFont_isSmooth",{C_POINTER},C_BOOL)

public function sfFont_isSmooth(atom font)
	return c_func(xsfFont_isSmooth,{font})
end function

public constant xsfFont_getInfo = define_c_func(gfx,"+sfFont_getInfo",{C_POINTER},sfFontInfo)

public function sfFont_getInfo(atom font)
	return c_func(xsfFont_getInfo,{font})
end function

--Image

public constant xsfImage_create = define_c_func(gfx,"+sfImage_create",{C_UINT,C_UINT},C_POINTER)

public function sfImage_create(atom w,atom h)
	return c_func(xsfImage_create,{w,h})
end function

public constant xsfImage_createFromColor = define_c_func(gfx,"+sfImage_createFromColor",{C_UINT,C_UINT,sfColor},C_POINTER)

public function sfImage_createFromColor(atom w,atom h,sequence col)
	return c_func(xsfImage_createFromColor,{w,h,col})
end function

public constant xsfImage_createFromPixels = define_c_func(gfx,"+sfImage_createFromPixels",{C_UINT,C_UINT,C_POINTER},C_POINTER)

public function sfImage_createFromPixels(atom w,atom h,atom pix)
	return c_func(xsfImage_createFromPixels,{w,h,pix})
end function

public constant xsfImage_createFromFile = define_c_func(gfx,"+sfImage_createFromFile",{C_STRING},C_POINTER)

public function sfImage_createFromFile(sequence file)
	return c_func(xsfImage_createFromFile,{file})
end function

public constant xsfImage_createFromMemory = define_c_func(gfx,"+sfImage_createFromMemory",{C_POINTER,C_SIZE_T},C_POINTER)

public function sfImage_createFromMemory(atom data,atom size)
	return c_func(xsfImage_createFromMemory,{data,size})
end function

public constant xsfImage_createFromStream = define_c_func(gfx,"+sfImage_createFromStream",{C_POINTER},C_POINTER)

public function sfImage_createFromStream(atom stream)
	return c_func(xsfImage_createFromStream,{stream})
end function

public constant xsfImage_copy = define_c_func(gfx,"+sfImage_copy",{C_POINTER},C_POINTER)

public function sfImage_copy(atom img)
	return c_func(xsfImage_copy,{img})
end function

public constant xsfImage_destroy = define_c_proc(gfx,"+sfImage_destroy",{C_POINTER})

public procedure sfImage_destroy(atom img)
	c_proc(xsfImage_destroy,{img})
end procedure

public constant xsfImage_saveToFile = define_c_func(gfx,"+sfImage_saveToFile",{C_POINTER,C_STRING},C_BOOL)

public function sfImage_saveToFile(atom img,sequence file)
	return c_func(xsfImage_saveToFile,{img,file})
end function

public constant xsfImage_saveToMemory = define_c_func(gfx,"+sfImage_saveToMemory",{C_POINTER,C_POINTER,C_STRING},C_BOOL)

public function sfImage_saveToMemory(atom img,atom op,sequence format)
	return c_func(xsfImage_saveToMemory,{img,op,format})
end function

public constant xsfImage_getSize = define_c_func(gfx,"+sfImage_getSize",{C_POINTER},sfVector2u)

public function sfImage_getSize(atom img)
	return c_func(xsfImage_getSize,{img})
end function

public constant xsfImage_createMaskFromColor = define_c_proc(gfx,"+sfImage_createMaskFromColor",{C_POINTER,sfColor,C_UINT8})

public procedure sfImage_createMaskFromColor(atom img,sequence col,atom al)
	c_proc(xsfImage_createMaskFromColor,{img,col,al})
end procedure

public constant xsfImage_copyImage = define_c_proc(gfx,"+sfImage_copyImage",{C_POINTER,C_POINTER,C_UINT,C_UINT,sfIntRect,C_BOOL})

public procedure sfImage_copyImage(atom img,atom src,atom x,atom y,sequence srcRect,atom app)
	c_proc(xsfImage_copyImage,{img,src,x,y,srcRect,app})
end procedure

public constant xsfImage_setPixel = define_c_proc(gfx,"+sfImage_setPixel",{C_POINTER,C_UINT,C_UINT,sfColor})

public procedure sfImage_setPixel(atom img,atom x,atom y,sequence col)
	c_proc(xsfImage_setPixel,{img,x,y,col})
end procedure

public constant xsfImage_getPixel = define_c_func(gfx,"+sfImage_getPixel",{C_POINTER,C_UINT,C_UINT},sfColor)

public function sfImage_getPixel(atom img,atom x,atom y)
	return c_func(xsfImage_getPixel,{img,x,y})
end function

public constant xsfImage_getPixelsPtr = define_c_func(gfx,"+sfImage_getPixelsPtr",{C_POINTER},C_POINTER)

public function sfImage_getPixelsPtr(atom img)
	return c_func(xsfImage_getPixelsPtr,{img})
end function

public constant xsfImage_flipHorizontally = define_c_proc(gfx,"+sfImage_flipHorizontally",{C_POINTER})

public procedure sfImage_flipHorizontally(atom img)
	c_proc(xsfImage_flipHorizontally,{img})
end procedure

public constant xsfImage_flipVertically = define_c_proc(gfx,"+sfImage_flipVertically",{C_POINTER})

public procedure sfImage_flipVertically(atom img)
	c_proc(xsfImage_flipVertically,{img})
end procedure

--RectangleShape

public constant xsfRectangleShape_create = define_c_func(gfx,"+sfRectangleShape_create",{},C_POINTER)

public function sfRectangleShape_create()
	return c_func(xsfRectangleShape_create,{})
end function

public constant xsfRectangleShape_copy = define_c_func(gfx,"+sfRectangleShape_copy",{C_POINTER},C_POINTER)

public function sfRectangleShape_copy(atom shape)
	return c_func(xsfRectangleShape_copy,{shape})
end function

public constant xsfRectangleShape_destroy = define_c_proc(gfx,"+sfRectangleShape_destroy",{C_POINTER})

public procedure sfRectangleShape_destroy(atom shape)
	c_proc(xsfRectangleShape_destroy,{shape})
end procedure

public constant xsfRectangleShape_setPosition = define_c_proc(gfx,"+sfRectangleShape_setPosition",{C_POINTER,sfVector2f})

public procedure sfRectangleShape_setPosition(atom shape,sequence pos)
	c_proc(xsfRectangleShape_setPosition,{shape,pos})
end procedure

public constant xsfRectangleShape_setRotation = define_c_proc(gfx,"+sfRectangleShape_setRotation",{C_POINTER,C_FLOAT})

public procedure sfRectangleShape_setRotation(atom shape,atom ang)
	c_proc(xsfRectangleShape_setRotation,{shape,ang})
end procedure

public constant xsfRectangleShape_setScale = define_c_proc(gfx,"+sfRectangleShape_setScale",{C_POINTER,sfVector2f})

public procedure sfRectangleShape_setScale(atom shape,sequence scale)
	c_proc(xsfRectangleShape_setScale,{shape,scale})
end procedure

public constant xsfRectangleShape_setOrigin = define_c_proc(gfx,"+sfRectangleShape_setOrigin",{C_POINTER,sfVector2f})

public procedure sfRectangleShape_setOrigin(atom shape,sequence ori)
	c_proc(xsfRectangleShape_setOrigin,{shape,ori})
end procedure

public constant xsfRectangleShape_getPosition = define_c_func(gfx,"+sfRectangleShape_getPosition",{C_POINTER},sfVector2f)

public function sfRectangleShape_getPosition(atom shape)
	return c_func(xsfRectangleShape_getPosition,{shape})
end function

public constant xsfRectangleShape_getRotation = define_c_func(gfx,"+sfRectangleShape_getRotation",{C_POINTER},C_FLOAT)

public function sfRectangleShape_getRotation(atom shape)
	return c_func(xsfRectangleShape_getRotation,{shape})
end function

public constant xsfRectangleShape_getScale = define_c_func(gfx,"+sfRectangleShape_getScale",{C_POINTER},sfVector2f)

public function sfRectangleShape_getScale(atom shape)
	return c_func(xsfRectangleShape_getScale,{shape})
end function

public constant xsfRectangleShape_getOrigin = define_c_func(gfx,"+sfRectangleShape_getOrigin",{C_POINTER},sfVector2f)

public function sfRectangleShape_getOrigin(atom shape)
	return c_func(xsfRectangleShape_getOrigin,{shape})
end function

public constant xsfRectangleShape_move = define_c_proc(gfx,"+sfRectangleShape_move",{C_POINTER,sfVector2f})

public procedure sfRectangleShape_move(atom shape,sequence off)
	c_proc(xsfRectangleShape_move,{shape,off})
end procedure

public constant xsfRectangleShape_rotate = define_c_proc(gfx,"+sfRectangleShape_rotate",{C_POINTER,C_FLOAT})

public procedure sfRectangleShape_rotate(atom shape,atom ang)
	c_proc(xsfRectangleShape_rotate,{shape,ang})
end procedure

public constant xsfRectangleShape_scale = define_c_proc(gfx,"+sfRectangleShape_scale",{C_POINTER,sfVector2f})

public procedure sfRectangleShape_scale(atom shape,sequence fac)
	c_proc(xsfRectangleShape_scale,{shape,fac})
end procedure

public constant xsfRectangleShape_getTransform = define_c_func(gfx,"+sfRectangleShape_getTransform",{C_POINTER},sfTransform)

public function sfRectangleShape_getTransform(atom shape)
	return c_func(xsfRectangleShape_getTransform,{shape})
end function

public constant xsfRectangleShape_getInverseTransform = define_c_func(gfx,"+sfRectangleShape_getInverseTransform",{C_POINTER},sfTransform)

public function sfRectangleShape_getInverseTransform(atom shape)
	return c_func(xsfRectangleShape_getInverseTransform,{shape})
end function

public constant xsfRectangleShape_setTexture = define_c_proc(gfx,"+sfRectangleShape_setTexture",{C_POINTER,C_POINTER,C_BOOL})

public procedure sfRectangleShape_setTexture(atom shape,atom tex,atom reset)
	c_proc(xsfRectangleShape_setTexture,{shape,tex,reset})
end procedure

public constant xsfRectangleShape_setTextureRect = define_c_proc(gfx,"+sfRectangleShape_setTextureRect",{C_POINTER,sfIntRect})

public procedure sfRectangleShape_setTextureRect(atom shape,sequence rect)
	c_proc(xsfRectangleShape_setTextureRect,{shape,rect})
end procedure

public constant xsfRectangleShape_setFillColor = define_c_proc(gfx,"+sfRectangleShape_setFillColor",{C_POINTER,sfColor})

public procedure sfRectangleShape_setFillColor(atom shape,sequence col)
	c_proc(xsfRectangleShape_setFillColor,{shape,col})
end procedure

public constant xsfRectangleShape_setOutlineColor = define_c_proc(gfx,"+sfRectangleShape_setOutlineColor",{C_POINTER,sfColor})

public procedure sfRectangleShape_setOutlineColor(atom shape,sequence col)
	c_proc(xsfRectangleShape_setOutlineColor,{shape,col})
end procedure

public constant xsfRectangleShape_setOutlineThickness = define_c_proc(gfx,"+sfRectangleShape_setOutlineThickness",{C_POINTER,C_FLOAT})

public procedure sfRectangleShape_setOutlineThickness(atom shape,atom thick)
	c_proc(xsfRectangleShape_setOutlineThickness,{shape,thick})
end procedure

public constant xsfRectangleShape_getTexture = define_c_func(gfx,"+sfRectangleShape_getTexture",{C_POINTER},C_POINTER)

public function sfRectangleShape_getTexture(atom shape)
	return c_func(xsfRectangleShape_getTexture,{shape})
end function

public constant xsfRectangleShape_getTextureRect = define_c_func(gfx,"+sfRectangleShape_getTextureRect",{C_POINTER},sfIntRect)

public function sfRectangleShape_getTextureRect(atom shape)
	return c_func(xsfRectangleShape_getTextureRect,{shape})
end function

public constant xsfRectangleShape_getFillColor = define_c_func(gfx,"+sfRectangleShape_getFillColor",{C_POINTER},sfColor)

public function sfRectangleShape_getFillColor(atom shape)
	return c_func(xsfRectangleShape_getFillColor,{shape})
end function

public constant xsfRectangleShape_getOutlineColor = define_c_func(gfx,"+sfRectangleShape_getOutlineColor",{C_POINTER},sfColor)

public function sfRectangleShape_getOutlineColor(atom shape)
	return c_func(xsfRectangleShape_getOutlineColor,{shape})
end function

public constant xsfRectangleShape_getOutlineThickness = define_c_func(gfx,"sfRectangleShape_getOutlineThickness",{C_POINTER},C_FLOAT)

public function sfRectangleShape_getOutlineThickness(atom shape)
	return c_func(xsfRectangleShape_getOutlineThickness,{shape})
end function

public constant xsfRectangleShape_getPointCount = define_c_func(gfx,"+sfRectangleShape_getPointCount",{C_POINTER},C_SIZE_T)

public function sfRectangleShape_getPointCount(atom shape)
	return c_func(xsfRectangleShape_getPointCount,{shape})
end function

public constant xsfRectangleShape_getPoint = define_c_func(gfx,"+sfRectangleShape_getPoint",{C_POINTER,C_SIZE_T},sfVector2f)

public function sfRectangleShape_getPoint(atom shape,atom idx)
	return c_func(xsfRectangleShape_getPoint,{shape,idx})
end function

public constant xsfRectangleShape_setSize = define_c_proc(gfx,"+sfRectangleShape_setSize",{C_POINTER,sfVector2f})

public procedure sfRectangleShape_setSize(atom shape,sequence size)
	c_proc(xsfRectangleShape_setSize,{shape,size})
end procedure

public constant xsfRectangleShape_getSize = define_c_func(gfx,"+sfRectangleShape_getSize",{C_POINTER},sfVector2f)

public function sfRectangleShape_getSize(atom shape)
	return c_func(xsfRectangleShape_getSize,{shape})
end function

public constant xsfRectangleShape_getLocalBounds = define_c_func(gfx,"+sfRectangleShape_getLocalBounds",{C_POINTER},sfFloatRect)

public function sfRectangleShape_getLocalBounds(atom shape)
	return c_func(xsfRectangleShape_getLocalBounds,{shape})
end function

public constant xsfRectangleShape_getGlobalBounds = define_c_func(gfx,"+sfRectangleShape_getGlobalBounds",{C_POINTER},sfFloatRect)

public function sfRectangleShape_getGlobalBounds(atom shape)
	return c_func(xsfRectangleShape_getGlobalBounds,{shape})
end function

--RenderWindow

public constant xsfRenderWindow_create = define_c_func(gfx,"+sfRenderWindow_create",{sfVideoMode,C_STRING,C_UINT32,C_POINTER},C_POINTER)

public function sfRenderWindow_create(sequence mode,sequence title,sfWindowStyle style,atom settings)
	return c_func(xsfRenderWindow_create,{mode,title,style,settings})
end function

public constant xsfRenderWindow_createUnicode = define_c_func(gfx,"+sfRenderWindow_createUnicode",{sfVideoMode,C_POINTER,C_UINT32,C_POINTER},C_POINTER)

public function sfRenderWindow_createUnicode(sequence mode,atom title,atom style,atom settings)
	return c_func(xsfRenderWindow_createUnicode,{mode,title,style,settings})
end function

public constant xsfRenderWindow_createFromHandle = define_c_func(gfx,"+sfRenderWindow_createFromHandle",{C_POINTER,C_POINTER},C_POINTER)

public function sfRenderWindow_createFromHandle(atom handle,atom settings)
	return c_func(xsfRenderWindow_createFromHandle,{handle,settings})
end function

public constant xsfRenderWindow_destroy = define_c_proc(gfx,"+sfRenderWindow_destroy",{C_POINTER})

public procedure sfRenderWindow_destroy(atom rw)
	c_proc(xsfRenderWindow_destroy,{rw})
end procedure

public constant xsfRenderWindow_close = define_c_proc(gfx,"+sfRenderWindow_close",{C_POINTER})

public procedure sfRenderWindow_close(atom rw)
	c_proc(xsfRenderWindow_close,{rw})
end procedure

public constant xsfRenderWindow_isOpen = define_c_func(gfx,"+sfRenderWindow_isOpen",{C_POINTER},C_BOOL)

public function sfRenderWindow_isOpen(atom rw)
	return c_func(xsfRenderWindow_isOpen,{rw})
end function

public constant xsfRenderWindow_getSettings = define_c_func(gfx,"+sfRenderWindow_getSettings",{C_POINTER},C_POINTER)

public function sfRenderWindow_getSettings(atom rw)
	return c_func(xsfRenderWindow_getSettings,{rw})
end function

public constant xsfRenderWindow_pollEvent = define_c_func(gfx,"+sfRenderWindow_pollEvent",{C_POINTER,C_POINTER},C_BOOL)

public function sfRenderWindow_pollEvent(atom rw,atom evt)
	return c_func(xsfRenderWindow_pollEvent,{rw,evt})
end function

public constant xsfRenderWindow_waitEvent = define_c_func(gfx,"+sfRenderWindow_waitEvent",{C_POINTER,C_POINTER},C_BOOL)

public function sfRenderWindow_waitEvent(atom rw,atom evt)
	return c_func(xsfRenderWindow_waitEvent,{rw,evt})
end function

public constant xsfRenderWindow_getPosition = define_c_func(gfx,"+sfRenderWindow_getPosition",{C_POINTER},sfVector2i)

public function sfRenderWindow_getPosition(atom rw)
	return c_func(xsfRenderWindow_getPosition,{rw})
end function

public constant xsfRenderWindow_setPosition = define_c_proc(gfx,"+sfRenderWindow_setPosition",{C_POINTER,sfVector2i})

public procedure sfRenderWindow_setPosition(atom rw,sequence pos)
	c_proc(xsfRenderWindow_setPosition,{rw,pos})
end procedure

public constant xsfRenderWindow_getSize = define_c_func(gfx,"+sfRenderWindow_getSize",{C_POINTER},sfVector2u)

public function sfRenderWindow_getSize(atom rw)
	return c_func(xsfRenderWindow_getSize,{rw})
end function

public constant xsfRenderWindow_isSrgb = define_c_func(gfx,"+sfRenderWindow_isSrgb",{C_POINTER},C_BOOL)

public function sfRenderWindow_isSrgb(atom rw)
	return c_func(xsfRenderWindow_isSrgb,{rw})
end function

public constant xsfRenderWindow_setSize = define_c_proc(gfx,"+sfRenderWindow_setSize",{C_POINTER,sfVector2u})

public procedure sfRenderWindow_setSize(atom rw,sequence size)
	c_proc(xsfRenderWindow_setSize,{rw,size})
end procedure

public constant xsfRenderWindow_setTitle = define_c_proc(gfx,"+sfRenderWindow_setTitle",{C_POINTER,C_STRING})

public procedure sfRenderWindow_setTitle(atom rw,sequence title)
	c_proc(xsfRenderWindow_setTitle,{rw,title})
end procedure

public constant xsfRenderWindow_setUnicodeTitle = define_c_proc(gfx,"+sfRenderWindow_setUnicodeTitle",{C_POINTER,C_POINTER})

public procedure sfRenderWindow_setUnicodeTitle(atom rw,atom title)
	c_proc(xsfRenderWindow_setUnicodeTitle,{rw,title})
end procedure

public constant xsfRenderWindow_setIcon = define_c_proc(gfx,"+sfRenderWindow_setIcon",{C_POINTER,C_UINT,C_UINT,C_POINTER})

public procedure sfRenderWindow_setIcon(atom rw,atom w,atom h,atom pix)
	c_proc(xsfRenderWindow_setIcon,{rw,w,h,pix})
end procedure

public constant xsfRenderWindow_setVisible = define_c_proc(gfx,"+sfRenderWindow_setVisible",{C_POINTER,C_BOOL})

public procedure sfRenderWindow_setVisible(atom rw,atom vis)
	c_proc(xsfRenderWindow_setVisible,{rw,vis})
end procedure

public constant xsfRenderWindow_setVerticalSyncEnabled = define_c_proc(gfx,"+sfRenderWindow_setVerticalSyncEnabled",{C_POINTER,C_BOOL})

public procedure sfRenderWindow_setVerticalSyncEnabled(atom rw,atom en)
	c_proc(xsfRenderWindow_setVerticalSyncEnabled,{rw,en})
end procedure

public constant xsfRenderWindow_setMouseCursorVisible = define_c_proc(gfx,"+sfRenderWindow_setMouseCursorVisible",{C_POINTER,C_BOOL})

public procedure sfRenderWindow_setMouseCursorVisible(atom rw,atom show)
	c_proc(xsfRenderWindow_setMouseCursorVisible,{rw,show})
end procedure

public constant xsfRenderWindow_setMouseCursorGrabbed = define_c_proc(gfx,"+sfRenderWindow_setMouseCursorGrabbed",{C_POINTER,C_BOOL})

public procedure sfRenderWindow_setMouseCursorGrabbed(atom rw,atom grab)
	c_proc(xsfRenderWindow_setMouseCursorGrabbed,{rw,grab})
end procedure

public constant xsfRenderWindow_setMouseCursor = define_c_proc(gfx,"+sfRenderWindow_setMouseCursor",{C_POINTER,C_POINTER})

public procedure sfRenderWindow_setMouseCursor(atom rw,atom cur)
	c_proc(xsfRenderWindow_setMouseCursor,{rw,cur})
end procedure

public constant xsfRenderWindow_setKeyRepeatEnabled = define_c_proc(gfx,"+sfRenderWindow_setKeyRepeatEnabled",{C_POINTER,C_BOOL})

public procedure sfRenderWindow_setKeyRepeatEnabled(atom rw,atom en)
	c_proc(xsfRenderWindow_setKeyRepeatEnabled,{rw,en})
end procedure

public constant xsfRenderWindow_setFramerateLimit = define_c_proc(gfx,"+sfRenderWindow_setFramerateLimit",{C_POINTER,C_UINT})

public procedure sfRenderWindow_setFramerateLimit(atom rw,atom lim)
	c_proc(xsfRenderWindow_setFramerateLimit,{rw,lim})
end procedure

public constant xsfRenderWindow_setJoystickThreshold = define_c_proc(gfx,"+sfRenderWindow_setJoystickThreshold",{C_POINTER,C_FLOAT})

public procedure sfRenderWindow_setJoystickThreshold(atom rw,atom thres)
	c_proc(xsfRenderWindow_setJoystickThreshold,{rw,thres})
end procedure

public constant xsfRenderWindow_setActive = define_c_func(gfx,"+sfRenderWindow_setActive",{C_POINTER,C_BOOL},C_BOOL)

public function sfRenderWindow_setActive(atom rw,atom act)
	return c_func(xsfRenderWindow_setActive,{rw,act})
end function

public constant xsfRenderWindow_requestFocus = define_c_proc(gfx,"+sfRenderWindow_requestFocus",{C_POINTER})

public procedure sfRenderWindow_requestFocus(atom rw)
	c_proc(xsfRenderWindow_requestFocus,{rw})
end procedure

public constant xsfRenderWindow_hasFocus = define_c_func(gfx,"+sfRenderWindow_hasFocus",{C_POINTER},C_BOOL)

public function sfRenderWindow_hasFocus(atom rw)
	return c_func(xsfRenderWindow_hasFocus,{rw})
end function

public constant xsfRenderWindow_display = define_c_proc(gfx,"+sfRenderWindow_display",{C_POINTER})

public procedure sfRenderWindow_display(atom rw)
	c_proc(xsfRenderWindow_display,{rw})
end procedure

public constant xsfRenderWindow_getSystemHandle = define_c_func(gfx,"+sfRenderWindow_getSystemHandle",{C_POINTER},C_POINTER)

public function sfRenderWindow_getSystemHandle(atom rw)
	return c_func(xsfRenderWindow_getSystemHandle,{rw})
end function

public constant xsfRenderWindow_clear = define_c_proc(gfx,"+sfRenderWindow_clear",{C_POINTER,sfColor})

public procedure sfRenderWindow_clear(atom rw,sequence col)
	c_proc(xsfRenderWindow_clear,{rw,col})
end procedure

public constant xsfRenderWindow_setView = define_c_proc(gfx,"+sfRenderWindow_setView",{C_POINTER,C_POINTER})

public procedure sfRenderWindow_setView(atom rw,atom v)
	c_proc(xsfRenderWindow_setView,{rw,v})
end procedure

public constant xsfRenderWindow_getView = define_c_func(gfx,"+sfRenderWindow_getView",{C_POINTER},C_POINTER)

public function sfRenderWindow_getView(atom rw)
	return c_func(xsfRenderWindow_getView,{rw})
end function

public constant xsfRenderWindow_getDefaultView = define_c_func(gfx,"+sfRenderWindow_getDefaultView",{C_POINTER},C_POINTER)

public function sfRenderWindow_getDefaultView(atom rw)
	return c_func(xsfRenderWindow_getDefaultView,{rw})
end function

public constant xsfRenderWindow_getViewport = define_c_func(gfx,"+sfRenderWindow_getViewport",{C_POINTER,C_POINTER},sfIntRect)

public function sfRenderWindow_getViewport(atom rw,atom v)
	return c_func(xsfRenderWindow_getViewport,{rw,v})
end function

public constant xsfRenderWindow_mapPixelToCoords = define_c_func(gfx,"+sfRenderWindow_mapPixelToCoords",{C_POINTER,sfVector2i,C_POINTER},sfVector2f)

public function sfRenderWindow_mapPixelToCoords(atom rw,sequence pt,atom v)
	return c_func(xsfRenderWindow_mapPixelToCoords,{rw,pt,v})
end function

public constant xsfRenderWindow_mapCoordsToPixel = define_c_func(gfx,"+sfRenderWindow_mapCoordsToPixel",{C_POINTER,sfVector2f,C_POINTER},sfVector2i)

public function sfRenderWindow_mapCoordsToPixel(atom rw,sequence pt,atom v)
	return c_func(xsfRenderWindow_mapCoordsToPixel,{rw,pt,v})
end function

public constant xsfRenderWindow_drawSprite = define_c_proc(gfx,"+sfRenderWindow_drawSprite",{C_POINTER,C_POINTER,C_POINTER}),
				xsfRenderWindow_drawText = define_c_proc(gfx,"+sfRenderWindow_drawText",{C_POINTER,C_POINTER,C_POINTER}),
				xsfRenderWindow_drawShape = define_c_proc(gfx,"+sfRenderWindow_drawShape",{C_POINTER,C_POINTER,C_POINTER}),
				xsfRenderWindow_drawCircleShape = define_c_proc(gfx,"+sfRenderWindow_drawCircleShape",{C_POINTER,C_POINTER,C_POINTER}),
				xsfRenderWindow_drawConvexShape = define_c_proc(gfx,"+sfRenderWindow_drawConvexShape",{C_POINTER,C_POINTER,C_POINTER}),
				xsfRenderWindow_drawRectangleShape = define_c_proc(gfx,"+sfRenderWindow_drawRectangleShape",{C_POINTER,C_POINTER,C_POINTER}),
				xsfRenderWindow_drawVertexArray = define_c_proc(gfx,"+sfRenderWindow_drawVertexArray",{C_POINTER,C_POINTER,C_POINTER}),
				xsfRenderWindow_drawVertexBuffer = define_c_proc(gfx,"+sfRenderWindow_drawVertexBuffer",{C_POINTER,C_POINTER,C_POINTER})
				
public procedure sfRenderWindow_drawSprite(atom rw,atom spr,atom st)
	c_proc(xsfRenderWindow_drawSprite,{rw,spr,st})
end procedure

public procedure sfRenderWindow_drawText(atom rw,atom txt,atom st)
	c_proc(xsfRenderWindow_drawText,{rw,txt,st})
end procedure

public procedure sfRenderWindow_drawShape(atom rw,atom shp,atom st)
	c_proc(xsfRenderWindow_drawShape,{rw,shp,st})
end procedure

public procedure sfRenderWindow_drawCircleShape(atom rw,atom circ,atom st)
	c_proc(xsfRenderWindow_drawCircleShape,{rw,circ,st})
end procedure

public procedure sfRenderWindow_drawConvexShape(atom rw,atom con,atom st)
	c_proc(xsfRenderWindow_drawConvexShape,{rw,con,st})
end procedure

public procedure sfRenderWindow_drawRectangleShape(atom rw,atom rect,atom st)
	c_proc(xsfRenderWindow_drawRectangleShape,{rw,rect,st})
end procedure

public procedure sfRenderWindow_drawVertexArray(atom rw,atom va,atom st)
	c_proc(xsfRenderWindow_drawVertexArray,{rw,va,st})
end procedure

public procedure sfRenderWindow_drawVertexBuffer(atom rw,atom vb,atom st)
	c_proc(xsfRenderWindow_drawVertexBuffer,{rw,vb,st})
end procedure

public constant xsfRenderWindow_drawVertexBufferRange = define_c_proc(gfx,"+sfRenderWindow_drawVertexBufferRange",{C_POINTER,C_POINTER,C_SIZE_T,C_SIZE_T,C_POINTER})

public procedure sfRenderWindow_drawVertexBufferRange(atom rw,atom vb,atom first,atom cnt,atom st)
	c_proc(xsfRenderWindow_drawVertexBufferRange,{rw,vb,first,cnt,st})
end procedure

public constant xsfRenderWindow_drawPrimitives = define_c_proc(gfx,"+sfRenderWindow_drawPrimitives",{C_POINTER,C_POINTER,C_SIZE_T,C_INT,C_POINTER})

public procedure sfRenderWindow_drawPrimitives(atom rw,atom verts,atom cnt,atom t,atom st)
	c_proc(xsfRenderWindow_drawPrimitives,{rw,verts,cnt,t,st})
end procedure

public constant xsfRenderWindow_pushGLStates = define_c_proc(gfx,"+sfRenderWindow_pushGLStates",{C_POINTER})

public procedure sfRenderWindow_pushGLStates(atom rw)
	c_proc(xsfRenderWindow_pushGLStates,{rw})
end procedure

public constant xsfRenderWindow_popGLStates = define_c_proc(gfx,"+sfRenderWindow_popGLStates",{C_POINTER})

public procedure sfRenderWindow_popGLStates(atom rw)
	c_proc(xsfRenderWindow_popGLStates,{rw})
end procedure

public constant xsfRenderWindow_resetGLStates = define_c_proc(gfx,"+sfRenderWindow_resetGLStates",{C_POINTER})

public procedure sfRenderWindow_resetGLStates(atom rw)
	c_proc(xsfRenderWindow_resetGLStates,{rw})
end procedure

public constant xsfMouse_getPositionRenderWindow = define_c_func(gfx,"+sfMouse_getPositionRenderWindow",{C_POINTER},sfVector2i)

public function sfMouse_getPositionRenderWindow(atom rt)
	return c_func(xsfMouse_getPositionRenderWindow,{rt})
end function

public constant xsfMouse_setPositionRenderWindow = define_c_proc(gfx,"+sfMouse_setPositionRenderWindow",{sfVector2i,C_POINTER})

public procedure sfMouse_setPositionRenderWindow(sequence pos,atom rt)
	c_proc(xsfMouse_setPositionRenderWindow,{pos,rt})
end procedure

public constant xsfTouch_getPositionRenderWindow = define_c_func(gfx,"+sfTouch_getPositionRenderWindow",{C_UINT,C_POINTER},sfVector2i)

public function sfTouch_getPositionRenderWindow(atom fing,atom rt)
	return c_func(xsfTouch_getPositionRenderWindow,{fing,rt})
end function

--RenderTexture

public constant xsfRenderTexture_create = define_c_func(gfx,"+sfRenderTexture_create",{C_UINT,C_UINT,C_BOOL},C_POINTER)

public function sfRenderTexture_create(atom w,atom h,atom db)
	return c_func(xsfRenderTexture_create,{w,h,db})
end function

public constant xsfRenderTexture_createWithSettings = define_c_func(gfx,"+sfRenderTexture_createWithSettings",{C_UINT,C_UINT,C_POINTER},C_POINTER)

public function sfRenderTexture_createWithSettings(atom w,atom h,atom set)
	return c_func(xsfRenderTexture_createWithSettings,{w,h,set})
end function

public constant xsfRenderTexture_destroy = define_c_proc(gfx,"+sfRenderTexture_destroy",{C_POINTER})

public procedure sfRenderTexture_destroy(atom rt)
	c_proc(xsfRenderTexture_destroy,{rt})
end procedure

public constant xsfRenderTexture_getSize = define_c_func(gfx,"+sfRenderTexture_getSize",{C_POINTER},sfVector2u)

public function sfRenderTexture_getSize(atom rt)
	return c_func(xsfRenderTexture_getSize,{rt})
end function

public constant xsfRenderTexture_isSrgb = define_c_func(gfx,"+sfRenderTexture_isSrgb",{C_POINTER},C_BOOL)

public function sfRenderTexture_isSrgb(atom rt)
	return c_func(xsfRenderTexture_isSrgb,{rt})
end function

public constant xsfRenderTexture_setActive = define_c_func(gfx,"+sfRenderTexture_setActive",{C_POINTER,C_BOOL},C_BOOL)

public function sfRenderTexture_setActive(atom rt,atom act)
	return c_func(xsfRenderTexture_setActive,{rt,act})
end function

public constant xsfRenderTexture_display = define_c_proc(gfx,"+sfRenderTexture_display",{C_POINTER})

public procedure sfRenderTexture_display(atom rt)
	c_proc(xsfRenderTexture_display,{rt})
end procedure

public constant xsfRenderTexture_clear = define_c_proc(gfx,"+sfRenderTexture_clear",{C_POINTER,sfColor})

public procedure sfRenderTexture_clear(atom rt,sequence col)
	c_proc(xsfRenderTexture_clear,{rt,col})
end procedure

public constant xsfRenderTexture_setView = define_c_proc(gfx,"+sfRenderTexture_setView",{C_POINTER,C_POINTER})

public procedure sfRenderTexture_setView(atom rt,atom v)
	c_proc(xsfRenderTexture_setView,{rt,v})
end procedure

public constant xsfRenderTexture_getView = define_c_func(gfx,"+sfRenderTexture_getView",{C_POINTER},C_POINTER)

public function sfRenderTexture_getView(atom rt)
	return c_func(xsfRenderTexture_getView,{rt})
end function

public constant xsfRenderTexture_getDefaultView = define_c_func(gfx,"+sfRenderTexture_getDefaultView",{C_POINTER},C_POINTER)

public function sfRenderTexture_getDefaultView(atom rt)
	return c_func(xsfRenderTexture_getDefaultView,{rt})
end function

public constant xsfRenderTexture_getViewport = define_c_func(gfx,"+sfRenderTexture_getViewport",{C_POINTER,C_POINTER},sfIntRect)

public function sfRenderTexture_getViewport(atom rt,atom v)
	return c_func(xsfRenderTexture_getViewport,{rt,v})
end function

public constant xsfRenderTexture_mapPixelToCoords = define_c_func(gfx,"+sfRenderTexture_mapPixelToCoords",{C_POINTER,sfVector2i,C_POINTER},sfVector2f)

public function sfRenderTexture_mapPixelToCoords(atom rt,sequence pt,atom v)
	return c_func(xsfRenderTexture_mapPixelToCoords,{rt,pt,v})
end function

public constant xsfRenderTexture_mapCoordsToPixel = define_c_func(gfx,"+sfRenderTexture_mapCoordsToPixel",{C_POINTER,sfVector2f,C_POINTER},sfVector2i)

public function sfRenderTexture_mapCoordsToPixel(atom rt,sequence pt,atom v)
	return c_func(xsfRenderTexture_mapCoordsToPixel,{rt,pt,v})
end function

public constant xsfRenderTexture_drawSprite = define_c_proc(gfx,"+sfRenderTexture_drawSprite",{C_POINTER,C_POINTER,C_POINTER}),
				xsfRenderTexture_drawText = define_c_proc(gfx,"+sfRenderTexture_drawText",{C_POINTER,C_POINTER,C_POINTER}),
				xsfRenderTexture_drawShape = define_c_proc(gfx,"+sfRenderTexture_drawShape",{C_POINTER,C_POINTER,C_POINTER}),
				xsfRenderTexture_drawCircleShape = define_c_proc(gfx,"+sfRenderTexture_drawCircleShape",{C_POINTER,C_POINTER,C_POINTER}),
				xsfRenderTexture_drawConvexShape = define_c_proc(gfx,"+sfRenderTexture_drawConvexShape",{C_POINTER,C_POINTER,C_POINTER}),
				xsfRenderTexture_drawRectangleShape = define_c_proc(gfx,"+sfRenderTexture_drawRectangleShape",{C_POINTER,C_POINTER,C_POINTER}),
				xsfRenderTexture_drawVertexArray = define_c_proc(gfx,"+sfRenderTexture_drawVertexArray",{C_POINTER,C_POINTER,C_POINTER}),
				xsfRenderTexture_drawVertexBuffer = define_c_proc(gfx,"+sfRenderTexture_drawVertexBuffer",{C_POINTER,C_POINTER,C_POINTER})
				
public procedure sfRenderTexture_drawSprite(atom rt,atom spr,atom st)
	c_proc(xsfRenderTexture_drawSprite,{rt,spr,st})
end procedure

public procedure sfRenderTexture_drawText(atom rt,atom txt,atom st)
	c_proc(xsfRenderTexture_drawText,{rt,txt,st})
end procedure

public procedure sfRenderTexture_drawShape(atom rt,atom shp,atom st)
	c_proc(xsfRenderTexture_drawShape,{rt,shp,st})
end procedure

public procedure sfRenderTexture_drawCircleShape(atom rt,atom circ,atom st)
	c_proc(xsfRenderTexture_drawCircleShape,{rt,circ,st})
end procedure

public procedure sfRenderTexture_drawConvexShape(atom rt,atom con,atom st)
	c_proc(xsfRenderTexture_drawConvexShape,{rt,con,st})
end procedure

public procedure sfRenderTexture_drawRectangleShape(atom rt,atom rec,atom st)
	c_proc(xsfRenderTexture_drawRectangleShape,{rt,rec,st})
end procedure

public procedure sfRenderTexture_drawVertexArray(atom rt,atom va,atom st)
	c_proc(xsfRenderTexture_drawVertexArray,{rt,va,st})
end procedure

public procedure sfRenderTexture_drawVertexBuffer(atom rt,atom vb,atom st)
	c_proc(xsfRenderTexture_drawVertexBuffer,{rt,vb,st})
end procedure

public constant xsfRenderTexture_drawVertexBufferRange = define_c_proc(gfx,"+sfRenderTexture_drawVertexBufferRange",{C_POINTER,C_POINTER,C_SIZE_T,C_SIZE_T,C_POINTER})

public procedure sfRenderTexture_drawVertexBufferRange(atom rt,atom vb,atom first,atom cnt,atom st)
	c_proc(xsfRenderTexture_drawVertexBufferRange,{rt,vb,first,cnt,st})
end procedure

public constant xsfRenderTexture_drawPrimitives = define_c_proc(gfx,"+sfRenderTexture_drawPrimitives",{C_POINTER,C_POINTER,C_SIZE_T,C_INT,C_POINTER})

public procedure sfRenderTexture_drawPrimitives(atom rt,atom verts,atom cnt,atom t,atom st)
	c_proc(xsfRenderTexture_drawPrimitives,{rt,verts,cnt,t,st})
end procedure

public constant xsfRenderTexture_pushGLStates = define_c_proc(gfx,"+sfRenderTexture_pushGLStates",{C_POINTER})

public procedure sfRenderTexture_pushGLStates(atom rt)
	c_proc(xsfRenderTexture_pushGLStates,{rt})
end procedure

public constant xsfRenderTexture_popGLStates = define_c_proc(gfx,"+sfRenderTexture_popGLStates",{C_POINTER})

public procedure sfRenderTexture_popGLStates(atom rt)
	c_proc(xsfRenderTexture_popGLStates,{rt})
end procedure

public constant xsfRenderTexture_resetGLStates = define_c_proc(gfx,"+sfRenderTexture_resetGLStates",{C_POINTER})

public procedure sfRenderTexture_resetGLStates(atom rt)
	c_proc(xsfRenderTexture_resetGLStates,{rt})
end procedure

public constant xsfRenderTexture_getTexture = define_c_func(gfx,"+sfRenderTexture_getTexture",{C_POINTER},C_POINTER)

public function sfRenderTexture_getTexture(atom rt)
	return c_func(xsfRenderTexture_getTexture,{rt})
end function

public constant xsfRenderTexture_getMaximumAntialiasingLevel = define_c_func(gfx,"+sfRenderTexture_getMaximumAntialiasingLevel",{},C_UINT)

public function sfRenderTexture_getMaximumAntialiasingLevel()
	return c_func(xsfRenderTexture_getMaximumAntialiasingLevel,{})
end function

public constant xsfRenderTexture_setSmooth = define_c_proc(gfx,"+sfRenderTexture_setSmooth",{C_POINTER,C_BOOL})

public procedure sfRenderTexture_setSmooth(atom rt,atom smo)
	c_proc(xsfRenderTexture_setSmooth,{rt,smo})
end procedure

public constant xsfRenderTexture_isSmooth = define_c_func(gfx,"+sfRenderTexture_isSmooth",{C_POINTER},C_BOOL)

public function sfRenderTexture_isSmooth(atom rt)
	return c_func(xsfRenderTexture_isSmooth,{rt})
end function

public constant xsfRenderTexture_setRepeated = define_c_proc(gfx,"+sfRenderTexture_setRepeated",{C_POINTER,C_BOOL})

public procedure sfRenderTexture_setRepeated(atom rt,atom rep)
	c_proc(xsfRenderTexture_setRepeated,{rt,rep})
end procedure

public constant xsfRenderTexture_isRepeated = define_c_func(gfx,"+sfRenderTexture_isRepeated",{C_POINTER},C_BOOL)

public function sfRenderTexture_isRepeated(atom rt)
	return c_func(xsfRenderTexture_isRepeated,{rt})
end function

public constant xsfRenderTexture_generateMipmap = define_c_func(gfx,"+sfRenderTexture_generateMipmap",{C_POINTER},C_BOOL)

public function sfRenderTexture_generateMipmap(atom rt)
	return c_func(xsfRenderTexture_generateMipmap,{rt})
end function

--Shader

public constant xsfShader_createFromFile = define_c_func(gfx,"+sfShader_createFromFile",{C_STRING,C_STRING,C_STRING},C_POINTER)

public function sfShader_createFromFile(sequence vsfn,sequence gsfn,sequence fsfn)
	return c_func(xsfShader_createFromFile,{vsfn,gsfn,fsfn})
end function

public constant xsfShader_createFromMemory = define_c_func(gfx,"+sfShader_createFromMemory",{C_STRING,C_STRING,C_STRING},C_POINTER)

public function sfShader_createFromMemory(sequence vs,sequence gs,sequence fs)
	return c_func(xsfShader_createFromMemory,{vs,gs,fs})
end function

public constant xsfShader_createFromStream = define_c_func(gfx,"+sfShader_createFromStream",{C_POINTER,C_POINTER,C_POINTER},C_POINTER)

public function sfShader_createFromStream(atom vsstr,atom gsstr,atom fsstr)
	return c_func(xsfShader_createFromStream,{vsstr,gsstr,fsstr})
end function

public constant xsfShader_destroy = define_c_proc(gfx,"+sfShader_destroy",{C_POINTER})

public procedure sfShader_destroy(atom s)
	c_proc(xsfShader_destroy,{s})
end procedure

public constant xsfShader_setFloatUniform = define_c_proc(gfx,"+sfShader_setFloatUniform",{C_POINTER,C_STRING,C_FLOAT})

public procedure sfShader_setFloatUniform(atom s,sequence name,atom x)
	c_proc(xsfShader_setFloatUniform,{s,name,x})
end procedure

public constant xsfShader_setVec2Uniform = define_c_proc(gfx,"+sfShader_setVec2Uniform",{C_POINTER,C_STRING,sfVector2f})

public procedure sfShader_setVec2Uniform(atom s,sequence name,sequence vec)
	c_proc(xsfShader_setVec2Uniform,{s,name,vec})
end procedure

public constant xsfShader_setVec3Uniform = define_c_proc(gfx,"+sfShader_setVec3Uniform",{C_POINTER,C_STRING,sfVector3f})

public procedure sfShader_setVec3Uniform(atom s,sequence name,sequence vec)
	c_proc(xsfShader_setVec3Uniform,{s,name,vec})
end procedure

public constant xsfShader_setVec4Uniform = define_c_proc(gfx,"+sfShader_setVec4Uniform",{C_POINTER,C_STRING,sfGlslVec4})

public procedure sfShader_setVec4Uniform(atom s,sequence name,sequence vec)
	c_proc(xsfShader_setVec4Uniform,{s,name,vec})
end procedure

public constant xsfShader_setColorUniform = define_c_proc(gfx,"+sfShader_setColorUniform",{C_POINTER,C_STRING,sfColor})

public procedure sfShader_setColorUniform(atom s,sequence name,sequence col)
	c_proc(xsfShader_setColorUniform,{s,name,col})
end procedure

public constant xsfShader_setIntUniform = define_c_proc(gfx,"+sfShader_setIntUniform",{C_POINTER,C_STRING,C_INT})

public procedure sfShader_setIntUniform(atom s,sequence name,atom x)
	c_proc(xsfShader_setIntUniform,{s,name,x})
end procedure

public constant xsfShader_setIvec2Uniform = define_c_proc(gfx,"+sfShader_setIvec2Uniform",{C_POINTER,C_STRING,sfGlslIvec2})

public procedure sfShader_setIvec2Uniform(atom s,sequence name,sequence vec)
	c_proc(xsfShader_setIvec2Uniform,{s,name,vec})
end procedure

public constant xsfShader_setIvec3Uniform = define_c_proc(gfx,"+sfShader_setIvec3Uniform",{C_POINTER,C_STRING,sfGlslIvec3})

public procedure sfShader_setIvec3Uniform(atom s,sequence name,sequence vec)
	c_proc(xsfShader_setIvec3Uniform,{s,name,vec})
end procedure

public constant xsfShader_setIvec4Uniform = define_c_proc(gfx,"+sfShader_setIvec4Uniform",{C_POINTER,C_STRING,sfGlslIvec4})

public procedure sfShader_setIvec4Uniform(atom s,sequence name,sequence vec)
	c_proc(xsfShader_setIvec4Uniform,{s,name,vec})
end procedure

public constant xsfShader_setIntColorUniform = define_c_proc(gfx,"+sfShader_setIntColorUniform",{C_POINTER,C_STRING,sfColor})

public procedure sfShader_setIntColorUniform(atom s,sequence name,sequence col)
	c_proc(xsfShader_setIntColorUniform,{s,name,col})
end procedure

public constant xsfShader_setBoolUniform = define_c_proc(gfx,"+sfSahder_setBoolUniform",{C_POINTER,C_STRING,C_BOOL})

public procedure sfShader_setBoolUniform(atom s,sequence name,integer x)
	c_proc(xsfShader_setBoolUniform,{s,name,x})
end procedure

public constant xsfShader_setBvec2Uniform = define_c_proc(gfx,"+sfShader_setBvec2Uniform",{C_POINTER,C_STRING,sfGlslBvec2})

public procedure sfShader_setBvec2Uniform(atom s,sequence name,sequence vec)
	c_proc(xsfShader_setBvec2Uniform,{s,name,vec})
end procedure

public constant xsfShader_setBvec3Uniform = define_c_proc(gfx,"+sfShader_setBvec3Uniform",{C_POINTER,C_STRING,sfGlslBvec3})

public procedure sfShader_setBvec3Uniform(atom s,sequence name,sequence vec)
	c_proc(xsfShader_setBvec3Uniform,{s,name,vec})
end procedure

public constant xsfShader_setBvec4Uniform = define_c_proc(gfx,"+sfShader_setBvec4Uniform",{C_POINTER,C_STRING,sfGlslBvec4})

public procedure sfShader_setBvec4Uniform(atom s,sequence name,sequence vec)
	c_proc(xsfShader_setBvec4Uniform,{s,name,vec})
end procedure

public constant xsfShader_setMat3Uniform = define_c_proc(gfx,"+sfShader_setMat3Uniform",{C_POINTER,C_STRING,C_POINTER})

public procedure sfShader_setMat3Uniform(atom s,sequence name,atom mat)
	c_proc(xsfShader_setMat3Uniform,{s,name,mat})
end procedure

public constant xsfShader_setMat4Uniform = define_c_proc(gfx,"+sfShader_setMat4Uniform",{C_POINTER,C_STRING,C_POINTER})

public procedure sfShader_setMat4Uniform(atom s,sequence name,atom mat)
	c_proc(xsfShader_setMat4Uniform,{s,name,mat})
end procedure

public constant xsfShader_setTextureUniform = define_c_proc(gfx,"+sfShader_setTextureUniform",{C_POINTER,C_STRING,C_POINTER})

public procedure sfShader_setTextureUniform(atom s,sequence name,atom tex)
	c_proc(xsfShader_setTextureUniform,{s,name,tex})
end procedure

public constant xsfShader_setCurrentTextureUniform = define_c_proc(gfx,"+sfShader_setCurrentTextureUniform",{C_POINTER,C_STRING})

public procedure sfShader_setCurrentTextureUniform(atom s,sequence name)
	c_proc(xsfShader_setCurrentTextureUniform,{s,name})
end procedure

public constant xsfShader_setFloatUniformArray = define_c_proc(gfx,"+sfShader_setFloatUniformArray",{C_POINTER,C_STRING,C_POINTER,C_SIZE_T})

public procedure sfShader_setFloatUniformArray(atom s,sequence name,atom scalar,atom len)
	c_proc(xsfShader_setFloatUniformArray,{s,name,scalar,len})
end procedure

public constant xsfShader_setVec2UniformArray = define_c_proc(gfx,"+sfShader_setVec2UniformArray",{C_POINTER,C_STRING,C_POINTER,C_SIZE_T})

public procedure sfShader_setVec2UniformArray(atom s,sequence name,atom va,atom len)
	c_proc(xsfShader_setVec2UniformArray,{s,name,va,len})
end procedure

public constant xsfShader_setVec3UniformArray = define_c_proc(gfx,"+sfShader_setVec3UniformArray",{C_POINTER,C_STRING,C_POINTER,C_SIZE_T})

public procedure sfShader_setVec3UniformArray(atom s,sequence name,atom va,atom len)
	c_proc(xsfShader_setVec3UniformArray,{s,name,va,len})
end procedure

public constant xsfShader_setVec4UniformArray = define_c_proc(gfx,"+sfShader_setVec4UniformArray",{C_POINTER,C_STRING,C_POINTER,C_SIZE_T})

public procedure sfShader_setVec4UniformArray(atom s,sequence name,atom va,atom len)
	c_proc(xsfShader_setVec4UniformArray,{s,name,va,len})
end procedure

public constant xsfShader_setMat3UniformArray = define_c_proc(gfx,"+sfShader_setMat3UniformArray",{C_POINTER,C_STRING,C_POINTER,C_SIZE_T})

public procedure sfShader_setMat3UniformArray(atom s,sequence name,atom ma,atom len)
	c_proc(xsfShader_setMat3UniformArray,{s,name,ma,len})
end procedure

public constant xsfShader_setMat4UniformArray = define_c_proc(gfx,"+sfShader_setMat4UniformArray",{C_POINTER,C_STRING,C_POINTER,C_SIZE_T})

public procedure sfShader_setMat4UniformArray(atom s,sequence name,atom ma,atom len)
	c_proc(xsfShader_setMat4UniformArray,{s,name,ma,len})
end procedure

public constant xsfShader_getNativeHandle = define_c_func(gfx,"+sfShader_getNativeHandle",{C_POINTER},C_UINT)

public function sfShader_getNativeHandle(atom s)
	return c_func(xsfShader_getNativeHandle,{s})
end function

public constant xsfShader_bind = define_c_proc(gfx,"+sfShader_bind",{C_POINTER})

public procedure sfShader_bind(atom s)
	c_proc(xsfShader_bind,{s})
end procedure

public constant xsfShader_isAvailable = define_c_func(gfx,"+sfShader_isAvailable",{},C_BOOL)

public function sfShader_isAvailable()
	return c_func(xsfShader_isAvailable,{})
end function

public constant xsfShader_isGeometryAvailable = define_c_func(gfx,"+sfShader_isGeometryAvailable",{},C_BOOL)

public function sfShader_isGeometryAvailable()
	return c_func(xsfShader_isGeometryAvailable,{})
end function

--Shape

public constant xsfShape_create = define_c_func(gfx,"+sfShape_create",{C_POINTER,C_POINTER,C_POINTER},C_POINTER)

public function sfShape_create(atom getPointCount,atom getPoint,atom ud)
	return c_func(xsfShape_create,{getPointCount,getPoint,ud})
end function

public constant xsfShape_destroy = define_c_proc(gfx,"+sfShape_destroy",{C_POINTER})

public procedure sfShape_destroy(atom s)
	c_proc(xsfShape_destroy,{s})
end procedure

public constant xsfShape_setPosition = define_c_proc(gfx,"+sfShape_setPosition",{C_POINTER,sfVector2f})

public procedure sfShape_setPosition(atom s,sequence pos)
	c_proc(xsfShape_setPosition,{s,pos})
end procedure

public constant xsfShape_setRotation = define_c_proc(gfx,"+sfShape_setRotation",{C_POINTER,C_FLOAT})

public procedure sfShape_setRotation(atom s,atom ang)
	c_proc(xsfShape_setRotation,{s,ang})
end procedure

public constant xsfShape_setScale = define_c_proc(gfx,"+sfShape_setScale",{C_POINTER,sfVector2f})

public procedure sfShape_setScale(atom s,sequence sca)
	c_proc(xsfShape_setScale,{s,sca})
end procedure

public constant xsfShape_setOrigin = define_c_proc(gfx,"+sfShape_setOrigin",{C_POINTER,sfVector2f})

public procedure sfShape_setOrigin(atom s,sequence ori)
	c_proc(xsfShape_setOrigin,{s,ori})
end procedure

public constant xsfShape_getPosition = define_c_func(gfx,"+sfShape_getPosition",{C_POINTER},sfVector2f)

public function sfShape_getPosition(atom s)
	return c_func(xsfShape_getPosition,{s})
end function

public constant xsfShape_getRotation = define_c_func(gfx,"+sfShape_getRotation",{C_POINTER},C_FLOAT)

public function sfShape_getRotation(atom s)
	return c_func(xsfShape_getRotation,{s})
end function

public constant xsfShape_getScale = define_c_func(gfx,"+sfShape_getScale",{C_POINTER},sfVector2f)

public function sfShape_getScale(atom s)
	return c_func(xsfShape_getScale,{s})
end function

public constant xsfShape_getOrigin = define_c_func(gfx,"+sfShape_getOrigin",{C_POINTER},sfVector2f)

public function sfShape_getOrigin(atom s)
	return c_func(xsfShape_getOrigin,{s})
end function

public constant xsfShape_move = define_c_proc(gfx,"+sfShape_move",{C_POINTER,sfVector2f})

public procedure sfShape_move(atom s,sequence off)
	c_proc(xsfShape_move,{s,off})
end procedure

public constant xsfShape_rotate = define_c_proc(gfx,"+sfShape_rotate",{C_POINTER,C_FLOAT})

public procedure sfShape_rotate(atom s,atom ang)
	c_proc(xsfShape_rotate,{s,ang})
end procedure

public constant xsfShape_scale = define_c_proc(gfx,"+sfShape_scale",{C_POINTER,sfVector2f})

public procedure sfShape_scale(atom s,sequence fac)
	c_proc(xsfShape_scale,{s,fac})
end procedure

public constant xsfShape_getTransform = define_c_func(gfx,"+sfShape_getTransform",{C_POINTER},sfTransform)

public function sfShape_getTransform(atom s)
	return c_func(xsfShape_getTransform,{s})
end function

public constant xsfShape_getInverseTransform = define_c_func(gfx,"+sfShape_getInverseTransform",{C_POINTER},sfTransform)

public function sfShape_getInverseTransform(atom s)
	return c_func(xsfShape_getInverseTransform,{s})
end function

public constant xsfShape_setTexture = define_c_proc(gfx,"+sfShape_setTexture",{C_POINTER,C_POINTER,C_BOOL})

public procedure sfShape_setTexture(atom s,atom tex,atom reset)
	c_proc(xsfShape_setTexture,{s,tex,reset})
end procedure

public constant xsfShape_setTextureRect = define_c_proc(gfx,"+sfShape_setTextureRect",{C_POINTER,sfIntRect})

public procedure sfShape_setTextureRect(atom s,sequence rect)
	c_proc(xsfShape_setTextureRect,{s,rect})
end procedure

public constant xsfShape_setFillColor = define_c_proc(gfx,"+sfShape_setFillColor",{C_POINTER,sfColor})

public procedure sfShape_setFillColor(atom s,sequence col)
	c_proc(xsfShape_setFillColor,{s,col})
end procedure

public constant xsfShape_setOutlineColor = define_c_proc(gfx,"+sfShape_setOutlineColor",{C_POINTER,sfColor})

public procedure sfShape_setOutlineColor(atom s,sequence col)
	c_proc(xsfShape_setOutlineColor,{s,col})
end procedure

public constant xsfShape_setOutlineThickness = define_c_proc(gfx,"+sfShape_setOutlineThickness",{C_POINTER,C_FLOAT})

public procedure sfShape_setOutlineThickness(atom s,atom thick)
	c_proc(xsfShape_setOutlineThickness,{s,thick})
end procedure

public constant xsfShape_getTexture = define_c_func(gfx,"+sfShape_getTexture",{C_POINTER},C_POINTER)

public function sfShape_getTexture(atom s)
	return c_func(xsfShape_getTexture,{s})
end function

public constant xsfShape_getTextureRect = define_c_func(gfx,"+sfShape_getTextureRect",{C_POINTER},sfIntRect)

public function sfShape_getTextureRect(atom s)
	return c_func(xsfShape_getTextureRect,{s})
end function

public constant xsfShape_getFillColor = define_c_func(gfx,"+sfShape_getFillColor",{C_POINTER},sfColor)

public function sfShape_getFillColor(atom s)
	return c_func(xsfShape_getFillColor,{s})
end function

public constant xsfShape_getOutlineColor = define_c_func(gfx,"+sfShape_getOutlineColor",{C_POINTER},sfColor)

public function sfShape_getOutlineColor(atom s)
	return c_func(xsfShape_getOutlineColor,{s})
end function

public constant xsfShape_getOutlineThickness = define_c_func(gfx,"+sfShape_getOutlineThickness",{C_POINTER},C_FLOAT)

public function sfShape_getOutlineThickness(atom s)
	return c_func(xsfShape_getOutlineThickness,{s})
end function

public constant xsfShape_getPointCount = define_c_func(gfx,"+sfShape_getPointCount",{C_POINTER},C_SIZE_T)

public function sfShape_getPointCount(atom s)
	return c_func(xsfShape_getPointCount,{s})
end function

public constant xsfShape_getPoint = define_c_func(gfx,"+sfShape_getPoint",{C_POINTER,C_SIZE_T},sfVector2f)

public function sfShape_getPoint(atom s,atom idx)
	return c_func(xsfShape_getPoint,{s,idx})
end function

public constant xsfShape_getLocalBounds = define_c_func(gfx,"+sfShape_getLocalBounds",{C_POINTER},sfFloatRect)

public function sfShape_getLocalBounds(atom s)
	return c_func(xsfShape_getLocalBounds,{s})
end function

public constant xsfShape_getGlobalBounds = define_c_func(gfx,"+sfShape_getGlobalBounds",{C_POINTER},sfFloatRect)

public function sfShape_getGlobalBounds(atom s)
	return c_func(xsfShape_getGlobalBounds,{s})
end function

public constant xsfShape_update = define_c_proc(gfx,"+sfShape_update",{C_POINTER})

public procedure sfShape_update(atom s)
	c_proc(xsfShape_update,{s})
end procedure

--Sprite

public constant xsfSprite_create = define_c_func(gfx,"+sfSprite_create",{},C_POINTER)

public function sfSprite_create()
	return c_func(xsfSprite_create,{})
end function

public constant xsfSprite_copy = define_c_func(gfx,"+sfSprite_copy",{C_POINTER},C_POINTER)

public function sfSprite_copy(atom spr)
	return c_func(xsfSprite_copy,{spr})
end function

public constant xsfSprite_destroy = define_c_proc(gfx,"+sfSprite_destroy",{C_POINTER})

public procedure sfSprite_destroy(atom spr)
	c_proc(xsfSprite_destroy,{spr})
end procedure

public constant xsfSprite_setPosition = define_c_proc(gfx,"+sfSprite_setPosition",{C_POINTER,sfVector2f})

public procedure sfSprite_setPosition(atom spr,sequence pos)
	c_proc(xsfSprite_setPosition,{spr,pos})
end procedure

public constant xsfSprite_setRotation = define_c_proc(gfx,"+sfSprite_setRotation",{C_POINTER,C_FLOAT})

public procedure sfSprite_setRotation(atom spr,atom ang)
	c_proc(xsfSprite_setRotation,{spr,ang})
end procedure

public constant xsfSprite_setScale = define_c_proc(gfx,"+sfSprite_setScale",{C_POINTER,sfVector2f})

public procedure sfSprite_setScale(atom spr,sequence sca)
	c_proc(xsfSprite_setScale,{spr,sca})
end procedure

public constant xsfSprite_setOrigin = define_c_proc(gfx,"+sfSprite_setOrigin",{C_POINTER,sfVector2f})

public procedure sfSprite_setOrigin(atom spr,sequence ori)
	c_proc(xsfSprite_setOrigin,{spr,ori})
end procedure

public constant xsfSprite_getPosition = define_c_func(gfx,"+sfSprite_getPosition",{C_POINTER},sfVector2f)

public function sfSprite_getPosition(atom spr)
	return c_func(xsfSprite_getPosition,{spr})
end function

public constant xsfSprite_getRotation = define_c_func(gfx,"+sfSprite_getRotation",{C_POINTER},C_FLOAT)

public function sfSprite_getRotation(atom spr)
	return c_func(xsfSprite_getRotation,{spr})
end function

public constant xsfSprite_getScale = define_c_func(gfx,"+sfSprite_getScale",{C_POINTER},sfVector2f)

public function sfSprite_getScale(atom spr)
	return c_func(xsfSprite_getScale,{spr})
end function

public constant xsfSprite_getOrigin = define_c_func(gfx,"+sfSprite_getOrigin",{C_POINTER},sfVector2f)

public function sfSprite_getOrigin(atom spr)
	return c_func(xsfSprite_getOrigin,{spr})
end function

public constant xsfSprite_move = define_c_proc(gfx,"+sfSprite_move",{C_POINTER,sfVector2f})

public procedure sfSprite_move(atom spr,sequence off)
	c_proc(xsfSprite_move,{spr,off})
end procedure

public constant xsfSprite_rotate = define_c_proc(gfx,"+sfSprite_rotate",{C_POINTER,C_FLOAT})

public procedure sfSprite_rotate(atom spr,atom ang)
	c_proc(xsfSprite_rotate,{spr,ang})
end procedure

public constant xsfSprite_scale = define_c_proc(gfx,"+sfSprite_scale",{C_POINTER,sfVector2f})

public procedure sfSprite_scale(atom spr,sequence fac)
	c_proc(xsfSprite_scale,{spr,fac})
end procedure

public constant xsfSprite_getTransform = define_c_func(gfx,"+sfSprite_getTransform",{C_POINTER},sfTransform)

public function sfSprite_getTransform(atom spr)
	return c_func(xsfSprite_getTransform,{spr})
end function

public constant xsfSprite_getInverseTransform = define_c_func(gfx,"+sfSprite_getInverseTransform",{C_POINTER},sfTransform)

public function sfSprite_getInverseTransform(atom spr)
	return c_func(xsfSprite_getInverseTransform,{spr})
end function

public constant xsfSprite_setTexture = define_c_proc(gfx,"+sfSprite_setTexture",{C_POINTER,C_POINTER,C_BOOL})

public procedure sfSprite_setTexture(atom spr,atom tex,atom reset)
	c_proc(xsfSprite_setTexture,{spr,tex,reset})
end procedure

public constant xsfSprite_setTextureRect = define_c_proc(gfx,"+sfSprite_setTextureRect",{C_POINTER,sfIntRect})

public procedure sfSprite_setTextureRect(atom spr,sequence rect)
	c_proc(xsfSprite_setTextureRect,{spr,rect})
end procedure

public constant xsfSprite_setColor = define_c_proc(gfx,"+sfSprite_setColor",{C_POINTER,sfColor})

public procedure sfSprite_setColor(atom spr,sequence col)
	c_proc(xsfSprite_setColor,{spr,col})
end procedure

public constant xsfSprite_getTexture = define_c_func(gfx,"+sfSprite_getTexture",{C_POINTER},C_POINTER)

public function sfSprite_getTexture(atom spr)
	return c_func(xsfSprite_getTexture,{spr})
end function

public constant xsfSprite_getTextureRect = define_c_func(gfx,"+sfSprite_getTextureRect",{C_POINTER},sfIntRect)

public function sfSprite_getTextureRect(atom spr)
	return c_func(xsfSprite_getTextureRect,{spr})
end function

public constant xsfSprite_getColor = define_c_func(gfx,"+sfSprite_getColor",{C_POINTER},sfColor)

public function sfSprite_getColor(atom spr)
	return c_func(xsfSprite_getColor,{spr})
end function

public constant xsfSprite_getLocalBounds = define_c_func(gfx,"+sfSprite_getLocalBounds",{C_POINTER},sfFloatRect)

public function sfSprite_getLocalBounds(atom spr)
	return c_func(xsfSprite_getLocalBounds,{spr})
end function

public constant xsfSprite_getGlobalBounds = define_c_func(gfx,"+sfSprite_getGlobalBounds",{C_POINTER},sfFloatRect)

public function sfSprite_getGlobalBounds(atom spr)
	return c_func(xsfSprite_getGlobalBounds,{spr})
end function

--Text

public enum type sfTextStyle
	sfTextRegular = 0,
	sfTextBold = 1,
	sfTextItalic = 2,
	sfTextUnderlined = 4,
	sfTextStrikeThrough = 8
end type

public constant xsfText_create = define_c_func(gfx,"+sfText_create",{},C_POINTER)

public function sfText_create()
	return c_func(xsfText_create,{})
end function

public constant xsfText_copy = define_c_func(gfx,"+sfText_copy",{C_POINTER},C_POINTER)

public function sfText_copy(atom txt)
	return c_func(xsfText_copy,{txt})
end function

public constant xsfText_destroy = define_c_proc(gfx,"+sfText_destroy",{C_POINTER})

public procedure sfText_destroy(atom txt)
	c_proc(xsfText_destroy,{txt})
end procedure

public constant xsfText_setPosition = define_c_proc(gfx,"+sfText_setPosition",{C_POINTER,sfVector2f})

public procedure sfText_setPosition(atom txt,sequence pos)
	c_proc(xsfText_setPosition,{txt,pos})
end procedure

public constant xsfText_setRotation = define_c_proc(gfx,"+sfText_setRotation",{C_POINTER,C_FLOAT})

public procedure sfText_setRotation(atom txt,atom ang)
	c_proc(xsfText_setRotation,{txt,ang})
end procedure

public constant xsfText_setScale = define_c_proc(gfx,"+sfText_setScale",{C_POINTER,sfVector2f})

public procedure sfText_setScale(atom txt,sequence sca)
	c_proc(xsfText_setScale,{txt,sca})
end procedure

public constant xsfText_setOrigin = define_c_proc(gfx,"+sfText_setOrigin",{C_POINTER,sfVector2f})

public procedure sfText_setOrigin(atom txt,sequence ori)
	c_proc(xsfText_setOrigin,{txt,ori})
end procedure

public constant xsfText_getPosition = define_c_func(gfx,"+sfText_getPosition",{C_POINTER},sfVector2f)

public function sfText_getPosition(atom txt)
	return c_func(xsfText_getPosition,{txt})
end function

public constant xsfText_getRotation = define_c_func(gfx,"+sfText_getRotation",{C_POINTER},C_FLOAT)

public function sfText_getRotation(atom txt)
	return c_func(xsfText_getRotation,{txt})	
end function

public constant xsfText_getScale = define_c_func(gfx,"+sfText_getScale",{C_POINTER},sfVector2f)

public function sfText_getScale(atom txt)
	return c_func(xsfText_getScale,{txt})
end function

public constant xsfText_getOrigin = define_c_func(gfx,"+sfText_getOrigin",{C_POINTER},sfVector2f)

public function sfText_getOrigin(atom txt)
	return c_func(xsfText_getOrigin,{txt})
end function

public constant xsfText_move = define_c_proc(gfx,"+sfText_move",{C_POINTER,sfVector2f})

public procedure sfText_move(atom txt,sequence off)
	c_proc(xsfText_move,{txt,off})
end procedure

public constant xsfText_rotate = define_c_proc(gfx,"+sfText_rotate",{C_POINTER,C_FLOAT})

public procedure sfText_rotate(atom txt,atom ang)
	c_proc(xsfText_rotate,{txt,ang})
end procedure

public constant xsfText_scale = define_c_proc(gfx,"+sfText_scale",{C_POINTER,sfVector2f})

public procedure sfText_scale(atom txt,sequence fac)
	c_proc(xsfText_scale,{txt,fac})
end procedure

public constant xsfText_getTransform = define_c_func(gfx,"+sfText_getTransform",{C_POINTER},sfTransform)

public function sfText_getTransform(atom txt)
	return c_func(xsfText_getTransform,{txt})
end function

public constant xsfText_getInverseTransform = define_c_func(gfx,"+sfText_getInverseTransform",{C_POINTER},sfTransform)

public function sfText_getInverseTransform(atom txt)
	return c_func(xsfText_getInverseTransform,{txt})
end function

public constant xsfText_setString = define_c_proc(gfx,"+sfText_setString",{C_POINTER,C_STRING})

public procedure sfText_setString(atom txt,sequence str)
	c_proc(xsfText_setString,{txt,str})
end procedure

public constant xsfText_setUnicodeString = define_c_proc(gfx,"+sfText_setUnicodeString",{C_POINTER,C_POINTER})

public procedure sfText_setUnicodeString(atom txt,atom str)
	c_proc(xsfText_setUnicodeString,{txt,str})
end procedure

public constant xsfText_setFont = define_c_proc(gfx,"+sfText_setFont",{C_POINTER,C_POINTER})

public procedure sfText_setFont(atom txt,atom font)
	c_proc(xsfText_setFont,{txt,font})
end procedure

public constant xsfText_setCharacterSize = define_c_proc(gfx,"+sfText_setCharacterSize",{C_POINTER,C_UINT})

public procedure sfText_setCharacterSize(atom txt,atom size)
	c_proc(xsfText_setCharacterSize,{txt,size})
end procedure

public constant xsfText_setLineSpacing = define_c_proc(gfx,"+sfText_setLineSpacing",{C_POINTER,C_FLOAT})

public procedure sfText_setLineSpacing(atom txt,atom spaceFac)
	c_proc(xsfText_setLineSpacing,{txt,spaceFac})
end procedure

public constant xsfText_setLetterSpacing = define_c_proc(gfx,"+sfText_setLetterSpacing",{C_POINTER,C_FLOAT})

public procedure sfText_setLetterSpacing(atom txt,atom spaceFac)
	c_proc(xsfText_setLetterSpacing,{txt,spaceFac})
end procedure

public constant xsfText_setStyle = define_c_proc(gfx,"+sfText_setStyle",{C_POINTER,C_UINT32})

public procedure sfText_setStyle(atom txt,atom style)
	c_proc(xsfText_setStyle,{txt,style})
end procedure

public constant xsfText_setColor = define_c_proc(gfx,"+sfText_setColor",{C_POINTER,sfColor})

public procedure sfText_setColor(atom txt,sequence col)
	c_proc(xsfText_setColor,{txt,col})
end procedure

public constant xsfText_setFillColor = define_c_proc(gfx,"+sfText_setFillColor",{C_POINTER,sfColor})

public procedure sfText_setFillColor(atom txt,sequence col)
	c_proc(xsfText_setFillColor,{txt,col})
end procedure

public constant xsfText_setOutlineColor = define_c_proc(gfx,"+sfText_setOutlineColor",{C_POINTER,sfColor})

public procedure sfText_setOutlineColor(atom txt,sequence col)
	c_proc(xsfText_setOutlineColor,{txt,col})
end procedure

public constant xsfText_setOutlineThickness = define_c_proc(gfx,"+sfText_setOutlineThickness",{C_POINTER,C_FLOAT})

public procedure sfText_setOutlineThickness(atom txt,atom thick)
	c_proc(xsfText_setOutlineThickness,{txt,thick})
end procedure

public constant xsfText_getString = define_c_func(gfx,"+sfText_getString",{C_POINTER},C_STRING)

public function sfText_getString(atom txt)
	return c_func(xsfText_getString,{txt})
end function

public constant xsfText_getUnicodeString = define_c_func(gfx,"+sfText_getUnicodeString",{C_POINTER},C_POINTER)

public function sfText_getUnicodeString(atom txt)
	return c_func(xsfText_getUnicodeString,{txt})
end function

public constant xsfText_getFont = define_c_func(gfx,"+sfText_getFont",{C_POINTER},C_POINTER)

public function sfText_getFont(atom txt)
	return c_func(xsfText_getFont,{txt})
end function

public constant xsfText_getCharacterSize = define_c_func(gfx,"+sfText_getCharacterSize",{C_POINTER},C_UINT)

public function sfText_getCharacterSize(atom txt)
	return c_func(xsfText_getCharacterSize,{txt})
end function

public constant xsfText_getLetterSpacing = define_c_func(gfx,"+sfText_getLetterSpacing",{C_POINTER},C_FLOAT)

public function sfText_getLetterSpacing(atom txt)
	return c_func(xsfText_getLetterSpacing,{txt})
end function

public constant xsfText_getLineSpacing = define_c_func(gfx,"+sfText_getLineSpacing",{C_POINTER},C_FLOAT)

public function sfText_getLineSpacing(atom txt)
	return c_func(xsfText_getLineSpacing,{txt})
end function

public constant xsfText_getStyle = define_c_func(gfx,"+sfText_getStyle",{C_POINTER},C_UINT32)

public function sfText_getStyle(atom txt)
	return c_func(xsfText_getStyle,{txt})
end function

public constant xsfText_getColor = define_c_func(gfx,"+sfText_getColor",{C_POINTER},sfColor)

public function sfText_getColor(atom txt)
	return c_func(xsfText_getColor,{txt})
end function

public constant xsfText_getFillColor = define_c_func(gfx,"+sfText_getFillColor",{C_POINTER},sfColor)

public function sfText_getFillColor(atom txt)
	return c_func(xsfText_getFillColor,{txt})
end function

public constant xsfText_getOutlineColor = define_c_func(gfx,"+sfText_getOutlineColor",{C_POINTER},sfColor)

public function sfText_getOutlineColor(atom txt)
	return c_func(xsfText_getOutlineColor,{txt})
end function

public constant xsfText_getOutlineThickness = define_c_func(gfx,"+sfText_getOutlineThickness",{C_POINTER},C_FLOAT)

public function sfText_getOutlineThickness(atom txt)
	return c_func(xsfText_getOutlineThickness,{txt})
end function

public constant xsfText_findCharacterPos = define_c_func(gfx,"+sfText_findCharacterPos",{C_POINTER,C_SIZE_T},sfVector2f)

public function sfText_findCharacterPos(atom txt,atom idx)
	return c_func(xsfText_findCharacterPos,{txt,idx})
end function

public constant xsfText_getLocalBounds = define_c_func(gfx,"+sfText_getLocalBounds",{C_POINTER},sfFloatRect)

public function sfText_getLocalBounds(atom txt)
	return c_func(xsfText_getLocalBounds,{txt})
end function

public constant xsfText_getGlobalBounds = define_c_func(gfx,"+sfText_getGlobalBounds",{C_POINTER},sfFloatRect)

public function sfText_getGlobalBounds(atom txt)
	return c_func(xsfText_getGlobalBounds,{txt})
end function

--Texture

public enum type sfTextureCoordinateType
	sfTextureNormalized = 0,
	sfTexturePixels
end type

public constant xsfTexture_create = define_c_func(gfx,"+sfTexture_create",{C_UINT,C_UINT},C_POINTER)

public function sfTexture_create(atom w,atom h)
	return c_func(xsfTexture_create,{w,h})
end function

public constant xsfTexture_createFromFile = define_c_func(gfx,"+sfTexture_createFromFile",{C_STRING,C_POINTER},C_POINTER)

public function sfTexture_createFromFile(sequence fname,atom area)
	return c_func(xsfTexture_createFromFile,{fname,area})
end function

public constant xsfTexture_createSrgbFromFile = define_c_func(gfx,"+sfTexture_createSrgbFromFile",{C_STRING,C_POINTER},C_POINTER)

public function sfTexture_createSrgbFromFile(sequence fname,atom area)
	return c_func(xsfTexture_createSrgbFromFile,{fname,area})
end function

public constant xsfTexture_createFromMemory = define_c_func(gfx,"+sfTexture_createFromMemory",{C_POINTER,C_SIZE_T,C_POINTER},C_POINTER)

public function sfTexture_createFromMemory(atom data,atom size,atom area)
	return c_func(xsfTexture_createFromMemory,{data,size,area})
end function

public constant xsfTexture_createSrgbFromMemory = define_c_func(gfx,"+sfTexture_createSrgbFromMemory",{C_POINTER,C_SIZE_T,C_POINTER},C_POINTER)

public function sfTexture_createSrgbFromMemory(atom data,atom size,atom area)
	return c_func(xsfTexture_createSrgbFromMemory,{data,size,area})
end function

public constant xsfTexture_createFromStream = define_c_func(gfx,"+sfTexture_createFromStream",{C_POINTER,C_POINTER},C_POINTER)

public function sfTexture_createFromStream(atom stream,atom area)
	return c_func(xsfTexture_createFromStream,{stream,area})
end function

public constant xsfTexture_createSrgbFromStream = define_c_func(gfx,"+sfTexture_createSrgbFromStream",{C_POINTER,C_POINTER},C_POINTER)

public function sfTexture_createSrgbFromStream(atom stream,atom area)
	return c_func(xsfTexture_createSrgbFromStream,{stream,area})
end function

public constant xsfTexture_createFromImage = define_c_func(gfx,"+sfTexture_createFromImage",{C_POINTER,C_POINTER},C_POINTER)

public function sfTexture_createFromImage(atom img,atom area)
	return c_func(xsfTexture_createFromImage,{img,area})
end function

public constant xsfTexture_createSrgbFromImage = define_c_func(gfx,"+sfTexture_createSrgbFromImage",{C_POINTER,C_POINTER},C_POINTER)

public function sfTexture_createSrgbFromImage(atom img,atom area)
	return c_func(xsfTexture_createSrgbFromImage,{img,area})
end function

public constant xsfTexture_copy = define_c_func(gfx,"+sfTexture_copy",{C_POINTER},C_POINTER)

public function sfTexture_copy(atom tex)
	return c_func(xsfTexture_copy,{tex})
end function

public constant xsfTexture_destroy = define_c_proc(gfx,"+sfTexture_destroy",{C_POINTER})

public procedure sfTexture_destroy(atom tex)
	c_proc(xsfTexture_destroy,{tex})
end procedure

public constant xsfTexture_getSize = define_c_func(gfx,"+sfTexture_getSize",{C_POINTER},sfVector2u)

public function sfTexture_getSize(atom tex)
	return c_func(xsfTexture_getSize,{tex})
end function

public constant xsfTexture_copyToImage = define_c_func(gfx,"+sfTexture_copyToImage",{C_POINTER},C_POINTER)

public function sfTexture_copyToImage(atom tex)
	return c_func(xsfTexture_copyToImage,{tex})
end function

public constant xsfTexture_updateFromPixels = define_c_proc(gfx,"+sfTexture_updateFromPixels",{C_POINTER,C_POINTER,C_UINT,C_UINT,C_UINT,C_UINT})

public procedure sfTexture_updateFromPixels(atom tex,atom pix,atom w,atom h,atom x,atom y)
	c_proc(xsfTexture_updateFromPixels,{tex,pix,w,h,x,y})
end procedure

public constant xsfTexture_updateFromTexture = define_c_proc(gfx,"+sfTexture_updateFromTexture",{C_POINTER,C_POINTER,C_UINT,C_UINT})

public procedure sfTexture_updateFromTexture(atom destTex,atom srcTex,atom x,atom y)
	c_proc(xsfTexture_updateFromTexture,{destTex,srcTex,x,y})
end procedure

public constant xsfTexture_updateFromImage = define_c_proc(gfx,"+sfTexture_updateFromimage",{C_POINTER,C_POINTER,C_UINT,C_UINT})

public procedure sfTexture_updateFromImage(atom tex,atom img,atom x,atom y)
	c_proc(xsfTexture_updateFromImage,{tex,img,x,y})
end procedure

public constant xsfTexture_updateFromWindow = define_c_proc(gfx,"+sfTexture_updateFromWindow",{C_POINTER,C_POINTER,C_UINT,C_UINT})

public procedure sfTexture_updateFromWindow(atom tex,atom win,atom x,atom y)
	c_proc(xsfTexture_updateFromWindow,{tex,win,x,y})
end procedure

public constant xsfTexture_updateFromRenderWindow = define_c_proc(gfx,"+sfTexture_updateFromRenderWindow",{C_POINTER,C_POINTER,C_UINT,C_UINT})

public procedure sfTexture_updateFromRenderWindow(atom tex,atom win,atom x,atom y)
	c_proc(xsfTexture_updateFromRenderWindow,{tex,win,x,y})
end procedure

public constant xsfTexture_setSmooth = define_c_proc(gfx,"+sfTexture_setSmooth",{C_POINTER,C_BOOL})

public procedure sfTexture_setSmooth(atom tex,atom smth)
	c_proc(xsfTexture_setSmooth,{tex,smth})
end procedure

public constant xsfTexture_isSmooth = define_c_func(gfx,"+sfTexture_isSmooth",{C_POINTER},C_BOOL)

public function sfTexture_isSmooth(atom tex)
	return c_func(xsfTexture_isSmooth,{tex})
end function

public constant xsfTexture_isSrgb = define_c_func(gfx,"+sfTexture_isSrgb",{C_POINTER},C_BOOL)

public function sfTexture_isSrgb(atom tex)
	return c_func(xsfTexture_isSrgb,{tex})
end function

public constant xsfTexture_setRepeated = define_c_proc(gfx,"+sfTexture_setRepeated",{C_POINTER,C_BOOL})

public procedure sfTexture_setRepeated(atom tex,atom rep)
	c_proc(xsfTexture_setRepeated,{tex,rep})
end procedure

public constant xsfTexture_isRepeated = define_c_func(gfx,"+sfTexture_isRepeated",{C_POINTER},C_BOOL)

public function sfTexture_isRepeated(atom tex)
	return c_func(xsfTexture_isRepeated,{tex})
end function

public constant xsfTexture_generateMipmap = define_c_func(gfx,"+sfTexture_generateMipmap",{C_POINTER},C_BOOL)

public function sfTexture_generateMipmap(atom tex)
	return c_func(xsfTexture_generateMipmap,{tex})
end function

public constant xsfTexture_swap = define_c_proc(gfx,"+sfTexture_swap",{C_POINTER,C_POINTER})

public procedure sfTexture_swap(atom left,atom right)
	c_proc(xsfTexture_swap,{left,right})
end procedure

public constant xsfTexture_getNativeHandle = define_c_func(gfx,"+sfTexture_getNativeHandle",{C_POINTER},C_UINT)

public function sfTexture_getNativeHandle(atom tex)
	return c_func(xsfTexture_getNativeHandle,{tex})
end function

public constant xsfTexture_bind = define_c_proc(gfx,"+sfTexture_bind",{C_POINTER,C_INT})

public procedure sfTexture_bind(atom tex,sfTextureCoordinateType t)
	c_proc(xsfTexture_bind,{tex,t})
end procedure

public constant xsfTexture_getMaximumSize = define_c_func(gfx,"+sfTexture_getMaximumSize",{},C_UINT)

public function sfTexture_getMaximumSize()
	return c_func(xsfTexture_getMaximumSize,{})
end function

--Transformable

public constant xsfTransformable_create = define_c_func(gfx,"+sfTransformable_create",{},C_POINTER)

public function sfTransformable_create()
	return c_func(xsfTransformable_create,{})
end function

public constant xsfTransformable_copy = define_c_func(gfx,"+sfTransformable_copy",{C_POINTER},C_POINTER)

public function sfTransformable_copy(atom trans)
	return c_func(xsfTransformable_copy,{trans})
end function

public constant xsfTransformable_destroy = define_c_proc(gfx,"+sfTransformable_destroy",{C_POINTER})

public procedure sfTransformable_destroy(atom trans)
	c_proc(xsfTransformable_destroy,{trans})
end procedure

public constant xsfTransformable_setPosition = define_c_proc(gfx,"+sfTransformable_setPosition",{C_POINTER,sfVector2f})

public procedure sfTransformable_setPosition(atom trans,sequence pos)
	c_proc(xsfTransformable_setPosition,{trans,pos})
end procedure

public constant xsfTransformable_setRotation = define_c_proc(gfx,"+sfTransformable_setRotation",{C_POINTER,C_FLOAT})

public procedure sfTransformable_setRotation(atom trans,atom ang)
	c_proc(xsfTransformable_setRotation,{trans,ang})
end procedure

public constant xsfTransformable_setScale = define_c_proc(gfx,"+sfTransformable_setScale",{C_POINTER,sfVector2f})

public procedure sfTransformable_setScale(atom trans,sequence sca)
	c_proc(xsfTransformable_setScale,{trans,sca})
end procedure

public constant xsfTransformable_setOrigin = define_c_proc(gfx,"+sfTransformable_setOrigin",{C_POINTER,sfVector2f})

public procedure sfTransformable_setOrigin(atom trans,sequence ori)
	c_proc(xsfTransformable_setOrigin,{trans,ori})
end procedure

public constant xsfTransformable_getPosition = define_c_func(gfx,"+sfTransformable_getPosition",{C_POINTER},sfVector2f)

public function sfTransformable_getPosition(atom trans)
	return c_func(xsfTransformable_getPosition,{trans})
end function

public constant xsfTransformable_getRotation = define_c_func(gfx,"+sfTransformable_getRotation",{C_POINTER},C_FLOAT)

public function sfTransformable_getRotation(atom trans)
	return c_func(xsfTransformable_getRotation,{trans})
end function

public constant xsfTransformable_getScale = define_c_func(gfx,"+sfTransformable_getScale",{C_POINTER},sfVector2f)

public function sfTransformable_getScale(atom trans)
	return c_func(xsfTransformable_getScale,{trans})
end function

public constant xsfTransformable_getOrigin = define_c_func(gfx,"+sfTransformable_getOrigin",{C_POINTER},sfVector2f)

public function sfTransformable_getOrigin(atom trans)
	return c_func(xsfTransformable_getOrigin,{trans})
end function

public constant xsfTransformable_move = define_c_proc(gfx,"+sfTransformable_move",{C_POINTER,sfVector2f})

public procedure sfTransformable_move(atom trans,sequence off)
	c_proc(xsfTransformable_move,{trans,off})
end procedure

public constant xsfTransformable_rotate = define_c_proc(gfx,"+sfTransformable_rotate",{C_POINTER,C_FLOAT})

public procedure sfTransformable_rotate(atom trans,atom ang)
	c_proc(xsfTransformable_rotate,{trans,ang})
end procedure

public constant xsfTransformable_scale = define_c_proc(gfx,"+sfTransformable_scale",{C_POINTER,sfVector2f})

public procedure sfTransformable_scale(atom trans,sequence fac)
	c_proc(xsfTransformable_scale,{trans,fac})
end procedure

public constant xsfTransformable_getTransform = define_c_func(gfx,"+sfTransformable_getTransform",{C_POINTER},sfTransform)

public function sfTransformable_getTransform(atom trans)
	return c_func(xsfTransformable_getTransform,{trans})
end function

public constant xsfTransformable_getInverseTransform = define_c_func(gfx,"+sfTransformable_getInverseTransform",{C_POINTER},sfTransform)

public function sfTransformable_getInverseTransform(atom trans)
	return c_func(xsfTransformable_getInverseTransform,{trans})
end function

--Vertex

public constant sfVertex = define_c_struct({
	sfVector2f, --position
	sfColor, --color
	sfVector2f --texCoords
})

--VertexArray

public constant xsfVertexArray_create = define_c_func(gfx,"+sfVertexArray_create",{},C_POINTER)

public function sfVertexArray_create()
	return c_func(xsfVertexArray_create,{})
end function

public constant xsfVertexArray_copy = define_c_func(gfx,"+sfVertexArray_copy",{C_POINTER},C_POINTER)

public function sfVertexArray_copy(atom va)
	return c_func(xsfVertexArray_copy,{va})
end function

public constant xsfVertexArray_destroy = define_c_proc(gfx,"+sfVertexArray_destroy",{C_POINTER})

public procedure sfVertexArray_destroy(atom va)
	c_proc(xsfVertexArray_destroy,{va})
end procedure

public constant xsfVertexArray_getVertexCount = define_c_func(gfx,"+sfVertexArray_getVertexCount",{C_POINTER},C_SIZE_T)

public function sfVertexArray_getVertexCount(atom va)
	return c_func(xsfVertexArray_getVertexCount,{va})
end function

public constant xsfVertexArray_getVertex = define_c_func(gfx,"+sfVertexArray_getVertex",{C_POINTER,C_SIZE_T},C_POINTER)

public function sfVertexArray_getVertex(atom va,atom idx)
	return c_func(xsfVertexArray_getVertex,{va,idx})
end function

public constant xsfVertexArray_clear = define_c_proc(gfx,"+sfVertexArray_clear",{C_POINTER})

public procedure sfVertexArray_clear(atom va)
	c_proc(xsfVertexArray_clear,{va})
end procedure

public constant xsfVertexArray_resize = define_c_proc(gfx,"+sfVertexArray_resize",{C_POINTER,C_SIZE_T})

public procedure sfVertexArray_resize(atom va,atom cnt)
	c_proc(xsfVertexArray_resize,{va,cnt})
end procedure

public constant xsfVertexArray_append = define_c_proc(gfx,"+sfVertexArray_append",{C_POINTER,sfVertex})

public procedure sfVertexArray_append(atom va,sequence vertex)
	c_proc(xsfVertexArray_append,{va,vertex})
end procedure

public constant xsfVertexArray_setPrimitiveType = define_c_proc(gfx,"+sfVertexArray_setPrimitiveType",{C_POINTER,C_INT})

public procedure sfVertexArray_setPrimitiveType(atom va,atom t)
	c_proc(xsfVertexArray_setPrimitiveType,{va,t})
end procedure

public constant xsfVertexArray_getPrimitiveType = define_c_func(gfx,"+sfVertexArray_getPrimitiveType",{C_POINTER},C_INT)

public function sfVertexArray_getPrimitiveType(atom va)
	return c_func(xsfVertexArray_getPrimitiveType,{va})
end function

public constant xsfVertexArray_getBounds = define_c_func(gfx,"+sfVertexArray_getBounds",{C_POINTER},sfFloatRect)

public function sfVertexArray_getBounds(atom va)
	return c_func(xsfVertexArray_getBounds,{va})
end function

--VertexBuffer

public enum type sfVertexBufferUsage
	sfVertexBufferStream = 0,
	sfVertexBufferDynamic,
	sfVertexBufferStatic
end type

public constant xsfVertexBuffer_create = define_c_func(gfx,"+sfVertexBuffer_create",{C_UINT,C_INT,C_INT},C_POINTER)

public function sfVertexBuffer_create(atom cnt,atom t,sfVertexBufferUsage u)
	return c_func(xsfVertexBuffer_create,{cnt,t,u})
end function

public constant xsfVertexBuffer_copy = define_c_func(gfx,"+sfVertexBuffer_copy",{C_POINTER},C_POINTER)

public function sfVertexBuffer_copy(atom vb)
	return c_func(xsfVertexBuffer_copy,{vb})
end function

public constant xsfVertexBuffer_destroy = define_c_proc(gfx,"+sfVertexBuffer_destroy",{C_POINTER})

public procedure sfVertexBuffer_destroy(atom vb)
	c_proc(xsfVertexBuffer_destroy,{vb})
end procedure

public constant xsfVertexBuffer_getVertexCount = define_c_func(gfx,"+sfVertexBuffer_getVertexCount",{C_POINTER},C_UINT)

public function sfVertexBuffer_getVertexCount(atom vb)
	return c_func(xsfVertexBuffer_getVertexCount,{vb})
end function

public constant xsfVertexBuffer_update = define_c_func(gfx,"+sfVertexBuffer_update",{C_POINTER,C_POINTER,C_UINT,C_UINT},C_BOOL)

public function sfVertexBuffer_update(atom vb,atom verts,atom cnt,atom off)
	return c_func(xsfVertexBuffer_update,{vb,verts,cnt,off})
end function

public constant xsfVertexBuffer_updateFromVertexBuffer = define_c_func(gfx,"+sfVertexBuffer_updateFromVertexBuffer",{C_POINTER,C_POINTER},C_BOOL)

public function sfVertexBuffer_updateFromVertexBuffer(atom vb,atom oth)
	return c_func(xsfVertexBuffer_updateFromVertexBuffer,{vb,oth})
end function

public constant xsfVertexBuffer_swap = define_c_proc(gfx,"+sfVertexBuffer_swap",{C_POINTER,C_POINTER})

public procedure sfVertexBuffer_swap(atom l,atom r)
	c_proc(xsfVertexBuffer_swap,{l,r})
end procedure

public constant xsfVertexBuffer_getNativeHandle = define_c_func(gfx,"+sfVertexBuffer_getNativeHandle",{C_POINTER},C_UINT)

public function sfVertexBuffer_getNativeHandle(atom vb)
	return c_func(xsfVertexBuffer_getNativeHandle,{vb})
end function

public constant xsfVertexBuffer_setPrimitiveType = define_c_proc(gfx,"+sfVertexBuffer_setPrimitiveType",{C_POINTER,C_INT})

public procedure sfVertexBuffer_setPrimitiveType(atom vb,atom t)
	c_proc(xsfVertexBuffer_setPrimitiveType,{vb,t})
end procedure

public constant xsfVertexBuffer_getPrimitiveType = define_c_func(gfx,"+sfVertexBuffer_getPrimitiveType",{C_POINTER},C_INT)

public function sfVertexBuffer_getPrimitiveType(atom vb)
	return c_func(xsfVertexBuffer_getPrimitiveType,{vb})
end function

public constant xsfVertexBuffer_setUsage = define_c_proc(gfx,"+sfVertexBuffer_setUsage",{C_POINTER,C_INT})

public procedure sfVertexBuffer_setUsage(atom vb,sfVertexBufferUsage u)
	c_proc(xsfVertexBuffer_setUsage,{vb,u})
end procedure

public constant xsfVertexBuffer_getUsage = define_c_func(gfx,"+sfVertexBuffer_getUsage",{C_POINTER},C_INT)

public function sfVertexBuffer_getUsage(atom vb)
	return c_func(xsfVertexBuffer_getUsage,{vb})
end function

public constant xsfVertexBuffer_bind = define_c_proc(gfx,"+sfVertexBuffer_bind",{C_POINTER})

public procedure sfVertexBuffer_bind(atom vb)
	c_proc(xsfVertexBuffer_bind,{vb})
end procedure

public constant xsfVertexBuffer_isAvailable = define_c_func(gfx,"+sfVertexBuffer_isAvailable",{},C_BOOL)

public function sfVertexBuffer_isAvailable()
	return c_func(xsfVertexBuffer_isAvailable,{})
end function

--View

public constant xsfView_create = define_c_func(gfx,"+sfView_create",{},C_POINTER)

public function sfView_create()
	return c_func(xsfView_create,{})
end function

public constant xsfView_createFromRect = define_c_func(gfx,"+sfView_createFromRect",{sfFloatRect},C_POINTER)

public function sfView_createFromRect(sequence rect)
	return c_func(xsfView_createFromRect,{rect})
end function

public constant xsfView_copy = define_c_func(gfx,"+sfView_copy",{C_POINTER},C_POINTER)

public function sfView_copy(atom v)
	return c_func(xsfView_copy,{v})
end function

public constant xsfView_destroy = define_c_proc(gfx,"+sfView_destroy",{C_POINTER})

public procedure sfView_destroy(atom v)
	c_proc(xsfView_destroy,{v})
end procedure

public constant xsfView_setCenter = define_c_proc(gfx,"+sfView_setCenter",{C_POINTER,sfVector2f})

public procedure sfView_setCenter(atom v,sequence cent)
	c_proc(xsfView_setCenter,{v,cent})
end procedure

public constant xsfView_setSize = define_c_proc(gfx,"+sfView_setSize",{C_POINTER,sfVector2f})

public procedure sfView_setSize(atom v,sequence size)
	c_proc(xsfView_setSize,{v,size})
end procedure

public constant xsfView_setRotation = define_c_proc(gfx,"+sfView_setRotation",{C_POINTER,C_FLOAT})

public procedure sfView_setRotation(atom v,atom ang)
	c_proc(xsfView_setRotation,{v,ang})
end procedure

public constant xsfView_setViewport = define_c_proc(gfx,"+sfView_setViewport",{C_POINTER,sfFloatRect})

public procedure sfView_setViewport(atom v,sequence vp)
	c_proc(xsfView_setViewport,{v,vp})
end procedure

public constant xsfView_reset = define_c_proc(gfx,"+sfView_reset",{C_POINTER,sfFloatRect})

public procedure sfView_reset(atom v,sequence r)
	c_proc(xsfView_reset,{v,r})
end procedure

public constant xsfView_getCenter = define_c_func(gfx,"+sfView_getCenter",{C_POINTER},sfVector2f)

public function sfView_getCenter(atom v)
	return c_func(xsfView_getCenter,{v})
end function

public constant xsfView_getSize = define_c_func(gfx,"+sfView_getSize",{C_POINTER},sfVector2f)

public function sfView_getSize(atom v)
	return c_func(xsfView_getSize,{v})
end function

public constant xsfView_getRotation = define_c_func(gfx,"+sfView_getRotation",{C_POINTER},C_FLOAT)

public function sfView_getRotation(atom v)
	return c_func(xsfView_getRotation,{v})
end function

public constant xsfView_getViewport = define_c_func(gfx,"+sfView_getViewport",{C_POINTER},sfFloatRect)

public function sfView_getViewport(atom v)
	return c_func(xsfView_getViewport,{v})
end function

public constant xsfView_move = define_c_proc(gfx,"+sfView_move",{C_POINTER,sfVector2f})

public procedure sfView_move(atom v,sequence off)
	c_proc(xsfView_move,{v,off})
end procedure

public constant xsfView_rotate = define_c_proc(gfx,"+sfView_rotate",{C_POINTER,C_FLOAT})

public procedure sfView_rotate(atom v,atom ang)
	c_proc(xsfView_rotate,{v,ang})
end procedure

public constant xsfView_zoom = define_c_proc(gfx,"+sfView_zoom",{C_POINTER,C_FLOAT})

public procedure sfView_zoom(atom v,atom fac)
	c_proc(xsfView_zoom,{v,fac})
end procedure
­109.2