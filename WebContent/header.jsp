<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.DatabaseConnection" %>
<%@page import="java.sql.*"%>
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
		
	<script type="text/javascript">
	
	function exportStandard()
	{
		 var form = document.createElement("form");
		   form.setAttribute("method", "post");
		   form.setAttribute("action", "ExportStandards");


		   document.body.appendChild(form);
		   form.submit();
	}
	
	
	</script>

	</head>
	
	<%
		 
		 	Connection con;
	 		ResultSet res=null,res1;
	 		DatabaseConnection dbconn;


	 		dbconn = new DatabaseConnection();
	 		con = dbconn.setConnection();
		 
		 	String employee_name = (String) session.getAttribute("emp_name");
		 	String employee_id = (String) session.getAttribute("emp_id");
		 	String company_code = (String) session.getAttribute("company_code");
		 	String actual_company_code = (String) session.getAttribute("actual_company_code");
		 	String login_company_name = (String) session.getAttribute("login_company_name");
		 	String login_type = (String) session.getAttribute("login_type");
			
			if(employee_id == null || employee_id == ""){
		   		response.sendRedirect("/APITask/index.jsp");
		   		return;
		   	}
			
			
			String user_id="";
			
			 
		 	String query_get_user= "select user_id from "+company_code+"_user_master where username= '"+session.getAttribute("emp_name").toString()+"' ";		
			res = dbconn.getResult(query_get_user, con);
			if(res.next())
			{
				user_id = res.getString("user_id");
			}
			
			
			
			String company_id="",query_get_data="";
			
			
		 	
			
		 %>

     
    
            <!-- PAGE -->
    
                    <!-- APP-HEADER -->
                    <div class="app-header header sticky">
                        <div class="container-fluid main-container">
                            <div class="d-flex align-items-center">
                                <a aria-label="Hide Sidebar" class="app-sidebar__toggle" data-bs-toggle="sidebar" href="javascript:void(0)"></a>
                                <!-- sidebar-toggle-->
                                <a class="logo-horizontal " href="index.html">
                                    <img src="assets/images/brand/logo.png" class="header-brand-img desktop-logo" alt="logo">
                                    <img src="assets/images/brand/logo_bkp.png" class="header-brand-img light-logo1" alt="logo">
                                </a>
                                
                                
                               	<div style="padding-left: 150px;">
                                      <span class="login100-form-title"><%=login_company_name %> (<%=actual_company_code %>)</span>
                                </div>
                                <!-- LOGO -->
                               
                               
                                <div class="d-flex order-lg-2 ms-auto header-right-icons">
                                
                                    <div class="navbar navbar-collapse responsive-navbar p-0">
                                        <div class="collapse navbar-collapse" id="navbarSupportedContent-4">
                                            <div class="d-flex order-lg-2">
                                              
                                                <!-- SIDE-MENU -->
                                                
                                                <div class="dropdown d-flex profile-1">
                                                    <a href="javascript:void(0)" data-bs-toggle="dropdown" class="nav-link leading-none d-flex">
                                                        <img src="assets/images/brand/user.png" alt="profile-user" class="avatar  profile-user brround cover-image">
                                                    </a>
                                                    
                                                    <div class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                                                       <div class="drop-heading">
                                                           <div class="text-center">
                                                               <h5 class="text-dark mb-0 fs-14 fw-semibold"><%=employee_name %></h5>
                                                              <!--  <small class="text-muted">DESIGNATION</small> -->
                                                           </div>
                                                       </div>
                                                       <div class="dropdown-divider m-0"></div>
                                                        <a class="dropdown-item" href="changepassword.jsp?login_user=<%= employee_name%>">
                                                            <i class="dropdown-icon fe fe-alert-circle"></i> Change Password
                                                        </a>
                                                        <a class="dropdown-item" href="Logout">
                                                            <i class="dropdown-icon fe fe-alert-circle"></i> Sign out
                                                        </a>
                                                   	</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /APP-HEADER -->
    
                    <!-- ************************************ APP-SIDEBAR *********************************** -->
                    <div class="sticky">
                        <div class="app-sidebar__overlay" data-bs-toggle="sidebar"></div>
                        <div class="app-sidebar">
                            <div class="side-header">
                                <a class="header-brand1" href="index.html">
                                    <img src="assets/images/brand/logo.png" class="header-brand-img desktop-logo" alt="logo">
                                    <img src="assets/images/brand/logo-1.png" class="header-brand-img toggle-logo" alt="logo">
                                    <img src="assets/images/brand/logo-2.png" class="header-brand-img light-logo" alt="logo">
                                    <img src="assets/images/brand/logo-3.png" class="header-brand-img light-logo1" alt="logo">
                                </a>
                                <!-- LOGO -->
                            </div>
                            <div class="main-sidemenu">
                                <div class="slide-left disabled" id="slide-left">
                                	<svg xmlns="http://www.w3.org/2000/svg" fill="#7b8191" width="24" height="24" viewBox="0 0 24 24">
                                        <path d="M13.293 6.293 7.586 12l5.707 5.707 1.414-1.414L10.414 12l4.293-4.293z" />
                                    </svg>
                                 </div>
                                 
                                 
                                 <!-- ======================== All Module links Start  -->
                                 
                                 
                                <ul class="side-menu">
	                                
                                    <li>
                                    <%if(login_type.equalsIgnoreCase("Niall Login")){ 
                                    %>
                                        <a class="side-menu__item" href="Home2"><i class="side-menu__icon ti-home"></i><span class="side-menu__label">Dashboards</span></a>
                                    <%}%>
                                    </li>
                                    
                                    
                                    <%if(login_type.equalsIgnoreCase("Niall Login")){ 
                                    %>
                                    
                                    
                                    <li class="slide">
		                                <a class="side-menu__item" data-bs-toggle="slide" href="javascript:void(0)">
		                                    <span class="side-menu__label">Masters</span><i class="angle fe fe-chevron-right"></i>
		                                </a>
		                                <ul class="slide-menu">
											<li><a href="ViewCompany" class="slide-item">Company Registration</a></li>
											
		                                </ul>
		                            </li>
                                    
                                    
                                   <%}%>
                        
                   </ul>
			                     
                        
                                
                                <!-- ======================== All Module links End  -->
                                
                                <div class="slide-right" id="slide-right">
                                	<svg xmlns="http://www.w3.org/2000/svg" fill="#7b8191" width="24" height="24" viewBox="0 0 24 24">
                                        <path d="M10.707 17.707 16.414 12l-5.707-5.707-1.414 1.414L13.586 12l-4.293 4.293z" />
                                    </svg>
                                </div>
                            </div>
                        </div>
                        <!--/APP-SIDEBAR-->
                    </div>
                    <!--/APP-SIDEBAR-->
    


