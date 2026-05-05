with Railroad_Logic; use Railroad_Logic;

package Train_Tasks is

   task type Train_Task (ID : Train_ID; Route : Route_Access);

   type Train_Task_Access is access Train_Task;

end Train_Tasks;