
with open("priorityControl.ini", "w") as f:
    for i in range(100):
        f.write("**.vehicle" + str(i) + ".interArrivalTime = 1s" + "\n")
        f.write("**.vehicle" + str(i) + ".result_directory = \"inputs/results\"" + "\n") 
        f.write("**.vehicle" + str(i) + ".locale_directory = \"inputs/locale\"" + "\n")
        f.write("**.vehicle" + str(i) + ".filename = \"vehicle" + str(i) + "\"" + "\n") 


'''**.vehicle15.interArrivalTime = 1s 
**.vehicle15.result_directory = "inputs/results" 
**.vehicle15.locale_directory = "inputs/locale" 
**.vehicle15.filename = "vehicle15" 
'''