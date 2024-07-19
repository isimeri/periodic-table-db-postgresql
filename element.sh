#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# echo $($PSQL "select * from elements");

MAIN_FUNC(){
  ARG1="$1"
  if [[ -z $ARG1 ]]
  then
    echo "Please provide an element as an argument."
  else
    # get element by atomic num, symbol or name
    if [[ $ARG1 =~ ^[0-9]+$ ]]
    then
      NAME=$($PSQL "select name from elements where atomic_number=$ARG1")
      SYMBOL=$($PSQL "select symbol from elements where atomic_number=$ARG1")
      ATOMIC_MASS=$($PSQL "select atomic_mass from properties where atomic_number=$ARG1")
      TYPE=$($PSQL "select type from properties where atomic_number=$ARG1")
      MELTING_POINT=$($PSQL "select melting_point_celsius from properties where atomic_number=$ARG1")
      BOILING_POINT=$($PSQL "select boiling_point_celsius from properties where atomic_number=$ARG1")

      echo "The element with atomic number $ARG1 is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    elif [[ $ARG1 =~ ^[A-Za-z]{1,3}$ ]]; then
      NAME=$($PSQL "select name from elements where symbol='$ARG1'")
      ATOMIC_NUMBER=$($PSQL "select atomic_number from elements where symbol='$ARG1'")

      ATOMIC_MASS=$($PSQL "select atomic_mass from properties where atomic_number=$ATOMIC_NUMBER")
      TYPE=$($PSQL "select type from properties where atomic_number=$ATOMIC_NUMBER")
      MELTING_POINT=$($PSQL "select melting_point_celsius from properties where atomic_number=$ATOMIC_NUMBER")
      BOILING_POINT=$($PSQL "select boiling_point_celsius from properties where atomic_number=$ATOMIC_NUMBER")

      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($ARG1). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    else
      echo "wrong argument"
    fi
  fi
}

MAIN_FUNC "$1"