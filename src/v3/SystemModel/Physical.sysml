package UAVPhysical{
    import PhysicalElementCatalog::*;

    part def UAVPhysicalModel{

        part GpsModule{
            port uart : UartPort;
        }
        part ImuModule{
            port spi : SpiPort;
        }

        part MicroControler{
            port uart : UartPort;
            port spi : SpiPort;

            port pwm1 : PwmPort;
            port pwm2 : PwmPort;
            port pwm3 : PwmPort;
            port pwm4 : PwmPort;
        }

        //TODO: Itt szeretném a motorok és a mikrokontroller PwmPort-ját összekötni egymással.
        //archModel :>> that : ;

        interface GpsToMicroControler
            connect gps references GpsModule.uart
            to uc references MicroControler.uart{

            }
        interface ImuToMicroControler
            connect sensor references ImuModule.spi
            to uc references MicroControler.spi{

            }

        
    }
}