
rem
	bbdoc: base type for CUSTOM managers.
end rem
Type TManager Abstract

	Method GetClass:TTypeId() Final
		Local _id:TTypeId = TTypeId.ForObject( Self )
		Return _id	
	End Method
	
End Type
