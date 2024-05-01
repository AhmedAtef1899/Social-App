
//https://newsapi.org/ baseurl
// v2/top-headlines?   method url
// sources=techcrunch&apiKey=API_KEY  queries



// https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=29ecf1b2e59e4a0e86216c6db4b812d6

// https://newsapi.org/v2/everything?q=tesla&apiKey=00b0c7af435d44399900111463b5b9d5

String token = '';

String? uId ='';

void printFullText(String text)
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) {
    print(match.group(0));
  });
}