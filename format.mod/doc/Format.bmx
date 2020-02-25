SuperStrict

Framework Text.Format
Import BRL.StandardIO

Local formatter:TFormatter = TFormatter.Create("->%-10s<->%10s<->%.5s<-")

formatter.Arg("Left").Arg("Right").Arg("Trimmed")

Print formatter.Format()
