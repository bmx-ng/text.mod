' Copyright (c) 2008-2026 Bruce A Henderson
' 
' Permission is hereby granted, free of charge, to any person obtaining a copy
' of this software and associated documentation files (the "Software"), to deal
' in the Software without restriction, including without limitation the rights
' to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
' copies of the Software, and to permit persons to whom the Software is
' furnished to do so, subject to the following conditions:
' 
' The above copyright notice and this permission notice shall be included in
' all copies or substantial portions of the Software.
' 
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
' IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
' FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
' AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
' LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
' OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
' THE SOFTWARE.
' 
SuperStrict

Rem
bbdoc: Persistence XML
about: An XML-based object-persistence framework. 
End Rem
Module Text.PersistenceXml

ModuleInfo "Version: 1.08"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "License: MIT"
ModuleInfo "Copyright: 2008-2026 Bruce A Henderson"

ModuleInfo "History: 1.08"
ModuleInfo "History: Performance improvements for deserializing numeric arrays."
ModuleInfo "History: 1.07"
ModuleInfo "History: Collections refactoring."
ModuleInfo "History: 1.06"
ModuleInfo "History: Updated to use Text.XML."
ModuleInfo "History: 1.05"
ModuleInfo "History: Improved persistence."
ModuleInfo "History: 1.04"
ModuleInfo "History: Improved persistence."
ModuleInfo "History: Added unit tests."
ModuleInfo "History: 1.03"
ModuleInfo "History: Added custom serializers."
ModuleInfo "History: 1.02"
ModuleInfo "History: Added XML parsing options arg for deserialization."
ModuleInfo "History: Fixed 64-bit address ref issue."
ModuleInfo "History: 1.01"
ModuleInfo "History: Added encoding for String and String Array fields. (Ronny Otto)"
ModuleInfo "History: 1.00"
ModuleInfo "History: Initial Release"

Import Text.XML
Import BRL.Reflection
Import BRL.Map
Import Collections.IntMap
Import BRL.Stream

Import "glue.c"

Rem
bbdoc: Object Persistence.
End Rem
Type TPersist

	Rem
	bbdoc: File format version
	End Rem
	Const BMO_VERSION:Int = 8

	Field doc:TxmlDoc
	Field objectMap:TMap = New TMap
	
	Field lastNode:TxmlNode
	
	Rem
	bbdoc: Serialized formatting.
	about: Set to True to have the data formatted nicely. Default is False - off.
	End Rem
	Global format:Int = False
	
	Rem
	bbdoc: Compressed serialization.
	about: Set to True to compress the serialized data. Default is False - no compression.
	End Rem
	Global compressed:Int = False
	
?ptr64
	Global bbEmptyString:String = Base36(Long(bbEmptyStringPtr()))
	Global bbNullObject:String = Base36(Long(bbNullObjectPtr()))
	Global bbEmptyArray:String = Base36(Long(bbEmptyArrayPtr()))
?Not ptr64
	Global bbEmptyString:String = Base36(Int(bbEmptyStringPtr()))
	Global bbNullObject:String = Base36(Int(bbNullObjectPtr()))
	Global bbEmptyArray:String = Base36(Int(bbEmptyArrayPtr()))
