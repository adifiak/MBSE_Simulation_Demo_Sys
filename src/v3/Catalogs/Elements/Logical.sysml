package LogicalElementCatalog{
    attribute def Position;
    attribute def Attitude;
    attribute def ControlerOutputSignals;

    port def PositionPort{
        out position : Position;
    }

    port def AttitudePort{
        out attitude : Attitude;
    }

    port def ControlerOutputSignalPort{
        out controlerOutputSignals : ControlerOutputSignals;
    }
}