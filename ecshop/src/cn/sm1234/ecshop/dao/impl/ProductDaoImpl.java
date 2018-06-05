package cn.sm1234.ecshop.dao.impl;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import cn.sm1234.ecshop.dao.ProductDao;
import cn.sm1234.ecshop.domain.Product;
import cn.sm1234.ecshop.utils.HibernateUtils;

public class ProductDaoImpl implements ProductDao {

	@Override
	public Long findByTotalCount() {
		//获取Session
		Session session = HibernateUtils.getSession();
		try {
			Query query = session.createQuery("select count(1) from Product");
			return (Long) query.uniqueResult();
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		} finally {
			//释放session
			session.close();
		}
	}

	@Override
	public List<Product> findByPage(Integer page, Integer rows) {
		Session session = HibernateUtils.getSession();
		
		try {
			Query query = session.createQuery("from Product");
			
			query.setFirstResult((page-1)*rows);
			query.setMaxResults(rows);
			return query.list();
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
			
		}
		
	}
	public static void main(String[] args) {
		ProductDaoImpl dao = new ProductDaoImpl();
		
		List<Product> list = dao.findByPage(1, 5);
		for(Product l:list) {
			System.out.println(l.getName());
		}
		
	}

	@Override
	public void save(Product p) {
		//获取Session
		Session session = HibernateUtils.getSession();
		try {
			 //打开事物
			session.beginTransaction();
			
			session.saveOrUpdate(p);
			
			session.getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
			throw new RuntimeException(e);
		} finally {
			session.close();
		}
	}

	@Override
	public Product findById(Integer id) {
		//获取Session
		Session session = HibernateUtils.getSession();
		
		try {
			return session.get(Product.class, id);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		} finally {
			session.close();
		}
	}

	@Override
	public void delete(Integer id) {
		Session session = HibernateUtils.getSession();
		try {
			session.beginTransaction();
			Product prod = session.get(Product.class, id);
			session.delete(prod);
			
			session.getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
			throw new RuntimeException(e);
			
		} finally {
			session.close();
		}
	}
}