?
	Field fileVersion:Int
	
	Field serializers:TMap = New TMap
	Field _inited:Int

	Field _sb:TStringBuilder = New TStringBuilder()
	' progress callback support
	Field _progressCallback(progress:Int, userData:Object)
	Field _progressUserData:Object
	Field _progressTotal:Int ' doesn't clamp at 100, it's up to the caller to manage this

	Rem
	bbdoc: Serializes the specified Object into a String.
	End Rem
	Method Serialize:String(obj:Object)
		Return SerializeToString(obj)
	End Method
	
	Method Free()
		If doc Then
			doc.Free()
			doc = Null
		End If
		If lastNode Then
			lastNode = Null
		End If
		objectMap.Clear()
		_progressTotal = 0
	End Method
	
	Rem
	bbdoc: Serializes an Object to a String.
	End Rem
	Method SerializeToString:String(obj:Object)
		If Not _inited Throw "Use TXMLPersistenceBuilder to create TPersist instance."
		Free()
		SerializeObject(obj)
		
		Return ToString()
	End Method
	
	Rem
	bbdoc: Serializes an Object to the file @filename.
	End Rem
	Method SerializeToFile(obj:Object, filename:String)
		If Not _inited Throw "Use TXMLPersistenceBuilder to create TPersist instance."
		Free()
		SerializeObject(obj)
		
		If doc Then
			doc.saveFile(filename, True, format)
		End If
		Free()
	End Method
	
	Rem
	bbdoc: Serializes an Object to a TxmlDoc structure.
	about: It is up to the user to free the returned TxmlDoc object.
	End Rem
	Method SerializeToDoc:TxmlDoc(obj:Object)
		If Not _inited Throw "Use TXMLPersistenceBuilder to create TPersist instance."
		Free()
		SerializeObject(obj)
		
		Local exportDoc:TxmlDoc = doc
		doc = Null
		Free()
		Return exportDoc
	End Method

	Rem
	bbdoc: Serializes an Object to a Stream.
	about: It is up to the user to close the stream.
	End Rem
	Method SerializeToStream(obj:Object, stream:TStream)
		If Not _inited Throw "Use TXMLPersistenceBuilder to create TPersist instance."
		Free()
		SerializeObject(obj)
		
		If doc Then
			doc.saveFile(stream, False, format)
		End If
		Free()
	End Method

	Rem
	bbdoc: Returns the serialized object as a string.
	End Rem
	Method ToString:String()
		If doc Then
			Return doc.ToStringFormat(format)
		End If
	End Method

	Method SetProgressCallback(callback(progress:Int, userData:Object), userData:Object)
		_progressCallback = callback
		_progressUserData = userData
	End Method

	Method DoProgress(progress:String)
		Local prog:Int = progress.ToInt()
		If prog Then
			_progressTotal :+ prog
			_progressCallback(_progressTotal, _progressUserData)
		End If
	End Method
	
	Method ProcessArray(arrayObject:Object, size:Int, node:TxmlNode, typeId:TTypeId)
	
		Local elementType:TTypeId = typeId.ElementType()
		
		Select elementType
			Case ByteTypeId, ShortTypeId, IntTypeId, LongTypeId, FloatTypeId, DoubleTypeId, UIntTypeId, ULongTypeId, LongIntTypeId, ULongIntTypeId, SizeTTypeId

				Local sb:TStringBuilder = new TStringBuilder()
				
				For Local i:Int = 0 Until size
				
					Local aObj:Object = typeId.GetArrayElement(arrayObject, i)

					If i Then
						sb.Append(" ")
					End If
					sb.Append(String(aObj))
				Next
				
				node.SetContent(sb.ToString())
			Default

				For Local i:Int = 0 Until size
				
					Local elementNode:TxmlNode = node.addChild("val")
					
					Local aObj:Object = typeId.GetArrayElement(arrayObject, i)
				
					Select elementType
						Case StringTypeId
							' only if not empty
							If String(aObj) Then
								elementNode.setContent(String(aObj))
							End If
						Default
							Local objRef:String = GetObjRef(aObj)
							
							' file version 5 ... array cells can contain references
							If Not Contains(objRef, aObj) Then
								SerializeObject(aObj, elementNode)
							Else
								elementNode.setAttribute("ref", objRef)
							End If
					End Select
				Next
				
		End Select
		
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SerializeFields(tid:TTypeId, obj:Object, node:TxmlNode)
		For Local f:TField = EachIn tid.EnumFields()
			SerializeField(f, obj, node)
		Next
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CreateSerializedFieldNode:TxmlNode(f:TField, node:TxmlNode)
		Local fieldNode:TxmlNode = node.addChild("field")
		fieldNode.setAttribute("name", f.Name())
		Return fieldNode
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SerializeField(f:TField, obj:Object, node:TxmlNode)
		If f.MetaData("nopersist") Then
			Return
		End If
	
		Local fieldType:TTypeId = f.TypeId()
		Local fieldNode:TxmlNode = CreateSerializedFieldNode(f, node)
		
		Local t:String
		Select fieldType
			Case ByteTypeId
				t = "byte"
				fieldNode.setContent(f.GetInt(obj))
			Case ShortTypeId
				t = "short"
				fieldNode.setContent(f.GetInt(obj))
			Case IntTypeId
				t = "int"
				fieldNode.setContent(f.GetInt(obj))
			Case LongTypeId
				t = "long"
				fieldNode.setContent(f.GetLong(obj))
			Case FloatTypeId
				t = "float"
				fieldNode.setContent(f.GetFloat(obj))
			Case DoubleTypeId
				t = "double"
				fieldNode.setContent(f.GetDouble(obj))
			Case UIntTypeId
				t = "uint"
				fieldNode.setContent(f.GetUInt(obj))
			Case ULongTypeId
				t = "ulong"
				fieldNode.setContent(f.GetULong(obj))
			Case LongIntTypeId
				t = "longint"
				fieldNode.setContent(f.GetLongInt(obj))
			Case ULongIntTypeId
				t = "ulongint"
				fieldNode.setContent(f.GetULongInt(obj))
			Case SizeTTypeId
				t = "sizet"
				fieldNode.setContent(f.GetSizeT(obj))
			Default
				t = fieldType.Name()

				If fieldType.ExtendsType( ArrayTypeId ) Then
				
					' prefix and strip brackets
					Local dims:Int = t.split("[").length
					If dims = 1 Then
						t = "array:" + t.Replace("[]", "")
					Else
						t = "array:" + t
					End If
					
					dims = fieldType.ArrayDimensions(f.Get(obj))
					If dims > 1 Then
						Local scales:String
						For Local i:Int = 0 Until dims - 1
							scales :+ (fieldType.ArrayLength(f.Get(obj), i) / fieldType.ArrayLength(f.Get(obj), i + 1))
							scales :+ ","
						Next
						
						scales:+ fieldType.ArrayLength(f.Get(obj), dims - 1)
						
						fieldNode.setAttribute("scales", scales)
					End If

					ProcessArray(f.Get(obj), fieldType.ArrayLength(f.Get(obj)), fieldNode, fieldType)

				Else
					Local fieldObject:Object = f.Get(obj)
					Local fieldRef:String = GetObjRef(fieldObject)
					
					If fieldRef <> bbEmptyString And fieldRef <> bbNullObject And fieldRef <> bbEmptyArray Then
						If fieldObject Then
							If Not Contains(fieldRef, fieldObject) Then
								SerializeObject(fieldObject, fieldNode)
							Else
								fieldNode.setAttribute("ref", fieldRef)
							End If
						End If
					End If
				End If
		End Select
		
		fieldNode.setAttribute("type", t)
	End Method

	Method SerializeByType(tid:TTypeId, obj:Object, node:TxmlNode)
		Local serializer:TXMLSerializer = TXMLSerializer(serializers.ValueForKey(tid.Name()))
		If serializer Then
			serializer.Serialize(tid, obj, node)
		Else
			SerializeFields(tid, obj, node)
		End If
	End Method
		
	Rem
	bbdoc: 
	End Rem
	Method SerializeObject:TxmlNode(obj:Object, parent:TxmlNode = Null)

		Local node:TxmlNode
		
		If Not doc Then
			doc = TxmlDoc.newDoc("1.0")
			parent = TxmlNode.newNode("bmo") ' BlitzMax Object
			parent.SetAttribute("ver", BMO_VERSION) ' set the format version
			doc.setRootElement(parent)
		Else
			If Not parent Then
				parent = doc.GetRootElement()
			End If
		End If
		
		If obj Then
			Local objRef:String = GetObjRef(obj)
			
			If objRef = bbEmptyString Or objRef = bbNullObject Or objRef = bbEmptyArray Then
				Return Null
			End If
			
			Local objectIsArray:Int = False
		
			Local tid:TTypeId = TTypeId.ForObject(obj)
			Local tidName:String = tid.Name()

			' Is this an array "Object" ?
			If tidName.EndsWith("[]") Then
				tidName = "_array_"
				objectIsArray = True
			End If
			
			node = parent.addChild(tidName)
			
			node.setAttribute("ref", objRef)
			
			AddObjectRef(obj, node)

			' We need to handle array objects differently..
			If objectIsArray Then
			
				tidName = tid.Name()[..tid.Name().length - 2]
				
				Local size:Int
				
				' it's possible that the array is zero-length, in which case the object type
				' is undefined. Therefore we default it to type "Object".
				' This doesn't matter, since it's essentially a Null Object which has no
				' inherent value. We only store the instance so that the de-serialized object will
				' look similar.
				Try
					size = tid.ArrayLength(obj)
				Catch e$
					tidName = "Object"
					size = 0
				End Try

				node.setAttribute("type", tidName)
				node.setAttribute("size", size)

				If size > 0 Then
					ProcessArray(obj, size, node, tid)
				End If
			
			Else

				' special case for String object
				If tid = StringTypeId Then
					node.setContent(String(obj))
				Else
					SerializeByType(tid, obj, node)
				End If
				
			End If
	
		End If
		
		Return node
		
	End Method
	
	Method Contains:Int(ref:String, obj:Object)
		Local cobj:Object = objectMap.ValueForKey(ref)
		If Not cobj Then
			Return False
		End If
		
		' same object already exists!
		If cobj = obj Then
			Return True
		End If
		
		' same ref but different object????
		Throw TPersistCollisionException.CreateException(ref, obj, cobj)
	End Method

	Method Delete()
		Free()
	End Method
	
	Rem
	bbdoc: De-serializes @text into an Object structure.
	about: Accepts a TxmlDoc, TStream or a String (of data).
	End Rem
	Method DeSerialize:Object(data:Object)
		If Not _inited Throw "Use TXMLPersistenceBuilder to create TPersist instance."
		
		If TxmlDoc(data) Then
			Return DeSerializeFromDoc(TxmlDoc(data))
		Else If TStream(data) Then
			Return DeSerializeFromStream(TStream(data))
		Else If String(data) Then
			Return DeSerializeObject(String(data), Null)
		End If
	End Method
	
	Rem
	bbdoc: De-serializes @doc into an Object structure.
	about: It is up to the user to free the supplied TxmlDoc.
	End Rem
	Method DeSerializeFromDoc:Object(xmlDoc:TxmlDoc)
		If Not _inited Throw "Use TXMLPersistenceBuilder to create TPersist instance."

		doc = xmlDoc

		Local root:TxmlNode = doc.GetRootElement()
		fileVersion = root.GetAttribute("ver").ToInt() ' get the format version
		Local obj:Object = DeSerializeObject("", root)
		doc = Null
		Free()
		Return obj
	End Method

	Rem
	bbdoc: De-serializes the file @filename into an Object structure.
	End Rem
	Method DeSerializeFromFile:Object(filename:Object)
		If Not _inited Throw "Use TXMLPersistenceBuilder to create TPersist instance."
	
		doc = TxmlDoc.parseFile(filename)

		If doc Then
			Local root:TxmlNode = doc.GetRootElement()
			fileVersion = root.GetAttribute("ver").ToInt() ' get the format version
			Local obj:Object = DeSerializeObject("", root)
			Free()
			Return obj
		End If
	End Method

	Rem
	bbdoc: De-serializes @stream into an Object structure.
	End Rem
	Method DeSerializeFromStream:Object(stream:TStream)
		If Not _inited Throw "Use TXMLPersistenceBuilder to create TPersist instance."

		Return DeSerializeFromFile(stream)
	End Method
	
	Method DeserializeByType:Object(objType:TTypeId, node:TxmlNode)
		Local serializer:TXMLSerializer = TXMLSerializer(serializers.ValueForKey(objType.Name()))
		If serializer Then
			Return serializer.Deserialize(objType, node)
		Else
			Local obj:Object = CreateObjectInstance(objType, node)
			DeserializeFields(objType, obj, node)
			Return obj
		End If
	End Method
	
	Method AddObjectRef(obj:Object, node:TxmlNode)
		objectMap.Insert(node.getAttribute("ref"), obj)
	End Method
	
	Method CreateObjectInstance:Object(objType:TTypeId, node:TxmlNode)
		' create the object
		Local obj:Object = objType.NewObject()
		AddObjectRef(obj, node)
		Return obj
	End Method
	
	Method DeserializeFields(objType:TTypeId, obj:Object, node:TxmlNode)
		' does the node contain child nodes?
		Local children:TObjectList = node.getChildren()
		If children <> Null Then
			For Local fieldNode:TxmlNode = EachIn children
			
				' this should be a field
				If fieldNode.GetName() = "field" Then
					_sb.SetLength(0)
				
					Local fieldObj:TField = objType.FindField(fieldNode.getAttribute("name"))
					
					Local fieldType:String = fieldNode.getAttribute("type")
					Select fieldType
						Case "byte", "short", "int"
							fieldObj.SetInt(obj, fieldNode.GetContent(_sb).toInt())
						Case "long"
							fieldObj.SetLong(obj, fieldNode.GetContent(_sb).toLong())
						Case "float"
							fieldObj.SetFloat(obj, fieldNode.GetContent(_sb).toFloat())
						Case "double"
							fieldObj.SetDouble(obj, fieldNode.GetContent(_sb).toDouble())
						Case "uint"
							fieldObj.SetUInt(obj, fieldNode.GetContent(_sb).toUInt())
						Case "sizet"
							fieldObj.SetSizeT(obj, fieldNode.GetContent(_sb).toSizeT())
						Case "ulong"
							fieldObj.SetULong(obj, fieldNode.GetContent(_sb).toULong())
						Case "longint"
							fieldObj.SetLongInt(obj, LongInt(fieldNode.GetContent(_sb).toLongInt())) ' FIXME : why do we need to cast here?
						Case "ulongint"
							fieldObj.SetULongInt(obj, fieldNode.GetContent(_sb).toULongInt())
						Default
							If fieldType.StartsWith("array:") Then

								Local arrayType:TTypeId = fieldObj.TypeId()
								Local arrayElementType:TTypeId = arrayType.ElementType()

								_sb.SetLength(0)

								' for file version 3+
								Local scalesi:Int[]
								Local scales:Int[] = fieldNode.getAttribute("scales", _sb).SplitInts(",")
								If scales.length > 1 Then
									scalesi = scales
								End If
								
								' for file Version 1+
								Select arrayElementType
									Case FloatTypeId
										_sb.SetLength(0)
										fieldNode.GetContent(_sb).Trim()

										Local values:Float[]
										If _sb.Length() > 0 Then
											values = _sb.SplitFloats(" ")
										End If

										' Fast path for 1-dimensional arrays
										If scalesi.length = 0 Then
											fieldObj.Set(obj, values)
										Else
											' Multi-dimensional array - create and copy
											Local arrayObj:Object = arrayType.NewArray(values.length, scalesi)
											fieldObj.Set(obj, arrayObj)

											For Local i:Int = 0 Until values.length
												arrayType.SetArrayElement(arrayObj, i, values[i])
											Next
										End If

									Case DoubleTypeId
										_sb.SetLength(0)
										fieldNode.GetContent(_sb).Trim()

										Local values:Double[]
										If _sb.Length() > 0 Then
											values = _sb.SplitDoubles(" ")
										End If

										' Fast path for 1-dimensional arrays
										If scalesi.length = 0 Then
											fieldObj.Set(obj, values)
										Else
											' Multi-dimensional array - create and copy
											Local arrayObj:Object = arrayType.NewArray(values.length, scalesi)
											fieldObj.Set(obj, arrayObj)

											For Local i:Int = 0 Until values.length
												arrayType.SetArrayElement(arrayObj, i, values[i])
											Next
										End If
									
									Case ByteTypeId
										_sb.SetLength(0)
										fieldNode.GetContent(_sb).Trim()

										Local values:Byte[]
										If _sb.Length() > 0 Then
											values = _sb.SplitBytes(" ")
										End If

										' Fast path for 1-dimensional arrays
										If scalesi.length = 0 Then
											fieldObj.Set(obj, values)
										Else
											' Multi-dimensional array - create and copy
											Local arrayObj:Object = arrayType.NewArray(values.length, scalesi)
											fieldObj.Set(obj, arrayObj)

											For Local i:Int = 0 Until values.length
												arrayType.SetArrayElement(arrayObj, i, values[i])
											Next
										End If

									Case ShortTypeId
										_sb.SetLength(0)
										fieldNode.GetContent(_sb).Trim()

										Local values:Short[]
										If _sb.Length() > 0 Then
											values = _sb.SplitShorts(" ")
										End If

										' Fast path for 1-dimensional arrays
										If scalesi.length = 0 Then
											fieldObj.Set(obj, values)
										Else
											' Multi-dimensional array - create and copy
											Local arrayObj:Object = arrayType.NewArray(values.length, scalesi)
											fieldObj.Set(obj, arrayObj)

											For Local i:Int = 0 Until values.length
												arrayType.SetArrayElement(arrayObj, i, values[i])
											Next
										End If
									
									Case IntTypeId
										_sb.SetLength(0)
										fieldNode.GetContent(_sb).Trim()

										Local values:Int[]
										If _sb.Length() > 0 Then
											values = _sb.SplitInts(" ")
										End If

										' Fast path for 1-dimensional arrays
										If scalesi.length = 0 Then
											fieldObj.Set(obj, values)
										Else
											' Multi-dimensional array - create and copy
											Local arrayObj:Object = arrayType.NewArray(values.length, scalesi)
											fieldObj.Set(obj, arrayObj)

											For Local i:Int = 0 Until values.length
												arrayType.SetArrayElement(arrayObj, i, values[i])
											Next
										End If
										
									Case LongTypeId
										_sb.SetLength(0)
										fieldNode.GetContent(_sb).Trim()

										Local values:Long[]
										If _sb.Length() > 0 Then
											values = _sb.SplitLongs(" ")
										End If

										' Fast path for 1-dimensional arrays
										If scalesi.length = 0 Then
											fieldObj.Set(obj, values)
										Else
											' Multi-dimensional array - create and copy
											Local arrayObj:Object = arrayType.NewArray(values.length, scalesi)
											fieldObj.Set(obj, arrayObj)

											For Local i:Int = 0 Until values.length
												arrayType.SetArrayElement(arrayObj, i, values[i])
											Next
										End If

									Case UIntTypeId
										_sb.SetLength(0)
										fieldNode.GetContent(_sb).Trim()

										Local values:UInt[]
										If _sb.Length() > 0 Then
											values = _sb.SplitUInts(" ")
										End If

										' Fast path for 1-dimensional arrays
										If scalesi.length = 0 Then
											fieldObj.Set(obj, values)
										Else
											' Multi-dimensional array - create and copy
											Local arrayObj:Object = arrayType.NewArray(values.length, scalesi)
											fieldObj.Set(obj, arrayObj)

											For Local i:Int = 0 Until values.length
												arrayType.SetArrayElement(arrayObj, i, values[i])
											Next
										End If

									Case ULongTypeId
										_sb.SetLength(0)
										fieldNode.GetContent(_sb).Trim()

										Local values:ULong[]
										If _sb.Length() > 0 Then
											values = _sb.SplitULongs(" ")
										End If

										' Fast path for 1-dimensional arrays
										If scalesi.length = 0 Then
											fieldObj.Set(obj, values)
										Else
											' Multi-dimensional array - create and copy
											Local arrayObj:Object = arrayType.NewArray(values.length, scalesi)
											fieldObj.Set(obj, arrayObj)

											For Local i:Int = 0 Until values.length
												arrayType.SetArrayElement(arrayObj, i, values[i])
											Next
										End If
									
									Case LongIntTypeId
										_sb.SetLength(0)
										fieldNode.GetContent(_sb).Trim()

										Local values:LongInt[]
										If _sb.Length() > 0 Then
											values = _sb.SplitLongInts(" ")
										End If

										' Fast path for 1-dimensional arrays
										If scalesi.length = 0 Then
											fieldObj.Set(obj, values)
										Else
											' Multi-dimensional array - create and copy
											Local arrayObj:Object = arrayType.NewArray(values.length, scalesi)
											fieldObj.Set(obj, arrayObj)

											For Local i:Int = 0 Until values.length
												arrayType.SetArrayElement(arrayObj, i, values[i])
											Next
										End If

									Case ULongIntTypeId
										_sb.SetLength(0)
										fieldNode.GetContent(_sb).Trim()

										Local values:ULongInt[]
										If _sb.Length() > 0 Then
											values = _sb.SplitULongInts(" ")
										End If

										' Fast path for 1-dimensional arrays
										If scalesi.length = 0 Then
											fieldObj.Set(obj, values)
										Else
											' Multi-dimensional array - create and copy
											Local arrayObj:Object = arrayType.NewArray(values.length, scalesi)
											fieldObj.Set(obj, arrayObj)

											For Local i:Int = 0 Until values.length
												arrayType.SetArrayElement(arrayObj, i, values[i])
											Next
										End If

									Case SizeTTypeId
										_sb.SetLength(0)
										fieldNode.GetContent(_sb).Trim()

										Local values:Size_T[]
										If _sb.Length() > 0 Then
											values = _sb.SplitSizeTs(" ")
										End If

										' Fast path for 1-dimensional arrays
										If scalesi.length = 0 Then
											fieldObj.Set(obj, values)
										Else
											' Multi-dimensional array - create and copy
											Local arrayObj:Object = arrayType.NewArray(values.length, scalesi)
											fieldObj.Set(obj, arrayObj)

											For Local i:Int = 0 Until values.length
												arrayType.SetArrayElement(arrayObj, i, values[i])
											Next
										End If

									Default
										Local arrayList:TObjectList = fieldNode.getChildren()
										
										If arrayList ' Birdie
											Local arrayObj:Object = arrayType.NewArray(arrayList.Count(), scalesi)
											fieldObj.Set(obj, arrayObj)
											
											Local i:Int
											For Local arrayNode:TxmlNode = EachIn arrayList
			
												Select arrayElementType
													Case StringTypeId
														arrayType.SetArrayElement(arrayObj, i, arrayNode.GetContent())
													Default
														' file version 5 ... array cells can contain references
														' is this a reference?
														Local ref:String = arrayNode.getAttribute("ref")
														If ref Then
															Local objRef:Object = objectMap.ValueForKey(ref)
															If objRef Then
																arrayType.SetArrayElement(arrayObj, i, objRef)
															Else
																Throw "Reference not mapped yet : " + ref
															End If
														Else
															arrayType.SetArrayElement(arrayObj, i, DeSerializeObject("", arrayNode))
														End If	
												End Select
			
												i:+ 1
											Next
										EndIf
								End Select
							Else
								' is this a reference?
								Local ref:String = fieldNode.getAttribute("ref")
								If ref Then
									Local objRef:Object = objectMap.ValueForKey(ref)
									If objRef Then
										fieldObj.Set(obj, objRef)
									Else
										Throw "Reference not mapped yet : " + ref
									End If
								Else
									fieldObj.Set(obj, DeSerializeObject("", fieldNode))
								End If
							End If
					End Select
					
					If _progressCallback Then
						Local prog:String = fieldObj.MetaData("progress")
						If prog Then
							DoProgress(prog)
						End If
					End If

				End If
			Next
		End If
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DeSerializeObject:Object(Text:String, parent:TxmlNode = Null, parentIsNode:Int = False)

		Local node:TxmlNode
		
		If Not doc Then
			
			doc = TxmlDoc.readDoc(Text)
			parent = doc.GetRootElement()
			fileVersion = parent.GetAttribute("ver").ToInt() ' get the format version
			node = TxmlNode(parent.GetFirstChild())
			lastNode = node
		Else
			If Not parent Then
				' find the next element node, if there is one. (content are also "nodes")
				node = TxmlNode(lastNode.NextSibling())
				'While node And (node.getType() <> XML_ELEMENT_NODE)
				'	node = TxmlNode(node.NextSibling())
				'Wend
				If Not node Then
					Return Null
				End If
				lastNode = node
			Else
				If parentIsNode Then
					node = parent
				Else
					node = TxmlNode(parent.GetFirstChild())
				End If
				lastNode = node
			End If
		End If
		
		Local obj:Object 
		
		
		If node Then
		
			Local nodeName:String = node.GetName()
			
			' Is this an array "Object" ?
			If nodeName = "_array_" Then
			
				Local objType:TTypeId = TTypeId.ForName(node.getAttribute("type") + "[]")
				
				Local size:Int = node.getAttribute("size").toInt()

				If size > 0 Then
					Local arrayElementType:TTypeId = objType.ElementType()
	
					Select arrayElementType
						Case FloatTypeId
							_sb.SetLength(0)

							obj = node.GetContent(_sb).SplitFloats(" ")
							AddObjectRef(obj, node)

						Case DoubleTypeId
							_sb.SetLength(0)

							obj = node.GetContent(_sb).SplitDoubles(" ")
							AddObjectRef(obj, node)

						Case ByteTypeId
							_sb.SetLength(0)

							obj = node.GetContent(_sb).SplitBytes(" ")
							AddObjectRef(obj, node)
						
						Case ShortTypeId
							_sb.SetLength(0)

							obj = node.GetContent(_sb).SplitShorts(" ")
							AddObjectRef(obj, node)

						Case IntTypeId
							_sb.SetLength(0)

							obj = node.GetContent(_sb).SplitInts(" ")
							AddObjectRef(obj, node)

						Case LongTypeId
							_sb.SetLength(0)

							obj = node.GetContent(_sb).SplitLongs(" ")
							AddObjectRef(obj, node)

						Case UIntTypeId
							_sb.SetLength(0)

							obj = node.GetContent(_sb).SplitUInts(" ")
							AddObjectRef(obj, node)

						Case ULongTypeId
							_sb.SetLength(0)

							obj = node.GetContent(_sb).SplitULongs(" ")
							AddObjectRef(obj, node)

						Case LongIntTypeId
							_sb.SetLength(0)

							obj = node.GetContent(_sb).SplitLongInts(" ")
							AddObjectRef(obj, node)

						Case ULongIntTypeId
							_sb.SetLength(0)

							obj = node.GetContent(_sb).SplitULongInts(" ")
							AddObjectRef(obj, node)

						Case SizeTTypeId
							_sb.SetLength(0)

							obj = node.GetContent(_sb).SplitSizeTs(" ")
							AddObjectRef(obj, node)
							
						Default
							obj = objType.NewArray(size)
							AddObjectRef(obj, node)

							Local arrayList:TObjectList = node.getChildren()
							
							If arrayList
								
								Local i:Int
								For Local arrayNode:TxmlNode = EachIn arrayList
		
									Select arrayElementType
										Case StringTypeId
											objType.SetArrayElement(obj, i, arrayNode.GetContent())
										Default
											' file version 5 ... array cells can contain references
											' is this a reference?
											Local ref:String = arrayNode.getAttribute("ref")
											If ref Then
												Local objRef:Object = objectMap.ValueForKey(ref)
												If objRef Then
													objType.SetArrayElement(obj, i, objRef)
												Else
													Throw "Reference not mapped yet : " + ref
												End If
											Else
												objType.SetArrayElement(obj, i, DeSerializeObject("", arrayNode))
											End If	

									End Select
		
									i:+ 1
								Next
							EndIf
					End Select
				Else
					obj = objType.NewArray(size)
					AddObjectRef(obj, node)
				End If
			
			Else
			
				Local objType:TTypeId = TTypeId.ForName(nodeName)
	
				' special case for String object
				If objType = StringTypeId Then
					obj = node.GetContent()
					AddObjectRef(obj, node)
					Return obj
				End If

				obj = DeserializeByType(objType, node)
			End If
		End If
	
		Return obj

	End Method


	Function GetObjRef:String(obj:Object)
