## Thanks for checking out our CLI App!

*A quick hello from Sarah and Dan:*

We're excited to share with you our very first CLI app, Hempirical. Hempiricial is a humble app that uses The Strain API (http://strains.evanbusse.com/index.html) to access information regarding different strains of marijuana for medical purposes.

The functionality is simple: A User can search through the various strains by name, species, and/or medical symptom and add any strain to their stash. The User can also view their stash as well as add or remove any strain they like.


### Installation

1. **Obtain API Key**

    Go to [strains.evanbusse.com](http://strains.evanbusse.com/index.html), click "Get a Key". Input your name and email address to receive a unique API Key.

2. **Apply API Key to seed file**

    In the "db" folder, there is a file called seed.rb. On line 14 replace "#{$key}" in the URL with your unique API key.

2. **Migrate:**  

    Run '*rake db:migrate*' from terminal while inside the top directory

3. **Seed:**

    Run '*ruby db/seed.rb*' in terminal

    This will populate the database with The Strain API data

4. **Run the App**  

    Run '*ruby bin/run.rb*' in terminal


### Contributing

    If you would like to add to or edit Hempirical, feel free to fork this repository. Please make descriptive commit messages and open a pul request against this repo.

    If you see an issue, but don’t know exactly how to fix it, please raise a Github issue, being as descriptive as possible.

    We will periodically check in to address any changes.
