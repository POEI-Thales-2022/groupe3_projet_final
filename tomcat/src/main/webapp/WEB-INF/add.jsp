<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./styles.css" />
<meta charset="UTF-8">
<title>Liste des incidents</title>
</head>
<body>
	<h1>Création d’incident</h1>
	<a href="./list">Annuler et retourner à la liste des incidents</a>
	<form method="post">
		<dl>
			<dt>Titre</dt>
			<dd>
				<input type="text" name="title" />
			</dd>
			<dt>Email</dt>
			<dd>
				<input type="text" name="email" />
			</dd>
			<dt>Sévérité</dt>
			<dd>
				<select name="severity">
					<c:forEach items="${severities}" var="severity">
						<option value="${ severity }">${ severity }</option>
					</c:forEach>
				</select>
			</dd>
			<dt>Type</dt>
			<dd>
				<select name="type">
					<c:forEach items="${types}" var="type">
						<option value="${ type }">${ type }</option>
					</c:forEach>
				</select>
			</dd>
			<dt>Progression</dt>
			<dd>
				<input type="number" name="progress" />
			</dd>
		</dl>
		<h3>Description</h3>
		<textarea name="description"></textarea>
		<div>
			<button>Créer</button>
		</div>
	</form>
</body>
</html>