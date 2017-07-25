package main

import (
	"fmt"
	"io"
	"net"
	"os"
)

func listen(listener net.Listener) {
	conn, err := listener.Accept()
	if err != nil {
		fmt.Fprintf(os.Stderr, "[!] %s\n", err)
		conn.Close()
	}
}

func connect(host, port string) {
	var addr string
	addr = net.JoinHostPort(host, port)
	// JoinHostPort combines host and port into a network address of the form host:port
	listener, err := net.Listen("tcp", addr)
	if err != nil {
		os.Exit(1)
	}
	defer listener.Close()

	for {
		listen(listener)
	}
}

func main() {
	var host, port string
	args := os.Args[1:]
	if len(args) != 2 && len(args) != 0 {
		usage(os.Stderr)
		return
	}
	if len(args) == 0 {
		fmt.Println("No host and port provided using default host 127.0.0.1 and port 8000")
		host = "127.0.0.1"
		port = "8000"
	}
	else {
		host = args[0]
		port = args[1]
		fmt.Printf("Host : %s Port : %s", host, port)
	}
	connect(host, port)
}

