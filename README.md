1. Run SUMO simulation and generate sumo trace file (sumotrace.xml)
  (in the case of windows)
    > .\test.bat (or) python runner.py

2. Generate Vehicle's equipment file
  (-s [wifi|camera|lidar] [all|random] -n <number of vehicles>)
    > python .\sensormount.py -s wifi all -s camera random -n 100 

3. Run Interaction Search
    > python .\interactionsearch.py -f .\sumotrace.xml -e .\vehicles.out -s sensors.json
  (-f <sumo trace file> -e <vehicle's equipment file> -s <sensor spec file>)
  (<sensor spec file> has already prepared. Do not modify)

4. Copy the files in results directory to inputs directory at Omnet++ samples
    > mv .\results ..\omnetpp-6.0\samples\interaction-search\inputs
    (The location of inputs directory depends on the place you put omnet++ files)

5. Run Omnet++ command line from mingw shortcut in omnet directory
    > C:\Users\kohig\Works\omnetpp-6.0\mingwenv.cmd

6. Run Omnet++ simulation
    > cd \Users\kohig\Works\omnetpp-6.0\samples\interaction-search
    > opp_run -m -u Cmdenv -c General -n . -n ../queueinglib -l ../queueinglib/libqueueinglib.dll priorityControl.ini

7. Acquire Result files
    Omnet++ simulation(Sequence.6) generates result files that record several parameters of Sink Object in Omnet++ simulation.
    