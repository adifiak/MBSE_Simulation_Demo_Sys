package Logical_System_Component_Catalog {
	package LogicalPartDefinitions {
		part def LogicalSystem;
		part def LogicalOperator;
		part def LogicalSurface;
		part def LogicalGPS;
		part def LogicalAtmosphere;

		package DetailedLogicalPartDefinitions {
			import LogicalPortDefinitions::*;

			part def DetailedLogicalSystem :> LogicalSystem{
				port TelemetryTransmitter : TelemetryPort;
				port CommandReciever : CommandPort;
				port AltitudeReciever : AltitudePort;
				port GPSReciever : GPSPort;
			}

			part def DetailedLogicalOperator :> LogicalOperator{
				port TelemetryReciever : ~TelemetryPort;
				port CommandTransmitter : ~CommandPort;
			}

			part def DetailedLogicalSurface :> LogicalSurface{
				port AltitudePercieved : ~AltitudePort;
			}

			part def DetailedLogicalGPS :> LogicalGPS{
				port GPSTransmission : ~GPSPort;
			}

			part def DetailedLogicalAtmosphere :> LogicalAtmosphere{

			}
		}
	}

	package LogicalItemDefinitions {
		item def Command;
		item def Telemetry;
		item def Position;
		item def Altitude;
	}

	package LogicalPortDefinitions {
		import LogicalItemDefinitions::*;

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
	}

	package LogicalConnectionDefinitions {
		import LogicalPartDefinitions::*;

		connection def UAV_GS_Connection {
			end uav : LogicalSystem;
			end groundStation: LogicalOperator;
		}

		connection def UAV_GPS_Connection {
			end uav : LogicalSystem;
			end gps : LogicalGPS;
		}

		connection def UAV_Surface_Connection {
			end uav : LogicalSystem;
			end surface: LogicalGPS;
		}

		connection def UAV_Atmosphere_Connection {
			end uav : LogicalSystem;
			end atmosphere: LogicalAtmosphere;
		}
	}
    
		
	
	/*
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
		
	}*/

	
}