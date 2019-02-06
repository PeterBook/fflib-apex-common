/**
 * File Name: fflib_UnitOfWork 
 * Description: 
 * Copyright (c) 2019 Johnson & Johnson
 * @author: architect ir. William G.J. Velzeboer | wvelzebo@its.jnj.com 
 */
public virtual with sharing class fflib_UnitOfWork implements fflib_IUnitOfWork
{
	protected Map<Object, List<fflib_IDoWork>> work = new Map<Object, List<fflib_IDoWork>>();

	protected List<Object> orderOfWork;

	public void addWork(Object typeOfWork, fflib_IDoWork work)
	{
		if (!this.work.containsKey(typeOfWork))
		{
			this.work.put(typeOfWork, new List<fflib_IDoWork>());
		}
		this.work.get(typeOfWork).add(work);
	}

	public List<fflib_IDoWork> getWork(Object typeOfWork)
	{
		if (this.work.containsKey(typeOfWork))
		{
			return this.work.get(typeOfWork);
		}
		else
		{
			return new List<fflib_IDoWork>();
		}
	}

	public fflib_IUnitOfWork setOrderOfWork(List<Object> orderOfWork)
	{
		this.orderOfWork = orderOfWork;
		return (fflib_IUnitOfWork) this;
	}

	public void commitWork()
	{
		for (Object typeOfWork : getOrderOfWork())
		{
			if (this.work.containsKey(typeOfWork))
			{
				commitWork(typeOfWork);
			}
		}
	}

	public void commitWork(Object typeOfWork)
	{
		for (fflib_IDoWork work : this.work.get(typeOfWork))
		{
			work.doWork();
		}
	}

	protected List<Object> getOrderOfWork()
	{
		if (null == this.orderOfWork)
		{
			return new List<Object>(this.work.keySet());
		}
		else
		{
			return this.orderOfWork;
		}
	}
}