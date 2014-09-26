rem
bbdoc: Manages system identifier bits.
end rem
Type TSystemBitManager
	
	'how many times to shift new bit left
	Global _pos:Int = 0
	
	'stores systems and their bits
	'key: system, value: bit (as string)
	Global _systemBits:TMap = New TMap
	
	
	
	Rem
	bbdoc: Retrieves indentifier bit for specified system.
	endrem
	Function GetBitFor:Long( s:TEntitySystem )
		
		'bit is stored as a string, so cast needed
		Local val:String = String(_systemBits.ValueForKey(s))
		Local bit:Long = val.ToLong()

		If bit = Null
			'generate new bit.
			'shift bit left * _pos
			bit = 1 Shl(_pos)
			_pos:+ 1
			
			'Long is not an object, so cast to string.
			_systemBits.Insert(s, String(bit))
		End If
		
		Return bit
	End Function

End Type
