<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<form action="testConversionServiceConverter" method="POST">
		<!-- lastname-email-gender-department.id 例如：GG-gg@atguigu.com-0-105 -->
		Employee:<input type="text" name="employee"/>
		<input type="submit" value="Submit"/>
	</form>
	<br><br>
	
	<!-- 
		1.WHY使用form标签呢？
		可以更快速的开发出表单页面，而且可以更方便的进行表单值的回显
		2.注意：
		可以通过modelAttribute 属性指定绑定的模型属性，
		若没有指定该属性，则默认从request域对象中读取 command的表单bean，
		如果该属性值也不存在，则会发生错误。
	 -->
	 <br><br>
	 <form:form action="${pageContext.request.contextPath }/emp" method="POST" modelAttribute="employee">
	 	
	 	<br>
	 	
	 	<c:if test="${employee.id == null }">
		 	<!-- path 属性对应 html 表单标签的name属性值 -->
		 	LastName:<form:input path="lastName"/>
		 	<form:errors path="lastName" ></form:errors>
	 	</c:if>
	 	<c:if test="${employee.id != null }">
	 		<form:hidden path="id"/>
	 		<%-- 对于 _method 不能使用 form:hidden 标签，因为modelAttribute 对应的bean中没有 _method这个属性 --%>
	 		<input type="hidden" name="_method" value="PUT"/>
	 	</c:if>
	 	
	 	<br>
	 	Email:<form:input path="email"/>
	 	<form:errors path="email"></form:errors>
	 	<br>
	 	<%
	 		Map<String, String> genders = new HashMap();
	 		genders.put("1","Male");
	 		genders.put("0","Female");
	 		
	 		request.setAttribute("genders", genders);
	 	%>
	 	Gender:
	 	<br>
	 	<form:radiobuttons path="gender" items="${genders }" delimiter="<br>"/>
	 	<br>
	 	Department: <form:select path="department.id" 
			items="${departments }" itemLabel="departmentName" itemValue="id"></form:select>
	 	<br>
	 	<!-- 
	 		1.数据类型转换
	 		2.数据类型格式化
	 		3.数据校验:
	 			1).如何校验？注解？
	 				①.使用JSR303验证标准
	 				②.加入 hibernate validator 验证框架的 jar 包
	 				③.在 SpringMVC 配置文件中添加<mvc:annotation-driven />
	 				④.需要在 bean 的属性上添加对应的注解
	 				⑤.在目标方法 bean 类型的前面添加 @Valid 注解
	 			2).验证出错转向到哪一个页面？
	 				注意：需校验的 Bean 对象和其绑定结果对象或错误对象时成对出现的，它们之间不允许声明其他的入参
	 			3).错误消息如何显示？如何把错误消息进行国际化？
	 	 -->
	 	Birth:<form:input path="birth"/>
	 	<form:errors path="birth"></form:errors>
	 	<br>
	 	Salary:<form:input path="salary"/>
	 	<br>
	 	<input type="submit" value="Submit"/>
	 	
	 </form:form>
	
</body>
</html>