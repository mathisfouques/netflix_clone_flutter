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

---

## CategoryMovies

### Description

Contains a list of movies that corresponds to the proper genre in the class

### Parameters

1. bool isAdult

2. List<MovieThumbnail>

3. Genre genre

## MovieThumbnail

### Description

Assemble informations needed to display a thumbnail of the movie/Serie on the homepage.

### Parameters

1. bool isAdult

2. int tmdbId

3. List<Genre> genres

4. String portraitSourceImage

## Genre

### Description

The genre of the movie or tvShow. Can be "Action", "Adventure", etc. Refers the id of the genre.

### Parameters

1. int id

Id of the genre in tmdb databse.

2. GenreType type

Type of the genre : is either a movie or a tv show.

3. String title

Name of the genre (english)

## GenreType (Is an enum)

### Description

Type of the genre : is either a movie or a tv show.

### Types

movie, tvShow

## MovieDetails

### Description

Assemble all informations about one movie : date, realisation, description, etc.

### Parameters

1. String title

The title of the movie.

2. String description

A brief overview or description of the movie.

3. List<Genre> genres

Genres associated with the movie (e.g., action, comedy, drama, etc.).

4. int? releaseYear

The year the movie was released. Null when the result from the api is not correct.

5. int id

Id of the movie.

6. Credits? credits

The credits of the movie. Can be null (for now ...) in case the credits call didn't work as expected.

7. List<Trailer>? trailers

The list of movie videos of type Trailer and coming from youtube

8. List<MovieThumbnail>? similarMovies

A list of MovieThumbnails that are similar to the movie.

## Credits

### Description

Encapsulates the director of the movie, as well as few of the most popular actors that played in the movie.

### Parameters

1. int forMovieId

Id of the movie associated with the credits.

2. String director

The director of a movie

3. List<String> popularActors

Most popular actors playing in the movie, by name. Length should be at least 3.

## Trailer

### Description

The trailer to show for one particular movie. Is generally linked to MovieDetails. In the future, on web, will be playing directly on the thumbnail ?

### Parameters

1. String name

The name of the trailer.

2. String youtubeKey

The key to be able to show the youtube video. http://<yt>?v=<youtubeKey> (normalement)
