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

## Setup

1.  **Clone the repository:**

    ```bash
    git clone git@github.com:Indev-Solutions/workshop01-back-msbet.git
    cd workshop01-back-msbet
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
  