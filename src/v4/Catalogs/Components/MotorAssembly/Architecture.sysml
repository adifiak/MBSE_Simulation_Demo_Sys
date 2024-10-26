package MotorAssemblyArchitecture{
    import ArchitectureElementCatalog::*;
    import MotorAssemblyLogical::*;
    import MotorAssemblyPhysical::*;

    part def MotorAssemblyArchitectureModel :> ArchitectureModel{
        part MotorAssemblyLogicalModel :> logical;
        part MotorAssemblyPhysicalModel :> physical;
    }
}