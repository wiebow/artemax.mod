
rem
bbdoc: If you need to process entities after a certain interval then use this.
end rem
Type TDelayedEntityProcessingSystem Extends TDelayedEntitySystem

	Rem
	bbdoc: Process a entity this system is interested in.
	endrem
	Method ProcessDelayedEntity(e:TEntity, accumulatedDelta:Int) Abstract
		
	'override
	Method ProcessDelayedEntities(entities:TBag, accumulatedDelta:Int)
		For Local i:Int = 0 To entities.GetSize()-1
			ProcessDelayedEntity(TEntity(entities.Get(i)), accumulatedDelta)
		Next
	End Method

End Type
