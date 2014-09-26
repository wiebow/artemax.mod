
Type TSystemManagerTest Extends TTest

	Field m:TSystemManager
	
	Method Before() {before}
		m = TSystemManager.Create(Null)
	End Method
	
	Method After() {after}
		m = Null
	End Method
	

	Method Constructor() {test}		
		assertNotNull(m, "no manager")
		assertNotNull(m._bagged)
		assertNotNull(m._systems)
	End Method
	
	
	
	Method SetSystem() {test}
		Local s1:TSystemMock1 = New TSystemMock1
		m.SetSystem(s1)
		assertTrue(m._bagged.Contains(s1))
	End Method
	
End Type



