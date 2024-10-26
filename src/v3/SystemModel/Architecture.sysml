package UAVArchitecture{
    import ArchitectureElementCatalog::*;
    import UAVLogical::*;
    import UAVPhysical::*;
    import MotorAssemblyArchitecture::*;

    part def UAVArchitectureModel :> Component{
        part logicalModel : UAVLogicalModel;
        part physicalModel : UAVPhysicalModel;

        part MotorAssemblyRF : MotorAssemblyArchitectureModel :> subcomponents;
        part MotorAssemblyRB : MotorAssemblyArchitectureModel :> subcomponents;
        part MotorAssemblyLB : MotorAssemblyArchitectureModel :> subcomponents;
        part MotorAssemblyLF : MotorAssemblyArchitectureModel :> subcomponents;

        //TODO: Itt az architektúra modell, ahol esetleg lehet még trükközni amiket én javasoltam azok itt lennének.
    }
}