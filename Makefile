report: server.out
	./$< 2>/dev/null &
	sleep 1
	./client/client.sh
	killall $<

goversion: server.out
	goversion $^

%.out: %/main.go
	env GOEXPERIMENT=boringcrypto go build -o $@ ./$<

.PHONY: report goversion