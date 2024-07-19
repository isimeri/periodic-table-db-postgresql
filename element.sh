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
    # select by atomic number
      NAME=$($PSQL "select name from elements where atomic_number=$ARG1")
      if [[ -z $NAME ]]; then
        # not found, display msg
        echo "I could not find that element in the database."
      else
        # found
        SYMBOL=$($PSQL "select symbol from elements where atomic_number=$ARG1")
        ATOMIC_MASS=$($PSQL "select atomic_mass from properties where atomic_number=$ARG1")
        TYPE=$($PSQL "select type from properties where atomic_number=$ARG1")
        MELTING_POINT=$($PSQL "select melting_point_celsius from properties where atomic_number=$ARG1")
        BOILING_POINT=$($PSQL "select boiling_point_celsius from properties where atomic_number=$ARG1")

        echo "The element with atomic number $ARG1 is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      fi
    elif [[ $ARG1 =~ ^[A-Za-z]{1,3}$ ]]; then
    # select by symbol
      ATOMIC_NUMBER=$($PSQL "select atomic_number from elements where symbol='$ARG1'")
      if [[ -z $ATOMIC_NUMBER ]]; then
        # not found, display msg
        echo "I could not find that element in the database."
      else
        # found
        NAME=$($PSQL "select name from elements where symbol='$ARG1'")

        ATOMIC_MASS=$($PSQL "select atomic_mass from properties where atomic_number=$ATOMIC_NUMBER")
        TYPE=$($PSQL "select type from properties where atomic_number=$ATOMIC_NUMBER")
        MELTING_POINT=$($PSQL "select melting_point_celsius from properties where atomic_number=$ATOMIC_NUMBER")
        BOILING_POINT=$($PSQL "select boiling_point_celsius from properties where atomic_number=$ATOMIC_NUMBER")

        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($ARG1). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      fi
    elif [[ $ARG1 =~ ^[A-Za-z]{3,}$ ]]; then
    # select by name
      ATOMIC_NUMBER=$($PSQL "select atomic_number from elements where name='$ARG1'")
      if [[ -z $ATOMIC_NUMBER ]]; then
        # symbol not found, display msg
        echo "I could not find that element in the database."
      else
        SYMBOL=$($PSQL "select symbol from elements where name='$ARG1'")

        ATOMIC_MASS=$($PSQL "select atomic_mass from properties where atomic_number=$ATOMIC_NUMBER")
        TYPE=$($PSQL "select type from properties where atomic_number=$ATOMIC_NUMBER")
        MELTING_POINT=$($PSQL "select melting_point_celsius from properties where atomic_number=$ATOMIC_NUMBER")
        BOILING_POINT=$($PSQL "select boiling_point_celsius from properties where atomic_number=$ATOMIC_NUMBER")

        echo "The element with atomic number $ATOMIC_NUMBER is $ARG1 ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $ARG1 has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      fi
    else
      echo "I could not find that element in the database."
    fi
  fi
}

MAIN_FUNC "$1"