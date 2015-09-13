-module(mapreduce).
%-compile(export_all).
-export([test/0]).

mapReduce(Module, MapFunction, ReduceFunction, InputFolder, OutputFolder, NumberOfThreads) ->
    case NumberOfThreads of
	0 ->
	    MapThreads = 4;
	N -> 
	    MapThreads = N
    end,

    case file:list_dir(InputFolder) of
    	{ok, Filenames} -> 
    	    io:fwrite("reading input files... ok~n");
    	{error, Msg0} ->
    	    io:fwrite("Could not get file names because ~p~n", [Msg0]),
	    Filenames = "",
    	    exit(exit_faliure)
    end,

    case file:read_file(InputFolder++"/"++Filenames) of
    	{ok, Content} ->
    	    io:fwrite("loading content from files... "),
    	    MapInput = binary:bin_to_list(Content),
    	    io:fwrite("ok~n");
    	{error, Msg1} ->
    	    io:fwrite("Could not read input file because ~p~n",[Msg1]),
	    MapInput = "",
    	    exit(exit_failure)
    end,
    string:tokens(MapInput, "\n").
    
%    MapFunction(file:read_file(Filenames)).

map(KeyValuePair) ->
    map_helper(KeyValuePair, []).

map_helper({_Key, []}, Acc) ->
    Acc;
map_helper({Key, [Head|Tail]}, Acc) ->
    map_helper({Key, Tail}, {Head, 1}++Acc).

test()->
    mapReduce(mapreduce, fun map/1, 0, "/Users/martinsundberg/Documents/Projects/mr_inc_dist/Input", 0, 0).
