
rem
	bbdoc: A system that processes entities at a interval in milliseconds.
	A typical usage would be a collision system or physics system.
end rem
Type TIntervalEntitySystem Extends TEntitySystem

	Field _acc:Int
	Field _interval:Int
	
	
	'override
	Method CheckProcessing:Int()
		_acc :+ _world.GetDelta()
		If _acc >= _interval
			_acc:- _interval
			Return True
		End If
		Return False	
	End Method
	
End Type
