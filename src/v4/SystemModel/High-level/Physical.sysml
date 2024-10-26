package UAVPhysical{
    import PhysicalElementCatalog::*;

    part def UAVPhysicalModel{
        import MotorAssemblyHighLevel::*;

        part gpsModule{
            port uart : UartPort;
        }
        part imuModule{
            port spi : ~SpiPort;
        }

        part microControler{
            port uart : UartPort;
            port spi : SpiPort;

            port pwm1 : PwmPort;
            port pwm2 : PwmPort;
            port pwm3 : PwmPort;
            port pwm4 : PwmPort;
        }

        part motorAssembly_RF : PhysicalMotorAssembly;
        part motorAssembly_RB : PhysicalMotorAssembly;
        part motorAssembly_LB : PhysicalMotorAssembly;
        part motorAssembly_LF : PhysicalMotorAssembly;

        interface gpsToMicroControler : UartInterface connect
            devicePort1 ::> microControler.uart to
            devicePort2 ::> gpsModule.uart;

        interface imuToMicroControler : SpiInterface connect
            masterPort ::> microControler.spi to
            slavePort  ::> imuModule.spi;

        interface microControlerToMotorAssembly_RF : PwmInterface connect
            pwmSource ::> microControler.pwm1 to
            pwmSink ::> motorAssembly_RF.pwm;

        interface microControlerToMotorAssembly_RB : PwmInterface connect
            pwmSource ::> microControler.pwm1 to
            pwmSink ::> motorAssembly_RB.pwm;

        interface microControlerToMotorAssembly_LB : PwmInterface connect
            pwmSource ::> microControler.pwm1 to
            pwmSink ::> motorAssembly_LB.pwm;

        interface microControlerToMotorAssembly_LF : PwmInterface connect
            pwmSource ::> microControler.pwm1 to
            pwmSink ::> motorAssembly_LF.pwm;

        
    }
}