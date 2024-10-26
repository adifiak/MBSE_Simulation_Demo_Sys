package MotorAssemblyPhysical{
    import PhysicalElementCatalog::*;

    part def MotorAssemblyPhysicalModel{
        port def ThreePhaseMotorPort;
        interface def ThreePhaseMotorInterface{
            end controllerPort : ThreePhaseMotorPort;
            end motorPort : ~ThreePhaseMotorPort;
        }

        part ESC{
            port pwm : ~PwmPort; //TODO: Ezt szeretném bekötni a kontrollerhez.
            port threePhaseMotorPort : ThreePhaseMotorPort;
        }

        part BLDCMotor{
            port threePhaseMotorPort : ~ThreePhaseMotorPort;
        }

        part Rotor;

        interface escToMotor : ThreePhaseMotorInterface connect
            controllerPort ::> ESC.threePhaseMotorPort to
            motorPort ::> BLDCMotor.threePhaseMotorPort;

        connection motorToRotor : MechenicalConnection connect
            mount ::> BLDCMotor to
            mounted ::> Rotor;
    }
}