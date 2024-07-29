package SystemContext{
    import SystemContextLogical::*;
    import SystemContextPhysical::*;

    part def SystemContextModel{
        part logicalModel : ContextModelLogical;
		part physicalModel : ContextModelPhysical;
    }
}