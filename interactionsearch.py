from collections import defaultdict
import math
import xml.etree.ElementTree as ET
import argparse
import csv
import json


parser = argparse.ArgumentParser(description="interaction search script for sumo output")
parser.add_argument('-f', '--sumofile', type=str, required=True, help='sumo output file formatted by XML')
parser.add_argument('-e', '--equipfile', type=str, required=True, help='vehicles list, which sensors are mounted on each vehicle')
parser.add_argument('-s', '--sensorfile', type=str, required=True, help='sensors list, which consists on the sensor spec information')
parser.add_argument('-o', '--outdir', type=str, default="results", help='a directory to put priority setting files for vehicles')
parser.add_argument('-t', '--target', type=str, required=True, help='target vehicle\'s ID')


args = parser.parse_args()



def readsensorspec(filename):
    with open(filename, 'r') as f:
        return json.load(f)['sensors']


def readequiplist(filename):
    equipdict = {}
    with open(filename, 'r') as f:
        reader = csv.reader(f)
        for i in reader:
            _id = i[0]
            _equip = i[1:]
            equipdict[_id] = _equip
    return equipdict


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


def maxrange(equip, sensors):
    r = {}
    for _id in equip.keys():
        _maxrange = 0
        for _sensorname in equip[_id]:
            for i in sensors:
                if i['name'] == _sensorname:
                    _distance = i['scope']['range']
                    if _maxrange < _distance:
                        _maxrange = _distance
        r[_id] = _maxrange
    return r


def _distance(v1, v2):
    x1 = v1['x']
    x2 = v2['x']
    y1 = v1['y']
    y2 = v2['y']
    return abs(math.sqrt(math.pow((x2-x1), 2) + math.pow((y2-y1), 2)))


def distance_bw_vehicles(vehicles, rangelist):
    distances = []
    ## 各車両間の距離を計算する
    for _v in vehicles:
        _id = _v['id']
        _rest = [v for v in vehicles if v['id'] != _id]
        distances += [(_v['id'], _r['id'], _distance(_v, _r)) for _r in _rest]
    ## 各車両間の距離から最大探索距離以上の組み合わせを削除
    ret = []
    for distance in distances:
        ## v1:センサを持ってる側, v2:センサで測定される側
        ## v1 のセンサの最大探索距離と v2 のセンサの最大探索距離が必ずしも
        ## 一致するとは限らないので、v1 と v2 の間の距離を一つにまとめていない。
        v1, v2, _d = distance
        if _d < rangelist[v1]:
            ret.append(distance)
    return ret


def sumo_angle(angle):
    return (360 - ((270 + angle) % 360)) % 360


def within_angle(v1, v2, angle):
    x = v2['x'] - v1['x']
    y = v2['y'] - v1['y']
    _a = sumo_angle(math.degrees(math.atan2(y, x)))    
    _b = abs(v1['angle'] - _a)
    _c = min(360-_b, _b)
    if (angle / 2) > _c:
        return True
    else:
        return False


def vehicle_in_sensor_view(in_scope, vehicles, equips, sensorspecs):

    inView = []
    for i in in_scope:
        _v1, _v2, _d = i

        specs = [s for s in sensorspecs if s['name'] in equips[_v1]]

        for spec in specs:
            _range = spec['scope']['range']

            if spec['scope']['fov'] == "directional":
                ## TODO: handling index error
                v1 = [v for v in vehicles if v['id'] == _v1][0]
                v2 = [v for v in vehicles if v['id'] == _v2][0]
                if (_d < _range) and within_angle(v1, v2, spec['scope']['angle']):
                    inView.append(i)

            if spec['scope']['fov'] == "omnidirectional":
                if _d < _range:
                    inView.append(i)
    return inView


def interaction_search(vid, in_scopes_by_time):

    interact_list = []
    ## 時刻の最後から探索する
    clocks = reversed(in_scopes_by_time.keys())
    for t in clocks:
        for i in in_scopes_by_time[t]:
            _id1, _id2, _d = i
            ## すでに interaction がある場合はスキップ
            e = next(filter(lambda x: True if x[1] == _id2 else False, interact_list), None)

            ## for debugging
            if e != None:
                print("Time:", t, "encounterd ", _id2, "but, already interacted at the time", e)

            if _id1 == vid and e == None:
                interact_list.append((t, _id2))
    return interact_list

