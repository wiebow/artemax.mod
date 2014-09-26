
rem
bbdoc: The entity manager holds all entities and components.
end rem
Type TEntityManager
	
	Field _world:TWorld
	
	'entities are stored here, by their id.
	Field _activeEntities:TBag
	Field _removedAndAvailable:TBag

	Field _nextAvailableID:Int
	Field _uniqueEntityID:Long
	Field _entityCount:Int
	Field _totalCreated:Long
	Field _totalRemoved:Long
	
	'stores components by type, the type Id is the index.
	'each bag slot holds a bag which contains components of that type.
	'the index in that bag is the entity id
	Field _componentsByType:TBag

	
	Function Create:TEntityManager(w:TWorld)
		Local e:TEntityManager = New TEntityManager
		e._world = w
		e._activeEntities  = New TBag
		e._removedAndAvailable = New TBag
		e._componentsByType = New TBag
		Return e
	End Function
	
		
	rem
	bbdoc: Creates an entity.
	endrem
	Method CreateEntity:TEntity(w:TWorld)
		Local e:TEntity
		
		'try to recycle entity and ID
		'create a new entity if needed
		e = TEntity(_removedAndAvailable.RemoveLast())
		If Not e
			e = TEntity.Create(_world, _nextAvailableID)
			_nextAvailableID:+ 1
		Else
			e.Reset()
		End If
		
		'lets make it really unique
		e.SetUniqueID( _uniqueEntityID )
		_uniqueEntityID:+ 1
		
		'mark as active
		_activeEntities.Set(e.GetId(), e)
		
		'update statistics
		_entityCount:+ 1
		_totalCreated:+ 1
		
		Return e
	End Method
	
	
	Rem
	bbdoc: Removes entity.
	about: Also removes all its components from the system.
	endrem
	Method Remove(e:TEntity)
		_activeEntities.Set(e.GetId(), Null)
		e.SetTypeBits(0)
		Refresh(e)		
		RemoveComponentsOfEntity(e)

		_entityCount:- 1
		_totalRemoved:+ 1
		_removedAndAvailable.Add(e)
	End Method
		
	
	Rem
	bbdoc: Removes all components from the entity.
	endrem
	Method RemoveComponentsOfEntity(e:TEntity)	
		For Local i:Int = 0 To _componentsByType.GetSize()-1
			
			'go through each component type
			Local components:TBag = TBag(_componentsByType.Get(i))
			
			'if bag of this type exists...
			If components
				'and if the entity ID fits in the bag...
				If e.GetId() < components.GetSize()
				
					'clear out the component entry for this entity
					components.Set(e.GetId(), Null)
				EndIf
			End If
		Next
	End Method
	
		
	Rem
	bbdoc: Returns true if the entity with specified id is live
	endrem
	Method IsActive:Int(id:Int)
		If _activeEntities.Get(id) Then Return True
		Return False
	End Method
	
	
	Rem
	bbdoc: Adds specified component to entity.
	about: Also registers the component's type.
	endrem
	Method AddComponent(e:TEntity, c:TComponent)
	
		'see if the component's type is known.
		'if not, TComponentTypeManager returns a new componenttype.
		Local ct:TComponentType = TComponentTypeManager.GetTypeFor(c)

		'ensure there is a bag spot in case we need to create a new one.
		If ct.GetId() >= _componentsByType.GetCapacity()
			_componentsByType.Set(ct.GetId(), Null)
		EndIf
		
		'retrieve the bag with components of the same type.
		'if needed, create and store a new bag for this componenttype
		Local components:TBag = TBag(_componentsByType.Get(ct.GetId()))
		If Not components
			components = New TBag
			_componentsByType.Set(ct.GetId(), components)
		End If
		
		'add the component to the componenttype bag
		'the index under which it is stored is the entity ID
		components.Set(e.GetId(), c)
		
		'add type bit to entity so it knows it has a
		'component of this type. This is used by TEntitySystem.Change()
		e.AddTypeBit(ct.GetBit())
	
	End Method	

	
	Rem
	bbdoc: Refreshes specified entity in all systems.
	about: Each system will check if the entity belongs to the system
	and if a component in the entity needs to be registered in that
	system.
	endrem	
	Method Refresh(e:TEntity)
		Local systemManager:TSystemManager = _world.GetSystemManager()
		Local systems:TBag = TBag(systemManager.GetSystems())
		
		For Local i:Int = 0 To systems.GetSize()-1
			TEntitySystem(systems.Get(i)).Change(e)
		Next
	End Method
	
	
	Rem
	bbdoc: Removes specified component from entity.
	endrem	
	Method RemoveComponent(e:TEntity, c:TComponent)
		Local ct:TComponentType = TComponentTypeManager.GetTypeFor(c)
		RemoveComponentByType(e, ct)
	End Method
		
	
	Rem
	bbdoc: Removes component from entity by specified type.
	endrem
	Method RemoveComponentByType(e:TEntity, ct:TComponentType)
		Local components:TBag = TBag(_componentsByType.Get(ct.GetId()))
		components.Set(e.GetId(), Null)
		
		'remove entry from entity
		e.RemoveTypeBit(ct.GetBit())
	End Method
		
	
	Rem
	bbdoc: Returns component of specified type in this entity.
	about: An entity can only hold one component of a type.
	returns: TComponent
	endrem
	Method GetComponent:TComponent(e:TEntity, ct:TComponentType)
		Local components:TBag = TBag(_componentsByType.Get(ct.GetId()))
		If components
			If e.GetId() < components.GetSize()
				Return TComponent(components.Get(e.GetId()))
			EndIf
		EndIf
		Return Null
	End Method
		
	
	Rem
	bbdoc: Returns entity with specified id.
	returns: TEntity
	endrem
	Method GetEntity:TEntity(entityID:Int)
		Return TEntity(_activeEntities.Get(entityID))
	End Method
	
	
	rem
	bbdoc: Returns number of entities in the system.
	endrem
	Method GetEntityCount:Int()
		Return _entityCount
	End Method
	
	
	rem
	bbdoc: Returns the number of entities created.
	endrem
	Method GetTotalCreated:Long()
		Return _totalCreated
	End Method
	
	
	rem
	bbdoc: Returns the number of entities deleted.
	endrem	
	Method GetTotalRemoved:Long()
		Return _totalRemoved
	End Method
	
	
	Rem
	bbdoc: Returns a bag holding all components of specified entity.
	about: Use for debugging or export only. It is slow.
	endrem
	Method GetComponents:TBag(e:TEntity)
		Local bag:TBag = New TBag
		For Local i:Int = 0 To _componentsByType.GetSize()-1
			Local components:TBag = TBag(_componentsByType.Get(i))
			If components And e.GetId() < components.GetSize()-1
				Local cp:TComponent = TComponent(components.Get(e.GetId()))
				If cp Then bag.Add(cp)
			End If
		Next
		Return bag
	End Method
	
	
	rem
	bbdoc: Return the active entities bag.
	endrem
	Method GetActiveEntities:TBag()
		Return _activeEntities
	End Method

End Type
