# Workshop Bet

This project focuses on providing the necessary tools for managing the basic data that feeds the betting system.

## Technologies Used

* Spring Boot
* Java
* Docker
* Docker Compose
* PostgreSQL

## Prerequisites

* [JDK 17 or higher]
* Docker
* Docker Compose

## Project Structure

	.
	├── deploy               		# Contains resources used during deployment. 
	├── src                  		# Source files
	│   ├── main					
	│   │	 ├── java          		# Standard location for the **main source code**.
	│   │	 ├── resources       		# This directory holds the resource files that the application needs to run
	│   │	 │	  ├── db       		
	│   │	 │	  │	  ├── migrations  # Flyway migration files
	│   ├── test          		
	│   │	 ├── java          		# This directory is dedicated to the **source code for the automated tests****.
	│   │	 ├── resources       		# Load and stress test
	│   │	 │	  ├── db       		
	│   │	 │	  │	  ├── migrations  # Flyway migration files for test purposes.
	├── Dockerfile
	├── docker-compose.ym
	├── pom.xml
	└── README.md

## Setupp

1.  **Clone the repository:**

    ```bash
    git clone git@github.com:Indev-Solutions/workshop01-back-msbet.git
    cd workshop01-back-msbet
    git checkout develop
    ```

2.  **Build the Spring Boot application:**

    ```bash
    ./mvnw clean install
    ```

3.  **Run Docker Compose:**

    ```bash
    docker-compose up -d
    ```

    This will start the database in a Docker container.

4.  **Run the Spring Boot application:**

    ```bash
    java -jar target/workshop-bet-[version].jar
    ```

    Or, if you prefer to use Maven:

    ```bash
    ./mvnw spring-boot:run
	```

## API Endpoints

* `GET /workshop/bets`: Retrieves the list of all bets.
* `GET /workshop/bets/{id}`: Retrieves a bet by its ID.

## Testing

* To run unit tests:

  ```bash
    ./mvnw test
  ```
  