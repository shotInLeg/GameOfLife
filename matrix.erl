-module(matrix).
-export([get/3, print/3]).

getCell([Head|_], 0) ->
	Head;
getCell([_|Tail], Number) ->
	getCell(Tail, Number-1).

get(Matrix, I, J) ->
	getCell(getCell(Matrix, I), J).


% Function for print Matrix
print([Head|_], 1, M) ->
	printList(Head, M),
	io:format("~n");

print([Head|Tail], N, M) ->
	printList(Head, M),
	io:format("~n"),
	print(Tail, N-1, M).

printList([Head|_], 1) ->
	if 	Head =:= 1 -> 
			io:format("# ");
		true 	   -> 
			io:format(". ")
	end;

printList([Head|Tail], M) ->
	if 	Head =:= 1 -> 
			io:format("# ");
		true 	   -> 
			io:format(". ")
	end,
	printList(Tail, M-1).
