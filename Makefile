PORT ?= 8000
PIDFILE := .server.pid
FRONTEND := frontend

.PHONY: up down

up:
	@if [ -f $(PIDFILE) ] && kill -0 $$(cat $(PIDFILE)) 2>/dev/null; then \
		echo "Already running on http://127.0.0.1:$(PORT) (pid $$(cat $(PIDFILE)))"; \
	else \
		cd $(FRONTEND) && python3 -m http.server $(PORT) --bind 127.0.0.1 >/dev/null 2>&1 & echo $$! > ../$(PIDFILE); \
		echo "Tiger Hacks → http://127.0.0.1:$(PORT)"; \
	fi

down:
	@if [ -f $(PIDFILE) ]; then \
		kill $$(cat $(PIDFILE)) 2>/dev/null || true; \
		rm -f $(PIDFILE); \
	fi
	@pkill -f "python3 -m http.server $(PORT)" 2>/dev/null || true
	@echo "Server stopped."
