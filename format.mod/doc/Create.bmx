SuperStrict

Framework Text.Format
Import BRL.StandardIO

Local formatter:TFormatter = TFormatter.Create("Value = %2.1f%%")

Print formatter.Arg(46.4).Format()

