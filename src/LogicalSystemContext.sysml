package Logical_System_Context {

	import Logical_System_Component_Catalog::*;

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
			to groundStation references logicalOperator;

		connection abstractGpsLink : UAV_GPS_Connection
			connect uav references logicalSystem
			to gps references logicalGPS;

		connection abstractSurfaceLink : UAV_Surface_Connection
			connect uav references logicalSystem
			to surface references logicalSurface;

		connection abstractAtmosphereLink : UAV_Atmosphere_Connection
			connect uav references logicalSystem
			to atmosphere references logicalAtmosphere;
				
	}

	public part def DetailedLogicalSystemContext :> LogicalSystemContext{
		import Logical_System_Component_Catalog::LogicalPortDefinitions::*;
		import Logical_System_Component_Catalog::LogicalPartDefinitions::DetailedLogicalPartDefinitions::*;

		part detailedLogicalSystem 		: DetailedLogicalSystem 	:> logicalSystem;
		part detailedLogicalOperator 	: DetailedLogicalOperator 	:> logicalOperator;
		part detailedLogicalSurface 	: DetailedLogicalSurface 	:> logicalSurface;
		part detailedLogicalGPS 		: DetailedLogicalGPS 		:> logicalGPS;
		part detailedLogicalAtmosphere 	: DetailedLogicalAtmosphere :> logicalAtmosphere;

		connection UAVDataLink ::> abstractCommLink {
			port def UAV_DataLinkPort;
			port def GS_DataLinkPort;

			end UAV : UAV_DataLinkPort{
				port TelemetryTransmitter : TelemetryPort;
				port CommandReciever : CommandPort;
			}
			end GS : GS_DataLinkPort{
				port TelemetryReciever : ~TelemetryPort;
				port CommandTransmitter : ~CommandPort;
			}
			
			connect UAV.TelemetryTransmitter to GS.TelemetryReciever;
			connect UAV.CommandReciever to GS.CommandTransmitter;
		}

		bind detailedLogicalSystem.TelemetryTransmitter = UAVDataLink.UAV.TelemetryTransmitter;
		bind detailedLogicalSystem.CommandReciever = UAVDataLink.UAV.CommandReciever;

		bind detailedLogicalOperator.TelemetryReciever = UAVDataLink.GS.TelemetryReciever;
		bind detailedLogicalOperator.CommandTransmitter = UAVDataLink.GS.CommandTransmitter;

		connection UAV_GPS_Link ::> abstractGpsLink{
			end UAV : GPSPort;
			end GPS : ~GPSPort;

			connect UAV to GPS;
		}

		bind detailedLogicalSystem.GPSReciever = UAV_GPS_Link.UAV;
		bind detailedLogicalGPS.GPSTransmission = UAV_GPS_Link.GPS;

		connection UAV_Surface_Link ::> abstractSurfaceLink{
			end UAV : SurfacePort;
			end Surface : ~SurfacePort;

			connect UAV to Surface;
		}

		bind detailedLogicalSystem.SurfaceReciever = UAV_Surface_Link.UAV;
		bind detailedLogicalSurface.SurfaceTransmitter = UAV_Surface_Link.Surface;

		connection UAV_Atmosphere_Link ::> abstractAtmosphereLink{
			end UAV : SurfacePort;
			end Atmosphere : ~AtmospherePort;

			connect UAV to Atmosphere;
		}

		bind detailedLogicalSystem.SurfaceReciever = UAV_Atmosphere_Link.UAV;
		bind detailedLogicalAtmosphere.AtmosphereTransmission = UAV_Atmosphere_Link.Atmosphere;
	}

	public part def AbstractUAVSystemWithContext :> DetailedLogicalSystemContext{
		import Logical_System_Component_Catalog::LogicalPartDefinitions::GeneralPartDefinitions::*;

		part abstractUAV : AbstractUAV :> detailedLogicalSystem{
			part generalAirframe 			: GeneralAirframe 				subsets components;
			part generalPowerDeliverySystem : GeneralPowerDeliverySystem 	subsets components;
			part generalPropultionSystem 	: GeneralPropultionSystem 		subsets components;
			part generalAvionics 			: GeneralAvionics 				subsets components;
			part generalPayload 			: GeneralPayload 				subsets components;
		}
	}
}