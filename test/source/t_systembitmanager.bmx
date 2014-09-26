
Type TSystemBitManagerTest Extends TTest


	'ensure that system bits are reset
	Method Before() {before}
		TSystemBitManager._pos = 0	
		TSystemBitManager._systemBits.Clear()
	End Method
	
	Method After() {after}
	End Method
	
	
	Method GetBitFor() {test}
		Local s1:TSystemMock1 = New TSystemMock1
		assertEqualsL(1, TSystemBitManager.GetBitFor(s1) )

		Local s2:TSystemMock2 = New TSystemMock2
		assertEqualsL(2, TSystemBitManager.GetBitFor(s2) )
		
		assertEqualsL(1, TSystemBitManager.GetBitFor(s1) )
	End Method
	
End Type

