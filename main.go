package main

import (
	"flag"

	"github.com/USA-RedDragon/go-webapp-template/http"
)

func main() {
	var listen = flag.String("listen", "localhost", "The IP to listen on")
	var port = flag.Int("port", 3000, "The Port to listen on")
	flag.Parse()

	http.Start(*listen, *port)
}
