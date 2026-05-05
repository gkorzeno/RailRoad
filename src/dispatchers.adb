with Ada.Text_IO;
with Network;
with Railroad_Logic; use Railroad_Logic;

package body Dispatchers is

   task body Dispatcher is
   begin
      Ada.Text_IO.Put_Line ("Dispatcher: System Monitoring Online.");

      loop
         exit when Simulation_Time.Is_Finished;

         Ada.Text_IO.Put ("Network Status: [");
         for I in Section_ID (1) .. Section_ID (10) loop
            if Network.Track_Layout.Element (I).Is_Clear then
               Ada.Text_IO.Put (".");
            else
               Ada.Text_IO.Put
                  (Train_ID'Image
                     (Network.Track_Layout.Element (I).Occupied_By));
            end if;
         end loop;
         Ada.Text_IO.Put_Line ("] Tick:"
            & Natural'Image (Simulation_Time.Get_Ticks));

         delay 1.0;
      end loop;

      Ada.Text_IO.Put_Line ("Dispatcher: Shutting down.");
   end Dispatcher;

end Dispatchers;