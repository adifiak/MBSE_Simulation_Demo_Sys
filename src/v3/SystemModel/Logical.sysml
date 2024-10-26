package UAVLogical{
    import LogicalElementCatalog::*;

    part def UAVLogicalModel{
        attribute position : Position;
        attribute attitude : Attitude;

        part PositionMeasurement{
            port positionPort : PositionPort;
        }
        part AttitudeMeasurement{
            port attitudePort : AttitudePort;
        }

        part FlightControler{
            port positionPort : ~PositionPort;
            port attitudePort : ~AttitudePort;

            port controlerOutputSignalPort : ControlerOutputSignalPort;
        }

        part ActuateSystem{
            port controlerOutputSignalPort : ~ControlerOutputSignalPort;
        }

        interface PositionSensorToFlightControler
            connect sensor references PositionMeasurement.positionPort
            to fc references FlightControler.positionPort{

            }
        interface AttitudeSensorToFlightControler
            connect sensor references AttitudeMeasurement.attitudePort
            to fc references FlightControler.positionPort{

            }

        interface FlightControlerToActuateSystem
            connect fc references FlightControler.controlerOutputSignalPort
            to actuation references ActuateSystem.controlerOutputSignalPort{

            }
    }
}