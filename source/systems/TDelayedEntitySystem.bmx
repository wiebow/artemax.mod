rem
bbdoc: The purpose of this class is to allow systems to execute at varying intervals.
	
An example system would be an ExpirationSystem, that deletes entities after a certain
lifetime. Instead of running a system that decrements a timeLeft value for each
entity, you can simply use this system to execute in a future at a time of the shortest
lived entity, and then reset the system to run at a time in a future at a time of the 
shortest lived entity, etc.
	
Another example system would be an AnimationSystem. You know when you have to animate
a certain entity, e.g. in 300 milliseconds. So you can set the system to run in 300 ms.
to perform the animation.
	
This will save CPU cycles in some scenarios.
	
Make sure you detect all circumstances that change. E.g. if you create a new entity you
should find out if you need to run the system sooner than scheduled, or when deleting
a entity, maybe something changed and you need to recalculate when to run. Usually this
applies to when entities are created, deleted, changed.
end rem
Type TDelayedEntitySystem Extends TEntitySystem

	Field _delay:Int
	Field _running:Int
	Field _acc:Int
	
	
	'override
	Method CheckProcessing:Int()
		If _running
			_acc:+ _world.GetDelta()
			If _acc >= _delay Then Return True
		End If
		Return False
	End Method
		
	
	Rem
	bbdoc: The entities to process with accumulated delta.
	endrem
	Method ProcessDelayedEntities(entities:TBag, accumulatedDelta:Int) Abstract


	'override
	Method ProcessEntities(entities:TBag) Final
		ProcessDelayedEntities(entities, _acc)
	End Method
	
		
	Rem
	bbdoc: Start processing of entities after a certain amount of milliseconds.
	about: Cancels current delayed run and starts a new one. 
	endrem
	Method StartDelayedRun(d:Int)
		_delay = d
		_acc = 0
		_running = True
	End Method
	
	
	Rem
	bbdoc: Get the initial delay that the system was ordered to process entities after.
	endrem
	Method GetInitialTimeDelay:Int()
		Return _delay
	End Method
	
	
	Rem
	bbdoc: Returns the time remaining before the system starts processing.
	endrem
	Method GetRemainingTimeUntilProcessing:Int()
		If _running
			Return _delay - _acc
		End If
		Return 0
	End Method
	
	
	Rem
	bbdoc: Returns true if the system is running.
	endrem
	Method IsRunning:Int()
		Return _running
	End Method
	
	
	Rem
	bbdoc: Aborts running the system in the future and stops it.
	Call delayedRun() to start it again.
	End Rem
	Method Stop()
		_running = False
		_acc = 0
	End Method	
	
End Type
