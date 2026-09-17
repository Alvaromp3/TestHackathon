PORT ?= 8000
HOST ?= localhost
PIDFILE := .server.pid
FRONTEND := frontend

.PHONY: up down

up:
	@if [ -f $(PIDFILE) ] && kill -0 $$(cat $(PIDFILE)) 2>/dev/null; then \
		echo "Already running on http://$(HOST):$(PORT) (pid $$(cat $(PIDFILE)))"; \
	else \
		python3 -m http.server $(PORT) --bind $(HOST) --directory $(FRONTEND) >/dev/null 2>&1 & \
		echo $$! > $(PIDFILE); \
		echo "Tiger Hacks → http://$(HOST):$(PORT)"; \
	fi

down:
	@if [ -f $(PIDFILE) ]; then \
		kill $$(cat $(PIDFILE)) 2>/dev/null || true; \
		rm -f $(PIDFILE); \
	fi
	@pkill -f "python3 -m http.server $(PORT)" 2>/dev/null || true
	@echo "Server stopped."
