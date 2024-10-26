package ArchitectureElementCatalog{
    part def LogicalModel;
    part def PhysicalModel;
    allocation def ModelAllocation{
        end l :>> source : LogicalModel;
        end p :>> target : PhysicalModel;

        allocation suballocations : ModelAllocation[*];
    }

    part def ArchitectureModel{
        part logical : LogicalModel;
        part physical : PhysicalModel;
        allocation allocations : ModelAllocation allocate  l::> logical to p::> physical;
    }
}