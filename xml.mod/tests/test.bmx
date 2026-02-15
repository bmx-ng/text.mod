SuperStrict

Framework brl.standardio
Import Text.XML
Import BRL.MaxUnit
Import BRL.Random
Import BRL.ByteArrayStream

New TTestSuite.run()

Type TXmlTest Extends TTest

	Global BASIC_XML:String = """
		<book>
			<title>Animal Farm</title>
			<author>George Orwell</author>
			<year>1945</year>
		</book>
		"""

	Global BASIC_XML_WITH_DECLARATION:String = """
		<?xml version="1.0" encoding="UTF-8"?>
		<book>
			<title>Animal Farm</title>
			<author>George Orwell</author>
			<year>1945</year>
		</book>
		"""

	Method testGetRootElement_withoutDeclaration() {test}

		Local doc:TXmlDoc = TXmlDoc.readDoc(BASIC_XML)

		Local root:TXmlNode = doc.getRootElement()

		AssertEquals("book", root.getName())

		doc.Free()
	End Method

	Method testGetRootElement_withDeclaration() {test}

		Local doc:TXmlDoc = TXmlDoc.readDoc(BASIC_XML_WITH_DECLARATION)

		Local root:TXmlNode = doc.getRootElement()

		AssertEquals("book", root.getName())

		doc.Free()
	End Method

	Method testSetRootElement_withoutDeclaration() {test}

		Local doc:TXmlDoc = TXmlDoc.readDoc(BASIC_XML)

		Local root:TXmlNode = doc.getRootElement()

		Local newRoot:TXmlNode = TXmlNode.newNode("newRoot")

		Local oldRoot:TxmlNode = doc.setRootElement(newRoot)

		root = doc.getRootElement()

		AssertEquals("book", oldRoot.getName())
		AssertEquals("newRoot", root.getName())

		oldRoot.Free()
		doc.Free()
	End Method

	Method testSetRootElement_withDeclaration() {test}

		Local doc:TXmlDoc = TXmlDoc.readDoc(BASIC_XML_WITH_DECLARATION)

		Local root:TXmlNode = doc.getRootElement()

		Local newRoot:TXmlNode = TXmlNode.newNode("newRoot")

		Local oldRoot:TxmlNode = doc.setRootElement(newRoot)

		root = doc.getRootElement()

		AssertEquals("book", oldRoot.getName())
		AssertEquals("newRoot", root.getName())

		oldRoot.Free()
		doc.Free()
	End Method

	Method testToString() {test}

		Local doc:TXmlDoc = TXmlDoc.readDoc(BASIC_XML)

		AssertEquals("""
		<?xml version="1.0" encoding="utf-8"?><book>
			<title>Animal Farm</title>
			<author>George Orwell</author>
			<year>1945</year>
		</book>
		""", doc.ToString())

		doc.Free()
	End Method

	Method testSetContent_Elements() {test}

		Local doc:TXmlDoc = TXmlDoc.readDoc("""
		<parent>
    		<child>Text Content</child>
			Middle
    		<child2>Another Text</child2>
		</parent>
		""")

		Local root:TXmlNode = doc.getRootElement()

		root.setContent("New Content")

		AssertEquals("""
		<?xml version="1.0" encoding="utf-8"?><parent><child>Text Content</child><child2>Another Text</child2>New Content</parent>
		""", doc.ToString())

		doc.Free()
	End Method

	Method testSetContent_TextElementComment() {test}

		Local doc:TXmlDoc = TXmlDoc.readDoc("""
		<parent>
    		<!-- This is a comment -->
			Text
		    <child>Text Content</child>
    		Another Text Node
		</parent>
		""")

		Local root:TXmlNode = doc.getRootElement()

		root.setContent("New Content")

		AssertEquals("""
		<?xml version="1.0" encoding="utf-8"?><parent><!-- This is a comment --><child>Text Content</child>New Content</parent>
		""", doc.ToString())

		doc.Free()
	End Method

	Method testSetContent_ElementNumberText() {test}

		Local doc:TXmlDoc = TXmlDoc.readDoc("""
		<parent>
    		<value>123</value>
    		456.789
    		OpaqueString
		</parent>
		""")

		Local root:TXmlNode = doc.getRootElement()

		root.setContent("New Content")

		AssertEquals("""
		<?xml version="1.0" encoding="utf-8"?><parent><value>123</value>New Content</parent>
		""", doc.ToString())

		doc.Free()
	End Method

	Method testSetContent_Empty() {test}

		Local doc:TXmlDoc = TXmlDoc.readDoc("""
		<parent></parent>
		""")

		Local root:TXmlNode = doc.getRootElement()

		root.setContent("New Content")

		AssertEquals("""
		<?xml version="1.0" encoding="utf-8"?><parent>New Content</parent>
		""", doc.ToString())

		doc.Free()
	End Method

