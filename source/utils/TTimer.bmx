rem
	bbdoc: Type description
end rem
Type TTimer Abstract
	
	Field _delay:Int
	Field _repeat:Int
	Field _acc:Int
	Field _done:Int
	Field _stopped:Int
	
	
	Method Execute() Abstract
	
	
'	Function Create:TTimer(d:Int, r:Int)
'		Local t:TTimer = New TTimer
'		t._delay = d
'		t._repeat = r
'		t._acc = 0
'		Return t
'	End Function
	
	
	
	Method Update( delta:Int)		
		If Not _done And Not _stopped
			_acc:+ delta
			If _acc >= _delay
				_acc :- _delay				
				If _repeat
					Reset()
				Else
					_done = True
				End If
				Execute()
			End If
		EndIf
	End Method
	
	
	
	Method Reset()
		_stopped = False
		_done =False
		_acc = 0
	End Method
	
	
	
	Method IsDone:Int()
		Return _done
	End Method
	
	
	
	Method IsRunning:Int()
		Return Not _done And _acc < _delay And Not _stopped
	
'		If Not done And acc < Delay And Not stopped
'			Return True
'		End If
	End Method
	
	
	
	Method Stop()
		_stopped = True
	End Method
	
	
	
	Method SetDelay(d:Int)
		_delay = d
	End Method
	
	

	Method GetDelay:Int()
		Return _delay
	End Method

	
		
	Method GetPercentageRemaining:Float()
		If _done
			Return 100.0
		ElseIf _stopped
			Return 0.0
		Else
			Return 1 - (_delay - _acc) / _delay
		End If
	End Method
	
End Type
