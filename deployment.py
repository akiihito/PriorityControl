import os
from xml.etree import cElementTree as ET
import argparse
import math


parser = argparse.ArgumentParser(description="create machine deployment plan at each area on a map")
parser.add_argument('-x', '--x', type=float, required=True, help='a max number of x axis')
parser.add_argument('-y', '--y', type=float, required=True, help='a max number of x axis')
parser.add_argument('-n', '--num', type=int, default=9, help='a number of machines')
parser.add_argument('-t', '--trace', type=str, default="sumotrace.xml", help='a trace file generated from SUMO sim')
parser.add_argument('-o', '--outdir', type=str, default="locale", help='a directory to store the deployplan files for vehicles')


args = parser.parse_args()


def readtracefile(filename):
    ret = {}
    tree = ET.parse(filename)
    for i in tree.iter(tag="timestep"):
        vlist = []
        for j in i.iter(tag="vehicle"):
            v = {}
            v["id"] = j.attrib["id"]
            v["x"] = float(j.attrib["x"])
            v["y"] = float(j.attrib["y"])
            v["angle"] = float(j.attrib["angle"])
            v["type"] = j.attrib["type"]
            v["speed"] = float(j.attrib["speed"])
            v["pos"] = float(j.attrib["pos"])
            v["lane"] = j.attrib["lane"]
            v["slope"] = float(j.attrib["slope"])
            vlist.append(v)
        ret[i.attrib["time"]] = vlist
    return ret

def splitmap(x: float, y: float, n: int):

    r, s = math.modf(math.sqrt(n))
    if r != 0 :
        print("machine num [%d] is not the power of two, %d machines are not used" % (args.num, args.num - math.pow(s,2)))

    segments = [[0 for j in range(int(s))] for i in range(int(s))]

    xstart = xend = ystart = yend = 0
    xunit, xremains = divmod(x, s)
    yunit, yremains = divmod(y, s)

    for _y in range(int(s)):
        if yremains != 0:
            yend += yunit + 1
            yremains -= 1
        else:
            yend += yunit

        xstart = xend = 0
        _xrem = xremains
        for _x in range(int(s)):
            if _xrem != 0:
                xend += xunit + 1
                _xrem -= 1
            else:
                xend += xunit
            #print("(%d, %d) : (xmin %d, xmax %d, ymin %d, ymax %d)" % (_x, _y, xstart, xend - 1, ystart, yend - 1))
            segments[_x][_y] = [xstart, xend - 1, ystart, yend - 1]
            xstart = xend
        ystart = yend

    return segments, xunit, yunit, int(s)


def pos2dst(segments: list, xunit :float, yunit :float, matrix: int, _x: float, _y: float):
    ## trimming
    if _x < 0:
        print("an outside value as a coordinate [x = %.2f], align to zero" % _x)
        _x = 0.0
    if _x > xunit * matrix:
        print("an outside value as a coordinate [x = %.2f], align to max size" % _x)
        _x = (xunit * matrix) - 0.1
    if _y < 0:
        print("an negative value as a coordinate [y = %.2f], align to zero" % _y)
        _y = 0.0
    if _y > yunit * matrix:
        print("an outside value as a coordinate [y = %.2f], align to max size" % _y)
        _y = (yunit * matrix) - 0.1

    i = int(_x / xunit)
    j = int(_y / yunit)

    try:
        node_id, seg = segments[j][i]
    except:
        print (i, j, xunit, yunit, _x, _y)
    (xstart, xend, ystart, yend) = seg


    if (xstart <= _x <= xend) and (ystart <= _y <= yend):
        return node_id
    if xend < _x:
        i = (i + 1) % (matrix - 1)
    else:
        i = i - 1 if i > 0 else matrix - 1
    if yend < _y:
        j = (j + 1) % (matrix - 1)
    else:
        j = j - 1 if j > 0 else matrix - 1
    node_id, seg = segments[j][i]
    return node_id


if __name__ == "__main__":
    ## split map to segments
    segments, xunit, yunit, matrix = splitmap(args.x, args.y, args.num)
    print("xunit size: %f, yunit size %f, matrix size %d" % (xunit, yunit, matrix))

    ## assign a machine to each segment
    machineIds = list(range(int(math.pow(matrix, 2))))
    for i in range(int(matrix)):
        for j in range(int(matrix)):
            seg = segments[j][i]
            segments[j][i] = (machineIds.pop(0), seg)

    ## make the deploy plans for each vehicle
    trace = readtracefile(args.trace)
    locale = {}

    time = [float(x) for x in trace.keys()]
    #{'id': '0.0', 'x': 598.4, 'y': 216.53, ...}
    for t in time:
        vehicles = trace[format(t, '.2f')]
        for v in vehicles:
            _id = v['id']
            _x  = v['x']
            _y  = v['y']
            node = pos2dst(segments, xunit, yunit, matrix, _x, _y)

            if _id in locale.keys():
                locale[_id].append([t, node])
            else:
                locale[_id] = [[t, node]]

    ## make the output directory if not exist
    if not os.path.exists(args.outdir):
        os.makedirs(args.outdir)

    ## output the deployement plan
    for _id in locale.keys():
        lines = []
        outfile = "vehicle" + str(int(float(_id)))
        plan = locale[_id]
        print(outfile)
        print(plan)
        with open(args.outdir + "/" + outfile, "w") as f:
            for l in plan:
                t, node_id = l
                #lines.append("{:.2f}".format(t) + ", " + str(node_id) + "\n")
                lines.append(str(node_id) + "\n")

            ## remove the linefeed at the tail
            lines = lines[0:-1] + [lines[-1].replace("\n", "")]
            f.writelines(lines)
