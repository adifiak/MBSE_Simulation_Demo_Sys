package UAVArchitecture{
    import ArchitectureElementCatalog::*;
    import UAVLogical::*;
    import UAVPhysical::*;
    import MotorAssemblyArchitecture::*;

    part def UAVArchitectureModel :> ArchitectureModel{
        :>> logical : UAVLogicalModel;
        :>> physical : UAVPhysicalModel;

        // Position Measurement
        allocation positionMeasurementToGps : ModelAllocation :> allocations.suballocations 
                allocate logical.positionMeasurement to physical.gpsModule;
        allocation positionMeasurementToMicroController : ModelAllocation :> allocations.suballocations 
                allocate logical.positionMeasurement to physical.microControler;

        // Attitude Measurement
        allocation attitudeMeasurementToImu : ModelAllocation :> allocations.suballocations 
                allocate logical.attitudeMeasurement to physical.imuModule;
        allocation attitudeMeasurementToMicroController : ModelAllocation :> allocations.suballocations 
                allocate logical.attitudeMeasurement to physical.microControler;

        // Flight Controller
        allocation flightControlerToMicroController : ModelAllocation :> allocations.suballocations 
                allocate logical.flightControler to physical.microControler;
            
        // Actuation
        allocation ActuationToMicroController : ModelAllocation :> allocations.suballocations 
                allocate logical.actuateSystem to physical.microControler;
        allocation ActuationToMotorAssembly_RF : ModelAllocation :> allocations.suballocations 
                allocate logical.actuateSystem to physical.motorAssembly_RF;
        allocation ActuationToMotorAssembly_RB : ModelAllocation :> allocations.suballocations 
                allocate logical.actuateSystem to physical.motorAssembly_RB;
        allocation ActuationToMotorAssembly_LB : ModelAllocation :> allocations.suballocations 
                allocate logical.actuateSystem to physical.motorAssembly_LB;
        allocation ActuationToMotorAssembly_LF : ModelAllocation :> allocations.suballocations 
                allocate logical.actuateSystem to physical.motorAssembly_LF;
        

    }
}