?ptr64
		Return Base36(Long(bbObjectRef(obj)))
?Not ptr64
		Return Base36(Int(bbObjectRef(obj)))
?
	End Function

?ptr64
	Function Base36:String( val:Long )
		Const size:Int = 13
?Not ptr64
	Function Base36:String( val:Int )
		Const size:Int = 6
?
		Local vLong:Long = $FFFFFFFFFFFFFFFF:Long & Long(Byte Ptr(val))
		Local buf:Short[size]
		For Local k:Int=(size-1) To 0 Step -1
			Local n:Int=(vLong Mod 36) + 48
			If n > 57 n:+ 7
			buf[k]=n
			vLong = vLong / 36
		Next
		
		' strip leading zeros
		Local offset:Int = 0
		While offset < size
			If buf[offset] - Asc("0") Exit
			offset:+ 1
		Wend

		Return String.FromShorts( Short Ptr(buf) + offset,size-offset )
	End Function

	Method AddSerializer(serializer:TXMLSerializer)
		serializers.Insert(serializer.TypeName(), serializer)
		serializer.persist = Self
	End Method

	Method DeserializeReferencedObject:Object(node:TxmlNode, direct:Int = False)
		Local obj:Object
		Local ref:String = node.getAttribute("ref")
		If ref Then
			Local objRef:Object = objectMap.ValueForKey(ref)
			If objRef Then
				obj = objRef
			Else
				Throw "Reference not mapped yet : " + ref
			End If
		Else
			obj = DeserializeObject("", node, direct)
		End If
		Return obj
	End Method

	Method SerializeReferencedObject:TxmlNode(obj:Object, node:TxmlNode)
		Local ref:String = GetObjRef(obj)
		If Contains(ref, obj)
			node.setAttribute("ref", ref)
		Else
			Return SerializeObject(obj, node)
		End If
	End Method
	
