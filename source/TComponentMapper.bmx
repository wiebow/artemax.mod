
rem
	bbdoc: High performance component retrieval from entities.
	about: Use this wherever you need to retrieve components from entities often and fast.
end rem
Type TComponentMapper Extends TComponent

	Field _type:TComponentType
	Field _em:TEntityManager
	
	
	Function Create:TComponentMapper(c:TComponent, w:TWorld)
		Local m:TComponentMapper = New TComponentMapper
		m._em = w.GetEntityManager()
		m._type = TComponentTypeManager.GetTypeFor(c)
		Return m
	End Function
	
	
	Rem
		bbdoc: Returns the component of mapped type belonging to specified entity.
		returns: TComponent
	endrem
	Method Get:TComponent(e:TEntity)
		Return _em.GetComponent(e, _type)
	End Method
	
End Type

