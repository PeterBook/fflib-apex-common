/**
 * File Name: fflib_DependencyInjector 
 * Description: 
 * Copyright (c) 2019 Johnson & Johnson
 * @author: architect ir. William G.J. Velzeboer | wvelzebo@its.jnj.com 
 */
public class fflib_DependencyInjector implements fflib_IDependencyInjector
{
	private Map<String, Object> bindings = new Map<String, Object>();
	private Map<String, Object> mockBindings = new Map<String, Object>();


	public Object newInstance(Object name)
	{
		// Mock implementation?
		if (hasMock(name))
		{
			return getMock(name);
		}

		// Create an instance of the type implementing the given interface
		System.debug('Name: '+name);
		System.debug('Bindings: '+bindings);
		if (hasBinding(name))
		{
			Object binding = getBinding(name);
			if (binding instanceof Type)
			{
				return ((Type) binding).newInstance();
			}
			else
			{
				return binding;
			}
		}
		else
		{
			throw new DependencyInjectorException(
					String.format(
							// todo - change into Custom Label
							'No implementation registered for service interface {0}',
							new List<String>{ name.toString() }
					)
			);
		}
	}

	private Object getMock(Object name)
	{
		return this.mockBindings.get(name.toString());
	}

	private Boolean hasMock(Object name)
	{
		return this.mockBindings.containsKey(name.toString());
	}

	private Object getBinding(Object name)
	{
		return this.bindings.get(name.toString());
	}

	private Boolean hasBinding(Object name)
	{
		return this.bindings.containsKey(name.toString());
	}


	public void setMock(Object name, Object to)
	{
		this.mockBindings.put(name.toString(), to);
	}


	/**
	 * Constructor for Service Factory
	 *
	 * @param serviceInterfaceTypeByServiceImplType
	 */
	public fflib_DependencyInjector(Map<Type, Type> serviceInterfaceTypeByServiceImplType)
	{
		for (Type key : serviceInterfaceTypeByServiceImplType.keySet())
		{
			registerBinding(
					(Object) key,
					(Object) serviceInterfaceTypeByServiceImplType.get(key)
			);
		}

	}

	/**
	 * Constructor for Selector Factory
	 *
	 * @param serviceInterfaceTypeByServiceImplType
	 */
	public fflib_DependencyInjector(Map<SObjectType, Type> sObjectBySelectorType)
	{

	}

	/**
	 * Constructor for Domain Factory
	 *
	 * @param serviceInterfaceTypeByServiceImplType
	 */
	public fflib_DependencyInjector(
			fflib_Application.SelectorFactory selectorFactory,
			Map<SObjectType, Type> sObjectByDomainConstructorType)
	{

	}

	private void registerBinding(Object name, Object to)
	{
		this.bindings.put(name.toString(), to);
	}

	public class DependencyInjectorException extends Exception { }
}