End Type

Type TPersistCollisionException Extends TPersistException

	Field ref:String
	Field obj1:Object
	Field obj2:Object
	
	Function CreateException:TPersistCollisionException(ref:String, obj1:Object, obj2:Object)
		Local e:TPersistCollisionException = New TPersistCollisionException
		e.ref = ref
		e.obj1 = obj1
		e.obj2 = obj2
		Return e
	End Function
	
	Method ToString:String()
		Return "Persist Collision. Matching ref '" + ref + "' for different objects"
	End Method

End Type

Type TPersistException Extends TRuntimeException
End Type

Rem
bbdoc: 
End Rem
Type TXMLPersistenceBuilder

	Global defaultSerializers:TMap = New TMap
	Field serializers:TMap = New TMap
	
	Method New()
		For Local s:TXMLSerializer = EachIn defaultSerializers.Values()
			Register(s.Clone())
		Next
	End Method

	Rem
	bbdoc: 
	End Rem
	Method Build:TPersist()
		Local persist:TPersist = New TPersist
		persist._inited = True
		
		For Local s:TXMLSerializer = EachIn serializers.Values()
			persist.AddSerializer(s)
		Next
		
		Return persist
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Register:TXMLPersistenceBuilder(serializer:TXMLSerializer)
		serializers.Insert(serializer.TypeName(), serializer)
		Return Self
	End Method

	Rem
	bbdoc: 
	End Rem
	Function RegisterDefault(serializer:TXMLSerializer)
		defaultSerializers.Insert(serializer.TypeName(), serializer)
	End Function

