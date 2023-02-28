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
	<h1>Détail de l’incident</h1>
	<a href="./list">Retourner à la liste des incidents</a>
	<h2>Informations</h2>
	<dl>
		<dt>Titre</dt>
		<dd>${ incident.getTitle() }</dd>
		<dt>Email</dt>
		<dd>${ incident.getEmail() }</dd>
		<dt>Sévérité</dt>
		<dd>${ incident.getSeverity() }</dd>
		<dt>Type</dt>
		<dd>${ incident.getType() }</dd>
		<dt>Progression</dt>
		<dd>${ incident.getProgress() }</dd>
	</dl>
	<h2>Description</h2>
	<p>${ incident.getDescription()}</p>
	<div>
		<form method="post" action="./remove">
			<input type="hidden" name="id"
				value="${ incident.getId() }" />
			<button>Supprimer</button>
		</form>
	</div>
</body>
</html>