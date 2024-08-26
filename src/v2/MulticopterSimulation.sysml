package MulticopterSimulation {
    import SimulationElementCatalog::*;

    part def SimpleMulticopter{
            part def MotorAssembly{//Great place for a trade study.
                port speedReference : SpeedReferencePort;
            }

            part motorAssembly_RF : MotorAssembly;
            part motorAssembly_RB : MotorAssembly;
            part motorAssembly_LB : MotorAssembly;
            part motorAssembly_LF : MotorAssembly;

            part chasiss{}

            part sensors{
                port position : PositionPort;
                port angle : AnglePort;
            }

            part controller{
                port position : PositionPort;
                port angle : AnglePort;

                port rfSpeedReference : SpeedReferencePort;
                port rbSpeedReference : SpeedReferencePort;
                port lbSpeedReference : SpeedReferencePort;
                port lfSpeedReference : SpeedReferencePort;

            }

            connection rfMotorToChasiss : MechanicalConnection
                connect attached ::> motorAssembly_RF
                to base ::> chasiss;
            connection rbMotorToChasiss : MechanicalConnection
                connect attached ::> motorAssembly_RB
                to base ::> chasiss;
            connection lbMotorToChasiss : MechanicalConnection
                connect attached ::> motorAssembly_LB
                to base ::> chasiss;
            connection lfMotorToChasiss : MechanicalConnection
                connect attached ::> motorAssembly_LF
                to base ::> chasiss;
            connection sensorsToChasiss : MechanicalConnection
                connect attached ::> sensors
                to base ::> chasiss;

            interface sensorsToController
                connect sensors.position
                to controller.position;
                connect sensors.angle
                to controller.angle;

            interface rfMotorToControler
                connect motorAssembly_RF.speedReference
                to controller.rfSpeedReference;
            interface rbMotorToControler
                connect motorAssembly_RF.speedReference
                to controller.rbSpeedReference;
            interface lbMotorToChasissControler
                connect motorAssembly_RF.speedReference
                to controller.lbSpeedReference;
            interface lfMotorToControler
                connect motorAssembly_RF.speedReference
                to controller.lfSpeedReference;
        }
}