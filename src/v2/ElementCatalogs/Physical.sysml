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
        //Pins...
    }

    port def RadioPort {
        attribute maxFrequency :> ISQSpaceTime::frequency;
        attribute minFrequency :> ISQSpaceTime::frequency;
    }

    interface def RadioLink {
			attribute frequency :> ISQSpaceTime::frequency;
			end tx : ~RadioPort;
			end rx : RadioPort;
		}

    port def UartPort{}

    interface def UARTinterface{
        end master : UartPort;
        end slave : UartPort;
    }

    port def SpiPort{}

    interface def SPIinterface{
        end master : SpiPort;
        end slave : SpiPort;
    }

    port def PwmPort{}

    interface def PWMinterface{
        end source : PwmPort;
        end reciever : PwmPort;
    }

}