# monarchmakersbnb

## [Task](https://github.com/makersacademy/course/tree/master/makersbnb)

# monarchmakersbnb

## [Task](https://github.com/makersacademy/course/tree/master/makersbnb)

## Setting Up The Database

1. Connect to `psql` in the command line.
2. Create the database using the command `CREATE DATABASE "makers_bnb";`.
3. Connect to the newly created database using `\c makers_bnb`.
4. Run the queries saved in the files in `db/migrations` to set up the appropriate tables.
5. To set up the test database, repeat steps 2 and 3 in `psql` with `makers_bnb_test`.

## Running The Application

1. Ensure the database is set up using the _Setting Up The Database_ instructions above.
2. Run `rackup` in the command line.
3. Go to `localhost:9292` in Google Chrome or Mozilla Firefox.

## Running the Tests

1. Ensure the test database is set up using the _Setting Up The Database_ instructions above.
1. Ensure you are in the project root on the command line.
1. Run `rspec` in the command line.

## User Stories

[Link to Trello User Stories Board](https://trello.com/b/fBNwccl8/user-stories)

- As a user, So that I can see all/list properties I would like to be able to sign up for Makers BNB
- As a user, so that I can find a property, I would like to be able to see a list of all properties I can book
- As a user, so that I can list a property, I would like to be able to become a 'host'
- As a user, so that I can have a place to stay, I would like to be able book a property
- As a user, so that I can confirm my booking, I would like to receive a confirmation from the host
- As a host, so that I can manage all my properties, I would like to be able to add multiple properties
- As a host, so a user can book my space, I would like to provide details about my space(description, price, location)
- As a host, so that users can book my property, I would like to be able to approve the request

## Our Process

As a team, we felt that in order to execute on the project efficiently, we needed a solid idea of what our vision for the project was. How would we go about building MakersBnB? What would the database architecture look like?<br>
What pages did we need in order to meet the criteria in the user stories? Without having all of these questions - and many, many more - answered and agreed upon before we started to implement, our individual efforts may diverge quickly.<br>
As such, we spent the whole of Monday and part of Tuesday planning and diagramming the backend of the project.<br>
We felt it was important to keep things as simple as possible while ensuring that we met the specifications in the user stories. We kept our solution down to 3 classes and 3 database tables.

## Model Diagrams

#### CRC Cards

<figure>
    <img width="795" alt="model_diagram_01" src="https://user-images.githubusercontent.com/65397514/100461246-703f9000-30c0-11eb-9330-06ccf489873e.png">
    <figcaption><i>Initial CRC Cards displaying all tables of the makers_bnb database</i></figcaption>
</figure>

#### Class Diagram

<figure>
    <img width="1074" alt="Screenshot 2020-11-24 at 10 58 46" src="https://user-images.githubusercontent.com/65397514/100459237-0b366b00-30bd-11eb-8e54-a302d2d1017d.png"/>
    <figcaption><i>Initial Class Diagram created during the planning session, containing all three classes used.</i></figcaption>
</figure>

#### Flowchart as User/Host

<figure>
    <img width="751" alt="Screenshot 2020-11-24 at 11 24 37" src="https://user-images.githubusercontent.com/65397514/100459249-1093b580-30bd-11eb-9ddb-2d502e9da0be.png">
    <figcaption><i>Flowchart representing the initial planning for a simple workflow of a host</i></figcaption>
</figure>

#### Flowchart as User/Guest

<figure>
    <img width="955" alt="Screenshot 2020-11-24 at 11 10 56" src="https://user-images.githubusercontent.com/65397514/100459255-12f60f80-30bd-11eb-9aba-868dff4cc1b3.png">
    <figcaption><i>Flowchart representing the initial planning for a simple workflow of a guest</i></figcaption>
</figure>
