# Models

This is a markdown describing the models I want you to write, still with the copyWith and toString methods for each model. The structure of the markdown is : 2 characters '#' before the model file followed by 3 '#' with the description that will be inside the file and 3 '#' followed by a list for the parameters.

Parameters contains The dart type followed by the name of the parameter, and bellow the list point, a description of the parameter that should be put just before the declaration of this parameter in the resulting class. All the parameters should be added to the description of the class, with a format like this "/// <description> \nParameters\n<parameter> : <parameter's description>.

Give a prompt with separate code blocks for each model. The comments should be documentation comments in the code. All model classes should extend Equatable.

For each class, make the toString and copyWith methods.

For each class, the hierarchy of classes is marked with this syntax : "ClassA (Is a ClassB)" where class A should extend class B with a result of code as is : `class ClassA extends ClassB {}`.

---

Specific to this app :

## Movie

### Description

Assemble all informations about one movie : date, realisation, description, etc.

### Parameters

1. String title

The title of the movie.

2. String description

A brief overview or description of the movie.

3. List<String> genres

Genres associated with the movie (e.g., action, comedy, drama, etc.).

4. String director

The director of the movie.

5. int releaseYear

The year the movie was released.

6. double rating

The movie's average user rating.

7. String imageUrl

The URL to the movie's poster or cover image.

8. int duration

The duration or runtime of the movie in minutes.

9. List<String> cast

List of actors or cast members associated with the movie.

10. String videoUrl

The URL to stream the movie or the actual video content.

11. bool isFavorite

A flag indicating if the movie has been marked as a favorite by the user.

12. bool isWatched

A flag indicating if the user has already watched the movie.
