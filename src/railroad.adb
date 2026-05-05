with Railroad_Logic; use Railroad_Logic;
with Network;
with Train_Tasks;
with Dispatchers;
with Loggers;
with Sim_Clocks;

procedure Railroad is

   Control_Center : Dispatchers.Dispatcher;
   Logger_Service : Loggers.EventLogger;
   Clock_Service  : Sim_Clocks.SimClock;

   Train_1 : Train_Tasks.Train_Task_Access;
   Train_2 : Train_Tasks.Train_Task_Access;
   Train_3 : Train_Tasks.Train_Task_Access;

begin
   Network.Initialize_Railway;

   Train_1 := new Train_Tasks.Train_Task
      (ID    => 1,
       Route => new Route_Lists.List'
          (Network.Get_Route (Minneapolis, Chicago)));

   Train_2 := new Train_Tasks.Train_Task
      (ID    => 2,
       Route => new Route_Lists.List'
          (Network.Get_Route (Chicago, Detroit)));

   Train_3 := new Train_Tasks.Train_Task
      (ID    => 3,
       Route => new Route_Lists.List'
          (Network.Get_Route (Minneapolis, Fargo)));

   null;
end Railroad;