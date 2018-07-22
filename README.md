# Movie Scheduler
A program to help movie theaters optimally schedule movies.

## Prerequisites 
In order to run this program, make sure you have ruby installed.

## Usage
In order to run the program, cd into the root directory and run the following command in the terminal:

```
ruby lib/movie_scheduler.rb path/to/filename.txt
```

## Design Decisions

The biggest design decision I made was to create a **ScheduleTime** class that represented time without a date. Managing an entire DateTime object for each schedule would have created a lot of work to simple not use the date part of the class. With ScheduleTime, time is represented abstractly instead of an actual time. The class still allows for necessary operations, like adding and subtracting minutes and comparing times.

A **Movie** instance represents all the data for each movie, and is responsible for calculating its start and end time, given a definite end time.

A **Theater** instance represents the schedule, turnover time, and setup time for each theater.

A **MovieScheduler** instance handles creating an optimized schedule for each movie, and input and output.
