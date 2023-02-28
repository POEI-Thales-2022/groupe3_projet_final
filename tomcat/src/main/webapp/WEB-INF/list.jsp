<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="/WEB-INF/functions.tld"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./styles.css" />
<meta charset="UTF-8">
<title>Liste des incidents</title>
</head>
<body>
	<h1>Incidents</h1>
	<a href="./add">Ajouter un incident</a>
	<div class="table">
		<div class="thead">
			<div class="thead">Titre</div>
			<div class="thead">Email</div>
			<div class="thead">Sévérité</div>
			<div class="thead">Type</div>
			<div class="thead">Progression</div>
			<div></div>
		</div>
		<c:forEach items="${incidents}" var="incident">
			<div class="${ f:cssSeverity(incident) }">
				<div>
					<a href="./details?id=${incident.getId()}"> ${ incident.getTitle() }
					</a>
				</div>
				<div>${ incident.getEmail() }</div>
				<div>${ incident.getSeverity() }</div>
				<div>${ incident.getType() }</div>
				<div>${ incident.getProgress() }</div>
				<div>
					<form method="post" action="./remove">
						<input type="hidden" name="id" value="${ incident.getId() }" />
						<button>Supprimer</button>
					</form>
				</div>
			</div>
		</c:forEach>
	</div>
</body>
</html>