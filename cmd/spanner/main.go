package main

import (
	"os/exec"

	"github.com/rs/zerolog/log"
)

func main() {
	log.Info().Msg("spanner is starting up")
	command := exec.Command("./gateway_main", "--hostname", "0.0.0.0")
	if err := command.Run(); err != nil {
		log.Fatal().Err(err).Msg("command.Run")
	}
}
