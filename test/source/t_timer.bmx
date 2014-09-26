
'unit tests for utils/ttimer

Type TTimerTest Extends TTest

	Field t:ttimermock
	
	Method Before() {before}
		t = New TTimerMock
	End Method
	
	Method After() {after}
		t = Null
	End Method
	

	Method Constructor() {test}		
		assertNotNull(t, "no timer")
	End Method
	
	
	Method IsRunning() {test}
		t._delay = 10
		t._done = False		
		assertTrue(t.IsRunning())
		
		t._done = True
		assertFalse(t.IsRunning())
	End Method
End Type
