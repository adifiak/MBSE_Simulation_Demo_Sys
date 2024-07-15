package Physical_System_Context {
	import PhysicalSystemComponentCatalog::PhysicalPartDefinitions::*;
	import PhysicalSystemComponentCatalog::PhysicalConnectionDefinitions::*;
	public part def PhysicalSystemContext {
		part physicalSystem : PhysicalSystem;
		part physicalOperator : PhysicalOperator;
		part physicalSurface : PhysicalSurface;
		part physicalGPS : PhysicalGPS;
		part physicalAtmosphere : PhysicalAtmosphere;

		connection abstractCommLink : UAV_GS_Connection
			connect uav references physicalSystem
			to groundStation references physicalOperator{
				interface toUAV : RadioLink
					connect uav.RadioReciever to
					groundStation.RadioTransmitter;
					frequency = 433000000;//TODO: Fix name collission
					modulation = Modulation::FM;
				interface toGS : RadioLink
					connect uav.RadioTransmitter to
					groundStation.RadioReciever;
					frequency = 433000000;
					modulation = Modulation::FM;
			}

		connection abstractGpsLink : UAV_GPS_Connection
			connect uav references physicalSystem
			to gps references physicalGPS{
				interface GPSLink :RadioLink
					connect uav.GPSReciever to
					gps.GPSTransmitter;
					frequency = 433000000;
					modulation = Modulation::FM;
			}

	}


}