End Type

Type TXmlMoreTests Extends TTest

	' Helper: make a reasonably unique temp filename in current dir
	Function TempFileName:String(prefix:String, suffix:String = ".xml")
		SeedRnd(MilliSecs())
		Local n:Int = Rand(100000, 999999)
		Return prefix + "_" + n + suffix
	End Function

	' -------------------------
	' readDoc() variations
	' -------------------------

	Method testReadDoc_stripsUtf8Bom() { test }

		' UTF-8 BOM bytes in a BlitzMax string can be represented as Chr($EF)+Chr($BB)+Chr($BF)
		Local bom:String = Chr($EF) + Chr($BB) + Chr($BF)

		Local xml:String = bom + "<book><title>Animal Farm</title></book>"
		Local doc:TXmlDoc = TXmlDoc.readDoc(xml)

		Local root:TXmlNode = doc.getRootElement()
		AssertEquals("book", root.getName())

		doc.Free()
	End Method

	Method testReadDoc_fromStream() { test }

		Local xml:String = "<root><child>v</child></root>"
		Local s:TStream = New TByteArrayStream(xml)

		Local doc:TXmlDoc = TXmlDoc.readDoc(s)
		AssertNotNull(doc)

		Local root:TXmlNode = doc.getRootElement()
		AssertEquals("root", root.getName())

		doc.Free()
		s.Close()
	End Method

	' -------------------------
	' Node creation / parent-child
	' -------------------------

	Method testNewNode_addChild_parentPointers() { test }

		Local root:TXmlNode = TXmlNode.newNode("root")
		Local child:TXmlNode = root.addChild("child", "hello")

		AssertEquals("root", root.getName())
		AssertEquals("child", child.getName())
		AssertEquals("root", child.GetParent().getName())

		' cleanup
		root.Free()
	End Method

	Method testAddChild_withoutContent_doesNotAddText() { test }

		Local root:TXmlNode = TXmlNode.newNode("root")
		Local child:TXmlNode = root.addChild("child") ' no content

		' ensure no accidental text node content got created by wrapper
		AssertEquals("", child.getContent())

		root.Free()
	End Method

	' -------------------------
	' Attributes
	' -------------------------

	Method testAttributes_set_get_has_unset() { test }

		Local n:TXmlNode = TXmlNode.newNode("n")

		AssertEquals(False, n.hasAttribute("id"))

		n.setAttribute("id", "123")
		AssertEquals(True, n.hasAttribute("id"))
		AssertEquals("123", n.getAttribute("id"))

		Local sb:TStringBuilder = New TStringBuilder()
		AssertEquals("123", n.getAttribute("id", sb).ToString())

		' default value parameter
		n.setAttribute("empty") ' should become ""
		AssertEquals(True, n.hasAttribute("empty"))
		AssertEquals("", n.getAttribute("empty"))

		sb.SetLength(0)
		AssertEquals("", n.getAttribute("empty", sb).ToString())

		n.unsetAttribute("id")
		AssertEquals(False, n.hasAttribute("id"))

		n.Free()
	End Method

	Method testGetAttributeList_countAndContents() { test }

		Local n:TXmlNode = TXmlNode.newNode("n")
		n.setAttribute("a", "1")
		n.setAttribute("b", "2")
		n.setAttribute("c", "3")

		Local list:TObjectList = n.getAttributeList()
		AssertEquals(3, list.Count())

		' Turn into a simple lookup without assuming order
		Local foundA:Int, foundB:Int, foundC:Int
		For Local it:Object = EachIn list
			Local attr:TxmlAttribute = TxmlAttribute(it)
			Select attr.getName()
				Case "a"
					foundA = (attr.getValue() = "1")
				Case "b"
					foundB = (attr.getValue() = "2")
				Case "c"
					foundC = (attr.getValue() = "3")
			End Select
		Next

		AssertEquals(True, foundA)
		AssertEquals(True, foundB)
		AssertEquals(True, foundC)

		n.Free()
	End Method

	' -------------------------
	' Siblings / ordering / traversal
	' -------------------------

	Method testSiblings_addNextAndPrevious() { test }

		Local doc:TXmlDoc = TXmlDoc.newDoc("1.0")
		Local root:TXmlNode = TXmlNode.newNode("root")
		doc.setRootElement(root)

		Local a:TXmlNode = root.addChild("a")
		Local c:TXmlNode = root.addChild("c")
		Local b:TXmlNode = TXmlNode.newNode("b")

		' insert b after a => a, b, c
		a.addNextSibling(b)

		Local children:TObjectList = root.getChildren()
		AssertEquals(3, children.Count())
		AssertEquals("a", TXmlNode(children.First()).getName())
		AssertEquals("b", TXmlNode(children.ValueAtIndex(1)).getName())
		AssertEquals("c", TXmlNode(children.Last()).getName())

		' now insert d before c => a, b, d, c
		Local d:TXmlNode = TXmlNode.newNode("d")
		c.addPreviousSibling(d)

		children = root.getChildren()
		AssertEquals(4, children.Count())
		AssertEquals("a", TXmlNode(children.ValueAtIndex(0)).getName())
		AssertEquals("b", TXmlNode(children.ValueAtIndex(1)).getName())
		AssertEquals("d", TXmlNode(children.ValueAtIndex(2)).getName())
		AssertEquals("c", TXmlNode(children.ValueAtIndex(3)).getName())

		doc.Free()
	End Method

	Method testFirstLastNextPrevSibling() { test }

		Local doc:TXmlDoc = TXmlDoc.readDoc("<root><a/><b/><c/></root>")
		Local root:TXmlNode = doc.getRootElement()

		Local first:TXmlNode = TXmlNode(root.getFirstChild())
		Local last:TXmlNode = TXmlNode(root.getLastChild())

		AssertEquals("a", first.getName())
		AssertEquals("c", last.getName())

		AssertEquals("b", first.nextSibling().getName())
		AssertEquals("b", last.previousSibling().getName())

		doc.Free()
	End Method

	Method testGetChildren_onlyElements() { test }

		' Ensure getChildren skips non-element nodes (text, comments, etc.)
		Local doc:TXmlDoc = TXmlDoc.readDoc("""
		<root>
			Text
			<!-- comment -->
			<a/>
			<b>content</b>
		</root>
		""")

		Local root:TXmlNode = doc.getRootElement()
		Local children:TObjectList = root.getChildren()

		AssertEquals(2, children.Count())
		AssertEquals("a", TXmlNode(children.ValueAtIndex(0)).getName())
		AssertEquals("b", TXmlNode(children.ValueAtIndex(1)).getName())

		doc.Free()
	End Method

	' -------------------------
	' Content behavior
	' -------------------------

	Method testAddContent_appends() { test }

		Local doc:TXmlDoc = TXmlDoc.readDoc("<root>hello</root>")
		Local root:TXmlNode = doc.getRootElement()

		root.addContent(" world")
		AssertEquals("hello world", root.getContent())

		doc.Free()
	End Method

	Method testGetContent_withExistingStringBuilder_appends() { test }

		Local doc:TXmlDoc = TXmlDoc.readDoc("<root><a><![CDATA[x]]></a><b>y</b></root>")
		Local root:TXmlNode = doc.getRootElement()

		Local sb:TStringBuilder = New TStringBuilder()
		sb.Append("prefix:")

		root.getContent(sb)
		AssertEquals("prefix:xy", sb.ToString())

		doc.Free()
	End Method

	Method testSetName_changesElementName() { test }

		Local doc:TXmlDoc = TXmlDoc.readDoc("<root><a/></root>")
		Local root:TXmlNode = doc.getRootElement()

		Local a:TXmlNode = root.findElement("a")
		AssertNotNull(a)

		a.setName("renamed")

		' find old should fail, new should succeed
		AssertNull(root.findElement("a"))
		AssertNotNull(root.findElement("renamed"))

		doc.Free()
	End Method

	' -------------------------
	' findElement() behavior
	' -------------------------

	Method testFindElement_byName_descendAndNoDescend() { test }

		Local doc:TXmlDoc = TXmlDoc.readDoc("""
		<root>
			<level1>
				<target id="deep"/>
			</level1>
			<target id="shallow"/>
		</root>
		""")

		Local root:TXmlNode = doc.getRootElement()

		' With descend, should find the first match in document order
		Local n1:TXmlNode = root.findElement("target", "", "", MXML_DESCEND)
		AssertNotNull(n1,"Find with descend returned null")
		AssertEquals("target", n1.getName())

		' With descend first from root, should only consider direct children => should find shallow target
		Local n2:TXmlNode = root.findElement("target", "", "", MXML_DESCEND_FIRST)
		AssertNotNull(n2,"Find with no descend returned null")
		AssertEquals("shallow", n2.getAttribute("id"))

		doc.Free()
	End Method

	Method testFindElement_byAttributeAndValue() { test }

		Local doc:TXmlDoc = TXmlDoc.readDoc("""
		<root>
			<item k="a"/>
			<item k="b"/>
			<item k="c"/>
		</root>
		""")

		Local root:TXmlNode = doc.getRootElement()

		Local n:TXmlNode = root.findElement("item", "k", "b", MXML_DESCEND)
		AssertNotNull(n)
		AssertEquals("b", n.getAttribute("k"))

		doc.Free()
	End Method

	' -------------------------
	' ToStringFormat()
	' -------------------------

	Method testToStringFormat_producesOutput() { test }

		Local doc:TXmlDoc = TXmlDoc.readDoc("<root><a>1</a><b>2</b></root>")

		Local s1:String = doc.ToStringFormat(False)
		Local s2:String = doc.ToStringFormat(True)

		' Both should contain root; formatted should normally have newlines/indentation,
		' but instead of relying on exact formatting, just assert it differs and contains expected tags.
		AssertTrue(s1.Find("<root") >= 0)
		AssertTrue(s2.Find("<root") >= 0)
		AssertTrue(s1 <> s2)

		doc.Free()
	End Method

	' -------------------------
	' saveFile() / parseFile()
	' -------------------------

	Method testSaveFile_andParseFile_roundTrip() { test }

		Local filename:String = TempFileName("xml_roundtrip")

		Local doc:TXmlDoc = TXmlDoc.readDoc("<root><a x='1'>v</a></root>")
		Local ok:Int = doc.saveFile(filename, True, False)
		AssertEquals(True, ok)
		doc.Free()

		Local doc2:TXmlDoc = TXmlDoc.parseFile(filename)
		AssertNotNull(doc2)

		Local root:TXmlNode = doc2.getRootElement()
		AssertEquals("root", root.getName())
		AssertEquals("a", root.getFirstChild().getName())

		doc2.Free()

		' cleanup
		DeleteFile(filename)
	End Method

	Method testSaveFile_toExistingStream_noAutoClose() { test }

		Local s:TStream = New TByteArrayStream

		Local doc:TXmlDoc = TXmlDoc.readDoc("<root/>")
		Local ok:Int = doc.saveFile(s, False, False) ' should not close stream
		AssertTrue(ok)

		' if stream was closed, this may error or write 0; simplest is attempt a write.
		s.WriteString(" ") ' harmless

		s.Close()
		doc.Free()

	End Method

	Method testParseFile_invalid_returnsNull() { test }

		Local filename:String = TempFileName("xml_invalid")
		Local s:TStream = WriteStream(filename)
		s.WriteString("<root><unclosed></root>")
		s.Close()

		Local doc:TXmlDoc = TXmlDoc.parseFile(filename)
		AssertNull(doc)

		DeleteFile(filename)
	End Method

	Method testSaveFile_stdoutPath_returnsBoolean() { test }

		' ensure code path for filename "-" is exercised
		Local doc:TXmlDoc = TXmlDoc.readDoc("<root/>")
		Local ok:Int = doc.saveFile("-", True, False)

		' Depending on implementation, may return 1/0 or true/false, but should be non-negative.
		AssertTrue(ok = 0 Or ok = 1)

		doc.Free()
	End Method

