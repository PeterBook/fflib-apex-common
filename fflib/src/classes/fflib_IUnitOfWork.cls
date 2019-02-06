/**
 * File Name: fflib_IUnitOfWork 
 * Description: 
 * Copyright (c) 2019 Johnson & Johnson
 * @author: architect ir. William G.J. Velzeboer | wvelzebo@its.jnj.com 
 */
public interface fflib_IUnitOfWork
{

	void addWork(Object typeOfWork, fflib_IDoWork work);

	List<fflib_IDoWork> getWork(Object typeOfWork);

	void commitWork();
}