# Models

This is a markdown describing the models I want you to write, still with the copyWith and toString methods for each model. The structure of the markdown is : 2 characters '#' before the model file followed by 3 '#' with the description that will be inside the file and 3 '#' followed by a list for the parameters.

Parameters contains The dart type followed by the name of the parameter, and bellow the list point, a description of the parameter that should be put just before the declaration of this parameter in the resulting class. All the parameters should be added to the description of the class, with a format like this "/// <description> \nParameters\n<parameter> : <parameter's description>.

Give a prompt with separate code blocks for each model. The comments should be documentation comments in the code. All model classes should extend Equatable.

For each class, make the toString and copyWith methods.

For each class, the hierarchy of classes is marked with this syntax : "ClassA (Is a ClassB)" where class A should extend class B with a result of code as is : `class ClassA extends ClassB {}`.

For each class, enum are marked with this syntax : "ClassA (Is an enum)" where class A should be an enum with this result of code : `enum ClassA`.
Enums will have a list of types marked with "### Types" : "## EnumType (Is an enum) ### Description description of the enum ### Types a,b,c ### Parameters 1.String toString " will produce this code : "enum EnumType {a(toString: "A"), b(toString: "B"), c(toString: "C"); const EnumType({required this.toString}); final String toString;}". The toString parameter is an example here and should be replaced by the correct parameters in the list of parameters, like with classic classes.

---

Specific to this app :

## MovieThumbnail

### Description

Assemble informations needed to display a thumbnail of the movie/Serie on the homepage.

### Parameters

1. bool isAdult

2. int tmdbId

3. List<Genre> genres

4. String portraitSourceImage

## Genre (Is an enum)

### Description

The category of the movie or tvShow. Can be "Action", "Adventure", etc.

### Types

action, adventure, documentary

### Parameters

1. int id

2. GenreType type

Type of the genre : is either a movie or a tv show.

3. String title

## GenreType

### Description

Type of the genre : is either a movie or a tv show.

### Types

movie, tvShow

### Parameters

None

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
