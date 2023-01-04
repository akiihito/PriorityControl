import os
import argparse

parser = argparse.ArgumentParser(description="make nedfile for omnet++")
parser.add_argument('-d', '--directory', type=str, default="results", help='a directory name that contains priority files')

args = parser.parse_args()

header = '''
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
'''

submodules = '''
        classifier%d: Classifier {
        }
        hangingUp%d: Sink {
        }
        High_Priority_Queue%d: PassiveQueue {
        }
        Low_Priority_Queue%d: PassiveQueue {
        }
        CPU%d: Server {
        }
        CPU%d: Server {
        }
        Served%d: Sink {
        }
        Served%d: Sink {
        }'''

connection = '''
    connections:
        classifier%d.out++ --> High_Priority_Queue%d.in++;
        classifier%d.out++ --> Low_Priority_Queue%d.in++;
        classifier%d.rest --> hangingUp%d.in++;
        High_Priority_Queue%d.out++ --> CPU%d.in++;
        High_Priority_Queue%d.out++ --> CPU%d.in++;
        Low_Priority_Queue%d.out++ --> CPU%d.in++;
        Low_Priority_Queue%d.out++ --> CPU%d.in++;
        CPU%d.out --> Served%d.in++;
        CPU%d.out --> Served%d.in++;'''

tail = '''
}
'''

vehicles = [f for f in os.listdir(args.directory) if os.path.isfile(os.path.join(args.directory, f))]
vehicles_submodules = ""
for v in vehicles:
    vehicles_submodules = vehicles_submodules + '''
        %s: FileBasedSource{
        }''' % v

vehicles_connections = ""
for v in vehicles:
    vehicles_connections = vehicles_connections + '''
        %s.out --> classifier%d.in++;''' % (v, 1)


with open("test.ned", "w") as f:
    f.write(header)
    f.write(submodules % (1,1,1,1,1,2,1,2))
    f.write(vehicles_submodules)
    f.write(connection % (1,1,1,1,1,1,1,1,1,2,1,1,1,2,1,1,2,2))
    f.write(vehicles_connections)
    f.write(tail)