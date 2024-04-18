package Abstract_System_Context {
	import Logical_System_Context::*;
	import Physical_System_Context::*;
	
	part def AbstractSystemContext {
		part logicalSystemContext : LogicalSystemContext;
		part physicalSystemContext : PhysicalSystemContext;
	}
}