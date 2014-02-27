<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="lab1_web.aspx.cs" Inherits="lab1_web.lab1_web" %>

<!DOCTYPE html>

<html>
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <h1>Добро пожаловать !</h1>
    <p>Пожалуйста, заполните все поля.</p>
<style>
article div { 
   margin: 10px 0;
}
        
label 
{
   float: left;
   display: block;
   width: 125px;
   font-weight:bold;
}

#errorbox {
	background-color: yellow;
	display: none;
}
</style>
<article>
    <section>
       <div>
         <label for="fname">Имя </label> 
         <input type="text" name="fname" id="fname" required  placeholder="Имя"> 
       </div>
       <div>
         <label for="lname">Фамилия </label>
         <input type="text" name="lname" id="lname" required placeholder="Фамилия">
       </div>
       <div>
         <label for="email">Email </label>
         <input type="email" name="email" id="email" required placeholder="your@email.com">
       </div>
       <div>
         <label for="website">Website </label>
         <input type="url" name="website" id="website" required placeholder="http://yoursite.com">
       </div>
     </section>
       <input required type="button" name="button" id="button" value="GO!">
 </article>
<h2>В хранилище </h2>
<div id='Storage'> </div>
<script>

var my_div = null;
var newDiv = null;

/*Проверка ввода email*/
function validateEmail(value) {
  var atpos = value.indexOf("@");
  var dotpos = value.lastIndexOf(".");
  if (atpos < 1 || (dotpos - atpos < 2)) return false; 
  return true; 
}

/*Проверка ввода URL*/
function validateURL(value) {
    var reurl = /^(http[s]?:\/\/){0,1}(www\.){0,1}[a-zA-Z0-9\.\-]+\.[a-zA-Z]{2,5}[\.]{0,1}/;
    return reurl.test(value);
}

function addDiv(message) {
    if (newDiv == null) newDiv = document.createElement("div");
    newDiv.innerHTML = message;

    my_div = document.getElementById("Storage");
    document.body.insertBefore(newDiv, my_div);
}

function showStorage() {
    var in_storage = "";

    /*Проверка, что все поля заполнены верно*/
    var error = "";
    for (var i = 0; i < sessionStorage.length; i++) {
        if (!sessionStorage.getItem(sessionStorage.key(i))) {  
            error += "Field " + sessionStorage.key(i) + " not filled properly\n";
        }
    }

    if (error) {
        alert(error);

        /*Добавление ошибки*/
        addDiv("Некорректный ввод данных !\n");

        return;
    }

    /*Cобираем информацию о том, что хранится в хранилище*/
     for (var i = 0; i < sessionStorage.length; i++) {
          in_storage += sessionStorage.key(i) + " : " + sessionStorage.getItem(sessionStorage.key(i)) + "\n";
        }

    /*Выводим то, что хранится в хранилище*/
    addDiv(in_storage)
}

function onStart() {
    sessionStorage.setItem("fname", "");
    sessionStorage.setItem("lname", "");
    sessionStorage.setItem("email", "");
    sessionStorage.setItem("website", "");
    addDiv("Пока пусто ...");
}

addEventListener("change", onStart(), false);

var fname_event = document.getElementById("fname");

/*Ввод имени*/
fname_event.addEventListener("deactivate",     // "change"
function () {
    if (this.value == "") alert("Не введено имя !\n"); 
    sessionStorage.setItem("fname", this.value);
}
, false);

var lname_event = document.getElementById("lname");

/*Ввод фамилии*/
lname_event.addEventListener("deactivate",
function () {
    if (this.value == "") alert("Не введена фамилия !\n");
    sessionStorage.setItem("lname", this.value);
}
, false);

var email_event = document.getElementById("email");

/*Ввод email*/
email_event.addEventListener("deactivate",
function () {
    if (!validateEmail(this.value)) {
        alert("Не верно введен email !\n");
        sessionStorage.setItem("email", "");
        return;
    }
    sessionStorage.setItem("email", this.value);
}
, false);

var url_event = document.getElementById("website");

/*Ввод url*/
url_event.addEventListener("deactivate",
function () {
    // if (this.value == "") alert("Не введен url !\n");
    if (!validateURL(this.value)) {
        alert("Не верно введен url ! \n");
        sessionStorage.setItem("website", "");
        return;
    }
    sessionStorage.setItem("website", this.value);
}
, false);

var button_event = document.getElementById("button");
button_event.addEventListener("click", showStorage, false);

</script>
</body>
</html>
