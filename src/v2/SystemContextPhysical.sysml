package SystemContextPhysical {
    import PhysicalElementCatalog::*;
    import MulticopterPhysical::MulticopterPhysicalModel;

    part def ContextModelPhysical{
        part system : MulticopterPhysicalModel;

        part groundStation{
            port commandRadioPort   : ~RadioPort{}
            port telemetryRadioPort : RadioPort{}
        }

        part gpsNetwork{
            port gpsRadioPort : ~RadioPort{}
        }

        part wind{
            public attribute windSpeed;
            public attribute windDirection;
        }

        connection windEffects
            connect system
            to wind{
                bind system.windSpeed = wind.windSpeed;
                bind system.windDirection = wind.windDirection;
            }

        import ISQSpaceTime::frequency;

        connection gsUavCommunication
            connect sys references system
            to gs references groundStation{
                interface CmdRadioLink : RadioLink
                    connect rx ::> sys.commandRadioPort
                    to tx ::> gs.commandRadioPort;/*{
                        redefines frequency = 2500000 [Hz];
                    }*/
                    
                interface TlRadioLink : RadioLink
                    connect tx ::> sys.telemetryRadioPort
                    to rx ::> gs.telemetryRadioPort;/*{
                        redefines frequency = 2500000 [Hz];
                    }*/
            }

        connection gpsUavCommunication
            connect sys references system
            to gps references gpsNetwork{
                interface : RadioLink
                    connect sys.gpsRadioPort
                    to gps.gpsRadioPort;
            }
    }
}