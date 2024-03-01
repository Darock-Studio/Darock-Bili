console.log("%cMeowBili Extension Here!", "color: #66CCFF;");
console.log("Current Link:", window.location.href);
var bvidSpdArr = window.location.href.split('/');
var bvid = bvidSpdArr[bvidSpdArr.length - 1];
window.location.href = "drkbili://openbvid/" + bvid;
