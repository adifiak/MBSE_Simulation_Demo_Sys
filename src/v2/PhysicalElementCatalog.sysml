package PhysicalElementCatalog{
    part def Component{
        attribute mass :> ISQ::mass; 
    }

    part def CompositeComponent :> Component{
        import NumericalFunctions::*;

        part subComponents : Component[*];

        attribute redefines mass = sum(subComponents.mass);
    }

    part def Microcontroller :> Component{

    }

    port def RadioPort {
        attribute maxFrequency :> ISQSpaceTime::frequency;
        attribute minFrequency :> ISQSpaceTime::frequency;
    }

    interface def RadioLink {
			attribute frequency :> ISQSpaceTime::frequency;
			end tx : RadioPort;
			end rx : ~RadioPort;
		}

    port def uartPort{}

    interface def UARTinterface{
        end master : uartPort;
        end slave : uartPort;
    }

    port spiPort{
        end master : uartPort;
        end slave : uartPort;
    }
}