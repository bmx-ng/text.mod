SuperStrict

Framework BRL.StandardIO
Import Text.Xlsx
Import BRL.Random
Import BRL.StringBuilder

Print "********************************************************************************"
Print "DEMO PROGRAM #10: XLStyles Usage and XLSheet conditional formatting"
Print "********************************************************************************"

Local doc:TXLDocument = New TXLDocument()
doc.Create("Demo10.xlsx", True)

Print "doc.Name() is " + doc.Name()

Local numberFormats:TXLNumberFormats = doc.Styles().NumberFormats()
Local fonts:TXLFonts = doc.Styles().Fonts()
Local fills:TXLFills = doc.Styles().Fills()
Local borders:TXLBorders = doc.Styles().Borders()
'Local cellStyleFormats:TXLCellStyleFormats = doc.Styles().CellStyleFormats()
Local cellFormats:TXLCellFormats = doc.Styles().CellFormats()
Local cellStyles:TXLCellStyles = doc.Styles().CellStyles()

Local wks:TXLWorksheet = doc.Workbook().Worksheet(1)

Local cellFormatIndexA2:Size_T = wks.Cell("A2").CellFormat() ' get index of cell format
Local fontIndexA2:Size_T = cellFormats[ cellFormatIndexA2 ].FontIndex() ' get index of used font

Local newFontIndex:Size_T = fonts.Create( fonts[ fontIndexA2 ] ) ' create a new font based on used font
Local newCellFormatIndex:Size_T = cellFormats.Create( cellFormats[ cellFormatIndexA2 ] ) ' create a new cell format based on used format

cellFormats[ newCellFormatIndex ].SetFontIndex( newFontIndex ) ' assign the new font to the new cell format
wks.Cell("A2").SetCellFormat( newCellFormatIndex ) ' assign the new cell format to the cell

' change the new font style:
fonts[ newFontIndex ].SetFontName("Arial")
fonts[ newFontIndex ].SetFontSize(14)
Local red:SColor8 = New SColor8(255, 0, 0)
Local green:SColor8 = New SColor8(0, 255, 0)
Local blue:SColor8 = New SColor8(0, 0, 255)
Local yellow:SColor8 = New SColor8(255, 255, 0)
fonts[ newFontIndex ].SetFontColor( green )
fonts[ newFontIndex ].SetBold()                                        ' bold
fonts[ newFontIndex ].SetItalic()                                      ' italic
fonts[ newFontIndex ].SetStrikethrough()                               ' strikethrough
fonts[ newFontIndex ].SetUnderline(EXLUnderlineStyle.XLUnderlineDouble) ' underline: XLUnderlineSingle, XLUnderlineDouble, XLUnderlineNone
fonts[ newFontIndex ].SetUnderline(EXLUnderlineStyle.XLUnderlineNone)   ' TEST: un-set the underline status

cellFormats[ newCellFormatIndex ].SetApplyFont( true )                 ' apply the font (seems to do nothing)

wks.Cell("A25" ).SetValue("42")
Print "wks A25 value is " + wks.Cell("A25").GetValueString()

Local cellRange:TXLCellRange = wks.Range("A3", "Z10") ' range based on cell reference strings

Local sb:TStringBuilder = New TStringBuilder()
sb.Append("range ").Append(cellRange.Address())
sb.Append(" with top left ").Append(cellRange.TopLeft().Address())
sb.Append(" and bottom right ").Append(cellRange.BottomRight().Address())
sb.Append(" contains ").Append(cellRange.NumRows()).Append(" rows, ").Append(cellRange.NumColumns()).Append(" columns")
Print sb.ToString()

cellRange = wks.Range("A1:XFD100") 'range based on range reference

sb.SetLength(0)
sb.Append("range ").Append(cellRange.Address())
sb.Append(" with top left ").Append(cellRange.TopLeft().Address())
sb.Append(" and bottom right ").Append(cellRange.BottomRight().Address())
sb.Append(" contains ").Append(cellRange.NumRows()).Append(" rows, ").Append(cellRange.NumColumns()).Append(" columns")
Print sb.ToString()

Local fontBold:Size_T = fonts.Create()
fonts[ fontBold ].SetBold()
Local boldDefault:Size_T = cellFormats.Create()
cellFormats[ boldDefault ].SetFontIndex( fontBold )

cellRange = wks.Range("A5:Z5")
cellRange.SetValue("this is a bold range")
cellRange.SetFormat( boldDefault ) ' TXLCellRange supports setting format for all cells in the range

Local fontItalic:Size_T = fonts.Create()
fonts[ fontItalic ].SetItalic()
Local italicDefault:Size_T = cellFormats.Create()
cellFormats[ italicDefault ].SetFontIndex( fontItalic )

cellRange = wks.Range("E1:E100")
cellRange.SetValue("this is an italic range")
cellRange.SetFormat( italicDefault )

