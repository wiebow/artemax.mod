
rem
	bbdoc: If you need to process entities at a certain interval then use this.
	A typical usage would be to regenerate ammo or health at certain intervals,
	no need to do that every game loop, but perhaps every 100 ms. or every second.
end rem
Type TIntervalEntityProcessingSystem Extends TIntervalEntitySystem Abstract


	Rem
		bbdoc: Process a entity this system is interested in.
	endrem
	Method ProcessEntity(e:TEntity) Abstract
	
	
	
	'override
	Method ProcessEntities(entities:TBag)
		For Local i:Int = 0 To entities.GetSize()-1
			ProcessEntity(TEntity(entities.Get(i)))
		Next
	End Method


End Type
