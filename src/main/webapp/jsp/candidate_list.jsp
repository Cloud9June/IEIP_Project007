<%@page import="com.sungil.database.DBConnect"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>

<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	StringBuffer sb = new StringBuffer();
	sb.append("select m_no, m_name, p_name,");
	sb.append(" case p_school when '1' then '고졸' when '2' then '학사' when '3' then '석사' when '4' then '박사' end p_school,");
	sb.append(" concat(concat(substr(m_jumin,1,7),'-'),substr(m_jumin,7,13)) m_jumin, m_city,");
	sb.append(" concat(concat(concat(p_tel1,'-'),p_tel2),p_tel3) p_tel" + " from tbl_member_202005 m, tbl_party_202005 p");
	sb.append(" where m.p_code = p.p_code");
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
		<h2>후보조회</h2>

		<table>
			<thead>
				<tr>
					<th>후보번호</th>
					<th>성명</th>
					<th>소속정당</th>
					<th>학력</th>
					<th>주민번호</th>
					<th>지역구</th>
					<th>대표전화</th>
				</tr>
			</thead>
			<tbody>
				<%
				while (rs.next()) {
				%>
				<tr>
					<td><%=rs.getString("m_no")%></td>
					<td><%=rs.getString("m_name")%></td>
					<td><%=rs.getString("p_name")%></td>
					<td><%=rs.getString("p_school")%></td>
					<td><%=rs.getString("m_jumin")%></td>
					<td><%=rs.getString("m_city")%></td>
					<td><%=rs.getString("p_tel")%></td>
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