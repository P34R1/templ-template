package main

import (
	"fmt"
	"net/http"

	"github.com/a-h/templ"
)

func main() {
	http.Handle("/", templ.Handler(root()))

	fmt.Println("Listening on port 8100")
	http.ListenAndServe("[::]:8100", nil)
}
