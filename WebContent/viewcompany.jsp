<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.temporal.ChronoUnit"%>
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
	<title>Company Details</title>

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

function post(path, parm, method, value) 
{
   method = method || "post"; // Set method to post by default if not specified.
   
   if(path == "DelCompany")
   {
	   	if(confirm("Do you want to Delete : "+value))
	   	{
	   	var form = document.createElement("form");
	   	   form.setAttribute("method", method);
	   	   form.setAttribute("action", path);
			
	   	
	   	       
	   	    var hiddenField = document.createElement("input");
	   	    hiddenField.setAttribute("type", "hidden");
	   	    hiddenField.setAttribute("name", parm);
	   	    hiddenField.setAttribute("value", value);
	
	   	    form.appendChild(hiddenField);
	   	 
	   	   document.body.appendChild(form);
	   	   form.submit();
	   	}
 
   }
   else
   {
	   
   // The rest of this code assumes you are not using a library.
   // It can be made less wordy if you use one.
   var form = document.createElement("form");
   form.setAttribute("method", method);
   form.setAttribute("action", path);

       
    var hiddenField = document.createElement("input");
    hiddenField.setAttribute("type", "hidden");
    hiddenField.setAttribute("name", parm);
    hiddenField.setAttribute("value", value);

    form.appendChild(hiddenField);

   document.body.appendChild(form);
   form.submit();
   }
}




</script>

<script type="text/javascript">
function displaydetail(x) {
    
	var expand = document.getElementById('expand'+x).value;
	
	if(expand == "true"){
		document.getElementById("tr"+x+"child").style.display = "table-row";
		document.getElementById("trI"+x+"child").style.display = "table-row";
		document.getElementById("trII"+x+"child").style.display = "table-row";
		//document.getElementById("trIII"+x+"child").style.display = "table-row";
		
		document.getElementById(x+"minus").style.display = "block";
		document.getElementById(x+"plus").style.display = "none";
		document.getElementById('expand'+x).value = "false";
	}else{
		document.getElementById("tr"+x+"child").style.display = "none";
		document.getElementById("trI"+x+"child").style.display = "none";
		document.getElementById("trII"+x+"child").style.display = "none";
		//document.getElementById("trIII"+x+"child").style.display = "none";
		
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
				document.getElementById("trI"+z+"child").style.display = "table-row";
				document.getElementById("trII"+z+"child").style.display = "table-row";
				//document.getElementById("trIII"+z+"child").style.display = "table-row";
				
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
				document.getElementById("trI"+z+"child").style.display = "none";
				document.getElementById("trII"+z+"child").style.display = "none";
				//document.getElementById("trIII"+z+"child").style.display = "none";
				
				document.getElementById(z+"minus").style.display = "none";
				document.getElementById(z+"plus").style.display = "block";
				document.getElementById('expand'+z).value = "true";
			}
		}
		
		document.getElementById('expandall').value = "true";
	}
    
}	

function updateStatus(id, newStatus) {
    $.ajax({
        url: 'UpdateStatus', // Servlet URL
        type: 'POST',
        data: {
            id: id,
            status: newStatus
        },
        success: function(response) {
            if (response.success) {
                var row = $('#row_' + id);
                row.find('td:eq(2)').text(newStatus); // Update the status column
                row.find('#std_status').val(newStatus); // Update the hidden input value

                // Update the button based on the new status
                var buttonHtml = newStatus === 'Active' ?
                    '<a onclick="updateStatus(' + id + ', \'Inactive\')" class="btn btn-danger-light" >Inactive</i></a>' :
                    '<a onclick="updateStatus(' + id + ', \'Active\')" class="btn btn-primary-light">Active</i></a>';
                
                row.find('td:eq(3)').html(buttonHtml); // Update the action column
            } else {
                alert('Failed to update status.');
            }
        },
        error: function() {
            alert('An error occurred while updating the status.');
        }
    });
}
function deactivateCompany(company_id,newStatus,rowId)
{
	 $.ajax({
	        url: 'UpdateStatus', // Servlet URL
	        type: 'POST',
	        data: {
	            id: company_id,
	            status: newStatus,
	            query: 'update company_registration set company_status=? where id=?'
	        },
	        success: function(response) {
	            if (response.success) {
	                var row = $('#'+rowId);
	                row.find('td:eq(8)').text(newStatus); // Update the status column
	                //row.find('#std_status').val(newStatus); // Update the hidden input value

	                // Update the button based on the new status
	                rowId="'"+rowId+"'";
	                var buttonHtml = newStatus === 'Active' ?
	                    '<a onclick="deactivateCompany(' + company_id + ', \'Inactive\','+rowId+')" class="btn btn-danger-light" >Deactive</a>' :
	                    '<a onclick="deactivateCompany(' + company_id + ', \'Active\','+rowId+')" class="btn btn-primary-light">Active</a>';
	                
	                row.find('td:eq(9)').html(buttonHtml); // Update the action column
	            } else {
	                alert('Failed to update status.');
	            }
	        },
	        error: function() {
	            alert('An error occurred while updating the status.');
	        }
	    });
}
</script>

<%
	Connection con;
	ResultSet res=null,res2;
	DatabaseConnection dbconn;
	
	dbconn = new DatabaseConnection();
	con = dbconn.setConnection();
	String login_type = (String) session.getAttribute("login_type");
	String employee_id = (String) session.getAttribute("emp_id");
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
	                  <div>
	                  <%if(login_type.equalsIgnoreCase("Niall Login")){ %>
						 <form action="" method="post">
							<input type="submit" value="Add New" class="btn btn-primary" onclick="form.action='CompanyRegistration.jsp';" />
						 </form>
						 <%} %>
	                  </div>
	              </div>
	              <!-- PAGE-HEADER END -->
    
                   <!-- ROW-1 OPEN -->
                  <div class="row">
					  <div class="col-md-12 col-lg-12">
						<div class="card">
							<div class="table-responsive">
									
								<%
									Iterator itr;
									List companydata = (List) request.getAttribute("companydata");
					
									if (companydata != null) {
								%>
										<table class="table card-table table-vcenter text-nowrap">
											<thead >
												<tr>
													<th>Company Code</th>
													<th>Company Name</th>
													<th>State</th>
													<th>GST No.</th>
												</tr>
											</thead>
											<tbody>
												<%
													int z, x;
													x = 0;
													
													for (itr = companydata.iterator(); itr.hasNext();) 
													{
														String company_id = (String) itr.next();
														String company_code = (String) itr.next();
														String company_name = (String) itr.next();
														String state = (String) itr.next();
														String gst_no = (String) itr.next();
														String company_status = (String) itr.next();
															
															 z = 0;
															 x++; 
												%>
												
												<tr id="tr<%=x%>">
													<td><span ><%=company_code%></span></td>
													<td><span ><%=company_name%></span></td>
													<td><span ><%=state%></span></td>
													<td><span ><%=gst_no%></span></td>
													<td>
														<a onclick="post('EditCompany','id','post',<%=company_id%>)"><i class="fa fa-pencil"></i></a>
														<a onclick="post('DelCompany','id', 'post',<%=company_id%>)"><i class="fa fa-trash-o"></i></a>
													</td>
												</tr>
												
										
												
												<%
													}
												%>
												
											</tbody>
										</table>
										
										<%
											}
										%>
									</div>
									<!-- table-responsive -->
								</div>
							</div>
						</div>
						<!-- ROW-1 CLOSED -->
                            
                            
                            
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