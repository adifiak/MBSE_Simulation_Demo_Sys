package MotorAssemblyHighLevel{
    import ArchitectureElementCatalog::*;

    port def ThrustLevelPort{}

    part def LogicalMotorAssembly :> LogicalModel{
        port thrustLevelPort : ~ThrustLevelPort;
        part generateForce;
        part generateTorque;
    }
    
    import PhysicalElementCatalog::*;

    part def PhysicalMotorAssembly :> PhysicalModel{
        port pwm : ~PwmPort;
    }

    allocation def MotorAllocation :> ModelAllocation{
        end :>> l : LogicalMotorAssembly;
        end :>> p : PhysicalMotorAssembly;
    }
    
}