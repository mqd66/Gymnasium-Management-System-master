/**
 * 
 */

function validate() {
	var pw1 = document.getElementById("pwd1").value;
	var pw2 = document.getElementById("pwd2").value;
	if((!pw1)&&(!pw2)){
		document.getElementById("tishi").innerHTML="<span></span>";
		document.getElementById("submit").disabled = false;
	}
	else{
		if(pw1 == pw2) {
			document.getElementById("tishi").innerHTML="";
			document.getElementById("submit").disabled = false;
		}
		else{
			document.getElementById("tishi").innerHTML="<font color='red'>两次密码不相同</font>";
			document.getElementById("submit").disabled = true;
		}
	}
}
function validateAccount() {
	var account = document.getElementById("account").value;
	var accountRegex = /^202\d{8}$/; // 账号格式的正则表达式
	var isValid = accountRegex.test(account);
	if (isValid) {
		document.getElementById("account-tishi").innerHTML = "";
		document.getElementById("submit").disabled = false;
	} else {
		document.getElementById("account-tishi").innerHTML = "<font color='red'>账号格式不正确</font>";
		document.getElementById("submit").disabled = true;
	}
}
function validateName() {
	var name = document.getElementById("name").value;
	// 在这里进行姓名格式验证的逻辑判断
	// 如果姓名格式正确，清空错误消息并启用提交按钮
	// 如果姓名格式不正确，显示错误消息并禁用提交按钮
	// 示例代码：
	if (name.length > 0) {
		document.getElementById("name-tishi").innerHTML = "";
		document.getElementById("submit").disabled = false;
	} else {
		document.getElementById("name-tishi").innerHTML = "<font color='red'>姓名不能为空</font>";
		document.getElementById("submit").disabled = true;
	}
}

function validatePhoneNumber() {
	var phoneNumber = document.getElementById("phone").value;
	var phoneRegex = /^\d{11}$/; // 手机号格式的正则表达式
	var isValid = phoneRegex.test(phoneNumber);
	if (isValid) {
		document.getElementById("phone-tishi").innerHTML = "";
		document.getElementById("submit").disabled = false;
	} else {
		document.getElementById("phone-tishi").innerHTML = "<font color='red'>手机号格式不正确</font>";
		document.getElementById("submit").disabled = true;
	}
}

function resetpwd(){
	document.getElementById("tishi").innerHTML="<span></span>";
	document.getElementById("submit").disabled = false;
}