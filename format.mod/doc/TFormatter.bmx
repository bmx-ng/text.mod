SuperStrict

Framework Text.Format
Import BRL.StandardIO

' Create a title
Local title:TFormatter = TFormatter.Create("%-30s %8s   %9s~n")
title.Arg("Product").Arg("Quantity").Arg("Value")

' print the title
Print title.Format()

' some data
Local prods:String[] = ["Keyboard", "Mouse", "10 CDs"]
Local amounts:Int[] = [4, 10, 15]
Local prices:Float[] = [12.99, 9.99, 5.50]

' the data formatting
Local dataFormat:TFormatter = TFormatter.Create("%-30s    %5d   %9.2f")

Local total:Float

' Print the data
For Local i:Int = 0 Until 3

	' apply the arguments
	dataFormat.Arg(prods[i])
	dataFormat.Arg(amounts[i])
	dataFormat.Arg(prices[i] * amounts[i])
	
	total:+ prices[i] * amounts[i]
	
	Print dataFormat.Format()
	
	' reset the formatter
	dataFormat.Clear()

Next

Print

' totals
Local totalFormat:TFormatter = TFormatter.Create("                                  %5s   %9.2f")
totalFormat.Arg("Total").Arg(total)

Print totalFormat.Format()