End Type

Rem
bbdoc: 
End Rem
Type TXMLSerializer
	Field persist:TPersist

	Rem
	bbdoc: Returns the typeid name that the serializer handles - For example, "TMap"
	End Rem
	Method TypeName:String() Abstract
	
	Rem
	bbdoc: Serializes the object.
	End Rem
	Method Serialize(tid:TTypeId, obj:Object, node:TxmlNode) Abstract

	Rem
	bbdoc: Deserializes the object.
	End Rem
	Method Deserialize:Object(objType:TTypeId, node:TxmlNode) Abstract

	Rem
	bbdoc: Returns a new instance.
	End Rem	
	Method Clone:TXMLSerializer() Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method SerializeObject:TxmlNode(obj:Object, node:TxmlNode)
		Return persist.SerializeObject(obj, node)
	End Method
	
	Rem
	bbdoc: Iterates over all of the object fields, serializing them.
	End Rem
	Method SerializeFields(tid:TTypeId, obj:Object, node:TxmlNode)
		persist.SerializeFields(tid, obj, node)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetFileVersion:Int()
		Return persist.fileVersion
	End Method
	
	Method DeserializeObject:Object(node:TxmlNode, direct:Int = False)
		Return persist.DeserializeObject("", node, direct)
	End Method
	
	Rem
	bbdoc: Returns True if the reference has already been processed.
	End Rem
	Method Contains:Int(ref:String, obj:Object)
		Return persist.Contains(ref, obj)
	End Method
	
	Rem
	bbdoc: Adds the object reference to the object map, in order to track what object instances have been processed.
	End Rem
	Method AddObjectRef(ref:String, obj:Object)
		persist.objectMap.Insert(ref, obj)
	End Method
	
	Rem
	bbdoc: Convenience method for checking and adding an object reference.
	returns: True if the object has already been processed.
	End Rem
	Method AddObjectRefAsRequired:Int(ref:String, obj:Object)
		If Contains(ref, obj) Then
			Return True
		End If
		AddObjectRef(ref, obj)
	End Method

	Rem
	bbdoc: Adds the xml reference to the object map, in order to track what object instances have been processed.
	End Rem
	Method AddObjectRefNode(node:TxmlNode, obj:Object)
		persist.AddObjectRef(obj, node)
	End Method
	
	Rem
	bbdoc: Returns a String representation of an object reference, suitable for serializing.
	End Rem
	Method GetObjRef:String(obj:Object)
		Return TPersist.GetObjRef(obj)
	End Method
	
	Method GetReferencedObj:Object(ref:String)
		Return persist.objectMap.ValueForKey(ref)
	End Method

	Rem
	bbdoc: Serializes a single field.
	End Rem
	Method SerializeField(f:TField, obj:Object, node:TxmlNode)
		persist.SerializeField(f, obj, node)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CreateObjectInstance:Object(objType:TTypeId, node:TxmlNode)
		Return persist.CreateObjectInstance(objType, node)
	End Method

	Method DeserializeFields(objType:TTypeId, obj:Object, node:TxmlNode)
		persist.DeserializeFields(objType, obj, node)
	End Method
	
	Method DeserializeReferencedObject:Object(node:TxmlNode, direct:Int = False)
		Return persist.DeserializeReferencedObject(node, direct)
	End Method
	
	Method SerializeReferencedObject:TxmlNode(obj:Object, node:TxmlNode)
		Return persist.SerializeReferencedObject(obj, node)
	End Method
	
