<%
// DB Open: MS SQL Server
// JDBC Driver 로딩
Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
// DB Open 
conn = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;databasename=myDB;user=jsp;password=1234;"); 
%>   	