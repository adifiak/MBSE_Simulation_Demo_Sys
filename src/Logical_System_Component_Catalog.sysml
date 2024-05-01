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
		port def UAV_DataLinkPort;
		port def GS_DataLinkPort;

		end UAV : UAV_DataLinkPort{
			port TelemetryTransmitter : ~TelemetryPort;
			port CommandReciever : ~CommandPort;
		}
		end GS : GS_DataLinkPort{
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
		
	part def Logical_Operator{
		port TelemetryReciever : ~TelemetryPort;
		port CommandTransmitter : ~CommandPort;
	}
		
	part def Logical_Surface{
		port AltitudePercieved : ~AltitudePort;
	}
		
	part def Logical_GPS{
		port GPSTransmission : ~GPSPort;
	}

	part def Logical_Atmosphere{
		
	}

	connection def UAV_GS_Connection {
		end uav : Logical_System;
		end groundStation: Logical_Operator;
	}

	connection def UAV_GPS_Connection {
		end uav : Logical_System;
		end gps : Logical_GPS;
	}

	connection def UAV_Surface_Connection {
		end uav : Logical_System;
		end surface: Logical_GPS;
	}

	connection def UAV_Atmosphere_Connection {
		end uav : Logical_System;
		end atmosphere: Logical_Atmosphere;
	}
}