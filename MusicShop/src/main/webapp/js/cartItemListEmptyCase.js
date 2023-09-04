/** cart.jsp의 cartItemList가 비어있다면 불러오는 js파일.
 * 
 */
var more_song_btn = document.getElementById('more-song-btn');
var my_song_btn = document.getElementById('my-song-btn');
more_song_btn.addEventListener('click', function() {
	window.location.href= jstlContextPath+"/album.jsp";
});
my_song_btn.addEventListener('click', function() {
	window.location.href= jstlContextPath+"/my_song.jsp";
});
 	