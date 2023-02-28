package net.pblouet.ajc.incidents.dao;

import java.util.List;
import java.util.Optional;

public interface GenericDao<K, T> {
	public List<T> findAll();

	public Optional<T> findOne(K key);

	public void add(T item);

	public void remove(K key);
}