End Type

Type TMapXMLSerializer Extends TXMLSerializer

	Global nil:TNode = New TMap._root

	Method TypeName:String()
		Return "TMap"
	End Method
	
	Method Serialize(tid:TTypeId, obj:Object, node:TxmlNode)
		Local map:TMap = TMap(obj)
		
		If map Then
			For Local mapNode:TNode = EachIn map
				Local n:TxmlNode = node.addChild("n")
				
				SerializeReferencedObject(mapNode.Key(), n.addChild("k"))
				SerializeReferencedObject(mapNode.Value(), n.addChild("v"))
			Next
		End If
	End Method
	
	Method Deserialize:Object(objType:TTypeId, node:TxmlNode)
		Local map:TMap = TMap(CreateObjectInstance(objType, node))

		Local children:TObjectList = node.getChildren()
		If children Then
			For Local mapNode:TxmlNode = EachIn children
				Local key:Object = DeserializeReferencedObject(TxmlNode(mapNode.getFirstChild()))
				Local value:Object = DeserializeReferencedObject(TxmlNode(mapNode.getLastChild()))
			
				map.Insert(key, value)
			Next
		End If
		
		Return map
	End Method

	Method Clone:TXMLSerializer()
		Return New TMapXMLSerializer
	End Method

End Type

