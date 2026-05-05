with Ada.Text_IO;
with Railroad_Logic; use Railroad_Logic;

package body Sim_Clocks is

   task body SimClock is
      Max_Ticks : constant Natural := 1000;
   begin
      Ada.Text_IO.Put_Line ("SimClock: Started.");
      loop
         delay 0.1;
         Simulation_Time.Increment;

         if Simulation_Time.Get_Ticks >= Max_Ticks then
            Simulation_Time.Set_Finished;
            exit;
         end if;
      end loop;
      Ada.Text_IO.Put_Line ("SimClock: Simulation complete.");
   end SimClock;

end Sim_Clocks;