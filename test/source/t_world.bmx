

Type TWorldTest Extends TTest

	Field w:TWorld
	
	Method Before() {before}
		w = New TWorld
	End Method
	
	Method After() {after}
		w = Null
	End Method
	

	Method Constructor() {test}		
		assertNotNull(w, "no world")
		assertNotNull(w._refreshed, "no refreshed")
		assertNotNull(w._deleted, "no deleted")
		assertNotNull(w._managers, "no managers")
		
		assertNotNull(w._systemManager)
		assertNotNull(w._entityManager)
		assertNotNull(w._tagManager)
		assertNotNull(w._groupManager)
	End Method
	
	
	Method GetAndSetDelta() {test}
		w.SetDelta(10)
		assertEqualsI(10, w.GetDelta())
	End Method
	
	
	
	'export and import a world
	
	
	'todo:	
	'getentity
	'createentity
	'deleteentity
	'refreshentity
	'loopstart

End Type