package SystemContextLogical {
    import LogicalElementCatalog::*;
    import MulticopterLogical::MulticopterLogicalModel;

    part def ContextModelLogical{
        

        part system : MulticopterLogicalModel;

        part groundStation{
            port commandTransmissionPort: ~CommandCommunicationPort;
            port telemetryReceptionPort : TelemetryCommunicationPort;
        }

        connection gsUavCommunication
            connect sys references system
            to gs references groundStation{
                interface
                    connect sys.commandReceptionPort
                    to gs.commandTransmissionPort;
                interface
                    connect sys.telemetryTransmissionPort
                    to gs.telemetryReceptionPort;
            }
    }
}