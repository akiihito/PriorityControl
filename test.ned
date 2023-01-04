
import org.omnetpp.queueing.Classifier;
import org.omnetpp.queueing.Delay;
import org.omnetpp.queueing.FileBasedSource;
import org.omnetpp.queueing.PassiveQueue;
import org.omnetpp.queueing.Router;
import org.omnetpp.queueing.Server;
import org.omnetpp.queueing.Sink;
import org.omnetpp.queueing.Source;

network PriorityControl
{
    submodules:

        classifier1: Classifier {
        }
        hangingUp1: Sink {
        }
        High_Priority_Queue1: PassiveQueue {
        }
        Low_Priority_Queue1: PassiveQueue {
        }
        CPU1: Server {
        }
        CPU2: Server {
        }
        Served1: Sink {
        }
        Served2: Sink {
        }
        vehicle15: FileBasedSource{
        }
        vehicle43: FileBasedSource{
        }
        vehicle57: FileBasedSource{
        }
        vehicle87: FileBasedSource{
        }
        vehicle91: FileBasedSource{
        }
        vehicle99: FileBasedSource{
        }
    connections:
        classifier1.out++ --> High_Priority_Queue1.in++;
        classifier1.out++ --> Low_Priority_Queue1.in++;
        classifier1.rest --> hangingUp1.in++;
        High_Priority_Queue1.out++ --> CPU1.in++;
        High_Priority_Queue1.out++ --> CPU2.in++;
        Low_Priority_Queue1.out++ --> CPU1.in++;
        Low_Priority_Queue1.out++ --> CPU2.in++;
        CPU1.out --> Served1.in++;
        CPU2.out --> Served2.in++;
        vehicle15.out --> classifier1.in++;
        vehicle43.out --> classifier1.in++;
        vehicle57.out --> classifier1.in++;
        vehicle87.out --> classifier1.in++;
        vehicle91.out --> classifier1.in++;
        vehicle99.out --> classifier1.in++;
}