Type TListXMLSerializer Extends TXMLSerializer

	Method TypeName:String()
		Return "TList"
	End Method
	
	Method Serialize(tid:TTypeId, obj:Object, node:TxmlNode)
		Local list:TList = TList(obj)
		
		If list Then
			For Local item:Object = EachIn list
				SerializeReferencedObject(item, node.addChild("e"))
			Next
		End If
	End Method
	
	Method Deserialize:Object(objType:TTypeId, node:TxmlNode)
		Local list:TList = TList(CreateObjectInstance(objType, node))
		
		Local children:TObjectList = node.getChildren()
		If children Then
			For Local listNode:TxmlNode = EachIn children
				list.AddLast(DeserializeReferencedObject(listNode))
			Next
		End If
		
		Return list
	End Method

	Method Clone:TXMLSerializer()
		Return New TListXMLSerializer
	End Method

End Type

Type TIntMapXMLSerializer Extends TXMLSerializer

	Method TypeName:String()
		Return "TIntMap"
	End Method
	
	Method Serialize(tid:TTypeId, obj:Object, node:TxmlNode)
		Local map:TIntMap = TIntMap(obj)

		If map Then
			For Local mapNode:TIntKeyValue = EachIn map
				Local v:TxmlNode = node.addChild("e")
				If mapNode.Value() Then
					SerializeReferencedObject(mapNode.Value(), v)
				End If
				v.setAttribute("index", mapNode.Key())
			Next
		End If
	End Method
	
	Method Deserialize:Object(objType:TTypeId, node:TxmlNode)
		Local map:TIntMap = TIntMap(CreateObjectInstance(objType, node))

		Local children:TObjectList = node.getChildren()
		If children Then
			
			For Local mapNode:TxmlNode = EachIn children
				Local index:Int = Int(mapNode.getAttribute("index"))
				Local obj:Object = DeserializeReferencedObject(mapNode)
				map.Insert(index, obj)
			Next
		End If
		Return map
	End Method

	Method Clone:TXMLSerializer()
		Return New TIntMapXMLSerializer
	End Method

