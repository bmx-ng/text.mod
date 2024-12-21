SuperStrict

Import Text.Expat

Import "source.bmx"

Extern

	Function gvContext:Byte Ptr()
	Function bmx_gvc_new:Byte Ptr()
	Function gvFreeContext(handle:Byte Ptr)


	Function agmemread:Byte Ptr(text:Byte Ptr)
	Function agisdirected:Int(g:Byte Ptr)
	Function agisundirected:Int(g:Byte Ptr)
	Function agisstrict:Int(g:Byte Ptr)
	Function agissimple:Int(g:Byte Ptr)

	Function bmx_graphviz_unflatten(g:Byte Ptr, doFans:Int, maxMinlen:Int, chainLimit:Int)

	Function gvLayout:Int(gvc:Byte Ptr, g:Byte Ptr, layout:Byte Ptr)

	Function gvRenderData:Int(gvc:Byte Ptr, g:Byte Ptr, format:Byte Ptr, data:Byte Ptr Ptr, length:UInt Var)
	Function gvFreeRenderData(data:Byte Ptr)
End Extern
