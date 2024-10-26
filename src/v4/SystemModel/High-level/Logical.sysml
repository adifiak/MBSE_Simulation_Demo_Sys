package UAVLogical{
    import LogicalElementCatalog::*;

    part def UAVLogicalModel{
        attribute position : Position;
        attribute attitude : Attitude;

        part positionMeasurement{
            port positionPort : PositionPort;
        }
        part attitudeMeasurement{
            port attitudePort : AttitudePort;
        }

        part flightControler{
            port positionPort : ~PositionPort;
            port attitudePort : ~AttitudePort;

            port controlerOutputSignalPort : ControlerOutputSignalPort;
        }

        part actuateSystem{
            port controlerOutputSignalPort : ~ControlerOutputSignalPort;
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