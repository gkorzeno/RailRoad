with Ada.Text_IO;
with Network;
with Railroad_Logic; use Railroad_Logic;

package body Train_Tasks is

   task body Train_Task is
      use Route_Lists;

      Current_Pos  : Cursor;
      Next_Pos     : Cursor;
      Next_Sect    : Section_ID;
      Held_Section : Section_ID;
      Has_Baton    : Boolean := False;
      Log          : Log_Entry;

      procedure Make_Log (Sect : Section_ID; Msg : String) is
         Padded : String (1 .. 40) := (others => ' ');
         Len    : constant Natural :=
            (if Msg'Length > 40 then 40 else Msg'Length);
      begin
         Padded (1 .. Len) := Msg (Msg'First .. Msg'First + Len - 1);
         Log := (Train => ID, Section => Sect, Message => Padded);
         Event_Queue.Push (Log);
      end Make_Log;

   begin
      -- Wait for simulation to start
      while Simulation_Time.Get_Ticks = 0 loop
         delay 0.1;
      end loop;

      Current_Pos := Route.First;

      -- Occupy the first section
      if Has_Element (Current_Pos) then
         Held_Section := Element (Current_Pos);
         Network.Track_Layout.Element (Held_Section).Request (ID);
         Has_Baton := True;
         Make_Log (Held_Section, "Departed from first section");
      end if;

      -- Move through each section in the route
      while Has_Element (Current_Pos) loop
         Next_Pos := Next (Current_Pos);

         if Has_Element (Next_Pos) then
            Next_Sect := Element (Next_Pos);

            -- Request next section (blocks if occupied)
            Network.Track_Layout.Element (Next_Sect).Request (ID);

            -- Travel time
            delay 2.0;

            -- Release previous section
            Network.Track_Layout.Element (Held_Section).Release (ID);
            Make_Log (Held_Section, "Released section");

            Held_Section := Next_Sect;
            Make_Log (Next_Sect, "Entered section");
         else
            -- Last section — final travel time
            delay 2.0;
         end if;

         Current_Pos := Next_Pos;
      end loop;

      -- Release final section and log arrival
      if Has_Baton then
         Network.Track_Layout.Element (Held_Section).Release (ID);
         Make_Log (Held_Section, "Arrived at destination");
      end if;

      Ada.Text_IO.Put_Line
         ("Train" & Train_ID'Image (ID) & " has arrived.");

   end Train_Task;

end Train_Tasks;