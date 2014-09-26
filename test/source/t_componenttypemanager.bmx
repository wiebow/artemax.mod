

Type TComponentTypeManagerTest Extends TTest


	Method Before() {before}
		'reset global fields before each test
		TComponentType._nextBit = 1
		TComponentType._nextID = 0
		TComponentTypeManager._componentTypes.Clear()
	End Method
	
	
	Method GetTypeFor() {test}
		Local c:TComponentMock = New TComponentMock
		Local ct:TComponentType = TComponentTypeManager.GetTypeFor(c)
		assertNotNull(ct)
		
		TComponentTypeManager.GetTypeFor(New TComponentMock)
		TComponentTypeManager.GetTypeFor(New TComponentMock)
		TComponentTypeManager.GetTypeFor(New TComponentMock)
		TComponentTypeManager.GetTypeFor(New TComponentMock)
		
		'returned type should still be the same.
		assertSame(ct, TComponentTypeManager.GetTypeFor(c))
		
		
	End Method
	
	
	Method GetBit() {test}
		Local c:TComponentMock = New Tcomponentmock
		TComponentTypeManager.GetTypeFor(c)
		
		Local bit:Int = TComponentTypeManager.GetBit(c)	
		assertEqualsI(1, bit)
		
		
		'create a new component, but of same type.
		'the bit should be the same as before as no
		'additional componenttype for TComponentMock
		'should be created.
		Local c1:TComponentMock = New Tcomponentmock
		TComponentTypeManager.GetTypeFor(c1)
		
		bit = TComponentTypeManager.GetBit(c1)
		assertEqualsI(1, bit)
		
		
		'and now mock2, which is an exention of mock
		Local c2:TComponentMock2 = New Tcomponentmock2
		TComponentTypeManager.GetTypeFor(c2)
		
		bit = TComponentTypeManager.GetBit(c2)
		assertEqualsI(2, bit)
		
	End Method
	

	Method GetId() {test}
		Local c:TComponentMock = New Tcomponentmock
		TComponentTypeManager.GetTypeFor(c)
		
		Local id:Int = TComponentTypeManager.GetBit(c)	
		assertEqualsI(1, id)
	End Method

End Type



