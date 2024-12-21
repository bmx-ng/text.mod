SuperStrict

Rem
bbdoc: Text / Graphviz
End Rem
Module Text.Graphviz

ModuleInfo "Version: 1.00"
ModuleInfo "License: Eclipse Public License 1.0"
ModuleInfo "Copyright: AT&T Research"
ModuleInfo "Copyright: Wrapper - 2024 Bruce A Henderson"

ModuleInfo "History: 1.00 Initial Release"
ModuleInfo "History: Graphviz 12.2.1"

Import "common.bmx"

'
' Renamed tree_map() to gv_tree_map() to avoid conflict with BlitzMax's tree_map() function.
'

Rem
bbdoc: A Graphviz context.
about: 
End Rem
Type TGVGraphviz

	Field gvcPtr:Byte Ptr

	Method New()
		gvcPtr = bmx_gvc_new()
	End Method

	Rem
	bbdoc: Lays out the graph.
	End Rem
	Method Layout:Int(graph:TAGraph, layout:String)
		Local res:Int = -1
		If gvcPtr Then
			Local t:Byte Ptr = layout.ToUtf8String()
			res = gvLayout(gvcPtr, graph.graphPtr, t)
			MemFree(t)
		End If
		Return res
	End Method

	Rem
	bbdoc: Converts the graph to SVG.
	End Rem
	Method ToSvg:String(graph:TAGraph)
		Return RenderToString(graph, "svg")
	End Method

	Rem
	bbdoc: Produces output in the DOT language.
	about: It reproduces the input, along with layout information for the graph. In particular, a bb attribute is attached to the graph,
	specifying the bounding box of the drawing. If the graph has a label, its position is specified by the lp attribute.

	Each node gets pos, width and the record rectangles are given in the rects attribute. If the node is a polygon and the vertices
	attribute is defined, this attribute contains the vertices of the node.

	Every edge is assigned a pos attribute, and if the edge has a label, the label position is given in lp.
	End Rem
	Method ToDot:String(graph:TAGraph)
		Return RenderToString(graph, "dot")
	End Method

	Rem
	bbdoc: Produces output in the DOT language.
	about: It extends the @dot format by providing much more detailed information about how graph components are drawn.
	It relies on additional attributes for nodes, edges and graphs.
	End Rem
	Method ToXDot:String(graph:TAGraph)
		Return RenderToString(graph, "xdot")
	End Method

	Rem
	bbdoc: Produces a pretty printed version of the input, with no layout performed.
	End Rem
	Method Prettify:String(graph:TAGraph)
		Return RenderToString(graph, "canon")
	End Method

	Rem
	bbdoc: Produces output in JSON format that contains the same information produced by #ToDot
	about: Assumes the graph has been processed by one of the layout algorithms.
	End Rem
	Method ToJson0:String(graph:TAGraph)
		Return RenderToString(graph, "json0")
	End Method

	Rem
	bbdoc: Produces output in JSON format that contains the same information produced by #ToXDot
	about: Assumes the graph has been processed by one of the layout algorithms.
	End Rem
	Method ToJson:String(graph:TAGraph)
		Return RenderToString(graph, "json")
	End Method

	Rem
	bbdoc: Produces JSON output similar to #ToJson0, except it only uses the content of the graph on input.
	about: Does not assume that the graph has been processed by any layout algorithm, and the only xdot information appearing in the
	output was in the original input file.
	End Rem
	Method ToDotJson:String(graph:TAGraph)
		Return RenderToString(graph, "dot_json")
	End Method

	Rem
	bbdoc: Produces JSON output similar to #ToJson, except it only uses the content of the graph on input.
	about: Does not assume that the graph has been processed by any layout algorithm, and the only xdot information appearing in the
	output was in the original input file.
	End Rem
	Method ToXDotJson:String(graph:TAGraph)
		Return RenderToString(graph, "xdot_json")
	End Method

	Rem
	bbdoc: Produces output using a simple, line-based language.
	End Rem
	Method ToPlain:String(graph:TAGraph)
		Return RenderToString(graph, "plain")
	End Method

	Rem
	bbdoc: Produces output using a simple, line-based language.
	about: On edges, it also provides port names on head and tail nodes when applicable.
	see https://graphviz.org/docs/outputs/plain/
	End Rem
	Method ToPlainExt:String(graph:TAGraph)
		Return RenderToString(graph, "plain-ext")
	End Method

	Rem
	bbdoc: Produces output in the form of a text string.
	about: The output is in the format specified by @format.

	Note that this method assumes the specified format is a text-based format.
	End Rem
	Method RenderToString:String(graph:TAGraph, format:String)
		Local res:Int
		If gvcPtr Then
			Local s:Byte Ptr
			Local length:UInt
			Local t:Byte Ptr = format.ToUtf8String()
			res = gvRenderData(gvcPtr, graph.graphPtr, t, Varptr s, length)
			MemFree(t)

			If res <> 0 Then
				Return Null
			End If

			Local render:String = String.FromUTF8Bytes(s, length)

			gvFreeRenderData(s)

			Return render
		End If

		Return Null
	End Method

	Rem
	bbdoc: Frees the context.
	End Rem
	Method Free()
		If gvcPtr
			gvFreeContext(gvcPtr)
			gvcPtr = Null
		End If
	End Method

	Method Delete()
		Free()
	End Method

End Type

Rem
bbdoc: A Graphviz graph.
about: A graph is the fundamental data structure representing a set of nodes 
and the connections (edges) between them. It may be directed or undirected, and 
can contain attributes that influence layout, style, and labeling. In addition to 
nodes and edges, graphs can also include subgraphs and clusters to group related 
elements, helping to produce clear and visually informative diagrams when rendered 
by Graphviz.
End Rem
Type TAGraph

	Field graphPtr:Byte Ptr

	Rem
	bbdoc: Creates a new graph from a string.
	about: @text is the string representation of the graph.
	End Rem
	Function FromString:TAGraph(text:String)
		Local g:TAGraph = New TAGraph
		Local t:Byte Ptr = text.ToUtf8String()
		g.graphPtr = agmemread(t)
		MemFree(t)
		If Not g.graphPtr Then
			Return Null
		End If
		Return g
	End Function

	Rem
	bbdoc: Returns #True if the graph is directed.
	End Rem
	Method IsDirected:Int()
		If graphPtr
			Return agisdirected(graphPtr)
		End If
		Return False
	End Method

	Rem
	bbdoc: Returns #True if the graph is undirected.
	End Rem
	Method IsUndirected:Int()
		If graphPtr
			Return agisundirected(graphPtr)
		End If
		Return False
	End Method

	Rem
	bbdoc: Returns #True if the graph is a strict graph.
	End Rem
	Method IsStrict:Int()
		If graphPtr
			Return agisstrict(graphPtr)
		End If
		Return False
	End Method

	Rem
	bbdoc: Returns #True if the graph is strict with no loops.
	End Rem
	Method IsSimple:Int()
		If graphPtr
			Return agissimple(graphPtr)
		End If
		Return False
	End Method

	Rem
	bbdoc: Used to improve the aspect ratio of graphs having many leaves or disconnected nodes.
	about: The usual layout for such a graph is generally very wide or tall.
	Unflatten inserts invisible edges or adjusts the minlen on edges to improve layout compaction.
	End Rem
	Method Unflatten(maxMinlen:Int = 0, doFans:Int = False, chainLimit:Int = 0)
		If graphPtr
			bmx_graphviz_unflatten(graphPtr, doFans, maxMinlen, chainLimit)
		End If
	End Method

End Type
