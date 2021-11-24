creative points

1. What you added
1.1 Create a new page named "Ranking" to show ranked movies based on score
1.2 Add a "Share" button to share movie details or add to Reminders or add to Messages or add to Shared Album and so on
1.3 Add a "Download" button to get the image of Movie Details Page and save it to Photos Library and add an alert when users click "Share" button
1.4 Add an alert when when users click "Add to Favorites" button
1.5 Add a new page to show the database source
1.6 Add a button to clean all favorites
1.7 Show popular movies when app launches
1.8 Save all the information about a favorited movie locally
1.9 Create a Upcoming Movie page

2. How you added it and what the process involved
2.1 Create a new View Controller, connect it with Navigation Controller then connect with Tab Bar Controller. Add Table View inside and get movies through API. Use sort function to sort all movies based on their scores and rank them from high score to low score. And show top 15 movies in the page. Meanwhile, connect this page to Movie Details Page to let users enter Movie Details Page from Raking Page.
2.2 Create an UIButton in Movie Details Page and add an action to it. Use UIActivityViewController to make whole Movie Details an activity. Then use popoverPresentationController to finish the share function.
2.3 Create an UIButton in Movie Details Page and add an action to it. Use an extension to change the whole  Movie Details View to image and use UIImageWriteToSavedPhotosAlbum to save image to Photos Library. Use UIAlertController to create an alert and decide its title, message and preferredStyle. Add alert function inside imageSaved function.
2.4 Use UIAlertController to create an alert and decide its title, message and preferredStyle. Add alert function inside addFav function.
2.5 Create a new View Controller, connect it with Navigation Controller then connect with Tab Bar Controller. Then add UILabel inside.
2.6 Add a button. Make the array that store all favorited movies null. And refresh the favorite list.
2.7 Get api of popular movies first. Get json data from url, and decode json data. Also call CacheImages. And put this function under viewDidLoad().
2.8 Use UserDefaults to save all information of a movie when users click the "Add to Favorite" button. Then in Favorite List, when users click any movie name, get all information saved and push these information to DetailedViewControl. Meanwhile, when delete any movie or clean all movies, also update the UserDefaults.
2.9 Get the api of upcoming movies first. Get json data from url, and decode json data. Also call CacheImages. And use Collection View.

3. Why you added it
3.1 It's very meaningful to create Raking Page because sometimes users don't know which movies they would like to watch. And they can watch the movies ranking and maybe this ranking can bring them ideas. On the same time, they can directly enter Movie details page from Ranking Page, which make it convenient for users cause they don't need to remember the movie name and have a search.
3.2 It makes it easier for users to share the details of movie. Sometimes users may want to share the movie to their friends or families, or add it into Reminder, or add to Messages, or add to Shared Album and so on, and it's hard for them to describe a lot of movie information. This button can be helpful to this situation.
3.3 It's very useful to save current drawing to the Photos Library. In that case, you can easily find what you browse last time without recalling. And you can share the image you draw to any friend. And an alert is very necessary because if users click the button without any message and any feedback, they may feel confused about it.
3.4 An alert is very necessary because this can make users realize that the action that they click the Add to Favorites button has already been triggered. Then whey can find favorited movies in favorite List.
3.5 This can make users know what is the database source of this app.
3.6 If users have a lot of movies in Favorite List, it's hard for them to delete one by one. Therefore, a "Clean All" button is very necessary.
3.7 Users can see all popular movies when they launch app. And it's very useful because sometimes they don't know what to search and don't know what to watch. So they can browse popular movies when app launches.
3.8 In this way, information of a movie can be saved locally which means when users click the movie name in Favorite List, data will not need to be obtained again from the Internet. They can access such information even without the Internet.
3.9 In this page, users can directly see what movie is upcoming. And maybe they can schedule time to watch them.
