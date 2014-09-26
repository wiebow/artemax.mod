


Type TComponentMock Extends TComponent
End Type

Type TComponentMock2 Extends TComponent
End Type


Type TComponentMock3 Extends TComponent {export}

	Field stringField:String = "this is a string" {exportname = "stringField"}
	Field intField:Int = 10 {exportname = "intField"}
	Field floatField:Float = 5.2 {exportname = "floatField"}
	Field byteField:Byte = 2 {exportname = "byteField"}
	Field shortfield:Short = 4 {exportname = "shortfield"}
	
End Type




Type TEntitySystemMock Extends TEntitySystem
	
	Method ProcessEntities(entities:TBag)
	End Method
	
	Method CheckProcessing:Int()
	End Method
	
	Method Initialize()
	End Method
	
	Method Added(e:TEntity)
	End Method

	Method Removed(e:TEntity)
	End Method

End Type


Type TSystemMock1 Extends TEntitySystem

	Method ProcessEntities(entities:TBag)
	End Method

	Method Initialize()
	End Method
	
	Method Change(e:TEntity)
	End Method

	Method CheckProcessing:Int()
	End Method
	
End Type


Type TSystemMock2 Extends TEntitySystem

	Method ProcessEntities(entities:TBag)
	End Method

	Method Initialize()
	End Method	
	
	Method Change(e:TEntity)		
	End Method

	Method CheckProcessing:Int()
	End Method

			
End Type


Type TTimerMock Extends TTimer

'	Function Create:TTimerMock(d:Int, r:Int)
'		Local t:TTimerMock = New TTimerMock
'		t._delay = d
'		t._repeat = r
'		t._acc = 0
'		Return t
'	End Function


	Method Execute()
	End Method

End Type