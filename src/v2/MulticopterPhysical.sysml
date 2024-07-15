package MulticopterPhysical {
    import PhysicalElementCatalog::*;

    part def MulticopterPhysicalModel :> CompositeComponent{
        import SI::kg;

        part components : Component[*] redefines subComponents;

        part chasiss : Component :> components{
            redefines mass = 0.5 [kg];
        }

        part mainMicrocontroller : Microcontroller :> components{
            redefines mass = 0.001 [kg];
            port uart1  : UartPort;
            port uart2  : UartPort;
            port spi    : SpiPort;
            port pwm1 : PwmPort;
            port pwm2 : PwmPort;
            port pwm3 : PwmPort;
            port pwm4 : PwmPort;
        }

        part def MotorAssembly :> Component{//Great place for a trade study.
            redefines mass = 0.1 [kg];
            attribute thrust :> ISQ::force;
            attribute torque :> ISQ::torque;
            port speedReference : PwmPort;
        }

        part MotorAssembly_RF : MotorAssembly :> components;
        part MotorAssembly_RB : MotorAssembly :> components;
        part MotorAssembly_LB : MotorAssembly :> components;
        part MotorAssembly_LF : MotorAssembly :> components;

        part radioTranssiever : Component :> components{
            redefines mass = 0.005 [kg];
            port rx : RadioPort{}
            port tx : RadioPort{}

            port uart : UartPort;
        }

        part IMU : Component :> components{
            redefines mass = 0.001 [kg];
            port spi : SpiPort;
        }

        part GPS : Component :> components{
            redefines mass = 0.001 [kg];
            port uart : UartPort;
            port gpsAntenna : RadioPort;
        }

        //uC to radio
        connection mainMicrocontrollerToRadio
            connect controller references mainMicrocontroller
            to radio references radioTranssiever{
                interface : UARTinterface
                    connect controller.uart1
                    to radio.uart;
            }

        //uC to sensors
        connection mainMicrocontrollerToGPS
            connect controller references mainMicrocontroller
            to gps references GPS{
                interface : UARTinterface
                    connect controller.uart2
                    to gps.uart;
            }
        connection mainMicrocontrollerToIMU
            connect controller references mainMicrocontroller
            to imu references IMU{
                interface : SPIinterface
                    connect controller.spi
                    to imu.spi;
            }

        //uC to Motors
        connection mainMicrocontrollerToMotorAssembly_RF
            connect controller references mainMicrocontroller
            to motor references MotorAssembly_RF{
                interface : PWMinterface
                    connect controller.pwm1
                    to motor.speedReference;
            }
        connection mainMicrocontrollerToMotorAssembly_RB
            connect controller references mainMicrocontroller
            to motor references MotorAssembly_RB{
                interface : PWMinterface
                    connect controller.pwm2
                    to motor.speedReference;
            }
        connection mainMicrocontrollerToMotorAssembly_LB
            connect controller references mainMicrocontroller
            to motor references MotorAssembly_LB{
                interface : PWMinterface
                    connect controller.pwm3
                    to motor.speedReference;
            }
        connection mainMicrocontrollerToMotorAssembly_LF
            connect controller references mainMicrocontroller
            to motor references MotorAssembly_LF{
                interface : PWMinterface
                    connect controller.pwm4
                    to motor.speedReference;
            }

        port commandRadioPort   : RadioPort{}
        port telemetryRadioPort : ~RadioPort{}
        port gpsRadioPort : RadioPort{}

        bind commandRadioPort = radioTranssiever.rx;
        bind telemetryRadioPort = radioTranssiever.tx;
        bind gpsRadioPort = GPS.gpsAntenna;
    }
}