<!-- BACK-TO-TOP -->
<a href="#top" id="back-to-top"><i class="fa fa-angle-up"></i></a>

<!-- JQUERY JS -->
<script src="assets/js/jquery.min.js"></script>

<!-- BOOTSTRAP JS -->
<script src="assets/plugins/bootstrap/js/popper.min.js"></script>
<script src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>

<!-- CHARTJS CHART JS -->
<script src="assets/plugins/chart/Chart.bundle.js"></script>
<script src="assets/plugins/chart/utils.js"></script>

<!-- SIDEMENU JS -->
<script src="assets/plugins/sidemenu/sidemenu.js"></script>

<!-- STICKY js -->
<script src="assets/js/sticky.js"></script>

<!-- SIDEBAR JS -->
<script src="assets/plugins/sidebar/sidebar.js"></script>

<!-- Perfect SCROLLBAR JS-->
<script src="assets/plugins/p-scroll/perfect-scrollbar.js"></script>
<script src="assets/plugins/p-scroll/pscroll.js"></script>
<script src="assets/plugins/p-scroll/pscroll-1.js"></script>

<!--MORRIS JS-->
<script src="assets/plugins/morris/morris.js"></script>
<script src="assets/plugins/morris/raphael-min.js"></script>

<!-- CHARTS JS -->
<script src="assets/js/index2.js"></script>

<!-- THEME COLOR JS -->
<script src="assets/js/themeColors.js"></script>

<!-- CUSTOM JS -->
<script src="assets/js/custom.js"></script>
      
<script src="assets/switcher/js/switcher.js"></script>

</html>