


Type TEntityManagerTest Extends TTest

	Field w:TWorld
	Field m:TEntityManager
	
	Method Before() {before}
		w = New TWorld
		m = w.GetEntityManager()
		TComponentType._nextBit = 1
		TComponentType._nextID = 0
		TComponentTypeManager._componentTypes.Clear()
	End Method
	
	Method After() {after}
		w = Null
		m = Null
	End Method
	

	Method Constructor() {test}
		assertNotNull(m._activeEntities)
		assertNotNull(m._removedAndAvailable)
		assertNotNull(m._componentsByType)
	End Method
	
	
	Method CreateEntity() {test}
	
		'this also tests the stat methods
		assertEqualsI(0, m._nextAvailableID, "0 id")
		assertEqualsI(0, m._uniqueEntityID, "0 unique")
		assertEqualsI(0, m.GetEntityCount(), "0 count")
		assertEqualsI(0, m.GetTotalCreated(), "0 total")
		
		Local e:TEntity = m.CreateEntity(w)
		assertNotNull(e)
		
		assertEqualsI(1, m._activeEntities.GetSize())
		assertSame(e, m._activeEntities.Get(0))
		
		assertEqualsI(1, m._nextAvailableID, "0 id")
		assertEqualsI(1, m._uniqueEntityID, "0 unique")		
		assertEqualsI(1, m.GetEntityCount(), "1 count")
		assertEqualsI(1, m.GetTotalCreated(), "1 total")
	End Method
	
	
	Method IsActive() {test}
		m.CreateEntity(w)
		m.CreateEntity(w)
		assertTrue(m.IsActive(0))
		assertTrue(m.IsActive(1))
	End Method
	

	Method GetEntity() {test}
		Local e1:TEntity = m.CreateEntity(w)
		Local e2:TEntity = m.CreateEntity(w)
		assertSame(e1, m._activeEntities.Get(0))
		assertSame(e2, m._activeEntities.Get(1))
	
		assertSame(e2, m.GetEntity(1))
	End Method	
	
	
	Method AddAndGetComponent() {test}
		Local e:TEntity = m.CreateEntity(w)
		Local c:TComponentMock = New TComponentMock
		m.AddComponent(e,c)
		
		Local ct:TComponentType = TComponentTypeManager.GetTypeFor(c)
		assertSame(c, m.GetComponent(e, ct))
	End Method
	
	
	'is also using removecomponentbytype()
	Method RemoveComponent() {test}	
		Local e:TEntity = m.CreateEntity(w)
		Local c:TComponentMock = New TComponentMock
		m.AddComponent(e,c)
		
		Local ct:TComponentType = TComponentTypeManager.GetTypeFor(c)
		assertSame(c, m.GetComponent(e, ct))

		e.RemoveComponent(c)		
		assertNull(m.GetComponent(e, ct))
	End Method	

	
	Method RemoveComponentsOfEntity() {test}
		Local e:TEntity = m.CreateEntity(w)
		Local c1:TComponentMock = New TComponentMock	
		Local c2:TComponentMock2 = New TComponentMock2
		m.AddComponent(e, c1)
		m.AddComponent(e, c2)
		
		m.RemoveComponentsOfEntity(e)
		
		Local ct1:TComponentType = TComponentTypeManager.GetTypeFor(c1)
		Local ct2:TComponentType = TComponentTypeManager.GetTypeFor(c2)
		assertNull(m.GetComponent(e, ct1), "ct1 present")
		assertNull(m.GetComponent(e, ct2), "ct2 present")
	End Method

	
	
	Method Remove() {test}
	
		Local e:TEntity = m.CreateEntity(w)
		assertTrue(m.IsActive(0))		
		
		m.Remove(e)
		assertFalse(m.IsActive(0))
		
		assertNotNull(m._removedAndAvailable.Get(0))
	
	End Method
	
	
	'is entity recycled instead of a new one created?
	Method RecycleEntity() {test}
		Local e1:TEntity = m.CreateEntity(w)
		Local e2:TEntity = m.CreateEntity(w)
		assertTrue(m.IsActive(0))
		assertTrue(m.IsActive(1))
		
		m.Remove(e2)
		
		'id 1 should be in removedandavailable
		'at begin of bag
		assertSame(m._removedAndAvailable.Get(0), e2)
		
		'create an entity. it should be reused
		Local e3:TEntity = m.CreateEntity(w)
		assertSame(e2, e3)
		assertNull(m._removedAndAvailable.Get(0))
	
	End Method
	
		
	Method Exportworld() {test}
	
		Local e:TEntity = w.CreateEntity()
		e.AddComponent(New TComponentMock3)
		e.AddComponent(New TComponentMock3)
		Local s:TStream = WriteStream("test.txt")
		
'		DebugStop
		w.Export(s)
		CloseStream(s)
	
	End Method

	
'	Method Refresh() {test}
'	End Method
	


End Type
