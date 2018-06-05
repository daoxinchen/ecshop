package cn.sm1234.ecshop.service.impl;

import java.util.List;

import cn.sm1234.ecshop.dao.ProductDao;
import cn.sm1234.ecshop.dao.impl.ProductDaoImpl;
import cn.sm1234.ecshop.domain.Product;
import cn.sm1234.ecshop.service.ProductService;

public class ProductServiceImpl implements ProductService {

	private ProductDao dao = new ProductDaoImpl();
	@Override
	public Long findByTotalCount() {
		return dao.findByTotalCount();
	}

	@Override
	public List<Product> findByPage(Integer page, Integer rows) {
		return dao.findByPage(page, rows);
	}

	@Override
	public void save(Product p) {
		dao.save(p);
	}

	@Override
	public Product findById(Integer id) {
		
		return dao.findById(id);
		
	}

	@Override
	public void delete(String ids) {
		if(ids!=null && !ids.equals("")) {
			String[] idArray = ids.split(",");
			for(String id : idArray ) {
				dao.delete(Integer.valueOf(id));
			}
			
		}
	}

}
