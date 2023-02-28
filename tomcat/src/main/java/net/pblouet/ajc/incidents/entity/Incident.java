package net.pblouet.ajc.incidents.entity;

import java.time.LocalDate;

import net.pblouet.ajc.incidents.util.IncidentBuilder;

public class Incident {
	private Long id;
	private String title;
	private String description;
	private String email;
	private Severity severity;
	private Type type;
	private Integer progress;
	private LocalDate creationDate;
	private LocalDate modificationDate;

	public Incident(String title, String description, String email, Severity severity, Type type, Integer progress) {
		super();
		this.title = title;
		this.description = description;
		this.email = email;
		this.severity = severity;
		this.type = type;
		this.progress = progress;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Severity getSeverity() {
		return severity;
	}

	public void setSeverity(Severity severity) {
		this.severity = severity;
	}

	public Type getType() {
		return type;
	}

	public void setType(Type type) {
		this.type = type;
	}

	public Integer getProgress() {
		return progress;
	}

	public void setProgress(Integer progress) {
		this.progress = progress;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public LocalDate getCreationDate() {
		return creationDate;
	}

	public LocalDate getModificationDate() {
		return modificationDate;
	}

	@Override
	public String toString() {
		return "Incident [id=" + id + ", title=" + title + ", description=" + description + ", email=" + email
				+ ", severity=" + severity + ", type=" + type + ", progress=" + progress + ", creationDate="
				+ creationDate + ", modificationDate=" + modificationDate + "]";
	}

	public static IncidentBuilder builder() {
		return new IncidentBuilder();
	}
}
