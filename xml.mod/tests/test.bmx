SuperStrict

Framework brl.standardio
Import Text.XML
Import BRL.MaxUnit

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

