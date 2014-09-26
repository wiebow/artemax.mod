rem
bbdoc: If you need to group your entities together, e.g. tanks going
into "units" group or explosions into "effects", then use this manager.
You must retrieve it using world instance.
An entity can only belong to one group at a time.
end rem
Type TGroupManager

	Field _world:TWorld
	
	Field _emptyBag:TBag
	
	'key: groupname, value: bag with entities	
	Field _entitiesByGroup:TMap
	
	'key: entity id, value: groupname
	Field _groupByEntity:TBag
	
	

	Rem
	bbdoc: Constructor.
	endrem
	Function Create:TGroupManager(w:TWorld)
		Local m:TGroupManager = New TGroupManager
		m._world = w
		m._emptyBag = New TBag
		m._entitiesByGroup = New TMap
		m._groupByEntity = New TBag
		Return m
	End Function


	
	rem
	bbdoc: Set the group of the entity.
	about: entity can only belong to one group.
	endrem
	Method Set(group:String, e:TEntity)
	
		'entity can only belong to one group
		Remove(e)
		
		Local entities:TBag = TBag(_entitiesByGroup.ValueForKey(group))
		If Not entities
			entities = New TBag
			_entitiesByGroup.Insert(group, entities)
		End If
		entities.Add(e)
		
		_groupByEntity.Set(e.GetId(), group)	
	End Method
	
	
	
	Rem
	bbdoc: Get all entities that belong to the provided group.
	endrem
	Method GetEntities:TBag(group:String)
		Local bag:TBag = TBag(_entitiesByGroup.ValueForKey(group))
		If Not bag Then Return _emptyBag
		Return bag
	End Method
	

		
	Rem
	bbdoc: Removes the provided entity from the group it is assigned to, if any.
	endrem
	Method Remove(e:TEntity)
		If e.GetId() < _groupByEntity.GetSize()
			Local group:String = String(_groupByEntity.Get(e.GetId()))
			If group
				_groupByEntity.Set(e.GetId(), Null)
				
				Local entities:TBag = TBag(_entitiesByGroup.ValueForKey(group))
				If entities Then entities.Remove(e)
			End If
		End If
	End Method
	

	
	Rem
	bbdoc: Returns the name of the group that this entity belongs
	to, null if none.
	endrem
	Method GetGroupOf:String(e:TEntity)
		If e.GetId() < _groupByEntity.GetSize()
			Return String(_groupByEntity.Get(e.GetId()))
		End If
		Return Null
	End Method
	
	
	
	Rem
	bbdoc: Checks if the entity belongs to any group.
	endrem
	Method IsGrouped:Int(e:TEntity)
		If GetGroupOf(e) Then Return True
		Return False	
	End Method
		
End Type
