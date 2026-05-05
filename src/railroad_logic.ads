with Ada.Containers.Ordered_Maps;
with Ada.Containers.Doubly_Linked_Lists;
with Ada.Containers.Vectors;

package Railroad_Logic is

   type Train_ID     is range 1 .. 10;
   type Section_ID   is range 1 .. 50;
   type Train_Speed  is digits 7 range 0.0 .. 200.0;
   type Train_State  is (Waiting, Moving, Stopped, Arrived);
   type Signal_State is (Clear, Caution, Danger);
   type Station_Name is
      (Minneapolis, Chicago, Detroit, Cleveland, Indianapolis, Fargo, Billings);

   protected type Track_Section is
      entry Request (T : Train_ID);
      procedure Release (T : Train_ID);
      function Is_Clear return Boolean;
      function Occupied_By return Train_ID;
   private
      Occupied      : Boolean  := False;
      Current_Train : Train_ID := Train_ID'First;
   end Track_Section;

   protected type Signal is
      procedure Set (S : Signal_State);
      function Get return Signal_State;
   private
      State : Signal_State := Clear;
   end Signal;

   protected type Station is
      procedure Train_Arrives (T : Train_ID);
      procedure Train_Departs (T : Train_ID);
      function Platform_Free return Boolean;
   private
      Platform_Occupied : Boolean  := False;
      Resident_Train    : Train_ID := Train_ID'First;
   end Station;

   type Section_Access is access Track_Section;

   package Section_Maps is new Ada.Containers.Ordered_Maps
      (Key_Type     => Section_ID,
       Element_Type => Section_Access);

   package Route_Lists is new Ada.Containers.Doubly_Linked_Lists
      (Element_Type => Section_ID);

   package Train_Queues is new Ada.Containers.Vectors
      (Index_Type   => Natural,
       Element_Type => Train_ID);

   type Log_Entry is record
      Train   : Train_ID;
      Section : Section_ID;
      Message : String (1 .. 40);
   end record;

   package Event_Logs is new Ada.Containers.Vectors
      (Index_Type   => Natural,
       Element_Type => Log_Entry);

   type Route_Access is access Route_Lists.List;

   protected Event_Queue is
      procedure Push (Item : in Log_Entry);
      entry Pop (Item : out Log_Entry);
      function Count return Natural;
   private
      Buffer : Event_Logs.Vector;
   end Event_Queue;

   protected Simulation_Time is
      procedure Increment;
      function  Get_Ticks return Natural;
      function  Is_Finished return Boolean;
      procedure Set_Finished;
   private
      Current_Tick : Natural := 0;
      Done         : Boolean := False;
   end Simulation_Time;

end Railroad_Logic;