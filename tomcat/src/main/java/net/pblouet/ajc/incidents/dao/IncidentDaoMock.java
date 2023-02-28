package net.pblouet.ajc.incidents.dao;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.atomic.AtomicLong;
import java.util.stream.Collectors;

import net.pblouet.ajc.incidents.entity.Incident;
import net.pblouet.ajc.incidents.entity.Severity;
import net.pblouet.ajc.incidents.entity.Type;

public class IncidentDaoMock implements IncidentDao {
	private AtomicLong idGenerator = new AtomicLong();
	private List<Incident> mocked = new ArrayList<>(List.of(
			Incident.builder().id(idGenerator.incrementAndGet()).title("Barre de titre")
					.description("Il faut rajouter une barre de titre à l’application").email("designer@pblouet.net")
					.severity(Severity.MEDIUM).type(Type.FEATURE).progress(20).build(),
			Incident.builder().id(idGenerator.incrementAndGet()).title("ACE photo chien").description(
					"Envoyer une photo de petit chien dans le champ `picture` permet une exécution de code arbitraire dans le champ `dreams`")
					.email("security@pblouet.net").severity(Severity.CRITICAL).type(Type.BUG).progress(0).build(),
			Incident.builder().id(idGenerator.incrementAndGet()).title("Dumps debug dans la console").description(
					"Il y a du JSON dans la console en production ; il faudrait nettoyer les instructions de debug")
					.email("dev@pblouet.net").severity(Severity.MINOR).type(Type.BUG).progress(80).build()));

	@Override
	public List<Incident> findAll() {
		return Collections.unmodifiableList(mocked);
	}

	@Override
	public Optional<Incident> findOne(Long key) {
		return mocked.stream().filter(incident -> incident.getId() == key).findFirst();
	}

	@Override
	public void add(Incident item) {
		item.setId(idGenerator.incrementAndGet());
		mocked.add(item);
	}

	@Override
	public void remove(Long key) {
		mocked = mocked.stream().filter(incident -> incident.getId() != key).collect(Collectors.toList());
	}

}
