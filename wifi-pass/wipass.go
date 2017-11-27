package main

import (
	"flag"
	"fmt"
	"os/user"
)

const CONNECTIONS_PATH = "/etc/NetworkManager/system-connections"

func main() {
	var name = flag.String("n", "", "Enter the name of the connection")
	var all = flag.Strin
	flag.Parse()
	fmt.Println(*name)
	if *name != "" {
		fmt.Println("[+] Got a name for the connection to find  :  ", *name)
		fmt.Println("[*] Path for the required files is  :  ", PATH)
		fmt.Println(user.Current())
	} else {
		fmt.Println("Koi naam to dedo re bhai ")
	}
}
