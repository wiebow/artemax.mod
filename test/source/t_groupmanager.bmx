
'unit tests for tgroupmanager.

Type TGroupManagerTest Extends TTest

	Field m:TGroupManager
	Field w:TWorld
	
	Method Before() {before}
		w = New TWorld
		m = w.GetGroupManager()
	End Method
	
	Method After() {after}
		w = Null
		m = Null
	End Method
	

	Method Constructor() {test}
		assertNotNull(m)
		assertNotNull(m._emptyBag)
		assertNotNull(m._entitiesByGroup)
		assertNotNull(m._groupByEntity)
	End Method


	Method Set() {test}
	
		'also tests GetGroupOf() and GetEntities()
	
		Local e1:TEntity = w.CreateEntity()
		m.Set("test1", e1)
		Local e2:TEntity = w.CreateEntity()
		m.Set("test2", e2)
		
		'bags should be created
		assertNotNull(m._entitiesByGroup.ValueForKey("test1"))
		assertNotNull(m._entitiesByGroup.ValueForKey("test2"))
		
		'entities in correct group bag?		
		assertEquals("test1", m.GetGroupOf(e1), "not in test 1")
		assertEquals("test2", m.GetGroupOf(e2), "not in test 2")
		
		'move to other group
		m.Set("test2", e1)
		assertEquals("test2", m.GetGroupOf(e1), "not in test2")
		
		'this bag should now be empty
		Local b:TBag = m.GetEntities("test1")
		assertEqualsI(0, b.GetSize(), "test1 not empty")
		
	End Method
	
	
	Method IsGrouped() {test}	
		Local e:TEntity = w.CreateEntity()
		m.Set("test", e)
		assertTrue(m.IsGrouped(e))
	End Method
	
	
	Method Remove() {test}
		Local e:TEntity = w.CreateEntity()

		m.Set("test", e)
		assertTrue(m.IsGrouped(e))	
		m.Remove(e)
		assertFalse(m.IsGrouped(e))	
	End Method
		
	
	Method GetGroupOf() {test}
		Local e:TEntity = w.CreateEntity()
		m.Set("test", e)
		assertEquals("test", m.GetGroupOf(e))
	End Method
	
End Type
