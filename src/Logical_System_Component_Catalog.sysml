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
			import LogicalPortDefinitions::GeneralUAVPorts::*;
			import ISQ::*;


			part def GeneralUAVComponent{
				attribute mass :> ISQ::mass;
			}

			part def GeneralAirframe 			:> GeneralUAVComponent;
			part def GeneralPowerDeliverySystem :> GeneralUAVComponent{
				port powerPort : ~PowerPort;
			}
			part def GeneralAvionics 			:> GeneralUAVComponent{
				port powerPort 		: PowerPort;
				port controlPort 	: ~ControlPort;
			}
			part def GeneralPropultionSystem 	:> GeneralUAVComponent{
				port powerPort 		: PowerPort;
				port controlPort 	: ControlPort;
			}
			part def GeneralPayload 			:> GeneralUAVComponent;

			part def AbstractUAV :> DetailedLogicalSystem{
				attribute mass :> ISQ::mass;
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
		package GeneralItemDefinitions{
			item def Power;
			item def ControlSignal;
		}
		
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

		package GeneralUAVPorts {
			import LogicalItemDefinitions::GeneralItemDefinitions::*;

			port def PowerPort {
				in item power : Power;
			}
			port def ControlPort {
				in item controlSignal : ControlSignal;
			}
		}
	}

	package LogicalConnectionDefinitions {
		import LogicalPartDefinitions::*;
		import LogicalPartDefinitions::GeneralPartDefinitions::*;

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

		interface def GeneralPowerSupplyInterface{
			end psu 	: ~PowerPort;
			end load	: PowerPort;
		}

		interface def GeneralControlInterface{
			end controler 	: ~ControlPort;
			end peripherial	: ControlPort;
		}
	}
	
}