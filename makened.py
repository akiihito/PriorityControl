import os
import argparse

parser = argparse.ArgumentParser(description="make nedfile for omnet++")
parser.add_argument('-d', '--directory', type=str, default="results", help='a directory name that contains priority files')
parser.add_argument('-c', '--cpu', type=int, required=True, help='a number of CPUs in one PC')
parser.add_argument('-n', '--node', type=int, required=True, help='a number of PC')
parser.add_argument('-o', '--output', type=str, default="test.ned", help='an output filename')

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

tail = '''
}
'''

def node_connection(node):
    _cls = node['cls']
    _hng = node['hng']
    _hq  = node['hq']
    _lq  = node['lq']
    _cpus = node['cpu']
    _srvs = node['srv']

    ret = []
    ret.append(_cls + ".out++ --> " + _hq + ".in++;")
    ret.append(_cls + ".out++ --> " + _lq + ".in++;")
    ret.append(_cls + ".rest --> " + _hng + ".in++;")
    for i in range(len(_cpus)):
        ret.append(_hq + ".out++ --> " + _cpus[i] + ".in++;")
        ret.append(_lq + ".out++ --> " + _cpus[i] + ".in++;")
        ret.append(_cpus[i] + ".out --> " + _srvs[i] + ".in++;")
    ret.append("router.out ++ --> " + _cls + ".in++;")

    return ret

if __name__ == '__main__':
    ## make label list
    vehicles = [f for f in os.listdir(args.directory) if os.path.isfile(os.path.join(args.directory, f))]
    cpus  = ["CPU{:d}".format(i) for i in range(1, args.cpu * args.node + 1)]
    highq = ["High_Priority_Queue{:d}".format(i) for i in range(1, args.node + 1)]
    lowq  = ["Low_Priority_Queue{:d}".format(i) for i in range(1, args.node + 1)]
    cls   = ["Classifier{:d}".format(i) for i in range(1, args.node + 1)]
    hng   = ["hangingUp{:d}".format(i) for i in range(1, args.node + 1)]
    srv   = ["Served{:d}".format(i) for i in range(1, args.cpu * args.node + 1)]

    ## make submodule list
    modules = []
    modules += [x + ": FileBasedSource {\n\t\t\t}" for x in vehicles]
    modules += [x + ": Server {\n\t\t\t}" for x in cpus]
    modules += [x + ": PassiveQueue {\n\t\t\t}" for x in highq]
    modules += [x + ": PassiveQueue {\n\t\t\t}" for x in lowq]
    modules += [x + ": Sink {\n\t\t\t}" for x in srv]
    modules += [x + ": Sink {\n\t\t\t}" for x in hng]
    modules += [x + ": Classifier {\n\t\t\t}" for x in cls]
    modules += ["router: Router {\n\t\t\t}"]

    ## make node set
    nodelist = []
    for i in range(args.node):
        node = {}
        node['cpu'] = [cpus.pop(0) for i in range(args.cpu)]
        node['hq'] = highq.pop(0)
        node['lq'] = lowq.pop(0)
        node['cls'] = cls.pop(0)
        node['hng'] = hng.pop(0)
        node['srv'] = [srv.pop(0) for i in range(args.cpu)]
        nodelist.append(node)

    ## make connection for each node
    connections = sum([node_connection(node) for node in nodelist], [])

    ## make connection between a router and vehicles
    connections += [vehicle + ".out --> router.in++;"for vehicle in vehicles]

    ## write out a ned file
    with open(args.output, "w") as f:
        f.write(header)
        for i in modules:
            f.write("\t\t\t" + i + "\n")
        f.write("\t\tconnections:")
        for i in connections:
            f.write("\t\t\t" + i + "\n")
        f.write(tail)
