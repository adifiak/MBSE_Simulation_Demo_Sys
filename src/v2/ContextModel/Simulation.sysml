package SystemContextSimulation{
    import SimulationElementCatalog::*;
    import MulticopterSimulation::*;

    part contextModelSimulation{
        part surface{}

        part wind{}

        part multicopter : SimpleMulticopter;

        connection rfMotorToChasiss : MechanicalConnection
                connect attached ::> wind
                to base ::> multicopter;
    }
}