<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>LogFinder</title> 
 
<style>
.header {
	height: 40px;
	padding: 20px 20px 0;
	background: #e1e1e1;
}

.main-content {
	height: 100vh;
	padding: 20px;
}

footer {
	padding: 10px 20px;
	background: #666;
	color: white;
}

a {
	color: #00aaff;
}
</style>
</head>
<body>

<div class="header"><b>Log Formatter</b></div>
<div class="main-content">


<form action="show.jsp" method="post">
<table>

	<tr>
		<td><input type="radio" name="chkSelect" value="window" checked="checked">Load logs from window </td>
		<td></td>
	</tr>
		<tr>
			<td>
				<textarea name="txtInput" rows="20" cols="60" id="txtInput"></textarea>
			</td>

			<td><!-- Fill your keys --> <br>
				<b>&nbsp;&nbsp;Include Keys</b><br>
			<br>
		<table>
			<tr height="40px">
				<td><input type="checkbox" name="chkKey" value="Component_name">Component_name</td>
				<td><input type="checkbox" name="chkKey" value="Consumer-Name">Consumer-Name</td>
				<td><input type="checkbox" name="chkKey" value="Instance_id">Instance_id</td>
			</tr>
			<tr height="40px">
				<td><input type="checkbox" name="chkKey"
					value="bootstrap-server">bootstrap-server</td>
				<td><input type="checkbox" name="chkKey" value="file">file</td>
				<td><input type="checkbox" name="chkKey" value="func">func</td>
			</tr>
			<tr height="40px">
				<td><input type="checkbox" name="chkKey" value="level">level</td>
				<td><input type="checkbox" name="chkKey" value="msg">msg</td>
				<td><input type="checkbox" name="chkKey" value="time">time</td>
			</tr>
			<tr height="40px">
				<td><input type="checkbox" name="chkKey" value="topics">topics</td>
				<td><input type="checkbox" name="chkKey" value="value">value</td>
				<td><input type="checkbox" name="chkKey" value="user_msg">user_msg</td>
			</tr>
			<tr height="40px">
				<td><input type="checkbox" name="chkKey" value="Hdrs">Hdrs</td>
				<td><input type="checkbox" name="chkKey" value="host">host</td>
				<td><input type="checkbox" name="chkKey" value="Producer-Name">Producer-Name</td>
			</tr>

			<!-- Include in search -->
			<tr height="40px">
				<td><b>Starts with:</b></td>
				<td><input type="text" name="txtInclude"><br>
				</td>
				<td></td>
			</tr>
			<tr height="40px">
				<td><b>Only with pattern:</b></td>
				<td><input type="text" name="txtPattern"><br>
				</td>
				<td>(Use "," for more pattern)</td>
			</tr>
			<!-- Include in search -->
			<tr height="40px">
				<td><b>Exclude search:</b></td>
				<td><input type="text" name="txtExclude"><br>
				</td>
				<td>(Use "," for more)</td>
			</tr>

		</table>
		<!-- Fill your keys ends here --></td>
	</tr>
	<tr>
		<td><input type="radio" name="chkSelect" value="remote" onselect="">Load logs from remote server </td>

		<td></td>
	</tr>
	<tr>
		<td><br>
			Ip Address,Username,Password,File Path: <br>
			Eg: 192.168.170.131,uname,pwd,/home/devicemgr.log<br>
			<input type="text" name="txtPath" size="50" >
			<!-- 
			<table id="tblCreds">
				<tr><td>IP</td><td><input type="text" name="txtIp"></td></tr>
				<tr><td>IP</td><td><input type="text" name="txtIp"></td></tr>
				<tr><td>Username</td><td><input type="text" name="txtUname"></td></tr>
				<tr><td>Password</td><td><input type="text" name="txtPwd"></td></tr>
				<tr><td>File Path</td><td><input type="text" name="txtPath"></td></tr>
			</table>
			-->
		</td>

		<td></td>
	</tr>
	<tr>
		<td><br><br><input type="submit" value="Submit Logs"></td>

		<td></td>
	</tr>
</table>
</form>
</div>
<footer>
<a href="https://www.linkedin.com/in/prince-pereira-8190a9b3/"> &copy;
Prince Pereira</a>
</footer>

</body>

</html>