End Type

Type TXmlCaseInsensitiveAndAttributesTest Extends TTest

	Method testGetAttribute_caseSensitive_missing() { test }

		Local n:TXmlNode = TXmlNode.newNode("n")
		n.setAttribute("Id", "123")

		' Case sensitive lookup should not find different case
		Local v:String = n.getAttribute("id")
		AssertTrue(v = Null Or v = "")

		n.Free()
	End Method

	Method testGetAttribute_caseInsensitive_finds() { test }

		Local n:TXmlNode = TXmlNode.newNode("n")
		n.setAttribute("Id", "123")

		AssertEquals("123", n.getAttribute("id", True))
		AssertEquals("123", n.getAttribute("ID", True))
		AssertEquals("123", n.getAttribute("iD", True))

		n.Free()
	End Method

	Method testTryGetAttribute_found_setsVar() { test }

		Local n:TXmlNode = TXmlNode.newNode("n")
		n.setAttribute("Token", "abc")

		Local out:String = "initial"
		Local found:Int = n.tryGetAttribute("Token", out)
		AssertEquals(True, found)
		AssertEquals("abc", out)

		n.Free()
	End Method

	Method testTryGetAttribute_notFound_doesNotReportFound() { test }

		Local n:TXmlNode = TXmlNode.newNode("n")
		n.setAttribute("Token", "abc")

		Local out:String = "initial"
		Local found:Int = n.tryGetAttribute("Missing", out)
		AssertEquals(False, found)

		' We won't assert what "out" becomes, since implementation might set it to Null or "".
		n.Free()
	End Method

	Method testTryGetAttribute_caseInsensitive_found() { test }

		Local n:TXmlNode = TXmlNode.newNode("n")
		n.setAttribute("Token", "abc")

		Local out:String
		Local found:Int = n.tryGetAttribute("token", out, True)
		AssertEquals(True, found)
		AssertEquals("abc", out)

		n.Free()
	End Method

	Method testHasAttribute_caseInsensitive() { test }

		Local n:TXmlNode = TXmlNode.newNode("n")
		n.setAttribute("MiXeD", "1")

		AssertEquals(True, n.hasAttribute("MiXeD"))
		AssertEquals(False, n.hasAttribute("mixed"))

		AssertEquals(True, n.hasAttribute("mixed", True))
		AssertEquals(True, n.hasAttribute("MIXED", True))

		n.Free()
	End Method

	Method testUnsetAttribute_caseInsensitive() { test }

		Local n:TXmlNode = TXmlNode.newNode("n")
		n.setAttribute("MiXeD", "1")

		' case sensitive unset should fail if case differs
		n.unsetAttribute("mixed")
		AssertEquals(True, n.hasAttribute("MiXeD"))

		' case insensitive unset should remove it
		n.unsetAttribute("mixed", True)
		AssertEquals(False, n.hasAttribute("MiXeD"))
		AssertEquals(0, n.getAttributeCount())

		n.Free()
	End Method

	Method testGetAttributeCount_tracksChanges() { test }

		Local n:TXmlNode = TXmlNode.newNode("n")
		AssertEquals(0, n.getAttributeCount())

		n.setAttribute("a", "1")
		AssertEquals(1, n.getAttributeCount())

		n.setAttribute("b", "2")
		AssertEquals(2, n.getAttributeCount())

		n.unsetAttribute("a")
		AssertEquals(1, n.getAttributeCount())

		n.Free()
	End Method

	Method testGetAttributeByIndex_nameAndValue_roundTrip() { test }

		Local n:TXmlNode = TXmlNode.newNode("n")
		n.setAttribute("a", "1")
		n.setAttribute("b", "2")
		n.setAttribute("c", "3")

		Local count:Int = n.getAttributeCount()
		AssertEquals(3, count)

		' Build a set of seen name/value pairs without relying on order
		Local seenA:Int, seenB:Int, seenC:Int

		For Local i:Int = 0 Until count
			Local name:String
			Local value:String = n.getAttributeByIndex(i, name)

			Select name
				Case "a"
					seenA = (value = "1")
				Case "b"
					seenB = (value = "2")
				Case "c"
					seenC = (value = "3")
			End Select

			' The no-name variant should return the same value for the same index
			Local value2:String = n.getAttributeByIndex(i)
			AssertEquals(value, value2)
		Next

		AssertEquals(True, seenA)
		AssertEquals(True, seenB)
		AssertEquals(True, seenC)

		n.Free()
	End Method

	Method testGetAttributeList_matchesCount_andContainsAll() { test }

		Local n:TXmlNode = TXmlNode.newNode("n")
		n.setAttribute("a", "1")
		n.setAttribute("b", "2")

		Local list:TObjectList = n.getAttributeList()
		AssertEquals(2, list.Count())
		AssertEquals(2, n.getAttributeCount())

		Local foundA:Int, foundB:Int
		For Local it:Object = EachIn list
			Local attr:TxmlAttribute = TxmlAttribute(it)
			Select attr.getName()
				Case "a"
					foundA = (attr.getValue() = "1")
				Case "b"
					foundB = (attr.getValue() = "2")
			End Select
		Next

		AssertEquals(True, foundA)
		AssertEquals(True, foundB)

		n.Free()
	End Method

	Method testFindElement_caseInsensitive_elementName() { test }

		Local doc:TXmlDoc = TXmlDoc.readDoc("<Root><Child/><child2/></Root>")
		Local root:TXmlNode = doc.getRootElement()

		' case sensitive should fail when case differs
		AssertNull(root.findElement("child", "", "", MXML_DESCEND, False))

		' case insensitive should find it
		Local c:TXmlNode = root.findElement("child", "", "", MXML_DESCEND, True)
		AssertNotNull(c)
		AssertEquals("Child", c.getName())

		doc.Free()
	End Method

	Method testFindElement_caseInsensitive_attributeNameAndValue() { test }

		Local doc:TXmlDoc = TXmlDoc.readDoc("""
		<root>
			<item Key="A"/>
			<item Key="B"/>
			<item Key="C"/>
		</root>
		""")

		Local root:TXmlNode = doc.getRootElement()

		' attribute name and/or value case-insensitive search
		Local n:TXmlNode = root.findElement("item", "key", "b", MXML_DESCEND, True)
		AssertNotNull(n)
		AssertEquals("B", n.getAttribute("Key"))

		doc.Free()
	End Method

	Method testGetChildren_returnsElementsOnly_TObjectList() { test }

		Local doc:TXmlDoc = TXmlDoc.readDoc("""
		<root>
			Text
			<!-- comment -->
			<a/>
			<b>content</b>
		</root>
		""")

		Local root:TXmlNode = doc.getRootElement()
		Local children:TObjectList = root.getChildren()

		AssertEquals(2, children.Count())
		AssertEquals("a", TXmlNode(children.ValueAtIndex(0)).getName())
		AssertEquals("b", TXmlNode(children.ValueAtIndex(1)).getName())

		doc.Free()
	End Method

	Method testAddContent_nowVisibleViaGetContent() { test }

		Local doc:TXmlDoc = TXmlDoc.readDoc("<root>hello</root>")
		Local root:TXmlNode = doc.getRootElement()

		root.addContent(" world")

		' With MXML_TEXT now handled, getContent should include text nodes.
		Local c:String = root.getContent()
		AssertTrue(c.Find("hello") >= 0)
		AssertTrue(c.Find("world") >= 0)

		doc.Free()
	End Method

	Method testGetContent_appendsToExistingBuilder_includingText() { test }

		Local doc:TXmlDoc = TXmlDoc.readDoc("<root>Hi <a><![CDATA[X]]></a> There</root>")
		Local root:TXmlNode = doc.getRootElement()

		Local sb:TStringBuilder = New TStringBuilder()
		sb.Append("prefix:")

		root.getContent(sb)

		Local s:String = sb.ToString()
		AssertTrue(s.Find("prefix:") = 0)
		AssertTrue(s.Find("Hi") >= 0)
		AssertTrue(s.Find("X") >= 0)
		AssertTrue(s.Find("There") >= 0)

		doc.Free()
	End Method

End Type
