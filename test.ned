
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
			vehicle18: FileBasaedSource {
			}
			vehicle24: FileBasaedSource {
			}
			vehicle51: FileBasaedSource {
			}
			vehicle56: FileBasaedSource {
			}
			vehicle73: FileBasaedSource {
			}
			vehicle74: FileBasaedSource {
			}
			vehicle96: FileBasaedSource {
			}
			vehicle97: FileBasaedSource {
			}
			CPU1: Server {
			}
			CPU2: Server {
			}
			CPU3: Server {
			}
			CPU4: Server {
			}
			High_Priority_Queue1: PassiveQueue {
			}
			High_Priority_Queue2: PassiveQueue {
			}
			Low_Priority_Queue1: PassiveQueue {
			}
			Low_Priority_Queue2: PassiveQueue {
			}
			Served1: Sink {
			}
			Served2: Sink {
			}
			Served3: Sink {
			}
			Served4: Sink {
			}
			hangingUp1: Sink {
			}
			hangingUp2: Sink {
			}
			Classifier1: Classifier {
			}
			Classifier2: Classifier {
			}
			router: Router {
			}
		connections:			Classifier1.out++ --> High_Priority_Queue1.in++;
			Classifier1.out++ --> Low_Priority_Queue1.in++;
			Classifier1.rest --> hangingUp1.in++;
			High_Priority_Queue1.out++ --> CPU1.in++;
			Low_Priority_Queue1.out++ --> CPU1.in++;
			CPU1.out --> Served1.in++;
			High_Priority_Queue1.out++ --> CPU2.in++;
			Low_Priority_Queue1.out++ --> CPU2.in++;
			CPU2.out --> Served2.in++;
			router.out ++ --> Classifier1.in++;
			Classifier2.out++ --> High_Priority_Queue2.in++;
			Classifier2.out++ --> Low_Priority_Queue2.in++;
			Classifier2.rest --> hangingUp2.in++;
			High_Priority_Queue2.out++ --> CPU3.in++;
			Low_Priority_Queue2.out++ --> CPU3.in++;
			CPU3.out --> Served3.in++;
			High_Priority_Queue2.out++ --> CPU4.in++;
			Low_Priority_Queue2.out++ --> CPU4.in++;
			CPU4.out --> Served4.in++;
			router.out ++ --> Classifier2.in++;
			vehicle18.out --> router.in++;
			vehicle24.out --> router.in++;
			vehicle51.out --> router.in++;
			vehicle56.out --> router.in++;
			vehicle73.out --> router.in++;
			vehicle74.out --> router.in++;
			vehicle96.out --> router.in++;
			vehicle97.out --> router.in++;

}
