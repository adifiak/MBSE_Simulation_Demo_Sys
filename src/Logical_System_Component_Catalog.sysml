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
				port SurfaceReciever : SurfacePort;
				port GPSReciever : GPSPort;
				port AtmosphereReciever : AtmospherePort;
			}

			part def DetailedLogicalOperator :> LogicalOperator{
				port TelemetryReciever : ~TelemetryPort;
				port CommandTransmitter : ~CommandPort;
			}

			part def DetailedLogicalSurface :> LogicalSurface{
				port SurfaceTransmitter : ~SurfacePort;
			}

			part def DetailedLogicalGPS :> LogicalGPS{
				port GPSTransmission : ~GPSPort;
			}

			part def DetailedLogicalAtmosphere :> LogicalAtmosphere{
				port AtmosphereTransmission : ~AtmospherePort;
			}
		}

		package GeneralPartDefinitions {
			import DetailedLogicalPartDefinitions::*;
			import ScalarValues::Real;


			part def GeneralUAVComponent{
				attribute mass : Real;
			}

			part def GeneralAirframe;
			part def GeneralPowerDeliverySystem;
			part def GeneralAvionics;
			part def GeneralPropultionSystem;
			part def GeneralPayload;

			part def AbstractUAV :> DetailedLogicalSystem{
				attribute mass : Real;
				part components : GeneralUAVComponent[*];
			}
		}
	}

	package LogicalItemDefinitions {
		item def Command;
		item def Telemetry;
		item def Position;
		item def Altitude;
		item def SurfaceInformation;
		item def AtmosphericData;
	}

	package LogicalPortDefinitions {
		import LogicalItemDefinitions::*;

		port def TelemetryPort {
			out item telemetryData : Telemetry;
		}
		port def CommandPort {
			in item commandData : Command;
		}
		port def SurfacePort {
			in item surfaceData : SurfaceInformation;
		}
		port def GPSPort {
			in item positionData : Position;
		}
		port def AtmospherePort {
			in item atmosphericData : AtmosphericData;
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
			end surface: LogicalSurface;
		}

		connection def UAV_Atmosphere_Connection {
			end uav : LogicalSystem;
			end atmosphere: LogicalAtmosphere;
		}
	}
	
}