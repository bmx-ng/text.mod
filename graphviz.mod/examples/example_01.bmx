SuperStrict

Framework brl.standardio
Import text.graphviz

Local gvc:TGVGraphviz = New TGVGraphviz

Local dot:String = """
	digraph G {Hello->World}
	"""

Local graph:TAGraph = TAGraph.FromString(dot)

If graph
	Local res:Int = gvc.Layout(graph, "dot")
	Print "Layout result: " + res
End If

Local svg:String = gvc.ToSvg(graph)

Print svg
