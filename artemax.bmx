Rem
	Copyright (c) 2012 Wiebo de Wit
	
	Permission is hereby granted, free of charge, to any person obtaining a copy of this
	software and associated documentation files (the "Software"), to deal in the
	Software without restriction, including without limitation the rights to use, copy,
	modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
	and to permit persons to whom the Software is furnished to do so, subject to the
	following conditions:
	
	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
	INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
	PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
	HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
	OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
	SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
endrem

SuperStrict

Rem
bbdoc: Artemax: Artemis framework port for Blitzmax.
about: Visit http://gamadu.com/artemis/ for the java original.
endrem
Module wdw.artemax

ModuleInfo "History: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Copyright: 2012 Wiebo de Wit"

ModuleInfo "History: 1.00"
ModuleInfo "Initial Release."

Import brl.reflection
Import brl.filesystem

Include "source/utils/TBag.bmx"
Include "source/utils/TTimer.bmx"
Include "source/TWorld.bmx"
Include "source/TEntity.bmx"
Include "source/TComponent.bmx"
Include "source/TComponentMapper.bmx"
Include "source/TComponentType.bmx"
Include "source/managers/TManager.bmx"
Include "source/managers/TComponentTypeManager.bmx"
Include "source/managers/TSystemManager.bmx"
Include "source/managers/TSystemBitManager.bmx"
Include "source/managers/TTagManager.bmx"
Include "source/managers/TGroupManager.bmx"
Include "source/managers/TEntityManager.bmx"
Include "source/systems/TEntitySystem.bmx"
Include "source/systems/TEntityProcessingSystem.bmx"
Include "source/systems/TIntervalEntitySystem.bmx"
Include "source/systems/TIntervalEntityProcessingSystem.bmx"
Include "source/systems/TDelayedEntitySystem.bmx"
Include "source/systems/TDelayedEntityProcessingSystem.bmx"
