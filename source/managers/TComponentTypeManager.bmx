
rem
bbdoc: manages component types
about: Type is not created, only its functions are used.
end rem
Type TComponentTypeManager
	
	'key: TTypeID (as string), value: ComponentType
	Global _componentTypes:TMap = New TMap

	
	
	Rem
	bbdoc: Retrieves componenttype for specified component.
	about: Creates a new componenttype if none exists.
	endrem	
	Function GetTypeFor:TComponentType(c:TComponent)
	
		Local tid:String = TTypeId.ForObject(c).toString()
		Local ct:TComponentType = TComponentType(_componentTypes.ValueForKey(tid))
		If Not ct
			ct = New TComponentType
			_componentTypes.Insert(tid, ct)
		End If
		Return ct
	End Function
	
	
	
	Rem
	bbdoc: Retrieves bit of componenttype for specified component.
	endrem
	Function GetBit:Long(c:TComponent)
		Return GetTypeFor(c).GetBit()
	End Function

	
	
	Rem
	bbdoc: Retrieves id of componenttype for specified component.
	endrem
	Function GetId:Int(c:TComponent)
		Return GetTypeFor(c).GetId()
	End Function

End Type