package cn.sm1234.ecshop.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import cn.sm1234.ecshop.domain.Product;
import cn.sm1234.ecshop.service.ProductService;
import cn.sm1234.ecshop.service.impl.ProductServiceImpl;

public class ProductAction extends ActionSupport implements ModelDriven<Product>{
 
	/**
	 * 
	 */
	private static final long serialVersionUID = -8733719522782932411L;
	//使用属性驱动接收page和rows
	private Integer page;
	private Integer rows;
	
	
	public Integer getPage() {
		return page;
	}
	public void setPage(Integer page) {
		this.page = page;
	}
	public Integer getRows() {
		return rows;
	}


	public void setRows(Integer rows) {
		this.rows = rows;
	}

	private ProductService service = new ProductServiceImpl();

	private Product p = new Product();
	/**
	 * 分页查询产品
	 */
	public String listByPage() {
		//1.接收page和rows
		
		//2.调用业务层，查询数据
		
		//2.1查询总记录数
		Long total = service.findByTotalCount();
		//2.2查询当前页数数据列表
		List<Product> list 	= service.findByPage(page, rows);
		
		//3.把数据转换为json(使用struts-json-plugin)
		//把数据放入值栈的root
		Map<String,Object> result = new HashMap<String,Object>();
		result.put("total", total);
		result.put("rows", list);
		
		ActionContext.getContext().getValueStack().push(result);
		
		return SUCCESS;
		
	}
	@Override
	public Product getModel() {
		return p;
	}
	
	/**
	 * 保存商品
	 */
	public String save() {
		Map<String,Object> result = new HashMap<String,Object>();
		try {
			//1.使用模型驱动接受商品数据
			
			//2.调用业务层，保存数据
			service.save(p);
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			//失败原因
			result.put("msg", e.getMessage());
		}
		ActionContext.getContext().getValueStack().push(result);
		return SUCCESS;
	}
	
	/**
	 * 查询一个商品
	 */
	public String get() {
		Product prod = service.findById(p.getId());
		ActionContext.getContext().getValueStack().push(prod);
		return SUCCESS;
	}
	
	private String ids;
	public void setIds(String ids) {
		this.ids = ids;
	}
	/**
	 * 删除商品
	 */
	public String delete() {
		Map<String,Object> result = new HashMap<String,Object>();
		try {
			service.delete(ids);
			result.put("success",true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			//失败原因
			result.put("msg", e.getMessage());
		}
		ActionContext.getContext().getValueStack().push(result);
		return SUCCESS;
	}
}
