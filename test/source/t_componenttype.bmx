
Type TComponentTypeTest Extends TTest

	'no setup needed. no object created, only
	'value manipulation going on.
	
	Method GetBit() {test}
	
		Local t1:TComponentType = New TComponentType
		assertEqualsL(0, t1.GetId())
		assertEqualsI(1, t1.GetBit())
		
		assertEqualsI(1, TComponentType._nextID)		
		assertEqualsI(2, TComponentType._nextBit)
		
		Local t2:TComponentType = New TComponentType
		assertEqualsI(1, t2.GetId())
		assertEqualsI(2, t2.GetBit())
		
		'etc
	End Method

End Type