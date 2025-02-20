#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

# Seed Service Table
SERVICE_COUNT=$($PSQL "SELECT COUNT(*) FROM services")
if [[ $SERVICE_COUNT -eq 0 ]]
then 
  $PSQL "INSERT INTO services(name) VALUES('cut'), ('color'), ('perm'), ('style'), ('trim')"
fi

# Main menu
MAIN_MENU() {
 

  # Display all services
  SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id")
  echo "$SERVICES" | while IFS="|" read SERVICE_ID SERVICE_NAME
  do 
    SERVICES_FORMATTED=$(echo "$SERVICE_ID) $SERVICE_NAME" | sed 's/\([0-9]\+\) )/\1)/g')
    echo $SERVICES_FORMATTED
  done

  read SERVICE_ID_SELECTED

  SERVICE_NAME_SELECTED=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  if [[ -z $SERVICE_NAME_SELECTED ]]
  then 
    echo -e "\nI could not find that service. What would you like today?"
    MAIN_MENU
  else
    BOOK_APPOINTMENT
  fi
}

BOOK_APPOINTMENT() {
  echo -e "\nWhat's your phone number?"
  read PHONE_NUMBER

  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$PHONE_NUMBER'")

  SERVICE_NAME_SELECTED_FORMATTED=$(echo $SERVICE_NAME_SELECTED | sed 's/ |/"/')

  if [[ -z $CUSTOMER_NAME ]]
  then
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    CUSTOMER_NAME_INSERT_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$PHONE_NUMBER')")
  fi

  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$PHONE_NUMBER'")

  echo -e "\nWhat time would you like your $SERVICE_NAME_SELECTED_FORMATTED,$CUSTOMER_NAME?"
  read SERVICE_TIME

  APPOINTMENT_INSERT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
  echo -e "\nI have put down for a $SERVICE_NAME_SELECTED_FORMATTED at $SERVICE_TIME,$CUSTOMER_NAME."
}

echo -e "\n~~~~~ MY SALON ~~~~~\n"
echo -e "Welcome to My Salon, how can I help you?\n"

MAIN_MENU