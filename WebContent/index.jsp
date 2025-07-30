<%@ page isELIgnored="false" %>
<!doctype html>
<html lang="en" dir="ltr">
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
		<title>APITest</title>

		<!-- BOOTSTRAP CSS -->
		<link id="style" href="assets/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" />

		<!-- STYLE CSS -->
		<link href="assets/css/style.css" rel="stylesheet"/>

		<!--- FONT-ICONS CSS -->
		<link href="assets/css/icons.css" rel="stylesheet"/>
		


</head>

	<body>

		<!-- BACKGROUND-IMAGE -->
		<div >

			<!-- GLOABAL LOADER -->
			<div id="global-loader">
				<img src="assets/images/loader.svg" class="loader-img" alt="Loader">
			</div>
			<!-- /GLOABAL LOADER -->

			<!-- PAGE -->
			<div class="page">
				<div class="">
				    <!-- CONTAINER OPEN -->
					<div class="col col-login mx-auto">
						<div class="text-center">
							<img src="assets/images/brand/logo.png" class="header-brand-img" alt="">
						</div>
					</div>
					<div class="container-login100">
						<div class="wrap-login100 p-6">
							<form action="${pageContext.request.contextPath}/ValidateLogin" method="post">
							
								<%	
								String error = (String)request.getAttribute("error");								
								if((error != null || error != "") && error == "1"){	
								%>
								<label>No such User name or Password exists</label>
								<%
								}
								%>
								
						 		<%
									String	employee_id = (String)session.getAttribute("emp_id");
									String	employee_name = (String)session.getAttribute("emp_name");
									String	company_code = (String)session.getAttribute("company_code");
								    
									
									if(company_code!=null)
									{
									
										if(company_code.equalsIgnoreCase("niall"))
										{
										
									    	if(employee_id != null && employee_id != ""){
									    		response.sendRedirect("/APITask/Home2");
									    		return;
									    	}
									    	else
									    	{
									    		session.invalidate();
									    	}
									    }
								    	
									}
									else
							    	{
							    		session.invalidate();
							    	}
								%> 
							
							
								<span class="login100-form-title">
									Login
								</span>
								<div class="wrap-input100 validate-input">
									<select class="input100" name="login_type" id="login_type" onchange="DisplayType(this.value)">
										<option value="Niall login">Niall Login</option>
									</select>
									<span class="focus-input100"></span>
									<span class="symbol-input100">
										<i class="zmdi zmdi-account" aria-hidden="true"></i>
									</span>
								</div>
								
								
								
								<div class="wrap-input100 validate-input">
									<input class="input100" type="text" name="company_code" placeholder="COMPANY CODE">
									<span class="focus-input100"></span>
									<span class="symbol-input100">
										<i class="zmdi zmdi-account" aria-hidden="true"></i>
									</span>
								</div>
								
								
								<div class="wrap-input100 validate-input">
									<input class="input100" type="text" name="username" placeholder="USER NAME">
									<span class="focus-input100"></span>
									<span class="symbol-input100">
										<i class="zmdi zmdi-account" aria-hidden="true"></i>
									</span>
								</div>
								
								<div class="wrap-input100 validate-input" data-validate = "Password is required">
									<input class="input100" type="password" name="password" placeholder="Password">
									<span class="focus-input100"></span>
									<span class="symbol-input100">
										<i class="zmdi zmdi-lock" aria-hidden="true"></i>
									</span>
								</div>
								<div class="container-login100-form-btn">
									<input type="submit" Value="Login" class="btn btn-pill btn-success">
								</div>
								
							</form>
						</div>
					</div>
					<!-- CONTAINER CLOSED -->
				</div>
			</div>
			<!-- End PAGE -->

		</div>
		<!-- BACKGROUND-IMAGE CLOSED -->

		<!-- JQUERY JS -->
		<script src="assets/js/jquery.min.js"></script>

		<!-- BOOTSTRAP JS -->
		<script src="assets/plugins/bootstrap/js/popper.min.js"></script>
		<script src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>

		<!-- THEME COLOR JS -->
		<script src="assets/js/themeColors.js"></script>

		<!-- CUSTOM JS -->
		<script src="assets/js/custom.js"></script>

	</body>
</html>
