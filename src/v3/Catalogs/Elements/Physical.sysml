package PhysicalElementCatalog{

    port def PwmPort{}
    port def SpiPort{}
    port def UartPort{}

    connection def MechenicalConnection{
        end mount;
        end mounted;
    }

}