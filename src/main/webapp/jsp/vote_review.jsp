<%@page import="com.sungil.database.DBConnect"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	StringBuffer sb = new StringBuffer();
	sb.append("select v_name, '19'||substr(v_jumin,1,2)||'년'||substr(v_jumin,3,2)||'월'||substr(v_jumin,5,2)||'일생' v_jumin,");
	sb.append(" '만 '||to_char(to_number(to_char(sysdate,'yyyy'))-to_number('19'||substr(v_jumin,1,2)))||'세' v_age,");
	sb.append(" case substr(v_jumin,7,1) when '1' then '남' else '여' end v_gender, m_no, substr(lpad(v_time,4,'0'),1,2)||':'||substr(lpad(v_time,4,'0'),3,2) v_time,");
	sb.append(" case v_confirm when 'Y' then '확인' else '미확인' end v_confirm" + " from tbl_vote_202005 where v_area='제1투표장'");
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
		<h2>투표검수조회</h2>

		<table>
			<thead>
				<tr>
					<th>성명</th>
					<th>생년월일</th>
					<th>나이</th>
					<th>성별</th>
					<th>후보번호</th>
					<th>투표시간</th>
					<th>유권자확인</th>
				</tr>
			</thead>
			<tbody>
				<%
				while (rs.next()) {
				%>
				<tr>
					<td><%=rs.getString("v_name")%></a></td>
					<td><%=rs.getString("v_jumin")%></td>
					<td><%=rs.getString("v_age")%></td>
					<td><%=rs.getString("v_gender")%></td>
					<td><%=rs.getString("m_no")%></td>
					<td><%=rs.getString("v_time")%></td>
					<td><%=rs.getString("v_confirm")%></td>
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