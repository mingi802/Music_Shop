/**
 * window 크기 동적으로 변경
 */
window.onload = function() {
	var info = document.getElementsByClassName('info')[0];
	var infoSize = info.getBoundingClientRect();
	console.log(infoSize.width, infoSize.height);
	console.log(window.outerWidth, window.outerHeight);
	window.resizeTo(infoSize.width+15, infoSize.height+72);
	console.log(window.outerWidth, window.outerHeight);
	console.log(document.documentElement.clientWidth, document.documentElement.clientHeight);
	console.log(window.innerWidth, window.innerHeight);
	const observer = new ResizeObserver((entry) => {
		  
		  let infoSize = entry[0].contentRect;
		  console.log(infoSize.width, infoSize.height);
		  console.log(window.outerWidth, window.outerHeight);
	  
	});

	// 크기변화를 관찰할 요소지정
	observer.observe(info);
	
	var details = document.querySelectorAll("div.info details");
	console.log(details);
	details.forEach(function(detail) {
		detail.addEventListener('click', windowResizeByDivSize);
	});
}
function windowResizeByDivSize() {
	var info = document.getElementsByClassName('info')[0];
	
	const observer = new ResizeObserver((entry, observer) => {
		  
		  let infoSize = entry[0].contentRect;
		  window.resizeTo(infoSize.width+15, infoSize.height+72);
		  console.log(window.outerWidth, window.outerHeight);
		  observer.disconnect();
	});

	// 크기변화를 관찰할 요소지정
	observer.observe(info);
	
}