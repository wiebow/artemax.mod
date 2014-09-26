
rem
bbdoc: If you need to communicate with systems from another system, then 
look it up here. Use the world instance to retrieve an instance of this type.
end rem
Type TSystemManager
	
	Field _world:TWorld
	Field _systems:TMap
	Field _bagged:TBag
	
	
	Function Create:TSystemManager(w:TWorld)
		Local s:TSystemManager = New TSystemManager
		s._world = w
		s._systems = New TMap
		s._bagged = New TBag
		Return s			
	End Function

	
	Rem
	bbdoc: Adds a system.
	endrem
	Method SetSystem:TEntitySystem(s:TEntitySystem)
		s.setworld(_world)
		
		'store in systems map, by typeid
		_systems.Insert(s.GetClass(), s)
		
		'add to bag
		If Not _bagged.Contains(s)
			_bagged.Add(s)
		End If
		
		'set bit so we can identify it.
		s.SetSystemBit(TSystemBitManager.GetBitFor(s))
		Return s		
	End Method
	
	
	Rem
	about: Initializes all systems.
	endrem
	Method InitializeAll()
		For Local i:Int = 0 To _bagged.GetSize()-1
			TEntitySystem(_bagged.Get(i)).Initialize()
		Next
	End Method
	
	
	Rem
	about: Retrieves all the systems in a bag.
	returns: TBag
	endrem
	Method GetSystems:TBag()
		Return _bagged
	End Method	
	
End Type
