#!/bin/bash

NC='\033[0m' #ANSI escape codes for colours
RED='\033[1;31m'
PURPLE='\033[1;35m'
CYAN='\033[0;36m'

echo "Enter pokemon name or pokedex number:"
read poke_name # take input
base_url="https://pokeapi.co/api/v2/pokemon/" 
base_url+=$poke_name
if [ "$(curl -s $base_url)" = "Not Found" ]; then
    printf "\n\U1F928 ${RED}Error: Pokemon not found\n\n" # oopsie
else
    weight=$(curl -s $base_url | jq -r '.weight') # use jq to parse json
    weight_corrected=$((weight / 10))
    height=$(curl -s $base_url | jq -r '.height')
    height_corrected=$((height * 10))
    type=$(curl -s $base_url | jq -r '.types[0].type.name')
    name=$(curl -s $base_url | jq -r '.name')
    ability=$(curl -s $base_url | jq -r '.abilities[0].ability.name')
    ability1=$(curl -s $base_url | jq -r '.abilities[1].ability.name') # get two abilities (two slots)
    if [ "$ability1" = 'null' ]; then
        ability1="-"
    fi
    printf "\nlearn more about: ${CYAN}\U2728 ${name} \U2728\n\n" # print away :')
    printf "\U1F409 ${PURPLE}height\t${NC}${height_corrected}cm\n" # dragon
    printf "\U1F9DA ${PURPLE}weight\t${NC}${weight_corrected}kg\n" # fairy
    printf "\U1F525 ${PURPLE}type\t\t${NC}${type}\n" # fire
    printf "\U1F9CA ${PURPLE}ability\t${NC}${ability}/${ability1}\n\n" # ice
fi
