# Backwards Plan for the Vacatio "Hello World" Epic

This document tracks our development teams attempt to reverse engineer the business outcomes of
the Vacatio "Hello World" Epic, breaking them down into _user stories_ that take 8 hours or
less to complete.

## Business Outcomes

1. The developers, and (incidentally) potential travelers will be able to download the Vacatio
   app, and create a user profile in the app.

    1. As the developers, we want to implement a basic CI system in place that can
       grab and build our code, so that we have confidence that our code is actually buildable.
  
    2. As the developers, we want to deploy to the Apple App Store whenever we merge to main,
       so that our deployment process is tightly coupled to our version control system.
  
    3. As the developers, we want a mock-up of our account sign-up UI, so that we understand
       what the heck our next steps are.
  
       ##### Acceptance Criteria
  
       - Should have a Figma wireframe of Account sign-up flow.
       - Should only handle sign-in/Account creation with a phone number.
       - Users should be prompted to enter in their first and last name and optionally upload a profile photo.
       - Users should be able to sign out of the Account.
       - The developers should understand and be in concensus about what users see when they
         first open the app.
       - Bryan, our project manager, should be linked to our Figma wireframe when it's finished.
  
    4. As the developers, we want to define our application Account/User Models, so that we
       have some idea of how to store and structure our user information.
  
    5. As the developers, we want to setup a database, so that we can store Account/User
       information separately from our application.

       #### Acceptance Criteria

       - The `User` Model should have a unique identifier that users can use to identify each
         other by (e.g. phone number).
  
    6. As a user, I want to be able to easily create my account using my phone number, so that
       I can get into Vacatio.
  
    7. (Optional) As the developers, we want to setup infrastucture that allows us to easily
       create copies of our database, so that we can individually work our app without getting
       in the way of our other group members.

2. The developers, and (incidentally) potential travelers will be able to delete the app,
   redownload it, and be sure that their application information is the same as it was before
   deleting the app. (_persistence_)

3. The developers, and (incidentally) potential travelers should be able to intuitively
   navigate through Vacatio.

    1. As a user, I want to be able to have an idea of the features Vacatio offers right when I
       open the app, so that I can use the app intuitively.

       #### Acceptance Criteria

       - Should have 3 tab bar items: Trips, Explore, Account (eventually will be "Profile"
         when logged in, or "Log in" when not logged in.
    
    2. As a user, I want to be able to see my Account information, so that I can make sure it's
       correct.

       #### Acceptance Criteria

       - Given that I am logged in to Vacatio, when I click the Account tab, I will see my
         basic user info (e.g. username, name, phone number).

       - Given that I am on the Account tab, when I need to change my phone number, I can click
         a button and be prompted to change it.

    3. As a user, I want to be able to create a trip, so that I can start creating a mental
       map of my trip.

       #### Acceptance Criteria

       - Should be wireframed in Figma prior to implementing any code.

4. The developers, and (incidentally) potential travelers should be able to search travel
   destinations based on different criteria.


5. The developers, and (incidentally) potential travelers should be able to save the
   destinations they are interested in.


6. The developers, and (incidentally) potential travelers will be able to find and add other
   travelers to their trips.

    1. As a user, I want to be able to share a trip with my companions via their phone number,
       so that I can add them to a trip.

    2. As a user, I want to be able to add my companions to a trip by their account ID, so that
       I can plan a trip with them.

7. The developers, and (incidentally) potential travelers, will be able to see the destinations
   that members of their "group" have pinned.


8. In the map view individual travelers (as part of a group) will be individually
   distinguishable.


9. The developers should be completing units of work in 8 hours of time or less, and
   subsequently pushing that work to GitHub. (This is the industry standard!)


10. Devmountain instructors should at least be able to use this iPhone application via Test
    Flight by October 8th, 2021.

    1. As a user, I want to have an idea of what Vacatio does before I download it, so that I
       can decide if it's useful to me or not.

    2. As a user, I want the functionality of the app to be clarified when I create my account,
       so that I have an idea of how to use it.
