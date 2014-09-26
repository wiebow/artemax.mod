
rem
bbdoc: The most raw entity system. It should not typically be used, but you can create your own entity system handling by extending this.
It is recommended that you use the other provided entity system implementations.
end rem
Type TEntitySystem Abstract
	

	Field _world:TWorld
	
	'unique bit, identifying this system.
	Field _systemBit:Long

	'componenttype bits registered to the system.
	Field _typeBits:Long
	
	'active entities in this system.
	Field _actives:TBag

	
	rem
	bbdoc: User hook for additional setup code.
	about: Called by the system manager. _world is set by this time.
	endrem
	Method Initialize()
	End Method
	
	
	Method New()
		_actives = New TBag
	End Method

	
	'Returns TypeId for the system.
	Method GetClass:TTypeId() Final
		Return TTypeId.ForObject(Self)
	End Method
	
	
	Method SetWorld(w:TWorld) Final
		_world = w
	End Method
		
	
	Method SetSystemBit(bit:Long) Final
		_systemBit = bit
	End Method


	Rem
	bbdoc: Registers specified component with this system.
	about: The componenttype bit gets added to the system type bits.
	endrem
	Method RegisterComponent(c:TComponent)
		Local ct:TComponentType = TComponentTypeManager.GetTypeFor(c)
		_typeBits:| ct.GetBit()
	End Method

	
	Rem
	bbdoc: Called before processing of entities begins. 
	endrem
	Method Begin()
	End Method
	
	
	Rem
	bbdoc: The system process runs here.
	endrem
	Method Process()
		If CheckProcessing() = True
			Begin()
			ProcessEntities(_actives)
			Stop()
		End If
	End Method
	
		
	Rem
	bbdoc: Called after processing of entities ends. 
	endrem	
	Method Stop()
	End Method
	
		
	Rem
	bbdoc: Any implementing entity system must implement this method and the logic to process the given entities of the system.
	endrem	
	Method ProcessEntities(entities:TBag) Abstract	
	
	
	Rem
	bbdoc: Returns true if the system should be processed, false if not.
	endrem
	Method CheckProcessing:Int() Abstract
		
	
	Rem
	bbdoc: Called when the system has received an entity it is interested in, e.g. created or a component was added to it.
	endrem
	Method Added(e:TEntity)
	End Method	

	
	Rem
	bbdoc: Called when a entity was removed from this system, e.g. deleted or had one of it's components removed.
	endrem
	Method Removed(e:TEntity)
	End Method
	
	
	Method Change(e:TEntity)
		Local result:Long
		
		'true when entity belongs to this system
		Local _contains:Int = False		
		'true when entity uses components managed by this system
		Local _interest:Int = False
		
		result = _systemBit & e.GetSystemBits()
		If result = _systemBit Then _contains = True
	
		result = _typeBits & e.GetTypeBits()
		If result = _typeBits Then _interest = True
		
		If _interest = True And _contains = False And _typeBits > 0
		
			'entity has components managed by this system
			'but it is not yet a part of this system. add it.
			_actives.Add(e)
			e.AddSystemBit(_systemBit)
			Added(e)
		ElseIf _interest = False And _contains = True And _typeBits > 0
		
			'entity has no components from this system but it still is
			'a part of this system. remove it.
			Remove(e)
		EndIf
	End Method
	
	
	Method Remove(e:TEntity)
		_actives.Remove(e)
		e.RemoveSystemBit(_systemBit)
		Removed(e)
	End Method
	
	
	rem
	bbdoc: Returns a bag with the active entities in this system.
	endrem
	Method GetActives:TBag()
		Return _actives
	End Method

End Type
