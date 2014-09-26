
rem
bbdoc: If you need to tag any entity, use this. A typical usage
would be to tag entities such as "PLAYER". After creating an entity
call register().
end rem
Type TTagManager

	Field _world:TWorld
	
	'key: tag (string), value: entity
	Field _entityByTag:TMap
	

	
	Rem
	bbdoc: Constructor
	endrem
	Function Create:TTagManager(w:TWorld)
		Local m:TTagManager = New TTagManager
		m._world = w
		m._entityByTag = New TMap
		Return m
	End Function
	
	
	
	Rem
	bbdoc: Tags entity with specified tag.
	about: A tag can only be used once. Use grouping if you need
	to register more entities under one commmon tag/label
	endrem
	Method Register(tag:String, e:TEntity)
		_entityByTag.Insert(tag, e)
	End Method
	

	
	Rem
	bbdoc: Removes tag from the system.
	endrem
	Method UnRegister(tag:String)
		_entityByTag.Remove(tag)
	End Method
	
	
	
	Rem
	bbdoc: Returns true if tag is present in the system.
	endrem
	Method IsRegistered:Int(tag:String)
		Return _entityByTag.Contains(tag)
	End Method
	
	
	
	Rem
	bbdoc: Returns entity registered specified tag.
	endrem
	Method GetEntity:TEntity(tag:String)
		Return TEntity(_entityByTag.ValueForKey(tag))
	End Method
	
	
	
	Rem
	bbdoc: Removes entity (and its tag) from the system.
	endrem
	Method Remove(e:TEntity)
		For Local k:String = EachIn _entityByTag.Keys()
			If _entityByTag.ValueForKey(k) = e
				_entityByTag.Remove(k)
				Return			
			EndIf
		Next
	End Method
	
End Type
