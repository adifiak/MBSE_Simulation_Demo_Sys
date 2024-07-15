package Multicopter{
    part def MulticopterModel {
        import MulticopterLogical::*;
        import MulticopterPhysical::*;
        
		part logicalModel : MulticopterLogicalModel;
		part physicalModel : MulticopterPhysicalModel;
	}
}