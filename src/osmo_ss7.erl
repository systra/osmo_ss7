-module(osmo_ss7).

%% API
-export([start/0,
         stop/0,
         get_env/1,
         get_env/2,
         get_env/3,
         set_env/2,
         get_priv_dir/0]).

-define(APP, ?MODULE).

%% ===================================================================
%% API
%% ===================================================================

% For console start
start() ->
    start(?APP).

stop() ->
    application:stop(?APP).

get_env(Key) ->
    get_env(Key, undefined).

get_env(Key, Default) ->
    case application:get_env(?APP, Key) of
        undefined   -> Default;
        {ok, Value} -> Value
    end.

get_env(Proto, Key, Default) ->
    case get_env(Proto, undefined) of
        undefined   -> Default;
        Params ->
            case proplists:get_value(Key, Params) of
                undefined -> Default;
                Value -> Value
            end
    end.

set_env(Key, Value) ->
    application:set_env(?APP, Key, Value).

get_priv_dir() ->
    code:priv_dir(?APP).

%% ===================================================================
%% Internal
%% ===================================================================

start(App) ->
    case application:start(App) of
        ok -> ok;
        {error, {not_started, Dependency}} ->
            start(Dependency),
            start(App);
        _Error ->
            init:stop()
    end.
