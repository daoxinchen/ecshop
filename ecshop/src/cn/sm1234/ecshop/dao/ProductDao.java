package cn.sm1234.ecshop.dao;

import java.util.List;

import cn.sm1234.ecshop.domain.Product;

public interface ProductDao {
	/**
	 * 查询总记录数
	 */
	public Long findByTotalCount();
	
	/**
	 * 查询当前页数列表
	 * @param page 当前页码
	 * @param rows 页面大小
	 * @return
	 */
	public List<Product> findByPage(Integer page,Integer rows);

	public void save(Product p);

	public Product findById(Integer id);

	public void delete(Integer valueOf);
}	
