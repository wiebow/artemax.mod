
Type TEntitySystemTest Extends TTest

	Field s:TEntitySystemMock
	
	Method Before() {before}
		s = New TEntitySystemMock
		s._systemBit = 1
		
		TComponentType._nextBit = 1
		TComponentType._nextID = 0
		TComponentTypeManager._componentTypes.Clear()		
		
	End Method
	
	Method After() {after}
		s = Null
	End Method
	

	Method Constructor() {test}
		assertNotNull(s, "no entitysystem")
		assertNotNull(s._actives)
	End Method
	
	
	Method Change() {test}
	
		'add a componenttype to the system
		Local c:TComponentMock =  New TComponentMock
		s.RegisterComponent(c)
		
'		DebugLog TComponentTypeManager.GetTypeFor(c)._bit
'		DebugLog String(s._typeFlags)
								
		'create an entity
		Local e:TEntity = New TEntity
		e._id = 10
		s.Change(e)
		
		'entity should not be in system. it has no component
		'associated with the system.
		assertFalse(s._actives.Contains(e))

'		DebugLog "before: "+ e._systemBits

		' add the componenttype bit of our registered component	
		'this is what the entitymanager does for us
		e.AddTypeBit(TComponentTypeManager.GetTypeFor(c)._bit)
		s.Change(e)
		
'		DebugLog "after: "+ e._systemBits
		
		'should now be in active list
		assertTrue(s._actives.Contains(e), "not added!")
		
		
		'remove the component from the entity.
		e.RemoveTypeBit(TComponentTypeManager.GetTypeFor(c)._bit)
		s.Change(e)
		assertFalse(s._actives.Contains(e), "not deleted!")
	End Method	
End Type
