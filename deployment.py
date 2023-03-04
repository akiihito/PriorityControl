from xml.etree import cElementTree as ET
import argparse
import math


parser = argparse.ArgumentParser(description="create machine deployment plan at each area on a map")
parser.add_argument('-x', '--x', type=float, required=True, help='a max number of x axis')
parser.add_argument('-y', '--y', type=float, required=True, help='a max number of x axis')
parser.add_argument('-n', '--num', type=int, default=9, help='a number of machines')
parser.add_argument('-t', '--trace', type=str, default="sumotrace.xml", help='a trace file generated from SUMO sim')

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

    return segments, xunit, yunit

if __name__ == "__main__":
    segments, xsize, ysize = splitmap(args.x, args.y, args.num)
    print("xsize: %f, ysize %f" % (xsize, ysize))

    trace = readtracefile(args.trace)
    print(trace.keys())