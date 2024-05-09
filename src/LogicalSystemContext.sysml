package Logical_System_Context {
	public part def LogicalSystemContext {
		import Logical_System_Component_Catalog::LogicalPartDefinitions::*;
		import Logical_System_Component_Catalog::LogicalConnectionDefinitions::*;

		part logicalSystem 		: LogicalSystem;
		part logicalOperator 	: LogicalOperator;
		part logicalSurface 	: LogicalSurface;
		part logicalGPS 		: LogicalGPS;
		part logicalAtmosphere 	: LogicalAtmosphere;

		connection abstractCommLink : UAV_GS_Connection
			connect uav references logicalSystem
			to groundStation references logicalOperator{
				interface dataLink connect
					uav.TelemetryTransmitter to
					groundStation.TelemetryReciever;
			}

		connection abstractGpsLink : UAV_GPS_Connection
			connect uav references logicalSystem
			to gps references logicalGPS{
				interface gpsLink connect
					uav.GPSReciever to
					gps.GPSTransmission;
			}

		connection abstractSurfaceLink : UAV_Surface_Connection
			connect uav references logicalSystem
			to surface references logicalSurface{
				interface surfaceLink connect
					uav.SurfaceReciever to
					surface.SurfaceTransmitter;
			}

		connection abstractAtmosphereLink : UAV_Atmosphere_Connection
			connect uav references logicalSystem
			to atmosphere references logicalAtmosphere{
				interface surfaceLink connect
					uav.AtmosphereReciever to
					atmosphere.AtmosphereTransmission;
			}	
	}
}