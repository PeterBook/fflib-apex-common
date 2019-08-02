/**
 * File Name: fflib_IDependencyInjector 
 * Description: Dependency Injector for fflib
 * @author: architect ir. Wilhelmus G.J. Velzeboer  GitHub.com/wimvelzeboer/
 */
public interface fflib_IDependencyInjector
{

	Object newInstance(Object name);

	void setMock(Object name, Object to);

}