def interaction_search2(vid, in_scopes_by_time):

    ## 時刻の最後から探索する
    clocks = list(reversed(in_scopes_by_time.keys()))
    if clocks == []:
        return interact_list

    ## interaction リスト
    interact_list = [(vid, float(clocks[0]))]

    for t in clocks:
        for i in in_scopes_by_time[t]:
            ## _id1: センサを持つ車両(ID)
            ## _id2: センサで捕捉される車両(ID)
            ## _d  : 車両間の距離
            _id1, _id2, _d = i

            l = [x[0] for x in interact_list]

            ## _id1, _id2 の車両が interaction リストに入っていたらスキップ
            if (_id1 in l) and (_id2 in l):
                continue
            
            ## _id1 の車両がリストに入っていて、_id2 がリストに入っていなければ
            ## _id2 の車両を新たな車両として、interaction リストに追加する。
            if (_id1 in l) and not(_id2 in l):
                interact_list.append((_id2, float(t)))

            ## _id2 の車両がリストに入っていて、_id1 がリストに入っていなければ
            ## (_id2 <- _id1)となり、_id1 が一方的に _id2 をセンサで捕捉している
            ## だけとなり、_id2 は _id1 の車両の存在に気付かないので、_id1 は
            ## _id2 の挙動に影響を与えない＝_id1の存在は無視

    return interact_list


def clock_interval(clocks):
    clocks = sorted(clocks)
    if len(clocks) < 2:
        return 0
    else:
        return clocks[1] - clocks[0]


if __name__ == "__main__":

    trace = readtracefile(args.sumofile)
    equips = readequiplist(args.equipfile)
    sensorspecs = readsensorspec(args.sensorfile)

    ## 各車両に配置されている複数センサーのうち、最大探索距離を持つセンサを探す
    maxrange_per_vehicle = maxrange(equips, sensorspecs)

    in_scopes_by_time = {}
    for t in trace.keys():
        ## for test
        if t == "20.00":
            break
        ## 各車両の距離を計算する（最大探索距離以上の計算結果は排除）
        in_range = distance_bw_vehicles(trace[t], maxrange_per_vehicle)
        ## 測定される側の車両がセンサーの探索範囲にいるか調べる
        in_view = vehicle_in_sensor_view(in_range, trace[t], equips, sensorspecs)   
        ## センサの範囲内にいる車両の情報を時刻毎にまとめる
        in_scopes_by_time[t] = in_view

    ## interaction search for all (test)
    '''
    for vehicle_id in equips.keys():
        interaction_list = interaction_search2(vehicle_id, in_scopes_by_time)
        print(interaction_list)
    '''

    interaction_list = interaction_search2(args.target, in_scopes_by_time)

    max_length = len(in_scopes_by_time.keys())
    unit = clock_interval([float(x) for x in in_scopes_by_time.keys()])
    print(max_length, unit)
    print(interaction_list)
    ##### それぞれの車両ごとにファイルを出力する
    ## 一度、高優先タスクに該当する車両だけファイル出力してみる
    for vinfo in interaction_list:
        _id, t = vinfo
        ## 整数値の車両IDだと、Omnet++ でシミュレーションする時に都合が悪いので、一時的な処理
        outfile = "vehicle" + str(int(float(_id)))
        lines = []
        with open(args.outdir + "/" + outfile, "w") as f:
            i = 0.00
            while i < max_length:
                if i < t:
                    ## SUMOの
                    lines.append("{:.2f}".format(i) + ", 0\n") # high priority
                else:
                    lines.append("{:.2f}".format(i) + ", 1\n") # low priority
                i += unit
            ## 最後の改行を削除
            lines = lines[0:-1] + [lines[-1].replace("\n", "")]
            f.writelines(lines)