cellRange = wks.Range("A10:Z11")
cellRange.SetValue("lalala") ' create cells if they do not exist by assigning values to them
Local row:TXLRow = wks.Row(10)
row.Cells().SetValue("this is an italic row") ' overwrite value for all *existing* cells in row
wks.SetRowFormat( row.RowNumber(), italicDefault )  ' set format for all (existing) cells in row, and row format to be used as default for future cells

cellRange = wks.Range("J1:J100")
cellRange.SetValue("this is a bold column")
Local col:TXLColumn = wks.Column("J")      ' getting a column from a column reference
wks.SetColumnFormat( TXLCellReference.ColumnAsNumber("J"), boldDefault ) ' set format for all (existing) cells in column, and column format to be used as default for future cells

wks.SetRowFormat( 11, newCellFormatIndex )  ' set row 11 to bold italic underline strikethrough font with color as formatted above
Local redFormat:Size_T = cellFormats.Create( cellFormats[ newCellFormatIndex ] )
Local redFont:Size_T = fonts.Create()
fonts[ redFont ].SetFontColor( red )
cellFormats[ redFormat ].SetFontIndex( redFont )
cellRange = wks.Range("B2:P5")
cellRange.SetValue("red range")
wks.Cell(cellRange.TopLeft()).SetValue("red range " + cellRange.Address() + " top left cell")
wks.Cell(cellRange.BottomRight()).SetValue("red range " + cellRange.Address() + " bottom right cell")
cellRange.SetFormat( redFormat )

Local myCellRange:TXLCellRange = wks.Range("B20:P25")     ' create a new range for formatting
myCellRange.SetValue("TEST COLORS")                              ' write some values to the cells so we can see format changes
Local baseFormat:Size_T = wks.Cell("B20").CellFormat()   ' determine the style used in B20
Local newCellStyle:Size_T = cellFormats.Create( cellFormats[ baseFormat ] ) ' create a new style based on the style in B20
Local newFontStyle:Size_T = fonts.Create(fonts[ cellFormats[ baseFormat ].FontIndex() ]) ' create a new font style based on the used font
Local newFillStyle:Size_T = fills.Create(fills[ cellFormats[ baseFormat ].FillIndex() ]) ' create a new fill style based on the used fill

fonts[ newFontStyle ].SetFontColor( green )
cellFormats[ newCellStyle ].SetFontIndex( newFontStyle )

fills[ newFillStyle ].SetPatternType( EXLPatternType.XLPatternNone )
fills[ newFillStyle ].SetPatternType( EXLPatternType.XLPatternSolid )

fills[ newFillStyle ].SetColor( yellow )
fills[ newFillStyle ].SetBackgroundColor( blue )    ' blue, setBackgroundColor only makes sense with gradient fills
cellFormats[ newCellStyle ].SetFillIndex( newFillStyle )

myCellRange.SetFormat( newCellStyle ) ' assign the new format to the full range of cells

' TXLFill -> TXLGradientFill test:
myCellRange = wks.Range("B30:P35")           ' create a new range for formatting
myCellRange.SetValue("TEST GRADIENT")        ' write some values to the cells so we can see format changes
baseFormat = wks.Cell("B30").CellFormat()   ' determine the style used in B20
newCellStyle = cellFormats.Create( cellFormats[ baseFormat ] ) ' create a new style based on the style in B20
Local testGradientIndex:Size_T = fills.Create(fills[ cellFormats[ baseFormat ].FillIndex() ]) ' create a new fill style based on the used fill

fills[ testGradientIndex ].SetFillType( EXLFillType.XLPatternFill )                   ' set the "wrong" fill type
fills[ testGradientIndex ].SetFillType( EXLFillType.XLGradientFill, XLForceFillType ) ' override that with a gradientFill
fills[ testGradientIndex ].SetGradientType( EXLGradientType.XLGradientLinear )            ' the gradient type

' configure the gradient stops
Local stops:TXLGradientStops = fills[ testGradientIndex ].Stops()

' first XLGradientStop
Local stopIndex:Size_T = stops.Create()
Local stopColor:TXLDataBarColor = stops[ stopIndex ].Color()
stops[ stopIndex ].SetPosition(0.1)
stopColor.SetRgb( green )

' second XLGradientStop
stopIndex = stops.Create(stops[stopIndex]) ' create another stop using previous stop as template
stopColor.Set( yellow )
stops[ stopIndex ].SetPosition(0.5)

cellFormats[ newCellStyle ].SetFillIndex( testGradientIndex )

myCellRange.SetFormat( newCellStyle ) ' assign the new format to the full range of cells

' ===== BEGIN cell borders demo
Local borderFormat:Size_T

' create a new cell format based on the current C3 format & assign it back to C3
Local borderedCellFormat:Size_T = cellFormats.Create( cellFormats[ wks.Cell("C7").CellFormat() ] )
wks.Cell("C7").SetCellFormat( borderedCellFormat )
wks.Cell("C7").SetValue("borders demo")

' ===== Create a new border format style & assign it to the new cell format
borderFormat = borders.Create()
' NOTE: the new border format uses a default (empty) borders object to demonstrate OpenXLSX ordered inserts.
'       Using an existing border style as a template would copy the OpenXLSX default border style which
'       already contains elements in the correct sequence, so that inserts could not be demonstrated.
cellFormats[ borderedCellFormat ].SetBorderIndex( borderFormat )

