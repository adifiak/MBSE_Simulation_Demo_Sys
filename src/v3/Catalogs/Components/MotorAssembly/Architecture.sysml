package MotorAssemblyArchitecture{
    import ArchitectureElementCatalog::*;
    import MotorAssemblyLogical::*;
    import MotorAssemblyPhysical::*;

    part def MotorAssemblyArchitectureModel :> Component{
        part logicalModel : MotorAssemblyLogicalModel;
        part physicalModel : MotorAssemblyPhysicalModel;
    }
}