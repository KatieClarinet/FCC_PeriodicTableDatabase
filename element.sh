#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ $1 ]]
  then
#  echo $1
  # if it's a number  
    if [[ $1 =~ ^[0-9]+$ ]]
      then
      ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $1;")
      # if not atomic number
        if [[ -z $ATOMIC_NUMBER ]]
          then
          # NOT IN SYSTEM
          echo "I could not find that element in the database."
          else
          #if atomic number
          # echo "atomic number:" $ATOMIC_NUMBER
          SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = '$1';")
          NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = '$1';")
          TYPE_ID=$($PSQL "SELECT type_id FROM properties INNER JOIN elements ON properties.atomic_number = elements.atomic_number WHERE elements.atomic_number = $1;")
          TYPE=$($PSQL "SELECT (CASE
          WHEN $TYPE_ID = 1 THEN 'metal'
             WHEN $TYPE_ID = 2 THEN 'metalloid'
                WHEN $TYPE_ID = 3 THEN 'nonmetal'
                END)")
          MASS=$($PSQL "SELECT atomic_mass FROM properties INNER JOIN elements ON properties.atomic_number = elements.atomic_number WHERE elements.atomic_number = $1;")
          MELTING=$($PSQL "SELECT melting_point_celsius FROM properties INNER JOIN elements ON properties.atomic_number = elements.atomic_number WHERE elements.atomic_number = $1;")
          BOILING=$($PSQL "SELECT boiling_point_celsius FROM properties INNER JOIN elements ON properties.atomic_number = elements.atomic_number WHERE elements.atomic_number = $1;")
          echo -e "The element with atomic number $(echo $ATOMIC_NUMBER | sed -E 's/^ *| *$//g') is $(echo $NAME | sed -E 's/^ *| *$//g') ($(echo $SYMBOL | sed -E 's/^ *| *$//g')). It's a $(echo $TYPE | sed -E 's/^ *| *$//g'), with a mass of $(echo $MASS | sed -E 's/^ *| *$//g') amu. $(echo $NAME | sed -E 's/^ *| *$//g') has a melting point of $(echo $MELTING | sed -E 's/^ *| *$//g') celsius and a boiling point of $(echo $BOILING | sed -E 's/^ *| *$//g') celsius."

        fi
      else
      # if it's not a number
      SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol = '$1';")
      NAME=$($PSQL "SELECT name FROM elements WHERE name = '$1';")
            #if not symbol
          if [[ -z $SYMBOL ]]
            then
              SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name = '$1';")
              if [[ -z $NAME ]]
                #if not found
                then
                echo "I could not find that element in the database."
                else
                #if NAME
                ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$1';")
                TYPE_ID=$($PSQL "SELECT type_id FROM properties INNER JOIN elements ON properties.atomic_number = elements.atomic_number WHERE elements.name = '$1';")
                TYPE=$($PSQL "SELECT (CASE
          WHEN $TYPE_ID = 1 THEN 'metal'
             WHEN $TYPE_ID = 2 THEN 'metalloid'
                WHEN $TYPE_ID = 3 THEN 'nonmetal'
                END)")
                MASS=$($PSQL "SELECT atomic_mass FROM properties INNER JOIN elements ON properties.atomic_number = elements.atomic_number WHERE elements.name = '$1';")
                MELTING=$($PSQL "SELECT melting_point_celsius FROM properties INNER JOIN elements ON properties.atomic_number = elements.atomic_number WHERE elements.name = '$1';")
                BOILING=$($PSQL "SELECT boiling_point_celsius FROM properties INNER JOIN elements ON properties.atomic_number = elements.atomic_number WHERE elements.name = '$1';")
                echo -e "The element with atomic number $(echo $ATOMIC_NUMBER | sed -E 's/^ *| *$//g') is $(echo $NAME | sed -E 's/^ *| *$//g') ($(echo $SYMBOL | sed -E 's/^ *| *$//g')). It's a $(echo $TYPE | sed -E 's/^ *| *$//g'), with a mass of $(echo $MASS | sed -E 's/^ *| *$//g') amu. $(echo $NAME | sed -E 's/^ *| *$//g') has a melting point of $(echo $MELTING | sed -E 's/^ *| *$//g') celsius and a boiling point of $(echo $BOILING | sed -E 's/^ *| *$//g') celsius."

              fi
              else
              #if SYMBOL
              ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$1';")
              NAME=$($PSQL "SELECT name FROM elements WHERE symbol = '$1';")
              TYPE_ID=$($PSQL "SELECT type_id FROM properties INNER JOIN elements ON properties.atomic_number = elements.atomic_number WHERE elements.symbol = '$1';")
              TYPE=$($PSQL "SELECT (CASE
          WHEN $TYPE_ID = 1 THEN 'metal'
             WHEN $TYPE_ID = 2 THEN 'metalloid'
                WHEN $TYPE_ID = 3 THEN 'nonmetal'
                END)")
              MASS=$($PSQL "SELECT atomic_mass FROM properties INNER JOIN elements ON properties.atomic_number = elements.atomic_number WHERE elements.symbol = '$1';")
              MELTING=$($PSQL "SELECT melting_point_celsius FROM properties INNER JOIN elements ON properties.atomic_number = elements.atomic_number WHERE elements.symbol = '$1';")
              BOILING=$($PSQL "SELECT boiling_point_celsius FROM properties INNER JOIN elements ON properties.atomic_number = elements.atomic_number WHERE elements.symbol = '$1';")
  echo -e "The element with atomic number $(echo $ATOMIC_NUMBER | sed -E 's/^ *| *$//g') is $(echo $NAME | sed -E 's/^ *| *$//g') ($(echo $SYMBOL | sed -E 's/^ *| *$//g')). It's a $(echo $TYPE | sed -E 's/^ *| *$//g'), with a mass of $(echo $MASS | sed -E 's/^ *| *$//g') amu. $(echo $NAME | sed -E 's/^ *| *$//g') has a melting point of $(echo $MELTING | sed -E 's/^ *| *$//g') celsius and a boiling point of $(echo $BOILING | sed -E 's/^ *| *$//g') celsius."

          fi



    fi


  # echo -e "The element with atomic number $(echo $ATOMIC_NUMBER | sed -E 's/^ *| *$//g') is $(echo $NAME | sed -E 's/^ *| *$//g') ($(echo $SYMBOL | sed -E 's/^ *| *$//g')). It's a $(echo $TYPE | sed -E 's/^ *| *$//g'), with a mass of $(echo $MASS | sed -E 's/^ *| *$//g') amu. $(echo $NAME | sed -E 's/^ *| *$//g') has a melting point of $(echo $MELTING | sed -E 's/^ *| *$//g') celsius and a boiling point of $(echo $BOILING | sed -E 's/^ *| *$//g') celsius."

  else
  echo "Please provide an element as an argument."
fi


