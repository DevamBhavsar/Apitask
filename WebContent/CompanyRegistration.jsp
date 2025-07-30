<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
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
	<title>Add Company</title>

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
	
	<script src="assets/jQuery/jquery.min.js"></script>
	
<script type="text/javascript">


function getCity(str) 
{
    
    if (typeof XMLHttpRequest != "undefined")
    {
    	xmlHttp= new XMLHttpRequest();
    }
    else if (window.ActiveXObject)
    {
    	xmlHttp= new ActiveXObject("Microsoft.XMLHTTP");
    }
    if (xmlHttp==null)
    {
    	alert("Browser does not support XMLHTTP Request")
    	return;
    } 
    
    var url="getcityname.jsp?state="+ str;
    xmlHttp.onreadystatechange = setCity;
    xmlHttp.open("GET", url, true);
    xmlHttp.send(null);
}

function setCity()
{   
    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    {   
    	document.getElementById("city").innerHTML=xmlHttp.responseText   
    }   
}

function getCity2(str) 
{
    
    if (typeof XMLHttpRequest != "undefined")
    {
    	xmlHttp= new XMLHttpRequest();
    }
    else if (window.ActiveXObject)
    {
    	xmlHttp= new ActiveXObject("Microsoft.XMLHTTP");
    }
    if (xmlHttp==null)
    {
    	alert("Browser does not support XMLHTTP Request")
    	return;
    } 
    
    var url="getcityname.jsp?state="+ str;
    xmlHttp.onreadystatechange = setCity2;
    xmlHttp.open("GET", url, true);
    xmlHttp.send(null);
}

function setCity2()
{   
    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    {   
    	document.getElementById("city2").innerHTML=xmlHttp.responseText   
    }   
}

$(document).ready(function(){
	$("#update").hide();
});

//===================

function add_item() 
{
	var count;
	count = document.getElementById("count").value;
	
	
	var std_name = document.getElementById("std_name").value;

	var table = document.getElementById('dataTableExample2');

	var rowCount = table.rows.length;
	var row = table.insertRow(rowCount);
	row.id=count;
	

	var cell1 = row.insertCell(0);
	var item_id_table = document.createElement("input");
	item_id_table.type = "text";
	item_id_table.name = "tbl_std_name";
	item_id_table.id = "tbl_std_name-"+count;
	item_id_table.value = std_name;
	item_id_table.style = "width: 250px;border: #fdfdfd;background: #fdfdfd;";
	cell1.appendChild(item_id_table);
	
	var cell2 = row.insertCell(1);
	cell2.innerHTML = "<a  id='deleteRow' ><i class=\"fa fa-trash-o\" style='color:blue'></i></a>";
	cell2.innerHTML += "&nbsp;&nbsp;";
	cell2.innerHTML += "<a id='editrow'><i class=\"fa fa-pencil\" style='color:blue'></i></a>";
	
		
	count++;
	document.getElementById('count').value = count;
	document.getElementById('std_name').value = ""; 

}


//================================ UPDATE ITEM FROM THE LIST ====================================

$(document).ready(function() {


	$('#dataTableExample2').on('click','a[id="editrow"]',function(e) {
		var rowNumber = $(this).closest('tr').attr("id");
		
		var std_name = $("#tbl_std_name-"+rowNumber).val();
		
		document.getElementById('std_name').value = std_name;
		
		$("#tbl_std_name-"+rowNumber).val("");
		
		document.getElementById('editRowNumber').value = rowNumber;
		
		$("#add").hide();
		$("#update").show();
		
	});

	$('#dataTableExample2').on('click','a[id="deleteRow"]',function(e) {

		var rowNumber = $(this).closest('tr').attr("id");
		
		$(this).closest('tr').remove();
		
		var count = document.getElementById("count").value;
		count--;
		
		document.getElementById('count').value = count;

	});
	
});


//======================= update item  =====================================================
function update_itm()
{
	var rowNumber;
	rowNumber = document.getElementById("editRowNumber").value;
	
	var std_name = document.getElementById("std_name").value;
	
	$("#tbl_std_name-"+rowNumber).val(std_name);
	
	
	document.getElementById('std_name').value = ""; 
		
	$("#add").show();
	$("#update").hide();
}

</script>

</head>