End Type

Type TStringMapXMLSerializer Extends TXMLSerializer

	Method TypeName:String()
		Return "TStringMap"
	End Method
	
	Method Serialize(tid:TTypeId, obj:Object, node:TxmlNode)
		Local map:TStringMap = TStringMap(obj)
		
		If map Then
			For Local mapNode:TStringKeyValue = EachIn map
				Local n:TxmlNode = node.addChild("n")
				SerializeReferencedObject(mapNode.Key(), n.addChild("k"))
				SerializeReferencedObject(mapNode.Value(), n.addChild("v"))
			Next
		End If
	End Method
	
	Method Deserialize:Object(objType:TTypeId, node:TxmlNode)
		Local map:TStringMap = TStringMap(CreateObjectInstance(objType, node))

		Local children:TObjectList = node.getChildren()
		If children Then
			For Local mapNode:TxmlNode = EachIn children
				Local keyNode:TxmlNode = TxmlNode(mapNode.getFirstChild())
				Local valueNode:TxmlNode = TxmlNode(mapNode.getLastChild())
				
				Local k:String = String(DeserializeReferencedObject(keyNode))
				Local v:Object = DeserializeReferencedObject(valueNode)

				map.Insert(k, v)
			Next
		End If

		Return map
	End Method

	Method Clone:TXMLSerializer()
		Return New TStringMapXMLSerializer
	End Method

End Type

TXMLPersistenceBuilder.RegisterDefault(New TMapXMLSerializer)
TXMLPersistenceBuilder.RegisterDefault(New TListXMLSerializer)
TXMLPersistenceBuilder.RegisterDefault(New TIntMapXMLSerializer)
TXMLPersistenceBuilder.RegisterDefault(New TStringMapXMLSerializer)

Extern
	Function bbEmptyStringPtr:Byte Ptr()
	Function bbNullObjectPtr:Byte Ptr()
	Function bbEmptyArrayPtr:Byte Ptr()
	Function bbObjectRef:Byte Ptr(obj:Object)
End Extern
