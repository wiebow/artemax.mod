

Rem
bbdoc: System entity.
endrem
Type TEntity Final

	Field _id:Int
	Field _uniqueID:Long
	Field _typeBits:Long
	Field _systemBits:Long

	Field _world:TWorld
	Field _entityManager:TEntityManager
	

	Function Create:TEntity(w:TWorld, id:Int)
		Local e:TEntity = New TEntity
		e._world = w
		e._entityManager = w.GetEntityManager()
		e._id = id
		Return e
	End Function
	
	
	
	Rem
	bbdoc: Returns the entity id.
	endrem
	Method GetId:Int()
		Return _id
	End Method
		
	
	Rem
	bbdoc: Sets the unique id of this entity.
	endrem
	Method SetUniqueID(uniqueID:Long)
		_uniqueID = uniqueID
	End Method
		
	
	Rem
	bbdoc: Returns the unique id of this entity.
	endrem	
	Method GetUniqueID:Long()
		Return _uniqueID
	End Method
		
	
	Rem
	bbdoc: Returns the type bits.
	about: Each bit represents a componenttype.
	endrem
	Method GetTypeBits:Long()
		Return _typeBits
	End Method
	
		
	Rem
	bbdoc: Adds specified componenttype bit.
	endrem	
	Method AddTypeBit(bit:Long)
		'binary OR
		_typeBits:| bit
	End Method
		
	
	Rem
	bbdoc: Removes specified componenttype bit.
	endrem	
	Method RemoveTypeBit(bit:Long)	
		'binary AND with inversed bit
		_typeBits:& ~bit
	End Method
		
	
	Rem
	bbdoc: Returns the system bit of this entity.
	endrem
	Method GetSystemBits:Long()
		Return _systemBits		
	End Method
		
	
	Rem
	bbdoc: Adds specified bit to the systembits of this entity.
	endrem
	Method AddSystemBit(bit:Long)
		_systemBits:| bit
	End Method	

	
	
	Rem
	bbdoc: Removes specified bit from the systembits of this entity.
	endrem
	Method RemoveSystemBit(bit:Long)
		_systemBits:& ~bit
	End Method
	

		
	Rem
	bbdoc: Sets all systembits of this entity.
	endrem
	Method SetSystemBits(bits:Long)
		_systemBits = bits
	End Method


	
	Rem
	bbdoc: Sets all componenttype bits of this entity.
	endrem
	Method SetTypeBits(bits:Long)
		_typeBits = bits
	End Method
	
	
	
	Rem
	bbdoc: Resets system and componenttype bits.
	endrem
	Method Reset()
		_systemBits = 0
		_typeBits = 0
	End Method
	
	
	
	Rem
	bbdoc: Returns entity information.
	returns: String
	endrem
	Method toString:String()
		Return "Entity["+_id+"]"
	End Method
	
	
	
	Rem
	bbdoc: Adds specified component to this entity.
	endrem	
	Method AddComponent(c:TComponent)
		_entityManager.AddComponent(Self, c)
	End Method
	
	
	
	Rem
	bbdoc: Removes specified component from this entity.
	endrem
	Method RemoveComponent(c:TComponent)
		_entityManager.RemoveComponent(Self, c)
	End Method
	
	
	
	Rem
	bbdoc: Faster removal of components from a entity.
	about: The component of specified type is removed from the entity.
	endrem
	Method RemoveComponentType(ct:TComponentType )
		_entityManager.RemoveComponentByType(Self, ct)
	End Method
	
	
	
	Rem
	bbdoc: Checks if the entity is active.
	endrem
	Method IsActive:Int()
		Return _entityManager.IsActive(_id)
	End Method
	
	
	
	Rem
	bbdoc: Retrieves component fast from entity by componenttype.
	about: This is the preferred method to use when retrieving a component
	from an entity. It will provide good performance.
	In order to retrieve the component fast you must provide a componenttype
	instance for the expected component.
	endrem
	Method GetComponent:TComponent(ct:TComponentType)
		Return _entityManager.GetComponent(Self, ct)
	End Method
	
	
	
	Rem
	bbdoc: Slower retrieval of components from this entity.
	about: Minimize use of this, but it is fine to use e.g. when creating
	and setting data in components.
	Returns: component of the same type, belonging to this entity, 
	or null if none is found.
	endrem
	Method GetComponent2:TComponent(c:TComponent)
		Local ct:TComponentType = TComponentTypeManager.GetTypeFor(c)
		Return GetComponent(ct)		
	End Method

		
	
	Rem
	bbdoc: Get all components belonging to this entity. 
	about: WARNING. Use only for debugging purposes, it is dead slow.
	WARNING. The returned bag is only valid until this method is called
	again, then it is overwritten.
	returns: TBag
	endrem
	Method GetComponents:TBag()
		Return _entityManager.GetComponents(Self)
	End Method
	
	
	
	Rem
	bbdoc: Refresh all changes to components for this entity.
	about: After adding or removing components, you must call this method.
	It will update all relevant systems. It is typical to call this after
	adding components to a newly created entity.
	endrem
	Method Refresh()
		_world.refreshEntity(Self)
	End Method
	
	
	
	Rem
	bbdoc: Delete this entity from the world.
	endrem	
	Method Delete()
		_world.DeleteEntity(Self)
	End Method
	
	
	
	Rem
	bbdoc: Set the group of the entity.
	about: Same as World.setGroup().
	endrem
	Method SetGroup(group:String)
		_world.GetGroupManager().Set(group, Self)
	End Method
	
	
	
	Rem
	bbdoc: Assign a tag to this entity.
	about: Same as World.setTag().
	endrem	
	Method SetTag(tag:String)
		_world.GetTagManager().Register(tag, Self)
	End Method	
	
End Type
