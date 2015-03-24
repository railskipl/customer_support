$(function() {
		$("#user_country").change(function(){
			if ($("#user_country").val() == 'Kenya')
				$("#user_i_live").prop('disabled', false);
			else{
				$("#user_i_live").prop('disabled', 'true');
				$("#user_i_live").val('Select');
			}
		});

		$("#user_first_name").bind( "change", function() {convertfname("user_first_name");});
		
		$("#user_last_name").bind( "change", function() {convertfname("user_last_name");});
		
		$("#password1").bind( "change", function() {validatePassword();});

		$("#password2").bind( "change", function() {validatePassword();});

		$("#user_email").bind( "change", function() {validateEmail();});
		$("#email_confirmation").bind( "change", function() {validateEmail();});
		$("#save").bind( "click", function() {calculateAge();});
		$("#user_alias").bind( "blur", function() {
			checkAvailiblity();
		});

		$("#field_terms").bind( "click",function(){
			if ($('#field_terms').is(":checked"))
		    document.getElementById("field_terms").setCustomValidity('');
			else
		    document.getElementById("field_terms").setCustomValidity('Please accept the terms and conditions to continue.');
		});
});

function checkAvailiblity(){
		$.ajax({
		type: "GET",
		url: "/check_availiblity/user/preferred_alias",
		data: { name: $("#user_alias").val() }
		})
		.done(function( msg ) {
			if (msg=='false'){
				$("#alias_name_error").html("");
				document.getElementById("user_alias").setCustomValidity("");
			}else{
				$("#alias_name_error").html("Alias name already in use.");
				document.getElementById("user_alias").setCustomValidity("Alias name already in use.");
			}

		});
}

function readImage(input) {
    if ( input.files && input.files[0] ) {
        var FR= new FileReader();
        FR.onload = function(e) {
           $('#avatar_image').css({'background' : 'url(' + e.target.result + ') no-repeat',
           	'background-size': '120px 150px'
       });
        };
        FR.readAsDataURL( input.files[0] );
    }
}

function validatePassword(){
	var pass2 = $("#password2").val();
	var pass1 = $("#password1").val();
	if(pass1 != pass2)
    document.getElementById("password2").setCustomValidity("Passwords Don't Match");
	else
    document.getElementById("password2").setCustomValidity('');
}

function validateEmail(){
	var confirm_email = $("#email_confirmation").val();
	var user_email = $("#user_email").val();
	if(confirm_email != user_email)
   	document.getElementById("email_confirmation").setCustomValidity("Emails Don't Match");
	else
    document.getElementById("email_confirmation").setCustomValidity('');
}

function calculateAge(){
  var user_birth_year = $(".dob select").last().val();
  var currentYear = (new Date).getFullYear();
  var age  = currentYear - user_birth_year;
  var data = document.getElementById("user_age").options[document.getElementById("user_age").selectedIndex].value;
   if (user_birth_year){
   	  check_range(age,data)

	//   if (data == "18-25"){
	//   	if (age < 18 || age > 25)
	//   		alert("Age range and date of birth does not match")
	//   }
	//   else if (data == "26-35") {
	// 	if (age < 26 || age > 35)
	//   		alert("Age range and date of birth does not match")
	//   }
	//   else if (data == "36-45") {
	// 	if (age < 36 || age > 45)
	//   		alert("Age range and date of birth does not match")
	//   }
	//   else if (data == "46-55") {
	// 	if (age < 46 || age > 55)
	//   		alert("Age range and date of birth does not match")
	//   }
	//   else if (data == "55+") {
	// 	if (age < 55)
	//   		alert("Age range and date of birth does not match")
	//   }
	 }
}


function check_range(age,data){
	var a = (data.split('-'));
	  if (age < a[0] || age > a[1])
	  	alert("Age range and date of birth does not match")
	  else if (data == "55+") {
	  	if (age < 55)
	   		alert("Age range and date of birth does not match")
	  	}


}

function convertfname(id){
   var str = document.getElementById(id).value;
   var res = str.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
   var id = "#" + id
   $(id).val (res);
}

