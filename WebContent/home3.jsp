<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.sql.*"%>
<%@page import="com.DatabaseConnection"%>

<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<!-- META DATA -->
	<meta charset="UTF-8">
	<meta name='viewport' content='width=device-width, initial-scale=1.0, user-scalable=0'>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="description" content="Volgh –  Bootstrap 5 Responsive Application Admin panel Theme Ui Kit & Premium Dashboard Design Modern Flat HTML Template">
	<meta name="author" content="Spruko Technologies Private Limited">
	<meta name="keywords" content="analytics dashboard, bootstrap 5 web app admin template, bootstrap admin panel, bootstrap admin template, bootstrap dashboard, bootstrap panel, Application dashboard design, dashboard design template, dashboard jquery clean html, dashboard template theme, dashboard responsive ui, html admin backend template ui kit, html flat dashboard template, it admin dashboard ui, premium modern html template">

	<!-- FAVICON -->
	<link rel="shortcut icon" type="image/x-icon" href="assets/images/brand/logo.png" />

	<!-- TITLE -->
	<title>Home3</title>

	<!-- BOOTSTRAP CSS -->
	<link id="style" href="assets/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" />

	<!-- STYLE CSS -->
	<link href="assets/css/style.css" rel="stylesheet"/>

	<!-- PLUGINS CSS -->
	<link href="assets/css/plugins.css" rel="stylesheet">

	<!--- FONT-ICONS CSS -->
	<link href="assets/css/icons.css" rel="stylesheet"/>

      <link href="assets/switcher/css/switcher.css" rel="stylesheet" />
	<link href="assets/switcher/demo.css" rel="stylesheet" />
</head>
	

<script type="text/javascript">
function displaydetail(x) {
    
	var expand = document.getElementById('expand'+x).value;
	
	if(expand == "true"){
		document.getElementById("tr"+x+"child").style.display = "table-row";
		
		document.getElementById(x+"minus").style.display = "block";
		document.getElementById(x+"plus").style.display = "none";
		document.getElementById('expand'+x).value = "false";
	}else{
		document.getElementById("tr"+x+"child").style.display = "none";
		
		document.getElementById(x+"minus").style.display = "none";
		document.getElementById(x+"plus").style.display = "block";
		document.getElementById('expand'+x).value = "true";
	}
    
}


function displayalldetail() {
    
	var totalrows = document.getElementById('xval').value;
	var expandall = document.getElementById('expandall').value;
	
	if(expandall == "true"){
		
		document.getElementById("minusmain").style.display = "block";
		document.getElementById("plusmain").style.display = "none";
		for(var z=1; z <= totalrows; z++){
			
			var dis = document.getElementById("tr"+z).style.display;
			
			if(dis != "none"){
				document.getElementById("tr"+z+"child").style.display = "table-row";
				
				document.getElementById(z+"minus").style.display = "block";
				document.getElementById(z+"plus").style.display = "none";
				document.getElementById('expand'+z).value = "false";
			}
			
		}
		document.getElementById('expandall').value = "false";
		
	}else{
		
		document.getElementById("minusmain").style.display = "none";
		document.getElementById("plusmain").style.display = "block";
		for(var z=1; z <= totalrows; z++){
			
			var dis = document.getElementById("tr"+z).style.display;
			
			if(dis != "none"){
				document.getElementById("tr"+z+"child").style.display = "none";
				document.getElementById(z+"minus").style.display = "none";
				document.getElementById(z+"plus").style.display = "block";
				document.getElementById('expand'+z).value = "true";
			}
		}
		
		document.getElementById('expandall').value = "true";
	}
    
}		
</script>

<%
	Connection con;
	ResultSet res=null;
	DatabaseConnection dbconn;
	
	dbconn = new DatabaseConnection();
	con = dbconn.setConnection();
	
	String fetch_company_name = (String) session.getAttribute("company_code");
	
%>

<body class="app light-mode horizontal">

     
<!-- GLOBAL-LOADER -->
<div id="global-loader">
    <img src="assets/images/loader.svg" class="loader-img" alt="Loader">
</div>
<!-- /GLOBAL-LOADER -->

<!-- PAGE -->
<div class="page">
    <div class="page-main">
    
       	  <jsp:include page="header.jsp"></jsp:include>
    
     	  <!--app-content open-->
	      <div class="app-content main-content">
	          <div class="side-app">
	
	              <div class="main-container">
	
		              <!-- PAGE-HEADER -->
		              <div class="page-header">
		                  <div>
		                      <h1 class="page-title">Company Details</h1>
		                  </div>
		              </div>
		              <!-- PAGE-HEADER END -->
	              
                            
                            
                     
                 </div>
             </div>
             <!-- CONTAINER CLOSED -->
         </div>
    
    <jsp:include page="footer.jsp"></jsp:include>

</div>
</div>

<!-- BACK-TO-TOP -->
<a href="#top" id="back-to-top"><i class="fa fa-angle-up"></i></a>




<!-- CUSTOM JS -->
<script src="assets/js/custom.js"></script>

</body>
</html>