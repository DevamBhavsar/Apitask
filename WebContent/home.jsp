<%@page import="java.util.ArrayList"%>
<%@page import="com.itextpdf.text.log.SysoLogger"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="com.DatabaseConnection"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.text.DecimalFormat" %>
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
		<title>APITask</title>

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


<style>
      
        #chart {
      max-width: 650px;
      margin: 35px auto;
    }
      
</style>

	
</head>



<%
	Connection con;
	ResultSet res,res1,res2,res3,res4,res5;
	DatabaseConnection dbconn;
	
	dbconn = new DatabaseConnection();
	con = dbconn.setConnection();
	
	
	String company_code = (String)session.getAttribute("company_code");
	
	String company_id="";
	
	String query_get_data = "select id from company_registration where company_code = '"+company_code+"'";
	res = dbconn.getResult(query_get_data, con);
	if(res.next())
	{
		company_id=res.getString("id");
	}
	 
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
                                    <h1 class="page-title">Home Page</h1>
                                    <!-- <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="#">Forms</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Form Layouts</li>
                                    </ol> -->
                                </div>
                            </div>
                            <!-- PAGE-HEADER END -->
			                
			               </div> 
			                
                        </div>
                    </div>
                    <!-- CONTAINER CLOSED -->
                </div>
    
    <jsp:include page="footer.jsp"></jsp:include>

</div>

<!-- BACK-TO-TOP -->
<a href="#top" id="back-to-top"><i class="fa fa-angle-up"></i></a>



<!-- CUSTOM JS -->
<script src="assets/js/custom.js"></script>

</body>
</html>