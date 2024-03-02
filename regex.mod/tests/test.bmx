SuperStrict

Framework Text.Regex
Import BRL.MaxUnit

New TTestSuite.run()

Type TRegexTest Extends TTest

	Method test() { test }

	End Method

End Type

Type TRegexNoOptionsTest Extends TTest

	Field options:TRegExOptions

	Method setup() { before }

		options = New TRegExOptions

	End Method

	Method testCaseSensitivePattern() { test }
		
		options.onlyPatternOptions = True

		Local regex:TRegEx = New TRegEx("hello", options)

		AssertNotNull(regex.Find("hello"))
		AssertNull(regex.Find("Hello"))

		regex:TRegEx = New TRegEx("(?i)hello", options)

		AssertNotNull(regex.Find("hello"))
		AssertNotNull(regex.Find("Hello"))
		AssertNotNull(regex.Find("HeLLo"))

	End Method

	Method testCaseSensitiveOptions() { test }

		options.caseSensitive = True
		
		Local regex:TRegEx = New TRegEx("hello", options)

		AssertNotNull(regex.Find("hello"))
		AssertNull(regex.Find("Hello"))

		options.caseSensitive = False

		regex = New TRegEx("hello", options)

		AssertNotNull(regex.Find("hello"))
		AssertNotNull(regex.Find("Hello"))
		AssertNotNull(regex.Find("HeLLo"))

	End Method

End Type

