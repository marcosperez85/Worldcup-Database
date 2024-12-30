#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# When you run your insert_data.sh script, it should add each unique team to the teams table. There should be 24 rows
echo $($PSQL "TRUNCATE games,teams")

cat games.csv | while IFS=',' read -r year round winner opponent winner_goals opponent_goals
do
  # Evalua que las variables declaradas no tengan el valor del encabezado
  if [[ $winner != winner && $opponent != opponent ]]
  then
    # Agregar equipos si no existen
    $PSQL "INSERT INTO teams(name) VALUES('$winner') ON CONFLICT (name) DO NOTHING;"
    $PSQL "INSERT INTO teams(name) VALUES('$opponent') ON CONFLICT (name) DO NOTHING;"

    # Obtener los IDs de los equipos
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$winner';")
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$opponent';")

    $PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals)
    VALUES($year, '$round', $WINNER_ID, $OPPONENT_ID, $winner_goals, $opponent_goals);"
  fi
done