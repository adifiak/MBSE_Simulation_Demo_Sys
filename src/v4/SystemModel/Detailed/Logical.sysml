package QuadcopterLogical{
    import LogicalElementCatalog::*;
    import UAVLogical::*;
    import MotorAssemblyHighLevel::LogicalMotorAssembly;
    import MotorAssemblyHighLevel::ThrustLevelPort;

    part def QuadcopterLogicalModel :> UAVLogicalModel{

        :>> positionMeasurement{
            port def RawPositionDataPort;

            part collectPositionData{
                port rawPositionDataPort : RawPositionDataPort;
            }

            part processRawPositionData{
                port rawPositionDataPort : ~RawPositionDataPort;
                port positionPort : PositionPort;
            }
            
            interface rawPositionDataInterface connect
                collectPositionData.rawPositionDataPort to
                processRawPositionData.rawPositionDataPort;
        
            port positionPort : PositionPort;

            bind positionPort = processRawPositionData.positionPort;
        }
        :>> attitudeMeasurement{
            port def RawAttitudeDataPort;

            part collectAttitudeData{
                port rawAttitudeDataPort : RawAttitudeDataPort;
            }

            part processRawAttitudeData{
                port rawAttitudeDataPort : ~RawAttitudeDataPort;
                port attitudePort : AttitudePort;
            }

            interface rawPositionDataInterface connect
                collectAttitudeData.rawAttitudeDataPort to
                processRawAttitudeData.rawAttitudeDataPort;
            
            port attitudePort : AttitudePort;
            
            bind attitudePort = processRawAttitudeData.attitudePort;
            
        }

        part flightControler{
            port positionPort : ~PositionPort;
            port attitudePort : ~AttitudePort;

            port controlerOutputSignalPort : ControlerOutputSignalPort;
        }

        :>> actuateSystem{
            port controlerOutputSignalPort : ~ControlerOutputSignalPort;

            part motorMixingAlgorithm{
                port controlerOutputSignalPort : ~ControlerOutputSignalPort;

                port thrustLevelPort_RF : ThrustLevelPort;
                port thrustLevelPort_RB : ThrustLevelPort;
                port thrustLevelPort_LB : ThrustLevelPort;
                port thrustLevelPort_LF : ThrustLevelPort;
            }

            part motorAssembly_RF : LogicalMotorAssembly;
            part motorAssembly_RB : LogicalMotorAssembly;
            part motorAssembly_LB : LogicalMotorAssembly;
            part motorAssembly_LF : LogicalMotorAssembly;

            interface MMATomotorAssembly_RF connect
                motorMixingAlgorithm.thrustLevelPort_RF to
                motorAssembly_RF.thrustLevelPort;
            interface MMATomotorAssembly_RB connect
                motorMixingAlgorithm.thrustLevelPort_RB to
                motorAssembly_RB.thrustLevelPort;
            interface MMATomotorAssembly_LB connect
                motorMixingAlgorithm.thrustLevelPort_LB to
                motorAssembly_LB.thrustLevelPort;
            interface MMATomotorAssembly_LF connect
                motorMixingAlgorithm.thrustLevelPort_LF to
                motorAssembly_LF.thrustLevelPort;
        }

        interface positionSensorToFlightControler
            connect sensor references positionMeasurement.positionPort
            to fc references flightControler.positionPort{

            }
        interface attitudeSensorToFlightControler
            connect sensor references attitudeMeasurement.attitudePort
            to fc references flightControler.positionPort{

            }

        interface flightControlerToActuateSystem
            connect fc references flightControler.controlerOutputSignalPort
            to actuation references actuateSystem.controlerOutputSignalPort{

            }
    }
}