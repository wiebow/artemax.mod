
SuperStrict

Framework bah.maxunit

Import wdw.artemax

Include "source/mocks.bmx"
Include "source/t_bag.bmx"
Include "source/t_timer.bmx"
Include "source/t_entitymanager.bmx"
Include "source/t_systembitmanager.bmx"
Include "source/t_componenttype.bmx"
Include "source/t_componenttypemanager.bmx"
Include "source/t_groupmanager.bmx"
Include "source/t_tagmanager.bmx"
Include "source/t_systemmanager.bmx"

Include "source/t_entitysystem.bmx"

'tested in other tests.
Include "source/t_entity.bmx"
Include "source/t_world.bmx"

'need work
'Include "source/t_componentmapper.bmx"

New TTestSuite.run()
