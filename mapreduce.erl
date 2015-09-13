-module(mapreduce).
-compile(export_all).

mapReduce(Module, MapFunction, ReduceFunction, InputFolder, OutputFolder, NumberOfThreads) ->
    case NumberOfThreads of
	0 ->
	    MapThreads = 4;
	N -> MapThreads = N
    end,
    MapThreads.

