package GeneralSystem{
    import Logical_System_Context::*;
    import Logical_System_Component_Catalog::*;
    import LogicalConnectionDefinitions::*;
    import GeneralSystemComponentCatalog::PartDefinitions::*;
    import GeneralSystemComponentCatalog::InterfaceDefinitions::*;

	part generalUAV : GeneralUAV{
		part generalAirframe 			: GeneralAirframe 				subsets components;
		part generalPowerDeliverySystem : GeneralPowerDeliverySystem 	subsets components;
		part generalPropultionSystem 	: GeneralPropultionSystem 		subsets components;
		part generalAvionics 			: GeneralAvionics 				subsets components;
		part generalPayload 			: GeneralPayload 				subsets components;

		interface psuToController : GeneralPowerSupplyInterface connect
			psu ::> generalPowerDeliverySystem.powerPort to
			load ::> generalAvionics.powerPort;

		interface psuToPropultion : GeneralPowerSupplyInterface connect
			psu ::> generalPowerDeliverySystem.powerPort to
			load ::> generalPropultionSystem.powerPort;

		interface ControllerToPropultion : GeneralControlInterface connect
			controler ::> generalAvionics.controlPort to
			peripherial ::> generalPropultionSystem.controlPort;

	}
}