borders[ borderFormat ].SetDiagonalUp( False )    ' setting this to true will apply the diagonal line style
borders[ borderFormat ].SetDiagonalDown( True )   '  - both diagonals can be applied simultaneously, but only with the same style
borders[ borderFormat ].SetOutline( True )        ' not sure if this is needed at all

' ===== Insert lines in a "wrong" sequence that MS Office would refuse to accept, to demonstrate XLStyles ordered inserting capability
borders[ borderFormat ].SetHorizontal( EXLLineStyle.XLLineStyleHair,   New SColor8( "ff446688" ) )
borders[ borderFormat ].SetVertical  ( EXLLineStyle.XLLineStyleDouble, New SColor8( "ff443322" ) )
borders[ borderFormat ].SetDiagonal  ( EXLLineStyle.XLLineStyleThick,  New SColor8( "ff332222" ), -0.25 )
borders[ borderFormat ].SetBottom    ( EXLLineStyle.XLLineStyleDotted, New SColor8( "ff222222" ), 0.25 )
borders[ borderFormat ].SetTop       ( EXLLineStyle.XLLineStyleDashed, New SColor8( "ff114444" ) )
borders[ borderFormat ].SetRight     ( EXLLineStyle.XLLineStyleMedium, New SColor8( "ff113333" ) )
borders[ borderFormat ].SetLeft      ( EXLLineStyle.XLLineStyleThin,   New SColor8( "ff112222" ) )

Print "borders[ " + borderFormat + " ] summary: " + borders[ borderFormat ].Summary()

' test additional line styles with setter function:
borders[ borderFormat ].SetLine      ( EXLLineType.XLLineVertical, EXLLineStyle.XLLineStyleSlantDashDot,     New SColor8( XLDefaultFontColor ) )
borders[ borderFormat ].SetLine      ( EXLLineType.XLLineDiagonal, EXLLineStyle.XLLineStyleMediumDashDotDot, New SColor8( XLDefaultFontColor ), -1.0 )
borders[ borderFormat ].SetLine      ( EXLLineType.XLLineBottom,   EXLLineStyle.XLLineStyleDashDotDot,       New SColor8( XLDefaultFontColor ), -0.1 )
borders[ borderFormat ].SetLine      ( EXLLineType.XLLineTop,      EXLLineStyle.XLLineStyleMediumDashDot,    green )
borders[ borderFormat ].SetLine      ( EXLLineType.XLLineRight,    EXLLineStyle.XLLineStyleDashDot,          New SColor8( XLDefaultFontColor ), 1.0 )
borders[ borderFormat ].SetLine      ( EXLLineType.XLLineLeft,     EXLLineStyle.XLLineStyleMediumDashed,     New SColor8( XLDefaultFontColor ) )

Print "borders[ " + borderFormat + " ] summary: " + borders[ borderFormat ].Summary()

' test direct access to line properties (read: the XLDataBarColor)
Local leftLine:TXLLine = borders[ borderFormat ].Left()
Local leftLineColor:TXLDataBarColor = leftLine.Color()
leftLineColor.SetRgb( blue )
leftLineColor.SetTint( -0.2 )
leftLineColor.SetAutomatic()
leftLineColor.SetIndexed( 606 )
leftLineColor.SetTheme( 707 )

Print "borders, leftLine summary: " + leftLine.Summary()
' unset some properties
leftLineColor.setTint( -0.1 )
leftLineColor.setAutomatic( false )
leftLineColor.setIndexed( 0 )
leftLineColor.setTheme( XLDeleteProperty )
' NOTE: XLDeleteProperty can be used to remove a property from XML where a value of 0 would not accomplish the same
'       formatting. Currently, only XLDataBarColor::setTheme supports this functionality. More can be added as properties
'       are discovered that have the same problem (theme="" still overrides e.g. the line color)
' std::cout << "#2 borders, leftLineColor summary: " << leftLineColor.summary() << std::endl
Print "borders, leftLineColor summary: " + leftLineColor.Summary()

' ===== END cell borders demo =====


Local mergedCellFormat:Size_T = cellFormats.Create( cellFormats[ wks.Cell("E4").CellFormat() ] )
cellFormats[ mergedCellFormat ].Alignment(XLCreateIfMissing).SetHorizontal(EXLAlignmentStyle.XLAlignCenter)
cellFormats[ mergedCellFormat ].Alignment(XLCreateIfMissing).SetVertical(EXLAlignmentStyle.XLAlignTop)
cellFormats[ mergedCellFormat ].Alignment(XLCreateIfMissing).SetTextRotation(5)
cellFormats[ mergedCellFormat ].Alignment(XLCreateIfMissing).SetWrapText(True)

wks.Cell("E4").SetValue("merged red range #1~n - hidden cell values are intact!")
wks.MergeCells("E4:G7")                     ' merge cells without deletion of contents


doc.Save()
doc.Close()
