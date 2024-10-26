package QuadcopterArchitecture{
    import ArchitectureElementCatalog::*;
    import UAVArchitecture::*;
    import QuadcopterLogical::*;
    import QuadcopterPhysical::*;
    import MotorAssemblyArchitecture::*;

    part def QuadcopterArchitectureModel :> UAVArchitectureModel{
        :>> logical : QuadcopterLogicalModel;
        :>> physical : QuadcopterPhysicalModel;

        // Position Measurement
        allocation :>> positionMeasurementToGps{
            end :>> source ::> logical.positionMeasurement;
            end :>> target ::> physical.gpsModule;
            allocation collectPositionDataToGps allocate source.collectPositionData to target;
        }
        allocation :>> positionMeasurementToMicroController{
            end :>> source ::> logical.positionMeasurement;
            end :>> target ::> physical.microControler;
            allocation processRawPositionDataToGps allocate source.processRawPositionData to target;
        }

        // Attitude Measurement
        allocation :>> attitudeMeasurementToImu{
            end :>> source ::> logical.attitudeMeasurement;
            end :>> target ::> physical.imuModule;
            allocation collectAttitudeDataToGps allocate source.collectAttitudeData to target;
        }
        allocation :>> attitudeMeasurementToMicroController{
            end :>> source ::> logical.attitudeMeasurement;
            end :>> target ::> physical.microControler;
            allocation processRawAttitudeDataToGps allocate source.processRawAttitudeData to target;
        }

        // Actuation
        allocation :>> ActuationToMicroController{
            end :>> source ::> logical.actuateSystem;
            end :>> target ::> physical.microControler;
            allocation MMAToMicroController allocate source.motorMixingAlgorithm to target;
        }
        allocation :>> ActuationToMotorAssembly_RF{
            end :>> source ::> logical.actuateSystem;
            end :>> target ::> physical.motorAssembly_RF;
            allocation MMAToMicroController allocate source.motorAssembly_RF to target;
        }
        allocation :>> ActuationToMotorAssembly_RB{
            end :>> source ::> logical.actuateSystem;
            end :>> target ::> physical.motorAssembly_RF;
            allocation MMAToMicroController allocate source.motorAssembly_RB to target;
        }
        allocation :>> ActuationToMotorAssembly_LB{
            end :>> source ::> logical.actuateSystem;
            end :>> target ::> physical.motorAssembly_RF;
            allocation MMAToMicroController allocate source.motorAssembly_LB to target;
        }
        allocation :>> ActuationToMotorAssembly_LF{
            end :>> source ::> logical.actuateSystem;
            end :>> target ::> physical.motorAssembly_RF;
            allocation MMAToMicroController allocate source.motorAssembly_LF to target;
        }

    }
}