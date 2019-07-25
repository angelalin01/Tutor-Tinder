# Tutor-Tinder

Tutor matching app in the style of Tinder


# App description: 

Tutor Tinder is a tutor matching app that connects students seeking tutoring with those that can provide the service based on needs and mutual preferences. Each user can choose to either be a student or a tutor, and will specify what kind of subject they need help on/can help on, what kind of price they are willing to pay/charge, and where they are based (location). Based on the user-specified criteria from both parties, the app will suggest either students or tutors to your feed with their contact infos (or a direct messaging feature). 

# Concepts applied:

- Networking (Firebase): database to store user information/preferences once user register with the ability to have such info retrieved when user hits “browse through preferences.” Based on each user’s specified criteria, the app will search through the database and return all users from the counterpart role that meet the criteria. 
- Segues: multiple view controllers with segues implemented so user can navigate back and forth
    - Login, Profile page, swiping/selecting page 
- Protocols and Delegation (TableView): TableView ViewController for the page that presents all the people the user has matched with  
- Camera: User can upload profile pic when creating user profile
