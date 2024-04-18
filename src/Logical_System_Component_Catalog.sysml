package Logical_System_Component_Catalog {
    item def Command{}
		item def Telemetry{}
		item def Position{}
		item def Altitude{}
		
		port def TelemetryPort {
			out item TelemetryData : Telemetry;
		}
		port def CommandPort {
			in item CommandData : Command;
		}
		port def AltitudePort {
			in item CommandData : Altitude;
		}
		port def GPSPort {
			in item PositionData : Position;
		}
		interface def UAVDataLink {
			end UAV {
				port TelemetryTransmitter : ~TelemetryPort;
				port CommandReciever : ~CommandPort;
			}
			end GS {
				port TelemetryReciever : TelemetryPort;
				port CommandTransmitter : CommandPort;
			}

			connect UAV.TelemetryTransmitter to GS.TelemetryReciever;
			connect UAV.CommandReciever to GS.CommandTransmitter;
		}
		
		part def Logical_System{
			port TelemetryTransmitter : TelemetryPort;
			port CommandReciever : CommandPort;
			port AltitudeReciever : AltitudePort;
			port GPSReciever : GPSPort;
		}
		
		part def Operator{
			port TelemetryReciever : ~TelemetryPort;
			port CommandTransmitter : ~CommandPort;
		}
		
		part def Surface{
			port AltitudePercieved : ~AltitudePort;
		}
		
		part def Logical_GPS{
			port GPSTransmission : ~GPSPort;
		}
}