package MulticopterLogical {
    part def MulticopterLogicalModel{
        import LogicalElementCatalog::*;

        part actuators  : Actuator[*];
        part sensors    : Sensor[*];

        //Are these ports accessible srom the outside?
        part def PositionSensor :> Sensor{
            port positionMeasurement{
                 out position : Position;
            }
        }
        part def AttitudeSensor :> Sensor{
            port attitudeMeasurement{
                out attitude : Attitude;
            }
        }
        //Can I do it whitout defs, and use it directly but keep the specialization?
        part positionSensor : PositionSensor :> sensors;
        part attitudeSensor : AttitudeSensor :> sensors;

        part def Rotor :> Actuator{
            port thrustCommand{
                in thrustLevel : ThrustLevel;
            }
        }

        part rotor_RF : Rotor :> actuators; //Right-Front rotor
        part rotor_RB : Rotor :> actuators; //Right-Back rotor
        part rotor_LB : Rotor :> actuators; //Left-Back rotor
        part rotor_LF : Rotor :> actuators; //Left-Front rotor

        part mainController : Controller{
            port navigationCommands{
                in command : Command;
            }

            port actualPosition{
                in position : Position;
            }
            port actualAttitude{
                in attitude : Attitude;
            }

            port thrustCommand_RF{
                out thrustLevel : ThrustLevel;
            }
            port thrustCommand_RB{
                out thrustLevel : ThrustLevel;
            }
            port thrustCommand_LB{
                out thrustLevel : ThrustLevel;
            }
            port thrustCommand_LF{
                out thrustLevel : ThrustLevel;
            }
        }

        part communicationModule{
            port rx : CommandCommunicationPort;
            port tx : ~TelemetryCommunicationPort;

            port revievedCommands{
                out command : Command;
            }
            port transmittableTelemetry{
                in telemetryData : TelemetryData;
            }

            flow of Command
                from rx.commandPacket.command
                to revievedCommands.command;
            flow of TelemetryData
                from transmittableTelemetry.telemetryData
                to tx.telemetryPacket.telemetryData;
        }

        part telemetryModule{
            port processedTelemetryData{
                out telemetryData : TelemetryData;
            }

            port positionMeasurements{
                in position : Position;
            }
            port attitudeMeasurements{
                in attitude : Attitude;
            }

            flow of Position
                from positionMeasurements.position
                to processedTelemetryData.telemetryData.position;
            flow of Attitude
                from attitudeMeasurements.attitude
                to processedTelemetryData.telemetryData.attitude;
        }

        port commandReceptionPort: CommandCommunicationPort;
        port telemetryTransmissionPort : ~TelemetryCommunicationPort;

        bind commandReceptionPort = communicationModule.rx;
        bind telemetryTransmissionPort = communicationModule.tx;

        //Sensors to Telemetry
        connection positionSensorToTelemetryModule
            connect sensor references positionSensor
            to telemetry references telemetryModule{
                interface
                    connect sensor.positionMeasurement
                    to telemetry.positionMeasurements;
            }
        connection attitudeSensorToTelemetryModule
            connect sensor references attitudeSensor
            to telemetry references telemetryModule{
                interface
                    connect sensor.attitudeMeasurement
                    to telemetry.attitudeMeasurements;
            }

        //Sensors to MainController
        connection positionSensorToMainController
            connect sensor references positionSensor
            to controller references mainController{
                interface
                    connect sensor.positionMeasurement
                    to controller.actualPosition;
            }
        connection attitudeSensorToMainController
            connect sensor references attitudeSensor
            to controller references mainController{
                interface
                    connect sensor.attitudeMeasurement
                    to controller.actualAttitude;
            }
        
        //Telemetry to Communications
        connection telemetryModuleToCommunicationModule
            connect telemetry references telemetryModule
            to comms references communicationModule{
                interface
                    connect telemetry.processedTelemetryData
                    to comms.transmittableTelemetry;
            }

        //Communications to MainController
        connection communicationModuleToMainController
            connect comms references communicationModule
            to conroller references mainController{
                interface
                    connect comms.revievedCommands
                    to conroller.navigationCommands;
            }

        //MainController to Rotors connections
        connection mainControllerToRotorRF
            connect rotor references rotor_RF
            to controller references mainController{
                interface
                    connect controller.thrustCommand_RF
                    to rotor.thrustCommand;
            }
        connection mainControllerToRotorRB
            connect rotor references rotor_RB
            to controller references mainController{
                interface
                    connect controller.thrustCommand_RB
                    to rotor.thrustCommand;
            }
        connection mainControllerToRotorLB
            connect rotor references rotor_LB
            to controller references mainController{
                interface
                    connect controller.thrustCommand_LB
                    to rotor.thrustCommand;
            }
        connection mainControllerToRotorLF
            connect rotor references rotor_LF
            to controller references mainController{
                interface
                    connect controller.thrustCommand_LF
                    to rotor.thrustCommand;
            }
    }
}