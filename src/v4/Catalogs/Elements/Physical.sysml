package PhysicalElementCatalog{

    port def PwmPort{}
    interface def PwmInterface{
        end pwmSource : PwmPort;
        end   pwmSink : ~PwmPort;
    }

    port def SpiPort{}
    interface def SpiInterface{
        end masterPort : SpiPort;
        end  slavePort : ~SpiPort;
    }

    port def UartPort{}
    interface def UartInterface{
        end devicePort1 : UartPort;
        end devicePort2: UartPort;
    }

    connection def MechenicalConnection{
        end mount;
        end mounted;
    }

}