with Railroad_Logic; use Railroad_Logic;

package body Network is

   procedure Initialize_Railway is
   begin
      for I in Section_ID loop
         declare
            S : constant Section_Access := new Track_Section;
         begin
            Track_Layout.Insert (I, S);
         end;
      end loop;
   end Initialize_Railway;

   function Get_Route (From, To : Station_Name) return Route_Lists.List is
      Selected_Route : Route_Lists.List;
   begin
      if From = Minneapolis and then To = Chicago then
         for I in Section_ID (1) .. Section_ID (4) loop
            Selected_Route.Append (I);
         end loop;

      elsif From = Chicago and then To = Detroit then
         for I in Section_ID (5) .. Section_ID (15) loop
            Selected_Route.Append (I);
         end loop;

      elsif From = Detroit and then To = Cleveland then
         for I in Section_ID (16) .. Section_ID (22) loop
            Selected_Route.Append (I);
         end loop;

      elsif From = Cleveland and then To = Indianapolis then
         for I in Section_ID (23) .. Section_ID (30) loop
            Selected_Route.Append (I);
         end loop;

      elsif From = Minneapolis and then To = Fargo then
         for I in Section_ID (31) .. Section_ID (36) loop
            Selected_Route.Append (I);
         end loop;

      elsif From = Fargo and then To = Billings then
         for I in Section_ID (37) .. Section_ID (45) loop
            Selected_Route.Append (I);
         end loop;

      end if;

      return Selected_Route;
   end Get_Route;

end Network;