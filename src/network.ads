with Railroad_Logic; use Railroad_Logic;

package Network is

   Track_Layout : Section_Maps.Map;

   procedure Initialize_Railway;

   function Get_Route (From, To : Station_Name) return Route_Lists.List;

end Network;