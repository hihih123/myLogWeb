<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Monitor</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="/resources/js/jquery-3.2.1.min.js"></script>
	<script src="/resources/js/dygraph.min.js"></script>
	<link rel="stylesheet" href="/resources/css/dygraph.css" />
	<script>

	$(document).ready(function () {
		
		//init data
		var data_cpu = [];
		var data_mem = [];
		var data_hdd = [];
		var lastCount = "000000000000000000000000";//해당 objId 이후 값을 가져온다.

		//init chart
	    var g_cpu = new Dygraph(document.getElementById("div_g_cpu"), data_cpu,
	                          {
	                            drawPoints: true,
	                            showRoller: false,
	                            valueRange: [0.0, 100.0],
	                            labels: ['Time', 'CPU']
	                          });
		
	    var g_mem = new Dygraph(document.getElementById("div_g_mem"), data_mem,
                {
                  drawPoints: true,
                  showRoller: false,
                  labels: ['Time', 'MEM']
                });
	    
	    var g_hdd = new Dygraph(document.getElementById("div_g_hdd"), data_hdd,
                {
                  drawPoints: true,
                  showRoller: false,
                  labels: ['Time', 'HDD']
                });
	    
	    
	    
	    var repeatFunc = function(){
	    	
	    	$.getJSON("http://130.211.254.77:3000/resource/com-id/0090F5E956B0/count/" + lastCount,
					  function(obj) {
	  					if(obj.length == 0){
	  						console.log('@@No data');
	  					}else{
	  						console.log('@@Data count : ' + obj.length);
	  						$.each(obj, function(inx, row) {
	  							
		 				    	console.log('@@ID : ' + row._id);
		 				    	console.log('@@TIM : ' + row.local_time);
		 				    	console.log('@@CPU : ' + row.cpu);
		 				    	console.log('@@MEM : ' + row.mem);
		 				    	console.log('@@HDD : ' + row.hdd);
		 				    	
		 				    	var t = new Date(row.local_time);
		 				    	data_cpu.push([t,row.cpu]);
		 				    	data_mem.push([t,row.mem]);
		 				    	data_hdd.push([t,row.hdd]);
		 				    	
		 				    	lastCount = row._id;
						    });
	  					}
	  					
	  					g_cpu.updateOptions( { 'file': data_cpu } );
	  					g_mem.updateOptions( { 'file': data_mem } );
	  					g_hdd.updateOptions( { 'file': data_hdd } );
					  });
	    	
	    }
	    
	    repeatFunc();//즉시 실행 후 타이머
	    window.intervalId = setInterval(function() {
	    	                                               
	    	  repeatFunc();
	    }, 2000); 
	  }
	);
	</script>
</head>
<body>
<h2>
실시간 자원 현황 (갱신 주기 : 2초)<br/>
MacAddress : ${macAddr}<br/>
</h2>
<div style="display: inline-block;">
CPU 부하율 (단위 : %)
<div id="div_g_cpu" style="width:600px; height:300px;"></div>
</div>
<div style="display: inline-block;">
MEM 점유율 (단위 : MB)
<div id="div_g_mem" style="width:600px; height:300px;"></div>
</div>
<div style="display: inline-block;">
HDD 남은 용량 (단위 : GB)
<div id="div_g_hdd" style="width:600px; height:300px;"></div>
</div>

</body>
</html>
