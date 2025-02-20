# Salon Appointment Scheduler

## Overview
This project is a **Bash script-based Salon Appointment Scheduler** that allows customers to book appointments for various services. It interacts with a PostgreSQL database to store customer details, services, and appointment information.

## Features
- Lists available salon services.
- Allows customers to book appointments.
- Stores customer details (name and phone number) in the database.
- Checks for existing customers and avoids duplicate entries.
- Saves appointment details in the database.
- Provides a confirmation message after booking.

## Technologies Used
- **Bash (Shell Scripting)**: Automates interactions with PostgreSQL.
- **PostgreSQL**: Stores customer, service, and appointment data.
- **Git**: Version control for managing project changes.

## Database Schema
The database consists of three tables:

1. **customers**
   - `customer_id` (Primary Key, Auto-increment)
   - `name` (VARCHAR)
   - `phone` (VARCHAR, Unique)

2. **services**
   - `service_id` (Primary Key, Auto-increment)
   - `name` (VARCHAR)

3. **appointments**
   - `appointment_id` (Primary Key, Auto-increment)
   - `customer_id` (Foreign Key referencing customers)
   - `service_id` (Foreign Key referencing services)
   - `time` (VARCHAR)

## Setup Instructions
1. **Clone the Repository**
   ```bash
   git clone <your-repo-url>
   cd <your-repo-folder>
   ```

2. **Set Up the Database**
   Open the PostgreSQL interactive shell:
   ```bash
   psql --username=freecodecamp --dbname=postgres
   ```
   Then create the database:
   ```sql
   CREATE DATABASE salon;
   \c salon;
   ```

3. **Run the Script**
   Make sure the script has execute permissions:
   ```bash
   chmod +x salon.sh
   ```
   Then execute it:
   ```bash
   ./salon.sh
   ```

## Usage
1. The script will display a numbered list of available services.
2. The user selects a service by entering the corresponding number.
3. The script prompts for a phone number.
   - If the phone number is new, it will prompt for a name and save the details.
   - If the phone number exists, it retrieves the existing customer’s name.
4. The user enters a preferred appointment time.
5. The script confirms the booking.

## Example Output
```
~~~~~ MY SALON ~~~~~

Welcome to My Salon, how can I help you?

1) Cut
2) Color
3) Perm

2

What's your phone number?
555-555-5555

What time would you like your color, Fabio?
11am

I have put you down for a color at 11am, Fabio.
```

## Backing Up Your Database
To back up your database:
```bash
pg_dump -cC --inserts -U freecodecamp salon > salon.sql
```
To restore it:
```bash
psql -U postgres < salon.sql
```

## Contributions
Feel free to fork this repository, make improvements, and submit a pull request.

## License
This project is licensed under the **MIT License**.

---

### Author
Developed as part of the freeCodeCamp **Relational Database Certification**.

