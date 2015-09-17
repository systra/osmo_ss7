REBAR = ./rebar

.PHONY: deps test

compile:
	@$(REBAR) compile

deps:
	@$(REBAR) get-deps

clean:
	@$(REBAR) clean

test:
	@$(REBAR) eunit skip_deps=true

run:
	@erl -pa apps/*/ebin deps/*/ebin -sname ss7 -s osmo_ss7
