-module(gameOfLife).
-export([start/0]).

count(Map, I, J, N, M) ->
	if 	I-1 =:= -1 ->
			TI = N-1;
		true ->
			TI = I-1
	end,

	if 	I+1 =:= N ->
			BI = 0;
		true ->
			BI = I+1
	end,


	if 	J-1 =:= -1 ->
			LJ = M-1;
		J-1 /= -1 ->
			LJ = J-1
	end,

	if 	J+1 =:= M ->
			RJ = 0;
		true ->
			RJ = J+1
	end,

	matrix:get(Map, TI, LJ) + matrix:get(Map, TI, J) + matrix:get(Map, TI, RJ) + 
	matrix:get(Map, I, LJ) + 0 + matrix:get(Map, I, RJ) + 
	matrix:get(Map, BI, LJ) + matrix:get(Map, BI, J) + matrix:get(Map, BI, RJ).


change(Map, N, M) ->
	NewMap = changeMatrix(Map, 0, 0, N, M),
	arrayToMatrix(NewMap, N, M).

changeMatrix(Map, I, J, N, M) ->
	State = matrix:get(Map, I, J),
	Count = count(Map, I, J, N, M),
	if 	State =:= 0, Count =:= 3 ->
			NewCell = 1;
		State =:= 1, Count >= 2, Count =< 3 ->
			NewCell = 1;
		true ->
			NewCell = 0
	end,

	if 	I /= N-1, J =:= M-1 ->
			[NewCell] ++ changeMatrix(Map, I+1, 0, N, M);
		I < N, J < M-1 ->
			[NewCell] ++ changeMatrix(Map, I, J+1, N, M);
		true ->
			[NewCell]
	end.


arrayToMatrix(Array, 1, M) ->
	[subArray(Array, M)];
arrayToMatrix(Array, N, M) ->
		[subArray(Array, M)] ++ arrayToMatrix(skipArray(Array, M), N-1, M).


subArray([Head|_], 1) ->
	[Head];
subArray([Head|Tail], N) ->
	[Head] ++ subArray(Tail, N-1).


skipArray([_|Tail], 1) ->
	Tail;
skipArray([_|Tail], N) ->
	skipArray(Tail, N-1).



game(Map, MapN, MapM) ->
	matrix:print(Map, MapN, MapM),
	MapNew = change(Map, MapN, MapM), 
	% io:format("~n~w~n", [change(Map, MapN, MapM)]),% Change function change(Map, MapN, MapM),
	if 	Map =:= MapNew -> 
			io:format("~n End. ~n");
		true 	   -> 
			timer:sleep(1000),
			game(MapNew, MapN, MapM)
	end.

start() ->
	MapN = 10,
	MapM = 10,
	Map = [
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 1, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 1, 0, 0, 0, 0, 0, 0],
		[0, 1, 1, 1, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	],

	Count = count(Map, 2, 2, MapN, MapM),
	io:format("~w ~n", [Count]),
	game(Map, MapN, MapM).
