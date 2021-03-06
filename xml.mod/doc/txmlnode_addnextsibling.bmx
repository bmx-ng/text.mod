SuperStrict

Framework Text.xml

Local doc:TxmlDoc = TxmlDoc.parseFile("attributes.xml")

If doc Then

	Local node:TxmlNode = TxmlNode(doc.getRootElement().getFirstChild())

	' a new node for the document
	Local newNode:TxmlNode = TxmlNode.newNode("cd")
	newNode.addAttribute("title", "Together Alone")
	newNode.addAttribute("artist", "Crowded House")
	newNode.addChild("country", "NZ")
	
	' add new node to document as sibling of node.
	node.addNextSibling(newNode)

	' output the document to stdout
	doc.saveFile("-")
End If
