package Multicopter{
    part def MulticopterModel {
        import MulticopterLogical::*;
        import MulticopterPhysical::*;
        import MulticopterSimulation::*;
        
		part logicalModel : MulticopterLogicalModel;
		part physicalModel : MulticopterPhysicalModel;
        part simulationModel : MulticopterSimpleSimulationModel;

        allocate l references logicalModel to p references physicalModel{
            allocate l.attitudeSensor to p.IMU;
            allocate l.positionSensor to p.GPS;

            //Might change
            allocate l.rotor_RF to p.MotorAssembly_RF;
            allocate l.rotor_RB to p.MotorAssembly_RB;
            allocate l.rotor_LB to p.MotorAssembly_LB;
            allocate l.rotor_LF to p.MotorAssembly_LF;

            allocate l.mainController to p.mainMicrocontroller;
            allocate l.communicationModule to p.radioTranssiever;
            allocate l.telemetryModule to p.mainMicrocontroller;

            allocate l.positionSensorToMainController to p.mainMicrocontrollerToGPS.gpsUart;
            allocate l.positionSensorToTelemetryModule to p.mainMicrocontrollerToGPS.gpsUart;
            allocate l.attitudeSensorToMainController to p.mainMicrocontrollerToIMU.imuSpi;
            allocate l.attitudeSensorToTelemetryModule to p.mainMicrocontrollerToIMU.imuSpi;
            allocate l.communicationModuleToMainController to p.mainMicrocontrollerToRadio.radioUart;
            allocate l.telemetryModuleToCommunicationModule to p.mainMicrocontrollerToRadio.radioUart;

            allocate l.mainControllerToRotorRF to p.mainMicrocontrollerToMotorAssembly_RF.rfMotorPwm;
            allocate l.mainControllerToRotorRB to p.mainMicrocontrollerToMotorAssembly_RB.rbMotorPwm;
            allocate l.mainControllerToRotorLB to p.mainMicrocontrollerToMotorAssembly_LB.lbMotorPwm;
            allocate l.mainControllerToRotorLF to p.mainMicrocontrollerToMotorAssembly_LF.lfMotorPwm;
        }
	}
}