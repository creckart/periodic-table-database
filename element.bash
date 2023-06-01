#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z $1 ]]
  then
    echo -e "Please provide an element as an argument."
  else
    if [[ ! $1 =~ ^[0-9]+$ ]]
      then
        if [[ $1 =~ ^[a-zA-Z]{1,2}$ ]]
          then
            SYMBOL_INPUT=$($PSQL "SELECT e.atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements AS e INNER JOIN properties AS p ON e.atomic_number=p.atomic_number INNER JOIN types AS t ON p.type_id=t.type_id WHERE symbol='$1'")
            if [[ -z $SYMBOL_INPUT ]]
              then
                echo -e "I could not find that element in the database."
            fi
          else
            NAME_INPUT=$($PSQL "SELECT e.atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements AS e INNER JOIN properties AS p ON e.atomic_number=p.atomic_number INNER JOIN types AS t ON p.type_id=t.type_id WHERE name='$1'")
            if [[ -z $NAME_INPUT ]]
              then
                echo -e "I could not find that element in the database."
            fi
          fi
      else
        ATOMIC_NUMBER_INPUT=$($PSQL "SELECT e.atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements AS e INNER JOIN properties AS p ON e.atomic_number=p.atomic_number INNER JOIN types AS t ON p.type_id=t.type_id WHERE e.atomic_number='$1'")
        if [[ -z $ATOMIC_NUMBER_INPUT ]]
          then
            echo -e "I could not find that element in the database."
        fi
    fi

    if [[ $ATOMIC_NUMBER_INPUT ]]
        then
          echo "$ATOMIC_NUMBER_INPUT" | while read ATOMIC_NUMBER BAR NAME BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT
            do
              echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
            done
      elif [[ $SYMBOL_INPUT ]]
        then
          echo "$SYMBOL_INPUT" | while read ATOMIC_NUMBER BAR NAME BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT
            do
              echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
            done
      elif [[ $NAME_INPUT ]]
        then
          echo "$NAME_INPUT" | while read ATOMIC_NUMBER BAR NAME BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT
            do
              echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
            done
    fi
fi