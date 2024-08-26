package LogicalElementCatalog{
    part def Actuator{}
    part def Sensor{}
    part def Controller{}

    attribute def Position;
    attribute def Attitude;
    attribute def ThrustLevel;

    item def DataPacket{
        //How to add a palyload, that is an "item"?
    }
    item def Command;

    port def CommunicationPort{
        in dataPacket : DataPacket;
    }
    item def CommandPacket :> DataPacket{
        item command : Command;
    }
    item def TelemetryData{
        position : Position;
        attitude : Attitude;
    }
    item def TelemetryPacket :> DataPacket{
        item telemetryData : TelemetryData;
    }

    port def CommandCommunicationPort :> CommunicationPort{
        in commandPacket : CommandPacket :>> dataPacket;
    }
    port def TelemetryCommunicationPort :> CommunicationPort{
        in telemetryPacket : TelemetryPacket :>> dataPacket;
    }
}