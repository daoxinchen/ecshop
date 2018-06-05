package cn.sm1234.ecshop.utils;
/**
 * 用于hibernate获取数据库连接
 * @author dxchen
 *
 */

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class HibernateUtils {
	
	private static Configuration config = null;
	private static SessionFactory sessionFactory = null;
	
	static {
		//1.读取配置
		config = new Configuration().configure();//读取hibernate.cfg.xml
		//2.创建SessionFactory
		sessionFactory = config.buildSessionFactory();
	}
	
	public static Session getSession() {
		if(sessionFactory!=null) {
			return sessionFactory.openSession();
		} else {
			return null;
		}
	}
	
}
