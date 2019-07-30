<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="java.util.*"%>
<%@page import="com.jcraft.jsch.*"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.InputStreamReader"%>

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
	height: 150vh;
	padding: 20px;
}

footer {
	position: absolute;
	bottom: 0;
	height: 60px;
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

<%!
	String input;
	String enabledKeys[];
	String strictPatterns[];
	HashMap<String, Boolean> disabledKeys;
	String searchPattern;
	List<String> excludePatterns;
	boolean searchPatternSet;
%>

<table border="1">
	<%

	String[] allKeys = new String[] { "Component_name", "Consumer-Name",
		"Instance_id", "bootstrap-server", "file", "func", "level", "msg",
		"time", "topics", "value", "user_msg", "Hdrs", "Producer-Name", "host"};
	
	String selRad = request.getParameter("chkSelect");
	
	if (selRad.equals("window")) {
		input = request.getParameter("txtInput");
	} else {
	
	// =======================  Find the logs from remote server starts here
		//String ipAdd = request.getParameter("txtIp");
		//String uname = request.getParameter("txtUname");
		//String pwd = request.getParameter("txtPwd");
		
		try {
			String path = request.getParameter("txtPath");
			String[] splitPath = path.split(",");
			String ipAdd = splitPath[0].trim();
			String uname = splitPath[1].trim();
			String pwd = splitPath[2].trim();
			String fPath = splitPath[3].trim();
			
            JSch jsch = new JSch();
            Session scpSession = null;
            try {
                scpSession = jsch.getSession(uname, ipAdd, 22);
                scpSession.setConfig("StrictHostKeyChecking", "no");
                scpSession.setPassword(pwd);
                scpSession.connect();

                Channel channel = scpSession.openChannel("sftp");
                channel.connect();
                ChannelSftp sftpChannel = (ChannelSftp) channel;

                InputStream stream = sftpChannel.get(fPath);
                
                try {
                	StringBuffer strBuf = new StringBuffer();
                    BufferedReader br = new BufferedReader(new InputStreamReader(stream));
                    String line;
                    while ((line = br.readLine()) != null) {
                    	strBuf.append("\n"+line);
                    }
                    input = strBuf.toString();
                    //out.println(input);

                } catch (IOException io) {
                    out.println("Exception occurred during reading file from SFTP server due to " + io.getMessage());
                    io.getMessage();

                } catch (Exception e) {
                    out.println("Exception occurred during reading file from SFTP server due to " + e.getMessage());
                    e.getMessage();

                }

                sftpChannel.exit();
                scpSession.disconnect();
            } catch (JSchException e) {
                e.printStackTrace();
            } catch (SftpException e) {
                e.printStackTrace();
            }
        } catch (Exception exc){
        	out.println("<b>Unable to resolve the machine details you provided</b>");
        }
	
	// =======================  Find the logs from remote server ends here
	}
	
	searchPattern = request.getParameter("txtInclude").trim();
	if (searchPattern.length() != 0){
		searchPatternSet = true;
	} else {
		
		searchPatternSet = false;
	}
	String exclude = request.getParameter("txtExclude").trim();
	if (exclude.length() == 0){
		excludePatterns = Arrays.asList(new String[]{});
	} else if (!exclude.contains(",")) {
		excludePatterns = Arrays.asList(new String[]{exclude});
	} else {
		String[] exclArray = exclude.split(",");
		excludePatterns = new ArrayList<String>();
		for (String exc: exclArray) {
			 if (exc.trim().length() > 0) {
				 excludePatterns.add(exc.trim());
             }
		}
	}
	String[] exclPatterns = 
	// Retrieve the checkbox ticks
	enabledKeys = request.getParameterValues("chkKey");
	strictPatterns = request.getParameter("txtPattern").toString().split(",");
	

	String tmp = "";
	disabledKeys = new HashMap<String, Boolean>();
	for (String key: allKeys){
		disabledKeys.put(key, true);
	}
	
	if (enabledKeys == null || enabledKeys.length == 0){
		enabledKeys = new String[] {};
	}
	
	for (String key: enabledKeys){
		disabledKeys.put(key, false);
	}
	
	out.println("<tr>");
	
	for (String key: enabledKeys){
		out.println("<th>"+key+"</th>");
	}
	out.println("<th>User Defined Data</th></tr>");
	
	if (input != null) {
		String[] array = input.split("\n");
		for(String val: array) {
			
			JSONParser parser = new JSONParser();
	        try {
	            JSONObject json = (JSONObject) parser.parse(val);
	            
	            if (searchPatternSet && !val.contains(searchPattern)) {
	            	continue;
	            } else {
	            	searchPatternSet = false;
	            }
	            
	            boolean comeout = false;
	            for (String exc : excludePatterns){
	            	if (val.contains(exc)) {
	            		comeout = true;
	            		break;
	            	}
	            }
	            
	            // Checking strict pattern
	            if (strictPatterns.length > 0){
	            	for (String pat: strictPatterns){
	            		if (!pat.trim().equals("") && !val.contains(pat.trim())){
	            			comeout = true;
		            		break;
	            		}
	            	}
	            	
	            }
	            
	            if (comeout){
	            	continue;
	            }
	            
	            
	            out.println("<tr>");
	            
	            
	            for (String key: enabledKeys) {
	            	if (json.get(key) != null) {
	            		tmp = String.valueOf(json.get(key));
	            	} else {
	            		tmp = "";
	            	}
	            	out.println("<td>" +tmp +"</td>");
	                
	                json.remove(key);
	            }
	            
	            // Removing unwanted data
	            
	            for (String key: disabledKeys.keySet()) {
	            	json.remove(key);
	            }
	            
	            out.println("<td>" +json +"</td>");
	            
				out.println("</tr>");
	        } catch (Exception e){

	        }
		}
	}
%>
</table>
</div>
<!-- 
<footer>
<a href="https://www.linkedin.com/in/prince-pereira-8190a9b3/">
&copy; Prince Pereira</a>
</footer>
 -->
</body>
</html>