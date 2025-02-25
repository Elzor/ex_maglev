DOCKER_COMPOSE=${DOCKER_COMPOSE_CMD} -f scripts/current/docker-compose.yml

rebuild:
	@echo "* Rebuild environment"
	@${DOCKER_COMPOSE} up -d --no-deps --build base
	@make exec command="mix local.hex --force && mix local.rebar --force && mix deps.get"
	@echo "ok: ready to go. You can start new development console with 'make console'"

console: __ensure_started
	@make run command=$(shell)

exec: __ensure_started
	@echo "* Run ${command}"
	@${DOCKER_COMPOSE} exec -T test ${command}

run: __ensure_started
	@echo "* Run ${command}"
	@${DOCKER_COMPOSE} exec test ${command}

gen_checksum: __ensure_started
	@make exec command="mix rustler_precompiled.download ExMaglev --all"

stop:
	@echo "* Stop"
	@${DOCKER_COMPOSE} down --remove-orphans

logs:
	@${DOCKER_COMPOSE} logs ${container}

clean: stop
	@echo "* Clean"

__ensure_started:
	@${DOCKER_COMPOSE} up --no-recreate --detach

# -----------------------------------------------------------------------------
test: __ensure_started
	@make run command='mix test'

checksum:
	@make run command='mix rustler_precompiled.download ExMaglev --all'
