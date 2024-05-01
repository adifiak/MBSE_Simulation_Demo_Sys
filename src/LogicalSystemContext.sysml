package Logical_System_Context {

	import Logical_System_Component_Catalog::*;

	public part def LogicalSystemContext {
		part system : Logical_System;
		part operator : Logical_Operator;
		part surface : Logical_Surface;
		part gps : Logical_GPS;
		part atmosphere : Logical_Atmosphere;

		connection abstractCommLink : UAV_GS_Connection
			connect uav references system
			to groundStation references operator;

		connection abstractGpsLink : UAV_GPS_Connection
			connect uav references system
			to gps references gps;

		connection abstractSurfaceLink : UAV_GPS_Connection
			connect uav references system
			to surface references surface;

		connection abstractAtmosphereLink : UAV_Atmosphere_Connection
			connect uav references system
			to atmosphere references atmosphere;
		
		//interface DataLink : UAVDataLink /*:>> abstractCommLink*/
		//	connect UAV.TelemetryTransmitter to system.TelemetryTransmitter;		
	}
}