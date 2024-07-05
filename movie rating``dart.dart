``dart
import 'package:flutter/material.dart';
// Sample movie data model
class Movie {
final String title;
final String description;
final String posterImageUrl;
double averageRating;
List<String> cast;
Movie({
required this.title,
required this.description,
required this.posterImageUrl,
this.averageRating = 0.0,
this.cast = const [],
});
}
void main() {
runApp(MovieRatingApp());
}
class MovieRatingApp extends StatelessWidget {
@override
Widget build(BuildContext context) {
return MaterialApp(
title: 'Movie Rating App',
theme: ThemeData(
primarySwatch: Colors.blue,
),
home: MovieListScreen(),
);
// Sample movie data
final List<Movie> movies = [
Movie(
title: 'The Shawshank Redemption',
description:
'Two imprisoned men bond over a number of years, finding solace and eventual
redemption through acts of common decency.',
posterImageUrl:
'https://www.gstatic.com/tv/thumb/v22vodart/1744/p1744_v_v8_ab.jpg',
averageRating: 9.3,
cast: ['Tim Robbins', 'Morgan Freeman'],
),
Movie(
title: 'The Godfather',
description:
'The aging patriarch of an organized crime dynasty transfers control of his clandestine
empire to his reluctant son.',
posterImageUrl:
'https://www.gstatic.com/tv/thumb/v22vodart/12025/p12025_v_v8_ad.jpg',
averageRating: 9.2,
cast: ['Marlon Brando', 'Al Pacino'],
),
// Add more sample movies here
];
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text('Movies'),
),
body: ListView.builder(
itemCount: movies.length,
itemBuilder: (context, index) {
return MovieListItem(movie: movies[index]);
),
);
}
}
class MovieListItem extends StatelessWidget {
final Movie movie;
const MovieListItem({required this.movie});
@override
Widget build(BuildContext context) {
return ListTile(
leading: Image.network(
movie.posterImageUrl,
width: 50,
height: 50,
fit: BoxFit.cover,
),
title: Text(movie.title),
subtitle: Text(movie.description),
onTap: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => MovieDetailsScreen(movie: movie),
),
);
},
);
}
}
class MovieDetailsScreen extends StatefulWidget {
final Movie movie;
const MovieDetailsScreen({required this.movie});
@override
_MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}
class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
double userRating = 0.0; // User's rating for the movie
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text(widget.movie.title),
),
body: SingleChildScrollView(
padding: EdgeInsets.all(16),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Image.network(
widget.movie.posterImageUrl,
width: 150,
height: 200,
fit: BoxFit.cover,
),
SizedBox(height: 16),
Text(
'Description:',
style: TextStyle(fontWeight: FontWeight.bold),
),
Text(widget.movie.description),
SizedBox(height: 16),
Text(
'Cast:',
style: TextStyle(fontWeight: FontWeight.bold),
),
Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: widget.movie.cast
.map((actor) => Text(actor))
.toList(),
),
SizedBox(height: 16),
Text(
'Average Rating: ${widget.movie.averageRating.toStringAsFixed(1)}',
style: TextStyle(fontWeight: FontWeight.bold),
),
SizedBox(height: 16),
Text(
'Your Rating:',
style: TextStyle(fontWeight: FontWeight.bold),
),
Slider(
value: userRating,
min: 0,
max: 10,
divisions: 10,
label: userRating.toStringAsFixed(1),
onChanged: (value) {
setState(() {
userRating = value;
});
},
),
SizedBox(height: 16),
ElevatedButton(
onPressed: () {
// Update movie's average rating based on user input
setState(() {
widget.movie.averageRating =
(widget.movie.averageRating + userRating) / 2;
});
// You can store the user's rating in a database here
},
child: Text('Submit Rating'),
),
],
),
),
);
}
}
