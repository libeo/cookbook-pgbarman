#! /usr/bin/env bats

@test "Is the binary installed ?" {
  run which barman
  [ "$status" -eq 0 ]
}
