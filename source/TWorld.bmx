
rem
bbdoc: Primary instance of the Artemax framework. It contains all the managers.
about: You must use this to create, delete and retrieve entities.
It is also important to set the delta each loop iteration.
end rem
Type TWorld

	'the default framework managers
	Field _systemManager:TSystemManager
	Field _entityManager:TEntityManager
	Field _tagManager:TTagManager
	Field _groupManager:TGroupManager
	
	'delta time for update systems
	Field _delta:Double
	'tween time for render systems
	Field _tween:Double
	
	Field _refreshed:TBag
	Field _deleted:TBag
	Field _managers:TMap
	
		
	Method New()
		_systemManager = TSystemManager.Create(Self)
		_entityManager = TEntityManager.Create(Self)
		_tagManager = TTagManager.Create(Self)
		_groupManager = TGroupManager.Create(Self)

		_refreshed = New TBag
		_deleted = New TBag
		_managers = New TMap
	End Method
	
	
	Rem
	bbdoc: Returns the system manager.
	endrem
	Method GetSystemManager:TSystemManager()
		Return _systemManager
	End Method
	
		
	Rem
	bbdoc: Returns the entity manager.
	endrem	
	Method GetEntityManager:TEntityManager()
		Return _entityManager
	End Method

	
	Rem
	bbdoc: Returns group manager.
	endrem
	Method GetGroupManager:TGroupManager()
		Return _groupManager
	End Method

	
	Rem
	bbdoc: Returns tag manager.
	endrem
	Method GetTagManager:TTagManager()
		Return _tagManager
	End Method

	
	Rem
	bbdoc: Allows for setting a custom manager.
	endrem
	Method SetManager(m:TManager)
		_managers.Insert(m.GetClass(), m)
	End Method
	
		
	Rem
	bbdoc: Returns a manager of the specified ttypid.
	about: The return object has to be cast to the correct type.
	returns: Object
	endrem
	Method GetManager:Object( ti:TTypeId )
		Return _managers.ValueForKey(ti)
	End Method

		
	Rem
	bbdoc: Time since last game loop.
	returns: Delta in millisecs.
	endrem
	Method GetDelta:Double()
		Return _delta
	End Method
	
		
	Rem
	bbdoc: You must specify the delta for the game here.
	endrem
	Method SetDelta(d:Double)
		_delta = d
	End Method
	
	
	Rem
	bbdoc: Passed time since last update.
	returns: Tween in millisecs.
	endrem
	Method GetTween:Double()
		Return _tween
	End Method
	
		
	Rem
	bbdoc: Sets world tween value.
	about: You must specify the tween for render systems here.
	endrem
	Method SetTween(t:Double)
		_tween = t
	End Method
	
		
	rem
	bbdoc: Delete the provided entity from the world.
	endrem
	Method DeleteEntity(e:TEntity)
		If _deleted.Contains(e) Then Return
		_deleted.Add(e)
	End Method
		
	
	Rem
	bbdoc: Ensure all systems are notified of changs to this entity.
	endrem
	Method RefreshEntity(e:TEntity)
		_refreshed.Add(e)
	End Method
		
	
	Rem
	bbdoc: Create and return a new or reused entity instance.
	returns: TEntity
	endrem
	Method CreateEntity:TEntity()
		Return _entityManager.CreateEntity(Self)
	End Method

			
	Rem
	bbdoc: Get an entity having the specified id.
	returns: TEntity
	endrem
	Method GetEntity:TEntity(entityID:Int)
		Return _entityManager.GetEntity(entityID)
	End Method
		
	
	Rem
	bbdoc: Let framework take care of internal business.
	about: Call this at the start of your application main loop.
	endrem
	Method LoopStart()	
		If Not _refreshed.IsEmpty()
			For Local i:Int = 0 To _refreshed.GetSize()-1
				_entityManager.Refresh(TEntity(_refreshed.Get(i)))
			Next
			_refreshed.Clear()
		End If
		
		If Not _deleted.IsEmpty()
			For Local i:Int = 0 To _deleted.GetSize()-1
				Local e:TEntity = TEntity(_deleted.Get(i))
				_groupManager.Remove(e)
				_entityManager.Remove(e)
				_tagManager.Remove(e)	
			Next
			_deleted.Clear()
		End If		
	End Method
	
End Type
