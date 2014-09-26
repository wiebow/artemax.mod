

Type TEntityTest Extends TTest

	Field w:TWorld
	Field e:TEntity
	
	
	Method Before()' {before}
		w = New TWorld
		e = Null
	End Method
	
	Method After()' {after}
		w = Null
		e = Null
	End Method
	
	
	Method Constructor()' {test}
		e = w.CreateEntity()
		assertNotNull(e)
	End Method
	


End Type