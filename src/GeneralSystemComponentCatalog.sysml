package GeneralSystemComponentCatalog{
    package PartDefinitions{
        import Logical_System_Component_Catalog::LogicalPartDefinitions::LogicalSystem;
        import PortDefinitions::*;
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

		part def GeneralUAV :> LogicalSystem{
			attribute mass :> ISQ::mass;
			part components : GeneralUAVComponent[*];
		}
    }

    package ItemDefinitions{
        item def Power;
		item def ControlSignal;
    }

    package PortDefinitions{
        import ItemDefinitions::*;
        port def PowerPort {
			in item power : Power;
		}
		port def ControlPort {
			in item controlSignal : ControlSignal;
		}
    }

    package InterfaceDefinitions{
        import PortDefinitions::*;
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