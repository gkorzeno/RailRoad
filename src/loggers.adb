with Ada.Text_IO;
with Ada.Streams.Stream_IO;
with Railroad_Logic; use Railroad_Logic;

package body Loggers is

   task body EventLogger is
      use Ada.Text_IO;
      use Ada.Streams.Stream_IO;

      CSV_File    : Ada.Text_IO.File_Type;
      Binary_File : Ada.Streams.Stream_IO.File_Type;
      S           : Stream_Access;
      Current_Log : Log_Entry;
      Simulation_Active : Boolean := True;
   begin
      Create (CSV_File,    Out_File, "railroad_log.csv");
      Create (Binary_File, Out_File, "railroad_log.dat");
      S := Stream (Binary_File);

      Put_Line (CSV_File, "Train_ID,Section_ID,Message");

      while Simulation_Active or else Event_Queue.Count > 0 loop
         if Event_Queue.Count > 0 then
            Event_Queue.Pop (Current_Log);

            Put      (CSV_File,
               Train_ID'Image   (Current_Log.Train)   & ",");
            Put      (CSV_File,
               Section_ID'Image (Current_Log.Section) & ",");
            Put_Line (CSV_File, Current_Log.Message);

            Log_Entry'Write (S, Current_Log);
         else
            delay 0.5;
            if Simulation_Time.Is_Finished then
               Simulation_Active := False;
            end if;
         end if;
      end loop;

      Close (CSV_File);
      Close (Binary_File);
      Put_Line ("Logger: Files saved and closed.");
   end EventLogger;

end Loggers;