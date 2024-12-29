#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# When you run your insert_data.sh script, it should add each unique team to the teams table. There should be 24 rows
cat games.csv | while IFS="," READ WINNER
do
  if [[ $WINNER = "winner" ]]
    INSERT_WINNER=$($PSQL "INSERT INTO teams VALUES('$WINNER')")
  fi
done