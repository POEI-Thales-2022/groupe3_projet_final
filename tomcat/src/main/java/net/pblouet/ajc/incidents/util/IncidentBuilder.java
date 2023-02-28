package net.pblouet.ajc.incidents.util;

import net.pblouet.ajc.incidents.entity.Incident;
import net.pblouet.ajc.incidents.entity.Severity;
import net.pblouet.ajc.incidents.entity.Type;

public class IncidentBuilder {
	private Long id = null;
	private String title = null;
	private String description = null;
	private String email = null;
	private Severity severity = null;
	private Type type = null;
	private Integer progress = null;

	public IncidentBuilder id(Long id) {
		this.id = id;
		return this;
	}

	public IncidentBuilder title(String title) {
		this.title = title;
		return this;
	}

	public IncidentBuilder description(String description) {
		this.description = description;
		return this;
	}

	public IncidentBuilder email(String email) {
		this.email = email;
		return this;
	}

	public IncidentBuilder severity(Severity severity) {
		this.severity = severity;
		return this;
	}

	public IncidentBuilder type(Type type) {
		this.type = type;
		return this;
	}

	public IncidentBuilder progress(Integer progress) {
		this.progress = progress;
		return this;
	}

	public Incident build() {
		Incident incident = new Incident(title, description, email, severity, type, progress);
		incident.setId(this.id);
		return incident;
	}
}
