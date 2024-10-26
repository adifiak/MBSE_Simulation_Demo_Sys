library package ReferenceSystems{
    abstract occurrence def FrameOfReference;

    abstract connection def RelativeToFrame{
        end baseFrame : FrameOfReference;
        end observedFram : FrameOfReference;
    }

    abstract connection def FrameTransformation {
        end currentFrame : FrameOfReference;
        end desiredFrame : FrameOfReference;
    }
}