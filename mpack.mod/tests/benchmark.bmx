SuperStrict

Framework BRL.StandardIO
Import Text.MPack

Const ENTRY_COUNT:Int = 4000
Const LOAD_ITERATIONS:Int = 100
Const LOOKUP_ITERATIONS:Int = 2000000

Local writer:TMPackWriter = TMPackWriter.CreateGrowable()
writer.StartArray(ENTRY_COUNT)
For Local index:Int = 0 Until ENTRY_COUNT
	writer.Write("Diagnostic " + index + ": Datei '{path}' enthält ungültigen Text — Größe {count}.")
Next
writer.FinishArray()
Local error:EMPackError
Local catalogue:Byte[] = writer.Finish(error)
If error <> EMPackError.ok Then Throw "Unable to build benchmark catalogue"

GCCollect()
Local allocationBefore:Size_T = GCMemAlloced()
Local started:Int = MilliSecs()
Local entries:String[]
Local checksum:Int
For Local iteration:Int = 0 Until LOAD_ITERATIONS
	Local reader:TMPackReader = New TMPackReader(catalogue)
	Local count:Int = Int(reader.BeginArray())
	entries = New String[count]
	For Local index:Int = 0 Until count
		entries[index] = reader.ReadString()
	Next
	reader.DoneArray()
	If reader.Free() <> EMPackError.ok Then Throw "Unable to read benchmark catalogue"
	checksum :+ entries[iteration Mod count].Length
Next
Local loadMilliseconds:Int = MilliSecs() - started
Local loadAllocated:Size_T = GCMemAlloced() - allocationBefore

started = MilliSecs()
For Local iteration:Int = 0 Until LOOKUP_ITERATIONS
	checksum :+ entries[iteration Mod entries.Length].Length
Next
Local lookupMilliseconds:Int = MilliSecs() - started

Print "entries=" + ENTRY_COUNT
Print "catalogue_bytes=" + catalogue.Length
Print "load_iterations=" + LOAD_ITERATIONS
Print "load_ms=" + loadMilliseconds
Print "load_gc_bytes=" + loadAllocated
Print "lookup_iterations=" + LOOKUP_ITERATIONS
Print "lookup_ms=" + lookupMilliseconds
Print "checksum=" + checksum
