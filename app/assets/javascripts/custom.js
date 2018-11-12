$(document).ready(function () {
$('#search-button').on('click',function(){
    var keyword = $('#book-search').val();
    var url = "https://www.googleapis.com/books/v1/volumes?q=" + keyword;
    console.log(url);
});
})