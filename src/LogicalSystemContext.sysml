package Logical_System_Context {

	import Logical_System_Component_Catalog::*;

	public part def LogicalSystemContext {
		part system : Logical_System;
		part operator : Operator;
		part surface : Surface;
		part gps : Logical_GPS;
		part atmosphere : Atmosphere;

		connection abstractCommLink : UAV_GS_Communication
			connect uav references system
			to groundStation references operator;

		//interface DataLink : UAVDataLink /*:>> abstractCommLink*/
		//	connect UAV.TelemetryTransmitter to system.TelemetryTransmitter;
		
	}
}