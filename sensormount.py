import argparse
import random
import numpy as np


parser = argparse.ArgumentParser(description="generate sensor mounted vehicle list")
parser.add_argument('-o', '--output', type=str, default="vehicles.out", help='vehicles list which mount sensors')
parser.add_argument('-s', '--sensor', action='append', nargs=2, metavar=('type', 'mount'), help='sensor type and which vehicle mounts it [all or random]')
parser.add_argument('-n', '--number', type=int, default=100, help='the number of vehicles')
args = parser.parse_args()


vehicles = {}
for i in range(args.number):
    vehicles[format(float(i), '.1f')] = []


for s in args.sensor:
    _type, _mount = s
    for i in vehicles.keys():
        if _mount == "all" :
            vehicles[i].append(_type)
        elif _mount == "random":
            if random.choice([True, False]):
                vehicles[i].append(_type)


with open(args.output, "w+") as f:
    for i in vehicles.keys():
        f.write(i+","+",".join(vehicles[i])+"\n")