# Movie App #

### What has been done

1. The app displays a list of movies currently being plaied in cinemas.
	
2. The list of movies contains endless pagination, swipe to refresh, error handling and empty list view. 

3. On the list view a user is able to add movie to favorites. The data is stored in UserDefaults.

4. A user is able to see details of each movie.
	
5. Details screen displayes movie's image, title, release date, rating and description

6. A user is able to add movie to favorites from the details screen. It is also refreshed on list screen.

7. To make list scroll smoother, on the list the app displayes smaller version of image and in details the original one.

## Testing

The Movie App leverages two different kinds of tests to cover the code:

* Unit Tests - Verify business logic
* Snapshot Tests - Verify the look of our UI

Only some tests was added to demonstrate the different kinds. There is now full coverage for now.

> **_NOTE:_** Snapshot Tests have to be run on iPhone 15.