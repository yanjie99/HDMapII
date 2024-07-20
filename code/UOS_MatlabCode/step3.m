maxSimulationTimeSec = 20;
set(rrSim,'MaxSimulationTime',maxSimulationTimeSec);

set(rrSim,"Logging","On");

set(rrSim,"SimulationCommand","Start");
while strcmp(get(rrSim,"SimulationStatus"),"Running")
    pause(1);
end