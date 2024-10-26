package SystemContextPhysical {
    import PhysicalElementCatalog::*;
    import MulticopterPhysical::MulticopterPhysicalModel;

    part def ContextModelPhysical{
        part surface{

        }

        part air{

        }

        part system : MulticopterPhysicalModel;

        part groundStation{
            port commandRadioPort   : ~RadioPort{}
            port telemetryRadioPort : RadioPort{}
        }

        part gpsNetwork{
            port gpsRadioPort : ~RadioPort{}
        }

        /*part wind{
            public attribute windSpeed;
            public attribute windDirection;
        }

        connection windEffects
            connect sys references system
            to wnd references wind{
                bind sys.windSpeed = wnd.windSpeed;
                bind sys.windDirection = wnd.windDirection;
            }*/

        //import ISQSpaceTime::frequency;
        import SI::Hz;

        connection gsUavCommunication
            connect sys references system
            to gs references groundStation{
                //TODO: Fix radio interfaces
                /*interface cmdRadioLink : RadioLink
                    connect rx ::> sys.commandRadioPort
                    to tx ::> gs.commandRadioPort{
                        redefines frequency = 2500000 [Hz];
                    }
                    
                interface telRadioLink : RadioLink
                    connect tx ::> sys.telemetryRadioPort
                    to rx ::> gs.telemetryRadioPort{
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