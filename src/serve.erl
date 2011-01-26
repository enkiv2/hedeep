-module('serve').
-export([serve/2]).

serve(Nodes, Data) -> serve_r(Nodes, Data), mainloop(Nodes).

serve_r(_, []) -> true;
serve_r([], Data) -> self() ! {serve, Data};
serve_r(Nodes, Data) -> hd(Nodes) ! {map, hd(Data)}, serve_r(tl(Nodes), tl(Data)).

mainloop(Nodes) -> 
	receive 
		{serve, Data} -> serve(Nodes, Data);
		{serve, NewNodes, Data} -> serve(NewNodes, Data);
		{collect, {X, Y}}  -> reduce(X, Y, hd(Nodes))
	end.

reduce(Key, Value, Node) ->
	Node ! {collect, {Key, Value}}.

