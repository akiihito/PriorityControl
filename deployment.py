import argparse
import math


parser = argparse.ArgumentParser(description="create machine deployment plan at each area on a map")
parser.add_argument('-x', '--x', type=float, required=True, help='a max number of x axis')
parser.add_argument('-y', '--y', type=float, required=True, help='a max number of x axis')
parser.add_argument('-n', '--num', type=int, default=9, help='a number of machines')

args = parser.parse_args()

if __name__ == "__main__":
    r, s = math.modf(math.sqrt(args.num))
    if r != 0 :
        print("machine num [%d] is not the power of two, %d machines are not used" % (args.num, args.num - math.pow(s,2)))

    xstart = xend = ystart = yend = 0
    xunit, xremains = divmod(args.x, s)
    yunit, yremains = divmod(args.y, s)

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
            print("(%d, %d) : (xmin %d, xmax %d, ymin %d, ymax %d)" % (_x, _y, xstart, xend - 1, ystart, yend - 1))
            xstart = xend
        ystart = yend
