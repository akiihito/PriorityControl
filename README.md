1. Run SUMO simulation and generate sumo trace file (sumotrace.xml)
  (in the case of windows)
    > .\test.bat (or) python runner.py

  You can change the parameter inside the runner.py
   (ex. the line #42 ('--flows', '100') indicates a number of vehicles in a simulation)
   (ex. the last 2 elems in the list #50 ('-e' '1000') indicates the duration of a simulation)

 -- More information about Manhattan Mobility Model
    https://sumo.dlr.de/docs/Tutorials/Manhattan.html

2. Generate Vehicle's equipment file
  (-s [wifi|camera|lidar] [all|random] -n <number of vehicles>)
    > python .\sensormount.py -s wifi all -s camera random -n 100 

3. Generate deployment plan for each vehicle
    > python deployment.py -x 900.0 -y 900.0 -n 9
  (-x <vertial size of a map> -y <horizontal size of a map> -n <a number of mahines to deploy VMs>)

4. Run Interaction Search
    > python .\interactionsearch.py -f .\sumotrace.xml -e .\vehicles.out -s sensors.json -t 0.0
  (-f <sumo trace file> -e <vehicle's equipment file> -s <sensor spec file> -t <a target vehicle ID>)
  (<sensor spec file> has already prepared. Do not modify)

5. make a ned file of Omnet++
    > python makened.py -c 2 -n 2 -o output.ned -d results
  (-c <a number of CPUs in one node> -n <a number of nodes> -o <ned filename> -d <directory contains the output files from interactionsearch.py (optional)>)

6. Copy the files in results and locale directory to inputs directory at Omnet++ samples
    > mv .\results ..\omnetpp-6.0\samples\interaction-search\inputs
    > mv .\locale ..\omnetpp-6.0\samples\interaction-search\inputs
    > mv test.ned ..\omnetpp-6.0\samples\interaction-search\
    (The location of inputs directory depends on the place you put omnet++ files)

7. Run Omnet++ command line from mingw shortcut in omnet directory
    > C:\Users\kohig\Works\omnetpp-6.0\mingwenv.cmd

8. Run Omnet++ simulation
    > cd \Users\kohig\Works\omnetpp-6.0\samples\interaction-search
    > opp_run -m -u Cmdenv -c General -n . -n ../queueinglib -l ../queueinglib/libqueueinglib.dll priorityControl.ini

9. Acquire Result files
    Omnet++ simulation(Sequence.6) generates result files that record several parameters of Sink Object in Omnet++ simulation.
    