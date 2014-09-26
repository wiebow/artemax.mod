
rem
	bbdoc: each component has a bit and id
	about: This type links the two together in the TComponentTypeManager
end rem
Type TComponentType
	
	'global values known to all componenttypes
	Global _nextBit:Long = 1
	Global _nextID:Long = 0
	
	'private values for each componenttype object
	Field _bit:Long
	Field _id:Int

	
	Method New()
		_bit = _nextBit
		_nextBit = _nextBit Shl(1)
		_id = _nextID
		_nextID:+ 1
	End Method
	
	
	Method GetBit:Long()
		Return _bit
	End Method
	
	
	Method GetId:Int()
		Return _id
	End Method

End Type
