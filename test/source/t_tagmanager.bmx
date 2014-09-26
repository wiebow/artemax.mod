
'unit tests for TTagManager.

Type TTagManagerTest Extends TTest

	Field m:TTagManager
	
	Method Before() {before}
		m = TTagManager.Create(Null)
	End Method
	
	Method After() {after}
		m = Null
	End Method
	

	Method Constructor() {test}
		assertNotNull(m)
		assertNotNull(m._entityByTag)
	End Method
	
	
	Method RegisterAndGetEntity() {test}
		Local e:TEntity = New TEntity
		m.Register("tag",e)
		assertSame(e, m.GetEntity("tag"))
	End Method
	
	
	Method UnRegister() {test}
		Local e:TEntity = New TEntity
		m.Register("tag1",e)
		assertSame(e, m.GetEntity("tag1"))
		
		m.UnRegister("tag1")
		assertNull(m.GetEntity("tag1"))
	End Method
	
	
	Method IsRegisted() {test}
		Local e:TEntity = New TEntity
		m.Register("tag2",e)
		assertTrue(m.IsRegistered("tag2"))
	End Method
	
	
	Method GetEntity() {test}
		Local e:TEntity = New TEntity
		m.Register("tag3",e)
		assertSame(e, m.GetEntity("tag3"))
	End Method	
	
	
	Method Remove() {test}
		Local e:TEntity = New TEntity
		m.Register("tag4",e)
		assertTrue(m.IsRegistered("tag4"))
		
		m.Remove(e)
		assertFalse(m.IsRegistered("tag4"))
		assertNull(m.GetEntity("tag4"))
	End Method
	
End Type
