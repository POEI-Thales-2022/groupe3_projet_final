package net.pblouet.ajc.incidents.dao;

public class DaoFactory {
	private static DaoFactory singleton = null;
	private IncidentDao incident = new IncidentDaoMock();

	private DaoFactory() {
	}

	public static DaoFactory get() {
		if (singleton == null)
			singleton = new DaoFactory();
		return singleton;
	}

	public IncidentDao incident() {
		return incident;
	}
}