<%
	Connection con;
	ResultSet res;
	DatabaseConnection dbconn;

	dbconn = new DatabaseConnection();
	con = dbconn.setConnection();
	
	
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
    
  <form action="CompanyRegistration" class="search nav-form" method="post">
  
     <!--app-content open-->
         <div class="app-content main-content">
             <div class="side-app">

                 <div class="main-container">

                 <!-- PAGE-HEADER -->
                 <div class="page-header">
                     <div>
                         <h1 class="page-title">Company Registration</h1>
                     </div>
                 </div>
       <!-- PAGE-HEADER END -->
    
                 <!-- ROW-1 OPEN -->
                 <div class="row">
                     <div class="col-lg-12 col-md-12 col-xl-12">
                         <div class="card">
                             <div class="card-header">
                                 <h3 class="card-title">Basic Details</h3>
                             </div>
                             
                             <div class="card-body">
                             
                                 <div class="row">
                                 	<div class="col-sm-4 col-md-4">
                                         <div class="form-group">
                                             <label class="form-label">Company Code <span class="text-red">*</span></label>
                                             <input type="text" class="form-control" id="company_code" name="company_code" required>
                                         </div>
                                     </div>
                                     <div class="col-sm-4 col-md-4">
                                         <div class="form-group">
                                             <label class="form-label">Company Name <span class="text-red">*</span></label>
                                             <input type="text" class="form-control" id="company_name" name="company_name" required>
                                         </div>
                                     </div>
                                     <div class="col-sm-4 col-md-4">
                                         <div class="form-group">
                                             <label class="form-label">Contact Person name</label>
                                             <input type="text" class="form-control" id="person_name" name="person_name"/>
                                         </div>
                                     </div>
                                 </div>
                                 
                                 
                                 <div class="row">    
                                     <div class="col-sm-4 col-md-4">
                                         <div class="form-group">
                                             <label class="form-label">Fax no.</label>
                                             <input type="text" class="form-control" id="fax_no" name="fax_no"/>
                                         </div>
                                     </div>
                                     <div class="col-sm-4 col-md-4">
                                         <div class="form-group">
                                             <label class="form-label">E-mail</label>
                                             <input type="text" class="form-control" id="email" name="email"/>
                                         </div>
                                     </div>
                                     <div class="col-sm-4 col-md-4">
                                         <div class="form-group">
                                             <label class="form-label">Web site</label>
                                             <input type="text" class="form-control" id="website" name="website"/>
                                         </div>
                                     </div>
                                 </div>
                                 
                                  <div class="row">
                                     <div class="col-sm-4 col-md-4">
                                         <div class="form-group">
                                             <label class="form-label">GST NO.</label>
                                             <input type="text" class="form-control" id="gst_no" name="gst_no"/>
                                         </div>
                                     </div>
                                     <div class="col-sm-4 col-md-4">
                                         <div class="form-group">
                                             <label class="form-label">PAN NO.</label>
                                             <input type="text" class="form-control" id="pan_no" name="pan_no"/>
                                         </div>
                                     </div>
                                     
                                     <div class="col-sm-4 col-md-4">
                                         <div class="form-group">
                                             <label class="form-label">Configuration Type?</label>
                                             <select class="form-control form-select select2" name="config_type" id="config_type">
                                                  <option value="Standard">Standard</option>
                                                  <option value="Customized">Customized</option>
												  
                                             </select>
                                         </div>
                                     </div>
                                     
                                     <div class="col-sm-4 col-md-4">
                                         <div class="form-group">
                                             <label class="form-label">Risk Type?</label>
                                             <select class="form-control form-select select2" name="risk_type" id="risk_type">
                                                  <option value="Asset">Asset</option>
                                                  <option value="Process">Process</option>
												  
                                             </select>
                                         </div>
                                     </div>
                                  </div>
                                 
                                 
                                 
                             </div>
                         </div>
                     </div>

                 </div>
                 
                 <!-- ROW-1 CLOSE -->
                 
                  <!-- ROW-1 OPEN -->
                 <div class="row">
                     <div class="col-lg-12 col-md-12 col-xl-12">
                         <div class="card">
                             <div class="card-header">
                                 <h3 class="card-title">Address Detail - 1</h3>
                             </div>
                             
                             <div class="card-body">
                             
                                 <div class="row">
                                 	<div class="col-sm-4 col-md-4">
                                         <div class="form-group">
                                             <label class="form-label">Country</label>
                                             <input type="text" class="form-control" id="country" name="country">
                                         </div>
                                     </div>
                                    <div class="col-sm-4 col-md-4">
                                         <div class="form-group">
                                             <label class="form-label">State</label>
                                             <select class="form-control form-select select2" name="state" id="state" onchange="getCity(this.value)">
                                                  <option value="---SELECT---">---SELECT---</option>
												  <%
													String query_get_state = "select distinct state from city_state where id>0";
													res = dbconn.getResult(query_get_state, con);
													while (res.next()) {
												%>
												<option value="<%=res.getString("state")%>"><%=res.getString("state")%></option>
												<%
													}
												%>
                                             </select>
                                         </div>
                                     </div>
                                     <div class="col-sm-4 col-md-4">
                                         <div class="form-group">
                                             <label class="form-label">City</label>
                                             <select class="form-control form-select select2" name="city" id="city" >
                                             </select>
                                         </div>
                                     </div>
                                 </div>
                                 
                                 <div class="row">
                                     <div class="col-sm-4 col-md-4">
                                         <div class="form-group">
                                             <label class="form-label">Village</label>
                                             <input type="text" class="form-control" id="village" name="village"/>
                                         </div>
                                     </div>
                                     <div class="col-sm-4 col-md-4">
                                         <div class="form-group">
                                             <label class="form-label">Street 1</label>
                                             <input type="text" class="form-control" id="street1" name="street1"/>
                                         </div>
                                     </div>
                                      <div class="col-sm-4 col-md-4">
                                         <div class="form-group">
                                             <label class="form-label">Street 2</label>
                                             <input type="text" class="form-control" id="street2" name="street2"/>
                                         </div>
                                     </div>
                                  </div>
                                 
                                 <div class="row">    
                                  	<div class="col-sm-4 col-md-4">
                                         <div class="form-group">
                                             <label class="form-label">Pin code</label>
                                             <input type="text" class="form-control" id="pincode" name="pincode"/>
                                         </div>
                                     </div>
                                     <div class="col-sm-4 col-md-4">
                                         <div class="form-group">
                                             <label class="form-label">Phone no.</label>
                                             <input type="text" class="form-control" id="phone_no" name="phone_no"/>
                                         </div>
                                     </div>
                                     <div class="col-sm-4 col-md-4">
                                         <div class="form-group">
                                             <label class="form-label">Mobile no.</label>
                                             <input type="text" class="form-control" id="mobile_no" name="mobile_no"/>
                                         </div>
                                     </div>
                                 </div>
                                 
                             </div>
                         </div>
                     </div>

                 </div>
                 
                 <!-- ROW-1 CLOSE -->
                 
                 
                  <!-- ROW-1 OPEN -->
                 <div class="row">
                     <div class="col-lg-12 col-md-12 col-xl-12">
                         <div class="card">
                             <div class="card-header">
                                 <h3 class="card-title">Address Detail - 2</h3>
                             </div>
                             
                             <div class="card-body">
                             
                                 <div class="row">
                                 	<div class="col-sm-4 col-md-4">
                                         <div class="form-group">
                                             <label class="form-label">Country</label>
                                             <input type="text" class="form-control" id="country2" name="country2">
                                         </div>
                                     </div>
                                    <div class="col-sm-4 col-md-4">
                                         <div class="form-group">
                                             <label class="form-label">State</label>
                                             <select class="form-control form-select select2" name="state2" id="state2" onchange="getCity2(this.value)">
                                                  <option value="---SELECT---">---SELECT---</option>
												  <%
													String query_get_state2 = "select distinct state from city_state where id>0";
													res = dbconn.getResult(query_get_state2, con);
													while (res.next()) {
												%>
												<option value="<%=res.getString("state")%>"><%=res.getString("state")%></option>
												<%
													}
												%>
                                             </select>
                                         </div>
                                     </div>
                                     <div class="col-sm-4 col-md-4">
                                         <div class="form-group">
                                             <label class="form-label">City</label>
                                             <select class="form-control form-select select2" name="city2" id="city2" >
                                             </select>
                                         </div>
                                     </div>
                                 </div>
                                 
                                 <div class="row">
                                     <div class="col-sm-4 col-md-4">
                                         <div class="form-group">
                                             <label class="form-label">Village</label>
                                             <input type="text" class="form-control" id="village2" name="village2"/>
                                         </div>
                                     </div>
                                     <div class="col-sm-4 col-md-4">
                                         <div class="form-group">
                                             <label class="form-label">Street 1</label>
                                             <input type="text" class="form-control" id="street12" name="street12"/>
                                         </div>
                                     </div>
                                      <div class="col-sm-4 col-md-4">
                                         <div class="form-group">
                                             <label class="form-label">Street 2</label>
                                             <input type="text" class="form-control" id="street22" name="street22"/>
                                         </div>
                                     </div>
                                  </div>
                                 
                                 <div class="row">    
                                  	<div class="col-sm-4 col-md-4">
                                         <div class="form-group">
                                             <label class="form-label">Pin code</label>
                                             <input type="text" class="form-control" id="pincode2" name="pincode2"/>
                                         </div>
                                     </div>
                                     <div class="col-sm-4 col-md-4">
                                         <div class="form-group">
                                             <label class="form-label">Phone no.</label>
                                             <input type="text" class="form-control" id="phone_no2" name="phone_no2"/>
                                         </div>
                                     </div>
                                     <div class="col-sm-4 col-md-4">
                                         <div class="form-group">
                                             <label class="form-label">Mobile no.</label>
                                             <input type="text" class="form-control" id="mobile_no2" name="mobile_no2"/>
                                         </div>
                                     </div>
                                 </div>
                                 
                             </div>
                         </div>
                     </div>

                 </div>
                 
                 <!-- ROW-1 CLOSE -->
                 
             <!-- ==================================================================================================================== -->
				<br>
				
				<div class="row">
                     <div class="col-lg-12 col-md-12 col-xl-12">
                         <div class="card">
                             
                             <div class="card-body">
			                           
								<div class="panel panel-primary">
									<div class="tab-menu-heading">
										<div class="tabs-menu1 ">
											<!-- Tabs -->
											<ul class="nav panel-tabs">
												<li ><a href="#empinfo" class="active" data-bs-toggle="tab">Standard Details</a></li>
											</ul>
										</div>
									</div>
									<div class="panel-body tabs-menu-body">
										<div class="tab-content">
										
										<input type="hidden" id="editRowNumber"/>
									    <input type="hidden" id="count" value="1" name="count" />   
										
											<div class="tab-pane active " id="empinfo">
												<div class="row">
													<div class="col-sm-3 col-md-3">
				                                      <div class="form-group">
				                                          <label class="form-label">Standard Name</label>
				                                          <select class="form-control form-select select2" name="std_name" id="std_name">
				                                          	<option value="">---SELECT---</option>
															 <% 
															 String query_get_ledger = "select std_name from standard_master where id > 0";
															 res = dbconn.getResult(query_get_ledger, con);
															 while(res.next()){ %>
										  						<option value="<%= res.getString("std_name")%>"><%= res.getString("std_name")%></option>
															 <% } %>
				                                          </select>
				                                      </div>
				                                  </div>
							                    </div>
							                               
				                               <div class="row">
				                                <div class="col-sm-4 col-md-4">
				                                </div>
				                                
				                                <div class="col-sm-4 col-md-4">
				                                	<input class="btn btn-primary" type="button" id="add" value="Add Item" onclick="add_item()" />
													<input class="btn btn-primary" type="button"  id="update" value="Update Item" onclick="update_itm()"/>
				                                </div>
				                               </div>
				                               
				                               <br>
							                               
				                                <div class="row">
				                                 	<div class="table-responsive">
				                                 		<table class="table card-table table-vcenter text-nowrap" id="dataTableExample2">
															<thead>
																<tr>
																	<th>Standard Name</th>
																	<th>Rights</th>
																</tr>
															</thead>
														</table>
				                                 	</div>
				                                </div>
							                                
											</div>       
				                           
				                     	 </div>
				                     </div>
				                   </div>
			            		</div>
			            	</div>
			           </div>
			        </div>
                 
                 
                 
                 <div class="form-group" style="padding-top: 20px;padding-left: 600px;">
                 <div class="col-md-offset-5 col-md-2">
						<input class="btn btn-primary" type="submit" value="Save" />
					</div>
				</div>
				
             </div>
         </div>
         <!-- CONTAINER CLOSED -->
     </div>
     
     </form>
    
    <jsp:include page="footer.jsp"></jsp:include>

</div>
</div>

<!-- BACK-TO-TOP -->
<a href="#top" id="back-to-top"><i class="fa fa-angle-up"></i></a>


<!-- INTERNAL SUMMERNOTE EDITOR JS -->
<script src="assets/plugins/summernote/summernote1.js"></script>
<script src="assets/js/summernote.js"></script>
<script src="assets/js/summernote1.js"></script>
<script src="assets/js/summernote2.js"></script>

<!-- CUSTOM JS -->
<script src="assets/js/custom.js"></script>

</body>
</html>