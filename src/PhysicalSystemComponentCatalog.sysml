package PhysicalSystemComponentCatalog {
	package PhysicalPartDefinitions {
		import PhysicalPortDefinitions::*;

		part def PhysicalSystem{
			port RadioReciever : RadioPort;
			port RadioTransmitter : ~RadioPort;
			port GPSReciever : RadioPort;

			//port SurfaceReciever : SurfacePort;
			//port AtmosphereReciever : AtmospherePort;
		}

		part def PhysicalOperator{
			port RadioReciever : RadioPort;
			port RadioTransmitter : ~RadioPort;
		}

		part def PhysicalSurface{
			//port SurfaceTransmitter : ~SurfacePort;
		}

		part def PhysicalGPS{
			port GPSTransmitter : ~RadioPort;
		}

		part def PhysicalAtmosphere{
			//port AtmosphereTransmission : ~AtmospherePort;
		}
	}

	package PhysicalItemDefinitions {
		item def PhysicalSignal;
		item def Measurement;// TODO: Should refine these two.
		item def Position;
		item def Altitude;
		item def SurfaceInformation;
		item def AtmosphericData;
	}

	package PhysicalPortDefinitions {
		import PhysicalItemDefinitions::*;

		port def RadioPort {}

		port def SensorPort { //TODO: Add active and passive sensores
			in item signal : PhysicalSignal;
		}

		port def MeasureablePropertyPort{
			out item measurement;
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

	package PhysicalConnectionDefinitions {
		import ISQSpaceTime::frequency;
		import PhysicalPartDefinitions::*;

		enum def Modulation {
			enum FM;
			enum AM;
			enum IQ;
		}

		interface def RadioLink {
			attribute frequency;//Is this good?
			attribute modulation : Modulation;
			end tx : RadioPort;
			end rx : ~RadioPort;
		}

		connection def UAV_GS_Connection {
			end uav : PhysicalSystem;
			end groundStation: PhysicalOperator;
		}

		connection def UAV_GPS_Connection {
			end uav : PhysicalSystem;
			end gps : PhysicalGPS;
		}

		/*connection def UAV_Surface_Connection {
			end uav : PhysicalSystem;
			end surface: PhysicalSurface;
		}

		connection def UAV_Atmosphere_Connection {
			end uav : PhysicalSystem;
			end atmosphere: PhysicalAtmosphere;
		}*/
	}	
}