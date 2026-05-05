package body Railroad_Logic is

   protected body Track_Section is

      entry Request (T : Train_ID) when not Occupied is
      begin
         Occupied      := True;
         Current_Train := T;
      end Request;

      procedure Release (T : Train_ID) is
         pragma Unreferenced (T);
      begin
         Occupied := False;
      end Release;

      function Is_Clear return Boolean is
      begin
         return not Occupied;
      end Is_Clear;

      function Occupied_By return Train_ID is
      begin
         return Current_Train;
      end Occupied_By;

   end Track_Section;

   protected body Signal is

      procedure Set (S : Signal_State) is
      begin
         State := S;
      end Set;

      function Get return Signal_State is
      begin
         return State;
      end Get;

   end Signal;

   protected body Station is

      procedure Train_Arrives (T : Train_ID) is
      begin
         Platform_Occupied := True;
         Resident_Train    := T;
      end Train_Arrives;

      procedure Train_Departs (T : Train_ID) is
         pragma Unreferenced (T);
      begin
         Platform_Occupied := False;
      end Train_Departs;

      function Platform_Free return Boolean is
      begin
         return not Platform_Occupied;
      end Platform_Free;

   end Station;

   protected body Event_Queue is

      procedure Push (Item : in Log_Entry) is
      begin
         Buffer.Append (Item);
      end Push;

      entry Pop (Item : out Log_Entry) when not Buffer.Is_Empty is
      begin
         Item := Buffer.First_Element;
         Buffer.Delete_First;
      end Pop;

      function Count return Natural is
      begin
         return Natural (Buffer.Length);
      end Count;

   end Event_Queue;

   protected body Simulation_Time is

      procedure Increment is
      begin
         Current_Tick := Current_Tick + 1;
      end Increment;

      function Get_Ticks return Natural is
      begin
         return Current_Tick;
      end Get_Ticks;

      function Is_Finished return Boolean is
      begin
         return Done;
      end Is_Finished;

      procedure Set_Finished is
      begin
         Done := True;
      end Set_Finished;

   end Simulation_Time;

end Railroad_Logic;