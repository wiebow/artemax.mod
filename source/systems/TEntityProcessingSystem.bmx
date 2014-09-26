
rem
bbdoc: A typical entity system. Use this when you need to process
entities possessing the provided component types.
end rem
Type TEntityProcessingSystem Extends TEntitySystem

	
	Rem
	bbdoc: Process an entity this system is interested in.
	endrem
	Method ProcessEntity(e:TEntity) Abstract

		
	'override
	Method ProcessEntities(entities:TBag)
		For Local i:Int = 0 To entities.GetSize()-1
			ProcessEntity(TEntity(entities.Get(i)))
		Next
	End Method
	
	
	'override
	Method CheckProcessing:Int()
		Return True
	End Method

End Type
