<%@page import="com.sungil.database.DBConnect"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	StringBuffer sb = new StringBuffer();
	sb.append("select m.m_no m_no, m.m_name m_name, count(*) rank");
	sb.append(" from tbl_member_202005 m, tbl_vote_202005 v");
	sb.append(" where m.m_no=v.m_no and v_confirm = 'Y'");
	sb.append(" group by m.m_no, m.m_name" + " order by rank desc");
	String sql = sb.toString();
	
	Connection conn = DBConnect.getConnection();
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body>
	<jsp:include page="../include/header.jsp"></jsp:include>
	<jsp:include page="../include/nav.jsp"></jsp:include>

	<section id="section">
		<h2>후보자등수</h2>

		<table>
			<thead>
				<tr>
					<th>후보번호</th>
					<th>성명</th>
					<th>총투표건수</th>
				</tr>
			</thead>
			<tbody>
				<%
				while (rs.next()) {
				%>
				<tr>
					<td><%=rs.getString("m_no")%></td>
					<td><%=rs.getString("m_name")%></td>
					<td><%=rs.getString("rank")%></td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</section>

	<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>