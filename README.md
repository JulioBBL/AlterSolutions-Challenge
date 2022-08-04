# AlterSolutions-Challenge

This app was developed with MVC architecture, due to it's simplicity and lack of boilerplate code compared to other architectures when interfacing with UIKit.
A single third party Library was used, SDWebImage, through SPM, to facilitate image retrieval and caching.

The UI has been developed through view code, breaking the components in chunks to ease reuse as if this project were a real application. All UI elements support both Light and Dark modes, addapting color tones where necessary.

Requests are handled using native iOS components, such as `URLSession`, `Result` and `Decodable`, in a static environment to discard any need of instance handling through Singletons or dependency injection.

There are some bugs that still need to be ironed out, but due to time constraints, they were left as is.

**Plus** items are accounted below, with description or reasoning provided where applicable.

## Application
We would like you to build a small application that accomplishes the following:
1. The main screen will then need to present with the Pokemon name and image. You may use any layout.
2. is redirected to a detail screen explained on step 3
3. The user should see a list of a minimum of six descriptions with info plus your image.
You may use any layout.
## Procedure
1. ~~Get your API Key as explained within the documentation https://pokeapi.co/~~ 

**no longer necessary for pokeapi V2**

2. Use Android Studio (Kotlin) or XCode (Swift) and share the project via Github.
3. Write a few sentences (max. 10) about your approach and send it with your solution.
4. You can use third-party libraries with their preference to handle dependencies.
5. Take the opportunity to showcase your coding style and use whatever design pattern
(MVVM, VIPER, etc.) you would frequently have used for this kind of task.
6. You have seven days to resolve this challenge.
## Plus
- [x] Pagination: 

  the application utilizes a complex and robust pagination manager that is ready to handle different page sizes and inconsistent API results.
- [x] Functional programming
- [ ] Dependency Injection: 

  Felt unnecessary to do dependency injection on such small app, it could be done with the `RequestHandler` object, but it having static methods felt like a better choice.
- [x] Unit Testing: 

  There are basic tests implemented, just for demonstration sake.
- [ ] UI Testing
- [ ] Mark any of them as favorite and send a POST request with the Pokemon data to a WebHook like http://webhook.site. (include the WebHook URL you used in the app): 

  Felt unnecessary to execute another generic API call.
- [ ] Adapt UI to mobile orientation changes: 

  UI is responsive, despite not having distinct layouts for dsifferent orientations.
- [x] Feel free to add more items as you wish (amaze us)
