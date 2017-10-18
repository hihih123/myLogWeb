<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Home</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="/resources/js/jquery-3.2.1.min.js"></script>
	<script>
	$(document).ready(function() {
		
		var repeatFunc = function(){
			
			$.getJSON("http://130.211.254.77:3000/computer/id",
				function(obj) {
					if(obj.length == 0){
						console.log("@@No data");
					}else{
						console.log('@@Data count : ' + obj.length);
						$('#list').text('');
						$.each(obj,
							function(idx, row) {
								
						    	$('#list').append('<a href="monitor/' + row.com_id + '">' + (idx+1) + '. MacAddress : ' + row.com_id +'</a><br/>');
						    	console.log('@@IDX : ' + (idx+1));
						    	console.log('@@ID : ' + row.com_id);
						    	console.log('@@HTM : ' + '<a href="monitor/' + row.com_id + '">' + (idx+1) + '. MacAddress : ' + row.com_id +'</a><br/>' );
							}
						);
					}
				}
			);
		}
		
		repeatFunc();//즉시 실행 후 타이머
		window.intervalId = setInterval(function() {
			
			repeatFunc();
		 }, 5000); 
		
	});
	</script>
</head>
<body>
<h2>
감지된 컴퓨터 (갱신 주기 : 5초)<br/>
</h2>
<div id="list"></div>
</body>
</html>
